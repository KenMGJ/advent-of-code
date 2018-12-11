
local grid_serial_number = 7165

function calculate_power_level( x, y )
    local rack_id = x + 10
    local power_level = rack_id * y
    power_level = power_level + grid_serial_number
    power_level = power_level * rack_id
    power_level = tostring( power_level )
    power_level = string.sub( power_level, -3, -3 )
    return tonumber( power_level ) - 5
end

local grid = {}
for x = 1, 300 do
    grid[ x ] = {}
    for y = 1, 300 do
        grid[x][y] = calculate_power_level( x, y )
    end
end

local results = {}
setmetatable( results, { __mode = "v" } ) -- make values weak
function get_sum_power( x, y, size )
    local key = x .. "-" .. y .. "-" .. size
    if results[ key ] then return results[ key ]
    else
        if size == 1 then
            local result = grid[x][y]
            results[ key ] = result
            return result
        else
            local result = get_sum_power( x, y, size - 1 ) + rest( x, y, size )
            results[ key ] = result
            return result
        end
    end
end

function rest( x, y, size )
    local sum = 0
    for i = x, x + size - 1
    do
        -- print( i, x, y, size )
        sum = sum + grid[i][y + size - 1]
    end
    for i = y, y + size - 2
    do
        sum = sum + grid[x + size - 1][i]
    end
    return sum
end

local max_size
local max_x
local max_y
local max_power

for size = 1, 300
do
    for i = 1, 300 - size + 1
    do
        for j = 1, 300 - size + 1
        do
            local power = get_sum_power( i, j, size )
            if max_power == nil or max_power < power
            then
                max_size = size
                max_x = i
                max_y = j
                max_power = power
            end
        end
    end
end

print( max_x .. "," .. max_y .. "," .. max_size )