--// TENTIXWARE HUD
--// LocalScript
--// Помести в:
--// StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- CONFIG
--==================================================

local GUI_NAME = "TentixWareHUD"

local MAIN_WIDTH = 560
local MAIN_HEIGHT = 420

local TWEEN_FAST = TweenInfo.new(
	0.18,
	Enum.EasingStyle.Quart,
	Enum.EasingDirection.Out
)

local TWEEN_SMOOTH = TweenInfo.new(
	0.35,
	Enum.EasingStyle.Quart,
	Enum.EasingDirection.Out
)

--==================================================
-- CLEAN OLD GUI
--==================================================

local OldGui = PlayerGui:FindFirstChild(GUI_NAME)

if OldGui then
	OldGui:Destroy()
end

--==================================================
-- HELPERS
--==================================================

local function New(className, properties, parent)
	local object = Instance.new(className)

	for property, value in pairs(properties or {}) do
		object[property] = value
	end

	object.Parent = parent

	return object
end

local function Corner(parent, radius)
	return New("UICorner", {
		CornerRadius = UDim.new(0, radius or 10)
	}, parent)
end

local function Stroke(parent, color, transparency, thickness)
	return New("UIStroke", {
		Color = color or Color3.fromRGB(255, 255, 255),
		Transparency = transparency or 0.8,
		Thickness = thickness or 1
	}, parent)
end

local function Tween(object, info, properties)
	local tween = TweenService:Create(object, info, properties)
	tween:Play()
	return tween
end

--==================================================
-- COLORS
--==================================================

local BG = Color3.fromRGB(9, 10, 14)
local PANEL = Color3.fromRGB(15, 17, 23)
local PANEL2 = Color3.fromRGB(20, 22, 29)

local WHITE = Color3.fromRGB(245, 245, 250)
local GREY = Color3.fromRGB(145, 148, 158)
local DARK_GREY = Color3.fromRGB(55, 58, 67)

local ACCENT = Color3.fromRGB(145, 90, 255)
local ACCENT_DARK = Color3.fromRGB(91, 52, 170)

--==================================================
-- SCREEN GUI
--==================================================

local ScreenGui = New("ScreenGui", {
	Name = GUI_NAME,
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, PlayerGui)

--==================================================
-- SCALE
--==================================================

local UIScale = New("UIScale", {
	Scale = 1
}, ScreenGui)

local function UpdateScale()
	local camera = workspace.CurrentCamera

	if not camera then
		return
	end

	local viewport = camera.ViewportSize

	local widthScale = viewport.X / MAIN_WIDTH
	local heightScale = viewport.Y / MAIN_HEIGHT

	local scale = math.min(widthScale, heightScale)

	-- Не даём GUI стать слишком маленьким.
	scale = math.clamp(scale, 0.62, 1)

	UIScale.Scale = scale
end

task.spawn(function()
	while ScreenGui.Parent do
		UpdateScale()
		task.wait(0.5)
	end
end)

--==================================================
-- BACKGROUND OVERLAY
--==================================================

local Overlay = New("Frame", {
	Name = "Overlay",
	BackgroundColor3 = Color3.new(0, 0, 0),
	BackgroundTransparency = 0.38,
	BorderSizePixel = 0,
	Size = UDim2.fromScale(1, 1),
	Visible = false,
	ZIndex = 1
}, ScreenGui)

--==================================================
-- MAIN HUD
--==================================================

local Hud = New("Frame", {
	Name = "HUD",
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromOffset(MAIN_WIDTH, MAIN_HEIGHT),
	BackgroundTransparency = 1,
	Visible = false,
	ZIndex = 10
}, ScreenGui)

--==================================================
-- TOP BRAND
--==================================================

local Brand = New("TextLabel", {
	Name = "Brand",
	AnchorPoint = Vector2.new(0.5, 0),
	Position = UDim2.new(0.5, 0, 0, -42),
	Size = UDim2.fromOffset(190, 32),
	BackgroundColor3 = PANEL,
	BackgroundTransparency = 0.05,
	BorderSizePixel = 0,
	Text = "TENTIXWARE",
	TextColor3 = WHITE,
	TextSize = 14,
	Font = Enum.Font.GothamBold,
	ZIndex = 20
}, Hud)

Corner(Brand, 12)
Stroke(Brand, ACCENT, 0.72, 1)

--==================================================
-- FPS / PING
--==================================================

local FPS = New("TextLabel", {
	Name = "FPS",
	AnchorPoint = Vector2.new(0, 0),
	Position = UDim2.new(0, 8, 0, -34),
	Size = UDim2.fromOffset(90, 24),
	BackgroundTransparency = 1,
	Text = "FPS 60",
	TextColor3 = GREY,
	TextSize = 11,
	Font = Enum.Font.GothamMedium,
	TextXAlignment = Enum.TextXAlignment.Left,
	ZIndex = 20
}, Hud)

local PING = New("TextLabel", {
	Name = "PING",
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, -8, 0, -34),
	Size = UDim2.fromOffset(90, 24),
	BackgroundTransparency = 1,
	Text = "PING 0",
	TextColor3 = GREY,
	TextSize = 11,
	Font = Enum.Font.GothamMedium,
	TextXAlignment = Enum.TextXAlignment.Right,
	ZIndex = 20
}, Hud)

