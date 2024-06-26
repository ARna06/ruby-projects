# frozen_string_literal: true

require_relative 'helper'
require_relative 'logics'
class Pawn
  NOTATION = ['♙', '♟'].freeze

  include Helpers
  include Pawn_specials

  def initialize(location, color)
    @location = location
    @color = color
    @symbol = if @color == 'white'
                NOTATION[0]
              else
                NOTATION[1]
              end
    @move_number = 0
    @possible_moves = []
    @attacks = []
  end

  attr_reader :symbol, :attacks, :possible_moves, :color
  attr_accessor :location

  def gen_possible_moves
    @possible_moves = []
    if @symbol == '♙'
      @possible_moves << [@location[0] - 2, @location[1]] if @move_number.zero? && [*0..7].include?(@location[0] - 2)
      @possible_moves << [@location[0] - 1, @location[1]] if [*0..7].include?(@location[0] - 1)
    else
      @possible_moves << [@location[0] + 2, @location[1]] if @move_number.zero? && [*0..7].include?(@location[0] + 2)
      @possible_moves << [@location[0] + 1, @location[1]] if [*0..7].include?(@location[0] + 1)
    end
  end

  def update(board)
    gen_possible_moves
    @attacks = Pawn_specials.attacks(@location, board, @color)
    @possible_moves.select! { |to| board[to[0]][to[1]].nil? }
    @possible_moves = Helpers.clear_possible_moves(@possible_moves, board, @color)
  end

  def move(to)
    if @possible_moves.include?(to) ^ @attacks.include?(to)
      @location = to
      @move_number += 1
      return true
    end
    false
  end
end
