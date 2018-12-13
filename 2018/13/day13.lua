local input_file = "test.txt"

local map = {}

local row = 1
local col = 1

for line in io.lines( input_file ) do
    map[row] = {}
    
    local j = 1
    for c = 1, string.len( line ) do
        map[row][j] = string.sub( line, c, c )
        j = j + 1
    end

    if j > col then col = j end
    row = row + 1
end

