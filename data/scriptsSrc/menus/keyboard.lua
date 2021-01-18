ui = gamelua.ui
print = gamelua.print
events = gamelua.events
keyboard_keys = {
  C = {
    inactive = "BIRD_BLUE",
    active = "BIRD_BLUE_YELL",
    x = 39,
    y = 221,
    ss = 0.5,
    so = 0
  },
  Cis = {
    inactive = "BIRD_GREY",
    active = "BIRD_GREY_YELL",
    x = 72,
    y = 132,
    ss = 1,
    so = 0
  },
  D = {
    inactive = "BIRD_RED",
    active = "BIRD_RED_YELL",
    x = 123,
    y = 218,
    ss = 0.7,
    so = -1
  },
  Dis = {
    inactive = "BIRD_GREY_BLINK",
    active = "BIRD_GREY_YELL",
    x = 168,
    y = 132,
    ss = 1,
    so = 0
  },
  E = {
    inactive = "BIRD_YELLOW",
    active = "BIRD_YELLOW_YELL",
    x = 212,
    y = 218,
    ss = 0.9,
    so = 0
  },
  F = {
    inactive = "BIRD_GREEN",
    active = "BIRD_GREEN_YELL",
    x = 315,
    y = 215,
    ss = 1,
    so = -3
  },
  Fis = {
    inactive = "BIRD_GREY_FLYING",
    active = "BIRD_GREY_YELL",
    x = 392,
    y = 134,
    ss = 1,
    so = -2
  },
  G = {
    inactive = "BIRD_BOOMERANG",
    active = "BIRD_BOOMERANG_YELL",
    x = 434,
    y = 222,
    ss = 0.9,
    so = -15
  }
}
song = {
  {note = "C", delay = 0.5},
  {note = "D", delay = 0.1875},
  {note = "Dis", delay = 0.1875},
  {note = "C", delay = 0.375},
  {note = "G", delay = 0.375},
  {note = "G", delay = 0.6},
  {note = "G", delay = 0.375},
  {note = "F", delay = 0.15},
  {note = "Dis", delay = 0.225},
  {note = "Dis", delay = 0.375},
  {note = "D", delay = 0.15},
  {note = "C", delay = 0.225}
}
KeyboardButton = ui.Image:new()
function KeyboardButton:init()
  ui.Image.init(self)
  self.click_time = -0.5
  self.click_scale = 1
  self.images = {"", ""}
end
function KeyboardButton:onEntry()
  ui.Image.onEntry(self)
  self.click_time = -0.5
  self.click_scale = 1
end
function KeyboardButton:update(dt, time)
  ui.Image.update(self, dt, time)
  if time < self.click_time + 0.1 then
    ui.Image.setImage(self, self.images[2])
    self.click_scale = 0.8
    local _, py = _G.res.getSpritePivot(self.image)
    local _, sh = _G.res.getSpriteBounds(self.image)
    self.click_offset = sh - py - (sh - py) * 0.8
  else
    ui.Image.setImage(self, self.images[1])
    self.click_scale = 1
    self.click_offset = 0
  end
end
function KeyboardButton:draw(x, y)
  ui.Image.draw(self, x, y + self.click_offset, scaleX, self.click_scale)
end
function KeyboardButton:setImage(inactive, active)
  ui.Image.setImage(self, inactive)
  self.images = {inactive, active}
end
function KeyboardButton:onPointerEvent(eventType, x, y)
  if ui.ImageButton.hitTest(self.hitBox, x, y) then
    if eventType == "LPRESS" then
      self.swipeReady = false
      return "PLAY_NOTE", self.meta, self
    elseif eventType == "LHOLD" and self.swipeReady then
      self.swipeReady = false
      return "PLAY_NOTE", self.meta, self
    end
  else
    self.swipeReady = true
  end
end
Keyboard = ui.Frame:new()
function Keyboard:init()
  ui.Frame.init(self)
  self.name = "Keyboard"
  local background = ui.Image:new()
  background.name = "background"
  background:setImage("GOLDEN_EGG_BG_1")
  self:addChild(background)
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
  for k, v in _G.pairs(keyboard_keys) do
    local shadow = ui.Image:new()
    shadow.name = "shadow" .. k
    shadow:setImage("SOUNDBOARD_3_SHADOW")
    self:addChild(shadow)
    local key = KeyboardButton:new()
    key.name = "key" .. k
    key:setImage(v.inactive, v.active)
    key.returnValue = "PLAY_NOTE"
    key.meta = k
    self:addChild(key)
  end
