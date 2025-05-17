if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var plane = [ 1, -1, 0, 0 ];
var ray = [ 0, 0, 0, 1, 1, 1 ];
var intersected = _.plane.rayIntersects( plane, ray );
console.log( `Plane intersects with ray : ${ intersected }` );
/* log : Plane intersects with ray: true */
