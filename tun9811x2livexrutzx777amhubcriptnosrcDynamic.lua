print("Executor "..identifyexecutor())
if not game:IsLoaded() then repeat game.Loaded:Wait() until game:IsLoaded() end
getgenv().Config = {
    Save_Member = true
}
_G.Check_Save_Setting = "CheckSaveSetting"
getgenv()['JsonEncode'] = function(msg)
    return game:GetService("HttpService"):JSONEncode(msg)
end
getgenv()['JsonDecode'] = function(msg)
    return game:GetService("HttpService"):JSONDecode(msg)
end
getgenv()['Check_Setting'] = function(Name)
    if not _G.Dis then
        if not isfolder('Dynamic Hub') then
            makefolder('Dynamic Hub')
        end
        if not isfolder('Dynamic Hub/Grow a Garden') then
            makefolder('Dynamic Hub/Grow a Garden')
        end
        if not isfile('Dynamic Hub/Grow a Garden/'..Name..'.json') then
            writefile('Dynamic Hub/Grow a Garden/'..Name..'.json', JsonEncode(getgenv().Config))
        end
    end
end
getgenv()['Get_Setting'] = function(Name)
    if not _G.Dis then
        if isfolder('Dynamic Hub') and isfile('Dynamic Hub/Grow a Garden/'..Name..'.json') then
            getgenv().Config = JsonDecode(readfile('Dynamic Hub/Grow a Garden/'..Name..'.json'))
            return getgenv().Config
        else
            getgenv()['Check_Setting'](Name)
        end
    end
end
getgenv()['Update_Setting'] = function(Name)
    if not _G.Dis then
        if isfolder('Dynamic Hub') and isfile('Dynamic Hub/Grow a Garden/'..Name..'.json') then
            writefile('Dynamic Hub/Grow a Garden/'..Name..'.json', JsonEncode(getgenv().Config))
        else
            getgenv()['Check_Setting'](Name)
        end
    end
end
getgenv()['Check_Setting'](_G.Check_Save_Setting)
getgenv()['Get_Setting'](_G.Check_Save_Setting)
if getgenv().Config.Save_Member then
    getgenv()['MyName'] = game.Players.LocalPlayer.Name
elseif getgenv().Config.Save_All_Member then
    getgenv()['MyName'] = "AllMember"
else
    getgenv()['MyName'] = "None"
    _G.Dis = true
end
getgenv()['Check_Setting'](getgenv()['MyName'])
getgenv()['Get_Setting'](getgenv()['MyName'])
getgenv().Config.Key = _G.wl_key
getgenv()['Update_Setting'](getgenv()['MyName'])
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/tun9811/Fluent/refs/heads/main/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/tun9811/Fluent/refs/heads/main/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/tun9811/Fluent/refs/heads/main/InterfaceManager.lua"))()
--// Anti AFK
game:GetService("Players").LocalPlayer.Idled:connect(function()
	game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	wait(180)
	game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
function EquipEggs()
    for i, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        if v:GetAttribute("ItemType") == "PetEgg" then
        local egge = v
        local eggname = v:GetAttribute("EggName")
            for i,v in pairs(getgenv().Config["Select Eggs"] or {}) do
                if eggname == i then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(egge)
                end
            end
        end
    end
end
function EquipSeed()
    for i, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        if v:GetAttribute("Seed") then
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
        end
    end
end
function EquipSeedFeeds()
    for i, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        if v:GetAttribute("ItemType") == "Holdable" then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
        end
    end
end
local TweenService = game:GetService("TweenService")
_G.Logo = 83452741766028 --- เลข logo
if game.CoreGui:FindFirstChild("ImageButton") then
    game.CoreGui:FindFirstChild("ImageButton"):Destroy()
end
local TweenService = game:GetService("TweenService")
_G.Logo = 83452741766028 --- เลข logo
if game.CoreGui:FindFirstChild("ImageButton") then
    game.CoreGui:FindFirstChild("ImageButton"):Destroy()
end
local ScreenGui = Instance.new("ScreenGui")
local ImageButton = Instance.new("ImageButton")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local Shadow = Instance.new("ImageLabel")
local ClickSound = Instance.new("Sound")
ScreenGui.Name = "ImageButton"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ImageButton.Parent = ScreenGui
ImageButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ImageButton.BackgroundTransparency = 0.8
ImageButton.BorderSizePixel = 0
ImageButton.Position = UDim2.new(0.49, 0, 0.010, 0)
ImageButton.Size = UDim2.new(0, 50, 0, 45)
ImageButton.Draggable = false
ImageButton.Image = "http://www.roblox.com/asset/?id="..(_G.Logo)
ImageButton.ImageTransparency = 0.4
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = ImageButton
UIStroke.Parent = ImageButton
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Transparency = 1
ClickSound.Parent = ImageButton
ClickSound.SoundId = "rbxassetid://130785805"
ClickSound.Volume = 1
local function playClickAnimation()
    local originalSize = ImageButton.Size
    local TweenSizeUp = TweenService:Create(ImageButton, TweenInfo.new(0.1), {Size = UDim2.new(0, 50, 0, 45)})
    local TweenSizeDown = TweenService:Create(ImageButton, TweenInfo.new(0.1), {Size = originalSize})
    TweenSizeUp:Play()
    TweenSizeUp.Completed:Connect(function()
        TweenSizeDown:Play()
    end)
end
ImageButton.MouseButton1Down:Connect(function()
    ClickSound:Play()    
    playClickAnimation()    
    game:GetService("VirtualInputManager"):SendKeyEvent(true, "RightControl", false, game)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, "RightControl", false, game)
end)
local Window = Fluent:CreateWindow({
    Title = "Grow a Garden - Dynamic Hub",
    SubTitle = "By x2Livex",
    TabWidth = 110,
    Size = UDim2.fromOffset(620, 420),
    --[[
    Acrylic = true,
    --]]
    Theme = "Lua Theme",
    MinimizeKey = Enum.KeyCode.RightControl
})
local Tabs = {
	General = Window:AddTab({ Title = "General", Icon = "component" }),
    Shop = Window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
    Dupe = Window:AddTab({ Title = "Dupe", Icon = "box" }),
	Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}
