( function _TreeMap_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( 'Tools' );
  require( '../l1/l1/TreeMap.s' );
  _.include( 'wTesting' );
}

const _ = _global_.wTools;
const __ = _globals_.testing.wTools;

// --
// write
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

  name : 'Tools.abse.TreeMap',
  silencing : 1,

  context :
  {
  },

  tests :
  {

    basic,

  }

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
