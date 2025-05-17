( function _Scalar_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../../../node_modules/Tools' );

  const _ = _global_.wTools;

  _.include( 'wTesting' );

  require( '../l1/Scalar.s' );

}

//

const _ = _global_.wTools.withLong.Fx;
const Parent = wTester;

// --
// test
// --

function isPowerOfTwo( test )
{
  test.case = 'zero'
  test.false( _.math.isPowerOfTwo( 0 ) );

  test.case = '2^2-1'
  test.false( _.math.isPowerOfTwo( Math.pow( 2, 4 ) - 1 ) );

  test.case = '2^4-1'
  test.false( _.math.isPowerOfTwo( Math.pow( 2, 4 ) - 1 ) );

  test.case = '2^8-1'
  test.false( _.math.isPowerOfTwo( Math.pow( 2, 8 ) - 1 ) );

  test.case = '2^16-1'
  test.false( _.math.isPowerOfTwo( Math.pow( 2, 16 ) - 1 ) );

  test.case = '2^32-1'
  test.false( _.math.isPowerOfTwo( Math.pow( 2, 32 ) - 1 ) );

  /* */

  for( let n = 0; n <= 32; n++ )
  {
    test.case = `2^${n}`;
    let src = Math.pow( 2, n );
    test.true( _.math.isPowerOfTwo( src ) );
  }

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.math.isPowerOfTwo( null ) )
}

//

function fract( test )
{

  test.case = 'half';
  test.equivalent( _.math.fract( 1.5 ) , 0.5 );

  test.case = 'less than half';
  test.equivalent( _.math.fract( 2.1 ) , 0.1 );

  test.case = 'more then half';
  test.equivalent( _.math.fract( 3.9 ) , 0.9 );

  test.case = 'exactly';
  test.equivalent( _.math.fract( 4.0 ) , 0.0 );

  test.case = 'negative half';
  test.equivalent( _.math.fract( -1.5 ) , 0.5 );

  test.case = 'negative less than half';
  test.equivalent( _.math.fract( -2.1 ) , 0.9 );

  test.case = 'negative more then half';
  test.equivalent( _.math.fract( -3.9 ) , 0.1 );

  test.case = 'negative exactly';
  test.equivalent( _.math.fract( -4.0 ) , 0.0 );

  test.case = 'zero';
  test.equivalent( _.math.fract( 0 ) , 0.0 );

  test.case = 'two decimals';
  test.equivalent( _.math.fract( 2.15 ) , 0.15 );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.math.fract();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.math.fract( 'x' );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.math.fract( [] );
  });

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( function()
  {
    _.math.fract( 1, 3 );
  });

}

//

function factorial( test )
{

  test.case = '1!';
  test.equivalent( _.math.factorial( 1 ) , 1 );

  test.case = '2!';
  test.equivalent( _.math.factorial( 2 ) , 2 );

  test.case = '3!';
  test.equivalent( _.math.factorial( 3 ) , 6 );

  test.case = '4!';
  test.equivalent( _.math.factorial( 4 ) , 24 );

  test.case = '5!';
  test.equivalent( _.math.factorial( 5 ) , 120 );

  test.case = '10!';
  test.equivalent( _.math.factorial( 10 ) , 3628800 );

  test.case = 'zero';
  test.equivalent( _.math.factorial( 0 ), 1 );


  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.math.factorial();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.math.factorial( 'x' );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.math.factorial( [] );
  });

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( function()
  {
    _.math.factorial( 1, 3 );
  });

  test.case = 'negative argument';
  test.shouldThrowErrorSync( function()
  {
    _.math.factorial( -4 );
  });

  test.case = 'not integer, lower 1';
  test.shouldThrowErrorSync( function()
  {
    _.math.factorial( 0.3 );
  });

  test.case = 'not integer, more 1';
  test.shouldThrowErrorSync( function()
  {
    _.math.factorial( 1.3 );
  });

}

//

