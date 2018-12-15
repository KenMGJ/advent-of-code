local input_file = "input.txt"

-- *******************************************
-- Define deque of cart directons
-- *******************************************
local up = { sym = "^", track = "|" }
local right = { sym = ">", track = "-" }
local down = { sym = "v", track = "|" }
local left = { sym = "<", track = "-" }

up.left = left ; up.right = right
up["/"] = right ; up["\\"] = left
right.left = up ; right.right = down
right["/"] = up ; right["\\"] = down
down.left = right ; down.right = left
down["/"] = left ; down["\\"] = right
left.left = down ; left.right = up
left["/"] = down ; left["\\"] = up

direction = {}
direction["^"] = up ; direction[">"] = right
direction["v"] = down ; direction["<"] = left
-- *******************************************

local map = {}
local carts = {}

local max_x = 1
local max_y = 1

for line in io.lines( input_file ) do
    map[max_y] = {}
    
    max_x = 1
    for c = 1, string.len( line ) do
        local ch = string.sub( line, c, c )
        map[max_y][max_x] = ch

        if ch == "<" or ch == ">" or ch == "^" or ch == "v" then
            local dir = direction[ch]
            carts[max_y .. "," .. max_x] = { dir = dir, turn = 0 }
            map[max_y][max_x] = dir.track
        end
 
        max_x = max_x + 1
    end

    max_y = max_y + 1
end

max_y = max_y - 1
max_x = max_x - 1

function print_map()
    for y = 1, max_y do
        for x = 1, max_x do
            io.write( map[y][x] )
        end
        print()
    end
end

function print_carts()
    for y = 1, max_y do
        for x = 1, max_x do
            local cart = carts[y .. "," .. x]
            if cart == nil then
                io.write(" ")
            else
                io.write( cart.dir.sym )
            end
        end
        print()
    end
end

function print_map_with_carts()
    for y = 1, max_y do
        for x = 1, max_x do
            local cart = carts[y .. "," .. x]
            if cart ~= nil then
                io.write( cart.dir.sym )
            else
                io.write( map[y][x] )
            end
        end
        print()
        print()
    end
end

local tick = 0
local one_left = false

function get_index( y, x )
    return y .. "," .. x
end

function new_cart_direction( cart, i, j )
    if map[i][j] == "\\" then
        cart.dir = cart.dir["\\"]
    elseif map[i][j] == "/" then
        cart.dir = cart.dir["/"]
    elseif map[i][j] == "+" then
        local next = cart.turn % 3
        if next == 0 then
            cart.dir = cart.dir.left
        elseif next == 2 then
            cart.dir = cart.dir.right
        end
        cart["turn"] = cart["turn"] + 1
    end
end

local found_y
local found_x

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
  end

local cart_count = tablelength( carts )
print( cart_count )

while not one_left do
    new_carts = {}

    for y = 1, max_y do
        if one_left then break end

        for x = 1, max_x do
            local idx = get_index( y, x )
            local cart = carts[idx]

            if cart ~= nil then
                -- print( tick, idx )

                local new_y = y
                local new_x = x

                local dir = cart.dir
                if dir.sym == "^" then
                    new_y = y - 1
                    new_x = x
                elseif dir.sym == ">" then
                    new_y = y
                    new_x = x + 1
                elseif dir.sym == "v" then
                    new_y = y + 1
                    new_x = x
                elseif dir.sym == "<" then
                    new_y = y
                    new_x = x - 1
                end

                new_cart_direction( cart, new_y, new_x )

                local next_index = get_index( new_y, new_x )
                if carts[next_index] ~= nil then
                    carts[next_index] = nil
                elseif new_carts[next_index] ~= nil then
                    new_carts[next_index] = nil
                else
                    carts[idx] = nil
                    new_carts[next_index] = cart
                end

            end
        end
    end

    tick = tick + 1
    carts = new_carts

    local new_cart_count = tablelength( carts )
    if new_cart_count ~= cart_count then
        cart_count = new_cart_count
        print( cart_count )
    end
    if new_cart_count == 1 then
        one_left = true
    end

end

for k, _ in pairs(carts) do
    local comma = string.find( k, "," )
    local row = tonumber(string.sub( k, comma + 1 )) - 1
    local column = tonumber(string.sub( k , 0, comma - 1 )) - 1 
    print( row .. "," .. column )
end