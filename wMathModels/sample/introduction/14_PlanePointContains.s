if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var point = [ 0, 1, 2 ];
var plane = [ 0, 1, 2, -1 ];
var contains = _.plane.pointContains( plane, point );
console.log( `Plane contains point : ${ contains }` );
/* log : Plane contains point : true */
