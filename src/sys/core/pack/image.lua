---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/16 22:23
---

local json = require('sys.3rd.json')
local Point = require('sys.core.feature.point')
local Sprite = require('sys.core.drawable.node.sprite')

---@class ImagePack: BaseDrawable
local ImagePack = require('sys.core.base.drawable'):extend()
ImagePack.__name='ImagePack'

function ImagePack:new()
  ImagePack.super.new(self)

  ---@type Sprite[]
  self.sprites = {}
  ---@type Point[]
  self.offsets = {}
  self.current_index = nil
end

---@return ImagePack
function ImagePack.loadFromDirectory(dir, color)
  local info = json.decode(love.filesystem.read(dir .. '/info.json'))
  local sprite_dir = string.format('%s/image', dir)
  if color then
    sprite_dir = string.format('%s_color_%d', sprite_dir, color)
  end

  local pack = ImagePack()
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

function ImagePack:setCurrentFrame(index)
  if index and index <= #self.sprites then
    self.current_index = index
  end
end

---@return Sprite
function ImagePack:currentSprite()
  return self.sprites[self.current_index]
end

function ImagePack:setOrigin(x, y)
  local origin = Point(x, y)
  local offset_origin = Point()
  ---@param sprite Sprite
  for index, sprite in ipairs(self.sprites) do
    sprite:setOrigin(offset_origin:base(origin):offset(self.offsets[index], -1):unpack())
  end
end

function ImagePack:setOrientation(radians)
  ---@param sprite Sprite
  for _, sprite in pairs(self.sprites) do
    sprite:setOrientation(radians)
  end
end

function ImagePack:draw()
  self:currentSprite():drawCall()
end

return ImagePack
