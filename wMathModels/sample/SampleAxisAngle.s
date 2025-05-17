if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

debugger;

var srcMatrix = _.Matrix.Make([ 3, 3 ]).copy
([
  0.7701511383, -0.4207354784, 0.479425549507,
  0.6224468350, 0.65995573997, - 0.420735478401,
  - 0.13938128948, 0.622446835, 0.7701511383
]);

var axisAndAngle = [ 0, 0, 0, 0 ];
aa = _.axisAndAngle.fromMatrixRotation( axisAndAngle, srcMatrix );
logger.log('aa: ', aa)
m = _.axisAndAngle.toMatrixRotation( axisAndAngle, _.Matrix.MakeZero( [ 3, 3 ] ) );
logger.log('m: ', m)


var q = _.quat.fromAxisAndAngle([ 0, 0, 0, 0 ], axisAndAngle );
logger.log('q: ', q)

var e = _.euler.fromQuat2([ 0, 0, 0, 0, 1, 2 ], q );
logger.log('e: ', e)
