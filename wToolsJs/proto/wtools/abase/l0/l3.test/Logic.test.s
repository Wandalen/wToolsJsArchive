( function _l0_l3_Logic_test_s()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( '../Include3.s' );
  require( 'wTesting' );
}

const _global = _global_;
const _ = _global_.wTools;
const __ = _globals_.testing.wTools;

// --
// dichotomy
// --

function basic( test )
{

  test.case = 'basic';
  var logic = new _.logic.node.And([ true, false ]);
  test.identical( _.logic.is( logic ), true );
  test.identical( _.logic.like( logic ), true );
  test.identical( logic.elements, [ true, false ] );
  test.identical( logic.elements.length, 2 );

}

//

function toStrStandard( test )
{

  /* */

  test.case = 'String( [ true, false ] )';
  var src = _.logic.and([ true, false ]);
  console.log( src );
  var got = String( src );
  var exp = `{- and with 2 elements -}`;
  test.identical( got, exp );

  /* */

  test.case = 'String( [] )';
  var src = _.logic.and([]);
  console.log( src );
  var got = String( src );
  var exp = `{- and with 0 elements -}`;
  test.identical( got, exp );

  /* */

  test.case = 'strTypeSecondary( and[ true, false ] )';
  var src = _.logic.and([ true, false ]);
  console.log( src );
  var exp = `LogicAnd`;
  test.identical( _.entity.strTypeSecondary( src ), exp );

  /* */

  test.case = 'strTypeSecondary( or[ true, false ] )';
  var src = _.logic.or([ true, false ]);
  console.log( src );
  var exp = `LogicOr`;
  test.identical( _.entity.strTypeSecondary( src ), exp );

  /* */

  test.case = 'strType([ true, false ])';
  var src = _.logic.and([ true, false ]);
  console.log( src );
  var exp = `LogicAnd.countable.constructible`;
  test.identical( _.entity.strType( src ), exp );

  /* */

  test.case = 'Object.prototype.toString([ true, false ])';
  var src = _.logic.and([ true, false ]);
  console.log( src );
  var got = Object.prototype.toString.call( src );
  var exp = '[object LogicAnd]';
  test.identical( got, exp );

  /* */

}

//

function is( test )
{

  test.case = 'string empty input';
  var got = _.logic.is( '' );
  test.identical( got, false );

  test.case = 'string input';
  var got = _.logic.is( 'hello' );
  test.identical( got, false );

  test.case = 'number 1 input';
  var got = _.logic.is( 1 );
  test.identical( got, false );

  test.case = 'number 0 input';
  var got = _.logic.is( 0 );
  test.identical( got, false );

  test.case = 'number negative input';
  var got = _.logic.is( -10 );
  test.identical( got, false );

  test.case = 'number positive input';
  var got = _.logic.is( 10 );
  test.identical( got, false );

  test.case = 'empty object input';
  var got = _.logic.is( {} );
  test.identical( got, false );

  test.case = 'object input';
  var got = _.logic.is( { name : 'a', age : 99 } );
  test.identical( got, false );

  test.case = 'empty array input';
  var got = _.logic.is( [] );
  test.identical( got, false );

  test.case = 'array input';
  var got = _.logic.is( [ 1, 2, 3 ] );
  test.identical( got, false );

  test.case = 'logic false input';
  var got = _.logic.is( false );
  test.identical( got, true );

  test.case = 'logic true input';
  var got = _.logic.is( true );
  test.identical( got, true );

  /* qqq2 : rewrite each similar test routine and extend */
  test.case = 'empty and';
  var src = _.logic.and([]);
  test.identical( _.logic.is( src ), true );

  test.case = 'populated and';
  var src = _.logic.and([ true, false ]);
  test.identical( _.logic.is( src ), true );

  test.case = 'empty or';
  var src = _.logic.or([]);
  test.identical( _.logic.is( src ), true );

  test.case = 'populated or';
  var src = _.logic.or([ true, false ]);
  test.identical( _.logic.is( src ), true );

}

//

