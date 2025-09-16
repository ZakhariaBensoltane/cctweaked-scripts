local mon = peripheral.wrap("right")  -- ou "right" selon ton écran
mon.clear()
mon.setTextScale(0.5)

local drive = peripheral.wrap("ae2:drive_0")
if not drive then
    mon.write("Aucun drive trouvé !")
    return
end

local items = drive.listItems()

mon.setCursorPos(1,1)
mon.write("=== AE2 Drive ===")

local y = 2
for _, item in pairs(items) do
    mon.setCursorPos(1, y)
    mon.write(item.label .. " x" .. item.count)
    y = y + 1
end
