mon = peripheral.wrap("top")
mon.setBackgroundColor(colors.black)
mon.clear()

guiID = 1


--Button Saves
buttonsCallback = {}
buttonsG = {}
buttonsL = {}
buttonsY = {}

function screenReset()

    for i=1, #buttonsCallback do
        buttonsCallback[i] = nil
        buttonsG[i] = nil
        buttonsL[i] = nil
        buttonsY[i] = nil
    end

    guiID = 1
    mon.setBackgroundColor(colors.black)
    mon.setTextColor(colors.white)
    mon.clear()
    sleep(0.1)
end

local function has_value (tab, val, mode)
    if mode == 0 then
        for index, value in ipairs(tab) do
            if value == val then
                return true
            end
        end
        return false
    elseif mode == 1 then
        for index, value in ipairs(tab) do
            if val > value then
                return true
            end
        end
        return false
    elseif mode == 2 then
        for index, value in ipairs(tab) do
            if val < value then
                return true
            end
        end
        return false
    end
end

local function find_index(tab, val)

    for index, value in ipairs(tab) do
        if val == value then
            return index
        end
    end

    return -1

end

function screenCheck()

    local event, side, x, y = os.pullEvent()

    if event == "monitor_touch" then
        print(x .. " " .. y .. "   " .. tostring(has_value(buttonsL, x, 1)) .. "   " .. tostring(has_value(buttonsG, x, 2)) .. "   " .. tostring(has_value(buttonsY, y, 0)))
        x1 = has_value(buttonsL, x, 1)
        x2 = has_value(buttonsG, x, 2)
        l = has_value(buttonsY, y, 0)
        if x1 == true and x2 == true and l == true then
            callback = buttonsCallback[find_index(buttonsY, y)]
            callback()
        end
    end
end

local button = {

    new = function(self)
        local new = {}
        setmetatable(new, {__index = self})
        return new
    end,
    create = function(self, text, callback)

        mon.setBackgroundColor(colors.red)
        w, h = mon.getSize()
        mon.setCursorPos((w-string.len(text))/2+1, guiID)
        mon.write(" ", string.len(text))
        mon.setTextColor(colors.white)
        mon.setCursorPos((w-string.len(text))/2+1, guiID)
        mon.write(text)
        
        guiID = guiID + 1

        table.insert(buttonsCallback, callback)
        table.insert(buttonsG, string.len(text) + (w-string.len(text))/2+1)
        table.insert(buttonsL, (w-string.len(text))/2)
        table.insert(buttonsY, guiID - 1)
        
    end

}

--Api functions

function addLabel(text, times)
    w, h = mon.getSize()
    mon.setCursorPos((w-string.len(text) * times)/2+1, guiID)

    text2 = ""

    for i=1,times do
        text2 = text2 .. text
    end

    mon.write(text2, times)
    guiID = guiID + 1
end

function settings(fontSize)

    mon.setTextScale(fontSize)

end

function addSpacer()
    guiID = guiID + 1
end

function addButton(text, callback)

    newButton = button:new()
    newButton:create(text, callback)

end
