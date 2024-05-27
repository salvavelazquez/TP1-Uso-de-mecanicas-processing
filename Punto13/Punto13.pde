int posX, posY;        // Posición de la bola
int tamanoBola = 20;   // Tamaño de la bola
float velX, velY;      // Velocidad de la bola
float[] normal;        // Normal de la superficie
float[] incidente;     // Vector incidente
float[] reflejado;     // Vector reflejado

void setup() {
  size(400, 400);  
  posX = width / 2;
  posY = height / 2;
  velX = random(-5, 5);
  velY = random(-5, 5);
}

void draw() {
  background(#1EB75C);
  moverBola();
  mostrarBola();
}

void moverBola() {
  posX += velX;
  posY += velY;
  
  // Reflexión en los bordes de la pantalla
  if (posX <= 0 || posX >= width) {
    normal = new float[]{1, 0};   // Normal para los bordes verticales
    incidente = new float[]{velX, velY};
    reflejado = reflejar(incidente, normal);
    velX = reflejado[0];
    velY = reflejado[1];
  }
  
  if (posY <= 0 || posY >= height) {
    normal = new float[]{0, 1};   // Normal para los bordes horizontales
    incidente = new float[]{velX, velY};
    reflejado = reflejar(incidente, normal);
    velX = reflejado[0];
    velY = reflejado[1];
  }
}

void mostrarBola() {
  fill(255, 0, 0);  
  ellipse(posX, posY, tamanoBola, tamanoBola);
}

float[] reflejar(float[] v, float[] n) {
  float productoPunto = v[0] * n[0] + v[1] * n[1];
  float[] reflexion = new float[2];
  reflexion[0] = v[0] - 2 * productoPunto * n[0];
  reflexion[1] = v[1] - 2 * productoPunto * n[1];
  return reflexion;
}
