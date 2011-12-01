require 'header'

class RandomExplorer < Algorithum
  def compute_next ant
    rand_max = 0
    weights = {}
    [:N, :S, :E, :W].each do |dir|
      weight = MAX_FRESHNESS
      weight -= ant.square.neighbor(dir).freshness
      rand_max += weight
      weights[dir] = weight
    end

    # should always happen
    if rand_max > 0
      r = Random.rand(rand_max)
      weights.each{ |dir, weight|
        if r <= weight
          ant.order dir
          ant.expected_square = ant.square.neighbor(dir)
          break
        end
        r -= weight
      }
    else
      ant.expected_square = ant.square
    end
    ant.expected_square.visit_freshness = MAX_FRESHNESS
    true
  end
end