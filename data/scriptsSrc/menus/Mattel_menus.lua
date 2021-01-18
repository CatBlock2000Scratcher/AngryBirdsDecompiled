ActivationScreen = ui.Frame:new()
function ActivationScreen:onEntry()
  gamelua.setPhysicsEnabled(false)
  self.shade = 0
  self.timer = 0
  self.phase = 0
  self.shake_offset_x = 0
  self.shake_offset_y = 0
  self.stars = {}
  function gamelua.currentGameMode()
  end
  _G.res.playAudio("king pig splash", 1, false)
end
function ActivationScreen:draw(x, y)
  gamelua.setRenderState(0, 0, 1, 1, 0, 0, 0)
  gamelua.drawRect(0, 0, 0, self.shade, 0, 0, gamelua.screenWidth, gamelua.screenHeight, false)
  gamelua.drawMenuParticlesInAdvance()
  ui.Frame.draw(self, x + self.shake_offset_x, y + self.shake_offset_y)
end
function ActivationScreen:update(dt, time)
  self.timer = self.timer + dt
  if not g_mattel_load_random_level then
    gamelua.drawGame()
  end
  if self.phase == 0 then
    if self.timer <= 0.5 then
      self.shade = self.timer / 0.5
    else
      self.shade = 1
    end
    local stars = _G.math.min(self.timer / 0.5 * 50, 50)
    if stars > #self.stars then
      for i = #self.stars, stars do
        local star = ui.Image:new()
        star.name = "star" .. i
        star.x = _G.math.random(0, gamelua.screenWidth)
        star.y = _G.math.random(0, gamelua.screenHeight)
        star.scaleX = 0
        star.scaleY = 0
        star.angle = _G.math.random() * _G.math.pi * 2
        star:setImage("PARTICLE_BLACK_STAR")
        self:addChild(star)
        star.t0 = self.timer
        local sw, sh = _G.res.getSpriteBounds(star.image)
        _G.table.insert(self.stars, star)
      end
    end
    for _, v in _G.pairs(self.stars) do
      if v.t0 > self.timer - 0.3 then
        local scale = gamelua.tweenLinear(self.timer - v.t0, 0, 1, 0.3)
        v.scaleX = scale
        v.scaleY = scale
      else
        v.scaleX = 1
        v.scaleY = 1
      end
    end
    if self.timer >= 0.8 and not self.loaded then
      if not g_mattel_assets_loaded then
        print("<mattel> load mattel stuff\n")
        loadMattelAssets()
        g_mattel_assets_loaded = true
      else
        print("<mattel> mattel stuff already loaded\n")
      end
      self.timer = 0
      self.phase = 1
      local pig = ui.Image:new()
      pig.name = "pig"
      pig:setImage("LOGO_KINGPIG_LAUGH")
      self:addChild(pig)
      self:layout()
      self.shade = 1
      pig.x = gamelua.screenWidth * 0.5
      local _, sh = _G.res.getSpriteBounds(pig.image)
      pig.y0 = 0 - sh
      pig.y = pig.y0
      pig.yd = gamelua.screenHeight * 0.5 + 0.5 * sh - pig.y0
      self.pig = pig
      for _, v in _G.pairs(self.stars) do
        self:removeChild(v)
      end
    end
  elseif self.phase == 1 then
    local images = {
      "LOGO_KINGPIG_LAUGH",
      "LOGO_KINGPIG_LAUGH_2"
    }
    local image = _G.math.floor(self.timer / 0.2) % 2 + 1
    self:getChild("pig"):setImage(images[image])
    if self.timer >= 2 then
      self.timer = 0
      self.phase = 2
      self:getChild("pig"):setVisible(false)
      local splash = ui.Image:new()
      splash.name = "splash"
      splash:setImage("EFFECT_BROKENGLASS")
      splash:setVisible(false)
      self:addChild(splash)
      local stamp = ui.Image:new()
      stamp.name = "stamp"
      stamp:setImage(g_mattel_modes[g_mattel_mode].logo)
      stamp.scaleX = 3
      stamp.scaleY = 3
      self.stamp = stamp
      self:addChild(stamp)
      self:layout()
    elseif self.timer < 0.5 then
      self.pig.y = gamelua.tweenEaseBounceOut(self.timer, self.pig.y0, self.pig.yd, 0.5)
    else
      self.pig.y = self.pig.y0 + self.pig.yd
    end
  elseif self.phase == 2 then
    local scale = gamelua.tweenLinear(_G.math.min(self.timer, 0.1), 3, -2, 0.1)
    self.stamp.scaleX = scale
    self.stamp.scaleY = scale
    if self.timer >= 0.1 then
      self.phase = 3
      self:layout()
      local splash = self:getChild("splash")
      splash:setVisible(true)
      local w, h = _G.res.getSpriteBounds(splash.image)
      _G.res.playAudio(gamelua.getAudioName("jewel_break"), 1, false)
      _G.particles.addParticles("powerupBuff", 1, gamelua.screenWidth * 0.5, gamelua.screenHeight * 0.5, 0, 0, 0, true, true)
      _G.particles.addParticles("mattelSplashGlass", 20, gamelua.screenWidth * 0.5, gamelua.screenHeight * 0.5, w, h, 0, true, true)
      self.timer = 0
      local tagline = ui.Text:new()
      tagline.name = "tagline"
      tagline.text = g_mattel_modes[g_mattel_mode].tagline
      tagline.x = gamelua.screenWidth * 0.5
      tagline.y = gamelua.screenHeight * 0.75
      tagline:setFont(gamelua.getFontBasic)
      tagline.textBoxSize = gamelua.screenWidth * 0.6
      tagline:clip()
      self:layout()
      self:addChild(tagline)
    end
  elseif self.phase == 3 then
    if self.timer < 0.2 then
      self.shake_offset_x = (_G.math.random(0, 100) - 50) * (0.2 - self.timer) * gamelua.screenHeight / 768
      self.shake_offset_y = (_G.math.random(0, 100) - 50) * (0.2 - self.timer) * gamelua.screenHeight / 768
    elseif self.timer >= 1 then
    end
  end
