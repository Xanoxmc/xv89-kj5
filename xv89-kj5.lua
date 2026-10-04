local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local lp = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "TentixWare"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = gethui and gethui() or lp.PlayerGui

-- ======= ТОПБАР =======
local topbar = Instance.new("Frame")
topbar.Size = UDim2.new(1, 0, 0, 36)
topbar.Position = UDim2.new(0, 0, 0, 0)
topbar.BackgroundColor3 = Color3.fromRGB(10, 10, 18)
topbar.BorderSizePixel = 0
topbar.ZIndex = 10
topbar.Parent = gui

local topLine = Instance.new("Frame")
topLine.Size = UDim2.new(1, 0, 0, 1)
topLine.Position = UDim2.new(0, 0, 1, -1)
topLine.BackgroundColor3 = Color3.fromRGB(124, 92, 252)
topLine.BorderSizePixel = 0
topLine.ZIndex = 11
topLine.Parent = topbar

-- Название
local nameL = Instance.new("TextLabel")
nameL.Size = UDim2.new(0, 120, 1, 0)
nameL.Position = UDim2.new(0, 10, 0, 0)
nameL.BackgroundTransparency = 1
nameL.Text = "TentixWare"
nameL.TextColor3 = Color3.fromRGB(255, 255, 255)
nameL.TextSize = 12
nameL.Font = Enum.Font.GothamBold
nameL.TextXAlignment = Enum.TextXAlignment.Left
nameL.ZIndex = 11
nameL.Parent = topbar

-- Версия
local verL = Instance.new("TextLabel")
verL.Size = UDim2.new(0, 60, 1, 0)
verL.Position = UDim2.new(0, 118, 0, 0)
verL.BackgroundTransparency = 1
verL.Text = "v0.1α"
verL.TextColor3 = Color3.fromRGB(124, 92, 252)
verL.TextSize = 10
verL.Font = Enum.Font.Gotham
verL.TextXAlignment = Enum.TextXAlignment.Left
verL.ZIndex = 11
verL.Parent = topbar

-- FPS
local fpsL = Instance.new("TextLabel")
fpsL.Size = UDim2.new(0, 50, 1, 0)
fpsL.Position = UDim2.new(0, 172, 0, 0)
fpsL.BackgroundTransparency = 1
fpsL.Text = "FPS: 0"
fpsL.TextColor3 = Color3.fromRGB(62, 207, 110)
fpsL.TextSize = 10
fpsL.Font = Enum.Font.Gotham
fpsL.TextXAlignment = Enum.TextXAlignment.Left
fpsL.ZIndex = 11
fpsL.Parent = topbar

-- Пинг
local pingL = Instance.new("TextLabel")
pingL.Size = UDim2.new(0, 55, 1, 0)
pingL.Position = UDim2.new(0, 222, 0, 0)
pingL.BackgroundTransparency = 1
pingL.Text = "PING: 0"
pingL.TextColor3 = Color3.fromRGB(255, 200, 60)
pingL.TextSize = 10
pingL.Font = Enum.Font.Gotham
pingL.TextXAlignment = Enum.TextXAlignment.Left
pingL.ZIndex = 11
pingL.Parent = topbar

-- Время
local timeL = Instance.new("TextLabel")
timeL.Size = UDim2.new(0, 65, 1, 0)
timeL.Position = UDim2.new(1, -70, 0, 0)
timeL.BackgroundTransparency = 1
timeL.Text = "00:00:00"
timeL.TextColor3 = Color3.fromRGB(160, 140, 255)
timeL.TextSize = 10
timeL.Font = Enum.Font.Gotham
timeL.TextXAlignment = Enum.TextXAlignment.Right
timeL.ZIndex = 11
timeL.Parent = topbar

-- ======= КНОПКА ОТКРЫТЬ (справа снизу) =======
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 42, 0, 42)
openBtn.Position = UDim2.new(1, -52, 1, -52)
openBtn.BackgroundColor3 = Color3.fromRGB(124, 92, 252)
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.Text = "TW"
openBtn.TextSize = 11
openBtn.Font = Enum.Font.GothamBold
openBtn.BorderSizePixel = 0
openBtn.ZIndex = 20
openBtn.Parent = gui
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)

-- ======= ЗАТЕМНЕНИЕ =======
local overlay = Instance.new("Frame")
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 8)
overlay.BackgroundTransparency = 1
overlay.BorderSizePixel = 0
overlay.ZIndex = 14
overlay.Visible = false
overlay.Parent = gui

local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = game.Lighting

