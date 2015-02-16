require 'awesome_print'
require_relative 'printable'

class MinHeap
	include Printable
	attr_reader :store

	def initialize
		@store = []
	end

	def count
		@store.size
	end

	def extract
		raise "nothing to extract" if count == 0

		value = @store.pop
		heapify_down(0) unless count == 0

		value
	end

	def push(val)
		@store << val
		heapify_up(count - 1)
	end

	def ==(other_heap)
		@store == other_heap.store
	end

	def child_indices(parent_idx)
		[2 * parent_idx + 1, 2 * parent_idx + 2].select{ |idx| idx < count }
	end

	def parent_index(child_idx)
		raise "root has no parent" if child_idx == 0
		(child_idx - 1) / 2
	end

	def heapify_down(parent_idx)
		# set up vars
		child_indices = child_indices(parent_idx)
		children = []
		parent = @store[parent_idx]

		# careful when there is only 1 child
		child_indices.each do |idx|
			child = @store[idx]
			children << child if child < parent
		end

		# recursive exit
		if children.all? { |child| child >= parent }
			return
		end

		# choose smaller of two children
		swap_idx = nil
		if children.size == 1
			swap_idx = child_indices.first
		else
			swap_idx = children[0] < children[1] ? child_indices[0] : child_indices[1]
		end

		# swap and recurse
		@store[parent_idx], @store[swap_idx] = @store[swap_idx], parent
		heapify_down(swap_idx)
	end

	def heapify_up(child_idx)
		return if child_idx == 0

		parent_idx = parent_index(child_idx)
		child, parent = @store[child_idx], @store[parent_idx]

		if child >= parent
			return
		else
			@store[child_idx], @store[parent_idx] = parent, child
			heapify_up(parent_idx)
		end
	end
end

#ad hoc testing
# a = [16, 14, 10, 8, 7, 9, 3, 2, 4, 1].reverse!
heap = MinHeap.new
# a.each { |el| heap.push(el) }

# puts "heap before heapifying"
# puts heap; puts

# puts "heap after heapifying"
# h1 = heap.heapify_down(1)
# h2 = heap.heapify_up(3)
# puts h1 == h2
# # puts heap

# b = %w(5 7 3 9 1).map(&:to_i)
# # puts b
# heap = MinHeap.new
# b.each { |el| heap.push(el) }
# # puts heap

# c = (0..4).map { heap.extract }
# puts c
# puts heap.store

a = ["e", "a", "s", "y", "q", "u", "e", "s", "t", "i", "o", "n"]
a.each{|char| heap.push(char) }
puts heap