ui = gamelua.ui
print = gamelua.print
events = gamelua.events
local debug_draw = false
channels = {
  [1] = {
    song = gamelua.currentMainMenuSong
  },
  [2] = {
    song = "ambient_theme1"
  },
  [3] = {
    song = "ambient_theme2"
  },
  [3.5] = {
    song = "funky_theme"
  },
  [4] = {
    song = "ambient_theme3"
  }
}
indicator_pos = {x0 = 0.383, x1 = 0.806}
RadioButton = ui.Image:new()
function RadioButton:onTouchEvent(type, id, x, y)
  if type == "TOUCHDOWN" and ui.ImageButton.hitTest(self, x, y) then
    self.down = true
    self.hold = true
    self.pressed = true
    return "CHANNEL_CLICKED", self.meta, self
  end
  if type == "TOUCHHOLD" and ui.ImageButton.hitTest(self, x, y) then
    self.hold = true
  end
end
function RadioButton:setImages(a, b)
  self.images = {a, b}
  self:setImage(a)
end
function RadioButton:update(dt, time)
  for k, v in _G.pairs(gamelua.touches) do
    if ui.ImageButton.hitTest(self, v.x, v.y) then
      self.hold = true
    end
  end
  if self.down then
    self:setImage(self.images[2])
  else
    self:setImage(self.images[1])
  end
end
if debug_draw then
  function RadioButton:draw(x, y)
    ui.Image.draw(self, x, y)
    local sw, sh = _G.res.getSpriteBounds("SOUNDBOARD_2_WHEEL")
    local px, py = _G.res.getSpritePivot("SOUNDBOARD_2_WHEEL")
    local min_radius = sw * 0.5
    local max_radius = sw * 1.5
    local cx = self.x - px + sw * 0.5
    local cy = self.y - py + sh * 0.5
    gamelua.setRenderState(0, 0, 1, 1)
    for i = 0, 15 do
      local a1 = _G.math.pi * 2 * (i / 16)
      local a2 = _G.math.pi * 2 * ((i + 1) / 16)
      local xm1 = _G.math.cos(a1)
      local xm2 = _G.math.cos(a2)
      local ym1 = _G.math.sin(a1)
      local ym2 = _G.math.sin(a2)
      gamelua.drawLine(255, 0, 0, 255, cx + min_radius * xm1, cy + min_radius * ym1, cx + min_radius * xm2, cy + min_radius * ym2, false, 1)
      gamelua.drawLine(255, 255, 0, 255, cx + max_radius * xm1, cy + max_radius * ym1, cx + max_radius * xm2, cy + max_radius * ym2, false, 1)
    end
  end
end
RadioWheel = ui.Image:new()
function RadioWheel:onEntry()
  ui.Image.onEntry(self)
  self.state = "IDLE"
  self.angle = 0
  self.channel = nil
  self.channel_pos = 1
end
function RadioWheel:onPointerEvent(eventType, x, y)
  if eventType == "LPRESS" and self.state == "IDLE" then
    local sw, sh = _G.res.getSpriteBounds("SOUNDBOARD_2_WHEEL")
    local px, py = _G.res.getSpritePivot("SOUNDBOARD_2_WHEEL")
    local center_x = self.x - px + sw * 0.5
    local center_y = self.y - py + sh * 0.5
    local min_radius = sw * 0.5
    local max_radius = sw * 1.5
    local dist = gamelua.distance(center_x, center_y, x, y)
    if min_radius <= dist and max_radius >= dist then
      self.state = "DRAGGING"
      self.last_angle = _G.math.atan2(y - center_y, x - center_x)
    end
  end
  if eventType == "LHOLD" and self.state == "DRAGGING" then
    local sw, sh = _G.res.getSpriteBounds("SOUNDBOARD_2_WHEEL")
    local px, py = _G.res.getSpritePivot("SOUNDBOARD_2_WHEEL")
    local center_x = self.x - px + sw * 0.5
    local center_y = self.y - py + sh * 0.5
    local min_radius = sw * 0.5
    local dist = gamelua.distance(center_x, center_y, x, y)
    local angle = _G.math.atan2(y - center_y, x - center_x)
    if min_radius <= dist then
      self.state = "DRAGGING"
      local diff = angle - self.last_angle
      if diff >= _G.math.pi then
        diff = diff - _G.math.pi * 2
      elseif diff <= -_G.math.pi then
        diff = diff + _G.math.pi * 2
      end
      self.channel_pos = self.channel_pos + diff / (_G.math.pi * 2)
      if self.channel_pos < 1 then
        self.channel_pos = 1
      elseif self.channel_pos > 4 then
        self.channel_pos = 4
      end
    end
    self.last_angle = angle
  end
  if eventType == "LRELEASE" and self.state == "DRAGGING" then
    self:release()
  end
end
function RadioWheel:spinTo(target)
  self.target = target
  if self.target >= self.channel_pos then
    self.direction = 1
    self.state = "AUTOSPINNING"
  elseif self.target < self.channel_pos then
    self.direction = -1
    self.state = "AUTOSPINNING"
  end
