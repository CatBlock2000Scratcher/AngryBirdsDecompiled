function canShowPurchaseHistory()
  return customerString == "verizon" and isPurchaseHistoryImplemented()
end
g_shop_products = {
  {
    name = "Super Seed",
    icon = "SHOP_SUPERSEED",
    button = "SHOP_WINDOW_SUPERSEED",
    tutorial = "TUTORIAL_SUPERSEED",
    message_icon = "WINDOW_SUPERSEED",
    message = "TEXT_POWERUP_RECEIVED_SUPERSEEDS",
    title_image = "SHOP_LOGO_SUPERSEED",
    description = "TEXT_SHOP_SUPER_SEED_DESCRIPTION",
    items = {
      {
        id = "superseed_20x",
        name = "x 20",
        price = {usd = 0.99},
        quantity = {superseed = 20}
      },
      {
        id = "superseed_50x",
        name = "x 50",
        price = {usd = 1.99},
        quantity = {superseed = 50}
      },
      {
        id = "superseed_150x",
        name = "x 150",
        price = {usd = 4.99},
        quantity = {superseed = 150}
      },
      {
        id = "superseed_400x",
        name = "x 400",
        price = {usd = 9.99},
        quantity = {superseed = 400}
      },
      {
        id = "superseed_1000x",
        name = "x 1000",
        price = {usd = 19.99},
        quantity = {superseed = 1000}
      }
    }
  },
  {
    name = "King Sling",
    icon = "SHOP_POWERSLING",
    button = "SHOP_WINDOW_POWERSLING",
    tutorial = "TUTORIAL_POWERSLING",
    message_icon = "WINDOW_KINGSLING",
    message = "TEXT_POWERUP_RECEIVED_KINGSLING",
    title_image = "SHOP_LOGO_KINGSLING",
    description = "TEXT_SHOP_KING_SLING_DESCRIPTION",
    items = {
      {
        id = "kingsling_20x",
        name = "x 20",
        price = {usd = 0.99},
        quantity = {kingsling = 20}
      },
      {
        id = "kingsling_50x",
        name = "x 50",
        price = {usd = 1.99},
        quantity = {kingsling = 50}
      },
      {
        id = "kingsling_150x",
        name = "x 150",
        price = {usd = 4.99},
        quantity = {kingsling = 150}
      },
      {
        id = "kingsling_400x",
        name = "x 400",
        price = {usd = 9.99},
        quantity = {kingsling = 400}
      },
      {
        id = "kingsling_1000x",
        name = "x 1000",
        price = {usd = 19.99},
        quantity = {kingsling = 1000}
      }
    }
  },
  {
    name = "Sling Scope",
    icon = "SHOP_SLINGSCOPE",
    button = "SHOP_WINDOW_SLINGSCOPE",
    tutorial = "TUTORIAL_SLINGSCOPE",
    message_icon = "WINDOW_SLINGSCOPE",
    message = "TEXT_POWERUP_RECEIVED_SLINGSCOPE",
    title_image = "SHOP_LOGO_SLIGNSCOPE",
    description = "TEXT_SHOP_SLING_SCOPE_DESCRIPTION",
    items = {
      {
        id = "slingscope_20x",
        name = "x 20",
        price = {usd = 0.99},
        quantity = {slingscope = 20}
      },
      {
        id = "slingscope_50x",
        name = "x 50",
        price = {usd = 1.99},
        quantity = {slingscope = 50}
      },
      {
        id = "slingscope_150x",
        name = "x 150",
        price = {usd = 4.99},
        quantity = {slingscope = 150}
      },
      {
        id = "slingscope_400x",
        name = "x 400",
        price = {usd = 9.99},
        quantity = {slingscope = 400}
      },
      {
        id = "slingscope_1000x",
        name = "x 1000",
        price = {usd = 19.99},
        quantity = {slingscope = 1000}
      }
    }
  },
  {
    name = "Birdquake",
    icon = "SHOP_BIRDQUAKE",
    button = "SHOP_WINDOW_BIRDQUAKE",
    tutorial = "TUTORIAL_BIRDQUAKE",
    message_icon = "WINDOW_BIRDQUAKE",
    message = "TEXT_POWERUP_RECEIVED_BIRDQUAKE",
    title_image = "SHOP_LOGO_BIRDQUAKE",
    description = "TEXT_SHOP_BIRDQUAKE",
    items = {
      {
        id = "birdquake_20x",
        name = "x 20",
        price = {usd = 0.99},
        quantity = {birdquake = 20}
      },
      {
        id = "birdquake_50x",
        name = "x 50",
        price = {usd = 1.99},
        quantity = {birdquake = 50}
      },
      {
        id = "birdquake_150x",
        name = "x 150",
        price = {usd = 4.99},
        quantity = {birdquake = 150}
      },
      {
        id = "birdquake_400x",
        name = "x 400",
        price = {usd = 9.99},
        quantity = {birdquake = 400}
      },
      {
        id = "birdquake_1000x",
        name = "x 1000",
        price = {usd = 19.99},
        quantity = {birdquake = 1000}
      }
    }
  },
  {
    name = "All-in-One Bundle",
    icon = "SHOP_BUNDLE",
    button = "SHOP_WINDOW_BUNDLE",
    tutorial = "TUTORIAL_BUNDLE",
    message_icon = "SHOP_BUNDLE",
    message = "TEXT_POWERUP_RECIEVED_BUNDLE",
    title_image = "SHOP_LOGO_BUNDLE",
    description = "TEXT_SHOP_ALL-IN-ONE-BUNDLE",
    items = {
      {
        id = "bundle_15x",
        name = "x 15",
        price = {usd = 2.99},
        message_quantity = 15,
        quantity = {
          superseed = 15,
          kingsling = 15,
          slingscope = 15,
          birdquake = 15
        }
      },
      {
        id = "bundle_30x",
        name = "x 30",
        price = {usd = 3.99},
        message_quantity = 30,
        quantity = {
          superseed = 30,
          kingsling = 30,
          slingscope = 30,
          birdquake = 30
        }
      },
      {
        id = "bundle_80x",
        name = "x 80",
        price = {usd = 7.99},
        message_quantity = 80,
        quantity = {
          superseed = 80,
          kingsling = 80,
          slingscope = 80,
          birdquake = 80
        }
      },
      {
        id = "bundle_200x",
        name = "x 200",
        price = {usd = 15.99},
        message_quantity = 200,
        quantity = {
          superseed = 200,
          kingsling = 200,
          slingscope = 200,
          birdquake = 200
        }
      },
      {
        id = "bundle_440x",
        name = "x 440",
        price = {usd = 31.99},
        message_quantity = 440,
        quantity = {
          superseed = 440,
          kingsling = 440,
          slingscope = 440,
          birdquake = 440
        }
      }
    }
  }
}
ProductPage = ui.Frame:new()
function ProductPage:new(o)
  local o = o or {}
  return ui.Frame.new(self, o)
