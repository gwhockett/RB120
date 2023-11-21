=begin
As a general programming concept, we can think of objects as having attributes. Attributes are made of state and behavior. A state might be a string value or integer. A behavior is a function or method that performs a task, which could be as simple as retrieving the value that an object contains.

Implementing attributes depends on the programming language.
A Ruby object's attribute usually is thought to have two components:

1. An instance variable to store a state (value). Instance variables defined within a class determine the how states can be stored within an instantiated object. An object's instance variable is not useful if we can't access it.

2. A getter and/or setter instance method. Instance methods need to be defined within the class that can give us access to an object's state(s). Generally, Instance methods (behaviors) alone are not considered attributes.
=end
