# use it for caching results of new year problem
require_relative '../puzzles/tokenize_year.rb'

class LRUCache
	attr_reader :hits, :misses

	def initialize(max, &proc)
		@store = {}
		@max_size = max
		@proc = proc

		@hits, @misses = 0, 0
	end

	def calculate(input)
		# check if input already cached
		if @store[input]
			@hits += 1
			@store[input][1] = Time.now
			return @store[input][0]
		end

		# if not in cache, call proc on input and add it to cache
		# eject from the cache if needed
		# return output
		@misses += 1
		@store[input] = [@proc.call(input), Time.now]
		eject! if @store.size > @max_size

		@store[input].first
	end


	def eject!
		key, val = @store.min_by{ |k, (v, time)| time }
		@store.delete(key)
	end
end

cache = LRUCache.new(100) do |(num, target)|
	solve_year(num, target)
end

num = 123456789
target = 2002

puts "calculating"
puts cache.calculate([num, target])
puts "cache misses count is #{cache.misses}"
puts "cache hits count is #{cache.hits}"; puts

sleep 1
puts cache.calculate([num, target])
puts "cache misses count is still #{cache.misses}"
puts "cache hits count is #{cache.hits}"