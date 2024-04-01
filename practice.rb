# 1. What will the following code output? Why?
# When the `Student` object at line 18. invokes the writer `Student#id=` A system stack error would occur.
# `self.id = value` at line 12 is a recursive call of the method `id=(value)` defined from lines 12 to 14.
# class Student
#   attr_reader :id
# 
#   def initialize(name)
#     @name = name
#     @id
#   end
# 
#   def id=(value)
#     self.id = value
#   end
# end
# 
# tom = Student.new("Tom")
# tom.id = 45
# 2. Define a class of your choice with the following:

# Constructor method that initializes 2 instance variables.
# Instance method that outputs an interpolated string of those variables.
# Getter methods for both (you can use the shorthand notation if you want).
# Prevent instances from accessing these methods outside of the class.
# Finally, explain what concept(s) you’ve just demonstrated with your code.

# class Dog
#   def initialize(name, age)
#     @name = name
#     @age = age
#   end
# 
#   def particulars
#     "#{name}, #{age}"
#   end
# 
#   private
# 
#   attr_reader :name, :age
# end

#encapsulation.
#The above code demonstrates two types of encapsulation OOP. The first is data encapsulation. When a `Dog` object
#is initialized from the class `Dog`, data is stored in the `Dog` object and referenced by the instance variables
#`@name` and `@age` that belong to that instance and no other instance. The second form of encapsulation is
#behavioral encapsulation through the method access control modifier `private` invoked at line 33. The methods
#that follow `private` in the class `Dog` can only be invoked by `self` within the scope of another `Dog` class
#instance method also invoked by the same `self`. These two types of encapsulation prevent unwanted behavior
#and data access.

# 3. What concept does the following code aim to demonstrate?

# module Greet
#   def greet(message)
#     puts message
#   end
# end
# 
# class Teacher
#   include Greet
# end
# 
# class Student
#   include Greet
# end
# 
# tom = Teacher.new
# rob = Student.new
# 
# tom.greet "Bonjour!"
# rob.greet "Hello!"

#This is an example of polymorphism through interface inheritance via the mixin `Greet`. Polymorphism in OOP is the
#ability of different object/data types to the interact with the same interface or have the same behavior. Here
#the module `Greet` contains the behavior `#greet`. When the module `Greet` is mixed in to the classes `Teacher` and
#`Student` it gives the objects of those different classes the ability to invoke `#greet`. This also demonstrates
#adheriance the "don't repeat yourself" principle by extracting a common behavior to the reuseable namespace `Greet`.

# 4. What will the last line of code return?
# A NoMethodError. Since `Student#id` is defined as a private method at line 94, the attempt by `#==` to invoke
# `Student#id` by `other.id` (a caller other than `self`) is not allowed by Ruby.
 
# class Student
#   def initialize(id, name)
#     @id = id
#     @name = name
#   end
#   
#   def ==(other)
#     self.id == other.id
#   end
# 
#   private
#   
#   attr_reader :id, :name
# end
# 
# rob = Student.new(123, "Rob")
# tom = Student.new(456, "Tom")
# 
# rob == tom

#5 What will the last 2 lines of code output?

# class Foo
#   def self.method_a
#     "Justice" + all
#   end
# 
#   def self.method_b(other)
#     "Justice" + other.exclamate
#   end
# 
#   private
# 
#   def self.all
#     " for all"
#   end
# 
#   def self.exclamate
#     all + "!!!"
#   end
# end
# 
# foo = Foo.new
# puts Foo.method_a # => "Justice for all"
# puts Foo.method_b(Foo) # => "Justice for all!!!"

