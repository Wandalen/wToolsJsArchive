if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var euler1 =  [ 1, 0, 0.5, 0, 1, 2 ] ;
console.log( `Euler : ${ _.entity.exportString( euler1, { precision : 2 } ) }` );
/* log : Euler : [ 1.0, 0.0, 0.50, 0.0, 1.0, 2.0 ] */

var quat = _.euler.toQuat( euler1, null );
console.log( `Quat from Euler : ${ _.entity.exportString( quat, { precision : 2 } ) }` );
/* log : Quat from Euler : [ 0.46, -0.12, 0.22, 0.85 ] */

var euler2 = _.quat.toEuler( quat, null );
console.log( `Euler from Quat : ${ _.entity.exportString( euler2, { precision : 2 } ) }` );
/* log : Euler from Quat : [ 1.0, 0.0, 0.50, 0.0, 1.0, 2.0 ] */