--==================================================
-- MAIN WINDOW
--==================================================

local Window = New("Frame", {
	Name = "Window",
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromOffset(MAIN_WIDTH, MAIN_HEIGHT),
	BackgroundColor3 = BG,
	BorderSizePixel = 0,
	ZIndex = 10
}, Hud)

Corner(Window, 18)
Stroke(Window, Color3.fromRGB(70, 72, 84), 0.55, 1)

--==================================================
-- WINDOW HEADER
--==================================================

local Header = New("Frame", {
	Name = "Header",
	Position = UDim2.fromOffset(0, 0),
	Size = UDim2.new(1, 0, 0, 52),
	BackgroundTransparency = 1,
	ZIndex = 12
}, Window)

local WindowTitle = New("TextLabel", {
	Name = "Title",
	Position = UDim2.fromOffset(18, 10),
	Size = UDim2.new(1, -70, 0, 18),
	BackgroundTransparency = 1,
	Text = "TentixWare",
	TextColor3 = WHITE,
	TextSize = 15,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left,
	ZIndex = 13
}, Header)

local WindowSubtitle = New("TextLabel", {
	Name = "Subtitle",
	Position = UDim2.fromOffset(18, 28),
	Size = UDim2.new(1, -70, 0, 16),
	BackgroundTransparency = 1,
	Text = "HUD / FUNCTIONS",
	TextColor3 = GREY,
	TextSize = 9,
	Font = Enum.Font.GothamMedium,
	TextXAlignment = Enum.TextXAlignment.Left,
	ZIndex = 13
}, Header)

--==================================================
-- CLOSE BUTTON
--==================================================

local CloseButton = New("TextButton", {
	Name = "Close",
	AnchorPoint = Vector2.new(1, 0.5),
	Position = UDim2.new(1, -14, 0.5, 0),
	Size = UDim2.fromOffset(30, 30),
	BackgroundColor3 = PANEL2,
	BackgroundTransparency = 0.1,
	BorderSizePixel = 0,
	Text = "×",
	TextColor3 = GREY,
	TextSize = 20,
	Font = Enum.Font.GothamMedium,
	AutoButtonColor = false,
	ZIndex = 20
}, Header)

Corner(CloseButton, 9)
Stroke(CloseButton, Color3.fromRGB(80, 82, 95), 0.65, 1)

CloseButton.MouseEnter:Connect(function()
	Tween(CloseButton, TWEEN_FAST, {
		BackgroundColor3 = Color3.fromRGB(34, 35, 44),
		TextColor3 = WHITE
	})
end)

CloseButton.MouseLeave:Connect(function()
	Tween(CloseButton, TWEEN_FAST, {
		BackgroundColor3 = PANEL2,
		TextColor3 = GREY
	})
end)

--==================================================
-- CONTENT
--==================================================

local Content = New("Frame", {
	Name = "Content",
	Position = UDim2.fromOffset(12, 58),
	Size = UDim2.new(1, -24, 1, -70),
	BackgroundTransparency = 1,
	ZIndex = 11
}, Window)

--==================================================
-- CATEGORIES
--==================================================

local Categories = New("Frame", {
	Name = "Categories",
	Position = UDim2.fromOffset(0, 0),
	Size = UDim2.fromOffset(130, 1),
	BackgroundColor3 = PANEL,
	BorderSizePixel = 0,
	ZIndex = 12
}, Content)

Corner(Categories, 12)
Stroke(Categories, Color3.fromRGB(65, 67, 78), 0.75, 1)

local CategoryList = New("UIListLayout", {
	Padding = UDim.new(0, 6),
	SortOrder = Enum.SortOrder.LayoutOrder
}, Categories)

local CategoryPadding = New("UIPadding", {
	PaddingTop = UDim.new(0, 10),
	PaddingLeft = UDim.new(0, 8),
	PaddingRight = UDim.new(0, 8)
}, Categories)

local ActiveCategory = nil

local function CreateCategory(text, order)
	local Button = New("TextButton", {
		Name = text,
		Size = UDim2.new(1, 0, 0, 38),
		BackgroundColor3 = PANEL,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Text = text,
		TextColor3 = GREY,
		TextSize = 11,
		Font = Enum.Font.GothamSemibold,
		AutoButtonColor = false,
		LayoutOrder = order,
		ZIndex = 15
	}, Categories)

	Corner(Button, 9)

	Button.MouseEnter:Connect(function()
		if ActiveCategory ~= Button then
			Tween(Button, TWEEN_FAST, {
				BackgroundColor3 = PANEL2,
				BackgroundTransparency = 0.15,
				TextColor3 = WHITE
			})
		end
	end)

	Button.MouseLeave:Connect(function()
		if ActiveCategory ~= Button then
			Tween(Button, TWEEN_FAST, {
				BackgroundTransparency = 1,
				TextColor3 = GREY
			})
		end
	end)

	Button.MouseButton1Click:Connect(function()
		if ActiveCategory and ActiveCategory ~= Button then
			Tween(ActiveCategory, TWEEN_FAST, {
				BackgroundTransparency = 1,
				TextColor3 = GREY
			})
		end

		ActiveCategory = Button

		Tween(Button, TWEEN_FAST, {
			BackgroundColor3 = ACCENT_DARK,
			BackgroundTransparency = 0.15,
			TextColor3 = WHITE
		})
	end)

	return Button
