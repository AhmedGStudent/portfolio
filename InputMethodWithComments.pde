// these numbers show how long each mouse match lasted in seconds
// arrays start at 0 so the first number is match 1
int[] mouseDurations = {
  113, 60, 53, 108, 71, 70, 77, 66, 68, 51,
  47, 88, 62, 57, 29, 90, 84, 48, 109, 42,
  87, 79, 131, 154, 91, 139, 168, 44, 61, 68,
  70, 106, 138, 139, 109, 96, 87, 39, 100, 101,
  39, 61, 132, 128, 88, 63, 99, 90, 121, 122
};

// this stores if i won or lost each mouse match
// 1 means win and 0 means loss
// each result matches the duration in the other array
// match 26 and match 34 were losses
int[] mouseResults = {
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
  1, 1, 1, 1, 1, 0, 1, 1, 1, 1,
  1, 1, 1, 0, 1, 1, 1, 1, 1, 1,
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1
};

// these will store my touchpad match durations
// empty for now because i havent collected them yet
int[] touchpadDurations = {};

// this will store my touchpad wins and losses
int[] touchpadResults = {};

// where the graph starts on the left
int graphLeft = 80;

// where the graph ends on the right
int graphRight = 720;

// where the graph starts at the top
int graphTop = 100;

// where the graph ends at the bottom
int graphBottom = 500;

// highest duration shown on the graph
int maxDuration = 400;

// total number of matches for each input method
int totalMatches = 50;

// setup only runs once when the program starts
// void means it doesnt return anything
void setup() {

  // makes the window 800 by 600
  size(800, 600);
}

// draw keeps running while the program is open
// this is useful because the mouse can move around
void draw() {

  // makes the background light grey
  background(240);

  // makes the text black
  fill(0);

  // changes the text size
  textSize(16);

  // shows the title
  text("Mouse vs Touchpad Performance Analysis", 230, 40);

  // changes the text size back
  textSize(12);

  // shows what the y axis measures
  text("Duration (seconds)", 85, 70);

  // shows what the x axis measures
  text("Match Number", 350, 560);

  // makes the lines black
  stroke(0);

  // draws the bottom axis
  line(graphLeft, graphBottom, graphRight, graphBottom);

  // draws the side axis
  line(graphLeft, graphBottom, graphLeft, graphTop);

  // repeats 5 times to show the duration numbers
  for (int i = 0; i <= 4; i++) {

    // multiplies i by 100 to get the duration number
    int duration = i * 100;

    // makes sure the number is black
    fill(0);

    // puts the number at the correct height
    // the extra 4 moves the text down slightly
    text(duration, 40, calculateY(duration) + 4);
  }

  // goes through all 50 match positions
  for (int i = 0; i < totalMatches; i++) {

    // only shows every fifth match number
    // % checks the remainder after dividing
    if (i % 5 == 0) {

      // makes the number black
      fill(0);

      // adds 1 because the first array position is 0
      // calculateX finds where the number goes
      text(i + 1, calculateX(i), 525);
    }
  }

  // makes the mouse lines blue
  stroke(0, 120, 255);

  // goes through the mouse data
  // stops one early because each line joins 2 points
  for (int i = 0; i < mouseDurations.length - 1; i++) {

    // draws a line from one match to the next
    // calculateX finds the horizontal positions
    // calculateY finds the vertical positions
    line(
      calculateX(i),
      calculateY(mouseDurations[i]),
      calculateX(i + 1),
      calculateY(mouseDurations[i + 1])
    );
  }

  // makes the touchpad lines orange
  stroke(255, 140, 0);

  // goes through the touchpad data
  // nothing happens yet because the array is empty
  for (int i = 0; i < touchpadDurations.length - 1; i++) {

    // joins each touchpad match to the next one
    line(
      calculateX(i),
      calculateY(touchpadDurations[i]),
      calculateX(i + 1),
      calculateY(touchpadDurations[i + 1])
    );
  }

  // makes the circle outlines black
  stroke(0);

  // makes the mouse circles blue
  fill(0, 120, 255);

  // goes through every mouse match
  for (int i = 0; i < mouseDurations.length; i++) {

    // draws a circle for each match
    // the last 2 numbers are the circle size
    ellipse(
      calculateX(i),
      calculateY(mouseDurations[i]),
      9,
      9
    );
  }

  // makes the touchpad circles orange
  fill(255, 140, 0);

  // goes through every touchpad match
  for (int i = 0; i < touchpadDurations.length; i++) {

    // draws a circle for each touchpad match
    ellipse(
      calculateX(i),
      calculateY(touchpadDurations[i]),
      9,
      9
    );
  }

  // makes a blue circle for the legend
  fill(0, 120, 255);
  ellipse(550, 70, 10, 10);

  // writes mouse next to it
  fill(0);
  text("Mouse", 562, 74);

  // makes an orange circle for the legend
  fill(255, 140, 0);
  ellipse(640, 70, 10, 10);

  // writes touchpad next to it
  fill(0);
  text("Touchpad", 652, 74);

  // checks if the mouse is hovering over a blue point
  for (int i = 0; i < mouseDurations.length; i++) {

    // mouseX and mouseY show where the cursor is
    // dist checks how far the cursor is from the point
    // if its less than 8 it shows the match details
    if (
      dist(
        mouseX,
        mouseY,
        calculateX(i),
        calculateY(mouseDurations[i])
      ) < 8
    ) {

      // shows the details for this mouse match
      // 0 means the input method is mouse
      showDetails(i, mouseDurations[i], mouseResults[i], 0);
    }
  }

  // checks if the mouse is hovering over an orange point
  for (int i = 0; i < touchpadDurations.length; i++) {

    // checks how close the cursor is to the touchpad point
    if (
      dist(
        mouseX,
        mouseY,
        calculateX(i),
        calculateY(touchpadDurations[i])
      ) < 8
    ) {

      // shows the details for this touchpad match
      // 1 means the input method is touchpad
      showDetails(i, touchpadDurations[i], touchpadResults[i], 1);
    }
  }
}

