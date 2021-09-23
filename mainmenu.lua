local menu = {}
local mainmenu={}
--del_new=3
function menu.load()
  table.insert(mainmenu,newButton("New Game", function()
    print "Starting New Game"
    level=(level-level)+1
    gamestate = "game"
    health=10
    score=0
    speed_enemy=1
    player:delbullets()
    enemycontroller:delall()  
    enemycontroller:spawnenemy()
    enemycontroller:spawnenemy()
    enemycontroller:spawnenemy()
    g=true
    s=false
    --del_new=del_new-1
  end))
  table.insert(mainmenu,newButton("Keybindings", function()
    print "Opening Keybindings settings...."
    s=true
    a=true
    key_b=false
    end ))
  table.insert(mainmenu,newButton("Quit Game", function()
    love.event.quit(0) end ))
end

function menu.update()
  j=love.keyboard.isDown("escape")
  if j and g then
    print(g)
    print(res)
    print(rep_res)
      res=true
      if  gover==true then 
        rep_res=true
      end
      if res and rep_res then
        print(g)
        print(res)
        print(rep_res)
        table.insert(mainmenu,1,newButton("Resume Game",function()
        print"Resuming game"
        g=true
        rep_res=false
        gover=false
        gamestate="game"
      end))
      end
      g=false
      gover=false 
      rep_res=false
      gamestate="menu"
    end
end

function menu.draw()
  love.graphics.draw(menu_image,t_w/284,t_h/177,r,3.5,3.5)
  margin=16
  local total_hieght =( button_height+margin )* #menu
  
  local cursor_y=0
  local ww=love.graphics.getWidth()
  local wh=love.graphics.getHeight()
  local button_width= ww *(1/3)
  for i,button in ipairs(mainmenu) do
    button.now=button.last
    local bx=(ww*0.5)-button_width*0.5
    local by=(wh*0.25)-(button_height*0.5)+cursor_y
    local mx,my=love.mouse.getPosition()
    local hot=  mx > bx and  mx < bx + button_width  and my > by and my < by+button_height
    if hot then
      love.graphics.setColor(0.8, 0.8, 0.9, 1.0)
    else
      love.graphics.setColor(0, 0, 0, 1)
    end
    button.now= love.mouse.isDown(1)
    if button.now and not button.last and hot then
      button.fn()
    end
    love.graphics.rectangle("fill",(ww*0.5)-button_width*0.5,(wh*0.25)-(button_height*0.5)+cursor_y,button_width,button_height)
    love.graphics.setColor(5,8,13,1)
    love.graphics.setFont(Font)
    love.graphics.print(button.text, bx+margin, by)
    cursor_y=cursor_y+button_height+margin
  end
end

local function loadMenu()
  return menu, mainmenu
end

return loadMenu