( function _ConvexPolygon_test_s_( ) {

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

function is( test )
{

  test.case = 'Source polygon remains unchanged'; //

  var polygon = _.convexPolygon.make( 3, 3 );

  var gotBool = _.convexPolygon.is( polygon );

  var expected = true;
  test.identical( gotBool, expected );

  var oldPolygon = _.convexPolygon.make( 3, 3 );
  test.equivalent( oldPolygon, polygon );

  test.case = 'Triangle 2D'; //

  var polygon = _.convexPolygon.make( 3, 2 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);

  var gotBool = _.convexPolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Square 3D'; //

  var polygon = _.convexPolygon.make( 4, 3 ).copy
  ([
    1, 1, 0, 0,
    0, 1, 1, 0,
    0, 0, 0, 0
  ]);

  var gotBool = _.convexPolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = '4 points in 3D forming concave polygon'; //

  var polygon = _.convexPolygon.make( 4, 3 ).copy
  ([
    1, 1, 0.9, 0,
    0, 1, 0.1, 0,
    0, 0, 0, 0
  ]);

  var gotBool = _.convexPolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Pentagone 2D'; //

  var polygon = _.convexPolygon.make( 5, 2 ).copy
  ([
    1, 0, 0, 0, 2,
    0, 0, 1, 2, 0
  ]);

  var gotBool = _.convexPolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Concave pentagone 2D'; //

  var polygon = _.convexPolygon.make( 5, 2 ).copy
  ([
    1, 0, 0, 2, 0,
    0, 0, 1, 0, 2
  ]);

  var gotBool = _.convexPolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Wrong dim and vertices'; //

  var polygon = _.Matrix.Make( [ 1, 2 ] ).copy
  ([
    1, 0
  ]);

  var gotBool = _.convexPolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Three points are always coplanar'; //

  var polygon = _.convexPolygon.make( 3, 3 ).copy
  ([
    1, 0, 0,
    0, 1, 0,
    1, 1, 1,
  ]);

  var gotBool = _.convexPolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Four points convex'; //

  var polygon = _.convexPolygon.make( 4, 3 ).copy
  ([
    0,   0,   0,   2,
    1, - 1,   -2,   0,
    1, - 1,   -2,   0
  ]);

  var gotBool = _.convexPolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Four points concave'; //

  var polygon = _.convexPolygon.make( 4, 3 ).copy
  ([
    0,   1,   0,   2,
    1, - 1,   -2,   0,
    1, - 1,   -2,   0
  ]);

  var gotBool = _.convexPolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  //

  test.true( !_.convexPolygon.is( ) );
  test.true( !_.convexPolygon.is( null ) );
  test.true( !_.convexPolygon.is( NaN ) );
  test.true( !_.convexPolygon.is( undefined ) );
  test.true( !_.convexPolygon.is( 'polygon' ) );
  test.true( !_.convexPolygon.is( [ 3 ] ) );
  test.true( !_.convexPolygon.is( 3 ) );

}

//

function isPolygon( test )
{

  test.case = 'Source polygon remains unchanged'; //

  var polygon = _.convexPolygon.make( 3, 3 );

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = true;
  test.identical( gotBool, expected );

  var oldPolygon = _.convexPolygon.make( 3, 3 );
  test.equivalent( oldPolygon, polygon );

  test.case = 'Triangle 2D'; //

  var polygon = _.convexPolygon.make( 3, 2 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Square 3D'; //

  var polygon = _.convexPolygon.make( 4, 3 ).copy
  ([
    1, 1, 0, 0,
    0, 1, 1, 0,
    0, 0, 0, 0
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = '4 points in 3D not coplanar'; //

  var polygon = _.convexPolygon.make( 4, 3 ).copy
  ([
    1, 1, 0, 0,
    0, 1, 1, 0,
    0, 0, 0, 1
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Pentagone 2D'; //

  var polygon = _.convexPolygon.make( 5, 2 ).copy
  ([
    1, 0, 0, 0, 2,
    0, 0, 1, 2, 0
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Dim < 2'; //

  var polygon = _.Matrix.Make( [ 1, 5 ] ).copy
  ([
    1, 0, 0, 0, 2
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Dim > 3'; //

  var polygon = _.Matrix.Make( [ 4, 5 ] ).copy
  ([
    1, 0, 0, 0, 2,
    1, 0, 0, 0, 2,
    1, 0, 0, 0, 2,
    1, 0, 0, 0, 2
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Vertices < 3'; //

  var polygon = _.Matrix.Make( [ 2, 2 ] ).copy
  ([
    1, 0,
    0, 1
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Three points are always coplanar'; //

  var polygon = _.convexPolygon.make( 3, 3 ).copy
  ([
    1, 0, 0,
    0, 1, 0,
    1, 1, 1,
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Four coplanar points'; //

  var polygon = _.convexPolygon.make( 4, 3 ).copy
  ([
    0,   0,   0,   2,
    1, - 1,   -2,   0,
    1, - 1,   -2,   0
  ]);

  var gotBool = _.convexPolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon = _.Matrix.Make( [ 3, 3 ] );
  test.shouldThrowErrorSync( () => _.convexPolygon.isPolygon( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.isPolygon( polygon, polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.isPolygon( null ));
  test.shouldThrowErrorSync( () => _.convexPolygon.isPolygon( NaN ));
  test.shouldThrowErrorSync( () => _.convexPolygon.isPolygon( undefined ));
  test.shouldThrowErrorSync( () => _.convexPolygon.isPolygon( 'polygon' ));
  test.shouldThrowErrorSync( () => _.convexPolygon.isPolygon( [ 3 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.isPolygon( 3 ));

}

//

function isConvex( test )
{
  test.open( '2d' );

  test.case = 'is not a polygon - Matrix 2x2';
  var polygon = _.Matrix.Make([ 2, 2 ]).copy
  ([
     1, 3,
    -2, 6,
  ]);
  var got = _.convexPolygon.isConvex( polygon );
  test.identical( got, false );

  /* */

  test.case = 'convex polygon - Matrix 2x3';
  var polygon = _.Matrix.Make([ 2, 3 ]).copy
  ([
     1,  3,  5,
    -2,  6,  0,
  ]);
  var got = _.convexPolygon.isConvex( polygon );
  test.identical( got, true );

  test.case = 'convex polygon - Matrix 2x4';
  var polygon = _.Matrix.Make([ 2, 4 ]).copy
  ([
     1,  3,  5,  4,
    -2,  6,  0, -1,
  ]);
  var got = _.convexPolygon.isConvex( polygon );
  test.identical( got, true );

  test.case = 'convex polygon - Matrix 2x6';
  var polygon = _.Matrix.Make([ 2, 6 ]).copy
  ([
    -2,  1,  3,  5,  6,  4,
    -4,  4,  6,  3, -1, -3,
  ]);
  var got = _.convexPolygon.isConvex( polygon );
  test.identical( got, true );

  /* */

  test.case = 'concave polygon - Matrix 2x4';
  var polygon = _.Matrix.Make([ 2, 4 ]).copy
  ([
     1,  3,  5,  4,
    -2,  6,  0,  1,
  ]);
  var got = _.convexPolygon.isConvex( polygon );
  test.identical( got, false );

  test.case = 'concave polygon - Matrix 2x6';
  var polygon = _.Matrix.Make([ 2, 6 ]).copy
  ([
    -2,  1,  3,  5,  6,  4,
    -4,  4,  6,  3,  1,  3,
  ]);
  var got = _.convexPolygon.isConvex( polygon );
  test.identical( got, false );

  test.close( '2d' );

  /* - */

  test.open( '3d' );

  test.case = 'is not a polygon - Matrix 3x2';
  var polygon = _.Matrix.Make([ 3, 2 ]).copy
  ([
     1, 3,
    -2, 6,
     1, 2,
  ]);
  var got = _.convexPolygon.isConvex( polygon );
  test.identical( got, false );

  /* */

  test.case = 'convex polygon - Matrix 3x3';
  var polygon = _.Matrix.Make([ 3, 3 ]).copy
  ([
     1,  3,  5,
    -2,  6,  0,
    -4,  1,  0,
  ]);
  var got = _.convexPolygon.isConvex( polygon );
  test.identical( got, true );

  test.case = 'convex polygon - Matrix 3x4';
  var polygon = _.Matrix.Make([ 3, 4 ]).copy
  ([
     1,  3,  5,  4,
    -2,  6,  0, -1,
     1,  1,  1,  1,
  ]);
  var got = _.convexPolygon.isConvex( polygon );
  test.identical( got, true );

  test.case = 'convex polygon - Matrix 3x6';
  var polygon = _.Matrix.Make([ 3, 6 ]).copy
  ([
    -2,  1,  3,  5,  6,  4,
    -4,  4,  6,  3, -1, -3,
     1,  1,  1,  1,  1,  1,
  ]);
  var got = _.convexPolygon.isConvex( polygon );
  test.identical( got, true );

  /* */

  test.case = 'concave polygon - Matrix 3x4';
  var polygon = _.Matrix.Make([ 3, 4 ]).copy
  ([
     1,  3,  5,  4,
    -2,  6,  0,  1,
     1,  1,  1,  1,
  ]);
  var got = _.convexPolygon.isConvex( polygon );
  test.identical( got, false );

  test.case = 'concave polygon - Matrix 2x6';
  var polygon = _.Matrix.Make([ 3, 6 ]).copy
  ([
    -2,  1,  3,  5,  6,  4,
    -4,  4,  6,  3,  1,  3,
     1,  1,  1,  1,  1,  1,
  ]);
  var got = _.convexPolygon.isConvex( polygon );
  test.identical( got, false );

  test.close( '3d' );

  /* - */

  test.case = '4d'; //
  var polygon = _.Matrix.Make([ 4, 5 ]).copy
  ([
    1, 0, 0, 0, 2,
    1, 0, 0, 0, 2,
    1, 0, 0, 0, 2,
    1, 0, 0, 0, 2
  ]);
  var got = _.convexPolygon.isConvex( polygon );
  test.identical( got, false );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.convexPolygon.isConvex() );

  test.case = 'wrong type of polygon';
  test.shouldThrowErrorSync( () => _.convexPolygon.isConvex([ 1, 2, 3, 4 ]) );
}

//

function isConcave( test )
{
  test.open( '2d' );

  test.case = 'is not a polygon - Matrix 2x2';
  var polygon = _.Matrix.Make([ 2, 2 ]).copy
  ([
     1, 3,
    -2, 6,
  ]);
  var got = _.convexPolygon.isConcave( polygon );
  test.identical( got, false );

  /* */

  test.case = 'convex polygon - Matrix 2x3';
  var polygon = _.Matrix.Make([ 2, 3 ]).copy
  ([
     1,  3,  5,
    -2,  6,  0,
  ]);
  var got = _.convexPolygon.isConcave( polygon );
  test.identical( got, false );

  test.case = 'convex polygon - Matrix 2x4';
  var polygon = _.Matrix.Make([ 2, 4 ]).copy
  ([
     1,  3,  5,  4,
    -2,  6,  0, -1,
  ]);
  var got = _.convexPolygon.isConcave( polygon );
  test.identical( got, false );

  test.case = 'convex polygon - Matrix 2x6';
  var polygon = _.Matrix.Make([ 2, 6 ]).copy
  ([
    -2,  1,  3,  5,  6,  4,
    -4,  4,  6,  3, -1, -3,
  ]);
  var got = _.convexPolygon.isConcave( polygon );
  test.identical( got, false );

  /* */

  test.case = 'concave polygon - Matrix 2x4';
  var polygon = _.Matrix.Make([ 2, 4 ]).copy
  ([
     1,  3,  5,  4,
    -2,  6,  0,  1,
  ]);
  var got = _.convexPolygon.isConcave( polygon );
  test.identical( got, true );

  test.case = 'concave polygon - Matrix 2x6';
  var polygon = _.Matrix.Make([ 2, 6 ]).copy
  ([
    -2,  1,  3,  5,  6,  4,
    -4,  4,  6,  3,  1,  3,
  ]);
  var got = _.convexPolygon.isConcave( polygon );
  test.identical( got, true );

  test.close( '2d' );

  /* - */

  test.open( '3d' );

  test.case = 'is not a polygon - Matrix 3x2';
  var polygon = _.Matrix.Make([ 3, 2 ]).copy
  ([
     1, 3,
    -2, 6,
     1, 2,
  ]);
  var got = _.convexPolygon.isConcave( polygon );
  test.identical( got, false );

  /* */

  test.case = 'convex polygon - Matrix 3x3';
  var polygon = _.Matrix.Make([ 3, 3 ]).copy
  ([
     1,  3,  5,
    -2,  6,  0,
    -4,  1,  0,
  ]);
  var got = _.convexPolygon.isConcave( polygon );
  test.identical( got, false );

  test.case = 'convex polygon - Matrix 3x4';
  var polygon = _.Matrix.Make([ 3, 4 ]).copy
  ([
     1,  3,  5,  4,
    -2,  6,  0, -1,
     1,  1,  1,  1,
  ]);
  var got = _.convexPolygon.isConcave( polygon );
  test.identical( got, false );

  test.case = 'convex polygon - Matrix 3x6';
  var polygon = _.Matrix.Make([ 3, 6 ]).copy
  ([
    -2,  1,  3,  5,  6,  4,
    -4,  4,  6,  3, -1, -3,
     1,  1,  1,  1,  1,  1,
  ]);
  var got = _.convexPolygon.isConcave( polygon );
  test.identical( got, false );

  /* */

  test.case = 'concave polygon - Matrix 3x4';
  var polygon = _.Matrix.Make([ 3, 4 ]).copy
  ([
     1,  3,  5,  4,
    -2,  6,  0,  1,
     1,  1,  1,  1,
  ]);
  var got = _.convexPolygon.isConcave( polygon );
  test.identical( got, true );

  test.case = 'concave polygon - Matrix 2x6';
  var polygon = _.Matrix.Make([ 3, 6 ]).copy
  ([
    -2,  1,  3,  5,  6,  4,
    -4,  4,  6,  3,  1,  3,
     1,  1,  1,  1,  1,  1,
  ]);
  var got = _.convexPolygon.isConcave( polygon );
  test.identical( got, true );

  test.close( '3d' );

  /* - */

  test.case = '4d'; //
  var polygon = _.Matrix.Make([ 4, 5 ]).copy
  ([
    1, 0, 0, 0, 2,
    1, 0, 0, 0, 2,
    1, 0, 0, 0, 2,
    1, 0, 0, 0, 2
  ]);
  var got = _.convexPolygon.isConcave( polygon );
  test.identical( got, false );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.convexPolygon.isConcave() );

  test.case = 'wrong type of polygon';
  test.shouldThrowErrorSync( () => _.convexPolygon.isConcave([ 1, 2, 3, 4 ]) );
}

//

function isClockwise( test )
{
  test.case = '2d clockwise'
  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    5, 2, 2, 5,
    5, 5, 1, 1
  ])
  test.true( _.convexPolygon.isClockwise( polygon ) );

  test.case = '2d counter clockwise'
  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    5, 2, 2, 5,
    1, 1, 5, 5,
  ])
  test.true( !_.convexPolygon.isClockwise( polygon ) );
}

//

function angleThreePoints( test )
{

  test.case = 'Source points and normal remain unchanged'; //

  var pointOne = [ 1, 0, 0 ];
  var pointTwo = [ 0, 0, 0 ];
  var pointThree = [ 0, 1, 0 ];
  var normal = [ 0, 0, 1 ];

  var gotAngle = _.convexPolygon.angleThreePoints( pointOne, pointTwo, pointThree, normal );

  var expected = Math.PI / 2;
  test.identical( gotAngle, expected );

  var oldPointOne = [ 1, 0, 0 ];
  test.equivalent( oldPointOne, pointOne );

  var oldPointTwo = [ 0, 0, 0 ];
  test.equivalent( oldPointTwo, pointTwo );

  var oldPointThree = [ 0, 1, 0 ];
  test.equivalent( oldPointThree, pointThree );

  var oldNormal = [ 0, 0, 1 ];
  test.equivalent( oldNormal, normal );

  test.case = 'Zero angle'; //

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 1 ], [ 2, 2 ], [ 1, 1 ] );
  var expected = 0;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 1, 1 ], [ 2, 2, 2 ], [ 1, 1, 1 ], [ 1, 0, 0 ] );
  var expected = 0;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 1, 1 ], [ 2, 2, 2 ], [ 1, 1, 1 ], [ - 1, 0, 0 ] );
  var expected = 0;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 1, 1 ], [ 2, 2, 2 ], [ 1, 1, 1 ] );
  var expected = 0;
  test.identical( gotAngle, expected );

  test.case = '3D small angle ( no normal to set angle direction )'; //

  test.description = 'Angle = PI - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 1, 1 ], [ 2, 2, 2 ], [ 3, 3, 3 ] );
  var expected = Math.PI;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 3, 3, 3 ], [ 2, 2, 2 ], [ -1, -1, -1 ] );
  var expected = Math.PI;
  test.identical( gotAngle, expected );


  test.description = 'Angle = 3* PI / 4 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 2, 0 ], [ 0, 2, 0 ], [ -1, 2, 1 ] );
  var expected = 3 * Math.PI / 4;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ -1, 2, 1 ], [ 0, 2, 0 ], [ 1, 2, 0 ] );
  var expected = 3 * Math.PI / 4;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 2 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0, 2 ], [ 0, 0, 2 ], [ 0, 1, 2 ] );
  var expected = Math.PI / 2;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 0, 1, 2 ], [ 0, 0, 2 ], [ 1, 0, 2 ] );
  var expected = Math.PI / 2;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 3 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0, 2 ], [ 0, 0, 2 ], [ Math.cos( Math.PI / 3 ), Math.sin( Math.PI / 3 ), 2 ] );
  var expected = Math.PI / 3;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ Math.cos( Math.PI / 3 ), Math.sin( Math.PI / 3 ), 2 ], [ 0, 0, 2 ], [ 1, 0, 2 ] );
  var expected = Math.PI / 3;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 4 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0, 2 ], [ 0, 0, 2 ], [ 4, 4, 2 ] );
  var expected = Math.PI / 4;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 1, 2 ], [ 0, 0, 2 ], [ 1, 0, 2 ] );
  var expected = Math.PI / 4;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 6 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0, 2 ], [ 0, 0, 2 ], [ Math.cos( Math.PI / 6 ), Math.sin( Math.PI / 6 ), 2 ] );
  var expected = Math.PI / 6;
  test.equivalent( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 3* Math.cos( Math.PI / 6 ), 3* Math.sin( Math.PI / 6 ), 2 ], [ 0, 0, 2 ], [ 1, 0, 2 ] );
  var expected = Math.PI / 6;
  test.equivalent( gotAngle, expected );

  test.case = '3D small angle with direction'; //

  test.description = 'Angle = PI - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 1, 1 ], [ 2, 2, 2 ], [ 3, 3, 3 ], [ 0, 0, 1 ] );
  var expected = Math.PI;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 3, 3, 3 ], [ 2, 2, 2 ], [ 1, 1, 1 ], [ 0, 0, 1 ] );
  var expected = 2 * Math.PI - Math.PI;
  test.identical( gotAngle, expected );


  test.description = 'Angle = 3* PI / 4 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 2, 0 ], [ 0, 2, 0 ], [ -1, 2, 1 ], [ 0, - 1, 0 ] );
  var expected = 3 * Math.PI / 4;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ -1, 2, 1 ], [ 0, 2, 0 ], [ 1, 2, 0 ], [ 0, - 1, 0 ] );
  var expected = 2 * Math.PI - 3 * Math.PI / 4;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 2 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0, 2 ], [ 0, 0, 2 ], [ 0, 1, 2 ], [ 0, 0, - 1 ] );
  var expected = 2 * Math.PI - Math.PI / 2;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 0, 1, 2 ], [ 0, 0, 2 ], [ 1, 0, 2 ], [ 0, 0, - 1 ] );
  var expected = Math.PI / 2;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 3 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0, 2 ], [ 0, 0, 2 ], [ Math.cos( Math.PI / 3 ), Math.sin( Math.PI / 3 ), 2 ], [ 0, 0, 1 ] );
  var expected = Math.PI / 3;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ Math.cos( Math.PI / 3 ), Math.sin( Math.PI / 3 ), 2 ], [ 0, 0, 2 ], [ 1, 0, 2 ], [ 0, 0, 1 ] );
  var expected = 2 * Math.PI - Math.PI / 3;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 4 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0, 2 ], [ 0, 0, 2 ], [ 4, 4, 2 ], [ 0, 0, 4 ] );
  var expected = Math.PI / 4;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 1, 2 ], [ 0, 0, 2 ], [ 1, 0, 2 ], [ 0, 0, 4 ] );
  var expected = 2 * Math.PI - Math.PI / 4;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 6 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0, 2 ], [ 0, 0, 2 ], [ Math.cos( Math.PI / 6 ), Math.sin( Math.PI / 6 ), 2 ], [ 0, 0, 1 ] );
  var expected = Math.PI / 6;
  test.equivalent( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ Math.cos( Math.PI / 6 ), Math.sin( Math.PI / 6 ), 2 ], [ 0, 0, 2 ], [ 1, 0, 2 ], [ 0, 0, 1 ] );
  var expected = 2 * Math.PI - Math.PI / 6;
  test.equivalent( gotAngle, expected );

  test.case = '2D angle'; //

  test.description = 'Angle = PI '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 1 ], [ 2, 2 ], [ 3, 3 ] );
  var expected = Math.PI;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 3, 3 ], [ 2, 2 ], [ 1, 1 ] );
  var expected = 2 * Math.PI - Math.PI;
  test.identical( gotAngle, expected );


  test.description = 'Angle = 3* PI / 4 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0 ], [ 0, 0 ], [ -1, 1 ] );
  var expected = 3 * Math.PI / 4;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ -1, 1 ], [ 0, 0 ], [ 1, 0 ] );
  var expected = 2 * Math.PI - 3 * Math.PI / 4;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 2 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0 ], [ 0, 0 ], [ 0, 1 ] );
  var expected = Math.PI / 2;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 0, 1 ], [ 0, 0 ], [ 1, 0 ] );
  var expected = 2 * Math.PI - Math.PI / 2;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 3 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0 ], [ 0, 0 ], [ Math.cos( Math.PI / 3 ), Math.sin( Math.PI / 3 ) ] );
  var expected = Math.PI / 3;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ Math.cos( Math.PI / 3 ), Math.sin( Math.PI / 3 ) ], [ 0, 0 ], [ 1, 0 ] );
  var expected = 2 * Math.PI - Math.PI / 3;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 4 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0 ], [ 0, 0 ], [ 4, 4 ] );
  var expected = Math.PI / 4;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 1 ], [ 0, 0 ], [ 1, 0 ] );
  var expected = 2 * Math.PI - Math.PI / 4;
  test.identical( gotAngle, expected );

  test.description = 'Angle = PI / 6 - both directions '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 0 ], [ 0, 0 ], [ Math.cos( Math.PI / 6 ), Math.sin( Math.PI / 6 ) ] );
  var expected = Math.PI / 6;
  test.equivalent( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ Math.cos( Math.PI / 6 ), Math.sin( Math.PI / 6 ) ], [ 0, 0 ], [ 1, 0 ] );
  var expected = 2 * Math.PI - Math.PI / 6;
  test.equivalent( gotAngle, expected );

  test.case = '2D angle'; //

  test.description = 'Angle = PI '

  var gotAngle = _.convexPolygon.angleThreePoints( [ 1, 1 ], [ 2, 2 ], [ 3, 3 ] );
  var expected = Math.PI;
  test.identical( gotAngle, expected );

  var gotAngle = _.convexPolygon.angleThreePoints( [ 3, 3 ], [ 2, 2 ], [ 1, 1 ] );
  var expected = 2 * Math.PI - Math.PI;
  test.identical( gotAngle, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon = _.Matrix.Make( [ 3, 3 ] );
  test.shouldThrowErrorSync( () => _.convexPolygon.angleThreePoints( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.angleThreePoints( [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.angleThreePoints( [ 1, 0, 0 ], [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.angleThreePoints( [ 1, 0, 0 ], [ 1, 0, 0 ], [ 1, 0, 0 ], [ 1, 0, 0 ], [ 1, 0, 0 ], ));
  test.shouldThrowErrorSync( () => _.convexPolygon.angleThreePoints( [ 1, 0, 0 ], [ 1, 0 ], [ 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.angleThreePoints( [ 1, 0, 0, 0 ], [ 1, 0, 1, 0 ], [ 1, 0, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.angleThreePoints( null, [ 1, 0, 0 ], [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.angleThreePoints( NaN, [ 1, 0, 0 ], [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.angleThreePoints( undefined, [ 1, 0, 0 ], [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.angleThreePoints( 'polygon', [ 1, 0, 0 ], [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.angleThreePoints( 3, [ 1, 0, 0 ], [ 1, 0, 0 ] ));

}

//

function make( test )
{

  test.case = 'Dim and vertices remain unchanged'; //

  var dim = 3;
  var vertices = 8;

  var gotPolygon = _.convexPolygon.make( vertices, dim );

  var expected = _.Matrix.Make( [ 3, 8 ] ).copy
  ([
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0
  ]);
  test.equivalent( gotPolygon, expected );

  var oldDim = 3;
  test.identical( dim, oldDim );

  var oldVertices = 8;
  test.identical( vertices, oldVertices );

  test.case = 'Triangle 2D'; //

  var dim = 2;
  var vertices = 3;

  var gotPolygon = _.convexPolygon.make( vertices, dim );

  var expected = _.Matrix.Make( [ 2, 3 ] ).copy
  ([
    0, 0, 0,
    0, 0, 0
  ]);
  test.equivalent( gotPolygon, expected );

  test.case = 'Square 3D'; //

  var dim = 3;
  var vertices = 4;

  var gotPolygon = _.convexPolygon.make( vertices, dim );

  var expected = _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0
  ]);
  test.equivalent( gotPolygon, expected );

  test.case = 'Pentagone 2D'; //

  var dim = 2;
  var vertices = 5;

  var gotPolygon = _.convexPolygon.make( vertices, dim );

  var expected = _.Matrix.Make( [ 2, 5 ] ).copy
  ([
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 0
  ]);
  test.equivalent( gotPolygon, expected );

  /* */

  test.case = 'from vector';

  var dim = 2;
  var vertices =
  [
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 0
  ]

  var gotPolygon = _.convexPolygon.make( vertices, dim );

  var expected = _.Matrix.Make( [ 2, 5 ] ).copy( vertices );
  test.equivalent( gotPolygon, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.convexPolygon.make( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( dim ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( vertices, dim, vertices ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( vertices, null ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( vertices, NaN ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( vertices, undefined ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( vertices, 'dim' ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( vertices, [ 3 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( null, dim ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( NaN, dim ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( undefined, dim ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( 'vertices', dim ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( [ 3 ], dim ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( 3, 1 ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( 3, 4 ));
  test.shouldThrowErrorSync( () => _.convexPolygon.make( 2, 2 ));

}

//

function pointContains( test )
{

  // test.case = 'Source polygon and point remain unchanged'; //
  //
  // var polygon = _.convexPolygon.make( 3, 3 );
  // var point = [ 1, 2, 3 ];
  //
  // var gotBool = _.convexPolygon.pointContains( polygon, point );
  //
  // var expected = false;
  // test.identical( gotBool, expected );
  //
  // var oldPolygon = _.convexPolygon.make( 3, 3 );
  // test.equivalent( oldPolygon, polygon );
  //
  // var oldPoint = [ 1, 2, 3 ];
  // test.equivalent( oldPoint, point );
  // xxx

  test.case = 'Triangle'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 3, 2 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);
  var point = [ 0.5, 0.5 ];

  debugger;
  var gotBool = _.convexPolygon.pointContains( polygon, point );
  debugger;
  var expected = true;
  test.equivalent( gotBool, expected );

  var polygon = _.convexPolygon.make( 3, 2 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);
  var point = [ 0.5, 2.5 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = false;
  test.equivalent( gotBool, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 3, 3 ).copy
  ([
    1, 4, 2,
    3, 4, 1,
    2, 2, 2
  ]);
  var point = [ 1.5, 3, 2 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = true;
  test.equivalent( gotBool, expected );

  var polygon = _.convexPolygon.make( 3, 3 ).copy
  ([
    -1, 0, 0,
    0, 0, -1,
    0, 0, 0
  ]);
  var point = [ -0.5, -0.5, 2 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Square'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    3, 3, 4, 4,
    3, 4, 4, 3
  ]);
  var point = [ 3.1, 3.9 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = true;
  test.equivalent( gotBool, expected );

  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    3, 3, 4, 4,
    3, 4, 4, 3
  ]);
  var point = [ 3.1, 4.1 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = false;
  test.equivalent( gotBool, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 4, 3 ).copy
  ([
    1, 0, 0, 1,
    0, 0, 1, 1,
    2, 2, 2, 2
  ]);
  var point = [ 0, 0.5, 2 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = true;
  test.equivalent( gotBool, expected );

  var polygon = _.convexPolygon.make( 4, 3 ).copy
  ([
    1, 0, 0, 1,
    0, 0, 1, 1,
    0, 0, 0, 0
  ]);
  var point = [ 0.5, 0.5, 2 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Pentagone 2D'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 5, 2 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1
  ]);
  var point = [ 0, 0 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = true;
  test.equivalent( gotBool, expected );

  var polygon = _.convexPolygon.make( 5, 2 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1
  ]);
  var point = [ - 0.1, 0.1 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = false;
  test.equivalent( gotBool, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 5, 3 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1,
    2, 2, 2, 2, 2
  ]);
  var point = [ 0, 0.5, 2 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = true;
  test.equivalent( gotBool, expected );

  var polygon = _.convexPolygon.make( 5, 3 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1,
    0, 0, 0, 0, 0
  ]);
  var point = [ 0.5, 0.5, 2 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Many vertices'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 10, 2 ).copy
  ([
    1,   0,  -1, -2, -2.1, -2,  -1,   0,   1, 2,
    0.1, 0, 0.1,  1,  1.5,  2, 2.5, 2.6, 2.5, 1
  ]);
  var pointT = [ 0, 0.1 ];
  var pointF = [ 0, - 0.1 ];

  var gotBool = _.convexPolygon.pointContains( polygon, pointT );
  var expected = true;
  test.equivalent( gotBool, expected );

  var gotBool = _.convexPolygon.pointContains( polygon, pointF );
  var expected = false;
  test.equivalent( gotBool, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 10, 3 ).copy
  ([
    1,   0,  -1, -2, -2.1, -2,  -1,   0,   1, 2,
    0.1, 0, 0.1,  1,  1.5,  2, 2.5, 2.6, 2.5, 1,
    4,   4,   4,  4,    4,  4,   4,   4,   4, 4
  ]);
  var pointT = [ 0, 0.1, 4 ];
  var pointF = [ 0, 0.1, 2 ];

  var gotBool = _.convexPolygon.pointContains( polygon, pointT );
  var expected = true;
  test.equivalent( gotBool, expected );

  var gotBool = _.convexPolygon.pointContains( polygon, pointF );
  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Point in vertex'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  var point = [ -1, 0.1 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Point close to vertex'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  var point = [ -1, 0 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Point in edge'; //

  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1,   0,  -1, 0,
    0, 0,  1,  2
  ]);
  var point = [ 0.5, 0 ];

  var gotBool = _.convexPolygon.pointContains( polygon, point );
  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Point in edge line but outside polygon'; //

  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  var pointOne = [ -2, 0 ];
  var pointTwo = [  2, 0 ];

  var gotBool = _.convexPolygon.pointContains( polygon, pointOne );
  var expected = false;
  test.equivalent( gotBool, expected );

  var gotBool = _.convexPolygon.pointContains( polygon, pointTwo );
  test.equivalent( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( polygon, [ 1, 0 ], [ 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( polygon, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( null, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( NaN, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( undefined, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( 'polygon', [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( [ 3 ], [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( 3, [ 1, 0, 0 ] ));

  // var polygon = _.convexPolygon.make( 4, 2 ).copy
  // ([
  //   1, 0, 0, 0.1,
  //   0, 0, 1, 0.1
  // ]);
  // test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( polygon, [ 1, 0 ] ));

  // var polygon = _.Matrix.Make( [ 1, 2 ] );
  // test.shouldThrowErrorSync( () => _.convexPolygon.pointContains( polygon, [ 1 ] ));
}

//

function pointDistance( test )
{

  test.case = 'Source polygon and point remain unchanged'; //

  var polygon = _.convexPolygon.make( 3, 3 );
  var point = [ 1, 2, 3 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );

  var expected = Math.sqrt( 14 );
  test.identical( gotDist, expected );

  var oldPolygon = _.convexPolygon.make( 3, 3 );
  test.equivalent( oldPolygon, polygon );

  var oldPoint = [ 1, 2, 3 ];
  test.equivalent( oldPoint, point );

  test.case = 'Triangle'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 3, 2 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);
  var point = [ 0.5, 0.5 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var polygon = _.convexPolygon.make( 3, 2 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);
  var point = [ 0.5, 2.5 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = Math.sqrt( 1.5*1.5 + 0.25 );
  test.equivalent( gotDist, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 3, 3 ).copy
  ([
    1, 4, 2,
    3, 4, 1,
    2, 2, 2
  ]);
  var point = [ 1.5, 3, 2 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var polygon = _.convexPolygon.make( 3, 3 ).copy
  ([
    -1, 0, 0,
    0, 0, -1,
    0, 0, 0
  ]);
  var point = [ -0.5, -0.5, 2 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 2;
  test.equivalent( gotDist, expected );

  test.case = 'Square'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    3, 3, 4, 4,
    3, 4, 4, 3
  ]);
  var point = [ 3.1, 3.9 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    3, 3, 4, 4,
    3, 4, 4, 3
  ]);
  var point = [ 3.1, 4.1 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 0.1;
  test.equivalent( gotDist, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 4, 3 ).copy
  ([
    1, 0, 0, 1,
    0, 0, 1, 1,
    2, 2, 2, 2
  ]);
  var point = [ 0, 0.5, 2 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var polygon = _.convexPolygon.make( 4, 3 ).copy
  ([
    1, 0, 0, 1,
    0, 0, 1, 1,
    0, 0, 0, 0
  ]);
  var point = [ 0.5, 0.5, 2 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 2;
  test.equivalent( gotDist, expected );

  test.case = 'Pentagone 2D'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 5, 2 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1
  ]);
  var point = [ 0, 0 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var polygon = _.convexPolygon.make( 5, 2 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1
  ]);
  var point = [ - 0.1, 0.1 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 0.1;
  test.equivalent( gotDist, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 5, 3 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1,
    2, 2, 2, 2, 2
  ]);
  var point = [ 0, 0.5, 2 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var polygon = _.convexPolygon.make( 5, 3 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1,
    0, 0, 0, 0, 0
  ]);
  var point = [ 0.5, 0.5, 2 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 2;
  test.equivalent( gotDist, expected );

  test.case = 'Many vertices'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 10, 2 ).copy
  ([
    1,   0,  -1, -2, -2.1, -2,  -1,   0,   1, 2,
    0.1, 0, 0.1,  1,  1.5,  2, 2.5, 2.6, 2.5, 1
  ]);
  var pointT = [ 0, 0.1 ];
  var pointF = [ 0, - 0.1 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, pointT );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var gotDist = _.convexPolygon.pointDistance( polygon, pointF );
  var expected = 0.1;
  test.equivalent( gotDist, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 10, 3 ).copy
  ([
    1,   0,  -1, -2, -2.1, -2,  -1,   0,   1, 2,
    0.1, 0, 0.1,  1,  1.5,  2, 2.5, 2.6, 2.5, 1,
    4,   4,   4,  4,    4,  4,   4,   4,   4, 4
  ]);
  var pointT = [ 0, 0.1, 4 ];
  var pointF = [ 0, 0.1, 2 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, pointT );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var gotDist = _.convexPolygon.pointDistance( polygon, pointF );
  var expected = 2;
  test.equivalent( gotDist, expected );

  test.case = 'Point in vertex'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  var point = [ -1, 0.1 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  test.case = 'Point close to vertex'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  var point = [ -1, 0 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 0.09950372048903948;
  test.equivalent( gotDist, expected );

  test.case = 'Point in edge'; //

  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1,   0,  -1, 0,
    0, 0,  1,  2
  ]);
  var point = [ 0.5, 0 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  test.case = 'Point in edge line but outside polygon'; //

  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  var pointOne = [ -2, 0 ];
  var pointTwo = [  2, 0 ];

  var gotDist = _.convexPolygon.pointDistance( polygon, pointOne );
  var expected = 0.7432941467979041;
  test.equivalent( gotDist, expected );

  var gotDist = _.convexPolygon.pointDistance( polygon, pointTwo );
  var expected = Math.sqrt( 1.01 );
  test.equivalent( gotDist, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( polygon, [ 1, 0 ], [ 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( polygon, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( null, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( NaN, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( undefined, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( 'polygon', [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( [ 3 ], [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( 3, [ 1, 0, 0 ] ));

  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1, 0, 0, 0.1,
    0, 0, 1, 0.1
  ]);
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( polygon, [ 1, 0 ] ));

  var polygon = _.Matrix.Make( [ 1, 2 ] );
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistance( polygon, [ 1 ] ));
}

//

function pointDistanceSqr( test )
{

  test.case = 'Source polygon and point remain unchanged'; //

  var polygon = _.convexPolygon.make( 3, 3 );
  var point = [ 1, 2, 3 ];

  var gotDist = _.convexPolygon.pointDistanceSqr( polygon, point );

  var expected = 14;
  test.identical( gotDist, expected );

  var oldPolygon = _.convexPolygon.make( 3, 3 );
  test.equivalent( oldPolygon, polygon );

  var oldPoint = [ 1, 2, 3 ];
  test.equivalent( oldPoint, point );

  test.case = 'Triangle'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 3, 2 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);
  var point = [ 0.5, 0.5 ];

  var gotDist = _.convexPolygon.pointDistanceSqr( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var polygon = _.convexPolygon.make( 3, 2 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);
  var point = [ 0.5, 2.5 ];

  var gotDist = _.convexPolygon.pointDistanceSqr( polygon, point );
  var expected = 1.5*1.5 + 0.25;
  test.equivalent( gotDist, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 3, 3 ).copy
  ([
    1, 4, 2,
    3, 4, 1,
    2, 2, 2
  ]);
  var point = [ 1.5, 3, 2 ];

  var gotDist = _.convexPolygon.pointDistanceSqr( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var polygon = _.convexPolygon.make( 3, 3 ).copy
  ([
    -1, 0, 0,
    0, 0, -1,
    0, 0, 0
  ]);
  var point = [ -0.5, -0.5, 2 ];

  var gotDist = _.convexPolygon.pointDistanceSqr( polygon, point );
  var expected = 4;
  test.equivalent( gotDist, expected );

  test.case = 'Square'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    3, 3, 4, 4,
    3, 4, 4, 3
  ]);
  var point = [ 3.1, 3.9 ];

  var gotDist = _.convexPolygon.pointDistanceSqr( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    3, 3, 4, 4,
    3, 4, 4, 3
  ]);
  var point = [ 3.1, 4.1 ];

  var gotDist = _.convexPolygon.pointDistanceSqr( polygon, point );
  var expected = _.math.sqr( 0.1 );
  test.equivalent( gotDist, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 4, 3 ).copy
  ([
    1, 0, 0, 1,
    0, 0, 1, 1,
    2, 2, 2, 2
  ]);
  var point = [ 0, 0.5, 2 ];

  var gotDist = _.convexPolygon.pointDistanceSqr( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var polygon = _.convexPolygon.make( 4, 3 ).copy
  ([
    1, 0, 0, 1,
    0, 0, 1, 1,
    0, 0, 0, 0
  ]);
  var point = [ 0.5, 0.5, 2 ];

  var gotDist = _.convexPolygon.pointDistanceSqr( polygon, point );
  var expected = 4;
  test.equivalent( gotDist, expected );

  test.case = 'Pentagone 2D'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 5, 2 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1
  ]);
  var point = [ 0, 0 ];

  var gotDist = _.convexPolygon.pointDistanceSqr( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var polygon = _.convexPolygon.make( 5, 2 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1
  ]);
  var point = [ - 0.1, 0.1 ];

  var gotDist = _.convexPolygon.pointDistanceSqr( polygon, point );
  var expected = _.math.sqr( 0.1 );;
  test.equivalent( gotDist, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 5, 3 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1,
    2, 2, 2, 2, 2
  ]);
  var point = [ 0, 0.5, 2 ];

  var gotDist = _.convexPolygon.pointDistanceSqr( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var polygon = _.convexPolygon.make( 5, 3 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1,
    0, 0, 0, 0, 0
  ]);
  var point = [ 0.5, 0.5, 2 ];

  var gotDist = _.convexPolygon.pointDistanceSqr( polygon, point );
  var expected = 4;
  test.equivalent( gotDist, expected );

  test.case = 'Many vertices'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 10, 2 ).copy
  ([
    1,   0,  -1, -2, -2.1, -2,  -1,   0,   1, 2,
    0.1, 0, 0.1,  1,  1.5,  2, 2.5, 2.6, 2.5, 1
  ]);
  var pointT = [ 0, 0.1 ];
  var pointF = [ 0, - 0.1 ];

  var gotDist = _.convexPolygon.pointDistanceSqr( polygon, pointT );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var gotDist = _.convexPolygon.pointDistanceSqr( polygon, pointF );
  var expected = _.math.sqr( 0.1 );;
  test.equivalent( gotDist, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 10, 3 ).copy
  ([
    1,   0,  -1, -2, -2.1, -2,  -1,   0,   1, 2,
    0.1, 0, 0.1,  1,  1.5,  2, 2.5, 2.6, 2.5, 1,
    4,   4,   4,  4,    4,  4,   4,   4,   4, 4
  ]);
  var pointT = [ 0, 0.1, 4 ];
  var pointF = [ 0, 0.1, 2 ];

  var gotDist = _.convexPolygon.pointDistanceSqr( polygon, pointT );
  var expected = 0;
  test.equivalent( gotDist, expected );

  var gotDist = _.convexPolygon.pointDistanceSqr( polygon, pointF );
  var expected = 4;
  test.equivalent( gotDist, expected );

  test.case = 'Point in vertex'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  var point = [ -1, 0.1 ];

  var gotDist = _.convexPolygon.pointDistanceSqr( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  test.case = 'Point close to vertex'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  var point = [ -1, 0 ];

  var gotDist = _.convexPolygon.pointDistanceSqr( polygon, point );
  var expected = _.math.sqr( 0.09950372048903948 );
  test.equivalent( gotDist, expected );

  test.case = 'Point in edge'; //

  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1,   0,  -1, 0,
    0, 0,  1,  2
  ]);
  var point = [ 0.5, 0 ];

  var gotDist = _.convexPolygon.pointDistanceSqr( polygon, point );
  var expected = 0;
  test.equivalent( gotDist, expected );

  test.case = 'Point in edge line but outside polygon'; //

  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  var pointOne = [ -2, 0 ];
  var pointTwo = [  2, 0 ];

  var gotDist = _.convexPolygon.pointDistanceSqr( polygon, pointOne );
  var expected = _.math.sqr( 0.7432941467979041 );
  test.equivalent( gotDist, expected );

  var gotDist = _.convexPolygon.pointDistanceSqr( polygon, pointTwo );
  var expected = 1.01
  test.equivalent( gotDist, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistanceSqr( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistanceSqr( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistanceSqr( polygon, [ 1, 0 ], [ 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistanceSqr( polygon, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistanceSqr( null, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistanceSqr( NaN, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistanceSqr( undefined, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistanceSqr( 'polygon', [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistanceSqr( [ 3 ], [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistanceSqr( 3, [ 1, 0, 0 ] ));

  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1, 0, 0, 0.1,
    0, 0, 1, 0.1
  ]);
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistanceSqr( polygon, [ 1, 0 ] ));

  var polygon = _.Matrix.Make( [ 1, 2 ] );
  test.shouldThrowErrorSync( () => _.convexPolygon.pointDistanceSqr( polygon, [ 1 ] ));
}

//

function pointClosestPoint( test )
{

  test.case = 'Source polygon and point remain unchanged'; //

  var polygon = _.convexPolygon.make( 3, 2 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);
  var point = [ 1, 2 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );

  var expected = _.convexPolygon.tools.long.make( [ 0, 1 ] );
  test.identical( gotClosestPoint, expected );

  var oldPolygon = _.convexPolygon.make( 3, 2 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);
  test.equivalent( oldPolygon, polygon );

  var oldPoint = [ 1, 2 ];
  test.equivalent( oldPoint, point );

  test.case = 'Triangle'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 3, 2 ).copy
  ([
    1, 0, 0,
    0, 1, 0,
  ]);
  var point = [ 0.5, 0.5 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = _.convexPolygon.tools.long.make( [ 0.5, 0.5 ] );
  test.equivalent( gotClosestPoint, expected );

  var polygon = _.convexPolygon.make( 3, 2 ).copy
  ([
    1, 0, 0,
    0, 1, 0,
  ]);
  var point = [ 0.5, 2.5 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = _.convexPolygon.tools.long.make( [ 0, 1 ] );
  test.equivalent( gotClosestPoint, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 3, 3 ).copy
  ([
    1, 2, 4,
    3, 1, 4,
    2, 2, 2,
  ]);
  var point = [ 1.5, 3, 2 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = _.convexPolygon.tools.long.make( [ 1.5, 3, 2 ] );
  test.equivalent( gotClosestPoint, expected );

  var polygon = _.convexPolygon.make( 3, 3 ).copy
  ([
    -1,  0,  0,
     0, -1,  0,
     0,  0,  0,
  ]);
  var point = [ -0.5, -0.5, 2 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = _.convexPolygon.tools.long.make( [ -0.5, -0.5, 0 ] );
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Square'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    3, 4, 4, 3,
    3, 3, 4, 4,
  ]);
  var point = [ 3.1, 3.9 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = _.convexPolygon.tools.long.make( [ 3.1, 3.9 ] );
  test.equivalent( gotClosestPoint, expected );

  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    3, 4, 4, 3,
    3, 3, 4, 4,
  ]);
  var point = [ 3.1, 4.1 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = _.convexPolygon.tools.long.make( [ 3.1, 4 ] );
  test.equivalent( gotClosestPoint, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 4, 3 ).copy
  ([
    1, 1, 0, 0,
    0, 1, 1, 0,
    2, 2, 2, 2,
  ]);
  var point = [ 0, 0.5, 2 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = _.convexPolygon.tools.long.make( [ 0, 0.5, 2 ] );
  test.equivalent( gotClosestPoint, expected );

  var polygon = _.convexPolygon.make( 4, 3 ).copy
  ([
    1, 1, 0, 0,
    0, 1, 1, 0,
    0, 0, 0, 0,
  ]);
  var point = [ 0.5, 2, 2 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = _.convexPolygon.tools.long.make( [ 0.5, 1, 0 ] );
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Pentagone 2D'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 5, 2 ).copy
  ([
    1, 0, 0, 1, 2,
    0, 0, 1, 1, 1
  ]);
  var point = [ 0, 0 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = _.convexPolygon.tools.long.make( [ 0, 0 ] );
  test.equivalent( gotClosestPoint, expected );

  var polygon = _.convexPolygon.make( 5, 2 ).copy
  ([
    1, 2, 1, 0, 0,
    0, 1, 1, 1, 0,
  ]);
  var point = [ - 0.1, 0.1 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = _.convexPolygon.tools.long.make( [ 0, 0.1 ] );
  test.equivalent( gotClosestPoint, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 5, 3 ).copy
  ([
    1, 2, 1, 0, 0,
    0, 1, 1, 1, 0,
    2, 2, 2, 2, 2,
  ]);
  var point = [ 0, 0.5, 2 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = _.convexPolygon.tools.long.make( [ 0, 0.5, 2 ] );
  test.equivalent( gotClosestPoint, expected );

  var polygon = _.convexPolygon.make( 5, 3 ).copy
  ([
    1, 2, 1, 0, 0,
    0, 1, 1, 1, 0,
    0, 0, 0, 0, 0,
  ]);
  var point = [ 0.5, 0.5, 2 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = _.convexPolygon.tools.long.make( [ 0.5, 0.5, 0 ] );
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Many vertices'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 10, 2 ).copy
  ([
    1,   2,   1,   0,  -1, -2, -2.1, -2,  -1, 0,
    0.1, 1, 2.5, 2.6, 2.5,  2,  1.5,  1, 0.1, 0,
  ]);
  var pointT = [ 0, 0.1 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, pointT );
  var expected = _.convexPolygon.tools.long.make( [ 0, 0.1 ] );
  test.equivalent( gotClosestPoint, expected );

  var pointF = [ 0, - 0.1 ];
  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, pointF );
  var expected = _.convexPolygon.tools.long.make( [ 0, 0 ] );
  test.equivalent( gotClosestPoint, expected );

  test.description = '3D';
  var polygon = _.convexPolygon.make( 10, 3 ).copy
  ([
    1,   2,   1,   0,  -1, -2, -2.1, -2,  -1, 0,
    0.1, 1, 2.5, 2.6, 2.5,  2,  1.5,  1, 0.1, 0,
    4,   4,   4,   4,   4,  4,    4,  4,   4, 4,
  ]);
  var pointT = [ 0, 0.1, 4 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, pointT );
  var expected = _.convexPolygon.tools.long.make( [ 0, 0.1, 4 ] );
  test.equivalent( gotClosestPoint, expected );

  var pointF = [ -3, 3, 2 ];
  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, pointF );
  var expected = _.convexPolygon.tools.long.make( [ -2, 2, 4 ] );
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Point in vertex'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  var point = [ -1, 0.1 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = _.convexPolygon.tools.long.make( [ -1, 0.1 ] );
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Point close to vertex'; //

  test.description = '2D';
  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1,    -2,   -1, 0,
    0.25,  1, 0.25, 0,
  ]);
  var point = [ -1, 0 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = _.convexPolygon.tools.long.make( [ -0.9411764705882353, 0.23529411764705882 ] );
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Point in edge'; //

  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1,  0, -1,  0,
    0,  2,  1,  0,
  ]);
  var point = [ 0.5, 0 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, point );
  var expected = _.convexPolygon.tools.long.make( [ 0.5, 0 ] );
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Point in edge line but outside polygon'; //

  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1,    -2,    -1,  0,
    0.15,  1,  0.15,  0,
  ]);

  var pointOne = [ -2, 0 ];
  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, pointOne );
  var expected = _.convexPolygon.tools.long.make( [ -1.5065312052018862, 0.5805515273629065 ] );
  test.equivalent( gotClosestPoint, expected );

  var pointTwo = [  2, 0 ];
  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, pointTwo );
  var expected = _.convexPolygon.tools.long.make( [ 1, 0.15 ] );
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Dst point is array'; //

  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1,     -2,    -1,  0,
    0.15,   1,  0.15,  0,
  ]);
  var srcPoint = _.vectorAdapter.from( [ -2, 0 ] );
  var dstPoint = [ 5, 5 ];

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, srcPoint, dstPoint );
  var expected = _.convexPolygon.tools.long.make( [ -1.5065312052018862, 0.5805515273629065 ] );
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Dst point is vector'; //

  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1,    -2,   -1, 0,
    0.15,  1, 0.15, 0,
  ]);
  var srcPoint = _.vectorAdapter.from( [ -2, 0 ] );
  var dstPoint = _.vectorAdapter.from( [ 5, 5 ] );

  var gotClosestPoint = _.convexPolygon.pointClosestPoint( polygon, srcPoint, dstPoint );
  var expected = _.convexPolygon.tools.vectorAdapter.from( [ -1.5065312052018862, 0.5805515273629065 ] );
  test.equivalent( gotClosestPoint, expected );


  /* */

  if( !Config.debug )
  return;

  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1,   0,  -1, -2,
    0.1, 0, 0.1,  1
  ]);
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( polygon, [ 1, 0 ], [ 1, 0 ], [ 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( polygon, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( null, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( NaN, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( undefined, [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( 'polygon', [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( [ 3 ], [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( 3, [ 1, 0, 0 ] ));

  var polygon = _.convexPolygon.make( 4, 2 ).copy
  ([
    1, 0.1, 0, 0,
    0, 0.1, 1, 0,
  ]);
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( polygon, [ 1, 0 ], null ));

  var polygon = _.Matrix.Make( [ 1, 2 ] )
  test.shouldThrowErrorSync( () => _.convexPolygon.pointClosestPoint( polygon, [ 1 ], undefined ));
}

//

function boxIntersects( test )
{

  test.description = 'Polygon and box remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1, 1, 1, 3, 3, 3 ];
  var expected = false;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  var oldBox = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( box, oldBox );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and box intersect'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 0, 0, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'Polygon and box intersect, box bigger than polygon'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ - 2, - 2, 2, 2 ];
  var expected = true;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'Polygon and box intersect, box smaller than polygon'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ - 0.2, - 0.2, 0.2, 0.2 ];
  var expected = true;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'Polygon and box not intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1, 1, 5, 5 ];
  var expected = false;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'Polygon and box almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1.1, 0, 2, 2 ];
  var expected = false;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'polygon in box edge'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var box = [ 0, 0, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'polygon in box vertex'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var box = [ 2, 1, 3, 2 ];
  var expected = true;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.case = '3D';//

  test.description = 'Polygon and box intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'Polygon and box intersect, box bigger than polygon'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'Polygon and box intersect, box smaller than polygon'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ - 0.2, - 0.2, - 0.2, 0.2, 0.2, 0.2 ];
  var expected = true;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'Polygon and box not intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1, 1, 1, 5, 5, 5 ];
  var expected = false;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'Polygon and box almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 0.1, 0, 0, 1, 1, 1 ];
  var expected = false;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'polygon in box side'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'polygon in box edge'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  test.description = 'polygon in box vertex'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var box = [ 2, 2, 1, 3, 3, 2 ];
  var expected = true;

  var gotBool = _.convexPolygon.boxIntersects( polygon, box );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( polygon, polygon, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( polygon, box, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( null, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( NaN, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( polygon, NaN));

  box = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( polygon, box ));
  box = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( polygon, box ));
  box = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.boxIntersects( polygon, box ));

}

//

function boxDistance( test )
{

  test.description = 'Polygon and box remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1, 1, 1, 3, 3, 3 ];
  var expected = Math.sqrt( 1.5 );

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  var oldBox = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( box, oldBox );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and box intersect'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 0, 0, 1, 1 ];
  var expected = 0;

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and box not intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1, 1, 5, 5 ];
  var expected = Math.sqrt( 0.5 );

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and box almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1.1, 0, 2, 2 ];
  var expected = 0.1;

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to box edge'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var box = [ 3, -3, 4, 4 ];
  var expected = 1;

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to box edge'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    0,   0,   1,   1,
    0,   1,   1,   0
  ]);
  var box = [ 2, -2, 4, 2 ];
  var expected = 1;

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to box vertex'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var box = [ 2, 3, 3, 4 ];
  var expected = 2;

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to box vertex'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1, 1, 2, 2 ];
  var expected = Math.sqrt( 0.5 );

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.case = '3D';//

  test.description = 'Polygon and box intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and box not intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1, 1, 1, 5, 5, 5 ];
  var expected = Math.sqrt( 1.5 );

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and box almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 0.1, 0, 0, 1, 1, 1 ];
  var expected = 0.1;

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to box side'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1,
    0,   0,   0,   0
  ]);
  var box = [ 2, -2, -2, 4, 2, 2 ];
  var expected = 1;

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to box side'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    1,   1,   0,
   -1,   1,   0,
    0,   0,   0
  ]);
  var box = [ 2, -2, -2, 4, 2, 2 ];
  var expected = 1;

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to box edge'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    2,   3,   3,   2,
    2,   3,   4,   3,
    2,   3,   3,   2
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = Math.sqrt( 3 );

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to box edge'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   1,   1,
    0,   0,   1,
    2,   2,   4
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 1;

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to box vertex'; //

  var polygon =  _.Matrix.Make( [ 3, 5 ] ).copy
  ([
    2,   3,   4,   3,   2,
    2,   3,   4,   4,   3,
    2,   3,   4,   5,   4
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = Math.sqrt( 3 );

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to box vertex'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = Math.sqrt( 2 ) / 2;

  var gotDist = _.convexPolygon.boxDistance( polygon, box );
  test.equivalent( gotDist, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( polygon, polygon, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( polygon, box, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( null, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( NaN, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( polygon, NaN));

  box = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( polygon, box ));
  box = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( polygon, box ));
  box = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.boxDistance( polygon, box ));

}
boxDistance.timeOut = 9000;

//

function boxClosestPoint( test )
{

  test.description = 'Polygon and box remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1, 1, 1, 3, 3, 3 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0.5, 0.5 ] );

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  var oldBox = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( box, oldBox );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and box intersect'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 0, 0, 1, 1 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and box not intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1, 1, 5, 5 ];
  var expected = _.convexPolygon.tools.long.make( [ 0.5, 0.5 ] );

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and box almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1.1, 0, 2, 2 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0 ] );

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to box edge'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var box = [ 3, -3, 4, 4 ];
  var expected = _.convexPolygon.tools.long.make( [ 2, 1 ] );

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to box edge'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    0,   0,   1,   1,
    0,   1,   1,   0
  ]);
  var box = [ 2, -2, 4, 2 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 1 ] );

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to box vertex'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var box = [ 2, 3, 3, 4 ];
  var expected = _.convexPolygon.tools.long.make( [ 2, 1 ] );

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to box vertex'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1, 1, 2, 2 ];
  var expected = _.convexPolygon.tools.long.make( [ 0.5, 0.5 ] );

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.case = '3D';//

  test.description = 'Polygon and box intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and box not intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 1, 1, 1, 5, 5, 5 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0.5, 0.5 ] );

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and box almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var box = [ 0.1, 0, 0, 1, 1, 1 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 1, 0 ] );

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to box side'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1,
    0,   0,   0,   0
  ]);
  var box = [ 2, -2, -2, 4, 2, 2 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0, 0 ] );

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to box side'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    1,   1,   0,
   -1,   1,   0,
    0,   0,   0
  ]);
  var box = [ 2, -2, -2, 4, 2, 2 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, -1, 0 ] );

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to box edge'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    2,   3,   3,   2,
    2,   3,   4,   3,
    2,   3,   3,   2
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = _.convexPolygon.tools.long.make( [ 2, 2, 2 ] );

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to box edge'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   1,   1,
    0,   0,   1,
    2,   2,   4
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0, 2 ] );

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to box vertex'; //

  var polygon =  _.Matrix.Make( [ 3, 5 ] ).copy
  ([
    2,   3,   4,   3,   2,
    2,   3,   4,   4,   3,
    2,   3,   4,   5,   4
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = _.convexPolygon.tools.long.make( [ 2, 2, 2 ] );

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to box vertex'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 1.5, 1.5 ] );

  var gotPoint = _.convexPolygon.boxClosestPoint( polygon, box );
  test.equivalent( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( polygon, polygon, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( polygon, box, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( null, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( NaN, box ));
  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( polygon, NaN));

  box = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( polygon, box ));
  box = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( polygon, box ));
  box = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.boxClosestPoint( polygon, box ));

}

//

function boundingBoxGet( test )
{

  /* */

  test.case = 'Source polygon remains unchanged';

  var srcPolygon = _.Matrix.Make( [ 3, 4 ] ).copy
    ([
      0,   0,   1,   1,
      0,   0,   1,   1,
      0,   1,   1,   0
    ]);
  var dstBox = [ 1, 1, 1, 2, 2, 2 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0, 0, 1, 1, 1 ] );

  var gotBox = _.convexPolygon.boundingBoxGet( srcPolygon, dstBox );
  test.identical( expected, gotBox );
  test.true( dstBox === gotBox );

  var oldSrcPolygon = _.Matrix.Make( [ 3, 4 ] ).copy
    ([
      0,   0,   1,   1,
      0,   0,   1,   1,
      0,   1,   1,   0
    ]);
  test.identical( srcPolygon, oldSrcPolygon );

  /* */

  test.case = 'Polygon inside box';

  var srcPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
    ([
      0,   0,   3,   3,
      0,   0,   2,   2,
      0,   1,   1,   0
    ]);
  var dstBox = [ -1, -1, -1, 5, 5, 5 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0, 0, 3, 2, 1 ] );

  var gotBox = _.convexPolygon.boundingBoxGet( srcPolygon, dstBox );
  test.identical( gotBox, expected );

  /* */

  test.case = 'Polygon outside Box';

  var srcPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
    ([
      3,   3,   3,   3,
      5,   3,   3,   5,
      3,   4,   2,   2
    ]);
  var dstBox = [ 0, 0, 0, 1, 1, 1 ];
  var expected = _.convexPolygon.tools.long.make( [ 3, 3, 2, 3, 5, 4 ] );

  var gotBox = _.convexPolygon.boundingBoxGet( srcPolygon, dstBox );
  test.identical( gotBox, expected );

  /* */

  test.case = 'Negative polygon values';

  var srcPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
    ([
      0,   0, - 1, - 1,
      0,   0, - 1, - 1,
      0, - 1, - 1,   0
    ]);
  var dstBox = [ 3, 3, 3, 4, 4, 4 ];
  var expected = _.convexPolygon.tools.long.make( [ - 1, - 1, - 1, 0, 0, 0 ] );

  var gotBox = _.convexPolygon.boundingBoxGet( srcPolygon, dstBox );
  test.identical( gotBox, expected );

  test.case = '2D'; //

  var srcPolygon = _.Matrix.Make( [ 2, 4 ] ).copy
    ([
      3,   6,   -1,   1,
      -2,   0,   7,   1
    ]);
  var dstBox = [ 3, 3, 4, 4 ];
  var expected = _.convexPolygon.tools.long.make( [ -1, -2, 6, 7 ] );

  var gotBox = _.convexPolygon.boundingBoxGet( srcPolygon, dstBox );
  test.identical( gotBox, expected );

  /* */

  test.case = 'dstBox vector';

  var srcPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
    ([
      0,   0,   2,   2,
      0,   2,   2,   0,
      0,   2,   2,   0
    ]);
  var dstBox = _.vectorAdapter.from( [ 1, 2, 3, 9, 10, - 1 ] );
  var expected = _.convexPolygon.tools.vectorAdapter.from( [ 0, 0, 0, 2, 2, 2  ] );

  var gotBox = _.convexPolygon.boundingBoxGet( srcPolygon, dstBox );
  test.identical( gotBox, expected );

  /* */

  test.case = 'dstBox null';

  var srcPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
    ([
      0,   0,  -2,  -2,
      0,   0,  -2,  -2,
      0,  -1,  -2,   0
    ]);
  var dstBox = null;
  var expected = _.convexPolygon.tools.long.make( [ -2, -2, -2, 0, 0, 0 ] );

  var gotBox = _.convexPolygon.boundingBoxGet( srcPolygon, dstBox );
  test.equivalent( gotBox, expected );

  /* */

  test.case = 'dstBox undefined';

  var srcPolygon =  _.Matrix.Make( [ 3, 3 ] ).copy
    ([
      0,   0,   1,
      1,   1,   3,
      0,   1,   1
    ]);
  var dstBox = undefined;
  var expected = _.convexPolygon.tools.long.make( [ 0, 1, 0, 1, 3, 1 ] );

  var gotBox = _.convexPolygon.boundingBoxGet( srcPolygon, dstBox );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  var srcPolygon = _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0,  -1,   0,
    0,   1,   0, - 1
  ]);
  test.shouldThrowErrorSync( () => _.convexPolygon.boundingBoxGet( ) );
  test.shouldThrowErrorSync( () => _.convexPolygon.boundingBoxGet( [] ) );
  test.shouldThrowErrorSync( () => _.convexPolygon.boundingBoxGet( [], [] ) );
  test.shouldThrowErrorSync( () => _.convexPolygon.boundingBoxGet( 'polygon', 'box' ) );
  test.shouldThrowErrorSync( () => _.convexPolygon.boundingBoxGet( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.convexPolygon.boundingBoxGet( srcPolygon, [ 1, 0, 1, 2, 1, 2 ], [ 0, 0, 0, 1, 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.convexPolygon.boundingBoxGet( NaN, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.convexPolygon.boundingBoxGet( null, [ 0, 1, 0, 1, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.convexPolygon.boundingBoxGet( srcPolygon, NaN ) );
  test.shouldThrowErrorSync( () => _.convexPolygon.boundingBoxGet( srcPolygon, [ 0, 1, 0, 1, 2 ]  ) );

}

//

function capsuleIntersects( test )
{

  test.description = 'Polygon and capsule remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1, 1, 1, 3, 3, 3, 1 ];
  var expected = false;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  var oldCapsule = [ 1, 1, 1, 3, 3, 3, 1 ];
  test.identical( capsule, oldCapsule );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and capsule intersect'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 0, 0, 1, 1, 0.5 ];
  var expected = true;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'Polygon and capsule intersect, capsule bigger than polygon'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ - 2, - 2, 2, 2, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'Polygon and capsule intersect, capsule smaller than polygon'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ - 0.2, - 0.2, 0.2, 0.2, 0.1 ];
  var expected = true;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'Polygon and capsule not intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1, 1, 5, 5, 0.5 ];
  var expected = false;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'Polygon and capsule almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1.1, 0, 2, 2, 0.05 ];
  var expected = false;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'capsule is polygon´s edge'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var capsule = [ 0, 0, 0, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'polygon in capsule vertex'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var capsule = [ -1, 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.case = '3D';//

  test.description = 'Polygon and capsule intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 0, 0, 0, 1, 1, 1, 0.5 ];
  var expected = true;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'Polygon and capsule intersect, capsule bigger than polygon'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ - 2, - 2, - 2, 2, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'Polygon and capsule intersect, capsule smaller than polygon'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ - 0.2, - 0.2, - 0.2, 0.2, 0.2, 0.2, 0.2 ];
  var expected = true;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'Polygon and capsule not intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1, 1, 1, 5, 5, 5, 1 ];
  var expected = false;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'Polygon and capsule almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 0.1, 0, 0, 1, 1, 1, 0.05 ];
  var expected = false;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'polygon in capsule side'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    1,   3,   2,
    1,   1,   2,
    0,   0,   1
  ]);
  var capsule = [ 0, 0, 0, 1, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  test.description = 'polygon in capsule vertex'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var capsule = [ 3, 2, 1, 3, 3, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.capsuleIntersects( polygon, capsule );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( polygon, polygon, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( polygon, capsule, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( null, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( NaN, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( polygon, NaN));

  capsule = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( polygon, capsule ));
  capsule = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( polygon, capsule ));
  // capsule = [ 0, 0, 1, 1, 2, 2, - 2 ];
  // test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( polygon, capsule ));
  capsule = [ 0, 0, 1, 1, 2, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleIntersects( polygon, capsule ));

}

//

function capsuleDistance( test )
{

  test.description = 'Polygon and capsule remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1, 1, 1, 3, 3, 3, 0.5 ];
  var expected = Math.sqrt( 1.5 ) - 0.5;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  var oldCapsule = [ 1, 1, 1, 3, 3, 3, 0.5 ];
  test.identical( capsule, oldCapsule );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and capsule intersect'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 0, 0, 1, 1, 0.5 ];
  var expected = 0;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and capsule not intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1, 1, 5, 5, 0.1 ];
  var expected = Math.sqrt( 0.5 ) - 0.1;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and capsule almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1.1, 0, 2, 2, 0.05 ];
  var expected = 0.05;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to capsule origin'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var capsule = [ 0, 0, -4, -4, 0.5 ];
  var expected = 0.5;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to capsule end'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    0,   1,   1,   0,
    0,   0,   1,   1,
  ]);
  var capsule = [ 0.5, -2, 0.5, -1, 0.3 ];
  var expected = 0.7;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to capsule'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   2,   2,   1,
    0,   0,   1,   1,
  ]);
  var capsule = [ 0, 0.5, 1, -0.5, 0.01 ];
  var expected = Math.sqrt( 0.125 ) - 0.01;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to capsule'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 3, 0, 0, 3, 1 ];
  var expected = Math.sqrt( 2 ) - 1;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.case = '3D';//

  test.description = 'Polygon and capsule intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 0, 0, 0, 1, 1, 1, 0.2 ];
  var expected = 0;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and capsule not intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1, 1, 1, 5, 5, 5, 0.3 ];
  var expected = Math.sqrt( 1.5 ) - 0.3;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and capsule almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 0.1, 0, 0, 1, 1, 1, 0.05 ];
  var expected = 0.05;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to capsule'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    2,   3,   3,   2,
    2,   3,   4,   3,
    2,   3,   3,   2
  ]);
  var capsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var expected = Math.sqrt( 3 ) - 1;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to capsule origin'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   1,   1,
    0,   0,   1,
    2,   2,   4
  ]);
  var capsule = [ 0.5, 0, 0.5, 0.5, 1, - 1, 0.5 ];
  var expected = 1;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to capsule end'; //

  var polygon =  _.Matrix.Make( [ 3, 5 ] ).copy
  ([
    2,   3,   4,   3,   2,
    2,   3,   4,   4,   3,
    2,   3,   4,   5,   4
  ]);
  var capsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var expected = Math.sqrt( 3 ) - 1;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to capsule'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);
  var capsule = [ -1, 0, 0, 1, 0, 0, 1 ];
  var expected = Math.sqrt( 4.5 ) - 1;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to capsule'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);
  var capsule = [ -1, 3, -1, 1, 3, -1, 0.5 ];
  var expected = 0.5;

  var gotDist = _.convexPolygon.capsuleDistance( polygon, capsule );
  test.equivalent( gotDist, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( polygon, polygon, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( polygon, capsule, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( null, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( NaN, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( polygon, NaN));

  capsule = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( polygon, capsule ));
  capsule = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( polygon, capsule ));
  // capsule = [ 0, 0, 1, 1, 2, 2, - 2 ];
  // test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( polygon, capsule ));
  capsule = [ 0, 0, 1, 1, 2, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleDistance( polygon, capsule ));

}

//

function capsuleClosestPoint( test )
{

  test.description = 'Polygon and capsule remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1, 1, 1, 3, 3, 3, 1 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0.5, 0.5 ] );

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  var oldCapsule = [ 1, 1, 1, 3, 3, 3, 1 ];
  test.identical( capsule, oldCapsule );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and capsule intersect'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 0, 0, 1, 1, 0.5 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and capsule not intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1, 1, 5, 5, 0.3 ];
  var expected = _.convexPolygon.tools.long.make( [ 0.5, 0.5 ] );

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and capsule almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1.1, 0, 2, 2, 0.05 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0 ] );

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to capsule origin'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var capsule = [ 0, 0, -1, -1, 0.5 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0 ] );

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to capsule end'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    0,   1,   1,   0,
    0,   0,   1,   1,
  ]);
  var capsule = [ 0.5, -2, 0.5, -1, 0.5 ];
  var expected = _.convexPolygon.tools.long.make( [ 0.5, 0 ] );

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to capsule'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    0,   0,   1,   1,
    0,   1,   1,   0
  ]);
  var capsule = [ 0, 3, 3, 0, 0.2 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 1 ] );

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to capsule'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 0, 3, 3, 0, 0.2 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0 ] );

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.case = '3D';//

  test.description = 'Polygon and capsule intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 0, 0, 0, 1, 1, 1, 0.5 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and capsule not intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 1, 1, 1, 5, 5, 5, 1 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0.5, 0.5 ] );

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and capsule almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var capsule = [ 0.1, 0, 0, 1, 1, 1, 0.05 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0, 0 ] );

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to capsule origin'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1,
    0,   0,   0,   0
  ]);
  var capsule = [ 1, 0, 2, 4, 3, 4, 1 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0, 0 ] );

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to capsule end'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    1,   1,   0,
   -1,   1,   0,
    0,   0,   0
  ]);
  var capsule = [ 2, 0, 3, 2, 0, 0, 0.5 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0, 0 ] );

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to capsule'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    2,   3,   3,   2,
    2,   3,   4,   3,
    2,   3,   3,   2
  ]);
  var capsule = [ 0, 1, 0, 0, 1, 5, 1 ];
  var expected = _.convexPolygon.tools.long.make( [ 2, 2, 2 ] );

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to capsule'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   1,   1,
    0,   0,   1,
    2,   2,   4
  ]);
  var capsule = [ 2, -1, 3, 2, 1, 3, 0.2 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0.6, 3.2 ] );

  var gotPoint = _.convexPolygon.capsuleClosestPoint( polygon, capsule );
  test.equivalent( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( polygon, polygon, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( polygon, capsule, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( null, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( NaN, capsule ));
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( polygon, NaN));

  capsule = [ 0, 0, 1, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( polygon, capsule ));
  capsule = [ 0, 0, 1, 1, 2, 1 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( polygon, capsule ));
  // capsule = [ 0, 0, 1, 1, 2, 2, - 2 ];
  // test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( polygon, capsule ));
  capsule = [ 0, 0, 1, 1, 2, 2, 2, 1 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.capsuleClosestPoint( polygon, capsule ));

}

//

function frustumIntersects( test )
{

  test.description = 'Polygon and frustum remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0,  -1,   0,
    0,   1,   0, - 1
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = true;

  var gotBool = _.convexPolygon.frustumIntersects( polygon, frustum );
  test.identical( gotBool, expected );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0,  -1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  var oldFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  test.identical( frustum, oldFrustum );

  test.description = 'Polygon and frustum intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    0,   1,   2,   0,
    0,   1,   3,   2
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = true;

  var gotBool = _.convexPolygon.frustumIntersects( polygon, frustum );
  test.identical( gotBool, expected );

  test.description = 'Polygon and frustum don´t intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    0,   1,   2,   0,
    0,   1,   3,   2
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3,   4, - 3,   4,   4, - 3,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = false;

  var gotBool = _.convexPolygon.frustumIntersects( polygon, frustum );
  test.identical( gotBool, expected );

  test.description = 'Polygon and frustum almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   2,   1,   0,
    0,   0,   1,   2,
    0,   1,   1,   1
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2,   1.1, - 2,   1.1,   1.1, - 2,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = false;

  var gotBool = _.convexPolygon.frustumIntersects( polygon, frustum );
  test.identical( gotBool, expected );

  test.description = 'Polygon and frustum just touching'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   2,   1,   0,
    0,   0,   1,   2,
    0,   1,   1,   1
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2,   1, - 2,   1,   1, - 2,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = true;

  var gotBool = _.convexPolygon.frustumIntersects( polygon, frustum );
  test.identical( gotBool, expected );

  test.description = 'Polygon and frustum just intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   2,   1,   0,
    0,   0,   1,   2,
    0,   1,   1,   1
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 0.9, - 2, 0.9, 0.9, -2,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = true;

  var gotBool = _.convexPolygon.frustumIntersects( polygon, frustum );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   2,   1,   0,
    0,   0,   1,   2,
    0,   1,   1,   1
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 0.9, - 2, 0.9, 0.9, -2,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumIntersects( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumIntersects( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumIntersects( polygon, polygon, frustum ));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumIntersects( null, frustum ));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumIntersects( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumIntersects( NaN, frustum ));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumIntersects( polygon, NaN));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumIntersects( [], frustum ));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumIntersects( polygon, [] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumIntersects( polygon, _.frustum.make() ));
  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    0,   2,   1,   0,
    0,   0,   1,   2,
  ]);
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumIntersects( polygon, frustum ));

}

//

function frustumDistance( test )
{

  test.description = 'Polygon and frustum remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0,  -1,   0,
    0,   1,   0, - 1
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = 0;

  var gotBool = _.convexPolygon.frustumDistance( polygon, frustum );
  test.identical( gotBool, expected );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0,  -1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  var oldFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  test.identical( frustum, oldFrustum );

  test.description = 'Polygon and frustum intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    0,   1,   2,   0,
    0,   1,   3,   2
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = 0;

  var gotBool = _.convexPolygon.frustumDistance( polygon, frustum );
  test.identical( gotBool, expected );

  test.description = 'Polygon and frustum don´t intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    0,   1,   2,   0,
    0,   1,   3,   2
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3,   4, - 3,   4,   4, - 3,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = Math.sqrt( 10 );

  var gotBool = _.convexPolygon.frustumDistance( polygon, frustum );
  test.identical( gotBool, expected );

  test.description = 'Polygon and frustum almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   2,   1,   0,
    0,   0,   1,   2,
    0,   1,   1,   1
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2,   1.1, - 2,   1.1,   1.1, - 2,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = Math.sqrt( 0.03 );

  var gotBool = _.convexPolygon.frustumDistance( polygon, frustum );
  test.equivalent( gotBool, expected );

  test.description = 'Polygon and frustum just touching'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   2,   1,   0,
    0,   0,   1,   2,
    0,   1,   1,   1
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2,   1, - 2,   1,   1, - 2,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = 0;

  var gotBool = _.convexPolygon.frustumDistance( polygon, frustum );
  test.identical( gotBool, expected );

  test.description = 'Polygon and frustum just intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   2,   1,   0,
    0,   0,   1,   2,
    0,   1,   1,   1
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 0.9, - 2, 0.9, 0.9, -2,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = 0;

  var gotBool = _.convexPolygon.frustumDistance( polygon, frustum );
  test.identical( gotBool, expected );

  test.description = 'Polygon vertex next to frustum'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    -0.9,   0,   0.9,   0,
    -0.8,   0,   0.8,   0,
    0.7,   1,   0.7,   0
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 1, - 2,   1,   1,  -2,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = Math.sqrt( 0.14 );

  var gotBool = _.convexPolygon.frustumDistance( polygon, frustum );
  test.equivalent( gotBool, expected );

  test.description = 'Polygon side next to frustum'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,    -2,  -1,
    0,   0,    -2,  -1,
    0,   3,     2,   1
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 1, - 2,   1,   1,  -2,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = Math.sqrt( 2 );

  var gotBool = _.convexPolygon.frustumDistance( polygon, frustum );
  test.equivalent( gotBool, expected );

  /* */

  if( !Config.debug )
  return;
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   2,   1,   0,
    0,   0,   1,   2,
    0,   1,   1,   1
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 0.9, - 2, 0.9, 0.9, -2,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumDistance( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumDistance( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumDistance( polygon, polygon, frustum ));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumDistance( null, frustum ));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumDistance( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumDistance( NaN, frustum ));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumDistance( polygon, NaN));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumDistance( [], frustum ));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumDistance( polygon, [] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumDistance( polygon, _.frustum.make() ));
  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    0,   2,   1,   0,
    0,   0,   1,   2,
  ]);
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumDistance( polygon, frustum ));

}

