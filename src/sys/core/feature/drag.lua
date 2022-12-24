---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/19 19:38
---

local Point = require('sys.core.feature.point')
local Mouse = require('sys.core.input.mouse')
local Event = require('sys.core.feature.event')
local BaseDrawable = require('sys.core.base.drawable')

---@class Drag: Updatable
local Drag = require('sys.core.base.updatable'):extend()
Drag.__name = 'Drag'
Drag.EVENT_BEGIN = 1
Drag.EVENT_MOVING = 2
Drag.EVENT_FINISHED = 3

Drag.MODE_FREE = 1
Drag.MODE_HORIZONTAL = 2
Drag.MODE_VERTICAL = 3

---@param object BaseDrawable
function Drag:new(object, mode)
  Drag.super.new(self)

  self.event = Event()
  self.mode = mode or Drag.MODE_FREE
  self.object = object

  ---@type BaseShape[]
  self.shapes = {}

  ---@param point Point
  self.test_function = function(point)
    for _, shape in pairs(self.shapes) do
      if shape:testPoint(point) then
        return true
      end
    end
    return false
  end

  self.start_position = Point()
  self.new_position = Point()
  self.mouse_start_position = Point()

  self.is_dragging = false
  self.smooth_moving = false
end

---@param shape BaseShape
function Drag:addShape(shape)
  table.insert(self.shapes, shape)
  return shape
end

---@param smooth_moving boolean
function Drag:setSmoothMoving(smooth_moving)
  self.smooth_moving = smooth_moving
end

---@param test_function fun(point: Point)
function Drag:setTestFunction(test_function)
  self.test_function = test_function
end

function Drag:cancel()
  self.is_dragging = false
  if self.start_position then
    self.object:setPosition(self.start_position:unpack())
  end
end

function Drag:update()
  if not self.is_dragging then
    if Mouse.key(Mouse.KEY_L):isDown() then
      if self.test_function(Mouse.position()) then
        self.start_position:base(self.object.position)
        self.mouse_start_position:base(Mouse.position())
        self.is_dragging = true
        self.event:emit(Drag.EVENT_BEGIN)
      end
    end
  else
    local new_position = self.new_position
    new_position:base(Mouse.position()):offset(self.mouse_start_position, -1)

    local parent = self.object.parent
    if parent and parent:is(BaseDrawable) then
      new_position:scale(parent:drawScale(), true)
    end

    new_position:offset(self.start_position)

    if self.mode == Drag.MODE_HORIZONTAL then
      new_position.y = self.start_position.y
    elseif self.mode == Drag.MODE_VERTICAL then
      new_position.x = self.start_position.x
    end

    if self.smooth_moving then
      local distance = self.object.position:distance(new_position)
      if distance > self.speed then
        self.object.position:move(
          self.object.position:angel(new_position),
          distance * 32 * self.speed * love.timer.getAverageDelta()
        )
        self.object:computeDrawPosition()
      else
        self.object:setPosition(new_position:unpack())
      end
    else
      self.object:setPosition(new_position:unpack())
    end
    self.event:emit(Drag.EVENT_MOVING, self.object.position)

    if Mouse.key(Mouse.KEY_L):isUp() then
      self.object:setPosition(new_position:unpack())
      self.is_dragging = false
      self.event:emit(Drag.EVENT_FINISHED, new_position)
    end
  end
end

return Drag
