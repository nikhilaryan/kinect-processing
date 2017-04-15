Thing thing1;
Thing thing2;
PImage a;
void setup(){
  size(700,700);
  smooth();
  a=loadImage("C:/Fireball.png");
  thing1 = new Thing(1*width/6,height/6,true);
  thing2 = new Thing(5*width/6,height*5/6,true);
}
  
void draw(){
  background(100);
  stroke(0);
  thing1.display(thing2);
  thing2.display(thing1);
  int x1=thing1.getx();
  int x2=thing2.getx();
  int y1=thing1.gety();
  int y2=thing2.gety();
  int x,y,x0,y0;
  x0=x1;
  y0=y1;
  if(x1+(4*frameCount)<=(x1+x2)/2)                                  //provided    x1<x2and y1<y2
  {
    strokeWeight(frameCount/2);
     x=x0+30;
     y=y0+30*(y2-y1)/(x2-x1);
    //line(x0,y0,x0+30,y0+30*(y2-y1)/(x2-x1));
    x0+=30;
    y0+=30;
    line(x2,y2,x2-(4*frameCount),-(4*frameCount)*(y2-y1)/(x2-x1)+y2);
    line(y1,y1,x1+(4*frameCount),+(4*frameCount)*(y2-y1)/(x2-x1)+y1);
  
}
}

class Thing
{
  PVector loc;
  boolean glowing;
  Thing(int x, int y, boolean glow){
    loc = new PVector(x,y);
    glowing = glow;
  }
  int getx()
  {
    return (int)loc.x;
  }
  
  int gety()
  {
    return (int)loc.y;
  }
  void display(Thing t){
   if(glowing){
      //float glowRadius = 100.0;
      float glowRadius = 100.0 + 15 * sin(frameCount/(3*frameRate)*TWO_PI); 
      strokeWeight(2);
      fill(255,255,0);
      for(int i = 0; i < glowRadius; i++){
       image(a,loc.x-(15+i)/2,loc.y-(15+i)/2,15+i,15+i);
     }
    }
    //fill(255,255,0);
    int x1=(int)loc.x;    
    int y1=(int)loc.y;
    int x2=t.getx();    
    int y2=t.gety();
     //if(x1+(3*frameCount)<(x1+x2)/2)
      //line(x1,y1,x1+(3*frameCount),(3*frameCount)*(y2-y1)/(x2-x1)+y1);
  
    stroke(255,255,0);
        
  }
    
} 
       