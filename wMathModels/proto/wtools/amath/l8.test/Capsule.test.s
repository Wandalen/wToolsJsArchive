( function _Capsule_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../node_modules/Tools' );

  _.include( 'wTesting' );
  _.include( 'wMathVector' );
  _.include( 'wMathMatrix' );

  require( '../l8/Concepts.s' );

}

//

const _ = _global_.wTools.withLong.Fx;
var Matrix = _.Matrix;
var vector = _.vectorAdapter;
var vec = _.capsule.tools.vectorAdapter.fromLong;
var avector = _.avector;
var sqrt = _.math.sqrt;
const Parent = wTester;

_.assert( _.routineIs( sqrt ) );

// --
// test
// --

function make( test )
{
  /* */

  test.case = 'Default';

  var gotCapsule = _.capsule.make();
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, 0, 0, 0, 0 ] );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'srcDim undefined';

  var srcDim = undefined;
  var gotCapsule = _.capsule.make( srcDim );
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, 0, 0, 0, 0 ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule !== srcDim );

  /* */

  test.case = 'srcDim null';

  var srcDim = null;
  var gotCapsule = _.capsule.make( srcDim );
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, 0, 0, 0, 0 ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule !== srcDim );

  /* */

  test.case = 'srcDim 2';

  var srcDim = 2;
  var gotCapsule = _.capsule.make( srcDim );
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, 0, 0 ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule !== srcDim );

  /* */

  test.case = 'srcDim array';

  var srcDim = [ 0, 1, 2, 3, 4 ];
  var gotCapsule = _.capsule.make( srcDim );
  var expected = _.capsule.tools.long.make( [ 0, 1, 2, 3, 4 ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule !== srcDim );

  /* */

  test.case = 'srcDim vector';

  var srcDim = _.capsule.tools.vectorAdapter.fromLong( [ 0, 1, 2, 3, 4 ] );
  var gotCapsule = _.capsule.make( srcDim );
  var expected = _.capsule.tools.long.make( [ 0, 1, 2, 3, 4 ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.make( [ 0, 0, 0 ], [ 1, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.make( [ 0, 0, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.make( 'capsule' ));
}

//

function makeZero( test )
{
  /* */

  test.case = 'Default';

  var gotCapsule = _.capsule.makeZero();
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, 0, 0, 0, 0 ] );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'srcDim undefined';

  var srcDim = undefined;
  var gotCapsule = _.capsule.makeZero( srcDim );
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, 0, 0, 0, 0 ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule !== srcDim );

  /* */

  test.case = 'srcDim null';

  var srcDim = null;
  var gotCapsule = _.capsule.makeZero( srcDim );
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, 0, 0, 0, 0 ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule !== srcDim );

  /* */

  test.case = 'srcDim 2';

  var srcDim = 2;
  var gotCapsule = _.capsule.makeZero( srcDim );
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, 0, 0 ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule !== srcDim );

  /* */

  test.case = 'srcDim array';

  var srcDim = [ 0, 1, 2, 3, 4 ];
  var gotCapsule = _.capsule.makeZero( srcDim );
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, 0, 0 ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule !== srcDim );

  /* */

  test.case = 'srcDim vector';

  var srcDim = _.capsule.tools.vectorAdapter.fromLong( [ 0, 1, 2, 3, 4 ] );
  var gotCapsule = _.capsule.makeZero( srcDim );
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, 0, 0 ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.makeZero( [ 0, 0, 0 ], [ 1, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.makeZero( [ 0, 0, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.makeZero( 'capsule' ));

}

//

function makeSingular( test )
{
  /* */

  test.case = 'Default';

  var gotCapsule = _.capsule.makeSingular();
  var expected = _.capsule.tools.long.make( [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity, - Infinity ] );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'srcDim undefined';

  var srcDim = undefined;
  var gotCapsule = _.capsule.makeSingular( srcDim );
  var expected = _.capsule.tools.long.make( [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity, - Infinity ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule !== srcDim );

  /* */

  test.case = 'srcDim null';

  var srcDim = null;
  var gotCapsule = _.capsule.makeSingular( srcDim );
  var expected = _.capsule.tools.long.make( [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity, - Infinity ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule !== srcDim );

  /* */

  test.case = 'srcDim 2';

  var srcDim = 2;
  var gotCapsule = _.capsule.makeSingular( srcDim );
  var expected = _.capsule.tools.long.make( [ Infinity, Infinity, - Infinity, - Infinity, - Infinity ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule !== srcDim );

  /* */

  test.case = 'srcDim array';

  var srcDim = [ 0, 1, 2, 3, 4 ];
  var gotCapsule = _.capsule.makeSingular( srcDim );
  var expected = _.capsule.tools.long.make( [ Infinity, Infinity, - Infinity, - Infinity, - Infinity ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule !== srcDim );

  /* */

  test.case = 'srcDim vector';

  var srcDim = _.capsule.tools.vectorAdapter.fromLong( [ 0, 1, 2, 3, 4 ] );
  var gotCapsule = _.capsule.makeSingular( srcDim );
  var expected = _.capsule.tools.long.make( [ Infinity, Infinity, - Infinity, - Infinity, - Infinity ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.makeSingular( [ 0, 0, 0 ], [ 1, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.makeSingular( [ 0, 0, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.makeSingular( 'capsule' ));
}

//

function zero( test )
{
  /* */

  test.case = 'Default';

  var gotCapsule = _.capsule.zero();
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, 0, 0, 0, 0 ] );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'srcCapsule undefined';

  var srcCapsule = undefined;
  var gotCapsule = _.capsule.zero( srcCapsule );
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, 0, 0, 0, 0 ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule !== srcCapsule );

  /* */

  test.case = 'srcCapsule null';

  var srcCapsule = null;
  var gotCapsule = _.capsule.zero( srcCapsule );
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, 0, 0, 0, 0 ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule !== srcCapsule );

  /* */

  test.case = 'srcCapsule 2';

  var srcCapsule = 2;
  var gotCapsule = _.capsule.zero( srcCapsule );
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, 0, 0 ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule !== srcCapsule );

  /* */

  test.case = 'srcCapsule array';

  var srcCapsule = [ 0, 1, 2, 3, 4 ];
  var gotCapsule = _.capsule.zero( srcCapsule );
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, 0, 0 ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule === srcCapsule );

  /* */

  test.case = 'srcCapsule vector';

  var srcCapsule = _.capsule.tools.vectorAdapter.fromLong( [ 0, 1, 2, 3, 4 ] );
  var gotCapsule = _.capsule.zero( srcCapsule );
  var expected =  _.capsule.tools.vectorAdapter.fromLong( [ 0, 0, 0, 0, 0 ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule === srcCapsule );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.zero( [ 0, 0, 1 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.zero( [ 0, 0, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.zero( 'capsule' ));

}

//

function nil( test )
{
  /* */

  test.case = 'Default';

  var gotCapsule = _.capsule.nil();
  var expected = _.capsule.tools.long.make( [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity, - Infinity ] );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'srcCapsule undefined';

  var srcCapsule = undefined;
  var gotCapsule = _.capsule.nil( srcCapsule );
  var expected = _.capsule.tools.long.make( [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity, - Infinity ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule !== srcCapsule );

  /* */

  test.case = 'srcCapsule null';

  var srcCapsule = null;
  var gotCapsule = _.capsule.nil( srcCapsule );
  var expected = _.capsule.tools.long.make( [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity, - Infinity ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule !== srcCapsule );

  /* */

  test.case = 'srcCapsule 2';

  var srcCapsule = 2;
  var gotCapsule = _.capsule.nil( srcCapsule );
  var expected = _.capsule.tools.long.make( [ Infinity, Infinity, - Infinity, - Infinity, - Infinity ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule !== srcCapsule );

  /* */

  test.case = 'srcCapsule array';

  var srcCapsule = [ 0, 1, 2, 3, 4 ];
  var gotCapsule = _.capsule.nil( srcCapsule );
  var expected = _.capsule.tools.long.make( [ Infinity, Infinity, - Infinity, - Infinity, - Infinity ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule === srcCapsule );

  /* */

  test.case = 'srcCapsule vector';

  var srcCapsule = _.capsule.tools.vectorAdapter.fromLong( [ 0, 1, 2, 3, 4 ] );
  var gotCapsule = _.capsule.nil( srcCapsule );
  var expected = _.capsule.tools.vectorAdapter.fromLong( [ Infinity, Infinity, - Infinity, - Infinity, - Infinity ] );
  test.identical( gotCapsule, expected );
  test.true( gotCapsule === srcCapsule );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.nil( [ 0, 0, 1 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.nil( [ 0, 0, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.nil( 'capsule' ));
}

//

function from( test )
{
  /* */

  test.case = 'Same instance returned - array';

  var srcCapsule = [ 0, 0, 2, 2, 1 ];
  var expected = _.capsule.tools.long.make( [ 0, 0, 2, 2, 1 ] );

  var gotCapsule = _.capsule.from( srcCapsule );
  test.identical( gotCapsule, expected );
  test.true( srcCapsule === gotCapsule );

  /* */

  test.case = 'Different instance returned - vector -> array';

  var srcCapsule = _.capsule.tools.vectorAdapter.fromLong( [ 0, 0, 2, 2, 1 ] );
  var expected = _.capsule.tools.vectorAdapter.fromLong( [ 0, 0, 2, 2, 1 ] );

  var gotCapsule = _.capsule.from( srcCapsule );
  test.identical( gotCapsule, expected );
  test.true( srcCapsule === gotCapsule );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.from( ));
  test.shouldThrowErrorSync( () => _.capsule.adapterFrom( [] ));
  test.shouldThrowErrorSync( () => _.capsule.from( [ 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.capsule.from( [ 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.from( 'capsule' ));
  test.shouldThrowErrorSync( () => _.capsule.from( NaN ));
  test.shouldThrowErrorSync( () => _.capsule.from( undefined ));
}

//

function adapterFrom( test )
{
  /* */

  test.case = 'Same instance returned - vector';

  var srcCapsule = [ 0, 0, 2, 2, 1 ];
  var expected = _.capsule.tools.vectorAdapter.from( [ 0, 0, 2, 2, 1 ] );

  var gotCapsule = _.capsule.adapterFrom( srcCapsule );
  test.identical( gotCapsule, expected );
  test.true( srcCapsule !== gotCapsule );

  /* */

  test.case = 'Different instance returned - vector -> vector';

  var srcCapsule = _.vectorAdapter.from( [ 0, 0, 2, 2, 1 ] );
  var expected = _.capsule.tools.vectorAdapter.from( [ 0, 0, 2, 2, 1 ] );

  var gotCapsule = _.capsule.adapterFrom( srcCapsule );
  test.identical( gotCapsule, expected );
  test.true( srcCapsule === gotCapsule );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.adapterFrom( ));
    test.shouldThrowErrorSync( () => _.capsule.adapterFrom( [] ));
  test.shouldThrowErrorSync( () => _.capsule.adapterFrom( [ 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.capsule.adapterFrom( [ 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.capsule.adapterFrom( 'capsule' ));
  test.shouldThrowErrorSync( () => _.capsule.adapterFrom( NaN ));
  test.shouldThrowErrorSync( () => _.capsule.adapterFrom( null ));
  test.shouldThrowErrorSync( () => _.capsule.adapterFrom( undefined ));
}

//

function is( test )
{
  debugger;
  /* */

  test.case = 'array';

  test.true( _.capsule.is([ 0, 0, 0 ]) );
  test.true( _.capsule.is([ 0, 1, 2, 3, 4 ]) );
  test.true( _.capsule.is([ 0, 0, 0, 0, 0, 0, 0 ]) );

  /* */

  test.case = 'vector';

  test.true( _.capsule.is( _.capsule.tools.vectorAdapter.fromLong([ 0, 0, 0 ]) ) );
  test.true( _.capsule.is( _.capsule.tools.vectorAdapter.fromLong([ 0, 1, 2, 3, 4 ]) ) );
  test.true( _.capsule.is( _.capsule.tools.vectorAdapter.fromLong([ 0, 0, 0, 0, 0, 0, 0 ]) ) );

  /* */

  test.case = 'not capsule';

  test.true( !_.capsule.is( [] ) );
  test.true( !_.capsule.is([ 0, 0 ]) );
  test.true( !_.capsule.is([ 0, 0, 0, 0 ]) );
  test.true( !_.capsule.is( _.capsule.tools.vectorAdapter.fromLong([]) ) );
  test.true( !_.capsule.is( null ) );
  test.true( !_.capsule.is( NaN ) );
  test.true( !_.capsule.is( undefined ) );
  test.true( !_.capsule.is( 'abc' ) );
  test.true( !_.capsule.is( { start : [ 0, 0, 0 ], end : [ 1, 1, 1 ], radius : 1 } ) );
  test.true( !_.capsule.is( function( a, b, c ){} ) );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.is( ));
  // test.shouldThrowErrorSync( () => _.capsule.is( 'abc' ));
  // test.shouldThrowErrorSync( () => _.capsule.is( null ));
  // test.shouldThrowErrorSync( () => _.capsule.is( NaN ));
  // test.shouldThrowErrorSync( () => _.capsule.is( undefined ));
  // test.shouldThrowErrorSync( () => _.capsule.is( { start : [ 0, 0, 0 ], end : [ 1, 1, 1 ], radius : 1 } ));
  // test.shouldThrowErrorSync( () => _.capsule.is( function( a, b, c ){} ));
  test.shouldThrowErrorSync( () => _.capsule.is( [ 0, 0, 0 ], [ 0, 2, 1 ] ));

}

//

function dimGet( test )
{
  /* */

  test.case = 'srcCapsule 1D - array';

  var srcCapsule = [ 0, 1, 1 ];
  var gotDim = _.capsule.dimGet( srcCapsule );
  var expected = 1;
  test.identical( gotDim, expected );
  test.true( gotDim !== srcCapsule );

  /* */

  test.case = 'srcCapsule 1D - vector';

  var srcCapsule = _.capsule.tools.vectorAdapter.fromLong( [ 0, 1, 1 ] );
  var gotDim = _.capsule.dimGet( srcCapsule );
  var expected = 1;
  test.identical( gotDim, expected );
  test.true( gotDim !== srcCapsule );

  /* */

  test.case = 'srcCapsule 2D - array';

  var srcCapsule = [ 0, 1, 2, 3, 4 ];
  var gotDim = _.capsule.dimGet( srcCapsule );
  var expected = 2;
  test.identical( gotDim, expected );
  test.true( gotDim !== srcCapsule );

  /* */

  test.case = 'srcCapsule 2D - vector';

  var srcCapsule = _.capsule.tools.vectorAdapter.fromLong( [ 0, 1, 2, 3, 4 ] );
  var gotDim = _.capsule.dimGet( srcCapsule );
  var expected = 2;
  test.identical( gotDim, expected );
  test.true( gotDim !== srcCapsule );

  /* */

  test.case = 'srcCapsule 3D - array';

  var srcCapsule = [ 0, 1, 2, 3, 4, 5, 6 ];
  var gotDim = _.capsule.dimGet( srcCapsule );
  var expected = 3;
  test.identical( gotDim, expected );
  test.true( gotDim !== srcCapsule );

  /* */

  test.case = 'srcCapsule 3D - vector';

  var srcCapsule = _.capsule.tools.vectorAdapter.fromLong( [ 0, 1, 2, 3, 4, 5, 6 ] );
  var gotDim = _.capsule.dimGet( srcCapsule );
  var expected = 3;
  test.identical( gotDim, expected );
  test.true( gotDim !== srcCapsule );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.dimGet( ) );
  test.shouldThrowErrorSync( () => _.capsule.dimGet( [] ) );
  test.shouldThrowErrorSync( () => _.capsule.dimGet( [ 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.dimGet( [ 0, 0, 0 ], [ 1, 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.dimGet( 'capsule' ) );
  test.shouldThrowErrorSync( () => _.capsule.dimGet( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.dimGet( null ) );
  test.shouldThrowErrorSync( () => _.capsule.dimGet( NaN ) );
  test.shouldThrowErrorSync( () => _.capsule.dimGet( undefined ) );

}

//

function originGet( test )
{
  /* */

  test.case = 'Source capsule remains unchanged';

  var srcCapsule = [ 0, 0, 1, 1, 1 ];
  var expected = _.capsule.tools.vectorAdapter.from( [ 0, 0 ] );

  var gotOrigin = _.capsule.originGet( srcCapsule );
  test.identical( gotOrigin, expected );

  var oldSrcCapsule = [ 0, 0, 1, 1, 1 ];
  test.equivalent( srcCapsule, oldSrcCapsule );

  /* */

  test.case = 'srcCapsule 1D - array';

  var srcCapsule = [ 0, 1, 2 ];
  var gotOrigin = _.capsule.originGet( srcCapsule );
  var expected = _.capsule.tools.vectorAdapter.from( [ 0 ] );
  test.identical( gotOrigin, expected );
  test.true( gotOrigin !== srcCapsule );

  /* */

  test.case = 'srcCapsule 1D - vector';

  var srcCapsule = _.capsule.tools.vectorAdapter.fromLong( [ 0, 1, 1 ] );
  var gotOrigin = _.capsule.originGet( srcCapsule );
  var expected = _.capsule.tools.vectorAdapter.from( [ 0 ] );
  test.identical( gotOrigin, expected );
  test.true( gotOrigin !== srcCapsule );

  /* */

  test.case = 'srcCapsule 2D - array';

  var srcCapsule = [ 0, 1, 2, 3, 4 ];
  var gotOrigin = _.capsule.originGet( srcCapsule );
  var expected = _.capsule.tools.vectorAdapter.from( [ 0, 1 ] );
  test.identical( gotOrigin, expected );
  test.true( gotOrigin !== srcCapsule );

  /* */

  test.case = 'srcCapsule 2D - vector';

  var srcCapsule = _.capsule.tools.vectorAdapter.fromLong( [ 0, 1, 2, 3, 4 ] );
  var gotOrigin = _.capsule.originGet( srcCapsule );
  var expected = _.capsule.tools.vectorAdapter.from( [ 0, 1 ] );
  test.identical( gotOrigin, expected );
  test.true( gotOrigin !== srcCapsule );

  /* */

  test.case = 'srcCapsule 3D - array';

  var srcCapsule = [ 0, 1, 2, 3, 4, 5, 6 ];
  var gotOrigin = _.capsule.originGet( srcCapsule );
  var expected = _.capsule.tools.vectorAdapter.from( [ 0, 1, 2 ] );
  test.identical( gotOrigin, expected );
  test.true( gotOrigin !== srcCapsule );

  /* */

  test.case = 'srcCapsule 3D - vector';

  var srcCapsule = _.capsule.tools.vectorAdapter.fromLong( [ 0, 1, 2, 3, 4, 5, 6 ] );
  var gotOrigin = _.capsule.originGet( srcCapsule );
  var expected = _.capsule.tools.vectorAdapter.from( [ 0, 1, 2 ] );
  test.identical( gotOrigin, expected );
  test.true( gotOrigin !== srcCapsule );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.originGet( ) );
  test.shouldThrowErrorSync( () => _.capsule.originGet( [ 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.originGet( [ 0, 0, 1 ], [ 1, 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.originGet( 'capsule' ) );
  test.shouldThrowErrorSync( () => _.capsule.originGet( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.originGet( null ) );
  test.shouldThrowErrorSync( () => _.capsule.originGet( NaN ) );
  test.shouldThrowErrorSync( () => _.capsule.originGet( undefined ) );

}

//

function endPointGet( test )
{
  /* */

  test.case = 'Source capsule remains unchanged';

  var srcCapsule = [ 0, 0, 1, 1, 2 ];
  var expected = _.capsule.tools.vectorAdapter.from( [ 1, 1 ] );

  var gotDirection = _.capsule.endPointGet( srcCapsule );
  test.identical( gotDirection, expected );

  var oldSrcCapsule = [ 0, 0, 1, 1, 2 ];
  test.equivalent( srcCapsule, oldSrcCapsule );

  /* */

  test.case = 'srcCapsule 1D - array';

  var srcCapsule = [ 0, 1, 2 ];
  var gotDirection = _.capsule.endPointGet( srcCapsule );
  var expected = _.capsule.tools.vectorAdapter.from( [ 1 ] );
  test.identical( gotDirection, expected );
  test.true( gotDirection !== srcCapsule );

  /* */

  test.case = 'srcCapsule 1D - vector';

  var srcCapsule = _.capsule.tools.vectorAdapter.fromLong( [ 0, 1, 2 ] );
  var gotDirection = _.capsule.endPointGet( srcCapsule );
  var expected = _.capsule.tools.vectorAdapter.from( [ 1 ] );
  test.identical( gotDirection, expected );
  test.true( gotDirection !== srcCapsule );

  /* */

  test.case = 'srcCapsule 2D - array';

  var srcCapsule = [ 0, 1, 2, 3, 4 ];
  var gotDirection = _.capsule.endPointGet( srcCapsule );
  var expected = _.capsule.tools.vectorAdapter.from( [ 2, 3 ] );
  test.identical( gotDirection, expected );
  test.true( gotDirection !== srcCapsule );

  /* */

  test.case = 'srcCapsule 2D - vector';

  var srcCapsule = _.capsule.tools.vectorAdapter.fromLong( [ 0, 1, 2, 3, 4 ] );
  var gotDirection = _.capsule.endPointGet( srcCapsule );
  var expected = _.capsule.tools.vectorAdapter.from( [ 2, 3 ] );
  test.identical( gotDirection, expected );
  test.true( gotDirection !== srcCapsule );

  /* */

  test.case = 'srcCapsule 3D - array';

  var srcCapsule = [ 0, 1, 2, 3, 4, 5, 6 ];
  var gotDirection = _.capsule.endPointGet( srcCapsule );
  var expected = _.capsule.tools.vectorAdapter.from( [ 3, 4, 5 ] );
  test.identical( gotDirection, expected );
  test.true( gotDirection !== srcCapsule );

  /* */

  test.case = 'srcCapsule 3D - vector';

  var srcCapsule = _.capsule.tools.vectorAdapter.fromLong( [ 0, 1, 2, 3, 4, 5, 6 ] );
  var gotDirection = _.capsule.endPointGet( srcCapsule );
  var expected = _.capsule.tools.vectorAdapter.from( [ 3, 4, 5 ] );
  test.identical( gotDirection, expected );
  test.true( gotDirection !== srcCapsule );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.endPointGet( ) );
  test.shouldThrowErrorSync( () => _.capsule.endPointGet( [ 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.endPointGet( [ 0, 0, 1 ], [ 1, 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.endPointGet( 'capsule' ) );
  test.shouldThrowErrorSync( () => _.capsule.endPointGet( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.endPointGet( null ) );
  test.shouldThrowErrorSync( () => _.capsule.endPointGet( NaN ) );
  test.shouldThrowErrorSync( () => _.capsule.endPointGet( undefined ) );

}

//

function radiusGet( test )
{

  /* */

  test.case = 'Source capsule remains unchanged';

  var srcCapsule = [ 0, 0, 1, 1, 2 ];
  var oldSrcCapsule = srcCapsule.slice();
  var expected =  2;

  var gotRadius = _.capsule.radiusGet( srcCapsule );

  test.equivalent( srcCapsule, oldSrcCapsule );
  test.identical( gotRadius, expected );

  /* */

  test.case = 'One dimension capsule';

  var capsule = [ 0, 1, 2 ];
  var expected =  2 ;

  var gotRadius = _.capsule.radiusGet( capsule );
  test.identical( gotRadius, expected );

  /* */

  test.case = 'Two dimension capsule';

  var capsule = [ 0, 0, 1, 1, 2 ];
  var expected = 2;

  var gotRadius = _.capsule.radiusGet( capsule );
  test.identical( gotRadius, expected );

  /* */

  test.case = 'Three dimension capsule';

  var capsule = [ 0, - 1, - 2, 2, 2, 2, 3 ];
  var expected = 3;

  var gotRadius = _.capsule.radiusGet( capsule );
  test.identical( gotRadius, expected );

  /* */

  test.case = 'Four dimension capsule';

  var capsule = [ 0, - 1, - 2, 2, 4, 4, 4, 4, 3 ];
  var expected =  3;

  var gotRadius = _.capsule.radiusGet( capsule );
  test.identical( gotRadius, expected );

  /* */

  test.case = 'NaN capsule';

  var capsule = [ NaN, NaN, 1 ];
  var expected = 1;

  var gotRadius = _.capsule.radiusGet( capsule );
  test.identical( gotRadius, expected );


  /* */

  test.case = 'radiusGet+Set two dimensions';

  var capsule = [ 0, 1, 2, 2, 1 ];
  var radiusOld = 1;
  var radiusSph = _.capsule.radiusGet( capsule );
  test.equivalent( radiusSph, radiusOld );

  var radius = 2;
  var expected = _.capsule.tools.long.make( [ 0, 1, 2, 2, 2 ] );
  expected = _.vectorAdapter.from(expected);
  var gotCapsule = _.capsule.radiusSet( capsule, radius );
  test.identical( gotCapsule, expected );

  var radiusSph = _.capsule.radiusGet( capsule );
  test.equivalent( radius, radiusSph );

  /* */

  test.case = 'radiusGet+Set three dimensions';

  var capsule = [ 0, 0, 1, 1, 1, 2, 1 ];
  var radiusOld = 1;
  var radiusSph = _.capsule.radiusGet( capsule );
  test.equivalent( radiusOld, radiusSph );

  var radius = 2;
  var expected = _.capsule.tools.long.make( [ 0, 0, 1, 1, 1, 2, 2 ] );
  expected = _.vectorAdapter.from(expected);
  var gotCapsule = _.capsule.radiusSet( capsule, radius );
  test.equivalent( gotCapsule, expected );

  var radiusSph = _.capsule.radiusGet( gotCapsule );
  test.equivalent( radius, radiusSph );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.radiusGet( ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusGet( [ ] ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusGet( [ 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusGet( [ 0, 0, 1 ], [ 1, 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusGet( 'capsule' ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusGet( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusGet( null ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusGet( NaN ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusGet( undefined ) );

}

//

function radiusSet( test )
{

  /* */

  test.case = 'Source radius remains unchanged';

  var capsule = [ 0, 0, 1, 1, 0 ];
  var srcRadius = 2;
  var expected =  _.capsule.tools.long.make( [ 0, 0, 1, 1, 2 ] );
  expected = _.capsule.tools.vectorAdapter.from(expected);

  var gotCapsule = _.capsule.radiusSet( capsule, srcRadius );
  test.identical( gotCapsule, expected );

  var oldSrcRadius = 2;
  test.equivalent( srcRadius, oldSrcRadius );

  /* */

  test.case = 'One dimension capsule';

  var capsule = [ 0, 1, 0 ];
  var radius = 2;
  var expected = _.capsule.tools.long.make( [ 0, 1, 2 ] );
  expected = _.capsule.tools.vectorAdapter.from(expected);

  var gotCapsule = _.capsule.radiusSet( capsule, radius );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'Two dimension capsule';

  var capsule = [ 0, 0, 1, 1, 2 ];
  var radius = 3;
  var expected = _.capsule.tools.long.make( [ 0, 0, 1, 1, 3 ] );
  expected = _.capsule.tools.vectorAdapter.from(expected);

  var gotCapsule = _.capsule.radiusSet( capsule, radius );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'Three dimension capsule';

  var capsule = [ 0, - 1, - 2, 1, 1, 1, 2 ];
  var radius = 4;
  var expected = _.capsule.tools.long.make( [ 0, - 1, - 2, 1, 1, 1, 4 ] );
  expected = _.capsule.tools.vectorAdapter.from(expected);

  var gotCapsule = _.capsule.radiusSet( capsule, radius );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'Four dimension capsule';

  var capsule = [ 0, - 1, - 2, 2, 2, 2, 2, 2, 0 ];
  var radius = 5;
  var expected = _.capsule.tools.long.make( [ 0, - 1, - 2, 2, 2, 2, 2, 2, 5 ] );
  expected = _.capsule.tools.vectorAdapter.from(expected);

  var gotCapsule = _.capsule.radiusSet( capsule, radius );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'negative radius';

  var capsule = [ 1, 2, - 3 ];
  var radius = - 2;
  var expected = _.capsule.tools.long.make( [ 1, 2, - 2 ] );
  expected = _.capsule.tools.vectorAdapter.from(expected);

  var gotCapsule = _.capsule.radiusSet( capsule, radius );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'NaN radius';

  var capsule = [ 1, 2, 3 ];
  var radius = NaN;
  var expected = _.capsule.tools.long.make( [ 1, 2, NaN ] );
  expected = _.capsule.tools.vectorAdapter.from(expected);

  var gotCapsule = _.capsule.radiusSet( capsule, radius );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'NaN capsule';

  var capsule = [ NaN, NaN, 0 ];
  var radius = 2;
  var expected = _.capsule.tools.long.make( [ NaN, NaN, 2 ] );
  expected = _.capsule.tools.vectorAdapter.from(expected);

  var gotCapsule = _.capsule.radiusSet( capsule, radius );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'radiusSet+Get one dimensions';

  var capsule = [ 0, 2, 3 ];
  var radiusOld = 3;
  var radiusSph = _.capsule.radiusGet( capsule );
  test.equivalent( radiusOld, radiusSph );

  var radius = 2;
  var expected = _.capsule.tools.long.make( [ 0, 2, 2 ] );
  expected = _.capsule.tools.vectorAdapter.from(expected);

  var gotCapsule = _.capsule.radiusSet( capsule, radius );
  test.identical( gotCapsule, expected );

  var radiusSph = _.capsule.radiusGet( capsule );
  test.equivalent( radius, radiusSph );

  /* */

  test.case = 'radiusSet+Get two dimensions';

  var capsule = [ 0, 0, 1, 1, 3 ];
  var radiusOld = 3;
  var radiusSph = _.capsule.radiusGet( capsule );
  test.equivalent( radiusOld, radiusSph );

  var radius = 2;
  var expected = _.capsule.tools.long.make( [ 0, 0, 1, 1, 2 ] );
  expected = _.capsule.tools.vectorAdapter.from(expected);

  var gotCapsule = _.capsule.radiusSet( capsule, radius );
  test.identical( gotCapsule, expected );

  var radiusSph = _.capsule.radiusGet( capsule );
  test.equivalent( radius, radiusSph );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.radiusSet( ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusSet( 0, 1 ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusSet( [ ] ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusSet( [ 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusSet( [ 0, 0, 1 ], [ 1, 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusSet( 'radius' ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusSet( null ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusSet( NaN ) );
  test.shouldThrowErrorSync( () => _.capsule.radiusSet( undefined ) );

}

//

function expand( test )
{

  /* */

  test.case = 'Expansion array remains unchanged and Destination capsule changes';

  // var capsule = [  - 1, - 1 , 1, 1, 1 ];
  // var point = [ 0, 0 ];
  // var expected = true;
  var dstCapsule = [ 0, 0, 1, 1, 2 ];
  var expand = [ 0, 2, 1 ];
  var expected = _.capsule.tools.long.make( [ 0, - 2, 1, 3, 3 ] );

  var gotCapsule = _.capsule.expand( dstCapsule, expand );
  test.identical( gotCapsule, expected );
  test.identical( dstCapsule, expected );

  // var oldCapsule = [  - 1, - 1 , 1, 1, 1 ];
  // test.identical( capsule, oldCapsule );
  var oldexpand = [ 0, 2, 1 ];
  test.identical( expand, oldexpand );

  var oldCapsule = [ 0, 0, 1, 1, 2 ];
  test.true( oldCapsule !== gotCapsule );

  /* */

  test.case = 'Null capsule expanded';

  var capsule = null;
  var expand = [ 1, 2, 3, 1 ];
  var expected = _.capsule.tools.long.make( [ - 1, - 2, - 3, 1, 2, 3, 1 ] );

  // var gotBool = _.capsule.pointContains( capsule, point );
  // test.identical( gotBool, expected );
  var gotCapsule = _.capsule.expand( capsule, expand );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'Null capsule NOT expanded';

  var capsule = null;
  var expand = [ 0, 0, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, 0, 0, 0, 0 ] );

  // var gotBool = _.capsule.pointContains( capsule, point );
  // test.identical( gotBool, expected );
  var gotCapsule = _.capsule.expand( capsule, expand );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'One side capsule expanded';

  var capsule = [ 0, 0, 0, 0, 0, 0, 1 ];
  var expand = [ 0, 0, 3, 0 ];
  var expected = _.capsule.tools.long.make( [ 0,  0, - 3, 0, 0, 3, 1 ] );

  // var gotBool = _.capsule.pointContains( capsule, point );
  // test.identical( gotBool, expected );
  var gotCapsule = _.capsule.expand( capsule, expand );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'Capsule expanded';

  var capsule = [ 0, 0, 0, 2, 2, 2, 1 ];
  var expand = [ 1, 3, 1, 1 ];
  var expected = _.capsule.tools.long.make( [ - 1, - 3, - 1, 3, 5, 3, 2 ] );

  var gotCapsule = _.capsule.expand( capsule, expand );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'Capsule expanded by value';

  var capsule = [ 0, 0, 0, 2, 2, 2, 0 ];
  var expand = 1;
  var expected = _.capsule.tools.long.make( [ - 1, - 1, - 1, 3, 3, 3, 1 ] );

  // var gotBool = _.capsule.pointContains( capsule, point );
  // test.identical( gotBool, expected );
  var gotCapsule = _.capsule.expand( capsule, expand );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'Same using array';

  var capsule = [ 0, 0, 0, 2, 2, 2, 0 ];
  var expand = [ 1, 1, 1, 1 ];
  var expected = _.capsule.tools.long.make( [ - 1, - 1, - 1, 3, 3, 3, 1 ] );

  // var gotBool = _.capsule.pointContains( capsule, point );
  // test.identical( gotBool, expected );
  var gotCapsule = _.capsule.expand( capsule, expand );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'Capsule NOT expanded ( empty expand array )';

  var capsule = [ 0, 0, 0, 2, 2, 2, 1 ];
  var expand = [  0, 0, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, 2, 2, 2, 1 ] );

  // var gotBool = _.capsule.pointContains( capsule, point );
  // test.identical( gotBool, expected );
  var gotCapsule = _.capsule.expand( capsule, expand );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'Capsule contracted by value';

  var capsule = [ 0, 0, 0, 3, 3, 3, 4 ];
  var expand = - 1;
  var expected = _.capsule.tools.long.make( [ 1, 1, 1, 2, 2, 2, 3 ] );

  var gotCapsule = _.capsule.expand( capsule, expand );
  test.identical( gotCapsule, expected );

  // var gotBool = _.capsule.pointContains( capsule, point );
  // test.identical( gotBool, expected );
  /* */

  test.case = 'Capsule contracted by array';

  var capsule = [ 0, 0, 0, 3, 3, 3, 4 ];
  var expand = [ - 1, - 1, - 1, - 1 ];
  var expected = _.capsule.tools.long.make( [ 1, 1, 1, 2, 2, 2, 3 ] );

  var gotCapsule = _.capsule.expand( capsule, expand );
  test.identical( gotCapsule, expected );

  // var gotBool = _.capsule.pointContains( capsule, point );
  // test.identical( gotBool, expected );

  /* */

  test.case = 'Capsule with decimal numbers expanded';

  var capsule = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766, 0.5 ];
  var expand = [ -0.100, 0, 0.100, 0.2 ];
  var expected = _.capsule.tools.long.make( [  0.050,  0.002, -0.338, 0.094, 0.766, 0.866, 0.7 ] );

  var gotCapsule = _.capsule.expand( capsule, expand );
  test.equivalent( gotCapsule, expected );

  // var gotBool = _.capsule.pointContains( capsule, point );
  // test.identical( gotBool, expected );

  /* */

  test.case = 'Null capsule of four dimensions expanded';

  var capsule = [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ];
  var expand = [ 1, 2, 3, 4, 5 ];
  var expected = _.capsule.tools.long.make( [ - 1, - 2, - 3, - 4, 1, 2, 3, 4, 5 ] );

  var gotCapsule = _.capsule.expand( capsule, expand );
  test.identical( gotCapsule, expected );

  // var gotBool = _.capsule.pointContains( capsule, point );
  // test.identical( gotBool, expected );

  /* */

  test.case = 'Null capsule of 7 dimensions expanded';

  var capsule = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ];
  var expand = [ 1, 2, 3 , 4, 5, 6, 7, 1 ];
  var expected = _.capsule.tools.long.make( [ - 1, - 2, - 3, - 4, - 5, - 6, - 7, 1, 2, 3, 4, 5, 6, 7, 2 ] );

  var gotCapsule = _.capsule.expand( capsule, expand );
  test.identical( gotCapsule, expected );

  // var gotBool = _.capsule.pointContains( capsule, point );
  // test.identical( gotBool, expected );

  /* */

  test.case = 'Capsule of 1 dimension expanded';

  var capsule = [ 0, 0, 0 ];
  var expand = 1;
  var expected = _.capsule.tools.long.make( [ - 1, 1, 1 ] );

  var gotCapsule = _.capsule.expand( capsule, expand );
  test.identical( gotCapsule, expected );

  // var gotBool = _.capsule.pointContains( capsule, point );
  // test.identical( gotBool, expected );

  /* */

  test.case = 'Null capsule expanded by value';

  var capsule = null;
  var expand =  4 ;
  var expected = _.capsule.tools.long.make( [ - 4, -4, -4, 4, 4, 4, 4 ] );

  var gotCapsule = _.capsule.expand( capsule, expand );
  test.identical( gotCapsule, expected );

  /* */

  if( !Config.debug )
  return;

  /* */

  test.case = 'No arguments';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.expand();
  });

  /* */

  test.case = 'Wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.expand( 'capsule', 'expand' );
  });

  /* */

  test.case = 'Too few arguments';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.expand( [ 0, 0, 0, 0, 0, 0, 0 ] );
  });

  /* */

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.expand( [ 0, 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 1 ] );
  });

  /* */

  test.case = 'empty arguments';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.expand( [ ], [ ] );
  });

  /* */

  test.case = 'Wrong expand array dimension (capsule 3D vs array 4D)';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.expand( [ 0, 0, 0, 0, 0, 0, 1 ], [ 0, 1, 0, 2, 1 ] );
  });

  /* */

  test.case = 'Wrong expand array dimension (capsule 3D vs array 2D)';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.expand( [ 0, 0, 0, 0, 0, 0, 1 ], [ 0, 1, 1 ] );
  });

  /* */

  test.case = 'Wrong expand array dimension (capsule 2D vs array 1D)';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.expand( [ 0, 0, 0, 0, 1 ], [ 0, 1 ] );
  });

  /* */

  test.case = 'Wrong expand array dimension (null capsule vs array 2D)';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.expand( null, [ 0, 1, 1 ] );
  });

}

//

function project( test )
{

  /* */

  test.case = 'Projection array remains unchanged and Destination capsule changes';

  // var capsule = [  - 1, - 1 , 1, 1, 0 ];
  // var point = [ 0, 0 ];
  // var expected = 0;
  var dstCapsule = [ 0, 0, 1, 1, 1 ];
  var project = [ [ 1, 1 ], 2, 2 ];
  var expected = _.capsule.tools.long.make( [ 0.5, 0.5, 2.5, 2.5, 2 ] );

  var gotCapsule = _.capsule.project( dstCapsule, project ); /* xxx : ? */
  test.identical( gotCapsule, expected );
  test.identical( dstCapsule, expected );

  // var oldCapsule = [  - 1, - 1 , 1, 1, 0 ];
  // test.identical( capsule, oldCapsule );
  var oldProject = [ [ 1, 1 ], 2, 2 ];
  test.identical( project, oldProject );

  var oldCapsule = [ 0, 0, 1, 1, 1 ];
  test.true( oldCapsule !== gotCapsule );

  /* */

  test.case = 'Null capsule projected';

  var capsule = null;
  var project = [ [ 1, 0, 0 ], 1, 2 ];
  var expected = _.capsule.tools.long.make( [ 1, 0, 0, 1, 0, 0, 0 ] );

  // var gotDistance = _.capsule.pointDistance( capsule, point );
  // test.identical( gotDistance, expected );
  var gotCapsule = _.capsule.project( capsule, project );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'Null capsule NOT projected';

  var capsule = null;
  var project = [ [ 0, 0, 0 ], 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, 0, 0, 0, 0 ] );

  // var gotDistance = _.capsule.pointDistance( capsule, point );
  // test.identical( gotDistance, expected );
  var gotCapsule = _.capsule.project( capsule, project );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'Capsule projected';

  var capsule = [ 0, 0, 0, 1, 0, 0, 2 ];
  var project = [ [ 0, 1, 0 ], 2, 3 ];
  var expected = _.capsule.tools.long.make( [ -0.5, 1, 0, 1.5, 1, 0, 6 ] );

  // var gotDistance = _.capsule.pointDistance( capsule, point );
  // test.identical( gotDistance, expected );
  var gotCapsule = _.capsule.project( capsule, project );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'Capsule expanded';

  var capsule = [ 0, 0, 0, 2, 2, 2, 1 ];
  var project = [ [ 0, 0, 0 ], 2, 2 ];
  var expected = _.capsule.tools.long.make( [ -1, -1, -1, 3, 3, 3, 2 ] );

  // var gotDistance = _.capsule.pointDistance( capsule, point );
  // test.identical( gotDistance, expected );
  var gotCapsule = _.capsule.project( capsule, project );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'Capsule contracted';

  var capsule = [ 0, 0, 0, 2, 2, 2, 1 ];
  var project = [ [ 0, 0, 0 ], 0.5, 0.5 ];
  var expected = _.capsule.tools.long.make( [ 0.5, 0.5, 0.5, 1.5, 1.5, 1.5, 0.5 ] );

  // var gotDistance = _.capsule.pointDistance( capsule, point );
  // test.identical( gotDistance, expected );
  var gotCapsule = _.capsule.project( capsule, project );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'Capsule translated';

  var capsule = [ 0, 0, 0, 2, 2, 2, 1 ];
  var project = [ [ 1, 2, 3 ], 1, 1 ];
  var expected = _.capsule.tools.long.make( [ 1, 2, 3, 3, 4, 5, 1 ] );

  // var gotDistance = _.capsule.pointDistance( capsule, point );
  // test.identical( gotDistance, expected );
  var gotCapsule = _.capsule.project( capsule, project );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'Capsule reduced to a point';

  var capsule = [ 0, 0, 0, 2, 2, 2, 2 ];
  var project = [ [ 1, 2, 3 ], 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 2, 3, 4, 2, 3, 4, 0 ] );

  // var gotDistance = _.capsule.pointDistance( capsule, point );
  // test.identical( gotDistance, expected );
  var gotCapsule = _.capsule.project( capsule, project );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'Capsule reduced to a sphere';

  var capsule = [ 0, 0, 0, 2, 2, 2, 2 ];
  var project = [ [ 1, 2, 3 ], 0, 1 ];
  var expected = _.capsule.tools.long.make( [ 2, 3, 4, 2, 3, 4, 2 ] );

  // var gotDistance = _.capsule.pointDistance( capsule, point );
  // test.identical( gotDistance, expected );
  var gotCapsule = _.capsule.project( capsule, project );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'Capsule NOT projected ( empty project array )';

  var capsule = [ 0, 0, 0, 2, 2, 2, 3 ];
  var project = [ [ 0, 0, 0 ], 1, 1 ];
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, 2, 2, 2, 3 ] );

  // var gotDistance = _.capsule.pointDistance( capsule, point );
  // test.identical( gotDistance, expected );
  var gotCapsule = _.capsule.project( capsule, project );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'Capsule of four dimensions projected';

  var capsule = [ -0.5, -0.5, -0.5, -0.5, 0.5, 0.5, 0.5, 0.5, 1 ];
  var project = [ [ 0, 0, 0, 0 ], 2, 4 ];
  var expected = _.capsule.tools.long.make( [ - 1, - 1, - 1, - 1, 1, 1, 1, 1, 4 ] );

  var gotCapsule = _.capsule.project( capsule, project );
  test.identical( gotCapsule, expected );

  /* */

  test.case = 'Capsule of 1 dimension projected';

  var capsule = [ 0, 1, 1 ];
  var project = [ [ 1 ], 2, 1 ];
  var expected = _.capsule.tools.long.make( [ 0.5, 2.5, 1 ] );

  var gotCapsule = _.capsule.project( capsule, project );
  test.identical( gotCapsule, expected );
  // var gotDistance = _.capsule.pointDistance( capsule, point );
  // test.identical( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;

  /* */

  test.case = 'No arguments';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.project();
  });

  /* */

  test.case = 'Wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.project( 'capsule', 'project' );
  });

  /* */

  test.case = 'Too few arguments';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.project( [ 0, 0, 0, 0, 0, 0, 0 ] );
  });

  /* */

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.project( [ 0, 0, 0 ], [ [ 0 ], 1, 0 ], [ [ 1 ], 0, 1 ] );
  });

  /* */

  test.case = 'Wrong project array dimension (capsule 3D vs array 4D)';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.project( [ 0, 0, 0, 0, 0, 0, 0 ], [ [ 1, 1, 1, 1 ], 0, 1 ] );
  });

  /* */

  test.case = 'Wrong project array dimension (capsule 3D vs array 2D)';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.project( [ 0, 0, 0, 0, 0, 0, 0 ], [ [ 0, 1 ], 1, 2 ] );
  });

  /* */

  test.case = 'Wrong project array dimension (capsule 2D vs array 1D)';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.project( [ 0, 0, 0, 0, 0 ], [ [ 0 ], 2, 1 ] );
  });

  /* */

  test.case = 'Wrong project array dimension (null capsule vs array 2D)';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.project( null, [ [ 0, 1 ], 1, 1 ] );
  });

  /* */

  test.case = 'Wrong project array dimension (project has less than 3 entries)';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.project( [ 0, 0, 0, 0, 0, 0, 0 ], [ [ 0, 1, 0 ], 1 ] );
  });

  /* */

  test.case = 'Wrong project array dimension (project has more than 3 entries)';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.project( [ 0, 0, 0, 0, 0, 0, 0 ], [ [ 0, 1, 0 ], 1, 2, 3 ] );
  });

  /* */

  test.case = 'Empty arrays';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.project( [ ], [ [  ],  ] );
  });

}

//

function getProjectionFactors( test )
{

  /* */

  test.case = 'Capsules remain unchanged';

  var dstCapsule = [ 0, 0, 1, 1, 1 ];
  var projCapsule = [ 0.5, 0.5, 2.5, 2.5, 2 ];
  var expected = _.capsule.tools.long.make( [ [ 1, 1 ], 2, 2 ] );

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.identical( gotFactors, expected );

  var oldCapsule = [ 0, 0, 1, 1, 1 ];
  test.identical( oldCapsule, dstCapsule );

  var oldProjCapsule = [ 0.5, 0.5, 2.5, 2.5, 2 ];
  test.identical( oldProjCapsule, projCapsule );

  /* */

  test.case = 'Capsule projected';

  var dstCapsule = [ 0, 0, 0, 1, 0, 0, 2 ];
  var projCapsule = [ -0.5, 1, 0, 1.5, 1, 0, 6 ];
  var expected = _.capsule.tools.long.make( [ [ 0, 1, 0 ], 2, 3 ] );

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Capsule expanded';

  var dstCapsule = [ 0, 0, 0, 2, 2, 2, 1 ];
  var projCapsule = [ -1, -1, -1, 3, 3, 3, 2 ];
  var expected = _.capsule.tools.long.make( [ [ 0, 0, 0 ], 2, 2 ] );

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Capsule contracted';

  var dstCapsule = [ 0, 0, 0, 2, 2, 2, 1 ];
  var projCapsule = [ 0.5, 0.5, 0.5, 1.5, 1.5, 1.5, 0.5 ];
  var expected = _.capsule.tools.long.make( [ [ 0, 0, 0 ], 0.5, 0.5 ] );

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Capsule translated';

  var dstCapsule = [ 0, 0, 0, 2, 2, 2, 1 ];
  var projCapsule = [ 1, 2, 3, 3, 4, 5, 1 ];
  var expected = _.capsule.tools.long.make( [ [ 1, 2, 3 ], 1, 1 ] );

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Capsule reduced to point';

  var dstCapsule = [ 0, 0, 0, 2, 2, 2, 1 ];
  var projCapsule = [ 2, 3, 4, 2, 3, 4, 0 ];
  var expected = _.capsule.tools.long.make( [ [ 1, 2, 3 ], 0, 0 ] );

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Capsule reduced to a sphere';

  var dstCapsule = [ 0, 0, 0, 2, 2, 2, 1 ];
  var projCapsule = [ 2, 3, 4, 2, 3, 4, 1 ];
  var expected = _.capsule.tools.long.make( [ [ 1, 2, 3 ], 0, 1 ] );

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Capsule NOT projected ( empty project array )';

  var dstCapsule = [ 0, 0, 0, 2, 2, 2, 3 ];
  var projCapsule = [ 0, 0, 0, 2, 2, 2, 3 ];
  var expected = _.capsule.tools.long.make( [ [ 0, 0, 0 ], 1, 1 ] );

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Null capsule of four dimensions projected';

  var dstCapsule = [ -0.5, -0.5, -0.5, -0.5, 0.5, 0.5, 0.5, 0.5, 1 ];
  var projCapsule = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1, 4 ];
  var expected = _.capsule.tools.long.make( [ [ 0, 0, 0, 0 ], 2, 4 ] );

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Capsule of 1 dimension projected';

  var dstCapsule = [ 0, 1, 1 ];
  var projCapsule = [ 0.5, 2.5, 1 ];
  var expected = _.capsule.tools.long.make( [ [ 1 ], 2, 1 ] );

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Point to capsule';

  var dstCapsule = [ 3, 4, 3, 4, 0 ];
  var projCapsule = [ 5, 5, 7, 8, 0 ];
  var expected = 0;

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Sphere to capsule';

  var dstCapsule = [ 3, 4, 3, 4, 1 ];
  var projCapsule = [ 5, 5, 7, 8, 1 ];
  var expected = 0;

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Segment to capsule';

  var dstCapsule = [ 3, 4, 3, 5, 0 ];
  var projCapsule = [ 5, 5, 7, 8, 1 ];
  var expected = 0;

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Capsules not parallel';

  var dstCapsule = [ 3, 4, 3, 5, 1 ];
  var projCapsule = [ 5, 5, 7, 5, 1 ];
  var expected = 0;

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.identical( gotFactors, expected );

  // Test cases including _.capsule.project()

  /* */

  test.case = 'Two equal capsules';

  var dstCapsule = [ 0, 0, 1, 1, 1 ];
  var projCapsule = [ 0, 0, 1, 1, 1 ];
  var expected = _.capsule.tools.long.make( [ [ 0, 0 ], 1, 1 ] );

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.identical( gotFactors, expected );

  var gotCapsule = _.capsule.project( dstCapsule, gotFactors );
  test.identical( gotCapsule, projCapsule );

  /* */

  test.case = 'Two equal point capsules';

  var dstCapsule = [ 3, 4, 3, 4, 0 ];
  var projCapsule = [ 3, 4, 3, 4, 0 ];
  var expected = _.capsule.tools.long.make( [ [ 0, 0 ], 1, 1 ] );

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.identical( gotFactors, expected );

  var gotCapsule = _.capsule.project( dstCapsule, gotFactors );
  test.identical( gotCapsule, projCapsule );

  /* */

  test.case = 'Point to point';

  var dstCapsule = [ 3, 4, 3, 4, 0 ];
  var projCapsule = [ 5, 5, 5, 5, 0 ];
  var expected = _.capsule.tools.long.make( [ [ 2, 1 ], 1, 1 ] );

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.identical( gotFactors, expected );

  var gotCapsule = _.capsule.project( dstCapsule, gotFactors );
  test.identical( gotCapsule, projCapsule );

  /* */

  test.case = 'Capsule to point';

  var dstCapsule = [ 3, 4, 6, 7, 1 ];
  var projCapsule = [ 5, 5, 5, 5, 0 ];
  var expected = _.capsule.tools.long.make( [ [ 0.5, -0.5 ], 0, 0 ] );

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.identical( gotFactors, expected );

  var gotCapsule = _.capsule.project( dstCapsule, gotFactors );
  test.identical( gotCapsule, projCapsule );

  /* */

  test.case = 'Capsule translated';

  var dstCapsule = [ 3, 4, 6, 7, 2 ];
  var projCapsule = [ -1, 8, 2, 11, 2 ];
  var expected = _.capsule.tools.long.make( [ [ -4, 4 ], 1, 1 ] );

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.identical( gotFactors, expected );

  var gotCapsule = _.capsule.project( dstCapsule, gotFactors );
  test.identical( gotCapsule, projCapsule );

  /* */

  test.case = 'Capsule contracted';

  var dstCapsule = [ 0, 0, 4, 4, 2 ];
  var projCapsule = [ 1, 1, 3, 3, 1 ];
  var expected = _.capsule.tools.long.make( [ [ 0, 0 ], 0.5, 0.5 ] );

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.identical( gotFactors, expected );

  var gotCapsule = _.capsule.project( dstCapsule, gotFactors );
  test.identical( gotCapsule, projCapsule );

  /* */

  test.case = 'Capsule expanded';

  var dstCapsule = [ 0, 0, 4, 4, 1 ];
  var projCapsule = [ -1, -1, 5, 5, 3/2 ];
  var expected = _.capsule.tools.long.make( [ [ 0, 0 ], 3/2, 3/2 ] );

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.equivalent( gotFactors, expected );

  var gotCapsule = _.capsule.project( dstCapsule, gotFactors );
  test.equivalent( gotCapsule, projCapsule );

  /* */

  test.case = 'Capsule expanded on length and contracted on radius';

  var dstCapsule = [ 0, 0, 4, 4, 4 ];
  var projCapsule = [ -1, -1, 5, 5, 1 ];
  var expected = _.capsule.tools.long.make( [ [ 0, 0 ], 3/2, 0.25 ] );

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.equivalent( gotFactors, expected );

  var gotCapsule = _.capsule.project( dstCapsule, gotFactors );
  test.equivalent( gotCapsule, projCapsule );

  /* */

  test.case = 'Capsule projected';

  var dstCapsule = [ 0, 0, 4, 4, 2 ];
  var projCapsule = [ -7, -3, 9, 13, 4 ];
  var expected = _.capsule.tools.long.make( [ [ -1, 3 ], 4, 2 ] );

  var gotFactors = _.capsule.getProjectionFactors( dstCapsule, projCapsule );
  test.identical( gotFactors, expected );

  var gotCapsule = _.capsule.project( dstCapsule, gotFactors );
  test.identical( gotCapsule, projCapsule );

  /* */

  if( !Config.debug )
  return;

  /* */

  test.case = 'No arguments';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.getProjectionFactors();
  });

  /* */

  test.case = 'Wrong type of argument - string';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.getProjectionFactors( 'capsule', 'projCapsule' );
  });

  /* */

  test.case = 'Wrong type of argument - null';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.getProjectionFactors( null, [ 0, 1, 2, 3, 1 ] );
  });

  /* */

  test.case = 'Wrong type of argument - null';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.getProjectionFactors( [ 0, 1, 2, 3, 1 ], null );
  });

  /* */

  test.case = 'Wrong type of argument - undefined';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.getProjectionFactors( undefined, [ 0, 1, 2, 3, 1 ] );
  });

  /* */

  test.case = 'Wrong type of argument - undefined';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.getProjectionFactors( [ 0, 1, 2, 3, 1 ], undefined );
  });

  /* */

  test.case = 'Empty arguments';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.getProjectionFactors( [], [] );
  });

  /* */

  test.case = 'Too few arguments';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.getProjectionFactors( [ 0, 0, 0, 0, 0, 0, 0 ] );
  });

  /* */

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.getProjectionFactors( [ 0, 0, 1 ], [ 1, 0, 1 ], [ 0, 1, 1 ] );
  });

  /* */

  test.case = 'Wrong project array dimension (capsule 3D vs capsule 4D)';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.getProjectionFactors( [ 0, 0, 0, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 0, 1, 0, 2, 1 ] );
  });

  /* */

  test.case = 'Wrong project array dimension (capsule 3D vs capsule 2D)';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.getProjectionFactors( [ 0, 0, 0, 0, 0, 0, 1 ], [ 0, 1, 2, 3, 1 ] );
  });

  /* */

  test.case = 'Wrong project array dimension (capsule 2D vs capsule 1D)';
  test.shouldThrowErrorSync( function()
  {
    _.capsule.getProjectionFactors( [ 0, 0, 0, 0, 1 ], [ 0, 2, 1 ] );
  });

}

