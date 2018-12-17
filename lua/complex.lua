complex = {}

local calculated = {}
local private = {}
function private.complexToString(t)
    local sym = ""
    if t.i >= 0 then
        sym = "+"
    end
    return t.r .. sym .. t.i .. "i"
end

function complex.new (r, i)

    -- We want to make sure that for r == r and i == i that new == new
    local create = false
    if calculated[r] == nil then
        calculated[r] = {}
        create = true
    elseif calculated[r][i] == nil then
        create = true
    end

    if create then
        local c = { r = r, i = i }
        setmetatable( c, { __tostring = private.complexToString } )
        calculated[r][i] = c
    end

    return calculated[r][i]
end
    
-- defines a constant `i'
complex.i = complex.new(0, 1)

function complex.add (c1, c2)
    return complex.new(c1.r + c2.r, c1.i + c2.i)
end

function complex.sub (c1, c2)
    return complex.new(c1.r - c2.r, c1.i - c2.i)
end

function complex.mul (c1, c2)
    return complex.new(c1.r*c2.r - c1.i*c2.i,
                        c1.r*c2.i + c1.i*c2.r)
end

function complex.inv (c)
    local n = c.r^2 + c.i^2
    return complex.new(c.r/n, -c.i/n)
end

return complex