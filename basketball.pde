

import KinectPV2.KJoint;
import KinectPV2.*;

KinectPV2 kinect;

float x = random(50,width-50),y=400,d=100,x1[],y1[],theta;
int i=0;
float rateX=random(2,5),rateY=0,gravity=0.2,diffX,diffY,temp;
PImage bg,bb,net;
boolean play=true;
void setup() {
  //size(1920,1080, P3D);
  fullScreen(P3D);
  bg = loadImage("E:/bb_bg.jpg");
  bb= loadImage("E:/basketball.png");
  net = loadImage("E:/net.png");
  kinect = new KinectPV2(this);

  kinect.enableSkeletonColorMap(true);
  //kinect.enableColorImg(true);
  
  
  kinect.init();
}

void draw() {
  
  background(0);
  image(bg,0,0,width,height);
  image(net,width-220,160,200,200);
  pushMatrix();
  //fill(50,120,150);
  //println(rateY);
  if(play==true)
  {
  x+=rateX;
  y+=rateY;
  rateY+=gravity;
  }
 
    if(x<d/2)
    {
      rateX*=-1;
      x=(d/2)+1;
    }
    else if(x>width-d/2)
    {
      
      rateX*=-1;
      x=width-(d/2)-1;
    }
    if(y<d/2)
    {
      rateY-=gravity;
      rateY*=-1;
      y=(d/2) +1;
    }
    else if(y>height-d/2)
    {
      rateY-=gravity;
      rateY*=-1;
      y=height - (d/2) -1;
    }
    
  //ellipse(x,y,d,d);
  image(bb,x,y,d,d);
  popMatrix();
  //image(kinect.getColorImage(), 0, 0, width, height);
  
  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();

  //individual JOINTS
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();

      color col  = skeleton.getIndexColor();
      fill(col);
      stroke(col);
      drawBody(joints);

      //draw different color for each hand state
      drawHandState(joints[KinectPV2.JointType_HandRight]);
      drawHandState(joints[KinectPV2.JointType_HandLeft]);
    }
  }
  pushMatrix();
  fill(255, 0, 0);
  text(frameRate, 50, 50);
  popMatrix();
}

//DRAW BODY
void drawBody(KJoint[] joints) {
   
  drawBone(joints, KinectPV2.JointType_Head, KinectPV2.JointType_Neck);
  drawBone(joints, KinectPV2.JointType_Neck, KinectPV2.JointType_SpineShoulder);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineMid);
  drawBone(joints, KinectPV2.JointType_SpineMid, KinectPV2.JointType_SpineBase);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderRight);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderLeft);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipRight);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipLeft);

  // Right Arm
  drawBone(joints, KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight);
  drawBone(joints, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_HandRight);
  drawBone(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_HandTipRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_ThumbRight);

  // Left Arm
  drawBone(joints, KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft);
  drawBone(joints, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_WristLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_HandLeft);
  drawBone(joints, KinectPV2.JointType_HandLeft, KinectPV2.JointType_HandTipLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_ThumbLeft);

  // Right Leg
  drawBone(joints, KinectPV2.JointType_HipRight, KinectPV2.JointType_KneeRight);
  drawBone(joints, KinectPV2.JointType_KneeRight, KinectPV2.JointType_AnkleRight);
  drawBone(joints, KinectPV2.JointType_AnkleRight, KinectPV2.JointType_FootRight);

  // Left Leg
  drawBone(joints, KinectPV2.JointType_HipLeft, KinectPV2.JointType_KneeLeft);
  drawBone(joints, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_AnkleLeft);
  drawBone(joints, KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_FootLeft);

  drawJoint(joints, KinectPV2.JointType_HandTipLeft);
  drawJoint(joints, KinectPV2.JointType_HandTipRight);
  drawJoint(joints, KinectPV2.JointType_FootLeft);
  drawJoint(joints, KinectPV2.JointType_FootRight);

  drawJoint(joints, KinectPV2.JointType_ThumbLeft);
  drawJoint(joints, KinectPV2.JointType_ThumbRight);

  drawJoint(joints, KinectPV2.JointType_Head);
}

