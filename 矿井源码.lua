local LBLG = Instance.new("ScreenGui", getParent)
local LBL = Instance.new("TextLabel", getParent)
local player = game.Players.LocalPlayer

LBLG.Name = "LBLG"
LBLG.Parent = game.CoreGui
LBLG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LBLG.Enabled = true
LBL.Name = "LBL"
LBL.Parent = LBLG
LBL.BackgroundColor3 = Color3.new(1, 1, 1)
LBL.BackgroundTransparency = 1
LBL.BorderColor3 = Color3.new(0, 0, 0)
LBL.Position = UDim2.new(0.75,0,0.010,0)
LBL.Size = UDim2.new(0, 133, 0, 30)
LBL.Font = Enum.Font.GothamSemibold
LBL.Text = "TextLabel"
LBL.TextColor3 = Color3.new(1, 1, 1)
LBL.TextScaled = true
LBL.TextSize = 14
LBL.TextWrapped = true
LBL.Visible = true

local FpsLabel = LBL
local Heartbeat = game:GetService("RunService").Heartbeat
local LastIteration, Start
local FrameUpdateTable = { }

game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "洛天依矿井脚本"; Text ="载入中"; Duration = 2; })wait("3")

game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "ggs制作矿井脚本"; Text ="阿巴阿巴"; Duration = 2; })wait("3")

game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "我喜欢挂王牌"; Text ="🙏钱晨拜三拜"; Duration = 2; })wait("3")

game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "洛天依矿井脚本"; Text ="载入成功"; Duration = 2; })

local function HeartbeatUpdate()
	LastIteration = tick()
	for Index = #FrameUpdateTable, 1, -1 do
		FrameUpdateTable[Index + 1] = (FrameUpdateTable[Index] >= LastIteration - 1) and FrameUpdateTable[Index] or nil
	end
	FrameUpdateTable[1] = LastIteration
	local CurrentFPS = (tick() - Start >= 1 and #FrameUpdateTable) or (#FrameUpdateTable / (tick() - Start))
	CurrentFPS = CurrentFPS - CurrentFPS % 1
	FpsLabel.Text = ("现在时间:"..os.date("%H").."时"..os.date("%M").."分"..os.date("%S"))
end
Start = tick()
Heartbeat:Connect(HeartbeatUpdate)

local playerGui = game.Players.LocalPlayer.PlayerGui 
  
 local fpsGui = Instance.new("ScreenGui") 
 fpsGui.Name = "FpsGui" 
 fpsGui.Parent = playerGui 
  
 local fpsLabel = Instance.new("TextLabel") 
 fpsLabel.Name = "FpsLabel" 
 fpsLabel.Size = UDim2.new(0, 100, 0, 20) 
 fpsLabel.Position = UDim2.new(0, 20, 0, 20) 
 fpsLabel.BackgroundColor3 = Color3.new(0, 0, 0) 
 fpsLabel.TextColor3 = Color3.new(1, 1, 1) 
 fpsLabel.Font = Enum.Font.SourceSans 
 fpsLabel.FontSize = Enum.FontSize.Size14 
 fpsLabel.Text = "帧数: " 
 fpsLabel.Parent = fpsGui 
  
 local lastUpdate = tick() 
  
 local fps = 0 
  
 local function updateFpsCounter() 
     local deltaTime = tick() - lastUpdate 
     lastUpdate = tick() 
  
     fps = math.floor(1 / deltaTime) 
  
     fpsLabel.Text = "帧数: " .. fps 
 end 
  
 game:GetService("RunService").RenderStepped:Connect(updateFpsCounter) 

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/renlua/UI-lib/refs/heads/main/AL_V3"))()
local win = library:new("H矿井脚本")
--
local UITab1 = win:Tab("信息",'16060333448')

local about = UITab1:section("作者信息",false)

about:Label("矿井脚本")
about:Label("ggs制作")
about:Label("每星期天星期六一定更新")
about:Label("此脚本是测试的有bug告诉洛天依")
about:Label("感谢游玩")

local UITab2 = win:Tab("主要功能",'16060333448')

local mainFunctions = UITab2:section("主要功能",false)

-- 无限挖矿功能
local miningEnabled = false
local miningThread = nil

local function startMining()
    miningEnabled = true
    miningThread = task.spawn(function()
        while miningEnabled do
            task.wait(0)
            local args = {
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,
                math.huge
            }
            game:GetService("ReplicatedStorage"):WaitForChild("shared/network/MiningNetwork@GlobalMiningEvents"):WaitForChild("Mine"):FireServer(unpack(args))
        end
    end)
end

local function stopMining()
    miningEnabled = false
    if miningThread then
        task.cancel(miningThread)
        miningThread = nil
    end
end

mainFunctions:Toggle("无限挖矿", false, function(state)
    if state then
        startMining()
    else
        stopMining()
    end
end)

-- 自动收集物品功能
local collectEnabled = false
local collectThread = nil
local collectRange = 50 -- 默认收集范围

local function startCollecting()
    collectEnabled = true
    collectThread = task.spawn(function()
        while collectEnabled do
            task.wait(0.5) -- 每0.5秒检测一次，减少性能消耗
            
            local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
            for i, v in ipairs(workspace.Items:GetChildren()) do
                -- 检查物品是否在范围内
                if (v.Position - playerPos).Magnitude <= collectRange then
                    local args = { v.Name }
                    game:GetService("ReplicatedStorage"):WaitForChild("shared/network/MiningNetwork@GlobalMiningEvents"):WaitForChild("CollectItem"):FireServer(unpack(args))
                end
            end
        end
    end)
end

local function stopCollecting()
    collectEnabled = false
    if collectThread then
        task.cancel(collectThread)
        collectThread = nil
    end
end

mainFunctions:Toggle("自动收集物品", false, function(state)
    if state then
        startCollecting()
    else
        stopCollecting()
    end
end)

mainFunctions:Slider("收集范围", 10, 500, 50, function(value)
    collectRange = value
end)