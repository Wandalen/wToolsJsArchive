if( typeof module !== 'undefined' )
require( 'wmathmodels' );
let _ = wTools;

debugger;

var srcQuat = [ Math.PI/4, Math.PI/4, 0, Math.PI/2 ];
var matrix1 = _.Matrix.MakeZero( [ 3, 3 ] );
var dstQuat = _.quat.make();

matrix1 = _.quat.toMatrix( srcQuat, matrix1 );
dstQuat = _.quat.fromMatrixRotation2( dstQuat, matrix1 );
console.log( 'First case: Conversion methods _.euler.toMatrix2 and _.euler.fromMatrix2 ', dstQuat)
