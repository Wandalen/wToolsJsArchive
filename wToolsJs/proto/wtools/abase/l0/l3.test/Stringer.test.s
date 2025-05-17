( function _l0_l3_Stringer_test_s_()
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
  test.true( _.aux.is( _.stringer ) );
}

// --
// declaration
// --

const Proto =
{

  name : 'Tools.Stringer.l0.l3',
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
