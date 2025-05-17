if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var line = [ 2, 1, 4, 2 ];
var point = [ 2, 3 ];
var distance = _.linePoints.pointDistance( line, point );
console.log( `Distance from line to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from line to point : 1.8 */
