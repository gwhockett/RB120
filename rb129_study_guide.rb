=begin
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

By default, all instance methods are set to `public`. `public` methods are available anywhere in a program.  `public` methods are the interface for intentional exposure of attributes and behaviors. Generally, a class should have as few `public` methods as possible.

Methods that have`private` accessibility can only be invoked by the current object instance within the scope of a instance method of the same class as the current object. Trying to call a `private` method directly inside or outside of a class will generate a NoMethodError. Keeping methods `private` is useful in the management of sensitive information like social security numbers, passwords and limiting the interface of objects.

`protected` methods can be invoked in a similar way `private` methods are invoked. This means protected methods can't be directly invoked outside or inside of a class but must be invoked by `self` or another object of the same class within the scope of an instance method of the same class. To invoke the `protected` method of another object of the same class, the other object must be passed into the instance method invoked by `self`. `protected` methods are useful for collaboration of same class objects where the attributes of the collaborating object shouldn't be public as well limiting the interface of the collaborating objects.

 **Class inheritance, encapsulation and polymorphism**

Class inheritance is created when a class is subclassed from a superclass. The subclass then inheirates the group of methods of its superclass. Class inheritance is used to create "is-a" relationships, i.e. hierarchical relationship domains and is used to model related classes. For example a dog is a kind of mammal. By adding methods to subclasses or overriding inherited methods, class inheritance is used to refine the behavior of subclassed objects. Class inheritance also gives us formal way to "dry out" code. Meaning that we can extract common methods to a superclass that gives us streamlined, polymorphic code structure that is easier to understand and debug. To create class inheritance the `<` symbol along with the superclass name is added to the class definition name of the inheriting subclass.

Encapsulation in OOP controls how parts of a code base interact with each other and promotes more effective programming through greater code sophistication. When data and behavior are available throughout a program it can be described as more monolithic and undifferentiated. The rigidity of a monolithic code base makes data protection and unintended modification more difficult. OOP in Ruby creates encapsulation of data by capturing it in an object of a class. Encapsulation of behavior is created by controlling where the methods of an object can be accessed.

Polymorphism is the plurality of data types that an interface can interact with, i.e different objects types that can invoke a method of the same name. In Ruby, different object types can invoke the same method if the differing objects can provide the needed parameters to invoke the same method. Ruby implements polymorphism through class inheritance, interface inheritance and duck-typing. Class inheritance and interface inheritance polymorphism give varying objects intersecting method lookup paths to achieve polymorphic structure and behavior.
Polymorphism through duck-typing is when different objects can respond to different methods of the same name but their respective method lookup paths do not intersect. With duck-typing, sameness of behavior of unrelated objects should be built into the code. So, if something can quack, you can treat it like a "duck."
Polymorphism should be implemented to create clarity of the intention of the code base. Polymorphism gives us flexibility of the use of existing code for new purposes and merely using a polymorphic technique is not polymorphism proper.

**Modules and their use cases**

Mixins, modules included into a class, add to the group of instance methods of that class. Mixins create interface inheritance but unlike class inheritance, as many mixins as needed can be added to a class and can be added to any class. Mixins are Ruby's way of creating multiple inheritance. We can also adjust the method lookup path of a class depending on how we order the inclusion of mixins. When a class has multiple mixins, the lookup path will look in the reverse order of the mixin inclusion list: last is first, first is last. Instance methods within a mixin are defined in the same way instance methods are defined within a class. Hence, we can extract instance methods to a mixin to DRY the code.

Namespacing modules are used to contain classes that are similar in type or are related. Namespacing also makes it easier to recognize related classes and prevents the collision of similarly named classes. Constant variables can be namespaced to provide data to various parts of a code base and are resolved using the namespace operator, `::`.

A module can be used to create module methods, i.e. methods we don't want to encapsulate to a specific type of object. The module methods are defined with their name prepended with `self` and the preferred way to invoked a module method is using the resolution operator `.`, but the namespace operator ,`::`, works as well.

