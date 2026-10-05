local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")
local lp = Players.LocalPlayer

-- Удаляем старый GUI если есть
local old = lp.PlayerGui:FindFirstChild("TentixWare")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "TentixWare"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = gethui and gethui() or lp.PlayerGui

local unlocked = false
local guiOpen = false

-- ====== КНОПКА-ЗАМОК ======
local lockBtn = Instance.new("TextButton")
lockBtn.Size = UDim2.new(0, 46, 0, 46)
lockBtn.Position = UDim2.new(1, -58, 0.5, -23)
lockBtn.BackgroundColor3 = Color3.fromRGB(100, 95, 90)
lockBtn.BorderSizePixel = 0
lockBtn.Text = "🔒"
lockBtn.TextSize = 18
lockBtn.Font = Enum.Font.Gotham
lockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
lockBtn.ZIndex = 40
lockBtn.Active = true
lockBtn.Draggable = true
lockBtn.Parent = gui
Instance.new("UICorner", lockBtn).CornerRadius = UDim.new(1, 0)
local lockS = Instance.new("UIStroke", lockBtn)
lockS.Color = Color3.fromRGB(255, 255, 255)
lockS.Transparency = 0.82

-- ====== HUD ПОЛОСКИ (FPS | PING) ======
local hudLeft = Instance.new("Frame")
hudLeft.Size = UDim2.new(0, 0, 0, 46)
hudLeft.Position = UDim2.new(0.5, 0, 0.5, -23)
hudLeft.BackgroundColor3 = Color3.fromRGB(90, 85, 80)
hudLeft.BorderSizePixel = 0
hudLeft.ClipsDescendants = true
hudLeft.ZIndex = 10
hudLeft.Visible = false
hudLeft.Parent = gui
local hlc = Instance.new("UICorner", hudLeft)
hlc.CornerRadius = UDim.new(1, 0)

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(1, -10, 1, 0)
fpsLabel.Position = UDim2.new(0, 8, 0, 0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS  60"
fpsLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
fpsLabel.TextSize = 11
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextXAlignment = Enum.TextXAlignment.Right
fpsLabel.ZIndex = 11
fpsLabel.Parent = hudLeft

local hudRight = Instance.new("Frame")
hudRight.Size = UDim2.new(0, 0, 0, 46)
hudRight.Position = UDim2.new(0.5, 0, 0.5, -23)
hudRight.BackgroundColor3 = Color3.fromRGB(90, 85, 80)
hudRight.BorderSizePixel = 0
hudRight.ClipsDescendants = true
hudRight.ZIndex = 10
hudRight.Visible = false
hudRight.Parent = gui
Instance.new("UICorner", hudRight).CornerRadius = UDim.new(1, 0)

local pingLabel = Instance.new("TextLabel")
pingLabel.Size = UDim2.new(1, -10, 1, 0)
pingLabel.Position = UDim2.new(0, 10, 0, 0)
pingLabel.BackgroundTransparency = 1
pingLabel.Text = "42 ms  PING"
pingLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
pingLabel.TextSize = 11
pingLabel.Font = Enum.Font.GothamBold
pingLabel.TextXAlignment = Enum.TextXAlignment.Left
pingLabel.ZIndex = 11
pingLabel.Parent = hudRight

-- Кнопка открытия (круглая по центру)
local openCore = Instance.new("TextButton")
openCore.Size = UDim2.new(0, 62, 0, 62)
openCore.Position = UDim2.new(0.5, -31, 0.5, -31)
openCore.BackgroundColor3 = Color3.fromRGB(120, 115, 110)
openCore.BorderSizePixel = 0
openCore.Text = ""
openCore.ZIndex = 20
openCore.Visible = false
openCore.Parent = gui
Instance.new("UICorner", openCore).CornerRadius = UDim.new(1, 0)
local ocS = Instance.new("UIStroke", openCore)
ocS.Color = Color3.fromRGB(255, 255, 255)
ocS.Transparency = 0.82

-- Крестик/квадратик внутри
local coreIcon = Instance.new("Frame")
coreIcon.Size = UDim2.new(0, 20, 0, 20)
coreIcon.Position = UDim2.new(0.5, -10, 0.5, -10)
coreIcon.BackgroundTransparency = 1
coreIcon.BorderSizePixel = 0
coreIcon.ZIndex = 21
coreIcon.Parent = openCore
local ciS = Instance.new("UIStroke", coreIcon)
ciS.Color = Color3.fromRGB(255, 255, 255)
ciS.Transparency = 0.3
ciS.Thickness = 2
Instance.new("UICorner", coreIcon).CornerRadius = UDim.new(0, 5)

-- Бренд под кнопкой
local brand = Instance.new("TextLabel")
brand.Size = UDim2.new(0, 140, 0, 25)
brand.Position = UDim2.new(0.5, -70, 0.5, 40)
brand.BackgroundColor3 = Color3.fromRGB(85, 80, 75)
brand.BackgroundTransparency = 0.1
brand.BorderSizePixel = 0
brand.Text = "TENTIXWARE"
brand.TextColor3 = Color3.fromRGB(255, 255, 255)
brand.TextTransparency = 0.22
brand.TextSize = 9
brand.Font = Enum.Font.GothamBold
brand.ZIndex = 20
brand.Visible = false
brand.Parent = gui
Instance.new("UICorner", brand).CornerRadius = UDim.new(0, 14)
local bS = Instance.new("UIStroke", brand)
bS.Color = Color3.fromRGB(255, 255, 255)
bS.Transparency = 0.9

-- ====== ГЛАВНАЯ ПАНЕЛЬ ======
local mainPanel = Instance.new("Frame")
mainPanel.Size = UDim2.new(0, 380, 0, 300)
mainPanel.Position = UDim2.new(0.5, -190, 0.5, -100)
mainPanel.BackgroundColor3 = Color3.fromRGB(18, 17, 22)
mainPanel.BorderSizePixel = 0
mainPanel.ZIndex = 15
mainPanel.Visible = false
mainPanel.Active = true
mainPanel.Parent = gui
Instance.new("UICorner", mainPanel).CornerRadius = UDim.new(0, 20)
local mpS = Instance.new("UIStroke", mainPanel)
mpS.Color = Color3.fromRGB(255, 255, 255)
mpS.Transparency = 0.92

-- Левая колонка (категории)
local catPanel = Instance.new("Frame")
catPanel.Size = UDim2.new(0, 90, 1, -20)
catPanel.Position = UDim2.new(0, 10, 0, 10)
catPanel.BackgroundColor3 = Color3.fromRGB(28, 26, 32)
catPanel.BorderSizePixel = 0
catPanel.ZIndex = 16
catPanel.Parent = mainPanel
Instance.new("UICorner", catPanel).CornerRadius = UDim.new(0, 16)
local cpS = Instance.new("UIStroke", catPanel)
cpS.Color = Color3.fromRGB(255, 255, 255)
cpS.Transparency = 0.92
local catLayout = Instance.new("UIListLayout", catPanel)
catLayout.Padding = UDim.new(0, 5)
local catPad = Instance.new("UIPadding", catPanel)
catPad.PaddingTop = UDim.new(0, 7)
catPad.PaddingLeft = UDim.new(0, 7)
catPad.PaddingRight = UDim.new(0, 7)

-- Правая панель (окно)
local windowPanel = Instance.new("Frame")
windowPanel.Size = UDim2.new(1, -116, 1, -20)
windowPanel.Position = UDim2.new(0, 108, 0, 10)
windowPanel.BackgroundColor3 = Color3.fromRGB(22, 20, 28)
windowPanel.BorderSizePixel = 0
windowPanel.ZIndex = 16
windowPanel.ClipsDescendants = true
windowPanel.Parent = mainPanel
Instance.new("UICorner", windowPanel).CornerRadius = UDim.new(0, 16)
local wpS = Instance.new("UIStroke", windowPanel)
wpS.Color = Color3.fromRGB(255, 255, 255)
wpS.Transparency = 0.92

-- Заголовок окна
local winHead = Instance.new("Frame")
winHead.Size = UDim2.new(1, -20, 0, 28)
winHead.Position = UDim2.new(0, 10, 0, 10)
winHead.BackgroundTransparency = 1
winHead.ZIndex = 17
winHead.Parent = windowPanel

local winTitle = Instance.new("TextLabel")
winTitle.Size = UDim2.new(0.6, 0, 1, 0)
winTitle.BackgroundTransparency = 1
winTitle.Text = "COMBAT"
winTitle.TextColor3 = Color3.fromRGB(238, 238, 238)
winTitle.TextSize = 11
winTitle.Font = Enum.Font.GothamBold
winTitle.TextXAlignment = Enum.TextXAlignment.Left
winTitle.ZIndex = 18
winTitle.Parent = winHead

local winSub = Instance.new("TextLabel")
winSub.Size = UDim2.new(0.4, 0, 1, 0)
winSub.Position = UDim2.new(0.6, 0, 0, 0)
winSub.BackgroundTransparency = 1
winSub.Text = "TENTIXWARE"
winSub.TextColor3 = Color3.fromRGB(255, 255, 255)
winSub.TextTransparency = 0.72
winSub.TextSize = 7
winSub.Font = Enum.Font.GothamBold
winSub.TextXAlignment = Enum.TextXAlignment.Right
winSub.ZIndex = 18
winSub.Parent = winHead

-- Список модулей (скролл)
local moduleList = Instance.new("ScrollingFrame")
moduleList.Size = UDim2.new(1, -20, 1, -50)
moduleList.Position = UDim2.new(0, 10, 0, 44)
moduleList.BackgroundTransparency = 1
moduleList.BorderSizePixel = 0
moduleList.ScrollBarThickness = 2
moduleList.ScrollBarImageColor3 = Color3.fromRGB(150, 145, 160)
moduleList.ZIndex = 17
moduleList.Parent = windowPanel
local modLayout = Instance.new("UIListLayout", moduleList)
modLayout.Padding = UDim.new(0, 7)
modLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- ====== ФУНКЦИЯ СОЗДАНИЯ ТОГГЛА ======
local function makeTog(parent, zIdx)
    local tog = Instance.new("TextButton")
    tog.Size = UDim2.new(0, 32, 0, 18)
    tog.BackgroundColor3 = Color3.fromRGB(48, 44, 58)
    tog.BorderSizePixel = 0
    tog.Text = ""
    tog.ZIndex = zIdx or 20
    tog.Parent = parent
    Instance.new("UICorner", tog).CornerRadius = UDim.new(1, 0)
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 12, 0, 12)
    dot.Position = UDim2.new(0, 3, 0.5, -6)
    dot.BackgroundColor3 = Color3.fromRGB(100, 95, 115)
    dot.BorderSizePixel = 0
    dot.ZIndex = (zIdx or 20) + 1
    dot.Parent = tog
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    local active = false
    tog.MouseButton1Click:Connect(function()
        active = not active
        TweenService:Create(tog, TweenInfo.new(0.18), {
            BackgroundColor3 = active and Color3.fromRGB(100,95,115) or Color3.fromRGB(48,44,58)
        }):Play()
        TweenService:Create(dot, TweenInfo.new(0.18), {
            Position = active and UDim2.new(1,-15,0.5,-6) or UDim2.new(0,3,0.5,-6),
            BackgroundColor3 = active and Color3.fromRGB(220,215,230) or Color3.fromRGB(100,95,115)
        }):Play()
    end)
    return tog, active
