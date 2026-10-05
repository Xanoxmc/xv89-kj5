й--============================================================
-- TENTIXWARE HUD
-- Roblox LocalScript
-- Place: StarterPlayer > StarterPlayerScripts
--
-- PC:
--   RightShift = Open / Close
--
-- Mobile:
--   Touch the center Open Core
--   Lock button can be dragged
--
-- Flow:
--   LOCK -> UNLOCK -> OPEN CORE -> GUI
--============================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--============================================================
-- CLEAN OLD VERSION
--============================================================

local oldGui = PlayerGui:FindFirstChild("TentixWareHUD")

if oldGui then
	oldGui:Destroy()
end

local oldBlur = Lighting:FindFirstChild("TentixWareBlur")

if oldBlur then
	oldBlur:Destroy()
end

--============================================================
-- COLORS
--============================================================

local COLOR = {
	Black = Color3.fromRGB(9, 9, 9),

	BackgroundTop = Color3.fromRGB(56, 56, 56),
	BackgroundMid = Color3.fromRGB(32, 32, 32),
	BackgroundBottom = Color3.fromRGB(8, 8, 8),

	BarTop = Color3.fromRGB(116, 116, 116),
	BarBottom = Color3.fromRGB(83, 83, 83),

	CoreTop = Color3.fromRGB(153, 153, 153),
	CoreMid = Color3.fromRGB(116, 116, 116),
	CoreBottom = Color3.fromRGB(85, 85, 85),

	PanelTop = Color3.fromRGB(37, 37, 37),
	PanelBottom = Color3.fromRGB(17, 17, 17),

	WindowTop = Color3.fromRGB(34, 34, 34),
	WindowBottom = Color3.fromRGB(13, 13, 13),

	Module = Color3.fromRGB(31, 31, 31),

	White = Color3.fromRGB(238, 238, 238),
	Light = Color3.fromRGB(221, 221, 221),

	Grey = Color3.fromRGB(160, 160, 160),
	DarkGrey = Color3.fromRGB(119, 119, 119),

	AccentGrey = Color3.fromRGB(102, 102, 102),
	AccentGrey2 = Color3.fromRGB(75, 75, 75),

	Slider = Color3.fromRGB(56, 56, 56),
	SliderKnob = Color3.fromRGB(170, 170, 170)
}

--============================================================
-- TWEEN INFOS
--============================================================

local T_FAST = TweenInfo.new(
	0.2,
	Enum.EasingStyle.Quad,
	Enum.EasingDirection.Out
)

local T_MEDIUM = TweenInfo.new(
	0.4,
	Enum.EasingStyle.Quart,
	Enum.EasingDirection.Out
)

local T_SMOOTH = TweenInfo.new(
	0.55,
	Enum.EasingStyle.Quart,
	Enum.EasingDirection.Out
)

local T_SLOW = TweenInfo.new(
	0.7,
	Enum.EasingStyle.Quart,
	Enum.EasingDirection.Out
)

--============================================================
-- HELPERS
--============================================================

local function Create(className, properties, parent)
	local object = Instance.new(className)

	for property, value in pairs(properties or {}) do
		object[property] = value
	end

	object.Parent = parent

	return object
end

local function AddCorner(parent, radius)
	return Create("UICorner", {
		CornerRadius = UDim.new(0, radius)
	}, parent)
end

local function AddStroke(parent, color, transparency, thickness)
	return Create("UIStroke", {
		Color = color,
		Transparency = transparency,
		Thickness = thickness or 1
	}, parent)
end

local function Tween(object, info, properties)
	local tween = TweenService:Create(
		object,
		info,
		properties
	)

	tween:Play()

	return tween
end

--============================================================
-- SCREEN GUI
--============================================================

local ScreenGui = Create("ScreenGui", {
	Name = "TentixWareHUD",

	ResetOnSpawn = false,

	IgnoreGuiInset = true,

	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,

	DisplayOrder = 999,

	ScreenInsets = Enum.ScreenInsets.None
}, PlayerGui)

--============================================================
-- RESPONSIVE SCALE
--============================================================

local UIScale = Create("UIScale", {
	Scale = 1
}, ScreenGui)

local function UpdateScale()
	local camera = workspace.CurrentCamera

	if not camera then
		return
	end

	local viewport = camera.ViewportSize

	local baseWidth = 560
	local baseHeight = 500

	local scaleX = viewport.X / baseWidth
	local scaleY = viewport.Y / baseHeight

	local scale = math.min(scaleX, scaleY)

	scale = math.clamp(
		scale,
		0.55,
		1
	)

	UIScale.Scale = scale
end

task.spawn(function()
	while ScreenGui.Parent do
		UpdateScale()
		task.wait(0.5)
	end
end)

--============================================================
-- BACKGROUND
--============================================================

local Background = Create("Frame", {
	Name = "GameBackground",

	Position = UDim2.fromScale(0, 0),

	Size = UDim2.fromScale(1, 1),

	BackgroundColor3 = COLOR.BackgroundBottom,

	BorderSizePixel = 0,

	ZIndex = 1
}, ScreenGui)

-- radial-like layered background
local BackgroundGlow = Create("Frame", {
	AnchorPoint = Vector2.new(0.5, 0.5),

	Position = UDim2.fromScale(0.5, 0.45),

	Size = UDim2.fromScale(1.4, 1.4),

	BackgroundColor3 = COLOR.BackgroundTop,

	BackgroundTransparency = 0.2,

	BorderSizePixel = 0,

	ZIndex = 1
}, Background)

AddCorner(BackgroundGlow, 999)

--============================================================
-- OVERLAY
--============================================================

