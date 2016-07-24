class Array
  def all_empty?
  	self.all? { |element| element.to_s.empty? }
  end

  def all_same?
    self.all? { |element| element == self[0] }
  end

  def any_empty?
    if self.size == 0
      true
    else
      self.any? { |element| element.to_s.empty? }
    end
  end

  def none_empty?
    !any_empty?
  end
end