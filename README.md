# Strap-On

Strap your actor/object's callbacks onto the LÖVE (Love2d) callbacks

## What is it?

Strap-On is an easy-to-use library that allows you to have individual callbacks on all of your actors/objects that reflect the LÖVE callbacks.

These callbacks are executed in the order that they are added with the LÖVE callback **always** happening last. LÖVE callbacks will be (but are not yet being) created for you to add on to if you have not explicitly created them by the time you call `StrapOn.harness()`.

## How do I use it?

1. Strap your objects onto the callback system
2. Harness up
3. Strap and Unstrap your objects whenever you want - they will be added or removed after during the next callback



## TODO

* [ ] Create dummy LÖVE callbacks if they don't already exist so that Strap-Ons can take advantage of them
* [ ] Add more examples

