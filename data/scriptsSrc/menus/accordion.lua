ui = gamelua.ui
print = gamelua.print
events = gamelua.events
g_notes = {
  "cminor",
  "dismajor",
  "fmajor",
  "gminor",
  "bmajor"
}
AccordionButton = ui.Image:new()
function AccordionButton:setImages(up_image, down_image)
  self:setImage(up_image)
  self.up_image = up_image
  self.down_image = down_image
end
function AccordionButton:onTouchEvent(type, id, x, y)
  if type == "TOUCHDOWN" and ui.ImageButton.hitTest(self, x, y) then
    self:setImage(self.down_image)
    return self.returnValue, self.meta, self
  end
  return nil, nil, nil
end
function AccordionButton:release()
  self:setImage(self.up_image)
end
AccordionHandle = ui.Image:new()
function AccordionHandle:init()
  ui.Image.init(self)
  self.state = "IDLE"
  self.dragging = false
  self.delta = 0
end
function AccordionHandle:onTouchEvent(type, id, x, y)
  if type == "TOUCHDOWN" and self.state == "IDLE" and ui.ImageButton.hitTest(self, x, y) then
    self.state = "DRAGGING"
    self.drag_id = id
    self.drag_start_x = x
    self.drag_last_x = x
    self.dragging = true
    self.rip_timer = 0
    self.direction = nil
  elseif type == "TOUCHHOLD" and self.state == "DRAGGING" and id == self.drag_id and x >= self.x - self.px * self.scaleX then
    self.dragging = true
    self.drag_last_x = x
  end
end
function AccordionHandle:update(dt, time)
  ui.Image.update(self, dt, time)
  self.direction_changed = false
  if not self.dragging and self.state == "DRAGGING" then
    self.state = "IDLE"
  end
  if self.state == "IDLE" then
    local diff = self.x - self.x0
    local delta = 0
    if diff > 0 then
      delta = dt * -self.bellows.w0 * 3
    elseif diff < 0 then
      delta = dt * self.bellows.w0 * 3
    end
    self.x = self.x + delta
    if delta > 0 and self.x > self.x0 then
      self.x = self.x0
    elseif delta < 0 and self.x < self.x0 then
      self.x = self.x0
    end
    self.bellows.scaleX = (self.bellows.w0 + (self.x - self.x0)) / self.bellows.w0 * self.bellows.sx0
  elseif self.state == "DRAGGING" then
    local drag_dist = _G.math.max(_G.math.min(self.drag_last_x - self.drag_start_x, self.bellows.wmax - self.bellows.w0), self.bellows.w0 * -0.8)
    self.x = self.x0 + drag_dist
    if 0 < _G.math.abs(drag_dist) then
      if self.direction == nil or 0 > self.direction * drag_dist then
        self.direction_changed = true
      end
      self.direction = drag_dist
    end
    if self.drag_last_x - self.x0 > self.bellows.w0 * 1.55 then
      self.rip_timer = self.rip_timer + dt
    else
      self.rip_timer = 0
    end
    self.bellows.scaleX = (self.bellows.w0 + drag_dist) / self.bellows.w0 * self.bellows.sx0
    if 3 <= self.rip_timer then
      self.dragging = false
      self.state = "RIPPING"
      self.rip_x = 0
      self.ripped_bellows:setVisible(true)
      self.bellows.scaleX = 1
      _G.res.stopAllAudio()
      _G.res.playAudio(gamelua.getAudioName("accordion_break"), 1, false, 0)
    end
  elseif self.state == "RIPPING" then
    self.rip_x = self.rip_x + (gamelua.screenWidth * 0.5 + self.rip_x) * dt * 2
    self.bellows.x = self.bellows.x0 + self.rip_x
    self.x = self.x0 + self.bellows.wmax - self.bellows.w0 + self.rip_x
  end
  self.dragging = false
