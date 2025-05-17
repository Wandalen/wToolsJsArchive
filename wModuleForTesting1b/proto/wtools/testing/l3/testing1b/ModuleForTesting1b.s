( function _ModuleForTesting1b_s_()
{

'use strict';

let _ = require( '../../Common.s' );

// --
// Routines
// --

function squareRootOfSum()
{
  let result = _.sumOfNumbers.apply( this, arguments );
  result = Math.sqrt( result );

  return result;
}

Object.assign( _, { squareRootOfSum } );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ].squareRootOfSum = squareRootOfSum;
module[ 'exports' ] = _;

})();


