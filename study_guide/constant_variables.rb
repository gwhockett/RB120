=begin
When creating classes there may be values that shouldn't be changed. To prevent
a value from changing a variable called a 'constant' can be used. A constant is
defined using the all uppercase letters for its name, like this:
`NAME = 'Sheila'`. Constants can be defined with just the first letter
uppercase but convention dictates all uppercase is used. Technically a
constant's value can be changed but Ruby will throw a warning. Constants have
lexical scope, meaning its available within the enclosing structure. The
enclosing structure might be a module, class, or the top level scope. To resolve
a constant reference Ruby will first seach lexically, then through the
ancestors of the current structure, then finally at the top level scope.
=end