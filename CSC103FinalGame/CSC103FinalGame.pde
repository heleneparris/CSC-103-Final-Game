possum p1;                                  //initial left possum
possum p2;                                  //initial right possum
ArrayList<food>foodList;                    // list for spawning food
ArrayList<food>leftFoodList;                // list for spawning food from left side

Animation possumanimation;                  //animation object for possum
PImage[] possumImages= new PImage[6];       //array for the left side possums

Animation foodanimation;                    //animation object for food
PImage[] foodImages= new PImage[4];         //array for foood

Animation bombanimation;                    //animation object for bomb
PImage[] bombImages= new PImage[4];         //array for bomb

Animation coinanimation;                    //animation object for coin
PImage[] coinImages= new PImage[4];         //array for coin

PImage  backgroundImage;  
PImage startScreenImage;
//time vars to know when to spawn
int spawnEndTime;    
int spawnStartTime;
int spawnInterval;
int leftSpawnInterval;

int switchVal;

int score;

import processing.sound.*;
SoundFile nomSound;
SoundFile backgroundMusic;
SoundFile deadMusic;

void setup() {
  size(650, 785);
  imageMode(CENTER);
  backgroundImage=loadImage("backgroundImage.png");
  startScreenImage=loadImage("startscreen.png");

  nomSound= new SoundFile(this, "nomSound.wav");
  backgroundMusic= new SoundFile(this, "backgroundMusic.wav");
  deadMusic= new SoundFile(this, "deadMusic.wav");

  spawnInterval=3000;

  spawnStartTime=millis();

  p1= new possum();                                          // initial left possum
  p2= new possum();                                          //initial right possum 

  foodList= new ArrayList<food>();                           // food list
  leftFoodList= new ArrayList<food>();                       // food list

  //  //filling arrays for possum images
  for (int i=0; i<possumImages.length; i++) {
    possumImages[i]= loadImage("possumanimation"+i+".png");
    possumImages[i].resize(275, 275);
  }
  for (int i=0; i<foodImages.length; i++) {
    foodImages[i]= loadImage("foodanimation"+i+".png");
    //initializing food object
    foodanimation= new Animation(foodImages, 4, 3);
  }
  for (int i=0; i<bombImages.length; i++) {
    bombImages[i]= loadImage("bombanimation"+i+".png");
    //initializing bomb object
    bombanimation= new Animation(bombImages, 4, 3);
  }
  for (int i=0; i<coinImages.length; i++) {
    coinImages[i]= loadImage("coinanimation"+i+".png");
    //initializing coin object
    coinanimation= new Animation(coinImages, 4, 2);
  }
}

