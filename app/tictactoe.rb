# frozen_string_literal: true

require 'pry'
require_relative 'mylogger'

class Tictactoe
  class InvalidInput < StandardError
  end

  def initialize
    @board = [[' ', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']]
    @moves = 9
    @winner = nil
  end

  def logger
    @logger ||= Mylogger.new('TicTacToe')
  end

  def print
    puts printable_board
    logger.log('printed board')
  end

  def result
    if @winner.nil?
      'no winner.'
    else
      "the winner is #{@winner}!"
    end
  end

  def try_move(x, y)
    mark(translate_x(x), translate_y(y), @moves % 2 == 0 ? 'O' : 'X')
    @moves -= 1
    logger.log("Move ok to coordinates #{x}, #{y} ok, moves left #{@moves}")
    true
  rescue InvalidInput => e
    logger.log e.message
    false
  end

  def mark(x, y, mark)
    raise InvalidInput, 'square already taken.' unless @board[x][y] == ' '
    @board[x][y] = mark
  end

  def translate_x(x)
    unless %w[1 2 3].include?(x)
      raise InvalidInput, "Invalid x value: #{x} for horizontal axis"
    end

    x.to_i - 1
  end

  def translate_y(y)
    unless %w[a b c].include?(y)
      raise InvalidInput, "Invalid y value: #{y} for vertical axis"
    end

    case y
    when 'a'
      0
    when 'b'
      1
    when 'c'
      2
    end
  end

  def clear
    @board = [[' ', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']]
  end

  def printable_board
    board = []
    board << '*********'
    board << "  a|b|c\n\n"

    @board.each_with_index do |r, i|
      board << "#{i+1} #{r[0]}|#{r[1]}|#{r[2]}"
      board << '  -----' unless i == 2
    end
    board
  end

  def over?
    if hz_win? || vr_win? || cr_win?
      logger.log("We have a winner, board at end #{@board.to_s}")
      return true
    elsif moves_left == 0
      logger.log("Game over out of moves, board at end #{@board.to_s}")
      return true
    end
    false
  end

  def moves_left
    @moves
  end

  def cr_win?
    arr1, arr2 = [],[]
    3.times { |i| arr1 << @board[i][i] }
    3.times { |i| arr2 << @board[i][2-i] }
    return false unless line_of_three?([arr1, arr2])
    logger.log 'cr_win'
    true
  end

  def hz_win?
    return false unless line_of_three?(@board)
    logger.log 'hz_win'
    true
  end

  def vr_win?
    return false unless line_of_three?(twisted_board)
    logger.log 'vr_win'
    true
  end

  def twisted_board
    [@board.map { |k| k[0] }, @board.map { |k| k[1] }, @board.map { |k| k[2] }]
  end

  def line_of_three?(arr)
    win = false
    arr.each do |val|
      next if val.include?(' ')

      if val[0] == val[1] && val[1] == val[2]
        win = true
        @winner = val[0]
        break
      end
    end
    win
  end
end
