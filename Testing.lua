-- GuiLibrary.lua

-- Define the GuiLibrary table
local GuiLibrary = {}

-- Function to create a ScreenGui
function GuiLibrary:CreateScreenGui(name, parent)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = name or "ScreenGui"
    screenGui.Parent = parent or game.Players.LocalPlayer:WaitForChild("PlayerGui")
    return screenGui
end

-- Function to create a rounded frame
function GuiLibrary:CreateRoundedFrame(name, parent, size, position, color, cornerRadius)
    local frame = Instance.new("Frame")
    frame.Name = name or "RoundedFrame"
    frame.Size = size or UDim2.new(0, 200, 0, 200)
    frame.Position = position or UDim2.new(0.5, -100, 0.5, -100)
    frame.BackgroundColor3 = color or Color3.fromRGB(255, 255, 255)
    frame.Parent = parent

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = cornerRadius or UDim.new(0, 12)
    uiCorner.Parent = frame

    return frame
end

-- Function to create a button
function GuiLibrary:CreateButton(name, parent, text, size, position, color)
    local button = Instance.new("TextButton")
    button.Name = name or "Button"
    button.Text = text or "Button"
    button.Size = size or UDim2.new(0, 200, 0, 50)
    button.Position = position or UDim2.new(0, 0, 0, 0)
    button.BackgroundColor3 = color or Color3.fromRGB(255, 255, 255)
    button.TextColor3 = Color3.fromRGB(0, 0, 0)
    button.Parent = parent

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 12)
    uiCorner.Parent = button

    return button
end

-- Function to create a tab system
function GuiLibrary:CreateTabSystem(parent)
    local tabSystem = {}
    tabSystem.Tabs = {}
    tabSystem.ActiveTab = nil

    -- Create tab holder frame
    local tabHolder = self:CreateRoundedFrame("TabHolder", parent, UDim2.new(1, 0, 0, 50), UDim2.new(0, 0, 0, 0), Color3.fromRGB(50, 50, 50))
    tabSystem.TabHolder = tabHolder

    -- Create plus button for adding tabs
    local plusButton = self:CreateButton("PlusButton", tabHolder, "+", UDim2.new(0, 50, 0, 50), UDim2.new(1, -50, 0, 0), Color3.fromRGB(70, 70, 70))
    plusButton.TextScaled = true

    -- Function to add a tab
    function tabSystem:AddTab(name)
        local tabButton = GuiLibrary:CreateButton(name, tabHolder, name, UDim2.new(0, 100, 0, 50), UDim2.new(0, #self.Tabs * 100, 0, 0), Color3.fromRGB(100, 100, 100))

        -- Create the tab content frame
        local tabFrame = GuiLibrary:CreateRoundedFrame(name .. "Frame", parent, UDim2.new(1, 0, 1, -50), UDim2.new(0, 0, 0, 50), Color3.fromRGB(255, 255, 255))
        tabFrame.Visible = false

        tabButton.MouseButton1Click:Connect(function()
            if tabSystem.ActiveTab then
                tabSystem.ActiveTab.Frame.Visible = false
            end
            tabFrame.Visible = true
            tabSystem.ActiveTab = {Button = tabButton, Frame = tabFrame}
        end)

        -- Insert tab into the tab system
        table.insert(self.Tabs, {Button = tabButton, Frame = tabFrame})
    end

    plusButton.MouseButton1Click:Connect(function()
        local tabName = "Tab " .. (#tabSystem.Tabs + 1)
        tabSystem:AddTab(tabName)
    end)

    return tabSystem
end

-- Return the library table
return GuiLibrary
