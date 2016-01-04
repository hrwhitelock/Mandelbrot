double xMin, xMax, yMin, yMax; //the plot bounds 
int plotW, plotH, plotX, plotY; //the plot bitmap position and size
int maxIter; //the maximum number of iterations to use when computing the Mandelbrot set
PImage plotImage;
int bgColor;
double zoomH, zoomW, zoomX, zoomY;
Button reset;
void setup() {
  size(600, 600);

  bgColor = 0xFF222222;

  reset = new Button(10, 10, 40, 40, "Reset");

  xMin = -2.5;
  xMax = 1.5;
  yMin = -2;
  yMax = 2;
  maxIter = 1000;

  plotW = 580;
  plotH = 580;
  plotX = 10;
  plotY = 10;

  plotImage = createImage(plotW, plotH, RGB);
  plotImage.loadPixels(); //makes the pixels available for editing.

  plot();
  refreshScreen();
}

void draw() {
  plot();
  refreshScreen();
  reset.drawAllButtons();
}
void refreshScreen() {
  background(bgColor);
  image(plotImage, plotX, plotY);
}

void plot() {
  //calculate the Mandelbrot set here, setting pixel colors accordingly.
  //c = a+bi
  //z*z+c = X*x-y*y+a +(2xy+b)i
  //...
  double x, y, tempX; //z = x+yi
  double a, b;
  int pixA, pixB;
  int i;
  boolean bounded = true;



  for (pixA=0; pixA<plotW; pixA++) {
    a = bitmapPixToX(pixA);
    for (pixB=0; pixB<plotH; pixB++) {
      b = bitmapPixToY(pixB);
      plotImage.pixels[pixB*plotW+pixA] = #000000;
      //iterate
      x = 0;
      y = 0;
      for (i=0; i<maxIter; i++) {
        //
        tempX = x*x-y*y+a;
        y = 2*x*y+b;
        x = tempX;

        if (x*x+y*y > 4) {
          bounded = false;
          plotImage.pixels[pixB*plotW+pixA] = colorByEscapeTime(i);
          break;
        }
      }
    }
  }




  //update pixels
  plotImage.updatePixels();
}

int colorByEscapeTime(int i) {
  int color0 = 0xFFCCCCCC;
  int color1 = 0xFF000000;
  int numSteps = 16;
  float lerpParam = ((float)(i % numSteps))/(numSteps-1);
  return lerpColor(color1, color0, lerpParam);
}

double bitmapPixToX(double pixX) {
  return xMin + pixX/plotW*(xMax - xMin);
}

double bitmapPixToY(double pixY) {
  return yMax + pixY/plotH*(yMin - yMax);
}

void mousePressed() {
  if (reset.mouseOverMe() == true) {
    xMin = -2.5;
    xMax = 1.5;
    yMin = -2;
    yMax = 2;
  }
  stroke(0, 255, 0);
  zoomX = mouseX;
  zoomY = mouseY;
  zoomW = abs(mouseX-pmouseX);
  zoomH = abs(mouseY-pmouseY);

}
void mouseReleased() {
  //
  xMin = bitmapPixToX(zoomX);
  xMax = bitmapPixToX(zoomX+zoomW);
  yMin = bitmapPixToY(zoomY);
  yMax = bitmapPixToY(zoomY+zoomH);
}

