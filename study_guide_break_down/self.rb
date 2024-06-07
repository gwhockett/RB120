# Self

p self # outputs "main"

module Readable
  p self # outputs the module name
  
  def read
  # `self` will output the calling object of this method
    "The calling object for this invocation of `#read` is #{self}"
  end

  def self.readable # module method definition
    "Module method: `::readable`"
  end
end

class Person
  p self # outputs the class name

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
  
  def self.persons # class method definition
    "Class method: `::persons`"
  end

  def no_setter(new_name, new_age)
    puts name # getter call
    puts age # getter call
    name = new_name # local variable creation, not a setter call
    age = new_age # local variable creation, not a setter call
    puts name # local variable output
    puts age # local variable output
    # now the getters, `#name` and `#age`, are shadowed
    # at the scope of this method unless preprended with
    # an explicit `self` and we can see that `@name` and
    # `@age` have not been reassigned
    puts self.name # getter call
    puts self.age # getter call
  end

  def new_name_and_age(new_name, new_age)
    # an explicit `self` needs to be prepended for a
    # setter call at the scope of an instance method
    self.name = new_name # setter call
    self.age = new_age # setter call
    # we see that `@name` and `@age` are reassigned
    puts name # getter call
    puts age # getter call
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