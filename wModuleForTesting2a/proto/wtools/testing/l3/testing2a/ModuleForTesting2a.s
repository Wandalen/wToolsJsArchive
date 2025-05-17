( function _ModuleForTesting2a_s_()
{

'use strict';

let _ = require( 'wmodulefortesting2' );

// --
// Routines
// --

function squareOfMul()
{
  let result = _.mulOfNumbers.apply( this, arguments );
  result = result * result;

  return result;
}

Object.assign( _, { squareOfMul } );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _;

})();


