width = 720
height = 1280
half_height = height / 2
half_width = width / 2
position_ref = width / 7
way_counter = 1
controls_rate = 1/3;
controls_sec_ref = 0
second_ref = 0

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
  aux = height / 20
  love.graphics.line(half_width, (aux * way_counter) - aux, half_width, (aux * way_counter * 1.2))
  love.graphics.line((half_width - (half_width / 4)), 0, (half_width / 8), height)
  love.graphics.line((half_width + (half_width / 4)), 0, (width - (half_width / 8)), height)
  way_counter = way_counter + (dt * 10) 

  if way_counter > 20 then
    way_counter = 1
  end
end

function controls()
  current_position = player["position"]

  if love.keyboard.isDown("d") then
    print("d")
    if current_position < 7 then
      player["position"] = current_position + 1
    end
  end

  if love.keyboard.isDown("a") then
    print("a")
    if current_position > 1 then
      player["position"] = current_position - 1
    end
  end
end

function love.update(dt)
  second_ref = second_ref + dt
  controls_sec_ref = controls_sec_ref + dt
  function love.draw()
    way_drawer(dt)
    player_drawer()
  end

  if controls_sec_ref > 1/10 then
    controls_sec_ref = 0
    controls()
  end

  if (second_ref == 1) then
    second_ref = 0
  end
end
