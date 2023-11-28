=begin
`self` is a keyword in Ruby used to ensure the intended object should invoke a
method. At top level scope, `self` refers to `main` which is an instance of the
Object class. At the lexical scope of a class and outside of an instance method
`self` refers to the class itself. Defining a class method requires `self` to
prepended to the name of the class method. Otherwise Ruby would interperate the
name of the method as an instance method. Within the scope of an instance
method `self` refers to the calling object of the instance method. Say we have
a getter method `name` that is invoked within an instance method. When Ruby
reads `name` there is no ambiguity. `self.name` and `name` are equivalent in
that both invoke the instance method. However, to invoke a setter method within
the scope of an instance method `self` must be prepended, e.g.,
`self.name = "Bob"`. Otherwise, `name = "Bob"` will initialize a new local
variable `name` that points to `"Bob"`. 
=end