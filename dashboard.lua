local mon = peripheral.find("monitor")
if not mon then
    error("Pas de monitor détecté !")
end

mon.setTextScale(0.5)
mon.clear()

-- charge l'image convertie
local img = paintutils.loadImage("image.jpg")

-- dessine l'image en haut à gauche du monitor
paintutils.drawImage(img, 1, 1)
