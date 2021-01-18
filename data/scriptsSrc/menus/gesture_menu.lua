ui = gamelua.ui
GestureMenu = ui.Frame:new()
function GestureMenu:init()
  ui.Frame.init(self)
  local menu_button = ui.Image:new()
  menu_button.name = "menu_button"
  menu_button:setImage("GESTURE_LEVELS")
  menu_button.images = {
    "GESTURE_LEVELS",
    "GESTURE_LEVELS_SELECTED"
  }
  self:addChild(menu_button)
  local resume_button = ui.Image:new()
  resume_button.name = "resume_button"
  resume_button:setImage("GESTURE_PLAY")
  resume_button.images = {
    "GESTURE_PLAY",
    "GESTURE_PLAY_SELECTED"
  }
  self:addChild(resume_button)
  local restart_button = ui.Image:new()
  restart_button.name = "restart_button"
  restart_button:setImage("GESTURE_RESTART")
  restart_button.images = {
    "GESTURE_RESTART",
    "GESTURE_RESTART_SELECTED"
  }
  self:addChild(restart_button)
  self.state = "RELEASED"
end
function GestureMenu:layout()
  ui.Frame.layout(self)
  local menu_button = self:getChild("menu_button")
  local resume_button = self:getChild("resume_button")
  local restart_button = self:getChild("restart_button")
  local sw, sh = _G.res.getSpriteBounds(resume_button.image)
  resume_button.x = gamelua.screenWidth * 0.5
  resume_button.y = gamelua.screenHeight * 0.5
  menu_button.x = gamelua.screenWidth * 0.5
  menu_button.y = gamelua.screenHeight * 0.5 - sh
  restart_button.x = gamelua.screenWidth * 0.5
  restart_button.y = gamelua.screenHeight * 0.5 + sh
end
function GestureMenu:update(dt, time)
  local switch_threshold = 30
  if gamelua.g_usingGestureControls then
    if self.state == "RELEASED" and gamelua.multitouchSweep.sweepAxis == "y" and gamelua.multitouchSweep.isSweeping then
      self.state = "VISIBLE"
      self.visible = true
      self.selection = 2
      self.gesture_offset = 0
    elseif self.state == "VISIBLE" and not gamelua.multitouchSweep.isSweeping then
      self.state = "RELEASED"
      self.visible = false
      self:triggerSelection(self.selection)
    elseif self.state == "VISIBLE" and gamelua.multitouchSweep.isSweeping then
      local ydiff = gamelua.multitouchSweep.sweepOffsetY
      if ydiff < 0 and self.gesture_offset > 0 then
        self.gesture_offset = ydiff
      elseif ydiff > 0 and self.gesture_offset < 0 then
        self.gesture_offset = ydiff
      else
        self.gesture_offset = self.gesture_offset + ydiff
      end
      if self.gesture_offset < -switch_threshold and self.selection > 1 then
        self.selection = self.selection - 1
        self.gesture_offset = 0
      elseif switch_threshold < self.gesture_offset and self.selection < 3 then
        self.selection = self.selection + 1
        self.gesture_offset = 0
      end
    end
    self:updateImages()
  else
    self.visible = false
  end
end
function GestureMenu:updateImages()
  local menu_button = self:getChild("menu_button")
  local resume_button = self:getChild("resume_button")
  local restart_button = self:getChild("restart_button")
  local buttons = {
    menu_button,
    resume_button,
    restart_button
  }
  for i = 1, #buttons do
    if self.selection == i then
      buttons[i]:setImage(buttons[i].images[2])
    else
      buttons[i]:setImage(buttons[i].images[1])
    end
  end
end
function GestureMenu:triggerSelection(n)
  if n == 1 then
    gamelua.eventManager:notify({
      id = gamelua.events.EID_LEAVE_GAME,
      reason = "PAUSE_MENU_BUTTON"
    })
    if gamelua.g_currentChallenge == nil then
      gamelua.eventManager:queueEvent({
        id = gamelua.events.EID_CHANGE_SCENE,
        from = "INGAME",
        target = "LEVEL_SELECTION_" .. gamelua.currentThemeNumber
      })
    else
      gamelua.eventManager:queueEvent({
        id = gamelua.events.EID_CHANGE_SCENE,
        target = "CHALLENGE_PAGE"
      })
    end
  elseif n == 3 then
    gamelua.levelRestartedFrom = "gesture menu"
    gamelua.eventManager:queueEvent({
      id = gamelua.events.EID_LEVEL_RESTART_CLICKED
    })
  end
end
filename = "gesture_menu.lua"
