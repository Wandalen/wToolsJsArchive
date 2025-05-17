( function _l0_l1_Logic_test_s()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( '../Include1.s' );
  require( 'wTesting' );
}

const _global = _global_;
const _ = _global_.wTools;
const __ = _globals_.testing.wTools;

//--
//
//--

function bulky( test )
{
  test.true( _.logic.is( true ) );
}

// --
// declaration
// --

const Proto =
{

  name : 'Tools.Logic.l0.l1',
  silencing : 1,
  enabled : 1,

  tests :
  {

    bulky,

  }

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