/* qqq2 : join with is into single test routine dichotomy */
function like( test )
{
  test.case = 'string empty input';
  var got = _.logic.like( '' );
  test.identical( got, false );

  test.case = 'string input';
  var got = _.logic.like( 'hello' );
  test.identical( got, false );

  test.case = 'string number';
  var got = _.logic.like( '1' );
  test.identical( got, false );

  test.case = 'number 1 input';
  var got = _.logic.like( 1 );
  test.identical( got, false );

  test.case = 'number 0 input';
  var got = _.logic.like( 0 );
  test.identical( got, false );

  test.case = 'number negative input';
  var got = _.logic.like( -10 );
  test.identical( got, false );

  test.case = 'number positive input';
  var got = _.logic.like( 10 );
  test.identical( got, false );

  test.case = 'empty object input';
  var got = _.logic.like( {} );
  test.identical( got, false );

  test.case = 'object input';
  var got = _.logic.like( { name : 'a', age : 99 } );
  test.identical( got, false );

  test.case = 'empty array input';
  var got = _.logic.like( [] );
  test.identical( got, false );

  test.case = 'array input';
  var got = _.logic.like( [ 1, 2, 3 ] );
  test.identical( got, false );

  test.case = 'logic false input';
  var got = _.logic.like( false );
  test.identical( got, true );

  test.case = 'logic true input';
  var got = _.logic.like( true );
  test.identical( got, true );

  test.case = 'empty and';
  var src = _.logic.and([]);
  test.identical( _.logic.like( src ), true );

  test.case = 'populated and';
  var src = _.logic.and([ true, false ]);
  test.identical( _.logic.like( src ), true );

  test.case = 'empty or';
  var src = _.logic.or([]);
  test.identical( _.logic.like( src ), true );

  test.case = 'populated or';
  var src = _.logic.or([ true, false ]);
  test.identical( _.logic.like( src ), true );

}

// --
//
// --

/* qqq : for junior : extend please */
function compare( test )
{

  test.case = 'true - true';
  var src1 = true;
  var src2 = true;
  test.identical( _.logic.equivalentShallow( src1, src2 ), true );
  test.identical( _.logic.equivalent( src1, src2 ), true );
  test.identical( _.logic.identicalShallow( src1, src2 ), true );
  test.identical( _.logic.identical( src1, src2 ), true );

  test.case = 'undefined - undefined';
  var src1 = undefined;
  var src2 = undefined;
  test.identical( _.logic.equivalentShallow( src1, src2 ), false );
  test.identical( _.logic.equivalent( src1, src2 ), false );
  test.identical( _.logic.identicalShallow( src1, src2 ), false );
  test.identical( _.logic.identical( src1, src2 ), false );

  test.case = 'null - undefined';
  var src1 = null;
  var src2 = undefined;
  test.identical( _.logic.equivalentShallow( src1, src2 ), false );
  test.identical( _.logic.equivalent( src1, src2 ), false );
  test.identical( _.logic.identicalShallow( src1, src2 ), false );
  test.identical( _.logic.identical( src1, src2 ), false );

  test.case = 'map - array';
  var src1 = {};
  var src2 = [];
  test.identical( _.logic.equivalentShallow( src1, src2 ), false );
  test.identical( _.logic.equivalent( src1, src2 ), false );
  test.identical( _.logic.identicalShallow( src1, src2 ), false );
  test.identical( _.logic.identical( src1, src2 ), false );

  test.case = 'false - false';
  var got = _.logic.equivalentShallow( false, false );
  test.identical( got, true );

  test.case = '1 - true';
  var got = _.logic.equivalentShallow( 1, true );
  test.identical( got, false );

  test.case = '0 - false';
  var got = _.logic.equivalentShallow( 0, false );
  test.identical( got, false );

  test.case = '1 - 1';
  var got = _.logic.equivalentShallow( 1, 1 );
  test.identical( got, false );

  test.case = '0 - 0';
  var got = _.logic.equivalentShallow( 1, 1 );
  test.identical( got, false );

  /* */

  test.case = 'true - false';
  var got = _.logic.equivalentShallow( true, false );
  test.identical( got, false );

  test.case = '1 - false';
  var got = _.logic.equivalentShallow( 1, false );
  test.identical( got, false );

  test.case = '0 - true';
  var got = _.logic.equivalentShallow( 0, true );
  test.identical( got, false );

  test.case = '1 - 0';
  var got = _.logic.equivalentShallow( 1, 0 );
  test.identical( got, false );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( () => _.logic.equivalentShallow() );

  test.case = 'too many args';
  test.shouldThrowErrorSync( () => _.logic.equivalentShallow( true, true, true, true ) );

}

