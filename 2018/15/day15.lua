local complex = require('lua/complex')

local map = {}

function is_goblin( c ) if map[ c ][ "type" ] == "G" then return true else return false end end
function is_elf( c ) if map[ c ][ "type" ] == "E" then return true else return false end end
function is_unit( c ) return is_goblin( c ) or is_elf( c ) end
function is_wall( c ) if map[ c ][ "type" ] == "#" then return true else return false end end
function is_open( c ) if map[ c ][ "type" ] == "." then return true else return false end end

local input_file = "test.txt"

local rows = 0
local columns = 0

for line in io.lines( input_file )
do
    rows = rows + 1

    for c = 1, string.len( line ) do
        local complex = complex.new( c, rows )
        map[ complex ] = { type = string.sub( line, c, c ) }
        columns = c
    end
end

function print_with_func( f )
    for r = 1, rows do
        for c = 1, columns do
            io.write( f( complex.new( c, r ) ) )
        end
        print()
    end
end

-- print_with_func( function(a) return map[ a ][ "type" ] end )
-- print_with_func( function(a) if is_goblin(a) then return "X" else return "." end end )
-- print_with_func( function(a) if is_elf(a) then return "X" else return "." end end )
-- print_with_func( function(a) if is_unit(a) then return "X" else return "." end end )
-- print_with_func( function(a) if is_wall(a) then return "X" else return "." end end )
-- print_with_func( function(a) if is_open(a) then return "X" else return "." end end )

function take_turn( unit )
    print( "take_turn", unit )
    -- move_into_range( unit )
    -- attack( unit )
end

local round = 0

while true do
    round = round + 1
    local turn_stack = {}

    -- Determine turn order
    for r = 1, rows do
        for c = 1, columns do
            local complex = complex.new( c, r )
            if is_unit( complex ) then
                table.insert( turn_stack, complex )
            end
        end
    end

    -- Take turns
    for _, c in pairs( turn_stack ) do
        take_turn( c )
    end

    break
end