end

local CombatCategory = CreateCategory("Combat", 1)
local VisualsCategory = CreateCategory("Visuals", 2)
local MiscCategory = CreateCategory("Misc", 3)
local SettingsCategory = CreateCategory("Settings", 4)

ActiveCategory = CombatCategory

Tween(CombatCategory, TWEEN_FAST, {
	BackgroundColor3 = ACCENT_DARK,
	BackgroundTransparency = 0.15,
	TextColor3 = WHITE
})

--==================================================
-- FUNCTIONS WINDOW
--==================================================

local FunctionsWindow = New("Frame", {
	Name = "Functions",
	Position = UDim2.fromOffset(142, 0),
	Size = UDim2.new(1, -142, 1, 0),
	BackgroundColor3 = PANEL,
	BorderSizePixel = 0,
	ClipsDescendants = true,
	ZIndex = 12
}, Content)

Corner(FunctionsWindow, 12)
Stroke(FunctionsWindow, Color3.fromRGB(65, 67, 78), 0.75, 1)

--==================================================
-- FUNCTION HEADER
--==================================================

local FunctionTitle = New("TextLabel", {
	Position = UDim2.fromOffset(14, 10),
	Size = UDim2.new(1, -28, 0, 24),
	BackgroundTransparency = 1,
	Text = "COMBAT",
	TextColor3 = WHITE,
	TextSize = 12,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left,
	ZIndex = 15
}, FunctionsWindow)

local FunctionLine = New("Frame", {
	Position = UDim2.fromOffset(14, 39),
	Size = UDim2.new(1, -28, 0, 1),
	BackgroundColor3 = Color3.fromRGB(48, 50, 59),
	BorderSizePixel = 0,
	ZIndex = 14
}, FunctionsWindow)

--==================================================
-- TOGGLE CREATOR
--==================================================

local function CreateToggle(parent, position, enabled)
	local Holder = New("TextButton", {
		Position = position,
		Size = UDim2.fromOffset(42, 22),
		BackgroundColor3 = Color3.fromRGB(40, 42, 51),
		BorderSizePixel = 0,
		Text = "",
		AutoButtonColor = false,
		ZIndex = 30
	}, parent)

	Corner(Holder, 11)

	local Knob = New("Frame", {
		Position = UDim2.fromOffset(3, 3),
		Size = UDim2.fromOffset(16, 16),
		BackgroundColor3 = Color3.fromRGB(190, 192, 200),
		BorderSizePixel = 0,
		ZIndex = 31
	}, Holder)

	Corner(Knob, 8)

	local State = enabled == true

	local function SetState(value)
		State = value

		if State then
			Tween(Holder, TWEEN_FAST, {
				BackgroundColor3 = ACCENT
			})

			Tween(Knob, TWEEN_FAST, {
				Position = UDim2.new(1, -19, 0, 3),
				BackgroundColor3 = WHITE
			})
		else
			Tween(Holder, TWEEN_FAST, {
				BackgroundColor3 = Color3.fromRGB(40, 42, 51)
			})

			Tween(Knob, TWEEN_FAST, {
				Position = UDim2.fromOffset(3, 3),
				BackgroundColor3 = Color3.fromRGB(190, 192, 200)
			})
		end
	end

	Holder.MouseButton1Click:Connect(function()
		SetState(not State)
	end)

	SetState(State)

	return Holder, function()
		return State
	end, SetState
end

--==================================================
-- NORMAL FUNCTION
--==================================================

local TestRow = New("Frame", {
	Name = "Test",
	Position = UDim2.fromOffset(10, 50),
	Size = UDim2.new(1, -20, 0, 40),
	BackgroundColor3 = PANEL2,
	BorderSizePixel = 0,
	ZIndex = 15
}, FunctionsWindow)

Corner(TestRow, 9)

New("TextLabel", {
	Position = UDim2.fromOffset(12, 0),
	Size = UDim2.new(1, -75, 1, 0),
	BackgroundTransparency = 1,
	Text = "Test",
	TextColor3 = WHITE,
	TextSize = 11,
	Font = Enum.Font.GothamMedium,
	TextXAlignment = Enum.TextXAlignment.Left,
	ZIndex = 17
}, TestRow)

CreateToggle(
	TestRow,
	UDim2.new(1, -54, 0.5, -11),
	false
)

--==================================================
-- TEST1 EXPANDABLE FUNCTION
--==================================================

