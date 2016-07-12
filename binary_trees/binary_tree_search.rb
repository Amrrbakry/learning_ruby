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
		array.each do | value |
			set = nil
			curr_node = @root
			while not set
				if value > curr_node.value
					if curr_node.right_child.nil?
						curr_node.right_child = Node.new(value, parent_node = curr_node)
						set = true
					else
						curr_node = curr_node.right_child
					end
				else
					if curr_node.left_child.nil? 
						curr_node.left_child = Node.new(value, parent_node = curr_node)
						set = true
					else
						curr_node = curr_node.left_child
					end
				end
			end
		end
	end


	def breadth_first_search(target)
		queue = [@root]
		visited = [@root]
		return @root if target == @root.value

		while queue.size > 0
			curr_node = queue.shift

			if curr_node.left_child && !visited.include?(curr_node.left_child)
				return curr_node.left_child if target == curr_node.left_child.value
				visited << curr_node.left_child
				queue << curr_node.left_child
			end

			if curr_node.right_child && !visited.include?(curr_node.right_child)
				return curr_node.right_child if target == curr_node.right_child.value
				visited << curr_node.right_child
				queue << curr_node.right_child
			end
		end
		nil
	end

	def depth_first_search(target)
		stack = [@root]
		visited = [@root]
		return @root if target == @root.value

		while stack.size > 0
			curr_node = stack[-1]

			if curr_node.left_child && !visited.include?(curr_node.left_child)
				return curr_node.left_child if target == curr_node.left_child.value
				visited << curr_node.left_child
				stack << curr_node.left_child
			elsif curr_node.right_child && !visited.include?(curr_node.right_child)
				return curr_node.right_child if target == curr_node.right_child.value
				visited << curr_node.right_child
				stack << curr_node.right_child
			else 
				stack.pop
			end
		end
		nil
	end

	def dfs_rec(target, curr_node = @root)
		return curr_node if target == curr_node.value
		a =  dfs_rec(target, curr_node.left_child) if curr_node.left_child
		return a if a
		b = dfs_rec(target, curr_node.right_child) if curr_node.right_child
		return b if b
		nil
	end

end

tree = Tree.new(7)
tree.build_tree([1, 7, 4, 23])
puts tree.breadth_first_search(23)
puts tree.depth_first_search(23)
puts tree.dfs_rec(23)