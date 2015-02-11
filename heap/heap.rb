require 'awesome_print'
require_relative 'printable'

class MinHeap
	include Printable
	attr_reader :store

	def initialize
		@store = []
	end

	def push(val)
		@store << val
		# heapify_up
	end

	def child_indices(parent_idx)
		[2 * parent_idx + 1, 2 * parent_idx + 2].select{ |idx| idx < @store.size }
	end

	def heapify_down(parent_idx)
		# set up vars
		child_indices = child_indices(parent_idx)
		children = []
		parent = @store[parent_idx]

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

	def pretty_print
		ap to_hash
	end
end

#ad hoc testing
a = [16, 14, 10, 8, 7, 9, 3, 2, 4, 1].reverse!
heap = MinHeap.new

a.each do |el|
	heap.push(el)
end

puts heap
