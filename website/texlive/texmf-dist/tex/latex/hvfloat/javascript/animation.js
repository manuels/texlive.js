////////////////////////////////////////////////////////////////////////////////
//
// (C) 2012, Alexander Grahn
//
// animation.js
//
// version 20120301
//
////////////////////////////////////////////////////////////////////////////////
//
// JavaScript for use with `add3DJScript' option of \includemedia
//
// * Activates keyframe animation embedded in the u3d file.
// * Arrow keys `Down', `Up' can be used for speeding up and
//   slowing down a running animation, key `Home' for reverting
//   to the default speed.
//
// * Adjustable parameters:
var  rate = 1; // 1 --> use original speed as default
var  palindrome = true; // true --> play forth and back
//
// This work may be distributed and/or modified under the
// conditions of the LaTeX Project Public License, either version 1.3
// of this license or (at your option) any later version.
// The latest version of this license is in
//   http://www.latex-project.org/lppl.txt
// and version 1.3 or later is part of all distributions of LaTeX
// version 2005/12/01 or later.
//
// This work has the LPPL maintenance status `maintained'.
// 
// The Current Maintainer of this work is A. Grahn.
//
////////////////////////////////////////////////////////////////////////////////

//get the first animation in the scene
var myAnim = scene.animations.getByIndex(0);
myAnim.wallTime = 0;
myAnim.speed = 1;
myAnim.myLength = myAnim.endTime - myAnim.startTime;
scene.activateAnimation(myAnim);

//method to set animation speed
myAnim.setSpeed = function (speed) {
  speed = Math.abs(speed);
  this.wallTime /= speed/this.speed; //correct the walltime
  this.speed = speed;
};

//method to change animation speed by a factor
myAnim.changeSpeed = function (mult) {
  this.wallTime /= mult; //correct the walltime
  this.speed *= mult;
};

//set default speed
myAnim.setSpeed(rate);

//menu items
runtime.addCustomMenuItem("faster", "Faster (Key Up)", "default", 0);
runtime.addCustomMenuItem("slower", "Slower (Key Down)", "default", 0);
runtime.addCustomMenuItem("default", "Default Speed (Key Home)", "default", 0);

//menu handler to control speed
menuEventHandler = new MenuEventHandler();
menuEventHandler.onEvent = function(e) {
  if (e.menuItemName == "faster") {
    myAnim.changeSpeed(1.25);
  }
  else if (e.menuItemName == "slower") {
    myAnim.changeSpeed(1/1.25);
  }
  else if (e.menuItemName == "default") {
    myAnim.setSpeed(rate);
  }
};
runtime.addEventHandler(menuEventHandler);

//key handler to control speed
keyEventHandler = new KeyEventHandler();
keyEventHandler.onKeyDown = true;
keyEventHandler.onEvent = function(e) {
  switch(e.characterCode) {
    case 30: //key up
      myAnim.changeSpeed(1.05);
      break;

    case 31: //key down
      myAnim.changeSpeed(1/1.05);
      break;

    case 4: //key home
      myAnim.setSpeed(rate);
      break;

    case 1: //key end
      myAnim.setSpeed(rate);
      break;
  }
};
runtime.addEventHandler(keyEventHandler);

//run the animation using a TimeEventHandler
myTimer = new TimeEventHandler();
myTimer.onTimeChange = true;
myTimer.onEvent = function(e) {
  myAnim.wallTime += e.deltaTime;
  if (palindrome == true) {
    myAnim.currentTime =
      myAnim.startTime
      + myAnim.myLength/2
        * (1 - Math.cos(Math.PI * myAnim.speed/myAnim.myLength * myAnim.wallTime));
  } else {
    myAnim.currentTime = myAnim.startTime
      + (myAnim.speed * myAnim.wallTime % myAnim.myLength);
  }
};
runtime.addEventHandler(myTimer);
