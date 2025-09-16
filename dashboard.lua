local mon = peripheral.wrap("right")
mon.setTextScale(2)
mon.setBackgroundColor(colors.black)
mon.setTextColor(colors.green)

while true do
    local time = textutils.formatTime(os.time(), true)
    mon.clear()
    mon.setCursorPos(3,2)
    mon.write("⌚ Heure : " .. time)
    sleep(1)
end
