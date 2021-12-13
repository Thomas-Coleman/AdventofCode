TEST_INPUT = <<-INPUT
fs-end
he-DX
fs-he
start-DX
pj-DX
end-zg
zg-sl
zg-pj
pj-he
RW-he
fs-DX
pj-RW
zg-RW
start-pj
he-WI
zg-he
pj-fs
start-RW
INPUT



class Cave
    attr_accessor :name, :connectedCaves, :isSmall

    def initialize(name)
        @name = name
        #puts name
        @isSmall = (name == name.downcase) ? true : false
        #puts ("Cave:  #{name}   Is Small? #{isSmall}")
        @connectedCaves = Array.new
    end
end


def init(inputString)
    @allCaves = Hash.new
    @startCave, @endCave = nil, nil
    inputString.each_line(chomp: true) do |lineStr|
        #puts lineStr
        src, dest = lineStr.split('-')
        connectCaves(src, dest)
    end
    @allPaths = Array.new
end

def connectCaves(srcCaveName, destCaveName)
    srcCave = @allCaves[srcCaveName]
    if srcCave == nil
        srcCave = @allCaves[srcCaveName] = Cave.new(srcCaveName)
        @allCaves[srcCaveName] = srcCave
    end
    
    destCave = @allCaves[destCaveName]
    if destCave == nil
        destCave = @allCaves[destCaveName] = Cave.new(destCaveName)
        @allCaves[destCaveName] = destCave
    end

    srcCave.connectedCaves.push(destCave)
    destCave.connectedCaves.push(srcCave)

    if srcCaveName.downcase == "start"
        @startCave = srcCave
    elsif destCaveName.downcase == "start"
        @startCave = destCave
    end
end

def traverseCaves(currentPath, currentCave, okToVisitTwice, visitedTwice)
    currentPath.push(currentCave)
    if currentCave.name.downcase == "end"
        #puts pathToString(currentPath)
        @allPaths.push(pathToString(currentPath))
    else 
        currentCave.connectedCaves.each do |nextCave|
            if nextCave.isSmall && currentPath.include?(nextCave)
                if !okToVisitTwice || visitedTwice != nil || nextCave.name == "start"
                    next
                else
                    visitedTwice = nextCave.name
                end
            end
            
            traverseCaves(currentPath, nextCave, okToVisitTwice, visitedTwice)
            if visitedTwice == nextCave.name
                visitedTwice = nil
            end
        end
    end
    currentPath.pop()
    
end

def findAllCavePaths(okToVisitTwice)
    currentCave = @startCave
    currentPath = Array.new

    traverseCaves(currentPath, currentCave, okToVisitTwice, nil)

    puts "Total #{@allPaths.length} paths."
    
    return @allPaths.length
end

def pathToString(path)
    pathStr = ""
    path.each_with_index do |cave, idx|
        pathStr += cave.name
        if idx != (path.length - 1)
            pathStr += ", "
        else
            pathStr += "\n"
        end
    end

    return pathStr
end


require 'minitest'
class Day11Test < Minitest::Test
    def test_findAllPaths
        init(TEST_INPUT)
        assert_equal 226, findAllCavePaths(false)
    end

    def test_findAllPathsVisitTwice
        init(TEST_INPUT)
        assert_equal 3509, findAllCavePaths(true)
    end 

end
Minitest.run []



puts ""
puts "ACTUAL INPUT"
input = File.read('2021/Day12_Input.txt')

puts "PART 1"
init(input)
findAllCavePaths(false)

puts "PART 2"
init(input)
findAllCavePaths(true)
