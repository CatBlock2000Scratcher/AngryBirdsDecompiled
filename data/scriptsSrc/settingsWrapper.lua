settingsWrapper = {}
if ABIDEnabled ~= true then
  localSettings = settings
  purchases = settings
else
  localSettings = localSettings or {}
  purchases = purchases or {}
end
function settingsWrapper:setPremium(premium)
  purchases.isPremium = premium
end
function settingsWrapper:isPremium()
  return purchases.isPremium
end
function settingsWrapper:isBoomerangBirdAchieved()
  return settings.boomerangBirdAchieved
end
function settingsWrapper:setBoomerangBirdAchieved()
  settings.boomerangBirdAchieved = true
end
function settingsWrapper:isBoomerangBird2Achieved()
  return settings.boomerangBirdAchieved2
end
function settingsWrapper:setBoomerangBird2Achieved()
  settings.boomerangBirdAchieved2 = true
end
function settingsWrapper:getEagleUsedTime()
  return localSettings.eagleUsedTime
end
function settingsWrapper:setEagleUsedTime(t)
  loginfo(" Eagle used time set to " .. _G.tostring(t))
  localSettings.eagleUsedTime = t
end
function settingsWrapper:getEagleUsedIn()
  if localSettings.eaglesUsedIn == nil then
    localSettings.eaglesUsedIn = {}
  end
  return localSettings.eaglesUsedIn
end
function settingsWrapper:resetEaglesUsedIn()
  localSettings.eaglesUsedIn = {}
end
function settingsWrapper:removeEagleUsedInLevel(levelName)
  local index
  if levelName == nil then
    return
  end
  for i, v in _G.ipairs(localSettings.eaglesUsedIn) do
    if v.level == levelName then
      index = i
    end
  end
  if index ~= nil then
    _G.table.remove(localSettings.eaglesUsedIn, i)
    return true
  end
  return false
end
function settingsWrapper:setEagleUsedInLevel(levelName)
  if localSettings.eaglesUsedIn == nil then
    localSettings.eaglesUsedIn = {}
  end
  if levelName ~= nil then
    _G.table.insert(localSettings.eaglesUsedIn, {level = levelName})
  end
end
function settingsWrapper:getCumulativeStars()
  return settings.cumulativeStars
end
function settingsWrapper:setCumulativeStars(stars)
  settings.cumulativeStars = stars
end
function settingsWrapper:getSettingsVersion()
  return settings.settingsVersion or {id = 0, version = "pre-2.0"}
end
function settingsWrapper:convertSettings()
  if settingsWrapper:getSettingsVersion().id == 0 then
    if settings.openGoldenEggLevels ~= nil then
      local oldGoldenEggs = settings.openGoldenEggLevels
      settings.openGoldenEggLevels = {}
      for k, v in _G.pairs(oldGoldenEggs) do
        if _G.type(v) == "number" then
          for i = 1, 26 do
            if k == "Level" .. i then
              local page, level_number
              if i <= 15 then
                page = 1
                level_number = i
              else
                page = 2
                level_number = i - 15
              end
              local level = g_episodes.G.pages[page].levels[level_number]
              local level_entry
              if v == 0 then
                level_entry = {unlocked = true, opened = false}
              elseif v == 1 or v == 2 then
                level_entry = {unlocked = true, opened = true}
              end
              settings.openGoldenEggLevels[level.name] = level_entry
            end
          end
        else
          settings.openGoldenEggLevels[k] = v
        end
      end
      for i = 1, #g_episodes.G.pages do
        for j = 1, #g_episodes.G.pages[i].levels do
          local level = g_episodes.G.pages[i].levels[j]
          if not settings.openGoldenEggLevels[level.name] then
            settings.openGoldenEggLevels[level.name] = {unlocked = false, opened = false}
          end
        end
      end
    end
    if settings.gameCompleted then
      settings.theme3Completed = true
    end
    if settings.lastOpenLevel then
      settings.lastOpenLevelLP1 = settings.lastOpenLevel
    end
    settings.eaglesUsedIn = nil
    settings.eagleUsedTime = nil
    if settings.gameStarted then
      settingsWrapper:setCutsceneWatched("pack1_intro")
    end
    for i = 2, 6 do
      if settings["lp" .. i .. "Started"] then
        settingsWrapper:setCutsceneWatched("pack" .. i .. "_intro")
      end
    end
    settings.settingsVersion = {id = 1, version = "2.0"}
    if ABIDEnabled then
      ABIDUtils.convertSettings()
    end
  end
