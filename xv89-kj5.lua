-- TentixWare HUD | Roblox Lua (Delta / executors)
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

local parent = (gethui and gethui()) or game:GetService("CoreGui")

local gui = Instance.new("ScreenGui")
gui.Name = "TentixWareHUD"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = parent

local unlocked = false
local guiOpen = false

local function tween(obj, info, props)
	TweenService:Create(obj, info, props):Play()
end
local smooth = TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

-- ================= LOCK BUTTON =================
local lockButton = Instance.new("TextButton")
lockButton.Size = UDim2.fromOffset(46, 46)
lockButton.Position = UDim2.new(0.5, 260, 0.5, -23)
lockButton.BackgroundColor3 = Color3.fromRGB(110, 110, 110)
lockButton.Text = "🔒"
lockButton.TextSize = 22
lockButton.Font = Enum.Font.GothamBold
lockButton.TextColor3 = Color3.fromRGB(232, 232, 232)
lockButton.AutoButtonColor = false
lockButton.Parent = gui
Instance.new("UICorner", lockButton).CornerRadius = UDim.new(1, 0)

local dragging, moved, dragStart, startPos
lockButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging, moved = true, false
		dragStart = input.Position
		startPos = lockButton.Position
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
	or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		if delta.Magnitude > 6 then moved = true end
		if moved then
			lockButton.Position = UDim2.new(0, startPos.X.Offset + delta.X,
				0, startPos.Y.Offset + delta.Y)
		end
	end
end)
lockButton.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		local wasMoved = moved
		dragging = false
		if not wasMoved then
			unlocked = true
			tween(lockButton, smooth, {BackgroundTransparency = 1, TextTransparency = 1})
			task.delay(0.5, function() lockButton.Visible = false end)
			tween(openCore, smooth, {BackgroundTransparency = 0, TextTransparency = 0})
			openCore.Active = true
		end
	end
end)

-- ================= HUD SYSTEM =================
local hudSystem = Instance.new("Frame")
hudSystem.Size = UDim2.fromOffset(560, 400)
hudSystem.Position = UDim2.new(0.5, -280, 0.5, -200)
hudSystem.BackgroundTransparency = 1
hudSystem.Visible = false
hudSystem.Parent = gui

-- bars
local bars = Instance.new("Frame")
bars.Size = UDim2.new(1, 0, 0, 46)
bars.Position = UDim2.new(0.5, 0, 0, 23)
bars.AnchorPoint = Vector2.new(0.5, 0.5)
bars.BackgroundTransparency = 1
bars.Parent = hudSystem

local function makeSide(leftSide)
	local side = Instance.new("Frame")
	side.Size = UDim2.new(0.5, 0, 1, 0)
	side.Position = leftSide and UDim2.new(0, 0, 0, 0) or UDim2.new(0.5, 0, 0, 0)
	side.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
	side.BorderSizePixel = 0
	side.ClipsDescendants = true
	side.Parent = bars
	local c = Instance.new("UICorner")
	c.CornerRadius = leftSide and UDim.new(0, 23) or UDim.new(0, 23)
	c.Parent = side
	return side
end

local leftBar = makeSide(true)
local rightBar = makeSide(false)

local function statLabel(parent2, text, size, bold, pos)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Text = text
	l.TextColor3 = bold and Color3.fromRGB(238, 238, 238) or Color3.fromRGB(160, 160, 160)
	l.Font = Enum.Font.GothamBold
	l.TextSize = size
	l.Size = UDim2.fromOffset(60, 20)
	l.Position = pos
	l.Parent = parent2
	return l
end

local fpsLabel = statLabel(leftBar, "FPS", 9, false, UDim2.new(1, -100, 0.5, -10))
local fpsValue = statLabel(leftBar, "60", 11, true, UDim2.new(1, -70, 0.5, -10))
local pingValue = statLabel(rightBar, "42 ms", 11, true, UDim2.new(0, 30, 0.5, -10))
local pingLabel = statLabel(rightBar, "PING", 9, false, UDim2.new(0, 70, 0.5, -10))

