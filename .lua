local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local UI_FONT = Enum.Font.SourceSans
local UI_TEXT_COLOR = Color3.fromRGB(200, 200, 200)
local UI_ACCENT_COLOR = Color3.fromRGB(84, 101, 255)
local UI_BORDER_COLOR = Color3.fromRGB(50, 50, 50)
local UI_CORNER_RADIUS = UDim.new(0, 8)
local UI_STROKE_THICKNESS = 1
local UI_ELEMENT_HEIGHT = 36
local UI_PADDING_AMOUNT = 10

local themes = {
    main_window_bg = Color3.fromRGB(20, 20, 20),
    tab_container_bg = Color3.fromRGB(25, 25, 25),
    tab_button_inactive_bg = Color3.fromRGB(30, 30, 30),
    tab_button_active_bg = Color3.fromRGB(40, 40, 40),
    section_frame_bg = Color3.fromRGB(35, 35, 35),
    sector_frame_bg = Color3.fromRGB(45, 45, 45),
    element_frame_bg = Color3.fromRGB(50, 50, 50),
    button_bg = Color3.fromRGB(60, 60, 60),
    slider_track_bg = Color3.fromRGB(70, 70, 70),
    slider_fill_bg = UI_ACCENT_COLOR,
    toggle_bg = Color3.fromRGB(60, 60, 60),
    toggle_indicator_on_bg = UI_ACCENT_COLOR,
    toggle_indicator_off_bg = Color3.fromRGB(80, 80, 80),
    dropdown_button_bg = Color3.fromRGB(60, 60, 60),
    dropdown_options_bg = Color3.fromRGB(50, 50, 50),
    dropdown_option_selected_bg = UI_ACCENT_COLOR,
    combo_button_bg = Color3.fromRGB(60, 60, 60),
    combo_options_bg = Color3.fromRGB(50, 50, 50),
    combo_option_selected_bg = UI_ACCENT_COLOR,
    keybind_bg = Color3.fromRGB(60, 60, 60),
    label_bg = Color3.fromRGB(50,50,50)
}

local function createBaseFrame(parent: GuiObject, name: string, size: UDim2, position: UDim2?): Frame
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Size = size
    if position then frame.Position = position end
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    return frame
end

local function createTextLabel(parent: GuiObject, name: string, text: string, fontSize: Enum.FontSize, textColor: Color3, font: Enum.Font): TextLabel
    local label = Instance.new("TextLabel")
    label.Name = name
    label.Text = text
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = textColor
    label.TextScaled = false
    label.TextSize = fontSize.Value
    label.Font = font
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Parent = parent

    return label
end

local function createButton(parent: GuiObject, name: string, text: string, bgColor: Color3?): TextButton
    local button = Instance.new("TextButton")
    button.Name = name
    button.Text = text
    button.Size = UDim2.new(1, 0, 0, UI_ELEMENT_HEIGHT)
    button.BackgroundColor3 = bgColor or themes.button_bg
    button.BackgroundTransparency = 0
    button.TextColor3 = UI_TEXT_COLOR
    button.Font = UI_FONT
    button.TextScaled = true
    button.TextSize = 16
    button.TextWrap = true
    button.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UI_CORNER_RADIUS
    corner.Parent = button

    local stroke = Instance.new("UIStroke")
    stroke.Color = UI_BORDER_COLOR
    stroke.Thickness = UI_STROKE_THICKNESS
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = button

    return button
end

local function addListLayout(parent: GuiObject, padding: UDim?): UIListLayout
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    layout.VerticalAlignment = Enum.VerticalAlignment.Top
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    if padding then layout.Padding = padding end
    layout.Parent = parent
    return layout
end

local function addPadding(parent: GuiObject, padding: UDim): UIPadding
    local uiPadding = Instance.new("UIPadding")
    uiPadding.PaddingLeft = padding
    uiPadding.PaddingRight = padding
    uiPadding.PaddingTop = padding
    uiPadding.PaddingBottom = padding
    uiPadding.Parent = parent
    return uiPadding
end

local library = {}

local Window = {}
Window.__index = Window

