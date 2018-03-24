
local Object = require "classic"
local GameState = require "gamestate"

local LevelState = Object:extend()

function LevelState:new(levelTable, nextState)
    self.internalTable = levelTable
	self.nextState = nextState
end

function LevelState:enter()
    require "player"
	require "floor"
	self.floor = Floor()
	local Level = require "level"
	self.level = Level(self.internalTable)
	self.player = Player(self.level.platforms[1].x, self.level.platforms[1].y)
end

function LevelState:keypressed(key)
	if key == 'space' then
		if not self.player.hasJumped then
			self.player:jump()
		elseif not self.player.hasDoubleJumped then
			self.player:doubleJump()
		end
	end 
end

function LevelState:keyreleased(key)
	if key == 'space' and self.player.hasJumped then
		self.player.jumpHeldDown = false 
	end
end

function LevelState:draw()
	self.floor:draw()
    self.player:draw()
	self.level:draw()
end

function LevelState:update(dt)
    self.player:update(dt)
	if self.level.goal.playerHasReached and self.nextState then
		GameState.switch(self.nextState)
		self.player:clear()
		self.level:clear()
	end
end

return LevelState