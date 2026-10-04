local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "TentixWare"
gui.ResetOnSpawn = false
gui.Parent = gethui and gethui() or lp.PlayerGui

-- ====== ПОЛОСКА ======
local strip = Instance.new("Frame")
strip.Size = UDim2.new(0, 215, 0, 30)
strip.Position = UDim2.new(0, 0, 1, -30)
strip.BackgroundColor3 = Color3.fromRGB(9, 8, 18)
strip.BorderSizePixel = 0
strip.ZIndex = 20
strip.Active = true
strip.Draggable = true
strip.ClipsDescendants = true
strip.Parent = gui
Instance.new("UICorner", strip).CornerRadius = UDim.new(0, 8)

-- Белое сияние сверху
local shine = Instance.new("Frame")
shine.Size = UDim2.new(1, 0, 0, 1)
shine.Position = UDim2.new(0, 0, 0, 0)
shine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
shine.BackgroundTransparency = 0.55
shine.BorderSizePixel = 0
shine.ZIndex = 22
shine.Parent = strip

-- Белый градиент внутри (имитация сияния)
local glow = Instance.new("Frame")
glow.Size = UDim2.new(1, 0, 0.5, 0)
glow.Position = UDim2.new(0, 0, 0, 0)
glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
glow.BackgroundTransparency = 0.88
glow.BorderSizePixel = 0
glow.ZIndex = 21
glow.Parent = strip

-- Анимация сияния (движущийся блик)
local blik = Instance.new("Frame")
blik.Size = UDim2.new(0.3, 0, 1, 0)
blik.Position = UDim2.new(-0.3, 0, 0, 0)
blik.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
blik.BackgroundTransparency = 0.82
blik.BorderSizePixel = 0
blik.ZIndex = 23
blik.Parent = strip
Instance.new("UICorner", blik).CornerRadius = UDim.new(0.5, 0)

-- Название
local nameL = Instance.new("TextLabel")
nameL.Size = UDim2.new(0, 75, 1, 0)
nameL.Position = UDim2.new(0, 8, 0, 0)
nameL.BackgroundTransparency = 1
nameL.Text = "TentixWare"
nameL.TextColor3 = Color3.fromRGB(255, 255, 255)
nameL.TextTransparency = 0.08
nameL.TextSize = 11
nameL.Font = Enum.Font.GothamBold
nameL.TextXAlignment = Enum.TextXAlignment.Left
nameL.ZIndex = 25
nameL.Parent = strip

-- Версия
local verL = Instance.new("TextLabel")
verL.Size = UDim2.new(0, 62, 1, 0)
verL.Position = UDim2.new(0, 84, 0, 0)
verL.BackgroundTransparency = 1
verL.Text = "v: 0.1 Alpha"
verL.TextColor3 = Color3.fromRGB(255, 255, 255)
verL.TextTransparency = 0.52
verL.TextSize = 9
verL.Font = Enum.Font.Gotham
verL.TextXAlignment = Enum.TextXAlignment.Left
verL.ZIndex = 25
verL.Parent = strip

-- Разделитель
local div = Instance.new("Frame")
div.Size = UDim2.new(0, 1, 0, 14)
div.Position = UDim2.new(0, 148, 0.5, -7)
div.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
div.BackgroundTransparency = 0.88
div.BorderSizePixel = 0
div.ZIndex = 25
div.Parent = strip

-- FPS
local fpsL = Instance.new("TextLabel")
fpsL.Size = UDim2.new(0, 32, 1, 0)
fpsL.Position = UDim2.new(0, 152, 0, 0)
fpsL.BackgroundTransparency = 1
fpsL.Text = "--fps"
fpsL.TextColor3 = Color3.fromRGB(147, 200, 255)
fpsL.TextSize = 9
fpsL.Font = Enum.Font.GothamBold
fpsL.TextXAlignment = Enum.TextXAlignment.Left
fpsL.ZIndex = 25
fpsL.Parent = strip

local div2 = div:Clone()
div2.Position = UDim2.new(0, 183, 0.5, -7)
div2.Parent = strip

