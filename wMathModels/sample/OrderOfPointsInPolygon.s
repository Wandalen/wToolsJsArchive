if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

/* Sample checks order of polygon vertexes */

var vertices =
[
  2,  6,  9,  5,
  1, -1,  2,  6,
]
var polygon = _.convexPolygon.make( vertices, 2 );
var point = [ 6, 4 ];
var contains = _.convexPolygon.pointContains( polygon, point );
console.log( `Should contains if has counterclock-wise order : ${ contains }` );
/* log : Should contains if has counterclock-wise order : true */

var vertices =
[
  2,  5,  9,  6,
  1,  6,  2, -1,
]
var polygon = _.convexPolygon.make( vertices, 2 );
var point = [ 6, 4 ];
var contains = _.convexPolygon.pointContains( polygon, point );
console.log( `Should not contains if has counterclock-wise order : ${ contains }` );
/* log : Should not contains if has counterclock-wise order : false */

/* */

// var vertices =
// [
//   2,  6,  9,  5,
//   1,  3,  2,  6,
// ]
// var polygon = _.concavePolygon.make( vertices, 2 );
// var point = [ 6, 4 ];
// var contains = _.concavePolygon.pointContains( polygon, point );
// console.log( `Should contains if has counterclock-wise order : ${ contains }` );
// /* log : Should contains if has counterclock-wise order : true */
//
// var vertices =
// [
//   2,  5,  9,  6,
//   1,  6,  2,  3,
// ]
// var polygon = _.concavePolygon.make( vertices, 2 );
// var point = [ 6, 4 ];
// var contains = _.concavePolygon.pointContains( polygon, point );
// console.log( `Should not contains if has counterclock-wise order : ${ contains }` );
// /* log : Should not contains if has counterclock-wise order : false */

