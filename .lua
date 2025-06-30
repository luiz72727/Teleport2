-- Aguarda o jogo carregar completamente
repeat task.wait() until game:IsLoaded()

-- Define os principais objetos do jogador
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Aguarda o personagem carregar com a parte principal do corpo
repeat task.wait() until character:FindFirstChild("HumanoidRootPart")

-- Teleporta para o portal Nightmare (ajuste a posição se o jogo mudar)
local nightmarePosition = Vector3.new(417.38, 162, -6)
character:MoveTo(nightmarePosition)
print("🟪 Teleportado para o portal Nightmare")

-- Aguarda ser colocado dentro da partida
task.wait(10)

-- Procura o botão "Start" e tenta clicar automaticamente
local gui = player:WaitForChild("PlayerGui")
local success = false

for i = 1, 60 do -- tenta por até 30 segundos
    for _, obj in pairs(gui:GetDescendants()) do
        if obj:IsA("TextButton") and obj.Text and obj.Text:lower() == "start" then
            print("🟢 Botão Start encontrado, clicando...")

            pcall(function() obj:Activate() end)
            pcall(function() obj.MouseButton1Click:Fire() end)
            pcall(function() obj.MouseButton1Down:Fire() end)

            success = true
            break
        end
    end
    if success then break end
    task.wait(0.5)
end

if success then
    print("🎮 Partida iniciada com sucesso!")
else
    warn("❌ Não foi possível encontrar o botão Start.")
end
