---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/11 19:09
---

local Mouse = require('sys.core.input.mouse')

---@class Button: Widget
local Button = require('sys.core.base.widget'):extend()
Button.__name = 'Button'

Button.STATUS_NORMAL = 1
Button.STATUS_HOVER = 2
Button.STATUS_PRESS = 3
Button.STATUS_DISABLED = 4

Button.EVENT_CLICKED = 1

function Button:new(normal, hover, press, disabled)
  Button.super.new(self)

  self.status = nil
  ---@type table<number, Node>
  self.nodes = {
    [Button.STATUS_NORMAL] = normal,
    [Button.STATUS_HOVER] = hover,
    [Button.STATUS_PRESS] = press,
    [Button.STATUS_DISABLED] = disabled,
  }

  for status, node in pairs(self.nodes) do
    self.nodes[status] = self:bind(node)
  end

  self:setStatus(Button.STATUS_NORMAL)
end

function Button:currentNode()
  return self.nodes[self.status] or self.nodes[Button.STATUS_NORMAL]
end

function Button:setStatus(status)
  self.status = status
  for _, node in pairs(self.nodes) do
    node:setVisible(false)
  end
  self:currentNode():setVisible(true)
end

function Button:update()
  if self.status == Button.STATUS_DISABLED then
    return
  end

  local current_node = self:currentNode()
  local is_mouse_cover = current_node.rect:testPoint(Mouse.position())

  if self.status == Button.STATUS_NORMAL then
    if self.focus or is_mouse_cover then
      self:setStatus(Button.STATUS_HOVER)
    end
  elseif self.status == Button.STATUS_HOVER then
    if is_mouse_cover then
      if Mouse.key(Mouse.KEY_L):isDown() then
        self:setStatus(Button.STATUS_PRESS)
      end
    elseif not self.focus then
      self:setStatus(Button.STATUS_NORMAL)
    end
  elseif self.status == Button.STATUS_PRESS then
    if Mouse.key(Mouse.KEY_L):isUp() then
      if is_mouse_cover then
        self.event:emit(Button.EVENT_CLICKED)
        self:setStatus(Button.STATUS_HOVER)
      else
        self:setStatus(Button.STATUS_NORMAL)
      end
    end
  end

  Button.super.update(self)
end

return Button