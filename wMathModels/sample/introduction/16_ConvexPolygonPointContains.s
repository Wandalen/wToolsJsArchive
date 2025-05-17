if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var point = [ 0, 1 ];
var vertices =
[
  1, 0, 0,
  0, 0, 1
];
var polygon = _.convexPolygon.make( vertices, 2 );
var contains = _.convexPolygon.pointContains( polygon, point );
console.log( `Polygon contains point : ${ contains }` );
/* log : Polygon contains point : true */
