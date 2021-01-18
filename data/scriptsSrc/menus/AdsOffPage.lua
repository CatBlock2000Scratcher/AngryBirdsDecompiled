AdsOffPage = ui.Frame:new()
function AdsOffPage:init()
  ui.Frame.init(self)
  self.name = "AdsOffPage"
  self.shade = self.shade or 0
  local bg = ui.Frame:new({name = "bg"})
  self:addChild(bg)
  local title = ui.Image:new({name = "title"})
  title:setImage("REMOVE_ADS_TEXT")
  bg:addChild(title)
  local closeButton = ui.ImageButton:new({
    name = "closeButton"
  })
  closeButton.returnValue = "CLOSE"
  closeButton:setImage("BUTTON_UPSELL_NO")
  closeButton.clickSound = "menu_back"
  bg:addChild(closeButton)
  local buyButton = ui.ImageButton:new({name = "buyButton"})
  buyButton.returnValue = "ADS_OFF_PURCHASE_CLICKED"
  buyButton:setImage("EAGLE_SHOPPING_CART_BUTTON")
  bg:addChild(buyButton)
  local birdImage = ui.Image:new({name = "birdImage"})
  birdImage:setImage("GARBAGE_CAN_BIRD")
  bg:addChild(birdImage)
  local ti = ui.Text:new({font = getFontBasic})
  ti.hanchor = "HCENTER"
  ti.vanchor = "BOTTOM"
  ti.text = "TEXT_REMOVE_ADS_UPSELL"
  ti.name = "sellText"
  bg:addChild(ti)
  local ti2 = ui.Text:new({font = getFontBasic})
  ti2.hanchor = "TOP"
  ti2.vanchor = "HCENTER"
  ti2.text = "TEXT_REMOVE_ADS_UPSELL2"
  ti2.name = "sellText2"
  bg:addChild(ti2)
end
function AdsOffPage:onEntry()
  ui.Frame.onEntry(self)
  eventManager:addEventListener(events.EID_ADS_REMOVED, self)
  self.visible = true
end
function AdsOffPage:layout()
  local bg = self:getChild("bg")
  bg.x = 0
  bg.y = 0
  bg.w = screenWidth
  local title = bg:getChild("title")
  title.x = bg.w * 0.5
  title.y = title.py + title.h * 0.1
  local birdImage = self:getChild("birdImage")
  birdImage.x = bg.w / 2
  birdImage.y = screenHeight / 2 + title.y + title.h / 2 - bg:getChild("buyButton").h
  local ti = self:getChild("sellText")
  ti.textBoxSize = bg.w * 0.8
  ti:clip()
  ti.y = birdImage.y - birdImage.h / 2
  ti.x = bg.w * 0.5
  local ti2 = self:getChild("sellText2")
  ti2.textBoxSize = bg.w * 0.8
  ti2.x = bg.w * 0.5
  ti2.y = birdImage.y + birdImage.py
  ti2:clip()
  local buyButton = bg:getChild("buyButton")
  buyButton.x = birdImage.x + birdImage.w * 0.5
  buyButton.y = screenHeight - buyButton.h * 0.55
  local close = bg:getChild("closeButton")
  close.x = birdImage.x - birdImage.w * 0.5
  close.y = buyButton.y
  ui.Frame.layout(self)
end
function AdsOffPage:onPointerEvent(eventType, x, y)
  local result, meta, item = ui.Frame.onPointerEvent(self, eventType, x, y)
  if result == "CLOSE" then
    eventManager:notify({
      id = events.EID_ADS_PURCHASE_CLOSE_CLICKED
    })
  elseif result == "ADS_OFF_PURCHASE_CLICKED" then
    eventManager:notify({
      id = events.EID_ADS_PURCHASE_OFF_CLICKED
    })
  end
  return result, meta, item
end
function AdsOffPage:onKeyEvent(eventType, key)
  if eventType == "RELEASE" and key == "BACK" then
    eventManager:notify({
      id = events.EID_ADS_PURCHASE_CLOSE_CLICKED
    })
  end
end
function AdsOffPage:update(dt, time)
  self.shade = _G.math.min(self.shade + dt * 2, 0.65)
  ui.Frame.update(self, dt, time)
end
function AdsOffPage:draw(x, y)
  drawGame()
  setRenderState(0, 0, 1, 1, 0, 0, 0)
  drawRect(0, 0, 0, 0.65, 0, 0, screenWidth, screenHeight, true)
  ui.Frame.draw(self, x, y)
end
function AdsOffPage:eventTriggered(event)
  if event.id == events.EID_ADS_REMOVED then
    eventManager:notify({
      id = events.EID_ADS_PURCHASE_CLOSE_CLICKED
    })
  end
end
function AdsOffPage:onExit()
  self.visible = false
  eventManager:removeEventListener(events.EID_ADS_REMOVED, self)
  ui.Frame.onExit(self)
end
filename = "AdsOffPage.lua"
