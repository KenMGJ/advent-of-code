points = {}

min_x = nil
min_y = nil

for line in io.lines("test.txt")
do

    point = {}

    -- Get position
    s = string.find(line, "<")
    e = string.find(line, ">")
    position = string.sub(line, s + 1, e - 1)

    c = string.find(position, ",")
    px = tonumber(string.sub(position, 0, c - 1))
    point["px"] = px
    py = tonumber(string.sub(position, c + 1))
    point["py"] = py

    -- Get velocity
    line = string.sub(line, e + 1)
    s = string.find(line, "<")
    e = string.find(line, ">")
    velocity = string.sub(line, s + 1, e - 1)

    c = string.find(velocity, ",")
    point["vx"] = tonumber(string.sub(velocity, 0, c - 1))
    point["vy"] = tonumber(string.sub(velocity, c + 1))

    table.insert(points, point)
end

for k,v in pairs(points)
do
    io.write(k)
    for k1, v1 in pairs(v)
    do
        io.write(k1, v1)
    end
    print()
end
