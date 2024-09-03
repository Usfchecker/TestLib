-- GUI Library Module (GUI.lua)
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local GUI = {}

-- Function to load code from a GitHub URL
local function LoadCode(url)
    local response = HttpService:GetAsync(url)
    return loadstring(response)()
end

-- Main GUI creation function
function GUI:CreateGUI()
    -- Load additional code if needed
    local libraryCode = LoadCode("https://raw.githubusercontent.com/Usfchecker/TestLib/main/Testing.lua")

    -- Create the main frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = LocalPlayer:WaitForChild("PlayerGui")

    -- Create the title bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    titleBar.Parent = mainFrame

    -- Create the close button
    local closeButton = Instance.new("TextButton")
    closeButton.Text = "X"
    closeButton.Size = UDim2.new(0, 30, 1, 0)
    closeButton.Position = UDim2.new(1, -30, 0, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    closeButton.Parent = titleBar
    closeButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
    end)

    -- Create the open button
    local openButton = Instance.new("TextButton")
    openButton.Text = "Open"
    openButton.Size = UDim2.new(0, 60, 0, 30)
    openButton.Position = UDim2.new(0, 10, 0, 10)
    openButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    openButton.Parent = titleBar
    openButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
    end)

    -- Create the content frame for tabs and buttons
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, 0, 1, -30)
    contentFrame.Position = UDim2.new(0, 0, 0, 30)
    contentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    contentFrame.Parent = mainFrame

    -- Add drag and resize functionality
    local dragging = false
    local dragInput, mousePos, framePos

    local function updateInput(input)
        if dragging then
            local delta = input.Position - mousePos
            mainFrame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end

    local function onInputBegan(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragInput = input
            mousePos = input.Position
            framePos = mainFrame.Position
        end
    end

    local function onInputEnded(input)
        if input == dragInput then
            dragging = false
        end
    end

    mainFrame.InputBegan:Connect(onInputBegan)
    mainFrame.InputChanged:Connect(updateInput)
    mainFrame.InputEnded:Connect(onInputEnded)

    -- Create tab container
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, 0, 1, 0)
    tabContainer.Position = UDim2.new(0, 0, 0, 0)
    tabContainer.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    tabContainer.Parent = contentFrame

    function GUI:AddTab(tabName)
        local tabButton = Instance.new("TextButton")
        tabButton.Text = tabName
        tabButton.Size = UDim2.new(0, 100, 0, 30)
        tabButton.Position = UDim2.new(0, 0, 0, 0)
        tabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        tabButton.Parent = tabContainer
    end

    function GUI:AddButton(buttonName, callback)
        local button = Instance.new("TextButton")
        button.Text = buttonName
        button.Size = UDim2.new(0, 100, 0, 30)
        button.Position = UDim2.new(0, 0, 0, 30)
        button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        button.Parent = tabContainer
        button.MouseButton1Click:Connect(callback)
    end

    -- Make the GUI initially visible
    mainFrame.Visible = true

    return GUI
end

return GUI
