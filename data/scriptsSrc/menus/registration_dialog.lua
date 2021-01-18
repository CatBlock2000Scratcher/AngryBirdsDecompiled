ui = gamelua.ui
print = gamelua.print
TextEntry = ui.Frame:new()
function TextEntry:init()
  ui.Frame.init(self)
  self.enabled = true
  self.max_length = nil
  self.cursor_blink_timer = 0
  self.cursor_x = 0
  self.font_height = 1
  local text = ui.Text:new()
  text.name = "text"
  self:addChild(text)
  self:setFont(gamelua.fontBasic)
end
function TextEntry:setEnabled(enabled)
  self.enabled = enabled
end
function TextEntry:setMaxLength(length)
  self.max_length = length
end
function TextEntry:onKeyEvent(event, key)
  local result, meta, item = ui.Frame.onKeyEvent(self, event, key)
  if self.enabled then
    local characters = {
      "A",
      "B",
      "C",
      "D",
      "E",
      "F",
      "G",
      "H",
      "I",
      "J",
      "K",
      "L",
      "M",
      "N",
      "O",
      "P",
      "Q",
      "R",
      "S",
      "T",
      "U",
      "V",
      "W",
      "X",
      "Y",
      "Z",
      "-"
    }
    if event == "PRESS" then
      for _, v in _G.ipairs(characters) do
        if v == key then
          self:keyPressed(key)
        end
      end
      if key == "BACKSPACE" then
        self.erase_repeat_time = 0.5
        self:eraseCharacter()
      end
      if key == "PASTE" then
        local chars = {}
        for _, v in _G.ipairs(characters) do
          chars[v] = true
        end
        local clipboard_contents = gamelua.getClipboardText():upper()
        for i = 1, #clipboard_contents do
          local char = clipboard_contents:sub(i, i)
          if chars[char] then
            self:keyPressed(char, true)
          end
        end
      end
    elseif event == "RELEASE" then
      self.erase_repeat_time = nil
    end
  end
  return result, meta, item
end
function TextEntry:keyPressed(key, nosound)
  local text = self:getChild("text")
  if self.max_length == nil or _G.string.len(text.text) < self.max_length then
    text.text = text.text .. key
    if not nosound then
      _G.res.playAudio("menu_confirm", 1, false)
    end
    self:contentChanged()
  end
end
function TextEntry:setFont(font)
  local text = self:getChild("text")
  text:setFont(font)
  gamelua.setFont(text.font)
  self.font_height = _G.res.getFontLeading() * self.scaleY
  self:contentChanged()
end
function TextEntry:eraseCharacter()
  local text = self:getChild("text")
  text.text = _G.string.sub(text.text, 1, _G.string.len(text.text) - 1)
  _G.res.playAudio("menu_back", 1, false)
  self:contentChanged()
end
function TextEntry:update(dt, time)
  if self.erase_repeat_time then
    self.erase_repeat_time = self.erase_repeat_time - dt
    if self.erase_repeat_time < 0 then
      self.erase_repeat_time = 0.025
      self:eraseCharacter()
    end
  end
  self.cursor_blink_timer = self.cursor_blink_timer + dt * 3
  if self.cursor_blink_timer >= 1 then
    self.cursor_blink_timer = self.cursor_blink_timer - 2
  end
end
function TextEntry:contentChanged()
  local text = self:getChild("text")
  gamelua.setFont(text.font)
  local text_width = _G.res.getStringWidth(text.text) * self.scaleX
  self.cursor_x = text_width * 0.5
end
function TextEntry:getText()
  local text = self:getChild("text")
  return text.text
end
function TextEntry:draw(x, y)
  ui.Frame.draw(self, x, y)
  if self.enabled then
    gamelua.setRenderState(0, 0, 1, 1)
    gamelua.drawLine2D(x + self.x + self.cursor_x, y + self.y - self.font_height * 0.4, x + self.x + self.cursor_x, y + self.y + self.font_height * 0.4, 4, 0, 0, 0, self.cursor_blink_timer * self.cursor_blink_timer * 255)
  end
end
RegistrationDialog = ui.Image:new()
function RegistrationDialog:new(from, success_event, success_call, o)
  o = o or {}
  o.from = from
  o.success_event = success_event
  o.success_call = success_call
  return ui.Image.new(self, o)
end
function RegistrationDialog:init()
  ui.Image.init(self)
  self:setImage("ACTIVATE_POPUP_WINDOW")
  local red_bird = ui.Image:new()
  red_bird.name = "red_bird"
  red_bird:setImage("ACTIVATE_POPUP_RED_BIRD")
  self:addChild(red_bird)
  local register_button = ui.ImageButton:new()
  register_button.name = "register_button"
  register_button:setImage("ACTIVATE_REGISTER_BUTTON")
  register_button.returnValue = "REGISTER"
  register_button.hover_enabled = false
  register_button.activateOnRelease = true
  self:addChild(register_button)
  local shop_button = ui.ImageButton:new()
  shop_button.name = "shop_button"
  shop_button:setImage("ACTIVATE_ROVIOSHOP_BUTTON")
  shop_button.returnValue = "GOTO_SHOP"
  shop_button.hover_enabled = false
  shop_button.activateOnRelease = true
  self:addChild(shop_button)
  local cancel_button = ui.ImageButton:new()
  cancel_button.name = "cancel_button"
  cancel_button:setImage("ACTIVATE_CANCEL_BUTTON")
  cancel_button.returnValue = "CANCEL"
  cancel_button.hover_enabled = false
  cancel_button.clickSound = "menu_back"
  cancel_button.activateOnRelease = true
  self:addChild(cancel_button)
  local key_entry = TextEntry:new()
  key_entry.name = "key_entry"
  key_entry.scaleX = 0.65
  key_entry.scaleY = 0.65
  key_entry:setFont(gamelua.fontBasic)
  key_entry:setMaxLength(19)
  self:addChild(key_entry)
  self.shade = 0
