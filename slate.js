var fullScreen = slate.operation("move", {
  "x" : "screenOriginX",
  "y" : "screenOriginY",
  "width" : "screenSizeX",
  "height" : "screenSizeY"
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

slate.bind("right:ctrl", function(win) {
    win.doOperation(pushRight);
});

slate.bind("left:ctrl", function(win) {
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