// this method works out where a duration goes on the y axis
// int means it returns a whole number
int calculateY(int duration) {

  // subtracts the duration from the bottom of the graph
  // bigger durations end up higher on the screen
  // return gives the answer back
  return graphBottom - duration;
}

// this method works out where a match goes on the x axis
// float means it can return a decimal number
float calculateX(int index) {

  // works out the space between each match
  // there are 49 gaps between 50 matches
  // 640 is the width of the graph
  float spacing = 640.0 / (totalMatches - 1);

  // returns the horizontal position
  return graphLeft + index * spacing;
}

// this method shows the information when i hover over a point
// void means it doesnt return a value
// index tells it which match to show
// duration is how long the match lasted
// result tells it if i won or lost
// method tells it if i used mouse or touchpad
void showDetails(int index, int duration, int result, int method) {

  // puts the box a bit to the right of the cursor
  float boxX = mouseX + 12;

  // puts the box above the cursor
  float boxY = mouseY - 85;

  // checks if the box would go off the right side
  if (boxX > 630) {

    // moves the box to the left instead
    boxX = mouseX - 165;
  }

  // checks if the box would go off the top
  if (boxY < 5) {

    // moves the box below the cursor instead
    boxY = mouseY + 12;
  }

  // makes the box white
  fill(255);

  // makes the outline black
  stroke(0);

  // draws the box for the match information
  // 150 is the width and 78 is the height
  rect(boxX, boxY, 150, 78);

  // makes the text black
  fill(0);

  // sets the text size
  textSize(12);

  // shows which match it is
  // adds 1 because arrays start at 0
  text("Match: " + (index + 1), boxX + 10, boxY + 18);

  // shows how long the match lasted
  text("Duration: " + duration + "s", boxX + 10, boxY + 36);

  // checks if the input method was mouse
  if (method == 0) {

    // shows mouse if method is 0
    text("Input: Mouse", boxX + 10, boxY + 54);

  } else {

    // shows touchpad otherwise
    text("Input: Touchpad", boxX + 10, boxY + 54);
  }

  // checks if the match was a win
  if (result == 1) {

    // shows win if result is 1
    text("Result: Win", boxX + 10, boxY + 72);

  } else {

    // shows loss otherwise
    text("Result: Loss", boxX + 10, boxY + 72);
  }
}
