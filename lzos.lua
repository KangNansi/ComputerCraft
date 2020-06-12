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
        if gui.Button(mon, "..", 4, 3 + y, 15, 1, colors.white, colors.black) then
            currentPath = fs.getDir(currentPath)
        end
    end

    if gui.Button(mon, "+", 1, 4, 1, 1, colors.lightBlue, colors.black) then
        newFileName = ""
        state = AddNewFile
    end

    for _, file in ipairs(files) do
        y = y + 1
        if y  > scrollPos then
            if fs.isDir(fs.combine(currentPath, file)) then
                if gui.Button(mon, file, 4, 3 + y - scrollPos, 15, 1, colors.white, colors.black) then
                    currentPath = fs.combine(currentPath, file)
                end
            else
                if gui.Button(mon, file, 4, 3 + y - scrollPos, 15, 1) then
                    selectedFile = fs.combine(currentPath, file)
                    state = OnFileSelect
                end
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
    local posx = sizex/2 - 5

    if gui.Button(mon, "Back", posx, 4, 10, 1) then
        state = main
    end
    if gui.Button(mon, "Update", posx, 5, 10, 1) then
        clean()
        shell.run("update")
        os.reboot()
    end
    if gui.Button(mon, "Quit", posx, 6, 10, 1) then
        quit = true
    end
end

selectedFile = ""

function OnFileSelect()
    if gui.Button(mon, "Edit", 1, 4, 10, 1) then
        shell.run("edit /" .. selectedFile)
        state = main
    end
    if gui.Button(mon, "Run", 1, 5, 10, 1) then
        shell.run(selectedFile)
        state = main
    end
end

newFileName = ""

function AddNewFile()
    newFileName = gui.TextEdit(mon, newFileName, 1, 5)
    if gui.Button(mon, "Create", 1, 6, 10, 1) then
        state = main
    end
end

os.queueEvent("repaint")

while not quit do
    gui.PullEvent()
    
    mon.setBackgroundColor(colors.black)
    mon.clear()

    gui.Label(mon, "LZos v0.0.11", mon.getSize()/2-5, 1, colors.lightBlue)
    date = textUtils.formatTime(os.time(), true)
    dateLen = string.len(date)
    gui.Label(mon, date, mon.getSize() - dateLen, 1, colors.lightBlue)

    if gui.Button(mon, "O", 1, 1, 1, 1, colors.lightBlue, colors.black) then
        if state == menu then
            state = main
        else
            state = menu
        end
    end

    if state == menu then
        DrawMenu()
    elseif state == main then
        DrawCurrentPath()
    else
        state()
    end

    gui.EndLoop()
end

clean()


