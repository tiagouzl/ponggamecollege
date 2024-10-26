// ponggamecollege - Jogo de Pong em Processing

// Variáveis da bola
float ballX, ballY;
float ballSpeedX = 5, ballSpeedY = 3;
int ballSize = 20;

// Variáveis das paletas
float paddleWidth = 10, paddleHeight = 80;
float leftPaddleY, rightPaddleY;
float paddleSpeed = 20;  // Velocidade mais rápida para maior dinamismo

// Placar
int leftScore = 0;
int rightScore = 0;

// Configuração inicial
void setup() {
  size(640, 480);  // Tamanho da tela
  resetBall();  // Inicializa a bola
  leftPaddleY = height / 2 - paddleHeight / 2;
  rightPaddleY = height / 2 - paddleHeight / 2;
}

// Função principal de repetição
void draw() {
  background(0);
  drawCenterLine();
  drawBall();
  drawPaddles();
  moveBall();
  checkCollision();
  displayScore();
}

// Desenha a linha central
void drawCenterLine() {
  stroke(255);
  for (int i = 0; i < height; i += 20) {
    line(width / 2, i, width / 2, i + 10);
  }
}

// Desenha a bola
void drawBall() {
  fill(255);
  noStroke();
  ellipse(ballX, ballY, ballSize, ballSize);
}

// Desenha as paletas dos jogadores
void drawPaddles() {
  rect(20, leftPaddleY, paddleWidth, paddleHeight);
  rect(width - 30, rightPaddleY, paddleWidth, paddleHeight);
}

// Movimenta a bola
void moveBall() {
  ballX += ballSpeedX;
  ballY += ballSpeedY;

  // Colisão com a parte superior e inferior
  if (ballY < 0 || ballY > height) {
    ballSpeedY *= -1;
  }

  // Verifica se houve gol
  if (ballX < 0) {
    rightScore++;
    resetBall();
  } else if (ballX > width) {
    leftScore++;
    resetBall();
  }
}

// Reseta a posição da bola após um gol
void resetBall() {
  ballX = width / 2;
  ballY = height / 2;
  ballSpeedX = random(1, 2) > 1.5 ? 5 : -5;
  ballSpeedY = random(-3, 3);
}

// Verifica colisão entre a bola e as paletas
void checkCollision() {
  if (ballX < 30 && ballY > leftPaddleY && ballY < leftPaddleY + paddleHeight) {
    ballSpeedX *= -1;
  }
  if (ballX > width - 30 && ballY > rightPaddleY && ballY < rightPaddleY + paddleHeight) {
    ballSpeedX *= -1;
  }
}

// Exibe o placar
void displayScore() {
  textSize(32);
  fill(255);
  text(leftScore, width / 4, 50);
  text(rightScore, 3 * width / 4, 50);
}

// Controla as paletas dos jogadores
void keyPressed() {
  // Paleta esquerda (Jogador 1)
  if (key == 'w' && leftPaddleY > 0) {
    leftPaddleY -= paddleSpeed;
  }
  if (key == 's' && leftPaddleY < height - paddleHeight) {
    leftPaddleY += paddleSpeed;
  }

  // Paleta direita (Jogador 2)
  if (keyCode == UP && rightPaddleY > 0) {
    rightPaddleY -= paddleSpeed;
  }
  if (keyCode == DOWN && rightPaddleY < height - paddleHeight) {
    rightPaddleY += paddleSpeed;
  }
}
