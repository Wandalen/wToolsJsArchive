( function _Frustum_test_s_( ) {

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
var vec = _.vectorAdapter.fromLong;
var avector = _.avector;
var sqrt = _.math.sqrt;
const Parent = wTester;

_.assert( _.routineIs( sqrt ) );

// --
// test
// --

function fromMatrixHomogenous( test )
{
  var frustum = _.frustum.make();
  var matrix = _.Matrix.FormPerspective( 90, [ 20, 70 ], [ 10, 50 ] );
  var gotFrustum = _.frustum.fromMatrixHomogenous( frustum, matrix );
  var expected = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    0, 0, 0, 0, 25, -25,
    -1, 1, 0, 0, 0, 0,
    0, 0, 0.285, -0.285, 0, 0,
    -1, -1, -1, -1, 0.500, -2.5
  ]);
  test.equivalent( gotFrustum, expected, 0.1 );
}

//

function cornersGet( test )
{

  test.description = 'Frustum remains unchanged'; //

  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = _.Matrix.Make( [ 3, 8 ] ).copy
  ([
    0, 0, 0, 0, 1, 1, 1, 1,
    1, 0, 1, 0, 1, 0, 1, 0,
    1, 1, 0, 0, 1, 1, 0, 0
  ]);

  var gotCorners = _.frustum.cornersGet( frustum );
  test.equivalent( gotCorners, expected );

  var oldFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( frustum, oldFrustum );

  test.description = 'Frustrum as box (0, 0, 0, 1, 1, 1)'; //

  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = _.Matrix.Make( [ 3, 8 ] ).copy
  ([
    0, 0, 0, 0, 1, 1, 1, 1,
    1, 0, 1, 0, 1, 0, 1, 0,
    1, 1, 0, 0, 1, 1, 0, 0
  ]);

  var gotCorners = _.frustum.cornersGet( frustum );
  test.identical( gotCorners, expected );

  test.description = 'Frustrum as point (1, 1, 1)'; //

  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 1, - 1, 1, 1, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = _.Matrix.Make( [ 3, 8 ] ).copy
  ([
    1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1
  ]);

  var gotCorners = _.frustum.cornersGet( frustum );
  test.identical( gotCorners, expected );

  test.description = 'Frustrum as box (-1, -1, -1, 1, 1, 1)'; //

  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, - 1, - 1, - 1, - 1, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = _.Matrix.Make( [ 3, 8 ] ).copy
  ([
    -1, -1, -1, -1, 1, 1, 1, 1,
    1, -1, 1, -1, 1, -1, 1, -1,
    1, 1, -1, -1, 1, 1, -1, -1
  ]);

  var gotCorners = _.frustum.cornersGet( frustum );
  test.identical( gotCorners, expected );

  test.description = 'Frustrum with inclined side'; //

  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 2, 1, - 1, 0, 0,
  ]);
  var expected = _.Matrix.Make( [ 3, 8 ] ).copy
  ([
    0, 0, 0, 0, 1, 1, 1, 1,
    1, 2, 1, 0, 1, 2, 1, 0,
    1, 1, 0, 0, 1, 1, 0, 0
  ]);

  var gotCorners = _.frustum.cornersGet( frustum );
  test.identical( gotCorners, expected );

  test.description = 'Frustrum with two inclined sides'; //

  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 2, 0,
    0, 2, 1, - 1, 0, 0,
  ]);
  var expected = _.Matrix.Make( [ 3, 8 ] ).copy
  ([
    2, 4, 2, 0, 1, 1, 1, 1,
    1, 2, 1, 0, 1, 2, 1, 0,
    1, 1, 0, 0, 1, 1, 0, 0
  ]);

  var gotCorners = _.frustum.cornersGet( frustum );
  test.identical( gotCorners, expected );

  test.description = 'Frustrum with three inclined sides'; //

  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 2, 0,
    0, 2, 1, - 1, 0, 0.5,
  ]);
  var expected = _.Matrix.Make( [ 3, 8 ] ).copy
  ([
    2, 4, 2, 0, 0.5, 0.5, 1, 1,
    1, 2, 1, 0, 1, 2, 1, 0,
    1, 1, 0, 0, 1, 1, 0, 0
  ]);

  var gotCorners = _.frustum.cornersGet( frustum );
  test.equivalent( gotCorners, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.cornersGet( ));
  test.shouldThrowErrorSync( () => _.frustum.cornersGet( frustum, frustum ));
  test.shouldThrowErrorSync( () => _.frustum.cornersGet( null ));
  test.shouldThrowErrorSync( () => _.frustum.cornersGet( NaN ));
  test.shouldThrowErrorSync( () => _.frustum.cornersGet( frustum, [ 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.cornersGet( [ 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.cornersGet( [ ] ));


}

//

function pointContains( test )
{

  test.description = 'Frustum and point remain unchanged'; //

  var frustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var point = [ 3, 3, 3 ];
  point = _.vectorAdapter.from( point );

  var expected = false;

  var gotBool = _.frustum.pointContains( frustum, point );
  test.identical( gotBool, expected );

  var oldPoint = _.vectorAdapter.from( [ 3, 3, 3 ] );
  test.identical( point, oldPoint );

  var oldFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( frustum, oldFrustum );

  test.description = 'Frustum contains point'; //

  var frustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var point = [ 0, 0, 0 ];
  point = _.vectorAdapter.from( point );
  var expected = true;

  var gotBool = _.frustum.pointContains( frustum, point );
  test.identical( gotBool, expected );

  test.description = 'Point near border'; //

  var frustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var point = [ 0.9, 0.9, 0.9 ];
  point = _.vectorAdapter.from( point );
  var expected = true;

  var gotBool = _.frustum.pointContains( frustum, point );
  test.identical( gotBool, expected );

  test.description = 'Point in corner'; //

  var frustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var point = [ 1, 1, 1 ];
  point = _.vectorAdapter.from( point );
  var expected = true;

  var gotBool = _.frustum.pointContains( frustum, point );
  test.identical( gotBool, expected );

  test.description = 'Point just outside frustum'; //

  var frustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var point = [ 1.1, 1.1, 1.1 ];
  point = _.vectorAdapter.from( point );
  var expected = false;

  var gotBool = _.frustum.pointContains( frustum, point );
  test.identical( gotBool, expected );

  test.description = 'Point out of frustum'; //

  var frustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var point = [ 5 , 5, 5 ];
  point = _.vectorAdapter.from( point );
  var expected = false;

  var gotBool = _.frustum.pointContains( frustum, point );
  test.identical( gotBool, expected );

  test.description = 'Zero frustum contains zero point'; //

  var frustum = _.frustum.make();
  var point = [ 0, 0, 0 ];
  point = _.vectorAdapter.from( point );
  var expected = true;

  var gotBool = _.frustum.pointContains( frustum, point );
  test.identical( gotBool, expected );

  test.description = 'Zero frustum contains  all points'; //

  var frustum = _.frustum.make();
  var point = [ 0, - 10, 5 ];
  point = _.vectorAdapter.from( point );
  var expected = true;

  var gotBool = _.frustum.pointContains( frustum, point );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var frustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var point = [ 0, - 10, 5 ];
  point = _.vectorAdapter.from( point );
  test.shouldThrowErrorSync( () => _.frustum.pointContains( ));
  test.shouldThrowErrorSync( () => _.frustum.pointContains( point ));
  test.shouldThrowErrorSync( () => _.frustum.pointContains( frustum ));
  test.shouldThrowErrorSync( () => _.frustum.pointContains( frustum, frustum, point ));
  test.shouldThrowErrorSync( () => _.frustum.pointContains( frustum, point, point ));
  test.shouldThrowErrorSync( () => _.frustum.pointContains( null, point ));
  test.shouldThrowErrorSync( () => _.frustum.pointContains( frustum, null));
  test.shouldThrowErrorSync( () => _.frustum.pointContains( NaN, point ));
  test.shouldThrowErrorSync( () => _.frustum.pointContains( frustum, NaN));

  point = [ 0, 1 ];
  point = _.vectorAdapter.from( point );
  test.shouldThrowErrorSync( () => _.frustum.pointContains( frustum, point ));
  point = [ 0, 0, 1, 1 ];
  point = _.vectorAdapter.from( point );
  test.shouldThrowErrorSync( () => _.frustum.pointContains( frustum, point ));

}

//

function pointDistance( test )
{

  test.description = 'Frustum and point remain unchanged'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var point = [ 3, 3, 3 ];

  var expected = Math.sqrt( 12 );

  var gotDistance = _.frustum.pointDistance( srcFrustum, point );
  test.identical( gotDistance, expected );

  var oldPoint = [ 3, 3, 3 ];
  test.identical( point, oldPoint );

  var oldFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Frustum contains point in corner'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotDistance = _.frustum.pointDistance( srcFrustum, point );
  test.identical( gotDistance, expected );

  test.description = 'Point near border'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var point = [ 0.9, 0.9, 0.9 ];
  var expected = 0;

  var gotDistance = _.frustum.pointDistance( srcFrustum, point );
  test.identical( gotDistance, expected );

  test.description = 'Point on side'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var point = [ 0.5, 0.5, 1 ];
  var expected = 0;

  var gotDistance = _.frustum.pointDistance( srcFrustum, point );
  test.identical( gotDistance, expected );

  test.description = 'Point just outside frustum'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var point = [ 1, 1, 1.1 ];
  var expected = 0.1;

  var gotDistance = _.frustum.pointDistance( srcFrustum, point );
  test.equivalent( gotDistance, expected );

  test.description = 'Point out of frustum - 1D'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var point = [ 0.5 , 0.5, 5 ];
  var expected = 4;

  var gotDistance = _.frustum.pointDistance( srcFrustum, point );
  test.identical( gotDistance, expected );

  test.description = 'Point out of frustum - 2D'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var point = [ 1 , 4, 5 ];
  var expected = 5;

  var gotDistance = _.frustum.pointDistance( srcFrustum, point );
  test.equivalent( gotDistance, expected );

  test.description = 'Point out of frustum - 3D'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var point = [ 5, 5, 5 ];
  var expected = Math.sqrt( 48 );

  var gotDistance = _.frustum.pointDistance( srcFrustum, point );
  test.equivalent( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;

  var frustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var point = [ 0, - 10, 5 ];
  point = _.vectorAdapter.from( point );
  test.shouldThrowErrorSync( () => _.frustum.pointDistance( ));
  test.shouldThrowErrorSync( () => _.frustum.pointDistance( point ));
  test.shouldThrowErrorSync( () => _.frustum.pointDistance( frustum ));
  test.shouldThrowErrorSync( () => _.frustum.pointDistance( frustum, frustum, point ));
  test.shouldThrowErrorSync( () => _.frustum.pointDistance( frustum, point, point ));
  test.shouldThrowErrorSync( () => _.frustum.pointDistance( null, point ));
  test.shouldThrowErrorSync( () => _.frustum.pointDistance( frustum, null));
  test.shouldThrowErrorSync( () => _.frustum.pointDistance( NaN, point ));
  test.shouldThrowErrorSync( () => _.frustum.pointDistance( frustum, NaN));

  point = [ 0, 1];
  point = _.vectorAdapter.from( point );
  test.shouldThrowErrorSync( () => _.frustum.pointDistance( frustum, point ));
  point = [ 0, 0, 1, 1];
  point = _.vectorAdapter.from( point );
  test.shouldThrowErrorSync( () => _.frustum.pointDistance( frustum, point ));

}

//

function pointClosestPoint( test )
{

  test.description = 'Source frustum and source point remain unchanged'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcPoint = [ -1, -1, -1 ];
  var expected = _.frustum.tools.long.make( [ 0, 0, 0 ] );

  var closestPoint = _.frustum.pointClosestPoint( srcFrustum, srcPoint );
  test.equivalent( closestPoint, expected );

  var oldPoint = [ -1, -1, -1 ];
  test.identical( srcPoint, oldPoint );

  var oldFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Frustrum as box ( 0, 0, 0, 1, 1, 1 ) - corner ( 1, 1, 1 )'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcPoint = [ -1, -1, -1 ];
  var expected = _.frustum.tools.long.make( [ 0, 0, 0 ] );

  var closestPoint = _.frustum.pointClosestPoint( srcFrustum, srcPoint );
  test.identical( closestPoint, expected );

  test.description = 'Frustrum as box ( 0, 0, 0, 1, 1, 1 ) - center of side side'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcPoint = [ 0.5, 0.5, -3 ];
  var expected = _.frustum.tools.long.make( [ 0.5, 0.5, 0 ] );

  var closestPoint = _.frustum.pointClosestPoint( srcFrustum, srcPoint );
  test.identical( closestPoint, expected );

  test.description = 'Point inside frustum'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcPoint = [ 0.5, 0.6, 0.2 ];
  var expected = 0;

  var closestPoint = _.frustum.pointClosestPoint( srcFrustum, srcPoint );
  test.identical( closestPoint, expected );

  test.description = 'Point under frustum'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcPoint = [ -1, -1, -1 ];
  var expected = _.frustum.tools.long.make( [ 0, 0, 0 ] );

  var closestPoint = _.frustum.pointClosestPoint( srcFrustum, srcPoint );
  test.identical( closestPoint, expected );

  test.description = 'Diagonal frustum plane'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 2, 1, - 1, 0, 0,
  ]);
  var srcPoint = [ 0, 0, 2 ];
  var expected = _.frustum.tools.long.make( [ 0, 0.4, 0.2 ] );

  var closestPoint = _.frustum.pointClosestPoint( srcFrustum, srcPoint );
  test.equivalent( closestPoint, expected );

  test.description = 'dstPoint Array returns array'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 2, 1, - 1, 0, 0,
  ]);
  var srcPoint = [ 0, 0, 2 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = _.frustum.tools.long.make( [ 0, 0.4, 0.2 ] );

  var closestPoint = _.frustum.pointClosestPoint( srcFrustum, srcPoint, dstPoint );
  test.equivalent( closestPoint, expected );
  test.identical( closestPoint, dstPoint );

  test.description = 'dstPointVector returns vector'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 2, 1, - 1, 0, 0,
  ]);
  var srcPoint = [ 0, 0, 2 ];
  var dstPoint = _.vectorAdapter.from( [ 0, 0, 0 ] );
  var expected = _.frustum.tools.vectorAdapter.from( [ 0, 0.4, 0.2 ] );

  var closestPoint = _.frustum.pointClosestPoint( srcFrustum, srcPoint, dstPoint );
  test.equivalent( closestPoint, expected );
  test.identical( closestPoint, dstPoint );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( srcFrustum, srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( null ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( NaN ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( srcFrustum, [ 0, 0, 2, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( [ 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( [ ] ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( null, [ 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( NaN , [ 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( srcFrustum, null ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( srcFrustum, NaN ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( srcFrustum, [ 0, 0, 2 ], null ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( srcFrustum, [ 0, 0, 2 ], undefined ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( srcFrustum, [ 0, 0, 2 ], NaN ));
  test.shouldThrowErrorSync( () => _.frustum.pointClosestPoint( srcFrustum, [ 0, 0, 2 ], [ 0, 0, 2, 3 ] ));

}

//

function boxContains( test )
{

  test.description = 'Frustum and box remain unchanged'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var box = [ 1, 1, 1, 3, 3, 3 ];
  var expected = false;

  var gotBool = _.frustum.boxContains( srcFrustum, box );
  test.identical( gotBool, expected );

  var oldBox = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( box, oldBox );

  var oldFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Same dimensions'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.frustum.boxContains( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Frustum and box intersect'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var box = [ 0.5, 0.5, 0.5, 1.5, 1.5, 1.5 ];
  var expected = false;

  var gotBool = _.frustum.boxContains( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Box bigger than frustum'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var box = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = false;

  var gotBool = _.frustum.boxContains( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Frustum bigger than frustum'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var box = [ 0.2, 0.2, 0.2, 0.4, 0.4, 0.4 ];
  var expected = true;

  var gotBool = _.frustum.boxContains( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Frustum and box not intersecting'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var box = [ 4, 4, 4, 5, 5, 5 ];
  var expected = false;

  var gotBool = _.frustum.boxContains( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Box and Frustum with common side - contained'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var box = [ 0, 0, 0, 0.6 , 0.6, 0.6 ];
  var expected = true;

  var gotBool = _.frustum.boxContains( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Frustum and box with common corner - not contained'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var box = [ 1, 1, 1, 5 , 5, 5 ];
  var expected = false;

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

  test.shouldThrowErrorSync( () => _.frustum.boxContains( ));
  test.shouldThrowErrorSync( () => _.frustum.boxContains( box ));
  test.shouldThrowErrorSync( () => _.frustum.boxContains( srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.boxContains( srcFrustum, srcFrustum, box ));
  test.shouldThrowErrorSync( () => _.frustum.boxContains( srcFrustum, box, box ));
  test.shouldThrowErrorSync( () => _.frustum.boxContains( null, box ));
  test.shouldThrowErrorSync( () => _.frustum.boxContains( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.frustum.boxContains( NaN, box ));
  test.shouldThrowErrorSync( () => _.frustum.boxContains( srcFrustum, NaN));

  box = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.frustum.boxContains( srcFrustum, box ));
  box = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.frustum.boxContains( srcFrustum, box ));
  box = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.frustum.boxContains( srcFrustum, box ));

}

//

function boxIntersects( test )
{

  test.description = 'Frustum and box remain unchanged'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var box = [ 1, 1, 1, 3, 3, 3 ];
  var expected = true;

  var gotBool = _.frustum.boxIntersects( srcFrustum, box );
  test.identical( gotBool, expected );

  var oldBox = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( box, oldBox );

  var oldFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( srcFrustum, oldFrustum );


  test.description = 'Frustum and box intersect'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.frustum.boxIntersects( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Frustum and box intersect, box bigger than frustum'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var box = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.frustum.boxIntersects( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Frustum and box intersect, box smaller than frustum'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var box = [ - 0.2, - 0.2, - 0.2, 0.2, 0.2, 0.2 ];
  var expected = true;

  var gotBool = _.frustum.boxIntersects( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Frustum and box not intersecting'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var box = [ 4, 4, 4, 5, 5, 5 ];
  var expected = false;

  var gotBool = _.frustum.boxIntersects( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Frustum and box almost intersecting'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var box = [ 1.1, 1.1, 1.1, 5 , 5, 5 ];
  var expected = false;

  var gotBool = _.frustum.boxIntersects( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Frustum and box just touching'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var box = [ 1, 1, 1, 5 , 5, 5 ];
  var expected = true;

  var gotBool = _.frustum.boxIntersects( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Frustum and box just intersect'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var box = [ 0.9, 0.9, 0.9, 5, 5, 5 ];
  var expected = true;

  var gotBool = _.frustum.boxIntersects( srcFrustum, box );
  test.identical( gotBool, expected );

  test.description = 'Frustum and box just intersect'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var box = [ 0.9, 0.9, 0.9, 5, 5, 5 ];
  var expected = true;

  var gotBool = _.frustum.boxIntersects( srcFrustum, box );
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

  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( ));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( box ));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( srcFrustum, srcFrustum, box ));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( srcFrustum, box, box ));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( null, box ));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( NaN, box ));
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( srcFrustum, NaN));

  box = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( srcFrustum, box ));
  box = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( srcFrustum, box ));
  box = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.frustum.boxIntersects( srcFrustum, box ));

}

//

function boxClosestPoint( test )
{

  test.description = 'Frustum and box remain unchanged'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var box = [ 0.5, 0.5, 0.5, 1.5, 1.5, 1.5 ];
  var expected = 0;

  var closestPoint = _.frustum.boxClosestPoint( srcFrustum, box );
  test.equivalent( closestPoint, expected );

  var oldBox = [ 0.5, 0.5, 0.5, 1.5, 1.5, 1.5 ];
  test.identical( box, oldBox );

  var oldFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Frustrum as box ( 0, 0, 0, 1, 1, 1 ) - corner ( 1, 1, 1 )'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var box = [ 1.5, 1.5, 1.5, 2.5, 2.5, 2.5 ];
  var expected = _.frustum.tools.long.make( [ 1, 1, 1 ] );

  var closestPoint = _.frustum.boxClosestPoint( srcFrustum, box );
  test.equivalent( closestPoint, expected );

  test.description = 'Frustrum as box ( 0, 0, 0, 1, 1, 1 ) - corner ( 0, 0, 0 )'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var box = [ -1, -1, -1, -0.5, -0.5, -0.5 ];
  var expected = _.frustum.tools.long.make( [ 0, 0, 0 ] );

  var closestPoint = _.frustum.boxClosestPoint( srcFrustum, box );
  test.equivalent( closestPoint, expected );

  test.description = 'Box and frustum intersect'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var box = [ -1, -1, -1, 0.5, 0.5, 0.5 ];
  var expected = 0;

  var closestPoint = _.frustum.boxClosestPoint( srcFrustum, box );
  test.identical( closestPoint, expected );

  test.description = 'Point in inclined frustum side'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 2, 1, - 1, 0, 0,
  ]);
  var box = [ -1, -1, 1, 0.5, 1.5, 2 ];
  var expected = _.frustum.tools.long.make( [ 0.5, 1.6, 0.79999999 ] );

  var closestPoint = _.frustum.boxClosestPoint( srcFrustum, box );
  test.equivalent( closestPoint, expected );

  test.description = 'Diagonal frustum plane'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 2, 1, - 1, 0, 0,
  ]);
  var box = [ -2, -2, 2, 0, 0, 4 ];
  var expected = _.frustum.tools.long.make( [ 0, 0.4, 0.20000 ] );

  var closestPoint = _.frustum.boxClosestPoint( srcFrustum, box );
  test.equivalent( closestPoint, expected );

  test.description = 'PointBox'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 2, 1, - 1, 0, 0,
  ]);
  var box = [ -2, -2, -2, -2, -2, -2 ];
  var expected = _.frustum.tools.long.make( [ 0, 0, 0 ] );

  var closestPoint = _.frustum.boxClosestPoint( srcFrustum, box );
  test.equivalent( closestPoint, expected );

  test.description = 'PointBox on side'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var box = [ 1.1, 0.5, 0.5, 1.1, 0.5, 0.5 ];
  var expected = _.frustum.tools.long.make( [ 1, 0.5, 0.5 ] );

  var closestPoint = _.frustum.boxClosestPoint( srcFrustum, box );
  test.equivalent( closestPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( srcFrustum, srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( null ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( NaN ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( srcFrustum, [ 0, 0, 2, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( [ 0, 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( [ ] ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( null, [ 0, 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( NaN , [ 0, 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( srcFrustum, null ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( srcFrustum, NaN ));
  test.shouldThrowErrorSync( () => _.frustum.boxClosestPoint( srcFrustum, srcFrustum, [ 0, 0, 0, 0, 0, 0 ] ));
}

//

function boundingBoxGet( test )
{

  /* */

  test.case = 'Source frustum remains unchanged';

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
    ([
      - 1, 0, - 1, 0, 0, - 1,
      0, 0, 0, 0, - 1, 1,
      1, - 1, 0, 0, 0, 0,
      0, 0, 1, - 1, 0, 0,
    ]);
  var dstBox = [ 1, 1, 1, 2, 2, 2 ];
  var expected = _.frustum.tools.long.make( [ 0, 0, 0, 1, 1, 1 ] );

  var gotBox = _.frustum.boundingBoxGet( dstBox, srcFrustum );
  test.identical( expected, gotBox );
  test.true( dstBox === gotBox );

  var oldSrcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
    ([
      - 1, 0, - 1, 0, 0, - 1,
      0, 0, 0, 0, - 1, 1,
      1, - 1, 0, 0, 0, 0,
      0, 0, 1, - 1, 0, 0,
    ]);
  test.identical( srcFrustum, oldSrcFrustum );

  /* */

  test.case = 'Zero frustum to zero box';

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
    ([
      0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, - 1, 1,
      1, - 1, 0, 0, 0, 0,
      0, 0, 1, - 1, 0, 0,
    ]);
  var dstBox = [ 0, 0, 0, 1, 1, 1 ];
  var expected = _.frustum.tools.long.make( [ 0, 0, 0, 0, 0, 0 ] );

  var gotBox = _.frustum.boundingBoxGet( dstBox, srcFrustum );
  test.identical( gotBox, expected );

  /* */

  test.case = 'Frustum inside box';

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
    ([
      - 2, 1, - 1, 0, 2, - 3,
      0, 0, 0, 0, - 1, 1,
      1, - 1, 0, 0, 0, 0,
      0, 0, 1, - 1, 0, 0,
    ]);
  var dstBox = [ 0, 0, 0, 5, 5, 5 ];
  var expected = _.frustum.tools.long.make( [ 2, 1, 0, 3, 2, 1 ] );

  var gotBox = _.frustum.boundingBoxGet( dstBox, srcFrustum );
  test.identical( gotBox, expected );

  /* */

  test.case = 'Frustum outside Box';

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
    ([
      - 3, 1, - 3, 1, 1, - 3,
      0, 0, 0, 0, - 1, 1,
      1, - 1, 0, 0, 0, 0,
      0, 0, 1, - 1, 0, 0,
    ]);
  var dstBox = [ - 3, - 4, - 5, - 5, - 4, - 2 ];
  var expected = _.frustum.tools.long.make( [ 1, 1, 1, 3, 3, 3 ] );

  var gotBox = _.frustum.boundingBoxGet( dstBox, srcFrustum );
  test.identical( gotBox, expected );

  /* */

  test.case = 'Point frustum and point Box';

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
    ([
      - 1, 1, - 1, 1, 1, - 1,
      0, 0, 0, 0, - 1, 1,
      1, - 1, 0, 0, 0, 0,
      0, 0, 1, - 1, 0, 0,
    ]);
  var dstBox = [ 3, 3, 3, 4, 4, 4 ];
  var expected = _.frustum.tools.long.make( [ 1, 1, 1, 1, 1, 1 ] );

  var gotBox = _.frustum.boundingBoxGet( dstBox, srcFrustum );
  test.identical( gotBox, expected );

  /* */

  test.case = 'Negative frustum values';

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
    ([
      1, - 2, 1, - 3, - 2, 1,
      0, 0, 0, 0, - 1, 1,
      1, - 1, 0, 0, 0, 0,
      0, 0, 1, - 1, 0, 0,
    ]);
  var dstBox = [ 3, 3, 3, 4, 4, 4 ];
  var expected = _.frustum.tools.long.make( [ - 2, - 2, - 3, - 1, - 1, - 1 ] );

  var gotBox = _.frustum.boundingBoxGet( dstBox, srcFrustum );
  test.identical( gotBox, expected );

  test.case = 'Diagonal frustum plane'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 2, 1, - 1, 0, 0,
  ]);
  var dstBox = [ 3, 3, 3, 4, 4, 4 ];
  var expected = _.frustum.tools.long.make( [ 0, 0, 0, 1, 3, 1 ] );

  var gotBox = _.frustum.boundingBoxGet( dstBox, srcFrustum );
  test.identical( gotBox, expected );

  /* */

  test.case = 'dstBox vector';

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 0, - 2, 0, 1, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 2, 1, - 1, 0, 0,
  ]);
  var dstBox = _.vectorAdapter.from( [ 1, 2, 3, 9, 10, - 1 ] );
  var expected = _.frustum.tools.vectorAdapter.from( [ 1, 0, 0, 1, 4, 2 ] );

  var gotBox = _.frustum.boundingBoxGet( dstBox, srcFrustum );
  test.identical( gotBox, expected );

  /* */

  test.case = 'dstBox null';

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 0, - 1, 0, 3, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var dstBox = null;
  var expected = _.frustum.tools.long.make( [ 1, 0, 0, 3, 3, 1 ] );

  var gotBox = _.frustum.boundingBoxGet( dstBox, srcFrustum );
  test.equivalent( gotBox, expected );

  /* */

  test.case = 'dstBox undefined';

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 1, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var dstBox = undefined;
  var expected = _.frustum.tools.long.make( [ 0, 1, 0, 1, 3, 1 ] );

  var gotBox = _.frustum.boundingBoxGet( dstBox, srcFrustum );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 1, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.shouldThrowErrorSync( () => _.frustum.boundingBoxGet( ) );
  test.shouldThrowErrorSync( () => _.frustum.boundingBoxGet( [] ) );
  test.shouldThrowErrorSync( () => _.frustum.boundingBoxGet( [], [] ) );
  test.shouldThrowErrorSync( () => _.frustum.boundingBoxGet( 'box', 'frustum' ) );
  test.shouldThrowErrorSync( () => _.frustum.boundingBoxGet( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.frustum.boundingBoxGet( [ 1, 0, 1, 2, 1, 2 ], [ 0, 0, 0, 1, 1, 1 ], srcFrustum ) );
  test.shouldThrowErrorSync( () => _.frustum.boundingBoxGet( NaN, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.frustum.boundingBoxGet( [ 0, 1, 0, 1, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.frustum.boundingBoxGet( [ 0, 1, 0, 1, 2, 1 ], NaN ) );
  test.shouldThrowErrorSync( () => _.frustum.boundingBoxGet( [ 0, 1, 0, 1, 2 ], srcFrustum ) );

}

//

function capsuleContains( test )
{

  test.description = 'Frustum and capsule remain unchanged'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var capsule = [ 2, 2, 2, 3, 3, 3, 1 ];
  var expected = false;

  var gotBool = _.frustum.capsuleContains( srcFrustum, capsule );
  test.identical( gotBool, expected );

  var oldCapsule = [ 2, 2, 2, 3, 3, 3, 1 ];
  test.identical( capsule, oldCapsule );

  var oldFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Frustum contains capsule'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var capsule = [ 0.2, 0.2, 0.2, 0.5, 0.5, 0.5, 0.1 ];
  var expected = true;

  var gotBool = _.frustum.capsuleContains( srcFrustum, capsule );
  test.identical( gotBool, expected );

  test.description = 'Capsule bigger than frustum'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var capsule = [ 0, 0, 0, 1, 1, 1, 2 ];
  var expected = false;

  var gotBool = _.frustum.capsuleContains( srcFrustum, capsule );
  test.identical( gotBool, expected );

  test.description = 'Frustum and capsule don´t intersect'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var capsule = [ 3, 3, 3, 5, 5, 5, 2 ];
  var expected = false;

  var gotBool = _.frustum.capsuleContains( srcFrustum, capsule );
  test.identical( gotBool, expected );

  test.description = 'Frustum and capsule intersect'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var capsule = [ 0, 1, 1, 1, 1, 1, 0.5 ];
  var expected = false;

  var gotBool = _.frustum.capsuleContains( srcFrustum, capsule );
  test.identical( gotBool, expected );

  test.description = 'Frustum contains capsule touching the sides'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var capsule = [ 0.1, 0.1, 0.1, 0.9, 0.9, 0.9, 0.1 ];
  var expected = true;

  var gotBool = _.frustum.capsuleContains( srcFrustum, capsule );
  test.identical( gotBool, expected );

  test.description = 'Zero capsule contained'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var capsule = _.capsule.makeZero();
  var expected = true;

  var gotBool = _.frustum.capsuleContains( srcFrustum, capsule );
  test.identical( gotBool, expected );

  test.description = 'Zero capsule not contained'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    -1, 0.5,  -1, 0.5, 0.5,  -1,
    0,    0,   0,   0,  -1,   1,
    1,   -1,   0,   0,   0,   0,
    0,    0,   1,  -1,   0,   0,
  ]);
  var capsule = _.capsule.makeZero();
  var expected = false;

  var gotBool = _.frustum.capsuleContains( srcFrustum, capsule );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var capsule = [ 0, 0, 0, 2, 2, 2, 1 ];
  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);

  test.shouldThrowErrorSync( () => _.frustum.capsuleContains( ));
  test.shouldThrowErrorSync( () => _.frustum.capsuleContains( capsule ));
  test.shouldThrowErrorSync( () => _.frustum.capsuleContains( srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.capsuleContains( srcFrustum, srcFrustum, capsule ));
  test.shouldThrowErrorSync( () => _.frustum.capsuleContains( srcFrustum, capsule, capsule ));
  test.shouldThrowErrorSync( () => _.frustum.capsuleContains( null, capsule ));
  test.shouldThrowErrorSync( () => _.frustum.capsuleContains( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.frustum.capsuleContains( NaN, capsule ));
  test.shouldThrowErrorSync( () => _.frustum.capsuleContains( srcFrustum, NaN));
  test.shouldThrowErrorSync( () => _.frustum.capsuleContains( srcFrustum, [ 0, 0, 2, 2, 1] ));
  test.shouldThrowErrorSync( () => _.frustum.capsuleContains( srcFrustum, [ 0, 0, 0, 2, 2, 2 ] ));
  test.shouldThrowErrorSync( () => _.frustum.capsuleContains( srcFrustum, [ 0, 0, 0, 0, 2, 2, 2, 2, 1 ] ));

}

//

function capsuleClosestPoint( test )
{

  test.description = 'Frustum and capsule remain unchanged'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 0.5, 0.5, 0.5, 1.5, 1.5, 1.5, 0.5 ];
  var expected = 0;

  var closestPoint = _.frustum.capsuleClosestPoint( srcFrustum, capsule );
  test.equivalent( closestPoint, expected );

  var oldCapsule = [ 0.5, 0.5, 0.5, 1.5, 1.5, 1.5, 0.5 ];
  test.identical( capsule, oldCapsule );

  var oldFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Frustrum as box ( 0, 0, 0, 1, 1, 1 ) - corner ( 1, 1, 1 )'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 1.5, 1.5, 1.5, 2.5, 2.5, 2.5, 0.1 ];
  var expected = _.frustum.tools.long.make( [ 1, 1, 1 ] );

  var closestPoint = _.frustum.capsuleClosestPoint( srcFrustum, capsule );
  test.equivalent( closestPoint, expected );

  test.description = 'Frustrum as capsule ( 0, 0, 0, 1, 1, 1 ) - corner ( 0, 0, 0 )'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ -1, -1, -1, -0.5, -0.5, -0.5, 0.2 ];
  var expected = _.frustum.tools.long.make( [ 0, 0, 0 ] );

  var closestPoint = _.frustum.capsuleClosestPoint( srcFrustum, capsule );
  test.equivalent( closestPoint, expected );

  test.description = 'Capsule and frustum intersect'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ -1, -1, -1, 0.5, 0.5, 0.5, 0.1 ];
  var expected = 0;

  var closestPoint = _.frustum.capsuleClosestPoint( srcFrustum, capsule );
  test.identical( closestPoint, expected );

  test.description = 'Point in inclined frustum side'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 2, 1, - 1, 0, 0,
  ]);
  var capsule = [ -1, -1, 1, 0.5, 1.5, 2, 0.3 ];
  var expected = _.frustum.tools.long.make( [ 0.42105263157894735, 1.3684210526315788, 0 ] );

  var closestPoint = _.frustum.capsuleClosestPoint( srcFrustum, capsule );
  test.equivalent( closestPoint, expected );

  test.description = 'Diagonal frustum plane'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 2, 1, - 1, 0, 0,
  ]);
  var capsule = [ -2, -2, 2, 0, 0, 4, 0.05 ];
  var expected = _.frustum.tools.long.make( [ 0, 0.4, 0.20000 ] );

  var closestPoint = _.frustum.capsuleClosestPoint( srcFrustum, capsule );
  test.equivalent( closestPoint, expected );

  test.description = 'Point Capsule'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 2, 1, - 1, 0, 0,
  ]);
  var capsule = [ -2, -2, -2, -2, -2, -2, 0 ];
  var expected = _.frustum.tools.long.make( [ 0, 0, 0 ] );

  var closestPoint = _.frustum.capsuleClosestPoint( srcFrustum, capsule );
  test.equivalent( closestPoint, expected );

  test.description = 'Point Capsule on side'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var capsule = [ 1.1, 0.5, 0.5, 1.1, 0.5, 0.5, 0 ];
  var expected = _.frustum.tools.long.make( [ 1, 0.5, 0.5 ] );

  var closestPoint = _.frustum.capsuleClosestPoint( srcFrustum, capsule );
  test.equivalent( closestPoint, expected );

  test.description = 'Sphere Capsule'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 2, 1, - 1, 0, 0,
  ]);
  var capsule = [ -2, -2, -2, -2, -2, -2, 0.4 ];
  var expected = _.frustum.tools.long.make( [ 0, 0, 0 ] );

  var closestPoint = _.frustum.capsuleClosestPoint( srcFrustum, capsule );
  test.equivalent( closestPoint, expected );

  test.description = 'Sphere Capsule on side'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0,  0,  -1,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   -1,  1,   0,   0,
  ]);
  var capsule = [ 1.1, 0.5, 0.5, 1.1, 0.5, 0.5, 0.1 ];
  var expected = 0;

  var closestPoint = _.frustum.capsuleClosestPoint( srcFrustum, capsule );
  test.equivalent( closestPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.capsuleClosestPoint( ));
  test.shouldThrowErrorSync( () => _.frustum.capsuleClosestPoint( srcFrustum, srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.capsuleClosestPoint( null ));
  test.shouldThrowErrorSync( () => _.frustum.capsuleClosestPoint( NaN ));
  test.shouldThrowErrorSync( () => _.frustum.capsuleClosestPoint( srcFrustum, [ 0, 0, 2, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.capsuleClosestPoint( [ 0, 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.capsuleClosestPoint( [ ] ));
  test.shouldThrowErrorSync( () => _.frustum.capsuleClosestPoint( null, [ 0, 0, 0, 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.capsuleClosestPoint( NaN , [ 0, 0, 0, 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.capsuleClosestPoint( srcFrustum, null ));
  test.shouldThrowErrorSync( () => _.frustum.capsuleClosestPoint( srcFrustum, NaN ));
  test.shouldThrowErrorSync( () => _.frustum.capsuleClosestPoint( srcFrustum, srcFrustum, [ 0, 0, 0, 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.capsuleClosestPoint( srcFrustum, [ 0, 0, 0, 0, 0, 0, - 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.capsuleClosestPoint( srcFrustum, [ 0, 0, 0, 0, 0, 0 ] ));
}

//

function convexPolygonContains( test )
{

  test.description = 'Frustum and polygon remain unchanged'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var polygon = _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    1, - 1,   0,
    - 1, 0, - 1
  ]);
  var expected = false;

  var gotBool = _.frustum.convexPolygonContains( srcFrustum, polygon );
  test.identical( gotBool, expected );

  var oldPolygon = _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    1, - 1,   0,
    - 1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  var oldFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Frustum contains polygon'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var polygon = _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0.5,   0,   0,
    0,   0.5,   0,
    0,     0, 0.5
  ]);
  var expected = true;

  var gotBool = _.frustum.convexPolygonContains( srcFrustum, polygon );
  test.identical( gotBool, expected );

  test.description = 'Polygon bigger than frustum'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,  0,  0,  0,
    0,  2,  2,  0,
    0,  0,  2,  2
  ]);
  var expected = false;

  var gotBool = _.frustum.convexPolygonContains( srcFrustum, polygon );
  test.identical( gotBool, expected );

  test.description = 'Frustum and convexPolygon don´t intersect'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var polygon = _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    4,   4,   3,
    3,   4,   3,
    3,   3,   4
  ]);
  var expected = false;

  var gotBool = _.frustum.convexPolygonContains( srcFrustum, polygon );
  test.identical( gotBool, expected );

  test.description = 'Frustum and convexPolygon intersect'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0.5,   2,   2, 0.5,
    0.5, 0.5,   2,   2,
    0.5, 0.5, 0.5, 0.5
  ]);
  var expected = false;

  var gotBool = _.frustum.convexPolygonContains( srcFrustum, polygon );
  test.identical( gotBool, expected );

  test.description = 'Frustum contains convexPolygon touching the sides'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var polygon = _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    1,   0,   0,
    0,   1,   0,
    0,   0,   1
  ]);
  var expected = true;

  var gotBool = _.frustum.convexPolygonContains( srcFrustum, polygon );
  test.identical( gotBool, expected );

  test.description = '5 vertices polygon contained'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var polygon = _.Matrix.Make( [ 3, 5 ] ).copy
  ([
    0,   0, 0.25, 0.5, 0.5,
    0, 0.5, 0.75, 0.5,   0,
    1,   1,    1,   1,   1
  ]);
  var expected = true;

  var gotBool = _.frustum.convexPolygonContains( srcFrustum, polygon );
  test.identical( gotBool, expected );

  test.description = '5 vertices polygon not contained'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    -1, 0.5,  -1, 0.5, 0.5,  -1,
    0,    0,   0,   0,  -1,   1,
    1,   -1,   0,   0,   0,   0,
    0,    0,   1,  -1,   0,   0,
  ]);
  var polygon = _.Matrix.Make( [ 3, 5 ] ).copy
  ([
    0,   0, 0.25, 0.5, 0.5,
    0, 0.5, 0.75, 0.5,   0,
    1,   1,    1,   1,   1
  ]);
  var expected = false;

  var gotBool = _.frustum.convexPolygonContains( srcFrustum, polygon );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var polygon = _.Matrix.Make( [ 3, 3 ] ).copy
  ([
    0,   0,   0,
    1, - 1,   0,
    - 1,   0, - 1
  ]);
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonContains( ));
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonContains( polygon ));
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonContains( srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonContains( srcFrustum, srcFrustum, polygon ));
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonContains( srcFrustum, polygon, polygon ));
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonContains( null, polygon ));
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonContains( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonContains( NaN, polygon ));
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonContains( srcFrustum, NaN));

  var polygon = _.Matrix.Make( [ 2, 3 ] ).copy
  ([
    0,   0,   0,
    - 1,   0, - 1
  ]);
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonContains( srcFrustum, polygon ));

  var polygon = _.Matrix.Make( [ 4, 3 ] ).copy
  ([
    0,     0,   0,
    - 1,   0, - 1,
    - 1,   0,   1,
    - 1,   0, - 1
  ]);
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonContains( srcFrustum, polygon ));

}

