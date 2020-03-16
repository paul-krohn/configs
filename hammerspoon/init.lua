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
-- the notation here is confusing -- the numerator and denominator are revered.
-- also be sure the grid size is divisible by the grid size _for height and width_.
spoon.MiroWindowsManager.sizes = {12/7, 2, 12/5}

hs.grid.MARGINX = 12
hs.grid.MARGINY = 12
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

lowerRight = {
  x = maxFrame.w / 2,
  y = 2 * maxFrame.h / 3 + primaryScreenMenuBarOffset,
  w = maxFrame.w / 2,
  h = maxFrame.h / 3,
}

upperRight = {
  x = maxFrame.w / 2,
  y = primaryScreenMenuBarOffset,
  w = maxFrame.w / 2,
  h = 2* maxFrame.h / 3,
}

halfLeft = {
  x = 0,
  y = primaryScreenMenuBarOffset,
  w = maxFrame.w / 2,
  h = maxFrame.h,
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
        appWindow:setFrame(position)
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
