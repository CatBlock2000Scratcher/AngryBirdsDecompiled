ui = gamelua.ui
print = gamelua.print
events = gamelua.events
Slider = ui.Image:new()
function Slider:init()
  ui.Image.init(self)
  self.pos_min = 0
  self.pos_max = 0
  self.value = 0
  self.state = "IDLE"
end
function Slider:setPositionRange(min, max)
  self.pos_min = min
  self.pos_max = max
  self:recalculatePosition()
end
function Slider:setValue(value)
  self.value = value
  self:recalculatePosition()
end
function Slider:getValue()
  return self.value
end
function Slider:valueFromX(x)
  if x < self.pos_min then
    return 0
  elseif x > self.pos_max then
    return 1
  end
  return (x - self.pos_min) / (self.pos_max - self.pos_min)
end
function Slider:recalculatePosition()
  self.x = self.value * (self.pos_max - self.pos_min) + self.pos_min
end
function Slider:onPointerEvent(eventType, x, y)
  if ui.ImageButton.hitTest(self, x, y) then
    if eventType == "LPRESS" then
      self.click_start_time = gamelua.g_time
      self.click_start_x = x
      self.last_x = x
      self.state = "CLICK"
    elseif eventType == "LHOLD" then
      if self.state == "IDLE" then
        self.click_start_time = gamelua.g_time
        self.click_start_x = x
        self.state = "CLICK"
      end
      if _G.math.abs(self.click_start_x - x) > gamelua.tapRadius then
        self.state = "DRAGGING"
      end
      self.last_x = x
    elseif eventType == "LRELEASE" then
      if self.state == "CLICK" and self.onClick then
        self:onClick()
      end
      self.state = "IDLE"
    end
  end
  return nil, nil, nil
end
function Slider:update(dt, time)
  ui.Image.update(self, dt, time)
  if self.state == "DRAGGING" then
    self:setValue(self:valueFromX(self.last_x))
    if self.onValueChanged then
      self:onValueChanged()
    end
  end
end
Sequencer = ui.Frame:new()
function Sequencer:init()
  ui.Frame.init(self)
  self.name = "Sequencer"
  local background = ui.Image:new()
  background.name = "background"
  background:setImage("GOLDEN_EGG_BG_1")
  self:addChild(background)
  local footprints = ui.Image:new()
  footprints.name = "footprints"
  footprints:setImage("SOUNDBOARD_4_FOOTPRINT")
  self:addChild(footprints)
  local sequencer_bg = ui.Image:new()
  sequencer_bg.name = "sequencer_bg"
  sequencer_bg:setImage("SOUNDBOARD_4_BG")
  self:addChild(sequencer_bg)
  local indicator = ui.Image:new()
  indicator.name = "indicator"
  indicator:setImage("SOUNDBOARD_4_HIGHLIGHT")
  indicator:setVisible(false)
  self:addChild(indicator)
  local top_grass = ui.TiledImage:new()
  top_grass.name = "top_grass"
  top_grass:setImage("SOUNDBOARD_4_GRASS_TOP")
  self:addChild(top_grass)
  local bottom_grass = ui.TiledImage:new()
  bottom_grass.name = "bottom_grass"
  bottom_grass:setImage("SOUNDBOARD_4_GRASS_BOTTOM")
  self:addChild(bottom_grass)
  local pig_sprites = {
    {
      "SOUNDBOARD_4_PIG_1",
      "PIGLETTE_BIG_01_BLINK"
    },
    {
      "SOUNDBOARD_4_PIG_2",
      "PIGLETTE_HELMET_01_BLINK"
    },
    {
      "SOUNDBOARD_4_PIG_3",
      "PIGLETTE_GRANDPA_01_BLINK"
    }
  }
  for j = 1, 3 do
    for i = 1, 8 do
      local pig = ui.ToggleButton:new()
      pig.name = "pig" .. j .. i
      pig:setImage(pig_sprites[j])
      pig.returnValue = "PIG_CLICKED"
      pig.meta = {col = j, row = i}
      self:addChild(pig)
    end
  end
  local bird = Slider:new()
  bird.name = "bird"
  bird:setImage("BIRD_BIG_BROTHER_BLINK")
  bird:setValue(0.5)
  self:addChild(bird)
  function bird.onClick(bird)
    self:togglePlay()
  end
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
  self.play = false
  self.direction = 1
  self.animation = 0
  self.timer = 0
  self.play_pos = 1
