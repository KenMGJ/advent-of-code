local Node = { value = nil, next = nil }

function Node:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

local Stack = { count = 0, top = nil }

function Stack:new(o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
end

function Stack:push( value )
    local node = Node:new{ value = value, next = self.top }
    self.top = node
    self.count = self.count + 1
end

function Stack:peek()
    if self.top == nil then
        return nil
    else
        return self.top.value
    end
end

function Stack:pop()
    if self.top == nil then
        return nil
    else
        local top = self.top
        self.top = top.next
        self.count = self.count - 1
        return top.value
    end
end

function Stack:print()
    local node = self.top
    while node ~= nil do
        io.write(node.value, " ")
        node = node.next
    end
    print()
end

function Stack:isEmpty()
    return self.count == 0
end

return Stack