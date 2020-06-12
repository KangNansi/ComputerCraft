
currentEvent = nil
ep1, ep2, ep3 = nil
repaint = false

idCount = 0
controlData = {}

cursorMonitor = nil
cursorPosX = 1
cursorPosY = 1

blinking = false

function getControlId()
    idCount = idCount + 1
    return idCount
end

function IsIn(x,y, minx, miny, maxx, maxy)
    return x >= minx and x <= maxx and y >= miny and y <= maxy
end

function PullEvent()
    currentEvent, ep1, ep2, ep3 = os.pullEvent()
    idCount = 0
    blinking = false
end

function EndLoop()
    if cursorMonitor and blinking then
        cursorMonitor.setCursorBlink(true)
        cursorMonitor.setCursorPos(cursorPosX, cursorPosY)
    end
    
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

function TextEdit(mon, currentText, x, y)
    controlId = getControlId()
    data = controlData[controlId] or {}
    data.cursorPos = data.cursorPos or 1

    if currentEvent == "key" then
        if ep1 == keys.backspace and string.len(currentText) > 0 then
            currentText = string.sub(currentText, 1, -2)
        end
    end
    if currentEvent == "char" then
        currentText = currentText..ep1
    end

    cursorMonitor = mon
    blinking = true
    cursorPosX = x + string.len(currentText)
    cursorPosY = y

    mon.setCursorPos(x,y)
    mon.setTextColor(colors.white)
    mon.setBackgroundColor(colors.black)
    mon.write(currentText)
    return currentText
end

function GetScroll()
    if currentEvent == "mouse_scroll" then
        repaint = true
        return ep1
    else
        return 0
    end
end