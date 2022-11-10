---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/11 01:01
---

---@class Rotatable: BaseObject
local Rotatable = require('sys.core.object.base'):extend()

function Rotatable:new()
  Rotatable.super.new(self)
  self.r = 0
  self.ox = 0
  self.oy = 0
end

function Rotatable:setRotation(r)
  self.r = r
end

function Rotatable:setOrigin(x, y)
  self.ox, self.oy = x, y
end

return Rotatable