void draw() {
  //start screen
  switch(switchVal) {
  case 0:
    background(color(255, 255, 255));
    image(startScreenImage, 315, 391);
    textSize(32);
    fill(0, 0, 0);
    text("Press 'r' to start!", 350, 450);
    textSize(24);
    text("Rule #1: eat hamburgers", 325, 525);
    text("Rule #2: don't eat bombs", 300, 575);
    textSize(28);
    text("control possums with the 's' and 'l' keys", 50, 100);
    break;

  case 1:
    // GAME:
    background(155, 155, 155);
    image(backgroundImage, 200, 393);
    spawnFood();                                           //function to spawn food
    p1.isHit(foodList);                                    // function that checks if the possum is hit by a food
    p1.resetBoundaries();                                  //updates boundaries
    p1.die();                                              //maybe use to do and action once possum dies
    p2.isHit(leftFoodList);                                // function that checks if the possum is hit by a food
    p2.resetBoundaries();                                  //updates boundaries
    p2.die();                                              //maybe use to do and action once possum dies
    foodanimation.isAnimating=true;
    bombanimation.isAnimating=true;
    coinanimation.isAnimating=true;
    
    if (!backgroundMusic.isPlaying()) {
      backgroundMusic.play();
 }
    for (int i=foodList.size()-1; i>=0; i--) {              //removes food when there is a collision
      if (foodList.get(i).removeFood == true) {
        foodList.remove(i);
      }
    }
    for (int i=leftFoodList.size()-1; i>=0; i--) {          //removes food after collision for left side
      if (leftFoodList.get(i).removeFood == true) {
        leftFoodList.remove(i);
      }
    }
    for (food aFood : foodList) {                                //for loop that renders the functions to move each food object
      aFood.speedUp();
      aFood.move();
      aFood.arch();
      aFood.resetBoundaries();
      if (aFood.id == 3) {
        foodanimation.display(aFood.x, aFood.y);                 //display food animation
      } else if (aFood.id == 2) {
        bombanimation.display(aFood.x, aFood.y);                 //display food animation
      } else {
        coinanimation.display(aFood.x, aFood.y);
      }
    }

    for (food aFood : leftFoodList) {                            //for loop that renders the functions to move each food object
      aFood.move();
      aFood.arch();
      aFood.resetBoundaries();
      if (aFood.id == 3) {
        foodanimation.display(aFood.leftX, aFood.leftY);         //display food animation
      } else if (aFood.id == 2) {
        bombanimation.display(aFood.leftX, aFood.leftY);         //display food animation
      } else {
        coinanimation.display(aFood.leftX, aFood.leftY);
      }
    }

    //if statement to check left side possum and open its mouth
    if (p1.mouthOpen==true) {
      image(possumImages[1], 125, 675);
    }

    if (p1.mouthOpen==false) {
      image(possumImages[0], 125, 675);
    }

    if (p2.mouthOpen==true) {
      image(possumImages[3], 525, 675);
    }  

    if (p2.mouthOpen==false) {
      image(possumImages[2], 525, 675);
    }

    // changes touhcing booleans back to false after every frame
    p1.isTouching=false;
    p2.isTouching=false;
    textSize(100);
    text(score, 275, 200);
    break;

  case 2:
  //dead screen
    background(color(0, 0, 0));
    backgroundMusic.stop();
    nomSound.stop();
    if (!deadMusic.isPlaying()) {
      deadMusic.play();
    }
    image(backgroundImage, 200, 393);
    image(possumImages[4], 535, 800);
    image(possumImages[5], 125, 800);
    textSize(68);
    text("You Died :(", 175, 300);
    textSize(58);
    text(score, 300, 400);
    break;
  }
}








void keyPressed() {
  //if statements to check if mouth is 'open' and food can pass through

  if (key=='s') {
    p1.c=color(200, 250, 15);
    p1.mouthOpen=true;
  }

  if (key=='l') {
    p2.c=color(200, 250, 15);
    p2.mouthOpen=true;
  }
  if (key=='r') {
    if (switchVal==0) {
      switchVal=1;
    }
  }
}



void keyReleased() {
  // if statements to make the mouth close if the key is released

  if (key=='s') {
    p1.c=color(0, 0, 255);
    p1.mouthOpen=false;
  }

  if (key=='l') {
    p2.c=color(0, 0, 255);
    p2.mouthOpen=false;
  }
}

void spawnFood() {                                             //function to spawn new food at certain time intervals
  int rN= int(random(0, 100));                                 //random number for right food list
  int lrN= int(random(0, 100));                                //random number for left food list
  int rId;
  int lId;
  if (rN<=15) {
    rId=1; //golden coin animation
  } else if (rN>10 &&rN<=40) {
    rId=2; //bomb animation
  } else { 
    rId=3; //hamburger animation
  }
  ////////////////////second set of if statements so that each food list is not spawning the same type of food //////////////////////////////////////
  if (lrN<=15) {
    lId=1; //golden coin
  } else if (rN>15 &&rN<=55) {
    lId=2; //bomb
  } else {
    lId=3 ;   //normal hamburger
  }
// timer for when food will spawn
  spawnEndTime=millis();
  if (spawnEndTime-spawnStartTime> spawnInterval) {
    if (foodList.size()<=100) {
      foodList.add(new food(rId));
    }
    if (leftFoodList.size()<=100) {
      leftFoodList.add(new food(lId));
    }
    spawnStartTime=millis();
  }
}
