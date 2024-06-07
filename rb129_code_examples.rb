=begin
#classes and objects
class Car
  attr_reader :type, :year # `Car` object getter behaviors for exposing state.

  def initialize(type, year)
    @type = type #Creation of attributes from the arguments passed to `::new`
    @year = year #`@type` and `@year` are how a `Car` object reference the data of its state.
  end

  def drive # A behavior of `Car` objects
    '...driving'
  end
end

honda = Car.new('Honda', 2016) # Instantiation of a new `Car` object.
puts honda.type # 'Honda'
puts honda.year # 2016
puts honda.drive # '...driving'

#States and Behavior

module Collaboratable
  attr_accessor :collaborator # Instance method - getter and setter behaviors

  def collaborator? # Instance method - test behavior for truthiness for `Person` class objects
    !!collaborator
  end
  
  def collaborator=(other) # Instance method - reassignment behavior of an instance variable
    @collaborator = other
  end

  def collaborators_name
    collaborator? ? " and their name is #{collaborator.name}." : "."
  end

  def collaborator_kept
    "\nI keep a collaborator: This is #{collaborator?}#{collaborators_name}"\
  end
end

class Person
  @@number_of_persons = 0 # A class variable that can share data with other `Person` objects
  
  attr_reader :name # Instance method - getter behavior for `Person` objects

  def initialize(name) # Instance method - constructor behavior for `Person` objects
    @name = name # instance variables can create state unique to the current object
    @@number_of_persons += 1 # an update of `Person`'s data. Can be shared with instances of the `Person` class
  end

  def self.number_of_persons # class method - data exposure behavior for the `Person` class
    @@number_of_persons
  end

  def number_of_persons # Instance method - exposure behavior of class variable data for `Person` instance objects
    Person.number_of_persons
  end

  def info # Instance method - behavior for the output of information about the current object.
    "\n#{self.inspect}; "\
    "\nName: #{name}"\
    "\nI am 1 of #{number_of_persons} persons."
  end
end

puts Person.number_of_persons
bob = Person.new("Bob")
sam = Person.new("Sam")
# Calling `#inspect` or invoking `p` on an instance object doesn't show it's shared data via a class variable but does show an object's
# attributes,i.e. initialized instance variables. 
p bob
# Below we can see `sam` and `bob` share data via a class variable that isn't returned by `#inspect` or `p`.
puts bob.info
puts sam.info

#Instance Variables and their scope
class Dog
  attr_accessor :name
  attr_reader :age, :hair
  @hair = "wire"

  def initialize
    @name = "fido"
    @age
  end
end

p dog1 = Dog.new # =>#<Dog:0x000055f6ba1dfb30 @name="fido">
p dog1.name # => "fido"
dog1.name = "nick"  # 'fido's `@name` value is reassigned
p Dog.new.name #=> "fido"
p dog1.name #=> "nick"
p Dog.new.age # => nil
p Dog.new.hair# => nil

# Here, new `Dog` class instances have an `@name` intialized to a string `"fido"`.
# Each `@name` is individulally scoped within the new instance of `Dog`.
# This means that we can change the value of `@name` within a specific instance
# like we did for the instance `dog1`.
# While an `@age` is named within `#initialize` but not intialized to a value. Since `@age` is not intialized
# it returns `nil` and is not scoped within an object.
# `@hair` is defined at the class level and is not scoped within instances of the `Dog` class.


#class variables and their scope
class Foo
  @@instantiations = 0

  def initialize
    @@instantiations += 1
   end

  def self.instantiations
    @@instantiations
  end
end

class Bar < Foo
end

puts Foo.instantiations
# We get the expected output of `0`
Foo.new
puts Foo.instantiations
# A `Foo` object has been created so we get the expected output of `1`.
Bar.new
puts Bar.instantiations
puts Foo.instantiations
# We get the output of `2` for both `Foo` and `Bar` even though we have only created one `Bar` and one `Foo` object.
# Since `Bar` is subclassed from `Foo` and share a single class variable, `@@instantiations`, the output is given via class variable scoping.

# Constant variables scope and inheritance
TOP_LEVEL = "top-level's constant"

