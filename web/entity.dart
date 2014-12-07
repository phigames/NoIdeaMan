part of ld31;

abstract class Entity {
  
  Level level;
  num x, y;
  ImageElement frames;
  Rectangle<num> frameRect;
  num width, height;
  bool visible;
  
  Entity(this.level) {
    visible = true;
  }
  
  bool isVisible() {
    return x + width / 2 >= -level.screenSizeX && x - width / 2 <= level.screenSizeX && y + height / 2 >= -level.screenSizeY && y - height / 2 <= level.screenSizeY;
  }
  
  bool isOnScreen() {
    return x >= -level.screenSizeX && x <= level.screenSizeX && y >= -level.screenSizeY && y <= level.screenSizeY;
  }
  
  void update(num delta);
  
  void draw() {
    if (visible) {
      bufferContext.drawImageToRect(frames, new Rectangle<num>((x - width / 2 + level.screenSizeX) * level.screenScale, (y - height / 2 + level.screenSizeY) * level.screenScale, width * level.screenScale, height * level.screenScale), sourceRect: frameRect);
      drawMore();
    }
  }
  
  void drawMore();
  
}