//

function pointContains( test )
{

  /* */

  test.case = 'Capsule and Point remain unchanged';

  var capsule = [  - 1,  - 1 , 1, 1, 1 ];
  var point = [ 0, 0 ];
  var expected = true;

  var gotBool = _.capsule.pointContains( capsule, point );
  test.identical( gotBool, expected );

  var oldCapsule = [  - 1,  - 1 , 1, 1, 1 ];
  test.identical( capsule, oldCapsule );

  var oldPoint = [ 0, 0 ];
  test.identical( point, oldPoint );

  /* */

  test.case = 'Null capsule contains point';

  var capsule = null;
  var point = [ 0, 0, 0 ];
  var expected = true;

  var gotBool = _.capsule.pointContains( capsule, point );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'Point capsule contains Point';

  var capsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = true;

  var gotBool = _.capsule.pointContains( capsule, point );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'Capsule capsule contains point';

  var capsule = [ 0, 0, 0, 2, 2, 2, 0 ];
  var point = [  1, 1, 1 ];
  var expected = true;

  var gotBool = _.capsule.pointContains( capsule, point );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'Capsule capsule doesn´t contain point';

  var capsule = [ 0, 0, 0, 2, 2, 2, 0 ];
  var point = [  1, 1, 1.1 ];
  var expected = false;

  var gotBool = _.capsule.pointContains( capsule, point );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'Sphere capsule contains point';

  var capsule = [ 0, 0, 0, 0, 0, 0, 1 ];
  var point = [  1, 0, 0 ];
  var expected = true;

  var gotBool = _.capsule.pointContains( capsule, point );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'Sphere capsule doesn´t contain point';

  var capsule = [ 0, 0, 0, 0, 0, 0, 1 ];
  var point = [  1, 1, 0 ];
  var expected = false;

  var gotBool = _.capsule.pointContains( capsule, point );
  test.identical( gotBool,  expected );


  /* */

  test.case = 'Capsule under point';

  var capsule = [ 0, 0, 0, 0, 0, 2, 1 ];
  var point = [ 0, 1, 4 ];
  var expected = false;

  var gotBool = _.capsule.pointContains( capsule, point );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'Point closer to origin';

  var capsule = [ 0, 0, 0, 0, 0, 2, 1 ];
  var point = [ 0, 0, -2 ];
  var expected = false;

  var gotBool = _.capsule.pointContains( capsule, point );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'Capsule of four dimensions contains point';

  var capsule = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.capsule.pointContains( capsule, point );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'Capsule of four dimensions doesn´t contain point';

  var capsule = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0 , 2 ];
  var expected = false;

  var gotBool = _.capsule.pointContains( capsule, point );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'Capsule of 1 dimension contains point';

  var capsule = [ 0, 2, 1 ];
  var point = [ 1 ];
  var expected = true;

  var gotBool = _.capsule.pointContains( capsule, point );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'Capsule of 1 dimension desn´t contain point ';

  var capsule = [ 0, 2, 1 ];
  var point = [ - 3 ];
  var expected = false;

  var gotBool = _.capsule.pointContains( capsule, point );
  test.identical( gotBool,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.pointContains( ) );
  test.shouldThrowErrorSync( () => _.capsule.pointContains( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.pointContains( 'capsule', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.pointContains( [ 1, 1, 2, 2, 1 ], 'capsule') );
  test.shouldThrowErrorSync( () => _.capsule.pointContains( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.pointContains( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.pointContains( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.pointContains( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.pointContains( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.pointContains( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.pointContains( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function pointDistance( test )
{

  /* */

  test.case = 'Capsule and Point remain unchanged';

  var capsule = [  - 1,  - 1 , 1, 1, 0 ];
  var point = [ 0, 0 ];
  var expected = 0;

  var gotDistance = _.capsule.pointDistance( capsule, point );
  test.identical( gotDistance, expected );

  var oldCapsule = [  - 1,  - 1 , 1, 1, 0 ];
  test.identical( capsule, oldCapsule );

  var oldPoint = [ 0, 0 ];
  test.identical( point, oldPoint );

  /* */

  test.case = 'Null capsule Distance empty point';

  var capsule = null;
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotDistance = _.capsule.pointDistance( capsule, point );
  test.identical( gotDistance,  expected );

  /* */

  test.case = 'Point capsule Distance same Point';

  var capsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotDistance = _.capsule.pointDistance( capsule, point );
  test.identical( gotDistance,  expected );

  /* */

  test.case = 'Point capsule Distance other Point';

  var capsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var point = [ 3, 4, 0 ];
  var expected = 5;

  var gotDistance = _.capsule.pointDistance( capsule, point );
  test.identical( gotDistance,  expected );

  /* */

  test.case = 'Capsule contains point in the middle';

  var capsule = [ 0, 0, 0, 2, 2, 2, 1 ];
  var point = [  1, 1, 1 ];
  var expected = 0;

  var gotDistance = _.capsule.pointDistance( capsule, point );
  test.identical( gotDistance,  expected );

  /* */

  test.case = 'Capsule contains point';

  var capsule = [ 0, 0, 0, 2, 2, 2, 1 ];
  var point = [  1, 1, 1.5 ];
  var expected = 0;

  var gotDistance = _.capsule.pointDistance( capsule, point );
  test.identical( gotDistance,  expected );

  /* */

  test.case = 'Capsule under point';

  var capsule = [ 0, 0, 0, 0, 0, 2, 1 ];
  var point = [ 0, 1, 4 ];
  var expected = Math.sqrt( 5 ) - 1;

  var gotDistance = _.capsule.pointDistance( capsule, point );
  test.identical( gotDistance,  expected );

  /* */

  test.case = 'Point closer to origin';

  var capsule = [ 0, 0, 0, 0, 0, 2, 1 ];
  var point = [ 0, 0, - 2 ];
  var expected = 1;

  var gotDistance = _.capsule.pointDistance( capsule, point );
  test.identical( gotDistance,  expected );

  /* */

  test.case = 'Capsule of four dimensions distance ';

  var capsule = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1, 2 ];
  var point = [ 0, 0, 0 , 4 ];
  var expected = Math.sqrt( 12 ) - 2;

  var gotDistance = _.capsule.pointDistance( capsule, point );
  test.identical( gotDistance,  expected );

  /* */

  test.case = 'Capsule of 1 dimension contains point';

  var capsule = [ 0, 2, 1 ];
  var point = [ 1 ];
  var expected = 0;

  var gotDistance = _.capsule.pointDistance( capsule, point );
  test.identical( gotDistance,  expected );

  /* */

  test.case = 'Capsule of 1 dimension distance';

  var capsule = [ 0, 2, 2 ];
  var point = [ - 3 ];
  var expected = 1;

  var gotDistance = _.capsule.pointDistance( capsule, point );
  test.identical( gotDistance,  expected );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.pointDistance( ) );
  test.shouldThrowErrorSync( () => _.capsule.pointDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.pointDistance( 'capsule', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.pointDistance( [ 1, 1, 2, 2 ], 'point') );
  test.shouldThrowErrorSync( () => _.capsule.pointDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.pointDistance( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.pointDistance( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.pointDistance( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.pointDistance( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.pointDistance( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.pointDistance( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function pointClosestPoint( test )
{

  /* */

  test.case = 'Capsule and Point remain unchanged';

  var capsule = [  - 1, - 1 , 1, 1, 1 ];
  var point = [ 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 0, 0 ] );

  var gotClosestPoint = _.capsule.pointClosestPoint( capsule, point );
  test.identical( gotClosestPoint, expected );

  var oldCapsule = [  - 1, - 1 , 1, 1, 1 ];
  test.identical( capsule, oldCapsule );

  var oldPoint = [ 0, 0 ];
  test.identical( point, oldPoint );

  /* */

  test.case = 'Null capsule - empty point';

  var capsule = null;
  var point = [ 0, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 0, 0, 0 ] );

  var gotClosestPoint = _.capsule.pointClosestPoint( capsule, point );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Point capsule - same Point';

  var capsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 0, 0, 0 ] );

  var gotClosestPoint = _.capsule.pointClosestPoint( capsule, point );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Point capsule - other Point';

  var capsule = [ 1, 2, 3, 0, 0, 0, 0 ];
  var point = [ 3, 4, 5 ];
  var expected = _.capsule.tools.long.make( [ 1, 2, 3 ] );

  var gotClosestPoint = _.capsule.pointClosestPoint( capsule, point );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule contains point in the middle';

  var capsule = [ 0, 0, 0, 2, 2, 2, 1 ];
  var point = [ 1, 1, 1 ];
  var expected = _.capsule.tools.long.make( [ 1, 1, 1 ] );

  var gotClosestPoint = _.capsule.pointClosestPoint( capsule, point );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule contains point';

  var capsule = [ 0, 0, 0, 2, 2, 2, 1 ];
  var point = [ 1.2, 0.9, 1.3 ];
  var expected = _.capsule.tools.long.make( [ 1.2, 0.9, 1.3 ] );

  var gotClosestPoint = _.capsule.pointClosestPoint( capsule, point );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule under point';

  var capsule = [ 0, 0, 0, 0, 0, 2, 1 ];
  var point = [ 0, 0, 4 ];
  var expected = _.capsule.tools.long.make( [ 0, 0, 3 ] );

  var gotClosestPoint = _.capsule.pointClosestPoint( capsule, point );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Point closer to origin';

  var capsule = [ 0, 0, 0, 2, 2, 2, 1 ];
  var point = [ - 2, - 2, - 2 ];
  var expected = _.capsule.tools.long.make( [ - 1 /Math.sqrt( 3 ), - 1 /Math.sqrt( 3 ), - 1 /Math.sqrt( 3 ) ] );

  var gotClosestPoint = _.capsule.pointClosestPoint( capsule, point );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule of four dimensions distance ';

  var capsule = [ - 1, - 1, - 1, - 1, 3, 3, 3, 3, 1 ];
  var point = [ 0, 0, 0, 2 ];
  var expected = _.capsule.tools.long.make( [ 0.21132486540518708, 0.21132486540518708, 0.21132486540518708, 1.3660254037844388 ] );

  var gotClosestPoint = _.capsule.pointClosestPoint( capsule, point );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule of 1 dimension contains point';

  var capsule = [ 0, 2, 1 ];
  var point = [ 1 ];
  var expected = [ 1 ];

  var gotClosestPoint = _.capsule.pointClosestPoint( capsule, point );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule of 1 dimension distance';

  var capsule = [ 0, 2, 1 ];
  var point = [ - 3 ];
  var expected = [ -1 ];

  var gotClosestPoint = _.capsule.pointClosestPoint( capsule, point );
  test.identical( gotClosestPoint, expected );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.pointClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.capsule.pointClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.pointClosestPoint( 'capsule', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.pointClosestPoint( [ 1, 1, 2, 2 ], 'point') );
  test.shouldThrowErrorSync( () => _.capsule.pointClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.pointClosestPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.pointClosestPoint( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.pointClosestPoint( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.pointClosestPoint( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.pointClosestPoint( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.pointClosestPoint( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function boxContains( test )
{

  /* */

  test.case = 'Capsule and box remain unchanged';

  var capsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.capsule.boxContains( capsule, box );
  test.identical( gotBool, expected );

  var oldCapsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  test.identical( capsule, oldCapsule );

  var oldBox = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( box, oldBox );

  /* */

  test.case = 'Null capsule - empty box';

  var capsule = null;
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = true;

  var gotBool = _.capsule.boxContains( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point capsule - same box';

  var capsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = true;

  var gotBool = _.capsule.boxContains( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point capsule - no intersection';

  var capsule = [ 1, 2, 3, 1, 2, 2, 0.5 ];
  var box = [ 1, 2, 4, 3, 4, 0 ];
  var expected = false;

  var gotBool = _.capsule.boxContains( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point capsule in box';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0 ];
  var box = [ 1, 2, 2, 3, 4, 4 ];
  var expected = false;

  var gotBool = _.capsule.boxContains( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Capsule contains box';

  var capsule = [ -2, -2, -2, 2, 2, 2, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.capsule.boxContains( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Capsule and box intersect';

  var capsule = [ 0, 0, 0, 0, 0, 2, 1 ];
  var box = [ 0, 0, 2, 4, 4, 5 ];
  var expected = false;

  var gotBool = _.capsule.boxContains( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Capsule over box';

  var capsule = [ 0, 0, 4, 0, 0, 6, 0.5 ];
  var box = [ 0, 1, 1, 3, 7, 3 ];
  var expected = false;

  var gotBool = _.capsule.boxContains( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'box closer to origin';

  var capsule = [ 0, 0, 0, 2, 2, 2, 0.75 ];
  var box = [ - 2, - 2, - 2, -1, -1, -1 ];
  var expected = false;

  var gotBool = _.capsule.boxContains( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = '2D intersection';

  var capsule = [ 0, 0, 2, 2, 1 ];
  var box = [ 1, 2, 3, 4 ];
  var expected = false;

  var gotBool = _.capsule.boxContains( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = '2D no intersection';

  var capsule = [ 0, 0, 2, -2, 1 ];
  var box = [ 1, 2, 3, 4 ];
  var expected = false;

  var gotBool = _.capsule.boxContains( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = '2D contained';

  var capsule = [ 0, 0, 2, 2, 1 ];
  var box = [ 1, 1, 2, 2 ];
  var expected = true;

  var gotBool = _.capsule.boxContains( capsule, box );
  test.identical( gotBool, expected );


  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.boxContains( ) );
  test.shouldThrowErrorSync( () => _.capsule.boxContains( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boxContains( 'capsule', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boxContains( [ 1, 1, 2, 2, 1 ], 'box') );
  test.shouldThrowErrorSync( () => _.capsule.boxContains( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.boxContains( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boxContains( [ 1, 1, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.boxContains( [ 1, 1, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.boxContains( [ 1, 1, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.boxContains( [ 1, 1, 2, 2 ], [ 1, 1, 2, 2 ] ) );

}

//

function boxIntersects( test )
{

  /* */

  test.case = 'Capsule and box remain unchanged';

  var capsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.capsule.boxIntersects( capsule, box );
  test.identical( gotBool, expected );

  var oldCapsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  test.identical( capsule, oldCapsule );

  var oldBox = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( box, oldBox );

  /* */

  test.case = 'Null capsule - empty box';

  var capsule = null;
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = true;

  var gotBool = _.capsule.boxIntersects( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point capsule - same box';

  var capsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = true;

  var gotBool = _.capsule.boxIntersects( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point capsule - no intersection';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0 ];
  var box = [ 1, 2, 4, 3, 4, 0 ];
  var expected = false;

  var gotBool = _.capsule.boxIntersects( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'sphere capsule in box';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0.1 ];
  var box = [ 1, 2, 2, 3, 4, 4 ];
  var expected = true;

  var gotBool = _.capsule.boxIntersects( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Capsule contains box';

  var capsule = [ -2, -2, -2, 2, 2, 2, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.capsule.boxIntersects( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Capsule and box intersect';

  var capsule = [ 0, 0, -2, 0, 0, 2, 1 ];
  var box = [ 0, 0, 1, 4, 4, 4 ];
  var expected = true;

  var gotBool = _.capsule.boxIntersects( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Capsule over box';

  var capsule = [ 0, 0, 4, 0, 0, 6, 0.5 ];
  var box = [ 0, 1, 1, 3, 7, 3 ];
  var expected = false;

  var gotBool = _.capsule.boxIntersects( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'box closer to origin';

  var capsule = [ 0, 0, 0, 2, 2, 2, 0.75 ];
  var box = [ - 2, - 2, - 2, -1, -1, -1 ];
  var expected = false;

  var gotBool = _.capsule.boxIntersects( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = '2D intersection';

  var capsule = [ 0, 0, 2, 2, 0.2 ];
  var box = [ 1, 2, 3, 4 ];
  var expected = true;

  var gotBool = _.capsule.boxIntersects( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = '2D no intersection';

  var capsule = [ 0, 0, 2, -2, 0.3 ];
  var box = [ 1, 2, 3, 4 ];
  var expected = false;

  var gotBool = _.capsule.boxIntersects( capsule, box );
  test.identical( gotBool, expected );


  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.boxIntersects( ) );
  test.shouldThrowErrorSync( () => _.capsule.boxIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boxIntersects( 'capsule', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boxIntersects( [ 1, 1, 2, 2, 1 ], 'box') );
  test.shouldThrowErrorSync( () => _.capsule.boxIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.boxIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boxIntersects( [ 1, 1, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.boxIntersects( [ 1, 1, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.boxIntersects( [ 1, 1, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.boxIntersects( [ 1, 1, 2, 2 ], [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boxIntersects( [ 1, 1, 2, 2, -1 ], [ 1, 1, 2, 2 ] ) );

}

//

function boxDistance( test )
{
  /* */

  test.case = 'Capsule and box remain unchanged';

  var capsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotBool = _.capsule.boxDistance( capsule, box );
  test.identical( gotBool, expected );

  var oldCapsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  test.identical( capsule, oldCapsule );

  var oldBox = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( box, oldBox );

  /* */

  test.case = 'Null capsule - empty box';

  var capsule = null;
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotBool = _.capsule.boxDistance( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'box capsule - same box';

  var capsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotBool = _.capsule.boxDistance( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point capsule';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0 ];
  var box = [ 1, 2, 4, 3, 4, 5 ];
  var expected = 1;

  var gotBool = _.capsule.boxDistance( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'sphere capsule in box';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0.1 ];
  var box = [ 1, 2, 2, 3, 4, 4 ];
  var expected = 0;

  var gotBool = _.capsule.boxDistance( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Capsule and box intersect';

  var capsule = [ -2, -2, -2, 2, 2, 2, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotBool = _.capsule.boxDistance( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Capsule over box';

  var capsule = [ 0, 0, 4, 0, 0, 6, 1 ];
  var box = [ 0, 1, 1, 3, 7, 3 ];
  var expected = Math.sqrt( 2 ) - 1;

  var gotBool = _.capsule.boxDistance( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'box corner closer to origin';

  var capsule = [ 0, 0, 0, 2, 2, 2, 0.5 ];
  var box = [ - 2, - 2, - 2, -1, -1, -1 ];
  var expected = Math.sqrt( 3 ) - 0.5;

  var gotBool = _.capsule.boxDistance( capsule, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'box side closer to origin';

  var capsule = [ 0, 0, 0, 2, 2, 2, 0.2 ];
  var box = [ -1, -1, -1, 0.5, 0.5, - 0.3 ];
  var expected = 0.1;

  var gotBool = _.capsule.boxDistance( capsule, box );
  test.equivalent( gotBool, expected );

  /* */

  test.case = '2D';

  var capsule = [ 2, 2, 3, 3, 1 ];
  var box = [ 0, 0, 1, 1 ];
  var expected = Math.sqrt( 2 ) - 1;

  var gotBool = _.capsule.boxDistance( capsule, box );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.boxDistance( ) );
  test.shouldThrowErrorSync( () => _.capsule.boxDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boxDistance( 'capsule', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boxDistance( [ 1, 1, 2, 2, 1 ], 'box') );
  test.shouldThrowErrorSync( () => _.capsule.boxDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.boxDistance( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boxDistance( [ 1, 1, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.boxDistance( [ 1, 1, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.boxDistance( [ 1, 1, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.boxDistance( [ 1, 1, 2, 2 ], [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boxDistance( [ 1, 1, 2, 2, -1 ], [ 1, 1, 2, 2 ] ) );

}

//

function boxClosestPoint( test )
{
  /* */

  test.case = 'Capsule and box remain unchanged';

  var capsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotPoint = _.capsule.boxClosestPoint( capsule, box );
  test.identical( gotPoint, expected );

  var oldCapsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  test.identical( capsule, oldCapsule );

  var oldBox = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( box, oldBox );

  /* */

  test.case = 'Null capsule - empty box';

  var capsule = null;
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotPoint = _.capsule.boxClosestPoint( capsule, box );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'box capsule - same box';

  var capsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotPoint = _.capsule.boxClosestPoint( capsule, box );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'point capsule';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0 ];
  var box = [ 1, 2, 4, 3, 4, 0 ];
  var expected = _.capsule.tools.long.make( [ 1, 2, 3 ] );

  var gotPoint = _.capsule.boxClosestPoint( capsule, box );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'sphere capsule in box';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0.1 ];
  var box = [ 1, 2, 2, 3, 4, 4 ];
  var expected = 0;

  var gotPoint = _.capsule.boxClosestPoint( capsule, box );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Capsule and box intersect';

  var capsule = [ -2, -2, -2, 2, 2, 2, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotPoint = _.capsule.boxClosestPoint( capsule, box );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Capsule over box';

  var capsule = [ 0, 0, 4, 0, 0, 6, 0.5 ];
  var box = [ 0, 1, 1, 3, 7, 3 ];
  var expected = _.capsule.tools.long.make( [ 0, 0.35355339059327373, 3.646446609406726 ] );

  var gotPoint = _.capsule.boxClosestPoint( capsule, box );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'box corner closer to origin';

  var capsule = [ 0, 0, 0, 2, 2, 2, 1 ];
  var box = [ - 2, - 2, - 2, -1, -1, -1 ];
  var expected = _.capsule.tools.long.make( [ - 1 / Math.sqrt( 3 ), - 1 / Math.sqrt( 3 ), - 1 / Math.sqrt( 3 ) ] );

  var gotPoint = _.capsule.boxClosestPoint( capsule, box );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'box side closer to origin';

  var capsule = [ 0, 0, 0, 2, 2, 2, 0.1 ];
  var box = [ -1, -1, -1, 0.5, 0.5, - 0.3 ];
  var expected = _.capsule.tools.long.make( [ 0, 0, - 0.1 ] );

  var gotPoint = _.capsule.boxClosestPoint( capsule, box );
  test.equivalent( gotPoint, expected );

  /* */

  test.case = 'box corner closer to end';

  var capsule = [ 0, 0, 0, 2, 2, 2, 1 ];
  var box = [ 6, 6, 8, 6, 9, 10 ];
  var expected = _.capsule.tools.long.make( [ 2.485071250072666, 2.485071250072666, 2.727606875108999 ] );

  var gotPoint = _.capsule.boxClosestPoint( capsule, box );
  test.identical( gotPoint, expected );

  /* */

  test.case = '2D';

  var capsule = [ 0, 0, 2, 10, 1 ];
  var box = [ 6, 7, 10, 8 ];
  var expected = _.capsule.tools.long.make( [ 2.7498114449216895, 8.650037711015663 ] );

  var gotPoint = _.capsule.boxClosestPoint( capsule, box );
  test.equivalent( gotPoint, expected, _.accuracySqrt );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.boxClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.capsule.boxClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boxClosestPoint( 'capsule', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boxClosestPoint( [ 1, 1, 2, 2 ], 'box') );
  test.shouldThrowErrorSync( () => _.capsule.boxClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.boxClosestPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boxClosestPoint( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.boxClosestPoint( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.boxClosestPoint( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.boxClosestPoint( [ 1, 1, 2, 2 ], [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boxClosestPoint( [ 1, 1, 2, 2, -1 ], [ 1, 1, 2, 2 ] ) );

}

//

function boundingBoxGet( test )
{

  /* */

  test.case = 'Source capsule remains unchanged';

  var srcCapsule = [ 0, 0, 0, 3, 3, 3, 1 ];
  var dstBox = [ 1, 1, 1, 2, 2, 2 ];
  var expected = _.capsule.tools.long.make( [ - 1, - 1, - 1, 4, 4, 4  ] );

  var gotBox = _.capsule.boundingBoxGet( dstBox, srcCapsule );
  test.identical( expected, gotBox );
  test.true( dstBox === gotBox );

  var oldSrcCapsule = [ 0, 0, 0, 3, 3, 3, 1 ];
  test.identical( srcCapsule, oldSrcCapsule );

  /* */

  test.case = 'Zero capsule to zero box';

  var srcCapsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var dstBox = [ 0, 0, 0, 1, 1, 1 ];
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, 0, 0, 0 ] );

  var gotBox = _.capsule.boundingBoxGet( dstBox, srcCapsule );
  test.identical( gotBox, expected );

  /* */

  test.case = 'Capsule inside box';

  var srcCapsule = [ 1, 1, 1, 4, 4, 4, 0.1 ];
  var dstBox = [ 0, 0, 0, 5, 5, 5 ];
  var expected = _.capsule.tools.long.make( [ 0.9, 0.9, 0.9, 4.1, 4.1, 4.1 ] );

  var gotBox = _.capsule.boundingBoxGet( dstBox, srcCapsule );
  test.equivalent( gotBox, expected );

  /* */

  test.case = 'Capsule outside Box';

  var srcCapsule = [ - 1, - 1, - 1, 1, 1, 1, 0.5 ];
  var dstBox = [ - 3, - 4, - 5, - 5, - 4, - 2 ];
  var expected = _.capsule.tools.long.make( [ - 1.5, - 1.5, - 1.5, 1.5, 1.5, 1.5 ] );

  var gotBox = _.capsule.boundingBoxGet( dstBox, srcCapsule );
  test.identical( gotBox, expected );

  /* */

  test.case = 'Point capsule and point Box';

  var srcCapsule = [ 1, 2, 3, 1, 2, 3, 0 ];
  var dstBox = [ 3, 3, 3, 4, 4, 4 ];
  var expected = _.capsule.tools.long.make( [ 1, 2, 3, 1, 2, 3 ] );

  var gotBox = _.capsule.boundingBoxGet( dstBox, srcCapsule );
  test.identical( gotBox, expected );

  /* */

  test.case = 'Sphere capsule';

  var srcCapsule = [ 1, 2, 3, 1, 2, 3, 1 ];
  var dstBox = [ 3, 3, 3, 4, 4, 4 ];
  var expected = _.capsule.tools.long.make( [ 0, 1, 2, 2, 3, 4 ] );

  var gotBox = _.capsule.boundingBoxGet( dstBox, srcCapsule );
  test.identical( gotBox, expected );

  /* */

  test.case = 'srcCapsule vector';

  var srcCapsule = _.vectorAdapter.from( [ - 8, - 5, 4.5, 4, 7, 16.5, 2 ] );
  var dstBox = [ 1, - 1, 5, 0, 3, 2 ];
  var expected = _.capsule.tools.long.make( [ - 10, - 7, 2.5, 6, 9, 18.5 ] );

  var gotBox = _.capsule.boundingBoxGet( dstBox, srcCapsule );
  test.identical( gotBox, expected );

  /* */

  test.case = 'dstBox vector - 2D';

  var srcCapsule = [ - 1, 0, - 2, 3, 1 ];
  var dstBox = _.vectorAdapter.from( [ 1, 2, 3, 9 ] );
  var expected = _.capsule.tools.vectorAdapter.from( [ - 3, - 1, 0, 4 ] );

  var gotBox = _.capsule.boundingBoxGet( dstBox, srcCapsule );
  test.identical( gotBox, expected );

  /* */

  test.case = 'dstBox null';

  var srcCapsule = [ 2.2, 3.3, - 4.4, 1, 0 ];
  var dstBox = null;
  var expected = _.capsule.tools.long.make( [ - 4.4, 1, 2.2, 3.3 ] );

  var gotBox = _.capsule.boundingBoxGet( dstBox, srcCapsule );
  test.equivalent( gotBox, expected );

  /* */

  test.case = 'dstBox undefined';

  var srcCapsule = [ - 1, - 3, - 5, 0, 0.5 ];
  var dstBox = undefined;
  var expected = _.capsule.tools.long.make( [  - 5.5, - 3.5, - 0.5, 0.5 ] );

  var gotBox = _.capsule.boundingBoxGet( dstBox, srcCapsule );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.boundingBoxGet( ) );
  test.shouldThrowErrorSync( () => _.capsule.boundingBoxGet( [] ) );
  test.shouldThrowErrorSync( () => _.capsule.boundingBoxGet( [], [] ) );
  test.shouldThrowErrorSync( () => _.capsule.boundingBoxGet( 'box', 'capsule' ) );
  test.shouldThrowErrorSync( () => _.capsule.boundingBoxGet( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boundingBoxGet( [ 1, 0, 1, 2, 1, 2 ], [ 0, 0, 0, 1, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boundingBoxGet( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boundingBoxGet( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 3, 4, - 1 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boundingBoxGet( NaN, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boundingBoxGet( [ 0, 1, 0, 1, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.boundingBoxGet( [ 0, 1, 0, 1, 2, 1 ], NaN ) );
  test.shouldThrowErrorSync( () => _.capsule.boundingBoxGet( [ 0, 1, 0, 1, 2 ], [ 0, 0, 1 ] ) );

}

//

function capsuleContains( test )
{

  /* */

  test.case = 'Capsules remain unchanged';

  var capsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  var tstCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.capsule.capsuleContains( capsule, tstCapsule );
  test.identical( gotBool, expected );

  var oldCapsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  test.identical( capsule, oldCapsule );

  var oldTstCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  test.identical( tstCapsule, oldTstCapsule );

  /* */

  test.case = 'point capsule - same capsule';

  var capsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var tstCapsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var expected = true;

  var gotBool = _.capsule.capsuleContains( capsule, tstCapsule );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'point capsule - no intersection';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0 ];
  var tstCapsule = [ 1, 2, 4, 3, 4, 0, 0.5 ];
  var expected = false;

  var gotBool = _.capsule.capsuleContains( capsule, tstCapsule );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'sphere capsule in capsule';

  var capsule = [ 1, 2, 1, 1, 2, 3, 3 ];
  var tstCapsule = [ 1, 2, 2, 1, 2, 2, 1 ];
  var expected = true;

  var gotBool = _.capsule.capsuleContains( capsule, tstCapsule );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'Capsule contains capsule';

  var capsule = [ -2, -2, -2, 2, 2, 2, 2 ];
  var tstCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.capsule.capsuleContains( capsule, tstCapsule );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'Capsules intersect';

  var capsule = [ 0, 0, -2, 0, 0, 2, 1 ];
  var tstCapsule = [ 0, 0, 0, 0, 4, 0, 0.2 ];
  var expected = false;

  var gotBool = _.capsule.capsuleContains( capsule, tstCapsule );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'Capsule over capsule';

  var capsule = [ 0, 0, 4, 0, 0, 6, 0.5 ];
  var tstCapsule = [ 0, 1, 1, 3, 7, 3, 1 ];
  var expected = false;

  var gotBool = _.capsule.capsuleContains( capsule, tstCapsule );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'capsule closer to origin';

  var capsule = [ 0, 0, 0, 2, 2, 2, 0.75 ];
  var tstCapsule = [ - 2, - 2, - 2, -1, -1, -1, 0.1 ];
  var expected = false;

  var gotBool = _.capsule.capsuleContains( capsule, tstCapsule );
  test.identical( gotBool,  expected );

  /* */

  test.case = '2D contained';

  var capsule = [ 0, 0, 4, 4, 3 ];
  var tstCapsule = [ 1, 2, 3, 4, 1 ];
  var expected = true;

  var gotBool = _.capsule.capsuleContains( capsule, tstCapsule );
  test.identical( gotBool,  expected );

  /* */

  test.case = '2D intersection';

  var capsule = [ 0, 0, 2, 2, 0.2 ];
  var tstCapsule = [ 1, 2, 3, 4, 1 ];
  var expected = false;

  var gotBool = _.capsule.capsuleContains( capsule, tstCapsule );
  test.identical( gotBool,  expected );

  /* */

  test.case = '2D no intersection';

  var capsule = [ 0, 0, 2, -2, 0.3 ];
  var tstCapsule = [ 1, 2, 3, 4, 0.2 ];
  var expected = false;

  var gotBool = _.capsule.capsuleContains( capsule, tstCapsule );
  test.identical( gotBool,  expected );


  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.capsuleContains( ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleContains( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleContains( 'capsule', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleContains( [ 1, 1, 2, 2, 1 ], 'capsule') );
  test.shouldThrowErrorSync( () => _.capsule.capsuleContains( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleContains( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleContains( [ 1, 1, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleContains( [ 1, 1, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleContains( [ 1, 1, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleContains( [ 1, 1, 2, 2, 1 ], [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleContains( [ 1, 1, 2, 2 ], [ 1, 1, 2, 2, 1 ] ) );
  // test.shouldThrowErrorSync( () => _.capsule.capsuleContains( [ 1, 1, 2, 2, -1 ], [ 1, 1, 2, 2, 1 ] ) );
  // test.shouldThrowErrorSync( () => _.capsule.capsuleContains( [ 1, 1, 2, 2, 1 ], [ 1, 1, 2, 2, - 1 ] ) );

}

//

function capsuleIntersects( test )
{

  /* */

  test.case = 'Capsules remain unchanged';

  var capsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  var tstCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.capsule.capsuleIntersects( capsule, tstCapsule );
  test.identical( gotBool, expected );

  var oldCapsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  test.identical( capsule, oldCapsule );

  var oldTstCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  test.identical( tstCapsule, oldTstCapsule );

  /* */

  test.case = 'Null capsule - empty capsule';

  var capsule = null;
  var tstCapsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var expected = true;

  var gotBool = _.capsule.capsuleIntersects( capsule, tstCapsule );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point capsule - same capsule';

  var capsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var tstCapsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var expected = true;

  var gotBool = _.capsule.capsuleIntersects( capsule, tstCapsule );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point capsule - no intersection';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0 ];
  var tstCapsule = [ 1, 2, 4, 3, 4, 0, 0.5 ];
  var expected = false;

  var gotBool = _.capsule.capsuleIntersects( capsule, tstCapsule );
  test.identical( gotBool, expected );

  /* */

  test.case = 'sphere capsule in capsule';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0.1 ];
  var tstCapsule = [ 1, 2, 2, 3, 4, 4, 2 ];
  var expected = true;

  var gotBool = _.capsule.capsuleIntersects( capsule, tstCapsule );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Capsule contains capsule';

  var capsule = [ -2, -2, -2, 2, 2, 2, 2 ];
  var tstCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.capsule.capsuleIntersects( capsule, tstCapsule );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Capsules intersect';

  var capsule = [ 0, 0, -2, 0, 0, 2, 1 ];
  var tstCapsule = [ 0, 0, 0, 0, 4, 0, 0.2 ];
  var expected = true;

  var gotBool = _.capsule.capsuleIntersects( capsule, tstCapsule );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Capsule over capsule';

  var capsule = [ 0, 0, 4, 0, 0, 6, 0.5 ];
  var tstCapsule = [ 0, 1, 1, 3, 7, 3, 1 ];
  var expected = false;

  var gotBool = _.capsule.capsuleIntersects( capsule, tstCapsule );
  test.identical( gotBool, expected );

  /* */

  test.case = 'capsule closer to origin';

  var capsule = [ 0, 0, 0, 2, 2, 2, 0.75 ];
  var tstCapsule = [ - 2, - 2, - 2, -1, -1, -1, 0.1 ];
  var expected = false;

  var gotBool = _.capsule.capsuleIntersects( capsule, tstCapsule );
  test.identical( gotBool, expected );

  /* */

  test.case = '2D intersection';

  var capsule = [ 0, 0, 2, 2, 0.2 ];
  var tstCapsule = [ 1, 2, 3, 4, 1 ];
  var expected = true;

  var gotBool = _.capsule.capsuleIntersects( capsule, tstCapsule );
  test.identical( gotBool, expected );

  /* */

  test.case = '2D no intersection';

  var capsule = [ 0, 0, 2, -2, 0.3 ];
  var tstCapsule = [ 1, 2, 3, 4, 0.2 ];
  var expected = false;

  var gotBool = _.capsule.capsuleIntersects( capsule, tstCapsule );
  test.identical( gotBool, expected );


  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.capsuleIntersects( ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleIntersects( 'capsule', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleIntersects( [ 1, 1, 2, 2, 1 ], 'capsule') );
  test.shouldThrowErrorSync( () => _.capsule.capsuleIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleIntersects( [ 1, 1, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleIntersects( [ 1, 1, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleIntersects( [ 1, 1, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleIntersects( [ 1, 1, 2, 2, 1 ], [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleIntersects( [ 1, 1, 2, 2 ], [ 1, 1, 2, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleIntersects( [ 1, 1, 2, 2, -1 ], [ 1, 1, 2, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleIntersects( [ 1, 1, 2, 2, 1 ], [ 1, 1, 2, 2, - 1 ] ) );

}

//

function capsuleDistance( test )
{

  /* */

  test.case = 'Capsules remain unchanged';

  var capsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  var tstCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var expected = 0;

  var gotBool = _.capsule.capsuleDistance( capsule, tstCapsule );
  test.identical( gotBool, expected );

  var oldCapsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  test.identical( capsule, oldCapsule );

  var oldTstCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  test.identical( tstCapsule, oldTstCapsule );

  /* */

  test.case = 'Null capsule - empty capsule';

  var capsule = null;
  var tstCapsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotBool = _.capsule.capsuleDistance( capsule, tstCapsule );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point capsule - same capsule';

  var capsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var tstCapsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotBool = _.capsule.capsuleDistance( capsule, tstCapsule );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point capsule - no intersection';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0 ];
  var tstCapsule = [ 1, 2, 4, 3, 4, 0, 0.5 ];
  var expected = 0.07735026918962584;

  var gotBool = _.capsule.capsuleDistance( capsule, tstCapsule );
  test.equivalent( gotBool, expected );

  /* */

  test.case = 'sphere capsule in capsule';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0.1 ];
  var tstCapsule = [ 1, 2, 2, 3, 4, 4, 2 ];
  var expected = 0;

  var gotBool = _.capsule.capsuleDistance( capsule, tstCapsule );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Capsule contains capsule';

  var capsule = [ -2, -2, -2, 2, 2, 2, 2 ];
  var tstCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var expected = 0;

  var gotBool = _.capsule.capsuleDistance( capsule, tstCapsule );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Capsules intersect';

  var capsule = [ 0, 0, -2, 0, 0, 2, 1 ];
  var tstCapsule = [ 0, 0, 0, 0, 4, 0, 0.2 ];
  var expected = 0;

  var gotBool = _.capsule.capsuleDistance( capsule, tstCapsule );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Capsule over capsule';

  var capsule = [ 0, 0, 4, 0, 0, 6, 0.5 ];
  var tstCapsule = [ 0, 1, 1, 3, 7, 3, 1 ];
  var expected = 1.6622776601683795;

  var gotBool = _.capsule.capsuleDistance( capsule, tstCapsule );
  test.identical( gotBool, expected );

  /* */

  test.case = 'capsule closer to origin';

  var capsule = [ 0, 0, 0, 2, 2, 2, 0.75 ];
  var tstCapsule = [ - 2, - 2, - 2, -1, -1, -1, 0.1 ];
  var expected = 0.8820508075688772;

  var gotBool = _.capsule.capsuleDistance( capsule, tstCapsule );
  test.identical( gotBool, expected );

  /* */

  test.case = '2D intersection';

  var capsule = [ 0, 0, 2, 2, 0.2 ];
  var tstCapsule = [ 1, 2, 3, 4, 1 ];
  var expected = 0;

  var gotBool = _.capsule.capsuleDistance( capsule, tstCapsule );
  test.identical( gotBool, expected );

  /* */

  test.case = '2D no intersection';

  var capsule = [ 0, 0, 2, -2, 0.3 ];
  var tstCapsule = [ 1, 2, 3, 4, 0.2 ];
  var expected = 1.7360679774997898;

  var gotBool = _.capsule.capsuleDistance( capsule, tstCapsule );
  test.identical( gotBool, expected );


  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.capsuleDistance( ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleDistance( 'capsule', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleDistance( [ 1, 1, 2, 2, 1 ], 'capsule') );
  test.shouldThrowErrorSync( () => _.capsule.capsuleDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleDistance( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleDistance( [ 1, 1, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleDistance( [ 1, 1, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleDistance( [ 1, 1, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleDistance( [ 1, 1, 2, 2, 1 ], [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleDistance( [ 1, 1, 2, 2 ], [ 1, 1, 2, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleDistance( [ 1, 1, 2, 2, -1 ], [ 1, 1, 2, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleDistance( [ 1, 1, 2, 2, 1 ], [ 1, 1, 2, 2, - 1 ] ) );

}

//

function capsuleClosestPoint( test )
{

  /* */

  test.case = 'Capsules remain unchanged';

  var capsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  var tstCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var expected = 0;

  var gotBool = _.capsule.capsuleClosestPoint( capsule, tstCapsule );
  test.identical( gotBool, expected );

  var oldCapsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  test.identical( capsule, oldCapsule );

  var oldTstCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  test.identical( tstCapsule, oldTstCapsule );

  /* */

  test.case = 'Null capsule - empty capsule';

  var capsule = null;
  var tstCapsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotBool = _.capsule.capsuleClosestPoint( capsule, tstCapsule );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point capsule - same capsule';

  var capsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var tstCapsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotBool = _.capsule.capsuleClosestPoint( capsule, tstCapsule );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point capsule - no intersection';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0 ];
  var tstCapsule = [ 1, 2, 4, 3, 4, 0, 0.5 ];
  var expected = _.capsule.tools.long.make( [ 1, 2, 3 ] );

  var gotBool = _.capsule.capsuleClosestPoint( capsule, tstCapsule );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'sphere capsule in capsule';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0.1 ];
  var tstCapsule = [ 1, 2, 2, 3, 4, 4, 2 ];
  var expected = 0;

  var gotBool = _.capsule.capsuleClosestPoint( capsule, tstCapsule );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'Capsule contains capsule';

  var capsule = [ -2, -2, -2, 2, 2, 2, 2 ];
  var tstCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var expected = 0;

  var gotBool = _.capsule.capsuleClosestPoint( capsule, tstCapsule );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'Capsules intersect';

  var capsule = [ 0, 0, -2, 0, 0, 2, 1 ];
  var tstCapsule = [ 0, 0, 0, 0, 4, 0, 0.2 ];
  var expected = 0;

  var gotBool = _.capsule.capsuleClosestPoint( capsule, tstCapsule );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'Capsule over capsule';

  var capsule = [ 0, 0, 4, 0, 0, 6, 0.5 ];
  var tstCapsule = [ 0, 1, 1, 3, 7, 3, 1 ];
  var expected = _.capsule.tools.long.make( [ 0, 0.15811388300841897, 3.525658350974743 ] );

  var gotBool = _.capsule.capsuleClosestPoint( capsule, tstCapsule );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'capsule closer to origin';

  var capsule = [ 0, 0, 0, 2, 2, 2, 0.75 ];
  var tstCapsule = [ - 2, - 2, - 2, -1, -1, -1, 0.1 ];
  var expected = _.capsule.tools.long.make( [ - 0.4330127018922194,  - 0.4330127018922194,  - 0.4330127018922194 ] );

  var gotBool = _.capsule.capsuleClosestPoint( capsule, tstCapsule );
  test.identical( gotBool,  expected );

  /* */

  test.case = '2D intersection';

  var capsule = [ 0, 0, 2, 2, 0.2 ];
  var tstCapsule = [ 1, 2, 3, 4, 1 ];
  var expected = 0;

  var gotBool = _.capsule.capsuleClosestPoint( capsule, tstCapsule );
  test.identical( gotBool,  expected );

  /* */

  test.case = '2D no intersection';

  var capsule = [ 0, 0, 2, -2, 0.3 ];
  var tstCapsule = [ 1, 2, 3, 4, 0.2 ];
  var expected = _.capsule.tools.long.make( [ 0.13416407864998736, 0.2683281572999747 ] );

  var gotBool = _.capsule.capsuleClosestPoint( capsule, tstCapsule );
  test.equivalent( gotBool,  expected );

  /* */

  test.case = 'dstPoint is vector';

  var capsule = [ 0, 0, 1, 0, 1 ];
  var tstCapsule = [ 0, 2, 1, 2, 0.5 ];
  var dstPoint = _.vectorAdapter.from( [ 0, 0 ]);
  var expected = _.capsule.tools.vectorAdapter.from( [ 0, 1 ] );

  var gotBool = _.capsule.capsuleClosestPoint( capsule, tstCapsule, dstPoint );
  test.identical( gotBool,  expected );


  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.capsuleClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleClosestPoint( 'capsule', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleClosestPoint( [ 1, 1, 2, 2, 1 ], 'capsule') );
  test.shouldThrowErrorSync( () => _.capsule.capsuleClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleClosestPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleClosestPoint( [ 1, 1, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleClosestPoint( [ 1, 1, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleClosestPoint( [ 1, 1, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleClosestPoint( [ 1, 1, 2, 2, 1 ], [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleClosestPoint( [ 1, 1, 2, 2 ], [ 1, 1, 2, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleClosestPoint( [ 1, 1, 2, 2, -1 ], [ 1, 1, 2, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.capsuleClosestPoint( [ 1, 1, 2, 2, 1 ], [ 1, 1, 2, 2, - 1 ] ) );

}

//

function convexPolygonContains( test )
{

  /* */

  test.case = 'Source capsule and polygon remain unchanged';

  var srcCapsule = [ - 1, - 1, -1, 0, 0, 2, 0.5 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = false;

  var gotPoint = _.capsule.convexPolygonContains( srcCapsule, polygon );
  test.identical( expected, gotPoint );

  var oldSrcCapsule = [ - 1, - 1, -1, 0, 0, 2, 0.5 ];
  test.identical( srcCapsule, oldSrcCapsule );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  /* */

  test.case = 'Capsule and polygon intersect';

  var srcCapsule = [ -1, - 1, -1, 1, 1, 1, 1 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    4,   0, - 4,   0,
    0,   4,   0, - 4
  ]);
  var expected = false;

  var gotPoint = _.capsule.convexPolygonContains( srcCapsule, polygon );
  test.identical( expected, gotPoint );

  /* */

  test.case = 'Capsule and polygon don´t intersect';

  var srcCapsule = [ 0, 1, 0, 1, 2, 1, 1 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    -2,  -2,  -2,  -2,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = false;

  var gotPoint = _.capsule.convexPolygonContains( srcCapsule, polygon );
  test.identical( expected, gotPoint );

  /* */

  test.case = 'Capsule contains polygon';

  var srcCapsule = [ 0, 0, 0, 1, 1, 1, 4 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = true;

  var gotPoint = _.capsule.convexPolygonContains( srcCapsule, polygon );
  test.identical( expected, gotPoint );

  /* */

  test.case = 'Capsule contains polygon touching sides';

  var srcCapsule = [ -1, 0, 0, 1, 0, 0, Math.sqrt( 2 ) ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = true;

  var gotPoint = _.capsule.convexPolygonContains( srcCapsule, polygon );
  test.identical( expected, gotPoint );

  /* */

  test.case = '2D contained';

  var srcCapsule = [ 0, -2, 3, 3, 2 ];
  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    0,   1,   1,   0,
    0,   0,   1,   1
  ]);
  var expected = true;

  var gotPoint = _.capsule.convexPolygonContains( srcCapsule, polygon );
  test.identical( expected, gotPoint );

  /* */

  test.case = '2D not contained';

  var srcCapsule = [ 1, 2, 3, 3, 0.5 ];
  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    0,   1,   1,   0,
    0,   0,   1,   1
  ]);
  var expected = false;

  var gotPoint = _.capsule.convexPolygonContains( srcCapsule, polygon );
  test.identical( expected, gotPoint );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonContains( ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonContains( [] ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonContains( 'capsule', polygon ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonContains( [ 0, 0, 1, 1, 1 ], 'polygon' ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonContains(  null, polygon ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonContains(  [ 0, 1, 2, 1, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonContains(  NaN, polygon ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonContains(  [ 0, 1, 2, 1, 1 ], NaN ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonContains( [ 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonContains( [ 0, 0, 0, 1, 1 ], [ 1, 0, 1, 2, 1 ], polygon ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonContains( [ 0, 1, 0, 1, 2 ], polygon, polygon ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonContains( [ 0, 1, 0 ], polygon ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonContains( [ 0, 1, 0, 2 ], polygon ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonContains( [ 0, 1, 0, 2, 2, 2 ], polygon ) );

}

//

function convexPolygonClosestPoint( test )
{

  /* */

  test.case = 'Source capsule and polygon remain unchanged';

  var srcCapsule = [ - 1, - 1, -1, 0, 0, 2, 0.5 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = 0;

  var gotPoint = _.capsule.convexPolygonClosestPoint( srcCapsule, polygon );
  test.identical( gotPoint, expected );

  var oldSrcCapsule = [ - 1, - 1, -1, 0, 0, 2, 0.5 ];
  test.identical( srcCapsule, oldSrcCapsule );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  /* */

  test.case = 'Capsule and polygon intersect';

  var srcCapsule = [ - 1, - 1, -1, 1, 1, 1, 1 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = 0;

  var gotPoint = _.capsule.convexPolygonClosestPoint( srcCapsule, polygon );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Polygon vertex in capsule corner';

  var srcCapsule = [ -1, 1, 0, -1, 2, 1, 1 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    -2,  -2,  -2,  -2,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = 0;

  var gotPoint = _.capsule.convexPolygonClosestPoint( srcCapsule, polygon );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Polygon next to capsule corner';

  var srcCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    -2,  -2,  -2,  -2,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = _.capsule.tools.long.make( [ -1, 0, 0 ] );

  var gotPoint = _.capsule.convexPolygonClosestPoint( srcCapsule, polygon );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Polygon in capsule corner';

  var srcCapsule = [ 1, 0, 0, 2, 0, 0, 1 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = 0;

  var gotPoint = _.capsule.convexPolygonClosestPoint( srcCapsule, polygon );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Polygon next to capsule side';

  var srcCapsule = [ 2, -1, -1, 2, 2, 2, 1 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = _.capsule.tools.long.make( [ 1, -0.5, -0.5 ] );

  var gotPoint = _.capsule.convexPolygonClosestPoint( srcCapsule, polygon );
  test.equivalent( gotPoint, expected );

  /* */

  test.case = 'Polygon vertex next to capsule corner';

  var srcCapsule = [ - 2, 2, 0, - 2, 3, 0, 0.5 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    -2,  -2,  -2,  -2,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = _.capsule.tools.long.make( [ -2, 1.5, 0 ] );

  var gotPoint = _.capsule.convexPolygonClosestPoint( srcCapsule, polygon );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Polygon edge next to capsule corner';

  var srcCapsule = [ 1, 1, 0, 2, 2, 0, 0 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1,
    0,   0,   0,   0
  ]);
  var expected = _.capsule.tools.long.make( [ 1, 1, 0 ] );

  var gotPoint = _.capsule.convexPolygonClosestPoint( srcCapsule, polygon );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Polygon vertex next to capsule side';

  var srcCapsule = [ - 1, 2, 0, 1, 2, 0, 0.5 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = _.capsule.tools.long.make( [ 0, 1.5, 0 ] );

  var gotPoint = _.capsule.convexPolygonClosestPoint( srcCapsule, polygon );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Polygon edge next to capsule side';

  var srcCapsule = [ -1, 3, 0, 2, 3, 0, 1 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   1,   1,   0,
    0,   0,   1,   1,
    0,   0,   0,   0
  ]);
  var expected = _.capsule.tools.long.make( [ 1, 2, 0 ] );

  var gotPoint = _.capsule.convexPolygonClosestPoint( srcCapsule, polygon );
  test.identical( gotPoint, expected );

  /* */

  test.case = '2D';

  var srcCapsule = [ 0, 2, 3, 3, 0.5 ];
  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    0,   1,   1,   0,
    0,   0,   1,   1
  ]);
  var expected = _.capsule.tools.long.make( [ 0, 1.5 ] );

  var gotPoint = _.capsule.convexPolygonClosestPoint( srcCapsule, polygon );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'dstPoint Array';

  var srcCapsule = [ 3, 3, 3, 4, 4, 4, Math.sqrt( 3 ) ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   1,   1,
    0,   0,   1,   1,
    0,   1,   1,   0
  ]);
  var dstPoint = [ 0, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 2, 2, 2 ] );

  var gotPoint = _.capsule.convexPolygonClosestPoint( srcCapsule, polygon, dstPoint );
  test.equivalent( gotPoint, expected );
  test.true( dstPoint === gotPoint );

  /* */

  test.case = 'dstPoint Vector';

  var srcCapsule = [ -1, 3, 0, 2, 3, 0, 1 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var dstPoint = _.capsule.tools.vectorAdapter.from( [ 0, 2, 1 ] );
  var expected = _.capsule.tools.vectorAdapter.from( [ 0, 2, 0 ] );

  var gotPoint = _.capsule.convexPolygonClosestPoint( srcCapsule, polygon, dstPoint );
  test.equivalent( gotPoint, expected );
  test.true( dstPoint === gotPoint );

  /* aaa vova: old test case? capsule and tstCapsule are not defined*/

  // var gotBool = _.capsule.capsuleClosestPoint( capsule, tstCapsule );
  // test.identical( gotBool, expected );
  // var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  // ([
  //   1,   0, - 1,   0,
  //   0,   1,   0, - 1
  // ]);

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.convexPolygonClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonClosestPoint( [] ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonClosestPoint( 'capsule', polygon ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonClosestPoint( [ 0, 0, 1, 1, 1 ], 'polygon' ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonClosestPoint(  null, polygon ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonClosestPoint(  [ 0, 1, 2, 1, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonClosestPoint(  NaN, polygon ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonClosestPoint(  [ 0, 1, 2, 1, 1 ], NaN ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonClosestPoint( [ 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonClosestPoint( [ 0, 0, 0, 1, 1 ], [ 1, 0, 1, 2, 1 ], polygon ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonClosestPoint( [ 0, 1, 0, 1, 2 ], polygon, polygon ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonClosestPoint( [ 0, 1, 0 ], polygon ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonClosestPoint( [ 0, 1, 0, 2 ], polygon ) );
  test.shouldThrowErrorSync( () => _.capsule.convexPolygonClosestPoint( [ 0, 1, 0, 2, 2, 2 ], polygon ) );

}

//

function frustumContains( test )
{

  /* */

  test.description = 'Frustum and capsule remain unchanged';

  var frustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var capsule = [ 1, 1, 1, 3, 3, 3, 1 ];
  var oldCapsule = capsule.slice();
  var expected = false;

  var gotBool = _.capsule.frustumContains( capsule, frustum );
  test.identical( gotBool, expected );
  test.identical( capsule, oldCapsule );

  var oldFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  test.identical( frustum, oldFrustum );

  test.description = 'Capsule contains frustum'; //

  var frustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var capsule = [ -1, -1, -1, 3, 3, 3, 1 ];
  var expected = true;

  var gotBool = _.capsule.frustumContains( capsule, frustum );
  test.identical( gotBool, expected );

  test.description = 'Capsule contains Zero frustum'; //

  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0,   0,   0,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);

  var capsule = [ -1, -1, -1, 3, 3, 3, 0.5 ];
  var expected = true;

  var gotBool = _.capsule.frustumContains( capsule, frustum );
  test.identical( gotBool, expected );

  test.description = 'Capsule contains frustum, touching sides'; //

  var frustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var capsule = [ 0, 0, 0, 1, 1, 1, Math.sqrt( 3/4 ) ];
  var expected = true;

  var gotBool = _.capsule.frustumContains( capsule, frustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum contains capsule'; //

  var frustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var capsule = [ 0.1, 0.1, 0.1, 0.5, 0.5, 0.5, 0.1 ];
  var expected = false;

  var gotBool = _.capsule.frustumContains( capsule, frustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and capsule intersect'; //

  var frustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var capsule = [ 0.1, 0.1, 0.1, 2, 2, 2, 0.1 ];
  var expected = false;

  var gotBool = _.capsule.frustumContains( capsule, frustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and capsule in different places'; //

  var frustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var capsule = [ 3, 3, 3, 4, 4, 4, 1 ];
  var expected = false;

  var gotBool = _.capsule.frustumContains( capsule, frustum );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var frustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);

  test.shouldThrowErrorSync( () => _.capsule.frustumContains( ));
  test.shouldThrowErrorSync( () => _.capsule.frustumContains( capsule ));
  test.shouldThrowErrorSync( () => _.capsule.frustumContains( frustum ));
  test.shouldThrowErrorSync( () => _.capsule.frustumContains( capsule, frustum, frustum ));
  test.shouldThrowErrorSync( () => _.capsule.frustumContains( capsule, capsule, frustum ));
  test.shouldThrowErrorSync( () => _.capsule.frustumContains( capsule, null ));
  test.shouldThrowErrorSync( () => _.capsule.frustumContains( null, frustum ));
  test.shouldThrowErrorSync( () => _.capsule.frustumContains( capsule, NaN ));
  test.shouldThrowErrorSync( () => _.capsule.frustumContains( NaN, frustum ));

  capsule = [ 0, 0, 1, 1, 1 ];
  test.shouldThrowErrorSync( () => _.capsule.frustumContains( capsule, frustum ));
  capsule = [ 0, 0, 1, 1, 2, 1];
  test.shouldThrowErrorSync( () => _.capsule.frustumContains( capsule, frustum ));
  capsule = [ 0, 0, 1, 1, 2, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.capsule.frustumContains( capsule, frustum ));

}

//

function frustumIntersects( test )
{

  test.description = 'Capsule and frustum remain unchanged'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 1, 1, 1, 3, 3, 3, 1 ];
  var expected = true;

  var gotBool = _.capsule.frustumIntersects( capsule, srcFrustum );
  test.identical( gotBool, expected );

  var oldCapsule = [ 1, 1, 1, 3, 3, 3, 1 ];
  test.identical( capsule, oldCapsule );

  var oldFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( srcFrustum, oldFrustum );


  test.description = 'Frustum and capsule intersect'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.capsule.frustumIntersects( capsule, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and capsule intersect on frustum corner'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 2, 2, 1, 4, 4, 2, Math.sqrt( 2 ) ];
  var expected = true;

  var gotBool = _.capsule.frustumIntersects( capsule, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum corner is capsule origin'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 1, 1, 1, 0, 0, 4, 1 ];
  var expected = true;

  var gotBool = _.capsule.frustumIntersects( capsule, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and capsule intersect on frustum side'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ -1, -1, 0, 0.5, 0.5, 0, 0.1 ];
  var expected = true;

  var gotBool = _.capsule.frustumIntersects( capsule, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and capsule not intersecting'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 4, 4, 4, 5, 5, 5, 1 ];
  var expected = false;

  var gotBool = _.capsule.frustumIntersects( capsule, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and capsule almost intersecting'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 1.2, 1.2, 1.2, 5, 5, 5, 0.1 ];
  var expected = false;

  var gotBool = _.capsule.frustumIntersects( capsule, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and capsule just touching'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 1.1, 1.1, 1.1, 5, 5, 5, Math.sqrt( 0.03 ) + test.accuracy ];
  var expected = true;

  var gotBool = _.capsule.frustumIntersects( capsule, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and capsule just intersect'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 1, 1, 1, 5, 5, 5, 0.1 ];
  var expected = true;

  var gotBool = _.capsule.frustumIntersects( capsule, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'capsule is null - intersection'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = null;
  var expected = true;

  var gotBool = _.capsule.frustumIntersects( capsule, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'capsule is null - no intersection'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0.5, - 1, 0.5, 0.5, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = null;
  var expected = false;

  var gotBool = _.capsule.frustumIntersects( capsule, srcFrustum );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 0, 0, 0, 1, 1, 1, 1]
  test.shouldThrowErrorSync( () => _.capsule.frustumIntersects( ));
  test.shouldThrowErrorSync( () => _.capsule.frustumIntersects( capsule ));
  test.shouldThrowErrorSync( () => _.capsule.frustumIntersects( srcFrustum ));
  test.shouldThrowErrorSync( () => _.capsule.frustumIntersects( capsule, srcFrustum, srcFrustum ));
  test.shouldThrowErrorSync( () => _.capsule.frustumIntersects( capsule, capsule, srcFrustum ));
  test.shouldThrowErrorSync( () => _.capsule.frustumIntersects( null, capsule ));
  test.shouldThrowErrorSync( () => _.capsule.frustumIntersects( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.capsule.frustumIntersects( NaN, capsule ));
  test.shouldThrowErrorSync( () => _.capsule.frustumIntersects( srcFrustum, NaN));

  capsule = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.capsule.frustumIntersects( capsule, srcFrustum ));
  capsule = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.capsule.frustumIntersects( capsule, srcFrustum ));
  capsule = [ 0, 0, 1, 1, 2, 2 ];
  test.shouldThrowErrorSync( () => _.capsule.frustumIntersects( capsule, srcFrustum ));
  capsule = [ 0, 0, 1, 1, 2, 2, -1 ];
  test.shouldThrowErrorSync( () => _.capsule.frustumIntersects( capsule, srcFrustum ));

}

//

function frustumDistance( test )
{

  test.description = 'Capsule and frustum remain unchanged'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 1, 1, 1, 3, 3, 3, 1 ];
  var expected = 0;

  var gotDistance = _.capsule.frustumDistance( capsule, srcFrustum );
  test.identical( gotDistance, expected );

  var oldCapsule = [ 1, 1, 1, 3, 3, 3, 1 ];
  test.identical( capsule, oldCapsule );

  var oldFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Frustum and capsule intersect'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 0, 0, 0, 1, 1, 1, 2 ];
  var expected = 0;

  var gotDistance = _.capsule.frustumDistance( capsule, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustum and capsule intersect on frustum corner'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 2, 2, 1, 4, 4, 4, Math.sqrt( 2 ) ];
  var expected = 0;

  var gotDistance = _.capsule.frustumDistance( capsule, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustum and capsule intersect on frustum side'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ -1, -1, 0, 0.5, 0.5, 0, 0.01 ];
  var expected = 0;

  var gotDistance = _.capsule.frustumDistance( capsule, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustum and capsule not intersecting'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 4, 4, 4, 5, 5, 5, Math.sqrt( 3 ) ];
  var expected = Math.sqrt( 12 );

  var gotDistance = _.capsule.frustumDistance( capsule, srcFrustum );
  test.equivalent( gotDistance, expected );

  test.description = 'Frustum and capsule almost intersecting'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 1.1, 1.1, 1.1, 5, 5, 5, 0 ];
  var expected = Math.sqrt( 0.03 );

  var gotDistance = _.capsule.frustumDistance( capsule, srcFrustum );
  test.equivalent( gotDistance, expected );

  test.description = 'capsule is null - intersection'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = null;
  var expected = 0;

  var gotDistance = _.capsule.frustumDistance( capsule, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'capsule is null - no intersection'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0.5, - 1, 0.5, 0.5, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = null;
  var expected = Math.sqrt( 0.75 );

  var gotDistance = _.capsule.frustumDistance( capsule, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'capsule closest to box side'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 2, - 3, 2, 2, - 3,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ - 2, 0.3, 0, 1, 0, 0, 1 ];
  var expected = 2;

  var gotDistance = _.capsule.frustumDistance( capsule, srcFrustum );
  test.equivalent( gotDistance, expected );

  test.description = 'Inclined capsule closest to box side'; //
  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 2, - 3, 2, 2, - 3,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ -2, 0.3, 0, 1, 0, 0.1, 2 ];
  var expected = Math.sqrt( 8.61 ) - 2;

  var gotDistance = _.capsule.frustumDistance( capsule, srcFrustum );
  test.identical( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  test.shouldThrowErrorSync( () => _.capsule.frustumDistance( ));
  test.shouldThrowErrorSync( () => _.capsule.frustumDistance( capsule ));
  test.shouldThrowErrorSync( () => _.capsule.frustumDistance( srcFrustum ));
  test.shouldThrowErrorSync( () => _.capsule.frustumDistance( capsule, srcFrustum, srcFrustum ));
  test.shouldThrowErrorSync( () => _.capsule.frustumDistance( capsule, capsule, srcFrustum ));
  test.shouldThrowErrorSync( () => _.capsule.frustumDistance( null, capsule ));
  test.shouldThrowErrorSync( () => _.capsule.frustumDistance( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.capsule.frustumDistance( NaN, capsule ));
  test.shouldThrowErrorSync( () => _.capsule.frustumDistance( srcFrustum, NaN));

  capsule = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.capsule.frustumDistance( capsule, srcFrustum ));
  capsule = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.capsule.frustumDistance( capsule, srcFrustum ));
  capsule = [ 0, 0, 1, 1, 2, 2 ];
  test.shouldThrowErrorSync( () => _.capsule.frustumDistance( capsule, srcFrustum ));
  capsule = [ 0, 0, 1, 1, 2, 2, - 2 ];
  test.shouldThrowErrorSync( () => _.capsule.frustumDistance( capsule, srcFrustum ));

}

//

function frustumClosestPoint( test )
{

  test.description = 'Capsule and frustum remain unchanged'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 1, 1, 1, 3, 3, 3, 1 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.frustumClosestPoint( capsule, srcFrustum );
  test.identical( gotClosestPoint, expected );

  var oldCapsule = [ 1, 1, 1, 3, 3, 3, 1 ];
  test.identical( capsule, oldCapsule );

  var oldFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Frustum and capsule intersect'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 0, 0, 0, 1, 1, 1, 2 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.frustumClosestPoint( capsule, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'Frustum and capsule intersect on frustum corner'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 2, 2, 0, - 1, -1, 1, 0.5 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.frustumClosestPoint( capsule, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'Frustum and capsule intersect on frustum side'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ -1, -1, 0, 0.5, 0.5, 0, 0.1 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.frustumClosestPoint( capsule, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'Frustum and capsule not intersecting'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 4, 4, 4, 5, 5, 5, Math.sqrt( 3 ) ];
  var expected = _.capsule.tools.long.make( [ 3, 3, 3 ] );

  var gotClosestPoint = _.capsule.frustumClosestPoint( capsule, srcFrustum );
  test.equivalent( gotClosestPoint, expected );

  test.description = 'Frustum and capsule almost intersecting'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 1.2, 1.2, 1.2, 5, 5, 5, Math.sqrt( 0.03 ) ];
  var expected = _.capsule.tools.long.make( [ 1.1, 1.1, 1.1 ] );

  var gotClosestPoint = _.capsule.frustumClosestPoint( capsule, srcFrustum );
  test.equivalent( gotClosestPoint, expected );

  test.description = 'capsule is null - intersection'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = null;
  var expected = 0;

  var gotClosestPoint = _.capsule.frustumClosestPoint( capsule, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'capsule is null - no intersection'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0.5, - 1, 0.5, 0.5, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = null;
  var expected = _.capsule.tools.long.make( [ 0, 0, 0 ] );

  var gotClosestPoint = _.capsule.frustumClosestPoint( capsule, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'capsule closest to frustum side'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0.5, - 1, 0.5, 0.5, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ - 2, 0.3, 0, -1, 0.3, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ -1, 0.3, 0 ] );

  var gotClosestPoint = _.capsule.frustumClosestPoint( capsule, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'Inclined capsule closest to frustum side'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 2, - 3, 2, 2, - 3,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ -2, 0.3, 0, 1, 0, 0.1, 0.1 ];
  var expected = _.capsule.tools.long.make( [ 1.0340799088295498, 0.06815981765909972, 0.16475182677614472 ] );

  var gotClosestPoint = _.capsule.frustumClosestPoint( capsule, srcFrustum );
  test.equivalent( gotClosestPoint, expected );

  test.description = 'Destination point is vector'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0.5, - 1, 0.5, 0.5, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 0, 2, 2, 0, 1, 2, 0.5 ];
  var dstPoint = _.capsule.tools.vectorAdapter.from( [ 0, 0, 0 ] );
  var expected = _.capsule.tools.vectorAdapter.from( [ 0.22360679774997896, 1, 1.55278640 ] );

  var gotClosestPoint = _.capsule.frustumClosestPoint( capsule, srcFrustum, dstPoint );
  test.equivalent( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  test.shouldThrowErrorSync( () => _.capsule.frustumClosestPoint( ));
  test.shouldThrowErrorSync( () => _.capsule.frustumClosestPoint( capsule ));
  test.shouldThrowErrorSync( () => _.capsule.frustumClosestPoint( srcFrustum ));
  test.shouldThrowErrorSync( () => _.capsule.frustumClosestPoint( capsule, srcFrustum, srcFrustum ));
  test.shouldThrowErrorSync( () => _.capsule.frustumClosestPoint( capsule, capsule, srcFrustum ));
  test.shouldThrowErrorSync( () => _.capsule.frustumClosestPoint( null, capsule ));
  test.shouldThrowErrorSync( () => _.capsule.frustumClosestPoint( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.capsule.frustumClosestPoint( NaN, capsule ));
  test.shouldThrowErrorSync( () => _.capsule.frustumClosestPoint( srcFrustum, NaN));

  capsule = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.capsule.frustumClosestPoint( capsule, srcFrustum ));
  capsule = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.capsule.frustumClosestPoint( capsule, srcFrustum ));
  capsule = [ 0, 0, 1, 1, 2, 2 ];
  test.shouldThrowErrorSync( () => _.capsule.frustumClosestPoint( capsule, srcFrustum ));
  capsule = [ 0, 0, 1, 1, 2, 2, - 2 ];
  test.shouldThrowErrorSync( () => _.capsule.frustumClosestPoint( capsule, srcFrustum ));

}

//

function lineIntersects( test )
{
  /* */

  test.case = 'Source line and capsule remain unchanged';

  var srcCapsule = [ 0, 0, 1, 1, 1 ];
  var srcLine = [ 0, 0, 2, 2 ];
  var expected = true;

  var isIntersection = _.capsule.lineIntersects( srcCapsule, srcLine );
  test.identical( isIntersection, expected );

  var oldSrcCapsule = [ 0, 0, 1, 1, 1 ];
  test.equivalent( srcCapsule, oldSrcCapsule );

  var oldSrcLine = [ 0, 0, 2, 2 ];
  test.equivalent( srcLine, oldSrcLine );

  /* */

  test.case = 'Capsule and line are the same';

  var srcCapsule = [ 0, 0, 1, 1, 0 ];
  var srcLine = [ 0, 0, 1, 1 ];
  var expected = true;

  var isIntersection = _.capsule.lineIntersects( srcCapsule, srcLine );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and line are parallel ( different origin - same direction )';

  var srcCapsule = [ 0, 0, 1, 1, 2 ];
  var srcLine = [ 3, 7, 1, 1 ];
  var expected = false;

  var isIntersection = _.capsule.lineIntersects( srcCapsule, srcLine );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and line are parallel ( different origin - different direction )';

  var srcCapsule = [ 0, 0, 1, 1, 1 ];
  var srcLine = [ 3, 7, 7, 7 ];
  var expected = false;

  var isIntersection = _.capsule.lineIntersects( srcCapsule, srcLine );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and line intersect';

  var srcCapsule = [ 5, 5, 1, 1, 0.2 ];
  var srcLine = [ 4, 0, -1, 1 ];
  var expected = true;

  var isIntersection = _.capsule.lineIntersects( srcCapsule, srcLine );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and line don´t intersect';

  var srcCapsule = [ 7, 6, 8, 6, 0.5 ];
  var srcLine = [ 6, 6, 1, 1 ];
  var expected = false;

  var isIntersection = _.capsule.lineIntersects( srcCapsule, srcLine );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and line intersect in their origin';

  var srcCapsule = [ 3, 7, 1, 0, 0.2 ];
  var srcLine = [ 3, 7, 0, 1 ];
  var expected = true;

  var isIntersection = _.capsule.lineIntersects( srcCapsule, srcLine );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and line intersect ';

  var srcCapsule = [ 0, 0, 1, 0, 1 ];
  var srcLine = [ -2, -6, 1, 2 ];
  var expected = true;

  var isIntersection = _.capsule.lineIntersects( srcCapsule, srcLine );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and line are perpendicular ';

  var srcCapsule = [ -3, 0, 1, 0, 0.2 ];
  var srcLine = [ 0, -2, 0, 1 ];
  var expected = true;

  var isIntersection = _.capsule.lineIntersects( srcCapsule, srcLine );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and line don´t intersect 3D';

  var srcCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var srcLine = [ 3, 0, 1, 2, 2, -1 ];
  var expected = false;

  var isIntersection = _.capsule.lineIntersects( srcCapsule, srcLine );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and line intersect 3D';

  var srcCapsule = [ 0, 0, 0, 0, 0, 3, 1 ];
  var srcLine = [ - 3, - 3, 2, 1, 1, 0 ];
  var expected = true;

  var isIntersection = _.capsule.lineIntersects( srcCapsule, srcLine );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and line don´t intersect 4D';

  var srcCapsule = [ 0, 0, 0, 0, 1, 1, 1, 1, 0.7 ];
  var srcLine = [ 3, 0, 1, 4, 2, 2, 2, -1 ];
  var expected = false;

  var isIntersection = _.capsule.lineIntersects( srcCapsule, srcLine );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and line intersect 4D';

  var srcCapsule = [ 0, 0, 0, 0, 4, 4, 4, 4, 0.3 ];
  var srcLine = [ 3, 2, 1, 0, 0, 1, 2, 3 ];
  var expected = true;

  var isIntersection = _.capsule.lineIntersects( srcCapsule, srcLine );
  test.identical( isIntersection, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.lineIntersects( ) );
  test.shouldThrowErrorSync( () => _.capsule.lineIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.lineIntersects( 'capsule', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.lineIntersects( [ 1, 1, 2, 2, 1 ], 'line') );
  test.shouldThrowErrorSync( () => _.capsule.lineIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.lineIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.lineIntersects( [ 1, 1, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.lineIntersects( [ 1, 1, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.lineIntersects( [ 1, 1, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.lineIntersects( [ 1, 1, 2, 2, 1 ], [ 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.lineIntersects( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.lineIntersects( [ 1, 1, 2, 2, -1 ], [ 1, 2, 3, 4 ] ) );

}

//

function lineDistance( test )
{
  /* */

  test.case = 'Source capsule and line remain unchanged';

  var srcCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var tstLine = [ 0, 0, 0, 2, 2, 2 ];
  var expected = 0;

  var gotDistance = _.capsule.lineDistance( srcCapsule, tstLine );
  test.identical( gotDistance, expected );

  var oldSrcCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  test.equivalent( srcCapsule, oldSrcCapsule );

  var oldTstLine = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( tstLine, oldTstLine );

  /* */

  test.case = 'Capsule and line are parallel ( different origin - same direction )';

  var srcCapsule = [ 0, 0, 0, 0, 0, 1, 2 ];
  var tstLine = [ 3, 7, 1, 0, 0, 1 ];
  var expected = Math.sqrt( 58 ) - 2;

  var gotDistance = _.capsule.lineDistance( srcCapsule, tstLine );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and line are parallel ( different origin - different direction )';

  var srcCapsule = [ 3, 7, 1, 3, 7, 7, 1 ];
  var tstLine = [ 0, 0, 0, 0, 0, 0.5 ];
  var expected = Math.sqrt( 58 ) - 1;

  var gotDistance = _.capsule.lineDistance( srcCapsule, tstLine );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and line are parallel ( different origin - opposite direction )';

  var srcCapsule = [ 0, 0, 0, 9, 0, 0, 0.4 ];
  var tstLine = [ 3, 7, 1, - 7, 0, 0 ];
  var expected = Math.sqrt( 50 ) - 0.4;

  var gotDistance = _.capsule.lineDistance( srcCapsule, tstLine );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'srcCapsule is a point';

  var srcCapsule = [ 3, 7, 1, 3, 7, 1, 0 ];
  var tstLine = [ 0, 0, 0, 1, 1, 1 ];
  var expected =  Math.sqrt( 168 / 9 );

  var gotDistance = _.capsule.lineDistance( srcCapsule, tstLine );
  test.equivalent( gotDistance, expected );

  /* */

  test.case = 'srcCapsule is a sphere';

  var srcCapsule = [ 3, 7, 1, 3, 7, 1, 1 ];
  var tstLine = [ 0, 0, 0, 1, 1, 1 ];
  var expected =  Math.sqrt( 168 / 9 ) - 1;

  var gotDistance = _.capsule.lineDistance( srcCapsule, tstLine );
  test.equivalent( gotDistance, expected );

  /* */

  test.case = 'tstLine is a point';

  var srcCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var tstLine = [ 3, 7, 1, 0, 0, 0 ];
  var expected = Math.sqrt( 40 ) - 1;

  var gotDistance = _.capsule.lineDistance( srcCapsule, tstLine );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and line are the same';

  var srcCapsule = [ 0, 4, 2, 5, 9, 7, 0 ];
  var tstLine = [ 0, 4, 2, 5, 9, 7 ];
  var expected = 0;

  var gotDistance = _.capsule.lineDistance( srcCapsule, tstLine );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and line intersect 4D';

  var srcCapsule = [ 0, 0, 2, 1, 0, 9, 2, 1, 0.2 ];
  var tstLine = [ 3, 4, 2, 1, -1, 0, 0, 0 ];
  var expected = 0;

  var gotDistance = _.capsule.lineDistance( srcCapsule, tstLine );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and line don´t intersect 2D - parallel';

  var srcCapsule = [ 0, 0, 2, 0, 2 ];
  var tstLine = [ - 3, - 4, 1, 0 ];
  var expected = 2;

  var gotDistance = _.capsule.lineDistance( srcCapsule, tstLine );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and line don´t intersect';

  var srcCapsule = [ 0, 0, 2, 0, 1 ];
  var tstLine = [ - 3, - 4, 0, 1 ];
  var expected = 2;

  var gotDistance = _.capsule.lineDistance( srcCapsule, tstLine );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and line intersect with line´s negative factor 2D';

  var srcCapsule = [ - 3, - 4, -3, 3, 1 ];
  var tstLine = [ 0, 0, 2, 0 ];
  var expected = 0;

  var gotDistance = _.capsule.lineDistance( srcCapsule, tstLine );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and line are perpendicular and intersect';

  var srcCapsule = [ 3, 7, 1, 8, 7, 1, 0.2 ];
  var tstLine = [ 3, 7, 1, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.capsule.lineDistance( srcCapsule, tstLine );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and line are perpendicular and don´t intersect';

  var srcCapsule = [ 0, 0, -3, 0, 0, 1, 0.5 ];
  var tstLine = [ 3, 0, 0, 0, 1, 0 ];
  var expected = 2.5;

  var gotDistance = _.capsule.lineDistance( srcCapsule, tstLine );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and line are parallel to x axis';

  var srcCapsule = [ 3, 7, 1, 7, 7, 1, 0.25 ];
  var tstLine = [ 3, 7, 2, 1, 0, 0 ];
  var expected = 0.75;

  var gotDistance = _.capsule.lineDistance( srcCapsule, tstLine );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and line are parallel but in a opposite direction';

  var srcCapsule = [ 3, 7, 1, 9, 7, 1, 0.2 ];
  var tstLine = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = 0.8;

  var gotDistance = _.capsule.lineDistance( srcCapsule, tstLine );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and line are parallel and intersect';

  var srcCapsule = [ 3, 7, 1, 9, 7, 1, 1.2 ];
  var tstLine = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = 0;

  var gotDistance = _.capsule.lineDistance( srcCapsule, tstLine );
  test.identical( gotDistance, expected );


  /* */

  test.case = 'srcCapsule is null';

  var srcCapsule = null;
  var tstLine = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = Math.sqrt( 53 );

  var gotDistance = _.capsule.lineDistance( srcCapsule, tstLine );
  test.identical( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.lineDistance( ) );
  test.shouldThrowErrorSync( () => _.capsule.lineDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.lineDistance( 'capsule', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.lineDistance( [ 0, 0, 1 ], 'line') );
  test.shouldThrowErrorSync( () => _.capsule.lineDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.lineDistance( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.lineDistance( [ 1, 1, 1, 2, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.lineDistance( [ 1, 1, 1, 2, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.lineDistance( [ 1, 1, 1, 2, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.lineDistance( [ 1, 1, 1, 2, 2, 2, 1 ], [ 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.lineDistance( [ 1, 1, 1, 2, 2, 2, - 1 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.lineDistance( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function lineClosestPoint( test )
{
  /* */

  test.case = 'Source capsule and line remain unchanged';

  var srcCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var tstLine = [ 0, 0, 0, 2, 2, 2 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.lineClosestPoint( srcCapsule, tstLine );
  test.identical( gotClosestPoint, expected );

  var oldSrcCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  test.equivalent( srcCapsule, oldSrcCapsule );

  var oldTstLine = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( tstLine, oldTstLine );

  /* */

  test.case = 'Capsule and line are parallel ( different origin - same direction )';

  var srcCapsule = [ 0, 0, 0, 0, 0, 1, 1 ];
  var tstLine = [ 3, 7, 1, 0, 0, 1 ];
  var expected = _.capsule.tools.long.make( [ 0.39391929857916763, 0.9191450300180578, 1 ] );

  var gotClosestPoint = _.capsule.lineClosestPoint( srcCapsule, tstLine );
  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and line are parallel ( different origin - different direction )';

  var srcCapsule = [ 3, 7, 1, 3, 7, 8, Math.sqrt( 2 ) ];
  var tstLine = [ 0, 0, 0, 0, 0, 0.5 ];
  var expected = _.capsule.tools.long.make( [ 2.442913985468844, 5.700132632760637, 1 ] );

  var gotClosestPoint = _.capsule.lineClosestPoint( srcCapsule, tstLine );
  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and line are parallel ( different origin - opposite direction )';

  var srcCapsule = [ 0, 0, 0, 10, 0, 0, 3 ];
  var tstLine = [ 3, 7, 1, - 7, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 3, 2.9698484809835, 0.4242640687119285 ] );

  var gotClosestPoint = _.capsule.lineClosestPoint( srcCapsule, tstLine );
  test.equivalent( gotClosestPoint, expected, _.accuracySqrt );

  /* */

  test.case = 'srcCapsule is a point';

  var srcCapsule = [ 3, 7, 1, 3, 7, 1, 0 ];
  var tstLine = [ 0, 0, 0, 1, 1, 1 ];
  var expected = _.capsule.tools.long.make( [ 3, 7, 1 ] );

  var gotClosestPoint = _.capsule.lineClosestPoint( srcCapsule, tstLine );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'tstLine is a point';

  var srcCapsule = [ 0, 0, 0, 9, 9, 9, 1 ];
  var tstLine = [ 3, 7, 1, 0, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 3.5123633167045747, 4.438183416477126, 3.0494532668182988 ] );

  var gotClosestPoint = _.capsule.lineClosestPoint( srcCapsule, tstLine );
  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and line are the same';

  var srcCapsule = [ 0, 4, 2, 3, 7, 5, 0 ];
  var tstLine = [ 0, 4, 2, 1, 1, 1 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.lineClosestPoint( srcCapsule, tstLine );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and line intersect 4D';

  var srcCapsule = [ 0, 0, 2, 1, 0, 9, 2, 1, 1 ];
  var tstLine = [ 3, 4, 2, 1, -1, 0, 0, 0 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.lineClosestPoint( srcCapsule, tstLine );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and line don´t intersect 2D - parallel';

  var srcCapsule = [ 0, 0, 2, 0, 0.5 ];
  var tstLine = [ - 3, - 4, 1, 0 ];
  var expected = _.capsule.tools.long.make( [ 0, - 0.5 ] );

  var gotClosestPoint = _.capsule.lineClosestPoint( srcCapsule, tstLine );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and line don´t intersect';

  var srcCapsule = [ 0, 0, 2, 0, 0.5 ];
  var tstLine = [ - 3, - 4, 0, 1 ];
  var expected = _.capsule.tools.long.make( [ -0.5, 0 ] );

  var gotClosestPoint = _.capsule.lineClosestPoint( srcCapsule, tstLine );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and line intersect with line´s negative factor 2D';

  var srcCapsule = [ - 3, - 4, -3, 4, 0.2 ];
  var tstLine = [ 0, 0, 2, 0 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.lineClosestPoint( srcCapsule, tstLine );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and line are perpendicular and intersect ( same origin )';

  var srcCapsule = [ 3, 7, 1, 8, 7, 1, 1 ];
  var tstLine = [ 3, 7, 1, 0, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.lineClosestPoint( srcCapsule, tstLine );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and line are perpendicular and don´t intersect';

  var srcCapsule = [ 0, 0, -3, 0, 0, 1, 2 ];
  var tstLine = [ 3, 0, 0, 1, 1, 0 ];
  var expected = _.capsule.tools.long.make( [ 1.4142135623730951, - 1.4142135623730951, 0 ] );

  var gotClosestPoint = _.capsule.lineClosestPoint( srcCapsule, tstLine );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and line are parallel to x';

  var srcCapsule = [ 3, 7, 1, 4, 7, 1, 0.5 ];
  var tstLine = [ 3, 7, 2, 4, 7, 2 ];
  var expected = _.capsule.tools.long.make( [ 2.940271890656845, 6.895475808649478, 1.4852908884131368 ] );

  var gotClosestPoint = _.capsule.lineClosestPoint( srcCapsule, tstLine );
  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and line are parallel but in a opposite direction';

  var srcCapsule = [ 3, 7, 1, 4, 7, 1, 0.1 ];
  var tstLine = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 3, 7, 1.1 ] );

  var gotClosestPoint = _.capsule.lineClosestPoint( srcCapsule, tstLine );
  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'srcCapsule is null';

  var srcCapsule = null;
  var tstLine = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 0, 0, 0 ] );

  var gotClosestPoint = _.capsule.lineClosestPoint( srcCapsule, tstLine );
  test.identical( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.lineClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.capsule.lineClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.lineClosestPoint( 'capsule', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.lineClosestPoint( [ 0, 0, 0 ], 'line') );
  test.shouldThrowErrorSync( () => _.capsule.lineClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.lineClosestPoint( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.lineClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.lineClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.lineClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.lineClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], [ 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.lineClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.lineClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], [ 1, 2, 3, 4 ] ) );

}

//

function planeIntersects( test )
{

  /* */

  test.case = 'Capsule and plane remain unchanged';

  var capsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = true;

  var gotBool = _.capsule.planeIntersects( capsule, plane );
  test.identical( gotBool, expected );

  var oldCapsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  test.identical( capsule, oldCapsule );

  var oldPlane = [ 1, 1, 0, 0 ];
  test.identical( plane, oldPlane );

  /* */

  test.case = 'Null capsule - no intersection';

  var capsule = null;
  var plane = [ 1, 1, 0, 0 ];
  var expected = false;

  var gotBool = _.capsule.planeIntersects( capsule, plane );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Null capsule - Intersection';

  var capsule = null;
  var plane = [ 0, 1, 0, -1 ];
  var expected = true;

  var gotBool = _.capsule.planeIntersects( capsule, plane );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point capsule - no intersection';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = false;

  var gotBool = _.capsule.planeIntersects( capsule, plane );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point capsule in plane';

  var capsule = [ - 1, 2, 3, -1, 2, 3, 0 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = true;

  var gotBool = _.capsule.planeIntersects( capsule, plane );
  test.identical( gotBool, expected );

  /* */

  test.case = 'sphere capsule - no intersection';

  var capsule = [ 1, 2, 3, 1, 2, 3, 1 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = false;

  var gotBool = _.capsule.planeIntersects( capsule, plane );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point capsule intersection';

  var capsule = [ - 1.1, 2, 3, -1.1, 2, 3, 2 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = true;

  var gotBool = _.capsule.planeIntersects( capsule, plane );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Capsule and plane intersect';

  var capsule = [ -2, -2, -2, 2, 2, 2, 1 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = true;

  var gotBool = _.capsule.planeIntersects( capsule, plane );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Capsule over plane';

  var capsule = [ 0, -6, 4, 1, 1, 0, 0.5 ];
  var plane = [ 3, 1, 0, 0 ];
  var expected = false;

  var gotBool = _.capsule.planeIntersects( capsule, plane );
  test.identical( gotBool, expected );

  /* */

  test.case = 'plane closer to origin';

  var capsule = [ 0, 0, 0, 2, 2, 2, 0.4 ];
  var plane = [ 0.5, 1, 0, 0 ];
  var expected = false;

  var gotBool = _.capsule.planeIntersects( capsule, plane );
  test.identical( gotBool, expected );

  /* */

  test.case = 'plane parallel to capsule';

  var capsule = [ 0, 0, 0, 0, 0, 2, 0.4 ];
  var plane = [ 0.5, 0, 1, 0 ];
  var expected = false;

  var gotBool = _.capsule.planeIntersects( capsule, plane );
  test.identical( gotBool, expected );

  /* */

  test.case = 'plane parallel contains capsule';

  var capsule = [ 0, 0, 0, 0, 0, 2, 1 ];
  var plane = [ 0, 0, 1, 0 ];
  var expected = true;

  var gotBool = _.capsule.planeIntersects( capsule, plane );
  test.identical( gotBool, expected );

  /* */

  test.case = 'plane perpendicular to capsule';

  var capsule = [ 0, 0, 0, 0, 0, 2, 1 ];
  var plane = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.capsule.planeIntersects( capsule, plane );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.planeIntersects( ) );
  test.shouldThrowErrorSync( () => _.capsule.planeIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.planeIntersects( 'capsule', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.planeIntersects( [ 1, 1, 1, 2, 2, 2, 1 ], 'plane') );
  test.shouldThrowErrorSync( () => _.capsule.planeIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.planeIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.planeIntersects( [ 1, 1, 1, 2, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.planeIntersects( [ 1, 1, 1, 2, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.planeIntersects( [ 1, 1, 1, 2, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.planeIntersects( [ 1, 1, 1, 2, 2, 2, 1 ], [ 1, 2, 3, 4, 5, 6 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.planeIntersects( [ 1, 1, 1, 2, 2, 2, - 1 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.planeIntersects( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function planeDistance( test )
{

  /* */

  test.case = 'Capsule and plane remain unchanged';

  var capsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = 0;

  var gotDistance = _.capsule.planeDistance( capsule, plane );
  test.identical( gotDistance, expected );

  var oldCapsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  test.identical( capsule, oldCapsule );

  var oldPlane = [ 1, 1, 0, 0 ];
  test.identical( plane, oldPlane );

  /* */

  test.case = 'Null capsule - empty plane';

  var capsule = null;
  var plane = [ 1, 1, 0, 0 ];
  var expected = 1;

  var gotDistance = _.capsule.planeDistance( capsule, plane );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'point capsule - no intersection';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = 2;

  var gotDistance = _.capsule.planeDistance( capsule, plane );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'point capsule in plane';

  var capsule = [ - 1, 2, 3, -1, 2, 3, 1 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = 0;

  var gotDistance = _.capsule.planeDistance( capsule, plane );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'sphere capsule - no intersection';

  var capsule = [ 1, 2, 3, 1, 2, 3, 1 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = 1;

  var gotDistance = _.capsule.planeDistance( capsule, plane );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'sphere capsule intersection';

  var capsule = [ - 1, 2, 3, -1, 2, 3, 1 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = 0;

  var gotDistance = _.capsule.planeDistance( capsule, plane );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and plane intersect';

  var capsule = [ -2, -2, -2, 2, 2, 2, 2 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = 0;

  var gotDistance = _.capsule.planeDistance( capsule, plane );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule over plane';

  var capsule = [ 0, -6, 4, 1, 1, 0, 1 ];
  var plane = [ 3, 1, 0, 0 ];
  var expected = 2;

  var gotDistance = _.capsule.planeDistance( capsule, plane );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'plane closer to origin';

  var capsule = [ 0, 0, 0, 2, 2, 2, 0.1 ];
  var plane = [ 0.5, 1, 0, 0 ];
  var expected = 0.4;

  var gotDistance = _.capsule.planeDistance( capsule, plane );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'plane parallel to capsule';

  var capsule = [ 0, 0, 0, 0, 0, 2, 0.2 ];
  var plane = [ 0.5, 0, 1, 0 ];
  var expected = 0.3;

  var gotDistance = _.capsule.planeDistance( capsule, plane );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'plane parallel contains capsule';

  var capsule = [ 0, 0, 0, 0, 0, 2, 0.1 ];
  var plane = [ 0, 0, 1, 0 ];
  var expected = 0;

  var gotDistance = _.capsule.planeDistance( capsule, plane );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'plane perpendicular to capsule';

  var capsule = [ 0, 0, 0, 0, 0, 2, 0.1 ];
  var plane = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.capsule.planeDistance( capsule, plane );
  test.identical( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.planeDistance( ) );
  test.shouldThrowErrorSync( () => _.capsule.planeDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.planeDistance( 'capsule', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.planeDistance( [ 1, 1, 1, 2, 2, 2, 1 ], 'plane') );
  test.shouldThrowErrorSync( () => _.capsule.planeDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.planeDistance( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.planeDistance( [ 1, 1, 1, 2, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.planeDistance( [ 1, 1, 1, 2, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.planeDistance( [ 1, 1, 1, 2, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.planeDistance( [ 1, 1, 1, 2, 2, 2, 1 ], [ 1, 2, 3, 4, 5, 6 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.planeDistance( [ 1, 1, 1, 2, 2, 2, - 1 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.planeDistance( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function planeClosestPoint( test )
{

  /* */

  test.case = 'Capsule and plane remain unchanged';

  var capsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = 0;

  var gotPoint = _.capsule.planeClosestPoint( capsule, plane );
  test.identical( gotPoint, expected );

  var oldCapsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  test.identical( capsule, oldCapsule );

  var oldPlane = [ 1, 1, 0, 0 ];
  test.identical( plane, oldPlane );

  /* */

  test.case = 'Null capsule - empty plane';

  var capsule = null;
  var plane = [ 1, 1, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 0, 0, 0 ] );

  var gotPoint = _.capsule.planeClosestPoint( capsule, plane );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'point capsule - no intersection';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 1, 2, 3 ] );

  var gotPoint = _.capsule.planeClosestPoint( capsule, plane );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'point capsule in plane';

  var capsule = [ - 1, 2, 3, - 1, 2, 3, 0 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = 0;

  var gotPoint = _.capsule.planeClosestPoint( capsule, plane );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'sphere capsule - no intersection';

  var capsule = [ 1, 2, 3, 1, 2, 3, 1 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 0, 2, 3 ] );

  var gotPoint = _.capsule.planeClosestPoint( capsule, plane );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'sphere capsule intersection';

  var capsule = [ - 1, 2, 3, - 1, 2, 3, 1 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = 0;

  var gotPoint = _.capsule.planeClosestPoint( capsule, plane );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Capsule and plane intersect';

  var capsule = [ -2, -2, -2, 2, 2, 2, 2 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = 0;

  var gotPoint = _.capsule.planeClosestPoint( capsule, plane );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Capsule over plane';

  var capsule = [ 0, -6, 4, 1, 1, 0, 2 ];
  var plane = [ 3, 1, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ -2, -6, 4 ] );

  var gotPoint = _.capsule.planeClosestPoint( capsule, plane );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'plane closer to origin';

  var capsule = [ 0, 0, 0, 2, 2, 2, 0.4 ];
  var plane = [ 0.5, 1, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ - 0.4, 0, 0 ] );

  var gotPoint = _.capsule.planeClosestPoint( capsule, plane );
  test.equivalent( gotPoint, expected );

  /* */

  test.case = 'plane parallel to capsule';

  var capsule = [ 0, 0, 0, 0, 0, 2, 1 ];
  var plane = [ 1.5, 0, 1, 0 ];
  var expected = _.capsule.tools.long.make( [ 0, -1, 0 ] );

  var gotPoint = _.capsule.planeClosestPoint( capsule, plane );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'plane parallel contains capsule';

  var capsule = [ 0, 0, 0, 0, 0, 2, 1 ];
  var plane = [ 0, 0, 1, 0 ];
  var expected = 0;

  var gotPoint = _.capsule.planeClosestPoint( capsule, plane );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'plane perpendicular to capsule';

  var capsule = [ 0, 0, 0, 0, 0, 2, 1 ];
  var plane = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotPoint = _.capsule.planeClosestPoint( capsule, plane );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'dstPoint is array';

  var capsule = [ 0, -6, 24, 1, 1, 1, 1 ];
  var plane = [ 3, 1, 0, 1 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 0.29289321881345254, 1, 0.29289321881345254 ] );

  var gotPoint = _.capsule.planeClosestPoint( capsule, plane, dstPoint );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'dstPoint is vector';

  var capsule = [ 0, -6, 24, 1, 1, 1, 1 ];
  var plane = [ 3, 1, 0, 1 ];
  var dstPoint = _.vectorAdapter.from( [ 0, 0, 0 ] );
  var expected = _.capsule.tools.vectorAdapter.from( [ 0.29289321881345254, 1, 0.29289321881345254 ] );

  var gotPoint = _.capsule.planeClosestPoint( capsule, plane, dstPoint );
  test.identical( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.planeClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.capsule.planeClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.planeClosestPoint( 'capsule', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.planeClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], 'plane') );
  test.shouldThrowErrorSync( () => _.capsule.planeClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.planeClosestPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.planeClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.planeClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.planeClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.planeClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], [ 1, 2, 3, 4, 5, 6 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.planeClosestPoint( [ 1, 1, 1, 2, 2, 2, - 1 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.planeClosestPoint( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function rayIntersects( test )
{
  /* */

  test.case = 'Source ray and capsule remain unchanged';

  var srcCapsule = [ 0, 0, 1, 1, 1 ];
  var srcRay = [ 0, 0, 2, 2 ];
  var expected = true;

  var isIntersection = _.capsule.rayIntersects( srcCapsule, srcRay );
  test.identical( isIntersection, expected );

  var oldSrcCapsule = [ 0, 0, 1, 1, 1 ];
  test.equivalent( srcCapsule, oldSrcCapsule );

  var oldSrcRay = [ 0, 0, 2, 2 ];
  test.equivalent( srcRay, oldSrcRay );

  /* */

  test.case = 'Capsule and ray are the same';

  var srcCapsule = [ 0, 0, 1, 1, 0 ];
  var srcRay = [ 0, 0, 1, 1 ];
  var expected = true;

  var isIntersection = _.capsule.rayIntersects( srcCapsule, srcRay );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and ray are parallel ( different origin - same direction )';

  var srcCapsule = [ 0, 0, 1, 1, 1 ];
  var srcRay = [ 3, 7, 1, 1 ];
  var expected = false;

  var isIntersection = _.capsule.rayIntersects( srcCapsule, srcRay );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and ray are parallel ( different origin - different direction )';

  var srcCapsule = [ 0, 0, 1, 1, 1 ];
  var srcRay = [ 3, 7, 7, 7 ];
  var expected = false;

  var isIntersection = _.capsule.rayIntersects( srcCapsule, srcRay );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and ray intersect';

  var srcCapsule = [ 5, 5, 1, 1, 1 ];
  var srcRay = [ 4, 0, -1, 1 ];
  var expected = true;

  var isIntersection = _.capsule.rayIntersects( srcCapsule, srcRay );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and ray don´t intersect';

  var srcCapsule = [ 7, 6, 8, 6, 0.5 ];
  var srcRay = [ 6, 6, 1, 1 ];
  var expected = false;

  var isIntersection = _.capsule.rayIntersects( srcCapsule, srcRay );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and ray intersect in their origin';

  var srcCapsule = [ 3, 7, 1, 0, 1 ];
  var srcRay = [ 3, 7, 0, 1 ];
  var expected = true;

  var isIntersection = _.capsule.rayIntersects( srcCapsule, srcRay );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and ray intersect ';

  var srcCapsule = [ 0, 0, 1, 0.5, 1 ];
  var srcRay = [ -2, -6, 1, 2 ];
  var expected = true;

  var isIntersection = _.capsule.rayIntersects( srcCapsule, srcRay );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and ray are perpendicular ';

  var srcCapsule = [ -3, 0.1, 1, 0.1, 0.2 ];
  var srcRay = [ 0, -2, 0, 1 ];
  var expected = true;

  var isIntersection = _.capsule.rayIntersects( srcCapsule, srcRay );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and ray don´t intersect 3D';

  var srcCapsule = [ 0, 0, 0, 1, 1, 1, 0.1 ];
  var srcRay = [ 3, 0, 1, 2, 2, -1 ];
  var expected = false;

  var isIntersection = _.capsule.rayIntersects( srcCapsule, srcRay );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and ray intersect 3D';

  var srcCapsule = [ 1, 0, 0, 1, 0, 3, 1 ];
  var srcRay = [ - 3, - 3, 2, 1, 1, 0 ];
  var expected = true;

  var isIntersection = _.capsule.rayIntersects( srcCapsule, srcRay );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and ray don´t intersect 4D';

  var srcCapsule = [ 0, 0, 0, 0, 1, 1, 1, 1, 1 ];
  var srcRay = [ 3, 0, 1, 4, 2, 2, 2, -1 ];
  var expected = false;

  var isIntersection = _.capsule.rayIntersects( srcCapsule, srcRay );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and ray intersect 4D';

  var srcCapsule = [ 0, 0, 0, 0, 4, 4, 4, 4, 2 ];
  var srcRay = [ 3, 2, 1, 0, 0, 1, 2, 3 ];
  var expected = true;

  var isIntersection = _.capsule.rayIntersects( srcCapsule, srcRay );
  test.identical( isIntersection, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.rayIntersects( ) );
  test.shouldThrowErrorSync( () => _.capsule.rayIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.rayIntersects( 'capsule', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.rayIntersects( [ 1, 1, 2, 2, 1 ], 'ray') );
  test.shouldThrowErrorSync( () => _.capsule.rayIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.rayIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.rayIntersects( [ 1, 1, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.rayIntersects( [ 1, 1, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.rayIntersects( [ 1, 1, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.rayIntersects( [ 1, 1, 2, 2, 1 ], [ 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.rayIntersects( [ 1, 1, 2, 2, - 1 ], [ 1, 2, 3, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.rayIntersects( [ 1, 1, 2, 2 ], [ 1, 2, 1, 0 ] ) );

}

//

function rayDistance( test )
{
  /* */

  test.case = 'Source capsule and ray remain unchanged';

  var srcCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var tstRay = [ 0, 0, 0, 2, 2, 2 ];
  var expected = 0;

  var gotDistance = _.capsule.rayDistance( srcCapsule, tstRay );
  test.identical( gotDistance, expected );

  var oldSrcCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  test.equivalent( srcCapsule, oldSrcCapsule );

  var oldTstRay = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( tstRay, oldTstRay );

  /* */

  test.case = 'Capsule and ray are parallel ( different origin - same direction )';

  var srcCapsule = [ 0, 0, 0, 0, 0, 1, 1 ];
  var tstRay = [ 3, 7, 1, 0, 0, 1 ];
  var expected = Math.sqrt( 58 ) - 1;

  var gotDistance = _.capsule.rayDistance( srcCapsule, tstRay );
  test.equivalent( gotDistance, expected );

  /* */

  test.case = 'Capsule and ray are parallel ( different origin - different direction )';

  var srcCapsule = [ 3, 7, 1, 3, 7, 7, 2 ];
  var tstRay = [ 0, 0, 0, 0, 0, 0.5 ];
  var expected = Math.sqrt( 58 ) - 2;

  var gotDistance = _.capsule.rayDistance( srcCapsule, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and ray are parallel ( different origin - opposite direction )';

  var srcCapsule = [ 0, 0, 0, 9, 0, 0, 3 ];
  var tstRay = [ 3, 7, 1, - 7, 0, 0 ];
  var expected = Math.sqrt( 50 ) - 3;

  var gotDistance = _.capsule.rayDistance( srcCapsule, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'srcCapsule is a point';

  var srcCapsule = [ 3, 7, 1, 3, 7, 1, 0 ];
  var tstRay = [ 0, 0, 0, 1, 1, 1 ];
  var expected =  Math.sqrt( 168 / 9 );

  var gotDistance = _.capsule.rayDistance( srcCapsule, tstRay );
  test.equivalent( gotDistance, expected );

  /* */

  test.case = 'tstRay is a point';

  var srcCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var tstRay = [ 3, 7, 1, 0, 0, 0 ];
  var expected = Math.sqrt( 40 ) - 1;

  var gotDistance = _.capsule.rayDistance( srcCapsule, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'srcCapsule is a sphere';

  var srcCapsule = [ 3, 7, 1, 3, 7, 1, 2 ];
  var tstRay = [ 0, 0, 0, 1, 1, 1 ];
  var expected =  Math.sqrt( 168 / 9 ) - 2;

  var gotDistance = _.capsule.rayDistance( srcCapsule, tstRay );
  test.equivalent( gotDistance, expected );

  /* */

  test.case = 'Capsule and ray are the same';

  var srcCapsule = [ 0, 4, 2, 5, 4, 2, 0 ];
  var tstRay = [ 0, 4, 2, 1, 0, 0 ];
  var expected = 0;

  var gotDistance = _.capsule.rayDistance( srcCapsule, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and ray intersect 4D';

  var srcCapsule = [ 0, 0, 2, 1, 0, 9, 2, 1, 1 ];
  var tstRay = [ 3, 4, 2, 1, -1, 0, 0, 0 ];
  var expected = 0;

  var gotDistance = _.capsule.rayDistance( srcCapsule, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and ray don´t intersect 2D - parallel';

  var srcCapsule = [ 0, 0, 2, 0, 2 ];
  var tstRay = [ - 3, - 4, 1, 0 ];
  var expected = 2;

  var gotDistance = _.capsule.rayDistance( srcCapsule, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and ray don´t intersect';

  var srcCapsule = [ 0, 0, 2, 0, 0.5 ];
  var tstRay = [ - 3, - 4, 0, 1 ];
  var expected = 2.5;

  var gotDistance = _.capsule.rayDistance( srcCapsule, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and ray don´t intersect with ray´s negative factor 2D';

  var srcCapsule = [ - 3, - 4, -3, 3, 1 ];
  var tstRay = [ 0, 0, 2, 0 ];
  var expected = 2;

  var gotDistance = _.capsule.rayDistance( srcCapsule, tstRay );
  test.equivalent( gotDistance, expected );

  /* */

  test.case = 'Capsule and ray are perpendicular and intersect';

  var srcCapsule = [ 3, 8, 1, 8, 8, 1, 1 ];
  var tstRay = [ 3, 7, 1, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.capsule.rayDistance( srcCapsule, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and ray are perpendicular and don´t intersect';

  var srcCapsule = [ 0, 0, -3, 0, 0, 1, 2 ];
  var tstRay = [ 3, 0, 0, 1, 1, 0 ];
  var expected = 1;

  var gotDistance = _.capsule.rayDistance( srcCapsule, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and ray are parallel to x axis';

  var srcCapsule = [ 3, 7, 1, 7, 7, 1, 0.5 ];
  var tstRay = [ 3, 7, 2, 1, 0, 0 ];
  var expected = 0.5;

  var gotDistance = _.capsule.rayDistance( srcCapsule, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'srcCapsule is null';

  var srcCapsule = null;
  var tstRay = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = Math.sqrt( 53 );

  var gotDistance = _.capsule.rayDistance( srcCapsule, tstRay );
  test.identical( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.rayDistance( ) );
  test.shouldThrowErrorSync( () => _.capsule.rayDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.rayDistance( 'capsule', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.rayDistance( [ 0, 0, 0 ], 'ray') );
  test.shouldThrowErrorSync( () => _.capsule.rayDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.rayDistance( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.rayDistance( [ 1, 1, 1, 2, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.rayDistance( [ 1, 1, 1, 2, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.rayDistance( [ 1, 1, 1, 2, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.rayDistance( [ 1, 1, 1, 2, 2, 2, 1 ], [ 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.rayDistance( [ 1, 1, 1, 2, 2, 2, - 1 ], [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.rayDistance( [ 1, 1, 1, 2, 2, 2 ], [ 1, 1, 1, 2, 2, 2 ] ) );

}

//

function rayClosestPoint( test )
{
  /* */

  test.case = 'Source capsule and ray remain unchanged';

  var srcCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var tstRay = [ 0, 0, 0, 2, 2, 2 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.rayClosestPoint( srcCapsule, tstRay );
  test.identical( gotClosestPoint, expected );

  var oldSrcCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  test.equivalent( srcCapsule, oldSrcCapsule );

  var oldTstRay = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( tstRay, oldTstRay );

  /* */

  test.case = 'Capsule and ray are parallel ( different origin - same direction )';

  var srcCapsule = [ 0, 0, 0, 0, 0, 1, 1 ];
  var tstRay = [ 3, 0, 1, 0, 0, 1 ];
  var expected = _.capsule.tools.long.make( [ 1, 0, 1 ] );

  var gotClosestPoint = _.capsule.rayClosestPoint( srcCapsule, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and ray are parallel ( different origin - different direction )';

  var srcCapsule = [ 0, 7, 1, 0, 7, 8, 1 ];
  var tstRay = [ 0, 0, 0, 0, 0, 0.5 ];
  var expected = _.capsule.tools.long.make( [ 0, 6, 1 ] );

  var gotClosestPoint = _.capsule.rayClosestPoint( srcCapsule, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and ray are parallel ( different origin - opposite direction )';

  var srcCapsule = [ 0, 0, 0, 10, 0, 0, 2 ];
  var tstRay = [ 3, 7, 1, - 7, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 3, 1.9798989873223332, 0.282842712474619 ] );

  var gotClosestPoint = _.capsule.rayClosestPoint( srcCapsule, tstRay );
  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'srcCapsule is a point';

  var srcCapsule = [ 3, 7, 1, 3, 7, 1, 0 ];
  var tstRay = [ 0, 0, 0, 1, 1, 1 ];
  var expected = _.capsule.tools.long.make( [ 3, 7, 1 ] );

  var gotClosestPoint = _.capsule.rayClosestPoint( srcCapsule, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'srcCapsule is a sphere';

  var srcCapsule = [ 3, 7, 1, 3, 7, 1, 1 ];
  var tstRay = [ 0, 0, 0, -1, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 2.609433267057528, 6.088677623134233, 0.8698110890191761 ] );

  var gotClosestPoint = _.capsule.rayClosestPoint( srcCapsule, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'tstRay is a point';

  var srcCapsule = [ 0, 0, 0, 9, 9, 9, 1 ];
  var tstRay = [ 3, 7, 1, 0, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 3.5123633167045747, 4.438183416477126, 3.0494532668182988 ] );

  var gotClosestPoint = _.capsule.rayClosestPoint( srcCapsule, tstRay );
  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and ray are the same';

  var srcCapsule = [ 0, 4, 2, 3, 7, 5, 1 ];
  var tstRay = [ 0, 4, 2, 1, 1, 1 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.rayClosestPoint( srcCapsule, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and ray intersect 4D';

  var srcCapsule = [ 0, 0, 2, 1, 0, 9, 2, 1, 2 ];
  var tstRay = [ 3, 5, 2, 1, -1, 0, 0, 0 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.rayClosestPoint( srcCapsule, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and ray don´t intersect 2D - parallel';

  var srcCapsule = [ 0, 0, 2, 0, 1 ];
  var tstRay = [ - 3, - 4, 1, 0 ];
  var expected = _.capsule.tools.long.make( [ 0, - 1 ] );

  var gotClosestPoint = _.capsule.rayClosestPoint( srcCapsule, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and ray don´t intersect 2D';

  var srcCapsule = [ 0, 0, 2, 0, 1 ];
  var tstRay = [ - 3, - 4, 0.5, 1 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.rayClosestPoint( srcCapsule, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and ray don´t intersect with ray´s negative factor 2D';

  var srcCapsule = [ - 3, - 4, -3, 4, 1 ];
  var tstRay = [ 0, 0, 2, 1 ];
  var expected = _.capsule.tools.long.make( [ -2.1055728090000843, -1.0527864045000421 ] );

  var gotClosestPoint = _.capsule.rayClosestPoint( srcCapsule, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and ray are perpendicular and intersect ( same origin )';

  var srcCapsule = [ 3, 7, 1, 8, 7, 1, 1 ];
  var tstRay = [ 3, 7, 1, 0, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.rayClosestPoint( srcCapsule, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and ray are perpendicular and don´t intersect';

  var srcCapsule = [ 0, 0, -3, 0, 0, 1, 0.5 ];
  var tstRay = [ 3, 0, 0, 1, 1, 0 ];
  var expected = _.capsule.tools.long.make( [ 0.5, 0, 0 ] );

  var gotClosestPoint = _.capsule.rayClosestPoint( srcCapsule, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and ray are parallel to x';

  var srcCapsule = [ 3, 7, 1, 4, 7, 1, 1 ];
  var tstRay = [ 3, 7, 3, 1, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 3, 7, 2 ] );

  var gotClosestPoint = _.capsule.rayClosestPoint( srcCapsule, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'srcCapsule is null';

  var srcCapsule = null;
  var tstRay = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 0, 0, 0 ] );

  var gotClosestPoint = _.capsule.rayClosestPoint( srcCapsule, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.rayClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.capsule.rayClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.rayClosestPoint( 'capsule', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.rayClosestPoint( [ 0, 0, 0 ], 'ray') );
  test.shouldThrowErrorSync( () => _.capsule.rayClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.rayClosestPoint( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.rayClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.rayClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.rayClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.rayClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], [ 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.rayClosestPoint( [ 1, 1, 1, 2, 2, 2, - 1 ], [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.rayClosestPoint( [ 1, 1, 1, 2, 2, 2 ], [ 1, 1, 1, 2, 2, 2 ] ) );

}

//

function segmentContains( test )
{

  /* */

  test.case = 'Source capsule and segment remain unchanged';

  var srcCapsule = [ - 1, - 1, -1, 0, 0, 2, 1 ];
  var tstSegment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = false;

  var gotBool = _.capsule.segmentContains( srcCapsule, tstSegment );
  test.identical( expected, gotBool );

  var oldSrcCapsule = [ - 1, - 1, -1, 0, 0, 2, 1 ];
  test.identical( srcCapsule, oldSrcCapsule );

  var oldtstSegment = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( tstSegment, oldtstSegment );

  /* */

  test.case = 'Capsule and segment intersect';

  var srcCapsule = [ - 1, - 1, -1, 1, 1, 1, 1 ];
  var tstSegment = [ 0, 0, 0, 2, 2, 2 ];
  var expected = false;

  var gotBool = _.capsule.segmentContains( srcCapsule, tstSegment );
  test.identical( expected, gotBool );

  /* */

  test.case = 'Capsule contains segment';

  var srcCapsule = [ - 1, - 1, -1, 2, 2, 2, 1 ];
  var tstSegment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.capsule.segmentContains( srcCapsule, tstSegment );
  test.identical( expected, gotBool );

  /* */

  test.case = 'Segment in capsule edge';

  var srcCapsule = [ -1, -1, -1, 2, 2, 2, 1 ];
  var tstSegment = [ -1, 0, -1, 2, 3, 2 ];
  var expected = true;

  var gotBool = _.capsule.segmentContains( srcCapsule, tstSegment );
  test.identical( expected, gotBool );

  /* */

  test.case = 'Segment is in capsule edge';

  var srcCapsule = [ -1, -1, -1, 0, 0, 0, 0.1 ];
  var tstSegment = [ -1, 0, 0, 0, 0, 0 ];
  var expected = false;

  var gotBool = _.capsule.segmentContains( srcCapsule, tstSegment );
  test.identical( expected, gotBool );

  /* */

  test.case = '2D - not contained';

  var srcCapsule = [ - 1, - 1, 0, 0, 1 ];
  var tstSegment = [ -3, -3, -2, -2 ];
  var expected = false;

  var gotBool = _.capsule.segmentContains( srcCapsule, tstSegment );
  test.identical( expected, gotBool );

  /* */

  test.case = '2D - contained';

  var srcCapsule = [ - 1, - 1, 3, 3, 1 ];
  var tstSegment = [ 0, 0, 2, 2 ];
  var expected = true;

  var gotBool = _.capsule.segmentContains( srcCapsule, tstSegment );
  test.identical( expected, gotBool );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.segmentContains( ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentContains( [] ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentContains( 'capsule', 'segment' ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentContains(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentContains( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentContains( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentContains( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentContains( [ 0, 1, 0, 1, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentContains( [ 0, 1, 0, 1, 2, 1 ], undefined ) );

}

//

function segmentIntersects( test )
{
  /* */

  test.case = 'Source segment and capsule remain unchanged';

  var srcCapsule = [ 0, 0, 1, 1, 1 ];
  var srcSegment = [ 0, 0, 2, 2 ];
  var expected = true;

  var isIntersection = _.capsule.segmentIntersects( srcCapsule, srcSegment );
  test.identical( isIntersection, expected );

  var oldSrcCapsule = [ 0, 0, 1, 1, 1 ];
  test.equivalent( srcCapsule, oldSrcCapsule );

  var oldSrcSegment = [ 0, 0, 2, 2 ];
  test.equivalent( srcSegment, oldSrcSegment );

  /* */

  test.case = 'Capsule and segment are the same';

  var srcCapsule = [ 0, 0, 1, 1, 0 ];
  var srcSegment = [ 0, 0, 1, 1 ];
  var expected = true;

  var isIntersection = _.capsule.segmentIntersects( srcCapsule, srcSegment );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and segment are parallel ( different origin - same direction )';

  var srcCapsule = [ 0, 0, 1, 1, 1 ];
  var srcSegment = [ 3, 7, 4, 8 ];
  var expected = false;

  var isIntersection = _.capsule.segmentIntersects( srcCapsule, srcSegment );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and segment are parallel ( different origin - different direction )';

  var srcCapsule = [ 0, 0, 1, 1, 1 ];
  var srcSegment = [ 3, 7, 2, 6 ];
  var expected = false;

  var isIntersection = _.capsule.segmentIntersects( srcCapsule, srcSegment );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and segment intersect';

  var srcCapsule = [ 5, 5, 1, 1, 1 ];
  var srcSegment = [ 4, 0, 1, 2 ];
  var expected = true;

  var isIntersection = _.capsule.segmentIntersects( srcCapsule, srcSegment );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and segment intersect ';

  var srcCapsule = [ 0, 0, 1, 0.5, 1 ];
  var srcSegment = [ -2, -6, 2, 2 ];
  var expected = true;

  var isIntersection = _.capsule.segmentIntersects( srcCapsule, srcSegment );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and segment don´t intersect';

  var srcCapsule = [ 7, 6, 8, 6, 0.5 ];
  var srcSegment = [ 6, 6, 8, 8 ];
  var expected = false;

  var isIntersection = _.capsule.segmentIntersects( srcCapsule, srcSegment );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and segment don´t intersect - segment negative factor';

  var srcCapsule = [ 1, 0, 2, 0, 0.5 ];
  var srcSegment = [ 3, 0, 4, 0 ];
  var expected = false;

  var isIntersection = _.capsule.segmentIntersects( srcCapsule, srcSegment );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and segment don´t intersect - segment factor > 1';

  var srcCapsule = [ 1, 0, 2, 0, 0.5 ];
  var srcSegment = [ - 1, 0, 0, 0 ];
  var expected = false;

  var isIntersection = _.capsule.segmentIntersects( srcCapsule, srcSegment );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and segment intersect in their origin';

  var srcCapsule = [ 3, 7, 1, 0, 1 ];
  var srcSegment = [ 3, 7, 5, 5 ];
  var expected = true;

  var isIntersection = _.capsule.segmentIntersects( srcCapsule, srcSegment );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and segment are perpendicular and intersect';

  var srcCapsule = [ -3, 0.1, 1, 0.1, 0.2 ];
  var srcSegment = [ 0, -2, 0, 1 ];
  var expected = true;

  var isIntersection = _.capsule.segmentIntersects( srcCapsule, srcSegment );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and segment don´t intersect 3D';

  var srcCapsule = [ 0, 0, 0, 1, 1, 1, 0.1 ];
  var srcSegment = [ 3, 0, 1, 2, 2, -1 ];
  var expected = false;

  var isIntersection = _.capsule.segmentIntersects( srcCapsule, srcSegment );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and segment intersect 3D';

  var srcCapsule = [ 1, 0, 0, 1, 0, 3, 1 ];
  var srcSegment = [ - 3, - 3, 2, 1, 1, 2 ];
  var expected = true;

  var isIntersection = _.capsule.segmentIntersects( srcCapsule, srcSegment );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and segment don´t intersect 4D';

  var srcCapsule = [ 0, 0, 0, 0, 1, 1, 1, 1, 1 ];
  var srcSegment = [ 3, 0, 1, 4, 2, 2, 2, -1 ];
  var expected = false;

  var isIntersection = _.capsule.segmentIntersects( srcCapsule, srcSegment );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Capsule and segment intersect 4D';

  var srcCapsule = [ 0, 0, 0, 0, 4, 4, 4, 4, 2 ];
  var srcSegment = [ 3, 2, 1, 0, 3, 5, 7, 9 ];
  var expected = true;

  var isIntersection = _.capsule.segmentIntersects( srcCapsule, srcSegment );
  test.identical( isIntersection, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.segmentIntersects( ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentIntersects( 'capsule', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentIntersects( [ 1, 1, 2, 2, 1 ], 'segment') );
  test.shouldThrowErrorSync( () => _.capsule.segmentIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentIntersects( [ 1, 1, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentIntersects( [ 1, 1, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentIntersects( [ 1, 1, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentIntersects( [ 1, 1, 2, 2, 1 ], [ 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentIntersects( [ 1, 1, 2, 2, - 1 ], [ 1, 2, 3, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentIntersects( [ 1, 1, 2, 2 ], [ 1, 2, 1, 0 ] ) );

}

//

function segmentDistance( test )
{
  /* */

  test.case = 'Source capsule and segment remain unchanged';

  var srcCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var tstSegment = [ 0, 0, 0, 2, 2, 2 ];
  var expected = 0;

  var gotDistance = _.capsule.segmentDistance( srcCapsule, tstSegment );
  test.identical( gotDistance, expected );

  var oldSrcCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  test.equivalent( srcCapsule, oldSrcCapsule );

  var oldTstSegment = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( tstSegment, oldTstSegment );

  /* */

  test.case = 'Capsule and segment are parallel ( different origin - same direction )';

  var srcCapsule = [ 0, 0, 0, 0, 0, 1, 1 ];
  var tstSegment = [ 3, 7, 1, 3, 7, 8 ];
  var expected = Math.sqrt( 58 ) - 1;

  var gotDistance = _.capsule.segmentDistance( srcCapsule, tstSegment );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and segment are parallel ( different origin - different direction )';

  var srcCapsule = [ 3, 7, 1, 3, 7, 7, 2 ];
  var tstSegment = [ 0, 0, 0, 0, 0, 9 ];
  var expected = Math.sqrt( 58 ) - 2;

  var gotDistance = _.capsule.segmentDistance( srcCapsule, tstSegment );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and segment are parallel ( different origin - opposite direction )';

  var srcCapsule = [ 0, 0, 0, 9, 0, 0, 3 ];
  var tstSegment = [ 3, 7, 1, - 7, 7, 1 ];
  var expected = Math.sqrt( 50 ) - 3;

  var gotDistance = _.capsule.segmentDistance( srcCapsule, tstSegment );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'srcCapsule is a point';

  var srcCapsule = [ 3, 7, 1, 3, 7, 1, 0 ];
  var tstSegment = [ 0, 0, 0, 6, 6, 6 ];
  var expected =  Math.sqrt( 168 / 9 );

  var gotDistance = _.capsule.segmentDistance( srcCapsule, tstSegment );
  test.equivalent( gotDistance, expected );

  /* */

  test.case = 'tstSegment is a point';

  var srcCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var tstSegment = [ 3, 7, 1, 3, 7, 1 ];
  var expected = Math.sqrt( 40 ) - 1;

  var gotDistance = _.capsule.segmentDistance( srcCapsule, tstSegment );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'srcCapsule is a sphere';

  var srcCapsule = [ 3, 7, 1, 3, 7, 1, 2 ];
  var tstSegment = [ 0, 0, 0, 7, 7, 7 ];
  var expected =  Math.sqrt( 168 / 9 ) - 2;

  var gotDistance = _.capsule.segmentDistance( srcCapsule, tstSegment );
  test.equivalent( gotDistance, expected );

  /* */

  test.case = 'Capsule and segment are the same';

  var srcCapsule = [ 0, 4, 2, 5, 4, 2, 0 ];
  var tstSegment = [ 0, 4, 2, 5, 4, 2 ];
  var expected = 0;

  var gotDistance = _.capsule.segmentDistance( srcCapsule, tstSegment );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and segment intersect 4D';

  var srcCapsule = [ 0, 0, 2, 1, 0, 9, 2, 1, 1 ];
  var tstSegment = [ 3, 4, 2, 1, - 7, 4, 2, 1 ];
  var expected = 0;

  var gotDistance = _.capsule.segmentDistance( srcCapsule, tstSegment );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and segment don´t intersect 2D - parallel';

  var srcCapsule = [ 0, 0, 2, 0, 2 ];
  var tstSegment = [ - 3, - 4, 5, - 4 ];
  var expected = 2;

  var gotDistance = _.capsule.segmentDistance( srcCapsule, tstSegment );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and segment don´t intersect';

  var srcCapsule = [ 0, 0, 2, 0, 0.5 ];
  var tstSegment = [ - 3, - 4, - 3, 4 ];
  var expected = 2.5;

  var gotDistance = _.capsule.segmentDistance( srcCapsule, tstSegment );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and segment don´t intersect with segment´s negative factor';

  var srcCapsule = [ 1, 1, 2, 2, 1 ];
  var tstSegment = [ 3, 3, 5, 5 ];
  var expected = Math.sqrt( 2 ) - 1;

  var gotDistance = _.capsule.segmentDistance( srcCapsule, tstSegment );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and segment don´t intersect with segment´s factor > 1';

  var srcCapsule = [ 1, 1, 1, 2, 0.5 ];
  var tstSegment = [ 1, - 1, 1, 0 ];
  var expected = 0.5;

  var gotDistance = _.capsule.segmentDistance( srcCapsule, tstSegment );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and segment are perpendicular and intersect';

  var srcCapsule = [ 3, 8, 1, 8, 8, 1, 1 ];
  var tstSegment = [ 3, 7, 1, 3, 7, 8 ];
  var expected = 0;

  var gotDistance = _.capsule.segmentDistance( srcCapsule, tstSegment );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and segment are perpendicular and don´t intersect';

  var srcCapsule = [ 0, 0, -3, 0, 0, 1, 2 ];
  var tstSegment = [ 3, 0, 0, 8, 5, 0 ];
  var expected = 1;

  var gotDistance = _.capsule.segmentDistance( srcCapsule, tstSegment );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and segment are parallel to x axis';

  var srcCapsule = [ 3, 7, 1, 7, 7, 1, 0.5 ];
  var tstSegment = [ 3, 7, 2, 8, 7, 2 ];
  var expected = 0.5;

  var gotDistance = _.capsule.segmentDistance( srcCapsule, tstSegment );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'srcCapsule is null';

  var srcCapsule = null;
  var tstSegment = [ 3, 7, 2, - 1, 7, 2 ];
  var expected = Math.sqrt( 53 );

  var gotDistance = _.capsule.segmentDistance( srcCapsule, tstSegment );
  test.identical( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.segmentDistance( ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentDistance( 'capsule', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentDistance( [ 0, 0, 0 ], 'segment') );
  test.shouldThrowErrorSync( () => _.capsule.segmentDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentDistance( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentDistance( [ 1, 1, 1, 2, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentDistance( [ 1, 1, 1, 2, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentDistance( [ 1, 1, 1, 2, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentDistance( [ 1, 1, 1, 2, 2, 2, 1 ], [ 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentDistance( [ 1, 1, 1, 2, 2, 2, - 1 ], [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentDistance( [ 1, 1, 1, 2, 2, 2 ], [ 1, 1, 1, 2, 2, 2 ] ) );

}

//

function segmentClosestPoint( test )
{
  /* */

  test.case = 'Source capsule and segment remain unchanged';

  var srcCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var tstSegment = [ 0, 0, 0, 2, 2, 2 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.segmentClosestPoint( srcCapsule, tstSegment );
  test.identical( gotClosestPoint, expected );

  var oldSrcCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  test.equivalent( srcCapsule, oldSrcCapsule );

  var oldTstSegment = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( tstSegment, oldTstSegment );

  /* */

  test.case = 'Capsule and segment are parallel ( different origin - same direction )';

  var srcCapsule = [ 0, 0, 0, 0, 0, 1, 1 ];
  var tstSegment = [ 3, 0, 1, 3, 0, 9 ];
  var expected = _.capsule.tools.long.make( [ 1, 0, 1 ] );

  var gotClosestPoint = _.capsule.segmentClosestPoint( srcCapsule, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and segment are parallel ( different origin - different direction )';

  var srcCapsule = [ 0, 7, 1, 0, 7, 8, 1 ];
  var tstSegment = [ 0, 0, 0, 0, 0, 6 ];
  var expected = _.capsule.tools.long.make( [ 0, 6, 1 ] );

  var gotClosestPoint = _.capsule.segmentClosestPoint( srcCapsule, tstSegment );
  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and segment are parallel ( different origin - opposite direction )';

  var srcCapsule = [ 0, 0, 0, 10, 0, 0, 2 ];
  var tstSegment = [ 3, 7, 1, - 7, 7, 1 ];
  var expected = _.capsule.tools.long.make( [ 3, 1.9798989873223332, 0.282842712474619 ] );

  var gotClosestPoint = _.capsule.segmentClosestPoint( srcCapsule, tstSegment );
  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'srcCapsule is a point';

  var srcCapsule = [ 3, 7, 1, 3, 7, 1, 0 ];
  var tstSegment = [ 0, 0, 0, 8, 8, 8 ];
  var expected = _.capsule.tools.long.make( [ 3, 7, 1 ] );

  var gotClosestPoint = _.capsule.segmentClosestPoint( srcCapsule, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'srcCapsule is a sphere';

  var srcCapsule = [ 3, 7, 1, 3, 7, 1, 1 ];
  var tstSegment = [ 0, 0, 0, -1, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 2.609433267057528, 6.088677623134233, 0.8698110890191761 ] );

  var gotClosestPoint = _.capsule.segmentClosestPoint( srcCapsule, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'tstSegment is a point';

  var srcCapsule = [ 0, 0, 0, 9, 9, 9, 1 ];
  var tstSegment = [ 3, 7, 1, 3, 7, 1 ];
  var expected = _.capsule.tools.long.make( [ 3.5123633167045747, 4.438183416477126, 3.0494532668182988 ] );

  var gotClosestPoint = _.capsule.segmentClosestPoint( srcCapsule, tstSegment );
  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and segment are the same';

  var srcCapsule = [ 0, 4, 2, 3, 7, 5, 1 ];
  var tstSegment = [ 0, 4, 2, 3, 7, 5 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.segmentClosestPoint( srcCapsule, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and segment intersect 4D';

  var srcCapsule = [ 0, 0, 2, 1, 0, 9, 2, 1, 2 ];
  var tstSegment = [ 3, 5, 2, 1, -3, 5, 2, 1 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.segmentClosestPoint( srcCapsule, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and segment don´t intersect 2D - parallel';

  var srcCapsule = [ 0, 0, 2, 0, 1 ];
  var tstSegment = [ - 3, - 4, 1, - 4 ];
  var expected = _.capsule.tools.long.make( [ 0, - 1 ] );

  var gotClosestPoint = _.capsule.segmentClosestPoint( srcCapsule, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and segment don´t intersect 2D';

  var srcCapsule = [ 0, 0, 2, 0, 1 ];
  var tstSegment = [ - 3, - 4, 1, 4 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.segmentClosestPoint( srcCapsule, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and segment don´t intersect with segment´s negative factor';

  var srcCapsule = [ - 3, - 4, -3, 4, 1 ];
  var tstSegment = [ 0, 0, 10, 5 ];
  var expected = _.capsule.tools.long.make( [ -2, 0 ] );

  var gotClosestPoint = _.capsule.segmentClosestPoint( srcCapsule, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and segment don´t intersect with segment´s factor > 1';

  var srcCapsule = [ - 3, 1, 4, 1, 1 ];
  var tstSegment = [ - 8, 1, - 5, 1 ];
  var expected = _.capsule.tools.long.make( [ - 4, 1 ] );

  var gotClosestPoint = _.capsule.segmentClosestPoint( srcCapsule, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and segment are perpendicular and intersect ( same origin )';

  var srcCapsule = [ 3, 7, 1, 8, 7, 1, 1 ];
  var tstSegment = [ 3, 7, 1, 3, 7, 8 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.segmentClosestPoint( srcCapsule, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and segment are perpendicular and don´t intersect';

  var srcCapsule = [ 0, 0, -3, 0, 0, 1, 0.5 ];
  var tstSegment = [ 3, 0, 0, 5, 2, 0 ];
  var expected = _.capsule.tools.long.make( [ 0.5, 0, 0 ] );

  var gotClosestPoint = _.capsule.segmentClosestPoint( srcCapsule, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and segment are parallel to x';

  var srcCapsule = [ 3, 7, 1, 4, 7, 1, 1 ];
  var tstSegment = [ 3, 7, 3, 8, 7, 3 ];
  var expected = _.capsule.tools.long.make( [ 3, 7, 2 ] );

  var gotClosestPoint = _.capsule.segmentClosestPoint( srcCapsule, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'srcCapsule is null';

  var srcCapsule = null;
  var tstSegment = [ 3, 7, 2, - 3, 7, 2 ];
  var expected = _.capsule.tools.long.make( [ 0, 0, 0 ] );

  var gotClosestPoint = _.capsule.segmentClosestPoint( srcCapsule, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.capsule.segmentClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentClosestPoint( 'capsule', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentClosestPoint( [ 0, 0, 0 ], 'segment') );
  test.shouldThrowErrorSync( () => _.capsule.segmentClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentClosestPoint( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], [ 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentClosestPoint( [ 1, 1, 1, 2, 2, 2, - 1 ], [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.segmentClosestPoint( [ 1, 1, 1, 2, 2, 2 ], [ 1, 1, 1, 2, 2, 2 ] ) );

}

//

function sphereContains( test )
{

  /* */

  test.case = 'Capsule and sphere remain unchanged';

  var capsule = [  - 1,  - 1, -1, 1, 1, 1, 1 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.capsule.sphereContains( capsule, sphere );
  test.identical( gotBool, expected );

  var oldCapsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  test.identical( capsule, oldCapsule );

  var oldSphere = [ 0, 0, 0, 1 ];
  test.identical( sphere, oldSphere );

  /* */

  test.case = 'Sphere contains point capsule';

  var capsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = false;

  var gotBool = _.capsule.sphereContains( capsule, sphere );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'point capsule - not contained';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0 ];
  var sphere = [ 4, 3, 4, 1 ];
  var expected = false;

  var gotBool = _.capsule.sphereContains( capsule, sphere );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'point sphere in capsule';

  var capsule = [ 1, 2, 1, 1, 2, 4, 2 ];
  var sphere = [ 2, 2, 2, 0 ];
  var expected = true;

  var gotBool = _.capsule.sphereContains( capsule, sphere );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'sphere capsule - no intersection';

  var capsule = [ 1, 2, 3, 1, 2, 3, 1 ];
  var sphere = [ 4, 3, 4, 1 ];
  var expected = false;

  var gotBool = _.capsule.sphereContains( capsule, sphere );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'Capsule in sphere';

  var capsule = [ 1, 2, 3, 2, 2, 3, 0.1 ];
  var sphere = [ 2, 2, 2, 2 ];
  var expected = false;

  var gotBool = _.capsule.sphereContains( capsule, sphere );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'Sphere in capsule';

  var capsule = [ 1, 2, 3, 2, 2, 3, 2 ];
  var sphere = [ 2, 2, 2, 0.2 ];
  var expected = true;

  var gotBool = _.capsule.sphereContains( capsule, sphere );
  test.identical( gotBool,  expected );

  /* */

  test.case = 'Capsule and sphere intersect';

  var capsule = [ -2, -2, -2, 3, 3, 3, 1 ];
  var sphere = [ 4, 4, 4, 1 ];
  var expected = false;

  var gotBool = _.capsule.sphereContains( capsule, sphere );
  test.identical( gotBool,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.sphereContains( ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereContains( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereContains( 'capsule', [ 1, 1, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereContains( [ 1, 1, 1, 2, 2, 2, 1 ], 'sphere') );
  test.shouldThrowErrorSync( () => _.capsule.sphereContains( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereContains( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereContains( [ 1, 1, 1, 2, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereContains( [ 1, 1, 1, 2, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereContains( [ 1, 1, 1, 2, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereContains( [ 1, 1, 1, 2, 2, 2, 1 ], [ 1, 2, 3, 4, 5, 6 ] ) );
  // test.shouldThrowErrorSync( () => _.capsule.sphereContains( [ 1, 1, 1, 2, 2, 2, - 1 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereContains( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function sphereIntersects( test )
{

  /* */

  test.case = 'Capsule and sphere remain unchanged';

  var capsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.capsule.sphereIntersects( capsule, sphere );
  test.identical( gotBool, expected );

  var oldCapsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  test.identical( capsule, oldCapsule );

  var oldSphere = [ 0, 0, 0, 1 ];
  test.identical( sphere, oldSphere );

  /* */

  test.case = 'Null capsule - empty sphere';

  var capsule = null;
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.capsule.sphereIntersects( capsule, sphere );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point capsule center of sphere';

  var capsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.capsule.sphereIntersects( capsule, sphere );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point capsule - no intersection';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0 ];
  var sphere = [ 4, 3, 4, 1 ];
  var expected = false;

  var gotBool = _.capsule.sphereIntersects( capsule, sphere );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point capsule in sphere';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0 ];
  var sphere = [ 2, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.capsule.sphereIntersects( capsule, sphere );
  test.identical( gotBool, expected );

  /* */

  test.case = 'sphere capsule center of sphere';

  var capsule = [ 0, 0, 0, 0, 0, 0, 0.5 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.capsule.sphereIntersects( capsule, sphere );
  test.identical( gotBool, expected );

  /* */

  test.case = 'sphere capsule - no intersection';

  var capsule = [ 1, 2, 3, 1, 2, 3, 1 ];
  var sphere = [ 4, 3, 4, 1 ];
  var expected = false;

  var gotBool = _.capsule.sphereIntersects( capsule, sphere );
  test.identical( gotBool, expected );

  /* */

  test.case = 'sphere capsule in sphere';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0.1 ];
  var sphere = [ 2, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.capsule.sphereIntersects( capsule, sphere );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Capsule and sphere intersect';

  var capsule = [ -2, -2, -2, 3, 3, 3, 1 ];
  var sphere = [ 4, 4, 4, 1 ];
  var expected = true;

  var gotBool = _.capsule.sphereIntersects( capsule, sphere );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Capsule over sphere';

  var capsule = [ 0, -6, 4, 0, 1, 4, 0.5 ];
  var sphere = [ 0, 0, 0, 3 ];
  var expected = false;

  var gotBool = _.capsule.sphereIntersects( capsule, sphere );
  test.identical( gotBool, expected );

  /* */

  test.case = 'sphere closer to origin';

  var capsule = [ 0, 0, 0, 2, 2, 2, 1 ];
  var sphere = [ - 2, - 2, - 2, 0.5 ];
  var expected = false;

  var gotBool = _.capsule.sphereIntersects( capsule, sphere );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.sphereIntersects( ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereIntersects( 'capsule', [ 1, 1, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereIntersects( [ 1, 1, 1, 2, 2, 2, 1 ], 'sphere') );
  test.shouldThrowErrorSync( () => _.capsule.sphereIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereIntersects( [ 1, 1, 1, 2, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereIntersects( [ 1, 1, 1, 2, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereIntersects( [ 1, 1, 1, 2, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereIntersects( [ 1, 1, 1, 2, 2, 2, 1 ], [ 1, 2, 3, 4, 5, 6 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereIntersects( [ 1, 1, 1, 2, 2, 2, - 1 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereIntersects( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function sphereDistance( test )
{

  /* */

  test.case = 'Capsule and sphere remain unchanged';

  var capsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.capsule.sphereDistance( capsule, sphere );
  test.identical( gotDistance, expected );

  var oldCapsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  test.identical( capsule, oldCapsule );

  var oldSphere = [ 0, 0, 0, 1 ];
  test.identical( sphere, oldSphere );

  /* */

  test.case = 'Null capsule - empty sphere';

  var capsule = null;
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.capsule.sphereDistance( capsule, sphere );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'point capsule center of sphere';

  var capsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.capsule.sphereDistance( capsule, sphere );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'point capsule - no intersection';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0 ];
  var sphere = [ 4, 3, 4, 1 ];
  var expected = Math.sqrt( 11 ) - 1;

  var gotDistance = _.capsule.sphereDistance( capsule, sphere );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'point capsule in sphere';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0 ];
  var sphere = [ 2, 2, 2, 2 ];
  var expected = 0;

  var gotDistance = _.capsule.sphereDistance( capsule, sphere );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'point capsule center of sphere';

  var capsule = [ 0, 0, 0, 0, 0, 0, 0.5 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.capsule.sphereDistance( capsule, sphere );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'point capsule - no intersection';

  var capsule = [ 1, 2, 3, 1, 2, 3, 1 ];
  var sphere = [ 4, 3, 4, 1 ];
  var expected = Math.sqrt( 11 ) - 2;

  var gotDistance = _.capsule.sphereDistance( capsule, sphere );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'point capsule in sphere';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0.1 ];
  var sphere = [ 2, 2, 2, 2 ];
  var expected = 0;

  var gotDistance = _.capsule.sphereDistance( capsule, sphere );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule and sphere intersect';

  var capsule = [ -2, -2, -2, 2, 2, 2, 1 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.capsule.sphereDistance( capsule, sphere );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Capsule over sphere';

  var capsule = [ 0, -6, 4, 0, 1, 4, 0.5 ];
  var sphere = [ 0, 0, 0, 3 ];
  var expected = 0.5;

  var gotDistance = _.capsule.sphereDistance( capsule, sphere );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'sphere closer to origin';

  var capsule = [ 0, 0, 0, 2, 2, 2, 0.5];
  var sphere = [ - 2, - 2, - 2, 0.5 ];
  var expected = Math.sqrt( 12 ) - 1;

  var gotDistance = _.capsule.sphereDistance( capsule, sphere );
  test.identical( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.sphereDistance( ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereDistance( 'capsule', [ 1, 1, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereDistance( [ 1, 1, 1, 2, 2, 2, 1 ], 'sphere') );
  test.shouldThrowErrorSync( () => _.capsule.sphereDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereDistance( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereDistance( [ 1, 1, 1, 2, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereDistance( [ 1, 1, 1, 2, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereDistance( [ 1, 1, 1, 2, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereDistance( [ 1, 1, 1, 2, 2, 2, 1 ], [ 1, 2, 3, 4, 5, 6 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereDistance( [ 1, 1, 1, 2, 2, 2, - 1 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereDistance( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function sphereClosestPoint( test )
{

  /* */

  test.case = 'Capsule and sphere remain unchanged';

  var capsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.sphereClosestPoint( capsule, sphere );
  test.identical( gotClosestPoint, expected );

  var oldCapsule = [  - 1, - 1, -1, 1, 1, 1, 1 ];
  test.identical( capsule, oldCapsule );

  var oldSphere = [ 0, 0, 0, 1 ];
  test.identical( sphere, oldSphere );

  /* */

  test.case = 'Null capsule - empty sphere';

  var capsule = null;
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.sphereClosestPoint( capsule, sphere );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'point capsule center of sphere';

  var capsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.sphereClosestPoint( capsule, sphere );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'point capsule - no intersection';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0 ];
  var sphere = [ 4, 3, 4, 1 ];
  var expected = _.capsule.tools.long.make( [ 1, 2, 3 ] );

  var gotClosestPoint = _.capsule.sphereClosestPoint( capsule, sphere );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'point capsule in sphere';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0 ];
  var sphere = [ 2, 2, 2, 2 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.sphereClosestPoint( capsule, sphere );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'sphere capsule center of sphere';

  var capsule = [ 0, 0, 0, 0, 0, 0, 0.5 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.sphereClosestPoint( capsule, sphere );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'point capsule - no intersection';

  var capsule = [ 1, 2, 3, 1, 2, 3, 1 ];
  var sphere = [ 4, 3, 4, 1 ];
  var expected = _.capsule.tools.long.make( [ 1.9045340337332908, 2.3015113445777637, 3.3015113445777637 ] );

  var gotClosestPoint = _.capsule.sphereClosestPoint( capsule, sphere );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'sphere capsule in sphere';

  var capsule = [ 1, 2, 3, 1, 2, 3, 0.1 ];
  var sphere = [ 2, 2, 2, 2 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.sphereClosestPoint( capsule, sphere );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule and sphere intersect';

  var capsule = [ -2, -2, -2, 2, 2, 2, 1 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.capsule.sphereClosestPoint( capsule, sphere );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Capsule over sphere';

  var capsule = [ 0, -6, 4, 0, 1, 4, 0.5 ];
  var sphere = [ 0, 0, 0, 3 ];
  var expected = _.capsule.tools.long.make( [ 0, 0, 3.5 ] );

  var gotClosestPoint = _.capsule.sphereClosestPoint( capsule, sphere );
  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'sphere closer to origin';

  var capsule = [ 0, 0, 0, 2, 2, 2, Math.sqrt( 3 ) ];
  var sphere = [ - 2, - 2, - 2, 0.5 ];
  var expected = _.capsule.tools.long.make( [ - 1, - 1, - 1 ] );

  var gotClosestPoint = _.capsule.sphereClosestPoint( capsule, sphere );
  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'dstPoint is vector';

  var capsule = [ 0, -6, 4, 0, 1, 4, 1 ];
  var sphere = [ 0, 5, 0, 3 ];
  var dstPoint = _.vectorAdapter.from( [ 0, 0, 0 ] );
  var expected = _.capsule.tools.vectorAdapter.from( [ 0, 1 + Math.sqrt( 2 ) / 2, 3.2928932188134525 ] );

  var gotClosestPoint = _.capsule.sphereClosestPoint( capsule, sphere, dstPoint );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'dstPoint is array';

  var capsule = [ 0, -6, 4, 0, 1, 4, 1 ];
  var sphere = [ 0, 5, 0, 3 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 0, 1 + Math.sqrt( 2 ) / 2, 3.2928932188134525 ] );

  var gotClosestPoint = _.capsule.sphereClosestPoint( capsule, sphere, dstPoint );
  test.identical( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.sphereClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereClosestPoint( 'capsule', [ 1, 1, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], 'sphere') );
  test.shouldThrowErrorSync( () => _.capsule.sphereClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereClosestPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], undefined ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereClosestPoint( [ 1, 1, 1, 2, 2, 2, 1 ], [ 1, 2, 3, 4, 5, 6 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereClosestPoint( [ 1, 1, 1, 2, 2, 2, - 1 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.sphereClosestPoint( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function boundingSphereGet( test )
{

  /* */

  test.case = 'Source capsule remains unchanged';

  var srcCapsule = [ 0, 0, 0, 3, 3, 3, 1 ];
  var dstSphere = [ 1, 1, 2, 1 ];
  var expected = _.capsule.tools.long.make( [ 1.5, 1.5, 1.5, Math.sqrt( 6.75 ) + 1 ] );

  var gotSphere = _.capsule.boundingSphereGet( dstSphere, srcCapsule );
  test.identical( expected, gotSphere );
  test.true( dstSphere === gotSphere );

  var oldSrcCapsule = [ 0, 0, 0, 3, 3, 3, 1 ];
  test.identical( srcCapsule, oldSrcCapsule );

  /* */

  test.case = 'Zero capsule to zero sphere';

  var srcCapsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var dstSphere = [ 0, 0, 0, 0 ];
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, 0 ] );

  var gotSphere = _.capsule.boundingSphereGet( dstSphere, srcCapsule );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Sphere inside capsule - same center';

  var srcCapsule = [ 0, 0, 0, 4, 4, 4, 0.2 ];
  var dstSphere = [ 2, 2, 2, 1 ];
  var expected = _.capsule.tools.long.make( [ 2, 2, 2, Math.sqrt( 12 ) + 0.2 ] );

  var gotSphere = _.capsule.boundingSphereGet( dstSphere, srcCapsule );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Point capsule and point Sphere';

  var srcCapsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var dstSphere = [ 3, 3, 3, 0 ];
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, 0 ] );

  var gotSphere = _.capsule.boundingSphereGet( dstSphere, srcCapsule );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Capsule inside Sphere';

  var srcCapsule = [ 0, 0, 0, 1, 1, 1, 0.1 ];
  var dstSphere = [ 0, 0, 0, 3 ];
  var expected = _.capsule.tools.long.make( [ 0.5, 0.5, 0.5, Math.sqrt( 0.75 ) + 0.1 ] );

  var gotSphere = _.capsule.boundingSphereGet( dstSphere, srcCapsule );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Sphere outside capsule';

  var srcCapsule = [ 1, 2, 3, 5, 8, 9, 3 ];
  var dstSphere = [ 5, 5, 5, 3 ];
  var expected = _.capsule.tools.long.make( [ 3, 5, 6, Math.sqrt( 22 ) + 3 ] );

  var gotSphere = _.capsule.boundingSphereGet( dstSphere, srcCapsule );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'srcCapsule vector';

  var srcCapsule = _.vectorAdapter.from( [- 1, - 1, - 1, 1, 1, 1, 1 ] );
  var dstSphere = [ 5, 5, 5, 3 ];
  var expected = _.capsule.tools.long.make( [ 0, 0, 0, Math.sqrt( 3 ) + 1 ] );

  var gotSphere = _.capsule.boundingSphereGet( dstSphere, srcCapsule );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'dstSphere vector';

  var srcCapsule = [- 1, - 1, - 1, 3, 3, 1, 0.5 ];
  var dstSphere = _.vectorAdapter.from( [ 5, 5, 5, 3 ] );
  var expected = _.capsule.tools.vectorAdapter.from( [ 1, 1, 0, 3.5 ] );

  var gotSphere = _.capsule.boundingSphereGet( dstSphere, srcCapsule );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'dstSphere null';

  var srcCapsule = [- 1, 5, - 1, 3, 7, 1, 1 ];
  var dstSphere = null;
  var expected = _.capsule.tools.long.make( [ 1, 6, 0, Math.sqrt( 6 ) + 1 ] );

  var gotSphere = _.capsule.boundingSphereGet( dstSphere, srcCapsule );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'dstSphere undefined';

  var srcCapsule = [- 1, - 3, - 5, 1, 0, 0, 0 ];
  var dstSphere = undefined;
  var expected = _.capsule.tools.long.make( [ 0, - 1.5, - 2.5, Math.sqrt( 9.5 ) ] );

  var gotSphere = _.capsule.boundingSphereGet( dstSphere, srcCapsule );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'srcCapsule inversed';

  var srcCapsule = _.vectorAdapter.from( [ 4, 4, 4, 2, 2, 2, 0.2 ] );
  var dstSphere = [ 5, 5, 5, 3 ];
  var expected = _.capsule.tools.long.make( [ 3, 3, 3, Math.sqrt( 3 ) + 0.2 ] );

  var gotSphere = _.capsule.boundingSphereGet( dstSphere, srcCapsule );
  test.identical( gotSphere, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.capsule.boundingSphereGet( ) );
  test.shouldThrowErrorSync( () => _.capsule.boundingSphereGet( [] ) );
  test.shouldThrowErrorSync( () => _.capsule.boundingSphereGet( [], [] ) );
  test.shouldThrowErrorSync( () => _.capsule.boundingSphereGet( 'capsule', 'sphere' ) );
  test.shouldThrowErrorSync( () => _.capsule.boundingSphereGet( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boundingSphereGet( [ 0, 0, 0, 1 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boundingSphereGet( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boundingSphereGet( NaN, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boundingSphereGet( [ 0, 1, 0, 1, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.capsule.boundingSphereGet( [ 0, 1, 0, 1, 2, 1 ], NaN ) );
  test.shouldThrowErrorSync( () => _.capsule.boundingSphereGet( [ 0, 1, 0, 1 ], [ 0, 0, 1, 2, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.capsule.boundingSphereGet( [ 0, 1, 0, 1 ], [ 0, 0, 1, 2, 2, 3, - 1 ] ) );

}




// --
// define class
// --

const Proto =
{

  name : 'Tools.Math.Capsule',
  silencing : 1,
  enabled : 1,
  // routine: 'is',

  tests :
  {

    make,
    makeZero,
    makeSingular,

    zero,
    nil,

    from,
    adapterFrom,

    is,
    dimGet,
    originGet,
    endPointGet,
    radiusGet,
    radiusSet,

    expand,
    project,
    getProjectionFactors,

    pointContains,
    pointDistance,
    pointClosestPoint,

    boxContains,
    boxIntersects,
    boxDistance,
    boxClosestPoint,
    boundingBoxGet,

    capsuleContains,
    capsuleIntersects,
    capsuleDistance,
    capsuleClosestPoint,

    convexPolygonContains,
    convexPolygonClosestPoint,

    frustumContains,
    frustumIntersects,
    frustumDistance,
    frustumClosestPoint,

    lineIntersects,
    lineDistance,
    lineClosestPoint,

    planeIntersects,
    planeDistance,
    planeClosestPoint,

    rayIntersects,
    rayDistance,
    rayClosestPoint,

    segmentContains,
    segmentIntersects,
    segmentDistance,
    segmentClosestPoint,

    sphereContains,
    sphereIntersects,
    sphereDistance,
    sphereClosestPoint,
    boundingSphereGet,

  }

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
