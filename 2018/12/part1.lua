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

print( state )

local current_index = 0
for i = 1, 50000000000
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

    state = _new
end

print( score )