local Overlay = Create("Frame", {
	Name = "Overlay",

	Position = UDim2.fromScale(0, 0),

	Size = UDim2.fromScale(1, 1),

	BackgroundColor3 = Color3.fromRGB(0, 0, 0),

	BackgroundTransparency = 1,

	BorderSizePixel = 0,

	ZIndex = 30,

	Visible = true
}, ScreenGui)

--============================================================
-- BLUR
--============================================================

local Blur = Create("BlurEffect", {
	Name = "TentixWareBlur",

	Size = 0
}, Lighting)

--============================================================
-- HUD SYSTEM
--============================================================

local HudSystem = Create("Frame", {
	Name = "HudSystem",

	AnchorPoint = Vector2.new(0.5, 0.5),

	Position = UDim2.fromScale(0.5, 0.5),

	Size = UDim2.fromOffset(560, 500),

	BackgroundTransparency = 1,

	BorderSizePixel = 0,

	ZIndex = 40
}, ScreenGui)

--============================================================
-- HUD
--============================================================

local Hud = Create("Frame", {
	Name = "HUD",

	Position = UDim2.fromOffset(0, 0),

	Size = UDim2.new(1, 0, 0, 50),

	BackgroundTransparency = 1,

	BorderSizePixel = 0,

	ZIndex = 41
}, HudSystem)

--============================================================
-- BARS
--============================================================

local Bars = Create("Frame", {
	Name = "Bars",

	AnchorPoint = Vector2.new(0.5, 0.5),

	Position = UDim2.fromScale(0.5, 0.5),

	Size = UDim2.fromOffset(0, 46),

	BackgroundTransparency = 1,

	BorderSizePixel = 0,

	ZIndex = 41
}, Hud)

-- LEFT BAR

local LeftBar = Create("Frame", {
	Name = "Left",

	Position = UDim2.fromScale(0, 0),

	Size = UDim2.fromScale(0.5, 1),

	BackgroundColor3 = COLOR.BarTop,

	BorderSizePixel = 0,

	BackgroundTransparency = 1,

	ZIndex = 41
}, Bars)

AddCorner(LeftBar, 23)

local LeftGradient = Create("UIGradient", {
	Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, COLOR.BarTop),
		ColorSequenceKeypoint.new(1, COLOR.BarBottom)
	}),

	Rotation = 90
}, LeftBar)

local LeftCover = Create("Frame", {
	AnchorPoint = Vector2.new(1, 0.5),

	Position = UDim2.fromScale(1, 0.5),

	Size = UDim2.new(0, 0, 1, 0),

	BackgroundColor3 = COLOR.BarBottom,

	BorderSizePixel = 0,

	BackgroundTransparency = 1,

	ZIndex = 42
}, LeftBar)

-- RIGHT BAR

local RightBar = Create("Frame", {
	Name = "Right",

	Position = UDim2.fromScale(0.5, 0),

	Size = UDim2.fromScale(0.5, 1),

	BackgroundColor3 = COLOR.BarTop,

	BorderSizePixel = 0,

	BackgroundTransparency = 1,

	ZIndex = 41
}, Bars)

AddCorner(RightBar, 23)

Create("UIGradient", {
	Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, COLOR.BarTop),
		ColorSequenceKeypoint.new(1, COLOR.BarBottom)
	}),

	Rotation = 90
}, RightBar)

--============================================================
-- FPS
--============================================================

local FPSHolder = Create("Frame", {
	AnchorPoint = Vector2.new(1, 0.5),

	Position = UDim2.new(1, -44, 0.5, 0),

	Size = UDim2.fromOffset(75, 22),

	BackgroundTransparency = 1,

	BorderSizePixel = 0,

	ZIndex = 43
}, LeftBar)

local FPSLabel = Create("TextLabel", {
	Position = UDim2.fromScale(0, 0),

	Size = UDim2.new(0.42, 0, 1, 0),

	BackgroundTransparency = 1,

	Text = "FPS",

	TextColor3 = Color3.fromRGB(185, 185, 185),

	TextSize = 9,

	Font = Enum.Font.GothamBold,

	TextXAlignment = Enum.TextXAlignment.Right,

	ZIndex = 44
}, FPSHolder)

local FPSValue = Create("TextLabel", {
	Position = UDim2.new(0.52, 0, 0, 0),

	Size = UDim2.new(0.48, 0, 1, 0),

	BackgroundTransparency = 1,

	Text = "60",

	TextColor3 = COLOR.White,

	TextSize = 11,

	Font = Enum.Font.GothamBold,

	TextXAlignment = Enum.TextXAlignment.Left,

	ZIndex = 44
}, FPSHolder)

--============================================================
-- PING
--============================================================

local PingHolder = Create("Frame", {
	Position = UDim2.fromOffset(44, 0),

	Size = UDim2.fromOffset(85, 22),

	BackgroundTransparency = 1,

	BorderSizePixel = 0,

	ZIndex = 43
}, RightBar)

local PingValue = Create("TextLabel", {
	Position = UDim2.fromScale(0, 0),

	Size = UDim2.new(0.62, 0, 1, 0),

	BackgroundTransparency = 1,

	Text = "42 ms",

	TextColor3 = COLOR.White,

	TextSize = 11,

	Font = Enum.Font.GothamBold,

	TextXAlignment = Enum.TextXAlignment.Right,

	ZIndex = 44
}, PingHolder)

local PingLabel = Create("TextLabel", {
	Position = UDim2.new(0.7, 0, 0, 0),

	Size = UDim2.new(0.3, 0, 1, 0),

	BackgroundTransparency = 1,

	Text = "PING",

	TextColor3 = Color3.fromRGB(185, 185, 185),

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