-- open core
openCore = Instance.new("TextButton")
openCore.Size = UDim2.fromOffset(62, 62)
openCore.Position = UDim2.new(0.5, -31, 0, -8)
openCore.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
openCore.Text = "◉"
openCore.TextSize = 24
openCore.Font = Enum.Font.GothamBold
openCore.TextColor3 = Color3.fromRGB(227, 227, 227)
openCore.BackgroundTransparency = 1
openCore.TextTransparency = 1
openCore.Active = false
openCore.Parent = hudSystem
Instance.new("UICorner", openCore).CornerRadius = UDim.new(1, 0)

-- brand
local brand = Instance.new("TextLabel")
brand.Size = UDim2.fromOffset(120, 25)
brand.Position = UDim2.new(0.5, -60, 0, 63)
brand.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
brand.Text = "TENTIXWARE"
brand.TextColor3 = Color3.fromRGB(200, 200, 200)
brand.Font = Enum.Font.GothamBold
brand.TextSize = 9
brand.BackgroundTransparency = 1
brand.TextTransparency = 1
brand.Parent = hudSystem
Instance.new("UICorner", brand).CornerRadius = UDim.new(0, 14)

-- ================= CONTENT =================
local content = Instance.new("Frame")
content.Size = UDim2.new(1, 0, 0, 300)
content.Position = UDim2.new(0, 0, 0, 110)
content.BackgroundTransparency = 1
content.Visible = false
content.Parent = hudSystem

-- categories
local categoriesFrame = Instance.new("Frame")
categoriesFrame.Size = UDim2.fromOffset(92, 236)
categoriesFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
categoriesFrame.BorderSizePixel = 0
categoriesFrame.Parent = content
Instance.new("UICorner", categoriesFrame).CornerRadius = UDim.new(0, 17)
local catLayout = Instance.new("UIListLayout")
catLayout.Padding = UDim.new(0, 6)
catLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
catLayout.Parent = categoriesFrame
local catPad = Instance.new("UIPadding")
catPad.PaddingTop = UDim.new(0, 7)
catPad.Parent = categoriesFrame

-- main window
local mainWindow = Instance.new("Frame")
mainWindow.Size = UDim2.new(1, -100, 1, 0)
mainWindow.Position = UDim2.new(0, 100, 0, 0)
mainWindow.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
mainWindow.BorderSizePixel = 0
mainWindow.ClipsDescendants = true
mainWindow.Parent = content
Instance.new("UICorner", mainWindow).CornerRadius = UDim.new(0, 21)

local windowInner = Instance.new("ScrollingFrame")
windowInner.Size = UDim2.new(1, -32, 1, -32)
windowInner.Position = UDim2.fromOffset(16, 16)
windowInner.BackgroundTransparency = 1
windowInner.ScrollBarThickness = 0
windowInner.AutomaticCanvasSize = Enum.AutomaticSize.Y
windowInner.CanvasSize = UDim2.new(0, 0, 0, 0)
windowInner.Parent = mainWindow
local innerLayout = Instance.new("UIListLayout")
innerLayout.Padding = UDim.new(0, 10)
innerLayout.Parent = windowInner

local windowTitle = Instance.new("TextLabel")
windowTitle.Size = UDim2.new(1, 0, 0, 20)
windowTitle.BackgroundTransparency = 1
windowTitle.Text = "COMBAT"
windowTitle.TextColor3 = Color3.fromRGB(238, 238, 238)
windowTitle.Font = Enum.Font.GothamBold
windowTitle.TextSize = 11
windowTitle.TextXAlignment = Enum.TextXAlignment.Left
windowTitle.Parent = windowInner

