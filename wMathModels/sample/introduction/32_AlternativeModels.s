if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var linePoints1 = _.linePoints.from([ 1, 1, 3, 3 ]);
var linePoints2 = _.linePoints.from([ 2, 2, 3, 3 ]);
var point1 = _.linePoints.pairIntersectionPoint( linePoints1, linePoints2 );
console.log( `Intersection point : ${ point1 }` );
/* log : Intersection point : [ 2, 2 ] */

var linePointsDir1 = _.linePointDir.fromPoints2( linePoints1 );
var linePointsDir2 = _.linePointDir.fromPoints2( linePoints2 );
var point2 = _.linePointDir.lineIntersectionPoint( linePointsDir1, linePointsDir2 );
console.log( `Intersection point : ${ point2 }` );
/* log : Intersection point: [ 2, 2 ] */
