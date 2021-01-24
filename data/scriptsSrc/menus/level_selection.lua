LevelSelectionRoot = ui.Frame:new()
local g_use_scroll_buttons = deviceModel == "windows" or deviceModel == "osx" or deviceModel == "roku" or deviceModel == "freebox"
function LevelSelectionRoot:draw(x, y)
  drawLevelSelectionBackground()
  ui.Frame.draw(self, x, y)
end
function LevelSelectionRoot:init()
  ui.Frame.init(self)
  self.name = self.name or "LevelSelectionRoot"
  if deviceModel == "s60" then
    local closeButton = ui.ImageButton:new()
    closeButton.name = "closeButton"
    closeButton:setImage("BUTTON_CLOSE")
    closeButton.returnValue = "EXIT"
    self:addChild(closeButton)
  end
end
function LevelSelectionRoot:layout()
  ui.Frame.layout(self)
  if deviceModel == "s60" then
    local closeButton = self:getChild("closeButton")
    closeButton.x = screenWidth - g_layoutMargin.x
    closeButton.y = g_layoutMargin.y
  end
end
function LevelSelectionRoot:update(dt, time)
  if _G.res.isAudioPlaying(currentMainMenuSong) == false and currentMainMenuSong ~= nil then
    _G.res.playAudio(currentMainMenuSong, 0.8, true, 7)
  end
  ui.Frame.update(self, dt, time)
end
function LevelSelectionRoot:onPointerEvent(eventType, x, y)
  local result, meta, item = ui.Frame.onPointerEvent(self, eventType, x, y)
  if result == "EPISODE_SELECTION" then
    eventManager:notify({
      id = events.EID_CHANGE_SCENE,
      target = "EPISODE_SELECTION",
      from = "LEVEL_SELECTION"
    })
  elseif result == "GOTO_LEVEL" then
    local allowed_to_play = true
    if g_registrationEnabled and not g_isRegistered and not g_episodes[meta.episode].pages[meta.page].free_to_play then
      allowed_to_play = false
    end
    local level_event
    if not meta.intro_cutscene then
      level_event = {
        id = events.EID_CHANGE_LEVEL,
        data = meta,
        from = "levelselection menu"
      }
    else
      level_event = {
        id = events.EID_LOAD_INTRO_CUTSCENE,
        cutscene = meta.intro_cutscene,
        data = meta
      }
    end
    if allowed_to_play then
      eventManager:notify(level_event)
    else
      eventManager:notify({
        id = events.EID_SHOW_REGISTRATION_DIALOG,
        from = "LEVEL_SELECTION",
        success_event = level_event
      })
    end
  elseif result == "DISABLED_LEVEL" then
    if g_episodes[meta.episode].pages[meta.page].levels[meta.level].hint then
      eventManager:notify({
        id = events.EID_PUSH_FRAME,
        target = GoldenEggHintPopup:new(g_episodes[meta.episode].pages[meta.page].levels[meta.level].hint)
      })
    end
  elseif result == "GOTO_FACEBOOK_CONNECT" then
    eventManager:notify({
      id = events.EID_GOTO_FACEBOOK_CONNECT
    })
  elseif result == "EXIT" then
    eventManager:notify({
      id = events.EID_EXIT_GAME
    })
  elseif result == "SHOW_FACEBOOK_PROMPT" then
    eventManager:notify({
      id = events.EID_PUSH_FRAME,
      target = ui.Prompt:new({
        title = "TEXT_FB_LEVELS_HINT_TITLE",
        content = "TEXT_FB_LEVELS_HINT"
      })
    })
  elseif result == "ACTIVATE_KINGPIG" then
    if currentMainMenuSong then
      _G.res.stopAudio(currentMainMenuSong)
      currentMainMenuSong = nil
    end
    eventManager:notify({
      id = events.EID_MATTEL_RANDOM_MODE,
      popup = true
    })
  end
  return result, meta, item
end
LevelSelection = LevelSelectionRoot:new()
function LevelSelection:new(o, episode)
  local o = o or {}
  o.episode = episode
  o.name = "LevelSelection" .. _G.tostring(episode)
  return LevelSelectionRoot.new(self, o)