function Window.new(windowName: string, windowId: string): Window
    local self = setmetatable({}, Window)

    self.windowName = windowName
    self.windowId = windowId
    self.tabs = {}
    self.activeTab = nil

    self.screenGui = Instance.new("ScreenGui")
    self.screenGui.Name = self.windowId
    self.screenGui.ResetOnSpawn = false
    self.screenGui.Parent = PlayerGui

    local uiScale = Instance.new("UIScale")
    uiScale.Scale = 0.8
    uiScale.Parent = self.screenGui

    self.mainFrame = createBaseFrame(self.screenGui, "MainWindow", UDim2.new(0, 600, 0, 400), UDim2.new(0.5, -300, 0.5, -200))
    self.mainFrame.BackgroundColor3 = themes.main_window_bg
    self.mainFrame.BackgroundTransparency = 0
    self.mainFrame.ClipsDescendants = true

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UI_CORNER_RADIUS
    corner.Parent = self.mainFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = UI_BORDER_COLOR
    stroke.Thickness = UI_STROKE_THICKNESS
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = self.mainFrame

    self.mainFrame.Draggable = true

    self.tabContainer = createBaseFrame(self.mainFrame, "TabContainer", UDim2.new(0, 60, 1, 0))
    self.tabContainer.BackgroundColor3 = themes.tab_container_bg
    self.tabContainer.BackgroundTransparency = 0

    local tabLayout = addListLayout(self.tabContainer, UDim.new(0, 5))
    tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tabLayout.Padding = UDim.new(0, 10)

    self.contentFrame = createBaseFrame(self.mainFrame, "ContentFrame", UDim2.new(1, -60, 1, 0), UDim2.new(0, 60, 0, 0))

    local contentLayout = addListLayout(self.contentFrame, UDim.new(0, UI_PADDING_AMOUNT))
    contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    contentLayout.Padding = UDim.new(0, UI_PADDING_AMOUNT)
    addPadding(self.contentFrame, UDim.new(0, UI_PADDING_AMOUNT))

    return self
end

function Window:new_tab(iconAssetId: string): Tab
    local newTab = Tab.new(self, iconAssetId)
    table.insert(self.tabs, newTab)

    if not self.activeTab then
        self:setActiveTab(newTab)
    end
    return newTab
end

function Window:setActiveTab(tab: Tab)
    if self.activeTab then
        self.activeTab.tabButton.BackgroundColor3 = themes.tab_button_inactive_bg
        self.activeTab.sectionsFrame.Visible = false
    end
    self.activeTab = tab
    self.activeTab.tabButton.BackgroundColor3 = themes.tab_button_active_bg
    self.activeTab.sectionsFrame.Visible = true

    for _, child in ipairs(self.contentFrame:GetChildren()) do
        if child:IsA("Frame") and child.Name == "SectionFrame" then
            child.Parent = nil
        end
    end
    tab.sectionsFrame.Parent = self.contentFrame
end

local Tab = {}
Tab.__index = Tab

function Tab.new(window: Window, iconAssetId: string): Tab
    local self = setmetatable({}, Tab)

    self.window = window
    self.iconAssetId = iconAssetId
    self.sections = {}

    self.tabButton = createButton(window.tabContainer, "TabButton", "", themes.tab_button_inactive_bg)
    self.tabButton.Size = UDim2.new(1, -20, 0, 40)
    self.tabButton.TextTransparency = 1

    local icon = Instance.new("ImageLabel")
    icon.Name = "TabIcon"
    icon.Image = iconAssetId
    icon.BackgroundTransparency = 1
    icon.Size = UDim2.new(0, 30, 0, 30)
    icon.Position = UDim2.new(0.5, -15, 0.5, -15)
    icon.Parent = self.tabButton

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UI_CORNER_RADIUS
    corner.Parent = self.tabButton

    local stroke = Instance.new("UIStroke")
    stroke.Color = UI_BORDER_COLOR
    stroke.Thickness = UI_STROKE_THICKNESS
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = self.tabButton

    self.tabButton.MouseButton1Click:Connect(function()
        self.window:setActiveTab(self)
    end)

    self.sectionsFrame = createBaseFrame(window.contentFrame, "SectionsFrame", UDim2.new(1, 0, 1, 0))
    self.sectionsFrame.Visible = false

    local sectionLayout = addListLayout(self.sectionsFrame, UDim.new(0, UI_PADDING_AMOUNT))
    sectionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    sectionLayout.Padding = UDim.new(0, UI_PADDING_AMOUNT)

    return self
