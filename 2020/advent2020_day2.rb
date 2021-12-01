inputArr = IO.readlines('advent2020_day2_input.txt')
puts "Total Passwords in File #{inputArr.length}"

puts 'Valid Passwords - Part 1'
puts '========='
totalValid = 0
inputArr.each do |policyAndPasswordStr|
    subStrings= policyAndPasswordStr.split(' ')
    indicesStr = subStrings[0]
    letterStr = subStrings[1].chop
    passwordStr = subStrings[2]

    indexStrings = indicesStr.split('-')

    charCount = 0
    for i in 0...passwordStr.length
        #puts "LetterStr:  #{letterStr}    PasswordStr[i]:  #{passwordStr[i]}"
        if passwordStr[i] == letterStr
            charCount +=1
        end
    end

    if charCount >= indexStrings[0].to_i and charCount <= indexStrings[1].to_i
        totalValid +=1
        puts("Index 1: " + indexStrings[0] + " Index 2: "+ indexStrings[1] + " Letter: " + letterStr + " Password: " + passwordStr)
    end
end

puts("Total Valid Passwords: #{totalValid}")


puts '\n\nValid Passwords - Part 2'
puts '========='
totalValid = 0
inputArr.each do |policyAndPasswordStr|
    subStrings= policyAndPasswordStr.split(' ')
    indicesStr = subStrings[0]
    letterStr = subStrings[1].chop
    passwordStr = subStrings[2]

    indexStrings = indicesStr.split('-')

    charCount = 0
    #puts "passwordStr[indexStrings[0].to_i - 1]:  #{passwordStr[indexStrings[0].to_i - 1]}"
    if passwordStr[indexStrings[0].to_i - 1] == letterStr
        charCount +=1
    end

    if passwordStr[indexStrings[1].to_i - 1] == letterStr
        charCount +=1
    end

    if charCount == 1
        totalValid +=1
        puts("Index 1: " + indexStrings[0] + " Index 2: "+ indexStrings[1] + " Letter: " + letterStr + " Password: " + passwordStr)
    end
end

puts("Total Valid Passwords: #{totalValid}")


