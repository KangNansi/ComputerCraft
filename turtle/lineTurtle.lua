os.loadAPI("lzos/turtle/turtleHelper")

args = {...}
blockName = args[1]
max = tonumber(args[2]) or 1000

distance = 0

function goBack()
    if distance > 0 then
        turtle.back()
        distance = distance - 1
        return false
    else
        return true
    end
end

function placeState()
    turtleHelper.placeDown(blockName)
    turtle.forward()
    distance = distance + 1
    return false
end

state = placeState

while true do
    if turtle.getFuelLevel() < 5 then
        turtleHelper.refill()
    end
    if state() then
        break
    end

    if state ~= goBack and (distance >= max) then
        state = goBack
    end
end