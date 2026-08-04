-- =======================================================================
-- CROWS HUB (CWH) ver 8.2 - PC PREMIUM (NO-BUG VERSION)
-- =======================================================================

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local WS, JP, FV = 16, 50, 70
local wsOn, jpOn, infJ, noclip, flg, fk, bp, hs, anti = false, false, false, false, false, false, false, false, false

local Window = Fluent:CreateWindow({
    Title = "Crows Hub | PC Premium",
    SubTitle = "by crowshubdev",
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
-- ВКЛАДКА 2: BYPASS & VISUALS
-- =======================================================================
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
-- ВКЛАДКА 4: SETTINGS (БЕЗБАГОВАЯ КАСТОМИЗАЦИЯ ВРУЧНУЮ)
-- =======================================================================
Tabs.Settings:AddSection("Menu Customization")

-- Кастомная удобная кнопка смены бинда закрытия меню
Tabs.Settings:AddKeybind("MenuKeybind", {
    Title = "Кнопка скрытия меню ГУИ",
    Mode = "Toggle",
    Default = "RightShift",
    Callback = function(Value)
        Window:ChangeMinimizeKey(Value)
    end
})

-- Наша личная автономная кнопка выбора тем (без лагающих плагинов)
local currentThemeNum = 1
local themeList = {"Dark", "Light", "Amethyst", "Aqua"}
local ThemeBtn = Tabs.Settings:AddButton({
    Title = "Сменить тему UI (Клик)",
    Description = "Текущая тема: Dark",
    Callback = function()
        currentThemeNum = currentThemeNum + 1
        if currentThemeNum > #themeList then currentThemeNum = 1 end
        local chosenTheme = themeList[currentThemeNum]
        Window:SetTheme(chosenTheme)
        Fluent:Notify({
            Title = "Crows Hub Theme",
            Content = "Тема интерфейса изменена на: " .. chosenTheme,
            Duration = 2
        })
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
-- ЧИСТАЯ ИЗОЛИРОВАННАЯ ПК-ЛОГИКА
-- =======================================================================
local P = game.Players.LocalPlayer

game:GetService("RunService").Stepped:Connect(function()
    pcall(function()
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

task.spawn(function() while task.wait(60) do if anti and P.Character and P.Character:FindFirstChildOfClass("Humanoid") then pcall(function() P.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping) end) end end end)

Window:SelectTab(1)

Fluent:Notify({
    Title = "Crows Hub | PC Edition",
    Content = "Премиум интерфейс ver 8.2 успешно инициализирован!",
    Duration = 5
})
