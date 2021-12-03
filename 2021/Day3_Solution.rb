@inputArr = IO.readlines("2021/Day3_Input.txt").map {|str| str.chomp!}

puts 'PART 1'
@zeroCountArray = []
@oneCountArray = []

@inputArr.each do |inputStr|
    idx = 0
    inputStr.each_char do |bit|
        if @zeroCountArray.length <= idx
            @zeroCountArray.push(0)
            @oneCountArray.push(0)
        end
        if bit == '0'
            @zeroCountArray[idx] += 1
        else
            @oneCountArray[idx] += 1
        end
        idx += 1
    end
end

@gammaBinaryStr = ""
@epsilonBinaryStr = ""
0.upto(@oneCountArray.length - 1) do |index|
    if @zeroCountArray[index] > @oneCountArray[index]
        @gammaBinaryStr += '0'
        @epsilonBinaryStr += '1'
    else
        @gammaBinaryStr += '1'
        @epsilonBinaryStr += '0'
    end
end

@gamma = @gammaBinaryStr.to_i(2)
@epsilon = @epsilonBinaryStr.to_i(2)

puts (@gamma * @epsilon).to_s


puts 'PART 2'
@bitIndex = 0
@remainingArr = @inputArr.map(&:clone)
@zeroArr = []
@oneArr = []
while @remainingArr.length > 1
    @remainingArr.each do |inputStr|
        if inputStr[@bitIndex] == '0'
            @zeroArr.push(inputStr)
        else
            @oneArr.push(inputStr)
        end
    end

    if @zeroArr.length > @oneArr.length
        @remainingArr = @zeroArr
    else
        @remainingArr = @oneArr
    end
    @zeroArr = []
    @oneArr = []
    @bitIndex += 1
end
@oxygen = @remainingArr[0].to_i(2)

@bitIndex = 0
@remainingArr = @inputArr.map(&:clone)
while @remainingArr.length > 1
    @remainingArr.each do |inputStr|
        if inputStr[@bitIndex] == '0'
            @zeroArr.push(inputStr)
        else
            @oneArr.push(inputStr)
        end
    end

    if @zeroArr.length <= @oneArr.length
        @remainingArr = @zeroArr
    else
        @remainingArr = @oneArr
    end
    @zeroArr = []
    @oneArr = []
    @bitIndex += 1
end
@co2 = @remainingArr[0].to_i(2)


puts @oxygen * @co2



