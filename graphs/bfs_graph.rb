require_relative 'topological_sort'

def graph_bfs(start)
	found_edges = {
		start => nil
	}

	queue = [start]

	until queue.empty?
		node = queue.shift

		node.out_edges.each do |oe|
			to_node = oe.to_node

			next if found_edges.has_key?(to_node)

			found_edges[to_node] = oe
			queue << to_node
		end
	end

	found_edges
end

def my_print(edges)
	edges.each do |node, edge|
		print node.to_s, ' ', edge.to_s
		puts
	end
end


# TESTING
vertices = []
vertices << (v1 = Node.new("A"))
vertices << (v2 = Node.new("B"))
vertices << (v3 = Node.new("C"))
vertices << (v4 = Node.new("D"))
vertices << (v5 = Node.new("E"))

e1 = Edge.new(v1, v2)
e2 = Edge.new(v2, v3)
e3 = Edge.new(v2, v4)
e4 = Edge.new(v4, v5)
# e5 = Edge.new(v2, v1)

results = graph_bfs(v1)
my_print(results)