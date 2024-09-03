-- MainScript.lua
local GuiLib = {
    CreateScreenGui = function(parent)
        local screenGui = Instance.new("ScreenGui")
        screenGui.Parent = parent
        return screenGui
    end,

    CreateFrame = function(parent, size, position)
        local frame = Instance.new("Frame")
        frame.Size = size
        frame.Position = position
        frame.Parent = parent
        return frame
    end,

    CreateTab = function(parent, name)
        local tab = Instance.new("Frame")
        tab.Name = name
        tab.Parent = parent
        return tab
    end,

    CreateMenu = function(parent, title)
        local menu = Instance.new("TextButton")
        menu.Text = title
        menu.Parent = parent
        return menu
    end
}

local player = game.Players.LocalPlayer
local screenGui = GuiLib:CreateScreenGui(player.PlayerGui)

local mainFrame = GuiLib:CreateFrame(screenGui, UDim2.new(0, 300, 0, 200), UDim2.new(0.5, -150, 0.5, -100))

local tab1 = GuiLib:CreateTab(mainFrame, "Tab1")
tab1.Size = UDim2.new(1, 0, 0.5, 0)
tab1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

local menuButton = GuiLib:CreateMenu(tab1, "Menu1")
menuButton.Size = UDim2.new(0, 100, 0, 50)
menuButton.Position = UDim2.new(0.5, -50, 0.5, -25)
