TEST_INPUT = <<-INPUT
16,1,2,0,4,2,7,1,2,14
INPUT


def init(inputString)
    @posArr = inputString.split(',').map(&:to_i)
end

# def median(inputArray)
#     puts "Median"
#     med = (inputArray.max - inputArray.min) / 2
#     puts med 
#     return med
# end

# def mode(inputArray)
#     puts "Mode"
#     countsMap = Hash.new
#     inputArray.each do |num|
#         if !countsMap.include?(num)
#             countsMap[num] = 1
#         else
#             countsMap[num] +=1
#         end
#     end

#     maxCount = countsMap.values.max
#     mode = countsMap.key(maxCount)
#     puts countsMap.inspect
#     puts mode.inspect
#     return mode
# end

def fuelCost(inputArray, targetDest, constantCost)
    cost = 0
    inputArray.each do |num|
        if constantCost
            cost += (num-targetDest).abs
        else
            cost += ((num-targetDest).abs * ((num-targetDest).abs + 1) / 2)
        end
    end

    return cost
end

def bruteCalcMinimum(inputArray, constantCost)
    puts "Brute Force Calc Minimum Cost"
    minCost = nil

    0.upto(inputArray.max) do |number|
        cost = fuelCost(inputArray, number, constantCost)
        if minCost == nil || cost < minCost
            minCost = cost
        end
    end

    puts minCost
    return minCost
end
 
require 'minitest'
class Day7Test < Minitest::Test
    def test_constant_cost
        init(TEST_INPUT)
        assert_equal 37, bruteCalcMinimum(@posArr, true)
    end

    def test_increasing_cot
        init(TEST_INPUT)
        assert_equal 168, bruteCalcMinimum(@posArr, false)
    end 

end
Minitest.run []


puts ""
puts "ACTUAL INPUT"
input = File.read('2021/Day7_Input.txt')

puts "PART 1"
init(input)
bruteCalcMinimum(@posArr, true)

puts "PART 2"
init(input)
bruteCalcMinimum(@posArr, false)

