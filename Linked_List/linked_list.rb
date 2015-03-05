require_relative 'link'
require_relative 'linkable'

class LinkedList
	include Linkable

	attr_accessor :first, :last
	attr_reader :count

	def initialize
		#these act as sentinel links giving access to front and back
		self.first = Link.new(nil)
		self.last = Link.new(nil)
		@count = 0

		first.insert_right(last)
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
		@count += 1
		link.value		#can either return link itself or its value
	end

	def pop
		raise "nothing to pop" if last.prev == first

		link = last.prev
		link.remove
		@count -= 1
		link.value
	end

	def unshift(value)
		link = Link.new(value)
		first.insert_right(link)
		@count += 1
		link.value
	end

	def shift
		raise "nothing to unshift" if first.next == last

		link = first.next
		link.remove
		@count -= 1
		link.value
	end
end

ll = LinkedList.new
[*1..5].each do |val|
	ll.push(val)
end


cur = ll.first.next
ll.count.times do 
	puts cur.value
	cur = cur.next
end
# puts ll.has_loop?

