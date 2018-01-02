module LList
  class Node
    attr_accessor :value, :next_node

    def initialize(value = nil, next_node = nil)
      @value = value
      @next_node = next_node
    end
  end

  class LinkedList
    attr_reader :head, :tail, :size

    def initialize(value)
      @head = Node.new(value, nil)
      @tail = @head
      @size = 1
    end

    def append(value)
      @tail.next_node = Node.new(value, nil)
      @tail = @tail.next_node
      @size += 1
    end

    def prepend(value)
      @head = Node.new(value, @head)
      @size += 1
    end

    def at(index)
      return @head if index == 1

      return @tail if index == @size

      return nil if index > @size || index.zero?

      current_node = @head
      1.upto(@size) do |i|
        return current_node if i == index

        current_node = current_node.next_node
        next
      end
    end

    def pop
      return 'Cannot delete the head of the list' if @size == 1

      node_before_last = at((@size - 1))
      node_before_last.next_node = nil
      @tail = node_before_last
      @size -= 1
    end

    def contains?(value)
      current_node = @head
      1.upto(@size) do
        return true if value == current_node.value

        current_node = current_node.next_node
        next
      end
      false
    end

    def find(data)
      current_node = @head
      1.upto(@size) do |i|
        return i if current_node.value == data

        current_node = current_node.next_node
        next
      end
      nil
    end

    def to_s
      current_node = @head
      1.upto((@size + 1)) do |i|
        return puts 'nil' if i > @size || current_node.nil?

        print "( #{current_node.value} ) -> "
        current_node = current_node.next_node
      end
    end

    def insert_at(index, value)
      node_before_index = at((index - 1))
      node_at_index = at(index)
      new_node = Node.new(value, node_at_index)
      @head = new_node if index == 1
      @tail = new_node if index == @size + 1
      node_before_index.next_node = new_node if node_before_index
      @size += 1
    end

    def remove_at(index)
      return nil if index > @size

      if index == @size
        pop
        @size -= 1
        return
      end

      if index == 1
        @head = at(2)
        @size -= 1
        return
      end

      node_before_index = at((index - 1))
      node_after_index = at((index + 1))
      node_at_index = at(index)
      node_at_index.value = nil
      node_at_index.next_node = nil
      node_before_index.next_node = node_after_index if node_after_index
      @size -= 1
    end
  end
end

linked_list = LList::LinkedList.new('first')
linked_list.append('second')
linked_list.append('third')
linked_list.append('fourth')
linked_list.to_s
puts linked_list.at(4).value # fourth
p linked_list.at(7) # nil
linked_list.pop
linked_list.to_s
puts linked_list.contains?('seventh') # false
puts linked_list.contains?('second') # true
linked_list.insert_at(1, 'inserted_first')
linked_list.to_s
linked_list.remove_at(3)
linked_list.to_s
linked_list.prepend('prepended_first')
linked_list.to_s
linked_list.insert_at(5, 'inserted_last')
linked_list.to_s
