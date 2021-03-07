# frozen_string_literal: true

require_relative '../app/tictactoe'

def play_round(game)
  while !game.over?
    while true 
      val = gets.chomp
      break if game.try_move(val[0], val[1])
      break if game.try_move(val[1], val[0])
      puts "Invalid input #{val}, give coordinates with number 1-3 and char a-c for a free square"
    end
    game.print
  end
  puts "\n\ngame over, this round #{game.result}\n\n"
end

puts 'Hello and welcome to play TicTacToe'

while true
  puts 'New round starting: place your marker by giving char number 1-3 for horizontal and char a,b,c for vertical line, e.g. 1a'
  tt = Tictactoe.new
  tt.print
  play_round(tt)
end