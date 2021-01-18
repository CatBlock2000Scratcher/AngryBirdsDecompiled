SubSystem = {}
function SubSystem:new(o)
  o = o or {}
  o.children = {}
  o.x = o.x or 0
  o.y = o.y or 0
  o.name = o.name or "UNDEFINED"
  _G.setmetatable(o, self)
  self.__index = self
  o:init()
  return o
end
function SubSystem:update(dt)
end
function SubSystem:init()
end
LinkListener = SubSystem:new()
function LinkListener:eventTriggered(event)
  local events = gamelua.events
  if event.id == events.EID_GIFT_PURCHASE_CLICKED then
    gamelua.logFlurryEvent("Apple gift purchase link clicked")
    gamelua.openURL(gamelua.APPLE_GIFT_PURCHASE_URL)
  end
  if event.id == events.EID_LENOVO_ADFREE_CLICKED then
    gamelua.logFlurryEvent("Lenovo no ads link clicked")
    gamelua.openURL(gamelua.LENOVO_NO_ADS_URL)
  end
  if event.id == events.EID_AB_SHOP_CLICKED then
    gamelua.logFlurryEvent("ABshop link clicked")
    gamelua.openURL(gamelua.ABSHOP_URL)
  end
  if event.id == events.EID_ALEX_CLICKED then
    gamelua.openURL(gamelua.ALEX_URL)
  end
  if event.id == events.EID_MIGHTY_EAGLE_TRAILER_CLICKED then
    gamelua.openURL(gamelua.MIGHTY_EAGLE_TRAILER)
    if gamelua.cheatsEnabled then
      gamelua.enableMightyEagle()
    end
  end
  if event.id == events.EID_NEWSLETTER_CLICKED then
    gamelua.logFlurryEvent("Newsletter link clicked")
    gamelua.openURL(gamelua.NEWSLETTER_URL)
  end
  if event.id == events.EID_SEASONS_CLICKED then
    gamelua.logFlurryEvent("Halloween link clicked")
    gamelua.openURL(gamelua.APP_STORE_HALLOWEEN_URL)
  end
end
AchievementProcessor = SubSystem:new()
function AchievementProcessor:init()
  self.achievementUnlockQueue = {}
  self.achievementRenderQueue = {}
  local isCheatsBuild = gamelua.cheatsEnabled == true and gamelua.releaseBuild == true
  self.featherGathererLimit = 200
  self.featherCollectorLimit = 100
  self.featherPickerLimit = 50
  self.blockSmasherLimit = 50000
  self.smashManiacLimit = 500000
  self.woodPeckerLimit = 5000
  self.bejewelerLimit = 100
  self.hardAsRockLimit = 100
  self.icePickerLimit = 5000
  self.stoneCutterLimit = 5000
  self.pigPopperLimit = 1000
  self.ABFanLimit = 18000
  self.trueABFanLimit = 54000
  self.ABAddictLimit = 108000
  self.starCollectorLimit = 750
  self.starGathererLimit = 1500
  self.birdSlingerLimit = 5000
  self.eggCrackerLimit = 10
  self.eggHunterLimit = 10
  if isCheatsBuild then
    self.featherGathererLimit = 3
    self.featherCollectorLimit = 2
    self.featherPickerLimit = 1
    self.blockSmasherLimit = 5
    self.smashManiacLimit = 5
    self.woodPeckerLimit = 5
    self.bejewelerLimit = 5
    self.hardAsRockLimit = 5
    self.icePickerLimit = 5
    self.stoneCutterLimit = 5
    self.pigPopperLimit = 5
    self.ABFanLimit = 60
    self.trueABFanLimit = 120
    self.ABAddictLimit = 180
    self.starCollectorLimit = 5
    self.starGathererLimit = 5
    self.birdSlingerLimit = 5
    self.eggCrackerLimit = 1
    self.eggHunterLimit = 1
  end
end
function AchievementProcessor:update(dt)
  if angryBirdsFanAchieved == nil and settingsWrapper:getPlaytime() + gamelua.currentPlaytime >= 18000 then
    self:addToAchievementUnlockQueue("Angry Birds Fan", true)
    angryBirdsFanAchieved = true
  end
  if trueAngryBirdsFanAchieved == nil and settingsWrapper:getPlaytime() + gamelua.currentPlaytime >= 54000 then
    self:addToAchievementUnlockQueue("True Angry Birds Fan", true)
    trueAngryBirdsFanAchieved = true
  end
  if angryBirdsAddicted == nil and settingsWrapper:getPlaytime() + gamelua.currentPlaytime >= 108000 then
    self:addToAchievementUnlockQueue("Angry Birds Addict", true)
    angryBirdsAddicted = true
  end