end
function ProductPage:init()
  self.x_offset = 0
  self.selection_init_offset = self.selection_init_offset or 0
  self.selection_offset = 0
  self.new_selection_x = 0
  ui.Frame.init(self)
  local bg = ui.Image:new()
  bg.name = "bg"
  bg:setImage("SHOP_BG_1")
  self:addChild(bg)
  self.backgroundColour = {
    r = 148,
    g = 210,
    b = 247,
    a = 255
  }
  local scroll = ui.ScrollFrame:new()
  scroll.name = "scroll"
  self:addChild(scroll)
  local title = ui.Image:new()
  title.name = "title"
  title:setImage(self.product.title_image)
  self:addChild(title)
  local description_shade = ui.Rect:new()
  description_shade.name = "description_shade"
  description_shade.a = 0.6
  self:addChild(description_shade)
  local description = ui.Text:new()
  description.name = "description"
  description.text = self.product.description
  description:setFont(getFontBasic)
  description.hanchor = "HCENTER"
  description.vanchor = "VCENTER"
  self:addChild(description)
  local top_bar = ui.TiledImage:new()
  top_bar.name = "top_bar"
  top_bar:setImage("SHOP_TOPBAR")
  self:addChild(top_bar)
  local selection = ui.Image:new()
  selection.name = "selection"
  selection:setImage("SHOP_TOPBAR_SELECTION")
  self:addChild(selection)
  local logo = ui.Image:new()
  logo.name = "logo"
  logo:setImage("UI_SHOPLOGO")
  self:addChild(logo)
  for k, v in _G.ipairs(g_shop_products) do
    local product_button = ui.ImageButton:new()
    product_button.name = "product" .. k
    product_button:setImage(v.icon)
    product_button.returnValue = "GOTO_PRODUCT"
    product_button.meta = k
    product_button.activateOnRelease = true
    product_button.clickSound = "menu_confirm"
    self:addChild(product_button)
    local counter_bg = ui.Image:new()
    counter_bg.name = "counter_bg"
    counter_bg:setImage("INGAME_BUTTON_SCOREBAR_SMALLER")
    product_button:addChild(counter_bg)
    local counter = ui.Text:new()
    if deviceModel == "iphone" or deviceModel == "iphone4" then
      counter.font = "FONT_POWERUP_AMOUNT"
    else
      counter.font = "FONT_LS_SMALL"
    end
    counter.name = "counter"
    counter.text = "0"
    counter_bg:addChild(counter)
    if k > 4 then
      counter_bg:setVisible(false)
      counter:setVisible(false)
    end
  end
  for i = 1, #self.product.items do
    local item_button = ui.ImageButton:new()
    item_button.name = "item" .. i
    item_button:setImage(self.product.button)
    item_button.floorCoordinates = false
    item_button.activateOnRelease = true
    scroll:addChild(item_button)
    local label = ui.Text:new()
    label.name = "label"
    label.font = "FONT_SHOP_AMOUNT"
    label.text = self.product.items[i].name
    label.hanchor = "RIGHT"
    label.floorCoordinates = false
    item_button:addChild(label)
    if deviceModel ~= "android" then
      local price_label = ui.Text:new()
      price_label.name = "price_label"
      price_label.font = getFontBasic
      price_label.text = "TEXT_SHOP_PRICE"
      price_label.hanchor = "RIGHT"
      price_label.floorCoordinates = false
      item_button:addChild(price_label)
      local price = ui.Text:new()
      price.name = "price"
      price.font = getFontBasic
      price.text = formatCurrency(self.product.items[i].price.usd, "USD")
      price.hanchor = "LEFT"
      price.floorCoordinates = false
      item_button:addChild(price)
    end
    local buy_button = ui.ImageButton:new()
    buy_button.name = "buy" .. i
    buy_button:setImage("SHOP_PURCHASE")
    buy_button.returnValue = "BUY_PRODUCT"
    buy_button.meta = i
    buy_button.activateOnRelease = true
    buy_button.clickSound = "menu_confirm"
    buy_button.floorCoordinates = false
    item_button:addChild(buy_button)
    local shade = ui.Image:new()
    shade.name = "shade"
    shade:setImage("SHOP_MIDDLEWINDOW_BLEND")
    item_button:addChild(shade)
    local shade2 = ui.Image:new()
    shade2.name = "shade"
    shade2:setImage("SHOP_PURCHASE_BLEND")
    buy_button:addChild(shade2)
  end
  local back_button = ui.ImageButton:new()
  back_button.name = "back_button"
  back_button:setImage("ARROW_LEFT")
  back_button.returnValue = "CLOSE_PRODUCT"
  back_button.attach = "fixed"
  back_button.activateOnRelease = true
  back_button.clickSound = "menu_back"
  self:addChild(back_button)
  local tutorial_button = ui.ImageButton:new()
  tutorial_button.name = "tutorial_button"
  tutorial_button:setImage("MENU_TUTORIALS")
  tutorial_button.returnValue = "SHOW_TUTORIALS"
  tutorial_button.activateOnRelease = true
  tutorial_button.clickSound = "menu_confirm"
  self:addChild(tutorial_button)
  if cheatsEnabled then
    local cheat_button = ui.ImageButton:new()
    cheat_button.name = "cheat_button"
    cheat_button:setImage("BUTTON_EMPTY")
    cheat_button.returnValue = "BUY_PRODUCT_CHEAT"
    cheat_button.meta = 5
    cheat_button.activateOnRelease = true
    cheat_button.clickSound = "menu_confirm"
    self:addChild(cheat_button)
  end
  if canShowPurchaseHistory() then
    local history_button = ui.ImageButton:new()
    history_button.name = "history_button"
    history_button:setImage("BUTTON_HISTORY")
    history_button.returnValue = "GOTO_PURCHASE_HISTORY"
    history_button.activateOnRelease = true
    history_button.clickSound = "menu_confirm"
    self:addChild(history_button)
  end
