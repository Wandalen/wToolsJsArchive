if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var line = [ 4, 2 ];
var point = [ 2, 3 ];
var distance = _.linePointCentered.pointDistanceCentered2D( line, point );
console.log( `Distance from centered line to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from centered line to point : 1.8 */
