( function _LineImplicit_test_s_( ) {

'use strict';

// return;

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

  test.case = 'srcDim 2';

  var srcDim = 2;
  var gotLine = _.plane.make( srcDim );
  var expected = _.plane.tools.long.make( [ 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.true( gotLine !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.plane.make( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.make( 'line' ));
}

//

function from( test )
{
  /* */

  test.case = 'Same instance returned - array';

  var srcLine = [ 0, 0, 2 ];
  var expected = _.plane.tools.long.make( [ 0, 0, 2 ] );

  var gotLine = _.plane.from( null, srcLine );
  test.identical( gotLine, expected );

  test.case = 'Same instance returned - array';
}

//

function fromPoints( test )
{
  /* */

  test.case = 'Pair stay unchanged';

  var pair = [ [ 0, 1 ], [ 0, 2 ] ];
  var expected = _.plane.tools.vectorAdapter.make( [ 0, -1, 0 ] );

  var gotLine = _.plane.fromPoints( null, pair[ 0 ], pair[ 1 ] )
  test.identical( gotLine, expected );

  var oldPair = [ [ 0, 1 ], [ 0, 2 ] ];
  test.identical( pair, oldPair );

  /* */

  test.case = 'Line starts in origin';

  var pair = [ [ 0, 0 ], [ 0, 1 ] ];
  var expected = _.plane.tools.vectorAdapter.make( [ 0, -1, 0 ] );

  var gotLine = _.plane.fromPoints( null, pair[ 0 ], pair[ 1 ] )
  test.identical( gotLine, expected );

  /* */

  test.case = 'Line is point';

  var pair = [ [ 0, 1 ], [ 0, 1 ] ];
  var expected = _.plane.tools.vectorAdapter.make( [ 0, 0, 0 ] );

  var gotLine = _.plane.fromPoints( null, pair[ 0 ], pair[ 1 ] )
  test.identical( gotLine, expected );

  //qqq
  // /* */

 test.case = 'Line of 1 dimension';

  // var pair = [ [ 3 ], [ 4 ] ];
  // var expected = _.plane.tools.vectorAdapter.make( [ 0, 1, 0 ] );

  // var gotLine = _.plane.fromPoints( null, pair[ 0 ], pair[ 1 ] )
  // test.identical( gotLine, expected );

  /* */

  test.case = 'Line goes up in y and down in x';

  var pair = [ [ 0, 2 ], [ -2, 2 ] ];
  var expected = _.plane.tools.vectorAdapter.make( [ 4, 0, -2 ] );

  var gotLine = _.plane.fromPoints( null, pair[ 0 ], pair[ 1 ] )
  test.identical( gotLine, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.plane.fromPoints( ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( null ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 2, 4 ], [ 3, 6 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 2, 4 ], [ 3, 6, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ [ 2, 4 ], [ 3, 6 ], [ 3, 6 ] ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( undefined ));

}

//

function is( test )
{
  debugger;
  /* */

  test.case = 'array';

  test.true( !_.plane.is( [] ) );
  test.true( _.plane.is([ 0, 0, 0 ]) );
  test.true( _.plane.is([ 1, 2, 3, 4 ]) );
  test.true( _.plane.is([ 0, 0, 0, 0, 0, 0 ]) );

  /* */

  test.case = 'vector';

  test.true( !_.plane.is( _.vectorAdapter.fromLong([]) ) );
  test.true( _.plane.is( _.vectorAdapter.fromLong([ 0, 0, 0 ]) ) );
  test.true( _.plane.is( _.vectorAdapter.fromLong([ 1, 2, 3, 4 ]) ) );
  test.true( _.plane.is( _.vectorAdapter.fromLong([ 0, 0, 0, 0, 0, 0 ]) ) );

  /* */

  test.case = 'not line';

  test.true( _.plane.is([ 0 ]) );
  test.true( _.plane.is([ 0, 0 ]) );

  test.true( _.plane.is( _.vectorAdapter.fromLong([ 0 ]) ) );
  test.true( _.plane.is( _.vectorAdapter.fromLong([ 0, 0 ]) ) );

  test.true( !_.plane.is( 'abc' ) );
  test.true( !_.plane.is( { origin : [ 0, 0, 0 ], direction : [ 1, 1, 1 ] } ) );
  test.true( !_.plane.is( function( a, b, c ){} ) );

  test.true( !_.plane.is( null ) );
  test.true( !_.plane.is( undefined ) );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.plane.is( ));
  test.shouldThrowErrorSync( () => _.plane.is( [ 0, 0 ], [ 1, 1 ] ));

}

//

function dimGet( test )
{
  /* */

 test.case = 'srcLine 1D - array';

  var srcLine = [ 0, 1 ];
  var gotDim = _.plane.dimGet( srcLine );
  var expected = 1;
  test.identical( gotDim, expected );
  test.true( gotDim !== srcLine );

  /* */

 test.case = 'srcLine 1D - vector';

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1 ] );
  var gotDim = _.plane.dimGet( srcLine );
  var expected = 1;
  test.identical( gotDim, expected );
  test.true( gotDim !== srcLine );

  /* */

  test.case = 'srcLine 2D - array';

  var srcLine = [ 0, 1, 2 ];
  var gotDim = _.plane.dimGet( srcLine );
  var expected = 2;
  test.identical( gotDim, expected );
  test.true( gotDim !== srcLine );

  /* */

  test.case = 'srcLine 2D - vector';

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1, 2 ] );
  var gotDim = _.plane.dimGet( srcLine );
  var expected = 2;
  test.identical( gotDim, expected );
  test.true( gotDim !== srcLine );

  /* */

  test.case = 'srcLine 3D - array';

  var srcLine = [ 0, 1, 2, 3 ];
  var gotDim = _.plane.dimGet( srcLine );
  var expected = 3;
  test.identical( gotDim, expected );
  test.true( gotDim !== srcLine );

  /* */

  test.case = 'srcLine 3D - vector';

  var srcLine = _.vectorAdapter.fromLong( [ 0, 1, 2, 3 ] );
  var gotDim = _.plane.dimGet( srcLine );
  var expected = 3;
  test.identical( gotDim, expected );
  test.true( gotDim !== srcLine );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.plane.dimGet( ) );
  test.shouldThrowErrorSync( () => _.plane.dimGet( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.plane.dimGet( 'line' ) );
  test.shouldThrowErrorSync( () => _.plane.dimGet( 0 ) );
  test.shouldThrowErrorSync( () => _.plane.dimGet( null ) );
  test.shouldThrowErrorSync( () => _.plane.dimGet( undefined ) );

}

//

function fromPoints2( test )//qqq:extend
{
  var srcPoint1 = [ 0,0 ];
  var srcPoint2 = [ 0,0 ];
  var expected = _.plane.tools.vectorAdapter.from( new F32x([ 0, 0, 0 ]) );
  var got = _.plane.fromPoints( null, srcPoint1, srcPoint2 );
  test.identical( got, expected );

  var srcPoint1 = [ 0,0 ];
  var srcPoint2 = [ 1,1 ];
  var expected = _.plane.tools.vectorAdapter.from( new F32x([ 0, -1, 1 ]) );
  var got = _.plane.fromPoints( null, srcPoint1, srcPoint2 );
  test.identical( got, expected );

  var srcPoint1 = [ 1,1 ];
  var srcPoint2 = [ 0,0 ];
  var expected = _.plane.tools.vectorAdapter.from( new F32x([ 0, 1, -1 ]) );
  var got = _.plane.fromPoints( null, srcPoint1, srcPoint2 );
  test.identical( got, expected );

  var srcPoint1 = [ 1,1 ];
  var srcPoint2 = [ 3,3 ];
  var expected = _.plane.tools.vectorAdapter.from( new F32x([ 0, -2, 2]) );
  var got = _.plane.fromPoints( null, srcPoint1, srcPoint2 );
  test.identical( got, expected );

  var srcPoint1 = [ -1,-1 ];
  var srcPoint2 = [ 1,1 ];
  var expected = _.plane.tools.vectorAdapter.from( new F32x([ 0, -2, 2 ]) );
  var got = _.plane.fromPoints( null, srcPoint1, srcPoint2 );
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'wrong number of arguments'
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [] ) );
  test.case = 'wrong number of elements in src array'
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 1 ], [ 1, 1 ] ) );
}

