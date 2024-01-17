local helper = os.loadAPI("turtleHelper")

local tArgs = { ... }
if #tArgs < 3 then
    print("usage: dirtFiller x y")
    return
end
local x = tArgs[1]
local y = tArgs[2]

for xi = 0, x do
    for xy = 0, y do
        if turtle.getFuelLevel() < 5 then
            helper.refill()
        end
        local present, block = turtle.inspectDown()
        if not present and helper.selectItem("minecraft:dirt") then
            turtle.placeDown()
        else
            print("ran out of dirt, terminating...")
            return
        end
    end
    if xi % 2 == 0 then
        turtle.turnLeft()
        turtle.turnLeft()
    else
        turtle.turnRight()
        turtle.turnRight()
    end
end