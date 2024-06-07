# Method Access Control
class Cat
  def initialize(name)
    @name = name
  end

  private

  def run
    "runs"
  end
  # Now `#run` can only be invoked within the scope of an instance method that is invoked by `self`
  protected
  
  attr_reader :name
  # Now `#name` can be invoked only within the scope of an instance method that is invoked by `self`
  # or another `Cat` object.
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

puts pickles.play(jinx) # `#play` is a public method available inside and outside of the class.
puts jinx.play(pickles)
puts ''
jinx.run_another_cat(pickles) # `#run` is private...(NoMethodError)
pickles.run # `#run` is private...(NoMethodError)
pickles.name # `#name` is protected...(NoMethodError)