=begin
Ruby's syntactical sugar makes certain methods look like an operator. For
instance, `str1 == str2` is fully written out like this: `str1.==(str2)`. These
are also called "fake operators" Below is a list of fake operators and true
operators in Ruby.

The following are "fake operators", i.e., methods
[], []=	                  Collection element getter and setter.
**	                      Exponential operator
!, ~, +, -	              Not, complement, unary plus and minus (method names for the last two are +@ and -@)
*, /, %	                  Multiply, divide, and modulo
+, -	                    Plus, minus
>>, <<	                  Right and left shift
&	                        Bitwise "and"
^, |	                    Bitwise exclusive "or" and regular "or" (inclusive "or")
<=, <, >, >=	            Less than/equal to, less than, greater than, greater than/equal to
<=>, ==, ===, !=, =~, !~	Equality and pattern matching (!~ cannot be directly defined)

The following are true operators and not a method call.

., ::	                                                     Method/constant resolution operators
&&	                                                       Logical "and"
||	                                                       Logical "or"
.., ...	                                                   Inclusive range, exclusive range
? :	                                                       Ternary if-then-else
=, %=, /=, -=, +=, |=, &=, >>=, <<=, *=, &&=, ||=, **=, {	 Assignment (and shortcuts) and block delimiter

When you define `==` as instance method in a class you automatically get the
`!=` as its inverse, unless you override `!=`

When defining comparison methods we don't automatically get other comparison
methods. Defining `<` doesn't give us `>`

When defining fake operators, keep in mind to follow the general useage of the
standard libraries.

Integer#+: increments the value by value of the argument, returning a new integer
String#+: concatenates with argument, returning a new string
Array#+: concatenates with argument, returning a new array.
Date#+: increments the date in days by value of the argument, returning a new date

Not only does the method `+` generate a new value but also creates a new
object. More to the point, what kind of object is method working with and is it mutating
or not?

Another notable fake operator(s) is Array#[] and Array#[]=
So `my_array[2]` fully written out looks like this `my_array.[](2)` to return
the object held at index `2` or `my_array.` And `my_array.[2]= "hello"` is
`my_array[]=(2, "hello")` for a reassignment of the second index to `"hello"`


=end