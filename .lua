local GUI = Instance.new("ScreenGui")
local Container = Instance.new("Frame")
local MainFrame = Instance.new("Frame")
local label = Instance.new("TextLabel")
local sbs01 = Instance.new("UIStroke")
local Tabs = Instance.new("Frame")
local TabMain = Instance.new("TextButton")
local sbs2 = Instance.new("UIStroke")
local sbs3 = Instance.new("UIStroke")
local ToolsTab = Instance.new("TextButton")
local sbs4 = Instance.new("UIStroke")
local sbs5 = Instance.new("UIStroke")
local GlobalTab = Instance.new("TextButton")
local sbs6 = Instance.new("UIStroke")
local sbs7 = Instance.new("UIStroke")
local MiscTab = Instance.new("TextButton")
local sbs8_misc = Instance.new("UIStroke")
local sbs9_misc = Instance.new("UIStroke")
local KeybindsTab = Instance.new("TextButton")
local sbs8_keys = Instance.new("UIStroke")
local sbs9_keys = Instance.new("UIStroke")
local TabsFrame = Instance.new("Frame")
local sbs = Instance.new("UIStroke")
local Line = Instance.new("Frame")
local Main = Instance.new("Frame")
local Tools = Instance.new("Frame")
local Global = Instance.new("Frame")
local Misc = Instance.new("Frame")
local Keybinds = Instance.new("Frame")

GUI.Name = "GUI"
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
GUI.Parent = game.StarterGui

Container.BackgroundTransparency = 1
Container.Name = "Container"
Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
Container.Size = UDim2.new(0, 100, 0, 100)
Container.BorderSizePixel = 0
Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Container.Parent = GUI

MainFrame.Name = "Main"
MainFrame.BackgroundTransparency = 1
MainFrame.Position = UDim2.new(1.45, 0, 1.54, 0)
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.Size = UDim2.new(0, 432, 0, 289)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.Parent = Container

label.TextWrapped = true
label.TextColor3 = Color3.fromRGB(189, 189, 189)
label.BorderColor3 = Color3.fromRGB(0, 0, 0)
label.Text = "Made by Fear (Nezuurr) Version 2.1"
label.BorderSizePixel = 0
label.Size = UDim2.new(0, 431, 0, 30)
label.Name = "label"
label.TextXAlignment = Enum.TextXAlignment.Left
label.TextSize = 14
label.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
label.TextScaled = true
label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
label.Parent = MainFrame

sbs01.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
sbs01.Name = "sbs01"
sbs01.Parent = label

Tabs.Name = "Tabs"
Tabs.Position = UDim2.new(0, 0, 0.9135, 0)
Tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tabs.Size = UDim2.new(0, 431, 0, 25)
Tabs.BorderSizePixel = 0
Tabs.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Tabs.Parent = MainFrame

TabMain.FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TabMain.TextColor3 = Color3.fromRGB(255, 255, 255)
TabMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
TabMain.Text = "Main"
TabMain.Size = UDim2.new(0, 99, 0, 25)
TabMain.Name = "Main"
TabMain.BorderSizePixel = 0
TabMain.TextWrapped = true
TabMain.TextSize = 14
TabMain.TextScaled = true
TabMain.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
TabMain.Parent = Tabs

sbs2.Name = "sbs2"
sbs2.Parent = TabMain
sbs3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
sbs3.Name = "sbs3"
sbs3.Parent = TabMain

ToolsTab.FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
ToolsTab.TextColor3 = Color3.fromRGB(255, 255, 255)
ToolsTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
ToolsTab.Text = "Tools"
ToolsTab.BorderSizePixel = 0
ToolsTab.Size = UDim2.new(0, 83, 0, 25)
ToolsTab.Name = "Tools"
ToolsTab.Position = UDim2.new(0.2297, 0, 0, 0)
ToolsTab.TextWrapped = true
ToolsTab.TextSize = 14
ToolsTab.TextScaled = true
ToolsTab.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
ToolsTab.Parent = Tabs

sbs4.Name = "sbs4"
sbs4.Parent = ToolsTab
sbs5.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
sbs5.Name = "sbs5"
sbs5.Parent = ToolsTab

GlobalTab.FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
GlobalTab.TextColor3 = Color3.fromRGB(255, 255, 255)
GlobalTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
GlobalTab.Text = "Global"
GlobalTab.BorderSizePixel = 0
GlobalTab.Size = UDim2.new(0, 83, 0, 25)
GlobalTab.Name = "Global"
GlobalTab.Position = UDim2.new(0.4223, 0, 0, 0)
GlobalTab.TextWrapped = true
GlobalTab.TextSize = 14
GlobalTab.TextScaled = true
GlobalTab.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
GlobalTab.Parent = Tabs

sbs6.Name = "sbs6"
sbs6.Parent = GlobalTab
sbs7.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
sbs7.Name = "sbs7"
sbs7.Parent = GlobalTab

