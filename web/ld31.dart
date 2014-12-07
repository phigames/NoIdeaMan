library ld31;

import 'dart:html';
import 'dart:math';

part 'gamestate.dart';
  part 'level.dart';
    part 'entity.dart';
      part 'player.dart';
      part 'enemies.dart';
      part 'bullet.dart';
      part 'stations.dart';
part 'resources.dart';
part 'input.dart';

Random random;
CanvasElement canvas;
CanvasRenderingContext2D canvasContext;
CanvasElement buffer;
CanvasRenderingContext2D bufferContext;
num lastUpdate;
DivElement startButton;
DivElement easyButton;
DivElement hardButton;
GameState gameState;
bool easy;

void main() {
  random = new Random();
  canvas = querySelector('#canvas');
  canvasContext = canvas.context2D;
  buffer = new CanvasElement(width: canvas.width, height: canvas.height);
  bufferContext = buffer.context2D;
  loadResources();
  initInput();
  window.onKeyDown.listen(onKeyDown);
  window.onKeyUp.listen(onKeyUp);
  canvas.onMouseDown.listen(onMouseDown);
  canvas.onMouseUp.listen(onMouseUp);
  canvas.onMouseMove.listen(onMouseMove);
  lastUpdate = -1;
  canvas.hidden = true;
  startButton = querySelector('#start');
  startButton.onClick.listen((_) => start());
  easyButton = querySelector('#easy');
  easyButton.onClick.listen((_) => onEasyClick());
  hardButton = querySelector('#hard');
  hardButton.onClick.listen((_) => onHardClick());
  easy = true;
}

void onEasyClick() {
  easyButton.className = 'easy_';
  hardButton.className = 'hard';
  easy = true;
}

void onHardClick() {
  hardButton.className = 'hard_';
  easyButton.className = 'easy';
  easy = false;
}

void start() {
  gameState = new GameState_Instructions();
  window.animationFrame.then(update);
  querySelector('#menu').hidden = true;
  canvas.hidden = false;
}

void update(num time) {
  if (lastUpdate == -1) {
    lastUpdate = time;
  }
  gameState.update(time - lastUpdate);
  lastUpdate = time;
  clear();
  gameState.draw();
  flush();
  window.animationFrame.then(update);
}

void clear() {
  bufferContext.clearRect(0, 0, canvas.width, canvas.height);
  bufferContext.fillStyle = '#FFFFFF';
  bufferContext.fillRect(0, 0, canvas.width, canvas.height);
}

void flush() {
  canvasContext.clearRect(0, 0, canvas.width, canvas.height);
  canvasContext.drawImage(buffer, 0, 0);
}