-- ================= COMPONENTS =================
local function createToggle(parent2, onChanged)
	local state = false
	local t = Instance.new("TextButton")
	t.Size = UDim2.fromOffset(32, 18)
	t.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
	t.Text = ""
	t.AutoButtonColor = false
	t.Parent = parent2
	Instance.new("UICorner", t).CornerRadius = UDim.new(1, 0)
	local knob = Instance.new("Frame")
	knob.Size = UDim2.fromOffset(12, 12)
	knob.Position = UDim2.fromOffset(3, 3)
	knob.BackgroundColor3 = Color3.fromRGB(119, 119, 119)
	knob.BorderSizePixel = 0
	knob.Parent = t
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
	t.MouseButton1Click:Connect(function()
		state = not state
		tween(t, TweenInfo.new(0.2), {BackgroundColor3 =
			state and Color3.fromRGB(102, 102, 102) or Color3.fromRGB(48, 48, 48)})
		tween(knob, TweenInfo.new(0.2), {Position =
			state and UDim2.fromOffset(17, 3) or UDim2.fromOffset(3, 3),
			BackgroundColor3 = state and Color3.fromRGB(238, 238, 238) or Color3.fromRGB(119, 119, 119)})
		if onChanged then onChanged(state) end
	end)
	return t, function() return state end
end

local function createSlider(parent2, min, max, default, onChanged)
	local wrap = Instance.new("Frame")
	wrap.Size = UDim2.fromOffset(100, 18)
	wrap.BackgroundTransparency = 1
	wrap.Parent = parent2
	local bar = Instance.new("Frame")
	bar.Size = UDim2.fromOffset(70, 4)
	bar.Position = UDim2.fromOffset(0, 7)
	bar.BackgroundColor3 = Color3.fromRGB(56, 56, 56)
	bar.BorderSizePixel = 0
	bar.Parent = wrap
	Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)
	local knob = Instance.new("Frame")
	knob.Size = UDim2.fromOffset(13, 13)
	knob.AnchorPoint = Vector2.new(0.5, 0.5)
	knob.Position = UDim2.new((default - min) / (max - min), 0, 0.5, 0)
	knob.BackgroundColor3 = Color3.fromRGB(170, 170, 170)
	knob.BorderSizePixel = 0
	knob.Parent = bar
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
	local valueLabel = Instance.new("TextLabel")
	valueLabel.Size = UDim2.fromOffset(26, 18)
	valueLabel.Position = UDim2.fromOffset(74, 0)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = tostring(default)
	valueLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
	valueLabel.Font = Enum.Font.Gotham
	valueLabel.TextSize = 8
	valueLabel.Parent = wrap

	local value = default
	local sliding = false
	local function setFromX(x)
		local rel = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
		value = math.floor(min + (max - min) * rel + 0.5)
		knob.Position = UDim2.new(rel, 0, 0.5, 0)
		valueLabel.Text = tostring(value)
		if onChanged then onChanged(value) end
	end
	bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			sliding = true
			setFromX(input.Position.X)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch) then
			setFromX(input.Position.X)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			sliding = false
		end
	end)
	return wrap, function() return value end
end

local function createModule(name, desc)
	local m = Instance.new("Frame")
	m.Size = UDim2.new(1, 0, 0, 42)
	m.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	m.BackgroundTransparency = 0.965
	m.BorderSizePixel = 0
	m.Parent = windowInner
	Instance.new("UICorner", m).CornerRadius = UDim.new(0, 12)
	local n = Instance.new("TextLabel")
	n.Size = UDim2.new(1, -60, 0, 14)
	n.Position = UDim2.fromOffset(11, 7)
	n.BackgroundTransparency = 1
	n.Text = name
	n.TextColor3 = Color3.fromRGB(221, 221, 221)
	n.Font = Enum.Font.GothamBold
	n.TextSize = 9
	n.TextXAlignment = Enum.TextXAlignment.Left
	n.Parent = m
	local d = Instance.new("TextLabel")
	d.Size = UDim2.new(1, -60, 0, 10)
	d.Position = UDim2.fromOffset(11, 22)
	d.BackgroundTransparency = 1
	d.Text = desc
	d.TextColor3 = Color3.fromRGB(110, 110, 110)
	d.Font = Enum.Font.Gotham
	d.TextSize = 7
	d.TextXAlignment = Enum.TextXAlignment.Left
	d.Parent = m
	return m
end

