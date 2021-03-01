--Minimal CLI Screen handling library
--By Bowuigi

Screen={display={},textAttributes={},textColors={},BGColors={},textAttributesList={normal=0,bold=1,underscore=4,blink=5,reverse=7,concealed=8}}

function Screen.newDisplay(w,h,fill)
	Screen.display={} --clear the display
	for x=1,w,1 do
	
		Screen.display[x]={}
		Screen.textAttributes[x]={}
		Screen.textColors[x]={}
		Screen.BGColors[x]={}
		for y=1,h,1 do
		
			Screen.textAttributes[x][y]=0
			Screen.textColors[x][y]=231
			Screen.BGColors[x][y]=232
			
			Screen.display[x][y]=fill
		
		end
	
	end
end

function Screen.clear(home)
	io.write("\027[2J") --ANSI Clear Screen
	if home then
	io.write("\027[H")
	end
end

function Screen.setCursorVisibility(vis)
	if vis then
	io.write("\027[?25h") -- ANSI show cursor
	else
	io.write("\027[?25l") -- ANSI hide cursor
	end
end

function Screen.setCursorPosition(x,y)
	io.write("\027["..y..";"..x.."f")
end

local function clamp(val,min,max)
return math.min(math.max(val,min),max)
end

function Screen.rectangle(x,y,x2,y2,fill)
	for xx=x,x2,1 do
		if Screen.display[xx]~=nil then
			for yy=y,y2,1 do
				if Screen.display[xx][yy]~=nil then
					Screen.display[xx][yy]=fill
				end
			end
		end
	end
end

function Screen.draw(color)
	local draw=""
	for x=1,#Screen.display,1 do
	
		for y=1,#Screen.display[x],1 do
			
			if color or color==nil then
				--Set colors by ID
				draw=draw..("\027[38;5;"..Screen.textColors[x][y].."m")
				draw=draw..("\027[48;5;"..Screen.BGColors[x][y].."m")
			end
			--Cache the display
			draw=draw..(Screen.display[x][y])
		
		end
	
	end
	print(draw)

end

return Screen