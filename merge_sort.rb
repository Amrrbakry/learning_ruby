def merge_sort(array)
	return array if array.length <= 1
	midpoint = array.length / 2
	merge(merge_sort(array[0..midpoint - 1]), merge_sort(array[midpoint..-1]))
end

def merge(array1, array2)
	result = []

	while !array1.empty? && !array2.empty?
		if array1[0] < array2[0]
			result << array1[0]
			array1.shift
		else
			result << array2[0]
			array2.shift
		end
	end 

	while !array1.empty? 
		result << array1[0]
		array1.shift
	end
	while !array2.empty?
		result << array2[0]
		array2.shift
	end
		result	
end

p merge_sort([5,8,95,14,2,33])