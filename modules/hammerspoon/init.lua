-- Window management on a 6-column grid

local mods  = { "ctrl", "alt" }
local modsD = { "ctrl", "alt", "cmd" }

-- frames before their first managed move, for restore
local originalFrames = {}

local function move(x, y, w, h)
  return function()
    local win = hs.window.focusedWindow()
    if not win then return end
    if not originalFrames[win:id()] then originalFrames[win:id()] = win:frame() end
    win:moveToUnit(hs.geometry.rect(x, y, w, h))
  end
end

local function restore()
  local win = hs.window.focusedWindow()
  local f = win and originalFrames[win:id()]
  if f then win:setFrame(f); originalFrames[win:id()] = nil end
end

-- halves
hs.hotkey.bind(mods, "left",  move(0,   0,   0.5, 1))
hs.hotkey.bind(mods, "right", move(0.5, 0,   0.5, 1))
hs.hotkey.bind(mods, "up",    move(0,   0,   1,   0.5))
hs.hotkey.bind(mods, "down",  move(0,   0.5, 1,   0.5))

-- quarters
hs.hotkey.bind(mods, "u", move(0,   0,   0.5, 0.5))
hs.hotkey.bind(mods, "i", move(0.5, 0,   0.5, 0.5))
hs.hotkey.bind(mods, "j", move(0,   0.5, 0.5, 0.5))
hs.hotkey.bind(mods, "k", move(0.5, 0.5, 0.5, 0.5))

-- thirds
hs.hotkey.bind(mods, "d", move(0,   0, 1/3, 1))
hs.hotkey.bind(mods, "f", move(1/3, 0, 1/3, 1))
hs.hotkey.bind(mods, "g", move(2/3, 0, 1/3, 1))

-- two-thirds
hs.hotkey.bind(mods, "e", move(0,   0, 2/3, 1))
hs.hotkey.bind(mods, "r", move(1/6, 0, 2/3, 1))
hs.hotkey.bind(mods, "t", move(1/3, 0, 2/3, 1))

-- sixth columns
hs.hotkey.bind(mods, "1", move(0,   0, 1/6, 1))
hs.hotkey.bind(mods, "6", move(5/6, 0, 1/6, 1))
hs.hotkey.bind(mods, ",", move(0,   0, 5/6, 1))
hs.hotkey.bind(mods, ".", move(1/6, 0, 5/6, 1))

-- maximize / center / restore
hs.hotkey.bind(mods, "return", move(0, 0, 1, 1))
hs.hotkey.bind(mods, "c", function()
  local win = hs.window.focusedWindow()
  if win then win:centerOnScreen() end
end)
hs.hotkey.bind(mods, "delete", restore)

-- displays
hs.hotkey.bind(modsD, "right", function()
  local win = hs.window.focusedWindow()
  if win then win:moveToScreen(win:screen():next(), true, true) end
end)
hs.hotkey.bind(modsD, "left", function()
  local win = hs.window.focusedWindow()
  if win then win:moveToScreen(win:screen():previous(), true, true) end
end)

hs.alert.show("Hammerspoon config loaded")
