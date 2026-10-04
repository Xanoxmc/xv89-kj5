local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local lp = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "TentixWare"
gui.ResetOnSpawn = false
gui.Parent = gethui and gethui() or lp.PlayerGui

-- Подвижная полоска
local strip = Instance.new("Frame")
strip.Size = UDim2.new(0, 210, 0, 34)
strip.Position = UDim2.new(0, 10, 0, 10)
strip.BackgroundColor3 = Color3.fromRGB(255,255,255)
strip.BackgroundTransparency = 0.94
strip.BorderSizePixel = 0
strip.ZIndex = 20
strip.Active = true
strip.Draggable = true
strip.Parent = gui
Instance.new("UICorner", strip).CornerRadius = UDim.new(1,0)
local ss = Instance.new("UIStroke",strip)
ss.Color = Color3.fromRGB(255,255,255)
ss.Transparency = 0.88
ss.Thickness = 0.5

-- Лого
local logo = Instance.new("Frame")
logo.Size = UDim2.new(0,24,0,24)
logo.Position = UDim2.new(0,5,0.5,-12)
logo.BackgroundColor3 = Color3.fromRGB(139,92,246)
logo.BackgroundTransparency = 0.78
logo.BorderSizePixel = 0
logo.ZIndex = 21
logo.Parent = strip
Instance.new("UICorner",logo).CornerRadius = UDim.new(1,0)
local logoS = Instance.new("UIStroke",logo)
logoS.Color = Color3.fromRGB(139,92,246)
logoS.Transparency = 0.6

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
nameL.Size = UDim2.new(0,75,1,0)
nameL.Position = UDim2.new(0,34,0,0)
nameL.BackgroundTransparency = 1
nameL.Text = "TentixWare"
nameL.TextColor3 = Color3.fromRGB(245,242,255)
nameL.TextTransparency = 0.08
nameL.TextSize = 11
nameL.Font = Enum.Font.GothamBold
nameL.TextXAlignment = Enum.TextXAlignment.Left
nameL.ZIndex = 21
nameL.Parent = strip

-- Версия-бейдж
local verBg = Instance.new("Frame")
verBg.Size = UDim2.new(0,44,0,16)
verBg.Position = UDim2.new(0,110,0.5,-8)
verBg.BackgroundColor3 = Color3.fromRGB(139,92,246)
verBg.BackgroundTransparency = 0.88
verBg.BorderSizePixel = 0
verBg.ZIndex = 21
verBg.Parent = strip
Instance.new("UICorner",verBg).CornerRadius = UDim.new(1,0)
local verS2 = Instance.new("UIStroke",verBg)
verS2.Color = Color3.fromRGB(139,92,246)
verS2.Transparency = 0.75

local verL = Instance.new("TextLabel")
verL.Size = UDim2.new(1,0,1,0)
verL.BackgroundTransparency = 1
verL.Text = "v0.1 α"
verL.TextColor3 = Color3.fromRGB(167,139,250)
verL.TextSize = 9
verL.Font = Enum.Font.GothamBold
verL.ZIndex = 22
verL.Parent = verBg

-- Разделитель
local div1 = Instance.new("Frame")
div1.Size = UDim2.new(0,1,0,13)
div1.Position = UDim2.new(0,158,0.5,-6)
div1.BackgroundColor3 = Color3.fromRGB(255,255,255)
div1.BackgroundTransparency = 0.9
div1.BorderSizePixel = 0
div1.ZIndex = 21
div1.Parent = strip

-- Пинг
local pingL = Instance.new("TextLabel")
pingL.Size = UDim2.new(0,28,1,0)
pingL.Position = UDim2.new(0,163,0,0)
pingL.BackgroundTransparency = 1
pingL.Text = "--"
pingL.TextColor3 = Color3.fromRGB(52,211,153)
pingL.TextSize = 10
pingL.Font = Enum.Font.GothamBold
pingL.TextXAlignment = Enum.TextXAlignment.Left
pingL.ZIndex = 21
pingL.Parent = strip

-- Разделитель 2
local div2 = Instance.new("Frame")
div2.Size = UDim2.new(0,1,0,13)
div2.Position = UDim2.new(0,183,0.5,-6)
div2.BackgroundColor3 = Color3.fromRGB(255,255,255)
div2.BackgroundTransparency = 0.9
div2.BorderSizePixel = 0
div2.ZIndex = 21
div2.Parent = strip

