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
-- if only this worked; apparently a moving/breaking target on every os release
hs.window.setShadows(false)

hs.loadSpoon("PaulWindowManager")

spoon.PaulWindowManager.log.level = 'warning'
spoon.PaulWindowManager.margin = 10

-- define a few aliases for both key bindings and app defaults
halfLeft = {
  w = 55
}

upperRight = {
  h = 50,
  w = 45,
  x = 55,
}

lowerRight = {
  h = 50,
  w = 45,
  x = 55,
  y = 50,
}

macro_mash = {"ctrl", "alt"}

spoon.PaulWindowManager:bindKeys{
  sizes = {
    {mash = macro_mash, key = "q", size = {h = 65, w = 55}},
    {mash = macro_mash, key = "w", size = {h = 65}},
    {mash = macro_mash, key = "e", size = upperRight},

    {mash = macro_mash, key = "a", size = halfLeft},
    {mash = macro_mash, key = "s", size = {}},
    {mash = macro_mash, key = "d", size = {        w = 45, x = 55}},

    {mash = macro_mash, key = "z", size = {h = 35, w = 55,         y = 65}},
    {mash = macro_mash, key = "x", size = {h = 35,                 y = 65}},
    {mash = macro_mash, key = "c", size = lowerRight},
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
  }
}
