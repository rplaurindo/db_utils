class Class
  def extends? constant
    ancestors.include?(constant) if constant != self
  end
end