#6. Will the following code execute? What will be the output?
# No, it will not execute as expected. `Puppet#greet` at line 149 overrides `Person#greet` via `Puppet` subclassing
# from `Person`. `Person#greet` does not take an argument but `super` at line 150 passes all arguments from #`Puppet#greet`
# to `Person#greet`. An ArgumentsError is generated by Ruby because `Person#greet` does not take an argument.
# class Person
#   attr_reader :name
# 
#   def initialize(name)
#     @name = name
#   end
# 
#   def greet
#      "Hello! they call me #{name}"
#   end
# end
# 
# class Puppet < Person
#   def initialize(name)
#     super
#   end
# 
#   def greet(message)
#     puts super + message
#   end
# end
# 
# puppet = Puppet.new("Cookie Monster")
# puppet.greet(" and I love cookies!")

#7. What concept does this code demonstrate? What will be the output?
# This demonstrates Polymorphism through class inheritance. Both the `Pigeon` and `Duck` classes are subclassed
# from `Bird` and inturn give the objects of these subclasses the behavior `Bird#fly`.
# outputs the following:
# "Bird is flying!"
# "Pigeon is flying!"
# "Duck is flying!"

# class Bird
#   def fly
#     p "#{self.class} is flying!"
#   end
# end
# 
# class Pigeon < Bird; end
# class Duck < Bird; end
# 
# birds = [Bird.new, Pigeon.new, Duck.new].each(&:fly)

#8. What does the self keyword refer to in the good method?
# Since `self` is invoked within the instance method `Dog#good`, it referes to the instance of the `Dog` class
# that calls `Dog#good`. At line 190, the `Dog` object `bandit` calls `Dog#good` which will return `"Bandit is a
# good dog"` because the body of `Dog#good` concatenates the return value of `self.name` to " is a good dog" 
# class Dog
#   attr_accessor :name
# 
#   def good
#     self.name + " is a good dog"
#   end
# end
# 
# bandit = Dog.new
# bandit.name = "Bandit"
# p bandit.good

#9. What will the last three lines of code print to the console? After song.artist is called,
# what would be returned if we inspect the song object?

# class Song
#   attr_reader :title, :artist
# 
#   def initialize(title)
#     @title = title
#     @artist
#   end
# 
#   def artist=(name)
#     @artist = name.upcase
#   end
# end
# 
# p song = Song.new("Superstition")
# p song.artist = "Stevie Wonder"
# p song.artist
# puts song.inspect

# Line 210 will output the object information, class type and memory enconding info, as well the
# initialized instance variable `@title = "Superstition"`
# Line 211 will output the return value of the argument, `"Stevie Wonder"` passed to the writer
# `Song#artist`.
# Line 212 will the output the current return value of the reader `Song#artist`: `"STEVIE WONDER"`
# Calling inspect on the song object will return class type and memory enconding info, as well the
# initialized instance variables `@title = "Superstition"` and `@artist = "STEVIE WONDER"`

#10. What will the last 2 lines output in this case?
# `"STEVIE WONDER"` because the argument is mutated of the setter is mutated by the destructive method
# `#upcase!`. The value of the reference `name` has been changed.
# `"STEVIE WONDER"`

#class Song
#  attr_reader :title, :artist
#
#  def initialize(title)
#    @title = title
#  end
#
#  def artist=(name)
#    @artist = name
#    name.upcase!
#  end
#end
#
#song = Song.new("Superstition")
#p song.artist = "Stevie Wonder"
#p song.artist

#11. What would cat.name return after the last line of code is executed?
# `nil`. `name = "Cheetos"` initializes a local variable within `#set_name`. `#set_name` does not call
# the setter `Cat#name=`

# class Cat
#   attr_accessor :name
# 
#   def set_name
#     name = "Cheetos"
#   end
# end
# 
# cat = Cat.new
# cat.set_name

#12. What will the last two lines of code output?
# [Bugs, Bunny, Run, Walk, Jump, Object, Kernel, BasicObject]
# "Running"
# module Walk
#   STR = "Walking"
# end
# 
# module Run
#   STR = "Running"
# end
# 
# module Jump
#   STR = "Jumping"
# end
# 
# class Bunny
#   include Jump
#   include Walk
#   include Run
# end
# 
# class Bugs < Bunny; end
# 
# p Bugs.ancestors 
# p Bugs::STR

