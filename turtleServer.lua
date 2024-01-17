
local turtles = {}

local function drawState()
    term.clear()
    term.setCursorPos(1, 1)
    print("TurleServer v0.0.1")
    for id, turtle in pairs(turtles) do
        print(turtle.id .. "   " .. turtle.state)
    end
end

local function hello(id, args)
    turtles[id] = { id = id, state = "idle" }
end

local function bye(id, args)
    turtles[id] = nil
end

local function state(id, args)
    turtles[id].state = args[2]
end

local handlers = {
    hello = hello,
    bye = bye,
    state = state
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