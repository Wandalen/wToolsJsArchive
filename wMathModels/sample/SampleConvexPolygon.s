if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;


var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
([
  0,   0,   0,   0,
  1,   0, - 1,   0,
  0,   1,   0, - 1
]);
var sphere = [ 1, 1, 5, 1 ];

var gotInt = _.convexPolygon.sphereIntersects( polygon, sphere );
var gotDist = _.convexPolygon.sphereDistance( polygon, sphere );
var gotCP = _.convexPolygon.sphereClosestPoint( polygon, sphere );

console.log('Intersection', gotInt)
console.log('Dist', gotDist)
console.log('CP', gotCP)
console.log('CP', _.sphere.pointClosestPoint( sphere, gotCP ) )
