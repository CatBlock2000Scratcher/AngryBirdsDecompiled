EpisodeSelection = LevelSelectionRoot:new()
local g_use_scroll_buttons = true
local g_use_new_layout = true
local has_AmazingAlexButton = true
extraButtons = 3
if g_use_new_layout then
  extraButtons = extraButtons + 1
end
if not g_hasWebBrowser then
  extraButtons = 0
end
if isKidsVersion then
  extraButtons = 0
  has_AmazingAlexButton = false
end
episodeNumberOffset = 0
if g_challengesEnabled then
  extraButtons = extraButtons + 1
  episodeNumberOffset = episodeNumberOffset - 1
end
if deviceModel == "blackberry" or customerString == "nook" then
  extraButtons = extraButtons - 1
  has_AmazingAlexButton = false
end
function EpisodeSelection:init()
  local episodeButtons = EpisodeScrollFrame:new()
  episodeButtons.name = "episodeButtons"
  self:addChild(episodeButtons)
  if deviceModel == "android" and isHDVersion and not isPremium then
    local giftButton = ui.ImageButton:new()
    giftButton.name = "giftButton"
    if iOS then
      giftButton:setImage("BUTTON_GIFT_APP")
      giftButton.returnValue = "GOTO_GIFT_PURCHASE"
    end
    if deviceModel == "android" and isHDVersion and not isPremium then
      giftButton:setImage("BTN_ADFREE")
      giftButton.returnValue = "GOTO_LENOVO_ADFREE"
    end
    giftButton.attach = "fixed"
    self:addChild(giftButton)
  end
  self:createDecorationSprites()
  if not g_use_new_layout then
    for i = 1, #g_episodeIds + extraButtons do
      local dot = ui.Image:new()
      dot.name = "dot" .. i
      dot:setImage("LS_DOT_BLACK")
      dot.attach = "fixed"
      self:addChild(dot)
    end
  end
  local backButton = ui.ImageButton:new()
  backButton.name = "backButton"
  backButton:setImage("ARROW_LEFT")
  backButton.returnValue = "GOTO_MAIN_MENU"
  backButton.attach = "fixed"
  backButton.activateOnRelease = true
  backButton.clickSound = "menu_back"
  self:addChild(backButton)
  self.currentSelection = settingsWrapper:getSelectedEpisode() - episodeNumberOffset
  if 1 > self.currentSelection then
    self.currentSelection = 1
    settingsWrapper:setSelectedEpisode(self.currentSelection + episodeNumberOffset)
  elseif self.currentSelection > #g_episodeIds + extraButtons then
    self.currentSelection = #g_episodeIds + extraButtons
    settingsWrapper:setSelectedEpisode(self.currentSelection + episodeNumberOffset)
  end
  episodeButtons.currentSelection = self.currentSelection
  self.backgroundColour = {
    r = 11,
    g = 101,
    b = 76,
    a = 255
  }
  LevelSelectionRoot.init(self)
  self.name = "episodeSelectionRoot"
  if g_use_scroll_buttons then
    local left_button = ui.ImageButton:new()
    left_button.name = "left_button"
    left_button:setImage("BUTTON_ARROW_LEFT")
    left_button.returnValue = "SCROLL_LEFT"
    self:addChild(left_button)
    episodeButtons.left_button = left_button
    local right_button = ui.ImageButton:new()
    right_button.name = "right_button"
    right_button:setImage("BUTTON_ARROW_RIGHT")
    right_button.returnValue = "SCROLL_RIGHT"
    self:addChild(right_button)
    episodeButtons.right_button = right_button
  end
  eventManager:addEventListener(events.EID_SCROLL_TO_EPISODE, self)
end
function EpisodeSelection:onKeyEvent(eventType, key)
  local result, meta, item = ui.Frame.onKeyEvent(self, eventType, key)
  if not result and eventType == "RELEASE" and (key == "BACK" or key == "ESCAPE") then
    eventManager:notify({
      id = events.EID_CURRENT_MENU_THEME_NEEDED
    })
    eventManager:notify({
      id = events.EID_CHANGE_SCENE,
      target = "MAIN_MENU",
      from = "EPISODE_SELECTION"
    })
  end
  return result, meta, item
end
function EpisodeSelection:onPointerEvent(eventType, x, y)
  local result, meta, item = LevelSelectionRoot.onPointerEvent(self, eventType, x, y)
  if x > screenWidth * 0.45 and x < screenWidth * 0.55 and y > screenHeight * 0.85 and y < screenHeight * 0.95 then
    if eventType == "LRELEASE" then
      self.GEClicks = self.GEClicks or 0
      self.GEClicks = self.GEClicks + 1
      local goldenEggLevel = "LevelGE_1"
      if self.GEClicks > 1 and not settingsWrapper:isGoldenEggUnlocked(goldenEggLevel) then
        eventManager:notify({
          id = events.EID_GOLDEN_EGG_FROM_MENU,
          levelName = goldenEggLevel
        })
      end
    end
  else
    self.GEClicks = 0
  end
  if result == "GOTO_MAIN_MENU" then
    eventManager:notify({
      id = events.EID_CURRENT_MENU_THEME_NEEDED
    })
    eventManager:notify({
      id = events.EID_CHANGE_SCENE,
      target = "MAIN_MENU",
      from = "EPISODE_SELECTION"
    })
  elseif result == "GOTO_LEVEL_SELECTION" then
    _G.res.playAudio("menu_confirm", 1, false)
    eventManager:queueEvent({
      id = events.EID_CHANGE_SCENE,
      target = "LEVEL_SELECTION_" .. meta,
      from = "EPISODE_SELECTION"
    })
  elseif result == "LOCKED_LEVEL_SELECTION" then
    _G.res.playAudio("menu_confirm", 1, false)
    local level_event = {
      id = events.EID_CHANGE_SCENE,
      target = "LEVEL_SELECTION_" .. meta,
      from = "EPISODE_SELECTION"
    }
    eventManager:notify({
      id = events.EID_SHOW_REGISTRATION_DIALOG,
      from = "LEVEL_SELECTION",
      success_event = level_event
    })
  elseif result == "GOTO_GIFT_PURCHASE" then
    _G.res.playAudio("menu_confirm", 1, false)
    eventManager:notify({
      id = events.EID_GIFT_PURCHASE_CLICKED
    })
  elseif result == "GOTO_LENOVO_ADFREE" then
    _G.res.playAudio("menu_confirm", 1, false)
    eventManager:notify({
      id = events.EID_LENOVO_ADFREE_CLICKED
    })
  elseif result == "GOTO_NEWSLETTER" then
    _G.res.playAudio("menu_confirm", 1, false)
    eventManager:notify({
      id = events.EID_NEWSLETTER_CLICKED
    })
  elseif result == "GOTO_SEASONS" then
    _G.res.playAudio("menu_confirm", 1, false)
    eventManager:notify({
      id = events.EID_SEASONS_CLICKED
    })
  elseif result == "GOTO_AB_SHOP" then
    _G.res.playAudio("menu_confirm", 1, false)
    eventManager:notify({
      id = events.EID_AB_SHOP_CLICKED
    })
  elseif result == "GOTO_ALEX_LINK" then
    _G.res.playAudio("menu_confirm", 1, false)
    eventManager:notify({
      id = events.EID_ALEX_CLICKED
    })
  elseif result == "GOTO_CHALLENGE" then
    _G.res.playAudio("menu_confirm", 1, false)
    eventManager:notify({
      id = events.EID_CHANGE_SCENE,
      target = "CHALLENGE_PAGE",
      from = "EPISODE_SELECTION"
    })
  elseif result == "SCROLL_LEFT" then
    self:getChild("episodeButtons"):previous()
  elseif result == "SCROLL_RIGHT" then
    self:getChild("episodeButtons"):next()
  end
  return result, meta, item
