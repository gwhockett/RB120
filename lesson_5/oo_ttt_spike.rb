class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]]              # diagonals
  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def no_move_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    no_move_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def three_mark(line)
    @squares.values_at(*line).map(&:marker)
  end

  def winning_line?(line)
    three_mark(line).uniq.size == 1 && !@squares[line[0]].unmarked?
  end

  # returns winning marker or nil

  def winning_marker
    WINNING_LINES.each do |line|
      return @squares[line[0]].marker if winning_line?(line)
    end
    nil
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def reset_squares
    (1..9).each { |key| @squares[key] = Square.new }
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
  FIRST_TO_MOVE = HUMAN_MARK
  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARK)
    @computer = Player.new(COMPUTER_MARK)
    @current_marker = FIRST_TO_MOVE
  end

  private

  def clear
    system 'clear'
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe!"
  end

  def display_board
    puts "You are #{HUMAN_MARK}. Computer is #{COMPUTER_MARK}"
    puts ""
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
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
    puts board.no_move_keys.join(', ')
    loop do
      square = gets.chomp.to_i
      break if board.no_move_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    board[board.no_move_keys.sample] = computer.marker
  end

  def human_turn?
    return true if board.no_move_keys.size.odd?

    false
  end

  def current_player_moves
    return human_moves if human_turn?

    computer_moves
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

  def display_reset_message
    puts "Let's play again!"
    puts ''
  end

  def reset
    board.reset_squares
    clear
  end

  public

  def player_moves_loop
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def game_loop
    loop do
      display_board
      player_moves_loop
      display_result
      break unless play_again?
      reset
      display_reset_message
    end
  end

  def play
    clear
    display_welcome_message
    game_loop
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