//

function fromPointAndTangent( test ) //qqq:cover with tests
{
  var srcPoint = [ 0,0 ];
  var srcTangent = [ 0,0 ];
  var expected = _.plane.tools.vectorAdapter.from( new F32x([ 0, 0, 0 ]) );
  var got = _.plane.fromPointAndTangent( srcPoint, srcTangent );
  test.equivalent( got, expected );

  if( !Config.debug )
  return;

  test.case = 'wrong number of arguments'
  test.shouldThrowErrorSync( () => _.plane.fromPointAndTangent( [] ) );
  test.case = 'wrong number of elements in src array'
  test.shouldThrowErrorSync( () => _.plane.fromPointAndTangent( [ 1 ], [ 1, 1 ] ) );
}

//

function lineIntersection( test ) //qqq:cover with tests
{
  var srcLine1 = [ 0,0,0 ];
  var srcLine2 = [ 0,0,0 ];
  var expected = _.plane.tools.vectorAdapter.from( new F32x([ NaN, NaN ]) );
  var got = _.plane.lineIntersection( srcLine1, srcLine2 );
  test.identical( got, expected );

  /* */

  test.case = 'Lines are parallel ( different origin - same direction )';

  var src1Line = [ 0, 1, 0 ];
  var src2Line = [ 0, 2, 0 ];
  var expected = _.plane.tools.vectorAdapter.from( new F32x([ NaN, NaN ]) );
  var got = _.plane.lineIntersection( src1Line, src2Line );
  test.identical( got, expected );

  /* */

  test.case = 'Lines intersect in origin';

  var src1Line = [ -7, 7, -2 ]; //3, 7, 1, 0
  var src2Line = [ 2, 6, -2 ];//3, 7, 0, 1
  var expected = _.plane.tools.vectorAdapter.from( new F32x([ 9, 28 ]) );
  var got = _.plane.lineIntersection( src1Line, src2Line );
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'wrong number of arguments'
  test.shouldThrowErrorSync( () => _.plane.lineIntersection( [] ) );
  test.case = 'wrong number of elements in src array'
  test.shouldThrowErrorSync( () => _.plane.lineIntersection( [ 1 ], [ 1, 1 ] ) );
}

