=begin
Ruby has a process it follows to find a method when an object invokes a method.
This is called the Method Lookup Path. To determine the lookup path Ruby uses
inhertance ancestory and included modules. First looking within the immediate
class of the invoking object, Ruby then looks to any included modules, then to the
immediate super class, then to any modules included in that super class and so on.
Ruby will continue to look until it gets to BasicOject. If no method is found then
an error will be raised. If a method is found along the path, that method will
execute and Ruby will stop looking. If you want to see the method lookup path
for a class, the class method `ancestors` can be invoked and output.

=end