//

function frustumClosestPoint( test )
{

  test.description = 'Polygon and frustum remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0,  -1,   0,
    0,   1,   0, - 1
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = 0;

  var gotBool = _.convexPolygon.frustumClosestPoint( polygon, frustum );
  test.identical( gotBool, expected );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0,  -1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  var oldFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  test.identical( frustum, oldFrustum );

  test.description = 'Polygon and frustum intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    0,   1,   2,   0,
    0,   1,   3,   2
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = 0;

  var gotBool = _.convexPolygon.frustumClosestPoint( polygon, frustum );
  test.identical( gotBool, expected );

  test.description = 'Polygon and frustum don´t intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    0,   1,   2,   0,
    0,   1,   3,   2
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3,   4, - 3,   4,   4, - 3,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = _.convexPolygon.tools.long.make( [ 0, 2, 3 ] );

  var gotBool = _.convexPolygon.frustumClosestPoint( polygon, frustum );
  test.identical( gotBool, expected );

  test.description = 'Polygon and frustum almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   2,   1,   0,
    0,   0,   1,   2,
    0,   1,   1,   1
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2,   1.1, - 2,   1.1,   1.1, - 2,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = _.convexPolygon.tools.long.make( [ 1, 1, 1 ] );

  var gotBool = _.convexPolygon.frustumClosestPoint( polygon, frustum );
  test.identical( gotBool, expected );

  test.description = 'Polygon and frustum just touching'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   2,   1,   0,
    0,   0,   1,   2,
    0,   1,   1,   1
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2,   1, - 2,   1,   1, - 2,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = 0;

  var gotBool = _.convexPolygon.frustumClosestPoint( polygon, frustum );
  test.identical( gotBool, expected );

  test.description = 'Polygon and frustum just intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   2,   1,   0,
    0,   0,   1,   2,
    0,   1,   1,   1
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 0.9, - 2, 0.9, 0.9, -2,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = 0;

  var gotBool = _.convexPolygon.frustumClosestPoint( polygon, frustum );
  test.identical( gotBool, expected );

  test.description = 'Polygon vertex next to frustum'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    -0.9,   0,   0.9,   0,
    -0.8,   0,   0.8,   0,
    0.7,   1,   0.7,   0
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 1, - 2,   1,   1,  -2,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = _.convexPolygon.tools.long.make( [ 0.9, 0.8, 0.7 ] );

  var gotBool = _.convexPolygon.frustumClosestPoint( polygon, frustum );
  test.equivalent( gotBool, expected );

  test.description = 'Polygon side next to frustum'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,    -2,  -1,
    0,   0,    -2,  -1,
    0,   3,     2,   1
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 1, - 2,   1,   1,  -2,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = _.convexPolygon.tools.long.make( [ 0, 0, 2 ] );

  var gotBool = _.convexPolygon.frustumClosestPoint( polygon, frustum );
  test.identical( gotBool, expected );

  test.description = 'dstPoint is vector'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   1,     1,   0,
    0,   0,     2,   4,
    4,   3,     4,   6
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 1, - 2,   1,   1,  -2,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var expected = _.convexPolygon.tools.vectorAdapter.from( [ 1, 0.4, 3.2 ] );

  var gotBool = _.convexPolygon.frustumClosestPoint( polygon, frustum, _.vectorAdapter.from( [ 0, 0, 0 ] ) );
  test.equivalent( gotBool, expected );

  /* */

  if( !Config.debug )
  return;
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   2,   1,   0,
    0,   0,   1,   2,
    0,   1,   1,   1
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 0.9, - 2, 0.9, 0.9, -2,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumClosestPoint( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumClosestPoint( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumClosestPoint( polygon, polygon, frustum ));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumClosestPoint( null, frustum ));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumClosestPoint( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumClosestPoint( NaN, frustum ));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumClosestPoint( polygon, NaN));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumClosestPoint( [], frustum ));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumClosestPoint( polygon, [] ));
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumClosestPoint( polygon, _.frustum.make() ));
  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    0,   2,   1,   0,
    0,   0,   1,   2,
  ]);
  test.shouldThrowErrorSync( () => _.convexPolygon.frustumClosestPoint( polygon, frustum ));

}