MiscTab.FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
MiscTab.TextColor3 = Color3.fromRGB(255, 255, 255)
MiscTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
MiscTab.Text = "Misc"
MiscTab.BorderSizePixel = 0
MiscTab.Size = UDim2.new(0, 83, 0, 25)
MiscTab.Name = "Misc"
MiscTab.Position = UDim2.new(0.6148, 0, 0, 0)
MiscTab.TextWrapped = true
MiscTab.TextSize = 14
MiscTab.TextScaled = true
MiscTab.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
MiscTab.Parent = Tabs

sbs8_misc.Name = "sbs8"
sbs8_misc.Parent = MiscTab
sbs9_misc.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
sbs9_misc.Name = "sbs9"
sbs9_misc.Parent = MiscTab

KeybindsTab.FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
KeybindsTab.TextColor3 = Color3.fromRGB(255, 255, 255)
KeybindsTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
KeybindsTab.Text = "Keybinds"
KeybindsTab.BorderSizePixel = 0
KeybindsTab.Size = UDim2.new(0, 83, 0, 25)
KeybindsTab.Name = "Keybinds"
KeybindsTab.Position = UDim2.new(0.8074, 0, 0, 0)
KeybindsTab.TextWrapped = true
KeybindsTab.TextSize = 14
KeybindsTab.TextScaled = true
KeybindsTab.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
KeybindsTab.Parent = Tabs

sbs8_keys.Name = "sbs8"
sbs8_keys.Parent = KeybindsTab
sbs9_keys.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
sbs9_keys.Name = "sbs9"
sbs9_keys.Parent = KeybindsTab

TabsFrame.Name = "TabsFrame"
TabsFrame.BackgroundTransparency = 0.2
TabsFrame.Position = UDim2.new(0, 0, 0.1038, 0)
TabsFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
TabsFrame.Size = UDim2.new(0, 431, 0, 234)
TabsFrame.BorderSizePixel = 0
TabsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TabsFrame.Parent = MainFrame

sbs.Name = "sbs"
sbs.Parent = TabsFrame

Line.Name = "Line"
Line.Position = UDim2.new(0, 0, -0.0085, 0)
Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
Line.Size = UDim2.new(0, 432, 0, 2)
Line.BorderSizePixel = 0
Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Line.Parent = TabsFrame

Main.Name = "Main"
Main.BackgroundTransparency = 0.2
Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
Main.Size = UDim2.new(0, 431, 0, 233)
Main.BorderSizePixel = 0
Main.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Main.Parent = TabsFrame

Tools.Name = "Tools"
Tools.Visible = false
Tools.BackgroundTransparency = 0.2
Tools.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tools.Size = UDim2.new(0, 431, 0, 233)
Tools.BorderSizePixel = 0
Tools.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Tools.Parent = TabsFrame

Global.Name = "Global"
Global.Visible = false
Global.BackgroundTransparency = 0.2
Global.BorderColor3 = Color3.fromRGB(0, 0, 0)
Global.Size = UDim2.new(0, 431, 0, 233)
Global.BorderSizePixel = 0
Global.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Global.Parent = TabsFrame

Misc.Name = "Misc"
Misc.Visible = false
Misc.BackgroundTransparency = 0.2
Misc.BorderColor3 = Color3.fromRGB(0, 0, 0)
Misc.Size = UDim2.new(0, 431, 0, 233)
Misc.BorderSizePixel = 0
Misc.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Misc.Parent = TabsFrame

Keybinds.Name = "Keybinds"
Keybinds.Visible = false
Keybinds.BackgroundTransparency = 0.2
Keybinds.BorderColor3 = Color3.fromRGB(0, 0, 0)
Keybinds.Size = UDim2.new(0, 431, 0, 233)
Keybinds.BorderSizePixel = 0
Keybinds.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Keybinds.Parent = TabsFrame

local tabMainButton = TabMain
local tabToolsButton = ToolsTab
local tabGlobalButton = GlobalTab
local tabMiscButton = MiscTab
local tabKeybindsButton = KeybindsTab

local mainFrame = Main
local toolsFrame = Tools
local globalFrame = Global
local miscFrame = Misc
local keybindsFrame = Keybinds

local function showTab(tab)
	mainFrame.Visible = tab == mainFrame
	toolsFrame.Visible = tab == toolsFrame
	globalFrame.Visible = tab == globalFrame
	miscFrame.Visible = tab == miscFrame
	keybindsFrame.Visible = tab == keybindsFrame
end

tabMainButton.MouseButton1Click:Connect(function()
	showTab(mainFrame)
end)

tabToolsButton.MouseButton1Click:Connect(function()
	showTab(toolsFrame)
end)

tabGlobalButton.MouseButton1Click:Connect(function()
	showTab(globalFrame)
end)

tabMiscButton.MouseButton1Click:Connect(function()
	showTab(miscFrame)
end)

tabKeybindsButton.MouseButton1Click:Connect(function()
	showTab(keybindsFrame)
end)