-- FPS
local fpsL = Instance.new("TextLabel")
fpsL.Size = UDim2.new(0,26,1,0)
fpsL.Position = UDim2.new(0,186,0,0)
fpsL.BackgroundTransparency = 1
fpsL.Text = "--"
fpsL.TextColor3 = Color3.fromRGB(96,165,250)
fpsL.TextSize = 10
fpsL.Font = Enum.Font.GothamBold
fpsL.TextXAlignment = Enum.TextXAlignment.Left
fpsL.ZIndex = 21
fpsL.Parent = strip

-- Панель (по центру)
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0,300,0,320)
panel.Position = UDim2.new(0.5,-150,0.5,-160)
panel.BackgroundColor3 = Color3.fromRGB(16,16,24)
panel.BackgroundTransparency = 0.04
panel.BorderSizePixel = 0
panel.ZIndex = 15
panel.Visible = false
panel.Active = true
panel.Draggable = true
panel.Parent = gui
Instance.new("UICorner",panel).CornerRadius = UDim.new(0,24)
local ps = Instance.new("UIStroke",panel)
ps.Color = Color3.fromRGB(255,255,255)
ps.Transparency = 0.9

-- Шапка панели
local ph = Instance.new("Frame")
ph.Size = UDim2.new(1,0,0,52)
ph.BackgroundTransparency = 1
ph.BorderSizePixel = 0
ph.ZIndex = 16
ph.Parent = panel

local phIcon = Instance.new("Frame")
phIcon.Size = UDim2.new(0,32,0,32)
phIcon.Position = UDim2.new(0,14,0.5,-16)
phIcon.BackgroundColor3 = Color3.fromRGB(139,92,246)
phIcon.BackgroundTransparency = 0.82
phIcon.BorderSizePixel = 0
phIcon.ZIndex = 17
phIcon.Parent = ph
Instance.new("UICorner",phIcon).CornerRadius = UDim.new(0,10)

local phIconT = Instance.new("TextLabel")
phIconT.Size = UDim2.new(1,0,1,0)
phIconT.BackgroundTransparency = 1
phIconT.Text = "⚡"
phIconT.TextSize = 14
phIconT.Font = Enum.Font.Gotham
phIconT.ZIndex = 18
phIconT.Parent = phIcon

local phTitle = Instance.new("TextLabel")
phTitle.Size = UDim2.new(0,120,0,20)
phTitle.Position = UDim2.new(0,52,0,8)
phTitle.BackgroundTransparency = 1
phTitle.Text = "TentixWare"
phTitle.TextColor3 = Color3.fromRGB(245,242,255)
phTitle.TextTransparency = 0.08
phTitle.TextSize = 13
phTitle.Font = Enum.Font.GothamBold
phTitle.TextXAlignment = Enum.TextXAlignment.Left
phTitle.ZIndex = 17
phTitle.Parent = ph

local phSub = Instance.new("TextLabel")
phSub.Size = UDim2.new(0,140,0,14)
phSub.Position = UDim2.new(0,52,0,28)
phSub.BackgroundTransparency = 1
phSub.Text = "v0.1 Alpha · injected"
phSub.TextColor3 = Color3.fromRGB(255,255,255)
phSub.TextTransparency = 0.7
phSub.TextSize = 10
phSub.Font = Enum.Font.Gotham
phSub.TextXAlignment = Enum.TextXAlignment.Left
phSub.ZIndex = 17
phSub.Parent = ph

-- Кнопка X
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,26,0,26)
closeBtn.Position = UDim2.new(1,-40,0.5,-13)
closeBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
closeBtn.BackgroundTransparency = 0.93
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.TextTransparency = 0.5
closeBtn.Text = "✕"
closeBtn.TextSize = 11
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.ZIndex = 17
closeBtn.Parent = ph
Instance.new("UICorner",closeBtn).CornerRadius = UDim.new(1,0)