**Method lookup path**

To resolve the invocation of a method Ruby follows a method lookup path. The group of methods an object has available to it is determined by the inheritance structure of its class and the methods defined within that class.  Ruby first looks within the immediate class of the invoking object then looks to any included modules. The order that the modules included into a class determines how the method lookup path is ordered. Ruby will look in the last included module first and moving in reverse order of the mixins. After looking in any modules, Ruby then moves to the immediate super class, then to any modules included in that super class and so on. Ruby will continue to look until it gets to the final superclass, `BasicObject`. If Ruby does not find a matching method, a NoMethodError is thrown and Ruby terminates the search . When a matching method is found along the path, Ruby will execute that method and stop looking. If you want to see the method lookup path for an object, call the class method `ancestors`  with the object's class. An array is returned with the lookup path.

**Method Overriding**

When a class inherits a method, we can redefine a method of the same name within that class to augment or refine the behavior of that method, i.e., override the method. Since Ruby terminates looking for a method once it has been executed, inherited methods can be overridden.

If we don't want Ruby to terminate method lookup for an overridden method we can use the keyword `super` within the overridden method and Ruby will continue looking up the method path for a method of the same name. `super` with no parentheses passes all arguments passed to the overridden method to the next method of the same name up the path. `super()` will pass no arguments to the overridden method even if that method has arguments. `super(a)` will pass `a`  to the overridden method. Multiple arguments can be passed to the overridden method as well.

Accidental overriding  happens when a method is unintentionally defined with the same name as an inherited method. This can have far reaching effects, especially if a method inherited from the `Object` class is overridden. It is generally not a good idea to override methods from the `Object` class. `to_s` is an exception to overriding an `Object` method. Overriding `to_s` is used to return a string representation of the current object and should only return a string with no side effects. If the return value of `to_s` is anything other than a string, invoking `to_s` will be the same as calling `to_s` on the calling object, which returns the class name and encoding information for its object id. Fake operators are often overridden as well.

 **self**

`self` is a keyword in Ruby used to reference an object, usually to ensure an intended calling object. What `self` references is dependent on the scope in which it is invoked. At top level scope, `self` refers to `main` which is an instance of the `Object` class. `self` at the scope of a module, outside of an instance method, refers to the module. At the scope of a class and outside of an instance method `self` refers to the class. Defining either a class method or a module method requires `self` to be prepended to the name of the both method types. Without `self` prepended for either, an instance method is defined. Within the scope of an instance method `self` refers to the calling object of the instance method. Say we have a getter method `name` that is invoked within an instance method and there isn't a local variable `name` initialized within that method, when Ruby reads `name` there is no ambiguity. `self.name` and `name` are equivalent in that both invoke the getter. However, to invoke a setter method within the scope of an instance method `self` must be prepended, e.g., `self.name = "Bob"`. Otherwise, `name = "Bob"` will initialize a new local variable `name` that points to `"Bob"`.

**Fake operators and equality**

Fake Operators:
Ruby's syntactical sugar makes certain methods look like an operator or so called "fake operators". For instance, `str1 == str2` is fully written out like this: `str1.==(str2)`. Custom classes may or may not inherit these fake operators and a fake operator's behavior often depends on the calling object type. At times these operators need to be overridden to return a custom or expected result. For instance, custom classes inherit `BasicObject#==`. `BasicObject#==` compares whether the caller and the argument are the same object, not whether they have the same return value. Even if two objects have the same state, `false` will be returned if they are different objects. Without overriding `#==`, invoking `#==` using a custom class object behaves the same as `BasicObject#==` . `BasicObject#==` is one the most common overridden fake operators. It can be used to compare specific attributes or the whole state of objects. When `BasicObject#==` is overridden we automatically get `#!=` along with it. However when overriding `#>` we don't automatically get `#<` and vise-versa.

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