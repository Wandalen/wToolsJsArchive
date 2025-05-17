if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

let srcRay = [ 0, 0, -1, 1, 0, 0 ];
var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
([
  0,   0,   0,   0,
  1,   0, - 1,   0,
  0,   1,   0, - 1
]);

result = _.ray.convexPolygonIntersects( srcRay, polygon );
console.log( result );
result = _.ray.convexPolygonDistance( srcRay, polygon );
console.log( result );
result = _.ray.convexPolygonClosestPoint( srcRay, polygon );
console.log( result );
debugger;