//

function pointDistance( test ) //qqq:cover with tests
{
  var srcLine = [ 0,1,1 ];
  var point = [ 0,0 ];
  var expected = 0;
  var got = _.plane.pointDistance( srcLine, point );
  test.identical( got, expected );

  var srcLine = [ 0,1,1 ];
  var point = [ 1,1 ];
  var expected = 1.414213562373095;
  var got = _.plane.pointDistance( srcLine, point );
  test.equivalent( got, expected );

  var srcLine = [ -3,-1,3 ];//0,1, 3,2
  var point = [ 3,2 ];
  var expected = 0;
  var got = _.plane.pointDistance( srcLine, point );
  test.identical( got, expected );

  var srcLine = [ -3,-1,3 ];//0,1, 3,2
  var point = [ 0,1 ];
  var expected = 0;
  var got = _.plane.pointDistance( srcLine, point );
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'wrong number of arguments'
  test.shouldThrowErrorSync( () => _.plane.pointDistance( [] ) );
  test.case = 'wrong number of elements in src array'
  test.shouldThrowErrorSync( () => _.plane.pointDistance( [ 1,1 ], [ 1, 1 ] ) );
}

// --
// define class
// --

const Proto =
{

  name : 'Tools.Math.LineImplicit',
  silencing : 1,

  tests :
  {
    make,

    is,

    dimGet,

    from,
    fromPoints,

    // originGet,
    // directionGet,

    // lineAt,
    // getFactor,

    fromPoints2,
    fromPointAndTangent,

    lineIntersection,

    pointDistance
  }

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
