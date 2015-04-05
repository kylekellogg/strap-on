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

local StrapOn = {
  accessories = {}
}

local function noop() end

function StrapOn.strap( accessory )
  local n = #StrapOn.accessories + 1
  StrapOn.accessories[ n ] = accessory or {}
  
  StrapOn.accessories[ n ].unstrap = function()
    for i = n, #StrapOn.accessories - 1, 1 do
      local x = StrapOn.accessories[ n + 1 ]
      StrapOn.accessories[ n ] = x
      StrapOn.accessories[ n + 1 ] = nil
    end
  end

  return StrapOn.accessories[ n ]
end

function StrapOn.harness( accessories )
  local og = {}

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

    og[v] = love[v] or noop
    love[v] = function( ... )
      local accs = copyAccessories()

      -- Execute the pre callback on all strapped accessories
      callOn( pre, accs, ... )

      -- Execute the actual callback on all strapped accessories
      callOn( v, accs, ... )

      -- Execute the love callback
      og[v]( ... )

      -- Execute the post callback on all strapped accessories
      callOn( post, accs, ... )
    end

  end

end

return StrapOn