local Test1Container = New("Frame", {
	Name = "Test1",
	Position = UDim2.fromOffset(10, 96),
	Size = UDim2.new(1, -20, 0, 42),
	BackgroundColor3 = PANEL2,
	BorderSizePixel = 0,
	ClipsDescendants = true,
	ZIndex = 15
}, FunctionsWindow)

Corner(Test1Container, 9)

-- Header is a FRAME, NOT a button.
-- This allows the toggle and arrow to be clicked separately.

local Test1Header = New("Frame", {
	Name = "Header",
	Position = UDim2.fromOffset(0, 0),
	Size = UDim2.new(1, 0, 0, 42),
	BackgroundTransparency = 1,
	ZIndex = 17
}, Test1Container)

New("TextLabel", {
	Position = UDim2.fromOffset(38, 0),
	Size = UDim2.new(1, -110, 1, 0),
	BackgroundTransparency = 1,
	Text = "Test1",
	TextColor3 = WHITE,
	TextSize = 11,
	Font = Enum.Font.GothamMedium,
	TextXAlignment = Enum.TextXAlignment.Left,
	ZIndex = 20
}, Test1Header)

--==================================================
-- ARROW
--==================================================

local ArrowButton = New("TextButton", {
	Name = "Arrow",
	Position = UDim2.fromOffset(8, 6),
	Size = UDim2.fromOffset(30, 30),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Text = "‹",
	TextColor3 = GREY,
	TextSize = 25,
	Font = Enum.Font.GothamMedium,
	Rotation = 90,
	AutoButtonColor = false,
	ZIndex = 25
}, Test1Header)

--==================================================
-- TEST1 MAIN TOGGLE
--==================================================

local Test1Toggle = CreateToggle(
	Test1Header,
	UDim2.new(1, -54, 0.5, -11),
	false
)

--==================================================
-- SUBFUNCTIONS AREA
--==================================================

local Settings = New("Frame", {
	Name = "Settings",
	Position = UDim2.fromOffset(10, 48),
	Size = UDim2.new(1, -20, 0, 134),
	BackgroundTransparency = 1,
	ZIndex = 18
}, Test1Container)

--==================================================
-- SLIDER
--==================================================

local function CreateSlider(parent, y, startValue)
	local Holder = New("Frame", {
		Position = UDim2.new(0, 0, 0, y),
		Size = UDim2.new(1, 0, 0, 40),
		BackgroundTransparency = 1,
		ZIndex = 22
	}, parent)

	-- Value ABOVE slider
	local Value = New("TextLabel", {
		Position = UDim2.new(0.57, 0, 0, 0),
		Size = UDim2.new(0.40, 0, 0, 15),
		BackgroundTransparency = 1,
		Text = tostring(startValue),
		TextColor3 = WHITE,
		TextSize = 9,
		Font = Enum.Font.GothamBold,
		TextXAlignment = Enum.TextXAlignment.Right,
		ZIndex = 25
	}, Holder)

	local Slider = New("Frame", {
		Position = UDim2.new(0.57, 0, 0, 20),
		Size = UDim2.new(0.40, 0, 0, 5),
		BackgroundColor3 = Color3.fromRGB(48, 50, 59),
		BorderSizePixel = 0,
		ZIndex = 23
	}, Holder)

	Corner(Slider, 4)

	local Fill = New("Frame", {
		Position = UDim2.fromScale(0, 0),
		Size = UDim2.new(startValue / 100, 0, 1, 0),
		BackgroundColor3 = ACCENT,
		BorderSizePixel = 0,
		ZIndex = 24
	}, Slider)

	Corner(Fill, 4)

	local Knob = New("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(startValue / 100, 0, 0.5, 0),
		Size = UDim2.fromOffset(12, 12),
		BackgroundColor3 = WHITE,
		BorderSizePixel = 0,
		ZIndex = 26
	}, Slider)

	Corner(Knob, 8)

	local Dragging = false

	local function SetValueFromX(x)
		local left = Slider.AbsolutePosition.X
		local width = Slider.AbsoluteSize.X

		local percent = math.clamp(
			(x - left) / width,
			0,
			1
		)

		local value = math.floor(percent * 100 + 0.5)

		Value.Text = tostring(value)

		Fill.Size = UDim2.new(percent, 0, 1, 0)
		Knob.Position = UDim2.new(percent, 0, 0.5, 0)
	end

	Slider.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			Dragging = true
			SetValueFromX(input.Position.X)
		end
	end)

	Slider.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			Dragging = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if not Dragging then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then

			SetValueFromX(input.Position.X)
		end
	end)

	return Holder
end

--==================================================
-- SUBFUNCTION ROW CREATOR
--==================================================

