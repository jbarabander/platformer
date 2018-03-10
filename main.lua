platform = {}
 
function love.load()
	platform.w = love.graphics.getWidth()
	platform.h = love.graphics.getHeight()
	platform.x = 0
	platform.y = platform.h / 2
    require "player"
    player = Player()
	require "floor"
	floor = Floor()
end

function love.keypressed(key)
	if key == 'space' then
		if not player.hasJumped then
			player:jump()
		elseif not player.hasDoubleJumped then
			player:doubleJump()
		end
	end 
end 

function love.keyreleased(key)
	if key == 'space' and player.hasJumped then
		player.jumpHeldDown = false 
	end
end

function love.update(dt)
    player:update(dt)
end
 
function love.draw()
	floor:draw()
    player:draw()
end