//

function andExec( test )
{

  /* */

  test.case = 'and()';
  var src = _.logic.and([]);
  test.identical( src.exec(), true );
  test.identical( _.logic.exec( src ), true );

  /* */

  test.case = 'and( true )';
  var src = _.logic.and([ true ]);
  test.identical( src.exec(), true );
  test.identical( _.logic.exec( src ), true );

  /* */

  test.case = 'and( true, true )';
  var src = _.logic.and([ true, true ]);
  test.identical( src.exec(), true );
  test.identical( _.logic.exec( src ), true );

  /* */

  test.case = 'and( false )';
  var src = _.logic.and([ false ]);
  test.identical( src.exec(), false );
  test.identical( _.logic.exec( src ), false );

  /* */

  test.case = 'and( false, false )';
  var src = _.logic.and([ false, false ]);
  test.identical( src.exec(), false );
  test.identical( _.logic.exec( src ), false );

  /* */

  test.case = 'and( true, false )';
  var src = _.logic.and([ true, false ]);
  test.identical( src.exec(), false );
  test.identical( _.logic.exec( src ), false );

  /* */

  test.case = 'and( false, true )';
  var src = _.logic.and([ false, true ]);
  test.identical( src.exec(), false );
  test.identical( _.logic.exec( src ), false );

  /* */

  test.case = 'and( true, true, true )';
  var src = _.logic.and([ true, true, true ]);
  test.identical( src.exec(), true );
  test.identical( _.logic.exec( src ), true );

  /* */

  test.case = 'and( false, false, false )';
  var src = _.logic.and([ false, false, false ]);
  test.identical( src.exec(), false );
  test.identical( _.logic.exec( src ), false );

  /* */

}

//

function orExec( test )
{

  /* */

  test.case = 'or()';
  var src = _.logic.or([]);
  test.identical( src.exec(), false );
  test.identical( _.logic.exec( src ), false );

  /* */

  test.case = 'or( true )';
  var src = _.logic.or([ true ]);
  test.identical( src.exec(), true );
  test.identical( _.logic.exec( src ), true );

  /* */

  test.case = 'or( true, true )';
  var src = _.logic.or([ true, true ]);
  test.identical( src.exec(), true );
  test.identical( _.logic.exec( src ), true );

  /* */

  test.case = 'or( false )';
  var src = _.logic.or([ false ]);
  test.identical( src.exec(), false );
  test.identical( _.logic.exec( src ), false );

  /* */

  test.case = 'or( false, false )';
  var src = _.logic.or([ false, false ]);
  test.identical( src.exec(), false );
  test.identical( _.logic.exec( src ), false );

  /* */

  test.case = 'or( true, false )';
  var src = _.logic.or([ true, false ]);
  test.identical( src.exec(), true );
  test.identical( _.logic.exec( src ), true );

  /* */

  test.case = 'or( false, true )';
  var src = _.logic.or([ false, true ]);
  test.identical( src.exec(), true );
  test.identical( _.logic.exec( src ), true );

  /* */

  test.case = 'or( true, true, true )';
  var src = _.logic.or([ true, true, true ]);
  test.identical( src.exec(), true );
  test.identical( _.logic.exec( src ), true );

  /* */

  test.case = 'or( false, false, false )';
  var src = _.logic.or([ false, false, false ]);
  test.identical( src.exec(), false );
  test.identical( _.logic.exec( src ), false );

  /* */

}

