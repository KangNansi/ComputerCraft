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

local function placeDirt()
    local present, block = turtle.inspectDown()
    if present and block.name ~= "minecraft:dirt" and block.name ~= "minecraft:grass" then
        turtle.digDown()
    end 
    if not present or not turtle.detectDown() then
        if turtleHelper.selectItem("minecraft:dirt") then
            turtle.placeDown()
        else
            print("ran out of dirt, terminating...")
            return false
        end
    end
    return true
end

for xi = 0, x do
    for xy = 0, y do
        if turtle.getFuelLevel() < 5 then
            turtleHelper.refill()
        end
        if not placeDirt() then
            return
        end
        turtle.dig()
        turtle.forward()
    end
    if xi % 2 == 0 then
        turtle.turnLeft()
        if not placeDirt() then
            return
        end
        turtle.dig()
        turtle.forward()
        turtle.turnLeft()
    else
        turtle.turnRight()
        if not placeDirt() then
            return
        end
        turtle.dig()
        turtle.forward()
        turtle.turnRight()
    end
end