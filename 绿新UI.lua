local CoreGui = game:GetService("StarterGui")
CoreGui:SetCore("SendNotification", {
    Title = "正在启动",
    Text = "开始倒计时",
    Duration = 5,
})
wait(2)
local CoreGui = game:GetService("StarterGui")
CoreGui:SetCore("SendNotification", {
    Title = "倒计时",
    Text = "三",
    Duration = 5,
})
wait(2)
local CoreGui = game:GetService("StarterGui")
CoreGui:SetCore("SendNotification", {
    Title = "倒计时",
    Text = "二",
    Duration = 5,
})
wait(2)
local CoreGui = game:GetService("StarterGui")
CoreGui:SetCore("SendNotification", {
    Title = "倒计时",
    Text = "一",
    Duration = 5,
})
wait(2)
print("Anti Afk On")
		local vu = game:GetService("VirtualUser")
		game:GetService("Players").LocalPlayer.Idled:connect(function()
		   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		   wait(1)
		   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end)
local CoreGui = game:GetService("StarterGui")
CoreGui:SetCore("SendNotification", {
    Title = "反挂机已自动开启",
    Text = "被踢出服务器的概率已降低",
    Duration = 5,
})
wait(2)
local CoreGui = game:GetService("StarterGui")
CoreGui:SetCore("SendNotification", {
    Title = "启动成功",
    Text = "您好"..game.Players.LocalPlayer.Name.."，绿🌲",
    Duration = 5,
})
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

local function HeartbeatUpdate()
	LastIteration = tick()
	for Index = #FrameUpdateTable, 1, -1 do
		FrameUpdateTable[Index + 1] = (FrameUpdateTable[Index] >= LastIteration - 1) and FrameUpdateTable[Index] or nil
	end
	FrameUpdateTable[1] = LastIteration
	local CurrentFPS = (tick() - Start >= 1 and #FrameUpdateTable) or (#FrameUpdateTable / (tick() - Start))
	CurrentFPS = CurrentFPS - CurrentFPS % 1
	FpsLabel.Text = ("当前时间:"..os.date("%H").."时"..os.date("%M").."分"..os.date("%S"))
end
Start = tick()
Heartbeat:Connect(HeartbeatUpdate)
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/WS857960/-/main/QJBDUI.txt'))()
local Window = OrionLib:MakeWindow({Name = "绿🌲｜修复版｜3.20230602", HidePremium = false, SaveConfig = true,IntroText ="绿🌲", ConfigFolder = "好闲"})
OrionLib:MakeNotification({
  Name = "欢迎使用绿🌲,作者QQ:2099718854",
  Content = "当前游戏ID为:" .. game.GameId .. " ",
  Image = "rbxassetid://7734068321",
  Time = 10
})
local Tab = Window:MakeTab({
  Name = "首页",
  Icon = "rbxassetid://4483345998",
  PremiumOnly = false
})
Tab:AddParagraph("你好"..game.Players.LocalPlayer.Name..",欢迎使用绿🍀","脚本仅供娱乐")
Tab:AddParagraph("您的用户名:"," "..game.Players.LocalPlayer.Name.."")
Tab:AddParagraph("您的注入器:"," "..identifyexecutor().."")
Tab:AddParagraph("您当前服务器的ID"," "..game.GameId.."")
Tab:AddParagraph("反挂机已启动","")
Tab:AddButton({
	Name = "反挂机2",
	Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/9fFu43FF"))()
  	end    
})

Tab:AddButton({
  Name = "娱乐蓝屏(还需要手动开启)(大退关闭)",
  Callback = function()
    local gui = Instance.new('ScreenGui', game:service'CoreGui')local button = Instance.new('TextButton', gui)button.Size = UDim2.new(0, 200, 0, 100)button.Position = UDim2.new(.5, 0, .5, 0)button.Text = '点击蓝屏'button.MouseButton1Click:Connect(loadstring(game:HttpGet'https://github.com/RunDTM/roblox-bluescreen/raw/main/bsod.lua'))
  end
})

Tab:AddButton({
	Name = "复制作者QQ号",
	Callback = function()
setclipboard("2099718854")
end
})  

Tab:AddButton({
	Name = "复制QQ群",
	Callback = function()
setclipboard("850765605")
end
})      
local Tab = Window:MakeTab({
  Name = "脚本",
  Icon = "rbxassetid://4483345998",
  PremiumOnly = false
})
Tab:AddButton({
  Name = "绿脚本",
  Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/hjjjjjjjiiugghhhhhhggyi/Green-script/main/%E7%BB%BF%20%E7%99%BD.lua",true))()
  end
})
