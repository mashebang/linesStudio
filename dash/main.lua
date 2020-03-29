lume = require "lume"

width = 720
height = 1280
half_height = height / 2
half_width = width / 2
position_ref = width / 7
controls_sec_ref = 0
score = 0

player = {}
player["position"] = 1
player["height"] = 900
player["radius"] = 30

function love.load()
  love.window.setMode(width, height)
end

function player_drawer()
  x_cord = position_ref * player["position"]
  love.graphics.circle("fill", (x_cord - 50), player["height"], player["radius"])
end

function way_drawer(dt)
  lateral_size = width / 8
  love.graphics.print(lume.round(score * 100), 0, 100)
  love.graphics.line(lateral_size, 0, lateral_size, height)
  love.graphics.line(width - lateral_size, 0, (width - lateral_size), height)
  love.graphics.line(width - lateral_size, 0, (width - lateral_size), height)
end

function move_right()
  if player["position"] < 7 then
    player["position"] = current_position + 1
  end
end

function move_left()
  if player["position"] > 1 then
    player["position"] = current_position - 1
  end
end

function controls()
  if love.keyboard.isDown("d") then
    move_right()
  end

  if love.keyboard.isDown("a") then
    move_left()
  end
  if love.mouse.isDown(1) then
    x = love.mouse.getX()
    if (x > half_width) then
      move_right()
    else
      move_left()
    end  
  end
end

function love.update(dt)
  controls_sec_ref = controls_sec_ref + dt
  function love.draw()
    way_drawer(dt)
    player_drawer()
  end

  if controls_sec_ref > 1/10 then
    controls_sec_ref = 0
    controls()
  end

  current_position = player["position"]

  if current_position == 1 or current_position == 7 then
    score = score - dt
  else
    score = score + dt
  end
end
