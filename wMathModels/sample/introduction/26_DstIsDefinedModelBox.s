if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var point1 = [ 3, 1 ];
var point2 = [ 0, 8 ];
var dstBox = _.box.makeSingular( 2 );
console.log( `Box : ${dstBox}` );
/* log : Box : Infinity,Infinity,-Infinity,-Infinity */
_.box.fromPoints( dstBox, [ point1, point2 ] );
console.log( `Box : ${dstBox}` );
/* log : Box : 0,1,3,8 */
