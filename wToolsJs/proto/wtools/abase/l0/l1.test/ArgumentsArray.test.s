( function _l0_l1_ArgumentsArray_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  // const _ = require( 'Tools' );
  require( '../Include1.s' );
  require( 'wTesting' );
}

const _global = _global_;
const _ = _global_.wTools;
const __ = _globals_.testing.wTools;

//--
// tests
//--

function dichotomy( test )
{

  dichotomyTemplate( { method : 'is' } );
  dichotomyTemplate( { method : 'isOld' } );
  dichotomyTemplate( { method : 'isIterator' } );

  dichotomyTemplate( { method : 'like' } );
  dichotomyTemplate( { method : 'likeOld' } );
  dichotomyTemplate( { method : 'likeUnfolded' } ); /* qqq : for Rahul : bad : order of routines should be the same in all files */
  // dichotomyTemplate( { method : 'likeUsingIsFunctor' } );


  function dichotomyTemplate( env )
  {
    test.case = `${__.entity.exportStringSolo( env )}, argumentsArray from empty array`;
    var src = _.argumentsArray.make( [] );
    test.true( _.argumentsArray[ env.method ]( src ) );
    test.false( _.array.is( src ) );
    test.false( _.array.like( src ) );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, array`;
    var src = [ 1, 2, 3 ];
    if( env.method.startsWith( 'is' ) )
    test.false( _.argumentsArray[ env.method ]( src ) );
    if( env.method.startsWith( 'like' ) )
    test.true( _.argumentsArray[ env.method ]( src ) );
    test.true( _.array.is( src ) );
    test.true( _.array.like( src ) );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, argument object`;
    var src = arguments;
    test.true( _.argumentsArray[ env.method ]( src ) );
    test.false( _.array.is( src ) );
    test.false( _.array.like( src ) );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, array prototype`;
    var src = Array.prototype;
    if( env.method.startsWith( 'is' ) )
    test.false( _.argumentsArray[ env.method ]( src ) );
    if( env.method.startsWith( 'like' ) )
    test.true( _.argumentsArray[ env.method ]( src ) );
    test.true( _.array.is( src ) );
    test.true( _.array.like( src ) );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, string`;
    var src = 'string';
    test.false( _.argumentsArray[ env.method ]( src ) );
    test.false( _.array.is( src ) );
    test.false( _.array.like( src ) );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, typed array`;
    var src = new U64x( 10 );
    test.false( _.argumentsArray[ env.method ]( src ) );
    test.false( _.array.is( src ) );
    test.false( _.array.like( src ) );

    /* */

    test.case = `${__.entity.exportStringSolo( env )}, false array`;
    var src = { __proto__ : Array.prototype };
    test.false( _.argumentsArray[ env.method ]( src ) );
    test.false( _.array.is( src ) );
    test.false( _.array.like( src ) );
  }
}

//

function dichotomyPerformance( test )
{
  /* Average of 10 runs of 5 million ierations of 8 input variants
  ╔════════════════════════╤═════╤═════╤══════════════╤═════╤═══════╤════════════╗
  ║                        │  is │isOld│   isIterator │ like│likeOld│likeUnfolded║
  ╟────────────────────────┼─────┼─────┼──────────────┼─────┼───────┼────────────╢
  ║Windows-10-20H2, 10.24.1│1.191│1.169│    2.962     │1.113│1.629  │  1.109     ║
  ╟────────────────────────┼─────┼─────┼──────────────┼─────┼───────┼────────────╢
  ║Windows-10-20H2, 14.17.0│1.066│1.129│    2.849     │1.053│1.660  │  1.041     ║
  ╟────────────────────────┼─────┼─────┼──────────────┼─────┼───────┼────────────╢
  ║   Linux-Kos, 12.9.1    │1.227│1.218│    3.040     │1.174│ 1.891 │  1.226     ║
  ╚════════════════════════╧═════╧═════╧══════════════╧═════╧═══════╧════════════╝
  qqq : for Rahul : update the table
  */

  let a = test.assetFor( false );
  test.identical( true, true );
  programRoutine.meta = {}
  programRoutine.meta.locals = { methodMeasure, varsInit, run };
  let program = a.program( programRoutine );

  program.start( { args : [ 'is' ] } );
  program.start( { args : [ 'isOld' ] } );
  program.start( { args : [ 'isIterator' ] } );
  program.start( { args : [ 'like' ] } );
  program.start( { args : [ 'likeOld' ] } );
  program.start( { args : [ 'likeUnfolded' ] } );

  return a.ready;

  /* */

  function methodMeasure( env )
  {
    let _ = wTools;
    let __ = wTools;
    let took, time;
    Config.debug = false;
    env = varsInit( env );

    debugger; /* eslint-disable-line no-debugger */
    time = _.time.now();
    for( let i = env.times; i > 0; i-- )
    run( env );
    took = __.time.spent( time );
    console.log( `${env.times} iterations of ${env.method} took : ${took} on ${process.version}` );
    debugger; /* eslint-disable-line no-debugger */
  }

  /* */

  function varsInit( env )
  {
    let _ = wTools;
    let __ = wTools;
    env.times = 5000000;
    env.argumentArray = arguments;
    env.madeArgumentArray = _.argumentsArray.make( [] );
    env.anArray = [ 1, 2, 3 ];
    env.arrayProtoType = Array.prototype;
    env.aString = 'string';
    env.aTypedArray = new U64x( 10 );
    env.falseArray = { __proto__ : Array.prototype }
    return env;
  }

  /* */

  function run( env )
  {
    let _ = wTools;
    let __ = wTools;
    let r = [];
    r.push( _.argumentsArray[ env.method ]( env.argumentArray ) );
    r.push( _.argumentsArray[ env.method ]( env.madeArgumentArray ) );
    r.push( _.argumentsArray[ env.method ]( env.anArray ) );
    r.push( _.argumentsArray[ env.method ]( env.arrayProtoType ) );
    r.push( _.argumentsArray[ env.method ]( env.aString ) );
    r.push( _.argumentsArray[ env.method ]( env.aTypedArray ) );
    r.push( _.argumentsArray[ env.method ]( env.falseArray ) );
    r.push( _.argumentsArray[ env.method ]() );
    /* qqq : for Rahul : result should not be discarded. it distorts result of measurements */
    return r;
  }

  /* */

  function programRoutine()
  {
    const _ = require( toolsPath );
    methodMeasure({ method : process.argv[ 2 ] });
  }

}

dichotomyPerformance.timeOut = 1e7;
dichotomyPerformance.experimental = true;

//

function make( test )
{
  test.case = 'without arguments';
  var got = _.argumentsArray.make();
  var expected = [];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );

  test.case = 'src - null';
  var got = _.argumentsArray.make( null );
  var expected = [];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );

  test.case = 'src - number, zero';
  var got = _.argumentsArray.make( 0 );
  var expected = new Array( 0 );
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  test.case = 'src - number, src > 0';
  var got = _.argumentsArray.make( 3 );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  /* */

  test.case = 'src - empty array';
  var src = [];
  var got = _.argumentsArray.make( src );
  var expected = [];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  test.case = 'src - array with single element';
  var src = [ 0 ];
  var got = _.argumentsArray.make( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  test.case = 'src - array with several elements';
  var src = [ 1, 2, 3 ];
  var got = _.argumentsArray.make( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  /* */

  test.case = 'src - empty unroll';
  var src = _.unroll.make( [] );
  var got = _.argumentsArray.make( src );
  var expected = [];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  test.case = 'src - unroll with single element';
  var src = _.unroll.make( [ 0 ] );
  var got = _.argumentsArray.make( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  test.case = 'src - unroll with several elements';
  var src = _.unroll.make( [ 1, 2, 3 ] );
  var got = _.argumentsArray.make( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  /* */

  test.case = 'src - empty argumentsArray';
  var src = _.argumentsArray.make( [] );
  var got = _.argumentsArray.make( src );
  var expected = [];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  test.case = 'src - argumentsArray with single element';
  var src = _.argumentsArray.make( [ 0 ] );
  var got = _.argumentsArray.make( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  test.case = 'src - argumentsArray with several elements';
  var src = _.argumentsArray.make( [ 1, 2, 3 ] );
  var got = _.argumentsArray.make( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  /* */

  test.case = 'src - empty BufferTyped';
  var src = new U8x( [] );
  var got = _.argumentsArray.make( src );
  var expected = [];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  test.case = 'src - BufferTyped with single element';
  var src = new I16x( [ 0 ] );
  var got = _.argumentsArray.make( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  test.case = 'src - BufferTyped with several elements';
  var src = new F32x( [ 1, 2, 3 ] );
  var got = _.argumentsArray.make( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.argumentsArray.make( 1, 3 ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.argumentsArray.make( {} ) );
  test.shouldThrowErrorSync( () => _.argumentsArray.make( 'wrong' ) );
}

//

function from( test )
{
  test.case = 'src - null';
  var got = _.argumentsArray.from( null );
  var expected = [];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );

  test.case = 'src - number, zero';
  var got = _.argumentsArray.from( 0 );
  var expected = new Array( 0 );
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  test.case = 'src - number, src > 0';
  var got = _.argumentsArray.from( 3 );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  /* */

  test.case = 'src - empty array';
  var src = [];
  var got = _.argumentsArray.from( src );
  var expected = [];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  test.case = 'src - array with single element';
  var src = [ 0 ];
  var got = _.argumentsArray.from( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  test.case = 'src - array with several elements';
  var src = [ 1, 2, 3 ];
  var got = _.argumentsArray.from( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  /* */

  test.case = 'src - empty unroll';
  var src = _.unroll.make( [] );
  var got = _.argumentsArray.from( src );
  var expected = [];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  test.case = 'src - unroll with single element';
  var src = _.unroll.make( [ 0 ] );
  var got = _.argumentsArray.from( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  test.case = 'src - unroll with several elements';
  var src = _.unroll.make( [ 1, 2, 3 ] );
  var got = _.argumentsArray.from( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  /* */

  test.case = 'src - empty argumentsArray';
  var src = _.argumentsArray.make( [] );
  var got = _.argumentsArray.from( src );
  var expected = [];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src === got );

  test.case = 'src - argumentsArray with single element';
  var src = _.argumentsArray.make( [ 0 ] );
  var got = _.argumentsArray.from( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src === got );

  test.case = 'src - argumentsArray with several elements';
  var src = _.argumentsArray.make( [ 1, 2, 3 ] );
  var got = _.argumentsArray.from( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src === got );

  /* */

  test.case = 'src - empty BufferTyped';
  var src = new U8x( [] );
  var got = _.argumentsArray.from( src );
  var expected = [];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  test.case = 'src - BufferTyped with single element';
  var src = new I16x( [ 0 ] );
  var got = _.argumentsArray.from( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  test.case = 'src - BufferTyped with several elements';
  var src = new F32x( [ 1, 2, 3 ] );
  var got = _.argumentsArray.from( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.true( _.argumentsArray.is( got ) );
  test.true( src !== got );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.argumentsArray.from() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.argumentsArray.from( 1, 3 ) );
  test.shouldThrowErrorSync( () => _.argumentsArray.from( [], 3 ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.argumentsArray.from( {} ) );
  test.shouldThrowErrorSync( () => _.argumentsArray.from( 'wrong' ) );
}

// --
//
// --

const Proto =
{

  name : 'Tools.ArgumentsArray.l0.l1',
  silencing : 1,
  enabled : 1,

  tests :
  {

    dichotomy,
    dichotomyPerformance,

    make,
    from,

  }

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
