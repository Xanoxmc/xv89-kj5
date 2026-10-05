--// TENTIXWARE HUD
--// Roblox LocalScript
--// Полная версия

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

------------------------------------------------------------
-- CLEAN OLD GUI
------------------------------------------------------------

local oldGui = PlayerGui:FindFirstChild("TentixWareHUD")

if oldGui then
	oldGui:Destroy()
end

------------------------------------------------------------
-- COLORS
------------------------------------------------------------

local COLORS = {
	Background = Color3.fromRGB(9,9,9),
	Window = Color3.fromRGB(22,22,22),
	Window2 = Color3.fromRGB(30,30,30),

	Panel = Color3.fromRGB(20,20,20),
	PanelLight = Color3.fromRGB(38,38,38),

	Button = Color3.fromRGB(90,90,90),
	ButtonDark = Color3.fromRGB(55,55,55),

	Text = Color3.fromRGB(225,225,225),
	SubText = Color3.fromRGB(125,125,125),

	White = Color3.fromRGB(240,240,240),

	Off = Color3.fromRGB(48,48,48),
	On = Color3.fromRGB(105,105,105),

	Slider = Color3.fromRGB(58,58,58),
	SliderFill = Color3.fromRGB(125,125,125),
	SliderKnob = Color3.fromRGB(175,175,175),
}

------------------------------------------------------------
-- GUI
------------------------------------------------------------

local Gui = Instance.new("ScreenGui")
Gui.Name = "TentixWareHUD"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

------------------------------------------------------------
-- BLUR
------------------------------------------------------------

local Blur = Instance.new("BlurEffect")
Blur.Name = "TentixWareBlur"
Blur.Size = 0
Blur.Parent = game:GetService("Lighting")

------------------------------------------------------------
-- BACKGROUND
------------------------------------------------------------

local Background = Instance.new("Frame")
Background.Name = "Background"
Background.Size = UDim2.fromScale(1,1)
Background.BackgroundColor3 = COLORS.Background
Background.BorderSizePixel = 0
Background.Parent = Gui

local BackgroundGradient = Instance.new("UIGradient")
BackgroundGradient.Rotation = 90
BackgroundGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(38,38,38)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25,25,25)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(7,7,7))
})
BackgroundGradient.Parent = Background

------------------------------------------------------------
-- DARK OVERLAY
------------------------------------------------------------

local Overlay = Instance.new("Frame")
Overlay.Name = "Overlay"
Overlay.Size = UDim2.fromScale(1,1)
Overlay.BackgroundColor3 = Color3.new(0,0,0)
Overlay.BackgroundTransparency = 1
Overlay.BorderSizePixel = 0
Overlay.ZIndex = 5
Overlay.Parent = Gui

------------------------------------------------------------
-- MAIN CONTAINER
------------------------------------------------------------

local HudSystem = Instance.new("Frame")
HudSystem.Name = "HudSystem"
HudSystem.AnchorPoint = Vector2.new(0.5,0.5)
HudSystem.Position = UDim2.fromScale(0.5,0.5)
HudSystem.Size = UDim2.new(0,560,0,420)
HudSystem.BackgroundTransparency = 1
HudSystem.ZIndex = 20
HudSystem.Parent = Gui

------------------------------------------------------------
-- HUD BAR
------------------------------------------------------------

local Hud = Instance.new("Frame")
Hud.Name = "Hud"
Hud.AnchorPoint = Vector2.new(0.5,0)
Hud.Position = UDim2.new(0.5,0,0,0)
Hud.Size = UDim2.new(1,0,0,50)
Hud.BackgroundTransparency = 1
Hud.Parent = HudSystem

------------------------------------------------------------
-- BARS
------------------------------------------------------------

local Bars = Instance.new("Frame")
Bars.Name = "Bars"
Bars.AnchorPoint = Vector2.new(0.5,0.5)
Bars.Position = UDim2.fromScale(0.5,0.5)
Bars.Size = UDim2.new(0,0,0,46)
Bars.BackgroundTransparency = 1
Bars.ClipsDescendants = true
Bars.Parent = Hud

local BarsLayout = Instance.new("UIListLayout")
BarsLayout.FillDirection = Enum.FillDirection.Horizontal
BarsLayout.SortOrder = Enum.SortOrder.LayoutOrder
BarsLayout.Parent = Bars

------------------------------------------------------------
-- LEFT BAR
------------------------------------------------------------

local LeftBar = Instance.new("Frame")
LeftBar.Name = "Left"
LeftBar.Size = UDim2.new(0.5,0,1,0)
LeftBar.BackgroundColor3 = Color3.fromRGB(90,90,90)
LeftBar.BorderSizePixel = 0
LeftBar.Parent = Bars

local LeftCorner = Instance.new("UICorner")
LeftCorner.CornerRadius = UDim.new(0,23)
LeftCorner.Parent = LeftBar

local LeftLabel = Instance.new("TextLabel")
LeftLabel.AnchorPoint = Vector2.new(1,0.5)
LeftLabel.Position = UDim2.new(1,-18,0.5,0)
LeftLabel.Size = UDim2.new(0,70,0,30)
LeftLabel.BackgroundTransparency = 1
LeftLabel.Text = "FPS  60"
LeftLabel.TextColor3 = COLORS.Text
LeftLabel.TextSize = 11
LeftLabel.Font = Enum.Font.GothamBold
LeftLabel.TextXAlignment = Enum.TextXAlignment.Right
LeftLabel.Parent = LeftBar

------------------------------------------------------------
-- RIGHT BAR
------------------------------------------------------------

