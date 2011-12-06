require 'square'

class SuperSquare < Square
  attr_accessor :pathList

  def has_path to
    @pathList = [] if @pathList.nil?
    r = ret = nil
    @pathList.each{|e| 
      ret = e if (e[:to].row == to.row && e[:to].col == to.col)
      break if ret
    }

    r = ret if ret && !neighbor(ret[:dir]).occupied?
    @pathList.delete(ret) if r.nil? && !ret.nil?
    return r
  end

  def add_path maxDist, dir
    @pathList = [] if @pathList.nil?    
    @element[:dist] = maxDist - @element[:G]
    @element[:dir] = dir
    @pathList << @element
  end

  attr_accessor :element
  @element = nil

  def clear
    @element = nil
  end

  def add_element e
    if @element.nil? && !occupied?
      e[:F] = e[:G] + distance(e[:to])
      @element = e
      true
    else
      false
    end
  end

  def distance sq
    y, x = sq.row - @row, sq.col - @col
    x += ai.cols if x < -SEARCH_RADIUS 
    x -= ai.cols if x >  SEARCH_RADIUS 
    y += ai.rows if y < -SEARCH_RADIUS 
    y -= ai.rows if y >  SEARCH_RADIUS
    return x.abs+y.abs 
  end
end