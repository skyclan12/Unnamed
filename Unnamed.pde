//started July 16th, 2016
//last updated July 16th, 2016
//By Skyclan12

//Starting Values
int enemySpawnRate = 5000;
int enemyLastSpawn = 0;
int enemySize = 75;
int playerSize = 50;

//Extra variables
int startTime;
int endTime;

//???
Player subject;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

void setup(){
  frameRate(60); //Set framerate
  size(750, 750); //Initialize dimensions of playing field
  subject = new Player(width/2, height/2); //Spawn player
  
}

void draw(){
  background(0);
  loadEntities();
  updateEntities();
  if (millis() >= enemyLastSpawn + enemySpawnRate) { //spawn an enemy at a set interval
    spawnEnemy();
  } 
  checkCollisions();
}

void spawnEnemy(){
  enemies.add(new Enemy(int(random(width - (width / 7))), int(random(height - (height / 7)))));
  enemyLastSpawn = millis();
}

void updateEntities(){
  for (Enemy thisEnemy : enemies){
    thisEnemy.move();
  }
  subject.move();
}

void loadEntities(){
  for (Enemy thisEnemy : enemies){
    thisEnemy.loadEnemy();
  }
  subject.loadPlayer();
}

void checkCollisions(){
  for (Enemy thisEnemy : enemies) {
    float collideDistance = enemySize + playerSize;
    if (dist(thisEnemy.getX(), thisEnemy.getY(), subject.getX(), subject.getY()) <= collideDistance) {
      terminateGame();
    }
  }
}

void terminateGame(){
  noLoop();
  text("Game Over", width/2, height/2);
}

class Enemy {
  float x, y, direction;
  Enemy(int xPos, int yPos){
    x = xPos;
    y = yPos;
  }
  
  void move(){
    direction = atan2(subject.getY() - y, subject.getX() - x);
    //direction = atan2(height/2-y,width/2-y);
    //direction = atan2(-y,-x);
    x = x + cos(direction) * 2;
    y = y + sin(direction) * 2;
  }

  void loadEnemy() {
    fill(255, 50, 50);
    ellipse(x, y, enemySize, enemySize);
    fill(0);
  }
  
  float getX() {
    return x;
  }

  float getY() {
    return y;
  }
  
}

class Player{
  int x, y;
  Player(int xPos, int yPos){
    x = xPos;
    y = yPos;
  }
  
  int getX(){
    return x;
  }
  
  int getY(){
    return y;
  }
  
  void loadPlayer(){
    fill(50, 50, 255);
    ellipse(x, y, playerSize, playerSize);
    fill(0);
  }
  
  void move(){
    y = y + ((mouseY - y) / 5);
    x = x + ((mouseX - x) / 5);
  }
  
}