//

function lineIntersects( test )
{

  test.description = 'Polygon and line remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 1, 1, 1, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.lineIntersects( polygon, line );
  test.identical( gotBool, expected );

  var oldLine = [ 1, 1, 1, 1, 1, 1 ];
  test.identical( line, oldLine );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and line intersect'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 0, 0, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.lineIntersects( polygon, line );
  test.identical( gotBool, expected );

  test.description = 'Polygon and line intersect, positive factor'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ - 2, - 2, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.lineIntersects( polygon, line );
  test.identical( gotBool, expected );

  test.description = 'Polygon and line intersect, negative factor'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 2, 2, -1, -1 ];
  var expected = true;

  var gotBool = _.convexPolygon.lineIntersects( polygon, line );
  test.identical( gotBool, expected );

  test.description = 'Polygon and line not intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 5, 5, 1, 0 ];
  var expected = false;

  var gotBool = _.convexPolygon.lineIntersects( polygon, line );
  test.identical( gotBool, expected );

  test.description = 'Polygon and line almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 1.1, 0, 0, 2 ];
  var expected = false;

  var gotBool = _.convexPolygon.lineIntersects( polygon, line );
  test.identical( gotBool, expected );

  test.description = 'line is polygon´s edge'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var line = [ 1, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.lineIntersects( polygon, line );
  test.identical( gotBool, expected );

  test.description = 'polygon in line vertex'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var line = [ 0, 0, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.lineIntersects( polygon, line );
  test.identical( gotBool, expected );

  test.case = '3D';//

  test.description = 'Polygon and line intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.lineIntersects( polygon, line );
  test.identical( gotBool, expected );

  test.description = 'Polygon and line intersect, positive factor'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ - 2, - 2, - 2, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.lineIntersects( polygon, line );
  test.identical( gotBool, expected );

  test.description = 'Polygon and line intersect, negative factor'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 2, 2, 2, -1, -1, -1 ];
  var expected = true;

  var gotBool = _.convexPolygon.lineIntersects( polygon, line );
  test.identical( gotBool, expected );

  test.description = 'Polygon and line not intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 2, 2, 2, 1, 0, 0 ];
  var expected = false;

  var gotBool = _.convexPolygon.lineIntersects( polygon, line );
  test.identical( gotBool, expected );

  test.description = 'Polygon and line almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 0.1, 0, 0, 0, 1, 1 ];
  var expected = false;

  var gotBool = _.convexPolygon.lineIntersects( polygon, line );
  test.identical( gotBool, expected );

  test.description = 'line in polygon edge'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 0, 1, 0, 0, -1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.lineIntersects( polygon, line );
  test.identical( gotBool, expected );

  test.description = 'line in polygon vertex'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var line = [ 0, 0, 0, 3, 3, 3 ];
  var expected = true;

  var gotBool = _.convexPolygon.lineIntersects( polygon, line );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.lineIntersects( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineIntersects( line ));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineIntersects( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineIntersects( polygon, polygon, line ));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineIntersects( polygon, line, line ));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineIntersects( null, line ));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineIntersects( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineIntersects( NaN, line ));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineIntersects( polygon, NaN));

  line = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.lineIntersects( polygon, line ));
  line = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.convexPolygon.lineIntersects( polygon, line ));
  line = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.lineIntersects( polygon, line ));

}

