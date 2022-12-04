---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/11 01:01
---

local Point = require('sys.core.feature.point')

---@class Rotatable: BaseDrawable
---@field super BaseDrawable
---@field parent Rotatable
local Rotatable = require('sys.core.base.drawable'):extend()
Rotatable.__name = 'Rotatable'

function Rotatable:new()
  Rotatable.super.new(self)
  self.radians = 0
  self.origin = Point(0, 0)

  self._draw_radians = self.radians
end

function Rotatable:setOrientation(radians)
  self.radians = radians
  self:computeDrawOrientation()
end

function Rotatable:drawOrientation()
  return self._draw_radians
end

function Rotatable:computeDrawOrientation()
  self._draw_radians = self.radians
  if self.parent and self.parent:is(Rotatable) then
    self._draw_radians = self._draw_radians + self.parent._draw_radians
  end
  ---@param child Rotatable
  self:batchChildren(function(child, index)
    child:computeDrawOrientation()
  end, Rotatable)
end

function Rotatable:setOrigin(x, y)
  self.origin:change(x, y)
end

return Rotatable
