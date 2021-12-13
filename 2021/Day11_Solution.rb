TEST_INPUT = <<-INPUT
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
INPUT



Octopus = Struct.new(:rowIdx, :colIdx, :energyLevel, :flashedThisStep)

def init(inputString)
    inputArr = inputString.each_line(chomp: true).to_a
    @octopusMatrix = inputArr.map.with_index { |row, rowIdx| row.chars.map.with_index { |level, colIdx| Octopus.new(rowIdx, colIdx, level.to_i, false)}}
    @totalFlashes = 0
end

def executeSteps(numSteps)
    @totalFlashes = 0

    #puts "Starting Matrix"
    #printMatrix()

    1.upto(numSteps).with_index do |idx|
        #puts "Step #{idx}"
        executeStep()
    end

    puts "Total Flashes: #{@totalFlashes}"
    return @totalFlashes
end


def executeUntilSimultaneousFlash()
    @totalFlashes = 0

    totalSteps = 0
    while true do
        totalSteps += 1
        flashesThisStep = executeStep()
        if flashesThisStep == (@octopusMatrix.length * @octopusMatrix[0].length)
            break
        end
    end

    puts "Total Steps Until Simultaneous Flash = #{totalSteps}"

    return totalSteps
end


def executeStep()
    numFlashedThisStep = 0

    octopusesToFlash = Array.new 
    @octopusMatrix.each_with_index do | octopusRow, rowIdx|
        octopusRow.each_with_index do | octopus, colIdx |
            octopus.energyLevel += 1
            if octopus.energyLevel > 9
                octopusesToFlash.push(octopus)
            end
        end
    end

    octopusesToFlash.each do |octopus |
        flashOctopus(octopus)
        octopus.energyLevel = 0
    end
    # printMatrix()

    @octopusMatrix.each_with_index do | octopusRow, rowIdx|
        octopusRow.each_with_index do | octopus, colIdx |
            if octopus.flashedThisStep == true
                numFlashedThisStep += 1
                octopus.flashedThisStep = false
            end
        end
    end

    return numFlashedThisStep
end

def flashOctopus(octopus)
    if octopus.flashedThisStep == false
        @totalFlashes += 1
        octopus.flashedThisStep = true
        octopus.energyLevel = 0
        -1.upto(1).with_index do |rowInc|
            rowIdx = octopus.rowIdx + rowInc
            if (rowIdx > -1 && rowIdx < @octopusMatrix.length) 
                -1.upto(1).with_index do |colInc|
                    colIdx = octopus.colIdx + colInc
                    if (colIdx > -1 && colIdx < @octopusMatrix[0].length)
                        if @octopusMatrix[rowIdx][colIdx].flashedThisStep == false
                            @octopusMatrix[rowIdx][colIdx].energyLevel += 1
                            if @octopusMatrix[rowIdx][colIdx].energyLevel > 9
                                flashOctopus(@octopusMatrix[rowIdx][colIdx])
                            end
                        end
                    end
                end
            end
        end
    end

end

def printMatrix
    puts
    @octopusMatrix.each do |row|
        row.each do |octopus|
            printf("%d", octopus.energyLevel)
        end
        printf("\n")
    end
end


require 'minitest'
class Day11Test < Minitest::Test
    def test_countFlashes
        init(TEST_INPUT)
        assert_equal 1656, executeSteps(100)
    end

    def test_untilSimultaneousFlash
       init(TEST_INPUT)
       assert_equal 195, executeUntilSimultaneousFlash()
    end 

end
Minitest.run []



puts ""
puts "ACTUAL INPUT"
input = File.read('2021/Day11_Input.txt')

puts "PART 1"
init(input)
executeSteps(100)

puts "PART 2"
init(input)
executeUntilSimultaneousFlash()
