require 'ai'

class Logger
  @@ai = nil

  def self.ai= ai
    @@ai = ai
  end

  def self.debug str
    $stderr.printf "[Turn %5d] %s\n", @@ai.turn_number, str
  end
end
