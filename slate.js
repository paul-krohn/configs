var fullScreen = slate.operation("move", {
  "x" : "screenOriginX",
  "y" : "screenOriginY",
  "width" : "screenSizeX",
  "height" : "screenSizeY"
});

var pushTopLeftThird = slate.operation("move", {
    "x" : "screenOriginX",
    "y" : "screenOriginY",
    "width" : "screenSizeX/3",
    "height" : "screenSizeY/2"
});

var pushTopRightThird = slate.operation("move", {
    "x" : "screenOriginX+2*screenSizeX/3",
    "y" : "screenOriginY",
    "width" : "screenSizeX/3",
    "height" : "screenSizeY/2"
});

/*
  screenOriginY represents, under usual/single display circumstances,
  the height of the main title bar and needs to be added to the y offest
  for non-top placements, ie anything that is intended to be flush to the
  bottom of the screen.
*/
var pushBottomLeftThird = slate.operation("move", {
    "x" : "screenOriginX",
    "y" : "screenOriginY+screenSizeY/2",
    "width" : "screenSizeX/3",
    "height" : "screenSizeY/2"
});

var pushBottomRightThird = slate.operation("move", {
    "x" : "screenOriginX+2*screenSizeX/3",
    "y" : "screenOriginY+screenSizeY/2",
    "width" : "screenSizeX/3",
    "height" : "screenSizeY/2"
});

var pushLeftThird = slate.operation("push", {
  "direction" : "left",
  "style" : "bar-resize:screenSizeX/3"
});

var pushRightThird = slate.operation("push", {
  "direction" : "right",
  "style" : "bar-resize:screenSizeX/3"
});

var pushRight2Thirds = slate.operation("push", {
  "direction" : "right",
  "style" : "bar-resize:2*screenSizeX/3"
});

var pushLeft2Thirds = slate.operation("push", {
  "direction" : "left",
  "style" : "bar-resize:2*screenSizeX/3"
});

var pushCenterThird = slate.operation("move", {
  "x": "screenOriginX+screenSizeX/3",
  "y": "screenOriginY",
  "width": "screenSizeX/3",
  "height" : "screenSizeY"
});

var pushLeft = slate.operation("push", {
  "direction" : "left",
  "style" : "bar-resize:screenSizeX/2"
});

var pushRight = slate.operation("push", {
  "direction" : "right",
  "style" : "bar-resize:screenSizeX/2"
});

slate.bind("right:ctrl;alt", function(win) {
    win.doOperation(pushRight);
});

slate.bind("up:ctrl;shift", function(win) {
    win.doOperation(pushTopLeftThird);
});

slate.bind("up:alt;shift", function(win) {
    win.doOperation(pushTopRightThird);
});

slate.bind("down:ctrl;shift", function(win) {
    win.doOperation(pushBottomLeftThird);
});

slate.bind("down:alt;shift", function(win) {
    win.doOperation(pushBottomRightThird);
});

slate.bind("left:ctrl;alt", function(win) {
    win.doOperation(pushLeft);
});

slate.bind("left:shift;ctrl", function(win) {
    win.doOperation(pushLeftThird);
});

slate.bind("right:shift;ctrl", function(win) {
    win.doOperation(pushRightThird);
});

slate.bind("right:shift;ctrl;alt",function(win) {
    win.doOperation(pushRight2Thirds);
});

slate.bind("left:shift;ctrl;alt",function(win) {
    win.doOperation(pushLeft2Thirds);
});

slate.bind("f:alt;ctrl",function(win) {
    win.doOperation(fullScreen);
});

/*
  tried to map this to up-arrow, seems to be confounded with
  something from mission control or something.
*/
slate.bind("c:shift;ctrl",function(win) {
    win.doOperation(pushCenterThird);
});
