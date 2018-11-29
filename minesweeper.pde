int rows=14, cols=24, w=50, sRow=(rows/2)-1, sCol=(cols/2)-1,timer;
double difficulty=.85;
block[][] blocks=new block[cols][rows];
menu title;
boolean go=false, win=false, moved=false, konami=false, menuScreen=true;
PImage okay;

void setup() {
  size(1201, 701);
  background(57,204,24);
  textAlign(CENTER);
  okay=loadImage("okay.png");
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      blocks[i][j]=new block(i, j);
    }
  }
  spots=new NormalParticle[500];
  for (int i=0; i<500; i++) {
    spots[i]=new NormalParticle();
  }
  title=new menu();
}


void draw() {
  if (menuScreen) {
    title.show();
    title.check();
  } else if (!konami||!win) {
    for (int i=0; i<cols; i++) {
      for (int j=0; j<rows; j++) {
        blocks[i][j].show();
        if (blocks[i][j].getHit()&&blocks[i][j].getBomb()) {
          go=true;
        }
        if (testWin()) {
          win=true;
        }
      }
    }
    select();
    konamiCheck();
    if (konami) {
      noCursor();
      image(okay, mouseX-20, mouseY-20);
    }
    if (go) {
      gameover();
    }
    if (win) {
      winner();
    }
    if (keyPressed&&key=='r') {
      reset();
    }
  } else {
    frameRate(30);
    for (int i=0; i<500; i++) {
      spots[i].move();
      spots[i].show();
    }
    fill(0, 0, 0, 80);
    stroke(0);
    rect(0, 0, width, height);
  }
  if(keyPressed&&key=='p'){
    menuScreen=true;
  }
}

class menu {
  int selX, selY;
  menu() {
  }

  void show() {
    textSize(100);
    fill(109,62,0);
    text("MINESWEEPER",width/2,200);
    //---------------
    noFill();
    stroke(109,62,0);
    strokeWeight(3);
    rect(300,400,200,100);
    fill(106,62,0);
    strokeWeight(1);
    textSize(50);
    text("Play",400,470);
    //-----------------
    noFill();
    stroke(109,62,0);
    strokeWeight(3);
    rect(700,400,200,100);
    fill(106,62,0);
    strokeWeight(1);
    textSize(50);
    text("Medium",800,470);
    if(difficulty==.85){
      noStroke();
      fill(0, 0, 100);
      rect(700+(3*w/7)+200, 400+(2*w/7)+25, w/18, 4*w/7);
      triangle(700+(3*w/7)+200, 400+(w/7)+25, 700+(5*w/7)+200, 400+(2*w/7)+25, 700+(3*w/7)+200, 400+(3*w/7)+25);
      rect(700+(2.7*w/7)+200, 400+(6*w/7)+25, w/7, w/15);
    }
    else{
      noStroke();
      fill(57,204,24);
      rect(910,550,100,100);
    }
    //---------------------
    noFill();
    stroke(109,62,0);
    strokeWeight(3);
    rect(700,250,200,100);
    fill(106,62,0);
    strokeWeight(1);
    textSize(50);
    text("Easy",800,320);
    if(difficulty==.95){
      noStroke();
      fill(0, 0, 100);
      rect(700+(3*w/7)+200, 250+(2*w/7)+25, w/18, 4*w/7);
      triangle(700+(3*w/7)+200, 250+(w/7)+25, 700+(5*w/7)+200, 250+(2*w/7)+25, 700+(3*w/7)+200, 250+(3*w/7)+25);
      rect(700+(2.7*w/7)+200, 250+(6*w/7)+25, w/7, w/15);
    }
    else{
      noStroke();
      fill(57,204,24);
      rect(910,250,100,100);
    }
    //--------------------
    noFill();
    stroke(109,62,0);
    strokeWeight(3);
    rect(700,550,200,100);
    fill(106,62,0);
    strokeWeight(1);
    textSize(50);
    text("Hard",800,620);
    if(difficulty==.75){
      noStroke();
      fill(0, 0, 100);
      rect(700+(3*w/7)+200, 550+(2*w/7)+25, w/18, 4*w/7);
      triangle(700+(3*w/7)+200, 550+(w/7)+25, 700+(5*w/7)+200, 550+(2*w/7)+25, 700+(3*w/7)+200, 550+(3*w/7)+25);
      rect(700+(2.7*w/7)+200, 550+(6*w/7)+25, w/7, w/15);
    }
    else{
      noStroke();
      fill(57,204,24);
      rect(910,550,100,100);
    }
  }

  void check() {
    if(selX<500&&selX>300&&selY<500&&selY>400){
      menuScreen=false;
      selX=0;
      selY=0;
    }
     if(selX<900&&selX>700&&selY<500&&selY>400){
       difficulty=.85;
    }
     if(selX<900&&selX>700&&selY<350&&selY>250){
      difficulty=.95;
    }
    if(selX<900&&selX>700&&selY<650&&selY>550){
      difficulty=.75;
    }
    
  }

