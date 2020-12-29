#File.open("input.txt", "r") do |inputFile|
#    inputFile.each_line {|line| puts "Line #{line.dump}"}
#end

inputArr = IO.readlines("advent2020_day1_input.txt")
puts "Array length: #{inputArr.length}"



puts '\n\n2 Numbers'
puts '========='
@done = false
inputArr.each do |num1Str|
  num1 = num1Str.to_i
  inputArr.each do |num2Str|
    num2 = num2Str.to_i
    next unless num1 + num2 == 2020

    puts "Num1 = #{num1} and Num2 = #{num2}"
    puts "Product = #{num1 * num2}"
    @done = true
    break
  end
  next unless @done
  break
end

puts "\n\n3 Numbers"
puts "========="
@done = false
inputArr.each do |num1Str|
  num1 = num1Str.to_i
  inputArr.each do |num2Str|
    num2 = num2Str.to_i
    inputArr.each do |num3Str|
        num3 = num3Str.to_i
        
        next unless num1 + num2 + num3 == 2020
        puts "Num1 = #{num1} and Num2 = #{num2} and Num3 = #{num3}"
        puts "Product = #{num1 * num2 * num3}"
        @done = true
        break
    end
    next unless @done
    break
  end
  next unless @done
  break
end


