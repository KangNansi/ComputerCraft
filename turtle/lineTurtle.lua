os.loadAPI("turtleHelper.lua")

args = {...}
blockName = args[1]
max = args[2] or 1000

distance = 0

function goBack()
    if distance > 0 then
        turtle.back()
        return false
    else
        return true
    end
end

function placeState()
    turtleHelper.placeDown(blockName)
    turtle.forward()
end

state = placeState

while true do
    turtleHelper.fullRefill()
    state()
    if state ~= goBack and (turtle.getFuelLevel() / 2 < distance or distance >= max) then
        state = goBack
    end
end