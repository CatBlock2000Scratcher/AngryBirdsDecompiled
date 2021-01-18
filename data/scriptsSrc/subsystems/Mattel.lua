print = gamelua.print
ui = gamelua.ui
g_mattel_active = false
g_mattel_mode = nil
g_mattel_splash_loaded = false
g_mattel_assets_loaded = false
g_mattel_first = true
g_mattel_activation_counts = {}
g_mattel_activation_screen = nil
function init(self)
  gamelua.eventManager:addEventListener(gamelua.events.EID_MATTEL_TOY_ACTIVATED, self)
  gamelua.eventManager:addEventListener(gamelua.events.EID_LEVEL_LOADING_DONE, self)
  gamelua.eventManager:addEventListener(gamelua.events.EID_LEAVE_GAME, self)
  gamelua.eventManager:addEventListener(gamelua.events.EID_LEVEL_ENDED, self)
  gamelua.eventManager:addEventListener(gamelua.events.EID_CAMERAS_INITIALISED, self)
  gamelua.eventManager:addEventListener(gamelua.events.EID_MATTEL_RANDOM_MODE, self)
  gamelua.eventManager:addEventListener(gamelua.events.EID_CHANGE_LEVEL, self)
  for i, v in _G.ipairs(g_mattel_modes) do
    g_mattel_activation_counts[i] = 0
  end
end
function eventTriggered(self, event)
  if event.id == gamelua.events.EID_MATTEL_TOY_ACTIVATED then
    if gamelua.currentGameMode == gamelua.updateGame then
      activate(event.popup)
    end
  elseif event.id == gamelua.events.EID_LEVEL_LOADING_DONE then
    if g_level_setup_function then
      g_level_setup_function()
    end
    gamelua.notificationsFrame:removeChild(g_mattel_activation_screen)
    g_mattel_activation_screen = nil
  elseif event.id == gamelua.events.EID_LEAVE_GAME then
    mattel_disable()
  elseif event.id == gamelua.events.EID_LEVEL_ENDED then
    if g_mattel_active then
      local mode = g_mattel_modes[g_mattel_mode]
      gamelua.menuManager:changeRoot(gamelua.LevelEndRoot:new())
      gamelua.eventManager:notify({
        id = gamelua.events.EID_PUSH_FRAME,
        target = LevelComplete:new({
          logo = mode.logo,
          level = event.level
        })
      })
    end
  elseif event.id == gamelua.events.EID_CAMERAS_INITIALISED then
    if g_mattel_active and (g_mattel_mode == 2 or g_mattel_mode == 3) then
      gamelua.currentZoomedScale = gamelua.minWorldScale
    end
  elseif event.id == gamelua.events.EID_MATTEL_RANDOM_MODE then
    g_mattel_load_random_level = true
    activate(event.popup)
  end
end
function mattel_disable()
  g_mattel_active = false
  g_level_setup_function = nil
end
function update(self, dt, time)
  if gamelua.cheatsEnabled and gamelua.keyCombination("M", "K") then
    gamelua.notifyEventManager("EID_MATTEL_TOY_ACTIVATED")
  end
end
function activate(open_in_popup)
  print("<mattel> activated\n")
  g_mattel_active = true
  if g_mattel_first then
    g_mattel_mode = 1
    g_mattel_first = false
  else
    g_mattel_mode = randomize_mode()
  end
  print("<mattel> mode: " .. g_mattel_modes[g_mattel_mode].name .. "\n")
  if not g_mattel_splash_loaded then
    gamelua.loadAssets({
      "MATTEL_STARBLEND"
    })
    gamelua.createAudio({
      fileName = gamelua.audioPath .. "/sfx/kingpig/kingpig_v02",
      extension = "mp3",
      alwaysStream = true,
      clipName = "king pig splash"
    })
    g_mattel_splash_loaded = true
  end
  if open_in_popup then
    g_mattel_activation_screen = ActivationScreen:new({})
    gamelua.notificationsFrame:addChild(g_mattel_activation_screen)
  else
    gamelua.eventManager:notify({
      id = gamelua.events.EID_CHANGE_SCENE,
      target = ActivationScreen:new({})
    })
  end