//

function lineDistance( test )
{

  test.description = 'Polygon and line remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 1, 1, 1, 0, 1, 0 ];
  var expected = 1;

  var gotDist = _.convexPolygon.lineDistance( polygon, line );
  test.equivalent( gotDist, expected );

  var oldLine = [ 1, 1, 1, 0, 1, 0 ];
  test.identical( line, oldLine );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and line intersect'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 0, 0, 1, 1 ];
  var expected = 0;

  var gotDist = _.convexPolygon.lineDistance( polygon, line );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and line not intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 1, 1, 1, -1 ];
  var expected = Math.sqrt( 0.5 );

  var gotDist = _.convexPolygon.lineDistance( polygon, line );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and line almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 1.1, 0, 0, 2 ];
  var expected = 0.1;

  var gotDist = _.convexPolygon.lineDistance( polygon, line );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to line origin'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var line = [ 0, 0, 0, -1 ];
  var expected = 1;

  var gotDist = _.convexPolygon.lineDistance( polygon, line );
  test.equivalent( gotDist, expected );

  var gotDist = _.convexPolygon.lineDistance( polygon, line );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to line'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var line = [ 0, 0, 1, -1 ];
  var expected = Math.sqrt( 0.5 );

  var gotDist = _.convexPolygon.lineDistance( polygon, line );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to line'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 3, 0, -1, 1 ];
  var expected = Math.sqrt( 2 );

  var gotDist = _.convexPolygon.lineDistance( polygon, line );
  test.equivalent( gotDist, expected );

  test.case = '3D';//

  test.description = 'Polygon and line intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotDist = _.convexPolygon.lineDistance( polygon, line );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and line not intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 1, 1, 1, 0, 5, 5 ];
  var expected = 1;

  var gotDist = _.convexPolygon.lineDistance( polygon, line );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and line almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 0.1, 0, 0, 0, 1, 1 ];
  var expected = 0.1;

  var gotDist = _.convexPolygon.lineDistance( polygon, line );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to line origin'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    2,   3,   3,   2,
    2,   3,   4,   3,
    2,   3,   3,   2
  ]);
  var line = [ 3, 3, 4, 1, 0, 0 ];
  var expected = 1;

  var gotDist = _.convexPolygon.lineDistance( polygon, line );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to line origin'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   1,   1,
    0,   0,   1,
    2,   2,   4
  ]);
  var line = [ 0.5, 0, 0, 0, 1, 0 ];
  var expected = 2;

  var gotDist = _.convexPolygon.lineDistance( polygon, line );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to line'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);
  var line = [ 1, 2, 2, 0, 1, -1 ];
  var expected = 1;

  var gotDist = _.convexPolygon.lineDistance( polygon, line );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to line'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);
  var line = [ 0, 0, -1, 0, 3, 0 ];
  var expected = 1;

  var gotDist = _.convexPolygon.lineDistance( polygon, line );
  test.equivalent( gotDist, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.lineDistance( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineDistance( line ));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineDistance( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineDistance( polygon, polygon, line ));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineDistance( polygon, line, line ));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineDistance( null, line ));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineDistance( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineDistance( NaN, line ));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineDistance( polygon, NaN));

  line = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.lineDistance( polygon, line ));
  line = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.convexPolygon.lineDistance( polygon, line ));
  line = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.lineDistance( polygon, line ));

}