end
function RadioWheel:release()
  local nearest = channels[1]
  local dist = _G.math.huge
  for k, v in _G.pairs(channels) do
    local d = _G.math.abs(k - self.channel_pos)
    if dist > d then
      nearest = k
      dist = d
    end
  end
  self.target = nearest
  if self.target >= self.channel_pos then
    self.direction = 1
    self.state = "AUTOSPINNING"
  elseif self.target < self.channel_pos then
    self.direction = -1
    self.state = "AUTOSPINNING"
  end
end
function RadioWheel:update(dt)
  ui.Image.update(self, dt)
  if self.state == "AUTOSPINNING" then
    self.channel_pos = self.channel_pos + dt * self.direction * 4
    if self.direction < 0 then
      self.channel_pos = _G.math.max(self.channel_pos, self.target)
    elseif self.direction > 0 then
      self.channel_pos = _G.math.min(self.channel_pos, self.target)
    end
    if self.channel_pos == self.target then
      self.state = "IDLE"
      self.channel = self.channel_pos
    end
  end
  self.angle = self.channel_pos * _G.math.pi * 2
end
Radio = ui.Frame:new()
function Radio:init()
  ui.Frame.init(self)
  self.name = "Radio"
  local background = ui.Image:new()
  background.name = "background"
  background:setImage("GOLDEN_EGG_BG_1")
  self:addChild(background)
  local radio = ui.Image:new()
  radio.name = "radio"
  radio:setImage("SOUNDBOARD_2_RADIO")
  self:addChild(radio)
  local wheel = RadioWheel:new()
  wheel.name = "wheel"
  wheel:setImage("SOUNDBOARD_2_WHEEL")
  self:addChild(wheel)
  for i = 1, 4 do
    local channel_button = RadioButton:new()
    channel_button.name = "channel_button_" .. i
    channel_button.meta = i
    channel_button:setImages("SOUNDBOARD_2_BUTTON_UP_" .. i, "SOUNDBOARD_2_BUTTON_DOWN_" .. i)
    self:addChild(channel_button)
  end
  local bird_shadow = ui.Image:new()
  bird_shadow.name = "bird_shadow"
  bird_shadow:setImage("SOUNDBOARD_2_BIRD_SHADOW")
  self:addChild(bird_shadow)
  local bird = ui.Image:new()
  bird.name = "bird"
  bird:setImage("SOUNDBOARD_2_BIRD")
  self:addChild(bird)
  local indicator = ui.Image:new()
  indicator.name = "indicator"
  indicator:setImage("SOUNDBOARD_2_INDICATOR")
  self:addChild(indicator)
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
function Radio:layout()
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
  local radio = self:getChild("radio")
  local sw, sh = _G.res.getSpriteBounds(radio.image)
  local px, py = _G.res.getSpritePivot(radio.image)
  local x = gamelua.screenWidth * 0.5
  local y
  if gamelua.screenHeight >= gamelua.screenHeight * 0.5 + (sh - py) * 1.2 then
    y = gamelua.screenHeight * 0.5
  else
    y = gamelua.screenHeight - (sh - py) * 1.2
  end
  radio.x = x
  radio.y = y
  for i = 1, 4 do
    local channel_button = self:getChild("channel_button_" .. i)
    channel_button.x = x
    channel_button.y = y
  end
  local wheel = self:getChild("wheel")
  wheel.x = x
  wheel.y = y
  local ww, wh = _G.res.getSpriteBounds("SOUNDBOARD_2_WHEEL")
  wheel.rotatePivotX = ww * 0.5
  wheel.rotatePivotY = wh * 0.5
  local bird = self:getChild("bird")
  local bw, bh = _G.res.getSpriteBounds(bird.image)
  bird.x = x + (sw - px) - bw * 0.4
  bird.y = y + (sh - py) - bh * 0.4
  bird.y0 = bird.y
  local bird_shadow = self:getChild("bird_shadow")
  local _, bsh = _G.res.getSpriteBounds(bird_shadow.image)
  bird_shadow.x = x + (sw - px) - bw * 0.4
  bird_shadow.y = y + (sh - py) + bsh * 0.5
  local indicator = self:getChild("indicator")
  indicator.y = y - py + sh * 0.42
  indicator.x0 = x - px + sw * indicator_pos.x0
  indicator.x1 = x - px + sw * indicator_pos.x1
  indicator.x = indicator.x0
end
function Radio:onEntry()
  ui.Frame.onEntry(self)
  self.current_channel = nil
  _G.res.stopAudio(gamelua.currentMainMenuSong)
  gamelua.menuManager:enableMultiTouch()
  self.bird_pos = nil
end
function Radio:onExit()
  ui.Frame.onExit(self)
  gamelua.menuManager:disableMultiTouch()
  gamelua.releaseAssets({
    "GOLDEN_EGGS"
  })
  if self.current_channel and channels[self.current_channel] and self.current_channel ~= 1 and _G.res.isAudioPlaying(channels[self.current_channel].song) then
    _G.res.stopAudio(channels[self.current_channel].song)
  end