end
function ProductPage:onEntry()
  ui.Frame.onEntry(self)
  if not self.enter then
    self.state = "STAY"
    self.offset_x = 0
    self.offset_y = 0
    self.timer = 0
  else
    self.state = "ENTER"
    self.timer = 0
    self.enter_duration = 0.2
  end
  self:updatePowerupCounters()
end
function ProductPage:updatePowerupCounters()
  local powerups = {
    "superseed",
    "kingsling",
    "slingscope",
    "birdquake"
  }
  for k, v in _G.ipairs(g_shop_products) do
    local product_button = self:getChild("product" .. k)
    product_button:getChild("counter_bg"):getChild("counter").text = settingsWrapper:getItemAmount(powerups[k])
  end
end
function ProductPage:layout()
  ui.Frame.layout(self)
  local top_bar = self:getChild("top_bar")
  local tbw, tbh = _G.res.getSpriteBounds(top_bar.image)
  top_bar.x = 0
  top_bar.y = 0
  top_bar:setXRepeat(_G.math.ceil(screenWidth / tbw))
  local scroll = self:getChild("scroll")
  local product_interval = 0.6
  if deviceModel == "android" then
    product_interval = 0.575
  end
  local anchors = {}
  for i = 1, #self.product.items do
    _G.table.insert(anchors, i, {
      x = (i - 1) * product_interval * screenWidth,
      y = 0
    })
  end
  scroll:setAnchors(anchors)
  scroll:setClip({
    x = 0,
    y = tbh,
    w = screenWidth,
    h = screenHeight - tbh
  })
  if self.state == "ENTER" then
    self.offset_x = tweenEaseCubicIn(self.timer, -screenWidth * 0.6 * 8, screenWidth * 0.6 * 8, self.enter_duration)
    self.offset_y = tweenEaseCubicIn(self.timer, -screenHeight, screenHeight, self.enter_duration)
  end
  local bg = self:getChild("bg")
  bg.x = 0
  bg.y = screenHeight
  local sw, sh = _G.res.getSpriteBounds(bg.image)
  if sw < screenWidth then
    bg.scaleX = screenWidth / sw
    bg.scaleY = bg.scaleX
  end
  local logo = self:getChild("logo")
  logo.x = 0
  logo.y = 0
  local back_button = self:getChild("back_button")
  back_button.x = back_button.w * 0.5 + g_layoutMargin.x
  back_button.y = screenHeight - back_button.h * 0.5 - g_layoutMargin.y
  local tutorial_button = self:getChild("tutorial_button")
  tutorial_button.x = screenWidth - back_button.x
  tutorial_button.y = back_button.y
  local sw, sh = _G.res.getSpriteBounds("SHOP_TOPBAR")
  for k, v in _G.ipairs(g_shop_products) do
    local product_button = self:getChild("product" .. k)
    product_button.x = screenWidth * 0.6 * (k - 1) * 0.25 + screenWidth * 0.2
    product_button.y = sh * 0.5
    if v == self.product then
      product_button:setEnabled(false)
      local selection = self:getChild("selection")
      selection.x = product_button.x
      selection.y = 0
    end
    local counter_bg = product_button:getChild("counter_bg")
    counter_bg.x = 0
    if deviceModel == "iphone" or deviceModel == "iphone4" then
      counter_bg.y = counter_bg.h * 0.15
    else
      counter_bg.y = 0
    end
    local counter = counter_bg:getChild("counter")
    counter.y = -counter_bg.py + counter_bg.h * 0.5
  end
  local bbsw, _ = _G.res.getSpriteBounds(back_button.image)
  local tbsw, _ = _G.res.getSpriteBounds(tutorial_button.image)
  local description_space = screenWidth - bbsw * 1.2 - tbsw * 1.2
  local title = self:getChild("title")
  local tpx, _ = _G.res.getSpritePivot(title.image)
  local tsw, _ = _G.res.getSpriteBounds(title.image)
  title.x = bbsw * 1.1 + tpx
  title.y = screenHeight * 0.89
  title:setVisible(false)
  local description = self:getChild("description")
  description.x = (bbsw * 1.1 + screenWidth - tbsw * 1.2) * 0.5
  description.textBoxSize = description_space
  description.y = screenHeight * 0.89
  if deviceModel == "android" then
    description.scaleX = 0.79
    description.scaleY = 0.79
  end
  description:clip()
  local description_shade = self:getChild("description_shade")
  description_shade.x = 0
  description_shade.y = _G.math.min(screenHeight * 0.795, screenHeight - description.textBlockHeight)
  description_shade.width = screenWidth
  description_shade.height = screenHeight * 1.1 - description_shade.y
  if canShowPurchaseHistory() then
    local history_button = self:getChild("history_button")
    history_button.x = screenWidth - back_button.x
    history_button.y = back_button.y - history_button.h
  end
  for i = 1, #self.product.items do
    local item_button = self:getChild("item" .. i)
    item_button.x = screenWidth * ((i - 1) * product_interval + 0.5)
    item_button.y = screenHeight * 0.5
    local sw, sh = _G.res.getSpriteBounds(item_button.image)
    local label = item_button:getChild("label")
    label.x = sw * 0.46
    label.y = sh * -0.2
    label.x0 = label.x
    label.y0 = label.y
    if deviceModel ~= "android" then
      local price_label = item_button:getChild("price_label")
      price_label.x = sw * -0.18
      price_label.y = sh * 0.24
      price_label.x0 = price_label.x
      price_label.y0 = price_label.y
      local price = item_button:getChild("price")
      price.x = price_label.x + sw * 0.02
      price.y = price_label.y
      price.x0 = price.x
      price.y0 = price.y
    end
  end