end

-- ====== ФУНКЦИЯ СОЗДАНИЯ МОДУЛЯ ======
local function makeModule(name, desc, order, onToggle)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 42)
    row.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    row.BackgroundTransparency = 0.965
    row.BorderSizePixel = 0
    row.LayoutOrder = order
    row.ZIndex = 18
    row.Parent = moduleList
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 12)
    local rs = Instance.new("UIStroke", row)
    rs.Color = Color3.fromRGB(255, 255, 255)
    rs.Transparency = 0.945

    local nameL = Instance.new("TextLabel")
    nameL.Size = UDim2.new(1, -50, 0, 22)
    nameL.Position = UDim2.new(0, 11, 0, 5)
    nameL.BackgroundTransparency = 1
    nameL.Text = name
    nameL.TextColor3 = Color3.fromRGB(218, 218, 218)
    nameL.TextSize = 9
    nameL.Font = Enum.Font.GothamBold
    nameL.TextXAlignment = Enum.TextXAlignment.Left
    nameL.ZIndex = 19
    nameL.Parent = row

    local descL = Instance.new("TextLabel")
    descL.Size = UDim2.new(1, -50, 0, 15)
    descL.Position = UDim2.new(0, 11, 0, 24)
    descL.BackgroundTransparency = 1
    descL.Text = desc
    descL.TextColor3 = Color3.fromRGB(255, 255, 255)
    descL.TextTransparency = 0.7
    descL.TextSize = 7
    descL.Font = Enum.Font.Gotham
    descL.TextXAlignment = Enum.TextXAlignment.Left
    descL.ZIndex = 19
    descL.Parent = row

    local togHolder = Instance.new("Frame")
    togHolder.Size = UDim2.new(0, 36, 0, 22)
    togHolder.Position = UDim2.new(1, -44, 0.5, -11)
    togHolder.BackgroundTransparency = 1
    togHolder.ZIndex = 19
    togHolder.Parent = row

    local tog = makeTog(togHolder, 20)
    if onToggle then
        tog.MouseButton1Click:Connect(onToggle)
    end
    return row
