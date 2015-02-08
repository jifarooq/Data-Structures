class MinHeap
	def initialize
		@store = []
	end

	def push(val)
		@store << val
		# heapify_up
	end

	def heapify_down(parent_idx)
		# set up vars
		child_indices = [2 * parent_idx + 1, 2 * parent_idx + 2]
		children = []
		parent = @store[parent_idx]
		swap_idx = nil

		# careful when there is only 1 child
		child_indices.each do |idx|
			child = @store[idx]
			children << child if child >= parent
		end

		# recursive exit
		if children.all? { |child| child >= parent }
			return
		end

		# choose smaller of two children
		if children.size == 1
			swap_idx = child_indices.first
		else
			swap_idx = children[0] < children[1] ? child_indices[0] : child_indices[1]
		end

		# swap and recurse
		@store[parent_idx], @store[swap_idx] = @store[swap_idx], parent
		heapify_down(swap_idx)
	end

end

#ad hoc testing
a = []

