local g_use_scroll_buttons = deviceModel == "windows" or deviceModel == "osx" or deviceModel == "roku" or deviceModel == "freebox"
LSGridLayout = {}
function LSGridLayout:beforeCreate(index, page)
end
function LSGridLayout:afterCreate(index, page)
end
function LSGridLayout:createLevelButton(level_button, index, page, level_index, level)
  local level_number = ui.Text:new({font = getFontBasic})
  level_number.name = "number"
  level_number.text = "" .. level_index
  level_button:addChild(level_number)
  if page.layout == "facebook" then
    level_button.type = "facebook"
  end
  local eagle = ui.Image:new()
  eagle.name = "eagle"
  eagle:setVisible(false)
  eagle:setImage("LS_EAGLE_BUTTON")
  level_button:addChild(eagle)
  local stars = ui.Image:new()
  stars.name = "stars"
  stars:setVisible(false)
  level_button:addChild(stars)
  local feather = ui.Image:new()
  feather.name = "feather"
  feather:setVisible(false)
  feather:setImage("LS_EAGLE_FEATHER")
  level_button:addChild(feather)
end
function LSGridLayout:isLevelOpen(level)
  return level <= settingsWrapper:getLastOpenLevel(self.episode)
end
function LSGridLayout:onOpenLevelEntry(page, level_button)
end
function LSGridLayout:onClosedLevelEntry(page, level_button)
  level_button:setEnabled(false)
end
function LSGridLayout:layout(page, index)
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
  local y_begin = -0.08 * screenHeight
  local y_line_gap_multiplier = 1.16
  local content_width = 0.83
  local levels_per_page = page.layout_params.cols * page.layout_params.rows
  local x_begin = (index - 1) * screenWidth + 0.5 * width * (1 - content_width) + left
  local x_gap = content_width * width / (page.layout_params.cols - 1)
  if deviceModel == "roku" then
    y_begin = 0.02 * screenHeight
  end
  for j = 1, page.layout_params.rows do
    local row_y = screenHeight * (j / (page.layout_params.rows + 2) * y_line_gap_multiplier)
    for k = 1, page.layout_params.cols do
      local level_button = self:getChild("level" .. index .. "-" .. (j - 1) * page.layout_params.cols + k)
      level_button.x = x_begin + x_gap * (k - 1)
      level_button.y = y_begin + row_y
      local level_button_width, level_button_height = _G.res.getSpriteBounds(level_button.image)
      local stars = level_button:getChild("stars")
    end
  end
end
LSFacebookLayout = {}
function LSFacebookLayout:beforeCreate(index, page)
end
function LSFacebookLayout:afterCreate(index, page)
  local fb_button = ui.ImageButton:new()
  fb_button.name = "fbButton" .. index
  fb_button:setImage("FB_LIKE_BUTTON")
  fb_button.returnValue = "GOTO_FACEBOOK_CONNECT"
  fb_button.activateOnRelease = true
  self:addChild(fb_button)
end
function LSFacebookLayout:createLevelButton(level_button, index, page, level_index, level)
  local level_number = ui.Text:new({font = getFontBasic})
  level_number.name = "number"
  level_number.text = "" .. level_index
  level_button:addChild(level_number)
  level_button.type = "facebook"
  local eagle = ui.Image:new()
  eagle.name = "eagle"
  eagle:setVisible(false)
  eagle:setImage("LS_EAGLE_BUTTON")
  level_button:addChild(eagle)
  local stars = ui.Image:new()
  stars.name = "stars"
  stars:setVisible(false)
  level_button:addChild(stars)
  local feather = ui.Image:new()
  feather.name = "feather"
  feather:setVisible(false)
  feather:setImage("LS_EAGLE_FEATHER")
  level_button:addChild(feather)
end
function LSFacebookLayout:isLevelOpen(level)
  return settingsWrapper:isFbPageLiked()
end
function LSFacebookLayout:onOpenLevelEntry(page, level_button)
  level_button:setImage(page.level_button, page.level_button)
  level_button.returnValue = "GOTO_LEVEL"
end
function LSFacebookLayout:onClosedLevelEntry(page, level_button)
  level_button:setEnabled(true)
  level_button.returnValue = "SHOW_FACEBOOK_PROMPT"
  level_button:setImage("LS_LEVEL_BG_NORMAL_CLOSED", "LS_LEVEL_BG_NORMAL_CLOSED")
end
function LSFacebookLayout:layout(page, index)
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
  local fb_button = self:getChild("fbButton" .. index)
  local _, fbh = _G.res.getSpriteBounds(fb_button.image)
  local page_x = (index - 1) * screenWidth + 0.5 * screenWidth
  fb_button.x = page_x
  fb_button.y = screenHeight / 2.75
  local lbw, lbh = _G.res.getSpriteBounds(page.level_button)
  for j = 1, page.layout_params.levels do
    local level_button = self:getChild("level" .. index .. "-" .. j)
    level_button.x = page_x - (page.layout_params.levels - 1) * 0.5 * 1.5 * lbw + (j - 1) * 1.5 * lbw
    level_button.y = fb_button.y + fbh / 2.28 + lbh * 0.5
    local stars = level_button:getChild("stars")
  end
end
LSGoldenEggsLayout = {}
function LSGoldenEggsLayout:beforeCreate(index, page)
  for i = 1, #page.levels do
    local starEffect = ui.Image:new()
    starEffect.name = "starEffect" .. index .. "-" .. i
    starEffect:setImage("GOLDEN_EGG_STAR_EFFECT")
    self:addChild(starEffect)
  end
end
function LSGoldenEggsLayout:afterCreate(index, page)
end
function LSGoldenEggsLayout:createLevelButton(level_button, index, page, level_index, level)
  local star = ui.Image:new()
  star.name = "star"
  star:setImage(level.completed_sprite_override or page.layout_params.completed_sprite)
  star:setVisible(false)
  level_button:addChild(star)
end
function LSGoldenEggsLayout:isLevelOpen(level)
end
function LSGoldenEggsLayout:onOpenLevelEntry(page, level_button)
end
function LSGoldenEggsLayout:onClosedLevelEntry(page, level_button)
  level_button:setEnabled(false)
end
function LSGoldenEggsLayout:layout(page, index)
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
  for j = 1, #page.levels do
    local level_button = self:getChild("level" .. index .. "-" .. j)
    level_button.x = (index - 1) * screenWidth + (page.levels[j].x or 0.5) * width + left
    level_button.y = (page.levels[j].y or 0.5) * screenHeight
    local star_effect = self:getChild("starEffect" .. index .. "-" .. j)
    star_effect.x = level_button.x
    star_effect.y = level_button.y
  end
end
g_ls_layout_mapping = {
  grid = LSGridLayout,
  facebook = LSFacebookLayout,
  goldeneggs = LSGoldenEggsLayout
}
filename = "level_selection_layouts.lua"
