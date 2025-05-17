( function _l0_l9_Stringer_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( 'Tools' );;
  require( 'wTesting' );
}

const _global = _global_;
const _ = _global_.wTools;
const __ = _globals_.testing.wTools;

// --
// tests
// --

function basic( test )
{

  /* */

  test.case = 'basic';
  var it = _.stringer.it({ verbosity : 5 });
  test.identical( it.tab, '' );
  test.identical( it.dtab, '  ' );
  test.identical( it.tabLevel, 0 );
  test.identical( it.verbosity, 5 );
  var exp = {}
  test.identical( _.props.onlyOwn( _.prototype.each( it )[ 0 ] ), exp );
  var exp =
  {
    'verbosity' : 5,
    'dstNode' : [],
  }
  test.identical( _.props.onlyOwn( _.prototype.each( it )[ 1 ] ), exp );
  var exp = new Set([ 'dstNode', 'tab', 'verbosity', 'tabLevel', 'level' ]);
  test.identical( new Set( _.props.keys( _.props.onlyOwn( _.prototype.each( it )[ 2 ] ) ) ), exp );
  var exp = new Set([ 'dstNode', 'verbosity', 'Seeker', 'iterator', 'iterationPrototype', 'firstIterationPrototype' ]);
  test.identical( new Set( _.props.keys( _.props.onlyOwn( _.prototype.each( it )[ 3 ] ) ) ), exp );

  test.identical( _.prototype.each( it ).length, 5 );

  /* */

}

// --
// declaration
// --

const Proto =
{

  name : 'Tools.Stringer.l0.l9',
  silencing : 1,

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
