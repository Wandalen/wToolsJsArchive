if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var sphere4d = [ 3, 3, 3, 3, 5 ];
var point4d = [ 4, 4, 4, 4 ];
var contains = _.sphere.pointContains( sphere4d, point4d );
console.log( `Sphere contains point : ${ contains }` );
/* log : Sphere contains point : true */
