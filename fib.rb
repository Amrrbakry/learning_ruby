def fib n
	seq = []
	0.upto(n) do |num|
		case num
		when 0
			seq << 0
		when 1  
			seq << 1
		else 
			seq << seq[(num - 1)] + seq[(num - 2)] 
		end
	end
	print seq
end

def fib_rec n
	return n <= 1 ? n : fib_rec(n - 1) + fib_rec(n - 2) 
end

puts "Iterative:"
fib(20)
puts "\nRecursive"
0.upto(20) { |i| print "#{fib_rec(i)}, " }
