-- 客户端脚本（放入StarterPlayerScripts）
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local keyBox = Instance.new("TextBox")
local submitBtn = Instance.new("TextButton")
local resultLabel = Instance.new("TextLabel")

-- ✅ 定义卡密库存（客户端存储，不安全！仅测试用）
local ValidKeys = {
    ["Roblox125847KEY"] = true,
    ["Roblox123695KEY"] = true,
    ["Roblox126475KEY"] = true,
}

-- 创建UI
function CreateUI()
    screenGui.Name = "KeySystem"
    screenGui.Parent = player.PlayerGui

    frame.Size = UDim2.new(0, 300, 0, 150)
    frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    frame.Parent = screenGui

    keyBox.Size = UDim2.new(0.8, 0, 0, 30)
    keyBox.Position = UDim2.new(0.1, 0, 0.2, 0)
    keyBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    keyBox.TextColor3 = Color3.new(1, 1, 1)
    keyBox.PlaceholderText = "输入卡密..."
    keyBox.ClearTextOnFocus = true
    keyBox.Parent = frame

    submitBtn.Size = UDim2.new(0.8, 0, 0, 30)
    submitBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
    submitBtn.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    submitBtn.TextColor3 = Color3.new(1, 1, 1)
    submitBtn.Text = "激活"
    submitBtn.Parent = frame

    resultLabel.Size = UDim2.new(0.8, 0, 0, 20)
    resultLabel.Position = UDim2.new(0.1, 0, 0.8, 0)
    resultLabel.BackgroundTransparency = 1
    resultLabel.TextColor3 = Color3.new(1, 1, 1)
    resultLabel.Text = ""
    resultLabel.Parent = frame
end

-- 验证逻辑（客户端验证，不安全！）
submitBtn.MouseButton1Click:Connect(function()
    local inputKey = keyBox.Text
    if inputKey == "" then
        resultLabel.Text = "请输入卡密！"
        return
    end

    -- ✅ 直接检查客户端存储的卡密
    if ValidKeys[inputKey] then
        resultLabel.Text = "激活成功！"
        keyBox.Text = ""
        
        -- ✅ 卡密验证成功，执行脚本
        loadstring(game:HttpGet("https://raw.githubusercontent.com/yun5555555555/kungjing/refs/heads/main/%E7%9F%BF%E4%BA%95%E6%BA%90%E7%A0%81.lua"))()
        
        -- 可选：关闭UI
        screenGui:Destroy()
    else
        resultLabel.Text = "卡密无效或已使用！"
    end
end)

-- 初始化UI
CreateUI()