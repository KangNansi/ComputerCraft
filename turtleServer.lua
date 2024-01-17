
local turtles = {}

local function drawState()
    term.clear()
    term.write("TurleServer v0.0.1")
    for id, turtle in turtles do
        term.write(turtle.id .. "   " .. turtle.state)
    end
end

local function hello(id, args)
    turtles[id] = { id = id, state = "idle" }
end

local function bye(id, args)
    turtles[id] = nil
end

local handlers = {
    hello = hello,
    bye = bye
}

while true do
    local id, msg = rednet.receive("turtle")
    local args = {}
    for arg in string.gmatch(msg, "[^%s]+") do
        args[#args + 1] = arg
    end
    if handlers[args[1]] ~= nil then
        handlers[args[1]](id, args)
    end

    drawState()
end