require 'header'

class SuperAnt < Ant
  attr_accessor :expected_square
  @@algorithums = []
  def self.algorithums
    @@algorithums
  end

  def initialize alive, owner, square, ai
    super alive, owner, square, ai
  end

  def is_me? pos
    if @expected_square == pos
      @square = pos
      @square.ant = self
      true
    else
      false 
    end
  end

  def compute_next
    @@algorithums.each{|algo|
      break if algo.compute_next self
    }
  end
end