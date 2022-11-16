---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/12 19:24
---

---@class Point: ClassicObject
local Point = require('sys.3rd.classic'):extend()

function Point:new(x, y)
  self.x, self.y = x, y
end

---@param point Point
function Point:offset(point)
  return Point(self.x + point.x, self.y + point.y)
end

---@param point Point
function Point:scale(point)
  return Point(self.x * point.x, self.y * point.y)
end

function Point:reverse()
  return Point(-self.x, -self.y)
end

function Point:unpack()
  return self.x, self.y
end

return Point
