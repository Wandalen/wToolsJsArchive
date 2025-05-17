( function _Collection_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( 'Tools' );
  _.include( 'wTesting' );
}

const _global = _global_;
const _ = _global_.wTools;

// --
// implement
// --

function basic( test )
{
  test.true( true );
}

// --
// declare
// --

const Proto =
{

  name : 'Tools.Collection.l1',
  silencing : 1,
  enabled : 1,

  tests :
  {
    basic,
  }

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
