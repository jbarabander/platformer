
function love.load()
	local menu = require "states.menu"
	local level2 = require "states.level2"
	level2.nextState = menu
	GameState = require "gamestate"
	GameState.registerEvents()
	GameState.switch(menu)
end
