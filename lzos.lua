os.loadAPI("lzos/gui")


local quit = false

local main, menu = 0, 1

local state = main

args = {...}

if #args > 1 then
    mon = peripheral.wrap(args[1])
else
    mon = peripheral.find("monitor")
end
if mon == nil then
    mon = term
end

currentPath = ""
scrollPos = 0

function DrawCurrentPath()
    files = fs.list(currentPath)
    local y = 0
    scrollPos = scrollPos + gui.GetScroll()
    if scrollPos < 0 then scrollPos = 0 end
    if scrollPos > #files then scrollPos = #files end
    if currentPath ~= "" and scrollPos <= 0 then
        if gui.Button(mon, "..", 4, 3 + y, 15, 1) then
            currentPath = fs.getDir(currentPath)
        end
    end
    for _, file in ipairs(files) do
        y = y + 1
        if y  > scrollPos then
            if fs.isDir(fs.combine(currentPath, file)) then
                if gui.Button(mon, file, 4, 3 + y - scrollPos, 15, 1) then
                    currentPath = fs.combine(currentPath, file)
                end
            else
                gui.Label(mon, file, 4, 3 + y - scrollPos)
            end
        end
    end
end

function clean()
    mon.setCursorPos(1,1)
    mon.setTextColor(colors.white)
    mon.setBackgroundColor(colors.black)
    mon.clear()
end

function DrawMenu()
    local sizex, sizey = mon.getSize()
    local posx = sizex - 5

    if gui.Button(mon, "quit", posx, 4, 10, 1) then
        quit = true
    end
    if gui.Button(mon, "update", posx, 5, 10, 1) then
        clean()
        shell.run("update")
        quit = true
    end
end

os.queueEvent("repaint")

while not quit do
    gui.PullEvent()
    
    mon.setBackgroundColor(colors.black)
    mon.clear()

    gui.Label(mon, "LZos v0.0.11", mon.getSize()/2-5, 1)

    if gui.Button(mon, "O", 1, 1, 1, 1) then
        state = menu
    end

    if state == menu then
        DrawMenu()
    elseif state == main then
        DrawCurrentPath()
    end

    gui.EndLoop()
end

clean()


