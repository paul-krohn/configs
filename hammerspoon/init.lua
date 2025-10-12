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
logger = hs.logger.new('main', 'debug')

-- define a few aliases for both key bindings and app defaults
halfLeft = {
  h = 80,
  w = 40,
  x = 10,
  y = 0
}

halfRight = {
  h = 80,
  w = 40,
  x = 50,
  y = 0
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
  w = 50,
}

centerBottom = {
  x = 28,
  y = 60,
  h = 40,
  w = 44,
}

tallRight = {
  w = 50,
  x = 50,
}

wideTop = {
  h = 80,
  w = 80,
  x = 10,
  y = 0,
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

biggen = {
  h = 75,
  w = 50,
  x = 22,
  y = 0
}

macro_mash = {"ctrl", "alt"}
shift_mash = {"shift", "ctrl", "alt"}
spoon.PaulWindowManager:bindKeys{
  sizes = {
    {mash = macro_mash, key = "q", size = centeredLeft},
    {mash = macro_mash, key = "w", size = centeredCenter},
    {mash = macro_mash, key = "f", size = centeredRight},

    {mash = shift_mash, key = "q", size = halfoTopLeft},
    {mash = shift_mash, key = "w", size = wideTop},
    {mash = shift_mash, key = "f", size = halfoTopRight},

    {mash = macro_mash, key = "a", size = halfLeft},
    {mash = shift_mash, key = "a", size = tallLeft},
    {mash = macro_mash, key = "r", size = centeredFullHeight},
    {mash = macro_mash, key = "s", size = halfRight},
    {mash = shift_mash, key = "s", size = tallRight},

    {mash = macro_mash, key = "z", size = smallLeftBottom},
    {mash = shift_mash, key = "z", size = halfLeftBottom},
    {mash = macro_mash, key = "x", size = centerBottom},
    {mash = macro_mash, key = "c", size = smallRightBottom},
    {mash = shift_mash, key = "c", size = halfRightBottom},

    {mash = shift_mash, key = "w", size = wideTop},
    {mash = shift_mash, key = "r", size = {}},
    {mash = shift_mash, key = "x", size = wideBottom},
    {mash = macro_mash, key = "b", size = biggen}
  },
  deltas = {
    {mash = macro_mash, key = "up", delta = 10, hw = 'h'},
    {mash = macro_mash, key = "down", delta = -10, hw = 'h'},
    {mash = macro_mash, key = "left", delta = -10, hw = 'w'},
    {mash = macro_mash, key = "right", delta = 10, hw = 'w'},
  },
  stack = {
    {mash = macro_mash, key = "p"},
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

hs.hotkey.bind(macro_mash, "-", function()
    hs.itunes.volumeDown()
    hs.alert(string.format("iTunes volume: %s", hs.itunes.getVolume()))
end)

hs.hotkey.bind(macro_mash, "=", function()
    hs.itunes.volumeUp()
    hs.alert(string.format("iTunes volume: %s", hs.itunes.getVolume()))
  end)

hs.hotkey.bind(macro_mash, "v", function()
    hs.hid.capslock.toggle()
end)

function copy_password(key)
    command = string.format("/opt/homebrew/bin/op item get \"%s\" --fields password --reveal | tr -d \"\n\"| pbcopy", key)
    local result = hs.execute(command)
    switchback()
    hs.alert(string.format("sent %s password to clipboard", key))
end

hs.hotkey.bind(macro_mash, "j", function()
  copy_password("AWS workspaces sjdev")
end)
hs.hotkey.bind(macro_mash, "l", function()
  copy_password("AWS workspaces sdev2")
end)
hs.hotkey.bind(macro_mash, "u", function()
  copy_password("AWS workspaces sjstage")
end)
hs.hotkey.bind(macro_mash, "y", function()
  copy_password("user-login")
end)

function switchback()
  -- check if this is an open, maybe locked workspaces session; we need to switch focus
  -- away and back to sync clipboards
  frontWindow = hs.window.frontmostWindow()
  if frontWindow:title() == "Amazon WorkSpaces" and frontWindow:application():name() == "WorkSpaces" then
    hs.application.launchOrFocus("Finder")
    hs.application.launchOrFocus("WorkSpaces")
  end
end
