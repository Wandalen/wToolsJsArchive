if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var plane = [ 1, 1, 0, 0 ];
var segment = [ -2, -2, -2, 2, 2, 2 ];
var intersected = _.plane.segmentIntersects( plane, segment );
console.log( `Plane intersects with segment : ${ intersected }` );
/* log : Plane intersects with segment : true */
