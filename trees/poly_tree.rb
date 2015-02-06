class Node
	attr_accessor :parent, :children
	attr_reader :value

	def initialize(value = nil)
		@value = value
		@parent = nil
		@children = []
	end
end

class PolyTree
	attr_reader :root

	def initialize(value = nil)
		@root = Node.new(value)
	end

	def add_node(value, parent = @root)
		child = Node.new(value)
		parent.children << child
		child.parent = parent
		child
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


#left branch
tree.add_node(4, node2)
tree.add_node(5, node2)
tree.add_node(6, node2)

#right branch
tree.add_node(7, node3)
node8 = tree.add_node(8, node3)

tree.add_node(9, node8)
tree.add_node(10, node8)
tree.add_node(11, node8)
tree.add_node(12, node8)

target_node = tree.dfs(2)
# puts target_node.value
# puts target_node.parent.value #8