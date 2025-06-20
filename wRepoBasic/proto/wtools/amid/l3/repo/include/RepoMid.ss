( function _Mid_s_()
{

'use strict';

/* GitTools */

if( typeof module !== 'undefined' )
{
  const _ = require( '../../../../../node_modules/Tools' );

  require( './RepoBasic.ss' );
  require( '../l1/Repo.s' );
  require( '../l3_provider/Git.s' );
  require( '../l3_provider/Github.s' );
  require( '../l3_provider/HardDrive.s' );
  require( '../l3_provider/Http.s' );
  require( '../l3_provider/Npm.s' );

  module[ 'exports' ] = _global_.wTools;
}

})();

