if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var sphere = [ 2, 1, 3 ];
var point = [ 5, 6 ];
var distance = _.sphere.pointDistance( sphere, point );
console.log( `Distance from sphere to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from sphere to point : 2.8 */
