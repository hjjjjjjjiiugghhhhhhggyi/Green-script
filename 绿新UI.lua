--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.2.8) ~  Much Love, Ferib 

]]--

local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit ;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v42,v43)local v44={};for v52=1, #v42 do v6(v44,v0(v4(v1(v2(v42,v52,v52 + 1 )),v1(v2(v43,1 + (v52% #v43) ,1 + (v52% #v43) + 1 )))%256 ));end return v5(v44);end local v8=game:GetService(v7("\226\215\218\55\242\190\213\57\196\202","\126\177\163\187\69\134\219\167"));v8:SetCore(v7("\16\200\36\193\210\44\217\35\195\245\32\204\62\204\243\45","\156\67\173\74\165"),{[v7("\0\190\93\26\185","\38\84\215\41\118\220\70")]="反挂机已自动开启",[v7("\100\19\58\6","\158\48\118\66\114")]="被踢出服务器的概率已降低",[v7("\143\49\2\55\103\172\244\165","\155\203\68\112\86\19\197")]=5});wait(1 + 1 );local v8=game:GetService(v7("\117\201\55\238\84\125\247\223\83\212","\152\38\189\86\156\32\24\133"));v8:SetCore(v7("\207\82\169\66\210\88\179\79\250\94\164\71\232\94\168\72","\38\156\55\199"),{[v7("\156\116\104\36\22","\35\200\29\28\72\115\20\154")]="启动成功",[v7("\45\186\201\203","\84\121\223\177\191\237\76")]="您好"   .. game.Players.LocalPlayer.Name   .. "，绿🌲" ,[v7("\159\67\219\161\46\89\63\207","\161\219\54\169\192\90\48\80")]=703 -(208 + 490) });local v9=Instance.new(v7("\122\65\18\32\76\76\39\48\64","\69\41\34\96"),getParent);local v10=Instance.new(v7("\136\198\207\30\46\42\190\198\219","\75\220\163\183\106\98"),getParent);local v11=game.Players.LocalPlayer;v9.Name=v7("\46\152\167\16","\185\98\218\235\87");v9.Parent=game.CoreGui;v9.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;v9.Enabled=true;v10.Name=v7("\231\30\11","\202\171\92\71\134\190");v10.Parent=v9;v10.BackgroundColor3=Color3.new(1,1 + 0 ,1);v10.BackgroundTransparency=1 + 0 ;v10.BorderColor3=Color3.new(836 -(660 + 176) ,0 + 0 ,202 -(14 + 188) );v10.Position=UDim2.new(0.75,675 -(534 + 141) ,0.01,0 + 0 );v10.Size=UDim2.new(0,118 + 15 ,0,29 + 1 );v10.Font=Enum.Font.GothamSemibold;v10.Text=v7("\29\196\52\156\5\192\46\141\37","\232\73\161\76");v10.TextColor3=Color3.new(1 -0 ,1 -0 ,2 -1 );v10.TextScaled=true;v10.TextSize=14;v10.TextWrapped=true;v10.Visible=true;local v33=v10;local v34=game:GetService(v7("\137\204\76\110\27\169\207\75\94\27","\126\219\185\34\61")).Heartbeat;local v35,v36;local v37={};local function v38()local v45=0 + 0 ;local v46;while true do if (v45==2) then v46=v46-(v46%(1 + 0)) ;v33.Text="北京时间:"   .. os.date(v7("\73\230","\135\108\174\62\18\30\23\147"))   .. "时"   .. os.date(v7("\243\196","\167\214\137\74\171\120\206\83"))   .. "分"   .. os.date(v7("\206\195","\199\235\144\82\61\152")) ;break;end if (v45==(397 -(115 + 281))) then v37[2 -1 ]=v35;v46=(((tick() -v36)>=(1 + 0)) and  #v37) or ( #v37/(tick() -v36)) ;v45=4 -2 ;end if (v45==(0 -0)) then v35=tick();for v55= #v37,868 -(550 + 317) , -1 do v37[v55 + (1 -0) ]=((v37[v55]>=(v35-(1 -0))) and v37[v55]) or nil ;end v45=2 -1 ;end end end v36=tick();v34:Connect(v38);local v39=loadstring(game:HttpGet("https://raw.githubusercontent.com/WS857960/-/main/QJBDUI.txt"))();local v40=v39:MakeWindow({[v7("\41\23\180\46","\75\103\118\217")]="绿🌲",[v7("\239\93\116\17\137\12\194\89\121\1\180","\126\167\52\16\116\217")]=false,[v7("\251\47\54\133\151\22\242\206\39\39","\156\168\78\64\224\212\121")]=true,[v7("\46\224\177\220\8\218\160\214\19","\174\103\142\197")]="绿🌲",[v7("\117\39\81\62\44\89\222\89\36\91\61\55","\152\54\72\63\88\69\62")]="好闲"});v39:MakeNotification({[v7("\250\197\227\89","\60\180\164\142")]="欢迎使用绿🌲,作者QQ:2099718854",[v7("\123\81\11\61\34\227\6","\114\56\62\101\73\71\141")]="当前游戏ID为:"   .. game.GameId   .. " " ,[v7("\145\228\218\195\189","\164\216\137\187")]="rbxassetid://7734068321",[v7("\230\239\60\183","\107\178\134\81\210\198\158")]=295 -(134 + 151) });local v41=v40:MakeTab({[v7("\22\15\143\195","\202\88\110\226\166")]="首页",[v7("\234\12\141\249","\170\163\111\226\151")]="rbxassetid://4483345998",[v7("\33\34\183\53\71\34\36\62\62\190\33","\73\113\80\210\88\46\87")]=false});v41:AddParagraph("你好"   .. game.Players.LocalPlayer.Name   .. ",欢迎使用绿🍀" ,"脚本仅供娱乐");v41:AddParagraph("您的用户名:"," "   .. game.Players.LocalPlayer.Name   .. "" );v41:AddParagraph("您的注入器:"," "   .. identifyexecutor()   .. "" );v41:AddParagraph("您当前服务器的ID"," "   .. game.GameId   .. "" );v41:AddParagraph("反挂机已启动","");v41:AddButton({[v7("\175\45\192\23","\135\225\76\173\114")]="反挂机2",[v7("\57\236\180\188\174\188\164\17","\199\122\141\216\208\204\221")]=function()loadstring(game:HttpGet("https://pastebin.com/raw/9fFu43FF"))();end});v41:AddButton({[v7("\131\220\29\245","\150\205\189\112\144\24")]="娱乐蓝屏(还需要手动开启)(大退关闭)",[v7("\6\133\179\64\6\137\18\27","\112\69\228\223\44\100\232\113")]=function()local v47=Instance.new(v7("\231\28\21\214\179\114\161\193\22","\230\180\127\103\179\214\28"),game:service(v7("\175\10\77\67\195\84\233","\128\236\101\63\38\132\33")));local v48=Instance.new(v7("\152\172\9\80\148\254\219\184\166\31","\175\204\201\113\36\214\139"),v47);v48.Size=UDim2.new(1665 -(970 + 695) ,381 -181 ,0,100);v48.Position=UDim2.new(1990.5 -(582 + 1408) ,0 -0 ,0.5 -0 ,0);v48.Text="点击蓝屏";v48.MouseButton1Click:Connect(loadstring(game:HttpGet("https://github.com/RunDTM/roblox-bluescreen/raw/main/bsod.lua")));end});v41:AddButton({[v7("\105\205\56\217","\100\39\172\85\188")]="复制作者QQ号",[v7("\142\121\181\140\49\172\123\178","\83\205\24\217\224")]=function()setclipboard(v7("\180\149\148\100\177\148\149\101\179\145","\93\134\165\173"));end});v41:AddButton({[v7("\144\243\204\199","\30\222\146\161\162\90\174\210")]="复制QQ群",[v7("\198\79\124\6\231\79\115\1","\106\133\46\16")]=function()setclipboard(v7("\0\117\35\171\12\21\14\112\38","\32\56\64\19\156\58"));end});local v41=v40:MakeTab({[v7("\116\201\232\83","\224\58\168\133\54\58\146")]="脚本",[v7("\112\85\68\243","\107\57\54\43\157\21\230\231")]="rbxassetid://4483345998",[v7("\235\153\20\248\176\201\194\244\133\29\236","\175\187\235\113\149\217\188")]=false});v41:AddButton({[v7("\18\174\140\73","\24\92\207\225\44\131\25")]="绿脚本",[v7("\104\210\180\64\25\124\72\216","\29\43\179\216\44\123")]=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/hjjjjjjjiiugghhhhhhggyi/Green-script/main/%E7%AC%AC%E4%BA%8C%E5%B1%82%E5%8A%A0%E5%AF%86.lua",true))();end});