module Othello
  OTHELLO = "Othello's constant"

  def othello_constant
    OTHELLO
  end

  class Cassio
    CASSIO = "Cassio's constant"

    def cassio_othello_constant
      OTHELLO
    end

    def cassio_top_level_constant
      TOP_LEVEL
    end
  end
end

class Lago
  LAGO = "Lago's constant"

  def self.lago_constant
    LAGO
  end

  def lago_constant
    LAGO
  end

  def lago_top_level_constant
    TOP_LEVEL
  end

  def othello_namespace_constant
    Othello::OTHELLO
  end

  def cassio_namespace_constant
    Othello::Cassio::CASSIO
  end

  def bianca_namespace_constant
    Bianca::BIANCA
  end
end

class Bianca < Lago
  BIANCA = "Bianca's constant"
  include Othello
end

p "Constants can be directly referenced from the scope of class method or instance method."
puts Lago.lago_constant 
puts Lago.new.lago_constant
puts Lago.new.lago_top_level_constant
puts ''

p "Classes can inherit methods that access a constant."
p "`Bianca` is a subclass of `Lago` and has the module `Othello` mixed-in."
puts Bianca.lago_constant
puts Bianca.new.lago_constant
puts Bianca.new.othello_constant
puts Bianca.new.lago_top_level_constant
puts ''

p "Objects of namespaced classes can reference constants from a method that are lexically available,"
p "as well as top-level constants."
puts Othello::Cassio.new.cassio_othello_constant
puts Othello::Cassio.new.cassio_top_level_constant
puts ''

p "The namespace resolution operator can be used to reference constants of a lexical scope."
puts Lago.new.othello_namespace_constant
puts Lago.new.cassio_namespace_constant
puts Lago.new.bianca_namespace_constant
puts Lago::LAGO
puts ''

p "The namespace resolution operator can be used to reference a constant found along the method"
p "lookup path of the lexical scope it searches."
puts Bianca::LAGO
puts Bianca::OTHELLO
puts ''

p "However the namespace resolution operator can't reference a constant that is outside of"
p "the lexical scope it searches."
puts Othello::TOP_LEVEL #...uninitialized constant Othello::TOP_LEVEL (NameError)
puts Bianca::TOP_LEVEL #...uninitialized constant Bianca::TOP_LEVEL (NameError)
puts Lago::TOP_LEVEL #...uninitialized constant Lago::TOP_LEVEL (NameError)

# Getter and Setter creation
class Person
  attr_reader :name, :age # accessor getter creation for `name` and `@age`
  attr_writer :age # accessor setter creation for `@age`
  attr_accessor :occupation # accessor getter and setter creation for `@occupation`

  def initialize
    @age = 12
    @occupation = "none"
    @shoe_size = 8
    @name = "Sam"
  end

  def shoe_size # getter definition for `@shoe_size`
    @shoe_size
  end

  def shoe_size=(size) # setter definition for `@shoe_size`
    @shoe_size = size
  end

  def to_s
    "#{name}'s info:"\
    "\nAge: #{age}"\
    "\nOccupation: #{occupation}"\
    "\nShoe size: #{shoe_size}"
  end
end

sam = Person.new
puts sam
puts ''
sam.age = 31
sam.occupation = "Actor"
sam.shoe_size = 11
puts sam

# Instance Methods vs. Class Methods
class Dog
  @@instances_created = 0
  attr_accessor :dog_number

  def initialize
    @@instances_created += 1
    self.dog_number = @@instances_created
  end

  def self.dog # class method definition
    "\nI am a class method that exposes data of the class `Dog`."\
    "\nI don't expose the data of a `Dog` object."\
    "\nI have instantiated #{@@instances_created} dogs."
  end

  def dog # instance method definition
    "\nI am an instance method that exposes data for an object of `Dog` and"\
    "\ndata of the `Dog` class."\
    "\nI am dog #{dog_number} of #{@@instances_created} instantiated dogs."
  end
end

puts Dog.dog # Invocation of the class method `::dog`
rex = Dog.new
ginger = Dog.new
puts rex.dog # Invocation of the instance method `#dog`
puts ginger.dog # Invocation of the instance method `#dog`
puts Dog.dog # Invocation of the class method `::dog`

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

# Class inheritance
class Mammal
  def sleep
    "I am a #{self.class} that is sleeping."
  end

  def run
    "I am a #{self.class} that is running."
  end
