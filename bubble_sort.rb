def bubble_sort array
	n = array.length - 1 

	n.times do
		i = 0
		while i != n do
			if array[i] > array[i + 1]
				array[i], array[i + 1] = array[i + 1], array[i]
			end
			i += 1
		end
	end
	p array
end

def bubble_sort_by array
	n = array.length - 1 

	n.times do
		i = 0
		while i != n do
			if yield(array[i], array[i + 1]) > 0
				array[i], array[i + 1] = array[i + 1], array[i]
			end
			i += 1
		end
	end
	p array
end



