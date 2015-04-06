local StrapOn = require '../strap-on'

local a
local b
local c

--  Main functions

function love.load( arg )
  --  Will be continuously called
  --  Showcases the flow of callbacks (pre, _, and post)
  a = StrapOn.strap({
      counter = 1
    })

  function a.preupdate( ... )
    print( 'a.preupdate' )
  end

  function a.update( ... )
    print( 'a.update' )
  end

  function a.postupdate( ... )
    print( 'a.postupdate :: ' .. a.counter )

    if a.counter == 5 then
      StrapOn.strap( b )
    end

    a.counter = a.counter + 1
  end

  --  Will only have it's method called once
  --  Showcases how to remove from the callback flow
  --  Even though "unstrap" is called during update(), postupdate() will be called for that execution [this allows for cleanup, etc]
  b = StrapOn.strap({})

  function b.update( ... )
    print( 'b.update' )
    b.unstrap()
  end

  function b.postupdate( ... )
    print( 'b.postupdate' )
  end

  --  Will be continuously called
  --  Showcases callbacks that will happen without even being declared
  c = StrapOn.strap()

  function c.update( ... )
    print( 'c.update' )
  end

  function c.mousemoved( ... )
    print( 'c.mousemoved' )
  end

  --  Starting up StrapOn
  StrapOn.harness()
end

function love.update( dt )
  print( 'love.update' )
end

--  Error handling

function love.errhand( msg )
  print( msg )
end