  void setselX(int i) {
    selX=i;
  }

  void setselY(int i) {
    selY=i;
  }
}

void mousePressed() {
  if (menuScreen) {
    title.setselX(mouseX);
    title.setselY(mouseY);
  }
  else if (!go&&!win) {
    for (int i=0; i<cols; i++) {
      for (int j=0; j<rows; j++) {
        if (mouseX>blocks[i][j].getX()&&mouseX<blocks[i][j].getX()+w+1) {
          if (mouseY>blocks[i][j].getY()&&mouseY<blocks[i][j].getY()+w+1) {
            if (mouseButton==LEFT) {
              blocks[i][j].reveal();
            } else if (blocks[i][j].getFlag()==false&&blocks[i][j].getHit()==false) {
              blocks[i][j].setFlag(true);
            } else {
              blocks[i][j].setFlag(false);
            }
          }
        }
      }
    }
  }
}

void reset() {
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      blocks[i][j]=new block(i, j);
    }
  }
  go=false;
  win=false;
}

void select() {
  noFill();
  strokeWeight(5);
  stroke(255, 255, 0);
  rect(sCol*w, sRow*w, w, w);
  strokeWeight(1);
  if (!go) {
    if (keyPressed&&(key=='w'||keyCode==UP)&&sRow>0&&(!moved||(timer>25&&timer%2==0))) {
      sRow--;
      moved=true;
    }
    if (keyPressed&&(key=='a'||keyCode==LEFT)&&sCol>0&&(!moved||(timer>25&&timer%2==0))) {
      sCol--;
      moved=true;
    }
    if (keyPressed&&(key=='s'||keyCode==DOWN)&&sRow<rows-1&&(!moved||(timer>25&&timer%2==0))) {
      sRow++;
      moved=true;
    }
    if (keyPressed&&(key=='d'||keyCode==RIGHT)&&sCol<cols-1&&(!moved||(timer>25&&timer%2==0))) {
      sCol++;
      moved=true;
    }
    if (keyPressed&&key=='f') {
      blocks[sCol][sRow].setFlag(true);
      moved=true;
    }
    if (keyPressed&&key=='c') {
      blocks[sCol][sRow].setFlag(false);
      moved=true;
    }
    if (keyPressed&&key=='e') {
      blocks[sCol][sRow].reveal();
      moved=true;
    }
    if (!keyPressed) {
      moved=false;
      timer=0;
    } else {
      timer++;
    }
  }
}

void gameover() {
  textSize(200);
  stroke(0);
  fill(0, 100);
  rect(25, 250, 1150, 175);
  fill(255, 0, 0);
  text("GAME OVER", width/2, height/2+height/12);
}

boolean testWin() {
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      if ((blocks[i][j].getBomb()==false&&blocks[i][j].getHit())||blocks[i][j].getBomb()) {
      } else {
        return false;
      }
    }
  }
  return true;
}

void winner() {
  textSize(200);
  stroke(0);
  fill(0, 200);
  rect(25, 250, 1150, 175);
  fill(0, 100, 0);
  text("You Win!!!", width/2, height/2+height/12);
}

class block {
  int x, y, posX, posY, around=-1;
  boolean bomb, hit=false, flag=false;
  block(int i, int j) {
    if (Math.random()>difficulty) {
      bomb=true;
    }
    x=w*i;
    y=w*j;
    posX=i;
    posY=j;
  }
  void show() {
    if (hit==true) {
      stroke(0);
      fill(109, 62, 0);
      rect(x, y, w, w);
    }
    if (bomb==true) {
      stroke(200, 100, 0);
      fill(255, 150, 0);
      ellipse(x+(w/2), y+(w/2), w/2, w/2);
    } else {
      textSize(30);
      fill(around*25+125);
      if (around>0) {
        text(around, x+(w/2), y+(3*(w/4)));
      }
    }
    if (hit==false) {
      stroke(39, 142, 15);
      fill(57, 204, 24);
      rect(x, y, w, w);
    }
    if (flag==true) {
      noStroke();
      fill(0, 0, 100);
      rect(x+(3*w/7), y+(2*w/7), w/18, 4*w/7);
      triangle(x+(3*w/7), y+(w/7), x+(5*w/7), y+(2*w/7), x+(3*w/7), y+(3*w/7));
      rect(x+(2.7*w/7), y+(6*w/7), w/7, w/15);
    }
  }

  int getX() {
    return x;
  }

  int getY() {
    return y;
  }

  boolean getBomb() {
    return bomb;
  }

  boolean getHit() {
    return hit;
  }

  boolean getFlag() {
    return flag;
  }

