require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    opponent = (evaluator == :x ? :o : :x)
    if board.over? 
      return true if board.winner == opponent
      return false 
    elsif next_mover_mark == evaluator
      self.children.all? { |child| child.losing_node?(evaluator) }
    else
      self.children.any? { |child| child.losing_node?(evaluator) }
    end
  end
  
  def winning_node?(evaluator)
    opponent = (evaluator == :x ? :o : :x)
    if board.over? 
      return true if board.winner == evaluator
      return false 
    elsif next_mover_mark != evaluator
      self.children.all? { |child| child.winning_node?(evaluator) }
    else
      self.children.any? { |child| child.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    all_moves = []
    (0..2).each do |idx|
      (0..2).each do |jdx|
        pos = [idx, jdx]
        
        if board.empty?(pos)

          dup_board = board.dup
          dup_board[pos] = self.next_mover_mark

          next_mover_mark = (self.next_mover_mark == :x ? :o : :x)
          all_moves << TicTacToeNode.new(dup_board, next_mover_mark, pos)
        end
      end
    end
    all_moves
  end

end
