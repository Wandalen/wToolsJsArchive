if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

debugger;

var box = null;
var pointOne = [ 0, 1 ];
var pointTwo =  [ 1, 0 ] ;
var pointThree = [ 0, - 1 ];
var pointFour = [ - 1, 0 ];
var pointFive = [ 0, 0 ];
var points = [ pointOne, pointTwo, pointThree, pointFour, pointFive ]

var dim = points[0].length;
console.log( 'dim :', dim );

if( box === null )
//var dimp = points[0].length;
box = _.box.makeSingular(dim);

console.log( 'box centered :', box );

_.box.fromPoints( box, points );

console.log( 'P1 :', pointOne );
console.log( 'P2 :', pointTwo );
console.log( 'P3 :', pointThree );
console.log( 'P4 :', pointFour );
console.log( 'P5 :', pointFive );
console.log( 'box centered :', box );
