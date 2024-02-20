=begin
Lesson 1 Quiz explanations.
1.
Object Oriennted Programming (OOP) is a programming paradigm created to deal with problems
experienced by developers when creating large, complex programs.

Large Complex programs can be difficult to maintain due to dependencies throughout the
program. OOP lets programmers write programs in which the different parts of the program
interact, thus reducing dependencies and facilitating maintenance.

Coding in a non-OO way ofen means writing code that is ueful solely within a single context.
Defining basic classes and leveraging concpets like inheritance to introduce more detailed
behaviors provides a greater level of reusability and flexibility.

Complex coding problems are often difficult to break down and solve in a clear and
systematic way. Using OOP to model classes appropriate to the problem, an using real-world
nouns to represent objects, lets programmers think at a higher level of abstraction that helps
them break down and solve problems.

Programming in an OO way doens't necesarily result in writing less code, and even if some OO
programs do have less code, they wouldn't necessarily run more efficiently.

2. The relationship between classes and objects

An Object does not inherit methods from its class. Classes inherit methods from other
classes.

Classes act as molds or templates for objects.

An objects's class determines its behaviors and attributes.

Objects are instances of a class.

3. Rudy modules

A module that is mixed in to a class (mixin) provides a collection of behaviors to one or
classes.

Objects are not instantiated from modules.

Modules provide an alternative to class inheritance for sharing methods. So called, interface
inheritance.

Modules can share behaviors but not attributes.

4. Encasulation

Ruby accomplishses encapsulation by creating objects and exposing inferfaces (i.e. methods)
to interact with those objects.

Encapsulation is not the ability of different objects to respond in different ways to the same
message. That is polymorphism.

Encapsulation is not a way to share common behaviors between classes. That is done with inheritance
or modules.

Encapsulation hides funcationality so that the hidden functionality is unavailable to the rest
of the code base.

5. Inheritance

Ruby uses the `super` keyword to call methods further up the inheritance hierarchy.

Classes that inherit from other classes are a subclass of the class they inherit from.

A class does not inherit from another class by using the `include` method. Ruby uses `include`
to mix in modules.

Inheritance is a way to form specialized classes from more general classe that already exist.

6. Polymorphism

Polymorphism is the ability of different object types to respond to the same method invocation. Often,
but not always, in different ways.

Polymorphism is not hiding the implementation detalis of a class from objects of other classes. That
is description of encapsulation.

Polymorphism is not the ability to instantiate multiple objects of the same class since all the objects
have the same behavior.

Method overriding is one way in which Ruby implements polymorphism.

7. Some benefits of class inheritance in Ruby.

Class inheritance in Ruby only allows a single class to a super class of a sub class. Ruby allows
multiple classes to be sub classed from a super class.

Class inerhitance in Ruby allows behaviors to be extracted from multiple classes into
a super class. Moving behaviors from classes to a super class means those classes should then
become a sub classes.

Class inheritance in Ruby is not what allows us to share methods between classes that are not part
of the same inheritance chain. Classes can only inherit from an ancestor class. Modules can be used to
share methods with classes that are not related.

Class inheritance lets us model concepts that are naturally hierarchical.

8. Objects of a class

The `==` method defined in the `BasicObject` class returns true only if two objects are the same.

Each object of a class is distinct.

You don't need to define and `#initialize` method unless you must initialize something when an object is
instantiated.

9. Superclasses

If a class does not have subclasses then it is not a superclass.

10. Method lookup path.

First within the class of the object, then any included modules within its class. Then the immediate superclass,
then that superclass's included modules until it get to the `Object` class, then `Kernel` until finally `BasicObject`

11. Read and explain OOP code.

`"Daisy says moooooooooooo!"` is output.
`daisy` is a `Cow` class object. The `Cow` class inherits `Animal#speak`. `Animal#speak` invokes `Cow#sound`.
`Cow#sound` uses `super` to call the inherited `Animal#sound` which returns the interpolated `"Daisy says "`.
`Cow#sound` then concatenates the return value of `Animal#sound` to `"moooooooooooo!"`. `Animal#speak` then passes
the return value of `Cow#sound` to `puts` for our output.

12. Objects of the same class.

Objects of the same class have the same behaviors and but can have different states.

13. Instance Variables.

Instance variables start with the `@` symbol., e.g.`@name`
Local variables start with a lowercase letter or an underscore character.
Class variable start with `@@`, e.g. `@@Person`
Setters are defined with `attr_writer`, `att_accessor` or the `def` keyword.

14. Which of the following class definitions will let us run this code and get the same result? Select all that apply.

kate = Person.new
kate.name = 'Kate'
kate.name # => 'Kate'

class Person
  attr_accessor :name
end

class Person
  attr_reader :name

  def name=(name)
    @name = name
  end
end

class Person
  attr_writer :name

  def name
    @name
  end
end

class Person
  def name
    @name
  end

  def name=(name)
    @name = name
  end
end

15. Which of the following code snippets can replace the "omitted code" comment to produce the indicated
result? Select all that apply.

class Person
  attr_writer :first_name, :last_name

  def full_name
    # omitted code
  end
end

mike = Person.new
mike.first_name = 'Michael'
mike.last_name = 'Garcia'
mike.full_name # => 'Michael Garcia'

`"#{@first_name} #{@last_name}"` or `@first_name + ' ' + @last_name`
Anything that would try to use a getter method `first_name` or `last_name` would fail because no getter method is 
defined and would result in a `NoMethodError`.

16. The last line in the above code should return "A". Which of the following methods can we add to the Student
class, so the code works as expected? Select all that apply.

class Student
  attr_accessor :name, :grade

  def initialize(name)
    @name = name
    @grade = nil
  end
end

priya = Student.new("Priya")
priya.change_grade('A')
priya.grade # => "A"

def change_grade(new_grade)
  self.grade = grade
end

def change_grade(new_grade)
  @grade = grade
end

17. On which lines in the following code does self refer to the instance of the MeMyselfAndI class referenced by
i rather than the class itself? Select all that apply.

class MeMyselfAndI
  self

  def self.me
    self
  end

  def myself
    self
  end
end

i = MeMyselfAndI.new

227 or (9) in the actual quiz.