function fibonacci( test )
{

  test.case = '0';
  var exp = 0;
  var got = _.math.fibonacci( 0 );
  test.equivalent( got, exp );

  test.case = '1';
  var exp = 1;
  var got = _.math.fibonacci( 1 );
  test.equivalent( got, exp );

  test.case = '2';
  var exp = 1;
  var got = _.math.fibonacci( 2 );
  test.equivalent( got, exp );

  test.case = '3';
  var exp = 2;
  var got = _.math.fibonacci( 3 );
  test.equivalent( got, exp );

  test.case = '4';
  var exp = 3;
  var got = _.math.fibonacci( 4 );
  test.equivalent( got, exp );

  test.case = '5';
  var exp = 5;
  var got = _.math.fibonacci( 5 );
  test.equivalent( got, exp );

  test.case = '6';
  var exp = 8;
  var got = _.math.fibonacci( 6 );
  test.equivalent( got, exp );

  /* */

  if( !Config.debug )
  return;

  test.case = 'negative';
  test.shouldThrowErrorSync( () => _.math.fibonacci( -1 ) );

}

//

function roundToPowerOfTwo( test )
{

  test.case = 'roundToPowerOfTwo: 1';
  test.equivalent( _.math.roundToPowerOfTwo( 1 ) , 1 );

  test.case = 'roundToPowerOfTwo: 127';
  test.equivalent( _.math.roundToPowerOfTwo( 127 ) , 128 );

  test.case = 'roundToPowerOfTwo: 127.5';
  test.equivalent( _.math.roundToPowerOfTwo( 127.5 ) , 128 );

  test.case = 'roundToPowerOfTwo: 11';
  test.equivalent( _.math.roundToPowerOfTwo( 11 ) , 8 );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.math.roundToPowerOfTwo();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.math.roundToPowerOfTwo( 'x' );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.math.roundToPowerOfTwo( [] );
  });

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( function()
  {
    _.math.roundToPowerOfTwo( 1, 3 );
  });

  test.case = 'negative argument';
  test.shouldThrowErrorSync( function()
  {
    _.math.roundToPowerOfTwo( -4 );
  });

}

//

function ceilToPowerOfTwo( test )
{

  test.case = 'ceilToPowerOfTwo: 127';
  test.equivalent( _.math.ceilToPowerOfTwo( 127 ) , 128 );

  test.case = 'ceilToPowerOfTwo: 127.5';
  test.equivalent( _.math.ceilToPowerOfTwo( 127.5 ) , 128 );

  test.case = 'ceilToPowerOfTwo: 15';
  test.equivalent( _.math.ceilToPowerOfTwo( 15 ) , 16 );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.math.ceilToPowerOfTwo();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.math.ceilToPowerOfTwo( 'x' );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.math.ceilToPowerOfTwo( [] );
  });

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( function()
  {
    _.math.ceilToPowerOfTwo( 1, 3 );
  });

  test.case = 'negative argument';
  test.shouldThrowErrorSync( function()
  {
    _.math.ceilToPowerOfTwo( -4 );
  });

}

//

function floorToPowerOfTwo( test )
{

  test.case = 'floorToPowerOfTwo: 19';
  test.equivalent( _.math.floorToPowerOfTwo( 19 ) , 16 );

  test.case = 'floorToPowerOfTwo: 31.9';
  test.equivalent( _.math.floorToPowerOfTwo( 31.9 ) , 16 );

  test.case = 'floorToPowerOfTwo: 0';
  test.equivalent( _.math.floorToPowerOfTwo( 0 ) , 0 );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.math.floorToPowerOfTwo();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.math.floorToPowerOfTwo( 'x' );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.math.floorToPowerOfTwo( [] );
  });

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( function()
  {
    _.math.floorToPowerOfTwo( 1, 3 );
  });

  test.case = 'negative argument';
  test.shouldThrowErrorSync( function()
  {
    _.math.floorToPowerOfTwo( -4 );
  });

}

//

function experiment( test )
{
  /*
   *  Why does it show an error for the decimal argument if there i no requirement in the code for it to be integer (even if it should)?
   */

  if( !Config.debug )
  return;

  test.case = 'decimal argument';
  test.shouldThrowErrorSync( function()
  {
    debugger;
    _.math.factorial( 2.5 )
  });

}

// --
// declare
// --

const Proto =
{

  name : 'Tools.Math.Scalar',
  silencing : 1,

  tests :
  {

    isPowerOfTwo,

    fract,
    factorial,
    fibonacci,

    roundToPowerOfTwo,
    ceilToPowerOfTwo,
    floorToPowerOfTwo,

    experiment,

  },

};

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
