var pushLeftThird = slate.operation("push", {
  "direction" : "left",
  "style" : "bar-resize:screenSizeX/3"
});

var pushRightThird = slate.operation("push", {
  "direction" : "right",
  "style" : "bar-resize:screenSizeX/3"
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
