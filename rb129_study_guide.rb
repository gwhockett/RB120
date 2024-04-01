=begin
Classes and Objects

In Ruby, objects are instances of a class and are created from classes. For example, strings are an
instance of the String class. Two objects of the same class type can contain different different
information. `"hello"` and `"good-bye"` are both strings but contain different info.

Classes define objects. The attributes and behaviors of an object are determined when defining
the class they will be derived from. Defining a class is similar to defining a method but instead of
using the `def` reserved word, `class` is used followed by the name of the class formatted using the
`PascalCase` naming convention. Finally to finish defining the class we use `end`.

An example:

class HousePet
  def initialize(name)
    @name = name           #`@name` is how all `HousePet` objects can have a unique attribute.
  end

  def walk                 # this method is a behavior that all `HousePet` objects will have.
    "#{@name} is walking."
  end
end

kiki = HousePet.new("Kiki") #instantiation of a new `HousePet` object.
p kiki.walk # => "Kiki is walking."

States and Behaviors

When defining a class two questions are the usual focus: What kind of state and what kind of behavior should an
object have? The state of an object derived from a class definition refers to the data referenced by that
particular object. If we create another `HousePet` object, say `pickles = HousePet.new("Pickles")`, both
'pickles' and 'kiki' are  `HousePet` objects but have different states. `kiki` contains the string `"Kiki"`
referenced by the instance variables `@name` and `pickles` contains the string `"Pickles"` referenced by the
instance variable `@name`. The class `HousePet` defines `@name` as a reference by which state is stored in its
objects. For `kiki` and `pickles` a unique `@name` exists within each and is held within each until they are
destroyed. If `kiki` goes away `@name` still exists within `pickles` and viseversa. `@name` is independent within
each and is not kept by the class.

However all instances of `HousePet` have the same behavior via the instance method `HousePet#walk` even when
instances have a different state. Here, objects of `HousePet` have the behavior of `HousePet#walk` that exposes
the unique data associated with an initialized `@name` held within each `HousePet` object.

Instance Variables, Class Variables, Constants: their respective scopes and how inheritance affects the scope each.

Instance Variables are variables that are used to tie data to the objects of a class. They start with the `@` symbol
and are named using the snake case convention. They exist as long as the object they are initialized within exists.
While they are defined at the class level they are scoped within objects, not the class where they are defined.
Uninitialized instance variables return `nil`. Instance variables are initialized by an instance method that is
found along the method look up path of the class that an object is derived from. They are accessable to instance
methods outside of the initializing instance method along the method look up path of the object's class and don't
need to be passed in as an argument to those instance methods.

Class Variables 

Class variables capture information about an entire class. They are created using two `@` symbols in front of a
snake cased name, like this: `@@snake_case`. Class variables can be directly initialized at the class level.
Class variables can be accessed using instance and class methods. Class variables share state between instances of
a class.

Class variables have scope anywhere within the class they are initialized and are accessible to all the subclasses that
inheirit from the class they are initialized within. They can be initialized at the class level, within instance methods
and class methods. Generally, using class methods in classes that have inheritance should be avoided because subclasses
can override superclass class variables which leads to unexpected behavior. 

They have two main behaviors:

1. All instances of the respective class share one copy of a class variable so instances of a class can use instance
methods to access a class variable.

2. Initialized class variables can be accessed by class methods.

Constant Variables

When creating classes there may be values that shouldn't be changed. To prevent
a value from changing a constant variable can be used. A constant is
defined using the all uppercase letters for its name, like this:
`NAME = 'Sheila'`. While constants can be defined with just the first letter
uppercase, convention dictates all uppercase be used. Technically, a
constant's value can be changed but Ruby will throw a warning.

Constants have lexical scope, meaning the position of the constant determines where it is available. Lexical scope
is determined by the enclosing structure / container, e.g., a module or class. To resolve a constant reference Ruby
first searches lexically, then through the ancestors of the current enclosing structure (method lookup path). The method
lookup path can be adjusted depending on the order in which modules are mixed in. Ruby will search in reverse order of 
listed mixins, i.e. the lowest or last will be searched first. After seaching the method lookup path Ruby will search
through the namespacing heirachy until finally reaching top level scope.

If the namespace operator,`::`, is used to resolve a constant, Ruby will not look beyond the namespaced container using
`::` but will follow the method lookup path of that container.

D = 'the top, outermost scope constant D'

module Bianca
  B = "module Bianca constant B"

  class Cassio
    C = "class Cassio constant C"

    def retrieve_constant_b
      B
    end

    def retrieve_constant_c
      C
    end

    def retrieve_constant_d
      D
    end
  end

  module Othello
    O = "module Othello constant O"
  end

  class Lago < Cassio
    include Othello
  
    def retrieve_constant_o
      O
    end
  end
end


p Bianca::Lago.ancestors # for reference
puts ''
p Bianca::Lago.new.retrieve_constant_o
p Bianca::Lago.new.retrieve_constant_b
p Bianca::Lago.new.retrieve_constant_c
p Bianca::Lago.new.retrieve_constant_d
puts ''
p Bianca::Lago::O
p Bianca::Lago::C
#p Bianca::Lago::B # Unintialized constant error
#p Bianca::Lago::D # Unintialized constant error

Creating getters and setters


=end


