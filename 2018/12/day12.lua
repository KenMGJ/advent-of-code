local input_file = "input.txt"

local state = nil
local rules = {}

for line in io.lines( input_file )
do
    if string.find( line, "initial state: " ) ~= nil then
        state = string.gsub( line, "initial state: ", "" )
    elseif string.find( line, " => " ) ~= nil then
        local b, e = string.find( line, " => " )
        local pattern = string.sub( line, 1, b - 1 )
        local result = string.sub( line, e + 1 )
        rules[ pattern ] = result
    end
end

local current_index = 0
local max_iterations = 50000000000
local i = 1
while i <= max_iterations
do

    local _state = state
    local _new = ""
    local sum = 0

    _state = '....' .. state .. '....'
    current_index = current_index - 2

    score = 0
    for j = 3, string.len( _state ) - 2
    do
        local sub = string.sub( _state, j - 2, j + 2 )
        if rules[ sub ] ~= nil then
            local val = rules[ sub ]
            if val == '#' then
                score = score + ( j - ( -1 * current_index ) - 3 )
            end
            _new = _new .. val
        else
            _new = _new .. "."
        end
    end

    local idx = string.find( _new, "#" )
    _new = string.sub( _new, idx )
    current_index = idx + current_index - 1
    _new = string.reverse( _new )
    idx = string.find( _new, "#" )
    _new = string.sub( _new, idx )
    _new = string.reverse( _new )

    if i == 20 then
        print( "part 1", score )
    end

    if _new == state then
        break
    else
        i = i + 1
        state = _new
    end
end

local diff = max_iterations - i
local new_index = current_index + diff

local new_score = 0
for j = 1, string.len( state )
do
    if string.sub( state, j, j ) == '#' then
        new_score = new_score + ( new_index + j - 1 )
    end
end

print( "part 2", new_score )