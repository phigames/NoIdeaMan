part of ld31;

abstract class Station extends Entity {
  
  num fullness;
  num speed;
  
  Station(Level level) : super(level) {
    fullness = 0;
  }
  
  void onFull();
  
  void apply();
  
  void updateAnimation();
  
  void update(num delta) {
    if (fullness < 3) {
      fullness += delta * speed;
      if (fullness > 3) {
        fullness = 3;
        onFull();
      }
    }
    if (x > level.player.x - level.player.width / 2 && x < level.player.x + level.player.width / 2 && y > level.player.y - level.player.height / 2 && y < level.player.y + level.player.height / 2) {
      if (fullness == 3) {
        apply();
        fullness = 0;
      }
    }
    updateAnimation();
  }
  
  void drawMore() { }
  
}

class Station_Health extends Station {
  
  Station_Health(Level level, num x, num y) : super(level) {
    this.x = x;
    this.y = y;
    frames = images['health-station'];
    frameRect = new Rectangle(0, 0, 110, 100);
    width = 50;
    height = width / frameRect.width * frameRect.height;
    speed = 0.0001;
  }
  
  void onFull() { }
  
  void apply() {
    level.player.heal(1);
    level.effects.add(new GraphicEffect(level, level.player.x, level.player.y - 70, images['health-text']));
  }
  
  void updateAnimation() {
    frameRect = new Rectangle(fullness.toInt() * 110, 0, 110, 100);
  }
  
}

class Station_Upgrade extends Station {
  
  Station_Upgrade(Level level, num x, num y) : super(level) {
    this.x = x;
    this.y = y;
    frames = images['upgrade-station'];
    frameRect = new Rectangle(0, 0, 90, 90);
    width = 50;
    height = width / frameRect.width * frameRect.height;
    speed = 0.0001;
  }
  
  void onFull() {
    level.effects.add(new GraphicEffect(level, x - 100, y + 60, images['upgrade-text']));
  }
  
  void apply() {
    level.player.bulletDamage++;
    level.effects.add(new GraphicEffect(level, level.player.x, level.player.y - 70, images['bullets-text']));
    speed *= 0.8;
  }
  
  void updateAnimation() {
    frameRect = new Rectangle(fullness.toInt() * 90, 0, 90, 90);
  }
  
}