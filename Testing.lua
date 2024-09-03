-- GuiLib.lua
local GuiLib = {}

function GuiLib:CreateScreenGui(parent)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = parent
    return screenGui
end

function GuiLib:CreateFrame(parent, size, position)
    local frame = Instance.new("Frame")
    frame.Size = size
    frame.Position = position
    frame.Parent = parent
    return frame
end

function GuiLib:CreateTab(parent, name)
    local tab = Instance.new("Frame")
    tab.Name = name
    tab.Parent = parent
    return tab
end

function GuiLib:CreateMenu(parent, title)
    local menu = Instance.new("TextButton")
    menu.Text = title
    menu.Parent = parent
    return menu
end

return GuiLib
