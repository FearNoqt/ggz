local playr = game:GetService("Players")
local local_player = playr.LocalPlayer
local tween = game:GetService("TweenService")

local scrgu
local mainf
local tabbf
local tabcf
local activ_tab_name = nil
local tabs_data = {}

local fear = {}

local function _init()
    scrgu = Instance.new("ScreenGui")
    scrgu.Name = "Fear_UI_Lib"
    scrgu.ResetOnSpawn = false
    scrgu.DisplayOrder = 100
    scrgu.Parent = local_player:WaitForChild("PlayerGui")

    mainf = Instance.new("Frame")
    mainf.Name = "MainFrame"
    mainf.Size = UDim2.new(0, 550, 0, 700)
    mainf.Position = UDim2.new(0.5, -275, 0.5, -350)
    mainf.AnchorPoint = Vector2.new(0.5, 0.5)
    mainf.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    mainf.BackgroundTransparency = 0.05
    mainf.BorderSizePixel = 0
    mainf.CornerRadius = UDim.new(0, 20)
    mainf.Active = true
    mainf.Draggable = true
    mainf.Parent = scrgu

    tabbf = Instance.new("Frame")
    tabbf.Name = "TabBtns"
    tabbf.Size = UDim2.new(0.25, 0, 1, 0)
    tabbf.Position = UDim2.new(0, 0, 0, 0)
    tabbf.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
    tabbf.BackgroundTransparency = 0
    tabbf.BorderSizePixel = 0
    tabbf.CornerRadius = UDim.new(0, 20)
    tabbf.Parent = mainf

    local tabbt_layout = Instance.new("UIListLayout")
    tabbt_layout.FillDirection = Enum.FillDirection.Vertical
    tabbt_layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tabbt_layout.VerticalAlignment = Enum.VerticalAlignment.Top
    tabbt_layout.Padding = UDim.new(0, 8)
    tabbt_layout.Parent = tabbf

    tabcf = Instance.new("Frame")
    tabcf.Name = "TabCont"
    tabcf.Size = UDim2.new(0.75, 0, 1, 0)
    tabcf.Position = UDim2.new(0.25, 0, 0, 0)
    tabcf.BackgroundColor3 = Color3.new(0.12, 0.12, 0.12)
    tabcf.BackgroundTransparency = 0
    tabcf.BorderSizePixel = 0
    tabcf.CornerRadius = UDim.new(0, 20)
    tabcf.Parent = mainf
end

local function _swic(name)
    if activ_tab_name then
        local old_tab = tabs_data[activ_tab_name]
        if old_tab then
            old_tab.button.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
            old_tab.content.Visible = false
        end
    end

    local new_tab = tabs_data[name]
    if new_tab then
        new_tab.button.BackgroundColor3 = Color3.new(0.2, 0.4, 0.8)
        new_tab.content.Visible = true
        activ_tab_name = name
    end
end