end
function RegistrationDialog:layout()
  self.x = gamelua.screenWidth * 0.5
  self.y = gamelua.screenHeight * 0.5
  local px, py = _G.res.getSpritePivot("ACTIVATE_ENTER_KEY")
  local sw, sh = _G.res.getSpriteBounds("ACTIVATE_ENTER_KEY")
  local key_entry = self:getChild("key_entry")
  key_entry.x = -px + sw * 0.5
  key_entry.y = -py + sh * 0.5
end
function RegistrationDialog:update(dt, time)
  ui.Image.update(self, dt, time)
  self.shade = self.shade + dt
end
function RegistrationDialog:draw(x, y)
  gamelua.drawRect(0, 0, 0, _G.math.min(self.shade, 0.65), 0, 0, gamelua.screenWidth, gamelua.screenHeight, false)
  ui.Image.draw(self, x, y)
end
function RegistrationDialog:onPointerEvent(eventType, x, y)
  local result, meta, item = ui.Image.onPointerEvent(self, eventType, x, y)
  if not result then
    return "BLOCK", nil, self
  elseif result == "CANCEL" then
    gamelua.eventManager:notify({
      id = gamelua.events.EID_POP_FRAME
    })
  elseif result == "GOTO_SHOP" then
    gamelua.openURL(gamelua.PC_SHOP_URL)
  elseif result == "REGISTER" then
    gamelua.eventManager:notify({
      id = gamelua.events.EID_PUSH_FRAME,
      target = KeyRegistrationPage:new(self.success_event, self.success_call)
    })
    registerKey(self:getChild("key_entry"):getText())
  end
  return result, meta, item
end
function RegistrationDialog:onKeyEvent(eventType, x, y)
  local result, meta, item = ui.Frame.onKeyEvent(self, eventType, x, y)
  return "BLOCK", nil, self
end
KeyRegistrationPage = ui.Frame:new()
function KeyRegistrationPage:new(success_event, success_call, o)
  o = o or {}
  o.success_event = success_event
  o.success_call = success_call
  return ui.Frame.new(self, o)
end
function KeyRegistrationPage:init()
  local spinner = ui.Image:new()
  spinner.name = "spinner"
  spinner:setImage("IN_APP_LOADING")
  self:addChild(spinner)
  self.spinner_angle = 0
end
function KeyRegistrationPage:layout()
  ui.Frame.layout(self)
  local spinner = self:getChild("spinner")
  spinner.x = gamelua.screenWidth * 0.5
  spinner.y = gamelua.screenHeight * 0.5
end
function KeyRegistrationPage:draw(x, y)
  gamelua.drawRect(0, 0, 0, 0.65, 0, 0, gamelua.screenWidth, gamelua.screenHeight, false)
  ui.Frame.draw(self, x, y)
end
function KeyRegistrationPage:update(dt, time)
  ui.Frame.update(self, dt, time)
  local spinner = self:getChild("spinner")
  self.spinner_angle = self.spinner_angle + dt * 10
  spinner.angle = _G.math.floor(self.spinner_angle / 0.5235983) * 0.5235983
  local finished, valid = gamelua.checkRegistrationResult()
  print("finished: " .. _G.tostring(finished) .. " valid: " .. _G.tostring(valid) .. "\n")
  if finished then
    gamelua.eventManager:notify({
      id = gamelua.events.EID_POP_FRAME
    })
    if valid then
      gamelua.eventManager:notify({
        id = gamelua.events.EID_POP_FRAME
      })
      gamelua.eventManager:notify({
        id = gamelua.events.EID_PUSH_FRAME,
        target = ui.Prompt:new({
          title = "Registration succeeded",
          content = "Key successfully registered.",
          close_event = self.success_event,
          close_call = self.success_call,
          box_width = 0.5
        })
      })
      saveRegistration()
    else
      gamelua.eventManager:notify({
        id = gamelua.events.EID_PUSH_FRAME,
        target = ui.Prompt:new({
          title = "Registration failed",
          content = "Make sure you entered the code correctly and you are connected to internet.",
          box_width = 0.5
        })
      })
    end
  end
end
function KeyRegistrationPage:onPointerEvent(eventType, x, y)
  local result, meta, item = ui.Image.onPointerEvent(self, eventType, x, y)
  if not result then
    return "BLOCK", nil, self
  end
  return result, meta, item
end
filename = "registration_dialog.lua"
