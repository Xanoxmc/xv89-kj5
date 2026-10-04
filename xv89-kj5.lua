local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "TentixWare"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = gethui and gethui() or lp.PlayerGui

-- Затемнение
local overlay = Instance.new("Frame")
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.BackgroundColor3 = Color3.fromRGB(5, 5, 12)
overlay.BackgroundTransparency = 1
overlay.BorderSizePixel = 0
overlay.ZIndex = 5
overlay.Visible = false
overlay.Parent = gui

-- Блюр
local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = game.Lighting

-- HUD бар
local hud = Instance.new("Frame")
hud.Size = UDim2.new(1, 0, 0, 40)
hud.Position = UDim2.new(0, 0, 1, -40)
hud.BackgroundColor3 = Color3.fromRGB(13, 13, 22)
hud.BorderSizePixel = 0
hud.ZIndex = 10
hud.Parent = gui

local hudLine = Instance.new("Frame")
hudLine.Size = UDim2.new(1, 0, 0, 1)
hudLine.Position = UDim2.new(0, 0, 0, 0)
hudLine.BackgroundColor3 = Color3.fromRGB(30, 30, 48)
hudLine.BorderSizePixel = 0
hudLine.ZIndex = 11
hudLine.Parent = hud

-- Логотип
local logo = Instance.new("Frame")
logo.Size = UDim2.new(0, 24, 0, 24)
logo.Position = UDim2.new(0, 12, 0.5, -12)
logo.BackgroundColor3 = Color3.fromRGB(124, 92, 252)
logo.BorderSizePixel = 0
logo.ZIndex = 11
logo.Parent = hud
Instance.new("UICorner", logo).CornerRadius = UDim.new(0, 6)

local logoText = Instance.new("TextLabel")
logoText.Size = UDim2.new(1, 0, 1, 0)
logoText.BackgroundTransparency = 1
logoText.Text = "TW"
logoText.TextColor3 = Color3.fromRGB(255, 255, 255)
logoText.TextSize = 10
logoText.Font = Enum.Font.GothamBold
logoText.ZIndex = 12
logoText.Parent = logo

-- Название
local nameLabel = Instance.new("TextLabel")
nameLabel.Size = UDim2.new(0, 100, 1, 0)
nameLabel.Position = UDim2.new(0, 44, 0, 0)
nameLabel.BackgroundTransparency = 1
nameLabel.Text = "TentixWare"
nameLabel.TextColor3 = Color3.fromRGB(200, 200, 224)
nameLabel.TextSize = 12
nameLabel.Font = Enum.Font.GothamBold
nameLabel.TextXAlignment = Enum.TextXAlignment.Left
nameLabel.ZIndex = 11
nameLabel.Parent = hud

-- Версия
local verLabel = Instance.new("TextLabel")
verLabel.Size = UDim2.new(0, 80, 0, 18)
verLabel.Position = UDim2.new(0, 148, 0.5, -9)
verLabel.BackgroundColor3 = Color3.fromRGB(20, 14, 38)
verLabel.TextColor3 = Color3.fromRGB(124, 92, 252)
verLabel.Text = "v0.1 alpha"
verLabel.TextSize = 10
verLabel.Font = Enum.Font.Gotham
verLabel.ZIndex = 11
verLabel.Parent = hud
Instance.new("UICorner", verLabel).CornerRadius = UDim.new(1, 0)
local verStroke = Instance.new("UIStroke")
verStroke.Color = Color3.fromRGB(124, 92, 252)
verStroke.Transparency = 0.7
verStroke.Thickness = 1
verStroke.Parent = verLabel

-- Время
local timeLabel = Instance.new("TextLabel")
timeLabel.Size = UDim2.new(0, 70, 1, 0)
timeLabel.Position = UDim2.new(1, -90, 0, 0)
timeLabel.BackgroundTransparency = 1
timeLabel.TextColor3 = Color3.fromRGB(90, 90, 120)
timeLabel.TextSize = 11
timeLabel.Font = Enum.Font.Gotham
timeLabel.ZIndex = 11
timeLabel.Parent = hud

-- Главная панель
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 320, 0, 240)
panel.Position = UDim2.new(0.5, -160, 0.5, -120)
panel.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
panel.BorderSizePixel = 0
panel.ZIndex = 10
panel.Visible = false
panel.Parent = gui
local panelCorner = Instance.new("UICorner", panel)
panelCorner.CornerRadius = UDim.new(0, 14)
local panelStroke = Instance.new("UIStroke", panel)
panelStroke.Color = Color3.fromRGB(34, 34, 58)
panelStroke.Thickness = 1

-- Шапка панели
local panelHead = Instance.new("Frame")
panelHead.Size = UDim2.new(1, 0, 0, 42)
panelHead.BackgroundColor3 = Color3.fromRGB(19, 19, 42)
panelHead.BorderSizePixel = 0
panelHead.ZIndex = 11
panelHead.Parent = panel
local phCorner = Instance.new("UICorner", panelHead)
phCorner.CornerRadius = UDim.new(0, 14)

