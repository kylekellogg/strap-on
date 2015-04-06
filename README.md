# Strap-On

Strap your actor/object's callbacks onto the [LÖVE (Love2d)][love] callbacks

## What is it?

Strap-On is an easy-to-use library that allows you to have individual callbacks on all of your actors/objects that reflect the [LÖVE][love] callbacks.

These callbacks are executed in the order that they are added with the [LÖVE][love] callback **always** happening last. [LÖVE][love] callbacks will be (but are not yet being) created for you to add on to if you have not explicitly created them by the time you call `StrapOn.harness()`.

## How do I use it?

1. Strap your objects onto the callback system
2. Harness up
3. Strap and Unstrap your objects whenever you want - they will be added or removed after during the next callback

```lua
local StrapOn = require 'strap-on'

local myTable = {}                --  A barebones object (or a complex one, whatever)
local altTable = StrapOn.strap()  --  Creates a blank object for you

--  Callbacks for your "myTable" table, showcasing the pre\*, \*, and post\* callbacks
function myTable.preupdate( dt )
  --  Whatever you want...
end

function myTable.update( dt )
  --  Whatever you want...
end

function myTable.postupdate( dt )
  --  Whatever you want...
end

--  Callback for the StrapOn created table
function altTable.update( dt )
  --  Whatever you want...
end

function love.load()
  StrapOn.strap( myTable )  --  Will return myTable as well, but you don't need to reassign it or anything

  StrapOn.harness()
end
```

## TODO

* [ ] Add more examples

[love]:   https://www.love2d.org/   "LÖVE"

