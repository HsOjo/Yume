---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/21 23:29
---

local Color = require('sys.core.feature.color')
local Indicator = require('sys.game.test.indicator')

---@class BaseTest: BaseDrawable
local BaseTest = require('sys.core.base.drawable'):extend()

function BaseTest:new()
  BaseTest.super.new(self, true)
  self:setFreeze(false)
  self:bind(Indicator())
  love.graphics.setBackgroundColor(Color(64, 64, 64):unpack())
end

return BaseTest
