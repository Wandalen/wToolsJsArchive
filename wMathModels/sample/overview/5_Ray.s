if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var ray = [ 2, 1, 6, 3 ];
var point = [ 2, 3 ];
var distance = _.ray.pointDistance( ray, point );
console.log( `Distance from ray to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from ray to point : 1.8 */
