---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/10 17:20
---

local Key = require('sys.core.input.key')
local Mouse = require('sys.core.input.mouse')
local Keyboard = require('sys.core.input.keyboard')
local Joystick = require('sys.core.input.joystick')

function love.load(args)
  io.stdout:setvbuf("no")
  ---@param arg string
  for _, arg in ipairs(args) do
    if arg:find('mobdebug') then
      load(arg)()
    end
  end

  ---@type string
  local last_arg = args[#args]
  local test_module = last_arg:match('test:(.+)') or 'base'
  test = require(string.format('sys.game.test.%s', test_module))()
  test:setScale(2 / love.graphics.getDPIScale())
end

function love.update(dt)
  test:updateCall(dt)

  Key.callback_updated()
  Mouse.callback_updated()
  Joystick.callback_updated()
end

function love.draw()
  test:drawCall()
end

function love.keypressed(key)
  Key.callback_pressed(Keyboard.key(key))
end

function love.keyreleased(key)
  Key.callback_released(Keyboard.key(key))
end

function love.mousepressed(x, y, button, istouch, presses)
  Key.callback_pressed(Mouse.key(button))
  Mouse.callback_moved(x, y, istouch)
end

function love.mousereleased(x, y, button, istouch, presses)
  Key.callback_released(Mouse.key(button))
  Mouse.callback_moved(x, y, istouch)
end

function love.mousemoved(x, y, dx, dy, istouch)
  Mouse.callback_moved(x, y, istouch)
end

function love.wheelmoved(x, y)
  Mouse.callback_wheel_moved(x, y)
end

---@param joystick Joystick
function love.joystickpressed(joystick, button)
  Key.callback_pressed(Joystick.key(button, joystick:getGUID()))
end

---@param joystick Joystick
function love.joystickreleased(joystick, button)
  Key.callback_released(Joystick.key(button, joystick:getGUID()))
end

---@param joystick Joystick
function love.joystickadded(joystick)
  Joystick.callback_added(joystick)
end

---@param joystick Joystick
function love.joystickremoved(joystick)
  Joystick.callback_removed(joystick)
end
