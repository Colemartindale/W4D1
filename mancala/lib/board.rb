class Board
  attr_accessor :cups


  def initialize(name1, name2)
    @cups = Array.new(14) { Array.new(4, :stone) }
    @cups[6] = []
    @cups[13] = []
    @name1 = name1
    @name2 = name2
  end

  def side(name)
    name == @name1 ? 6 : 13
  end
 
  def valid_move?(start_pos)
    if start_pos.between?(0, 5) == false && start_pos.between?(7, 12) == false
      raise 'Invalid starting cup'
    elsif @cups[start_pos].empty?
      raise 'Starting cup is empty'
    end
    
  end

  def make_move(start_pos, current_player_name)
    arr = @cups[start_pos]
    @cups[start_pos] = []
    i = start_pos + 1
    until arr.empty?
      i = i % 14
      if i == 6 || i == 13
        if current_player_name == @name1 && i == 6
          @cups[i] << arr.shift
        elsif current_player_name == @name2 && i == 13
          @cups[i] << arr.shift
        end
      else
        @cups[i] << arr.shift
      end
      i += 1
    end
    render
    next_turn(i) 
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if @cups[ending_cup_idx].empty?
      return :switch
    elsif side == 6 && ending_cup_idx == 6 || side == 13 && ending_cup_idx == 13
      return :prompt
    else
      return ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
  end

  def winner
  end
end
