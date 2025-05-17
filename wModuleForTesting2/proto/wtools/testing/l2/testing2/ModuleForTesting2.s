( function _ModuleForTesting2_s_()
{

'use strict';

const _ = require( '../../Common.s' );

// --
// Routines
// --

function mulOfNumbers()
{
  let result = Number( arguments[ 0 ] );
  for( let i = 1; i < arguments.length; i++ )
  result *= Number( arguments[ i ] );

  return result;
}

Object.assign( _, { mulOfNumbers } );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ].mulOfNumbers = mulOfNumbers;
module[ 'exports' ] = _;

})();
