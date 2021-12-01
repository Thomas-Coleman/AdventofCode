


validPassports = 0
passportFieldsFound = {byr: nil, iyr: nil, eyr: nil, hgt: nil, hcl: nil, ecl: nil, pid: nil, cid: nil}
doneWithPassport = false
inputArr = IO.readlines('advent2020_day4_input.txt')
inputArr.each_with_index do |inputStr, index|
    #puts "Read: #{inputStr}"
    if inputStr.strip.empty? || index == inputArr.size - 1
        # done processing current passport
        doneWithPassport = true
    end
    if not inputStr.strip.empty?
        fieldsStr = inputStr.split(' ')
        fieldsStr.each do |fieldStr|
            keyValueStr = fieldStr.split(':')
            key = keyValueStr[0]
            value = keyValueStr[1]
            #puts "Key: #{key}, Value: #{value}"
            passportFieldsFound[:"#{key}"] = value
            #puts "#{passportFieldsFound}"
        end
    end

    if doneWithPassport
        # done processing current passport -> check that all required fields were found
        if (!passportFieldsFound[:byr].nil? && 
            !passportFieldsFound[:iyr].nil? && 
            !passportFieldsFound[:eyr].nil? && 
            !passportFieldsFound[:hgt].nil? && 
            !passportFieldsFound[:hcl].nil? && 
            !passportFieldsFound[:ecl].nil? &&
            !passportFieldsFound[:pid].nil?) 
            # all required fields are present
            # check that they are valid...
            valid = true
            byrValid = passportFieldsFound[:byr].match?(/\d{4}/) && 
                passportFieldsFound[:byr].to_i >=1920 &&
                passportFieldsFound[:byr].to_i <= 2002
            #puts "byr = #{passportFieldsFound[:byr]}    valid = #{byrValid}"

            iyrValid = passportFieldsFound[:iyr].match?(/\d{4}/) && 
                passportFieldsFound[:iyr].to_i >=2010 &&
                passportFieldsFound[:iyr].to_i <= 2020
            #puts "iyr = #{passportFieldsFound[:iyr]}    valid = #{iyrValid}"

            eyrValid = valid && passportFieldsFound[:eyr].match?(/\d{4}/) && 
                passportFieldsFound[:eyr].to_i >=2020 &&
                passportFieldsFound[:eyr].to_i <= 2030
            #puts "eyr = #{passportFieldsFound[:eyr]}    valid = #{eyrvalid}"

            #puts passportFieldsFound[:hgt]
            heightValid = true
            heightArr = passportFieldsFound[:hgt].match(/(?<value>\d+)(?<unit>[a-z]+)/)
            if heightArr.nil?
                #puts "invalid height!"
                heightValid = false
            else
                if heightArr[:unit].eql? "cm"
                    heightValid = heightArr[:value].to_i >= 150 && heightArr[:value].to_i <= 193
                else
                    heightValid = heightArr[:value].to_i >= 59 && heightArr[:value].to_i <= 76
                end
                #puts "hgt = #{heightArr[:value]} unit = #{heightArr[:unit]}   valid = #{heightValid}"
            end

            hclValid =  passportFieldsFound[:hcl].match?(/#\w{6}/) 
            #puts "hcl = #{passportFieldsFound[:hcl]}    valid = #{hclValid}"

            eclValid = passportFieldsFound[:ecl].match?(/amb|blu|brn|gry|grn|hzl|oth/) 
            #puts "ecl = #{passportFieldsFound[:ecl]}    valid = #{eclValid}"

            pidValid = valid && passportFieldsFound[:pid].match?(/^\d{9}$/) 
            #puts "pid = #{passportFieldsFound[:pid]}    valid = #{pidValid}"


            valid = byrValid && iyrValid && eyrValid && heightValid && hclValid && eclValid && pidValid

            if !valid
            #     puts "Invalid values detected"
            #     puts "#{passportFieldsFound}"
            else
                validPassports += 1
            #     puts "Valid!"
            end
        else
            #puts "Invalid number of fields!"
            #puts "#{passportFieldsFound}"
        end
        passportFieldsFound = {byr: nil, iyr: nil, eyr: nil, hgt: nil, hcl: nil, ecl: nil, pid: nil, cid: nil}
        doneWithPassport = false
        #exit
    end
end

puts "Valid passports: #{validPassports}"