-- Пинг
local pingL = Instance.new("TextLabel")
pingL.Size = UDim2.new(0, 30, 1, 0)
pingL.Position = UDim2.new(0, 186, 0, 0)
pingL.BackgroundTransparency = 1
pingL.Text = "--ms"
pingL.TextColor3 = Color3.fromRGB(94, 234, 212)
pingL.TextSize = 9
pingL.Font = Enum.Font.GothamBold
pingL.TextXAlignment = Enum.TextXAlignment.Left
pingL.ZIndex = 25
pingL.Parent = strip

-- ====== ПАНЕЛЬ ======
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 270, 0, 180)
panel.Position = UDim2.new(0.5, -135, 0.5, -90)
panel.BackgroundColor3 = Color3.fromRGB(9, 8, 18)
panel.BorderSizePixel = 0
panel.ZIndex = 15
panel.Visible = false
panel.Active = true
panel.Draggable = true
panel.ClipsDescendants = true
panel.Parent = gui
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 16)

local pShine = Instance.new("Frame")
pShine.Size = UDim2.new(1, 0, 0, 1)
pShine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
pShine.BackgroundTransparency = 0.55
pShine.BorderSizePixel = 0
pShine.ZIndex = 16
pShine.Parent = panel

local pGlow = Instance.new("Frame")
pGlow.Size = UDim2.new(1, 0, 0.4, 0)
pGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
pGlow.BackgroundTransparency = 0.9
pGlow.BorderSizePixel = 0
pGlow.ZIndex = 16
pGlow.Parent = panel

-- Шапка панели
local pTitle = Instance.new("TextLabel")
pTitle.Size = UDim2.new(1, -50, 0, 38)
pTitle.Position = UDim2.new(0, 14, 0, 0)
pTitle.BackgroundTransparency = 1
pTitle.Text = "TentixWare  ·  v: 0.1 Alpha"
pTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
pTitle.TextTransparency = 0.1
pTitle.TextSize = 11
pTitle.Font = Enum.Font.GothamBold
pTitle.TextXAlignment = Enum.TextXAlignment.Left
pTitle.ZIndex = 20
pTitle.Parent = panel

local xBtn = Instance.new("TextButton")
xBtn.Size = UDim2.new(0, 22, 0, 22)
xBtn.Position = UDim2.new(1, -30, 0, 8)
xBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
xBtn.BackgroundTransparency = 0.9
xBtn.Text = "✕"
xBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
xBtn.TextTransparency = 0.4
xBtn.TextSize = 10
xBtn.Font = Enum.Font.GothamBold
xBtn.BorderSizePixel = 0
xBtn.ZIndex = 20
xBtn.Parent = panel
Instance.new("UICorner", xBtn).CornerRadius = UDim.new(1, 0)

local pdiv = Instance.new("Frame")
pdiv.Size = UDim2.new(1, -24, 0, 1)
pdiv.Position = UDim2.new(0, 12, 0, 38)
pdiv.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
pdiv.BackgroundTransparency = 0.9
pdiv.BorderSizePixel = 0
pdiv.ZIndex = 19
pdiv.Parent = panel

-- ====== SPEED HACK КНОПКА ======
local speedEnabled = false
local SPEED = 100 -- максимальное значение для MM2

local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(1, -24, 0, 42)
speedBtn.Position = UDim2.new(0, 12, 0, 48)
speedBtn.BackgroundColor3 = Color3.fromRGB(20, 16, 36)
speedBtn.BorderSizePixel = 0
speedBtn.Text = ""
speedBtn.ZIndex = 19
speedBtn.Parent = panel
Instance.new("UICorner", speedBtn).CornerRadius = UDim.new(0, 10)
local sbS = Instance.new("UIStroke", speedBtn)
sbS.Color = Color3.fromRGB(255, 255, 255)
sbS.Transparency = 0.88
sbS.Thickness = 0.5

local sbLabel = Instance.new("TextLabel")
sbLabel.Size = UDim2.new(1, -60, 1, 0)
sbLabel.Position = UDim2.new(0, 14, 0, 0)
sbLabel.BackgroundTransparency = 1
sbLabel.Text = "Speed Hack"
sbLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
sbLabel.TextTransparency = 0.1
sbLabel.TextSize = 11
sbLabel.Font = Enum.Font.GothamBold
sbLabel.TextXAlignment = Enum.TextXAlignment.Left
sbLabel.ZIndex = 20
sbLabel.Parent = speedBtn