-- module: Test (simple toggle)
local testModule = createModule("Test", "Test function")
local tToggle = Instance.new("Frame")
tToggle.Size = UDim2.fromOffset(32, 18)
tToggle.Position = UDim2.new(1, -43, 0.5, -9)
tToggle.BackgroundTransparency = 1
tToggle.Parent = testModule
createToggle(tToggle, function(state) print("Test:", state) end)

-- module: Test1 (dropdown with sub-settings)
local test1 = Instance.new("Frame")
test1.Size = UDim2.new(1, 0, 0, 42)
test1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
test1.BackgroundTransparency = 0.965
test1.BorderSizePixel = 0
test1.ClipsDescendants = true
test1.Parent = windowInner
Instance.new("UICorner", test1).CornerRadius = UDim.new(0, 12)

local header = Instance.new("TextButton")
header.Size = UDim2.new(1, 0, 0, 42)
header.BackgroundTransparency = 1
header.Text = ""
header.Parent = test1

local arrow = Instance.new("TextLabel")
arrow.Size = UDim2.fromOffset(12, 12)
arrow.Position = UDim2.new(0, 11, 0, 15)
arrow.BackgroundTransparency = 1
arrow.Text = "⌃"
arrow.TextColor3 = Color3.fromRGB(180, 180, 180)
arrow.TextSize = 10
arrow.Rotation = 180
arrow.Parent = header

local hName = Instance.new("TextLabel")
hName.Size = UDim2.new(1, -80, 0, 14)
hName.Position = UDim2.fromOffset(32, 7)
hName.BackgroundTransparency = 1
hName.Text = "Test1"
hName.TextColor3 = Color3.fromRGB(221, 221, 221)
hName.Font = Enum.Font.GothamBold
hName.TextSize = 9
hName.TextXAlignment = Enum.TextXAlignment.Left
hName.Parent = header
local hDesc = hName:Clone()
hDesc.Text = "Settings"
hDesc.TextColor3 = Color3.fromRGB(110, 110, 110)
hDesc.Font = Enum.Font.Gotham
hDesc.TextSize = 7
hDesc.Position = UDim2.fromOffset(32, 22)
hDesc.Parent = header

local hToggleWrap = Instance.new("Frame")
hToggleWrap.Size = UDim2.fromOffset(32, 18)
hToggleWrap.Position = UDim2.new(1, -43, 0, 12)
hToggleWrap.BackgroundTransparency = 1
hToggleWrap.Parent = header
createToggle(hToggleWrap, function(state) print("Test1:", state) end)

local settingsFrame = Instance.new("Frame")
settingsFrame.Size = UDim2.new(1, 0, 0, 0)
settingsFrame.Position = UDim2.new(0, 0, 0, 42)
settingsFrame.BackgroundTransparency = 1
settingsFrame.Parent = test1
local sLayout = Instance.new("UIListLayout")
sLayout.Padding = UDim.new(0, 6)
sLayout.Parent = settingsFrame
local sPad = Instance.new("UIPadding")
sPad.PaddingLeft = UDim.new(0, 10)
sPad.PaddingRight = UDim.new(0, 10)
sPad.PaddingBottom = UDim.new(0, 10)
sPad.Parent = settingsFrame

