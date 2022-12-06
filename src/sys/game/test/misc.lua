---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/21 23:41
---

local Timer = require('sys.core.feature.timer')
local Table = require('sys.core.feature.table')
local Joystick = require('sys.core.input.joystick')

---@class MiscTest: BaseTest
local MiscTest = require('sys.game.test.base'):extend()

function MiscTest:new()
  MiscTest.super.new(self)

  self.timer = Timer(function(c, fc)
    print(c, fc)
  end, 1, 10):start()

  self:bind(self.timer)
end

function MiscTest:update(dt)
  MiscTest.super.update(self, dt)
  self.indicator:setText(string.format(
    '%s\n\n%s', self.indicator.text, Table.format(Joystick._status, 3)
  ))
end

return MiscTest
