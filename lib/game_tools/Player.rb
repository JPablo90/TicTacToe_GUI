module Player
  class Player
    attr_accessor :winner, :label, :turn
    
    def initialize(label)
      @winner = false
      @label = label
      @turn = false
    end
  end
end