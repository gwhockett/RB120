=begin
A module is a container that holds reuseable code. The reusable code could be
classes, methods or constants. Modules are used in classes through the
invocation of the `include` method followed by the module name formated in
CamelCase, like this: `module ModuleName`. Modules are also used for
namespacing. This means organizing similar or related classes in a module.
Modules make it easier to recongnize related classes and reduces the collision
of similarly named classes in the codebase. Lastly, modules give us a place to
contain out of place methods. Direct access to classes and constants in a
module can be given via the namespace operator `::`, i.e.,
`ModuleName :: NAME_CONSTANT` for constant or `ModuleName :: SomeClass.new` for
a class.

Since classes in Ruby only directly sub-class from one super class, so called
single inheritance, there would be greater difficultly to accurately model
problem domains without modules. Ruby allows us to mix in behaviors through
modules without the use of multiple inheritance. A class can mix in as many
modules as we like and any class can mix in a module. Modules give us another
avenue to create polymorphic structure and encapsulation.

=end