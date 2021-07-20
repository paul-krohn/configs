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

spoon.PaulWindowManager:bindKeys{
  sizes = {
    {mash = {},              key = "f13",  size = {h = 65, w = 55}},
    {mash = {"ctrl", "alt"}, key = "q",    size = {h = 65, w = 55}},
    {mash = {},              key = "f14",  size = {h = 65}},
    {mash = {"ctrl", "alt"}, key = "w",    size = {h = 65}},
    {mash = {},              key = "f15",  size = upperRight},
    {mash = {"ctrl", "alt"}, key = "e",    size = upperRight},

    {mash = {},              key = "pad-", size = halfLeft},
    {mash = {"ctrl", "alt"}, key = "a",    size = halfLeft},
    {mash = {},              key = "pad+", size = {}},
    {mash = {"ctrl", "alt"}, key = "s",    size = {}},
    {mash = {},              key = "padenter", size = {    w = 45, x = 55}},
    {mash = {"ctrl", "alt"}, key = "d",    size = {        w = 45, x = 55}},

    {mash = {},              key = "pad7", size = {h = 35, w = 55,         y = 65}},
    {mash = {"ctrl", "alt"}, key = "z",    size = {h = 35, w = 55,         y = 65}},
    {mash = {},              key = "pad8", size = {h = 35,                 y = 65}},
    {mash = {"ctrl", "alt"}, key = "x",    size = {h = 35,                 y = 65}},
    {mash = {},              key = "pad9", size = lowerRight},
    {mash = {"ctrl", "alt"}, key = "c",    size = lowerRight},
  },
  deltas = {
    {mash = {"ctrl", "alt"}, key = "up", delta = 10, hw = 'h'},
    {mash = {"ctrl", "alt"}, key = "down", delta = -10, hw = 'h'},
    {mash = {"ctrl", "alt"}, key = "left", delta = -10, hw = 'w'},
    {mash = {"ctrl", "alt"}, key = "right", delta = 10, hw = 'w'},
  },
  stack = {
    {mash = {}, key = "f17"},
    {mash = {"ctrl", "alt"}, key = "t"},
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
    mash = {"ctrl", "alt"},
    key = "p",
  },
  next = {
    {mash = {}, key = "pad="},
    {mash = {"ctrl", "alt"}, key = "n"},
  },
  mic = {
    {mash = {"ctrl", "alt"}, key = "m"},
    {mash = {}, key = "pad,"},
  }
}