end

function Tab:new_section(sectionName: string): Section
    local newSection = Section.new(self, sectionName)
    table.insert(self.sections, newSection)
    return newSection
end

local Section = {}
Section.__index = Section

function Section.new(tab: Tab, sectionName: string): Section
    local self = setmetatable({}, Section)

    self.tab = tab
    self.sectionName = sectionName
    self.sectors = {}

    self.sectionFrame = createBaseFrame(tab.sectionsFrame, "SectionFrame", UDim2.new(1, 0, 0, 0))
    self.sectionFrame.AutomaticSize = Enum.AutomaticSize.Y
    self.sectionFrame.BackgroundColor3 = themes.section_frame_bg
    self.sectionFrame.BackgroundTransparency = 0

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UI_CORNER_RADIUS
    corner.Parent = self.sectionFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = UI_BORDER_COLOR
    stroke.Thickness = UI_STROKE_THICKNESS
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = self.sectionFrame

    addPadding(self.sectionFrame, UDim.new(0, UI_PADDING_AMOUNT))

    local headerFrame = createBaseFrame(self.sectionFrame, "HeaderFrame", UDim2.new(1, 0, 0, 20))
    local headerText = createTextLabel(headerFrame, "HeaderText", sectionName, Enum.FontSize.Size14, UI_TEXT_COLOR, UI_FONT)
    headerText.TextXAlignment = Enum.TextXAlignment.Center
    headerText.TextSize = 14
    headerText.TextWrapped = true

    local separator = Instance.new("Frame")
    separator.Name = "Separator"
    separator.Size = UDim2.new(1, 0, 0, 1)
    separator.BackgroundColor3 = UI_BORDER_COLOR
    separator.BackgroundTransparency = 0
    separator.Parent = self.sectionFrame

    self.sectorsContainer = createBaseFrame(self.sectionFrame, "SectorsContainer", UDim2.new(1, 0, 0, 0))
    self.sectorsContainer.AutomaticSize = Enum.AutomaticSize.Y

    local sectorLayout = addListLayout(self.sectorsContainer, UDim.new(0, UI_PADDING_AMOUNT))
    sectorLayout.FillDirection = Enum.FillDirection.Horizontal
    sectorLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    sectorLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    sectorLayout.Wrap = true

    addPadding(self.sectorsContainer, UDim.new(0, UI_PADDING_AMOUNT))

    local sectionContentsLayout = addListLayout(self.sectionFrame, UDim.new(0, UI_PADDING_AMOUNT))
    sectionContentsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left

    return self
end

function Section:new_sector(sectorName: string, alignment: string): Sector
    local newSector = Sector.new(self, sectorName, alignment)
    table.insert(self.sectors, newSector)
    return newSector
end

local Sector = {}
Sector.__index = Sector

function Sector.new(section: Section, sectorName: string, alignment: string): Sector
    local self = setmetatable({}, Sector)

    self.section = section
    self.sectorName = sectorName
    self.alignment = alignment
    self.elements = {}

    self.sectorFrame = createBaseFrame(section.sectorsContainer, "SectorFrame", UDim2.new(0.5, -UI_PADDING_AMOUNT/2, 0, 0))
    self.sectorFrame.AutomaticSize = Enum.AutomaticSize.Y
    self.sectorFrame.BackgroundColor3 = themes.sector_frame_bg
    self.sectorFrame.BackgroundTransparency = 0

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UI_CORNER_RADIUS
    corner.Parent = self.sectorFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = UI_BORDER_COLOR
    stroke.Thickness = UI_STROKE_THICKNESS
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = self.sectorFrame

    addPadding(self.sectorFrame, UDim.new(0, UI_PADDING_AMOUNT))

    local sectorLayout = addListLayout(self.sectorFrame, UDim.new(0, 5))
    sectorLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left

    local headerFrame = createBaseFrame(self.sectorFrame, "SectorHeaderFrame", UDim2.new(1, 0, 0, 20))
    local headerText = createTextLabel(headerFrame, "SectorHeaderText", sectorName, Enum.FontSize.Size14, UI_TEXT_COLOR, UI_FONT)
    headerText.TextXAlignment = Enum.TextXAlignment.Center
    headerText.TextSize = 14
    headerText.TextWrapped = true

    if alignment == 'Left' then
        self.sectorFrame.LayoutOrder = 1
    elseif alignment == 'Right' then
        self.sectorFrame.LayoutOrder = 2
    else
        self.sectorFrame.Size = UDim2.new(1, 0, 0, 0)
    end

    return self
