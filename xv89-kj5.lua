local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local lp = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "TentixWare"
gui.ResetOnSpawn = false
gui.Parent = gethui and gethui() or lp.PlayerGui

-- Полоска (левый верхний угол)
local strip = Instance.new("Frame")
strip.Size = UDim2.new(0, 220, 0, 32)
strip.Position = UDim2.new(0, 10, 0, 10)
strip.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
strip.BackgroundTransparency = 0.18
strip.BorderSizePixel = 0
strip.ZIndex = 10
strip.Active = true
strip.Parent = gui
Instance.new("UICorner", strip).CornerRadius = UDim.new(1, 0)
local ss = Instance.new("UIStroke", strip)
ss.Color = Color3.fromRGB(255,255,255)
ss.Transparency = 0.92
ss.Thickness = 0.5

-- Логотип-круг
local logoCircle = Instance.new("Frame")
logoCircle.Size = UDim2.new(0,22,0,22)
logoCircle.Position = UDim2.new(0,5,0.5,-11)
logoCircle.BackgroundColor3 = Color3.fromRGB(80,50,180)
logoCircle.BackgroundTransparency = 0.78
logoCircle.BorderSizePixel = 0
logoCircle.ZIndex = 11
logoCircle.Parent = strip
Instance.new("UICorner", logoCircle).CornerRadius = UDim.new(1,0)

local logoTxt = Instance.new("TextLabel")
logoTxt.Size = UDim2.new(1,0,1,0)
logoTxt.BackgroundTransparency = 1
logoTxt.Text = "⚡"
logoTxt.TextSize = 11
logoTxt.Font = Enum.Font.Gotham
logoTxt.ZIndex = 12
logoTxt.Parent = logoCircle

-- Название
local nameL = Instance.new("TextLabel")
nameL.Size = UDim2.new(0,80,1,0)
nameL.Position = UDim2.new(0,32,0,0)
nameL.BackgroundTransparency = 1
nameL.Text = "TentixWare"
nameL.TextColor3 = Color3.fromRGB(238,235,255)
nameL.TextTransparency = 0.05
nameL.TextSize = 11
nameL.Font = Enum.Font.GothamBold
nameL.TextXAlignment = Enum.TextXAlignment.Left
nameL.ZIndex = 11
nameL.Parent = strip

-- Точка
local dot = Instance.new("Frame")
dot.Size = UDim2.new(0,3,0,3)
dot.Position = UDim2.new(0,114,0.5,-1)
dot.BackgroundColor3 = Color3.fromRGB(255,255,255)
dot.BackgroundTransparency = 0.82
dot.BorderSizePixel = 0
dot.ZIndex = 11
dot.Parent = strip
Instance.new("UICorner",dot).CornerRadius = UDim.new(1,0)

-- Версия
local verL = Instance.new("TextLabel")
verL.Size = UDim2.new(0,55,1,0)
verL.Position = UDim2.new(0,120,0,0)
verL.BackgroundTransparency = 1
verL.Text = "v 0.1 Alpha"
verL.TextColor3 = Color3.fromRGB(160,148,220)
verL.TextTransparency = 0.3
verL.TextSize = 10
verL.Font = Enum.Font.Gotham
verL.TextXAlignment = Enum.TextXAlignment.Left
verL.ZIndex = 11
verL.Parent = strip

-- Разделитель
local div = Instance.new("Frame")
div.Size = UDim2.new(0,1,0,14)
div.Position = UDim2.new(0,176,0.5,-7)
div.BackgroundColor3 = Color3.fromRGB(255,255,255)
div.BackgroundTransparency = 0.9
div.BorderSizePixel = 0
div.ZIndex = 11
div.Parent = strip

-- Пинг
local pingL = Instance.new("TextLabel")
pingL.Size = UDim2.new(0,42,1,0)
pingL.Position = UDim2.new(0,180,0,0)
pingL.BackgroundTransparency = 1
pingL.Text = "42ms"
pingL.TextColor3 = Color3.fromRGB(52,211,153)
pingL.TextSize = 10
pingL.Font = Enum.Font.GothamBold
pingL.TextXAlignment = Enum.TextXAlignment.Left
pingL.ZIndex = 11
pingL.Parent = strip

-- Панель 4:3
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0,240,0,180)
panel.Position = UDim2.new(0,10,0,48)
panel.BackgroundColor3 = Color3.fromRGB(18,18,26)
panel.BackgroundTransparency = 0.12
panel.BorderSizePixel = 0
panel.ZIndex = 10
panel.Visible = false
panel.Active = true
panel.Draggable = true
panel.Parent = gui
Instance.new("UICorner",panel).CornerRadius = UDim.new(0,18)
local ps = Instance.new("UIStroke",panel)
ps.Color = Color3.fromRGB(255,255,255)
ps.Transparency = 0.93
ps.Thickness = 0.5

-- Открытие по клику на полоску
local isOpen = false
strip.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        isOpen = not isOpen
        panel.Visible = isOpen
    end
end)

-- Обновление пинга и FPS
local frames, elapsed = 0, 0
RunService.Heartbeat:Connect(function(dt)
    frames += 1
    elapsed += dt
    if elapsed >= 0.8 then
        local ok, ping = pcall(function()
            return math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        if ok then
            pingL.Text = ping.."ms"
            if ping < 60 then
                pingL.TextColor3 = Color3.fromRGB(52,211,153)
            elseif ping < 100 then
                pingL.TextColor3 = Color3.fromRGB(251,191,36)
            else
                pingL.TextColor3 = Color3.fromRGB(248,113,113)
            end
        end
        frames = 0
        elapsed = 0
    end
end)ect(closePanel)
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
