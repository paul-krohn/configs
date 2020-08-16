--- reload config
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

local v60hyper = {}
local globalHyper = {"ctrl", "alt"}
local primaryScreen = hs.screen.primaryScreen()
local primaryScreenMenuBarOffset = primaryScreen:frame().y


local screenDimensionFigurer = {}
screenDimensionFigurer.__index = screenDimensionFigurer

function screenDimensionFigurer.new(win)
  local self = setmetatable({}, screenDimensionFigurer)

  self.margin = 10

  self.win = win
  self.frame = win:frame()
  local screen = win:screen()
  self.max = screen:frame()
  self.menuBarOffset = win:screen():frame().y

  self.frame.x = self.margin
  self.frame.y = self.margin + self.menuBarOffset
  self.frame.w = self.max.w - (2 * self.margin)
  self.frame.h = self.max.h - (2 * self.margin) - self.menuBarOffset

  return self

end


hs.hotkey.bind({"alt", "ctrl"}, "x", function()
  local sdf = screenDimensionFigurer.new(hs.window.focusedWindow())

  sdf.frame.h = sdf.max.h / 2

  sdf.win:setFrame(sdf.frame)
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
