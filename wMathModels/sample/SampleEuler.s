if( typeof module !== 'undefined' )
require( 'wmathmodels' );
let _ = wTools;

debugger;

var euler1 = [ Math.PI + 0.1, Math.PI, Math.PI/3, 2, 1, 2 ];
var euler2 = [ Math.PI + 0.1, Math.PI + _.accuracySqrt, Math.PI/3 + _.accuracySqr, 2, 1, 2 ];
var euler3 = [ Math.PI + 0.1, Math.PI + _.accuracy, Math.PI/3 + _.accuracySqr, 2, 1, 2 ];
var euler4 = [ Math.PI + 0.1, Math.PI + _.accuracySqr, Math.PI/3 + _.accuracySqr, 2, 1, 2 ];
var euler2bis = [ 0, 0, 0, 2, 1, 2 ];
var quat1 = [ 0, 0, 0, 0 ];
var quat2 = [ 0, 0, 0, 0 ];
var matrix1 = _.Matrix.Make( [ 3, 3 ] )

quat1 = _.euler.toQuat2( euler1, quat1 );
matrix1 = _.quat.toMatrix( quat1, matrix1 );
euler2 = _.euler.fromMatrix3( euler2, matrix1 );
quat2 = _.euler.toQuat2( euler2, quat2 );

console.log( 'quat1 :',quat1[ 0 ], quat1[ 1 ], quat1[ 2 ], quat1[ 3 ] );
console.log( 'quat2 :',quat2[ 0 ], quat2[ 1 ], quat2[ 2 ], quat2[ 3 ] );
console.log( 'euler1 :',euler1[ 0 ], euler1[ 1 ], euler1[ 2 ], euler1[ 3 ], euler1[ 4 ], euler1[ 5 ] );
console.log( 'euler2 :',euler2[ 0 ], euler2[ 1 ], euler2[ 2 ], euler2[ 3 ], euler2[ 4 ], euler2[ 5 ] );

console.log( 'euler2 :',euler2[ 0 ], euler3[ 1 ], euler2[ 2 ], euler2[ 3 ], euler2[ 4 ], euler2[ 5 ] );

console.log( 'euler2 :',euler2[ 0 ], euler4[ 1 ], euler2[ 2 ], euler2[ 3 ], euler2[ 4 ], euler2[ 5 ] );
console.log( _.accuracySqr, _.accuracy, _.accuracySqrt );
