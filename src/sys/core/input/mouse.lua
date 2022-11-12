---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/11 12:30
---

local Key = require('sys.core.input.key')
local Point = require('sys.core.util.point')

---@class Mouse
local Mouse = {
  KEY_PREFIX = 'mouse_',
  KEY_L = '1',
  KEY_R = '2',
  KEY_M = '3',
}

Mouse._status = {
  position = Point(0, 0),
  wheel = Point(0, 0),
  is_touch = false,
}

function Mouse.position()
  return Mouse._status.position
end

function Mouse.wheel()
  return Mouse._status.wheel
end

function Mouse.isTouch()
  return Mouse._status.is_touch
end

function Mouse.key(code)
  return Key(Mouse.KEY_PREFIX .. code)
end

function Mouse.callback_updated()
  Mouse._status.wheel = Point(0, 0)
end

function Mouse.callback_moved(x, y, is_touch)
  Mouse._status.position = Point(x, y)
  Mouse._status.is_touch = is_touch
end

function Mouse.callback_wheel_moved(x, y)
  Mouse._status.wheel = Point(x, y)
end

return Mouse
