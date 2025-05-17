( function _l0_l1_Seeker_test_s_()
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

// --
// tests
// --

function bulky( test )
{
  test.true( _.aux.is( _.seeker ) );
}

// --
// declaration
// --

const Proto =
{

  name : 'Tools.Seeker.l0.l1',
  silencing : 1,

  tests :
  {

    bulky,

  }

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