end
function ProductPage:onPointerEvent(eventType, x, y)
  local result, meta, item = ui.Frame.onPointerEvent(self, eventType, x, y)
  if result == "CLOSE_PRODUCT" then
    self:exit()
  elseif result == "BUY_PRODUCT" then
    local function buy_func()
      purchaseItem(g_iap_products[self.product.items[meta].id], function()
        self:purchaseSucceeded(meta)
      end, function(_, status, error)
        self:purchaseFailed(meta, status, error)
      end)
      eventManager:notify({
        id = events.EID_PUSH_FRAME,
        target = PurchasePage:new()
      })
    end
    if deviceModel == "android" and self.product.items[meta].price.usd >= 10 then
      notificationsFrame:addChild(ui.ConfirmPrompt:new({
        title = "You are about to purchase \n" .. self.product.name .. " " .. self.product.items[meta].name .. [[


 Do you wish to proceed?]],
        confirmOnLeft = deviceModel ~= "osx",
        confirm_call = buy_func
      }))
    else
      buy_func()
    end
  elseif result == "BUY_PRODUCT_CHEAT" then
    self:purchaseSucceeded(meta)
  elseif result == "GOTO_PRODUCT" then
    if self.state ~= "EXIT" then
      function self.exit_function()
        eventManager:notify({
          id = events.EID_CHANGE_SCENE,
          target = ProductPage:new({
            from = self.from,
            product = g_shop_products[meta],
            enter = true,
            selection_init_offset = self.selection_offset
          })
        })
      end
      self.exit_duration = 0.2
      self.timer = 0
      self.state = "EXIT"
      self:getChild("scroll").locked = true
      self.new_selection_x = item.x
    end
  elseif result == "GOTO_PURCHASE_HISTORY" then
    eventManager:notify({
      id = events.EID_CHANGE_SCENE,
      target = PurchaseHistory:new({
        from = self.from,
        product = self.product
      })
    })
  elseif result == "SHOW_TUTORIALS" then
    eventManager:notify({
      id = events.EID_CHANGE_SCENE,
      target = PowerupTutorial:new({
        from = self.from,
        product = self.product
      })
    })
  elseif result == "SCROLL_PREVIOUS" then
    self:getChild("scroll"):previous()
  elseif result == "SCROLL_NEXT" then
    self:getChild("scroll"):next()
  end
  return result, meta, item
end
function ProductPage:onKeyEvent(type, key)
  local result, meta, item = ui.Frame.onKeyEvent(self, type, key)
  if not result and type == "RELEASE" and (key == "BACK" or key == "ESCAPE") then
    self:exit()
  end
  return result, meta, item
end
function ProductPage:exit()
  local completion_event, completion_call
  if self.from == "MAIN_MENU" then
    completion_event = {
      id = events.EID_CHANGE_SCENE,
      target = "MAIN_MENU",
      from = "SHOP"
    }
  elseif self.from == "INGAME" then
    function completion_call()
      menuManager:changeRoot(ui.GameHud:new())
      setGameMode(updateGame)
      setPhysicsEnabled(true)
      if deviceModel == "iphone4" or deviceModel == "ipad3" then
        changeResolution = true
        wantedResolution = "FULL"
        g_resetCameras = true
      end
    end
  elseif self.from == "PAUSE" then
    function completion_call()
      local pause = ui.GameHud:new()
      pause:instantlyShowPauseMenu()
      menuManager:changeRoot(pause)
      if deviceModel == "iphone4" or deviceModel == "ipad3" then
        changeResolution = true
        wantedResolution = "FULL"
        g_resetCameras = 1
      end
    end
  end
  local profileName = selectFontProfile()
  eventManager:notify({
    id = events.EID_DO_LOADING,
    items = {
      function()
        _G.res.releaseFont(fontPath .. "/" .. profileName .. "/FONT_SHOP_AMOUNT.dat")
        releaseAssets({"SHOP"})
      end
    },
    completion_event = completion_event,
    completion_call = completion_call
  })
end
function ProductPage:purchaseFailed(item_id, status, error)
  local item = self.product.items[item_id]
  eventManager:notify({
    id = events.EID_IAP_FAILED,
    item = item.id,
    reason = _G.tostring(status) .. "/" .. _G.tostring(error)
  })
  eventManager:notify({
    id = events.EID_POP_FRAME
  })
