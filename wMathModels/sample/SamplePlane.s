if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

let srcPlane = [ 0, 0, 1, 0 ];
var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
([
  0,   0,   0,   0,
  1,   0, - 1,   0,
  0,   1,   0, - 1
]);

result = _.plane.convexPolygonIntersects( srcPlane, polygon );
console.log( result );
result = _.plane.convexPolygonDistance( srcPlane, polygon );
console.log( result );
result = _.plane.convexPolygonClosestPoint( srcPlane, polygon );
console.log( result );
debugger;