local phFix = Instance.new("Frame")
phFix.Size = UDim2.new(1, 0, 0.5, 0)
phFix.Position = UDim2.new(0, 0, 0.5, 0)
phFix.BackgroundColor3 = Color3.fromRGB(19, 19, 42)
phFix.BorderSizePixel = 0
phFix.ZIndex = 11
phFix.Parent = panelHead

local phTitle = Instance.new("TextLabel")
phTitle.Size = UDim2.new(0.6, 0, 1, 0)
phTitle.Position = UDim2.new(0, 14, 0, 0)
phTitle.BackgroundTransparency = 1
phTitle.Text = "TentixWare"
phTitle.TextColor3 = Color3.fromRGB(208, 208, 232)
phTitle.TextSize = 13
phTitle.Font = Enum.Font.GothamBold
phTitle.TextXAlignment = Enum.TextXAlignment.Left
phTitle.ZIndex = 12
phTitle.Parent = panelHead

local phBadge = Instance.new("TextLabel")
phBadge.Size = UDim2.new(0, 52, 0, 18)
phBadge.Position = UDim2.new(1, -66, 0.5, -9)
phBadge.BackgroundColor3 = Color3.fromRGB(20, 14, 38)
phBadge.TextColor3 = Color3.fromRGB(124, 92, 252)
phBadge.Text = "ALPHA"
phBadge.TextSize = 9
phBadge.Font = Enum.Font.GothamBold
phBadge.ZIndex = 12
phBadge.Parent = panelHead
Instance.new("UICorner", phBadge).CornerRadius = UDim.new(1, 0)
local badgeStroke = Instance.new("UIStroke", phBadge)
badgeStroke.Color = Color3.fromRGB(124, 92, 252)
badgeStroke.Transparency = 0.7

-- Нижняя полоса панели
local panelFoot = Instance.new("Frame")
panelFoot.Size = UDim2.new(1, 0, 0, 34)
panelFoot.Position = UDim2.new(0, 0, 1, -34)
panelFoot.BackgroundColor3 = Color3.fromRGB(12, 12, 22)
panelFoot.BorderSizePixel = 0
panelFoot.ZIndex = 11
panelFoot.Parent = panel

local footLine = Instance.new("Frame")
footLine.Size = UDim2.new(1, 0, 0, 1)
footLine.BackgroundColor3 = Color3.fromRGB(26, 26, 48)
footLine.BorderSizePixel = 0
footLine.ZIndex = 12
footLine.Parent = panelFoot

local statusDot = Instance.new("Frame")
statusDot.Size = UDim2.new(0, 6, 0, 6)
statusDot.Position = UDim2.new(0, 14, 0.5, -3)
statusDot.BackgroundColor3 = Color3.fromRGB(62, 207, 110)
statusDot.BorderSizePixel = 0
statusDot.ZIndex = 12
statusDot.Parent = panelFoot
Instance.new("UICorner", statusDot).CornerRadius = UDim.new(1, 0)

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 80, 1, 0)
statusLabel.Position = UDim2.new(0, 26, 0, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "активен"
statusLabel.TextColor3 = Color3.fromRGB(58, 58, 90)
statusLabel.TextSize = 10
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.ZIndex = 12
statusLabel.Parent = panelFoot

-- Кнопка закрыть
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 62, 0, 22)
closeBtn.Position = UDim2.new(1, -76, 0.5, -11)
closeBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 40)
closeBtn.TextColor3 = Color3.fromRGB(74, 74, 106)
closeBtn.Text = "закрыть"
closeBtn.TextSize = 10
closeBtn.Font = Enum.Font.Gotham
closeBtn.ZIndex = 12
closeBtn.Parent = panelFoot
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
local closeBtnStroke = Instance.new("UIStroke", closeBtn)
closeBtnStroke.Color = Color3.fromRGB(37, 37, 64)

-- Логика открытия/закрытия
local isOpen = false

local function openPanel()
    isOpen = true
    overlay.Visible = true
    panel.Visible = true
    TweenService:Create(overlay, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundTransparency = 0.12}):Play()
    TweenService:Create(blur, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = 16}):Play()
end

local function closePanel()
    isOpen = false
    TweenService:Create(overlay, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
    TweenService:Create(blur, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Size = 0}):Play()
    task.delay(0.25, function()
        overlay.Visible = false
        panel.Visible = false
    end)
end

hud.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        if isOpen then closePanel() else openPanel() end
    end
end)

overlay.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        closePanel()
    end
end)

closeBtn.MouseButton1Click:Connect(closePanel)

-- Время
RunService.Heartbeat:Connect(function()
    local t = os.date("*t")
    timeLabel.Text = string.format("%02d:%02d:%02d", t.hour, t.min, t.sec)
end)
