# Constant variables scope and inheritance
TOP_LEVEL = "top-level's constant"

module Othello
  OTHELLO = "Othello's constant"

  def othello_constant
    OTHELLO
  end

  class Cassio
    CASSIO = "Cassio's constant"

    def cassio_othello_constant
      OTHELLO
    end

    def cassio_top_level_constant
      TOP_LEVEL
    end
  end
end

class Lago
  LAGO = "Lago's constant"

  def self.lago_constant
    LAGO
  end

  def lago_constant
    LAGO
  end

  def lago_top_level_constant
    TOP_LEVEL
  end

  def othello_namespace_constant
    Othello::OTHELLO
  end

  def cassio_namespace_constant
    Othello::Cassio::CASSIO
  end

  def bianca_namespace_constant
    Bianca::BIANCA
  end
end

class Bianca < Lago
  BIANCA = "Bianca's constant"
  include Othello
end

p "Constants can be directly referenced from the scope of class method or instance method."
puts Lago.lago_constant 
puts Lago.new.lago_constant
puts Lago.new.lago_top_level_constant
puts ''

p "Classes can inherit methods that access a constant."
p "`Bianca` is a subclass of `Lago` and has the module `Othello` mixed-in."
puts Bianca.lago_constant
puts Bianca.new.lago_constant
puts Bianca.new.othello_constant
puts Bianca.new.lago_top_level_constant
puts ''

p "Objects of namespaced classes can reference constants from a method that are lexically available,"
p "as well as top-level constants."
puts Othello::Cassio.new.cassio_othello_constant
puts Othello::Cassio.new.cassio_top_level_constant
puts ''

p "The namespace resolution operator can be used to reference constants of a lexical scope."
puts Lago.new.othello_namespace_constant
puts Lago.new.cassio_namespace_constant
puts Lago.new.bianca_namespace_constant
puts Lago::LAGO
puts ''

p "The namespace resolution operator can be used to reference a constant found along the method"
p "lookup path of the lexical scope it searches."
puts Bianca::LAGO
puts Bianca::OTHELLO
puts ''

p "However the namespace resolution operator can't reference a constant that is outside of"
p "the lexical scope it searches."
puts Othello::TOP_LEVEL #...uninitialized constant Othello::TOP_LEVEL (NameError)
puts Bianca::TOP_LEVEL #...uninitialized constant Bianca::TOP_LEVEL (NameError)
puts Lago::TOP_LEVEL #...uninitialized constant Lago::TOP_LEVEL (NameError)