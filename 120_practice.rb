class Person
  attr_reader :name
  
  def set_name
    @name = 'Bob'
  end
end

bob = Person.new
p bob.name

=begin
 Class `Person` objects do not initialize an `@name` instance variable unless the
instance method `set_name` is called by an object of the `Person` class. The
`Person` object `Bob` on line 10 calls the getter method `name` without a prior call
of `set_name`. Since uninitalized instance variables return `nil`, `nil` is output.