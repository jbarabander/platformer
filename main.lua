
function love.load()

    require "player"
    player = Player()
	require "floor"
	floor = Floor()
	require "level"
	level = Level({
		{x=180, y=180},
		{x=160, y=250},
		{x=300, y=270}
	})
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
	level:draw()
end