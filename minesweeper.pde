int rows=16,cols=24,w=50;
block[][] blocks=new block[cols][rows];
boolean go=false,win=false;

void setup(){
  size(1201,801);
  background(180);
  for(int i=0;i<cols;i++){
    for(int j=0;j<rows;j++){
      blocks[i][j]=new block(i,j);
    }
  }
}

void draw(){
  for(int i=0;i<cols;i++){
    for(int j=0;j<rows;j++){
      blocks[i][j].show();
      if(blocks[i][j].getHit()&&blocks[i][j].getBomb()){
        go=true;
      }
      if(testWin()){
        win=true;
      }
    }
  }
  if(go==true){
    gameover();
  }
  if(win==true){
    winner();
  }
}

void mousePressed(){
  for(int i=0;i<cols;i++){
    for(int j=0;j<rows;j++){
      if(mouseX>blocks[i][j].getX()&&mouseX<blocks[i][j].getX()+w+1){
        if(mouseY>blocks[i][j].getY()&&mouseY<blocks[i][j].getY()+w+1){
          if(mouseButton==LEFT){
            blocks[i][j].reveal();
          }
          else if(blocks[i][j].getFlag()==false&&blocks[i][j].getHit()==false){
            blocks[i][j].setFlag(true);
          }
          else{
            blocks[i][j].setFlag(false);
          }
        }
      }
    }
  }
}

void gameover(){
  noLoop();
  textSize(200);
  stroke(0);
  fill(255,0,0);
  textAlign(CENTER);
  text("GAME OVER",600,400);
}

boolean testWin(){
  for(int i=0;i<cols;i++){
    for(int j=0;j<rows;j++){
      if((blocks[i][j].getBomb()==false&&blocks[i][j].getHit())||blocks[i][j].getBomb()){}
      else{return false;}
    }
  }
  return true;
}

void winner(){
  noLoop();
  textSize(200);
  stroke(0);
  fill(0,100,0);
  textAlign(CENTER);
  text("You Win!!!",600,400);
}

class block{
  int x,y,posX,posY,around=-1;
  boolean bomb,hit=false,flag=false;
  block(int i,int j){
    if(Math.random()>.99){
      bomb=true;
    }
    x=w*i;
    y=w*j;
    posX=i;
    posY=j;
  }
  void show(){
     if(hit==true){
      stroke(0);
      fill(220);
      rect(x,y,w,w);
    }
    if(bomb==true){
      stroke(200,100,0);
      fill(255,150,0);
      ellipse(x+(w/2),y+(w/2),w/2,w/2);
    }
    else{
      textSize(30);
      fill(255,0,0);
      if(around>0){
        text(around,x+(w/3),y+(2*(w/3)));
      }
    }
    if(hit==false){
      stroke(0);
      fill(255);
      rect(x,y,w,w);
    }
    if(flag==true){
      noStroke();
      fill(0,0,100);
      rect(x+(3*w/7),y+(2*w/7),w/18,4*w/7);
      triangle(x+(3*w/7),y+(w/7),x+(5*w/7),y+(2*w/7),x+(3*w/7),y+(3*w/7));
      rect(x+(2.7*w/7),y+(6*w/7),w/7,w/15);
    }
  }
  
  int getX(){
    return x;
  }
  
  int getY(){
    return y;
  }
  
  boolean getBomb(){
    return bomb;
  }
  
  boolean getHit(){
    return hit;
  }
  
  boolean getFlag(){
    return flag;
  }
  
  void setFlag(boolean set){
    flag=set;
  }
  
  void reveal(){
    if(flag==false){
      hit=true;
      check();
    }
  }
  
  void check(){
    around=0;
    for(int i=posX-1;i<=posX+1;i++){
      if(i>=0&&i<cols){
        for(int j=posY-1;j<=posY+1;j++){
          if(j>=0&&j<rows){
            if(blocks[i][j].getBomb()){
              around++;
            }
          }
        }
      }
    }
    if(around==0){
      for(int i=posX-1;i<=posX+1;i++){
        if(i>=0&&i<cols){
          for(int j=posY-1;j<=posY+1;j++){
            if(j>=0&&j<rows&&blocks[i][j].getHit()==false){
              blocks[i][j].reveal();
            }
          }
        }
      }
    }
  }
}
