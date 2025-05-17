if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
([
  -3,  0,   0,  -3,   0,  -3,
  0,   0,   0,   0,   -1,  1,
  1,  -1,   0,   0,   0,   0,
  0,   0,  -1,   1,   0,   0,
]);
var polygon = _.Matrix.Make( [ 3, 4 ] ).copy
([
  0.5,   2,   2, 0.5,
  0.5, 0.5,   2,   2,
  0.5, 0.5, 0.5, 0.5
]);

result = _.frustum.convexPolygonIntersects( srcFrustum, polygon );
console.log( result );
result = _.frustum.convexPolygonDistance( srcFrustum, polygon );
console.log( result );
result = _.frustum.convexPolygonClosestPoint( srcFrustum, polygon );
console.log( result );
result = _.frustum.convexPolygonContains( srcFrustum, polygon );
console.log( result );