end

-- ====== МОДУЛЬ СО СЛАЙДЕРОМ ======
local function makeModuleSlider(name, desc, order, minVal, maxVal, defVal, onToggle, onSlide)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 85)
    row.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    row.BackgroundTransparency = 0.965
    row.BorderSizePixel = 0
    row.LayoutOrder = order
    row.ZIndex = 18
    row.Parent = moduleList
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 12)
    local rs = Instance.new("UIStroke", row)
    rs.Color = Color3.fromRGB(255, 255, 255)
    rs.Transparency = 0.945

    local nameL = Instance.new("TextLabel")
    nameL.Size = UDim2.new(1, -50, 0, 20)
    nameL.Position = UDim2.new(0, 11, 0, 5)
    nameL.BackgroundTransparency = 1
    nameL.Text = name
    nameL.TextColor3 = Color3.fromRGB(218, 218, 218)
    nameL.TextSize = 9
    nameL.Font = Enum.Font.GothamBold
    nameL.TextXAlignment = Enum.TextXAlignment.Left
    nameL.ZIndex = 19
    nameL.Parent = row

    local descL = Instance.new("TextLabel")
    descL.Size = UDim2.new(1, -50, 0, 14)
    descL.Position = UDim2.new(0, 11, 0, 24)
    descL.BackgroundTransparency = 1
    descL.Text = desc
    descL.TextColor3 = Color3.fromRGB(255, 255, 255)
    descL.TextTransparency = 0.7
    descL.TextSize = 7
    descL.Font = Enum.Font.Gotham
    descL.TextXAlignment = Enum.TextXAlignment.Left
    descL.ZIndex = 19
    descL.Parent = row

    local togHolder = Instance.new("Frame")
    togHolder.Size = UDim2.new(0, 36, 0, 22)
    togHolder.Position = UDim2.new(1, -44, 0, 5)
    togHolder.BackgroundTransparency = 1
    togHolder.ZIndex = 19
    togHolder.Parent = row
    local tog = makeTog(togHolder, 20)
    if onToggle then
        tog.MouseButton1Click:Connect(onToggle)
    end

    -- Слайдер
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -22, 0, 4)
    sliderBg.Position = UDim2.new(0, 11, 0, 50)
    sliderBg.BackgroundColor3 = Color3.fromRGB(56, 52, 66)
    sliderBg.BorderSizePixel = 0
    sliderBg.ZIndex = 19
    sliderBg.Parent = row
    Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1, 0)

    local pct = (defVal - minVal) / (maxVal - minVal)
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(pct, 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(170, 165, 185)
    sliderFill.BorderSizePixel = 0
    sliderFill.ZIndex = 20
    sliderFill.Parent = sliderBg
    Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 13, 0, 13)
    knob.Position = UDim2.new(pct, -6, 0.5, -6)
    knob.BackgroundColor3 = Color3.fromRGB(200, 195, 215)
    knob.BorderSizePixel = 0
    knob.ZIndex = 21
    knob.Parent = sliderBg
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local valL = Instance.new("TextLabel")
    valL.Size = UDim2.new(0, 30, 0, 14)
    valL.Position = UDim2.new(1, -30, 0, 62)
    valL.BackgroundTransparency = 1
    valL.Text = tostring(defVal)
    valL.TextColor3 = Color3.fromRGB(170, 165, 185)
    valL.TextSize = 8
    valL.Font = Enum.Font.GothamBold
    valL.TextXAlignment = Enum.TextXAlignment.Right
    valL.ZIndex = 19
    valL.Parent = row

    local minL2 = Instance.new("TextLabel")
    minL2.Size = UDim2.new(0, 20, 0, 14)
    minL2.Position = UDim2.new(0, 11, 0, 60)
    minL2.BackgroundTransparency = 1
    minL2.Text = tostring(minVal)
    minL2.TextColor3 = Color3.fromRGB(255, 255, 255)
    minL2.TextTransparency = 0.72
    minL2.TextSize = 7
    minL2.Font = Enum.Font.Gotham
    minL2.TextXAlignment = Enum.TextXAlignment.Left
    minL2.ZIndex = 19
    minL2.Parent = row

    local currentVal = defVal
    local draggingSlider = false

    sliderBg.InputBegan:Connect(function(i)
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
        if draggingSlider and (
            i.UserInputType == Enum.UserInputType.MouseMovement
            or i.UserInputType == Enum.UserInputType.Touch
        ) then
            local p = math.clamp(
                (i.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X,
                0, 1
            )
            currentVal = math.floor(minVal + p * (maxVal - minVal))
            sliderFill.Size = UDim2.new(p, 0, 1, 0)
            knob.Position = UDim2.new(p, -6, 0.5, -6)
            valL.Text = tostring(currentVal)
            if onSlide then onSlide(currentVal) end
        end
    end)

    return row, tog
end

-- ====== КАТЕГОРИИ ======
local cats = {"Combat", "Visuals", "Misc", "Settings"}
local catEmoji = {"⚔️", "👁️", "⚙️", "🔧"}
local activeCat = "Combat"
local catBtns = {}

for i, cat in ipairs(cats) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 52)
    btn.BackgroundColor3 = cat == activeCat
        and Color3.fromRGB(80, 75, 95)
        or Color3.fromRGB(255, 255, 255)
    btn.BackgroundTransparency = cat == activeCat and 0.1 or 0.97
    btn.BorderSizePixel = 0
    btn.Text = catEmoji[i].."\n"..cat
    btn.TextColor3 = cat == activeCat
        and Color3.fromRGB(240, 238, 248)
        or Color3.fromRGB(255, 255, 255)
    btn.TextTransparency = cat == activeCat and 0.08 or 0.57
    btn.TextSize = 8
    btn.Font = Enum.Font.GothamBold
    btn.ZIndex = 17
    btn.Parent = catPanel
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 11)
    table.insert(catBtns, {btn = btn, cat = cat})
