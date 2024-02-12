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
=end

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

=begin
# What is output on `lines 14, 15, and 16` and why?


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
