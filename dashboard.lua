-- map.lua
-- Carte ASCII simple affichée sur un moniteur CC:Tweaked

local mon = peripheral.find("monitor")
mon.setTextScale(0.5)
mon.clear()
mon.setCursorPos(1,1)

-- Exemple de plan de base (chaque ligne = une rangée)
-- Tu peux modifier avec tes vraies salles
local map = {
    "##########",
    "#   S    #",  -- S = Salle stockage
    "#   E    #",  -- E = Salle énergie
    "#   M    #",  -- M = Machines
    "##########"
}

mon.write("=== Carte de la Base ===\n\n")

for i, line in ipairs(map) do
    mon.write(line .. "\n")
end