end

for _, item in ipairs(catBtns) do
    item.btn.MouseButton1Click:Connect(function()
        activeCat = item.cat
        winTitle.Text = item.cat:upper()
        for _, o in ipairs(catBtns) do
            TweenService:Create(o.btn, TweenInfo.new(0.2), {
                BackgroundTransparency = o.cat == activeCat and 0.1 or 0.97,
                TextTransparency = o.cat == activeCat and 0.08 or 0.57
            }):Play()
        end
    end)
end

-- ====== SPEED HACK ======
local speedEnabled = false
local currentSpeed = 100

local speedMod = makeModuleSlider(
    "⚡  Speed Hack",
    "Макс скорость без кика · MM2",
    1, 16, 100, 100,
    function() end,
    function(val)
        currentSpeed = val
        if speedEnabled then
            local char = lp.Character
            if char then
                local h = char:FindFirstChildOfClass("Humanoid")
                if h then h.WalkSpeed = currentSpeed end
            end
        end
    end
)

-- Находим тоггл speed и вешаем логику
local speedTog = speedMod:FindFirstChildOfClass("Frame")
    and speedMod:FindFirstChildOfClass("Frame"):FindFirstChildOfClass("TextButton")

if speedTog then
    speedTog.MouseButton1Click:Connect(function()
        speedEnabled = not speedEnabled
        local char = lp.Character
        if char then
            local h = char:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed = speedEnabled and currentSpeed or 16 end
        end
    end)
