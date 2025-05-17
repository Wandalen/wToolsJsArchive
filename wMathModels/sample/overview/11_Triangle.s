if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var triangle = [ 2, 1, 9, 2, 5, 6 ];
var point = [ 3, 6 ]
var distance = _.triangle.pointDistance( triangle, point );
console.log( `Distance from triangle to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from triangle to point : 1.7 */
console.log( `Type : ${ _.entity.strType( triangle ) }` );
/* log : Type : Array */