local function subSetting(name, desc, withSlider, min, max, default)
	local s = Instance.new("Frame")
	s.Size = UDim2.new(1, 0, 0, 38)
	s.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	s.BackgroundTransparency = 0.965
	s.BorderSizePixel = 0
	s.Parent = settingsFrame
	Instance.new("UICorner", s).CornerRadius = UDim.new(0, 10)
	local n = Instance.new("TextLabel")
	n.Size = UDim2.new(0.4, 0, 0, 12)
	n.Position = UDim2.fromOffset(10, 8)
	n.BackgroundTransparency = 1
	n.Text = name
	n.TextColor3 = Color3.fromRGB(217, 217, 217)
	n.Font = Enum.Font.GothamBold
	n.TextSize = 8
	n.TextXAlignment = Enum.TextXAlignment.Left
	n.Parent = s
	local d = Instance.new("TextLabel")
	d.Size = UDim2.new(0.4, 0, 0, 9)
	d.Position = UDim2.fromOffset(10, 21)
	d.BackgroundTransparency = 1
	d.Text = desc
	d.TextColor3 = Color3.fromRGB(100, 100, 100)
	d.Font = Enum.Font.Gotham
	d.TextSize = 6
	d.TextXAlignment = Enum.TextXAlignment.Left
	d.Parent = s

	local controls = Instance.new("Frame")
	controls.Size = UDim2.fromOffset(withSlider and 140 or 40, 18)
	controls.Position = UDim2.new(1, withSlider and -150 or -50, 0.5, -9)
	controls.BackgroundTransparency = 1
	controls.Parent = s
	local tg = Instance.new("Frame")
	tg.Size = UDim2.fromOffset(32, 18)
	tg.BackgroundTransparency = 1
	tg.Parent = controls
	createToggle(tg, function(state) print(name .. " toggle:", state) end)
	if withSlider then
		local sw = Instance.new("Frame")
		sw.Size = UDim2.fromOffset(100, 18)
		sw.Position = UDim2.fromOffset(40, 0)
		sw.BackgroundTransparency = 1
		sw.Parent = controls
		createSlider(sw, min, max, default, function(v) print(name .. " slider:", v) end)
	end
	return s
end

subSetting("Test", "Enable function", false)
subSetting("Test1", "Enable + Slider", true, 0, 100, 50)
subSetting("Test2", "Enable + Slider", true, 0, 100, 70)

local open1 = false
local CLOSED_H, OPEN_H = 42, 42 + 3 * 44 + 16
header.MouseButton1Click:Connect(function()
	open1 = not open1
	tween(test1, smooth, {Size = UDim2.new(1, 0, 0, open1 and OPEN_H or CLOSED_H)})
	tween(settingsFrame, smooth, {Size = UDim2.new(1, 0, 0, open1 and (OPEN_H - 42) or 0)})
	tween(arrow, smooth, {Rotation = open1 and 0 or 180})
end)

-- ================= CATEGORIES =================
for i, catName in ipairs({"Combat", "Visuals", "Misc", "Settings"}) do
	local c = Instance.new("TextButton")
	c.Size = UDim2.new(1, -14, 0, 52)
	c.BackgroundColor3 = i == 1 and Color3.fromRGB(85, 85, 85) or Color3.fromRGB(0, 0, 0)
	c.BackgroundTransparency = i == 1 and 0 or 1
	c.Text = catName
	c.TextColor3 = i == 1 and Color3.fromRGB(240, 240, 240) or Color3.fromRGB(130, 130, 130)
	c.Font = Enum.Font.GothamBold
	c.TextSize = 8
	c.Parent = categoriesFrame
	Instance.new("UICorner", c).CornerRadius = UDim.new(0, 12)
	c.MouseButton1Click:Connect(function()
		for _, other in ipairs(categoriesFrame:GetChildren()) do
			if other:IsA("TextButton") then
				other.BackgroundTransparency = 1
				other.TextColor3 = Color3.fromRGB(130, 130, 130)
			end
		end
		c.BackgroundTransparency = 0
		c.TextColor3 = Color3.fromRGB(240, 240, 240)
		windowTitle.Text = string.upper(catName)
	end)
end

-- ================= OPEN / CLOSE =================
openCore.MouseButton1Click:Connect(function()
	if not unlocked then return end
	guiOpen = not guiOpen
	hudSystem.Visible = true
	content.Visible = guiOpen
	tween(brand, smooth, {BackgroundTransparency = guiOpen and 0 or 1,
		TextTransparency = guiOpen and 0 or 1})
	if not guiOpen then
		task.delay(0.5, function() if not guiOpen then hudSystem.Visible = false end end)
	end
end)

-- ================= FPS / PING =================
task.spawn(function()
	while true do
		task.wait(1.2)
		if guiOpen then
			fpsValue.Text = tostring(math.floor(1 / RunService.RenderStepped:Wait()))
			local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
			pingValue.Text = math.floor(ping) .. " ms"
		end
	end
end)

