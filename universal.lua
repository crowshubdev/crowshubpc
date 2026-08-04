-- =======================================================================
-- CROWS HUB (CWH) - FLUENT UI PC VERSION
-- =======================================================================

-- 1. Загружаем официальную библиотеку Fluent UI из интернета
local Fluent = loadstring(game:HttpGet("https://github.com"))()

-- Переменные для твоих чит-функций
local WS, JP = 16, 50
local wsOn, jpOn, infJ, noclip = false, false, false, false

-- 2. Создаем главное роскошное окно (как у Overdrive)
local Window = Fluent:CreateWindow({
    Title = "Crows Hub | PC Edition",
    SubTitle = "by crowshubdev",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 420), -- Большой удобный размер для ПК-экрана
    Acrylic = true, -- Красивое полупрозрачное размытие заднего фона
    Theme = "Dark", -- Темная стильная тема
    MinimizeKey = Enum.KeyCode.RightShift -- Скрыть/открыть меню на правый Шифт!
})

-- 3. Создаем левые вкладки (Tabs)
local MainTab = Window:AddTab({ Title = "Main", Icon = "home" })
local BypassTab = Window:AddTab({ Title = "Bypass & Visuals", Icon = "eye" })

-- =======================================================================
-- НАПОЛНЕНИЕ ВКЛАДКИ 1: MAIN (Скорость и Прыжки)
-- =======================================================================

MainTab:AddSection("Character Modifications")

-- Красивая кнопка-переключатель (Toggle) для скорости
MainTab:AddToggle("SpeedBtn", {
    Title = "Toggle WalkSpeed (Включить Скорость)",
    Default = false,
    Callback = function(Value)
        wsOn = State
    end
})

-- Плавный ползунок (Slider) для выбора значения скорости
MainTab:AddSlider("SpeedSlider", {
    Title = "WalkSpeed Value",
    Description = "Регулировка скорости бега",
    Min = 16,
    Max = 250,
    Default = 16,
    Rounding = 0,
    Callback = function(Value)
        WS = Value
    end
})

MainTab:AddSection("Jump Modifications")

-- Переключатель для прыжка
MainTab:AddToggle("JumpBtn", {
    Title = "Toggle JumpPower (Включить Прыжок)",
    Default = false,
    Callback = function(Value)
        jpOn = State
    end
})

-- Ползунок силы прыжка
MainTab:AddSlider("JumpSlider", {
    Title = "JumpPower Value",
    Min = 50,
    Max = 300,
    Default = 50,
    Rounding = 0,
    Callback = function(Value)
        JP = Value
    end
})

-- =======================================================================
-- НАПОЛНЕНИЕ ВКЛАДКИ 2: BYPASS & VISUALS (Ноклип, Инф Прыжок)
-- =======================================================================

BypassTab:AddToggle("InfJumpBtn", {
    Title = "Infinite Jump (Бесконечный прыжок)",
    Default = false,
    Callback = function(State)
        infJ = State
    end
})

BypassTab:AddToggle("NoclipBtn", {
    Title = "Noclip (Проход сквозь стены)",
    Default = false,
    Callback = function(State)
        noclip = State
    end
})

-- Обычная клик-кнопка (Button) для суицида
BypassTab:AddButton({
    Title = "Instant Reset (Суицид)",
    Description = "Мгновенное возрождение",
    Callback = function()
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.Health = 0
        end
    end
})

-- =======================================================================
-- ЖЕСТКИЙ ЦИКЛ ФИЗИКИ (Твоя рабочая логика)
-- =======================================================================
game:GetService("RunService").Stepped:Connect(function()
    pcall(function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            local h = char:FindFirstChildOfClass("Humanoid")
            if wsOn then h.WalkSpeed = WS end
            if jpOn then h.UseJumpPower = true h.JumpPower = JP end
            if noclip then 
                for _,v in pairs(char:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end 
            end
        end
    </pcall>
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if infJ and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Красивое уведомление (Notification) в углу экрана при запуске хаба
Fluent:Notify({
    Title = "Crows Hub",
    Content = "Скрипт на базе Fluent UI успешно запущен!",
    Duration = 5
})
