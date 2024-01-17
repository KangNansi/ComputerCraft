local path = fs.getDir(shell.getRunningProgram())
if path ~= '' then
    path = path.."/"
end
os.loadAPI(path.."turtleHelper")

local tArgs = { ... }
if #tArgs < 2 then
    print("usage: dirtFiller x y")
    return
end
local x = tArgs[1]
local y = tArgs[2]

for xi = 0, x do
    for xy = 0, y do
        if turtle.getFuelLevel() < 5 then
            turtleHelper.refill()
        end
        local present, block = turtle.inspectDown()
        if not present or not turtle.detectDown() then
            if turtleHelper.selectItem("minecraft:dirt") then
                turtle.placeDown()
            else
                print("ran out of dirt, terminating...")
                return
            end
        end
        turtle.forward()
    end
    if xi % 2 == 0 then
        turtle.turnLeft()
        turtle.forward()
        turtle.turnLeft()
    else
        turtle.turnRight()
        turtle.forward()
        turtle.turnRight()
    end
end