end
function LevelSelection:init()
  self.backgroundColour = {
    r = 0,
    g = 0,
    b = 0,
    a = 255
  }
  self:createDecorationSprites()
  local levelButtons = LevelScrollFrame:new(nil, self.episode)
  levelButtons.name = "levelButtons"
  self:addChild(levelButtons)
  self.currentSelection = settingsWrapper:getCurrentLevelSelectionPage(self.episode)
  if self.currentSelection > #g_episodes[self.episode].pages then
    self.currentSelection = #g_episodes[self.episode].pages
    settingsWrapper:setCurrentLevelSelectionPage(self.episode, self.currentSelection)
  end
  levelButtons.currentSelection = self.currentSelection
  local left = self:getChild("left")
  if g_episodes[self.episode].decor_left ~= nil then
    left:setVisible(true)
    left:setImage(g_episodes[self.episode].decor_left)
  else
    left:setVisible(false)
  end
  local right = self:getChild("right")
  if g_episodes[self.episode].decor_right ~= nil then
    right:setVisible(true)
    right:setImage(g_episodes[self.episode].decor_right)
  else
    right:setVisible(false)
  end
  for i = 1, #g_episodes[self.episode].pages do
    local page = g_episodes[self.episode].pages[i]
    local dot = ui.Image:new()
    dot.name = "dot" .. i
    dot:setImage("LS_DOT_BLACK")
    dot.attach = "fixed"
    self:addChild(dot)
  end
  for i = 1, #g_episodes[self.episode].pages do
    local page = g_episodes[self.episode].pages[i]
    local pageNumber = ui.Text:new()
    pageNumber.name = "pageNumber" .. i
    if page.display_dot_numbers ~= false then
      pageNumber.text = page.display_number or ""
    else
      pageNumber.text = ""
    end
    pageNumber.font = "FONT_LS_SMALL"
    pageNumber.visible = false
    pageNumber.attach = "fixed"
    self:addChild(pageNumber)
  end
  local backButton = ui.ImageButton:new()
  backButton.name = "backButton"
  backButton:setImage("ARROW_LEFT")
  backButton.returnValue = "EPISODE_SELECTION"
  backButton.attach = "fixed"
  backButton.activateOnRelease = true
  backButton.clickSound = "menu_back"
  self:addChild(backButton)
  if g_use_scroll_buttons then
    local left_button = ui.ImageButton:new()
    left_button.name = "left_button"
    left_button:setImage("BUTTON_ARROW_LEFT")
    left_button.returnValue = "SCROLL_LEFT"
    self:addChild(left_button)
    levelButtons.left_button = left_button
    local right_button = ui.ImageButton:new()
    right_button.name = "right_button"
    right_button:setImage("BUTTON_ARROW_RIGHT")
    right_button.returnValue = "SCROLL_RIGHT"
    self:addChild(right_button)
    levelButtons.right_button = right_button
  end
  eventManager:addEventListener(events.EID_SCROLL_TO_NEXT_WORLD, self)
  LevelSelectionRoot.init(self)
end
function LevelSelection:createDecorationSprites()
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
function LevelSelection:onEntry()
  eventManager:addEventListener(events.EID_FACEBOOK_LIKE_CLICKED, self)
  eventManager:addEventListener(events.EID_MIGHTY_EAGLE_AVAILABLE, self)
  eventManager:addEventListener(events.EID_MIGHTY_EAGLE_NFC_COOLDOWN_OVER, self)
  loginfo("added EID_MIGHTY_EAGLE_AVAILABLE for levelSelection")
  self:shadeBackground(self.currentSelection)
  self:updateSelection(true)
  levelRestartedFrom = nil
  LevelSelectionRoot.onEntry(self)
end
function LevelSelection:onExit()
  loginfo("removing EID_MIGHTY_EAGLE_AVAILABLE for levelSelection")
  eventManager:removeEventListener(events.EID_FACEBOOK_LIKE_CLICKED, self)
  eventManager:removeEventListener(events.EID_MIGHTY_EAGLE_AVAILABLE, self)
  eventManager:removeEventListener(events.EID_MIGHTY_EAGLE_NFC_COOLDOWN_OVER, self)
  LevelSelectionRoot.onExit(self)