-- ======= ГЛАВНАЯ ПАНЕЛЬ (подвижная) =======
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 300, 0, 340)
panel.Position = UDim2.new(0.5, -150, 0.5, -170)
panel.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
panel.BorderSizePixel = 0
panel.ZIndex = 15
panel.Visible = false
panel.Active = true
panel.Draggable = true
panel.Parent = gui
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 14)
local panelStroke = Instance.new("UIStroke", panel)
panelStroke.Color = Color3.fromRGB(124, 92, 252)
panelStroke.Transparency = 0.6
panelStroke.Thickness = 1

-- Шапка панели
local panelHead = Instance.new("Frame")
panelHead.Size = UDim2.new(1, 0, 0, 40)
panelHead.BackgroundColor3 = Color3.fromRGB(20, 16, 40)
panelHead.BorderSizePixel = 0
panelHead.ZIndex = 16
panelHead.Parent = panel
Instance.new("UICorner", panelHead).CornerRadius = UDim.new(0, 14)
local phFix = Instance.new("Frame")
phFix.Size = UDim2.new(1, 0, 0.5, 0)
phFix.Position = UDim2.new(0, 0, 0.5, 0)
phFix.BackgroundColor3 = Color3.fromRGB(20, 16, 40)
phFix.BorderSizePixel = 0
phFix.ZIndex = 16
phFix.Parent = panelHead

local phTitle = Instance.new("TextLabel")
phTitle.Size = UDim2.new(1, -50, 1, 0)
phTitle.Position = UDim2.new(0, 14, 0, 0)
phTitle.BackgroundTransparency = 1
phTitle.Text = "TentixWare  v0.1 alpha"
phTitle.TextColor3 = Color3.fromRGB(200, 180, 255)
phTitle.TextSize = 12
phTitle.Font = Enum.Font.GothamBold
phTitle.TextXAlignment = Enum.TextXAlignment.Left
phTitle.ZIndex = 17
phTitle.Parent = panelHead

-- Кнопка закрыть X
local closeX = Instance.new("TextButton")
closeX.Size = UDim2.new(0, 28, 0, 28)
closeX.Position = UDim2.new(1, -36, 0.5, -14)
closeX.BackgroundColor3 = Color3.fromRGB(40, 20, 60)
closeX.TextColor3 = Color3.fromRGB(200, 150, 255)
closeX.Text = "✕"
closeX.TextSize = 13
closeX.Font = Enum.Font.GothamBold
closeX.BorderSizePixel = 0
closeX.ZIndex = 18
closeX.Parent = panelHead
Instance.new("UICorner", closeX).CornerRadius = UDim.new(0, 6)

-- ======= НИЖНЯЯ ЧАСТЬ — ТАБЛИЦА ИГРОКОВ =======
local listTitle = Instance.new("TextLabel")
listTitle.Size = UDim2.new(1, -20, 0, 24)
listTitle.Position = UDim2.new(0, 10, 0, 46)
listTitle.BackgroundTransparency = 1
listTitle.Text = "[ ИГРОКИ В СЕССИИ ]"
listTitle.TextColor3 = Color3.fromRGB(124, 92, 252)
listTitle.TextSize = 11
listTitle.Font = Enum.Font.GothamBold
listTitle.TextXAlignment = Enum.TextXAlignment.Left
listTitle.ZIndex = 16
listTitle.Parent = panel

local divider = Instance.new("Frame")
divider.Size = UDim2.new(1, -20, 0, 1)
divider.Position = UDim2.new(0, 10, 0, 70)
divider.BackgroundColor3 = Color3.fromRGB(40, 30, 70)
divider.BorderSizePixel = 0
divider.ZIndex = 16
divider.Parent = panel

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -80)
scrollFrame.Position = UDim2.new(0, 5, 0, 76)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 2
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(124, 92, 252)
scrollFrame.ZIndex = 16
scrollFrame.Parent = panel

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 4)
listLayout.Parent = scrollFrame

-- ======= ФУНКЦИЯ ПОЛУЧЕНИЯ РОЛИ MM2 =======
local function getRole(player)
    local success, role = pcall(function()
        return player:FindFirstChild("Role") or player:FindFirstChild("mm2role")
    end)
    if success and role then
        return tostring(role.Value):lower()
    end
    return "innocent"
end

local function getRoleColor(role)
    if role == "murderer" then
        return Color3.fromRGB(255, 60, 60), "[ УБИЙЦА ]"
    elseif role == "sheriff" then
        return Color3.fromRGB(60, 140, 255), "[ ШЕРИФ ]"
    else
        return Color3.fromRGB(180, 180, 180), "--"
    end
