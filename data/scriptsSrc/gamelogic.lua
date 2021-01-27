log = _G.require "log"
log.outfile = "logs.txt"
function print(text)
	log.info(text)
end
g_isAccelerometerControl = deviceModel == "roku" or deviceModel == "freebox"
g_enableHoverScaling = deviceModel == "windows" or deviceModel == "osx" or deviceModel == "roku" or deviceModel == "freebox"
iapInitTimeOut = 20
function loadFiles()
  loadLuaFileToObject(scriptPath .. "/options.lua", this, "options")
  loadLuaFile(scriptPath .. "/utils.lua", "")
  loadLuaFileToObject(scriptPath .. "/events.lua", this, "events")
  loadLuaFileToObject(scriptPath .. "/subsystemsapi.lua", this, "subsystemsapi")
  loadLuaFileToObject(scriptPath .. "/ui_components/Frame.lua", this, "ui")
  loadLuaFileToObject(scriptPath .. "/ui_components/Text.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/ui_components/TextButton.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/ui_components/Image.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/ui_components/BGBox.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/ui_components/ImageButton.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/ui_components/ScallableButton.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/ui_components/StaticButton.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/ui_components/ProgressBar.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/ui_components/ToggleButton.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/ui_components/AudioToggleButton.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/ui_components/GridFrame.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/ui_components/SliderFrame.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/ui_components/ScrollFrame2.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/ui_components/TiledImage.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/ui_components/BackgroundBox.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/ui_components/Slider.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/ui_components/Rect.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/ui_components/MenuManager.lua", this, "MenuManager")
  loadLuaFileToObject(scriptPath .. "/menus/MightyEagleButton.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/menus/Prompt.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/menus/MessageBox.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/menus/ConfirmPrompt.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/menus/GameHud.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/menus/PausePage.lua", this.ui, "")
  loadLuaFileToObject(scriptPath .. "/menus/rovio_news.lua", this.ui, "")
  powerAndMeEnabled = true
  disableExternalLinks = not g_hasWebBrowser or isKidsVersion
  if isKidsVersion or applyChinaRestictions then
    powerAndMeEnabled = false
  end
  if not isHDVersion and customerString == "amazon" then
    powerAndMeEnabled = false
  end
  if isKidsVersion then
    loadLuaFileToObject(scriptPath .. "/episodes-pre.lua", this, "_")
  elseif not g_is_free_version then
    loadLuaFileToObject(scriptPath .. "/episodes.lua", this, "_")
  else
    loadLuaFileToObject(scriptPath .. "/episodes_free.lua", this, "_")
  end
  if not isKidsVersion then
    loadLuaFile(scriptPath .. "/powerups.lua", "")
    loadLuaFile(scriptPath .. "/menus/MEPage.lua", "")
    loadLuaFile(scriptPath .. "/menus/daily_reward.lua", "")
  end
  loadLuaFile(scriptPath .. "/iap.lua", "")
  loadLuaFile(scriptPath .. "/achievements.lua", "")
  loadLuaFileToObject(scriptPath .. "/subsystems/subsystems.lua", this, "subsystems")
  loadLuaFileToObject(scriptPath .. "/subsystems/Mattel.lua", this, "Mattel")
  loadLuaFileToObject(scriptPath .. "/EventManager.lua", this.subsystems, "")
  loadLuaFileToObject(scriptPath .. "/timer.lua", this.subsystems, "")
  loadLuaFileToObject(scriptPath .. "/subsystems/flurry.lua", this.subsystems, "")
  loadLuaFileToObject(scriptPath .. "/subsystems/loader.lua", this.subsystems, "")
  if showEditor then
    loadLuaFile(scriptPath .. "/editor/editor.lua", "")
  else
    function updateEditor()
    end
  end
  loadLuaFileToObject(scriptPath .. "/menus/infoFrame.lua", this, "info")
  if deviceModel == "android" or isLiteVersion then
    loadLuaFile(scriptPath .. "/menus/AdsOffPage.lua", "")
  end
  if subsystemsapi:isAndroid() then
    loadLuaFile(scriptPath .. "/menus/GoogleCheckoutPage.lua", "")
  end
  if customerString == "nook" then
    loadLuaFileToObject(scriptPath .. "/subsystems/Nook.lua", this.subsystems, "")
  end
  loadLuaFile(scriptPath .. "/menus/ProcessManager.lua", "")
  loadLuaFile(scriptPath .. "/menus/cutscene.lua", "")
  loadLuaFile(scriptPath .. "/settingsWrapper.lua", "")
  if g_challengesEnabled then
    loadLuaFile(scriptPath .. "/challenges/challenges.lua", "")
    loadLuaFile(scriptPath .. "/challenges/ChallengePage.lua", "")
  end
  loadLuaFile(scriptPath .. "/subsystems/adsSubsystem.lua", "")
  loadLuaFile(scriptPath .. "/cutscenes.lua", "cutscenes")
  if ABIDEnabled then
    loadLuaFileToObject(scriptPath .. "/ABSync.lua", this, "utils")
    loadLuaFileToObject(scriptPath .. "/ABIDUtils.lua", this, "ABIDUtils")
    loadLuaFileToObject(scriptPath .. "/subsystems/ABIDSubSystem.lua", this.subsystems, "")
  end
  if g_registrationEnabled then
    loadLuaFileToObject(scriptPath .. "/menus/registration_dialog.lua", this, "DRM")
    loadLuaFileToObject(scriptPath .. "/PC_DRM.lua", this.DRM, "")
  end
  if deviceModel == "osx" then
    loadLuaFileToObject(scriptPath .. "/trackpad.lua", this, "OSX")
  end
end
loadFiles()
loadlist = {}
postHighscores = true
subSystemsList = {}
processManager = ProcessManager:new()
g_useMp3Sound = true
if deviceModel == "windows" or deviceModel == "osx" or deviceModel == "roku" or deviceModel == "freebox" then
  g_useMp3Sound = false
end
g_restDistance = 2
if deviceModel == "freebox" then
  g_restDistance = 2
end
g_streamSounds = false
if customerString == "hannspree" then
  isSeasonsAvailable = false
end
g_skipToAngryBirdsSplash = deviceModel == "bada" or deviceModel == "blackberry" or deviceModel == "roku"
g_disableDragPanning = g_isAccelerometerControl
g_deltaBasedSlingshot = g_isAccelerometerControl
g_slingshotSensitivity = 0.1
g_layoutMargin = {x = 0, y = 0}
if deviceModel == "roku" then
  g_layoutMargin.x, g_layoutMargin.y = screenWidth * 0.05, screenHeight * 0.05
end
g_disableAnimatedTutorials = deviceModel == "roku"
lockLevelsButtonVisible = false
hideHud = false
showCameraDebugData = false
eagleLockedTime = 3600
NFCUnlockTime = 3600
g_menu_particle_scale = 1
g_eagleClickedFrom = nil
g_enableNewMenus = false
if cheatsEnabled then
  NFCUnlockTime = 60
  eagleLockedTime = 60
end
LP5_PAGE2_LOCKED = false
LP5_PAGE3_LOCKED = false
LP6_PAGE2_LOCKED = false
LP6_PAGE3_LOCKED = false
g_isRegistered = false
feedMessages = {}
adRemovalItemId = "com.rovio.angrybirds.removeads"
mightyEagleItemId = "com.clickgamer.angrybirds.mightyeagle2"
if deviceModel == "ipad" or deviceModel == "ipad3" then
  mightyEagleItemId = "com.chillingo.angrybirdsipad.mightyeagle"
end
if deviceModel == "iphone" or deviceModel == "ipad" or deviceModel == "iphone4" or deviceModel == "ipad3" or deviceModel == "android" then
  webViewIsSupported = true
end
iOS = false
if deviceModel == "iphone" or deviceModel == "ipad" or deviceModel == "iphone4" or deviceModel == "ipad3" then
  iOS = true
end
g_powerups_enabled = (iOS or deviceModel == "android") and powerAndMeEnabled
if deviceModel == "android" and customerString == "nook" then
  g_powerups_enabled = false
end
g_isPC = false
if deviceModel == "windows" or deviceModel == "osx" then
  g_isPC = true
end
g_crystalEnabled = false
g_allowLowQualityGraphics = deviceModel == "android" and not isHDVersion
g_currentCursorName = "CURSOR_HAND_POINT"
g_cursorEnabled = false
g_updateAvailable = false
g_usingGestureControls = false
g_goldenEggKeyboardControl = deviceModel == "windows" or deviceModel == "osx" or g_isAccelerometerControl
g_goldenEggKeys = {
  "O",
  "P",
  "E",
  "N"
}
g_goldenEggKeyCount = 0
if deviceModel == "roku" then
  g_goldenEggKeys = {
    "KEY_GAMING_A"
  }
  g_rokuCursorVisible = true
  g_isRokuSD = screenHeight < 720
end
if deviceModel == "freebox" then
  g_rokuCursorVisible = true
  g_goldenEggKeys = {"KEY_5"}
end
if isPremium then
  settingsWrapper:setPremium(true)
end
if releaseBuild then
  showEditor = false
  postHighscores = true
  function _G.assert()
  end
end
function _G.assert()
end
tapRadius = 15 * screenWidth / 480
debugShowGameCenter = false
eventManager = nil
achievementProcessor = nil
notificationsFrame = ui.Frame:new()
function notificationsFrame:eventTriggered(event)
  if event.id == events.EID_SHOW_LOADING_PAGE then
    self:getChild("loading").visible = true
  elseif event.id == events.EID_HIDE_LOADING_PAGE then
    self:getChild("loading").visible = false
  elseif event.id == events.EID_LEVEL_LOADING_INIT then
    self:getChild("loading").visible = true
  elseif event.id == events.EID_LEVEL_LOADING_DONE then
    self:getChild("loading").visible = false
    if tempWorldScale ~= nil then
      print("tempWorldScale = nil\n")
      tempWorldScale = nil
    end
  end
  if event.id == events.EID_PROCESS_FINISHED then
    local allChildren = {}
    if event.target ~= nil then
      self:removeChild(event.target.item)
    end
  end
end
if applyChinaRestictions or deviceModel == "roku" then
  g_episodes[5].pages[4] = nil
end
g_currentChallenge = nil
g_haveEagleScores = false
g_freeEagleUnlockStatus = {}
function isChallengeMode()
  return g_currentChallenge ~= nil
end
function startNextGameplayChallenge(challenge, progress)
  progress.levelIndex = progress.levelIndex + 1
  setEditing(false)
  setPhysicsEnabled(false)
  local previous_level_count = 0
  levelName = challenge.levels[progress.levelIndex].name
  local levelData, episode, page, levelNumber = getLevelById(levelName)
  for i = 1, page - 1 do
    previous_level_count = previous_level_count + #g_episodes[episode].pages[page].levels
  end
  currentLevelNumber = previous_level_count + levelNumber
  currentLevelNumberInTheme = getLevelNumber(challenge.levelName)
  currentThemeNumber = episode
  currentWorldNumber = g_episodes[episode].pages[page].world_number
  currentPageNumber = page
  levelFolder = "levels/" .. g_episodes[episode].pages[page].folder_name .. "/"
  numberOfAttemptsInLevel = 1
  eventManager:notify({
    id = events.EID_LEVEL_LOADING_INIT
  })
end
function prepareChallengeQueue(challenge)
  print("Starting Challenge : id = " .. challenge.id .. " type = " .. challenge.type .. " name = " .. challenge.name .. " reward = " .. challenge.reward .. "\n")
  if challenge.type == "BIRD_FLOCK" then
    g_currentChallenge = challenge
    g_currentChallengeProgress = {}
    g_currentChallengeProgress.levelIndex = 0
    g_currentChallengeProgress.shotsQueue = {}
    for i, v in _G.ipairs(g_currentChallenge.shotsQueue) do
      for k, l in _G.pairs(g_currentChallenge.shotsQueue[i]) do
        for amount = 1, l do
          _G.table.insert(g_currentChallengeProgress.shotsQueue, k)
        end
      end
    end
    eventManager:notify({
      id = events.EID_START_NEXT_CHALLENGE_LEVEL,
      challenge = g_currentChallenge,
      progress = g_currentChallengeProgress
    })
  end
end
function getLevelNumber(levelName)
  for i = 1, #g_episodes do
    for j = 1, #g_episodes[i].pages do
      for k = 1, #g_episodes[i].pages[j].levels do
        if g_episodes[i].pages[j].levels[k].name == levelName then
          return k
        end
      end
    end
  end
  return 0
end
function getLevelIndexInEpisode(level)
  for i = 1, #g_episodeIds do
    local index = 1
    for j = 1, #g_episodes[g_episodeIds[i]].pages do
      for k = 1, #g_episodes[g_episodeIds[i]].pages[j].levels do
        if g_episodes[g_episodeIds[i]].pages[j].levels[k].name == level then
          return index
        end
        index = index + 1
      end
    end
  end
  return nil
end
function getLevelById(level)
  for _, k in _G.ipairs(g_episodeIds) do
    local v = g_episodes[k]
    for i = 1, #v.pages do
      for j = 1, #v.pages[i].levels do
        if v.pages[i].levels[j].name == level then
          return v.pages[i].levels[j], k, i, j
        end
      end
    end
  end
  return nil
end
function getNextLevel(level)
  local next = false
  for k, _ in allLevels() do
    if k == level then
      next = true
    elseif next then
      return k
    end
  end
  return nil
end
function allLevels()
  local iterator = function(_, i)
    if i == nil then
      local level = g_episodes[g_episodeIds[1]].pages[1].levels[1]
      return level.name, level
    end
    local _, episode, page, index = getLevelById(i)
    for j = 1, #g_episodeIds do
      if g_episodeIds[j] == episode then
        episode = j
        break
      end
    end
    index = index + 1
    if index > #g_episodes[g_episodeIds[episode]].pages[page].levels then
      page = page + 1
      index = 1
      if page > #g_episodes[g_episodeIds[episode]].pages then
        episode = episode + 1
        page = 1
        if episode > #g_episodeIds then
          return nil
        end
      end
    end
    local level = g_episodes[g_episodeIds[episode]].pages[page].levels[index]
    return level.name, level
  end
  return iterator, nil, nil
end
function allEpisodes()
  local iterator = function(_, i)
    if i == nil then
      local episode = g_episodes[g_episodeIds[1]]
      return g_episodeIds[1], episode
    end
    local episode
    for j = 1, #g_episodeIds do
      if g_episodeIds[j] == i then
        episode = j
        break
      end
    end
    episode = episode + 1
    if g_episodeIds[episode] == nil then
      return nil
    end
    return g_episodeIds[episode], g_episodes[g_episodeIds[episode]]
  end
  return iterator, nil, nil
end
function isNextLevelButtonDisabled(level_id)
  local level, episode, page, _ = getLevelById(level_id)
  local disable_next_button = false
  if g_episodes[episode].disable_next_level_button then
    disable_next_button = true
  end
  if g_episodes[episode].pages[page].disable_next_level_button then
    disable_next_button = true
  elseif g_episodes[episode].pages[page].disable_next_level_button == false then
    disable_next_button = false
  end
  if level.disable_next_level_button then
    disable_next_button = true
  elseif level.disable_next_level_button == false then
    disable_next_button = false
  end
  return disable_next_button
end
function isEagleDisabled(level_id)
  if g_eagle_disabled then
    return true
  end
  local level, episode, page, _ = getLevelById(level_id)
  if level == nil then
    return true
  end
  local mighty_eagle_disabled = false
  if g_episodes[episode].mighty_eagle_disabled then
    mighty_eagle_disabled = true
  end
  if g_episodes[episode].pages[page].mighty_eagle_disabled then
    mighty_eagle_disabled = true
  elseif g_episodes[episode].pages[page].mighty_eagle_disabled == false then
    mighty_eagle_disabled = false
  end
  if level.mighty_eagle_disabled then
    mighty_eagle_disabled = true
  elseif level.mighty_eagle_disabled == false then
    mighty_eagle_disabled = false
  end
  return mighty_eagle_disabled
end
function isPowerupsDisabled(level_id)
  if g_powerups_disabled then
    return true
  end
end
function prepareLevel(meta, eventFrom)
  setEditing(false)
  setPhysicsEnabled(false)
  local previous_level_count = 0
  for i = 1, meta.page - 1 do
    previous_level_count = previous_level_count + #g_episodes[meta.episode].pages[meta.page].levels
  end
  currentLevelNumber = previous_level_count + meta.level
  currentLevelNumberInTheme = getLevelNumber(meta.levelName)
  currentThemeNumber = meta.episode
  currentWorldNumber = g_episodes[meta.episode].pages[meta.page].world_number
  currentPageNumber = meta.page
  levelFolder = "levels/" .. g_episodes[meta.episode].pages[meta.page].folder_name .. "/"
  levelName = meta.levelName
  numberOfAttemptsInLevel = 1
  currentEpisode = meta.episode
  if g_episodes[meta.episode].no_level_progression then
    settingsWrapper:setGoldenEggPlayed(levelName)
    eventManager:notify({
      id = events.EID_GE_LEVEL_STARTED,
      levelName = levelName
    })
  else
    eventManager:notify({
      id = events.EID_LEVEL_STARTED,
      currentWorldNumber = currentWorldNumber,
      currentLevelNumberInTheme = currentLevelNumberInTheme,
      from = eventFrom
    })
  end
  if g_episodes[meta.episode].per_page_level_numbering then
    g_currentLevelString = g_episodes[meta.episode].pages[meta.page].display_number .. "-" .. getLevelNumber(meta.levelName)
  else
    g_currentLevelString = g_episodes[meta.episode].pages[meta.page].display_number .. "-" .. getLevelIndexInEpisode(meta.levelName)
  end
  eventManager:notify({
    id = events.EID_LEVEL_LOADING_INIT
  })
end
loadFrameCount = 0
gameluaMenuListener = {
  eventTriggered = function(o, event)
    if event.id == events.EID_FULLSCREEN_AD_SHOWING then
      menuManager.delegateBackClicks = false
      if settingsWrapper:isAudioEnabled() then
        changeAudio()
        changeAudioBackAfterAd = true
      end
    end
    if event.id == events.EID_FULLSCREEN_AD_DISMISSED then
      menuManager.delegateBackClicks = true
      if changeAudioBackAfterAd and not settingsWrapper:isAudioEnabled() then
        changeAudio()
        changeAudioBackAfterAd = false
      end
    end
    if event.id == events.EID_EXIT_FROM_MAIN_REQUESTED then
      requestExit()
    end
    if event.id == events.EID_LEVEL_RESTART_CLICKED then
      restartLevelIngame(event.hidden)
    end
    if event.id == events.EID_PAUSE_CLICKED then
      setPhysicsEnabled(false)
      setGameMode(function()
      end)
    end
    if event.id == events.EID_BACK_TO_GAME_CLICKED then
      setPhysicsEnabled(true)
      hidePauseMenu()
      if settingsWrapper:isAudioEnabled() then
        setMusicVolume(1)
        setEffectsVolume(1)
      end
      setGameMode(updateGame)
      skipInput = true
    end
    if event.id == events.EID_MIGHTY_EAGLE_PURCHASE_CLOSE_CLICKED then
      if event.from == "LEVEL_FAILED" then
        local frame = menuManager:popFrame()
        eventManager:notify({
          id = events.EID_PUSH_FRAME,
          target = frame.return_screen
        })
      elseif event.from == "INGAME" then
        menuManager:changeRoot(g_hud_class:new())
        setGameMode(updateGame)
        setPhysicsEnabled(true)
      end
    end
    if event.id == events.EID_GOTO_FACEBOOK_CONNECT then
      gotoABFBConnect()
    end
    if event.id == events.EID_GOOGLE_CHECKOUT_CLICKED then
      print(" ### EID_GOOGLE_CHECKOUT_CLICKED; ITEM = " .. event.item)
    end
    if event.id == events.EID_OPERATOR_CHECKOUT_CLICKED then
      print(" ### OPERATOR CHECKOUT CLICKED; ITEM = " .. event.item)
    end
    if event.id == events.EID_MIGHTY_EAGLE_BUTTON_CLICKED then
      if startedFromEditor then
        launchEagleBaitInGame()
      elseif isEagleEnabled() == true then
        if event.from and event.from == "MAIN_MENU" then
          return
        end
        if isEagleUnavailableForShot() == true then
          eagleInfoTimer = 3
        else
          launchEagleBaitInGame()
          if event.from == "LEVEL_FAILED" then
            menuManager:changeRoot(g_hud_class:new())
            if deviceModel == "iphone4" or deviceModel == "ipad3" then
              changeResolution = true
              wantedResolution = "FULL"
              g_resetCameras = true
            end
          end
        end
      elseif event.from == "LEVEL_FAILED" then
        g_eagleClickedFrom = "LEVEL_FAILED"
        eventManager:notify({
          id = events.EID_PUSH_FRAME,
          target = MEPage:new({
            return_screen = menuManager:popFrame()
          })
        })
      elseif event.from == "MAIN_MENU" then
        g_eagleClickedFrom = "MAIN_MENU"
        menuManager:changeRoot(MainMenuEaglePage:new())
      elseif event.from == "INGAME" then
        g_eagleClickedFrom = "INGAME"
        goToMightyEagleDemoPageFromGame()
      end
      skipInput = true
    end
    if event.id == events.EID_LEVEL_LOADING_INIT then
      if wantedResolution ~= "FULL" then
        changeResolution = true
        wantedResolution = "FULL"
      end
      loadFrameCount = 1
    end
    if event.id == events.EID_SHOW_LOADING_PAGE then
      menuManager:setAllowInput(false)
    end
    if event.id == events.EID_HIDE_LOADING_PAGE then
      menuManager:setAllowInput(true)
    end
    if event.id == events.EID_GOLDEN_EGG_FROM_MENU then
      revealGoldenEgg(event.levelName)
    end
    if event.id == events.EID_BOOMERANG_BIRD_POPUP then
      showRewardPopup("BOOMERANG_BIRD")
    end
    if event.id == events.EID_STAR_POPUP then
      showRewardPopup("STAR", {
        first_time = event.first_time
      })
    end
    if event.id == events.EID_REWARD_POPUP then
      showRewardPopup("GENERIC_REWARD", {
        sprite = event.sprite,
        sound = event.sound
      })
    end
    if event.id == events.EID_START_NEXT_CHALLENGE_LEVEL then
      startNextGameplayChallenge(event.challenge, event.progress)
    end
    if event.id == events.EID_CHANGE_SCENE then
      clearParticles()
      if event.from == "INGAME" then
        setGameMode(function()
        end)
        _G.res.stopAllAudio()
        stopIngameSounds()
      end
      if event.from == "BOOT" then
        if useDynamicAssets then
          dynamic.release("splashes")
        else
          releaseImages({"SPLASHES"})
        end
      end
    end
    if event.id == events.EID_LEVEL_COMPLETED then
      loginfo(" EID_LEVEL_COMPLETED. levelName = " .. event.levelName .. " eagleBaitLaunched=" .. _G.tostring(event.eagleBaitLaunched) .. "\n")
      if event.eagleBaitLaunched ~= true and settingsWrapper:removeEagleUsedInLevel(event.levelName) then
        loginfo("removing eagle used in from " .. event.levelName)
        settingsWrapper:setEagleUsedTime(nil)
        removeNotification("mightyEagleAvailable")
      end
      local level, episode, page, index = getLevelById(event.levelName)
      if settingsWrapper:getLastOpenLevel(episode) <= getLevelIndexInEpisode(event.levelName) and not g_episodes[episode].no_level_progression and not g_episodes[episode].pages[page].no_level_progression then
        settingsWrapper:incrementLastOpenLevel(episode)
        saveLuaFileWrapper("settings.lua", "settings", true)
      end
    end
    if event.id == events.EID_CHALLENGE_STARTED then
      if not highscores[event.challenge.id] then
        print("<warning> highscores[" .. _G.tostring(event.challenge.id) .. "] was not initialised\n")
        highscores[event.challenge.id] = {}
      end
      if not highscores[event.challenge.id].played then
        highscores[event.challenge.id].played = true
        eventManager:notify({
          id = events.EID_CHALLENGE_STARTED_FIRSTTIME,
          challenge = event.challenge
        })
      end
      prepareChallengeQueue(event.challenge)
    end
    if event.id == events.EID_CHANGE_LEVEL then
      g_currentChallenge = nil
      g_currentChallengeProgress = nil
      local meta = event.data
      if meta.levelName == "SOUNDBOARD1" or meta.levelName == "RADIO" or meta.levelName == "KEYBOARD" or meta.levelName == "SEQUENCER" or meta.levelName == "ACCORDION" then
        settingsWrapper:setGoldenEggPlayed(meta.levelName)
        eventManager:notify({
          id = events.EID_GE_LEVEL_STARTED,
          levelName = meta.levelName
        })
        local goto_level
        if meta.levelName == "SOUNDBOARD1" then
          goto_level = {
            id = events.EID_CHANGE_SCENE,
            target = soundboards.Soundboard:new()
          }
        elseif meta.levelName == "RADIO" then
          goto_level = {
            id = events.EID_CHANGE_SCENE,
            target = soundboards.Radio:new()
          }
        elseif meta.levelName == "KEYBOARD" then
          goto_level = {
            id = events.EID_CHANGE_SCENE,
            target = soundboards.Keyboard:new()
          }
        elseif meta.levelName == "SEQUENCER" then
          goto_level = {
            id = events.EID_CHANGE_SCENE,
            target = soundboards.Sequencer:new()
          }
        elseif meta.levelName == "ACCORDION" then
          goto_level = {
            id = events.EID_CHANGE_SCENE,
            target = soundboards.Accordion:new()
          }
        end
        eventManager:notify({
          id = events.EID_DO_LOADING,
          items = {
            function()
              loadAssets({
                "GOLDEN_EGGS"
              })
            end
          },
          completion_event = goto_level
        })
      else
        prepareLevel(meta, event.from)
      end
    end
    if event.id == events.EID_GAMELUA_POPUP then
      dummyPopupPage.rootContainer = event.root
      setActivePopupPage(dummyPopupPage)
    end
    if event.id == events.EID_EXIT_CONFIRMED then
      requestExit()
    end
    if event.id == events.EID_EXIT_GAME then
      if deviceModel ~= "android" and not g_isPC then
        requestExit()
      else
        notificationsFrame:addChild(ui.ConfirmPrompt:new({
          title = "TEXT_EXIT_CONFIRM",
          confirmOnLeft = deviceModel ~= "osx",
          reverse_back_key = deviceModel == "android",
          confirm_event = {
            id = events.EID_EXIT_CONFIRMED
          },
          reverse_back_key = deviceModel == "android"
        }))
      end
    end
    if event.id == events.EID_GOTO_GAME then
      if wantedResolution ~= "FULL" then
        changeResolution = true
        wantedResolution = "FULL"
      end
      local old_reso_x, old_reso_y = screenWidth, screenHeight
      if deviceModel == "iphone4" then
        screenWidth = 960
        screenHeight = 640
      elseif deviceModel == "ipad3" then
        screenWidth = 2048
        screenHeight = 1536
      end
      initCameras()
      if deviceModel == "iphone4" or deviceModel == "ipad3" then
        screenWidth = old_reso_x
        screenHeight = old_reso_y
      end
      menuManager:deactivate()
      setGameMode(updateGame)
      g_drawHud = true
      if settingsWrapper:isAudioEnabled() then
        setMusicVolume(1)
        setEffectsVolume(1)
      end
      menuManager:changeRoot(g_hud_class:new())
    end
    if event.id == events.EID_LOAD_INTRO_CUTSCENE then
      local play_cutscene = {
        id = events.EID_PLAY_INTRO_CUTSCENE,
        cutscene = event.cutscene,
        data = event.data
      }
      eventManager:notify({
        id = events.EID_DO_LOADING,
        items = {loadCutScenes},
        completion_event = play_cutscene
      })
    end
    if event.id == events.EID_PLAY_INTRO_CUTSCENE then
      menuManager:changeRoot(CutScene:new(event.cutscene, {
        id = events.EID_CHANGE_LEVEL,
        data = event.data
      }))
    end
    if event.id == events.EID_LOAD_END_CUTSCENE then
      local play_cutscene = {
        id = events.EID_PLAY_END_CUTSCENE,
        cutscene = event.cutscene,
        episode = event.episode,
        page = event.page,
        level_index = event.level_index
      }
      eventManager:notify({
        id = events.EID_DO_LOADING,
        items = {loadCutScenes},
        completion_event = play_cutscene
      })
    end
    if event.id == events.EID_PLAY_END_CUTSCENE then
      menuManager:changeRoot(CutScene:new(event.cutscene, {
        id = events.EID_END_CUTSCENE_FINISHED,
        episode = event.episode,
        page = event.page,
        level_index = event.level_index
      }))
    end
    if event.id == events.EID_END_CUTSCENE_FINISHED then
      local return_event = {
        id = events.EID_RETURN_TO_MENU_FROM_CUTSCENE,
        episode = event.episode,
        page = event.page,
        level_index = event.level_index
      }
      eventManager:notify({
        id = events.EID_DO_LOADING,
        items = {releaseCutScenes},
        completion_event = return_event
      })
    end
    if event.id == events.EID_RETURN_TO_MENU_FROM_CUTSCENE then
      if not g_episodes[event.episode].pages[event.page].levels[event.level_index].episode_end and not g_episodes[event.episode].pages[event.page].levels[event.level_index].temporary_end then
        eventManager:notify({
          id = events.EID_SCROLL_TO_NEXT_WORLD,
          episode = event.episode
        })
        eventManager:notify({
          id = events.EID_CHANGE_SCENE,
          target = "LEVEL_SELECTION_" .. event.episode
        })
      elseif g_episodes[event.episode].pages[event.page].levels[event.level_index].temporary_end then
        eventManager:notify({
          id = events.EID_CHANGE_SCENE,
          target = "LEVEL_SELECTION_" .. event.episode
        })
      elseif event.episode == #g_episodes then
        eventManager:notify({
          id = events.EID_CURRENT_MENU_THEME_NEEDED
        })
        local credits_event = {
          id = events.EID_GOTO_CREDITS
        }
        eventManager:notify(credits_event)
      else
        if _G.tonumber(event.episode) then
          eventManager:notify({
            id = events.EID_SCROLL_TO_EPISODE,
            from = event.episode,
            to = event.episode + 1
          })
        end
        local episode_event = {
          id = events.EID_CHANGE_SCENE,
          target = "EPISODE_SELECTION"
        }
        eventManager:notify(episode_event)
      end
    end
    if event.id == events.EID_GOTO_CREDITS then
      eventManager:notify({
        id = events.EID_CHANGE_SCENE,
        target = "CREDITS"
      })
    end
    if event.id == events.EID_LEVEL_PLAYED_WITH_EAGLE then
      local eagle_already_used = false
      for k, v in _G.pairs(settingsWrapper:getEagleUsedIn()) do
        if v.level == event.level then
          eagle_already_used = true
        end
      end
      if not event.skipped then
        eagle_already_used = true
      end
      if event.level ~= nil and highscores[event.level] ~= nil and highscores[event.level].score > 0 then
        eagle_already_used = true
        loginfo("eagle was already used in level (score found)")
      end
      if not eagle_already_used then
        settingsWrapper:setEagleUsedInLevel(event.level)
        settingsWrapper:setEagleUsedTime(currentTime())
        local eagleNotificationText = _G.res.getString("TEXTS_BASIC", "TEXT_MIGHTY_EAGLE_RETURNS")
        addNotificationAfter("mightyEagleAvailable", eagleLockedTime, eagleNotificationText)
      end
    end
    if event.id == events.EID_THREE_STARS_GAINED then
      local _, episode, _, _ = getLevelById(event.level)
      local stars, total_stars = calculateEpisodeStars(episode)
      if stars == total_stars and not settingsWrapper:isEpisodeThreeStarred(episode) and not g_episodes[episode].disable_episode_completion_screens then
        eventManager:notify({
          id = events.EID_EPISODE_THREE_STARRED,
          episode = episode
        })
      end
    end
    if event.id == events.EID_EPISODE_THREE_STARRED then
      settingsWrapper:setEpisodeThreeStarred(event.episode)
      if g_episodes[event.episode].three_stars_goldenegg then
        goldenEggAchieved(g_episodes[event.episode].three_stars_goldenegg)
      end
    end
    if event.id == events.EID_STARS_GAINED then
      settingsWrapper:setCumulativeStars(settingsWrapper:getCumulativeStars() + event.stars)
    end
    if event.id == events.EID_WORLD_COMPLETED then
      settingsWrapper:setThemeCompleted(event.worldNumber)
    end
    if event.id == events.EID_CHALLENGE_LEVEL_ENDED then
      g_drawHud = false
      if startedFromEditor then
        return
      end
      setPhysicsEnabled(false)
      setGameMode(function()
      end)
      stopIngameSounds()
      menuManager:changeRoot(LevelEndRoot:new())
      if event.levelComplete == true then
        if g_currentChallengeProgress.levelIndex + 1 > #g_currentChallenge.levels then
          eventManager:notify({
            id = events.EID_CHALLENGE_COMPLETE,
            challenge = g_currentChallenge
          })
          if not highscores[event.challenge.id] or not highscores[event.challenge.id].completed then
            highscores[event.challenge.id] = {completed = true}
            saveLuaFileWrapper("highscores.lua", "highscores", true)
            eventManager:notify({
              id = events.EID_CHALLENGE_COMPLETE_FIRST_TIME,
              challenge = g_currentChallenge
            })
          end
          eventManager:notify({
            id = events.EID_PUSH_FRAME,
            target = ChallengeComplete:new(event.challenge, g_currentChallengeProgress)
          })
        else
          eventManager:notify({
            id = events.EID_PUSH_FRAME,
            target = ChallengeLevelComplete:new(event.challenge, g_currentChallengeProgress)
          })
        end
      else
        eventManager:notify({
          id = events.EID_CHALLENGE_FAILED,
          challenge = g_currentChallenge,
          progress = g_currentChallengeProgress
        })
        eventManager:notify({
          id = events.EID_PUSH_FRAME,
          target = ChallengeFailed:new(event.challenge, g_currentChallengeProgress)
        })
      end
    end
    if event.id == events.EID_LEVEL_ENDED then
      levelCompleteTimer = 0
      lastScoreTime = 0
      endTimeout = false
      if startedFromEditor then
        return
      end
      if deviceModel == "iphone4" or deviceModel == "ipad3" then
        changeResolution = true
        wantedResolution = "HALF"
        g_resetCameras = true
      end
      setPhysicsEnabled(false)
      setGameMode(function()
      end)
      stopIngameSounds()
      if not g_special_game_mode then
        local level, episode, page, index = getLevelById(event.level)
        local first_time = true
        if highscores[event.level] and highscores[event.level].completed then
          first_time = false
        end
        if highscores[event.level] == nil then
          highscores[event.level] = {score = 0}
        end
        if highscores[event.level].score == nil then
          highscores[event.level].score = 0
        end
        if highscores[event.level].legitScore == nil then
          highscores[event.level].legitScore = highscores[event.level].score
        end
        if not highscores[event.level].completed and event.levelComplete then
          eventManager:notify({
            id = events.EID_LEVEL_COMPLETE_FIRST_TIME,
            level = event.level
          })
          highscores[event.level].completed = true
        end
        local stars = 0
        if event.levelComplete and g_episodes[episode].extra then
          local old_highscore = highscores[event.level].score or 0
          if event.score > highscores[event.level].score then
            eventManager:notify({
              id = events.EID_NEW_HIGHSCORE,
              level = event.level,
              oldHighscore = highscores[event.level].score,
              newHighscore = event.score
            })
            highscores[event.level].score = event.score
            highscores[event.level].birds = birdsShot
            if gameCenterEnabled and gameCenter and gameCenter.leaderboards then
              setPostedStatus(event.level)
            end
          end
          if #g_powerups_used == 0 and event.score > highscores[event.level].legitScore then
            highscores[event.level].legitScore = event.score
          end
          if highscores[event.level].lowScore == nil or event.score < highscores[event.level].lowScore then
            highscores[event.level].lowScore = event.score
          end
          if event.score >= starTable[event.level].goldScore then
            eventManager:notify({
              id = events.EID_GOLDEN_EGG_STAR_GAINED,
              data = {
                starsGained = calculateStarsFromGoldenEggLevels()
              }
            })
          end
          menuManager:changeRoot(LevelEndRoot:new())
          local end_page = GoldenEggComplete:new(event.level, event.score, old_highscore, {
            powerups_used = #g_powerups_used > 0
          })
          eventManager:notify({
            id = events.EID_PUSH_FRAME,
            target = end_page
          })
        elseif event.levelComplete and not eagleBaitLaunched then
          stars = getStarCount(event.level, event.score)
          local old_highscore = highscores[event.level].score or 0
          local old_ep_stars, total_stars = calculateEpisodeStars(episode)
          if event.score > highscores[event.level].score then
            eventManager:notify({
              id = events.EID_NEW_HIGHSCORE,
              level = event.level,
              oldHighscore = highscores[event.level].score,
              newHighscore = event.score
            })
            highscores[event.level].score = event.score
            highscores[event.level].birds = birdsShot
            if gameCenterEnabled and gameCenter and gameCenter.leaderboards then
              setPostedStatus(event.level)
            end
          end
          if #g_powerups_used == 0 and event.score > highscores[event.level].legitScore then
            highscores[event.level].legitScore = event.score
          end
          local new_ep_stars = calculateEpisodeStars(episode)
          if highscores[event.level].lowScore == nil or event.score < highscores[event.level].lowScore then
            highscores[event.level].lowScore = event.score
          end
          if event.score >= starTable[event.level].goldScore then
            eventManager:notify({
              id = events.EID_THREE_STARS_GAINED,
              level = event.level
            })
          end
          eventManager:notify({
            id = events.EID_STARS_GAINED,
            level = event.level,
            stars = stars
          })
          if iOS then
            postTotalHighScores()
            if not isLiteVersion then
              postLevelHighScore(levelName, highscores[levelName].score, true)
            end
          end
          menuManager:changeRoot(LevelEndRoot:new())
          local end_stars = stars
          local end_page = LevelComplete:new({
            powerups_used = #g_powerups_used > 0
          }, event.level, first_time, end_stars, event.score, old_highscore, isEagleUnavailableForShot())
          local episode_completed = false
          local episode_three_starred = false
          if stars == 3 and total_stars <= new_ep_stars and old_ep_stars < new_ep_stars and not g_episodes[episode].disable_episode_completion_screens then
            end_page = EpisodeThreeStars:new(nil, end_page, episode)
            episode_three_starred = true
          end
          if level.episode_end and first_time and not g_episodes[episode].disable_episode_completion_screens then
            if not episode_three_starred then
              end_page = EpisodeComplete:new(nil, end_page, episode)
            end
            episode_completed = true
          end
          eventManager:notify({
            id = events.EID_PUSH_FRAME,
            target = end_page
          })
        elseif eagleBaitLaunched then
          print("<Mighty Eagle> score for " .. _G.tostring(event.level) .. ": " .. _G.tostring(event.score) .. "\n")
          local eagle_score = _G.math.min(_G.math.floor(event.score / starTable[event.level].eagleScore * 100), 100)
          local old_eagle_score = highscores[event.level].eagleScore or 0
          if eagle_score > old_eagle_score then
            eventManager:notify({
              id = events.EID_NEW_EAGLE_HIGHSCORE,
              level = event.level,
              oldHighscore = old_eagle_score,
              newHighscore = eagle_score
            })
            storeEagleScore(event.level, eagle_score)
            if eagle_score >= 100 then
              eventManager:notify({
                id = events.EID_EAGLE_FEATHER_GAINED,
                level = event.level
              })
            end
          end
          if highscores[event.level].eagleScoreMax == nil or event.score > highscores[event.level].eagleScoreMax then
            highscores[event.level].eagleScoreMax = event.score
          end
          if highscores[event.level].eagleScoreMin == nil or event.score > highscores[event.level].eagleScoreMin then
            highscores[event.level].eagleScoreMin = event.score
          end
          print("level played using mighty eagle\n")
          eventManager:notify({
            id = events.EID_LEVEL_PLAYED_WITH_EAGLE,
            level = event.level,
            skipped = first_time
          })
          local end_page = EagleScore:new(nil, event.level, first_time, eagle_score, old_eagle_score)
          local episode_completed = false
          if level.episode_end and first_time and not g_episodes[episode].disable_episode_completion_screens then
            end_page = EpisodeComplete:new(nil, end_page, episode)
            episode_completed = true
            if episode_completed and not settingsWrapper:isRewardCollected("episode" .. _G.tostring(episode)) then
              settingsWrapper:setRewardCollected("episode" .. _G.tostring(episode))
              bundleReward(5)
            end
          end
          menuManager:changeRoot(LevelEndRoot:new())
          eventManager:notify({
            id = events.EID_PUSH_FRAME,
            target = end_page
          })
        else
          menuManager:changeRoot(LevelEndRoot:new())
          eventManager:notify({
            id = events.EID_PUSH_FRAME,
            target = LevelFailed:new(event.level, not isEagleUnavailableForShot(), not first_time)
          })
        end
        saveLuaFileWrapper("highscores.lua", "highscores", true)
        saveLuaFileWrapper("settings.lua", "settings", true)
        if event.levelComplete then
          local level, e, w, levelNumber = getLevelById(event.level)
          if levelNumber == #g_episodes[episode].pages[page].levels then
            eventManager:notify({
              id = events.EID_EPISODE_COMPLETED,
              episodeNumber = e
            })
          end
          if not g_episodes[episode].extra and not g_episodes[episode].pages[page].extra and g_episodes[episode].pages[page].world_number and g_episodes[episode].pages[page].world_number > 0 and index == #g_episodes[episode].pages[page].levels then
            local first_time_completed = not settingsWrapper:isThemeCompleted(g_episodes[episode].pages[page].world_number)
            eventManager:notify({
              id = events.EID_WORLD_COMPLETED,
              worldNumber = g_episodes[episode].pages[page].world_number,
              firstTime = first_time_completed,
              clearAchievement = g_episodes[episode].pages[page].clear_achievement
            })
          end
          if not g_episodes[episode].extra then
            local episode_stars, episode_total_stars = calculateEpisodeStars(episode)
            eventManager:notify({
              id = events.EID_LEVEL_COMPLETED,
              levelName = event.level,
              totalScore = calculateEpisodeScore(episode),
              gainedStars = stars,
              themeNumber = episode,
              stars = episode_stars,
              totalStars = episode_total_stars,
              cumulativeStars = settingsWrapper:getCumulativeStars(),
              extraWorld = g_episodes[episode].extra,
              feathers = calculateAllFeathers(),
              scoreAchievementLimit = g_episodes[episode].score_achievement_limit,
              eagleBaitLaunched = eagleBaitLaunched
            })
          else
            eventManager:notify({
              id = events.EID_GOLDEN_EGG_COMPLETED,
              level = event.level
            })
          end
        elseif not g_episodes[episode].extra then
          eventManager:notify({
            id = events.EID_LEVEL_FAILED,
            level = event.level
          })
        else
          eventManager:notify({
            id = events.EID_GOLDEN_EGG_FAILED,
            level = event.level
          })
        end
      end
    end
    if event.id == events.EID_SHOW_TUTORIALS then
      birdTutorialPopups = {}
      if g_platformTutorials and g_platformTutorials[deviceModel] then
        for _, v in _G.ipairs(g_platformTutorials[deviceModel]) do
          addTutorial(birdTutorialPopups, v)
        end
      end
      if settingsWrapper:getTutorialsForItem("BIRD_RED") then
        _G.table.insert(birdTutorialPopups, settingsWrapper:getTutorialsForItem("BIRD_RED").sprite)
      end
      if settingsWrapper:getTutorialsForItem("BIRD_BLUE") then
        _G.table.insert(birdTutorialPopups, settingsWrapper:getTutorialsForItem("BIRD_BLUE").sprite)
      end
      if settingsWrapper:getTutorialsForItem("BIRD_YELLOW") then
        _G.table.insert(birdTutorialPopups, settingsWrapper:getTutorialsForItem("BIRD_YELLOW").sprite)
      end
      if settingsWrapper:getTutorialsForItem("BIRD_GREY") then
        _G.table.insert(birdTutorialPopups, settingsWrapper:getTutorialsForItem("BIRD_GREY").sprite)
      end
      if settingsWrapper:getTutorialsForItem("BIRD_GREEN") then
        _G.table.insert(birdTutorialPopups, settingsWrapper:getTutorialsForItem("BIRD_GREEN").sprite)
      end
      if settingsWrapper:getTutorialsForItem("BIRD_BOOMERANG") ~= nil then
        _G.table.insert(birdTutorialPopups, settingsWrapper:getTutorialsForItem("BIRD_BOOMERANG").sprite)
      end
      if settingsWrapper:getTutorialsForItem("BIRD_BIG_BROTHER") ~= nil then
        _G.table.insert(birdTutorialPopups, settingsWrapper:getTutorialsForItem("BIRD_BIG_BROTHER").sprite)
      end
      if settingsWrapper:getTutorialsForItem("BIRD_PUFFER_1") then
        _G.table.insert(birdTutorialPopups, settingsWrapper:getTutorialsForItem("BIRD_PUFFER_1").sprite)
      end
      if settingsWrapper:getTutorialsForItem("BAIT_SARDINE") ~= nil then
        _G.table.insert(birdTutorialPopups, settingsWrapper:getTutorialsForItem("BAIT_SARDINE").sprite)
      end
      if #birdTutorialPopups > 1 then
        eventManager:notify({
          id = events.EID_SHOW_TUTORIAL,
          tutorial = birdTutorialPopups[1],
          from = "PAUSE_MENU"
        })
      end
    end
    if event.id == events.EID_SHOW_TUTORIAL then
      _G.table.remove(birdTutorialPopups, 1)
      if g_tutorialActive then
        eventManager:notify({
          id = events.EID_POP_FRAME
        })
      end
      g_tutorialActive = {
        tutorial = event.tutorial,
        from = event.from
      }
      if _G.type(event.tutorial) == "string" and not g_disableAnimatedTutorials then
        eventManager:notify({
          id = events.EID_PUSH_FRAME,
          target = AnimatedTutorial:new(event.tutorial)
        })
      else
        eventManager:notify({
          id = events.EID_PUSH_FRAME,
          target = Tutorial:new(event.tutorial)
        })
      end
      if event.from == "INGAME" then
        setPhysicsEnabled(false)
        setGameMode(function()
        end)
      end
    end
    if event.id == events.EID_ADS_PURCHASE_OFF_CLICKED_INGAME then
      setPhysicsEnabled(false)
      function currentGameMode()
      end
      setGameOn(false)
      eventManager:notify({
        id = events.EID_CHANGE_SCENE,
        target = AdsOffPage:new()
      })
    end
    if event.id == events.EID_ADS_PURCHASE_OFF_CLICKED then
      purchaseAdRemoval()
    end
    if event.id == events.EID_GOOGLE_CHECKOUT_CLOSE_CLICKED and event.inGame ~= true then
      eventManager:notify({
        id = events.EID_CHANGE_SCENE,
        target = "MAIN_MENU"
      })
    end
    if event.id == events.EID_ADS_PURCHASE_CLOSE_CLICKED or event.id == events.EID_GOOGLE_CHECKOUT_CLOSE_CLICKED and event.inGame == true then
      menuManager:changeRoot(g_hud_class:new())
      setGameMode(updateGame)
      setPhysicsEnabled(true)
    end
    if event.id == events.EID_CLOSE_TUTORIAL then
      local tutorial = g_tutorialActive
      if #birdTutorialPopups == 0 then
        setPhysicsEnabled(true)
        setGameMode(updateGame)
        g_tutorialActive = nil
        eventManager:notify({
          id = events.EID_POP_FRAME
        })
        eventManager:notify({
          id = events.EID_TUTORIALS_DONE
        })
      else
        g_tutorialActive.ready_for_next_tutorial = true
      end
    end
    if event.id == events.EID_SKIP_TUTORIALS then
      birdTutorialPopups = {}
      if g_tutorialActive then
        eventManager:notify({
          id = events.EID_POP_FRAME
        })
        g_tutorialActive = nil
      end
    end
    if event.id == events.EID_LEAVE_GAME and event.reason == "PAUSE_MENU_BUTTON" and (deviceModel == "iphone4" or deviceModel == "ipad3") then
      changeResolution = true
      wantedResolution = "HALF"
    end
    if event.id == events.EID_SHOW_REGISTRATION_DIALOG then
      eventManager:notify({
        id = events.EID_PUSH_FRAME,
        target = DRM.RegistrationDialog:new(event.from, event.success_event, event.success_call)
      })
    end
    if event.id == events.EID_UPDATE_GAME then
      callVersionUpdater()
      requestExit()
    end
    if event.id == events.EID_TOGGLE_FULLSCREEN then
      if isInFullScreenMode() then
        setFullScreenMode(false)
      else
        setFullScreenMode(true)
      end
    end
    if event.id == events.EID_POWERUP_WILL_BE_USED then
      print("<POWERUPS> consuming powerup of type " .. _G.tostring(event.type) .. "\n")
      settingsWrapper:consumeItem(event.type)
      _G.table.insert(g_powerups_used, event.type)
      eventManager:notify({
        id = events.EID_POWERUP_WAS_USED,
        type = event.type,
        total_used = #g_powerups_used,
        level = levelName
      })
    end
  end
}
function notifyEventManager(event, params)
  if eventManager then
    params = params or {}
    params.id = event
    eventManager:notify(params)
  end
end
function purchaseCheckoutErrorCallback()
  eventManager:notify({
    id = events.EID_PUSH_FRAME,
    target = ui.Prompt:new({
      title = "TEXT_NETWORK_ERROR_TITLE",
      content = "TEXT_NETWORK_ERROR"
    })
  })
end
function initSubsystems()
  eventManager = subsystems.EventManager:new()
  achievementProcessor = subsystems.AchievementProcessor:new()
  achievementProcessor:checkForAchievements()
  menuManager = MenuManager.MenuManager:new()
  menuManager:changeRoot(notificationsFrame, "notifications")
  menuManager.menu_order = {
    "root",
    "notifications"
  }
  menuManager.input_order = {
    "notifications",
    "root"
  }
  adSystem = AdsSubSystem:new()
  linkListener = subsystems.LinkListener:new()
  if showEditor then
    editorListener = Editor:new()
  end
  flurry = subsystems.Flurry:new()
  loaderSystem = subsystems.Loader:new()
  if customerString == "nook" then
    nook_subsystem = subsystems.NookSubsystem:new()
  end
  if ABIDEnabled then
    ABIDSubSystem = subsystems.ABIDSubSystem:new()
    eventManager:addEventListener(events.EID_GAME_INITIALIZED, ABIDSubSystem)
    eventManager:addEventListener(events.EID_ABID_CLICKED, ABIDSubSystem)
    eventManager:addEventListener(events.EID_GAME_PAUSED, ABIDSubSystem)
    eventManager:addEventListener(events.EID_GAME_RESUMED, ABIDSubSystem)
  end
  eventManager:addEventListener(events.EID_SHOW_LOADING_PAGE, notificationsFrame)
  eventManager:addEventListener(events.EID_HIDE_LOADING_PAGE, notificationsFrame)
  eventManager:addEventListener(events.EID_LEVEL_LOADING_DONE, notificationsFrame)
  eventManager:addEventListener(events.EID_LEVEL_LOADING_INIT, notificationsFrame)
  eventManager:addEventListener(events.EID_PROCESS_FINISHED, notificationsFrame)
  eventManager:addEventListener(events.EID_GOLDEN_EGG_GAINED, achievementProcessor)
  eventManager:addEventListener(events.EID_GOLDEN_EGG_STAR_GAINED, achievementProcessor)
  eventManager:addEventListener(events.EID_TUTORIAL_WATCHED, achievementProcessor)
  eventManager:addEventListener(events.EID_WORLD_COMPLETED, achievementProcessor)
  eventManager:addEventListener(events.EID_LEVEL_COMPLETED, achievementProcessor)
  eventManager:addEventListener(events.EID_BLOCKS_DESTROYED, achievementProcessor)
  eventManager:addEventListener(events.EID_BOOMERANG_BIRD_POPUP_SHOWN, achievementProcessor)
  eventManager:addEventListener(events.EID_BIRD_SHOT, achievementProcessor)
  eventManager:addEventListener(events.EID_BIRDS_COLLIDED_ON_FLY, achievementProcessor)
  eventManager:addEventListener(events.EID_ACHIEVEMENT_BULLSEYE, achievementProcessor)
  eventManager:addEventListener(events.EID_CAKE_COLLECTED, achievementProcessor)
  eventManager:addEventListener(events.EID_SPACE_INVANDER, achievementProcessor)
  eventManager:addEventListener(events.EID_CHANGE_SCENE, menuManager)
  eventManager:addEventListener(events.EID_POP_FRAME, menuManager)
  eventManager:addEventListener(events.EID_PUSH_FRAME, menuManager)
  eventManager:addEventListener(events.EID_CHANGE_LEVEL, gameluaMenuListener)
  eventManager:addEventListener(events.EID_GOTO_MAIN_MENU, gameluaMenuListener)
  eventManager:addEventListener(events.EID_GAMELUA_POPUP, gameluaMenuListener)
  eventManager:addEventListener(events.EID_EXIT_GAME, gameluaMenuListener)
  eventManager:addEventListener(events.EID_GOTO_GAME, gameluaMenuListener)
  eventManager:addEventListener(events.EID_LEVEL_COMPLETED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_CHANGE_SCENE, gameluaMenuListener)
  eventManager:addEventListener(events.EID_GOLDEN_EGG_FROM_MENU, gameluaMenuListener)
  eventManager:addEventListener(events.EID_BOOMERANG_BIRD_POPUP, gameluaMenuListener)
  eventManager:addEventListener(events.EID_STAR_POPUP, gameluaMenuListener)
  eventManager:addEventListener(events.EID_REWARD_POPUP, gameluaMenuListener)
  eventManager:addEventListener(events.EID_LEVEL_PLAYED_WITH_EAGLE, gameluaMenuListener)
  eventManager:addEventListener(events.EID_THREE_STARS_GAINED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_EPISODE_THREE_STARRED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_STARS_GAINED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_WORLD_COMPLETED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_CHALLENGE_LEVEL_ENDED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_LEVEL_ENDED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_CHALLENGE_STARTED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_START_NEXT_CHALLENGE_LEVEL, gameluaMenuListener)
  eventManager:addEventListener(events.EID_GOTO_FACEBOOK_CONNECT, gameluaMenuListener)
  eventManager:addEventListener(events.EID_LEAVE_GAME, gameluaMenuListener)
  eventManager:addEventListener(events.EID_MIGHTY_EAGLE_PURCHASE_CLOSE_CLICKED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_MIGHTY_EAGLE_PURCHASE_CLICKED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_LEVEL_LOADING_INIT, gameluaMenuListener)
  eventManager:addEventListener(events.EID_SHOW_LOADING_PAGE, gameluaMenuListener)
  eventManager:addEventListener(events.EID_HIDE_LOADING_PAGE, gameluaMenuListener)
  eventManager:addEventListener(events.EID_LEVEL_LOADING_DONE, gameluaMenuListener)
  eventManager:addEventListener(events.EID_LOAD_INTRO_CUTSCENE, gameluaMenuListener)
  eventManager:addEventListener(events.EID_LOAD_END_CUTSCENE, gameluaMenuListener)
  eventManager:addEventListener(events.EID_PLAY_INTRO_CUTSCENE, gameluaMenuListener)
  eventManager:addEventListener(events.EID_PLAY_END_CUTSCENE, gameluaMenuListener)
  eventManager:addEventListener(events.EID_RETURN_TO_MENU_FROM_CUTSCENE, gameluaMenuListener)
  eventManager:addEventListener(events.EID_MIGHTY_EAGLE_BUTTON_CLICKED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_END_CUTSCENE_FINISHED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_GOTO_CREDITS, gameluaMenuListener)
  eventManager:addEventListener(events.EID_PAUSE_CLICKED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_BACK_TO_GAME_CLICKED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_LEVEL_RESTART_CLICKED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_EXIT_CONFIRMED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_FULLSCREEN_AD_SHOWING, gameluaMenuListener)
  eventManager:addEventListener(events.EID_FULLSCREEN_AD_DISMISSED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_GOOGLE_CHECKOUT_CLOSE_CLICKED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_OPERATOR_CHECKOUT_CLICKED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_GOOGLE_CHECKOUT_CLICKED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_POWERUP_WILL_BE_USED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_SHOW_TUTORIAL, gameluaMenuListener)
  eventManager:addEventListener(events.EID_CLOSE_TUTORIAL, gameluaMenuListener)
  eventManager:addEventListener(events.EID_SHOW_TUTORIALS, gameluaMenuListener)
  eventManager:addEventListener(events.EID_SKIP_TUTORIALS, gameluaMenuListener)
  eventManager:addEventListener(events.EID_ADS_PURCHASE_OFF_CLICKED_INGAME, gameluaMenuListener)
  eventManager:addEventListener(events.EID_ADS_PURCHASE_CLOSE_CLICKED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_ADS_PURCHASE_OFF_CLICKED, gameluaMenuListener)
  eventManager:addEventListener(events.EID_SHOW_REGISTRATION_DIALOG, gameluaMenuListener)
  eventManager:addEventListener(events.EID_UPDATE_GAME, gameluaMenuListener)
  eventManager:addEventListener(events.EID_TOGGLE_FULLSCREEN, gameluaMenuListener)
  if showEditor then
    eventManager:addEventListener(events.EID_LEVEL_ENDED, editorListener)
  end
  eventManager:addEventListener(events.EID_GIFT_PURCHASE_CLICKED, linkListener)
  eventManager:addEventListener(events.EID_AB_SHOP_CLICKED, linkListener)
  eventManager:addEventListener(events.EID_ALEX_CLICKED, linkListener)
  eventManager:addEventListener(events.EID_LENOVO_ADFREE_CLICKED, linkListener)
  eventManager:addEventListener(events.EID_NEWSLETTER_CLICKED, linkListener)
  eventManager:addEventListener(events.EID_SEASONS_CLICKED, linkListener)
  eventManager:addEventListener(events.EID_MIGHTY_EAGLE_TRAILER_CLICKED, linkListener)
  eventManager:addEventListener(events.EID_LEVEL_PLAYED_WITH_EAGLE, flurry)
  eventManager:addEventListener(events.EID_EAGLE_FEATHER_GAINED, flurry)
  eventManager:addEventListener(events.EID_NEW_HIGHSCORE, flurry)
  eventManager:addEventListener(events.EID_LEVEL_COMPLETE_FIRST_TIME, flurry)
  eventManager:addEventListener(events.EID_GOLDEN_EGG_COMPLETED, flurry)
  eventManager:addEventListener(events.EID_LEVEL_COMPLETED, flurry)
  eventManager:addEventListener(events.EID_LEVEL_FAILED, flurry)
  eventManager:addEventListener(events.EID_GOLDEN_EGG_FAILED, flurry)
  eventManager:addEventListener(events.EID_CHALLENGE_STARTED, flurry)
  eventManager:addEventListener(events.EID_CHALLENGE_STARTED_FIRSTTIME, flurry)
  eventManager:addEventListener(events.EID_CHALLENGE_RESTARTED, flurry)
  eventManager:addEventListener(events.EID_CHALLENGE_FAILED, flurry)
  eventManager:addEventListener(events.EID_CHALLENGE_COMPLETE, flurry)
  eventManager:addEventListener(events.EID_CHALLENGE_COMPLETE_FIRST_TIME, flurry)
  eventManager:addEventListener(events.EID_CHALLENGE_MENU_ENTERED, flurry)
  eventManager:addEventListener(events.EID_CHALLENGE_UNLOCKED, flurry)
  eventManager:addEventListener(events.EID_IAP_FAILED_OTHER, flurry)
  eventManager:addEventListener(events.EID_MIGHTYEAGLE_RESTORED, flurry)
  eventManager:addEventListener(events.EID_IAP_CANCELLED_BY_USER, flurry)
  eventManager:addEventListener(events.EID_MIGHTYEAGLE_PURCHASED, flurry)
  eventManager:addEventListener(events.EID_CRYSTAL_STARTED, flurry)
  eventManager:addEventListener(events.EID_FACEBOOK_LIKE_CLICKED, flurry)
  eventManager:addEventListener(events.EID_CHANGE_LEVEL, flurry)
  eventManager:addEventListener(events.EID_MAIN_MENU_ENTERED, flurry)
  eventManager:addEventListener(events.EID_MENUMANAGER_ROOT_CHANGED, flurry)
  eventManager:addEventListener(events.EID_CHANGE_SCENE, flurry)
  eventManager:addEventListener(events.EID_ABOUT_MENU_OPENED, flurry)
  eventManager:addEventListener(events.EID_GOTO_FACEBOOK_CONNECT, flurry)
  eventManager:addEventListener(events.EID_ABSHOP_LINK_CLICKED, flurry)
  eventManager:addEventListener(events.EID_GIFT_PURCHASE_CLICKED, flurry)
  eventManager:addEventListener(events.EID_FACEBOOK_LINK_CLICKED, flurry)
  eventManager:addEventListener(events.EID_TWITTER_LINK_CLICKED, flurry)
  eventManager:addEventListener(events.EID_SINA_WEIBO_LINK_CLICKED, flurry)
  eventManager:addEventListener(events.EID_TENCENT_WEIBO_LINK_CLICKED, flurry)
  eventManager:addEventListener(events.EID_QZONE_LINK_CLICKED, flurry)
  eventManager:addEventListener(events.EID_CINEMATIC_TRAILER_CLICKED, flurry)
  eventManager:addEventListener(events.EID_MIGHTY_EAGLE_TRAILER_CLICKED, flurry)
  eventManager:addEventListener(events.EID_SEASONS_LINK_CLICKED, flurry)
  eventManager:addEventListener(events.EID_NEWSLETTER_CLICKED, flurry)
  eventManager:addEventListener(events.EID_LEVEL_RESTARTED, flurry)
  eventManager:addEventListener(events.EID_FLURRY_EVENT_STARTED_BEFORE_COMPLETION, flurry)
  eventManager:addEventListener(events.EID_LEVEL_STARTED, flurry)
  eventManager:addEventListener(events.EID_GE_LEVEL_STARTED, flurry)
  eventManager:addEventListener(events.EID_GOLDEN_EGG_STAR_GAINED, flurry)
  eventManager:addEventListener(events.EID_GE_LEVEL_RESTARTED, flurry)
  eventManager:addEventListener(events.EID_MIGHTY_EAGLE_BUTTON_CLICKED, flurry)
  eventManager:addEventListener(events.EID_NOOK_STORE_ENTERED_FIRST_TIME, flurry)
  eventManager:addEventListener(events.EID_NOOK_STORE_EXITED, flurry)
  eventManager:addEventListener(events.EID_IAP_COMPLETED, flurry)
  eventManager:addEventListener(events.EID_ALEX_CLICKED, flurry)
  eventManager:addEventListener(events.EID_IAP_FAILED, flurry)
  eventManager:addEventListener(events.EID_SHOP_PURCHASE, flurry)
  eventManager:addEventListener(events.EID_POWERUP_WAS_USED, flurry)
  eventManager:addEventListener(events.EID_DAILYREWARD_RECEIVED, flurry)
  eventManager:addEventListener(events.EID_PARENTAL_LOCK_TOGGLED, flurry)
  eventManager:addEventListener(events.EID_LEVEL_COMPLETED_WITH_POWERUPS, flurry)
  eventManager:addEventListener(events.EID_PLAYER_RETURNED, flurry)
  eventManager:addEventListener(events.EID_MATTEL_STARTED, flurry)
  eventManager:addEventListener(events.EID_AD_SERVED, flurry)
  eventManager:addEventListener(events.EID_AD_REQUESTED, flurry)
  eventManager:addEventListener(events.EID_DO_LOADING, loaderSystem)
  eventManager:addEventListener(events.EID_MENUMANAGER_ROOT_CHANGED, adSystem)
  eventManager:addEventListener(events.EID_GAME_INITIALIZED, adSystem)
  eventManager:addEventListener(events.EID_LEVEL_LOADING_DONE, adSystem)
  eventManager:addEventListener(events.EID_GOTO_GAME, adSystem)
  eventManager:addEventListener(events.EID_ROVIO_NEWS_SHOWN, adSystem)
  if useDynamicAssets then
    eventManager:addEventListener(events.EID_LEAVE_GAME, dynamic)
    eventManager:addEventListener(events.EID_CURRENT_MENU_THEME_NEEDED, dynamic)
    eventManager:addEventListener(events.EID_CURRENT_MENU_THEME_NOT_NEEDED, dynamic)
  end
  Mattel:init()
  _G.table.insert(subSystemsList, achievementSystem)
  _G.table.insert(subSystemsList, loaderSystem)
  _G.table.insert(subSystemsList, Mattel)
  if deviceModel == "osx" then
    _G.table.insert(subSystemsList, {
      update = OSX.updateTrackpad
    })
  end
  if customerString == "nook" then
    _G.table.insert(subSystemsList, nook_subsystem)
  end
end
function generateRedirectURL(variant, target)
  return "http://cloud.rovio.com/link/redirect/?d=" .. deviceModel .. "&p=abc&a=" .. variant .. "&v=" .. gameVersionNumber .. "&t=" .. target .. "&r=game&c=" .. customerString
end
function createStartUpAssets()
  print("create startup assets\n")
  if deviceModel == "windows" then
    g_cameraProfileList = {
      deviceModel,
      "osx",
      "ipad",
      "iphone"
    }
  elseif deviceModel == "osx" then
    g_cameraProfileList = {
      deviceModel,
      "windows",
      "ipad",
      "iphone"
    }
  elseif deviceModel == "freebox" then
    g_cameraProfileList = {
      deviceModel,
      "windows",
      "osx",
      "ipad",
      "iphone"
    }
  elseif deviceModel == "roku" then
    g_cameraProfileList = {
      deviceModel,
      "windows",
      "osx",
      "ipad",
      "iphone"
    }
  elseif deviceModel == "iphone" then
    g_cameraProfileList = {
      deviceModel,
      "osx",
      "ipad",
      "iphone"
    }
  elseif deviceModel == "ipad" then
    g_cameraProfileList = {deviceModel, "iphone"}
  elseif deviceModel == "ipad3" then
    g_cameraProfileList = {
      deviceModel,
      "ipad",
      "iphone"
    }
  elseif deviceModel == "android" and isHDVersion or deviceModel == "blackberry" then
    g_cameraProfileList = {
      deviceModel,
      "ipad",
      "iphone"
    }
  else
    g_cameraProfileList = {deviceModel, "iphone"}
  end
  if useDynamicAssets then
    loadLuaFileToObject(scriptPath .. "/dynamicassets.lua", this, "_")
  end
  local variant = "full"
  if isLiteVersion then
    variant = "lite"
  end
  g_variant = variant
  if isHDVersion then
    variant = "HD"
  end
  if applyChinaRestictions then
    variant = variant .. "_china"
  end
  local appStoreFullType = "originalfull"
  local appStoreSeasonsFullType = "halloweenfull"
  local appStoreAlexFullType = "amazingalexfull"
  if customerString ~= "rovio" then
    appStoreFullType = appStoreFullType .. "_" .. customerString
    appStoreSeasonsFullType = appStoreSeasonsFullType .. "_" .. customerString
    appStoreAlexFullType = appStoreAlexFullType .. "_" .. customerString
  end
  APP_STORE_FULL_VERSION_URL = generateRedirectURL(variant, appStoreFullType)
  APP_STORE_HALLOWEEN_URL = generateRedirectURL(variant, appStoreSeasonsFullType)
  NEWSLETTER_URL = generateRedirectURL(variant, "newsletter")
  ANDROID_MARKET_FULL_VERSION_URL = generateRedirectURL("litebeta2", "originalfull")
  ALEX_URL = generateRedirectURL(variant, appStoreAlexFullType)
  REPORT_BUG_URL = generateRedirectURL("litebeta2", "reportbug")
  ANGRY_BIRDS_TRAILER_URL = generateRedirectURL(variant, "trailer")
  OVI_STORE_URL = generateRedirectURL(variant, "full")
  OVI_STORE_URL_S60 = generateRedirectURL("lite", "originalfull")
  OVI_STORE_MORE_GAMES_URL_S60 = generateRedirectURL(variant, "moregames")
  ROVIO_IN_OVI_STORE_URL = "http://store.ovi.com/publisher/RovioMobile/"
  LP1_IN_OVI_STORE_URL = generateRedirectURL(variant, "lp1")
  LP2_IN_OVI_STORE_URL = generateRedirectURL(variant, "lp2")
  FACEBOOK_URL = generateRedirectURL(variant, "facebook")
  TWITTER_URL = generateRedirectURL(variant, "twitterfollow")
  MIGHTY_EAGLE_TRAILER = generateRedirectURL(variant, "trailer2")
  SINA_WEIBO_URL = generateRedirectURL(variant, "weibo")
  TENCENT_WEIBO_URL = generateRedirectURL(variant, "tencentweibo")
  QZONE_URL = generateRedirectURL(variant, "qzone")
  ROVIO_UPDATE_URL_S60 = generateRedirectURL(variant, "checklatestfull")
  if applyChinaRestictions then
    ROVIO_UPDATE_URL_S60 = generateRedirectURL("full_china", "checklatestfull")
  end
  ABSHOP_URL = generateRedirectURL(variant, "shop")
  APPLE_GIFT_PURCHASE_URL = generateRedirectURL(variant, "purchasegift")
  LENOVO_NO_ADS_URL = generateRedirectURL(variant, "lenovonoads")
  RIO_CONTEST_URL = generateRedirectURL(variant, "riocontest")
  PRIVACY_POLICY_URL = generateRedirectURL(variant, "privacypolicy")
  EULA_URL = generateRedirectURL(variant, "eula")
  AB_FBCONNECT_URL = generateRedirectURL(variant, "facebooklike")
  ABLIKE_URL = generateRedirectURL(variant, "ablike")
  PC_SHOP_URL = "http://www.angrybirds.com/redirect.php?device=pc&product=angrybirds&variant=free&type=originalfullpc"
  if releaseBuild then
    MAIN_MENU_AD_URL = "http://cloud.rovio.com/content/embed/popup/?d=" .. deviceModel .. "&p=abc&a=" .. variant .. "&v=" .. gameVersionNumber .. "&sw=" .. screenWidth .. "&sh=" .. screenHeight .. "&i=" .. uniqueDeviceId .. "&c=" .. customerString
  else
    MAIN_MENU_AD_URL = "http://smoke.rovio.com/content/embed/popup/?d=" .. deviceModel .. "&p=abc&a=" .. variant .. "&v=" .. gameVersionNumber .. "&sw=" .. screenWidth .. "&sh=" .. screenHeight .. "&i=" .. uniqueDeviceId .. "&c=" .. customerString
  end
  if releaseBuild then
    ROVIO_NEWS_URL = "http://cloud.rovio.com/content/embed/pauseMenu/?d=" .. deviceModel .. "&p=abc&a=" .. variant .. "&v=" .. gameVersionNumber .. "&sw=" .. screenWidth .. "&sh=" .. screenHeight .. "&i=" .. uniqueDeviceId .. "&c=" .. customerString
  else
    ROVIO_NEWS_URL = "http://smoke.rovio.com/content/embed/pauseMenu/?d=" .. deviceModel .. "&p=abc&a=" .. variant .. "&v=" .. gameVersionNumber .. "&sw=" .. screenWidth .. "&sh=" .. screenHeight .. "&i=" .. uniqueDeviceId .. "&c=" .. customerString
  end
  uniqueDeviceId = uniqueDeviceId or "none"
  _G.res.createTextGroupSet(localizationPath .. "/TEXTS_BASIC.dat")
  if useDynamicAssets then
    dynamic.load("splashes")
  else
    loadImages({"SPLASHES"})
  end
  if deviceModel == "windows" or deviceModel == "osx" or deviceModel == "roku" or deviceModel == "freebox" then
    print("44.1kHz audio selected\n")
    _G.res.createAudioOutput(2, 16, 44100)
  else
    print("16kHz audio selected\n")
    _G.res.createAudioOutput(1, 16, 16000)
  end
  if deviceModel == "windows" or deviceModel == "osx" then
    if settingsWrapper:getFullscreen() then
      setFullScreenMode(true)
    else
      local w, h = settingsWrapper:getResolution()
      w = _G.math.max(w, 1024)
      h = _G.math.max(h, 600)
      setResolution(w, h)
    end
  end
end
function selectAssetProfile(group)
  local profileName = "480x320"
  local retina_groups = {
    "ACHIEVEMENTS",
    "BACKGROUNDS",
    "BUTTONS",
    "GOLDEN_EGGS",
    "HUD",
    "LEVELSELECTION",
    "MATTEL_SPLASH",
    "MATTEL_STARBLEND",
    "MENU",
    "REWARDS2",
    "SHOP",
    "SPLASHES",
    "TUTORIALS"
  }
  local retina_groups_iphone = {"CUTSCENES"}
  if deviceModel == "iphone" then
    if screenWidth == 960 and (contains(retina_groups, group) or contains(retina_groups_iphone, group)) then
      profileName = "480x320_retina"
    else
      profileName = "480x320"
    end
  elseif deviceModel == "iphone4" then
    if group == "HUD" or group == "REWARDS2" then
      profileName = "480x320_retina"
    else
      profileName = "480x320"
    end
  elseif deviceModel == "ipad" then
    if screenWidth == 2048 and contains(retina_groups, group) then
      profileName = "1024x768_retina"
    else
      profileName = "1024x768"
    end
  elseif deviceModel == "ipad3" then
    if group == "HUD" or group == "REWARDS2" then
      profileName = "1024x768_retina"
    else
      profileName = "1024x768"
    end
  elseif deviceModel == "n900" then
    profileName = "864x480"
  elseif deviceModel == "meego" then
    profileName = "864x480"
  elseif deviceModel == "bada" then
    if screenHeight < 480 then
      profileName = "480x320"
    else
      profileName = "864x480"
    end
  elseif deviceModel == "s60" then
    if applyChinaRestictions then
      if group == "CHINA" then
        profileName = "640x360_china"
      else
        profileName = "640x360"
      end
    else
      profileName = "640x360"
    end
  elseif deviceModel == "android" then
    if isHDVersion then
      if screenWidth <= 1024 and screenHeight <= 600 then
        if group == "SHOP" then
          profileName = "864x480"
        elseif group == "SPLASHES" then
          profileName = "1024x600"
        else
          profileName = "1024x768"
        end
        print("Group = " .. group .. " profileName = " .. profileName)
      else
        profileName = "1280x800"
      end
    elseif contains({
      "MENU",
      "BUTTONS",
      "GOLDEN_EGGS",
      "LEVELSELECTION",
      "TUTORIALS",
      "SHOP",
      "HUD",
      "REWARDS2"
    }, group) and screenHeight < 320 then
      profileName = "320x240_android_partial"
    elseif contains({
      "MENU",
      "BUTTONS",
      "GOLDEN_EGGS",
      "LEVELSELECTION",
      "TUTORIALS",
      "SHOP",
      "HUD",
      "REWARDS2"
    }, group) and screenHeight < 480 then
      profileName = "480x320_android_partial"
    else
      profileName = "864x480"
    end
  elseif deviceModel == "windows" then
    profileName = "pc"
  elseif deviceModel == "osx" then
    profileName = "pc"
  elseif deviceModel == "freebox" then
    profileName = "pc"
  elseif deviceModel == "blackberry" then
    if group == "SPLASHES" then
      profileName = "1024x600"
    else
      profileName = "1024x768"
    end
  end
  return profileName
end
function selectFontProfile()
  local profileName = "480x320"
  if deviceModel == "iphone" or deviceModel == "iphone4" then
    if screenWidth == 960 then
      profileName = "960x640"
    else
      profileName = "480x320"
    end
  elseif deviceModel == "meego" then
    profileName = "864x480"
  elseif deviceModel == "ipad" or deviceModel == "ipad3" then
    if screenWidth == 2048 then
      profileName = "2048x1536"
    else
      profileName = "1024x768"
    end
  elseif deviceModel == "bada" then
    if screenHeight < 480 then
      profileName = "480x320"
    else
      profileName = "864x480"
    end
  elseif deviceModel == "s60" then
    profileName = "640x360"
  elseif deviceModel == "android" then
    if screenHeight < 320 then
      profileName = "320x240"
    elseif screenHeight < 480 then
      profileName = "480x320"
    else
      profileName = "864x480"
    end
  elseif deviceModel == "windows" then
    profileName = "pc"
  elseif deviceModel == "osx" then
    profileName = "pc"
  elseif deviceModel == "roku" then
    if not g_isRokuSD then
      profileName = "pc"
    else
      profileName = "640x360"
    end
  elseif deviceModel == "freebox" then
    profileName = "pc"
  elseif deviceModel == "blackberry" then
    profileName = "1024x768"
  end
  return profileName
end
function loadLoadList(profile)
  if loadlist[profile] == nil then
    loadLuaFileToObject(imagePath .. "/" .. profile .. "/loadlist.lua", this.loadlist, profile)
    for k, v in _G.pairs(this.loadlist[profile].assetLoadList[profile]) do
      this.loadlist[profile][k] = v
    end
    this.loadlist[profile].assetLoadList = nil
  end
end
function loadAssets(groups)
  for _, v in _G.ipairs(groups) do
    local profile = selectAssetProfile(v)
    loadLoadList(profile)
    local files = loadlist[profile][v]
    if files then
      for _, v2 in _G.ipairs(files) do
        if v2[2] == 0 then
          _G.res.createSpriteSheet(imagePath .. "/" .. profile .. "/" .. v2[1])
        elseif v2[2] == 1 then
          print("Loading compo sprite set " .. imagePath .. "/" .. profile .. "/" .. v2[1] .. "\n")
          _G.res.createCompoSpriteSet(imagePath .. "/" .. profile .. "/" .. v2[1])
        elseif v2[2] == 2 then
        end
      end
    end
  end
end
function releaseAssets(groups)
  for _, v in _G.ipairs(groups) do
    local profile = selectAssetProfile(v)
    loadLoadList(profile)
    local files = loadlist[profile][v]
    if files then
      for _, v2 in _G.ipairs(files) do
        if v2[2] == 0 then
          _G.res.releaseSpriteSheet(imagePath .. "/" .. profile .. "/" .. v2[1])
        elseif v2[2] == 1 then
          print("Loading compo sprite set " .. imagePath .. "/" .. profile .. "/" .. v2[1] .. "\n")
          _G.res.releaseCompoSpriteSet(imagePath .. "/" .. profile .. "/" .. v2[1])
        elseif v2[2] == 2 then
        end
      end
    end
  end
end
loadImages = loadAssets
loadCompoSprites = loadAssets
releaseImages = releaseAssets
releaseCompoSprites = releaseAssets
function setupFonts()
  fontBasic = _G.res.getString("TEXTS_BASIC", "FONT_BASIC")
  fontMenu = _G.res.getString("TEXTS_BASIC", "FONT_MENU")
  fontScore = _G.res.getString("TEXTS_BASIC", "FONT_HIGHSCORE")
end
function getFontBasic()
  return fontBasic
end
function getFontMenu()
  return fontMenu
end
function getFontScore()
  return fontScore
end
function loadFonts()
  local profileName = selectFontProfile()
  setupFonts()
  _G.res.createBitmapFont(fontPath .. "/" .. profileName .. "/" .. fontMenu .. ".dat")
  _G.res.createBitmapFont(fontPath .. "/" .. profileName .. "/FONT_BASIC.dat")
  _G.res.createBitmapFont(fontPath .. "/" .. profileName .. "/FONT_SCORE.dat")
  _G.res.createBitmapFont(fontPath .. "/" .. profileName .. "/FONT_LS_SMALL.dat")
  _G.res.createBitmapFont(fontPath .. "/" .. profileName .. "/FONT_CHALLENGE_SCORE.dat")
  _G.res.createBitmapFont(fontPath .. "/" .. profileName .. "/FONT_CURRENT_HIGHSCORE.dat")
  loadLocaleFonts()
  if gameCenterSupported or not releaseBuild and iOS then
    _G.res.createBitmapFont(fontPath .. "/" .. profileName .. "/FONT_GAMECENTER_BASIC.dat")
  end
  if deviceModel == "iphone" or deviceModel == "iphone4" then
    _G.res.createBitmapFont(fontPath .. "/" .. profileName .. "/FONT_POWERUP_AMOUNT.dat")
  end
end
function loadLocaleFonts()
  local profileName = selectFontProfile()
  if deviceModel ~= "windows" and deviceModel ~= "osx" and deviceModel ~= "roku" and deviceModel ~= "freebox" then
    if _G.res.getLocale() == "zh_CN" or _G.res.getLocale() == "zh_TW" then
      _G.res.createBitmapFont(fontPath .. "/" .. profileName .. "/FONT_HIGHSCORE_CHINESE.dat")
      _G.res.createBitmapFont(fontPath .. "/" .. profileName .. "/FONT_BASIC_CHINESE.dat")
    else
      _G.res.releaseFont(fontPath .. "/" .. profileName .. "/FONT_HIGHSCORE_CHINESE.dat")
      _G.res.releaseFont(fontPath .. "/" .. profileName .. "/FONT_BASIC_CHINESE.dat")
    end
  end
end
function changeLocale(locale)
  print("LOCAL CHANGED TO " .. locale .. "\n")
  _G.res.loadLocale("TEXTS_BASIC", locale)
  _G.res.useLocale(locale)
  setupFonts()
  loadLocaleFonts()
  menuManager:gameResumed()
end
function loadAllThemeGraphics()
  for k, v in _G.pairs(blockTable.themes) do
    if k ~= "settings" then
      for _, v2 in _G.ipairs(v.graphicSetName) do
        loadAssets({v2})
      end
    end
  end
end
currentGFXSet = {}
function loadThemeGraphics(name)
  print("<THEME> == loading theme graphics ==\n")
  local themeName = blockTable.themes[name].graphicSetName
  if _G.type(themeName) == "string" then
    themeName = {themeName}
  end
  local load = Set.difference(themeName, currentGFXSet)
  local release = Set.difference(currentGFXSet, themeName)
  if #load == 0 then
    print("<THEME> not loading anything\n")
  end
  for _, v in _G.ipairs(release) do
    print("<THEME> releasing graphics set : " .. v .. "\n")
    releaseAssets({v})
  end
  currentGFXSet = themeName
  for _, v in _G.ipairs(load) do
    print("<THEME> loading graphics set : " .. v .. "\n")
    loadAssets({v})
  end
end
function createAssets()
  if settingsWrapper:getSettingsVersion().id ~= 1 then
    settingsWrapper:convertSettings()
  end
  loadFonts()
  defaultMenuFont = fontBasic
  setFont(defaultMenuFont)
  if useDynamicAssets then
    dynamic.load({
      "common",
      "mainMenuRoot",
      settingsWrapper:getCurrentMainMenuTheme()
    })
  else
    loadImages({
      "INGAME",
      "OTHER",
      "ACHIEVEMENTS",
      "MENU",
      "LEVELSELECTION",
      "POPUPS",
      "BUTTONS",
      "TUTORIALS",
      "CURSORS",
      "REWARDS2"
    })
    loadAssets({"HUD"})
    loadBackgrounds()
    if applyChinaRestictions then
      loadImages({"CHINA"})
    end
    loadCompoSprites({
      "INGAME_COMPOSPRITES",
      "ROVIO_NEWS_COMPOSPRITES",
      "BUTTONS_COMPOSPRITES",
      "MENU_COMPOSPRITES"
    })
  end
  function createAudio(params)
    local stream = g_streamSounds
    if params.alwaysStream then
      stream = true
    end
    local extension = params.extension or "wav"
    if g_useMp3Sound and params.extension == nil then
      extension = "mp3"
    end
    local fileName = params.fileName .. "." .. extension
    _G.res.createAudio(fileName, params.clipName, stream)
  end
  createAudio({
    fileName = audioPath .. "/sfx/bird 01 collision a1",
    clipName = "bird 01 collision a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 01 collision a2",
    clipName = "bird 01 collision a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 01 collision a3",
    clipName = "bird 01 collision a3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 01 collision a4",
    clipName = "bird 01 collision a4"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 01 collision a1_low",
    clipName = "bird 01 collision a1_low"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 01 collision a2_low",
    clipName = "bird 01 collision a2_low"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 01 collision a3_low",
    clipName = "bird 01 collision a3_low"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 01 collision a4_low",
    clipName = "bird 01 collision a4_low"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 01 flying",
    clipName = "bird_01_flying"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bigbrother_fly",
    clipName = "big_brother_flying"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bigbrother_awakens",
    clipName = "big_brother_awakens"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 01 select",
    clipName = "bird_01_select"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bigbrother_select",
    clipName = "big_brother_select"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 02 collision a1",
    clipName = "bird 02 collision a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 02 collision a2",
    clipName = "bird 02 collision a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 02 collision a3",
    clipName = "bird 02 collision a3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 02 collision a4",
    clipName = "bird 02 collision a4"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 02 collision a5",
    clipName = "bird 02 collision a5"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 02 flying",
    clipName = "bird_02_flying"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 02 select",
    clipName = "bird_02_select"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 03 collision a1",
    clipName = "bird 03 collision a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 03 collision a2",
    clipName = "bird 03 collision a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 03 collision a3",
    clipName = "bird 03 collision a3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 03 collision a4",
    clipName = "bird 03 collision a4"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 03 collision a5",
    clipName = "bird 03 collision a5"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 03 flying",
    clipName = "bird_03_flying"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 03 select",
    clipName = "bird_03_select"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 04 flying",
    clipName = "bird_04_flying"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 04 select",
    clipName = "bird_04_select"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 04 collision a1",
    clipName = "bird 04 collision a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 04 collision a2",
    clipName = "bird 04 collision a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 04 collision a3",
    clipName = "bird 04 collision a3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 04 collision a4",
    clipName = "bird 04 collision a4"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 05 collision a1",
    clipName = "bird 05 collision a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 05 collision a2",
    clipName = "bird 05 collision a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 05 collision a3",
    clipName = "bird 05 collision a3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 05 collision a4",
    clipName = "bird 05 collision a4"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 05 collision a5",
    clipName = "bird 05 collision a5"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 05 flying",
    clipName = "bird_05_flying"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird 05 select",
    clipName = "bird_05_select"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird_06_flying",
    clipName = "bird_06_flying"
  })
  createAudio({
    fileName = audioPath .. "/sfx/boomerang_select",
    clipName = "boomerang_select"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird misc a1",
    clipName = "bird_misc_a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird misc a2",
    clipName = "bird_misc_a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird misc a3",
    clipName = "bird_misc_a3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird misc a4",
    clipName = "bird_misc_a4"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird misc a5",
    clipName = "bird_misc_a5"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird misc a6",
    clipName = "bird_misc_a6"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird misc a7",
    clipName = "bird_misc_a7"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird misc a8",
    clipName = "bird_misc_a8"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird misc a9",
    clipName = "bird_misc_a9"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird misc a10",
    clipName = "bird_misc_a10"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird misc a11",
    clipName = "bird_misc_a11"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird misc a12",
    clipName = "bird_misc_a12"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird destroyed",
    clipName = "bird_destroyed"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird next military a1",
    clipName = "bird next military a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird next military a2",
    clipName = "bird next military a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird next military a3",
    clipName = "bird next military a3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird shot-a1",
    clipName = "bird shot a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird shot-a2",
    clipName = "bird shot a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird shot-a3",
    clipName = "bird shot a3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/level clear military a1",
    extension = "mp3",
    alwaysStream = true,
    clipName = "level clear military a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/level clear military a2",
    extension = "mp3",
    alwaysStream = true,
    clipName = "level clear military a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/level failed piglets a1",
    extension = "mp3",
    alwaysStream = true,
    clipName = "level failed piglets a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/level failed piglets a2",
    extension = "mp3",
    alwaysStream = true,
    clipName = "level failed piglets a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/level start military a1",
    extension = "mp3",
    alwaysStream = true,
    clipName = "level start military a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/level start military a2",
    extension = "mp3",
    alwaysStream = true,
    clipName = "level start military a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/ice light collision a1",
    clipName = "light collision a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/ice light collision a2",
    clipName = "light collision a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/ice light collision a3",
    clipName = "light collision a3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/ice light collision a4",
    clipName = "light collision a4"
  })
  createAudio({
    fileName = audioPath .. "/sfx/ice light collision a5",
    clipName = "light collision a5"
  })
  createAudio({
    fileName = audioPath .. "/sfx/ice light collision a6",
    clipName = "light collision a6"
  })
  createAudio({
    fileName = audioPath .. "/sfx/ice light collision a7",
    clipName = "light collision a7"
  })
  createAudio({
    fileName = audioPath .. "/sfx/ice light collision a8",
    clipName = "light collision a8"
  })
  createAudio({
    fileName = audioPath .. "/sfx/light damage a1",
    clipName = "light damage a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/light damage a2",
    clipName = "light damage a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/light damage a3",
    clipName = "light damage a3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/light destroyed a1",
    clipName = "light destroyed a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/light destroyed a2",
    clipName = "light destroyed a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/light destroyed a3",
    clipName = "light destroyed a3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/light rolling",
    clipName = "light_rolling"
  })
  createAudio({
    fileName = audioPath .. "/sfx/menu back",
    clipName = "menu_back"
  })
  createAudio({
    fileName = audioPath .. "/sfx/menu confirm",
    clipName = "menu_confirm"
  })
  createAudio({
    fileName = audioPath .. "/sfx/menu select",
    clipName = "menu_select"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette collision a1",
    clipName = "piglette collision a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette collision a2",
    clipName = "piglette collision a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette collision a3",
    clipName = "piglette collision a3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette collision a4",
    clipName = "piglette collision a4"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette collision a5",
    clipName = "piglette collision a5"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette collision a6",
    clipName = "piglette collision a6"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette collision a7",
    clipName = "piglette collision a7"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette collision a8",
    clipName = "piglette collision a8"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette damage a1",
    clipName = "piglette damage a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette damage a2",
    clipName = "piglette damage a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette damage a3",
    clipName = "piglette damage a3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette damage a4",
    clipName = "piglette damage a4"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette damage a5",
    clipName = "piglette damage a5"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette damage a6",
    clipName = "piglette damage a6"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette damage a7",
    clipName = "piglette damage a7"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette damage a8",
    clipName = "piglette damage a8"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette destroyed",
    clipName = "piglette_destroyed"
  })
  createAudio({
    fileName = audioPath .. "/sfx/rock collision a1",
    clipName = "rock collision a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/rock collision a2",
    clipName = "rock collision a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/rock collision a3",
    clipName = "rock collision a3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/rock collision a4",
    clipName = "rock collision a4"
  })
  createAudio({
    fileName = audioPath .. "/sfx/rock collision a5",
    clipName = "rock collision a5"
  })
  createAudio({
    fileName = audioPath .. "/sfx/rock damage a1",
    clipName = "rock damage a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/rock damage a2",
    clipName = "rock damage a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/rock damage a3",
    clipName = "rock damage a3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/rock destroyed a1",
    clipName = "rock destroyed a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/rock destroyed a2",
    clipName = "rock destroyed a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/rock destroyed a3",
    clipName = "rock destroyed a3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/rock rolling",
    clipName = "rock_rolling"
  })
  createAudio({
    fileName = audioPath .. "/sfx/special boost",
    clipName = "special_boost"
  })
  createAudio({
    fileName = audioPath .. "/sfx/special egg explosion",
    clipName = "special_explosion"
  })
  createAudio({
    fileName = audioPath .. "/sfx/special group",
    clipName = "special_egg"
  })
  createAudio({
    fileName = audioPath .. "/sfx/special egg",
    clipName = "special_group"
  })
  createAudio({
    fileName = audioPath .. "/sfx/wood collision a1",
    clipName = "wood collision a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/wood collision a2",
    clipName = "wood collision a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/wood collision a3",
    clipName = "wood collision a3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/wood collision a4",
    clipName = "wood collision a4"
  })
  createAudio({
    fileName = audioPath .. "/sfx/wood collision a5",
    clipName = "wood collision a5"
  })
  createAudio({
    fileName = audioPath .. "/sfx/wood collision a6",
    clipName = "wood collision a6"
  })
  createAudio({
    fileName = audioPath .. "/sfx/wood damage a1",
    clipName = "wood damage a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/wood damage a2",
    clipName = "wood damage a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/wood damage a3",
    clipName = "wood damage a3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/wood destroyed a1",
    clipName = "wood destroyed a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/wood destroyed a2",
    clipName = "wood destroyed a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/wood destroyed a3",
    clipName = "wood destroyed a3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/wood rolling",
    clipName = "wood_rolling"
  })
  createAudio({
    fileName = audioPath .. "/sfx/balloon_pop",
    clipName = "balloon_pop"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bird pushing egg out",
    clipName = "bird_pushing_egg_out"
  })
  createAudio({
    fileName = audioPath .. "/sfx/slingshot streched",
    clipName = "slingshot_stretched"
  })
  createAudio({
    fileName = audioPath .. "/sfx/tnt box explodes",
    clipName = "tnt_explodes"
  })
  createAudio({
    fileName = audioPath .. "/sfx/boomerang_swish",
    clipName = "boomerang_swish"
  })
  createAudio({
    fileName = audioPath .. "/sfx/boomerang_activate",
    clipName = "boomerang_activate"
  })
  createAudio({
    fileName = audioPath .. "/sfx/trampoline",
    clipName = "trampoline"
  })
  createAudio({
    fileName = audioPath .. "/sfx/redbird_yell01",
    clipName = "red_special_1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/redbird_yell02",
    clipName = "red_special_2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/redbird_yell03",
    clipName = "red_special_3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bigbrother_yell",
    clipName = "big_brother_special_1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/mightyeagle",
    clipName = "mighty_eagle_yell"
  })
  createAudio({
    fileName = audioPath .. "/sfx/sardine_can_shot",
    extension = "mp3",
    alwaysStream = true,
    clipName = "sardine_can_shot"
  })
  createAudio({
    fileName = audioPath .. "/sfx/sardine_can_physics_a2",
    extension = "mp3",
    alwaysStream = true,
    clipName = "sardine_can_physics_a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/mighty_eagle_bounce",
    extension = "mp3",
    alwaysStream = true,
    clipName = "mighty_eagle_thump"
  })
  createAudio({
    fileName = audioPath .. "/sfx/mighty_eagle_fly",
    extension = "mp3",
    alwaysStream = true,
    clipName = "mighty_eagle_fly"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette oink a1",
    clipName = "piglette_a1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette oink a2",
    clipName = "piglette_a2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette oink a3",
    clipName = "piglette_a3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette oink a4",
    clipName = "piglette_a4"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette oink a5",
    clipName = "piglette_a5"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette oink a8",
    clipName = "piglette_a8"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette oink a9",
    clipName = "piglette_a9"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette oink a10",
    clipName = "piglette_a10"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette oink a11",
    clipName = "piglette_a11"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette oink a12",
    clipName = "piglette_a12"
  })
  createAudio({
    fileName = audioPath .. "/sfx/star_collect",
    clipName = "star_collect"
  })
  createAudio({
    fileName = audioPath .. "/sfx/button_radio",
    clipName = "button_radio"
  })
  createAudio({
    fileName = audioPath .. "/sfx/goldenegg",
    clipName = "goldenegg"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piano-c",
    clipName = "noteC"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piano-cis",
    clipName = "noteCis"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piano-d",
    clipName = "noteD"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piano-dis",
    clipName = "noteDis"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piano-e",
    clipName = "noteE"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piano-f",
    clipName = "noteF"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piano-fis",
    clipName = "noteFis"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piano-g",
    clipName = "noteG"
  })
  createAudio({
    fileName = audioPath .. "/music/level_complete",
    extension = "mp3",
    alwaysStream = true,
    clipName = "level_complete"
  })
  createAudio({
    fileName = audioPath .. "/music/game_complete",
    extension = "mp3",
    alwaysStream = true,
    clipName = "game_complete"
  })
  createAudio({
    fileName = audioPath .. "/music/title_theme",
    extension = "mp3",
    alwaysStream = true,
    clipName = "title_theme"
  })
  createAudio({
    fileName = audioPath .. "/music/ambient_white_dryforest",
    extension = "mp3",
    alwaysStream = true,
    clipName = "ambient_theme1"
  })
  createAudio({
    fileName = audioPath .. "/music/ambient_green_jungleish",
    extension = "mp3",
    alwaysStream = true,
    clipName = "ambient_theme2"
  })
  createAudio({
    fileName = audioPath .. "/music/ambient_red_savannah",
    extension = "mp3",
    alwaysStream = true,
    clipName = "ambient_theme3"
  })
  createAudio({
    fileName = audioPath .. "/music/ambient_city",
    extension = "mp3",
    alwaysStream = true,
    clipName = "ambient_theme7"
  })
  createAudio({
    fileName = audioPath .. "/music/birds_outro",
    extension = "mp3",
    alwaysStream = true,
    clipName = "birds_outro"
  })
  createAudio({
    fileName = audioPath .. "/music/birds_intro",
    extension = "mp3",
    alwaysStream = true,
    clipName = "birds_intro"
  })
  createAudio({
    fileName = audioPath .. "/music/birds_boss",
    extension = "mp3",
    alwaysStream = true,
    clipName = "birds_boss"
  })
  createAudio({
    fileName = audioPath .. "/music/funky_theme",
    extension = "mp3",
    alwaysStream = true,
    clipName = "funky_theme"
  })
  createAudio({
    fileName = audioPath .. "/sfx/piglette oink story",
    clipName = "piglette_oink_story"
  })
  createAudio({
    fileName = audioPath .. "/sfx/ball_bounce",
    clipName = "ball_bounce"
  })
  createAudio({
    fileName = audioPath .. "/music/ambient_construction",
    extension = "mp3",
    alwaysStream = true,
    clipName = "construction_theme1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/pig_bd",
    clipName = "pig_bd"
  })
  createAudio({
    fileName = audioPath .. "/sfx/pig_snare_1",
    clipName = "pig_snare_1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/pig_snare_2",
    clipName = "pig_snare_2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/pig_snare_3",
    clipName = "pig_snare_3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/pig_snare_4",
    clipName = "pig_snare_4"
  })
  createAudio({
    fileName = audioPath .. "/sfx/pig_hi-hat_1",
    clipName = "pig_hi-hat_1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/pig_hi-hat_2",
    clipName = "pig_hi-hat_2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/cminor_left",
    clipName = "cminor_left"
  })
  createAudio({
    fileName = audioPath .. "/sfx/dismajor_left",
    clipName = "dismajor_left"
  })
  createAudio({
    fileName = audioPath .. "/sfx/fmajor_left",
    clipName = "fmajor_left"
  })
  createAudio({
    fileName = audioPath .. "/sfx/gminor_left",
    clipName = "gminor_left"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bmajor_left",
    clipName = "bmajor_left"
  })
  createAudio({
    fileName = audioPath .. "/sfx/cminor_right",
    clipName = "cminor_right"
  })
  createAudio({
    fileName = audioPath .. "/sfx/dismajor_right",
    clipName = "dismajor_right"
  })
  createAudio({
    fileName = audioPath .. "/sfx/fmajor_right",
    clipName = "fmajor_right"
  })
  createAudio({
    fileName = audioPath .. "/sfx/gminor_right",
    clipName = "gminor_right"
  })
  createAudio({
    fileName = audioPath .. "/sfx/bmajor_right",
    clipName = "bmajor_right"
  })
  createAudio({
    fileName = audioPath .. "/sfx/accordion_empty_pull",
    clipName = "empty_accordion_left"
  })
  createAudio({
    fileName = audioPath .. "/sfx/accordion_empty_push",
    clipName = "empty_accordion_right"
  })
  createAudio({
    fileName = audioPath .. "/sfx/accordion_break",
    clipName = "accordion_break"
  })
  createAudio({
    fileName = audioPath .. "/sfx/pig_singing_1",
    clipName = "pig_singing_1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/pig_singing_2",
    clipName = "pig_singing_2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/pig_singing_3",
    clipName = "pig_singing_3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/pig_singing_4",
    clipName = "pig_singing_4"
  })
  createAudio({
    fileName = audioPath .. "/sfx/pig_singing_5",
    clipName = "pig_singing_5"
  })
  createAudio({
    fileName = audioPath .. "/sfx/pig_singing_6",
    clipName = "pig_singing_6"
  })
  createAudio({
    fileName = audioPath .. "/sfx/pig_singing_7",
    clipName = "pig_singing_7"
  })
  createAudio({
    fileName = audioPath .. "/sfx/pig_singing_8",
    clipName = "pig_singing_8"
  })
  createAudio({
    fileName = audioPath .. "/music/ab_cave_ambient",
    extension = "mp3",
    alwaysStream = true,
    clipName = "ambient_cave"
  })
  createAudio({
    fileName = audioPath .. "/sfx/jewel_break_01",
    clipName = "jewel_break_1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/jewel_break_02",
    clipName = "jewel_break_2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/jewel_break_03",
    clipName = "jewel_break_3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/stalaktite_break_01",
    clipName = "stalaktite_break_1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/stalaktite_break_02",
    clipName = "stalaktite_break_2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/stalaktite_break_03",
    clipName = "stalaktite_break_3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/gamescorescreen_score_count_loop",
    extension = "wav",
    clipName = "score_count"
  })
  createAudio({
    fileName = audioPath .. "/sfx/star_1",
    alwaysStream = true,
    clipName = "star_1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/star_2",
    alwaysStream = true,
    clipName = "star_2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/star_3",
    alwaysStream = true,
    clipName = "star_3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/highscore",
    extension = "mp3",
    alwaysStream = true,
    clipName = "new_highscore"
  })
  createAudio({
    fileName = audioPath .. "/music/ambience_waterfall",
    extension = "mp3",
    alwaysStream = true,
    clipName = "ambience_waterfall"
  })
  createAudio({
    fileName = audioPath .. "/sfx/big_bird",
    clipName = "big_bird"
  })
  createAudio({
    fileName = audioPath .. "/sfx/earthquake",
    clipName = "earthquake"
  })
  createAudio({
    fileName = audioPath .. "/sfx/laser_sight",
    clipName = "laser_sight"
  })
  createAudio({
    fileName = audioPath .. "/sfx/powerup_intro",
    clipName = "powerup_intro"
  })
  createAudio({
    fileName = audioPath .. "/sfx/slot_1",
    clipName = "slot_1"
  })
  createAudio({
    fileName = audioPath .. "/sfx/slot_2",
    clipName = "slot_2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/slot_3",
    clipName = "slot_3"
  })
  createAudio({
    fileName = audioPath .. "/sfx/slot_machine",
    clipName = "slot_machine"
  })
  createAudio({
    fileName = audioPath .. "/sfx/super_shot",
    clipName = "super_shot"
  })
  createAudio({
    fileName = audioPath .. "/sfx/super_slingshot",
    clipName = "super_slingshot"
  })
  createAudio({
    fileName = audioPath .. "/sfx/powerup_awarded",
    clipName = "powerup_awarded"
  })
  createAudio({
    fileName = audioPath .. "/sfx/powerup_awarded2",
    clipName = "powerup_awarded2"
  })
  createAudio({
    fileName = audioPath .. "/sfx/Globe_Bird_Death_remove_1",
    clipName = "Globe_Bird_Death_remove_1",
    volume = 1
  })
  createAudio({
    fileName = audioPath .. "/sfx/Globe_Bird_Hit_1",
    clipName = "Globe_Bird_Hit_1",
    volume = 1
  })
  createAudio({
    fileName = audioPath .. "/sfx/Globe_Bird_Hit_2",
    clipName = "Globe_Bird_Hit_2",
    volume = 1
  })
  createAudio({
    fileName = audioPath .. "/sfx/Globe_Bird_Hit_3",
    clipName = "Globe_Bird_Hit_3",
    volume = 1
  })
  createAudio({
    fileName = audioPath .. "/sfx/Globe_Bird_Hit_4",
    clipName = "Globe_Bird_Hit_4",
    volume = 1
  })
  createAudio({
    fileName = audioPath .. "/sfx/Globe_Bird_idle_01",
    clipName = "Globe_Bird_idle_01",
    volume = 1
  })
  createAudio({
    fileName = audioPath .. "/sfx/Globe_Bird_idle_02",
    clipName = "Globe_Bird_idle_02",
    volume = 1
  })
  createAudio({
    fileName = audioPath .. "/sfx/Globe_Bird_idle_03",
    clipName = "Globe_Bird_idle_03",
    volume = 1
  })
  createAudio({
    fileName = audioPath .. "/sfx/Globe_Bird_Launch_3",
    clipName = "Globe_Bird_Launch_3",
    volume = 1
  })
  createAudio({
    fileName = audioPath .. "/sfx/Globe_Bird_Special_Activation_1",
    clipName = "Globe_Bird_Special_Activation_1",
    volume = 1
  })
  createAudio({
    fileName = audioPath .. "/sfx/Globe_Bird_Special_Activation_2",
    clipName = "Globe_Bird_Special_Activation_2",
    volume = 1
  })
  createAudio({
    fileName = audioPath .. "/sfx/Globe_Bird_Special_Activation_3",
    clipName = "Globe_Bird_Special_Activation_3",
    volume = 1
  })
  createAudio({
    fileName = audioPath .. "/sfx/Globe_Bird_Selection_1",
    clipName = "Globe_Bird_Selection_1",
    volume = 1
  })
  createAudio({
    fileName = audioPath .. "/music/birthday_ambience",
    extension = "mp3",
    alwaysStream = true,
    clipName = "birthday_ambience",
    volume = 1
  })
  createAudio({
    fileName = audioPath .. "/sfx/birthday_cake1",
    clipName = "birthday_cake1",
    volume = 1
  })
  createAudio({
    fileName = audioPath .. "/sfx/birthday_cake2",
    clipName = "birthday_cake2",
    volume = 1
  })
  createAudio({
    fileName = audioPath .. "/music/BeachAmbience",
    extension = "mp3",
    alwaysStream = true,
    clipName = "beach_ambience"
  })
  createAudio({
    fileName = audioPath .. "/music/RainAmbience",
    extension = "mp3",
    alwaysStream = true,
    clipName = "rain_ambience"
  })
  audioGroups = {
    bird_01_collision = {
      "bird 01 collision a1",
      "bird 01 collision a2",
      "bird 01 collision a3",
      "bird 01 collision a4"
    },
    bird_02_collision = {
      "bird 02 collision a1",
      "bird 02 collision a2",
      "bird 02 collision a3",
      "bird 02 collision a4",
      "bird 02 collision a5"
    },
    bird_03_collision = {
      "bird 03 collision a1",
      "bird 03 collision a2",
      "bird 03 collision a3",
      "bird 03 collision a4",
      "bird 03 collision a5"
    },
    bird_04_collision = {
      "bird 04 collision a1",
      "bird 04 collision a2",
      "bird 04 collision a3",
      "bird 04 collision a4"
    },
    bird_05_collision = {
      "bird 05 collision a1",
      "bird 05 collision a2",
      "bird 05 collision a3",
      "bird 05 collision a4",
      "bird 05 collision a5"
    },
    big_brother_collision = {
      "bird 01 collision a1_low",
      "bird 01 collision a2_low",
      "bird 01 collision a3_low",
      "bird 01 collision a4_low"
    },
    bird_next = {
      "bird next a1",
      "bird next a2",
      "bird next a3"
    },
    bird_next_military = {
      "bird next military a1",
      "bird next military a2",
      "bird next military a3"
    },
    bird_shot = {
      "bird shot a1",
      "bird shot a2",
      "bird shot a3"
    },
    level_clear_military = {
      "level clear military a1",
      "level clear military a2"
    },
    level_failed_piglets = {
      "level failed piglets a1",
      "level failed piglets a2"
    },
    level_start_military = {
      "level start military a1",
      "level start military a2"
    },
    light_collision = {
      "light collision a1",
      "light collision a2",
      "light collision a3",
      "light collision a4",
      "light collision a5",
      "light collision a6",
      "light collision a7",
      "light collision a8"
    },
    light_damage = {
      "light damage a1",
      "light damage a2",
      "light damage a3"
    },
    light_destroyed = {
      "light destroyed a1",
      "light destroyed a2",
      "light destroyed a3"
    },
    piglette_collision = {
      "piglette collision a1",
      "piglette collision a2",
      "piglette collision a3",
      "piglette collision a4",
      "piglette collision a5",
      "piglette collision a6",
      "piglette collision a7",
      "piglette collision a8"
    },
    piglette_damage = {
      "piglette damage a1",
      "piglette damage a2",
      "piglette damage a3",
      "piglette damage a4",
      "piglette damage a5",
      "piglette damage a6",
      "piglette damage a7",
      "piglette damage a8"
    },
    rock_collision = {
      "rock collision a1",
      "rock collision a2",
      "rock collision a3",
      "rock collision a4",
      "rock collision a5"
    },
    rock_damage = {
      "rock damage a1",
      "rock damage a2",
      "rock damage a3"
    },
    rock_destroyed = {
      "rock destroyed a1",
      "rock destroyed a2",
      "rock destroyed a3"
    },
    wood_collision = {
      "wood collision a1",
      "wood collision a2",
      "wood collision a3",
      "wood collision a4",
      "wood collision a5",
      "wood collision a6"
    },
    wood_damage = {
      "wood damage a1",
      "wood damage a2",
      "wood damage a3"
    },
    wood_destroyed = {
      "wood destroyed a1",
      "wood destroyed a2",
      "wood destroyed a3"
    },
    bird_misc = {
      "bird_misc_a1",
      "bird_misc_a2",
      "bird_misc_a3",
      "bird_misc_a4",
      "bird_misc_a5",
      "bird_misc_a6",
      "bird_misc_a7",
      "bird_misc_a8",
      "bird_misc_a9",
      "bird_misc_a10",
      "bird_misc_a11",
      "bird_misc_a12"
    },
    piglette = {
      "piglette_a1",
      "piglette_a2",
      "piglette_a3",
      "piglette_a4",
      "piglette_a5",
      "piglette_a8",
      "piglette_a9",
      "piglette_a10",
      "piglette_a11",
      "piglette_a12"
    },
    red_special = {
      "red_special_1",
      "red_special_2",
      "red_special_3"
    },
    big_brother_special = {
      "big_brother_special_1"
    },
    pig_accordion = {
      "pig_singing_1",
      "pig_singing_2",
      "pig_singing_3",
      "pig_singing_4",
      "pig_singing_5",
      "pig_singing_6",
      "pig_singing_7",
      "pig_singing_8"
    },
    stalaktite_break = {
      "stalaktite_break_1",
      "stalaktite_break_2",
      "stalaktite_break_3"
    },
    jewel_break = {
      "jewel_break_1",
      "jewel_break_2",
      "jewel_break_3"
    },
    globe_hit = {
      "Globe_Bird_Hit_1",
      "Globe_Bird_Hit_2",
      "Globe_Bird_Hit_3",
      "Globe_Bird_Hit_4"
    },
    globe_special = {
      "Globe_Bird_Special_Activation_1",
      "Globe_Bird_Special_Activation_2",
      "Globe_Bird_Special_Activation_3"
    },
    birthday_cake = {
      "birthday_cake1",
      "birthday_cake2"
    }
  }
  currentMainMenuSong = "title_theme"
  if not settingsWrapper:isAudioEnabled() then
    _G.res.stopAudioOutput()
    setEffectsVolume(0)
    setMusicVolume(0)
  else
    _G.res.startAudioOutput()
    setEffectsVolume(1)
    setMusicVolume(1)
  end
  if showEditor == false then
    for k, v in _G.pairs(blockTable.themes) do
      if k == settingsWrapper:getCurrentMainMenuTheme() then
        loadThemeGraphics(k)
        break
      end
    end
  else
    loadAllThemeGraphics()
  end
  assetsCreated = true
end
function saveLuaFileWrapper(fileName, tableName, appData)
  if isLiteVersion == true and deviceModel == "s60" then
    if tableName == "settings" then
      fileName = "settings_trial.lua"
    end
    if tableName == "highscores" then
      fileName = "highscores_trial.lua"
    end
  end
  saveLuaFile(fileName, tableName, appData)
  if tableName == "settings" and ABIDEnabled then
    if localSettings ~= nil then
      saveLuaFile("localSettings.lua", "localSettings", true)
    end
    if purchases ~= nil then
      saveLuaFile("purchases.lua", "purchases", true)
    end
  end
end
function getAudioName(name)
  if audioGroups[name] ~= nil then
    local index = _G.math.random(1, #audioGroups[name])
    return audioGroups[name][index]
  end
  return name
end
showFps = false
if not releaseBuild or cheatsEnabled then
  showFps = true
end
showBG = true
showSleepingObjects = false
fpsTimer = 0
fpsFrames = 0
fps = 0
zoomLevel = 0
function updateIapInitTimer(dt)
  if iapInitTimer ~= nil then
    iapInitTimer = iapInitTimer - dt
    if iapInitTimer <= 0 then
      iapInitTimer = nil
      iapBuyItem(mightyEagleItemId, "inAppPurchaseBuyCallback")
    end
  end
end
function debugGCpopup()
  gameCenter = {}
  gameCenter.achievements = {}
  gameCenter.achievements.Cakemonger = g_achievements.Cakemonger
  gameCenterEnabled = true
  gameCenter.achievements.showPopUpID = "Cakemonger"
  showAchievementPopUp()
  achievementPopupDebug = true
  print("showing popup")
end
function update(dt, realDt)
  local localDelta = dt or 0
  g_dt = dt
  g_time = g_time and g_time + dt or 0
  if g_delayedURLOpen and g_time >= g_delayedURLOpen.time then
    local data = g_delayedURLOpen
    g_delayedURLOpen = nil
    openURL(data.url)
  end
  if g_gameWasResumed and g_restoreFullScreenOnReactivate == 2 then
    setFullScreenMode(true)
    g_restoreFullScreenOnReactivate = nil
    g_gameWasResumed = nil
  end
  if not releaseBuild or cheatsEnabled then
    if customerString == "nook" and keyReleased.F2 then
      g_testFreeEagle = not g_testFreeEagle
      notifyNookInsideStore(g_testFreeEagle)
    end
    if customerString == "nook" and doubleClick and cursor.x < 32 and 32 > cursor.y then
      g_testFreeEagle = not g_testFreeEagle
      notifyNookInsideStore(g_testFreeEagle)
    end
  end
  if ABIDEnabled and ABIDSubSystem ~= nil then
    ABIDSubSystem:update(dt, realDt)
  end
  if keyReleased.F7 and cheatsEnabled then
    debugGCpopup()
  end
  if cheatsEnabled then
    if keyHold.SHIFT and keyPressed.F12 then
      g_cursorEnabled = not g_cursorEnabled
    end
    if keyHold.SHIFT and keyPressed.X then
      randomPowerupReward(5)
    end
    if keyHold.SHIFT and keyPressed.Z then
      bundleReward(5)
    end
    if keyHold.SHIFT and keyPressed.C then
      iapEnabled = not iapEnabled
    end
    if keyHold.M and keyPressed.E or keyPressed.M and keyHold.E then
      settingsWrapper:setMightyEagleEnabled()
    end
  end
  if keyReleased.S then
    changeAudio("KEYBOARD_COMMAND")
  end
  updateAudioRamp(dt)
  if loadFrameCount ~= nil and 0 < loadFrameCount then
    loadFrameCount = loadFrameCount - 1
    if loadFrameCount == 0 then
      loadLevelInternal(levelFolder .. levelName)
    end
  end
  if settingsWrapper ~= nil and settingsWrapper:getNFCUnlockTimer() and eventManager ~= nil and getMightyEagleNFCUnlockCooldown() == 0 and settingsWrapper:getEagleUsedIn() ~= nil and 0 < #settingsWrapper:getEagleUsedIn() then
    settingsWrapper:setEagleUsedTime(nil)
    settingsWrapper:resetEaglesUsedIn()
    saveLuaFileWrapper("settings.lua", "settings", true)
    eventManager:notify({
      id = events.EID_MIGHTY_EAGLE_NFC_COOLDOWN_OVER
    })
  end
  if settingsWrapper ~= nil and settingsWrapper:getEagleUsedTime() ~= nil and eventManager ~= nil and timeDiff(currentTime(), settingsWrapper:getEagleUsedTime()) >= eagleLockedTime then
    print("Mighty eagle available again!\n")
    eventManager:notify({
      id = events.EID_MIGHTY_EAGLE_AVAILABLE
    })
    eagleInfoTimer = nil
    settingsWrapper:setEagleUsedTime(nil)
    settingsWrapper:resetEaglesUsedIn()
  end
  for i = 1, #subSystemsList do
    subSystemsList[i]:update(dt)
  end
  if menuManager ~= nil then
    menuManager:update(dt, time)
  end
  if adSystem ~= nil then
    adSystem:update(dt, time)
  end
  if g_resetCameras then
    if _G.tonumber(g_resetCameras) and 0 < g_resetCameras then
      g_resetCameras = g_resetCameras - 1
    else
      resetCamerasiPhone4()
      g_resetCameras = false
    end
  end
  if eventManager ~= nil then
    eventManager:tick()
  end
  processManager:update(dt)
  if releaseBuild == false then
    if keyHold.CONTROL then
      if keyPressed["1"] then
        changeLocale("en_EN")
        if menuManager and menuManager:getRoot() then
          menuManager:getRoot():layout()
        end
      elseif keyPressed["2"] then
        changeLocale("fr_FR")
        if menuManager and menuManager:getRoot() then
          menuManager:getRoot():layout()
        end
      elseif keyPressed["3"] then
        changeLocale("it_IT")
        if menuManager and menuManager:getRoot() then
          menuManager:getRoot():layout()
        end
      elseif keyPressed["4"] then
        changeLocale("de_DE")
        if menuManager and menuManager:getRoot() then
          menuManager:getRoot():layout()
        end
      elseif keyPressed["5"] then
        changeLocale("es_ES")
        if menuManager and menuManager:getRoot() then
          menuManager:getRoot():layout()
        end
      elseif keyPressed["6"] then
        changeLocale("zh_CN")
        if menuManager and menuManager:getRoot() then
          menuManager:getRoot():layout()
        end
      elseif keyPressed["7"] then
        changeLocale("zh_TW")
        if menuManager and menuManager:getRoot() then
          menuManager:getRoot():layout()
        end
      elseif keyPressed["8"] then
        changeLocale("ja_JA")
        if menuManager and menuManager:getRoot() then
          menuManager:getRoot():layout()
        end
      elseif keyPressed["9"] then
        changeLocale("pt_PT")
        if menuManager and menuManager:getRoot() then
          menuManager:getRoot():layout()
        end
      elseif keyPressed["0"] then
        changeLocale("pl_PL")
        if menuManager and menuManager:getRoot() then
          menuManager:getRoot():layout()
        end
      end
    end
    if keyHold.G and keyPressed.C or keyPressed.G and keyHold.C then
      debugShowGameCenter = not debugShowGameCenter
      print("debugShowGameCenter set to " .. _G.tostring(debugShowGameCenter) .. "\n")
      if debugShowGameCenter then
        enableGameCenter()
      else
        disableGameCenter()
      end
    end
  end
  if prepareMenusAfterAd == true then
    prepareMenusAfterAd = false
    if birdTutorialPopups ~= nil and 0 < #birdTutorialPopups then
      prepareMenuPage(tutorials)
    end
    if currentMenuPage ~= nil then
      prepareMenuPage(currentMenuPage)
    end
    if popupPage ~= nil then
      prepareMenuPage(popupPage)
    end
  end
  if newMenuPageNeedsPrepare == true or currentMenuPage ~= newMenuPage then
    setActiveMenuPageDelayed(newMenuPage, newMenuPageNeedsPrepare, newMenuPageResumed)
    newMenuPageNeedsPrepare = nil
  end
  if additionalPopupPageDelay ~= true and newPopupPage ~= nil and popupPage ~= newPopupPage then
    popupPage = newPopupPage
    if popupPage == upsellPage then
      releaseCutScenes()
    end
    if newPopupPageNeedsPrepare ~= false then
      prepareMenuPage(popupPage)
      if popupPage == goldenEggAchievedPage then
        print("goldenEggAchievedPage prepared\n")
      end
    end
    print("popup delayed: " .. popupPage.name)
    newPopupPageNeedsPrepare = nil
    newPopupPage = nil
  end
  if additionalPopupPageDelay == true then
    additionalPopupPageDelay = nil
  end
  currentGameMode = currentGameMode or updateSplashes
  time = time and time + dt or 0
  playtimeCounter = playtimeCounter and playtimeCounter + dt or 0
  if lastVideoAdTime == nil then
    lastVideoAdTime = time
  end
  updateIapInitTimer(dt)
  iapUpdate(dt)
  if settingsWrapper:getEagleUsedTime() ~= nil then
    local timeLeft = eagleLockedTime - timeDiff(currentTime(), settingsWrapper:getEagleUsedTime())
    if timeLeft > 0 and timeLeft <= 5 and (eagleInfoTimer == nil or timeLeft > eagleInfoTimer) then
      eagleInfoTimer = timeLeft
    end
    if eagleInfoTimer ~= nil and currentGameMode == updateGame then
      eagleInfoTimer = eagleInfoTimer - dt
      if 0 > eagleInfoTimer then
        eagleInfoTimer = nil
      end
    end
  end
  doubleClick = false
  if doubleClickTimer == nil then
    doubleClickTimer = 0
  end
  if keyPressed.LBUTTON then
    if doubleClickState ~= 2 then
      doubleClickState = 1
      doubleClickTimer = 0.5
    else
      doubleClickState = 3
    end
  elseif 0 < doubleClickTimer and keyReleased.LBUTTON then
    if doubleClickState == 1 then
      doubleClickState = 2
    elseif doubleClickState == 3 then
      doubleClick = true
    end
  end
  doubleClickTimer = doubleClickTimer - dt
  if 0 >= doubleClickTimer then
    doubleClickTimer = 0
    doubleClickState = 0
  end
  currentGameMode(dt, time)
  if menuManager ~= nil then
    menuManager:draw()
  end
  if keyPressed.F and cheatsEnabled then
    showFps = not showFps
  end
  if keyPressed["9"] then
    showBG = not showBG
  end
  if keyPressed["8"] and showEditor then
    showSleepingObjects = not showSleepingObjects
  end
  if iOS and achievementProcessor ~= nil then
    if 0 < #achievementProcessor.achievementUnlockQueue then
      if lastAchievementUnlockTime == nil then
        lastAchievementUnlockTime = -3
      end
      if 3 < time - lastAchievementUnlockTime then
        if gameCenterEnabled then
          if gameCenter and gameCenter.achievements and gameCenter.achievements.loading ~= true then
            achievementProcessor:unlockNextAchievement()
            lastAchievementUnlockTime = time
          end
        else
          achievementProcessor:unlockNextAchievement()
          lastAchievementUnlockTime = time
        end
      end
    end
    if 0 < #achievementProcessor.achievementRenderQueue then
      if lastAchievementRenderTime == nil then
        lastAchievementRenderTime = -3
      end
      if 3 < time - lastAchievementRenderTime then
        achievementProcessor:renderNextAchievementPopup()
        lastAchievementRenderTime = time
      end
    end
    if checkForCrystalEnabled == true and userEnabledCrystal() == true then
      checkForCrystalEnabled = false
      showCrystalInMainMenu = true
      activateCrystalUIAtProfile()
    end
  end
  if oldScreenWidth ~= screenWidth or oldScreenHeight ~= screenHeight then
    oldScreenWidth = screenWidth
    oldScreenHeight = screenHeight
    if notificationsFrame then
      notificationsFrame:layout()
    end
    if menuManager and menuManager:getRoot() then
      menuManager:getRoot():layout()
    end
    if currentGameMode ~= updateGame or deviceModel ~= "iphone4" then
    end
    if g_isPC and menuManager then
      if (screenWidth < 1024 or screenHeight < 600) and not g_resolutionWarningShown then
        g_resolutionWarningShown = true
        local root = notificationsFrame
        if root then
          local warning_page = ResolutionWarning:new(1024, 600)
          root:addChild(warning_page)
          warning_page:onEntry()
          warning_page:layout()
        end
      end
      if screenWidth >= 1024 and screenHeight >= 600 and g_resolutionWarningShown then
        g_resolutionWarningShown = nil
      end
    end
  end
  if g_isPC then
    if not isInFullScreenMode() then
      settingsWrapper:setResolution(screenWidth, screenHeight)
    end
    if isInFullScreenMode() ~= settingsWrapper:getFullscreen() then
      settingsWrapper:setFullscreen(isInFullScreenMode())
    end
  end
  local animateTime = 0.4
  setRenderState(0, 0, 1, 1, 0, 0)
  if showFps and assetsCreated == true then
    if 1 <= fpsTimer then
      fps = fpsFrames / fpsTimer
      fpsTimer = 0
      fpsFrames = 0
    end
    fpsString = _G.string.format("%.1f", fps)
    setFont(fontBasic)
    _G.res.drawString("", fpsString, screenWidth * 0.5, screenHeight, "BOTTOM", "HCENTER")
    fpsTimer = fpsTimer + realDt
    fpsFrames = fpsFrames + 1
  end
  if g_cursorEnabled then
    local show_cursor = true
    if deviceModel == "osx" and currentGameMode == updateGame and isInFullScreenMode() then
      show_cursor = OSX.using_mouse
	elseif deviceModel == "windows" then
	  show_cursor = true
    else
      show_cursor = g_isAccelerometerControl and currentGameMode ~= updateGame and g_rokuCursorVisible or false
    end
    if show_cursor and 0 <= cursor.x and 0 <= cursor.y and cursor.x <= screenWidth and cursor.y <= screenHeight then
      if keyHold.LBUTTON then
        g_currentCursorName = "CURSOR_HAND_CLICK"
      else
        g_currentCursorName = "CURSOR_HAND_POINT"
      end
      setRenderState(0, 0, 1, 1)
      _G.res.drawSprite(g_currentCursorName, cursor.x, cursor.y)
    end
  end
end
counter = 1
function updateAudioRamp(dt)
  if audioRampVolume then
    audioRampVolume = audioRampVolume + dt / audioRampLength
    if audioRampVolume <= 0 then
      audioRampVolume = nil
      setMusicVolume(0)
      setEffectsVolume(0)
    elseif audioRampVolume > 1 then
      audioRampVolume = nil
      setMusicVolume(1)
      setEffectsVolume(1)
    else
      setMusicVolume(audioRampVolume * audioRampVolume)
      setEffectsVolume(audioRampVolume * audioRampVolume)
    end
  end
end
function removeAds()
  hideAd()
  stopAds()
  settingsWrapper:setPremium(true)
  saveLuaFileWrapper("settings.lua", "settings", true)
  eventManager:notify({
    id = events.EID_ADS_REMOVED
  })
end
function gameResumed()
  if g_restoreFullScreenOnReactivate == 2 then
    g_gameWasResumed = true
  end
  getCurrentLocale()
  setupFonts()
  loadLocaleFonts()
  if notificationsFrame ~= nil then
    notificationsFrame:layout()
  end
  if shouldShowAd() then
    hideAd()
  end
  if currentBirdIndex and rubberBandPos and levelStartPosition then
    rubberBandPos.x, rubberBandPos.y = levelStartPosition.x, levelStartPosition.y
    rubberBandLength = 0
    dragStarted = false
  end
  if gameCenterEnabled and gameCenter and gameCenter.leaderboards and leaderboards and g_menuInitialised then
    refreshLocalGameCenterData()
    postTotalHighScores()
  end
  if menuManager ~= nil then
    menuManager:gameResumed()
  end
  if eventManager ~= nil and not startedFromEditor then
    local mode = ""
    if currentGameMode == updateGame then
      mode = "INGAME"
    end
    eventManager:notify({
      id = events.EID_GAME_RESUMED,
      mode = mode
    })
  end
end
function gamePaused()
  calculatePlaytime()
  saveLuaFileWrapper("settings.lua", "settings", true)
  if eventManager ~= nil and not startedFromEditor then
    local mode = ""
    if currentGameMode == updateGame then
      mode = "INGAME"
    end
    eventManager:queueEvent({
      id = events.EID_GAME_PAUSED,
      mode = mode
    })
  end
  if birdTutorialPopups ~= nil and #birdTutorialPopups == 0 and updateGame ~= nil and currentGameMode ~= nil and currentGameMode == updateGame and not startedFromEditor then
    setPhysicsEnabled(false)
    setGameMode(function()
    end)
  end
end
function setFont(fontName)
  _G.res.useFont(fontName)
end
function setGameMode(gameMode)
  currentGameMode = gameMode
  if currentGameMode == updateGame then
    setGameOn(true)
    avoidCrystalBackgroundActivity(true)
  else
    setGameOn(false)
    avoidCrystalBackgroundActivity(false)
  end
  if g_isAccelerometerControl then
    enableMotion(currentGameMode ~= updateGame)
    captureMouse(currentGameMode == updateGame)
    g_rokuCursorVisible = currentGameMode ~= updateGame and not g_tutorialActive
  end
end
function crystalUiDeactivated()
  if playerInitializedCrystalUiDeactivation ~= false then
    showCrystalInMainMenu = false
  end
  playerInitializedCrystalUiDeactivation = true
end
function goldenEggAchieved(level)
  if not settingsWrapper:isGoldenEggUnlocked(level) and not g_special_game_mode then
    settingsWrapper:unlockGoldenEgg(level)
    highscores[level] = {
      completed = false,
      birds = 0,
      score = 0,
      lowScore = 0
    }
    saveLuaFileWrapper("highscores.lua", "highscores", true)
    saveLuaFileWrapper("settings.lua", "settings", true)
    showRewardPopup("GOLDEN_EGG")
    eventManager:notify({
      id = events.EID_GOLDEN_EGG_GAINED,
      data = {
        openedLevelsAmount = calculateOpenGoldenEggLevels()
      }
    })
  end
end
function showAchievementPopUp()
  local show_gamecenter_popups = true
  if show_gamecenter_popups and gameCenterEnabled and gameCenter and gameCenter.achievements and gameCenter.achievements.showPopUpID then
    achievementProcessor:addToAchievementRenderQueue(gameCenter.achievements.showPopUpID)
  end
end
function goldenEggStarAchieved(level)
  local first_time
  if highscores[level] and highscores[level].completed then
    first_time = false
  else
    first_time = true
  end
  eventManager:notify({
    id = events.EID_STAR_POPUP,
    first_time = first_time
  })
  if highscores[level] ~= nil then
    highscores[level].completed = true
  else
    highscores[level] = {
      completed = true,
      birds = 0,
      score = 0,
      lowScore = 0
    }
  end
  saveLuaFileWrapper("highscores.lua", "highscores", true)
  saveLuaFileWrapper("settings.lua", "settings", true)
  eventManager:notify({
    id = events.EID_GOLDEN_EGG_STAR_GAINED,
    data = {
      starsGained = calculateStarsFromGoldenEggLevels(),
      levelName = level
    }
  })
end
function aboutGoldenEggAchieved()
  goldenEggAchieved("LevelGE_14")
end
function episode3LevelSelectionEggAchieved()
  goldenEggAchieved("LevelGE_7")
end
function mightyEagleNotificationCallback(event_type)
  if eventManager ~= nil then
  end
end
function updateSplashes(dt, time)
  if splashTimer == nil then
    splashTimer = 0
    current = 1
    splashes = {
      {
        sprite = "SPLASH_CLICKGAMER",
        time = 2,
        bgColor = {
          red = 255,
          green = 255,
          blue = 255
        }
      },
      {
        sprite = "SPLASH_ROVIO",
        time = 3,
        bgColor = {
          red = 255,
          green = 255,
          blue = 255
        }
      },
      {
        sprite = "SPLASH_ANGRY_BIRDS",
        time = 1,
        bgColor = {
          red = 0,
          green = 0,
          blue = 0
        }
      }
    }
    if g_skipToAngryBirdsSplash then
      current = 3
    elseif deviceModel ~= "iphone" and deviceModel ~= "ipad" and deviceModel ~= "iphone4" and deviceModel ~= "ipad3" then
      current = 2
    end
    loadingSplash = 3
  end
  splashTimer = splashTimer + dt
  if keyPressed.LBUTTON and splashes[current].sprite ~= "KOREA_IMAGE_1" then
    splashTimer = splashes[current].time + 1
  end
  local sw, sh = _G.res.getSpriteBounds("", splashes[current].sprite)
  local scale = false
  local xs, ys = 1, 1
  local xCoord, yCoord = screenWidth / 2, screenHeight / 2
  if splashes[current].sprite == "SPLASH_ROVIO" and sh > screenHeight * 0.7 then
    scale = true
    ys = screenHeight * 0.7 / sh
    xs = screenHeight * 0.7 / sh
    local newWidth = sw * xs
    if newWidth > screenWidth then
      ys = screenWidth / sw
      xs = screenWidth / sw
    end
  elseif splashes[current].sprite ~= "SPLASH_ROVIO" and splashes[current].sprite ~= "KOREA_IMAGE_1" and screenHeight ~= sh and splashes[current].sprite ~= "SPLASH_CLICKGAMER" and deviceModel ~= "ipad" then
    scale = true
    ys = screenHeight / sh
    xs = screenHeight / sh
    local newWidth = sw * xs
    if newWidth > screenWidth then
      ys = screenWidth / sw
      xs = screenWidth / sw
    end
  end
  if scale then
    setRenderState(0, 0, xs, ys)
    _G.res.drawSprite("", splashes[current].sprite, _G.math.floor(xCoord / xs), _G.math.floor(yCoord / ys))
    if splashes[current].sprite == "SPLASH_ANGRY_BIRDS" then
      if isBetaVersion and deviceModel == "android" or isLiteVersion then
        _G.res.drawSprite("", "LITE_SPLASH", _G.math.floor(xCoord / xs), _G.math.floor(yCoord / ys))
      end
      if isBetaVersion and deviceModel == "android" then
        _G.res.drawSprite("", "SPLASH_LOADING", screenWidth, screenHeight)
      else
        _G.res.drawSprite("", _G.res.getString("TEXTS_BASIC", "TEXT_SPLASH_LOADING_SPRITE"), screenWidth / xs, screenHeight / ys)
      end
    end
    setRenderState(0, 0, 1, 1)
  else
    _G.res.drawSprite("", splashes[current].sprite, screenWidth / 2, screenHeight / 2)
    if splashes[current].sprite == "SPLASH_ANGRY_BIRDS" then
      _G.res.drawSprite("", _G.res.getString("TEXTS_BASIC", "TEXT_SPLASH_LOADING_SPRITE"), screenWidth, screenHeight)
      if isBetaVersion and deviceModel == "android" or isLiteVersion then
        _G.res.drawSprite("", "LITE_SPLASH", screenWidth / 2, screenHeight / 2)
        _G.res.drawSprite("", "SPLASH_LOADING", screenWidth, screenHeight)
      end
    elseif splashes[current].sprite == "KOREA_IMAGE_1" then
      _G.res.drawSprite("", "KOREA_IMAGE_2", screenWidth - 30, screenHeight - 35)
    end
  end
  if splashes[current].sprite == "SPLASH_ROVIO" then
    setRenderState(0, 0, 1, 1, 0, 0, 0)
    local copyrightSprite = "COPYRIGHT_TEXT"
    if deviceModel == "android" and screenWidth < 480 then
      copyrightSprite = "COPYRIGHT_TEXT_QVGA"
    end
    local sw, sh = _G.res.getSpriteBounds(copyrightSprite)
    _G.res.drawSprite(copyrightSprite, screenWidth * 0.5, screenHeight)
  end
  if current >= loadingSplash and dt < splashTimer and assetsCreated ~= true then
    if (isLiteVersion or deviceModel == "android") and not settingsWrapper:isPremium() then
      requestAndShowVideo()
    end
    createAssets()
  end
  if splashTimer > splashes[current].time then
    splashTimer = 0
    current = current + 1
    if splashes[current] ~= nil then
      setBGColor(splashes[current].bgColor.red, splashes[current].bgColor.green, splashes[current].bgColor.blue)
    end
    if current > #splashes then
      initialize()
      setTheme(settingsWrapper:getCurrentMainMenuTheme())
      if not settingsWrapper:isGfxLowQuality() then
        drawBackgroundNative()
        if scale then
          setRenderState(0, 0, xs, ys, 0, 0)
          _G.res.drawSprite("", "SPLASH_ANGRY_BIRDS", _G.math.floor(screenWidth / 2 / xs), _G.math.floor(screenHeight / 2 / ys))
        else
          setRenderState(0, 0, 1, 1, 0, 0)
          _G.res.drawSprite("", "SPLASH_ANGRY_BIRDS", screenWidth / 2, screenHeight / 2)
        end
      end
      setGameMode(function()
      end)
    end
  end
end
function updateValues()
  defaultForce = -925
  boostForce = defaultForce
  collisionParticleForceThreshold = 10
  collisionSoundForceThreshold = 3
  blockDestroyedScoreIncrement = 500
  pigletteDestroyedScoreIncrement = 5000
  birdsLeftScoreIncrement = 10000
  hardLimitSimultaneousParticles = 150
  softLimitSimultaneousParticles = 75
end
function initialize()
  _G.math.randomseed(_G.os.time())
  numberKeys = {
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0"
  }
  screen = {
    x = screenWidth * 0.5,
    y = screenHeight * 0.5,
    top = 0,
    left = 0,
    bottom = screenHeight,
    right = screenWidth
  }
  if showCameraDebugData then
    visualizeScreen = {x = 0, y = 0}
  end
  oldScreenWidth = screenWidth
  oldScreenHeight = screenHeight
  cameraShakeX, cameraShakeY = 0, 0
  floatingScoreScaling = 1
  if deviceModel == "iphone4" or deviceModel == "ipad3" then
    floatingScoreScaling = 2
  end
  loading = false
  menuSunsetAngle = 0
  goldenEggsStarEffectAngle = 0
  rubberBandPos = {x = 0, y = 0}
  rubberBandSpeed = 0
  floatingScores = {}
  objectCounts = {}
  scoreTable = {}
  draggingSpeed = 0
  draggingStartPosPhysics = {x = -1, y = -1}
  draggingStartPosWorld = {x = -1, y = -1}
  draggingStartPosScreen = {x = -1, y = -1}
  selectedObjects = {}
  selectedObjectPos = {x = 0, y = 0}
  selectedBird = nil
  objectToAdd = nil
  objectToAddAngle = 0
  currentGroupIndex = 1
  currentGroup = nil
  currentThemeIndex = 1
  currentTheme = nil
  cameraTargetObject = nil
  doubleClickTimer = 0
  quadClickTimer = 0
  quadClickCounter = 0
  gameTimer = 0
  levelCompleteTimer = 0
  birdBuffTimer = 0
  currentBirdIndex = 1
  currentBirdName = nil
  flyingBird = nil
  birdSpecialtyAvailable = false
  particleAmount = 0
  blockMoveTimer = 0
  if deviceModel ~= "freebox" then
    cursor.x, cursor.y = 0, 0
  end
  cursorPhysics = {x = 0, y = 0}
  cursorWorld = {x = 0, y = 0}
  oldCursorWorld = {x = 0, y = 0}
  oldCursor = {x = 0, y = 0}
  tapPosWorld = {x = 0, y = 0}
  springConstant = 1500
  springDampening = 50
  difficultyLevel = 1
  score = 0
  zoomLevel = 0
  defaultForce = -800
  blockDestroyedScoreIncrement = 100
  physicsToWorld = 20
  physicsScale = 1 / physicsToWorld
  shootRange = 2.2
  shootMaxLength = shootRange + 3.2
  continueButtonY = screenHeight * 0.5 + 70
  oldScale = 1
  levelStartPosition = {x = 0, y = 0}
  animationScreen = {x = 0, y = 0}
  slingShotBasePosition = {x = 0, y = 0}
  animationWorldScale = 1
  setPhysicsSimulationScale(physicsToWorld)
  levelName = ""
  cameraFunction = defaultCamera
  castleCameraTimer = 0
  levelStartTimer = 0
  currentLevelNumber = -1
  currentThemeNumber = -1
  currentWorldNumber = -1
  inExtraWorld = false
  currentLevelNumberInTheme = -1
  currentPageNumber = -1
  collisionParticleForceThreshold = 5
  physicsEnabled = false
  levelSaved = true
  selectionRectActive = false
  birdFired = false
  loadingPageDrawn = false
  particles = {}
  elementAnimations = {}
  initializeMenu()
  updateValues()
  setPhysicsEnabled(false)
  cos = _G.math.cos
  sin = _G.math.sin
  if isIapEnabled() then
    setNotificationCallback("mightyEagleNotificationCallback")
  end
  eventManager:notify({
    id = events.EID_GAME_INITIALIZED,
    screenWidth = screenWidth,
    screenHeight = screenHeight,
    customerString = customerString,
    deviceModel = deviceModel
  })
end
function inAppPurchaseInitCallback(pid, status, errorCode)
  if status ~= nil and errorCode ~= nil then
    print("gameLogic.lua::itemPurchaseCallback(): status: " .. status .. ", errorCode: " .. errorCode .. "\n")
    if status == 1 then
      local count = iapGetItemCount()
      print("  gameLogic.lua::itemPurchaseCallback(): itemCount: " .. count .. "\n")
      if count > 0 then
        local eagleItemFound = false
        for i = 0, count - 1 do
          local item = iapGetItemAt(i)
          print("  gameLogic.lua::itemPurchaseCallback(): item(i): ")
          print("    name: " .. item.name .. ", id: " .. item.id .. ", type: " .. item.type .. ", quantity: " .. item.quantity .. ", desc: " .. item.description .. "\n")
          if item.id == mightyEagleItemId then
            eagleItemFound = true
            mightyEagleItem = {
              name = item.name,
              id = item.id,
              type = item.type,
              quantity = item.quantity,
              description = item.description
            }
          end
        end
        if eagleItemFound ~= true then
          print("  gameLogic.lua::itemPurchaseCallback(): mighty eagle item not found\n")
        end
      else
        print("  gameLogic.lua::itemPurchaseCallback(): no items found\n")
      end
    else
      print("  gameLogic.lua::itemPurchaseCallback(): init failed\n")
    end
  end
  iapInitTimer = 0
end
function purchaseAdRemoval()
  logFlurryEvent("Ads removal purchase started")
  iapBuyItem(adRemovalItemId, "adRemovalPurchaseCallback")
end
function purchaseMightyEagle()
  print("gameLogic.lua:: purchaseMightyEagle(): enter\n")
  iapInitTimer = iapInitTimeOut
  iapInitItemPurchase("inAppPurchaseInitCallback")
end
function inAppPurchaseBuyCallback(pid, status, errorCode)
  local failed = true
  if status ~= nil and errorCode ~= nil then
    loginfo("gameLogic.lua::inAppPurchaseBuyCallback(): (status: " .. status .. ", errorCode: " .. errorCode .. ")\n")
    if status == 2 then
      loginfo("gameLogic.lua::inAppPurchaseBuyCallback  (fail) \n")
      if errorCode == 2 then
        loginfo("gameLogic.lua::inAppPurchaseBuyCallback user cancelled \n")
        eventManager:notify({
          id = events.EID_IAP_CANCELLED_BY_USER,
          status = status,
          error = errorCode,
          product = pid
        })
      else
        eventManager:notify({
          id = events.EID_IAP_FAILED_OTHER,
          status = status,
          error = errorCode,
          product = pid
        })
        loginfo("gameLogic.lua::inAppPurchaseBuyCallback  (fail : other)\n")
      end
    end
    if (status == 1 or status == 3 or status == 4) and pid == mightyEagleItemId then
      failed = false
      enableMightyEagle()
      settingsWrapper:resetEaglesUsedIn()
      settingsWrapper:setNFCUnlockTimer(nil)
      settingsWrapper:setEagleUsedTime(nil)
      settingsWrapper:setMightyEagleUpsellPageViewed()
      saveLuaFileWrapper("settings.lua", "settings", true)
      if g_eagleClickedFrom == "INGAME" or g_eagleClickedFrom == "LEVEL_FAILED" then
        launchEagleBaitInGame()
      end
      if status == 1 then
        loginfo("gameLogic.lua::inAppPurchaseBuyCallback  (success) \n")
        local from
        if g_eagleClickedFrom == "MAIN_MENU" then
          from = "MAIN_MENU"
        else
          from = getWorldLevelNumberCombination()
        end
        if levelName ~= nil and (highscores[levelName] == nil or highscores[levelName] ~= nil and highscores[levelName].completed ~= true) then
          usedAsLevelSkip = "yes"
        end
        eventManager:notify({
          id = events.EID_MIGHTYEAGLE_PURCHASED,
          status = status,
          errorCode = errorCode,
          from = from,
          usedAsLevelSkip = usedAsLevelSkip
        })
      elseif status == 3 then
        loginfo("gameLogic.lua::inAppPurchaseBuyCallback (mighty eagle restored)")
        eventManager:notify({
          id = events.EID_MIGHTYEAGLE_RESTORED,
          status = status,
          errorCode = errorCode
        })
      end
      loginfo("gameLogic.lua::inAppPurchaseBuyCallback: (Mighty Eagle Enabled) \n")
    end
  end
  if g_eagleClickedFrom == "MAIN_MENU" then
    eventManager:notify({
      id = events.EID_CHANGE_SCENE,
      target = "MAIN_MENU"
    })
  elseif g_eagleClickedFrom == "INGAME" then
    if failed then
      goToMightyEagleDemoPageFromGame()
    else
      menuManager:changeRoot(g_hud_class:new())
    end
  elseif g_eagleClickedFrom == "LEVEL_FAILED" then
    if not failed then
      menuManager:changeRoot(g_hud_class:new())
      if deviceModel == "iphone4" or deviceModel == "ipad3" then
        changeResolution = true
        wantedResolution = "FULL"
        g_resetCameras = true
      end
    else
      local frame = menuManager:popFrame()
      eventManager:notify({
        id = events.EID_PUSH_FRAME,
        target = frame.return_screen
      })
    end
  end
end
function adRemovalPurchaseCallback(pid, status, errorCode)
  local STATUS_SUCCESS = 1
  local STATUS_FAIL = 2
  local STATUS_RESTORE = 3
  local STATUS_PENDING = 4
  local ERRCODE_USER_CANCELLED = 2
  print("gameLogic.lua::inAppPurchaseBuyCallback(): status: " .. _G.tostring(status) .. ", errorCode: " .. _G.tostring(errorCode) .. "\n")
  if status ~= nil and errorCode ~= nil then
    if status == STATUS_FAIL then
      print("  fail\n")
      if errorCode == ERRCODE_USER_CANCELLED then
        print("  user cancel\n")
        logFlurryEventWithParam("Ads removal purchase", "Result", "user cancelled")
      else
        print("  other\n")
        logFlurryEventWithParam("Ads removal purchase", "Result", "fail")
      end
    end
    if (status == STATUS_SUCCESS or status == STATUS_RESTORE or status == STATUS_PENDING) and pid == adRemovalItemId then
      removeAds()
      scoreAdOffsetY = 0
      if status == STATUS_PENDING then
        logFlurryEventWithParam("Ads removal purchase", "Result", "pending")
      elseif status == STATUS_SUCCESS then
        logFlurryEventWithParam("Ads removal purchase", "Result", "success")
        print(" success\n")
      elseif status == STATUS_RESTORE then
        print("  restored")
      end
    end
  end
  setPhysicsEnabled(false)
  setGameMode(function()
  end)
  eventManager:queueEvent({
    id = events.EID_GAME_PAUSED,
    mode = ""
  })
end
function checkLastOpenLevels()
  for i = 1, #g_episodeIds do
    local id = g_episodeIds[i]
    local ep = g_episodes[g_episodeIds[i]]
    if not ep.no_level_progression then
      local last = calculateLastOpenLevel(id)
      if last > settingsWrapper:getLastOpenLevel(id) then
        settingsWrapper:setLastOpenLevel(id, last)
        print("<settings> set last open level for episode " .. _G.tostring(id) .. " to " .. _G.tostring(last) .. "\n")
      end
    end
  end
end
function initializeMenu()
  if not settingsWrapper:isFlurryFirstTimeLevelCollected() then
    for i = 1, #g_episodes do
      for j = 1, #g_episodes[i].pages do
        for k = 1, #g_episodes[i].pages[j].levels do
          local level = g_episodes[i].pages[j].levels[k]
          if highscores[level.name] ~= nil and not g_episodes[i].pages[j].extra and g_episodes[i].pages[j].world_number and g_episodes[i].pages[j].world_number > 0 then
            levelCompleteFirstTimeFlurryParams = {}
            levelCompleteFirstTimeFlurryParams.Level = g_episodes[i].pages[j].world_number .. "-" .. k
            logFlurryEventWithParams("Level complete first time", "levelCompleteFirstTimeFlurryParams")
          end
        end
      end
    end
    settingsWrapper:setFlurryFirstTimeLevelCollected()
  end
  checkLastOpenLevels()
  local ct = currentTime()
  if settingsWrapper:getCumulativeStars() == nil then
    settingsWrapper:setCumulativeStars(0)
    for i = 1, #g_episodes do
      local stars, _ = calculateEpisodeStars(i)
      settingsWrapper:setCumulativeStars(settingsWrapper:getCumulativeStars() + stars)
    end
  end
  for _, v in _G.pairs(g_episodes) do
    if not v.extra then
      for _, v2 in _G.pairs(v.pages) do
        if not v2.extra and v2.world_number and v2.world_number > 0 and not settingsWrapper:isThemeCompleted(v2.world_number) and highscores[v2.levels[#v2.levels].name] ~= nil and highscores[v2.levels[#v2.levels].name].completed then
          settingsWrapper:setThemeCompleted(v2.world_number)
        end
      end
    end
  end
  for i = 1, #g_episodes do
    if not settingsWrapper:isEpisodeThreeStarred(i) then
      local epStars, epTotalStars = calculateEpisodeStars(i)
      if epTotalStars <= epStars then
        settingsWrapper:setEpisodeThreeStarred(i)
      end
    end
  end
  if #settingsWrapper:getEagleUsedIn() == 0 then
    settingsWrapper:resetEaglesUsedIn()
    settingsWrapper:setEagleUsedTime(nil)
  end
  if not settingsWrapper:isIAPRestoreChecked() and deviceModel == "android" and isIapEnabled() then
    settingsWrapper:setIAPRestoreChecked()
    print("<iap> attempting iap restore\n")
    iapRestoreItems("iapRestoreCallback")
  end
  if not isEagleEnabled() and checkEagleStatusFromHighscores() then
    enableMightyEagle()
    settingsWrapper:setMightyEagleUpsellPageViewed()
  end
  settingsWrapper:restoreGoldenEggsFromHighscores()
  if releaseBuild ~= true and g_episodes.G ~= nil then
    for i = 1, #g_episodes.G.pages do
      for j = 1, #g_episodes.G.pages[i].levels do
        local level = g_episodes.G.pages[i].levels[j]
        settingsWrapper:unlockGoldenEgg(level.name)
      end
    end
  end
  settingsWrapper:incrementGameStarts()
  getInitialPowerupRewards()
  saveLuaFileWrapper("settings.lua", "settings", true)
  if g_registrationEnabled then
    g_isRegistered = DRM.checkRegistration()
  end
  createMenuPages()
  selectedMenuItem = -1
  oldMenuPage = nil
  if not releaseBuild then
    for i = 1, #g_episodeIds do
      if not g_episodes[g_episodeIds[i]].no_level_progression then
        settingsWrapper:setLastOpenLevel(g_episodeIds[i], 200)
      end
    end
  end
  limitLevels = false
  openDemoLevels = {
    1,
    6,
    17,
    26,
    34,
    36,
    45,
    49,
    58
  }
  popupPage = nil
  birdAnimations = {}
  baitSardine = {
    y = 0,
    x = 0,
    name = "BaitSardine_1",
    startNumber = nil,
    angle = 0,
    definition = "BaitSardine"
  }
  if isBetaVersion then
    setActivePopupPage(betaDisclaimerPage)
  end
  menuManager:addLink("MAIN_MENU", MainMenu:new())
  menuManager:addLink("CREDITS", Credits:new())
  if not g_is_free_version then
    for _, v in _G.pairs(g_episodeIds) do
      menuManager:addLink("LEVEL_SELECTION_" .. v, LevelSelection:new(nil, v))
    end
    menuManager:addLink("EPISODE_SELECTION", EpisodeSelection:new(nil))
  else
    local ls = LevelSelectionFree:new()
    menuManager:addLink("EPISODE_SELECTION", ls)
    menuManager:addLink("LEVEL_SELECTION_1", ls)
  end
  menuManager:addLink("INFO_FRAME", info.InfoFrame:new())
  if g_challengesEnabled then
    menuManager:addLink("CHALLENGE_PAGE", ChallengeFrame:new())
  end
  if powerAndMeEnabled then
    menuManager:addLink("MIGHTY_EAGLE_PURCHASE_PAGE", MEPage:new())
  end
  if subsystemsapi:isAndroid() and useAds() then
    menuManager:addLink("ADS_OFF_PAGE", AdsOffPage:new())
  end
  g_menuInitialised = true
  eventManager:notify({
    id = events.EID_CHANGE_SCENE,
    target = "MAIN_MENU",
    from = "BOOT"
  })
  if not releaseBuild or cheatsEnabled then
    for k, _ in _G.pairs(nuked) do
      print("-- showing message for lost savefile " .. k .. "\n")
      eventManager:notify({
        id = events.EID_PUSH_FRAME,
        target = ui.Prompt:new({
          title = "QA Message",
          content = "The file \"" .. k .. "\" was corrupted"
        })
      })
    end
  end
  if g_updateCheckEnabled and deviceModel == "windows" then
    print("checking for updates\n")
    checkForUpdates()
  end
  if deviceModel == "windows" or deviceModel == "osx" or g_isAccelerometerControl then
    g_cursorEnabled = true
  end
  if g_isAccelerometerControl then
    enableMotion(true)
  end
end
function iapRestoreCallback(pid, status, error)
  print("<iap> restore callback; pid: " .. _G.tostring(pid) .. " status: " .. _G.tostring(status) .. " error: " .. _G.tostring(error) .. "\n")
  if status == 1 or status == 3 or status == 4 then
    if pid == mightyEagleItemId then
      print("<iap> restore mighty eagle\n")
      enableMightyEagle()
      settingsWrapper:resetEaglesUsedIn()
      settingsWrapper:setEagleUsedTime(nil)
      settingsWrapper:setMightyEagleUpsellPageViewed()
      saveLuaFileWrapper("settings.lua", "settings", true)
    elseif pid == adRemovalItemId then
      print("<iap> restored ad removal\n")
      removeAds()
    else
      print("<iap> attempted to restore unknown item id\n")
    end
    eventManager:notify({
      id = events.EID_IAP_ITEMS_RESTORED
    })
  else
    print("<iap> restore failed?\n")
  end
end
function getInitialPowerupRewards()
  if not settingsWrapper:isRewardCollected("firststart") then
    g_startup_rewards = 5
  else
    g_startup_rewards = nil
  end
end
function getWorldLevelNumberCombination()
  local level = "999-999"
  if currentWorldNumber ~= nil and currentLevelNumberInTheme ~= nil then
    level = currentWorldNumber .. "-" .. currentLevelNumberInTheme
  end
  return level
end
function startCrystal()
  if isCrystalUIShowing() then
    showCrystalInMainMenu = false
    deactivateCrystalUI()
    eventManager:notify({
      id = events.EID_CRYSTAL_DEACTIVATED
    })
  else
    showCrystalInMainMenu = true
    postTotalHighScores()
    eventManager:notify({
      id = events.EID_CRYSTAL_STARTED
    })
    activateCrystalUI()
  end
end
function changeGFXQuality()
  settingsWrapper:toggleGfxLowQuality()
end
function refreshLocalGameCenterData()
  print("gamelogic refreshLocalGameCenterData \n")
  if gameCenterEnabled and leaderboards then
    for k, v in _G.pairs(leaderboards) do
      getLeaderboardScoresForRange(v, 1, 1)
    end
  end
end
function getLeaderboardNameForWorld(worldNumber)
  local lboardName = "totalScoreWorld" .. worldNumber
  return lboardName
end
function getLeaderboardNameForEpisode(episodeNumber)
  local lboardName = false
  if _G.type(episodeNumber) == "number" and episodeNumber <= #g_episodes then
    lboardName = "totalScoreEpisode" .. episodeNumber
  end
  return lboardName
end
function getLeaderboardNameForTotalScore()
  if isLiteVersion then
    return "liteTotalScore"
  else
    return "totalScore"
  end
end
function getWorldScore(episode, page)
  local totalScore = 0
  for i = 1, #g_episodes[episode].pages[page].levels do
    local level = g_episodes[episode].pages[page].levels[i]
    if highscores[level.name] ~= nil and highscores[level.name].score ~= nil then
      totalScore = totalScore + highscores[level.name].score
    end
  end
  return totalScore
end
function getLeaderboardNamesForLevel(levelName)
  if g_menuInitialised then
    local worldNumber = 0
    for k, v in allLevels() do
      if k == levelName then
        local level, episode, page, _ = getLevelById(levelName)
        local lboardNames = {}
        local lboardNameWorld = getLeaderboardNameForWorld(g_episodes[episode].pages[page].world_number)
        local lboardNameEpisode = getLeaderboardNameForEpisode(episode)
        local lboardNameTotal = getLeaderboardNameForTotalScore()
        if lboardNameWorld then
          _G.table.insert(lboardNames, lboardNameWorld)
        end
        if lboardNameEpisode then
          _G.table.insert(lboardNames, lboardNameEpisode)
        end
        if lboardNameTotal then
          _G.table.insert(lboardNames, lboardNameTotal)
        end
        return lboardNames
      end
    end
  end
  return false
end
function setPostedStatus(levelName)
  if gameCenterEnabled and gameCenter and gameCenter.leaderboards and leaderboards then
    local lboardNames = getLeaderboardNamesForLevel(levelName)
    if lboardNames then
      for k, v in _G.pairs(lboardNames) do
        if gameCenter.leaderboards[leaderboards[v]] then
          print("Setting posted status to false for leaderboard " .. v .. ".\n")
          gameCenter.leaderboards[leaderboards[v]].posted = false
        end
      end
    end
  end
end
function setIndicatorPositions()
end
function disableGameCenter()
  if not menuManager then
    return
  end
  local main_menu = menuManager:getLink("MAIN_MENU")
  local episode_selection = menuManager:getLink("EPISODE_SELECTION")
  if main_menu then
    main_menu:setGameCenterEnabled(false)
  end
  if episode_selection then
    episode_selection:disableGameCenter()
  end
end
function enableGameCenter()
  if not menuManager then
    return
  end
  local main_menu = menuManager:getLink("MAIN_MENU")
  local episode_selection = menuManager:getLink("EPISODE_SELECTION")
  if main_menu then
    main_menu:setGameCenterEnabled(true)
  end
  if episode_selection then
    episode_selection:enableGameCenter()
  end
end
function getAllThreeStars()
  print("Get all three stars cheat\n")
  for k, v in allLevels() do
    if highscores[k] == nil then
      highscores[k] = {}
    end
    highscores[k].score = 500000
    highscores[k].completed = true
  end
  saveLuaFileWrapper("highscores.lua", "highscores", true)
end
function createMenuPages()
  loadLuaFile(scriptPath .. "/menus/level_selection_layouts.lua", "")
  loadLuaFile(scriptPath .. "/menus/level_selection.lua", "")
  loadLuaFile(scriptPath .. "/menus/level_selection_free.lua", "")
  loadLuaFile(scriptPath .. "/menus/episode_selection.lua", "")
  loadLuaFile(scriptPath .. "/menus/main_menu.lua", "")
  loadLuaFile(scriptPath .. "/menus/credits.lua", "")
  loadLuaFile(scriptPath .. "/menus/tutorials.lua", "")
  loadLuaFile(scriptPath .. "/menus/animated_tutorial.lua", "")
  loadLuaFile(scriptPath .. "/menus/egg_hint.lua", "")
  loadLuaFile(scriptPath .. "/menus/loading.lua", "")
  loadLuaFile(scriptPath .. "/menus/level_end.lua", "")
  loadLuaFile(scriptPath .. "/menus/achievements.lua", "")
  loadLuaFile(scriptPath .. "/menus/reward_popups.lua", "")
  loadLuaFile(scriptPath .. "/menus/updater.lua", "")
  loadLuaFile(scriptPath .. "/menus/shop2.lua", "")
  loadLuaFileToObject(scriptPath .. "/menus/Mattel_menus.lua", this.Mattel, "")
  loadLuaFileToObject(scriptPath .. "/menus/soundboard.lua", this, "soundboards")
  loadLuaFileToObject(scriptPath .. "/menus/radio.lua", this.soundboards, "")
  loadLuaFileToObject(scriptPath .. "/menus/keyboard.lua", this.soundboards, "")
  loadLuaFileToObject(scriptPath .. "/menus/sequencer.lua", this.soundboards, "")
  loadLuaFileToObject(scriptPath .. "/menus/accordion.lua", this.soundboards, "")
  if gameCenterSupported or not releaseBuild then
    loadLuaFile(scriptPath .. "/subsystems/game_center.lua", "")
  end
  if deviceModel == "windows" or deviceModel == "osx" then
    loadLuaFile(scriptPath .. "/menus/resolution.lua", "")
  end
  if deviceModel == "osx" then
    loadLuaFileToObject(scriptPath .. "/menus/gesture_menu.lua", this.OSX, "")
  end
  local loading = LevelLoadingPage:new({name = "loading", visible = "false"})
  notificationsFrame:addChild(loading)
  loading:layout()
  initSubsystems()
  createPopupBoxSpriteTables()
  if gameCenterEnabled and gameCenter and gameCenter.leaderboards then
    postTotalHighScores()
  end
end
function calculateEpisodeStars(episode)
  local stars = 0
  local total_stars = 0
  for i = 1, #g_episodes[episode].pages do
    local page = g_episodes[episode].pages[i]
    total_stars = total_stars + #page.levels * 3
    for j = 1, #page.levels do
      local level = page.levels[j]
      if highscores[level.name] ~= nil and highscores[level.name].completed then
        local score = highscores[level.name].score or 0
        if score >= starTable[level.name].goldScore then
          stars = stars + 3
        elseif score >= starTable[level.name].silverScore then
          stars = stars + 2
        elseif score > 0 then
          stars = stars + 1
        end
      end
    end
  end
  return stars, total_stars
end
function calculateEpisodeScore(episode)
  local score = 0
  for i = 1, #g_episodes[episode].pages do
    local page = g_episodes[episode].pages[i]
    for j = 1, #page.levels do
      local level = page.levels[j]
      if highscores[level.name] ~= nil and highscores[level.name].completed then
        score = score + highscores[level.name].score
      end
    end
  end
  return score
end
function getEagleScore(levelName)
  if levelName == nil or highscores[levelName] == nil or highscores[levelName].eagleScore == nil then
    return -1
  end
  local eagleScore = 0
  if highscores[levelName].eagleScore ~= nil then
    eagleScore = highscores[levelName].eagleScore
  end
  return eagleScore
end
function storeEagleScore(levelName, score)
  if settingsWrapper:isMightyEagleEnabled() then
    highscores[levelName].eagleScore = score
  elseif isFreeEagleEnabled() or g_usingFreeEagle then
    highscores[levelName].eagleScore = score
    highscores[levelName].freeEagleUsed = true
    g_haveEagleScores = true
  elseif settingsWrapper:getNFCMeUnlocked() then
    highscores[levelName].eagleScore = score
    highscores[levelName].freeEagleUsed = true
    g_haveEagleScores = true
    settingsWrapper:setNFCMeUnlocked(false)
  end
end
function calculateFeatherScore(episode)
  local total_feathers = 0
  local feathers = 0
  for i = 1, #g_episodes[episode].pages do
    local page = g_episodes[episode].pages[i]
    total_feathers = total_feathers + #page.levels
    for j = 1, #page.levels do
      local level = page.levels[j]
      if highscores[level.name] ~= nil and getEagleScore(level.name) >= 100 then
        feathers = feathers + 1
      end
    end
  end
  return feathers, total_feathers
end
function calculateAllFeathers()
  local feathers = 0
  local total_feathers = 0
  for i = 1, #g_episodes do
    local f, tf = calculateFeatherScore(i)
    feathers = feathers + f
    total_feathers = total_feathers + tf
  end
  return feathers, total_feathers
end
function calculateEpisodeLevelsCompleted(episode)
  local total_levels = 0
  for i = 1, #g_episodes[episode].pages do
    local page = g_episodes[episode].pages[i]
    for j = 1, #page.levels do
      local level = page.levels[j]
      if highscores[level.name] ~= nil and highscores[level.name].completed then
        total_levels = total_levels + 1
      end
    end
  end
  return total_levels
end
function calculateLastOpenLevel(episode)
  local pages = g_episodes[episode].pages
  local last_level = 1
  local level_index = 1
  for i = 1, #pages do
    if not pages[i].extra then
      for j = 1, #pages[i].levels do
        level_index = level_index + 1
        local level = pages[i].levels[j]
        if highscores[level.name] and highscores[level.name].completed then
          last_level = level_index
        end
      end
    end
  end
  return last_level
end
function checkEagleStatusFromHighscores()
  local eagleEnabled = false
  for i = 1, #g_episodes do
    for j = 1, #g_episodes[i].pages do
      for k = 1, #g_episodes[i].pages[j].levels do
        local level = g_episodes[i].pages[j].levels[k]
        if highscores[level.name] ~= nil and highscores[level.name].eagleScore ~= nil and highscores[level.name].eagleScore > 0 then
          if not highscores[level.name].freeEagleUsed then
            eagleEnabled = true
          end
          g_haveEagleScores = true
        end
      end
    end
  end
  return eagleEnabled
end
function calculateStarsFromGoldenEggLevels()
  stars = 0
  if g_episodes.G ~= nil then
    for i = 1, #g_episodes.G.pages do
      for j = 1, #g_episodes.G.pages[i].levels do
        local level = g_episodes.G.pages[i].levels[j]
        if highscores[level.name] and highscores[level.name].completed then
          stars = stars + 1
        end
      end
    end
  end
  return stars
end
function calculateOpenGoldenEggLevels()
  count = 0
  if g_episodes.G ~= nil then
    for i = 1, #g_episodes.G.pages do
      for j = 1, #g_episodes.G.pages[i].levels do
        if settingsWrapper:isGoldenEggUnlocked(g_episodes.G.pages[i].levels[j].name) then
          count = count + 1
        end
      end
    end
  end
  return count
end
function restartLevelIngame(hiddenLoading)
  settingsWrapper:incrementGameRestarted()
  if numberOfAttemptsInLevel == nil then
    numberOfAttemptsInLevel = 0
  end
  if currentEpisode == "G" then
    eventManager:notify({
      id = events.EID_GE_LEVEL_RESTARTED,
      levelName = levelName,
      levelRestartedFrom = "pause menu"
    })
  elseif currentEpisode ~= "G" then
    eventManager:notify({
      id = events.EID_LEVEL_RESTARTED,
      currentWorldNumber = currentWorldNumber,
      currentLevelNumberInTheme = currentLevelNumberInTheme,
      numberOfAttemptsInLevel = numberOfAttemptsInLevel,
      birdsShot = birdsShot,
      birdsCounter = birdsCounter,
      levelRestartedFrom = "pause menu"
    })
  end
  numberOfAttemptsInLevel = numberOfAttemptsInLevel + 1
  setEditing(false)
  setPhysicsEnabled(false)
  if not isChallengeMode() then
    eventManager:notify({
      id = events.EID_LEVEL_LOADING_INIT
    })
    if hiddenLoading then
      eventManager:notify({
        id = events.EID_HIDE_LOADING_PAGE
      })
    end
  else
    eventManager:notify({
      id = events.EID_CHALLENGE_RESTARTED,
      challenge = g_currentChallenge
    })
    eventManager:notify({
      id = events.EID_CHALLENGE_STARTED,
      challenge = g_currentChallenge
    })
  end
end
--[[function handleGameModeChange(page, selectedMenuItem)
  if currentGameMode == updateEditor then
    _G.res.stopAudio(currentMainMenuSong)
    levelName = page.items[selectedMenuItem].filename
    levelFolder = page.items[selectedMenuItem].folder
    setEditing(true)
    setPhysicsEnabled(physicsEnabled)
    currentLevelNumberInTheme = page.items[selectedMenuItem].pageLevelIndex or currentLevelNumberInTheme
    currentLevelNumber = page.items[selectedMenuItem].levelIndex or currentLevelNumber
    currentThemeNumber = page.items[selectedMenuItem].themeIndex or currentThemeNumber
    currentWorldNumber = page.items[selectedMenuItem].worldNumber or currentWorldNumber
    currentPageNumber = page.pageNumber or currentPageNumber
    loadLevelInternal(levelFolder .. levelName)
  end
end]]
function checkLogLevelNotCompleted()
  if highscores ~= nil and levelName ~= nil and startedFromEditor ~= true then
    local levelNotCompleted = highscores[levelName] == nil
    if levelNotCompleted and currentWorldNumber ~= nil and currentLevelNumberInTheme ~= nil then
      local level = getWorldLevelNumberCombination()
      local levelData, episode, world, levelNumber = getLevelById(levelName)
      local extra = g_episodes[episode].extra
      if not extra then
        eventManager:notify({
          id = events.EID_FLURRY_EVENT_STARTED_BEFORE_COMPLETION,
          level = level
        })
      end
    end
  end
end
function releaseCutScenes()
  releaseCompoSprites({
    "CUTSCENES_COMPOSPRITES"
  })
  releaseImages({"CUTSCENES"})
  loadBackgrounds()
  loadImages({
    "MENU",
    "OTHER",
    "INGAME",
    "LEVELSELECTION",
    "POPUPS",
    "BUTTONS",
    "TUTORIALS"
  })
  loadAssets({"HUD"})
  loadCompoSprites({
    "BUTTONS_COMPOSPRITES",
    "MENU_COMPOSPRITES"
  })
end
function releaseBackgrounds()
  releaseImages({
    "BACKGROUNDS"
  })
end
function loadBackgrounds()
  loadImages({
    "BACKGROUNDS"
  })
end
function loadCutScenes()
  if deviceModel ~= "windows" and deviceModel ~= "osx" then
    releaseCompoSprites({
      "BUTTONS_COMPOSPRITES",
      "MENU_COMPOSPRITES"
    })
    releaseImages({"OTHER", "MENU"})
    releaseImages({
      "INGAME",
      "LEVELSELECTION",
      "POPUPS",
      "BUTTONS",
      "TUTORIALS"
    })
    releaseAssets({"HUD"})
    releaseBackgrounds()
  end
  loadImages({"CUTSCENES"})
  loadCompoSprites({
    "CUTSCENES_COMPOSPRITES"
  })
end
function gotoLevelSelectionGoldenEggs(dt)
  print("(1.5.4) ep Golden Eggs clicked..\n")
  function currentGameMode()
  end
  eventManager:notify({
    id = events.EID_CHANGE_SCENE,
    target = "LEVEL_SELECTION_G"
  })
end
function loadPreviousLevel(dt)
  drawGame()
  drawMenu()
  if isLevelSelectionPage(levelSelectionPages) then
    if currentLevelNumberInTheme <= 1 then
      levelSelectionPages.currentPage = levelSelectionPages.currentPage - 1
      if levelSelectionPages.currentPage <= 0 then
        if levelSelectionPages == levelSelectionPagesBasic then
          levelSelectionPages.currentPage = 1
        else
          if levelSelectionPages == levelSelectionPagesExtra then
            levelSelectionPages = levelSelectionPagesBasic
          elseif levelSelectionPages == levelSelectionPagesPack3 then
            levelSelectionPages = levelSelectionPagesExtra
          elseif levelSelectionPages == levelSelectionPagesPack4 then
            levelSelectionPages = levelSelectionPagesPack3
          elseif levelSelectionPages == levelSelectionPagesPack5 then
            levelSelectionPages = levelSelectionPagesPack4
          elseif levelSelectionPages == levelSelectionPagesPack6 then
            levelSelectionPages = levelSelectionPagesPack5
          end
          levelSelectionPages.currentPage = levelSelectionPages.pageCount
          currentLevelNumberInTheme = levelSelectionPages.levelsPerPage
          currentLevelNumber = levelSelectionPages.pageCount * levelSelectionPages.levelsPerPage
          currentThemeNumber = currentThemeNumber - 1
          currentWorldNumber = currentWorldNumber - 1
        end
      else
        currentLevelNumberInTheme = levelSelectionPages.levelsPerPage
        currentLevelNumber = currentLevelNumber - 1
        currentThemeNumber = currentThemeNumber - 1
        currentWorldNumber = currentWorldNumber - 1
      end
    else
      currentLevelNumberInTheme = currentLevelNumberInTheme - 1
      currentLevelNumber = currentLevelNumber - 1
    end
    local index = (levelSelectionPages.currentPage - 1) * levelSelectionPages.levelsPerPage + levelSelectionPages.firstLevelIndex
    levelName = levelSelectionPages.items[currentLevelNumberInTheme + index - 1].filename
    levelFolder = levelSelectionPages.items[currentLevelNumberInTheme + index - 1].folder
  end
  levelRestartedFrom = nil
  loading = true
  setGameMode(updateLoading)
end
function loadNextLevel(dt)
  drawGame()
  local currentEpisode = g_episodes[currentThemeNumber]
  local currentPage = currentEpisode.pages[currentPageNumber]
  local currentLevel = currentPage.levels[currentLevelNumber]
  if currentLevelNumberInTheme >= #currentPage.levels then
    if currentPageNumber >= #currentEpisode.pages then
      if currentThemeNumber >= #g_episodes then
        currentThemeNumber = #g_episodes
      else
        currentLevelNumberInTheme = 1
        currentPageNumber = 1
        currentThemeNumber = currentThemeNumber + 1
      end
    else
      currentLevelNumberInTheme = 1
      currentPageNumber = currentPageNumber + 1
    end
  else
    currentLevelNumberInTheme = currentLevelNumberInTheme + 1
  end
  local currentLevelNumber = 0
  for i = 1, currentPageNumber - 1 do
    currentLevelNumber = currentLevelNumber + #currentEpisode.pages[i]
  end
  currentLevelNumber = currentLevelNumber + currentLevelNumberInTheme
  currentEpisode = g_episodes[currentThemeNumber]
  currentPage = currentEpisode.pages[currentPageNumber]
  currentLevel = currentPage.levels[currentLevelNumberInTheme]
  numberOfAttemptsInLevel = 1
  levelName = currentLevel.name
  levelFolder = "levels/" .. currentPage.folder_name .. "/"
  levelRestartedFrom = nil
  print("loadNextLevel [" .. _G.tostring(levelFolder) .. _G.tostring(levelName) .. "] (" .. _G.tostring(currentThemeNumber) .. "-" .. _G.tostring(currentLevelNumberInTheme) .. ")\n")
  eventManager:notify({
    id = events.EID_LEVEL_LOADING_INIT
  })
  function currentGameMode()
  end
end
function hasLevelPack(n)
  return true
end
function isEpisodeOpen(id)
  if g_registrationEnabled then
    if id == 1 or id == "G" then
      return true
    else
      return g_isRegistered
    end
  else
    return true
  end
end
function isEpisodeComplete(id)
  local ep = g_episodes[id]
  for _, v in _G.ipairs(ep.pages) do
    for _, v2 in _G.ipairs(v.levels) do
      if v2.episode_end then
        return highscores[v2.name] and highscores[v2.name].completed
      end
    end
  end
  return false
end
function showLoadingInitGameCenter()
  if mainMenu and mainMenu.items then
    local leaderboards = getItemByName(mainMenu.items, "leaderboards")
    local achievements = getItemByName(mainMenu.items, "achievements")
    local loaderLB = getItemByName(mainMenu.items, "loaderLB")
    local loaderAC = getItemByName(mainMenu.items, "loaderAC")
    achievements.selectable = false
    leaderboards.selectable = false
    loaderLB.x, loaderLB.y = leaderboards.x, leaderboards.y
    loaderAC.x, loaderAC.y = achievements.x, achievements.y
    loaderLB.show = true
    loaderAC.show = true
    loaderLB.angle = 0
    loaderAC.angle = 0
    leaderboards.sprite = "BUTTON_EMPTY"
    achievements.sprite = "BUTTON_EMPTY"
    initGameCenter()
    leaderboards.callFunction = nil
    achievements.callFunction = nil
  end
end
function hideLoadingInitGameCenter()
end
function showLoadingLeaderboards()
  local leaderboards = getItemByName(mainMenu.items, "leaderboards")
  local loader = getItemByName(mainMenu.items, "loaderLB")
  getItemByName(mainMenu.items, "achievements").selectable = false
  getItemByName(mainMenu.items, "achievements").sprite = "BUTTON_ACHIEVEMENTS_DISABLED"
  loader.x, loader.y = leaderboards.x, leaderboards.y
  loader.show = true
  loader.angle = 0
  leaderboards.sprite = "BUTTON_EMPTY"
  showLeaderboards()
  leaderboards.callFunction = nil
end
function hideLoadingLeaderboards()
  local main_menu = menuManager:getLink("MAIN_MENU")
  if main_menu then
    main_menu:resetGameCenterButtons()
  end
end
function showLoadingAchievements()
  local achievements = getItemByName(mainMenu.items, "achievements")
  local loader = getItemByName(mainMenu.items, "loaderAC")
  getItemByName(mainMenu.items, "leaderboards").selectable = false
  getItemByName(mainMenu.items, "leaderboards").sprite = "BUTTON_LEADERBOARDS_DISABLED"
  loader.x, loader.y = achievements.x, achievements.y
  loader.show = true
  loader.angle = 0
  achievements.sprite = "BUTTON_EMPTY"
  showAchievements()
  achievements.callFunction = nil
end
function hideLoadingAchievements()
  local main_menu = menuManager:getLink("MAIN_MENU")
  if main_menu then
    main_menu:resetGameCenterButtons()
  end
end
function showSystemPopup(title, message, icon)
  getItemByName(systemPopup.items, "title").text = title
  getItemByName(systemPopup.items, "message").text = message
  getItemByName(systemPopup.items, "icon").sprite = icon
  setActivePopupPage(systemPopup)
end
function hideSystemPopup()
  popupPage = nil
end
function showFBLikePopup()
  showSystemPopup("TEXT_FB_LEVELS_HINT_TITLE", "TEXT_FB_LEVELS_HINT")
end
function showPauseMenu(dt)
  levelRestartedFrom = "pause menu"
  _G.res.stopAudio("wood_rolling")
  _G.res.stopAudio("rock_rolling")
  _G.res.stopAudio("light_rolling")
  eventManager:notify({
    id = events.EID_ABOUT_MENU_OPENED
  })
  loginfo(" - Show pausemenu - ")
end
function hidePauseMenu(dt)
end
function showEagleTimeLeft()
  eagleInfoTimer = 3
end
function launchEagleBaitInGame()
  rubberBandPos.x = levelStartPosition.x
  rubberBandPos.y = levelStartPosition.y
  rubberBandSpeed = 0
  if currentBirdName ~= nil and objects.world[currentBirdName].shot ~= true then
    removeBird(objects.world[currentBirdName])
  elseif birdToSlingshotBirdName ~= nil then
    removeBird(objects.world[birdToSlingshotBirdName])
    currentBirdIndex = currentBirdIndex + 1
  end
  local nextBirdName
  repeat
    currentBirdIndex = currentBirdIndex + 1
    nextBirdName = getNextBird(currentBirdIndex)
    if nextBirdName ~= nil then
      removeBird(objects.world[nextBirdName])
    end
  until nextBirdName == nil
  currentBirdIndex = currentBirdIndex - 1
  birdToSlingshotBirdName = nil
  currentBirdName = nil
  launchEagleBait()
  if #birdTutorialPopups == 0 then
    changeResolution = nil
  end
  fillInNextBird = true
end
function launchEagleBait()
  eventManager:notify({
    id = events.EID_EAGLE_BAIT_LAUNCHED
  })
  local tempFlyingBird = flyingBird
  returnToBirdCamera()
  flyingBird = tempFlyingBird
  if isFreeEagleEnabled() then
    g_usingFreeEagle = true
  end
  eagleSoundPlayed = nil
  eagleBaitLaunched = true
  levelCompleteTimer = 0
  levelFailedTimer = -200
  local obj = baitSardine
  local name = createObject(blockTable, obj.definition, obj.name, obj.x * scaleFactor, obj.y * scaleFactor)
  obj.angle = _G.math.fmod(obj.angle, _G.math.pi * 2)
  if 0 > obj.angle then
    obj.angle = obj.angle + _G.math.pi * 2
  end
  setRotation(name, obj.angle)
  setMaterial(name, objects.world[name].material)
  if objects.world[name].texture ~= nil then
    local texture = blockTable.themes[name].texture
    setTexture(name, texture)
  end
  if objects.world[name].controllable then
    birdsCounter = birdsCounter + 1
    objects.world[name].startNumber = birdsCounter
  end
  objects.world[name].animTimer = 3
  objects.world[name].jumpTimer = 3
  birds[name] = objects.world[name]
  local sprites = getDamageSprite(objects.world[name], blockTable.blocks)
  objects.world[name].damageSprite = sprites.sprite
  objects.world[name].blinkSprite = sprites.blink
  objects.world[name].smileSprite = sprites.smile
  objects.world[name].frozen = false
  objects.world[name].isEagleBait = true
  objects.world[name].recordTrajectory = false
  if not settingsWrapper:getTutorialsForItem(objects.world[name].sprite) then
    settingsWrapper:createTutorialForItem(objects.world[name].sprite, blockTable.blocks[objects.world[name].definition].tutorialInfo)
    _G.table.insert(birdTutorialPopups, blockTable.blocks[objects.world[name].definition].tutorialInfo)
  else
  end
  nextBirdTimer = 0.1
  drawGame()
end
function setEffectsVolume(volume)
  for i = 0, 4 do
    _G.res.setTrackVolume(volume, i)
  end
end
function setMusicVolume(volume)
  _G.res.setTrackVolume(volume, 7)
end
function changeAudio(from)
  if subsystemsapi:isAndroid() then
    print("audio enabled : " .. _G.tostring(settingsWrapper:isAudioEnabled()))
    if settingsWrapper:isAudioEnabled() then
      setMusicVolume(0)
      setEffectsVolume(0)
      eventManager:notify({
        id = events.EID_AUDIO_STATE_CHANGED,
        state = 0,
        from = from
      })
    else
      setMusicVolume(1)
      setEffectsVolume(1)
      eventManager:notify({
        id = events.EID_AUDIO_STATE_CHANGED,
        state = 1,
        from = from
      })
    end
  elseif settingsWrapper:isAudioEnabled() then
    audioRampVolume = _G.res.getTrackVolume(7)
    audioRampLength = -0.5
    eventManager:notify({
      id = events.EID_AUDIO_STATE_CHANGED,
      state = 0,
      from = from
    })
  else
    audioRampVolume = _G.res.getTrackVolume(7)
    audioRampLength = 0.5
    _G.res.startAudioOutput()
    eventManager:notify({
      id = events.EID_AUDIO_STATE_CHANGED,
      state = 1,
      from = from
    })
  end
  settingsWrapper:toggleAudioEnabled()
  saveLuaFileWrapper("settings.lua", "settings", true)
end
function gotoMightyEagleTrailer()
  eventManager:notify({
    id = events.EID_MIGHTY_EAGLE_TRAILER_CLICKED
  })
end
function gotoSeasonsInAppStore()
  eventManager:notify({
    events.EID_SEASONS_LINK_CLICKED
  })
end
function gotoNewsLetter()
  eventManager:notify({
    id = events.EID_NEWSLETTER_CLICKED
  })
end
function openURL(url)
  if g_delayedURLOpen then
    return
  end
  if (deviceModel == "windows" or deviceModel == "osx") and isInFullScreenMode() then
    setFullScreenMode(false)
    g_restoreFullScreenOnReactivate = 1
    g_delayedURLOpen = {
      time = g_time + 0.1,
      url = url
    }
  else
    if (deviceModel == "windows" or deviceModel == "osx") and g_restoreFullScreenOnReactivate == 1 then
      g_restoreFullScreenOnReactivate = 2
    end
    print("opening URL: " .. _G.tostring(url) .. "\n")
    _G.res.openURL(url)
  end
end
function gotoABFBConnect()
  if not settingsWrapper:isFbPageLiked() then
    settingsWrapper:setFbPageLiked()
    eventManager:notify({
      id = events.EID_HIDE_LOADING_PAGE
    })
    openURL(AB_FBCONNECT_URL)
    eventManager:notify({
      id = events.EID_FACEBOOK_LIKE_CLICKED
    })
  else
    showFBLiked()
  end
end
function showFBLiked()
  eventManager:notify({
    id = events.EID_PUSH_FRAME,
    target = ui.Prompt:new({
      title = "TEXT_LIKE_CONFIRMED_TITLE",
      content = "TEXT_LIKE_CONFIRMED",
      box_width = 0.5
    })
  })
  eventManager:notify({
    id = events.EID_HIDE_LOADING_PAGE
  })
end
function gotoABShop()
  eventManager:notify({
    id = events.EID_ABSHOP_LINK_CLICKED
  })
  openURL(ABSHOP_URL)
end
function gotoAndroidMarket()
  openURL(ANDROID_MARKET_FULL_VERSION_URL)
end
function gotoPrivacyPolicy()
  openURL(PRIVACY_POLICY_URL)
end
function gotoEula()
  openURL(EULA_URL)
end
function gotoFacebook()
  eventManager:notify({
    id = events.EID_FACEBOOK_LINK_CLICKED
  })
  openURL(FACEBOOK_URL)
end
function gotoTwitter()
  eventManager:notify({
    id = events.EID_TWITTER_LINK_CLICKED
  })
  openURL(TWITTER_URL)
end
function gotoSinaWeibo()
  eventManager:notify({
    id = events.EID_SINA_WEIBO_LINK_CLICKED
  })
  openURL(SINA_WEIBO_URL)
end
function gotoTencentWeibo()
  eventManager:notify({
    id = events.EID_TENCENT_WEIBO_LINK_CLICKED
  })
  openURL(TENCENT_WEIBO_URL)
end
function gotoQzone()
  eventManager:notify({
    id = events.EID_QZONE_LINK_CLICKED
  })
  openURL(QZONE_URL)
end
function gotoAngryBirdsTrailer()
  eventManager:notify({
    id = events.EID_CINEMATIC_TRAILER_CLICKED
  })
  openURL(ANGRY_BIRDS_TRAILER_URL)
end
function gotoOviStore(dt)
  if deviceModel == "n900" then
    openURL(OVI_STORE_URL)
  elseif deviceModel == "s60" then
    openURL(OVI_STORE_URL_S60)
  end
end
function gotoS60UpdatePage()
  openURL(ROVIO_UPDATE_URL_S60)
end
function gotoMoreOnOviStore()
  openURL(OVI_STORE_MORE_GAMES_URL_S60)
  removePopupMenu()
end
function addPopupMenu()
end
function removePopupMenu()
end
function drawLevelSelectionBackground(page)
  setRenderState(0, 0, -1, 1, 0)
  _G.res.drawSprite("", "LS_BACKGROUND", -screenWidth, 0, "LEFT", "TOP", _G.math.ceil(screenWidth / 2), screenHeight)
  setRenderState(0, 0, 1, 1, 0)
  _G.res.drawSprite("", "LS_BACKGROUND", 0, 0, "LEFT", "TOP", _G.math.floor(screenWidth / 2), screenHeight)
  setRenderState(0, 0, 1, 1, 0)
end
function filterLoadedLevel()
  if not startedFromEditor then
    local goldenEgg = function(level)
      return settingsWrapper:isGoldenEggUnlocked(level)
    end
    local boomerangBird = function(s)
      return settings[s] == true
    end
    local filterItems = {
      {
        world = 4,
        level = 7,
        item = "ExtraGoldenEgg_1",
        check = goldenEgg("LevelGE_5")
      },
      {
        world = 5,
        level = 19,
        item = "ExtraGoldenEgg_1",
        check = goldenEgg("LevelGE_3")
      },
      {
        world = 8,
        level = 15,
        item = "ExtraGoldenEgg_1",
        check = goldenEgg("LevelGE_8")
      },
      {
        world = 6,
        level = 4,
        item = "ExtraBoomerangBird_1",
        check = boomerangBird("boomerangBirdAchieved")
      },
      {
        world = 9,
        level = 5,
        item = "ExtraBoomerangBird_1",
        check = boomerangBird("boomerangBirdAchieved2")
      },
      {
        world = 9,
        level = 14,
        item = "ExtraGoldenEgg_1",
        check = goldenEgg("LevelGE_9")
      },
      {
        world = 11,
        level = 15,
        item = "ExtraGoldenEgg_1",
        check = goldenEgg("LevelGE_11")
      },
      {
        world = 13,
        level = 10,
        item = "ExtraGoldenEgg_1",
        check = goldenEgg("LevelGE_17")
      },
      {
        world = 13,
        level = 12,
        item = "ExtraSuperBowl_2",
        check = goldenEgg("LevelGE_19")
      },
      {
        world = 14,
        level = 4,
        item = "ExtraGoldenEgg_1",
        check = goldenEgg("LevelGE_18")
      },
      {
        world = 15,
        level = 12,
        item = "ExtraGoldenEgg_1",
        check = goldenEgg("LevelGE_20")
      },
      {
        world = 16,
        level = 9,
        item = "ExtraGoldenEgg_1",
        check = goldenEgg("LevelGE_21")
      },
      {
        world = 17,
        level = 12,
        item = "ExtraTreasureChest_1",
        check = goldenEgg("LevelGE_23")
      },
      {
        world = 18,
        level = 6,
        item = "ExtraGoldenEgg_1",
        check = goldenEgg("LevelGE_24")
      }
    }
    for i = 1, #filterItems do
      if currentWorldNumber == filterItems[i].world and currentLevelNumberInTheme == filterItems[i].level and filterItems[i].check then
        loadedObjects.world[filterItems[i].item] = nil
        for k, v in _G.pairs(loadedObjects.joints) do
          if v.end1 == filterItems[i].item or v.end2 == filterItems[i].item then
            loadedObjects.joints[k] = nil
          end
        end
      end
    end
    if currentEpisode == "G" and currentLevelNumber == 20 then
      local time = getCurrentTime()
      local center = loadedObjects.world.StaticBlockTheme17_06_1
      local minutes1 = loadedObjects.world.WoodBlock1_1
      local minutes2 = loadedObjects.world.WoodBlock1_2
      local seconds = loadedObjects.world.LightBlock1_1
      if center and minutes1 and minutes2 and seconds then
        local m_radius = _G.math.sqrt(_G.math.pow(minutes1.x - center.x, 2) + _G.math.pow(minutes1.y - center.y, 2))
        local m_angle = (time.minutes / 60 + time.seconds / 3600) * _G.math.pi * 2 - _G.math.pi * 0.5
        minutes1.x = center.x + _G.math.cos(m_angle) * m_radius
        minutes1.y = center.y + _G.math.sin(m_angle) * m_radius
        minutes2.x = minutes1.x
        minutes2.y = minutes1.y
        local s_radius = _G.math.sqrt(_G.math.pow(seconds.x - center.x, 2) + _G.math.pow(seconds.y - center.y, 2))
        local s_angle = time.seconds / 60 * _G.math.pi * 2 - _G.math.pi * 0.5
        seconds.x = center.x + _G.math.cos(m_angle) * s_radius
        seconds.y = center.y + _G.math.sin(m_angle) * s_radius
      end
    end
  end
end
function showRewardPopup(type, params)
  local popup
  if type == "GOLDEN_EGG" then
    popup = GoldenEgg:new()
    _G.res.playAudio("goldenegg", 1, false)
  elseif type == "BOOMERANG_BIRD" then
    popup = BoomerangBirdPopup:new()
    _G.res.playAudio("star_collect", 1, false)
  elseif type == "STAR" then
    popup = StarPopup:new(params.first_time)
    _G.res.playAudio("star_collect", 1, false)
  elseif type == "GENERIC_REWARD" then
    popup = RewardPopup:new(params.sprite)
    _G.res.playAudio(params.sound, 1, false)
  end
  notificationsFrame:addChild(popup)
  popup.x = screenWidth * 0.5
  popup.y = screenHeight * 0.9
  popup:onEntry()
  popup:layout()
  local duration = 1.2
  processManager:insertAction({
    name = "golden egg rise",
    finished = false,
    item = popup,
    start = 0,
    duration = duration,
    meta = {},
    action = function(item, elapsed, target, dt, meta)
      local moveRate = tweenEaseCubicOut(elapsed, 0, 1, target)
      local rate = elapsed / target
      item.y = (2.5 - moveRate * 1.5) * (screenHeight * 0.5)
      item.x = screenWidth * 0.5
      item.angle = item.angle + dt * 2
      item.visible = true
      item:getChild("egg").visible = true
      item:getChild("egg").angle = -item.angle
      item.rate = rate
    end
  })
  processManager:insertAction({
    name = "golden egg stay middle",
    finished = false,
    item = popup,
    start = duration,
    duration = duration,
    meta = {},
    action = function(item, elapsed, target, dt, meta)
      item.angle = item.angle + dt * 2
      item.x = screenWidth * 0.5
      item:getChild("egg").angle = -item.angle
    end
  })
  processManager:insertAction({
    name = "golden egg go away",
    finished = false,
    item = popup,
    start = duration * 2,
    duration = duration,
    meta = {},
    action = function(item, elapsed, target, dt, meta)
      local moveRate = tweenEaseCubicIn(elapsed, 0, 1, target)
      local rate = elapsed / target
      item.y = screenHeight * 0.5 - moveRate * 0.7 * screenHeight
      item.angle = item.angle + dt * 2
      item.rate = 1 - rate
      item.x = screenWidth * 0.5
      item:getChild("egg").angle = -item.angle
    end
  })
  processManager:start()
end
function revealGoldenEgg(name)
  settingsWrapper:unlockGoldenEgg(name)
  showRewardPopup("GOLDEN_EGG")
end
function loadLevelInternal(levelFileName)
  g_tutorialActive = nil
  g_usingFreeEagle = false
  g_level_completing = false
  if levelFileName ~= nil then
    print("  ------------  LOAD LEVEL INTERNAL.. fileName = " .. levelFileName .. "\n")
  end
  releaseCutScenes()
  _G.res.stopAllAudio()
  quadClick = false
  quadClickCounter = 0
  eagleBaitLaunched = false
  eagleTimer = nil
  cameraShake = nil
  triggerTime = 0
  editor = {drawOneLayer = false, currentLayer = 0}
  birdToSlingshotAnimationTimer = 0
  birdToSlingshotAnimationAngle = 0.75 * _G.math.pi
  birdToSlingshotSurplusAngle = birdToSlingshotAnimationAngle - _G.math.pi * 0.5
  birdToSlingshotAnimationHeight = 0
  birdToSlingshotAnimationStartX = 0
  birdToSlingshotAnimationStartY = 0
  birdToSlingshotBirdName = nil
  currentBirdIndex = 1
  currentBirdName = nil
  flyingBird = nil
  birdSpecialtyAvailable = false
  g_touch_released_after_specialty = true
  birdFired = false
  birdReady = false
  fillInNextBird = false
  birdSelected = false
  showTapIcon = true
  birdsShot = 0
  tapStarted = false
  tapCount = 0
  tapTimer = 0
  tapPosition = {x = 0, y = 0}
  doubleClickTimer = 0
  levelCompleteTimer = 0
  levelCompleted = false
  levelFailedTimer = 0
  birdBuffTimer = 0
  castleCameraTimer = 0
  dragCursorIndex = 1
  dragCursorTable = {
    {
      dx = 0,
      dy = 0,
      dt = 1
    }
  }
  rubberBandAngle = 0
  rubberBandLength = 0
  oldRubberBandLength = 0
  g_last_angle = nil
  g_powerups_used = {}
  g_slingshot_power = 1
  g_sling_scope = false
  g_sling_scope_animation = 0
  g_powerups_active = false
  g_bird_quake = false
  g_bird_quake_timer = 0
  g_super_seed = false
  g_slingshot_back = "SLING_SHOT_01_BACK"
  g_slingshot_front = "SLING_SHOT_01_FRONT"
  g_rubber_r = 48
  g_rubber_g = 23
  g_rubber_b = 8
  g_king_sling = false
  g_sling_scope_activation = false
  g_disable_slingshot = false
  g_extra_game_update = nil
  g_disable_double_tap = false
  g_reload_bird = animateBirdToSlingShot
  g_default_start_x = 0
  g_default_start_y = 0
  g_bird_reload_delay = 1
  g_game_win_condition = checkLevelComplete
  g_game_lose_condition = checkLevelFailed
  g_bird_remove_time = 1
  g_bird_remove_velocity_treshold = 0.0025
  g_camera_follows_launched_bird = true
  g_hud_class = ui.GameHud
  g_eagle_disabled = false
  g_powerups_disabled = false
  g_special_game_mode = false
  g_sound_next_bird = "bird_next_military"
  g_sound_level_clear = "level_clear_military"
  g_sound_level_start = "level_start_military"
  g_sound_level_failed = "level_failed_piglets"
  g_sound_birds = "bird_misc"
  g_sound_pigs = "piglette"
  g_zooming_disabled = false
  cameraResetTimer = 0
  showTapTimer = 0
  nextBirdTimer = 0.5
  zoomLevel = 0
  oldZoomLevel = 0
  worldScale = 1
  oldScoreLen = 0
  sweepSpeed = 0
  particleAmount = 0
  levelLeftEdge = 100000
  levelRightEdge = -100000
  g_challengeHudTimer = 0
  g_goldenEggKeyCount = 0
  g_skip_to_level_end = false
  g_skip_wait_for_moving_objects = false
  birdsCounter = 0
  objectCounts = {}
  floatingScores = {}
  score = 0
  scoreTable = {}
  scoreTable.blocks = {score = 0, blockDestroyedScore = blockDestroyedScoreIncrement}
  scoreTable.birds = {score = 0}
  oldScore = 0
  lastScoreTime = 0
  endTimeout = false
  selectedObjects = {}
  cameraTargetObject = nil
  allowResetToBirdCamera = false
  particles = {}
  birdTutorialPopups = {}
  showTutorialGoldenEgg = false
  deadBlocks = {}
  g_cinematic_camera = {}
  g_cinematic_camera_timer = 0
  if g_platformTutorials and g_platformTutorials[deviceModel] then
    for _, v in _G.ipairs(g_platformTutorials[deviceModel]) do
      if not settingsWrapper:getTutorialsForItem(v.id) then
        local sprite = getTutorialSprite(v)
        if addTutorial(birdTutorialPopups, v) then
          settingsWrapper:createTutorialForItem(v.id, sprite, false)
        end
      end
    end
  end
  if objects.world ~= nil then
    if objects.world.MightyEagle_a ~= nil then
      removeObject("MightyEagle_a")
      objects.world.MightyEagle_a = nil
    end
    for k, v in _G.pairs(objects.world) do
      objects.world[k] = nil
    end
  end
  birds = {}
  levelGoals = {}
  flyingGrenades = {}
  birdTrajectory = {
    {},
    {},
    {}
  }
  otherBirds = {}
  episode4BGCranes = {startX = 64}
  eagleInfoTimer = nil
  currentThemeIndex = 1
  objects.world = {}
  objects.joints = {}
  objects.counts = {}
  objects.themeSprites = {}
  objects.physicsToWorld = physicsToWorld
  objects.theme = "theme1"
  objects.castleCameraData = nil
  objects.birdCameraData = nil
  setWorldScale(worldScale)
  screen.x = 0
  screen.y = 0
  levelStartPosition.x = 0
  levelStartPosition.y = 0
  slingShotBasePosition.x = 0
  slingShotBasePosition.y = 0
  rubberBandPos.x = 0
  rubberBandPos.y = 0
  rubberBandSpeed = 0
  objects.levelParticles = {}
  loadLevel(levelFileName)
  print(" - - - Level loaded \n")
  filterLoadedLevel()
  print(" - - - Filter loaded level done \n")
  if loadedObjects == nil then
    for k0, v0 in _G.pairs(blockTable.themes) do
      if v0.index ~= nil and v0.index == currentThemeIndex then
        currentTheme = k0
      end
    end
    createBox("ground", "", (levelLeftEdge + levelRightEdge) * 0.5, 5, 2000, 10, 0, 0.8, 0, true, false, 0)
    objects.world.ground.material = "staticGround"
    objects.world.ground.definition = "Ground"
    objects.world.ground.strength = 30
    objects.world.ground.defence = 1000000
    print("Setting current theme to " .. currentTheme .. "\n")
    setTheme(currentTheme)
    themeSpriteObjects = {}
    return
  end
  local countsSaved = false
  if loadedObjects.counts ~= nil then
    countsSaved = true
    for k, v in _G.pairs(loadedObjects.counts) do
      objects.counts[k] = v
    end
  end
  local pscale = 100
  if loadedObjects.physicsToWorld ~= nil then
    pscale = loadedObjects.physicsToWorld
  end
  scaleFactor = pscale / physicsToWorld
  local oldTheme = settingsWrapper:getCurrentMainMenuTheme()
  if loadedObjects.theme ~= nil then
    objects.theme = loadedObjects.theme
    currentThemeIndex = blockTable.themes[objects.theme].index
    settingsWrapper:setCurrentZoomLevelMainMenu(0)
    for k0, v0 in _G.pairs(blockTable.themes) do
      if v0.index ~= nil and v0.index == currentThemeIndex then
        currentTheme = k0
        settingsWrapper:setCurrentMainMenuTheme(k0)
        if not v0.mainMenuScale then
          local layersAmount = 0
          for l = 1, #v0.bgLayers do
            layersAmount = layersAmount + 1
            settingsWrapper:setCurrentZoomLevelMainMenu(v0.bgLayers[l][4] + settingsWrapper:getCurrentZoomLevelMainMenu())
          end
          settingsWrapper:setCurrentZoomLevelMainMenu(settingsWrapper:getCurrentZoomLevelMainMenu() / layersAmount)
        else
          settingsWrapper:setCurrentZoomLevelMainMenu(v0.mainMenuScale)
        end
        currentMusic = v0.music
        currentMainMenuSong = v0.menuMusic or "title_theme"
      end
    end
  end
  if useDynamicAssets then
    dynamic.enterIngame(oldTheme, currentTheme)
  elseif showEditor == false then
    loadThemeGraphics(currentTheme)
  else
    loadAllThemeGraphics()
  end
  setTheme(currentTheme)
  print("Theme set\n")
  themeSpriteObjects = {}
  if loadedObjects.world ~= nil then
    for k, v in _G.pairs(loadedObjects.world) do
      local obj = v
      if obj.name ~= "ground" then
        local name = createObject(blockTable, obj.definition, obj.name, obj.x * scaleFactor, obj.y * scaleFactor)
        obj.angle = _G.math.fmod(obj.angle, _G.math.pi * 2)
        if 0 > obj.angle then
          obj.angle = obj.angle + _G.math.pi * 2
        end
        setRotation(name, obj.angle)
        setMaterial(name, objects.world[name].material)
        if objects.world[name].texture ~= nil then
          local texture = blockTable.themes[currentTheme].texture
          setTexture(name, texture)
        end
        local width = objects.world[name].width
        if width == nil then
          width = objects.world[name].radius
        end
        if objects.world[name].x - width < levelLeftEdge then
          levelLeftEdge = objects.world[name].x - width
        end
        if objects.world[name].x + width > levelRightEdge then
          levelRightEdge = objects.world[name].x + width
        end
        if objects.world[name].controllable then
          birdsCounter = birdsCounter + 1
          if obj.startNumber ~= nil then
            objects.world[name].startNumber = obj.startNumber
          else
            objects.world[name].startNumber = birdsCounter
          end
          if obj.startNumber == 1 then
            g_default_start_x = objects.world[name].x
            g_default_start_y = objects.world[name].y
          end
          if isChallengeMode() then
            if obj.startNumber == 1 then
              challengeBirdStartX = objects.world[name].x
              challengeBirdStartY = objects.world[name].y
            end
            objects.world[name] = nil
            removeObject(obj.name)
          end
        end
      end
    end
  end
  if isChallengeMode() then
    birdsCounter = 1
    if g_currentChallenge.type == "BIRD_FLOCK" then
      local x = 1
      local bird = g_currentChallengeProgress.shotsQueue[x]
      local name = createObject(blockTable, bird, "challengeBird" .. birdsCounter .. bird, challengeBirdStartX * scaleFactor, challengeBirdStartY * scaleFactor)
      setRotation(name, 0)
      setMaterial(name, objects.world[name].material)
      objects.world[name].controllable = true
      if objects.world[name].texture ~= nil then
        local texture = blockTable.themes[currentTheme].texture
        setTexture(name, texture)
      end
      birdsCounter = birdsCounter + 1
      objects.world[name].startNumber = 1
    end
    for _, v in _G.ipairs(g_currentChallengeProgress.shotsQueue) do
      if blockTable.blocks[v].tutorialInfo ~= nil then
        local birdSprite = blockTable.blocks[v].sprite
        if not settingsWrapper:getTutorialsForItem(birdSprite) then
          local hasExtraTutorial = false
          if birdSprite == "BIRD_GREEN" or birdSprite == "BIRD_BLUE" or birdSprite == "BIRD_YELLOW" or birdSprite == "BIRD_GREY" or birdSprite == "BIRD_BOOMERANG" or birdSprite == "BIRD_PUFFER_1" then
            hasExtraTutorial = true
          end
          settingsWrapper:createTutorialForItem(birdSprite, blockTable.blocks[v].tutorialInfo, hasExtraTutorial)
          _G.table.insert(birdTutorialPopups, blockTable.blocks[v].tutorialInfo)
          eventManager:notify({
            id = events.EID_TUTORIAL_WATCHED,
            data = {sprite = birdSprite}
          })
        end
      end
    end
  end
  createBox("ground", "", (levelLeftEdge + levelRightEdge) * 0.5, 5, 2000, 10, 0, 0.8, 0, true, false, 0)
  objects.world.ground.material = "staticGround"
  objects.world.ground.definition = "Ground"
  objects.world.ground.strength = 30
  objects.world.ground.defence = 1000000
  countsSaved = true
  if loadedObjects.themeSprites then
    for k, v in _G.pairs(loadedObjects.themeSprites) do
      addThemeSprite(k, v)
      if not objects.themeSprites then
        objects.themeSprites = {}
      end
      objects.themeSprites[v.name] = {
        definition = v.definition,
        name = v.name,
        x = v.x,
        y = v.y,
        layer = v.layer,
        angle = v.angle,
        scale = v.scale
      }
    end
  end
  print("Creating joints\n")
  if loadedObjects.joints ~= nil then
    for k, v in _G.pairs(loadedObjects.joints) do
      createJoint(v)
    end
  end
  objects.castleCameraData = loadedObjects.castleCameraData
  objects.birdCameraData = loadedObjects.birdCameraData
  objects.doNotWaitForMovingObjects = loadedObjects.doNotWaitForMovingObjects
  if loadedObjects.levelParticles ~= nil and _G.type(loadedObjects.levelParticles) == "table" and loadedObjects.levelParticles.settingsFrame then
    g_levelParticlesEnabled = true
    objects.levelParticles = loadedObjects.levelParticles
    print("enabled level particles\n")
  else
    g_levelParticlesEnabled = false
    print("no level particles\n")
  end
  for k, v in _G.pairs(loadedObjects) do
    loadedObjects[k] = nil
  end
  loadedObjects.cameraData = nil
  selectedBird = nil
  local maxScore = 0
  birdCount = 0
  for k, v in _G.pairs(objects.world) do
    if v.controllable == true then
      if modifiers ~= nil then
      end
      birdCount = birdCount + 1
      v.animTimer = _G.math.random(10, 30) / 10
      v.jumpTimer = _G.math.random(10, 30) / 10
      setRotation(v.name, 0)
      setObjectParameter(v.name, 2, 0)
      birds[k] = v
      if blockTable.blocks[v.definition].tutorialInfo ~= nil and not settingsWrapper:getTutorialsForItem(v.sprite) then
        local birdSprite = blockTable.blocks[v.definition].sprite
        local hasExtraTutorial = false
        if birdSprite == "BIRD_GREEN" or birdSprite == "BIRD_BLUE" or birdSprite == "BIRD_YELLOW" or birdSprite == "BIRD_GREY" or birdSprite == "BIRD_BOOMERANG" or birdSprite == "BIRD_PUFFER_1" then
          hasExtraTutorial = true
        end
        settingsWrapper:createTutorialForItem(v.sprite, blockTable.blocks[v.definition].tutorialInfo, hasExtraTutorial)
        _G.table.insert(birdTutorialPopups, blockTable.blocks[v.definition].tutorialInfo)
        eventManager:notify({
          id = events.EID_TUTORIAL_WATCHED,
          data = {sprite = birdSprite}
        })
      end
    end
    if v.levelGoal then
      v.blinkTimer = _G.math.random(5, 30) / 10
      v.oinkTimer = _G.math.random(5, 30) / 10
      levelGoals[k] = v
      setObjectParameter(k, 1, 1)
    end
    local sprites = getDamageSprite(v, blockTable.blocks)
    v.damageSprite = sprites.sprite
    v.blinkSprite = sprites.blink
    v.smileSprite = sprites.smile
    v.frozen = false
    if v.controllable then
      maxScore = maxScore + birdsLeftScoreIncrement
    elseif v.levelGoal then
      maxScore = maxScore + v.strength * 10 + pigletteDestroyedScoreIncrement
    elseif v.defence <= 1000 then
      maxScore = maxScore + v.strength * 10
      destroyedBonus = blockDestroyedScoreIncrement
      if blockTable.blocks[v.definition].destroyedScoreInc ~= nil then
        destroyedBonus = blockTable.blocks[v.definition].destroyedScoreInc
      end
      maxScore = maxScore + destroyedBonus
    end
  end
  maxScore = maxScore - birdsLeftScoreIncrement
  print("Max score for " .. currentWorldNumber .. "-" .. currentLevelNumberInTheme .. ": " .. maxScore .. "\n")
  levelStartTimer = 0
  local startObjectName = getNextBird(1)
  if startObjectName ~= nil then
    setObjectParameter(startObjectName, 2, 1)
  end
  if startObjectName ~= nil and objects.world[startObjectName] ~= nil then
    local px, py = _G.res.getSpritePivot("", "SLING_SHOT_01_BACK")
    local sw, sh = _G.res.getSpriteBounds("", "SLING_SHOT_01_BACK")
    local r = objects.world[startObjectName].radius
    if r == nil then
      r = 0
    end
    levelStartPosition.x = objects.world[startObjectName].x
    levelStartPosition.y = objects.world[startObjectName].y - (sh - py) * physicsScale + r + 0.2
    slingShotBasePosition.x = objects.world[startObjectName].x
    slingShotBasePosition.y = objects.world[startObjectName].y
    rubberBandPos.x = levelStartPosition.x - 0.1
    rubberBandPos.y = levelStartPosition.y - 0.1
    baitSardine.x, baitSardine.y = objects.world[startObjectName].x, objects.world[startObjectName].y
  end
  local c = blockTable.themes[objects.theme].color
  setBGColor(c.r, c.g, c.b)
  drawRect(c.r / 255, c.g / 255, c.b / 255, 1, 0, 0, screenWidth, screenHeight, false)
  initCameras()
  if objects.levelParticles ~= nil then
    local birdCamera = objects.birdCameraData
    local castleCamera = objects.castleCameraData
    if objects.levelParticles.startAtGroundLevel then
      objects.levelParticles.y = 0
    else
      objects.levelParticles.y = _G.math.min(castleCamera[deviceModel].py, castleCamera[deviceModel].py) - screenHeight * 0.5 / (screenHeight * minWorldScale / screenWidth)
    end
    objects.levelParticles.x = (castleCamera[deviceModel].px + screenWidth / castleCamera[deviceModel].sx + (birdCamera[deviceModel].px - screenWidth * 0.5 / birdCamera[deviceModel].sx) + _G.math.abs(objects.levelParticles.y)) / 2
    objects.levelParticles.width = castleCamera[deviceModel].px + castleCamera[deviceModel].screenWidth / castleCamera[deviceModel].sx - (birdCamera[deviceModel].px - birdCamera[deviceModel].screenWidth / birdCamera[deviceModel].sx) + _G.math.abs(objects.levelParticles.y)
    objects.levelParticles.firstFrame = true
    levelParticlesTimer = 0
  end
  eagleUsedInCurrentLevel = false
  for k, v in _G.pairs(settingsWrapper:getEagleUsedIn()) do
    if v.level == levelName then
      eagleUsedInCurrentLevel = true
      break
    end
  end
  editor = {drawOneLayer = false, currentLayer = 0}
  loadedObjects = nil
  loading = false
  loadingPageDrawn = false
  print("level load complete\n")
  checkLogLevelNotCompleted()
  _G.collectgarbage("collect")
  eventManager:notify({
    id = events.EID_LEVEL_LOADING_DONE
  })
  if not startedFromEditor then
    eventManager:notify({
      id = events.EID_GOTO_GAME
    })
  end
  g_levelLoaded = true
end
function getIndexInTable(tableObj, element)
  local index = 1
  for k, v in _G.pairs(tableObj) do
    if v == element then
      return index
    end
    index = index + 1
  end
  return 0
end
function createObject(definitions, objectDefinition, objName, xpos, ypos)
  local name = ""
  local blockDef = definitions.blocks[objectDefinition]
  if blockDef == nil then
    print("<ERROR> level contains a nonexistant block \"" .. _G.tostring(objectDefinition) .. "\"")
    return ""
  end
  local materialDef = definitions.materials[blockDef.material]
  local density = blockDef.density
  local friction = blockDef.friction
  local restitution = blockDef.restitution
  local controllable = blockDef.controllable
  local strength = blockDef.strength
  local defence = blockDef.defence
  local levelGoal = blockDef.levelGoal
  local collision = blockDef.collision
  local damageFactors = blockDef.damageFactors
  local useLegacyCollisionPath = blockDef.useLegacyCollisionPath
  local z_order = blockDef.z_order
  local pivotx, pivoty, forceX, forceY
  if materialDef ~= nil then
    if forceX == nil then
      forceX = materialDef.forceX
    end
    if forceY == nil then
      forceY = materialDef.forceY
    end
    if density == nil then
      density = materialDef.density
      definitions.blocks[objectDefinition].density = density
    end
    if friction == nil then
      friction = materialDef.friction
      definitions.blocks[objectDefinition].friction = friction
    end
    if restitution == nil then
      restitution = materialDef.restitution
      definitions.blocks[objectDefinition].restitution = restitution
    end
    if controllable == nil then
      controllable = materialDef.controllable
      definitions.blocks[objectDefinition].controllable = controllable
    end
    if strength == nil then
      strength = materialDef.strength
      definitions.blocks[objectDefinition].strength = strength
    end
    if defence == nil then
      defence = materialDef.defence
      definitions.blocks[objectDefinition].defence = defence
    end
    if forceX == nil then
      forceX = materialDef.forceX
      definitions.blocks[objectDefinition].forceX = forceX
    end
    if z_order == nil then
      z_order = materialDef.z_order
      definitions.blocks[objectDefinition].z_order = z_order
    end
  end
  if z_order == nil then
    z_order = 0
    definitions.blocks[objectDefinition].z_order = z_order
  end
  if countsSaved == false or objName == nil then
    if objects.counts[objectDefinition] == nil then
      objects.counts[objectDefinition] = 0
    end
    objects.counts[objectDefinition] = objects.counts[objectDefinition] + 1
    name = objectDefinition .. "_" .. objects.counts[objectDefinition]
  else
    name = objName
  end
  local sprite = blockDef.sprite
  local w, h = 1, 1
  local sizeFactor = 0.92
  if sprite == nil and blockDef.damageSprites ~= nil then
    sprite = blockDef.damageSprites.damage1.sprite
  end
  if blockDef.type == "box" then
    if blockDef.width == nil or blockDef.height == nil then
      w, h = _G.res.getSpriteBounds("", sprite)
      if blockDef.density == 0 then
        sizeFactor = 1
      end
      w = w * physicsScale * sizeFactor
      h = h * physicsScale * sizeFactor
      pivotx, pivoty = _G.res.getSpritePivot("", sprite)
    else
      w = blockDef.width
      h = blockDef.height
      pivotx, pivoty = _G.res.getSpritePivot("", sprite)
    end
    if collision == nil then
      collision = true
    end
    createBox(name, sprite, xpos, ypos, w, h, density, friction, restitution, collision, controllable, z_order)
    if controllable then
      objects.world[name].damageFactors = damageFactors
      objects.world[name].useLegacyCollisionPath = useLegacyCollisionPath
    end
  end
  if blockDef.type == "polygon" then
    if sprite ~= "" and sprite ~= nil then
      w, h = _G.res.getSpriteBounds("", sprite)
      if blockDef.density == 0 then
        sizeFactor = 1
      end
      w = w * physicsScale * sizeFactor
      h = h * physicsScale * sizeFactor
      pivotx, pivoty = _G.res.getSpritePivot("", sprite)
    else
      w = blockDef.width
      h = blockDef.height
      pivotx, pivoty = _G.res.getSpritePivot("", sprite)
    end
    if collision == nil then
      collision = true
    end
    clearVertices()
    if blockDef.vertices ~= nil then
      for i = 1, #blockDef.vertices do
        local vert = blockDef.vertices[i]
        addVertex(vert.x * w - w * 0.5, vert.y * h - h * 0.5)
      end
    end
    createPolygon(name, sprite, xpos, ypos, w, h, density, friction, restitution, collision, controllable, z_order)
    if controllable then
      objects.world[name].damageFactors = damageFactors
      objects.world[name].useLegacyCollisionPath = useLegacyCollisionPath
    end
  end
  if blockDef.type == "circle" then
    if blockDef.radius ~= nil then
      w = blockDef.radius
    elseif sprite ~= "" and sprite ~= nil then
      w, h = _G.res.getSpriteBounds("", sprite)
      w = w * 0.5 * physicsScale * sizeFactor
    end
    pivotx, pivoty = _G.res.getSpritePivot("", sprite)
    createCircle(name, sprite, xpos, ypos, w, density, friction, restitution, controllable, z_order)
    if controllable then
      objects.world[name].damageFactors = damageFactors
      objects.world[name].useLegacyCollisionPath = useLegacyCollisionPath
    end
  end
  objects.world[name].definition = objectDefinition
  objects.world[name].damageSprite = sprite
  objects.world[name].controllable = controllable
  objects.world[name].strength = strength
  objects.world[name].defence = defence
  objects.world[name].material = blockDef.material
  objects.world[name].texture = blockDef.texture
  objects.world[name].levelGoal = levelGoal
  objects.world[name].spritePivotX = pivotx
  objects.world[name].spritePivotY = pivoty
  objects.world[name].forceX = forceX
  objects.world[name].forceY = forceY
  return name
end
function checkDirectories()
  if not checkDirectory(levelFolder) then
    createDirectory(levelFolder)
  end
  if not checkDirectory(levelFolder .. "temp/") then
    createDirectory(levelFolder .. "temp/")
  end
end
function updateCursorObjectAccordingToTheme()
  for k, v in _G.pairs(blockTable.blocks) do
    if v.group == currentGroup and v.groupIndex == currentGroupIndex and (v.theme == nil or v.theme == currentTheme) then
      objectToAdd = k
      selectedObjects = {}
    end
  end
end
function getObjectListBounds(objects)
  local w, h, px, py
  local minx = 1000000
  local maxx = -1000000
  local miny = 1000000
  local maxy = -1000000
  for k, v in _G.pairs(objects) do
    local width = v.width
    local height = v.height
    if width == nil then
      width = v.radius
      height = v.radius
    else
      width = width * 0.5
      height = height * 0.5
    end
    if minx > v.x - width then
      minx = v.x - width
    end
    if maxx < v.x + width then
      maxx = v.x + width
    end
    if miny > v.y - height then
      miny = v.y - height
    end
    if maxy < v.y + height then
      maxy = v.y + height
    end
  end
  w = maxx - minx
  h = maxy - miny
  px = (maxx + minx) * 0.5
  py = (maxy + miny) * 0.5
  return px, py, w, h
end
function roundNumber(number, decimalDigits)
  local t_shift = 10 ^ decimalDigits
  return _G.math.floor(number * t_shift + 0.5) / t_shift
end
function returnToEditor()
  setEditing(true)
  local name = "temp/" .. levelName .. ".temp.playtest"
  currentThemeNumber = levelSelectionPageNumber
  menuManager:changeRoot(nil)
  loadLevelInternal(levelFolder .. name)
  setGameMode(updateEditor)
  setPhysicsEnabled(false)
end
function goToMenu()
  eventManager:queueEvent({
    id = events.EID_PAUSE_CLICKED
  })
  hideAd()
  drawGame()
end
function addObjectToSelection(object, removeDuplicate)
  local objectFound = false
  for soi = 1, #selectedObjects do
    if selectedObjects[soi] == object then
      if removeDuplicate then
        _G.table.remove(selectedObjects, soi)
      end
      objectFound = true
      soi = #selectedObjects
    end
  end
  if not objectFound then
    _G.table.insert(selectedObjects, object)
  end
end
function postTotalHighScores()
  if postHighscores == true then
    local totalScore = 0
    local worldNumber = 0
    for i = 1, #g_episodes do
      local epTotalScore = 0
      for j = 1, #g_episodes[i].pages do
        local page = g_episodes[i].pages[j]
        local world = page.world_number
        local score = getWorldScore(i, j)
        epTotalScore = epTotalScore + score
        local lboardName = getLeaderboardNameForWorld(world)
        if lboardName and score > 0 then
          postLevelHighScore(lboardName, score, false)
        end
      end
      totalScore = totalScore + epTotalScore
      local lboardName = getLeaderboardNameForEpisode(i)
      if lboardName and epTotalScore > 0 then
        postLevelHighScore(lboardName, epTotalScore, false)
      end
    end
    local lboardName = getLeaderboardNameForTotalScore()
    if lboardName and totalScore > 0 then
      postLevelHighScore(lboardName, totalScore, false)
      print("<gc> posting total highscore " .. _G.string.format("%.0f", totalScore) .. "\n")
    end
  end
end
function postLevelHighScore(levelName, score, isLevelScore)
  if postHighscores == true and leaderboards ~= nil then
    leaderboardid = leaderboards[levelName]
    if leaderboardid ~= nil then
      print("Posting highscore for level " .. levelName .. " (score = " .. score .. " leaderboard = " .. leaderboardid .. ")\n")
      postHighscore(leaderboardid, score, isLevelScore)
    else
      print("Leaderboard id for level " .. levelName .. " not found!\n")
    end
  end
end
function returnToLevelSelection()
  stopIngameSounds()
  currentMenuPage = nil
  newMenuPage = nil
  setGameMode(function()
  end)
  eventManager:notify({
    id = events.EID_CHANGE_SCENE,
    target = "LEVEL_SELECTION_" .. currentThemeNumber
  })
end
function tweenLinear(currentTime, startValue, changeOfValue, duration)
  local c = changeOfValue
  local t = currentTime
  local d = duration
  local b = startValue
  return c * t / d + b
end
function tweenEaseCubicIn(currentTime, startValue, changeOfValue, duration)
  local c = changeOfValue
  local t = currentTime
  local d = duration
  local b = startValue
  t = t / d
  return c * t * t * t + b
end
function tweenEaseCubicOut(currentTime, startValue, changeOfValue, duration)
  local c = changeOfValue
  local t = currentTime
  local d = duration
  local b = startValue
  t = t / d - 1
  return c * (t * t * t + 1) + b
end
function tweenEaseCubicInOut(currentTime, startValue, changeOfValue, duration)
  local c = changeOfValue
  local t = currentTime
  local d = duration
  local b = startValue
  t = t / (d / 2)
  if t < 1 then
    return c / 2 * (t * t * t) + b
  end
  t = t - 2
  return c / 2 * (t * t * t + 2) + b
end
function tweenEaseBounceOut(currentTime, startValue, changeOfValue, duration)
  local c = changeOfValue
  local t = currentTime
  local d = duration
  local b = startValue
  t = t / d
  if t < 0.36363637 then
    return c * 7.5625 * t * t + b
  elseif t < 0.72727275 then
    t = t - 0.54545456
    return c * (7.5625 * t * t + 0.75) + b
  elseif t < 0.90909094 then
    t = t - 0.8181818
    return c * (7.5625 * t * t + 0.9375) + b
  else
    t = t - 0.95454544
    return c * (7.5625 * t * t + 0.984375) + b
  end
end
function updateLevelEnding(dt)
  if g_skip_to_level_end then
    return
  end
  if levelCompleted and not g_skip_wait_for_moving_objects then
    eagleDarkness = nil
    birdBuffTimer = birdBuffTimer - dt
    if birdBuffTimer < 0 then
      local nextBirdName = getNextBird(birdsLeftCounter)
      if nextBirdName ~= nil then
        birdsLeftCounter = birdsLeftCounter + 1
        if eagleBaitLaunched ~= true then
          scoreTable.birds.score = scoreTable.birds.score + birdsLeftScoreIncrement
        end
        local nbo = objects.world[nextBirdName]
        _G.res.playAudio(getAudioName(g_sound_birds), 1, false, 0)
        _G.table.insert(floatingScores, {
          x = nbo.x,
          y = nbo.y,
          sprite = getObjectDefinition(nextBirdName).spriteScore,
          score = birdsLeftScoreIncrement,
          time = 0,
          lifetime = 0.9,
          maxScale = floatingScoreScaling * 1,
          xs = 0
        })
        birdBuffTimer = 0.5
      else
        beforeLevelEnding(dt)
      end
      updateScore(dt)
      if quadClick == true then
        if deviceModel ~= "roku" then
          score = starTable[levelName].goldScore
          if eagleBaitLaunched == true then
            score = starTable[levelName].eagleScore
          end
        elseif quadClickCounter == 1 then
          score = 666
        elseif quadClickCounter == 2 then
          score = starTable[levelName].silverScore
        elseif quadClickCounter >= 3 then
          score = starTable[levelName].goldScore
        end
      end
    end
  elseif not g_skip_wait_for_moving_objects then
    levelCompleteTimer = levelCompleteTimer - dt
  elseif g_skip_wait_for_moving_objects then
  end
  if 0 >= levelCompleteTimer then
    if not isChallengeMode() then
      if devideModel == "iphone4" or deviceModel == "ipad3" then
        changeResolution = true
        wantedResoluion = "HALF"
      end
      eventManager:queueEvent({
        id = events.EID_LEVEL_ENDED,
        level = levelName,
        score = score,
        levelComplete = levelCompleted
      })
    else
      print("levelIndex = " .. g_currentChallengeProgress.levelIndex .. "\n")
      print("shots queue = " .. _G.tostring(#g_currentChallengeProgress.shotsQueue) .. "\n")
      print("total levels = " .. #g_currentChallenge.levels .. "\n")
      if g_currentChallenge.type == "BIRD_FLOCK" and (g_currentChallengeProgress.shotsQueue == nil or #g_currentChallengeProgress.shotsQueue == 0) and g_currentChallengeProgress.levelIndex < #g_currentChallenge.levels then
        levelCompleted = false
      end
      eventManager:notify({
        id = events.EID_CHALLENGE_LEVEL_ENDED,
        challenge = g_currentChallenge,
        progress = g_currentChallengeProgress,
        levelComplete = levelCompleted
      })
    end
  end
end
function skipToLevelEnd()
  g_skip_to_level_end = true
  levelCompleted = true
  birdsLeftCounter = currentBirdIndex
  if currentBirdName == nil or objects.world[currentBirdName].shot == true then
    birdsLeftCounter = birdsLeftCounter + 1
  end
  scoreTable.birds.score = 0
  local bird = getNextBird(birdsLeftCounter)
  if bird then
    while bird do
      birdsLeftCounter = birdsLeftCounter + 1
      if not eagleBaitLaunched then
        scoreTable.birds.score = scoreTable.birds.score + birdsLeftScoreIncrement
      end
      bird = getNextBird(birdsLeftCounter)
    end
  end
  updateScore(0)
  if devideModel == "iphone4" or deviceModel == "ipad3" then
    changeResolution = true
    wantedResoluion = "HALF"
  end
  eventManager:queueEvent({
    id = events.EID_LEVEL_ENDED,
    level = levelName,
    score = score,
    levelComplete = levelCompleted
  })
end
function beforeLevelEnding(dt)
  if showBoomerangBirdPopup == true and levelCompleteTimer > 0 and levelCompleteTimer - dt <= 0 then
    showBoomerangBirdPopup = false
    levelCompleteTimer = levelCompleteTimer + 3.6
    eventManager:notify({
      id = events.EID_BOOMERANG_BIRD_POPUP
    })
    if currentLevelNumberInTheme == 4 and currentWorldNumber == 6 then
      settingsWrapper:setBoomerangBirdAchieved()
    elseif currentLevelNumberInTheme == 5 and currentWorldNumber == 9 then
      settingsWrapper:setBoomerangBird2Achieved()
    end
    eventManager:notify({
      id = events.EID_BOOMERANG_BIRD_POPUP_SHOWN
    })
  else
    levelCompleteTimer = levelCompleteTimer - dt
  end
end
function initLevelComplete()
  eventManager:notify({
    id = events.EID_LEVEL_COMPLETE_INIT
  })
  rubberBandPos.x = levelStartPosition.x
  rubberBandPos.y = levelStartPosition.y
  rubberBandSpeed = 0
  rubberBandLength = 0
  allowResetToBirdCamera = false
  showTapIcon = false
  showTapTimer = 0
  levelCompleted = true
  birdsLeftCounter = currentBirdIndex
  if currentBirdName == nil or objects.world[currentBirdName].shot == true then
    birdsLeftCounter = birdsLeftCounter + 1
  end
  if g_special_game_mode then
    birdsLeftCounter = 0
  end
  if getNextBird(birdsLeftCounter) ~= nil then
    birdBuffTimer = 2.5
    if cameraFunction ~= launchCamera then
      birdBuffTimer = 3.5
      castleCameraTimer = 1
      cameraFunction = launchCamera
      animationScreen.x = screen.x
      animationScreen.y = screen.y
      animationWorldScale = worldScale
    end
  end
  _G.res.playAudio(getAudioName(g_sound_level_clear), 1, false)
  levelCompleteTimer = 1
  if eagleBaitLaunched then
    levelCompleteTimer = 2
  end
  if currentWorldNumber == 6 and currentLevelNumberInTheme == 4 and settingsWrapper:isBoomerangBirdAchieved() ~= true or currentWorldNumber == 9 and currentLevelNumberInTheme == 5 and settingsWrapper:isBoomerangBird2Achieved() ~= true then
    showBoomerangBirdPopup = true
  end
  g_level_completing = true
end
function isLevelEnding()
  return g_level_completing or false
end
function initLevelFailed(dt)
  levelFailedTimer = levelFailedTimer + dt
  if levelFailedTimer > 1.5 then
    levelCompleteTimer = 0.5
    _G.res.playAudio(getAudioName(g_sound_level_failed), 1, false)
  end
end
g_cursorPanning = deviceModel == "windows" or deviceModel == "osx"
function activateSlingshotCooldown()
  triggerTime = g_time
end
function isSlingshotAvailable()
  return triggerTime + 0.1 <= g_time
end
function isSlingshotVisible()
  local slingshot_world_x, _ = physicsToWorldTransform(slingShotBasePosition.x, 0)
  return slingshot_world_x > screen.left
end
if deviceModel ~= "roku" then
  function levelCompleteCheat()
    if keyPressed.LBUTTON then
      if quadClickTimer > 0 and cursor.x < 60 and cursor.y > screenHeight - 60 then
        quadClickCounter = quadClickCounter + 1
        quadClickTimer = 0.5
        if quadClickCounter >= 4 then
          quadClick = true
        end
      else
        quadClick = false
        quadClickTimer = 0.5
        quadClickCounter = 1
      end
    end
  end
else
  function levelCompleteCheat()
    if keyPressed.KEY_GAMING_A or keyPressed.A then
      if quadClickTimer > 0 then
        quadClickCounter = quadClickCounter + 1
        quadClickTimer = 0.5
        if quadClickCounter == 3 then
          quadClick = true
        end
      else
        quadClick = false
        quadClickTimer = 0.5
        quadClickCounter = 1
      end
    end
    if quadClickTimer <= 0 and 0 < quadClickCounter then
      quadClick = true
    end
  end
end
function updateGame(dt, time)
  if cheatsEnabled then
    if keyReleased["1"] and getNextBird(currentBirdIndex) then
      activateSuperSeed()
    end
    if keyReleased["2"] then
      activateKingSling()
    end
    if keyReleased["3"] then
      activateSlingScope()
    end
    if keyReleased["4"] then
      activateBirdQuake()
    end
    if touchcount == 6 then
      notifyEventManager("EID_MATTEL_TOY_ACTIVATED")
    end
  end
  if g_sling_scope then
    g_sling_scope_animation = g_sling_scope_animation + dt
  end
  if g_currentChallenge ~= nil and g_currentChallenge.type == "BIRD_FLOCK" then
    updateBirdFlockChallenge(dt, time)
  end
  if flyingBird ~= nil then
    local bDef = getObjectDefinition(flyingBird.name)
    if bDef ~= nil and bDef.sprite ~= nil and settingsWrapper:getTutorialsForItem(bDef.sprite) and settingsWrapper:getTutorialsForItem(bDef.sprite).showHelp then
      extraTutorialTimer = extraTutorialTimer + dt
    end
  end
  if cursor.wheelTriggered and cameraFunction == levelStartCamera then
    allowResetToBirdCamera = true
    cameraTargetObject = nil
    cameraFunction = doItAllCamera
  end
  cameraShakeX, cameraShakeY = 0, 0
  if cameraShake ~= nil and cameraShake ~= 0 then
    cameraShakeX = _G.math.floor(_G.math.random(-_G.math.abs(cameraShake), _G.math.abs(cameraShake)))
    cameraShakeY = _G.math.floor(_G.math.random(-_G.math.abs(cameraShake), _G.math.abs(cameraShake)))
  end
  levelTimeout = false
  if time ~= nil and lastScoreTime ~= 0 then
    if not lastScoreTimer then
      lastScoreTimer = time
    else
      lastScoreTimer = lastScoreTimer + dt
    end
    if oldScore ~= score then
      oldScore = score
      lastScoreTime = time
      lastScoreTimer = time
    end
    if lastScoreTimer - lastScoreTime >= 15 then
      levelTimeout = true
    end
  end
  oldCursorWorld.x = cursorWorld.x
  oldCursorWorld.y = cursorWorld.y
  cursorPhysics.x, cursorPhysics.y = screenToPhysicsTransform(cursor.x, cursor.y)
  cursorWorld.x, cursorWorld.y = screenToWorldTransform(cursor.x, cursor.y)
  rightSweep = false
  leftSweep = false
  quadClickTimer = quadClickTimer - dt
  if not startedFromEditor and not skipInput and (keyReleased.KEY_MENU or keyReleased.P and g_goldenEggKeyCount ~= 2 or keyReleased.ESCAPE or keyReleased.KEY_BACK) then
    goToMenu()
    return
  end
  if keyReleased.ESCAPE or keyReleased.KEY_BACK or startedFromEditor == true and touchcount == 3 then
    if startedFromEditor then
      _G.res.stopAudio(currentMusic)
      returnToEditor()
    end
    drawGame()
    return
  end
  if startedFromEditor ~= true then
    if keyPressed.LEFT then
      panToBirdCamera()
    end
    if keyPressed.RIGHT then
      panToCastleCamera()
    end
  elseif keyPressed.F5 or keyPressed.R then
    levelRestartedFrom = "keyboard command"
    setEditing(false)
    setPhysicsEnabled(false)
    local name = "temp/" .. levelName .. ".temp.playtest"
    checkDirectories()
    loadLevelInternal(levelFolder .. name)
    setGameMode(updateGame)
    if startedFromEditor ~= true then
      levelSelectionPageNumber = currentThemeNumber
    end
    currentThemeNumber = currentThemeIndex
  end
  if levelStartTimer == 0 then
    levelStartTimer = levelStartTimer + 0.01
    _G.res.playAudio(getAudioName(g_sound_level_start), 1, false)
    _G.res.stopAudio(currentMainMenuSong)
    currentBirdIndex = 0
    fillInNextBird = true
  end
  if currentMusic ~= nil and _G.res.isAudioPlaying(currentMusic) == false then
    _G.res.playAudio(currentMusic, 1, true, 7)
  end
  if keyPressed.MBUTTON then
    setWorldScale(1)
    worldScale = 1
  end
  if g_goldenEggKeys[g_goldenEggKeyCount + 1] and keyPressed[g_goldenEggKeys[g_goldenEggKeyCount + 1]] and currentWorldNumber == 1 and currentLevelNumberInTheme == 8 then
    local treasure_chest = objects.world.ExtraTreasureChest_1
    if treasure_chest ~= nil then
      g_goldenEggKeyCount = g_goldenEggKeyCount + 1
    end
  end
  if (doubleClick == true and not g_goldenEggKeyboardControl or g_goldenEggKeyCount == #g_goldenEggKeys and g_goldenEggKeyboardControl) and currentWorldNumber == 1 and currentLevelNumberInTheme == 8 then
    treasureChest = objects.world.ExtraTreasureChest_1
    if treasureChest ~= nil and (distance(cursorPhysics.x, cursorPhysics.y, treasureChest.x, treasureChest.y) < 2.5 or g_goldenEggKeyboardControl) then
      goldenEggAchieved("LevelGE_15")
      additionalPopupPageDelay = false
    end
  end
  if levelStartTimer < 1 or 6 < levelStartTimer then
    levelStartTimer = levelStartTimer + dt
  else
    setPhysicsEnabled(true)
    levelStartTimer = 10
  end
  if 0 < levelCompleteTimer then
    updateLevelEnding(dt)
  else
    if g_game_win_condition() or (keyPressed.C or quadClick == true) and cheatsEnabled then
      initLevelComplete()
    end
    if g_game_lose_condition() then
      initLevelFailed(dt)
    end
  end
  if g_powerups_active then
    skipInput = true
    if g_bird_quake then
      updateBirdQuake(dt)
    end
    if g_super_seed then
      updateSuperSeed(dt)
    end
    if g_king_sling then
      updateKingSling(dt)
    end
    if g_sling_scope_activation then
      updateSlingScope(dt)
    end
  end
  if cameraFunction == cinematicCamera then
    skipInput = true
  end
  gameTimer = gameTimer + dt
  if tapStarted and not skipInput then
    tapTimer = tapTimer + dt
    if tapTimer > 0.25 then
      if tapCount == 1 and showTapIcon then
        returnToBirdCamera()
      end
      if tapCount == 2 and not g_disable_double_tap and not g_zooming_disabled then
        if cameraAnimationSliderTarget == 0 then
          currentZoomedScale = objects.birdCameraData[deviceModel].sx
        else
          currentZoomedScale = objects.castleCameraData[deviceModel].sx
        end
        maxZoomLevel = true
      end
      tapTimer = 0
      tapCount = 0
      tapStarted = false
    end
  end
  if objects.levelParticles ~= nil and g_levelParticlesEnabled then
    if objects.levelParticles.firstFrame == true then
      if objects.levelParticles.startAtGroundLevel then
        _G.particles.addLevelParticles(objects.levelParticles.particles, objects.levelParticles.settingsFrame.amount * 15, objects.levelParticles.x, objects.levelParticles.y / 3, objects.levelParticles.width, 0, 0, alse)
      else
        _G.particles.addLevelParticles(objects.levelParticles.particles, objects.levelParticles.settingsFrame.amount * 15, objects.levelParticles.x, objects.levelParticles.y / 3, objects.levelParticles.width, objects.levelParticles.y, 0, false)
      end
      objects.levelParticles.firstFrame = false
    else
      levelParticlesTimer = levelParticlesTimer + dt
      if levelParticlesTimer > 1 / objects.levelParticles.settingsFrame.amount and isPhysicsEnabled() then
        levelParticlesTimer = 0
        _G.particles.addLevelParticles(objects.levelParticles.particles, 1, objects.levelParticles.x, objects.levelParticles.y, objects.levelParticles.width, 0, 0, false)
      end
    end
  end
  if g_cursorPanning and not g_usingGestureControls then
    if cursor.x < screenWidth * 0.01 and 0 < cameraAnimationSlider then
      panToBirdCamera()
    elseif cursor.x > screenWidth * 0.99 and 1 > cameraAnimationSlider then
      panToCastleCamera()
    end
  end
  if g_extra_game_update then
    g_extra_game_update(dt, time)
  end
  local bird_specialty_activated = false
  if not levelCompleted and keyPressed.LBUTTON and not skipInput and (not g_skip_trigger_specialty or g_usingGestureControls) and flyingBird ~= nil and birdSpecialtyAvailable and time ~= g_eagleButtonClickTime then
    triggerBirdSpecialty(dt)
    bird_specialty_activated = true
    g_touch_released_after_specialty = false
  end
  if not g_usingGestureControls and keyReleased.LBUTTON or g_usingGestureControls and touchcount == 0 then
    g_touch_released_after_specialty = true
  end
  if keyPressed.LBUTTON and not levelCompleted and not bird_specialty_activated and not g_usingGestureControls and skipInput ~= true then
    inGamePressed = true
    draggingStartPosPhysics.x = cursorPhysics.x
    draggingStartPosPhysics.y = cursorPhysics.y
    draggingStartPosScreen.x = cursor.x
    draggingStartPosScreen.y = cursor.y
    oldCursor.x = cursor.x
    oldCursor.y = cursor.y
    if tapStarted == false then
      tapPosition.x = cursor.x
      tapPosition.y = cursor.y
      tapStarted = true
      tapTimer = 0
    end
    dragStarted = true
    dragCursorTable = {}
    dragCursorIndex = 1
    dragCursorTable[dragCursorIndex] = {
      dx = 0,
      dy = 0,
      dt = dt
    }
    tapPosWorld.x = cursorWorld.x
    tapPosWorld.y = cursorWorld.y
    if touchcount == 1 and not g_disable_slingshot and currentBirdName ~= nil then
      local obj = objects.world[currentBirdName]
      if g_deltaBasedSlingshot then
        if isSlingshotAvailable() then
          returnToBirdCamera()
        end
      elseif distance(obj.x, obj.y, cursorPhysics.x, cursorPhysics.y) < shootRange / worldScale * screenWidth / 480 then
        selectedBird = obj
      end
    end
  end
  local zoom_done = true
  if g_usingGestureControls and multitouchZoom and multitouchZoom.zoomCoolingTime > -1 then
    zoom_done = false
    multitouchZoom.zoomCoolingTime = multitouchZoom.zoomCoolingTime + dt
    if multitouchZoom.zoomCoolingTime > 0.5 then
      multitouchZoom.zoomCoolingTime = -1
      zoom_done = true
    end
  end
  if g_usingGestureControls and not skipInput then
    if touchcount == 1 and not dragStarted then
      inGamePressed = true
      local _, touch = _G.next(touches)
      tapPosWorld.x, tapPosWorld.y = screenToWorldTransform(touch.x, touch.y)
    end
    if touchcount == 1 and not levelCompleted and not bird_specialty_activated and not dragStarted and currentBirdName ~= nil and zoom_done and g_touch_released_after_specialty and not birdSpecialtyAvailable and not g_disable_slingshot then
      dragStarted = true
      dragCursorTable = {}
      dragCursorIndex = 1
      dragCursorTable[dragCursorIndex] = {
        dx = 0,
        dy = 0,
        dt = dt
      }
      inGamePressed = true
      local index, touch = _G.next(touches)
      oldCursor.x = touch.x
      oldCursor.y = touch.y
      touch_start_x = touch.x
      touch_start_y = touch.y
      touch_old_x = touch.x
      touch_old_y = touch.y
      local obj = objects.world[currentBirdName]
      draggingStartPosPhysics.x = obj.x
      draggingStartPosPhysics.y = obj.y
      selectedBird = obj
      returnToBirdCamera()
    end
    if g_usingGestureControls and multitouchSweep and multitouchSweep.isSweeping and multitouchSweep.sweepAxis == "x" and not dragStarted then
      dragStarted = true
      dragCursorTable = {}
      dragCursorIndex = 1
      dragCursorTable[dragCursorIndex] = {
        dx = 0,
        dy = 0,
        dt = dt
      }
      inGamePressed = true
    end
  end
  if (not g_usingGestureControls and keyHold.LBUTTON or g_usingGestureControls and touchcount == 1) and not levelCompleted and inGamePressed and skipInput ~= true then
    if dragStarted == true then
      do
        local dx = 0
        local dy = 0
        if not g_usingGestureControls then
          dx = cursor.x - oldCursor.x
          dy = cursor.y - oldCursor.y
        else
          local index, touch = _G.next(touches)
          dx = touch.x - oldCursor.x
          dy = cursor.y - oldCursor.y
        end
        if dragCursorTable[dragCursorIndex].dt >= 0.017 then
          dragCursorIndex = dragCursorIndex + 1
          if dragCursorIndex > 5 then
            dragCursorIndex = 1
          end
          dragCursorTable[dragCursorIndex] = {
            dx = dx,
            dy = dy,
            dt = dt
          }
        else
          dragCursorTable[dragCursorIndex].dx = dragCursorTable[dragCursorIndex].dx + dx
          dragCursorTable[dragCursorIndex].dy = dragCursorTable[dragCursorIndex].dy + dy
          dragCursorTable[dragCursorIndex].dt = dragCursorTable[dragCursorIndex].dt + dt
        end
      end
      if selectedBird ~= nil then
        draggingStartPosPhysics.x = levelStartPosition.x
        draggingStartPosPhysics.y = levelStartPosition.y
        if birdReady == true and isSlingshotVisible() then
          local vecToRest
          if g_deltaBasedSlingshot then
            local dx, dy = cursor.x, cursor.y
            slingshotDeltaVector.x = slingshotDeltaVector.x - screenToPhysicsScale(dx) * g_slingshotSensitivity
            slingshotDeltaVector.y = slingshotDeltaVector.y - screenToPhysicsScale(dy) * g_slingshotSensitivity
            vecToRest = slingshotDeltaVector
            local maxlen, len = shootRange + 3.2, vLength(slingshotDeltaVector.x, slingshotDeltaVector.y)
            if maxlen < len then
              slingshotDeltaVector.x = slingshotDeltaVector.x * (maxlen / len)
              slingshotDeltaVector.y = slingshotDeltaVector.y * (maxlen / len)
            end
          elseif not g_usingGestureControls then
            vecToRest = {
              x = draggingStartPosPhysics.x - cursorPhysics.x,
              y = draggingStartPosPhysics.y - cursorPhysics.y
            }
          else
            local index, touch = _G.next(touches)
            vecToRest = {
              x = screenToPhysicsScale(touch_start_x - touch.x),
              y = screenToPhysicsScale(touch_start_y - touch.y)
            }
            touch_old_x = touch.x
            touch_old_y = touch.y
          end
          stretchRubberBand(vecToRest)
        end
      elseif g_deltaBasedSlingshot then
        if currentBirdName and isSlingshotVisible() and isSlingshotAvailable() then
          selectedBird = objects.world[currentBirdName]
          slingshotDeltaVector = {x = 0, y = 0}
          if g_isAccelerometerControl then
            enableMotion(true)
          end
        end
      elseif not g_usingGestureControls and not g_disableDragPanning then
        local dx = objects.castleCameraData[deviceModel].px - objects.birdCameraData[deviceModel].px
        if dx > 1 then
          local delta = (cursor.x - oldCursor.x) / (dx * worldScale)
          sweepSpeed = 0
          cameraAnimationSlider = cameraAnimationSlider - delta
          cameraFunction = doItAllCamera
        end
      end
    end
  elseif g_usingGestureControls and multitouchSweep and multitouchSweep.isSweeping and multitouchSweep.sweepAxis == "x" and dragStarted and not skipInput then
    local dx = objects.castleCameraData[deviceModel].px - objects.birdCameraData[deviceModel].px
    if dx > 1 then
      local delta = multitouchSweep.sweepOffsetX / (dx * worldScale)
      sweepSpeed = 0
      cameraAnimationSlider = cameraAnimationSlider - delta
      cameraFunction = doItAllCamera
    end
  end
  if (not g_usingGestureControls and (keyReleased.LBUTTON or not keyHold.LBUTTON) or g_usingGestureControls and touchcount == 0) and skipInput ~= true then
    if dragStarted then
      dragStarted = false
      if selectedBird ~= nil and not levelCompleted then
        if isChallengeMode() and g_currentChallenge.type == "BIRD_FLOCK" and g_currentChallengeProgress ~= nil then
          _G.table.remove(g_currentChallengeProgress.shotsQueue, 1)
        end
        local distToRest, vecToRest
        if g_deltaBasedSlingshot then
          vecToRest = slingshotDeltaVector
          distToRest = vLength(vecToRest.x, vecToRest.y)
          if g_isAccelerometerControl then
            enableMotion(false)
          end
        elseif not g_usingGestureControls then
          distToRest = distance(draggingStartPosPhysics.x, draggingStartPosPhysics.y, cursorPhysics.x, cursorPhysics.y)
          vecToRest = {
            x = draggingStartPosPhysics.x - cursorPhysics.x,
            y = draggingStartPosPhysics.y - cursorPhysics.y
          }
        else
          local index, touch = _G.next(touches)
          distToRest = screenToPhysicsScale(distance(touch_start_x, touch_start_y, touch_old_x, touch_old_y))
          vecToRest = {
            x = screenToPhysicsScale(touch_start_x - touch_old_x),
            y = screenToPhysicsScale(touch_start_y - touch_old_y)
          }
        end
        if distToRest > g_restDistance then
          if eagleBaitLaunched ~= true and not g_special_game_mode and 0 > vecToRest.x then
            settingsWrapper:incrementBackwardsBirdCount()
          end
          settingsWrapper:incrementBirdsShot()
          eventManager:notify({
            id = events.EID_BIRD_SHOT,
            birdsShooted = settingsWrapper:getBirdsShot(),
            backwardsBirdCount = settingsWrapper:getBackwardsBirdCount()
          })
          local distFactor = rubberBandLength / shootMaxLength
          if distFactor < 0 then
            distFactor = 0
          end
          if distFactor > 1 then
            distFactor = 1
          end
          local force = -defaultForce * physicsScale * selectedBird.mass * g_slingshot_power
          setPosition(selectedBird.name, rubberBandPos.x, rubberBandPos.y)
          setVelocity(selectedBird.name, 0, 0)
          applyImpulse(selectedBird.name, vecToRest.x / distToRest * force * distFactor, vecToRest.y / distToRest * force * distFactor, selectedBird.x, selectedBird.y)
          if g_camera_follows_launched_bird then
            cameraTargetObject = selectedBird
          end
          flyingBird = selectedBird
          if g_slingshot_power > 1 then
            selectedBird.particleTimer = 0
            selectedBird.particleTimerLimit = 0.025
          end
          extraTutorialTimer = 0
          cameraFunction = doItAllCamera
          if g_camera_follows_launched_bird then
            if vecToRest.x > 0 then
              cameraAnimationSliderTarget = 1
            else
              cameraAnimationSliderTarget = 0
            end
          end
          animationScreen.x = screen.x
          animationScreen.y = screen.y
          animationWorldScale = worldScale
          animationWorldScale2 = worldScale
          selectedBird.shot = true
          selectedBird.hasCollided = false
          birdSpecialtyAvailable = true
          allowResetToBirdCamera = true
          allowTrajectoryClearing = true
          hasMovingObjectsAboveTolerance = true
          birdSelected = false
          birdReady = false
          birdFired = true
          showTapIcon = false
          birdsShot = birdsShot + 1
          cameraResetTimer = 0
          showTapTimer = 0
          nextBirdTimer = g_bird_reload_delay
          currentBirdName = nil
          if birdsShot == birdCount then
            lastScoreTime = time
            oldScore = score
            eventManager:notify({
              id = events.EID_ALL_BIRDS_SHOT
            })
          end
          otherBirds = {}
          birdTrajectory = {
            {},
            {},
            {}
          }
          flyingBird.sprite = getObjectDefinition(flyingBird.name).spriteFlying
          setSprite(flyingBird.name, flyingBird.sprite)
          if getObjectDefinition(selectedBird.name).launchSound ~= nil then
            _G.res.playAudio(getObjectDefinition(selectedBird.name).launchSound, 1, false)
            local kingsling_active = false
            for _, powerup in _G.pairs(g_powerups_used) do
              if powerup == "kingsling" then
                kingsling_active = true
              end
            end
            if kingsling_active then
              _G.res.playAudio("super_shot", 1, false)
            else
              _G.res.playAudio(getAudioName("bird_shot"), 1, false)
            end
            g_scope_sound_ready = true
          end
          selectedBird = nil
        else
          cancelBirdDrag()
        end
      elseif not g_disableDragPanning then
        local i = 1
        local dxSum = 0
        local dtSum = 0
        local speed = 0
        while i <= #dragCursorTable do
          dtSum = dtSum + dragCursorTable[i].dt
          dxSum = dxSum + dragCursorTable[i].dx
          i = i + 1
        end
        speed = dxSum / dtSum
        dragCursorTable = {}
        local cond
        if not g_usingGestureControls then
          cond = touchcount == 1 and distance(draggingStartPosScreen.x, draggingStartPosScreen.y, cursor.x, cursor.y) > screenWidth * 0.1 or _G.math.abs(speed) > 200
        else
          cond = multitouchSweep.sweepAxis == "x" and multitouchSweep.sweepSpeed and _G.math.abs(multitouchSweep.sweepSpeed) > 200
          if cond then
            speed = multitouchSweep.sweepSpeed * 0.25
          end
        end
        if cond then
          sweepSpeed = speed
          if _G.math.abs(sweepSpeed) > 0 then
            if not g_usingGestureControls then
              if _G.math.abs(draggingStartPosScreen.x - cursor.x) > _G.math.abs(draggingStartPosScreen.y - cursor.y) then
                if draggingStartPosScreen.x - cursor.x > 0 then
                  leftSweep = true
                else
                  rightSweep = true
                end
              end
            elseif multitouchSweep.sweepSpeed < 0 then
              leftSweep = true
            else
              rightSweep = true
            end
            if _G.math.abs(sweepSpeed) < 200 then
              sweepSpeed = sweepSpeed / _G.math.abs(sweepSpeed) * 200
            end
            if _G.math.abs(sweepSpeed) > 5000 then
              sweepSpeed = sweepSpeed / _G.math.abs(sweepSpeed) * 5000
            end
          end
        else
          sweepSpeed = 0
        end
      end
      if not g_usingGestureControls and not g_disableDragPanning then
        if leftSweep == true and sweepSpeed < 0 then
          cameraFunction = doItAllCamera
          cameraAnimationSliderTarget = 1
          if cameraAnimationSlider < 0 then
            cameraAnimationSlider = 0
          end
          doubleClickTimer = 0
        end
        if rightSweep == true and sweepSpeed > 0 then
          animationScreen.x = screen.x
          animationScreen.y = screen.y
          animationWorldScale = worldScale
          cameraFunction = doItAllCamera
          cameraAnimationSliderTarget = 0
          if cameraAnimationSlider > 1 then
            cameraAnimationSlider = 1
          end
          allowResetToBirdCamera = false
          cameraTargetObject = nil
          doubleClickTimer = 0
          showTapIcon = false
          showTapTimer = 0
        end
      end
      if tapStarted and vLength(cursor.x - tapPosition.x, cursor.y - tapPosition.y) < tapRadius then
        tapCount = tapCount + 1
        tapTimer = 0
      end
    end
  elseif g_usingGestureControls and touchcount > 1 and dragStarted then
    cancelBirdDrag()
  end
  if cheatsEnabled == true then
    levelCompleteCheat()
  end
  if allowResetToBirdCamera == true and hasMovingObjectsAboveTolerance == false and hasMovingObjects == false and levelCompleted == false and birdSpecialtyAvailable == false and (not isChallengeMode() or #g_currentChallengeProgress.shotsQueue > 0) then
    if cameraResetTimer <= 0 then
      cameraResetTimer = 0.5
    end
    cameraResetTimer = cameraResetTimer - dt
    if cameraResetTimer <= 0 then
      returnToBirdCamera()
    end
  end
  if showTapTimer <= 0 and cameraAnimationSliderTarget == 1 and birdSpecialtyAvailable == false and cameraTargetObject == nil then
    showTapTimer = 0.5
  end
  if cameraAnimationSliderTarget == 0 then
    showTapTimer = 0
    showTapIcon = false
  end
  if showTapTimer > 0 then
    showTapTimer = showTapTimer - dt
    if showTapTimer <= 0 then
      showTapIcon = true
    end
  end
  g_reload_bird(dt)
  local recordTrajectory = false
  if flyingBird ~= nil then
    if flyingBird.recordTrajectory ~= false then
      recordTrajectory = true
      local lx, ly = physicsToWorldTransform(flyingBird.x, flyingBird.y)
      local bt = birdTrajectory[1]
      if #bt < 1 or vLengthsq(lx - bt[#bt].x, ly - bt[#bt].y) > 400 then
        _G.table.insert(bt, {x = lx, y = ly})
        addToTrajectory(1, lx, ly)
      end
    end
    local def = getObjectDefinition(flyingBird.name)
    if eagleBaitLaunched ~= true and not g_special_game_mode and def.specialty ~= "GRENADE" then
      if previousSpaceInvaderY == nil then
        previousSpaceInvaderY = 0
      end
      if previousSpaceInvaderY > -125 and flyingBird.y <= -125 then
        eventManager:notify({
          id = events.EID_SPACE_INVANDER
        })
      end
      previousSpaceInvaderY = flyingBird.y
    end
  end
  if otherBirds ~= nil then
    for i = 1, 2 do
      local obj = objects.world[otherBirds[i]]
      if obj ~= nil and obj.recordTrajectory ~= false then
        recordTrajectory = true
        local lx, ly = physicsToWorldTransform(obj.x, obj.y)
        local bt = birdTrajectory[i + 1]
        if #bt < 1 or vLengthsq(lx - bt[#bt].x, ly - bt[#bt].y) > 400 then
          _G.table.insert(bt, {x = lx, y = ly})
          addToTrajectory(i + 1, lx, ly)
        end
      end
    end
  end
  if recordTrajectory == false and allowTrajectoryClearing == true then
    startNewTrajectory()
    allowTrajectoryClearing = false
  end
  if birdReady == true and currentBirdName ~= nil then
    setPosition(currentBirdName, rubberBandPos.x, rubberBandPos.y)
    setVelocity(currentBirdName, 0, 0)
  end
  if birdFired then
    local rubberBandDtLeft = dt
    local rubberBandDt
    while rubberBandDtLeft > 0 do
      if rubberBandDtLeft < 0.05 then
        rubberBandDt = rubberBandDtLeft
      else
        rubberBandDt = 0.05
      end
      rubberBandDtLeft = rubberBandDtLeft - rubberBandDt
      local distToRest = distance(levelStartPosition.x, levelStartPosition.y, rubberBandPos.x, rubberBandPos.y)
      local vecToRest = {
        x = levelStartPosition.x - rubberBandPos.x,
        y = levelStartPosition.y - rubberBandPos.y
      }
      rubberBandAngle = _G.math.atan2(vecToRest.y, vecToRest.x)
      rubberBandLength = distToRest
      rubberBandSpeed = rubberBandSpeed + dampedSpring(springConstant, springDampening, distToRest, rubberBandSpeed) * 0.05 * physicsScale
      if distToRest > 0 then
        rubberBandPos.x = rubberBandPos.x + vecToRest.x / distToRest * rubberBandSpeed * rubberBandDt
        rubberBandPos.y = rubberBandPos.y + vecToRest.y / distToRest * rubberBandSpeed * rubberBandDt
        rubberBandLength = distance(levelStartPosition.x, levelStartPosition.y, rubberBandPos.x, rubberBandPos.y)
      end
    end
  end
  for i = #flyingGrenades, 1, -1 do
    if flyingGrenades[i].explode == true then
      local flyingGrenade = flyingGrenades[i].name
      local grenadeDef = getObjectDefinition(flyingGrenade)
      addParticles(flyingGrenade, grenadeDef.particles, 6, true, false)
      makeExplosion(objects.world[flyingGrenade], grenadeDef, getAudioName("special_explosion"))
      addParticles(flyingGrenade, grenadeDef.particles, 5, true, false)
      if cameraTargetObject ~= nil and cameraTargetObject.name == flyingGrenades[i].name then
        cameraTargetObject = nil
      end
      removeObject(flyingGrenade)
      objects.world[flyingGrenade] = nil
      _G.table.remove(flyingGrenades, i)
    end
  end
  if eagleTimer ~= nil then
    eagleTimer = eagleTimer - dt
  end
  if eagleDarkness ~= nil then
    eagleDarkness = eagleDarkness - dt * 0.4
    eagleDarkness = _G.math.max(_G.math.min(eagleDarkness, 0.5), 0)
  end
  for k, v in _G.pairs(objects.world) do
    if isPhysicsEnabled() then
      local bDef = getObjectDefinition(v.name)
      if bDef.forceX ~= nil and bDef.forceY ~= nil then
        applyForce(v.name, bDef.forceX * v.mass, bDef.forceY * v.mass, v.x, v.y)
      elseif v.forceX ~= nil and v.forceY ~= nil then
        applyForce(v.name, v.forceX * v.mass, v.forceY * v.mass, v.x, v.y)
      end
    end
    if v.bombTimer ~= nil then
      v.bombTimer = v.bombTimer - dt
      if v.bombTimer < 0 then
        makeExplosion(v, getObjectDefinition(k), getAudioName("special_explosion"))
        removeBird(v)
      elseif v.bombTimer < 0.5 then
        v.damageSprite = getObjectDefinition(k).spriteSpecial3
        setSprite(v.name, v.damageSprite)
      elseif v.bombTimer < 1 then
        v.damageSprite = getObjectDefinition(k).spriteSpecial2
        setSprite(v.name, v.damageSprite)
      end
    elseif v.globeTimer ~= nil then
      v.globeTimer = v.globeTimer - dt
      if v.globeTimer < 0 and globeExplodeDone then
        if not v.hasCollided then
          local lx, ly = physicsToWorldTransform(v.x, v.y)
          addPuffToTrajectory(1, lx, ly)
        end
        _G.res.playAudio(getAudioName(blockTable.blocks[v.definition].specialSound), 1, false)
        local name = "a" .. v.name .. "a"
        local def = getObjectDefinition(k)
        createCircle(name, def.sprite, v.x, v.y, def.radius * (v.powerup_scale or 1), def.density, def.friction, def.restitution, v.controllable, v.z_order)
        objects.world[name].definition = v.definition
        objects.world[name].controllable = def.controllable
        objects.world[name].strength = def.strength
        objects.world[name].defence = def.defence
        objects.world[name].material = def.material
        objects.world[name].levelGoal = def.levelGoal
        objects.world[name].damageFactors = def.damageFactors
        local xp, yp = _G.res.getSpritePivot("", def.sprite)
        objects.world[name].spritePivotX = xp
        objects.world[name].spritePivotY = yp
        objects.world[name].damageSprite = def.damageSprite
        objects.world[name].useLegacyCollisionPath = def.useLegacyCollisionPath
        objects.world[name].shot = true
        objects.world[name].finalGlobe = true
        objects.world[name].xVel = v.xVel
        objects.world[name].yVel = v.yVel
        objects.world[name].hasCollided = v.hasCollided
        objects.world[name].powerup_scale = v.powerup_scale
        objects.world[name].scale = v.powerup_scale or 1
        objects.world[name].pufferLifeTimeTimer = 4
        setRotation(name, v.angle)
        setVelocity(name, v.xVel, v.yVel)
        setObjectParameter(name, 5, v.powerup_scale or 1)
        setObjectParameter(name, 6, 1)
        birds[name] = objects.world[name]
        removeBird(v, true)
        v = objects.world[name]
        objects.world[v.name].sprite = def.sprite
        setSprite(v.name, objects.world[v.name].sprite)
        v.sprite = def.sprite
        cameraTargetObject = v
        globeExplodeDone = nil
      elseif dt >= v.globeTimer then
        local name = v.name .. "a"
        makeExplosion(v, getObjectDefinition(k), nil)
        local def = blockTable.blocks[v.definition]
        local def_name = v.definition
        if def.puffedDefinition then
          def_name = def.puffedDefinition
          def = blockTable.blocks[def.puffedDefinition]
        end
        createCircle(name, def.sprite, v.x, v.y, def.radius * (v.powerup_scale or 1), def.density, def.friction, def.restitution, v.controllable, v.z_order)
        objects.world[name].definition = def_name
        objects.world[name].controllable = def.controllable
        objects.world[name].strength = def.strength
        objects.world[name].defence = def.defence
        objects.world[name].material = def.material
        objects.world[name].levelGoal = def.levelGoal
        objects.world[name].damageFactors = def.damageFactors
        local xp, yp = _G.res.getSpritePivot("", def.sprite)
        objects.world[name].spritePivotX = xp
        objects.world[name].spritePivotY = yp
        objects.world[name].damageSprite = def.damageSprite
        objects.world[name].useLegacyCollisionPath = def.useLegacyCollisionPath
        objects.world[name].shot = true
        objects.world[name].xVel = v.xVel
        objects.world[name].yVel = v.yVel
        objects.world[name].hasCollided = v.hasCollided
        objects.world[name].globeTimer = v.globeTimer
        objects.world[name].powerup_scale = v.powerup_scale
        objects.world[name].scale = v.powerup_scale or 1
        setRotation(name, v.angle)
        setVelocity(name, v.xVel, v.yVel)
        setObjectParameter(name, 5, 0.5 * (v.powerup_scale or 1))
        setObjectParameter(name, 6, 1)
        birds[name] = objects.world[name]
        removeBird(v, true)
        v = objects.world[name]
        objects.world[v.name].sprite = def.sprite
        setSprite(v.name, objects.world[v.name].sprite)
        v.sprite = def.sprite
        cameraTargetObject = v
        globeExplodeDone = true
      end
    elseif v.isGlobeDeath == true then
      if v.deathTimer > 0 then
        v.deathTimer = v.deathTimer - dt
        v.directionChangeTimer = v.directionChangeTimer - dt
        if v.directionChangeTimer <= 0 then
          v.directionChangeTimer = 0.05
          v.xVelChange = _G.math.random(-50, 50)
          v.yVelChange = _G.math.random(-50, 50)
        end
        v.scale = v.deathTimer / v.deathTimerFull * (v.powerup_scale or 1)
        v.updateCount = v.updateCount + 1
        setObjectParameter(v.name, 5, v.scale)
        if v.updateCount % 3 == 0 then
          local name = v.name .. "a"
          local def = getObjectDefinition(k)
          createCircle(name, def.sprite, v.x, v.y, def.radius * v.scale, 1.0E-6, 0, def.restitution, v.controllable, v.z_order)
          objects.world[name].definition = v.definition
          objects.world[name].controllable = def.controllable
          objects.world[name].strength = def.strength
          objects.world[name].defence = def.defence
          objects.world[name].material = def.material
          objects.world[name].levelGoal = def.levelGoal
          objects.world[name].damageFactors = def.damageFactors
          local xp, yp = _G.res.getSpritePivot("", def.sprite)
          objects.world[name].spritePivotX = xp
          objects.world[name].spritePivotY = yp
          objects.world[name].damageSprite = def.damageSprite
          objects.world[name].useLegacyCollisionPath = def.useLegacyCollisionPath
          objects.world[name].shot = true
          objects.world[name].isGlobeDeath = true
          objects.world[name].updateCount = v.updateCount
          objects.world[name].deathTimerFull = v.deathTimerFull
          objects.world[name].deathTimer = v.deathTimer
          objects.world[name].scale = v.deathTimer / v.deathTimerFull * (v.powerup_scale or 1)
          objects.world[name].directionChangeTimer = v.directionChangeTimer
          objects.world[name].xVelChange = v.xVelChange
          objects.world[name].yVelChange = v.yVelChange
          objects.world[name].xVel = v.xVel + v.xVelChange
          objects.world[name].yVel = v.yVel + v.yVelChange
          objects.world[name].powerup_scale = v.powerup_scale
          setRotation(name, _G.math.atan2(-objects.world[name].xVel, objects.world[name].yVel) - _G.math.pi / 2)
          setVelocity(name, objects.world[name].xVel, objects.world[name].yVel)
          setObjectParameter(name, 5, v.scale)
          setObjectParameter(name, 6, 1)
          birds[name] = objects.world[name]
          removeBird(v, true, 1)
        end
      else
        allowResetToBirdCamera = true
        removeBird(v)
      end
    elseif v.pufferLifeTimeTimer ~= nil then
      v.pufferLifeTimeTimer = v.pufferLifeTimeTimer - dt
      if v.pufferLifeTimeTimer < 0 then
        removeBird(v)
      end
    elseif v.isEagleBait == true and eagleTimer ~= nil then
      if eagleTimer < 6.2 and eagleMoving == true then
        birdSpecialtyAvailable = false
        eagleMoving = false
        createMightyEagle(v.x, v.y)
      end
    elseif v.isMightyEagle then
      eagleHeight = levelStartPosition.y - v.y
      if objects.world.ground.y - v.y < 0 then
        v.lowerThanGround = true
      end
      eagleHeight = _G.math.max(_G.math.min(eagleHeight, 50), 0)
      local speed = 10000
      v.particleTimer = v.particleTimer + dt
      local particleAmount = _G.math.floor(v.particleTimer / v.particleTimerLimit)
      if particleAmount > 0 then
        v.particleTimer = _G.math.fmod(v.particleTimer, v.particleTimerLimit)
        addParticles(v.name, "mightyEagleParticles", particleAmount, false, false)
      end
      if v.hitGround ~= true then
        local angle = _G.math.atan2(v.initVelY, v.initVelX)
        setVelocity(v.name, v.initVelX * speed, v.initVelY * speed)
        setRotation(v.name, angle)
      elseif v.hitGround == true then
        setVelocity(v.name, v.initVelX * speed, -v.initVelY * speed)
        setAngularVelocity(v.name, _G.math.pi * 4)
      end
    elseif v.superseed_timer then
      v.superseed_timer = v.superseed_timer + dt
      local def = getObjectDefinition(v.name)
      local new_bird = superSeedResizeBird(v.name, v, def)
    elseif v.controllable and v.shot == true then
      if not v.hasCollided and g_slingshot_power > 1 and v.particleTimer then
        v.particleTimer = v.particleTimer + dt
        local particleAmount = _G.math.floor(v.particleTimer / v.particleTimerLimit)
        if particleAmount > 0 then
          v.particleTimer = _G.math.fmod(v.particleTimer, v.particleTimerLimit)
          local x, y = physicsToWorldTransform(v.x, v.y)
          local r = (v.radius or 0) * 2
          local w, h = physicsToWorldTransform(r, r)
          _G.particles.addParticles("superSlingTrail", particleAmount, x, y, w, h, getAngle(v.name), false, false)
        end
      end
      if v.isReadyForRemoveTimer ~= nil and vLengthsq(v.xVel, v.yVel) < g_bird_remove_velocity_treshold then
        v.isReadyForRemoveTimer = v.isReadyForRemoveTimer - dt
      else
        v.isReadyForRemoveTimer = g_bird_remove_time
      end
      if v.isReadyForRemoveTimer < 0 and cameraTargetObject ~= v then
        removeBird(v)
        v = nil
      end
    end
    if v ~= nil and v.frozen and objects.world[k] then
      if v.controllable then
        if v.isEagleBait == true then
          eagleX, eagleY = v.x, v.y
          if eagleTimer == nil then
            eagleTimer = 8.7
            eagleMoving = true
          end
        end
        if v.boomerangActive ~= true then
          removeBird(v)
        end
        if v.isMightyEagle and v.hitGround ~= true then
          cameraShake = 100
          _G.res.playAudio("mighty_eagle_thump", 1, false)
          for k2, v2 in _G.pairs(objects.world) do
            if v2 ~= nil and v2.strength ~= nil and v2.levelGoal then
              local force = -v2.mass * 15
              applyImpulse(v2.name, 0, force, v2.x, v2.y)
              v2.strength = 1.0E-5
              v2.defence = 0
            end
          end
          if objects.joints ~= nil then
            for k, v in _G.pairs(objects.joints) do
              destroyJoint(v.name)
            end
          end
          eagleTimer = 4
        end
      else
        removeObject(k)
        objects.world[k] = nil
        levelGoals[k] = nil
        if checkLevelGoalsDestroyed() then
          eventManager:notify({
            id = events.EID_LEVEL_GOALS_CLEARED
          })
          lastScoreTime = time
          oldScore = score
        end
      end
      v = nil
    end
  end
  if eagleTimer ~= nil then
    if eagleTimer < 6.2 and eagleMoving == true and eagleX ~= nil and eagleY ~= nil then
      birdSpecialtyAvailable = false
      eagleMoving = false
      createMightyEagle(eagleX, eagleY)
    elseif eagleTimer < 7.7 and eagleSoundPlayed ~= true then
      _G.res.playAudio("mighty_eagle_yell", 1, false)
      _G.res.playAudio("mighty_eagle_fly", 1, false)
      eagleSoundPlayed = true
    end
    if cameraShake ~= nil and cameraShake > 0 then
      cameraShake = _G.math.max(cameraShake - cameraShake * dt * 2.2, 0)
    end
    if eagleTimer < 0 then
      for k, v in _G.pairs(objects.world) do
        if v.strength ~= nil and v.levelGoal then
          v.strength = 0
          deadBlocks[k] = v
        end
      end
    end
    if destroyJoints then
      if objects.joints ~= nil then
        for k, v in _G.pairs(objects.joints) do
          destroyJoint(v.name)
        end
      end
      destroyJoints = nil
    end
  end
  if cameraFunction ~= nil then
    cameraFunction(dt)
  end
  for k, v in _G.pairs(birds) do
    bird = v
    local bDef = getObjectDefinition(bird.name)
    if bird.shot == true and bDef.specialty == "BOOMERANG" then
      if v.boomerangActive == true then
        if bird.prevAngle ~= nil and bird.prevAngle < -1 and bird.angle >= -1 then
          if bird.x < levelLeftEdge then
            vol = _G.math.max(1 - (levelLeftEdge - bird.x) / 100, 0)
          elseif bird.x > levelRightEdge then
            vol = _G.math.max(1 - (bird.x - levelRightEdge) / 100, 0)
          else
            vol = 1
          end
          _G.res.playAudio("boomerang_swish", vol, false)
        end
        bird.prevAngle = bird.angle
        if bird.xVel >= bird.boomerangMinXVel and bird.xVel <= bird.boomerangMaxXVel then
          applyForce(bird.name, bird.boomerangXForce, 0, bird.x, bird.y)
        end
        if bird.yVel > 5 then
          applyForce(bird.name, 0, bird.boomerangYForce, bird.x, bird.y)
        end
        bird.angularVelocity = bird.angularVelocity + dt * 20
        if bird.angularVelocity > 20 then
          bird.angularVelocity = 20
        end
        setAngularVelocity(bird.name, bird.angularVelocity)
      elseif bird == flyingBird and birdSpecialtyAvailable then
        applyForce(bird.name, 0, blockTable.blocks[bird.definition].flyVerticalForce, bird.x, bird.y)
        if bird.angularVelocity == nil then
          bird.angularVelocity = 0
        end
        bird.angularVelocity = bird.angularVelocity + dt * 15
        if bird.angularVelocity > 6.28 then
          bird.angularVelocity = 6.28
        end
        setAngularVelocity(bird.name, bird.angularVelocity)
      end
    elseif bird.shot == true and bird.definition == "BaitSardine" then
      if bird.angularVelocity == nil then
        bird.angularVelocity = 0
      end
      if bird.hasCollided ~= true then
        bird.angularVelocity = bird.angularVelocity + dt * 10
        if bird.angularVelocity > 20 then
          bird.angularVelocity = 20
        end
        setAngularVelocity(bird.name, bird.angularVelocity)
      end
    end
  end
  for k, v in _G.pairs(objects.joints) do
    if v.backAndForth then
      checkJointLimits(v.name)
    end
  end
  updateCharacterAnimations(dt)
  updateFloatingScores(dt)
  updateScore(dt)
  oldCursor.x = cursor.x
  oldCursor.y = cursor.y
  drawGame()
  if tempWorldScale ~= nil then
    print("tempWorldScale = nil\n")
    tempWorldScale = nil
  end
  skipInput = false
  g_skip_trigger_specialty = false
end
function cancelBirdDrag()
  if selectedBird then
    setPosition(selectedBird.name, levelStartPosition.x, levelStartPosition.y)
    selectedBird = nil
    rubberBandPos.x = levelStartPosition.x
    rubberBandPos.y = levelStartPosition.y
    rubberBandSpeed = 0
    rubberBandLength = 0
    if not _G.res.isAudioPlaying("laser_sight") then
      g_scope_sound_ready = true
    end
  end
end
function triggerBirdSpecialty(dt)
  birdSpecialtyAvailable = false
  local bDef = getObjectDefinition(flyingBird.name)
  birdSpecialty = bDef.specialty
  if birdSpecialty == "GLOBE" then
    settingsWrapper:setExtraTutorialShown(bDef.sprite)
    flyingBird.globeTimer = dt * 2
  end
  if birdSpecialty == "BOOST" then
    settingsWrapper:setExtraTutorialShown(bDef.sprite)
    local force = boostForce * physicsScale * flyingBird.mass
    local x, y = vNormalize(flyingBird.xVel, flyingBird.yVel)
    applyImpulse(flyingBird.name, -x * force, -y * force, flyingBird.x, flyingBird.y)
    addParticles(flyingBird.name, blockTable.blocks[flyingBird.definition].particles, 10, false, false)
    _G.res.playAudio(getAudioName(blockTable.blocks[flyingBird.definition].specialSound), 1, false)
    objects.world[flyingBird.name].sprite = bDef.spriteSpecial
    setSprite(flyingBird.name, objects.world[flyingBird.name].sprite)
    local lx, ly = physicsToWorldTransform(flyingBird.x, flyingBird.y)
    addPuffToTrajectory(1, lx, ly)
  end
  if birdSpecialty == "BOMB" then
    settingsWrapper:setExtraTutorialShown(bDef.sprite)
    makeExplosion(flyingBird, bDef, getAudioName(blockTable.blocks[flyingBird.definition].specialSound))
    removeBird(flyingBird)
  end
  if birdSpecialty == "SOUND" then
    _G.res.playAudio(getAudioName(blockTable.blocks[flyingBird.definition].specialSound), 1, false)
  end
  if birdSpecialty == "CLUSTER_BOMB" then
    settingsWrapper:setExtraTutorialShown(bDef.sprite)
    local lx, ly = physicsToWorldTransform(flyingBird.x, flyingBird.y)
    addPuffToTrajectory(1, lx, ly)
    local x, y = vNormalize(flyingBird.yVel, -flyingBird.xVel)
    local newName = flyingBird.name .. "a"
    createCircle(newName, flyingBird.sprite, flyingBird.x - x, flyingBird.y - y, flyingBird.radius, flyingBird.density, flyingBird.friction, flyingBird.restitution, flyingBird.controllable, flyingBird.z_order)
    objects.world[newName].definition = flyingBird.definition
    objects.world[newName].controllable = flyingBird.controllable
    objects.world[newName].strength = flyingBird.strength
    objects.world[newName].defence = flyingBird.defence
    objects.world[newName].material = flyingBird.material
    objects.world[newName].levelGoal = flyingBird.levelGoal
    objects.world[newName].damageFactors = flyingBird.damageFactors
    objects.world[newName].spritePivotX = flyingBird.spritePivotX
    objects.world[newName].spritePivotY = flyingBird.spritePivotY
    objects.world[newName].damageSprite = flyingBird.damageSprite
    objects.world[newName].useLegacyCollisionPath = flyingBird.useLegacyCollisionPath
    objects.world[newName].shot = true
    objects.world[newName].sleeping = false
    objects.world[newName].hasCollided = false
    objects.world[newName].parentName = flyingBird.name
    objects.world[newName].xVel = flyingBird.xVel - x * 7
    objects.world[newName].yVel = flyingBird.yVel - y * 7
    setSprite(newName, flyingBird.damageSprite)
    setRotation(newName, flyingBird.angle)
    setVelocity(newName, flyingBird.xVel - x * 7, flyingBird.yVel - y * 7)
    birds[newName] = objects.world[newName]
    if flyingBird.powerup_scale then
      setObjectParameter(newName, 5, flyingBird.powerup_scale)
      setObjectParameter(newName, 6, 1)
    end
    newName = flyingBird.name .. "b"
    createCircle(newName, flyingBird.sprite, flyingBird.x, flyingBird.y, flyingBird.radius, flyingBird.density, flyingBird.friction, flyingBird.restitution, flyingBird.controllable, flyingBird.z_order)
    objects.world[newName].definition = flyingBird.definition
    objects.world[newName].controllable = flyingBird.controllable
    objects.world[newName].strength = flyingBird.strength
    objects.world[newName].defence = flyingBird.defence
    objects.world[newName].material = flyingBird.material
    objects.world[newName].levelGoal = flyingBird.levelGoal
    objects.world[newName].damageFactors = flyingBird.damageFactors
    objects.world[newName].spritePivotX = flyingBird.spritePivotX
    objects.world[newName].spritePivotY = flyingBird.spritePivotY
    objects.world[newName].damageSprite = flyingBird.damageSprite
    objects.world[newName].useLegacyCollisionPath = flyingBird.useLegacyCollisionPath
    objects.world[newName].shot = true
    objects.world[newName].sleeping = false
    objects.world[newName].hasCollided = false
    objects.world[newName].parentName = flyingBird.name
    objects.world[newName].xVel = flyingBird.xVel
    objects.world[newName].yVel = flyingBird.yVel
    setSprite(newName, flyingBird.damageSprite)
    setRotation(newName, flyingBird.angle)
    setVelocity(newName, flyingBird.xVel, flyingBird.yVel)
    birds[newName] = objects.world[newName]
    if flyingBird.powerup_scale then
      setObjectParameter(newName, 5, flyingBird.powerup_scale)
      setObjectParameter(newName, 6, 1)
    end
    newName = flyingBird.name .. "c"
    createCircle(newName, flyingBird.sprite, flyingBird.x + x, flyingBird.y + y, flyingBird.radius, flyingBird.density, flyingBird.friction, flyingBird.restitution, flyingBird.controllable, flyingBird.z_order)
    objects.world[newName].definition = flyingBird.definition
    objects.world[newName].controllable = flyingBird.controllable
    objects.world[newName].strength = flyingBird.strength
    objects.world[newName].defence = flyingBird.defence
    objects.world[newName].material = flyingBird.material
    objects.world[newName].levelGoal = flyingBird.levelGoal
    objects.world[newName].damageFactors = flyingBird.damageFactors
    objects.world[newName].spritePivotX = flyingBird.spritePivotX
    objects.world[newName].spritePivotY = flyingBird.spritePivotY
    objects.world[newName].damageSprite = flyingBird.damageSprite
    objects.world[newName].useLegacyCollisionPath = flyingBird.useLegacyCollisionPath
    objects.world[newName].shot = true
    objects.world[newName].sleeping = false
    objects.world[newName].hasCollided = false
    objects.world[newName].parentName = flyingBird.name
    objects.world[newName].xVel = flyingBird.xVel + x * 7
    objects.world[newName].yVel = flyingBird.yVel + y * 7
    setSprite(newName, flyingBird.damageSprite)
    setRotation(newName, flyingBird.angle)
    setVelocity(newName, flyingBird.xVel + x * 7, flyingBird.yVel + y * 7)
    birds[newName] = objects.world[newName]
    if flyingBird.powerup_scale then
      setObjectParameter(newName, 5, flyingBird.powerup_scale)
      setObjectParameter(newName, 6, 1)
    end
    otherBirds = {
      flyingBird.name .. "a",
      flyingBird.name .. "b"
    }
    removeBird(flyingBird)
    flyingBird = objects.world[newName]
    cameraTargetObject = flyingBird
    _G.res.playAudio(blockTable.blocks[flyingBird.definition].specialSound, 1, false)
  end
  if birdSpecialty == "GRENADE" then
    settingsWrapper:setExtraTutorialShown(bDef.sprite)
    local x, y = vNormalize(flyingBird.yVel, -flyingBird.xVel)
    local newName = flyingBird.name .. "a"
    objects.world[flyingBird.name].sprite = bDef.spriteSpecial
    setSprite(flyingBird.name, objects.world[flyingBird.name].sprite)
    local grenade_def = blockTable.blocks[bDef.projectile]
    createCircle(newName, grenade_def.sprite, flyingBird.x, flyingBird.y + flyingBird.radius * 2, flyingBird.radius, flyingBird.density, flyingBird.friction, flyingBird.restitution, true, flyingBird.z_order)
    objects.world[newName].definition = bDef.projectile
    objects.world[newName].controllable = true
    objects.world[newName].strength = flyingBird.strength
    objects.world[newName].defence = flyingBird.defence
    objects.world[newName].material = flyingBird.material
    objects.world[newName].damageFactors = blockTable.blocks[objects.world[newName].definition].damageFactors
    objects.world[newName].useLegacyCollisionPath = flyingBird.useLegacyCollisionPath
    objects.world[newName].levelGoal = false
    local xp, yp = _G.res.getSpritePivot(grenade_def.sprite)
    objects.world[newName].spritePivotX = xp
    objects.world[newName].spritePivotY = yp
    objects.world[newName].damageSprite = grenade_def.sprite
    objects.world[newName].xVel = 0
    objects.world[newName].yVel = 100
    setSprite(newName, objects.world[newName].damageSprite)
    setRotation(newName, flyingBird.angle)
    setVelocity(newName, objects.world[newName].xVel, objects.world[newName].yVel)
    _G.table.insert(flyingGrenades, {name = newName, timer = 5})
    _G.res.playAudio(getAudioName(blockTable.blocks[flyingBird.definition].specialSound), 1, false)
    cameraTargetObject = objects.world[newName]
    applyImpulse(flyingBird.name, -0.04 * defaultForce * flyingBird.mass, 0.08 * defaultForce * flyingBird.mass, flyingBird.x - 0.5, flyingBird.y)
    local lx, ly = physicsToWorldTransform(flyingBird.x, flyingBird.y)
    addPuffToTrajectory(1, lx, ly)
  end
  if birdSpecialty == "BOOMERANG" then
    settingsWrapper:setExtraTutorialShown(bDef.sprite)
    flyingBird.boomerangActive = true
    if flyingBird.xVel ~= 0 then
      yForceCoeff = 2 - _G.math.min(_G.math.abs(flyingBird.yVel / flyingBird.xVel), 2)
    else
      yForceCoeff = 0
    end
    flyingBird.boomerangXForce = flyingBird.xVel * physicsScale * flyingBird.mass * blockTable.blocks[flyingBird.definition].boomerangHorizontalForce * g_slingshot_power
    flyingBird.boomerangYForce = yForceCoeff * physicsScale * flyingBird.mass * blockTable.blocks[flyingBird.definition].boomerangVerticalForce * g_slingshot_power
    flyingBird.boomerangMinXVel = -blockTable.blocks[flyingBird.definition].boomerangMaxHorizontalSpeed * g_slingshot_power
    flyingBird.boomerangMaxXVel = blockTable.blocks[flyingBird.definition].boomerangMaxHorizontalSpeed * g_slingshot_power
    objects.world[flyingBird.name].sprite = bDef.spriteSpecial
    setSprite(flyingBird.name, objects.world[flyingBird.name].sprite)
    _G.res.playAudio(getAudioName(blockTable.blocks[flyingBird.definition].specialSound), 1, false)
    local lx, ly = physicsToWorldTransform(flyingBird.x, flyingBird.y)
    addPuffToTrajectory(1, lx, ly)
  end
end
function updateBirdFlockChallenge(dt, time)
  g_challengeHudTimer = g_challengeHudTimer + dt
end
function closeMightyEaglePurchasePage()
  setPhysicsEnabled(false)
  drawGame()
end
function backToGameFromPopup()
  print("going to pause menu\n")
  popupPage = nil
  showPauseMenu()
  setPhysicsEnabled(false)
end
function goToMightyEagleDemoPageFromGame()
  settingsWrapper:setMightyEagleUpsellPageViewed()
  setPhysicsEnabled(false)
  function currentGameMode()
  end
  drawGame()
  setGameOn(false)
  eventManager:notify({
    id = events.EID_CHANGE_SCENE,
    target = IngameEaglePage:new()
  })
end
function goToMightyEaglePaymentPage(inGame)
  newPopupPage = mightyEaglePaymentPage
  if isEagleEnabled() ~= true then
    purchaseMightyEagle()
    if g_eagleClickedFrom == "MAIN_MENU" then
      menuManager:changeRoot(MainMenuEaglePurchasePage:new())
    elseif g_eagleClickedFrom == "INGAME" then
      eventManager:notify({
        id = events.EID_PUSH_FRAME,
        target = EaglePurchasePage:new({
          return_screen = menuManager:popFrame()
        })
      })
    elseif g_eagleClickedFrom == "LEVEL_FAILED" then
      eventManager:notify({
        id = events.EID_PUSH_FRAME,
        target = EaglePurchasePage:new({
          return_screen = menuManager:popFrame()
        })
      })
    end
  end
end
function resetMightyEagleFeature()
  settingsWrapper:resetMightyEagle()
  settingsWrapper:resetEaglesUsedIn()
  highscores = {}
end
function createMightyEagle(meX, meY)
  levelCompleteTimer = 0
  levelFailedTimer = -200
  eagleX, eagleY = nil, nil
  local newName = "MightyEagle_a"
  local blockDef = blockTable.blocks.MightyEagleBird
  createCircle(newName, blockDef.sprite, levelLimitMinX + 1, meY - (meX - levelLimitMinX + 1) / 2, blockDef.radius, blockDef.density, blockDef.friction, blockDef.restitution, true, blockDef.z_order)
  objects.world[newName].targetX = meX
  objects.world[newName].targetY = meY
  objects.world[newName].initVelX, objects.world[newName].initVelY = vNormalize(objects.world[newName].targetX - objects.world[newName].x, objects.world[newName].targetY - objects.world[newName].y)
  objects.world[newName].definition = "MightyEagleBird"
  objects.world[newName].controllable = blockDef.controllable
  objects.world[newName].strength = blockDef.strength
  objects.world[newName].defence = blockDef.defence
  objects.world[newName].material = blockDef.material
  objects.world[newName].damageFactors = blockDef.damageFactors
  objects.world[newName].useLegacyCollisionPath = blockDef.useLegacyCollisionPath
  objects.world[newName].levelGoal = false
  local xp, yp = _G.res.getSpritePivot("INGAME_BIRDS_2", blockDef.sprite)
  objects.world[newName].spritePivotX = xp
  objects.world[newName].spritePivotY = yp
  objects.world[newName].damageSprite = blockDef.sprite
  objects.world[newName].xVel = 0
  objects.world[newName].yVel = 0
  setSprite(newName, objects.world[newName].damageSprite)
  setRotation(newName, 0)
  setVelocity(newName, objects.world[newName].xVel, objects.world[newName].yVel)
  objects.world[newName].animTimer = 9999
  objects.world[newName].jumpTimer = 9999
  objects.world[newName].animOn = false
  objects.world[newName].isMightyEagle = true
  objects.world[newName].shot = true
  objects.world[newName].particleTimer = 0
  objects.world[newName].particleTimerLimit = 0.025
  objects.world[newName].recordTrajectory = false
  birds[newName] = objects.world[newName]
  birdsCounter = birdsCounter + 1
  currentZoomedScale = objects.castleCameraData[deviceModel].sx
  flyingBird = objects.world[newName]
  setMaxTranslation(5)
  _G.particles.setHardLimit(250)
  _G.particles.setSoftLimit(0, 0.2)
end
function removeBlocks()
  if objects.world == nil then
    return
  end
  for k, v in _G.pairs(deadBlocks) do
    if v ~= nil and v.strength ~= nil then
      local bDef = getObjectDefinition(k)
      local scoreToAdd = blockDestroyedScoreIncrement
      if bDef.destroyedScoreInc ~= nil then
        scoreToAdd = blockTable.blocks[v.definition].destroyedScoreInc
      end
      if v.levelGoal then
        scoreToAdd = pigletteDestroyedScoreIncrement
        _G.res.playAudio(getAudioName(blockTable.materials[bDef.material].damageSound), 1, false)
        _G.table.insert(floatingScores, {
          x = v.x,
          y = v.y,
          sprite = bDef.spriteScore,
          score = scoreToAdd,
          time = 0,
          lifetime = 0.9,
          maxScale = floatingScoreScaling * 1,
          xs = 0
        })
        if startedFromEditor ~= true then
          local anyPiglettesAlive = 0
          for k2, v2 in _G.pairs(levelGoals) do
            if v2.levelGoal then
              anyPiglettesAlive = anyPiglettesAlive + 1
            end
          end
          if anyPiglettesAlive == 1 then
            eventManager:notify({
              id = events.EID_LEVEL_GOALS_CLEARED
            })
            lastScoreTime = time
            oldScore = score
          end
        end
      elseif bDef.spriteScore ~= nil then
        _G.table.insert(floatingScores, {
          x = v.x,
          y = v.y,
          sprite = bDef.spriteScore,
          score = scoreToAdd,
          time = 0,
          lifetime = 0.9,
          maxScale = floatingScoreScaling * 1,
          xs = 0
        })
      else
        _G.table.insert(floatingScores, {
          x = v.x,
          y = v.y,
          text = "" .. scoreToAdd,
          score = scoreToAdd,
          time = 0,
          lifetime = 0.6,
          maxScale = floatingScoreScaling * (0.25 + scoreToAdd / 3000),
          xs = 0
        })
      end
      scoreTable.blocks.score = scoreTable.blocks.score + scoreToAdd
      local bDef = getObjectDefinition(k)
      local particle = bDef.particles
      if particle == nil then
        particle = blockTable.materials[v.material].particles
      end
      local destroySound = blockTable.materials[v.material].destroyedSound
      local particleAmount = 12
      local batAmount = _G.math.random(12, 20)
      if particle == "smokeBuff" then
        particleAmount = 1
      elseif particle == "batBuff" then
        particleAmount = batAmount
      elseif particle == "flameBuff" then
        particleAmount = 1
      end
      if bDef.specialty == "BOMB" then
        makeExplosion(deadBlocks[k], bDef, getAudioName("tnt_explodes"))
      end
      if destroySound ~= nil then
        _G.res.playAudio(getAudioName(destroySound), 0.7, false, 3)
      end
      updateDestroyedBlocksValues(v)
      if eagleBaitLaunched ~= true then
        if currentLevelNumberInTheme == 2 and currentWorldNumber == 2 and v.name == "ExtraBeachBall_1" then
          goldenEggAchieved("LevelGE_2")
        end
        if currentLevelNumberInTheme == 14 and currentWorldNumber == 6 and v.name == "StaticBalloon03_2" then
          goldenEggAchieved("LevelGE_6")
        end
        if currentLevelNumberInTheme == 7 and currentWorldNumber == 4 and v.name == "ExtraGoldenEgg_1" then
          goldenEggAchieved("LevelGE_5")
        end
        if currentLevelNumberInTheme == 19 and currentWorldNumber == 5 and v.name == "ExtraGoldenEgg_1" then
          goldenEggAchieved("LevelGE_3")
        end
        if currentLevelNumberInTheme == 15 and currentWorldNumber == 8 and v.name == "ExtraGoldenEgg_1" then
          goldenEggAchieved("LevelGE_8")
        end
        if currentLevelNumberInTheme == 14 and currentWorldNumber == 9 and v.name == "ExtraGoldenEgg_1" then
          goldenEggAchieved("LevelGE_9")
        end
        if currentLevelNumberInTheme == 3 and currentWorldNumber == 10 and v.name == "ExtraRubberDuck_1" then
          goldenEggAchieved("LevelGE_10")
        end
        if currentLevelNumberInTheme == 15 and currentWorldNumber == 11 and v.name == "ExtraGoldenEgg_1" then
          goldenEggAchieved("LevelGE_11")
        end
        if currentLevelNumberInTheme == 12 and currentWorldNumber == 12 and v.name == "ExtraHolyGrail_4" then
          goldenEggAchieved("LevelGE_16")
        end
        if currentLevelNumberInTheme == 10 and currentWorldNumber == 13 and v.name == "ExtraGoldenEgg_1" then
          goldenEggAchieved("LevelGE_17")
        end
        if currentLevelNumberInTheme == 4 and currentWorldNumber == 14 and v.name == "ExtraGoldenEgg_1" then
          goldenEggAchieved("LevelGE_18")
        end
        if currentLevelNumberInTheme == 12 and currentWorldNumber == 13 and v.name == "ExtraSuperBowl_2" then
          goldenEggAchieved("LevelGE_19")
        end
        if currentLevelNumberInTheme == 12 and currentWorldNumber == 15 and v.name == "ExtraGoldenEgg_1" then
          goldenEggAchieved("LevelGE_20")
        end
        if currentLevelNumberInTheme == 9 and currentWorldNumber == 16 and v.name == "ExtraGoldenEgg_1" then
          goldenEggAchieved("LevelGE_21")
        end
        if currentLevelNumberInTheme == 12 and currentWorldNumber == 17 and v.name == "ExtraTreasureChest_1" then
          goldenEggAchieved("LevelGE_23")
        end
        if currentLevelNumberInTheme == 6 and currentWorldNumber == 18 and v.name == "ExtraGoldenEgg_1" then
          goldenEggAchieved("LevelGE_24")
        end
        if currentLevelNumberInTheme == 15 and currentWorldNumber == 18 and v.name == "SPECIAL_CAKE_1_1" then
          if not settingsWrapper:isCakeCollected() then
            settingsWrapper:setCakeCollected()
            eventManager:notify({
              id = events.EID_REWARD_POPUP,
              sprite = "GOLDEN_EGG_SPECIAL_CAKE",
              sound = "star_collect"
            })
          end
          eventManager:notify({
            id = events.EID_CAKE_COLLECTED
          })
        end
      end
      addParticles(k, particle, particleAmount, false, false)
      removeObject(k)
      levelGoals[k] = nil
      objects.world[k] = nil
      deadBlocks[k] = nil
    end
  end
end
function updateDestroyedBlocksValues(v)
  if eagleBaitLaunched ~= true and (deviceModel == "iphone" or deviceModel == "ipad" or deviceModel == "iphone4" or deviceModel == "ipad3") then
    if v.material ~= nil then
      if v.material == "wood" then
        settingsWrapper:setWoodBlocksDestroyed(settingsWrapper:getWoodBlocksDestroyed() + 1)
      elseif v.material == "light" then
        settingsWrapper:setIceBlocksDestroyed(settingsWrapper:getIceBlocksDestroyed() + 1)
      elseif v.material == "rock" then
        settingsWrapper:setRockBlocksDestroyed(settingsWrapper:getRockBlocksDestroyed() + 1)
      elseif v.material == "piglette" and not eagleBaitLaunched then
        settingsWrapper:incrementPigsDestroyed()
      elseif v.material == "amber" or v.material == "ruby" or v.material == "amethyst" and not eagleBaitLaunched then
        settingsWrapper:incrementJewelsDestroyed()
      elseif v.material == "stalaktite_tip" and not eagleBaitLaunched then
        settingsWrapper:incrementStalaktitesDestroyed()
      end
      totalBlocks = 0
      totalBlocks = totalBlocks + settingsWrapper:getWoodBlocksDestroyed()
      totalBlocks = totalBlocks + settingsWrapper:getIceBlocksDestroyed()
      totalBlocks = totalBlocks + settingsWrapper:getRockBlocksDestroyed()
    end
    local event = {
      id = events.EID_BLOCKS_DESTROYED,
      totalBlocks = totalBlocks or 0,
      stalaktitesDestroyed = settingsWrapper:getStalaktitesDestroyed(),
      jewelsDestroyed = settingsWrapper:getJewelsDestroyed(),
      pigsDestroyed = settingsWrapper:getPigsDestroyed(),
      rockBlocksDestroyed = settingsWrapper:getRockBlocksDestroyed(),
      iceBlocksDestroyed = settingsWrapper:getIceBlocksDestroyed(),
      woodBlocksDestroyed = settingsWrapper:getWoodBlocksDestroyed()
    }
    eventManager:notify(event)
  end
end
function updateScore(dt)
  score = 0
  for k, v in _G.pairs(scoreTable) do
    score = score + v.score
  end
end
function animateBirdToSlingShot(dt)
  local testIndex = currentBirdIndex + 1
  if nextBirdTimer > 0 then
    nextBirdTimer = nextBirdTimer - dt
    if nextBirdTimer <= 0 then
      if getNextBird(testIndex) ~= nil then
        if birdFired then
          birdFired = false
          fillInNextBird = true
          selectedBird = nil
        end
      else
        allowResetToBirdCamera = false
      end
    end
  end
  if fillInNextBird == true then
    if birdToSlingshotBirdName == nil then
      birdToSlingshotAnimationTimer = 0
      birdToSlingshotBirdName = getNextBird(testIndex)
      objects.world[birdToSlingshotBirdName].jumpTimer = 10000
      if objects.world[birdToSlingshotBirdName].jumpOn == true then
        birdToSlingshotAnimationStartY = objects.world[birdToSlingshotBirdName].oldY
        objects.world[birdToSlingshotBirdName].y = objects.world[birdToSlingshotBirdName].oldY
        objects.world[birdToSlingshotBirdName].jumpOn = false
      end
      birdToSlingshotAnimationStartX = objects.world[birdToSlingshotBirdName].x
      birdToSlingshotAnimationStartY = objects.world[birdToSlingshotBirdName].y
      birdToSlingshotAnimationHeight = (levelStartPosition.y - objects.world[birdToSlingshotBirdName].y) * 1.33
    end
    birdToSlingshotAnimationTimer = birdToSlingshotAnimationTimer + dt
    local obj = objects.world[birdToSlingshotBirdName]
    if obj == nil then
      return
    end
    setPosition(obj.name, birdToSlingshotAnimationStartX * (1 - birdToSlingshotAnimationTimer) + levelStartPosition.x * birdToSlingshotAnimationTimer, birdToSlingshotAnimationStartY + _G.math.sin(birdToSlingshotAnimationAngle * birdToSlingshotAnimationTimer) * birdToSlingshotAnimationHeight)
    setRotation(obj.name, obj.angle + _G.math.pi * 2 * dt)
    if 1 <= birdToSlingshotAnimationTimer then
      birdToSlingshotBirdName = nil
      birdToSlingshotAnimationTimer = 0
      fillInNextBird = false
      birdReady = true
      currentBirdIndex = currentBirdIndex + 1
      currentBirdName = getNextBird(currentBirdIndex)
      setPosition(currentBirdName, levelStartPosition.x - 0.1, levelStartPosition.y - 0.1)
      rubberBandPos.x, rubberBandPos.y = levelStartPosition.x - 0.1, levelStartPosition.y - 0.1
      rubberBandAngle = _G.math.atan2(-0.1, 0.1)
      local castleToBirdCamDist = _G.math.abs(distance(objects.birdCameraData[deviceModel].px, objects.birdCameraData[deviceModel].py, objects.castleCameraData[deviceModel].px, objects.castleCameraData[deviceModel].py))
      local camToBirdCamDist = _G.math.abs(distance(screen.x, screen.y, objects.birdCameraData[deviceModel].px, objects.birdCameraData[deviceModel].py))
      local volume = _G.math.min(1, _G.math.max(0.25, 1 - camToBirdCamDist / castleToBirdCamDist))
      _G.res.playAudio(getAudioName(g_sound_next_bird), volume, false)
      setObjectParameter(currentBirdName, 2, 1)
      setRotation(currentBirdName, 0)
    end
  end
end
function animateChallengeBirdToSlingshot(dt)
  if birdsShot == 0 then
    animateBirdToSlingshot(dt)
    return
  end
  if 0 < nextBirdTimer then
    nextBirdTimer = nextBirdTimer - dt
    if 0 >= nextBirdTimer and birdFired and 0 < #g_currentChallengeProgress.shotsQueue then
      local bird = g_currentChallengeProgress.shotsQueue[1]
      spawnBird("challengeBird" .. birdsCounter .. bird, challengeBirdStartX * scaleFactor, challengeBirdStartY * scaleFactor)
    end
  end
end
function spawnBird(name, type, x, y)
  name = createObject(blockTable, type, name, x, y)
  setRotation(name, 0)
  setMaterial(name, objects.world[name].material)
  objects.world[name].controllable = true
  if objects.world[name].texture ~= nil then
    local texture = blockTable.themes[currentTheme].texture
    setTexture(name, texture)
  end
  birds[name] = objects.world[name]
  birds[name].animTimer = _G.math.random(10, 30) / 10
  birds[name].jumpTimer = _G.math.random(10, 30) / 10
  birdsCounter = birdsCounter + 1
  objects.world[name].startNumber = birdsCounter
  birdReady = true
  currentBirdIndex = currentBirdIndex + 1
  currentBirdName = name
  birdFired = false
  setPosition(currentBirdName, levelStartPosition.x - 0.1, levelStartPosition.y - 0.1)
  rubberBandPos.x, rubberBandPos.y = levelStartPosition.x - 0.1, levelStartPosition.y - 0.1
  rubberBandAngle = _G.math.atan2(-0.1, 0.1)
  local castleToBirdCamDist = _G.math.abs(distance(objects.birdCameraData[deviceModel].px, objects.birdCameraData[deviceModel].py, objects.castleCameraData[deviceModel].px, objects.castleCameraData[deviceModel].py))
  local camToBirdCamDist = _G.math.abs(distance(screen.x, screen.y, objects.birdCameraData[deviceModel].px, objects.birdCameraData[deviceModel].py))
  local volume = _G.math.min(1, _G.math.max(0.25, 1 - camToBirdCamDist / castleToBirdCamDist))
  _G.res.playAudio(getAudioName(g_sound_next_bird), volume, false)
  setObjectParameter(currentBirdName, 2, 1)
  setRotation(currentBirdName, 0)
  addParticles(name, getObjectDefinition(name).particles, 10, false, false)
end
g_scope_sound_ready = true
function stretchRubberBand(displacement)
  _G.assert(displacement.x ~= nil and displacement.y ~= nil, "displacement vector missing x/y members")
  local distToRest = vLength(displacement.x, displacement.y)
  rubberBandAngle = distToRest > 0 and _G.math.atan2(displacement.y, displacement.x) or 0
  if distToRest < shootMaxLength then
    rubberBandPos.x = levelStartPosition.x - displacement.x
    rubberBandPos.y = levelStartPosition.y - displacement.y
    rubberBandLength = distToRest
    if _G.math.abs(rubberBandLength - oldRubberBandLength) > 0.1 and _G.res.isAudioPlaying("slingshot_stretched") == false then
      _G.res.playAudio("slingshot_stretched", 1, false)
    end
    oldRubberBandLength = rubberBandLength
    if birdSelected == false then
      _G.res.playAudio(getObjectDefinition(selectedBird.name).selectionSound, 1, false)
      birdSelected = true
    end
  else
    rubberBandPos.x = levelStartPosition.x - displacement.x * shootMaxLength / distToRest
    rubberBandPos.y = levelStartPosition.y - displacement.y * shootMaxLength / distToRest
    rubberBandLength = shootMaxLength
    rubberBandSpeed = 0
    if birdSelected == false then
      _G.res.playAudio("slingshot_stretched", 1, false)
      _G.res.playAudio(getObjectDefinition(selectedBird.name).selectionSound, 1, false)
      birdSelected = true
    end
  end
  if g_sling_scope and g_scope_sound_ready then
    _G.res.playAudio("laser_sight", 1, false)
    g_scope_sound_ready = false
  end
  local factor = 1
  if rubberBandAngle >= -1.9 and rubberBandAngle < -1.75 then
    factor = -(rubberBandAngle + 1.75) / 0.15
  end
  if rubberBandAngle >= -1.75 and rubberBandAngle < -1.5 then
    factor = 0.25
  end
  if rubberBandAngle >= -1.5 and rubberBandAngle < -1.35 then
    factor = (1.5 + rubberBandAngle) / 0.15
  end
  if factor < 0.25 then
    factor = 0.25
  end
  if rubberBandLength > factor * shootMaxLength then
    rubberBandPos.y = levelStartPosition.y - shootMaxLength * factor * displacement.y / distToRest
    rubberBandLength = distance(levelStartPosition.x, levelStartPosition.y, rubberBandPos.x, rubberBandPos.y)
  end
end
function updateCharacterAnimations(dt)
  if checkLevelFailed() then
    for k, v in _G.pairs(levelGoals) do
      setSprite(v.name, v.smileSprite)
    end
  else
    for k, v in _G.pairs(levelGoals) do
      v.blinkTimer = v.blinkTimer - dt
      if v.blinkTimer < 0 then
        if v.blinkOn == true then
          v.blinkTimer = _G.math.random(1, 30) / 10
          setSprite(v.name, v.damageSprite)
          v.blinkOn = false
        else
          v.blinkTimer = _G.math.random(1, 4) / 10
          setSprite(v.name, v.blinkSprite)
          v.blinkOn = true
        end
      end
    end
  end
  for k, v in _G.pairs(levelGoals) do
    v.oinkTimer = v.oinkTimer - dt
    if 0 > v.oinkTimer then
      v.oinkTimer = _G.math.random(10, 60) / 10
      local lsx, lsy = physicsToWorldTransform(v.x, v.y)
      local dist = vLength(screen.x - lsx, screen.y - lsy)
      local volume = 1 - dist / 1000
      if volume > 0 and g_sound_pigs then
        _G.res.playAudio(getAudioName(g_sound_pigs), volume, false, 0)
      end
    end
  end
  for k, v in _G.pairs(birds) do
    if v.shot ~= true then
      v.animTimer = v.animTimer - dt
      if 0 > v.animTimer then
        if v.animOn == true then
          v.animTimer = _G.math.random(10, 150) / 100
          setSprite(v.name, v.damageSprite)
          v.animOn = false
        else
          v.animTimer = _G.math.random(10, 20) / 100
          local animType = _G.math.random(1, 4)
          local sprite
          local spriteChanged = false
          if animType == 1 then
            sprite = blockTable.blocks[v.definition].spriteYell
            local lsx, lsy = physicsToWorldTransform(levelStartPosition.x, levelStartPosition.y)
            local dist = vLength(screen.x - lsx, screen.y - lsy)
            local volume = 1 - dist / 1000
            if volume > 0 and eagleBaitLaunched ~= true then
              _G.res.playAudio(getAudioName(g_sound_birds), volume, false, 0)
            end
          else
            sprite = blockTable.blocks[v.definition].spriteBlink
          end
          if sprite ~= nil then
            setSprite(v.name, sprite)
          end
          v.animOn = true
        end
      end
      if currentBirdName ~= v.name then
        if v.jumpOn ~= true then
          v.jumpTimer = v.jumpTimer - dt
        end
        if 0 > v.jumpTimer then
          v.jumpTimer = _G.math.random(0, 35) / 10
          v.jumpHeight = _G.math.random(5, 15) / 10
          v.jumpSpeed = 7 / v.jumpHeight * 1.2
          if levelCompleted then
            v.jumpTimer = 0
            v.jumpHeight = _G.math.random(25, 35) / 10
            v.jumpSpeed = 7 / v.jumpHeight * 1.6
          end
          v.jumpAngle = 0
          v.jumpOn = true
          v.jumpRebound = false
          v.jumpRoll = 0
          if blockTable.blocks[v.definition].allowRoll == true and v.jumpHeight > 0.9 then
            v.jumpRoll = _G.math.random(0, 4) - 1
          end
          v.oldY = v.y
          v.oldAngle = v.angle
        end
        if v.jumpOn == true then
          v.jumpAngle = v.jumpAngle + dt * v.jumpSpeed
          setPosition(v.name, v.x, v.oldY - _G.math.sin(v.jumpAngle) * v.jumpHeight)
          if (v.jumpRoll == -1 or v.jumpRoll == 1) and v.jumpRebound ~= true then
            setRotation(v.name, v.jumpAngle * 2 * v.jumpRoll)
          end
          if v.jumpAngle > _G.math.pi then
            if v.jumpRebound == true then
              v.jumpOn = false
              v.y = v.oldY
              v.angle = v.oldAngle
              setPosition(v.name, v.x, v.y)
              setRotation(v.name, v.angle)
            else
              v.jumpRebound = true
              v.jumpAngle = 0
              v.jumpHeight = v.jumpHeight * 0.3
              v.jumpSpeed = v.jumpSpeed * 2
            end
          end
        end
      end
    end
  end
end
extraTutorialTimer = 0
function drawExtraTutorial(sprite)
  if extraTutorialTimer > 0.5 and birdSpecialtyAvailable == true and sprite ~= nil and settingsWrapper:getTutorialsForItem(sprite) and settingsWrapper:getTutorialsForItem(sprite).showHelp then
    if isRetinaGraphicsEnabled() then
      _G.res.drawSprite("", "TUTORIAL_FINGER_BIG", screenWidth * 0.9, screenHeight / 2, "BOTTOM", "HCENTER")
    else
      _G.res.drawSprite("", "TUTORIAL_FINGER_BIG", screenWidth * 0.8, screenHeight, "BOTTOM", "HCENTER")
    end
  end
end
function setHudRenderState()
  if (deviceModel == "iphone4" or deviceModel == "ipad3") and (changeResolution ~= true and wantedResolution == "FULL" or changeResolution == true and wantedResolution == "HALF") then
    setRenderState(0, 0, 2, 2)
  else
    setRenderState(0, 0, 1, 1)
  end
end
function drawFingerHelp()
  if flyingBird ~= nil and flyingBird.name ~= nil then
    local bDef = getObjectDefinition(flyingBird.name)
    drawExtraTutorial(bDef.sprite)
  end
end
function drawPurchaseAdsOffButton()
  if scoreAdOffsetY ~= nil and shouldShowAd() and isShowingAd == true and isAdsOffPurchaseEnabled() then
    setHudRenderState()
    purchaseAdsRemoveButton.x = screenWidth - 480 - purchaseAdsRemoveButton.w / 2
    if 480 > screenHeight and xCoordEye ~= nil then
      purchaseAdsRemoveButton.x = xCoordEye + _G.res.getSpriteBounds("BUTTON_USE_EAGLE") / 2 + purchaseAdsRemoveButton.w * 0.52
    end
    purchaseAdsRemoveButton.y = scoreAdOffsetY / 2
    if currentGameMode == updateGame and popupPage == nil then
      _G.res.drawSprite("", purchaseAdsRemoveButton.sprite, purchaseAdsRemoveButton.x, purchaseAdsRemoveButton.y)
    end
  end
end
function drawGame()
  if showCameraDebugData then
    tempScreen = {}
    tempScreen.x = screen.x
    tempScreen.y = screen.y
    tempScreen.left = screen.left
    tempScreen.right = screen.right
    tempScreen.top = screen.top
    tempScreen.bottom = screen.bottom
    tempScreen.scale = worldScale
    local newScreenHeight = screenHeight / (screenWidth / ((levelRightEdge - levelLeftEdge) * physicsToWorld))
    worldScale = minWorldScale * 0.9
    screen.x = (levelRightEdge + levelLeftEdge) * 0.5 * physicsToWorld
    screen.y = -newScreenHeight * 0.25
    setWorldScale(worldScale)
    defaultCamera(0)
  end
  local c = blockTable.themes[objects.theme].color
  setBGColor(c.r, c.g, c.b)
  setFont(fontBasic)
  if not settingsWrapper:isGfxLowQuality() then
    drawBackgroundNative()
  end
  local rbx, rby = physicsToWorldTransform(rubberBandPos.x, rubberBandPos.y)
  local lsx, lsy = physicsToWorldTransform(levelStartPosition.x, levelStartPosition.y)
  local rbx1, rby1 = rbx, rby
  if currentBirdName ~= nil then
    local radius = objects.world[currentBirdName].radius
    if radius == nil then
      radius = objects.world[currentBirdName].width * 0.5
    end
    rbx1 = rbx - (radius + 0.05) * physicsToWorld * _G.math.cos(rubberBandAngle)
    rby1 = rby - (radius + 0.05) * physicsToWorld * _G.math.sin(rubberBandAngle)
  end
  local rbw = 50 / rubberBandLength
  if rbw > 25 then
    rbw = 25
  end
  if rbw < 10 then
    rbw = 10
  end
  local wScale = worldScale
  if tempWorldScale ~= nil then
    wScale = tempWorldScale
  end
  setRenderState(-screen.left - cameraShakeX, -screen.top - cameraShakeY, wScale, wScale, 0)
  _G.res.drawSprite(g_slingshot_back, lsx, lsy)
  local lsx1, lsy1 = lsx + 20, lsy
  drawLine2D(lsx1, lsy1, rbx1, rby1, rbw, g_rubber_r, g_rubber_g, g_rubber_b, 255)
  if selectedBird == nil then
    _G.res.drawSprite("SLING_HOLDER", rbx1, rby1)
  end
  drawGameNative()
  if not settingsWrapper:isGfxLowQuality() and g_levelParticlesEnabled then
    drawLevelParticlesNative(1)
  end
  drawForegroundNative()
  if not settingsWrapper:isGfxLowQuality() and g_levelParticlesEnabled then
    drawLevelParticlesNative(2)
  end
  setRenderState(-screen.left - cameraShakeX, -screen.top - cameraShakeY, wScale, wScale, 0, 0, 0)
  local lsx2, lsy2 = lsx - 21, lsy - 3
  drawLine2D(lsx2, lsy2, rbx1, rby1, rbw, g_rubber_r, g_rubber_g, g_rubber_b, 255)
  if selectedBird ~= nil then
    setRenderState(-screen.left - cameraShakeX, -screen.top - cameraShakeY, wScale, wScale, rubberBandAngle, _G.res.getSpritePivot("INGAME_BIRDS_1", "SLING_HOLDER"))
    _G.res.drawSprite("INGAME_BIRDS_1", "SLING_HOLDER", rbx1, rby1)
  end
  if g_sling_scope then
    drawSlingScope(wScale)
  end
  setRenderState(-screen.left - cameraShakeX, -screen.top - cameraShakeY, wScale, wScale, 0, 0, 0)
  _G.res.drawSprite(g_slingshot_front, lsx, lsy)
  if useLevelLimits and cameraTargetObject ~= nil then
    local ct = cameraTargetObject
    if ct.y * physicsToWorld < screen.top then
      setRenderState(-screen.left, -screen.top, wScale, wScale, 0, ct.spritePivotX, ct.spritePivotY)
      _G.res.drawSprite("INGAME_BIRDS_1", "HUD_ARROW_UP", _G.math.floor(ct.x * physicsToWorld), _G.math.floor(screen.top))
    end
  end
  if currentGameMode ~= updateEditor then
    setRenderState(0, 0, 1, 1, 0)
    local drawHud = true
    if hideHud == true then
      drawHud = false
    end
  end
  if currentGameMode == updateEditor then
    drawSelectedObjectsArea()
  end
  if showSleepingObjects == true then
    for k, v in _G.pairs(objects.world) do
      if v.sleeping == true and v.sprite ~= "" then
        local w, h = _G.res.getSpriteBounds("", v.sprite)
        w, h = w * 0.5, h * 0.5
        local x, y = physicsToWorldTransform(v.x, v.y)
        local x1, y1 = x - w, y - h
        local x2, y2 = x + w, y + h
        setRenderState(-screen.left, -screen.top, wScale, wScale, v.angle, v.spritePivotX, v.spritePivotY)
        drawRect(1, 0, 0, 0.5, x1, y1, x2, y2, true)
      end
      if v.definition and v.sprite ~= "" then
        local blockDef = blockTable.blocks[v.definition]
        local w, h = _G.res.getSpriteBounds("", v.sprite)
        w, h = w * 0.5, h * 0.5
        local x, y = physicsToWorldTransform(v.x, v.y)
        local x1, y1 = x - w, y - h
        local x2, y2 = x + w, y + h
        if blockDef.type == "circle" then
          local radius = blockDef.radius or _G.math.max(worldToPhysicsTransform(w, 0), worldToPhysicsTransform(h, 0))
          drawCircle(x, y, radius, v.angle, 255, 255, 255, 255, 4)
        elseif blockDef.type == "box" and blockDef.width ~= nil then
          local ww, hh = physicsToWorldTransform(blockDef.width, blockDef.height)
          local x1, y1 = x - ww / 2, y - hh / 2
          local x2, y2 = x + ww / 2, y + hh / 2
          local pivX = v.spritePivotX / (w * 2)
          local pivY = v.spritePivotY / (h * 2)
          drawWireFrameRect(x1, y1, x2, y2, 3, true, 0, 255, 255, 190, v.angle, pivX, pivY)
        elseif blockDef.type == "box" and blockDef.width == nil then
          local w, h = _G.res.getSpriteBounds("", v.sprite)
          w, h = w * 0.5, h * 0.5
          local x, y = physicsToWorldTransform(v.x, v.y)
          local x1, y1 = x - w, y - h
          local x2, y2 = x + w, y + h
          drawWireFrameRect(x1, y1, x2, y2, 3, true, 0, 255, 255, 190, v.angle, pivX, pivY)
        elseif blockDef.type == "polygon" and blockDef.vertices then
          local points = {}
          for kk, vv in _G.pairs(blockDef.vertices) do
            local wx, wy = w * 2 * vv.x, h * 2 * vv.y
            local point = {
              x + wx - w,
              y + wy - h
            }
            _G.table.insert(points, point)
          end
          drawPolygon(points, 3, true, 255, 255, 255, 255, v.angle, 0.5, 0.5)
        end
      end
      if v.strength ~= nil and v.sprite ~= nil and v.strength ~= blockTable.blocks[v.definition].strength and v.sprite ~= "" then
        local w, h = _G.res.getSpriteBounds("", v.sprite)
        w, h = w * 0.5, h * 0.5
        local x, y = physicsToWorldTransform(v.x, v.y)
        local x1, y1 = x - w, y - h
        local x2, y2 = x + w, y + h
        setRenderState(-screen.left, -screen.top, wScale, wScale, v.angle, v.spritePivotX, v.spritePivotY)
        drawLine(0, 0, 255, 155, x1, y1, x2, y1, true, 4)
        drawLine(0, 0, 255, 155, x1, y1, x1, y2, true, 4)
        setRenderState(-screen.left, -screen.top, wScale, wScale, v.angle, v.spritePivotX, -v.spritePivotY)
        drawLine(0, 0, 255, 155, x1, y2, x2, y2, true, 4)
        setRenderState(-screen.left, -screen.top, wScale, wScale, v.angle, -v.spritePivotX, v.spritePivotY)
        drawLine(0, 0, 255, 155, x2, y1, x2, y2, true, 4)
      end
      if selectedObjects ~= nil and #selectedObjects == 1 and selectedObjects[1] == v then
        drawDummyCollisionBox(v)
      end
    end
  end
  setRenderState(0, 0, 1, 1, 0)
  oldZoomLevel = zoomLevel
  if deviceModel == "android" and isBetaVersion and currentGameMode == updateGame and #birdTutorialPopups == 0 then
    _G.res.drawSprite("MENU_LITEBETA_1", "BETA_BOTTOM_RIGHT", screenWidth, screenHeight)
  end
  if objects.world.MightyEagle_a ~= nil then
    local eagle = objects.world.MightyEagle_a
    if eagle.targetX > eagle.x then
      eagleDarkness = (100 - _G.math.min(_G.math.max(_G.math.abs(eagle.targetX - eagle.x), 0), 100)) / 200
    end
  end
  if eagleDarkness ~= nil then
    drawRect(0, 0, 0, eagleDarkness, 0, 0, screenWidth, screenHeight, false)
  end
  if popupPage ~= nil then
    drawMenuPage(popupPage)
  end
  if showCameraDebugData then
    local bcd = objects.birdCameraData[deviceModel]
    local ccd = objects.castleCameraData[deviceModel]
    local swx = screenWidth * 0.5 / tempScreen.scale
    local swy = screenHeight * 0.5 / tempScreen.scale
    setRenderState(-screen.left, -screen.top, wScale, wScale, 0, 0, 0)
    drawLine2D(bcd.px, bcd.py, ccd.px, ccd.py, 3, 48, 23, 8, 255)
    drawLine2D(animationScreen.x, animationScreen.y - 15, animationScreen.x, animationScreen.y + 15, 3, 48, 23, 8, 255)
    drawRectLines(visualizeScreen.x - swx, visualizeScreen.y - swy, visualizeScreen.x + swx, visualizeScreen.y + swy, 3, 255, 255, 255, 255)
    drawLine2D(leftLimit, -500, leftLimit, 50, 3, 255, 23, 8, 255)
    drawLine2D(rightLimit, -500, rightLimit, 50, 3, 255, 23, 8, 255)
    drawLine2D(leftLimit, groundLimit, rightLimit, groundLimit, 3, 255, 23, 8, 255)
    setRenderState(0, 0, 1, 1, 0)
    screen.x = tempScreen.x
    screen.y = tempScreen.y
    screen.left = tempScreen.left
    screen.right = tempScreen.right
    screen.top = tempScreen.top
    screen.bottom = tempScreen.bottom
    worldScale = tempScreen.scale
    setWorldScale(worldScale)
  end
end
function defaultCamera(dt)
  screen.left = screen.x - screenWidth * 0.5 / worldScale
  screen.top = screen.y - screenHeight * 0.5 / worldScale
  screen.right = screen.x + screenWidth * 0.5 / worldScale
  screen.bottom = screen.y + screenHeight * 0.5 / worldScale
  setTopLeft(screen.left + cameraShakeX, screen.top + cameraShakeY)
end
function getTempBirdCamera()
  local tempCamera = {}
  local bcd = objects.birdCameraData[deviceModel]
  local ccd = objects.castleCameraData[deviceModel]
  if maxZoomLevel == true then
    tempCamera.sx = bcd.sx
  else
    tempCamera.sx = currentZoomedScale
  end
  if tempCamera.sx > bcd.sx then
    tempCamera.sx = bcd.sx
  end
  if tempCamera.sx < minWorldScale then
    tempCamera.sx = minWorldScale
  end
  tempCamera.py = bcd.py
  local alpha = (tempCamera.sx - minWorldScale) / (bcd.sx - minWorldScale)
  tempCamera.py = bcd.py * alpha + ccd.py * (1 - alpha)
  local groundPos = tempCamera.py + screenHeight * 0.5 / tempCamera.sx
  if groundPos > groundLimit then
    tempCamera.py = tempCamera.py + (groundLimit - groundPos)
  end
  local leftPos = bcd.px - screenWidth * 0.5 / tempCamera.sx
  tempCamera.px = bcd.px
  if leftPos < leftLimit then
    tempCamera.px = bcd.px + (leftLimit - leftPos)
  end
  return tempCamera
end
function getTempCastleCamera()
  local tempCamera = {}
  local ccd = objects.castleCameraData[deviceModel]
  if maxZoomLevel == true then
    tempCamera.sx = ccd.sx
  else
    tempCamera.sx = currentZoomedScale
  end
  if tempCamera.sx > ccd.sx then
    tempCamera.sx = ccd.sx
  end
  if tempCamera.sx < minWorldScale then
    tempCamera.sx = minWorldScale
  end
  local groundPos = ccd.py + screenHeight * 0.5 / tempCamera.sx
  tempCamera.py = ccd.py
  if groundPos > groundLimit then
    tempCamera.py = ccd.py + (groundLimit - groundPos)
  end
  local rightPos = ccd.px + screenWidth * 0.5 / tempCamera.sx
  tempCamera.px = ccd.px
  if rightPos > rightLimit then
    tempCamera.px = ccd.px + (rightLimit - rightPos)
  end
  return tempCamera
end
useLevelLimits = true
function doItAllCamera(dt)
  local ccd = objects.castleCameraData[deviceModel]
  local bcd = objects.birdCameraData[deviceModel]
  if oldZoomLevel ~= zoomLevel and not g_zooming_disabled then
    maxZoomLevel = false
    currentZoomedScale = currentZoomedScale + zoomLevel - oldZoomLevel
    if cameraAnimationSliderTarget == 0 then
      if currentZoomedScale >= bcd.sx then
        currentZoomedScale = bcd.sx
        maxZoomLevel = true
      end
    elseif currentZoomedScale >= ccd.sx then
      currentZoomedScale = ccd.sx
      maxZoomLevel = true
    end
    if currentZoomedScale < minWorldScale then
      currentZoomedScale = minWorldScale
    end
    oldZoomLevel = zoomLevel
    animationWorldScale = currentZoomedScale
  end
  local bcdt = getTempBirdCamera()
  local ccdt = getTempCastleCamera()
  if ccd ~= nil and bcd ~= nil and not g_zooming_disabled then
    local springFactor = dt * 3.5
    local scaleFactor = screenWidth / ccd.screenWidth
    local screenTemp = {x = 0, y = 0}
    local dx = ccdt.px - bcdt.px
    if dx < 1 then
      dx = 1
    end
    animateScale = true
    if 0 > cameraAnimationSlider then
      cameraAnimationSlider = cameraAnimationSlider - cameraAnimationSlider * 0.3
      if cameraAnimationSlider < -0.01 then
        animateScale = false
      end
      forceSprings = true
      sweepSpeed = 0
    end
    if 1 < cameraAnimationSlider then
      cameraAnimationSlider = cameraAnimationSlider + (1 - cameraAnimationSlider) * 0.3
      if cameraAnimationSlider > 1.01 then
        animateScale = false
      end
      forceSprings = true
      sweepSpeed = 0
    end
    if 0 < cameraAnimationSlider and 1 > cameraAnimationSlider and sweepSpeed == 0 then
      forceSprings = false
      if cameraAnimationSlider < 0.5 then
        cameraAnimationSliderTarget = 0
      else
        cameraAnimationSliderTarget = 1
      end
    end
    if cameraTargetObject == nil then
      if (not g_usingGestureControls and not keyHold.LBUTTON or g_usingGestureControls and (not multitouchSweep.isSweeping or multitouchSweep.sweepAxis ~= "x")) and sweepSpeed == 0 then
        cameraAnimationSlider = cameraAnimationSlider + (cameraAnimationSliderTarget - cameraAnimationSlider) * 0.3
      elseif forceSprings ~= true then
        springFactor = 1
      end
      cameraAnimationSlider = cameraAnimationSlider - dt * sweepSpeed / (dx * bcd.sx)
      local tsx = bcdt.sx + (ccdt.sx - bcdt.sx) * cameraAnimationSlider
      local tpx = bcdt.px + (ccdt.px - bcdt.px) * cameraAnimationSlider
      local tpy = bcdt.py + (ccdt.py - bcdt.py) * cameraAnimationSlider
      animationScreen.x = animationScreen.x - (animationScreen.x - tpx) * springFactor
      animationScreen.y = animationScreen.y - (animationScreen.y - tpy) * springFactor
      if animateScale == true then
        animationWorldScale = animationWorldScale - (animationWorldScale - tsx) * springFactor
      end
      if maxZoomLevel == true then
        currentZoomedScale = animationWorldScale
      end
      screen.x = animationScreen.x
      screen.y = animationScreen.y
      worldScale = animationWorldScale
      setWorldScale(worldScale)
      repositionScreen()
    end
    if cameraTargetObject ~= nil then
      local ctx, cty = physicsToWorldTransform(cameraTargetObject.x, cameraTargetObject.y)
      if 0 < cameraTargetObject.xVel then
        cameraAnimationSlider = cameraAnimationSlider + cameraTargetObject.xVel * physicsToWorld * dt * 10 / dx
      end
      if 1 < cameraAnimationSlider then
        cameraAnimationSlider = 1
      end
      local tsx = bcdt.sx + (ccdt.sx - bcdt.sx) * cameraAnimationSlider
      local tpx = bcdt.px + (ccdt.px - bcdt.px) * cameraAnimationSlider
      local tpy = bcdt.py + (ccdt.py - bcdt.py) * cameraAnimationSlider
      animationWorldScale = animationWorldScale - (animationWorldScale - tsx) * springFactor
      animationScreen.x = animationScreen.x - (animationScreen.x - tpx) * springFactor
      animationScreen.y = animationScreen.y - (animationScreen.y - tpy) * springFactor
      local cleft = animationScreen.x - screenWidth * 0.5 / animationWorldScale
      local ctop = animationScreen.y - screenHeight * 0.5 / animationWorldScale
      local cright = animationScreen.x + screenWidth * 0.5 / animationWorldScale
      local cbottom = animationScreen.y + screenHeight * 0.5 / animationWorldScale
      local minx = _G.math.min(cleft, ctx - 50)
      local miny = _G.math.min(ctop, cty - 50)
      local maxx = _G.math.max(cright, ctx + 50)
      local maxy = _G.math.max(cbottom, cty + 50)
      if useLevelLimits then
        minx = _G.math.max(leftLimit, minx)
        maxx = _G.math.min(rightLimit, maxx)
      end
      local xScale = _G.math.abs(screenWidth / (maxx - minx))
      local yScale = _G.math.abs(screenHeight / (maxy - miny))
      local worldScaleTemp = _G.math.min(xScale, yScale) * scaleFactor
      if worldScaleTemp > animationWorldScale then
        worldScaleTemp = animationWorldScale
      end
      screenTemp.x = (maxx + minx) * 0.5
      screenTemp.y = (maxy + miny) * 0.5
      if useLevelLimits then
        local limitsReached = false
        if screenTemp.x + screenWidth * 0.5 / worldScaleTemp > rightLimit then
          maxx = rightLimit
          minx = maxx - screenWidth / worldScaleTemp
          limitsReached = true
          if minx < leftLimit then
            minx = leftLimit
          end
        end
        if screenTemp.x - screenWidth * 0.5 / worldScaleTemp < leftLimit then
          minx = leftLimit
          maxx = minx + screenWidth / worldScaleTemp
          limitsReached = true
          if maxx > rightLimit then
            maxx = rightLimit
          end
        end
        if limitsReached then
          screenTemp.x = (maxx + minx) * 0.5
          worldScaleTemp = _G.math.abs(screenWidth / (maxx - minx)) * scaleFactor
        end
      end
      screen.x = screen.x - (screen.x - screenTemp.x) * springFactor
      animationWorldScale2 = animationWorldScale2 - (animationWorldScale2 - worldScaleTemp) * springFactor
      worldScale = animationWorldScale2
      screen.y = screen.y - (screen.y - screenTemp.y) * springFactor
      forceSprings = true
      if ctx >= rightLimit or ctx <= leftLimit then
        animationWorldScale = worldScale
        animationScreen.x = screen.x
        animationScreen.y = screen.y
        cameraTargetObject = nil
      end
      setWorldScale(worldScale)
      repositionScreen()
    end
  end
  defaultCamera(dt)
end
function cinematicCamera(dt)
  g_cinematic_camera_timer = g_cinematic_camera_timer + dt
  if #g_cinematic_camera > 0 and g_cinematic_camera_timer >= g_cinematic_camera[1].time then
    local action = _G.table.remove(g_cinematic_camera, 1)
    local default_tween = tweenLinear
    if action.action == "pan" then
      g_cinematic_camera_pan = {
        t0 = action.time,
        td = action.duration,
        x0 = screen.x,
        y0 = screen.y,
        xd = action.x - screen.x,
        yd = action.y - screen.y,
        tween = action.tween or default_tween
      }
    elseif action.action == "zoom" then
      g_cinematic_camera_zoom = {
        t0 = action.time,
        td = action.duration,
        z0 = worldScale,
        zd = action.zoom - worldScale,
        tween = action.tween or default_tween
      }
    elseif action.action == "set_camera" then
      cameraFunction = action.camera
    end
  end
  if g_cinematic_camera_pan then
    local pan = g_cinematic_camera_pan
    if g_cinematic_camera_timer > pan.t0 + pan.td then
      g_cinematic_camera_pan = nil
      screen.x = pan.x0 + pan.xd
      screen.y = pan.y0 + pan.yd
    else
      screen.x = pan.tween(g_cinematic_camera_timer - pan.t0, pan.x0, pan.xd, pan.td)
      screen.y = pan.tween(g_cinematic_camera_timer - pan.t0, pan.y0, pan.yd, pan.td)
    end
  end
  if g_cinematic_camera_zoom then
    local zoom = g_cinematic_camera_zoom
    if g_cinematic_camera_timer > zoom.t0 + zoom.td then
      g_cinematic_camera_zoom = nil
      worldScale = zoom.z0 + zoom.zd
    else
      worldScale = zoom.tween(g_cinematic_camera_timer - zoom.t0, zoom.z0, zoom.zd, zoom.td)
    end
  end
  animationScreen.x = screen.x
  animationScreen.y = screen.y
  setWorldScale(worldScale)
  repositionScreen()
  defaultCamera(dt)
end
function returnToBirdCamera()
  showTapIcon = false
  showTapTimer = 0
  cameraFunction = doItAllCamera
  sweepSpeed = objects.castleCameraData[deviceModel].px - objects.birdCameraData[deviceModel].px
  cameraAnimationSliderTarget = 0
  if cameraAnimationSlider >= 1 then
    cameraAnimationSlider = 1
  end
  allowResetToBirdCamera = false
  cameraTargetObject = nil
  flyingBird = nil
end
function panToBirdCamera()
  cameraFunction = doItAllCamera
  sweepSpeed = objects.castleCameraData[deviceModel].px - objects.birdCameraData[deviceModel].px
  cameraAnimationSliderTarget = 0
  if cameraAnimationSlider >= 1 then
    cameraAnimationSlider = 1
  end
  cameraTargetObject = nil
end
function panToCastleCamera()
  cameraFunction = doItAllCamera
  sweepSpeed = objects.birdCameraData[deviceModel].px - objects.castleCameraData[deviceModel].px
  cameraAnimationSliderTarget = 1
  if cameraAnimationSlider <= 0 then
    cameraAnimationSlider = 0
  end
  cameraTargetObject = nil
end
function repositionScreen()
  local ccd = objects.castleCameraData[deviceModel]
  local bcd = objects.birdCameraData[deviceModel]
  if worldScale < minWorldScale then
    worldScale = minWorldScale
    setWorldScale(worldScale)
  end
  if showCameraDebugData then
    visualizeScreen.x = screen.x
    visualizeScreen.y = screen.y
  end
  local groundPos = screen.y + screenHeight * 0.5 / worldScale
  if groundPos > groundLimit then
    screen.y = screen.y + (groundLimit - groundPos)
  end
  local rightPos = screen.x + screenWidth * 0.5 / worldScale
  if rightPos > rightLimit then
    screen.x = screen.x + (rightLimit - rightPos)
  end
  local leftPos = screen.x - screenWidth * 0.5 / worldScale
  if leftPos < leftLimit then
    screen.x = screen.x + (leftLimit - leftPos)
  end
end
function updateIsLevelStartCamera()
  g_isLevelStartCamera = cameraFunction == levelStartCamera
end
function levelStartCamera(dt)
  local ccd = objects.castleCameraData[deviceModel]
  local bcd = objects.birdCameraData[deviceModel]
  if castleCameraTimer < 2 then
    local wx, wy = ccd.px, ccd.py
    if g_zooming_disabled then
      worldScale = minWorldScale
    elseif levelRestartedFrom == nil or startedFromEditor then
      worldScale = ccd.sx
    else
      worldScale = getTempCastleCamera().sx
    end
    setWorldScale(worldScale)
    screen.x = wx
    screen.y = wy
    castleCameraTimer = castleCameraTimer + dt
    animationWorldScale = worldScale
    animationScreen.x = screen.x
    animationScreen.y = screen.y
    if levelRestartedFrom ~= nil or startedFromEditor ~= true then
      repositionScreen()
    end
    defaultCamera(dt)
    return
  end
  castleCameraTimer = 0
  cameraAnimationSlider = 1
  cameraAnimationSliderTarget = 0
  sweepSpeed = ccd.px - bcd.px
  showTapIcon = false
  cameraFunction = doItAllCamera
  animationScreen.x = screen.x
  animationScreen.y = screen.y
  animationWorldScale = worldScale
  defaultCamera(dt)
end
function gotoCastleCamera(dt)
  if objects.birdCameraData[deviceModel] ~= nil then
    local ccd = objects.castleCameraData[deviceModel]
    local wx, wy = ccd.px, ccd.py
    local springFactor = dt * 4
    animationWorldScale = animationWorldScale - (animationWorldScale - ccd.sx) * springFactor
    animationScreen.x = animationScreen.x - (animationScreen.x - wx) * springFactor
    animationScreen.y = animationScreen.y - (animationScreen.y - wy) * springFactor
    cameraAnimationSliderTarget = 1
    cameraAnimationSlider = 1
    screen.x = animationScreen.x
    screen.y = animationScreen.y
    worldScale = animationWorldScale
    setWorldScale(worldScale)
  end
  defaultCamera(dt)
end
function launchCamera(dt)
  if castleCameraTimer < 3 then
    castleCameraTimer = castleCameraTimer + dt
    defaultCamera(dt)
    return
  end
  if objects.birdCameraData and objects.birdCameraData[deviceModel] ~= nil then
    local ccd = objects.castleCameraData[deviceModel]
    local bcd = objects.birdCameraData[deviceModel]
    local wx, wy = bcd.px, bcd.py
    local springFactor = dt * 4
    animationWorldScale = animationWorldScale - (animationWorldScale - bcd.sx) * springFactor
    animationScreen.x = animationScreen.x - (animationScreen.x - wx) * springFactor
    animationScreen.y = animationScreen.y - (animationScreen.y - wy) * springFactor
    cameraAnimationSlider = (bcd.px - animationScreen.x) / (bcd.px - ccd.px)
    screen.x = animationScreen.x
    screen.y = animationScreen.y
    worldScale = animationWorldScale
    setWorldScale(worldScale)
    if _G.math.abs(worldScale - ccd.sx) < 0.05 and _G.math.abs(screen.x - wx) < 5 and _G.math.abs(screen.y - wy) < 5 then
      worldScale = bcd.sx
      setWorldScale(worldScale)
      screen.x = wx
      screen.y = wy
      cameraFunction = defaultCamera
      castleCameraTimer = 0
      cameraAnimationSlider = 0
    end
  end
  defaultCamera(dt)
end
function setPositions(xadd, yadd)
  for k, v in _G.pairs(selectedObjects) do
    setPosition(v.name, v.x + xadd * physicsScale, v.y + yadd * physicsScale)
    setSleeping(v.name, false)
  end
  levelSaved = false
end
function updateScale()
  if oldScale ~= worldScale then
    local wx = cursor.x / oldScale + screen.left
    local wy = cursor.y / oldScale + screen.top
    local newx = (wx * worldScale - cursor.x) / worldScale
    local newy = (wy * worldScale - cursor.y) / worldScale
    screen.x = newx + screenWidth * 0.5 / worldScale
    screen.y = newy + screenHeight * 0.5 / worldScale
  end
  oldScale = worldScale
end
function birdCollision(object1, object2, force, damage)
  local obj1 = objects.world[object1]
  local obj2 = objects.world[object2]
  if obj1.controllable and damage > 0 then
    local bird = obj1
    local resultDamage = damage * 10
    _G.table.insert(floatingScores, {
      x = bird.x,
      y = bird.y,
      text = "" .. resultDamage,
      score = resultDamage,
      time = 0,
      lifetime = 0.6,
      maxScale = floatingScoreScaling * (0.25 + resultDamage / 3000),
      xs = 0
    })
    if scoreTable[object1] == nil then
      scoreTable[object1] = {}
      scoreTable[object1].score = 0
    end
    scoreTable[object1].score = scoreTable[object1].score + resultDamage
  end
  if g_deltaBasedSlingshot and (obj1.shot and not obj1.hasCollided or obj2.shot and not obj2.hasCollided) and birdSpecialtyAvailable then
    activateSlingshotCooldown()
  end
  if obj1.shot and obj2.shot then
    if not obj1.hasCollided and not obj2.hasCollided and not obj1.isEagleBait and not obj2.isEagleBait then
      if obj1.parentName == nil or obj2.parentName == nil or obj1.parentName ~= obj2.parentName then
        obj1.hasCollided, obj2.hasCollided = true, true
        if eagleBaitLaunched ~= true and not g_special_game_mode then
          settingsWrapper:setWilhelmTell()
          eventManager:notify({
            id = events.EID_BIRDS_COLLIDED_ON_FLY
          })
        end
      end
    elseif obj1.isMightyEagle and obj2.isEagleBait then
      obj2.frozen = true
    elseif obj2.isMightyEagle and obj1.isEagleBait then
      obj1.frozen = true
    end
  elseif obj1.shot and obj2.levelGoal and not settingsWrapper:getBullsEye() then
    if not obj1.hasCollided and obj2.x - levelStartPosition.x > 75 then
      obj1.hasCollided = true
      if eagleBaitLaunched ~= true and not g_special_game_mode then
        eventManager:notify({
          id = events.EID_ACHIEVEMENT_BULLSEYE
        })
        settingsWrapper:setBullsEye()
      end
    end
  elseif obj2.shot and obj1.levelGoal and not settingsWrapper:getBullsEye() then
    if not obj2.hasCollided and obj1.x - levelStartPosition.x > 75 then
      obj2.hasCollided = true
      if eagleBaitLaunched ~= true and not g_special_game_mode then
        eventManager:notify({
          id = events.EID_ACHIEVEMENT_BULLSEYE
        })
        settingsWrapper:setBullsEye()
      end
    end
  elseif obj1.shot then
    obj1.hasCollided = true
  elseif obj2.shot then
    obj2.hasCollided = true
  end
  if obj1.shot then
    local bDef = getObjectDefinition(obj1.name)
    local birdSpecialty = bDef.specialty
    if bDef.spriteCollision ~= nil then
      if birdSpecialty == "GRENADE" then
        if birdSpecialtyAvailable and flyingBird == obj1 then
          objects.world[obj1.name].sprite = bDef.spriteCollision
          setSprite(obj1.name, objects.world[obj1.name].sprite)
        end
      else
        objects.world[obj1.name].sprite = bDef.spriteCollision
        setSprite(obj1.name, objects.world[obj1.name].sprite)
      end
    end
  end
  if obj2.shot then
    local bDef = getObjectDefinition(obj2.name)
    local birdSpecialty = bDef.specialty
    if bDef.spriteCollision ~= nil then
      if birdSpecialty == "GRENADE" then
        if birdSpecialtyAvailable and flyingBird == obj2 then
          objects.world[obj2.name].sprite = bDef.spriteCollision
          setSprite(obj2.name, objects.world[obj2.name].sprite)
        end
      else
        objects.world[obj2.name].sprite = bDef.spriteCollision
        setSprite(obj2.name, objects.world[obj2.name].sprite)
      end
    end
  end
  if flyingBird ~= nil and (flyingBird.name == object1 or flyingBird.name == object2) then
    if (obj1.controllable ~= true or obj2.controllable ~= true) and cameraTargetObject ~= nil and (cameraTargetObject == obj1 or cameraTargetObject == obj2) then
      cameraTargetObject = nil
      animationScreen.x = screen.x
      animationScreen.y = screen.y
      animationWorldScale = worldScale
    end
    local bDef = getObjectDefinition(flyingBird.name)
    local birdSpecialty = bDef.specialty
    if birdSpecialty ~= "BOMB" and birdSpecialty ~= "GLOBE" then
      birdSpecialtyAvailable = false
      if bDef.spriteCollision ~= nil then
        if birdSpecialty == "GRENADE" then
          if birdSpecialtyAvailable then
            objects.world[flyingBird.name].sprite = bDef.spriteCollision
            setSprite(flyingBird.name, objects.world[flyingBird.name].sprite)
          end
        else
          objects.world[flyingBird.name].sprite = bDef.spriteCollision
          setSprite(flyingBird.name, objects.world[flyingBird.name].sprite)
        end
      end
      if birdSpecialty == "SUMMON_MIGHTY_EAGLE" and flyingBird.collision ~= true and eagleTimer == nil then
        eagleTimer = 8.7
        eagleMoving = true
      end
    elseif birdSpecialty == "BOMB" then
      if flyingBird.collision ~= true then
        objects.world[flyingBird.name].bombTimer = 1.5
        objects.world[flyingBird.name].damageSprite = bDef.spriteSpecial1
        objects.world[flyingBird.name].sprite = objects.world[flyingBird.name].damageSprite
        setSprite(flyingBird.name, objects.world[flyingBird.name].damageSprite)
        birdSpecialtyAvailable = true
      end
    elseif birdSpecialty == "GLOBE" and flyingBird.collision ~= true then
      objects.world[flyingBird.name].globeTimer = 1.5
      birdSpecialtyAvailable = true
    end
    flyingBird.collision = true
  end
  if obj1.controllable then
    local bird = obj1
    local bDef = getObjectDefinition(bird.name)
    local birdSpecialty = bDef.specialty
    if birdSpecialty == "BOOMERANG" then
      bird.boomerangActive = false
    end
  end
  if obj2.controllable then
    local bird = obj2
    local bDef = getObjectDefinition(bird.name)
    local birdSpecialty = bDef.specialty
    if birdSpecialty == "BOOMERANG" then
      bird.boomerangActive = false
    end
  end
  if obj1.shot and obj1.controllable then
    obj1.collision = true
    if obj2.controllable ~= true then
      obj1.recordTrajectory = false
    end
  end
  if obj2.shot and obj2.controllable then
    obj2.collision = true
    if obj1.controllable ~= true then
      obj2.recordTrajectory = false
    end
  end
  for i = #flyingGrenades, 1, -1 do
    local flyingGrenade = flyingGrenades[i].name
    if flyingGrenade == object1 and obj2.controllable ~= true or flyingGrenade == object2 and obj1.controllable ~= true then
      flyingGrenades[i].explode = true
      if object1 == flyingGrenade then
        object1 = nil
      end
    end
    if object1 == flyingGrenade and obj2.controllable == true then
      return
    end
    if object2 == flyingGrenade and obj1.controllable == true then
      return
    end
  end
  if object1 ~= nil then
    if objects.world[object1].definition == "MightyEagleBird" and objects.world[object2].definition == "BaitSardine" then
      objects.world[object2].strength = 0
    elseif objects.world[object1].lowerThanGround or objects.world[object1].definition == "MightyEagleBird" and object2 == "ground" then
      objects.world[object1].hitGround = true
      cameraShake = 100
      local bDef = getObjectDefinition(objects.world[object1].name)
      bDef.spriteCollision = "BIRD_MIGHTY_EAGLE_RADIAL"
      objects.world[object1].sprite = bDef.spriteCollision
      setSprite(object1, objects.world[object1].sprite)
      _G.res.playAudio("mighty_eagle_thump", 1, false)
      for k, v in _G.pairs(objects.world) do
        if v.strength ~= nil and v.levelGoal then
          local force = -v.mass * 15
          applyImpulse(v.name, 0, force, v.x, v.y)
          v.strength = 1.0E-4
          v.defence = 0
        elseif v.isEagleBait then
          v.strength = 0
        end
      end
      destroyJoints = true
      eagleTimer = 4
    end
    local birdie = birds[object1]
    local birdieStartForce = 0
    if object2 ~= nil and (getObjectDefinition(object2).material == "immovable" or getObjectDefinition(object2).material == "staticGround") and birdie ~= nil and birdie.xVel ~= nil and birdie.yVel ~= nil then
      birdieStartForce = vLength(birdie.xVel, birdie.yVel) * birdie.mass / 10
    end
    if force > collisionParticleForceThreshold or birdieStartForce > collisionParticleForceThreshold then
      local mat = blockTable.materials[getObjectDefinition(object2).material]
      if mat ~= nil then
        local sound = mat.collisionSound
        if damage > 10 then
          sound = mat.damageSound or sound
        end
        if sound ~= nil then
          _G.res.playAudio(getAudioName(sound), 0.7, false, 2)
        end
      end
      local particle = getObjectDefinition(object1).particles
      local particleAmount = _G.math.random(12, 20)
      if getObjectDefinition(object1).particlesAmountLimits ~= nil then
        particleAmount = _G.math.random(getObjectDefinition(object1).particlesAmountLimits[1], getObjectDefinition(object1).particlesAmountLimits[2])
      end
      addParticles(object1, particle, particleAmount, false, false)
      local volume = 0.7
      if birdie ~= nil then
        local maxForce = 60 * birdie.mass / 10
        local dmgFactor = blockTable.damageFactors[birdie.damageFactors].damageMultiplier[getObjectDefinition(object2).material]
        if dmgFactor ~= nil and dmgFactor > 1 then
          maxForce = maxForce * dmgFactor
        end
        volume = _G.math.min(_G.math.max(_G.math.max(force, birdieStartForce) / maxForce, 0.2), 1)
      end
      if getObjectDefinition(object1).collisionSound ~= nil then
        _G.res.playAudio(getAudioName(getObjectDefinition(object1).collisionSound), volume, false, 2)
      end
    end
  end
  if obj2.controllable ~= true then
    local sprites = getDamageSprite(obj2, blockTable.blocks)
    obj2.damageSprite = sprites.sprite
    obj2.blinkSprite = sprites.blink
    obj2.smileSprite = sprites.smile
  end
end
function blockCollision(object1, object2, force, wasDamageDone)
  if wasDamageDone then
    local obj1 = objects.world[object1]
    local sprites = getDamageSprite(obj1, blockTable.blocks)
    local dmgSprite = sprites.sprite
    if dmgSprite ~= obj1.damageSprite then
      obj1.damageSprite = dmgSprite
      obj1.blinkSprite = sprites.blink
      obj1.smileSprite = sprites.smile
      if getObjectDefinition(object1).damageSound ~= nil then
        _G.res.playAudio(getAudioName(getObjectDefinition(object1).damageSound), 0.5, false, 2)
      end
    end
    local obj2 = objects.world[object2]
    local sprites = getDamageSprite(obj2, blockTable.blocks)
    local dmgSprite = sprites.sprite
    if dmgSprite ~= obj2.damageSprite then
      obj2.damageSprite = dmgSprite
      obj2.blinkSprite = sprites.blink
      obj2.smileSprite = sprites.smile
      if getObjectDefinition(object2).damageSound ~= nil then
        _G.res.playAudio(getAudioName(getObjectDefinition(object2).damageSound), 0.5, false, 2)
      end
    end
  end
  if force > collisionSoundForceThreshold then
    local material1 = blockTable.materials[getObjectDefinition(object1).material]
    local material2 = blockTable.materials[getObjectDefinition(object2).material]
    if material1 ~= nil then
      _G.res.playAudio(getAudioName(blockTable.materials[getObjectDefinition(object1).material].collisionSound), 0.5, false, 2)
    end
    if material2 ~= nil and material2 ~= material1 then
      _G.res.playAudio(getAudioName(blockTable.materials[getObjectDefinition(object2).material].collisionSound), 0.5, false, 2)
    end
  end
end
function addParticles(object, particle, amount, ignoreLimits, menu)
  local obj = objects.world[object]
  if obj == nil then
    return
  end
  local x, y = physicsToWorldTransform(obj.x, obj.y)
  local w, h = 1, 1
  if obj.radius == nil then
    w, h = physicsToWorldTransform(obj.width, obj.height)
  else
    w, h = physicsToWorldTransform(obj.radius * 2, obj.radius * 2)
  end
  if particle[1] then
    for i = 1, #particle do
      if particleTable.particles[particle[i]].amount then
        amount = particleTable.particles[particle[i]].amount
      end
      newParticles(particle[i], amount, x, y, w, h, getAngle(obj.name), ignoreLimits, menu)
    end
  else
    newParticles(particle, amount, x, y, w, h, getAngle(obj.name), ignoreLimits, menu)
  end
end
function globeBirdDeath(object)
  local name = "GlobeDeath"
  local def = getObjectDefinition(object.name)
  createCircle(name, def.sprite, object.x, object.y, def.radius * (object.powerup_scale or 1), 1.0E-6, 0, def.restitution, object.controllable, object.z_order)
  objects.world[name].definition = object.definition
  objects.world[name].controllable = def.controllable
  objects.world[name].strength = def.strength
  objects.world[name].defence = def.defence
  objects.world[name].material = def.material
  objects.world[name].levelGoal = def.levelGoal
  objects.world[name].damageFactors = def.damageFactors
  objects.world[name].isPuffed = true
  local xp, yp = _G.res.getSpritePivot("", def.sprite)
  objects.world[name].spritePivotX = xp
  objects.world[name].spritePivotY = yp
  objects.world[name].damageSprite = def.damageSprite
  objects.world[name].useLegacyCollisionPath = def.useLegacyCollisionPath
  objects.world[name].shot = true
  objects.world[name].isGlobeDeath = true
  objects.world[name].updateCount = 0
  objects.world[name].deathTimerFull = 1.5
  objects.world[name].deathTimer = object.deathTimer or objects.world[name].deathTimerFull
  objects.world[name].scale = object.powerup_scale or 1
  objects.world[name].directionChangeTimer = object.directionChangeTimer or 0
  objects.world[name].xVel = object.xVel
  objects.world[name].yVel = object.yVel
  objects.world[name].powerup_scale = object.powerup_scale
  setRotation(name, object.angle)
  setVelocity(name, object.xVel, object.yVel)
  setObjectParameter(name, 5, object.powerup_scale or 1)
  setObjectParameter(name, 6, 1)
  birds[name] = objects.world[name]
  local k = object.name
  if cameraTargetObject == object then
    cameraTargetObject = nil
  end
  if currentBirdName == k then
    currentBirdName = nil
  end
  if flyingBird == object then
    flyingBird = nil
    birdSpecialtyAvailable = false
  end
  removeObject(k)
  objects.world[k] = nil
  birds[k] = nil
  otherBirds[k] = nil
  _G.res.playAudio(getAudioName(def.removeSound), 1, false)
end
function removeBird(object, nosound, amount)
  nosound = nosound or false
  amount = amount or 10
  local k = object.name
  local globeDeath = object.finalGlobe == true
  local particles = getObjectDefinition(k)
  if particles ~= nil then
    particles = particles.particles
  end
  if globeDeath then
    globeBirdDeath(object)
    return
  end
  if particles ~= nil and amount > 0 then
    addParticles(k, getObjectDefinition(k).particles, amount, false, globeDeath)
  end
  if cameraTargetObject == object then
    cameraTargetObject = nil
  end
  if currentBirdName == k then
    currentBirdName = nil
  end
  if flyingBird == object then
    flyingBird = nil
    birdSpecialtyAvailable = false
  end
  removeObject(k)
  objects.world[k] = nil
  birds[k] = nil
  otherBirds[k] = nil
  if not nosound then
    _G.res.playAudio(getAudioName("bird_destroyed"), 1, false)
  end
end
function getObjectDefinition(name)
  if objects.world[name] == nil then
    print(_G.debug.traceback())
  end
  return blockTable.blocks[objects.world[name].definition]
end
function getNextBird(index)
  for k, v in _G.pairs(birds) do
    if v.controllable and v.startNumber == index then
      return k
    end
  end
  return nil
end
function checkLevelComplete()
  if eagleBaitLaunched == true and (eagleTimer == nil or eagleTimer > 0) then
    return false
  end
  for k, v in _G.pairs(levelGoals) do
    if v.levelGoal then
      return false
    end
  end
  if not levelTimeout and hasMovingObjects and objects.doNotWaitForMovingObjects ~= true and not g_skip_wait_for_moving_objects then
    return false
  end
  return true
end
function checkLevelGoalsDestroyed()
  for k, v in _G.pairs(levelGoals) do
    if v.levelGoal then
      return false
    end
  end
  return true
end
function checkLevelFailed()
  if g_bird_quake then
    return false
  end
  if not levelTimeout then
    if hasMovingObjects and objects.doNotWaitForMovingObjects ~= true then
      return false
    end
    for k, v in _G.pairs(birds) do
      if v.controllable then
        return false
      end
    end
  end
  if g_currentChallenge and g_currentChallenge.type == "BIRD_FLOCK" and #g_currentChallengeProgress.shotsQueue > 0 then
    return false
  end
  return true
end
function getDamageSprite(object, definitions)
  local sprites = {}
  sprites.sprite = object.sprite
  sprites.blink = object.sprite
  sprites.smile = object.sprite
  if object.definition == nil or object.definition == "" then
    return sprites
  end
  if definitions[object.definition] == nil then
    return sprites
  end
  if definitions[object.definition].damageSprites == nil then
    return sprites
  end
  if object.strength == nil then
    return sprites
  end
  local percentage = object.strength / definitions[object.definition].strength * 100
  for k, v in _G.pairs(definitions[object.definition].damageSprites) do
    if percentage > v.min and percentage <= v.max then
      setSprite(object.name, v.sprite)
      sprites.sprite = v.sprite
      sprites.blink = v.sprite
      sprites.smile = v.sprite
      if v.blinkSprite ~= nil then
        sprites.blink = v.blinkSprite
      end
      if v.smileSprite ~= nil then
        sprites.smile = v.smileSprite
      end
      return sprites
    end
  end
  return sprites
end
function makeExplosion(object, definition, sound)
  if definition.explosionForce ~= nil then
    if sound ~= nil then
      _G.res.playAudio(sound, 0.7, false, 1)
    end
    addParticles(object.name, "explosion", 1, true, false)
    addParticles(object.name, "explosionBuff", 1, true, false)
    for k, v in _G.pairs(objects.world) do
      if v.controllable or object == v then
      else
        local dist = vLength(v.x - object.x, v.y - object.y)
        if dist < definition.explosionRadius then
          local x, y = vNormalize(v.x - object.x, v.y - object.y)
          local force = physicsScale * definition.explosionForce / dist
          applyImpulse(k, x * force, y * force, v.x, v.y)
        end
        if dist < definition.explosionDamageRadius and v.defence < definition.explosionDamage / dist then
          v.strength = v.strength - definition.explosionDamage / dist
          local sprites = getDamageSprite(v, blockTable.blocks)
          v.damageSprite = sprites.sprite
          v.blinkSprite = sprites.blink
          v.smileSprite = sprites.smile
          if v.strength <= 0 then
            deadBlocks[k] = v
          end
        end
      end
    end
  end
end
function makeClickExplosion(objectX, objectY, explosionForce, explosionRadius, explosionDamage, explosionDamageRadius, sound)
  if sound ~= nil then
    _G.res.playAudio(sound, 0.7, false, 1)
  end
  local wx, wy = physicsToWorldTransform(objectX, objectY)
  newParticles("explosion", 1, wx, wy, 4, 4, 0, false, false)
  newParticles("explosionBuff", 1, wx, wy, 4, 4, 0, false, false)
  for k, v in _G.pairs(objects.world) do
    local dist = vLength(v.x - objectX, v.y - objectY)
    local x, y = vNormalize(v.x - objectX, v.y - objectY)
    if explosionRadius > dist then
      local force = physicsScale * explosionForce / dist
      applyImpulse(k, x * force, y * force, v.x, v.y)
    end
    if explosionDamageRadius > dist and v.defence ~= nil and v.defence < explosionDamage / dist then
      v.strength = v.strength - explosionDamage / dist
      local sprites = getDamageSprite(v, blockTable.blocks)
      v.damageSprite = sprites.sprite
      v.blinkSprite = sprites.blink
      v.smileSprite = sprites.smile
    end
  end
end
function worldToPhysicsTransform(x, y)
  local px = x * physicsScale
  local py = y * physicsScale
  return px, py
end
function worldToScreenTransform(x, y)
  local sx = (x - screen.left) * worldScale
  local sy = (y - screen.top) * worldScale
  return sx, sy
end
function screenToWorldTransform(x, y)
  local wx = x / worldScale + screen.left
  local wy = y / worldScale + screen.top
  return wx, wy
end
function physicsToWorldTransform(x, y)
  local wx = x * physicsToWorld
  local wy = y * physicsToWorld
  return wx, wy
end
function physicsToScreenTransform(x, y)
  local wx, wy = physicsToWorldTransform(x, y)
  local sx, sy = worldToScreenTransform(wx, wy)
  return sx, sy
end
function screenToPhysicsTransform(x, y)
  local wx, wy = screenToWorldTransform(x, y)
  local px, py = worldToPhysicsTransform(wx, wy)
  return px, py
end
function screenToPhysicsScale(x)
  return x / worldScale * physicsScale
end
function distance(x1, y1, x2, y2)
  local dx = x2 - x1
  local dy = y2 - y1
  return _G.math.sqrt(dx * dx + dy * dy)
end
function currentTime()
  local timeNow = {
    d = _G.os.date("%d") * 1,
    h = _G.os.date("%H") * 1,
    m = _G.os.date("%M") * 1,
    s = _G.os.date("%S") * 1
  }
  return timeNow
end
function timeDiff(t2, t1)
  local temp1 = t1.h * 60 * 60 + t1.m * 60 + t1.s
  local temp2 = t2.h * 60 * 60 + t2.m * 60 + t2.s
  if t2.d ~= t1.d then
    temp2 = temp2 + 86400
  end
  return temp2 - temp1
end
function formatTime(inputTime)
  local timeText = ""
  local hours = _G.string.format("%d", _G.math.floor(inputTime / 3600))
  local minutes = _G.string.format("%d", _G.math.floor(_G.math.fmod(inputTime, 3600) / 60))
  local seconds = _G.string.format("%d", _G.math.fmod(_G.math.fmod(inputTime, 3600), 60))
  if inputTime >= 3600 then
    minutes = "00" .. minutes
    minutes = _G.string.sub(minutes, #minutes - 1, #minutes)
    seconds = "00" .. seconds
    seconds = _G.string.sub(seconds, #seconds - 1, #seconds)
    timeText = hours .. ":" .. minutes .. ":" .. seconds
  else
    seconds = "00" .. seconds
    seconds = _G.string.sub(seconds, #seconds - 1, #seconds)
    timeText = minutes .. ":" .. seconds
  end
  return timeText
end
function checkObjectBounds(x, y, width, height, angle, cursorX, cursorY)
  local cx = cursorX - x
  local cy = cursorY - y
  local tcx = cx * _G.math.cos(angle) + cy * _G.math.sin(angle)
  local tcy = -cx * _G.math.sin(angle) + cy * _G.math.cos(angle)
  local halfWidth = width * 0.5
  local halfHeight = height * 0.5
  local left = -halfWidth
  local top = -halfHeight
  local right = halfWidth
  local bottom = halfHeight
  if tcx >= left and tcx < right and tcy >= top and tcy < bottom then
    return true
  end
  return false
end
function checkPolygonObjectBounds(x, y, width, height, angle, vertices, cursorX, cursorY)
  local cx = cursorX - x
  local cy = cursorY - y
  local tcx = cx * _G.math.cos(angle) + cy * _G.math.sin(angle)
  local tcy = -cx * _G.math.sin(angle) + cy * _G.math.cos(angle)
  local tVerts = {}
  for i = 1, #vertices do
    tVerts[i] = {}
    tVerts[i].x = vertices[i].x * width - 0.5 * width
    tVerts[i].y = vertices[i].y * height - 0.5 * height
  end
  return testPointInPolygon(tcx, tcy, tVerts)
end
function checkBounds(left, top, w, h, cursorX, cursorY, angle, hanchor, vanchor)
  if hanchor and vanchor then
    if hanchor == "HCENTER" then
      left = left - w * 0.5
    elseif hanchor == "LEFT" then
      left = left + w
    elseif hanchor == "RIGHT" then
      left = left - w
    end
    if vanchor == "VCENTER" then
      top = top - h * 0.5
    elseif vanchor == "TOP" then
      top = top + h
    elseif vanchor == "BOTTOM" then
      top = top - h
    end
  end
  if cursorX >= left and cursorX < left + w and cursorY >= top and cursorY < top + h then
    return true
  end
  return false
end
function checkTextBounds(textGroup, text, hanchor, vanchor, x, y, cursorX, cursorY)
  local w = _G.res.getStringWidth(_G.res.getString(textGroup, text))
  local h = _G.res.getFontLeading()
  if hanchor == nil then
    x = x - w * 0.5
  elseif hanchor == "RIGHT" then
    x = x - w
  elseif hanchor == "HCENTER" then
    x = x - w * 0.5
  end
  if vanchor == nil then
    y = y - h * 0.5
  elseif vanchor == "BOTTOM" then
    y = y - h
  elseif vanchor == "VCENTER" then
    y = y - h * 0.5
  end
  return checkBounds(x, y, w, h, cursorX, cursorY)
end
function checkSpriteBounds(sheet, sprite, x, y, cursorX, cursorY)
  local w, h = _G.res.getSpriteBounds(sheet, sprite)
  local px, py = _G.res.getSpritePivot(sheet, sprite)
  return checkBounds(x - px, y - py, w, h, cursorX, cursorY)
end
function getObjectsInsideRect(x1, y1, x2, y2)
  if x2 < x1 then
    x1, x2 = x2, x1
  end
  if y2 < y1 then
    y1, y2 = y2, y1
  end
  local t = {}
  for k, v in _G.pairs(objects.world) do
    x, y = physicsToWorldTransform(v.x, v.y)
    if x1 < x and x2 >= x and y1 < y and y2 >= y and v.name ~= "ground" then
      _G.table.insert(t, v)
    end
  end
  return t
end
function getThemeObjectsInsideRect(x1, y1, x2, y2, layer)
  if x2 < x1 then
    x1, x2 = x2, x1
  end
  if y2 < y1 then
    y1, y2 = y2, y1
  end
  local t = {}
  for k, v in _G.pairs(themeSpriteObjects) do
    x, y = physicsToWorldTransform(v.x, v.y)
    if v.layer == layer and x1 < x and x2 >= x and y1 < y and y2 >= y then
      _G.table.insert(t, v)
    end
  end
  return t
end
function testPointInPolygon(x, y, vertices)
  local s = #vertices
  local e = 1
  local counter = 0
  while e <= #vertices do
    if y > _G.math.min(vertices[s].y, vertices[e].y) and y <= _G.math.max(vertices[s].y, vertices[e].y) and x <= _G.math.max(vertices[s].x, vertices[e].x) and vertices[s].y ~= vertices[e].y then
      local crossPointX = (y - vertices[s].y) * (vertices[e].x - vertices[s].x) / (vertices[e].y - vertices[s].y) + vertices[s].x
      if vertices[s].x == vertices[e].x or x < crossPointX then
        counter = counter + 1
      end
    end
    s = e
    e = e + 1
  end
  if counter % 2 == 0 then
    return false
  end
  return true
end
function dampedSpring(ks, kd, r, v)
  return ks * r - kd * v
end
function signed2DTriArea(aX, aY, bX, bY, cX, cY)
  return (aX - cX) * (bY - cY) - (aY - cY) * (bX - cX)
end
function test2DSegmentSegment(aX, aY, bX, bY, cX, cY, dX, dY, findPoint)
  local instersectionValue, intersectionPoint
  local a1 = signed2DTriArea(aX, aY, bX, bY, dX, dY)
  local a2 = signed2DTriArea(aX, aY, bX, bY, cX, cY)
  if a1 ~= 0 and a2 ~= 0 and a1 * a2 < 0 then
    local a3 = signed2DTriArea(cX, cY, dX, dY, aX, aY)
    local a4 = a3 + a2 - a1
    if a3 ~= 0 and a4 ~= 0 and a3 * a4 < 0 then
      if findPoint == true then
        intersectionValue = a3 / (a3 - a4)
        intersectionPoint = {
          x = aX + intersectionValue * (bX - aX),
          y = aY + intersectionValue * (bY - aY)
        }
      end
      return true, instersectionValue, intersectionPoint
    end
  end
  return false
end
function vLength(x, y)
  local len = _G.math.sqrt(x * x + y * y)
  return len
end
function vLengthsq(x, y)
  local len = x * x + y * y
  return len
end
function vNormalize(x, y)
  local len = _G.math.sqrt(x * x + y * y)
  return x / len, y / len
end
function updateFloatingScores(dt)
  local i = 1
  while i <= #floatingScores do
    local fs = floatingScores[i]
    fs.time = fs.time + dt
    if fs.time < 0.25 then
      fs.xs = fs.maxScale * fs.time / 0.25
    elseif fs.time < fs.lifetime - 0.25 then
      fs.xs = fs.maxScale
    else
      fs.xs = fs.maxScale * (fs.lifetime - fs.time) / 0.25
    end
    if floatingScores[i].time > floatingScores[i].lifetime then
      _G.table.remove(floatingScores, i)
    else
      i = i + 1
    end
  end
end
function newParticles(type, amount, x, y, w, h, angle, ignoreLimits, menu)
  local pt = particleTable.particles[type]
  if pt == nil then
    return
  end
  if type == nil or type == "" then
    return
  end
  _G.particles.addParticles(type, amount, x, y, w, h, angle, ignoreLimits, menu)
end
function drawBox(borderSprites, sheet, x1, y1, width, height, hAnchor, vAnchor, color)
  local boxSprites = borderSprites
  local r, g, b, a = 1, 1, 1, 1
  if color ~= nil then
    if color.red ~= nil then
      r = color.red
    end
    if color.green ~= nil then
      g = color.green
    end
    if color.blue ~= nil then
      b = color.blue
    end
    if color.alpha ~= nil then
      a = color.alpha
    end
  end
  local x2 = x1 + width - 1
  local y2 = y1 + height - 1
  local thTopMiddle = 0
  local twMiddleLeft = 0
  local twMiddleRight = 0
  local thBottomMiddle = 0
  if boxSprites.topLeft == nil then
    boxSprites.topLeft = ""
  end
  if boxSprites.topRight == nil then
    boxSprites.topRight = ""
  end
  if boxSprites.bottomLeft == nil then
    boxSprites.bottomLeft = ""
  end
  if boxSprites.bottomRight == nil then
    boxSprites.bottomRight = ""
  end
  if boxSprites.center == nil then
    boxSprites.center = ""
  end
  if boxSprites.topMiddle ~= nil then
    _, thTopMiddle = _G.res.getSpriteBounds(sheet, boxSprites.topMiddle)
  else
    boxSprites.topMiddle = ""
  end
  if boxSprites.left ~= nil then
    twMiddleLeft, _ = _G.res.getSpriteBounds(sheet, boxSprites.left)
  else
    boxSprites.left = ""
  end
  if boxSprites.right ~= nil then
    twMiddleRight, _ = _G.res.getSpriteBounds(sheet, boxSprites.right)
  else
    boxSprites.right = ""
  end
  if boxSprites.bottomMiddle ~= nil then
    _, thBottomMiddle = _G.res.getSpriteBounds(sheet, boxSprites.bottomMiddle)
  else
    boxSprites.bottomMiddle = ""
  end
  local xPivot, yPivot = 0, 0
  if hAnchor == "HCENTER" then
    xPivot = -width / 2
  elseif hAnchor == "RIGHT" then
    xPivot = -width
  else
    xPivot = 0
  end
  if vAnchor == "VCENTER" then
    yPivot = -height / 2
  elseif vAnchor == "BOTTOM" then
    yPivot = -height
  else
    yPivot = 0
  end
  local drawSprite = _G.res.drawSprite
  local floor = _G.math.floor
  if floor(y1 - thTopMiddle + yPivot) <= screenHeight and floor(y1 + height + yPivot + thBottomMiddle) >= 0 then
    drawSprite(sheet, boxSprites.topMiddle, floor(x1 + xPivot), floor(y1 - thTopMiddle + yPivot), "TOP", "LEFT", floor(width), floor(thTopMiddle))
    drawSprite(sheet, boxSprites.bottomMiddle, floor(x1 + xPivot), floor(y1 + height + yPivot), "TOP", "LEFT", floor(width), floor(thBottomMiddle))
    drawSprite(sheet, boxSprites.left, floor(x1 - twMiddleLeft + xPivot), floor(y1 + yPivot), "TOP", "LEFT", floor(twMiddleLeft), floor(height))
    drawSprite(sheet, boxSprites.right, floor(x1 + width + xPivot), floor(y1 + yPivot), "TOP", "LEFT", floor(twMiddleRight), floor(height))
    drawSprite(sheet, boxSprites.topLeft, floor(x1 + xPivot), floor(y1 + yPivot), "BOTTOM", "RIGHT")
    drawSprite(sheet, boxSprites.topRight, floor(x1 + width + xPivot), floor(y1 + yPivot), "BOTTOM", "LEFT")
    drawSprite(sheet, boxSprites.bottomLeft, floor(x1 + xPivot), floor(y1 + height + yPivot), "TOP", "RIGHT")
    drawSprite(sheet, boxSprites.bottomRight, floor(x1 + width + xPivot), floor(y1 + height + yPivot), "TOP", "LEFT")
    if color ~= nil then
      drawRect(r, g, b, a, floor(x1 + xPivot), floor(y1 + yPivot), floor(x2 + xPivot), floor(y2 + yPivot), false)
    else
      drawSprite(sheet, boxSprites.center, floor(x1 + xPivot), floor(y1 + yPivot), "TOP", "LEFT", floor(width), floor(height))
    end
  end
end
function createPopupBoxSpriteTables()
  popupBoxSprites = {
    topLeft = "POPUP_TOP_LEFT",
    topMiddle = "POPUP_TOP_MIDDLE",
    topRight = "POPUP_TOP_RIGHT",
    left = "POPUP_LEFT",
    center = "POPUP_CENTER",
    right = "POPUP_RIGHT",
    bottomLeft = "POPUP_BOTTOM_LEFT",
    bottomMiddle = "POPUP_BOTTOM_MIDDLE",
    bottomRight = "POPUP_BOTTOM_RIGHT"
  }
  completeBoxSprites = {
    topLeft = "COMPLETE_TOP_LEFT",
    topMiddle = "COMPLETE_TOP_MIDDLE",
    topRight = "COMPLETE_TOP_RIGHT",
    left = "COMPLETE_LEFT",
    center = "COMPLETE_CENTER",
    right = "COMPLETE_RIGHT"
  }
  whiteBoxSprites = {
    topLeft = "WHITE_TOP_LEFT",
    topMiddle = "WHITE_TOP_MIDDLE",
    topRight = "WHITE_TOP_RIGHT",
    left = "WHITE_LEFT",
    center = "WHITE_CENTER",
    right = "WHITE_RIGHT",
    bottomLeft = "WHITE_BOTTOM_LEFT",
    bottomMiddle = "WHITE_BOTTOM_MIDDLE",
    bottomRight = "WHITE_BOTTOM_RIGHT"
  }
  tutorialBoxSprites = {
    topLeft = "TUTORIAL_TOP_LEFT",
    topMiddle = "TUTORIAL_TOP_MIDDLE",
    topRight = "TUTORIAL_TOP_RIGHT",
    left = "TUTORIAL_LEFT",
    center = "TUTORIAL_CENTER",
    right = "TUTORIAL_RIGHT",
    bottomLeft = "TUTORIAL_BOTTOM_LEFT",
    bottomMiddle = "TUTORIAL_BOTTOM_MIDDLE",
    bottomRight = "TUTORIAL_BOTTOM_RIGHT"
  }
  blackBoxSprites = {
    topLeft = "UPSELL_TOP_LEFT",
    topMiddle = "UPSELL_TOP_MIDDLE",
    topRight = "UPSELL_TOP_RIGHT",
    left = "UPSELL_LEFT",
    center = "UPSELL_CENTER",
    right = "UPSELL_RIGHT",
    bottomLeft = "UPSELL_BOTTOM_LEFT",
    bottomMiddle = "UPSELL_BOTTOM_MIDDLE",
    bottomRight = "UPSELL_BOTTOM_RIGHT"
  }
  scoreBox = {
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
  achievementBoxSprites = {
    left = "ACHIEVEMENT_BG_LEFT",
    center = "ACHIEVEMENT_BG_MIDDLE",
    right = "ACHIEVEMENT_BG_RIGHT"
  }
  playBoxSprites = {
    left = "PLAY_BUTTON_BG_LEFT",
    center = "PLAY_BUTTON_BG_MIDDLE",
    right = "PLAY_BUTTON_BG_RIGHT"
  }
end
function calculatePlaytime()
  if playtimeCounter == nil then
    playtimeCounter = 0
  end
  settingsWrapper:addPlaytime(playtimeCounter)
  playtimeCounter = 0
end
function resetCamerasiPhone4()
  local ccd = objects.castleCameraData[deviceModel]
  if ccd.screenWidth == nil then
    ccd.screenWidth = 1680
  end
  if ccd.screenHeight == nil then
    ccd.screenHeight = 1050
  end
  local cameraAspectRation = ccd.screenWidth / ccd.screenHeight
  local currentAspectRation = screenWidth / screenHeight
  local tempCcd = {}
  if cameraAspectRation <= currentAspectRation then
    tempCcd.sx = originalCcd.sx * screenHeight / ccd.screenHeight
  else
    tempCcd.sx = originalCcd.sx * screenWidth / ccd.screenWidth
  end
  tempWorldScale = worldScale * (tempCcd.sx / ccd.sx)
  setWorldScale(tempWorldScale)
end
function resolutionChanged(width, height)
  if not g_levelLoaded or deviceModel == "iphone4" or deviceModel == "ipad3" then
    return
  end
  local cameraFunctionTemp = cameraFunction
  local cameraAnimationSliderTemp = cameraAnimationSlider
  local cameraAnimationSliderTargetTemp = cameraAnimationSliderTarget
  local screenWidthTemp = screenWidth
  local screenHeightTemp = screenHeight
  local worldScaleTemp = worldScale
  local animationWorldScaleTemp = animationWorldScale
  worldScale = worldScaleTemp
  animationWorldScale = animationWorldScaleTemp
  setWorldScale(worldScale)
  local ratio = width / screenWidth
  screenWidth = width
  screenHeight = height
  objects.castleCameraData[deviceModel].px = originalCcd.px
  objects.castleCameraData[deviceModel].py = originalCcd.py
  objects.castleCameraData[deviceModel].sx = originalCcd.sx
  objects.castleCameraData[deviceModel].sy = originalCcd.sy
  objects.castleCameraData[deviceModel].screenWidth = originalCcd.screenWidth
  objects.castleCameraData[deviceModel].screenHeight = originalCcd.screenHeight
  objects.birdCameraData[deviceModel].px = originalBcd.px
  objects.birdCameraData[deviceModel].py = originalBcd.py
  objects.birdCameraData[deviceModel].sx = originalBcd.sx
  objects.birdCameraData[deviceModel].sy = originalBcd.sy
  objects.birdCameraData[deviceModel].screenWidth = originalBcd.screenWidth
  objects.birdCameraData[deviceModel].screenHeight = originalBcd.screenHeight
  initCameras()
  cameraFunction = cameraFunctionTemp
  cameraAnimationSlider = cameraAnimationSliderTemp
  cameraAnimationSliderTarget = cameraAnimationSliderTargetTemp
  worldScale = worldScaleTemp * ratio
  animationWorldScale = animationWorldScaleTemp * ratio
  setWorldScale(worldScale)
  cameraFunction(0)
  screenWidth = screenWidthTemp
  screenHeight = screenHeightTemp
end
originalCcd = {}
originalBcd = {}
function initCameras()
  cameraFunction = levelStartCamera
  eventManager:notify({
    id = events.EID_BEFORE_CAMERAS_INITIALISED
  })
  if objects.castleCameraData ~= nil then
    local cameraSelected = false
    for i = 1, #g_cameraProfileList do
      local cameraProfile = g_cameraProfileList[i]
      if objects.castleCameraData[cameraProfile] ~= nil then
        cameraSelected = true
        if cameraProfile ~= deviceModel then
          objects.castleCameraData[deviceModel] = {}
          objects.castleCameraData[deviceModel].px = objects.castleCameraData[cameraProfile].px
          objects.castleCameraData[deviceModel].py = objects.castleCameraData[cameraProfile].py
          objects.castleCameraData[deviceModel].sx = objects.castleCameraData[cameraProfile].sx
          objects.castleCameraData[deviceModel].sy = objects.castleCameraData[cameraProfile].sy
          objects.castleCameraData[deviceModel].screenWidth = objects.castleCameraData[cameraProfile].screenWidth
          objects.castleCameraData[deviceModel].screenHeight = objects.castleCameraData[cameraProfile].screenHeight
        end
        print("--using camera profile: " .. _G.tostring(cameraProfile) .. "\n")
        break
      end
    end
    if cameraSelected == false then
      if objects.castleCameraData.px ~= nil then
        objects.castleCameraData[deviceModel] = {}
        objects.castleCameraData[deviceModel].px = objects.castleCameraData.px
        objects.castleCameraData[deviceModel].py = objects.castleCameraData.py
        objects.castleCameraData[deviceModel].sx = objects.castleCameraData.sx
        objects.castleCameraData[deviceModel].sy = objects.castleCameraData.sy
        objects.castleCameraData[deviceModel].screenWidth = objects.castleCameraData.screenWidth
        objects.castleCameraData[deviceModel].screenHeight = objects.castleCameraData.screenHeight
      else
        objects.castleCameraData[deviceModel] = {}
        objects.castleCameraData[deviceModel].px = screen.x
        objects.castleCameraData[deviceModel].py = screen.y
        objects.castleCameraData[deviceModel].sx = 1
        objects.castleCameraData[deviceModel].sy = 1
        objects.castleCameraData[deviceModel].screenWidth = screenWidth
        objects.castleCameraData[deviceModel].screenHeight = screenHeight
      end
    end
    local ccd = objects.castleCameraData[deviceModel]
    if ccd.screenWidth == nil then
      ccd.screenWidth = 1680
    end
    if ccd.screenHeight == nil then
      ccd.screenHeight = 1050
    end
    originalCcd.px = ccd.px
    originalCcd.py = ccd.py
    originalCcd.sx = ccd.sx
    originalCcd.sy = ccd.sy
    originalCcd.screenWidth = ccd.screenWidth
    originalCcd.screenHeight = ccd.screenHeight
    local cameraAspectRation = ccd.screenWidth / ccd.screenHeight
    local currentAspectRation = screenWidth / screenHeight
    if cameraAspectRation <= currentAspectRation or startedFromEditor == true then
      ccd.sx = ccd.sx * screenHeight / ccd.screenHeight
      ccd.sy = ccd.sy * screenHeight / ccd.screenHeight
    else
      ccd.sx = ccd.sx * screenWidth / ccd.screenWidth
      ccd.sy = ccd.sy * screenWidth / ccd.screenWidth
    end
    if objects.castleCameraData.version == nil then
      worldScale = ccd.sx
      setWorldScale(worldScale)
      screen.left = ccd.px - screenWidth * 0.5
      screen.top = ccd.py - screenHeight * 0.5
      screen.right = screen.left + screenWidth / worldScale
      screen.bottom = screen.top + screenHeight / worldScale
      screen.x = (screen.right + screen.left) * 0.5
      screen.y = (screen.bottom + screen.top) * 0.5
      ccd.px = screen.x
      ccd.py = screen.y
    else
      worldScale = ccd.sx
      setWorldScale(worldScale)
      screen.x = ccd.px
      screen.y = ccd.py
      screen.left = screen.x - screenWidth * 0.5 / worldScale
      screen.top = screen.y - screenHeight * 0.5 / worldScale
      screen.right = screen.x + screenWidth * 0.5 / worldScale
      screen.bottom = screen.y + screenHeight * 0.5 / worldScale
    end
  else
    objects.castleCameraData = {}
    objects.castleCameraData[deviceModel] = {}
    local ccd = objects.castleCameraData[deviceModel]
    ccd.sx = 1
    ccd.sy = 1
    ccd.px = screen.x
    ccd.py = screen.y
  end
  local ccd = objects.castleCameraData[deviceModel]
  ccd.top = screen.top
  ccd.left = screen.left
  ccd.right = screen.right
  ccd.bottom = screen.bottom
  cameraAnimationSlider = 1
  cameraAnimationSliderTarget = 1
  defaultCamera()
  local wx1, _ = worldToPhysicsTransform(ccd.left, ccd.top)
  local wx2, _ = worldToPhysicsTransform(ccd.right, ccd.bottom)
  if objects.birdCameraData ~= nil then
    local cameraSelected = false
    for i = 1, #g_cameraProfileList do
      local cameraProfile = g_cameraProfileList[i]
      if objects.birdCameraData[cameraProfile] ~= nil then
        cameraSelected = true
        if cameraProfile ~= deviceModel then
          objects.birdCameraData[deviceModel] = {}
          objects.birdCameraData[deviceModel].px = objects.birdCameraData[cameraProfile].px
          objects.birdCameraData[deviceModel].py = objects.birdCameraData[cameraProfile].py
          objects.birdCameraData[deviceModel].sx = objects.birdCameraData[cameraProfile].sx
          objects.birdCameraData[deviceModel].sy = objects.birdCameraData[cameraProfile].sy
          objects.birdCameraData[deviceModel].screenWidth = objects.birdCameraData[cameraProfile].screenWidth
          objects.birdCameraData[deviceModel].screenHeight = objects.birdCameraData[cameraProfile].screenHeight
        end
        break
      end
    end
    if cameraSelected == false then
      if objects.birdCameraData.px ~= nil then
        objects.birdCameraData[deviceModel] = {}
        objects.birdCameraData[deviceModel].px = objects.birdCameraData.px
        objects.birdCameraData[deviceModel].py = objects.birdCameraData.py
        objects.birdCameraData[deviceModel].sx = objects.birdCameraData.sx
        objects.birdCameraData[deviceModel].sy = objects.birdCameraData.sy
        objects.birdCameraData[deviceModel].screenWidth = objects.birdCameraData.screenWidth
        objects.birdCameraData[deviceModel].screenHeight = objects.birdCameraData.screenHeight
      else
        objects.birdCameraData[deviceModel] = {}
        objects.birdCameraData[deviceModel].px = screen.x
        objects.birdCameraData[deviceModel].py = screen.y
        objects.birdCameraData[deviceModel].sx = 1
        objects.birdCameraData[deviceModel].sy = 1
        objects.birdCameraData[deviceModel].screenWidth = screenWidth
        objects.birdCameraData[deviceModel].screenHeight = screenHeight
      end
    end
    local bcd = objects.birdCameraData[deviceModel]
    if bcd.screenWidth == nil then
      bcd.screenWidth = 1680
    end
    if bcd.screenHeight == nil then
      bcd.screenHeight = 1050
    end
    originalBcd.px = bcd.px
    originalBcd.py = bcd.py
    originalBcd.sx = bcd.sx
    originalBcd.sy = bcd.sy
    originalBcd.screenWidth = bcd.screenWidth
    originalBcd.screenHeight = bcd.screenHeight
    local cameraAspectRation = bcd.screenWidth / bcd.screenHeight
    local currentAspectRation = screenWidth / screenHeight
    if cameraAspectRation <= currentAspectRation then
      bcd.sx = bcd.sx * screenHeight / bcd.screenHeight
      bcd.sy = bcd.sy * screenHeight / bcd.screenHeight
    else
      bcd.sx = bcd.sx * screenWidth / bcd.screenWidth
      bcd.sy = bcd.sy * screenWidth / bcd.screenWidth
    end
    if objects.birdCameraData.version == nil then
      scale = bcd.sx
      bcd.left = bcd.px - screenWidth * 0.5
      bcd.top = bcd.py - screenHeight * 0.5
      bcd.right = screen.left + screenWidth / scale
      bcd.bottom = screen.top + screenHeight / scale
      bcd.px = (screen.right + screen.left) * 0.5
      bcd.py = (screen.bottom + screen.top) * 0.5
    else
      bcd.left = bcd.px - screenWidth * 0.5 / bcd.sx
      bcd.top = bcd.py - screenHeight * 0.5 / bcd.sy
      bcd.right = screen.left + screenWidth / bcd.sx
      bcd.bottom = screen.top + screenHeight / bcd.sy
    end
  else
    objects.birdCameraData = {}
    objects.birdCameraData[deviceModel] = {}
    local bcd = objects.birdCameraData[deviceModel]
    bcd.sx = 1
    bcd.sy = 1
    bcd.px = screen.x
    bcd.py = screen.y
    bcd.left = bcd.px - screenWidth * 0.5
    bcd.top = bcd.py - screenHeight * 0.5
    bcd.right = screen.left + screenWidth * 0.5
    bcd.bottom = screen.top + screenHeight * 0.5
  end
  local bcd = objects.birdCameraData[deviceModel]
  ccd.screenWidth = screenWidth
  ccd.screenHeight = screenHeight
  bcd.screenWidth = screenWidth
  bcd.screenHeight = screenHeight
  leftLimit = bcd.left - screenWidth * 0.2
  rightLimit = ccd.right + screenWidth * 0.2
  local leftLimitPhysics, rightLimitPhysics = worldToPhysicsTransform(leftLimit, rightLimit)
  if rightLimitPhysics > levelRightEdge then
    levelRightEdge = rightLimitPhysics
  end
  if leftLimitPhysics < levelLeftEdge then
    levelLeftEdge = leftLimitPhysics
  end
  levelLimitMinX = levelLeftEdge - screenWidth * 0.75 * physicsScale
  levelLimitMaxX = levelRightEdge + screenWidth * 0.75 * physicsScale
  setLevelLimits(levelLimitMinX, -10000, levelLimitMaxX, 20)
  maxLevelWidth = rightLimit - leftLimit
  minWorldScale = screenWidth / maxLevelWidth
  groundLimit = bcd.bottom
  if groundLimit < ccd.bottom then
    groundLimit = ccd.bottom
  end
  groundLimit = screenHeight / (minWorldScale * 5)
  if levelRestartedFrom == nil or startedFromEditor == true then
    currentZoomedScale = bcd.sx
    if currentZoomedScale < ccd.sx then
      currentZoomedScale = ccd.sx
    end
  end
  eventManager:notify({
    id = events.EID_CAMERAS_INITIALISED
  })
end
function StringStartsWith(String, Start)
  return _G.string.sub(String, 1, _G.string.len(Start)) == Start
end
function addThemeSprite(name, attributes)
  local obj = attributes
  local spr = blockTable.blocks[obj.definition].sprite
  if not spr and blockTable.blocks[obj.definition].damageSprites then
    spr = blockTable.blocks[obj.definition].damageSprites.damage1
  end
  local t_scaleX = 1
  local t_scaleY = 1
  if obj.scale ~= nil then
    t_scaleX = obj.scale.x or 1
    t_scaleY = obj.scale.y or 1
  end
  createThemeSprite(obj.name, spr, obj.x, obj.y, t_scaleX, t_scaleY, obj.angle, obj.layer)
  themeSpriteObjects[name] = {
    x = obj.x,
    y = obj.y,
    name = obj.name,
    definition = obj.definition,
    scale = obj.scale or {x = 1, y = 1},
    angle = obj.angle,
    layer = obj.layer
  }
  local t_worldSprite = blockTable.blocks[obj.definition]
  local w, h = _G.res.getSpriteBounds("", spr)
  local sizeFactor = 0.92
  if t_worldSprite.density == 0 then
    sizeFactor = 1
  end
  w = w * physicsScale * sizeFactor
  h = h * physicsScale * sizeFactor
  themeSpriteObjects[name].type = t_worldSprite.type
  themeSpriteObjects[name].width = w
  themeSpriteObjects[name].height = h
  themeSpriteObjects[name].vertices = t_worldSprite.vertices
  if t_worldSprite.type == "circle" then
    if t_worldSprite.radius ~= nil then
      themeSpriteObjects[name].radius = t_worldSprite.radius
    elseif spr ~= "" and spr ~= nil then
      local w, h = _G.res.getSpriteBounds("", spr)
      themeSpriteObjects[name].radius = w * 0.5 * physicsScale * sizeFactor
    end
  end
end
function inAppPurchasingBecameAvailable()
  if iapEnabled ~= true then
    iapEnabled = true
    if menuManager ~= nil and menuManager:getRoot() ~= nil and menuManager:getRoot().name == "mainMenuRoot" then
      menuManager:getRoot():refreshMiddleButtons()
    end
  end
end
function enableMightyEagle()
  settingsWrapper:setMightyEagleEnabled()
end
function isEagleEnabled()
  return settingsWrapper:isMightyEagleEnabled() or isFreeEagleEnabled()
end
function isAdsOffPurchaseEnabled()
  return iapEnabled == true and deviceModel == "android" and isPremium ~= true
end
function isIapEnabled()
  if isKidsVersion or not isHDVersion and customerString == "amazon" then
    return false
  end
  return iapEnabled == true and (iOS or deviceModel == "android")
end
function showEagleUIElements()
  return (settingsWrapper:isMightyEagleEnabled() or iapEnabled == true) and not isChallengeMode() and (iOS or deviceModel == "android")
end
function showEagleScoreElements()
  return isIapEnabled() or settingsWrapper:isMightyEagleEnabled() or g_haveEagleScores or isFreeEagleEnabled()
end
function isEagleUnavailableForShot()
  local disabled = false
  local eagleUsedTimeCheck = settingsWrapper:getEagleUsedTime() ~= nil
  local highscoreCheck = highscores[levelName] == nil or (highscores[levelName].score == 0 or highscores[levelName].completed ~= true) and highscores[levelName].eagleScore == nil
  local currentLevelCheck = eagleUsedInCurrentLevel ~= true
  local timeCheck = settingsWrapper:getEagleUsedTime() ~= nil and timeDiff(currentTime(), settingsWrapper:getEagleUsedTime()) < eagleLockedTime
  if eagleUsedTimeCheck and highscoreCheck and currentLevelCheck and timeCheck then
    disabled = true
  end
  print(" ---------- isEagleUnavailableForShot == " .. _G.tostring(disabled))
  return disabled
end
function unlockFreeEagle(source)
  local free_eagle_previously_available = isFreeEagleEnabled()
  g_freeEagleUnlockStatus[source] = {one_shot = false, enabled = true}
  if not free_eagle_previously_available then
    eventManager:notify({
      id = events.EID_FREE_EAGLE_ENABLED
    })
  end
  eventManager:notify({
    id = events.EID_FREE_EAGLE_BECAME_AVAILABLE,
    source = source
  })
  print("free eagle from " .. _G.tostring(source) .. " became available\n")
end
function lockFreeEagle(source)
  if g_freeEagleUnlockStatus[source] == nil then
    return
  end
  g_freeEagleUnlockStatus[source].enabled = false
  if not isFreeEagleEnabled() then
    eventManager:notify({
      id = events.EID_FREE_EAGLE_DISABLED
    })
  end
  eventManager:notify({
    id = events.EID_FREE_EAGLE_BECAME_UNAVAILABLE,
    source = source
  })
  print("free eagle from " .. _G.tostring(source) .. " became unavailable\n")
end
function isFreeEagleEnabled()
  for _, v in _G.pairs(g_freeEagleUnlockStatus) do
    if v.enabled then
      return true
    end
  end
  return false
end
function unlockMightyEagleNFC()
  if settingsWrapper:isMightyEagleEnabled() or settingsWrapper:getEagleUsedTime() ~= nil then
    return
  end
  local event = {}
  if getMightyEagleNFCUnlockCooldown() == 0 then
    if not settingsWrapper:getNFCMeUnlocked() then
      settingsWrapper:setNFCUnlockTimer(currentTime())
    end
    settingsWrapper:setNFCMeUnlocked(true)
    settingsWrapper:setEagleUsedTime(nil)
    saveLuaFileWrapper("settings.lua", "settings", true)
    eventManager:queueEvent({
      id = events.EID_MIGHTYEAGLE_UNLOCK_ONCE,
      text = "ME_NFC_UNLOCK_SUCCESFULL"
    })
  else
    local timeDiff = getMightyEagleNFCUnlockCooldown()
    eventManager:queueEvent({
      id = events.EID_MIGHTY_EAGLE_UNLOCK_ONCE_COOLDOWN,
      text = "ME_NFC_UNLOCK_CD" .. formatTime(timeDiff)
    })
  end
end
function getMightyEagleNFCUnlockCooldown()
  if not settingsWrapper:getNFCUnlockTimer() then
    return 0
  else
    local timeDiff = NFCUnlockTime - timeDiff(currentTime(), settingsWrapper:getNFCUnlockTimer())
    timeDiff = _G.math.max(0, timeDiff)
    return timeDiff
  end
end
function stopIngameSounds()
  _G.res.stopAudio(currentMusic)
  _G.res.stopAudio("wood_rolling")
  _G.res.stopAudio("rock_rolling")
  _G.res.stopAudio("light_rolling")
end
function getStarCount(level, score)
  if score >= starTable[level].goldScore then
    return 3
  elseif score >= starTable[level].silverScore then
    return 2
  end
  return 1
end
function checkChallengeUnlockCondition(challenge)
  if challenge.unlockCondition.date ~= nil then
    local time = _G.os.date("*t")
    if challenge.unlockCondition.date.y > time.year then
      return false
    elseif challenge.unlockCondition.date.y < time.year then
    elseif challenge.unlockCondition.date.m > time.month then
      return false
    elseif challenge.unlockCondition.date.m < time.month then
    elseif challenge.unlockCondition.date.d > time.day then
      return false
    end
  end
  return true
end
function getNextChallengeUnlockCountdown()
  local next
  for _, v in _G.pairs(g_challenges) do
    if not checkChallengeUnlockCondition(v) and v.unlockCondition.date then
      if next == nil then
        next = v
      elseif v.unlockCondition.date.y < next.unlockCondition.date.y then
        next = v
      elseif v.unlockCondition.date.y == next.unlockCondition.date.y and v.unlockCondition.date.m < next.unlockCondition.date.m then
        next = v
      elseif v.unlockCondition.date.y == next.unlockCondition.date.y and v.unlockCondition.date.m == next.unlockCondition.date.m and v.unlockCondition.date.d < next.unlockCondition.date.d then
        next = v
      end
    end
  end
  if next ~= nil then
    local now = getCurrentTime()
    local diff = getTimeDifference({
      year = next.unlockCondition.date.y,
      month = next.unlockCondition.date.m,
      day = next.unlockCondition.date.d
    }, now)
    if diff.days > 0 then
      return _G.string.format("%u:%02u:%02u:%02u", diff.days, diff.hours, diff.minutes, diff.seconds)
    elseif 0 < diff.hours then
      return _G.string.format("%u:%02u:%02u", diff.hours, diff.minutes, diff.seconds)
    else
      return _G.string.format("%u:%02u", diff.minutes, diff.seconds)
    end
  end
  return nil
end
function getUnviewedChallengesCount()
  local unviewedCount = 0
  for i = 1, #g_challenges do
    if checkChallengeUnlockCondition(g_challenges[i]) then
      local id = g_challenges[i].id
      if highscores[id] ~= nil then
        if highscores[id].viewed ~= true then
          unviewedCount = unviewedCount + 1
        end
      else
        unviewedCount = unviewedCount + 1
      end
    end
  end
  return unviewedCount
end
function logwarning(s)
  print("WARNING: " .. _G.tostring(s) .. "\n")
end
function logerror(s)
  print("ERROR: " .. _G.tostring(s) .. "\n")
end
function loginfo(s)
  print("INFO: " .. _G.tostring(s) .. "\n")
end
function keyCombination(a, b)
  return (not keyHold[a] or not keyPressed[b]) and keyPressed[a] and keyHold[b]
end
function isRetinaGraphicsEnabled()
  return (deviceModel == "iphone4" or deviceModel == "ipad3") and (changeResolution ~= true and wantedResolution == "FULL" or changeResolution == true and wantedResolution == "HALF")
end
function updateAvailable(isUpdateAvailable)
  print("<Updater> update available: " .. _G.tostring(isUpdateAvailable) .. "\n")
  g_updateAvailable = isUpdateAvailable
  if isUpdateAvailable then
    eventManager:notify({
      id = events.EID_UPDATE_AVAILABLE
    })
  end
end
function useAds()
  return deviceModel == "android" and not settingsWrapper:isPremium()
end
filename = "gamelogic.lua"
