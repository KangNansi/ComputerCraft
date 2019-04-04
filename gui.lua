
currentEvent = nil
ep1, ep2, ep3

function IsIn(x,y, minx, miny, maxx, maxy)
    return x >= minx and x <= maxx and y >= miny and y <= maxy
end

function PullEvent()
    currentEvent, ep1, ep2, ep3 = os.pullEvent()
end

function Button(mon, title, x, y, w, h)
    mon.setCursorPos(x,y)
    mon.setTextColor(colors.black)
    mon.setBackgroundColor(colors.white)
    mon.write(title)
    clicked = currentEvent == "monitor_touch" and IsIn(ep2, ep3, x, y, x+w, y+h)
    return clicked
end