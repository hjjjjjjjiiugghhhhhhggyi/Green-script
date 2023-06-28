(function(define)
	repeat
		game:GetService("RunService").Heartbeat:wait()
	until game:IsLoaded();
	local function check_exploit()  --> 检查注入器配置, 如果注入器不行就不能加载脚本
		if not getgenv then
			return false;
		end
		return true;
	end
	local whitelisted = false;
	
	
	local _CONFIGS = {  --> 游戏配置列表, 如果不懂请勿修改, 可以改数字
	   ["UI_NAME"] = define,
	   ["总开关"] = nil,
	   ["防误触开关"] = true,
	   ["cutPlankByHONG"] = nil,
	   ["无限跳"] = false,
	   ["穿墙开关"] = false,
	   ["飞行开关"] = false,
	   ["isBuying"] = false,
	   ["取消购买"] = false,
	   ["处理木头"] = false,
	   ["处理木头并加工"] = false,
	   ["点击砍树"] = false,
	   ["填充工具"] = false,
	   ["刷粉车"] = false,
	   ["粉车器"] = nil,
	   ["自动砍树"] = nil,
	   ["UI长"] = 250,
	   ["UI宽"] = 300,
	   ["传送模式"] = 2,
	   ["飞行速度"] = 4,
	   ["步行速度"] = 16,
	   ["跳跃力"] = 50,  --> 比如这个50  代表加载脚本初始的跳跃力是50, 可以改 100或者150等等
	   ["悬浮高度"] = 0,
	   ["重力"] = 198,
	   ["相机焦距"] = 100,
	   ["广角"] = 70,
	};
	
	local function ClearConfig()  --> 清除游戏配置功能
		if _CONFIGS["总开关"] ~= nil then
			_CONFIGS["总开关"]:Disconnect()
			_CONFIGS["总开关"] = nil;
			_CONFIGS["防误触开关"] = nil;
			_CONFIGS["无限跳"] = false;
			_CONFIGS["穿墙开关"] = false;
			_CONFIGS["UI长"] = 250;
			_CONFIGS["UI宽"] = 300;
			_CONFIGS["飞行速度"] = 4
			_CONFIGS["飞行开关"] = false
			_CONFIGS["isBuying"] = false;
			getgenv()["点击出售木头"] = false;
			_CONFIGS["取消购买"] = false;
			_CONFIGS["传送模式"] = 2;
			_CONFIGS["处理木头"] = false;
			_CONFIGS["处理木头并加工"] = false
			_CONFIGS["点击砍树"] = false;
			_CONFIGS["填充工具"] = false
			_CONFIGS["刷粉车"] = false
			if getgenv().Test then
				getgenv().Test:Disconnect();
				getgenv().Test = nil;
			end
			if getgenv().CutWoodToSawmill then
				getgenv().CutWoodToSawmill:Disconnect()
				getgenv().CutWoodToSawmill = nil
			end
			if _G.HardDraggerConnection then
				_G.HardDraggerConnection:Disconnect()
				_G.HardDraggerConnection = nil
			end
			if _CONFIGS["cutPlankByHONG"] then
				_CONFIGS["cutPlankByHONG"]:Disconnect();
				_CONFIGS["cutPlankByHONG"] = nil;
			end
			if _G.OrigDrag then
				_G.OrigDrag = nil
			end
			if clickSellLog then
				clickSellLog:Disconnect();
				clickSellLog = nil;
			end
			if mod then
				mod:Disconnect();
				mod = nil;
			end
			if _CONFIGS["自动砍树"] then
				_CONFIGS["自动砍树"]:Disconnect();
				_CONFIGS["自动砍树"] = nil;
			end
			if DayOfNight then
			    DayOfNight:Disconnect()
			    DayOfNight = nil
			end
			if getgenv().PlankToBp then
			    getgenv().PlankToBp:Disconnect()
			    getgenv().PlankToBp = nil
			end
			if _CONFIGS["粉车器"] then
				_CONFIGS["粉车器"]:Disconnect();
				_CONFIGS["粉车器"] = nil;
			end
		end
	end
	ClearConfig()
	
	function ifError(msg)
		warn("脚本出问题辣!")
		writefile(string.format("走马观花错误日志%s.txt", os.date():sub(11):gsub(" ", "-")), string.format("具体错误原因为:\n %s", msg))
	end
	
	local HONG = {
		GS = function(...)
			return game.GetService(game, ...);
		end;
	}
	
	
	HONG.RS = HONG.GS"RunService"
	HONG.RES = HONG.GS"ReplicatedStorage"
	HONG.LIGHT = HONG.GS"Lighting"
	HONG.TPS = HONG.GS"TeleportService"
	HONG.LP = HONG.GS"Players".LocalPlayer
	HONG.WKSPC = HONG.GS"Workspace"
	HONG.COREGUI = HONG.GS "CoreGui";
	local Mouse = HONG.LP:GetMouse()
	
	
	function HONG:printf(...)
		print(string.format(...));
	end
	
	function HONG:SelectNotify(...)
		local Args = {
			...
		}
		local NotificationBindable = Instance.new("BindableFunction")
		NotificationBindable.OnInvoke = Args[6]
		game.StarterGui:SetCore("SendNotification", {
			Title = Args[1],
			Text = Args[2],
			Icon = nil,
			Duration = Args[5],
			Button1 = Args[3],
			Button2 = Args[4],
			Callback = NotificationBindable
		})
		return Args
	end
	
	
	function HONG:DragModel(...)  --> 移动模型功能
		local Args = {
			...
		};
		assert(Args[1]:IsA("Model") == true, "参数1必须是模型!");
		if _CONFIGS["传送模式"] == 1 then
			pcall(function()
				self.RES.Interaction.ClientIsDragging:FireServer(Args[1])
			end);
			Args[1]:PivotTo(Args[2]);
		elseif _CONFIGS["传送模式"] == 2 then
			pcall(function()
				self.RES.Interaction.ClientIsDragging:FireServer(Args[1])
			end);
			if not Args[1].PrimaryPart then
				Args[1].PrimaryPart = Args[1]:FindFirstChildOfClass("Part")
			end
			Args[1]:SetPrimaryPartCFrame(Args[2])
		end
	end
	
	function HONG:Teleport(...)  --> 传送功能
		local Args = {
			...
		};
		if self.LP.Character.Humanoid.SeatPart then
			spawn(function()
				for i = 1, 15 do
					self:DragModel(self.LP.Character.Humanoid.SeatPart.Parent, Args[1]);
				end
			end)
			return;
		end
		for i = 1, 3 do
			self:DragModel(self.LP.Character, Args[1]);
			task.wait();
		end
	end
	
	function HONG:TP(x, y, z)
		self:Teleport(CFrame.new(x, y, z));
	end
	
	function HONG:ServiceTP(ID)  --> 跳转服务器功能, 用于重进服务器
		HONG.TPS:Teleport(ID, HONG.LP)
    end
    
	local whitelist_table = {};
    local check_whitelist = function()  --> 检查白名单功能        
        local url = ""; --> 白名单网址
        local res = game.HttpGet(game, url);
        
    	whitelist_table = loadstring(res)()
    	
    	local plr = game:GetService("Players").LocalPlayer;
    	table.foreach(whitelist_table, function (i,v)
    	    if v == plr.Name  then --> 判断玩家用户名
    	    	whitelisted = true;
    	    end
    	end)
    end
    check_whitelist()
	
	local function checkModify()
	
		local develop = {  --> 脚本开发者列表, 里面双引号填写游戏用户名, 脚本开发者可以免去白名单检查
			"lixiang_c4",
			"Move_C",
			"MIXI_SERVICE2",
			"MIXI_SERVICE3",
			"MIXI_SERVICE4",
			"zhanghuihuihui",
			"jjdkekd30y9",
		}
		local plr = game:GetService("Players").LocalPlayer;
		local is_dev = false;
		local function isDev()
			table.foreach(develop, function(i, v)
				if v == plr.Name then
					is_dev = true;
					return true;
				end
			end)
			return is_dev;
		end
		--↓ 判断代码是否被修改
		if (getgenv().zhanghuihuihui ~= "走马观花作者 紅" or not getgenv().zhanghuihuihui) and not isDev() then
			plr:Kick("请不要修改代码");
			task.wait(.01);
       -- while true do end
		end
		getgenv().zhanghuihuihui = nil;
	end
	local functions = {
		checkModify
	};
	table.foreach(functions, function(_, v)
		pcall(v);
	end)
	if whitelisted == true then
		local plr = game:GetService("Players").LocalPlayer;
		game.StarterGui:SetCore('SendNotification', {
			Title = '白名单认证',  --> 单引号里面的中文可以改, 加载脚本时的通知
			Text = '玩家 : ' .. plr.Name .. ' 你是白名单玩家,稍后会加载脚本'
		})
		local _warn = warn;
		
		task.wait(0.5)
		--↓ 这些是在游戏开发者控制台输出的东西, 修不修改无大碍, 脚本用户看不到, 入过要修改, 修改单引号里面的中文
		_warn('---------------')
		_warn('欢迎' .. plr.Name .. '使用 走马观花脚本')
		_warn('---------------')
		_warn('白名单玩家 : ' .. #whitelist_table .. ' 人')
		_warn('---------------')
		_warn('脚本作者: 紅')
		_warn('---------------')
    
    --<<  UI 部分, 不懂代码请勿修改 >>--
		local a = {
			Plrs = "Players",
			LP = "LocalPlayer",
			RS = "ReplicatedStorage"
		}
		local b = setmetatable({}, {
			__index = function(self, c)
				return game.GetService(game, c)
			end,
			__call = function(self, c)
				return game.GetService(game, c)
			end
		})
		if b.CoreGui:FindFirstChild(_CONFIGS.UI_NAME) then
			b.CoreGui[_CONFIGS.UI_NAME]:Destroy()
		end
		local dm = UDim.new
		local dn = UDim2.new
		local dp = Color3.fromRGB
		local dq = Instance.new
		local dr = function()
		end
		local ds = b.Players.LocalPlayer:GetMouse()
		getgenv().library = {
			flags = {
				GetState = function(dt, du)
					return library.flags[du].State
				end
			},
			modules = {},
			currentTab = nil
		}
		function library:UpdateToggle(du, be)
			local be = be or library.flags:GetState(du)
			if be == library.flags:GetState(du) then
				return
			end
			library.flags[du]:SetState(be)
		end
		local dv = {}
		function dv:Tween(dw, dx, dy, dz, dA)
			return b.TweenService:Create(
	dx, TweenInfo.new(dy or 0.25, Enum.EasingStyle[dz or "Linear"], Enum.EasingDirection[dA or "InOut"]), dw)
		end
		function dv:SwitchTab(dB)
			local dC = library.currentTab
			if dC == dB then
				return
			end
			library.currentTab = dB
			dv:Tween({
				Transparency = 1
			}, dC[2].Glow):Play()
			dv:Tween({
				Transparency = 0
			}, dB[2].Glow):Play()
			dC[1].Visible = false
			dB[1].Visible = true
		end
		local dD = dq("ScreenGui")
		local Open = dq("TextButton")
		local dE = dq("Frame")
		local dF = dq("UICorner")
		local dG = dq("TextLabel")
		local dH = dq("UICorner")
		local dI = dq("Frame")
		local dJ = dq("UICorner")
		local dK = dq("ScrollingFrame")
		local dL = dq("UIListLayout")
		local dM = dq("UIPadding")
		local dN = dq("Frame")
		local dO = dq("UICorner")
		dD.Name = _CONFIGS.UI_NAME
		dD.Parent = b.CoreGui
		dE.Name = "Main"
		dE.Parent = dD
		dE.BackgroundColor3 = dp(52, 62, 72)
		dE.BorderSizePixel = 0
		dE.Position = dn(0.5, 0, 0.5, 0)
		dE.Size = dn(0, 448, 0, 280)
		dE.AnchorPoint = Vector2.new(0.5, 0.5)
		dE.Active = true
		dE.Draggable = true
		dF.CornerRadius = dm(0, 6)
		dF.Name = "MainCorner"
		dF.Parent = dE
		dG.Parent = dE
		dG.BackgroundColor3 = dp(58, 69, 80)
		dG.BorderSizePixel = 0
		dG.Position = dn(0, 6, 0, 6)
		dG.Size = dn(0, 436, 0, 24)
		dG.Font = Enum.Font.GothamBold
		dG.Text = "  " .. _CONFIGS.UI_NAME;
		dG.TextColor3 = dp(255, 255, 255)
		dG.TextSize = 14.000
		dG.TextXAlignment = Enum.TextXAlignment.Left
		Open.Name = "Open"
		Open.Parent = dD
		Open.BackgroundColor3 = dE.BackgroundColor3;
		Open.Position = UDim2.new(0.839879155, 0, - 0.0123076923, 0)
		Open.BorderSizePixel = 2
		Open.BorderColor3 = dG.BackgroundColor3
		Open.Size = UDim2.new(0, 55, 0, 25)
		Open.Font = Enum.Font.SourceSans
		Open.Text = "隐藏"
		Open.TextColor3 = Color3.fromRGB(255, 255, 255)
		Open.TextSize = 14.000
		Open.Active = true
		Open.Draggable = true
		local TOGGLE = true;
		Open.MouseButton1Down:connect(function()
			TOGGLE = not TOGGLE
			dE.Visible = TOGGLE
			Open.Text = (TOGGLE and "隐藏" or "打开");
		end)
		dH.CornerRadius = dm(0, 6)
		dH.Name = "TextLabelCorner"
		dH.Parent = dG
		dI.Name = "Sidebar"
		dI.Parent = dE
		dI.BackgroundColor3 = dp(58, 69, 80)
		dI.BorderSizePixel = 0
		dI.Position = dn(0, 6, 0, 36)
		dI.Size = dn(0, 106, 0, 238)
		dJ.CornerRadius = dm(0, 6)
		dJ.Name = "SidebarCorner"
		dJ.Parent = dI
		dK.Name = "TabButtons"
		dK.Parent = dI
		dK.Active = true
		dK.BackgroundColor3 = dp(255, 255, 255)
		dK.BackgroundTransparency = 1.000
		dK.BorderSizePixel = 0
		dK.Size = dn(0, 106, 0, 238)
		dK.ScrollBarThickness = 0
		dL.Parent = dK
		dL.HorizontalAlignment = Enum.HorizontalAlignment.Center
		dL.SortOrder = Enum.SortOrder.LayoutOrder
		dL.Padding = dm(0, 5)
		dM.Parent = dK
		dM.PaddingTop = dm(0, 6)
		dN.Name = "TabHolder"
		dN.Parent = dE
		dN.BackgroundColor3 = dp(58, 69, 80)
		dN.BorderSizePixel = 0
		dN.Position = dn(0, 118, 0, 36)
		dN.Size = dn(0, 324, 0, 238)
		dO.CornerRadius = dm(0, 6)
		dO.Name = "TabHolderCorner"
		dO.Parent = dN
		dL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
	function()
			dK.CanvasSize = dn(0, 0, 0, dL.AbsoluteContentSize.Y + 12)
		end)
		function createBaseNotifications()
			if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("NotificationHolder") then
				return game:GetService("Players").LocalPlayer.PlayerGui.NotificationHolder
			end
			local ScreenGui = Instance.new("ScreenGui")
			ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			local ToggleNotif = Instance.new("Frame")
			ToggleNotif.Name = "ToggleNotif"
			ToggleNotif.ZIndex = 5
			ToggleNotif.AnchorPoint = Vector2.new(1, 1)
			ToggleNotif.Visible = false
			ToggleNotif.Size = UDim2.new(0, 291, 0, 56)
			ToggleNotif.Position = UDim2.new(1, 0, 1, 0)
			ToggleNotif.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
			ToggleNotif.Parent = ScreenGui
			local UiCorner = Instance.new("UICorner")
			UiCorner.Name = "UiCorner"
			UiCorner.Parent = ToggleNotif
			local Dropshadow = Instance.new("UIStroke")
			Dropshadow.Name = "Dropshadow"
			Dropshadow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			Dropshadow.Transparency = 0.8
			Dropshadow.Thickness = 2
			Dropshadow.Color = Color3.fromRGB(20, 20, 20)
			Dropshadow.Parent = ToggleNotif
			local SepVertical = Instance.new("Frame")
			SepVertical.Name = "SepVertical"
			SepVertical.Size = UDim2.new(0, 2, 0, 56)
			SepVertical.BackgroundTransparency = 0.5
			SepVertical.Position = UDim2.new(0.7423077, 0, 0, 0)
			SepVertical.BorderSizePixel = 0
			SepVertical.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
			SepVertical.Parent = ToggleNotif
			local SepHorizontal = Instance.new("Frame")
			SepHorizontal.Name = "SepHorizontal"
			SepHorizontal.Size = UDim2.new(0, 72, 0, 2)
			SepHorizontal.BackgroundTransparency = 0.5
			SepHorizontal.Position = UDim2.new(0.75, 0, 0.4464286, 2)
			SepHorizontal.BorderSizePixel = 0
			SepHorizontal.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
			SepHorizontal.Parent = ToggleNotif
			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.Size = UDim2.new(0, 216, 0, 19)
			Title.BackgroundTransparency = 1
			Title.BorderSizePixel = 0
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.FontSize = Enum.FontSize.Size14
			Title.TextSize = 14
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.Font = Enum.Font.SourceSans
			Title.Parent = ToggleNotif
			local Paragraph = Instance.new("TextLabel")
			Paragraph.Name = "Paragraph"
			Paragraph.Size = UDim2.new(0, 218, 0, 37)
			Paragraph.BackgroundTransparency = 1
			Paragraph.Position = UDim2.new(0, 0, 0.3392857, 0)
			Paragraph.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Paragraph.FontSize = Enum.FontSize.Size14
			Paragraph.TextSize = 14
			Paragraph.TextColor3 = Color3.fromRGB(255, 255, 255)
			Paragraph.Text = ""
			Paragraph.TextYAlignment = Enum.TextYAlignment.Top
			Paragraph.TextWrapped = true
			Paragraph.Font = Enum.Font.SourceSans
			Paragraph.TextWrap = true
			Paragraph.TextXAlignment = Enum.TextXAlignment.Left
			Paragraph.Parent = ToggleNotif
			local UIPadding = Instance.new("UIPadding")
			UIPadding.PaddingLeft = UDim.new(0, 10)
			UIPadding.PaddingRight = UDim.new(0, 5)
			UIPadding.Parent = Paragraph
			local True = Instance.new("TextButton")
			True.Name = "True"
			True.Size = UDim2.new(0, 72, 0, 27)
			True.BackgroundTransparency = 1
			True.Position = UDim2.new(0.75, 0, 0, 0)
			True.BorderSizePixel = 0
			True.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			True.FontSize = Enum.FontSize.Size14
			True.TextSize = 14
			True.TextColor3 = Color3.fromRGB(255, 255, 255)
			True.Text = "Yes"
			True.Font = Enum.Font.SourceSans
			True.Parent = ToggleNotif
			local False = Instance.new("TextButton")
			False.Name = "False"
			False.Size = UDim2.new(0, 72, 0, 27)
			False.BackgroundTransparency = 1
			False.Position = UDim2.new(0.75, 0, 0.5178571, 0)
			False.BorderSizePixel = 0
			False.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			False.FontSize = Enum.FontSize.Size14
			False.TextSize = 14
			False.TextColor3 = Color3.fromRGB(255, 255, 255)
			False.Text = "No"
			False.Font = Enum.Font.SourceSans
			False.Parent = ToggleNotif
			local LocalScript = Instance.new("LocalScript")
			LocalScript.Parent = ScreenGui
			local DefaultNotif = Instance.new("Frame")
			DefaultNotif.Name = "DefaultNotif"
			DefaultNotif.ZIndex = 5
			DefaultNotif.AnchorPoint = Vector2.new(1, 1)
			DefaultNotif.Visible = false
			DefaultNotif.Size = UDim2.new(0, 291, 0, 56)
			DefaultNotif.Position = UDim2.new(1, 0, 0.9999999, 0)
			DefaultNotif.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
			DefaultNotif.Parent = ScreenGui
			local UiCorner1 = Instance.new("UICorner")
			UiCorner1.Name = "UiCorner"
			UiCorner1.Parent = DefaultNotif
			local Dropshadow1 = Instance.new("UIStroke")
			Dropshadow1.Name = "Dropshadow"
			Dropshadow1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			Dropshadow1.Transparency = 0.8
			Dropshadow1.Thickness = 2
			Dropshadow1.Color = Color3.fromRGB(20, 20, 20)
			Dropshadow1.Parent = DefaultNotif
			local Title1 = Instance.new("TextLabel")
			Title1.Name = "Title"
			Title1.Size = UDim2.new(0, 291, 0, 19)
			Title1.BackgroundTransparency = 1
			Title1.BorderSizePixel = 0
			Title1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title1.FontSize = Enum.FontSize.Size14
			Title1.TextSize = 14
			Title1.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title1.Font = Enum.Font.SourceSans
			Title1.Parent = DefaultNotif
			local Paragraph1 = Instance.new("TextLabel")
			Paragraph1.Name = "Paragraph"
			Paragraph1.Size = UDim2.new(0, 291, 0, 37)
			Paragraph1.BackgroundTransparency = 1
			Paragraph1.Position = UDim2.new(0, 0, 0.3392857, 0)
			Paragraph1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Paragraph1.FontSize = Enum.FontSize.Size14
			Paragraph1.TextSize = 14
			Paragraph1.TextColor3 = Color3.fromRGB(255, 255, 255)
			Paragraph1.Text = ""
			Paragraph1.TextYAlignment = Enum.TextYAlignment.Top
			Paragraph1.TextWrapped = true
			Paragraph1.Font = Enum.Font.SourceSans
			Paragraph1.TextWrap = true
			Paragraph1.TextXAlignment = Enum.TextXAlignment.Left
			Paragraph1.Parent = DefaultNotif
			local UIPadding1 = Instance.new("UIPadding")
			UIPadding1.PaddingLeft = UDim.new(0, 10)
			UIPadding1.PaddingRight = UDim.new(0, 5)
			UIPadding1.Parent = Paragraph1
			if syn then
				syn.protect_gui(ScreenGui)
			end
			ScreenGui.Parent = game:GetService("Players").LocalPlayer.PlayerGui
			return ScreenGui
		end
		notificationHolder = createBaseNotifications()
		notifAmount = 0
		removedPos = nil
		function library:SelectNotify(args)
			args = args or {}
			args.TweenSpeed = args.TweenSpeed or 1
			args.TweenInSpeed = args.TweenInSpeed or args.TweenSpeed
			args.TweenOutSpeed = args.TweenOutSpeed or args.TweenSpeed
			args.TweenVerticalSpeed = args.TweenVerticalSpeed or args.TweenSpeed
			args.Title = args.Title or "Title"
			args.Text = args.Text or "Text"
			args.TrueText = args.TrueText or "Yes"
			args.FalseText = args.FalseText or "No"
			args.Duration = args.Duration or 5
			args.Callback = args.Callback or function()
				warn("No callback for notif")
			end
		
		---- arg defining ^
			notifAmount = notifAmount + 1
			local track = notifAmount
			local notifNum = notifAmount
			local doesExist = true
			local notif = notificationHolder.ToggleNotif:Clone()
			local removed = false
			notif.Parent = notificationHolder
			notif.Visible = true
			notif.Position = UDim2.new(1, 300, 1, - 5)
			notif.Transparency = 0.05
			notif.True.Text = args.TrueText
			notif.False.Text = args.FalseText
			task.spawn(function()
				task.wait(args.Duration + args.TweenInSpeed)
				doesExist = false
			end)
			notif.True.MouseButton1Click:Connect(function()
				doesExist = false
				removed = true
				notifAmount = notifAmount - 1
				removedPos = notif.Position.Y.Offset
				pcall(args.Callback, true)
			end)
			notif.False.MouseButton1Click:Connect(function()
				doesExist = false
				removed = true
				notifAmount = notifAmount - 1
				removedPos = notif.Position.Y.Offset
				pcall(args.Callback, false)
			end)
			notif.Paragraph.Text = args.Text
			notif.Title.Text = args.Title
			notif:TweenPosition(UDim2.new(1, - 5, 1, - 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, args.TweenInSpeed)
			task.spawn(function()
				local originalPos = notif.Position
				while doesExist and task.wait() do
					local pos = notif.Position
					if notifAmount > track then
						notif:TweenPosition(UDim2.new(1, - 5, 1, originalPos.Y.Offset - (65 * (notifAmount - notifNum))), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, args.TweenVerticalSpeed, true)
						track = track + 1
					end
					if notifAmount < track then
						if removedPos > pos.Y.Offset then
							notif:TweenPosition(UDim2.new(1, - 5, 1, originalPos.Y.Offset - (65 * (notifAmount - notifNum))), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, args.TweenVerticalSpeed, true)
						else
							notifNum = notifNum - 1
						end
						track = track - 1
					end
				end
				local pos = notif.Position
				if removed == false then
					notifAmount = notifAmount - 1
					removedPos = notif.Position.Y.Offset
				end
				notif:TweenPosition(UDim2.new(1, 300, 1, pos.Y.Offset), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, args.TweenOutSpeed, true)
				task.wait(args.TweenOutSpeed)
				notif:Destroy()
			end)
		end
		function library:Notify(args)
			args = args or {}
			args.TweenSpeed = args.TweenSpeed or 1
			args.TweenInSpeed = args.TweenInSpeed or args.TweenSpeed
			args.TweenOutSpeed = args.TweenOutSpeed or args.TweenSpeed
			args.TweenVerticalSpeed = args.TweenVerticalSpeed or args.TweenSpeed
			args.Title = args.Title or "Title"
			args.Text = args.Text or "Text"
			args.Duration = args.Duration or 5
		
		---- arg defining ^
			notifAmount = notifAmount + 1
			local track = notifAmount
			local notifNum = notifAmount
			local removed = false
			local doesExist = true
			local notif = notificationHolder.DefaultNotif:Clone()
			notif.Parent = notificationHolder
			notif.Visible = true
			notif.Position = UDim2.new(1, 300, 1, - 5)
			notif.Transparency = 0.05
			notif.InputBegan:Connect(function(InputObject)
				if InputObject.UserInputType == Enum.UserInputType.MouseButton1 then
					task.spawn(function()
						local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
						game:GetService("TweenService"):Create(notif, tweenInfo, {
							Transparency = 0.8
						}):Play()
					end)
					doesExist = false
					removed = true
					notifAmount = notifAmount - 1
					removedPos = notif.Position.Y.Offset
				end
			end)
			task.spawn(function()
				task.wait(args.Duration + args.TweenInSpeed)
				doesExist = false
			end)
			notif.Paragraph.Text = args.Text
			notif.Title.Text = args.Title
			notif:TweenPosition(UDim2.new(1, - 5, 1, - 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, args.TweenInSpeed)
			task.spawn(function()
				local originalPos = notif.Position
				while doesExist and task.wait() do
					local pos = notif.Position
					if notifAmount > track then
						notif:TweenPosition(UDim2.new(1, - 5, 1, originalPos.Y.Offset - (65 * (notifAmount - notifNum))), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, args.TweenVerticalSpeed, true)
						track = track + 1
					end
					if notifAmount < track then
						if removedPos > pos.Y.Offset then
							notif:TweenPosition(UDim2.new(1, - 5, 1, originalPos.Y.Offset - (65 * (notifAmount - notifNum))), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, args.TweenVerticalSpeed, true)
						else
							notifNum = notifNum - 1
						end
						track = track - 1
					end
				end
				local pos = notif.Position
				if removed == false then
					notifAmount = notifAmount - 1
					removedPos = notif.Position.Y.Offset
				end
				notif:TweenPosition(UDim2.new(1, 300, 1, pos.Y.Offset), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, args.TweenOutSpeed, true)
				task.wait(args.TweenOutSpeed)
				notif:Destroy()
			end)
		end
		function library:CreateTab(dZ)
			local d_ = dq("TextButton")
			local e0 = dq("UICorner")
			local e1 = dq("Frame")
			local e2 = dq("UICorner")
			local e3 = dq("UIGradient")
			local e4 = dq("ScrollingFrame")
			local e5 = dq("UIPadding")
			local e6 = dq("UIListLayout")
			d_.Name = "TabButton"
			d_.Parent = dK
			d_.BackgroundColor3 = dp(52, 62, 72)
			d_.BorderSizePixel = 0
			d_.Size = dn(0, 94, 0, 28)
			d_.AutoButtonColor = false
			d_.Font = Enum.Font.GothamSemibold
			d_.Text = dZ
			d_.TextColor3 = dp(255, 255, 255)
			d_.TextSize = 14.000
			e0.CornerRadius = dm(0, 6)
			e0.Name = "TabButtonCorner"
			e0.Parent = d_
			e1.Name = "Glow"
			e1.Parent = d_
			e1.BackgroundColor3 = dp(255, 255, 255)
			e1.BorderSizePixel = 0
			e1.Position = dn(0, 0, 0.928571463, 0)
			e1.Size = dn(0, 94, 0, 2)
			e1.Transparency = 1
			e2.CornerRadius = dm(0, 6)
			e2.Name = "GlowCorner"
			e2.Parent = e1
			e3.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0.00, dp(52, 62, 72)),
				ColorSequenceKeypoint.new(0.50, dp(255, 255, 255)),
				ColorSequenceKeypoint.new(1.00, dp(52, 62, 72))
			}
			e3.Name = "GlowGradient"
			e3.Parent = e1
			e4.Name = "Tab"
			e4.Parent = dN
			e4.Active = true
			e4.BackgroundColor3 = dp(255, 255, 255)
			e4.BackgroundTransparency = 1.000
			e4.BorderSizePixel = 0
			e4.Size = dn(0, 324, 0, 238)
			e4.ScrollBarThickness = 0
			e4.Visible = false
			if library.currentTab == nil then
				library.currentTab = {
					e4,
					d_
				}
				e1.Transparency = 0
				e4.Visible = true
			end
			e5.Name = "TabPadding"
			e5.Parent = e4
			e5.PaddingTop = dm(0, 6)
			e6.Name = "TabLayout"
			e6.Parent = e4
			e6.HorizontalAlignment = Enum.HorizontalAlignment.Center
			e6.SortOrder = Enum.SortOrder.LayoutOrder
			e6.Padding = dm(0, 5)
			e6:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
	function()
				e4.CanvasSize = dn(0, 0, 0, e6.AbsoluteContentSize.Y + 12)
			end)
			d_.MouseButton1Click:Connect(
	function()
				dv:SwitchTab({
					e4,
					d_
				})
			end)
			local e7 = {}
			function e7:NewSeparator()
				local e8 = dq("Frame")
				e8.Transparency = 1
				e8.Size = dn(0, 0, 0, 0)
				e8.BorderSizePixel = 0
				e8.Parent = e4
			end
			function e7:NewButton(e9, ea)
				local ea = ea or dr
				local eb = dq("TextButton")
				local ec = dq("UICorner")
				eb.Name = "BtnModule"
				eb.Parent = e4
				eb.BackgroundColor3 = dp(52, 62, 72)
				eb.BorderSizePixel = 0
				eb.Size = dn(0, 312, 0, 28)
				eb.AutoButtonColor = false
				eb.Font = Enum.Font.GothamSemibold
				eb.Text = "  " .. e9
				eb.TextColor3 = dp(255, 255, 255)
				eb.TextSize = 14.000
				eb.TextXAlignment = Enum.TextXAlignment.Left
				ec.CornerRadius = dm(0, 6)
				ec.Name = "BtnModuleCorner"
				ec.Parent = eb
				eb.MouseButton1Click:Connect(ea)
			end
			function e7:NewToggle(e9, du, ed, ea)
				local ea = ea or dr
				local ed = ed or false
				local ee = dq("TextButton")
				local ef = dq("UICorner")
				local eg = dq("Frame")
				local eh = dq("UIGradient")
				local ei = dq("UICorner")
				local ej = dq("Frame")
				local ek = dq("UICorner")
				local el = dq("UIGradient")
				library.flags[du or e9] = {
					State = false,
					Callback = ea,
					SetState = function(self, be)
						local be = be ~= nil and be or not library.flags:GetState(du)
						library.flags[du].State = be
						task.spawn(
	            function()
							library.flags[du].Callback(be)
						end)
						dv:Tween({
							Transparency = be and 1 or 0
						}, eg):Play()
						dv:Tween({
							Transparency = be and 0 or 1
						}, ej):Play()
					end
				}
				ee.Name = "ToggleModule"
				ee.Parent = e4
				ee.BackgroundColor3 = dp(52, 62, 72)
				ee.BorderSizePixel = 0
				ee.Size = dn(0, 312, 0, 28)
				ee.AutoButtonColor = false
				ee.Font = Enum.Font.GothamSemibold
				ee.Text = "  " .. e9
				ee.TextColor3 = dp(255, 255, 255)
				ee.TextSize = 14.000
				ee.TextXAlignment = Enum.TextXAlignment.Left
				ef.CornerRadius = dm(0, 6)
				ef.Name = "ToggleModuleCorner"
				ef.Parent = ee
				eg.Name = "OffStatus"
				eg.Parent = ee
				eg.BackgroundColor3 = dp(255, 255, 255)
				eg.BorderSizePixel = 0
				eg.Position = dn(0.878205061, 0, 0.178571433, 0)
				eg.Size = dn(0, 34, 0, 18)
				eh.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0.00, dp(255, 83, 83)),
					ColorSequenceKeypoint.new(0.15, dp(255, 83, 83)),
					ColorSequenceKeypoint.new(0.62, dp(52, 62, 72)),
					ColorSequenceKeypoint.new(1.00, dp(52, 62, 72))
				}
				eh.Rotation = 300
				eh.Name = "OffGrad"
				eh.Parent = eg
				ei.CornerRadius = dm(0, 4)
				ei.Name = "OffStatusCorner"
				ei.Parent = eg
				ej.Name = "OnStatus"
				ej.Parent = ee
				ej.BackgroundColor3 = dp(255, 255, 255)
				ej.BackgroundTransparency = 1.000
				ej.BorderSizePixel = 0
				ej.Position = dn(0.878205121, 0, 0.178571433, 0)
				ej.Size = dn(0, 34, 0, 18)
				ej.Transparency = 1
				ek.CornerRadius = dm(0, 4)
				ek.Name = "OnStatusCorner"
				ek.Parent = ej
				el.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0.00, dp(52, 62, 72)),
					ColorSequenceKeypoint.new(0.38, dp(48, 57, 67)),
					ColorSequenceKeypoint.new(1.00, dp(53, 255, 134))
				}
				el.Rotation = 300
				el.Name = "OnGrad"
				el.Parent = ej
				ee.MouseButton1Click:Connect(
	    function()
					library.flags[du or e9]:SetState()
				end)
				if ed then
					library.flags[du or e9]:SetState(ed)
				end
			end
			function e7:NewBind(e9, em, ea)
				local em = Enum.KeyCode[em]
				local en = {
					Return = true,
					Space = true,
					Tab = true,
					Backquote = true,
					CapsLock = true,
					Escape = true,
					Unknown = true
				}
				local eo = {
					RightControl = "Right Ctrl",
					LeftControl = "Left Ctrl",
					LeftShift = "Left Shift",
					RightShift = "Right Shift",
					Semicolon = ";",
					Quote = '"',
					LeftBracket = "[",
					RightBracket = "]",
					Equals = "=",
					Minus = "-",
					RightAlt = "Right Alt",
					LeftAlt = "Left Alt"
				}
				local ep = em
				local eq = em and (eo[em.Name] or em.Name) or "None"
				local er = dq("TextButton")
				local es = dq("UICorner")
				local et = dq("TextButton")
				local eu = dq("UICorner")
				er.Name = "KeybindModule"
				er.Parent = e4
				er.BackgroundColor3 = dp(52, 62, 72)
				er.BorderSizePixel = 0
				er.Size = dn(0, 312, 0, 28)
				er.AutoButtonColor = false
				er.Font = Enum.Font.GothamSemibold
				er.Text = "  " .. e9
				er.TextColor3 = dp(255, 255, 255)
				er.TextSize = 14.000
				er.TextXAlignment = Enum.TextXAlignment.Left
				es.CornerRadius = dm(0, 6)
				es.Name = "KeybindModuleCorner"
				es.Parent = er
				et.Name = "KeybindValue"
				et.Parent = er
				et.BackgroundColor3 = dp(58, 69, 80)
				et.BorderSizePixel = 0
				et.Position = dn(0.75, 0, 0.178571433, 0)
				et.Size = dn(0, 74, 0, 18)
				et.AutoButtonColor = false
				et.Font = Enum.Font.Gotham
				et.Text = eq
				et.TextColor3 = dp(255, 255, 255)
				et.TextSize = 12.000
				eu.CornerRadius = dm(0, 4)
				eu.Name = "KeybindValueCorner"
				eu.Parent = et
				b.UserInputService.InputBegan:Connect(
	    function(aJ, aK)
					if aK then
						return
					end
					if aJ.UserInputType ~= Enum.UserInputType.Keyboard then
						return
					end
					if aJ.KeyCode ~= ep then
						return
					end
					ea(ep.Name)
				end)
				et.MouseButton1Click:Connect(
	    function()
					et.Text = "..."
					wait()
					local ev, ew = b.UserInputService.InputEnded:Wait()
					local ex = tostring(ev.KeyCode.Name)
					if ev.UserInputType ~= Enum.UserInputType.Keyboard then
						et.Text = eq
						return
					end
					if en[ex] then
						et.Text = eq
						return
					end
					wait()
					ep = Enum.KeyCode[ex]
					et.Text = eo[ex] or ex
				end)
			end
			function e7:NewSlider(e9, du, em, ey, ez, eA, ea)
				local em = em or ey
				local ea = ea or dr
				local eB = dq("TextButton")
				local eC = dq("UICorner")
				local eD = dq("Frame")
				local eE = dq("UICorner")
				local eF = dq("Frame")
				local eG = dq("UICorner")
				local eH = dq("TextBox")
				local eI = dq("UICorner")
				local eJ = dq("TextButton")
				local eK = dq("TextButton")
				library.flags[du] = {
					State = em,
					SetValue = function(self, be)
						local eL = (ds.X - eD.AbsolutePosition.X) / eD.AbsoluteSize.X
						if be then
							eL = (be - ey) / (ez - ey)
						end
						eL = math.clamp(eL, 0, 1)
						if eA then
							be = be or tonumber(string.format("%.1f", tostring(ey + (ez - ey) * eL)))
						else
							be = be or math.floor(ey + (ez - ey) * eL)
						end
						library.flags[du].State = tonumber(be)
						eH.Text = tostring(be)
						eF.Size = dn(eL, 0, 1, 0)
						ea(tonumber(be))
					end
				}
				eB.Name = "SliderModule"
				eB.Parent = e4
				eB.BackgroundColor3 = dp(52, 62, 72)
				eB.BorderSizePixel = 0
				eB.Position = dn(0, 0, - 0.140425533, 0)
				eB.Size = dn(0, 312, 0, 28)
				eB.AutoButtonColor = false
				eB.Font = Enum.Font.GothamSemibold
				eB.Text = "  " .. e9
				eB.TextColor3 = dp(255, 255, 255)
				eB.TextSize = 14.000
				eB.TextXAlignment = Enum.TextXAlignment.Left
				eC.CornerRadius = dm(0, 6)
				eC.Name = "SliderModuleCorner"
				eC.Parent = eB
				eD.Name = "SliderBar"
				eD.Parent = eB
				eD.BackgroundColor3 = dp(58, 69, 80)
				eD.BorderSizePixel = 0
				eD.Position = dn(0.442307681, 0, 0.392857134, 0)
				eD.Size = dn(0, 108, 0, 6)
				eE.CornerRadius = dm(0, 2)
				eE.Name = "SliderBarCorner"
				eE.Parent = eD
				eF.Name = "SliderPart"
				eF.Parent = eD
				eF.BackgroundColor3 = dp(255, 255, 255)
				eF.BorderSizePixel = 0
				eF.Size = dn(0, 0, 0, 6)
				eG.CornerRadius = dm(0, 2)
				eG.Name = "SliderPartCorner"
				eG.Parent = eF
				eH.Name = "SliderValue"
				eH.Parent = eB
				eH.BackgroundColor3 = dp(58, 69, 80)
				eH.BorderSizePixel = 0
				eH.Position = dn(0.884615362, 0, 0.178571433, 0)
				eH.Size = dn(0, 32, 0, 18)
				eH.Font = Enum.Font.Gotham
				eH.Text = em or ey
				eH.TextColor3 = dp(255, 255, 255)
				eH.TextSize = 12.000
				eI.CornerRadius = dm(0, 4)
				eI.Name = "SliderValueCorner"
				eI.Parent = eH
				eJ.Name = "AddSlider"
				eJ.Parent = eB
				eJ.BackgroundColor3 = dp(255, 255, 255)
				eJ.BackgroundTransparency = 1.000
				eJ.BorderSizePixel = 0
				eJ.Position = dn(0.807692289, 0, 0.178571433, 0)
				eJ.Size = dn(0, 18, 0, 18)
				eJ.Font = Enum.Font.Gotham
				eJ.Text = "+"
				eJ.TextColor3 = dp(255, 255, 255)
				eJ.TextSize = 18.000
				eK.Name = "MinusSlider"
				eK.Parent = eB
				eK.BackgroundColor3 = dp(255, 255, 255)
				eK.BackgroundTransparency = 1.000
				eK.BorderSizePixel = 0
				eK.Position = dn(0.365384609, 0, 0.178571433, 0)
				eK.Size = dn(0, 18, 0, 18)
				eK.Font = Enum.Font.Gotham
				eK.Text = "-"
				eK.TextColor3 = dp(255, 255, 255)
				eK.TextSize = 18.000
				eK.MouseButton1Click:Connect(
	    function()
					local eM = library.flags:GetState(du)
					eM = math.clamp(eM - 1, ey, ez)
					library.flags[du]:SetValue(eM)
				end)
				eJ.MouseButton1Click:Connect(
	    function()
					local eM = library.flags:GetState(du)
					eM = math.clamp(eM + 1, ey, ez)
					library.flags[du]:SetValue(eM)
				end)
				library.flags[du]:SetValue(em)
				local dS, eN, eO = false, false, {
					[""] = true,
					["-"] = true
				}
				eD.InputBegan:Connect(
	    function(dX)
					if dX.UserInputType == Enum.UserInputType.MouseButton1 or dX.UserInputType == Enum.UserInputType.Touch then
						library.flags[du]:SetValue()
						dS = true
					end
				end)
				b.UserInputService.InputEnded:Connect(
	    function(dX)
					if dS and dX.UserInputType == Enum.UserInputType.MouseButton1 or dX.UserInputType == Enum.UserInputType.Touch then
						dS = false
					end
				end)
				b.UserInputService.InputChanged:Connect(
	    function(dX)
					if dS == true then
						library.flags[du]:SetValue()
					end
				end)
				eH.Focused:Connect(
	    function()
					eN = true
				end)
				eH.FocusLost:Connect(
	    function()
					eN = false
					if eH.Text == "" then
						library.flags[du]:SetValue(em)
					end
				end)
				eH:GetPropertyChangedSignal("Text"):Connect(
	    function()
					if not eN then
						return
					end
					eH.Text = eH.Text:gsub("%D+", "")
					local e9 = eH.Text
					if not tonumber(e9) then
						eH.Text = eH.Text:gsub("%D+", "")
					elseif not eO[e9] then
						if tonumber(e9) > ez then
							e9 = ez
							eH.Text = tostring(ez)
						end
						library.flags[du]:SetValue(tonumber(e9))
					end
				end)
			end
			function e7:NewDropdown(e9, du, eP, ea)
				local ea = ea or dr
				library.flags[du] = {
					State = eP[1]
				}
				local eQ = dq("TextButton")
				local eR = dq("UICorner")
				local eS = dq("TextBox")
				local eT = dq("TextButton")
				local eU = dq("TextButton")
				local eV = dq("UICorner")
				local eW = dq("UIListLayout")
				local eX = dq("UIPadding")
				eQ.Name = "DropdownModule"
				eQ.Parent = e4
				eQ.BackgroundColor3 = dp(52, 62, 72)
				eQ.BorderSizePixel = 0
				eQ.Size = dn(0, 312, 0, 28)
				eQ.AutoButtonColor = false
				eQ.Font = Enum.Font.GothamSemibold
				eQ.Text = ""
				eQ.TextColor3 = dp(255, 255, 255)
				eQ.TextSize = 14.000
				eQ.TextXAlignment = Enum.TextXAlignment.Left
				eR.CornerRadius = dm(0, 6)
				eR.Name = "DropdownModuleCorner"
				eR.Parent = eQ
				eS.Name = "DropdownText"
				eS.Parent = eQ
				eS.BackgroundColor3 = dp(255, 255, 255)
				eS.BackgroundTransparency = 1.000
				eS.Position = dn(0.025641026, 0, 0, 0)
				eS.Size = dn(0, 192, 0, 28)
				eS.Font = Enum.Font.GothamSemibold
				eS.PlaceholderText = e9
				eS.PlaceholderColor3 = dp(255, 255, 255)
				eS.TextColor3 = dp(255, 255, 255)
				eS.TextSize = 14.000
				eS.TextXAlignment = Enum.TextXAlignment.Left
				eS.Text = ""
				eT.Name = "OpenDropdown"
				eT.Parent = eQ
				eT.BackgroundColor3 = dp(255, 255, 255)
				eT.BackgroundTransparency = 1.000
				eT.BorderSizePixel = 0
				eT.Position = dn(0.907051265, 0, 0.178571433, 0)
				eT.Size = dn(0, 18, 0, 18)
				eT.Font = Enum.Font.Gotham
				eT.Text = "+"
				eT.TextColor3 = dp(255, 255, 255)
				eT.TextSize = 22.000
				eU.Name = "DropdownBottom"
				eU.Parent = e4
				eU.BackgroundColor3 = dp(52, 62, 72)
				eU.BorderSizePixel = 0
				eU.ClipsDescendants = true
				eU.Position = dn(0.0185185187, 0, 0.206896558, 0)
				eU.Size = dn(0, 312, 0, 0)
				eU.AutoButtonColor = false
				eU.Font = Enum.Font.GothamSemibold
				eU.Text = ""
				eU.TextColor3 = dp(255, 255, 255)
				eU.TextSize = 14.000
				eU.TextXAlignment = Enum.TextXAlignment.Left
				eU.Visible = false
				eV.CornerRadius = dm(0, 6)
				eV.Name = "DropdownBottomCorner"
				eV.Parent = eU
				eW.Name = "DropdownBottomLayout"
				eW.Parent = eU
				eW.HorizontalAlignment = Enum.HorizontalAlignment.Center
				eW.SortOrder = Enum.SortOrder.LayoutOrder
				eW.Padding = dm(0, 6)
				eX.Name = "DropdownBottomPadding"
				eX.Parent = eU
				eX.PaddingTop = dm(0, 6)
				local eY = false
				eW:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
	            function()
					if not eY then
						return
					end
					dv:Tween({
						Size = dn(0, 312, 0, eW.AbsoluteContentSize.Y + 12)
					}, eU, 0.1):Play()
				end)
				local eZ = function()
					local NewValue = eS.Text			
					for _, Element in next, eU:GetChildren() do
						if Element:IsA("TextButton") then
							if string.find(Element.Name:lower(), NewValue:lower()) then
								Element.Visible = true
							else
								Element.Visible = false
							end
						end
					end
				end
				local e_ = function(e9)
					local eP = eU:GetChildren()
					for ai = 1, # eP do
						local bd = eP[ai]
						if e9 == "" then
							eZ()
						else
							if bd:IsA("TextButton") then
								if bd.Name:lower():sub(1, string.len(e9)) == e9:lower() then
									bd.Visible = true
								else
									bd.Visible = false
								end
							end
						end
					end
				end
				local f0 = function()
					eY = not eY
					if eY then
						eU.Visible = true
						eZ()
					else
						task.spawn(
	                    function()
							task.wait(0.35)
							eU.Visible = false
						end)
					end
					eT.Text = eY and "-" or "+"
					dv:Tween({
						Size = dn(0, 312, 0, eY and eW.AbsoluteContentSize.Y + 12 or 0)
					}, eU, 0.35):Play()
				end
				eT.MouseButton1Click:Connect(f0)
				eS.Focused:Connect(
	            function()
					if eY then
						return
					end
					f0()
				end)
				eS:GetPropertyChangedSignal("Text"):Connect(function() -- 改版
					local NewValue = eS.Text			
					for _, Element in next, eU:GetChildren() do
						if Element:IsA("TextButton") then
							if string.find(Element.Name:lower(), NewValue:lower()) then
								Element.Visible = true
							else
								Element.Visible = false
							end
						end
					end
				end)
				library.flags[du].SetOptions = function(self, eP)
					library.flags[du]:ClearOptions()
					for ai = 1, # eP do
						library.flags[du]:AddOption(eP[ai])
					end
				end
				library.flags[du].ClearOptions = function(self)
					local f1 = eU:GetChildren()
					for ai = 1, # f1 do
						local dx = f1[ai]
						if dx:IsA("TextButton") then
							dx:Destroy()
						end
					end
				end
				library.flags[du].AddOption = function(self, bd)
					local f2 = dq("TextButton")
					local f3 = dq("UICorner")
					f2.Name = bd
					f2.Parent = eU
					f2.BackgroundColor3 = dp(58, 69, 80)
					f2.BorderSizePixel = 0
					f2.Size = dn(0, 300, 0, 28)
					f2.AutoButtonColor = false
					f2.Font = Enum.Font.GothamSemibold
					f2.Text = bd
					f2.TextColor3 = dp(255, 255, 255)
					f2.TextSize = 14.000
					f3.CornerRadius = dm(0, 6)
					f3.Name = "OptionCorner"
					f3.Parent = f2
					f2.MouseButton1Click:Connect(
	                function()
						eS.PlaceholderText = bd
						eS.Text = ""
						library.flags[du].State = bd
						task.spawn(f0)
						ea(bd)
					end)
				end
				library.flags[du].RemoveOption = function(self, bd)
					eU:WaitForChild(bd):Destroy()
				end
				library.flags[du]:SetOptions(eP)
			end
			function e7:NewBox(e9, du, ea)
				local ea = ea or dr
				local eB = dq("TextButton")
				local eC = dq("UICorner")
				local eH = dq("TextBox")
				local eI = dq("UICorner")
				eB.Name = "SliderModule"
				eB.Parent = e4
				eB.BackgroundColor3 = dp(52, 62, 72)
				eB.BorderSizePixel = 0
				eB.Position = dn(0, 0, - 0.140425533, 0)
				eB.Size = dn(0, 312, 0, 28)
				eB.AutoButtonColor = false
				eB.Font = Enum.Font.GothamSemibold
				eB.Text = "  " .. e9
				eB.TextColor3 = dp(255, 255, 255)
				eB.TextSize = 14.000
				eB.TextXAlignment = Enum.TextXAlignment.Left
				eC.CornerRadius = dm(0, 6)
				eC.Name = "BoxButtonCorner"
				eC.Parent = eB
				eH.Name = "Box"
				eH.Parent = eB
				eH.BackgroundColor3 = dp(58, 69, 80)
				eH.BorderSizePixel = 0
				eH.Position = dn(0.774615362, 0, 0.178571433, 0)
				eH.Size = dn(0, 65, 0, 18)
				eH.Font = Enum.Font.Gotham
				eH.Text = ""
				eH.PlaceholderText = du
				eH.TextColor3 = dp(255, 255, 255)
				eH.TextSize = 12.000
				eI.CornerRadius = dm(0, 4)
				eI.Name = "BoxCorner"
				eI.Parent = eH
				eH.FocusLost:Connect(
	            function(EnterPressed)
					if not EnterPressed then
						return
					else
						ea(eH.Text)
						if getgenv().ClearTextBoxText then
							wait(0.10)
							eH.Text = ""
						end
					end
				end)
			end
			return e7
		end
		setmetatable(getgenv().library, {
			__newindex = function(self, i, v)
				if i == 'Name' then
					dG.Text = "   " .. v
					return true
				end
				rawset(self, i, v)
			end
		})
		
		
		--<< 游戏功能部分 >>
		
		--↓ 以下请勿修改
	    _CONFIGS["总开关"] = HONG.RS.RenderStepped:Connect(function()
		pcall(function()
			HONG.LP.Character.Humanoid.WalkSpeed = _CONFIGS["步行速度"]
			HONG.LP.Character.Humanoid.JumpPower = _CONFIGS["跳跃力"]
			HONG.LP.Character.Humanoid.HipHeight = _CONFIGS["悬浮高度"]
			HONG.WKSPC.Gravity = _CONFIGS["重力"]
			HONG.LP.CameraMaxZoomDistance = _CONFIGS["相机焦距"]
			HONG.WKSPC.Camera.FieldOfView = _CONFIGS["广角"]
		end)
	end)
	
	
	function HONG:NOTIFY(title, text, duration) --> 通知功能
	    return library:Notify({
	           Title = title, 
	           Text = text,
	           Duration = duration
	       })
	end
	
	--↓ 双引号里面的中文可以修改, 对应的是脚本UI的菜单名字
	local Page1 = library:CreateTab("设置菜单");
	local Page2 = library:CreateTab("玩家菜单");
	local Page3 = library:CreateTab("购买菜单");
	local Page4 = library:CreateTab("木材菜单");
	local Page5 = library:CreateTab("传送菜单");
	local Page6 = library:CreateTab("环境菜单");
	local Page7 = library:CreateTab("基地菜单");
	local Page8 = library:CreateTab("汽车菜单");
	
	
	Page1:NewToggle("防误触", "Mistouch", true, function(v)
	    _CONFIGS["防误触开关"] = v;
	end)
	
	Page1:NewButton("关闭脚本", function()
	    	if _CONFIGS["防误触开关"] == true then
			HONG:SelectNotify("防误触", "确定要关闭脚本吗?", "确定", "取消", 5, function(text) --> 双引号里面的中文可以改
				if text == "确定" then
					xpcall(function()
						for i, v in next, HONG.COREGUI:GetDescendants() do
							if v.Name == _CONFIGS.UI_NAME then
								v:Destroy()
								ClearConfig()
							end
						end
					end, function(err)
						return HONG:printf("错误是:  %s", err)
					end)
					return
				end
				HONG:NOTIFY("通知", "已取消", 4) --> 双引号里面的中文可以改
			end)
			return
		end
		xpcall(function()
			for i, v in next, HONG.COREGUI:GetDescendants() do
				if v.Name == _CONFIGS.UI_NAME then
					v:Destroy()
					ClearConfig()
				end
			end
		end, function(err)
			return HONG:printf("错误是:  %s", err)
		end)
	end)
	
	Page1:NewButton("重进服务器", function()
		if _CONFIGS["防误触开关"] == true then
			HONG:SelectNotify("防误触", "确定要重进服务器吗?", "确定", "取消", 5, function(text) --> 双引号里面的中文可以改
				if text == "确定" then
					xpcall(function()
						HONG:ServiceTP(game.PlaceId)
					end, function(err)
						return HONG:printf("错误是:  %s", err)
					end)
					return
				end
				HONG:NOTIFY("通知", "已取消", 4) --> 双引号里面的中文可以改
			end)
			return
		end
		xpcall(function()
			HONG:ServiceTP(game.PlaceId)
		end, function(err)
			return HONG:printf("错误是:  %s", err)
		end)
	end)
	
	Page1:NewSeparator()
	
	
	Page1:NewButton("脚本作者  紅#0296", function()
		print("感谢 紅")
	end)
	
	
	Page1:NewButton("Woof UI Library  0x37", function()
		print("感谢 Step")
	end)
	
	Page1:NewButton("无眼球砍幻影  cooper#2723", function()
		print("感谢 cooper")
	end)
	
	Page1:NewButton("很多帮助  x**#3797", function()
		print("感谢 x**")
	end)
	
	Page1:NewButton("教学帮助  wYn#0001", function()
		print("感谢 wYn")
	end)
	
	
	Page1:NewButton("最大支持  你们", function()
		print("感谢 你们")
	end)
	
	
	Page2:NewSlider("步行速度", "步行速度slider", 50, 16, 300, false, function(v)
		_CONFIGS["步行速度"] = v;
	end)
	
	Page2:NewSlider("跳跃力", "跳跃力slider", 50, 50, 300, false, function(v)
		_CONFIGS["跳跃力"] = v;
	end)
	
	Page2:NewSlider("飞行速度","飞行速度slider", 4, 1, 100, false, function(v)
		_CONFIGS["飞行速度"] = tonumber(v)
	end)
	
	Page2:NewToggle("飞行", "fly", false, function(bool)
	    _CONFIGS["飞行开关"] = bool
		speeds = _CONFIGS["飞行速度"]
		if _CONFIGS["飞行开关"] == false then
			_CONFIGS["飞行开关"] = true
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, true)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, true)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, true)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, true)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
			HONG.LP.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
		else
			_CONFIGS["飞行开关"] = false
			for i = 1, speeds do
				spawn(
	                function()
					local hb = game:GetService("RunService").Heartbeat
					tpwalking = true
					local chr = HONG.LP.Character
					local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
					while tpwalking and hb:Wait() and chr and hum and hum.Parent do
						if hum.MoveDirection.Magnitude > 0 then
							chr:TranslateBy(hum.MoveDirection)
						end
					end
				end)
			end
			HONG.LP.Character.Animate.Disabled = true
			local Char = HONG.LP.Character
			local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")
			for i, v in next, Hum:GetPlayingAnimationTracks() do
				v:AdjustSpeed(0)
			end
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, false)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, false)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, false)
			HONG.LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
			HONG.LP.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
		end
		if HONG.LP.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
			local torso = HONG.LP.Character.Torso
			local flying = true
			local deb = true
			local ctrl = {
				f = 0,
				b = 0,
				l = 0,
				r = 0
			}
			local lastctrl = {
				f = 0,
				b = 0,
				l = 0,
				r = 0
			}
			local maxspeed = 50
			local speed = 0
			local bg = Instance.new("BodyGyro", torso)
			bg.P = 9e4
			bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
			bg.cframe = torso.CFrame
			local bv = Instance.new("BodyVelocity", torso)
			bv.velocity = Vector3.new(0, 0.1, 0)
			bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
			if _CONFIGS["飞行开关"] == false then
				HONG.LP.Character.Humanoid.PlatformStand = true
			end
			while _CONFIGS["飞行开关"] == false or HONG.LP.Character.Humanoid.Health == 0 do
				game:GetService("RunService").RenderStepped:Wait()
				if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
					speed = speed + .5 + (speed / maxspeed)
					if speed > maxspeed then
						speed = maxspeed
					end
				elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
					speed = speed - 1
					if speed < 0 then
						speed = 0
					end
				end
				if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
					bv.velocity = ((HONG.WKSPC.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f + ctrl.b)) + ((HONG.WKSPC.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * .2, 0).p) - HONG.WKSPC.CurrentCamera.CoordinateFrame.p)) * speed
					lastctrl = {
						f = ctrl.f,
						b = ctrl.b,
						l = ctrl.l,
						r = ctrl.r
					}
				elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
					bv.velocity = ((HONG.WKSPC.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f + lastctrl.b)) + ((HONG.WKSPC.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l + lastctrl.r, (lastctrl.f + lastctrl.b) * .2, 0).p) - HONG.WKSPC.CurrentCamera.CoordinateFrame.p)) * speed
				else
					bv.velocity = Vector3.new(0, 0, 0)
				end
				bg.cframe = HONG.WKSPC.CurrentCamera.CoordinateFrame * CFrame.Angles(- math.rad((ctrl.f + ctrl.b) * 50 * speed / maxspeed), 0, 0)
			end
			ctrl = {
				f = 0,
				b = 0,
				l = 0,
				r = 0
			}
			lastctrl = {
				f = 0,
				b = 0,
				l = 0,
				r = 0
			}
			speed = 0
			bg:Destroy()
			bv:Destroy()
			HONG.LP.Character.Humanoid.PlatformStand = false
			HONG.LP.Character.Animate.Disabled = false
			tpwalking = false
		else
			local UpperTorso = HONG.LP.Character.UpperTorso
			local flying = true
			local deb = true
			local ctrl = {
				f = 0,
				b = 0,
				l = 0,
				r = 0
			}
			local lastctrl = {
				f = 0,
				b = 0,
				l = 0,
				r = 0
			}
			local maxspeed = 50
			local speed = 0
			local bg = Instance.new("BodyGyro", UpperTorso)
			bg.P = 9e4
			bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
			bg.cframe = UpperTorso.CFrame
			local bv = Instance.new("BodyVelocity", UpperTorso)
			bv.velocity = Vector3.new(0, 0.1, 0)
			bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
			if _CONFIGS["飞行开关"] == false then
				HONG.LP.Character.Humanoid.PlatformStand = true
			end
			while _CONFIGS["飞行开关"] == false or HONG.LP.Character.Humanoid.Health == 0 do
				wait()
				if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
					speed = speed + .5 + (speed / maxspeed)
					if speed > maxspeed then
						speed = maxspeed
					end
				elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
					speed = speed - 1
					if speed < 0 then
						speed = 0
					end
				end
				if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
					bv.velocity = ((HONG.WKSPC.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f + ctrl.b)) + ((HONG.WKSPC.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * .2, 0).p) - HONG.WKSPC.CurrentCamera.CoordinateFrame.p)) * speed
					lastctrl = {
						f = ctrl.f,
						b = ctrl.b,
						l = ctrl.l,
						r = ctrl.r
					}
				elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
					bv.velocity = ((HONG.WKSPC.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f + lastctrl.b)) + ((HONG.WKSPC.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l + lastctrl.r, (lastctrl.f + lastctrl.b) * .2, 0).p) - HONG.WKSPC.CurrentCamera.CoordinateFrame.p)) * speed
				else
					bv.velocity = Vector3.new(0, 0, 0)
				end
				bg.cframe = HONG.WKSPC.CurrentCamera.CoordinateFrame * CFrame.Angles(- math.rad((ctrl.f + ctrl.b) * 50 * speed / maxspeed), 0, 0)
			end
			ctrl = {
				f = 0,
				b = 0,
				l = 0,
				r = 0
			}
			lastctrl = {
				f = 0,
				b = 0,
				l = 0,
				r = 0
			}
			speed = 0
			bg:Destroy()
			bv:Destroy()
			HONG.LP.Charactder.Humanoid.PlatformStand = false
			HONG.LP.Character.Animate.Disabled = false
			tpwalking = false
		end
	end)
	
	function togggleInvisible(num)
		for i, v in pairs(HONG.LP.Character:children()) do
			if v:IsA("Accessory") then
				for i, k in pairs(v:children()) do
					if k:IsA("Part") then
						k.Transparency = num
					end
				end
			end
			if v:IsA("Part") and v.Name ~= "HumanoidRootPart" then
				v.Transparency = num;
				if v.Name == "Head" then
					v:FindFirstChild"face".Transparency = num;
				end
			end
		end
	end
	
	Page2:NewSlider("悬浮高度", "悬浮slider", 0, 0, 300, false, function(v)
		_CONFIGS["悬浮高度"] = v;
	end)
	
	Page2:NewSlider("重力", "重力slider", 198, 0, 300, false, function(v)
		_CONFIGS["重力"] = v;
	end)
	
	Page2:NewToggle("无限跳", "toggleInfJump", false, function(bool)
	    _CONFIGS["无限跳"] = bool;
		HONG.GS("UserInputService").JumpRequest:Connect(function()
			if _CONFIGS["无限跳"] == true then
			 --   HONG.WKSPC.Gravity = 198; -- 防止两个都开造成卡顿
				HONG.LP.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
			end
		end)
	end)
	
	Page2:NewToggle("穿墙", "toggleNoclip", false, function(bool)
	    _CONFIGS["穿墙开关"] = bool;
		local IsNoclip = HONG.RS.Stepped:Connect(function()
			for i, v in next, HONG.LP.Character:GetDescendants() do
				if _CONFIGS["穿墙开关"] then
					if v:IsA"BasePart" then
						v.CanCollide = false
					else
						pcall(
	                            function()
							IsNoclip:Disconnect()
							IsNoclip = nil;
						end)
					end
				end
			end
		end)
	end)
	
	Page2:NewButton("安全自杀", function()
	    if not HONG.LP.Character then
			return
		end
		HONG.LP.Character.Head:Destroy()
		_CONFIGS["isBuying"] = false; --> 如果卡在了正在购买, 可以通过自杀来解决
	end)
	
	Page2:NewButton("点击传送 [工具]", function()
	    if HONG.LP.Backpack:FindFirstChild"点击传送" or HONG.LP.Character:FindFirstChild"点击传送" then
			HONG.LP.Backpack["点击传送"]:Destroy()
		end
		local ClickToTeleport = Instance.new("Tool", HONG.LP.Backpack)
		ClickToTeleport.Name = "点击传送"
		ClickToTeleport.RequiresHandle = false
		ClickToTeleport.Activated:Connect(function()
			local x = Mouse.hit.x
			local y = Mouse.hit.y
			local z = Mouse.hit.z
			HONG:Teleport(CFrame.new(x, y, z) + Vector3.new(0, 3, 0))
		end)
	end)
	
	
	Page2:NewToggle("灯光", "light", false, function(bool)
	    if bool then
			local MIXI_Light = Instance.new("PointLight", HONG.LP.Character.Head)
			MIXI_Light.Name = "MIXI_Light"
			MIXI_Light.Range = 35
			MIXI_Light.Brightness = 5
		else
			HONG.LP.Character.Head:FindFirstChild"MIXI_Light":Destroy()
		end
	end)
	
	Page2:NewToggle("水上行走", "waterWalk", false, function(bool)
		for i, v in next, HONG.WKSPC.Water:GetDescendants() do
			if v:IsA("Part") then
				v.CanCollide = bool;
			end
		end
	end)
	
	Page2:NewSeparator()
	
	Page2:NewSlider("相机焦距", "焦距slider", 2000, 100, 2000, false, function(v)
	    _CONFIGS["相机焦距"] = v;
	end)
	
	
	Page2:NewSlider("广角", "广角slider", 70, 70, 120, false, function(v)
	    _CONFIGS["广角"] = v;
	end)
	
	local cameraType = {  --> 游戏相机视角类型
		"Fixed";-- 静止
		"Follow";-- 跟随
	    "Attach"; -- 固定
		"Track";-- 不会自动旋转
		"Watch";-- 静止状态, 旋转保持
		"Custom";-- 默认
		"Scriptable";
	}
	
	Page2:NewDropdown("选择相机模式", "相机模式", cameraType, function(v)
	    cameraType = v;
	end)
	
	Page2:NewButton("确认选择", function()
	    if type(cameraType) == "table" then return end
		HONG.WKSPC.CurrentCamera.CameraType = Enum.CameraType[cameraType]
	end)
	
	Page2:NewButton("修复卡视角问题", function()
		HONG.WKSPC.CurrentCamera.CameraType = Enum.CameraType["Watch"]
		task.wait()
		HONG.WKSPC.CurrentCamera.CameraType = Enum.CameraType["Custom"]
	end)
	
	Page2:NewButton("锁定视角脚本", function()
		xpcall(function()
			if HONG.LP.PlayerGui:FindFirstChild("Shiftlock (StarterGui)") then
				return
			end
			local a = Instance.new("ScreenGui")
			local b = Instance.new("ImageButton")
			a.Name = "Shiftlock (StarterGui)"
			a.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
			a.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
			b.Parent = a;
			b.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			b.BackgroundTransparency = 1.000;
			b.Position = UDim2.new(0.921914339, 0, 0.552375436, 0)
			b.Size = UDim2.new(0.0636147112, 0, 0.0661305636, 0)
			b.SizeConstraint = Enum.SizeConstraint.RelativeXX;
			b.Image = "http://www.roblox.com/asset/?id=182223762"
			local function c()
				local a = Instance.new('LocalScript', b)
				local b = {}
				local c = game:GetService("Players")
				local d = game:GetService("RunService")
				local e = game:GetService("ContextActionService")
				local c = c.LocalPlayer;
				local c = c.Character or c.CharacterAdded:Wait()
				local f = c:WaitForChild("HumanoidRootPart")
				local c = c.Humanoid;
				local g = workspace.CurrentCamera;
				local a = a.Parent;
				uis = game:GetService("UserInputService")
				ismobile = uis.TouchEnabled;
				a.Visible = ismobile;
				local h = {
					OFF = "rbxasset://textures/ui/mouseLock_off@2x.png",
					ON = "rbxasset://textures/ui/mouseLock_on@2x.png"
				}
				local i = 900000;
				local j = false;
				local k = CFrame.new(1.7, 0, 0)
				local l = CFrame.new(- 1.7, 0, 0)
				local function m(b)
					a.Image = h[b]
				end;
				local function h(a)
					c.AutoRotate = a
				end;
				local function c(a, a)
					return CFrame.new(f.Position, Vector3.new(a.CFrame.LookVector.X * i, f.Position.Y, a.CFrame.LookVector.Z * i))
				end;
				local function i()
					h(false)
					m("ON")
					f.CFrame = c(f, g)
					g.CFrame = g.CFrame * k
				end;
				local function c()
					h(true)
					m("OFF")
					g.CFrame = g.CFrame * l;
					pcall(function()
						j:Disconnect()
						j = nil
					end)
				end;
				m("OFF")
				j = false;
				function ShiftLock()
					if not j then
						j = d.RenderStepped:Connect(function()
							i()
						end)
					else
						c()
					end
				end;
				local f = e:BindAction("ShiftLOCK", ShiftLock, false, "On")
				e:SetPosition("ShiftLOCK", UDim2.new(0.8, 0, 0.8, 0))
				a.MouseButton1Click:Connect(function()
					if not j then
						j = d.RenderStepped:Connect(function()
							i()
						end)
					else
						c()
					end
				end)
				return b
			end;
			coroutine.wrap(c)()
			local function b()
				local a = Instance.new('LocalScript', a)
				local a = game:GetService("Players")
				local b = game:GetService("UserInputService")
				local c = UserSettings()
				local c = c.GameSettings;
				local d = {}
				while not a.LocalPlayer do
					wait()
				end;
				local a = a.LocalPlayer;
				local e = a:GetMouse()
				local f = a:WaitForChild("PlayerGui")
				local g, h, h;
				local i = true;
				local j = true;
				local k = false;
				local l = false;
				d.OnShiftLockToggled = Instance.new("BindableEvent")
				local function m()
					return a.DevEnableMouseLock and c.ControlMode == Enum.ControlMode.MouseLockSwitch and a.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and c.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove and a.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable
				end;
				if not b.TouchEnabled then
					i = m()
				end;
				local function n()
					j = not j;
					d.OnShiftLockToggled:Fire()
				end;
				local o = function()
					
				end;
				function d:IsShiftLocked()
					return i and j
				end;
				function d:SetIsInFirstPerson(a)
					l = a
				end;
				local function l(a, a, a)
					if i then
						n()
					end
				end;
				local function l()
					if g then
						g.Parent = nil
					end;
					i = false;
					e.Icon = ""
					if h then
						h:disconnect()
						h = nil
					end;
					k = false;
					d.OnShiftLockToggled:Fire()
				end;
				local e = function(a, b)
					if b then
						return
					end;
					if a.UserInputType ~= Enum.UserInputType.Keyboard or a.KeyCode == Enum.KeyCode.LeftShift or a.KeyCode == Enum.KeyCode.RightShift then
					end
				end;
				local function n()
					i = m()
					if i then
						if g then
							g.Parent = f
						end;
						if j then
							d.OnShiftLockToggled:Fire()
						end;
						if not k then
							h = b.InputBegan:connect(e)
							k = true
						end
					end
				end;
				c.Changed:connect(function(a)
					if a == "ControlMode" then
						if c.ControlMode == Enum.ControlMode.MouseLockSwitch then
							n()
						else
							l()
						end
					elseif a == "ComputerMovementMode" then
						if c.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove then
							l()
						else
							n()
						end
					end
				end)
				a.Changed:connect(function(b)
					if b == "DevEnableMouseLock" then
						if a.DevEnableMouseLock then
							n()
						else
							l()
						end
					elseif b == "DevComputerMovementMode" then
						if a.DevComputerMovementMode == Enum.DevComputerMovementMode.ClickToMove or a.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable then
							l()
						else
							n()
						end
					end
				end)
				a.CharacterAdded:connect(function(a)
					if not b.TouchEnabled then
						o()
					end
				end)
				if not b.TouchEnabled then
					o()
					if m() then
						h = b.InputBegan:connect(e)
						k = true
					end
				end;
				n()
				return d
			end;
			coroutine.wrap(b)()
		end, ifError)
	end)
	
	getgenv()["物品总数"] = 1;
	
	Page3:NewSlider("物品数量", "buycountslider", 1, 1, 25, false, function(v)
	    getgenv()["物品总数"] = v;
	end)
	
	getgenv()["不想购买"] = false;
	
	Page3:NewButton("停止购买", function()
	    getgenv()["不想购买"] = true;
	    wait(1)
	    getgenv()["不想购买"] = false;
	end)
	
	Page3:NewSeparator();
	
	local WoodRus_Store = {
		"基础斧头 12$",
		"普通斧头 90$",
		"钢斧 190$",
		"硬化斧 550$",
		"银斧头 2040$",
		"破旧锯木厂 130$",
		"普通锯木厂 1600$",
		"锯木机01 11000$",
		"锯木机02 22500$",
		"锯木机02L 86500$",
		"多用途运载车 400$",
		"工作灯 80$",
		"沙子袋 1600$",
		"劈锯 12200$",
		"铁丝 205$",
		"按钮 320$",
		"控制杆 520$",
		"压力板 640$",
		"急弯传送带 100$",
		"直式传送带 80$",
		"漏斗式传送带 60$",
		"倾斜传送带 95$",
		"左转直式传送带 480$",
		"右转直式传送带 480$",
		"切换传送器 320$",
		"木头清扫机 430$",
		"传送带支架 12$",
	}
	
	local function newDragModel(model, cframe)
	    if not model.PrimaryPart then
	        model.PrimaryPart = model:FindFirstChildOfClass("Part")
	    end
	    HONG.RES.Interaction.ClientIsDragging:FireServer(model)
	    model.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
	    model:PivotTo(cframe)
	end
	
	local function getShopId(c, n, i)
		return {
			["Character"] = c,
			["Name"] = n,
			["ID"] = tonumber(i)
		}
	end
	
	local Stores = {
		["WoodRUs"] = getShopId(HONG.WKSPC.Stores.WoodRUs.Thom, "Thom", 7);
		["FurnitureStore"] = getShopId(HONG.WKSPC.Stores.FurnitureStore.Corey, "Corey", 8);
		["CarStore"] = getShopId(HONG.WKSPC.Stores.CarStore.Jenny, "Jenny", 9);
		["ShackShop"] = getShopId(HONG.WKSPC.Stores.ShackShop.Bob, "Bob", 10);
		["LandStore"] = getShopId(HONG.WKSPC.Stores.LandStore.Ruhven, "Ruhven", 1);
		["FineArt"] = getShopId(HONG.WKSPC.Stores.FineArt.Timothy, "Timothy", 11);
		["LogicStore"] = getShopId(HONG.WKSPC.Stores.LogicStore.Lincoln, "Lincoln", 12);
		["TollBooth0"] = getShopId(HONG.WKSPC.Bridge.TollBooth0.Seranok, "Seranok", 14);
		["Ferry"] = getShopId(HONG.WKSPC.Ferry.Ferry.Hoover, "Hoover", 15);
		["Region_Main"] = getShopId(HONG.WKSPC.Region_Main:FindFirstChild("Strange Man"), "Strange Man", 3);
	};
	
	
	local function buyItem(count, store, item, name)
		if type(item) == "table" then
			HONG:NOTIFY("错误", "请先选择商品!", 4)
			return
		end
		count = count or 1
		local oldpos = HONG.LP.Character.HumanoidRootPart.CFrame;
		local sum = 0;
		while sum < count  do
		    if getgenv()["不想购买"] == true then
		        HONG:Teleport(oldpos)
				return
		    end
		    
			local Item
			for i, v in next, HONG.WKSPC.Stores:children() do
				if v.Name == "ShopItems" and v:FindFirstChild"Box" then
					for j, k in next, v:children() do
						if k.BoxItemName.Value == item then
							ltem = k
						end
					end
				end
			end
			repeat
				HONG.RS.Heartbeat:wait()
			until ltem ~= nil
			HONG:Teleport(ltem.Main.CFrame + Vector3.new(0, 1, 5))
			task.wait(0.5)
			repeat
			    if getgenv()["不想购买"] == true then
		            HONG:Teleport(oldpos)
				    return
		        end
				newDragModel(ltem, HONG.WKSPC.Stores[name].Counter.CFrame + Vector3.new(0, .6, 0))
				HONG:Teleport(ltem.Main.CFrame + Vector3.new(0, 1, 5))
				task.wait(0.2)
	            --print((ltem.Main.Position - HONG.WKSPC.Stores[name].Counter.Position).Magnitude)
			until (ltem.Main.Position - HONG.WKSPC.Stores[name].Counter.Position).Magnitude < 5;
			task.wait(0.4)
			HONG:Teleport(HONG.WKSPC.Stores[name].Counter.CFrame + Vector3.new(0, 5, 5))
			HONG.RS.Heartbeat:wait()
			repeat
				HONG.RS.Heartbeat:wait()
				if getgenv()["不想购买"] == true then
		            HONG:Teleport(oldpos)
				    return
		        end
				HONG.RES.Interaction.ClientIsDragging:FireServer(ltem)
				HONG.RES.NPCDialog.PlayerChatted:InvokeServer(store, "ConfirmPurchase")
			until ltem.Owner.Value == HONG.LP or ltem.Owner.Value ~= nil
			for i = 1, 30 do
				newDragModel(ltem, oldpos)
				task.wait(0.01)
			end
			task.wait(0.5)
			sum = sum + 1
		end
		HONG:Teleport(oldpos)
	end
	
	Page3:NewDropdown("反斗城商品", "shop_woodrus", WoodRus_Store, function(WShop)
	    if WShop == "基础斧头 12$" then
			WoodRus_Store = "BasicHatchet"
		end
		if WShop == "普通斧头 90$" then
			WoodRus_Store = "Axe1"
		end
		if WShop == "钢斧 190$" then
			WoodRus_Store = "Axe2"
		end
		if WShop == "硬化斧 550$" then
			WoodRus_Store = "Axe3"
		end
		if WShop == "银斧头 2040$" then
			WoodRus_Store = "SilverAxe"
		end
		if WShop == "破旧锯木厂 130$" then
			WoodRus_Store = "Sawmill"
		end
		if WShop == "普通锯木厂 1600$" then
			WoodRus_Store = "Sawmill2"
		end
		if WShop == "锯木机01 11000$" then
			WoodRus_Store = "Sawmill3"
		end
		if WShop == "锯木机02 22500$" then
			WoodRus_Store = "Sawmill4"
		end
		if WShop == "锯木机02L 86500$" then
			WoodRus_Store = "Sawmill4L"
		end
		if WShop == "多用途运载车 400$" then
			WoodRus_Store = "UtilityTruck"
		end
		if WShop == "工作灯 80$" then
			WoodRus_Store = "WorkLight"
		end
		if WShop == "沙子袋 1600$" then
			WoodRus_Store = "BagOfSand"
		end
		if WShop == "劈锯 12200$" then
			WoodRus_Store = "ChopSaw"
		end
		if WShop == "铁丝 205$" then
			WoodRus_Store = "Wire"
		end
		if WShop == "按钮 320$" then
			WoodRus_Store = "Button0"
		end
		if WShop == "控制杆 520$" then
			WoodRus_Store = "Lever0"
		end
		if WShop == "压力板 640$" then
			WoodRus_Store = "PressurePlate"
		end
		if WShop == "急弯传送带 100$" then
			WoodRus_Store = "TightTurnConveyor"
		end
		if WShop == "直式传送带 80$" then
			WoodRus_Store = "StraightConveyor"
		end
		if WShop == "漏斗式传送带 60$" then
			WoodRus_Store = "ConveyorFunnel"
		end
		if WShop == "倾斜传送带 95$" then
			WoodRus_Store = "TiltConveyor"
		end
		if WShop == "左转直式传送带 480$" then
			WoodRus_Store = "StraightSwitchConveyorLeft"
		end
		if WShop == "右转直式传送带 480$" then
			WoodRus_Store = "StraightSwitchConveyorRight"
		end
		if WShop == "切换传送器 320$" then
			WoodRus_Store = "ConveyorSwitch"
		end
		if WShop == "木头清扫机 430$" then
			WoodRus_Store = "LogSweeper"
		end
		if WShop == "传送带支架 12$" then
			WoodRus_Store = "ConveyorSupports"
		end
	end)
	
	Page3:NewButton("购买", function()
		xpcall(buyItem(getgenv()["物品总数"], Stores["WoodRUs"], WoodRus_Store, "WoodRUs"), function(err)
			print("");
		end)
	end)
	
	Page3:NewSeparator();
	
	local BluePrintStore = {
		"篱笆[宽] 80$",
		"篱笆[窄] 80$",
		"篱笆角 80$",
		"矮篱笆[宽] 80$",
		"矮篱笆[窄] 80$",
		"矮篱笆角 80$",
		"光滑的墙[宽] 80$",
		"光滑的墙[窄] 80$",
		"光滑墙角 80$",
		"矮光滑墙[宽] 80$",
		"矮光滑墙[窄] 80$",
		"又矮又光滑的墙角 80$",
		"光滑墙立柱[宽] 80$",
		"光滑墙立柱[窄] 80$",
		"光滑墙角立柱 80$",
		"波纹墙[宽] 80$",
		"波纹墙[窄] 80$",
		"波纹墙角 80$",
		"矮波纹墙[宽] 80$",
		"矮波纹墙[窄] 80$",
		"矮波纹墙角 80$",
		"波纹墙立柱[宽] 80$",
		"波纹墙立柱[窄] 80$",
		"波纹墙角立柱 80$",
		"微型瓷砖 80$",
		"小型瓷砖 80$",
		"瓷砖 80$",
		"大型瓷砖 80$",
		"微型地板 80$",
		"小型地板 80$",
		"地板 80$",
		"大型地板 80$",
		"方桌 80$",
		"长桌 80$",
		"普通椅子 80$",
		"陡峭楼梯 80$",
		"楼梯 80$",
		"梯子 80$",
		"标志杆 80$",
		"普通门 80$",
		"半截门 80$",
		"宽敞门 80$",
		"4/4木楔 80$",
		"4/4x1 木楔 80$",
		"3/4木楔 80$",
		"3/4x1 木楔 80$",
		"2/4木楔 80$",
		"2/4x1木楔 80$",
		"1/4木楔 80$",
		"1/4x1木楔 80$",
		"3/3木楔 80$",
		"3/3x1 木楔 80$",
		"2/3木楔 80$",
		"2/3x1木楔 80$",
		"1/3木楔 80$",
		"1/3x1木楔 80$",
		"2/2木楔 80$",
		"2/2x1木楔 80$",
		"1/2木楔 80$",
		"1/2x1木楔 80$",
		"1/1木楔 80$",
		"1/1x1木楔 80$"
	}
	
	Page3:NewDropdown("蓝图商品", "shop_blueprint", BluePrintStore, function(item)
	    if item == "篱笆[宽] 80$" then
			BluePrintStore = "Wall3Tall"
		end
		if item == "篱笆[窄] 80$" then
			BluePrintStore = "Wall3TallThin"
		end
		if item == "篱笆角 80$" then
			BluePrintStore = "Wall3TallCorner"
		end
		if item == "矮篱笆[宽] 80$" then
			BluePrintStore = "Wall3"
		end
		if item == "矮篱笆[窄] 80$" then
			BluePrintStore = "Wall3Thin"
		end
		if item == "矮篱笆角 80$" then
			BluePrintStore = "Wall3Corner"
		end
		if item == "光滑的墙[宽] 80$" then
			BluePrintStore = "Wall2Tall"
		end
		if item == "光滑的墙[窄] 80$" then
			BluePrintStore = "Wall2TallThin"
		end
		if item == "光滑墙角 80$" then
			BluePrintStore = "Wall2TallCorner"
		end
		if item == "矮光滑墙[宽] 80$" then
			BluePrintStore = "Wall2"
		end
		if item == "矮光滑墙[窄] 80$" then
			BluePrintStore = "Wall2Thin"
		end
		if item == "又矮又光滑的墙角 80$" then
			BluePrintStore = "Wall2Corner"
		end
		if item == "光滑墙立柱[宽] 80$" then
			BluePrintStore = "Wall2Short"
		end
		if item == "光滑墙立柱[窄] 80$" then
			BluePrintStore = "Wall2ShortThin"
		end
		if item == "光滑墙角立柱 80$" then
			BluePrintStore = "Wall2ShortCorner"
		end
		if item == "波纹墙[宽] 80$" then
			BluePrintStore = "Wall1Tall"
		end
		if item == "波纹墙[窄] 80$" then
			BluePrintStore = "Wall1TallThin"
		end
		if item == "波纹墙角 80$" then
			BluePrintStore = "Wall1TallCorner"
		end
		if item == "矮波纹墙[宽] 80$" then
			BluePrintStore = "Wall1"
		end
		if item == "矮波纹墙[窄] 80$" then
			BluePrintStore = "Wall1Thin"
		end
		if item == "矮波纹墙角 80$" then
			BluePrintStore = "Wall1Corner"
		end
		if item == "波纹墙立柱[宽] 80$" then
			BluePrintStore = "Wall1Short"
		end
		if item == "波纹墙立柱[窄] 80$" then
			BluePrintStore = "Wall1ShortThin"
		end
		if item == "波纹墙角立柱 80$" then
			BluePrintStore = "Wall1ShortCorner"
		end
		if item == "微型瓷砖 80$" then
			BluePrintStore = "Floor2Tiny"
		end
		if item == "小型瓷砖 80$" then
			BluePrintStore = "Floor2Small"
		end
		if item == "瓷砖 80$" then
			BluePrintStore = "Floor2"
		end
		if item == "大型瓷砖 80$" then
			BluePrintStore = "Floor2Large"
		end
		if item == "微型地板 80$" then
			BluePrintStore = "Floor1Tiny"
		end
		if item == "小型地板 80$" then
			BluePrintStore = "Floor1Small"
		end
		if item == "地板" then
			BluePrintStore = "Floor1"
		end
		if item == "大型地板 80$" then
			BluePrintStore = "Floor1Large"
		end
		if item == "方桌 80$" then
			BluePrintStore = "Table1"
		end
		if item == "长桌 80$" then
			BluePrintStore = "Table2"
		end
		if item == "普通椅子 80$" then
			BluePrintStore = "Chair1"
		end
		if item == "陡峭楼梯 80$" then
			BluePrintStore = "Stair1"
		end
		if item == "楼梯 80$" then
			BluePrintStore = "Stair2"
		end
		if item == "梯子 80$" then
			BluePrintStore = "Ladder1"
		end
		if item == "标志杆 80$" then
			BluePrintStore = "Post"
		end
		if item == "普通门 80$" then
			BluePrintStore = "Door1"
		end
		if item == "半截门 80$" then
			BluePrintStore = "Door2"
		end
		if item == "宽敞门 80$" then
			BluePrintStore = "Door3"
		end
		if item == "4/4木楔 80$" then
			BluePrintStore = "Wedge1"
		end
		if item == "4/4x1 木楔 80$" then
			BluePrintStore = "Wedge1_Thin"
		end
		if item == "4/4木楔 80$" then
			BluePrintStore = "Wedge1"
		end
		if item == "4/4x1 木楔 80$" then
			BluePrintStore = "Wedge1_Thin"
		end
		if item == "3/4木楔 80$" then
			BluePrintStore = "Wedge2"
		end
		if item == "3/4x1 木楔 80$" then
			BluePrintStore = "Wedge2_Thin"
		end
		if item == "2/4木楔 80$" then
			BluePrintStore = "Wedge3"
		end
		if item == "2/4x1 木楔 80$" then
			BluePrintStore = "Wedge3_Thin"
		end
		if item == "1/4木楔 80$" then
			BluePrintStore = "Wedge4"
		end
		if item == "1/4x1 木楔 80$" then
			BluePrintStore = "Wedge4_Thin"
		end
		if item == "3/3木楔 80$" then
			BluePrintStore = "Wedge5"
		end
		if item == "3/3x1 木楔 80$" then
			BluePrintStore = "Wedge5_Thin"
		end
		if item == "2/3木楔 80$" then
			BluePrintStore = "Wedge6"
		end
		if item == "2/3x1 木楔 80$" then
			BluePrintStore = "Wedge6_Thin"
		end
		if item == "1/3木楔 80$" then
			BluePrintStore = "Wedge7"
		end
		if item == "1/3x1 木楔 80$" then
			BluePrintStore = "Wedge7_Thin"
		end
		if item == "2/2木楔 80$" then
			BluePrintStore = "Wedge8"
		end
		if item == "2/2x1 木楔 80$" then
			BluePrintStore = "Wedge8_Thin"
		end
		if item == "1/2木楔 80$" then
			BluePrintStore = "Wedge9"
		end
		if item == "1/2x1 木楔 80$" then
			BluePrintStore = "Wedge9_Thin"
		end
		if item == "1/1木楔 80$" then
			BluePrintStore = "Wedge10"
		end
		if item == "1/1x1 木楔 80$" then
			BluePrintStore = "Wedge10_Thin"
		end
	end)
	
	Page3:NewButton("购买", function()
		xpcall(buyItem(getgenv()["物品总数"], Stores["WoodRUs"], BluePrintStore, "WoodRUs"), function(err)
			print("");
		end)
	end)
	
	Page3:NewSeparator();
	
	Page3:NewButton("购买土地", function()
		HONG.RES.NPCDialog.PlayerChatted:InvokeServer(Stores.LandStore, "EnterPurchase")
	end)
	
	Page3:NewSeparator();
	
	local Car_Store = {
		"小型拖车 1800$",
		"531式拖车 13000$",
		"多用途运载车XL 5000$",
		"瓦尔的全功能拖车 19000$"
	}
	
	Page3:NewDropdown("盒子车行", "shop_woodrus", Car_Store, function(item)
	    if item == "小型拖车 1800$" then
			Car_Store = "SmallTrailer"
		end
		if item == "531式拖车 13000$" then
			Car_Store = "Trailer2"
		end
		if item == "多用途运载车XL 5000$" then
			Car_Store = "UtilityTruck2"
		end
		if item == "瓦尔的全功能拖车 19000$" then
			Car_Store = "Pickup1"
		end
	end)
	
	Page3:NewButton("购买", function()
		xpcall(buyItem(getgenv()["物品总数"], Stores["CarStore"], Car_Store, "CarStore"), function(err)
			print("");
		end)
	end)
	
	Page3:NewSeparator();
	
	local Furniture_Store = {
		"洗碗机 380$",
		"火炉 340$",
		"冰箱 310$",
		"马桶 90$",
		"床2 350$",
		"床1 250$",
		"大型玻璃板 550$",
		"玻璃板 220$",
		"小型玻璃板 50$",
		"微型玻璃板 12$",
		"普通玻璃门 720$",
		"灯泡 2600$",
		"照明灯 90$",
		"墙灯 90$",
		"台灯 90$",
		"落地灯 110$",
		"长沙发 320$",
		"双人沙发 200$",
		"扶手椅 140$",
		"惊悚冰柱灯串 910$",
		"琥珀色冰柱灯串 750$",
		"蓝色冰柱灯串 750$",
		"绿色冰柱灯串 750$",
		"红色冰柱灯串 750$",
		"烟花发射器 7500$",
		"薄柜子 80$",
		"橱柜 80$",
		"橱柜角 80$",
		"宽橱柜角 80$",
		"薄工作台面 80$",
		"工作台面 80$",
		"带水槽的工作台面 80$"
	}
	
	Page3:NewDropdown("家具店商品", "shop_f", Furniture_Store, function(item)
	    if item == "洗碗机 380$" then
			Furniture_Store = "Dishwasher"
		end
		if item == "火炉 340$" then
			Furniture_Store = "Stove"
		end
		if item == "冰箱 310$" then
			Furniture_Store = "Refridgerator"
		end
		if item == "马桶 90$" then
			Furniture_Store = "Toilet"
		end
		if item == "床2 350$" then
			Furniture_Store = "Bed2"
		end
		if item == "床1 250$" then
			Furniture_Store = "Bed1"
		end
		if item == "大型玻璃板 550$" then
			Furniture_Store = "GlassPane4"
		end
		if item == "玻璃板 220$" then
			Furniture_Store = "GlassPane3"
		end
		if item == "小型玻璃板 50$" then
			Furniture_Store = "GlassPane2"
		end
		if item == "微型玻璃板 12$" then
			Furniture_Store = "GlassPane1"
		end
		if item == "普通玻璃门 720$" then
			Furniture_Store = "GlassDoor1"
		end
		if item == "灯泡 2600$" then
			Furniture_Store = "LightBulb"
		end
		if item == "照明灯 90$" then
			Furniture_Store = "WallLight2"
		end
		if item == "墙灯 90$" then
			Furniture_Store = "WallLight1"
		end
		if item == "台灯 90$" then
			Furniture_Store = "Lamp1"
		end
		if item == "落地灯 110$" then
			Furniture_Store = "FloorLamp1"
		end
		if item == "长沙发 320$" then
			Furniture_Store = "Seat_Couch"
		end
		if item == "双人沙发 200$" then
			Furniture_Store = "Seat_Loveseat"
		end
		if item == "扶手椅 140$" then
			Furniture_Store = "Seat_Armchair"
		end
		if item == "惊悚冰柱灯串 910$" then
			Furniture_Store = "IcicleWireHalloween"
		end
		if item == "琥珀色冰柱灯串 750$" then
			Furniture_Store = "IcicleWireAmber"
		end
		if item == "蓝色冰柱灯串 750$" then
			Furniture_Store = "IcicleWireBlue"
		end
		if item == "绿色冰柱灯串 750$" then
			Furniture_Store = "IcicleWireGreen"
		end
		if item == "红色冰柱灯串 750$" then
			Furniture_Store = "IcicleWireRed"
		end
		if item == "烟花发射器 7500$" then
			Furniture_Store = "FireworkLauncher"
		end
		if item == "薄柜子 80$" then
			Furniture_Store = "Cabinet1Thin"
		end
		if item == "橱柜 80$" then
			Furniture_Store = "Cabinet1"
		end
		if item == "橱柜角 80$" then
			Furniture_Store = "Cabinet1CornerTight"
		end
		if item == "宽橱柜角 80$" then
			Furniture_Store = "Cabinet1CornerWide"
		end
		if item == "薄工作台面 80$" then
			Furniture_Store = "CounterTop1Thin"
		end
		if item == "工作台面 80$" then
			Furniture_Store = "CounterTop1"
		end
		if item == "带水槽的工作台面 80$" then
			Furniture_Store = "CounterTop1Sink"
		end
	end)
	
	Page3:NewButton("购买", function()
		xpcall(buyItem(getgenv()["物品总数"], Stores["FurnitureStore"], Furniture_Store, "FurnitureStore"), function(err)
			print("");
		end)
	end)
	
	Page3:NewSeparator();
	
	local Shack_Shop = {
		"炸药 220$",
		"毛毛虫软糖罐 3200$",
	}
	
	Page3:NewDropdown("鲍勃小屋", "shop_shack", Shack_Shop, function(item)
		if item == "炸药 220$" then
			Shack_Shop = "Dynamite"
		end
		if item == "毛毛虫软糖罐 3200$" then
			Shack_Shop = "CanOfWorms"
		end
	end)
	
	Page3:NewButton("购买", function()
		xpcall(buyItem(getgenv()["物品总数"], Stores["ShackShop"], Shack_Shop, "ShackShop"), function(err)
			print("");
		end)
	end)
	
	Page3:NewSeparator();
	
	local FineArts = {
		"北极灯串 16000$",
		"孤独的长颈鹿 26800$",
		"未知标题 5980$",
		"户外水彩素描 6$",
		"困扰装饰画 2006$",
		"阴郁的黄昏海景 16800$",
		"菠萝 2406000$"
	}
	
	Page3:NewDropdown("艺术品商店", "shop_fineart", FineArts, function(item)
	    if item == "北极灯串 16000$" then
			FineArts = "Painting7"
		end
		if item == "孤独的长颈鹿 26800$" then
			FineArts = "Painting9"
		end
		if item == "未知标题 5980$" then
			FineArts = "Painting1"
		end
		if item == "户外水彩素描 6$" then
			FineArts = "Painting3"
		end
		if item == "困扰装饰画 2006$" then
			FineArts = "Painting2"
		end
		if item == "阴郁的黄昏海景 16800$" then
			FineArts = "Painting6"
		end
		if item == "菠萝 2406000$" then
			FineArts = "Painting8"
		end
	end)
	
	Page3:NewButton("购买", function()
		xpcall(buyItem(getgenv()["物品总数"], Stores["FineArt"], FineArts, "FineArt"), function(err)
			print("");
		end)
	end)
	
	Page3:NewSeparator();
	
	local Logic_Store = {
		"铁丝 205$",
		"按钮 320$",
		"控制杆 520$",
		"压力板 640$",
		"激光探测器 3200$",
		"激光 11300$",
		"木材探测器 11300$",
		"定时开关 902$",
		"异或门 260$",
		"或门 260$",
		"与门 260$",
		"信号变换器 200$",
		"白色霓虹灯线 720$",
		"紫罗兰色霓虹灯线 720$",
		"蓝色霓虹灯线 720$",
		"蓝绿色霓虹灯线 720$",
		"绿色霓虹灯线 720$",
		"黄色霓虹灯线 720$",
		"橙色霓虹灯线 720$",
		"红色霓虹灯线 720$",
		"舱门 830$",
		"信号延迟 520$",
		"信号维持 520$"
	}
	
	Page3:NewDropdown("连接逻辑店", "shop_logic", Logic_Store, function(item)
		if item == "铁丝 205$" then
			Logic_Store = "Wire"
		end
		if item == "按钮 320$" then
			Logic_Store = "Button0"
		end
		if item == "控制杆 520$" then
			Logic_Store = "Lever0"
		end
		if item == "压力板 640$" then
			Logic_Store = "PressurePlate"
		end
		if item == "激光探测器 3200$" then
			Logic_Store = "LaserReceiver"
		end
		if item == "激光 11300$" then
			Logic_Store = "Laser"
		end
		if item == "木材探测器 11300$" then
			Logic_Store = "WoodChecker"
		end
		if item == "定时开关 902$" then
			Logic_Store = "ClockSwitch"
		end
		if item == "异或门 260$" then
			Logic_Store = "GateXOR"
		end
		if item == "或门 260$" then
			Logic_Store = "GateOR"
		end
		if item == "与门 260$" then
			Logic_Store = "GateAND"
		end
		if item == "信号变换器 200$" then
			Logic_Store = "GateNOT"
		end
		if item == "白色霓虹灯线 720$" then
			Logic_Store = "NeonWireWhite"
		end
		if item == "紫罗兰色霓虹灯线 720$" then
			Logic_Store = "NeonWireViolet"
		end
		if item == "蓝色霓虹灯线 720$" then
			Logic_Store = "NeonWireBlue"
		end
		if item == "蓝绿色霓虹灯线 720$" then
			Logic_Store = "NeonWireCyan"
		end
		if item == "绿色霓虹灯线 720$" then
			Logic_Store = "NeonWireGreen"
		end
		if item == "黄色霓虹灯线 720$" then
			Logic_Store = "NeonWireYellow"
		end
		if item == "橙色霓虹灯线 720$" then
			Logic_Store = "NeonWireOrange"
		end
		if item == "红色霓虹灯线 720$" then
			Logic_Store = "NeonWireRed"
		end
		if item == "舱门 830$" then
			Logic_Store = "Hatch"
		end
		if item == "信号延迟 520$" then
			Logic_Store = "SignalDelay"
		end
		if item == "信号维持 520$" then
			Logic_Store = "SignalSustain"
		end
	end)
	
	Page3:NewButton("购买", function()
		xpcall(buyItem(getgenv()["物品总数"], Stores["LogicStore"], Logic_Store, "LogicStore"), function(err)
			print("");
		end)
	end)
	
	Page3:NewSeparator();
	
	Page3:NewButton("购买桥票 $100", function()
		HONG.RES.NPCDialog.PlayerChatted:InvokeServer(Stores["TollBooth0"], "ConfirmPurchase")
	end)
	
	Page3:NewButton("购买船票 $400", function()
		HONG.RES.NPCDialog.PlayerChatted:InvokeServer(Stores["Ferry"], "ConfirmPurchase")
	end)
	
	
	Page3:NewButton("购买超级蓝图 $10009000", function()
		HONG.RES.NPCDialog.PlayerChatted:InvokeServer(Stores["Region_Main"], "ConfirmPurchase")
	end)
	
	
	local players = game:GetService("Players");
	local player = players.LocalPlayer;
	getgenv()["不想砍树"] = false;
	
	local function getDamage(tool)
		local modTool = require(game:GetService("ReplicatedStorage").AxeClasses[("AxeClass_%s"):format(tool.ToolName.Value)])
		local t = modTool.new()
		return t.Damage
	end
	
	local function getCurrentAxe()
		local tool = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Tool")
		if tool and tool.Name ~= "BlueprintTool" then
			return tool
		end
		return false;
	end
	
	local MIXI_ENDTIME_PART = function()
		if HONG.WKSPC:FindFirstChild"MIXI_EndTimeTree_OfPart" then
			return
		end
		local part = Instance.new("Part", HONG.WKSPC)
		part.Size = Vector3.new(300, 1, 300)
		part.CFrame = CFrame.new(- 45.1, - 216.15, - 1341.15)
		part.Anchored = true
		part.BrickColor = BrickColor.new("Bright red")
		part.Material = Enum.Material.DiamondPlate
		part.Name = "MIXI_EndTimeTree_OfPart"
	end
	
	
	local function cutTree(config)
		local config = config or {};
		config.Cutevent = config.Cutevent or nil; --> 砍树事件是必须要的!
		config.Tool = config.Tool or nil; --> 斧头是必须要的!
		config.Height = config.Height or 0.3;
		config.SectionId = config.SectionId or 1;
		config.FaceVector = config.FaceVector or Vector3.new(1, 0, 0);
		local damage
		if config.Tool.ToolName.Value == "EndTimesAxe" and config.Cutevent.Parent.TreeClass.Value == "LoneCave" then
			damage = 10000000;
			MIXI_ENDTIME_PART()
		elseif config.Tool.ToolName.Value == "OvergrownAxe" and config.Cutevent.Parent.TreeClass.Value == "GreenSwampy" then
			damage = 7;
		elseif config.Tool.ToolName.Value == "OvergrownAxe" and config.Cutevent.Parent.TreeClass.Value == "GoldSwampy" then
			damage = 5.35;
		elseif config.Tool.ToolName.Value == "FireAxe" and config.Cutevent.Parent.TreeClass.Value == "Volcano" then
			damage = 6.35;
		elseif config.Tool.ToolName.Value == "CaveAxe" and config.Cutevent.Parent.TreeClass.Value == "CaveCrawler" then
			damage = 7.2;
		elseif config.Tool.ToolName.Value == "IceAxe" and config.Cutevent.Parent.TreeClass.Value == "Frost" then
	        damage = 6;
		else
			damage = getDamage(config.Tool);
		end
		game:GetService("ReplicatedStorage").Interaction.RemoteProxy:FireServer(
	    config.Cutevent, {
			["tool"] = config.Tool;
			["faceVector"] = config.FaceVector;
			["height"] = config.Height;
			["sectionId"] = config.SectionId;
			["hitPoints"] = tonumber(damage);
			["cooldown"] = 0.01;
			["cuttingClass"] = "Axe";
		})
	end
	
	local getNo1Axe = function(tree)
		local axes = {};
		local bestTool
		for _, v in next, HONG.LP.Character:GetChildren() do
			if v:IsA("Tool") and v.Name ~= "BlueprintTool" then
				if v:FindFirstChild("CuttingTool") then
				    table.insert(axes, v)
				end
			end
		end
		for _, v in next, HONG.LP.Backpack:GetChildren() do
			if v:IsA("Tool") and v.Name ~= "BlueprintTool" then
			    if v:FindFirstChild("CuttingTool") then
				    table.insert(axes, v)
				end
			end
		end
		local bbb = {}
		for i, v in next, axes do
		 --   print("iv=", i,v)
			local damage
		--	print(tree)
			if v.ToolName.Value == "EndTimesAxe" and tree == "LoneCave" then
				damage = 10000000;
				return v
			elseif v.ToolName.Value == "OvergrownAxe" and tree == "GreenSwampy" then
				damage = 7;
				return v
			elseif v.ToolName.Value == "OvergrownAxe" and tree == "GoldSwampy" then
				damage = 5.35;
				return v
		    elseif v.ToolName.Value == "IceAxe" and tree == "Frost" then
		        damage = 6;
		        return v
			elseif v.ToolName.Value == "FireAxe" and tree == "Volcano" then
				damage = 6.35;
				return v
			elseif v.ToolName.Value == "CaveAxe" and tree == "CaveCrawler" then
				damage = 7.2;
				return v
			else
				table.insert(bbb, v)
			end
		end
		for i, v in next, bbb do
			if math.max(getDamage(v)) then
				bestTool = v;
			end
		end
		return bestTool
	end
	
	
	local getAxe = function(tree)
		local Axe = getNo1Axe(tree);
		if not Axe then
			return HONG:NOTIFY("错误!", "没有找到斧头!", 4)
		end
		return Axe
	end
	   
	
	local function bringTree(config)
		local config = config or {};
		config.TreeValue = config.TreeValue or "Generic"; --> 树是必须要的!
		config.Quantity = config.Quantity or 1; --> 带来树的数量
		local oldpos = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame;
		
		if not getAxe(config.TreeValue) then 
		    HONG:Teleport(oldpos)
		    return HONG:NOTIFY("错误!", "没有找到斧头!", 3)
		end
		
		    
		local woods = {}
		local sum = 0;
		while sum < config.Quantity  do
		    if getgenv()["不想砍树"] == true then
		        HONG:Teleport(oldpos)
		        HONG.WKSPC.Camera.CameraSubject = HONG.LP.Character
	         	togggleInvisible(0)
				return
		    end
			local wood, treeToCut;
			local checkWoodSize = {};
			for _, v in next, game:GetService("Workspace"):GetDescendants() do
				if v.Name == "TreeRegion" then
					for _, model in next, v:children() do
						if model:FindFirstChild("CutEvent") then
							if model:FindFirstChild("WoodSection") then
								table.insert(woods, model.WoodSection)
								if # woods >= 3 then --> 判断树大小
									if model.Owner.Value == nil or model.Owner.Value == HONG.LP then
										if not model:FindFirstChild("RootCut") then
											if model.TreeClass.Value == config.TreeValue then
												wood = model;
											end
										end
									end
								end
							end
						end
					end
				end
			end
			if wood == nil then
				HONG:NOTIFY("错误!", "没有找到树!", 4)
				HONG:Teleport(oldpos)
				return
			end
	       
	        
	        --> 检查树大小 和 定位传送part
			local woodPart;
			for _, v in next, wood:GetDescendants() do
				if v.Name == "WoodSection" then
					treeToCut = wood.CutEvent
					table.insert(woods, v)
					if v:FindFirstChild("ID") and v.ID.Value == 1 then
						woodPart = v
					end
				end
			end
			togggleInvisible(1)
			repeat
			    if getgenv()["不想砍树"] == true then
		            HONG:Teleport(oldpos)
		            HONG.WKSPC.Camera.CameraSubject = HONG.LP.Character
	             	togggleInvisible(0)
				    return
		        end
				HONG.WKSPC.Camera.CameraSubject = woodPart;
				HONG:Teleport(woodPart.CFrame + Vector3.new(0, 2.5, 3.5));
				task.wait()
				cutTree({
					Cutevent = treeToCut;
					Tool = getAxe(config.TreeValue);
					Height = 0.3;
				})
			until wood:FindFirstChild("RootCut")
			local Log
			for s, b in next, HONG.WKSPC.LogModels:GetDescendants() do
				if b:FindFirstChild"Owner" and b.Owner.Value == HONG.LP then
					Log = b
				end
			end
			for i = 1, 20 do
				newDragModel(Log, oldpos)
				task.wait(0.1)
			end
			task.wait()
			sum = sum + 1;
		end
		HONG:Teleport(oldpos)
		HONG.WKSPC.Camera.CameraSubject = HONG.LP.Character
		togggleInvisible(0)    
	end
	
	getgenv()["带来树数量"] = 1;
	
	Page4:NewSlider("砍树数量", "砍树slider", 1, 1, 30, false, function(v)
	   getgenv()["带来树数量"] = v;
	end)
	
	local tree_list = {
		"原始木",
		"金木",
		"蓝木",
		"樱桃木",
		"冰木",
		"火山木",
		"橡树",
		"胡桃木",
		"白桦木",
		"雪光木",
		"雪松",
		"僵尸木",
		"棕树",
		"椰子树",
		"幻影木"
	}
	local select_tree = "Generic";
	
	Page4:NewDropdown("选择树", "select_tree", tree_list, function(list)
		if list == "火山木" then
			select_tree = ("Volcano")
		end
		if list == "蓝木" then
			select_tree = ("CaveCrawler")
		end
		if list == "原始木" then
			select_tree = ("Generic")
		end
		if list == "樱桃木" then
			select_tree = ("Cherry")
		end
		if list == "僵尸木" then
			select_tree = ("GreenSwampy")
		end
		if list == "椰子树" then
			select_tree = ("Palm")
		end
		if list == "金木" then
			select_tree = ("GoldSwampy")
		end
		if list == "冰木" then
			select_tree = ("Frost")
		end
		if list == "胡桃木" then
			select_tree = ("Walnut")
		end
		if list == "雪光木" then
			select_tree = ("SnowGlow")
		end
		if list == "橡树" then
			select_tree = ("Oak")
		end
		if list == "白桦木" then
			select_tree = ("Birch")
		end
		if list == "棕树" then
			select_tree = ("Koa")
		end
		if list == "雪松" then
			select_tree = ("Pine")
		end
		if list == "幻影木" then
			select_tree = ("LoneCave")
		end
	end)
	
	Page4:NewButton("带来树", function()
		bringTree({
			TreeValue = select_tree;
			Quantity = tonumber(getgenv()["带来树数量"]);
		})
	end)
	
	Page4:NewButton("停止", function()
	    getgenv()["不想砍树"] = true;
	    wait(1)
	    getgenv()["不想砍树"] = false;
	end)
	
	Page4:NewSeparator();
	
	Page4:NewToggle("点击出售木材", "clicksell", false, function(v)
	    getgenv()["点击出售木头"] = v;
		local UserInputService = game:GetService("UserInputService")
		clickSellLog = UserInputService.TouchTap:Connect(function()
			if getgenv()["点击出售木头"] == false then
				if clickSellLog then
					clickSellLog:Disconnect();
					clickSellLog = nil;
					return
				end
				return
			end
			pcall(function()
				spawn(function()
					local oldpos = HONG.LP.Character.HumanoidRootPart.CFrame
					local wood = Mouse.Target.Parent;
					local sell = CFrame.new(315.12146, - 0.190167814, 85.0448074);
					if wood:FindFirstChild("WoodSection") and (wood:FindFirstChild("Owner") and (wood.Owner.Value == HONG.LP) or (wood.Owner.Value == nil)) then
						if not wood:FindFirstChild"RootCut" and wood.Parent.Name == "TreeRegion" then
							return library:Notify({
							           Title = "错误!", 
							           Text = "这棵树还没有砍!",
							           Duration = 4
							       })
						end
						HONG.LP.Character:MoveTo(wood.WoodSection.CFrame.p);
						for i = 1, 20 do
							HONG:DragModel(wood, sell)
							task.wait(0.1)
						end
					end
				end)
			end)
		end)
	end)
	
	local sellAllLog = true;
	
	Page4:NewToggle("出售全部木头", "sellallwood", false, function(v)
	    sellAllLog = v;
		local sell = CFrame.new(315.12146, - 0.190167814, 85.0448074);
		local oldpos = HONG.LP.Character.HumanoidRootPart.CFrame
		for _, v in next, HONG.WKSPC.LogModels:GetDescendants() do
			if sellAllLog == false then --> 如果不想买了, 就中断且传送到原来的位置
				HONG:Teleport(oldpos);
				return
			end
			if v:FindFirstChild"Owner" then
				if v.Owner.Value == HONG.LP or v.Owner.Value == nil then
					pcall(function()
						HONG.LP.Character:MoveTo(v.WoodSection.CFrame.p);
						for i = 1, 20 do
							HONG.LP.Character:MoveTo(v.WoodSection.CFrame.p);
							HONG:DragModel(v, sell)
							task.wait(0.1)
						end
					end)
				end
			end
		end
		HONG:Teleport(oldpos);
	end)
	
	local function teleport(config)
		local config = config or {};
		config.CFrame = config.CFrame or CFrame.new(0, 0, 0);
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = config.CFrame;
	end
	
	Page4:NewToggle("点击自动砍树", "clickautocut", false, function(v)
	    _CONFIGS["点击砍树"] = v;
		local Mouse = HONG.LP:GetMouse()
		
		local UserInputService = game:GetService("UserInputService")
		_CONFIGS["自动砍树"] = UserInputService.TouchTap:Connect(function()
			pcall(function()
				if _CONFIGS["点击砍树"] == false then
					_CONFIGS["自动砍树"]:Disconnect();
					_CONFIGS["自动砍树"] = nil;
				end
				local oldpos = HONG.LP.Character.HumanoidRootPart.CFrame
				local wood = Mouse.Target		
				local height = wood.CFrame:pointToObjectSpace(Mouse.Hit.p).Y + wood.Size.Y/2			
		
				if wood.Name == "WoodSection" then				
					repeat
						cutTree({
							Cutevent = wood.Parent.CutEvent;
							Tool = getAxe(wood.Parent.TreeClass.Value);
							Height = height;
						})
						task.wait()
					until wood:FindFirstChild("Tree Weld") == nil
				end
			end)
		end)
	end)
	
	
	_CONFIGS["处理木头"] = false
	
	
	Page4:NewButton("处理木材", function()
	    if getgenv()["点击出售木头"] == true then
	        _CONFIGS["处理木头"] = false
	        return library:Notify({
			           Title = "错误!", 
			           Text = "请先关闭点击出售木头!",
			           Duration = 4
			       })
	    end
		_CONFIGS["处理木头"] = true
		
		local UserInputService = game:GetService("UserInputService")
		library:Notify({
	       Title = "处理树", 
	       Text = "请点击一颗已砍的树, 自动分解",
	       Duration = 4
	   })		      
		getgenv().Test = UserInputService.TouchTap:Connect(function()
			if _CONFIGS["处理木头"] == false then
				if getgenv().Test then
					getgenv().Test:Disconnect();
					getgenv().Test = nil;
				end
				return
			end
			pcall(function()
				local oldpos = HONG.LP.Character.HumanoidRootPart.CFrame
				local wood = Mouse.Target.Parent;
				if wood:FindFirstChild("WoodSection") and (wood:FindFirstChild("Owner") and (wood.Owner.Value == HONG.LP) or (wood.Owner.Value == nil)) then
					if not wood:FindFirstChild"RootCut" and wood.Parent.Name == "TreeRegion" then
						return library:Notify({
	    		           Title = "错误!", 
	    		           Text = "这棵树还没有砍!",
	    		           Duration = 4
	    		       })
					end
					
					local index = 0;
					_CONFIGS["处理木头"] = false;
					for i, v in pairs(wood:GetDescendants()) do
						if v:FindFirstChild("SelectionBox") then
							v:FindFirstChild("SelectionBox"):Destroy()
						end
						if v.Name == "WoodSection" then
							index = index + 1
							local selection = Instance.new("SelectionBox")
							selection.Parent = v
							selection.Adornee = selection.Parent
							if v:WaitForChild("ID") then
								if v.ID.Value == index then
									HONG.LP.Character:MoveTo(v.CFrame.p)
									repeat
										cutTree({
											Cutevent = v.Parent.CutEvent;
											SectionId = v.ID.Value;
											Tool = getAxe(v.Parent.TreeClass.Value);
											Height = v.Size.y;
										})         
										task.wait()
									until v:FindFirstChild("Tree Weld") == nil
									--> warn("砍完", index)
									task.wait()
									if v:FindFirstChild("SelectionBox") then
										v:FindFirstChild("SelectionBox"):Destroy()
									end
								else
									index = index + 1
								end
							end
						end
					end
					task.wait()
					HONG:Teleport(oldpos)
				end
			end)
		end)
	end)
	_CONFIGS["处理木头并加工"] = false
	
	Page4:NewButton("处理木材并加工", function()
	    if getgenv()["点击出售木头"] == true then
	        return library:Notify({
			           Title = "错误!", 
			           Text = "请先关闭点击出售木头!",
			           Duration = 4
			       })
	    end
		_CONFIGS["处理木头并加工"] = true
		
		local UserInputService = game:GetService("UserInputService")
		library:Notify({
	       Title = "处理树!", 
	       Text = "请点击一颗已砍的树和加工机, 自动分解并加工",
	       Duration = 4
	   })
			       
		local oldpos = HONG.LP.Character.HumanoidRootPart.CFrame
		local sawmill = nil;
		local wood = nil;
		getgenv().CutWoodToSawmill = UserInputService.TouchTap:Connect(function()
			pcall(function()
				if _CONFIGS["处理木头并加工"] == false then
					if getgenv().CutWoodToSawmill then
						getgenv().CutWoodToSawmill:Disconnect();
						getgenv().CutWoodToSawmill = nil;
					end
					return
				end
				local model = Mouse.Target.Parent;
				if model:FindFirstChild("Owner") then
					if model.Owner.Value == HONG.LP or model.Owner.Value == nil then
						if model:FindFirstChild("WoodSection") then
							if not model:FindFirstChild"RootCut" and model.Parent.Name == "TreeRegion" then
								return HONG:NOTIFY("错误!", "这棵树还没有砍!", 4)
							end
							wood = model;
							HONG:NOTIFY("处理树", "已选择树", 4)
						end
					end
					if model:FindFirstChild("ItemName") then
						if model.Name:sub(1, 7) == "Sawmill" or model.ItemName.Value:sub(1, 7) == "Sawmill" then
							sawmill = model;
							HONG:NOTIFY("处理树", "已选择加工机", 4)
						end
					end
				end
			end)
		end)
		
	-- local UserInputService = game:GetService("UserInputService")
		-- local delta = UserInputService:GetMouseDelta()
		
	
	
		repeat
			task.wait()
		until wood ~= nil and sawmill ~= nil;
		getgenv().CutWoodToSawmill:Disconnect()
		getgenv().CutWoodToSawmill = nil
		local sawCF = sawmill.Particles.CFrame;
		local index = 0;
	
		for i, v in pairs(wood:GetDescendants()) do
			if v:FindFirstChild("SelectionBox") then
				v:FindFirstChild("SelectionBox"):Destroy()
			end
			if v.Name == "WoodSection" then
				index = index + 1
				local selection = Instance.new("SelectionBox")
	                  -->selection.Color3=Color3.new(95,95,95)
				selection.Parent = v
				selection.Adornee = selection.Parent
				if v:WaitForChild("ID") then
					if v.ID.Value == index then
	                     --    HONG:Teleport(v.CFrame + Vector3.new(0, 5, 5))
						HONG.LP.Character:MoveTo(v.CFrame.p)
						repeat
							cutTree({
								Cutevent = v.Parent.CutEvent;
								SectionId = v.ID.Value;
								Tool = getAxe(v.Parent.TreeClass.Value);
								Height = v.Size.y;
							})         
	                            -- HONG.RS.Heartbeat:wait()
							task.wait()
						until v:FindFirstChild("Tree Weld") == nil
	                        --warn("砍完", index)
						task.wait()
						if v:FindFirstChild("SelectionBox") then
							v:FindFirstChild("SelectionBox"):Destroy()
						end
						task.wait(1)
						for i = 1, 20 do
							HONG.RS.Heartbeat:wait()
							HONG:DragModel(v.Parent, sawCF)
						end
					else
						index = index + 1
					end
				end
			end
			task.wait()
		end
		HONG.RS.Heartbeat:wait()
		for _, v in next, HONG.WKSPC.LogModels:GetDescendants() do
			if v.Name == wood.Name then
				local ws = {}
				for _, c in next, v:GetChildren() do
					if c.Name == "WoodSection" then
						table.insert(ws, c)
					end
				end
				if # ws == 1 then
					for i = 1, 20 do
						HONG.RS.Heartbeat:wait()
						HONG:DragModel(v, sawCF)
					end
				end
			end
		end
		HONG:NOTIFY("处理树","已完成加工",4)
		task.wait()
		HONG:Teleport(oldpos)
	end)
	
	Page4:NewSeparator();
	
	plank1x1ByBark = function(v1)
		local v2 = {};
		v2[1] = v1;
		v2[2] = 1 / (v1.Size.x * v1.Size.z);
		if v2[2] < 0.2 then
			v2[2] = 0.3;
		end
		v2[3] = math.floor(v1.Size.y / v2[2]);
		if v2[3] < 1 then
			v2[3] = 0;
		end
		v2[4] = v1.Size.y;
		return v2;
	end
	
	Page4:NewButton("木板1x1 测试", function()
	    if getgenv()["点击出售木头"] == true then
	        return HONG:NOTIFY("错误","请先关闭点击出售木头",4)
	    end
		getgenv()["木板1x1"] = true	
		local UserInputService = game:GetService("UserInputService")
		HONG:NOTIFY("木板1x1", "请点击一块木板, 自动切割一单位", 4)
		local oldpos = HONG.LP.Character.HumanoidRootPart.CFrame
		local plank = nil;
		_CONFIGS["cutPlankByHONG"] = UserInputService.TouchTap:Connect(function()
			pcall(function()
				if getgenv()["木板1x1"] == false then
					if _CONFIGS["cutPlankByHONG"] then
						_CONFIGS["cutPlankByHONG"]:Disconnect();
						_CONFIGS["cutPlankByHONG"] = nil;
					end
					return
				end
				local model = Mouse.Target.Parent;
				if model.Name == "Plank" then
					if model:FindFirstChild("Owner") then
						if model.Owner.Value == HONG.LP or model.Owner.Value == nil then
							if model:FindFirstChild("WoodSection") then
								plank = model.WoodSection;
								HONG:NOTIFY("木板1x1", "已选择木板", 4)
							end
						end
					end
				end
			end)
		end)
		
		repeat
			task.wait()
		until plank ~= nil
		_CONFIGS["cutPlankByHONG"]:Disconnect();
		_CONFIGS["cutPlankByHONG"] = nil;
		local v0 = plank1x1ByBark(plank)
		local v1 = {}
		local v2 = v0[3]
		local v3 = false;
		if v2 == 0 then
			return
		end;
		local v4 = HONG.WKSPC.PlayerModels.ChildAdded:Connect(function(model)
			if model:WaitForChild("Owner").Value == HONG.LP and model:FindFirstChild'WoodSection' and math.floor(plank1x1ByBark(model.WoodSection)[4]) == math.floor(v0[4] - v0[2]) then
				v3 = true;
				v1 = plank1x1ByBark(model:FindFirstChild'WoodSection')
			end
		end)
		for i, v in pairs(plank.Parent:GetDescendants()) do
			if v:FindFirstChild("SelectionBox") then
				v:FindFirstChild("SelectionBox"):Destroy()
			end
		end
		for i = 1, v0[3] do
			local selection = Instance.new("SelectionBox")
			selection.Parent = v0[1]
			selection.Adornee = selection.Parent
			v3 = false;
			HONG.LP.Character:MoveTo(v0[1].CFrame.p)
			repeat
				task.wait()
				cutTree({
					Cutevent = v0[1].Parent.CutEvent;
					Tool = getAxe(v0[1].Parent.TreeClass.Value);
					Height = v0[2];
					FaceVector = Vector3.new(- 1, - 0, - 0);
				})
			until v3 or (i == v0[3] and wait(6)) or v0[1].Size.y <= 2
			if v0[1]:FindFirstChild("SelectionBox") then
				v0[1]:FindFirstChild("SelectionBox"):Destroy()
			end
			v0 = v1
		end
		v4:Disconnect()
	end)
	
	local sellAllPlank = true;
	
	Page4:NewToggle("出售全部木板", "sellallplank", false, function(v)
	    sellAllPlank = v;
		local sell = CFrame.new(315.12146, - 0.190167814, 85.0448074);
		local oldpos = HONG.LP.Character.HumanoidRootPart.CFrame
		for _, v in next, HONG.WKSPC.PlayerModels:GetDescendants() do
			if sellAllPlank == false then --> 如果不想卖了, 就中断且传送到原来的位置
				HONG:Teleport(oldpos);
				return
			end
			if v:FindFirstChild"Owner" then
				if v.Owner.Value == HONG.LP then
					if v.Name == "Plank" and v:FindFirstChild("WoodSection") then
						pcall(function()
							HONG.LP.Character:MoveTo(v.WoodSection.CFrame.p);
							for i = 1, 25 do
	                             HONG.LP.Character:MoveTo(v.WoodSection.CFrame.p);
								HONG:DragModel(v, sell)
								HONG.RS.Heartbeat:wait()
							end
							HONG.RS.Heartbeat:wait()
						end)
					end
				end
			end
		end
		HONG:Teleport(oldpos);
	end)
	
	
	Page4:NewSeparator();
	
	Page4:NewToggle("拖拽器", "dragmode", false, function(state)
	    	if state then
			_G.HardDraggerConnection = game.Workspace.ChildAdded:connect(
	            function(a)
				if a.Name == "Dragger" then
					local b = a:WaitForChild("BodyGyro")
					local c = a:WaitForChild("BodyPosition")
					local d = {
						bp_p = c.P,
						bp_d = c.D,
						bp_maxforce = c.maxForce,
						bg_p = b.P,
						bg_d = b.D,
						bg_maxtorque = b.maxTorque,
						color_backup = a.BrickColor
					}
					local e = BrickColor.new("Bright blue")
					a.BrickColor = e
					repeat
						task.wait()
						c.P = 120000
						c.D = 1000
						c.maxForce = Vector3.new(1, 1, 1) * 1000000
						b.maxTorque = Vector3.new(1, 1, 1) * 200
						b.P = 1200
						b.D = 140
					until a.Parent ~= game.Workspace
					c.maxForce = d["bp_maxforce"]
					c.D = d["bp_d"]
					c.P = d["bp_p"]
					b.maxTorque = d["bg_maxtorque"]
					b.P = d["bg_p"]
					b.D = d["bg_d"]
					a.BrickColor = d["color_backup"]
				end
			end)
			if not _G.OrigDrag then
				_G.OrigDrag = getsenv(game:GetService("Players").LocalPlayer.PlayerGui.ItemDraggingGUI.Dragger).canDrag
				getsenv(game:GetService("Players").LocalPlayer.PlayerGui.ItemDraggingGUI.Dragger).canDrag = function(f)
					if _G.OrigDrag(f) == true then
						return true
					end
					local g = game.Players.LocalPlayer.Character
					if not g then
						return
					end
					if g:FindFirstChildOfClass("Tool") then
						return
					end
					if f then
						if f.Parent then
							if 0 <= g.Humanoid.Health and f.Name == "LeafPart" then
								return false
							else
								local h = f
								repeat
									h = h.Parent
								until h.Parent.Name == "PlayerModels" or h.Parent == game.Workspace or h.Parent == game or h.Parent.Name == "LogModels"
								if h.Parent.Name == "PlayerModels" or h.Parent.Name == "LogModels" then
								end
							end
						end
					end
					return false
				end
			end
		else
			_G.HardDraggerConnection:Disconnect()
			_G.HardDraggerConnection = nil
			getsenv(game:GetService("Players").LocalPlayer.PlayerGui.ItemDraggingGUI.Dragger).canDrag = _G.OrigDrag
			_G.OrigDrag = nil
		end
	end)
	
	Page4:NewToggle("查看幻影木", "viewendtimetree", false, function(state)
	    	if state then
			local wood
			for i, v in next, HONG.WKSPC:children() do
				if v.Name == "TreeRegion" then
					for l, k in next, v:children() do
						if k:FindFirstChild"TreeClass" then
							if k.TreeClass.Value == "LoneCave" then
								wood = k
							end
						end
					end
				end
			end
			if wood == nil then
				return HONG:NOTIFY("错误!", "幻影木已被别人摧毁(其他外挂)", 4)
			end
			local woodpart
			for i, v in next, wood:children() do
				if v.Name == "WoodSection" and v:FindFirstChild"ID" and v:FindFirstChild"ID".Value == tonumber(1) then
					woodpart = v
				end
			end
			HONG.WKSPC.Camera.CameraSubject = woodpart
		else
			HONG.WKSPC.Camera.CameraSubject = HONG.LP.Character
		end
	end)
	
	function hahafunnygod()
	  local rootjoint = HONG.LP.Character.HumanoidRootPart.RootJoint
	  rootjoint:Clone().Parent = rootjoint.Parent
	  rootjoint:Destroy()
	  task.wait()
	end
	
	
	
	
	
	Page4:NewButton("无眼球砍幻影", function(bool)
		local wood = nil
		local oldpos = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame;
		
		for i, v in next, HONG.WKSPC:children() do
			if v.Name == "TreeRegion" then
				for l, k in next, v:children() do
					if k:FindFirstChild"TreeClass" then
						if k.TreeClass.Value == "LoneCave" then
							wood = k
						end
					end
				end
			end
		end
		
		
		if wood == nil then
			return HONG:NOTIFY("错误!", "幻影木没有了", 4)
		end
		togggleInvisible(1)
		hahafunnygod()
			
	    	local woodPart;
	    	for _, v in next, wood:GetDescendants() do
	    		if v.Name == "WoodSection" then
	    			if v:FindFirstChild("ID") and v.ID.Value == 1 then
	    				woodPart = v
	    			end
	    		end
	    	end
	    	repeat
	    		task.wait()
	    		HONG:Teleport(woodPart.CFrame + Vector3.new(0, 3, 3));
	    		cutTree({
	    			Cutevent = wood.CutEvent;
	    			Tool = getAxe(wood.TreeClass.Value);
	    			Height = 0.3;
	    		})
	    	until wood:FindFirstChild("RootCut")
	    	local Log
	    	for s, b in next, HONG.WKSPC.LogModels:GetDescendants() do
	    		if b:FindFirstChild"Owner" and b.Owner.Value == HONG.LP then
	    			Log = b
	    		end
	    	end
	    	task.wait(0.15)
	        task.spawn(function()
	            for cooper=1, 60 do
	                HONG.RES.Interaction.ClientIsDragging:FireServer(Log)
	                task.wait()
	            end
	        end)
	      task.wait(0.1)
	      Log.PrimaryPart = Log.WoodSection
	      for i=1, 60 do
	        Log.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
	        Log:PivotTo(oldpos)
	        task.wait()
	      end
	      task.wait()
	      HONG.LP.Character.Head:Destroy()
	      HONG.LP.CharacterAdded:Wait()
	      task.wait(1.5)
	      HONG.LP.Character.HumanoidRootPart.CFrame = Log.WoodSection.CFrame
	end)
	
	
	
	local WoodTP = {
	    "火山",
	    "蓝木",
	    "雪光木",
	    "冰木",
	    "僵尸木",
	    "橡木",
	    "樱桃木",
	    "白桦木",
	    "棕树",
	    "雪松",
	    "幻影木",
	    "椰子树",
	    "胡桃木"
	}
	local StoreTP = {
	    "木材反斗城",
	    "土地商店",
	    "盒子车行",
	    "家具店",
	    "鲍勃沙克",
	    "艺术品商店",
	    "连接逻辑店",
	    "建筑大师"
	}
	local OtherTP = {
	    "生成地",
	    "汽车杀人",
	    "小绿盒",
	    "小鸟斧",
	    "桥",
	    "幻影木出口",
	    "木材出售地",
	    "鲨鱼斧",
	    "灯塔",
	    "英灵神殿",
	    "火山秘密基地"
	}
	
	Page5:NewDropdown("商店地点", "shop_tp", StoreTP, function(new)
	    StoreTP = new;
	end)
	
	Page5:NewButton("传送!", function()
	    if type(StoreTP) == "table" then
	        HONG:NOTIFY("错误!", "请先选择地点!", 4)
	        return
	    end
	    if StoreTP == "木材反斗城" then
	        HONG:TP(273, 3, 56)
	    end
	    if StoreTP == "土地商店" then
	        HONG:TP(294, 3, -100)
	    end
	    if StoreTP == "盒子车行" then
	        HONG:TP(510, 3, -1445)
	    end
	    if StoreTP == "家具店" then
	        HONG:TP(497, 3, -1747)
	    end
	    if StoreTP == "鲍勃沙克" then
	        HONG:TP(260, 8, -2542)
	    end
	    if StoreTP == "艺术品商店" then
	        HONG:TP(5251, -166, 719)
	    end
	    if StoreTP == "连接逻辑店" then
	        HONG:TP(4608, 7, -809)
	    end
	    if StoreTP == "建筑大师" then
	        HONG:TP(1060, 17, 1131)
	    end
	end)
	
	Page5:NewSeparator();
	
	Page5:NewDropdown("木材地点", "wood_tp", WoodTP, function(new)
	    WoodTP = new;
	end)
	
	Page5:NewButton("传送!", function()
	    if type(WoodTP) == "table" then
	        HONG:NOTIFY("错误!", "请先选择地点!", 4)
	        return
	    end
	    if WoodTP == "火山" then
	        HONG:TP(-1613, 623, 1082)
	    end
	    if WoodTP == "蓝木" then
	        HONG:TP(3515, -195, 426)
	    end
	    if WoodTP == "雪光木" then
	        HONG:TP(-1135, 1, -945)
	    end
	    if WoodTP == "冰木" then
	        HONG:TP(1461, 412, 3228)
	    end
	    if WoodTP == "僵尸木" then
	        HONG:TP(-1054, 132, -1177)
	    end
	    if WoodTP == "橡木" then
	        HONG:TP(-126, 3, -1702)
	    end
	    if WoodTP == "白桦木" then
	        HONG:TP(-601, 275, 1174)
	    end
	    if WoodTP == "棕树" then
	        HONG:TP(4782, 4, -682)
	    end
	    if WoodTP == "雪松" then
	        HONG:TP(1263, 81, 1985)
	    end
	    if WoodTP == "幻影木" then
	        HONG:TP(-59, -207, -1334)
	    end
	    if WoodTP == "椰子树" then
	        HONG:TP(4330, -6, -1841)
	    end
	    if WoodTP == "胡桃木" then
	        HONG:TP(348, 3, -1536)
	    end
	    if WoodTP == "樱桃木" then
	        HONG:TP(111, 60, 1233)
	    end
	end)
	
	Page5:NewSeparator();
	
	Page5:NewDropdown("其他地点", "other_tp", OtherTP, function(new)
	    OtherTP = new;
	end)
	
	Page5:NewButton("传送!", function()
	    if type(OtherTP) == "table" then
	        HONG:NOTIFY("错误!", "请先选择地点!", 4)
	        return
	    end
	    if OtherTP == "生成地" then
	        HONG:TP(155, 3, 74)
	    end
	    if OtherTP == "小绿盒" then
	        HONG:TP(-1668, 350, 1475)
	    end
	    if OtherTP == "小鸟斧" then
	        HONG:TP(4797, 19, -983)
	    end
	    if OtherTP == "桥" then
	        HONG:TP(134, 5, -608)
	    end
	    if OtherTP == "幻影木出口" then
	        HONG:TP(-586, 74, -1414)
	    end
	    if OtherTP == "木材出售地" then
	        HONG:TP(307, -3, 105)
	    end
	    if OtherTP == "鲨鱼斧" then
	        HONG:TP(324, 46, 1923)
	    end
	    if OtherTP == "灯塔" then
	        HONG:TP(1454, 375, 3257)
	    end
	    if OtherTP == "英灵神殿" then
	        HONG:TP(-1618, 195, 938)
	    end
	    if OtherTP == "火山秘密基地" then
	        HONG:TP(-1432, 444, 1185)
	    end
	    if OtherTP == "汽车杀人" then
	        HONG:TP(-1636, 198, 1296)
	    end
	end)
	
	Page5:NewSeparator();
	
	getgenv()["玩家们"] = {}
	
	for _, v in next, HONG.GS("Players"):GetPlayers() do
	    table.insert(getgenv()["玩家们"], v.Name)
	end
	
	Page5:NewDropdown("选择玩家", "player_tp", getgenv()["玩家们"], function(plr)
	    getgenv()["玩家们"] = plr;
	end)
	
	Page5:NewButton("传送到玩家身边!", function() 
	    if type(getgenv()["玩家们"]) == "table" then
	        return HONG:NOTIFY("错误", "请先选择玩家", 4)
	    end
	    HONG:Teleport(HONG.GS("Players")[tostring(getgenv()["玩家们"])].Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0))
	end)
	
	Page5:NewButton("传送到玩家基地!", function() 
	    if type(getgenv()["玩家们"]) == "table" then
	        return HONG:NOTIFY("错误", "请先选择玩家", 4)
	    end
	    
	    for i, v in next, HONG.WKSPC.Properties:GetChildren() do
	        if v:FindFirstChild("Owner") and v.Owner.Value == HONG.GS("Players")[tostring(getgenv()["玩家们"])] then
	            HONG:Teleport(v.OriginSquare.CFrame + Vector3.new(0, 5, 0))
	        end
	    end
	end)
	
	Page5:NewToggle("查看玩家", "viewPlayer", false, function(state)
	    if state then
	        if type(getgenv()["玩家们"]) == "table" then
	            return HONG:NOTIFY("错误", "请先选择玩家", 4)
	        end
	        HONG:NOTIFY("正在观察", tostring(HONG.GS("Players")[tostring(getgenv()["玩家们"])].Name), 4)
	        HONG.WKSPC.Camera.CameraSubject = HONG.GS("Players")[tostring(getgenv()["玩家们"])].Character
	    else
	        HONG.WKSPC.Camera.CameraSubject = HONG.LP.Character
	    end
	end)
	
	Page5:NewToggle("查看玩家基地", "viewPlayerBase", false, function(state)
	    if state then
	        for i, v in next, HONG.WKSPC.Properties:GetChildren() do
	            if v:FindFirstChild("Owner") and v.Owner.Value == HONG.GS("Players")[tostring(getgenv()["玩家们"])] then
	            HONG.WKSPC.Camera.CameraSubject = v.OriginSquare
	            HONG:NOTIFY("正在观察", tostring(HONG.GS("Players")[tostring(getgenv()["玩家们"])].Name.."的基地"), 4)
	            end
	        end    
	    else
	        HONG.WKSPC.Camera.CameraSubject = HONG.LP.Character
	    end
	end)
	
	HONG.GS("Players").PlayerRemoving:Connect(function(player)  
	    if getgenv()["玩家们"] ~= nil and #getgenv()["玩家们"] >= 1 then
	        pcall(table.remove, getgenv()["玩家们"], table.find(player.Name))
	        
	        plr:refresh(getgenv()["玩家们"])
	        library.flags["player_tp1"]:RemoveOption(player.Name)
	    end
	    HONG:NOTIFY("玩家离开", ("%s离开了服务器"):format(player.Name), 4);
	end)
	
	HONG.GS("Players").PlayerAdded:Connect(function(player)
	    if getgenv()["玩家们"] ~= nil and #getgenv()["玩家们"] >= 1 then
	        if not table.find(getgenv()["玩家们"], tostring(player.Name)) then
	            table.insert(getgenv()["玩家们"], player.Name);
	        end        
	        library.flags["player_tp"]:AddOption(player.Name)
	    end
	    HONG:NOTIFY("玩家加入", ("%s加入了服务器"):format(player.Name), 4);
	end)
	
	Page5:NewSeparator();
	
	Page5:NewButton("设置位置!", function() 
	        if HONG.WKSPC:FindFirstChild("IIIII") then
	            HONG.WKSPC.IIIII:Destroy()
	        end
	        p = Instance.new("Part", HONG.WKSPC)
	        p.Name = "IIIII"
	        p.Transparency = 1
	        p.Anchored = true
	        p.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	        p.CanCollide = false
	        p.Size = game.Players.LocalPlayer.Character.HumanoidRootPart.Size
	        
	    local posBox = Instance.new("SelectionBox", p)
	    posBox.Name = "posBox"
	    posBox.Color3=Color3.new(255, 255, 255)
	    posBox.Adornee = posBox.Parent
	end)
	
	Page5:NewButton("删除位置!", function() 
	    if HONG.WKSPC:FindFirstChild("IIIII") then
	        HONG.WKSPC.IIIII:Destroy()
	    end
	end)
	
	Page5:NewButton("传送!", function() 
	    if HONG.WKSPC:FindFirstChild("IIIII") then
	        HONG:Teleport(HONG.WKSPC.IIIII.CFrame)
	    end
	end)
	
	
	DayOfNight = HONG.LIGHT.Changed:Connect(function()
	    if Day then
	        HONG.LIGHT.TimeOfDay = "11:30:00"
	    end
	
	    if Night then
	        HONG.LIGHT.TimeOfDay = "24:00:00"
	    end
	
	    if NoFog then
	        HONG.LIGHT.FogEnd = math.huge
	    end
	end)
	
	Page6:NewToggle("白天", "day", true, function(state)
	    Day = state;
	end)
	
	Page6:NewToggle("黑夜", "night", false, function(state)
	    Night = state;
	end)
	
	Page6:NewToggle("删除雾", "nofog", true, function(state)
	    NoFog = state;
	end)
	
	Page6:NewToggle("万圣节", "wsj", false, function(state)
	    HONG.LIGHT.Spook.Value = state;
	end)
	
	Page6:NewToggle("阴影", "shadow", false, function(state)
	    HONG.LIGHT.GlobalShadows = state;
	end)
	
	Page6:NewSlider("场景亮度", "bring", 2, 0, 10, false, function(v)
	    HONG.LIGHT.Brightness = v
	end)
	
	Page6:NewSeparator();
	
	Page6:NewToggle("删除水", "deletewater", false, function(state)
	    local water = {}
	    if state then
	        for _, v in next, HONG.WKSPC.Water:GetChildren() do
	    		if v.Name == "Water" then
	    			v.Transparency = 1
	    			v.CanCollide = false
	    		end
	        end
	        for _, v in next, HONG.WKSPC.Bridge.VerticalLiftBridge.WaterModel:GetChildren() do
	    		if v.Name == "Water" then
	    			v.Transparency = 1
	    			v.CanCollide = false
	    		end
	    	end
	 
	    else
	        for _, v in next, HONG.WKSPC.Water:GetChildren() do
	    		if v.Name == "Water" then
	    			v.Transparency = 0
	    			v.CanCollide = false
	    		end
	        end
	        for _, v in next, HONG.WKSPC.Bridge.VerticalLiftBridge.WaterModel:GetChildren() do
	    		if v.Name == "Water" then
	    			v.Transparency = 0
	    			v.CanCollide = false
	    		end
	    	end
	    end
	end)
	
	Page6:NewToggle("删除岩浆", "deleteLava", false, function(state)
	    if not state then
	        for i,v in next, HONG.LIGHT:GetChildren() do
	            if v.Name == "Lava" then
	                v.Parent = HONG.WKSPC.Region_Volcano
	                HONG.WKSPC.Region_Volcano.BasePlate:Destroy()
	            end
	        end
	    else
	        for i,v in next, HONG.WKSPC.Region_Volcano:GetChildren() do
	            if v.Name == "Lava" then
	                local bp = v.BasePlate:Clone()
	                bp.Parent = HONG.WKSPC.Region_Volcano
	                bp:ClearAllChildren()
	                bp.CanCollide = true
	                bp.BrickColor = HONG.WKSPC.Region_Volcano.Slate.BrickColor
	                bp.Material = HONG.WKSPC.Region_Volcano.Slate.Material
	                v.Parent = HONG.LIGHT
	            end
	        end
	    end
	end)
	
	Page6:NewToggle("删除火山巨石", "deleteBoulder", false, function(state)
	    if state then
	        for i,v in next, HONG.WKSPC.Region_Volcano.PartSpawner:GetChildren() do
	            if v.Name == "VolcanoBoulder" then
	                v.Parent = HONG.LIGHT
	            end
	        end
	    else
	        for i,v in next, HONG.LIGHT:GetChildren() do
	            if v.Name == "VolcanoBoulder" then
	                v.Parent = HONG.WKSPC.Region_Volcano.PartSpawner
	            end
	        end
	    end
	end)
	
	Page6:NewToggle("删除雪山石头", "deleteSnow", false, function(state)
	    if state then
	        for i,v in next, HONG.WKSPC.Region_Snow:GetChildren() do
	            if v.Name == "PartSpawner" then
	                v.Parent = HONG.LIGHT
	            end
	        end
	    else
	        for i,v in next, HONG.LIGHT:GetChildren() do
	            if v.Name == "PartSpawner" then
	                v.Parent = HONG.WKSPC.Region_Snow
	            end
	        end
	    end
	end)
	
	Page6:NewToggle("删除鲨鱼斧入口", "deleteDenHatch", false, function(state)
	    if state then
	        for i,v in next, HONG.WKSPC.Region_Snow.Den:GetChildren() do
	            if v.Name == "DenHatch" then
	                v.Parent = HONG.LIGHT
	            end
	        end
	    else
	        for i,v in next, HONG.LIGHT:GetChildren() do
	            if v.Name == "DenHatch" then
	                v.Parent = HONG.WKSPC.Region_Snow.Den
	            end
	        end
	    end
	end)
	
	function HONG:FreeLand()
	    local base
	    local oldtime = tick();
	    for _, v in next, HONG.WKSPC.Properties:GetChildren() do 
	        if v:FindFirstChild("Owner") and v:FindFirstChild("OriginSquare") and v.Owner.Value == nil then 
	            HONG.RES.PropertyPurchasing.ClientPurchasedProperty:FireServer(v, v.OriginSquare.OriginCFrame.Value.p + Vector3.new(0,3,0))
	       
	            wait(0.5)
	            Instance.new('RemoteEvent', HONG.RES.Interaction).Name = "Ban";
	            break
	        end
	    end            
	    	for _ ,v in next, HONG.WKSPC.Properties:GetChildren() do
	    		if v.Owner.Value == HONG.LP then
	    		    HONG:Teleport(v.OriginSquare.CFrame + Vector3.new(0,10,0));
	    		    break;
	    		end
	    	end
	    HONG:NOTIFY("完成", ("耗时%.3f秒"):format(tick() - oldtime), 4);
	end
	
	
	Page7:NewButton("免费土地", function() 
	    HONG:FreeLand()
	end)
	
	Page7:NewButton("出售土地牌子", function() 
	    local oldtime = tick();
	    local oldpos = HONG.LP.Character.HumanoidRootPart.CFrame;
	    local sell = CFrame.new(315.12146, - 0.190167814, 85.0448074);
	    
	    for _, v in next, HONG.WKSPC.PlayerModels:GetChildren() do
	        if v.Name == "Model" and v:FindFirstChild("Owner") then
	            if v.Owner.Value == HONG.LP then
	                HONG:Teleport(v:FindFirstChildOfClass("Part").CFrame)
	                task.wait()
	                HONG.RES.Interaction.ClientInteracted:FireServer(v, "Take down sold sign")
	                task.wait()
	                for i=1, 25 do
	                    HONG:DragModel(v, sell)
	                    task.wait()
	                end
	                break;
	            end
	        end
	    end
	    HONG:NOTIFY("完成", ("耗时%.3f秒"):format(tick() - oldtime), 4);
	    HONG:Teleport(oldpos)
	end)
	
	
	maxland = function()
	    local oldtime = tick();
	    for i, v in pairs(game:GetService("Workspace").Properties:GetChildren()) do
	        if v:FindFirstChild("Owner") and v.Owner.Value == game.Players.LocalPlayer then
	            base = v
	            square = v.OriginSquare
	            break;
	        end
	    end
	    function makebase(pos)
	        local Event = game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty
	        Event:FireServer(base, pos)
	    end
	    spos = square.Position
	    makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z))
	    makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z))
	    makebase(CFrame.new(spos.X, spos.Y, spos.Z + 40))
	    makebase(CFrame.new(spos.X, spos.Y, spos.Z - 40))
	    makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z + 40))
	    makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z - 40))
	    makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z + 40))
	    makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z - 40))
	    makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z))
	    makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z))
	    makebase(CFrame.new(spos.X, spos.Y, spos.Z + 80))
	    makebase(CFrame.new(spos.X, spos.Y, spos.Z - 80))
	--Corners--
	    makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z + 80))
	    makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z - 80))
	    makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z + 80))
	    makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z - 80))
	--Corners--
	    makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z + 80))
	    makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z + 80))
	    makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z + 40))
	    makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z - 40))
	    makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z + 40))
	    makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z - 40))
	    makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z - 80))
	    makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z - 80))
	    HONG:NOTIFY("完成", ("耗时%.3f秒"):format(tick() - oldtime), 4);
	end
	
	Page7:NewButton("最大土地", function() 
	    maxland()
	end)
	
	Page7:NewSeparator();
	
	function cooperAxeDupe()
	            -- get cooper
	    local cooper = game.Players.LocalPlayer
	    
	    -- can relod functin
	    local canRelod = function()
	        -- This script was generated by coopers's RemoteSpy: https://github.com/Upbolt/Hydroxide
	    
	    local ohInstance1 = cooper
	    
	    return game:GetService("ReplicatedStorage").LoadSaveRequests.ClientMayLoad:InvokeServer(ohInstance1)
	    end
	    
	    -- dup ax
	    function dupAx()
	        if cooper.CurrentSaveSlot.Value == -1 then
	            return HONG:NOTIFY("错误","请加载存档",4)
	        elseif cooper.CurrentSaveSlot.Value ~= -1 then
	            if not canRelod() then
	                HONG:NOTIFY("复制斧头","冷却时间请等待",4)
	            end
	            repeat
	                task.wait()
	            until canRelod()
	            -- This script was generated by coopers's RemoteSpy: https://github.com/Upbolt/Hydroxide
	    local ohNumber1 = cooper.CurrentSaveSlot.Value
	    local ohInstance2 = cooper
	    
	    task.spawn(function()
	        game:GetService("ReplicatedStorage").LoadSaveRequests.RequestLoad:InvokeServer(ohNumber1, ohInstance2)
	    end)
	        task.wait()
	        cooper.Character.Head:Destroy()
	        HONG:NOTIFY("复制斧头","复制中...",4)
	        return true
	        end
	    end
	    dupAx()
	end
	
	Page7:NewButton("复制斧头", function() 
	    cooperAxeDupe()
	end)
	
	
	getgenv().loopDupe = false;
	
	Page7:NewToggle("循环复制斧头", "loopdupeAxe", false, function(state)
	    getgenv().loopDupe = state;
	    while getgenv().loopDupe == true do
	        cooperAxeDupe()
	        task.wait()
	    end
	end)
	
	Page7:NewSeparator();
	
	Page7:NewButton("复制基地  需要朋友", function()
	    local item, c = HONG.WKSPC.PlayerModels.ChildAdded:Connect(function(v)
	        if v:WaitForChild("Owner") and v.Owner.Value == HONG.LP then
	            game:Shutdown();
	        end
	    end)
	    HONG.RES.LoadSaveRequests.RequestLoad:InvokeServer(3, HONG.LP);
	end)
	
	Page7:NewSeparator();
	
	_CONFIGS["填充工具"] = false;
	
	
	Page7:NewToggle("木板填充蓝图", "planktoblueprint", false, function(state)
	       if getgenv()["点击出售木头"] == true then
	        return HONG:NOTIFY("错误","请先关闭点击出售木头",4)
	    end
		_CONFIGS["填充工具"] = state
		
		while _CONFIGS["填充工具"]  == true do
		
		local UserInputService = game:GetService("UserInputService")
		HONG:NOTIFY("填充蓝图", "请点击一个蓝图和木板, 填充到蓝图", 4)
		local oldpos = HONG.LP.Character.HumanoidRootPart.CFrame
		local bp = nil;
		local plank = nil;
		getgenv().PlankToBp = UserInputService.TouchTap:Connect(function()
			pcall(function()
				if _CONFIGS["填充工具"] == false then
					if getgenv().PlankToBp then
						getgenv().PlankToBp:Disconnect();
						getgenv().PlankToBp = nil;
					end
					return
				end
				local model = Mouse.Target.Parent;
				if model:FindFirstChild("Owner") then
					if model.Owner.Value == HONG.LP or model.Owner.Value == nil then
					    if model.Name == "Plank" then
	    					if model:FindFirstChild("WoodSection") then   					
	    						plank = model;
	    						local v1 = Instance.new("BoxHandleAdornment", plank.WoodSection)
	    						
	    						local selection = Instance.new("SelectionBox")
			                    selection.Parent = plank.WoodSection
			                    selection.Adornee = selection.Parent
			                    selection.Name = "Selection"
	                            
	    						HONG:NOTIFY("填充蓝图", "已选择木板", 4)
	    					end
	    		        end
					end
					if model:FindFirstChild("Type") and model.Type.Value == "Blueprint" then
						bp = model;
						
						local selection = Instance.new("SelectionBox")
	                    selection.Parent = bp.BuildDependentWood
	                    selection.Adornee = selection.Parent
	                    selection.Name = "Selection"
			             
	                    
						HONG:NOTIFY("填充蓝图", "已选择蓝图", 4)
					end
				end
			end)
		end)
		
		
		repeat
			task.wait()
		until plank ~= nil and bp ~= nil;
		getgenv().PlankToBp:Disconnect()
		getgenv().PlankToBp = nil
		
		
	    HONG.LP.Character:MoveTo(plank.WoodSection.Position)
	    for i=1, 25 do
	        HONG:DragModel(plank, bp.Main.CFrame)
	        task.wait()
	    end    
	    plank.WoodSection.Selection:Destroy()
	    bp.BuildDependentWood.Selection:Destroy()
	    HONG:Teleport(oldpos)
	    task.wait()
	    end
	end)
	
	Page7:NewSeparator();
	
	Page7:NewButton("设置位置!", function() 
	    if HONG.WKSPC:FindFirstChild("BRING") then
	        HONG.WKSPC.BRING:Destroy()
	    end
	    p = Instance.new("Part", HONG.WKSPC)
	    p.Name = "BRING"
	    p.Transparency = 1
	    p.Anchored = true
	    p.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	    p.CanCollide = false
	    p.Size = game.Players.LocalPlayer.Character.HumanoidRootPart.Size
	        
	    local posBox = Instance.new("SelectionBox", p)
	    posBox.Name = "BRINGBOX"
	    posBox.Color3=Color3.new(0, 255, 0)
	    posBox.Adornee = posBox.Parent
	end)
	
	Page7:NewButton("删除位置!", function() 
	    if HONG.WKSPC:FindFirstChild("BRING") then
	        HONG.WKSPC.BRING:Destroy()
	    end
	end)
	
	Page7:NewButton("获取传送工具!", function() 
	    if HONG.LP.Backpack:FindFirstChild"点击传送任何物品" or HONG.LP.Character:FindFirstChild"点击传送任何物品" then
		HONG.LP.Backpack["点击传送任何物品"]:Destroy()
	    end;
	    local a = Instance.new("Tool", HONG.LP.Backpack)
	    a.Name = "点击传送任何物品"
	    a.RequiresHandle = false;
	    a.Activated:Connect(function()
	    	if HONG.WKSPC:FindFirstChild("BRING") then
	    		local b = HONG.WKSPC.BRING.CFrame;
	    		local c = Mouse.Target.Parent;
	    		if not c:FindFirstChild"RootCut" and c.Parent.Name == "TreeRegion" then
	    			return
	    		end;
	    		if c:FindFirstChild("Type") and c.Type.Value == "Blueprint" and not c:FindFirstChild("PurchasedBoxItemName") then
	    			return
	    		end;
	    		if c:FindFirstChild("Type") and c.Type.Value == "Vehicle Spot" then
	    			return
	    		end;
	    		if c:FindFirstChild("Type") and c.Type.Value == "Furniture" and not c:FindFirstChild("PurchasedBoxItemName") then
	    			return
	    		end;
	    		if c:FindFirstChild("Type") and c.Type.Value == "Wire" and not c:FindFirstChild("PurchasedBoxItemName") then
	    			return
	    		end;
	    		if c:FindFirstChild("Type") and c.Type.Value == "Structure" and not c:FindFirstChild("PurchasedBoxItemName") then
	    			return
	    		end;
	    		if c:FindFirstChild("TreeClass") or c.Name == "Plank" or c:FindFirstChild("Type") then
	    			local d = HONG.LP.Character.HumanoidRootPart.CFrame;
	    			if c:FindFirstChild"Owner" then
	    				local e = c:FindFirstChildOfClass("Part")
	    				pcall(function()
	    					HONG.LP.Character:MoveTo(e.CFrame.p)
	    				end)
	    				c.PrimaryPart = e;
	    				for f = 1, 60 do
	    					c.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
	    					HONG.RES.Interaction.ClientIsDragging:FireServer(c)
	    					c:PivotTo(b)
	    					task.wait(0.01)
	    				end
	    			end
	    		else
	    			return
	    		end
	    	end
	    end)
	end)
	
	
	Page8:NewSlider("汽车速度", "carSpeedSlider", 1, 0, 10, false, function(v)
	    if HONG.LP.Character.Humanoid.SeatPart ~= nil then
	    	local Vehicle = HONG.LP.Character.Humanoid.SeatPart.Parent
	        if not Vehicle then
	            return
	        end
	      Vehicle.Configuration:FindFirstChild'MaxSpeed'.Value = v;
	    end
	end)
	
	Page8:NewButton("翻转汽车", function() 
	    if HONG.LP.Character.Humanoid.SeatPart ~= nil then
	        cf = HONG.LP.Character.HumanoidRootPart.CFrame * CFrame.fromEulerAnglesXYZ(90, 0, 0)
	        local plr = HONG.LP
	        local plrc = plr.Character
	        local mdl = plrc.Humanoid.SeatPart.Parent
	        if plrc.Humanoid.SeatPart.Name ~= "DriveSeat" then return end
	        if (cf.p-plrc.HumanoidRootPart.CFrame.p).Magnitude >= 175 then
	            local ocf = mdl.PrimaryPart.CFrame + Vector3.new(0,5,0)
	            local intensity = 20
	            if mdl.Seat:FindFirstChild'SeatWeld' then intensity = 30 end
	            local rotmag = intensity
	            for i = 1,intensity do
	                rotmag = rotmag * 1.05
	                HONG.RS.RenderStepped:wait()
	                mdl:SetPrimaryPartCFrame(ocf*CFrame.Angles(0, math.rad(rotmag*i), 0))
	            end
	            for i=1,0.8*intensity do
	                HONG.RS.RenderStepped:wait()
	                mdl:SetPrimaryPartCFrame(cf)
	            end
	        else
	            mdl:SetPrimaryPartCFrame(cf)
	        end
	    end
	end)
	
	Page8:NewSeparator();
	
	_CONFIGS["刷粉车"] = false;
	
	
	local CAR = nil
	local FP = nil
	
	HONG.WKSPC.PlayerModels.ChildAdded:connect(function(v) if v:WaitForChild("Owner") then
	    if v.Owner.Value == HONG.LP then
	        if v:WaitForChild("PaintParts") then
	            FP = v.PaintParts.Part
	        end
	    end
	  end
	end)
	
	
	Page8:NewButton("开始!", function() 
	    _CONFIGS["刷粉车"] = true
	    local UserInputService = game:GetService("UserInputService")
		HONG:NOTIFY("刷粉车", "请点击一个车位, 自动刷粉车", 4)
		local carSpawn = nil
		
		_CONFIGS["粉车器"] = UserInputService.TouchTap:Connect(function()
			pcall(function()
				if _CONFIGS["刷粉车"] == false then
					if _CONFIGS["粉车器"] then
						_CONFIGS["粉车器"]:Disconnect();
						_CONFIGS["粉车器"] = nil;
					end
					return
				end
				local model = Mouse.Target.Parent;
	             if model:FindFirstChild("Type") then
	                 if model.Type.Value == "Vehicle Spot" then
	                     carSpawn = model.ButtonRemote_SpawnButton;
	                     HONG:NOTIFY("刷粉车", "车位已选择", 4)
	                     local selection = Instance.new("SelectionBox")
	                     selection.Parent = model.Main
	                     selection.Adornee = selection.Parent
	                    selection.Name = "CarSpawnS"
	                 end
	             end
	        end)
	    end)
	    repeat task.wait()
	    until carSpawn ~= nil
	    _CONFIGS["粉车器"]:Disconnect();
		_CONFIGS["粉车器"] = nil;
	    repeat
	        task.wait(0.5)
			HONG.RES.Interaction.RemoteProxy:FireServer(carSpawn)
			repeat wait() until FP ~= CAR
			CAR = FP
		until  FP.BrickColor.Name == "Hot pink"
		HONG:NOTIFY("刷粉车","已完成",4)
		carSpawn.Parent.Main:FindFirstChild("CarSpawnS"):Destroy()
	end)
	else
		local plr = game:GetService("Players").LocalPlayer;
		plr:Kick("没有白名单, 请加作者QQ购买白名单: \n3539186671");
		while true do
		end
	end

end)("走马观花 X")  --> 脚本名字, 双引号里面的中文可以改