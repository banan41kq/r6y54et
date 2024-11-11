-- Загрузка Orion UI Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({Name = "Item Spawner", HidePremium = false, SaveConfig = false, ConfigFolder = "OrionTest"})

-- Переменные
local Amount1 = 5  -- Количество для спавна
local axeSelection = nil  -- Выбранный топор
local presentSelection = nil  -- Выбранный подарок

-- Создаем вкладку для спавнера топоров
local AxeTab = Window:MakeTab({
    Name = "Axe Spawn",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Ползунок для выбора количества предметов
AxeTab:AddSlider({
    Name = "Amount",
    Min = 1,
    Max = 100,
    Default = 5,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "items",
    Callback = function(value)
        Amount1 = value
    end
})

-- Выпадающий список для выбора топора
AxeTab:AddDropdown({
    Name = "Select Axe",
    Default = "Select Axe",
    Options = {"BasicHatchet", "ManyAxe", "Axe1", "Axe2", "Axe3", "SilverAxe", "AxeBetaTesters", "EndTimesAxe", "AxeChicken", "CandyCaneAxe", "AxeAmber", "GingerBreadAxe", "AxeTwitter", "RustyAxe"},
    Callback = function(option)
        axeSelection = option
    end    
})

-- Кнопка для спавна топора
AxeTab:AddButton({
    Name = "Spawn Axe",
    Callback = function()
        spawnAxe()
    end
})

-- Создаем вкладку для спавнера подарков
local PresentTab = Window:MakeTab({
    Name = "Present Spawn",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Ползунок для выбора количества предметов
PresentTab:AddSlider({
    Name = "Amount",
    Min = 1,
    Max = 100,
    Default = 5,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "items",
    Callback = function(value)
        Amount1 = value
    end
})

-- Выпадающий список для выбора подарка
PresentTab:AddDropdown({
    Name = "Select Gift",
    Default = "Select Gift",
    Options = {"2016CGift_Ut", "2015CGift_Coal", "2015CGift_Red", "2016CGift_Sweet", "2015CGift_Volcano", "2015CGift_Wobble", "2016CGift_Blue", "2016CGift_Big", "2016CGift_Jingle", "2016CGift_Wobble", "2018CGift_Wobble", "2017CGift_Green", "2017CGift_GreatTimes", "2017CGift_Modern", "2017CGift_Wobble", "2019CGift_Wobble_", "2017CGifts_Gold", "2018CGift_Snow", "2018CGift_Plate", "2018CGift_Cocoa", "2018CGift_Candy", "2018CGift_Wobble_", "2018CGift_Duck", "2018CGift_Cone", "2018CGift_Sled", "2018CGift_GingerAxe", "2018CGift_Plum", "2019CGift_Yellow_", "2019CGift_Bowl", "2019CGift_Rusty", "2019CGift_Cola", "2019CGift_Burnt", "2020CGift_Teal", "2020CGift_Wobble", "2020CGift_Cave", "2021CGift_Black", "2021CGift_Wobble"},
    Callback = function(option)
        presentSelection = option
    end    
})

-- Кнопка для спавна подарка
PresentTab:AddButton({
    Name = "Spawn Gift",
    Callback = function()
        spawnPresent()
    end
})

-- Создаем вкладку "Other"
local OtherTab = Window:MakeTab({
    Name = "Other",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Кнопка для включения Infinity Yield
OtherTab:AddButton({
    Name = "Infinity Yield",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})

-- Вторая кнопка для инжекта скрипта
OtherTab:AddButton({
    Name = "Inject Script",
    Callback = function()
        -- Вставьте ссылку на ваш скрипт
        local scriptUrl = "https://example.com/your-script-url.lua"  -- Замените на ссылку на ваш скрипт
        loadstring(game:HttpGet(scriptUrl))()
    end
})

-- Функция для спавна топора
function spawnAxe()
    if not axeSelection then
        OrionLib:MakeNotification({
            Name = "Error",
            Content = "Please select a valid axe",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
        return
    end

    local Axe = axeSelection
    local Amount = Amount1
    local Plr = game:GetService("Players").LocalPlayer

    local Added = game:GetService("Workspace").PlayerModels.ChildAdded:Connect(function(v)
        local Owner, Type = v:WaitForChild("Owner"), v:WaitForChild("Type")
        if Owner.Value == Plr and Type.Value == "Blueprint" then
            game:GetService("ReplicatedStorage").PlaceStructure.ClientPlacedStructure:FireServer(Axe, Plr.Character.Head.CFrame, Plr, nil, v, true)
        end
    end)

    for i = 1, Amount do
        game:GetService("ReplicatedStorage").PlaceStructure.ClientPlacedBlueprint:FireServer("Floor1Tiny", Plr.Character.Head.CFrame, Plr)
        task.wait()
    end

    task.wait(2)
    Added:Disconnect()
end

-- Функция для спавна подарка
function spawnPresent()
    if not presentSelection then
        OrionLib:MakeNotification({
            Name = "Error",
            Content = "Please select a valid gift",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
        return
    end

    local Present = presentSelection
    local Amount = Amount1
    local Plr = game:GetService("Players").LocalPlayer

    local Added = game:GetService("Workspace").PlayerModels.ChildAdded:Connect(function(v)
        local Owner, Type = v:WaitForChild("Owner"), v:WaitForChild("Type")
        if Owner.Value == Plr and Type.Value == "Blueprint" then
            game:GetService("ReplicatedStorage").PlaceStructure.ClientPlacedStructure:FireServer(Present, Plr.Character.Head.CFrame, Plr, nil, v, true)
        end
    end)

    for i = 1, Amount do
        game:GetService("ReplicatedStorage").PlaceStructure.ClientPlacedBlueprint:FireServer("Floor1Tiny", Plr.Character.Head.CFrame, Plr)
        task.wait()
    end

    task.wait(2)
    Added:Disconnect()
end

-- Инициализация окна
OrionLib:Init()
