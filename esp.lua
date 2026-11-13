local ESPLib = {
    Enabled = true,
    BoxType = "Corner",
    ShowNames = true,
    ShowHealth = true,
    ShowDistance = true,
    ShowVisibilityFlag = true,
    MaxDistance = 1000,
    Colors = {
        Box1 = Color3.fromRGB(214, 129, 129),
        Box2 = Color3.fromRGB(120, 71, 71),
        Text1 = Color3.fromRGB(201, 79, 79),
        Text2 = Color3.fromRGB(102, 41, 41),
        Health1 = Color3.fromRGB(201, 79, 79),
        Health2 = Color3.fromRGB(102, 41, 41)
    },
    Objects = {}
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local localPlayer = Players.LocalPlayer
while not localPlayer do
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    localPlayer = Players.LocalPlayer
end

local function getRandomName()
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    local length = math.random(12, 22)
    local name = ""
    for i = 1, length do
        local rand = math.random(1, #chars)
        name = name .. chars:sub(rand, rand)
    end
    return name
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = getRandomName()
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 10
ScreenGui.IgnoreGuiInset = true

task.spawn(function()
    local success = pcall(function()
        if gethui then ScreenGui.Parent = gethui() else ScreenGui.Parent = CoreGui end
    end)
    if not success or not ScreenGui.Parent then
        local pg = localPlayer:FindFirstChild("PlayerGui")
        while not pg do task.wait(0.1) pg = localPlayer:FindFirstChild("PlayerGui") end
        ScreenGui.Parent = pg
    end
end)

local function createCornerLine(zindex)
    local line = Instance.new("Frame")
    line.Name = getRandomName()
    line.BackgroundColor3 = Color3.new(1, 1, 1)
    line.BorderSizePixel = 0
    line.ZIndex = zindex or 1
    line.Visible = false
    line.Parent = ScreenGui
    return line
end

local function createTextLabel(text, zIndex)
    local label = Instance.new("TextLabel")
    label.Name = getRandomName()
    label.Text = text
    label.Font = Enum.Font.Code
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextSize = 13
    label.BackgroundTransparency = 1
    label.ZIndex = zIndex
    label.Size = UDim2.new(0, 0, 0, 0)
    label.Visible = false
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Parent = ScreenGui

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.new(0, 0, 0)
    stroke.Thickness = 1
    stroke.Parent = label

    return label
end

function ESPLib.GetCharacter(target)
    if typeof(target) == "Instance" then
        if target:IsA("Player") then
            return target.Character
        elseif target:IsA("Model") then
            return target
        end
    end
    return nil
end

function ESPLib.GetRootPart(character)
    if not character then return nil end
    return character:FindFirstChild("HumanoidRootPart")
        or character:FindFirstChild("RootPart")
        or character:FindFirstChild("Torso")
        or character:FindFirstChild("UpperTorso")
        or character.PrimaryPart
        or character:FindFirstChildWhichIsA("BasePart")
end

function ESPLib.GetHealth(character)
    if not character then return 0, 100 end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        return humanoid.Health, humanoid.MaxHealth
    end
    local hp = character:GetAttribute("Health") or 100
    local maxHp = character:GetAttribute("MaxHealth") or 100
    return hp, maxHp
end

local function createDrawings(displayName)
    local boxMain = Instance.new("Frame") boxMain.Name = getRandomName() boxMain.BackgroundTransparency = 1 boxMain.Visible = false boxMain.Parent = ScreenGui
    local strokeMain = Instance.new("UIStroke") strokeMain.Name = getRandomName() strokeMain.Thickness = 1 strokeMain.Color = Color3.fromRGB(255, 255, 255) strokeMain.LineJoinMode = Enum.LineJoinMode.Miter strokeMain.Parent = boxMain
    local gradMain = Instance.new("UIGradient") gradMain.Rotation = 90 gradMain.Parent = strokeMain
    local boxOutline = Instance.new("Frame") boxOutline.Name = getRandomName() boxOutline.BackgroundTransparency = 1 boxOutline.Visible = false boxOutline.Parent = ScreenGui
    local strokeOutline = Instance.new("UIStroke") strokeOutline.Name = getRandomName() strokeOutline.Thickness = 1 strokeOutline.Color = Color3.fromRGB(0, 0, 0) strokeOutline.LineJoinMode = Enum.LineJoinMode.Miter strokeOutline.Parent = boxOutline
    local boxInline = Instance.new("Frame") boxInline.Name = getRandomName() boxInline.BackgroundTransparency = 1 boxInline.Visible = false boxInline.Parent = ScreenGui
    local strokeInline = Instance.new("UIStroke") strokeInline.Name = getRandomName() strokeInline.Thickness = 1 strokeInline.Color = Color3.fromRGB(0, 0, 0) strokeInline.LineJoinMode = Enum.LineJoinMode.Miter strokeInline.Parent = boxInline

    local o_tl_h = createCornerLine(1) o_tl_h.BackgroundColor3 = Color3.new(0,0,0) local o_tl_v = createCornerLine(1) o_tl_v.BackgroundColor3 = Color3.new(0,0,0) local o_tr_h = createCornerLine(1) o_tr_h.BackgroundColor3 = Color3.new(0,0,0) local o_tr_v = createCornerLine(1) o_tr_v.BackgroundColor3 = Color3.new(0,0,0) local o_bl_h = createCornerLine(1) o_bl_h.BackgroundColor3 = Color3.new(0,0,0) local o_bl_v = createCornerLine(1) o_bl_v.BackgroundColor3 = Color3.new(0,0,0) local o_br_h = createCornerLine(1) o_br_h.BackgroundColor3 = Color3.new(0,0,0) local o_br_v = createCornerLine(1) o_br_v.BackgroundColor3 = Color3.new(0,0,0)
    local tl_h = createCornerLine(2) local tl_v = createCornerLine(2) local tr_h = createCornerLine(2) local tr_v = createCornerLine(2) local bl_h = createCornerLine(2) local bl_v = createCornerLine(2) local br_h = createCornerLine(2) local br_v = createCornerLine(2)

    local CornerColoredLines = {tl_h, tl_v, tr_h, tr_v, bl_h, bl_v, br_h, br_v}
    local CornerOutlineLines = {o_tl_h, o_tl_v, o_tr_h, o_tr_v, o_bl_h, o_bl_v, o_br_h, o_br_v}
    local CornerGradients = {}
    for _, line in ipairs(CornerColoredLines) do local g = Instance.new("UIGradient") g.Rotation = 90 g.Parent = line table.insert(CornerGradients, g) end

    local healthBorder = Instance.new("Frame") healthBorder.Name = getRandomName() healthBorder.BackgroundColor3 = Color3.fromRGB(0, 0, 0) healthBorder.BorderSizePixel = 0 healthBorder.Visible = false healthBorder.ZIndex = 1 healthBorder.Parent = ScreenGui
    local healthBg = Instance.new("Frame") healthBg.Name = getRandomName() healthBg.BackgroundColor3 = Color3.fromRGB(25, 25, 25) healthBg.BorderSizePixel = 0 healthBg.Visible = false healthBg.ZIndex = 2 healthBg.Parent = ScreenGui
    local healthBar = Instance.new("Frame") healthBar.Name = getRandomName() healthBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255) healthBar.BorderSizePixel = 0 healthBar.ZIndex = 3 healthBar.Visible = false healthBar.Parent = healthBg
    local gradHealth = Instance.new("UIGradient") gradHealth.Rotation = 90 gradHealth.Parent = healthBar

    local nameLabel = createTextLabel(displayName, 5) local gradName = Instance.new("UIGradient") gradName.Rotation = 90 gradName.Parent = nameLabel
    local distLabel = createTextLabel("[0]", 5) local gradDist = Instance.new("UIGradient") gradDist.Rotation = 90 gradDist.Parent = distLabel
    local flagLabel = createTextLabel("Visible", 5) local gradFlag = Instance.new("UIGradient") gradFlag.Rotation = 90 gradFlag.Parent = flagLabel

    return {
        Main = boxMain, Outline = boxOutline, Inline = boxInline, GradMain = gradMain, StrokeMain = strokeMain,
        CornerColoredLines = CornerColoredLines, CornerOutlineLines = CornerOutlineLines, CornerGradients = CornerGradients,
        HealthBorder = healthBorder, HealthBg = healthBg, HealthBar = healthBar, GradHealth = gradHealth,
        NameLabel = nameLabel, GradName = gradName,
        DistLabel = distLabel, GradDist = gradDist,
        FlagLabel = flagLabel, GradFlag = gradFlag
    }
end

function ESPLib:Remove(target)
    local cache = self.Objects[target]
    if cache then
        if cache.Connection then pcall(function() cache.Connection:Disconnect() end) end
        if cache.Main then pcall(function() cache.Main:Destroy() end) end
        if cache.Outline then pcall(function() cache.Outline:Destroy() end) end
        if cache.Inline then pcall(function() cache.Inline:Destroy() end) end
        for _, line in ipairs(cache.CornerColoredLines or {}) do pcall(function() line:Destroy() end) end
        for _, line in ipairs(cache.CornerOutlineLines or {}) do pcall(function() line:Destroy() end) end
        if cache.HealthBorder then pcall(function() cache.HealthBorder:Destroy() end) end
        if cache.HealthBg then pcall(function() cache.HealthBg:Destroy() end) end
        if cache.HealthBar then pcall(function() cache.HealthBar:Destroy() end) end

        for _, label in ipairs({cache.NameLabel, cache.DistLabel, cache.FlagLabel}) do
            if label then pcall(function() label:Destroy() end) end
        end
        self.Objects[target] = nil
    end
end

function ESPLib:AddCharacter(model, customName)
    if not model or self.Objects[model] then return end
    local cache = createDrawings(customName or model.Name)
    cache.Target = model
    cache.IsCustom = true
    if typeof(model) == "Instance" then
        cache.Connection = model.AncestryChanged:Connect(function(_, parent)
            if not parent then
                self:Remove(model)
            end
        end)
    end
    self.Objects[model] = cache
end

function ESPLib:AddPlayer(player)
    if player == localPlayer or self.Objects[player] then return end
    local cache = createDrawings(player.Name)
    cache.Target = player
    cache.IsCustom = false
    self.Objects[player] = cache
end

for _, player in ipairs(Players:GetPlayers()) do
    ESPLib:AddPlayer(player)
end

Players.PlayerAdded:Connect(function(player)
    ESPLib:AddPlayer(player)
end)

Players.PlayerRemoving:Connect(function(player)
    ESPLib:Remove(player)
end)

RunService.RenderStepped:Connect(function()
    local Camera = workspace.CurrentCamera
    if not Camera then return end

    for target, cache in pairs(ESPLib.Objects) do
        local character = cache.IsCustom and target or ESPLib.GetCharacter(target)
        local isVisible = false

        if character and ESPLib.Enabled then
            local hrp = ESPLib.GetRootPart(character)
            local currentHealth, maxHealth = ESPLib.GetHealth(character)

            if hrp and currentHealth > 0 then
                local distance = (hrp.Position - Camera.CFrame.Position).Magnitude

                if distance <= ESPLib.MaxDistance then
                    local rPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                    if onScreen then
                        local topScreen = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 2.5, 0))
                        local bottomScreen = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, -3.0, 0))
                        local sizeY = math.max(10, math.floor(math.abs(bottomScreen.Y - topScreen.Y)))
                        local sizeX = math.max(6, math.floor(sizeY / 1.6))

                        if sizeY > 2 then
                            isVisible = true

                            local posX = math.floor(rPos.X - sizeX / 2)
                            local posY = math.floor(topScreen.Y)

                            local dynamicTextSize = math.clamp(math.floor(sizeY / 3), 9, 14)
                            local colors = ESPLib.Colors

                            local csBox = ColorSequence.new(colors.Box1, colors.Box2)
                            local csText = ColorSequence.new(colors.Text1, colors.Text2)
                            local csHealth = ColorSequence.new(colors.Health1, colors.Health2)

                            cache.GradMain.Color = csBox
                            for _, g in ipairs(cache.CornerGradients) do g.Color = csBox end
                            cache.GradHealth.Color = csHealth
                            cache.GradName.Color = csText
                            cache.GradDist.Color = csText
                            cache.GradFlag.Color = csText

                            if ESPLib.BoxType == "2D" then
                                cache.Main.Visible = true
                                cache.Main.Size = UDim2.new(0, sizeX, 0, sizeY)
                                cache.Main.Position = UDim2.new(0, posX, 0, posY)
                                cache.Main.BackgroundTransparency = 1
                                cache.StrokeMain.Color = Color3.new(1, 1, 1)
                                cache.GradMain.Color = csBox
                                cache.Outline.Visible = true
                                cache.Outline.Size = UDim2.new(0, sizeX + 2, 0, sizeY + 2)
                                cache.Outline.Position = UDim2.new(0, posX - 1, 0, posY - 1)
                                cache.Inline.Visible = true
                                cache.Inline.Size = UDim2.new(0, sizeX - 2, 0, sizeY - 2)
                                cache.Inline.Position = UDim2.new(0, posX + 1, 0, posY + 1)

                                for _, line in ipairs(cache.CornerColoredLines) do line.Visible = false end
                                for _, line in ipairs(cache.CornerOutlineLines) do line.Visible = false end

                            elseif ESPLib.BoxType == "Corner" then
                                cache.Main.Visible = false cache.Outline.Visible = false cache.Inline.Visible = false

                                local X1 = posX local X2 = posX + sizeX - 1 local Y_top = posY - 1 local Y_bot = posY + sizeY
                                local cLen = math.max(1, math.floor(sizeX / 3))

                                local o_tl_h, o_tl_v, o_tr_h, o_tr_v, o_bl_h, o_bl_v, o_br_h, o_br_v = unpack(cache.CornerOutlineLines)
                                local tl_h, tl_v, tr_h, tr_v, bl_h, bl_v, br_h, br_v = unpack(cache.CornerColoredLines)

                                o_tl_h.Size = UDim2.new(0, cLen + 2, 0, 3) o_tl_h.Position = UDim2.new(0, X1 - 1, 0, Y_top - 1) o_tl_h.Visible = true
                                tl_h.Size = UDim2.new(0, cLen, 0, 1) tl_h.Position = UDim2.new(0, X1, 0, Y_top) tl_h.Visible = true
                                o_tl_v.Size = UDim2.new(0, 3, 0, cLen + 2) o_tl_v.Position = UDim2.new(0, X1 - 1, 0, Y_top - 1) o_tl_v.Visible = true
                                tl_v.Size = UDim2.new(0, 1, 0, cLen) tl_v.Position = UDim2.new(0, X1, 0, Y_top) tl_v.Visible = true
                                o_tr_h.Size = UDim2.new(0, cLen + 2, 0, 3) o_tr_h.Position = UDim2.new(0, X2 - cLen, 0, Y_top - 1) o_tr_h.Visible = true
                                tr_h.Size = UDim2.new(0, cLen, 0, 1) tr_h.Position = UDim2.new(0, X2 - cLen + 1, 0, Y_top) tr_h.Visible = true
                                o_tr_v.Size = UDim2.new(0, 3, 0, cLen + 2) o_tr_v.Position = UDim2.new(0, X2 - 1, 0, Y_top - 1) o_tr_v.Visible = true
                                tr_v.Size = UDim2.new(0, 1, 0, cLen) tr_v.Position = UDim2.new(0, X2, 0, Y_top) tr_v.Visible = true
                                o_bl_h.Size = UDim2.new(0, cLen + 2, 0, 3) o_bl_h.Position = UDim2.new(0, X1 - 1, 0, Y_bot - 1) o_bl_h.Visible = true
                                bl_h.Size = UDim2.new(0, cLen, 0, 1) bl_h.Position = UDim2.new(0, X1, 0, Y_bot) bl_h.Visible = true
                                o_bl_v.Size = UDim2.new(0, 3, 0, cLen + 2) o_bl_v.Position = UDim2.new(0, X1 - 1, 0, Y_bot - cLen) o_bl_v.Visible = true
                                bl_v.Size = UDim2.new(0, 1, 0, cLen) bl_v.Position = UDim2.new(0, X1, 0, Y_bot - cLen + 1) bl_v.Visible = true
                                o_br_h.Size = UDim2.new(0, cLen + 2, 0, 3) o_br_h.Position = UDim2.new(0, X2 - cLen, 0, Y_bot - 1) o_br_h.Visible = true
                                br_h.Size = UDim2.new(0, cLen, 0, 1) br_h.Position = UDim2.new(0, X2 - cLen + 1, 0, Y_bot) br_h.Visible = true
                                o_br_v.Size = UDim2.new(0, 3, 0, cLen + 2) o_br_v.Position = UDim2.new(0, X2 - 1, 0, Y_bot - cLen) o_br_v.Visible = true
                                br_v.Size = UDim2.new(0, 1, 0, cLen) br_v.Position = UDim2.new(0, X2, 0, Y_bot - cLen + 1) br_v.Visible = true
                            end

                            if ESPLib.ShowHealth then
                                local hp = math.max(0, currentHealth)
                                local maxHp = math.max(1, maxHealth)
                                local healthScale = math.clamp(hp / maxHp, 0, 1)

                                local padding = 6
                                local barWidth = 2

                                local boxTop = posY - 1
                                local boxHeight = sizeY + 2

                                cache.HealthBorder.Size = UDim2.new(0, barWidth + 2, 0, boxHeight + 2)
                                cache.HealthBorder.Position = UDim2.new(0, posX - padding - 1, 0, boxTop - 1)

                                cache.HealthBg.Size = UDim2.new(0, barWidth, 0, boxHeight)
                                cache.HealthBg.Position = UDim2.new(0, posX - padding, 0, boxTop)

                                cache.HealthBar.Size = UDim2.new(1, 0, healthScale, 0)
                                cache.HealthBar.Position = UDim2.new(0, 0, 1 - healthScale, 0)

                                cache.HealthBorder.Visible = true
                                cache.HealthBg.Visible = true
                                cache.HealthBar.Visible = true
                            else
                                cache.HealthBorder.Visible = false
                                cache.HealthBg.Visible = false
                                cache.HealthBar.Visible = false
                            end

                            local currentTextY = posY - (dynamicTextSize + 4)

                            if ESPLib.ShowNames then
                                local nameX = math.floor(posX + (sizeX / 2))
                                local nameY = math.floor(currentTextY)

                                cache.NameLabel.TextSize = dynamicTextSize
                                cache.NameLabel.Visible = true
                                cache.NameLabel.TextXAlignment = Enum.TextXAlignment.Center
                                cache.NameLabel.Position = UDim2.new(0, nameX, 0, nameY)
                            else
                                cache.NameLabel.Visible = false
                            end

                            if ESPLib.ShowDistance then
                                local distText = "[" .. math.floor(distance) .. "]"
                                local distX = posX + sizeX + 5
                                local distY = posY + math.floor(dynamicTextSize / 2)

                                cache.DistLabel.Text = distText
                                cache.DistLabel.TextSize = dynamicTextSize
                                cache.DistLabel.Visible = true
                                cache.DistLabel.TextXAlignment = Enum.TextXAlignment.Left
                                cache.DistLabel.Position = UDim2.new(0, distX, 0, distY)
                            else
                                cache.DistLabel.Visible = false
                            end

                            if ESPLib.ShowVisibilityFlag then
                                local rayParams = RaycastParams.new()
                                local filter = {character}
                                local lpChar = ESPLib.GetCharacter(localPlayer)
                                if lpChar then table.insert(filter, lpChar) end
                                rayParams.FilterDescendantsInstances = filter
                                rayParams.FilterType = Enum.RaycastFilterType.Blacklist
                                local ray = workspace:Raycast(Camera.CFrame.Position, hrp.Position - Camera.CFrame.Position, rayParams)
                                local flagText = (ray ~= nil) and "Hidden" or "Visible"

                                local flagX = posX + sizeX + 5
                                local flagY = posY + dynamicTextSize + 4 + math.floor(dynamicTextSize / 2)

                                cache.FlagLabel.Text = flagText
                                cache.FlagLabel.TextSize = dynamicTextSize
                                cache.FlagLabel.Visible = true
                                cache.FlagLabel.TextXAlignment = Enum.TextXAlignment.Left
                                cache.FlagLabel.Position = UDim2.new(0, flagX, 0, flagY)
                            else
                                cache.FlagLabel.Visible = false
                            end
                        end
                    end
                end
            end
        end

        if not isVisible then
            cache.Main.Visible = false cache.Outline.Visible = false cache.Inline.Visible = false
            for _, line in ipairs(cache.CornerColoredLines) do line.Visible = false end
            for _, line in ipairs(cache.CornerOutlineLines) do line.Visible = false end
            cache.HealthBorder.Visible = false cache.HealthBg.Visible = false cache.HealthBar.Visible = false
            cache.NameLabel.Visible = false
            cache.DistLabel.Visible = false
            cache.FlagLabel.Visible = false
        end
    end
end)

return ESPLib
