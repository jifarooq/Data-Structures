class Link
	attr_accessor :value, :prev, :next

	def initialize(value)
		# self.value = value
		@value = value
	end

	def insert_left(link)
		#raise hell if link doesn't exist or something

		link.next = self
		link.prev = self.prev
		self.prev.next = link if self.prev
		self.prev = link
	end

	def insert_right(link)
		link.prev = self
		link.next = self.next
		self.next.prev = link if self.next
		self.next = link
	end

	def remove #remove self from chain
		self.prev.next = self.next
		self.next.prev = self.prev
		self.prev, self.next = nil, nil
	end
end