---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/16 22:23
---

local json = require('sys.3rd.json')
local Sprite = require('sys.core.element.sprite')

---@class ImagePack: BaseDrawable
local ImagePack = require('sys.core.base.drawable'):extend()

function ImagePack:new()
  ImagePack.super.new(self)
  self.sprites = {}
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
  for index, pos in ipairs(info) do
    local sprite = Sprite(string.format('%s/%d.png', sprite_dir, index - 1))
    sprite:setPosition(pos.x, pos.y)
    pack.sprites[index] = pack:bind(sprite)
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
  ---@param sprite Sprite
  for _, sprite in ipairs(self.sprites) do
    sprite:setOrigin(x, y)
  end
end

function ImagePack:setOrientation(radians)
  ---@param sprite Sprite
  for _, sprite in ipairs(self.sprites) do
    sprite:setOrientation(radians)
  end
end

function ImagePack:draw()
  self:currentSprite():drawCall()
end

return ImagePack
