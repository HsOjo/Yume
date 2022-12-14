---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by hsojo.
--- DateTime: 2022/11/19 20:25
---

local Table = {}
Table.unpack = table.unpack or unpack
Table.pack = table.pack or function(...)
  return { ... }
end

function Table.index(tbl, value)
  for k, v in pairs(tbl) do
    if v == value then
      return k
    end
  end
end

function Table.remove(tbl, value)
  local index = Table.index(tbl, value)
  return table.remove(tbl, index)
end

function Table.map(tbl, func)
  local new_tbl = {}
  for k, v in pairs(tbl) do
    new_tbl[k] = func(v)
  end
  return new_tbl
end

function Table.length(tbl)
  local i = 0
  for _, _ in pairs(tbl) do
    i = i + 1
  end
  return i
end

function Table.format(tbl, max_depth, stack, depth)
  depth = depth or 0
  max_depth = max_depth or 1
  stack = stack or {}

  ---@type string
  local table_name = tbl.__name
  local table_len = Table.length(tbl)
  local is_list = table_len == #tbl

  if stack[tbl] or (table_len and depth > max_depth) then
    if stack[tbl] then
      table_name = '(circular)'
    end
    return string.format('%s(%p)', table_name or '(table)', tbl)
  end

  stack[tbl] = true

  local indent = ''
  local next_indent = ''
  for _ = 0, depth do
    indent = next_indent
    next_indent = next_indent .. '  '
  end

  local processor = {
    ['number'] = tostring,
    ['boolean'] = tostring,
    ['string'] = function(x)
      return string.format('"%s"', x)
    end,
    ['table'] = function(x)
      return Table.format(x, max_depth, stack, depth + 1)
    end,
    ['other'] = function(x)
      return string.format('("%s")(%p)', type(x), x)
    end
  }

  local content = ''
  for k, v in pairs(tbl) do
    if tostring(k):sub(0, 1) ~= '_' then
      if content ~= '' then
        content = content .. ', '
      end

      local value = (processor[type(v)] or processor.other)(v)

      if is_list then
        content = content .. value
      else
        local key = (processor[type(k)] or processor.other)(k)
        content = content .. string.format('\n%s[%s] = %s', next_indent, key, value)
      end
    end
  end

  stack[tbl] = false
  if is_list then
    if content ~= '' then
      content = string.format(' %s ', content)
    end
    content = string.format('{%s}', content)
  else
    if content ~= '' then
      content = string.format('%s\n%s', content, indent)
    end
    content = string.format('{%s}', content)

    if table_name then
      content = string.format('%s(%p) %s', table_name, tbl, content)
    end
  end

  return content
end

function Table.print(tbl)
  print(Table.format(tbl))
end

return Table
