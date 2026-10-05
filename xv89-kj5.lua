local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")
local lp = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "TentixWare"
gui.ResetOnSpawn = false
gui.Parent = gethui and gethui() or lp.PlayerGui

-- ====== ПОЛОСКА ======
local strip = Instance.new("Frame")
strip.Size = UDim2.new(0, 220, 0, 28)
strip.Position = UDim2.new(0, 6, 0, 6)
strip.BackgroundColor3 = Color3.fromRGB(8, 7, 16)
strip.BorderSizePixel = 0
strip.ZIndex = 20
strip.Active = true
strip.Draggable = true
strip.ClipsDescendants = true
strip.Parent = gui
Instance.new("UICorner", strip).CornerRadius = UDim.new(1, 0)

-- Обводка
local stripStroke = Instance.new("UIStroke", strip)
stripStroke.Color = Color3.fromRGB(255, 255, 255)
stripStroke.Transparency = 0.86
stripStroke.Thickness = 0.8

-- Белое сияние сверху
local topShine = Instance.new("Frame")
topShine.Size = UDim2.new(0.9, 0, 0, 1)
topShine.Position = UDim2.new(0.05, 0, 0, 0)
topShine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
topShine.BackgroundTransparency = 0.5
topShine.BorderSizePixel = 0
topShine.ZIndex = 22
topShine.Parent = strip
Instance.new("UICorner", topShine).CornerRadius = UDim.new(1, 0)

-- Движущийся блик
local blik = Instance.new("Frame")
blik.Size = UDim2.new(0.25, 0, 1, 0)
blik.Position = UDim2.new(-0.25, 0, 0, 0)
blik.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
blik.BackgroundTransparency = 0.78
blik.BorderSizePixel = 0
blik.ZIndex = 23
blik.Parent = strip
Instance.new("UICorner", blik).CornerRadius = UDim.new(0.5, 0)

-- TW логотип
local twLabel = Instance.new("TextLabel")
twLabel.Size = UDim2.new(0, 22, 0, 22)
twLabel.Position = UDim2.new(0, 3, 0.5, -11)
twLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
twLabel.BackgroundTransparency = 0.88
twLabel.Text = "TW"
twLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
twLabel.TextTransparency = 0.2
twLabel.TextSize = 8
twLabel.Font = Enum.Font.GothamBold
twLabel.ZIndex = 25
twLabel.Parent = strip
Instance.new("UICorner", twLabel).CornerRadius = UDim.new(1, 0)

-- Название
local nameL = Instance.new("TextLabel")
nameL.Size = UDim2.new(0, 68, 1, 0)
nameL.Position = UDim2.new(0, 28, 0, 0)
nameL.BackgroundTransparency = 1
nameL.Text = "TentixWare"
nameL.TextColor3 = Color3.fromRGB(255, 255, 255)
nameL.TextTransparency = 0.05
nameL.TextSize = 10.5
nameL.Font = Enum.Font.GothamBold
nameL.TextXAlignment = Enum.TextXAlignment.Left
nameL.ZIndex = 25
nameL.Parent = strip

-- Версия
local verL = Instance.new("TextLabel")
verL.Size = UDim2.new(0, 58, 1, 0)
verL.Position = UDim2.new(0, 96, 0, 0)
verL.BackgroundTransparency = 1
verL.Text = "v: 0.1 Alpha"
verL.TextColor3 = Color3.fromRGB(255, 255, 255)
verL.TextTransparency = 0.58
verL.TextSize = 8.5
verL.Font = Enum.Font.Gotham
verL.TextXAlignment = Enum.TextXAlignment.Left
verL.ZIndex = 25
verL.Parent = strip

-- Разделитель 1
local function mkDiv(x)
    local d = Instance.new("Frame")
    d.Size = UDim2.new(0, 1, 0, 12)
    d.Position = UDim2.new(0, x, 0.5, -6)
    d.BackgroundColor3 = Color3.fromRGB(255,255,255)
    d.BackgroundTransparency = 0.88
    d.BorderSizePixel = 0
    d.ZIndex = 25
    d.Parent = strip