//

function lineClosestPoint( test )
{

  test.description = 'Polygon and line remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 1, 1, 1, 0, 1, 0 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0, 1 ] );

  var gotPoint = _.convexPolygon.lineClosestPoint( polygon, line );
  test.equivalent( gotPoint, expected );

  var oldLine = [ 1, 1, 1, 0, 1, 0 ];
  test.identical( line, oldLine );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and line intersect'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 0, 0, 1, 1 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.lineClosestPoint( polygon, line );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and line not intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 1, 1, 1, -1 ];
  var expected = _.convexPolygon.tools.long.make( [ 0.5, 0.5 ] );

  var gotPoint = _.convexPolygon.lineClosestPoint( polygon, line );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and line almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 1.1, 0, 0, 2 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0 ] );

  var gotPoint = _.convexPolygon.lineClosestPoint( polygon, line );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to line origin'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var line = [ 0, 0, 0, -1 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0 ] );

  var gotPoint = _.convexPolygon.lineClosestPoint( polygon, line );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to line'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    0,   0,   1,   1,
    0,   1,   1,   0
  ]);
  var line = [ 0, - 3, 3, 0 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0 ] );

  var gotPoint = _.convexPolygon.lineClosestPoint( polygon, line );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to line'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 3, - 1, -1, 1 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0 ] );

  var gotPoint = _.convexPolygon.lineClosestPoint( polygon, line );
  test.equivalent( gotPoint, expected );

  test.case = '3D';//

  test.description = 'Polygon and line intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.lineClosestPoint( polygon, line );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and line not intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 1, 1, 1, 0, 5, 5 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0.5, 0.5 ] );

  var gotPoint = _.convexPolygon.lineClosestPoint( polygon, line );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and line almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var line = [ 0.1, 0, 0, 0, 1, 1 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0, 0 ] );

  var gotPoint = _.convexPolygon.lineClosestPoint( polygon, line );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to line origin'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1,
    0,   0,   0,   0
  ]);
  var line = [ 1, 0, 2, 0, 1, 0 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0, 0 ] );

  var gotPoint = _.convexPolygon.lineClosestPoint( polygon, line );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to line'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    2,   3,   3,   2,
    2,   3,   4,   3,
    2,   3,   3,   2
  ]);
  var line = [ 0, 0, 0, 0, 1, 0 ];
  var expected = _.convexPolygon.tools.long.make( [ 2, 2, 2 ] );

  var gotPoint = _.convexPolygon.lineClosestPoint( polygon, line );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to line'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   1,   1,
    0,   0,   1,
    2,   2,   4
  ]);
  var line = [ -2, 0, 0, 2, 0, 0 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0, 2 ] );

  var gotPoint = _.convexPolygon.lineClosestPoint( polygon, line );
  test.equivalent( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.lineClosestPoint( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineClosestPoint( line ));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineClosestPoint( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineClosestPoint( polygon, polygon, line ));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineClosestPoint( polygon, line, line ));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineClosestPoint( null, line ));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineClosestPoint( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineClosestPoint( NaN, line ));
  test.shouldThrowErrorSync( () => _.convexPolygon.lineClosestPoint( polygon, NaN));

  line = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.lineClosestPoint( polygon, line ));
  line = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.convexPolygon.lineClosestPoint( polygon, line ));
  line = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.lineClosestPoint( polygon, line ));

}

