local game = {}
local animation=require('animation')

function game.load()
  enemy={}
  hp={}
  hpcontroller={}
  hpcontroller.health={}
  enemycontroller={}
  enemycontroller.enemies={}
  player={}
  player.x=0
  player.bullets={}
  player.cooldown=25
  k=0
  level=1
  player.fire=function()
    if player.cooldown <= 0 then
      love.audio.stop(fire_sound)
      love.audio.play(fire_sound)  
      k=k+1
      player.cooldown=25
      bullet={}
      bullet.x=player.x
      bullet.y=530
      player_gun=love.graphics.newImage("gunfire.png")
      gfirex_x=t_w/800-110
      gfirex_y=t_h/600+435
      gfirex_sx=0.5
      gfirex_sy=0.5
      table.insert(player.bullets,bullet)
    end
  end
  function player:delbullets()
    for i,e in ipairs(self.bullets) do
        if e.y>0 then
          e.y=-1000
      end
        end
    end
    function enemycontroller:spawnenemy()
      enemy={}
      enemy.x=math.random(50,500)
      enemy.y=math.random(-400,-50)
      enemy.height=10
      enemy.width=30
      table.insert(self.enemies,enemy)
    end
    function hpcontroller:spawn()
       hp={}
       hp.x=math.random(50,500)
       hp.y=math.random(-400,-50)
       hp.height=10
       hp.width=10
       table.insert(self.health,hp)
    end
    function enemycontroller:delall()
      for i,e in ipairs(self.enemies) do
        table.remove(self.enemies,i)
        end
    end
    function hpcontroller:delall()
      for i,e in ipairs(self.health) do
        table.remove(self.health,i)
        end
    end
  function levelup()
    if next(enemycontroller.enemies)==nil then
      if level==1 or level ==5 or level ==8 or level==11 or level==13 then
       hpcontroller:spawn()
    end
      level=level+1
      speed_enemy=speed_enemy+0.3
      for i=1,2+(level*2) do
       enemycontroller:spawnenemy()
      end
      end
    end
  function checkcollision(enemies,bullets)
    for i,e in ipairs(enemies) do
     for k,b in ipairs(bullets) do
      if  b.x < e.x+8 and b.x > e.x-74 and b.y<e.y+e.height then 
         table.remove(enemies,i)
         destroy_x=e.x
         destroy_y=e.y
         destroy=true
         explosion=true
         table.remove(bullets,k)
         score=score+2
        end
        explosion=false
      end
    end
  end
-- graphics for firing
player_gun=love.graphics.newImage("gun2.png")
gfirex_x=t_w/276
gfirex_y=t_h/149+530
gfirex_sx=0.5
gfirex_sy=0.5
-------------
end
function game.update(dt)
  local no_of_bullets=2
  player.cooldown=player.cooldown-no_of_bullets
  local b=love.keyboard.isDown(m_r)
  local c=love.keyboard.isDown(m_l)
  local d=love.keyboard.isDown(m_f)
  local j=love.keyboard.isDown("escape")
  function love.keyreleased(key)
    if key == "space" then
      -- graphics for firing
      player_gun=love.graphics.newImage("gun2.png")
      gfirex_x=t_w/276
      gfirex_y=t_h/149+530
      gfirex_sx=0.5
      gfirex_sy=0.5
-------------
    end
  end
    if d then
      player.fire()
    end
    for i,b in ipairs(player.bullets)do
      --for deleting the bullet far away
      if b.y<20 then
        table.remove(player.bullets,i)
      end
      -- for speed of bullet
      speed_bullet=7
      if level==5 or level==10 or level==12 then
        speed_bullet=speed_bullet+4
      end
      b.y=b.y-speed_bullet
    end
--    for i,b in ipairs(player.bullets)do
--      --for deleting the bullet far away
--      if b.y<500 and del_new<2 then
--     s   table.remove(player.bullets,i)
--      end
--    end
    if b and player.x<650 then 
      player.x=player.x+9 
      rot=0
      end
    if c and player.x>0 then 
      player.x=player.x-9 
      rot=-0.
    end
    collision_wall=false
    for i,e in ipairs(enemycontroller.enemies) do
      e.y=e.y+speed_enemy
      if e.x <= 700 and e.x >= 0 then 
            if e.x==700 or e.x==0 then
              enemy_x=enemy_x*-1
            end
            e.x=e.x+enemy_x
        end
    for i,h in ipairs(hpcontroller.health) do 
        h.y=h.y+0.4
          if  h.y>525 and h.y<575 and h.x>gfirex_x+player.x-25 and h.x<gfirex_x+player.x+110   then
          table.remove(hpcontroller.health,i)
          health=health+1
        end
      end
--        if e.x<360 then
--          e.x=e.x-1
--        end
  
      if e.y>500 then
        table.remove(enemycontroller.enemies,i)
        health=health-1
      end
      end
destroy=false
checkcollision(enemycontroller.enemies,player.bullets)
  end

function game.draw()
      v=true
      love.graphics.setColor(255,255,255)
      love.graphics.draw(background_game,t_w/640,t_h/480,r,1.5,1.5)
      love.graphics.setColor(0.8,1.8,3)
      love.graphics.draw(player_gun,gfirex_x+player.x,gfirex_y,rot,gfirex_sx,gfirex_sy)
      love.graphics.setNewFont(16)
      love.graphics.print("Level:",680,20)
      love.graphics.print(tostring(level),740,20)
      love.graphics.print("Score:",680,35)
      love.graphics.print(tostring(score),740,35)
      love.graphics.print("Health:",680,5)
      love.graphics.print(tostring(health),740,5)
      love.graphics.setColor(255,255,255)
      --- for generating bullets
      for _,b in pairs(player.bullets) do
        love.graphics.draw(bullet_shape,b.x+63,b.y,r,0.1,0.1)
      end
      for _,e in pairs(enemycontroller.enemies) do
        love.graphics.setColor(255,255,255)
        love.graphics.draw(monster_image,e.x,e.y,r,0.2,0.2)
      end
      for i,k in ipairs (hpcontroller.health)do
        love.graphics.draw(hpasset,k.x,k.y,r,1,1)
        end
end

return game