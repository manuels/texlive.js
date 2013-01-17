////////////////////////////////////////////////////////////////////////////////
//
// (C) 2012, Alexander Grahn
//
// asylabels.js
//
// version 20120301
//
////////////////////////////////////////////////////////////////////////////////
//
// 3D JavaScript to be used with media9.sty (option `add3Djscript') for
// Asymptote generated PRC files
//
// adds billboard behaviour to text labels in Asymptote PRC files for improved
// visibility, they always face the camera while dragging the 3d object with the
// mouse.
//
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

//recursive function which computes the lower left BBox corner of a text
//label; it marches through all sibling mesh nodes the label is composed of;
//the returned Vector3 object will become the pivot point of the label
function nextCenter(msh){
  //compute local-to-world transf. matrix of current mesh node
  var trans=new Matrix4x4(msh.transform);
  var parent=msh.parent;
  while(parent.transform){
    trans.multiplyInPlace(parent.transform);
    parent=parent.parent;
  }

  //min BBox corner of current mesh node
  var min=new Vector3();
  min.set(msh.computeBoundingBox().min);
  min.set(trans.transformPosition(min));

  //get min BBox corner closest to origin (0,0,0)
  if(msh.nextSibling){
    var nextmin=nextCenter(msh.nextSibling);
    return(min.length < nextmin.length ? min : nextmin);
  }else{
    return(min);
  }
}

//find all text labels in the scene and determine pivoting points
var zero=new Vector3(0,0,0);
var nodes=scene.nodes;
var center=new Array();
var index=new Array();
for(var i=0; i<nodes.count; i++){
  var node=nodes.getByIndex(i); 
  var name=node.name;
  var end=name.lastIndexOf(".")-1;
  if(end > 0){
    if(name.charAt(end) == "\001"){
      var start=name.lastIndexOf("-")+1;
      if(end-start > 0) {
        index.push(i);
        center.push(nextCenter(node.firstChild));
        node.name=name.substr(0,start-1);
      }
    }
  }
}

var camera=scene.cameras.getByIndex(0); 

//event handler to maintain upright position of text labels
billboardHandler=new RenderEventHandler();
billboardHandler.onEvent=function(event)
{
  var position=camera.position;
  var direction=position.subtract(camera.targetPosition);
  var up=camera.up.subtract(position);

  for(var i=0; i<index.length; i++){
    var node=nodes.getByIndex(index[i]);
    var R=Matrix4x4();
    R.setView(zero,direction,up);
    var c=center[i];
    var T=node.transform;
    T.setIdentity();
    T.translateInPlace(c.scale(-1));
    T.multiplyInPlace(R);
    T.translateInPlace(c);
  }

  runtime.refresh(); 
}
runtime.addEventHandler(billboardHandler);

runtime.refresh();
