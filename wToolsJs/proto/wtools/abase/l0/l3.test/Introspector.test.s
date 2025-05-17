( function _l0_l3_Introspector_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  require( '../Include3.s' );
  require( 'wTesting' );
}

const _global = _global_;
const _ = _global_.wTools;
const __ = _globals_.testing.wTools;
const fileProvider = __.fileProvider;
const path = fileProvider.path;

// --
// tests
// --

function bulky( test )
{
  test.true( _.aux.is( _.introspector ) );
}

// --
// declare
// --

const Proto =
{

  name : 'Tools.Introspector.l0.l3',
  silencing : 1,

  context :
  {
  },

  tests :
  {
    bulky,
  }

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
