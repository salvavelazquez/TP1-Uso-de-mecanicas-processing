PImage playerImg, enemyImg, fireballImg, backgroundImage;
Player player;
Enemy enemy;
ArrayList<Fireball> fireballs;
int fireballCooldown = 1000; // Tiempo de espera entre disparos (en milisegundos)
int lastFireballTime = 0; // Último tiempo en que se disparó una bola de fuego

void setup() {
  size(800, 600);
  
  // Cargar y reducir las imágenes
  playerImg = loadImage("player.png");
  enemyImg = loadImage("enemy.png");
  fireballImg = loadImage("fireball.png");
  backgroundImage = loadImage("fondo.jpg");
  
  playerImg.resize(80, 150); // Cambiar el tamaño de la imagen del jugador
  enemyImg.resize(200, 200);  // Cambiar el tamaño de la imagen del enemigo
  fireballImg.resize(40, 30); // Cambiar el tamaño de la imagen de la bola de fuego
  
  player = new Player(600, 0, playerImg);
  enemy = new Enemy(10, 320, enemyImg);
  fireballs = new ArrayList<Fireball>();
}

void draw() {
  image(backgroundImage, 0, 0, width, height);
  player.display();
  enemy.display();
  enemy.detectar(player);
  
  for (int i = fireballs.size() - 1; i >= 0; i--) {
    Fireball fb = fireballs.get(i);
    fb.move();
    fb.display();
    if (fb.offScreen()) {
      fireballs.remove(i);
    }
  }
}

void keyPressed() {
  player.move(key);
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

class Player extends GameObject {
  Player(float x, float y, PImage img) {
    super(x, y, img);
  }
  
  void move(char key) {
    if (keyCode == UP) posY -= 15;
    if (keyCode == DOWN) posY += 15;
    if (keyCode == LEFT) posX -= 15;
    if (keyCode == RIGHT) posX += 15;
  }
}

class Enemy extends GameObject {
  float visionAngle = radians(30);
  
  Enemy(float x, float y, PImage img) {
    super(x, y, img);
  }
  
  void detectar(Player player) {
    PVector toPlayer = new PVector(player.posX - posX, player.posY - posY);
    PVector direction = new PVector(1, 0); // Enemigo mira hacia la derecha
    
    float angle = PVector.angleBetween(direction, toPlayer);
    
    if (angle < visionAngle) {
      attack(toPlayer);
    }
  }
  
  void attack(PVector directionToPlayer) {
    if (millis() - lastFireballTime > fireballCooldown) {
      directionToPlayer.normalize(); // Normalizar el vector de dirección
      fireballs.add(new Fireball(posX, posY, fireballImg, directionToPlayer));
      lastFireballTime = millis();
    }
  }
}

class Fireball extends GameObject {
  PVector velocity;
  
  Fireball(float x, float y, PImage img, PVector direction) {
    super(x, y, img);
    velocity = direction.copy().mult(10); // Ajusta la velocidad de la bola de fuego
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
