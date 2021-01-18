ui = gamelua.ui
print = gamelua.print
events = gamelua.events
SoundboardButton = ui.ImageButton:new()
function SoundboardButton:onEntry()
  ui.ImageButton.onEntry(self)
  self.click_time = -0.5
end
function SoundboardButton:update(dt, time)
  ui.ImageButton.update(self, dt, time)
  if time < self.click_time + 0.1 then
    self.scaleX = 0.875
    self.scaleY = 0.875
  else
    self.scaleX = 1
    self.scaleY = 1
  end
end
Soundboard = ui.Frame:new()
soundboard_buttons = {
  {
    image = "SOUNDBOARD_1_LEVEL_START",
    rel_x = 0.15,
    rel_y = 0.35,
    audio = {
      default = "level_start_military"
    },
    type = "play"
  },
  {
    image = "SOUNDBOARD_1_LEVEL_FAIL",
    rel_x = 0.15,
    rel_y = 0.65,
    audio = {
      default = "level_failed_piglets"
    },
    type = "reset"
  },
  {
    image = "SOUNDBOARD_1_BIRD_BLUE",
    rel_x = 0.23,
    rel_y = 0.2,
    audio = {
      default = "bird_misc",
      launch = "bird_02_flying",
      special = "special_group",
      collide = "bird_02_collision"
    },
    type = "bird"
  },
  {
    image = "SOUNDBOARD_1_BIRD_RED",
    rel_x = 0.36,
    rel_y = 0.2,
    audio = {
      default = "bird_misc",
      launch = "bird_01_flying",
      special = "red_special",
      collide = "bird_01_collision"
    },
    type = "bird"
  },
  {
    image = "SOUNDBOARD_1_BIRD_YELLOW",
    rel_x = 0.52,
    rel_y = 0.2,
    audio = {
      default = "bird_misc",
      launch = "bird_03_flying",
      special = "special_boost",
      collide = "bird_03_collision"
    },
    type = "bird"
  },
  {
    image = "SOUNDBOARD_1_BIRD_BLACK",
    rel_x = 0.7,
    rel_y = 0.2,
    audio = {
      default = "bird_misc",
      launch = "bird_04_flying",
      special = "special_explosion",
      collide = "bird_04_collision"
    },
    type = "bird"
  },
  {
    image = "SOUNDBOARD_1_BIRD_WHITE",
    rel_x = 0.9,
    rel_y = 0.2,
    audio = {
      default = "bird_misc",
      launch = "bird_05_flying",
      special = "special_egg",
      collide = "bird_05_collision"
    },
    type = "bird"
  },
  {
    image = "SOUNDBOARD_1_SLINGSHOT",
    rel_x = 0.35,
    rel_y = 0.5,
    audio = {
      default = "slingshot_stretched"
    },
    type = "slingshot"
  },
  {
    image = "SOUNDBOARD_1_TNT",
    rel_x = 0.5,
    rel_y = 0.5,
    audio = {
      default = "tnt_explodes"
    },
    type = "block"
  },
  {
    image = "SOUNDBOARD_1_BLOCK_STONE",
    rel_x = 0.66,
    rel_y = 0.5,
    audio = {
      default = "rock_collision",
      hit = "rock_destroyed"
    },
    type = "block"
  },
  {
    image = "SOUNDBOARD_1_BLOCK_WOOD",
    rel_x = 0.77,
    rel_y = 0.5,
    audio = {
      default = "wood_collision",
      hit = "wood_destroyed"
    },
    type = "block"
  },
  {
    image = "SOUNDBOARD_1_BLOCK_ICE",
    rel_x = 0.88,
    rel_y = 0.5,
    audio = {
      default = "light_collision",
      hit = "light_destroyed"
    },
    type = "block"
  },
  {
    image = "SOUNDBOARD_1_PIG_SMALL",
    rel_x = 0.3,
    rel_y = 0.8,
    audio = {
      default = "piglette",
      kill = "piglette_destroyed"
    },
    type = "pig"
  },
  {
    image = "SOUNDBOARD_1_PIG_HELMET",
    rel_x = 0.5,
    rel_y = 0.8,
    audio = {
      default = "piglette",
      kill = "piglette_destroyed"
    },
    type = "pig"
  },
  {
    image = "SOUNDBOARD_1_PIG_OLD",
    rel_x = 0.7,
    rel_y = 0.8,
    audio = {
      default = "piglette",
      kill = "piglette_destroyed"
    },
    type = "pig"
  },
  {
    image = "SOUNDBOARD_1_PIG_KING",
    rel_x = 0.9,
    rel_y = 0.8,
    audio = {
      default = "piglette",
      kill = "piglette_destroyed"
    },
    type = "pig"
  }
}
function Soundboard:init()
  ui.Frame.init(self)
  self.name = "Soundboard"
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
  for k, v in _G.ipairs(soundboard_buttons) do
    local button = SoundboardButton:new()
    button.name = "soundboard_button_" .. k
    button.returnValue = "PLAY_CLIP"
    button.meta = k
    button:setImage(v.image)
    self:addChild(button)
  end
