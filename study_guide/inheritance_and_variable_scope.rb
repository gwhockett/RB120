=begin
An object instance can have access to an instance variable and that variable's
companion methods (gettes, setters, etc.) that are along the method look-up
path of that instance. Within a class, care must be taken when defining methods
that overwrite a parent class method or a mixed in module's method that
initializes an instance variable. Otherwise, an overwriten method might prevent
an instance variable from being initialized.

Class variables are accessible to sub-classes but should be avoided when used
in an inheritance chain. Changing a sub-class variable's value overides the
super-class's variable and will affect all other sub-classes of that
super-class.

For Ruby to resolve a constant's reference it first looks within lexical scope.
Meaning if the reference is inside of a module then within that module first or
if a class then within a that class first. If Ruby does not find the reference
within lexical scope then it searches the ancestors path of that scope. Finally
if the constant is not found with on method look up path, Ruby will look at the
top level scope of the current program. 
=end