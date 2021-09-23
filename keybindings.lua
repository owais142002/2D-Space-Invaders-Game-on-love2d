local keybindings={}
function keybindings.load()
  k_back=love.keyboard.isDown("backspace")
  m_r="right"
  m_l="left"
  m_f="space"
end
function keybindings.update(dt)
  a=true
end
function keybindings.draw()
  if a then
    love.graphics.draw(menu_image,800/284,600/177,r,3.5,3.5)
    love.graphics.draw(backspace,700,5,r,1.2,1.2)
    love.graphics.print("keybindings",300,5)
    love.graphics.rectangle("line",295,5,245,50)
    if k_back then
      key_b=true
      a=false
      end
    end
  
end
return keybindings