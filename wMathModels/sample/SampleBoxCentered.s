
if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

let srcBox = [ -1, 3, 2, 3, 3, 4 ];
var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
([
  0,   0,   0,   0,
  1,   0, - 1,   0,
  0,   1,   0, - 1
]);

result = _.box.convexPolygonIntersects( srcBox, polygon );
console.log( result );
result = _.box.convexPolygonDistance( srcBox, polygon );
console.log( result );
result = _.box.convexPolygonClosestPoint( srcBox, polygon );
console.log( result );
debugger;

srcBox = [ - 1, - 1, -1, 0, 0, 2 ];
var tstCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
var expected = false;

var gotCapsule = _.box.capsuleContains( srcBox, tstCapsule );
console.log( gotCapsule );
