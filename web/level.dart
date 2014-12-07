part of ld31;

class Level {

  num screenTargetSizeX, screenTargetSizeY;
  num screenSizeX, screenSizeY;
  num screenTargetScale;
  num screenScale;
  int expandScreen;
  ImageElement background;
  Player player;
  List<EnemySpawner> spawners;
  List<Enemy> enemies;
  List<Station> stations;
  List<GraphicEffect> effects;
  ImageElement heart;
  Rectangle<num> heartRect, brokenHeartRect;
  int dialog;
  num dialogTime;
  num bossTime;
  ImageElement bossText;
  num winTime;
  
  Level.Test() {
    screenSizeX = 400;
    screenSizeY = 225;
    screenTargetScale = 1;
    screenScale = 5;
    expandScreen = 0;
    background = images['background'];
    player = new Player(this);
    spawners = new List<EnemySpawner>();
    if (easy) {
      spawners.add(new EnemySpawner(this, 250, 150, EnemySpawner.TYPE_PACM, 4000, 15000));
      spawners.add(new EnemySpawner(this, 150, -200, EnemySpawner.TYPE_PACM, 5500, 15000));
      spawners.add(new EnemySpawner(this, -100, -300, EnemySpawner.TYPE_STRAWB, 8000, 10000));
      spawners.add(new EnemySpawner(this, -200, 330, EnemySpawner.TYPE_CHERR, 8000, 1000));
      spawners.add(new EnemySpawner(this, -650, -100, EnemySpawner.TYPE_GHOS, 10000, 0));
    } else {
      spawners.add(new EnemySpawner(this, 250, 150, EnemySpawner.TYPE_PACM, 3500, 12000));
      spawners.add(new EnemySpawner(this, 150, -200, EnemySpawner.TYPE_PACM, 5000, 12000));
      spawners.add(new EnemySpawner(this, -100, -300, EnemySpawner.TYPE_STRAWB, 8000, 10000));
      spawners.add(new EnemySpawner(this, -200, 330, EnemySpawner.TYPE_CHERR, 8000, 1000));
      spawners.add(new EnemySpawner(this, -650, -100, EnemySpawner.TYPE_GHOS, 10000, 0));
    }
    enemies = new List<Enemy>();
    stations = new List<Station>();
    stations.add(new Station_Health(this, -300, 0));
    stations.add(new Station_Upgrade(this, 500, -250));
    effects = new List<GraphicEffect>();
    heart = images['heart'];
    heartRect = new Rectangle<num>(0, 0, 100, 100);
    brokenHeartRect = new Rectangle<num>(100, 0, 100, 100);
    dialog = 0;
    dialogTime = 0;
    bossTime = -1;
    bossText = images['boss-text'];
    winTime = -1;
  }
  
