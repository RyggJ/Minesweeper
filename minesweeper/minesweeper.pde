int rows=12,cols=12,w=50;
block[][] blocks=new block[cols][rows];

void setup(){
  size(601,601);
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
    }
  }
}

void mousePressed(){
  for(int i=0;i<cols;i++){
    for(int j=0;j<rows;j++){
      if(mouseX>blocks[i][j].getX()&&mouseX<blocks[i][j].getX()+w+1){
        if(mouseY>blocks[i][j].getY()&&mouseY<blocks[i][j].getY()+w+1){
          blocks[i][j].reveal();
        }
      }
    }
  }
}

class block{
  int x,y,posX,posY,around;
  boolean bomb,hit=false;
  block(int i,int j){
    if(Math.random()>.5){
      bomb=true;
    }
    x=w*i;
    y=w*j;
    posX=i;
    posY=j;
    check();
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
      text(around,x+(w/3),y+(2*(w/3)));
    }
    if(hit==false){
      stroke(0);
      fill(255);
      rect(x,y,w,w);
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
  
  void reveal(){
    hit=true;
  }
  
  void check(){
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
  }
}
