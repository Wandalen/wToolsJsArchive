if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

var srcSphere = [ 4, 4, Math.sqrt( 2 ) ];
var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
([
  3,   5,   5,   3,
  3,   3,   5,   5
]);

result = _.sphere.convexPolygonIntersects( srcSphere, polygon );
console.log( result );
result = _.sphere.convexPolygonDistance( srcSphere, polygon );
console.log( result );
result = _.sphere.convexPolygonClosestPoint( srcSphere, polygon );
console.log( result );
result = _.sphere.convexPolygonContains( srcSphere, polygon );
console.log( result );
debugger;