print("[TentixWare] Нажми на замок, чтобы разблокировать HUD")
185),

	TextSize = 9,

	Font = Enum.Font.GothamBold,

	TextXAlignment = Enum.TextXAlignment.Left,

	ZIndex = 44
}, PingHolder)

--============================================================
-- OPEN CORE
--============================================================

local OpenCore = Create("TextButton", {
	Name = "OpenCore",

	AnchorPoint = Vector2.new(0.5, 0.5),

	Position = UDim2.fromScale(0.5, 0.5),

	Size = UDim2.fromOffset(62, 62),

	BackgroundColor3 = COLOR.CoreMid,

	BorderSizePixel = 0,

	Text = "",

	AutoButtonColor = false,

	Visible = false,

	ZIndex = 50
}, Hud)

AddCorner(OpenCore, 50)

AddStroke(
	OpenCore,
	Color3.fromRGB(255, 255, 255),
	0.82,
	1
)

local CoreGradient = Create("UIGradient", {
	Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, COLOR.CoreTop),
		ColorSequenceKeypoint.new(0.5, COLOR.CoreMid),
		ColorSequenceKeypoint.new(1, COLOR.CoreBottom)
	}),

	Rotation = 135
}, OpenCore)

local CoreIconOuter = Create("Frame", {
	AnchorPoint = Vector2.new(0.5, 0.5),

	Position = UDim2.fromScale(0.5, 0.5),

	Size = UDim2.fromOffset(20, 20),

	BackgroundTransparency = 1,

	BorderSizePixel = 0,

	ZIndex = 51
}, OpenCore)

AddCorner(CoreIconOuter, 6)

AddStroke(
	CoreIconOuter,
	Color3.fromRGB(235, 235, 235),
	0.3,
	2
)

local CoreDot = Create("Frame", {
	AnchorPoint = Vector2.new(0.5, 0.5),

	Position = UDim2.fromScale(0.5, 0.5),

	Size = UDim2.fromOffset(6, 6),

	BackgroundColor3 = Color3.fromRGB(227, 227, 227),

	BorderSizePixel = 0,

	ZIndex = 52
}, OpenCore)

AddCorner(CoreDot, 10)

--============================================================
-- BRAND
--============================================================

local Brand = Create("TextLabel", {
	Name = "Brand",

	AnchorPoint = Vector2.new(0.5, 0),

	Position = UDim2.fromScale(0.5, 0),

	Size = UDim2.fromOffset(150, 25),

	BackgroundColor3 = Color3.fromRGB(80, 80, 80),

	BackgroundTransparency = 0.05,

	BorderSizePixel = 0,

	Text = "TENTIXWARE",

	TextColor3 = Color3.fromRGB(210, 210, 210),

	TextSize = 9,

	Font = Enum.Font.GothamBold,

	Visible = false,

	ZIndex = 45
}, HudSystem)

AddCorner(Brand, 14)

AddStroke(
	Brand,
	Color3.fromRGB(255, 255, 255),
	0.9,
	1
)

--============================================================
-- CONTENT
--============================================================

local Content = Create("Frame", {
	Name = "Content",

	Position = UDim2.fromOffset(0, 97),

	Size = UDim2.new(1, 0, 1, -97),

	BackgroundTransparency = 1,

	BorderSizePixel = 0,

	Visible = false,

	ZIndex = 45
}, HudSystem)

--============================================================
-- CATEGORIES
--============================================================

local Categories = Create("Frame", {
	Name = "Categories",

	Position = UDim2.fromOffset(0, 0),

	Size = UDim2.fromOffset(92, 300),

	BackgroundColor3 = COLOR.PanelTop,

	BorderSizePixel = 0,

	ZIndex = 46
}, Content)

AddCorner(Categories, 17)

AddStroke(
	Categories,
	Color3.fromRGB(255, 255, 255),
	0.92,
	1
)

Create("UIGradient", {
	Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, COLOR.PanelTop),
		ColorSequenceKeypoint.new(1, COLOR.PanelBottom)
	}),

	Rotation = 90
}, Categories)