end

lp.CharacterAdded:Connect(function(char)
    if speedEnabled then
        task.wait(0.5)
        local h = char:WaitForChild("Humanoid")
        if h then h.WalkSpeed = currentSpeed end
    end
end)

-- Обновляем канвас листа
modLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    moduleList.CanvasSize = UDim2.new(0, 0, 0, modLayout.AbsoluteContentSize.Y + 10)
end)

-- ====== ОТКРЫТИЕ / ЗАКРЫТИЕ ======
local function openGUI()
    guiOpen = true
    mainPanel.Visible = true
    hudLeft.Visible = true
    hudRight.Visible = true
    brand.Visible = true
    TweenService:Create(hudLeft, TweenInfo.new(0.55, Enum.EasingStyle.Back), {
        Size = UDim2.new(0.35, 0, 0, 46),
        Position = UDim2.new(0.15, 0, 0.5, -23)
    }):Play()
    TweenService:Create(hudRight, TweenInfo.new(0.55, Enum.EasingStyle.Back), {
        Size = UDim2.new(0.35, 0, 0, 46),
        Position = UDim2.new(0.5, 0, 0.5, -23)
    }):Play()
end

local function closeGUI()
    guiOpen = false
    TweenService:Create(hudLeft, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 0, 0, 46),
        Position = UDim2.new(0.5, 0, 0.5, -23)
    }):Play()
    TweenService:Create(hudRight, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 0, 0, 46),
        Position = UDim2.new(0.5, 0, 0.5, -23)
    }):Play()
    task.delay(0.35, function()
        mainPanel.Visible = false
        brand.Visible = false
        hudLeft.Visible = false
        hudRight.Visible = false
    end)
end

-- Замок: первый тап = разблокировать, следующие = открыть/закрыть
local lockStart = nil
lockBtn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        lockStart = i.Position
    end
end)
lockBtn.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        if lockStart and (i.Position - lockStart).Magnitude < 8 then
            if not unlocked then
                unlocked = true
                lockBtn.Text = "🔓"
                openCore.Visible = true
            else
                if guiOpen then
                    closeGUI()
                else
                    openGUI()
                end
            end
        end
        lockStart = nil
    end
end)

openCore.MouseButton1Click:Connect(function()
    if guiOpen then closeGUI() else openGUI() end
end)

-- ====== FPS + ПИНГ ======
local fr, el = 0, 0
RunService.Heartbeat:Connect(function(dt)
    fr += 1; el += dt
    if el >= 0.7 then
        local fps = math.floor(fr / el)
        fpsLabel.Text = "FPS  "..fps
        local ok, p = pcall(function()
            return math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        if ok then pingLabel.Text = p.." ms  PING" end
        fr = 0; el = 0
    end
end)
