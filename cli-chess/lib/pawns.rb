require_relative 'helper'
class Pawn

  NOTATION = ['♙', '♟']

  include Helpers

  def initialize(location, color)
    @location = location
    @color = color
    if @color == 'white'
      @symbol = NOTATION[0]
    else
      @symbol = NOTATION[1]
    end
    @move_number = 0
    @possible_moves = Array.new
    @attacks = Array.new
  end

  attr_reader :symbol, :location, :attacks, :possible_moves, :color

  def gen_possible_moves
    @possible_moves = Array.new
    if @symbol == '♙'
      if @move_number == 0
        @possible_moves << [@location[0]-2,@location[1]]
      end
      @possible_moves << [@location[0]-1,@location[1]]
    else
      if @move_number == 0
        @possible_moves << [@location[0]+2,@location[1]]
      end
      @possible_moves << [@location[0]+1,@location[1]]
    end
  end

  def move(to, board)
    gen_possible_moves
    @attacks = Helpers.attacking_positions(@possible_moves, board, @color)
    @possible_moves = Helpers.clear_possible_moves(@possible_moves, board, @color)
    if @possible_moves.include?(to)
      @location = to
      @move_number += 1
      return true
    end
    return false
  end
end
