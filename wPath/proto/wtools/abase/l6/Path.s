//#! /usr/bin/env node
(function _Path_s_()
{

'use strict';

/**
 * Tools to manipulate path. Aggregates modules PathBasic and PathTools. Module Path leverages parsing, joining, extracting, normalizing, nativizing, resolving paths... Use the module to get uniform experience from playing with paths on different platforms.
 * @module Tools/base/Path
*/

if( typeof module !== 'undefined' )
{
  const _ = require( 'Tools' );

  _.include( 'wPathBasic' );
  _.include( 'wPathTools' );
}

const _global = _global_;
const _ = _global_.wTools;
const Self = _global_.wTools;

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

})();