end
function ProductPage:purchaseSucceeded(item_id)
  local item = self.product.items[item_id]
  for k, v in _G.pairs(item.quantity) do
    settingsWrapper:addItems(k, v)
  end
  local quantity
  if item.message_quantity then
    quantity = item.message_quantity
  else
    local _
    _, quantity = _G.next(item.quantity)
  end
  eventManager:notify({
    id = events.EID_IAP_COMPLETED,
    item = item.id
  })
  eventManager:notify({
    id = events.EID_POP_FRAME
  })
  notificationsFrame:addChild(PowerupReward:new({
    image = self.product.message_icon,
    message = self.product.message,
    amount = quantity,
    initial_shade = 0.65
  }))
  self:updatePowerupCounters()
end
function ProductPage:update(dt, time)
  if self.state == "ENTER" then
    self.timer = _G.math.min(self.timer + dt, self.enter_duration)
    self.offset_x = tweenEaseCubicOut(self.timer, -screenWidth * 0.6 * 8, screenWidth * 0.6 * 8, self.enter_duration)
    self.offset_y = tweenEaseCubicOut(self.timer, -screenHeight, screenHeight, self.enter_duration)
    self.selection_offset = tweenEaseCubicOut(self.timer, -self.selection_init_offset, self.selection_init_offset, self.enter_duration)
    if self.timer >= self.enter_duration then
      self.state = "STAY"
      self.offset_x = 0
      self.offset_y = 0
      self.selection_offset = 0
    end
  elseif self.state == "EXIT" then
    self.timer = _G.math.min(self.timer + dt, self.exit_duration)
    local selection = self:getChild("selection")
    self.offset_x = tweenEaseCubicIn(self.timer, 0, screenWidth * 0.6 * 8, self.exit_duration)
    self.offset_y = tweenEaseCubicIn(self.timer, 0, -screenHeight, self.exit_duration)
    self.selection_offset = tweenEaseCubicIn(self.timer, 0, (self.new_selection_x - selection.x) / 2, self.exit_duration)
    if self.timer >= self.exit_duration then
      self.exit_function()
    end
  end
  ui.Frame.update(self, dt, time)
  local scroll = self:getChild("scroll")
  for i = 1, #self.product.items do
    local button = scroll:getChild("item" .. i)
    local buy = scroll:getChild("buy" .. i)
    dist = _G.math.abs(button.x - scroll:getCurrentX() - screenWidth * 0.5)
    button.scaleX = 1 - 0.4 * (dist / screenWidth)
    button.scaleY = button.scaleX
    local buy_button = button:getChild("buy" .. i)
    if deviceModel == "android" then
      buy_button.x = 0
      buy_button.y = button.h * button.scaleY / 2 - buy_button.h * button.scaleY / 2
    else
      buy_button.x = button.w * button.scaleX / 2 - buy_button.w * button.scaleX / 2 * 1.2
      buy_button.y = button.h * button.scaleY / 2 - buy_button.h * button.scaleY / 2 * 1.2
    end
    local shade = button:getChild("shade")
    shade.alpha = _G.math.min(dist / screenWidth, 1)
    local shade2 = buy:getChild("shade")
    shade2.alpha = shade.alpha
    local label = button:getChild("label")
    label.x = label.x0 * button.scaleX
    label.y = label.y0 * button.scaleY
    if deviceModel ~= "android" then
      local price = button:getChild("price")
      price.x = price.x0 * button.scaleX
      price.y = price.y0 * button.scaleX
      local price_label = button:getChild("price_label")
      price_label.x = price_label.x0 * button.scaleX
      price_label.y = price_label.y0 * button.scaleX
    end
  end
  for i = 1, #self.product.items do
    local scroll = self:getChild("scroll")
    local item_button = scroll:getChild("item" .. i)
    local buy_button = item_button:getChild("buy" .. i)
    if i == scroll:getCurrentAnchor() then
      buy_button:setEnabled(true)
    else
      buy_button:setEnabled(false)
    end
  end
  for i = 1, #self.product.items do
    local scroll = self:getChild("scroll")
    local item_button = scroll:getChild("item" .. i)
    if i == scroll:getCurrentAnchor() - 1 then
      item_button:setEnabled(true)
      item_button.returnValue = "SCROLL_PREVIOUS"
    elseif i == scroll:getCurrentAnchor() + 1 then
      item_button:setEnabled(true)
      item_button.returnValue = "SCROLL_NEXT"
    else
      item_button:setEnabled(false)
    end
  end
end
function ProductPage:draw(x, y)
  for i, v in _G.ipairs(self.children) do
    if v.visible == true then
      if v.name == "description" then
        v:draw(x + self.x, y + self.y - self.offset_y)
      elseif v.name == "selection" then
        v:draw(x + self.x + self.selection_offset, y + self.y)
      elseif v.name == "scroll" or v.name == "title" then
        v:draw(x + self.x, y + self.y + self.offset_y)
      else
        v:draw(x + self.x, y + self.y)
      end
    end
  end
end
PurchasePage = ui.Frame:new()
function PurchasePage:init()
  ui.Frame.init(self)
  local spinner = ui.Image:new()
  spinner.name = "spinner"
  spinner:setImage("IN_APP_LOADING")
  self:addChild(spinner)
  self.spinner_angle = 0
end
function PurchasePage:layout()
  ui.Frame.layout(self)
  local spinner = self:getChild("spinner")
  spinner.x = screenWidth * 0.5
  spinner.y = screenHeight * 0.5
  if isRetinaGraphicsEnabled() then
    spinner.scaleX = 2
    spinner.scaleY = 2
  else
    spinner.scaleY = 1
    spinner.scaleY = 1
  end