end
function Keyboard:layout()
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
  local scale = gamelua.screenHeight / 320
  if scale > 1.4 then
    scale = 1.4
  end
  local ref_width = _G.math.min(gamelua.screenWidth, 640)
  local ref_height = _G.math.min(gamelua.screenHeight, 480)
  local ingame_asset_scale = 1
  if gamelua.deviceModel == "ipad" and gamelua.screenWidth == 2048 then
    ref_width = ref_width * 2
    ref_height = ref_height * 2
    ingame_asset_scale = 2
  elseif gamelua.deviceModel == "iphone" and gamelua.screenWidth == 960 then
    ref_width = 960
    ref_height = 640
    ingame_asset_scale = 1.4
  end
  for k, v in _G.pairs(keyboard_keys) do
    local bird = self:getChild("key" .. k)
    local shadow = self:getChild("shadow" .. k)
    local _, bh = _G.res.getSpriteBounds(bird.image)
    local _, bpx = _G.res.getSpritePivot(bird.image)
    local _, sh = _G.res.getSpriteBounds(shadow.image)
    bird.x = gamelua.screenWidth * 0.5 - ref_width * 0.5 + v.x * (ref_width / 480)
    shadow.x = bird.x + v.so * scale * ingame_asset_scale
    bird.y = gamelua.screenHeight * 0.5 - ref_height * 0.5 + v.y * (ref_height / 320)
    shadow.y = bird.y + (bh - bpx) * scale * ingame_asset_scale
    bird.scaleX = scale * ingame_asset_scale
    bird.scaleY = scale * ingame_asset_scale
    shadow.scaleX = scale * v.ss
    shadow.scaleY = scale * v.ss
    bird.hitBox = {
      x = bird.x,
      y = bird.y,
      h = bird.h,
      w = bird.w,
      px = bird.px,
      py = bird.py,
      scaleX = scale * ingame_asset_scale,
      scaleY = scale * ingame_asset_scale
    }
  end
end
function Keyboard:onEntry()
  ui.Frame.onEntry(self)
  self.state = "IDLE"
  self.star_collected = false
  self.last_notes = {}
  _G.res.stopAudio(gamelua.currentMainMenuSong)
end
function Keyboard:onExit()
  ui.Frame.onExit(self)
  gamelua.releaseAssets({
    "GOLDEN_EGGS"
  })
end
function Keyboard:collectStar()
  self.star_collected = true
  gamelua.goldenEggStarAchieved("KEYBOARD")
end
function Keyboard:onPointerEvent(eventType, x, y)
  local result, meta, item = ui.Frame.onPointerEvent(self, eventType, x, y)
  if result == "EXIT_SOUNDBOARD" then
    gamelua.eventManager:notify({
      id = events.EID_CHANGE_SCENE,
      target = "LEVEL_SELECTION_G"
    })
  elseif result == "PLAY_NOTE" then
    _G.res.playAudio("note" .. meta, 1, false, 0)
    item.click_time = gamelua.g_time
    if #self.last_notes == 5 then
      _G.table.remove(self.last_notes, 1)
    end
    _G.table.insert(self.last_notes, meta)
    self:checkMelody()
  end
  return result, meta, item
end
function Keyboard:onKeyEvent(eventType, key)
  local result, meta, item = ui.Frame.onKeyEvent(self, eventType, key)
  if not result and eventType == "RELEASE" and (key == "BACK" or key == "ESCAPE") then
    gamelua.eventManager:notify({
      id = events.EID_CHANGE_SCENE,
      target = "LEVEL_SELECTION_G"
    })
  end
  return result, meta, item
end
function Keyboard:checkMelody()
  if #self.last_notes == 5 and self.last_notes[1] == "C" and self.last_notes[2] == "D" and self.last_notes[3] == "Dis" and self.last_notes[4] == "C" and self.last_notes[5] == "G" and not self.star_collected then
    self.state = "AUTOPLAY"
    self.play_pos = 1
    self.play_timer = 0
  end
end
function Keyboard:update(dt, time)
  ui.Frame.update(self, dt, time)
  if self.state == "AUTOPLAY" then
    if self.play_pos <= #song then
      self.play_timer = self.play_timer + dt
      if self.play_timer >= song[self.play_pos].delay then
        self.play_timer = self.play_timer - song[self.play_pos].delay
        _G.res.playAudio("note" .. song[self.play_pos].note, 1, false, 0)
        self:getChild("key" .. song[self.play_pos].note).click_time = gamelua.g_time
        self.play_pos = self.play_pos + 1
      end
    else
      self.state = "IDLE"
      if not self.star_collected then
        self:collectStar()
      end
    end
  end
end
filename = "keyboard.lua"
