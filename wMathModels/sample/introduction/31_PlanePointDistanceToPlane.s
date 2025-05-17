if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var point = [ 4, 1, -3 ];
var plane = [ 2, -1, 3, 1 ];
var distance = _.plane.pointDistance( plane, point );
console.log( `Distance from 3D plane to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from 3D plane to point : -0.27 */