end
mkDiv(156)

-- FPS
local fpsL = Instance.new("TextLabel")
fpsL.Size = UDim2.new(0, 30, 1, 0)
fpsL.Position = UDim2.new(0, 159, 0, 0)
fpsL.BackgroundTransparency = 1
fpsL.Text = "--"
fpsL.TextColor3 = Color3.fromRGB(147, 200, 255)
fpsL.TextSize = 9
fpsL.Font = Enum.Font.GothamBold
fpsL.TextXAlignment = Enum.TextXAlignment.Left
fpsL.ZIndex = 25
fpsL.Parent = strip

mkDiv(188)

-- Пинг
local pingL = Instance.new("TextLabel")
pingL.Size = UDim2.new(0, 30, 1, 0)
pingL.Position = UDim2.new(0, 191, 0, 0)
pingL.BackgroundTransparency = 1
pingL.Text = "--"
pingL.TextColor3 = Color3.fromRGB(94, 234, 212)
pingL.TextSize = 9
pingL.Font = Enum.Font.GothamBold
pingL.TextXAlignment = Enum.TextXAlignment.Left
pingL.ZIndex = 25
pingL.Parent = strip

-- ====== ПАНЕЛЬ ======
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 268, 0, 200)
panel.Position = UDim2.new(0.5, -134, 0.5, -100)
panel.BackgroundColor3 = Color3.fromRGB(8, 7, 16)
panel.BorderSizePixel = 0
panel.ZIndex = 15
panel.Visible = false
panel.Active = true
panel.Draggable = true
panel.ClipsDescendants = true
panel.Parent = gui
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 16)

local pStroke = Instance.new("UIStroke", panel)
pStroke.Color = Color3.fromRGB(255,255,255)
pStroke.Transparency = 0.86
pStroke.Thickness = 0.8

-- Сияние панели
local pShine = Instance.new("Frame")
pShine.Size = UDim2.new(0.85, 0, 0, 1)
pShine.Position = UDim2.new(0.075, 0, 0, 0)
pShine.BackgroundColor3 = Color3.fromRGB(255,255,255)
pShine.BackgroundTransparency = 0.5
pShine.BorderSizePixel = 0
pShine.ZIndex = 16
pShine.Parent = panel
Instance.new("UICorner", pShine).CornerRadius = UDim.new(1,0)

-- Шапка
local pHead = Instance.new("Frame")
pHead.Size = UDim2.new(1, 0, 0, 38)
pHead.BackgroundTransparency = 1
pHead.ZIndex = 16
pHead.Parent = panel

local pName = Instance.new("TextLabel")
pName.Size = UDim2.new(1, -44, 1, 0)
pName.Position = UDim2.new(0, 14, 0, 0)
pName.BackgroundTransparency = 1
pName.Text = "TentixWare  ·  v: 0.1 Alpha"
pName.TextColor3 = Color3.fromRGB(255,255,255)
pName.TextTransparency = 0.08
pName.TextSize = 11
pName.Font = Enum.Font.GothamBold
pName.TextXAlignment = Enum.TextXAlignment.Left
pName.ZIndex = 17
pName.Parent = pHead

local xBtn = Instance.new("TextButton")
xBtn.Size = UDim2.new(0, 22, 0, 22)
xBtn.Position = UDim2.new(1, -30, 0.5, -11)
xBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
xBtn.BackgroundTransparency = 0.91
xBtn.Text = "✕"
xBtn.TextColor3 = Color3.fromRGB(255,255,255)
xBtn.TextTransparency = 0.35
xBtn.TextSize = 10
xBtn.Font = Enum.Font.GothamBold
xBtn.BorderSizePixel = 0
xBtn.ZIndex = 17
xBtn.Parent = pHead
Instance.new("UICorner", xBtn).CornerRadius = UDim.new(1,0)

