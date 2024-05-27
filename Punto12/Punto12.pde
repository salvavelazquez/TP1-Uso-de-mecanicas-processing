PImage tankImg, playerImg, fireballImg;
Tank tank;
Player player;
ArrayList<Fireball> fireballs;
int tiempoDeEspera = 1000; // Tiempo de espera entre disparos (en milisegundos)
int ultimoTimeDisparo = 0; // Último tiempo en que se disparó una bola de fuego
float attackDistance = 200; // Distancia de ataque

void setup() {
  size(800, 600);
  
  tankImg = loadImage("tank.png");
  playerImg = loadImage("player.png");
  fireballImg = loadImage("fireball.png");
  
  tankImg.resize(70, 70); 
  playerImg.resize(150, 80); 
  fireballImg.resize(30, 30); 
  
  tank = new Tank(400, 250, tankImg);
  player = new Player(700, 300, playerImg);
  fireballs = new ArrayList<Fireball>();
}

void draw() {
  background(#4D0571);
  tank.display();
  player.display();
  tank.detect(player);
  
  for (int i = fireballs.size() - 1; i >= 0; i--) {
    Fireball fb = fireballs.get(i);
    fb.move();
    fb.display();
    if (fb.offScreen()) {
      fireballs.remove(i);
    }
  }
}

void mouseMoved() {
  player.move(mouseX, mouseY);
}

class GameObject {
  float posX, posY;
  PImage img;
  
  GameObject(float x, float y, PImage img) {
    posX = x;
    posY = y;
    this.img = img;
  }
  
  void display() {
    image(img, posX, posY);
  }
}

class Tank extends GameObject {
  float angle;
  
  Tank(float x, float y, PImage img) {
    super(x, y, img);
    angle = 0;
  }
  
  void detect(Player player) {
    PVector toPlayer = new PVector(player.posX - posX, player.posY - posY);
    if (toPlayer.mag() < attackDistance) {
      angle = atan2(toPlayer.y, toPlayer.x);
      attack(toPlayer);
    }
  }
  
  void attack(PVector directionToPlayer) {
    if (millis() - ultimoTimeDisparo > tiempoDeEspera) {
      directionToPlayer.normalize(); // Normalizar el vector de dirección
      fireballs.add(new Fireball(posX, posY, fireballImg, directionToPlayer));
      ultimoTimeDisparo = millis();
    }
  }
  
  void display() {
    pushMatrix();
    translate(posX + img.width / 2, posY + img.height / 2);
    rotate(angle);
    imageMode(CENTER);
    image(img, 0, 0);
    popMatrix();
  }
}

class Player extends GameObject {
  Player(float x, float y, PImage img) {
    super(x, y, img);
  }
  
  void move(float x, float y) {
    posX = x - img.width / 2;
    posY = y - img.height / 2;
  }
}

class Fireball extends GameObject {
  PVector velocity;
  
  Fireball(float x, float y, PImage img, PVector direction) {
    super(x+35, y+35, img);
    velocity = direction.copy().mult(5);
  }
  
  void move() {
    posX += velocity.x;
    posY += velocity.y;
  }
  
  void display() {
    super.display();
  }
  
  boolean offScreen() {
    return posX > width || posX < 0 || posY > height || posY < 0;
  }
}
