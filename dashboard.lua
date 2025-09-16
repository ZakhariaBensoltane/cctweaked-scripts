local monitor = peripheral.wrap("right")  -- ou "left"
monitor.setTextScale(2)
monitor.clear()
monitor.setCursorPos(1,1)
monitor.write("Hello World !")
