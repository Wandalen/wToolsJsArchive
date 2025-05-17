( function _LinePoints_test_s_( ) {

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

function fromRay( test )
{
  var src = [ 0, 0, 1, 1 ]
  var got = _.linePoints.fromRay( src );
  var expected = _.linePoints.tools.long.make( [ 0,0, 1,1 ] );
  test.identical( got, expected );
  test.true( got !== src );

  var src = [ 1, 1, 1, 1 ]
  var got = _.linePoints.fromRay( src );
  var expected = _.linePoints.tools.long.make([ 1, 1, 2, 2 ] );
  test.identical( got, expected );
  test.true( got !== src );
}

//

function fromLineImplicit( test )
{
  var expected = [ 0, 2, 1, 2 ];
  var lineImplicit = _.lineImplicit.fromPair([ [ -2, 2 ], [ 3, 2 ] ]).toLong();
  var got = _.linePoints.fromLineImplicit( lineImplicit );
  var checkPoint1 = lineImplicit[ 0 ] * got[ 0 ] + lineImplicit[ 1 ] * got[ 1 ] + lineImplicit[ 2 ]
  var checkPoint2 = lineImplicit[ 0 ] * got[ 2 ] + lineImplicit[ 1 ] * got[ 3 ] + lineImplicit[ 2 ]
  test.identical( got, expected )
  test.identical( checkPoint1, 0 )
  test.identical( checkPoint2, 0 )

  var expected = [ 0.29508196721311475, -0.2459016393442623, 0.29508196721311475, -0.2459016393442623 ];
  var lineImplicit = _.lineImplicit.fromPair([ [ -2, -3 ], [ 3, 3 ] ]).toLong();
  var got = _.linePoints.fromLineImplicit( lineImplicit );
  var checkPoint1 = lineImplicit[ 0 ] * got[ 0 ] + lineImplicit[ 1 ] * got[ 1 ] + lineImplicit[ 2 ]
  var checkPoint2 = lineImplicit[ 0 ] * got[ 2 ] + lineImplicit[ 1 ] * got[ 3 ] + lineImplicit[ 2 ]
  test.equivalent( got, expected )
  test.identical( checkPoint1, 0 )
  test.identical( checkPoint2, 0 )

  var expected = [ -0, 2, 1, 2 ];
  var lineImplicit = _.lineImplicit.fromPair([ [ 3, 2 ], [ -2, 2 ] ]).toLong();
  var got = _.linePoints.fromLineImplicit( lineImplicit );
  var checkPoint1 = lineImplicit[ 0 ] * got[ 0 ] + lineImplicit[ 1 ] * got[ 1 ] + lineImplicit[ 2 ]
  var checkPoint2 = lineImplicit[ 0 ] * got[ 2 ] + lineImplicit[ 1 ] * got[ 3 ] + lineImplicit[ 2 ]
  test.identical( got, expected )
  test.identical( checkPoint1, 0 )
  test.identical( checkPoint2, 0 )

  var expected = [ 0, -0, 1, 1 ];
  var lineImplicit = _.lineImplicit.fromPair([ [ 0, 0 ], [ 3, 3 ] ]).toLong();
  var got = _.linePoints.fromLineImplicit( lineImplicit );
  var checkPoint1 = lineImplicit[ 0 ] * got[ 0 ] + lineImplicit[ 1 ] * got[ 1 ] + lineImplicit[ 2 ]
  var checkPoint2 = lineImplicit[ 0 ] * got[ 2 ] + lineImplicit[ 1 ] * got[ 3 ] + lineImplicit[ 2 ]
  test.identical( got, expected )
  test.identical( checkPoint1, 0 )
  test.identical( checkPoint2, 0 )

  var expected = [ -0, 0, 1, 1 ];
  var lineImplicit = _.lineImplicit.fromPair([ [ 3, 3 ], [ 0, 0 ] ]).toLong();
  var got = _.linePoints.fromLineImplicit( lineImplicit );
  var checkPoint1 = lineImplicit[ 0 ] * got[ 0 ] + lineImplicit[ 1 ] * got[ 1 ] + lineImplicit[ 2 ]
  var checkPoint2 = lineImplicit[ 0 ] * got[ 2 ] + lineImplicit[ 1 ] * got[ 3 ] + lineImplicit[ 2 ]
  test.identical( got, expected )
  test.identical( checkPoint1, 0 )
  test.identical( checkPoint2, 0 )
}

//

function pairAt( test )
{
  var src = [ 1, 1, 5, 5 ]
  var got = _.linePoints.pairAt( src, 0.25 );
  var expected = _.linePoints.tools.vectorAdapter.fromLong( [ 2, 2 ] );
  test.identical( got, expected );
  test.true( got !== src );

  var src = [ 1, 1, 5, 5 ]
  var got = _.linePoints.pairAt( src, 0.5 );
  var expected = _.linePoints.tools.vectorAdapter.fromLong( [ 3, 3 ] );
  test.identical( got, expected );
  test.true( got !== src );

  var src = [ 1, 1, 5, 5 ]
  var got = _.linePoints.pairAt( src, 0 );
  var expected = _.linePoints.tools.vectorAdapter.fromLong( [ 1, 1 ] );
  test.identical( got, expected );
  test.true( got !== src );

  var src = [ 1, 1, 5, 5 ]
  var got = _.linePoints.pairAt( src, 1 );
  var expected = _.linePoints.tools.vectorAdapter.fromLong( [ 5, 5 ] );
  test.identical( got, expected );
  test.true( got !== src );

}

//

function pairPairParallel( test )
{
  test.case = '2d parallel'
  var pair1 = _.linePoints.fromRay( [ 0, 0, 1, 1 ] );
  var pair2 = _.linePoints.fromRay( [ 3, 7, - 2, - 2 ] );
  var expected = true;

  var got = _.linePoints.pairPairParallel( pair1, pair2 );
  test.identical( got, expected )

  test.case = '2d not parallel'

  var pair1 = _.linePoints.fromRay( [ 3, 7, 1, - 1 ] );
  var pair2 = _.linePoints.fromRay( [ 3, 7, 7, 7 ]);
  var expected = false;

  var got = _.linePoints.pairPairParallel( pair1, pair2 );
  test.identical( got, expected )

}

//

function pairIntersectionFactors( test )
{
  /* */

  test.case = 'Rays don´t intersect';

  var pair1 = _.linePoints.fromRay( [ 0, 0, 1, 1 ] );
  var pair2 = _.linePoints.fromRay( [ 3, 0, 2, -1 ] );
  var expected = 0;

  var got = _.linePoints.pairIntersectionFactors( pair1, pair2 );
  test.identical( got, expected )

  /* */

  test.case = 'Rays intersect in their origin';

  var pair1 = _.linePoints.fromRay( [ 3, 7, 1, 0 ] );
  var pair2 = _.linePoints.fromRay( [ 3, 7, 0, 1  ] );
  var expected = _.linePoints.tools.vectorAdapter.from( [ 0, 0 ] );

  var got = _.linePoints.pairIntersectionFactors( pair1, pair2 );
  test.identical( got, expected )

  /* */

  test.case = 'Rays intersect ';

  var pair1 = _.linePoints.fromRay( [ 0, 0, 1, 0 ] );
  var pair2 = _.linePoints.fromRay( [ -2, -6, 1, 2 ] );
  var expected = _.linePoints.tools.vectorAdapter.from( [ 1, 3 ] );

  var got = _.linePoints.pairIntersectionFactors( pair1, pair2 );
  test.identical( got, expected )

  /* */

  test.case = 'Rays are perpendicular ';

  var pair1 = _.linePoints.fromRay( [ -3, 0, 1, 0 ] );
  var pair2 = _.linePoints.fromRay( [ 0, -2, 0, 1 ] );
  var expected = _.linePoints.tools.vectorAdapter.from( [ 3, 2 ] );

  var got = _.linePoints.pairIntersectionFactors( pair1, pair2 );
  test.identical( got, expected )
}

//

function pairIntersectionPoint( test )
{
  /* */

  test.case = 'Parellel';

  var pair1 = _.linePoints.fromRay( [ 0, 0, 1, 1 ] );
  var pair2 = _.linePoints.fromRay( [ 3, 7, 1, 1 ] );
  var expected = 0

  var got = _.linePoints.pairIntersectionPoint( pair1, pair2 );
  test.identical( got, expected )

  /* */

  test.case = 'Same';

  var pair1 = _.linePoints.fromRay( [ 0, 0, 1, 1 ] );
  var pair2 = _.linePoints.fromRay( [ 0, 0, 1, 1 ] );
  var expected = _.linePoints.tools.long.make( [ 0, 0 ] );

  var got = _.linePoints.pairIntersectionPoint( pair1, pair2 );
  test.identical( got, expected )

  /* */

  test.case = 'Rays intersect in their origin';

  var pair1 = _.linePoints.fromRay( [ 3, 7, 1, 0 ] );
  var pair2 = _.linePoints.fromRay( [ 3, 7, 0, 1 ] );
  var expected = _.linePoints.tools.long.make( [ 3, 7 ] );

  var got = _.linePoints.pairIntersectionPoint( pair1, pair2 );
  test.identical( got, expected )

  /* */

  test.case = 'Rays intersect';

  var pair1 = _.linePoints.fromRay( [ 0, 0, 1, 0 ] );
  var pair2 = _.linePoints.fromRay( [ -2, -6, 1, 2 ] );
  var expected = _.linePoints.tools.long.make( [ 1, 0 ] );

  var got = _.linePoints.pairIntersectionPoint( pair1, pair2 );
  test.identical( got, expected )

}

//

function pairIntersectionPointAccurate( test )
{
  /* */

  test.case = 'Parellel';

  var pair1 = _.linePoints.fromRay( [ 0, 0, 1, 1 ] );
  var pair2 = _.linePoints.fromRay( [ 3, 7, 1, 1 ] );
  var expected = 0

  var got = _.linePoints.pairIntersectionPointAccurate( pair1, pair2 );
  test.identical( got, expected )

  /* */

  test.case = 'Same';

  var pair1 = _.linePoints.fromRay( [ 0, 0, 1, 1 ] );
  var pair2 = _.linePoints.fromRay( [ 0, 0, 1, 1 ] );
  var expected = _.linePoints.tools.long.make( [ 0, 0 ] );

  var got = _.linePoints.pairIntersectionPointAccurate( pair1, pair2 );
  test.identical( got, expected )

  /* */

  test.case = 'Rays intersect in their origin';

  var pair1 = _.linePoints.fromRay( [ 3, 7, 1, 0 ] );
  var pair2 = _.linePoints.fromRay( [ 3, 7, 0, 1 ] );
  var expected = _.linePoints.tools.long.make( [ 3, 7 ] );

  var got = _.linePoints.pairIntersectionPointAccurate( pair1, pair2 );
  test.identical( got, expected )

  /* */

  test.case = 'Rays intersect';

  var pair1 = _.linePoints.fromRay( [ 0, 0, 1, 0 ] );
  var pair2 = _.linePoints.fromRay( [ -2, -6, 1, 2 ] );
  var expected = _.linePoints.tools.long.make( [ 1, 0 ] );

  var got = _.linePoints.pairIntersectionPointAccurate( pair1, pair2 );
  test.identical( got, expected )

}

//

// --
// declare
// --

const Proto =
{

  name : 'Tools/Math/LinePoints',
  silencing : 1,
  enabled : 1,
  // verbosity : 7,
  // debug : 1,

  tests :
  {
    make,
    is,
    from,

    fromRay,
    fromLineImplicit,

    pairAt,

    pairPairParallel,
    pairIntersectionFactors,
    pairIntersectionPoint,
    pairIntersectionPointAccurate
  }

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
