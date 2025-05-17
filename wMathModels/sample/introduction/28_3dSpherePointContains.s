if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var sphere3d = [ 2, 2, 2, 5 ];
var point3d = [ 3, 3, 3 ];
var contains = _.sphere.pointContains( sphere3d, point3d );
console.log( `Sphere contains point : ${ contains }` );
/* log : Sphere contains point : true */