end
Accordion = ui.Frame:new()
function Accordion:init()
  ui.Frame.init(self)
  self.name = "Accordion"
  local background = ui.Image:new()
  background.name = "background"
  background:setImage("GOLDEN_EGG_BG_1")
  self:addChild(background)
  local ripped_bellows = ui.Image:new()
  ripped_bellows.name = "ripped_bellows"
  ripped_bellows:setImage("ACCO_MID_BROKEN")
  ripped_bellows:setVisible(false)
  self:addChild(ripped_bellows)
  local bellows = ui.Image:new()
  bellows.name = "bellows"
  bellows:setImage("ACCO_MID")
  self:addChild(bellows)
  local accordion = ui.Image:new()
  accordion.name = "accordion"
  accordion:setImage("ACCO_LEFT")
  self:addChild(accordion)
  for i = 1, 5 do
    local button = AccordionButton:new()
    button.name = "button" .. i
    button.returnValue = "PLAY"
    button.meta = i
    button:setImages("ACCO_BTN_UP_" .. i, "ACCO_BTN_DOWN_" .. i)
    self:addChild(button)
  end
  local handle = AccordionHandle:new()
  handle.name = "handle"
  handle:setImage("ACCO_RIGHT")
  self:addChild(handle)
  handle.bellows = bellows
  handle.ripped_bellows = ripped_bellows
  local pig = ui.ToggleButton:new()
  pig.name = "pig"
  pig:setImage({
    "GE_GRANDPA_01",
    "GE_GRANDPA_01_BLINK"
  })
  pig.returnValue = "TOGGLE_PIG"
  self:addChild(pig)
  local back_button = ui.ImageButton:new()
  back_button.name = "back_button"
  back_button.returnValue = "EXIT_SOUNDBOARD"
  back_button:setImage("ARROW_LEFT")
  back_button.activateOnRelease = true
  self:addChild(back_button)
  local audio_button = ui.AudioToggleButton:new()
  audio_button.name = "audio_button"
  audio_button:setImage({
    "MENU_SFX",
    "BUTTON_MENU_SFX_OFF"
  })
  audio_button.activateOnRelease = true
  self:addChild(audio_button)
end
function Accordion:layout()
  ui.Frame.layout(self)
  do
    local background = self:getChild("background")
    local sw, sh = _G.res.getSpriteBounds(background.image)
    background.x = gamelua.screenWidth * 0.5
    background.y = gamelua.screenHeight * 0.5
    background.scaleX = gamelua.screenWidth / sw
    background.scaleY = gamelua.screenHeight / sh
  end
  do
    local back_button = self:getChild("back_button")
    local sw, sh = _G.res.getSpriteBounds(back_button.image)
    back_button.x = sw * 0.5 + gamelua.g_layoutMargin.x
    back_button.y = gamelua.screenHeight - sh * 0.5 - gamelua.g_layoutMargin.y
  end
  do
    local audio_button = self:getChild("audio_button")
    local sw, sh = _G.res.getSpriteBounds("MENU_SFX")
    audio_button.x = sw * 0.5 + gamelua.g_layoutMargin.x
    audio_button.y = sh * 0.5 + gamelua.g_layoutMargin.y
  end
  do
    local pig_scale = 1
    local pig = self:getChild("pig")
    local sw, sh = _G.res.getSpriteBounds("GE_GRANDPA_01")
    pig.x = gamelua.screenWidth - sw * 0.55 * pig_scale - gamelua.g_layoutMargin.x
    pig.y = gamelua.screenHeight - sh * 0.55 * pig_scale - gamelua.g_layoutMargin.y
    pig.scaleX = pig_scale
    pig.scaleY = pig_scale
  end
  local accordion = self:getChild("accordion")
  local ripped_bellows = self:getChild("ripped_bellows")
  local bellows = self:getChild("bellows")
  local handle = self:getChild("handle")
  accordion.y = gamelua.screenHeight * 0.5
  ripped_bellows.y = gamelua.screenHeight * 0.5
  bellows.y = gamelua.screenHeight * 0.5
  handle.y = gamelua.screenHeight * 0.5
  local accordion_width = 0
  local asw, _ = _G.res.getSpritePivot(accordion.image)
  local bsw, _ = _G.res.getSpriteBounds(bellows.image)
  local bpx, _ = _G.res.getSpritePivot(bellows.image)
  local hsw, _ = _G.res.getSpriteBounds(handle.image)
  local hpx, _ = _G.res.getSpritePivot(handle.image)
  accordion_width = asw + bsw - bpx + hsw - hpx
  accordion.x = gamelua.screenWidth * 0.5 - 0.5 * accordion_width + asw
  ripped_bellows.x = accordion.x
  bellows.x = accordion.x
  bellows.x0 = bellows.x
  bellows.w0 = (bsw - bpx) * 0.65
  bellows.wmax = bsw - bpx
  bellows.sx0 = 0.65
  bellows.scaleX = 0.65
  handle.x0 = accordion.x + bellows.w0
  handle.x = handle.x0
  for i = 1, 5 do
    local button = self:getChild("button" .. i)
    button.x = accordion.x
    button.y = accordion.y
  end
