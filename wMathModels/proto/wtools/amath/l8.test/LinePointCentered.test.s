( function _LinePointCentered_test_s_( ) {

'use strict';

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
var vec = _.vectorAdapter.fromArray;
var avector = _.avector;
var sqrt = _.math.sqrt;
const Parent = wTester;

_.assert( _.routineIs( sqrt ) );

// --
// test
// --


function make( test )
{

  test.case = 'pair 2D'; //

  var dim = 2;
  var gotPair = _.linePoints.make( dim );

  var expected = _.linePoints.tools.long.make( [ 0, 0, 0, 0 ] );
  test.identical( gotPair, expected );

  /* */

  if( !Config.debug )
  return;

  var vertices = 3;

  test.shouldThrowErrorSync( () => _.linePoints.make( dim, vertices, vertices ));
  test.shouldThrowErrorSync( () => _.linePoints.make( null, vertices ));
  test.shouldThrowErrorSync( () => _.linePoints.make( NaN, vertices ));
  test.shouldThrowErrorSync( () => _.linePoints.make( undefined, vertices ));
  test.shouldThrowErrorSync( () => _.linePoints.make( 'dim', vertices ));
  test.shouldThrowErrorSync( () => _.linePoints.make( [ 3 ], vertices ));
  test.shouldThrowErrorSync( () => _.linePoints.make( dim, null ));
  test.shouldThrowErrorSync( () => _.linePoints.make( dim, NaN ));
  test.shouldThrowErrorSync( () => _.linePoints.make( dim, undefined ));
  test.shouldThrowErrorSync( () => _.linePoints.make( dim, 'vertices' ));
  test.shouldThrowErrorSync( () => _.linePoints.make( dim, [ 3 ] ));
  test.shouldThrowErrorSync( () => _.linePoints.make( 1, 3 ));
  test.shouldThrowErrorSync( () => _.linePoints.make( 4, 3 ));
  test.shouldThrowErrorSync( () => _.linePoints.make( 2, 2 ));

}

//


function from( test )
{
  /* */

  test.case = 'Same instance returned - array';

  var srcPair = [ 0, 0, 1 , 1, 2, 0 ];
  var expected = _.linePoints.tools.long.make( [ 0, 0, 1, 1, 2, 0 ] );

  var gotPair = _.linePoints.from( srcPair );
  test.identical( gotPair, expected );
  test.true( srcPair === gotPair );

  var srcPair = null;
  var expected = _.linePoints.tools.long.make( [ 0, 0, 0, 0 ] );

  var gotPair = _.linePoints.from( srcPair );
  test.identical( gotPair, expected );
  test.true( srcPair !== gotPair );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.linePoints.from( ));
  test.shouldThrowErrorSync( () => _.linePoints.from( [] ));
  test.shouldThrowErrorSync( () => _.linePoints.from( [ 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.linePoints.from( [ 0, 0, 0, 0 ], [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.linePoints.from( 'pair' ));
  test.shouldThrowErrorSync( () => _.linePoints.from( NaN ));
  test.shouldThrowErrorSync( () => _.linePoints.from( undefined ));
}

//

function is( test )
{

  test.true( _.linePoints.is( [ 0, 0, 0, 0 ] ) );
  test.true( _.linePoints.is( [ 0, 0, 1, 1, 2, 0 ] ) );

  //

  test.true( !_.linePoints.is( [ 0, 0, 1, 1, 2, 0, 0 ] ) );
  test.true( !_.linePoints.is( null ) );
  test.true( !_.linePoints.is( NaN ) );
  test.true( !_.linePoints.is( undefined ) );
  test.true( !_.linePoints.is( 'polygon' ) );
  test.true( !_.linePoints.is( [ 3 ] ) );
  test.true( !_.linePoints.is( 3 ) );

}

//

function pointDistanceCentered2D( test )
{

  /* */

  test.case = 'Line and Point remain unchanged';

  var line = [ 1, 1 ];
  var point = [ 0, 1 ];
  var expected = Math.sqrt( 2 ) / 2;

  var gotDistance = _.linePointCentered.pointDistanceCentered2D( line, point );
  test.equivalent( gotDistance, expected );

  var oldLine = [ 1, 1 ];
  test.identical( line, oldLine );

  var oldPoint = [ 0, 1 ];
  test.identical( point, oldPoint );

  /* */

  test.case = 'Null line Distance empty point';

  var line = null;
  var point = [ 0, 0 ];
  var expected = 0;

  var gotDistance = _.linePointCentered.pointDistanceCentered2D( line, point );
  test.identical( gotDistance, expected );

  test.open( '2d' )

  /* */

  test.case = 'Point line Distance same Point';

  var line = [ 0, 0 ];
  var point = [ 0, 0 ];
  var expected = 0;

  var gotDistance = _.linePointCentered.pointDistanceCentered2D( line, point );
  test.identical( gotDistance, expected );

  /* */

  test.case = 'Point line Distance other Point';

  var line = [ 1,1 ];
  var point = [ 0, 1 ];
  var expected = Math.sqrt( 2 ) / 2;

  var gotDistance = _.linePointCentered.pointDistanceCentered2D( line, point );
  test.equivalent( gotDistance, expected );

  /* */

  test.case = 'Point close to origin';

  var line = [ 2,3 ];
  var point = [ 0, 1 ];
  var expected = 2 * ( Math.sqrt( 13 ) / 13 );

  var gotDistance = _.linePointCentered.pointDistanceCentered2D( line, point );
  test.equivalent( gotDistance, expected );

  /* */

  test.case = 'Point close to end';

  var line = [ -1,2 ];
  var point = [ 1, 3 ];
  var expected = -Math.sqrt( 5 )

  var gotDistance = _.linePointCentered.pointDistanceCentered2D( line, point );
  test.equivalent( gotDistance, expected );

  /* */

  test.case = 'Point on line';

  var line = [ 2,2 ];
  var point = [ 1, 1 ];
  var expected = 0

  var gotDistance = _.linePointCentered.pointDistanceCentered2D( line, point );
  test.equivalent( gotDistance, expected );

  test.close( '2d' )
}

//

function pointDistanceCentered3DSqr( test )//qqq vova: extend
{
  /* */

  test.case = 'Point on line';

  var line = [ 2, 2, 2 ];
  var point = [ 1, 1, 1 ];
  var expected = 0

  var gotDistance = _.linePointCentered.pointDistanceCentered3DSqr( line, point );
  test.equivalent( gotDistance, expected );

  /* */

  test.case = 'Point closer to origin';

  var line = [ 0, 0, 2 ];
  var point = [ 0, -2, 0 ];
  var expected = 4;

  var gotDistance = _.linePointCentered.pointDistanceCentered3DSqr( line, point );
  test.equivalent( gotDistance, expected );

  /* */

  test.case = 'Point closer to end';

  var line = [ 0, 0, 2 ];
  var point = [ 0, 1, 2 ];
  var expected = 1;

  var gotDistance = _.linePointCentered.pointDistanceCentered3DSqr( line, point );
  test.equivalent( gotDistance, expected );

  /* */

  test.case = 'Point with negative factor';

  var line = [ 0, 0, 2 ];
  var point = [ 0, 0, 4 ];
  var expected = 0;

  var gotDistance = _.linePointCentered.pointDistanceCentered3DSqr( line, point );
  test.equivalent( gotDistance, expected );

}


//

// --
// declare
// --

const Proto =
{

  name : 'Tools/Math/LinePointCentered',
  silencing : 1,
  enabled : 1,
  // verbosity : 7,
  // debug : 1,

  tests :
  {
    make,
    is,
    from,

    pointDistanceCentered2D,
    pointDistanceCentered3DSqr,
  }

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