local function CreateSubFunction(name, y, value)
	local Row = New("Frame", {
		Name = name,
		Position = UDim2.fromOffset(0, y),
		Size = UDim2.new(1, 0, 0, 40),
		BackgroundColor3 = Color3.fromRGB(24, 26, 34),
		BorderSizePixel = 0,
		ZIndex = 20
	}, Settings)

	Corner(Row, 8)

	New("TextLabel", {
		Position = UDim2.fromOffset(10, 0),
		Size = UDim2.new(0.42, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = name,
		TextColor3 = WHITE,
		TextSize = 10,
		Font = Enum.Font.GothamMedium,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 25
	}, Row)

	-- Toggle is BEFORE slider.
	CreateToggle(
		Row,
		UDim2.new(0.45, 0, 0.5, -11),
		false
	)

	-- Slider is to the RIGHT of toggle.
	CreateSlider(
		Row,
		0,
		value
	)

	return Row
end

--==================================================
-- SUBFUNCTIONS
--==================================================

CreateSubFunction("Test", 0, 50)
CreateSubFunction("Test1", 44, 65)
CreateSubFunction("Test2", 88, 30)

--==================================================
-- EXPAND / COLLAPSE
--==================================================

local Expanded = false

local CLOSED_HEIGHT = 42
local OPEN_HEIGHT = 188

local function SetExpanded(state)
	Expanded = state

	if Expanded then
		-- Arrow DOWN
		Tween(ArrowButton, TWEEN_SMOOTH, {
			Rotation = -90,
			TextColor3 = WHITE
		})

		Tween(Test1Container, TWEEN_SMOOTH, {
			Size = UDim2.new(1, -20, 0, OPEN_HEIGHT)
		})
	else
		-- Arrow UP
		Tween(ArrowButton, TWEEN_SMOOTH, {
			Rotation = 90,
			TextColor3 = GREY
		})

		Tween(Test1Container, TWEEN_SMOOTH, {
			Size = UDim2.new(1, -20, 0, CLOSED_HEIGHT)
		})
	end
end

ArrowButton.MouseButton1Click:Connect(function()
	SetExpanded(not Expanded)
end)

--==================================================
-- OPEN / CLOSE BUTTON
--==================================================

local OpenButton = New("TextButton", {
	Name = "OpenButton",
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromOffset(74, 74),
	BackgroundColor3 = PANEL,
	BorderSizePixel = 0,
	Text = "",
	AutoButtonColor = false,
	Visible = true,
	ZIndex = 50
}, ScreenGui)

Corner(OpenButton, 20)
Stroke(OpenButton, ACCENT, 0.45, 1)

local OpenCore = New("Frame", {
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromOffset(38, 38),
	BackgroundColor3 = ACCENT,
	BorderSizePixel = 0,
on

	Button.MouseButton1Click:Connect(function()

		CurrentCategory = name

		for _,v in ipairs(Categories:GetChildren()) do
			if v:IsA("TextButton") then
				v.BackgroundColor3 = COLORS.Panel

				for _,child in ipairs(v:GetChildren()) do
					if child:IsA("TextLabel") then
						child.TextColor3 = COLORS.SubText
					end
				end
			end
		end

		Button.BackgroundColor3 = COLORS.Button

		Icon.TextColor3 = COLORS.White
		Text.TextColor3 = COLORS.White

		WindowTitle.Text = string.upper(name)

	end)

	return Button
end

------------------------------------------------------------
-- MAIN WINDOW
------------------------------------------------------------

local MainWindow = Instance.new("Frame")
MainWindow.Name = "MainWindow"
MainWindow.Position = UDim2.new(0,100,0,0)
MainWindow.Size = UDim2.new(1,-100,0,310)
MainWindow.BackgroundColor3 = COLORS.Window
MainWindow.BorderSizePixel = 0
MainWindow.Parent = Content

local WindowCorner = Instance.new("UICorner")
WindowCorner.CornerRadius = UDim.new(0,21)
WindowCorner.Parent = MainWindow

local WindowStroke = Instance.new("UIStroke")
WindowStroke.Color = Color3.fromRGB(65,65,65)
WindowStroke.Transparency = 0.75
WindowStroke.Thickness = 1
WindowStroke.Parent = MainWindow

------------------------------------------------------------
-- WINDOW TITLE
------------------------------------------------------------

local WindowTitle = Instance.new("TextLabel")
WindowTitle.Position = UDim2.new(0,16,0,12)
WindowTitle.Size = UDim2.new(0.5,0,0,20)
WindowTitle.BackgroundTransparency = 1
WindowTitle.Text = "COMBAT"
WindowTitle.TextColor3 = COLORS.Text
WindowTitle.TextSize = 11
WindowTitle.Font = Enum.Font.GothamBold
WindowTitle.TextXAlignment = Enum.TextXAlignment.Left
WindowTitle.Parent = MainWindow

local WindowBrand = Instance.new("TextLabel")
WindowBrand.AnchorPoint = Vector2.new(1,0)
WindowBrand.Position = UDim2.new(1,-16,0,13)
WindowBrand.Size = UDim2.new(0,90,0,18)
WindowBrand.BackgroundTransparency = 1
WindowBrand.Text = "TENTIXWARE"
WindowBrand.TextColor3 = COLORS.SubText
WindowBrand.TextSize = 7
WindowBrand.Font = Enum.Font.GothamBold
WindowBrand.TextXAlignment = Enum.TextXAlignment.Right
WindowBrand.Parent = MainWindow

------------------------------------------------------------
-- SCROLL
------------------------------------------------------------

local Scroll = Instance.new("ScrollingFrame")
Scroll.Position = UDim2.new(0,10,0,40)
Scroll.Size = UDim2.new(1,-20,1,-50)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 0
Scroll.CanvasSize = UDim2.new(0,0,0,0)
Scroll.Parent = MainWindow

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0,8)
Layout.Parent = Scroll

------------------------------------------------------------
-- UPDATE CANVAS
------------------------------------------------------------

local function UpdateCanvas()

	task.defer(function()

		Scroll.CanvasSize =
			UDim2.new(
				0,
				0,
				0,
				Layout.AbsoluteContentSize.Y + 10
			)

	end)

end

Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateCanvas)

------------------------------------------------------------
-- MODULE FUNCTION
------------------------------------------------------------

local function CreateModule(name, description)

	local Module = Instance.new("Frame")
	Module.Name = name
	Module.Size = UDim2.new(1,0,0,42)
	Module.BackgroundColor3 = Color3.fromRGB(28,28,28)
	Module.BorderSizePixel = 0
	Module.Parent = Scroll

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0,12)
	Corner.Parent = Module

	local NameLabel = Instance.new("TextLabel")
	NameLabel.Position = UDim2.new(0,11,0,7)
	NameLabel.Size = UDim2.new(0.5,0,0,14)
	NameLabel.BackgroundTransparency = 1
	NameLabel.Text = name
	NameLabel.TextColor3 = COLORS.Text
	NameLabel.TextSize = 9
	NameLabel.Font = Enum.Font.GothamBold
	NameLabel.TextXAlignment = Enum.TextXAlignment.Left
	NameLabel.Parent = Module

	local Description = Instance.new("TextLabel")
	Description.Position = UDim2.new(0,11,0,22)
	Description.Size = UDim2.new(0.5,0,0,11)
	Description.BackgroundTransparency = 1
	Description.Text = description
	Description.TextColor3 = COLORS.SubText
	Description.TextSize = 7
	Description.Font = Enum.Font.Gotham
	Description.TextXAlignment = Enum.TextXAlignment.Left
	Description.Parent = Module

	return Module