end
function PurchasePage:update(dt, time)
  ui.Frame.update(self, dt, time)
  local spinner = self:getChild("spinner")
  self.spinner_angle = self.spinner_angle + dt * 10
  spinner.angle = _G.math.floor(self.spinner_angle / 0.5235983) * 0.5235983
end
function PurchasePage:draw(x, y, scaleX, scaleY, angle)
  setRenderState(0, 0, 1, 1, 0, 0, 0)
  drawRect(0, 0, 0, 0.65, 0, 0, screenWidth, screenHeight, true)
  ui.Frame.draw(self, x, y, scaleX, scaleY, angle)
end
function PurchasePage:onPointerEvent(eventType, x, y)
  if self.no_blocking then
    local result, meta, item = ui.Frame.onPointerEvent(self, eventType, x, y)
    return result, meta, item
  else
    return "BLOCK", nil, self
  end
end
function PurchasePage:onKeyEvent(type, key)
  return "BLOCK", nil, self
end
PurchaseHistory = ui.Frame:new()
function PurchaseHistory:init()
  ui.Frame.init(self)
  local bg = ui.Image:new()
  bg.name = "bg"
  bg:setImage("SHOP_BG_1")
  self:addChild(bg)
  local title = ui.Text:new()
  title.name = "title"
  title.text = "PURCHASE HISTORY"
  title.vanchor = "TOP"
  title.x = screenWidth / 2
  title.y = screenHeight * 0.02
  self:addChild(title)
  local back_button = ui.ImageButton:new()
  back_button.name = "back_button"
  back_button:setImage("ARROW_LEFT")
  back_button.returnValue = "CLOSE_HISTORY"
  back_button.attach = "fixed"
  back_button.activateOnRelease = true
  back_button.clickSound = "menu_back"
  self:addChild(back_button)
  local next_button = ui.ImageButton:new()
  next_button.name = "next_button"
  next_button:setImage("BUTTON_ARROW_RIGHT")
  next_button:setAngle(_G.math.pi / 2)
  next_button.returnValue = "NEXT_PAGE"
  next_button.attach = "fixed"
  next_button.activateOnRelease = true
  self:addChild(next_button)
  local previous_button = ui.ImageButton:new()
  previous_button.name = "previous_button"
  previous_button:setImage("BUTTON_ARROW_LEFT")
  previous_button:setAngle(_G.math.pi / 2)
  previous_button.returnValue = "PREVIOUS_PAGE"
  previous_button.attach = "fixed"
  previous_button.activateOnRelease = true
  self:addChild(previous_button)
  local historyScrollFrame = HistoryScrollFrame:new()
  historyScrollFrame.name = "historyScrollFrame"
  historyScrollFrame.start_y = title.y + title:getFontLeading() * 2
  if g_purchaseHistoryLoaded then
    historyScrollFrame:setText(g_purchaseHistoryText)
  else
    historyScrollFrame:setText("")
  end
  self:addChild(historyScrollFrame)
end
function PurchaseHistory:layout()
  ui.Frame.layout(self)
  local bg = self:getChild("bg")
  bg.x = 0
  bg.y = screenHeight
  local sw, sh = _G.res.getSpriteBounds(bg.image)
  if sw < screenWidth then
    bg.scaleX = screenWidth / sw
    bg.scaleY = bg.scaleX
  end
  local title = self:getChild("title")
  title.x = screenWidth / 2
  title.y = screenHeight * 0.02
  local back_button = self:getChild("back_button")
  back_button.x = back_button.w * 0.5 + g_layoutMargin.x
  back_button.y = screenHeight - back_button.h * 0.5 - g_layoutMargin.y
  local next_button = self:getChild("next_button")
  next_button.x = screenWidth * 0.5 + next_button.w
  next_button.y = screenHeight * 0.8
  local previous_button = self:getChild("previous_button")
  previous_button.x = screenWidth * 0.5 - previous_button.w
  previous_button.y = screenHeight * 0.8
end
function PurchaseHistory:onPointerEvent(eventType, x, y)
  local result, meta, item = ui.Frame.onPointerEvent(self, eventType, x, y)
  if result == "CLOSE_HISTORY" then
    self:exit()
  elseif result == "NEXT_PAGE" then
    self:getChild("historyScrollFrame"):next()
  elseif result == "PREVIOUS_PAGE" then
    self:getChild("historyScrollFrame"):previous()
  end
  return result, meta, item
end
function PurchaseHistory:onKeyEvent(type, key)
  local result, meta, item = ui.Frame.onKeyEvent(self, type, key)
  if not result and type == "RELEASE" and (key == "BACK" or key == "ESCAPE") then
    self:exit()
  end
  return result, meta, item
end
function PurchaseHistory:exit()
  if self.spinner_active then
    eventManager:notify({
      id = events.EID_POP_FRAME
    })
  end
  eventManager:notify({
    id = events.EID_CHANGE_SCENE,
    target = ProductPage:new({
      from = self.from,
      product = self.product
    })
  })
end
function PurchaseHistory:onEntry()
  ui.Frame.onEntry(self)
  eventManager:notify({
    id = events.EID_PUSH_FRAME,
    target = PurchasePage:new({no_blocking = true})
  })
  self.spinner_active = true
  getPurchaseHistory()