end
function settingsWrapper:getWilhelmTell()
  return settings.wilhelmTell or false
end
function settingsWrapper:setWilhelmTell()
  settings.wilhelmTell = true
end
function settingsWrapper:getBullsEye()
  return settings.bullsEye or false
end
function settingsWrapper:setBullsEye()
  settings.bullsEye = true
end
function settingsWrapper:getWoodBlocksDestroyed()
  return settings.woodBlocksDestroyed or 0
end
function settingsWrapper:setWoodBlocksDestroyed(blocks)
  settings.woodBlocksDestroyed = blocks
end
function settingsWrapper:getRockBlocksDestroyed()
  return settings.rockBlocksDestroyed or 0
end
function settingsWrapper:setRockBlocksDestroyed(blocks)
  settings.rockBlocksDestroyed = blocks
end
function settingsWrapper:getIceBlocksDestroyed()
  return settings.iceBlocksDestroyed or 0
end
function settingsWrapper:setIceBlocksDestroyed(blocks)
  settings.iceBlocksDestroyed = blocks
end
function settingsWrapper:getStalaktitesDestroyed()
  return settings.stalaktitesDestroyed or 0
end
function settingsWrapper:incrementStalaktitesDestroyed()
  if settings.stalaktitesDestroyed == nil then
    settings.stalaktitesDestroyed = 0
  end
  settings.stalaktitesDestroyed = settings.stalaktitesDestroyed + 1
end
function settingsWrapper:getJewelsDestroyed()
  return settings.jewelsDestroyed or 0
end
function settingsWrapper:incrementJewelsDestroyed()
  if settings.jewelsDestroyed == nil then
    settings.jewelsDestroyed = 0
  end
  settings.jewelsDestroyed = settings.jewelsDestroyed + 1
end
function settingsWrapper:getPigsDestroyed()
  return settings.pigsDestroyed or 0
end
function settingsWrapper:incrementPigsDestroyed()
  if settings.pigsDestroyed == nil then
    settings.pigsDestroyed = 0
  end
  settings.pigsDestroyed = settings.pigsDestroyed + 1
end
function settingsWrapper:getTutorials()
  if settings.tutorials == nil then
    settings.tutorials = {}
  end
  return settings.tutorials
end
function settingsWrapper:getTutorialsForItem(tutorial_item)
  return settingsWrapper:getTutorials()[tutorial_item]
end
function settingsWrapper:createTutorialForItem(tutorial_item, sprite, extra_tutorial)
  local tutorials = settingsWrapper:getTutorials()
  tutorials[tutorial_item] = {sprite = sprite}
  if extra_tutorial then
    tutorials[tutorial_item].showHelp = true
  end
end
function settingsWrapper:setExtraTutorialShown(tutorial_item)
  local tutorial = settingsWrapper:getTutorialsForItem(tutorial_item)
  if tutorial and tutorial.showHelp then
    tutorial.showHelp = false
  end
end
function settingsWrapper:resetMightyEagle()
  local tutorials = settingsWrapper:getTutorials()
  tutorials.BAIT_SARDINE = nil
  purchases.mightyEagleEnabled = nil
end
function settingsWrapper:isEpisodeThreeStarred(episode)
  return settings["threeStarsLP" .. episode] or false
end
function settingsWrapper:setEpisodeThreeStarred(episode)
  settings["threeStarsLP" .. episode] = true
end
function settingsWrapper:isThemeCompleted(theme)
  return settings["theme" .. theme .. "Completed"] or false
end
function settingsWrapper:setThemeCompleted(theme)
  if _G.tonumber(theme) and _G.math.floor(_G.tonumber(theme)) > 0 then
    settings["theme" .. _G.math.floor(_G.tonumber(theme)) .. "Completed"] = true
  end
end
function settingsWrapper:getGoldenEgg(level)
  if settings.openGoldenEggLevels == nil then
    settings.openGoldenEggLevels = {}
  end
  if settings.openGoldenEggLevels[level] == nil then
    settings.openGoldenEggLevels[level] = {unlocked = false, opened = false}
  end
  return settings.openGoldenEggLevels[level]