function fear.addtb(name)
    if tabs_data[name] then
        warn("fear.addtb: Tab '" .. name .. "' already exists.")
        return nil
    end

    local tabtn = Instance.new("TextButton")
    tabtn.Name = name .. "_Btn"
    tabtn.Size = UDim2.new(0.9, 0, 0, 50)
    tabtn.Text = name
    tabtn.TextColor3 = Color3.new(1, 1, 1)
    tabtn.Font = Enum.Font.GothamBold
    tabtn.TextScaled = true
    tabtn.BackgroundTransparency = 0
    tabtn.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    tabtn.BorderSizePixel = 0
    tabtn.CornerRadius = UDim.new(0, 8)
    tabtn.Parent = tabbf

    tabtn.MouseButton1Click:Connect(function()
        _swic(name)
    end)

    local tabct = Instance.new("Frame")
    tabct.Name = name .. "_Cont"
    tabct.Size = UDim2.new(1, 0, 1, 0)
    tabct.Position = UDim2.new(0, 0, 0, 0)
    tabct.BackgroundTransparency = 1
    tabct.BorderSizePixel = 0
    tabct.Visible = false
    tabct.Parent = tabcf

    local contl = Instance.new("UIListLayout")
    contl.FillDirection = Enum.FillDirection.Vertical
    contl.HorizontalAlignment = Enum.HorizontalAlignment.Left
    contl.VerticalAlignment = Enum.VerticalAlignment.Top
    contl.Padding = UDim.new(0, 15)
    contl.Parent = tabct

    local contp = Instance.new("UIPadding")
    contp.PaddingLeft = UDim.new(0, 15)
    contp.PaddingRight = UDim.new(0, 15)
    contp.PaddingTop = UDim.new(0, 15)
    contp.PaddingBottom = UDim.new(0, 15)
    contp.Parent = tabct

    tabs_data[name] = {button = tabtn, content = tabct}

    if not activ_tab_name then
        _swic(name)
    end

    return {
        addbtn = function(props)
            if not props.text or type(props.click) ~= "function" then
                warn("fear.addtb.addbtn: Props need 'text' (string) and 'click' (function).")
                return nil
            end

            local new_btn = Instance.new("TextButton")
            new_btn.Name = props.text:gsub("%s+", "_") .. "_Btn"
            new_btn.Size = UDim2.new(1, -30, 0, 45)
            new_btn.Text = props.text
            new_btn.TextColor3 = Color3.new(1, 1, 1)
            new_btn.Font = Enum.Font.Gotham
            new_btn.TextScaled = true
            new_btn.BackgroundTransparency = 0
            new_btn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            new_btn.BorderSizePixel = 0
            new_btn.CornerRadius = UDim.new(0, 8)
            new_btn.Parent = tabct

            new_btn.MouseEnter:Connect(function()
                new_btn:TweenBackgroundColor3(Color3.new(0.3, 0.3, 0.3), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
            end)
            new_btn.MouseLeave:Connect(function()
                new_btn:TweenBackgroundColor3(Color3.new(0.2, 0.2, 0.2), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
            end)

            new_btn.MouseButton1Click:Connect(props.click)
            return new_btn
        end,

        addtog = function(props)
            if not props.text or type(props.click) ~= "function" or type(props.defau) ~= "boolean" then
                warn("fear.addtb.addtog: Props need 'text' (string), 'defau' (boolean), and 'click' (function).")
                return nil
            end

            local toggl_frame = Instance.new("Frame")
            toggl_frame.Name = props.text:gsub("%s+", "_") .. "_Togg"
            toggl_frame.Size = UDim2.new(1, -30, 0, 45)
            toggl_frame.BackgroundTransparency = 1
            toggl_frame.BorderSizePixel = 0
            toggl_frame.Parent = tabct

            local tog_text = Instance.new("TextLabel")
            tog_text.Name = "Text"
            tog_text.Size = UDim2.new(0.7, 0, 1, 0)
            tog_text.Text = props.text
            tog_text.TextColor3 = Color3.new(1, 1, 1)
            tog_text.Font = Enum.Font.Gotham
            tog_text.TextScaled = true
            tog_text.TextXAlignment = Enum.TextXAlignment.Left
            tog_text.BackgroundTransparency = 1
            tog_text.Parent = toggl_frame

            local tog_btn = Instance.new("TextButton")
            tog_btn.Name = "Toggle"
            tog_btn.Size = UDim2.new(0, 60, 0, 30)
            tog_btn.Position = UDim2.new(1, -60, 0.5, -15)
            tog_btn.AnchorPoint = Vector2.new(1, 0.5)
            tog_btn.BackgroundColor3 = props.defau and Color3.new(0.2, 0.8, 0.2) or Color3.new(0.8, 0.2, 0.2)
            tog_btn.BackgroundTransparency = 0
            tog_btn.BorderSizePixel = 0
            tog_btn.CornerRadius = UDim.new(0, 15)
            tog_btn.Parent = toggl_frame

            local tog_indi = Instance.new("Frame")
            tog_indi.Name = "Indicator"
            tog_indi.Size = UDim2.new(0, 20, 0, 20)
            tog_indi.BackgroundColor3 = Color3.new(1, 1, 1)
            tog_indi.BackgroundTransparency = 0
            tog_indi.BorderSizePixel = 0
            tog_indi.CornerRadius = UDim.new(0.5, 0)
            tog_indi.Parent = tog_btn

            local current_value = props.defau
            local function _updat_tog_indi()
                if current_value then
                    tog_btn:TweenBackgroundColor3(Color3.new(0.2, 0.8, 0.2), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
                    tog_indi:TweenPosition(UDim2.new(1, -25, 0.5, -10), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
                else
                    tog_btn:TweenBackgroundColor3(Color3.new(0.8, 0.2, 0.2), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
                    tog_indi:TweenPosition(UDim2.new(0, 5, 0.5, -10), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
                end
            end

            _updat_tog_indi()

            tog_btn.MouseButton1Click:Connect(function()
                current_value = not current_value
                _updat_tog_indi()
                props.click(current_value)
            end)

            return toggl_frame
        end,

        addsli = function(props)
            if not props.text or type(props.min) ~= "number" or type(props.max) ~= "number" or type(props.defau) ~= "number" or type(props.click) ~= "function" then
                warn("fear.addtb.addsli: Props need 'text' (string), 'min'/'max'/'defau' (numbers), and 'click' (function).")
                return nil
            end

            local sli_frame = Instance.new("Frame")
            sli_frame.Name = props.text:gsub("%s+", "_") .. "_Slid"
            sli_frame.Size = UDim2.new(1, -30, 0, 65)
            sli_frame.BackgroundTransparency = 1
            sli_frame.BorderSizePixel = 0
            sli_frame.Parent = tabct

            local sli_text = Instance.new("TextLabel")
            sli_text.Name = "Text"
            sli_text.Size = UDim2.new(1, 0, 0.4, 0)
            sli_text.Text = props.text .. ": " .. props.defau
            sli_text.TextColor3 = Color3.new(1, 1, 1)
            sli_text.Font = Enum.Font.Gotham
            sli_text.TextScaled = true
            sli_text.TextXAlignment = Enum.TextXAlignment.Left
            sli_text.BackgroundTransparency = 1
            sli_text.Parent = sli_frame

            local sli_bar_track = Instance.new("Frame")
            sli_bar_track.Name = "Track"
            sli_bar_track.Size = UDim2.new(1, 0, 0, 8)
            sli_bar_track.Position = UDim2.new(0, 0, 0.6, 0)
            sli_bar_track.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            sli_bar_track.BackgroundTransparency = 0
            sli_bar_track.BorderSizePixel = 0
            sli_bar_track.CornerRadius = UDim.new(0.5, 0)
            sli_bar_track.Parent = sli_frame

            local sli_bar_fill = Instance.new("Frame")
            sli_bar_fill.Name = "Fill"
            sli_bar_fill.Size = UDim2.new(0, 0, 1, 0)
            sli_bar_fill.BackgroundColor3 = Color3.new(0.2, 0.4, 0.8)
            sli_bar_fill.BackgroundTransparency = 0
            sli_bar_fill.BorderSizePixel = 0
            sli_bar_fill.CornerRadius = UDim.new(0.5, 0)
            sli_bar_fill.Parent = sli_bar_track

            local sli_handl = Instance.new("Frame")
            sli_handl.Name = "Handle"
            sli_handl.Size = UDim2.new(0, 16, 0, 16)
            sli_handl.Position = UDim2.new(0, -8, 0.5, -8)
            sli_handl.AnchorPoint = Vector2.new(0.5, 0.5)
            sli_handl.BackgroundColor3 = Color3.new(1, 1, 1)
            sli_handl.BackgroundTransparency = 0
            sli_handl.BorderSizePixel = 0
            sli_handl.CornerRadius = UDim.new(0.5, 0)
            sli_handl.Parent = sli_bar_track
            sli_handl.Active = true
            sli_handl.Draggable = true

            local is_drag = false
            local last_pos_x = 0
            local current_value = props.defau

            local function _updat_slid()
                local percent = (current_value - props.min) / (props.max - props.min)
                percent = math.clamp(percent, 0, 1)
                
                local x_pos = percent
                sli_handl:TweenPosition(UDim2.new(x_pos, -8, 0.5, -8), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.1, true)
                sli_bar_fill:TweenSize(UDim2.new(x_pos, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.1, true)
                sli_text.Text = props.text .. ": " .. math.floor(current_value * 100) / 100
            end

            _updat_slid()

            sli_handl.MouseButton1Down:Connect(function()
                is_drag = true
                last_pos_x = playr.LocalPlayer:GetMouse().X
            end)

            sli_bar_track.MouseButton1Down:Connect(function(x, y)
                local mouse_x = playr.LocalPlayer:GetMouse().X
                local relative_x = mouse_x - sli_bar_track.AbsolutePosition.X
                local percent = relative_x / sli_bar_track.AbsoluteSize.X
                current_value = props.min + (props.max - props.min) * percent
                _updat_slid()
                props.click(current_value)
            end)

            playr.LocalPlayer:GetMouse().MouseUp:Connect(function()
                if is_drag then
                    is_drag = false
                end
            end)

            playr.LocalPlayer:GetMouse().MouseMove:Connect(function()
                if is_drag then
                    local mouse_x = playr.LocalPlayer:GetMouse().X
                    local relative_x = mouse_x - sli_bar_track.AbsolutePosition.X
                    local percent = relative_x / sli_bar_track.AbsoluteSize.X
                    current_value = props.min + (props.max - props.min) * percent
                    _updat_slid()
                    props.click(current_value)
                end
            end)
            
            return sli_frame
        end,

        adddrp = function(props)
            if not props.text or type(props.optns) ~= "table" or type(props.click) ~= "function" then
                warn("fear.addtb.adddrp: Props need 'text' (string), 'optns' (table), and 'click' (function).")
                return nil
            end
            if #props.optns == 0 then
                warn("fear.addtb.adddrp: 'optns' table cannot be empty.")
                return nil
            end

            local drp_frame = Instance.new("Frame")
            drp_frame.Name = props.text:gsub("%s+", "_") .. "_Drop"
            drp_frame.Size = UDim2.new(1, -30, 0, 45)
            drp_frame.BackgroundTransparency = 1
            drp_frame.BorderSizePixel = 0
            drp_frame.Parent = tabct

            local drp_text_btn = Instance.new("TextButton")
            drp_text_btn.Name = "SelectBtn"
            drp_text_btn.Size = UDim2.new(1, 0, 1, 0)
            drp_text_btn.Text = props.text .. ": " .. (props.defau or props.optns[1])
            drp_text_btn.TextColor3 = Color3.new(1, 1, 1)
            drp_text_btn.Font = Enum.Font.Gotham
            drp_text_btn.TextScaled = true
            drp_text_btn.BackgroundTransparency = 0
            drp_text_btn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            drp_text_btn.BorderSizePixel = 0
            drp_text_btn.CornerRadius = UDim.new(0, 8)
            drp_text_btn.Parent = drp_frame

            local drp_arrow = Instance.new("ImageLabel")
            drp_arrow.Name = "Arrow"
            drp_arrow.Size = UDim2.new(0, 20, 0, 20)
            drp_arrow.Position = UDim2.new(1, -25, 0.5, -10)
            drp_arrow.AnchorPoint = Vector2.new(1, 0.5)
            drp_arrow.Image = "rbxassetid://4962299522"
            drp_arrow.BackgroundTransparency = 1
            drp_arrow.ImageColor3 = Color3.new(1,1,1)
            drp_arrow.Parent = drp_text_btn

            local opt_frame = Instance.new("Frame")
            opt_frame.Name = "Options"
            opt_frame.Size = UDim2.new(1, 0, 0, 0)
            opt_frame.Position = UDim2.new(0, 0, 1, 5)
            opt_frame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
            opt_frame.BackgroundTransparency = 0
            opt_frame.BorderSizePixel = 0
            opt_frame.CornerRadius = UDim.new(0, 8)
            opt_frame.Visible = false
            opt_frame.ClipsDescendants = true
            opt_frame.Parent = drp_frame

            local opt_layout = Instance.new("UIListLayout")
            opt_layout.FillDirection = Enum.FillDirection.Vertical
            opt_layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            opt_layout.VerticalAlignment = Enum.VerticalAlignment.Top
            opt_layout.Padding = UDim.new(0, 2)
            opt_layout.Parent = opt_frame

            local dropdown_open = false
            local current_value = props.defau or props.optns[1]

            local function _cloe_drp()
                dropdown_open = false
                opt_frame:TweenSize(UDim2.new(1, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
                drp_arrow:TweenRotation(0, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
            end

            local function _open_drp()
                dropdown_open = true
                local option_height = 35
                opt_frame:TweenSize(UDim2.new(1, 0, 0, #props.optns * (option_height + opt_layout.Padding.Offset) + 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
                drp_arrow:TweenRotation(180, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
            end

            for _, option_text in ipairs(props.optns) do
                local opt_btn = Instance.new("TextButton")
                opt_btn.Name = option_text:gsub("%s+", "_")
                opt_btn.Size = UDim2.new(1, 0, 0, 35)
                opt_btn.Text = option_text
                opt_btn.TextColor3 = Color3.new(1, 1, 1)
                opt_btn.Font = Enum.Font.Gotham
                opt_btn.TextScaled = true
                opt_btn.BackgroundTransparency = 0
                opt_btn.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
                opt_btn.BorderSizePixel = 0
                opt_btn.Parent = opt_frame

                opt_btn.MouseEnter:Connect(function()
                    opt_btn:TweenBackgroundColor3(Color3.new(0.25, 0.25, 0.25), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1)
                end)
                opt_btn.MouseLeave:Connect(function()
                    opt_btn:TweenBackgroundColor3(Color3.new(0.15, 0.15, 0.15), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1)
                end)

                opt_btn.MouseButton1Click:Connect(function()
                    current_value = option_text
                    drp_text_btn.Text = props.text .. ": " .. current_value
                    _cloe_drp()
                    props.click(current_value)
                end)
            end

            drp_text_btn.MouseButton1Click:Connect(function()
                if dropdown_open then
                    _cloe_drp()
                else
                    _open_drp()
                end
            end)

            return drp_frame
        end,
    }
end

_init()

_G.fear = fear

local home_tab = _G.fear.addtb("Home")
local settg = _G.fear.addtb("Settg")
local debug = _G.fear.addtb("Debug")

if home_tab then
    home_tab.addbtn({
        text = "Click Me",
        click = function()
            print("Home button clicked!")
        end
    })
    home_tab.addtog({
        text = "Feature Toggle",
        defau = true,
        click = function(val)
            print("Feature Toggle is now: " .. tostring(val))
        end
    })
    home_tab.addsli({
        text = "Volume",
        min = 0,
        max = 100,
        defau = 50,
        click = function(val)
            print("Volume set to: " .. math.floor(val))
        end
    })
    home_tab.adddrp({
        text = "Mode",
        optns = {"Normal", "Hard", "Easy"},
        defau = "Normal",
        click = function(val)
            print("Mode selected: " .. val)
        end
    })
end

if settg then
    settg.addbtn({
        text = "Save Config",
        click = function()
            print("Config saved!")
        end
    })
    settg.addtog({
        text = "Full Screen",
        defau = false,
        click = function(val)
            print("Full screen is: " .. tostring(val))
        end
    })
    settg.adddrp({
        text = "Theme",
        optns = {"Dark", "Light", "Blue"},
        defau = "Dark",
        click = function(val)
            print("Theme changed to: " .. val)
        end
    })
end

if debug then
    debug.addbtn({
        text = "Print Info",
        click = function()
            warn("Debug info here.")
        end
    })
    debug.addtog({
        text = "Show Debug Overlay",
        defau = false,
        click = function(val)
            print("Debug Overlay: " .. tostring(val))
        end
    })
    debug.addsli({
        text = "FPS Limit",
        min = 10,
        max = 240,
        defau = 60,
        click = function(val)
            print("FPS Limit: " .. math.floor(val))
        end
    })
end
