

function refill()
    local slot = turtle.getSelectedSlot()
    for i = 0, 15 do
        local t = (slot + i) % 16
        if t == 0 then
            t = 16
        end
        if slot ~= t then
            turtle.select(t)
        end
        if turtle.refuel(1) then
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
    local slot = turtle.getSelectedSlot()
    for i = 0, 15 do
        local t = (slot + i) % 16
        if t == 0 then t = 16 end
        if t ~= slot then
            turtle.select(t)
        end
        local detail = turtle.getItemDetail()
        if detail and string.match(detail.name, name) then
            return t
        end
    end
    return 0
end

function selectItem(name)
    local itemSlot = findItem(name)
    if itemSlot > 0 then
        turtle.select(itemSlot)
        return true
    end
    return false
end

function isItemSelected(name)
    local detail = turtle.getItemDetail()
    if detail and string.match(detail.name, name) then
        return true
    else
        return false
    end
end

function placeDown(name)
    if isItemSelected(name) or selectItem(name) then
        turtle.placeDown()
        return true
    else
        print("Item "..name.." not found.")
        return false
    end
end

