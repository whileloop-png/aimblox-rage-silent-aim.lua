--[[

 ░▒▓███████▓▒░▒▓████████▓▒░▒▓██████▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░       ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓███████▓▒░░▒▓████████▓▒░▒▓█▓▒░      ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░         ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░         ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
 ░▒▓██████▓▒░   ░▒▓█▓▒░  ░▒▓████████▓▒░▒▓█▓▒░      ░▒▓███████▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒▒▓█▓▒░░▒▓██████▓▒░ ░▒▓███████▓▒░░▒▓██████▓▒░ ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
       ░▒▓█▓▒░  ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
       ░▒▓█▓▒░  ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓███████▓▒░   ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░       ░▒▓██████▓▒░   ░▒▓██▓▒░  ░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓████████▓▒░▒▓██████▓▒░ ░▒▓█████████████▓▒░  
--]]                                                                                                                                                                                       




local players = game:GetService("Players")
local repStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
local player = players.LocalPlayer
local mouse = player:GetMouse()
local cam = workspace.CurrentCamera

--//just checks if behind a wall
function notWall(target)
    local ray = Ray.new(player.Character.Head.Position, (target.Position - player.Character.Head.Position).Unit * 300)
    local part, pos = workspace:FindPartOnRayWithIgnoreList(ray, {player.Character}, false, true)
    if part then
        local humanoid = part.Parent:FindFirstChildOfClass("Humanoid")
        if not humanoid then
            humanoid = part.Parent.Parent:FindFirstChildOfClass("Humanoid")
        end
        if humanoid and target and humanoid.Parent == target.Parent then
            return true
        end
    end
    return false
end

--//gets the closest player to mouse
function closestPlayer()
    local target = nil
    local maxDist = math.huge
    for _, v in pairs(players:GetPlayers()) do
        if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            if v.Character:FindFirstChild("HumanoidRootPart") then
                local screenPos = cam:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                local dist = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                if dist < maxDist and notWall(v.Character.HumanoidRootPart) then
                    target = v.Character:FindFirstChild("Head")
                    maxDist = dist
                end
            end
        end
    end
    return target
end

function trailMake(origin, target)
    local att0 = Instance.new("Attachment")
    att0.Position = origin
    att0.Parent = workspace.Terrain

    local att1 = Instance.new("Attachment")
    att1.Position = target
    att1.Parent = workspace.Terrain

    local beam = Instance.new("Beam")
    beam.Attachment0 = att0
    beam.Attachment1 = att1
    beam.FaceCamera = true
    beam.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
    beam.Width0 = 0.1
    beam.Width1 = 0.1
    beam.Parent = workspace.Terrain

    game:GetService("Debris"):AddItem(att0, .7)
    game:GetService("Debris"):AddItem(att1, .7)
    game:GetService("Debris"):AddItem(beam, .7)
end

function hitPart(target)
    local bodyParts = {"Head", "HumanoidRootPart"}
    for _, partName in ipairs(bodyParts) do
        local part = target.Parent:FindFirstChild(partName)
        if part then
            local ray = Ray.new(player.Character.Head.Position, (part.Position - player.Character.Head.Position).Unit * 300)
            local hitPart, position = workspace:FindPartOnRayWithIgnoreList(ray, {player.Character}, false, true)
            if hitPart == part then
                return partName, position
            end
        end
    end
    return nil, nil
end

--//hooked function
local rqr_func = require(repStorage.Client.Components.GunEngine)

local ogfire = rqr_func.OnTargetHit.Fire

rqr_func.OnTargetHit.Fire = function(self, arg1_3, arg2_2)

    local closest = closestPlayer()

    if closest then
        local head = closest 
        if head then
            arg1_3 = head
            arg2_2 = head.Position
        end
    end

    local pos = arg2_2
    local part = arg1_3

    trailMake(player.Character.Head.Position, pos)

    return ogfire(self, part, pos)
end
