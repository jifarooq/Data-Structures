require 'ruby-graphviz'

# Create a new graph
g = GraphViz.new( :G, :type => :digraph )

# Create nodes
vals = %w(A B C D E)
nodes = []

vals.each do |val|
	nodes << g.add_nodes(val)
end

a, b, c, d, e = nodes

# Create edges
(0...nodes.size).each do |i|
	(i + 1...nodes.size).each do |j|
		x, y = nodes[i], nodes[j]
		g.add_edges( x, y )
		g.add_edges( y, x )
	end
end
# g.add_edges( a, b )
# g.add_edges( b, a )
# g.add_edges( b, c )
# g.add_edges( b, d )
# g.add_edges( d, e )

# Generate output image
g.output( :png => "my_crazy_dense_graph.png" )