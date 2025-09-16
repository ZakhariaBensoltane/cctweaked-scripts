-- Radar Base Map
local monitor = peripheral.find("monitor")
local detector = peripheral.find("playerDetector")

if not monitor then error("Monitor manquant") end
if not detector then error("Player Detector manquant") end

monitor.setTextScale(0.5)
monitor.clear()

-- Taille de la carte (en chunks affichés autour de la base)
local radius = 4 -- 4 chunks autour du centre

-- Position du centre (à définir !)
local baseX, baseZ = 0, 0 -- change avec tes coords

while true do
    monitor.clear()
    monitor.setCursorPos(1,1)
    monitor.write("=== Radar Base ===")

    -- Liste des joueurs
    local players = detector.getPlayersInRange(128) -- rayon 128 blocs

    for _, name in ipairs(players) do
        local pos = detector.getPlayerPos(name)
        local chunkX = math.floor(pos.x / 16)
        local chunkZ = math.floor(pos.z / 16)

        local dx = chunkX - math.floor(baseX / 16)
        local dz = chunkZ - math.floor(baseZ / 16)

        -- Convertir en coords écran
        local screenX = (radius + dx) * 4 + 2
        local screenY = (radius + dz) * 2 + 3

        monitor.setCursorPos(screenX, screenY)
        monitor.write(name:sub(1,3)) -- affiche les 3 premières lettres
    end

    sleep(1)
end
