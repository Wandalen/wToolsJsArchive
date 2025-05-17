if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var point = [ 0, 1 ];
var line = [ 0, 0, 0, 2 ];
var contains = _.linePointDir.pointContains( line, point );
console.log( `Line contains point : ${ contains }` );
/* log : Line contains point : true */