end

-- ======= ОБНОВЛЕНИЕ СПИСКА =======
local playerRows = {}

local function updateList()
    for _, v in pairs(scrollFrame:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end
    playerRows = {}

    for _, player in pairs(Players:GetPlayers()) do
        if player == lp then continue end

        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, -8, 0, 30)
        row.BackgroundColor3 = Color3.fromRGB(18, 14, 32)
        row.BorderSizePixel = 0
        row.ZIndex = 17
        row.Parent = scrollFrame
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

        local nameTag = Instance.new("TextLabel")
        nameTag.Size = UDim2.new(0.6, 0, 1, 0)
        nameTag.Position = UDim2.new(0, 10, 0, 0)
        nameTag.BackgroundTransparency = 1
        nameTag.Text = player.Name
        nameTag.TextColor3 = Color3.fromRGB(220, 220, 240)
        nameTag.TextSize = 11
        nameTag.Font = Enum.Font.Gotham
        nameTag.TextXAlignment = Enum.TextXAlignment.Left
        nameTag.ZIndex = 18
        nameTag.Parent = row

        local role = getRole(player)
        local roleColor, roleText = getRoleColor(role)

        local roleTag = Instance.new("TextLabel")
        roleTag.Size = UDim2.new(0.4, -10, 1, 0)
        roleTag.Position = UDim2.new(0.6, 0, 0, 0)
        roleTag.BackgroundTransparency = 1
        roleTag.Text = roleText
        roleTag.TextColor3 = roleColor
        roleTag.TextSize = 11
        roleTag.Font = Enum.Font.GothamBold
        roleTag.TextXAlignment = Enum.TextXAlignment.Right
        roleTag.ZIndex = 18
        roleTag.Parent = row

        table.insert(playerRows, {row = row, player = player, nameTag = nameTag, roleTag = roleTag})
    end

    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 8)
end

-- ======= ЛОГИКА ОТКРЫТИЯ/ЗАКРЫТИЯ =======
local isOpen = false

local function openPanel()
    isOpen = true
    overlay.Visible = true
    panel.Visible = true
    TweenService:Create(overlay, TweenInfo.new(0.3), {BackgroundTransparency = 0.15}):Play()
    TweenService:Create(blur, TweenInfo.new(0.3), {Size = 18}):Play()
    updateList()
end

local function closePanel()
    isOpen = false
    TweenService:Create(overlay, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
    TweenService:Create(blur, TweenInfo.new(0.25), {Size = 0}):Play()
    task.delay(0.25, function()
        overlay.Visible = false
        panel.Visible = false
    end)
end

openBtn.MouseButton1Click:Connect(function()
    if isOpen then closePanel() else openPanel() end
end)
closeX.MouseButton1Click:Connect(closePanel)
overlay.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then closePanel() end
end)

-- ======= ОБНОВЛЕНИЕ СТАТИСТИКИ =======
local lastFpsUpdate = 0
local frameCount = 0

RunService.Heartbeat:Connect(function(dt)
    frameCount += 1
    lastFpsUpdate += dt
    if lastFpsUpdate >= 0.5 then
        local fps = math.floor(frameCount / lastFpsUpdate)
        local fpsColor = fps >= 50 and Color3.fromRGB(62, 207, 110)
            or fps >= 30 and Color3.fromRGB(255, 200, 60)
            or Color3.fromRGB(255, 80, 80)
        fpsL.Text = "FPS: " .. fps
        fpsL.TextColor3 = fpsColor
        frameCount = 0
        lastFpsUpdate = 0
    end

    local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
    local pingColor = ping < 80 and Color3.fromRGB(62, 207, 110)
        or ping < 150 and Color3.fromRGB(255, 200, 60)
        or Color3.fromRGB(255, 80, 80)
    pingL.Text = "PING: " .. ping
    pingL.TextColor3 = pingColor

    local t = os.date("*t")
    timeL.Text = string.format("%02d:%02d:%02d", t.hour, t.min, t.sec)

    -- Обновление ролей в реальном времени
    if isOpen then
        for _, data in pairs(playerRows) do
            local role = getRole(data.player)
            local roleColor, roleText = getRoleColor(role)
            data.roleTag.Text = roleText
            data.roleTag.TextColor3 = roleColor
        end
    end
end)

-- Обновление при подключении/отключении игроков
Players.PlayerAdded:Connect(function()
    if isOpen then updateList() end
end)
Players.PlayerRemoving:Connect(function()
    if isOpen then updateList() end
end)