end
function settingsWrapper:setGoldenEggPlayed(level)
  settingsWrapper:getGoldenEgg(level).opened = true
end
function settingsWrapper:isGoldenEggPlayed(level)
  return settingsWrapper:getGoldenEgg(level).opened
end
function settingsWrapper:isGoldenEggUnlocked(level)
  return settingsWrapper:getGoldenEgg(level).unlocked
end
function settingsWrapper:unlockGoldenEgg(level)
  settingsWrapper:getGoldenEgg(level).unlocked = true
end
function settingsWrapper:restoreGoldenEggsFromHighscores()
  if g_episodes.G ~= nil then
    for i = 1, #g_episodes.G.pages do
      for j = 1, #g_episodes.G.pages[i].levels do
        local level = g_episodes.G.pages[i].levels[j]
        if highscores[level.name] then
          settingsWrapper:unlockGoldenEgg(level.name)
          if highscores[level.name].completed then
            settingsWrapper:setGoldenEggPlayed(level.name)
          end
        end
      end
    end
  end
end
function settingsWrapper:getLastRewardDate()
  return settings.lastDailyRewardTime or {
    year = 0,
    month = 0,
    day = 0,
    hour = 0,
    minutes = 0,
    seconds = 0
  }
end
function settingsWrapper:setLastRewardDate(time)
  local reward_date = time
  reward_date.hour = 0
  reward_date.minutes = 0
  reward_date.seconds = 0
  settings.lastDailyRewardTime = time
end
function settingsWrapper:getDailyRewardStreak()
  return settings.dailyRewardStreak or 0
end
function settingsWrapper:setDailyRewardStreak(streak)
  settings.dailyRewardStreak = streak
end
function settingsWrapper:toggleChildlock()
  if settings.shopChildlockOn then
    settings.shopChildlockOn = not settings.shopChildlockOn
  else
    settings.shopChildlockOn = true
  end
end
function settingsWrapper:isChildlockOn()
  return settings.shopChildlockOn or false
end
function settingsWrapper:setMightyEagleUpsellPageViewed()
  settings.mightyEagleUpsellPageViewed = true
end
function settingsWrapper:isMightyEagleUpsellPageViewed()
  return settings.mightyEagleUpsellPageViewed or false
end
function settingsWrapper:setMightyEagleEnabled()
  purchases.mightyEagleEnabled = true
end
function settingsWrapper:isMightyEagleEnabled()
  return purchases.mightyEagleEnabled or false
end
function settingsWrapper:isIAPRestoreChecked()
  return settings.iap_restore_checked or false
end
function settingsWrapper:setIAPRestoreChecked()
  settings.iap_restore_checked = true
end
function settingsWrapper:isGfxLowQuality()
  return localSettings.gfxLowQuality or false
end
function settingsWrapper:toggleGfxLowQuality()
  if localSettings.gfxLowQuality == nil then
    localSettings.gfxLowQuality = true
  else
    localSettings.gfxLowQuality = not localSettings.gfxLowQuality
  end
end
function settingsWrapper:isFlurryFirstTimeLevelCollected()
  return settings.flurryFirstTimeLevelCollected or false
end
function settingsWrapper:setFlurryFirstTimeLevelCollected()
  settings.flurryFirstTimeLevelCollected = true
end
function settingsWrapper:isFbPageLiked()
  return settings.fbPageLiked or false
end
function settingsWrapper:setFbPageLiked()
  settings.fbPageLiked = true
end
function settingsWrapper:getBirdsShot()
  return settings.birdsShooted or 0
end
function settingsWrapper:incrementBirdsShot()
  settings.birdsShooted = settingsWrapper:getBirdsShot() + 1
end
function settingsWrapper:getBackwardsBirdCount()
  return settings.backwardsBirdCount or 0
end
function settingsWrapper:incrementBackwardsBirdCount()
  settings.backwardsBirdCount = settingsWrapper:getBackwardsBirdCount() + 1
end
function settingsWrapper:getSelectedEpisode()
  return localSettings.selectedEpisode or 1
end
function settingsWrapper:setSelectedEpisode(episode)
  localSettings.selectedEpisode = episode
end
function settingsWrapper:getLastOpenLevel(episode)
  local last = settings["lastOpenLevelLP" .. episode] or calculateLastOpenLevel(episode)
  if not settings["lastOpenLevelLP" .. episode] then
    settings["lastOpenLevelLP" .. episode] = last
  end
  return last
