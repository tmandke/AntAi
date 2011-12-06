require 'field'

class PathLogger
  @@map = nil

  def self.init map
    @@map = map
  end

  def self.find from, to
    path = from.has_path to

    return path if path

    openList = []
    closedList = [from]
    from.element = {:to => to, :dir => nil, :G => 0, :F => 0}
    current = from
    found = unreachable = false
    begin
      #Logger.debug "Target = #{to.to_str},Loc = #{current.to_str} G = #{current.element[:G]}, F = #{current.element[:F]}"
      n, s, e, w = current.neighbor(:N), current.neighbor(:S), current.neighbor(:E), current.neighbor(:W)
      n = nil unless n.add_element({:to => to, :dir => :N, :bdir => :S, :G => current.element[:G]+1})      
      s = nil unless s.add_element({:to => to, :dir => :S, :bdir => :N, :G => current.element[:G]+1})      
      e = nil unless e.add_element({:to => to, :dir => :E, :bdir => :W, :G => current.element[:G]+1})      
      w = nil unless w.add_element({:to => to, :dir => :W, :bdir => :E, :G => current.element[:G]+1})      
      push openList, n if n
      push openList, s if s
      push openList, e if e
      push openList, w if w

      unreachable = true if openList.length == 0
      closedList << current
      current = openList.delete_at(0)
      found = true if current && current.row == to.row && current.col == to.col
    end until found or unreachable

    ret = nil
    if found
      max_dist = current.element[:G]
      c = current
      dir = c.element[:dir]
      begin
        # go back
        c = c.neighbor c.element[:bdir]
        pdir = c.element[:dir]
        c.add_path(max_dist, dir)
        dir = pdir
      end until dir.nil?
      ret = c.element
    end
    current.clear if current
    closedList.each{|e| e.clear}
    openList.each{|e| e.clear}
    return ret
  end

  def self.push list, s
    len = list.length
    list.each_with_index{|sq, i|
      if sq.element[:F] >= s.element[:F]
        list.insert i, s
        break
      end
    }
    list << s if len == list.length
  end
end