//

function planeIntersects( test )
{

  test.description = 'Polygon and plane remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ 3, 1, 0, 0 ];
  var expected = false;

  var gotBool = _.convexPolygon.planeIntersects( polygon, plane );
  test.identical( gotBool, expected );

  var oldPlane = [ 3, 1, 0, 0 ];
  test.identical( plane, oldPlane );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.description = 'Polygon and plane intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ 0, 0, -1, 2 ];
  var expected = true;

  var gotBool = _.convexPolygon.planeIntersects( polygon, plane );
  test.identical( gotBool, expected );

  test.description = 'Polygon in plane'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ 0, 1, 0, 0 ];
  var expected = true;

  var gotBool = _.convexPolygon.planeIntersects( polygon, plane );
  test.identical( gotBool, expected );

  test.description = 'Polygon and plane don´t intersect, parallel'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ 1, 1, 0, 0 ];
  var expected = false;

  var gotBool = _.convexPolygon.planeIntersects( polygon, plane );
  test.identical( gotBool, expected );

  test.description = 'Polygon and plane don´t intersect, perpendicular'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ -2, 0, 1, 0 ];
  var expected = false;

  var gotBool = _.convexPolygon.planeIntersects( polygon, plane );
  test.identical( gotBool, expected );

  test.description = 'Polygon and plane almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ 0.1, 1, 0, 0 ];
  var expected = false;

  var gotBool = _.convexPolygon.planeIntersects( polygon, plane );
  test.identical( gotBool, expected );

  test.description = 'Polygon vertex in plane'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ -1, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.planeIntersects( polygon, plane );
  test.identical( gotBool, expected );

  test.description = 'Polygon edge in plane'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ -1, 0, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.planeIntersects( polygon, plane );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.planeIntersects( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeIntersects( plane ));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeIntersects( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeIntersects( polygon, polygon, plane ));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeIntersects( polygon, plane, plane ));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeIntersects( null, plane ));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeIntersects( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeIntersects( NaN, plane ));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeIntersects( polygon, NaN));

  plane = [ 0, 0, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.planeIntersects( polygon, plane ));
  plane = [ 0, 0, 1, 1, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.planeIntersects( polygon, plane ));

}

//

function planeDistance( test )
{

  test.description = 'Polygon and plane remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ 3, 1, 0, 0 ];
  var expected = 3;

  var gotDist = _.convexPolygon.planeDistance( polygon, plane );
  test.identical( gotDist, expected );

  var oldPlane = [ 3, 1, 0, 0 ];
  test.identical( plane, oldPlane );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.description = 'Polygon and plane intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ 0, 0, -1, 2 ];
  var expected = 0;

  var gotDist = _.convexPolygon.planeDistance( polygon, plane );
  test.identical( gotDist, expected );

  test.description = 'Polygon in plane'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ 0, 1, 0, 0 ];
  var expected = 0;

  var gotDist = _.convexPolygon.planeDistance( polygon, plane );
  test.identical( gotDist, expected );

  test.description = 'Polygon and plane don´t intersect, parallel'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ 1, 1, 0, 0 ];
  var expected = 1;

  var gotDist = _.convexPolygon.planeDistance( polygon, plane );
  test.identical( gotDist, expected );

  test.description = 'Polygon and plane don´t intersect, perpendicular'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ -2, 0, 1, 0 ];
  var expected = 1;

  var gotDist = _.convexPolygon.planeDistance( polygon, plane );
  test.identical( gotDist, expected );

  test.description = 'Polygon and plane almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ 0.1, 1, 0, 0 ];
  var expected = 0.1;

  var gotDist = _.convexPolygon.planeDistance( polygon, plane );
  test.identical( gotDist, expected );

  test.description = 'Polygon vertex in plane'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ -1, 0, 0, 1 ];
  var expected = 0;

  var gotDist = _.convexPolygon.planeDistance( polygon, plane );
  test.identical( gotDist, expected );

  test.description = 'Polygon vertex next to the plane'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ -1.2, 0, 0, 1 ];
  var expected = 0.2;

  var gotDist = _.convexPolygon.planeDistance( polygon, plane );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon edge in plane'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ -1, 0, 1, 1 ];
  var expected = 0;

  var gotDist = _.convexPolygon.planeDistance( polygon, plane );
  test.identical( gotDist, expected );

  test.description = 'Polygon edge next to the plane'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ -1.1, 0, 1, 1 ];
  var expected = 0.1 * Math.sqrt( 2 ) / 2;

  var gotDist = _.convexPolygon.planeDistance( polygon, plane );
  test.equivalent( gotDist, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.planeDistance( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeDistance( plane ));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeDistance( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeDistance( polygon, polygon, plane ));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeDistance( polygon, plane, plane ));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeDistance( null, plane ));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeDistance( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeDistance( NaN, plane ));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeDistance( polygon, NaN));

  plane = [ 0, 0, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.planeDistance( polygon, plane ));
  plane = [ 0, 0, 1, 1, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.planeDistance( polygon, plane ));

}

//

function planeClosestPoint( test )
{

  test.description = 'Polygon and plane remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ 3, 1, 0, 0 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 1, 0 ] );

  var gotPoint = _.convexPolygon.planeClosestPoint( polygon, plane );
  test.identical( gotPoint, expected );

  var oldPlane = [ 3, 1, 0, 0 ];
  test.identical( plane, oldPlane );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.description = 'Polygon and plane intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ 0, 0, -1, 2 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.planeClosestPoint( polygon, plane );
  test.identical( gotPoint, expected );

  test.description = 'Polygon in plane'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ 0, 1, 0, 0 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.planeClosestPoint( polygon, plane );
  test.identical( gotPoint, expected );

  test.description = 'Polygon and plane don´t intersect, parallel'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ 1, 1, 0, 0 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 1, 0 ] );

  var gotPoint = _.convexPolygon.planeClosestPoint( polygon, plane );
  test.identical( gotPoint, expected );

  test.description = 'Polygon and plane don´t intersect, perpendicular'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ 2, 0, 1, 0 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, -1, 0 ] );

  var gotPoint = _.convexPolygon.planeClosestPoint( polygon, plane );
  test.identical( gotPoint, expected );

  test.description = 'Polygon and plane almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ 0.1, 1, 0, 0 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 1, 0 ] );

  var gotPoint = _.convexPolygon.planeClosestPoint( polygon, plane );
  test.identical( gotPoint, expected );

  test.description = 'Polygon vertex in plane'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ -1, 0, 0, 1 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.planeClosestPoint( polygon, plane );
  test.identical( gotPoint, expected );

  test.description = 'Polygon vertex next to the plane'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ -1.2, 0, 0, 1 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0, 1 ] );

  var gotPoint = _.convexPolygon.planeClosestPoint( polygon, plane );
  test.identical( gotPoint, expected );

  test.description = 'Polygon edge in plane'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ -1, 0, 1, 1 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.planeClosestPoint( polygon, plane );
  test.identical( gotPoint, expected );

  test.description = 'Polygon edge next to the plane'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var plane = [ -1.1, 0, 1, 1 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 1, 0] );

  var gotPoint = _.convexPolygon.planeClosestPoint( polygon, plane );
  test.identical( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.planeClosestPoint( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeClosestPoint( plane ));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeClosestPoint( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeClosestPoint( polygon, polygon, plane ));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeClosestPoint( polygon, plane, plane ));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeClosestPoint( null, plane ));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeClosestPoint( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeClosestPoint( NaN, plane ));
  test.shouldThrowErrorSync( () => _.convexPolygon.planeClosestPoint( polygon, NaN));

  plane = [ 0, 0, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.planeClosestPoint( polygon, plane ));
  plane = [ 0, 0, 1, 1, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.planeClosestPoint( polygon, plane ));

}

//

function rayIntersects( test )
{

  test.description = 'Polygon and ray remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 1, 1, 1, 1, 1, 1 ];
  var expected = false;

  var gotBool = _.convexPolygon.rayIntersects( polygon, ray );
  test.identical( gotBool, expected );

  var oldRay = [ 1, 1, 1, 1, 1, 1 ];
  test.identical( ray, oldRay );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and ray intersect'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 0, 0, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.rayIntersects( polygon, ray );
  test.identical( gotBool, expected );

  test.description = 'Polygon and ray intersect, positive factor'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ - 2, - 2, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.rayIntersects( polygon, ray );
  test.identical( gotBool, expected );

  test.description = 'Polygon and ray don´t intersect, negative factor'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ -2, -2, -1, -1 ];
  var expected = false;

  var gotBool = _.convexPolygon.rayIntersects( polygon, ray );
  test.identical( gotBool, expected );

  test.description = 'Polygon and ray not intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 5, 5, 1, 0 ];
  var expected = false;

  var gotBool = _.convexPolygon.rayIntersects( polygon, ray );
  test.identical( gotBool, expected );

  test.description = 'Polygon and ray almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 1.1, 0, 0, 2 ];
  var expected = false;

  var gotBool = _.convexPolygon.rayIntersects( polygon, ray );
  test.identical( gotBool, expected );

  test.description = 'ray is polygon´s edge'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var ray = [ 1, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.rayIntersects( polygon, ray );
  test.identical( gotBool, expected );

  test.description = 'polygon in ray vertex'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var ray = [ 0, 0, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.rayIntersects( polygon, ray );
  test.identical( gotBool, expected );

  test.case = '3D';//

  test.description = 'Polygon and ray intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.rayIntersects( polygon, ray );
  test.identical( gotBool, expected );

  test.description = 'Polygon and ray intersect, positive factor'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ - 2, - 2, - 2, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.rayIntersects( polygon, ray );
  test.identical( gotBool, expected );

  test.description = 'Polygon and ray don´t intersect, negative factor'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 2, 2, 2, 1, 1, 1 ];
  var expected = false;

  var gotBool = _.convexPolygon.rayIntersects( polygon, ray );
  test.identical( gotBool, expected );

  test.description = 'Polygon and ray not intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 2, 2, 2, 1, 0, 0 ];
  var expected = false;

  var gotBool = _.convexPolygon.rayIntersects( polygon, ray );
  test.identical( gotBool, expected );

  test.description = 'Polygon and ray almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 0.1, 0, 0, 0, 1, 1 ];
  var expected = false;

  var gotBool = _.convexPolygon.rayIntersects( polygon, ray );
  test.identical( gotBool, expected );

  test.description = 'ray in polygon edge'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 0, 1, 0, 0, -1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.rayIntersects( polygon, ray );
  test.identical( gotBool, expected );

  test.description = 'ray in polygon vertex'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var ray = [ 0, 0, 0, 3, 3, 3 ];
  var expected = true;

  var gotBool = _.convexPolygon.rayIntersects( polygon, ray );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.rayIntersects( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayIntersects( ray ));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayIntersects( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayIntersects( polygon, polygon, ray ));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayIntersects( polygon, ray, ray ));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayIntersects( null, ray ));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayIntersects( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayIntersects( NaN, ray ));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayIntersects( polygon, NaN));

  ray = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.rayIntersects( polygon, ray ));
  ray = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.convexPolygon.rayIntersects( polygon, ray ));
  ray = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.rayIntersects( polygon, ray ));

}

