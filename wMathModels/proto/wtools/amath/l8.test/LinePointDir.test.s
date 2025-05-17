( function _LinePointDir_test_s_( ) {

'use strict';

// return;

if( typeof module !== 'undefined' )
{

  const _ = require( 'Tools' );

  _.include( 'wTesting' );
  _.include( 'wMathVector' );
  _.include( 'wMathMatrix' );

  require( '../l8/Concepts.s' );

}

//

const _ = _global_.wTools.withLong.Fx;
var Matrix = _.Matrix;
var vector = _.vectorAdapter;
var vec = _.vectorAdapter.fromLong;
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

  test.case = 'srcDim undefined';

  var srcDim = undefined;
  var gotLine = _.linePointDir.make( srcDim );
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0, 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.true( gotLine !== srcDim );

  /* */

  test.case = 'srcDim null';

  var srcDim = null;
  var gotLine = _.linePointDir.make( srcDim );
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0, 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.true( gotLine !== srcDim );

  /* */

  test.case = 'srcDim 2';

  var srcDim = 2;
  var gotLine = _.linePointDir.make( srcDim );
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.true( gotLine !== srcDim );

  /* */

  test.case = 'srcDim array';

  var srcDim = [ 0, 1, 2, 3 ];
  var gotLine = _.linePointDir.make( srcDim );
  var expected = _.linePointDir.tools.long.make( [ 0, 1, 2, 3 ] );
  test.identical( gotLine, expected );
  test.true( gotLine !== srcDim );

  /* */

  test.case = 'srcDim vector';

  var srcDim = _.vectorAdapter.fromLong([ 0, 1, 2, 3 ]);
  var gotLine = _.linePointDir.make( srcDim );
  var expected = _.linePointDir.tools.long.make( [ 0, 1, 2, 3 ] );
  test.identical( gotLine, expected );
  test.true( gotLine !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.make( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.linePointDir.make( 'line' ));
}

//

function makeZero( test )
{
  /* */

  test.case = 'srcDim undefined';

  var srcDim = undefined;
  var gotLine = _.linePointDir.makeZero( srcDim );
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0, 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.true( gotLine !== srcDim );

  /* */

  test.case = 'srcDim null';

  var srcDim = null;
  var gotLine = _.linePointDir.makeZero( srcDim );
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0, 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.true( gotLine !== srcDim );

  /* */

  test.case = 'srcDim 2';

  var srcDim = 2;
  var gotLine = _.linePointDir.makeZero( srcDim );
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.true( gotLine !== srcDim );

  /* */

  test.case = 'srcDim array';

  var srcDim = [ 0, 1, 2, 3 ];
  var gotLine = _.linePointDir.makeZero( srcDim );
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.true( gotLine !== srcDim );

  /* */

  test.case = 'srcDim vector';

  var srcDim = _.vectorAdapter.fromLong([ 0, 1, 2, 3 ]);
  var gotLine = _.linePointDir.makeZero( srcDim );
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.true( gotLine !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.makeZero( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.linePointDir.makeZero( 'line' ));

}

//

function makeSingular( test )
{
  /* */

  test.case = 'srcDim undefined';

  var srcDim = undefined;
  var gotLine = _.linePointDir.makeSingular( srcDim );
  var expected = _.linePointDir.tools.long.make( [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ] );
  test.identical( gotLine, expected );
  test.true( gotLine !== srcDim );

  /* */

  test.case = 'srcDim null';

  var srcDim = null;
  var gotLine = _.linePointDir.makeSingular( srcDim );
  var expected = _.linePointDir.tools.long.make( [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ] );
  test.identical( gotLine, expected );
  test.true( gotLine !== srcDim );

  /* */

  test.case = 'srcDim 2';

  var srcDim = 2;
  var gotLine = _.linePointDir.makeSingular( srcDim );
  var expected = _.linePointDir.tools.long.make( [ Infinity, Infinity, - Infinity, - Infinity ] );
  test.identical( gotLine, expected );
  test.true( gotLine !== srcDim );

  /* */

  test.case = 'srcDim array';

  var srcDim = [ 0, 1, 2, 3 ];
  var gotLine = _.linePointDir.makeSingular( srcDim );
  var expected = _.linePointDir.tools.long.make( [ Infinity, Infinity, - Infinity, - Infinity ] );
  test.identical( gotLine, expected );
  test.true( gotLine !== srcDim );

  /* */

  test.case = 'srcDim vector';

  var srcDim = _.vectorAdapter.fromLong([ 0, 1, 2, 3 ]);
  var gotLine = _.linePointDir.makeSingular( srcDim );
  var expected = _.linePointDir.tools.long.make( [ Infinity, Infinity, - Infinity, - Infinity ] );
  test.identical( gotLine, expected );
  test.true( gotLine !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.makeSingular( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.linePointDir.makeSingular( 'line' ));
}

//

function zero( test )
{
  /* */

  test.case = 'srcLine undefined';

  var srcLine = undefined;
  var gotLine = _.linePointDir.zero( srcLine );
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0, 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.true( gotLine !== srcLine );

  /* */

  test.case = 'srcLine null';

  var srcLine = null;
  var gotLine = _.linePointDir.zero( srcLine );
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0, 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.true( gotLine !== srcLine );

  /* */

  test.case = 'srcLine 2';

  var srcLine = 2;
  var gotLine = _.linePointDir.zero( srcLine );
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.true( gotLine !== srcLine );

  /* */

  test.case = 'srcLine array';

  var srcLine = [ 0, 1, 2, 3 ];
  var gotLine = _.linePointDir.zero( srcLine );
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.true( gotLine === srcLine );

  /* */

  test.case = 'srcLine vector';

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1, 2, 3 ] );
  var gotLine = _.linePointDir.zero( srcLine );
  var expected = _.linePointDir.tools.vectorAdapter.fromLong( [ 0, 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.true( gotLine === srcLine );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.zero( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.linePointDir.zero( 'line' ));

}

//

function nil( test )
{
  /* */

  test.case = 'srcLine undefined';

  var srcLine = undefined;
  var gotLine = _.linePointDir.nil( srcLine );
  var expected = _.linePointDir.tools.long.make( [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ] );
  test.identical( gotLine, expected );
  test.true( gotLine !== srcLine );

  /* */

  test.case = 'srcLine null';

  var srcLine = null;
  var gotLine = _.linePointDir.nil( srcLine );
  var expected = _.linePointDir.tools.long.make( [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ] );
  test.identical( gotLine, expected );
  test.true( gotLine !== srcLine );

  /* */

  test.case = 'srcLine 2';

  var srcLine = 2;
  var gotLine = _.linePointDir.nil( srcLine );
  var expected = _.linePointDir.tools.long.make( [ Infinity, Infinity, - Infinity, - Infinity ] );
  test.identical( gotLine, expected );
  test.true( gotLine !== srcLine );

  /* */

  test.case = 'srcLine array';

  var srcLine = [ 0, 1, 2, 3 ];
  var gotLine = _.linePointDir.nil( srcLine );
  var expected = _.linePointDir.tools.long.make( [ Infinity, Infinity, - Infinity, - Infinity ] );
  test.identical( gotLine, expected );
  test.true( gotLine === srcLine );

  /* */

  test.case = 'srcLine vector';

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1, 2, 3 ] );
  var gotLine = _.linePointDir.nil( srcLine );
  var expected = _.linePointDir.tools.vectorAdapter.fromLong( [ Infinity, Infinity, - Infinity, - Infinity ] );
  test.identical( gotLine, expected );
  test.true( gotLine === srcLine );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.nil( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.linePointDir.nil( 'line' ));
}

//

function from( test )
{
  /* */

  test.case = 'Same instance returned - array';

  var srcLine = [ 0, 0, 2, 2 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 2, 2 ] );

  var gotLine = _.linePointDir.from( srcLine );
  test.identical( gotLine, expected );
  test.true( srcLine === gotLine );

  /* */

  test.case = 'Different instance returned - vector -> array';

  var srcLine = _.vectorAdapter.fromLong( [ 0, 0, 2, 2 ] );
  var expected = _.linePointDir.tools.vectorAdapter.fromLong( [ 0, 0, 2, 2 ] );

  var gotLine = _.linePointDir.from( srcLine );
  test.identical( gotLine, expected );
  test.true( srcLine === gotLine );

  /* */

  test.case = 'Same instance returned - empty array';

  var srcLine = [];
  var expected = _.linePointDir.tools.long.make( [] );

  var gotLine = _.linePointDir.from( srcLine );
  test.identical( gotLine, expected );
  test.true( srcLine === gotLine );

  /* */

  test.case = 'Different instance returned - null -> array';

  var srcLine = null;
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0, 0, 0, 0 ] );

  var gotLine = _.linePointDir.from( srcLine );
  test.identical( gotLine, expected );
  test.true( srcLine !== gotLine );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePointDir.from( ));
  test.shouldThrowErrorSync( () => _.linePointDir.from( [ 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.linePointDir.from( [ 0, 0, 0, 0 ], [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.linePointDir.from( 'line' ));
  test.shouldThrowErrorSync( () => _.linePointDir.from( NaN ));
  test.shouldThrowErrorSync( () => _.linePointDir.from( undefined ));
}

//

function adapterFrom( test )
{
  /* */

  test.case = 'Same instance returned - vector';

  var srcLine = [ 0, 0, 2, 2 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0, 0, 2, 2 ] );

  var gotLine = _.linePointDir.adapterFrom( srcLine );
  test.identical( gotLine, expected );
  test.true( srcLine !== gotLine );

  /* */

  test.case = 'Different instance returned - vector -> vector';

  var srcLine = _.linePointDir.tools.vectorAdapter.from( [ 0, 0, 2, 2 ] );
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0, 0, 2, 2 ] );

  var gotLine = _.linePointDir.adapterFrom( srcLine );
  test.identical( gotLine, expected );
  test.true( srcLine === gotLine );

  /* */

  test.case = 'Same instance returned - empty vector';

  var srcLine = [];
  var expected =  _.linePointDir.tools.vectorAdapter.from( [] );

  var gotLine = _.linePointDir.adapterFrom( srcLine );
  test.identical( gotLine, expected );
  test.true( srcLine !== gotLine );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePointDir.adapterFrom( ));
  test.shouldThrowErrorSync( () => _.linePointDir.adapterFrom( [ 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.linePointDir.adapterFrom( [ 0, 0, 0, 0 ], [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.linePointDir.adapterFrom( 'line' ));
  test.shouldThrowErrorSync( () => _.linePointDir.adapterFrom( NaN ));
  test.shouldThrowErrorSync( () => _.linePointDir.adapterFrom( null ));
  test.shouldThrowErrorSync( () => _.linePointDir.adapterFrom( undefined ));
}

//

function fromPoints( test )
{
  /* */

  test.case = 'Pair stay unchanged';

  var point1 = [ 0, 1, 2 ]
  var point2 = [ 0, 2, 4 ]
  var expected = _.linePointDir.tools.vectorAdapter.make( [ 0, 1, 2, 0, 1, 2 ] );

  var gotLine = _.linePointDir.fromPoints( point1, point2 );
  test.identical( gotLine, expected );

  var oldPoin1 = [ 0, 1, 2 ]
  var oldPoin2 = [ 0, 2, 4 ]
  test.identical( point1, oldPoin1 );
  test.identical( point2, oldPoin2 );

  /* */

  test.case = 'Line starts in origin';

  var point1 = [ 0, 0, 0 ]
  var point2 = [ 0, 1, 2 ]
  var expected = _.linePointDir.tools.vectorAdapter.make( [ 0, 0, 0, 0, 1, 2 ] );

  var gotLine = _.linePointDir.fromPoints( point1, point2 );
  test.identical( gotLine, expected );

  /* */

  test.case = 'Line is point';

  var point1 = [ 0, 1, 2 ]
  var point2 = [ 0, 1, 2 ]
  var expected = _.linePointDir.tools.vectorAdapter.make( [ 0, 1, 2, 0, 0, 0 ] );

  var gotLine = _.linePointDir.fromPoints( point1, point2 );
  test.identical( gotLine, expected );

  /* */

  test.case = 'Line of 1 dimension';

  var point1 = [ 3 ]
  var point2 = [ 4 ]
  var expected = _.linePointDir.tools.vectorAdapter.make( [ 3, 1 ] );

  var gotLine = _.linePointDir.fromPoints( point1, point2 );
  test.identical( gotLine, expected );

  /* */

  test.case = 'Line goes up in y and down in z';

  var point1 = [ 0, 1, 2 ]
  var point2 = [ 0, 3, 1 ]
  var expected = _.linePointDir.tools.vectorAdapter.make( [ 0, 1, 2, 0, 2, -1 ] );

  var gotLine = _.linePointDir.fromPoints( point1, point2 );
  test.identical( gotLine, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.fromPoints( ));
  test.shouldThrowErrorSync( () => _.linePointDir.fromPoints( null ));
  test.shouldThrowErrorSync( () => _.linePointDir.fromPoints( [ 2, 4 ], [ 3, 6, 2 ] ));
  test.shouldThrowErrorSync( () => _.linePointDir.fromPoints( [ [ 2, 4 ], [ 3, 6 ], [ 3, 6 ] ] ));
  test.shouldThrowErrorSync( () => _.linePointDir.fromPoints( undefined ));

}

//

function fromPoints2( test )
{
  /* */

  test.case = 'Pair stay unchanged';

  var points = [ 0, 1, 2, 0, 2, 4 ]
  var expected = _.linePointDir.tools.vectorAdapter.make( [ 0, 1, 2, 0, 1, 2 ] );

  var gotLine = _.linePointDir.fromPoints2( points );
  test.identical( gotLine, expected );

  var oldPoints = [ 0, 1, 2, 0, 2, 4 ]
  test.identical( points, oldPoints );

  /* */

  test.case = 'Line starts in origin';

  var points = [ 0, 0, 0, 0, 1, 2 ]
  var expected = _.linePointDir.tools.vectorAdapter.make( [ 0, 0, 0, 0, 1, 2 ] );

  var gotLine = _.linePointDir.fromPoints2( points );
  test.identical( gotLine, expected );

  /* */

  test.case = 'Line is point';

  var points = [ 0, 1, 2, 0, 1, 2 ]
  var expected = _.linePointDir.tools.vectorAdapter.make( [ 0, 1, 2, 0, 0, 0 ] );

  var gotLine = _.linePointDir.fromPoints2( points );
  test.identical( gotLine, expected );

  /* */

  test.case = 'Line goes up in y and down in z';

  var points = [ 0, 1, 2, 0, 3, 1 ]
  var expected = _.linePointDir.tools.vectorAdapter.make( [ 0, 1, 2, 0, 2, -1 ] );

  var gotLine = _.linePointDir.fromPoints2( points );
  test.identical( gotLine, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.fromPoints( ));
  test.shouldThrowErrorSync( () => _.linePointDir.fromPoints( null ));
  test.shouldThrowErrorSync( () => _.linePointDir.fromPoints( [ 3, 4 ] ));
  test.shouldThrowErrorSync( () => _.linePointDir.fromPoints( [ 2, 4 ], [ 3, 6, 2 ] ));
  test.shouldThrowErrorSync( () => _.linePointDir.fromPoints( [ [ 2, 4 ], [ 3, 6 ], [ 3, 6 ] ] ));
  test.shouldThrowErrorSync( () => _.linePointDir.fromPoints( undefined ));

}

//

function is( test )
{
  debugger;
  /* */

  test.case = 'array';

  test.true( _.linePointDir.is( [] ) );
  test.true( _.linePointDir.is([ 0, 0 ]) );
  test.true( _.linePointDir.is([ 1, 2, 3, 4 ]) );
  test.true( _.linePointDir.is([ 0, 0, 0, 0, 0, 0 ]) );

  /* */

  test.case = 'vector';

  test.true( _.linePointDir.is( _.vectorAdapter.fromLong([]) ) );
  test.true( _.linePointDir.is( _.vectorAdapter.fromLong([ 0, 0 ]) ) );
  test.true( _.linePointDir.is( _.vectorAdapter.fromLong([ 1, 2, 3, 4 ]) ) );
  test.true( _.linePointDir.is( _.vectorAdapter.fromLong([ 0, 0, 0, 0, 0, 0 ]) ) );

  /* */

  test.case = 'not line';

  test.true( !_.linePointDir.is([ 0 ]) );
  test.true( !_.linePointDir.is([ 0, 0, 0 ]) );

  test.true( !_.linePointDir.is( _.vectorAdapter.fromLong([ 0 ]) ) );
  test.true( !_.linePointDir.is( _.vectorAdapter.fromLong([ 0, 0, 0 ]) ) );

  test.true( !_.linePointDir.is( 'abc' ) );
  test.true( !_.linePointDir.is( { origin : [ 0, 0, 0 ], direction : [ 1, 1, 1 ] } ) );
  test.true( !_.linePointDir.is( function( a, b, c ){} ) );

  test.true( !_.linePointDir.is( null ) );
  test.true( !_.linePointDir.is( undefined ) );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.is( ));
  test.shouldThrowErrorSync( () => _.linePointDir.is( [ 0, 0 ], [ 1, 1 ] ));

}

//

function dimGet( test )
{
  /* */

  test.case = 'srcLine 1D - array';

  var srcLine = [ 0, 1 ];
  var gotDim = _.linePointDir.dimGet( srcLine );
  var expected = 1;
  test.identical( gotDim, expected );
  test.true( gotDim !== srcLine );

  /* */

  test.case = 'srcLine 1D - vector';

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1 ] );
  var gotDim = _.linePointDir.dimGet( srcLine );
  var expected = 1;
  test.identical( gotDim, expected );
  test.true( gotDim !== srcLine );

  /* */

  test.case = 'srcLine 2D - array';

  var srcLine = [ 0, 1, 2, 3 ];
  var gotDim = _.linePointDir.dimGet( srcLine );
  var expected = 2;
  test.identical( gotDim, expected );
  test.true( gotDim !== srcLine );

  /* */

  test.case = 'srcLine 2D - vector';

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1, 2, 3 ] );
  var gotDim = _.linePointDir.dimGet( srcLine );
  var expected = 2;
  test.identical( gotDim, expected );
  test.true( gotDim !== srcLine );

  /* */

  test.case = 'srcLine 3D - array';

  var srcLine = [ 0, 1, 2, 3, 4, 5 ];
  var gotDim = _.linePointDir.dimGet( srcLine );
  var expected = 3;
  test.identical( gotDim, expected );
  test.true( gotDim !== srcLine );

  /* */

  test.case = 'srcLine 3D - vector';

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1, 2, 3, 4, 5 ] );
  var gotDim = _.linePointDir.dimGet( srcLine );
  var expected = 3;
  test.identical( gotDim, expected );
  test.true( gotDim !== srcLine );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.dimGet( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.dimGet( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.dimGet( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.dimGet( 'line' ) );
  test.shouldThrowErrorSync( () => _.linePointDir.dimGet( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.dimGet( null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.dimGet( undefined ) );

}

//

function originGet( test )
{
  /* */

  test.case = 'Source line remains unchanged';

  var srcLine = [ 0, 0, 1, 1 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0, 0 ] );

  var gotOrigin = _.linePointDir.originGet( srcLine );
  test.identical( gotOrigin, expected );

  var oldSrcLine = [ 0, 0, 1, 1 ];
  test.equivalent( srcLine, oldSrcLine );

  /* */

  test.case = 'srcLine 1D - array';

  var srcLine = [ 0, 1 ];
  var gotOrigin = _.linePointDir.originGet( srcLine );
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0 ] );
  test.identical( gotOrigin, expected );
  test.true( gotOrigin !== srcLine );

  /* */

  test.case = 'srcLine 1D - vector';

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1 ] );
  var gotOrigin = _.linePointDir.originGet( srcLine );
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0 ] );
  test.identical( gotOrigin, expected );
  test.true( gotOrigin !== srcLine );

  /* */

  test.case = 'srcLine 2D - array';

  var srcLine = [ 0, 1, 2, 3 ];
  var gotOrigin = _.linePointDir.originGet( srcLine );
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0, 1 ] );
  test.identical( gotOrigin, expected );
  test.true( gotOrigin !== srcLine );

  /* */

  test.case = 'srcLine 2D - vector';

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1, 2, 3 ] );
  var gotOrigin = _.linePointDir.originGet( srcLine );
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0, 1 ] );
  test.identical( gotOrigin, expected );
  test.true( gotOrigin !== srcLine );

  /* */

  test.case = 'srcLine 3D - array';

  var srcLine = [ 0, 1, 2, 3, 4, 5 ];
  var gotOrigin = _.linePointDir.originGet( srcLine );
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0, 1, 2 ] );
  test.identical( gotOrigin, expected );
  test.true( gotOrigin !== srcLine );

  /* */

  test.case = 'srcLine 3D - vector';

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1, 2, 3, 4, 5 ] );
  var gotOrigin = _.linePointDir.originGet( srcLine );
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0, 1, 2 ] );
  test.identical( gotOrigin, expected );
  test.true( gotOrigin !== srcLine );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.originGet( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.originGet( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.originGet( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.originGet( 'line' ) );
  test.shouldThrowErrorSync( () => _.linePointDir.originGet( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.originGet( null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.originGet( undefined ) );

}

//

function directionGet( test )
{
  /* */

  test.case = 'Source line remains unchanged';

  var srcLine = [ 0, 0, 1, 1 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 1, 1 ] );

  var gotDirection = _.linePointDir.directionGet( srcLine );
  test.identical( gotDirection, expected );

  var oldSrcLine = [ 0, 0, 1, 1 ];
  test.equivalent( srcLine, oldSrcLine );

  /* */

  test.case = 'srcLine 1D - array';

  var srcLine = [ 0, 1 ];
  var gotDirection = _.linePointDir.directionGet( srcLine );
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 1 ] );
  test.identical( gotDirection, expected );
  test.true( gotDirection !== srcLine );

  /* */

  test.case = 'srcLine 1D - vector';

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1 ] );
  var gotDirection = _.linePointDir.directionGet( srcLine );
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 1 ] );
  test.identical( gotDirection, expected );
  test.true( gotDirection !== srcLine );

  /* */

  test.case = 'srcLine 2D - array';

  var srcLine = [ 0, 1, 2, 3 ];
  var gotDirection = _.linePointDir.directionGet( srcLine );
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 2, 3 ] );
  test.identical( gotDirection, expected );
  test.true( gotDirection !== srcLine );

  /* */

  test.case = 'srcLine 2D - vector';

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1, 2, 3 ] );
  var gotDirection = _.linePointDir.directionGet( srcLine );
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 2, 3 ] );
  test.identical( gotDirection, expected );
  test.true( gotDirection !== srcLine );

  /* */

  test.case = 'srcLine 3D - array';

  var srcLine = [ 0, 1, 2, 3, 4, 5 ];
  var gotDirection = _.linePointDir.directionGet( srcLine );
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 3, 4, 5 ] );
  test.identical( gotDirection, expected );
  test.true( gotDirection !== srcLine );

  /* */

  test.case = 'srcLine 3D - vector';

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1, 2, 3, 4, 5 ] );
  var gotDirection = _.linePointDir.directionGet( srcLine );
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 3, 4, 5 ] );
  test.identical( gotDirection, expected );
  test.true( gotDirection !== srcLine );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.directionGet( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.directionGet( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.directionGet( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.directionGet( 'line' ) );
  test.shouldThrowErrorSync( () => _.linePointDir.directionGet( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.directionGet( null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.directionGet( undefined ) );

}

//

function lineAt( test )
{
  /* */

  test.case = 'Source line and factor remain unchanged';

  var srcLine = [ 0, 0, 1, 1 ];
  var factor = 1;
  var expected = _.linePointDir.tools.long.make( [ 1, 1 ] );

  var gotPoint = _.linePointDir.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  var oldSrcLine = [ 0, 0, 1, 1 ];
  test.equivalent( srcLine, oldSrcLine );

  var oldFactor = 1;
  test.equivalent( factor, oldFactor );

  /* */

  test.case = 'Factor = null, return origin';

  var srcLine = [ 0, 0, 1, 1 ];
  var factor = 0;
  var expected = _.linePointDir.tools.long.make( [ 0, 0 ] );

  var gotPoint = _.linePointDir.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Factor = 0, return origin';

  var srcLine = [ 0, 0, 1, 1 ];
  var factor = 0;
  var expected = _.linePointDir.tools.long.make( [ 0, 0 ] );

  var gotPoint = _.linePointDir.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Factor = 1, return origin + direction';

  var srcLine = [ 0, 1, 1, 1 ];
  var factor = 1;
  var expected = _.linePointDir.tools.long.make( [ 1, 2 ] );

  var gotPoint = _.linePointDir.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  /* */

  test.case = '3D line';

  var srcLine = [ 0, 1, 2, 1, 1, 1 ];
  var factor = 1;
  var expected = _.linePointDir.tools.long.make( [ 1, 2, 3 ] );

  var gotPoint = _.linePointDir.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'factor smaller than 1';

  var srcLine = [ 0, 1, 2, 2, 2, 2 ];
  var factor = 0.5;
  var expected = _.linePointDir.tools.long.make( [ 1, 2, 3 ] );

  var gotPoint = _.linePointDir.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'factor bigger than one';

  var srcLine = [ 0, 1, 2, 1, 1, 1 ];
  var factor = 5;
  var expected = _.linePointDir.tools.long.make( [ 5, 6, 7 ] );

  var gotPoint = _.linePointDir.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Negative factor';

  var srcLine = [ 0, 1, 2, 1, 1, 1 ];
  var factor = - 5;
  var expected = _.linePointDir.tools.long.make( [ - 5, - 4, - 3 ] );

  var gotPoint = _.linePointDir.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.lineAt( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineAt( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineAt( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineAt( 'line', 1 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineAt( [ 0, 0 ], 'factor') );
  test.shouldThrowErrorSync( () => _.linePointDir.lineAt( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineAt( null, 1 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineAt( undefined, 1 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineAt( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineAt( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function getFactor( test )
{

  /* */

  test.case = 'Line and Point remain unchanged';

  var line = [  - 1, - 1 , 1, 1 ];
  var point = [ 0, 0 ];
  var expected = 1;

  var gotFactor = _.linePointDir.getFactor( line, point );
  test.identical( gotFactor, expected );

  var oldLine = [  - 1, - 1 , 1, 1 ];
  test.identical( line, oldLine );

  var oldPoint = [ 0, 0 ];
  test.identical( point, oldPoint );

  /* */

  test.case = 'Null line contains empty point';

  var line = null;
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotFactor = _.linePointDir.getFactor( line, point );
  test.identical( gotFactor, expected );

  /* */

  test.case = 'Point line contains Point';

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotFactor = _.linePointDir.getFactor( line, point );
  test.identical( gotFactor, expected );

  /* */

  test.case = 'Factor smaller than one';

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = 0.5;

  var gotFactor = _.linePointDir.getFactor( line, point );
  test.identical( gotFactor, expected );

  /* */

  test.case = 'Factor bigger than one';

  var line = [ 0, 0, 0, 1, 1, 1 ];
  var point = [  6, 6, 6 ];
  var expected = 6;

  var gotFactor = _.linePointDir.getFactor( line, point );
  test.identical( gotFactor, expected );

  /* */

  test.case = 'Negative factor';

  var line = [ 0, 0, 0, 1, 1, 1 ];
  var point = [  - 6, - 6, - 6 ];
  var expected = - 6;

  var gotFactor = _.linePointDir.getFactor( line, point );
  test.identical( gotFactor, expected );


  /* */

  test.case = 'Direction with different values';

  var line = [ 0, 0, 0, 1, 2, 3 ];
  var point = [  6, 12, 18 ];
  var expected = 6;

  var gotFactor = _.linePointDir.getFactor( line, point );
  test.identical( gotFactor, expected );

  /* */

  test.case = 'Direction with different values ( one of them 0 )';

  var line = [ 0, 0, 0, 1, 2, 0 ];
  var point = [  6, 12, 0 ];
  var expected = 6;

  var gotFactor = _.linePointDir.getFactor( line, point );
  test.identical( gotFactor, expected );

  /* */

  test.case = 'Direction with different values ( one of them 0 )';

  var line = [ 0, 0, 0, 0, 2, 3 ];
  var point = [  0, 12, 18 ];
  var expected = 6;

  var gotFactor = _.linePointDir.getFactor( line, point );
  test.identical( gotFactor, expected );

  /* */

  test.case = 'Direction with different values ( one of them 0 )';

  var line = [ 0, 0, 0, 1, 2, 0 ];
  var point = [  6, 12, 18];
  var expected = false;

  var gotFactor = _.linePointDir.getFactor( line, point );
  test.identical( gotFactor, expected );

  /* */

  test.case = 'Line under point';

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ 1, 1, 3 ];
  var expected = false;

  var gotFactor = _.linePointDir.getFactor( line, point );
  test.identical( gotFactor, expected );

  /* */

  test.case = 'Line ( normalized to 1 )';

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var point = [ 0.500, 0.500, 0.000 ];
  var expected = 1/ Math.sqrt( 2 );

  var gotFactor = _.linePointDir.getFactor( line, point );
  test.equivalent( gotFactor, expected );

  /* */

  test.case = 'Line of four dimensions';

  var line = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0, 0 ];
  var expected = 1;

  var gotFactor = _.linePointDir.getFactor( line, point );
  test.identical( gotFactor, expected );

  /* */

  test.case = 'Line of 7 dimensions';

  var line = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 1, 1, 1, 1, 1, 1, 1 ];
  var point = [ - 1, -1, -1, -1, -1, -1, -1 ];
  var expected = 1;

  var gotFactor = _.linePointDir.getFactor( line, point );
  test.identical( gotFactor, expected );

  /* */

  test.case = 'Line of 1 dimension contains point';

  var line = [ 0, 2 ];
  var point = [ 1 ];
  var expected = 0.5;

  var gotFactor = _.linePointDir.getFactor( line, point );
  test.identical( gotFactor, expected );

  /* */

  test.case = 'Line of 1 dimension always contains point ';

  var line = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = - 1.5;

  var gotFactor = _.linePointDir.getFactor( line, point );
  test.identical( gotFactor, expected );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePointDir.getFactor( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.getFactor( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.getFactor( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.getFactor( [ 1, 1, 2, 2 ], 'factor') );
  test.shouldThrowErrorSync( () => _.linePointDir.getFactor( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.getFactor( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.getFactor( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.getFactor( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.getFactor( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.getFactor( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function lineParallel3D( test )
{
  /* */

  test.case = 'Source lines and accuracySqr remain unchanged';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 0, 0, 0, 2, 2, 2 ];
  var accuracySqr = 1E-10;
  var expected = true;

  var isParallel = _.linePointDir.lineParallel3D( src1Line, src2Line, accuracySqr );
  test.identical( isParallel, expected );

  var oldSrc1Line = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( src1Line, oldSrc1Line );

  var oldSrc2Line = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( src2Line, oldSrc2Line );

  var oldAccuracySqr = 1E-10;
  test.equivalent( accuracySqr, oldAccuracySqr );

  /* */

  test.case = 'Lines are the same';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var isParallel = _.linePointDir.lineParallel3D( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are parallel ( different origin - same direction )';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 1, 1, 1 ];
  var expected = true;

  var isParallel = _.linePointDir.lineParallel3D( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are parallel ( different origin - different direction )';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 7, 7, 7 ];
  var expected = true;

  var isParallel = _.linePointDir.lineParallel3D( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are parallel ( different origin - opposite direction )';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, - 7, - 7, - 7 ];
  var expected = true;

  var isParallel = _.linePointDir.lineParallel3D( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are parallel ( src1Line is a point )';

  var src1Line = [ 3, 7, 1, 0, 0, 0 ];
  var src2Line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var isParallel = _.linePointDir.lineParallel3D( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are parallel ( src2Line is a point )';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 0, 0, 0 ];
  var expected = true;

  var isParallel = _.linePointDir.lineParallel3D( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are not parallel ( same origin - different direction )';

  var src1Line = [ 3, 7, 1, 1, - 1, 1 ];
  var src2Line = [ 3, 7, 1, 7, 7, 7 ];
  var expected = false;

  var isParallel = _.linePointDir.lineParallel3D( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are perpendicular';

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 1, 0, 0, 1 ];
  var expected = false;

  var isParallel = _.linePointDir.lineParallel3D( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are parallel to x';

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 1, 1, 0, 0 ];
  var expected = true;

  var isParallel = _.linePointDir.lineParallel3D( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are parallel but in a opposite direction';

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 1, - 1, 0, 0 ];
  var expected = true;

  var isParallel = _.linePointDir.lineParallel3D( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.lineParallel3D( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineParallel3D( [ 0, 0, 0 ] ) );
   test.shouldThrowErrorSync( () => _.linePointDir.lineParallel3D( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineParallel3D( [ 0, 0 ], 'factor') );
  test.shouldThrowErrorSync( () => _.linePointDir.lineParallel3D( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineParallel3D( null, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineParallel3D( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineParallel3D( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineParallel3D( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineParallel3D( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineParallel3D( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}


//

function lineParallel( test )
{
  /* */

  test.case = 'Source lines and accuracySqr remain unchanged';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 0, 0, 0, 2, 2, 2 ];
  var accuracySqr = 1E-10;
  var expected = true;

  var isParallel = _.linePointDir.lineParallel( src1Line, src2Line, accuracySqr );
  test.identical( isParallel, expected );

  var oldSrc1Line = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( src1Line, oldSrc1Line );

  var oldSrc2Line = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( src2Line, oldSrc2Line );

  var oldAccuracySqr = 1E-10;
  test.equivalent( accuracySqr, oldAccuracySqr );

  /* */

  test.case = 'Lines are the same';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var isParallel = _.linePointDir.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are parallel ( different origin - same direction )';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 1, 1, 1 ];
  var expected = true;

  var isParallel = _.linePointDir.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are parallel ( different origin - different direction )';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 7, 7, 7 ];
  var expected = true;

  var isParallel = _.linePointDir.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are parallel ( different origin - opposite direction )';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, - 7, - 7, - 7 ];
  var expected = true;

  var isParallel = _.linePointDir.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are parallel ( src1Line is a point )';

  var src1Line = [ 3, 7, 1, 0, 0, 0 ];
  var src2Line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var isParallel = _.linePointDir.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are parallel ( src2Line is a point )';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 0, 0, 0 ];
  var expected = true;

  var isParallel = _.linePointDir.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are parallel ( src2Line is a point - 4D )';

  var src1Line = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 1, 0, 0, 0, 0 ];
  var expected = true;

  var isParallel = _.linePointDir.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are not parallel ( same origin - different direction )';

  var src1Line = [ 3, 7, 1, 1, - 1, 1 ];
  var src2Line = [ 3, 7, 1, 7, 7, 7 ];
  var expected = false;

  var isParallel = _.linePointDir.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are perpendicular';

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 1, 0, 0, 1 ];
  var expected = false;

  var isParallel = _.linePointDir.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are parallel to x';

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 1, 1, 0, 0 ];
  var expected = true;

  var isParallel = _.linePointDir.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are parallel but in a opposite direction';

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 1, - 1, 0, 0 ];
  var expected = true;

  var isParallel = _.linePointDir.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are parallel 2D';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 7, - 2, - 2 ];
  var expected = true;

  var isParallel = _.linePointDir.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are not parallel 2D';

  var src1Line = [ 3, 7, 1, - 1 ];
  var src2Line = [ 3, 7, 7, 7 ];
  var expected = false;

  var isParallel = _.linePointDir.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are parallel 4D';

  var src1Line = [ 0, 0, 1, 1, 0, 1, 2, 3 ];
  var src2Line = [ 3, 7, - 2, - 2, 0, 2, 4, 6 ];
  var expected = true;

  var isParallel = _.linePointDir.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are not parallel 4D';

  var src1Line = [ 3, 7, 1, - 1, 3, 7, 1, - 1 ];
  var src2Line = [ 3, 7, 7, 7, 3, 7, 7, 7 ];
  var expected = false;

  var isParallel = _.linePointDir.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are parallel 6D';

  var src1Line = [ 0, 0, 1, 1, 1, 1, 0, 1, 2, 3, 4, 5 ];
  var src2Line = [ 3, 7, - 2, - 2, 0, 0, 0, 2, 4, 6, 8, 10 ];
  var expected = true;

  var isParallel = _.linePointDir.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  test.case = 'Lines are not parallel 6D';

  var src1Line = [ 0, 0, 1, 1, 1, 1, 0, 1, 2, 3, 4, 5 ];
  var src2Line = [ 3, 7, - 2, - 2, 0, 0, 0, 2, 8, 6, 8, 10 ];
  var expected = false;

  var isParallel = _.linePointDir.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.lineParallel( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineParallel( [ 0, 0, 0 ] ) );
   test.shouldThrowErrorSync( () => _.linePointDir.lineParallel( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineParallel( [ 0, 0 ], 'factor') );
  test.shouldThrowErrorSync( () => _.linePointDir.lineParallel( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineParallel( null, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineParallel( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineParallel( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineParallel( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineParallel( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineParallel( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function lineIntersectionFactors( test )
{
  /* */

  test.case = 'Source lines remain unchanged';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 0, 0, 2, 2 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0, 0 ] );

  var isIntersectionFactors = _.linePointDir.lineIntersectionFactors( src1Line, src2Line );
  test.identical( isIntersectionFactors, expected );

  var oldSrc1Line = [ 0, 0, 1, 1 ];
  test.equivalent( src1Line, oldSrc1Line );

  var oldSrc2Line = [ 0, 0, 2, 2 ];
  test.equivalent( src2Line, oldSrc2Line );

  /* */

  test.case = 'Lines are the same';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 0, 0, 1, 1 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0, 0 ] );

  var isIntersectionFactors = _.linePointDir.lineIntersectionFactors( src1Line, src2Line );
  test.identical( isIntersectionFactors, expected );

  /* */

  test.case = 'Lines are parallel ( different origin - same direction )';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 7, 1, 1 ];
  var expected = 0;

  var isIntersectionFactors = _.linePointDir.lineIntersectionFactors( src1Line, src2Line );
  test.identical( isIntersectionFactors, expected );

  /* */

  test.case = 'Lines are parallel ( different origin - different direction )';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 7, 7, 7 ];
  var expected = 0;

  var isIntersectionFactors = _.linePointDir.lineIntersectionFactors( src1Line, src2Line );
  test.identical( isIntersectionFactors, expected );

  /* */

  test.case = 'Lines intersect with negative factor';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 0, 2, -1 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 1, -1 ] );

  var isIntersectionFactors = _.linePointDir.lineIntersectionFactors( src1Line, src2Line );
  test.equivalent( isIntersectionFactors, expected );

  /* */

  test.case = 'Lines intersect in their origin';

  var src1Line = [ 3, 7, 1, 0 ];
  var src2Line = [ 3, 7, 0, 1 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0, 0 ] );

  var isIntersectionFactors = _.linePointDir.lineIntersectionFactors( src1Line, src2Line );
  test.equivalent( isIntersectionFactors, expected );

  /* */

  test.case = 'Lines intersect ';

  var src1Line = [ 0, 0, 1, 0 ];
  var src2Line = [ -2, -6, 1, 2 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 1, 3 ] );

  var isIntersectionFactors = _.linePointDir.lineIntersectionFactors( src1Line, src2Line );
  test.equivalent( isIntersectionFactors, expected );

  /* */

  test.case = 'Lines are perpendicular ';

  var src1Line = [ -3, 0, 1, 0 ];
  var src2Line = [ 0, -2, 0, 1 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 3, 2 ] );

  var isIntersectionFactors = _.linePointDir.lineIntersectionFactors( src1Line, src2Line );
  test.equivalent( isIntersectionFactors, expected );

  /* */

  test.case = 'Lines 3D intersection';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 3, 3, 0, 1, 4 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 3, 0 ] );

  var isIntersectionFactors = _.linePointDir.lineIntersectionFactors( src1Line, src2Line );
  test.equivalent( isIntersectionFactors, expected );

  /* */

  test.case = 'Lines 3D intersection negative factors';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ - 3, - 3, - 3, 0, 1, 4 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ - 3, 0 ] );

  var isIntersectionFactors = _.linePointDir.lineIntersectionFactors( src1Line, src2Line );
  test.equivalent( isIntersectionFactors, expected );

  /* */

  test.case = 'Lines 3D intersection 3rd coordinate 0';

  var src1Line = [ 5, 5, 7, 0, 0, 1 ];
  var src2Line = [ 0, 0, 0, 4, 4, 4 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ -2, 1.25 ] );

  var isIntersectionFactors = _.linePointDir.lineIntersectionFactors( src1Line, src2Line );
  test.equivalent( isIntersectionFactors, expected );


  /* */

  test.case = 'Lines 3D intersection 3rd coordinate 0';

  var src1Line = [ 0, 0, 0, 1, 1, 0 ];
  var src2Line = [ 3, 3, 0, 0, 1, 0 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 3, 0 ] );

  var isIntersectionFactors = _.linePointDir.lineIntersectionFactors( src1Line, src2Line );
  test.equivalent( isIntersectionFactors, expected );

  /* */

  test.case = 'Lines 3D no intersection';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 3, 5, 0, 1, 4 ];
  var expected = 0;

  var isIntersectionFactors = _.linePointDir.lineIntersectionFactors( src1Line, src2Line );
  test.identical( isIntersectionFactors, expected );

  /* */

  test.case = 'Lines 4D intersection';

  var src1Line = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Line = [ 3, 3, 3, 3, 0, 2, 1, 4 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 3, 0 ] );

  var isIntersectionFactors = _.linePointDir.lineIntersectionFactors( src1Line, src2Line );
  test.equivalent( isIntersectionFactors, expected );

  /* */

  test.case = 'Lines 4D no intersection';

  var src1Line = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Line = [ 3, 3, 5, 3, 0, 0, 1, 4 ];
  var expected = 0;

  var isIntersectionFactors = _.linePointDir.lineIntersectionFactors( src1Line, src2Line );
  test.identical( isIntersectionFactors, expected );

  /* */

  test.case = 'Lines 4D no intersection out of 3D intersection';

  var src1Line = [ 0, 0, 0, 1, 1, 1, 1, -1 ];
  var src2Line = [ 3, 3, 3, 2, 0, 1, 4, 3 ];
  var expected = 0;

  var isIntersectionFactors = _.linePointDir.lineIntersectionFactors( src1Line, src2Line );
  test.identical( isIntersectionFactors, expected );

  /* */

  test.case = 'Lines 8D intersection';

  var src1Line = [ 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1  ];
  var src2Line = [ 3, 3, 3, 3, 3, 3, 3, 3, 0, 2, 1, 4, 0, 2, 1, 4 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 3, 0 ] );

  var isIntersectionFactors = _.linePointDir.lineIntersectionFactors( src1Line, src2Line );
  test.equivalent( isIntersectionFactors, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionFactors( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionFactors( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionFactors( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionFactors( [ 1, 1, 2, 2 ], 'line') );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionFactors( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionFactors( null, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionFactors( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionFactors( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionFactors( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionFactors( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionFactors( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function lineIntersectionPoints( test )
{
  /* */

  test.case = 'Source lines remain unchanged';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 0, 0, 2, 2 ];
  var expected = _.linePointDir.tools.long.make( [ [ 0, 0 ], [ 0, 0 ] ] );

  var isIntersectionPoints = _.linePointDir.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  var oldSrc1Line = [ 0, 0, 1, 1 ];
  test.equivalent( src1Line, oldSrc1Line );

  var oldSrc2Line = [ 0, 0, 2, 2 ];
  test.equivalent( src2Line, oldSrc2Line );

  /* */

  test.case = 'Lines are the same';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 0, 0, 1, 1 ];
  var expected = _.linePointDir.tools.long.make( [ [ 0, 0 ], [ 0, 0 ] ] );

  var isIntersectionPoints = _.linePointDir.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  /* */

  test.case = 'Lines are parallel ( different origin - same direction )';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 7, 1, 1 ];
  var expected = 0;

  var isIntersectionPoints = _.linePointDir.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  /* */

  test.case = 'Lines are parallel ( different origin - different direction )';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 7, 7, 7 ];
  var expected = 0;

  var isIntersectionPoints = _.linePointDir.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  /* */

  test.case = 'Lines intersect with negative factor';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 0, 2, -1 ];
  var expected = _.linePointDir.tools.long.make( [ [ 1, 1 ], [ 1, 1 ] ] );

  var isIntersectionPoints = _.linePointDir.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  /* */

  test.case = 'Lines intersect in their origin';

  var src1Line = [ 3, 7, 1, 0 ];
  var src2Line = [ 3, 7, 0, 1 ];
  var expected = _.linePointDir.tools.long.make( [ [ 3, 7 ], [ 3, 7 ] ] );

  var isIntersectionPoints = _.linePointDir.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  /* */

  test.case = 'Lines intersect ';

  var src1Line = [ 0, 0, 1, 0 ];
  var src2Line = [ -2, -6, 1, 2 ];
  var expected = _.linePointDir.tools.long.make( [ [ 1, 0 ], [ 1, 0 ] ] );

  var isIntersectionPoints = _.linePointDir.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  /* */

  test.case = 'Lines are perpendicular ';

  var src1Line = [ -3, 0, 1, 0 ];
  var src2Line = [ 0, -2, 0, 1 ];
  var expected = _.linePointDir.tools.long.make( [ [ 0, 0 ], [ 0, 0 ] ] );

  var isIntersectionPoints = _.linePointDir.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  /* */

  test.case = 'Lines don´t intersect 3D';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 0, 1, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoints = _.linePointDir.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  /* */

  test.case = 'Lines intersect 3D';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 3, 1, 4 ];
  var expected = _.linePointDir.tools.long.make( [ [ 9, 9, 9 ], [ 9, 9, 9 ] ] );

  var isIntersectionPoints = _.linePointDir.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  /* */

  test.case = 'Lines 3D intersection 3rd coordinate 0';

  var src1Line = [ 0, 0, 0, 1, 1, 0 ];
  var src2Line = [ 3, 3, 0, 0, 1, 0 ];
  var expected = _.linePointDir.tools.long.make( [ [ 3, 3, 0 ], [ 3, 3, 0 ] ] );

  var isIntersectionPoints = _.linePointDir.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  /* */

  test.case = 'Lines don´t intersect 4D';

  var src1Line = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Line = [ 3, 0, 1, 4, 2, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoints = _.linePointDir.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  /* */

  test.case = 'Lines intersect 4D';

  var src1Line = [ 0, 0, 0, 1, 1, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 4, 3, 1, 4, 3 ];
  var expected = _.linePointDir.tools.long.make( [ [ 9, 9, 9, 10 ], [ 9, 9, 9, 10 ] ] );

  var isIntersectionPoints = _.linePointDir.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPoints( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPoints( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPoints( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPoints( [ 1, 1, 2, 2 ], 'line') );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPoints( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPoints( null, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPoints( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPoints( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPoints( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPoints( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPoints( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function lineIntersectionPoint( test )
{
  /* */

  test.case = 'Source lines remain unchanged';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 0, 0, 2, 2 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0 ] );

  var isIntersectionPoint = _.linePointDir.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  var oldSrc1Line = [ 0, 0, 1, 1 ];
  test.equivalent( src1Line, oldSrc1Line );

  var oldSrc2Line = [ 0, 0, 2, 2 ];
  test.equivalent( src2Line, oldSrc2Line );

  /* */

  test.case = 'Lines are the same';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 0, 0, 1, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0 ] );

  var isIntersectionPoint = _.linePointDir.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  test.case = 'Lines are parallel ( different origin - same direction )';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 7, 1, 1 ];
  var expected = 0;

  var isIntersectionPoint = _.linePointDir.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  test.case = 'Lines are parallel ( different origin - different direction )';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 7, 7, 7 ];
  var expected = 0;

  var isIntersectionPoint = _.linePointDir.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  test.case = 'Lines intersect with negative factor';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 0, 2, -1 ];
  var expected = _.linePointDir.tools.long.make( [ 1, 1 ] );

  var isIntersectionPoint = _.linePointDir.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  test.case = 'Lines intersect in their origin';

  var src1Line = [ 3, 7, 1, 0 ];
  var src2Line = [ 3, 7, 0, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 7 ] );

  var isIntersectionPoint = _.linePointDir.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  test.case = 'Lines intersect ';

  var src1Line = [ 0, 0, 1, 0 ];
  var src2Line = [ -2, -6, 1, 2 ];
  var expected = _.linePointDir.tools.long.make( [ 1, 0 ] );

  var isIntersectionPoint = _.linePointDir.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  test.case = 'Lines are perpendicular ';

  var src1Line = [ -3, 0, 1, 0 ];
  var src2Line = [ 0, -2, 0, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0 ] );

  var isIntersectionPoint = _.linePointDir.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  test.case = 'Lines don´t intersect 3D';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 0, 1, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoint = _.linePointDir.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  test.case = 'Lines intersect 3D';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 3, 1, 4 ];
  var expected = _.linePointDir.tools.long.make( [ 9, 9, 9 ] );

  var isIntersectionPoint = _.linePointDir.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  test.case = 'Lines don´t intersect 4D';

  var src1Line = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Line = [ 3, 0, 1, 4, 2, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoint = _.linePointDir.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  test.case = 'Lines intersect 4D';

  var src1Line = [ 0, 0, 0, 1, 1, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 4, 3, 1, 4, 3 ];
  var expected = _.linePointDir.tools.long.make( [ 9, 9, 9, 10 ] );

  var isIntersectionPoint = _.linePointDir.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPoint( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPoint( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPoint( [ 1, 1, 2, 2 ], 'line') );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPoint( null, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPoint( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPoint( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPoint( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPoint( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function lineIntersectionPointAccurate( test )
{
  /* */

  test.case = 'Source lines remain unchanged';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 0, 0, 2, 2 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0 ] );

  var isIntersectionPoint = _.linePointDir.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  var oldSrc1Line = [ 0, 0, 1, 1 ];
  test.equivalent( src1Line, oldSrc1Line );

  var oldSrc2Line = [ 0, 0, 2, 2 ];
  test.equivalent( src2Line, oldSrc2Line );

  /* */

  test.case = 'Lines are the same';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 0, 0, 1, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0 ] );

  var isIntersectionPoint = _.linePointDir.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  test.case = 'Lines are parallel ( different origin - same direction )';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 7, 1, 1 ];
  var expected = 0;

  var isIntersectionPoint = _.linePointDir.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  test.case = 'Lines are parallel ( different origin - different direction )';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 7, 7, 7 ];
  var expected = 0;

  var isIntersectionPoint = _.linePointDir.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  test.case = 'Lines intersect with negative factor';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 0, 2, -1 ];
  var expected = _.linePointDir.tools.long.make( [ 1, 1 ] );

  var isIntersectionPoint = _.linePointDir.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  test.case = 'Lines intersect in their origin';

  var src1Line = [ 3, 7, 1, 0 ];
  var src2Line = [ 3, 7, 0, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 7 ] );

  var isIntersectionPoint = _.linePointDir.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  test.case = 'Lines intersect ';

  var src1Line = [ 0, 0, 1, 0 ];
  var src2Line = [ -2, -6, 1, 2 ];
  var expected = _.linePointDir.tools.long.make( [ 1, 0 ] );

  var isIntersectionPoint = _.linePointDir.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  test.case = 'Lines are perpendicular ';

  var src1Line = [ -3, 0, 1, 0 ];
  var src2Line = [ 0, -2, 0, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0 ] );

  var isIntersectionPoint = _.linePointDir.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  test.case = 'Lines don´t intersect 3D';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 0, 1, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoint = _.linePointDir.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  test.case = 'Lines intersect 3D';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 3, 1, 4 ];
  var expected = _.linePointDir.tools.long.make( [ 9, 9, 9 ] );

  var isIntersectionPoint = _.linePointDir.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  test.case = 'Lines don´t intersect 4D';

  var src1Line = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Line = [ 3, 0, 1, 4, 2, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoint = _.linePointDir.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  test.case = 'Lines intersect 4D';

  var src1Line = [ 0, 0, 0, 1, 1, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 4, 3, 1, 4, 3 ];
  var expected = _.linePointDir.tools.long.make( [ 9, 9, 9, 10 ] );

  var isIntersectionPoint = _.linePointDir.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPointAccurate( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPointAccurate( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPointAccurate( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPointAccurate( [ 1, 1, 2, 2 ], 'line') );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPointAccurate( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPointAccurate( null, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPointAccurate( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPointAccurate( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPointAccurate( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPointAccurate( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersectionPointAccurate( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function pointContains( test )
{

  /* */

  test.case = 'Line and Point remain unchanged';

  var line = [  - 1, - 1 , 1, 1 ];
  var point = [ 0, 0 ];
  var expected = true;

  var gotBool = _.linePointDir.pointContains( line, point );
  test.identical( gotBool, expected );

  var oldLine = [  - 1, - 1 , 1, 1 ];
  test.identical( line, oldLine );

  var oldPoint = [ 0, 0 ];
  test.identical( point, oldPoint );

  /* */

  test.case = 'Null line contains empty point';

  var line = null;
  var point = [ 0, 0, 0 ];
  var expected = true;

  var gotBool = _.linePointDir.pointContains( line, point );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Point line contains Point';

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = true;

  var gotBool = _.linePointDir.pointContains( line, point );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line contains point';

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = true;

  var gotBool = _.linePointDir.pointContains( line, point );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line over point';

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, 1, 4 ];
  var expected = false;

  var gotBool = _.linePointDir.pointContains( line, point );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Point closer to origin';

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, -2 , 0 ];
  var expected = false;

  var gotBool = _.linePointDir.pointContains( line, point );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Point contained with negative factor';

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, 0, - 2 ];
  var expected = true;

  var gotBool = _.linePointDir.pointContains( line, point );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Point not contained with negative factor';

  var line = [ 0, 0, 0, 1, 1, 1 ];
  var point = [ 0, 0, - 1 ];
  var expected = false;

  var gotBool = _.linePointDir.pointContains( line, point );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) contains point';

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var point = [ 0.500, 0.500, 0.000 ];
  var expected = true;

  var gotBool = _.linePointDir.pointContains( line, point );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) doesn´t contain point';

  var line = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, - 0.303 ];
  var expected = false;

  var gotBool = _.linePointDir.pointContains( line, point );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line of four dimensions contains point';

  var line = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0 , 0 ];
  var expected = true;

  var gotBool = _.linePointDir.pointContains( line, point );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line of four dimensions doesn´t contain point';

  var line = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, - 2, 0 , 2 ];
  var expected = false;

  var gotBool = _.linePointDir.pointContains( line, point );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line of 7Linemensions contains point';

  var line = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 1, 1, 1, 1, 1, 1, 1 ];
  var point = [ - 1, -1, -1, -1, -1, -1, -1 ];
  var expected = true;

  var gotBool = _.linePointDir.pointContains( line, point );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line of 7 dimensions doesn´t contain point';

  var line = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 1, 1, 1, 1, 1, 1, 1 ];
  var point = [ 0, 4, 3.5, 0, 5, 2, 2 ];
  var expected = false;

  var gotBool = _.linePointDir.pointContains( line, point );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line of 1 dimension contains point';

  var line = [ 0, 2 ];
  var point = [ 1 ];
  var expected = true;

  var gotBool = _.linePointDir.pointContains( line, point );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line of 1 dimension contains point with negative factor';

  var line = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = true;

  var gotBool = _.linePointDir.pointContains( line, point );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Negative factor 2 dimensions';

  var line = [ 0, 0, 1, 1 ];
  var point = [ - 3, -3 ];
  var expected = true;

  var gotBool = _.linePointDir.pointContains( line, point );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Negative factor 3 dimensions';

  var line = [ 0, 0, 0, 1, 1, 2 ];
  var point = [ - 3, -3, -6 ];
  var expected = true;

  var gotBool = _.linePointDir.pointContains( line, point );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePointDir.pointContains( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointContains( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointContains( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointContains( [ 1, 1, 2, 2 ], 'line') );
  test.shouldThrowErrorSync( () => _.linePointDir.pointContains( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointContains( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointContains( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointContains( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointContains( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointContains( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function pointDistance( test )
{

  /* */

  test.case = 'Line and Point remain unchanged';

  var line = [  - 1, - 1 , 1, 1 ];
  var point = [ 0, 0 ];
  var expected = 0;

  var gotDistance = _.linePointDir.pointDistance( line, point );
  test.identical( gotDistance, expected );

  var oldLine = [  - 1, - 1 , 1, 1 ];
  test.identical( line, oldLine );

  var oldPoint = [ 0, 0 ];
  test.identical( point, oldPoint );

  /* */

  test.case = 'Null line Distance empty point';

  var line = null;
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotDistance = _.linePointDir.pointDistance( line, point );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Point line Distance same Point';

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotDistance = _.linePointDir.pointDistance( line, point );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Point line Distance other Point';

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 3, 4, 0 ];
  var expected = 5;

  var gotDistance = _.linePointDir.pointDistance( line, point );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line contains point';

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = 0;

  var gotDistance = _.linePointDir.pointDistance( line, point );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line contains point with negative factor';

  var line = [ 0, 0, 0, 2, 2, - 2 ];
  var point = [  - 1, - 1, 1 ];
  var expected = 0;

  var gotDistance = _.linePointDir.pointDistance( line, point );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line over point';

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, 1, 4 ];
  var expected = 1;

  var gotDistance = _.linePointDir.pointDistance( line, point );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Point closer to origin';

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, -2, 0 ];
  var expected = 2;

  var gotDistance = _.linePointDir.pointDistance( line, point );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Point with negative factor';

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, 0, -2 ];
  var expected = 0;

  var gotDistance = _.linePointDir.pointDistance( line, point );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) Distance point';

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var point = [ 0.500, 0.500, 0.000 ];
  var expected = 0;

  var gotDistance = _.linePointDir.pointDistance( line, point );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) doesn´t contain point';

  var line = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, - 0.303 ];
  var expected = 0.568342039793567;

  var gotDistance = _.linePointDir.pointDistance( line, point );
  test.equivalent( gotDistance, expected );

  /* */

  test.case = 'Line of four dimensions distance ';

  var line = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0 , 4 ];
  var expected = Math.sqrt( 12 );

  var gotDistance = _.linePointDir.pointDistance( line, point );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line of 7 dimensions distance';

  var line = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 0, 0, 0, 0, 0, 0, 1 ];
  var point = [ 2, 2, 2, 2, 2, 2, 2 ];
  var expected = Math.sqrt( 96 );

  var gotDistance = _.linePointDir.pointDistance( line, point );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line of 1 dimension contains point';

  var line = [ 0, 2 ];
  var point = [ 1 ];
  var expected = 0;

  var gotDistance = _.linePointDir.pointDistance( line, point );
  test.identical( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePointDir.pointDistance( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointDistance( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointDistance( [ 1, 1, 2, 2 ], 'line') );
  test.shouldThrowErrorSync( () => _.linePointDir.pointDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointDistance( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointDistance( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointDistance( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointDistance( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointDistance( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function pointClosestPoint( test )
{

  /* */

  test.case = 'Line and Point remain unchanged';

  var line = [  - 1, - 1 , 1, 1 ];
  var point = [ 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0 ] );

  var gotClosestPoint = _.linePointDir.pointClosestPoint( line, point );
  test.identical( gotClosestPoint, expected );

  var oldLine = [  - 1, - 1 , 1, 1 ];
  test.identical( line, oldLine );

  var oldPoint = [ 0, 0 ];
  test.identical( point, oldPoint );

  /* */

  test.case = 'Null line - empty point';

  var line = null;
  var point = [ 0, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0 ] );

  var gotClosestPoint = _.linePointDir.pointClosestPoint( line, point );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Point line - same Point';

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0 ] );

  var gotClosestPoint = _.linePointDir.pointClosestPoint( line, point );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Point line - other Point';

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var point = [ 3, 4, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 1, 2, 3 ] );

  var gotClosestPoint = _.linePointDir.pointClosestPoint( line, point );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line contains point';

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ 1, 1, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 1, 1, 1 ] );

  var gotClosestPoint = _.linePointDir.pointClosestPoint( line, point );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line over point';

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, 1, 4 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 4 ] );

  var gotClosestPoint = _.linePointDir.pointClosestPoint( line, point );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Point with negative factor';

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ - 2, - 2, - 2 ];
  var expected = _.linePointDir.tools.long.make( [ - 2, - 2, - 2 ] );

  var gotClosestPoint = _.linePointDir.pointClosestPoint( line, point );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) Distance point';

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var point = [ 0.500, 0.500, 0.000 ];
  var expected = _.linePointDir.tools.long.make( [ 0.5, 0.5, 0 ] );

  var gotClosestPoint = _.linePointDir.pointClosestPoint( line, point );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) doesn´t contain point';

  var line = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, - 0.303 ];
  var expected = _.linePointDir.tools.long.make( [ 0.02572500470627867, 0.10157398765468795, 0.10157398765468795 ] );

  var gotClosestPoint = _.linePointDir.pointClosestPoint( line, point );
  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'Line of four dimensions distance ';

  var line = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0 , 4 ];
  var expected = _.linePointDir.tools.long.make( [ 1, 1, 1, 1 ] );

  var gotClosestPoint = _.linePointDir.pointClosestPoint( line, point );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line of 7 dimensions distance';

  var line = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 0, 0, 0, 0, 0, 0, 1 ];
  var point = [ 2, 2, 2, 2, 2, 2, 2 ];
  var expected = _.linePointDir.tools.long.make( [ - 2, - 2, - 2, - 2, - 2, - 2, 2 ] );

  var gotClosestPoint = _.linePointDir.pointClosestPoint( line, point );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line of 1 dimension contains point';

  var line = [ 0, 2 ];
  var point = [ 1 ];
  var expected = [ 1 ];

  var gotClosestPoint = _.linePointDir.pointClosestPoint( line, point );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line of 1 contains point with negative factor';

  var line = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = [ -3 ];

  var gotClosestPoint = _.linePointDir.pointClosestPoint( line, point );
  test.identical( gotClosestPoint, expected );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePointDir.pointClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointClosestPoint( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointClosestPoint( [ 1, 1, 2, 2 ], 'line') );
  test.shouldThrowErrorSync( () => _.linePointDir.pointClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointClosestPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointClosestPoint( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointClosestPoint( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointClosestPoint( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.pointClosestPoint( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function boxIntersects( test )
{

  /* */

  test.case = 'Line and box remain unchanged';

  var line = [  - 1, - 1, -1, 1, 1, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.linePointDir.boxIntersects( line, box );
  test.identical( gotBool, expected );

  var oldLine = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( line, oldLine );

  var oldBox = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( box, oldBox );

  /* */

  test.case = 'Null line - empty box';

  var line = null;
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = true;

  var gotBool = _.linePointDir.boxIntersects( line, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'box line - same box';

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = true;

  var gotBool = _.linePointDir.boxIntersects( line, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point line - no intersection';

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 4, 3, 4, 0 ];
  var expected = false;

  var gotBool = _.linePointDir.boxIntersects( line, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point line in box';

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 2, 3, 4, 4 ];
  var expected = true;

  var gotBool = _.linePointDir.boxIntersects( line, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line and box intersect';

  var line = [ -2, -2, -2, 2, 2, 2 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.linePointDir.boxIntersects( line, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line over box';

  var line = [ 0, 0, 4, 0, 0, 2 ];
  var box = [ 0, 1, 1, 3, 7, 3 ];
  var expected = false;

  var gotBool = _.linePointDir.boxIntersects( line, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'box closer to origin';

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ - 2, - 2, - 3, -1, -1, - 2 ];
  var expected = true;

  var gotBool = _.linePointDir.boxIntersects( line, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'box with negative factor';

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ - 2, - 2, - 2, -1, -1, -1 ];
  var expected = true;

  var gotBool = _.linePointDir.boxIntersects( line, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) intersection';

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var box = [ 0.500, 0.123, 0, 0.734, 0.900, 0.837 ];
  var expected = true;

  var gotBool = _.linePointDir.boxIntersects( line, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) doesn´t contain box';

  var line = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var box = [ 0.12322, 0.03232, 0, 0.050, 0.500, - 0.303 ];
  var expected = false;

  var gotBool = _.linePointDir.boxIntersects( line, box );
  test.equivalent( gotBool, expected );

  /* */

  test.case = '2D intersection';

  var line = [ 0, 0, 2, 2 ];
  var box = [ 1, 2, 3, 4 ];
  var expected = true;

  var gotBool = _.linePointDir.boxIntersects( line, box );
  test.identical( gotBool, expected );

  /* */

  test.case = '2D no intersection';

  var line = [ 0, 0, 2, -2 ];
  var box = [ 1, 2, 3, 4 ];
  var expected = false;

  var gotBool = _.linePointDir.boxIntersects( line, box );
  test.identical( gotBool, expected );


  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePointDir.boxIntersects( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boxIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boxIntersects( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boxIntersects( [ 1, 1, 2, 2 ], 'box') );
  test.shouldThrowErrorSync( () => _.linePointDir.boxIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boxIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boxIntersects( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boxIntersects( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boxIntersects( [ 1, 1, 2, 2 ], - 2 ) );

}

//

function boxDistance( test )
{
  /* */

  test.case = 'Line and box remain unchanged';

  var line = [  - 1, - 1, -1, 1, 1, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotBool = _.linePointDir.boxDistance( line, box );
  test.identical( gotBool, expected );

  var oldLine = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( line, oldLine );

  var oldBox = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( box, oldBox );

  /* */

  test.case = 'Null line - empty box';

  var line = null;
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotBool = _.linePointDir.boxDistance( line, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'box line - same box';

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotBool = _.linePointDir.boxDistance( line, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point line';

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 4, 3, 4, 5 ];
  var expected = 1;

  var gotBool = _.linePointDir.boxDistance( line, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point line in box';

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 2, 3, 4, 4 ];
  var expected = 0;

  var gotBool = _.linePointDir.boxDistance( line, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line and box intersect';

  var line = [ -2, -2, -2, 2, 2, 2 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotBool = _.linePointDir.boxDistance( line, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line over box';

  var line = [ 0, 0, 4, 0, 0, 2 ];
  var box = [ 0, 1, 1, 3, 7, 3 ];
  var expected = 1;

  var gotBool = _.linePointDir.boxDistance( line, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'box corner is in line with negative factor';

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ - 2, - 2, - 2, -1, -1, -1 ];
  var expected = 0;

  var gotBool = _.linePointDir.boxDistance( line, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'box corner closer to origin';

  var line = [ 2, 2, 2, - 2, 2, 2 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = Math.sqrt( 24/9 );

  var gotBool = _.linePointDir.boxDistance( line, box );
  test.equivalent( gotBool, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) intersection';

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var box = [ 0.500, 0.123, 0, 0.734, 0.900, 0.837 ];
  var expected = 0;

  var gotBool = _.linePointDir.boxDistance( line, box );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) doesn´t contain box';

  var line = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var box = [ 0.12322, 0.03232, 0, 0.050, 0.500, 0.303 ];
  var expected = 0.04570949385069674;

  var gotBool = _.linePointDir.boxDistance( line, box );
  test.equivalent( gotBool, expected );

  /* */

  test.case = '2D';

  var line = [ 2, 0, 2, 2 ];
  var box = [ 0, 0, 1, 1 ];
  var expected = Math.sqrt( 0.5 );

  var gotBool = _.linePointDir.boxDistance( line, box );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePointDir.boxDistance( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boxDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boxDistance( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boxDistance( [ 1, 1, 2, 2 ], 'box') );
  test.shouldThrowErrorSync( () => _.linePointDir.boxDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boxDistance( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boxDistance( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boxDistance( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boxDistance( [ 1, 1, 2, 2 ], - 2 ) );

}

//

function boxClosestPoint( test )
{
  /* */

  test.case = 'Line and box remain unchanged';

  var line = [  - 1, - 1, -1, 1, 1, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotPoint = _.linePointDir.boxClosestPoint( line, box );
  test.identical( gotPoint, expected );

  var oldLine = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( line, oldLine );

  var oldBox = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( box, oldBox );

  /* */

  test.case = 'Null line - empty box';

  var line = null;
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotPoint = _.linePointDir.boxClosestPoint( line, box );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'box line - same box';

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotPoint = _.linePointDir.boxClosestPoint( line, box );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'point line';

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 4, 3, 4, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 1, 2, 3 ] );

  var gotPoint = _.linePointDir.boxClosestPoint( line, box );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'point line in box';

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 2, 3, 4, 4 ];
  var expected = 0;

  var gotPoint = _.linePointDir.boxClosestPoint( line, box );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Line and box intersect';

  var line = [ -2, -2, -2, 2, 2, 2 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotPoint = _.linePointDir.boxClosestPoint( line, box );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Line over box - negative factor';

  var line = [ 0, 0, 4, 0, 0, 2 ];
  var box = [ 0, 1, 1, 3, 7, 3 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 1 ] );

  var gotPoint = _.linePointDir.boxClosestPoint( line, box );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'box corner - negative factor';

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ - 2, - 2, - 2, -1, -1, -1 ];
  var expected = 0;

  var gotPoint = _.linePointDir.boxClosestPoint( line, box );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'box corner closer to origin';

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ 0, - 2, 0, 1, -1, 1 ];
  var expected = _.linePointDir.tools.long.make( [ - 1/3, - 1/3, - 1/3 ] );

  var gotPoint = _.linePointDir.boxClosestPoint( line, box );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'box corner not close to origin';

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ 6, 7, 8, 6, 9, 10 ];
  var expected = _.linePointDir.tools.long.make( [ 7, 7, 7 ] );

  var gotPoint = _.linePointDir.boxClosestPoint( line, box );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) intersection';

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var box = [ 0.500, 0.123, 0, 0.734, 0.900, 0.837 ];
  var expected = 0;

  var gotPoint = _.linePointDir.boxClosestPoint( line, box );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) doesn´t contain box';

  var line = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var box = [ 0.12322, 0.03232, 0, 0.050, 0.500, - 0.303 ];
  var expected = _.linePointDir.tools.long.make( [ 0.005519293548276563, 0.021792674525669315, 0.021792674525669315 ] );

  var gotPoint = _.linePointDir.boxClosestPoint( line, box );
  test.equivalent( gotPoint, expected );

  /* */

  test.case = '2D';

  var line = [ 0, 0, 2, 1 ];
  var box = [ 6, 7, 10, 8 ];
  var expected = _.linePointDir.tools.long.make( [ 10.8, 5.4 ] );

  var gotPoint = _.linePointDir.boxClosestPoint( line, box );
  test.identical( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePointDir.boxClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boxClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boxClosestPoint( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boxClosestPoint( [ 1, 1, 2, 2 ], 'box') );
  test.shouldThrowErrorSync( () => _.linePointDir.boxClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boxClosestPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boxClosestPoint( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boxClosestPoint( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boxClosestPoint( [ 1, 1, 2, 2 ], - 2 ) );

}

//

function boundingBoxGet( test )
{

  /* */

  test.case = 'Source line remains unchanged';

  var srcLine = [ 0, 0, 0, 3, 3, 3 ];
  var dstBox = [ 1, 1, 1, 2, 2, 2 ];
  var expected = _.linePointDir.tools.long.make( [ - Infinity, - Infinity, - Infinity, Infinity, Infinity, Infinity ] );

  var gotBox = _.linePointDir.boundingBoxGet( dstBox, srcLine );
  test.identical( expected, gotBox );
  test.true( dstBox === gotBox );

  var oldSrcLine = [ 0, 0, 0, 3, 3, 3 ];
  test.identical( srcLine, oldSrcLine );

  /* */

  test.case = 'Empty';

  var srcLine = [ ];
  var dstBox = [ ];
  var expected = _.linePointDir.tools.long.make( [ ] );

  var gotBox = _.linePointDir.boundingBoxGet( dstBox, srcLine );
  test.identical( gotBox, expected );

  /* */

  test.case = 'Zero line to zero box';

  var srcLine = [ 0, 0, 0, 0, 0, 0 ];
  var dstBox = [ 0, 0, 0, 1, 1, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0, 0, 0, 0 ] );

  var gotBox = _.linePointDir.boundingBoxGet( dstBox, srcLine );
  test.identical( gotBox, expected );

  /* */

  test.case = 'Line inside box';

  var srcLine = [ 1, 1, 1, 4, 4, 4 ];
  var dstBox = [ 0, 0, 0, 5, 5, 5 ];
  var expected = _.linePointDir.tools.long.make( [ - Infinity, - Infinity, - Infinity, Infinity, Infinity, Infinity ] );

  var gotBox = _.linePointDir.boundingBoxGet( dstBox, srcLine );
  test.identical( gotBox, expected );

  /* */

  test.case = 'Line outside Box';

  var srcLine = [ - 1, - 1, - 1, 1, 2, 3 ];
  var dstBox = [ - 3, - 4, - 5, - 5, - 4, - 2 ];
  var expected = _.linePointDir.tools.long.make( [  - Infinity, - Infinity, - Infinity, Infinity, Infinity, Infinity ] );

  var gotBox = _.linePointDir.boundingBoxGet( dstBox, srcLine );
  test.identical( gotBox, expected );

  /* */

  test.case = 'Point line and point Box';

  var srcLine = [ 1, 2, 3, 0, 0, 0 ];
  var dstBox = [ 3, 3, 3, 4, 4, 4 ];
  var expected = _.linePointDir.tools.long.make( [ 1, 2, 3, 1, 2, 3 ] );

  var gotBox = _.linePointDir.boundingBoxGet( dstBox, srcLine );
  test.identical( gotBox, expected );

  /* */

  test.case = 'Negative line direction';

  var srcLine = [ 1, 2, 3, - 3, - 2, - 1 ];
  var dstBox = [ 3, 3, 3, 4, 4, 4 ];
  var expected = _.linePointDir.tools.long.make( [ - Infinity, - Infinity, - Infinity, Infinity, Infinity, Infinity ] );

  var gotBox = _.linePointDir.boundingBoxGet( dstBox, srcLine );
  test.identical( gotBox, expected );

  /* */

  test.case = 'Mixed directions';

  var srcLine = [ 1, 2, 3, - 1, 0, 1 ];
  var dstBox = [ 3, 3, 3, 4, 4, 4 ];
  var expected = _.linePointDir.tools.long.make( [ - Infinity, 2, - Infinity, Infinity, 2, Infinity ] );

  var gotBox = _.linePointDir.boundingBoxGet( dstBox, srcLine );
  test.identical( gotBox, expected );

  /* */

  test.case = 'srcLine vector';

  var srcLine = _.linePointDir.tools.vectorAdapter.from( [ - 8, - 5, 4.5, 4, 7, 16.5 ] );
  var dstBox = [ 1, - 1, 5, 0, 3, 2 ];
  var expected = _.linePointDir.tools.long.make( [  - Infinity, - Infinity, - Infinity, Infinity, Infinity, Infinity ] );

  var gotBox = _.linePointDir.boundingBoxGet( dstBox, srcLine );
  test.identical( gotBox, expected );

  /* */

  test.case = 'dstBox vector - 2D';

  var srcLine = [ - 1, 0, - 2, 3 ];
  var dstBox = _.linePointDir.tools.vectorAdapter.from( [ 1, 2, 3, 9 ] );
  var expected = _.linePointDir.tools.vectorAdapter.from( [ - Infinity, - Infinity, Infinity, Infinity ] );

  var gotBox = _.linePointDir.boundingBoxGet( dstBox, srcLine );
  test.identical( gotBox, expected );

  /* */

  test.case = 'dstBox null';

  var srcLine = [ 2.2, 3.3, - 4.4, 0 ];
  var dstBox = null;
  var expected = _.linePointDir.tools.long.make( [ - Infinity, 3.3, Infinity, 3.3 ] );

  var gotBox = _.linePointDir.boundingBoxGet( dstBox, srcLine );
  test.equivalent( gotBox, expected );

  /* */

  test.case = 'dstBox undefined';

  var srcLine = [ - 1, - 3, 0, 1 ];
  var dstBox = undefined;
  var expected = _.linePointDir.tools.long.make( [  -1, - Infinity, - 1, Infinity ] );

  var gotBox = _.linePointDir.boundingBoxGet( dstBox, srcLine );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePointDir.boundingBoxGet( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boundingBoxGet( [] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boundingBoxGet( 'box', 'line' ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boundingBoxGet( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boundingBoxGet( [ 1, 0, 1, 2, 1, 2 ], [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boundingBoxGet( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 3, 4, 5 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boundingBoxGet( NaN, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boundingBoxGet( [ 0, 1, 0, 1, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boundingBoxGet( [ 0, 1, 0, 1, 2, 1 ], NaN ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boundingBoxGet( [ 0, 1, 0, 1, 2 ], [ 0, 0, 1 ] ) );

}

//

function capsuleClosestPoint( test )
{
  /* */

  test.case = 'Line and capsule remain unchanged';

  var line = [  - 1, - 1, -1, 1, 1, 1 ];
  var capsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var expected = 0;

  var gotPoint = _.linePointDir.capsuleClosestPoint( line, capsule );
  test.identical( gotPoint, expected );

  var oldLine = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( line, oldLine );

  var oldCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  test.identical( capsule, oldCapsule );

  /* */

  test.case = 'capsule line - same capsule';

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var capsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotPoint = _.linePointDir.capsuleClosestPoint( line, capsule );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'point line';

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var capsule = [ 1, 2, 4, 3, 4, 0, 0.5 ];
  var expected = _.linePointDir.tools.long.make( [ 1, 2, 3 ] );

  var gotPoint = _.linePointDir.capsuleClosestPoint( line, capsule );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'point line in capsule';

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var capsule = [ 1, 2, 2, 3, 4, 4, 1 ];
  var expected = 0;

  var gotPoint = _.linePointDir.capsuleClosestPoint( line, capsule );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Line and capsule intersect';

  var line = [ -2, -2, -2, 2, 2, 2 ];
  var capsule = [ 0, 0, 0, 1, 1, 1, 0.5 ];
  var expected = 0;

  var gotPoint = _.linePointDir.capsuleClosestPoint( line, capsule );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Line over capsule - negative factor';

  var line = [ 0, 0, 4, 0, 0, 2 ];
  var capsule = [ 0, 1, 1, 3, 7, 3, 0.2 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 1 ] );

  var gotPoint = _.linePointDir.capsuleClosestPoint( line, capsule );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'capsule corner - negative factor';

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var capsule = [ - 2, - 2, - 2, -1, -1, -1, 1 ];
  var expected = 0;

  var gotPoint = _.linePointDir.capsuleClosestPoint( line, capsule );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'capsule corner closer to origin';

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var capsule = [ 0, - 2, 0, 1, -1, 1, 0.2 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0 ] );

  var gotPoint = _.linePointDir.capsuleClosestPoint( line, capsule );
  test.equivalent( gotPoint, expected );

  /* */

  test.case = 'capsule corner not close to origin';

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var capsule = [ 6, 7, 8, 6, 9, 10, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 7, 7, 7 ] );

  var gotPoint = _.linePointDir.capsuleClosestPoint( line, capsule );
  test.identical( gotPoint, expected );

  /* */

  test.case = '2D';

  var line = [ 0, 0, 2, 1 ];
  var capsule = [ 6, 7, 10, 8, 0.1 ];
  var expected = _.linePointDir.tools.long.make( [ 11.2, 5.6 ] );

  var gotPoint = _.linePointDir.capsuleClosestPoint( line, capsule );
  test.identical( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePointDir.capsuleClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.capsuleClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.capsuleClosestPoint( 'line', [ 1, 1, 2, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.capsuleClosestPoint( [ 1, 1, 2, 2 ], 'capsule') );
  test.shouldThrowErrorSync( () => _.linePointDir.capsuleClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.capsuleClosestPoint( undefined, [ 1, 1, 2, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.capsuleClosestPoint( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.capsuleClosestPoint( null, [ 1, 1, 2, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.capsuleClosestPoint( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.capsuleClosestPoint( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.capsuleClosestPoint( [ 1, 1, 2, 2 ], [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.capsuleClosestPoint( [ 1, 1, 2, 2 ], [ 1, 1, 2, 2, - 1 ] ) );

}

//

function convexPolygonClosestPoint( test )
{

  /* */

  test.case = 'Source line and polygon remain unchanged';

  var srcLine = [ - 1, - 1, -1, 1, 0, 1 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = 0;

  var gotPoint = _.linePointDir.convexPolygonClosestPoint( srcLine, polygon );
  test.identical( expected, gotPoint );

  var oldSrcLine = [ - 1, - 1, -1, 1, 0, 1 ];
  test.identical( srcLine, oldSrcLine );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  /* */

  test.case = 'Line and polygon intersect';

  var srcLine = [ - 1, - 1, -1, 1, 1, 1 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = 0;

  var gotPoint = _.linePointDir.convexPolygonClosestPoint( srcLine, polygon );
  test.identical( expected, gotPoint );

  /* */

  test.case = 'Line cuts polygon vertex';

  var srcLine = [ 0, 1, 0, 1, 0, 0 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    -2,  -2,  -2,  -2,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = 0;

  var gotPoint = _.linePointDir.convexPolygonClosestPoint( srcLine, polygon );
  test.identical( expected, gotPoint );

  /* */

  test.case = 'Line next to polygon vertex';

  var srcLine = [ 0, 2, 0, 1, 0, 0 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    -2,  -2,  -2,  -2,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = _.linePointDir.tools.long.make( [ -2, 2, 0 ] );

  var gotPoint = _.linePointDir.convexPolygonClosestPoint( srcLine, polygon );
  test.identical( expected, gotPoint );

  /* */

  test.case = 'Line cuts polygon edge';

  var srcLine = [ -1, 0, 0, 1, 0.5, 0.5 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = 0;

  var gotPoint = _.linePointDir.convexPolygonClosestPoint( srcLine, polygon );
  test.identical( expected, gotPoint );

  /* */

  test.case = 'Line next to polygon edge';

  var srcLine = [ -1, 0, 0, 1, 1, 1 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = _.linePointDir.tools.long.make( [ - 1/3, 2/3, 2/3 ] );

  var gotPoint = _.linePointDir.convexPolygonClosestPoint( srcLine, polygon );
  test.equivalent( expected, gotPoint );

  /* */

  test.case = 'Line cuts polygon';

  var srcLine = [ - 3, 2, 0, - 1, 1.5, 0.5 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    -2,  -2,  -2,  -2,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = 0;

  var gotPoint = _.linePointDir.convexPolygonClosestPoint( srcLine, polygon );
  test.identical( expected, gotPoint );

  /* */

  test.case = 'Line next to polygon';

  var srcLine = [ 3, 4, - 1, 1, 1, 0 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1,
    0,   0,   0,   0
  ]);
  var expected = _.linePointDir.tools.long.make( [ 0, 1, -1 ] );

  var gotPoint = _.linePointDir.convexPolygonClosestPoint( srcLine, polygon );
  test.identical( expected, gotPoint );

  /* */

  test.case = '2D';

  var srcLine = [ 0, 3, 3, 3 ];
  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    0,   1,   1,   0,
    0,   0,   1,   1
  ]);
  var expected = _.linePointDir.tools.long.make( [ -1, 2 ] );

  var gotPoint = _.linePointDir.convexPolygonClosestPoint( srcLine, polygon );
  test.identical( expected, gotPoint );

  /* */

  test.case = 'dstPoint Array';

  var srcLine = [ 3, 3, 3, 1, 1, 2 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var dstPoint = [ 0, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 2/3, 2/3, -5/3 ] );

  var gotPoint = _.linePointDir.convexPolygonClosestPoint( srcLine, polygon, dstPoint );
  test.equivalent( expected, gotPoint );
  test.true( dstPoint === gotPoint );

  /* */

  test.case = 'dstPoint Vector';

  var srcLine = [ -1, 2, -4, 0, 0, -1 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var dstPoint = _.linePointDir.tools.vectorAdapter.from( [ 0, 2, 1 ] );
  var expected = _.linePointDir.tools.vectorAdapter.from( [ -1, 2, 0 ] );

  var gotPoint = _.linePointDir.convexPolygonClosestPoint( srcLine, polygon, dstPoint );
  test.equivalent( expected, gotPoint );
  test.true( dstPoint === gotPoint );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.shouldThrowErrorSync( () => _.linePointDir.convexPolygonClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.convexPolygonClosestPoint( [] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.convexPolygonClosestPoint( 'line', polygon ) );
  test.shouldThrowErrorSync( () => _.linePointDir.convexPolygonClosestPoint( [ 0, 0, 1, 1 ], 'polygon' ) );
  test.shouldThrowErrorSync( () => _.linePointDir.convexPolygonClosestPoint(  null, polygon ) );
  test.shouldThrowErrorSync( () => _.linePointDir.convexPolygonClosestPoint(  [ 0, 1, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.convexPolygonClosestPoint(  NaN, polygon ) );
  test.shouldThrowErrorSync( () => _.linePointDir.convexPolygonClosestPoint(  [ 0, 1, 2, 1 ], NaN ) );
  test.shouldThrowErrorSync( () => _.linePointDir.convexPolygonClosestPoint( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.convexPolygonClosestPoint( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1 ], polygon ) );
  test.shouldThrowErrorSync( () => _.linePointDir.convexPolygonClosestPoint( [ 0, 1, 0, 1, 2, 1 ], polygon, polygon ) );
  test.shouldThrowErrorSync( () => _.linePointDir.convexPolygonClosestPoint( [ 0, 1, 0 ], polygon ) );
  test.shouldThrowErrorSync( () => _.linePointDir.convexPolygonClosestPoint( [ 0, 1, 0, 2, 2 ], polygon ) );
  test.shouldThrowErrorSync( () => _.linePointDir.convexPolygonClosestPoint( [ 0, 1, 0, 2, 2, 2 ], polygon ) );

}

//

function frustumIntersects( test )
{

  test.description = 'Line and frustum remain unchanged'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ 1, 1, 1, 3, 3, 3 ];
  var expected = true;

  var gotBool = _.linePointDir.frustumIntersects( line, srcFrustum );
  test.identical( gotBool, expected );

  var oldLine = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( line, oldLine );

  var oldFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  test.identical( srcFrustum, oldFrustum );


  test.description = 'Frustum and line intersect'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.linePointDir.frustumIntersects( line, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and line intersect on frustum corner'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ 2, 2, 0, - 1, -1, 1 ];
  var expected = true;

  var gotBool = _.linePointDir.frustumIntersects( line, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum corner is line origin'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ 1, 1, 1, 0, 0, 2 ];
  var expected = true;

  var gotBool = _.linePointDir.frustumIntersects( line, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and line intersect on frustum side'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ -1, -1, 0, 0.5, 0.5, 0 ];
  var expected = true;

  var gotBool = _.linePointDir.frustumIntersects( line, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Negative factor'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ 4, 4, 4, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.linePointDir.frustumIntersects( line, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and line not intersecting'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ 4, 4, 4, 5, 5, 0 ];
  var expected = false;

  var gotBool = _.linePointDir.frustumIntersects( line, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and line almost intersecting'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ 1.1, 1.1, 4.1, 5, 5, 5 ];
  var expected = false;

  var gotBool = _.linePointDir.frustumIntersects( line, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and line just touching'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ 1, 1, 1, 5 , 5, 5 ];
  var expected = true;

  var gotBool = _.linePointDir.frustumIntersects( line, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and line just intersect'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ 0.9, 0.9, 0.9, 5, 5, 5 ];
  var expected = true;

  var gotBool = _.linePointDir.frustumIntersects( line, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'line is null - intersection'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = null;
  var expected = true;

  var gotBool = _.linePointDir.frustumIntersects( line, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'line is null - no intersection'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0.5, - 1, 0.5, 0.5, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = null;
  var expected = false;

  var gotBool = _.linePointDir.frustumIntersects( line, srcFrustum );
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

  test.shouldThrowErrorSync( () => _.linePointDir.frustumIntersects( ));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumIntersects( line ));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumIntersects( srcFrustum ));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumIntersects( line, srcFrustum, srcFrustum ));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumIntersects( line, line, srcFrustum ));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumIntersects( null, line ));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumIntersects( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumIntersects( NaN, line ));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumIntersects( srcFrustum, NaN));

  line = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.linePointDir.frustumIntersects( line, srcFrustum ));
  line = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.linePointDir.frustumIntersects( line, srcFrustum ));
  line = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.linePointDir.frustumIntersects( line, srcFrustum ));

}

//

function frustumDistance( test )
{

  test.description = 'Line and frustum remain unchanged'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ 1, 1, 1, 3, 3, 3 ];
  var expected = 0;

  var gotDistance = _.linePointDir.frustumDistance( line, srcFrustum );
  test.identical( gotDistance, expected );

  var oldLine = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( line, oldLine );

  var oldFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Frustum and line intersect'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotDistance = _.linePointDir.frustumDistance( line, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustum and line intersect on frustum corner'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ 2, 2, 0, - 1, -1, 1 ];
  var expected = 0;

  var gotDistance = _.linePointDir.frustumDistance( line, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustum and line intersect on frustum side'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ -1, -1, 0, 0.5, 0.5, 0 ];
  var expected = 0;

  var gotDistance = _.linePointDir.frustumDistance( line, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Negative factor'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ 4, 4, 4, 5, 5, 5 ];
  var expected = 0;

  var gotDistance = _.linePointDir.frustumDistance( line, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustum and line not intersecting'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ 4, 4, 4, 1, 1, 0 ];
  var expected = 3;

  var gotDistance = _.linePointDir.frustumDistance( line, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustum and line almost intersecting'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ 1.1, 1.1, 1.1, 5, 5, 0 ];
  var expected = 0.1;

  var gotDistance = _.linePointDir.frustumDistance( line, srcFrustum );
  test.equivalent( gotDistance, expected );

  test.description = 'line is null - intersection'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = null;
  var expected = 0;

  var gotDistance = _.linePointDir.frustumDistance( line, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'line is null - no intersection'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0.5, - 1, 0.5, 0.5, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = null;
  var expected = Math.sqrt( 0.75 );

  var gotDistance = _.linePointDir.frustumDistance( line, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'line closest to box side'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0.5, - 1, 0.5, 0.5, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ - 2, 0.3, 0, 1, 0, 0 ];
  var expected = Math.sqrt( 0.29 );

  var gotDistance = _.linePointDir.frustumDistance( line, srcFrustum );
  test.equivalent( gotDistance, expected );

  test.description = 'Inclined line closest to box side'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0.5, - 1, 0.5, 0.5, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ -2, 0.3, 0, 1, 0, 0.1 ];
  var expected = 0.2821417381318113;

  var gotDistance = _.linePointDir.frustumDistance( line, srcFrustum );
  test.equivalent( gotDistance, expected );

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

  test.shouldThrowErrorSync( () => _.linePointDir.frustumDistance( ));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumDistance( line ));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumDistance( srcFrustum ));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumDistance( line, srcFrustum, srcFrustum ));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumDistance( line, line, srcFrustum ));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumDistance( null, line ));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumDistance( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumDistance( NaN, line ));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumDistance( srcFrustum, NaN));

  line = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.linePointDir.frustumDistance( line, srcFrustum ));
  line = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.linePointDir.frustumDistance( line, srcFrustum ));
  line = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.linePointDir.frustumDistance( line, srcFrustum ));

}

//

function frustumClosestPoint( test )
{

  test.description = 'Line and frustum remain unchanged'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ 1, 1, 1, 3, 3, 3 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.frustumClosestPoint( line, srcFrustum );
  test.identical( gotClosestPoint, expected );

  var oldLine = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( line, oldLine );

  var oldFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Frustum and line intersect'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.frustumClosestPoint( line, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'Frustum and line intersect on frustum corner'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ 2, 2, 0, - 1, -1, 1 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.frustumClosestPoint( line, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'Frustum and line intersect on frustum side'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ -1, -1, 0, 0.5, 0.5, 0 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.frustumClosestPoint( line, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'Negative factor'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ 4, 4, 4, 5, 5, 5 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.frustumClosestPoint( line, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'Frustum and line not intersecting'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ 4, 4, 4, 5, 5, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 1, 1, 4 ] );

  test.description = 'Frustum and line almost intersecting'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ 1.1, 1.1, 1.1, 5, 5, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 1, 1, 1.1 ] );

  var gotClosestPoint = _.linePointDir.frustumClosestPoint( line, srcFrustum );
  test.equivalent( gotClosestPoint, expected );

  test.description = 'line is null - intersection'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = null;
  var expected = 0;

  var gotClosestPoint = _.linePointDir.frustumClosestPoint( line, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'line is null - no intersection'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0.5, - 1, 0.5, 0.5, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = null;
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0 ] );

  var gotClosestPoint = _.linePointDir.frustumClosestPoint( line, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'line closest to box side'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0.5, - 1, 0.5, 0.5, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ - 2, 0.3, 0, 1, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 0.5, 0.3, 0 ] );

  var gotClosestPoint = _.linePointDir.frustumClosestPoint( line, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'Inclined line closest to box side'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0.5, - 1, 0.5, 0.5, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ -2, 0.3, 0, 1, 0, 0.1 ];
  var expected = _.linePointDir.tools.long.make( [ 1.0198020935058594, 0.3, 0.30198020935058595 ] );

  var gotClosestPoint = _.linePointDir.frustumClosestPoint( line, srcFrustum );
  test.equivalent( gotClosestPoint, expected );

  test.description = 'Destination point is vector'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0.5, - 1, 0.5, 0.5, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var line = [ 0, 2, 2, - 1, - 1, - 1 ];
  var dstPoint = _.linePointDir.tools.vectorAdapter.from( [ 0, 0, 0 ] );
  var expected = _.linePointDir.tools.vectorAdapter.from( [ -0.5, 1.5, 1.5 ] );

  var gotClosestPoint = _.linePointDir.frustumClosestPoint( line, srcFrustum, dstPoint );
  test.identical( gotClosestPoint, expected );

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

  test.shouldThrowErrorSync( () => _.linePointDir.frustumClosestPoint( ));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumClosestPoint( line ));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumClosestPoint( srcFrustum ));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumClosestPoint( line, srcFrustum, srcFrustum ));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumClosestPoint( line, line, srcFrustum ));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumClosestPoint( null, line ));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumClosestPoint( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumClosestPoint( NaN, line ));
  test.shouldThrowErrorSync( () => _.linePointDir.frustumClosestPoint( srcFrustum, NaN));

  line = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.linePointDir.frustumClosestPoint( line, srcFrustum ));
  line = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.linePointDir.frustumClosestPoint( line, srcFrustum ));
  line = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.linePointDir.frustumClosestPoint( line, srcFrustum ));

}

//

function lineIntersects( test )
{
  /* */

  test.case = 'Source lines remain unchanged';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 0, 0, 2, 2 ];
  var expected = true;

  var isIntersection = _.linePointDir.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  var oldSrc1Line = [ 0, 0, 1, 1 ];
  test.equivalent( src1Line, oldSrc1Line );

  var oldSrc2Line = [ 0, 0, 2, 2 ];
  test.equivalent( src2Line, oldSrc2Line );

  /* */

  test.case = 'Lines are the same';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 0, 0, 1, 1 ];
  var expected = true;

  var isIntersection = _.linePointDir.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Lines are parallel ( different origin - same direction )';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 7, 1, 1 ];
  var expected = false;

  var isIntersection = _.linePointDir.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Lines are parallel ( different origin - different direction )';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 7, 7, 7 ];
  var expected = false;

  var isIntersection = _.linePointDir.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Lines intersect with negative factor';

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 0, 2, -1 ];
  var expected = true;

  var isIntersection = _.linePointDir.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Lines intersect in their origin';

  var src1Line = [ 3, 7, 1, 0 ];
  var src2Line = [ 3, 7, 0, 1 ];
  var expected = true;

  var isIntersection = _.linePointDir.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Lines intersect ';

  var src1Line = [ 0, 0, 1, 0 ];
  var src2Line = [ -2, -6, 1, 2 ];
  var expected = true;

  var isIntersection = _.linePointDir.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Lines are perpendicular ';

  var src1Line = [ -3, 0, 1, 0 ];
  var src2Line = [ 0, -2, 0, 1 ];
  var expected = true;

  var isIntersection = _.linePointDir.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Lines don´t intersect 3D';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 0, 1, 2, 2, -1 ];
  var expected = false;

  var isIntersection = _.linePointDir.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Lines intersect 3D';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 3, 1, 4 ];
  var expected = true;

  var isIntersection = _.linePointDir.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Lines don´t intersect 4D';

  var src1Line = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Line = [ 3, 0, 1, 4, 2, 2, 2, -1 ];
  var expected = false;

  var isIntersection = _.linePointDir.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Lines intersect 4D';

  var src1Line = [ 0, 0, 0, 1, 1, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 4, 3, 1, 4, 3 ];
  var expected = true;

  var isIntersection = _.linePointDir.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersects( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersects( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersects( [ 1, 1, 2, 2 ], 'line') );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersects( null, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersects( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersects( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersects( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineIntersects( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function lineDistance( test )
{
  /* */

  test.case = 'Source lines remain unchanged';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 0, 0, 0, 2, 2, 2 ];
  var expected = 0;

  var gotDistance = _.linePointDir.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  var oldSrc1Line = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( src1Line, oldSrc1Line );

  var oldSrc2Line = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( src2Line, oldSrc2Line );

  /* */

  test.case = 'Lines are the same';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotDistance = _.linePointDir.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Lines are parallel ( different origin - same direction )';

  var src1Line = [ 0, 0, 0, 0, 0, 1 ];
  var src2Line = [ 3, 7, 1, 0, 0, 1 ];
  var expected = Math.sqrt( 58 );

  var gotDistance = _.linePointDir.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Lines are parallel ( different origin - different direction )';

  var src1Line = [ 0, 0, 0, 0, 0, 0.5 ];
  var src2Line = [ 3, 7, 1, 0, 0, 7 ];
  var expected = Math.sqrt( 58 );

  var gotDistance = _.linePointDir.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Lines are parallel ( different origin - opposite direction )';

  var src1Line = [ 0, 0, 0, 1, 0, 0 ];
  var src2Line = [ 3, 7, 1, - 7, 0, 0 ];
  var expected = Math.sqrt( 50 );

  var gotDistance = _.linePointDir.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'src1Line is a point';

  var src1Line = [ 3, 7, 1, 0, 0, 0 ];
  var src2Line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 4.320493798938574;

  var gotDistance = _.linePointDir.lineDistance( src1Line, src2Line );
  test.equivalent( gotDistance, expected );

  /* */

  test.case = 'Lines are the same';

  var src1Line = [ 0, 4, 2, 1, 1, 1 ];
  var src2Line = [ 0, 4, 2, 1, 1, 1 ];
  var expected = 0;

  var gotDistance = _.linePointDir.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Lines intersect 4D';

  var src1Line = [ 0, 0, 2, 1, 0, 1, 0, 0 ];
  var src2Line = [ 3, 4, 2, 1, -1, 0, 0, 0 ];
  var expected = 0;

  var gotDistance = _.linePointDir.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Lines intersect with negative factor 3D';

  var src1Line = [ 0, 0, 0, 3, 2, 1 ];
  var src2Line = [ - 3, - 4, -4, 0, -1, -1.5 ];
  var expected = 0;

  var gotDistance = _.linePointDir.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Lines intersect with negative factor';

  var src1Line = [ 0, 0, 2, 0 ];
  var src2Line = [ - 3, - 4, 0, 1 ];
  var expected = 0;

  var gotDistance = _.linePointDir.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Lines don´t intersect 2D';

  var src1Line = [ 0, 0, 2, 0 ];
  var src2Line = [ - 3, - 4, 1, 0 ];
  var expected = 4;

  var gotDistance = _.linePointDir.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Lines are perpendicular and intersect';

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 1, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.linePointDir.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Lines are perpendicular and don´t intersect';

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, -2, 1, 0, 0, 1 ];
  var expected = 9;

  var gotDistance = _.linePointDir.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Lines are parallel to x';

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 2, 1, 0, 0 ];
  var expected = 1;

  var gotDistance = _.linePointDir.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Lines are parallel but in a opposite direction';

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = 1;

  var gotDistance = _.linePointDir.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'srcLine is null';

  var src1Line = null;
  var src2Line = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = Math.sqrt( 53 );

  var gotDistance = _.linePointDir.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.lineDistance( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineDistance( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineDistance( [ 0, 0 ], 'line') );
  test.shouldThrowErrorSync( () => _.linePointDir.lineDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineDistance( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineDistance( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineDistance( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineDistance( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineDistance( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function lineClosestPoint( test )
{
  /* */

  test.case = 'Source lines remain unchanged';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 0, 0, 0, 2, 2, 2 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0 ] );

  var gotClosestPoint = _.linePointDir.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  var oldSrc1Line = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( src1Line, oldSrc1Line );

  var oldSrc2Line = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( src2Line, oldSrc2Line );

  /* */

  test.case = 'Lines are parallel ( different origin - same direction )';

  var src1Line = [ 0, 0, 0, 0, 0, 1 ];
  var src2Line = [ 3, 7, 1, 0, 0, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 1 ] );

  var gotClosestPoint = _.linePointDir.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Lines are parallel ( different origin - different direction )';

  var src1Line = [ 3, 7, 1, 0, 0, 7 ];
  var src2Line = [ 0, 0, 0, 0, 0, 0.5 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 7, 0 ] );

  var gotClosestPoint = _.linePointDir.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Lines are parallel ( different origin - opposite direction )';

  var src1Line = [ 0, 0, 0, 1, 0, 0 ];
  var src2Line = [ 3, 7, 1, - 7, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 0, 0 ] );

  var gotClosestPoint = _.linePointDir.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'src1Line is a point - in srcLine1';

  var src1Line = [ 3, 7, 1, 0, 0, 0 ];
  var src2Line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 7, 1 ] );

  var gotClosestPoint = _.linePointDir.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'src1Line is a point - in srcLine2';

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 0, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 3.6666666, 3.6666666, 3.6666666 ] );

  var gotClosestPoint = _.linePointDir.lineClosestPoint( src1Line, src2Line );
  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'Lines are the same';

  var src1Line = [ 0, 4, 2, 1, 1, 1 ];
  var src2Line = [ 0, 4, 2, 1, 1, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 4, 2 ] );

  var gotClosestPoint = _.linePointDir.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Lines intersect 4D';

  var src1Line = [ 0, 0, 2, 1, 0, 1, 0, 0 ];
  var src2Line = [ 3, 4, 2, 1, -1, 0, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 4, 2, 1 ] );

  var gotClosestPoint = _.linePointDir.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Lines don´t intersect 2D - parallel';

  var src1Line = [ 0, 0, 2, 0 ];
  var src2Line = [ - 3, - 4, 1, 0 ];
  var expected = _.linePointDir.tools.long.make( [ -3, 0 ] );

  var gotClosestPoint = _.linePointDir.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Lines intersect with negative factor 2D';

  var src1Line = [ 0, 0, 2, 0 ];
  var src2Line = [ - 3, - 4, 0, 1 ];
  var expected = _.linePointDir.tools.long.make( [ -3, 0 ] );

  var gotClosestPoint = _.linePointDir.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Lines are perpendicular and intersect';

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 1, 0, 0, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 7, 1 ] );

  var gotClosestPoint = _.linePointDir.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Lines are perpendicular and don´t intersect';

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, -2, 1, 0, 0, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 7, 1 ] );

  var gotClosestPoint = _.linePointDir.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Lines are parallel to x';

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 2, 1, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 7, 1 ] );

  var gotClosestPoint = _.linePointDir.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Lines are parallel but in a opposite direction';

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 7, 1 ] );

  var gotClosestPoint = _.linePointDir.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'srcLine is null';

  var src1Line = null;
  var src2Line = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0 ] );

  var gotClosestPoint = _.linePointDir.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.lineClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineClosestPoint( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineClosestPoint( [ 0, 0 ], 'line') );
  test.shouldThrowErrorSync( () => _.linePointDir.lineClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineClosestPoint( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineClosestPoint( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineClosestPoint( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineClosestPoint( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.lineClosestPoint( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function planeIntersects( test )
{

  /* */

  test.case = 'Line and plane remain unchanged';

  var line = [  - 1, - 1, -1, 1, 1, 1 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = true;

  var gotBool = _.linePointDir.planeIntersects( line, plane );
  test.identical( gotBool, expected );

  var oldLine = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( line, oldLine );

  var oldPlane = [ 1, 1, 0, 0 ];
  test.identical( plane, oldPlane );

  /* */

  test.case = 'Null line';

  var line = null;
  var plane = [ 1, 1, 0, 0 ];
  var expected = false;

  var gotBool = _.linePointDir.planeIntersects( line, plane );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point line - no intersection';

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = false;

  var gotBool = _.linePointDir.planeIntersects( line, plane );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point line in plane';

  var line = [ - 1, 2, 3, 0, 0, 0 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = true;

  var gotBool = _.linePointDir.planeIntersects( line, plane );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line and plane intersect';

  var line = [ -2, -2, -2, 2, 2, 2 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = true;

  var gotBool = _.linePointDir.planeIntersects( line, plane );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Negative factor';

  var line = [ 0, -6, 4, 1, 1, 0 ];
  var plane = [ 3, 1, 0, 0 ];
  var expected = true;

  var gotBool = _.linePointDir.planeIntersects( line, plane );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) intersection';

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var plane = [ - 2, 0, 2, 0 ];
  var expected = true;

  var gotBool = _.linePointDir.planeIntersects( line, plane );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) no intersection';

  var line = [ 0, 0, 0, 0, 0.194, 0 ];
  var plane = [ 1, 3, 0, 0 ];
  var expected = false;

  var gotBool = _.linePointDir.planeIntersects( line, plane );
  test.equivalent( gotBool, expected );

  /* */

  test.case = 'plane parallel to line';

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0.5, 0, 1, 0 ];
  var expected = false;

  var gotBool = _.linePointDir.planeIntersects( line, plane );
  test.identical( gotBool, expected );

  /* */

  test.case = 'plane parallel contains line';

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 0, 1, 0 ];
  var expected = true;

  var gotBool = _.linePointDir.planeIntersects( line, plane );
  test.identical( gotBool, expected );

  /* */

  test.case = 'plane perpendicular to line';

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.linePointDir.planeIntersects( line, plane );
  test.identical( gotBool, expected );

  /* */

  test.case = 'plane parallel to line 4D';

  var line = [ 0, 2, 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 0, 1, 0, 0 ];
  var expected = false;

  var gotBool = _.linePointDir.planeIntersects( line, plane );
  test.identical( gotBool, expected );

  /* */

  test.case = 'plane parallel to line 4D';

  var line = [ 0, 2, 0, 0, 1, 0, 1, 2 ];
  var plane = [ 0, 0, 1, 0, 0 ];
  var expected = false;

  var gotBool = _.linePointDir.planeIntersects( line, plane );
  test.identical( gotBool, expected );


  /* */

  test.case = 'plane perpendicular to line';

  var line = [ 0, 0, 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.linePointDir.planeIntersects( line, plane );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePointDir.planeIntersects( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeIntersects( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeIntersects( [ 1, 1, 1, 2, 2, 2 ], 'plane') );
  test.shouldThrowErrorSync( () => _.linePointDir.planeIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeIntersects( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeIntersects( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeIntersects( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeIntersects( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4, 5, 6 ] ) );

}

//

function planeIntersectionPoint( test )
{

  /* */

  test.case = 'Line and plane remain unchanged';

  var line = [  - 1,  - 1, -1, 1, 0, 0 ];
  var plane = [ - 1, 1, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 1, -1, -1 ] );

  var gotPoint = _.linePointDir.planeIntersectionPoint( line, plane );
  test.identical( gotPoint, expected );

  var oldLine = [  - 1, - 1, -1, 1, 0, 0 ];
  test.identical( line, oldLine );

  var oldPlane = [ -1, 1, 0, 0 ];
  test.identical( plane, oldPlane );

  /* */

  test.case = 'Null line';

  var line = null;
  var plane = [ 1, 1, 0, 0 ];
  var expected = 0;

  var gotPoint = _.linePointDir.planeIntersectionPoint( line, plane );
  test.identical( gotPoint,  expected );

  /* */

  test.case = 'point line - no intersection';

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = 0;

  var gotPoint = _.linePointDir.planeIntersectionPoint( line, plane );
  test.identical( gotPoint,  expected );

  /* */

  test.case = 'point line in plane';

  var line = [ - 1, 2, 3, 0, 0, 0 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ -1, 2, 3 ] );

  var gotPoint = _.linePointDir.planeIntersectionPoint( line, plane );
  test.identical( gotPoint,  expected );

  /* */

  test.case = 'Line and plane intersect';

  var line = [ -2, -2, -2, 2, 2, 2 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ -1, -1, -1 ] );

  var gotPoint = _.linePointDir.planeIntersectionPoint( line, plane );
  test.identical( gotPoint,  expected );

  /* */

  test.case = 'Negative factor';

  var line = [ 0, -6, 4, 1, 1, 0 ];
  var plane = [ 3, 1, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ - 3, -9, 4 ] );

  var gotPoint = _.linePointDir.planeIntersectionPoint( line, plane );
  test.identical( gotPoint,  expected );

  /* */

  test.case = 'Positive factor';

  var line = [ 0, -6, 4, 1, 1, 0 ];
  var plane = [ - 3, 1, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 3, -3, 4 ] );

  var gotPoint = _.linePointDir.planeIntersectionPoint( line, plane );
  test.identical( gotPoint,  expected );

  /* */

  test.case = 'Line ( normalized to 1 ) intersection';

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var plane = [ - 2, 0, 2, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 1, 1, 0 ] );

  var gotPoint = _.linePointDir.planeIntersectionPoint( line, plane );
  test.equivalent( gotPoint,  expected );

  /* */

  test.case = 'Line ( normalized to 1 ) no intersection';

  var line = [ 0, 0, 0, 0, 0.194, 0 ];
  var plane = [ 1, 3, 0, 0 ];
  var expected = 0;

  var gotPoint = _.linePointDir.planeIntersectionPoint( line, plane );
  test.equivalent( gotPoint,  expected );

  /* */

  test.case = 'plane parallel to line';

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0.5, 0, 1, 0 ];
  var expected = 0;

  var gotPoint = _.linePointDir.planeIntersectionPoint( line, plane );
  test.identical( gotPoint,  expected );

  /* */

  test.case = 'plane parallel contains line';

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 0, 1, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0 ] );

  var gotPoint = _.linePointDir.planeIntersectionPoint( line, plane );
  test.identical( gotPoint,  expected );

  /* */

  test.case = 'plane contains line origin';

  var line = [ 0, 0, 0, 0, 3, 2 ];
  var plane = [ 0, 0, 1, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0 ] );

  var gotPoint = _.linePointDir.planeIntersectionPoint( line, plane );
  test.identical( gotPoint,  expected );

  /* */

  test.case = 'plane perpendicular to line';

  var line = [ 3, 4, 4, 0, 0, 2 ];
  var plane = [ 0, 0, 0, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 4, 0 ] );

  var gotPoint = _.linePointDir.planeIntersectionPoint( line, plane );
  test.identical( gotPoint,  expected );

  /* */

  test.case = 'plane parallel to line 4D';

  var line = [ 0, 2, 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 0, 1, 0, 0 ];
  var expected = 0;

  var gotPoint = _.linePointDir.planeIntersectionPoint( line, plane );
  test.identical( gotPoint,  expected );

  /* */

  test.case = 'plane perpendicular to line 4D';

  var line = [ 0, 1, 2, 3, 0, 0, 0, 2 ];
  var plane = [ 0, 0, 0, 0, 3 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 1, 2, 0 ] );

  var gotPoint = _.linePointDir.planeIntersectionPoint( line, plane );
  test.identical( gotPoint,  expected );

  /* */

  test.case = 'plane and line intersect 4D';

  var line = [ 0, 1, 2, 3, 0, 0, 0, 2 ];
  var plane = [ 0, 0, 1, 2, 3 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 1, 2, - ( 1 + 2/3 ) ] );

  var gotPoint = _.linePointDir.planeIntersectionPoint( line, plane );
  test.equivalent( gotPoint,  expected );

  /* */

  test.case = 'dstPoint is vector';

  var line = [ 3, 4, 4, 0, 0, 2 ];
  var plane = [ 0, 0, 0, 1 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 3, 4, 0 ] );

  var gotPoint = _.linePointDir.planeIntersectionPoint( line, plane, _.linePointDir.tools.vectorAdapter.from( [ 0, 0, 0 ] ) );
  test.identical( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePointDir.planeIntersectionPoint( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeIntersectionPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeIntersectionPoint( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeIntersectionPoint( [ 1, 1, 1, 2, 2, 2 ], 'plane') );
  test.shouldThrowErrorSync( () => _.linePointDir.planeIntersectionPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeIntersectionPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeIntersectionPoint( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeIntersectionPoint( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeIntersectionPoint( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeIntersectionPoint( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4, 5, 6 ] ) );

}

planeIntersectionPoint.accuracy = 1e-6;

//

function planeDistance( test )
{

  /* */

  test.case = 'Line and plane remain unchanged';

  var line = [  - 1, - 1, -1, 1, 1, 1 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = 0;

  var gotDistance = _.linePointDir.planeDistance( line, plane );
  test.identical( gotDistance, expected );

  var oldLine = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( line, oldLine );

  var oldPlane = [ 1, 1, 0, 0 ];
  test.identical( plane, oldPlane );

  /* */

  test.case = 'Null line - empty plane';

  var line = null;
  var plane = [ 1, 1, 0, 0 ];
  var expected = 1;

  var gotDistance = _.linePointDir.planeDistance( line, plane );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'point line - no intersection';

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = 2;

  var gotDistance = _.linePointDir.planeDistance( line, plane );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'point line in plane';

  var line = [ - 1, 2, 3, 0, 0, 0 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = 0;

  var gotDistance = _.linePointDir.planeDistance( line, plane );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line and plane intersect';

  var line = [ -2, -2, -2, 2, 2, 2 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = 0;

  var gotDistance = _.linePointDir.planeDistance( line, plane );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Negative factor';

  var line = [ 0, -6, 4, 1, 1, 0 ];
  var plane = [ 3, 1, 0, 0 ];
  var expected = 0;

  var gotDistance = _.linePointDir.planeDistance( line, plane );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) intersection';

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var plane = [ - 2, 0, 2, 0 ];
  var expected = 0;

  var gotDistance = _.linePointDir.planeDistance( line, plane );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'plane parallel to line';

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0.5, 0, 1, 0 ];
  var expected = 0.5;

  var gotDistance = _.linePointDir.planeDistance( line, plane );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'plane parallel to line opposite side';

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0.5, 0, - 1, 0 ];
  var expected = 0.5;

  var gotDistance = _.linePointDir.planeDistance( line, plane );
  test.identical( gotDistance, expected );


  /* */

  test.case = 'plane parallel contains line';

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 0, 1, 0 ];
  var expected = 0;

  var gotDistance = _.linePointDir.planeDistance( line, plane );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'plane perpendicular to line';

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.linePointDir.planeDistance( line, plane );
  test.identical( gotDistance, expected );


  /* */

  test.case = 'plane parallel to line 4D';

  var line = [ 1, 2, 3, 4, 0, 0, 0, 2 ];
  var plane = [ 0, 0, 1, 0, 0 ];
  var expected = 2;

  var gotDistance = _.linePointDir.planeDistance( line, plane );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'plane perpendicular to line 4D';

  var line = [ 0, 0, 0, 0, 0, 0, 2, 0 ];
  var plane = [ 0, 0, 0, 1, 0 ];
  var expected = 0;

  var gotDistance = _.linePointDir.planeDistance( line, plane );
  test.identical( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePointDir.planeDistance( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeDistance( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeDistance( [ 1, 1, 1, 2, 2, 2 ], 'plane') );
  test.shouldThrowErrorSync( () => _.linePointDir.planeDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeDistance( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeDistance( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeDistance( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeDistance( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeDistance( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4, 5, 6 ] ) );

}

//

function planeClosestPoint( test )
{

  /* */

  test.case = 'Line and plane remain unchanged';

  var line = [  - 1, - 1, -1, 1, 1, 1 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = 0;

  var gotPoint = _.linePointDir.planeClosestPoint( line, plane );
  test.identical( gotPoint, expected );

  var oldLine = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( line, oldLine );

  var oldPlane = [ 1, 1, 0, 0 ];
  test.identical( plane, oldPlane );

  /* */

  test.case = 'Null line - empty plane';

  var line = null;
  var plane = [ 1, 1, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0 ] );

  var gotPoint = _.linePointDir.planeClosestPoint( line, plane );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'point line - no intersection';

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 1, 2, 3 ] );

  var gotPoint = _.linePointDir.planeClosestPoint( line, plane );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'point line in plane';

  var line = [ - 1, 2, 3, 0, 0, 0 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = 0;

  var gotPoint = _.linePointDir.planeClosestPoint( line, plane );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Line and plane intersect';

  var line = [ -2, -2, -2, 2, 2, 2 ];
  var plane = [ 1, 1, 0, 0 ];
  var expected = 0;

  var gotPoint = _.linePointDir.planeClosestPoint( line, plane );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Negative factor';

  var line = [ 0, -6, 4, 1, 1, 0 ];
  var plane = [ 3, 1, 0, 0 ];
  var expected = 0;

  var gotPoint = _.linePointDir.planeClosestPoint( line, plane );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) intersection';

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var plane = [ - 2, 0, 2, 0 ];
  var expected = 0;

  var gotPoint = _.linePointDir.planeClosestPoint( line, plane );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) parallel';

  var line = [ 0, 0, 0, 0, 0.194, 0 ];
  var plane = [ 1, 3, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0 ] );

  var gotPoint = _.linePointDir.planeClosestPoint( line, plane );
  test.equivalent( gotPoint, expected );

  /* */

  test.case = 'plane parallel to line';

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0.5, 0, 1, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0 ] );

  var gotPoint = _.linePointDir.planeClosestPoint( line, plane );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'plane parallel contains line';

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 0, 1, 0 ];
  var expected = 0;

  var gotPoint = _.linePointDir.planeClosestPoint( line, plane );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'plane perpendicular to line';

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotPoint = _.linePointDir.planeClosestPoint( line, plane );
  test.identical( gotPoint, expected );


  /* */

  test.case = 'plane parallel to line 4D';

  var line = [ 1, 2, 3, 4, 0, 0, 0, 2 ];
  var plane = [ 0, 0, 1, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 1, 2, 3, 4 ] );

  var gotPoint = _.linePointDir.planeClosestPoint( line, plane );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'plane perpendicular to line 4D';

  var line = [ 0, 0, 0, 0, 0, 0, 2, 0 ];
  var plane = [ 0, 0, 0, 1, 0 ];
  var expected = 0;

  var gotPoint = _.linePointDir.planeClosestPoint( line, plane );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'dstPoint is array';

  var line = [ 0, -6, 24, 0, 1, 0 ];
  var plane = [ 3, 1, 0, 0 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 0, -6, 24 ] );

  var gotPoint = _.linePointDir.planeClosestPoint( line, plane, dstPoint );
  test.identical( gotPoint, expected );

  /* */

  test.case = 'dstPoint is vector';

  var line = [ 0, -6, 24, 0, 1, 0 ];
  var plane = [ 3, 1, 0, 0 ];
  var dstPoint = _.linePointDir.tools.vectorAdapter.from( [ 0, 0, 0 ] );
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0, -6, 24 ] );

  var gotPoint = _.linePointDir.planeClosestPoint( line, plane, dstPoint );
  test.identical( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePointDir.planeClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeClosestPoint( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeClosestPoint( [ 1, 1, 1, 2, 2, 2 ], 'plane') );
  test.shouldThrowErrorSync( () => _.linePointDir.planeClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeClosestPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeClosestPoint( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeClosestPoint( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeClosestPoint( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.planeClosestPoint( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4, 5, 6 ] ) );

}

//

function rayIntersects( test )
{
  /* */

  test.case = 'Source ray and line remain unchanged';

  var srcLine = [ 0, 0, 1, 1 ];
  var srcRay = [ 0, 0, 2, 2 ];
  var expected = true;

  var isIntersection = _.linePointDir.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  var oldSrcLine = [ 0, 0, 1, 1 ];
  test.equivalent( srcLine, oldSrcLine );

  var oldSrcRay = [ 0, 0, 2, 2 ];
  test.equivalent( srcRay, oldSrcRay );

  /* */

  test.case = 'Line and ray are the same';

  var srcLine = [ 0, 0, 1, 1 ];
  var srcRay = [ 0, 0, 1, 1 ];
  var expected = true;

  var isIntersection = _.linePointDir.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Line and ray are parallel ( different origin - same direction )';

  var srcLine = [ 0, 0, 1, 1 ];
  var srcRay = [ 3, 7, 1, 1 ];
  var expected = false;

  var isIntersection = _.linePointDir.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Line and ray are parallel ( different origin - different direction )';

  var srcLine = [ 0, 0, 1, 1 ];
  var srcRay = [ 3, 7, 7, 7 ];
  var expected = false;

  var isIntersection = _.linePointDir.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Line and ray intersect with line´s negative factor';

  var srcLine = [ 5, 5, 1, 1 ];
  var srcRay = [ 3, 0, 1, 2.5 ];
  var expected = true;

  var isIntersection = _.linePointDir.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Line and ray don´t intersect with ray´s negative factor';

  var srcLine = [ 3, 0, 1, 2.5 ];
  var srcRay = [ 6, 6, 1, 1 ];
  var expected = false;

  var isIntersection = _.linePointDir.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Line and ray intersect in their origin';

  var srcLine = [ 3, 7, 1, 0 ];
  var srcRay = [ 3, 7, 0, 1 ];
  var expected = true;

  var isIntersection = _.linePointDir.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Line and ray intersect ';

  var srcLine = [ 0, 0, 1, 0 ];
  var srcRay = [ -2, -6, 1, 2 ];
  var expected = true;

  var isIntersection = _.linePointDir.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Line and ray are perpendicular ';

  var srcLine = [ -3, 0, 1, 0 ];
  var srcRay = [ 0, -2, 0, 1 ];
  var expected = true;

  var isIntersection = _.linePointDir.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Line and ray don´t intersect 3D';

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var srcRay = [ 3, 0, 1, 2, 2, -1 ];
  var expected = false;

  var isIntersection = _.linePointDir.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Line and ray intersect 3D';

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var srcRay = [ 3, 7, 1, 3, 1, 4 ];
  var expected = true;

  var isIntersection = _.linePointDir.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Line and ray don´t intersect 4D';

  var srcLine = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var srcRay = [ 3, 0, 1, 4, 2, 2, 2, -1 ];
  var expected = false;

  var isIntersection = _.linePointDir.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  /* */

  test.case = 'Line and ray intersect 4D';

  var srcLine = [ 0, 0, 0, 1, 1, 1, 1, 1 ];
  var srcRay = [ 3, 7, 1, 4, 3, 1, 4, 3 ];
  var expected = true;

  var isIntersection = _.linePointDir.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersects( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersects( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersects( [ 1, 1, 2, 2 ], 'ray') );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersects( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersects( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersects( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersects( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function rayIntersectionPoint( test )
{
  /* */

  test.case = 'Source line and ray remain unchanged';

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstRay = [ 0, 0, 0, 2, 2, 2 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0 ] );

  var gotIntersectionPoint = _.linePointDir.rayIntersectionPoint( srcLine, tstRay );
  test.identical( gotIntersectionPoint, expected );

  var oldSrcLine = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( srcLine, oldSrcLine );

  var oldTstRay = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( tstRay, oldTstRay );

  /* */

  test.case = 'Line and ray are parallel ( different origin - same direction )';

  var srcLine = [ 0, 0, 0, 0, 0, 1 ];
  var tstRay = [ 3, 7, 1, 0, 0, 1 ];
  var expected = 0;

  var gotIntersectionPoint = _.linePointDir.rayIntersectionPoint( srcLine, tstRay );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'Line and ray are parallel ( different origin - different direction )';

  var srcLine = [ 3, 7, 1, 0, 0, 7 ];
  var tstRay = [ 0, 0, 0, 0, 0, 0.5 ];
  var expected = 0;

  var gotIntersectionPoint = _.linePointDir.rayIntersectionPoint( srcLine, tstRay );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'Line and ray are parallel and intersect';

  var srcLine = [ 3, 7, 1, 0, 0, 7 ];
  var tstRay = [ 3, 7, 7, 0, 0, 0.5 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 7, 7 ] );

  var gotIntersectionPoint = _.linePointDir.rayIntersectionPoint( srcLine, tstRay );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'srcLine is a point not in ray';

  var srcLine = [ 3, 7, 1, 0, 0, 0 ];
  var tstRay = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotIntersectionPoint = _.linePointDir.rayIntersectionPoint( srcLine, tstRay );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'srcLine is a point in ray';

  var srcLine = [ 3, 3, 3, 0, 0, 0 ];
  var tstRay = [ 0, 0, 0, 1, 1, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 3, 3 ] );

  var gotIntersectionPoint = _.linePointDir.rayIntersectionPoint( srcLine, tstRay );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'tstRay is a point not in line';

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstRay = [ 3, 7, 1, 0, 0, 0 ];
  var expected = 0;

  var gotIntersectionPoint = _.linePointDir.rayIntersectionPoint( srcLine, tstRay );
  test.equivalent( gotIntersectionPoint, expected );

  /* */

  test.case = 'tstRay is a point in line';

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstRay = [ -4, -4, -4, 0, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ -4, -4, -4 ] );

  var gotIntersectionPoint = _.linePointDir.rayIntersectionPoint( srcLine, tstRay );
  test.equivalent( gotIntersectionPoint, expected );

  /* */

  test.case = 'Line and ray are the same';

  var srcLine = [ 0, 4, 2, 1, 1, 1 ];
  var tstRay = [ 0, 4, 2, 1, 1, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 4, 2 ] );

  var gotIntersectionPoint = _.linePointDir.rayIntersectionPoint( srcLine, tstRay );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'Line and ray intersect 4D';

  var srcLine = [ 0, 0, 2, 1, 0, 1, 0, 0 ];
  var tstRay = [ 3, 4, 2, 1, -1, 0, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 4, 2, 1 ] );

  var gotIntersectionPoint = _.linePointDir.rayIntersectionPoint( srcLine, tstRay );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'Line and ray don´t intersect 2D - parallel';

  var srcLine = [ 0, 0, 2, 0 ];
  var tstRay = [ - 3, - 4, 1, 0 ];
  var expected = 0;

  var gotIntersectionPoint = _.linePointDir.rayIntersectionPoint( srcLine, tstRay );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'Line and ray intersect with line´s positive factor 2D';

  var srcLine = [ 0, 0, -2, 0 ];
  var tstRay = [ - 3, - 4, 0, 1 ];
  var expected = _.linePointDir.tools.long.make( [ -3, 0 ] );

  var gotIntersectionPoint = _.linePointDir.rayIntersectionPoint( srcLine, tstRay );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'Line and ray intersect with line´s negative factor 2D';

  var srcLine = [ 0, 0, 2, 0 ];
  var tstRay = [ - 3, - 4, 0, 1 ];
  var expected = _.linePointDir.tools.long.make( [ -3, 0 ] );

  var gotIntersectionPoint = _.linePointDir.rayIntersectionPoint( srcLine, tstRay );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'Line and ray don´t intersect with ray´s negative factor 2D';

  var srcLine = [ - 3, - 4, 0, 1 ];
  var tstRay = [ 0, 0, 2, 0 ];
  var expected = 0;

  var gotIntersectionPoint = _.linePointDir.rayIntersectionPoint( srcLine, tstRay );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'Line and ray are perpendicular and intersect';

  var srcLine = [ 5, 7, 1, 1, 0, 0 ];
  var tstRay = [ 3, 7, 1, 0, 0, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 7, 1 ] );

  var gotIntersectionPoint = _.linePointDir.rayIntersectionPoint( srcLine, tstRay );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'Line and ray are perpendicular and don´t intersect';

  var srcLine = [ 0, 0, -3, 0, 0, 1 ];
  var tstRay = [ 3, 0, 0, 1, 1, 0 ];
  var expected = 0;

  var gotIntersectionPoint = _.linePointDir.rayIntersectionPoint( srcLine, tstRay );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'Line and ray are parallel to x';

  var srcLine = [ 3, 7, 1, 1, 0, 0 ];
  var tstRay = [ 3, 7, 2, 1, 0, 0 ];
  var expected = 0;

  var gotIntersectionPoint = _.linePointDir.rayIntersectionPoint( srcLine, tstRay );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'srcLine is null';

  var srcLine = null;
  var tstRay = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = 0;

  var gotIntersectionPoint = _.linePointDir.rayIntersectionPoint( srcLine, tstRay );
  test.identical( gotIntersectionPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersectionPoint( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersectionPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersectionPoint( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersectionPoint( [ 0, 0 ], 'ray') );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersectionPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersectionPoint( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersectionPoint( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersectionPoint( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersectionPoint( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersectionPoint( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function rayIntersectionFactors( test )
{
  /* */

  test.case = 'Source line and ray remain unchanged';

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstRay = [ 0, 0, 0, 2, 2, 2 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0, 0 ] );

  var gotIntersectionFactors = _.linePointDir.rayIntersectionFactors( srcLine, tstRay );
  test.identical( gotIntersectionFactors, expected );

  var oldSrcLine = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( srcLine, oldSrcLine );

  var oldTstRay = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( tstRay, oldTstRay );

  /* */

  test.case = 'Line and ray are parallel ( different origin - same direction )';

  var srcLine = [ 0, 0, 0, 0, 0, 1 ];
  var tstRay = [ 3, 7, 1, 0, 0, 1 ];
  var expected = 0;

  var gotIntersectionFactors = _.linePointDir.rayIntersectionFactors( srcLine, tstRay );
  test.identical( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and ray are parallel ( different origin - different direction )';

  var srcLine = [ 3, 7, 1, 0, 0, 7 ];
  var tstRay = [ 0, 0, 0, 0, 0, 0.5 ];
  var expected = 0;

  var gotIntersectionFactors = _.linePointDir.rayIntersectionFactors( srcLine, tstRay );
  test.identical( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and ray are parallel and intersect in the origin';

  var srcLine = [ 3, 7, 1, 0, 0, -7 ];
  var tstRay = [ 3, 7, 1, 0, 0, 0.5 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0, 0 ] );

  var gotIntersectionFactors = _.linePointDir.rayIntersectionFactors( srcLine, tstRay );
  test.identical( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and ray are parallel and intersect';

  var srcLine = [ 3, 7, 1, 0, 0, 7 ];
  var tstRay = [ 3, 7, 7, 0, 0, 0.5 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0.8571428571428571, 0 ] );

  var gotIntersectionFactors = _.linePointDir.rayIntersectionFactors( srcLine, tstRay );
  test.equivalent( gotIntersectionFactors, expected );

  /* */

  test.case = 'srcLine is a point not in ray';

  var srcLine = [ 3, 7, 1, 0, 0, 0 ];
  var tstRay = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotIntersectionFactors = _.linePointDir.rayIntersectionFactors( srcLine, tstRay );
  test.identical( gotIntersectionFactors, expected );

  /* */

  test.case = 'srcLine is a point in ray';

  var srcLine = [ 3, 3, 3, 0, 0, 0 ];
  var tstRay = [ 0, 0, 0, 1, 1, 1 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0, 3 ] );

  var gotIntersectionFactors = _.linePointDir.rayIntersectionFactors( srcLine, tstRay );
  test.identical( gotIntersectionFactors, expected );

  /* */

  test.case = 'tstRay is a point not in line';

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstRay = [ 3, 7, 1, 0, 0, 0 ];
  var expected = 0;

  var gotIntersectionFactors = _.linePointDir.rayIntersectionFactors( srcLine, tstRay );
  test.equivalent( gotIntersectionFactors, expected );

  /* */

  test.case = 'tstRay is a point in line';

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstRay = [ -4, -4, -4, 0, 0, 0 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ -4, 0 ] );

  var gotIntersectionFactors = _.linePointDir.rayIntersectionFactors( srcLine, tstRay );
  test.equivalent( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and ray are the same';

  var srcLine = [ 0, 4, 2, 1, 1, 1 ];
  var tstRay = [ 0, 4, 2, 1, 1, 1 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0, 0 ] );

  var gotIntersectionFactors = _.linePointDir.rayIntersectionFactors( srcLine, tstRay );
  test.identical( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and ray intersect 4D';

  var srcLine = [ 0, 0, 2, 1, 0, 1, 0, 0 ];
  var tstRay = [ 3, 4, 2, 1, -1, 0, 0, 0 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 4, 3 ] );

  var gotIntersectionFactors = _.linePointDir.rayIntersectionFactors( srcLine, tstRay );
  test.equivalent( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and ray don´t intersect 2D - parallel';

  var srcLine = [ 0, 0, 2, 0 ];
  var tstRay = [ - 3, - 4, 1, 0 ];
  var expected = 0;

  var gotIntersectionFactors = _.linePointDir.rayIntersectionFactors( srcLine, tstRay );
  test.identical( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and ray intersect with line´s positive factor 2D';

  var srcLine = [ 0, 0, -2, 0 ];
  var tstRay = [ - 3, - 4, 0, 1 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 1.5, 4 ] );

  var gotIntersectionFactors = _.linePointDir.rayIntersectionFactors( srcLine, tstRay );
  test.equivalent( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and ray intersect with line´s negative factor 2D';

  var srcLine = [ 0, 0, 2, 0 ];
  var tstRay = [ - 3, - 4, 0, 1 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ -1.5, 4 ] );

  var gotIntersectionFactors = _.linePointDir.rayIntersectionFactors( srcLine, tstRay );
  test.equivalent( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and ray don´t intersect with ray´s negative factor 2D';

  var srcLine = [ - 3, - 4, 0, 1 ];
  var tstRay = [ 0, 0, 2, 0 ];
  var expected = 0;

  var gotIntersectionFactors = _.linePointDir.rayIntersectionFactors( srcLine, tstRay );
  test.identical( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and ray are perpendicular and intersect';

  var srcLine = [ 5, 7, 1, 1, 0, 0 ];
  var tstRay = [ 3, 7, 1, 0, 0, 1 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ -2, 0 ] );

  var gotIntersectionFactors = _.linePointDir.rayIntersectionFactors( srcLine, tstRay );
  test.equivalent( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and ray are perpendicular and don´t intersect';

  var srcLine = [ 0, 0, -3, 0, 0, 1 ];
  var tstRay = [ 3, 0, 0, 1, 1, 0 ];
  var expected = 0;

  var gotIntersectionFactors = _.linePointDir.rayIntersectionFactors( srcLine, tstRay );
  test.identical( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and ray are parallel to x';

  var srcLine = [ 3, 7, 1, 1, 0, 0 ];
  var tstRay = [ 3, 7, 2, 1, 0, 0 ];
  var expected = 0;

  var gotIntersectionFactors = _.linePointDir.rayIntersectionFactors( srcLine, tstRay );
  test.identical( gotIntersectionFactors, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersectionFactors( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersectionFactors( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersectionFactors( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersectionFactors( [ 0, 0 ], 'ray') );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersectionFactors( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersectionFactors( null, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersectionFactors( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersectionFactors( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersectionFactors( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersectionFactors( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayIntersectionFactors( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function rayDistance( test )
{
  /* */

  test.case = 'Source line and ray remain unchanged';

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstRay = [ 0, 0, 0, 2, 2, 2 ];
  var expected = 0;

  var gotDistance = _.linePointDir.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  var oldSrcLine = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( srcLine, oldSrcLine );

  var oldTstRay = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( tstRay, oldTstRay );

  /* */

  test.case = 'Line and ray are parallel ( different origin - same direction )';

  var srcLine = [ 0, 0, 0, 0, 0, 1 ];
  var tstRay = [ 3, 7, 1, 0, 0, 1 ];
  var expected = Math.sqrt( 58 );

  var gotDistance = _.linePointDir.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line and ray are parallel ( different origin - different direction )';

  var srcLine = [ 3, 7, 1, 0, 0, 7 ];
  var tstRay = [ 0, 0, 0, 0, 0, 0.5 ];
  var expected = Math.sqrt( 58 );

  var gotDistance = _.linePointDir.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line and ray are parallel ( different origin - opposite direction )';

  var srcLine = [ 0, 0, 0, 1, 0, 0 ];
  var tstRay = [ 3, 7, 1, - 7, 0, 0 ];
  var expected = Math.sqrt( 50 );

  var gotDistance = _.linePointDir.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'srcLine is a point';

  var srcLine = [ 3, 7, 1, 0, 0, 0 ];
  var tstRay = [ 0, 0, 0, 1, 1, 1 ];
  var expected =  Math.sqrt( 168 / 9 );

  var gotDistance = _.linePointDir.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'tstRay is a point';

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstRay = [ 3, 7, 1, 0, 0, 0 ];
  var expected = Math.sqrt( 168 / 9 );

  var gotDistance = _.linePointDir.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line and ray are the same';

  var srcLine = [ 0, 4, 2, 1, 1, 1 ];
  var tstRay = [ 0, 4, 2, 1, 1, 1 ];
  var expected = 0;

  var gotDistance = _.linePointDir.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line and ray intersect 4D';

  var srcLine = [ 0, 0, 2, 1, 0, 1, 0, 0 ];
  var tstRay = [ 3, 4, 2, 1, -1, 0, 0, 0 ];
  var expected = 0;

  var gotDistance = _.linePointDir.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line and ray don´t intersect 2D - parallel';

  var srcLine = [ 0, 0, 2, 0 ];
  var tstRay = [ - 3, - 4, 1, 0 ];
  var expected = 4;

  var gotDistance = _.linePointDir.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line and ray intersect with line´s negative factor 2D';

  var srcLine = [ 0, 0, 2, 0 ];
  var tstRay = [ - 3, - 4, 0, 1 ];
  var expected = 0;

  var gotDistance = _.linePointDir.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line and ray don´t intersect with ray´s negative factor 2D';

  var srcLine = [ - 3, - 4, 0, 1 ];
  var tstRay = [ 0, 0, 2, 0 ];
  var expected = 3;

  var gotDistance = _.linePointDir.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line and ray are perpendicular and intersect';

  var srcLine = [ 3, 7, 1, 1, 0, 0 ];
  var tstRay = [ 3, 7, 1, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.linePointDir.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line and ray are perpendicular and don´t intersect';

  var srcLine = [ 0, 0, -3, 0, 0, 1 ];
  var tstRay = [ 3, 0, 0, 1, 1, 0 ];
  var expected = 3;

  var gotDistance = _.linePointDir.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line and ray are parallel to x axis';

  var srcLine = [ 3, 7, 1, 1, 0, 0 ];
  var tstRay = [ 3, 7, 2, 1, 0, 0 ];
  var expected = 1;

  var gotDistance = _.linePointDir.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line and ray are parallel but in a opposite direction';

  var srcLine = [ 3, 7, 1, 1, 0, 0 ];
  var tstRay = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = 1;

  var gotDistance = _.linePointDir.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'srcLine is null';

  var srcLine = null;
  var tstRay = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = Math.sqrt( 53 );

  var gotDistance = _.linePointDir.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.rayDistance( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayDistance( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayDistance( [ 0, 0 ], 'ray') );
  test.shouldThrowErrorSync( () => _.linePointDir.rayDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayDistance( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayDistance( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayDistance( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayDistance( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayDistance( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function rayClosestPoint( test )
{
  /* */

  test.case = 'Source line and ray remain unchanged';

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstRay = [ 0, 0, 0, 2, 2, 2 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  var oldSrcLine = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( srcLine, oldSrcLine );

  var oldTstRay = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( tstRay, oldTstRay );

  /* */

  test.case = 'Line and ray are parallel ( different origin - same direction )';

  var srcLine = [ 0, 0, 0, 0, 0, 1 ];
  var tstRay = [ 3, 7, 1, 0, 0, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 1 ] );

  var gotClosestPoint = _.linePointDir.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line and ray are parallel ( different origin - different direction )';

  var srcLine = [ 3, 7, 1, 0, 0, 7 ];
  var tstRay = [ 0, 0, 0, 0, 0, 0.5 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 7, 0 ] );

  var gotClosestPoint = _.linePointDir.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line and ray are parallel ( different origin - opposite direction )';

  var srcLine = [ 0, 0, 0, 1, 0, 0 ];
  var tstRay = [ 3, 7, 1, - 7, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 0, 0 ] );

  var gotClosestPoint = _.linePointDir.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'srcLine is a point';

  var srcLine = [ 3, 7, 1, 0, 0, 0 ];
  var tstRay = [ 0, 0, 0, 1, 1, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 7, 1 ] );

  var gotClosestPoint = _.linePointDir.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'tstRay is a point';

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstRay = [ 3, 7, 1, 0, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 3.6666666, 3.6666666, 3.6666666 ] );

  var gotClosestPoint = _.linePointDir.rayClosestPoint( srcLine, tstRay );
  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'Line and ray are the same';

  var srcLine = [ 0, 4, 2, 1, 1, 1 ];
  var tstRay = [ 0, 4, 2, 1, 1, 1 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line and ray intersect 4D';

  var srcLine = [ 0, 0, 2, 1, 0, 1, 0, 0 ];
  var tstRay = [ 3, 4, 2, 1, -1, 0, 0, 0 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line and ray don´t intersect 2D - parallel';

  var srcLine = [ 0, 0, 2, 0 ];
  var tstRay = [ - 3, - 4, 1, 0 ];
  var expected = _.linePointDir.tools.long.make( [ -3, 0 ] );

  var gotClosestPoint = _.linePointDir.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line and ray intersect with line´s positive factor 2D';

  var srcLine = [ 0, 0, -2, 0 ];
  var tstRay = [ - 3, - 4, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line and ray intersect with line´s negative factor 2D';

  var srcLine = [ 0, 0, 2, 0 ];
  var tstRay = [ - 3, - 4, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line and ray don´t intersect with ray´s negative factor 2D';

  var srcLine = [ - 3, - 4, 0, 1 ];
  var tstRay = [ 0, 0, 2, 0 ];
  var expected = _.linePointDir.tools.long.make( [ -3, 0 ] );

  var gotClosestPoint = _.linePointDir.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line and ray are perpendicular and intersect';

  var srcLine = [ 3, 7, 1, 1, 0, 0 ];
  var tstRay = [ 3, 7, 1, 0, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line and ray are perpendicular and don´t intersect';

  var srcLine = [ 0, 0, -3, 0, 0, 1 ];
  var tstRay = [ 3, 0, 0, 1, 1, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0 ] );

  var gotClosestPoint = _.linePointDir.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line and ray are parallel to x';

  var srcLine = [ 3, 7, 1, 1, 0, 0 ];
  var tstRay = [ 3, 7, 2, 1, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 7, 1 ] );

  var gotClosestPoint = _.linePointDir.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line and ray are parallel but in a opposite direction';

  var srcLine = [ 3, 7, 1, 1, 0, 0 ];
  var tstRay = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 7, 1 ] );

  var gotClosestPoint = _.linePointDir.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'srcLine is null';

  var srcLine = null;
  var tstRay = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0 ] );

  var gotClosestPoint = _.linePointDir.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.rayClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayClosestPoint( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayClosestPoint( [ 0, 0 ], 'ray') );
  test.shouldThrowErrorSync( () => _.linePointDir.rayClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayClosestPoint( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayClosestPoint( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayClosestPoint( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayClosestPoint( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.rayClosestPoint( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function segmentIntersectionPoint( test )
{
  /* */

  test.case = 'Source line and segment remain unchanged';

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstSegment = [ 0, 0, 0, 2, 2, 2 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0 ] );

  var gotIntersectionPoint = _.linePointDir.segmentIntersectionPoint( srcLine, tstSegment );
  test.identical( gotIntersectionPoint, expected );

  var oldSrcLine = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( srcLine, oldSrcLine );

  var oldTstSegment = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( tstSegment, oldTstSegment );

  /* */

  test.case = 'Line and segment are parallel ( different origin - same direction )';

  var srcLine = [ 0, 0, 0, 0, 0, 1 ];
  var tstSegment = [ 3, 7, 1, 3, 7, 7 ];
  var expected = 0;

  var gotIntersectionPoint = _.linePointDir.segmentIntersectionPoint( srcLine, tstSegment );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'Line and segment are parallel ( different origin - different direction )';

  var srcLine = [ 3, 7, 1, 0, 0, 7 ];
  var tstSegment = [ 0, 0, 0, 0, 0, 0.5 ];
  var expected = 0;

  var gotIntersectionPoint = _.linePointDir.segmentIntersectionPoint( srcLine, tstSegment );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'srcLine is a point - not contained';

  var srcLine = [ 3, 7, 1, 0, 0, 0 ];
  var tstSegment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotIntersectionPoint = _.linePointDir.segmentIntersectionPoint( srcLine, tstSegment );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'srcLine is a point - contained';

  var srcLine = [ 0.5, 0.5, 0.5, 0, 0, 0 ];
  var tstSegment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 0.5, 0.5, 0.5 ] );

  var gotIntersectionPoint = _.linePointDir.segmentIntersectionPoint( srcLine, tstSegment );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'tstSegment is a point - not contained';

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstSegment = [ 3, 7, 1, 3, 7, 1 ];
  var expected = 0;

  var gotIntersectionPoint = _.linePointDir.segmentIntersectionPoint( srcLine, tstSegment );
  test.equivalent( gotIntersectionPoint, expected );

  /* */

  test.case = 'tstSegment is a point - contained';

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstSegment = [ 7, 7, 7, 7, 7, 7 ];
  var expected = _.linePointDir.tools.long.make( [ 7, 7, 7 ] );

  var gotIntersectionPoint = _.linePointDir.segmentIntersectionPoint( srcLine, tstSegment );
  test.equivalent( gotIntersectionPoint, expected );

  /* */

  test.case = 'Line and segment are the same';

  var srcLine = [ 0, 4, 2, 1, 1, 1 ];
  var tstSegment = [ 0, 4, 2, 3, 7, 5 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 4, 2 ] );

  var gotIntersectionPoint = _.linePointDir.segmentIntersectionPoint( srcLine, tstSegment );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'Line and segment intersect 4D';

  var srcLine = [ 0, 0, 2, 1, 0, 1, 0, 0 ];
  var tstSegment = [ 3, 4, 2, 1, -3, 4, 2, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 4, 2, 1 ] );

  var gotIntersectionPoint = _.linePointDir.segmentIntersectionPoint( srcLine, tstSegment );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'Line and segment don´t intersect 2D - parallel';

  var srcLine = [ 0, 0, 2, 0 ];
  var tstSegment = [ - 3, - 4, 3, -4 ];
  var expected = 0;

  var gotIntersectionPoint = _.linePointDir.segmentIntersectionPoint( srcLine, tstSegment );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'Line and segment intersect with line´s negative factor 2D';

  var srcLine = [ 0, 0, 2, 0 ];
  var tstSegment = [ - 3, - 4, -3, 1 ];
  var expected = _.linePointDir.tools.long.make( [ -3, 0 ] );

  var gotIntersectionPoint = _.linePointDir.segmentIntersectionPoint( srcLine, tstSegment );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'Line and segment don´t intersect with segment´s negative factor 2D';

  var srcLine = [ - 3, - 4, 0, 1 ];
  var tstSegment = [ 0, 0, 2, 0 ];
  var expected = 0;

  var gotIntersectionPoint = _.linePointDir.segmentIntersectionPoint( srcLine, tstSegment );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'Line and segment are perpendicular and intersect';

  var srcLine = [ 5, 7, 1, 1, 0, 0 ];
  var tstSegment = [ 3, 7, 1, 3, 7, 8 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 7, 1 ] );

  var gotIntersectionPoint = _.linePointDir.segmentIntersectionPoint( srcLine, tstSegment );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'Line and segment are perpendicular and don´t intersect';

  var srcLine = [ 0, 0, -3, 0, 0, 1 ];
  var tstSegment = [ 3, 2, 0, -3, 2, 0 ];
  var expected = 0;

  var gotIntersectionPoint = _.linePointDir.segmentIntersectionPoint( srcLine, tstSegment );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'Line and segment are parallel to x';

  var srcLine = [ 3, 7, 1, 1, 0, 0 ];
  var tstSegment = [ 3, 7, 2, 9, 7, 2 ];
  var expected = 0;

  var gotIntersectionPoint = _.linePointDir.segmentIntersectionPoint( srcLine, tstSegment );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = 'srcLine is null';

  var srcLine = null;
  var tstSegment = [ 3, 7, 2, -3, 7, 2 ];
  var expected = 0;

  var gotIntersectionPoint = _.linePointDir.segmentIntersectionPoint( srcLine, tstSegment );
  test.identical( gotIntersectionPoint, expected );

  /* */

  test.case = '';

  var srcLine = [ 3, 7, 0, 0, 0, 0.5 ]
  var tstSegment  = [ 3, 7, 1, 3, 7, 7 ]
  var got = _.linePointDir.segmentIntersectionPoint( srcLine, tstSegment )
  test.identical( got, [] )

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.segmentIntersectionPoint( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentIntersectionPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentIntersectionPoint( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentIntersectionPoint( [ 0, 0 ], 'segment') );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentIntersectionPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentIntersectionPoint( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentIntersectionPoint( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentIntersectionPoint( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentIntersectionPoint( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentIntersectionPoint( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function segmentIntersectionFactors( test )
{
  /* */

  test.case = 'Source line and segment remain unchanged';

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstSegment = [ 0, 0, 0, 2, 2, 2 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0, 0 ] );

  var gotIntersectionFactors = _.linePointDir.segmentIntersectionFactors( srcLine, tstSegment );
  test.identical( gotIntersectionFactors, expected );

  var oldSrcLine = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( srcLine, oldSrcLine );

  var oldTstSegment = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( tstSegment, oldTstSegment );

  /* */

  test.case = 'Line and segment are parallel ( different origin - same direction )';

  var srcLine = [ 0, 0, 0, 0, 0, 1 ];
  var tstSegment = [ 3, 7, 1, 3, 7, 7 ];
  var expected = 0;

  var gotIntersectionFactors = _.linePointDir.segmentIntersectionFactors( srcLine, tstSegment );
  test.identical( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and segment are parallel ( different origin - different direction )';

  var srcLine = [ 3, 7, 1, 0, 0, 7 ];
  var tstSegment = [ 0, 0, 0, 0, 0, 0.5 ];
  var expected = 0;

  var gotIntersectionFactors = _.linePointDir.segmentIntersectionFactors( srcLine, tstSegment );
  test.identical( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and segment are parallel same origin';

  var srcLine = [ 3, 7, 1, 0, 0, 7 ];
  var tstSegment = [ 3, 7, 1, 3, 7, 8 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0, 0 ] );

  var gotIntersectionFactors = _.linePointDir.segmentIntersectionFactors( srcLine, tstSegment );
  test.identical( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and segment are parallel different origin';

  var srcLine = [ 3, 7, 4.5, 0, 0, 7 ];
  var tstSegment = [ 3, 7, 1, 3, 7, 8 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ -0.5, 0 ] );

  var gotIntersectionFactors = _.linePointDir.segmentIntersectionFactors( srcLine, tstSegment );
  test.equivalent( gotIntersectionFactors, expected );


  /* */

  test.case = 'srcLine is a point - not contained';

  var srcLine = [ 3, 7, 1, 0, 0, 0 ];
  var tstSegment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotIntersectionFactors = _.linePointDir.segmentIntersectionFactors( srcLine, tstSegment );
  test.identical( gotIntersectionFactors, expected );

  /* */

  test.case = 'srcLine is a point - contained';

  var srcLine = [ 0.5, 0.5, 0.5, 0, 0, 0 ];
  var tstSegment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0, 0.5 ] );

  var gotIntersectionFactors = _.linePointDir.segmentIntersectionFactors( srcLine, tstSegment );
  test.identical( gotIntersectionFactors, expected );

  /* */

  test.case = 'tstSegment is a point - not contained';

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstSegment = [ 3, 7, 1, 3, 7, 1 ];
  var expected = 0;

  var gotIntersectionFactors = _.linePointDir.segmentIntersectionFactors( srcLine, tstSegment );
  test.equivalent( gotIntersectionFactors, expected );

  /* */

  test.case = 'tstSegment is a point - contained';

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstSegment = [ 7, 7, 7, 7, 7, 7 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 7, 0 ] );

  var gotIntersectionFactors = _.linePointDir.segmentIntersectionFactors( srcLine, tstSegment );
  test.equivalent( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and segment are the same';

  var srcLine = [ 0, 4, 2, 1, 1, 1 ];
  var tstSegment = [ 0, 4, 2, 3, 7, 5 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0, 0 ] );

  var gotIntersectionFactors = _.linePointDir.segmentIntersectionFactors( srcLine, tstSegment );
  test.identical( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and segment intersect 4D';

  var srcLine = [ 0, 0, 2, 1, 0, 1, 0, 0 ];
  var tstSegment = [ 3, 4, 2, 1, -3, 4, 2, 1 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 4, 0.5 ] );

  var gotIntersectionFactors = _.linePointDir.segmentIntersectionFactors( srcLine, tstSegment );
  test.equivalent( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and segment don´t intersect 2D - parallel';

  var srcLine = [ 0, 0, 2, 0 ];
  var tstSegment = [ - 3, - 4, 3, -4 ];
  var expected = 0;

  var gotIntersectionFactors = _.linePointDir.segmentIntersectionFactors( srcLine, tstSegment );
  test.identical( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and segment intersect with line´s negative factor 2D';

  var srcLine = [ 0, 0, 2, 0 ];
  var tstSegment = [ - 3, - 4, -3, 1 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ -1.5, 0.8 ] );

  var gotIntersectionFactors = _.linePointDir.segmentIntersectionFactors( srcLine, tstSegment );
  test.equivalent( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and segment don´t intersect with segment´s negative factor 2D';

  var srcLine = [ - 3, - 4, 0, 1 ];
  var tstSegment = [ 0, 0, 2, 0 ];
  var expected = 0;

  var gotIntersectionFactors = _.linePointDir.segmentIntersectionFactors( srcLine, tstSegment );
  test.identical( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and segment are perpendicular and intersect';

  var srcLine = [ 5, 7, 1, 1, 0, 0 ];
  var tstSegment = [ 3, 7, 1, 3, 7, 8 ];
  var expected = _.linePointDir.tools.vectorAdapter.from( [ -2, 0 ] );

  var gotIntersectionFactors = _.linePointDir.segmentIntersectionFactors( srcLine, tstSegment );
  test.equivalent( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and segment are perpendicular and don´t intersect';

  var srcLine = [ 0, 0, -3, 0, 0, 1 ];
  var tstSegment = [ 3, 2, 0, -3, 2, 0 ];
  var expected = 0;

  var gotIntersectionFactors = _.linePointDir.segmentIntersectionFactors( srcLine, tstSegment );
  test.identical( gotIntersectionFactors, expected );

  /* */

  test.case = 'Line and segment are parallel to x';

  var srcLine = [ 3, 7, 1, 1, 0, 0 ];
  var tstSegment = [ 3, 7, 2, 9, 7, 2 ];
  var expected = 0;

  var gotIntersectionFactors = _.linePointDir.segmentIntersectionFactors( srcLine, tstSegment );
  test.identical( gotIntersectionFactors, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.segmentIntersectionFactors( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentIntersectionFactors( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentIntersectionFactors( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentIntersectionFactors( [ 0, 0 ], 'segment') );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentIntersectionFactors( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentIntersectionFactors( null, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentIntersectionFactors( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentIntersectionFactors( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentIntersectionFactors( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentIntersectionFactors( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentIntersectionFactors( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function segmentClosestPoint( test )
{
  /* */

  test.case = 'Source line and segment remain unchanged';

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstSegment = [ 0, 0, 0, 2, 2, 2 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  var oldSrcLine = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( srcLine, oldSrcLine );

  var oldTstSegment = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( tstSegment, oldTstSegment );

  /* */

  test.case = 'Line and segment are parallel ( different origin - same direction )';

  var srcLine = [ 0, 0, 0, 0, 0, 1 ];
  var tstSegment = [ 3, 7, 1, 3, 7, 7 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 1 ] );

  var gotClosestPoint = _.linePointDir.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line and segment are parallel ( different origin - different direction )';

  var srcLine = [ 3, 7, 1, 0, 0, 7 ];
  var tstSegment = [ 0, 0, 0, 0, 0, 0.5 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 7, 0 ] );

  var gotClosestPoint = _.linePointDir.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line and segment are parallel ( different origin - opposite direction )';

  var srcLine = [ 0, 0, 0, 1, 0, 0 ];
  var tstSegment = [ 3, 7, 1, - 7, 7, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 0, 0 ] );

  var gotClosestPoint = _.linePointDir.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'srcLine is a point';

  var srcLine = [ 3, 7, 1, 0, 0, 0 ];
  var tstSegment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 7, 1 ] );

  var gotClosestPoint = _.linePointDir.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'tstSegment is a point';

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstSegment = [ 3, 7, 1, 3, 7, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 3.6666666, 3.6666666, 3.6666666 ] );

  var gotClosestPoint = _.linePointDir.segmentClosestPoint( srcLine, tstSegment );
  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'Line and segment are the same';

  var srcLine = [ 0, 4, 2, 1, 1, 1 ];
  var tstSegment = [ 0, 4, 2, 3, 7, 5 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line and segment intersect 4D';

  var srcLine = [ 0, 0, 2, 1, 0, 1, 0, 0 ];
  var tstSegment = [ 3, 4, 2, 1, -3, 4, 2, 1 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line and segment don´t intersect 2D - parallel';

  var srcLine = [ 0, 0, 2, 0 ];
  var tstSegment = [ - 3, - 4, 3, -4 ];
  var expected = _.linePointDir.tools.long.make( [ -3, 0 ] );

  var gotClosestPoint = _.linePointDir.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line and segment intersect with line´s negative factor 2D';

  var srcLine = [ 0, 0, 2, 0 ];
  var tstSegment = [ - 3, - 4, -3, 1 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line and segment don´t intersect with segment´s negative factor 2D';

  var srcLine = [ - 3, - 4, 0, 1 ];
  var tstSegment = [ 0, 0, 2, 0 ];
  var expected = _.linePointDir.tools.long.make( [ -3, 0 ] );

  var gotClosestPoint = _.linePointDir.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line and segment are perpendicular and intersect';

  var srcLine = [ 3, 7, 1, 1, 0, 0 ];
  var tstSegment = [ 3, 7, 1, 3, 7, 8 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line and segment are perpendicular and don´t intersect';

  var srcLine = [ 0, 0, -3, 0, 0, 1 ];
  var tstSegment = [ 3, 2, 0, -3, 2, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0 ] );

  var gotClosestPoint = _.linePointDir.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line and segment are parallel to x';

  var srcLine = [ 3, 7, 1, 1, 0, 0 ];
  var tstSegment = [ 3, 7, 2, 9, 7, 2 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 7, 1 ] );

  var gotClosestPoint = _.linePointDir.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line and segment are parallel but in a opposite direction';

  var srcLine = [ 3, 7, 1, 1, 0, 0 ];
  var tstSegment = [ 3, 7, 2, -3, 7, 2 ];
  var expected = _.linePointDir.tools.long.make( [ 3, 7, 1 ] );

  var gotClosestPoint = _.linePointDir.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'srcLine is null';

  var srcLine = null;
  var tstSegment = [ 3, 7, 2, -3, 7, 2 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0 ] );

  var gotClosestPoint = _.linePointDir.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.linePointDir.segmentClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentClosestPoint( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentClosestPoint( [ 0, 0 ], 'segment') );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentClosestPoint( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentClosestPoint( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentClosestPoint( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentClosestPoint( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.segmentClosestPoint( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function sphereIntersects( test )
{

  /* */

  test.case = 'Line and sphere remain unchanged';

  var line = [  - 1, - 1, -1, 1, 1, 1 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.linePointDir.sphereIntersects( line, sphere );
  test.identical( gotBool, expected );

  var oldLine = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( line, oldLine );

  var oldSphere = [ 0, 0, 0, 1 ];
  test.identical( sphere, oldSphere );

  /* */

  test.case = 'Null line - empty sphere';

  var line = null;
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.linePointDir.sphereIntersects( line, sphere );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point line center of sphere';

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.linePointDir.sphereIntersects( line, sphere );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point line - no intersection';

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var sphere = [ 4, 3, 4, 1 ];
  var expected = false;

  var gotBool = _.linePointDir.sphereIntersects( line, sphere );
  test.identical( gotBool, expected );

  /* */

  test.case = 'point line in sphere';

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var sphere = [ 2, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.linePointDir.sphereIntersects( line, sphere );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line and sphere intersect';

  var line = [ -2, -2, -2, 2, 2, 2 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.linePointDir.sphereIntersects( line, sphere );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line over sphere';

  var line = [ 0, -6, 4, 0, 1, 0 ];
  var sphere = [ 0, 0, 0, 3 ];
  var expected = false;

  var gotBool = _.linePointDir.sphereIntersects( line, sphere );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Negative factor';

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var sphere = [ - 2, - 2, - 2, 0.5 ];
  var expected = true;

  var gotBool = _.linePointDir.sphereIntersects( line, sphere );
  test.identical( gotBool, expected );

  /* */

  test.case = 'sphere closer to origin';

  var line = [ 1, 1, 1, 2, 2, 2 ];
  var sphere = [ 2, 1, 0, 0.1 ];
  var expected = false;

  var gotBool = _.linePointDir.sphereIntersects( line, sphere );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) intersection';

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var sphere = [ 0, 2, 0, 2 ];
  var expected = true;

  var gotBool = _.linePointDir.sphereIntersects( line, sphere );
  test.identical( gotBool, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) no intersection';

  var line = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var sphere = [ 3, 3, 3, 1 ];
  var expected = false;

  var gotBool = _.linePointDir.sphereIntersects( line, sphere );
  test.equivalent( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePointDir.sphereIntersects( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereIntersects( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereIntersects( [ 1, 1, 1, 2, 2, 2 ], 'sphere') );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereIntersects( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereIntersects( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereIntersects( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereIntersects( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4, 5, 6 ] ) );

}

//

function sphereDistance( test )
{

  /* */

  test.case = 'Line and sphere remain unchanged';

  var line = [  - 1, - 1, -1, 1, 1, 1 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.linePointDir.sphereDistance( line, sphere );
  test.identical( gotDistance, expected );

  var oldLine = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( line, oldLine );

  var oldSphere = [ 0, 0, 0, 1 ];
  test.identical( sphere, oldSphere );

  /* */

  test.case = 'Null line - empty sphere';

  var line = null;
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.linePointDir.sphereDistance( line, sphere );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'point line center of sphere';

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.linePointDir.sphereDistance( line, sphere );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'point line - no intersection';

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var sphere = [ 4, 3, 4, 1 ];
  var expected = Math.sqrt( 11 ) - 1;

  var gotDistance = _.linePointDir.sphereDistance( line, sphere );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'point line in sphere';

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var sphere = [ 2, 2, 2, 2 ];
  var expected = 0;

  var gotDistance = _.linePointDir.sphereDistance( line, sphere );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line and sphere intersect';

  var line = [ -2, -2, -2, 2, 2, 2 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.linePointDir.sphereDistance( line, sphere );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line over sphere';

  var line = [ 0, -6, 4, 0, 1, 0 ];
  var sphere = [ 0, 0, 0, 3 ];
  var expected = 1;

  var gotDistance = _.linePointDir.sphereDistance( line, sphere );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Negative factor';

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var sphere = [ - 2, - 2, - 2, 0.5 ];
  var expected = 0;

  var gotDistance = _.linePointDir.sphereDistance( line, sphere );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) intersection';

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var sphere = [ 0, 2, 0, 2 ];
  var expected = 0;

  var gotDistance = _.linePointDir.sphereDistance( line, sphere );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) no intersection';

  var line = [ 0, 0, 0, 1 / Math.sqrt( 3 ), 1 / Math.sqrt( 3 ), 1 / Math.sqrt( 3 ) ];
  var sphere = [ 3, 0, 0, 1 ];
  var expected = Math.sqrt( 6 ) - 1;

  var gotDistance = _.linePointDir.sphereDistance( line, sphere );
  test.equivalent( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePointDir.sphereDistance( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereDistance( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereDistance( [ 1, 1, 1, 2, 2, 2 ], 'sphere') );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereDistance( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereDistance( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereDistance( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereDistance( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereDistance( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4, 5, 6 ] ) );

}

//

function sphereClosestPoint( test )
{

  /* */

  test.case = 'Line and sphere remain unchanged';

  var line = [  - 1, - 1, -1, 1, 1, 1 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.sphereClosestPoint( line, sphere );
  test.identical( gotClosestPoint, expected );

  var oldLine = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( line, oldLine );

  var oldSphere = [ 0, 0, 0, 1 ];
  test.identical( sphere, oldSphere );

  /* */

  test.case = 'Null line - empty sphere';

  var line = null;
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.sphereClosestPoint( line, sphere );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'point line center of sphere';

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.sphereClosestPoint( line, sphere );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'point line - no intersection';

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var sphere = [ 4, 3, 4, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 1, 2, 3 ] );

  var gotClosestPoint = _.linePointDir.sphereClosestPoint( line, sphere );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'point line in sphere';

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var sphere = [ 2, 2, 2, 2 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.sphereClosestPoint( line, sphere );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line and sphere intersect';

  var line = [ -2, -2, -2, 2, 2, 2 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.sphereClosestPoint( line, sphere );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line over sphere';

  var line = [ 0, -6, 4, 0, 1, 0 ];
  var sphere = [ 0, 0, 0, 3 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 4 ] );

  var gotClosestPoint = _.linePointDir.sphereClosestPoint( line, sphere );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Negative factor';

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var sphere = [ - 2, - 2, - 2, 0.5 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.sphereClosestPoint( line, sphere );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) intersection';

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var sphere = [ 0, 2, 0, 2 ];
  var expected = 0;

  var gotClosestPoint = _.linePointDir.sphereClosestPoint( line, sphere );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Line ( normalized to 1 ) no intersection';

  var line = [ 0, 0, 0, 1 / Math.sqrt( 3 ), 1 / Math.sqrt( 3 ), 1 / Math.sqrt( 3 ) ];
  var sphere = [ 3, 0, 0, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 1, 1, 1 ] );

  var gotClosestPoint = _.linePointDir.sphereClosestPoint( line, sphere );
  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'dstPoint is vector';

  var line = [ 0, -6, 4, 0, 1, 0 ];
  var sphere = [ 0, 5, 0, 3 ];
  var dstPoint = _.linePointDir.tools.vectorAdapter.from( [ 0, 0, 0 ] );
  var expected = _.linePointDir.tools.vectorAdapter.from( [ 0, 5, 4 ] );

  var gotClosestPoint = _.linePointDir.sphereClosestPoint( line, sphere, dstPoint );
  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'dstPoint is array';

  var line = [ 0, -6, 4, 0, 1, 0 ];
  var sphere = [ 1, 5, 0, 3 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 5, 4 ] );

  var gotClosestPoint = _.linePointDir.sphereClosestPoint( line, sphere, dstPoint );
  test.identical( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePointDir.sphereClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereClosestPoint( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereClosestPoint( [ 1, 1, 1, 2, 2, 2 ], 'sphere') );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereClosestPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereClosestPoint( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereClosestPoint( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereClosestPoint( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.linePointDir.sphereClosestPoint( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4, 5, 6 ] ) );

}

//

function boundingSphereGet( test )
{

  /* */

  test.case = 'Source line remains unchanged';

  var srcLine = [ 0, 0, 0, 3, 3, 3 ];
  var dstSphere = [ 1, 1, 2, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0, Infinity ] );

  var gotSphere = _.linePointDir.boundingSphereGet( dstSphere, srcLine );
  test.identical( expected, gotSphere );
  test.true( dstSphere === gotSphere );

  var oldSrcLine = [ 0, 0, 0, 3, 3, 3 ];
  test.identical( srcLine, oldSrcLine );

  /* */

  test.case = 'Zero line to zero sphere';

  var srcLine = [ 0, 0, 0, 0, 0, 0 ];
  var dstSphere = [ 0, 0, 0, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0, 0 ] );

  var gotSphere = _.linePointDir.boundingSphereGet( dstSphere, srcLine );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Point line and point Sphere';

  var srcLine = [ 0, 0, 0, 0, 0, 0 ];
  var dstSphere = [ 3, 3, 3, 0 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0, 0 ] );

  var gotSphere = _.linePointDir.boundingSphereGet( dstSphere, srcLine );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Sphere and line intersect';

  var srcLine = [ 0, 0, 0, 4, 4, 4 ];
  var dstSphere = [ 2, 2, 2, 1 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0, Infinity ] );

  var gotSphere = _.linePointDir.boundingSphereGet( dstSphere, srcLine );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Sphere and line intersect - negative dir';

  var srcLine = [ 0, 0, 0, - 1, - 1, - 1 ];
  var dstSphere = [ 0, 0, 0, 3 ];
  var expected = _.linePointDir.tools.long.make( [ 0, 0, 0, Infinity ] );

  var gotSphere = _.linePointDir.boundingSphereGet( dstSphere, srcLine );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Sphere and line don´t intersect';

  var srcLine = [ 1, 2, 3, 5, 8, 9 ];
  var dstSphere = [ 5, 5, 5, 3 ];
  var expected = _.linePointDir.tools.long.make( [ 1, 2, 3, Infinity ] );

  var gotSphere = _.linePointDir.boundingSphereGet( dstSphere, srcLine );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'srcLine vector';

  var srcLine = _.linePointDir.tools.vectorAdapter.from( [- 1, - 1, - 1, 1, 1, 1 ] );
  var dstSphere = [ 5, 5, 5, 3 ];
  var expected = _.linePointDir.tools.long.make( [ - 1, - 1, - 1, Infinity ] );

  var gotSphere = _.linePointDir.boundingSphereGet( dstSphere, srcLine );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'dstSphere vector';

  var srcLine = [- 1, - 1, - 1, 3, 3, 1 ];
  var dstSphere = _.linePointDir.tools.vectorAdapter.from( [ 5, 5, 5, 3 ] );
  var expected = _.linePointDir.tools.vectorAdapter.from( [ - 1, - 1, - 1, Infinity ] );

  var gotSphere = _.linePointDir.boundingSphereGet( dstSphere, srcLine );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'dstSphere null';

  var srcLine = [- 1, 5, - 1, 0, 0, 0 ];
  var dstSphere = null;
  var expected = _.linePointDir.tools.long.make( [ - 1, 5, - 1, 0 ] );

  var gotSphere = _.linePointDir.boundingSphereGet( dstSphere, srcLine );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'dstSphere undefined';

  var srcLine = [ - 1, - 3, - 5, 1, 0, 0 ];
  var dstSphere = undefined;
  var expected = _.linePointDir.tools.long.make( [ - 1, - 3, - 5, Infinity ] );

  var gotSphere = _.linePointDir.boundingSphereGet( dstSphere, srcLine );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Very small direction';

  var srcLine = _.linePointDir.tools.vectorAdapter.from( [ 4, 4, 4, 1E-12, 1E-12, 1E-12 ] );
  var dstSphere = [ 5, 5, 5, 3 ];
  var expected = _.linePointDir.tools.long.make( [ 4, 4, 4, Infinity ] );

  var gotSphere = _.linePointDir.boundingSphereGet( dstSphere, srcLine );
  test.identical( gotSphere, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePointDir.boundingSphereGet( ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boundingSphereGet( [] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boundingSphereGet( [], [] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boundingSphereGet( 'sphere', 'line' ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boundingSphereGet( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boundingSphereGet( [ 0, 0, 0, 1 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boundingSphereGet( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boundingSphereGet( NaN, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boundingSphereGet( [ 0, 1, 0, 1, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boundingSphereGet( [ 0, 1, 0, 1, 2, 1 ], NaN ) );
  test.shouldThrowErrorSync( () => _.linePointDir.boundingSphereGet( [ 0, 1, 0, 1 ], [ 0, 0, 1, 2, 2, 3, 1 ] ) );

}

//

function pointsToPointSide( test )
{
  test.case = 'point on the line'

  var srcLine = [ 0, 0, 1, 1 ];
  var srcPoint = [ 0, 0 ];
  var expected = 0;

  var gotSide = _.linePointDir.pointsToPointSide( srcLine, srcPoint );
  test.identical( gotSide, expected )

  var srcLine = [ 0, 0, 1, 1 ];
  var srcPoint = [ 2, 2 ];
  var expected = 0;

  var gotSide = _.linePointDir.pointsToPointSide( srcLine, srcPoint );
  test.identical( gotSide, expected )

  var srcLine = [ 0, 0, 1, 1 ];
  var srcPoint = [ -1, -1 ];
  var expected = 0;

  var gotSide = _.linePointDir.pointsToPointSide( srcLine, srcPoint );
  test.identical( gotSide, expected )


  var srcLine = [ 0, 0, 1, 1 ];
  var srcPoint = [ 0.5, 0.5 ];
  var expected = 0;

  var gotSide = _.linePointDir.pointsToPointSide( srcLine, srcPoint );
  test.identical( gotSide, expected )

  test.case = 'point on the left side'

  var srcLine = [ 0, 0, 1, 1 ];
  var srcPoint = [ 0.5, 1 ];
  var expected = -0.5;

  var gotSide = _.linePointDir.pointsToPointSide( srcLine, srcPoint );
  test.identical( gotSide, expected )

  var srcLine = [ 0, 0, 1, 1 ];
  var srcPoint = [ 0.5, 2 ];
  var expected = -1.5;

  var gotSide = _.linePointDir.pointsToPointSide( srcLine, srcPoint );
  test.identical( gotSide, expected )

  test.case = 'point on the right side'

  var srcLine = [ 0, 0, 1, 1 ];
  var srcPoint = [ 0.5, 0 ];
  var expected = 0.5;

  var gotSide = _.linePointDir.pointsToPointSide( srcLine, srcPoint );
  test.identical( gotSide, expected )

  var srcLine = [ 0, 0, 1, 1 ];
  var srcPoint = [ 0.5, -1 ];
  var expected = 1.5;

  var gotSide = _.linePointDir.pointsToPointSide( srcLine, srcPoint );
  test.identical( gotSide, expected )
}

// --
// define class
// --

const Proto =
{

  name : 'Tools.Math.LinePointDir',
  silencing : 1,

  tests :
  {
    make,
    makeZero,
    makeSingular,

    zero,
    nil,

    from,
    adapterFrom,
    fromPoints,
    fromPoints2,

    is,
    dimGet,
    originGet,
    directionGet,

    lineAt,
    getFactor,

    lineParallel3D,

    lineParallel,
    lineIntersectionFactors,
    lineIntersectionPoints,
    lineIntersectionPoint,
    lineIntersectionPointAccurate,

    pointContains,
    pointDistance,
    pointClosestPoint,

    boxIntersects,
    boxDistance,
    boxClosestPoint,
    boundingBoxGet,

    capsuleClosestPoint,

    convexPolygonClosestPoint,

    frustumIntersects,
    frustumDistance,
    frustumClosestPoint,

    lineIntersects,
    lineDistance,
    lineClosestPoint,

    planeIntersects,
    planeIntersectionPoint,
    planeDistance,
    planeClosestPoint,

    rayIntersects,
    rayIntersectionPoint,
    rayIntersectionFactors,
    rayDistance,
    rayClosestPoint,

    segmentIntersectionPoint,
    segmentIntersectionFactors,
    segmentClosestPoint,

    sphereIntersects,
    sphereDistance,
    sphereClosestPoint,
    boundingSphereGet,

    pointsToPointSide,

  }

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
