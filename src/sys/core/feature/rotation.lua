---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/11 01:01
---

local Point = require('sys.core.feature.point')

---@class Rotation: BaseObject
local Rotation = require('sys.core.base.object'):extend()
Rotation.__name = 'Rotation'

function Rotation:new()
  self.radians = 0
  self.origin = Point(0, 0)
end

function Rotation:setOrientation(radians)
  self.radians = radians
end

function Rotation:setOrigin(x, y)
  self.origin:change(x, y)
end

return Rotation