//

function rayDistance( test )
{

  test.description = 'Polygon and ray remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 1, 1, 1, 0, 1, 0 ];
  var expected = Math.sqrt( 1.5 );

  var gotDist = _.convexPolygon.rayDistance( polygon, ray );
  test.equivalent( gotDist, expected );

  var oldRay = [ 1, 1, 1, 0, 1, 0 ];
  test.identical( ray, oldRay );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and ray intersect'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 0, 0, 1, 1 ];
  var expected = 0;

  var gotDist = _.convexPolygon.rayDistance( polygon, ray );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and ray not intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 1, 1, 1, -1 ];
  var expected = Math.sqrt( 0.5 );

  var gotDist = _.convexPolygon.rayDistance( polygon, ray );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and ray almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 1.1, 0, 0, 2 ];
  var expected = 0.1;

  var gotDist = _.convexPolygon.rayDistance( polygon, ray );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to ray origin'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var ray = [ 0, 0, 0, -1 ];
  var expected = 1;

  var gotDist = _.convexPolygon.rayDistance( polygon, ray );
  test.equivalent( gotDist, expected );

  var gotDist = _.convexPolygon.rayDistance( polygon, ray );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to ray'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var ray = [ 0, 0, 1, -1 ];
  var expected = Math.sqrt( 0.5 );

  var gotDist = _.convexPolygon.rayDistance( polygon, ray );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to ray'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 3, 0, -1, 1 ];
  var expected = Math.sqrt( 2 );

  var gotDist = _.convexPolygon.rayDistance( polygon, ray );
  test.equivalent( gotDist, expected );

  test.case = '3D';//

  test.description = 'Polygon and ray intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotDist = _.convexPolygon.rayDistance( polygon, ray );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and ray not intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 1, 1, 1, 0, 5, 5 ];
  var expected = Math.sqrt( 1.5 );

  var gotDist = _.convexPolygon.rayDistance( polygon, ray );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and ray almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 0.1, 0, 0, 0, 1, 1 ];
  var expected = 0.1;

  var gotDist = _.convexPolygon.rayDistance( polygon, ray );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to ray origin'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    2,   3,   3,   2,
    2,   3,   4,   3,
    2,   3,   3,   2
  ]);
  var ray = [ 3, 3, 4, 0, 0, 1 ];
  var expected = 1;

  var gotDist = _.convexPolygon.rayDistance( polygon, ray );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to ray origin'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   1,   1,
    0,   0,   1,
    2,   2,   4
  ]);
  var ray = [ 0.5, 0, 0, 0, 1, 0 ];
  var expected = 2;

  var gotDist = _.convexPolygon.rayDistance( polygon, ray );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to ray'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);
  var ray = [ 1, 2, 2, 0, 1, -1 ];
  var expected = 1;

  var gotDist = _.convexPolygon.rayDistance( polygon, ray );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to ray'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);
  var ray = [ 0, 0, -1, 0, 3, 0 ];
  var expected = 1;

  var gotDist = _.convexPolygon.rayDistance( polygon, ray );
  test.equivalent( gotDist, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.rayDistance( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayDistance( ray ));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayDistance( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayDistance( polygon, polygon, ray ));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayDistance( polygon, ray, ray ));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayDistance( null, ray ));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayDistance( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayDistance( NaN, ray ));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayDistance( polygon, NaN));

  ray = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.rayDistance( polygon, ray ));
  ray = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.convexPolygon.rayDistance( polygon, ray ));
  ray = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.rayDistance( polygon, ray ));

}

//

function rayClosestPoint( test )
{

  test.description = 'Polygon and ray remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 1, 1, 1, 0, 1, 0 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0.5, 0.5 ] );

  var gotPoint = _.convexPolygon.rayClosestPoint( polygon, ray );
  test.equivalent( gotPoint, expected );

  var oldRay = [ 1, 1, 1, 0, 1, 0 ];
  test.identical( ray, oldRay );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and ray intersect'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 0, 0, 1, 1 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.rayClosestPoint( polygon, ray );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and ray not intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 1, 1, 1, -1 ];
  var expected = _.convexPolygon.tools.long.make( [ 0.5, 0.5 ] );

  var gotPoint = _.convexPolygon.rayClosestPoint( polygon, ray );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and ray almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 1.1, 0, 0, 2 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0 ] );

  var gotPoint = _.convexPolygon.rayClosestPoint( polygon, ray );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to ray origin'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var ray = [ 0, 0, 0, -1 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0 ] );

  var gotPoint = _.convexPolygon.rayClosestPoint( polygon, ray );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to ray'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    0,   0,   1,   1,
    0,   1,   1,   0
  ]);
  var ray = [ 0, - 3, 3, 0 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0 ] );

  var gotPoint = _.convexPolygon.rayClosestPoint( polygon, ray );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to ray'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 3, - 1, -1, 1 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0 ] );

  var gotPoint = _.convexPolygon.rayClosestPoint( polygon, ray );
  test.equivalent( gotPoint, expected );

  test.case = '3D';//

  test.description = 'Polygon and ray intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.rayClosestPoint( polygon, ray );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and ray not intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 1, 1, 1, 0, 5, 5 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0.5, 0.5 ] );

  var gotPoint = _.convexPolygon.rayClosestPoint( polygon, ray );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and ray almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var ray = [ 0.1, 0, 0, 0, 1, 1 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0, 0 ] );

  var gotPoint = _.convexPolygon.rayClosestPoint( polygon, ray );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to ray origin'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1,
    0,   0,   0,   0
  ]);
  var ray = [ 1, 0, 2, 0, 0, 1 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0, 0 ] );

  var gotPoint = _.convexPolygon.rayClosestPoint( polygon, ray );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to ray'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    2,   3,   3,   2,
    2,   3,   4,   3,
    2,   3,   3,   2
  ]);
  var ray = [ 0, 0, 0, 0, 1, 0 ];
  var expected = _.convexPolygon.tools.long.make( [ 2, 2, 2 ] );

  var gotPoint = _.convexPolygon.rayClosestPoint( polygon, ray );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to ray'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   1,   1,
    0,   0,   1,
    2,   2,   4
  ]);
  var ray = [ -2, 0, 0, 2, 0, 0 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0, 2 ] );

  var gotPoint = _.convexPolygon.rayClosestPoint( polygon, ray );
  test.equivalent( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.rayClosestPoint( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayClosestPoint( ray ));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayClosestPoint( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayClosestPoint( polygon, polygon, ray ));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayClosestPoint( polygon, ray, ray ));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayClosestPoint( null, ray ));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayClosestPoint( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayClosestPoint( NaN, ray ));
  test.shouldThrowErrorSync( () => _.convexPolygon.rayClosestPoint( polygon, NaN));

  ray = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.rayClosestPoint( polygon, ray ));
  ray = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.convexPolygon.rayClosestPoint( polygon, ray ));
  ray = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.rayClosestPoint( polygon, ray ));

}

//

function segmentContains( test )
{

  test.description = 'Polygon and segment remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1, 1, 1, 3, 3, 3 ];
  var expected = false;

  var gotBool = _.convexPolygon.segmentContains( polygon, segment );
  test.identical( gotBool, expected );

  var oldSegment = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( segment, oldSegment );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon away from segment'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 3, 3, 5, 6 ];
  var expected = false;

  var gotBool = _.convexPolygon.segmentContains( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'Polygon and segment intersect'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0, 0, 1, 1 ];
  var expected = false;

  var gotBool = _.convexPolygon.segmentContains( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'Polygon contains segment'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentContains( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'Segment in polygon side'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentContains( polygon, segment );
  test.identical( gotBool, expected );

  test.case = '3D';//

  test.description = 'Polygon and segment intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = false;

  var gotBool = _.convexPolygon.segmentContains( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'Polygon away from segment'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ - 2, - 2, -3, 4 ];
  var expected = false;

  var gotBool = _.convexPolygon.segmentContains( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'Polygon contains segment'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0, - 0.2, - 0.2, 0, 0.2, 0.2 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentContains( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'Segment is polygon side'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0, 1, 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentContains( polygon, segment );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.segmentContains( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentContains( segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentContains( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentContains( polygon, polygon, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentContains( polygon, segment, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentContains( null, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentContains( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentContains( NaN, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentContains( polygon, NaN));

  segment = [ 0, 0, 1 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentContains( polygon, segment ));
  segment = [ 0, 0, 1, 1, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentContains( polygon, segment ));

}

//

function segmentIntersects( test )
{

  test.description = 'Polygon and segment remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1, 1, 1, 3, 3, 3 ];
  var expected = false;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  var oldSegment = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( segment, oldSegment );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and segment intersect'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0, 0, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'Polygon and segment intersect, segment bigger than polygon'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ - 2, - 2, 2, 2 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'Polygon and segment intersect, segment smaller than polygon'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ - 0.2, - 0.2, 0.2, 0.2 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'Polygon and segment not intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1, 1, 5, 5 ];
  var expected = false;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'Polygon and segment almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1.1, 0, 2, 2 ];
  var expected = false;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'segment is polygon´s edge'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var segment = [ 1, 0, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'polygon in segment vertex'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var segment = [ 0, 0, 1, 0 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.case = '3D';//

  test.description = 'Polygon and segment intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'Polygon and segment intersect, segment bigger than polygon'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'Polygon and segment intersect, segment smaller than polygon'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ - 0.2, - 0.2, - 0.2, 0.2, 0.2, 0.2 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'Polygon and segment not intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1, 1, 1, 5, 5, 5 ];
  var expected = false;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'Polygon and segment almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0.1, 0, 0, 1, 1, 1 ];
  var expected = false;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'polygon in segment side'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'polygon in segment edge'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var segment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  test.description = 'polygon in segment vertex'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var segment = [ 2, 2, 1, 3, 3, 2 ];
  var expected = true;

  var gotBool = _.convexPolygon.segmentIntersects( polygon, segment );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( polygon, polygon, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( polygon, segment, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( null, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( NaN, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( polygon, NaN));

  segment = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( polygon, segment ));
  segment = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( polygon, segment ));
  segment = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentIntersects( polygon, segment ));

}

//

function segmentDistance( test )
{

  test.description = 'Polygon and segment remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1, 1, 1, 3, 3, 3 ];
  var expected = Math.sqrt( 1.5 );

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  var oldSegment = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( segment, oldSegment );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and segment intersect'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0, 0, 1, 1 ];
  var expected = 0;

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and segment not intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1, 1, 5, 5 ];
  var expected = Math.sqrt( 0.5 );

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and segment almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1.1, 0, 2, 2 ];
  var expected = 0.1;

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to segment origin'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var segment = [ 0, 0, -4, -4 ];
  var expected = 1;

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to segment end'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    0,   1,   1,   0,
    0,   0,   1,   1,
  ]);
  var segment = [ 0.5, -2, 0.5, -1 ];
  var expected = 1;

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to segment'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   2,   2,   1,
    0,   0,   1,   1,
  ]);
  var segment = [ 0, 0.5, 1, -0.5 ];
  var expected = Math.sqrt( 0.125 );

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to segment'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 3, 0, 0, 3 ];
  var expected = Math.sqrt( 2 );

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.case = '3D';//

  test.description = 'Polygon and segment intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and segment not intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1, 1, 1, 5, 5, 5 ];
  var expected = Math.sqrt( 1.5 );

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and segment almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0.1, 0, 0, 1, 1, 1 ];
  var expected = 0.1;

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to segment edge'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    2,   3,   3,   2,
    2,   3,   4,   3,
    2,   3,   3,   2
  ]);
  var segment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = Math.sqrt( 3 );

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to segment origin'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   1,   1,
    0,   0,   1,
    2,   2,   4
  ]);
  var segment = [ 0.5, 0, 0.5, 0.5, 1, - 1 ];
  var expected = 1.5;

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to segment end'; //

  var polygon =  _.Matrix.Make( [ 3, 5 ] ).copy
  ([
    2,   3,   4,   3,   2,
    2,   3,   4,   4,   3,
    2,   3,   4,   5,   4
  ]);
  var segment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = Math.sqrt( 3 );

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'polygon edge next to segment'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);
  var segment = [ -1, 0, 0, 1, 0, 0 ];
  var expected = Math.sqrt( 4.5 );

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  test.description = 'polygon vertex next to segment'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);
  var segment = [ -1, 3, -1, 1, 3, -1 ];
  var expected = 1;

  var gotDist = _.convexPolygon.segmentDistance( polygon, segment );
  test.equivalent( gotDist, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( polygon, polygon, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( polygon, segment, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( null, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( NaN, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( polygon, NaN));

  segment = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( polygon, segment ));
  segment = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( polygon, segment ));
  segment = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentDistance( polygon, segment ));

}

//

function segmentClosestPoint( test )
{

  test.description = 'Polygon and segment remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1, 1, 1, 3, 3, 3 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0.5, 0.5 ] );

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  var oldSegment = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( segment, oldSegment );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and segment intersect'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0, 0, 1, 1 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and segment not intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1, 1, 5, 5 ];
  var expected = _.convexPolygon.tools.long.make( [ 0.5, 0.5 ] );

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and segment almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1.1, 0, 2, 2 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0 ] );

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to segment origin'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var segment = [ 0, 0, -1, -1 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0 ] );

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to segment end'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    0,  1,  1,  0,
    0,  0,  1,  1,
  ]);
  var segment = [ 0.5, -2, 0.5, -1 ];
  var expected = _.convexPolygon.tools.long.make( [ 0.5, 0 ] );

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to segment'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    0,   0,   1,   1,
    0,   1,   1,   0
  ]);
  var segment = [ 0, 3, 3, 0 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 1 ] );

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to segment'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 2, - 1, 2, 2 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0 ] );

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.case = '3D';//

  test.description = 'Polygon and segment intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and segment not intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 1, 1, 1, 5, 5, 5 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0.5, 0.5 ] );

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'Polygon and segment almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var segment = [ 0.1, 0, 0, 1, 1, 1 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0, 0 ] );

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to segment origin'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1,
    0,   0,   0,   0
  ]);
  var segment = [ 1, 0, 2, 4, 3, 4 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0, 0 ] );

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to segment end'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    1,   1,   0,
   -1,   1,   0,
    0,   0,   0
  ]);
  var segment = [ 2, 0, 3, 2, 0, 0 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0, 0 ] );

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon vertex next to segment'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    2,   3,   3,   2,
    2,   3,   4,   3,
    2,   3,   3,   2
  ]);
  var segment = [ 0, 1, 0, 0, 1, 5 ];
  var expected = _.convexPolygon.tools.long.make( [ 2, 2, 2 ] );

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  test.description = 'polygon edge next to segment'; //

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   1,   1,
    0,   0,   1,
    2,   2,   4
  ]);
  var segment = [ 2, -1, 3, 2, 1, 3 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0.6, 3.2 ] );

  var gotPoint = _.convexPolygon.segmentClosestPoint( polygon, segment );
  test.equivalent( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    0,   3,   4,
    3,   0,   4
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( polygon, polygon, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( polygon, segment, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( null, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( NaN, segment ));
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( polygon, NaN));

  segment = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( polygon, segment ));
  segment = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( polygon, segment ));
  segment = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.segmentClosestPoint( polygon, segment ));

}

//