-- Разделитель панели
local pdiv = Instance.new("Frame")
pdiv.Size = UDim2.new(1,-28,0,1)
pdiv.Position = UDim2.new(0,14,0,52)
pdiv.BackgroundColor3 = Color3.fromRGB(255,255,255)
pdiv.BackgroundTransparency = 0.94
pdiv.BorderSizePixel = 0
pdiv.ZIndex = 16
pdiv.Parent = panel

-- Стат-ячейки
local function makeStatCell(pos, label, startVal, col)
    local cell = Instance.new("Frame")
    cell.Size = UDim2.new(0,126,0,70)
    cell.Position = pos
    cell.BackgroundColor3 = Color3.fromRGB(255,255,255)
    cell.BackgroundTransparency = 0.97
    cell.BorderSizePixel = 0
    cell.ZIndex = 16
    cell.Parent = panel
    Instance.new("UICorner",cell).CornerRadius = UDim.new(0,14)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1,-10,0,14)
    lbl.Position = UDim2.new(0,12,0,10)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(255,255,255)
    lbl.TextTransparency = 0.72
    lbl.TextSize = 9
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 17
    lbl.Parent = cell

    local val = Instance.new("TextLabel")
    val.Size = UDim2.new(1,-10,0,36)
    val.Position = UDim2.new(0,12,0,26)
    val.BackgroundTransparency = 1
    val.Text = startVal
    val.TextColor3 = col
    val.TextSize = 28
    val.Font = Enum.Font.GothamBold
    val.TextXAlignment = Enum.TextXAlignment.Left
    val.ZIndex = 17
    val.Parent = cell
    return val
end

local pingVal = makeStatCell(UDim2.new(0,14,0,62), "PING", "--", Color3.fromRGB(52,211,153))
local fpsVal = makeStatCell(UDim2.new(0,160,0,62), "FPS", "--", Color3.fromRGB(96,165,250))

-- Пустое тело
local emptyL = Instance.new("TextLabel")
emptyL.Size = UDim2.new(1,-28,0,30)
emptyL.Position = UDim2.new(0,14,0,148)
emptyL.BackgroundTransparency = 1
emptyL.Text = "— функции появятся здесь —"
emptyL.TextColor3 = Color3.fromRGB(255,255,255)
emptyL.TextTransparency = 0.86
emptyL.TextSize = 11
emptyL.Font = Enum.Font.Gotham
emptyL.ZIndex = 16
emptyL.Parent = panel

-- Футер
local footDiv = Instance.new("Frame")
footDiv.Size = UDim2.new(1,-28,0,1)
footDiv.Position = UDim2.new(0,14,1,-38)
footDiv.BackgroundColor3 = Color3.fromRGB(255,255,255)
footDiv.BackgroundTransparency = 0.94
footDiv.BorderSizePixel = 0
footDiv.ZIndex = 16
footDiv.Parent = panel

local statusL = Instance.new("TextLabel")
statusL.Size = UDim2.new(0.5,0,0,28)
statusL.Position = UDim2.new(0,14,1,-32)
statusL.BackgroundTransparency = 1
statusL.Text = "● активен"
statusL.TextColor3 = Color3.fromRGB(52,211,153)
statusL.TextTransparency = 0.2
statusL.TextSize = 10
statusL.Font = Enum.Font.Gotham
statusL.TextXAlignment = Enum.TextXAlignment.Left
statusL.ZIndex = 17
statusL.Parent = panel

local buildL = Instance.new("TextLabel")
buildL.Size = UDim2.new(0.5,0,0,28)
buildL.Position = UDim2.new(0.5,-14,1,-32)
buildL.BackgroundTransparency = 1
buildL.Text = "build 001"
buildL.TextColor3 = Color3.fromRGB(255,255,255)
buildL.TextTransparency = 0.82
buildL.TextSize = 10
buildL.Font = Enum.Font.Gotham
buildL.TextXAlignment = Enum.TextXAlignment.Right
buildL.ZIndex = 17
buildL.Parent = panel

-- Открытие/закрытие
local isOpen = false
strip.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        isOpen = not isOpen
        panel.Visible = isOpen
    end
end)
closeBtn.MouseButton1Click:Connect(function()
    isOpen = false; panel.Visible = false
end)

-- Обновление
local frames, elapsed = 0, 0
RunService.Heartbeat:Connect(function(dt)
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
