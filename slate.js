var pushLeftThird = slate.operation("push", {
  "direction" : "left",
  "style" : "bar-resize:screenSizeX/3"
});

var pushRightThird = slate.operation("push", {
  "direction" : "right",
  "style" : "bar-resize:screenSizeX/3"
});


/*
var move = slate.operation("move", {
  "x" : topLeftX,
  "y" : topLeftY,
  "width" : width,
  "height" : height,
  "screen" : screen
});
*/
var pushCenterThird = slate.operation("move", {
//   "x": "screenOriginX+screenSizeX/3,"
//   "y": "screenOriginY",
//   "width": "screenSizeX/3",
//   "height": 100
  "x": "screenOriginX+screenSizeX/3",
  "y": "screenOriginY",
  "width": "screenSizeX/3",
  "height" : "screenSizeY"
});
  
//   "y" : topLeftY,
//   "height" : height,
//   "screen" : screen
//   "direction" : "left",
//   "style" : "bar-resize:screenSizeX/3",

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

// slate.bind("up:shift;ctrl", function(win) {
//     win.doOperation(pushCenterThird);
// });
// 

/*
slate.bind("1:ctrl", function(win) {
  // here win is a reference to the currently focused window
  if (win.title() === "OMG I WANT TO BE FULLSCREEN") {
    win.doOperation(fullscreen);
    return;
  }
  var appName = win.app().name();
  if (appName === "iTerm") {
    win.doOperation(pushRight);
  } else if (appName === "Google Chrome") {
    win.doOperation(pushLeft);
  } else {
    win.doOperation(pushTop);
  }
});
*/