  void setFlag(boolean set) {
    if (getHit()==false) {
      flag=set;
    }
  }

  void reveal() {
    if (flag==false) {
      hit=true;
      check();
    }
  }

  void check() {
    around=0;
    for (int i=posX-1; i<=posX+1; i++) {
      if (i>=0&&i<cols) {
        for (int j=posY-1; j<=posY+1; j++) {
          if (j>=0&&j<rows) {
            if (blocks[i][j].getBomb()) {
              around++;
            }
          }
        }
      }
    }
    if (around==0) {
      for (int i=posX-1; i<=posX+1; i++) {
        if (i>=0&&i<cols) {
          for (int j=posY-1; j<=posY+1; j++) {
            if (j>=0&&j<rows&&blocks[i][j].getHit()==false) {
              blocks[i][j].reveal();
            }
          }
        }
      }
    }
  }
}

//-----------------------------------------------------------------------------------

boolean upOne=false, upTwo=false, downOne=false, downTwo=false, leftOne=false, rightOne=false, leftTwo=false, rightTwo=false, b=false, a=false, start=false;
boolean sOne=false, sTwo=false, sThree=false, sFour=false, sFive=false, sSix=false, sSeven=false, sEight=false, sNine=false, sTen=false;
boolean changed=false;
void konamiCheck() {
  if (!konami) {
    if (keyCode==UP&&!upOne) {
      upOne=true;
      changed=true;
    }
    if (upOne&&!keyPressed) {
      sOne=true;
      changed=false;
    }
    if (keyPressed&&keyCode==UP&&sOne) {
      upTwo=true;
      changed=true;
    }
    if (upTwo&&!keyPressed) {
      sTwo=true;
      changed=false;
    }
    if (keyPressed&&keyCode==DOWN&&sTwo) {
      downOne=true;
      changed=true;
    }
    if (downOne&&!keyPressed) {
      sThree=true;
      changed=false;
    }
    if (keyPressed&&keyCode==DOWN&&sThree) {
      downTwo=true;
      changed=true;
    }
    if (downTwo&&!keyPressed) {
      sFour=true;
      changed=false;
    }
    if (keyPressed&&keyCode==LEFT&&sFour) {
      leftOne=true;
      changed=true;
    }
    if (leftOne&&!keyPressed) {
      sFive=true;
      changed=false;
    }
    if (keyPressed&&keyCode==RIGHT&&sFive) {
      rightOne=true;
      changed=true;
    }
    if (rightOne&&!keyPressed) {
      sSix=true;
      changed=false;
    }
    if (keyPressed&&keyCode==LEFT&&sSix) {
      leftTwo=true;
      changed=true;
    }
    if (leftTwo&&!keyPressed) {
      sSeven=true;
      changed=false;
    }
    if (keyPressed&&keyCode==RIGHT&&sSeven) {
      rightTwo=true;
      changed=true;
    }
    if (rightTwo&&!keyPressed) {
      sEight=true;
      changed=false;
    }
    if (keyPressed&&key=='b'&&sEight) {
      b=true;
      changed=true;
    }
    if (b&&!keyPressed) {
      sNine=true;
      changed=false;
    }
    if (keyPressed&&key=='a'&&sNine) {
      a=true;
      changed=true;
    }
    if (a&&!keyPressed) {
      sTen=true;
      changed=false;
    }
    if (keyCode==SHIFT&&sTen) {
      konami=true;
    }
    if (keyPressed&&!changed) {
      upOne=false;
      upTwo=false;
      downOne=false;
      downTwo=false; 
      leftOne=false;
      rightOne=false;
      leftTwo=false; 
      rightTwo=false;
      b=false; 
      a=false;
      start=false;
      sOne=false;
      sTwo=false;
      sThree=false;
      sFour=false;
      sFive=false;
      sSix=false;
      sSeven=false;
      sEight=false;
      sNine=false;
      sTen=false;
    }
  }
}
//-----------------------------------------------------------
NormalParticle[] spots;
double cAngle;
double centerx=350, centery=150;

class NormalParticle {
  double x, y, angle=Math.random()*PI*2, speed=Math.random()*8;
  int r=(int)(255-(speed*30)), g=(int)(255-(speed*20)), b=(int)(255-(speed*10));
  //int r=(int)(Math.random()*200)+50,g=(int)(Math.random()*200)+50,b=(int)(Math.random()*200)+50;
  public void move() {
    x+=(speed*cos((float)angle));
    y+=(speed*sin((float)angle));
    if (direct()==true) {
      angle+=.05;
    } else {
      angle-=.05;
    }
  }
  public void show() {
    image(okay, mouseX+(int)x, mouseY+(int)y);
  }
  boolean direct() {
    if (speed>2) {
      if (speed>4) {
        if (speed>6) {
          return false;
        }
        return true;
      }
      return false;
    }
    return true;
  }
}
