--- reload config
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

local v60hyper = {}
local globalHyper = {"ctrl", "alt"}
local primaryScreen = hs.screen.primaryScreen()
local primaryScreenMenuBarOffset = primaryScreen:frame().y
hs.window.animationDuration = 0

hs.loadSpoon("PaulWindowManager")

spoon.PaulWindowManager:bindSizes({mappings=
  {mash = {},              key = "f13",  size = {h = 65, w = 55}},
  {mash = {"ctrl", "alt"}, key = "q",    size = {h = 65, w = 55}},
  {mash = {},              key = "f14",  size = {h = 65}},
  {mash = {"ctrl", "alt"}, key = "w",    size = {h = 65}},
  {mash = {},              key = "f15",  size = {h = 50, w = 50, x = 55}},
  {mash = {"ctrl", "alt"}, key = "e",    size = {h = 50, w = 50, x = 55}},

  {mash = {},              key = "pad-", size = {        w = 55}},
  {mash = {"ctrl", "alt"}, key = "a",    size = {        w = 55}},
  {mash = {},              key = "pad+", size = {}},
  {mash = {"ctrl", "alt"}, key = "s",    size = {}},
  {mash = {},              key = "padenter", size = {            x = 55}},
  {mash = {"ctrl", "alt"}, key = "d",    size = {                x = 55}},

  {mash = {},              key = "pad7", size = {h = 35, w = 55,         y = 65}},
  {mash = {"ctrl", "alt"}, key = "z",    size = {h = 35, w = 55,         y = 65}},
  {mash = {},              key = "pad8", size = {h = 35,                 y = 65}},
  {mash = {"ctrl", "alt"}, key = "x",    size = {h = 35,                 y = 65}},
  {mash = {},              key = "pad9", size = {h = 50,         x = 55, y = 50}},
  {mash = {"ctrl", "alt"}, key = "c",    size = {h = 50,         x = 55, y = 50}},
})

hs.hotkey.bind({"alt", "ctrl"}, "up", function()
  local sdf = screenDimensionFigurer:new(hs.window.focusedWindow(), true)
  -- no resizing/use default full-screen size
  sdf:changeSize('h', 10)
  sdf:move()
end)

hs.hotkey.bind({"alt", "ctrl"}, "down", function()
  local sdf = screenDimensionFigurer:new(hs.window.focusedWindow(), true)
  -- no resizing/use default full-screen size
sdf:changeSize('h', -10)
  sdf:move()
end)

hs.hotkey.bind({"alt", "ctrl"}, "left", function()
  local sdf = screenDimensionFigurer:new(hs.window.focusedWindow(), true)
  -- no resizing/use default full-screen size
  sdf:changeSize('w', -10)
  sdf:move()
end)

hs.hotkey.bind({"alt", "ctrl"}, "right", function()
  local sdf = screenDimensionFigurer:new(hs.window.focusedWindow(), true)
  -- no resizing/use default full-screen size
  sdf:changeSize('w', 10)
  sdf:move()
end)


function stackWindows(win)
  -- find all windows in the app of the frontmost window
  -- make all the windows in the app the same size
  local f = win:frame()
  local app = win:application()
  local windows = app:allWindows()
  for i, window in ipairs(windows) do
    window:setFrame(f)
  end
end

hs.hotkey.bind(v60hyper, "f17", function()
  local win = hs.window.focusedWindow()
  stackWindows(win)
end)

maxFrame = {
  x = 0,
  y = primaryScreenMenuBarOffset,
  h = primaryScreen:frame().h,
  w = primaryScreen:frame().w,
}

-- on a 24x24 grid, these are {x, y, w, h}
lowerRight = {
  14.0, 10.0, 10.0, 14.0
}

upperRight = {
  14.0, 0.0, 10.0, 10.0
}

halfLeft = {
  0.0, 0.0, 14.0, 24.0
}

local appPositions = {
  Atom = halfLeft,
  ['Google Chrome'] = halfLeft,
  ['IntelliJ IDEA'] = halfLeft,
  iTerm2 = upperRight,
  -- Messages = lowerRight,
  PyCharm = halfLeft,
  Slack = lowerRight,
}

hs.hotkey.bind(globalHyper, "k", function()
  -- print("setting up default window positions")
  -- print(appPositions.PyCharm.x)
  for appName, position in pairs(appPositions) do
    -- print("for ", appName)
    thisApp = hs.application.get(appName)
    if thisApp == nil then
      print("skipping nil app: ", appName)
    else
      for title, appWindow in pairs(thisApp:allWindows()) do
        print("the position for ", title, " is h/w/x/y", position.h, position.w, position.x, position.y)
        hs.grid.set(appWindow, position)
      end
    end
  end
end)

-- the 'pad=' key is under 'n' on layer 2
hs.hotkey.bind(v60hyper, "pad=", function()
  local win = hs.window.focusedWindow()
  local scr = win:screen()
  local nextScreen = scr:next()
  win:moveToScreen(scr:next())
  if nextScreen:fullFrame().h * nextScreen:fullFrame().w < scr:fullFrame().h * scr:fullFrame().w then
    print(string.format("next screen area: %s", nextScreen:fullFrame().h * nextScreen:fullFrame().w))
    print(string.format("this screen area: %s", scr:fullFrame().h * scr:fullFrame().w))
    -- next screen is smaller; make it MiroWindowsManager's idea of full screen.
    spoon.MiroWindowsManager:_nextFullScreenStep()
  end
end)

myLog = hs.logger.new('pk_config', 'debug')
hs.hotkey.bind(globalHyper, 'm', function()
  local currentMic = hs.audiodevice.defaultInputDevice()

  currentMic:setMuted(not currentMic:muted())

  local verb = currentMic:muted() and " " or " un-"
  local alertString =  currentMic:name() .. verb .. "muted"
  hs.alert.show(alertString)

end)
