(function _UseTop_s_() {

'use strict';

/**
  @module Tools/mid/Files - Collection of classes to abstract files systems. Many interfaces provide files, but not called as file systems and treated differently. For example server-side gives access to local files and browser-side HTTP/HTTPS protocol gives access to files as well, but in the very different way, it does the first. This problem forces a developer to break fundamental programming principle DRY and make code written to solve a problem not applicable to the same problem, on another platform/technology. Files treats any file-system-like interface as files system. Files combines all files available to the application into the single namespace where each file has unique Path/URI, so that operating with several files on different files systems is not what user of the module should worry about. If Files does not have an adapter for your files system you may design it providing a short list of stupid methods fulfilling completely or partly good defined API and get access to all sophisticated general algorithms on files for free. Who said files is only externals? Files makes possible to treat internals of a program as files system(s). Use the module to keep DRY.
*/

/**
 * @file files/UseTop.s.
 */

if( typeof module !== 'undefined' )
{

  require( './UseMid.s' );

  var _ = _global_.wTools;

  /* l5 */

  require( './l5_provider/Extract.s' );
  if( Config.platform === 'nodejs' )
  require( './l5_provider/HardDrive.ss' );
  if( Config.platform === 'nodejs' )
  require( './l5_provider/Url.ss' );
  if( Config.platform === 'browser' )
  require( './l5_provider/Url.js' );
  if( Config.platform === 'browser' )
  require( './l5_provider/HtmlDocument.js' );

  /* l7 */

  require( './l7/Hub.s' );

  /* l8 */

  try { require( './l8_filter/Caching.s' ); } catch( err ) {}
  try { require( './l8_filter/CachingContent.s' ); } catch( err ) {}
  try { require( './l8_filter/CachingFolders.s' ); } catch( err ) {}
  try { require( './l8_filter/Reroot.s' ); } catch( err ) {}

  _.path.currentAtBegin = _.path.current();

}

var _global = _global_;
var _ = _global_.wTools;
var FileRecord = _.FileRecord;
var Self = _global_.wTools;

// --
// declare
// --

var Proto =
{
}

//

_.mapExtend( Self,Proto );

// --
// export
// --

if( typeof module !== 'undefined' )
if( _global_.WTOOLS_PRIVATE )
delete require.cache[ module.id ];

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
