=begin
Class variables capture information about an entire class and are shared with
all instances of the respective class. They are created using two `@` symbols
in front of a snake cased name, like this: `@@snake_case` Class variables can
be directly initialized at the class level and they do not need a method to be
refernced or modified within a class. However, class variables can be accessed
using instance and class methods. Instances of a class can use getters and
setters to access a class variable outside of a class and are defined the same
manner as they are for instance variables.
=end