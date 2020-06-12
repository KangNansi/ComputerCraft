
currentEvent = nil
ep1, ep2, ep3 = nil
repaint = false

function IsIn(x,y, minx, miny, maxx, maxy)
    return x >= minx and x <= maxx and y >= miny and y <= maxy
end

function PullEvent()
    currentEvent, ep1, ep2, ep3 = os.pullEvent()
end

function EndLoop()
    if repaint then
        os.queueEvent("repaint")
        repaint = false
    end
end

function Button(mon, title, x, y, w, h, bgColor, fgColor)
    bgColor = bgColor or colors.black
    fgColor = fgColor or colors.white
    w = w or string.len(title)
    h = h or 1
    mon.setCursorPos(x,y)
    mon.setTextColor(fgColor)
    mon.setBackgroundColor(bgColor)
    mon.write(title)
    clicked = currentEvent == "mouse_click" and IsIn(ep2, ep3, x, y, x+w-1, y+h-1)
    if clicked then repaint = true end
    return clicked
end

function Label(mon, title, x, y, textColor, bgColor)
    textColor = textColor or colors.white
    bgColor = bgColor or colors.black
    mon.setCursorPos(x,y)
    mon.setTextColor(textColor)
    mon.setBackgroundColor(bgColor)
    mon.write(title)
end

function GetScroll()
    if currentEvent == "mouse_scroll" then
        repaint = true
        return ep1
    else
        return 0
    end
end