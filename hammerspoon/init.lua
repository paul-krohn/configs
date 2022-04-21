--- reload config
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

local primaryScreen = hs.screen.primaryScreen()
local primaryScreenMenuBarOffset = primaryScreen:frame().y
hs.window.animationDuration = 0
-- if only this worked; apparently a moving/breaking target on every os release
hs.window.setShadows(false)

hs.loadSpoon("PaulWindowManager")

spoon.PaulWindowManager.log.level = 'warning'
spoon.PaulWindowManager.margin = 10

-- define a few aliases for both key bindings and app defaults
halfLeft = {
  w = 50
}

upperRight = {
  h = 58,
  w = 50,
  x = 50,
}

lowerRight = {
  h = 42,
  w = 50,
  x = 50,
  y = 58,
}

centeredCenter = {
  h = 60,
  w = 44,
  x = 28,
  y = 0,
}

centeredLeft = {
  h = 60,
  w = 28,
  x = 0,
  y = 0,
}

centeredRight = {
  h = 60,
  w = 28,
  x = 72,
  y = 0,
}

centeredBottomLeft = {
  h = 40,
  w = 50,
  x = 0,
  y = 60,
}

centeredBottomRight = {
  h = 40,
  w = 50,
  x = 50,
  y = 60,
}

centeredFullHeight = {
  h = 100,
  w = 44,
  x = 28,
  y = 0,
}


halfoTopLeft = {
  h = 60,
  w = 50,
  x = 0,
  y = 0,
}

halfoTopRight = {
  h = 60,
  w = 50,
  x = 50,
  y = 0,
}

tallLeft = {
  w = 28,
}

centerBottom = {
  x = 28,
  y = 60,
  h = 40,
  w = 44,
}

tallRight = {
  w = 28,
  x = 72,
}

wideTop = {
  h = 60
}

wideBottom = {
  h = 40,
  y = 60
}

smallLeftBottom = {
  h = 40,
  y = 60,
  w = 28,
}

smallRightBottom = {
  h = 40,
  y = 60,
  w = 28,
  x = 72,
}
halfRightBottom = {
  h = 40,
  y = 60,
  w = 50,
  x = 50,
}

halfLeftBottom = {
  h = 40,
  y = 60,
  w = 50,
  x = 0,
}

macro_mash = {"ctrl", "alt"}
shift_mash = {"shift", "ctrl", "alt"}
spoon.PaulWindowManager:bindKeys{
  sizes = {
    {mash = macro_mash, key = "q", size = centeredLeft},
    {mash = macro_mash, key = "w", size = centeredCenter},
    {mash = macro_mash, key = "e", size = centeredRight},

    {mash = shift_mash, key = "q", size = halfoTopLeft},
    {mash = shift_mash, key = "w", size = wideTop},
    {mash = shift_mash, key = "e", size = halfoTopRight},

    {mash = macro_mash, key = "a", size = tallLeft},
    {mash = macro_mash, key = "s", size = centeredFullHeight},
    {mash = macro_mash, key = "d", size = tallRight},

    {mash = macro_mash, key = "z", size = smallLeftBottom},
    {mash = shift_mash, key = "z", size = halfLeftBottom},
    {mash = macro_mash, key = "x", size = centerBottom},
    {mash = macro_mash, key = "c", size = smallRightBottom},
    {mash = shift_mash, key = "c", size = halfRightBottom},

    {mash = shift_mash, key = "w", size = wideTop},
    {mash = shift_mash, key = "s", size = {}},
    {mash = shift_mash, key = "x", size = wideBottom}
  },
  deltas = {
    {mash = macro_mash, key = "up", delta = 10, hw = 'h'},
    {mash = macro_mash, key = "down", delta = -10, hw = 'h'},
    {mash = macro_mash, key = "left", delta = -10, hw = 'w'},
    {mash = macro_mash, key = "right", delta = 10, hw = 'w'},
  },
  stack = {
    {mash = macro_mash, key = "t"},
  },
  appDefaults = {
    positions = {
      Atom = halfLeft,
      ['Google Chrome'] = halfLeft,
      ['IntelliJ IDEA'] = halfLeft,
      iTerm2 = upperRight,
      PyCharm = halfLeft,
      Safari = halfLeft,
      Slack = lowerRight,
    },
    mash = macro_mash,
    key = "p",
  },
  next = {
    {mash = macro_mash,     key = "n"},
  },
  mic = {
    {mash = macro_mash,     key = "m"},
  },
  audiosummary = {
    {mash = macro_mash, key = "u"}
  }
}
