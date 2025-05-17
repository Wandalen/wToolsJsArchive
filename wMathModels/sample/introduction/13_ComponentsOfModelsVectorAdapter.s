if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var box = _.vad.from([ 2, 1, 9, 5 ]);
var cornerLeft = _.box.cornerLeftGet( box );
var cornerRight = _.box.cornerRightGet( box );
console.log( `cornerLeft : ${ cornerLeft }` );
/* log : cornerLeft : VectorAdapter.x2.Array :: 2.000 1.000 */
console.log( `cornerRight : ${ cornerRight }` );
/* log : cornerRight : VectorAdapter.x2.Array :: 9.000 5.000 */
