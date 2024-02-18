=begin
# What is output and why?
# What does this demonstrate about instance variables that differentiates them from local variables?
`nil` is output because `@name` has not been initalized by the `Person` object `bob`. Instance
variables must be initialized at the object level. If `bob` invokes #set_name then the instance
variable `@name` will be initialized to the string `'Bob'` where `@name` will continue to exist within
the object `bob` for later reference and use. However, if a local variable was initalized within the
scope of #set_name, that local variable would no longer exist once #set_name has finished executing. 
1.

class Person
  attr_reader :name
  
  def set_name
    @name = 'Bob'
  end
end

bob = Person.new
p bob.name

2.

module Swimmable
  def enable_swimming
    @can_swim = true
  end
end

class Dog
  include Swimmable

  def swim
    "swimming!" if @can_swim
  end
end

teddy = Dog.new
p teddy.swim   


# What is output and why? What does this demonstrate about instance variables?

`nil` is output because the `Dog` object `teddy` did not invoke Swimmable#enable_swimming, which
leaves `@can_swim` not invoked for `teddy`. While instance variables are defined at the class level
there are only initialized by instance objects and are maintained at the scope of an instance.

3.

module Describable
  def describe_shape
    "I am a #{self.class} and have #{SIDES} sides."
  end
end

class Shape
  include Describable

  def self.sides
    self::SIDES
  end
  
  def sides
    self.class::SIDES
  end
end

class Quadrilateral < Shape
  SIDES = 4
end

class Square < Quadrilateral; end

p Square.sides 
p Square.new.sides 
p Square.new.describe_shape 


# What is output and why? What does this demonstrate about constant scope? What does `self` refer to in each of the 3 methods above?
=begin
`Squares.sides` ouputs `4` because it calls the class method `self.sides` which returns the constant `SIDES` in the class `Quadrilateral`.
For #self.sides of the class `Square` `self` referes to the class `Square`.

`Square.new.sides` outputs `4` because it calls the instance method Shape#sides and returns the constant `SIDES` in the class `Quadrilateral`.
`self` in Shape#sides referes to the calling instance object `Square.new`.

`Square.new.describe_shape` outputs an uninitialized constant error because there is no `SIDES` constant defined lexically in the `Describable`
module.

This demonstrates that constants are available (scoped) within the enclosing structure in which they are initailized, i.e., lexical scope.

4
class AnimalClass
  attr_accessor :name, :animals
  
  def initialize(name)
    @name = name
    @animals = []
  end
  
  def <<(animal)
    animals << animal
  end
  
  def +(other_class)
    new_obj = AnimalClass.new("some animals classes")
    
    self.animals.each { |fauna| new_obj.animals << fauna }
    other_class.animals.each { |fauna| new_obj.animals << fauna }

    new_obj
  end
end

class Animal
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
end

mammals = AnimalClass.new('Mammals')
mammals << Animal.new('Human')
mammals << Animal.new('Dog')
mammals << Animal.new('Cat')

birds = AnimalClass.new('Birds')
birds << Animal.new('Eagle')
birds << Animal.new('Blue Jay')
birds << Animal.new('Penguin')

some_animal_classes = mammals + birds
p some_animal_classes

# What is output? Is this what we would expect when using `AnimalClass#+`? If not, how could we adjust the implementation of `AnimalClass#+`
# to be more in line with what we'd expect the method to return?

A new array containing all the animal objects from `mammals` and `birds`. The output is technically correct in the output in the
way that `AnimalClass#+` is defined but it is not returning a new `AnimalClass` object if it its behave in similarity to the standard
#+ methods. For that similarity, it need to return a new `AnimalClass` object with it's `@animals` array containing all the animals from
both `birds` and `mammals`

