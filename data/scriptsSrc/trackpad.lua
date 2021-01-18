print = gamelua.print
frame = 0
last_touch_frame = 0
using_mouse = true
last_cursor = {x = 0, y = 0}
last_touches = {}
function updateTrackpad(dt)
  frame = frame + 1
  local input_method_change_frames = 2
  if gamelua.touchcount > 0 then
    last_touch_frame = frame
    using_mouse = false
  elseif gamelua.touchcount == 0 and frame > last_touch_frame + input_method_change_frames and (gamelua.cursor.x ~= last_cursor.x or gamelua.cursor.y ~= last_cursor.y) then
    using_mouse = true
  end
  last_cursor.x = gamelua.cursor.x
  last_cursor.y = gamelua.cursor.y
  if gamelua.isInFullScreenMode() and not using_mouse then
    gamelua.g_usedGestureControls = true
  end
  if gamelua.currentGameMode ~= gamelua.updateGame or using_mouse or not gamelua.isInFullScreenMode() then
    emulateMouse()
    gamelua.captureMouse(false)
  else
    gamelua.g_usingGestureControls = true
    gamelua.captureMouse(true)
  end
end
function emulateMouse()
  if gamelua.keyHold.LBUTTON then
    gamelua.touchcount = 1
    gamelua.touches = {
      {
        x = gamelua.cursor.x,
        y = gamelua.cursor.y
      }
    }
  else
    gamelua.touchcount = 0
    gamelua.touches = {}
  end
  gamelua.g_usingGestureControls = false
end
filename = "trackpad.lua"