end

function Sector:element(elementType: string, elementName: string, initialState: any, callback: (v: {[string]: any}) -> ()): any
    local newElement = nil
    local elementFrame = createBaseFrame(self.sectorFrame, elementName .. "ElementFrame", UDim2.new(1, 0, 0, UI_ELEMENT_HEIGHT))
    elementFrame.BackgroundColor3 = themes.element_frame_bg
    elementFrame.BackgroundTransparency = 0

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UI_CORNER_RADIUS
    corner.Parent = elementFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = UI_BORDER_COLOR
    stroke.Thickness = UI_STROKE_THICKNESS
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = elementFrame

    local elementLabel = createTextLabel(elementFrame, "ElementNameLabel", elementName, Enum.FontSize.Size14, UI_TEXT_COLOR, UI_FONT)
    elementLabel.Size = UDim2.new(0.5, 0, 1, 0)
    addPadding(elementLabel, UDim.new(0, 5))

    if elementType == 'Button' then
        newElement = ButtonElement.new(elementFrame, elementName, callback)
    elseif elementType == 'Toggle' then
        newElement = ToggleElement.new(elementFrame, elementName, initialState, callback)
    elseif elementType == 'Dropdown' then
        newElement = DropdownElement.new(elementFrame, elementName, initialState, callback)
    elseif elementType == 'Slider' then
        newElement = SliderElement.new(elementFrame, elementName, initialState, callback)
    elseif elementType == 'Combo' then
        newElement = ComboElement.new(elementFrame, elementName, initialState, callback)
    else
        warn("Unknown element type:", elementType)
        elementFrame:Destroy()
        return nil
    end

    if newElement then
        table.insert(self.elements, newElement)
    end

    return newElement
end

local Element = {}
Element.__index = Element

function Element.new(elementFrame: Frame, name: string, callback: (v: {[string]: any}) -> ()): Element
    local self = setmetatable({}, Element)
    self.frame = elementFrame
    self.name = name
    self.callback = callback
    return self
end

function Element:updateCallback(value: any)
    if self.callback then
        self.callback({[self.name] = value})
    end
end

local ButtonElement = {}
ButtonElement.__index = ButtonElement
setmetatable(ButtonElement, Element)

function ButtonElement.new(elementFrame: Frame, name: string, callback: (v: {[string]: any}) -> ()): ButtonElement
    local self = setmetatable(Element.new(elementFrame, name, callback), ButtonElement)

    local button = createButton(elementFrame, name .. "Button", name, themes.button_bg)
    button.Size = UDim2.new(1, 0, 1, 0)
    button.TextXAlignment = Enum.TextXAlignment.Center

    button.MouseButton1Click:Connect(function()
        self:updateCallback(true)
    end)
    return self
end

local ToggleElement = {}
ToggleElement.__index = ToggleElement
setmetatable(ToggleElement, Element)