  void update(num delta) {
    if (dialogTime >= 0) {
      dialogTime += delta;
    }
    if (dialogTime >= 1000 && dialog == 0) {
      effects.add(new GraphicEffect(this, player.x + 100, player.y - 90, images['dialog-1']));
      dialog = 1;
    } else if (dialogTime >= 3000 && dialog == 1) {
      effects.add(new GraphicEffect(this, -300, -120, images['dialog-2']));
      dialogTime = -1;
    }
    if (bossTime == -1) {
      screenTargetScale *= 1 + delta * 0.000005;
      if (screenTargetScale > 1) {
        screenTargetScale = 1;
      }
      while (expandScreen > 0) {
        if (screenTargetScale <= 0.62) {
          screenTargetScale *= 0.997;
        } else if (screenTargetScale <= 0.8) {
          screenTargetScale *= 0.99;
        } else {
          screenTargetScale *= 0.98;
        }
        expandScreen--;
        if (screenTargetScale <= 0.5 && bossTime != -2) {                     // <-------- 0.5
          screenTargetScale = 0.5;
          bossTime = 0;
          spawners.clear();
          stations.clear();
        }
      }
      screenTargetSizeX = 400 / screenTargetScale;
      screenTargetSizeY = 225 / screenTargetScale;
    }
    screenScale += (screenTargetScale - screenScale) * 0.01 * delta;
    screenSizeX = 400 / screenScale;
    screenSizeY = 225 / screenScale;
    player.update(delta);
    for (int i = 0; i < spawners.length; i++) {
      if (spawners[i].isOnScreen()) {
        spawners[i].update(delta);
      }
    }
    for (int i = 0; i < enemies.length; i++) {
      if (enemies[i].isOnScreen()) {
        if (enemies[i].dead) {
          enemies.removeAt(i);
          i--;
          continue;
        }
        enemies[i].update(delta);
      }
    }
    for (int i = 0; i < stations.length; i++) {
      if (stations[i].isOnScreen()) {
        stations[i].update(delta);
      }
    }
    for (int i = 0; i < effects.length; i++) {
      effects[i].update(delta);
      if (effects[i].dead) {
        effects.removeAt(i);
        i--;
      }
    }
    if (bossTime >= 0) {
      bossTime += delta;
      if (bossTime >= 3000) {
        bossTime = -2;
        // kinda sloppy...
        enemies.add(new Enemy_Pacma(new EnemySpawner(this, 0, 0, EnemySpawner.TYPE_PACMA, 0, 0)));
      }
    } else if (bossTime == -2 && enemies.length == 0 && winTime == -1) {
      winTime = 0;
    }
    if (winTime >= 0) {
      winTime += delta;
      if (winTime >= 2000) {
        gameState = new GameState_Win();
      }
    }
  }
  
  void draw() {
    /*int bx = screenSizeX ~/ 200 + 1;
    int by = screenSizeY ~/ 200 + 1;
    for (int i = -bx; i < bx; i++) {
      for (int j = -by; j < by; j++) {
        bufferContext.drawImageToRect(background, new Rectangle<num>((i * 200 + screenSizeX) * screenScale, (j * 200 + screenSizeY) * screenScale, 200 * screenScale, 200 * screenScale));
      }
    }*/
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 3; j++) {
        bufferContext.drawImageToRect(background, new Rectangle<num>(i * 200, j * 200, 200, 200));
      }
    }
    player.draw();
    for (int i = 0; i < spawners.length; i++) {
      if (spawners[i].isVisible()) {
        spawners[i].draw();
      }
    }
    for (int i = 0; i < enemies.length; i++) {
      if (enemies[i].isVisible()) {
        enemies[i].draw();
      }
    }
    for (int i = 0; i < stations.length; i++) {
      if (stations[i].isVisible()) {
        stations[i].draw();
      }
    }
    for (int i = 0; i < effects.length; i++) {
      effects[i].draw();
    }
    for (int i = 0; i < player.maxHealth; i++) {
      if (player.health > i) {
        bufferContext.drawImageToRect(heart, new Rectangle<num>(i * 40 + 10, 10, 40, 40), sourceRect: heartRect);
      } else {
        bufferContext.drawImageToRect(heart, new Rectangle<num>(i * 40 + 10, 10, 40, 40), sourceRect: brokenHeartRect);
      }
    }
    if (bossTime >= 0 && bossTime < 3000 && (bossTime / 1000).round() == bossTime ~/ 1000) {
      bufferContext.drawImageToRect(bossText, new Rectangle<num>(50, 50, 700, 350));
    }
  }
  
}

// i'm so bad at naming things...
class GraphicEffect {
  
  Level level;
  num x, y;
  ImageElement image;
  num width, height;
  num offsetY;
  num alpha;
  bool dead;
  
  GraphicEffect(this.level, this.x, this.y, this.image) {
    width = image.width / 2;
    height = width / image.width * image.height;
    offsetY = 0;
    alpha = 1;
    dead = false;
  }
  
  void update(num delta) {
    offsetY -= delta * 0.01;
    alpha -= delta * 0.0008;
    if (alpha <= 0) {
      dead = true;
    }
  }
  
  void draw() {
    bufferContext.globalAlpha = alpha;
    bufferContext.drawImageToRect(image, new Rectangle<num>((x + level.screenSizeX) * level.screenScale - width / 2, (y + level.screenSizeY) * level.screenScale - height / 2 + offsetY, width, height));
    bufferContext.globalAlpha = 1;
  }
  
}