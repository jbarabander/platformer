Object = require "classic"
math = require "math"
Player = Object:extend()

local MAX_NUM_OF_JUMPING_FRAMES = 20


function Player:new()
	self.speed = 200
	self.y_velocity = 0 
	self.jump_height = -300
	self.gravity = -900
    self.x = love.graphics.getWidth() / 2
	self.y = love.graphics.getHeight() / 2 - 50
    self.ground = self.y
    self.size = 50
    self.jumpingFrames = 0
    self.hasDoubleJumped = false
    self.doubleJumpHeight = self.jump_height / 2
end

function Player:draw()
    love.graphics.rectangle("line", self.x, self.y, self.size, self.size)
end

function Player:canStillJump()
    return (
        self.y_velocity == 0 or 
        self.jumpingFrames < MAX_NUM_OF_JUMPING_FRAMES
    )
end

function Player:clearJump()
    self.jumpingFrames = 0
    self.y_velocity = 0
    self.y = self.ground
    self.hasDoubleJumped = false
end

function Player:doubleJump()
    self.jumpingFrames = 0
    self.y_velocity = self.doubleJumpHeight
    self.hasDoubleJumped = true
end

function Player:reAddJumpHeight()
    if self.hasDoubleJumped then
        self.y_velocity = self.doubleJumpHeight
    else
        self.y_velocity = self.jump_height
    end
end

function Player:jumpingStatus(dt)
	if love.keyboard.isDown('space') then
        if self.y_velocity == 0 or self.jumpingFrames < MAX_NUM_OF_JUMPING_FRAMES then
		    self:reAddJumpHeight()
            self.jumpingFrames = self.jumpingFrames + 1
        elseif not self.hasDoubleJumped and self.jumpingFrames == math.huge then 
            self:doubleJump()
        end
	end 
    if not love.keyboard.isDown('space') and self.y_velocity ~=0 then
        self.jumpingFrames = math.huge
    end
	if self.y_velocity ~= 0 then
		self.y = self.y + self.y_velocity * dt
		self.y_velocity = self.y_velocity - self.gravity * dt
	end
end

function Player:update(dt)
    if love.keyboard.isDown('d') then
		if self.x < (love.graphics.getWidth() - self.size) then
			self.x = self.x + (self.speed * dt)
		end
	elseif love.keyboard.isDown('a') then
		if self.x > 0 then 
			self.x = self.x - (self.speed * dt)
		end
	end
    self:jumpingStatus(dt)
    -- collision detection
    if self.y > self.ground then
        self:clearJump()
	end
end