end

class Dog < Mammal # now `Dog` has the behaviors of `Mammal` and is refined by `#bark`
  def bark
    "barking"
  end
end

class Cat < Mammal # now `Cat` has the behaviors of `Mammal` and is refined by `#purr`
  def purr
    "purring"
  end
end

[Dog.new, Cat.new].each do |mammal| # use of "dry" code and polymorphic behavior via class inheritance.
  puts mammal.sleep
  puts mammal.run
end

puts Dog.new.bark # subclass objects with behaviors specific to their class.
puts Cat.new.purr

# Encapsulation example
class Dog
  def bark
    "bark"
  end
end

class Cat
  attr_accessor :name # Our reader and writer behavior definition for `@name`

  def initialize(name, color)
    @name = name    # Data can be encapsulated by initialized instance variables 
    @color = color  # that are scoped within an instance object.
  end

  def play(other)
    "#{name} is #{color} and plays with #{other.name}."
  end

  # both `@name` and `@color` are checked to see if they point to the same object with the same value.
  # in their respective `Cat` objects.
  def state?(other)
    name.equal?(other.name) && color.equal?(other.color)
  end

  def purr
    "purring"
  end

  # method access control encapsulates where objects can exhibit behavior.
  protected
  
  attr_reader :color
end

# OOP in Ruby encapsulates data
initial_name = "max"
initial_color = "black"

cat1 = Cat.new(initial_name, initial_color)
cat2 = Cat.new(initial_name, initial_color)
p cat1.object_id == cat2.object_id # => false
puts cat1.state?(cat2) # => true
puts ''
puts cat1.name # => max
puts cat2.name # => max
# At this point, if we mutate `initial_name`'s reference object,
# `@name`'s value in `cat1` and `@name`'s value in `cat2` also update.
puts ''
puts initial_name.reverse! # => xam
puts cat1.name # => xam
puts cat2.name # => xam
puts cat1.state?(cat2) # => true
# We can see that we have two different `Cat` objects that have the same state, i.e.
# their instance variables reference the same data.
puts ''
# However, even though `cat1` and `cat2` happen to have the same state, each `Cat` object's state is
# unique by way of encapsulation.
# Now we need to see that each `Cat` object encapsulates state.
# We have defined a writer method, `#name=`, for intentional state modification of a `Cat` object.
# Here we reassign `@name` within `cat2` to different data. 
cat2.name = "xnij"
# The data that `cat2` was initialized to,`intial_name`, is now no longer part of `cat2`'s state
# but `intial_name` is still part of `cat1`'s state.
puts cat1.name # => xam
puts cat2.name # => xnij
puts cat1.state?(cat2) # => false
# And we can see how encapsulation protects the data referenced by `cat2` along with all other
# `Cat` objects' data through the use of that setter.
puts ''
cat1.name.reverse!
cat2.name.reverse!
puts initial_name # => max
puts cat1.name # => max
puts cat2.name # => jinx
puts ''
# OOP in Ruby encapsulates behavior
# `Cat#color` can only be exhibited within the scope of a `Cat` instance method because it has a
# method access control implemented.
puts cat1.play(cat2) # => max is black and plays with jinx.
puts cat1.color # No Method Error
# As defined here, `Cat` objects can't invoke `Dog` behavior and vise-versa.
# The fact that classes are unrelated is an encapsulation of their behaviors.
cat1.bark # NoMethodError
Dog.new.purr # NoMethodError

# Polymorphism example
module Walkable
  def walk(walk_type="easy")
    "#{walk_type} walk"
  end
end

class Parent
  attr_reader :hair_color

  def initialize
    @hair_color = "Blonde"
  end
end

class Child < Parent
  include Walkable

  def initialize
    @hair_color = "Brown"
  end
end

class Dog
  include Walkable
end

class Duck
  def walk(gait="waddle")
    "#{gait} walk"
  end
end

[Parent.new, Child.new].each { |obj|  puts obj.hair_color } # Polymorphism through class inheritance
[Child.new, Dog.new].each { |obj| puts obj.walk("run") } # Polymorphism through interface inheritance / mixins
[Dog.new, Duck.new].each { |obj| puts obj.walk} # Ducktyping polymorphism

# Modules and their use cases

