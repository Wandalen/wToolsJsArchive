
if( typeof module !== 'undefined' )
require( 'wTools' );
let _ = wTools;

var src = [ 0, [ 0, 1 ], [ 4, 4, 4, 0, [ 0, 9 ] ] ]
var r = _.arrayFlattenOnce( null, [ 1, [ 1 ], 0 ] )
console.log( r )
