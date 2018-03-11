
local Object = require "classic"
local GameState = require "gamestate"

local LevelState = Object:extend()

function LevelState:new(levelTable)
    self.internalTable = levelTable
end

function LevelState:enter()
    require "player"
    self.player = Player()
	require "floor"
	self.floor = Floor()
	local Level = require "level"
	self.level = Level(self.internalTable)
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
end

return LevelState