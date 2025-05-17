let _ = require( 'wTools' );

var src = [ 0, [ 0, 1 ], [ 4, 4, 4, 0, [ 0, 9 ] ] ];
var r = _.arrayFlattenOnce( null, src );
console.log( `Source array : ${ src }` );
// log : Source array : [ 0, [ 0, 1 ], [ 4, 4, 4, 0, [ 0, 9 ] ] ]
console.log( `Resulted array : ${ r }` );
// log : Resulted array : [ 0, 1, 4, 9 ]
