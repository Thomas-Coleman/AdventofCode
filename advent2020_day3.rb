movesRight = -1
movesDown = -1
product = 1

moves = [[1,1],[3,1],[5,1],[7,1],[1,2]]

for index in 1..moves.length do
    movesRight = moves[index-1][0]
    movesDown = moves[index-1][1]

    puts "Right: #{movesRight}  Down: #{movesDown}"

    inputArr = IO.readlines('advent2020_day3_input.txt')
    currentY = -1
    nextX, nextY = 0, 0
    treesHit = 0
    inputArr.each do |mapStr|
        currentY += 1
        if currentY < nextY
            next
        end
        if mapStr[nextX] == '#'
            treesHit += 1
            #puts "X: #{nextX} Y: #{currentY}"
        end
        nextX += movesRight
        if nextX >= (mapStr.length - 1)
            nextX = nextX - mapStr.length + 1
        end
        nextY += movesDown
    end

    puts "  Trees Hit: #{treesHit}"

    product = product * treesHit

end

puts "  Product: #{product}"