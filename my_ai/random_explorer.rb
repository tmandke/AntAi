require 'header'

class RandomExplorer < Algorithum
  def compute_next ant
    rand_max = 0
    weights = {}
    [:N, :S, :E, :W].each do |dir|
      b = ant.square.neighbor(dir)
      if b.food?
        rand_max = 0
        break
      end
      weight = MAX_FRESHNESS
      weight -= b.freshness
      rand_max += weight
      weights[dir] = weight
    end

    # should always happen
    if rand_max > 0
      r = Random.rand(rand_max)
      weights.each{ |dir, weight|
        if r < weight
          ant.order dir
          break
        end
        r -= weight
        Logger.debug("Going onto a square where there is some one #{ant.expected_square.to_str}") if ant.expected_square && ant.expected_square.occupied?
      }
    else
      ant.order :stay
    end
    true
  end
end