part of ld31;

class Bullet extends Entity {

  num speedX, speedY;
  num damage;
  Entity owner;
  bool dead;
  
  Bullet.Player(Player player) : super(player.level) {
    x = player.x;
    y = player.y - 50;
    frames = images['bullet'];
    frameRect = new Rectangle<num>(0, 0, 47, 38);
    width = 20;
    height = width / frameRect.width * frameRect.height;
    num dx = mouseX / level.screenScale - level.screenSizeX - x;
    num dy = mouseY / level.screenScale - level.screenSizeY - y;
    num a = atan(dy / dx);
    if (dx < 0) {
      a += PI;
    }
    speedX = cos(a) * 0.4;
    speedY = sin(a) * 0.4;
    damage = player.bulletDamage;
    owner = player;
    dead = false;
    sounds['shoot'].currentTime = 0;
    sounds['shoot'].play();
  }
  
  Bullet.Strawb(Enemy_Strawb strawb) : super(strawb.level) {
    x = strawb.x;
    y = strawb.y - 20;
    frames = images['strawb-bullet'];
    num dx = level.player.x - x;
    num dy = level.player.y - y;
    if (dx.abs() > dy.abs()) {
      frameRect = new Rectangle<num>(0, 0, 40, 40);
    } else {
      frameRect = new Rectangle<num>(40, 0, 40, 40);
    }
    width = 30;
    height = width / frameRect.width * frameRect.height;
    num a = atan(dy / dx);
    if (dx < 0) {
      a += PI;
    }
    speedX = cos(a) * 0.5;
    speedY = sin(a) * 0.5;
    damage = 1;
    owner = strawb;
    dead = false;
    sounds['shoot'].currentTime = 0;
    sounds['shoot'].play();
  }
  
  Bullet.Cherr(Enemy_Cherr cherr) : super(cherr.level) {
    x = cherr.x;
    y = cherr.y - 20;
    frames = images['bullet'];
    num dx = level.player.x - x;
    num dy = level.player.y - y;
    frameRect = new Rectangle<num>(0, 0, 47, 38);
    width = 30;
    height = width / frameRect.width * frameRect.height;
    num a = atan(dy / dx);
    if (dx < 0) {
      a += PI;
    }
    speedX = cos(a) * 0.5;
    speedY = sin(a) * 0.5;
    damage = 2;
    owner = cherr;
    dead = false;
    sounds['shoot'].currentTime = 0;
    sounds['shoot'].play();
  }
  
  void update(num delta) {
    x += speedX * delta;
    y += speedY * delta;
    if (x < -level.screenSizeX - 50 || x > level.screenSizeX + 50 || y < -level.screenSizeY - 50 || y > level.screenSizeY + 50) {
      dead = true;
    } else {
      if (owner == level.player) {
        for (int i = 0; i < level.enemies.length; i++) {
          Enemy e = level.enemies[i];
          // optimize
          if (x > e.x - e.width / 3 && x < e.x + e.width / 3 && y > e.y - e.height / 3 && y < e.y + e.height / 3) {
            e.damage(damage);
            dead = true;
            break;
          }
        }
      } else {
        // optimize
        if (x > level.player.x - level.player.width / 2 && x < level.player.x + level.player.width / 2 && y > level.player.y - level.player.height / 2 && y < level.player.y + level.player.height / 2) {
          level.player.damage(damage);
          dead = true;
        }
      }
    }
  }
  
  void drawMore() { }
  
}