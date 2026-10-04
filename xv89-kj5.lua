local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "TentixWare"
gui.ResetOnSpawn = false
gui.Parent = gethui and gethui() or lp.PlayerGui

-- Водяная анимация через UIGradient
local function makeWaterGrad(parent)
    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(10,10,16)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(18,20,28)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(14,16,22)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(10,10,16)),
    })
    grad.Rotation = 135
    grad.Parent = parent
    -- Анимация сдвига
    local t = 0
    RunService.Heartbeat:Connect(function(dt)
        t += dt * 0.3
        grad.Offset = Vector2.new(math.sin(t)*0.4, math.cos(t*0.7)*0.2)
    end)
    return grad
end

-- ПОЛОСКА
local strip = Instance.new("Frame")
strip.Size = UDim2.new(0,208,0,32)
strip.Position = UDim2.new(0,10,0,10)
strip.BackgroundColor3 = Color3.fromRGB(11,11,17)
strip.BorderSizePixel = 0
strip.ZIndex = 20
strip.Active = true
strip.Parent = gui
Instance.new("UICorner",strip).CornerRadius = UDim.new(1,0)
makeWaterGrad(strip)
local ss = Instance.new("UIStroke",strip)
ss.Color = Color3.fromRGB(255,255,255)
ss.Transparency = 0.9

-- Лого
local logo = Instance.new("Frame")
logo.Size = UDim2.new(0,24,0,24)
logo.Position = UDim2.new(0,4,0.5,-12)
logo.BackgroundColor3 = Color3.fromRGB(13,13,20)
logo.BorderSizePixel = 0
logo.ZIndex = 21
logo.Parent = strip
Instance.new("UICorner",logo).CornerRadius = UDim.new(1,0)
local ls = Instance.new("UIStroke",logo)
ls.Color = Color3.fromRGB(255,255,255)
ls.Transparency = 0.88

local logoT = Instance.new("TextLabel")
logoT.Size = UDim2.new(1,0,1,0)
logoT.BackgroundTransparency = 1
logoT.Text = "⚡"
logoT.TextSize = 11
logoT.Font = Enum.Font.Gotham
logoT.ZIndex = 22
logoT.Parent = logo

-- Название
local nameL = Instance.new("TextLabel")
nameL.Size = UDim2.new(0,72,1,0)
nameL.Position = UDim2.new(0,33,0,0)
nameL.BackgroundTransparency = 1
nameL.Text = "TentixWare"
nameL.TextColor3 = Color3.fromRGB(228,225,245)
nameL.TextTransparency = 0.12
nameL.TextSize = 11
nameL.Font = Enum.Font.GothamBold
nameL.TextXAlignment = Enum.TextXAlignment.Left
nameL.ZIndex = 21
nameL.Parent = strip

-- Версия
local verBg = Instance.new("Frame")
verBg.Size = UDim2.new(0,62,0,16)
verBg.Position = UDim2.new(0,106,0.5,-8)
verBg.BackgroundColor3 = Color3.fromRGB(255,255,255)
verBg.BackgroundTransparency = 0.95
verBg.BorderSizePixel = 0
verBg.ZIndex = 21
verBg.Parent = strip
Instance.new("UICorner",verBg).CornerRadius = UDim.new(1,0)
local vs = Instance.new("UIStroke",verBg)
vs.Color = Color3.fromRGB(255,255,255)
vs.Transparency = 0.91

local verT = Instance.new("TextLabel")
verT.Size = UDim2.new(1,0,1,0)
verT.BackgroundTransparency = 1
verT.Text = "v: 0.1 Alpha"
verT.TextColor3 = Color3.fromRGB(255,255,255)
verT.TextTransparency = 0.62
verT.TextSize = 8.5
verT.Font = Enum.Font.GothamBold
verT.ZIndex = 22
verT.Parent = verBg

-- Разделитель
local function makeDivider(x)
    local d = Instance.new("Frame")
    d.Size = UDim2.new(0,1,0,12)
    d.Position = UDim2.new(0,x,0.5,-6)
    d.BackgroundColor3 = Color3.fromRGB(255,255,255)
    d.BackgroundTransparency = 0.92
    d.BorderSizePixel = 0
    d.ZIndex = 21
    d.Parent = strip
    return d
end
makeDivider(172)

-- Пинг
local pingL = Instance.new("TextLabel")
pingL.Size = UDim2.new(0,30,1,0)
pingL.Position = UDim2.new(0,175,0,0)
pingL.BackgroundTransparency = 1
pingL.Text = "--"
pingL.TextColor3 = Color3.fromRGB(94,234,212)
pingL.TextSize = 10
pingL.Font = Enum.Font.GothamBold
pingL.TextXAlignment = Enum.TextXAlignment.Left
pingL.ZIndex = 21
pingL.Parent = strip

