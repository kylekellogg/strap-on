local callbacks = {
  'draw',
  'errhand',
  'focus',
  'keypressed',
  'keyreleased',
  'load',           --  Will never be called on strapped accessories given that it's only called _once_
  'mousefocus',
  'mousemoved',
  'mousepressed',
  'mousereleased',
  'quit',
  'resize',
  'run',
  'textinput',
  'threaderror',
  'update',
  'visible',
  'gamepadaxis',
  'gamepadpressed',
  'gamepadreleased',
  'joystickadded',
  'joystickaxis',
  'joystickhat',
  'joystickpressed',
  'joystickreleased',
  'joystickremoved'
}

local Array = {}

function Array.new( ... )
  local arr = {}
  
  arr.push = function( ... )
    Array.push( arr, ... )
  end

  arr.splice = function( idx, deletecount )
    Array.splice( arr, idx, deletecount )
  end

  arr.indexof = function( obj )
    return Array.indexof( arr, obj )
  end

  arr.push( ... )

  return arr
end

function Array.push( arr, ... )
  local len = #arr

  for i,v in ipairs({...}) do
    arr[ len + i ] = v
  end

  return arr
end

function Array.splice( arr, idx, deletecount )
  local len = #arr - 1

  for i=idx,len do
    arr[ i ] = arr[ i + 1 ]
    arr[ i + 1 ] = nil
  end

  return arr
end

function Array.indexof( arr, obj )
  local len = #arr

  for i=1,len do
    if arr[i] == obj then
      return i
    end
  end

  return 0
end

local StrapOn = {
  accessories = Array.new(),
  origcallbacks = {},
  harnessed = false
}

local function noop() end

function StrapOn.strap( accessory )
  if StrapOn.hasStrapped( accessory ) then
    return accessory
  end
  
  local idx = #StrapOn.accessories + 1

  accessory = accessory or {}

  local f = accessory.unstrap or noop
  accessory.unstrap = function( ... )
    f( ... )
    StrapOn.unstrap( accessory )
  end

  StrapOn.accessories.push( accessory )
  
  return accessory
end

function StrapOn.unstrap( accessory )
  if not StrapOn.hasStrapped( accessory ) then
    return
  end

  -- Find the accessory
  for i,v in ipairs(StrapOn.accessories) do
    if v == accessory then
      StrapOn.accessories.splice( i, 1 )

      break
    end
  end
end

function StrapOn.hasStrapped( accessory )
  if StrapOn.accessories.indexof( accessory ) > 0 then
    return true
  end

  return false
end

function StrapOn.harness( accessories )
  if StrapOn.harnessed then
    StrapOn.unharness()
  end

  StrapOn.origcallbacks = {}

  -- Add any accessories
  if accessories then
    for _,v in pairs(accessories) do
      StrapOn.strap(v)
    end
  end

  --  Copy the accessories
  local function copyAccessories()
    local a = {}

    for i,v in ipairs(StrapOn.accessories) do
      a[i] = v
    end

    return a
  end

  local function callOn( func, accs, ... )
    for _,v in ipairs(accs) do
      local f = v[func] or noop
      f( ... )
    end
  end

  for _,v in ipairs(callbacks) do
    local pre = 'pre' .. v
    local post = 'post' .. v

    StrapOn.origcallbacks[v] = love[v] or noop
    love[v] = function( ... )
      local accs = copyAccessories()

      -- Execute the pre callback on all strapped accessories
      callOn( pre, accs, ... )

      -- Execute the actual callback on all strapped accessories
      callOn( v, accs, ... )

      -- Execute the love callback
      StrapOn.origcallbacks[v]( ... )

      -- Execute the post callback on all strapped accessories
      callOn( post, accs, ... )
    end

  end

  StrapOn.harnessed = true

end

function StrapOn.unharness()
  if not StrapOn.harnessed then
    return
  end

  for _,v in ipairs(callbacks) do
    love[v] = StrapOn.origcallbacks[v] or noop
  end

  StrapOn.harnessed = false
end

return StrapOn
