# Method Access Control
class Cat
  def initialize(name)
    @name = name
  end

  private
  # Now `#run` can only be invoked within the scope of an instance method that
  # is invoked by `self`
  def run
    "runs"
  end
  
  protected
  # Now `#name` can be invoked only within the scope of an instance method that
  #  is invoked by `self` or another `Cat` object.
  attr_reader :name
  
  public

  def play(other)
    "#{name} #{run} and plays with #{other.name}."
  end

  def run_another_cat(other)
    # This method is defined to show that `#run` is private and can't be invoked
    # by any object except `self`.
    other.run
  end
end

pickles = Cat.new("Pickles")
jinx = Cat.new("Jinx")

# `#play` is a public method available inside and outside of the class.
puts pickles.play(jinx)
puts jinx.play(pickles)
puts ''
jinx.run_another_cat(pickles) # `#run` is private...(NoMethodError)
pickles.run # `#run` is private...(NoMethodError)
pickles.name # `#name` is protected...(NoMethodError)