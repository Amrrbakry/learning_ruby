class Tree

	class Node

		attr_accessor :value, :parent_node, :left_child, :right_child

		def initialize(value, parent_node = nil, left_child = nil, right_child = nil)
			@value = value
			@parent_node = parent_node
			@left_child = left_child
			@right_child = right_child
		end

	end

	attr_reader :root

	def initialize(value)
		@root = Node.new(value)
	end

	def build_tree(array)
		array.each do |element|
			set = nil
			curr_node =  @root

			while !set
				if element > curr_node.value
					if curr_node.right_child.nil?
						curr_node.right_child = Node.new(element, curr_node)
						set = true
					else
						curr_node = curr_node.right_child
					end					
				else
					if curr_node.left_child.nil?
						curr_node.left_child = Node.new(element, curr_node)
						set = true
					else
						curr_node.left_child = curr_node
					end
				end
			end
		end
	end

end

tree = Tree.new(7)
tree.build_tree([17,5,12,20])