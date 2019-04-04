os.loadAPI("lzos/gui")

local currentEvent = nil
local ep1, ep2, ep3
local quit = false

args = {...}

monitor = peripheral.wrap(args[1])

function IsIn(x,y, minx, miny, maxx, maxy)
    return x >= minx and x <= maxx and y >= miny and y <= maxy
end

function HandleEvent()
    if currentEvent == "monitor_touch" and ep1 == args[1] then
        if IsIn(ep2, ep3, 0, 0, 5, 1) then
            quit = true
        end
    end
end

while not quit do
    currentEvent, ep1, ep2, ep3 = os.pullEvent()
    HandleEvent()

    monitor.clear()
    monitor.setCursorPos(0,0)
    monitor.write("quit")
end

