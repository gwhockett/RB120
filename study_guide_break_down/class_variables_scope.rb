#class variables and their scope
class Foo
  @@instantiations = 0

  def initialize
    @@instantiations += 1
   end

  def self.instantiations
    @@instantiations
  end
end

class Bar < Foo
end

puts Foo.instantiations
# We get the expected output of `0`
Foo.new
puts Foo.instantiations
# A `Foo` object has been created so we get the expected output of `1`.
Bar.new
puts Bar.instantiations
puts Foo.instantiations
# We get the output of `2` for both `Foo` and `Bar` even though we have only created one `Bar` and one `Foo` object.
# Since `Bar` is subclassed from `Foo` and share a single class variable, `@@instantiations`, the output is given via class variable scoping.