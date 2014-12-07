part of ld31;

abstract class GameState {
  
  void update(num delta);
  
  void draw();
  
}

class GameState_Instructions extends GameState {
  
  ImageElement image;
  
  GameState_Instructions() {
    image = images['instructions'];
  }
  
  void update(num delta) {
    if (leftMouse) {
      gameState = new GameState_World();
    }
  }
  
  void draw() {
    bufferContext.drawImage(image, 0, 0);
  }
  
}

class GameState_World extends GameState {
  
  Level playingLevel;
  
  GameState_World() {
    playingLevel = new Level.Test();
  }
  
  void update(num delta) {
    playingLevel.update(delta);
  }
  
  void draw() {
    playingLevel.draw();
  }
  
}

class GameState_Win extends GameState {
  
  ImageElement image;
  AudioElement sound;
  
  GameState_Win() {
    image = images['win'];
    sound = sounds['win'];
    sound.currentTime = 0;
    sound.play();
  }
  
  void update(num delta) { }
  
  void draw() {
    bufferContext.drawImage(image, 0, 0);
  }
  
}

class GameState_Death extends GameState {
  
  ImageElement image;
  AudioElement sound;
  
  GameState_Death() {
    image = images['death'];
    sound = sounds['death'];
    sound.currentTime = 0;
    sound.play();
  }
  
  void update(num delta) { }
  
  void draw() {
    bufferContext.drawImage(image, 0, 0);
  }
  
}