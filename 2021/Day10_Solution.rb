TEST_INPUT = <<-INPUT
[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]
INPUT



def init(inputString)
    @inputArr = inputString.each_line(chomp: true).to_a
    @illegalCharCount = {:round => 0, :square => 0, :brace => 0, :angle => 0}
    @completionStrings = Array.new
end

def incrementIllegalCharCount(ch)
    if ch == ')'
        @illegalCharCount[:round] += 1
    elsif ch == ']'
        @illegalCharCount[:square] += 1
    elsif ch == '}'
        @illegalCharCount[:brace] += 1
    elsif ch == '>'
        @illegalCharCount[:angle] += 1
    end
end

def getMatchFor(ch)
    if ch == '('
        return ')'
    elsif ch == '['
        return ']'
    elsif ch == '{'
        return '}'
    elsif ch == '<'
        return '>'
    elsif ch == ')'
        return '('
    elsif ch == ']'
        return '['
    elsif ch == '}'
        return '{'
    elsif ch == '>'
        return '<'
    end

    return ''
end

def parseInput(inputStringArr)
    inputStringArr.each do |inputLineStr|
        parseInputLine(inputLineStr)
    end
end

def parseInputLine(inputLineStr)
    unmatchedStack = Array.new

    #puts inputLineStr
    inputLineStr.chars.each do |ch|
        if ch == '{' or ch == '(' or ch == '[' or ch == '<' then
            unmatchedStack.push(ch)
        elsif ch == '}' or ch == ')' or ch == ']' or ch == '>'
            if unmatchedStack.length == 0 then
                incrementIllegalCharCount(ch)
                return
            end

            toBeMatched = unmatchedStack[unmatchedStack.length - 1]
            if getMatchFor(ch) != toBeMatched
                #puts "Unmatched!! #{ch} Expected #{toBeMatched}"
                incrementIllegalCharCount(ch)
                return
            else
                unmatchedStack.pop
            end
        end

        #puts "Unmatched Stack #{unmatchedStack.to_s}"
    end

    if unmatchedStack.length > 0
        completionString = ""
        unmatchedStack.reverse.each do |ch|
            completionString += getMatchFor(ch)
        end
        #puts "Completion String = #{completionString}"

        @completionStrings.push(completionString)
    end
end

def calcCorruptionScore()
    total = 0

    total += (3 * @illegalCharCount[:round])
    total += (57 * @illegalCharCount[:square])
    total += (1197 * @illegalCharCount[:brace])
    total += (25137 * @illegalCharCount[:angle])

    puts "Total Corruption Score: #{total}"
    return total
end

def calcCompletionScore()
    completionScores = Array.new

    @completionStrings.each do |completionString|
        stringTotal = 0
        completionString.chars.each do |ch|
            value = 0
            if ch == ')'
                value = 1
            elsif ch == ']'
                value = 2
            elsif ch == '}'
                value = 3
            elsif ch == '>'
                value =4
            end

            stringTotal *= 5
            stringTotal += value
        end

        puts "String total #{stringTotal}"
        completionScores.push(stringTotal)
    end

    completionScores.sort!
    midIdx = (completionScores.length / 2)
    puts puts "Middle Completion Score: #{completionScores[midIdx]}"
    return completionScores[midIdx]
end


require 'minitest'
class Day10Test < Minitest::Test
    def test_corrupted_score
        init(TEST_INPUT)
        parseInput(@inputArr)
        assert_equal 26397, calcCorruptionScore()
    end

    def test_completion_score
        init(TEST_INPUT)
        parseInput(@inputArr)
        assert_equal 288957, calcCompletionScore()
    end 

end
Minitest.run []

puts ""
puts "ACTUAL INPUT"
input = File.read('2021/Day10_Input.txt')

puts "PART 1"
init(input)
parseInput(@inputArr)
calcCorruptionScore()

puts "PART 2"
calcCompletionScore()