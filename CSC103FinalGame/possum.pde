class possum {

  int x;                 //x-pos
  int rightX;            //x-pos for right side
  int y;                 //y-pos
  int rightY;            //y-pos for right side
  int d;                 //diameter
  int c;                 //color
  int topBound;          //top boundary
  int bottomBound;       //bottom boundary
  int leftBound;         //left boundary
  int rightBound;        //right boundary
  boolean mouthOpen;     //checks if mouth is open or not
  boolean isTouching;    //boolean for checking if food and possum collide
  boolean isDead;        //boolean checking to see if posums are dead


  //constructor for possum class
  possum() {
    x=125;
    rightX=525;
    y=750;
    rightY=750;
    d=100;
    c=color(0, 0, 255);
    topBound= y+275;
    bottomBound= y+550;
    leftBound=x;
    rightBound= x+275;
    mouthOpen=false;
    isTouching=false;
    isDead=false;
  }
  //function to draw possum
  void render() {
    fill(c);
    circle(x, y, d);
    circle(rightX, rightY, d);
  }
  //function that checks if food objects are colliding with the possum
  void isHit(ArrayList<food> aFoodList) {

    for (food tempFood : aFoodList) {

      if (tempFood.topBound<=bottomBound) {
        if (tempFood.bottomBound>=topBound) {
          if (tempFood.rightBound>=leftBound) {
            if (tempFood.leftBound<=rightBound) {
              nomSound.play();
              tempFood.removeFood=true;
              isTouching=true;
              if (tempFood.id==1) {
                score=score+2;
                if (mouthOpen==false) {
                  isDead=true;
                  switchVal=2;
                }
              }
              if (tempFood.id==3) {
                score=score+1;
                if (mouthOpen==false) {
                  isDead=true;
                  switchVal=2; 
                }
              }
              if (tempFood.id==2) {
                nomSound.stop();
                if (mouthOpen==true) {
                  isDead=true;
                  switchVal=2;
                }
              }
            }
          }
        }
      }
    }
  }
  //updates boundaries of possum
  void resetBoundaries() {
    topBound=y-(d/2);
    bottomBound=y+(d/2);
    leftBound=x-(d/2);
    rightBound=x+(d/2);
  }

  //function that sees if a collision happened 
  void die() {
    if (isTouching==true) {
      if (mouthOpen==false) {
        isDead=true;
      }
    }
  }
}
