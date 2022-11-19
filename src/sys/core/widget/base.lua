---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/11 23:27
---

local Event = require('sys.core.feature.event')

---@class BaseWidget: BaseDrawable
local BaseWidget = require('sys.core.base.drawable'):extend()

function BaseWidget:new()
  BaseWidget.super.new(self)
  self.focus = false
  self.event = Event()
end

function BaseWidget:setFocus(focus)
  self.focus = focus
  if focus and self.parent:is(BaseWidget) then
    self.parent:setFocus(focus)
  end
end

function BaseWidget:update()
  ---@param child BaseWidget
  for _, child in pairs(self.children) do
    if child:is(BaseWidget) then
      child:update()
    end
  end
end

function BaseWidget:release()
  BaseWidget.super.release(self)
  self.event:release()
end

return BaseWidget