function sphereIntersects( test )
{

  test.description = 'Polygon and sphere remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 1, 1, 1, 3 ];
  var expected = true;

  var gotBool = _.convexPolygon.sphereIntersects( polygon, sphere );
  test.identical( gotBool, expected );

  var oldSphere = [ 1, 1, 1, 3 ];
  test.identical( sphere, oldSphere );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and sphere intersect'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 0, 0, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.sphereIntersects( polygon, sphere );
  test.identical( gotBool, expected );

  test.description = 'Polygon and sphere intersect, sphere bigger than polygon'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 0, 0, 2 ];
  var expected = true;

  var gotBool = _.convexPolygon.sphereIntersects( polygon, sphere );
  test.identical( gotBool, expected );

  test.description = 'Polygon and sphere intersect, sphere smaller than polygon'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 0, 0, 0.2 ];
  var expected = true;

  var gotBool = _.convexPolygon.sphereIntersects( polygon, sphere );
  test.identical( gotBool, expected );

  test.description = 'Polygon and sphere not intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 1, 5, 1 ];
  var expected = false;

  var gotBool = _.convexPolygon.sphereIntersects( polygon, sphere );
  test.identical( gotBool, expected );

  test.description = 'Polygon and sphere almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 2, 0, 0.9 ];
  var expected = false;

  var gotBool = _.convexPolygon.sphereIntersects( polygon, sphere );
  test.identical( gotBool, expected );

  test.description = 'sphere in polygon´s edge'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var sphere = [ 0, 0.5, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.sphereIntersects( polygon, sphere );
  test.identical( gotBool, expected );

  test.description = 'sphere in polygon vertex'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var sphere = [ 0, -1, Math.sqrt( 2 )];
  var expected = true;

  var gotBool = _.convexPolygon.sphereIntersects( polygon, sphere );
  test.identical( gotBool, expected );

  test.case = '3D';//

  test.description = 'Polygon and sphere intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.convexPolygon.sphereIntersects( polygon, sphere );
  test.identical( gotBool, expected );

  test.description = 'Polygon and sphere intersect, sphere bigger than polygon'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 0, 0, 0, 2 ];
  var expected = true;

  var gotBool = _.convexPolygon.sphereIntersects( polygon, sphere );
  test.identical( gotBool, expected );

  test.description = 'Polygon and sphere intersect, sphere smaller than polygon'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 0, 0, 0, 0.2 ];
  var expected = true;

  var gotBool = _.convexPolygon.sphereIntersects( polygon, sphere );
  test.identical( gotBool, expected );

  test.description = 'Polygon and sphere not intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 1, 1, 5, 1 ];
  var expected = false;

  var gotBool = _.convexPolygon.sphereIntersects( polygon, sphere );
  test.identical( gotBool, expected );

  test.description = 'Polygon and sphere almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 1, 0, 0, 0.9 ];
  var expected = false;

  var gotBool = _.convexPolygon.sphereIntersects( polygon, sphere );
  test.identical( gotBool, expected );

  test.description = 'sphere in polygon edge'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var sphere = [ 0, 0, 0.5, Math.sqrt( 2 ) ];
  var expected = true;

  var gotBool = _.convexPolygon.sphereIntersects( polygon, sphere );
  test.identical( gotBool, expected );

  test.description = 'sphere in polygon vertex'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var sphere = [ 0, 0, -1, Math.sqrt( 3 ) ];
  var expected = true;

  var gotBool = _.convexPolygon.sphereIntersects( polygon, sphere );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.sphereIntersects( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereIntersects( sphere ));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereIntersects( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereIntersects( polygon, polygon, sphere ));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereIntersects( polygon, sphere, sphere ));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereIntersects( null, sphere ));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereIntersects( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereIntersects( NaN, sphere ));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereIntersects( polygon, NaN));

  sphere = [ 0, 0, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereIntersects( polygon, sphere ));
  sphere = [ 0, 0, 1, 1, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereIntersects( polygon, sphere ));
  sphere = [ 0, 0, 1, 1, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereIntersects( polygon, sphere ));

}

//

function sphereDistance( test )
{

  test.description = 'Polygon and sphere remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 1, 1, 1, 3 ];
  var expected = 0;

  var gotDist = _.convexPolygon.sphereDistance( polygon, sphere );
  test.identical( gotDist, expected );

  var oldSphere = [ 1, 1, 1, 3 ];
  test.identical( sphere, oldSphere );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and sphere intersect'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 0, 0, 1 ];
  var expected = 0;

  var gotDist = _.convexPolygon.sphereDistance( polygon, sphere );
  test.identical( gotDist, expected );

  test.description = 'Polygon and sphere intersect, sphere bigger than polygon'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 0, 0, 2 ];
  var expected = 0;

  var gotDist = _.convexPolygon.sphereDistance( polygon, sphere );
  test.identical( gotDist, expected );

  test.description = 'Polygon and sphere intersect, sphere smaller than polygon'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 0, 0, 0.2 ];
  var expected = 0;

  var gotDist = _.convexPolygon.sphereDistance( polygon, sphere );
  test.identical( gotDist, expected );

  test.description = 'Polygon and sphere not intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 0, 5, 1 ];
  var expected = 3;

  var gotDist = _.convexPolygon.sphereDistance( polygon, sphere );
  test.identical( gotDist, expected );

  test.description = 'Polygon and sphere almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 2, 0, 0.9 ];
  var expected = 0.1;

  var gotDist = _.convexPolygon.sphereDistance( polygon, sphere );
  test.equivalent( gotDist, expected );

  test.description = 'sphere next to polygon´s edge'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var sphere = [ 0, 0.5, 0.9 ];
  var expected = 0.1;

  var gotDist = _.convexPolygon.sphereDistance( polygon, sphere );
  test.equivalent( gotDist, expected );

  test.description = 'sphere next to polygon vertex'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var sphere = [ 0, -1, Math.sqrt( 2 ) - 0.2];
  var expected = 0.2;

  var gotDist = _.convexPolygon.sphereDistance( polygon, sphere );
  test.equivalent( gotDist, expected );

  test.case = '3D';//

  test.description = 'Polygon and sphere intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDist = _.convexPolygon.sphereDistance( polygon, sphere );
  test.identical( gotDist, expected );

  test.description = 'Polygon and sphere intersect, sphere bigger than polygon'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 0, 0, 0, 2 ];
  var expected = 0;

  var gotDist = _.convexPolygon.sphereDistance( polygon, sphere );
  test.identical( gotDist, expected );

  test.description = 'Polygon and sphere intersect, sphere smaller than polygon'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 0, 0, 0, 0.2 ];
  var expected = 0;

  var gotDist = _.convexPolygon.sphereDistance( polygon, sphere );
  test.identical( gotDist, expected );

  test.description = 'Polygon and sphere not intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 1, 1, 5, 1 ];
  var expected = 3.2426406871192848;

  var gotDist = _.convexPolygon.sphereDistance( polygon, sphere );
  test.equivalent( gotDist, expected );

  test.description = 'Polygon and sphere almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 1, 0, 0, 0.9 ];
  var expected = 0.1;

  var gotDist = _.convexPolygon.sphereDistance( polygon, sphere );
  test.equivalent( gotDist, expected );

  test.description = 'sphere next to polygon edge'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var sphere = [ 0, 0, 0.5, Math.sqrt( 2 ) - 0.1 ];
  var expected = 0.1;

  var gotDist = _.convexPolygon.sphereDistance( polygon, sphere );
  test.equivalent( gotDist, expected );

  test.description = 'sphere next to polygon vertex'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var sphere = [ 0, 0, -1, Math.sqrt( 3 ) - 1 ];
  var expected = 1;

  var gotDist = _.convexPolygon.sphereDistance( polygon, sphere );
  test.identical( gotDist, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.sphereDistance( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereDistance( sphere ));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereDistance( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereDistance( polygon, polygon, sphere ));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereDistance( polygon, sphere, sphere ));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereDistance( null, sphere ));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereDistance( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereDistance( NaN, sphere ));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereDistance( polygon, NaN));

  sphere = [ 0, 0, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereDistance( polygon, sphere ));
  sphere = [ 0, 0, 1, 1, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereDistance( polygon, sphere ));
  sphere = [ 0, 0, 1, 1, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereDistance( polygon, sphere ));

}

//

function sphereClosestPoint( test )
{

  test.description = 'Polygon and sphere remain unchanged'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 1, 1, 1, 3 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.sphereClosestPoint( polygon, sphere );
  test.identical( gotPoint, expected );

  var oldSphere = [ 1, 1, 1, 3 ];
  test.identical( sphere, oldSphere );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  test.case = '2D';//

  test.description = 'Polygon and sphere intersect'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 0, 0, 1 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.sphereClosestPoint( polygon, sphere );
  test.identical( gotPoint, expected );

  test.description = 'Polygon and sphere intersect, sphere bigger than polygon'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 0, 0, 2 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.sphereClosestPoint( polygon, sphere );
  test.identical( gotPoint, expected );

  test.description = 'Polygon and sphere intersect, sphere smaller than polygon'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 0, 0, 0.2 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.sphereClosestPoint( polygon, sphere );
  test.identical( gotPoint, expected );

  test.description = 'Polygon and sphere not intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 0, 5, 1 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 1 ] );

  var gotPoint = _.convexPolygon.sphereClosestPoint( polygon, sphere );
  test.identical( gotPoint, expected );

  test.description = 'Polygon and sphere almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 2, 0, 0.9 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0 ] );

  var gotPoint = _.convexPolygon.sphereClosestPoint( polygon, sphere );
  test.identical( gotPoint, expected );

  test.description = 'sphere next to polygon´s edge'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   2,   2,   1,
    0,   0,   1,   1,
  ]);
  var sphere = [ 0, 0.5, 0.9 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0.5 ] );

  var gotPoint = _.convexPolygon.sphereClosestPoint( polygon, sphere );
  test.identical( gotPoint, expected );

  test.description = 'sphere next to polygon vertex'; //

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   2,   2,   1,
    0,   0,   1,   1,
  ]);
  var sphere = [ 0, -1, Math.sqrt( 2 ) - 0.2];
  var expected = _.convexPolygon.tools.long.make( [ 1, 0 ] );

  var gotPoint = _.convexPolygon.sphereClosestPoint( polygon, sphere );
  test.identical( gotPoint, expected );

  test.case = '3D';//

  test.description = 'Polygon and sphere intersect'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.sphereClosestPoint( polygon, sphere );
  test.identical( gotPoint, expected );

  test.description = 'Polygon and sphere intersect, sphere bigger than polygon'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 0, 0, 0, 2 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.sphereClosestPoint( polygon, sphere );
  test.identical( gotPoint, expected );

  test.description = 'Polygon and sphere intersect, sphere smaller than polygon'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0,  -1,   0,
    0,  -1,   0,   1,
  ]);
  var sphere = [ 0, 0, 0, 0.2 ];
  var expected = 0;

  var gotPoint = _.convexPolygon.sphereClosestPoint( polygon, sphere );
  test.identical( gotPoint, expected );

  test.description = 'Polygon and sphere not intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 1, 1, 5, 1 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0, 1 ] );

  var gotPoint = _.convexPolygon.sphereClosestPoint( polygon, sphere );
  test.identical( gotPoint, expected );

  test.description = 'Polygon and sphere almost intersecting'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var sphere = [ 1, 0, 0, 0.9 ];
  var expected = _.convexPolygon.tools.long.make( [ 0, 0, 0 ] );

  var gotPoint = _.convexPolygon.sphereClosestPoint( polygon, sphere );
  test.identical( gotPoint, expected );

  test.description = 'sphere next to polygon edge'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var sphere = [ 0, 0, 0.5, Math.sqrt( 2 ) - 0.1 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 1, 0.5 ] );

  var gotPoint = _.convexPolygon.sphereClosestPoint( polygon, sphere );
  test.identical( gotPoint, expected );

  test.description = 'sphere next to polygon vertex'; //

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);
  var sphere = [ 0, 0, -1, Math.sqrt( 3 ) - 1 ];
  var expected = _.convexPolygon.tools.long.make( [ 1, 1, 0 ] );

  var gotPoint = _.convexPolygon.sphereClosestPoint( polygon, sphere );
  test.identical( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    0,   1,   1,   0
  ]);

  test.shouldThrowErrorSync( () => _.convexPolygon.sphereClosestPoint( ));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereClosestPoint( sphere ));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereClosestPoint( polygon ));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereClosestPoint( polygon, polygon, sphere ));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereClosestPoint( polygon, sphere, sphere ));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereClosestPoint( null, sphere ));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereClosestPoint( polygon, null));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereClosestPoint( NaN, sphere ));
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereClosestPoint( polygon, NaN));

  sphere = [ 0, 0, 1];
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereClosestPoint( polygon, sphere ));
  sphere = [ 0, 0, 1, 1, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereClosestPoint( polygon, sphere ));
  sphere = [ 0, 0, 1, 1, 2, 2 ];
  test.shouldThrowErrorSync( () => _.convexPolygon.sphereClosestPoint( polygon, sphere ));

}

//

function boundingSphereGet( test )
{

  /* */

  test.case = 'Source polygon remains unchanged';

  var srcPolygon = _.Matrix.Make( [ 3, 4 ] ).copy
    ([
      0,   0,   1,   1,
      0,   0,   1,   1,
      0,   1,   1,   0
    ]);
  var dstSphere = [ 1, 1, 1, 2 ];
  var expected = _.convexPolygon.tools.long.make( [ 0.5, 0.5, 0.5, Math.sqrt( 0.75 ) ] );

  var gotSphere = _.convexPolygon.boundingSphereGet( srcPolygon, dstSphere );
  test.identical( expected, gotSphere );
  test.true( dstSphere === gotSphere );

  var oldSrcPolygon = _.Matrix.Make( [ 3, 4 ] ).copy
    ([
      0,   0,   1,   1,
      0,   0,   1,   1,
      0,   1,   1,   0
    ]);
  test.identical( srcPolygon, oldSrcPolygon );

  /* */

  test.case = 'Polygon inside sphere';

  var srcPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
    ([
      0,   0,   3,   3,
      0,   0,   2,   2,
      0,   1,   1,   0
    ]);
  var dstSphere = [ 1, 1, 1, 10 ];
  var expected = _.convexPolygon.tools.long.make( [ 1.5, 1, 0.5, Math.sqrt( 3.5 ) ] );

  var gotSphere = _.convexPolygon.boundingSphereGet( srcPolygon, dstSphere );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Polygon outside Sphere';

  var srcPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
    ([
      3,   3,   3,   3,
      5,   3,   3,   5,
      3,   4,   2,   2
    ]);
  var dstSphere = [ 0, 0, 0, 1 ];
  var expected = _.convexPolygon.tools.long.make( [ 3, 4, 3, Math.sqrt( 2 ) ] );

  var gotSphere = _.convexPolygon.boundingSphereGet( srcPolygon, dstSphere );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Negative polygon values';

  var srcPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
    ([
      0,   0, - 1, - 1,
      0,   0, - 1, - 1,
      0, - 1, - 1,   0
    ]);
  var dstSphere = [ 3, 3, 3, 4 ];
  var expected = _.convexPolygon.tools.long.make( [ - 0.5, - 0.5, - 0.5, Math.sqrt( 0.75 ) ] );

  var gotSphere = _.convexPolygon.boundingSphereGet( srcPolygon, dstSphere );
  test.identical( gotSphere, expected );

  test.case = '2D'; //

  var srcPolygon = _.Matrix.Make( [ 2, 4 ] ).copy
    ([
      3,   6,   -1,   1,
      -2,   0,   7,   1
    ]);
  var dstSphere = [ 3, 3, 4 ];
  var expected = _.convexPolygon.tools.long.make( [ 2.5, 2.5, Math.sqrt( 32.5 ) ] );

  var gotSphere = _.convexPolygon.boundingSphereGet( srcPolygon, dstSphere );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'dstSphere vector';

  var srcPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
    ([
      0,   0,   2,   2,
      0,   2,   2,   0,
      0,   2,   2,   0
    ]);
  var dstSphere = _.vectorAdapter.from( [ 1, 2, 3, 9 ] );
  var expected = _.convexPolygon.tools.vectorAdapter.from( [ 1, 1, 1, Math.sqrt( 3 )  ] );

  var gotSphere = _.convexPolygon.boundingSphereGet( srcPolygon, dstSphere );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'dstSphere null';

  var srcPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
    ([
      0,   0,  -2,  -2,
      0,   0,  -2,  -2,
      0,  -1,  -2,   0
    ]);
  var dstSphere = null;
  var expected = _.convexPolygon.tools.long.make( [ -1, -1, -1, Math.sqrt( 3 ) ] );

  var gotSphere = _.convexPolygon.boundingSphereGet( srcPolygon, dstSphere );
  test.equivalent( gotSphere, expected );

  /* */

  test.case = 'dstSphere undefined';

  var srcPolygon =  _.Matrix.Make( [ 3, 3 ] ).copy
    ([
      0,   0,   1,
      1,   1,   3,
      0,   1,   1
    ]);
  var dstSphere = undefined;
  var expected = _.convexPolygon.tools.long.make( [ 0.5, 2, 0.5, Math.sqrt( 1.5 ) ] );

  var gotSphere = _.convexPolygon.boundingSphereGet( srcPolygon, dstSphere );
  test.identical( gotSphere, expected );

  /* */

  if( !Config.debug )
  return;

  var srcPolygon = _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0,  -1,   0,
    0,   1,   0, - 1
  ]);
  test.shouldThrowErrorSync( () => _.convexPolygon.boundingSphereGet( ) );
  test.shouldThrowErrorSync( () => _.convexPolygon.boundingSphereGet( [] ) );
  test.shouldThrowErrorSync( () => _.convexPolygon.boundingSphereGet( [], [] ) );
  test.shouldThrowErrorSync( () => _.convexPolygon.boundingSphereGet( 'polygon', 'sphere' ) );
  test.shouldThrowErrorSync( () => _.convexPolygon.boundingSphereGet( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.convexPolygon.boundingSphereGet( srcPolygon, [ 1, 0, 1, 2, 1, 2 ], [ 0, 0, 0, 1, 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.convexPolygon.boundingSphereGet( NaN, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.convexPolygon.boundingSphereGet( null, [ 0, 1, 0, 1, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.convexPolygon.boundingSphereGet( srcPolygon, NaN ) );
  test.shouldThrowErrorSync( () => _.convexPolygon.boundingSphereGet( srcPolygon, [ 0, 1, 0, 1, 2 ]  ) );

}




// --
// declare
// --

const Proto =
{

  name : 'Tools/Math/ConvexPolygon',
  silencing : 1,
  enabled : 1,
  // verbosity : 7,
  // debug : 1,

  tests :
  {

    is,
    isPolygon,
    isConvex,
    isConcave,
    isClockwise,
    angleThreePoints,

    make,

    pointContains,
    pointDistance,
    pointDistanceSqr,
    pointClosestPoint,

    boxIntersects,
    boxDistance,
    boxClosestPoint,
    boundingBoxGet,

    capsuleIntersects,
    capsuleDistance,
    capsuleClosestPoint,

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

    segmentIntersects,
    segmentDistance,
    segmentClosestPoint,

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
