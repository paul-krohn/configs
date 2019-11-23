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
left_third = 0.45
middle_third = 0.38
right_third = 0.26
padding_size = 20

-- full screen
hs.hotkey.bind({"alt", "ctrl"}, "s", function()
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
hs.hotkey.bind({"alt", "ctrl"}, "j", function()
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
hs.hotkey.bind({"alt", "ctrl"}, "k", function()
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

-- left "third"
hs.hotkey.bind({"alt", "ctrl"}, "a", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + padding_size
  -- f.y = max.y
  f.y = 2 * padding_size
  f.w = max.w * left_third - padding_size
  f.h = max.h - 2 * padding_size
  win:setFrame(f)
end)


-- middle "third"
hs.hotkey.bind({"alt", "ctrl"}, "w", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w * left_third + padding_size
  f.y = 2 * padding_size
  f.w = max.w * (1 - left_third) - 2 * padding_size
  f.h = max.h / 2 - padding_size
  win:setFrame(f)
end)

-- right "third"
hs.hotkey.bind({"alt", "ctrl"}, "x", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w * left_third + padding_size
  f.y = max.h / 2 - screenFrameHeightDiff(win) + padding_size
  f.w = max.w * (1 - left_third) - 2 * padding_size
  f.h = max.h / 2 - (2 * padding_size)
  win:setFrame(f)
end)

-- right  two thirds
hs.hotkey.bind({"alt", "ctrl"}, "d", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w * left_third + padding_size
  f.y = 2 * padding_size
  f.w = max.w * (1 - left_third) - 2 * padding_size
  f.h = max.h - 2 * padding_size
  win:setFrame(f)
end)
