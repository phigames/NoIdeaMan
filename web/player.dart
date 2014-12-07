part of ld31;

class Player extends Entity {

  num speed;
  List<Bullet> bullets;
  num bulletTime;
  num bulletDelay;
  num bulletDamage;
  int direction;
  int frame;
  num frameTime;
  num frameDelay;
  num health;
  num maxHealth;
  bool dead;
  num deathTime;
  
  Player(Level level) : super(level) {
    x = 0;
    y = 0;
    frames = images['player'];
    frameRect = new Rectangle<num>(0, 0, 150, 280);
    width = 100;
    height = width / frameRect.width * frameRect.height;
    speed = 0.2;
    bullets = new List<Bullet>();
    bulletTime = 0;
    bulletDelay = 500;
    bulletDamage = 1;
    direction = 0;
    frame = 0;
    frameTime = 0;
    frameDelay = 200;
    health = 10;
    maxHealth = 10;
    dead = false;
  }
  
  void damage(num damage) {
    health -= damage;
    if (health <= 0 && !dead) {
      dead = true;
      deathTime = 0;
      visible = false;
      level.effects.add(new GraphicEffect(level, x, y - 70, images['kill-text']));
      sounds['kill'].currentTime = 0;
      sounds['kill'].play();
    }
    sounds['hurt'].currentTime = 0;
    sounds['hurt'].play();
  }
  
  // severe case of name lackage
  void heal(num healage) {
    health += healage;
    if (health > maxHealth) {
      health = maxHealth;
    }
  }
  
  void updateAnimation(num delta) {
    frameTime += delta;
    if (frameTime >= frameDelay) {
      frame++;
      if (frame > 1) {
        frame = 0;
      }
      frameTime -= frameDelay;
    }
    // optimize (direction change)
    frameRect = new Rectangle<num>(direction * 300 + frame * 150, 0, 150, 280);
  }
  
  void update(num delta) {
    if (leftKey) {
      x -= speed * delta;
      if (x < -level.screenSizeX) {
        x = -level.screenSizeX;
      }
      direction = 0;
    }
    if (upKey) {
      y -= speed * delta;
      if (y < -level.screenSizeY) {
        y = -level.screenSizeY;
      }
      direction = 1;
    }
    if (rightKey) {
      x += speed * delta;
      if (x > level.screenSizeX) {
        x = level.screenSizeX;
      }
      direction = 2;
    }
    if (downKey) {
      y += speed * delta;
      if (y > level.screenSizeY) {
        y = level.screenSizeY;
      }
      direction = 3;
    }
    bulletTime += delta;
    if (leftMouse) {
      num dx = mouseX / level.screenScale - level.screenSizeX - x;
      num dy = mouseY / level.screenScale - level.screenSizeY - y;
      if (dx.abs() > dy.abs()) {
        if (dx < 0) {
          direction = 0;
        } else {
          direction = 2;
        }
      } else {
        if (dy < 0) {
          direction = 1;
        } else {
          direction = 3;
        }
      }
      if (bulletTime >= bulletDelay) {
        bullets.add(new Bullet.Player(this));
        bulletTime = 0;
      }
    }
    for (int i = 0; i < bullets.length; i++) {
      bullets[i].update(delta);
      if (bullets[i].dead) {
        bullets.removeAt(i);
        i--;
      }
    }
    updateAnimation(delta);
    if (dead) {
      deathTime += delta;
      if (deathTime >= 2000) {
        gameState = new GameState_Death();
      }
    }
  }
  
  void drawMore() {
    for (int i = 0; i < bullets.length; i++) {
      bullets[i].draw();
    }
  }
  
}