local headDiv = Instance.new("Frame")
headDiv.Size = UDim2.new(1, -24, 0, 1)
headDiv.Position = UDim2.new(0, 12, 0, 38)
headDiv.BackgroundColor3 = Color3.fromRGB(255,255,255)
headDiv.BackgroundTransparency = 0.9
headDiv.BorderSizePixel = 0
headDiv.ZIndex = 16
headDiv.Parent = panel

-- ====== SPEED HACK ======
local currentSpeed = 100
local speedEnabled = false

-- Карточка Speed
local card = Instance.new("Frame")
card.Size = UDim2.new(1, -24, 0, 110)
card.Position = UDim2.new(0, 12, 0, 48)
card.BackgroundColor3 = Color3.fromRGB(255,255,255)
card.BackgroundTransparency = 0.96
card.BorderSizePixel = 0
card.ZIndex = 16
card.Parent = panel
Instance.new("UICorner", card).CornerRadius = UDim.new(0, 12)
local cStroke = Instance.new("UIStroke", card)
cStroke.Color = Color3.fromRGB(255,255,255)
cStroke.Transparency = 0.9
cStroke.Thickness = 0.5

-- Заголовок карточки
local cardTitle = Instance.new("TextLabel")
cardTitle.Size = UDim2.new(0.6, 0, 0, 28)
cardTitle.Position = UDim2.new(0, 12, 0, 0)
cardTitle.BackgroundTransparency = 1
cardTitle.Text = "⚡ Speed Hack"
cardTitle.TextColor3 = Color3.fromRGB(255,255,255)
cardTitle.TextTransparency = 0.08
cardTitle.TextSize = 11
cardTitle.Font = Enum.Font.GothamBold
cardTitle.TextXAlignment = Enum.TextXAlignment.Left
cardTitle.ZIndex = 17
cardTitle.Parent = card

-- Значение скорости
local speedValL = Instance.new("TextLabel")
speedValL.Size = UDim2.new(0.4, -12, 0, 28)
speedValL.Position = UDim2.new(0.6, 0, 0, 0)
speedValL.BackgroundTransparency = 1
speedValL.Text = "100"
speedValL.TextColor3 = Color3.fromRGB(147, 200, 255)
speedValL.TextTransparency = 0.1
speedValL.TextSize = 13
speedValL.Font = Enum.Font.GothamBold
speedValL.TextXAlignment = Enum.TextXAlignment.Right
speedValL.ZIndex = 17
speedValL.Parent = card

-- Тоггл
local tog = Instance.new("Frame")
tog.Size = UDim2.new(0, 34, 0, 17)
tog.Position = UDim2.new(1, -46, 0, 6)
tog.BackgroundColor3 = Color3.fromRGB(35, 30, 55)
tog.BorderSizePixel = 0
tog.ZIndex = 17
tog.Parent = card
Instance.new("UICorner", tog).CornerRadius = UDim.new(1,0)

local togDot = Instance.new("Frame")
togDot.Size = UDim2.new(0, 11, 0, 11)
togDot.Position = UDim2.new(0, 3, 0.5, -5.5)
togDot.BackgroundColor3 = Color3.fromRGB(120,115,140)
togDot.BorderSizePixel = 0
togDot.ZIndex = 18
togDot.Parent = tog
Instance.new("UICorner", togDot).CornerRadius = UDim.new(1,0)

-- Слайдер трек
local sliderTrack = Instance.new("Frame")
sliderTrack.Size = UDim2.new(1, -24, 0, 4)
sliderTrack.Position = UDim2.new(0, 12, 0, 36)
sliderTrack.BackgroundColor3 = Color3.fromRGB(255,255,255)
sliderTrack.BackgroundTransparency = 0.88
sliderTrack.BorderSizePixel = 0
sliderTrack.ZIndex = 17
sliderTrack.Parent = card
Instance.new("UICorner", sliderTrack).CornerRadius = UDim.new(1,0)