end
function ActivationScreen:layout()
  ui.Frame.layout(self)
  local stamp = self:getChild("stamp")
  if stamp then
    stamp.x = gamelua.screenWidth * 0.5
    stamp.y = gamelua.screenHeight * 0.5
  end
  local splash = self:getChild("splash")
  if splash then
    splash.x = gamelua.screenWidth * 0.5
    splash.y = gamelua.screenHeight * 0.5
  end
  local tagline = self:getChild("tagline")
  if tagline then
    tagline:clip()
  end
end
function ActivationScreen:onPointerEvent(eventType, x, y)
  if eventType == "LPRESS" and g_mattel_assets_loaded then
    g_mattel_modes[g_mattel_mode].activation()
  end
  return "BLOCK", nil, self
end
function ActivationScreen:onKeyEvent(eventType, key)
  return "BLOCK", nil, self
end
MattelHud = ui.GameHud:inherit()
TimerHud = ui.GameHud:inherit()
function TimerHud:init()
  ui.GameHud.init(self)
  local timer_box = ui.Image:new()
  timer_box.name = "timer_box"
  timer_box:setImage("INGAME_TIMER")
  self:addChild(timer_box)
  self.timer_box = timer_box
  local minutes = ui.Text:new()
  minutes.name = "timer_text"
  minutes.font = "FONT_BASIC"
  minutes.hanchor = "RIGHT"
  self.minutes = minutes
  timer_box:addChild(minutes)
  local seconds = ui.Text:new()
  seconds.name = "timer_text"
  seconds.font = "FONT_BASIC"
  seconds.hanchor = "RIGHT"
  self.seconds = seconds
  timer_box:addChild(seconds)
  local hundreths = ui.Text:new()
  hundreths.name = "timer_text"
  hundreths.font = "FONT_BASIC"
  hundreths.hanchor = "RIGHT"
  self.hundreths = hundreths
  timer_box:addChild(hundreths)
end
function TimerHud:layout()
  ui.GameHud.layout(self)
  local timer_box = self:getChild("timer_box")
  timer_box.x = gamelua.screenWidth * 0.5
  local _, sh = _G.res.getSpriteBounds(timer_box.image)
  gamelua.setFont(self.minutes.font)
  local tw = _G.res.getStringWidth("0'00\"00")
  self.hundreths.x = tw * 0.5
  self.hundreths.y = sh * 0.5
  local tw = _G.res.getStringWidth("00")
  self.seconds.x = self.hundreths.x - tw
  self.seconds.y = sh * 0.5
  local tw = _G.res.getStringWidth("00\"")
  self.minutes.x = self.seconds.x - tw
  self.minutes.y = sh * 0.5
end
function TimerHud:update(dt, time)
  ui.GameHud.update(self, dt, time)
  local m, s, c = gamelua.countdownTimeParts(g_level_timer)
  self.minutes.text = m .. "'"
  self.seconds.text = s .. "\""
  self.hundreths.text = c
  self.timer_box:setVisible(self:getChild("pauseButton").visible)