local CategoryPadding = Create("UIPadding", {
	PaddingTop = UDim.new(0, 7),
	PaddingBottom = UDim.new(0, 7),
	PaddingLeft = UDim.new(0, 7),
	PaddingRight = UDim.new(0, 7)
}, Categories)

local CategoryLayout = Create("UIListLayout", {
	FillDirection = Enum.FillDirection.Vertical,

	HorizontalAlignment = Enum.HorizontalAlignment.Center,

	VerticalAlignment = Enum.VerticalAlignment.Top,

	Padding = UDim.new(0, 6),

	SortOrder = Enum.SortOrder.LayoutOrder
}, Categories)

--============================================================
-- ICON MAKER
--============================================================

local function MakeCombatIcon(parent)
	local icon = Create("Frame", {
		Size = UDim2.fromOffset(20, 20),

		BackgroundTransparency = 1,

		BorderSizePixel = 0,

		ZIndex = 52
	}, parent)

	local circle = Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),

		Position = UDim2.fromScale(0.5, 0.5),

		Size = UDim2.fromOffset(17, 17),

		BackgroundTransparency = 1,

		BorderSizePixel = 0,

		ZIndex = 53
	}, icon)

	AddCorner(circle, 20)

	AddStroke(
		circle,
		COLOR.White,
		0.15,
		2
	)

	local dot = Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),

		Position = UDim2.fromScale(0.5, 0.5),

		Size = UDim2.fromOffset(5, 5),

		BackgroundColor3 = COLOR.White,

		BorderSizePixel = 0,

		ZIndex = 54
	}, icon)

	AddCorner(dot, 10)

	return icon
end

local function MakeVisualIcon(parent)
	local icon = Create("Frame", {
		Size = UDim2.fromOffset(21, 20),

		BackgroundTransparency = 1,

		BorderSizePixel = 0,

		ZIndex = 52
	}, parent)

	local eye = Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),

		Position = UDim2.fromScale(0.5, 0.5),

		Size = UDim2.fromOffset(18, 11),

		BackgroundTransparency = 1,

		BorderSizePixel = 0,

		Rotation = 45,

		ZIndex = 53
	}, icon)

	AddCorner(eye, 8)

	AddStroke(
		eye,
		COLOR.White,
		0.15,
		2
	)

	local dot = Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),

		Position = UDim2.fromScale(0.5, 0.5),

		Size = UDim2.fromOffset(6, 6),

		BackgroundColor3 = COLOR.White,

		BorderSizePixel = 0,

		ZIndex = 54
	}, icon)

	AddCorner(dot, 10)

	return icon
end

local function MakeMiscIcon(parent)
	local icon = Create("Frame", {
		Size = UDim2.fromOffset(21, 21),

		BackgroundTransparency = 1,

		BorderSizePixel = 0,

		ZIndex = 52
	}, parent)

	for _, position in ipairs({
		UDim2.fromOffset(5, 9),
		UDim2.fromOffset(11, 4),
		UDim2.fromOffset(11, 15)
	}) do
		local dot = Create("Frame", {
			Position = position,

			Size = UDim2.fromOffset(5, 5),

			BackgroundColor3 = COLOR.White,

			BorderSizePixel = 0,

			ZIndex = 54
		}, icon)

		AddCorner(dot, 10)
	end

	return icon
end

local function MakeSettingsIcon(parent)
	local icon = Create("TextLabel", {
		Size = UDim2.fromOffset(21, 21),

		BackgroundTransparency = 1,

		Text = "⚙",

		TextColor3 = COLOR.White,

		TextSize = 19,

		Font = Enum.Font.GothamBold,

		ZIndex = 53
	}, parent)

	return icon
end

--============================================================
-- CATEGORIES
--============================================================

local categoryButtons = {}

local WindowTitle

