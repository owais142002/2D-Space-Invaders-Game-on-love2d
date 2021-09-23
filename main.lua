local loadMenu = require('mainmenu')
local menu, mainmenu = loadMenu()
local game = require('game')
local keybindings=require('keybindings')
local gameover= require('gameover')
local animation=require('animation')
local anim_pic
local animation_destroy
local fps =10
local anim_timer=1/fps
local num_frames=6
local frame=1
local xoffset
local anim_x=0
local anim_y=0
v=true
gover=true
health=10
rot=0
explosion=false
fire_sound=love.audio.newSource("fire.wav","static")
Font=love.graphics.newFont("font.ttf",32)
function newButton(text,fn)
  return {text=text,fn=fn
    ,now= false,
  last= false
   }
end
key_b=true
button_height=40
score=0
h=0
enemy_x=2
g=false
v=false
s=true
bullet_shape=love.graphics.newImage("bullet1.png")
menu_image=love.graphics.newImage("mainmenuimage.png")
background_game=love.graphics.newImage("backgroundgame.jpg")
monster_image=love.graphics.newImage("monster.png")
backspace=love.graphics.newImage("back3.png")
gameover_pic=love.graphics.newImage("gameover.png")
hpasset=love.graphics.newImage('hpasset.png')
res=true
rep_res=true
speed_enemy=1
local gamestate = 'menu'
game.load()
menu.load()
animation.load()
timer=0
function love.update(dt)
  keybindings.load()
  menu.update()
  if key_b then
    function love.draw()
      love.graphics.setFont(Font)
      menu.draw()
    end
  end
  if g then
      if health>0 then
      if health>0 and level==15 then
        function love.draw()
          gameover_pic=love.graphics.newImage("gamewon.png")
          gameover.draw()
          gameover.update()
          rep_res=false
        end
      else
        levelup()
        game.update()
        if dt>0.035 then end
        anim_timer=anim_timer-dt
        animation.update()
        function love.draw()
          love.graphics.setFont(Font)
          game.draw()
          animation.draw()
          animation.draw()
          animation.draw()
        end
      end
    else
      if health==0 then
        function love.draw()
          gameover_pic=love.graphics.newImage("gameover.png")
          gameover.draw()
          gameover.update()
          rep_res=false
        end
      end
    end
  end

if key_b==false then
      function love.draw()
        keybindings.draw()
      end
 end
 end



