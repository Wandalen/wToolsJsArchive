
let _ = require( 'wmathgeometric' );

/**/

// var pair1 = [ [ 0, 0 ], [ 10, 10 ] ];
// var pair2 = [ [ 10, 0 ], [ 0, 10 ] ];
var matrix = [ 0, 1, 2, 3 ];
var y = [ 10, 11 ];

// console.log( 'pair1:', pair1 );
// console.log( 'pair2:', pair1 );

// var intersection = _.math.pairPairIntersectionPoint( pair1, pair2 ); /* Moved */
var result = _.math.d2linearEquationSolve( matrix, y )

console.log( 'result:', result );
/* log : result: : [ -4, 5 ] */
