( function _Triangle_test_s_( ) {

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

  test.case = 'Triangle 2D'; //

  var dim = 2;
  var gotTriangle = _.triangle.make( dim );

  var expected = _.triangle.tools.long.make( [ 0, 0, 0, 0, 0, 0 ] );
  test.identical( gotTriangle, expected );

  /* */

  if( !Config.debug )
  return;

  var vertices = 3;

  test.shouldThrowErrorSync( () => _.triangle.make( dim, vertices, vertices ));
  test.shouldThrowErrorSync( () => _.triangle.make( null, vertices ));
  test.shouldThrowErrorSync( () => _.triangle.make( NaN, vertices ));
  test.shouldThrowErrorSync( () => _.triangle.make( undefined, vertices ));
  test.shouldThrowErrorSync( () => _.triangle.make( 'dim', vertices ));
  test.shouldThrowErrorSync( () => _.triangle.make( [ 3 ], vertices ));
  test.shouldThrowErrorSync( () => _.triangle.make( dim, null ));
  test.shouldThrowErrorSync( () => _.triangle.make( dim, NaN ));
  test.shouldThrowErrorSync( () => _.triangle.make( dim, undefined ));
  test.shouldThrowErrorSync( () => _.triangle.make( dim, 'vertices' ));
  test.shouldThrowErrorSync( () => _.triangle.make( dim, [ 3 ] ));
  test.shouldThrowErrorSync( () => _.triangle.make( 1, 3 ));
  test.shouldThrowErrorSync( () => _.triangle.make( 4, 3 ));
  test.shouldThrowErrorSync( () => _.triangle.make( 2, 2 ));

}

//


function from( test )
{
  /* */

  test.case = 'Same instance returned - array';

  var srcTriangle = [ 0, 0, 1, 1, 2, 0 ];
  var expected = _.triangle.tools.long.make( [ 0, 0, 1, 1, 2, 0 ] );

  var gotTriangle = _.triangle.from( srcTriangle );
  test.identical( gotTriangle, expected );
  test.true( srcTriangle === gotTriangle );

  /* */

  test.case = 'Different instance returned - vector -> array';

  var srcTriangle = _.vectorAdapter.fromLong( [  0, 0, 1, 1, 2, 0 ] );
  var expected = _.triangle.tools.vectorAdapter.fromLong( [ 0, 0, 1, 1, 2, 0 ] );

  var gotTriangle = _.triangle.from( srcTriangle );
  test.identical( gotTriangle, expected );
  test.true( srcTriangle === gotTriangle );

  /* */

  test.case = 'Different instance returned - null -> array';

  var srcTriangle = null;
  var expected = _.triangle.tools.long.make( [ 0, 0, 0, 0, 0, 0 ] );

  var gotTriangle = _.triangle.from( srcTriangle );
  test.identical( gotTriangle, expected );
  test.true( srcTriangle !== gotTriangle );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.triangle.from( ));
  test.shouldThrowErrorSync( () => _.triangle.from( [ 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.triangle.from( [ 0, 0, 0, 0 ], [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.triangle.from( 'triangle' ));
  test.shouldThrowErrorSync( () => _.triangle.from( NaN ));
  test.shouldThrowErrorSync( () => _.triangle.from( undefined ));
}

//

function is( test )
{

  test.case = 'Triangle 2D'; //

  test.true( _.triangle.is( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.true( _.triangle.is( [ 0, 0, 1, 1, 2, 0 ] ) );

  //

  test.true( !_.triangle.is( null ) );
  test.true( !_.triangle.is( NaN ) );
  test.true( !_.triangle.is( undefined ) );
  test.true( !_.triangle.is( 'polygon' ) );
  test.true( !_.triangle.is( [ 3 ] ) );
  test.true( !_.triangle.is( 3 ) );

}

//

function pointContains( test )
{
  let triangle = [ 0, 0, 1, 1, 2, 0 ];

  test.true( _.triangle.pointContains( triangle, [ 0, 0 ] ) )
  test.true( _.triangle.pointContains( triangle, [ 1, 0 ] ) )
  test.true( _.triangle.pointContains( triangle, [ 2, 0 ] ) )
  test.true( _.triangle.pointContains( triangle, [ 1, 1 ] ) )
  test.true( _.triangle.pointContains( triangle, [ 1, 0.5 ] ) )

  test.true( !_.triangle.pointContains( triangle, [ -1, 0 ] ) )
  test.true( !_.triangle.pointContains( triangle, [ 3, 0 ] ) )
  test.true( !_.triangle.pointContains( triangle, [ 1, -1 ] ) )
  test.true( !_.triangle.pointContains( triangle, [ 1, 2 ] ) )

}

//

function pointDistance( test )//qqq vova: extend
{
  test.open( 'triangle contains point' )

  var triangle = [ 0, 0, 0, 1, 1, 0, 2, 0, 0 ];
  var point = [ 0, 0, 0 ]
  var expected = 0;

  var gotDistance = _.triangle.pointDistance( triangle, point );
  test.identical( gotDistance, expected );

  //

  var triangle = [ 0, 0, 0, 1, 1, 0, 2, 0, 0 ];
  var point = [ 1, 0, 0 ]
  var expected = 0;

  var gotDistance = _.triangle.pointDistance( triangle, point );
  test.identical( gotDistance, expected );

  //

  var triangle = [ 0, 0, 0, 1, 1, 0, 2, 0, 0 ];
  var point = [ 2, 0, 0 ]
  var expected = 0;

  var gotDistance = _.triangle.pointDistance( triangle, point );
  test.identical( gotDistance, expected );

  //

  var triangle = [ 0, 0, 0, 1, 1, 0, 2, 0, 0 ];
  var point = [ 1, 1, 0 ]
  var expected = 0;

  var gotDistance = _.triangle.pointDistance( triangle, point );
  test.identical( gotDistance, expected );

  //

  var triangle = [ 0, 0, 0, 1, 1, 0, 2, 0, 0 ];
  var point = [ 1, 0.5, 0  ]
  var expected = 0;

  var gotDistance = _.triangle.pointDistance( triangle, point );
  test.identical( gotDistance, expected );

  test.close( 'triangle contains point' )

  var triangle = [ 0, 0, 0, 1, 1, 0, 2, 0, 0 ];
  var point = [ 1, 1, 1  ]
  var expected = 1;

  var gotDistance = _.triangle.pointDistance( triangle, point );
  test.identical( gotDistance, expected );

}

//

// --
// declare
// --

const Proto =
{

  name : 'Tools/Math/Triangle',
  silencing : 1,
  enabled : 1,
  // verbosity : 7,
  // debug : 1,

  tests :
  {
    make,
    is,
    from,

    pointContains,
    pointDistance,
  }

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
