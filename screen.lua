--Minimal CLI Screen handling library
--Copyright (c) Bowuigi 2021

Screen={display={},textAttributes={},textColors={},BGColors={},textAttributesList={normal=0,bold=1,underscore=4,blink=5,reverse=7,concealed=8}}

function Screen.newDisplay(w,h,fill)
	Screen.display={} --clear the display
	for y=1,w,1 do
	
		Screen.display[y]={}
		Screen.textAttributes[y]={}
		Screen.textColors[y]={}
		Screen.BGColors[y]={}
		for x=1,h,1 do
		
			Screen.textAttributes[y][x]=0
			Screen.textColors[y][x]=231
			Screen.BGColors[y][x]=232
			Screen.display[y][x]=fill:sub(1,1)
		
		end
	
	end
end

function Screen.clear(home)
	io.write("\027[2J") --ANSI Clear Screen
	if home then
		io.write("\027[H")
	end
end

function Screen.setCursorVisibility(visibility)
	if visibility then
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

function Screen.setPixel(x,y,pixel)
	if Screen.display[y]~=nil then
		if Screen.display[y][x]~=nil then
			Screen.display[y][x]=pixel:sub(1,1)
		end
	end
end

function Screen.getPixel(x,y)
	if Screen.display[y]~=nil then
		return Screen.display[y][x]
	else
		return nil
	end
end

function Screen.setColor(bg,x,y,colorID)
	if Screen.display[y]~=nil then
		if Screen.display[y][x]~=nil then
			if bg then
				Screen.BGColors[y][x]=clamp(colorID,0,255)
			else
				Screen.textColors[y][x]=clamp(colorID,0,255)
			end
		end
	end
end

function Screen.getColor(bg,x,y)
	if Screen.display[y] then
		if bg then
			return Screen.BGColors[y][x]
		else
			return Screen.textColors[y][x]
		end
	end
end

function Screen.rectangle(x,y,x2,y2,fill)
	for xx=x,x2,1 do
		if Screen.display[xx]~=nil then
			for yy=y,y2,1 do
				if Screen.display[xx][yy]~=nil then
					Screen.display[xx][yy]=fill:sub(1,1)
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
			if y==#Screen.display[x][1] then
				draw=draw.."\n"
			end
			--Optimize drawing
			draw=draw..(Screen.display[x][y])
		
		end
	
	end
	io.write(draw)

end

return Screen