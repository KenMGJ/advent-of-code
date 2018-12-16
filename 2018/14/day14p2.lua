local Stack = require('lua/stack')

local input = 59414
local input_as_string = tostring(input)

local stack = Stack:new()
for i = string.len( input_as_string ), 1, -1 do
    stack:push( string.sub( input_as_string, i, i ) )
end
local seen = Stack:new()

local first_recipe = { score = 3, prev = nil, next = nil }
local second_recipe = { score = 7, prev = first_recipe, next = first_recipe }
first_recipe.prev = second_recipe ; first_recipe.next = second_recipe

local first_elf = first_recipe
local second_elf = second_recipe

local last = second_recipe

local count = 1
while not found do

    local new_score = first_elf.score + second_elf.score
    local new_score_as_string = tostring( new_score )

    for i = 1, string.len( new_score_as_string ) do
        local char = string.sub( new_score_as_string, i, i )
        local recipe = { score = tonumber( char ), prev = last, next = last.next }
        last.next = recipe
        last = recipe
        count = count + 1
    end

    for i = 1, first_elf.score + 1 do
        first_elf = first_elf.next
    end

    for i = 1, second_elf.score + 1 do
        second_elf = second_elf.next
    end

    if count > 50000000 then break end
end

io.write( first_recipe.score )
local ptr = first_recipe.next
while ptr ~= first_recipe do
    io.write( ptr.score )
    ptr = ptr.next
end