//

function convexPolygonClosestPoint( test )
{

  test.description = 'Frustum and convexPolygon remain unchanged'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
  ]);
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = 0;

  var closestPoint = _.frustum.convexPolygonClosestPoint( srcFrustum, polygon );
  test.equivalent( closestPoint, expected );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
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
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Polygon and frustum intersect'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    -3, 0.5, 0.5,  -3, 0.5,  -3,
    0,   0,   0,   0,   -1,  1,
    1,  -1,   0,   0,   0,   0,
    0,   0,  -1,   1,   0,   0,
  ]);
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   1,   1,
    0,   0,   1,   1,
    0,   1,   1,   0
  ]);
  var expected = 0;

  var closestPoint = _.frustum.convexPolygonClosestPoint( srcFrustum, polygon );
  test.identical( closestPoint, expected );

  test.description = 'Polygon inside frustum'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    -3,  0,   0,  -3,   0,  -3,
    0,   0,   0,   0,   -1,  1,
    1,  -1,   0,   0,   0,   0,
    0,   0,  -1,   1,   0,   0,
  ]);
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   1,   2,   2,
    1,   1,   2,   2,
    1,   2,   2,   1
  ]);
  var expected = 0;

  var closestPoint = _.frustum.convexPolygonClosestPoint( srcFrustum, polygon );
  test.identical( closestPoint, expected );

  test.description = 'Polygon next to frustum vertex'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    -3,  1,   1,  -3,   1,  -3,
    0,   0,   0,   0,   -1,  1,
    1,  -1,   0,   0,   0,   0,
    0,   0,  -1,   1,   0,   0,
  ]);
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0, 0.5, 0.5,
    0,   0, 0.5, 0.5,
    0, 0.5, 0.5,   0
  ]);
  var expected = _.frustum.tools.long.make( [ 1, 1, 1 ] );

  var closestPoint = _.frustum.convexPolygonClosestPoint( srcFrustum, polygon );
  test.equivalent( closestPoint, expected );

  test.description = 'Polygon next to frustum edge'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    -3,  1,   1,  -3,   1,  -3,
    0,   0,   0,   0,   -1,  1,
    1,  -1,   0,   0,   0,   0,
    0,   0,  -1,   1,   0,   0,
  ]);
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0, 0.5, 0.5,
    0,   0, 0.5, 0.5,
    0, 0.5, 0.5,   0
  ]);
  var expected = _.frustum.tools.long.make( [ 1, 1, 1 ] );

  var closestPoint = _.frustum.convexPolygonClosestPoint( srcFrustum, polygon );
  test.equivalent( closestPoint, expected );

  test.description = 'Polygon next to frustum side'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    -3,  0,   0,  -3,   0,  -3,
    0,   0,   0,   0,   -1,  1,
    1,  -1,   0,   0,   0,   0,
    0,   0,  -1,   1,   0,   0,
  ]);
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    2,   1, 0.5,   1,
    1,   2,   1, 0.5,
    4,   4,   4,   4
  ]);
  var expected = _.frustum.tools.long.make( [ 0.75, 0.75, 3 ] );

  var closestPoint = _.frustum.convexPolygonClosestPoint( srcFrustum, polygon );
  test.equivalent( closestPoint, expected );

  test.description = 'Diagonal frustum plane'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3,   0, - 1,   0,   1, - 2,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   2,   1, - 1,   0,   0,
  ]);
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = _.frustum.tools.long.make( [ 1, 0, 0 ] );

  var closestPoint = _.frustum.convexPolygonClosestPoint( srcFrustum, polygon );
  test.equivalent( closestPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.convexPolygonClosestPoint( ));
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonClosestPoint( srcFrustum, srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonClosestPoint( null ));
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonClosestPoint( NaN ));
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonClosestPoint( srcFrustum, [ 0, 0, 2, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonClosestPoint( [ 0, 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonClosestPoint( [ ] ));
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonClosestPoint( null, [ 0, 0, 0, 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonClosestPoint( NaN , [ 0, 0, 0, 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonClosestPoint( srcFrustum, null ));
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonClosestPoint( srcFrustum, NaN ));
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonClosestPoint( srcFrustum, srcFrustum, [ 0, 0, 0, 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonClosestPoint( srcFrustum, [ 0, 0, 0, 0, 0, 0, - 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.convexPolygonClosestPoint( srcFrustum, [ 0, 0, 0, 0, 0, 0 ] ));
}

//

function frustumContains( test )
{

  test.description = 'Frustums remain unchanged'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = true;

  var gotBool = _.frustum.frustumContains( srcFrustum, tstFrustum );
  test.identical( gotBool, expected );

  var oldSrcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( srcFrustum, oldSrcFrustum );

  var oldTstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( tstFrustum, oldTstFrustum );

  test.description = 'Frustum Contains itself'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = true;

  var gotBool = _.frustum.frustumContains( srcFrustum, tstFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum contains point frustum'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 0.5, 0.5, - 0.5, 0.5, 0.5, - 0.5,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = true;

  var gotBool = _.frustum.frustumContains( srcFrustum, tstFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum contains frustum'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 0.5, 0.4, - 0.5, 0.4, 0.4, - 0.4,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = true;

  var gotBool = _.frustum.frustumContains( srcFrustum, tstFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustums don´t intersect'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 4, - 3, 4, 4, - 3,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = false;

  var gotBool = _.frustum.frustumContains( srcFrustum, tstFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustums almost intersecting'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 1.1, - 2, 1.1, 1.1, - 2,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = false;

  var gotBool = _.frustum.frustumContains( srcFrustum, tstFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustums just touching'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 1, - 2, 1, 1, - 2,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = false;

  var gotBool = _.frustum.frustumContains( srcFrustum, tstFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustums just intersect'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 0.9, - 2, 0.9, 1, 0.9,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = false;

  var gotBool = _.frustum.frustumContains( srcFrustum, tstFrustum );
  test.identical( gotBool, expected );

  test.description = 'Zero frustum, intersection'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.frustum.make();
  var expected = true;

  var gotBool = _.frustum.frustumContains( srcFrustum, tstFrustum );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.frustumContains( ));
  test.shouldThrowErrorSync( () => _.frustum.frustumContains( srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumContains( srcFrustum, srcFrustum, frustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumContains( null, frustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumContains( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.frustum.frustumContains( NaN, frustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumContains( srcFrustum, NaN));
  test.shouldThrowErrorSync( () => _.frustum.frustumContains( [], srcFrustum));
  test.shouldThrowErrorSync( () => _.frustum.frustumContains( [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], srcFrustum));

}

//

function frustumIntersects( test )
{

  test.description = 'Frustums remain unchanged'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = true;

  var gotBool = _.frustum.frustumIntersects( srcFrustum, frustum );
  test.identical( gotBool, expected );

  var oldSrcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( srcFrustum, oldSrcFrustum );

  var oldFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( frustum, oldFrustum );

  test.description = 'Frustum intersects with itself'; //

  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = true;

  var gotBool = _.frustum.frustumIntersects( srcFrustum, frustum );
  test.identical( gotBool, expected );

  test.description = 'Frustums intersect'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 0.5, - 0.5, - 0.5, - 0.5, - 0.5, - 0.5,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = true;

  var gotBool = _.frustum.frustumIntersects( srcFrustum, frustum );
  test.identical( gotBool, expected );

  test.description = 'Frustums don´t intersec'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 4, - 3, 4, 4, - 3,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = false;

  var gotBool = _.frustum.frustumIntersects( srcFrustum, frustum );
  test.identical( gotBool, expected );

  test.description = 'Frustums almost intersecting'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 1.1, - 2, 1.1, 1.1, - 2,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = false;

  var gotBool = _.frustum.frustumIntersects( srcFrustum, frustum );
  test.identical( gotBool, expected );

  test.description = 'Frustums just touching'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 1, - 2, 1, 1, - 2,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = true;

  var gotBool = _.frustum.frustumIntersects( srcFrustum, frustum );
  test.identical( gotBool, expected );

  test.description = 'Frustums just intersect'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 0.9, - 2, 0.9, 1, 0.9,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = true;

  var gotBool = _.frustum.frustumIntersects( srcFrustum, frustum );
  test.identical( gotBool, expected );

  test.description = 'Zero frustum, intersection'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var frustum = _.frustum.make();
  var expected = true;

  var gotBool = _.frustum.frustumIntersects( srcFrustum, frustum );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( ));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( srcFrustum, srcFrustum, frustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( null, frustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( NaN, frustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( srcFrustum, NaN));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( [], srcFrustum));
  test.shouldThrowErrorSync( () => _.frustum.frustumIntersects( [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], srcFrustum));

}

//

function frustumDistance( test )
{

  test.description = 'Frustums remain unchanged'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = 0;

  var gotDistance = _.frustum.frustumDistance( srcFrustum, tstFrustum );
  test.identical( gotDistance, expected );

  var oldSrcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( srcFrustum, oldSrcFrustum );

  var oldTstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( tstFrustum, oldTstFrustum );

  test.description = 'Frustum Contains frustum'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 0.5, 0.4, - 0.5, 0.4, 0.4, - 0.4,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = 0;

  var gotDistance = _.frustum.frustumDistance( srcFrustum, tstFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustums just touching'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 1, - 2, 1, 1, - 2,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = 0;

  var gotDistance = _.frustum.frustumDistance( srcFrustum, tstFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustums just intersect'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 0.9, - 2, 0.9, 1, 0.9,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = 0;

  var gotDistance = _.frustum.frustumDistance( srcFrustum, tstFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustums don´t intersect'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 4, - 3, 4, 4, - 3,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = Math.sqrt( 12 );

  var gotDistance = _.frustum.frustumDistance( srcFrustum, tstFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustums with parallel side'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    -1, 0, - 3, 2, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = 1;

  var gotDistance = _.frustum.frustumDistance( srcFrustum, tstFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustums almost intersecting'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 1.1, - 2, 1.1, 1.1, - 2,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = Math.sqrt( 0.03 );

  var gotDistance = _.frustum.frustumDistance( srcFrustum, tstFrustum );
  test.equivalent( gotDistance, expected );

  test.description = 'Zero frustum, intersection'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.frustum.make();
  var expected = 0;

  var gotDistance = _.frustum.frustumDistance( srcFrustum, tstFrustum );
  test.identical( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.frustumDistance( ));
  test.shouldThrowErrorSync( () => _.frustum.frustumDistance( srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumDistance( srcFrustum, srcFrustum, frustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumDistance( null, frustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumDistance( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.frustum.frustumDistance( NaN, frustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumDistance( srcFrustum, NaN));
  test.shouldThrowErrorSync( () => _.frustum.frustumDistance( [], srcFrustum));
  test.shouldThrowErrorSync( () => _.frustum.frustumDistance( [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], srcFrustum));

}

//

function frustumClosestPoint( test )
{

  test.description = 'Frustums remain unchanged'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = 0;

  var gotPoint = _.frustum.frustumClosestPoint( srcFrustum, tstFrustum );
  test.identical( gotPoint, expected );

  var oldSrcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( srcFrustum, oldSrcFrustum );

  var oldTstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( tstFrustum, oldTstFrustum );

  test.description = 'Frustum Contains frustum'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 0.5, 0.4, - 0.5, 0.4, 0.4, - 0.4,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = 0;

  var gotPoint = _.frustum.frustumClosestPoint( srcFrustum, tstFrustum );
  test.identical( gotPoint, expected );

  test.description = 'Frustums just touching'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 1, - 2, 1, 1, - 2,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = 0;

  var gotPoint = _.frustum.frustumClosestPoint( srcFrustum, tstFrustum );
  test.identical( gotPoint, expected );

  test.description = 'Frustums just intersect'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 0.9, - 2, 0.9, 1, 0.9,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = 0;

  var gotPoint = _.frustum.frustumClosestPoint( srcFrustum, tstFrustum );
  test.identical( gotPoint, expected );

  test.description = 'Frustums don´t intersect'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 4, - 3, 4, 4, - 3,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = _.frustum.tools.long.make( [ 1, 1, 1 ] );

  var gotPoint = _.frustum.frustumClosestPoint( srcFrustum, tstFrustum );
  test.identical( gotPoint, expected );

  test.description = 'Frustums don´t intersect - exchange tst and src frustums'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 4, - 3, 4, 4, - 3,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = _.frustum.tools.long.make( [ 3, 3, 3 ] );

  var gotPoint = _.frustum.frustumClosestPoint( srcFrustum, tstFrustum );
  test.identical( gotPoint, expected );

  test.description = 'Frustums with parallel side'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    -1, 0, - 3, 2, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = _.frustum.tools.long.make( [ 0, 1, 1 ] );

  var gotPoint = _.frustum.frustumClosestPoint( srcFrustum, tstFrustum );
  test.identical( gotPoint, expected );

  test.description = 'Frustums with parallel side - exchange tst and src frustums'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    -1, 0, - 3, 2, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = _.frustum.tools.long.make( [ 0, 1, 2 ] );

  var gotPoint = _.frustum.frustumClosestPoint( srcFrustum, tstFrustum );
  test.identical( gotPoint, expected );

  test.description = 'Frustums almost intersecting'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 1.1, - 2, 1.1, 1.1, - 2,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = _.frustum.tools.long.make( [ 1, 1, 1 ] );

  var gotPoint = _.frustum.frustumClosestPoint( srcFrustum, tstFrustum );
  test.equivalent( gotPoint, expected );

  test.description = 'Frustums almost intersecting - exchange tst and src frustums'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 1.1, - 2, 1.1, 1.1, - 2,
  0, 0, 0, 0, - 1, 1,
  1, - 1, 0, 0, 0, 0,
  0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = _.frustum.tools.long.make( [ 1.1, 1.1, 1.1 ] );

  var gotPoint = _.frustum.frustumClosestPoint( srcFrustum, tstFrustum );
  test.equivalent( gotPoint, expected );

  test.description = 'Zero frustum, intersection'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstFrustum = _.frustum.make();
  var expected = 0;

  var gotPoint = _.frustum.frustumClosestPoint( srcFrustum, tstFrustum );
  test.identical( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.frustumClosestPoint( ));
  test.shouldThrowErrorSync( () => _.frustum.frustumClosestPoint( srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumClosestPoint( srcFrustum, srcFrustum, frustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumClosestPoint( null, frustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumClosestPoint( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.frustum.frustumClosestPoint( NaN, frustum ));
  test.shouldThrowErrorSync( () => _.frustum.frustumClosestPoint( srcFrustum, NaN));
  test.shouldThrowErrorSync( () => _.frustum.frustumClosestPoint( [], srcFrustum));
  test.shouldThrowErrorSync( () => _.frustum.frustumClosestPoint( [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], srcFrustum));

}

//

function lineClosestPoint( test )
{

  /* */

  test.case = 'Source frustum and line remain unchanged';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstLine = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotLine = _.frustum.lineClosestPoint( srcFrustum, tstLine );
  test.identical( expected, gotLine );

  var oldSrcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( srcFrustum, oldSrcFrustum );

  var oldtstLine = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( tstLine, oldtstLine );

  /* */

  test.case = 'Frustum and line intersect';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstLine = [ -1, -1, 0, 1, 1, 1 ];
  var expected = 0;

  var gotLine = _.frustum.lineClosestPoint( srcFrustum, tstLine );
  test.identical( expected, gotLine );

  /* */

  test.case = 'Line origin is frustum corner';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstLine = [ 1, 1, 1, 1, 0, 0 ];
  var expected = 0;

  var gotLine = _.frustum.lineClosestPoint( srcFrustum, tstLine );
  test.identical( expected, gotLine );

  /* */

  test.case = 'Line is frustum side';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstLine = [ 1, 0, 0, 1, 0, 0 ];
  var expected = 0;

  var gotLine = _.frustum.lineClosestPoint( srcFrustum, tstLine );
  test.identical( expected, gotLine );

  /* */

  test.case = 'Negative factor on corner';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstLine = [ -3, -3, -3, -1, -1, -1 ];
  var expected = 0;

  var gotLine = _.frustum.lineClosestPoint( srcFrustum, tstLine );
  test.identical( expected, gotLine );

  /* */

  test.case = 'Negative factor on side';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstLine = [ 0.5, 0.5, 2, 0, 0, 1 ];
  var expected = 0;

  var gotLine = _.frustum.lineClosestPoint( srcFrustum, tstLine );
  test.identical( expected, gotLine );

  /* */

  test.case = 'Closest point is corner';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstLine = [ 1, 1, 2, 0, 1, 0 ];
  var expected = _.frustum.tools.long.make( [ 1, 1, 1 ] );

  var gotLine = _.frustum.lineClosestPoint( srcFrustum, tstLine );
  test.identical( expected, gotLine );

  /* */

  test.case = 'Closest point on side';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstLine = [ 0.5, 0.5, 1, 0, 1, 0 ];
  var expected = 0;

  var gotLine = _.frustum.lineClosestPoint( srcFrustum, tstLine );
  test.identical( expected, gotLine );

  /* */

  test.case = 'dstPoint Array';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstLine = [ 5, 5, 1, 1, 0, 0 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = _.frustum.tools.long.make( [ 0, 1, 1 ] );

  var gotLine = _.frustum.lineClosestPoint( srcFrustum, tstLine, dstPoint );
  test.identical( expected, gotLine );
  test.true( dstPoint === gotLine );

  /* */

  test.case = 'dstPoint Vector';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var tstLine = [ - 5, 5, 1, 1, 0, 0 ];
  var dstPoint = _.frustum.tools.vectorAdapter.from( [ 0, 0, 0 ] );
  var expected = _.frustum.tools.vectorAdapter.from( [ 0, 1, 1 ] );

  var gotLine = _.frustum.lineClosestPoint( srcFrustum, tstLine, dstPoint );
  test.equivalent( expected, gotLine );
  test.true( dstPoint === gotLine );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.lineClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.frustum.lineClosestPoint( [] ) );
  test.shouldThrowErrorSync( () => _.frustum.lineClosestPoint( 'frustum', 'line' ) );
  test.shouldThrowErrorSync( () => _.frustum.lineClosestPoint(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.frustum.lineClosestPoint( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.frustum.lineClosestPoint( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.frustum.lineClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.frustum.lineClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.frustum.lineClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], undefined ) );

}

//

function planeIntersects( test )
{

  test.description = 'Frustum and plane remain unchanged'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var plane = [ 2, 1, 0, 0 ];
  var expected = false;

  var gotBool = _.frustum.planeIntersects( srcFrustum, plane );
  test.identical( gotBool, expected );

  var oldFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( srcFrustum, oldFrustum );

  var oldPlane = [ 2, 1, 0, 0 ];
  test.identical( plane, oldPlane );

  test.description = 'Frustum and plane intersect'; //

  var plane = [ - 0.4, 1, 0, 0 ];
  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = true;

  var gotBool = _.frustum.planeIntersects( srcFrustum, plane );
  test.identical( gotBool, expected );

  test.description = 'Plane cuts Frustum in diagonal'; //

  var plane = [ 0, 0.3, 0.3, 0.3 ];
  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var expected = true;

  var gotBool = _.frustum.planeIntersects( srcFrustum, plane );
  test.identical( gotBool, expected );

  test.description = 'Plane is frustum side'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var plane = [ 0, 0, 1, 0 ];
  var expected = true;

  var gotBool = _.frustum.planeIntersects( srcFrustum, plane );
  test.identical( gotBool, expected );

  test.description = 'Frustum and plane don´t intersect'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var plane = [ 4, 0, 1, 2 ];
  var expected = false;

  var gotBool = _.frustum.planeIntersects( srcFrustum, plane );
  test.identical( gotBool, expected );

  test.description = 'Frustums almost intersecting'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var plane = [ - 1.1, 0 , 1, 0 ];
  var expected = false;

  var gotBool = _.frustum.planeIntersects( srcFrustum, plane );
  test.identical( gotBool, expected );

  test.description = 'Frustum and plane don´t intersect'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var plane = [ 1, 0, 2, 0 ];
  var expected = false;

  var gotBool = _.frustum.planeIntersects( srcFrustum, plane );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.planeIntersects( ));
  test.shouldThrowErrorSync( () => _.frustum.planeIntersects( srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.planeIntersects( srcFrustum, [ 0, 0, 1, 1 ], [ 0, 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.planeIntersects( null, [ 1, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.planeIntersects( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.frustum.planeIntersects( NaN, [ 1, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.planeIntersects( srcFrustum, NaN ));
  test.shouldThrowErrorSync( () => _.frustum.planeIntersects( [], [ 1, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.planeIntersects( [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 1, 0, 0, 1 ] ));

}

//

function planeDistance( test )
{

  test.description = 'Frustum and plane remain unchanged'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var plane = [ 2, 1, 0, 0 ];
  var expected = 2;

  var gotDistance = _.frustum.planeDistance( srcFrustum, plane );
  test.identical( gotDistance, expected );

  var oldFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  test.identical( srcFrustum, oldFrustum );

  var oldPlane = [ 2, 1, 0, 0 ];
  test.identical( plane, oldPlane );

  test.description = 'Frustum and plane intersect'; //

  var plane = [ - 0.4, 1, 0, 0 ];
  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var expected = 0;

  var gotDistance = _.frustum.planeDistance( srcFrustum, plane );
  test.identical( gotDistance, expected );

  test.description = 'Plane cuts Frustum in diagonal'; //

  var plane = [ 0, 0.3, 0.3, 0.3 ];
  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var expected = 0;

  var gotDistance = _.frustum.planeDistance( srcFrustum, plane );
  test.identical( gotDistance, expected );

  test.description = 'Plane is frustum side'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var plane = [ 0, 0, 1, 0 ];
  var expected = 0;

  var gotDistance = _.frustum.planeDistance( srcFrustum, plane );
  test.identical( gotDistance, expected );

  test.description = 'Frustum corner in plane'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var plane = [ -3, 1, 1, 1 ];
  var expected = 0;

  var gotDistance = _.frustum.planeDistance( srcFrustum, plane );
  test.identical( gotDistance, expected );

  test.description = 'Frustums almost intersecting'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var plane = [ - 1.1, 0 , 1, 0 ];
  var expected = 0.1;

  var gotDistance = _.frustum.planeDistance( srcFrustum, plane );
  test.equivalent( gotDistance, expected );

  test.description = 'Plane parallel to frustum side'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var plane = [ 4, 0, 1, 0 ];
  var expected = 4;

  var gotDistance = _.frustum.planeDistance( srcFrustum, plane );
  test.identical( gotDistance, expected );

  test.description = 'Plane opposite to frustum´s corner'; //

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var plane = [ - 6, 1, 1, 1 ];
  var expected = Math.sqrt( 3 );

  var gotDistance = _.frustum.planeDistance( srcFrustum, plane );
  test.equivalent( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.planeDistance( ));
  test.shouldThrowErrorSync( () => _.frustum.planeDistance( srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.planeDistance( srcFrustum, [ 0, 0, 1, 1 ], [ 0, 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.planeDistance( null, [ 1, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.planeDistance( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.frustum.planeDistance( NaN, [ 1, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.planeDistance( srcFrustum, NaN ));
  test.shouldThrowErrorSync( () => _.frustum.planeDistance( [], [ 1, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.planeDistance( [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 1, 0, 0, 1 ] ));

}

//

function planeClosestPoint( test )
{

  test.description = 'Frustum and plane remain unchanged'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var plane = [ -1, 1, 0, 1 ];
  var expected = 0;

  var closestPoint = _.frustum.planeClosestPoint( srcFrustum, plane );
  test.equivalent( closestPoint, expected );

  var oldPlane = [ -1, 1, 0, 1 ];
  test.identical( plane, oldPlane );

  var oldFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Frustrum as box ( 0, 0, 0, 1, 1, 1 ) - corner ( 1, 1, 1 )'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var plane = [ - 6, 1, 1, 1 ];
  var expected = _.frustum.tools.long.make( [ 1, 1, 1 ] );

  var closestPoint = _.frustum.planeClosestPoint( srcFrustum, plane );
  test.equivalent( closestPoint, expected );

  test.description = 'Frustrum as plane ( 0, 0, 0, 1, 1, 1 ) - corner ( 0, 0, 0 )'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var plane = [ 3, 1, 1, 1 ];
  var expected = _.frustum.tools.long.make( [ 0, 0, 0 ] );

  var closestPoint = _.frustum.planeClosestPoint( srcFrustum, plane );
  test.equivalent( closestPoint, expected );

  test.description = 'plane and frustum intersect'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var plane = [ - 2, 1, 1, 1 ];
  var expected = 0;

  var closestPoint = _.frustum.planeClosestPoint( srcFrustum, plane );
  test.identical( closestPoint, expected );

  test.description = 'Plane parallel to inclined frustum side'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 2, 1, - 1, 0, 0,

  ]);
  var plane = [ - 5, 0, -1, 2 ];
  var expected = _.frustum.tools.long.make( [ 0, 2, 1 ] );

  var closestPoint = _.frustum.planeClosestPoint( srcFrustum, plane );
  test.equivalent( closestPoint, expected );

  test.description = 'Diagonal frustum - plane intersection'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 2, 1, - 1, 0, 0,

  ]);
  var plane = [ - 1, 0, 0, 2 ];
  var expected = 0;
  var closestPoint = _.frustum.planeClosestPoint( srcFrustum, plane );
  test.equivalent( closestPoint, expected );

  test.description = 'Frustum Corner in plane'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 2, 1, - 1, 0, 0,

  ]);
  var plane = [ - 3, 1, 1, 1 ];
  var expected = 0;

  var closestPoint = _.frustum.planeClosestPoint( srcFrustum, plane );
  test.equivalent( closestPoint, expected );

  test.description = 'Plane is frustum side'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var plane = [ 0, 1, 0, 0 ];
  var expected = 0;
  var closestPoint = _.frustum.planeClosestPoint( srcFrustum, plane );
  test.equivalent( closestPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.planeClosestPoint( ));
  test.shouldThrowErrorSync( () => _.frustum.planeClosestPoint( srcFrustum, srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.planeClosestPoint( null ));
  test.shouldThrowErrorSync( () => _.frustum.planeClosestPoint( NaN ));
  test.shouldThrowErrorSync( () => _.frustum.planeClosestPoint( srcFrustum, [ 0, 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.planeClosestPoint( [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.planeClosestPoint( [ ] ));
  test.shouldThrowErrorSync( () => _.frustum.planeClosestPoint( null, [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.planeClosestPoint( NaN , [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.planeClosestPoint( srcFrustum, null ));
  test.shouldThrowErrorSync( () => _.frustum.planeClosestPoint( srcFrustum, NaN ));
  test.shouldThrowErrorSync( () => _.frustum.planeClosestPoint( srcFrustum, srcFrustum, [ 0, 0, 0, 1 ] ));

}

//

function rayClosestPoint( test )
{

  /* */

  test.case = 'Source frustum and ray remain unchanged';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var tstRay = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotRay = _.frustum.rayClosestPoint( srcFrustum, tstRay );
  test.identical( expected, gotRay );

  var oldSrcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  test.identical( srcFrustum, oldSrcFrustum );

  var oldtstRay = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( tstRay, oldtstRay );

  /* */

  test.case = 'Frustum and ray intersect';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var tstRay = [ -1, -1, 0, 1, 1, 1 ];
  var expected = 0;

  var gotRay = _.frustum.rayClosestPoint( srcFrustum, tstRay );
  test.identical( expected, gotRay );

  /* */

  test.case = 'Ray origin is frustum corner';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var tstRay = [ 1, 1, 1, 1, 0, 0 ];
  var expected = 0;

  var gotRay = _.frustum.rayClosestPoint( srcFrustum, tstRay );
  test.identical( expected, gotRay );

  /* */

  test.case = 'Ray is frustum side';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var tstRay = [ 1, 0, 0, 1, 0, 0 ];
  var expected = 0;

  var gotRay = _.frustum.rayClosestPoint( srcFrustum, tstRay );
  test.identical( expected, gotRay );

  /* */

  test.case = 'Frustum corner is the closest point';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var tstRay = [ -3, -3, -3, -1, -1, -1 ];
  var expected = _.frustum.tools.long.make( [ 0, 0, 0 ] );

  var gotRay = _.frustum.rayClosestPoint( srcFrustum, tstRay );
  test.identical( expected, gotRay );

  /* */

  test.case = 'Closest point in frustum side';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var tstRay = [ 0.5, 0.5, 2, 0, 0, 1 ];
  var expected = _.frustum.tools.long.make( [ 0.5, 0.5, 1 ] );

  var gotRay = _.frustum.rayClosestPoint( srcFrustum, tstRay );
  test.identical( expected, gotRay );

  /* */

  test.case = 'dstPoint Array';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var tstRay = [ 5, 5, 1, 1, 0, 0 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = _.frustum.tools.long.make( [ 1, 1, 1 ] );

  var gotRay = _.frustum.rayClosestPoint( srcFrustum, tstRay, dstPoint );
  test.identical( expected, gotRay );
  test.true( dstPoint === gotRay );

  /* */

  test.case = 'dstPoint Vector';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var tstRay = [ - 5, 5, 1, 1, 0, 0 ];
  var dstPoint = _.frustum.tools.vectorAdapter.from( [ 0, 0, 0 ] );
  var expected = _.frustum.tools.vectorAdapter.from( [ 0, 1, 1 ] );

  var gotRay = _.frustum.rayClosestPoint( srcFrustum, tstRay, dstPoint );
  test.equivalent( expected, gotRay );
  test.true( dstPoint === gotRay );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.rayClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.frustum.rayClosestPoint( [] ) );
  test.shouldThrowErrorSync( () => _.frustum.rayClosestPoint( 'frustum', 'ray' ) );
  test.shouldThrowErrorSync( () => _.frustum.rayClosestPoint(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.frustum.rayClosestPoint( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.frustum.rayClosestPoint( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.frustum.rayClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.frustum.rayClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.frustum.rayClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], undefined ) );

}

//

function segmentContains( test )
{

  /* */

  test.case = 'Source frustum and segment remain unchanged';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,

  ]);
  var tstSegment = [ 0, 0, 0, 2, 2, 2 ];
  var expected = false;

  var gotBool = _.frustum.segmentContains( srcFrustum, tstSegment );
  test.identical( expected, gotBool );

  var oldSrcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,

  ]);
  test.identical( srcFrustum, oldSrcFrustum );

  var oldtstSegment = [ 0, 0, 0, 2, 2, 2 ];
  test.identical( tstSegment, oldtstSegment );

  /* */

  test.case = 'Frustum and segment don´t intersect';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,

  ]);
  var tstSegment = [ -1, -1, 0, -7, 5, -1 ];
  var expected = false;

  var gotBool = _.frustum.segmentContains( srcFrustum, tstSegment );
  test.identical( expected, gotBool );

  /* */

  test.case = 'Frustum and segment intersect';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,

  ]);
  var tstSegment = [ -1, -1, 0, 1, 1, 1 ];
  var expected = false;

  var gotBool = _.frustum.segmentContains( srcFrustum, tstSegment );
  test.identical( expected, gotBool );

  /* */

  test.case = 'Segment origin is frustum corner';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,

  ]);
  var tstSegment = [ 1, 1, 1, 2, 2, 2 ];
  var expected = false;

  var gotBool = _.frustum.segmentContains( srcFrustum, tstSegment );
  test.identical( expected, gotBool );

  /* */

  test.case = 'Frustum contains segment';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,  0, - 1,   0,   0, - 1,
    0,    0,   0,   0,   1, - 1,
    -1,   1,   0,   0,   0,   0,
    0,    0, - 1,   1,   0,   0,

  ]);
  var tstSegment = [ -0.2, -0.9, -0.5, -0.2, -0.1, -0.2 ];
  var expected = true;

  var gotBool = _.frustum.segmentContains( srcFrustum, tstSegment );
  test.identical( expected, gotBool );

  /* */

  test.case = 'Segment is in frustum edge';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,

  ]);
  var tstSegment = [ 0, 0, 0, 1, 0, 0 ];
  var expected = true;

  var gotBool = _.frustum.segmentContains( srcFrustum, tstSegment );
  test.identical( expected, gotBool );

  /* */

  test.case = 'Segment is in frustum side';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,

  ]);
  var tstSegment = [ 0, 0, 0, 1, 1, 0 ];
  var expected = true;

  var gotBool = _.frustum.segmentContains( srcFrustum, tstSegment );
  test.identical( expected, gotBool );

  /* */

  test.case = 'Segment from frustum corner to frustum corner';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,

  ]);
  var tstSegment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.frustum.segmentContains( srcFrustum, tstSegment );
  test.identical( expected, gotBool );

  /* */

  if( !Config.debug )
  return;

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1,   0, - 1,   0,   0, - 1,
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,

  ]);
  test.shouldThrowErrorSync( () => _.frustum.segmentContains( ) );
  test.shouldThrowErrorSync( () => _.frustum.segmentContains( [] ) );
  test.shouldThrowErrorSync( () => _.frustum.segmentContains( 'frustum', 'segment' ) );
  test.shouldThrowErrorSync( () => _.frustum.segmentContains(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.frustum.segmentContains( srcFrustum ) );
  test.shouldThrowErrorSync( () => _.frustum.segmentContains( srcFrustum, srcFrustum ) );
  test.shouldThrowErrorSync( () => _.frustum.segmentContains( srcFrustum, [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.frustum.segmentContains( srcFrustum, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.frustum.segmentContains( srcFrustum, [ 1, 0, 1, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.frustum.segmentContains( srcFrustum, [ 1, 0, 1, 2, 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.frustum.segmentContains( null, [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.frustum.segmentContains( srcFrustum, null ) );
  test.shouldThrowErrorSync( () => _.frustum.segmentContains( undefined, [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.frustum.segmentContains( srcFrustum, undefined ) );

}

//

function segmentClosestPoint( test )
{

  /* */

  test.case = 'Source frustum and segment remain unchanged';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var tstSegment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotSegment = _.frustum.segmentClosestPoint( srcFrustum, tstSegment );
  test.identical( expected, gotSegment );

  var oldSrcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  test.identical( srcFrustum, oldSrcFrustum );

  var oldtstSegment = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( tstSegment, oldtstSegment );

  /* */

  test.case = 'Frustum and segment intersect';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var tstSegment = [ -1, -1, 0, 1, 1, 1 ];
  var expected = 0;

  var gotSegment = _.frustum.segmentClosestPoint( srcFrustum, tstSegment );
  test.identical( expected, gotSegment );

  /* */

  test.case = 'Segment origin is frustum corner';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var tstSegment = [ 1, 1, 1, 2, 2, 2 ];
  var expected = 0;

  var gotSegment = _.frustum.segmentClosestPoint( srcFrustum, tstSegment );
  test.identical( expected, gotSegment );

  /* */

  test.case = 'Segment end is frustum corner';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var tstSegment = [ -1, -1, -1, 0, 0, 0 ];
  var expected = 0;

  var gotSegment = _.frustum.segmentClosestPoint( srcFrustum, tstSegment );
  test.identical( expected, gotSegment );

  /* */

  test.case = 'Segment is frustum side';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var tstSegment = [ 0, 0, 0, 1, 0, 0 ];
  var expected = 0;

  var gotSegment = _.frustum.segmentClosestPoint( srcFrustum, tstSegment );
  test.identical( expected, gotSegment );

  /* */

  test.case = 'Negative factor on corner';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var tstSegment = [ 3, 3, 3, 4, 4, 4 ];
  var expected = _.frustum.tools.long.make( [ 1, 1, 1 ] );

  var gotSegment = _.frustum.segmentClosestPoint( srcFrustum, tstSegment );
  test.identical( expected, gotSegment );

  /* */

  test.case = 'Positive factor on corner';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var tstSegment = [ -3, -3, -3, -1, -1, -1 ];
  var expected = _.frustum.tools.long.make( [ 0, 0, 0 ] );

  var gotSegment = _.frustum.segmentClosestPoint( srcFrustum, tstSegment );
  test.identical( expected, gotSegment );

  /* */

  test.case = 'Negative factor on side';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var tstSegment = [ 0.5, 0.5, 2, 0.5, 0.5, 3 ];
  var expected = _.frustum.tools.long.make( [ 0.5, 0.5, 1 ] );

  var gotSegment = _.frustum.segmentClosestPoint( srcFrustum, tstSegment );
  test.identical( expected, gotSegment );

  /* */

  test.case = 'Positive factor on side';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var tstSegment = [ 0.5, 0.5, - 2, 0.5, 0.5, - 1 ];
  var expected = _.frustum.tools.long.make( [ 0.5, 0.5, 0 ] );

  var gotSegment = _.frustum.segmentClosestPoint( srcFrustum, tstSegment );
  test.identical( expected, gotSegment );

  /* */

  test.case = 'Closest point is corner';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var tstSegment = [ 0, 0, 2, 0, 0, 7 ];
  var expected = _.frustum.tools.long.make( [ 0, 0, 1 ] );

  var gotSegment = _.frustum.segmentClosestPoint( srcFrustum, tstSegment );
  test.identical( expected, gotSegment );

  /* */

  test.case = 'Closest point on side';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var tstSegment = [ 0.2, 0.3, 1.1, 0.4, 0.5, 1.2 ];
  var expected = _.frustum.tools.long.make( [ 0.2, 0.3, 1 ] );

  var gotSegment = _.frustum.segmentClosestPoint( srcFrustum, tstSegment );
  test.identical( expected, gotSegment );

  /* */

  test.case = 'dstPoint Array';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var tstSegment = [ 5, 5, 1, 8, 5, 1 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = _.frustum.tools.long.make( [ 1, 1, 1 ] );

  var gotSegment = _.frustum.segmentClosestPoint( srcFrustum, tstSegment, dstPoint );
  test.identical( expected, gotSegment );
  test.true( dstPoint === gotSegment );

  /* */

  test.case = 'dstPoint Vector';

  var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var tstSegment = [ - 5, 5, 1, -3, 5, 1 ];
  var dstPoint = _.vectorAdapter.from( [ 0, 0, 0 ] );
  var expected = _.frustum.tools.vectorAdapter.from( [ 0, 1, 1 ] );

  var gotSegment = _.frustum.segmentClosestPoint( srcFrustum, tstSegment, dstPoint );
  test.equivalent( expected, gotSegment );
  test.true( dstPoint === gotSegment );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.segmentClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.frustum.segmentClosestPoint( [] ) );
  test.shouldThrowErrorSync( () => _.frustum.segmentClosestPoint( 'frustum', 'segment' ) );
  test.shouldThrowErrorSync( () => _.frustum.segmentClosestPoint(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.frustum.segmentClosestPoint( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.frustum.segmentClosestPoint( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.frustum.segmentClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.frustum.segmentClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.frustum.segmentClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], undefined ) );

}

//

function sphereContains( test )
{

  test.description = 'Frustum and sphere remain unchanged'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var sphere = [ 3, 3, 3, 1 ];
  var expected = false;

  var gotBool = _.frustum.sphereContains( srcFrustum, sphere );
  test.identical( gotBool, expected );

  var oldSphere = [ 3, 3, 3, 1 ];
  test.identical( sphere, oldSphere );

  var oldFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Frustum contains sphere'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var sphere = [ 0.5, 0.5, 0.5, 0.4 ];
  var expected = true;

  var gotBool = _.frustum.sphereContains( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Sphere bigger than frustum'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var sphere = [ 0.5, 0.5, 0.5, 1 ];
  var expected = false;

  var gotBool = _.frustum.sphereContains( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Frustum and sphere don´t intersect'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var sphere = [ 5, 5, 5, 2 ];
  var expected = false;

  var gotBool = _.frustum.sphereContains( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Frustum and sphere intersect'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var sphere = [ 1, 1, 1, 0.5 ];
  var expected = false;

  var gotBool = _.frustum.sphereContains( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Frustum contains sphere not in the middle'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var sphere = [ 0.4, 0.3, 0.6, 0.1 ];
  var expected = true;

  var gotBool = _.frustum.sphereContains( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Frustum and sphere contained and touching'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var sphere = [ 0.5, 0.5, 0.5, 0.5 ];
  var expected = true;

  var gotBool = _.frustum.sphereContains( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Zero sphere'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var sphere = _.sphere.makeZero();
  var expected = true;

  var gotBool = _.frustum.sphereContains( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Zero frustum'; //

  var srcFrustum = _.frustum.make();
  var sphere = [ 0, 0, 0, 2 ];
  var expected = true;

  var gotBool = _.frustum.sphereContains( srcFrustum, sphere );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var sphere = [ 0, 0, 1, 2];
  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);

  test.shouldThrowErrorSync( () => _.frustum.sphereContains( ));
  test.shouldThrowErrorSync( () => _.frustum.sphereContains( sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereContains( srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.sphereContains( srcFrustum, srcFrustum, sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereContains( srcFrustum, sphere, sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereContains( null, sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereContains( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.frustum.sphereContains( NaN, sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereContains( srcFrustum, NaN));

  var sphere = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.frustum.sphereContains( srcFrustum, sphere ));

}

//

function sphereIntersects( test )
{

  test.description = 'Frustum and sphere remain unchanged'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var sphere = [ 3, 3, 3, 1 ];
  var expected = false;

  var gotBool = _.frustum.sphereIntersects( srcFrustum, sphere );
  test.identical( gotBool, expected );

  var oldSphere = [ 3, 3, 3, 1 ];
  test.identical( sphere, oldSphere );

  var oldFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Frustum and sphere intersect'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var sphere = [ 1, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.frustum.sphereIntersects( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Frustum and sphere intersect, sphere bigger than frustum'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var sphere = [ 1, 1, 1, 7 ];
  var expected = true;

  var gotBool = _.frustum.sphereIntersects( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Frustum and sphere intersect, frustum bigger than sphere'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var sphere = [ 0.5, 0.5, 0.5, 0.1 ];
  var expected = true;

  var gotBool = _.frustum.sphereIntersects( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Frustum and sphere not intersecting'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var sphere = [ 5, 5, 5, 1 ];
  var expected = false;

  var gotBool = _.frustum.sphereIntersects( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Frustum and sphere almost intersecting'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var sphere = [ 5 , 5, 5, 6.9 ];
  var expected = false;

  var gotBool = _.frustum.sphereIntersects( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Frustum and sphere just touching'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var sphere = [ 5 , 5, 5, 6.93 ];
  var expected = true;

  var gotBool = _.frustum.sphereIntersects( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Frustum and sphere just intersect'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var sphere = [ 5, 5, 5, 7 ];
  var expected = true;

  var gotBool = _.frustum.sphereIntersects( srcFrustum, sphere );
  test.identical( gotBool, expected );

  test.description = 'Zero frustum, intersection'; //

  var srcFrustum = _.frustum.make();
  var sphere = [ 0, 0, 0, 2 ];
  var expected = true;

  var gotBool = _.frustum.sphereIntersects( srcFrustum, sphere );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var sphere = [ 0, 0, 1, 2];
  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);

  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( ));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( srcFrustum, srcFrustum, sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( srcFrustum, sphere, sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( null, sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( NaN, sphere ));
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( srcFrustum, NaN));

  var sphere = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.frustum.sphereIntersects( srcFrustum, sphere ));

}

//

function sphereClosestPoint( test )
{

  test.description = 'Frustum and sphere remain unchanged'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var sphere = [ 0.5, 0.5, 0.5, 0.5 ];
  var expected = 0;

  var closestPoint = _.frustum.sphereClosestPoint( srcFrustum, sphere );
  test.equivalent( closestPoint, expected );

  var oldSphere = [ 0.5, 0.5, 0.5, 0.5 ];
  test.identical( sphere, oldSphere );

  var oldFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Frustrum as box ( 0, 0, 0, 1, 1, 1 ) - corner ( 1, 1, 1 )'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var sphere = [ 2.5, 2.5, 2.5, 0.5 ];
  var expected = _.frustum.tools.long.make( [ 1, 1, 1 ] );

  var closestPoint = _.frustum.sphereClosestPoint( srcFrustum, sphere );
  test.equivalent( closestPoint, expected );

  test.description = 'Frustrum as box ( 0, 0, 0, 1, 1, 1 ) - corner ( 0, 0, 0 )'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var sphere = [ -1, -1, -1, 0.5 ];
  var expected = _.frustum.tools.long.make( [ 0, 0, 0 ] );

  var closestPoint = _.frustum.sphereClosestPoint( srcFrustum, sphere );
  test.equivalent( closestPoint, expected );

  test.description = 'sphere and frustum intersect'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var sphere = [ -1, -1, -1, 1.8 ];
  var expected = 0;

  var closestPoint = _.frustum.sphereClosestPoint( srcFrustum, sphere );
  test.identical( closestPoint, expected );

  test.description = 'Point in inclined frustum side'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 2, 1, - 1, 0, 0,

  ]);
  var sphere = [ 0.5, 1.5, 1, 0.01 ];
  var expected = _.frustum.tools.long.make( [ 0.5, 1.6, 0.79999999 ] );

  var closestPoint = _.frustum.sphereClosestPoint( srcFrustum, sphere );
  test.equivalent( closestPoint, expected );

  test.description = 'Diagonal frustum plane'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 2, 1, - 1, 0, 0,

  ]);
  var sphere = [ 0, 0, 2, 0.01 ];
  var expected = _.frustum.tools.long.make( [ 0, 0.4, 0.20000 ] );
  var closestPoint = _.frustum.sphereClosestPoint( srcFrustum, sphere );
  test.equivalent( closestPoint, expected );

  test.description = 'Pointsphere'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 3, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 2, 1, - 1, 0, 0,

  ]);
  var sphere = [ -2, -2, -2, 0 ];
  var expected = _.frustum.tools.long.make( [ 0, 0, 0 ] );

  var closestPoint = _.frustum.sphereClosestPoint( srcFrustum, sphere );
  test.equivalent( closestPoint, expected );

  test.description = 'Pointsphere on side'; //

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var sphere = [ 1.1, 0.5, 0.5, 0 ];
  var expected = _.frustum.tools.long.make( [ 1, 0.5, 0.5 ] );
  var closestPoint = _.frustum.sphereClosestPoint( srcFrustum, sphere );
  test.equivalent( closestPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( srcFrustum, srcFrustum ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( null ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( NaN ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( srcFrustum, [ 0, 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( [ ] ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( null, [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( NaN , [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( srcFrustum, null ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( srcFrustum, NaN ));
  test.shouldThrowErrorSync( () => _.frustum.sphereClosestPoint( srcFrustum, srcFrustum, [ 0, 0, 0, 1 ] ));

}

//

function boundingSphereGet( test )
{

  /* */

  test.case = 'Source frustum remains unchanged';

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var dstSphere = [ 1, 1, 2, 1 ];
  var expected = _.frustum.tools.long.make( [ 0.5, 0.5, 0.5, Math.sqrt( 0.75 ) ] );

  var gotSphere = _.frustum.boundingSphereGet( dstSphere, srcFrustum );
  test.identical( expected, gotSphere );
  test.true( dstSphere === gotSphere );

  var oldSrcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  test.identical( srcFrustum, oldSrcFrustum );

  /* */

  test.case = 'Zero frustum to zero sphere';

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var dstSphere = [ 0, 0, 0, 1 ];
  var expected = _.frustum.tools.long.make( [ 0, 0, 0, 0 ] );

  var gotSphere = _.frustum.boundingSphereGet( dstSphere, srcFrustum );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Sphere inside frustum - same center';

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 4, 0, - 4, 0, 0, - 4,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var dstSphere = [ 2, 2, 2, 1 ];
  var expected = _.frustum.tools.long.make( [ 2, 2, 2, Math.sqrt( 12 ) ] );

  var gotSphere = _.frustum.boundingSphereGet( dstSphere, srcFrustum );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Point frustum and point Sphere';

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 1, - 1, 1, 1, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var dstSphere = [ 3, 3, 3, 0 ];
  var expected = _.frustum.tools.long.make( [ 1, 1, 1, 0 ] );

  var gotSphere = _.frustum.boundingSphereGet( dstSphere, srcFrustum );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Frustum inside Sphere';

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var dstSphere = [ 0, 0, 0, 3 ];
  var expected = _.frustum.tools.long.make( [ 0.5, 0.5, 0.5, Math.sqrt( 0.75 ) ] );

  var gotSphere = _.frustum.boundingSphereGet( dstSphere, srcFrustum );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Sphere outside frustum';

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 0, - 2, 0, 0, - 2,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var dstSphere = [ 5, 5, 5, 3 ];
  var expected = _.frustum.tools.long.make( [ 1, 1, 1, Math.sqrt( 3 ) ] );

  var gotSphere = _.frustum.boundingSphereGet( dstSphere, srcFrustum );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'dstSphere vector';

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    1, 3, 1, 1, 3, 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var dstSphere = _.frustum.tools.vectorAdapter.from( [ 5, 5, 5, 3 ] );
  var expected = _.frustum.tools.vectorAdapter.from( [ 1, 1, 0, 3 ] );

  var gotSphere = _.frustum.boundingSphereGet( dstSphere, srcFrustum );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'dstSphere null';

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 5, 7, 1, 1, 3, 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var dstSphere = null;
  var expected = _.frustum.tools.long.make( [ 1, 6, 0, Math.sqrt( 6 ) ] );

  var gotSphere = _.frustum.boundingSphereGet( dstSphere, srcFrustum );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'dstSphere undefined';

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    3, 0, 0, 5, 1, 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var dstSphere = undefined;
  var expected = _.frustum.tools.long.make( [ 0, - 1.5, 2.5, Math.sqrt( 9.5 ) ] );

  var gotSphere = _.frustum.boundingSphereGet( dstSphere, srcFrustum );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'srcFrustum inversed';

  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 2, 4, - 2, 4, 4, - 2,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  var dstSphere = [ 5, 5, 5, 3 ];
  var expected = _.frustum.tools.long.make( [ 3, 3, 3, Math.sqrt( 3 ) ] );

  var gotSphere = _.frustum.boundingSphereGet( dstSphere, srcFrustum );
  test.identical( gotSphere, expected );

  /* */

  if( !Config.debug )
  return;
  var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    1, 3, - 5, 7, 1, 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,

  ]);
  test.shouldThrowErrorSync( () => _.frustum.boundingSphereGet( ) );
  test.shouldThrowErrorSync( () => _.frustum.boundingSphereGet( [] ) );
  test.shouldThrowErrorSync( () => _.frustum.boundingSphereGet( [], [] ) );
  test.shouldThrowErrorSync( () => _.frustum.boundingSphereGet( 'sphere', 'frustum' ) );
  test.shouldThrowErrorSync( () => _.frustum.boundingSphereGet( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.frustum.boundingSphereGet( srcFrustum ) );
  test.shouldThrowErrorSync( () => _.frustum.boundingSphereGet( [ 0, 0, 0, 1 ], [ 0, 1, 0, 1 ], srcFrustum ) );
  test.shouldThrowErrorSync( () => _.frustum.boundingSphereGet( [ 0, 1, 0, 1, 2, 1 ], srcFrustum ) );
  test.shouldThrowErrorSync( () => _.frustum.boundingSphereGet( NaN, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.frustum.boundingSphereGet( [ 0, 1, 0, 1, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.frustum.boundingSphereGet( [ 0, 1, 0, 1, 2, 1 ], NaN ) );

}

// --
// declare
// --

const Proto =
{

  name : 'Tools.Math.Frustum',
  silencing : 1,

  tests :
  {
    fromMatrixHomogenous,
    cornersGet,

    pointContains,
    pointDistance,
    pointClosestPoint,

    boxContains,
    boxIntersects,
    boxClosestPoint,
    boundingBoxGet,

    capsuleContains,
    capsuleClosestPoint,

    convexPolygonContains,
    convexPolygonClosestPoint,

    frustumContains,
    frustumIntersects,
    frustumDistance,
    frustumClosestPoint,

    lineClosestPoint,

    planeIntersects,
    planeDistance,
    planeClosestPoint,

    rayClosestPoint,

    segmentContains,
    segmentClosestPoint,

    sphereContains,
    sphereIntersects,
    sphereClosestPoint,
    boundingSphereGet,

  }

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
