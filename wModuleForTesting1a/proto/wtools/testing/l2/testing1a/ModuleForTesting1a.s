( function _ModuleForTesting1a_s_()
{

'use strict';

const _ = require( '../../Common.s' );

// --
// Routines
// --

function squareOfSum()
{
  let result = _.sumOfNumbers.apply( this, arguments );
  result = result * result;

  return result;
}

//

Object.assign( _, { squareOfSum } );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _;

})();


