---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/12 19:24
---

---@class Point: BaseObject
local Point = require('sys.core.base.object'):extend()

function Point:new(x, y)
  self.x, self.y = x, y
end

function Point:change(x, y)
  self.x, self.y = x, y
  return self
end

function Point:unpack()
  return self.x, self.y
end

---@param point Point
function Point:base(point)
  return self:change(point:unpack())
end

function Point:copy()
  return Point(self:unpack())
end

---@param point Point
function Point:offset(point, scale)
  scale = scale or 1
  return self:change(
    self.x + point.x * scale,
    self.y + point.y * scale
  )
end

---@param point Point
function Point:scale(point)
  return self:change(
    self.x * point.x,
    self.y * point.y
  )
end

function Point:move(radians, distance)
  return self:change(
    self.x + distance * math.cos(radians),
    self.y + distance * math.sin(radians)
  )
end

---@param point Point
function Point:distance(point)
  return math.sqrt(
    math.pow(self.x - point.x, 2)
      + math.pow(self.y - point.y, 2)
  )
end

---@param point Point
---@return number radians of two points.
function Point:angel(point)
  local pi = math.pi
  if self.x == point.x then
    if self.y > point.y then
      return pi * 0.5
    else
      return pi * 1.5
    end
  elseif self.y == point.y then
    if self.x > point.x then
      return 0
    else
      return pi
    end
  else
    local radians = math.atan((point.y - self.y) / (point.x - self.x))
    if self.x < point.x and self.y > point.y then
      return radians + pi
    elseif self.x < point.x and self.y < point.y then
      return radians + pi
    elseif self.x > point.x and self.y < point.y then
      return radians + 2 * pi
    else
      return radians
    end
  end
end

return Point