# Modules are used to provide common/polymorphic behaviors to unrelated classes, through so called "mixins".
module Personable
  def sit
    "sit on a Zamboni via the mixin #{Personable}"
  end

  def speak
    "I am of the class #{self.class}. I can speak via the mixin #{Personable} and #{sit}."
  end
end

module Birdable
  def sit
    "sit in a treetop via the mixin #{Birdable}"
  end
end

class Mascot
  include Personable
end

class Raptors
  include Personable
  include Birdable
end

p Raptors.new.speak
p Mascot.new.speak
puts ''

# Namespacing: Modules are used to contain classes that are similar in type or are related.
# Namespacing makes it easier to recognize similar and related classes.
# Namespacing prevents the collision of similarly named classes.

module Dogs
  def self.type
    self
  end

  class Bulldog
    def speak
      "I am of the class #{self.class}, namespaced within the module #{Dogs.type}."
    end
  end
end

module Mascots
  def self.type
    self
  end

  class Bulldog
    def speak
      "I am of the class #{self.class}, namespaced within the module #{Mascots.type}."
    end
  end
end

p Dogs::Bulldog.new.speak
p Mascots::Bulldog.new.speak
puts ''

# Module Methods
module Brains
  def self.chess
    "chess"
  end

  def self.tic_tac_toe 
    "tic-tac-toe"
  end
end

class Chicken
  def speak
    "I am a #{self.class} and I can play #{Brains.tic_tac_toe}." # the preferred way to invoke a module method.
  end
end

class Person
  def speak
    "I am a #{self.class} and I can play #{Brains::chess}."
  end
end

puts Chicken.new.speak
puts Person.new.speak

# Class Inheritance vs. Modules
=end
module Walkable
  def walk
    "walked"
  end
end

module Fuelable
  def gasoline
    "gas added"
  end
end

module Sleepable
  def sleep
    "sleeping"
  end
end

class Mammal
  include Sleepable
  attr_reader :warm_blooded

  def initialize
    @warm_blooded = "warm_blooded"
  end
end

class Dog < Mammal
  include Walkable

  def bark
    "bark"
  end
end

class Beagle < Dog
  def hunt
    "hunt"
  end
end

class Lawnmower
  include Fuelable
  include Walkable
end

subclassed_warm_blooded_sleepers = [Dog.new, Beagle.new]
mixed_in_walkers = [Dog.new, Beagle.new, Lawnmower.new]

subclassed_warm_blooded_sleepers.each { |animal| puts "#{animal.warm_blooded} and #{animal.sleep}" }
mixed_in_walkers.each { |mover| puts mover.walk }

=begin
# Method Lookup Path

module Boatable
  def drive
    "boat"
  end
end

module Busable
  def drive
    "bus"
  end
end

class BusDriver
  include Boatable
  include Busable
end

class Captain
  include Busable
  include Boatable
end

# Both the `BusDriver` class and `Captain` class have their method lookup paths
# augmented by the order in which their mixins are included. So, Ruby executes a
# different `#drive` for each.
puts BusDriver.new.drive
puts Captain.new.drive

# Method Overriding
class Driver
  def drive
    "car"
  end

  def to_s # Overrides `#to_s` inherited from `Object`
    "I am liscensed to drive a #{drive}."
  end
end

class BusDriver < Driver
  def drive # Overrides `#drive` inherited from `Driver`
    "bus and a " + super # Here `super` incorporates the behavior of the overriden `#drive`
  end
end

sam = Driver.new
bob = BusDriver.new

puts sam
puts bob

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

# Fake Operators

puts 10 == 10 # syntactical sugar
puts 10.==(10) # explicit syntax of a fake operator

class Dog
  attr_reader :age
  def initialize(age)
    @age = age
  end
end

puts Dog.new(10).age # 10
# When we call `==` on the return value of a `#age` we get the expected result
puts Dog.new(10).age == Dog.new(10).age # true
puts Dog.new(20).age == Dog.new(10).age # false
puts Dog.new(20).age > Dog.new(10).age # true
# But invoking `==` with a `Dog` object returns what is a seemingly odd result if
# we don't understand `==`'s inherited behavior.
puts Dog.new(10) == Dog.new(10) # false
puts Dog.new(10) > Dog.new(10) # NoMethodError
=end