-- ПАНЕЛЬ (центр экрана)
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0,290,0,300)
panel.Position = UDim2.new(0.5,-145,0.5,-150)
panel.BackgroundColor3 = Color3.fromRGB(11,11,17)
panel.BorderSizePixel = 0
panel.ZIndex = 15
panel.Visible = false
panel.Active = true
panel.Draggable = true
panel.Parent = gui
Instance.new("UICorner",panel).CornerRadius = UDim.new(0,22)
makeWaterGrad(panel)
local ps2 = Instance.new("UIStroke",panel)
ps2.Color = Color3.fromRGB(255,255,255)
ps2.Transparency = 0.91

-- Шапка панели
local ph = Instance.new("Frame")
ph.Size = UDim2.new(1,0,0,50)
ph.BackgroundTransparency = 1
ph.BorderSizePixel = 0
ph.ZIndex = 16
ph.Parent = panel

local phIc = Instance.new("Frame")
phIc.Size = UDim2.new(0,30,0,30)
phIc.Position = UDim2.new(0,12,0.5,-15)
phIc.BackgroundColor3 = Color3.fromRGB(13,13,20)
phIc.BorderSizePixel = 0
phIc.ZIndex = 17
phIc.Parent = ph
Instance.new("UICorner",phIc).CornerRadius = UDim.new(0,10)
local piS = Instance.new("UIStroke",phIc)
piS.Color = Color3.fromRGB(255,255,255)
piS.Transparency = 0.88

local phIcT = Instance.new("TextLabel")
phIcT.Size = UDim2.new(1,0,1,0)
phIcT.BackgroundTransparency = 1
phIcT.Text = "⚡"
phIcT.TextSize = 13
phIcT.Font = Enum.Font.Gotham
phIcT.ZIndex = 18
phIcT.Parent = phIc

local phTitle = Instance.new("TextLabel")
phTitle.Size = UDim2.new(0,130,0,18)
phTitle.Position = UDim2.new(0,48,0,8)
phTitle.BackgroundTransparency = 1
phTitle.Text = "TentixWare"
phTitle.TextColor3 = Color3.fromRGB(228,225,245)
phTitle.TextTransparency = 0.1
phTitle.TextSize = 12
phTitle.Font = Enum.Font.GothamBold
phTitle.TextXAlignment = Enum.TextXAlignment.Left
phTitle.ZIndex = 17
phTitle.Parent = ph

local phSub = Instance.new("TextLabel")
phSub.Size = UDim2.new(0,160,0,14)
phSub.Position = UDim2.new(0,48,0,26)
phSub.BackgroundTransparency = 1
phSub.Text = "v: 0.1 Alpha · injected"
phSub.TextColor3 = Color3.fromRGB(255,255,255)
phSub.TextTransparency = 0.72
phSub.TextSize = 9
phSub.Font = Enum.Font.Gotham
phSub.TextXAlignment = Enum.TextXAlignment.Left
phSub.ZIndex = 17
phSub.Parent = ph

local xBtn = Instance.new("TextButton")
xBtn.Size = UDim2.new(0,24,0,24)
xBtn.Position = UDim2.new(1,-36,0.5,-12)
xBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
xBtn.BackgroundTransparency = 0.94
xBtn.TextColor3 = Color3.fromRGB(255,255,255)
xBtn.TextTransparency = 0.55
xBtn.Text = "✕"
xBtn.TextSize = 11
xBtn.Font = Enum.Font.GothamBold
xBtn.BorderSizePixel = 0
xBtn.ZIndex = 17
xBtn.Parent = ph
Instance.new("UICorner",xBtn).CornerRadius = UDim.new(1,0)

-- Разделитель панели
local function makePanelDiv(y)
    local d = Instance.new("Frame")
    d.Size = UDim2.new(1,-24,0,1)
    d.Position = UDim2.new(0,12,0,y)
    d.BackgroundColor3 = Color3.fromRGB(255,255,255)
    d.BackgroundTransparency = 0.94
    d.BorderSizePixel = 0
    d.ZIndex = 16
    d.Parent = panel
end
makePanelDiv(50)

-- Стат-ячейки
local function makeCell(xPos, label, col)
    local cell = Instance.new("Frame")
    cell.Size = UDim2.new(0.5,-16,0,68)
    cell.Position = UDim2.new(xPos,0,0,60)
    cell.BackgroundColor3 = Color3.fromRGB(255,255,255)
    cell.BackgroundTransparency = 0.97
    cell.BorderSizePixel = 0
    cell.ZIndex = 16
    cell.Parent = panel
    Instance.new("UICorner",cell).CornerRadius = UDim.new(0,14)
    local cs = Instance.new("UIStroke",cell)
    cs.Color = Color3.fromRGB(255,255,255)
    cs.Transparency = 0.93

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1,-10,0,14)
    lbl.Position = UDim2.new(0,10,0,9)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(255,255,255)
    lbl.TextTransparency = 0.78
    lbl.TextSize = 8.5
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 17
    lbl.Parent = cell

    local val = Instance.new("TextLabel")
    val.Size = UDim2.new(1,-10,0,34)
    val.Position = UDim2.new(0,10,0,24)
    val.BackgroundTransparency = 1
    val.Text = "--"
    val.TextColor3 = col
    val.TextSize = 26
    val.Font = Enum.Font.GothamBold
    val.TextXAlignment = Enum.TextXAlignment.Left
    val.ZIndex = 17
    val.Parent = cell
    return val
