if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var line = [ 2, 1, 2, 1 ];
var point = [ 2, 3 ];
var distance = _.linePointDir.pointDistance( line, point );
console.log( `Distance from line by point and direction to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from line by point and direction to point : 1.8 */
