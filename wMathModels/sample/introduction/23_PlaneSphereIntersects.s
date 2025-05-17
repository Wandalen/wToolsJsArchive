if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var plane = [ 2, 0, 2, 0 ];
var sphere = [ 0, 0, 0, 1.5 ];
var intersected = _.plane.sphereIntersects( plane, sphere );
console.log( `Plane intersects with sphere : ${ intersected }` );
/* log : Plane intersects with sphere : true */
