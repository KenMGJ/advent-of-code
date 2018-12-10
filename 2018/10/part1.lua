function calculate_area(min_x, max_x, min_y, max_y)
    return ( max_x - min_x ) * ( max_y - min_y );
end

points = {}

min_x = nil
min_y = nil
max_x = nil
max_y = nil

-- *******************************************************************
-- Read the file; Do initial calculations
-- *******************************************************************
for line in io.lines("input.txt")
do
    local point = {}

    -- Get position
    local s = string.find(line, "<")
    local e = string.find(line, ">")
    local position = string.sub(line, s + 1, e - 1)

    local c = string.find(position, ",")
    local px = tonumber(string.sub(position, 0, c - 1))
    point["px"] = px
    local py = tonumber(string.sub(position, c + 1))
    point["py"] = py

    if( min_x == nil or px < min_x ) then min_x = px end
    if( max_x == nil or px > max_x ) then max_x = px end
    if( min_y == nil or py < min_y ) then min_y = py end
    if( max_y == nil or py > max_y ) then max_y = py end

    -- Get velocity
    line = string.sub(line, e + 1)
    s = string.find(line, "<")
    e = string.find(line, ">")
    local velocity = string.sub(line, s + 1, e - 1)

    c = string.find(velocity, ",")
    point["vx"] = tonumber(string.sub(velocity, 0, c - 1))
    point["vy"] = tonumber(string.sub(velocity, c + 1))

    table.insert(points, point)
end

area = calculate_area( min_x, max_x, min_y, max_y )

i = 0
while( true )
do

    new_points = {}
    min_x = nil
    min_y = nil
    max_x = nil
    max_y = nil

    for k,v in pairs( points )
    do
        new_point = {}

        local px = v["px"] + v["vx"]
        new_point["px"] = px
        local py = v["py"] + v["vy"]
        new_point["py"] = v["py"] + v["vy"]

        if( min_x == nil or px < min_x ) then min_x = px end
        if( max_x == nil or px > max_x ) then max_x = px end
        if( min_y == nil or py < min_y ) then min_y = py end
        if( max_y == nil or py > max_y ) then max_y = py end

        new_point["vx"] = v["vx"]
        new_point["vy"] = v["vy"]

        new_points[k] = new_point
    end

    local new_area = calculate_area( min_x, max_x, min_y, max_y )

    if (new_area < area) then
        points = new_points
        area = new_area
    else
        break
    end

    i = i + 1
end

print( i )

sky = {}
for x = min_x, max_x, 1
do
    sky[x]= {}
    for y = min_y, max_y, 1
    do
        sky[x][y] = '.'
    end
end

for k, v in pairs( points )
do
    sky[v["px"]][v["py"]] = '#'
end

for y = min_y, max_y, 1
do
    for x = min_x, max_x, 1
    do
        io.write( sky[x][y], ' ' )
    end
    print()
end
