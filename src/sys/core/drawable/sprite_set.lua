---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/16 22:23
---

local json = require('sys.3rd.json')
local Point = require('sys.core.feature.point')
local Sprite = require('sys.core.drawable.node.sprite')

---@class SpriteSet: BaseDrawable
local SpriteSet = require('sys.core.base.drawable'):extend()
SpriteSet.__name = 'SpriteSet'

function SpriteSet:new()
  SpriteSet.super.new(self)

  ---@type Sprite[]
  self.sprites = {}
  ---@type Point[]
  self.offsets = {}
  self.current_index = nil
end

---@return SpriteSet
function SpriteSet.loadFromDirectory(dir, color)
  local info = json.decode(love.filesystem.read(dir .. '/info.json'))
  local sprite_dir = string.format('%s/image', dir)
  if color then
    sprite_dir = string.format('%s_color_%d', sprite_dir, color)
  end

  local pack = SpriteSet()
  ---@param pos table
  for index, pos in ipairs(info) do
    pack.offsets[index] = Point(pos.x, pos.y)
    pack.sprites[index] = pack:bind(
      Sprite.loadFromFile(string.format('%s/%d.png', sprite_dir, index - 1))
    )
  end

  pack:setCurrentFrame(1)
  return pack
end

function SpriteSet:setCurrentSprite(index)
  if index and index <= #self.sprites then
    self.current_index = index
  end
end

---@return Sprite
function SpriteSet:currentSprite()
  return self.sprites[self.current_index]
end

---@param process fun(sprite:Sprite, index: number)
function SpriteSet:batch(process)
  for index, sprite in ipairs(self.sprites) do
    process(sprite, index)
  end
end

function SpriteSet:setOrigin(x, y)
  local origin = Point(x, y)
  local offset_origin = Point()
  self:batch(function(sprite, index)
    sprite:setOrigin(offset_origin:base(origin):offset(self.offsets[index], -1):unpack())
  end)
end

function SpriteSet:draw()
  self:currentSprite():drawCall()
end

return SpriteSet