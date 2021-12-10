TEST_INPUT = <<-INPUT
2199943210
3987894921
9856789892
8767896789
9899965678
INPUT

Point = Struct.new(:rowNum, :colNum)

def init(inputString)
    @inputArr = inputString.each_line(chomp: true).to_a
    @lowPoints = Array.new
end

def assessRiskLevel()
    totalRisk = 0

    @inputArr.each_with_index do |row, rowNum|
        row.chars.each_with_index do |floorHeightStr, colNum|
            floorHeight = floorHeightStr.to_i
            adjacenciesToCheck = 4
            higherAdjacentSpaces = 0

            if rowNum == 0 or rowNum == @inputArr.length-1
                adjacenciesToCheck -= 1
            end
            if colNum == 0 or colNum == @inputArr[0].length-1
                adjacenciesToCheck -= 1
            end

            if rowNum !=0 then
                if @inputArr[rowNum - 1].chars[colNum].to_i > floorHeight then
                    higherAdjacentSpaces += 1
                end
            end
            if rowNum != (@inputArr.length - 1) then
                if @inputArr[rowNum + 1].chars[colNum].to_i > floorHeight then
                    higherAdjacentSpaces += 1
                end
            end
            if colNum !=0 then
                if @inputArr[rowNum].chars[colNum - 1].to_i > floorHeight then
                    higherAdjacentSpaces += 1
                end
            end
            if colNum != (@inputArr[0].length - 1) then
                if @inputArr[rowNum].chars[colNum + 1].to_i > floorHeight then
                    higherAdjacentSpaces += 1
                end
            end

            if higherAdjacentSpaces == adjacenciesToCheck then
                # found low point
                #puts "Low point row: #{rowNum}, col: #{colNum}, height: #{floorHeight}, adjacencies to check: #{adjacenciesToCheck}"
                totalRisk += (floorHeight+1)
                @lowPoints.push(Point.new(rowNum, colNum))
                #puts "size #{@lowPoints.length}"
            end

        end
    end

    puts "Total Risk:  #{totalRisk}"
    return totalRisk
end

def findBasins()
    basinSizes = Array.new

    assessRiskLevel()
    @lowPoints.each do |lowPoint|
        @exploredPoints = Array.new
        basinSize = exploreNeighouringPositions(lowPoint, 1)
        puts "Basin Size: #{basinSize}"
        basinSizes.push(basinSize)
    end

    sortedBasins = basinSizes.sort.reverse
    productBasins = sortedBasins[0] * sortedBasins[1] * sortedBasins[2]
    puts "Product of Largest Basins: #{productBasins}"
    return productBasins
end

def exploreNeighouringPositions(currentPoint, basinSize)
    if @exploredPoints.include? currentPoint
        #puts "current point already explored:  #{currentPoint.to_s}"
        return basinSize
    end
    @exploredPoints.push(currentPoint)
    #puts "exploring neighbours of: #{currentPoint.to_s}"
    if currentPoint.rowNum !=0 then
        if @inputArr[currentPoint.rowNum - 1].chars[currentPoint.colNum].to_i < 9 then
            newPoint = Point.new(currentPoint.rowNum - 1,currentPoint.colNum)
            if !@exploredPoints.include? newPoint
                #puts "new point already explored:  #{newPoint.to_s}"
                basinSize += 1
                basinSize = exploreNeighouringPositions(newPoint, basinSize)
            end
        end
    end
    if currentPoint.rowNum != (@inputArr.length - 1) then
        if @inputArr[currentPoint.rowNum + 1].chars[currentPoint.colNum].to_i < 9 then
            newPoint = Point.new(currentPoint.rowNum + 1,currentPoint.colNum)
            if !@exploredPoints.include? newPoint
                #puts "new point already explored:  #{newPoint.to_s}"
                basinSize += 1
                basinSize = exploreNeighouringPositions(newPoint, basinSize)
            end
        end
    end
    if currentPoint.colNum != 0 then
        if @inputArr[currentPoint.rowNum].chars[currentPoint.colNum - 1].to_i < 9 then
            newPoint = Point.new(currentPoint.rowNum,currentPoint.colNum - 1)
            if !@exploredPoints.include? newPoint
                #puts "new point already explored:  #{newPoint.to_s}"
                basinSize += 1
                basinSize = exploreNeighouringPositions(newPoint, basinSize)
            end
        end
    end
    if currentPoint.colNum != (@inputArr[0].length - 1)  then
        if @inputArr[currentPoint.rowNum].chars[currentPoint.colNum + 1].to_i < 9 then
            newPoint = Point.new(currentPoint.rowNum,currentPoint.colNum + 1)
            if !@exploredPoints.include? newPoint
                #puts "new point already explored:  #{newPoint.to_s}"
                basinSize += 1
                basinSize = exploreNeighouringPositions(newPoint, basinSize)
            end
        end
    end

    return basinSize
end




require 'minitest'
class Day9Test < Minitest::Test
    def test_risk_level
        init(TEST_INPUT)
        assert_equal 15, assessRiskLevel()
    end

    def test_basins
        init(TEST_INPUT)
        assert_equal 1134, findBasins()
    end 

end
Minitest.run []

puts ""
puts "ACTUAL INPUT"
input = File.read('2021/Day9_Input.txt')

puts "PART 1"
init(input)
assessRiskLevel()

puts "PART 2"
init(input)
findBasins()