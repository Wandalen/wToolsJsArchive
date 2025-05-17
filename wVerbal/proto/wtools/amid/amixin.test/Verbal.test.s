( function _Verbal_test_s_( )
{

'use strict';

/*
qqq : implement tests for mixin vebal
*/

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../node_modules/Tools' );

  _.include( 'wTesting' );

  require( '../amixin/Verbal.s' );

}

const _ = _global_.wTools;

//

function trivial( test )
{

  test.identical( 1, 1 );

}

//

const Proto =
{

  name : 'Tools.mid.mixin.Verbal',
  silencing : 1,
  // verbosity : 1,

  tests :
  {
    trivial,
  },

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
