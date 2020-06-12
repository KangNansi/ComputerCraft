

function refill()
    for i = 0, 16 do
        turtle.select(i)
        if turtle.refuel() then
            return true
        end
    end
    return false
end

function fullRefill()
    while turtle.getFuelLevel() < turtle.getFuelLimit() do
        if not refill() then
            return false
        end
    end
    return true
end

function findItem(name)
    for i = 0, 16 do
        turtle.select(i)
        local detail = turtle.getItemDetail()
        if string.match(detail.name, name) then
            return i
        end
    end
    return -1
end

function selectItem(name)
    local itemSlot = findItem(name)
    if itemSlot >= 0 then
        turtle.select(itemSlot)
        return true
    end
    return false
end

function placeDown(name)
    if selectItem(name) then
        turtle.placeDown()
        return true
    else
        print("Item "..name.." not found.")
        return false
    end
end

