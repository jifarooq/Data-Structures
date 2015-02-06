class Node
	attr_accessor :parent, :children
	attr_reader :value

	def initialize(value = nil)
		@value = value
		@parent = nil
		@children = []
	end

	def count
		1 + children.map(&:count).reduce(0, :+)
	end
end

class PolyTree
	attr_reader :root

	def initialize(value = nil)
		@root = Node.new(value)
	end

	def count
		@root.count
	end

	def add_node(value, parent = @root)
		child = Node.new(value)
		parent.children << child
		child.parent = parent
		child
	end

	def remove(node)
		# puts "node value is #{node.value}"
		if node.children.empty?		
			remove_leaf(node)
		else
			# arbitrarily swap values with first child
			# then call itself on the child
			node.value, children[0].value = children[0].value, node.value
			remove_node(children[0])
		end
	end

	def remove_leaf(node)
		parent = node.parent
		parent.children.delete(node)
		node.parent = nil

		node
	end

	def bfs(target)
		nodes = [@root]

		until nodes.empty?
			node = nodes.shift
			return node if node.value == target

			#children is an array, so need to concat
			nodes.concat(node.children) 
		end

		nil
	end

	def dfs(target, node = @root)
		return node if node.value == target

		node.children.each do |child|
			result = dfs(target, child)
			#must return within loop
			return result if result.value == target
		end

		nil
	end
end

# adhoc testing
tree = PolyTree.new(1)
node2 = tree.add_node(2)
node3 = tree.add_node(3)

#left branch
node4 = tree.add_node(4, node2)
tree.add_node(5, node2)
tree.add_node(6, node2)

puts tree.count
tree.remove(node4)
puts tree.count

#right branch
# tree.add_node(7, node3)
# node8 = tree.add_node(8, node3)

# tree.add_node(9, node8)
# tree.add_node(10, node8)
# tree.add_node(11, node8)
# tree.add_node(12, node8)

# target_node = tree.bfs(4)
# puts "tree before is"; p tree; puts
# tree.remove_node(node2)
# puts "tree after is #{tree}"