local sbSub = Instance.new("TextLabel")
sbSub.Size = UDim2.new(1, -60, 0, 14)
sbSub.Position = UDim2.new(0, 14, 1, -16)
sbSub.BackgroundTransparency = 1
sbSub.Text = "speed: "..SPEED
sbSub.TextColor3 = Color3.fromRGB(255, 255, 255)
sbSub.TextTransparency = 0.6
sbSub.TextSize = 8.5
sbSub.Font = Enum.Font.Gotham
sbSub.TextXAlignment = Enum.TextXAlignment.Left
sbSub.ZIndex = 20
sbSub.Parent = speedBtn

-- Тоггл
local toggle = Instance.new("Frame")
toggle.Size = UDim2.new(0, 36, 0, 18)
toggle.Position = UDim2.new(1, -48, 0.5, -9)
toggle.BackgroundColor3 = Color3.fromRGB(40, 35, 60)
toggle.BorderSizePixel = 0
toggle.ZIndex = 20
toggle.Parent = speedBtn
Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)

local toggleDot = Instance.new("Frame")
toggleDot.Size = UDim2.new(0, 12, 0, 12)
toggleDot.Position = UDim2.new(0, 3, 0.5, -6)
toggleDot.BackgroundColor3 = Color3.fromRGB(160, 160, 180)
toggleDot.BorderSizePixel = 0
toggleDot.ZIndex = 21
toggleDot.Parent = toggle
Instance.new("UICorner", toggleDot).CornerRadius = UDim.new(1, 0)

local TweenService = game:GetService("TweenService")

local function setSpeed(on)
    speedEnabled = on
    local char = lp.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = on and SPEED or 16
        end
    end
    TweenService:Create(toggle, TweenInfo.new(0.2), {
        BackgroundColor3 = on and Color3.fromRGB(94,234,212) or Color3.fromRGB(40,35,60)
    }):Play()
    TweenService:Create(toggleDot, TweenInfo.new(0.2), {
        Position = on and UDim2.new(1,-15,0.5,-6) or UDim2.new(0,3,0.5,-6),
        BackgroundColor3 = on and Color3.fromRGB(255,255,255) or Color3.fromRGB(160,160,180)
    }):Play()
end

speedBtn.MouseButton1Click:Connect(function()
    setSpeed(not speedEnabled)
end)

-- Возобновление скорости после смерти
lp.CharacterAdded:Connect(function(char)
    if speedEnabled then
        task.wait(0.5)
        local hum = char:WaitForChild("Humanoid")
        if hum then hum.WalkSpeed = SPEED end
    end
end)

-- ====== ОТКРЫТИЕ / ЗАКРЫТИЕ ======
local isOpen = false
local startPos = nil

strip.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        startPos = i.Position
    end
end)

strip.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        if startPos and (i.Position - startPos).Magnitude < 8 then
            isOpen = not isOpen
            panel.Visible = isOpen
        end
        startPos = nil
    end
end)

xBtn.MouseButton1Click:Connect(function()
    isOpen = false; panel.Visible = false
end)

-- ====== АНИМАЦИЯ БЛИКА ======
local bt = 0
RunService.Heartbeat:Connect(function(dt)
    bt += dt * 0.5
    local x = (bt % 1.4) - 0.3
    blik.Position = UDim2.new(x, 0, 0, 0)
end)

-- ====== FPS И ПИНГ ======
local frames, elapsed = 0, 0
RunService.Heartbeat:Connect(function(dt)
    frames += 1; elapsed += dt
    if elapsed >= 0.7 then
        local fps = math.floor(frames / elapsed)
        fpsL.Text = fps.."fps"
        local fc = fps >= 55 and Color3.fromRGB(147,200,255)
            or fps >= 30 and Color3.fromRGB(251,191,36)
            or Color3.fromRGB(248,113,113)
        fpsL.TextColor3 = fc

        local ok, ping = pcall(function()
            return math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        if ok then
            pingL.Text = ping.."ms"
            local pc = ping < 60 and Color3.fromRGB(94,234,212)
                or ping < 100 and Color3.fromRGB(251,191,36)
                or Color3.fromRGB(248,113,113)
            pingL.TextColor3 = pc
        end
        frames = 0; elapsed = 0
    end
end)