-- Слайдер заполнение
local sliderFill = Instance.new("Frame")
sliderFill.Size = UDim2.new(1, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(147, 200, 255)
sliderFill.BackgroundTransparency = 0.3
sliderFill.BorderSizePixel = 0
sliderFill.ZIndex = 18
sliderFill.Parent = sliderTrack
Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1,0)

-- Слайдер ручка
local sliderKnob = Instance.new("Frame")
sliderKnob.Size = UDim2.new(0, 14, 0, 14)
sliderKnob.Position = UDim2.new(1, -7, 0.5, -7)
sliderKnob.BackgroundColor3 = Color3.fromRGB(255,255,255)
sliderKnob.BackgroundTransparency = 0.1
sliderKnob.BorderSizePixel = 0
sliderKnob.ZIndex = 19
sliderKnob.Parent = sliderTrack
Instance.new("UICorner", sliderKnob).CornerRadius = UDim.new(1,0)

-- Метки слайдера
local minL = Instance.new("TextLabel")
minL.Size = UDim2.new(0, 30, 0, 16)
minL.Position = UDim2.new(0, 12, 0, 44)
minL.BackgroundTransparency = 1
minL.Text = "16"
minL.TextColor3 = Color3.fromRGB(255,255,255)
minL.TextTransparency = 0.72
minL.TextSize = 8
minL.Font = Enum.Font.Gotham
minL.TextXAlignment = Enum.TextXAlignment.Left
minL.ZIndex = 17
minL.Parent = card

local maxL = Instance.new("TextLabel")
maxL.Size = UDim2.new(0, 30, 0, 16)
maxL.Position = UDim2.new(1, -42, 0, 44)
maxL.BackgroundTransparency = 1
maxL.Text = "100"
maxL.TextColor3 = Color3.fromRGB(255,255,255)
maxL.TextTransparency = 0.72
maxL.TextSize = 8
maxL.Font = Enum.Font.Gotham
maxL.TextXAlignment = Enum.TextXAlignment.Right
maxL.ZIndex = 17
maxL.Parent = card

-- Описание
local speedDesc = Instance.new("TextLabel")
speedDesc.Size = UDim2.new(1, -24, 0, 20)
speedDesc.Position = UDim2.new(0, 12, 0, 62)
speedDesc.BackgroundTransparency = 1
speedDesc.Text = "Максимальная скорость без кика в MM2"
speedDesc.TextColor3 = Color3.fromRGB(255,255,255)
speedDesc.TextTransparency = 0.7
speedDesc.TextSize = 8.5
speedDesc.Font = Enum.Font.Gotham
speedDesc.TextXAlignment = Enum.TextXAlignment.Left
speedDesc.ZIndex = 17
speedDesc.Parent = card

-- Пресеты скорости
local presets = {{"Норм", 50}, {"Быстро", 75}, {"Макс", 100}}
for i, pr in ipairs(presets) do
    local pb = Instance.new("TextButton")
    pb.Size = UDim2.new(0, 68, 0, 22)
    pb.Position = UDim2.new(0, 12 + (i-1)*76, 0, 82)
    pb.BackgroundColor3 = Color3.fromRGB(255,255,255)
    pb.BackgroundTransparency = 0.9
    pb.Text = pr[1].." ("..pr[2]..")"
    pb.TextColor3 = Color3.fromRGB(255,255,255)
    pb.TextTransparency = 0.3
    pb.TextSize = 8.5
    pb.Font = Enum.Font.GothamBold
    pb.BorderSizePixel = 0
    pb.ZIndex = 17
    pb.Parent = card
    Instance.new("UICorner", pb).CornerRadius = UDim.new(0, 6)
    pb.MouseButton1Click:Connect(function()
        currentSpeed = pr[2]
        local pct = (currentSpeed - 16) / (100 - 16)
        sliderFill.Size = UDim2.new(pct, 0, 1, 0)
        sliderKnob.Position = UDim2.new(pct, -7, 0.5, -7)
        speedValL.Text = tostring(currentSpeed)
        if speedEnabled then
            local char = lp.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = currentSpeed end
            end
        end
    end)
