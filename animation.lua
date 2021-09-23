local animation={}
local fps=10
local anim_timer=1/fps
function animation.load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  anim_pic=love.graphics.newImage("animation.png")
  animation_destroy=love.graphics.newQuad(0,0,55,53, anim_pic:getDimensions())
end
function animation.update()
  if anim_timer<=0 then
    anim_timer=1/fps
    frame=frame+1
    if frame<=num_frames then 
      anim_x=0
      anim_y=0
    else
      anim_x=-1000
      anim_y=-1000
    end
    xoffset=55*frame
    animation_destroy:setViewport(xoffset,0,54,55)
  end
end
function animation.draw()
  if destroy==true then
  love.graphics.draw(anim_pic,animation_destroy, destroy_x,destroy_y,r,1.2,1.2)
  end
end
return animation