Ball b;
Player p1; // Left player
Player p2; // Right player

void setup() {
  size(750, 500);
  rectMode(CENTER);
  textAlign(CENTER);
  textSize(30);
  b = new Ball();
  p1 = new Player();
  p2 = new Player();
  b.reset(); // Resets the ball to the center of the screen and randomizes speed
  p1.x = 125; // Both players have static x values
  p2.x = width - (125);
  p1.y = height/2; // Default to being at the center of the screen because why not
  p2.y = height/2;
  p1.speed = 5;
  p2.speed = 5;
  p1.score = 0;
  p2.score = 0;
}

void draw() {
  background(0);
  b.show();
  b.move();
  b.wallCollide();
  b.playerCollide();
  p1.show();
  p2.show();
  p1.move();
  p2.move();
  fill(255);
  text(p1.score, width/4, 50);
  text(p2.score, width*3/4, 50);
  b.score();
}

class Player {
  float x;
  float y;
  float speed;
  char lastKey;
  int score;

  void show() {
    fill(255); 
    stroke(255);
    rect(x, y, 37, 37*5);
  }

  void move() {
    keyPressed();
    if(key == 'w' || key == 's') {
      p1.lastKey = key;
    }
    else if(key == 'i' || key == 'k') {
      p2.lastKey = key;
    }
    
    if((lastKey == 'w' || lastKey == 'i') && y-93.75 > 0) {
      y -= speed;
    }
    else if((lastKey == 's' || lastKey == 'k') && y+93.75 < height) {
      y += speed;
    }
  }
}

class Ball {
  float x;
  float y;
  float xspeed;
  float yspeed;

  void show() {
    fill(255);
    stroke(255);
    rect(x, y, 25, 25);
  }

  void move() {
    x += xspeed;
    y += yspeed;
  }

  void wallCollide() {
    if (y+12.5 > height || y-12.5 < 0) {
      yspeed = -yspeed;
    }
  }

  void playerCollide() {
    if(((x-12.5 < p1.x+75/4) && y+12.5 < p1.y+93.75 && y-12.5 > p1.y-93.75) || (x+12.5 > p2.x-75/4) && y+12.5 < p2.y+93.75 && y-12.5 > p2.y-93.75) {
      xspeed = -xspeed;
    }
  }
  
  void reset() {
    x = width/2;
    y = height/2;
    b.yspeed = random(-5, 5);
    b.xspeed = (round(random(0, 1)) == 0) ? random(-5, -2.5) : random(2.5, 5); // Ensures that the magnitude of the speed is at least 5 but no more than 10, but it can be either direction
    p1.y = height/2;
    p2.y = height/2;
    key = ' ';
  }
  void score() {
    if(x < 0) {
      p2.score++;
      reset();
    }
    else if(x > width) {
      p1.score++;
      reset();
    }
  }
}
