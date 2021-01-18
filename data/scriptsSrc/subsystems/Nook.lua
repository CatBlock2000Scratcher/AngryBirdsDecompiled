ui = gamelua.ui
print = gamelua.print
g_storeEnterTime = nil
g_insideStore = false
NookSubsystem = SubSystem:new()
function NookSubsystem:init()
  self.extend_state = "CLOSED"
  self.extend_amount = 0
  self.visible = false
  gamelua.eventManager:addEventListener(gamelua.events.EID_FREE_EAGLE_BECAME_AVAILABLE, self)
  gamelua.eventManager:addEventListener(gamelua.events.EID_FREE_EAGLE_BECAME_UNAVAILABLE, self)
  gamelua.eventManager:addEventListener(gamelua.events.EID_NOOK_STORE_ENTERED, self)
  gamelua.eventManager:addEventListener(gamelua.events.EID_NOOK_STORE_EXITED, self)
  gamelua.registerStoreStatusListener()
end
function NookSubsystem:eventTriggered(event)
  if event.id == gamelua.events.EID_FREE_EAGLE_BECAME_AVAILABLE and event.source == "nook" then
    self.extend_state = "OPENING"
    if not self.visible then
      self:createBanner()
    end
  end
  if event.id == gamelua.events.EID_FREE_EAGLE_BECAME_UNAVAILABLE and event.source == "nook" then
    self.extend_state = "CLOSING"
  end
  if event.id == gamelua.events.EID_NOOK_STORE_ENTERED then
    g_storeEnterTime = gamelua.getCurrentTime()
    g_insideStore = true
    print("<Nook> store entered\n")
    if not gamelua.settingsWrapper:isNookUserAlreadyConnected() then
      print("<Nook> store entered first time\n")
      gamelua.settingsWrapper:setNookUserAlreadyConnected()
      gamelua.eventManager:notify({
        id = gamelua.events.EID_NOOK_STORE_ENTERED_FIRST_TIME
      })
    end
    gamelua.unlockFreeEagle("nook")
  end
  if event.id == gamelua.events.EID_NOOK_STORE_EXITED then
    print("<Nook> store exited\n")
    g_insideStore = false
    gamelua.lockFreeEagle("nook")
  end
end
function NookSubsystem:update(dt)
  if self.extend_state == "OPENING" then
    self.extend_amount = _G.math.min(self.extend_amount + dt * 2, 1)
    if self.extend_amount == 1 then
      self.extend_state = "OPEN"
    end
  elseif self.extend_state == "CLOSING" then
    self.extend_amount = _G.math.max(self.extend_amount - dt * 2, 0)
    if self.extend_amount == 0 then
      self.extend_state = "CLOSED"
      if self.visible then
        self:removeBanner()
      end
    end
  end
  if self.visible then
    local banner = gamelua.notificationsFrame:getChild("nook_eagle_banner")
    local _, sh = _G.res.getSpriteBounds("BARNES_NOBLE_MIGHTY_EAGLE")
    banner.y = gamelua.tweenEaseCubicOut(self.extend_amount, -sh, sh, 1)
    local root = gamelua.menuManager:getRoot()
    if root and (root.name == "LevelEndRoot" or _G.string.find(root.name, "^LevelSelection")) or gamelua.rovioNewsIsShown then
      banner:setVisible(false)
    else
      banner:setVisible(true)
    end
  end
end
function NookSubsystem:createBanner()
  local banner = ui.Image:new()
  banner.name = "nook_eagle_banner"
  banner:setImage("BARNES_NOBLE_MIGHTY_EAGLE")
  gamelua.notificationsFrame:addChild(banner)
  local _, sh = _G.res.getSpriteBounds("BARNES_NOBLE_MIGHTY_EAGLE")
  banner.x = gamelua.screenWidth * 0.5
  banner.y = -sh
  self.visible = true
end
function NookSubsystem:removeBanner()
  local banner = gamelua.notificationsFrame:getChild("nook_eagle_banner")
  gamelua.notificationsFrame:removeChild(banner)
  self.visible = false
end
function gamelua.notifyNookInsideStore(in_store)
  if in_store and not g_insideStore then
    gamelua.eventManager:notify({
      id = gamelua.events.EID_NOOK_STORE_ENTERED
    })
  elseif g_insideStore then
    local now = gamelua.getCurrentTime()
    local diff = gamelua.getTimeDifference(now, g_storeEnterTime)
    print(_G.string.format("<Nook> visit duration: %02ud%02uh%02um%02us\n", diff.days, diff.hours, diff.minutes, diff.seconds))
    gamelua.eventManager:notify({
      id = gamelua.events.EID_NOOK_STORE_EXITED,
      duration = diff
    })
  end
end
filename = "Nook.lua"