function ToggleElement.new(elementFrame: Frame, name: string, initialState: boolean, callback: (v: {[string]: any}) -> ()): ToggleElement
    local self = setmetatable(Element.new(elementFrame, name, callback), ToggleElement)

    self.state = initialState or false
    self.toggleColor = UI_ACCENT_COLOR

    local toggleButton = createButton(elementFrame, name .. "ToggleButton", "", themes.toggle_bg)
    toggleButton.Size = UDim2.new(0, 40, 1, 0)
    toggleButton.Position = UDim2.new(1, -40, 0, 0)
    toggleButton.TextTransparency = 1

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UI_CORNER_RADIUS
    toggleCorner.Parent = toggleButton

    local indicator = Instance.new("Frame")
    indicator.Name = "Indicator"
    indicator.Size = UDim2.new(0, 20, 0, 20)
    indicator.Position = UDim2.new(0.5, -10, 0.5, -10)
    indicator.BackgroundColor3 = self.toggleColor
    indicator.BackgroundTransparency = 0
    indicator.Parent = toggleButton

    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(0.5, 0)
    indicatorCorner.Parent = indicator

    self.toggleButton = toggleButton
    self.indicator = indicator

    local function updateToggleVisual()
        self.indicator.BackgroundColor3 = self.state and self.toggleColor or themes.toggle_indicator_off_bg
    end

    toggleButton.MouseButton1Click:Connect(function()
        self.state = not self.state
        updateToggleVisual()
        self:updateCallback(self.state)
    end)

    updateToggleVisual()

    return self
end

function ToggleElement:add_color(options: {Color: Color3}, name: string?, callback: (v: {[string]: any}) -> ())
    local color = options.Color or UI_ACCENT_COLOR
    self.toggleColor = color
    self.indicator.BackgroundColor3 = self.state and self.toggleColor or themes.toggle_indicator_off_bg
    if callback then
        callback({Color = color})
    end
end

local DropdownElement = {}
DropdownElement.__index = DropdownElement
setmetatable(DropdownElement, Element)

function DropdownElement.new(elementFrame: Frame, name: string, initialState: {options: {string}}, callback: (v: {[string]: any}) -> ()): DropdownElement
    local self = setmetatable(Element.new(elementFrame, name, callback), DropdownElement)

    self.options = initialState.options or {}
    self.selectedIndex = 1
    self.selectedOption = self.options[self.selectedIndex] or "None"
    self.isOpen = false

    local dropdownButton = createButton(elementFrame, name .. "DropdownButton", self.selectedOption, themes.dropdown_button_bg)
    dropdownButton.Size = UDim2.new(0.5, 0, 1, 0)
    dropdownButton.Position = UDim2.new(0.5, 0, 0, 0)
    dropdownButton.TextXAlignment = Enum.TextXAlignment.Right
    dropdownButton.TextSize = 14
    addPadding(dropdownButton, UDim.new(0, 5))

    self.dropdownButton = dropdownButton

    self.optionsFrame = createBaseFrame(elementFrame.Parent.Parent.Parent.Parent, name .. "OptionsFrame", UDim2.new(0, elementFrame.AbsoluteSize.X / elementFrame.AbsoluteSize.X * elementFrame.Size.X.Scale, 0, 0))
    self.optionsFrame.AutomaticSize = Enum.AutomaticSize.Y
    self.optionsFrame.BackgroundColor3 = themes.dropdown_options_bg
    self.optionsFrame.BackgroundTransparency = 0
    self.optionsFrame.Visible = false
    self.optionsFrame.ZIndex = 10

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UI_CORNER_RADIUS
    corner.Parent = self.optionsFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = UI_BORDER_COLOR
    stroke.Thickness = UI_STROKE_THICKNESS
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = self.optionsFrame

    local optionsLayout = addListLayout(self.optionsFrame, UDim.new(0, 2))
    optionsLayout.Padding = UDim.new(0, 2)

    local function updateDropdownPosition()
        local absPos = elementFrame.AbsolutePosition
        local absSize = elementFrame.AbsoluteSize
        self.optionsFrame.Position = UDim2.new(0, absPos.X + elementFrame.Size.X.Offset, 0, absPos.Y + absSize.Y)
    end

    local function populateOptions()
        for _, child in ipairs(self.optionsFrame:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end

        for i, optionText in ipairs(self.options) do
            local optionButton = createButton(self.optionsFrame, "Option" .. i, optionText, themes.dropdown_options_bg)
            optionButton.Size = UDim2.new(1, 0, 0, UI_ELEMENT_HEIGHT)
            optionButton.TextXAlignment = Enum.TextXAlignment.Left
            optionButton.TextSize = 14
            addPadding(optionButton, UDim.new(0, 5))
            if i == self.selectedIndex then
                optionButton.BackgroundColor3 = themes.dropdown_option_selected_bg
            end

            optionButton.MouseButton1Click:Connect(function()
                self.selectedIndex = i
                self.selectedOption = optionText
                self.dropdownButton.Text = self.selectedOption
                self.isOpen = false
                self.optionsFrame.Visible = false
                self:updateCallback(self.selectedOption)
                populateOptions()
            end)
        end
    end

    dropdownButton.MouseButton1Click:Connect(function()
        self.isOpen = not self.isOpen
        self.optionsFrame.Visible = self.isOpen
        if self.isOpen then
            populateOptions()
            updateDropdownPosition()
        end
    end)

    game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and self.isOpen and input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mousePos = input.Position
            local buttonAbsPos = dropdownButton.AbsolutePosition
            local buttonAbsSize = dropdownButton.AbsoluteSize
            local optionsAbsPos = self.optionsFrame.AbsolutePosition
            local optionsAbsSize = self.optionsFrame.AbsoluteSize

            local inButton = mousePos.X >= buttonAbsPos.X and mousePos.X <= buttonAbsPos.X + buttonAbsSize.X and
                             mousePos.Y >= buttonAbsPos.Y and mousePos.Y <= buttonAbsPos.Y + buttonAbsSize.Y

            local inOptions = mousePos.X >= optionsAbsPos.X and mousePos.X <= optionsAbsPos.X + optionsAbsSize.X and
                              mousePos.Y >= optionsAbsPos.Y and mousePos.Y <= optionsAbsPos.Y + optionsAbsSize.Y

            if not inButton and not inOptions then
                self.isOpen = false
                self.optionsFrame.Visible = false
            end
        end
    end)

    elementFrame.AbsolutePosition.Changed:Connect(updateDropdownPosition)
    elementFrame.AbsoluteSize.Changed:Connect(updateDropdownPosition)

    return self
