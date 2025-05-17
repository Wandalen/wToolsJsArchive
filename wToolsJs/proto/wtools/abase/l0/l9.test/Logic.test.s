( function _l0_l9_Logic_test_s()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( 'Tools' );
  _.include( 'wTesting' );
}

const _global = _global_;
const _ = _global_.wTools;
const __ = _globals_.testing.wTools;

//--
// l0/l8/Logic.s
//--

function bulky( test )
{
  test.true( true );
}

// --
// declaration
// --

const Proto =
{

  name : 'Tools.Logic.l0.l9',
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