end
function settingsWrapper:setLastOpenLevel(episode, level)
  settings["lastOpenLevelLP" .. episode] = level
end
function settingsWrapper:incrementLastOpenLevel(episode)
  settings["lastOpenLevelLP" .. episode] = settingsWrapper:getLastOpenLevel(episode) + 1
end
function settingsWrapper:getCurrentZoomLevelMainMenu()
  return localSettings.currentZoomLevelMainMenu or 1.83
end
function settingsWrapper:setCurrentZoomLevelMainMenu(zoom)
  localSettings.currentZoomLevelMainMenu = zoom
end
function settingsWrapper:getCurrentMainMenuTheme()
  return localSettings.currentMainMenuTheme or "theme1"
end
function settingsWrapper:setCurrentMainMenuTheme(theme)
  localSettings.currentMainMenuTheme = theme
end
function settingsWrapper:getCurrentLevelSelectionPages()
  if localSettings.currentLevelSelectionPages == nil then
    localSettings.currentLevelSelectionPages = {}
  end
  return localSettings.currentLevelSelectionPages
end
function settingsWrapper:getCurrentLevelSelectionPage(episode)
  return settingsWrapper:getCurrentLevelSelectionPages()["pack" .. episode] or 1
end
function settingsWrapper:setCurrentLevelSelectionPage(episode, page)
  settingsWrapper:getCurrentLevelSelectionPages()["pack" .. episode] = page
end
function settingsWrapper:isAudioEnabled()
  if localSettings.audioEnabled == nil then
    localSettings.audioEnabled = true
  end
  return localSettings.audioEnabled
end
function settingsWrapper:toggleAudioEnabled()
  localSettings.audioEnabled = not settingsWrapper:isAudioEnabled()
end
function settingsWrapper:getPlaytime()
  if settings.playtime == nil then
    return 0
  end
  return _G.tonumber(settings.playtime) or 0
end
function settingsWrapper:addPlaytime(time)
  settings.playtime = _G.math.floor(settingsWrapper:getPlaytime() + time)
end
function settingsWrapper:getGameStarts()
  return settings.gameStarts or 0
end
function settingsWrapper:incrementGameStarts()
  settings.gameStarts = settingsWrapper:getGameStarts() + 1
end
function settingsWrapper:getGameRestarted()
  return settings.gameRestarted or 0
end
function settingsWrapper:incrementGameRestarted()
  settings.gameRestarted = settingsWrapper:getGameRestarted() + 1
end
function settingsWrapper:getCutscenes()
  if settings.cutscenesWatched == nil then
    settings.cutscenesWatched = {}
  end
  return settings.cutscenesWatched
end
function settingsWrapper:canSkipCutscene(cutscene)
  return settingsWrapper:getCutscenes()[cutscene] == true
end
function settingsWrapper:setCutsceneWatched(cutscene)
  settingsWrapper:getCutscenes()[cutscene] = true
end
function settingsWrapper:isFirstTimeUseLocation()
  if settings.firstTimeUseLocation == nil then
    return true
  else
    return settings.firstTimeUseLocation
  end
end
function settingsWrapper:setLocationUsed()
  settings.firstTimeUseLocation = false
end
function settingsWrapper:getNFCMeUnlocked()
  return localSettings.NFCMeUnlock or false
end
function settingsWrapper:setNFCMeUnlocked(value)
  localSettings.NFCMeUnlock = value
end
function settingsWrapper:getNFCUnlockTimer()
  return localSettings.NFCUnlockTimer or false
end
function settingsWrapper:setNFCUnlockTimer(time)
  localSettings.NFCUnlockTimer = time
end
function settingsWrapper:getAchievementStatusList()
  if settings.achievementStatus == nil then
    settings.achievementStatus = {}
  end
  return settings.achievementStatus
end
function settingsWrapper:getAchievementStatus(achievement)
  local status = settingsWrapper:getAchievementStatusList()
  local valid_achievement = false
  for k, v in _G.pairs(g_achievements) do
    if k == achievement then
      valid_achievement = true
      break
    end
  end
  if not valid_achievement then
    print("invalid achievement id " .. _G.tostring(achievement) .. "\n")
    return false
  end
  if not status[achievement] then
    status[achievement] = {unlocked = false}
  end
  return status[achievement]
