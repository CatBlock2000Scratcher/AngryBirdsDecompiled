for k, v in _G.ipairs(g_episodes[1].pages[1].levels) do
  g_level_scripts[v.name] = g_level_scripts[v.name] or {}
  g_level_scripts[v.name].onLoadLevel = function()
    waves = loadedObjects.waves
    vehicleObjects = {}
  end
  g_level_scripts[v.name].onUpdate = function(dt, time)
    if waves.useRedBirdSpeciality then
      spawnBird("generated_bird_" .. birdsCounter, "RedBird", g_default_start_x * scaleFactor, g_default_start_y * scaleFactor)
      waves.useRedBirdSpeciality = false
    end
  end
end