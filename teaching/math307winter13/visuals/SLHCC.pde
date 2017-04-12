/* from http://www.math.washington.edu/~gautas/SLHCCjs/SLHCC.pde */

/**
 * SLHCC 1
 *
 * For messing around with second order linear homogeneous DEs with constant coefficients.
 * Gautam Sisodia (gautas (at) uw dot edu)
 * Thanks to Matthew Conroy for most of the code
 **/

float r1, r2, c1, c2; //used in solution method
float a, b, c, y1, y2; //equation coefficients
float yy, yyLast; //solution point
int spos1=600, spos2=500, spos3=600, spos4=600, spos5=600; //current slider positions
int newspos1 = spos1, newspos2 = spos2, newspos3 = spos3, newspos4 = spos4, newspos5 = spos5; //future slider positions

void setup()
{
  size(1000, 560);

   PFont fontA = loadFont("CourierNewPS-BoldMT-48.vlw");
   textFont(fontA, 20);
}

void draw()
{
	yyLast=0;	
  background(255);
 
  //get coefficients from sliders	
  a = 0.01*(spos1-width/2);
  b = 0.01*(spos2-width/2);
  c = 0.01*(spos3-width/2);
  y1 = 0.01*(spos4-width/2);
  y2 = 0.01*(spos5-width/2);  

 
  
  smooth();
  strokeWeight(1);
    
    //draw axes
    stroke(33);
    line(0,height/2-50,width,height/2-50);
    line(width/10.-50,0,width/10.-50,height);
    
    
    //draw solution
    for(int i = 0; i<width; ++i) {
	        
	yy = height/2-50-80*sol(a,b,c,(i-width/10.+50)/20);
	if(yy<0) yy = 0;
	if(yy>height)yy=height;        
        stroke(100);
        strokeWeight(2);
        line(i,(int)yy,i-1,(int)yyLast);
	yyLast=yy;
    }

  
    
   
   // update sliders

	if(mousePressed)
	{
		if(mouseY>height-100 && mouseY<height-90) newspos1 = mouseX-5;
		if(mouseY>height-80 && mouseY<height-70) newspos2 = mouseX-5;
		if(mouseY>height-60 && mouseY<height-50) newspos3 = mouseX-5;
		if(mouseY>height-40 && mouseY<height-30) newspos4 = mouseX-5;
		if(mouseY>height-20 && mouseY<height-10) newspos5 = mouseX-5;
	}
	if(abs(spos1-newspos1)>2) spos1 += (newspos1 - spos1)/10;	
	if(abs(spos2-newspos2)>2) spos2 += (newspos2 - spos2)/10;
	if(abs(spos3-newspos3)>2) spos3 += (newspos3 - spos3)/10;
	if(abs(spos4-newspos4)>2) spos4 += (newspos4 - spos4)/10;
	if(abs(spos5-newspos5)>2) spos5 += (newspos5 - spos5)/10;

   //draw sliders 
  
    fill(240);
    rect(0, height-20, width, 10);
    rect(0, height-40, width, 10);
    rect(0, height-60, width, 10);
    rect(0, height-80, width, 10);
    rect(0, height-100, width, 10);
    fill(0);
    rect(spos1,height-100, 10, 10);
    rect(spos2,height-80, 10, 10);
    rect(spos3,height-60, 10, 10);
	rect(spos4,height-40, 10, 10);
    	rect(spos5,height-20, 10, 10);	

  //write equation
   text(int(a*100)/100.+"y''+"+int(b*100)/100.+"y'+"+int(c*100)/100.+"y=0, y(0)="+int(y1*100)/100.+", y'(0)=" + int(y2*100)/100.,100,height-120);

}
//compute solution
float sol(float a, float b, float c, float t)
{
  if(pow(b, 2) > 4*a*c)
  {
    r1 = (-1*b + sqrt(pow(b,2) - 4*a*c))/(2*a);
    r2 = (-1*b - sqrt(pow(b,2) - 4*a*c))/(2*a);
    c2 = (y2 - r1*y1)/(r2-r1);
    c1 = y1 - c2;
    return c1*exp(r1*t) + c2*exp(r2*t);
  }
  if(pow(b, 2) < 4*a*c)
  {
    r1 = (-1*b)/(2*a);
    r2 = (sqrt(4*a*c-pow(b,2)))/(2*a);
    c1 = y1;
    c2 = (y2-r1*y1)/r2;
    return exp(r1*t)*(c1*cos(r2*t)+c2*sin(r2*t));
  }
  if(pow(b, 2) == 4*a*c)
  {
    r1 = (-1*b)/(2*a);
    c1 = y1;
    c2 = y2 - r1*y1;
    return c1*exp(r1*t) + c2*t*exp(r1*t);
  }
  return 0;
}  


 

