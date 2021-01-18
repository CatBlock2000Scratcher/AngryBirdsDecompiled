_G.setfenv(1, gamelua)
if showEditor then
  print("Level editor is not supported with dynamic assets, disabling dynamic asset loading\n")
  useDynamicAssets = false
  return
end
createDynamicHandler("dynamic")
function loadImages()
end
function loadCompoSprites()
end
function releaseImages()
end
function releaseCompoSprites()
end
function loadThemeGraphics()
end
function loadAllThemeGraphics()
end
loadLuaFileToObject(scriptPath .. "/dynamic/default.lua", this, "_")
function dynamic.enterIngame(oldTheme, theme)
  local currentRoot = menuManager:getRoot()
  if currentRoot and currentRoot.name ~= "gameHud" then
    _G.assert(_G.type(currentRoot.name) == "string", "invalid name value")
    dynamic.delayrelease(currentRoot.name)
  end
  if oldTheme ~= theme then
    dynamic.delayrelease(oldTheme)
  end
  dynamic.load({"ingame", theme})
end
function dynamic.eventTriggered(o, event)
  if event.id == events.EID_LEAVE_GAME then
    dynamic.delayrelease({"ingame", currentTheme})
  elseif event.id == events.EID_CURRENT_MENU_THEME_NEEDED then
    dynamic.queueload(settingsWrapper:getCurrentMainMenuTheme())
  elseif event.id == events.EID_CURRENT_MENU_THEME_NOT_NEEDED then
    dynamic.delayrelease(settingsWrapper:getCurrentMainMenuTheme())
  end
end
filename = "dynamicassets.lua"
