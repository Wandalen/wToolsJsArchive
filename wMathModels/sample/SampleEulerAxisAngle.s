if( typeof module !== 'undefined' )
require( 'wmathmodels' );
let _ = wTools;

debugger;

var euler1 = _.euler.make();
var euler2 = _.euler.make();
var axisAndAngle = _.axisAndAngle.makeZero( );
var quat1 = _.quat.make();
var quat2 = _.quat.make();
var quat2b = _.quat.make();
euler1=[ 0.5, 0.5, 0.5, 0, 1, 2 ];
euler2[ 3 ] = euler1[ 3 ]; euler2[ 4 ] = euler1[ 4 ]; euler2[ 5 ] = euler1[ 5 ];
debugger;
quat1 = _.euler.toQuat2( euler1, quat1 );
debugger;
logger.log('quat1: ', quat1)
euler2 = _.euler.fromQuat2( euler2, quat1 );
logger.log('euler2: ', euler2)
axisAndAngle = _.euler.toAxisAndAngle2( euler2, axisAndAngle );
quat2 = _.quat.fromAxisAndAngle( quat2, axisAndAngle );
logger.log('quat2: ', quat2)
