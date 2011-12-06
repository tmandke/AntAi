require 'header'

class SuperAnt < Ant
  attr_accessor :expected_square, :ordered

  @@algorithums = []
  def self.algorithums
    @@algorithums
  end

  def initialize alive, owner, square, ai
    super alive, owner, square, ai
    ordered = false
  end

  def is_me? pos
    if @expected_square && @expected_square.row == pos.row && @expected_square.col == pos.col
      @square = pos
      @square.ant = self
      @alive = true
      true
    else
      false 
    end
  end

  def compute_next
    @@algorithums.each{|algo|
      ret = algo.compute_next self
      #Logger.debug "#{algo.class.name} = #{ret}"
      break if ret
    } unless ordered
  end

  def order direction
    @expected_square = direction == :stay ? @square : @square.neighbor(direction)
    Logger.debug("Going onto a square where there is some one #{ant.expected_square.to_str}") if !direction == :stay && ant.expected_square && ant.expected_square.occupied?
    @expected_square.expect_ant
    super direction unless direction == :stay
  end
end