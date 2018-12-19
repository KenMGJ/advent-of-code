local input_file = "input.txt"

local area = {}

local length = 0
local width = 1

for line in io.lines( input_file )
do
    length = length + 1

    area[ length ] = {}
    for j = 1, string.len( line )
    do
        area[ length ][ j ] = string.sub( line, j, j )
        width = j
    end
end

function print_area()
    for x = 1, length do
        for y = 1, width do
            io.write( area[ x ][ y ] )
        end
        print()
    end
end

function get_min_x_and_y( x, y )
    local min_x
    if x - 1 == 0 then min_x = x else min_x = x - 1 end
    local min_y
    if y - 1 == 0 then min_y = y else min_y = y - 1 end
    local max_x
    if x == length then max_x = length else max_x = x + 1 end
    local max_y
    if y == width then max_y = width else max_y = y + 1 end

    return min_x, min_y, max_x, max_y
end

function open_should_become_tree( x, y )
    local count = 0

    local min_x, min_y, max_x, max_y = get_min_x_and_y( x, y )

    for i = min_x, max_x do
        for j = min_y, max_y do
            if not (x == i and y == j ) and area[ i ][ j ] == '|' then
                count = count + 1
            end
        end
    end

    return count >= 3
end

function tree_should_become_lumberyard( x, y )
    local count = 0

    local min_x, min_y, max_x, max_y = get_min_x_and_y( x, y )

    for i = min_x, max_x do
        for j = min_y, max_y do
            if not (x == i and y == j ) and area[ i ][ j ] == '#' then
                count = count + 1
            end
        end
    end

    return count >= 3
end

function lumberyard_should_remain( x, y )
    local lumberyard_count = 0
    local tree_count = 0

    local min_x, min_y, max_x, max_y = get_min_x_and_y( x, y )

    for i = min_x, max_x do
        for j = min_y, max_y do
            if not (x == i and y == j ) then
                local value = area[ i ][ j ]
                if value == '|' then
                    tree_count = tree_count + 1
                elseif value == '#' then
                    lumberyard_count = lumberyard_count + 1
                end
            end
        end
    end

    return lumberyard_count > 0 and tree_count > 0
end

function calculate_value()
    local trees = 0
    local lumber = 0
    for x = 1, length do
        for y = 1, width do
            local value = area[ x ][ y ]
            if value == "|" then trees = trees + 1
            elseif value == "#" then lumber = lumber + 1 end
        end
    end
    return trees * lumber
end

for i = 1, 10 do
    local new_map = {}

    for x = 1, length do
        new_map[ x ] = {}

        for y = 1, width do
            local value = area[ x ][ y ]
            if value == '.' then
                if open_should_become_tree( x, y ) then
                    new_map[ x ][ y ] = "|"
                else
                    new_map[ x ][ y ] = value
                end
            elseif value == '|' then
                if tree_should_become_lumberyard( x, y ) then
                    new_map[ x ][ y ] = "#"
                else
                    new_map[ x ][ y ] = value
                end
            elseif value == '#' then
                if lumberyard_should_remain( x, y ) then
                    new_map[ x ][ y ] = "#"
                else
                    new_map[ x ][ y ] = "."
                end
            end
        end
    end

    area = new_map
end

print( calculate_value() )