os.loadAPI("lzos/gui")


local quit = false

args = {...}

mon = peripheral.wrap(args[1])

currentPath = "/"

function DrawCurrentPath()
    files = fs.list(currentPath)
    local y = 0
    if currentPath ~= "/" then
        if gui.Button(mon, "..", 4, 3 + y, 15, 1) then
            currentPath = fs.getDir(currentPath)
        end
    end
    for _, file in ipairs(files) do
        y = y + 1
        if fs.isDir(file) then
            if gui.Button(mon, file, 4, 3 + y, 15, 1) then
                currentPath = file
            end
        else
            gui.Label(mon, file, 4, 3 + y)
        end
    end
end

while not quit do
    gui.PullEvent()
    
    mon.clear()

    if gui.Button(mon, "quit", 1, 1, 5, 1) then
        quit = true
    end

    gui.Label(mon, "LZos v0.0.1", mon.getSize()/2-5, 1)

    DrawCurrentPath()
end