end

local SliderElement = {}
SliderElement.__index = SliderElement
setmetatable(SliderElement, Element)

function SliderElement.new(elementFrame: Frame, name: string, initialState: {default: {min: number, max: number, default: number}}, callback: (v: {[string]: any}) -> ()): SliderElement
    local self = setmetatable(Element.new(elementFrame, name, callback), SliderElement)

    self.min = initialState.default.min or 0
    self.max = initialState.default.max or 100
    self.value = initialState.default.default or self.min

    local sliderFrame = createBaseFrame(elementFrame, name .. "SliderFrame", UDim2.new(0.5, 0, 1, 0), UDim2.new(0.5, 0, 0, 0))
    sliderFrame.BackgroundColor3 = themes.slider_track_bg
    sliderFrame.BackgroundTransparency = 0

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.5, 0)
    corner.Parent = sliderFrame

    local fill = Instance.new("Frame")
    fill.Name = "SliderFill"
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = themes.slider_fill_bg
    fill.BackgroundTransparency = 0
    fill.Parent = sliderFrame

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0.5, 0)
    fillCorner.Parent = fill

    local handle = Instance.new("ImageLabel")
    handle.Name = "SliderHandle"
    handle.Image = "rbxassetid://600373076"
    handle.BackgroundTransparency = 1
    handle.Size = UDim2.new(0, 20, 0, 20)
    handle.ZIndex = 2
    handle.Parent = sliderFrame

    local handleCorner = Instance.new("UICorner")
    handleCorner.CornerRadius = UDim.new(0.5, 0)
    handleCorner.Parent = handle

    local valueLabel = createTextLabel(elementFrame, "ValueLabel", tostring(self.value), Enum.FontSize.Size14, UI_TEXT_COLOR, UI_FONT)
    valueLabel.Size = UDim2.new(0.25, 0, 1, 0)
    valueLabel.Position = UDim2.new(0.75, 0, 0, 0)
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    addPadding(valueLabel, UDim.new(0, 5))

    self.sliderFrame = sliderFrame
    self.fill = fill
    self.handle = handle
    self.valueLabel = valueLabel

    local isDragging = false
    local function updateSlider(input: InputObject)
        local mouseX = input.Position.X
        local sliderAbsPos = self.sliderFrame.AbsolutePosition
        local sliderAbsSize = self.sliderFrame.AbsoluteSize

        local normalizedX = math.clamp((mouseX - sliderAbsPos.X) / sliderAbsSize.X, 0, 1)
        self.value = self.min + (self.max - self.min) * normalizedX
        self.value = math.round(self.value * 100) / 100

        self.fill.Size = UDim2.new(normalizedX, 0, 1, 0)
        self.handle.Position = UDim2.new(normalizedX, -self.handle.Size.X.Offset / 2, 0.5, -self.handle.Size.Y.Offset / 2)
        self.valueLabel.Text = tostring(self.value)

        self:updateCallback(self.value)
    end

    sliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            updateSlider(input)
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)

    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)

    local normalizedInitial = (self.value - self.min) / (self.max - self.min)
    self.fill.Size = UDim2.new(normalizedInitial, 0, 1, 0)
    self.handle.Position = UDim2.new(normalizedInitial, -self.handle.Size.X.Offset / 2, 0.5, -self.handle.Size.Y.Offset / 2)
    self.valueLabel.Text = tostring(self.value)

    return self
