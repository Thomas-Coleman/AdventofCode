TEST_INPUT = <<-INPUT
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
INPUT


Point = Struct.new(:x, :y)

class LineSegment
    attr_reader :point1, :point2

    def initialize(p1, p2)
        @point1 = p1
        @point2 = p2
    end

    def mapLineToGrid(grid, ignoreDiagonal)
        if @point1.x == @point2.x
            startY = @point1.y
            endY = @point2.y
            if @point1.y > @point2.y
                startY = @point2.y
                endY = @point1.y  
            end
            (startY..endY).each do |y|
                grid.markPointOnGrid(@point1.x, y)
            end
        elsif @point1.y == point2.y
            startX = @point1.x
            endX = @point2.x
            if @point1.x > @point2.x
                startX = @point2.x
                endX = @point1.x  
            end
            (startX..endX).each do |x|
                grid.markPointOnGrid(x, @point1.y)
            end
        else
            if ignoreDiagonal
                #puts "Ignoring Diagonal Segment #{@point1} <-> #{point2}"
            else
                incX = 1
                incY = 1
                x = @point1.x
                y = @point1.y
                if @point1.x > @point2.x
                    incX = -1
                end
                if @point1.y > @point2.y
                    incY = -1 
                end
                grid.markPointOnGrid(x, y)
                until (x == @point2.x && y == @point2.y)
                    x += incX
                    y += incY
                    grid.markPointOnGrid(x, y)
                end
            end
        end
    end

end

class GridLayout
    attr_reader :grid, :gridSize

    def initialize(gridSize)
        @gridSize = gridSize
        @grid = Array.new(gridSize) {Array.new(gridSize, 0)}
    end

    def markPointOnGrid(x, y)
        @grid[x][y] += 1
    end
    
    def getNumberOfOverlapPoints
        numOverlapPoints = 0
        0.upto(@gridSize-1) do |x|
            0.upto(@gridSize-1) do |y|
                if @grid[x][y] > 1
                    numOverlapPoints += 1
                end
            end
        end

        return numOverlapPoints
    end
end

def init(inputString, grid, ignoreDiagonal)
    
    inputArr = inputString.each_line(chomp: true)

    inputArr.each do |inputStr|
        coords = inputStr.split(" -> ")
        xy1 = coords[0].split(",")
        point1 = Point.new(xy1[0].to_i,xy1[1].to_i)
        xy2 = coords[1].split(",")
        point2 = Point.new(xy2[0].to_i,xy2[1].to_i)

        lineSegment = LineSegment.new(point1, point2)
        lineSegment.mapLineToGrid(grid, ignoreDiagonal)
    end
end

require 'minitest'
class HydrothermalTest < Minitest::Test
  def test_part1
    @grid = GridLayout.new(10)
    init(TEST_INPUT, @grid, true)
    assert_equal 5, @grid.getNumberOfOverlapPoints
  end

  def test_part2
    @grid = GridLayout.new(10)
    init(TEST_INPUT, @grid, false)
    assert_equal 12, @grid.getNumberOfOverlapPoints
  end
end
Minitest.run



input = File.read('2021/Day5_Input.txt')

puts "PART 1"
@grid = GridLayout.new(1000)
init(input, @grid, true)
puts "Number of Overlap Points: #{@grid.getNumberOfOverlapPoints}"

puts "PART 2"
@grid = GridLayout.new(1000)
init(input, @grid, false)
puts "Number of Overlap Points: #{@grid.getNumberOfOverlapPoints}"