end
function PurchaseHistory:update(dt, time)
  ui.Frame.update(self, dt, time)
  if g_purchaseHistoryLoaded and self.spinner_active then
    local history = self:getChild("historyScrollFrame")
    history:setText(g_purchaseHistoryText)
    eventManager:notify({
      id = events.EID_POP_FRAME
    })
    self.spinner_active = false
  end
  local historyScrollFrame = self:getChild("historyScrollFrame")
  local currentAnchor = historyScrollFrame:getCurrentAnchor()
  if self.last_anchor ~= currentAnchor then
    local next_button = self:getChild("next_button")
    local previous_button = self:getChild("previous_button")
    if currentAnchor == #historyScrollFrame.anchors then
      next_button.visible = false
    else
      next_button.visible = true
    end
    if currentAnchor == 1 then
      previous_button.visible = false
    else
      previous_button.visible = true
    end
    self.last_anchor = currentAnchor
  end
end
HistoryScrollFrame = ui.ScrollFrame:new()
function HistoryScrollFrame:init()
  ui.ScrollFrame.init(self)
  self.old_text = ""
  self.longest_lines = {
    0,
    0,
    0,
    0
  }
  self.purchased_items = {}
  self.scroll_axis = "y"
  self.line_height = 1
  self.start_y = self.start_y or 0
end
function HistoryScrollFrame:setText(text)
  local history = ui.Text:new()
  history.text = text
  history:clip()
  self.purchased_items = {}
  self.longest_lines = {
    0,
    0,
    0,
    0
  }
  self.line_height = history:getFontLeading()
  for i = 1, #history.lines do
    local start_index = 1
    local item_info = {}
    local line = history.lines[i].text
    for k = 1, 4 do
      local end_index, _ = _G.string.find(line, "\t", start_index)
      local item
      if end_index ~= nil then
        item = ui.Text:new({
          text = _G.string.sub(line, start_index, end_index - 1)
        })
        start_index = end_index + 1
      else
        item = ui.Text:new({
          text = _G.string.sub(line, start_index)
        })
      end
      if item.width > self.longest_lines[k] then
        self.longest_lines[k] = item.width
      end
      _G.table.insert(item_info, k, item)
      self:addChild(item)
    end
    _G.table.insert(self.purchased_items, i, item_info)
  end
  self:layout()
end
function HistoryScrollFrame:layout()
  if self.last_screenHeight ~= screenHeight then
    self:resetState()
    self.last_screenHeight = screenHeight
  end
  local max_height = screenHeight * 0.5
  local max_lines = _G.math.floor(max_height / self.line_height)
  local page_height = self.line_height * max_lines
  local anchors = {}
  local lines = #self.purchased_items or 1
  local anchorAmount = _G.math.max(_G.math.ceil(lines / max_lines), 1)
  for i = 1, anchorAmount do
    _G.table.insert(anchors, i, {
      x = 0,
      y = (i - 1) * page_height
    })
  end
  self:setAnchors(anchors)
  local y_margin = self.start_y + screenHeight * 0.02 + self.line_height / 2
  local x_margin = screenWidth * 0.02
  local x_spacing = screenWidth / 4 / 2
  for i, v in _G.ipairs(self.purchased_items) do
    local field_amount = #self.purchased_items[1]
    for k = 1, field_amount do
      if k == 1 then
        v[k].hanchor = "LEFT"
        v[k].x = x_margin
      elseif k == field_amount then
        v[k].hanchor = "RIGHT"
        v[k].x = screenWidth - x_margin
      elseif k <= field_amount / 2 then
        v[k].x = v[k - 1].x + self.longest_lines[k - 1] + x_margin
        v[k].hanchor = "LEFT"
      else
        v[k].x = screenWidth - x_margin - self.longest_lines[k + 1] - x_margin
        v[k].hanchor = "RIGHT"
      end
      v[k].y = y_margin + self.line_height * (i - 1)
    end
  end
  self:setClip({
    x = 0,
    y = self.start_y + screenHeight * 0.02,
    w = screenWidth,
    h = page_height
  })
end
PowerupTutorial = ui.Frame:new()
function PowerupTutorial:init()
  ui.Frame.init(self)
  local bg = ui.Image:new()
  bg.name = "bg"
  bg:setImage("SHOP_BG_1")
  self:addChild(bg)
  local scroll = ui.ScrollFrame:new()
  scroll.name = "scroll"
  self:addChild(scroll)
  for k, v in _G.ipairs(g_shop_products) do
    local product_tutorial = ui.ImageButton:new()
    product_tutorial.name = "tutorial" .. k
    product_tutorial:setImage(v.tutorial)
    product_tutorial.returnValue = "CLICKED_" .. v.tutorial
    product_tutorial.activateOnRelease = true
    scroll:addChild(product_tutorial)
    if self.product == v then
      self.product_index = k
    end
  end
  local back_button = ui.ImageButton:new()
  back_button.name = "back_button"
  back_button:setImage("ARROW_LEFT")
  back_button.returnValue = "CLOSE_TUTORIAL"
  back_button.attach = "fixed"
  back_button.activateOnRelease = true
  back_button.clickSound = "menu_back"
  self:addChild(back_button)
  local left_button = ui.ImageButton:new()
  left_button.name = "left_button"
  left_button:setImage("BUTTON_ARROW_LEFT")
  left_button.returnValue = "SCROLL"
  left_button.meta = 1
  self:addChild(left_button)
  local right_button = ui.ImageButton:new()
  right_button.name = "right_button"
  right_button:setImage("BUTTON_ARROW_RIGHT")
  right_button.returnValue = "SCROLL"
  right_button.meta = -1
  self:addChild(right_button)
  for i = 1, #g_shop_products do
    local dot = ui.Image:new()
    dot.name = "dot" .. i
    dot:setImage("LS_DOT_BLACK")
    self:addChild(dot)
    local pageNumber = ui.Text:new()
    pageNumber.name = "pageNumber" .. i
    pageNumber.font = "FONT_LS_SMALL"
    pageNumber.visible = false
    pageNumber.text = _G.tostring(i)
    self:addChild(pageNumber)
  end