end

------------------------------------------------------------
-- TOGGLE
------------------------------------------------------------

local function CreateToggle(parent)

	local Toggle = Instance.new("TextButton")
	Toggle.Name = "Toggle"
	Toggle.AnchorPoint = Vector2.new(1,0.5)
	Toggle.Position = UDim2.new(1,-11,0.5,0)
	Toggle.Size = UDim2.fromOffset(32,18)
	Toggle.BackgroundColor3 = COLORS.Off
	Toggle.Text = ""
	Toggle.AutoButtonColor = false
	Toggle.ZIndex = 10
	Toggle.Parent = parent

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(1,0)
	Corner.Parent = Toggle

	local Knob = Instance.new("Frame")
	Knob.Name = "Knob"
	Knob.Position = UDim2.new(0,3,0.5,-6)
	Knob.Size = UDim2.fromOffset(12,12)
	Knob.BackgroundColor3 = Color3.fromRGB(115,115,115)
	Knob.BorderSizePixel = 0
	Knob.Parent = Toggle

	local KnobCorner = Instance.new("UICorner")
	KnobCorner.CornerRadius = UDim.new(1,0)
	KnobCorner.Parent = Knob

	local Enabled = false

	local function SetEnabled(state)

		Enabled = state

		local goal = {}

		if Enabled then
			goal.Position = UDim2.new(1,-15,0.5,-6)
			goal.BackgroundColor3 = COLORS.White
			Toggle.BackgroundColor3 = COLORS.On
		else
			goal.Position = UDim2.new(0,3,0.5,-6)
			goal.BackgroundColor3 = Color3.fromRGB(115,115,115)
			Toggle.BackgroundColor3 = COLORS.Off
		end

		TweenService:Create(
			Knob,
			TweenInfo.new(
				0.18,
				Enum.EasingStyle.Quart,
				Enum.EasingDirection.Out
			),
			goal
		):Play()

	end

	Toggle.MouseButton1Click:Connect(function()
		SetEnabled(not Enabled)
	end)

	Toggle:SetAttribute("Enabled",false)

	return Toggle, SetEnabled
end

------------------------------------------------------------
-- SLIDER
-- VALUE ABOVE SLIDER
------------------------------------------------------------

