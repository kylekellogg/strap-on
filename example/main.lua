local StrapOn = require '../strap-on'

local acc1
local acc2
local acc3

--  Main functions

function love.load( arg )
  --  Will be continuously called
  --  Showcases the flow of callbacks (pre, _, and post)
  acc1 = {
      counter = 1
    }

  acc1 = StrapOn.strap( acc1 )

  function acc1.preupdate( ... )
    print( 'acc1.preupdate' )
  end

  function acc1.update( ... )
    print( 'acc1.update' )
  end

  function acc1.postupdate( ... )
    print( 'acc1.postupdate :: ' .. acc1.counter )

    if acc1.counter == 5 then
      StrapOn.strap( acc2 )
    end

    acc1.counter = acc1.counter + 1
  end

  --  Will only have it's method called once
  --  Showcases how to remove from the callback flow
  --  Even though "unstrap" is called during update(), postupdate() will be called [this allows for cleanup, etc]
  acc2 = {}

  acc2 = StrapOn.strap( acc2 )

  function acc2.update( ... )
    print( 'acc2.update' )
    acc2.unstrap()
  end

  function acc2.postupdate( ... )
    print( 'acc2.postupdate' )
  end

  --  Will be continuously called
  --  Showcases selective callbacks
  acc3 = StrapOn.strap()

  function acc3.update( ... )
    print( 'acc3.update' )
  end

  function acc3.postupdate( ... )
    print( 'acc3.postupdate' )
  end

  --  Starting up StrapOn
  StrapOn.harness()
end

function love.update( dt )
  print( 'love.update' )
  print( '' )
end

--  Error handling

function love.errhand( msg )
  print( msg )
end
