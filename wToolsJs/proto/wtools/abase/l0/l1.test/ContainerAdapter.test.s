( function _l0_l1_ContainerAdapter_test_s()
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

function dichotomy( test )
{

  /* */

  test.case = 'undefined';
  var src = undefined;
  test.false( _.containerAdapter.is( src ) );
  test.false( _.containerAdapter.like( src ) );
  test.false( _.containerAdapter.isContainer( src ) );
  test.false( _.containerAdapter.setLike( src ) );
  test.false( _.containerAdapter.longLike( src ) );

  /* */

  test.case = 'null';
  var src = null;
  test.false( _.containerAdapter.is( src ) );
  test.false( _.containerAdapter.like( src ) );
  test.false( _.containerAdapter.isContainer( src ) );
  test.false( _.containerAdapter.setLike( src ) );
  test.false( _.containerAdapter.longLike( src ) );

  /* */

  test.case = 'number';
  var src = 13;
  test.false( _.containerAdapter.is( src ) );
  test.false( _.containerAdapter.like( src ) );
  test.false( _.containerAdapter.isContainer( src ) );
  test.false( _.containerAdapter.setLike( src ) );
  test.false( _.containerAdapter.longLike( src ) );

  /* */

  test.case = 'string';
  var src = 'str';
  test.false( _.containerAdapter.is( src ) );
  test.false( _.containerAdapter.like( src ) );
  test.false( _.containerAdapter.isContainer( src ) );
  test.false( _.containerAdapter.setLike( src ) );
  test.false( _.containerAdapter.longLike( src ) );

  /* */

  test.case = 'set';
  var src = new Set;
  test.false( _.containerAdapter.is( src ) );
  test.false( _.containerAdapter.like( src ) );
  test.true( _.containerAdapter.isContainer( src ) );
  test.true( _.containerAdapter.setLike( src ) );
  test.false( _.containerAdapter.longLike( src ) );

  /* */

  test.case = 'array';
  var src = [];
  test.false( _.containerAdapter.is( src ) );
  test.false( _.containerAdapter.like( src ) );
  test.true( _.containerAdapter.isContainer( src ) );
  test.false( _.containerAdapter.setLike( src ) );
  test.true( _.containerAdapter.longLike( src ) );

  /* */

}

// --
// declaration
// --

const Proto =
{

  name : 'Tools.ContainerAdapter.l0.l1',
  silencing : 1,
  enabled : 1,

  tests :
  {

    dichotomy,

  }

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
