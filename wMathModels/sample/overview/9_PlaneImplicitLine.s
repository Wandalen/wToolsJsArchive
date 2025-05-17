if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var line = [ -2, -1, 2 ];
var point = [ 2, 3 ];
var distance = _.plane.pointDistance( line, point );
console.log( `Distance from straight to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from straight to point : 0.89 */
