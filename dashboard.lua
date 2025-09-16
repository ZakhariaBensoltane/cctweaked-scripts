-- Explorer les périphériques connectés via le hub
term.clear()
term.setCursorPos(1,1)
print("=== Explorateur de périphériques ===")

-- Lister les périphériques
local periphList = peripheral.getNames()

if #periphList == 0 then
    print("Aucun périphérique détecté.")
    return
end

print("Périphériques trouvés :")
for i, name in ipairs(periphList) do
    print(i .. ". " .. name .. " (" .. peripheral.getType(name) .. ")")
end

-- Choisir un périphérique
print("\nTape le numéro du périphérique à explorer :")
local choice = tonumber(read())
local target = periphList[choice]

if not target then
    print("Choix invalide.")
    return
end

print("\nExploration de : " .. target .. " (" .. peripheral.getType(target) .. ")")

-- Afficher les méthodes disponibles
local methods = peripheral.getMethods(target)
if not methods or #methods == 0 then
    print("Ce périphérique n’a pas de méthodes accessibles.")
    return
end

print("Méthodes disponibles :")
for i, m in ipairs(methods) do
    print(i .. ". " .. m)
end

-- Tester une méthode simple (ex: getEnergy, getItems, etc.)
print("\nTape le numéro d’une méthode à tester :")
local mChoice = tonumber(read())
local method = methods[mChoice]

if not method then
    print("Choix invalide.")
    return
end

print("\nRésultat de " .. method .. ":")
local ok, result = pcall(function()
    return peripheral.call(target, method)
end)

if ok then
    if type(result) == "table" then
        print(textutils.serialize(result))
    else
        print(tostring(result))
    end
else
    print("Erreur : " .. tostring(result))
end
