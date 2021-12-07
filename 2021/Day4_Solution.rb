CellAddress = Struct.new(:boardNum, :colNum, :rowNum)
Cell = Struct.new(:number, :drawn)

class Board
    attr_reader :won

    def initialize
        @cells = Array.new(5) {Array.new(5)}
        @won = false
    end

    def initCell(col, row, number)
        @cells[col][row] = Cell.new(number, false)
    end

    # returns true if results in a win
    def numberDrawn(col, row)
        @cells[col][row].drawn = true

        #check if we have a winner - row
        winner = true
        0.upto(4) do |colNum|
            winner = winner & @cells[colNum][row].drawn
        end
        if winner
            #puts "winner row"
            @won = true
            return true
        end

        #check if we have a winner - column
        winner = true
        0.upto(4) do |rowNum|
            winner = winner & @cells[col][rowNum].drawn
        end
        if winner
            #puts "winner column"
            @won = true
            return true
        end

        return false
    end

    def getScore(winningNumber)
        sumNotDrawn = 0

        0.upto(4) do |colNum|
            0.upto(4) do |rowNum|
                if @cells[colNum][rowNum].drawn == false
                    sumNotDrawn += @cells[colNum][rowNum].number
                end
            end
        end
        return winningNumber.to_i * sumNotDrawn
    end

end



def init()
    @inputArr.each_with_index do |inputStr, index|
        if index == 0
            @drawnNumbers = inputStr.split(',')
        elsif inputStr == ""
            @numBoards += 1
            @boards.push Board.new
            @currentRow = 0
        else
            boardRow = inputStr.split(' ')
            boardRow.each_with_index do |number, currentColumn|
                cellAddr = CellAddress.new(@numBoards-1, currentColumn, @currentRow)
                if @numberToCellMap[number] == nil then @numberToCellMap[number] = Array.new end
                @numberToCellMap[number].push cellAddr
                @boards[@numBoards - 1].initCell(currentColumn,@currentRow, number.to_i)
            end
            @currentRow +=1
        end
    end
end

# returns winningBoardNum, winningNumber
def performDraw(stopOnFirst)
    firstWinnerFound = false
    winningBoard = -1
    winningNumber = -1

    @drawnNumbers.each do |number|
        #puts "Drew #{number}"
        cellArray = @numberToCellMap[number]
        cellArray.each do |cellAddr|
            if @boards[cellAddr.boardNum].won
                # already won - skip to next board
                next
            end

            if @boards[cellAddr.boardNum].numberDrawn(cellAddr.colNum, cellAddr.rowNum)
                # we have a winner!!!
                #puts "Board #{cellAddr.boardNum} is a Winner!!!  Number: #{number}"
                winningBoard = cellAddr.boardNum
                winningNumber = number

                if !firstWinnerFound
                    score = @boards[winningBoard].getScore(winningNumber)
                    puts "Part 1 answer is #{score}"
                    firstWinnerFound = true
                end
            end
        end
    end

    score = @boards[winningBoard].getScore(winningNumber)
    puts "Part 2 answer is #{score}"
end

@inputArr = IO.readlines("2021/Day4_Input.txt").map {|str| str.chomp!}
@numberToCellMap = Hash.new
@numBoards = 0
@winningNumber = -1
@boards = Array.new

init()
performDraw(true)





