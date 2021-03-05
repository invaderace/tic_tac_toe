# frozen_string_literal: true

require 'pry'

# This makes the board. That's all.
class Board
  ROW1 = [0, 1, 2].freeze
  ROW2 = [3, 4, 5].freeze
  ROW3 = [6, 7, 8].freeze
  COLUMN1 = [0, 3, 6].freeze
  COLUMN2 = [1, 4, 7].freeze
  COLUMN3 = [2, 5, 8].freeze
  DIAGONAL_UP = [2, 4, 6].freeze
  DIAGONAL_DOWN = [0, 4, 8].freeze
  ROWS = [ROW1, ROW2, ROW3, COLUMN1, COLUMN2, COLUMN3, DIAGONAL_UP, DIAGONAL_DOWN]

  attr_accessor :board, :xs, :os, :full

  def initialize(board = [1, 2, 3, 4, 5, 6, 7, 8, 9])
    @board = board
    @xs = []
    @os = []
    @full = false
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts '---+---+---'
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts '---+---+---'
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def three_in_row?
    # true if row? || column? || diagonal?
    result = false
    ROWS.each do |row|
      result = true if row.all? { |i| @xs.include? i } || row.all? { |i| @os.include? i }
    end
    result
  end

  def check_tokens
    check_xs
    check_os
    check_full
  end

  def check_xs
    @board.each_with_index { |value, index| @xs.push(index) if value == 'x' }
  end

  def check_os
    @board.each_with_index { |value, index| @os.push(index) if value == 'o' }
  end

  def row?
    true if row1? || row2? || row3?
  end

  def column?
    true if column1? || column2? || column3?
  end

  def diagonal?
    true if diagonal_up? || diagonal_down?
  end

  def reset_tokens
    xs.clear
    os.clear
  end

  def check_full
    x_and_o = %w[x o]
    count = 0
    @board.each do |i|
      count += 1 if x_and_o.include? i # count up to 9 spaces
      @full = true if count == 9
    end
  end
end
