if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var plane = [ 1, 1, 0, 0 ];
var capsule = [ - 1, 2, 3, -1, 2, 3, 0  ];
var intersected = _.plane.capsuleIntersects( plane, capsule );
console.log( `Plane intersects with capsule : ${ intersected }` );
/* log : Plane intersects with capsule: true */
