-- reload config
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

function screenFrameHeightDiff(win)
  local screen = win:screen()
  local fr = screen:frame()
  local ff = screen:fullFrame()
  return ff.y - fr.y
end
-- define sizes of the 'large' vs 'small' left/right sections
small = 0.35
large = 0.65

-- left small
hs.hotkey.bind({"alt", "ctrl"}, "U", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w * small
  f.h = max.h
  win:setFrame(f)
end)

-- left large
hs.hotkey.bind({"alt", "ctrl"}, "I", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w * large
  f.h = max.h
  win:setFrame(f)
end)

-- right large
hs.hotkey.bind({"alt", "ctrl"}, "O", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w * small)
  f.y = max.y
  f.w = max.w * large
  f.h = max.h
  win:setFrame(f)
end)

-- right small
hs.hotkey.bind({"alt", "ctrl"}, "P", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.w - (max.w * small)
  f.y = max.y
  f.w = max.w * small
  f.h = max.h
  win:setFrame(f)
end)

-- upper right small
hs.hotkey.bind({"alt", "ctrl"}, ";", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + large * max.w
  f.y = max.y
  f.w = max.w * small
  f.h = max.h / 2
  win:setFrame(f)
end)

-- lower right small
hs.hotkey.bind({"alt", "ctrl"}, "/", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + large * max.w
  f.y = max.y + max.h / 2
  f.w = max.w * small
  f.h = max.h / 2
  win:setFrame(f)
end)

-- full screen
hs.hotkey.bind({"alt", "ctrl"}, "m", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end)

-- half left
hs.hotkey.bind({"alt", "ctrl"}, "q", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- half right
hs.hotkey.bind({"alt", "ctrl"}, "w", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w / 2
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- half top left
hs.hotkey.bind({"alt", "ctrl"}, "a", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

-- top right half/half
hs.hotkey.bind({"alt", "ctrl"}, "s", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.w /2
  f.y = 0
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

-- bottom left half.half
hs.hotkey.bind({"alt", "ctrl"}, "z", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.h / 2 - screenFrameHeightDiff(win)
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

-- bottom right half.half
hs.hotkey.bind({"alt", "ctrl"}, "x", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.w / 2
  f.y = max.h / 2 - screenFrameHeightDiff(win)
œf.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)
