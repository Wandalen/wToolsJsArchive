if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

var srcLine = [ -5, 2, -5, 1, 0, 1 ];
var polygon =  _.Matrix.Make([ 3, 4 ]).copy
([
  0,   0,   0,   0,
  1,   0, - 1,   0,
  0,   1,   0, - 1
]);

debugger;
var result = _.linePointDir.convexPolygonIntersects( srcLine, polygon );
console.log( result );
result = _.linePointDir.convexPolygonDistance( srcLine, polygon );
console.log( result );
result = _.linePointDir.convexPolygonClosestPoint( srcLine, polygon );
console.log( result );