end
function Sequencer:togglePlay()
  local bird = self:getChild("bird")
  self.play = not self.play
  if self.play then
    bird:setImage("BIRD_BIG_BROTHER_YELL")
    self.play_delay = 1
    self.timer = 0
    self.play_pos = 0
    _G.res.playAudio(gamelua.getAudioName("big_brother_special_1"), 1, false, 0)
  else
    bird:setImage("BIRD_BIG_BROTHER_BLINK")
    bird.angle = 0
    self:getChild("indicator"):setVisible(false)
  end
  self:setBirdPivot(bird)
  self:updatePigFaces()
end
function Sequencer:layout()
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
    local sequencer_bg = self:getChild("sequencer_bg")
    sequencer_bg.x = 0
    sequencer_bg.y = gamelua.screenHeight * 0.15
    sequencer_bg.w = gamelua.screenWidth
    local top_grass = self:getChild("top_grass")
    local bottom_grass = self:getChild("bottom_grass")
    top_grass.x = 0
    bottom_grass.x = 0
    top_grass.y = gamelua.screenHeight * 0.15
    bottom_grass.y = gamelua.screenHeight * 0.15 + sequencer_bg.h
    top_grass:setXRepeat(_G.math.ceil(gamelua.screenWidth / top_grass.w))
    bottom_grass:setXRepeat(_G.math.ceil(gamelua.screenWidth / bottom_grass.w))
    local sequencerWidth = gamelua.screenWidth - gamelua.g_layoutMargin.x * 2
    for j = 1, 3 do
      for i = 1, 8 do
        local pig = self:getChild("pig" .. j .. i)
        pig.x = sequencerWidth * 0.125 * (i - 0.5) + gamelua.g_layoutMargin.x
        pig.y = gamelua.screenHeight * 0.15 + sequencer_bg.h * 0.333 * (j - 0.5)
        local image_off = pig:getStateImage(1)
        local image_on = pig:getStateImage(2)
        local off_sw, _ = _G.res.getSpriteBounds(image_off)
        local on_sw, _ = _G.res.getSpriteBounds(image_on)
        pig.scales = {
          1,
          off_sw / on_sw
        }
      end
    end
    local indicator = self:getChild("indicator")
    indicator.y = gamelua.screenHeight * 0.15
    indicator.positions = {}
    for i = 1, 8 do
      indicator.positions[i] = sequencerWidth * 0.125 * (i - 0.5) + gamelua.g_layoutMargin.x
    end
  end
  local footprints = self:getChild("footprints")
  local bird = self:getChild("bird")
  local _, sh = _G.res.getSpriteBounds("BIRD_BIG_BROTHER")
  local fpw, _ = _G.res.getSpriteBounds(footprints.image)
  local bs = 1
  if gamelua.screenWidth > 480 then
    bs = 1.5
    if gamelua.deviceModel == "ipad" and gamelua.screenWidth == 2048 then
      bs = 3
    end
  end
  footprints.x = gamelua.screenWidth * 0.5
  footprints.y = gamelua.screenHeight * 0.84 + sh * 0.4
  bird.y = gamelua.screenHeight * 0.84
  bird.scaleX = bs
  bird.scaleY = bs
  bird:setPositionRange(gamelua.screenWidth * 0.5 - fpw * 0.5, gamelua.screenWidth * 0.5 + fpw * 0.5)
  self:setBirdPivot(bird)
end
function Sequencer:onEntry()
  ui.Frame.onEntry(self)
  _G.res.stopAudio(gamelua.currentMainMenuSong)
end
function Sequencer:onExit()
  ui.Frame.onExit(self)
  gamelua.releaseAssets({
    "GOLDEN_EGGS"
  })
end
function Sequencer:collectStar()
  self.star_collected = true
  gamelua.goldenEggStarAchieved("SEQUENCER")
end
function Sequencer:onPointerEvent(eventType, x, y)
  local result, meta, item = ui.Frame.onPointerEvent(self, eventType, x, y)
  if result == "EXIT_SOUNDBOARD" then
    gamelua.eventManager:notify({
      id = events.EID_CHANGE_SCENE,
      target = "LEVEL_SELECTION_G"
    })
  elseif result == "PIG_CLICKED" then
    item.scaleX = item.scales[item.state]
    item.scaleY = item.scales[item.state]
  end
  return result, meta, item
