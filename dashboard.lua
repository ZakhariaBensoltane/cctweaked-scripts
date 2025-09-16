-- Dashboard.lua
-- Affiche l'état du drive AE2 et de l'énergie

-- Récupération des périphériques
local mon = peripheral.find("monitor") or error("Aucun moniteur trouvé !")
local drive = peripheral.find("ae2:drive") or error("Aucun drive AE2 trouvé !")
local energy = peripheral.find("energy_storage") or error("Aucun stockage d'énergie trouvé !")

-- Préparation du moniteur
mon.setTextScale(0.5)
mon.setBackgroundColor(colors.black)
mon.setTextColor(colors.white)
mon.clear()

-- Fonction d'affichage
local function printCentered(y, text, color)
    local w, _ = mon.getSize()
    mon.setCursorPos((w - #text) / 2, y)
    mon.setTextColor(color or colors.white)
    mon.write(text)
end

while true do
    mon.clear()

    -- Énergie
    local stored = energy.getEnergy()
    local max = energy.getEnergyCapacity()
    local percent = (stored / max) * 100

    printCentered(1, "=== Dashboard AE2 ===", colors.cyan)
    printCentered(3, string.format("Energie: %d / %d RF (%.1f%%)", stored, max, percent), colors.yellow)

    -- Drive
    local cells = drive.listCells()
    if #cells == 0 then
        printCentered(5, "Aucun disque detecte !", colors.red)
    else
        printCentered(5, "Disques AE2:", colors.green)
        for i, cell in ipairs(cells) do
            local label = cell.name or "Disque inconnu"
            local used = cell.used or 0
            local total = cell.total or 0
            local percentCell = total > 0 and (used / total) * 100 or 0
            mon.setCursorPos(2, 6 + i)
            mon.setTextColor(colors.white)
            mon.write(string.format("%s : %d/%d (%.1f%%)", label, used, total, percentCell))
        end
    end

    sleep(2) -- Rafraîchit toutes les 2 secondes
end
