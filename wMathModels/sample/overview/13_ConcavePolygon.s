if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* */

var vertices =
[
  2,  6,  9,  5,
  1,  3,  2,  6
]
var polygon = _.concavePolygon.make( vertices, 2 );
var point = [ 3, 6 ]
var distance = _.concavePolygon.pointDistance( polygon, point );
console.log( `Distance from concave polygon to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from concave polygon to point : 1.7 */
console.log( `Type : ${ _.entity.strType( polygon ) }` );
/* log : Type : wMatrix */