#13a. What will be returned by the value1 and value2 method calls?
# 'Local'
# 'Global'

#13b. If we omit the first line (VAL = ‘Global’), what will the returned values be then?
# Uninitialzied constant

#13c. Without defining VAL again, what line of code can you add to the Bar class inside
# the Foo module to allow value2 access to the same VAL as value1?
# `include Foo`

#VAL = 'Global'

# module Foo
#   VAL = 'Local'
# 
#   class Bar
#     include Foo
#     def value1
#       VAL
#     end
#   end
# end
# 
# class Foo::Bar
#   def value2
#     VAL
#   end
# end
# 
# p Foo::Bar.new.value1
# p Foo::Bar.new.value2

# 14. Write 3 methods inside the Person class and one method in the Friend class that would
# return the outputs shown on lines 23 and 24.


# class Person
#   attr_reader :friends
# 
#   def initialize
#     @friends = []
#   end
# 
#   def <<(other)
#     friends << other.name
#   end
# 
#   def []=(index, other)
#     friends[index] = other.name
#   end
# 
#   def [](index)
#     friends[index]
#   end
# end
# 
# class Friend
#   attr_reader :name
# 
#   def initialize(name)
#     @name = name
#   end
# 
#   def to_s
#     name
#   end
# end
# 
# tom = Person.new
# john = Friend.new('John')
# amber = Friend.new('Amber')
# 
# puts john
# 
# tom << amber
# tom[1] = john
# puts tom[0]      # => Amber
# p tom.friends # => ["Amber", "John"]

#15. What will be output when the last 2 lines of code get executed?
# 2
# 2

# class Foo
#   @@var = 1
# 
#   def self.var
#     @@var
#   end
# end
# 
# class Bar < Foo
#   @@var = 2
# end
# 
# puts Foo.var 
# puts Bar.var

#16. Update the Human class to have lines 11 and 14 return the desired output

# class Human 
#   attr_reader :name
# 
#   def initialize(name="Dylan")
#     @name = name
#   end
# 
#   def hair_color(color)
#     color = "blonde" unless color.size > 0
#     "Hi, my name is #{self} and I have #{color} hair."
#   end
# 
#   def self.hair_color(color)
#     self.new.hair_color(color)
#   end
# 
#   def to_s
#     name
#   end
# end

# puts Human.new("Jo").hair_color("blonde")  
# Should output "Hi, my name is Jo and I have blonde hair."

# puts Human.hair_color("")              
# Should "Hi, my name is Dylan and I have blonde hair."

#17. What does each self refer to in the code snippet below?

# class MeMyselfAndI
#   self
# 
#   def self.me
#     self
#   end
# 
#   def myself
#     self
#   end
# end

# i = MeMyselfAndI.new

# The `self` at Line 416, 418 and 419 refer to the class MeMyselfAndI
# The `self` at line 423 refers to the instance object of the class `MeMyseflAndI` that calls the instance method
# `MeMyselfAnyI#myself`

#18 What are some of the characteristics of instance variables?

# They cannot be accessed outside of the class without defining methods to interact with them (however, as Alex Scout pointed out, you can still indirectly access them by using #instance_variable_get)
# Flexible and do not need to be initialized — in which case they would return nil.
# Dynamically appended to an object upon assignment/initialization.
# Belong to the object — each object gains its own copy of every instance variable defined in a class.
# Their values are not inheritable — modifying one value in a particular instance dos not affect other instances.
# Scoped at the object level and accessible in all instance methods, i.e., they do not need to be passed in as arguments prior to being referred to.

# #1 — What will the following code output? Why?
# System Stack Error. The body of the setter method `Student#id=` is calling itself, `self.id = value`, at its own definition. This causes a recursive
# loop.
=begin