end
function PowerupTutorial:layout()
  ui.Frame.layout(self)
  local bg = self:getChild("bg")
  bg.x = 0
  bg.y = screenHeight
  local sw, sh = _G.res.getSpriteBounds(bg.image)
  if sw < screenWidth then
    bg.scaleX = screenWidth / sw
    bg.scaleY = bg.scaleX
  end
  local back_button = self:getChild("back_button")
  back_button.x = back_button.w * 0.5 + g_layoutMargin.x
  back_button.y = screenHeight - back_button.h * 0.5 - g_layoutMargin.y
  local border, _ = _G.res.getSpriteBounds("BUTTON_ARROW_LEFT") + g_layoutMargin.x, nil
  local scroll = self:getChild("scroll")
  local anchors = {}
  for i = 1, #g_shop_products do
    _G.table.insert(anchors, i, {
      x = (i - 1) * screenWidth * 0.7,
      y = 0
    })
    local product_tutorial = self:getChild("tutorial" .. i)
    product_tutorial.x = screenWidth * 0.5 + (i - 1) * screenWidth * 0.7
    product_tutorial.y = screenHeight * 0.4
  end
  scroll:setAnchors(anchors)
  scroll:setClip({
    x = border,
    y = 0,
    w = screenWidth - border * 2,
    h = screenHeight
  })
  scroll:setCurrentAnchor(find_key(g_shop_products, self.product))
  local left_button = self:getChild("left_button")
  local right_button = self:getChild("right_button")
  local sw, sh = _G.res.getSpriteBounds(left_button.image)
  left_button.x = sw * 0.5 + g_layoutMargin.x
  left_button.y = screenHeight * 0.5
  right_button.x = screenWidth - sw * 0.5 - g_layoutMargin.x
  right_button.y = screenHeight * 0.5
  local dot_y = 10
  local dot_spacing = 15
  local first_dot_x = screenWidth * 0.5 - (#g_shop_products - 1) * 0.5 * dot_spacing
  local text_y = 0.03 * screenHeight + 12
  for i = 1, #g_shop_products do
    local dot = self:getChild("dot" .. i)
    dot.x = first_dot_x + dot_spacing * (i - 1)
    dot.y = screenHeight - dot_y - g_layoutMargin.y
    local pageNumber = self:getChild("pageNumber" .. i)
    pageNumber.x = dot.x
    pageNumber.y = screenHeight - text_y - g_layoutMargin.y
  end
end
function PowerupTutorial:onPointerEvent(eventType, x, y)
  local result, meta, item = ui.Frame.onPointerEvent(self, eventType, x, y)
  if result == "CLOSE_TUTORIAL" then
    self:exit()
  elseif result == "SCROLL" then
    if meta < 0 then
      self:getChild("scroll"):next()
    else
      self:getChild("scroll"):previous()
    end
  elseif result == "CLICKED_TUTORIAL_SUPERSEED" then
    if not _G.res.isAudioPlaying(getAudioName("big_bird")) then
      _G.res.playAudio(getAudioName("big_bird"), 1, false)
    end
  elseif result == "CLICKED_TUTORIAL_POWERSLING" then
    if not _G.res.isAudioPlaying(getAudioName("super_shot")) then
      _G.res.playAudio("super_shot", 1, false)
    end
  elseif result == "CLICKED_TUTORIAL_SLINGSCOPE" then
    if not _G.res.isAudioPlaying(getAudioName("laser_sight")) then
      _G.res.playAudio("laser_sight", 1, false)
    end
  elseif result == "CLICKED_TUTORIAL_BIRDQUAKE" then
    if not _G.res.isAudioPlaying(getAudioName("earthquake")) then
      _G.res.playAudio(getAudioName("earthquake"), 1, false)
    end
  elseif result == "CLICKED_TUTORIAL_BUNDLE" and not _G.res.isAudioPlaying(getAudioName("powerup_intro")) then
    _G.res.playAudio(getAudioName("powerup_intro"), 1, false)
  end
  return result, meta, item
end
function PowerupTutorial:onKeyEvent(type, key)
  local result, meta, item = ui.Frame.onKeyEvent(self, type, key)
  if not result and type == "RELEASE" and (key == "BACK" or key == "ESCAPE") then
    self:exit()
  end
  return result, meta, item
end
function PowerupTutorial:exit()
  eventManager:notify({
    id = events.EID_CHANGE_SCENE,
    target = ProductPage:new({
      from = self.from,
      product = self.product
    })
  })
end
function PowerupTutorial:update(dt, time)
  local scroll = self:getChild("scroll")
  local old_index = scroll:getCurrentAnchor()
  ui.Frame.update(self, dt, time)
  local index = scroll:getCurrentAnchor()
  self:getChild("left_button"):setVisible(index > 1)
  self:getChild("right_button"):setVisible(index < #g_shop_products)
  self.product = g_shop_products[index]
  self.product_index = index
  if old_index ~= index then
    self:refreshDots(index, old_index)
  end
end
function PowerupTutorial:onEntry()
  ui.Frame.onEntry(self)
  self:refreshDots(self.product_index, self.product_index)
end
function PowerupTutorial:refreshDots(index, old_index)
  local new_dot = self:getChild("dot" .. index)
  if new_dot ~= nil then
    self:getChild("dot" .. old_index):setImage("LS_DOT_BLACK")
    self:getChild("pageNumber" .. old_index).visible = false
    new_dot:setImage("LS_DOT_WHITE")
    self:getChild("pageNumber" .. index).visible = false
  end
end
filename = "shop.lua"
