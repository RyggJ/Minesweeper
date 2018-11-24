int rows=14,cols=24,w=50,sRow=(rows/2)-1,sCol=(cols/2)-1;
block[][] blocks=new block[cols][rows];
boolean go=false,win=false,moved=false;

void setup(){
  size(1201,701);
  background(180);
  textAlign(CENTER);
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
  select();
  if(go==true){
    gameover();
  }
  if(win==true){
    winner();
  }
  if(keyPressed&&key=='r'){
    reset();
  }
}

void mousePressed(){
  if(!go){
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
}

void reset(){
  for(int i=0;i<cols;i++){
    for(int j=0;j<rows;j++){
      blocks[i][j]=new block(i,j);
    }
  }
  go=false;
  win=false;
}

void select(){
  noFill();
  strokeWeight(5);
  stroke(255,255,0);
  rect(sCol*w,sRow*w,w,w);
  strokeWeight(1);
  if(keyPressed&&(key=='w'||keyCode==UP)&&sRow>0&&!moved){
    sRow--;
    moved=true;
  }
  if(keyPressed&&(key=='a'||keyCode==LEFT)&&sCol>0&&!moved){
    sCol--;
    moved=true;
  }
  if(keyPressed&&(key=='s'||keyCode==DOWN)&&sRow<rows-1&&!moved){
    sRow++;
    moved=true;
  }
  if(keyPressed&&(key=='d'||keyCode==RIGHT)&&sCol<cols-1&&!moved){
    sCol++;
    moved=true;
  }
  if(keyPressed&&key=='f'){
    blocks[sCol][sRow].setFlag(true);
    moved=true;
  }
  if(keyPressed&&key=='c'){
    blocks[sCol][sRow].setFlag(false);
    moved=true;
  }
  if(keyPressed&&key=='e'){
    blocks[sCol][sRow].reveal();
    moved=true;
  }
  if(!keyPressed){
    moved=false;
  }
}

void gameover(){
  textSize(200);
  stroke(0);
  fill(0,100);
  rect(25,250,1150,175);
  fill(255,0,0);
  text("GAME OVER",width/2,height/2+height/12);
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
  textSize(200);
  stroke(0);
  fill(0,100);
  rect(25,250,1150,175);
  fill(0,100,0);
  text("You Win!!!",width/2,height/2+height/12);
}

class block{
  int x,y,posX,posY,around=-1;
  boolean bomb,hit=false,flag=false;
  block(int i,int j){
    if(Math.random()>.85){
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
      fill(109,62,0);
      rect(x,y,w,w);
    }
    if(bomb==true){
      stroke(200,100,0);
      fill(255,150,0);
      ellipse(x+(w/2),y+(w/2),w/2,w/2);
    }
    else{
      textSize(30);
      fill(around*25+125);
      if(around>0){
        text(around,x+(w/2),y+(3*(w/4)));
      }
    }
    if(hit==false){
      stroke(39,142,15);
      fill(57,204,24);
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
              around++;}}}}}
    if(around==0){
      for(int i=posX-1;i<=posX+1;i++){
        if(i>=0&&i<cols){
          for(int j=posY-1;j<=posY+1;j++){
            if(j>=0&&j<rows&&blocks[i][j].getHit()==false){
              blocks[i][j].reveal();}}}}}}}
