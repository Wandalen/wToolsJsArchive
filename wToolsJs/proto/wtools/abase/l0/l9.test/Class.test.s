( function _l0_l9_Class_test_s_()
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

// --
// tests
// --

function bulky( test )
{

  test.true( _.symbol.is( _.class.iteratorSymbol ) )

}

// --
//
// --

const Proto =
{

  name : 'Tools.Class.l0.l9',
  silencing : 1,

  tests :
  {

    bulky,

  }

};

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
