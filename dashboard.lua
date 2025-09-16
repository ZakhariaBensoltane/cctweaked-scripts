local monitor = peripheral.wrap("left") -- ton moniteur
local drive = peripheral.wrap("right") -- adapte selon où est ton drive
local energy = peripheral.wrap("back") -- ton contrôleur avec energy_storage

monitor.clear()
monitor.setCursorPos(1,1)
monitor.write("=== Dashboard AE2 ===")

-- Energie
local stored = energy.getEnergy()
local max = energy.getMaxEnergyStored()
local percent = (stored / max) * 100
monitor.setCursorPos(1,2)
monitor.write(string.format("Energie: %d / %d RF (%.1f%%)", stored, max, percent))

-- Inventaire du Drive
monitor.setCursorPos(1,4)
monitor.write("Disques AE2 :")

local items = drive.list()
local line = 5
for slot, item in pairs(items) do
    local detail = drive.getItemDetail(slot)
    if detail then
        monitor.setCursorPos(1, line)
        monitor.write(string.format("Slot %d: %s x%d", slot, detail.name, detail.count))
        line = line + 1
    end
end
