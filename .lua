-- Aguarda o jogo carregar
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Espera o HumanoidRootPart aparecer
repeat task.wait() until character:FindFirstChild("HumanoidRootPart")

-- Etapa 1: Teleporta pro portal Nightmare com a nova posição
local nightmarePosition = Vector3.new(417.38, 162, -6)
character:MoveTo(nightmarePosition)
print("🟪 Teleportado para o portal Nightmare")

-- Etapa 2: Aguarda entrar na partida
task.wait(10)

-- Etapa 3: Espera e clica automaticamente no botão "Start"
local gui = player:WaitForChild("PlayerGui")
local success = false

for i = 1, 60 do -- tenta por até 30 segundos
    for _, obj in pairs(gui:GetDescendants()) do
        if obj:IsA("TextButton") or obj:IsA("ImageButton") then
            local texto = (obj.Text or ""):lower()
            if texto == "start" then
                print("🟢 Botão Start encontrado, tentando clicar...")

                -- Clica de várias formas pra garantir
                pcall(function() obj:Activate() end)
                pcall(function() obj.MouseButton1Click:Fire() end)
                pcall(function() obj.MouseButton1Down:Fire() end)

                success = true
                break
            end
        end
    end

    if success then
        print("🎮 Botão Start clicado com sucesso!")
        break
    end

    task.wait(0.5)
end

if not success then
    warn("❌ Botão Start não foi encontrado.")
end
