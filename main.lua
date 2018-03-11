
function love.load()

    require "player"
    player = Player()
	require "floor"
	floor = Floor()
	require "platform"
	platforms = {
		Platform(180, 180),
		Platform(160, 250)
	}
	require "goal"
	goal = Goal(210, 80)
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
	goal:draw()
	for k,v in pairs(platforms) do
		v:draw()
	end
end