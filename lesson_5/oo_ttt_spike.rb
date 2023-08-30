class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]]              # diagonals
  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def [](key)
    @squares[key].marker
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

  def line_values(line)
    @squares.values_at(*line)
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

  def line_breakdown?(line, plyr_mrk)
    line.count(plyr_mrk) == 2 && line.count(Square::NO_MOVE) == 1
  end

  def no_move_squares(line)
    line_values(line).select do |idx|
      idx.marker == Square::NO_MOVE
    end
  end

  def random_square(plyr_mrk)
    self[no_move_keys.sample] = plyr_mrk
  end

  def easy_difficulty(plyr_mrk)
    WINNING_LINES.each do |line|
      if line_breakdown?(three_mark(line), plyr_mrk)
        return no_move_squares(line).sample.marker = plyr_mrk
      end
    end
    random_square(plyr_mrk)
  end

  def medium_difficulty(plyr_mrk, other_plyr_mrk)
    WINNING_LINES.each do |line|
      if line_breakdown?(three_mark(line), other_plyr_mrk)
        return no_move_squares(line)[0].marker = plyr_mrk
      end
    end
    random_square(plyr_mrk)
  end

  def middle_square(plyr_mrk)
    return self[5] = plyr_mrk if @squares[5].unmarked?
    random_square(plyr_mrk)
  end

  def hard_defense(plyr_mrk, other_plyr_mrk)
    WINNING_LINES.each do |line|
      if line_breakdown?(three_mark(line), other_plyr_mrk)
        return no_move_squares(line)[0].marker = plyr_mrk
      end
    end
    middle_square(plyr_mrk)
  end

  def hard_difficulty(plyr_mrk, other_plyr_mrk)
    WINNING_LINES.each do |line|
      if line_breakdown?(three_mark(line), plyr_mrk)
        return no_move_squares(line).sample.marker = plyr_mrk
      end
    end
    hard_defense(plyr_mrk, other_plyr_mrk)
  end

  def square_id(num)
    no_move_keys.size == 9 ? num : ' '
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "             |     |"
    puts "          #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "         #{square_id(1)}   | #{square_id(2)}   | #{square_id(3)}"
    puts "        -----+-----+-----"
    puts "             |     |"
    puts "          #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "         #{square_id(4)}   | #{square_id(5)}   | #{square_id(6)}"
    puts "        -----+-----+-----"
    puts "             |     |"
    puts "          #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "         #{square_id(7)}   | #{square_id(8)}   | #{square_id(9)}"
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
  attr_accessor :marker, :name
end

