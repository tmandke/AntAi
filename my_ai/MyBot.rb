$:.unshift File.dirname($0)
require 'header'

ai=AI.new

ai.setup do |ai|
	# your setup code here, if any
  SuperAnt.algorithums << FoodDart.new
  SuperAnt.algorithums << RandomExplorer.new
end

ai.run do |ai|
	# your turn code here
	
	ai.map.my_ants.each do |ant|
		ant.compute_next
	end
end