-- ZytraHub English Edition
-- Lightweight Mobile GUI
-- Version 1.0

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Remove an existing copy
local Existing = PlayerGui:FindFirstChild("ZytraHub")
if Existing then
    Existing:Destroy()
end

local Themes = {
    Purple = {
        Background = Color3.fromRGB(30, 20, 50),
        Border = Color3.fromRGB(180, 100, 255),
        Text = Color3.fromRGB(230, 210, 255),
        Button = Color3.fromRGB(55, 40, 75)
    },
    Orange = {
        Background = Color3.fromRGB(50, 30, 20),
        Border = Color3.fromRGB(255, 160, 60),
        Text = Color3.fromRGB(255, 220, 180),
        Button = Color3.fromRGB(75, 45, 30)
    },
    Blue = {
        Background = Color3.fromRGB(15, 20, 40),
        Border = Color3.fromRGB(80, 150, 255),
        Text = Color3.fromRGB(200, 220, 255),
        Button = Color3.fromRGB(25, 35, 70)
    }
}

local ThemeNames = {"Purple", "Orange", "Blue"}
local ThemeIndex = 1
local CurrentTheme = Themes.Purple

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZytraHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 10
ScreenGui.Parent = PlayerGui

-- Main window
local Main = Instance.new("Frame")
Main.Name = "MainWindow"
Main.Size = UDim2.new(0, 270, 0, 300)
Main.Position = UDim2.new(0.5, -135, 0.5, -150)
Main.BackgroundColor3 = CurrentTheme.Background
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

local Border = Instance.new("UIStroke")
Border.Color = CurrentTheme.Border
Border.Thickness = 2
Border.Parent = Main

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 35)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "ZytraHub English"
Title.TextColor3 = CurrentTheme.Text
Title.TextSize = 19
Title.Font = Enum.Font.GothamBold
Title.Parent = Main

-- Performance display
local Stats = Instance.new("TextLabel")
Stats.Size = UDim2.new(1, -24, 0, 42)
Stats.Position = UDim2.new(0, 12, 0, 42)
Stats.BackgroundTransparency = 1
Stats.Text = "FPS: --  |  Ping: -- ms"
Stats.TextColor3 = CurrentTheme.Text
Stats.TextSize = 13
Stats.Font = Enum.Font.Gotham
Stats.Parent = Main

local function CreateButton(text, y)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -24, 0, 35)
    Button.Position = UDim2.new(0, 12, 0, y)
    Button.BackgroundColor3 = CurrentTheme.Button
    Button.TextColor3 = CurrentTheme.Text
    Button.Text = text
    Button.TextSize = 14
    Button.Font = Enum.Font.GothamBold
    Button.AutoButtonColor = true
    Button.Parent = Main

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button

    return Button
end

local ESPButton = CreateButton("ESP: Visual Demo Only", 92)
local AimButton = CreateButton("Aimbot: Visual Demo Only", 134)
local ThemeButton = CreateButton("Theme: Purple", 176)
local HideButton = CreateButton("Hide Menu", 218)

local Notice = Instance.new("TextLabel")
Notice.Size = UDim2.new(1, -20, 0, 25)
Notice.Position = UDim2.new(0, 10, 1, -29)
Notice.BackgroundTransparency = 1
Notice.Text = "Mobile-friendly interface"
Notice.TextColor3 = CurrentTheme.Text
Notice.TextSize = 11
Notice.Font = Enum.Font.Gotham
Notice.Parent = Main

-- Floating reopen button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 105, 0, 40)
ToggleButton.Position = UDim2.new(1, -115, 0, 60)
ToggleButton.BackgroundColor3 = CurrentTheme.Background
ToggleButton.TextColor3 = CurrentTheme.Text
ToggleButton.Text = "Open ZytraHub"
ToggleButton.TextSize = 12
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Visible = false
ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 10)
ToggleCorner.Parent = ToggleButton

local ToggleBorder = Instance.new("UIStroke")
ToggleBorder.Color = CurrentTheme.Border
ToggleBorder.Parent = ToggleButton

-- Theme application
local function ApplyTheme()
    Main.BackgroundColor3 = CurrentTheme.Background
    Border.Color = CurrentTheme.Border
    Title.TextColor3 = CurrentTheme.Text
    Stats.TextColor3 = CurrentTheme.Text
    Notice.TextColor3 = CurrentTheme.Text

    for _, Object in ipairs(Main:GetChildren()) do
        if Object:IsA("TextButton") then
            Object.BackgroundColor3 = CurrentTheme.Button
            Object.TextColor3 = CurrentTheme.Text
        end
    end

    ToggleButton.BackgroundColor3 = CurrentTheme.Background
    ToggleButton.TextColor3 = CurrentTheme.Text
    ToggleBorder.Color = CurrentTheme.Border
end

-- Theme cycling
ThemeButton.Activated:Connect(function()
    ThemeIndex = (ThemeIndex % #ThemeNames) + 1
    local Name = ThemeNames[ThemeIndex]
    CurrentTheme = Themes[Name]
    ThemeButton.Text = "Theme: " .. Name
    ApplyTheme()
end)

-- Demonstration controls
local ESPEnabled = false
ESPButton.Activated:Connect(function()
    ESPEnabled = not ESPEnabled
    ESPButton.Text = ESPEnabled
        and "ESP Demo: ON"
        or "ESP: Visual Demo Only"
end)

local AimEnabled = false
AimButton.Activated:Connect(function()
    AimEnabled = not AimEnabled
    AimButton.Text = AimEnabled
        and "Aimbot Demo: ON"
        or "Aimbot: Visual Demo Only"
end)

-- Hide and reopen
HideButton.Activated:Connect(function()
    Main.Visible = false
    ToggleButton.Visible = true
end)

ToggleButton.Activated:Connect(function()
    Main.Visible = true
    ToggleButton.Visible = false
end)

-- Dragging with mouse or touch
local Dragging = false
local DragStart
local StartPosition

Title.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = Input.Position
        StartPosition = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if Dragging and (
        Input.UserInputType == Enum.UserInputType.MouseMovement
        or Input.UserInputType == Enum.UserInputType.Touch
    ) then
        local Delta = Input.Position - DragStart

        Main.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
    end
end)

-- Low-overhead performance display
local Frames = 0
local Elapsed = 0
local LastFPS = 0

RunService.Heartbeat:Connect(function(DeltaTime)
    Frames += 1
    Elapsed += DeltaTime

    if Elapsed >= 1 then
        LastFPS = math.floor(Frames / Elapsed + 0.5)
        Frames = 0
        Elapsed = 0

        local Ping = 0
        pcall(function()
            Ping = math.floor(Player:GetNetworkPing() * 1000 + 0.5)
        end)

        Stats.Text = "FPS: " .. LastFPS
            .. "  |  Ping: " .. Ping .. " ms"
    end
end)

print("ZytraHub English Edition loaded.")
