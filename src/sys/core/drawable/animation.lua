---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/12/3 18:23
---

local Timer = require('sys.core.feature.timer')

---@class Animation: Rotatable
local Animation = require('sys.core.base.rotatable'):extend()

function Animation:new()
  Animation.super.new(self)

  self.timer = Timer(function()
    self:nextFrame()
  end, 0)
  self:bind(self.timer)

  ---@type SpriteSet[]
  self.sprite_sets = {}

  ---@type table[]
  self.frames = {}

  self.loop = true
  self.current_frame = nil
  self.index = 0
end

function Animation:setLoop(loop)
  self.loop = loop
end

function Animation:addSpriteSet(...)
  local sprite_sets = { ... }
  for index, sprite_set in pairs(sprite_sets) do
    self:bind(sprite_set)
    table.insert(self.sprite_sets, sprite_set)
  end
end

---@param process fun(sprite_set: SpriteSet, index: number)
function Animation:batchSpriteSets(process)
  for index, sprite_set in pairs(self.sprite_sets) do
    process(sprite_set, index)
  end
end

function Animation:setOrigin(x, y)
  Animation.super.setOrigin(self, x, y)
  ---@param sprite_set SpriteSet
  self.animation:batchSpriteSet(function(sprite_set, index)
    sprite_set:setOrigin(self.origin:unpack())
  end)
end

function Animation:addFrame(index, rate)
  local frame = {}
  frame.index = index
  frame.rate = rate or 30
  table.insert(self.frames, frame)
  if not self.current_frame then
    self:reset()
  end
end

function Animation:addFrameRange(index_start, index_end, rate)
  for index = index_start, index_end do
    self:addFrame(index, rate)
  end
end

function Animation:nextFrame()
  if #self.frames == 0 then
    return
  end

  self.index = self.index + 1
  local next_frame = self.frames[self.index]
  if not next_frame then
    if self.loop then
      self:reset()
    end
    return
  end

  self.timer:setTimeout(1 / next_frame.rate)
  self.timer:reset():start()
  self.current_frame = next_frame
  if #self.sprite_sets then
    for _, sprite_set in pairs(self.sprite_sets) do
      sprite_set:setCurrentSprite(next_frame.index)
    end
  end
end

function Animation:reset()
  self.index = 0
  self:nextFrame()
  return self
end

return Animation