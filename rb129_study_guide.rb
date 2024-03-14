=begin
Classes and Objects

In Ruby, objects are instances of a class and are created from classes. For example, strings are an
instance of the String class. Two objects of the same class type can contain different different
information. `"hello"` and `"good-bye"` are both strings but contain different info.

A class can be thought of as a mold that instantiates an object of that class, in other words classes define objects.
The attributes and behaviors of an object are determined when defining the class they will be derived from.
Defining a class is similar to defining a method but instead of using the `def` reserved word, `class` is used
followed by the name of the class formatted using the `PascalCase` naming convention. Finally to finish
defining the class we use `end`.

An example:

class HousePet
  def initialize(name)
    @name = name         #`@name` is how all `HousePet` objects can have a unique attribute.
  end

  def walk               # this method is a behavior that all `HousePet` objects will have.
    "#{@name} is walking."
  end
end

kiki = HousePet.new("Kiki") #instantiation of a new `HousePet` object.
p kiki.walk # => "Kiki is walking."

States and Behaviors

When defining a class two things are the usual focus: state and behavior
The state of an object derived from a class definition refers to the data referenced by that particular object.
If we create another `HousePet` object, say `pickles = HousePet.new("Pickles")`, both 'pickles' and 'kiki' are 
`HousePet` objects but have different states. `kiki` contains the string `"Kiki"` referenced by the instance
variables `@name` and `pickles` contains the string `"Pickles"` referenced by the instance variable `@name`.
The class `HousePet` defines `@name` as a reference by which state is stored in its objects. For `kiki` and
`pickles` a unique `@name` exists within each and is held within each until they are destroyed. If `kiki` goes
away `@name` still exists within `pickles` and viseversa. `@name` is independent within each and is not kept by
the class.

However all instances of `HousePet` have the same behavior via the instance method `HousePet#walk` even when
instances have a different state. Here, objects of `HousePet` have the behavior of `HousePet#walk` that exposes
the unique data associated with an initialized `@name` held within each `HousePet` object.

Instance Variables, Class Variables, Constants: their respective scopes and how inheritance affects each's scope.

Instance Variables are variables that are used to tie data to the objects of a class. They start with the `@` symbol
and exist as long as the object they are initialized within exists. While they are defined at the class level they
are initialized within the class. Uninitialized instance variables return `nil` 
