TEST_INPUT = <<-INPUT
be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
INPUT


def init(inputString)
    inputArr = inputString.each_line(chomp: true)
    
    @signalPatterns = Array.new
    @outputValues = Array.new

    inputArr.each_with_index do |inputLine, idx| 
        inputLineParts = inputLine.split(' | ')
        @signalPatterns[idx] = inputLineParts[0].split(' ').map {|pattern| pattern.chars.sort.join}
        @outputValues[idx] = inputLineParts[1].split(' ').map {|output| output.chars.sort.join}
    end
end

def count1478s()
    count = 0
    
    @outputValues.flatten.each do |outputValue|
        case outputValue.length
        when 2 #one
            count += 1
        when 4 #four
            count += 1
        when 3 #seven
            count += 1
        when 7 # eight
            count += 1
        end
    end

    puts "Count of 1478s: #{count}"
    return count
end

def deduceSignalMappings(signalPatterns, outputValues)
    
    total = 0

    signalPatterns.each_with_index do |signalPattern, idx|
        total += deduceSignalMapping(signalPattern, outputValues[idx])
    end

    puts "TOTAL: #{total}"
    return total
end


def deduceSignalMapping(signalPatterns, outputValues)
    numbers = Array.new(10, "")

    signalPatterns.each do |pattern|

        case pattern.length
        when 2 #one
            numbers[1] = pattern
        when 4 # four
            numbers[4] = pattern
        when 3 # seven
            numbers[7] = pattern
        when 7 # eight
            numbers[8] = pattern
        when 6 # zero, six, or nine
        when 5 # two, three, or five   
        end
    end

    # find nine and basePos
    basePos = ''
    fourSeven = (numbers[4] + numbers[7]).chars.sort.uniq.join
    signalPatterns.each do |pattern |
        if pattern.length == 6
            subbed = (pattern.chars - fourSeven.chars).join
            if subbed.length == 1
                # found 9!
                # found base position
                numbers[9] = pattern
                basePos = subbed.chars[0]
            end
        end
    end
    
    # find lowerLeftPos
    subbed = (numbers[8].chars - numbers[9].chars).join
    lowerLeftPos = subbed.chars[0]

    # find zero and upperLeftPos
    upperLeftPos = ''
    sevenAndBaseAndLowerLeft = (numbers[7] + basePos + lowerLeftPos).chars.sort.join
    signalPatterns.each do |pattern |
        if pattern.length == 6
            subbed = (pattern.chars - sevenAndBaseAndLowerLeft.chars).join
            if subbed.length == 1
                # found zero!
                # found upper Left pos
                numbers[0] = pattern
                upperLeftPos = subbed.chars[0]
            end
        end
    end

    # find three
    numbers[3] = (numbers[8].chars - upperLeftPos.chars - lowerLeftPos.chars).join
 
    signalPatterns.each do |pattern |
        if pattern.length == 6
            if pattern != numbers[9] and pattern != numbers[0]
                numbers[6] = pattern
            end
        end
    end
    
    signalPatterns.each do |pattern |
        if pattern.length == 5
            if (numbers[6].chars - pattern.chars).length == 1
                numbers[5] = pattern
            elsif pattern != numbers[3]
                numbers[2] = pattern
            end
        end
    end

    # numbers.each_with_index do |number, idx|
    #     puts "#{idx} = #{number}"
    # end
    decodedValue = ""
    outputValues.each do |digitPattern|
        numbers.each_with_index do |pattern, index|
            if digitPattern == pattern
                decodedValue += index.to_s 
            end
        end
    end

    #puts "Decoded Value = #{decodedValue}"
    return decodedValue.to_i
end

require 'minitest'
class Day8Test < Minitest::Test
    def test_count_1478s
        init(TEST_INPUT)
        assert_equal 26, count1478s()
    end

    def test_deducedMapping
        init(TEST_INPUT)
        assert_equal 61229, deduceSignalMappings(@signalPatterns, @outputValues)
    end 

end
Minitest.run []


puts ""
puts "ACTUAL INPUT"
input = File.read('2021/Day8_Input.txt')

puts "PART 1"
init(input)
count1478s()
deduceSignalMapping(@signalPatterns[0], @outputValues[0])

puts "PART 2"
init(input)
deduceSignalMappings(@signalPatterns, @outputValues)

