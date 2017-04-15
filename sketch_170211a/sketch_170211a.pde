void setup(){size(1080,720);
frameRate(5);}
void draw()
{
  background(random(255),random(255),random(255));
  strokeWeight(10);
  ellipse(150,150,150,150);

strokeWeight(10);
ellipse(350,150,150,150);

strokeWeight(10);
if((pmouseX>=75)&& (pmouseX<=255)&&(pmouseY>=75)&&(pmouseY<=255))
{fill(0);
ellipse(150,150,150,150);
fill(255);
}
else{
fill(255);
ellipse(150,150,150,150);
fill(255);
ellipse(350,150,150,150);
}
//if(pmouseX>=275)&&(pmouseX<=475)&&(pmouseY>=75)&&(pmouseY<=)
}