local function CreateSlider(parent, defaultValue)

	local Container = Instance.new("Frame")
	Container.Name = "SliderContainer"
	Container.AnchorPoint = Vector2.new(1,0.5)
	Container.Position = UDim2.new(1,-10,0.5,0)
	Container.Size = UDim2.fromOffset(90,34)
	Container.BackgroundTransparency = 1
	Container.Parent = parent

	--------------------------------------------------------
	-- VALUE ABOVE
	--------------------------------------------------------

	local ValueLabel = Instance.new("TextLabel")
	ValueLabel.AnchorPoint = Vector2.new(0.5,1)
	ValueLabel.Position = UDim2.new(0.5,0,0,10)
	ValueLabel.Size = UDim2.new(0,40,0,12)
	ValueLabel.BackgroundTransparency = 1
	ValueLabel.Text = tostring(defaultValue)
	ValueLabel.TextColor3 = Color3.fromRGB(170,170,170)
	ValueLabel.TextSize = 7
	ValueLabel.Font = Enum.Font.GothamBold
	ValueLabel.Parent = Container

	--------------------------------------------------------
	-- SLIDER
	--------------------------------------------------------

	local SliderBackground = Instance.new("Frame")
	SliderBackground.AnchorPoint = Vector2.new(0.5,0)
	SliderBackground.Position = UDim2.new(0.5,0,0,17)
	SliderBackground.Size = UDim2.new(1,-10,0,4)
	SliderBackground.BackgroundColor3 = COLORS.Slider
	SliderBackground.BorderSizePixel = 0
	SliderBackground.Parent = Container

	local SliderCorner = Instance.new("UICorner")
	SliderCorner.CornerRadius = UDim.new(1,0)
	SliderCorner.Parent = SliderBackground

	local Fill = Instance.new("Frame")
	Fill.Size = UDim2.new(defaultValue/100,0,1,0)
	Fill.BackgroundColor3 = COLORS.SliderFill
	Fill.BorderSizePixel = 0
	Fill.Parent = SliderBackground

	local FillCorner = Instance.new("UICorner")
	FillCorner.CornerRadius = UDim.new(1,0)
	FillCorner.Parent = Fill

	local Knob = Instance.new("TextButton")
	Knob.AnchorPoint = Vector2.new(0.5,0.5)
	Knob.Position = UDim2.new(defaultValue/100,0,0.5,0)
	Knob.Size = UDim2.fromOffset(13,13)
	Knob.BackgroundColor3 = COLORS.SliderKnob
	Knob.Text = ""
	Knob.AutoButtonColor = false
	Knob.ZIndex = 5
	Knob.Parent = SliderBackground

	local KnobCorner = Instance.new("UICorner")
	KnobCorner.CornerRadius = UDim.new(1,0)
	KnobCorner.Parent = Knob

	--------------------------------------------------------
	-- SLIDER LOGIC
	--------------------------------------------------------

	local Value = defaultValue
	local Dragging = false

	local function SetValue(value)

		Value = math.clamp(
			math.floor(value + 0.5),
			0,
			100
		)

		local alpha =
			Value / 100

		Fill.Size =
			UDim2.new(
				alpha,
				0,
				1,
				0
			)

		Knob.Position =
			UDim2.new(
				alpha,
				0,
				0.5,
				0
			)

		ValueLabel.Text =
			tostring(Value)

	end

	local function UpdateFromMouse(x)

		local absolutePosition =
			SliderBackground.AbsolutePosition.X

		local absoluteSize =
			SliderBackground.AbsoluteSize.X

		local alpha =
			math.clamp(
				(x - absolutePosition) /
				absoluteSize,
				0,
				1
			)

		SetValue(alpha * 100)

	end

	Knob.InputBegan:Connect(function(input)

		if
			input.UserInputType ==
			Enum.UserInputType.MouseButton1
			or
			input.UserInputType ==
			Enum.UserInputType.Touch
		then

			Dragging = true

		end

	end)

	UserInputService.InputChanged:Connect(function(input)

		if not Dragging then
			return
		end

		if
			input.UserInputType ==
			Enum.UserInputType.MouseMovement
			or
			input.UserInputType ==
			Enum.UserInputType.Touch
		then

			UpdateFromMouse(input.Position.X)

		end

	end)

	UserInputService.InputEnded:Connect(function(input)

		if
			input.UserInputType ==
			Enum.UserInputType.MouseButton1
			or
			input.UserInputType ==
			Enum.UserInputType.Touch
		then

			Dragging = false

		end

	end)

	SliderBackground.InputBegan:Connect(function(input)

		if
			input.UserInputType ==
			Enum.UserInputType.MouseButton1
			or
			input.UserInputType ==
			Enum.UserInput"16"
minL.TextColor3 = Color3.fromRGB(255, 255, 255)
minL.TextTransparency = 0.72
minL.TextSize = 8
minL.Font = Enum.Font.Gotham
minL.TextXAlignment = Enum.TextXAlignment.Left
minL.ZIndex = 17
minL.Parent = card

local maxL = Instance.new("TextLabel")
maxL.Size = UDim2.new(0, 30, 0, 14)
maxL.Position = UDim2.new(1, -42, 0, 44)
maxL.BackgroundTransparency = 1
maxL.Text = "100"
maxL.TextColor3 = Color3.fromRGB(255, 255, 255)
maxL.TextTransparency = 0.72
maxL.TextSize = 8
maxL.Font = Enum.Font.Gotham
maxL.TextXAlignment = Enum.TextXAlignment.Right
maxL.ZIndex = 17
maxL.Parent = card

local descL = Instance.new("TextLabel")
descL.Size = UDim2.new(1, -24, 0, 16)
descL.Position = UDim2.new(0, 12, 0, 60)
descL.BackgroundTransparency = 1
descL.Text = "Макс скорость без кика · MM2"
descL.TextColor3 = Color3.fromRGB(255, 255, 255)
descL.TextTransparency = 0.7
descL.TextSize = 8.5
descL.Font = Enum.Font.Gotham
descL.TextXAlignment = Enum.TextXAlignment.Left
descL.ZIndex = 17
descL.Parent = card

local presets = {{"Норм", 50}, {"Быстро", 75}, {"Макс", 100}}
for i, pr in ipairs(presets) do
    local pb = Instance.new("TextButton")
    pb.Size = UDim2.new(0, 68, 0, 22)
    pb.Position = UDim2.new(0, 12 + (i-1)*76, 0, 82)
    pb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    pb.BackgroundTransparency = 0.91
    pb.Text = pr[1].."  "..pr[2]
    pb.TextColor3 = Color3.fromRGB(255, 255, 255)
    pb.TextTransparency = 0.3
    pb.TextSize = 8.5
    pb.Font = Enum.Font.GothamBold
    pb.BorderSizePixel = 0
    pb.ZIndex = 17
    pb.Parent = card
    Instance.new("UICorner", pb).CornerRadius = UDim.new(0, 6)

    pb.MouseButton1Click:Connect(function()
        currentSpeed = pr[2]
        local pct = (currentSpeed - 16) / 84
        sliderFill.Size = UDim2.new(pct, 0, 1, 0)
        sliderKnob.Position = UDim2.new(pct, -7, 0.5, -7)
        speedValL.Text = currentSpeed
        if speedEnabled then
            local char = lp.Character
            if char then
                local h = char:FindFirstChildOfClass("Humanoid")
                if h then h.WalkSpeed = currentSpeed end
            end
        end
    end)
end

local function applySpeed(on)
    speedEnabled = on
    local char = lp.Character
    if char then
        local h = char:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = on and currentSpeed or 16 end
    end
    TweenService:Create(tog, TweenInfo.new(0.18), {
        BackgroundColor3 = on and Color3.fromRGB(94, 234, 212) or Color3.fromRGB(35, 30, 55)
    }):Play()
    TweenService:Create(togDot, TweenInfo.new(0.18), {
        Position = on and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6),
        BackgroundColor3 = on and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(110, 105, 135)
    }):Play()
