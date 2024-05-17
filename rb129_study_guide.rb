=begin
Classes and Objects

In Ruby, objects are instances of a class and are created from classes. For example, strings are an
instance of the String class. Two objects of the same class type can contain different different
information. `"hello"` and `"good-bye"` are both strings but contain different info.

Classes define objects. The attributes and behaviors of an object are determined when defining
the class they will be derived from.
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


class Cat
  attr_reader :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def speak
    'Meow'
  end
end

pickles = Cat.new('Pickles', 2)
socks = Cat.new('Socks', 9)
puts pickles.name # 'Pickles'
puts socks.name # 'Socks'
puts pickles.age # 2
puts socks.age # 9
puts pickles.speak # 'Meow'
puts socks.speak # 'Meow'

A class can be describe as a mold that forms an object. Objects of a class have two main components: state and behavior.
The data associated with an object is its state and data is referrenced within an object by instance variables. The behavior of an
instance object is determined by defining instance methods in its class.

In this example the behaviors of the objects `fido` and `paws` are the instance methods `#name`, `#age` and
`#speak`. The state individually of `pickles` and `socks` is given by the data refered to by the instance variables `@name` and `@age`
within each.

Class inheritance versus Mixins

At the object level, inheritance can add to the group of methods a class collects in the two ways stated.

Class inheritance is created when a class is subclassed from a superclass. The subclass then inheriates the group of methods of the superclass.
Classes subclass from a single parent/superclass giving a single chain of inheritance. 

Mixins, modules included into a class, add to the group of instance methods of that class. Mixins create interface inheritance but unlike class
inheritance, as many mixins as needed can be added to a class and can be added to any class. Mixins are Ruby's way of creating multiple
inheritance.

Class inheritance is used to create heirarchical relationship domains and is used to model related classes. By adding methods to subclasses or
overriding inherited methods, class inheritance is used to refine the behavior of subclassed objects. In contrast, mixins allow unrelated
classes to have the same behavior. More broadly, class inheritance is used to create "is-a" relationships. If a greyhound is a type of dog,
greyhound should subclass from the dog superclass. Mixins create "has-a" relationships. If a cat and a dog class are unrelated but both have
the same ability to walk, a mixin can be used. Mixins are also used to give a subclass behaviors that a superclass does not.

module Swimmable
  def swim
    "I can swim."
  end
end

module Runnable
  def run
    "I can run."
  end
end

class Dog
  include Runnable
  
  def bark
    "bark!"
  end
end

class Greyhound < Dog
  include Swimmable

  def run 
    super + " Really fast!"
  end
end

class Bulldog < Dog
  def speak
    "I can #{bark} on command."
  end
end

class Cat
  include Runnable
  include Swimmable

  def swim
    super + " But I hate to."
  end
end


#related classes whose behaviors differ
puts Greyhound.new.run
puts Greyhound.new.bark
puts Greyhound.new.swim
puts
puts Bulldog.new.run
puts Bulldog.new.speak
# Bulldog.new.swim #=> NoMethodError
puts
#unrelated class with the same behavior via a mixin
puts Cat.new.run
puts Cat.new.swim

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
defined using all uppercase letters for its name, like this:
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

################################################################
For the topics shown below, you should be able to provide clear explanations, using code snippets as examples, and be able to identify these concepts within code snippets.

**Classes and objects**

A Class is a template that defines and creates objects. The syntax to define a class is similar to defining a method but instead of using the `def`...`end`  reserved words, `class`...`end` is used with the name of a class is formatted in `PascalCase`. Defining a class's characteristics has two main considerations: how the class and it's objects behave and how the class and its objects keep state. When a class calls `::new`, it instantiates a new instance object. From Ruby Docs:

