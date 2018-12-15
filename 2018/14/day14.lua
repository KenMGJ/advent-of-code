local level = 635041

local first_recipe = { score = 3, prev = nil, next = nil }
local second_recipe = { score = 7, prev = first_recipe, next = first_recipe }

first_recipe.prev = second_recipe
first_recipe.next = second_recipe

local first_elf = first_recipe
local second_elf = second_recipe

local last = second_recipe

local count = 2
while count < level + 10 do

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

end

local ptr = last
local last_ten = ""
for i = 1, 10 do
    last_ten = tostring( ptr.score ) .. last_ten
    ptr = ptr.prev
end

print(last_ten)