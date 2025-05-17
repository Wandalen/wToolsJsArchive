if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var point = [ 3, 2 ];
var line = [ -4, 4, 0 ];
var distance = _.plane.pointDistance( line, point );
console.log( `Distance from line to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from line to point : -0.71*/
