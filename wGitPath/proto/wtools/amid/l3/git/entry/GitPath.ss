( function _GitTools_ss_()
{

'use strict';

/**
 * Collection of cross-platform routines to operate over git paths reliably and consistently. GitPath leverages parsing, normalizing, nativizing git paths. Use the module to get uniform experience from playing with paths on different platforms.
 * @module Tools/mid/GitPath
*/

if( typeof module !== 'undefined' )
{
  const _ = require( '../include/GitPathMid.ss' );
  module[ 'exports' ] = _global_.wTools;
}

})();
