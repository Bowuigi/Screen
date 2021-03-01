# Screen
A terminal screen handling library made in Lua

Features
---
- Full control over the screen
- 256 Color support
- Support for attributes
- Mouse control and visibility toggle
- Easy to use
- Uses x,y format

Usage
---
Clone the repo and add

```lua
Screen=require "screen"

Screen.newDisplay(ScreenWidth,ScreenHeight,CharacterToFillWith)
```

At the top of your file

Functions
---
```lua
Screen.newDisplay(w,h,fill) -- Makes a display with a width of 'w', a height of 'h' and filled with the first character of 'fill'
Screen.setPixel(x,y,pixel) -- Changes the character at x,y to the first character of the 'fill' variable
Screen.getPixel(x,y) -- Returns the character on the x,y position of the display
Screen.setColor(bg,x,y,colorID) -- Sets the color on x,y to the colorID variable (uses a background tile depending on 'bg' variable)
Screen.getColor(bg,x,y) -- Returns the colorID of a certain cell (uses a background tile depending on 'bg' variable)
Screen.rectangle(x,y,x2,y2,fill) -- Makes a rectangle with the two points supplied and fills it with 'fill' character
Screen.clear(home) -- Clears the screen and returns the cursor to home position (reduces flickering) depending on the 'home' argument
Screen.draw(color) -- Draws the screen, if 'color' is disabled then no color will be rendered, reducing flickering
```