end
function Sequencer:onKeyEvent(eventType, key)
  local result, meta, item = ui.Frame.onKeyEvent(self, eventType, key)
  if not result and eventType == "RELEASE" and (key == "BACK" or key == "ESCAPE") then
    gamelua.eventManager:notify({
      id = events.EID_CHANGE_SCENE,
      target = "LEVEL_SELECTION_G"
    })
  end
  return result, meta, item
end
function Sequencer:update(dt, time)
  ui.Frame.update(self, dt, time)
  if self.play and self.play_delay > 0 then
    self.play_delay = _G.math.max(self.play_delay - dt, 0)
    if self.play_delay == 0 then
      local bird = self:getChild("bird")
      bird:setImage("BIRD_BIG_BROTHER")
      self:setBirdPivot(bird)
      local indicator = self:getChild("indicator")
      indicator:setVisible(true)
      indicator.x = indicator.positions[1]
      self.play_pos = 1
    end
  elseif self.play then
    local bird = self:getChild("bird")
    local tempo = bird:getValue() * -0.35 + 0.5
    self.animation = (self.animation + dt / (6 * tempo)) % 0.4
    local bird_angle
    if self.animation <= 0.1 then
      bird_angle = self.animation
    elseif self.animation <= 0.3 then
      bird_angle = 0.2 - self.animation
    else
      bird_angle = self.animation - 0.4
    end
    bird.angle = bird_angle
    self.timer = self.timer + dt
    if tempo <= self.timer then
      self.timer = self.timer - tempo
      self.play_pos = self.play_pos + 1
      if self.play_pos == 9 then
        self.play_pos = 1
      end
      self:playColumn()
      self:updatePigFaces()
    end
    local indicator = self:getChild("indicator")
    indicator.x = indicator.positions[self.play_pos]
    if not self.star_collected and bird:getValue() >= 0.98 and self:checkPigs() then
      self:collectStar()
      self:togglePlay()
    end
  end
end
function Sequencer:setBirdPivot(bird)
  local sw, sh = _G.res.getSpriteBounds("BIRD_BIG_BROTHER")
  bird.rotatePivotX = sw * 0.5
  bird.rotatePivotY = sh
end
function Sequencer:playColumn()
  local clips = {
    "pig_hi-hat_" .. (self.play_pos - 1) % 2 + 1,
    "pig_snare_" .. (self.play_pos - 1) % 4 + 1,
    "pig_bd"
  }
  for i = 1, 3 do
    local pig = self:getChild("pig" .. i .. self.play_pos)
    if pig.state == 2 then
      _G.res.playAudio(gamelua.getAudioName(clips[i]), 1, false, 0)
    end
  end
end
function Sequencer:checkPigs()
  local pigs = 0
  for j = 1, 3 do
    for i = 1, 8 do
      local pig = self:getChild("pig" .. j .. i)
      if pig:getState() == 2 then
        pigs = pigs + 1
      end
    end
  end
  return pigs == 24
end
function Sequencer:updatePigFaces()
  local images = {
    off = {
      {
        "SOUNDBOARD_4_PIG_1",
        "PIGLETTE_BIG_01_BLINK"
      },
      {
        "SOUNDBOARD_4_PIG_2",
        "PIGLETTE_HELMET_01_BLINK"
      },
      {
        "SOUNDBOARD_4_PIG_3",
        "PIGLETTE_GRANDPA_01_BLINK"
      }
    },
    on = {
      {
        "SOUNDBOARD_4_PIG_1",
        "PIGLETTE_BIG_01"
      },
      {
        "SOUNDBOARD_4_PIG_2",
        "PIGLETTE_HELMET_01"
      },
      {
        "SOUNDBOARD_4_PIG_3",
        "PIGLETTE_GRANDPA_01"
      }
    },
    hit = {
      {
        "SOUNDBOARD_4_PIG_1",
        "PIGLETTE_BIG_01_SMILE"
      },
      {
        "SOUNDBOARD_4_PIG_2",
        "PIGLETTE_HELMET_01_SMILE"
      },
      {
        "SOUNDBOARD_4_PIG_3",
        "PIGLETTE_GRANDPA_04_SMILE"
      }
    }
  }
  for j = 1, 3 do
    for i = 1, 8 do
      local pig = self:getChild("pig" .. j .. i)
      if self.play and self.play_pos == i then
        pig:setImage(images.hit[j])
      elseif self.play then
        pig:setImage(images.on[j])
      else
        pig:setImage(images.off[j])
      end
    end
  end
end
filename = "sequencer.lua"