end
function LevelSelection:layout()
  local left = self:getChild("left")
  left.y = screenHeight
  local right = self:getChild("right")
  right.x = screenWidth
  right.y = screenHeight
  local back_button = self:getChild("backButton")
  back_button:refresh()
  back_button.x = back_button.w * 0.5 + g_layoutMargin.x
  back_button.y = screenHeight - back_button.h * 0.5 - g_layoutMargin.y
  if deviceModel == "roku" then
    back_button.y = back_button.h * 0.5 + g_layoutMargin.y
  end
  local pages = g_episodes[self.episode].pages
  local dot_y = 10
  local dot_spacing = 15
  local first_dot_x = screenWidth * 0.5 - (#pages - 1) * 0.5 * dot_spacing
  local text_y = 0.03 * screenHeight + 12
  for i = 1, #pages do
    local dot = self:getChild("dot" .. i)
    dot.x = first_dot_x + dot_spacing * (i - 1)
    dot.y = screenHeight - dot_y - g_layoutMargin.y
    local pageNumber = self:getChild("pageNumber" .. i)
    pageNumber.x = dot.x
    pageNumber.y = screenHeight - text_y - g_layoutMargin.y
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
  LevelSelectionRoot.layout(self)
end
function LevelSelection:setEpisode(id)
  self.episode = id
end
function LevelSelection:checkGoldenEgg(dt, time)
  local egg = self:getChild("GoldenEggEP3")
  if self.episode ~= 3 or egg == nil then
    return
  end
  if self.revealTimer ~= nil and self.revealTimer > 0 then
    self.revealTimer = self.revealTimer - dt
    if self.revealTimer < 0 then
      self.revealTimer = nil
    end
    return true
  end
  if egg ~= nil then
    local x = self:getChild("levelButtons"):getCurrentX()
    local GEx = egg.x
    if x >= GEx - screenWidth * 0.8 then
      self:getChild("levelButtons"):removeChild(egg)
      eventManager:notify({
        id = events.EID_GOLDEN_EGG_FROM_MENU,
        levelName = "LevelGE_7"
      })
      self.revealTimer = 3
    end
  end
end
function LevelSelection:update(dt, time)
  self:shadeBackground(self:getChild("levelButtons"):getCurrentX() / screenWidth + 1)
  if self:checkGoldenEgg(dt, time) then
    return
  end
  if self.episode == "G" then
    for i = 1, #g_episodes[self.episode].pages do
      for j = 1, #g_episodes[self.episode].pages[i].levels do
        local star_effect = self:getChild("starEffect" .. i .. "-" .. j)
        star_effect.angle = star_effect.angle + dt * 0.6
      end
    end
  end
  if self.scroll_to_next_page then
    local scroll = self:getChild("levelButtons")
    scroll:next()
    self.scroll_to_next_page = false
  end
  LevelSelectionRoot.update(self, dt, time)
  self:updateSelection()
end
if g_use_scroll_buttons then
  function LevelSelection:onPointerEvent(eventType, x, y)
    local result, meta, item = LevelSelectionRoot.onPointerEvent(self, eventType, x, y)
    if result == "SCROLL_LEFT" then
      self:getChild("levelButtons"):previous()
    elseif result == "SCROLL_RIGHT" then
      self:getChild("levelButtons"):next()
    end
    return result, meta, item
  end
end
function LevelSelection:onKeyEvent(eventType, key)
  local result, meta, item = LevelSelectionRoot.onKeyEvent(self, eventType, key)
  if not result and eventType == "RELEASE" and (key == "BACK" or key == "ESCAPE") then
    eventManager:notify({
      id = events.EID_CHANGE_SCENE,
      target = "EPISODE_SELECTION",
      from = "LEVEL_SELECTION"
    })
  end
  return result, meta, item
end
function LevelSelection:shadeBackground(page)
  local leftSide = _G.math.floor(page)
  local rightSide = leftSide + 1
  local ep = g_episodes[self.episode]
  if page <= 1 then
    self.backgroundColour.r = ep.pages[1].colour.r
    self.backgroundColour.g = ep.pages[1].colour.g
    self.backgroundColour.b = ep.pages[1].colour.b
  elseif page >= #ep.pages then
    self.backgroundColour.r = ep.pages[#ep.pages].colour.r
    self.backgroundColour.g = ep.pages[#ep.pages].colour.g
    self.backgroundColour.b = ep.pages[#ep.pages].colour.b
  else
    local ml = page - leftSide
    self.backgroundColour.r = ep.pages[leftSide].colour.r + ml * (ep.pages[rightSide].colour.r - ep.pages[leftSide].colour.r)
    self.backgroundColour.g = ep.pages[leftSide].colour.g + ml * (ep.pages[rightSide].colour.g - ep.pages[leftSide].colour.g)
    self.backgroundColour.b = ep.pages[leftSide].colour.b + ml * (ep.pages[rightSide].colour.b - ep.pages[leftSide].colour.b)
  end
end
function LevelSelection:updateSelection(initial_selection)
  local new_index = self.currentSelection
  if not initial_selection then
    new_index = self:getChild("levelButtons"):getCurrentAnchor()
  end
  if self.currentSelection ~= new_index or initial_selection then
    settingsWrapper:setCurrentLevelSelectionPage(self.episode, new_index)
    local new_dot = self:getChild("dot" .. new_index)
    if new_dot ~= nil then
      self:getChild("dot" .. self.currentSelection):setImage("LS_DOT_BLACK")
      self:getChild("pageNumber" .. self.currentSelection).visible = false
      new_dot:setImage("LS_DOT_WHITE")
      self:getChild("pageNumber" .. new_index).visible = true
      self.currentSelection = new_index
    end
    self:getChild("levelButtons").currentSelection = new_index
    if g_use_scroll_buttons then
      self:getChild("left_button"):setVisible(new_index > 1)
      self:getChild("right_button"):setVisible(new_index < #g_episodes[self.episode].pages)
    end
  end
end
function LevelSelection:eventTriggered(event)
  if event.id == events.EID_SCROLL_TO_NEXT_WORLD and event.episode == self.episode then
    self.scroll_to_next_page = true
  end
  if event.id == events.EID_FACEBOOK_LIKE_CLICKED then
    local pages = g_episodes[self.episode].pages
    if self.episode ~= nil then
      for i = 1, #g_episodes[self.episode].pages do
        local page = pages[i]
        for j = 1, #page.levels do
          local button = self:getChild("level" .. i .. "-" .. j)
          if button ~= nil and button.type == "facebook" then
            button:setImage(page.level_button, page.level_button)
            button.returnValue = "GOTO_LEVEL"
            button:getChild("number").visible = true
            self:getChild("levelButtons"):refreshVisibleChildren()
          end
        end
      end
    end
  end
  if event.id == events.EID_MIGHTY_EAGLE_AVAILABLE or event.id == events.EID_MIGHTY_EAGLE_NFC_COOLDOWN_OVER then
    local pages = g_episodes[self.episode].pages
    if self.episode ~= nil then
      for i = 1, #g_episodes[self.episode].pages do
        local page = pages[i]
        for j = 1, #page.levels do
          local button = self:getChild("level" .. i .. "-" .. j)
          if button ~= nil then
            local eagle = button:getChild("eagle")
            if eagle ~= nil and eagle.visible then
              eagle.visible = false
              local number = button:getChild("number")
              if number ~= nil then
                number.visible = true
              end
              self:getChild("levelButtons"):refreshVisibleChildren()
            end
          end
        end
      end
    end
  end
end
LevelScrollFrame = ui.ScrollFrame:new()
function LevelScrollFrame:new(o, episode)
  local o = o or {}
  o.episode = episode
  return ui.ScrollFrame.new(self, o)
end
function LevelScrollFrame:init()
  self.visible_children = {}
  self.visible_images = {}
  self.visible_text = {}
  self.eventTimer = subsystems.Timer.new(g_time or 0)
  local pages = g_episodes[self.episode].pages
  local levels = 0
  for i = 1, #g_episodes[self.episode].pages do
    if g_episodes[self.episode].per_page_level_numbering then
      levels = 0
    end
    local page = pages[i]
    g_ls_layout_mapping[page.layout].beforeCreate(self, i, page)
    for j = 1, #page.levels do
      levels = levels + 1
      self:createLevelButton(i, j, page, page.levels[j], levels)
    end
    g_ls_layout_mapping[page.layout].afterCreate(self, i, page)
    if self.episode == 3 and i == 1 and not settingsWrapper:isGoldenEggUnlocked("LevelGE_7") then
      local egg = ui.ImageButton:new()
      egg.name = "GoldenEggEP3"
      egg:setImage("GOLDEN_EGG_5")
      self:addChild(egg)
    end
    if page.locked then
      local coming_soon = ui.Image:new()
      coming_soon.name = "coming_soon" .. i
      coming_soon:setImage("LS_COMING_SOON")
      self:addChild(coming_soon)
    end
    if (deviceModel == "ipad" or deviceModel == "ipad3" or deviceModel == "android" or deviceModel == "windows" or deviceModel == "osx") and self.episode == "G" and i == 2 then
      local kingpig_button = ui.ImageButton:new()
      kingpig_button.name = "kingpig_button"
      kingpig_button:setImage("MATTEL_GOLDENEGGS_SELECT")
      kingpig_button.returnValue = "ACTIVATE_KINGPIG"
      kingpig_button:setVisible(false)
      self:addChild(kingpig_button)
    end
  end
  ui.ScrollFrame.init(self)
end
if g_isAccelerometerControl then
  function LevelScrollFrame:wheel(direction)
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
function LevelScrollFrame:createLevelButton(i, j, page, button, display_number)
  local levelName = button.name
  local level_button = ui.ImageButton:new()
  level_button.name = "level" .. i .. "-" .. j
  level_button.activateOnRelease = true
  level_button.onPointerEvent = ui.ScrollFrame.handlePointerEvent
  local enabled_button = page.levels[j].level_button_override or page.level_button
  local disabled_button = page.levels[j].disabled_button_override or "LS_LEVEL_BG_NORMAL_CLOSED"
  level_button:setImage(enabled_button, disabled_button)
  local level, _, _, _ = getLevelById(levelName)
  level_button.returnValue = "GOTO_LEVEL"
  level_button.disabledReturnValue = "DISABLED_LEVEL"
  self:addChild(level_button)
  g_ls_layout_mapping[page.layout].createLevelButton(self, level_button, i, page, display_number, level)
  level_button.meta = {
    episode = self.episode,
    page = i,
    level = j,
    levelName = levelName,
    intro_cutscene = level.intro_cutscene,
    flurryId = button.flurryId
  }
end
function LevelScrollFrame:onEntry()
  ui.ScrollFrame.onEntry(self)
  local levels = 0
  for i = 1, #g_episodes[self.episode].pages do
    local page = g_episodes[self.episode].pages[i]
    for j = 1, #page.levels do
      local level_button = self:getChild("level" .. i .. "-" .. j)
      local level = page.levels[j]
      if not g_episodes[self.episode].no_level_progression then
        local level_open = g_ls_layout_mapping[page.layout].isLevelOpen(self, levels + j)
        if page.locked then
          level_open = false
        end
        if level_open or highscores[level.name] then
          level_button:setEnabled(true)
          level_button:getChild("number").visible = true
          g_ls_layout_mapping[page.layout].onOpenLevelEntry(self, page, level_button)
          local score = highscores[level.name]
          local limits = starTable[level.name]
          local level_number = level_button:getChild("number")
          local stars = level_button:getChild("stars")
          local feather = level_button:getChild("feather")
          local eagle = level_button:getChild("eagle")
          level_number.visible = true
          eagle.visible = false
          if highscores[level.name] and highscores[level.name].score and 0 < highscores[level.name].score and highscores[level.name].completed then
            local score = highscores[level.name]
            local limits = starTable[level.name]
            stars.visible = true
            if score.score >= limits.goldScore then
              stars:setImage("LS_STARS_3")
            elseif score.score >= limits.silverScore then
              stars:setImage("LS_STARS_2")
            else
              stars:setImage("LS_STARS_1")
            end
          elseif highscores[level.name] and (not highscores[level.name].score or highscores[level.name].score and highscores[level.name].score == 0) and highscores[level.name].completed and settings.eaglesUsedIn then
            for i = 1, #settings.eaglesUsedIn do
              if settings.eaglesUsedIn[i].level == level.name then
                loginfo("eagle used in " .. level.name)
                level_number.visible = false
                stars.visible = false
                eagle.visible = true
              end
            end
          end
          if highscores[level.name] and highscores[level.name].eagleScore and highscores[level.name].eagleScore >= 100 then
            feather.visible = true
          end
        else
          g_ls_layout_mapping[page.layout].onClosedLevelEntry(self, page, level_button)
          level_button:getChild("number").visible = false
          level_button:getChild("stars").visible = false
          level_button:getChild("eagle").visible = false
          level_button:getChild("feather").visible = false
        end
      else
        local star_effect = self:getChild("starEffect" .. i .. "-" .. j)
        if settingsWrapper:isGoldenEggUnlocked(level.name) then
          level_button:setEnabled(true)
          level_button:setVisible(true)
          star_effect:setVisible(not settingsWrapper:isGoldenEggPlayed(level.name))
          local star = level_button:getChild("star")
          if highscores[level.name] and highscores[level.name].completed then
            star:setVisible(true)
          else
            star:setVisible(false)
          end
        else
          level_button:setEnabled(false)
          if level.disabled_button_override == nil then
            level_button:setVisible(false)
          else
            level_button:setVisible(true)
          end
          star_effect.visible = false
        end
      end
    end
    levels = levels + #page.levels
  end
  if self.episode == "G" and (deviceModel == "ipad" or deviceModel == "ipad3" or deviceModel == "android" or deviceModel == "windows" or deviceModel == "osx") then
    local kingpig_button = self:getChild("kingpig_button")
    local eps = {
      1,
      2,
      3,
      4,
      5,
      6,
      7
    }
    local open = true
    for _, v in _G.ipairs(eps) do
      local e = g_episodes[v]
      for _, v2 in _G.ipairs(e.pages) do
        for _, v3 in _G.ipairs(v2.levels) do
          if not highscores[v3.name] or highscores[v3.name].score < starTable[v3.name].goldScore then
            open = false
          end
        end
      end
    end
    if open or not releaseBuild then
      kingpig_button:setVisible(true)
    end
  end
  self:refreshVisibleChildren()
end
function LevelScrollFrame:layout()
  local left, right
  if g_use_scroll_buttons then
    local border = _G.res.getSpriteBounds("BUTTON_ARROW_LEFT") + g_layoutMargin.x
    left = border
    right = screenWidth - border
  else
    left = g_layoutMargin.x
    right = screenWidth - g_layoutMargin.x
  end
  local width = right - left
  local anchors = {}
  local anchorAmount = #g_episodes[self.episode].pages
  if self.episode == "G" then
    local have_page_2_egg = false
    for _, v in _G.ipairs(g_episodes[self.episode].pages[2].levels) do
      if settingsWrapper:isGoldenEggUnlocked(v.name) then
        have_page_2_egg = true
      end
    end
    if deviceModel == "ipad" or deviceModel == "ipad3" or deviceModel == "android" or deviceModel == "windows" or deviceModel == "osx" then
      local kingpig_button = self:getChild("kingpig_button")
      kingpig_button.x = screenWidth * 1.15
      kingpig_button.y = screenHeight * 0.19
    end
    if not have_page_2_egg then
      anchorAmount = 1
      menuManager:getRoot():getChild("dot1").visible = false
      menuManager:getRoot():getChild("dot2").visible = false
      local rb = menuManager:getRoot():getChild("right_button")
      if rb then
        rb.visible = false
      end
    else
      menuManager:getRoot():getChild("dot1").visible = true
      menuManager:getRoot():getChild("dot2").visible = true
    end
  end
  for i = 1, anchorAmount do
    _G.table.insert(anchors, i, {
      x = (i - 1) * screenWidth,
      y = 0
    })
  end
  self:setAnchors(anchors)
  ui.ScrollFrame.layout(self)
  if self.episode == 3 then
    local egg = self:getChild("GoldenEggEP3")
    if egg ~= nil then
      local w, h = _G.res.getSpriteBounds(egg.image)
      egg.y = screenHeight * 0.5 - h / 2
      egg.x = anchorAmount * screenWidth + w * 1.5
    end
  end
  self:setCurrentAnchor(self.currentSelection)
  for i = 1, #g_episodes[self.episode].pages do
    local page = g_episodes[self.episode].pages[i]
    g_ls_layout_mapping[page.layout].layout(self, page, i)
    if page.locked then
      local coming_soon = self:getChild("coming_soon" .. i)
      coming_soon.x = (i - 0.5) * screenWidth
      coming_soon.y = 0.5 * screenHeight
    end
  end
  self:refreshVisibleChildren()
end
function LevelScrollFrame:update(dt, time)
  self.eventTimer:update(dt, time)
  local sx = self:getCurrentX()
  if g_use_scroll_buttons then
    ui.ScrollFrame.update(self, dt, time)
  else
    self:updateSelf(dt, time)
  end
  if sx ~= self:getCurrentX() then
    self:refreshVisibleChildren()
  end
end
if deviceModel ~= "windows" and deviceModel ~= "osx" and deviceModel ~= "freebox" then
  function LevelScrollFrame:draw(x, y, scaleX, scaleY, angle)
    x = x or 0
    y = y or 0
    x = x - self:getCurrentX()
    y = y - self:getCurrentY()
    angle = angle or 0
    x = _G.math.floor(x)
    y = _G.math.floor(y)
    for k, v in _G.ipairs(self.visible_images) do
      local image = v.image
      if image.angle == 0 then
        self:drawImage(image, v.x + x, v.y + y, v.parent)
      else
        self:drawImageWithAngle(image, v.x + x, v.y + y, v.parent)
      end
    end
    setRenderState(0, 0, 1, 1, 0, 0, 0)
    for k, v in _G.ipairs(self.visible_text) do
      self:drawText(v.text, v.x + x, v.y + y, v.parent)
    end
  end
end
if g_enableHoverScaling then
  function LevelScrollFrame:drawImage(item, x, y, parent)
    item:drawSelf(x, y, 1, 1, 0, parent and parent:hoverScale() or 1)
  end
  function LevelScrollFrame:drawText(text, x, y, parent)
    text:draw(x, y, 1, 1, 0, parent and parent:hoverScale() or 1)
  end
else
  function LevelScrollFrame:drawImage(item, x, y)
    if item.visible == true then
      _G.res.drawSprite(item.image, _G.math.floor(item.x + x), _G.math.floor(item.y + y))
    end
  end
  function LevelScrollFrame:drawText(text, x, y)
    setFont(text.font)
    _G.res.drawString("TEXTS_BASIC", text.text, _G.math.floor(text.x + x), _G.math.floor(text.y + y), text.hanchor, text.vanchor)
  end
end
function LevelScrollFrame:drawImageWithAngle(item, x, y)
  if item.visible == true then
    setRenderState(_G.math.floor(item.x + x), _G.math.floor(item.y + y), 1, 1, item.angle, item.px, item.py)
    _G.res.drawSprite(item.image, 0, 0)
    setRenderState(0, 0, 1, 1, 0, 0, 0)
  end
end
function LevelScrollFrame:refreshVisibleChildren()
  local x = self:getCurrentX() or 0
  local y = self:getCurrentY() or 0
  local image_index = 1
  local text_index = 1
  for _, v in _G.ipairs(self.children) do
    if v.visible == true and v.x - x >= -v.w and v.x - x <= screenWidth + 0.5 * v.w then
      local vi = self.visible_images[image_index] or {}
      vi.x, vi.y, vi.image, vi.parent = 0, 0, v, nil
      self.visible_images[image_index] = vi
      image_index = image_index + 1
      for _, v2 in _G.ipairs(v.children) do
        if v2.text == nil and v2.visible then
          local vi = self.visible_images[image_index] or {}
          vi.x, vi.y, vi.image, vi.parent = v.x, v.y, v2, v
          self.visible_images[image_index] = vi
          image_index = image_index + 1
        elseif v2.text ~= nil and v2.visible then
          local vt = self.visible_text[text_index] or {}
          vt.x, vt.y, vt.text, vt.parent = v.x, v.y, v2, v
          self.visible_text[text_index] = vt
          text_index = text_index + 1
        end
      end
    end
  end
  self.visible_images[image_index] = nil
  self.visible_text[text_index] = nil
end
function LevelScrollFrame:onPointerEvent(eventType, x, y)
  if not type == "LHOLD" then
    return ui.ScrollFrame.onPointerEvent(self, eventType, x, y)
  else
    local sx = self:getCurrentX()
    local result, meta, item = ui.ScrollFrame.onPointerEvent(self, eventType, x, y)
    if sx ~= self:getCurrentX() then
      self:refreshVisibleChildren()
    end
    return result, meta, item
  end
end
filename = "level_selection.lua"
