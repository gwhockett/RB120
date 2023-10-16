=begin
As a general programming concept, we can think of attributes as the different
characteristics that make up an object.

For example:
A `Laptop` object might inlcude: make, color dimensions, display, processor,
memory, storage, battery life, etc. Generally, these attributes (think
attr_accessor in Ruby) can be accessed and manipulated from outside the object.

Implementing attributes depends on the programming language.
In Ruby, initializing instance variables and their names within a class
determines the attributes that make up an object.

Having an instance variable in class with no way access it is not a useful
attribute. Getters and setters give us access to an object's attributes but do
not make up a part of an object's state. An object's state is composed of
instance variables and their values.
=end