end

local pingVal = makeCell(0,   "PING", Color3.fromRGB(94,234,212))
local fpsVal  = makeCell(0.5, "FPS",  Color3.fromRGB(147,197,253))
pingVal.Parent.Position = UDim2.new(0,12,0,60)
fpsVal.Parent.Position  = UDim2.new(0.5,4,0,60)

makePanelDiv(140)

-- Пустое тело
local emptyL = Instance.new("TextLabel")
emptyL.Size = UDim2.new(1,-24,0,60)
emptyL.Position = UDim2.new(0,12,0,150)
emptyL.BackgroundTransparency = 1
emptyL.Text = "— функции появятся здесь —"
emptyL.TextColor3 = Color3.fromRGB(255,255,255)
emptyL.TextTransparency = 0.87
emptyL.TextSize = 10
emptyL.Font = Enum.Font.Gotham
emptyL.ZIndex = 16
emptyL.Parent = panel

makePanelDiv(260)

-- Статус футер
local statusL = Instance.new("TextLabel")
statusL.Size = UDim2.new(0.5,0,0,28)
statusL.Position = UDim2.new(0,12,1,-32)
statusL.BackgroundTransparency = 1
statusL.Text = "● активен"
statusL.TextColor3 = Color3.fromRGB(94,234,212)
statusL.TextTransparency = 0.25
statusL.TextSize = 9.5
statusL.Font = Enum.Font.Gotham
statusL.TextXAlignment = Enum.TextXAlignment.Left
statusL.ZIndex = 17
statusL.Parent = panel

local buildL = Instance.new("TextLabel")
buildL.Size = UDim2.new(0.5,-12,0,28)
buildL.Position = UDim2.new(0.5,0,1,-32)
buildL.BackgroundTransparency = 1
buildL.Text = "build 001"
buildL.TextColor3 = Color3.fromRGB(255,255,255)
buildL.TextTransparency = 0.85
buildL.TextSize = 9.5
buildL.Font = Enum.Font.Gotham
buildL.TextXAlignment = Enum.TextXAlignment.Right
buildL.ZIndex = 17
buildL.Parent = panel

-- ЛОГИКА: тап vs перетаскивание
local isOpen = false
local dragStart = nil
local startPos = nil
local DRAG_THRESHOLD = 6

local function openPanel() isOpen = true; panel.Visible = true end
local function closePanel() isOpen = false; panel.Visible = false end

xBtn.MouseButton1Click:Connect(closePanel)

strip.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragStart = tick()
        startPos = input.Position
    end
end)

strip.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        if not startPos then return end
        local delta = (input.Position - startPos).Magnitude
        if delta < DRAG_THRESHOLD then
            if isOpen then closePanel() else openPanel() end
        end
        startPos = nil
    end
end)

-- Обновление FPS и пинга
local frames, elapsed = 0, 0
RunService.Heartbeat:Connect(function(dt)
    frames += 1; elapsed += dt
    if elapsed >= 0.7 then
        local fps = math.floor(frames / elapsed)
        fpsVal.Text = fps
        fpsL2 = fps
        local fc = fps >= 55 and Color3.fromRGB(147,197,253)
            or fps >= 30 and Color3.fromRGB(251,191,36)
            or Color3.fromRGB(248,113,113)
        fpsVal.TextColor3 = fc

        local ok, ping = pcall(function()
            return math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        if ok then
            pingL.Text = ping.."ms"
            pingVal.Text = ping
            local pc = ping < 60 and Color3.fromRGB(94,234,212)
                or ping < 100 and Color3.fromRGB(251,191,36)
                or Color3.fromRGB(248,113,113)
            pingL.TextColor3 = pc
            pingVal.TextColor3 = pc
        end
        frames = 0; elapsed = 0
    end
end)tbeat:Connect(function(dt)
    frames += 1; elapsed += dt
    if elapsed >= 0.6 then
        local fps = math.floor(frames / elapsed)
        fpsL.Text = fps
        fpsVal.Text = fps
        local fpsCol = fps >= 55 and Color3.fromRGB(96,165,250)
            or fps >= 30 and Color3.fromRGB(251,191,36)
            or Color3.fromRGB(248,113,113)
        fpsL.TextColor3 = fpsCol
        fpsVal.TextColor3 = fpsCol
        frames = 0; elapsed = 0

        local ok, ping = pcall(function()
            return math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        if ok then
            pingL.Text = ping
            pingVal.Text = ping
            local pCol = ping < 60 and Color3.fromRGB(52,211,153)
                or ping < 100 and Color3.fromRGB(251,191,36)
                or Color3.fromRGB(248,113,113)
            pingL.TextColor3 = pCol
            pingVal.TextColor3 = pCol
        end
    end
end)
