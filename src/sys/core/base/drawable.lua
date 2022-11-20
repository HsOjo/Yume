---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/10 20:19
---

local Table = require('sys.core.util.table')
local Point = require('sys.core.feature.point')

---@class BaseDrawable: BaseObject
local BaseDrawable = require('sys.core.base.object'):extend()

function BaseDrawable:new()
  self.position = Point(0, 0)
  self.scale = Point(1, 1)

  ---@type BaseEffect[]
  self.effects = {}

  self.parent = nil
  self.children = {}

  self.visible = true

  self._draw_position = Point()
  self._draw_scale = Point()
end

---@param child BaseDrawable
function BaseDrawable:bind(child)
  local index
  local parent = child.parent
  if parent ~= self then
    if parent ~= nil then
      Table.remove(parent.children, child)
    end

    index = table.insert(self.children, child)
    child.parent = self
  end

  return child, index
end

---@param x number
---@param y number
function BaseDrawable:setPosition(x, y)
  self.position:change(x or 0, y or 0)
end

---@param sx number
---@param sy number
function BaseDrawable:setScale(sx, sy)
  self.scale:change(sx or 1, sy or 1)
end

---@param effect BaseEffect
function BaseDrawable:applyEffect(effect)
  self.effects[effect:getClass()] = effect
end

function BaseDrawable:clearEffect(effect_class)
  if effect_class then
    self.effects[effect_class] = nil
  else
    self.effects = {}
  end
end

function BaseDrawable:setVisible(visible)
  self.visible = visible
end

function BaseDrawable:drawPosition()
  local draw_position = self._draw_position:base(self.position)
  if self.parent then
    return draw_position:scale(self.parent:drawScale()):offset(self.parent:drawPosition())
  end
  return draw_position
end

function BaseDrawable:drawScale()
  local draw_scale = self._draw_scale:base(self.scale)
  if self.parent then
    return draw_scale:scale(self.parent:drawScale())
  end
  return draw_scale
end

function BaseDrawable:draw()
  self:drawChildren()
end

function BaseDrawable:drawChildren()
  ---@param child BaseDrawable
  for _, child in pairs(self.children) do
    child:drawCall()
  end
end

function BaseDrawable:drawCall()
  if not self.visible then
    return
  end

  for _, effect in pairs(self.effects) do
    effect:drawBefore()
  end
  self:draw()
  for _, effect in pairs(self.effects) do
    effect:drawAfter()
  end
end

function BaseDrawable:release()
  for _, child in pairs(self.children) do
    child:release()
  end
  self.parent = nil
end

return BaseDrawable
