( function _Base_s_()
{

'use strict';

/* GitPath */

if( typeof module !== 'undefined' )
{
  const _ = require( '../../../../../node_modules/Tools' );

  _.include( 'wUriBasic' );
  _.include( 'wStringsExtra' );
  _.include( 'wFilesBasic' );

  module[ 'exports' ] = _global_.wTools;
}

})();
