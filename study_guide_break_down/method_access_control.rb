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
#puts pickles.play(jinx)
#puts jinx.play(pickles)
#puts ''
#jinx.run_another_cat(pickles) # `#run` is private...(NoMethodError)
#pickles.run # `#run` is private...(NoMethodError)
#pickles.name # `#name` is protected...(NoMethodError)

class Dog
  attr_reader :name

  def initialize
    @name = "Rex"
  end

  def other_dog_cant_run(other)
    # `#run` can't be invoked by any object except `self` at the scope of an
    # instance method. Even if the argument's object is the same as the calling
    # object of the current instance method.
    puts "#{name} #{run}" # an implicit `self` invokes `#run`
    other.run
  end

  def self.No_Private_Running(other)
    # `#run` can't be invoked within the scope of a class method because
    # private instance methods must be invoked at the scope of an instance
    # method.
    other.run
  end

  def make_another_dog
    # Another way to show that private methods must be invoked by `self` at the
    # scope of an instance method.
    Dog.new.run
  end

  private

  def run
    "runs!"
  end
end

rex = Dog.new
rex.other_dog_cant_run(rex) # NoMethodError for `#run`
rex.make_another_dog # NoMethodError for `#run`
Dog.No_Private_Running(rex) # NoMethodError for `#run`