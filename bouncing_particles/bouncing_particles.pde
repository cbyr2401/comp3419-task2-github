// Bouncing Particles
//
//
//
//

ArrayList<Ball> m_balls = new ArrayList<Ball>();
int frames = 0;

void setup(){
  size(400,400,P3D);
  
  background(128);
  
  
}

void draw(){
  // clear the canvas
  background(128);
  
  // draw the cube
  drawCube();
  
  // draw all the balls to the screen
  for ( int i = 0; i < m_balls.size(); i++ ){
     if(m_balls.get(i).move() == 0) 
     {
       m_balls.remove(i); 
     }
     println("moving ball...", i);
  }
  
  // draw mouse pointer
  //fill(255);
  //ellipse(mouseX, mouseY, 5, 5);
  
  //delay(500);
  frames++;
  println("frame: ", frames);
   
  
}

void mouseClicked() {
   // add a new ball to the screen
  Ball temp = new Ball(mouseX, mouseY, 0);
  m_balls.add(temp);
  println("creating ball...");
}


public class Ball {
   // position
   private int x = 0;
   private int y = 0;
   private int z = 0;
   // motion
   private float acceleration_y = 0;
   private float acceleration_x = 0;
   private float acceleration_z = -5;
   private float g = 0.15;
   // look and feel
   private PImage texture;
   private float GRAVITY = 9.81;
   private PShape object;
   
   
   public Ball(int xPos, int yPos, int zPos){
     // initally the mouse position
     x = xPos;
     z = zPos;
     y = yPos;
     
     texture = loadImage("earth.jpg");
     
     create();
     
   }
   
   public int move(){
     // determine the "y" location
     y += acceleration_y;
     
     // update the acceleration if necessary
     acceleration_y += g;
     
     // check if we have hit the bottom
     if ( y > 400 )
     {
         acceleration_y = -acceleration_y/1.15;
     }
     
     // determine the "x" location
     // if the ball hits a left or right wall, the direction should become
     //  inverted.
     x += acceleration_x;
     
     // determine the "z" location
     // if the ball hits the back wall, the direction should become
     //  inverted.  Also, if it goes behind the field of view, it 
     //  should delete itself.
     z += acceleration_z;
     
     if ( z < -400 ) {
       // bounce back
       acceleration_z = -acceleration_z;
     }
     
     if ( z > 400 )
     {
        return 0; // failure
     }
     
     // draw the sphere
     pushMatrix();       //save
     translate(x, y, z); //move
     
     shape(object);           //render
     popMatrix();        //move
          
     // success
     return 1;
     
   }
   
   public void create(){
      object = createShape(SPHERE, 15);
      object.setTexture(texture);  //TODO:  Add a texture generator
      object.setStroke(false);
   }
  
}



void drawCube(){
  
  pushMatrix();
  
  noStroke();
  
  //left side
  beginShape(QUAD_STRIP);
  fill(255,0,0); //red
  vertex(0,0,0);
  vertex(0,0,-400);
  vertex(0,400,0);
  vertex(0,400,-400);
  //endShape();
  
  //right side
  //beginShape(LINES);
  fill(255,255,0); //yellow
  vertex(400,0,0);
  vertex(400,0,-400);
  vertex(400,400,0);
  vertex(400,400,-400);
  //endShape();
  
  //top
  //beginShape(LINES);
  fill(0,255,0); //green
  vertex(0,0,0);
  vertex(0,0,-400);
  vertex(400,0,0);
  vertex(400,0,-400);
  //endShape();
  
  //bottom
  //beginShape(LINES);
  fill(0,0,255); //blue
  vertex(0,400,0);
  vertex(0,400,-400);
  vertex(400,400,0);
  vertex(400,400,-400);
  //endShape();
  
  //back
  //beginShape(LINES);
  fill(0,255,255); //cyan
  vertex(0,0,-400);
  vertex(400,0,-400);
  vertex(0,400,-400);
  vertex(400,400,-400);
  endShape();
  
  
  popMatrix();  
}