grid_serial_number = 7165

function calculate_power_level( x, y )
    local rack_id = x + 10
    local power_level = rack_id * y
    power_level = power_level + grid_serial_number
    power_level = power_level * rack_id
    power_level = tostring( power_level )
    power_level = string.sub( power_level, -3, -3 )
    return tonumber( power_level ) - 5
end

grid = {}
for x = 1, 300 do
    grid[x] = {}
    for y = 1, 300 do
        grid[x][y] = calculate_power_level( x, y )
    end
end

function power_of_subgrid( x, y, size )
    local power = 0
    for i = x, x + ( size - 1 ) do
        for j = y, y + ( size - 1 ) do
            power = power + grid[i][j]
        end
    end
    return power
end

function calculate_max_power( size )

    x = nil
    y = nil
    max_power = nil

    local limit = 300 - size - 1
    for i = 1, limit do
        for j = 1, limit do
            local power = power_of_subgrid( i, j, size )
            if max_power == nil or max_power < power then
                x = i
                y = j
                max_power = power
            end
        end
    end

    return x, y, max_power

end

max_i = nil
max_x = nil
max_y = nil
max_power = nil

for i = 1, 300
do
    local x, y, power = calculate_max_power( i )
    if max_power == nil or power > max_power then
        max_i = i
        max_x = x
        max_y = y
        max_power = power
    end
    print( i )
end

print( max_i, "(", max_x, max_y, ")", max_power )
