monitor = peripheral.wrap("right")
monitor.setTextScale(2)
monitor.clear()

while true do
    local time = textutils.formatTime(os.time(), true)
    monitor.setCursorPos(1,1)
    monitor.clear()
    monitor.write("Heure: " .. time)
    sleep(1)
end
