platform = {}
 
function love.load()
	platform.width = love.graphics.getWidth()
	platform.height = love.graphics.getHeight()
	platform.x = 0
	platform.y = platform.height / 2
    require "player"
    player = Player()
end

function love.update(dt)
    player:update(dt)
end
 
function love.draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle('fill', platform.x, platform.y, platform.width, platform.height)
    player:draw()
end