---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/20 16:26
---

---@class Color: BaseObject
local Color = require('sys.core.base.object'):extend()
Color.__name = 'Color'

function Color:new(r, g, b, a)
  self.r = r or 0
  self.g = g or 0
  self.b = b or 0
  self.a = a or 255

  self._mode_01 = false
end

function Color:mode_01(mode_01)
  self._mode_01 = mode_01
  return self
end

function Color:change(r, g, b, a)
  self.r = r or 0
  self.g = g or 0
  self.b = b or 0
  if self._mode_01 then
    self.a = a or 1
  else
    self.a = a or 255
  end
end

function Color:unpack()
  return self.r, self.g, self.b, self.a
end

function Color:convert_255()
  if self._mode_01 then
    self.r = self.r * 255
    self.g = self.g * 255
    self.b = self.b * 255
    self.a = self.a * 255
  end
  return self
end

function Color:convert_01()
  if not self._mode_01 then
    self.r = self.r / 255
    self.g = self.g / 255
    self.b = self.b / 255
    self.a = self.a / 255
  end
  return self
end

return Color
