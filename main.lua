
function love.load()
	local menu = require "states.menu"
	GameState = require "gamestate"
	GameState.registerEvents()
	GameState.switch(menu)
end
