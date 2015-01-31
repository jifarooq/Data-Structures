require_relative 'link'

class LinkedList
	attr_accessor :first, :last

	def initialize
		#these act as sentinel links giving access to front and back
		self.first = Link.new(nil)
		self.last = Link.new(nil)

		self.first.insert_right(self.last)
	end

	def [](idx)
		raise "index out of range" if idx < 0
		link = first

		(idx + 1).times do 
			link = link.next
			raise "index out of range" if link == last
		end

		link
	end

	def push(value)
		link = Link.new(value)
		last.insert_left(link)
		link.value		#can either return link itself or its value
	end

	def pop
		raise "nothing to pop" if last.prev == first

		link = last.prev
		link.remove
		link.value
	end

	def unshift(value)
		link = Link.new(value)
		first.insert_right(link)
		link.value
	end

	def shift
		raise "nothing to unshift" if first.next == last

		link = first.next
		link.remove
		link.value
	end
end