end

local ComboElement = {}
ComboElement.__index = ComboElement
setmetatable(ComboElement, Element)

function ComboElement.new(elementFrame: Frame, name: string, initialState: {options: {string}}, callback: (v: {[string]: any}) -> ()): ComboElement
    local self = setmetatable(Element.new(elementFrame, name, callback), ComboElement)

    self.options = initialState.options or {}
    self.selectedOptions = {}
    self.isOpen = false

    local comboButton = createButton(elementFrame, name .. "ComboButton", "Select Options...", themes.combo_button_bg)
    comboButton.Size = UDim2.new(0.5, 0, 1, 0)
    comboButton.Position = UDim2.new(0.5, 0, 0, 0)
    comboButton.TextXAlignment = Enum.TextXAlignment.Right
    comboButton.TextSize = 14
    addPadding(comboButton, UDim.new(0, 5))

    self.comboButton = comboButton

    self.optionsFrame = createBaseFrame(elementFrame.Parent.Parent.Parent.Parent, name .. "ComboOptionsFrame", UDim2.new(0, elementFrame.AbsoluteSize.X / elementFrame.AbsoluteSize.X * elementFrame.Size.X.Scale, 0, 0))
    self.optionsFrame.AutomaticSize = Enum.AutomaticSize.Y
    self.optionsFrame.BackgroundColor3 = themes.combo_options_bg
    self.optionsFrame.BackgroundTransparency = 0
    self.optionsFrame.Visible = false
    self.optionsFrame.ZIndex = 10

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UI_CORNER_RADIUS
    corner.Parent = self.optionsFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = UI_BORDER_COLOR
    stroke.Thickness = UI_STROKE_THICKNESS
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = self.optionsFrame

    local optionsLayout = addListLayout(self.optionsFrame, UDim.new(0, 2))
    optionsLayout.Padding = UDim.new(0, 2)

    local function updateComboPosition()
        local absPos = elementFrame.AbsolutePosition
        local absSize = elementFrame.AbsoluteSize
        self.optionsFrame.Position = UDim2.new(0, absPos.X + elementFrame.Size.X.Offset, 0, absPos.Y + absSize.Y)
    end

    local function updateComboText()
        if #self.selectedOptions == 0 then
            self.comboButton.Text = "Select Options..."
        else
            self.comboButton.Text = table.concat(self.selectedOptions, ", ")
        end
    end

    local function populateOptions()
        for _, child in ipairs(self.optionsFrame:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end

        for i, optionText in ipairs(self.options) do
            local optionButton = createButton(self.optionsFrame, "Option" .. i, optionText, themes.combo_options_bg)
            optionButton.Size = UDim2.new(1, 0, 0, UI_ELEMENT_HEIGHT)
            optionButton.TextXAlignment = Enum.TextXAlignment.Left
            optionButton.TextSize = 14
            addPadding(optionButton, UDim.new(0, 5))

            local isSelected = false
            for idx, selected in ipairs(self.selectedOptions) do
                if selected == optionText then
                    isSelected = true
                    break
                end
            end

            if isSelected then
                optionButton.BackgroundColor3 = themes.combo_option_selected_bg
            end

            optionButton.MouseButton1Click:Connect(function()
                local found = false
                for idx, selected in ipairs(self.selectedOptions) do
                    if selected == optionText then
                        table.remove(self.selectedOptions, idx)
                        found = true
                        break
                    end
                end
                if not found then
                    table.insert(self.selectedOptions, optionText)
                end
                updateComboText()
                populateOptions()
                self:updateCallback(self.selectedOptions)
            end)
        end
    end

    comboButton.MouseButton1Click:Connect(function()
        self.isOpen = not self.isOpen
        self.optionsFrame.Visible = self.isOpen
        if self.isOpen then
            populateOptions()
            updateComboPosition()
        end
    end)

    game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and self.isOpen and input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mousePos = input.Position
            local buttonAbsPos = comboButton.AbsolutePosition
            local buttonAbsSize = comboButton.AbsoluteSize
            local optionsAbsPos = self.optionsFrame.AbsolutePosition
            local optionsAbsSize = self.optionsFrame.AbsoluteSize

            local inButton = mousePos.X >= buttonAbsPos.X and mousePos.X <= buttonAbsPos.X + buttonAbsSize.X and
                             mousePos.Y >= buttonAbsPos.Y and mousePos.Y <= buttonAbsPos.Y + buttonAbsSize.Y

            local inOptions = mousePos.X >= optionsAbsPos.X and mousePos.X <= optionsAbsPos.X + optionsAbsSize.X and
                              mousePos.Y >= optionsAbsPos.Y and mousePos.Y <= optionsAbsPos.Y + optionsAbsSize.Y

            if not inButton and not inOptions then
                self.isOpen = false
                self.optionsFrame.Visible = false
            end
        end
    end)

    elementFrame.AbsolutePosition.Changed:Connect(updateComboPosition)
    elementFrame.AbsoluteSize.Changed:Connect(updateComboPosition)

    updateComboText()

    return self
