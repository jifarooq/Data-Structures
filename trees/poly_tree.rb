require 'awesome_print'

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

	def to_hash
		{ @value => children.reduce( {} ) { 
			|result, child| result.merge(child.to_hash)
		} }
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

	def draw
		tree_hash = @root.to_hash
		ap tree_hash
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
			remove_non_leaf(node)
		end
	end

	def remove_non_leaf(node)
		parent = node.parent
		children = node.children

		node.parent = nil
		children.each do |child|
			child.parent = nil
		end

		#need to reassign parent too!
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

# ADHOC TESTING
tree = PolyTree.new(1)
node2 = tree.add_node(2)
node3 = tree.add_node(3)

# LEFT BRANCH
node4 = tree.add_node(4, node2)
2.times { |i| tree.add_node(i + 5, node2) }

tree.draw
tree.remove(node4)
tree.draw

# RIGHT BRANCH
# tree.add_node(7, node3)
# node8 = tree.add_node(8, node3)

# 4.times { |i| tree.add_node(i + 9, node8) }