end
function AchievementProcessor:eventTriggered(event)
  local settingsWrapper = gamelua.settingsWrapper
  if event.id == gamelua.events.EID_GOLDEN_EGG_GAINED then
    if event.data.openedLevelsAmount == self.eggHunterLimit then
      self:addToAchievementUnlockQueue("Egg Hunter")
    end
  elseif event.id == gamelua.events.EID_GOLDEN_EGG_STAR_GAINED then
    if event.data.starsGained == self.eggCrackerLimit then
      self:addToAchievementUnlockQueue("Egg Cracker")
    end
  elseif event.id == gamelua.events.EID_MIGHTY_EAGLE_PURCHASED then
    self:addToAchievementUnlockQueue("Aquiline Benefactor")
  elseif event.id == gamelua.events.EID_TUTORIAL_WATCHED then
    if settingsWrapper:getTutorialsForItem("BIRD_BLUE") then
      self:addToAchievementUnlockQueue("Split it!")
    end
    if settingsWrapper:getTutorialsForItem("BIRD_YELLOW") then
      self:addToAchievementUnlockQueue("Speed is the Essence")
    end
    if settingsWrapper:getTutorialsForItem("BIRD_GREY") then
      self:addToAchievementUnlockQueue("Boom Boom!")
    end
    if settingsWrapper:getTutorialsForItem("BIRD_GREEN") then
      self:addToAchievementUnlockQueue("Mother of all Bombs")
    end
    if settingsWrapper:getTutorialsForItem("BIRD_BOOMERANG") then
      self:addToAchievementUnlockQueue("Return to Sender")
    end
    if settingsWrapper:getTutorialsForItem("BIRD_BIG_BROTHER") then
      self:addToAchievementUnlockQueue("Seeing Red")
    end
    if settingsWrapper:getTutorialsForItem("BAIT_SARDINE") then
      self:addToAchievementUnlockQueue("Aquiline Benefactor")
    end
  elseif event.id == gamelua.events.EID_LEVEL_COMPLETED then
    if event.cumulativeStars >= self.starCollectorLimit and event.cumulativeStars < self.starGathererLimit then
      self:addToAchievementUnlockQueue("Star Collector", true)
    end
    if event.cumulativeStars >= self.starGathererLimit then
      self:addToAchievementUnlockQueue("Star Gatherer", true)
    end
    if event.stars >= event.totalStars then
      self:addToAchievementUnlockQueue("Episode " .. event.themeNumber .. " - Total Destruction")
    end
    if event.scoreAchievementLimit and event.totalScore >= event.scoreAchievementLimit then
      self:addToAchievementUnlockQueue("Episode " .. event.themeNumber .. " - Score Addict")
    end
    if event.feathers >= self.featherGathererLimit then
      self:addToAchievementUnlockQueue("Feather Gatherer")
    end
    if event.feathers >= self.featherCollectorLimit then
      self:addToAchievementUnlockQueue("Feather Collector")
    end
    if event.feathers >= self.featherPickerLimit then
      self:addToAchievementUnlockQueue("Feather Picker")
    end
  elseif event.id == gamelua.events.EID_WORLD_COMPLETED then
    if event.firstTime == true and event.clearAchievement ~= nil then
      self:addToAchievementUnlockQueue(event.clearAchievement)
    end
  elseif event.id == gamelua.events.EID_BLOCKS_DESTROYED then
    gamelua.print("Event total blocks = " .. event.totalBlocks .. "\n")
    if event.totalBlocks == self.blockSmasherLimit then
      self:addToAchievementUnlockQueue("Block Smasher", true)
    else
    end
    if event.totalBlocks == self.smashManiacLimit then
      self:addToAchievementUnlockQueue("Smash Maniac", true)
    else
    end
    if event.stalaktitesDestroyed == self.hardAsRockLimit then
      self:addToAchievementUnlockQueue("Hard as a Rock", true)
    end
    if event.jewelsDestroyed == self.bejewelerLimit then
      self:addToAchievementUnlockQueue("Ultimate Bejeweler", true)
    end
    if event.pigsDestroyed == self.pigPopperLimit then
      self:addToAchievementUnlockQueue("Pig Popper", true)
    end
    if event.rockBlocksDestroyed == self.stoneCutterLimit then
      self:addToAchievementUnlockQueue("Stonecutter", true)
    end
    if event.iceBlocksDestroyed == self.icePickerLimit then
      self:addToAchievementUnlockQueue("Icepicker", true)
    end
    if event.woodBlocksDestroyed == self.woodPeckerLimit then
      self:addToAchievementUnlockQueue("Woodpecker", true)
    end
  elseif event.id == gamelua.events.EID_BOOMERANG_BIRD_POPUP_SHOWN then
    self:addToAchievementUnlockQueue("Return to Sender")
  elseif event.id == gamelua.events.EID_BIRD_SHOT then
    if event.birdsShooted == self.birdSlingerLimit then
      self:addToAchievementUnlockQueue("Bird Slinger", true)
    end
    if event.backwardsBirdCount == 10 then
      self:addToAchievementUnlockQueue("Backward Compatibility", true)
    end
  elseif event.id == gamelua.events.EID_SPACE_INVANDER then
    self:addToAchievementUnlockQueue("Space Invader", true)
  elseif event.id == gamelua.events.EID_BIRDS_COLLIDED_ON_FLY then
    self:addToAchievementUnlockQueue("Wilhelm Tell")
  elseif event.id == gamelua.events.EID_ACHIEVEMENT_BULLSEYE then
    self:addToAchievementUnlockQueue("Bull's Eye")
  elseif event.id == gamelua.events.EID_CAKE_COLLECTED then
    self:addToAchievementUnlockQueue("Cakemonger")
  end
