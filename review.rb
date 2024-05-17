module Goodbye
  def self.goodbye
    "Goodbye"
  end
end


def hello
  include Goodbye
end

puts Goodbye