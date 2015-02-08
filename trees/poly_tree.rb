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
			|result, child| result.merge(child.to_hash) }
		}
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

	def pretty_print
		ap @root.to_hash
	end

	# can pass in a node or a value
	def insert(object, parent = @root)
		child = object.is_a?(Node) ? object : Node.new(object)
		parent.children << child
		child.parent = parent

		child
	end

	def remove(node)
		raise "can't uproot right now" if node == @root
		node.children.empty? ? detach(node) : remove_non_leaf(node)
	end

	def detach(node)
		parent = node.parent
		parent.children.delete(node)
		node.parent = nil

		node
	end

	def remove_non_leaf(node)
		parent, children = node.parent, node.children
		
		detach(node)
		node.children = []
		children.each { |child| child.parent = nil }

		# REATTACH (using first child as replacement)
		replacement, other_children = children.first, children[1..-1]
		insert(replacement, parent)
		other_children.each { |child| insert(child, replacement) }

		node
	end

	def print_values_breadth
		nodes = [@root]

		until nodes.empty?
			node = nodes.shift
			puts node.value
			nodes.concat(node.children)
		end
	end

	def print_values_depth(node = @root)
		puts node.value

		node.children.each do |child|
			return if child.nil?
			print_values_depth(child)
		end
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
node2 = tree.insert(2)
node3 = tree.insert(3)

# LEFT BRANCH
node4 = tree.insert(4, node2)
2.times { |i| tree.insert(i + 5, node2) }

# RIGHT BRANCH
tree.insert(7, node3)
node8 = tree.insert(8, node3)

nodes = []
4.times { |i| nodes << tree.insert(i + 9, node8) }

tree.pretty_print
tree.print_values_depth
# tree.remove(node3)
# tree.pretty_print

# =>
# {
#     1 => {
#         2 => {
#             4 => {},
#             5 => {},
#             6 => {}
#         },
#         3 => {
#             7 => {},
#             8 => {
#                  9 => {},
#                 10 => {},
#                 11 => {},
#                 12 => {}
#             }
#         }
#     }
# }
