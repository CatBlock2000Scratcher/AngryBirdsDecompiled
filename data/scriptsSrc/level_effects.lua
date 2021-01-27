LevelEffect = {}
function LevelEffect:inherit()
  local o = {}
  _G.setmetatable(o, self)
  self.__index = self
  return o or {}
end
function LevelEffect:new(o)
  o = o or {}
  _G.setmetatable(o, self)
  self.__index = self
  o:init()
  return o
end
function LevelEffect:init()
end
function LevelEffect:update(dt, time)
end
function setLevelEffects(currentTheme)
  g_level_effects = {}
  if blockTable.themes[currentTheme].effects then
    for k, v in _G.ipairs(blockTable.themes[currentTheme].effects) do
      _G.table.insert(g_level_effects, (_G.getfenv(1)[v.type]:new(v.params)))
    end
  end
end
function updateLevelEffects(dt, time)
  for k, v in _G.ipairs(g_level_effects) do
    v:update(dt, time)
  end
end
g_thunder_duration_cap = 1.5
g_thunder_durations = {
  {
    chance = 1,
    min = 0.7,
    max = 0.8
  },
  {
    chance = 3,
    min = 0.3,
    max = 0.66
  }
}
g_thunder_duration_in = 0.15
g_thunder_duration_out = 0.25
g_thunder_interval_min = 3
g_thunder_interval_max = 20
g_thunder_sound_delay_min = 0.2
g_thunder_sound_delay_max = 2.2
Thunder = LevelEffect:inherit()
function Thunder:init()
  self.thunder_active = false
  self.thunder_interval = _G.math.random(3, 6)
  self.sound_played = true
  for k, v in _G.ipairs(self.flash_layers) do
    setThemeRectColour(v - 1, 255, 255, 255, 0)
  end
  for k, v in _G.ipairs(self.shadow_layers) do
    setThemeRectColour(v - 1, 0, 0, 0, 0)
  end
end
function Thunder:update(dt, time)
  if self.thunder_active then
    self:updateThunder(dt)
  else
    self.thunder_interval = self.thunder_interval - dt
    if self.thunder_interval <= 0 then
      self:doThunder()
    end
  end
  if not self.sound_played then
    self.sound_timer = self.sound_timer - dt
    if 0 >= self.sound_timer then
      _G.res.playAudio(getAudioName("lightning"), 1, false)
      self.sound_played = true
    end
  end
end
function Thunder:doThunder()
  value = nil
  for k, v in _G.ipairs(g_thunder_durations) do
  end
  for k2, v2 in _G.ipairs(g_thunder_durations) do
  value = k2
  end
  self.thunder_duration = g_thunder_durations[value].min + _G.math.random() * (g_thunder_durations[value].max - g_thunder_durations[value].min)
  self.thunder_timer = 0
  self.sound_timer = g_thunder_sound_delay_min + _G.math.random() * (g_thunder_sound_delay_max - g_thunder_sound_delay_min)
  self.thunder_interval = g_thunder_interval_min + _G.math.random() * (g_thunder_interval_max - g_thunder_interval_min)
  self.sound_played = false
  self.thunder_active = true
  self.previous_alpha = 0
  self.alpha = 0
  self.alpha_change_timer = 0
end
function Thunder:updateThunder(dt)
  local L2_32, L3_33, L4_34
  L2_32 = self.thunder_duration
  L3_33 = g_thunder_duration_in
  L2_32 = L2_32 + L3_33
  L3_33 = g_thunder_duration_out
  L2_32 = L2_32 + L3_33
  L3_33 = 0.06
  L4_34 = _G
  L4_34 = L4_34.math
  L4_34 = L4_34.min
  L4_34 = L4_34(self.thunder_timer + dt, L2_32)
  self.thunder_timer = L4_34
  L4_34 = self.alpha_change_timer
  L4_34 = L4_34 + dt
  self.alpha_change_timer = L4_34
  L4_34 = self.alpha_change_timer
  if L3_33 <= L4_34 then
    L4_34 = 0
    if self.thunder_timer < g_thunder_duration_in then
      L4_34 = self.thunder_timer / g_thunder_duration_in
    elseif self.thunder_timer < g_thunder_duration_in + self.thunder_duration then
      L4_34 = _G.math.max(1 - (g_thunder_duration_cap + self.thunder_duration / (g_thunder_duration_cap * 3)) + _G.math.random() * (g_thunder_duration_cap + self.thunder_duration / (g_thunder_duration_cap * 3)), 0)
    else
      L4_34 = 1 - (self.thunder_timer - (g_thunder_duration_in + self.thunder_duration)) / g_thunder_duration_out
    end
    self.previous_alpha = self.alpha
    self.alpha = L4_34
    self.alpha_change_timer = 0
  end
  L4_34 = tweenLinear
  L4_34 = L4_34(self.alpha_change_timer, self.previous_alpha, self.alpha - self.previous_alpha, L3_33)
  if self.thunder_timer == L2_32 then
    self.thunder_active = false
    L4_34 = 0
  end
  for _FORV_8_, _FORV_9_ in _G.ipairs(self.flash_layers) do
    setThemeRectColour(_FORV_9_ - 1, 255, 255, 255, _G.math.floor(L4_34 * 255))
  end
  for _FORV_8_, _FORV_9_ in _G.ipairs(self.shadow_layers) do
    setThemeRectColour(_FORV_9_ - 1, 0, 0, 0, _G.math.floor(L4_34 * 255))
  end
end
g_foam_margin = 0.1
g_max_foam = 0.5
g_water_margin = 0.2
g_wave_frequecy = 1
g_foam_fall_speed = 0.6
Waves = LevelEffect:inherit()
function Waves:init()
  _, self.foam_h = _G.res.getSpriteBounds(self.foam_layer.sprite)
  _, self.water_h = _G.res.getSpriteBounds(self.water_layer.sprite)
  _, self.ground_h = _G.res.getSpriteBounds(self.ground_layer.sprite)
  self.last_foam_offset = 0
  self.run_time = 0
  self:updateWaves(0)
end
function Waves:update(dt, time)
  self:updateWaves(dt)
end
function Waves:updateWaves(dt)
  local L2_41, L3_42, L4_43, L5_44
  L2_41 = self.run_time
  L2_41 = L2_41 + dt
  self.run_time = L2_41
  L2_41 = self.water_h
  L3_42 = g_water_margin
  L2_41 = L2_41 * L3_42
  L3_42 = self.ground_h
  L3_42 = L3_42 - L2_41
  L3_42 = L3_42 / 2
  L4_43 = _G
  L4_43 = L4_43.math
  L4_43 = L4_43.sin
  L5_44 = self.run_time
  L5_44 = L5_44 * g_wave_frequecy
  L4_43 = L4_43(L5_44)
  L4_43 = L4_43 * L3_42
  L5_44 = L2_41 + L3_42
  L4_43 = L4_43 + L5_44
  L5_44 = self.last_foam_offset
  L5_44 = L5_44 + self.foam_h * g_foam_fall_speed * dt
  if L5_44 > L4_43 - self.foam_h * g_foam_margin then
    L5_44 = L4_43 - self.foam_h * g_foam_margin
  elseif L5_44 < L4_43 - (self.foam_h - self.foam_h * g_max_foam) then
    L5_44 = L4_43 - (self.foam_h - self.foam_h * g_max_foam)
  end
  setThemeForegroundOffsetY(self.water_layer.index - 1, L4_43)
  setThemeForegroundOffsetY(self.foam_layer.index - 1, L5_44)
  self.last_foam_offset = L5_44
end
filename = "level_effects.lua"
