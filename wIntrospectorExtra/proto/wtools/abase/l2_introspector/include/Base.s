( function _Base_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( '../../../../node_modules/Tools' );

  _.include( 'wIntrospectorBasic' );
  _.include( 'wFilesBasic' );

  module[ 'exports' ] = wTools;
}

})();
