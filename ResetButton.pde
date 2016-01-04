
class Button {
  PVector cornerPos;
  float h;
  float w; 
  int buttonColor;
  float textColor;
  String buttonName;
  boolean mouseOnMe;

  Button(float x, float y, float _w, float _h, String stuff) {
    w = _w;
    h = _h;
    cornerPos = new PVector(x, y);
    buttonName = stuff;
    buttonColor = 0xFF000066;
  }

  void drawAllButtons() {
    strokeWeight(1);
    rectMode(CORNER);
    fill(buttonColor);
    rect(cornerPos.x, cornerPos.y, w, h);
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(h/5);

    text(buttonName, cornerPos.x+w/2, cornerPos.y + h/2);
  }
  boolean mouseOverMe() {

    return( (cornerPos.x< mouseX && mouseX <cornerPos.x + w && 
      cornerPos.y< mouseY && mouseY< cornerPos.y +h) );
  }
}

