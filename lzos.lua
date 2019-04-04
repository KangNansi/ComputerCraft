os.loadAPI("lzos/gui")

local currentEvent = nil
local ep1, ep2, ep3
local quit = false

function IsIn(x,y, minx, miny, maxx, maxy)
    return x >= minx and x <= maxx and y >= miny and y <= maxy
end

function HandleEvent()
    if currentEvent == "mouse_click" and ep1 == 0 then
        if IsIn(ep2, ep3, 0, 0, 5, 1) then
            quit = true
        end
    end
end

while not quit do
    currentEvent, ep1, ep2, ep3 = os.pullEvent()
    HandleEvent()

    term.clear()
    term.setCursorPos(0,0)
    term.write("quit")
end

