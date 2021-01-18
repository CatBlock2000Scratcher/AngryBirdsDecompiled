AdsSubSystem = subsystems.SubSystem:new()
currentFrame = 0
FULLSCREEN_ADS_TIMER = 300
if releaseBuild ~= true and cheatsEnabled == true then
  FULLSCREEN_ADS_TIMER = 30
end
function AdsSubSystem:eventTriggered(event)
  if settingsWrapper:isPremium() then
    return
  end
  if event.id == events.EID_LEVEL_LOADING_DONE then
  end
  if event.id == events.EID_MENUMANAGER_ROOT_CHANGED and event.root ~= nil then
    if _G.string.find(event.root.name, "^LevelSelection") then
      hideAd()
    end
    if event.root.name == "LevelEndRoot" or event.root.name == "MEPage" then
      hideAd()
    end
    if event.root.name == "AdsOffPage" then
      hideAd()
    end
  end
  if event.id == events.EID_ROVIO_NEWS_SHOWN then
    self.showAdNotAllowedAtPausemenu = true
  end
  if event.id == events.EID_GOTO_GAME then
    if currentFrame == nil then
      showAdFrame = 10
    else
      showAdFrame = currentFrame + 10
    end
  end
  if event.id == events.EID_GAME_INITIALIZED then
    self.bannerWidth = 320 * (event.screenWidth / 320)
    self.bannerHeight = 48 * (event.screenHeight / 320)
    isShowingAd = false
    if shouldShowAd() then
      requestAd()
      requestExpandableAd()
      notifyEventManager(events.EID_AD_REQUESTED, {type = "banner"})
      notifyEventManager(events.EID_AD_REQUESTED, {type = "expandable"})
      adRequested = true
    end
    local isAndroid, isHD = subsystemsapi:isAndroid()
    if isAndroid and isHD then
      self.bannerHeight = 48
    end
  end
end
function AdsSubSystem:update(dt, time)
  if currentGameMode == updateGame then
    currentFrame = currentFrame + 1
  end
  if shouldShowAd() then
    local adDuration = 15
    local animationDuration = 0.7
    if isShowingAd == true and isHidingAd ~= true and adDuration < time - lastAdTime then
      adHidingStartedTime = time
      hideAd()
    end
    if isHidingAd == true and isShowingAd == true and adHidingStartedTime ~= nil then
      self.scoreAdOffsetY = self.bannerHeight - self.bannerHeight * (time - adHidingStartedTime) / animationDuration
    elseif isHidingAd ~= true and isShowingAd == true then
      self.scoreAdOffsetY = self.bannerHeight * (_G.math.min(time - adShowingStartedTime, animationDuration) / animationDuration)
    elseif isShowingAd ~= true then
      self.scoreAdOffsetY = 0
    end
    if videoAdRequested ~= true and videoReady ~= true and time - lastVideoAdTime > FULLSCREEN_ADS_TIMER then
      requestVideoAd()
      videoAdRequested = true
      notifyEventManager(events.EID_AD_REQUESTED, {
        type = "interstitial"
      })
      print("Requesting next video ad\n")
    end
    if self.expandableTimer ~= nil then
      self.expandableTimer = self.expandableTimer - dt
      if 0 > self.expandableTimer then
        requestExpandableAd()
        notifyEventManager(events.EID_AD_REQUESTED, {type = "expandable"})
        self.expandableTimer = nil
      end
    end
    if showAdFrame ~= nil and currentFrame ~= nil and currentFrame >= showAdFrame then
      if videoReady then
        showVideoAd()
      elseif expandableAdReady then
        if isExpandableShowAllowed() then
          if showingAd and not isHidingAd then
            hideAd()
          end
          eventManager:notify({
            id = events.EID_FULLSCREEN_AD_SHOWING
          })
          showExpandableAd()
          notifyEventManager(events.EID_AD_SERVED, {type = "expandable"})
          showingExpandableAd = true
          expandableAdReady = false
        end
        adSystem.expandableTimer = FULLSCREEN_ADS_TIMER
      elseif not showingExpandableAd then
        showAd()
      end
      showAdFrame = nil
    end
  end