end
function EpisodeSelection:eventTriggered(event)
  if event.id ~= events.EID_SCROLL_TO_EPISODE or not g_use_new_layout then
  else
    local scroll = self:getChild("episodeButtons")
    local slots = scroll:numVisibleSlots()
    scroll.autoscroll_on_entry = true
  end
end
function EpisodeSelection:createDecorationSprites()
  local left = ui.Image:new()
  left.name = "left"
  left:setImage("LS_MAIN_LEFT")
  left.attach = "fixed"
  self:addChild(left)
  local right = ui.Image:new()
  right.name = "right"
  right:setImage("LS_MAIN_RIGHT")
  right.attach = "fixed"
  self:addChild(right)
end
function EpisodeSelection:update(dt, time)
  LevelSelectionRoot.update(self, dt, time)
  if g_challengesEnabled then
    local unviewedChallengesCount = getUnviewedChallengesCount()
    local challengeButton = self:getChild("challengeButton")
    challengeButton:setUnviewedChallengesCount(unviewedChallengesCount)
    challengeButton.timer = challengeButton.timer + dt * 3
    local newChallengesText = self:getChild("newChallengesText")
    local challengeImage = self:getChild("challengeImage")
    newChallengesText.scaleY = 0.7 + _G.math.sin(challengeButton.timer) * 0.15
    newChallengesText.scaleX = 0.7 + _G.math.sin(challengeButton.timer) * 0.15
    challengeImage.scaleX = 1 + _G.math.sin(challengeButton.timer) * 0.15
    challengeImage.scaleY = 1 + _G.math.sin(challengeButton.timer) * 0.15
  end
  self:updateSelection()
