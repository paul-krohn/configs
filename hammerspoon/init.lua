--- reload config
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

local v60hyper = {}
local globalHyper = {"ctrl", "alt"}
local primaryScreen = hs.screen.primaryScreen()
local primaryScreenMenuBarOffset = primaryScreen:frame().y


screenDimensionFigurer = {}
screenDimensionFigurer.__index = screenDimensionFigurer

function screenDimensionFigurer:new(win, useCurrentSize)
  local self = setmetatable({}, screenDimensionFigurer)

  self.size = {x = 0, y = 0, h = 100, w = 100}

  self.margin = 10

  self.win = win
  self.frame = win:frame()
  local screen = win:screen()
  self.max = screen:frame()
  self.menuBarOffset = win:screen():frame().y

  useCurrentSize = useCurrentSize or false
  print(string.format("use current size: %s", useCurrentSize))
  if useCurrentSize then
   self:guessSize()
  end

  return self

end

function screenDimensionFigurer:guessSize()

  -- print(string.format("the frame we are guessing from: x: %s w: %s y: %s h: %s", self.frame.x, self.frame.w, self.frame.y, self.frame.h))

  local abuts = {
    l = self.frame.x <= self.margin,
    r = self.frame.x + self.frame.w >= self.max.w - self.margin,
    t = self.frame.y <= self.menuBarOffset + self.margin,
    b = self.frame.y + self.frame.h >= self.max.h - self.margin
  }

  -- print(string.format("abutments: l: %s r: %s, t: %s, b: %s", abuts.l, abuts.r, abuts.t, abuts.b))

  if abuts.l and abuts.r then
    self.size.x = 0
    self.size.w = 100
  elseif abuts.l and not abuts.r then
    self.size.x = 0
    self.size.w = (self.frame.w + self.margin * 1.5) / self.max.w * 100
  elseif not abuts.l and abuts.r then
    self.size.x = (self.frame.x - self.margin * 0.5) / self.max.w * 100
    self.size.w = (self.frame.w + self.margin) / self.max.w * 100
  else  -- abuts neither is the remaining case
    self.size.x = (self.frame.x - self.margin * 0.5) / self.max.w * 100
    self.size.w = (self.frame.w + self.margin) / self.max.w * 100
  end

  if abuts.t and abuts.b then
    self.size.y = 0
    self.size.h = 100
  elseif abuts.t and not abuts.b then
    self.size.y = 0
    self.size.h = (self.frame.h + self.margin * 1.5) / self.max.h * 100
  elseif not abuts.t and abuts.b then
    self.size.y = (self.frame.y - self.menuBarOffset - self.margin * 0.5) / self.max.h * 100
    self.size.h = (self.frame.h + self.margin) / self.max.h * 100
  else
    self.size.y = (self.frame.y - self.menuBarOffset - self.margin * 0.5) / self.max.h * 100
    self.size.h = (self.frame.h + self.margin) / self.max.h * 100
  end

  print(string.format("we guessed: x: %s w: %s y: %s h: %s", self.size.x, self.size.w, self.size.y, self.size.h))
end

function screenDimensionFigurer.move(self)

  local offsets = {left = self.margin, right = self.margin, top = self.margin, bottom = self.margin}
  if self.size.x ~= 0 then
    offsets.left = 0.5 * self.margin
  end

  if self.size.x + self.size.w <= 99 then
    offsets.right = 0.5 * self.margin
  end

  if self.size.y ~= 0 then
    offsets.top = 0.5 * self.margin
  end

  if self.size.y + self.size.h <= 99 then
    offsets.bottom = 0.5 * self.margin
  end

  self.frame.x = (self.max.w * self.size.x / 100) + offsets.left
  self.frame.w = (self.max.w * self.size.w / 100) - offsets.left - offsets.right
  self.frame.y = (self.max.h * self.size.y / 100) + offsets.top + self.menuBarOffset
  self.frame.h = (self.max.h * self.size.h / 100) - offsets.top - offsets.bottom

  self.win:setFrame(self.frame)
end

function screenDimensionFigurer.getSizeWithOffsets(self, hw)

  local baseSize = self.frame.w
  if hw == 'h' then
    baseSize = self.frame.h
  end
  print("the frame: " , self.frame)

  marginShave = 1 * self.margin -- still doesn't do rh margins right
  if percent == 100 then
    marginShave = 0
  end

  local newSize = baseSize * percent / 100 - marginShave
  print("new size: ", newSize)
  return newSize

end

hs.hotkey.bind({"alt", "ctrl"}, "a", function()
  local sdf = screenDimensionFigurer:new(hs.window.focusedWindow())

  sdf.size.h = 55
  sdf.size.w = 55

  sdf:move()
end)

hs.hotkey.bind({"alt", "ctrl"}, "z", function()
  local sdf = screenDimensionFigurer:new(hs.window.focusedWindow())

  sdf.size.y = 55
  sdf.size.h = 45
  sdf.size.w = 55

  sdf:move()
end)

hs.hotkey.bind({"alt", "ctrl"}, "s", function()
  local sdf = screenDimensionFigurer:new(hs.window.focusedWindow())

  sdf.size.x = 55
  sdf.size.h = 65
  sdf.size.w = 45

  sdf:move()
end)

hs.hotkey.bind({"alt", "ctrl"}, "x", function()
  local sdf = screenDimensionFigurer:new(hs.window.focusedWindow())

  sdf.size.x = 55
  sdf.size.y = 65
  sdf.size.h = 35
  sdf.size.w = 45

  sdf:move()
end)

hs.hotkey.bind({"alt", "ctrl"}, "f", function()
  local sdf = screenDimensionFigurer:new(hs.window.focusedWindow())
  -- no resizing/use default full-screen size
  sdf:move()
end)

hs.hotkey.bind({"alt", "ctrl"}, "up", function()
  local sdf = screenDimensionFigurer:new(hs.window.focusedWindow(), true)
  -- no resizing/use default full-screen size
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