end

togBtn.MouseButton1Click:Connect(function()
    applySpeed(not speedEnabled)
end)

-- Слайдер drag
local sliderDrag = false
sliderBg.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        sliderDrag = true
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        sliderDrag = false
    end
end)
UIS.InputChanged:Connect(function(i)
    if sliderDrag and (i.UserInputType == Enum.UserInputType.MouseMovement
    or i.UserInputType == Enum.UserInputType.Touch) then
        local pct = math.clamp(
            (i.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X,
            0, 1
        )
        currentSpeed = math.floor(16 + pct * 84)
        sliderFill.Size = UDim2.new(pct, 0, 1, 0)
        sliderKnob.Position = UDim2.new(pct, -7, 0.5, -7)
        speedValL.Text = currentSpeed
        if speedEnabled then
            local char = lp.Character
            if char then
                local h = char:FindFirstChildOfClass("Humanoid")
                if h then h.WalkSpeed = currentSpeed end
            end
        end
    end
end)

lp.CharacterAdded:Connect(function(char)
    if speedEnabled then
        task.wait(0.5)
        local h = char:WaitForChild("Humanoid")
        if h then h.WalkSpeed = currentSpeed end
    end
end)

-- ОТКРЫТИЕ
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
    isOpen = false
    panel.Visible = false
end)

-- БЛИК
local bt = 0
RunService.Heartbeat:Connect(function(dt)
    bt = bt + dt * 0.45
    local x = (bt % 1.6) - 0.22
    blik.Position = UDim2.new(x, 0, 0, 0)
end)

-- FPS + ПИНГ
local fr, el = 0, 0
RunService.Heartbeat:Connect(function(dt)
    fr = fr + 1
    el = el + dt
    if el >= 0.7 then
        local fps = math.floor(fr / el)
        fpsL.Text = fps.."fps"
        fpsL.TextColor3 = fps >= 55
            and Color3.fromRGB(147, 200, 255)
            or fps >= 30
            and Color3.fromRGB(251, 191, 36)
            or Color3.fromRGB(248, 113, 113)

        local s, p = pcall(function()
            return math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        if s then
            pingL.Text = p.."ms"
            pingL.TextColor3 = p < 60
                and Color3.fromRGB(94, 234, 212)
                or p < 100
                and Color3.fromRGB(251, 191, 36)
                or Color3.fromRGB(248, 113, 113)
        end
        fr = 0
        el = 0
    end
end)
