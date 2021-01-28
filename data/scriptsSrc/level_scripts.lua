g_level_scripts = {}
local removeObjectAndJoints = function(item)
  loadedObjects.world[item] = nil
  for k, v in _G.pairs(loadedObjects.joints) do
    if v.end1 == item or v.end2 == item then
      loadedObjects.joints[k] = nil
    end
  end
end
g_goldenEggKeyboardControl = deviceModel == "windows" or deviceModel == "osx" or g_isAccelerometerControl
g_goldenEggKeys = {
  "O",
  "P",
  "E",
  "N"
}
g_goldenEggKeyCount = 0
if deviceModel == "freebox" then
  g_rokuCursorVisible = true
  g_goldenEggKeys = {"KEY_5"}
end
g_level_scripts.Level5 = {
  onLoadLevel = function()
    g_goldenEggKeyCount = 0
  end,
  onUpdate = function(dt, time)
    if g_goldenEggKeys[g_goldenEggKeyCount + 1] and keyPressed[g_goldenEggKeys[g_goldenEggKeyCount + 1]] then
      local treasure_chest = objects.world.ExtraTreasureChest_1
      if treasure_chest ~= nil then
        g_goldenEggKeyCount = g_goldenEggKeyCount + 1
      end
    end
    if doubleClick == true and not g_goldenEggKeyboardControl or g_goldenEggKeyCount == #g_goldenEggKeys and g_goldenEggKeyboardControl then
      local treasureChest = objects.world.ExtraTreasureChest_1
      if treasureChest ~= nil and (distance(cursorPhysics.x, cursorPhysics.y, treasureChest.x, treasureChest.y) < 2.5 or g_goldenEggKeyboardControl) then
        goldenEggAchieved("LevelGE_15")
      end
    end
  end
}
g_level_scripts.Level34 = {
  onRemoveBlock = function(block)
    if block.name == "ExtraBeachBall_1" and not eagleBaitLaunched then
      goldenEggAchieved("LevelGE_2")
    end
  end
}
g_level_scripts.LevelP2_64 = {
  onLoadLevel = function()
    if settingsWrapper:isGoldenEggUnlocked("LevelGE_5") then
      removeObjectAndJoints("ExtraGoldenEgg_1")
    end
  end,
  onRemoveBlock = function(block)
    if block.name == "ExtraGoldenEgg_1" and not eagleBaitLaunched then
      goldenEggAchieved("LevelGE_5")
    end
  end
}
g_level_scripts.LevelP2_67 = {
  onLoadLevel = function()
    if settingsWrapper:isGoldenEggUnlocked("LevelGE_3") then
      removeObjectAndJoints("ExtraGoldenEgg_1")
    end
  end,
  onRemoveBlock = function(block)
    if block.name == "ExtraGoldenEgg_1" and not eagleBaitLaunched then
      goldenEggAchieved("LevelGE_3")
    end
  end
}
g_level_scripts.LevelP3_271 = {
  onLoadLevel = function()
    if settingsWrapper:isBoomerangBirdAchieved() then
      removeObjectAndJoints("ExtraBoomerangBird_1")
    end
  end,
  onInitLevelComplete = function()
    if not settingsWrapper:isBoomerangBirdAchieved() then
      showBoomerangBirdPopup = true
    end
  end,
  onBeforeLevelEnding = function()
    if showBoomerangBirdPopup == true then
      showBoomerangBirdPopup = false
      levelCompleteTimer = levelCompleteTimer + 3.6
      eventManager:notify({
        id = events.EID_BOOMERANG_BIRD_POPUP
      })
      settingsWrapper:setBoomerangBirdAchieved()
      eventManager:notify({
        id = events.EID_BOOMERANG_BIRD_POPUP_SHOWN
      })
    end
  end
}
g_level_scripts.LevelP3_220 = {
  onRemoveBlock = function(block)
    if block.name == "StaticBalloon03_2" and not eagleBaitLaunched then
      goldenEggAchieved("LevelGE_6")
    end
  end
}
g_level_scripts.LevelP3_313 = {
  onLoadLevel = function()
    if settingsWrapper:isGoldenEggUnlocked("LevelGE_8") then
      removeObjectAndJoints("ExtraGoldenEgg_1")
    end
  end,
  onRemoveBlock = function(block)
    if block.name == "ExtraGoldenEgg_1" and not eagleBaitLaunched then
      goldenEggAchieved("LevelGE_8")
    end
  end
}
g_level_scripts.LevelP4_426 = {
  onLoadLevel = function()
    if settingsWrapper:isBoomerangBird2Achieved() then
      removeObjectAndJoints("ExtraBoomerangBird_1")
    end
  end,
  onInitLevelComplete = function()
    if not settingsWrapper:isBoomerangBird2Achieved() then
      showBoomerangBirdPopup = true
    end
  end,
  onBeforeLevelEnding = function()
    if showBoomerangBirdPopup == true then
      showBoomerangBirdPopup = false
      levelCompleteTimer = levelCompleteTimer + 3.6
      eventManager:notify({
        id = events.EID_BOOMERANG_BIRD_POPUP
      })
      settingsWrapper:setBoomerangBird2Achieved()
      eventManager:notify({
        id = events.EID_BOOMERANG_BIRD_POPUP_SHOWN
      })
    end
  end
}
g_level_scripts.LevelP4_440 = {
  onLoadLevel = function()
    if settingsWrapper:isGoldenEggUnlocked("LevelGE_9") then
      removeObjectAndJoints("ExtraGoldenEgg_1")
    end
  end,
  onRemoveBlock = function(block)
    if block.name == "ExtraGoldenEgg_1" and not eagleBaitLaunched then
      goldenEggAchieved("LevelGE_9")
    end
  end
}
g_level_scripts.LevelP4_444 = {
  onRemoveBlock = function(block)
    if block.name == "ExtraRubberDuck_1" and not eagleBaitLaunched then
      goldenEggAchieved("LevelGE_10")
    end
  end
}
g_level_scripts.LevelP4_478 = {
  onLoadLevel = function()
    if settingsWrapper:isGoldenEggUnlocked("LevelGE_11") then
      removeObjectAndJoints("ExtraGoldenEgg_1")
    end
  end,
  onRemoveBlock = function(block)
    if block.name == "ExtraGoldenEgg_1" and not eagleBaitLaunched then
      goldenEggAchieved("LevelGE_11")
    end
  end
}
g_level_scripts.LevelP5_357 = {
  onRemoveBlock = function(block)
    if block.name == "ExtraHolyGrail_4" and not eagleBaitLaunched then
      goldenEggAchieved("LevelGE_16")
    end
  end
}
g_level_scripts.LevelP5_650 = {
  onLoadLevel = function()
    if settingsWrapper:isGoldenEggUnlocked("LevelGE_17") then
      removeObjectAndJoints("ExtraGoldenEgg_1")
    end
  end,
  onRemoveBlock = function(block)
    if block.name == "ExtraGoldenEgg_1" and not eagleBaitLaunched then
      goldenEggAchieved("LevelGE_17")
    end
  end
}
g_level_scripts.LevelP5_354 = {
  onLoadLevel = function()
    if settingsWrapper:isGoldenEggUnlocked("LevelGE_19") then
      removeObjectAndJoints("ExtraSuperBowl_2")
    end
  end,
  onRemoveBlock = function(block)
    if block.name == "ExtraSuperBowl_2" and not eagleBaitLaunched then
      goldenEggAchieved("LevelGE_19")
    end
  end
}
g_level_scripts.LevelP5_364 = {
  onLoadLevel = function()
    if settingsWrapper:isGoldenEggUnlocked("LevelGE_18") then
      removeObjectAndJoints("ExtraGoldenEgg_1")
    end
  end,
  onRemoveBlock = function(block)
    if block.name == "ExtraGoldenEgg_1" and not eagleBaitLaunched then
      goldenEggAchieved("LevelGE_18")
    end
  end
}
g_level_scripts.Level695 = {
  onLoadLevel = function()
    if settingsWrapper:isGoldenEggUnlocked("LevelGE_20") then
      removeObjectAndJoints("ExtraGoldenEgg_1")
    end
  end,
  onRemoveBlock = function(block)
    if block.name == "ExtraGoldenEgg_1" and not eagleBaitLaunched then
      goldenEggAchieved("LevelGE_20")
    end
  end
}
g_level_scripts.Level697 = {
  onLoadLevel = function()
    if settingsWrapper:isGoldenEggUnlocked("LevelGE_21") then
      removeObjectAndJoints("ExtraGoldenEgg_1")
    end
  end,
  onRemoveBlock = function(block)
    if block.name == "ExtraGoldenEgg_1" and not eagleBaitLaunched then
      goldenEggAchieved("LevelGE_21")
    end
  end
}
g_level_scripts.LevelP6_7 = {
  onLoadLevel = function()
    if settingsWrapper:isGoldenEggUnlocked("LevelGE_23") then
      removeObjectAndJoints("ExtraTreasureChest_1")
    end
  end,
  onRemoveBlock = function(block)
    if block.name == "ExtraTreasureChest_1" and not eagleBaitLaunched then
      goldenEggAchieved("LevelGE_23")
    end
  end
}
g_level_scripts.LevelH564 = {
  onLoadLevel = function()
    if settingsWrapper:isGoldenEggUnlocked("LevelGE_24") then
      removeObjectAndJoints("ExtraGoldenEgg_1")
    end
  end,
  onRemoveBlock = function(block)
    if block.name == "ExtraGoldenEgg_1" and not eagleBaitLaunched then
      goldenEggAchieved("LevelGE_24")
    end
  end
}
g_level_scripts.LevelH900 = {
  onRemoveBlock = function(block)
    if block.name == "SPECIAL_CAKE_1_1" and not eagleBaitLaunched then
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
}
g_level_scripts.SOUNDBOARD1 = {
  onPrepareOverride = function()
    settingsWrapper:setGoldenEggPlayed("SOUNDBOARD1")
    eventManager:notify({
      id = events.EID_GE_LEVEL_STARTED,
      levelName = "SOUNDBOARD1"
    })
    local goto_level = {
      id = events.EID_CHANGE_SCENE,
      target = soundboards.Soundboard:new()
    }
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
  end
}
g_level_scripts.RADIO = {
  onPrepareOverride = function()
    settingsWrapper:setGoldenEggPlayed("RADIO")
    eventManager:notify({
      id = events.EID_GE_LEVEL_STARTED,
      levelName = "RADIO"
    })
    local goto_level = {
      id = events.EID_CHANGE_SCENE,
      target = soundboards.Radio:new()
    }
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
  end
}
g_level_scripts.KEYBOARD = {
  onPrepareOverride = function()
    settingsWrapper:setGoldenEggPlayed("KEYBOARD")
    eventManager:notify({
      id = events.EID_GE_LEVEL_STARTED,
      levelName = "KEYBOARD"
    })
    local goto_level = {
      id = events.EID_CHANGE_SCENE,
      target = soundboards.Keyboard:new()
    }
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
  end
}
g_level_scripts.SEQUENCER = {
  onPrepareOverride = function()
    settingsWrapper:setGoldenEggPlayed("SEQUENCER")
    eventManager:notify({
      id = events.EID_GE_LEVEL_STARTED,
      levelName = "SEQUENCER"
    })
    local goto_level = {
      id = events.EID_CHANGE_SCENE,
      target = soundboards.Sequencer:new()
    }
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
  end
}
g_level_scripts.ACCORDION = {
  onPrepareOverride = function()
    settingsWrapper:setGoldenEggPlayed("ACCORDION")
    eventManager:notify({
      id = events.EID_GE_LEVEL_STARTED,
      levelName = "ACCORDION"
    })
    local goto_level = {
      id = events.EID_CHANGE_SCENE,
      target = soundboards.Accordion:new()
    }
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
  end
}
g_level_scripts.LevelGE_20 = {
  onLoadLevel = function()
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
}
--loadLuaFile(scriptPath .. "/subsystems/eggdefender/EggDefender.lua", "")
filename = "level_scripts.lua"
