( function _l0_l1_Diagnostic_test_s_()
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
// tests
//--

function assertBasic( test )
{
  var err;

  test.case = 'assert pass condition';
  var got = _.assert( 5 !== 4 );
  test.identical( got, true );

  test.case = 'passed failure condition : should generates exception';
  try
  {
    _.assert( 5 === 4 )
  }
  catch( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );

  test.case = 'passed failure condition with passed message : should generates exception with message';
  try
  {
    _.assert( false, 'short error description' )
  }
  catch( e )
  {
    err = e;
  }
  test.identical( /short error description/.test( err.message ), true );

}

// --
//
// --

const Proto =
{

  name : 'Tools.Diagnostic.l0.l1',
  silencing : 1,
  enabled : 1,

  tests :
  {

    assertBasic,

  }

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
