(function _UseFilesArchive_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

  var _ = _global_.wTools;

  _.include( 'wVerbal' );
  _.include( 'wFiles' );
  _.include( 'wStateStorage' );

  require( './l8_filter/Archive.s' );
  require( './l9/FilesArchive.s' );
  require( './l9/FilesGraph.s' );

}

var _global = _global_;
var _ = _global_.wTools;

// --
// export
// --

if( typeof module !== 'undefined' )
if( _global_.WTOOLS_PRIVATE )
delete require.cache[ module.id ];

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _;

})();