end
LevelComplete = gamelua.LevelEnd:new()
function LevelComplete:init()
  self.name = "LevelComplete"
  self.menutype = "complete menu"
  gamelua.LevelEnd.init(self)
  local page_title = self:getChild("pageTitle")
  page_title:setVisible(false)
  local page_logo = ui.Image:new()
  page_logo.name = "page_logo"
  page_logo:setImage(self.logo)
  self:addChild(page_logo)
  local pig_face = ui.Image:new()
  pig_face.name = "pig_face"
  if gamelua.levelCompleted and not g_mattel_modes[g_mattel_mode].reverse_pig then
    pig_face:setImage("LOGO_KINGPIG_LAUGH")
  else
    pig_face:setImage("LOGO_KINGPIG_CRY_1")
  end
  self:addChild(pig_face)
  local buttonLeft = self:getChild("button1")
  local buttonMiddle = self:getChild("button2")
  local buttonRight = self:getChild("button3")
  buttonLeft:setVisible(true)
  buttonMiddle:setVisible(true)
  local disable_next_button = gamelua.isNextLevelButtonDisabled(gamelua.levelName)
  local next_level_locked = true
  if gamelua.highscores[gamelua.levelName] and gamelua.highscores[gamelua.levelName].completed then
    next_level_locked = false
  end
  if disable_next_button or next_level_locked then
    buttonRight:setVisible(false)
    self.buttons = 2
  else
    buttonRight:setVisible(true)
    self.buttons = 3
  end
  buttonLeft:setImage("BUTTON_MENU")
  buttonLeft.returnValue = "RETURN_TO_LEVEL_SELECTION"
  buttonMiddle:setImage("BUTTON_RESTART")
  buttonMiddle.returnValue = "RESTART_LEVEL"
  buttonMiddle.meta = {
    menu = self.menutype
  }
  local level, episode, page, index = gamelua.getLevelById(gamelua.levelName)
  if not level.clear_cutscene then
    buttonRight:setImage("BUTTON_NEXTLEVEL")
    buttonRight.returnValue = "NEXT_LEVEL"
    buttonRight.meta = {
      menu = self.menutype
    }
  else
    buttonRight:setImage("MENU_CUTSCENE")
    buttonRight.returnValue = "PLAY_CUTSCENE"
    buttonRight.meta = {
      cutscene = level.clear_cutscene,
      episode = episode,
      page = page,
      level = index
    }
  end
end
function LevelComplete:onPointerEvent(eventType, x, y)
  local result, meta, item = ui.Frame.onPointerEvent(self, eventType, x, y)
  if result == "NEXT_LEVEL" then
    mattel_disable()
  end
  gamelua.LevelEnd.onPointerEvent(self, eventType, x, y)
end
function LevelComplete:onEntry()
  gamelua.LevelEnd.onEntry(self)
  if gamelua.levelCompleted and not g_mattel_modes[g_mattel_mode].reverse_pig or not gamelua.levelCompleted and g_mattel_modes[g_mattel_mode].reverse_pig then
    _G.res.playAudio("king pig cry", 1, false, 7)
  else
    _G.res.playAudio("king pig laugh", 1, false, 7)
  end
  self.timer = 0
  self.tear_timer = 0
end
function LevelComplete:layout()
  self.button_y = 0.9
  gamelua.LevelEnd.layout(self)
  local page_logo = self:getChild("page_logo")
  page_logo.x = gamelua.screenWidth * 0.5
  page_logo.y = gamelua.screenHeight * 0.18
  local pig_face = self:getChild("pig_face")
  pig_face.x = gamelua.screenWidth * 0.5
  pig_face.y = gamelua.screenHeight * 0.8
end
function LevelComplete:update(dt, time)
  gamelua.LevelEnd.update(self, dt, time)
  self.timer = self.timer + dt
  local pig_face = self:getChild("pig_face")
  if gamelua.levelCompleted and not g_mattel_modes[g_mattel_mode].reverse_pig or not gamelua.levelCompleted and g_mattel_modes[g_mattel_mode].reverse_pig then
    local images = {
      "LOGO_KINGPIG_CRY_1",
      "LOGO_KINGPIG_CRY_2"
    }
    local image = _G.math.floor(self.timer / 0.2) % 2 + 1
    pig_face:setImage(images[image])
    self.tear_timer = self.tear_timer + dt
    if self.tear_timer >= 0.1 then
      local tear_multiplier = 1
      if gamelua.deviceModel == "ipad" and gamelua.screenWidth == 2048 then
        tear_multiplier = 2
      end
      _G.particles.addParticles("mattelPigTears", 1, pig_face.x - 120 * tear_multiplier, pig_face.y - 120 * tear_multiplier, 0, 0, 0, true, true)
      _G.particles.addParticles("mattelPigTears", 1, pig_face.x + 100 * tear_multiplier, pig_face.y - 120 * tear_multiplier, 0, 0, 0, true, true)
      self.tear_timer = 0
    end
  else
    local images = {
      "LOGO_KINGPIG_LAUGH",
      "LOGO_KINGPIG_LAUGH_2"
    }
    local image = _G.math.floor(self.timer / 0.2) % 2 + 1
    pig_face:setImage(images[image])
  end
end
filename = "Mattel_menus.lua"
