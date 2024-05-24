
// Clase Vector
class Vector {
  float x1, y1, x2, y2;

  // Constructor para inicializar el vector con puntos origen y destino
  Vector(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }

  // Método para sumar otro vector
  Vector add(Vector v) {
    float newX2 = this.x2 + (v.x2 - v.x1);
    float newY2 = this.y2 + (v.y2 - v.y1);
    return new Vector(this.x1, this.y1, newX2, newY2);
  }

  // Método para restar otro vector
  Vector subtract(Vector v) {
    float newX2 = this.x2 - (v.x2 - v.x1);
    float newY2 = this.y2 - (v.y2 - v.y1);
    return new Vector(this.x1, this.y1, newX2, newY2);
  }

  // Método para dibujar el vector
  void draw() {
    line(x1, y1, x2, y2);
  }
}

// Variables para los puntos A, B y C
Vector AB, AC, AD, BC, CD;


void setup() {
  size(1200, 600);
  background(255);

  // Se amplia el tamaño de los vectores
  float escala = 50;

  // Inicializando los vectores A->B y A->C con la escala
  AB = new Vector(-1 * escala, -2 * escala, 4 * escala, -1 * escala);
  AC = new Vector(-1 * escala, -2 * escala, 5 * escala, 2 * escala);

  // Calculando el vector D usando las operaciones de la clase Vector
  // Vector D se obtiene sumando el vector AC al punto B
  AD = AB.add(AC);
  BC = new Vector(AB.x2, AB.y2, AD.x2, AD.y2);
  CD = new Vector(AC.x2, AC.y2, AD.x2, AD.y2);

  // Dibujando los vectores para formar el paralelogramo
  translate(width/2, height/2);
  strokeWeight(2);
  stroke(0);

  // Dibujar ejes
  stroke(200);
  line(-width/2, 0, width/2, 0);  // Eje X
  line(0, -height/2, 0, height/2);  // Eje Y

  // Dibujar los vectores
  stroke(0);
  AB.draw();
  AC.draw();
  AD.draw();
  BC.draw();
  CD.draw();
}

void draw() {
  // El contenido principal se dibuja en setup()
}
