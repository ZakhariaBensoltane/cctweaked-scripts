-- Trouve automatiquement le moniteur
local monitor = peripheral.find("monitor")
if not monitor then
    error("Aucun moniteur trouvé !")
end
monitor.clear()
monitor.setTextScale(0.5)
monitor.setCursorPos(1,1)

-- Trouve automatiquement le contrôleur AE2 (énergie)
local controller = peripheral.find("ae2:controller")
-- Trouve automatiquement le drive AE2 (disques)
local drive = peripheral.find("ae2:drive")

-- Fonction d'affichage
local function afficher()
    monitor.clear()
    monitor.setCursorPos(1,1)
    monitor.write("=== Dashboard AE2 ===")

    -- Partie Energie
    if controller and controller.getEnergy then
        local energy = controller.getEnergy()
        local maxEnergy = controller.getMaxEnergy()
        local percent = (energy / maxEnergy) * 100
        monitor.setCursorPos(1,3)
        monitor.write(string.format("Energie: %d / %d RF (%.1f%%)", energy, maxEnergy, percent))
    else
        monitor.setCursorPos(1,3)
        monitor.write("Pas de controleur AE2 trouvé")
    end

    -- Partie Drive
    monitor.setCursorPos(1,5)
    if drive and drive.getStoredItems then
        local items = drive.list()
        monitor.write("Disques AE2 :")
        local y = 6
        for slot, disk in pairs(items) do
            monitor.setCursorPos(2, y)
            monitor.write("Slot " .. slot .. ": " .. disk.name)
            y = y + 1
        end
    else
        monitor.write("Pas de drive AE2 trouvé")
    end
end

-- Boucle infinie
while true do
    afficher()
    sleep(5) -- rafraîchit toutes les 5 secondes
end
