=begin
A collaborating object works in conjunction with an object as a stored state.
While a collaborating object can technically be of any class type, an object
isn't considered to be collaborating unless it is a custom object. This is
because collaboration not only occurs as a matter of state (an object kept in
physical memory) but in the design and implimentation of OOP. Collaboration is
a way of determining the kind of relationships differing objects can have.
If you have an object of the class `RecipeBook` then a recipe object from the
class `MainCourseRecipe` that is stored in a `RecipeBook` object is
collborating. If you have a class called `Recipe` then the class
`MainCourseRecipe` should be a sub-class of `Recipe`. If you have a class
called `Ingredient` then the objects of `Ingredient` can collaborate with
objects of the `MainCourseRecipe` because the objects `Ingredient` would be
stored directly within a `MainCourseRecipe` object. But the `Ingredient` class
and `Ingredient` objects have no relationship to the `RecipeBook` class and
objects.

=end