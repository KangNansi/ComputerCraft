os.loadAPI("lzos/gui")


local quit = false

args = {...}

mon = peripheral.wrap(args[1])



while not quit do
    gui.PullEvent()
    
    if gui.Button(mon, "quit", 1, 1, 5, 1) then
        quit = true
    end
end

