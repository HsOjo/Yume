---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/19 14:46
---

local Color = require('sys.core.feature.color')

---@class ColorEffect: Effect
local ColorEffect = require('sys.core.base.effect'):extend()
ColorEffect.__name = 'ColorEffect'

function ColorEffect:new(...)
  self.color = Color(...)
  self.prev_color = Color()
end

function ColorEffect:drawBefore()
  self.prev_color:change(love.graphics.getColor())
  love.graphics.setColor(self.color:unpack())
end

function ColorEffect:drawAfter()
  love.graphics.setColor(self.prev_color:unpack())
end

return ColorEffect
