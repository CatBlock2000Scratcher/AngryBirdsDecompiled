if gamelua.releaseBuild then
  validation_url = "http://drm-pc.angrybirdsgame.com/validateKey/?"
  registration_url = "http://drm-pc.angrybirdsgame.com/consumeKey/?"
  key_type = "SABC2011FL"
else
  validation_url = "http://dev.angrybirds.com/drm/validateKey/?"
  registration_url = "http://dev.angrybirds.com/drm/consumeKey/?"
  key_type = "shop-full-abc-pc-test"
end
function registerKey(key)
  current_key = key
  gamelua.registerKey(key, key_type, registration_url)
end
function saveRegistration()
  local settingsWrapper = gamelua.settingsWrapper
  settingsWrapper:setHardwareID(gamelua.getDeviceID())
  settingsWrapper:addRegisteredKey(key_type)
  gamelua.g_isRegistered = true
end
function checkRegistration()
  local settingsWrapper = gamelua.settingsWrapper
  if not settingsWrapper:isKeyRegistered(key_type) then
    return false
  end
  if not gamelua.verifyDeviceID(settingsWrapper:getHardwareID()) then
    return false
  end
  return true
end
filename = "PC_DRM.lua"
