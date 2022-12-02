---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/11 00:03
---

---@class Sprite: Node
---@field super Node
---@field drawable Image
local Sprite = require('sys.core.base.node'):extend()
Sprite.__name = 'Sprite'

function Sprite:new(image)
  Sprite.super.new(self)
  self:setDrawable(image)
end

function Sprite.loadFromFile(path)
  return Sprite(love.graphics.newImage(path))
end

return Sprite