end

function library.new(windowName: string, windowId: string): Window
    return Window.new(windowName, windowId)
end

return library

local myWindow = library.new('My Awesome UI', 'MyGameUI')

local mainTab = myWindow.new_tab('rbxassetid://4483345998')
local settingsTab = myWindow.new_tab('rbxassetid://6034177579')

local gameplaySection = mainTab.new_section('Gameplay Controls')
local characterSection = mainTab.new_section('Character Options')

local audioSection = settingsTab.new_section('Audio Settings')
local displaySection = settingsTab.new_section('Display Preferences')

local leftControls = gameplaySection.new_sector('Movement', 'Left')
local rightControls = gameplaySection.new_sector('Actions', 'Right')

local jumpButton = leftControls.element('Button', 'Jump!', nil, function()
    print("Jump button clicked!")
end)

local runToggle = leftControls.element('Toggle', 'Toggle Run', false, function(value)
    print("Run Toggled:", value.ToggleRun)
end)
runToggle:add_color({Color = Color3.fromRGB(0, 150, 255)}, nil, function(colorInfo)
    print("Run toggle color changed to:", colorInfo.Color)
end)

local difficultyDropdown = rightControls.element('Dropdown', 'Difficulty', {options = {'Easy', 'Normal', 'Hard', 'Expert'}}, function(value)
    print("Difficulty selected:", value.Difficulty)
end)

local musicVolumeSlider = audioSection.new_sector('Volume Sliders', 'Left').element('Slider', 'Music Volume', {default = {min = 0, max = 1, default = 0.7}}, function(value)
    print("Music Volume:", value.MusicVolume)
end)

local sfxVolumeSlider = audioSection.new_sector('Volume Sliders', 'Right').element('Slider', 'SFX Volume', {default = {min = 0, max = 1, default = 0.8}}, function(value)
    print("SFX Volume:", value.SFXVolume)
end)

local specialAbilities = characterSection.new_sector('Abilities', 'Left').element('Combo', 'Special Abilities', {options = {'Flight', 'Invisibility', 'Super Strength', 'Teleportation'}}, function(value)
    print("Selected Abilities:")
    for _, ability in ipairs(value.SpecialAbilities) do
        print("- " .. ability)
    end
end)

