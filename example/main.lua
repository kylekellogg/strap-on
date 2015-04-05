Class = require '30log'
StrapOn = require 'libs/strap-on'

local acc1
local acc2
local acc3

--  Main functions

function love.load( arg )
  --  Will be continuously called
  --  Showcases the flow of callbacks (pre, _, and post)
  acc1 = StrapOn.strap({
      id = 'acc1'
    })

  function acc1:preupdate( ... )
    print( 'acc1:preupdate' )
  end

  function acc1:update( ... )
    print( 'acc1:update' )
  end

  function acc1:postupdate( ... )
    print( 'acc1:postupdate' )
  end

  --  Will only have it's method called once
  --  Showcases how to remove from the callback flow
  --  Even though "unstrap" is called during update(), postupdate() will be called [this allows for cleanup, etc]
  acc2 = StrapOn.strap({
      id = 'acc2'
    })

  function acc2:update( ... )
    print( 'acc2:update' )
    acc2.unstrap()
  end

  function acc2:postupdate( ... )
    print( 'acc2:postupdate' )
  end

  --  Will be continuously called
  --  Showcases selective callbacks
  acc3 = StrapOn.strap()

  function acc3:update( ... )
    print( 'acc3:update' )
  end

  function acc3:postupdate( ... )
    print( 'acc3:postupdate' )
  end

  --  Starting up StrapOn
  StrapOn.harness()
end

function love.update( dt )
  print( 'love.update' )
end

function love.draw()
end

--  Key and text input handling

function love.keypressed( key, isrepeat )
end

function love.keyreleased( key )
end

function love.textinput( text )
end

--  Mouse handling

function love.mousepressed( x, y, button )
end

function love.mousereleased( x, y, button )
end

--  Focus handling

function love.focus( f )
end

function love.mousefocus( f )
end

function love.visible( v )
end

--  Resize handling

function love.resize( w, h )
end

--  Main loop & ending func

-- function love.run()
--   print( 'love.run' )
-- end

function love.quit()
end

--  Error handling

function love.errhand( msg )
  print( msg )
end

function love.threaderror( thread, errorstr )
end

function love.mousemoved()
end

function love.gamepadaxis()
end

function love.gamepadpressed()
end

function love.gamepadreleased()
end

function love.joystickadded()
end

function love.joystickaxis()
end

function love.joystickhat()
end

function love.joystickpressed()
end

function love.joystickreleased()
end

function love.joystickremoved()
end
