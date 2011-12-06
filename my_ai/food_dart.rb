require 'header'

class FoodDart < Algorithum
  def compute_next ant
    food = []
    nums = (-SEARCH_RADIUS..SEARCH_RADIUS).to_a
    nums.each{|r|
      nums.each{|c|
        s = ant.square.neighbour_offset(r, c)
        food << s if s.food?
      }
    }
    food_dist = []
    food.each{|f|
      path = PathLogger.find(ant.square, f)
      food_dist << path if path
    }
    
    food_dist = food_dist.sort{|a, b| 
      a[:dist] - b[:dist]
    }

    food_dist.each do |fd|
      Logger.debug "#{ant.square.to_str} -> #{fd[:to].to_str}, #{fd[:dist]}"      
    end
    food_dist.each do |fd|
      ant.order fd[:dir]
      return true
    end
    false
  end
end