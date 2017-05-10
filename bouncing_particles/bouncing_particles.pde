// Bouncing Particles
// @author: Cian Byrne
//
// Some elements of the project were taken from the following source(s):
// https://www.openprocessing.org/sketch/52806
// 

ArrayList<Ball> m_balls = new ArrayList<Ball>();
int frames = 0;

void setup(){
  size(400,400,P3D);
  
}

void draw(){
  // clear the canvas
  background(0);
  
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
  
  // debug
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
   private int HARDNESS = 0;
   private int num_bounces = 0;
   private float DECAY_FACTOR = 0.85;
   // look and feel
   private PImage texture;
   private PShape object;
   
   // CONSTRUCTOR
   public Ball(int xPos, int yPos, int zPos){
     // initally the mouse position
     x = xPos;
     z = zPos;
     y = yPos;
     
     // randomly decide where the ball is going to fly
     acceleration_x = random(-5, 5);
     acceleration_y = random(-5, 5);
     acceleration_z = -(random(5));

     // load a texture for the spheres that are being shot
     texture = loadImage("earth.jpg");
     
     // create the object.
     create();     
   }
   
   public int move(){
     // set to "1" for perfect preservation
     float POWER_PRESERVATION = 1; //(pow(DECAY_FACTOR, num_bounces));
     
     
     // determine the "y" lcoation
     // update the acceleration if necessary
     y += acceleration_y * POWER_PRESERVATION;
     acceleration_y += g;
     
     // it hit the top of the box, automatically send the ball back to the ground (quickly).
     if ( y < 0 + HARDNESS ) {
         
         acceleration_y = -acceleration_y;
     }
     
     // hit the floor, bounce back up but be slightly in-elastic (1.15)
     if ( y > 400 - HARDNESS ) {
         acceleration_y = -acceleration_y / 1.15; 
         num_bounces++;
     }
     
     
     // determine the "x" location
     // if the ball hits a left or right wall, the direction should become
     //  inverted.
     x += acceleration_x * POWER_PRESERVATION;
     
     // right wall is hit
     if ( x < 0 + HARDNESS ) {
       acceleration_x = -acceleration_x;
       num_bounces++;
     }
     
     // left wall is hit
     if ( x > 400 - HARDNESS ) {
       acceleration_x = -acceleration_x;
       num_bounces++;
     }
     
     
     // determine the "z" location
     // if the ball hits the back wall, the direction should become
     //  inverted.  Also, if it goes behind the field of view, it 
     //  should delete itself.
     z += acceleration_z * POWER_PRESERVATION;
     
     // bounce back, back wall is hit
     if ( z < -400 + HARDNESS ) {
       acceleration_z = -acceleration_z;
       num_bounces++;
     }
     
     // delete the ball from the window because it has fallen
     //  out of the box.
     if ( z > 400 - HARDNESS){
        return 0; // failure
     }
     
     // draw the sphere
     pushMatrix();       //save
     translate(x, y, z); //move
     shape(object);      //render
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
  beginShape(QUAD_STRIP);
  
  //left side
  fill(255,0,0); //red
  vertex(0,0,0);
  vertex(0,0,-400);
  vertex(0,400,0);
  vertex(0,400,-400);
  
  //right side
  fill(255,255,0); //yellow
  vertex(400,0,0);
  vertex(400,0,-400);
  vertex(400,400,0);
  vertex(400,400,-400);
  
  //top
  fill(0,255,0); //green
  vertex(0,0,0);
  vertex(0,0,-400);
  vertex(400,0,0);
  vertex(400,0,-400);
  
  //bottom
  fill(0,0,255); //blue
  vertex(0,400,0);
  vertex(0,400,-400);
  vertex(400,400,0);
  vertex(400,400,-400);
  
  //back
  fill(0,255,255); //cyan
  vertex(0,0,-400);
  vertex(400,0,-400);
  vertex(0,400,-400);
  vertex(400,400,-400);
  
  endShape();
  popMatrix();  
}