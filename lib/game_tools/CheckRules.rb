module CheckRules
  class CheckRules
    def winner?(board, playerLabel, sizeBoard)
      return true if winningRow?(board, playerLabel)
      return true if winningColumn?(board, playerLabel)
      return true if winningDiagonal?(board, playerLabel, sizeBoard)
      false
    end
    
    def tie?(board)
      board.each { |row| return false if row.any? { |item| item == nil } }
      true
    end
    
    private
    def checkLine(line, playerLabel)
      return true if line.all? { |item| item == playerLabel }
      false
    end
    
    def winningRow?(board, playerLabel)
      board.each { |row| return true if  checkLine(row, playerLabel) == true }
      false
    end
    
    def winningColumn?(board, playerLabel)
      columns = board.transpose
      columns.each { |column| return true if  checkLine(column, playerLabel) == true }
      false
    end
    
    def winningDiagonal?(board, playerLabel, sizeBoard)
      return true if checkLine(getLeftDiag(board, sizeBoard), playerLabel)
      return true if checkLine(getRightDiag(board, sizeBoard), playerLabel)
      false
    end
    
    def getLeftDiag(board, sizeBoard)
      leftDiag = Array.new(sizeBoard) { |item| item = nil }
      nCol = nRow = 0
      leftDiag.length.times{
        leftDiag[nRow] = board[nRow][nCol]
        nCol += 1
        nRow += 1
      }
      leftDiag
    end
    
    def getRightDiag(board, sizeBoard)
      rightDiag = Array.new(sizeBoard) { |item| item = nil }
      nCol = sizeBoard - 1
      nRow = 0
      rightDiag.length.times{
        rightDiag[nRow] = board[nRow][nCol]
        nCol -= 1
        nRow += 1
      }
      rightDiag
    end
  end
end