end

-- Логика тоггла
local function applySpeed(on)
    speedEnabled = on
    local char = lp.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = on and currentSpeed or 16 end
    end
    TweenService:Create(tog, TweenInfo.new(0.18), {
        BackgroundColor3 = on and Color3.fromRGB(94,234,212) or Color3.fromRGB(35,30,55)
    }):Play()
    TweenService:Create(togDot, TweenInfo.new(0.18), {
        Position = on and UDim2.new(1,-14,0.5,-5.5) or UDim2.new(0,3,0.5,-5.5),
        BackgroundColor3 = on and Color3.fromRGB(255,255,255) or Color3.fromRGB(120,115,140)
    }):Play()
end

-- Клик по тогглу
local togBtn = Instance.new("TextButton")
togBtn.Size = UDim2.new(1, 0, 1, 0)
togBtn.BackgroundTransparency = 1
togBtn.Text = ""
togBtn.ZIndex = 20
togBtn.Parent = tog
togBtn.MouseButton1Click:Connect(function()
    applySpeed(not speedEnabled)
end)

-- Слайдер логика
local draggingSlider = false
sliderTrack.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        draggingSlider = true
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        draggingSlider = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(i)
    if draggingSlider and (i.UserInputType == Enum.UserInputType.MouseMovement
    or i.UserInputType == Enum.UserInputType.Touch) then
        local trackPos = sliderTrack.AbsolutePosition.X
        local trackSize = sliderTrack.AbsoluteSize.X
        local pct = math.clamp((i.Position.X - trackPos) / trackSize, 0, 1)
        currentSpeed = math.floor(16 + pct * (100 - 16))
        sliderFill.Size = UDim2.new(pct, 0, 1, 0)
        sliderKnob.Position = UDim2.new(pct, -7, 0.5, -7)
        speedValL.Text = tostring(currentSpeed)
        if speedEnabled then
            local char = lp.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = currentSpeed end
            end
        end
    end
end)

-- После смерти
lp.CharacterAdded:Connect(function(char)
    if speedEnabled then
        task.wait(0.5)
        local hum = char:WaitForChild("Humanoid")
        if hum then hum.WalkSpeed = currentSpeed end
    end
end)

-- ====== ОТКРЫТИЕ ======
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
            isOpen = not isOpen; panel.Visible = isOpen
        end
        startPos = nil
    end
end)
xBtn.MouseButton1Click:Connect(function() isOpen=false; panel.Visible=false end)

-- ====== БЛИК ======
local bt = 0
RunService.Heartbeat:Connect(function(dt)
    bt += dt * 0.45
    local x = (bt % 1.6) - 0.25
    blik.Position = UDim2.new(x, 0, 0, 0)
end)

-- ====== FPS + ПИНГ ======
local fr, el = 0, 0
RunService.Heartbeat:Connect(function(dt)
    fr+=1; el+=dt
    if el >= 0.7 then
        local fps = math.floor(fr/el)
        fpsL.Text = fps.."fps"
        fpsL.TextColor3 = fps>=55 and Color3.fromRGB(147,200,255) or fps>=30 and Color3.fromRGB(251,191,36) or Color3.fromRGB(248,113,113)
        local ok,p = pcall(function() return math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
        if ok then
            pingL.Text = p.."ms"
            pingL.TextColor3 = p<60 and Color3.fromRGB(94,234,212) or p<100 and Color3.fromRGB(251,191,36) or Color3.fromRGB(248,113,113)
        end
        fr=0; el=0
    end
end)3)
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