end
function Radio:collectStar()
  self.star_collected = true
  gamelua.goldenEggStarAchieved("RADIO")
end
function Radio:onPointerEvent(eventType, x, y)
  local result, meta, item = ui.Frame.onPointerEvent(self, eventType, x, y)
  if result == "EXIT_SOUNDBOARD" then
    gamelua.eventManager:notify({
      id = events.EID_CHANGE_SCENE,
      target = "LEVEL_SELECTION_G"
    })
  end
  return result, meta, item
end
function Radio:onKeyEvent(eventType, key)
  local result, meta, item = ui.Frame.onKeyEvent(self, eventType, key)
  if not result and eventType == "RELEASE" and (key == "BACK" or key == "ESCAPE") then
    gamelua.eventManager:notify({
      id = events.EID_CHANGE_SCENE,
      target = "LEVEL_SELECTION_G"
    })
  end
  return result, meta, item
end
function Radio:onTouchEvent(type, id, x, y)
  local result, meta, item = ui.Frame.onTouchEvent(self, type, id, x, y)
  if result == "CHANNEL_CLICKED" then
    local target = meta
    self:getChild("wheel"):spinTo(meta)
    if meta ~= self.last_button then
      _G.res.playAudio("button_radio", 1, false)
    end
    self.last_button = meta
  end
  return result, meta, item
end
function Radio:update(dt, time)
  ui.Frame.update(self, dt, time)
  local new_count = 0
  for i = 1, 4 do
    local channel_button = self:getChild("channel_button_" .. i)
    if channel_button.pressed then
      new_count = new_count + 1
    end
  end
  for i = 1, 4 do
    local channel_button = self:getChild("channel_button_" .. i)
    if new_count > 0 and not channel_button.hold then
      channel_button.down = false
    end
    channel_button.hold = false
    channel_button.pressed = false
  end
  local down_count = 0
  for i = 1, 4 do
    local channel_button = self:getChild("channel_button_" .. i)
    if channel_button.down then
      down_count = down_count + 1
    end
  end
  if down_count == 2 and not _G.res.isAudioPlaying(channels[3.5].song) then
    self:getChild("wheel"):spinTo(3.5)
  end
  local wheel = self:getChild("wheel")
  do
    local indicator = self:getChild("indicator")
    indicator.x = indicator.x0 + (indicator.x1 - indicator.x0) * ((wheel.channel_pos - 1) / 3)
    if wheel.channel == 3.5 and not self.star_collected then
      self:collectStar()
    end
    if wheel.channel == 3.5 and self.bird_pos == nil then
      self.bird_pos = 0
    end
    local bird = self:getChild("bird")
    if wheel.channel == 3.5 then
      self.bird_pos = (self.bird_pos + dt * 5) % _G.math.pi
    elseif self.bird_pos ~= nil then
      self.bird_pos = self.bird_pos + dt * 5
      if self.bird_pos >= _G.math.pi then
        self.bird_pos = nil
      end
    end
    local _, sh = _G.res.getSpriteBounds(bird.image)
    if self.bird_pos ~= nil then
      bird.angle = _G.math.sin(self.bird_pos) * 0.25
      bird.y = bird.y0 - _G.math.sin(self.bird_pos) * sh * 0.333
    else
      bird.angle = 0
      bird.y = bird.y0
    end
  end
  if wheel.channel ~= self.current_channel then
    if self.current_channel and channels[self.current_channel] and _G.res.isAudioPlaying(channels[self.current_channel].song) then
      _G.res.stopAudio(channels[self.current_channel].song)
    end
    self.current_channel = wheel.channel
    _G.res.playAudio(channels[self.current_channel].song, 0.8, true, 7)
    local play_button_sound = false
    if self.current_channel ~= 3.5 then
      for i = 1, 4 do
        local channel_button = self:getChild("channel_button_" .. i)
        if channel_button.down and not self.current_channel == i then
          channel_button.down = false
        elseif not channel_button.down and self.current_channel == i then
          channel_button.down = true
          play_button_sound = true
        elseif channel_button.down and self.current_channel == i then
        else
          channel_button.down = false
        end
      end
    else
      local down_count = 0
      for i = 1, 4 do
        local channel_button = self:getChild("channel_button_" .. i)
        if channel_button.down then
          down_count = down_count + 1
        end
      end
      if down_count < 2 then
        self:getChild("channel_button_1").down = false
        self:getChild("channel_button_2").down = false
        self:getChild("channel_button_3").down = true
        self:getChild("channel_button_4").down = true
        play_button_sound = true
      end
    end
    if play_button_sound then
      _G.res.playAudio("button_radio", 1, false)
    end
  elseif self.current_channel and channels[self.current_channel] and not _G.res.isAudioPlaying(channels[self.current_channel].song) then
    _G.res.playAudio(channels[self.current_channel].song, 0.8, true, 7)
  end
end
filename = "radio.lua"
