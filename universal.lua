-- =======================================================================
-- CROWS HUB (CWH) ver 8.3 - PC ELITE VISUALS (FULLY FIXED)
-- =======================================================================

local Fluent = loadstring(game:HttpGet("https://github.com"))()

local WS, JP, FV = 16, 50, 70
local wsOn, jpOn, infJ, noclip, flg, fk, bp, hs, anti = false, false, false, false, false, false, false, false, false
local espOn, chamsOn = false, false

local Window = Fluent:CreateWindow({
    Title = "Crows Hub | PC Premium",
    SubTitle = "by crowshubdev | version 8.3",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 430),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightShift
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main Mods", Icon = "user" }),
    Bypass = Window:AddTab({ Title = "Bypass & Visuals", Icon = "eye" }),
    Troll = Window:AddTab({ Title = "HvH Troll", Icon = "swords" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- =======================================================================
-- ВКЛАДКА 1: MAIN MODS
-- =======================================================================
Tabs.Main:AddSection("Movement Customization")

Tabs.Main:AddToggle("SpeedToggle", {
    Title = "Toggle WalkSpeed (Включить Скорость)",
    Default = false,
    Callback = function(Value) wsOn = Value end
})

Tabs.Main:AddSlider("SpeedSlider", {
    Title = "WalkSpeed Value",
    Min = 16, Max = 250, Default = 16, Rounding = 0,
    Callback = function(Value) WS = Value end
})

Tabs.Main:AddToggle("JumpToggle", {
    Title = "Toggle JumpPower (Включить Прыжок)",
    Default = false,
    Callback = function(Value) jpOn = Value end
})

Tabs.Main:AddSlider("JumpSlider", {
    Title = "JumpPower Value",
    Min = 50, Max = 300, Default = 50, Rounding = 0,
    Callback = function(Value) JP = Value end
})

-- =======================================================================
-- ВКЛАДКА 2: BYPASS & VISUALS (Твои новые Чамсы и ЕСП)
-- =======================================================================
Tabs.Bypass:AddSection("Visual Exploits (ESP)")

Tabs.Bypass:AddToggle("EspNames", {
    Title = "ESP Name Players (Имена сквозь стены)",
    Default = false,
    Callback = function(Value) espOn = Value end
})

Tabs.Bypass:AddToggle("ChamsPlayers", {
    Title = "Chams Players (Подсветка силуэтов)",
    Default = false,
    Callback = function(Value) chamsOn = Value end
})

Tabs.Bypass:AddSection("Bypass Features")

Tabs.Bypass:AddToggle("InfJumpToggle", {
    Title = "Infinite Jump (Бесконечный Прыжок)",
    Default = false,
    Callback = function(Value) infJ = Value end
})

Tabs.Bypass:AddToggle("NoclipToggle", {
    Title = "Noclip (Сквозь стены)",
    Default = false,
    Callback = function(Value) noclip = Value end
})

Tabs.Bypass:AddSection("Camera Modifications")

Tabs.Bypass:AddSlider("FOVSlider", {
    Title = "Field Of View (FOV)",
    Min = 30, Max = 120, Default = 70, Rounding = 0,
    Callback = function(Value) FV = Value workspace.CurrentCamera.FieldOfView = FV end
})

-- =======================================================================
-- ВКЛАДКА 3: HVH TROLL & SAFETY
-- =======================================================================
Tabs.Troll:AddSection("Troll Exploits")

Tabs.Troll:AddToggle("FlingToggle", {
    Title = "Fling Kill (Юла)",
    Default = false,
    Callback = function(Value) fk = Value end
})

Tabs.Troll:AddToggle("BringToggle", {
    Title = "Bring Parts (Магнит предметов)",
    Default = false,
    Callback = function(Value) bp = Value end
})

Tabs.Troll:AddToggle("HeadSpinToggle", {
    Title = "Head Spin (HvH Крутилка головы)",
    Default = false,
    Callback = function(Value) hs = Value end
})

Tabs.Troll:AddSection("Safety Systems")

Tabs.Troll:AddToggle("AntiFlingToggle", {
    Title = "Anti-Fling (Защита от юлы)",
    Default = false,
    Callback = function(Value) flg = Value end
})

Tabs.Troll:AddToggle("AntiAFKToggle", {
    Title = "Anti-AFK (Анти-кик сервер)",
    Default = false,
    Callback = function(Value) anti = Value end
})

-- =======================================================================
-- ВКЛАДКА 4: SETTINGS (Исправленные бинды и темы)
-- =======================================================================
Tabs.Settings:AddSection("Menu Customization")

Tabs.Settings:AddKeybind("MenuKeybind", {
    Title = "Кнопка скрытия меню ГУИ",
    Mode = "Toggle",
    Default = Enum.KeyCode.RightShift,
    Callback = function(Key)
        Window:ChangeMinimizeKey(Key)
    end
})

local currentThemeNum = 1
local themeList = {"Dark", "Light", "Amethyst", "Aqua"}
Tabs.Settings:AddButton({
    Title = "Сменить тему UI (Клик)",
    Description = "Цикличное переключение скинов оформления",
    Callback = function()
        currentThemeNum = currentThemeNum + 1
        if currentThemeNum > #themeList then currentThemeNum = 1 end
        local chosenTheme = themeList[currentThemeNum]
        Window:SetTheme(chosenTheme)
    end
})

Tabs.Settings:AddSection("Utilities")

Tabs.Settings:AddButton({
    Title = "Instant Reset (Суицид)",
    Description = "Мгновенный перезапуск персонажа",
    Callback = function()
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.Health = 0
        end
    end
})

-- =======================================================================
-- СЕРВЕРНАЯ ФИЗИКА И МОЩНЫЕ ПК-ВИЗУАЛЫ
-- =======================================================================
local P = game.Players.LocalPlayer

-- Функция для отрисовки 2D ESP имен и Chams подсветки силуэтов
local function applyVisuals(plr)
    if plr == P then return end
    
    local function createVisuals(char)
        local head = char:WaitForChild("Head", 5)
        local hrp = char:WaitForChild("HumanoidRootPart", 5)
        if not head or not hrp then return end
        
        -- Создание 2D ESP текста над головой
        if not head:FindFirstChild("CWH_NameESP") then
            local bb = Instance.new("BillboardGui")
            bb.Name = "CWH_NameESP"
            bb.Size = UDim2.new(0, 100, 0, 30)
            bb.AlwaysOnTop = true
            bb.ExtentsOffset = Vector3.new(0, 3, 0)
            
            local tl = Instance.new("TextLabel")
            tl.Size = UDim2.new(1, 0, 1, 0)
            tl.BackgroundTransparency = 1
            tl.Text = plr.Name
            tl.TextColor3 = Color3.fromRGB(255, 255, 255)
            tl.Font = Enum.Font.SourceSansBold
            tl.TextSize = 14
            tl.TextStrokeTransparency = 0
            tl.Parent = bb
            bb.Parent = head
        end
        
        -- Создание неоновой подсветки силуэта (Chams)
        if not char:FindFirstChild("CWH_Chams") then
            local highlight = Instance.new("Highlight")
            highlight.Name = "CWH_Chams"
            highlight.FillColor = Color3.fromRGB(0, 120, 255)
            highlight.FillTransparency = 0.5
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.OutlineTransparency = 0
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = char
        end
    end
    
    plr.CharacterAdded:Connect(createVisuals)
    if plr.Character then createVisuals(plr.Character) end
end

-- Мониторинг игроков для ESP
for _, player in pairs(game.Players:GetPlayers()) do applyVisuals(player) end
game.Players.PlayerAdded:Connect(applyVisuals)

-- Постоянный цикл обновления видимости визуалов и физики персонажа
game:GetService("RunService").Stepped:Connect(function()
    pcall(function()
        -- Контроль ESP и Chams на ходу
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character then
                local char = player.Character
                local esp = char:FindFirstChild("Head") and char.Head:FindFirstChild("CWH_NameESP")
                local chams = char:FindFirstChild("CWH_Chams")
                
                if esp then esp.Enabled = espOn end
                if chams then chams.Enabled = chamsOn end
            end
        end
        
        -- Базовая физика
        if P.Character and P.Character:FindFirstChildOfClass("Humanoid") then
            local h = P.Character:FindFirstChildOfClass("Humanoid")
            if wsOn then h.WalkSpeed = WS else h.WalkSpeed = 16 end
            if jpOn then h.UseJumpPower = true h.JumpPower = JP end
            if noclip then 
                for _,v in pairs(P.Character:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end 
            end
        end
        if flg and P.Character and P.Character:FindFirstChild("HumanoidRootPart") then P.Character.HumanoidRootPart.RotVelocity = Vector3.new(0,0,0) end
    end)
end)

game:GetService("RunService").RenderStepped:Connect(function()
    pcall(function()
        if fk and P.Character and P.Character:FindFirstChild("HumanoidRootPart") then P.Character.Humanoid.PlatformStand = true P.Character.HumanoidRootPart.RotVelocity = Vector3.new(0,500,0) end
        if bp then for _,v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") and not v.Anchored and P.Character and P.Character:FindFirstChild("HumanoidRootPart") then if (v.Position-P.Character.HumanoidRootPart.Position).Magnitude<50 then v.CFrame=P.Character.HumanoidRootPart.CFrame end end end end
        if hs and P.Character and P.Character:FindFirstChild("Head") then P.Character.Head.CFrame = P.Character.Head.CFrame * CFrame.Angles(0, math.rad(25), 0) end
    end)
end)

game:GetService("UserInputService").JumpRequest:Connect(function() 
    if infJ and P.Character and P.Character:FindFirstChildOfClass("Humanoid") then P.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping) end 
end)
task.spawn(function() while task.wait(60) do if anti and P.Character and P.Character:FindFirstChildOfClass("Humanoid") then pcall(function() P.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping) end) end end end)Window:SelectTab(1)Fluent:Notify({Title = "Crows Hub | PC Edition",Content = "Премиум интерфейс ver 8.3 полностью инициализирован!",Duration = 5})
