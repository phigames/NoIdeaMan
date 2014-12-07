part of ld31;

class Enemy extends Entity {
  
  num health;
  bool dead;
  int value;
  
  Enemy(EnemySpawner spawner, bool scatter) : super(spawner.level) {
    if (scatter) {
      do {
        x = spawner.x + random.nextDouble() * 300 - 150;
      } while (x < -level.screenSizeX || x > level.screenSizeX);
      do {
        y = spawner.y + random.nextDouble() * 300 - 150;
      } while (y < -level.screenSizeY || y > level.screenSizeY);
    } else {
      x = spawner.x;
      y = spawner.y - 20;
    }
    dead = false;
    sounds['spawn'].currentTime = 0;
    sounds['spawn'].play();
  }
  
  void damage(num damage) {
    health -= damage;
    if (health <= 0) {
      dead = true;
      level.expandScreen += value;
      level.effects.add(new GraphicEffect(level, x, y - 20, images['kill-text']));
      sounds['kill'].currentTime = 0;
      sounds['kill'].play();
    } else {
      sounds['damage'].currentTime = 0;
      sounds['damage'].play();
    }
  }
  
  void update(num delta) {
    
  }
  
  void drawMore() { }
  
}

class Enemy_Pacm extends Enemy {
  
  int direction;
  int frame;
  num frameTime;
  num frameDelay;
  num speed;
  num hurt;
  num hurtTime;
  num hurtDelay;
  
  Enemy_Pacm(EnemySpawner spawner) : super(spawner, false) {
    frames = images['pacm'];
    frameRect = new Rectangle<num>(0, 0, 200, 250);
    width = 50;
    height = width / frameRect.width * frameRect.height;
    direction = 0;
    frame = 0;
    frameTime = 0;
    frameDelay = 300;
    speed = 0.1;
    hurt = 1;
    hurtTime = 0;
    if (easy) {
      hurtDelay = 1000;
    } else {
      hurtDelay = 500;
    }
    health = 3;
    value = 3;
  }
  
  void updateFrame(num delta) {
    frameTime += delta;
    if (frameTime >= frameDelay) {
      frame++;
      if (frame > 1) {
        frame = 0;
      }
      frameTime -= frameDelay;
    }
    // optimize (direction change)
    frameRect = new Rectangle<num>(direction * 400 + frame * 200, 0, 200, 250);
  }
  
  void update(num delta) {
    num dx = level.player.x - x;
    num dy = level.player.y - y;
    num a = atan(dy / dx);
    if (dx < 0) {
      a += PI;
    }
    num mx = cos(a) * speed * delta;
    num my = sin(a) * speed * delta;
    if (mx.abs() > my.abs()) {
      if (mx < 0) {
        direction = 0;
      } else {
        direction = 2;
      }
    } else {
      if (my < 0) {
        direction = 1;
      } else {
        direction = 3;
      }
    }
    x += mx;
    y += my;
    hurtTime += delta;
    if (x > level.player.x - level.player.width / 2 && x < level.player.x + level.player.width / 2 && y > level.player.y - level.player.height / 2 && y < level.player.y + level.player.height / 2) {
      if (hurtTime >= hurtDelay) {
        level.player.damage(hurt);
        hurtTime = 0;
      }
    }
    updateFrame(delta);
  }
  
}

class Enemy_Strawb extends Enemy {
  
  List<Bullet> bullets;
  num bulletTime;
  num bulletDelay;
  
  Enemy_Strawb(EnemySpawner spawner) : super(spawner, true) {
    bullets = new List<Bullet>();
    bulletTime = 0;
    if (easy) {
      bulletDelay = 5000;
    } else {
      bulletDelay = 3000;
    }
    frames = images['strawb'];
    frameRect = new Rectangle(0, 0, 360, 440);
    width = 70;
    height = width / frameRect.width * frameRect.height;
    health = 5;
    value = 4;
  }
  
  void update(num delta) {
    bulletTime += delta;
    if (bulletTime >= bulletDelay) {
      bullets.add(new Bullet.Strawb(this));
      bulletTime = 0;
    }
    for (int i = 0; i < bullets.length; i++) {
      bullets[i].update(delta);
      if (bullets[i].dead) {
        bullets.removeAt(i);
        i--;
      }
    }
  }
  
  void drawMore() {
    for (int i = 0; i < bullets.length; i++) {
      bullets[i].draw();
    }
  }
  
}

class Enemy_Cherr extends Enemy {
  
  List<Bullet> bullets;
  num bulletTime;
  num bulletDelay;
  
  Enemy_Cherr(EnemySpawner spawner) : super(spawner, true) {
    bullets = new List<Bullet>();
    bulletTime = 0;
    if (easy) {
      bulletDelay = 5000;
    } else {
      bulletDelay = 3000;
    }
    frames = images['cherr'];
    frameRect = new Rectangle(0, 0, 185, 204);
    width = 70;
    height = width / frameRect.width * frameRect.height;
    health = 8;
    value = 5;
  }
  
  void update(num delta) {
    bulletTime += delta;
    if (bulletTime >= bulletDelay) {
      bullets.add(new Bullet.Cherr(this));
      bulletTime = 0;
    }
    for (int i = 0; i < bullets.length; i++) {
      bullets[i].update(delta);
      if (bullets[i].dead) {
        bullets.removeAt(i);
        i--;
      }
    }
  }
  
