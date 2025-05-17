if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var plane = [ -2, 0, 2, 0 ];
var box = [ 0, 0, 0, 2, 2, 2 ];
var intersected = _.plane.boxIntersects( plane, box );
console.log( `Plane intersects with box : ${ intersected }` );
/* log : Plane intersects with box : true */
