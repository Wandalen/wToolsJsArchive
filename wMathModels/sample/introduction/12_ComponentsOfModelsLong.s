if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var box = new F32x([ 2, 1, 9, 5 ]);
var cornerLeft = _.box.cornerLeftGet( box );
console.log( `cornerLeft : ${ cornerLeft }` );
/* log : cornerLeft : VectorAdapter.x2.F32x :: 2.000 1.000 */
cornerLeft.assign([ 3, 4 ]);
console.log( `box : ${ box }` );
/* log : box : 3,4,9,5 */
