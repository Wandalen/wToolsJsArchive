( function _ConcavePolygon_test_s_( ) {

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

  var polygon = _.concavePolygon.make( 3, 3 );

  var gotBool = _.concavePolygon.is( polygon );

  var expected = true;
  test.identical( gotBool, expected );

  var oldPolygon = _.concavePolygon.make( 3, 3 );
  test.equivalent( oldPolygon, polygon );

  test.case = 'Triangle 2D'; //

  var polygon = _.concavePolygon.make( 3, 2 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);

  var gotBool = _.concavePolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Square 3D'; //

  var polygon = _.concavePolygon.make( 4, 3 ).copy
  ([
    1, 1, 0, 0,
    0, 1, 1, 0,
    0, 0, 0, 0
  ]);

  var gotBool = _.concavePolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = '4 points in 3D forming concave polygon'; //

  var polygon = _.concavePolygon.make( 4, 3 ).copy
  ([
    1, 1, 0.9, 0,
    0, 1, 0.1, 0,
    0, 0, 0, 0
  ]);

  var gotBool = _.concavePolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Pentagone 2D'; //

  var polygon = _.concavePolygon.make( 5, 2 ).copy
  ([
    1, 0, 0, 0, 2,
    0, 0, 1, 2, 0
  ]);

  var gotBool = _.concavePolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Concave pentagone 2D'; //

  var polygon = _.concavePolygon.make( 5, 2 ).copy
  ([
    1, 0, 0, 2, 0,
    0, 0, 1, 0, 2
  ]);

  var gotBool = _.concavePolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Wrong dim and vertices'; //

  var polygon = _.Matrix.Make( [ 1, 2 ] ).copy
  ([
    1, 0
  ]);

  var gotBool = _.concavePolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Three points are always coplanar'; //

  var polygon = _.concavePolygon.make( 3, 3 ).copy
  ([
    1, 0, 0,
    0, 1, 0,
    1, 1, 1,
  ]);

  var gotBool = _.concavePolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Four points convex'; //

  var polygon = _.concavePolygon.make( 4, 3 ).copy
  ([
    0,   0,   0,   2,
    1, - 1,   -2,   0,
    1, - 1,   -2,   0
  ]);

  var gotBool = _.concavePolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Four points concave'; //

  var polygon = _.concavePolygon.make( 4, 3 ).copy
  ([
    0,   1,   0,   2,
    1, - 1,   -2,   0,
    1, - 1,   -2,   0
  ]);

  var gotBool = _.concavePolygon.is( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  //

  test.true( !_.concavePolygon.is( ) );
  test.true( !_.concavePolygon.is( null ) );
  test.true( !_.concavePolygon.is( NaN ) );
  test.true( !_.concavePolygon.is( undefined ) );
  test.true( !_.concavePolygon.is( 'polygon' ) );
  test.true( !_.concavePolygon.is( [ 3 ] ) );
  test.true( !_.concavePolygon.is( 3 ) );

}

//

function isPolygon( test )
{

  test.case = 'Source polygon remains unchanged'; //

  var polygon = _.concavePolygon.make( 3, 3 );

  var gotBool = _.concavePolygon.isPolygon( polygon );

  var expected = true;
  test.identical( gotBool, expected );

  var oldPolygon = _.concavePolygon.make( 3, 3 );
  test.equivalent( oldPolygon, polygon );

  test.case = 'Triangle 2D'; //

  var polygon = _.concavePolygon.make( 3, 2 ).copy
  ([
    1, 0, 0,
    0, 0, 1
  ]);

  var gotBool = _.concavePolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Square 3D'; //

  var polygon = _.concavePolygon.make( 4, 3 ).copy
  ([
    1, 1, 0, 0,
    0, 1, 1, 0,
    0, 0, 0, 0
  ]);

  var gotBool = _.concavePolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = '4 points in 3D not coplanar'; //

  var polygon = _.concavePolygon.make( 4, 3 ).copy
  ([
    1, 1, 0, 0,
    0, 1, 1, 0,
    0, 0, 0, 1
  ]);

  var gotBool = _.concavePolygon.isPolygon( polygon );

  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Pentagone 2D'; //

  var polygon = _.concavePolygon.make( 5, 2 ).copy
  ([
    1, 0, 0, 0, 2,
    0, 0, 1, 2, 0
  ]);

  var gotBool = _.concavePolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Dim < 2'; //

  var polygon = _.Matrix.Make( [ 1, 5 ] ).copy
  ([
    1, 0, 0, 0, 2
  ]);

  var gotBool = _.concavePolygon.isPolygon( polygon );

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

  var gotBool = _.concavePolygon.isPolygon( polygon );

  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Vertices < 3'; //

  var polygon = _.Matrix.Make( [ 2, 2 ] ).copy
  ([
    1, 0,
    0, 1
  ]);

  var gotBool = _.concavePolygon.isPolygon( polygon );

  var expected = false;
  test.equivalent( gotBool, expected );

  test.case = 'Three points are always coplanar'; //

  var polygon = _.concavePolygon.make( 3, 3 ).copy
  ([
    1, 0, 0,
    0, 1, 0,
    1, 1, 1,
  ]);

  var gotBool = _.concavePolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  test.case = 'Four coplanar points'; //

  var polygon = _.concavePolygon.make( 4, 3 ).copy
  ([
    0,   0,   0,   2,
    1, - 1,   -2,   0,
    1, - 1,   -2,   0
  ]);

  var gotBool = _.concavePolygon.isPolygon( polygon );

  var expected = true;
  test.equivalent( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var polygon = _.Matrix.Make( [ 3, 3 ] );
  test.shouldThrowErrorSync( () => _.concavePolygon.isPolygon( ));
  test.shouldThrowErrorSync( () => _.concavePolygon.isPolygon( polygon, polygon ));
  test.shouldThrowErrorSync( () => _.concavePolygon.isPolygon( null ));
  test.shouldThrowErrorSync( () => _.concavePolygon.isPolygon( NaN ));
  test.shouldThrowErrorSync( () => _.concavePolygon.isPolygon( undefined ));
  test.shouldThrowErrorSync( () => _.concavePolygon.isPolygon( 'polygon' ));
  test.shouldThrowErrorSync( () => _.concavePolygon.isPolygon( [ 3 ] ));
  test.shouldThrowErrorSync( () => _.concavePolygon.isPolygon( 3 ));

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
  var got = _.concavePolygon.isConvex( polygon );
  test.identical( got, false );

  /* */

  test.case = 'convex polygon - Matrix 2x3';
  var polygon = _.Matrix.Make([ 2, 3 ]).copy
  ([
     1,  3,  5,
    -2,  6,  0,
  ]);
  var got = _.concavePolygon.isConvex( polygon );
  test.identical( got, true );

  test.case = 'convex polygon - Matrix 2x4';
  var polygon = _.Matrix.Make([ 2, 4 ]).copy
  ([
     1,  3,  5,  4,
    -2,  6,  0, -1,
  ]);
  var got = _.concavePolygon.isConvex( polygon );
  test.identical( got, true );

  test.case = 'convex polygon - Matrix 2x6';
  var polygon = _.Matrix.Make([ 2, 6 ]).copy
  ([
    -2,  1,  3,  5,  6,  4,
    -4,  4,  6,  3, -1, -3,
  ]);
  var got = _.concavePolygon.isConvex( polygon );
  test.identical( got, true );

  /* */

  test.case = 'concave polygon - Matrix 2x4';
  var polygon = _.Matrix.Make([ 2, 4 ]).copy
  ([
     1,  3,  5,  4,
    -2,  6,  0,  1,
  ]);
  var got = _.concavePolygon.isConvex( polygon );
  test.identical( got, false );

  test.case = 'concave polygon - Matrix 2x6';
  var polygon = _.Matrix.Make([ 2, 6 ]).copy
  ([
    -2,  1,  3,  5,  6,  4,
    -4,  4,  6,  3,  1,  3,
  ]);
  var got = _.concavePolygon.isConvex( polygon );
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
  var got = _.concavePolygon.isConvex( polygon );
  test.identical( got, false );

  /* */

  test.case = 'convex polygon - Matrix 3x3';
  var polygon = _.Matrix.Make([ 3, 3 ]).copy
  ([
     1,  3,  5,
    -2,  6,  0,
    -4,  1,  0,
  ]);
  var got = _.concavePolygon.isConvex( polygon );
  test.identical( got, true );

  test.case = 'convex polygon - Matrix 3x4';
  var polygon = _.Matrix.Make([ 3, 4 ]).copy
  ([
     1,  3,  5,  4,
    -2,  6,  0, -1,
     1,  1,  1,  1,
  ]);
  var got = _.concavePolygon.isConvex( polygon );
  test.identical( got, true );

  test.case = 'convex polygon - Matrix 3x6';
  var polygon = _.Matrix.Make([ 3, 6 ]).copy
  ([
    -2,  1,  3,  5,  6,  4,
    -4,  4,  6,  3, -1, -3,
     1,  1,  1,  1,  1,  1,
  ]);
  var got = _.concavePolygon.isConvex( polygon );
  test.identical( got, true );

  /* */

  test.case = 'concave polygon - Matrix 3x4';
  var polygon = _.Matrix.Make([ 3, 4 ]).copy
  ([
     1,  3,  5,  4,
    -2,  6,  0,  1,
     1,  1,  1,  1,
  ]);
  var got = _.concavePolygon.isConvex( polygon );
  test.identical( got, false );

  test.case = 'concave polygon - Matrix 2x6';
  var polygon = _.Matrix.Make([ 3, 6 ]).copy
  ([
    -2,  1,  3,  5,  6,  4,
    -4,  4,  6,  3,  1,  3,
     1,  1,  1,  1,  1,  1,
  ]);
  var got = _.concavePolygon.isConvex( polygon );
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
  var got = _.concavePolygon.isConvex( polygon );
  test.identical( got, false );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.concavePolygon.isConvex() );

  test.case = 'wrong type of polygon';
  test.shouldThrowErrorSync( () => _.concavePolygon.isConvex([ 1, 2, 3, 4 ]) );
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
  var got = _.concavePolygon.isConcave( polygon );
  test.identical( got, false );

  /* */

  test.case = 'convex polygon - Matrix 2x3';
  var polygon = _.Matrix.Make([ 2, 3 ]).copy
  ([
     1,  3,  5,
    -2,  6,  0,
  ]);
  var got = _.concavePolygon.isConcave( polygon );
  test.identical( got, false );

  test.case = 'convex polygon - Matrix 2x4';
  var polygon = _.Matrix.Make([ 2, 4 ]).copy
  ([
     1,  3,  5,  4,
    -2,  6,  0, -1,
  ]);
  var got = _.concavePolygon.isConcave( polygon );
  test.identical( got, false );

  test.case = 'convex polygon - Matrix 2x6';
  var polygon = _.Matrix.Make([ 2, 6 ]).copy
  ([
    -2,  1,  3,  5,  6,  4,
    -4,  4,  6,  3, -1, -3,
  ]);
  var got = _.concavePolygon.isConcave( polygon );
  test.identical( got, false );

  /* */

  test.case = 'concave polygon - Matrix 2x4';
  var polygon = _.Matrix.Make([ 2, 4 ]).copy
  ([
     1,  3,  5,  4,
    -2,  6,  0,  1,
  ]);
  var got = _.concavePolygon.isConcave( polygon );
  test.identical( got, true );

  test.case = 'concave polygon - Matrix 2x6';
  var polygon = _.Matrix.Make([ 2, 6 ]).copy
  ([
    -2,  1,  3,  5,  6,  4,
    -4,  4,  6,  3,  1,  3,
  ]);
  var got = _.concavePolygon.isConcave( polygon );
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
  var got = _.concavePolygon.isConcave( polygon );
  test.identical( got, false );

  /* */

  test.case = 'convex polygon - Matrix 3x3';
  var polygon = _.Matrix.Make([ 3, 3 ]).copy
  ([
     1,  3,  5,
    -2,  6,  0,
    -4,  1,  0,
  ]);
  var got = _.concavePolygon.isConcave( polygon );
  test.identical( got, false );

  test.case = 'convex polygon - Matrix 3x4';
  var polygon = _.Matrix.Make([ 3, 4 ]).copy
  ([
     1,  3,  5,  4,
    -2,  6,  0, -1,
     1,  1,  1,  1,
  ]);
  var got = _.concavePolygon.isConcave( polygon );
  test.identical( got, false );

  test.case = 'convex polygon - Matrix 3x6';
  var polygon = _.Matrix.Make([ 3, 6 ]).copy
  ([
    -2,  1,  3,  5,  6,  4,
    -4,  4,  6,  3, -1, -3,
     1,  1,  1,  1,  1,  1,
  ]);
  var got = _.concavePolygon.isConcave( polygon );
  test.identical( got, false );

  /* */

  test.case = 'concave polygon - Matrix 3x4';
  var polygon = _.Matrix.Make([ 3, 4 ]).copy
  ([
     1,  3,  5,  4,
    -2,  6,  0,  1,
     1,  1,  1,  1,
  ]);
  var got = _.concavePolygon.isConcave( polygon );
  test.identical( got, true );

  test.case = 'concave polygon - Matrix 2x6';
  var polygon = _.Matrix.Make([ 3, 6 ]).copy
  ([
    -2,  1,  3,  5,  6,  4,
    -4,  4,  6,  3,  1,  3,
     1,  1,  1,  1,  1,  1,
  ]);
  var got = _.concavePolygon.isConcave( polygon );
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
  var got = _.concavePolygon.isConcave( polygon );
  test.identical( got, false );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.concavePolygon.isConcave() );

  test.case = 'wrong type of polygon';
  test.shouldThrowErrorSync( () => _.concavePolygon.isConcave([ 1, 2, 3, 4 ]) );
}

//

function isClockwise( test )
{
  test.case = 'concave counter clockwise'

  var polygon =
  _.concavePolygon.make( 4, 2 ).copy
  ([
    6.84, 1.26, 2.32, 5.46,
    0.64, 1.54, 4.71, 4.93,
  ]);
  test.true( !_.concavePolygon.isClockwise( polygon ) );

  test.case = 'concave clockwise'
  var polygon = _.concavePolygon.make( 4, 2 ).copy
  ([
    5.46,2.32,1.26,6.84,
    4.93,4.71,1.54,0.64
  ])
  test.true( _.concavePolygon.isClockwise( polygon ) );
}

//

function make( test )
{

  test.case = 'Dim and vertices remain unchanged'; //

  var dim = 3;
  var vertices = 8;

  var gotPolygon = _.concavePolygon.make( vertices, dim );

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

  var gotPolygon = _.concavePolygon.make( vertices, dim );

  var expected = _.Matrix.Make( [ 2, 3 ] ).copy
  ([
    0, 0, 0,
    0, 0, 0
  ]);
  test.equivalent( gotPolygon, expected );

  test.case = 'Square 3D'; //

  var dim = 3;
  var vertices = 4;

  var gotPolygon = _.concavePolygon.make( vertices, dim );

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

  var gotPolygon = _.concavePolygon.make( vertices, dim );

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

  var gotPolygon = _.concavePolygon.make( vertices, dim );

  var expected = _.Matrix.Make( [ 2, 5 ] ).copy( vertices );
  test.equivalent( gotPolygon, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.concavePolygon.make( ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( dim ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( vertices, dim, vertices ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( vertices, null ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( vertices, NaN ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( vertices, undefined ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( vertices, 'dim' ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( vertices, [ 3 ] ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( null, dim ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( NaN, dim ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( undefined, dim ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( 'vertices', dim ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( [ 3 ], dim ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( 3, 1 ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( 3, 4 ));
  test.shouldThrowErrorSync( () => _.concavePolygon.make( 2, 2 ));

}

//

function pointDistance( test )//qqq:extend
{
  var vertices =
  [
    2,  6,  9,  5,
    1,  4,  4,  6,
  ]
  var polygon = _.concavePolygon.make( vertices, 2 );
  var point = [ 2, 0 ];
  var expected = 1;
  var gotDistance = _.concavePolygon.pointDistance( polygon, point );

  test.identical( gotDistance, expected );

}

// --
// declare
// --

const Proto =
{

  name : 'Tools/Math/concavePolygon',
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

    make,

    pointDistance,

  }

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
