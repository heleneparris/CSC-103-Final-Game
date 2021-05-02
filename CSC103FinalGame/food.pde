class food {

  int x;               //x-pos
  int y;               //y-pos
  int d;               //diameter
  int c;               //color
  int xSpeed;          //x speed of arc
  int ySpeed;          // y speed of arc
  int fallingSpeed;
  int topBound;        //top boundary
  int bottomBound;     //bottom boundary
  int leftBound;       //left boundary
  int rightBound;      //right boundary

  int startTime;       //vars for start time
  int endTime;
  int interval;        //interval for when the arc should happen

  int leftX;           //x-pos
  int leftY;           //y-pos

  int id;              //vars to identify which food object will be hamburger, coin, or bomb

  boolean removeFood;  //boolean to control when to remove a food object

  // constructor for food class
  food(int anId) {
    x=650;
    y=(height/3)*2;
    d=50;
    c=color(255, 0, 0);
    xSpeed=5;
    ySpeed=5;
    fallingSpeed=9;
    topBound= y-(d/2);
    bottomBound= y+(d/2);
    leftBound=x-(d/2);
    rightBound= x+(d/2);
    startTime=millis();
    interval=450;
    removeFood=false;
    leftX=0;
    leftY=(height/3)*2;
    spawnStartTime= millis();
    id=anId;
  }
  // fucnction for drawing the food
  void render() {
    fill(c);
    circle(x, y, d);
    circle(leftX, leftY, d);
  }
  //function for moving the food
  void move() {
    leftX=leftX+xSpeed;
    leftY=leftY-fallingSpeed;
    x=x-xSpeed;
    y=y-fallingSpeed;
  }
  //function for arcing the food
  void arch() {
    endTime=millis();
    if (endTime-startTime>interval) {
      y=y+ySpeed*3;
      leftY=leftY+ySpeed*3;
    }
  }
  // function to reset boundaries when food moves
  void resetBoundaries() {
    topBound=y-(d/2);
    bottomBound=y+(d/2);
    leftBound=x-(d/2);
    rightBound=x+(d/2);
  }
  //fucntion to make food objects spawn faster as time goes on
  void speedUp() {

    if (score<=7) {
      spawnInterval=1300;
    }
    if (score>7 && score<=25) {
      spawnInterval=1200;
    }
    if (score>25 && score<=45) {
      spawnInterval=1100;
    }
    if (score>45 && score<60) {
      spawnInterval=1000;
    }
    if (score>60 && score<75) {
      spawnInterval=900;
    }
     if (score>75 && score<=90) {
      spawnInterval=800;
    }
    if (score>90 && score<=120) {
      spawnInterval=700;
    }
    if (score>120 && score<140) {
      spawnInterval=600;
    }
    if (score>140 && score<160) {
      spawnInterval=500;
    }
  }
}
