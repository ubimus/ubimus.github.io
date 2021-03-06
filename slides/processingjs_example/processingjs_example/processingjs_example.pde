interface PNaClCsound {
   void Event(String val);
   void SetChannel(String channelName, float value); 
}

PnaclCsound csound;
int HEIGHT = 520;

void bindCsound(PNaClCsound cs) {
     csound = cs;
}

class TouchPoint {
    int x, y, radius;
    int MAX_RADIUS = 20;
    boolean active; 
    
    void update() {
      if(active && radius < MAX_RADIUS) {
         radius++; 
      } else if(!active && radius > 0) {
         radius--; 
      }
    }
    
    void draw() {
      stroke(#00FF00);      // set the default shape outline colour
      fill(#CCFFCC);        // set the default shape fill colour

      ellipse(x, y, radius, radius);
    }
}

class Preloader {
   String loadingText = "Loading Csound...";
   
   void draw() {
      fill(#ffffff);
      textSize(18);
      text(loadingText, width/2 - textWidth(loadingText)/2, 
          HEIGHT/2 - 9);
   } 
}

TouchPoint t = new TouchPoint();
Preloader p = new Preloader();

void mousePressed() {
   t.active = true; 
   t.x = mouseX;
   t.y = mouseY;
   
   
   if(csound != null) {
      csound.Event("i1 0 -1"); 
      csound.SetChannel("x", mouseX / 800);
      csound.SetChannel("y", 1 - (mouseY / 600));
   }
   
}

void mouseReleased() {
   t.active = false; 
   csound.Event("i-1 0 1"); 

}

void mouseDragged() {
   t.x = mouseX;
   t.y = mouseY;
   
   if(csound != null) {
       csound.SetChannel("x", mouseX / 800);
       csound.SetChannel("y", 1 - (mouseY / HEIGHT));
   }
}

void setup() {
  size(800,HEIGHT);
  
  t.x = 20;
  t.y = 20;
  t.radius = 0;
}

void draw() {
  t.update();
  background(#000000);
  
  if(csound == null) {
     p.draw(); 
  } else {
     t.draw();
  }
  
}
