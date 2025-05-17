if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var plane = [ -0.4, 1, 0, 0 ];
var frustum = _.frustum.make().copy
([
  -1,   0,  -1,   0,   0,  -1,
   0,   0,   0,   0,  -1,   1,
   1,  -1,   0,   0,   0,   0,
   0,   0,   1,  -1,   0,   0,
]);
var intersected = _.plane.frustumIntersects( plane, frustum );
console.log( `Plane intersects with frustum : ${ intersected }` );
/* log : Plane intersects with frustum : true */
