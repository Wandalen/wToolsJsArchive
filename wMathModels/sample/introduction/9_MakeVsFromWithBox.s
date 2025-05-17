if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var src1 = [ 2, 1, 9, 5 ];
var box1 = _.box.make( src1 );
console.log( 'Box1 :', box1 );
/* log : Box1 : [ 2, 1, 9, 5 ] */
console.log( 'src1 === box1 :', src1 === box1 );
/* log : src1 === box1 : false */

var src2 = [ 2, 1, 9, 5 ];
var box2 = _.box.from( src2 );
console.log( 'Box2 :', box2 );
/* log : Box2 : [ 2, 1, 9, 5 ] */
console.log( 'src2 === box2 :', src2 === box2 );
/* log : src2 === box2 : true */

