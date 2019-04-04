os.loadAPI("lzos/gui")


local quit = false

args = {...}

mon = peripheral.wrap(args[1])



while not quit do
    gui.PullEvent()
    
    mon.clear()

    if gui.Button(mon, "quit", 1, 1, 5, 1) then
        quit = true
    end

    gui.Label(mon, "LZos v0.0.1", mon.getSize()/2-5, 1)
end

