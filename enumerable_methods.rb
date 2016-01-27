module Enumerable
	def my_each 
		i = 0 
		while i < self.size 
			yield(self[i]) if block_given?
			i += 1
		end
		self
	end

	def my_each_with_index
		i = 0 
		while i < self.size 
			yield(self[i], i) if block_given?
			i += 1
		end
		return i
	end

	def my_select 
		result = []
		i = 0
		while i < self.size
			if yield(self[i])
				result << self[i]
			end
			i += 1
		end
		result
	end

=begin
	
	**my_select method using my_each**
		
	def my_select
		result = []
		my_each {|i| result << i if yield(i)}
		result
	end

=end

	def my_all?
		my_each do |element|
			if yield(element) != true
				return false
			end
		end
		return true
	end

	def my_any?
		my_each do |element| 
			if yield(element) == true
				return true
			end
		end
		return false
	end

	def my_none?
		my_any? do |element|
			if yield(element) == true
				return false
			else
				return true
			end
		end
	end

	def my_count(element = nil)
		c = 0
		if block_given?
			r  = my_select {|x| yield(x)}
			c = r.length
		elsif element
			r = my_select {|x| x == element}
			c = r.length
		else
			return self.length
		end
	end

=begin 
	
	**my_map that takes a block**

	def my_map 
		result = []
		if block_given?
			my_each do |x|
				result << yield(x)
		end
		else
			return self
		end
		result
	end

	**my_map that takes a proc** 

	def my_map &proc
		result = []
			my_each do |x|
				result << proc.call(x)
		end
		else
			return self
		end
		result
	end
=end 
	
	def my_map &proc
		result = []
		my_each do |x|
			if block_given?
				result << yield(proc.call(x))
			else
				proc.call(x)
			end
		end
		result
	end

	def my_inject(initial = nil)
		initial = self[0] if initial.nil?
		memo = initial
		my_each do |x|
			memo = yield(memo, x) 
		end
		memo
	end

end

def multiply_els array
		array.my_inject(1) {|product, n| product * n }
end

