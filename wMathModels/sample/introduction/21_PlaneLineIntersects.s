if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var plane = [ 1, 1, 0, 0 ];
var line = [ 1, 0, 1, 1, 1, 1 ];
var intersected = _.plane.lineIntersects( plane, line );
console.log( `Plane intersects with line : ${ intersected }` );
/* log : Plane intersects with line : true */