5
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def change_info(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end


sparky = GoodDog.new('Spartacus', '12 inches', '10 lbs') 
sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info 
# => Spartacus weighs 10 lbs and is 12 inches tall.


# We expect the code above to output `”Spartacus weighs 45 lbs and is 24 inches tall.”` Why does our `change_info` method not work as expected?

`GoodDog#change_info` creates the local variables `name`, `height`, `weight`. Each should have `self.` or `@` prepended to ensure that instance variable
is being reassigned its parameter value.

6
class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
  
  def change_name
    self.name = name.upcase
  end
end

bob = Person.new('Bob')
p bob.name 
p bob.change_name
p bob.name


# In the code above, we hope to output `'BOB'` on `line 16`. Instead, we raise an error. Why? How could we adjust this code to output `'BOB'`?

`name` within the scope of `Person#change_name` is an unitialized local variable. Changing `name = name.upcase` to `self.name = name.upcase`
will get our desired output.

7
class Vehicle
  @@wheels = 4

  def self.wheels
    @@wheels
  end
end

p Vehicle.wheels                             

class Motorcycle < Vehicle
  @@wheels = 2
end

p Motorcycle.wheels                           
p Vehicle.wheels                              

class Car < Vehicle; end

p Vehicle.wheels
p Motorcycle.wheels                           
p Car.wheels     


# What does the code above output, and why? What does this demonstrate about class variables, and why we should avoid using class variables when working
# with inheritance?

The output is:
4
2
2
2
2
2

There is a single copy of a class variable that shared amongst a class and all its sub-classes. Using class variables should be avoided with
inheritance because unintended modification of a class variable can happen anywhere along the inheritance chain.

8
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end
end

bruno = GoodDog.new("brown")       
p bruno

# What is output and why? What does this demonstrate about `super`?

`bruno`'s object information is output #=> #<GoodDog:0x000055ca2d727548 @name="brown", @color="brown">
`GoodDog.new` at line xx creates a new `GoodDog` object and invokes the constructor method `initialize` that takes one argument.
`initialize` invokes `super` which passes the argument value `"brown"` from line xx to the inherited `Animal#initialize`. `@name` is initialized
and assigned to `"brown"`. `GoodDog#initialize` then initializes `@color` and assigns it to `"brown"` which was passed in as an argument at lien xx.
This demonstrates that `super` automatically passes method arguments to the super class method invoked by `super`.

9
class Animal
  def initialize
  end
end

class Bear < Animal
  def initialize(color)
    super
    @color = color
  end
end

bear = Bear.new("black")        

p bear
# What is output and why? What does this demonstrate about `super`? 

An argument error is output because `Animal#initialize` was passed an argument when it is not defined to take an argument.
`super` passes an argument to an inherited method even if that method does not take an argument.

10
module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing."
  end
end

module Danceable
  def dance
    "I'm dancing."
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end

module GoodAnimals
  include Climbable

  class GoodDog < Animal
    include Swimmable
    include Danceable
  end
  
  class GoodCat < Animal; end
end

good_dog = GoodAnimals::GoodDog.new
p good_dog.walk


# What is the method lookup path used when invoking `#walk` on `good_dog`?

Ruby would look in the following order of objects of this array:
[GoodAnimals::GoodDog, Danceable, Swimmable, Animal, Walkable]
Once #walk has been resolved in the module `Wallkable`, Ruby would stop looking.

11
class Animal
  def eat
    puts "I eat."
  end
end

class Fish < Animal
  def eat
    puts "I eat plankton."
  end
end

class Dog < Animal
  def eat
     puts "I eat kibble."
  end
end

def feed_animal(animal)
  animal.eat
end

array_of_animals = [Animal.new, Fish.new, Dog.new]
array_of_animals.each do |animal|
  feed_animal(animal)
end

# What is output and why? How does this code demonstrate polymorphism? 

The output would be the following:
"I eat."
"I eat plankton."
"I eat kibble."

Each object contained in `array_of_animals` can invoke an instance method called #eat. Each have a different
output because the `Fish` and `Dog` classes override the #eat method they inherit from `Animal`.
This is a demonstration of polymorphism through inheritance.

12
class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

class Pet
  def jump
    puts "I'm jumping!"
  end
end

class Cat < Pet; end

class Bulldog < Pet; end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty
bob.pets << bud                     

bob.pets.jump 

# We raise an error in the code above. Why? What do `kitty` and `bud` represent in relation to our
`Person` object?  
`bob.pets` returns a `@pets` array stored within the `Person` object `bob`. `Person` class objects don't
have a `jump` method defined for array objects to invoke. `kitty` and `bud` are collaborator objects. They
they are the objects, "pets", that populate the `Person` `bob`'s `@pets` array.

13
class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def initialize(name); end

  def dog_name
    "bark! bark! #{@name} bark! bark!"
  end
end

teddy = Dog.new("Teddy")
puts teddy.dog_name   


# What is output and why?
"bark! bark!  bark! bark!" is output. The `Dog` object `teddy` invokes the instance method `#dog_name` which returns
a string that interpolates an `@name` instance variable of the calling object. However, `teddy` does not have an initialized
`@name` instance variable, so `nil` is returned for the interpolation. `Dog#initialize` overrides its inherited
`Animal#initialize` method and does not call `super`, thus `teddy` cannot initialize `@name`.

14
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

al = Person.new('Alexander')
alex = Person.new(al.name)
p al.name == alex.name # => true
p al.name.equal?(alex.name)


# In the code above, we want to compare whether the two objects have the same name. `Line 11` currently returns `false`.
#How could we return `true` on `line 11`? 

# Further, since `al.name == alex.name` returns `true`, does this mean the `String` objects referenced by `al` and
# `alex`'s `@name` instance variables are the same object? How could we prove our case?

We could have both `al` and `alex` both call the accessor reader method `Person#name` which allow the method `==` to
compare the value of `@name` within `al` and `alex`. Or we could override `==` within `Person` to compare `self.name`
to `other.name` to achive the same comparison.

Here `#==` is just checking whether `al.name` and `alex.name` have the return value not whether they are the same objects.
We could compare `al.name`'s returned object with `alex.name`'s returned object using the method #equal? which compares if
two objects are the same object.

15
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "My name is #{name.upcase!}."
  end
end

bob = Person.new('Bob')
puts bob.name
puts bob
puts bob.name

# What is output on `lines 14, 15, and 16` and why?
Line 14 outputs `'Bob'`. Line 15 outputs `"My name is BOB."`. Line 14 outputs `'BOB'`
On line 14 the `Person` object `bob` invokes the getter method `Person#name` which returns `bob`'s `@name` instance variable value. That value
is passed to `puts` which outputs `'Bob'` and returns `nil`. On line 15 the `Person` object `bob` is passed to `puts` where `to_s` is invoked
on `puts`'s arugment. Since `to_s` is overriden for `Person` class objects, `"My name is #{name.upcase!}."` is returned. It that return value,
string interpolation of the getter `Person#name` invokes the mutating `upcase!` method where the value of the `@name` is changed to `'BOB'`
`puts` finally outputs `"My name is BOB."` and returns `nil`. Online 16 the `Person` object `bob` invokes the getter method `Person#name`
that now returns `'BOB'` which is passed to and output by `puts` and returns `nil`.

 16.
# Why is it generally safer to invoke a setter method (if available) vs. referencing the instance variable directly when trying to
# set an instance variable within the class? Give an example.
If we invoke an undefined method, e.g., misspelling or give the wrong number of arguments or wrong argument type Ruby can give us an error
warning. This makes it less likely to introduce a bug to our program. If reference an instance variable directly but misspell that instance
variable Ruby will create a new instance variable, leaving our instance variable unchanged and creating a bug.

class Person
  attr_accessor :name
  attr_reader :age

  def initialize(name, age)
    self.name = name
    @ge = age
  end

end

bob = Person.new("bob", 26)
p bob.name
p bob

17
# Give an example of when it would make sense to manually write a custom getter method vs. using `attr_reader`.
A manual getter allows us to augment the return value of the getter with out changing the value of the instance variable
referrenced by the getter. We may want to do this to redact a portion of sensitive information, e.g. social security numbers,
or prepend salutations to a name.

class Police
  attr_writer :name

  def initialize(name)
    self.name = name
  end

  def name
    "Lt. #{@name}"
  end
end

larry = Police.new("Larry")
puts larry.name

18
class Shape
  @@sides = nil

  def self.sides
    @@sides
  end

  def sides
    @@sides
  end
end

class Triangle < Shape
  def initialize
    @@sides = 3
  end
end

class Quadrilateral < Shape
  def initialize
    @@sides = 4
  end
end

p Triangle.sides #=> nil
p Triangle.new.sides #=> 3
p Triangle.sides #=> 3
Shape.new
p Triangle.sides #=> 3
Quadrilateral.new
p Triangle.sides #=> 4
p Triangle.new.sides #=> 3
p Triangle.sides #=> 3

# What can executing `Triangle.sides` return? What can executing `Triangle.new.sides` return?
# What does this demonstrate about class variables?
`Triangle.sides` could return `3` or `4` or `nil`. `Triangle.new.sides` can only return `3`
Class variables' scope available across all related classes. If a class variable's value is
changed in class that inherates that class variable. The value of that class variable is
in the super class and any other sub classes of that super class.

19
# What is the `attr_accessor` method, and why wouldn’t we want to just add `attr_accessor`
# methods for every instance variable in our class? Give an example.
The `attr_accessor` method is used to create a getter and setter for an instance variable. When the name of the
instance variable is passed in as an argument to `attr_accessor` as a symbol without the `@` sign, e.g.
`attr_accessor :name` would creates a getter and setter for `@name`. `attr_accessor` is great for refactoring
but doesn't allow for custom getters or setters via its implementation. Also, we may not want to have a getter
and setter for every instance variable. If only want a getter, then we could use `attr_reader` or only a setter
for an instance variable, then `attr_writer`. These variations of `attr_*` give Ruby options for encapsulating
object instance data.

20
# What is the difference between states and behaviors?
For instance objects of a class, a state is data that is referenced by an instance variable that is maintained at
the scope of the instance object and not at within the class itself. A behavior for instance objects of a class
are the instance methods available to the objects to invoke. Behaviors can be inherited from super-classes or mixed
in modules but instance variables cannot be inherited.

21
# What is the difference between instance methods and class methods?
Instance methods are methods (behaviors) available to be invoked by object instances of a class but not to the class itself.
An instance of a class must be instantiated to invoke an instance method.
Class methods are behaviors available to a class but not the instances of that class. Once a class is defined it can invoke class methods
class methods. Custom class methods need to have `self.` prepended to the name of the method at definition to work as a class method.

22
# What are collaborator objects, and what is the purpose of using them in OOP? Give an example of how we would work with one.
Collaborator objects work in conjunction with and stored as state in other objects. They are usually custom objects and unrealted
to the object they stored in. While any object type can be used as a collaborator, collaborating objects are designed
and implimented in OOP too determine the relationships different objects can have.

23
# How and why would we implement a fake operator in a custom class? Give an example.
First we need to know what a fake operator is. Fake operators are methods that look like genuine operators but Rudy's
syntactical sugar hides portions of the  fake operator''s syntax to make it more readable. Custom classes inherit
fake operator's like `==`. If we call `==` with a custom object and pass in another object, `==` returns a boolean as
to whether they are the same object. If we need to compare a specific state of a custom object using `==` then we could
override `==` to compare only the specified state.

class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def ==(other)
    name == other.name
  end
end

bob = Person.new("Bob")
anna = Person.new("Bob")
p bob.name
p anna.name
p bob.name == anna.name
p bob == bob
p anna == bob

25
class Person
  def initialize(n)
    @name = n
  end
  
  def get_name
    @name
  end
end

bob = Person.new('bob')
joe = Person.new('joe')

puts bob.inspect # => #<Person:0x000055e79be5dea8 @name="bob">
puts joe.inspect # => #<Person:0x000055e79be5de58 @name="joe">

p bob.get_name # => "bob"

# What does the above code demonstrate about how instance variables are scoped?
Since both `Person` objects, `joe` and `bob`, have their own `@name` that point to different
string objects at the same time, means that `@name` is scoped within those instances of `Person`
and not in the class `Person`. We can see that `joe` did not reassign `@name` within `bob`.

26
# How do class inheritance and mixing in modules affect instance variable scope? Give an example.
The scope of an ivar is not affected by class inheritance or mixing in modules. Class inheritance
and mixins can affect how an ivar is initialized within and retrieved from its scope.

27
# How does encapsulation relate to the public interface of a class?
Encapsulation, through method access control, allows us to hide internal representation of an object
from the outside of a class. The public interfaces of a class are the methods available external
to the class.

28
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age  = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
puts sparky

29
# When does accidental method overriding occur, and why? Give an example.
Accidental method overriding occurs when an instance method is defined within a custom class that has the same name
as an inherited method. Overriding methods, especially from the `Object`, class can far reaching, unwanted side
effects.

class Email
  def send
    "Whoosh!"
  end

  def recieve
    "You've got mail!"
  end
end

message = Email.new
puts message.recieve
puts message.send
puts message.send "recieve"

# Here Object#send has been overriden by Email#send. It would be better to name Email#send to #send_email to prevent any
# unwanted side effects.

30
# How is Method Access Control implemented in Ruby? Provide examples of when we would use public,
# protected, and private access modifiers.
# Method Access Control is implemented by invoking `Object#private`, `Object#protected` or `Object#public` within a
# class or module. Instance methods are public by default but once any of the Method Access Control methods are invoked,
# all methods that are defined afterwards will have that access status until another Method Access Control method is invoked.
# There are should be as few public methods as possible for any class.
=end

=begin
# What is output and why? How could we output a message of our choice instead?
# `sparky`'s object class name and the encoding information of its memory address.
# This is output because `puts` calls `to_s` on the object `sparky`. We could override
# the `GoodDog` class's inherited `to_s` method to output a custom message when `sparky`
# is passed to `puts`.
# How is the output above different than the output of the code below, and why?
# `sparky`'s object class name and the encoding information of its memory address and the initialized
# ivars `@name` and `@age`
# `p` invokes the method `inspect` which returns
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    @name = n
    @age  = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
p sparky




#50.
class Person
  TITLES = ['Mr', 'Mrs', 'Ms', 'Dr']

  @@total_people = 0

  def initialize(name)
    @name = name
  end

  def age
    @age
  end
end

# What are the scopes of each of the different variables in the above code?

The constant `TITLES` has lexical scope. The class variable `@@total_people` has lexical scope.
The instance variable `@name` would be scoped at the instance/object level when initialized.
However, `@age` does not have a way to be intialized so it has nowhere to be scoped.

bob = Person.new('bob')
bob.age
p bob

51.
# The following is a short description of an application that lets a customer place an order for a meal:

# - A meal always has three meal items: a burger, a side, and drink.
# - For each meal item, the customer must choose an option.
# - The application must compute the total cost of the order.

# 1. Identify the nouns and verbs we need in order to model our classes and methods.
# 2. Create an outline in code (a spike) of the structure of this application.
# 3. Place methods in the appropriate classes to correspond with various verbs.


52. 
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end


# In the `make_one_year_older` method we have used `self`. What is another way
we could write this method so we don't have to use the `self` prefix? Which use
case would be preferred according to best practices in Ruby, and why?

Changing `self.age += 1` to `@age += 1` would yield the same return value for #make_one_year_older.
According to best practices `self.age += 1` is the preferred implimentation. If we misspelled `@age` we would
unintentially initalize a new instance method and `@age` would not be set to the new value.
If we misspelled #age, Ruby would throw a no mehtod error message and prevent a bug from being introduced into
the program.

53.
# What is output and why? What does this demonstrate about how methods need to be defined in modules, and why?
A NoMethodError would be output. For a method defined within a module to used as an instance method, the method
should not have `self` prepended to the name. Here, #self.drive is a module method available to Drivalble.

module Drivable
  def self.drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
Drivable.drive


54.
# What module/method could we add to the above code snippet to output the desired output on the last 2 lines, and why?
We could mixin the `Comparable` module and define a comparable, `<=>`, instance method within the class `House` that would
evaluate the `@price` state of two different `House` objects.


class House
  include Comparable
  attr_reader :price

  def <=>(other)
    price <=> other.price
  end

  def initialize(price)
    @price = price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2 # => Home 1 is cheaper
puts "Home 2 is more expensive" if home2 > home1 # => Home 2 is more expensive


=end
