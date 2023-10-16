class Player
  def initialize
  end

  def hit
  end

  def stay
  end

  def busted?
  end

  def total
  end
end

class Dealer
  def initialize
  end

  def deal
  end

  def hit
  end

  def stay
  end

  def busted?
  end

  def total
  end
end

class Participant

end

class Card
  include Comparable
  attr_reader :rank, :suit

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    VALUES.fetch(rank, rank)
  end

  def <=>(other_card)
    value <=> other_card.value
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    populate_deck
  end

  def draw
    populate_deck if @deck_of_cards.size == 0
    @deck_of_cards.pop
  end

  def size
    @deck_of_cards.size
  end

  private

  def populate_deck
    @deck_of_cards = []
    RANKS.each do |rank|
      SUITS.each do |suit|
        @deck_of_cards << Card.new(rank, suit)
      end
    end
    @deck_of_cards.shuffle!
  end
end
