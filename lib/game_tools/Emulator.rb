require "game_tools/CheckRules"
require "game_tools/Board"
require "game_tools/Player"

module Emulator  
  class Emulator
    MIN_BOARD_SIZE = 3
    MAX_BOARD_SIZE = 15

    attr_reader :board, :player1, :player2

    def initialize
      @board = nil
      @player1 = Player::Player.new('X')
      @player2 = Player::Player.new('O')
    end

    def start_game
      who_start = 0
      board_size = 0
      check_rules = CheckRules::CheckRules.new
      playing = true
      while playing
        board_size = define_board_size
        board = Board::Board.new(board_size)
        display_board
        play(who_start, check_rules, board_size)
        winner_is
        playing = play_again?
        who_start += 1
      end
    end
    
    private

    def play(who_start, check_rules, board_size)
      while player1.winner == false and player2.winner == false and check_rules.tie?(board.board) == false
        change_turns_players(who_start)
        put_tap
        player1.winner = check_rules.winner?(board.board, player1.label, board_size)
        player2.winner = check_rules.winner?(board.board, player2.label, board_size)
        reload
      end
    end
    
    def winner_is
      if player1.winner
        puts "The winner is the Player 1."
        player1.winner = false
      elsif player2.winner
        puts "The winner is the Player 2."
        player2.winner = false
      else
        puts "Draw."
      end
      puts "____________________________________"
    end

    def play_again?
      play = nil
      puts "Would you like to play again?, yes press y, no press any key: "
      play = $stdin.gets.chomp
      play.downcase!
      return true if play == 'y'
      false
    end
    
    def put_tap
      position = 0
      if player1.turn
        puts "Player 1 turn, choose a empty cell in the board : "
        position = gets.chomp.to_i
        find_correct_position(position, Player1)
      else
        puts "Player 2 turn, choose a empty cell in the board : "
        position = gets.chomp.to_i
        find_correct_position(position, Player2)
      end
    end

    def find_correct_position(position, player)
      until board.add_value(position, player.label)
        puts "The cell is not available or does not exist, choose a valid cell: "
        position = gets.chop.to_i
      end
    end
    
    def define_board_size
      board_size = 3
      puts "Type the size of your board, the board is square and the munimum " +
      "size should be greater than or equal to 3 and less than or equal to 15: "
      board_size = gets.chomp.to_i
      while board_size < MIN_BOARD_SIZE or board_size > MAX_BOARD_SIZE
        puts "choose an appropriate value for the size of the board:"
        board_size = gets.chomp.to_i
      end
      board_size
    end
    
    def change_turns_players(who_start)
      if player1.turn
        player1.turn = false
        player2.turn = true
      elsif player2.turn
        player1.turn = true
        player2.turn = false
      else
        start_after_tie(who_start)
      end 
    end

    def start_after_tie(who_start)
      if who_start%2 == 0
        player1.turn  = true
      else
        player2.turn = true
      end
    end
    
    def display_board
      puts board.board.map {|item| item.join("\t")}
      puts "____________________________________"
    end
    
    def reload
      system("clear")
      display_board
    end
  end
end
