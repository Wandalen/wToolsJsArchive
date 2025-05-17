( function _ModuleForTesting2b_s_()
{

'use strict';

let _ = require( 'wmodulefortesting2' );

// --
// Routines
// --

function squareRootOfMul()
{
  let result = _.mulOfNumbers.apply( this, arguments );
  result = Math.sqrt( result );

  return result;
}

Object.assign( _, { squareRootOfMul } );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _;

})();


