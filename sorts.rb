def quick_sort_in_place(arr, start = 0, len = arr.size)
	return arr if len < 2

	pivot_idx = partition(arr, start, len)
	left_len = pivot_idx - start
	right_len = len - (left_len + 1)

	quick_sort(arr, start, left_len)
	quick_sort(arr, pivot_idx + 1, right_len)

	arr
end

def partition(arr, start, len)
	pivot_idx = start
	pivot = arr[start]

	(start + 1...start + len).each do |i|
		value = arr[i]

		if value < pivot
			arr[i] = arr[pivot_idx + 1]
			arr[pivot_idx + 1] = pivot
			arr[pivot_idx] = value

			pivot_idx += 1
		end
	end

	pivot_idx
end

def quick_sort(arr)
	return arr if arr.size < 2

	pivot = arr[rand(arr.size)]

	left = arr.select{ |x| x < pivot }
	middle = arr.select{ |x| x == pivot }
	right = arr.select{ |x| x > pivot }

	quick_sort(left) + middle + quick_sort(right)
end

def bubble_sort(arr)
	sorted = false
	my_len = arr.size - 2

	until sorted
		sorted = true

		my_len.times do |i|
			if arr[i] > arr[i+1]
				sorted = false
				arr[i], arr[i+1] = arr[i+1], arr[i]
			end
		end
	end

	arr
end

def merge_sort(arr)
	return arr if arr.size == 1

	midpoint = arr.size / 2
	s_left = merge_sort(arr[0...midpoint])
	s_right = merge_sort(arr[midpoint..-1])

	merge(s_left, s_right)
end

def merge(left, right)
	merged = []

	until left.empty? || right.empty?
		next_el = (left.first < right.first) ? left.shift : right.shift
		merged << next_el
	end

	merged + left + right
end

def selection_sort(arr)
	sorted = arr
	len = arr.size
	
	len.times do |i|
		search_arr = sorted[i..-1]
		cur = sorted[i]

		cur_min = search_arr.min
		swap_idx = i + search_arr.index(cur_min)

		sorted[i] = cur_min
		sorted[swap_idx] = cur
	end

	sorted
end

def naive_sort(arr)
	my_len = arr.size - 2

	my_len.times do
		(0..my_len).each do |i|			
			arr[i], arr[i+1] = arr[i+1], arr[i] if arr[i] > arr[i+1]
		end
	end

	arr
end


a = []
1000.times { a << rand(2500) }
# print naive_sort(a) == a.sort; puts

