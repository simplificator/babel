class Fixnum
  def at_most(limit)
    self > limit ? limit : self
  end
end