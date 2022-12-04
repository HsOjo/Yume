---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/21 23:37
---

local ColorEffect = require('sys.core.effect.color')

local Circle = require('sys.core.drawable.shape.circle')
local Model = require('sys.core.drawable.model')
local SpriteSet = require('sys.core.drawable.sprite_set')
local Drag = require('sys.core.feature.drag')

---@class AnimationTest: BaseTest
local AnimationTest = require('sys.game.test.base'):extend()

function AnimationTest:new()
  AnimationTest.super.new(self)

  self.model = Model()
  self:bind(self.model)
  self.model:addSpriteSet(
    SpriteSet.loadFromDirectory('res/sprite_character_swordman_atequipment_weapon_katana/(tn)sg_katana0000x', 0),
    SpriteSet.loadFromDirectory('res/sprite_character_swordman_atequipment_weapon_katana/(tn)sg_katana0000b', 0),
    SpriteSet.loadFromDirectory('res/sprite_character_swordman_atequipment_avatar_skin/sg_body80100'),
    SpriteSet.loadFromDirectory('res/sprite_character_swordman_atequipment_weapon_katana/(tn)sg_katana0000a', 0)
  )
  self.model:batchSpriteSets(function(sprite_set, _)
    sprite_set:batchSprites(function(sprite, _)
      sprite.rect:setVisible(true)
    end)
  end)
  self.model:setOrigin(250, 380)
  self.model:setPosition(256, 256)
  self.model:setScale(-2, 2)

  self.model:newAction('stand', true):addFrameRange(10, 13, 5)
  self.model:newAction('walk', true):addFrameRange(14, 23, 10)

  self.drag = Drag(self.model)
  self.drag.event:on(Drag.EVENT_BEGIN, function()
    self.model:doAction('walk')
  end)
  self.drag.event:on(Drag.EVENT_FINISHED, function()
    self.model:doAction('stand')
  end)
  self:bind(self.drag)
  self.drag:setTestFunction(function(point)
    local result = false
    self.model:batchSpriteSets(function(sprite_set, index)
      if not result then
        result = result or sprite_set:currentSprite().rect:testPoint(point)
      end
    end)
    return result
  end)

  self.pos_indicator = Circle(2)
  self.pos_indicator:applyEffect(ColorEffect(255, 0, 0))
  self:bind(self.pos_indicator)
end

function AnimationTest:update(dt)
  AnimationTest.super.update(self, dt)
  self.pos_indicator:setPosition(self.model.position:unpack())
  --self.animation:setOrientation(self.animation.radians + dt)
end

return AnimationTest
