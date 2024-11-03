local Crab={
    is_attacking_upper=false,
    is_attacking_lower=false,

    Body={
        x=0,
        y=love.graphics.getHeight()/2,
        radius=love.graphics.getWidth()/7,

        draw=function(self)
            love.graphics.setColor(1,1,1)
            love.graphics.circle("fill",self.x,self.y,self.radius)
        end,

        Hitbox={
            x=0,
            y=love.graphics.getHeight()/2,
            radius=love.graphics.getWidth()/7,

            draw=function(self)
                love.graphics.setColor(1,0,1)
                love.graphics.circle("line",self.x,self.y,self.radius)
            end
        }

    },

    UpperHand={
        X1=love.graphics.getWidth()/12,
        Y1=love.graphics.getHeight()/5.5,
        x1=love.graphics.getWidth()/12,
        y1=love.graphics.getHeight()/6,

        hand_width=love.graphics.getWidth()/3,
        hand_height=love.graphics.getHeight()/5,

        X2=0,
        Y2=0,
        x2=0,
        y2=0,

        rotation_angle=0.2*math.pi, --radians
        rotation_speed=0.8,
        rotation_step=0.01*math.pi,
        rotation_progress=0,

        update=function(self, Crab)
            self.X2=self.X1+self.hand_width
            self.Y2=self.Y1+self.hand_height


            local halfWid=self.hand_width/2
            local halfHei=self.hand_height/2
            local centerX=self.X1+self.hand_width/2
            local centerY=self.Y1+self.hand_height/2
            
            if Crab.is_attacking_upper then
                
                if self.rotation_progress < self.rotation_angle then
                    self.rotation_progress=self.rotation_progress+self.rotation_step*self.rotation_speed
                    print(self.rotation_progress)

                    self.x1=centerX*1.1+(-halfWid*math.cos(self.rotation_progress*1.7))+(-halfHei*math.sin(self.rotation_progress))
                    self.y1=centerY*1.1+(-halfWid*math.sin(self.rotation_progress*0.8))+(-halfHei*math.cos(self.rotation_progress))

                    self.x2=centerX*0.88+(halfWid*math.cos(self.rotation_progress*1.7))+(halfHei*math.sin(self.rotation_progress))
                    self.y2=centerY*0.88+(halfWid*math.sin(self.rotation_progress*0.8))+(halfHei*math.cos(self.rotation_progress))

                else
                    Crab.is_attacking_upper=false
                end
            else
                if self.rotation_progress > 0 then
                    self.rotation_progress=self.rotation_progress-self.rotation_step*self.rotation_speed

                    self.x1=centerX*1.1+(-halfWid*math.cos(self.rotation_progress*1.7))+(-halfHei*math.sin(self.rotation_progress))
                    self.y1=centerY*1.1+(-halfWid*math.sin(self.rotation_progress*0.8))+(-halfHei*math.cos(self.rotation_progress))
                    
                    self.x2=centerX*0.88+(halfWid*math.cos(self.rotation_progress*1.7))+(halfHei*math.sin(self.rotation_progress))
                    self.y2=centerY*0.88+(halfWid*math.sin(self.rotation_progress*0.8))+(halfHei*math.cos(self.rotation_progress))

                    if self.rotation_progress<0 then
                        self.rotation_progress=0
                    end
                end
            end
        end,

        draw=function(self)
            local centerX=self.X1+self.hand_width/2
            local centerY=self.Y1+self.hand_height/2

            love.graphics.push()
            love.graphics.translate(self.X1+self.hand_width/2,self.Y1+self.hand_height/2)
            love.graphics.setColor(1,1,1)
            love.graphics.rotate(self.rotation_progress)
            love.graphics.rectangle("fill",-self.hand_width/2,-self.hand_height/2,self.hand_width,self.hand_height)
            love.graphics.pop()

            love.graphics.setColor(1,0,0)
            love.graphics.rectangle("fill",self.x1,self.y1,5,5)
            love.graphics.setColor(1,0,0)
            love.graphics.rectangle("fill",self.x2,self.y2,5,5)
            love.graphics.setColor(1,0,0)
            love.graphics.rectangle("fill",centerX,centerY,5,5)
           
        end,

        Hitbox={
            x1=0,
            x2=0,
            y1=0,
            y2=0,
            current_rotation=0,

            update=function(self,crab)
                x1=crab.UpperHand.x1
                y1=crab.UpperHand.y1
                currtent_rotation=crab.UpperHand.rotation_progress
                x2=crab.UpperHand.x2
                y2=crab.UpperHand.y2
                
            end

        }
    },

    LowerHand={
        hand_width=love.graphics.getWidth()/3,
        hand_height=love.graphics.getHeight()/5,
        X1=love.graphics.getWidth()/12,
        Y1=love.graphics.getHeight()/1.6,
        x1=love.graphics.getWidth()/12,
        y1=love.graphics.getHeight()/1.75+love.graphics.getHeight()/5,

        

        X2=0,
        Y2=0,
        x2=0,
        y2=0,

        rotation_angle=-0.2*math.pi, --radians
        rotation_speed=0.8,
        rotation_step=0.01*math.pi,
        rotation_progress=0,

        update=function(self, Crab)
            self.X2=self.X1+self.hand_width
            self.Y2=self.Y1+self.hand_height


            local halfWid=self.hand_width/2
            local halfHei=self.hand_height/2
            local centerX=self.X1+self.hand_width/2
            local centerY=self.Y1+self.hand_height/2
            
            if Crab.is_attacking_lower then
                
                if self.rotation_progress > self.rotation_angle then
                    self.rotation_progress=self.rotation_progress-self.rotation_step*self.rotation_speed
                    print(self.rotation_progress)

                    self.x1=centerX*1.1+(-halfWid*math.cos(self.rotation_progress))+(-halfHei*math.sin(self.rotation_progress))
                    self.y1=self.hand_height+centerY*0.95+(-halfWid*math.sin(self.rotation_progress*0.8))+(-halfHei*math.cos(self.rotation_progress))

                    self.x2=centerX*0.87+(halfWid*math.cos(self.rotation_progress))+(halfHei*math.sin(self.rotation_progress))
                    self.y2=-self.hand_height+centerY*1.05+(halfWid*math.sin(self.rotation_progress*0.7))+(halfHei*math.cos(self.rotation_progress))

                else
                    Crab.is_attacking_lower=false
                end
            else
                if self.rotation_progress < 0 then
                    self.rotation_progress=self.rotation_progress+self.rotation_step*self.rotation_speed

                    self.x1=centerX*1.1+(-halfWid*math.cos(self.rotation_progress))+(-halfHei*math.sin(self.rotation_progress))
                    self.y1=self.hand_height+centerY*0.95+(-halfWid*math.sin(self.rotation_progress*0.8))+(-halfHei*math.cos(self.rotation_progress))
                    
                    self.x2=centerX*0.87+(halfWid*math.cos(self.rotation_progress))+(halfHei*math.sin(self.rotation_progress))
                    self.y2=-self.hand_height+centerY*1.05+(halfWid*math.sin(self.rotation_progress*0.7))+(halfHei*math.cos(self.rotation_progress))

                    if self.rotation_progress>0 then
                        self.rotation_progress=0
                    end
                end
            end
        end,

        draw=function(self)
            local centerX=self.X1+self.hand_width/2
            local centerY=self.Y1+self.hand_height/2

            love.graphics.push()
            love.graphics.translate(self.X1+self.hand_width/2,self.Y1+self.hand_height/2)
            love.graphics.setColor(1,1,1)
            love.graphics.rotate(self.rotation_progress)
            love.graphics.rectangle("fill",-self.hand_width/2,-self.hand_height/2,self.hand_width,self.hand_height)
            love.graphics.pop()

            love.graphics.setColor(1,0,0)
            love.graphics.rectangle("fill",self.x1,self.y1,5,5)
            love.graphics.setColor(1,0,0)
            love.graphics.rectangle("fill",self.x2,self.y2,5,5)
            love.graphics.setColor(1,0,0)
            love.graphics.rectangle("fill",centerX,centerY,5,5)
           
        end,

        Hitbox={
            x1=0,
            x2=0,
            y1=0,
            y2=0,
            current_rotation=0,

            update=function(self,crab)
                x1=crab.UpperHand.x1
                y1=crab.UpperHand.y1
                currtent_rotation=crab.UpperHand.rotation_progress
                x2=crab.UpperHand.x2
                y2=crab.UpperHand.y2
                
            end

        }
    }
    
}

return Crab