end
function EpisodeSelection:updateSelection(initial_selection)
  local new_index = self.currentSelection
  if not initial_selection then
    new_index = self:getChild("episodeButtons"):getCurrentAnchor()
  end
  if self.currentSelection ~= new_index or initial_selection then
    settingsWrapper:setSelectedEpisode(new_index + episodeNumberOffset)
    if not g_use_new_layout then
      local new_dot = self:getChild("dot" .. new_index)
      if new_dot ~= nil then
        self:getChild("dot" .. self.currentSelection):setImage("LS_DOT_BLACK")
        new_dot:setImage("LS_DOT_WHITE")
        self.currentSelection = new_index
        self:getChild("episodeButtons"):setEnabledSlot(new_index)
      end
      self:getChild("episodeButtons").currentSelection = new_index
    else
      self.currentSelection = new_index
      self:getChild("episodeButtons").currentSelection = new_index
      self:getChild("left_button"):setVisible(new_index > 1)
      visibleSlots = self:getChild("episodeButtons"):numVisibleSlots()
      self:getChild("right_button"):setVisible(new_index <= #g_episodeIds + extraButtons - visibleSlots and visibleSlots < #g_episodeIds + extraButtons)
    end
  end
end
function EpisodeSelection:onEntry()
  self:updateSelection(true)
  self.GEClicks = 0
  LevelSelectionRoot.onEntry(self)
end
function EpisodeSelection:draw(x, y)
  drawLevelSelectionBackground()
  ui.Frame.draw(self, x, y)
end
function EpisodeSelection:layout()
  setFont(fontBasic)
  local left = self:getChild("left")
  left.x = 0
  left.y = screenHeight
  local right = self:getChild("right")
  right.x = screenWidth
  right.y = screenHeight
  if not g_use_new_layout then
    local num_dots = #g_episodeIds + extraButtons
    local dot_y = 10
    local dot_spacing = 15
    local first_dot_x = screenWidth * 0.5 - (num_dots - 1) * 0.5 * dot_spacing
    for i = 1, num_dots do
      local dot = self:getChild("dot" .. i)
      dot.x = first_dot_x + dot_spacing * (i - 1)
      dot.y = screenHeight - dot_y - g_layoutMargin.y
    end
  end
  local back_button = self:getChild("backButton")
  back_button:refresh()
  back_button.x = back_button.w * 0.5 + g_layoutMargin.x
  back_button.y = screenHeight - back_button.h * 0.5 - g_layoutMargin.y
  if deviceModel == "roku" then
    back_button.y = back_button.h * 0.5 + g_layoutMargin.y
  end
  local giftButton = self:getChild("giftButton")
  if giftButton ~= nil then
    local giftButtonWidth, giftButtonHeight = _G.res.getSpriteBounds(giftButton.image)
    giftButton.x = _G.math.floor(screenWidth - giftButtonWidth * 0.5 - g_layoutMargin.x)
    giftButton.y = _G.math.floor(giftButtonHeight * 0.5 + g_layoutMargin.y)
  end
  if g_use_scroll_buttons then
    local left_button = self:getChild("left_button")
    local right_button = self:getChild("right_button")
    local sw, sh = _G.res.getSpriteBounds(left_button.image)
    left_button.x = sw * 0.5 + g_layoutMargin.x
    left_button.y = screenHeight * 0.5
    right_button.x = screenWidth - sw * 0.5 - g_layoutMargin.x
    right_button.y = screenHeight * 0.5
  end
  self:updateSelection(self.currentSelection)
  LevelSelectionRoot.layout(self)
end
EpisodeScrollFrame = ui.ScrollFrame:new()
function EpisodeScrollFrame:init()
  local episodeButtons = {}
  self.slots = {}
  self.visible_slots = 1
  self.visible_children = {}
  local slotIndex = 1
  self.eventTimer = subsystems.Timer.new(g_time or 0)
  if g_challengesEnabled then
    do
      local challengeButton = ui.ImageButton:new()
      challengeButton.timer = 0
      challengeButton:setImage("CHALLENGES_EPISODE_SELECTION")
      challengeButton.name = "challengeButton"
      challengeButton.returnValue = "GOTO_CHALLENGE"
      challengeButton.activateOnRelease = true
      function challengeButton.onPointerEvent(o, eventType, x, y)
        if eventType == "LRELEASE" then
          x = x + challengeButton.w * 0.5
          y = y + challengeButton.h * 0.5
          if x >= challengeButton.x and x <= challengeButton.x + challengeButton.w and y >= challengeButton.y and y <= challengeButton.y + challengeButton.h then
            _G.res.playAudio("menu_confirm", 1, false)
            return challengeButton.returnValue, challengeButton.meta
          end
        end
      end
      function challengeButton.setUnviewedChallengesCount(o, count)
        if count == nil or count == 0 then
          challengeButton:getChild("newChallengesText").visible = false
          challengeButton:getChild("challengeImage").visible = false
          return
        end
        challengeButton.newChallengesCount = count
        local text = challengeButton:getChild("newChallengesText")
        challengeButton:getChild("challengeImage").visible = true
        text.visible = true
        challengeButton:getChild("newChallengesText").text = _G.tostring(count)
        text:clip()
      end
      local challengeImage = ui.ImageButton:new({
        name = "challengeImage"
      })
      challengeImage:setImage("H_NOTIFICATION_ICON_BG")
      challengeImage.x = 0
      challengeImage.y = challengeButton.h * 0.45
      challengeImage.floorCoordinates = false
      challengeButton:addChild(challengeImage)
      local newChallengesText = ui.Text:new({
        name = "newChallengesText",
        text = "",
        font = getFontBasic
      })
      newChallengesText:clip()
      newChallengesText.x = challengeImage.x
      newChallengesText.y = challengeImage.y
      newChallengesText.scaleX = 0.5
      newChallengesText.scaleY = 0.5
      newChallengesText.floorCoordinates = false
      challengeButton:addChild(newChallengesText)
      self:addChild(challengeButton)
      self.slots[slotIndex] = {
        "challengeButton"
      }
      slotIndex = slotIndex + 1
    end
  end
  for i = 1, #g_episodeIds do
    self.slots[slotIndex] = {
      "episode" .. g_episodeIds[i]
    }
    slotIndex = slotIndex + 1
  end
  for k, v in _G.pairs(g_episodes) do
    episodeButtons[k] = self:createEpisodeButton(k, v)
  end
  if g_hasWebBrowser and not isKidsVersion then
    if has_AmazingAlexButton then
      local alexButton = ui.ImageButton:new()
      alexButton.name = "alexButton"
      alexButton:setImage("BTN_ALEX")
      alexButton.returnValue = "GOTO_ALEX_LINK"
      alexButton.activateOnRelease = true
      self:addChild(alexButton)
      self.slots[slotIndex] = {"alexButton"}
      slotIndex = slotIndex + 1
    end
    local upsellButton = ui.ImageButton:new()
    upsellButton.name = "upsellButton"
    if not g_use_new_layout then
      upsellButton:setImage("UPSELL_SHOP")
    else
      upsellButton:setImage("BTN_MERCHANDISE")
    end
    upsellButton.returnValue = "GOTO_AB_SHOP"
    upsellButton.activateOnRelease = true
    self:addChild(upsellButton)
    self.slots[slotIndex] = {
      "upsellButton"
    }
    slotIndex = slotIndex + 1
    local newsletterButton = ui.ImageButton:new()
    newsletterButton.name = "newsletterButton"
    if not g_use_new_layout then
      newsletterButton:setImage("SIGNUP_NEWSLETTER")
    else
      newsletterButton:setImage("BTN_NEWSLETTER")
    end
    newsletterButton.returnValue = "GOTO_NEWSLETTER"
    newsletterButton.activateOnRelease = true
    self.slots[slotIndex] = {
      "newsletterButton"
    }
    if g_use_new_layout then
      slotIndex = slotIndex + 1
      self:addChild(newsletterButton)
    end
    if isSeasonsAvailable then
      local seasonsButton = ui.ImageButton:new()
      seasonsButton.name = "seasonsButton"
      if not g_use_new_layout then
        seasonsButton:setImage("UPSELL_HALLOWEEN")
      else
        seasonsButton:setImage("BTN_GET_SEASONS")
      end
      seasonsButton.returnValue = "GOTO_SEASONS"
      seasonsButton.activateOnRelease = true
      if not g_use_new_layout then
        newsletterButton:addChild(seasonsButton)
        _G.table.insert(self.slots[slotIndex], "seasonsButton")
      else
        self.slots[slotIndex] = {
          "seasonsButton"
        }
        slotIndex = slotIndex + 1
        self:addChild(seasonsButton)
      end
    end
    if not g_use_new_layout then
      slotIndex = slotIndex + 1
      self:addChild(newsletterButton)
    end
  end
  local w, h = self:getEpisodeButtonDimensions()
  for _, v in _G.pairs(episodeButtons) do
    v.width = w
    v.height = h
    v.reference_button = self.reference_button
    self:addChild(v)
  end
  ui.ScrollFrame.init(self)
end
function EpisodeScrollFrame:createEpisodeButton(id, episode)
  local button
  if id == "G" then
    button = GoldenEggButton:new()
  else
    button = EpisodeButton:new()
  end
  button.name = "episode" .. id
  button:setEpisode(id, episode)
  button.returnValue = "GOTO_LEVEL_SELECTION"
  button.disabledReturnValue = "LOCKED_LEVEL_SELECTION"
  if id == 1 then
    self.reference_button = button
  end
  return button
end
if g_isAccelerometerControl then
  function EpisodeScrollFrame:wheel(direction)
    if direction > 0 then
      self.left_button:onMouseEnter()
      self.eventTimer:once(nil, function()
        self.left_button:onMouseLeave()
      end, 0.15)
    elseif direction < 0 then
      self.right_button:onMouseEnter()
      self.eventTimer:once(nil, function()
        self.right_button:onMouseLeave()
      end, 0.15)
    end
    return ui.ScrollFrame.wheel(self, direction)
  end
end
function EpisodeScrollFrame:getEpisodeButtonDimensions()
  local biggestEpisodeImageW = 0
  local biggestEpisodeImageH = 0
  local biggestTextW = 0
  setFont(fontBasic)
  for _, v in _G.pairs(g_episodes) do
    local w, h = _G.res.getSpriteBounds(v.icon)
    if biggestEpisodeImageW < w then
      biggestEpisodeImageW = w
    end
    if biggestEpisodeImageH < h then
      biggestEpisodeImageH = h
    end
    w = _G.res.getStringWidth(v.name)
    if biggestTextW < w then
      biggestTextW = w
    end
  end
  return _G.math.max(biggestTextW * 0.8, biggestEpisodeImageW * 0.95), biggestEpisodeImageH * 1.7
end
function EpisodeScrollFrame:setEnabledSlot(index)
  self.enabled_slot = index
end
function EpisodeScrollFrame:onEntry()
  for k, _ in _G.pairs(g_episodes) do
    self:getChild("episode" .. k):setOpen(isEpisodeOpen(k))
  end
  ui.ScrollFrame.onEntry(self)
  self:refreshVisibleChildren()
end
if not g_use_new_layout then
  function EpisodeScrollFrame:layout()
    local anchors = {}
    for i = 1, #g_episodeIds + extraButtons do
      _G.table.insert(anchors, i, {
        x = (i - 1) * -screenWidth * 0.5,
        y = 0
      })
    end
    self:setAnchors(anchors)
    self:setCurrentAnchor(self.currentSelection)
    local buttonIndex = 1
    if g_challengesEnabled then
      local challengeButton = self:getChild("challengeButton")
      local bg = challengeButton:getChild("")
      challengeButton.x = buttonIndex * screenWidth * 0.5
      challengeButton.y = screenHeight * 0.5
      buttonIndex = buttonIndex + 1
    end
    local w, h = self:getEpisodeButtonDimensions()
    for i = 1, #g_episodeIds do
      local episodeBox = self:getChild("episode" .. g_episodeIds[i])
      episodeBox.x = buttonIndex * screenWidth * 0.5
      episodeBox.y = screenHeight * 0.5
      episodeBox.width = w
      episodeBox.height = h
      buttonIndex = buttonIndex + 1
    end
    if not disableExternalLinks then
      local alexButton = self:getChild("alexButton")
      alexButton.x = buttonIndex * screenWidth * 0.5
      alexButton.y = screenHeight * 0.5
      buttonIndex = buttonIndex + 1
      local upsellButton = self:getChild("upsellButton")
      upsellButton.x = buttonIndex * screenWidth * 0.5
      upsellButton.y = screenHeight * 0.5
      buttonIndex = buttonIndex + 1
      local newsletterButton = self:getChild("newsletterButton")
      newsletterButton.x = buttonIndex * screenWidth * 0.5
      buttonIndex = buttonIndex + 1
      if isSeasonsAvailable then
        local seasonsButton = newsletterButton:getChild("seasonsButton")
        local _, seasonsButtonHeight = _G.res.getSpriteBounds(seasonsButton.image)
        seasonsButton.y = -seasonsButtonHeight
        newsletterButton.y = _G.math.floor(screenHeight * 0.5 + seasonsButtonHeight * 0.5)
      else
        newsletterButton.y = screenHeight * 0.5
      end
    end
    ui.ScrollFrame.layout(self)
    self:refreshVisibleChildren()
  end
else
  function EpisodeScrollFrame:layout()
    local border = 0
    if g_use_scroll_buttons then
      border, _ = _G.res.getSpriteBounds("BUTTON_ARROW_LEFT") + g_layoutMargin.x, nil
    end
    local slots = self:numVisibleSlots()
    local slot_width = (screenWidth - border * 2) / slots
    self.clip = {
      x = border,
      y = 0,
      w = screenWidth - border * 2,
      h = screenHeight
    }
    local anchors = {}
    for i = 1, #g_episodeIds + extraButtons - slots + 1 do
      _G.table.insert(anchors, i, {
        x = (i - 1) * slot_width,
        y = 0
      })
    end
    self:setAnchors(anchors)
    self:setCurrentAnchor(_G.math.min(self.currentSelection, #self.anchors))
    ui.ScrollFrame.layout(self)
    local buttonIndex = 0.5
    if g_challengesEnabled then
      local challengeButton = self:getChild("challengeButton")
      local bg = challengeButton:getChild("")
      challengeButton.x = _G.math.floor(buttonIndex * slot_width + border)
      challengeButton.y = screenHeight * 0.5
      buttonIndex = buttonIndex + 1
    end
    for i = 1, #g_episodeIds do
      local episodeBox = self:getChild("episode" .. g_episodeIds[i])
      episodeBox.x = _G.math.floor(buttonIndex * slot_width + border)
      episodeBox.y = screenHeight * 0.5
      buttonIndex = buttonIndex + 1
    end
    if g_hasWebBrowser and not isKidsVersion then
      if has_AmazingAlexButton then
        local alexButton = self:getChild("alexButton")
        alexButton.x = _G.math.floor(buttonIndex * slot_width + border)
        alexButton.y = screenHeight * 0.5
        buttonIndex = buttonIndex + 1
      end
      local upsellButton = self:getChild("upsellButton")
      upsellButton.x = _G.math.floor(buttonIndex * slot_width + border)
      upsellButton.y = screenHeight * 0.5
      buttonIndex = buttonIndex + 1
      local newsletterButton = self:getChild("newsletterButton")
      newsletterButton.x = _G.math.floor(buttonIndex * slot_width + border)
      newsletterButton.y = screenHeight * 0.5
      buttonIndex = buttonIndex + 1
      if isSeasonsAvailable then
        local seasonsButton = self:getChild("seasonsButton")
        seasonsButton.x = _G.math.floor(buttonIndex * slot_width + border)
        seasonsButton.y = screenHeight * 0.5
        buttonIndex = buttonIndex + 1
      end
    end
    self:refreshVisibleChildren()
  end
end
function EpisodeScrollFrame:numVisibleSlots()
  local border = 0
  if g_use_scroll_buttons then
    border = _G.res.getSpriteBounds("BUTTON_ARROW_LEFT")
  end
  local bw, _ = _G.res.getSpriteBounds(g_episodes[1].button)
  if screenWidth > 480 and deviceModel ~= "iphone" then
    bw = bw * 1.1666666
  end
  local slots = _G.math.max(1, _G.math.floor((screenWidth - border * 2) / bw))
  slots = _G.math.min(#g_episodeIds + extraButtons, slots)
  return slots
end
function EpisodeScrollFrame:refreshVisibleChildren()
  local i = 1
  local BackgroundBox_draw = BackgroundBox.draw
  local Image_draw = ui.Image.draw
  local ImageButton_draw = ui.ImageButton.draw
  local Text_draw = ui.Text.draw
  local EpButton_draw = EpisodeButtonBase.draw
  local x = self:getCurrentX()
  local y = self:getCurrentY()
  for k, v in _G.ipairs(self.children) do
    if v.visible == true and v.x + x >= -screenWidth * 0.5 and v.x + x <= screenWidth * 1.5 then
      for k2, v2 in _G.ipairs(v.children) do
        if v2.visible then
          if v2.draw == BackgroundBox_draw then
            local vc = self.visible_children[i] or {}
            vc.x, vc.y, vc.item, vc.parent = v.x + x, v.y + y, v2, v
            self.visible_children[i] = vc
            i = i + 1
          end
          for k3, v3 in _G.ipairs(v2.children) do
            if v3.visible and v3.draw == BackgroundBox_draw then
              local vc = self.visible_children[i] or {}
              vc.x, vc.y, vc.item, vc.parent = v.x + v2.x + x, v.y + v2.y + y, v3, v2
              self.visible_children[i] = vc
              i = i + 1
            end
          end
        end
      end
    end
  end
  for k, v in _G.ipairs(self.children) do
    if v.visible == true and v.x + x >= -screenWidth * 0.5 and v.x + x <= screenWidth * 1.5 then
      if v.draw == Image_draw or v.draw == ImageButton_draw or g_use_new_layout and v.draw == EpButton_draw then
        local vc = self.visible_children[i] or {}
        vc.x, vc.y, vc.item, vc.parent = x, y, v, nil
        self.visible_children[i] = vc
        i = i + 1
      end
      for k2, v2 in _G.ipairs(v.children) do
        if v2.visible then
          if v2.draw == Image_draw or v2.draw == ImageButton_draw then
            local vc = self.visible_children[i] or {}
            vc.x, vc.y, vc.item, vc.parent = v.x + x, v.y + y, v2, v
            self.visible_children[i] = vc
            i = i + 1
          end
          for k3, v3 in _G.ipairs(v2.children) do
            if v3.visible and (v3.draw == Image_draw or v3.draw == ImageButton_draw) then
              local vc = self.visible_children[i] or {}
              vc.x, vc.y, vc.item, vc.parent = v.x + v2.x + x, v.y + v2.y + y, v3, v2
              self.visible_children[i] = vc
              i = i + 1
            end
          end
        end
      end
    end
  end
  for k, v in _G.ipairs(self.children) do
    if v.visible == true and v.x + x >= -screenWidth * 0.5 and v.x + x <= screenWidth * 1.5 then
      for k2, v2 in _G.ipairs(v.children) do
        if v2.visible then
          if v2.draw == Text_draw then
            local vc = self.visible_children[i] or {}
            vc.x, vc.y, vc.item, vc.parent = v.x + x, v.y + y, v2, v
            self.visible_children[i] = vc
            i = i + 1
          end
          for k3, v3 in _G.ipairs(v2.children) do
            if v3.visible and v3.draw == Text_draw then
              local vc = self.visible_children[i] or {}
              vc.x, vc.y, vc.item, vc.parent = v.x + v2.x + x, v.y + v2.y + y, v3, v2
              self.visible_children[i] = vc
              i = i + 1
            end
          end
        end
      end
    end
  end
  self.visible_children[i] = nil
end
function EpisodeScrollFrame:update(dt, time)
  self.eventTimer:update(dt, time)
  local sx = self.scrollX
  if g_use_new_layout then
    ui.ScrollFrame.update(self, dt, time)
  else
    self:doUpdate(dt, time)
  end
  if sx ~= self.scrollX then
    self:refreshVisibleChildren()
  end
  if self.autoscroll_on_entry then
    self:next()
    self.autoscroll_on_entry = nil
  end
end
if not g_use_new_layout then
  function EpisodeScrollFrame:onPointerEvent(eventType, x, y)
    local result, meta, element = ui.ScrollFrame.onPointerEvent(self, eventType, x, y)
    if result then
      for i = 1, #self.slots do
        for j = 1, #self.slots[i] do
          if element == self:getChild(self.slots[i][j]) then
            if self.enabled_slot == i then
              return result, meta, element
            else
              self:scrollToAnchor(i)
            end
          end
        end
      end
    end
    return result, meta, item
  end
end
local drawVisibleChild
if g_enableHoverScaling then
  function drawVisibleChild(item, x, y, parent)
    if parent == nil then
      item:drawSelf(x, y)
    else
      item:draw(x, y, 1, 1, 0, parent:hoverScale())
    end
  end
else
  function drawVisibleChild(item, x, y)
    if item.drawFast ~= nil then
      item:drawFast(x, y)
    elseif item.drawSelf ~= nil then
      item:drawSelf(x, y, 1, 1, 0)
    else
      item:draw(x, y, 1, 1, 0)
    end
  end
end
if deviceModel == "roku" then
  function EpisodeScrollFrame:draw(x, y, scaleX, scaleY, angle)
    x = x or 0
    y = y or 0
    x = x + self.scrollX
    y = y + self.scrollY
    scaleX = scaleX or 1
    scaleY = scaleY or 1
    angle = angle or 0
    x = _G.math.floor(x)
    y = _G.math.floor(y)
    if self.clip then
      _G.res.setClipRect(self.clip.x, self.clip.y, self.clip.w, self.clip.h)
    end
    for k, v in _G.ipairs(self.visible_children) do
      drawVisibleChild(v.item, v.x, v.y, v.parent)
    end
    if self.clip then
      _G.res.setClipRect(0, 0, screenWidth, screenHeight)
    end
  end
end
BackgroundBox = ui.Frame:new()
function BackgroundBox:init()
  self.x = 0
  self.y = 0
  self.visible = true
  self.locked = false
  ui.Frame.init(self)
end
function BackgroundBox:drawSelf(x, y, scaleX, scaleY)
  if self.visible == false then
    return
  end
  scaleX = scaleX or 1
  scaleY = scaleY or 1
  setRenderState(0, 0, 1, 1)
  drawBoxNative(self.components, _G.math.floor(self.x + x), _G.math.floor(self.y + y), _G.math.floor(self.width * scaleX), _G.math.floor(self.height * scaleY), self.hanchor, self.vanchor, nil)
end
function BackgroundBox:draw(x, y, scaleX, scaleY)
  self:drawSelf(x, y, scaleX, scaleY)
  ui.Frame.draw(self, x, y, scaleX, scaleY)
end
if not g_use_new_layout then
  EpisodeButtonBase = ui.Frame:new()
  function EpisodeButtonBase:init()
    self.x = 0
    self.y = 0
    self.enabled = true
    local background = BackgroundBox:new()
    background.name = "background"
    background.hanchor = "HCENTER"
    background.vanchor = "VCENTER"
    self:addChild(background)
    local yellowLine = BackgroundBox:new()
    yellowLine.name = "yellowLine"
    yellowLine.hanchor = "HCENTER"
    yellowLine.vanchor = "TOP"
    yellowLine.components = {
      topMiddle = "EPISODE_YELLOW_LINE"
    }
    background:addChild(yellowLine)
    local episodeIcon = ui.Image:new()
    episodeIcon.name = "episodeIcon"
    background:addChild(episodeIcon)
    local episodeName = ui.Text:new({font = getFontBasic})
    episodeName.name = "episodeName"
    episodeName.hanchor = "HCENTER"
    episodeName.vanchor = "BASELINE"
    background:addChild(episodeName)
    ui.Frame.init(self)
  end
  function EpisodeButtonBase:setOpen(open)
    self.locked = not open
  end
  function EpisodeButtonBase:layout()
    setFont(fontBasic)
    local fontHeight = _G.res.getFontHeight()
    local background = self:getChild("background")
    background.width = self.width
    background.height = self.height
    local episodeName = self:getChild("episodeName")
    episodeName.y = _G.math.floor(self.height * -0.44)
    local yellowLine = background:getChild("yellowLine")
    yellowLine.y = background:getChild("episodeName").y + fontHeight * 0.4
    yellowLine.width = self.width
    yellowLine.height = 1
    ui.Frame.layout(self)
  end
  function EpisodeButtonBase:setEpisode(id, episode)
    self.episode = id
    local background = self:getChild("background")
    background.components = {
      topLeft = "EPISODE" .. id .. "_TOP_LEFT",
      topMiddle = "EPISODE" .. id .. "_TOP_MIDDLE",
      topRight = "EPISODE" .. id .. "_TOP_RIGHT",
      left = "EPISODE" .. id .. "_LEFT",
      center = "EPISODE" .. id .. "_CENTER",
      right = "EPISODE" .. id .. "_RIGHT",
      bottomLeft = "EPISODE" .. id .. "_BOTTOM_LEFT",
      bottomMiddle = "EPISODE" .. id .. "_BOTTOM_MIDDLE",
      bottomRight = "EPISODE" .. id .. "_BOTTOM_RIGHT"
    }
    local episodeIcon = background:getChild("episodeIcon")
    episodeIcon:setImage(episode.icon)
    local episodeName = background:getChild("episodeName")
    episodeName.text = episode.name
  end
  function EpisodeButtonBase:draw(x, y)
    ui.Frame.draw(self, _G.math.floor(x), _G.math.floor(y))
  end
  function EpisodeButtonBase:onPointerEvent(eventType, x, y)
    local result, meta, element = ui.Frame.onPointerEvent(self, eventType, x, y)
    if not result and eventType == "LRELEASE" then
      local background = self:getChild("background")
      if x >= self.x - background.width * 0.5 and x <= self.x + background.width * 0.5 and y >= self.y - background.height * 0.5 and y <= self.y + background.height * 0.5 then
        meta = self.episode
        if self.enabled and not self.locked then
          result = self.returnValue
        elseif self.enabled and self.locked then
          result = self.disabledReturnValue
        end
        if self.enabled then
          return result, meta, self
        end
      end
    end
    return result, meta, element
  end
  EpisodeButton = EpisodeButtonBase:new()
  function EpisodeButton:init()
    self.scoreSprite = _G.res.getString("TEXTS_BASIC", "TEXT_SCORE_SPRITE")
    local featherBox = BackgroundBox:new()
    featherBox.name = "featherBox"
    featherBox.hanchor = "HCENTER"
    featherBox.vanchor = "TOP"
    self:addChild(featherBox)
    EpisodeButtonBase.init(self)
    local feather = ui.Image:new()
    feather.name = "feather"
    feather:setImage("EPISODE_SELECTION_FEATHER")
    self:addChild(feather)
    local featherScore = ui.Text:new()
    featherScore.name = "featherScore"
    featherScore.text = ""
    featherScore.font = "FONT_LS_SMALL"
    self:addChild(featherScore)
    local scoreComponents = {
      topLeft = "SCORE_TOP_LEFT",
      left = "SCORE_LEFT",
      bottomLeft = "SCORE_BOTTOM_LEFT",
      bottomMiddle = "SCORE_BOTTOM_MIDDLE",
      bottomRight = "SCORE_BOTTOM_RIGHT",
      right = "SCORE_RIGHT",
      topRight = "SCORE_TOP_RIGHT",
      topMiddle = "SCORE_TOP_MIDDLE",
      center = "SCORE_CENTER"
    }
    local background = self:getChild("background")
    local scoreBoxLeft = BackgroundBox:new()
    scoreBoxLeft.name = "scoreBoxLeft"
    scoreBoxLeft.hanchor = "LEFT"
    scoreBoxLeft.vanchor = "BOTTOM"
    scoreBoxLeft.components = scoreComponents
    background:addChild(scoreBoxLeft)
    local scoreText = ui.Image:new()
    scoreText.name = "scoreText"
    scoreText:setImage(self.scoreSprite)
    scoreText.hanchor = "HCENTER"
    scoreText.vanchor = "VCENTER"
    background:addChild(scoreText)
    local score = ui.Text:new()
    score.name = "score"
    score.text = "0"
    score.font = "FONT_LS_SMALL"
    score.hanchor = "HCENTER"
    score.vanchor = "BOTTOM"
    background:addChild(score)
    local scoreBoxRight = BackgroundBox:new()
    scoreBoxRight.name = "scoreBoxRight"
    scoreBoxRight.hanchor = "RIGHT"
    scoreBoxRight.vanchor = "BOTTOM"
    scoreBoxRight.components = scoreComponents
    background:addChild(scoreBoxRight)
    local star = ui.Image:new()
    star.name = "star"
    star:setImage("LS_STAR_GOLD")
    background:addChild(star)
    local starCounter = ui.Text:new()
    starCounter.name = "starCounter"
    starCounter.text = ""
    starCounter.font = "FONT_LS_SMALL"
    starCounter.hanchor = "HCENTER"
    starCounter.vanchor = "BOTTOM"
    background:addChild(starCounter)
    if gameCenterSupported or not releaseBuild and iOS then
      local meterBG = ui.Image:new()
      meterBG.name = "meterBG"
      meterBG:setImage("GLOBAL_METER_BG")
      meterBG:setVisible(false)
      self:addChild(meterBG)
      local meterIndicator = ui.Image:new()
      meterIndicator.name = "meterIndicator"
      meterIndicator:setImage("GLOBAL_METER_INDICATOR")
      meterBG:setVisible(false)
      meterBG:addChild(meterIndicator)
    end
    local lock = ui.Image:new()
    lock.name = "lock"
    lock:setImage("LS_LEVEL_PACK_LOCK")
    lock:setVisible(false)
    self:addChild(lock)
  end
  function EpisodeButton:setEpisode(id, episode)
    local featherBox = self:getChild("featherBox")
    featherBox.components = {
      left = "EPISODE" .. id .. "_LEFT",
      center = "EPISODE" .. id .. "_CENTER",
      right = "EPISODE" .. id .. "_RIGHT",
      bottomLeft = "EPISODE" .. id .. "_BOTTOM_LEFT",
      bottomMiddle = "EPISODE" .. id .. "_BOTTOM_MIDDLE",
      bottomRight = "EPISODE" .. id .. "_BOTTOM_RIGHT"
    }
    EpisodeButtonBase.setEpisode(self, id, episode)
  end
  function EpisodeButton:onEntry()
    local stars, total_stars = calculateEpisodeStars(self.episode)
    local starCounter = self:getChild("starCounter")
    starCounter.text = stars .. "/" .. total_stars
    local total_score = calculateEpisodeScore(self.episode)
    local score = self:getChild("score")
    score.text = _G.string.format("%d", total_score)
    local feathers, total_feathers = calculateFeatherScore(self.episode)
    local feather_score = self:getChild("featherScore")
    feather_score.text = feathers .. "/" .. total_feathers
    if gameCenterSupported or not releaseBuild and iOS then
      local meterBG = self:getChild("meterBG")
      meterBG:setVisible(gameCenterEnabled)
      local meterIndicator = meterBG:getChild("meterIndicator")
      meterIndicator:setVisible(gameCenterEnabled)
      self.gameCenterVisible = gameCenterEnabled
      self:setGameCenterIndicatorPositions()
    end
    EpisodeButtonBase.onEntry(self)
  end
  function EpisodeButton:layout()
    setFont(fontBasic)
    local fontHeight = _G.res.getFontHeight()
    setFont("FONT_LS_SMALL")
    local fontHeightSmall = _G.res.getFontHeight()
    local featherBox = self:getChild("featherBox")
    featherBox.y = self.height * 0.5 + fontHeightSmall * 0.8075
    featherBox.width = self.width * 0.35
    featherBox.height = fontHeightSmall * 0.85
    local background = self:getChild("background")
    local _, topEdgeY = _G.res.getSpriteBounds(background.components.topMiddle)
    local scoreWidth, scoreHeight = _G.res.getSpriteBounds(self.scoreSprite)
    local starWidth, starHeight = _G.res.getSpriteBounds("LS_STAR_GOLD")
    local feather = self:getChild("feather")
    local featherScore = self:getChild("featherScore")
    local featherWidth, _ = _G.res.getSpriteBounds(feather.image)
    local featherPivotX, _ = _G.res.getSpritePivot(feather.image)
    local featherScoreWidth = _G.res.getStringWidth(featherScore.text)
    setFont(featherScore.font)
    feather.x = featherBox.width * -0.5 + (featherBox.width - featherWidth - featherScoreWidth) * 0.5 + featherPivotX
    feather.y = _G.math.floor(featherBox.y + (featherBox.height + topEdgeY) * 0.475)
    featherScore.x = feather.x + featherScoreWidth * 0.5
    featherScore.y = feather.y
    if not showEagleScoreElements() then
      featherBox.visible = false
      feather.visible = false
      featherScore.visible = false
    else
      featherBox.visible = true
      feather.visible = true
      featherScore.visible = true
    end
    local scoreBoxWidth = _G.math.max(self.width / 2.25, scoreWidth)
    local scoreBoxLeft = background:getChild("scoreBoxLeft")
    scoreBoxLeft.x = -self.width * 0.5
    scoreBoxLeft.y = self.height * 0.5 + topEdgeY / 6
    scoreBoxLeft.width = scoreBoxWidth
    scoreBoxLeft.height = fontHeightSmall + starHeight
    local scoreText = background:getChild("scoreText")
    self.scoreSprite = _G.res.getString("TEXTS_BASIC", "TEXT_SCORE_SPRITE")
    scoreText:setImage(self.scoreSprite)
    scoreText.x = _G.math.floor(scoreBoxLeft.x + scoreBoxLeft.width * 0.5)
    scoreText.y = _G.math.floor(scoreBoxLeft.y - 0.8 * scoreBoxLeft.height)
    local score = background:getChild("score")
    score.x = _G.math.floor(self.width * -0.5 + scoreBoxLeft.width * 0.5)
    score.y = _G.math.floor(scoreBoxLeft.y)
    local scoreBoxRight = background:getChild("scoreBoxRight")
    scoreBoxRight.x = self.width * 0.5
    scoreBoxRight.y = self.height * 0.5 + topEdgeY / 6
    scoreBoxRight.width = _G.math.min(self.width / 2.25, 2 * (self.width / 2.25) - scoreBoxWidth)
    scoreBoxRight.height = fontHeightSmall + starHeight
    local star = background:getChild("star")
    star.x = _G.math.floor(scoreBoxRight.x - scoreBoxRight.width * 0.5)
    star.y = _G.math.floor(scoreBoxRight.y - 0.8 * scoreBoxRight.height)
    local starCounter = background:getChild("starCounter")
    starCounter.x = _G.math.floor(self.width * 0.5 - scoreBoxRight.width * 0.5)
    starCounter.y = _G.math.floor(scoreBoxRight.y)
    if gameCenterSupported or not releaseBuild and iOS then
      local episodeBorderWidth, _ = _G.res.getSpriteBounds(background.components.left)
      local meterBG = self:getChild("meterBG")
      local meterWidth, meterHeight = _G.res.getSpriteBounds(meterBG.image)
      local meterPivotX, meterPivotY = _G.res.getSpritePivot(meterBG.image)
      meterBG.x = _G.math.floor(-self.width * 0.5 - episodeBorderWidth * 0.6)
      meterBG.y = _G.math.floor(meterPivotY - meterHeight * 0.5)
      local meterIndicator = meterBG:getChild("meterIndicator")
    end
    local lock = self:getChild("lock")
    lock:setVisible(self.locked)
    EpisodeButtonBase.layout(self)
  end
  function EpisodeButton:setGameCenterIndicatorPositions()
    if not gameCenterEnabled or not gameCenter then
      print("<gamecenter> indicator: gc not enabled\n")
      return
    end
    if not gameCenter.leaderboards or not leaderboards then
      print("<gamecenter> indicator: leaderboards not loaded\n")
    end
    local leaderBoardName = getLeaderboardNameForEpisode(self.episode)
    local leaderBoardID = leaderboards[leaderBoardName]
    if not leaderBoardName or not leaderBoardID then
      print("<gamecenter> indicator: couldn't get leaderboard or leaderboard name (name=" .. _G.tostring(leaderBoardName) .. "\n")
      return
    end
    if not gameCenter.leaderboards[leaderBoardID] or gameCenter.leaderboards[leaderBoardID].loading then
      print("<gamecenter> indicator: leaderboard doesn't exist or is still loading\n")
      return
    end
    local leaderboard = gameCenter.leaderboards[leaderBoardID]
    if leaderboard.localRank and leaderboard.range then
      local local_rank = leaderboard.localRank
      local range = leaderboard.range
      local pos_in_meter = 0
      if local_rank > 0 then
        if range > 1 then
          pos_in_meter = (local_rank - 1) / (range - 1)
        else
          pos_in_meter = 0
        end
      end
      local meterBG = self:getChild("meterBG")
      local _, meterHeight = _G.res.getSpriteBounds(meterBG.image)
      local meterIndicator = meterBG:getChild("meterIndicator")
      meterIndicator.y = _G.math.min(meterHeight * -0.645 + meterHeight * 0.645 * pos_in_meter, 0)
    else
      print("<gamecenter> indicator: no leaderboard rank\n")
    end
  end
  GoldenEggButton = EpisodeButtonBase:new()
  function GoldenEggButton:init()
    EpisodeButtonBase.init(self)
    local background = self:getChild("background")
    local egg_left = ui.Image:new()
    egg_left.name = "eggLeft"
    egg_left:setImage("EPISODEG_EGG")
    background:addChild(egg_left)
    local egg_right = ui.Image:new()
    egg_right.name = "eggRight"
    egg_right:setImage("EPISODEG_EGG")
    background:addChild(egg_right)
    local score_box = BackgroundBox:new()
    score_box.name = "scoreBox"
    score_box.hanchor = "HCENTER"
    score_box.vanchor = "BOTTOM"
    score_box.components = {
      topLeft = "SCORE_TOP_LEFT",
      left = "SCORE_LEFT",
      bottomLeft = "SCORE_BOTTOM_LEFT",
      bottomMiddle = "SCORE_BOTTOM_MIDDLE",
      bottomRight = "SCORE_BOTTOM_RIGHT",
      right = "SCORE_RIGHT",
      topRight = "SCORE_TOP_RIGHT",
      topMiddle = "SCORE_TOP_MIDDLE",
      center = "SCORE_CENTER"
    }
    self:addChild(score_box)
    local star = ui.Image:new()
    star.name = "star"
    star:setImage("EPISODEG_STAR")
    score_box:addChild(star)
    local score = ui.Text:new()
    score.name = "score"
    score.text = ""
    score.font = "FONT_LS_SMALL"
    score.hanchor = "HCENTER"
    score.vanchor = "BASELINE"
    score_box:addChild(score)
  end
  function GoldenEggButton:onEntry()
    local background = self:getChild("background")
    local score_box = self:getChild("scoreBox")
    local score = score_box:getChild("score")
    score.text = "" .. calculateStarsFromGoldenEggLevels()
    EpisodeButtonBase.onEntry(self)
  end
  function GoldenEggButton:layout()
    EpisodeButtonBase.layout(self)
    local background = self:getChild("background")
    local egg_left = background:getChild("eggLeft")
    egg_left.x = _G.math.floor(-self.width / 2.1)
    egg_left.y = _G.math.floor(-self.height / 2.05)
    local egg_right = background:getChild("eggRight")
    egg_right.x = _G.math.floor(self.width / 2.1)
    egg_right.y = _G.math.floor(-self.height / 2.05)
    setFont("FONT_LS_SMALL")
    local fontHeightSmall = _G.res.getFontHeight()
    local _, starHeight = _G.res.getSpriteBounds("LS_STAR_GOLD")
    local _, iconHeight = _G.res.getSpriteBounds(background:getChild("episodeIcon").image)
    local _, topEdgeY = _G.res.getSpriteBounds(background.components.topMiddle)
    local score_box = self:getChild("scoreBox")
    score_box.y = self.height * 0.5 + topEdgeY / 6
    score_box.width = self.width / 4.5
    score_box.height = fontHeightSmall + starHeight
    local star = score_box:getChild("star")
    star.y = score_box.height * -0.5 - fontHeightSmall * 0.125
    local score = score_box:getChild("score")
    score.y = score_box.height * -0.5 - fontHeightSmall * 0.125
  end
else
  EpisodeButtonBase = ui.ImageButton:new()
  function EpisodeButtonBase:init()
    ui.ImageButton.init(self)
    self.activateOnRelease = true
    local lock = ui.Image:new()
    lock.name = "lock"
    lock:setImage("LS_LEVEL_PACK_LOCK")
    lock:setVisible(false)
    self:addChild(lock)
  end
  function EpisodeButtonBase:setEpisode(id, episode)
    self.episode = id
    self.meta = id
  end
  function EpisodeButtonBase:setOpen(open)
    self.locked = not open
    self:setEnabled(open)
  end
  function EpisodeButtonBase:layout()
    ui.ImageButton.layout(self)
    local lock = self:getChild("lock")
    lock:setVisible(self.locked)
  end
  EpisodeButton = EpisodeButtonBase:new()
  function EpisodeButton:init()
    local score_box = ui.Image:new()
    score_box.name = "score_box"
    score_box:setImage("EP_BTN_SCOREBOX")
    self:addChild(score_box)
    local score = ui.Text:new()
    score.name = "score"
    score.text = "0"
    score.font = "FONT_LS_SMALL"
    self:addChild(score)
    local star_box = ui.Image:new()
    star_box.name = "star_box"
    star_box:setImage("EP_BTN_STARBOX")
    self:addChild(star_box)
    local stars = ui.Text:new()
    stars.name = "stars"
    stars.text = ""
    stars.font = "FONT_LS_SMALL"
    self:addChild(stars)
    local feather_box = ui.Image:new()
    feather_box.name = "feather_box"
    feather_box:setImage("EP_BTN_EAGLEBOX")
    self:addChild(feather_box)
    local feather_score = ui.Text:new()
    feather_score.name = "feather_score"
    feather_score.text = "0"
    feather_score.font = "FONT_LS_SMALL"
    self:addChild(feather_score)
    EpisodeButtonBase.init(self)
  end
  function EpisodeButton:layout()
    EpisodeButtonBase.layout(self)
    local score_box = self:getChild("score_box")
    local star_box = self:getChild("star_box")
    local score = self:getChild("score")
    local stars = self:getChild("stars")
    local bg_w, bg_h = _G.res.getSpriteBounds(self.reference_button and self.reference_button.image or self.image)
    local box_w, star_box_h = _G.res.getSpriteBounds(star_box.image)
    local _, score_box_h = _G.res.getSpriteBounds(score_box.image)
    setFont(score.font)
    local font_adjust, font_adjust2
    local fh = _G.res.getFontLeading()
    local font_profile = selectFontProfile()
    font_adjust = star_box_h * 0.25
    font_adjust2 = 0
    if deviceModel == "android" and screenHeight < 320 then
      font_adjust = star_box_h * 0.15
      font_adjust2 = font_adjust * -0.1
    end
    if not showEagleScoreElements() then
      star_box.y = bg_h * 0.5 - star_box_h * 0.5 - (bg_w - box_w) * 0.5
      score_box.y = star_box.y - star_box_h * 0.5 - (bg_w - box_w) * 0.25 - score_box_h * 0.5
      stars.y = star_box.y + font_adjust
      score.y = score_box.y + font_adjust
    else
      local feather_box = self:getChild("feather_box")
      local feather_score = self:getChild("feather_score")
      local _, feather_box_h = _G.res.getSpriteBounds(feather_box.image)
      feather_box.y = bg_h * 0.5 - feather_box_h * 0.5 - (bg_w - box_w) * 0.5
      star_box.y = feather_box.y - feather_box_h * 0.5 - (bg_w - box_w) * 0.25 - star_box_h * 0.5
      score_box.y = star_box.y - star_box_h * 0.5 - (bg_w - box_w) * 0.25 - score_box_h * 0.5
      feather_score.x = box_w * 0.2
      feather_score.y = feather_box.y + font_adjust2
      stars.y = star_box.y + font_adjust
      score.y = score_box.y + font_adjust
    end
  end
  function EpisodeButton:onEntry()
    EpisodeButtonBase.onEntry(self)
    local stars, total_stars = calculateEpisodeStars(self.episode)
    local star_counter = self:getChild("stars")
    star_counter.text = stars .. "/" .. total_stars
    local total_score = calculateEpisodeScore(self.episode)
    local score = self:getChild("score")
    score.text = _G.string.format("%d", total_score)
    self:getChild("feather_box"):setVisible(showEagleScoreElements())
    self:getChild("feather_score"):setVisible(showEagleScoreElements())
    if showEagleScoreElements() then
      local feathers, total_feathers = calculateFeatherScore(self.episode)
      local feather_score = self:getChild("feather_score")
      feather_score.text = feathers .. "/" .. total_feathers
    end
  end
  function EpisodeButton:setEpisode(id, episode)
    EpisodeButtonBase.setEpisode(self, id, episode)
    self:setImage(g_episodes[id].button)
  end
  GoldenEggButton = EpisodeButtonBase:new()
  function GoldenEggButton:init()
    local star_box = ui.Image:new()
    star_box.name = "star_box"
    star_box:setImage("EP_BTN_STARBOX")
    self:addChild(star_box)
    local stars = ui.Text:new()
    stars.name = "stars"
    stars.text = ""
    stars.font = "FONT_LS_SMALL"
    self:addChild(stars)
    EpisodeButtonBase.init(self)
  end
  function GoldenEggButton:layout()
    EpisodeButtonBase.layout(self)
    local star_box = self:getChild("star_box")
    local stars = self:getChild("stars")
    local bg_w, bg_h = _G.res.getSpriteBounds(self.image)
    local box_w, star_box_h = _G.res.getSpriteBounds(star_box.image)
    star_box.y = bg_h * 0.5 - star_box_h * 0.5 - (bg_w - box_w) * 0.5
    stars.y = star_box.y + star_box_h * 0.25
  end
  function GoldenEggButton:onEntry()
    EpisodeButtonBase.onEntry(self)
    local star_counter = self:getChild("stars")
    star_counter.text = "" .. calculateStarsFromGoldenEggLevels()
  end
  function GoldenEggButton:setEpisode(id, episode)
    EpisodeButtonBase.setEpisode(self, id, episode)
    self:setImage("BTN_GOLDENEGGS")
  end
end
filename = "episode_selection.lua"
