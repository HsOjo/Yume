---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/22 00:03
---

---@class BaseUpdatable: BaseNestable
---@field super BaseNestable
---@field parent BaseUpdatable
---@field children BaseUpdatable[]
local BaseUpdatable = require('sys.core.base.nestable'):extend()
BaseUpdatable.__name = 'Updatable'

function BaseUpdatable:new()
  BaseUpdatable.super.new(self)
  self.speed = 1
  self.active = true
end

function BaseUpdatable:setSpeed(speed)
  self.speed = speed
end

function BaseUpdatable:setActive(active)
  self.active = active
end

function BaseUpdatable:update(dt)
  self:updateChildren(dt)
end

function BaseUpdatable:updateChildren(dt)
  for _, child in pairs(self.children) do
    if child:is(BaseUpdatable) then
      child:update(dt)
    end
  end
end

function BaseUpdatable:updateCall(dt)
  if not self.active then
    return
  end

  dt = dt * self.speed
  self:update(dt)
end

return BaseUpdatable