> new(args, ...) → obj
>
> Calls [`allocate`](https://ruby-doc.org/3.3.0/Class.html#method-i-allocate) to create a new object of _class_’s class, then invokes that object’s initialize method, passing it  _args_. This is the method that ends up getting called whenever an object is constructed using  `.new`.

When the object is instantiated calling inspecting the object returns the name of the object's class, memory encoding information and any attributes the object has.

 **States and behaviour**
 
The state of an object is composed of the data associated with that object. An instance object's state generally consists of attributes and those attributes are unique to that instance. For Ruby, an attribute of an object is an initialized instance variable. While the data an object is associated with can be shared by other objects, e.g. through a constant variable, class variable or an instance variable, the attributes and state of that object are not shared even though two different objects can have the same state.

Behaviors are the instance methods an instance object can invoke. All instances of a class can exhibit the same behavior.  The group of methods that can be invoked by instance object are defined within its class or are inherited by that class.

 **Instance variables, class variables, and constants, including the scope of each type and how inheritance can affect that scope**

Instance variables are variables that are named similarly as local variables but have an `@` prepended to a `snake_cased` name. They are not scoped or initialized at the class level but are initialized and scoped with instance objects. Meaning instance variables are accessed only by the object they are initialized with. Instance variables are initialized via an instance method available to that instance object. A class can inherit methods that give its objects the ability to initialize and access instance variables but classes do not inherit instance variables.

Class variables capture information about an entire class and share data between instances of a class. A class and instances of that class sharing one copy of a class variable. They are named with `@@` prepended to a `snake_cased` name. Class variables can be directly initialized within a class and can also be initialized within an instance method or a class method. Initialized class variables have scope anywhere within the class they are initialized in and are accessible to all the subclasses that inherit from that class. They are also available to the instance methods and class methods of those subclasses. Generally, using class methods in classes that use inheritance should be avoided due to unexpected behavior that can result from a reassignment by an inheriting class.

Constants variables are used to  prevent a value from changing. Convention dictates a constant should be named using all `UPPERCASE` or `SCREAMING_SNAKE_CASE` but Ruby will recognized a variable as a constant if just the first letter of its name is uppercase. Technically, a constant's value can be changed but Ruby will throw a warning but not an error. Constants have lexical scope, meaning the position of the constant determines where it can be referenced. When directly referencing a constant from a method, Ruby first searches lexically, i.e. the position where the constant name is, then through the ancestors (method lookup path) of that the lexical scope and lastly top-level scope. Classes can inherit class methods and instance methods that have access to a constant.

If the namespace resolution operator,`::`, is used to reference a constant, Ruby will search that lexical scope and the method lookup path of that lexical scope but will not go beyond that lexical scope. The namespace resolution operator can't be used to reference constants at the top-level.

Once a constant is resolved, Ruby stops looking to resolve the constant. If Ruby does not find where a constant is initialized, a NameError is thrown for an uninitialized constant.

**Different ways to create and call getter and setter methods**

Getter:
An instance variable's value can't be accessed directly inside or outside of a class. If we want to obtain a value stored in an instance variable of an object, we must use a method that has access to the object's instance variable. To do that, an instance method needs to be defined that returns an initialized instance variable, i.e., an attribute. By convention, a getter is defined to complete the single task of returning an attribute and is defined with the name of the attribute it returns.

Setter:
A setter method initializes or changes the value of an instance variable. Ruby has specific syntax for Ruby to recognize it as a setter. For instance, if a getter is named `age` that returns an attribute `@age` then the setter should have the same name but with `=` suffixed along with an argument parameter. `age=(number)`. Ruby's syntactical sugar also allows us to invoke a setter with a more natural `rex.age = 8`. Setters always return the value of the argument passed in. So here, `8` would be returned even if the last line of this setter has another expression. By convention, a setter it performs only one job, setting the value of an instance variable and has the same name as the attribute it sets.
	
Getters and setters can be defined using the `def`..`end` keywords but Ruby has a built-in-way to refactor these definitions. `#attr_accessor`creates both a reader and writer with name of the argument. `#attr_reader` creates a reader and `#attr_writer` creates a setter. All three need to have arguments in a symbol or string format and can take multiple arguments to create multiple readers and writers.

 **Instance methods vs. class methods**

Instance methods are called by an object instance of a class. Instance methods can be a behavior of an object instance or can be used to expose and modify the value of its instance variables. They can also expose and modify class variables of the calling object's class. They are defined using the reserved words `def` ... `end`, have a `snake_case` format, may or may not take arguments and can have their accessibility modified through Method Access Control modifiers.

Class methods are called by a class, not the objects of a class. Class methods are the behavior of a class and are used to expose and modify the data of a class. If we need a method that does not deal with the state of an object, we can use a class method. Class methods are defined in the same way instance methods are but have `self` prepended to the name of the class.

 **Method access control**

Ruby gives us access modifiers to create behavioral encapsulation. Access modifiers restrict or allow where an instance method can be invoked ,i.e. method access control. Ruby gives us three instance methods to modify the accessibility of the instance methods of a class: `public`, `private` and `protected`. Any instance method defined below an access modifier invocation, with no arguments passed to the modifier, will have that access status. Those instance methods will have that access status until another modifier is invoked to change the status of the following instance method definitions. Access modifiers can be used in classes or mixins. 

By default, all instance methods are set to `public`. Generally, a class should have as few `public` methods as possible. `public` methods are the interface used for intentional exposure of attributes and behaviors.

Methods that have`private` accessibility can only be invoked by the current object instance within the scope of a instance method of the same class as the current object. Trying to call a `private` method directly inside or outside of a class will generate a NoMethodError. Keeping methods `private` is useful in the management of sensitive information like social security numbers, passwords and limiting the interface of objects.

`protected` methods can be invoked in a similar way `private` methods are invoked. This means protected methods can't be directly invoked outside or inside of a class but must be invoked by `self` or another object of the same class within the scope of an instance method of the same class. To invoke the `protected` method of another object of the same class, the other object must be passed into the instance method invoked by `self`. `protected` methods are useful for collaboration of same class objects where the attributes of the collaborating object shouldn't be public as well limiting the interface of the collaborating objects.

 **Class inheritance, encapsulation and polymorphism**

Class inheritance is created when a class is subclassed from a superclass. The subclass then inheirates the group of methods of its superclass. Class inheritance is used to create "is-a" relationships, i.e. hierarchical relationship domains and is used to model related classes. For example a dog is a kind of mammal. By adding methods to subclasses or overriding inherited methods, class inheritance is used to refine the behavior of subclassed objects. Class inheritance also gives us formal way to "dry out" code. Meaning that we can extract common methods to a superclass that gives us streamlined, polymorphic code structure that is easier to understand and debug. To create class inheritance the `<` symbol along with the superclass name is added to the class definition name of the inheriting subclass.

Encapsulation in OOP controls how parts of a code base interact with each other and promotes more effective programming through greater code sophistication. When data and behavior are available throughout a program it can be described as more monolithic and undifferentiated. The rigidity of a monolithic code base makes data protection and unintended modification more difficult. OOP in Ruby creates encapsulation of data by capturing it in an object of a class. Encapsulation of behavior is created by controlling where the methods of an object can be accessed.

Polymorphism is the plurality of data types that an interface can interact with. In Ruby, different object types can invoke the same method if the differing objects can provide the needed parameters to invoke the same method. Ruby implements polymorphism through class inheritance, interface inheritance and duck-typing. Class inheritance and interface inheritance polymorphism give varying objects intersecting method lookup paths to achieve polymorphic structure and behavior. Polymorphism through duck-typing is when different objects can respond to different methods of the same name but their respective method lookup paths do not intersect. With duck-typing, sameness of behavior of unrelated objects should be built into the code. So, if something can quack, you can treat it like a "duck." Polymorphism should be implemented to create clarity of the intention of the code base. Merely using a polymorphic technique is not polymorphism proper.

**Modules and their use cases**

Mixins, modules included into a class, add to the group of instance methods of that class. Mixins create interface inheritance but unlike class inheritance, as many mixins as needed can be added to a class and can be added to any class. Mixins are Ruby's way of creating multiple inheritance. We can also adjust the method lookup path of a class depending on how we order the inclusion of mixins. When a class has multiple mixins, the lookup path will look in the reverse order of the mixin inclusion list: last is first, first is last. Instance methods within a mixin are defined in the same way instance methods are defined within a class. Hence, we can extract instance methods to a mixin to DRY the code.

Namespacing modules are used to contain classes that are similar in type or are related. Namespacing also makes it easier to recognize related classes and prevents the collision of similarly named classes. Constant variables can be namespaced to provide data to various parts of a code base and are resolved using the namespace operator, `::`.

A module can be used to create module methods, i.e. methods we don't want to encapsulate to a specific type of object. The module methods are defined with their name prepended with `self` and the preferred way to invoked a module method is using the resolution operator `.`, but the namespace operator ,`::`, works as well.

**Method lookup path**

To resolve the invocation of a method Ruby follows a method lookup path. The group of methods an object has available to it is determined by the inheritance structure of its class and the methods defined within that class.  Ruby first looks within the immediate class of the invoking object then looks to any included modules. The order that the modules included into a class determines how the method lookup path is ordered. Ruby will look in the last included module first and moving in reverse order of the mixins. After looking in any modules, Ruby then moves to the immediate super class, then to any modules included in that super class and so on. Ruby will continue to look until it gets to the final superclass, `BasicObject`. If Ruby does not find a matching method, a NoMethodError is thrown and Ruby terminates the search . When a matching method is found along the path, Ruby will execute that method and stop looking. If you want to see the method lookup path for an object, call the class method `ancestors`  with the object's class. An array is returned with the lookup path.

**Method Overriding**

When a class inherits a method, we can redefine a method of the same name within that class to augment or refine the behavior of that method, i.e., override the method. Since Ruby terminates looking for a method once it has been executed, inherited methods can be overridden.

If we don't want Ruby to terminate method lookup for an overridden method we can use the keyword `super` within the overridden method and Ruby will continue looking up the method path for a method of the same name. `super` with no parentheses passes all arguments passed to the overridden method to the next method of the same name up the path. `super()` will pass no arguments to the overridden method even if that method has arguments. `super(a)` will pass `a`  to the overridden method. Multiple arguments can be passed to the overridden method as well.

Accidental overriding  happens when a method is unintentionally defined with the same name as an inherited method. This can have far reaching effects, especially if a method inherited from the `Object` class is overridden. It is generally not a good idea to override methods from the `Object` class. `to_s` is an exception to overriding an `Object` method. Overriding `to_s` is used to return a string representation of the current object and should only return a string with no side effects. If the return value of `to_s` is anything other than a string, invoking `to_s` will be the same as calling `to_s` on the calling object, which returns the class name and encoding information for its object id.

 **self**

`self` is a keyword in Ruby used to reference an object, usually to ensure an intended calling object. What `self` references is dependent on the scope in which it is invoked. At top level scope, `self` refers to `main` which is an instance of the `Object` class. At the scope of a class and outside of an instance method `self` refers to the class itself. Defining a class method requires `self` to be prepended to the name of the class method. Otherwise, Ruby would interpret the name of the method as an instance method. Within the scope of an instance method `self` refers to the calling object of the instance method. `self` within the scope of a method refers to the module. Say we have a getter method `name` that is invoked within an instance method. When Ruby reads `name` there is no ambiguity. `self.name` and `name` are equivalent in that both invoke the getter. However, to invoke a setter method within the scope of an instance method `self` must be prepended, e.g., `self.name = "Bob"`. Otherwise, `name = "Bob"` will initialize a new local variable `name` that points to `"Bob"`.

**Fake operators and equality**

Fake Operators:
Ruby's syntactical sugar makes certain methods look like an operator or so called "fake operators". For instance, `str1 == str2` is fully written out like this: `str1.==(str2)`. Custom classes inherit these fake operators. At times these operators need to be overridden to return a custom or expected result.

The following are true operators:
- `.` method resolution
- `::` namespace/constant resolution
- `&&` logical "and"
- `||` logical "or"
- `..`, `...` inclusive range, exclusive range
- `?`...`:`Ternary if-then-else
- `=`, `%=`, `/=`, `-=`, `+=`, `|=`, `&=`, `>>=`, `<<=`, `*=`, `&&=`, `||=`, `**=` assignment operators
-  `{`...`}` block delimitation

The following are "fake operators", i.e., instance methods:
- `[]`, `[]=` Collection element getter and setter.
- `**` Exponential operator
- `!`, `~`, `+`, `-` Not, complement, unary plus and minus (method names for the last two are +@ and -@)
- `*`, `/`, `%` Multiply, divide, and modulo
- `+`, `-` plus, minus
- `>>`, `<<` Right and left shift
- `&` Bitwise "and"
- `^`, `|` Bitwise exclusive "or" and regular "or" (inclusive "or")
- `<=`, `<`, `>`, `>=` Less than/equal to, less than, greater than, greater than/equal to
- `<=>`, `==`, `===`, `!=`, `=~`, `!~`	Equality and pattern matching (`!~` cannot be directly defined)

Custom classes inherit `BasicObject#==`. `BasicObject#==` compares whether the caller and the argument are the same object, not whether they have the same return value. Even if two objects have the same state, `false` will be returned if they are different objects. Without overriding `#==` invoking `#==` using a custom class object behave the same as `BasicObject#==` . `BasicObject#==` is one the most common overridden fake operators. It can be used to compare specific attributes or the whole state of objects. When `BasicObject#==` is overridden we automatically get `#!=` along with it. However with when overriding `#>` we don't automatically get `#<` and vise-versa.

When working with a collection and we want to access and modify the elements of a collection, we need to define the element getter method:

```ruby
def [](idx)
	collection[idx]
end
```
Setter instance method:

```ruby
def []=(idx, obj)
	collection[idx] = obj
end
```

For equivalence please see the following page:
https://launchschool.com/lessons/d2f05460/assignments/9cadd494
- `==`understanding how this works is the most important of these methods.
- `===` asks, if the caller is group, is the argument a member of that group. Is implicitly used by `case` statements.
- `equal?`  determines whether two variables have the same value and point to the same object.
- `eql?` determines if two objects contain the same value and if they're of the same class. Implicitly used by`hash`

**Collaborator Objects**

Collaboration between objects is at the core of OOP and gives programmers a way to make useful connections between various actors of a program. It enables a program to chop up and modularize a task into cohesive pieces. Objects stored as state that work in conjunction with the object they are kept in are considered collaborator objects. They're usually custom objects defined by the programmer and not inherited from the Ruby core library.
=end