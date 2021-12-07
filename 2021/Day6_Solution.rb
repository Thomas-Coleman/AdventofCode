TEST_INPUT = <<-INPUT
3,4,3,1,2
INPUT


def simulate(numDays, verbose)
    daysRemaining = numDays
    daysCompleted = 0

    while daysRemaining > 0
        newFishToday = 0
        @fishArr.each_with_index do |fish, idx|
            if fish == 0
                newFishToday += 1
                fish = 6
            else
                fish -= 1
            end
            @fishArr[idx] = fish
        end
        1.upto(newFishToday) do
            @fishArr.push(8)
        end

        daysRemaining -= 1
        daysCompleted += 1
        if verbose
            printf("After %d days: ", daysCompleted)
            printFish()
        end
    end

    puts "Total fish = #{@fishArr.length}"
    return @fishArr.length
end

def simulateV2(numDays, verbose)
    
    daysRemaining = numDays
    daysCompleted = 0

    while daysRemaining > 0
        newFishToday = @countFishArr[0]
        @countFishArr.shift       
        @countFishArr[6] = @countFishArr[6] + newFishToday
        @countFishArr[8] = newFishToday

        daysRemaining -= 1
        daysCompleted += 1
        if verbose
            printf("After %d days: ", daysCompleted)
            sum = @countFishArr.inject {|sum, count| sum+count}
            puts "Total fish = #{sum}"
        end
    end

    printf("After %d days: ", daysCompleted)
    sum = @countFishArr.inject {|sum, count| sum+count}
    puts "Total fish = #{sum}"
    return sum
end


def init(inputString)
    @fishArr = inputString.split(',').map {|fish| fish.to_i }

    @countFishArr = Array.new(9, 0)
    @fishArr.each do |fish|
        @countFishArr[fish] += 1
    end
    #puts @countFishArr
end

def printFish
    @fishArr.each {|fish| printf("%d,", fish)}
    printf("\n")
end

require 'minitest'
class FishTest < Minitest::Test
    def test_18
        init(TEST_INPUT)
        assert_equal 26, simulateV2(18, false)
    end

    def test_80
        init(TEST_INPUT)
        assert_equal 5934, simulateV2(80, false)
    end
end
Minitest.run []

puts ""
puts "ACTUAL INPUT"
input = File.read('2021/Day6_Input.txt')

puts "PART 1"
init(input)
simulate(80, false)
simulateV2(80, false)

puts "PART 2"
init(input)
simulateV2(256, false)