end
function AchievementProcessor:unlockNextAchievement()
  gamelua.unlockAchievement(self.achievementUnlockQueue[1].id, self.achievementUnlockQueue[1].desc)
  _G.table.remove(self.achievementUnlockQueue, 1)
end
function AchievementProcessor:addToAchievementUnlockQueue(desc, inFront)
  _G.assert(desc ~= nil)
  local first_time = not gamelua.settingsWrapper:isAchievementAlreadyUnlocked(desc)
  gamelua.eventManager:notify({
    id = gamelua.events.EID_ACHIEVEMENT_UNLOCKED,
    name = desc,
    first_time_unlocked = first_time
  })
  if first_time then
    gamelua.settingsWrapper:markAchievementUnlocked(desc)
    gamelua.saveLuaFileWrapper("settings.lua", "settings", true)
  end
  gamelua.print("<achievement> Added achievement '" .. desc .. "' to unlock queue\n")
  if gamelua.achievements ~= nil and gamelua.achievements[desc] ~= nil then
    local id = gamelua.achievements[desc].id
    for i = 1, #self.achievementUnlockQueue do
      if self.achievementUnlockQueue[i].id == id then
        return
      end
    end
    inFront = inFront or false
    if inFront then
      _G.table.insert(self.achievementUnlockQueue, 1, {id = id, desc = desc})
    else
      _G.table.insert(self.achievementUnlockQueue, {id = id, desc = desc})
    end
  end
