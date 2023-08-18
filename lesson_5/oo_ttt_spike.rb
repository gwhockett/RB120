require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +   # columns
                [[1, 5, 9], [3, 5, 7]]                # diagonals
  def initialize
    @squares = {}
    (1..9).each {|key| @squares[key] = Square.new}
  end

  def get_square_at(key)
    @squares[key]
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker
  end

  def no_move_keys
    @squares.keys.select{|key| @squares[key].unmarked? }
  end

  def full?
    no_move_keys.empty?
  end

  def someone_won?
    !!detect_winner
  end

  def all_human_line?(line)
    @squares.values_at(*line).map(&:marker).count(TTTGame::HUMAN_MARK) == 3
  end

  def all_computer_line?(line)
    @squares.values_at(*line).map(&:marker).count(TTTGame::COMPUTER_MARK) == 3
  end
  #returns winning marker or nil
  def detect_winner
    WINNING_LINES.each do |line|
      if all_human_line?(line)
        return TTTGame::HUMAN_MARK
      elsif all_computer_line?(line)
        return TTTGame::COMPUTER_MARK
      end
    end
    nil
  end

  def clear
    (1..9).each {|key| @squares[key].reset_square}
  end
end

class Square
  NO_MOVE = ' '
  attr_accessor :marker

  def initialize(marker=NO_MOVE)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == NO_MOVE
  end
  
  def reset_square
    self.marker = NO_MOVE
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  attr_reader :board, :human, :computer
  HUMAN_MARK = "X"
  COMPUTER_MARK = "O"

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARK)
    @computer = Player.new(COMPUTER_MARK)
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe!"
  end

  def display_board(clear = true)
    system 'clear' if clear
    puts "You are #{HUMAN_MARK}. Computer is #{COMPUTER_MARK}"
    puts ""
    puts "     |     |"
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}"
    puts "     |     |"
    puts ""
  end

  def display_result
    display_board
    case board.detect_winner
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "Tie game."
    end
  end

  def human_moves
    square = nil
    puts "Please select an open square from:"
    puts "#{board.no_move_keys.join(', ')}"
    loop do
      square = gets.chomp.to_i
      break if board.no_move_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board.set_square_at(square, human.marker)
  end

  def computer_moves
    board.set_square_at(board.no_move_keys.sample, computer.marker)
  end
  
  def play_again?
    answer = nil
    loop do
      puts "Enter 'y' to play again or 'n' to quit:"
      answer = gets.chomp.downcase
      break if answer == 'n' || answer == 'y'
    end
    answer == 'y'
  end


  def play
    system 'clear'
    display_welcome_message
    loop do
      display_board(false)
      loop do
        human_moves
        break if board.someone_won? || board.full?
        computer_moves
        break if board.someone_won? || board.full?
        display_board
      end
      display_result
      break unless play_again?
      board.clear
      system 'clear'
      puts "Let's play again!"
      puts ''
    end
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
