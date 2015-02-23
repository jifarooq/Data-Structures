require_relative 'graph'

def topological_sort(nodes)
	in_edge_counts = {}
	queue = []
	sorted_nodes = []

	# queue begins with all 'central' nodes
	nodes.each do |node|
		in_edge_counts[node.value] = node.in_edges.size
		queue << node if node.in_edges.empty?
	end

	until queue.empty?
		node = queue.shift
		sorted_nodes << node

		# to_node is destination point
		node.out_edges.each do |edge|
			to_node = edge.to_node

			in_edge_counts[to_node.value] -= 1
			queue << to_node if in_edge_counts[to_node.value] == 0
		end
	end

	sorted_nodes
end

#TESTING
nodes = []
nodes << (v1 = Node.new("Wash Buckley"))
nodes << (v2 = Node.new("Feed Buckley"))
nodes << (v3 = Node.new("Dry Buckley"))
nodes << (v4 = Node.new("Brush Buckley"))
Edge.new(v1, v2)
Edge.new(v1, v3)
Edge.new(v2, v4)
Edge.new(v3, v4)

vals = nodes.map{ |v| v.to_s }

sorted_nodes = topological_sort(nodes.shuffle)
sorted_vals = sorted_nodes.map{ |v| v.to_s }

puts "sorted nodes are #{sorted_vals}"
