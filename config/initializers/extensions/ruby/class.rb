class Class
  def extend? constant
    ancestors.include?(constant)
  end
end