local Options = Fluent.Options
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local hrp = Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
Tabs.General:AddSection("[🏠] Main")
Tabs.General:AddToggle("Auto Plant", {
    Title = "Auto Plant", 
    Description = "",
    Default = getgenv().Config["Auto Plant"] or false,
    Callback = function(Value)
        getgenv().Config["Auto Plant"] = Value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end
})
local seedname = {}
for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
    table.insert(seedname,v:GetAttribute("Seed"))
end
local lpname = game.Players.LocalPlayer.Name
spawn(function()
    while wait() do
        if getgenv().Config["Auto Plant"] then
            pcall(function()
                for i,v in next , workspace.Farm:GetChildren() do
                    if v:FindFirstChild "Important" then
                        if v:FindFirstChild "Important".Data.Owner.Value == lpname then
                            local Plant_Locations =  v:FindFirstChild "Important".Plant_Locations.Can_Plant.Position
                            for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                                if v:IsA("Tool") then
                                    wait(0.1)
                                    local args = {
                                        Plant_Locations,
                                        v:GetAttribute("Seed")
                                    }
                                    game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Plant_RE"):FireServer(unpack(args))
                                else
                                    EquipSeed()
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)
Tabs.General:AddToggle("Auto Collect Plant", {
    Title = "Auto Collect Plant", 
    Description = "",
    Default = getgenv().Config["Auto Collect Plant"] or false,
    Callback = function(Value)
        getgenv().Config["Auto Collect Plant"] = Value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end
})
spawn(function()
    while wait(0.1) do
        if getgenv().Config["Auto Collect Plant"] then
            pcall(function()
                local ply  = game.Players.LocalPlayer.Name
                for i,v in pairs(workspace.Farm:GetChildren()) do
                    if v:FindFirstChild("Important") then
                        local Important = v.Important
                        local Plants_Physical = v.Important.Plants_Physical
                        for i,v in pairs(Important:GetChildren()) do
                            if v:FindFirstChild("Owner") then
                            if v.Owner.Value == ply then
                                    for i,v in pairs(Plants_Physical:GetChildren()) do
                                        if v.Parent == Plants_Physical and v:FindFirstChild("Fruits") then
                                            local Fruits = v:FindFirstChild("Fruits")
                                            for i,v in pairs(Fruits:GetChildren()) do
                                                if v:FindFirstChild("2") then
                                                    local pro = v:FindFirstChild("2") 
                                                    for i,v in pairs(pro:GetChildren()) do
                                                        if v.Name == "ProximityPrompt" then
                                                            hrp.CFrame = pro.CFrame
                                                            fireproximityprompt(v,100000)
                                                        end
                                                    end
                                                end
                                            end
                                        elseif v:FindFirstChild("2") then
                                            local pro = v:FindFirstChild("2") 
                                            for i,v in pairs(pro:GetChildren()) do
                                                if v.Name == "ProximityPrompt" then
                                                    hrp.CFrame = pro.CFrame
                                                    fireproximityprompt(v,100000)
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)
Tabs.General:AddToggle("Auto Sell All", {
    Title = "Auto Sell All", 
    Description = "",
    Default = getgenv().Config["Auto Sell All"] or false,
    Callback = function(Value)
        getgenv().Config["Auto Sell All"] = Value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end
})
function TP(Pos)
    hrp.CFrame = Pos
end
spawn(function()
    while wait() do
        if getgenv().Config["Auto Sell All"] then
            pcall(function()
                TP(CFrame.new(61.5791626, 2.99999976, 0.426791906, 0.00144657469, -2.19503917e-08, -0.999998927, -1.77063984e-13, 1, -2.19504148e-08, 0.999998927, 3.19299795e-11, 0.00144657469))
                game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()
            end)
        end
    end
end)
Tabs.General:AddSection("[👩‍🌾] Npcs")
local npcs = {}
for i,v in next , workspace.NPCS:GetChildren() do
    table.insert(npcs,v.Name)
end
local ChoosedNpcs = Tabs.General:AddDropdown("Select Npcs", {
    Title = "Select Npcs",
    Description = "",
    Values = npcs,
    Multi = false,
    Default = getgenv().Config["Select Npcs"] or "N/A",
})
ChoosedNpcs:OnChanged(function(Value)
    getgenv().Config["Select Npcs"] = Value
    getgenv()['Update_Setting'](getgenv()['MyName'])
end)
Tabs.General:AddButton({
    Title = "Teleport to Npcs",
    Description = "",
    Callback = function()
        for i,v in next , workspace.NPCS:GetChildren() do
            if v.Name == getgenv().Config["Select Npcs"] then
                TP(v.HumanoidRootPart.CFrame)
            end
        end
    end
})
Tabs.General:AddSection("[🥚] Eggs")
local eggshop = {}
for i,v in pairs(game:GetService("ReplicatedStorage").Assets.Models.EggModels:GetChildren()) do
    table.insert(eggshop,v.Name)
end
local ChoosedEggs = Tabs.General:AddDropdown("Select Eggs", {
    Title = "Select Eggs",
    Description = "",
    Values = eggshop,
    Multi = true,
    Default = {getgenv().Config["Select Eggs"] or "N/A"},
})
if getgenv().Config["Select Eggs"] then
    ChoosedEggs:SetValue(getgenv().Config["Select Eggs"])
end
ChoosedEggs:OnChanged(function(Value)
    getgenv().Config["Select Eggs"] = Value
    getgenv()['Update_Setting'](getgenv()['MyName'])
end)
Tabs.General:AddToggle("Auto Plant Eggs", {
    Title = "Auto Plant Eggs", 
    Description = "",
    Default = getgenv().Config["Auto Plant Eggs"] or false,
    Callback = function(Value)
        getgenv().Config["Auto Plant Eggs"] = Value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end
})
spawn(function()
    while wait() do
        if getgenv().Config["Auto Plant Eggs"] then
            pcall(function()
                for i,v in next , workspace.Farm:GetChildren() do
                    if v:FindFirstChild "Important" then
                        if v:FindFirstChild "Important".Data.Owner.Value == lpname then
                            local Plant_Locations =  v:FindFirstChild "Important".Plant_Locations.Can_Plant.Position
                            for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                                EquipEggs()
                                wait(0.1)
                                local args = {
                                    "CreateEgg",
                                    Plant_Locations
                                }
                                game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("PetEggService"):FireServer(unpack(args))
                            end
                        end
                    end
                end
            end)
        end
    end
end)
Tabs.General:AddToggle("Auto Hatch Eggs", {
    Title = "Auto Hatch Eggs", 
    Description = "",
    Default = getgenv().Config["Auto Hatch Eggs"] or false,
    Callback = function(Value)
        getgenv().Config["Auto Hatch Eggs"] = Value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end
})
spawn(function()
    while wait() do
        if getgenv().Config["Auto Hatch Eggs"] then
            pcall(function()
                for i,v in next , workspace.Farm:GetChildren() do
                    if v:FindFirstChild "Important" then
                        if v:FindFirstChild "Important".Data.Owner.Value == lpname then
                            local Objects_Physical = v:FindFirstChild "Important".Objects_Physical
                            for i,v in pairs(Objects_Physical:GetChildren()) do
                                local egg = v
                                for i,v in pairs(getgenv().Config["Select Eggs"] or {}) do
                                    if egg:FindFirstChild(i) and egg[i]:FindFirstChild("ProximityPrompt") then
                                        hrp.CFrame = egg.PetEgg.CFrame
                                        fireproximityprompt(egg[i]:FindFirstChild("ProximityPrompt"))
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)
Tabs.General:AddSection("[🐔] Feeds")
Tabs.General:AddToggle("Auto Feed", {
    Title = "Auto Feed", 
    Description = "",
    Default = getgenv().Config["Auto Feed"] or false,
    Callback = function(Value)
        getgenv().Config["Auto Feed"] = Value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end
})
spawn(function()
    while wait() do
        if getgenv().Config["Auto Feed"] then
            pcall(function()
                EquipSeedFeeds()
                local args = {
                    "Feed",
                    "{cd2a2567-b23b-466d-ab1a-ce6b80a6808e}"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("ActivePetService"):FireServer(unpack(args))
            end)
        end
    end
end)
Tabs.Shop:AddSection("[🍅] Seed")
local CurrentStock = Tabs.Shop:AddParagraph({
    Title = "Current Stock",
    Content = ""
})
local checkstock = {}
spawn(function()
    while task.wait(1) do
        pcall(function()
            table.clear(checkstock)
            local player = game:GetService("Players").LocalPlayer
            local gui = player:WaitForChild("PlayerGui")
            local shop = gui:WaitForChild("Seed_Shop")
            local frame = shop:WaitForChild("Frame")
            local scroll = frame:WaitForChild("ScrollingFrame")
            for _, v in ipairs(scroll:GetChildren()) do
                local main = v:FindFirstChild("Main_Frame")
                if main then
                    local seedText = main:FindFirstChild("Seed_Text")
                    local stockText = main:FindFirstChild("Stock_Text")
                    local costText = main:FindFirstChild("Cost_Text")
                    if seedText and stockText and costText then
                        local stock = tonumber(string.match(stockText.Text, "X(%d+)"))
                        if stock and stock > 0 then
                            table.insert(checkstock,
                                seedText.Text .. " x" .. stock .. " | Cost: " .. costText.Text
                            )
                        end
                    end
                end
            end
            if CurrentStock and typeof(CurrentStock.SetDesc) == "function" then
                CurrentStock:SetDesc(table.concat(checkstock, "\n"))
            end
        end)
    end
end)
local seed = {}
for i,v in next , game:GetService("ReplicatedStorage").Seed_Models:GetChildren() do
    table.insert(seed,v.Name)
end
local ChoosedSeed = Tabs.Shop:AddDropdown("Select Seed", {
    Title = "Select Seed",
    Description = "",
    Values = seed,
    Multi = true,
    Default = {getgenv().Config["Select Seed"] or "N/A"},
})
if getgenv().Config["Select Seed"] then
    ChoosedSeed:SetValue(getgenv().Config["Select Seed"])
end
ChoosedSeed:OnChanged(function(Value)
    getgenv().Config["Select Seed"] = Value
    getgenv()['Update_Setting'](getgenv()['MyName'])
end)
Tabs.Shop:AddToggle("Auto Buy Seed", {
    Title = "Auto Buy Seed", 
    Description = "",
    Default = getgenv().Config["Auto Buy Seed"] or false,
    Callback = function(Value)
        getgenv().Config["Auto Buy Seed"] = Value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end
})
spawn(function()
    while wait() do
        if getgenv().Config["Auto Buy Seed"] then
            pcall(function()
                for i,v in next , getgenv().Config["Select Seed"] or {} do
                local args = {
                    i
                }
                game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuySeedStock"):FireServer(unpack(args))
                end
            end)
        end
    end
end)
Tabs.Shop:AddToggle("Auto Buy Seed All", {
    Title = "Auto Buy Seed All", 
    Description = "",
    Default = getgenv().Config["Auto Buy Seed All"] or false,
    Callback = function(Value)
        getgenv().Config["Auto Buy Seed All"] = Value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end
})
spawn(function()
    while wait() do
        if getgenv().Config["Auto Buy Seed All"] then
            pcall(function()
                for i,v in next , game:GetService("ReplicatedStorage").Seed_Models:GetChildren() do
                local args = {
                    v.Name
                }
                game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuySeedStock"):FireServer(unpack(args))
                end
            end)
        end
    end
end)
local gear = {}
for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Gear_Shop.Frame.ScrollingFrame:GetChildren()) do
    if v:FindFirstChild("Main_Frame") then
        table.insert(gear, v.Main_Frame.Gear_Text.Text)
    end
end
Tabs.Shop:AddSection("[⚙️] Gear")
local checkGear = Tabs.Shop:AddParagraph({
    Title = "Current Gear",
    Content = ""
})
local checkgear = {}
spawn(function()
    while task.wait(1) do
        pcall(function()
            table.clear(checkgear)
            local player = game:GetService("Players").LocalPlayer
            local gui = player:WaitForChild("PlayerGui")
            local shop = gui:WaitForChild("Gear_Shop")
            local frame = shop:WaitForChild("Frame")
            local scroll = frame:WaitForChild("ScrollingFrame")
            for _, v in ipairs(scroll:GetChildren()) do
                local main = v:FindFirstChild("Main_Frame")
                if main then
                    local seedText = main:FindFirstChild("Gear_Text")
                    local stockText = main:FindFirstChild("Stock_Text")
                    local costText = main:FindFirstChild("Cost_Text")
                    if seedText and stockText and costText then
                        local stock = tonumber(string.match(stockText.Text, "X(%d+)"))
                        if stock and stock > 0 then
                            table.insert(checkgear,
                                seedText.Text .. " x" .. stock .. " | Cost: " .. costText.Text
                            )
                        else
                            checkGear:SetDesc("...")
                        end
                    end
                end
            end
            if checkGear and typeof(checkGear.SetDesc) == "function" then
                checkGear:SetDesc(table.concat(checkgear, "\n"))
            end
        end)
    end
end)
local Choosedgear = Tabs.Shop:AddDropdown("Select Gear", {
    Title = "Select Gear",
    Description = "",
    Values = gear,
    Multi = true,
    Default = {getgenv().Config["Select Gear"] or "N/A"},
})
if getgenv().Config["Select Gear"] then
    Choosedgear:SetValue(getgenv().Config["Select Gear"])
end
Choosedgear:OnChanged(function(Value)
    getgenv().Config["Select Gear"] = Value
    getgenv()['Update_Setting'](getgenv()['MyName'])
end)
Tabs.Shop:AddToggle("Auto Buy Gear", {
    Title = "Auto Buy Gear", 
    Description = "",
    Default = getgenv().Config["Auto Buy Gear"] or false,
    Callback = function(Value)
        getgenv().Config["Auto Buy Gear"] = Value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end
})
spawn(function()
    while wait() do
        if getgenv().Config["Auto Buy Gear"] then
            pcall(function()
                for i,v in next , getgenv().Config["Select Gear"] or {} do
                    local args = {
                        i
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyGearStock"):FireServer(unpack(args))
                end
            end)
        end
    end
end)
Tabs.Shop:AddToggle("Auto Buy Gear All", {
    Title = "Auto Buy Gear All", 
    Description = "",
    Default = getgenv().Config["Auto Buy Gear All"] or false,
    Callback = function(Value)
        getgenv().Config["Auto Buy Gear All"] = Value
        getgenv()['Update_Setting'](getgenv()['MyName'])
    end
})
spawn(function()
    while wait() do
        if getgenv().Config["Auto Buy Gear All"] then
            pcall(function()
                for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Gear_Shop.Frame.ScrollingFrame:GetChildren()) do
                    if v:FindFirstChild("Main_Frame") then
                    local args = {
                        v.Main_Frame.Gear_Text.Text
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyGearStock"):FireServer(unpack(args))
                    end
                end
            end)
        end
    end
end)
Tabs.Dupe:AddSection("[💵] Money")
Tabs.Dupe:AddButton({
    Title = "Dupe Money",
    Description = "",
    Callback = function()
       for i,v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character:FindFirstChildOfClass("Tool") and v.Character:FindFirstChildOfClass("Tool"):GetAttribute("ItemType") == "Pet" then
                for i= 1,1000 do
                local args = {
                    [1] = v.Character:FindFirstChildOfClass("Tool")
                }

                game:GetService("ReplicatedStorage"):WaitForChild("GameEvents", 9e9):WaitForChild("SellPet_RE", 9e9):FireServer(unpack(args))
                end
            end
        end
    end
})
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
SaveManager:LoadAutoloadConfig()
