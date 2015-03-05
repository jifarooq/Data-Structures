module Linkable
	def median
		middle = first.next
		tail = first.next

		while (tail && tail != last)
			middle = middle.next
			tail = tail.next.next
		end

		middle.prev.value
	end

	def has_loop?
		single = first
		double = first

		count.times do
			single = single.next
			double = double.next.next

			puts "single is #{single}"
			puts "double is #{double}"

			return true if single == double
		end

		false
	end
end

