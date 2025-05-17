if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

let srcSegment = [ 3, 0, -1, 4, 0, 0 ];
var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
([
  0,   0,   0,   0,
  1,   0, - 1,   0,
  0,   1,   0, - 1
]);

result = _.segment.convexPolygonIntersects( srcSegment, polygon );
console.log( result );
result = _.segment.convexPolygonDistance( srcSegment, polygon );
console.log( result );
result = _.segment.convexPolygonClosestPoint( srcSegment, polygon );
console.log( result );
debugger;