// xxx
// //
//
// function xandExec( test )
// {
//
//   /* */
//
//   test.case = 'xand()';
//   var src = _.logic.xand([]);
//   test.identical( src.exec(), true );
//   test.identical( _.logic.exec( src ), true );
//
//   /* */
//
//   test.case = 'xand( true )';
//   var src = _.logic.xand([ true ]);
//   test.identical( src.exec(), false );
//   test.identical( _.logic.exec( src ), false );
//
//   /* */
//
//   test.case = 'xand( true, true )';
//   var src = _.logic.xand([ true, true ]);
//   test.identical( src.exec(), true );
//   test.identical( _.logic.exec( src ), true );
//
//   /* */
//
//   test.case = 'xand( false )';
//   var src = _.logic.xand([ false ]);
//   test.identical( src.exec(), true );
//   test.identical( _.logic.exec( src ), true );
//
//   /* */
//
//   test.case = 'xand( false, false )';
//   var src = _.logic.xand([ false, false ]);
//   test.identical( src.exec(), true );
//   test.identical( _.logic.exec( src ), true );
//
//   /* */
//
//   test.case = 'xand( true, false )';
//   var src = _.logic.xand([ true, false ]);
//   test.identical( src.exec(), false );
//   test.identical( _.logic.exec( src ), false );
//
//   /* */
//
//   test.case = 'xand( false, true )';
//   var src = _.logic.xand([ false, true ]);
//   test.identical( src.exec(), false );
//   test.identical( _.logic.exec( src ), false );
//
//   /* */
//
//   test.case = 'xand( true, true, true )';
//   var src = _.logic.xand([ true, true, true ]);
//   test.identical( src.exec(), true );
//   test.identical( _.logic.exec( src ), true );
//
//   /* */
//
//   test.case = 'xand( false, false, false )';
//   var src = _.logic.xand([ false, false, false ]);
//   test.identical( src.exec(), true );
//   test.identical( _.logic.exec( src ), true );
//
//   /* */
//
// }
//
// //
//
// function xorExec( test )
// {
//
//   /* */
//
//   test.case = 'xor()';
//   var src = _.logic.xor([]);
//   test.identical( src.exec(), false );
//   test.identical( _.logic.exec( src ), false );
//
//   /* */
//
//   test.case = 'xor( true )';
//   var src = _.logic.xor([ true ]);
//   test.identical( src.exec(), true );
//   test.identical( _.logic.exec( src ), true );
//
//   /* */
//
//   test.case = 'xor( true, true )';
//   var src = _.logic.xor([ true, true ]);
//   test.identical( src.exec(), false );
//   test.identical( _.logic.exec( src ), false );
//
//   /* */
//
//   test.case = 'xor( false )';
//   var src = _.logic.xor([ false ]);
//   test.identical( src.exec(), false );
//   test.identical( _.logic.exec( src ), false );
//
//   /* */
//
//   test.case = 'xor( false, false )';
//   var src = _.logic.xor([ false, false ]);
//   test.identical( src.exec(), false );
//   test.identical( _.logic.exec( src ), false );
//
//   /* */
//
//   test.case = 'xor( true, false )';
//   var src = _.logic.xor([ true, false ]);
//   test.identical( src.exec(), true );
//   test.identical( _.logic.exec( src ), true );
//
//   /* */
//
//   test.case = 'xor( false, true )';
//   var src = _.logic.xor([ false, true ]);
//   test.identical( src.exec(), true );
//   test.identical( _.logic.exec( src ), true );
//
//   /* */
//
//   test.case = 'xor( true, true, true )';
//   var src = _.logic.xor([ true, true, true ]);
//   test.identical( src.exec(), true );
//   test.identical( _.logic.exec( src ), true );
//
//   /* */
//
//   test.case = 'xor( false, false, false )';
//   var src = _.logic.xor([ false, false, false ]);
//   test.identical( src.exec(), false );
//   test.identical( _.logic.exec( src ), false );
//
//   /* */
//
// }

// --
// declaration
// --

const Proto =
{

  name : 'Tools.Logic.l0.l3',
  silencing : 1,
  enabled : 1,

  tests :
  {

    basic,
    toStrStandard,
    is,
    like,

    compare,
    andExec,
    orExec,
    // xandExec,
    // xorExec,

  }

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();