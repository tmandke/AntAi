require 'header'
# Represent a single field of the map.
class Square
	# Ant which sits on this square, or nil. The ant may be dead.	 
	attr_accessor :visit_freshness
	attr_reader :ant
	def ant=(val)
		@ant.alive = false if @ant && val == nil
		@ant = val
		@visit_freshness = @ant ? MAX_FRESHNESS : (@visit_freshness > 0 ? @visit_freshness - 1  : 0)
	end
	# Which row this square belongs to.
	attr_accessor :row
	# Which column this square belongs to.
	attr_accessor :col

	attr_accessor :water, :food, :hill, :ai

	def initialize water, food, hill, ant, row, col, ai
		@water, @food, @hill, @ant, @row, @col, @ai = water, food, hill, ant, row, col, ai
		@visit_freshness = 0
	end

	# Returns true if this square is not water. Square is passable if it's not water, it doesn't contain alive ants and it doesn't contain food.
	def land?; !@water; end
	# Returns true if this square is water.
	def water?; @water; end
	# Returns true if this square contains food.
	def food?; @food; end
	# Returns owner number if this square is a hill, false if not
	def hill?; @hill; end
	# Returns true if this square has an alive ant.
	def ant?; @ant and @ant.alive?; end;

	def freshness
		water? ? MAX_FRESHNESS : @visit_freshness
	end
	# Returns a square neighboring this one in given direction.
	def neighbor direction
		direction=direction.to_s.upcase.to_sym # canonical: :N, :E, :S, :W

		case direction
		when :N
			row, col = @ai.normalize @row-1, @col
		when :E
			row, col = @ai.normalize @row, @col+1
		when :S
			row, col = @ai.normalize @row+1, @col
		when :W
			row, col = @ai.normalize @row, @col-1
		else
			raise 'incorrect direction'
		end

		return @ai.map[row][col]
	end
	def to_str
		"Square row = #{row}, col = #{col}"
	end
end