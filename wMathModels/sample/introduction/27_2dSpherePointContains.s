if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var sphere2d = [ 1, 1, 5 ];
var point2d = [ 2, 2 ];
var contains = _.sphere.pointContains( sphere2d, point2d );
console.log( `Sphere contains point : ${ contains }` );
/* log : Sphere contains point : true */
