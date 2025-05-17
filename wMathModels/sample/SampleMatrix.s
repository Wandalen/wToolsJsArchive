if( typeof module !== 'undefined' )
require( 'wmathmodels' );

let _ = wTools;

let  m = _.Matrix.MakeSquare([
    1, 2, 3,
    2, 1, 2,
    0, 1, 2
  ]);
let  i = m.clone();
debugger;
console.log( m.triangulateLuNormalizing() );

i.invert( );
// console.log('m', m);
m = _.Matrix.From( m );
i = _.Matrix.From( i );

let r = _.Matrix.Mul( null,[ m, i ] );
// console.log( r )
