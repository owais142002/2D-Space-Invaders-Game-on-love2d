gameover={}
function gameover.load()
  
end
function gameover.update(dt)
    player:delbullets()
    enemycontroller:delall()

end
function gameover.draw()
      if gover==true then
      gover=true
      end
      love.graphics.draw(gameover_pic,t_w/284,t_h/177,r,3.5,3.5)
--      love.graphics.print("Level:",680,20)
--      love.graphics.print(tostring(level),740,20)
      love.graphics.setNewFont(30)
      love.graphics.print("Your Score:",300,400)
      love.graphics.print(tostring(score),480,400)
end
return gameover