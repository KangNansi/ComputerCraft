os.loadAPI("lzos/gui")

local currentEvent = nil

function waitForEvent()
    while true do
        currentEvent = os.pullEvent()
    end
end

function printEvent()
    while true do
        if currentEvent != nil then
            print(currentEvent)
            currentEvent = nil
        end
    end
end

parallel.waitForAny(waitForEvent, printEvent)