//draw joint
void drawJoint(KJoint[] joints , int jointType) {
  pushMatrix();
  translate(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ());
  if(jointType == KinectPV2.JointType_HandTipLeft)
  {
   diffX=joints[KinectPV2.JointType_HandLeft].getX()-x;
    diffY=joints[KinectPV2.JointType_HandLeft].getY()-y;
    if(abs(diffX)<=70 && abs(diffY)<=d/2)
      {
        //println(diffX+","+diffY);
        //rateX=random(-3,3);
       
        //fill(200,120,50);
        //ellipse(x,y,d,d);
        if(rateY>0)
          y-=50;
        else if(rateY<0)
          y+=0;
        rateY*=-1;
        rateX=random(2,5);
        if(abs(joints[KinectPV2.JointType_HandLeft].getX()-joints[KinectPV2.JointType_HandRight].getX())<=100 && abs(joints[KinectPV2.JointType_HandLeft].getY()-joints[KinectPV2.JointType_HandRight].getY())<=100)
        
         {
           play=false;
           x=(joints[KinectPV2.JointType_HandLeft].getX()+joints[KinectPV2.JointType_HandRight].getX())/2;
           y=(joints[KinectPV2.JointType_HandLeft].getY()+joints[KinectPV2.JointType_HandRight].getY())/2;
           temp=joints[KinectPV2.JointType_HandLeft].getY()-joints[KinectPV2.JointType_ShoulderLeft].getY();
           //println(temp);
           if(temp<-100)
           {
             theta=atan2(abs(y-joints[KinectPV2.JointType_ShoulderLeft].getY()),abs(x-joints[KinectPV2.JointType_ShoulderLeft].getX()));
             //println(theta*180/PI);
             rateX=50*cos(theta);
             rateY=-5*sin(theta);
             println(rateX+","+rateY);
           }  
         }
         else
         {
           
           play=true;
         }
      }
      
      
  }
  else if(jointType == KinectPV2.JointType_HandTipRight)
  {
   
   diffX=joints[KinectPV2.JointType_HandRight].getX()-x;
    diffY=joints[KinectPV2.JointType_HandRight].getY()-y;
    if(abs(diffX)<=70 && abs(diffY)<=d/2)
      {
        //println(diffX+","+diffY);
        //rateX=random(-3,3);
        //fill(200,120,50);
        //ellipse(x,y,d,d);
        if(rateY>0)
          y-=50;
        else if(rateY<0)
          y+=50;
        
        rateY*=-1;
        rateX=random(2,5);
        if(abs(joints[KinectPV2.JointType_HandLeft].getX()-joints[KinectPV2.JointType_HandRight].getX())<=100 && abs(joints[KinectPV2.JointType_HandLeft].getY()-joints[KinectPV2.JointType_HandRight].getY())<=100)
        
         {
           play=false;
           x=(joints[KinectPV2.JointType_HandLeft].getX()+joints[KinectPV2.JointType_HandRight].getX())/2;
           y=(joints[KinectPV2.JointType_HandLeft].getY()+joints[KinectPV2.JointType_HandRight].getY())/2;
            
         }
         else
         {
           play=true;
         }
      }
      
      
  
  }
  
  ellipse(0, 0, 25, 25);
  popMatrix();
}

//draw bone
void drawBone(KJoint[] joints, int jointType1, int jointType2) {
  pushMatrix();
  translate(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
  line(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ(), joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
}

//draw hand state
void drawHandState(KJoint joint) {
  noStroke();
  handState(joint.getState());
  pushMatrix();
  translate(joint.getX(), joint.getY(), joint.getZ());
  ellipse(0, 0, 70, 70);
  popMatrix();
}

/*
Different hand state
 KinectPV2.HandState_Open
 KinectPV2.HandState_Closed
 KinectPV2.HandState_Lasso
 KinectPV2.HandState_NotTracked
 */
void handState(int handState) {
  switch(handState) {
  case KinectPV2.HandState_Open:
    fill(0, 255, 0);
    break;
  case KinectPV2.HandState_Closed:
    fill(255, 0, 0);
    break;
  case KinectPV2.HandState_Lasso:
    fill(0, 0, 255);
    break;
  case KinectPV2.HandState_NotTracked:
    fill(255, 255, 255);
    break;
  }
}