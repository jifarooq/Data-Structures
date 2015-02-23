class Node
	attr_reader :value, :in_edges, :out_edges

	def initialize(value)
		@value = value
		@in_edges = []
		@out_edges = []
	end

	def to_s
		value
	end
end

# don't forget the cost!
class Edge
	attr_accessor :from_node, :to_node, :cost

	def initialize(from_node, to_node, cost = 1)
		@from_node = from_node
		@to_node = to_node
		@cost = cost

		to_node.in_edges << self
		from_node.out_edges << self
	end

	def destroy
		to_node.out_edges.delete(self)
		from_node.in_edges.delete(self)
		to_node = nil
		from_node = nil
	end

	def to_s
		[from_node, to_node].map()
	end
end

