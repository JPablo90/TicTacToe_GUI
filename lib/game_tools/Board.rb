module Board
	class Board
    MIN_CELL_NUM = 1
    MIN_BOARD_SIZE = 3
		attr_reader :board

    def initialize(boardSize = MIN_BOARD_SIZE)
			@board = Array.new(boardSize) { Array.new(boardSize, nil) }
			@boardSize = boardSize
		end

		def addValue(cellNumber, labelPlayer)
			coordinateX = 0
			coordinateY = 0
			return false if cellPosWrong?(cellNumber)
			coordinateX = findCoordinateX(cellNumber)
      coordinateY = findCoordinateY(cellNumber)
      
			if  emptyCell?(coordinateY, coordinateX)
				@board[coordinateY][coordinateX] = labelPlayer
				return true
			end
			false	
		end

    private
    
    def cellPosWrong?(cellNumber)
      maxCellNum = @boardSize**2
      return true if cellNumber < MIN_CELL_NUM or cellNumber > maxCellNum
      return false
    end

		def findCoordinateX(cellNumber)
			coordinateX = 0
			mod  =  cellNumber % @boardSize
			if mod == 0
				coordinateX = @boardSize - 1
			else
				coordinateX = mod -1
			end
			coordinateX
		end

		def findCoordinateY(cellNumber)
			coordinateY = 0
			div  =  cellNumber / @boardSize
			if cellNumber % @boardSize == 0 
				coordinateY = div - 1
			else
				coordinateY = div
			end
			coordinateY
		end

		def emptyCell?(row, column)
			return true if @board[row][column] == nil
			false
		end
	end
end
