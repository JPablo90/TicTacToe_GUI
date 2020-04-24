RSpec.describe CheckRules::CheckRules do
  BOARD_SIZE = 4
  ID_MAX = BOARD_SIZE**2
  checkRules = CheckRules::CheckRules.new

  def addLabelO(board)
    column = 2
    (0..BOARD_SIZE-1).each do |row|
      board[row][column] = board[row][column+1] = "O"
      column-=2 if (row % 2) == 0
      column+=2 if (row % 2) != 0
    end
  end

  def diagCorrect?(diagonal, boardDiag)
    (0..BOARD_SIZE-1).each { |column| return false if diagonal[column] != boardDiag[column] }
    return true
  end
  
  context "#winner?" do
    board =  Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, "X") }
    it "There is a winner" do
			expect(true).to eq(checkRules.winner?(board, "X", BOARD_SIZE))
		end

    it "There is not a winner" do
      expect(false).to eq(checkRules.winner?(board, "O", BOARD_SIZE))
		end
  end

  context "#tie?" do
    board =  Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, "X") }
    it "There is a not a tie" do
      board[0][2] = nil
			expect(false).to eq(checkRules.tie?(board))
		end

    it "There is a tie" do
      addLabelO(board)
      expect(true).to eq(checkRules.tie?(board))
		end
  end

  context "#checkLine" do
    line =  Array.new(BOARD_SIZE, "X")
    it "The labels on the line are the same" do
      expect(true).to eq(checkRules.send(:checkLine, line, "X"))
    end

    it "The labels on the line are not the same" do
      line[0] = "O"
      expect(false).to eq(checkRules.send(:checkLine, line, "X"))
    end
  end

  context "#winningRow?" do
    board =  Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, "X") }
    it "There is a winning row" do
      addLabelO(board)
      board[2][0] = board[2][1] = "O"
      expect(true).to eq(checkRules.send(:winningRow?, board, "O"))
    end

    it "There is not a winning row" do
      board[2][3] = "X"
      expect(false).to eq(checkRules.send(:winningRow?, board, "O"))
    end
  end

  context "#winningColumn?" do
    board =  Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, "X") }
    it "There is a winning column" do
      addLabelO(board)
      board[2][0] = board[0][0] = "O"
      expect(true).to eq(checkRules.send(:winningColumn?, board, "O"))
    end

    it "There is not a winning column" do
      board[0][0] = "X"
      expect(false).to eq(checkRules.send(:winningColumn?, board, "O"))
    end
  end

  context "#winningDiagonal?" do
    board =  Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, "X") }
    it "There is a winning diagonal" do
      addLabelO(board)
      board[1][2] = board[2][1] = "O"
      expect(true).to eq(checkRules.send(:winningDiagonal?, board, "O", BOARD_SIZE))
    end

    it "There is not a winning diagonal" do
      board[2][1] = "X"
      expect(false).to eq(checkRules.send(:winningDiagonal?, board, "O", BOARD_SIZE))
    end
  end

  context "#getRightDiag" do
    board =  Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, "X") }
    board[0][3] = board[1][2] = board[2][1] = board[3][0] = "O"
    it "The method get the right diagonal" do
      boardDiag = [board[0][3], board[1][2], board[2][1], board[3][0]]
      diagonal = checkRules.send(:getRightDiag, board, BOARD_SIZE)
      expect(true).to eq(diagCorrect?(diagonal, boardDiag))
    end
  end

  context "#getLeftDiag" do
    board =  Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, "X") }
    board[0][0] = board[1][1] = board[2][2] = board[3][3] = "O"
    it "The method get the left diagonal" do
      boardDiag = [board[0][0], board[1][1], board[2][2], board[3][3]]
      diagonal = checkRules.send(:getLeftDiag, board, BOARD_SIZE)
      expect(true).to eq(diagCorrect?(diagonal, boardDiag))
    end
  end
end
