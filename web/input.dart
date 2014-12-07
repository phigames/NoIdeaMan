part of ld31;

bool leftKey, upKey, rightKey, downKey;
bool leftMouse, rightMouse;
int mouseX, mouseY;

void initInput() {
  leftKey = false;
  upKey = false;
  rightKey = false;
  downKey = false;
  leftMouse = false;
  rightMouse = false;
  mouseX = 0;
  mouseY = 0;
}

void onKeyDown(KeyboardEvent event) {
  if (event.keyCode == KeyCode.LEFT || event.keyCode == KeyCode.A) {
    leftKey = true;
  } else if (event.keyCode == KeyCode.UP || event.keyCode == KeyCode.W) {
    upKey = true;
  } else if (event.keyCode == KeyCode.RIGHT || event.keyCode == KeyCode.D) {
    rightKey = true;
  } else if (event.keyCode == KeyCode.DOWN || event.keyCode == KeyCode.S) {
    downKey = true;
  }
}

void onKeyUp(KeyboardEvent event) {
  if (event.keyCode == KeyCode.LEFT || event.keyCode == KeyCode.A) {
    leftKey = false;
  } else if (event.keyCode == KeyCode.UP || event.keyCode == KeyCode.W) {
    upKey = false;
  } else if (event.keyCode == KeyCode.RIGHT || event.keyCode == KeyCode.D) {
    rightKey = false;
  } else if (event.keyCode == KeyCode.DOWN || event.keyCode == KeyCode.S) {
    downKey = false;
  }
}

void onMouseDown(MouseEvent event) {
  if (event.button == 0) {
    leftMouse = true;
  } else if (event.button == 2) {
    rightMouse = true;
  }
}

void onMouseUp(MouseEvent event) {
  if (event.button == 0) {
    leftMouse = false;
  } else if (event.button == 2) {
    rightMouse = false;
  }
}

void onMouseMove(MouseEvent event) {
  mouseX = event.client.x - canvas.offsetLeft + window.scrollX;
  mouseY = event.client.y - canvas.offsetTop + window.scrollY;
}