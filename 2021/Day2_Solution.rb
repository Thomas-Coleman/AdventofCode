inputArr = IO.readlines("2021/Day2_Input.txt").map {|string| string.split(" ")}

puts 'PART 1'
@horizPos = 0
@depthPos = 0

inputArr.each do |dirStr, distanceStr|
    distance = distanceStr.to_i

    case dirStr
    when "forward"
        @horizPos += distance

    when "up"
        @depthPos -= distance

    when "down"
        @depthPos += distance

    else
        puts "UNEXPECTED CASE!!!"
        exit
    end

    #puts "Dir = #{dirStr} Distance = #{distance}  New HorizPos = #{@horizPos} New DepthPos = #{@depthPos}"
end

@totalMultipliedTogether = @horizPos * @depthPos
puts "Total HorizPos x DepthPos = #{@totalMultipliedTogether}"


puts 'PART 2'
@horizPos = 0
@depthPos = 0
@aimDir = 0

inputArr.each do |dirStr, distanceStr|
    distance = distanceStr.to_i

    case dirStr
    when "forward"
        @horizPos += distance
        @depthPos += @aimDir * distance

    when "up"
        @aimDir -= distance

    when "down"
        @aimDir += distance

    else
        puts "UNEXPECTED CASE!!!"
        exit
    end

    #puts "Dir = #{dirStr} Distance = #{distance}  Aim = #{@aimDir}   New HorizPos = #{@horizPos} New DepthPos = #{@depthPos}"
end

@totalMultipliedTogether = @horizPos * @depthPos
puts "Total HorizPos x DepthPos = #{@totalMultipliedTogether}"




