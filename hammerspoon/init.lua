--- reload config
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

local v60hyper = {}
local globalHyper = {"ctrl", "alt"}
local primaryScreen = hs.screen.primaryScreen()
local primaryScreenMenuBarOffset = primaryScreen:frame().y

hs.loadSpoon("MiroWindowsManager")
-- spoon.MiroWindowsManager.log.setLogLevel('debug')
-- spoon.MiroWindowsManager.log.d('hi')

-- Since there is no way to pass arguments to a spoon, we have to (re-) set
-- hs.grid and MiroWindowsManager.GRID to 12x12. The default grid of 24x24 _works_
-- but it looks like a remainder bug makes windows, particularly on small (laprop) screens,
-- decrease in height every time they are re-sized; using a 12x12 grid avoids that bug.
hs.grid.setGrid('12x12')
spoon.MiroWindowsManager.GRID = {w = 12, h = 12}
-- the notation here is confusing -- the numerator and denominator are reversed;
-- also be sure the grid size is divisible by the grid size _for height and width_.
spoon.MiroWindowsManager.sizes = {12/4, 2, 12/8}

-- a margin of 8 seems to be small enough to avoid the aforementioned bug
hs.grid.setMargins(hs.geometry.size({w=8, h=8}))
-- setting animationDuration to not-zero makes iTerm/Terminal windows move all herky-jerky
hs.window.animationDuration = 0.0

-- bindings for my custom-programmed keyboard
spoon.MiroWindowsManager:bindHotkeys({
  -- these keys are all mapped under layer 2
  -- f14 is w/up-arrow
  up = {v60hyper, "f14"},
  --pad+ is s/down-arrow
  down = {v60hyper, "pad+"},
  -- pad- is a/left-arrow
  left = {v60hyper, "pad-"},
  -- padenter is d/right-arrow
  right = {v60hyper, "padenter"},
  -- pad1 is f
  fullscreen = {v60hyper,"pad1"}
})
-- bindings for an Apple keyboard, like the built-in one on a laptop
spoon.MiroWindowsManager:bindHotkeys({
  up = {globalHyper, "up"},
  down = {globalHyper, "down"},
  left = {globalHyper, "left"},
  right = {globalHyper, "right"},
  fullscreen = {globalHyper, "f"}
})

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
