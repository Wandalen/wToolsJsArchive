
if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

var srcBox = [ - 1, - 1, -1, 2, 2, 2 ];
var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
([
  0,   0,   0,   0,
  1,   0, - 1,   0,
  0,   1,   0, - 1
]);

  var gotBool = _.box.convexPolygonContains( srcBox, polygon );
console.log( gotBool )
debugger;
