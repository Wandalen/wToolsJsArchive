( function _Img_s_( )
{

'use strict';

/**
 * Standardized abstract interface to open / read / parse image with collection of plugins. Aggregates module Image.
 * @module Tools/mid/Img
 */

if( typeof module !== 'undefined' )
{
  const _ = require( '../include/Img.s' )
  module[ 'exports' ] = _global_.wTools;
}

})();
