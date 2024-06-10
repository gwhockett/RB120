# Self

# outputs "main"
p self

module Readable
  # outputs the module name
  p self
  
  def read
  # `self` will output the calling object of this method
    "The calling object for this invocation of `#read` is #{self}"
  end

  # module method definition
  def self.readable
    "Module method: `::readable`"
  end
end

class Person
  # outputs the class name
  p self

  include Readable
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def know
    # `self` will output the calling object of this method
    "The calling object for this invocation of `#know` is #{self}"
  end
  
  # class method definition
  def self.persons
    "Class method: `::persons`"
  end

  def no_setter(new_name, new_age)
     # getter call
    puts name
    puts age
    # local variable creation, not a setter call
    name = new_name
    age = new_age
    # local variable output
    puts name
    puts age
    # now the getters, `#name` and `#age`, are shadowed
    # at the scope of this method unless preprended with
    # an explicit `self` and we can see that `@name` and
    # `@age` have not been reassigned
    puts self.name
    puts self.age
  end

  def new_name_and_age(new_name, new_age)
    # an explicit `self` needs to be prepended for a
    # setter call at the scope of an instance method
    self.name = new_name
    self.age = new_age
    # we see that `@name` and `@age` are reassigned
    puts name
    puts age
  end
end

puts ''
puts Readable.readable
puts Person.persons
puts ''
reader1 = Person.new("Bob", 35)
puts reader1.read
puts reader1.know
puts ''
reader1.no_setter("Rick", 23)
puts ''
reader1.new_name_and_age("Jessica", 28)