end
function randomize_mode()
  local total = 0
  for i, v in _G.ipairs(g_mattel_activation_counts) do
    total = total + v
  end
  local average = total / #g_mattel_modes
  local old_mode = g_mattel_mode
  local new_mode = 1
  repeat
    new_mode = _G.math.random(1, #g_mattel_modes)
  until new_mode ~= old_mode and average >= g_mattel_activation_counts[new_mode]
  g_mattel_activation_counts[new_mode] = g_mattel_activation_counts[new_mode] + 1
  return new_mode
end
function randomize_level()
  local selected_episode = _G.math.random(1, 8)
  if selected_episode == 8 then
    selected_episode = "SURF"
  end
  local selected_page
  repeat
    selected_page = _G.math.random(1, #gamelua.g_episodes[selected_episode].pages)
  until not gamelua.g_episodes[selected_episode].pages[selected_page].locked
  local selected_level = _G.math.random(1, #gamelua.g_episodes[selected_episode].pages[selected_page].levels)
  local level_data = {
    episode = selected_episode,
    page = selected_page,
    level = selected_level,
    levelName = gamelua.g_episodes[selected_episode].pages[selected_page].levels[selected_level].name
  }
  level_event = {
    id = gamelua.events.EID_CHANGE_LEVEL,
    data = level_data,
    from = "mattel GE"
  }
  gamelua.eventManager:notify(level_event)
end
function restart()
  gamelua.skipInput = true
  gamelua.levelRestartedFrom = nil
  local flurry_from = "toy"
  if g_mattel_load_random_level then
    flurry_from = "golden_egg"
  end
  gamelua.eventManager:queueEvent({
    id = gamelua.events.EID_MATTEL_STARTED,
    from = flurry_from or false,
    mode = g_mattel_mode
  })
  if g_mattel_load_random_level then
    randomize_level()
    g_mattel_load_random_level = false
    gamelua.g_level_started_from_mattel_ge = true
  else
    gamelua.eventManager:queueEvent({
      id = gamelua.events.EID_LEVEL_RESTART_CLICKED
    })
  end
end
function loadMattelAssets()
  gamelua.createAudio({
    fileName = gamelua.audioPath .. "/sfx/kingpig/king_pig_cry",
    extension = "mp3",
    alwaysStream = true,
    clipName = "king pig cry"
  })
  gamelua.createAudio({
    fileName = gamelua.audioPath .. "/sfx/kingpig/KingPigLaugh02",
    extension = "mp3",
    alwaysStream = true,
    clipName = "king pig laugh"
  })
  gamelua.createAudio({
    fileName = gamelua.audioPath .. "/sfx/kingpig/pig_launch",
    clipName = "pig launch"
  })
  gamelua.createAudio({
    fileName = gamelua.audioPath .. "/sfx/kingpig/pig_special_02",
    clipName = "pig special"
  })
  gamelua.loadAssets({
    "MATTEL_SPLASH",
    "MATTEL_INGAME"
  })
  gamelua.loadParticleFile()
end
function checkTimedLevelFailed()
  return g_level_timer == 0 and (gamelua.flyingBird == nil or gamelua.flyingBird and gamelua.flyingBird.hasCollided)
end
function activateMaterialMixup()
  g_level_setup_function = setupMaterialMixup
  restart()
end
function setupMaterialMixup()
  gamelua.g_extra_game_update = updateMaterialMixup
  gamelua.g_hud_class = MattelHud
  gamelua.g_eagle_disabled = true
  gamelua.g_powerups_disabled = true
  gamelua.g_special_game_mode = true
  g_materials_replaced = false
end
function updateMaterialMixup(dt, time)
  if gamelua.isPhysicsEnabled() and not g_materials_replaced then
    replaceMaterials()
    g_materials_replaced = true
  end
end
function replaceMaterials()
  local material_counts = {}
  for k, v in _G.pairs(gamelua.objects.world) do
    material_counts[v.material] = (material_counts[v.material] or 0) + 1
  end
  local l = material_counts.light or 0
  local w = material_counts.wood or 0
  local r = material_counts.rock or 0
  local a, b
  if l >= w and l >= r then
    a = "light"
    if w > r then
      b = "wood"
    else
      b = "rock"
    end
  elseif l <= w and w >= r then
    a = "wood"
    if l > r then
      b = "light"
    else
      b = "rock"
    end
  else
    a = "rock"
    if l < w then
      b = "wood"
    else
      b = "light"
    end
  end
  local def_map = {
    wood = "Wood",
    light = "Light",
    rock = "Stone"
  }
  local material_particles = {
    wood = "woodenBuff",
    rock = "rockBuff",
    light = "lightBuff"
  }
  local replace = function(s, pattern, replacement)
    local first, last = _G.string.find(s, pattern)
    if first and last then
      return _G.string.sub(s, 1, first - 1) .. replacement .. _G.string.sub(s, last + 1)
    end
    return s
  end
  for k, v in _G.pairs(gamelua.objects.world) do
    if v.strength and gamelua.blockTable.blocks[v.definition].strength and not v.controllable then
      local health = v.strength / gamelua.blockTable.blocks[v.definition].strength
      local particles = false
      if v.material == a then
        v.material = b
        v.definition = replace(v.definition, def_map[a], def_map[b])
        particles = true
      elseif v.material == b then
        v.material = a
        v.definition = replace(v.definition, def_map[b], def_map[a])
        particles = true
      end
      if particles then
        local x, y = gamelua.physicsToWorldTransform(v.x, v.y)
        local w, h = 0, 0
        if v.width and v.height then
          w, h = v.width, v.height
        elseif v.radius then
          w, h = v.radius * 2, v.radius * 2
        end
        w, h = gamelua.physicsToWorldTransform(w, h)
        _G.particles.addParticles(material_particles[v.material], 5, x, y, w, h, v.angle, false, false)
      end
      v.strength = health * gamelua.blockTable.blocks[v.definition].strength
      local sprites = gamelua.getDamageSprite(v, gamelua.blockTable.blocks)
      v.damageSprite = sprites.sprite
      v.blinkSprite = sprites.blink
      v.smileSprite = sprites.smile
      gamelua.setSprite(v.name, v.damageSprite)
    end
  end
end
function activateTotalDestruction()
  g_level_setup_function = setupTotalDestruction
  restart()
end
function setupTotalDestruction()
  gamelua.g_disable_slingshot = true
  gamelua.g_disable_double_tap = true
  gamelua.g_extra_game_update = updateTotalDestruction
  gamelua.g_hud_class = TimerHud
  gamelua.g_eagle_disabled = true
  gamelua.g_powerups_disabled = true
  gamelua.g_special_game_mode = true
  g_level_timer = 10
  gamelua.g_game_lose_condition = checkTimedLevelFailed
  gamelua.g_zooming_disabled = true
  gamelua.g_sound_level_start = ""
  for _, v in _G.pairs(gamelua.birds) do
    gamelua.removeBird(v, true, 0)
  end
  function gamelua.g_reload_bird()
  end
  g_explosion_count = 0
end
function updateTotalDestruction(dt, time)
  if gamelua.isPhysicsEnabled() and not gamelua.checkLevelGoalsDestroyed() and g_explosion_count > 0 then
    g_level_timer = _G.math.max(g_level_timer - dt, 0)
  end
  if gamelua.isPhysicsEnabled() and gamelua.keyPressed.LBUTTON and 0 < g_level_timer and not gamelua.checkLevelGoalsDestroyed() then
    g_explosion_count = g_explosion_count + 1
    local explosion_radius = 15
    local explosion_force = 10000
    local damage_radius = 5
    local explosion_damage = 20
    _G.res.playAudio("tnt_explodes", 0.85, false)
    local wx, wy = gamelua.screenToWorldTransform(gamelua.cursor.x, gamelua.cursor.y)
    local ex, ey = gamelua.screenToPhysicsTransform(gamelua.cursor.x, gamelua.cursor.y)
    local particle_x = wx
    local particle_y = wy
    if ey > 0 and ey < explosion_radius * 0.25 then
      particle_y = 0
    end
    _G.particles.addParticles("totalDestructionExplosion", 1, particle_x, particle_y, 0, 0, 0, true, false)
    if gamelua.objects.joints ~= nil then
      for k, v in _G.pairs(gamelua.objects.joints) do
        local end_point = gamelua.objects.world[v.end1]
        local dist = _G.math.max(gamelua.vLength(end_point.x - ex, end_point.y - ey), 0.5)
        local x, y = gamelua.vNormalize(end_point.x - ex, end_point.y - ey)
        if dist < explosion_radius * 0.5 and type ~= 5 then
          gamelua.destroyJoint(v.name)
        end
      end
    end
    for k, v in _G.pairs(gamelua.objects.world) do
      local dist = _G.math.max(gamelua.vLength(v.x - ex, v.y - ey), 0.5)
      local x, y = gamelua.vNormalize(v.x - ex, v.y - ey)
      if explosion_radius > dist then
        local force = gamelua.physicsScale * explosion_force / dist
        gamelua.applyImpulse(k, x * force, y * force, v.x, v.y)
      end
    end
  end
end
function activateBirdFrenzy()
  g_level_setup_function = setupBirdFrenzy
  restart()
end
function setupBirdFrenzy()
  gamelua.g_disable_double_tap = true
  gamelua.g_reload_bird = animateBirdFrenzyBirdToSlingshot
  gamelua.g_game_lose_condition = checkTimedLevelFailed
  gamelua.g_camera_follows_launched_bird = false
  gamelua.g_bird_reload_delay = 0.2
  gamelua.g_bird_remove_time = 0.1
  gamelua.g_bird_remove_velocity_treshold = 0.04
  local bird_count = 0
  for k, v in _G.pairs(gamelua.birds) do
    bird_count = bird_count + 1
  end
  g_level_timer = 10 * bird_count
  for _, v in _G.pairs(gamelua.birds) do
    gamelua.removeBird(v, true, 0)
  end
  gamelua.birdFired = true
  gamelua.nextBirdTimer = 0.001
  gamelua.g_hud_class = TimerHud
  gamelua.g_extra_game_update = updateBirdFrenzy
  gamelua.g_eagle_disabled = true
  gamelua.g_powerups_disabled = true
  gamelua.g_special_game_mode = true
  gamelua.g_zooming_disabled = true
end
function animateBirdFrenzyBirdToSlingshot(dt)
  if not gamelua.isPhysicsEnabled() or g_level_timer == 0 or gamelua.checkLevelGoalsDestroyed() then
    return
  end
  if 0 < gamelua.nextBirdTimer then
    gamelua.nextBirdTimer = gamelua.nextBirdTimer - dt
    local birds = {
      "RedBird",
      "SmallBlueBird",
      "YellowBird",
      "BlackBird",
      "BasicBird2",
      "RedBigBird",
      "BoomerangBird",
      "GlobeBird"
    }
    if 0 >= gamelua.nextBirdTimer and gamelua.birdFired then
      gamelua.spawnBird("generated_bird_" .. gamelua.birdsCounter, birds[_G.math.random(1, #birds)], gamelua.g_default_start_x * gamelua.scaleFactor, gamelua.g_default_start_y * gamelua.scaleFactor)
    end
  end
end
function updateBirdFrenzy(dt, time)
  if gamelua.isPhysicsEnabled() and not gamelua.checkLevelGoalsDestroyed() and gamelua.birdsShot > 0 then
    g_level_timer = _G.math.max(g_level_timer - dt, 0)
    if g_level_timer == 0 and gamelua.birdReady then
      gamelua.cancelBirdDrag()
      gamelua.birdReady = false
      gamelua.removeBird(gamelua.objects.world[gamelua.currentBirdName])
      gamelua.currentBirdName = nil
    end
  end
end
function activateKingPig()
  g_level_setup_function = setupKingPig
  restart()
end
function setupKingPig()
  gamelua.g_hud_class = MattelHud
  local materials = gamelua.blockTable.materials
  local blocks = gamelua.blockTable.blocks
  for k, v in _G.pairs(g_mattel_materials) do
    materials[k .. "_MATTEL"] = gamelua.deepCopy(materials[k])
    local mat = materials[k .. "_MATTEL"]
    for k2, v2 in _G.pairs(v) do
      mat[k2] = gamelua.deepCopy(v2)
    end
  end
  for k, v in _G.pairs(g_mattel_blocks) do
    blocks[k .. "_MATTEL"] = gamelua.deepCopy(blocks[k])
    local def = blocks[k .. "_MATTEL"]
    for k2, v2 in _G.pairs(v) do
      def[k2] = gamelua.deepCopy(v2)
    end
  end
  for k, v in _G.pairs(gamelua.objects.world) do
    local need_sprite = false
    if v.material == "piglette" then
      v.definition = v.definition .. "_MATTEL"
      v.material = "piglette_MATTEL"
      need_sprite = true
    elseif v.controllable then
      v.definition = v.definition .. "_MATTEL"
      need_sprite = true
    end
    if need_sprite then
      v.sprite = gamelua.blockTable.blocks[v.definition].sprite
      local sprites = gamelua.getDamageSprite(v, gamelua.blockTable.blocks)
      v.damageSprite = sprites.sprite
      v.blinkSprite = sprites.blink
      v.smileSprite = sprites.smile
      gamelua.setSprite(k, v.damageSprite)
    end
  end
  gamelua.g_extra_game_update = updateKingPig
  gamelua.g_eagle_disabled = true
  gamelua.g_powerups_disabled = true
  gamelua.g_special_game_mode = true
  gamelua.g_sound_next_bird = "piglette"
  gamelua.g_sound_level_clear = "level_failed_piglets"
  gamelua.g_sound_level_start = "piglette"
  gamelua.g_sound_level_failed = "piglette_oink_story"
  gamelua.g_sound_birds = "piglette"
  gamelua.g_sound_pigs = nil
end
function updateKingPig(dt, time)
end
g_mattel_modes = {
  {
    name = "king pig",
    activation = activateKingPig,
    logo = "LOGO_PIGPANIC",
    tagline = "TEXT_KING_PIG_MODE_KING_PIG_TAGLINE",
    reverse_pig = true
  },
  {
    name = "bird frenzy",
    activation = activateBirdFrenzy,
    logo = "LOGO_BIRDFRENZY",
    tagline = "TEXT_KING_PIG_MODE_BIRD_FRENZY_TAGLINE"
  },
  {
    name = "total destruction",
    activation = activateTotalDestruction,
    logo = "LOGO_TOTALDESTRUCTION",
    tagline = "TEXT_KING_PIG_MODE_TOTAL_DESTRUCTION_TAGLINE"
  },
  {
    name = "material mixup",
    activation = activateMaterialMixup,
    logo = "LOGO_MATERIALMIXUP",
    tagline = "TEXT_KING_PIG_MODE_MATERIAL_MIX-UP_TAGLINE"
  }
}
g_mattel_materials = {
  piglette = {
    collisionSound = "ground_collision",
    damageSound = "ground_collision",
    destroyedSound = "ground_collision"
  }
}
g_mattel_blocks = {
  SmallBlueBird = {
    sprite = "BLUE_PIG_NORMAL",
    spriteFlying = "BLUE_PIG_NORMAL",
    spriteCollision = "BLUE_PIG_COLLISION",
    spriteYell = "BLUE_PIG_YELLOW",
    spriteBlink = "BLUE_PIG_BLINK",
    particles = "mattelPigBuff",
    particlesTrail = "blueBirdTrail",
    collisionSound = "piglette_collision",
    launchSound = "pig launch",
    specialSound = "pig special",
    selectionSound = "piglette",
    unselectionSound = "piglette",
    spriteScore = "SCORE_10K_GREEN"
  },
  RedBird = {
    sprite = "RED_PIG_NORMAL",
    spriteFlying = "RED_PIG_FLY",
    spriteCollision = "RED_PIG_COLLISION",
    spriteYell = "RED_PIG_YELL",
    spriteBlink = "RED_PIG_BLINK",
    particles = "mattelPigBuff",
    particlesTrail = "redBirdTrail",
    collisionSound = "piglette_collision",
    launchSound = "pig launch",
    specialSound = "pig special",
    selectionSound = "piglette",
    unselectionSound = "piglette",
    spriteScore = "SCORE_10K_GREEN"
  },
  YellowBird = {
    sprite = "YELLOW_PIG_NORMAL",
    spriteFlying = "YELLOW_PIG_FLY",
    spriteCollision = "YELLOW_PIG_COLLISION",
    spriteYell = "YELLOW_PIG_YELL",
    spriteBlink = "YELLOW_PIG_BLINK",
    spriteSpecial = "YELLOW_PIG_SPECIAL",
    particles = "mattelPigBuff",
    particlesTrail = "yellowBirdTrail",
    collisionSound = "piglette_collision",
    launchSound = "pig launch",
    specialSound = "pig special",
    selectionSound = "piglette",
    unselectionSound = "piglette",
    spriteScore = "SCORE_10K_GREEN"
  },
  BlackBird = {
    sprite = "BOMB_PIG_NORMAL",
    spriteFlying = "BOMB_PIG_FLY",
    spriteCollision = "BOMB_PIG_FLY",
    spriteYell = "BOMB_PIG_YELL",
    spriteBlink = "BOMG_PIG_BLINK",
    spriteSpecial1 = "BOMG_PIG_EXPLOSION_1",
    spriteSpecial2 = "BOMB_PIG_EXPLOSION_2",
    spriteSpecial3 = "BOMB_PIG_EXPLOSION_3",
    particles = "mattelPigBuff",
    particlesTrail = "bombBirdTrail",
    collisionSound = "piglette_collision",
    launchSound = "pig launch",
    specialSound = "pig special",
    selectionSound = "piglette",
    unselectionSound = "piglette",
    spriteScore = "SCORE_10K_GREEN"
  },
  BasicBird2 = {
    sprite = "EGG_PIG_NORMAL",
    spriteFlying = "EGG_PIG_FLY",
    spriteCollision = "EGG_PIG_COLLISION",
    spriteYell = "EGG_PIG_YELL",
    spriteBlink = "EGG_PIG_BLINK",
    spriteSpecial = "EGG_PIG_SPECIAL",
    particles = "mattelPigBuff",
    particlesTrail = "bomberBirdTrail",
    collisionSound = "piglette_collision",
    launchSound = "pig launch",
    specialSound = "pig special",
    selectionSound = "piglette",
    unselectionSound = "piglette",
    projectile = "EggGranade_MATTEL",
    spriteScore = "SCORE_10K_GREEN"
  },
  EggGranade = {
    sprite = "EGG_PIG_BOWLINGBALL",
    particles = "explosionBuff",
    specialty = "BOMB"
  },
  RedBigBird = {
    sprite = "BIG_PIG_NORMAL",
    spriteFlying = "BIG_PIG_NORMAL",
    spriteCollision = "BIG_PIG_NORMAL",
    spriteYell = "BIG_PIG_YELL",
    spriteBlink = "BIG_PIG_BLINK",
    particles = "mattelPigBuff",
    particlesTrail = "redBirdTrail",
    collisionSound = "piglette_collision",
    launchSound = "pig launch",
    specialSound = "pig special",
    selectionSound = "piglette",
    unselectionSound = "piglette",
    spriteScore = "SCORE_10K_GREEN"
  },
  BoomerangBird = {
    sprite = "GREEN_PIG_NORMAL",
    spriteFlying = "GREEN_PIG_NORMAL",
    spriteCollision = "GREEN_PIG_COLLISION",
    spriteYell = "GREEN_PIG_YELL",
    spriteBlink = "GREEN_PIG_BLINK",
    spriteSpecial = "GREEN_PIG_SPECIAL",
    particles = "mattelPigBuff",
    particlesTrail = "yellowBirdTrail",
    collisionSound = "piglette_collision",
    launchSound = "pig launch",
    specialSound = "pig special",
    selectionSound = "piglette",
    unselectionSound = "piglette",
    spriteScore = "SCORE_10K_GREEN"
  },
  GlobeBird = {
    particles = {
      "mattelPigBuff",
      "smokeBuff"
    },
    particlesTrail = "redBirdTrail",
    sprite = "PUFFER_PIG_NORMAL",
    spriteFlying = "PUFFER_PIG_NORMAL",
    spriteCollision = "PUFFER_PIG_NORMAL",
    spriteYell = "PUFFER_PIG_YELL",
    spriteAction = "PUFFER_PIG_NORMAL",
    spriteBlink = "PUFFER_PIG_BLINK",
    collisionSound = "piglette_collision",
    launchSound = "pig launch",
    specialSound = "pig special",
    selectionSound = "piglette",
    unselectionSound = "piglette",
    puffedDefinition = "GlobeBirdBig_MATTEL",
    spriteScore = "SCORE_10K_GREEN"
  },
  GlobeBirdBig = {
    particles = "mattelPigBuff",
    particlesTrail = "redBirdTrail",
    sprite = "PUFFER_PIG_PUFF",
    spriteFlying = "PUFFER_PIG_PUFF",
    spriteCollision = "PUFFER_PIG_PUFF",
    spriteYell = "PUFFER_PIG_PUFF",
    spriteAction = "PUFFER_PIG_PUFF",
    spriteBlink = "PUFFER_PIG_PUFF",
    collisionSound = "piglette_collision",
    launchSound = "pig launch",
    specialSound = "pig special",
    selectionSound = "piglette",
    unselectionSound = "piglette",
    removeSound = "piglette"
  },
  SmallPiglette = {
    sprite = "EGG_SMALL_1",
    particles = "smokeBuff",
    spriteScore = "SCORE_5K_WHITE",
    material = "piglette_MATTEL",
    damageSprites = {
      damage1 = {
        sprite = "EGG_SMALL_1",
        blinkSprite = "EGG_SMALL_1",
        smileSprite = "EGG_SMALL_1",
        max = 100,
        min = -1000
      }
    }
  },
  MediumPiglette = {
    sprite = "EGG_MEDIUM_1",
    particles = "smokeBuff",
    spriteScore = "SCORE_5K_WHITE",
    material = "piglette_MATTEL",
    damageSprites = {
      damage1 = {
        sprite = "EGG_MEDIUM_1",
        blinkSprite = "EGG_MEDIUM_1",
        smileSprite = "EGG_MEDIUM_1",
        max = 100,
        min = -1000
      }
    }
  },
  HelmetPiglette = {
    sprite = "EGG_HELMET_1",
    particles = "smokeBuff",
    spriteScore = "SCORE_5K_WHITE",
    material = "piglette_MATTEL",
    damageSprites = {
      damage1 = {
        sprite = "EGG_HELMET_1",
        blinkSprite = "EGG_HELMET_1",
        smileSprite = "EGG_HELMET_1",
        max = 100,
        min = -1000
      }
    }
  },
  LargePiglette = {
    sprite = "EGG_BIG_1",
    particles = "smokeBuff",
    spriteScore = "SCORE_5K_WHITE",
    material = "piglette_MATTEL",
    damageSprites = {
      damage1 = {
        sprite = "EGG_BIG_1",
        blinkSprite = "EGG_BIG_1",
        smileSprite = "EGG_BIG_1",
        max = 100,
        min = -1000
      }
    }
  },
  GrandpaPiglette = {
    sprite = "EGG_MOUSTACHE_1",
    particles = "smokeBuff",
    spriteScore = "SCORE_5K_WHITE",
    material = "piglette_MATTEL",
    damageSprites = {
      damage1 = {
        sprite = "EGG_MOUSTACHE_1",
        blinkSprite = "EGG_MOUSTACHE_1",
        smileSprite = "EGG_MOUSTACHE_1",
        max = 100,
        min = -1000
      }
    }
  },
  KingPiglette = {
    sprite = "EGG_KINGPIG_1",
    particles = "smokeBuff",
    spriteScore = "SCORE_5K_WHITE",
    material = "piglette_MATTEL",
    damageSprites = {
      damage1 = {
        sprite = "EGG_KINGPIG_1",
        blinkSprite = "EGG_KINGPIG_1",
        smileSprite = "EGG_KINGPIG_1",
        max = 100,
        min = -1000
      }
    }
  }
}
filename = "Mattel.lua"
