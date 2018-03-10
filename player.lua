local Object = require "classic"
local math = require "math"
local world = require "world"

Player = Object:extend()

local MAX_NUM_OF_JUMPING_FRAMES = 15


function Player:new()
    self.type = 'player'
    self.speed = 200
    self.yVelocity = 0 
    self.jumpHeight = -300
    self.gravity = -1000
    self.x = love.graphics.getWidth() / 2
	self.y = love.graphics.getHeight() / 2 - 50
    self.size = 50
    self.h = self.size
    self.w = self.size
    self.jumpingFrames = 0
    self.hasJumped = false
    self.jumpHeldDown = false
    self.hasDoubleJumped = false
    self.doubleJumpHeight = self.jumpHeight * 0.9
    world:add(self, self.x, self.y, self.w, self.h)
end

function Player:draw()
    love.graphics.rectangle("line", self.x, self.y, self.size, self.size)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print("actualX: "..actualX, 12, 12)
    love.graphics.print("actualY: "..actualY, 12, 26)
end

function Player:canStillJump()
    return (
        self.yVelocity == 0 or 
        self.jumpingFrames < MAX_NUM_OF_JUMPING_FRAMES
    )
end

function Player:clearJump()
    self.jumpingFrames = 0
    self.yVelocity = 0
    self.hasDoubleJumped = false
    self.hasJumped = false
end

function Player:jump()
    if self.yVelocity == 0 then
        self.hasJumped = true
        self.jumpHeldDown = true
        self.yVelocity = self.jumpHeight
    end
end

function Player:doubleJump()
    self.jumpingFrames = 0
    self.yVelocity = self.doubleJumpHeight
    self.hasDoubleJumped = true
end

function Player:reAddJumpHeight()
    if not self.hasDoubleJumped then
        self.yVelocity = self.jumpHeight
    end
end

function Player:jumpingStatus(dt)
	if love.keyboard.isDown('space') then
        if self.yVelocity == 0 or (self.jumpingFrames < MAX_NUM_OF_JUMPING_FRAMES and self.jumpHeldDown) then
		    self:reAddJumpHeight()
            self.jumpingFrames = self.jumpingFrames + 1
        end
	end 
	if self.yVelocity ~= 0 then
		self.y = self.y + self.yVelocity * dt
		self.yVelocity = self.yVelocity - self.gravity * dt
	end
end

function Player:checkCollision()
    actualX, actualY, cols, len = world:move(self, self.x, self.y)
    self.x = actualX
    self.y = actualY
    for i=1,len do
        local other = cols[i].other
        if other.isFloor then
            self:clearJump()
        end
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
    self:checkCollision()
end
