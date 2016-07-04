class LinkedList

	class Node
		attr_accessor :value, :next_node

		def initialize(value = nil, next_node = nil)
			@value = value
			@next_node = next_node
		end

	end

	attr_reader :head, :tail

	def initialize(value)
		@head = Node.new(value, nil)
		@tail = @head
		@@size = 1
	end

	# adds a new node to the end of the list - increments the size of the list
	def append(value)
		@tail.next_node = Node.new(value, nil)
		@tail = @tail.next_node
		@@size += 1
	end

	# adds a new node to the start of the list - increments the size of the list
	def prepend(value)
		@head = Node.new(value, @head)
		@@size += 1
	end

	# return the number of nodes in the list
	def size
		@@size
	end

	# returns the node at the given index
	def at(index)
		return @head if index == 1
		return @tail if index == @@size
		return nil if index > @@size
		node = @head
    pos = 1
    while node.next_node != nil
      pos += 1
      node = node.next_node
      return node if index == pos
    end 
	end

	# deletes the last node in the list
	def pop
		return "Cannot delete the head of the list!" if @@size == 1
		node_before_last = at( (@@size - 1) )
		node_before_last.next_node = nil
		@tail = node_before_last
		@@size -= 1
	end

	# returns true if the list contains the given value
	def contains?(value)
		pos = 1
		node = @head
		while pos != (@@size + 1)
			if node.value == value
				return true
			else
				node = node.next_node
				pos += 1
				next
			end
		end
		false
	end

	# returns the index of the node that has the given value or nil if not found
	def find(value)
		if contains?(value)
			pos = 1
			node = @head
			while pos != (@@size + 1)
				if node.value == value
					return pos
				else
					node = node.next_node
					pos += 1
					next
				end
			end
		else
			nil
		end
	end

	# prints the list objects in a string format
	def to_s
		node = @head
		@@size.times do |i|
			print "( #{node.value} ) -> " 
			node = node.next_node
			if i == ( @@size - 1 )
				puts "nil"
			end
		end
	end

	# inserts value at the given index
	def insert_at(index, value)
	prev_node = at(index - 1)
	current = at(index)
	current = Node.new(value, current)
	prev_node.next_node = current
	@@size += 1
	end

	# removes the node at the given index
	def remove_at(index)
	return nil if index > @@size
		case index
		when 1 then @head = at(2); @@size -= 1
		when @@size then pop
		else
			prev_node = at(index - 1)
			n_node = at(index + 1)
			prev_node.next_node = n_node
			@@size -= 1
		end
	end

end

