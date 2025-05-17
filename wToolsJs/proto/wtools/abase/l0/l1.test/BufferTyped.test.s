( function _l0_l1_BufferTyped_test_s_()
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
// declaration
// --

function is( test )
{
  isTemplate( { method : 'is' } );
  isTemplate( { method : 'isSlow' } );
  isTemplate( { method : 'isUsingGetPrototype' } );
  isTemplate( { method : 'isUsingGetPrototypeWithFunctor' } );
  isTemplate( { method : 'isUsingExistenceOfField' } );
  isTemplate( { method : 'isUsingSet' } );
  isTemplate( { method : 'isUsingHashMap' } );
  isTemplate( { method : 'isUsingMap' } );

  function isTemplate( env )
  {
    test.case = `${__.entity.exportStringSolo( env )}, BigUint64Array`;
    var got = _.bufferTyped[ env.method ]( new U64x( 10 ) );
    var expected = true;
    test.identical( got, expected );

    test.case = `${__.entity.exportStringSolo( env )}, Uint32Array`;
    var got = _.bufferTyped[ env.method ]( new U32x( 10 ) );
    var expected = true;
    test.identical( got, expected );

    test.case = `${__.entity.exportStringSolo( env )}, Uint16Array`;
    var got = _.bufferTyped[ env.method ]( new U16x( 10 ) );
    var expected = true;
    test.identical( got, expected );

    test.case = `${__.entity.exportStringSolo( env )}, Uint8Array`;
    var got = _.bufferTyped[ env.method ]( new U8x( 10 ) );
    var expected = true;
    test.identical( got, expected );

    test.case = `${__.entity.exportStringSolo( env )}, Uint8ClampedArray`;
    var got = _.bufferTyped[ env.method ]( new U8xClamped( 10 ) );
    var expected = true;
    test.identical( got, expected );

    test.case = `${__.entity.exportStringSolo( env )}, Big int 64 array`;
    var got = _.bufferTyped[ env.method ]( new I64x( 10 ) );
    var expected = true;
    test.identical( got, expected );

    test.case = `${__.entity.exportStringSolo( env )}, Int32Array`;
    var got = _.bufferTyped[ env.method ]( new I32x( 10 ) );
    var expected = true;
    test.identical( got, expected );

    test.case = `${__.entity.exportStringSolo( env )}, Int16Array`;
    var got = _.bufferTyped[ env.method ]( new I16x( 10 ) );
    var expected = true;
    test.identical( got, expected );

    test.case = `${__.entity.exportStringSolo( env )}, Int8Array`;
    var got = _.bufferTyped[ env.method ]( new I8x( 10 ) );
    var expected = true;
    test.identical( got, expected );

    test.case = `${__.entity.exportStringSolo( env )}, Float64Array`;
    var got = _.bufferTyped[ env.method ]( new F64x( 10 ) );
    var expected = true;
    test.identical( got, expected );

    test.case = `${__.entity.exportStringSolo( env )}, Float32Array`;
    var got = _.bufferTyped[ env.method ]( new F32x( 10 ) );
    var expected = true;
    test.identical( got, expected );

    test.case = `${__.entity.exportStringSolo( env )}, Buffer Node`;
    var got = _.bufferTyped[ env.method ]( BufferNode.alloc( 5 ) );
    var expected = false;
    test.identical( got, expected );

    test.case = `${__.entity.exportStringSolo( env )}, raw array buffer`;
    var got = _.bufferTyped[ env.method ]( new BufferRaw( 10 ) );
    var expected = false;
    test.identical( got, expected );

    test.case = `${__.entity.exportStringSolo( env )}, shared array buffer`;
    var got = _.bufferTyped[ env.method ]( new BufferRawShared( 1024 ) );
    var expected = false;
    test.identical( got, expected );

    test.case = `${__.entity.exportStringSolo( env )}, an array`;
    var got = _.bufferTyped[ env.method ]( [ 1, 2, 3 ] );
    var expected  = false;
    test.identical( got, expected );

    test.case = `${__.entity.exportStringSolo( env )}, arguments array`;
    var got = _.bufferTyped[ env.method ]( arguments );
    var expected = false;
    test.identical( got, expected );

    test.case = `${__.entity.exportStringSolo( env )}, a number`;
    var got = _.bufferTyped[ env.method ]( 1 );
    var expected = false;
    test.identical( got, expected );

    test.case = `${__.entity.exportStringSolo( env )}, an object`;
    var got = _.bufferTyped[ env.method ]( {} );
    var expected = false;
    test.identical( got, expected );

    test.case = `${__.entity.exportStringSolo( env )}, no argument`;
    var got = _.bufferTyped[ env.method ]();
    var expected  = false;
    test.identical( got, expected );

    test.case = `${__.entity.exportStringSolo( env )}, null`;
    var got = _.bufferTyped[ env.method ]( null );
    var expected  = false;
    test.identical( got, expected );

    test.case = `${__.entity.exportStringSolo( env )}, function`;
    var got = _.bufferTyped[ env.method ]( function() {} );
    var expected  = false;
    test.identical( got, expected );

    test.case = `${__.entity.exportStringSolo( env )}, string`;
    var got = _.bufferTyped[ env.method ]( 'x' );
    var expected  = false;
    test.identical( got, expected );

    test.case = `${__.entity.exportStringSolo( env )}, boolean`;
    var got = _.bufferTyped[ env.method ]( false );
    var expected  = false;
    test.identical( got, expected );
  }
}

//

function isPerformance( test )
{
  /*
    Average of 10 runs of 1 million iteration of 23 _.bufferTyped.is variations
    Values below are in seconds
    ╔═══════════════════╤═════╤══════╤═══════════════════╤══════════════════════════════╤═══════════════════════╤══════════╤══════════════╤══════════╗
    ║                   │  is │isSlow│isUsingGetPrototype│isUsingGetPrototypeWithFunctor│isUsingExistenceOfField│isUsingSet│isUsingHashMap│isUsingMap║
    ╟───────────────────┼─────┼──────┼───────────────────┼──────────────────────────────┼───────────────────────┼──────────┼──────────────┼──────────╢
    ║ **Njs : v10.24.1**│0.530│ 4.250│       0.685       │             0.700            │         1.432         │   4.266  │     4.215    │   3.414  ║
    ╟───────────────────┼─────┼──────┼───────────────────┼──────────────────────────────┼───────────────────────┼──────────┼──────────────┼──────────╢
    ║ **Njs : v14.17.0**│0.603│ 6.347│       0.671       │             0.675            │         1.418         │   5.597  │     5.573    │   4.682  ║
    ╟───────────────────┼─────┼──────┼───────────────────┼──────────────────────────────┼───────────────────────┼──────────┼──────────────┼──────────╢
    ║ **Njs : v15.14.0**│0.562│ 6.437│       0.627       │             0.584            │         1.318         │   5.572  │     5.558    │   4.520  ║
    ╟───────────────────┼─────┼──────┼───────────────────┼──────────────────────────────┼───────────────────────┼──────────┼──────────────┼──────────╢
    ║Kos : Njs : v12.9.1│0.789│ 7.937│       1.071       │             0.926            │         1.795         │   7.505  │     7.708    │   5.456  ║
    ╚═══════════════════╧═════╧══════╧═══════════════════╧══════════════════════════════╧═══════════════════════╧══════════╧══════════════╧══════════╝
  */

  debugger; /* eslint-disable-line no-debugger */
  var debugFlag = Config.debug;
  Config.debug = false;

  /* */

  isPerformanceTemplate( { method : 'is' } );
  isPerformanceTemplate( { method : 'isSlow' } );
  isPerformanceTemplate( { method : 'isUsingGetPrototype' } );
  isPerformanceTemplate( { method : 'isUsingGetPrototypeWithFunctor' } );
  isPerformanceTemplate( { method : 'isUsingExistenceOfField' } );
  isPerformanceTemplate( { method : 'isUsingSet' } );
  isPerformanceTemplate( { method : 'isUsingHashMap' } );
  isPerformanceTemplate( { method : 'isUsingMap' } );

  /* */

  function isPerformanceTemplate( data )
  {
    test.case = `${data.method}`;
    var took, time;
    var env = initializeVariables();

    time = _.time.now();
    for( let i = env.times; i > 0; i-- )
    {
      env.name = data.method;
      run( env );
    }
    took = __.time.spent( time );

    console.log( `${env.times} iterations of ${test.case} took : ${took} on ${process.version}` );
    test.identical( true, true );
  }

  /* */

  Config.debug = debugFlag;
  debugger; /* eslint-disable-line no-debugger */

  /* - */

  function initializeVariables()
  {
    var env = {};
    env.times = 1000000;
    env.bigUint64Array = new U64x( 10 );
    env.uint32Array = new U32x( 10 );
    env.uint16Array = new U16x( 10 );
    env.uint8Array = new U8x( 10 );
    env.uint8ClampedArray = new U8xClamped( 10 );
    env.bigInt64Array = new I64x( 10 );
    env.int32Array = new I32x( 10 );
    env.int16Array = new I16x( 10 );
    env.int8Array = new I8x( 10 );
    env.float64Array = new F64x( 10 );
    env.float32Array = new F32x( 10 );
    env.bufferNode = BufferNode.alloc( 5 );
    env.rawArrayBuffer = new BufferRaw( 10 );
    env.sharedArrayBuffer = new BufferRawShared( 1024 );
    env.nonEmptyArray = [ 1, 2, 3 ];
    env.anEmptyRoutine = new function() {};
    env.aString = 'x';
    env.aNumber = 1;
    env.aBoolean = false;
    env.anEmptyMap = {};
    env.aMapWithFieldBuffer = { buffer : [] };
    return env;
  }

  /**/

  function run( env )
  {
    _.bufferTyped[ env.name ]( env.bigUint64Array );
    _.bufferTyped[ env.name ]( env.uint32Array );
    _.bufferTyped[ env.name ]( env.uint16Array );
    _.bufferTyped[ env.name ]( env.uint8Array );
    _.bufferTyped[ env.name ]( env.uint8ClampedArray );
    _.bufferTyped[ env.name ]( env.bigInt64Array );
    _.bufferTyped[ env.name ]( env.int32Array );
    _.bufferTyped[ env.name ]( env.int16Array );
    _.bufferTyped[ env.name ]( env.int8Array );
    _.bufferTyped[ env.name ]( env.float64Array );
    _.bufferTyped[ env.name ]( env.float32Array );
    _.bufferTyped[ env.name ]( env.bufferNode );
    _.bufferTyped[ env.name ]( env.rawArrayBuffer );
    _.bufferTyped[ env.name ]( env.sharedArrayBuffer );
    _.bufferTyped[ env.name ]( env.nonEmptyArray );
    _.bufferTyped[ env.name ]( arguments );
    _.bufferTyped[ env.name ]( env.aNumber );
    _.bufferTyped[ env.name ]( env.anEmptyMap );
    _.bufferTyped[ env.name ]( env.aMapWithFieldBuffer );
    _.bufferTyped[ env.name ]();
    _.bufferTyped[ env.name ]( null );
    _.bufferTyped[ env.name ]( env.anEmptyRoutine );
    _.bufferTyped[ env.name ]( env.aString );
    _.bufferTyped[ env.name ]( env.aBoolean );
  }

}

isPerformance.timeOut = 1e7;
isPerformance.experimental = true;

// --
//
// --

const Proto =
{

  name : 'Tools.BufferTyped.l0.l1',
  silencing : 1,
  enabled : 1,

  tests :
  {

    is,
    isPerformance,

  }

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