end
function AchievementProcessor:checkForAchievements()
  gamelua.print("checking achievements...\n")
  local settings = gamelua.settings
  local settingsWrapper = gamelua.settingsWrapper
  local g_episodes = gamelua.g_episodes
  local totalBlocks = 0
  totalBlocks = totalBlocks + settingsWrapper:getWoodBlocksDestroyed()
  totalBlocks = totalBlocks + settingsWrapper:getIceBlocksDestroyed()
  totalBlocks = totalBlocks + settingsWrapper:getRockBlocksDestroyed()
  if settingsWrapper:getWilhelmTell() then
    self:addToAchievementUnlockQueue("Wilhelm Tell")
  end
  if settingsWrapper:getBullsEye() then
    self:addToAchievementUnlockQueue("Bull's Eye")
  end
  for i = 1, #g_episodes do
    if g_episodes[i].clear_achievement then
      for j = 1, #g_episodes[i].pages do
        if settingsWrapper:isThemeCompleted(g_episodes[i].pages[j].world_number) and g_episodes[i].pages[j].clear_achievement then
          self:addToAchievementUnlockQueue(g_episodes[i].pages[j].clear_achievement)
        end
      end
    end
    if g_episodes[i].score_achievement_limit then
      local stars, total_stars = gamelua.calculateEpisodeStars(i)
      if total_stars <= stars then
        self:addToAchievementUnlockQueue("Episode " .. i .. " - Total Destruction")
      end
      local total_score = gamelua.calculateEpisodeScore(i)
      if g_episodes[i].score_achievement_limit and total_score >= g_episodes[i].score_achievement_limit then
        self:addToAchievementUnlockQueue("Episode " .. i .. " - Score Addict")
      end
    end
  end
  local feathers, maxFeathers = gamelua.calculateAllFeathers()
  if feathers >= self.featherGathererLimit then
    self:addToAchievementUnlockQueue("Feather Gatherer")
  end
  if feathers >= self.featherCollectorLimit then
    self:addToAchievementUnlockQueue("Feather Collector")
  end
  if feathers >= self.featherPickerLimit then
    self:addToAchievementUnlockQueue("Feather Picker")
  end
  if settingsWrapper:getTutorialsForItem("BIRD_BLUE") ~= nil then
    self:addToAchievementUnlockQueue("Split it!")
  end
  if settingsWrapper:getTutorialsForItem("BIRD_YELLOW") ~= nil then
    self:addToAchievementUnlockQueue("Speed is the Essence")
  end
  if settingsWrapper:getTutorialsForItem("BIRD_GREY") ~= nil then
    self:addToAchievementUnlockQueue("Boom Boom!")
  end
  if settingsWrapper:getTutorialsForItem("BIRD_GREEN") ~= nil then
    self:addToAchievementUnlockQueue("Mother of all Bombs")
  end
  if settingsWrapper:getTutorialsForItem("BIRD_BOOMERANG") ~= nil then
    self:addToAchievementUnlockQueue("Return to Sender")
  end
  if settingsWrapper:getTutorialsForItem("BIRD_BIG_BROTHER") ~= nil then
    self:addToAchievementUnlockQueue("Seeing Red")
  end
  if settingsWrapper:getTutorialsForItem("BAIT_SARDINE") ~= nil then
    self:addToAchievementUnlockQueue("Aquiline Benefactor")
  end
  if settingsWrapper:getBackwardsBirdCount() >= 10 then
    self:addToAchievementUnlockQueue("Backward Compatibility", true)
  end
  if totalBlocks >= self.blockSmasherLimit then
    self:addToAchievementUnlockQueue("Block Smasher", true)
  end
  if totalBlocks >= self.smashManiacLimit then
    self:addToAchievementUnlockQueue("Smash Maniac", true)
  end
  if settingsWrapper:getWoodBlocksDestroyed() >= self.woodPeckerLimit then
    self:addToAchievementUnlockQueue("Woodpecker", true)
  end
  if settingsWrapper:getJewelsDestroyed() >= self.bejewelerLimit then
    self:addToAchievementUnlockQueue("Ultimate Bejeweler", true)
  end
  if settingsWrapper:getStalaktitesDestroyed() >= self.hardAsRockLimit then
    self:addToAchievementUnlockQueue("Hard as a Rock", true)
  end
  if settingsWrapper:getIceBlocksDestroyed() >= self.icePickerLimit then
    self:addToAchievementUnlockQueue("Icepicker", true)
  end
  if settingsWrapper:getRockBlocksDestroyed() >= self.stoneCutterLimit then
    self:addToAchievementUnlockQueue("Stonecutter", true)
  end
  if settingsWrapper:getPigsDestroyed() >= self.pigPopperLimit then
    self:addToAchievementUnlockQueue("Pig Popper", true)
  end
  if gamelua.calculateOpenGoldenEggLevels() >= self.eggHunterLimit then
    self:addToAchievementUnlockQueue("Egg Hunter")
  end
  if gamelua.calculateStarsFromGoldenEggLevels() >= self.eggCrackerLimit then
    self:addToAchievementUnlockQueue("Egg Cracker")
  end
  if settingsWrapper:getPlaytime() >= self.ABFanLimit then
    self:addToAchievementUnlockQueue("Angry Birds Fan", true)
  end
  if settingsWrapper:getPlaytime() >= self.trueABFanLimit then
    self:addToAchievementUnlockQueue("True Angry Birds Fan", true)
  end
  if settingsWrapper:getPlaytime() >= self.ABAddictLimit then
    self:addToAchievementUnlockQueue("Angry Birds Addict", true)
  end
  if settings.cumulativeStars ~= nil and settings.cumulativeStars >= self.starCollectorLimit then
    self:addToAchievementUnlockQueue("Star Collector", true)
  end
  if settings.cumulativeStars ~= nil and settings.cumulativeStars >= self.starGathererLimit then
    self:addToAchievementUnlockQueue("Star Gatherer", true)
  end
  if settingsWrapper:getBirdsShot() >= self.birdSlingerLimit then
    self:addToAchievementUnlockQueue("Bird Slinger", true)
  end
  if settingsWrapper:isCakeCollected() then
    self:addToAchievementUnlockQueue("Cakemonger")
  end
end
function AchievementProcessor:addToAchievementRenderQueue(popupId)
  if gamelua.gameCenter.achievements[popupId] then
    _G.table.insert(self.achievementRenderQueue, popupId)
  end
end
function AchievementProcessor:renderNextAchievementPopup()
  local popup_id = self.achievementRenderQueue[1]
  local achievementBox = gamelua.AchievementPopup:new(popup_id)
  achievementBox.name = "achievement"
  gamelua.notificationsFrame:addChild(achievementBox)
  achievementBox:onEntry()
  achievementBox:layout()
  if gamelua.currentGameMode == gamelua.updateGame then
    gamelua.setPhysicsEnabled(true)
  end
  _G.table.remove(self.achievementRenderQueue, 1)
  if gamelua.achievementPopupDebug and #self.achievementRenderQueue == 0 then
    gamelua.gameCenter = nil
    gamelua.gameCenterEnabled = false
    gamelua.achievementPopupDebug = false
  end
end
filename = "subsystems.lua"
