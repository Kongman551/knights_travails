require_relative 'knight.rb'

class Board
    attr_accessor :k
  
    def initialize
      intro
      @k = Knight.new([@xs, @ys], [@xe, @ye])
    end
  
    def intro
      valid = false
      until valid
        puts 'Enter X start (0-7): '
        @xs = gets.chomp.to_i
        puts 'Enter Y start (0-7): '
        @ys = gets.chomp.to_i
        puts 'Enter X end (0-7): '
        @xe = gets.chomp.to_i
        puts 'Enter y end (0-7): '
        @ye = gets.chomp.to_i
        valid = [@xs, @ys, @xe, @ye].all? { |x| x.between?(0,7) }
      end
    end
  
    def knight_moves
      solve_kt(@k.position, @k.destination)
    end
  
    def is_valid?(grid, moves)
      moves[0] >= 0 && moves[0] < grid.length && moves[1] >= 0 && moves[1] < grid.length && grid[moves[0]][moves[1]] == -1
    end
  
    def print_ans(start, dest, answer)
      puts "\n\nKnights Travails\n\n"
      puts "You made it in #{answer.length} moves.\n\n"
      puts "Start: #{start}"
      puts "End: #{dest}\n\n"
      puts 'Path:'
      answer.each do |x|
        if x == dest
          print x.to_s
        else
          print "#{x} => "
        end
      end
    end
  
    def solve_kt(start, dest, answer = [])
      grid = Array.new(8) { Array.new(8) { -1 } }
      moves = [[-2, 1], [-1, 2], [1, 2], [2, 1], [-2, -1], [-1, -2], [1, -2], [2, -1]]
      grid[start[0]][start[1]] = 0
  
      return 'Invalid' unless solve_kt_help(grid, start, 1, moves, dest, answer)
  
      print_ans(start, dest, answer)
    end
  
      def solve_kt_help(grid, current, num, moves, dest, answer)
      return true if current == dest
  
      (0..7).each do |i|
        next_move = [current[0] + moves[i][0], current[1] + moves[i][1]]
  
        next unless is_valid?(grid, next_move)
  
        answer << next_move
        grid[next_move[0]][next_move[1]] = num
        return true if solve_kt_help(grid, next_move, num + 1, moves, dest, answer)
  
        grid[next_move[0]][next_move[1]] = -1
      end
      false
    end
end
