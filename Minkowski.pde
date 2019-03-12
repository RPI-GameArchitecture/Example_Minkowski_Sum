PImage img1;
PImage img2;
PVector imgPos1;
PVector imgPos2;

void setup()
{
    img1=loadImage("circle.png");
    img2=loadImage("circle.png");
  
    imgPos1=new PVector(-100,-100,0);
    imgPos2=new PVector(0,0);
    
    size(800,600);
}

void drawMinkowskiSum()
{
  int x1,y1,x2,y2;
  
  for (y1=0;y1<img1.height;y1++)
  {
    for (x1=0;x1<img1.width;x1++)
    {
      color c1=img1.get(x1,y1);
      if (alpha(c1)>0)
      {
        for (y2=0;y2<img2.height;y2++)
        {
          for (x2=0;x2<img2.width;x2++)
          {
            color c2=img2.get(x2,y2);
            if (alpha(c2)>0)
            {
               // both pixels are opaque, add them together and draw the result
               float x_sum = x1+imgPos1.x + x2 + imgPos2.x;
               float y_sum = y1+imgPos1.y + y2 + imgPos2.y;
               
               set(int (x_sum) + width/2,int (y_sum) + height/2,color(0));
            }
          }
        }
      }
    }
  }
}

void draw()
{
    background(220);
    pushMatrix();
    translate(width/2, height/2);
    line (-width/2,0,width/2,0);
    line (0,-height/2,0,height/2);
    
    if (mousePressed && mouseButton==LEFT)
    {
    imgPos1.x = mouseX-(width/2);
    imgPos1.y = mouseY-(height/2);
    }
    if (mousePressed && mouseButton==RIGHT)
    {
    imgPos2.x = mouseX-(width/2);
    imgPos2.y = mouseY-(height/2);
    }
    pushMatrix();
    translate(imgPos1.x, imgPos1.y);
    translate(-img1.width/2,-img1.height/2);
    image(img1,0,0);
    popMatrix();
    
    pushMatrix();
    translate(imgPos2.x, imgPos2.y);
    translate(-img2.width/2,-img2.height/2);
    image(img2,0,0);
    popMatrix();

    drawMinkowskiSum();
    

    popMatrix();
}
