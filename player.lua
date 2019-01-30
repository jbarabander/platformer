local Object = require "classic"
local math = require "math"
local world = require "world"

Player = Object:extend()
local MAX_NUM_OF_JUMPING_FRAMES = 10

local playerFilter = function(item, other)
    if other.isFloor or other.isPlatform then
        return "slide"
    elseif other.isGoal then
        return "cross"
    elseif other.isSpike then
        return "cross"
    end
end

function Player:new(x, y)
    self.type = 'player'
    self.speed = 200
    self.yVelocity = 0 
    self.jumpHeight = -300
    self.gravity = -1000
    self.size = 50
    self.x = x
    self.y = y - self.size
    self.h = self.size
    self.w = self.size
    self.jumpingFrames = 0
    self.hasJumped = false
    self.jumpHeldDown = false
    self.hasDoubleJumped = false
    self.doubleJumpHeight = self.jumpHeight * 0.9
    world:add(self, self.x, self.y, self.w, self.h)
end

function Player:clear()
    world:remove(self)
    self:clearJump()
end

function Player:debug()
    -- debugging info
    local hasJumped
    if self.hasJumped then
        hasJumped = "true"
    else 
        hasJumped = "false"
    end
    local hasDoubleJumped
    if self.hasDoubleJumped then
        hasDoubleJumped = "true"
    else 
        hasDoubleJumped = "false"
    end
    local jumpHeldDown
    if self.jumpHeldDown then
        jumpHeldDown = "true"
    else
        jumpHeldDown = "false"
    end
    love.graphics.print("y velocity: "..self.yVelocity, 12, 40)
    love.graphics.print("jump called: "..hasJumped, 12, 54)
    love.graphics.print("double jump called: "..hasDoubleJumped, 12, 66)
    love.graphics.print("jumping frames: "..self.jumpingFrames, 12, 78)
    love.graphics.print("jump held down: "..jumpHeldDown, 12, 90)
end


function Player:draw()
    love.graphics.rectangle("line", self.x, self.y, self.size, self.size)
    love.graphics.setColor(255, 255, 255, 255)
    self:debug()
end

function Player:clearVelocity()
    self.yVelocity = 0
end

function Player:clearJumpingFrames()
    self.jumpingFrames = 0
end

function Player:clearJump()
    self:clearJumpingFrames()
    self:clearVelocity()
    self.hasDoubleJumped = false
    self.hasJumped = false
end

function Player:jump()
    self.hasJumped = true
    self.jumpHeldDown = true
    self.yVelocity = self.jumpHeight
end

function Player:doubleJump()
    self:clearJumpingFrames()
    self.yVelocity = self.doubleJumpHeight
    self.hasDoubleJumped = true
end

function Player:reAddJumpHeight()
    if not self.hasDoubleJumped then
        self:jump()
    end
end

function Player:jumpingStatus(dt)
    if love.keyboard.isDown('space') then
        if not self.hasJumped or (self.jumpingFrames < MAX_NUM_OF_JUMPING_FRAMES and self.jumpHeldDown) then
            self:reAddJumpHeight()
            self.jumpingFrames = self.jumpingFrames + 1
        end
    end 
    if self.yVelocity ~= 0 then
        self.y = self.y + self.yVelocity * dt
    end
end

function Player:checkCollision()
    local actualX, actualY, cols, len = world:move(self, self.x, self.y)
    local oldX = self.x
    local oldY = self.y
    self.x = actualX
    self.y = actualY
    for i=1,len do
        local other = cols[i].other
        local fromBottom = (other.isFloor or other.isPlatform) and self.y < oldY
        local fromTop = other.isPlatform and self.y == other.y + other.h
        if fromBottom then
            self:clearJump()
        elseif fromTop then
            self:clearVelocity()
        elseif other.isGoal then
            other:setPlayerHasReached(true)
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
    self:checkCollision(dt)
    self.yVelocity = self.yVelocity - self.gravity * dt
end
