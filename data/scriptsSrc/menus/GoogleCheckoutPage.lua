GoogleCheckoutPage = ui.Frame:new()
function GoogleCheckoutPage:init()
  ui.Frame.init(self)
  self.shade = self.shade or 0
  local bg = ui.Image:new({name = "bg"})
  bg:setImage("CHALLENGE_LIST_SHADOW_MIDDLE")
  self:addChild(bg)
  local operatorCheckout = ui.ImageButton:new({
    name = "operatorCheckout",
    returnValue = "OPERATOR_CHECKOUT"
  })
  operatorCheckout:setImage("PAYMENT_OPERATOR_BTN")
  bg:addChild(operatorCheckout)
  local googleCheckout = ui.ImageButton:new({
    name = "googleCheckout",
    returnValue = "GOOGLE_CHECKOUT"
  })
  googleCheckout:setImage("PAYMENT_GOOGLE_WALLET_BTN")
  bg:addChild(googleCheckout)
  local closeButton = ui.ImageButton:new({
    name = "closeButton"
  })
  closeButton.returnValue = "CLOSE"
  closeButton:setImage("BUTTON_UPSELL_NO")
  closeButton.clickSound = "menu_back"
  bg:addChild(closeButton)
end
function GoogleCheckoutPage:onEntry()
  ui.Frame.onEntry(self)
  self.visible = true
end
function GoogleCheckoutPage:layout()
  local bg = self:getChild("bg")
  bg:setSize(screenWidth, screenHeight)
  bg.x = screenWidth * 0.5 - bg.w * 0.5
  bg.y = 0
  local close = bg:getChild("closeButton")
  close.x = close.px
  close.y = screenHeight - close.h / 2
  local googleCheckout = self:getChild("googleCheckout")
  googleCheckout.x = screenWidth * 0.5 - googleCheckout.w * 0.6
  googleCheckout.y = screenHeight * 0.5
  local operatorCheckout = self:getChild("operatorCheckout")
  operatorCheckout.x = screenWidth * 0.5 + operatorCheckout.w * 0.6
  operatorCheckout.y = screenHeight * 0.5
  ui.Frame.layout(self)
end
function GoogleCheckoutPage:onPointerEvent(eventType, x, y)
  local result, meta, item = ui.Frame.onPointerEvent(self, eventType, x, y)
  if result == "CLOSE" then
    eventManager:notify({
      id = events.EID_GOOGLE_CHECKOUT_CLOSE_CLICKED,
      inGame = self.inGame
    })
  elseif result == "OPERATOR_CHECKOUT" then
    eventManager:notify({
      id = events.EID_OPERATOR_CHECKOUT_CLICKED,
      item = self.purchaseItem,
      inGame = self.inGame
    })
  elseif result == "GOOGLE_CHECKOUT" then
    eventManager:notify({
      id = events.EID_GOOGLE_CHECKOUT_CLICKED,
      item = self.purchaseItem,
      inGame = self.inGame
    })
  end
  return result, meta, item
end
function GoogleCheckoutPage:update(dt, time)
  self.shade = _G.math.min(self.shade + dt * 2, 0.65)
  ui.Frame.update(self, dt, time)
end
function GoogleCheckoutPage:draw(x, y)
  if self.inGame == true then
    drawGame()
  end
  ui.Frame.draw(self, x, y)
end
function GoogleCheckoutPage:onExit()
  self.visible = false
  ui.Frame.onExit(self)
end
filename = "GoogleCheckoutPage.lua"
