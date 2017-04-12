/**
 * Complex exponential demonstration
 *
 *  Graphs real and imaginary parts of exp[(a+bi)t] and lets the user play around with a,b
 * 
 * history: adapted from SLHCC.js, by Gautam Sisodia (gautas (at) uw dot edu), who says, "Thanks to Matthew Conroy for most of the code." Thanks, Dr. Conroy!
 **/

float r1, r2, c1, c2; //used in solution method
float lambda, mu; //equation coefficients
float yy, yyLast; //solution point
int sposL=250, sposM=750; //current slider positions
int newsposL = sposL, newsposM = sposM; //future slider positions
float lambdaMin=-0.5, lambdaMax=+0.5;
float muMin=-5.0, muMax=5.0;
float xmin=-1, xmax=5;
float ymin=-5, ymax=5;
int sliderW=20,sliderH=16; //slider width/height
int sliderBarH=24;
boolean imPart;		// true for imaginary part, false for real part.
int riToggleDistance=110;	// distance from top of real/imaginary toggle button to bottom edge of canvas
int riBoxWidth=170, riBoxHeight=30;  // width&height of individual button
int riBoxLeft=80;		// x position of left edge of toggle button
int riTextLMargin=20, riTextTMargin=18; // left and top margins of the text for real/imaginary buttons.

void setup()
{
  size(1000, 560);

  PFont fontA = loadFont("CharterBT-Bold-24.vlw");
  textFont(fontA, 20);
}

void draw()
{
  	
  background(255);
 

   // update sliders

	if(mousePressed)
	{
/*		if(mouseY>height-100 && mouseY<height-90) newsposL = mouseX-5;*/
/*		if(mouseY>height-80 && mouseY<height-70) newsposM = mouseX-5;*/
		if(mouseY>height-60-sliderBarH/2 && mouseY<height-60+sliderBarH/2) newsposL = mouseX;
/*		if(mouseY>height-40 && mouseY<height-30) newsposL = mouseX-5;*/
		if(mouseY>height-20-sliderBarH/2 && mouseY<height+sliderBarH/2) newsposM = mouseX;

		if (mouseY>height-riToggleDistance && mouseY<height-riToggleDistance+riBoxHeight) {
			if (mouseX >= riBoxLeft && mouseX < riBoxLeft+riBoxWidth)
				imPart = false;
			else if (mouseX >= riBoxLeft+riBoxWidth && mouseX < riBoxLeft+(riBoxWidth*2))
				imPart = true;
		}
	}
	if(abs(sposL-newsposL)>2) sposL += (newsposL - sposL)/10;	
	if(abs(sposM-newsposM)>2) sposM += (newsposM - sposM)/10;

  //get coefficients from sliders	
  lambda = (sposL*1./width)*(lambdaMax-lambdaMin)+lambdaMin;
  mu = (sposM*1./width)*(muMax-muMin)+muMin;
 
  
  smooth();
  strokeWeight(1);
    
    //draw axes
    stroke(33);
    line(0,height/2-50,width,height/2-50);
    line(width/10.-50,0,width/10.-50,height);
    
    
    //draw solution
    yyLast=0;
    for(int i = 0; i<width; ++i) { 
	if (imPart)
		yy = ImFun(lambda, mu, (i-width/10.+50)/20);
	else
		yy = ReFun(lambda, mu, (i-width/10.+50)/20);

	yy = height/2-50-80*yy;
	if(yy<0) yy = 0;
	if(yy>height)yy=height;        
        stroke(100);
        strokeWeight(2);
        line(i,(int)yy,i-1,(int)yyLast);
	yyLast=yy;
    }



   //draw sliders 
  
    fill(240);
    rect(0, height-20-sliderBarH/2, width, sliderBarH);
/*    rect(0, height-40, width, 10);*/
    rect(0, height-60-sliderBarH/2, width, sliderBarH);
/*    rect(0, height-80, width, 10);
    rect(0, height-100, width, 10);*/
    fill(0);
/*    rect(spos1,height-100, 10, 10);*/
/*    rect(spos2,height-80, 10, 10);*/
    rect(sposL-sliderW/2,height-60-sliderH/2, sliderW, sliderH);
/*	rect(sposL,height-40, 10, 10);*/
    	rect(sposM-sliderW/2,height-20-sliderH/2, sliderW, sliderH);	

   fill(192);
   if (imPart) {
     rect(riBoxLeft+riBoxWidth, height-riToggleDistance, riBoxWidth, riBoxHeight);
   } else {
     rect(riBoxLeft, height-riToggleDistance, riBoxWidth, riBoxHeight);
   }

  fill(0);
  //write real/imaginary toggle
   text("Real Part", riBoxLeft+riTextLMargin, height - riToggleDistance + riTextTMargin);
   text("Imaginary Part", riBoxLeft+riBoxWidth+riTextLMargin, height - riToggleDistance + riTextTMargin);

  //write equation
   if (imPart) {
      text("y(t) = Im e^[("+int(lambda*100)/100.+"+"+int(mu*100)/100.+"i)t]",100,height-120);
   } else {
      text("y(t) = Re e^[("+int(lambda*100)/100.+"+"+int(mu*100)/100.+"i)t]",100,height-120);
   }
}

// real part of complex exponential function
float ReFun(float lambda, float mu, float t)
{
  return exp(lambda*t)*cos(mu*t);
}  

// imaginary part of complex exponential function
float ImFun(float lambda, float mu, float t)
{
  return exp(lambda*t)*sin(mu*t);
}  


