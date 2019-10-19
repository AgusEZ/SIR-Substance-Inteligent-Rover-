

void eng_update(){
  //updating the motor's state.
     for(int i=0;i<4;i++){digitalWrite(eng[i],engp[i]);}
}

// moving the robot.

void forward(){engp[0]=true;engp[1]=false;engp[2]=true;engp[3]=false;}
void back(){engp[0]=false;engp[1]=true;engp[2]=false;engp[3]=true;}
void left(){engp[0]=true;engp[1]=true;engp[2]=true;engp[3]=false;}
void right(){engp[0]=true;engp[1]=false;engp[2]=true;engp[3]=true;}
void rleft(){engp[0]=true;engp[1]=false;engp[2]=false;engp[3]=true;}
void rright(){engp[0]=false;engp[1]=true;engp[2]=true;engp[3]=false;}
void stoop(){engp[0]=true;engp[1]=true;engp[2]=true;engp[3]=true;}