class TTTGame
  FIRST  = 'first'
  SECOND = 'second'
  EASY   = '  :-/  ...meh'
  MEDIUM = '  ;-|  ...hmmm'
  HARD   = '  >%-{}  ...@#$^!'

  attr_reader :board, :human, :computer
  attr_accessor :order_choice, :match_score, :difficulty

  def initialize
    @board = Board.new
    @human = Player.new
    @computer = Player.new
    @match_score = { human: 0, computer: 0 }
  end

  private

  def clear
    system 'clear'
  end

  def computer_name
    computer.name = ['ChatGPT', 'HAL 9000', 'Ava', 'The Borg', 'Watson'].sample
  end

  def choose_players_names
    loop do
      puts "Enter your playing name:"
      human.name = gets.chomp
      break if human.name.strip != ''
      puts "You must enter at least a single character name!"
    end
    computer_name
    puts "You will be playing against #{computer.name}."
  end

  def computer_mark(human_mark)
    case human_mark
    when 'X'
      computer.marker = 'O'
    when 'O'
      computer.marker = 'X'
    end
  end

  def choose_players_marks
    loop do
      puts "Would you like to be 'X' or 'O'?"
      human.marker = gets.chomp.upcase
      break if human.marker == 'X' || human.marker == 'O'
      puts "You must enter 'X' or 'O'!"
    end
    computer_mark(human.marker)
  end

  def assign_first_to_move(turn)
    case turn
    when '1'
      self.order_choice = FIRST
    when '2'
      self.order_choice = SECOND
    when '3'
      self.order_choice = [FIRST, SECOND].sample
      puts "OK, you will go #{order_choice}."
    end
  end

  def choose_first_to_move
    turn = nil
    loop do
      puts "Who goes first? You or #{computer.name}?"
      puts "Enter '1' to make the first move or '2' to go second."
      puts "Enter '3' if you would like #{computer.name} to choose."
      turn = gets.chomp
      break if turn == '1' || turn == '2' || turn == '3'
      puts "You must enter '1', '2', or '3'!"
    end
    assign_first_to_move(turn)
  end

  def assign_difficulty(level)
    difficulties = [EASY, MEDIUM, HARD]
    self.difficulty = difficulties[level - 1]
  end

  def choose_difficulty
    level = nil
    loop do
      puts "How difficult should #{computer.name} play against you?"
      puts "Enter '1' for easy, '2' for medium and '3' for hard."
      level = gets.chomp.to_i
      break if level == 1 || level == 2 || level == 3
      puts "You must enter '1', '2', or '3'!"
    end
    assign_difficulty(level)
  end

  def match_parameter_choices
    choose_players_names
    puts ''
    choose_players_marks
    puts ''
    choose_first_to_move
    puts ''
    choose_difficulty
    clear
  end

  def welcome_message
    puts "Welcome to Tic Tac Toe!"
  end

  def goodbye_message
    puts "Thanks for playing Tic Tac Toe, #{human.name}!"
  end

  def mark_info
    puts ''
    puts "#{human.name} is #{human.marker}."
    puts "#{computer.name} is #{computer.marker}."
    puts ''
  end

  def match_info
    puts "First to win 5 games wins the match!"
    puts ''
    puts "Difficulty is set to: #{difficulty}"
    puts ''
    puts "#{human.name}'s score: #{match_score[:human]}"
    puts "#{computer.name}'s score: #{match_score[:computer]}"
    puts ''
  end

  def display_board
    match_info
    board.draw
    mark_info
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def game_result_message
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker
      puts "#{human.name} won the game!"
    when computer.marker
      puts "#{computer.name} won the game!"
    else
      puts "Tie game. No score."
    end
  end

  def joinor(arr, separator= ', ', conjunction= 'or')
    return arr.last if arr.size == 1
    arr2 = arr - [arr.last]
    arr2.join(separator) + " #{conjunction} #{arr.last}"
  end

  def human_moves
    square = nil
    puts "Please select an open square from:"
    puts joinor(board.no_move_keys)
    loop do
      square = gets.chomp.to_i
      break if board.no_move_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = human.marker
  end

  def computer_moves
    case difficulty
    when EASY
      board.easy_difficulty(computer.marker)
    when MEDIUM
      board.medium_difficulty(computer.marker, human.marker)
    when HARD
      board.hard_difficulty(computer.marker, human.marker)
    end
  end

  def first_player_turn?
    return true if board.no_move_keys.size.odd?
    false
  end

  def human_turn?
    (first_player_turn? && order_choice == FIRST) ||
      (!first_player_turn? && order_choice == SECOND)
  end

  def current_player_moves
    return human_moves if human_turn?
    computer_moves
  end

  def game_reset_message
    puts ''
    puts "Let's play again!"
    puts "Press 'enter' to continue."
    gets
  end

  def game_reset
    board.reset_squares
    clear
  end

  def match_again?
    answer = nil
    loop do
      puts "Enter 'y' to play another match or 'n' to quit:"
      answer = gets.chomp.downcase
      break if answer == 'n' || answer == 'y'
    end
    answer == 'y'
  end

  def score_counter
    if board.winning_marker == human.marker
      match_score[:human] += 1
    elsif board.winning_marker == computer.marker
      match_score[:computer] += 1
    end
  end

  def score_five?
    match_score[:human] == 5 || match_score[:computer] == 5
  end

  def match_result_message
    puts ''
    if match_score[:human] == 5
      puts "#{human.name} won the match!"
    elsif match_score[:computer] == 5
      puts "#{computer.name} won the match!"
    end
  end

  def match_reset
    match_score[:human] = 0
    match_score[:computer] = 0
    game_reset
  end

  public

  def player_moves_loop
    loop do
      current_player_moves
      score_counter
      clear_screen_and_display_board
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if first_player_turn?
    end
  end

  def game_loop
    loop do
      display_board
      player_moves_loop
      game_result_message
      break if score_five?
      game_reset_message
      game_reset
    end
  end

  def match_loop
    loop do
      game_loop
      match_result_message
      break unless match_again?
      match_reset
    end
  end

  def play
    clear
    welcome_message
    match_parameter_choices
    match_loop
    goodbye_message
  end
end

game = TTTGame.new
game.play