  void drawMore() {
    for (int i = 0; i < bullets.length; i++) {
      bullets[i].draw();
    }
  }
  
}

class Enemy_Ghos extends Enemy {
 
  num speed;
  num hurt;
  num hurtTime;
  num hurtDelay;
  
  Enemy_Ghos(EnemySpawner spawner) : super(spawner, false) {
    frames = images['ghos'];
    frameRect = new Rectangle<num>(0, 0, 336, 335);
    width = 100;
    height = width / frameRect.width * frameRect.height;
    speed = 0.15;
    hurt = 3;
    hurtTime = 0;
    if (easy) {
      hurtDelay = 1000;
    } else {
      hurtDelay = 500;
    }
    health = 20;
    value = 12;
  }
  
  void update(num delta) {
    num dx = level.player.x - x;
    num dy = level.player.y - y;
    num a = atan(dy / dx);
    if (dx < 0) {
      a += PI;
    }
    x += cos(a) * speed * delta;
    y += sin(a) * speed * delta;
    hurtTime += delta;
    if (x > level.player.x - level.player.width / 2 && x < level.player.x + level.player.width / 2 && y > level.player.y - level.player.height / 2 && y < level.player.y + level.player.height / 2) {
      if (hurtTime >= hurtDelay) {
        level.player.damage(hurt);
        hurtTime = 0;
      }
    }
  }
  
}

class Enemy_Pacma extends Enemy {
  
  int direction;
  int frame;
  num frameTime;
  num frameDelay;
  num speed;
  num hurt;
  num hurtTime;
  num hurtDelay;
  
  Enemy_Pacma(EnemySpawner spawner) : super(spawner, false) {
    frames = images['pacm'];
    frameRect = new Rectangle<num>(0, 0, 200, 250);
    width = 200;
    height = width / frameRect.width * frameRect.height;
    direction = 0;
    frame = 0;
    frameTime = 0;
    frameDelay = 300;
    speed = 0.22;
    hurt = 4;
    hurtTime = -3000;
    hurtDelay = 1000;
    health = 100;
    value = 3;
  }
  
  void updateFrame(num delta) {
    frameTime += delta;
    if (frameTime >= frameDelay) {
      frame++;
      if (frame > 1) {
        frame = 0;
      }
      frameTime -= frameDelay;
    }
    // optimize (direction change)
    frameRect = new Rectangle<num>(direction * 400 + frame * 200, 0, 200, 250);
  }
  
  void update(num delta) {
    hurtTime += delta;
    if (hurtTime > 0) {
      num dx = level.player.x - x;
      num dy = level.player.y - y;
      num mx = 0;
      num my = 0;
      if (random.nextInt(500 ~/ delta) == 0) {
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
      }
      if (direction == 0) {
        mx = -speed * delta;
      } else if (direction == 1) {
        my = -speed * delta;
      } else if (direction == 2) {
        mx = speed * delta;
      } else if (direction == 3) {
        my = speed * delta;
      }
      x += mx;
      y += my;
      if (x > level.screenSizeX) {
        x = level.screenSizeX;
      } else if (x < -level.screenSizeX) {
        x = -level.screenSizeX;
      }
      if (y > level.screenSizeY) {
        y = level.screenSizeY;
      } else if (y < -level.screenSizeY) {
        y = -level.screenSizeY;
      }
      if (x > level.player.x - level.player.width / 2 && x < level.player.x + level.player.width / 2 && y > level.player.y - level.player.height / 2 && y < level.player.y + level.player.height / 2) {
        if (hurtTime >= hurtDelay) {
          level.player.damage(hurt);
          hurtTime = 0;
        }
      }
    }
    updateFrame(delta);
  }
  
}

class EnemySpawner extends Entity {
  
  static const int TYPE_PACM = 1;
  static const int TYPE_STRAWB = 2;
  static const int TYPE_CHERR = 3;
  static const int TYPE_GHOS = 4;
  static const int TYPE_PACMA = 5;
  
  int type;
  num spawnTime;
  num spawnDelay;
  num spawnDeceleration;
  
  EnemySpawner(Level level, num x, num y, this.type, this.spawnDelay, this.spawnDeceleration) : super(level) {
    this.x = x;
    this.y = y;
    if (type != TYPE_PACMA) {
      frames = images['spawner'];
      frameRect = new Rectangle(0, 0, 219, 200);
      width = 80;
      height = width / frameRect.width * frameRect.height;
      spawnTime = -random.nextDouble() * 5000;
    }
  }
  
  void update(num delta) {
    spawnTime += delta;
    if (spawnTime >= spawnDelay) {
      if (type == TYPE_PACM) {
        level.enemies.add(new Enemy_Pacm(this));
      } else if (type == TYPE_STRAWB) {
        level.enemies.add(new Enemy_Strawb(this));
      } else if (type == TYPE_CHERR) {
        level.enemies.add(new Enemy_Cherr(this));
      } else if (type == TYPE_GHOS) {
        level.enemies.add(new Enemy_Ghos(this));
      } else if (type == TYPE_PACMA) {
        level.enemies.add(new Enemy_Pacma(this));
      }
      spawnTime = (-1 / (level.screenTargetScale) + 1) * spawnDeceleration;
    }
  }
  
  void drawMore() { }
  
}