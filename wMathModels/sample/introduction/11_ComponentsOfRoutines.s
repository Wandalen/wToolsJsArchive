if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var box = new F32x([ 2, 1, 9, 5 ]);
var cornerLeft = _.box.cornerLeftGet( box );
var cornerRight = _.box.cornerRightGet( box );
console.log( `cornerLeft : ${ cornerLeft }` );
/* log : cornerLeft : VectorAdapter.x2.F32x :: 2.000 1.000 */
console.log( `cornerRight : ${ cornerRight }` );
/* log : cornerRight : VectorAdapter.x2.F32x :: 9.000 5.000 */