end
function settingsWrapper:isAchievementAlreadyUnlocked(achievement)
  local status = settingsWrapper:getAchievementStatus(achievement)
  if not status then
    return false
  end
  return status.unlocked
end
function settingsWrapper:markAchievementUnlocked(achievement)
  local status = settingsWrapper:getAchievementStatus(achievement)
  if not status then
    return
  end
  status.unlocked = true
end
function settingsWrapper:isCakeCollected()
  return settings.cakeCollected or false
end
function settingsWrapper:setCakeCollected()
  settings.cakeCollected = true
end
function settingsWrapper:isNookUserAlreadyConnected()
  return localSettings.nookUserAlreadyConnected or false
end
function settingsWrapper:setNookUserAlreadyConnected()
  localSettings.nookUserAlreadyConnected = true
end
function settingsWrapper:getLicense()
  if settings.license == nil then
    settings.license = {}
  end
  return settings.license
end
function settingsWrapper:getKeyTypes()
  local license = settingsWrapper:getLicense()
  if license.registeredKeyTypes == nil then
    license.registeredKeyTypes = {}
  end
  return license.registeredKeyTypes
end
function settingsWrapper:getHardwareID()
  return settingsWrapper:getLicense().hardwareID or ""
end
function settingsWrapper:setHardwareID(id)
  settingsWrapper:getLicense().hardwareID = id
end
function settingsWrapper:isKeyRegistered(key_type)
  for _, v in _G.ipairs(settingsWrapper:getKeyTypes()) do
    if v == key_type then
      return true
    end
  end
  return false
end
function settingsWrapper:addRegisteredKey(key_type)
  _G.table.insert(settingsWrapper:getKeyTypes(), key_type)
end
function settingsWrapper:getFullscreen()
  if settings.fullscreen == nil then
    settings.fullscreen = true
  end
  return settings.fullscreen
end
function settingsWrapper:setFullscreen(fs)
  settings.fullscreen = fs
end
function settingsWrapper:getResolution()
  return settings.screenWidth or 1024, settings.screenHeight or 600
end
function settingsWrapper:setResolution(width, height)
  settings.screenWidth = width
  settings.screenHeight = height
end
function settingsWrapper:getInventory()
  if settings.inventory == nil then
    settings.inventory = {}
  end
  return settings.inventory
end
function settingsWrapper:getItemAmount(item)
  return settingsWrapper:getInventory()[item] or 0
end
function settingsWrapper:setItemAmountInternal(item, amount)
  settingsWrapper:getInventory()[item] = amount
end
function settingsWrapper:consumeItem(item)
  settingsWrapper:setItemAmountInternal(item, settingsWrapper:getItemAmount(item) - 1)
end
function settingsWrapper:addItems(item, amount)
  settingsWrapper:setItemAmountInternal(item, settingsWrapper:getItemAmount(item) + amount)
end
function settingsWrapper:getOneTimeRewards()
  if settings.oneTimeRewards == nil then
    settings.oneTimeRewards = {}
  end
  return settings.oneTimeRewards
end
function settingsWrapper:isRewardCollected(id)
  if settingsWrapper:getOneTimeRewards()[id] == true then
    return true
  end
  return false
end
function settingsWrapper:setRewardCollected(id)
  settingsWrapper:getOneTimeRewards()[id] = true
end
function settingsWrapper:getMainMenuAdLastCheckedTime()
  if settings.mainMenuAdLastChecked == nil then
    settings.mainMenuAdLastChecked = {
      year = 2000,
      month = 1,
      day = 1,
      hour = 0,
      minutes = 0,
      seconds = 0
    }
  end
  return settings.mainMenuAdLastChecked
end
function settingsWrapper:setMainMenuAdLastCheckedTime(t)
  settings.mainMenuAdLastChecked = t
end
function settingsWrapper:getMainMenuAdTimeStamp()
  if settings.mainMenuAdTimeStamp == nil then
    settings.mainMenuAdTimeStamp = ""
  end
  return settings.mainMenuAdTimeStamp
end
function settingsWrapper:setMainMenuAdTimeStamp(s)
  settings.mainMenuAdTimeStamp = _G.tostring(s)
end
filename = "settingsWrapper.lua"
