local Gamestate = require "gamestate"
local level1 = require "states.level1"
local math = require "math"

local menu = {}
local limit
local y
local rectX
local index = 0
local titleFont
local optionFont

function menu:enter()
    titleFont = love.graphics.newFont(24)
    optionFont = love.graphics.newFont(12)
end

function menu:draw()
    love.graphics.setFont(titleFont)
    love.graphics.printf('Platformer!', 0, 30, limit, "center")
    love.graphics.setFont(optionFont)
    love.graphics.printf("Start Game", 0, y, limit, "center")
    love.graphics.printf("Quit", 0, y + 30, limit, "center")
    
    local font = love.graphics.getFont()
    local fontHeight = font:getAscent() + font:getDescent()
    local rectHeight = fontHeight + 20
    local rectY = y + (30 * index) - fontHeight / 2
    love.graphics.rectangle("line", rectX - 100, rectY, 200, rectHeight)

end

function menu:update()
    limit = love.graphics.getWidth()
    y = love.graphics.getHeight() / 2
    rectX = limit / 2
end

function menu:keypressed(key)
	if key == 's' then
        index = (index + 1) % 2
	end
    if key == 'w' then
        index = math.abs((index - 1) % 2)
    end
end
function menu:keyreleased(key, code)
    if key == 'return' then
        if index == 0 then
            Gamestate.switch(level1)
        elseif index == 1 then
            love.event.quit()
        end
    end
end

return menu