
int[] mouseDurations = {113, 60, 53, 108, 71, 70, 77, 66, 68, 51,
  47, 88, 62, 57, 29, 90, 84, 48, 109, 42,
  87, 79, 131, 154, 91, 139, 168, 44, 61, 68,
  70, 106, 138, 139, 109, 96, 87, 39, 100, 101,
  39, 61, 132, 128, 88, 63, 99, 90, 121, 122};

int[] mouseResults = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
  1, 1, 1, 1, 1, 0, 1, 1, 1, 1,
  1, 1, 1, 0, 1, 1, 1, 1, 1, 1,
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1};

int[] touchpadDurations = {};
int[] touchpadResults = {};

int graphLeft = 80;
int graphRight = 720;
int graphTop = 100;
int graphBottom = 500;
int maxDuration = 400;
int totalMatches = 50;

void setup() {
  size(800, 600);
}

void draw() {
  background(240);
  fill(0);
  textSize(16);
  text("Mouse vs Touchpad Performance Analysis", 230, 40);
  textSize(12);
  text("Duration (seconds)", 85, 70);
  text("Match Number", 350, 560);

  stroke(0);
  line(graphLeft, graphBottom, graphRight, graphBottom);
  line(graphLeft, graphBottom, graphLeft, graphTop);

  for (int i = 0; i <= 4; i++) {
    int duration = i * 100;
    fill(0);
    text(duration, 40, calculateY(duration) + 4);
  }

  for (int i = 0; i < totalMatches; i++) {
    if (i % 5 == 0) {
      fill(0);
      text(i + 1, calculateX(i), 525);
    }
  }

  stroke(0, 120, 255);
  for (int i = 0; i < mouseDurations.length - 1; i++) {
    line(calculateX(i), calculateY(mouseDurations[i]),
      calculateX(i + 1), calculateY(mouseDurations[i + 1]));
  }

  stroke(255, 140, 0);
  for (int i = 0; i < touchpadDurations.length - 1; i++) {
    line(calculateX(i), calculateY(touchpadDurations[i]),
      calculateX(i + 1), calculateY(touchpadDurations[i + 1]));
  }

  stroke(0);
  fill(0, 120, 255);
  for (int i = 0; i < mouseDurations.length; i++) {
    ellipse(calculateX(i), calculateY(mouseDurations[i]), 9, 9);
  }

  fill(255, 140, 0);
  for (int i = 0; i < touchpadDurations.length; i++) {
    ellipse(calculateX(i), calculateY(touchpadDurations[i]), 9, 9);
  }

  fill(0, 120, 255);
  ellipse(550, 70, 10, 10);
  fill(0);
  text("Mouse", 562, 74);
  fill(255, 140, 0);
  ellipse(640, 70, 10, 10);
  fill(0);
  text("Touchpad", 652, 74);

  for (int i = 0; i < mouseDurations.length; i++) {
    if (dist(mouseX, mouseY, calculateX(i), calculateY(mouseDurations[i])) < 8) {
      showDetails(i, mouseDurations[i], mouseResults[i], 0);
    }
  }

  for (int i = 0; i < touchpadDurations.length; i++) {
    if (dist(mouseX, mouseY, calculateX(i), calculateY(touchpadDurations[i])) < 8) {
      showDetails(i, touchpadDurations[i], touchpadResults[i], 1);
    }
  }
}

int calculateY(int duration) {
  return graphBottom - duration;
}

float calculateX(int index) {
  float spacing = 640.0 / (totalMatches - 1);
  return graphLeft + index * spacing;
}

void showDetails(int index, int duration, int result, int method) {
  float boxX = mouseX + 12;
  float boxY = mouseY - 85;
  if (boxX > 630) {
    boxX = mouseX - 165;
  }
  if (boxY < 5) {
    boxY = mouseY + 12;
  }

  fill(255);
  stroke(0);
  rect(boxX, boxY, 150, 78);
  fill(0);
  textSize(12);
  text("Match: " + (index + 1), boxX + 10, boxY + 18);
  text("Duration: " + duration + "s", boxX + 10, boxY + 36);
  if (method == 0) {
    text("Input: Mouse", boxX + 10, boxY + 54);
  } else {
    text("Input: Touchpad", boxX + 10, boxY + 54);
  }
  if (result == 1) {
    text("Result: Win", boxX + 10, boxY + 72);
  } else {
    text("Result: Loss", boxX + 10, boxY + 72);
  }
}
