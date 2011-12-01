require 'header'

class Field
	# Map, as an array of arrays.
	attr_accessor :map, :rows, :cols, :ai, :my_ants, :food, :hills, :enemy_ants

  def initialize rows, cols, ai
    @rows, @cols, @ai = rows, cols, ai
    @map=Array.new(@rows){|row| 
      Array.new(@cols){|col| 
        Square.new false, false, false, nil, row, col, @ai 
        } }

    @my_ants=[]
    @food=[]
    @hills=[]
    @enemy_ants=[]
    @turn = 0
  end

  def new_turn turn
    @turn = turn
    @enemy_ants=[]
    @food=[]
    @map.each{|row| row.each{|sq| 
      sq.food = false
      sq.ant = nil
      sq.hill = false}}
  end

  def cleanup
    size = @my_ants.length
    @my_ants.select!{|ant| ant.alive?}
    $stderr.puts "turn #{@turn}: ants dead: #{size - @my_ants.size}"
  end

  def update_map row, col, type, owner
    ret = true
    case type
    when 'w'
      @map[row][col].water=true
    when 'f'
      @map[row][col].food=true
      @food << @map[row][col]
    when 'h'
      @map[row][col].hill=owner
      @hills << @map[row][col]
    when 'a'

      if owner==0
        current_ant = @my_ants.select{|ant|
          ant.is_me? @map[row][col]
        }
        if current_ant.length == 0
          a = SuperAnt.new true, owner, @map[row][col], @ai
          @my_ants.push a
        end
      else
        a=Ant.new true, owner, @map[row][col], @ai
        @enemy_ants.push a
      end
    when 'd'
      d=Ant.new false, owner, @map[row][col], @ai
      @map[row][col].ant = d
    when 'r'
      # pass
    else
      ret = false
    end
    ret
  end

  def [] (i)
    @map[i]
  end
end