
const _ = require( '../../../node_modules/Tools' );

_.include( 'wProcess' );
_.include( 'wFiles' );

_.process._exitHandlerRepair();

console.log( '1' );

setTimeout( f, 1000 );
for( let i = 0 ; i < 9999 ; i++ )
_.fileProvider.fileRead( __filename );

console.log( '2' );

function f()
{
  console.log( 'f' );
  setTimeout( f, 1000 );
}