end
function Accordion:onEntry()
  ui.Frame.onEntry(self)
  gamelua.menuManager:enableMultiTouch()
  self.current_volume = 0
  self.current_channel = 0
  self.current_note = "empty_accordion"
  self.previous_x = self:getChild("handle").x
  self.volume_timer = 0
  self:setVolume(5, 0)
  self:setVolume(6, 0)
  _G.res.stopAudio(gamelua.currentMainMenuSong)
end
function Accordion:onExit()
  ui.Frame.onExit(self)
  gamelua.menuManager:disableMultiTouch()
  gamelua.releaseAssets({
    "GOLDEN_EGGS"
  })
  local volume = _G.res.getTrackVolume(7)
  _G.res.setTrackVolume(volume, 5)
  _G.res.setTrackVolume(volume, 6)
  _G.res.stopAllAudio()
end
function Accordion:collectStar()
  self.star_collected = true
  gamelua.goldenEggStarAchieved("ACCORDION")
end
function Accordion:update(dt, time)
  ui.Frame.update(self, dt, time)
  local handle = self:getChild("handle")
  if not self.star_collected and handle.state == "RIPPING" and not _G.res.isAudioPlaying(gamelua.getAudioName("accordion_break")) then
    self:collectStar()
  elseif handle.state == "DRAGGING" and handle.direction_changed then
    _G.res.stopAllAudio()
    self:playTracks()
    if self:isPigActive() then
      local pig = self:getChild("pig")
      if pig:getStateImage(1) == "GE_GRANDPA_01" then
        pig:setStateImage(1, "GE_GRANDPA_04_SMILE")
      else
        pig:setStateImage(1, "GE_GRANDPA_01")
      end
      _G.res.playAudio(gamelua.getAudioName("pig_accordion"), 0.7, false, 0)
    end
  elseif handle.state == "IDLE" then
    self:getChild("pig"):setStateImage(1, "GE_GRANDPA_01")
  end
  self.volume_timer = self.volume_timer + dt
  if self.volume_timer > 0.016 then
    if handle.state == "DRAGGING" and 0 < _G.math.abs(handle.x - self.previous_x) then
      self.current_volume = _G.math.min(self.current_volume + self.volume_timer * 20 * _G.math.abs(handle.x - self.previous_x) / self:getChild("bellows").w0, 1)
    else
      self.current_volume = _G.math.max(self.current_volume - self.volume_timer * 0.35, 0)
    end
    self.volume_timer = 0
    self.previous_x = handle.x
  end
  if _G.tonumber(handle.direction) then
    if 0 > handle.direction then
      self:setVolume(5, self.current_volume)
      self:setVolume(6, 0)
    else
      self:setVolume(5, 0)
      self:setVolume(6, self.current_volume)
    end
  end
end
function Accordion:onPointerEvent(eventType, x, y)
  local result, meta, item = ui.Frame.onPointerEvent(self, eventType, x, y)
  if result == "EXIT_SOUNDBOARD" then
    gamelua.eventManager:notify({
      id = events.EID_CHANGE_SCENE,
      target = "LEVEL_SELECTION_G"
    })
  end
  return result, meta, item
end
function Accordion:onKeyEvent(eventType, key)
  local result, meta, item = ui.Frame.onKeyEvent(self, eventType, key)
  if not result and eventType == "RELEASE" and (key == "BACK" or key == "ESCAPE") then
    gamelua.eventManager:notify({
      id = events.EID_CHANGE_SCENE,
      target = "LEVEL_SELECTION_G"
    })
  end
  return result, meta, item
end
function Accordion:onTouchEvent(type, id, x, y)
  local result, meta, item = ui.Frame.onTouchEvent(self, type, id, x, y)
  if result == "PLAY" then
    for i = 1, 5 do
      if i ~= meta then
        self:getChild("button" .. i):release()
      end
    end
    if self:getChild("handle").state ~= "RIPPING" then
      _G.res.stopAllAudio()
      self.current_note = g_notes[meta]
      self:playTracks()
    end
  end
  return result, meta, item
end
function Accordion:isPigActive()
  return self:getChild("pig").state == 1
end
function Accordion:setVolume(track, volume)
  local max_volume = _G.res.getTrackVolume(7)
  _G.res.setTrackVolume(_G.math.min(volume, max_volume), track)
end
function Accordion:playTracks()
  _G.res.playAudio(self.current_note .. "_left", 1, true, 5)
  _G.res.playAudio(self.current_note .. "_right", 1, true, 6)
end
filename = "accordion.lua"
