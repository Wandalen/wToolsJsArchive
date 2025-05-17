if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var axisAndAngle = [ 1, 0, 0, Math.PI / 4 ];
var euler = _.euler.fromAxisAndAngle2( null, axisAndAngle );
console.log( `AxisAndAngle to Euler : ${ _.entity.exportString( euler, { precision : 2 } ) }` )
/* log : AxisAndAngle to Euler : [ 0.79, 0.0, -0.0, 0.0, 1.0, 2.0 ] */
