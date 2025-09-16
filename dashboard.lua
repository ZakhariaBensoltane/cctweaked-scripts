-- dashboard.lua
-- Dashboard animé : heure, morts, animation

-- === Initialisation monitor ===
local mon = peripheral.find("monitor")
if not mon then
    error("Aucun moniteur trouvé !")
end
mon.setTextScale(0.5)
mon.setBackgroundColor(colors.black)
mon.setTextColor(colors.white)

-- === Animation frames (cœur qui bat) ===
local frames = {
  {
    "  ♥  ",
    " ♥♥♥ ",
    "  ♥  ",
  },
  {
    "     ",
    "  ♥  ",
    "     ",
  }
}

-- === Fonction affichage heure ===
local function drawTime(y)
    local t = os.time()
    local timeStr = textutils.formatTime(t, true)
    mon.setCursorPos(1, y)
    mon.setTextColor(colors.cyan)
    mon.write("Heure: "..timeStr)
    mon.setTextColor(colors.white)
end

-- === Fonction affichage morts (scoreboard) ===
local function drawDeaths(y)
    mon.setCursorPos(1, y)
    mon.setTextColor(colors.red)
    mon.write("Morts:")

    local success, data = pcall(commands.scoreboard, "players", "list", "Deaths")
    if success and data then
        local row = y + 1
        for _, player in ipairs(data) do
            mon.setCursorPos(2, row)
            mon.setTextColor(colors.white)
            mon.write(player.name..": "..player.score)
            row = row + 1
        end
    else
        mon.setCursorPos(2, y + 1)
        mon.setTextColor(colors.gray)
        mon.write("(Scoreboard 'Deaths' non dispo)")
    end
    mon.setTextColor(colors.white)
end

-- === Fonction animation pixel ===
local function drawAnimation(y)
    for _, frame in ipairs(frames) do
        -- Nettoie zone animation
        for i = 0, 3 do
            mon.setCursorPos(1, y + i)
            mon.write(string.rep(" ", 10))
        end

        -- Dessine la frame
        for i, line in ipairs(frame) do
            mon.setCursorPos(2, y + i - 1)
            mon.setTextColor(colors.pink)
            mon.write(line)
        end
        mon.setTextColor(colors.white)

        sleep(0.5)
    end
end

-- === Boucle principale ===
while true do
    mon.clear()

    -- Affiche l'heure (ligne 1)
    drawTime(1)

    -- Affiche scoreboard (ligne 3+)
    drawDeaths(3)

    -- Animation en bas
    local _, h = mon.getSize()
    drawAnimation(h - 5)

    sleep(0.1)
end
