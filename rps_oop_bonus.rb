class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def rock_win?(other_move)
    (rock? && other_move.scissors?) ||
      (rock? && other_move.lizard?)
  end

  def paper_win?(other_move)
    (paper? && other_move.rock?) ||
      (paper? && other_move.spock?)
  end

  def scissors_win?(other_move)
    (scissors? && other_move.paper?) ||
      (scissors? && other_move.lizard?)
  end

  def lizard_win?(other_move)
    (lizard? && other_move.spock?) ||
      (lizard? && other_move.paper?)
  end

  def spock_win?(other_move)
    (spock? && other_move.rock?) ||
      (spock? && other_move.scissors?)
  end

  def rock_lose?(other_move)
    (rock? && other_move.paper?) ||
      (rock? && other_move.spock?)
  end

  def paper_lose?(other_move)
    (paper? && other_move.scissors?) ||
      (paper? && other_move.lizard?)
  end

  def scissors_lose?(other_move)
    (scissors? && other_move.rock?) ||
      (scissors? && other_move.spock?)
  end

  def lizard_lose?(other_move)
    (lizard? && other_move.rock?) ||
      (lizard? && other_move.scissors?)
  end

  def spock_lose?(other_move)
    (spock? && other_move.paper?) ||
      (spock? && other_move.lizard?)
  end

  def >(other_move)
    rock_win?(other_move) ||
      paper_win?(other_move) ||
      scissors_win?(other_move) ||
      lizard_win?(other_move) ||
      spock_win?(other_move)
  end

  def <(other_move)
    rock_lose?(other_move) ||
      paper_lose?(other_move) ||
      scissors_lose?(other_move) ||
      lizard_lose?(other_move) ||
      spock_lose?(other_move)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name
  attr_reader :score

  def initialize
    @name = set_name
    @score = 0
  end

  def win
    @score += 1
  end
end

class Human < Player
  def set_name
    puts "Please enter the human player's name:"
    gets.chomp
  end

  def choose
    choice = nil
    loop do
      puts "", "Please choose rock, paper, scissors, lizard or spock:"
      choice = gets.chomp.downcase
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice.", ""
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    ['R2D2', 'HAL', 'Chappie', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
    puts "First player to score 10 points, wins the match!", ""
  end

  def initialize
    display_welcome_message
    @human = Human.new
    @computer = Computer.new
  end

  def display_move
    puts "", "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}.", ""
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} scores the point!", ""
    elsif human.move < computer.move
      puts "You lose! #{computer.name} scores the point!", ""
    else
      puts "Tie game. No score!", ""
    end
  end

  def score_keeper
    if human.move > computer.move
      human.win
    elsif human.move < computer.move
      computer.win
    end
  end

  def display_score
    score_keeper
    puts "#{human.name} has #{human.score} points."
    puts "#{computer.name} has #{computer.score} points."
  end

  def display_goodbye_message
    if human.score == 10
      puts "#{human.name} won the match!"
    else
      puts "#{computer.name} won the match!"
    end

    puts "", "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Goodbye!"
  end

  # def play_again
  #   puts "Enter 'y' to play again."
  #   gets.chomp.downcase
  # end

  def play
    loop do
      human.choose
      computer.choose
      display_move
      display_winner
      display_score
      break if human.score == 10 || computer.score == 10
    end
    display_goodbye_message
  end
end

RPSGame.new.play
