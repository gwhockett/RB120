=begin
Classes in Ruby create objects and determine what kind of states and behaviors
a class's objects can have. All custom classes inherit behaviors from Object
and BasicObject. BasicObject is the only class that does not have a parent
class to inherit from. Custom classes can also inherit from other custom
classes that are defined ealier in a code base. The earlier class's name must
be added to the name of the class using the `<` sign, like this:
`class CurrentClass < EarlierClass`. Here `CurrentClass` now inherits the
behaviors, i.e. methods, of `EarlierClass`. Classes in Ruby can only sub class
directly from one super class. So called, Single Class Inheritance.

Encapsulation is contorlling how part of a code base can interact with the rest
of a code base. It's a kind of data protection that prevents unintended
modification. The boundaries of encapsulation also promote code sophistication
for more effective programming. In Ruby, Method Access Control is one of the
main ways to encapsulate data.

Polymorphism is the plurality of data types that an interface can interact
with. In Ruby, different object types can invoke the same method if the
differing objects can provide the needed parameters to invoke the same method. 
The two main ways that Ruby implements polymorphism is through class
inheritance and Duck-typing. When a class inherits a method from a super class,
the sub class can override the parent class method by defining an instance
method with the same name as the inherited method. This is polymorphism through
inheritance. Polymorphism through Duck-typing is when different, unrelated
objects can respond the same method name. However, with duck-typing, emphasis
should be placed on the sameness of the behavior of the unrelated objects. So,
if something can "quack", treat it like a duck. Duck-typing is an informal
classification of a group of unrelated objects pulled together by overlapping
behaviors, thus duck-typing allows for polymorphism without direct inheritance.
Polymorphism should be understood and implemented to create clearity of
intention and use of code. Merely having a method that can be called by several
different object types does not make for polymorphism even when polymorphic
technique is used.

