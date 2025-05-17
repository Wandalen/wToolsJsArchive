
if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

var capsule = [ 2, 2, 0, 4, 4, 4, 1 ];
var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
([
  0,   0,   0,   0,
  1,   0, - 1,   0,
  0,   1,   0, - 1
]);

result = _.capsule.convexPolygonIntersects( capsule, polygon );
console.log( result );
result = _.capsule.convexPolygonDistance( capsule, polygon );
console.log( result );
result = _.capsule.convexPolygonClosestPoint( capsule, polygon );
console.log( result );
