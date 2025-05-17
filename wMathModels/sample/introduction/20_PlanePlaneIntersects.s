if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var plane = [ 1, 1, 0, 0 ];
var intersected = _.plane.planeIntersects( plane, plane );
console.log( `Plane intersects with plane : ${ intersected }` );
/* log : Plane intersects with plane : true */
