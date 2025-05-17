if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var segment = [ 9, 1, 2, 4 ];
var point = [ 3, 5 ];
var distance = _.segment.pointDistance( segment, point );
console.log( `Distance from segment to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from segment to point : 1.3 */
