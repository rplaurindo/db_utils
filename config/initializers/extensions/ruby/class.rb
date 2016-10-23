class Class
  def extend? constant
    ancestors.include?(constant) if constant != self
  end
end