end
function Soundboard:layout()
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
  local ref_width = _G.math.min(gamelua.screenWidth, 1024)
  local ref_height = _G.math.min(gamelua.screenHeight, 768)
  if gamelua.deviceModel == "ipad" and gamelua.screenWidth == 2048 then
    ref_width = ref_width * 2
    ref_height = ref_height * 2
  end
  for k, v in _G.ipairs(soundboard_buttons) do
    local button = self:getChild("soundboard_button_" .. k)
    button.x = gamelua.screenWidth * 0.5 - ref_width * 0.5 + v.rel_x * ref_width
    button.y = gamelua.screenHeight * 0.5 - ref_height * 0.5 + v.rel_y * ref_height
  end
end
function Soundboard:onEntry()
  ui.Frame.onEntry(self)
  self.state = "none"
  self.bird = 0
  self.specialty = false
  self.started = false
  self.star_collected = false
  _G.res.stopAudio(gamelua.currentMainMenuSong)
end
function Soundboard:onExit()
  ui.Frame.onExit(self)
  gamelua.releaseAssets({
    "GOLDEN_EGGS"
  })
end
function Soundboard:stopAudio(clip)
  if gamelua.audioGroups[clip] then
    for _, v in _G.ipairs(gamelua.audioGroups[clip]) do
      if _G.res.isAudioPlaying(v) then
        _G.res.stopAudio(v)
      end
    end
  elseif _G.res.isAudioPlaying(clip) then
    _G.res.stopAudio(clip)
  end
end
function Soundboard:clicked(id)
  local button = soundboard_buttons[id]
  if button.type == "play" then
    self.started = true
    return "play"
  elseif button.type == "slingshot" then
    self.state = "stretched"
    return "stretch"
  elseif button.type == "bird" then
    if self.state == "stretched" then
      self.state = "launched"
      self.bird = id
      self.specialty = true
      return "launch"
    elseif self.state == "launched" and self.bird == id then
      if self.specialty then
        self.specialty = false
        return "special"
      end
      return "collide"
    end
  elseif button.type == "pig" then
    if self.state == "launched" then
      if self.started and not self.star_collected then
        self:collectStar()
      end
      return "kill"
    end
  elseif button.type == "block" and self.state == "launched" then
    return "hit"
  end
  self.state = "none"
  self.started = false
  return nil
end
function Soundboard:collectStar()
  self.star_collected = true
  gamelua.goldenEggStarAchieved("SOUNDBOARD1")
end
function Soundboard:selectClip(action, button)
  local clips = soundboard_buttons[button].audio
  if action and clips[action] then
    return clips[action]
  end
  return clips.default
end
function Soundboard:onPointerEvent(eventType, x, y)
  local result, meta, item = ui.Frame.onPointerEvent(self, eventType, x, y)
  if result == "EXIT_SOUNDBOARD" then
    gamelua.eventManager:notify({
      id = events.EID_CHANGE_SCENE,
      target = "LEVEL_SELECTION_G"
    })
  elseif result == "PLAY_CLIP" then
    local action = self:clicked(meta)
    local clip = self:selectClip(action, meta)
    self:stopAudio(clip)
    _G.res.playAudio(gamelua.getAudioName(clip), 1, false, 0)
    item.click_time = gamelua.g_time
  end
  return result, meta, item
end
function Soundboard:onKeyEvent(eventType, key)
  local result, meta, item = ui.Frame.onKeyEvent(self, eventType, key)
  if not result and eventType == "RELEASE" and (key == "BACK" or key == "ESCAPE") then
    gamelua.eventManager:notify({
      id = events.EID_CHANGE_SCENE,
      target = "LEVEL_SELECTION_G"
    })
  end
  return result, meta, item
end
filename = "soundboard.lua"
