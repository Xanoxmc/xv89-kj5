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
ce.new("TextLabel")
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