local RightBar = Instance.new("Frame")
RightBar.Name = "Right"
RightBar.Size = UDim2.new(0.5,0,1,0)
RightBar.BackgroundColor3 = Color3.fromRGB(90,90,90)
RightBar.BorderSizePixel = 0
RightBar.Parent = Bars

local RightCorner = Instance.new("UICorner")
RightCorner.CornerRadius = UDim.new(0,23)
RightCorner.Parent = RightBar

local PingLabel = Instance.new("TextLabel")
PingLabel.Position = UDim2.new(0,18,0.5,-15)
PingLabel.Size = UDim2.new(0,80,0,30)
PingLabel.BackgroundTransparency = 1
PingLabel.Text = "42 ms  PING"
PingLabel.TextColor3 = COLORS.Text
PingLabel.TextSize = 11
PingLabel.Font = Enum.Font.GothamBold
PingLabel.TextXAlignment = Enum.TextXAlignment.Left
PingLabel.Parent = RightBar

------------------------------------------------------------
-- OPEN BUTTON
------------------------------------------------------------

local OpenButton = Instance.new("TextButton")
OpenButton.Name = "OpenButton"
OpenButton.AnchorPoint = Vector2.new(0.5,0.5)
OpenButton.Position = UDim2.fromScale(0.5,0.5)
OpenButton.Size = UDim2.fromOffset(62,62)
OpenButton.BackgroundColor3 = Color3.fromRGB(110,110,110)
OpenButton.Text = ""
OpenButton.AutoButtonColor = false
OpenButton.ZIndex = 50
OpenButton.Parent = Hud

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1,0)
OpenCorner.Parent = OpenButton

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Color = Color3.fromRGB(150,150,150)
OpenStroke.Transparency = 0.45
OpenStroke.Thickness = 1
OpenStroke.Parent = OpenButton

local OpenIcon = Instance.new("TextLabel")
OpenIcon.Size = UDim2.fromScale(1,1)
OpenIcon.BackgroundTransparency = 1
OpenIcon.Text = "✦"
OpenIcon.TextColor3 = COLORS.White
OpenIcon.TextSize = 26
OpenIcon.Font = Enum.Font.GothamBold
OpenIcon.Parent = OpenButton

------------------------------------------------------------
-- BRAND
------------------------------------------------------------

local Brand = Instance.new("TextLabel")
Brand.Name = "Brand"
Brand.AnchorPoint = Vector2.new(0.5,0)
Brand.Position = UDim2.new(0.5,0,0,63)
Brand.Size = UDim2.new(0,125,0,25)
Brand.BackgroundColor3 = Color3.fromRGB(80,80,80)
Brand.Text = "TENTIXWARE"
Brand.TextColor3 = Color3.fromRGB(210,210,210)
Brand.TextSize = 9
Brand.Font = Enum.Font.GothamBold
Brand.TextTransparency = 1
Brand.Parent = HudSystem

local BrandCorner = Instance.new("UICorner")
BrandCorner.CornerRadius = UDim.new(0,14)
BrandCorner.Parent = Brand

------------------------------------------------------------
-- CONTENT
------------------------------------------------------------

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Position = UDim2.new(0,0,0,97)
Content.Size = UDim2.new(1,0,0,310)
Content.BackgroundTransparency = 1
Content.Parent = HudSystem

------------------------------------------------------------
-- CATEGORIES
------------------------------------------------------------

local Categories = Instance.new("Frame")
Categories.Name = "Categories"
Categories.Size = UDim2.new(0,92,1,0)
Categories.BackgroundColor3 = COLORS.Panel
Categories.Parent = Content

local CategoriesCorner = Instance.new("UICorner")
CategoriesCorner.CornerRadius = UDim.new(0,17)
CategoriesCorner.Parent = Categories

local CategoriesPadding = Instance.new("UIPadding")
CategoriesPadding.PaddingTop = UDim.new(0,7)
CategoriesPadding.PaddingBottom = UDim.new(0,7)
CategoriesPadding.PaddingLeft = UDim.new(0,7)
CategoriesPadding.PaddingRight = UDim.new(0,7)
CategoriesPadding.Parent = Categories

local CategoriesLayout = Instance.new("UIListLayout")
CategoriesLayout.Padding = UDim.new(0,6)
CategoriesLayout.Parent = Categories

------------------------------------------------------------
-- CATEGORY FUNCTION
------------------------------------------------------------

local CurrentCategory = "Combat"

local function CreateCategory(name, symbol)

	local Button = Instance.new("TextButton")
	Button.Name = name
	Button.Size = UDim2.new(1,0,0,52)
	Button.BackgroundColor3 = COLORS.Panel
	Button.Text = ""
	Button.AutoButtonColor = false
	Button.Parent = Categories

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0,12)
	Corner.Parent = Button

	local Icon = Instance.new("TextLabel")
	Icon.Position = UDim2.new(0,0,0,5)
	Icon.Size = UDim2.new(1,0,0,20)
	Icon.BackgroundTransparency = 1
	Icon.Text = symbol
	Icon.TextColor3 = COLORS.SubText
	Icon.TextSize = 17
	Icon.Font = Enum.Font.GothamBold
	Icon.Parent = Button

	local Text = Instance.new("TextLabel")
	Text.Position = UDim2.new(0,0,0,28)
	Text.Size = UDim2.new(1,0,0,15)
	Text.BackgroundTransparency = 1
	Text.Text = name
	Text.TextColor3 = COLORS.SubText
	Text.TextSize = 7
	Text.Font = Enum.Font.GothamBold
	Text.Parent = Button

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
