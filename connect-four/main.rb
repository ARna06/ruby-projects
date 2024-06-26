# frozen_string_literal: true

require './lib/logics'

print "This is a simple implementation of connect four in ruby. \n"
print "The columns are designated from 1 to 7. Put the column you want want to put the ball.\n"
print "Write 'exit' to exit the game.\n"
game = Game.new
game.make_board
while game.win_checker == false
  print "Enter player #{(game.turn % 2) + 1} move :"
  entry = gets.chomp!
  if entry == 'exit'
    print "You have successfully exited the game!\n"
    break
  end
  game.get_moves(entry.to_i)
  game.make_board
end

print "Player #{((game.turn - 1) % 2) + 1} wins! \n" if game.win_checker == true
