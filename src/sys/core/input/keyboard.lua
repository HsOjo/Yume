---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/11 12:30
---

local Key = require('sys.core.input.key')

local Keyboard = {
  KEY_PREFIX = 'keyboard_',
}

function Keyboard.key(code)
  return Key.get(Keyboard.KEY_PREFIX .. code)
end

return Keyboard