local function CreateCategory(name, iconType, order)
	local button = Create("TextButton", {
		Name = name,

		Size = UDim2.new(1, 0, 0, 52),

		BackgroundColor3 = Color3.fromRGB(102, 102, 102),

		BackgroundTransparency = 1,

		BorderSizePixel = 0,

		Text = "",

		AutoButtonColor = false,

		LayoutOrder = order,

		ZIndex = 48
	}, Categories)

	AddCorner(button, 12)

	local iconHolder = Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0),

		Position = UDim2.new(0.5, 0, 0, 7),

		Size = UDim2.fromOffset(22, 21),

		BackgroundTransparency = 1,

		BorderSizePixel = 0,

		ZIndex = 49
	}, button)

	if iconType == "Combat" then
		MakeCombatIcon(iconHolder)
	elseif iconType == "Visuals" then
		MakeVisualIcon(iconHolder)
	elseif iconType == "Misc" then
		MakeMiscIcon(iconHolder)
	elseif iconType == "Settings" then
		MakeSettingsIcon(iconHolder)
	end

	local text = Create("TextLabel", {
		AnchorPoint = Vector2.new(0.5, 0),

		Position = UDim2.new(0.5, 0, 0, 30),

		Size = UDim2.new(1, -4, 0, 14),

		BackgroundTransparency = 1,

		Text = name,

		TextColor3 = Color3.fromRGB(135, 135, 135),

		TextSize = 7,

		Font = Enum.Font.GothamBold,

		ZIndex = 50
	}, button)

	categoryButtons[name] = {
		Button = button,
		Text = text
	}

	button.MouseEnter:Connect(function()
		if button:GetAttribute("Active") then
			return
		end

		Tween(
			button,
			T_FAST,
			{
				BackgroundTransparency = 0.93
			}
		)

		Tween(
			text,
			T_FAST,
			{
				TextColor3 = Color3.fromRGB(221, 221, 221)
			}
		)
	end)

	button.MouseLeave:Connect(function()
		if button:GetAttribute("Active") then
			return
		end

		Tween(
			button,
			T_FAST,
			{
				BackgroundTransparency = 1
			}
		)

		Tween(
			text,
			T_FAST,
			{
				TextColor3 = Color3.fromRGB(135, 135, 135)
			}
		)
	end)

	button.MouseButton1Click:Connect(function()
		for _, data in pairs(categoryButtons) do
			data.Button:SetAttribute("Active", false)

			Tween(
				data.Button,
				T_FAST,
				{
					BackgroundTransparency = 1
				}
			)

			Tween(
				data.Text,
				T_FAST,
				{
					TextColor3 = Color3.fromRGB(135, 135, 135)
				}
			)
		end

		button:SetAttribute("Active", true)

		Tween(
			button,
			T_FAST,
			{
				BackgroundTransparency = 0
			}
		)

		Tween(
			text,
			T_FAST,
			{
				TextColor3 = Color3.fromRGB(240, 240, 240)
			}
		)

		if WindowTitle then
			WindowTitle.Text = string.upper(name)
		end
	end)

	return button
end

CreateCategory("Combat", "Combat", 1)
CreateCategory("Visuals", "Visuals", 2)
CreateCategory("Misc", "Misc", 3)
CreateCategory("Settings", "Settings", 4)

categoryButtons["Combat"].Button:SetAttribute("Active", true)

categoryButtons["Combat"].Button.BackgroundTransparency = 0
categoryButtons["Combat"].Text.TextColor3 = Color3.fromRGB(240, 240, 240)

--============================================================
-- MAIN WINDOW
--============================================================

local MainWindow = Create("Frame", {
	Name = "MainWindow",

	Position = UDim2.fromOffset(100, 0),

	Size = UDim2.new(1, -100, 0, 300),

	BackgroundColor3 = COLOR.WindowBottom,

	BorderSizePixel = 0,

	ZIndex = 46
}, Content)

AddCorner(MainWindow, 21)

AddStroke(
	MainWindow,
	Color3.fromRGB(255, 255, 255),
	0.92,
	1
)

Create("UIGradient", {
	Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, COLOR.WindowTop),
		ColorSequenceKeypoint.new(1, COLOR.WindowBottom)
	}),

	Rotation = 145
}, MainWindow)

--============================================================
-- WINDOW INNER
--============================================================

local WindowInner = Create("ScrollingFrame", {
	Name = "WindowInner",

	Position = UDim2ce.new("TextLabel")
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
