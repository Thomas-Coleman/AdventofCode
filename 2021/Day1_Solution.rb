inputArr = IO.readlines("2021/Day1_Input.txt")
puts "Array length: #{inputArr.length}"


puts 'PART 1'
@prevDepth = -1
@increasedCount = 0
inputArr.each do |depthStr|
    newDepth = depthStr.to_i 
    if @prevDepth == -1
        @prevDepth = newDepth
        next
    end

    puts "newDepth = #{newDepth} and prevDepth = #{@prevDepth}"
    if newDepth > @prevDepth
        puts "increased!!"
        @increasedCount +=1 
    end

    @prevDepth = newDepth
end

puts "Total increased = #{@increasedCount}"


puts 'PART 2'
@prevDepth = -1
@prevDepth2 = -1
@prevDepth3 = -1
@increasedCount = 0
inputArr.each do |depthStr|
    newDepth = depthStr.to_i
    puts "newDepth = #{newDepth} and prevDepth = #{@prevDepth} and prevDepth2 = #{@prevDepth2} and prevDepth3 = #{@prevDepth3}"
    
    if @prevDepth != -1 and @prevDepth2 != -1 and @prevDepth3 != -1
        prevWindow = @prevDepth + @prevDepth2 + @prevDepth3
        newWindow = newDepth + @prevDepth + @prevDepth2

        puts "newWindow = #{newWindow} and prevWindow = #{prevWindow}"
        if newWindow > prevWindow
            puts "increased!!"
            @increasedCount += 1
        end
    end

    @prevDepth3 = @prevDepth2
    @prevDepth2 = @prevDepth
    @prevDepth = newDepth

end

puts "Total increased = #{@increasedCount}"