end
function showAd()
  if shouldShowAd() then
    print("Trying to show ad\n")
    if isShowingAd == true then
      print("Still showing previous ad, reseting ad timer\n")
      lastAdTime = time
    elseif adRequested == true then
      adSystem.scoreAdOffsetY = 0
      print("Still requesting ad, doing nothing\n")
    elseif adReady == true then
      adReady = false
      isShowingAd = true
      isHidingAd = false
      lastAdTime = time
      adShowingStartedTime = time
      showAdvertisement()
      adSystem.scoreAdOffsetY = 0
      print("showing ad\n")
      eventManager:notify({
        id = events.EID_AD_READY
      })
      notifyEventManager(events.EID_AD_SERVED, {type = "banner"})
    elseif adRequested ~= true then
      print("No ad ready and not requesting ad, requesting now.\n")
      requestAd()
      notifyEventManager(events.EID_AD_REQUESTED, {type = "banner"})
      adRequested = true
      adSystem.scoreAdOffsetY = 0
    end
  end
end
function requestAdSuccesful()
  print("requestAdSuccesful\n")
  adReady = true
  adRequested = false
end
function requestAdFailed()
  print("requestAdFailed\n")
  adRequested = false
end
function hideAd()
  print("Trying to hide ad\n")
  if isShowingAd == true and isHidingAd ~= true then
    hideAdvertisement()
    isHidingAd = true
    print("hideAd\n")
  end
end
function startAdTimer()
  isShowingAd = true
  lastAdTime = time
  print("Starting Ad Timer, starting to show ad\n")
end
function showVideoAd()
  print("Checking if it's time for video ad\n")
  if videoReady == true and isShowingAd ~= true then
    print("Show video\n")
    showVideoAdvertisement()
    lastVideoAdTime = time
    videoAdRequested = false
    notifyEventManager(events.EID_AD_SERVED, {
      type = "interstitial"
    })
  end
end
function fullScreenAdDismissed()
  print("Fullscreen ad dismissed.\n")
  adSystem.scoreAdOffsetY = 0
  eventManager:notify({
    id = events.EID_FULLSCREEN_AD_DISMISSED
  })
  if currentGameMode == updateGame and _G.res.isAudioPlaying(currentMainMenuSong) == true then
    _G.res.stopAudio(currentMainMenuSong)
  end
end
function fullScreenVideoDismissed()
  fullScreenAdDismissed()
end
function isBannerShowAllowed()
  if subsystemsapi:isPauseMenuVisible() and adSystem.showAdNotAllowedAtPausemenu then
    return false
  end
  return shouldShowAd()
end
function isExpandableShowAllowed()
  if subsystemsapi:isPauseMenuVisible() then
    return false
  end
  return shouldShowAd()
end
function shouldShowAd()
  if menuManager ~= nil and menuManager:getRoot() ~= nil then
    local rootName = menuManager:getRoot().name
    if rootName == "MEPage" or rootName == "AdsOffPage" or rootName == "LevelEndRoot" or subsystemsapi:isPauseMenuVisible() then
      return false
    end
  end
  return (isLiteVersion == true and (deviceModel == "iphone" or deviceModel == "iphone4" or deviceModel == "ipad" or deviceModel == "ipad3") or deviceModel == "android") and not settingsWrapper:isPremium()
end
function onExpandableAdReady()
  expandableAdReady = true
  adSystem.expandableTimer = nil
end
function onExpandableAdRequestFailed()
  adSystem.expandableTimer = FULLSCREEN_ADS_TIMER
end
function onExpandableAdWillExpand()
end
function onExpandableAdWasHidden()
  showingExpandableAd = false
  adSystem.expandableTimer = FULLSCREEN_ADS_TIMER
  eventManager:notify({
    id = events.EID_FULLSCREEN_AD_DISMISSED
  })
end
filename = "adsSubsystem.lua"
