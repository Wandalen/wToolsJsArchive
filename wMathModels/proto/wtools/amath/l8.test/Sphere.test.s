( function _Sphere_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  //

  const _ = require( '../../../node_modules/Tools' );

  _.include( 'wTesting' );
  _.include( 'wMathVector' );

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

  test.case = 'src undefined';

  var src = undefined;
  var got = _.sphere.make( src );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 0 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src null';

  var src = null;
  var got = _.sphere.make( src );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 0 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src 2';

  var src = 2;
  var got = _.sphere.make( src );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src array';

  var src = [ 0, 1, 2, 3 ];
  var got = _.sphere.make( src );
  var expected = _.sphere.tools.long.make( [ 0, 1, 2, 3 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src vector';

  var src = _.vectorAdapter.fromLong([ 0, 1, 2, 3 ]);
  var got = _.sphere.make( src );
  var expected = _.sphere.tools.long.make( [ 0, 1, 2, 3 ] );
  test.identical( got, expected );
  test.true( got !== src );

}

//

function makeZero( test )
{

  /* */

  test.case = 'src undefined';

  var src = undefined;
  var got = _.sphere.makeZero( src );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 0 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src null';

  var src = null;
  var got = _.sphere.makeZero( src );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 0 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src 2';

  var src = 2;
  var got = _.sphere.makeZero( src );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src array';

  var src = [ 0, 1, 2, 3 ];
  var got = _.sphere.makeZero( src );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 0 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src vector';

  var src = _.vectorAdapter.fromLong([ 0, 1, 2, 3 ]);
  var got = _.sphere.makeZero( src );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 0 ] );
  test.identical( got, expected );
  test.true( got !== src );

}

//

function makeSingular( test )
{

  /* */

  test.case = 'src undefined';

  var src = undefined;
  var got = _.sphere.makeSingular( src );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, -Infinity ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src null';

  var src = null;
  var got = _.sphere.makeSingular( src );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, -Infinity ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src 2';

  var src = 2;
  var got = _.sphere.makeSingular( src );
  var expected = _.sphere.tools.long.make( [ 0, 0, -Infinity ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src array';

  var src = [ 0, 1, 2, 3 ];
  var got = _.sphere.makeSingular( src );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, -Infinity ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src vector';

  var src = _.vectorAdapter.fromLong([ 0, 1, 2, 3 ]);
  var got = _.sphere.makeSingular( src );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, -Infinity ] );
  test.identical( got, expected );
  test.true( got !== src );

}

//

function zero( test )
{

  /* */

  test.case = 'src undefined';

  var src = undefined;
  var got = _.sphere.zero( src );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 0 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src null';

  var src = null;
  var got = _.sphere.zero( src );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 0 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src 2';

  var src = 2;
  var got = _.sphere.zero( src );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'dst array';

  var dst = [ 0, 1, 2, 3 ];
  var got = _.sphere.zero( dst );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 0 ] );
  test.identical( got, expected );
  test.true( got === dst );

  /* */

  test.case = 'dst vector';

  var dst = _.vectorAdapter.fromLong([ 0, 1, 2, 3 ]);
  var got = _.sphere.zero( dst );
  var expected = _.sphere.tools.vectorAdapter.fromLong([ 0, 0, 0, 0 ]);
  test.identical( got, expected );
  test.true( got === dst );

  /* */

  test.case = 'dst array 2d';

  var dst = [ 0, 1, 5 ];
  var got = _.sphere.zero( dst );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0 ] );
  test.identical( got, expected );
  test.true( got === dst );

}

//

function nil( test )
{

  /* */

  test.case = 'src undefined';

  var src = undefined;
  var got = _.sphere.nil( src );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, -Infinity ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src null';

  var src = null;
  var got = _.sphere.nil( src );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, -Infinity ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src 2';

  var src = 2;
  var got = _.sphere.nil( src );
  var expected = _.sphere.tools.long.make( [ 0, 0, -Infinity ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'dst array';

  var dst = [ 0, 1, 2, 3 ];
  var got = _.sphere.nil( dst );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, -Infinity ] );
  test.identical( got, expected );
  test.true( got === dst );

  /* */

  test.case = 'dst vector';

  var dst = _.vectorAdapter.fromLong([ 0, 1, 2, 3 ]);
  var got = _.sphere.nil( dst );
  var expected = _.sphere.tools.vectorAdapter.fromLong([ 0, 0, 0, -Infinity ]);
  test.identical( got, expected );
  test.true( got === dst );

  /* */

  test.case = 'dst array 2d';

  var dst = [ 0, 1, 5 ];
  var got = _.sphere.nil( dst );
  var expected = _.sphere.tools.long.make( [ 0, 0, -Infinity ] );
  test.identical( got, expected );
  test.true( got === dst );

}

//

function centeredOfRadius( test )
{
  /* */

  test.case = 'src 2';

  var src = 2;
  var got = _.sphere.centeredOfRadius(  null, src );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 2 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'dst array';

  var dst = [ 0, 1, 2, 3 ];
  var got = _.sphere.centeredOfRadius( dst, 0.5 );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 0.5 ] );
  test.identical( got, expected );
  test.true( got === dst );

  /* */

  test.case = 'dst vector';

  var dst = _.vectorAdapter.fromLong([ 0, 1, 2, 3 ]);
  var got = _.sphere.centeredOfRadius( dst, 0.5 );
  var expected = _.sphere.tools.vectorAdapter.fromLong([ 0, 0, 0, 0.5 ]);
  test.identical( got, expected );
  test.true( got === dst );

  /* */

  test.case = 'dst array 2d';

  var dst = [ 0, 1, 5 ];
  var got = _.sphere.centeredOfRadius( dst, 0.5 );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0.5 ] );
  test.identical( got, expected );
  test.true( got === dst );

  /* */

  /* */

  test.case = 'src undefined';

  var src = undefined;
  var got = _.sphere.centeredOfRadius( src, 2 );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 2 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src null';

  var src = null;
  var got = _.sphere.centeredOfRadius( src, 2 );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 2 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src 2';

  var src = 2;
  var got = _.sphere.centeredOfRadius( src, 2 );
  var expected = _.sphere.tools.long.make( [ 0, 0, 2 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'dst array';

  var dst = [ 0, 1, 2, 3 ];
  var got = _.sphere.centeredOfRadius( dst, 2 );
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 2 ] );
  test.identical( got, expected );
  test.true( got === dst );

  /* */

  test.case = 'dst vector';

  var dst = _.vectorAdapter.fromLong([ 0, 1, 2, 3 ]);
  var got = _.sphere.centeredOfRadius( dst, 2 );
  var expected = _.sphere.tools.vectorAdapter.fromLong([ 0, 0, 0, 2 ]);
  test.identical( got, expected );
  test.true( got === dst );

  /* */

  test.case = 'dst array 2d';

  var dst = [ 0, 1, 5 ];
  var got = _.sphere.centeredOfRadius( dst, 2 );
  var expected = _.sphere.tools.long.make( [ 0, 0, 2 ] );
  test.identical( got, expected );
  test.true( got === dst );

}

//

function fromPoints( test )
{

  /* */

  test.case = 'Points remain unchanged and Destination sphere changes';

  var dstSphere = [ 0, 0, 0, 1 ];
  var points = [ [ 1, 1, 0 ], [ 0, 0, 0 ], [ 0, 0, 2 ] ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 2 ] );

  var gotSphere = _.sphere.fromPoints( dstSphere, points );
  test.identical( gotSphere, expected );
  test.identical( dstSphere, expected );

  var oldpoints = [ [ 1, 1, 0 ], [ 0, 0, 0 ], [ 0, 0, 2 ] ];
  test.identical( points, oldpoints );

  /* */

  test.case = 'Create sphere of two dimensions';

  var dstSphere = null;
  var points = [ [ 1, 0 ], [ 0, - 2 ], [ 0, 3 ], [ - 3, 4 ] ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 5 ] );

  var gotSphere = _.sphere.fromPoints( dstSphere, points );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Create sphere three dimensions';

  var dstSphere = null;
  var points = [ [ 1, 0, 0 ], [ 0, 2, 0 ], [ 0, 0, 3 ] ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 3 ] );

  var gotSphere = _.sphere.fromPoints( dstSphere, points );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Zero points - sphere not expanded';

  var dstSphere = null;
  var points= [ [ 0, 0, 0 ], [ 0, 0, 0 ] ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 0 ] );

  var gotSphere = _.sphere.fromPoints( dstSphere, points);
  test.identical( gotSphere, expected );

  /* */

  test.case = 'sphere expanded';

  var dstSphere = [ 0, 0, 0, 2 ];
  var points= [ [ - 1, 0, - 1 ], [ 0, 3, 0 ], [ 0, - 3, 0 ] ] ;
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 3 ] );

  var gotSphere = _.sphere.fromPoints( dstSphere, points);
  test.identical( gotSphere, expected );

  /* */

  test.case = 'sphere NOT expanded ( points inside sphere )';

  var dstSphere = [ 1, 1, 1, 2 ];
  var points= [ [ 0, 1, 1 ], [ 1, 0, 1 ], [ 1, 1, 0 ] ];
  var expected = _.sphere.tools.long.make( [ 1, 1, 1, 1 ] );

  var gotSphere = _.sphere.fromPoints( dstSphere, points);
  test.identical( gotSphere, expected );

  /* */

  test.case = 'sphere ( normalized to 1 ) expanded';

  var dstSphere = [ 0, 0, 0, 0 ];
  var points= [ [ - 0.500, 0, 0 ], [ 0, 0.005, 0 ] ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 0.5 ] );

  var gotSphere = _.sphere.fromPoints( dstSphere, points);
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Null sphere of four dimensions expanded';

  var dstSphere = [ 0, 0, 0, 0, 0 ];
  var points= [ [ 0, 0, 0, 1 ], [ 0, 0, 3 , 4 ] ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 0, 5 ] );

  var gotSphere = _.sphere.fromPoints( dstSphere, points);
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Null sphere of 7 dimensions expanded';

  var dstSphere = [  0, 0, 0, 0, 0, 0, 0, 1 ];
  var points= [ [ 0, 2, 0, 0, 0, 0, 0 ], [ 0, 0, 0 , 4, 0, 0, 0 ] ] ;
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 0, 0, 0, 0, 4 ] );

  var gotSphere = _.sphere.fromPoints( dstSphere, points);
  test.identical( gotSphere, expected );

  /* */

  test.case = 'sphere of 1 dimension expanded';

  var dstSphere = [ 0, 0 ];
  var points= [ [ - 1 ], [ 0 ], [ 1 ] ];
  var expected = _.sphere.tools.long.make( [ 0, 1 ] );

  var gotSphere = _.sphere.fromPoints( dstSphere, points);
  test.identical( gotSphere, expected );


  /* */

  test.case = 'sphere of 1 dimension not expanded - NaN';

  var dstSphere = [ NaN, NaN ];
  var points= [ [ NaN ], [ NaN ], [ NaN ] ];
  var expected = _.sphere.tools.long.make( [ NaN, NaN ] );

  var gotSphere = _.sphere.fromPoints( dstSphere, points);
  test.identical( gotSphere, expected );

  /* */

  test.case = 'sphere of 1 dimension not expanded - NaN';

  var dstShere = [ NaN, NaN ];
  var points= [ [ 1 ], [ 2 ], [ 0 ] ];
  var expected = _.sphere.tools.long.make( [ NaN, NaN ] );

  var gotSphere = _.sphere.fromPoints( dstSphere, points);
  test.identical( gotSphere, expected );


  /* */

  test.case = 'sphere of 1 dimension not expanded - NaN';

  var dstSphere = [ 0, 1 ];
  var points= [ [ NaN ], [ NaN ], [ NaN ] ];
  var expected = _.sphere.tools.long.make( [ 0, NaN ] );

  var gotSphere = _.sphere.fromPoints( dstSphere, points);
  test.identical( gotSphere, expected );

  /* */

  if( !Config.debug )
  return;

  /* */

  test.case = 'No arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromPoints();
  });


  /* */

  test.case = 'Wrong type of argument - none';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromPoints( [ ] , [ [ ], [ ] ] );
  });

  /* */

  test.case = 'Wrong type of argument - string';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromPoints( 'sphere', 'points' );
  });

  /* */

  test.case = 'Wrong type of argument - null';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromPoints( null, null );
  });

  /* */

  test.case = 'Wrong type of argument - number';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromPoints( null, 4 );
  });

  /* */

  test.case = 'Too few arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromPoints( [ 0, 0, 0 ] );
  });

  /* */

  test.case = 'Too few arguments - one point';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromPoints( [ 0, 0, 0 ], [ 1, 1, 1 ]);
  });

  /* */

  test.case = 'too many arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromPoints( [ 0, 0, 0 ], [ [ 0, 1 ], [ 2, 1 ], [ 0, 3 ] ], [ 1, 0 ] );
  });

  /* */

  test.case = 'Wrong points dimension (sphere 3D vs points 4D)';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromPoints( [ 0, 0, 0, 0 ], [ [ 0, 1, 0, 2 ], [ 0, 1, - 3, 4 ] ] );
  });

  /* */

  test.case = 'Wrong points dimension (sphere 3D vs points 2D)';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromPoints( [ 0, 0, 0, 0 ], [ [ 0, 1 ], [ 2, 1 ], [ 0, 3 ] ] );
  });

  /* */

  test.case = 'Wrong points dimension (sphere 2D vs points 1D)';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromPoints( [ 0, 0, 0 ], [ [ 1 ], [ 0 ] ] );
  });
}

//

function fromBox( test )
{

  debugger;

  /* */

  test.case = 'trivial';

  var expected = _.sphere.tools.long.make( [ 0.5, 0.5, 0.5, sqrt( 0.75 ) ] );
  var bsphere = [ 0, 0, 0, 0 ];
  var bbox = [ 0, 0, 0, 1, 1, 1 ];

  _.sphere.fromBox( bsphere, bbox );
  test.equivalent( bsphere, expected );

  var expected = vec( expected );
  var bsphere = vec([ 0, 0, 0, 0 ]);
  var bbox = vec( bbox );

  _.sphere.fromBox( bsphere, bbox );
  test.equivalent( bsphere, expected );

  /* */

  test.case = 'same sizes, different position';

  var expected = _.sphere.tools.long.make( [ -2.5, 0.5, 5.5, sqrt( 0.75 ) ] );
  var bsphere = [ 0, 0, 0, 0 ];
  var bbox = [ -3, 0, 5, -2, 1, 6 ];

  _.sphere.fromBox( bsphere, bbox );
  test.equivalent( bsphere, expected );

  var expected = vec( expected );
  var bsphere = vec([ 0, 0, 0, 0 ]);
  var bbox = vec( bbox );

  _.sphere.fromBox( bsphere, bbox );
  test.equivalent( bsphere, expected );

  /* */

  test.case = 'different sizes, different position';

  var expected = _.sphere.tools.long.make( [ -2, 0.5, 7, sqrt( 21 )/2 ] );
  var bsphere = [ 0, 0, 0, 0 ];
  var bbox = [ -3, 0, 5, -1, 1, 9 ];

  _.sphere.fromBox( bsphere, bbox );
  test.equivalent( bsphere, expected );

  var expected = vec( expected );
  var bsphere = vec([ 0, 0, 0, 0 ]);
  var bbox = vec( bbox );

  _.sphere.fromBox( bsphere, bbox )
  test.equivalent( bsphere, expected );

  /* */

  test.case = 'transfrom cube to sphere';
  var box = _.box.fromCube( null, 6 );
  var gotSphere = _.sphere.fromBox( null, box );
  var expected = _.sphere.tools.long.make([ 0, 0, 0, 3 ]);
  test.identical( gotSphere, expected );

  test.case = 'Nil box';
  var box = _.box.nil();
  var gotSphere = _.sphere.fromBox( null, box );
  test.true( _.sphere.isNil( gotSphere ) );

  test.case = 'Nil box';
  var box = _.box.nil();
  var dstShere = _.sphere.make();
  var gotSphere = _.sphere.fromBox( dstShere, box );
  test.identical( dstShere, gotSphere );
  test.true( _.sphere.isNil( gotSphere ) );

  /* */

  test.case = 'bad arguments';

  if( !Config.debug )
  return;

  function shouldThrowErrorOfAnyKind( rname )
  {

    test.shouldThrowErrorSync( () => _.avector[ rname ]() );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1, 2 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1, 2 ], [ 3 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1, 2 ], [ 3, 4 ], [ 5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1, 2 ], [ 3, 4 ], 1 ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1, 2 ], [ 3, 4 ], undefined ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1, 2 ], [ 3, 4 ], '1' ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1, 2, 3, 4 ], [ 1, 2, 3, 4, 5 ] ) );
    test.shouldThrowErrorSync( () => _.avector[ rname ]( [ 1, 2, 3 ], [ 1, 2, 3, 4, 5, 6 ] ) );

    test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]() );
    test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]( vec([ 1, 2 ]) ) );
    test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]( vec([ 1, 2 ]), vec([ 3 ]) ) );
    test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]( vec([ 1, 2 ]), vec([ 3, 4 ]), vec([ 5 ]) ) );
    test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]( vec([ 1, 2 ]), vec([ 3, 4 ]), 1 ) );
    test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]( vec([ 1, 2 ]), vec([ 3, 4 ]), undefined ) );
    test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]( vec([ 1, 2 ]), vec([ 3, 4 ]), '1' ) );
    test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]( vec([ 1, 2, 3, 4 ]), vec([ 1, 2, 3, 4, 5 ]) ) );
    test.shouldThrowErrorSync( () => _.vectorAdapter[ rname ]( vec([ 1, 2, 3 ]), vec([ 1, 2, 3, 4, 5, 6 ]) ) );

  }

  shouldThrowErrorOfAnyKind( 'sphereFromBox' );

  debugger;
}

//

function fromCenterAndRadius( test )
{

  /* */

  test.case = 'Center and radius remain unchanged and Destination sphere changes';

  var dstSphere = [ 0, 0, 0, 1 ];
  var center = [ 0, 0, 2 ];
  var radius = 3;
  var expected = _.sphere.tools.long.make( [ 0, 0, 2, 3 ] );

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius );
  test.identical( gotSphere, expected );
  test.identical( dstSphere, expected );

  var oldcenter = [ 0, 0, 2 ];
  test.identical( center, oldcenter );
  var oldradius = 3;
  test.identical( radius, oldradius );

  /* */

  test.case = 'Create sphere of one dimension';

  var dstSphere = null;
  var center = [ 0 ];
  var radius = 1;
  var expected = _.sphere.tools.long.make( [ 0, 1 ] );

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius);
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Create sphere of two dimensions';

  var dstSphere = null;
  var center = [ 0, 1 ];
  var radius = 1;
  var expected = _.sphere.tools.long.make( [ 0, 1, 1 ] );

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Create sphere three dimensions';

  var dstSphere = null;
  var center = [ 0, 0, 0 ];
  var radius = 3;
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 3 ] );

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'sphere expanded - center moved';

  var dstSphere = [ 0, 0, 0, 2 ];
  var center = [ 0, - 5.5, 101 ];
  var radius = 6;
  var expected = _.sphere.tools.long.make( [ 0, - 5.5, 101, 6 ] );

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius);
  test.identical( gotSphere, expected );

  /* */

  test.case = 'sphere contracted';

  var dstSphere = [ 1, 1, 1, 2 ];
  var center = [ 1, 1, 1 ];
  var radius = 1;
  var expected = _.sphere.tools.long.make( [ 1, 1, 1, 1 ] );

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius);
  test.identical( gotSphere, expected );

  /* */

  test.case = 'sphere ( normalized to 1 ) expanded';

  var dstSphere = [ 0.2, - 0.1, 0.6, 0.2 ];
  var center = [ - 0.4, 0.1, 0.3 ];
  var radius = 0.5;
  var expected = _.sphere.tools.long.make( [ - 0.4, 0.1, 0.3, 0.5 ] );

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius);
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Zero sphere of four dimensions expanded';

  var dstSphere = [ 0, 0, 0, 0, 0 ];
  var center = [ 0, 1, 2, 3 ];
  var radius = 1;
  var expected = _.sphere.tools.long.make( [ 0, 1, 2, 3, 1 ] );

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius);
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Null sphere of 7 dimensions expanded';

  var dstSphere = [  0, 0, 0, 0, 0, 0, 0, 1 ];
  var center = [  0, 3, 0, - 2, 0, 3, 0 ];
  var radius = 2;
  var expected = _.sphere.tools.long.make( [ 0, 3, 0, - 2, 0, 3, 0, 2 ] );

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius);
  test.identical( gotSphere, expected );

  /* */

  test.case = 'sphere of 1 dimension expanded';

  var dstSphere = [ 0, 0 ];
  var center = [ 0 ];
  var radius = 1;
  var expected = _.sphere.tools.long.make( [ 0, 1 ] );

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius);
  test.identical( gotSphere, expected );

  /* */

  test.case = 'NaN sphere of 1 dimension expanded';

  var dstSphere = [ NaN, NaN ];
  var center = [ 0 ];
  var radius = 1;
  var expected = _.sphere.tools.long.make( [ 0, 1 ] );

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius);
  test.identical( gotSphere, expected );

  /* */

  test.case = 'sphere of 1 dimension no center - center NaN';

  var dstSphere = [ 0, 1 ];
  var center = [ NaN ];
  var radius = 1;
  var expected = _.sphere.tools.long.make( [ NaN, 1 ] );

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius);
  test.identical( gotSphere, expected );

  /* */

  test.case = 'sphere of 1 dimension not expanded - radius NaN';

  var dstSphere = [ 0, 1 ];
  var center = [ 0 ];
  var radius = NaN;
  var expected = _.sphere.tools.long.make( [ 0, NaN ] );

  var gotSphere = _.sphere.fromCenterAndRadius( dstSphere, center, radius);
  test.identical( gotSphere, expected );

  /* */

  if( !Config.debug )
  return;

  /* */

  test.case = 'No arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromCenterAndRadius();
  });

  /* */

  test.case = 'Wrong type of argument - none';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromCenterAndRadius( [ ] , [ ], [ ]  );
  });

  /* */

  test.case = 'Wrong type of argument - string';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromCenterAndRadius( 'sphere', 'center', 'radius' );
  });

  /* */

  test.case = 'Wrong type of argument - number';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromCenterAndRadius( 1, 2, 4 );
  });

  /* */

  test.case = 'Too few arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromCenterAndRadius( [ 0, 0, 0 ] );
  });

  /* */

  test.case = 'Too few arguments - no radius';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromCenterAndRadius( [ 0, 0, 0 ], [ 1, 1, 1 ] );
  });

  /* */

  test.case = 'Too few arguments - no center';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromCenterAndRadius( [ 0, 0, 0 ], 1 );
  });

  /* */

  test.case = 'too many arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromCenterAndRadius( [ 0, 0, 0 ], [ 0, 1 ], [ 2, 1 ], 3 );
  });

  /* */

  test.case = 'Wrong center dimension ( sphere 3D vs center 4D )';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromCenterAndRadius( [ 0, 0, 0, 0 ], [ 0, 1, 0, 2 ], 3 );
  });

  /* */

  test.case = 'Wrong center dimension ( sphere 3D vs center 2D )';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromCenterAndRadius( [ 0, 0, 0, 0 ], [ 2, 1 ], 2 );
  });

  /* */

  test.case = 'Wrong center dimension ( sphere 2D vs center 1D )';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromCenterAndRadius( [ 0, 0, 0 ], [ 1 ], 1 );
  });

  /* */

  test.case = 'Wrong radius dimension';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.fromCenterAndRadius( [ 0, 0, 0 ], [ 1, 1 ], [1, 0] );
  });

}

//

function is( test )
{

  var s =
`
  test.true( _.sphere.is([ 0 ]) );
  test.true( _.sphere.is([ 0, 0 ]) );
  test.true( _.sphere.is([ 0, 0, 0 ]) );
  test.true( _.sphere.is([ 0, 0, 0, 0 ]) );
`

  console.log( s );

  /* */

  test.case = 'array';

  test.true( _.sphere.is([ 0 ]) );
  test.true( _.sphere.is([ 0, 0 ]) );
  test.true( _.sphere.is([ 0, 0, 0 ]) );
  test.true( _.sphere.is([ 0, 0, 0, 0 ]) );

  /* */

  test.case = 'vector';

  test.true( _.sphere.is( _.vectorAdapter.fromLong([ 0 ]) ) );
  test.true( _.sphere.is( _.vectorAdapter.fromLong([ 0, 0 ]) ) );
  test.true( _.sphere.is( _.vectorAdapter.fromLong([ 0, 0, 0 ]) ) );
  test.true( _.sphere.is( _.vectorAdapter.fromLong([ 0, 0, 0, 0 ]) ) );

  /* */

  test.case = 'not sphere';

  test.true( !_.sphere.is( [] ) );
  test.true( !_.sphere.is( _.vectorAdapter.fromLong([]) ) );
  test.true( !_.sphere.is( 'abc' ) );
  test.true( !_.sphere.is( { center : [ 0, 0, 0 ], radius : 1 } ) );
  test.true( !_.sphere.is( function( a, b, c ){} ) );

}

//

function isEmpty( test )
{

  debugger;

  /* */

  test.case = 'empty';

  test.true( _.sphere.isEmpty([ 0 ]) );
  test.true( _.sphere.isEmpty([ 0, 0 ]) );
  test.true( _.sphere.isEmpty([ 0, 0, 0 ]) );
  test.true( _.sphere.isEmpty([ 0, 0, 0, 0 ]) );

  test.true( _.sphere.isEmpty([ 0 ]) );
  test.true( _.sphere.isEmpty([ 1, 0 ]) );
  test.true( _.sphere.isEmpty([ 1, 0, 0 ]) );
  test.true( _.sphere.isEmpty([ 1, 0, 0, 0 ]) );

  test.true( _.sphere.isEmpty([ -1 ]) );
  test.true( _.sphere.isEmpty([ 0, -1 ]) );
  test.true( _.sphere.isEmpty([ 0, 0, -1 ]) );
  test.true( _.sphere.isEmpty([ 0, 0, 0, -1 ]) );

  test.true( _.sphere.isEmpty([ -Infinity ]) );
  test.true( _.sphere.isEmpty([ 0, -Infinity ]) );
  test.true( _.sphere.isEmpty([ 0, 0, -Infinity ]) );
  test.true( _.sphere.isEmpty([ 0, 0, 0, -Infinity ]) );

  test.true( _.sphere.isEmpty([ 0.1, -Infinity ]) );
  test.true( _.sphere.isEmpty([ 0, 0.1, -Infinity ]) );
  test.true( _.sphere.isEmpty([ 0, 0, 0.1, -Infinity ]) );

  /* */

  test.case = 'not empty';

  test.true( !_.sphere.isEmpty([ 1 ]) );
  test.true( !_.sphere.isEmpty([ 0, 1 ]) );
  test.true( !_.sphere.isEmpty([ 0, 0, 1 ]) );
  test.true( !_.sphere.isEmpty([ 0, 0, 0, 1 ]) );

  test.true( !_.sphere.isEmpty([ Infinity ]) );
  test.true( !_.sphere.isEmpty([ 0, Infinity ]) );
  test.true( !_.sphere.isEmpty([ 0, 0, Infinity ]) );
  test.true( !_.sphere.isEmpty([ 0, 0, 0, Infinity ]) );

}

//

function isZero( test )
{

  /* */

  test.case = 'zero';

  test.true( _.sphere.isZero([ 0 ]) );
  test.true( _.sphere.isZero([ 0, 0 ]) );
  test.true( _.sphere.isZero([ 0, 0, 0 ]) );
  test.true( _.sphere.isZero([ 0, 0, 0, 0 ]) );

  test.true( _.sphere.isZero([ 0 ]) );
  test.true( _.sphere.isZero([ 1, 0 ]) );
  test.true( _.sphere.isZero([ 1, 0, 0 ]) );
  test.true( _.sphere.isZero([ 1, 0, 0, 0 ]) );

  /* */

  test.case = 'not zero';

  test.true( !_.sphere.isZero([ 1 ]) );
  test.true( !_.sphere.isZero([ 0, 1 ]) );
  test.true( !_.sphere.isZero([ 0, 0, 1 ]) );
  test.true( !_.sphere.isZero([ 0, 0, 0, 1 ]) );

  test.true( !_.sphere.isZero([ -1 ]) );
  test.true( !_.sphere.isZero([ 0, -1 ]) );
  test.true( !_.sphere.isZero([ 0, 0, -1 ]) );
  test.true( !_.sphere.isZero([ 0, 0, 0, -1 ]) );

  test.true( !_.sphere.isZero([ -Infinity ]) );
  test.true( !_.sphere.isZero([ 0, -Infinity ]) );
  test.true( !_.sphere.isZero([ 0, 0, -Infinity ]) );
  test.true( !_.sphere.isZero([ 0, 0, 0, -Infinity ]) );

  test.true( !_.sphere.isZero([ Infinity ]) );
  test.true( !_.sphere.isZero([ 0, Infinity ]) );
  test.true( !_.sphere.isZero([ 0, 0, Infinity ]) );
  test.true( !_.sphere.isZero([ 0, 0, 0, Infinity ]) );

  test.true( !_.sphere.isZero([ 0.1, -Infinity ]) );
  test.true( !_.sphere.isZero([ 0, 0.1, -Infinity ]) );
  test.true( !_.sphere.isZero([ 0, 0, 0.1, -Infinity ]) );

}

//

function isNil( test )
{

  /* */

  test.case = 'nil';

  test.true( _.sphere.isNil([ -Infinity ]) );
  test.true( _.sphere.isNil([ 0, -Infinity ]) );
  test.true( _.sphere.isNil([ 0, 0, -Infinity ]) );
  test.true( _.sphere.isNil([ 0, 0, 0, -Infinity ]) );

  /* */

  test.case = 'not nil';

  test.true( !_.sphere.isNil([ Infinity ]) );
  test.true( !_.sphere.isNil([ 0, Infinity ]) );
  test.true( !_.sphere.isNil([ 0, 0, Infinity ]) );
  test.true( !_.sphere.isNil([ 0, 0, 0, Infinity ]) );

  test.true( !_.sphere.isNil([ 0.1, -Infinity ]) );
  test.true( !_.sphere.isNil([ 0, 0.1, -Infinity ]) );
  test.true( !_.sphere.isNil([ 0, 0, 0.1, -Infinity ]) );

}

//

function dimGet( test )
{

  /* */

  test.case = 'Source sphere remains unchanged';

  var srcSphere = [ 0, 0, 1, 1 ];
  var oldSrcSphere = srcSphere.slice();
  var expected = 3;

  var gotDim = _.sphere.dimGet( srcSphere );
  test.identical( gotDim, expected );
  test.identical( srcSphere, oldSrcSphere );

  /* */

  test.case = 'Nil sphere sphere';

  var sphere = [ 1, 1, 1, -Infinity ];
  var expected = 3;

  var gotDim = _.sphere.dimGet( sphere );
  test.identical( gotDim, expected );

  /* */

  test.case = 'Zero dimension sphere';

  var sphere = [ 1 ];
  var expected = 0;

  var gotDim = _.sphere.dimGet( sphere );
  test.identical( gotDim, expected );

  /* */

  test.case = 'One dimension sphere';

  var sphere = [ 0, 0 ];
  var expected = 1;

  var gotDim = _.sphere.dimGet( sphere );
  test.identical( gotDim, expected );

  /* */

  test.case = 'Two dimension sphere';

  var sphere = [ 0, - 1, 1.5 ];
  var expected = 2;

  var gotDim = _.sphere.dimGet( sphere );
  test.identical( gotDim, expected );

  /* */

  test.case = 'Three dimension sphere';

  var sphere = [ - 1, 0, 1.2, 2 ];
  var expected = 3;

  var gotDim = _.sphere.dimGet( sphere );
  test.identical( gotDim, expected );

  /* */

  test.case = 'Four dimension sphere';

  var sphere = [ - 1, - 2.2, 1, 2, 5.4 ];
  var expected = 4;

  var gotDim = _.sphere.dimGet( sphere );
  test.identical( gotDim, expected );

  /* */

  test.case = 'Eight dimension sphere';

  var sphere = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4, - 1.1 ];
  var expected = 8;

  var gotDim = _.sphere.dimGet( sphere );
  test.identical( gotDim, expected );


  /* */

  test.case = 'NaN';

  var sphere = [ 'Hi', 'world' ];
  var expected = 1;

  var gotDim = _.sphere.dimGet( sphere );
  test.identical( gotDim, expected );

  /* */

  test.case = 'NaN';

  var sphere = [ 'Hi', 'world', null, null, NaN, NaN ];
  var expected = 5;

  var gotDim = _.sphere.dimGet( sphere );
  test.identical( gotDim, expected );

  /* */

  if( !Config.debug )
  return;

  /* */

  test.case = 'No arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.dimGet();
  });

  /* */

  test.case = 'Wrong Sphere dimension';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.dimGet( [] );
  });

  /* */

  test.case = 'Wrong type of argument';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.dimGet( 'Hi' );
  });

  /* */

  test.case = 'Wrong type of argument';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.dimGet( null );
  });

  /* */

  test.case = 'Wrong type of argument';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.dimGet( 3 );
  });

  /* */

  test.case = 'To many arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.dimGet( [ 0, 1 ], [ 0, 1 ] );
  });

}

//

function centerGet( test )
{

  /* */

  test.case = 'Source sphere remains unchanged';

  var srcSphere = [ 0, 0, 1, 1 ];
  var oldSrcSphere = srcSphere.slice();
  var expected = _.sphere.tools.long.make( [ 0, 0, 1 ] );
  expected = _.vectorAdapter.from(expected);

  var gotCenter = _.sphere.centerGet( srcSphere );

  test.equivalent( srcSphere, oldSrcSphere );
  test.identical( gotCenter, expected );

  /* */

  test.case = 'Zero dimension sphere';

  var sphere = [ 0 ];
  var expected = _.sphere.tools.long.make( [ ] );
  expected = _.vectorAdapter.from(expected);

  var gotCenter = _.sphere.centerGet( sphere );
  test.identical( gotCenter, expected );

  /* */

  test.case = 'One dimension sphere';

  var sphere = [ 0, 0 ];
  var expected = [ 0 ];
  expected = _.vectorAdapter.from(expected);

  var gotCenter = _.sphere.centerGet( sphere );
  test.identical( gotCenter, expected );

  /* */

  test.case = 'Two dimension sphere';

  var sphere = [ 0, 0, 2 ];
  var expected = _.sphere.tools.long.make( [ 0, 0 ] );
  expected = _.vectorAdapter.from(expected);

  var gotCenter = _.sphere.centerGet( sphere );
  test.identical( gotCenter, expected );

  /* */

  test.case = 'Three dimension sphere';

  var sphere = [ 0, - 1, - 2, 2 ];
  var expected = _.sphere.tools.long.make( [ 0, - 1, - 2 ] );
  expected = _.vectorAdapter.from(expected);

  var gotCenter = _.sphere.centerGet( sphere );
  test.identical( gotCenter, expected );

  /* */

  test.case = 'Four dimension sphere';

  var sphere = [ 0, - 1, - 2, 2, 0 ];
  var expected = _.sphere.tools.long.make( [ 0, - 1, - 2, 2 ] );
  expected = _.vectorAdapter.from(expected);

  var gotCenter = _.sphere.centerGet( sphere );
  test.identical( gotCenter, expected );

  /* */

  test.case = 'Eight dimension sphere';

  var sphere = [  0, - 1, - 2, 2, 0, 1, 2, 6, - 1 ];
  var expected = _.sphere.tools.long.make( [ 0, - 1, -2, 2, 0, 1, 2, 6 ] );
  expected = _.vectorAdapter.from(expected);

  var gotCenter = _.sphere.centerGet( sphere );
  test.identical( gotCenter, expected );

  /* */

  test.case = 'normalized sphere';

  var sphere = [ 0.624, 0.376, 0.52 ];
  var expected = _.sphere.tools.long.make( [ 0.624, 0.376 ] );
  expected = _.vectorAdapter.from(expected);

  var gotCenter = _.sphere.centerGet( sphere );
  test.identical( gotCenter, expected );

  /* */

  test.case = 'negative radius';

  var sphere = [ 1, 2, - 3 ];
  var expected = _.sphere.tools.long.make( [ 1, 2 ] );
  expected = _.vectorAdapter.from(expected);

  var gotCenter = _.sphere.centerGet( sphere );
  test.identical( gotCenter, expected );


  /* */

  test.case = 'NaN radius';

  var sphere = [ 1, 2, NaN ];
  var expected = _.sphere.tools.long.make( [ 1, 2 ] );
  expected = _.vectorAdapter.from(expected);

  var gotCenter = _.sphere.centerGet( sphere );
  test.identical( gotCenter, expected );

  /* */

  test.case = 'NaN sphere';

  var sphere = [ NaN, NaN, NaN ];
  var expected = _.sphere.tools.long.make( [ NaN, NaN ] );
  expected = _.vectorAdapter.from(expected);

  var gotCenter = _.sphere.centerGet( sphere );
  test.identical( gotCenter, expected );

  /* */

  if( !Config.debug )
  return;

  /* */

  test.case = 'No arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.centerGet();
  });

  /* */

  test.case = 'Too many arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.centerGet( [ 0, 0, 1, 1 ], [ 0, 0, 0, 0 ] );
  });

  /* */

  test.case = 'Wrong type of arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.centerGet( null );
  });

  /* */

  test.case = 'Wrong type of arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.centerGet( 'string' );
  });

  /* */

  test.case = 'Wrong type of arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.centerGet( 4 );
  });

  /* */

  test.case = 'Wrong sphere dimension';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.centerGet( [ ] );
  });

}

//

function radiusGet( test )
{

  /* */

  test.case = 'Source sphere remains unchanged';

  var srcSphere = [ 0, 0, 1, 1 ];
  var oldSrcSphere = srcSphere.slice();
  var expected =  1 ;
  // expected = _.vectorAdapter.from(expected);

  var gotRadius = _.sphere.radiusGet( srcSphere );

  test.equivalent( srcSphere, oldSrcSphere );
  test.identical( gotRadius, expected );

  /* */

  test.case = 'Zero dimension sphere';

  var sphere = [ 0 ];
  var expected = 0;

  var gotRadius = _.sphere.radiusGet( sphere );
  test.identical( gotRadius, expected );

  /* */

  test.case = 'One dimension sphere';

  var sphere = [ 0, 0 ];
  var expected =  0 ;

  var gotRadius = _.sphere.radiusGet( sphere );
  test.identical( gotRadius, expected );

  /* */

  test.case = 'Two dimension sphere';

  var sphere = [ 0, 0, 2 ];
  var expected = 2;

  var gotRadius = _.sphere.radiusGet( sphere );
  test.identical( gotRadius, expected );

  /* */

  test.case = 'Three dimension sphere';

  var sphere = [ 0, - 1, - 2, 2 ];
  var expected = 2;

  var gotRadius = _.sphere.radiusGet( sphere );
  test.identical( gotRadius, expected );

  /* */

  test.case = 'Four dimension sphere';

  var sphere = [ 0, - 1, - 2, 2, 0 ];
  var expected =  0;

  var gotRadius = _.sphere.radiusGet( sphere );
  test.identical( gotRadius, expected );

  /* */

  test.case = 'Eight dimension sphere';

  var sphere = [  0, - 1, - 2, 2, 0, 1, 2, 6, 1 ];
  var expected = 1;

  var gotRadius = _.sphere.radiusGet( sphere );
  test.identical( gotRadius, expected );

  /* */

  test.case = 'normalized sphere';

  var sphere = [ 0.624, 0.376, 0.52 ];
  var expected = 0.52;

  var gotRadius = _.sphere.radiusGet( sphere );
  test.identical( gotRadius, expected );

  /* */

  test.case = 'negative radius';

  var sphere = [ 1, 2, - 3 ];
  var expected = -3;

  var gotRadius = _.sphere.radiusGet( sphere );
  test.identical( gotRadius, expected );


  /* */

  test.case = 'NaN radius';

  var sphere = [ 1, 2, NaN ];
  var expected = NaN;

  var gotRadius = _.sphere.radiusGet( sphere );
  test.identical( gotRadius, expected );

  /* */

  test.case = 'NaN sphere';

  var sphere = [ NaN, NaN, NaN ];
  var expected = NaN;

  var gotRadius = _.sphere.radiusGet( sphere );
  test.identical( gotRadius, expected );

  /* */

  test.case = 'radiusGet+Set two dimensions';

  var sphere = [ 0, 1, 1 ];
  var radiusOld = 1;
  var radiusSph = _.sphere.radiusGet( sphere );
  test.equivalent( radiusSph, radiusOld );

  var radius = 2;
  var expected = _.sphere.tools.long.make( [ 0, 1, 2 ] );
  expected = _.vectorAdapter.from(expected);
  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  var radiusSph = _.sphere.radiusGet( sphere );
  test.equivalent( radius, radiusSph );

  /* */

  test.case = 'radiusGet+Set three dimensions';

  var sphere = [ 0, 0, 1, 1 ];
  var radiusOld = 1;
  var radiusSph = _.sphere.radiusGet( sphere );
  test.equivalent( radiusOld, radiusSph );

  var radius = 2;
  var expected = _.sphere.tools.long.make( [ 0, 0, 1, 2 ] );
  expected = _.vectorAdapter.from(expected);
  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.equivalent( gotSphere, expected );

  var radiusSph = _.sphere.radiusGet( gotSphere );
  test.equivalent( radius, radiusSph );

  /* */

  test.case = 'NaN sphere';

  var sphere = [ NaN, NaN, NaN ];
  var expected = NaN;

  var gotSphere = _.sphere.radiusGet( sphere );
  test.equivalent( gotSphere, expected );

  /* */

  if( !Config.debug )
  return;

  /* */

  test.case = 'No arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.radiusGet();
  });

  /* */

  test.case = 'Too many arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.radiusGet( [ 0, 0, 1, 1 ], [ 0, 0, 0, 0 ] );
  });

  /* */

  test.case = 'Wrong type of arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.radiusGet( null );
  });

  /* */

  test.case = 'Wrong type of arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.radiusGet( 'string' );
  });

  /* */

  test.case = 'Wrong type of arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.radiusGet( 4 );
  });

  /* */

  test.case = 'Wrong sphere dimension';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.radiusGet( [ ] );
  });

}

//

function radiusSet( test )
{

  /* */

  test.case = 'Source radius remains unchanged';

  var sphere = [ 0, 0, 1, 1 ];
  var srcRadius = 2;
  var expected =  [ 0, 0, 1, 2 ] ;
  expected = _.vectorAdapter.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, srcRadius );
  test.identical( gotSphere, expected );

  var oldSrcRadius = 2;
  test.equivalent( srcRadius, oldSrcRadius );

  /* */

  test.case = 'Zero dimension sphere';

  var sphere = [ 0 ];
  var radius = 1;
  var expected = [ 1 ];
  expected = _.vectorAdapter.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'One dimension sphere';

  var sphere = [ 0, 0 ];
  var radius = 2;
  var expected = [ 0, 2 ] ;
  expected = _.vectorAdapter.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Two dimension sphere';

  var sphere = [ 0, 0, 2 ];
  var radius = 3;
  var expected = _.sphere.tools.long.make( [ 0, 0, 3 ] );
  expected = _.vectorAdapter.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Three dimension sphere';

  var sphere = [ 0, - 1, - 2, 2 ];
  var radius = 4;
  var expected = _.sphere.tools.long.make( [ 0, - 1, - 2, 4 ] );
  expected = _.vectorAdapter.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Four dimension sphere';

  var sphere = [ 0, - 1, - 2, 2, 0 ];
  var radius = 5;
  var expected = _.sphere.tools.long.make( [ 0, - 1, - 2, 2, 5 ] );
  expected = _.vectorAdapter.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Eight dimension sphere';

  var sphere = [  0, - 1, - 2, 2, 0, 1, 2, 6, 1 ];
  var radius = 2;
  var expected = _.sphere.tools.long.make( [  0, - 1, - 2, 2, 0, 1, 2, 6, 2 ] );
  expected = _.vectorAdapter.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'normalized sphere';

  var sphere = [ 0.624, 0.376, 0.52 ];
  var radius = 0.777;
  var expected = _.sphere.tools.long.make( [ 0.624, 0.376, 0.777 ] );
  expected = _.vectorAdapter.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'negative radius';

  var sphere = [ 1, 2, - 3 ];
  var radius = - 2;
  var expected = _.sphere.tools.long.make( [ 1, 2, - 2 ] );
  expected = _.vectorAdapter.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'NaN radius';

  var sphere = [ 1, 2, 3 ];
  var radius = NaN;
  var expected = _.sphere.tools.long.make( [ 1, 2, NaN ] );
  expected = _.vectorAdapter.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'NaN sphere';

  var sphere = [ NaN, NaN, NaN ];
  var radius = 2;
  var expected = _.sphere.tools.long.make( [ NaN, NaN, 2 ] );
  expected = _.vectorAdapter.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'radiusSet+Get two dimensions';

  var sphere = [ 0, 2, 3 ];
  var radiusOld = 3;
  var radiusSph = _.sphere.radiusGet( sphere );
  test.equivalent( radiusOld, radiusSph );

  var radius = 2;
  var expected = _.sphere.tools.long.make( [ 0, 2, 2 ] );
  expected = _.vectorAdapter.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  var radiusSph = _.sphere.radiusGet( sphere );
  test.equivalent( radius, radiusSph );

  /* */

  test.case = 'radiusSet+Get three dimensions';

  var sphere = [ 0, 1, 1, 3 ];
  var radiusOld = 3;
  var radiusSph = _.sphere.radiusGet( sphere );
  test.equivalent( radiusOld, radiusSph );

  var radius = 2;
  var expected = _.sphere.tools.long.make( [ 0, 1, 1, 2 ] );
  expected = _.vectorAdapter.from(expected);

  var gotSphere = _.sphere.radiusSet( sphere, radius );
  test.identical( gotSphere, expected );

  var radiusSph = _.sphere.radiusGet( sphere );
  test.equivalent( radius, radiusSph );

  /* */

  if( !Config.debug )
  return;

  /* */

  test.case = 'No arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.radiusSet();
  });

  /* */

  test.case = 'Too many arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.radiusSet( [ 0, 0, 1, 1 ], 2, 3 );
  });

  /* */

  test.case = 'Wrong type of arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.radiusSet( [ 0, 0, 1, 1 ], [ 0, 0, 0, 0 ] );
  });

  /* */

  test.case = 'Wrong type of arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.radiusSet( null, null );
  });

  /* */

  test.case = 'Wrong type of arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.radiusSet( 'string', 'Hi' );
  });

  /* */

  test.case = 'Wrong type of arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.radiusSet( 4, 3 );
  });

  /* */

  test.case = 'Wrong sphere dimension';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sphere.radiusSet( [ ], 2 );
  });

}

//

function project( test )
{

  /* */

  test.case = 'Projection array remains unchanged and Destination sphere changes';

  var dstSphere = [ 0.5, 0.5, 1 ];
  var project = [ [ 1, 1 ], 2 ];
  var expected = _.sphere.tools.long.make( [ 1.5, 1.5, 2 ] );

  var gotSphere = _.sphere.project( dstSphere, project );
  test.identical( gotSphere, expected );
  test.identical( dstSphere, expected );

  var oldProject = [ [ 1, 1 ], 2 ];
  test.identical( project, oldProject );

  var oldSphere = [ 0.5, 0.5, 1 ];
  test.true( oldSphere !== gotSphere );

  /* */

  test.case = 'Null sphere projected';

  var sphere = null;
  var project = [ [ 1, 0, 0 ], 2 ];
  var expected = _.sphere.tools.long.make( [ 1, 0, 0, 0 ] );

  var gotSphere = _.sphere.project( sphere, project );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Null sphere NOT projected';

  var sphere = null;
  var project = [ [ 0, 0, 0 ], 0 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 0 ] );

  var gotSphere = _.sphere.project( sphere, project );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Sphere projected';

  var sphere = [ 0.5, 0, 0, 2 ];
  var project = [ [ 0, 1, 0 ], 3 ];
  var expected = _.sphere.tools.long.make( [ 0.5, 1, 0, 6 ] );

  var gotSphere = _.sphere.project( sphere, project );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Sphere expanded';

  var sphere = [ 0, 2, 2, 1 ];
  var project = [ [ 0, 0, 0 ], 2 ];
  var expected = _.sphere.tools.long.make( [ 0, 2, 2, 2 ] );

  var gotSphere = _.sphere.project( sphere, project );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Sphere contracted';

  var sphere = [ 0, 2, 2, 1 ];
  var project = [ [ 0, 0, 0 ], 0.5 ];
  var expected = _.sphere.tools.long.make( [ 0, 2, 2, 0.5 ] );

  var gotSphere = _.sphere.project( sphere, project );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Sphere translated';

  var sphere = [ 0, 2, 2, 1 ];
  var project = [ [ 1, 2, 3 ], 1 ];
  var expected = _.sphere.tools.long.make( [ 1, 4, 5, 1 ] );

  var gotSphere = _.sphere.project( sphere, project );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Sphere reduced to a point';

  var sphere = [ 0, 2, 2, 2 ];
  var project = [ [ 1, 2, 3 ], 0 ];
  var expected = _.sphere.tools.long.make( [ 1, 4, 5, 0 ] );

  var gotSphere = _.sphere.project( sphere, project );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Sphere NOT projected ( empty project array )';

  var sphere = [ 0, 2, 2, 3 ];
  var project = [ [ 0, 0, 0 ], 1 ];
  var expected = _.sphere.tools.long.make( [ 0, 2, 2, 3 ] );

  var gotSphere = _.sphere.project( sphere, project );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Sphere of four dimensions projected';

  var sphere = [ -0.5, -0.5, 0.5, 0.5, 1 ];
  var project = [ [ 0, 0, 0, 0 ], 4 ];
  var expected = _.sphere.tools.long.make( [ -0.5, -0.5, 0.5, 0.5, 4 ] );

  var gotSphere = _.sphere.project( sphere, project );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Sphere of 1 dimension projected';

  var sphere = [ 0, 1 ];
  var project = [ [ 1 ], 2 ];
  var expected = _.sphere.tools.long.make( [ 1, 2 ] );

  var gotSphere = _.sphere.project( sphere, project );
  test.identical( gotSphere, expected );

  /* */

  if( !Config.debug )
  return;

  /* */

  test.case = 'No arguments';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.project();
  });

  /* */

  test.case = 'Wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.project( 'sphere', 'project' );
  });

  /* */

  test.case = 'Too few arguments';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.project( [ 0, 0, 0, 0 ] );
  });

  /* */

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.project( [ 0, 0, 0 ], [ [ 0, 0 ], 1 ], [ [ 1, 1 ], 0 ] );
  });

  /* */

  test.case = 'Wrong project array dimension (sphere 3D vs array 4D)';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.project( [ 0, 0, 0, 0 ], [ [ 1, 1, 1, 1 ], 1 ] );
  });

  /* */

  test.case = 'Wrong project array dimension (sphere 3D vs array 2D)';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.project( [ 0, 0, 0, 0 ], [ [ 0, 1 ], 2 ] );
  });

  /* */

  test.case = 'Wrong project array dimension (sphere 2D vs array 1D)';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.project( [ 0, 0, 0 ], [ [ 0 ], 2 ] );
  });

  /* */

  test.case = 'Wrong project array dimension (null sphere vs array 2D)';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.project( null, [ [ 0, 1 ], 1 ] );
  });

  /* */

  test.case = 'Wrong project array dimension (project has less than 2 entries)';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.project( [ 0, 0, 0, 0 ], [ [ 0, 1, 0 ] ] );
  });

  /* */

  test.case = 'Wrong project array dimension (project has more than 2 entries)';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.project( [ 0, 0, 0, 0 ], [ [ 0, 1, 0 ], 1, 2 ] );
  });

  /* */

  test.case = 'Empty arrays';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.project( [ ], [ [  ],  ] );
  });

}

//

function getProjectionFactors( test )
{

  /* */

  test.case = 'Spheres remain unchanged';

  var dstSphere = [ 0, 0, 1, 1 ];
  var projSphere = [ 0.5, 0.5, 1.5, 2 ];
  var expected = _.sphere.tools.long.make( [ [ 0.5, 0.5, 0.5 ], 2 ] );

  var gotFactors = _.sphere.getProjectionFactors( dstSphere, projSphere );
  test.identical( gotFactors, expected );

  var oldSphere = [ 0, 0, 1, 1 ];
  test.identical( oldSphere, dstSphere );

  var oldProjSphere = [ 0.5, 0.5, 1.5, 2 ];
  test.identical( oldProjSphere, projSphere );

  /* */

  test.case = 'Sphere projected';

  var dstSphere = [ 1, 0, 0, 2 ];
  var projSphere = [ -0.5, 1, 0, 6 ];
  var expected = _.sphere.tools.long.make( [ [ -1.5, 1, 0 ], 3 ] );

  var gotFactors = _.sphere.getProjectionFactors( dstSphere, projSphere );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Sphere expanded';

  var dstSphere = [ 2, 2, 2, 1 ];
  var projSphere = [ 2, 2, 2, 2 ];
  var expected = _.sphere.tools.long.make( [ [ 0, 0, 0 ], 2 ] );

  var gotFactors = _.sphere.getProjectionFactors( dstSphere, projSphere );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Sphere contracted';

  var dstSphere = [ 2, 2, 2, 1 ];
  var projSphere = [ 2, 2, 2, 0.5 ];
  var expected = _.sphere.tools.long.make( [ [ 0, 0, 0 ], 0.5 ] );

  var gotFactors = _.sphere.getProjectionFactors( dstSphere, projSphere );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Sphere translated';

  var dstSphere = [ 0, 2, 2, 1 ];
  var projSphere = [ 1, 4, 5, 1 ];
  var expected = _.sphere.tools.long.make( [ [ 1, 2, 3 ], 1 ] );

  var gotFactors = _.sphere.getProjectionFactors( dstSphere, projSphere );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Sphere reduced to point';

  var dstSphere = [ 2, 2, 2, 1 ];
  var projSphere = [ 3, 4, 5, 0 ];
  var expected = _.sphere.tools.long.make( [ [ 1, 2, 3 ], 0 ] );

  var gotFactors = _.sphere.getProjectionFactors( dstSphere, projSphere );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Sphere reduced';

  var dstSphere = [ 0, 0, 0, 4 ];
  var projSphere = [ 2, 3, 4, 1 ];
  var expected = _.sphere.tools.long.make( [ [ 2, 3, 4 ], 0.25 ] );

  var gotFactors = _.sphere.getProjectionFactors( dstSphere, projSphere );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Sphere NOT projected ( empty project array )';

  var dstSphere = [ 2, 2, 2, 3 ];
  var projSphere = [ 2, 2, 2, 3 ];
  var expected = _.sphere.tools.long.make( [ [ 0, 0, 0 ], 1 ] );

  var gotFactors = _.sphere.getProjectionFactors( dstSphere, projSphere );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Sphere of four dimensions projected';

  var dstSphere = [ -0.5, -0.5, 0.5, 0.5, 1 ];
  var projSphere = [ - 1, - 1, 1, 1, 4 ];
  var expected = _.sphere.tools.long.make( [ [ -0.5, -0.5, 0.5, 0.5 ], 4 ] );

  var gotFactors = _.sphere.getProjectionFactors( dstSphere, projSphere );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Sphere of 1 dimension projected';

  var dstSphere = [ 0, 1 ];
  var projSphere = [ 1, 1 ];
  var expected = _.sphere.tools.long.make( [ [ 1 ], 1 ] );

  var gotFactors = _.sphere.getProjectionFactors( dstSphere, projSphere );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Point to point';

  var dstSphere = [ 3, 4, 0 ];
  var projSphere = [ 5, 5, 0 ];
  var expected = _.sphere.tools.long.make( [ [ 2, 1 ], 1 ] );

  var gotFactors = _.sphere.getProjectionFactors( dstSphere, projSphere );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Point to sphere';

  var dstSphere = [ 3, 4, 0 ];
  var projSphere = [ 5, 5, 7 ];
  var expected = 0;

  var gotFactors = _.sphere.getProjectionFactors( dstSphere, projSphere );
  test.identical( gotFactors, expected );

  /* */

  test.case = 'Sphere to sphere';

  var dstSphere = [ 3, 4, 3, 1 ];
  var projSphere = [ 5, 5, 7, 2 ];
  var expected = _.sphere.tools.long.make( [ [ 2, 1, 4 ], 2 ] );;

  var gotFactors = _.sphere.getProjectionFactors( dstSphere, projSphere );
  test.identical( gotFactors, expected );

  // Test cases including _.sphere.project()

  /* */

  test.case = 'Two equal spheres';

  var dstSphere = [ 0, 0, 1, 1, 1 ];
  var projSphere = [ 0, 0, 1, 1, 1 ];
  var expected = _.sphere.tools.long.make( [ [ 0, 0, 0, 0 ], 1 ] );

  var gotFactors = _.sphere.getProjectionFactors( dstSphere, projSphere );
  test.identical( gotFactors, expected );

  var gotSphere = _.sphere.project( dstSphere, gotFactors );
  test.identical( gotSphere, projSphere );

  /* */

  test.case = 'Two equal point spheres';

  var dstSphere = [ 3, 4, 0 ];
  var projSphere = [ 3, 4, 0 ];
  var expected = _.sphere.tools.long.make( [ [ 0, 0 ], 1 ] );

  var gotFactors = _.sphere.getProjectionFactors( dstSphere, projSphere );
  test.identical( gotFactors, expected );

  var gotSphere = _.sphere.project( dstSphere, gotFactors );
  test.identical( gotSphere, projSphere );

  /* */

  test.case = 'Point to point';

  var dstSphere = [ 3, 4, 0 ];
  var projSphere = [ 5, 5, 0 ];
  var expected = _.sphere.tools.long.make( [ [ 2, 1 ], 1 ] );

  var gotFactors = _.sphere.getProjectionFactors( dstSphere, projSphere );
  test.identical( gotFactors, expected );

  var gotSphere = _.sphere.project( dstSphere, gotFactors );
  test.identical( gotSphere, projSphere );

  /* */

  test.case = 'Sphere to point';

  var dstSphere = [ 3, 4, 6, 1 ];
  var projSphere = [ 5, 5, 5, 0 ];
  var expected = _.sphere.tools.long.make( [ [ 2, 1, -1 ], 0 ] );

  var gotFactors = _.sphere.getProjectionFactors( dstSphere, projSphere );
  test.identical( gotFactors, expected );

  var gotSphere = _.sphere.project( dstSphere, gotFactors );
  test.identical( gotSphere, projSphere );

  /* */

  test.case = 'Sphere translated';

  var dstSphere = [ 3, 4, 6, 2 ];
  var projSphere = [ -1, 8, 2, 2 ];
  var expected = _.sphere.tools.long.make( [ [ -4, 4, -4 ], 1 ] );

  var gotFactors = _.sphere.getProjectionFactors( dstSphere, projSphere );
  test.identical( gotFactors, expected );

  var gotSphere = _.sphere.project( dstSphere, gotFactors );
  test.identical( gotSphere, projSphere );

  /* */

  test.case = 'Sphere contracted';

  var dstSphere = [ 0, 0, 4, 2 ];
  var projSphere = [ 0, 0, 4, 1 ];
  var expected = _.sphere.tools.long.make( [ [ 0, 0, 0 ], 0.5 ] );

  var gotFactors = _.sphere.getProjectionFactors( dstSphere, projSphere );
  test.identical( gotFactors, expected );

  var gotSphere = _.sphere.project( dstSphere, gotFactors );
  test.identical( gotSphere, projSphere );

  /* */

  test.case = 'Sphere expanded';

  var dstSphere = [ 0, 0, 4, 1 ];
  var projSphere = [ 0, 0, 4, 3/2 ];
  var expected = _.sphere.tools.long.make( [ [ 0, 0, 0 ], 3/2 ] );

  var gotFactors = _.sphere.getProjectionFactors( dstSphere, projSphere );
  test.equivalent( gotFactors, expected );

  var gotSphere = _.sphere.project( dstSphere, gotFactors );
  test.equivalent( gotSphere, projSphere );

  /* */

  test.case = 'Sphere projected';

  var dstSphere = [ 0, 0, 4, 2 ];
  var projSphere = [ -7, -3, 9, 4 ];
  var expected = _.sphere.tools.long.make( [ [ -7, -3, 5 ], 2 ] );

  var gotFactors = _.sphere.getProjectionFactors( dstSphere, projSphere );
  test.identical( gotFactors, expected );

  var gotSphere = _.sphere.project( dstSphere, gotFactors );
  test.identical( gotSphere, projSphere );

  /* */

  if( !Config.debug )
  return;

  /* */

  test.case = 'No arguments';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.getProjectionFactors();
  });

  /* */

  test.case = 'Wrong type of argument - string';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.getProjectionFactors( 'sphere', 'projSphere' );
  });

  /* */

  test.case = 'Wrong type of argument - null';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.getProjectionFactors( null, [ 0, 1, 2, 3, 1 ] );
  });

  /* */

  test.case = 'Wrong type of argument - null';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.getProjectionFactors( [ 0, 1, 2, 3, 1 ], null );
  });

  /* */

  test.case = 'Wrong type of argument - undefined';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.getProjectionFactors( undefined, [ 0, 1, 2, 3, 1 ] );
  });

  /* */

  test.case = 'Wrong type of argument - undefined';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.getProjectionFactors( [ 0, 1, 2, 3, 1 ], undefined );
  });

  /* */

  test.case = 'Empty arguments';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.getProjectionFactors( [], [] );
  });

  /* */

  test.case = 'Too few arguments';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.getProjectionFactors( [ 0, 0, 0, 0, 0, 0, 0 ] );
  });

  /* */

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.getProjectionFactors( [ 0, 0, 1 ], [ 1, 0, 1 ], [ 0, 1, 1 ] );
  });

  /* */

  test.case = 'Wrong project array dimension (sphere 3D vs sphere 4D)';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.getProjectionFactors( [ 0, 0, 0, 1 ], [ 1, 1, 1, 1, 0 ] );
  });

  /* */

  test.case = 'Wrong project array dimension (sphere 3D vs sphere 2D)';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.getProjectionFactors( [ 0, 0, 0, 1 ], [ 0, 1, 2 ] );
  });

  /* */

  test.case = 'Wrong project array dimension (sphere 2D vs sphere 1D)';
  test.shouldThrowErrorSync( function()
  {
    _.sphere.getProjectionFactors( [ 0, 0, 0 ], [ 0, 2 ] );
  });

}

//

function pointContains( test )
{
  test.case = 'Sphere and point remain unchanged';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 0, 0, 2 ];
  var gotContains = _.sphere.pointContains( sphere, point );

  var expected = false;
  test.identical( gotContains, expected );

  var oldSphere = [ 0, 0, 0, 1 ];
  test.identical( sphere, oldSphere );

  var oldPoint = [ 0, 0, 2 ];
  test.identical( point, oldPoint );

  test.case = 'Not contained in 1D';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 3, 0, 0 ];

  var expected = false;
  var gotContains = _.sphere.pointContains( sphere, point );

  test.identical( gotContains, expected );

  test.case = 'Not contained in 2D';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 3, 4, 0 ];

  var expected = false;
  var gotContains = _.sphere.pointContains( sphere, point );

  test.identical( gotContains, expected );

  test.case = 'Not contained in 3D';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 3, 3, 3 ];



  var expected = false;
  var gotContains = _.sphere.pointContains( sphere, point );

  test.equivalent( gotContains, expected );

  test.case = 'Point below the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ - 3, - 3, - 3 ];

  var expected = false;
  var gotContains = _.sphere.pointContains( sphere, point );

  test.equivalent( gotContains, expected );

  test.case = 'Point touching the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 1, 0, 0 ];

  var expected = true;
  var gotContains = _.sphere.pointContains( sphere, point );

  test.identical( gotContains, expected );

  test.case = 'Point inside the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 0, 0, 0.5 ];
  var expected = true;

  var gotContains = _.sphere.pointContains( sphere, point );

  test.identical( gotContains, expected );

  test.case = 'Point in the middle of the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 0, 0, 0 ];
  var expected = true;

  var gotContains = _.sphere.pointContains( sphere, point );

  test.identical( gotContains, expected );

  test.case = 'Center of the sphere not in the origin - point inside';

  var sphere = [ 1, 1, 2, 1 ];
  var point = [ 1, 1, 1.5 ];
  var expected = true;

  var gotContains = _.sphere.pointContains( sphere, point );

  test.identical( gotContains, expected );

  test.case = 'Center of the sphere not in the origin - point outside';

  var sphere = [ 1, 1, 2, 1 ];
  var point = [ 1, 1, 4.3 ];
  var expected = false;

  var gotContains = _.sphere.pointContains( sphere, point );

  test.equivalent( gotContains, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.pointContains( ) );
  test.shouldThrowErrorSync( () => _.sphere.pointContains( [ 0, 0, 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointContains( [ 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointContains( [ 0, 0, 0, 1 ], [ 1, 2, 3 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointContains( [ 1, 2, 3, 4 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointContains( [ 1, 2, 3, 4, 5 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointContains( null, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointContains( [ 0, 0, 0, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.pointContains( NaN, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointContains( [ 0, 0, 0, 1 ], NaN ) );
}

//

function pointDistance( test )
{
  test.case = 'Sphere and point remain unchanged';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 0, 0, 2 ];
  var oldSphere = [ 0, 0, 0, 1 ];
  var oldPoint = [ 0, 0, 2 ];
  var expected = 1;
  var gotDistance = _.sphere.pointDistance( sphere, point );

  test.identical( gotDistance, expected );
  test.identical( sphere, oldSphere );
  test.identical( point, oldPoint );

  test.case = 'Distance in 1D';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 3, 0, 0 ];
  var expected = 2;

  var gotDistance = _.sphere.pointDistance( sphere, point );

  test.identical( gotDistance, expected );

  test.case = 'Distance in 2D';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 3, 4, 0 ];
  var expected = 4;

  var gotDistance = _.sphere.pointDistance( sphere, point );

  test.identical( gotDistance, expected );

  test.case = 'Distance in 3D';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 3, 3, 3 ];
  var expected = 4.196152422706632;

  var gotDistance = _.sphere.pointDistance( sphere, point );

  test.equivalent( gotDistance, expected );

  test.case = 'Point below the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ - 3, - 3, - 3 ];
  var expected = 4.196152422706632;

  var gotDistance = _.sphere.pointDistance( sphere, point );

  test.equivalent( gotDistance, expected );

  test.case = 'Point touching the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 1, 0, 0 ];
  var expected = 0;

  var gotDistance = _.sphere.pointDistance( sphere, point );

  test.identical( gotDistance, expected );

  test.case = 'Point inside the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 0, 0, 0.5 ];
  var expected = 0;

  var gotDistance = _.sphere.pointDistance( sphere, point );

  test.identical( gotDistance, expected );

  test.case = 'Point in the middle of the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotDistance = _.sphere.pointDistance( sphere, point );

  test.identical( gotDistance, expected );

  test.case = 'Center of the sphere not in the origin - point inside';

  var sphere = [ 1, 1, 2, 1 ];
  var point = [ 1, 1, 1.5 ];
  var expected = 0;

  var gotDistance = _.sphere.pointDistance( sphere, point );

  test.identical( gotDistance, expected );

  test.case = 'Center of the sphere not in the origin - point outside';

  var sphere = [ 1, 1, 2, 1 ];
  var point = [ 1, 1, 4.3 ];
  var expected = 1.3;

  var gotDistance = _.sphere.pointDistance( sphere, point );

  test.equivalent( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.pointDistance( ) );
  test.shouldThrowErrorSync( () => _.sphere.pointDistance( [ 0, 0, 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointDistance( [ 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointDistance( [ 0, 0, 0, 1 ], [ 1, 2, 3 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointDistance( [ 1, 2, 3, 4 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointDistance( [ 1, 2, 3, 4, 5 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointDistance( null, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointDistance( [ 0, 0, 0, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.pointDistance( NaN, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointDistance( [ 0, 0, 0, 1 ], NaN ) );
}

//

function pointClosestPoint( test )
{
  test.case = 'Sphere and point remain unchanged';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 0, 0, 2 ];
  var oldSphere = [ 0, 0, 0, 1 ];
  var oldPoint = [ 0, 0, 2 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 1 ] );
  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point );

  test.identical( gotClosestPoint, expected );
  test.identical( sphere, oldSphere );
  test.identical( point, oldPoint );

  test.case = 'ClosestPoint in 1D';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 3, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 1, 0, 0 ] );

  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point );

  test.identical( gotClosestPoint, expected );

  test.case = 'ClosestPoint in 2D';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 3, 4, 0 ];
  var expected = _.sphere.tools.long.make( [ 0.6, 0.8, 0 ] );

  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'ClosestPoint in 3D';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 2, 4, 6 ];
  var expected = _.sphere.tools.long.make( [ 0.2672612419124244, 0.5345224838248488, 0.8017837257372732 ] );

  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'Point below the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ - 3, - 3, - 3 ];
  var expected = _.sphere.tools.long.make( [ -0.5773502691896257, -0.5773502691896257, -0.5773502691896257 ] );

  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'Point touching the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 1, 0, 0 ];
  var expected = _.sphere.tools.vectorAdapter.from( [ 1, 0, 0 ] );

  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point );

  test.identical( gotClosestPoint, expected );

  test.case = 'Point inside the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 0, 0, 0.5 ];
  var expected = _.sphere.tools.vectorAdapter.from( [ 0, 0, 0.5 ] );

  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point );

  test.identical( gotClosestPoint, expected );

  test.case = 'Point in the middle of the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var point = [ 0, 0, 0 ];
  var expected = _.sphere.tools.vectorAdapter.from( [ 0, 0, 0 ] );

  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point );

  test.identical( gotClosestPoint, expected );

  test.case = 'Center of the sphere not in the origin - point inside';

  var sphere = [ 1, 1, 2, 1 ];
  var point = [ 1, 1, 1.5 ];
  var expected = _.sphere.tools.vectorAdapter.from( [ 1, 1, 1.5 ] );

  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point );

  test.identical( gotClosestPoint, expected );

  test.case = 'Center of the sphere not in the origin - point outside';

  var sphere = [ 1, 1, 2, 1 ];
  var point = [ 1, 1, 4.3 ];
  var expected = _.sphere.tools.long.make( [ 1, 1, 3 ] );

  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'dstPoint is array';

  var sphere = [ 1, 1, 2, 1 ];
  var point = [ 1, 1, 4.3 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 1, 1, 3 ] );

  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point, dstPoint );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'dstPoint is vector';

  var sphere = [ 1, 1, 2, 1 ];
  var point = [ 1, 1, 4.3 ];
  var dstPoint = _.vectorAdapter.fromLong( [ 0, 0, 0 ] );
  var expected = _.sphere.tools.vectorAdapter.fromLong( [ 1, 1, 3 ] );

  var gotClosestPoint = _.sphere.pointClosestPoint( sphere, point, dstPoint );

  test.equivalent( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.pointClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.sphere.pointClosestPoint( [ 0, 0, 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointClosestPoint( [ 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointClosestPoint( [ 1, 2, 3, 4 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointClosestPoint( [ 1, 2, 3, 4, 5 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointClosestPoint( null, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointClosestPoint( [ 0, 0, 0, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.pointClosestPoint( NaN, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.pointClosestPoint( [ 0, 0, 0, 1 ], NaN ) );
}

//

function pointExpand( test )
{
  debugger;

  test.case = 'expand zero by zero';

  var sphere = [ 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 0 ] );
  var got = _.sphere.pointExpand( sphere, point );

  test.equivalent( got, expected );
  test.true( got === sphere );

  test.case = 'expand zero by non zero';

  var sphere = [ 0, 0, 0, 0 ];
  //var center = _.sphere.centerGet( sphere );
  var point = [ 1, 1, 1 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, _.math.sqrt( 3 ) ] );
  var got = _.sphere.pointExpand( sphere, point );
  //var d1 = _.avector.distance( point, center );
  debugger;
  //var d2 = _.avector.distance( _.dup( 0, 3 ), center );

  test.equivalent( got, expected );
  // test.equivalent( d1, d2 );
  // test.equivalent( d1, _.sphere.radiusGet( sphere ) );
  test.true( got === sphere );

  test.case = 'expand non zero by non zero';

  var sphere = [ 1, 1, 1, 1 ];
  var center = _.sphere.centerGet( sphere );
  var point = [ -1, -1, -1 ];
  var expected = _.sphere.tools.long.make( [ 1, 1, 1, 3.4641016151377544 ] );
  var got = _.sphere.pointExpand( sphere, point );
  // var d1 = _.avector.distance( point, center );
  // var d2 = _.avector.distance( _.dup( 1+_.math.sqrt( 3 ) / 3, 3 ), center );

  test.equivalent( got, expected );
  // test.equivalent( d1, d2 );
  // test.equivalent( d1, _.sphere.radiusGet( sphere ) );
  test.true( got === sphere );

  test.case = 'expand nil sphere by point';

  var sphere = [ 1, 1, 1, -Infinity ];
  var center = _.sphere.centerGet( sphere );
  var point = [ -1, -1, -1 ];
  var expected = _.sphere.tools.long.make( [ -1, -1, -1, 0 ] );
  var got = _.sphere.pointExpand( sphere, point );

  test.equivalent( got, expected );
  test.true( got === sphere );

  test.case = 'Point in sphere - no expansion';

  var sphere = [ 1, 1, 1, 3 ];
  var point = [ 0, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 1, 1, 1, 3 ] );
  var got = _.sphere.pointExpand( sphere, point );

  test.equivalent( got, expected );
  test.true( got === sphere );

  test.case = 'Point out of sphere - expansion';

  var sphere = [ 1, 1, 1, 3 ];
  var point = [ 1, 5, 1 ];
  var expected = _.sphere.tools.long.make( [ 1, 1, 1, 4 ] );
  var got = _.sphere.pointExpand( sphere, point );

  test.equivalent( got, expected );
  test.true( got === sphere );


}

//

function boxContains( test )
{
  /* */

  test.case = 'Sphere and box remain unchanged';

  var sphere = [ 0, 0, 0, 1 ];
  var oldSphere = [ 0, 0, 0, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var oldBox = [ 0, 0, 0, 1, 1, 1 ];
  var expected = false;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.identical( gotBool, expected );
  test.identical( sphere, oldSphere );
  test.identical( box, oldBox );

  /* */

  test.case = 'Empty sphere contains empty box';

  var sphere = [ 0, 0, 0, 0 ];
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = true;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.equivalent( gotBool, expected );

  /* */

  test.case = 'Sphere contains box';

  var sphere = [ 0, 0, 0, 2 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.equivalent( gotBool, expected );

  /* */

  test.case = 'Sphere inside box';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = false;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.equivalent( gotBool, expected );

  /* */

  test.case = 'Box inside sphere';

  var sphere = [ 0, 0, 0, 6 ];
  var box = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = true;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.equivalent( gotBool, expected );

  /* */

  test.case = 'Just touching';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 1, 0, 0, 2, 1, 1 ];
  var expected = false;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.equivalent( gotBool, expected );

  /* */

  test.case = 'Not intersecting';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 2, 2, 2, 3, 3, 3 ];
  var expected = false;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.equivalent( gotBool, expected );

  /* */

  test.case = 'One corner of the box in sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expected = false;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.equivalent( gotBool, expected );

  test.case = 'Sphere is nil';

  var sphere = _.sphere.makeSingular();
  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expected = true;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.equivalent( gotBool, expected );

  test.case = 'box is nil';

  var sphere = [ 0, 0, 0, 2 ];
  var box = _.box.makeSingular();
  var expected = false;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.equivalent( gotBool, expected );

  test.case = 'Negative distance no intersection';

  var sphere = [ 0, 0, 0, 2 ];
  var box = [ -4, -4, -4, -3, -3, -3 ];
  var expected = false;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.equivalent( gotBool, expected );

  test.case = 'Negative distance - sphere contains box';

  var sphere = [ -3, -3, -3, 4 ];
  var box = [ -4, -4, -4, -1, -1, -1 ];
  var expected = true;
  var gotBool = _.sphere.boxContains( sphere, box );

  test.equivalent( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.boxContains( ) );
  test.shouldThrowErrorSync( () => _.sphere.boxContains( [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxContains( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4, 5, 6 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxContains( 'sphere', 'box' ) );
  test.shouldThrowErrorSync( () => _.sphere.boxContains( [ 1, 2, 3, 4 ], 'box' ) );
  test.shouldThrowErrorSync( () => _.sphere.boxContains( 'sphere', [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxContains( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxContains( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4, 5, 6, 7 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxContains( [ 1, 2, 3, 4 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.boxContains( null, [ 1, 2, 3, 4 ] ) );

}

//

function boxIntersects( test )
{
  /* */

  test.case = 'Sphere and box remain unchanged';

  var sphere = [ 0, 0, 0, 1 ];
  var oldSphere = [ 0, 0, 0, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var oldBox = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.identical( gotBool, expected );
  test.identical( sphere, oldSphere );
  test.identical( box, oldBox );

  /* */

  test.case = 'Intersection of empty sphere and box';

  var sphere = [ 0, 0, 0, 0 ];
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = true;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.equivalent( gotBool, expected );

  /* */

  test.case = 'Trivial intersection';

  var sphere = [ - 1, 2, 0, 2 ];
  var box = [ - 2, 0, 0, 0, 2, 1 ];
  var expected = true;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.equivalent( gotBool, expected );

  /* */

  test.case = 'Sphere inside box';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = true;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.equivalent( gotBool, expected );

  /* */

  test.case = 'Box inside sphere';

  var sphere = [ 0, 0, 0, 6 ];
  var box = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = true;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.equivalent( gotBool, expected );

  /* */

  test.case = 'Just touching';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 1, 0, 0, 2, 1, 1 ];
  var expected = true;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.equivalent( gotBool, expected );

  /* */

  test.case = 'Not intersecting';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 2, 2, 2, 3, 3, 3 ];
  var expected = false;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.equivalent( gotBool, expected );

  /* */

  test.case = 'One corner of the box in sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expected = true;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.equivalent( gotBool, expected );

  test.case = 'Sphere is nil';

  var sphere = _.sphere.makeSingular();
  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expected = true;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.equivalent( gotBool, expected );

  test.case = 'box is nil';

  var sphere = [ 0, 0, 0, 2 ];
  var box = _.box.makeSingular();
  var expected = false;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.equivalent( gotBool, expected );

  test.case = 'Negative distance no intersection';

  var sphere = [ 0, 0, 0, 2 ];
  var box = [ -4, -4, -4, -3, -3, -3 ];
  var expected = false;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.equivalent( gotBool, expected );

  test.case = 'Negative distance - intersection';

  var sphere = [ 0, 0, 0, 2 ];
  var box = [ -4, -4, -4, -1, -1, -1 ];
  var expected = true;
  var gotBool = _.sphere.boxIntersects( sphere, box );

  test.equivalent( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.boxIntersects( ) );
  test.shouldThrowErrorSync( () => _.sphere.boxIntersects( [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxIntersects( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4, 5, 6 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxIntersects( 'sphere', 'box' ) );
  test.shouldThrowErrorSync( () => _.sphere.boxIntersects( [ 1, 2, 3, 4 ], 'box' ) );
  test.shouldThrowErrorSync( () => _.sphere.boxIntersects( 'sphere', [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxIntersects( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxIntersects( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4, 5, 6, 7 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxIntersects( [ 1, 2, 3, 4 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.boxIntersects( null, [ 1, 2, 3, 4 ] ) );

}

//

function boxClosestPoint( test )
{
  test.case = 'Sphere and point remain unchanged';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 0, 0, 2, 1, 1, 3 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 1 ] );
  var gotClosestPoint = _.sphere.boxClosestPoint( sphere, box );

  test.identical( gotClosestPoint, expected );
  var oldSphere = [ 0, 0, 0, 1 ];
  test.identical( sphere, oldSphere );
  var oldBox = [ 0, 0, 2, 1, 1, 3 ];
  test.identical( box, oldBox );

  test.case = 'ClosestPoint in 1D';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 3, 0, 0, 5, 2, 2 ];
  var expected = _.sphere.tools.long.make( [ 1, 0, 0 ] );

  var gotClosestPoint = _.sphere.boxClosestPoint( sphere, box );

  test.identical( gotClosestPoint, expected );

  test.case = 'ClosestPoint in 2D';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 3, 4, 0, 7, 8, 9 ];
  var expected = _.sphere.tools.long.make( [ 0.6, 0.8, 0 ] );

  var gotClosestPoint = _.sphere.boxClosestPoint( sphere, box );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'ClosestPoint in 3D';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 2, 4, 6, 3, 7, 7 ];
  var expected = _.sphere.tools.long.make( [ 0.2672612419124244, 0.5345224838248488, 0.8017837257372732 ] );

  var gotClosestPoint = _.sphere.boxClosestPoint( sphere, box );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'Box below the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ -5, -6, -4, - 3, - 3, - 3 ];
  var expected = _.sphere.tools.long.make( [ -0.5773502691896257, -0.5773502691896257, -0.5773502691896257 ] );

  var gotClosestPoint = _.sphere.boxClosestPoint( sphere, box );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'Box corner touching the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 1, 0, 0, 2, 0, 2 ];
  var expected = 0;

  var gotClosestPoint = _.sphere.boxClosestPoint( sphere, box );

  test.identical( gotClosestPoint, expected );

  test.case = 'Box and sphere intersect';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 0, 0, 0.5, 1, 1, 1 ];
  var expected = 0;

  var gotClosestPoint = _.sphere.boxClosestPoint( sphere, box );

  test.identical( gotClosestPoint, expected );

  test.case = 'Box inside the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 0, 0, 0, 0.5, 0.5, 0.5 ];
  var expected = 0;

  var gotClosestPoint = _.sphere.boxClosestPoint( sphere, box );

  test.identical( gotClosestPoint, expected );

  test.case = 'Sphere inside box';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ -1, -1, -1, 1, 1, 1 ];
  var expected = 0;

  var gotClosestPoint = _.sphere.boxClosestPoint( sphere, box );

  test.identical( gotClosestPoint, expected );

  test.case = 'dstPoint is array';

  var sphere = [ 1, 1, 2, 1 ];
  var box = [ 1, 1, 4.3, 2, 2, 5 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 1, 1, 3 ] );

  var gotClosestPoint = _.sphere.boxClosestPoint( sphere, box, dstPoint );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'dstPoint is vector';

  var sphere = [ 1, 1, 2, 1 ];
  var box = [ 1, 1, 4.3, 2, 2, 5 ];
  var dstPoint = _.vectorAdapter.fromLong( [ 0, 0, 0 ] );
  var expected = _.sphere.tools.vectorAdapter.fromLong( [ 1, 1, 3 ] );

  var gotClosestPoint = _.sphere.boxClosestPoint( sphere, box, dstPoint );

  test.equivalent( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.boxClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.sphere.boxClosestPoint( [ 0, 0, 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxClosestPoint( [ 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxClosestPoint( [ 1, 2, 3, 4 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxClosestPoint( [ 1, 2, 3, 4, 5 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxClosestPoint( null, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxClosestPoint( [ 0, 0, 0, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.boxClosestPoint( NaN, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxClosestPoint( [ 0, 0, 0, 1 ], NaN ) );
}

//

function boxExpand( test )
{
  /* */

  test.case = 'Sphere changes and box remains unchanged';

  var sphere = [ 0, 0, 0, 1 ];
  var oldSphere = [ 0, 0, 0, 1 ];
  var box = [ 0, 0, 0, 4, 3, 0 ];
  var oldBox = [ 0, 0, 0, 4, 3, 0 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 5 ] );;
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.true( gotSphere === sphere );
  test.identical( gotSphere, expected );
  test.identical( box, oldBox );

  /* */

  test.case = 'Expansion of empty sphere';

  var sphere = [ 0, 0, 0, 0 ];
  var box = [ 0, 0, 0, 0, 0, 1 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 1 ] );
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.true( gotSphere === sphere );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Trivial expansion';

  var sphere = [ - 1, 0, 0, 2 ];
  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expected = _.sphere.tools.long.make( [ - 1, 0, 0, 4.1231056256 ] );
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.true( gotSphere === sphere );
  test.equivalent( gotSphere, expected );

  /* */

  test.case = 'Expansion - box is point';

  var sphere = [ - 1, 0, 0, 2 ];
  var box = [ 3, 0, 0, 3, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ - 1, 0, 0, 4 ] );
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.true( gotSphere === sphere );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Sphere inside box';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 3.46410161513 ] );
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.true( gotSphere === sphere );
  test.equivalent( gotSphere, expected );

  /* */

  test.case = 'Box inside sphere - no expansion';

  var sphere = [ 0, 0, 0, 6 ];
  var box = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 6 ] );
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.true( gotSphere === sphere );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Zero Box - no expansion';

  var sphere = [ 0, 0, 0, 6 ];
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 6 ] );
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.true( gotSphere === sphere );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'Just touching - expansion';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 1, 0, 0, 2, 1, 1 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 2.449489742 ] );
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.true( gotSphere === sphere );
  test.equivalent( gotSphere, expected );

  /* */

  test.case = 'Just touching - no expansion';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 0, 0, 0, 0, 0, 1 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 1 ] );
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.true( gotSphere === sphere );
  test.identical( gotSphere, expected );

  /* */

  test.case = 'One corner of the box in sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var box = [ 0, 0, 0, 2, - 2, 2 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 3.4641016151 ] );
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.true( gotSphere === sphere );
  test.equivalent( gotSphere, expected );

  test.case = 'Sphere is nil';

  var sphere = _.sphere.makeSingular();
  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expected =  _.sphere.tools.long.make( [ 0, 0, 0, 3.4641016151 ] );
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.true( gotSphere === sphere );
  test.equivalent( gotSphere, expected );

  test.case = 'box is nil';

  var sphere = [ 0, 0, 0, 2 ];
  var box = _.box.makeSingular();
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, Infinity ] );
  var gotSphere = _.sphere.boxExpand( sphere, box );

  test.true( gotSphere === sphere );
  test.identical( gotSphere, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.boxExpand( ) );
  test.shouldThrowErrorSync( () => _.sphere.boxExpand( [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxExpand( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4, 5, 6 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxExpand( 'sphere', 'box' ) );
  test.shouldThrowErrorSync( () => _.sphere.boxExpand( [ 1, 2, 3, 4 ], 'box' ) );
  test.shouldThrowErrorSync( () => _.sphere.boxExpand( 'sphere', [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxExpand( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxExpand( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4, 5, 6, 7 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxExpand( [ 1, 2, 3, 4 ], undefined ) );
  test.shouldThrowErrorSync( () => _.sphere.boxExpand( null, [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boxExpand( [ 1, 2, 3, 4 ], null ) );

}

//

function boundingBoxGet( test )
{

  /* */

  test.case = 'Source sphere remains unchanged';

  var srcSphere = [ 0, 0, 0, 3 ];
  var dstBox = [ 1, 1, 1, 2, 2, 2 ];
  var expected = _.sphere.tools.long.make( [ - 3, - 3, - 3, 3, 3, 3 ] );

  var gotBox = _.sphere.boundingBoxGet( dstBox, srcSphere );
  test.identical( expected, gotBox );
  test.true( dstBox === gotBox );

  var oldSrcSphere = [ 0, 0, 0, 3 ];
  test.identical( srcSphere, oldSrcSphere );

  /* */

  test.case = 'Zero sphere to zero box';

  var srcSphere = [ 0, 0, 0, 0 ];
  var dstBox = [ 0, 0, 0, 1, 1, 1 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 0, 0, 0 ] );

  var gotBox = _.sphere.boundingBoxGet( dstBox, srcSphere );
  test.identical( gotBox, expected );

  /* */

  test.case = 'Box inside sphere - same center';

  var srcSphere = [ 1, 1, 1, 4 ];
  var dstBox = [ 0, 0, 0, 2, 2, 2 ];
  var expected = _.sphere.tools.long.make( [ - 3, - 3, - 3, 5, 5, 5 ] );

  var gotBox = _.sphere.boundingBoxGet( dstBox, srcSphere );
  test.identical( gotBox, expected );

  /* */

  test.case = 'Point sphere and point Box';

  var srcSphere = [ 1, 2, 3, 0 ];
  var dstBox = [ 3, 3, 3, 4, 4, 4 ];
  var expected = _.sphere.tools.long.make( [ 1, 2, 3, 1, 2, 3 ] );

  var gotBox = _.sphere.boundingBoxGet( dstBox, srcSphere );
  test.identical( gotBox, expected );

  /* */

  test.case = 'Sphere inside Box';

  var srcSphere = [ - 1, - 1, - 1, 1 ];
  var dstBox = [ - 3, - 4, - 5, 5, 4, 3 ];
  var expected = _.sphere.tools.long.make( [ - 2, - 2, - 2, 0, 0, 0 ] );

  var gotBox = _.sphere.boundingBoxGet( dstBox, srcSphere );
  test.identical( gotBox, expected );

  /* */

  test.case = 'Box outside sphere';

  var srcSphere = [ 1, 2, 3, 2 ];
  var dstBox = [ 5, 5, 5, 6, 6, 6 ];
  var expected = _.sphere.tools.long.make( [ - 1, 0, 1, 3, 4, 5 ] );

  var gotBox = _.sphere.boundingBoxGet( dstBox, srcSphere );
  test.identical( gotBox, expected );

  /* */

  test.case = 'srcSphere vector';

  var srcSphere = _.vectorAdapter.from( [ - 2, 1, 10.5, 6 ] );
  var dstBox = [ 1, - 1, 5, 0, 3, 2 ];
  var expected = _.sphere.tools.long.make( [ - 8, - 5, 4.5, 4, 7, 16.5 ] );

  var gotBox = _.sphere.boundingBoxGet( dstBox, srcSphere );
  test.identical( gotBox, expected );

  /* */

  test.case = 'dstBox vector';

  var srcSphere = [ - 1, 0, - 2, 3 ];
  var dstBox = _.vectorAdapter.from( [ 1, 2, 3, 9, 8, 7 ] );
  var expected = _.sphere.tools.vectorAdapter.from( [ - 4, - 3, - 5, 2, 3, 1  ] );

  var gotBox = _.sphere.boundingBoxGet( dstBox, srcSphere );
  test.identical( gotBox, expected );

  /* */

  test.case = 'dstBox null';

  var srcSphere = [ 2.2, 3.3, - 4.4, 1 ];
  var dstBox = null;
  var expected = _.sphere.tools.long.make( [ 1.2, 2.3, -5.4, 3.2, 4.3, -3.4 ] );

  var gotBox = _.sphere.boundingBoxGet( dstBox, srcSphere );
  test.equivalent( gotBox, expected );

  /* */

  test.case = 'dstBox undefined';

  var srcSphere = [ - 1, - 3, - 5, 0 ];
  var dstBox = undefined;
  var expected = _.sphere.tools.long.make( [  - 1, - 3, - 5, - 1, - 3, - 5 ] );

  var gotBox = _.sphere.boundingBoxGet( dstBox, srcSphere );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.boundingBoxGet( ) );
  test.shouldThrowErrorSync( () => _.sphere.boundingBoxGet( [] ) );
  test.shouldThrowErrorSync( () => _.sphere.boundingBoxGet( [], [] ) );
  test.shouldThrowErrorSync( () => _.sphere.boundingBoxGet( 'box', 'sphere' ) );
  test.shouldThrowErrorSync( () => _.sphere.boundingBoxGet( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boundingBoxGet( [ 1, 0, 1, 2, 1, 2 ], [ 0, 0, 0, 1 ], [ 0, 1, 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boundingBoxGet( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boundingBoxGet( NaN, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.boundingBoxGet( [ 0, 1, 0, 1, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.boundingBoxGet( [ 0, 1, 0, 1, 2, 1 ], NaN ) );
  test.shouldThrowErrorSync( () => _.sphere.boundingBoxGet( [ 0, 1, 0, 1, 2 ], [ 0, 0, 1 ] ) );

}

//

function capsuleContains( test )
{
  test.case = 'Sphere and capsule remain unchanged';

  var sphere = [ 0, 0, 0, 1 ];
  var capsule = [ 0, 0, 2, 1, 1, 3, 0.5 ];
  var expected = false;
  var gotBool = _.sphere.capsuleContains( sphere, capsule );

  test.identical( gotBool, expected );
  var oldSphere = [ 0, 0, 0, 1 ];
  test.identical( sphere, oldSphere );
  var oldCapsule = [ 0, 0, 2, 1, 1, 3, 0.5 ];
  test.identical( capsule, oldCapsule );

  test.case = 'Sphere and capsule intersect';

  var sphere = [ 4, 4, 4, 1 ];
  var capsule = [ 3, 3, 3, 5, 3, 3, 0.1 ];
  var expected = false;

  var gotBool = _.sphere.capsuleContains( sphere, capsule );

  test.identical( gotBool, expected );

  test.case = 'Sphere contains capsule';

  var sphere = [ 4, 4, 4, 4 ];
  var capsule = [ 3, 3, 3, 5, 3, 3, 0.1 ];
  var expected = true;

  var gotBool = _.sphere.capsuleContains( sphere, capsule );

  test.identical( gotBool, expected );

  test.case = 'sphere contains capsule in 2D';

  var sphere = [ -3, 4, 8  ];
  var capsule = [ -1, 3, -2, 5, 1 ];
  var expected = true;

  var gotBool = _.sphere.capsuleContains( sphere, capsule );

  test.equivalent( gotBool, expected );

  test.case = 'Capsule and sphere don´t intersect';

  var sphere = [ 0, 0, 0, 1 ];
  var capsule = [ -5, -6, -4, - 3, - 3, - 3, 1 ];
  var expected = false;

  var gotBool = _.sphere.capsuleContains( sphere, capsule );

  test.equivalent( gotBool, expected );

  test.case = 'Capsule corner touching the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var capsule = [ 2, 0, 0, 5, 0, 0, 1 ];
  var expected = false;

  var gotBool = _.sphere.capsuleContains( sphere, capsule );

  test.identical( gotBool, expected );

  test.case = 'Capsule and sphere intersect';

  var sphere = [ 0, 0, 0, 1 ];
  var capsule = [ 0, 0, 0.5, 1, 1, 1, 0.1 ];
  var expected = false;

  var gotBool = _.sphere.capsuleContains( sphere, capsule );

  test.identical( gotBool, expected );

//   var srcSphere = [ - 1, 0, - 2, 3 ];
//   var dstBox = _.vectorAdapter.from( [ 1, 2, 3, 9, 8, 7 ] );
//   var expected = _.sphere.tools.vectorAdapter.from( [ - 4, - 3, - 5, 2, 3, 1  ] );

  test.case = 'Capsule inside the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var capsule = [ 0, 0, 0, 0.5, 0.5, 0.5, 0.1 ];
  var expected = true;

  var gotBool = _.sphere.capsuleContains( sphere, capsule );

  test.identical( gotBool, expected );

  test.case = 'Sphere inside capsule';

  var sphere = [ 0, 0, 0, 1 ];
  var capsule = [ -1, -1, -1, 1, 1, 1, 2 ];
  var expected = false;

  var gotBool = _.sphere.capsuleContains( sphere, capsule );

  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.capsuleContains( ) );
  test.shouldThrowErrorSync( () => _.sphere.capsuleContains( [ 0, 0, 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.capsuleContains( [ 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.capsuleContains( [ 1, 2, 3, 4 ], [ 1, 2, 3, 4, 5 ], [ 1, 2, 3, 4, 5 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.capsuleContains( [ 1, 2, 3, 4 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.capsuleContains( [ 1, 2, 3, 4, 5 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.capsuleContains( [ 1, 2, 3, 4, 5 ], [ 1, 2, 3, 4, - 1 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.capsuleContains( null, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.capsuleContains( [ 0, 0, 0, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.capsuleContains( NaN, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.capsuleContains( [ 0, 0, 0, 1 ], NaN ) );
}

//

function capsuleClosestPoint( test )
{
  test.case = 'Sphere and point remain unchanged';

  var sphere = [ 0, 0, 0, 1 ];
  var capsule = [ 0, 0, 2, 1, 1, 3, 0.5 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 1 ] );
  var gotClosestPoint = _.sphere.capsuleClosestPoint( sphere, capsule );

  test.identical( gotClosestPoint, expected );
  var oldSphere = [ 0, 0, 0, 1 ];
  test.identical( sphere, oldSphere );
  var oldCapsule = [ 0, 0, 2, 1, 1, 3, 0.5 ];
  test.identical( capsule, oldCapsule );

  test.case = 'ClosestPoint in 1D';

  var sphere = [ 0, 0, 0, 1 ];
  var capsule = [ 3, 0, 0, 5, 2, 2, 1 ];
  var expected = _.sphere.tools.long.make( [ 1, 0, 0 ] );

  var gotClosestPoint = _.sphere.capsuleClosestPoint( sphere, capsule );

  test.identical( gotClosestPoint, expected );

  test.case = 'ClosestPoint in 2D';

  var sphere = [ 0, 0, 0, 1 ];
  var capsule = [ 3, 4, 0, 7, 8, 9, 0.1 ];
  var expected = _.sphere.tools.long.make( [ 0.6, 0.8, 0 ] );

  var gotClosestPoint = _.sphere.capsuleClosestPoint( sphere, capsule );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'ClosestPoint in 3D';

  var sphere = [ 0, 0, 0, 1 ];
  var capsule = [ 2, 4, 6, 3, 7, 7, 0.2 ];
  var expected = _.sphere.tools.long.make( [ 0.2672612419124244, 0.5345224838248488, 0.8017837257372732 ] );

  var gotClosestPoint = _.sphere.capsuleClosestPoint( sphere, capsule );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'Capsule below the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var capsule = [ -5, -6, -4, - 3, - 3, - 3, 1 ];
  var expected = _.sphere.tools.long.make( [ -0.5773502691896257, -0.5773502691896257, -0.5773502691896257 ] );

  var gotClosestPoint = _.sphere.capsuleClosestPoint( sphere, capsule );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'Capsule corner touching the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var capsule = [ 2, 0, 0, 5, 0, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.sphere.capsuleClosestPoint( sphere, capsule );

  test.identical( gotClosestPoint, expected );

  test.case = 'Capsule and sphere intersect';

  var sphere = [ 0, 0, 0, 1 ];
  var capsule = [ 0, 0, 0.5, 1, 1, 1, 0.1 ];
  var expected = 0;

  var gotClosestPoint = _.sphere.capsuleClosestPoint( sphere, capsule );

  test.identical( gotClosestPoint, expected );

  test.case = 'Capsule inside the sphere';

  var sphere = [ 0, 0, 0, 1 ];
  var capsule = [ 0, 0, 0, 0.5, 0.5, 0.5, 0.2 ];
  var expected = 0;

  var gotClosestPoint = _.sphere.capsuleClosestPoint( sphere, capsule );

  test.identical( gotClosestPoint, expected );

  test.case = 'Sphere inside capsule';

  var sphere = [ 0, 0, 0, 1 ];
  var capsule = [ -1, -1, -1, 1, 1, 1, 2 ];
  var expected = 0;

  var gotClosestPoint = _.sphere.capsuleClosestPoint( sphere, capsule );

  test.identical( gotClosestPoint, expected );

  test.case = 'dstPoint is array';

  var sphere = [ 1, 1, 2, 1 ];
  var capsule = [ 1, 1, 4.3, 2, 2, 5, 0.3 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 1, 1, 3 ] );

  var gotClosestPoint = _.sphere.capsuleClosestPoint( sphere, capsule, dstPoint );

  test.equivalent( gotClosestPoint, expected );

  test.case = 'dstPoint is vector';

  var sphere = [ 1, 1, 2, 1 ];
  var capsule = [ 1, 1, 4.3, 2, 2, 5, 0.3 ];
  var dstPoint = _.vectorAdapter.fromLong( [ 0, 0, 0 ] );
  var expected = _.sphere.tools.vectorAdapter.fromLong( [ 1, 1, 3 ] );

  var gotClosestPoint = _.sphere.capsuleClosestPoint( sphere, capsule, dstPoint );

  test.equivalent( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.capsuleClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.sphere.capsuleClosestPoint( [ 0, 0, 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.capsuleClosestPoint( [ 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.capsuleClosestPoint( [ 1, 2, 3, 4 ], [ 1, 2, 3, 4, 5 ], [ 1, 2, 3, 4, 5 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.capsuleClosestPoint( [ 1, 2, 3, 4 ], [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.capsuleClosestPoint( [ 1, 2, 3, 4, 5 ], [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.capsuleClosestPoint( [ 1, 2, 3, 4, 5 ], [ 1, 2, 3, 4, - 1 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.capsuleClosestPoint( null, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.capsuleClosestPoint( [ 0, 0, 0, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.capsuleClosestPoint( NaN, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.capsuleClosestPoint( [ 0, 0, 0, 1 ], NaN ) );
}

//

function convexPolygonContains( test )
{

  /* */

  test.case = 'Source sphere and polygon remain unchanged';

  var srcSphere = [ - 1, - 1, -1, 3, ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = true;

  var gotBool = _.sphere.convexPolygonContains( srcSphere, polygon );
  test.identical( expected, gotBool );

  var oldSrcSphere = [ - 1, - 1, -1, 3 ];
  test.identical( srcSphere, oldSrcSphere );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  /* */

  test.case = 'Sphere and polygon intersect';

  var srcSphere = [ - 1, - 1, -1, 2 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = false;

  var gotBool = _.sphere.convexPolygonContains( srcSphere, polygon );
  test.identical( expected, gotBool );

  /* */

  test.case = 'Sphere cuts polygon vertex';

  var srcSphere = [ 0, 1, 0, 2 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    -2,  -2,  -2,  -2,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = false;

  var gotBool = _.sphere.convexPolygonContains( srcSphere, polygon );
  test.identical( expected, gotBool );

  /* */

  test.case = 'Sphere and polygon don´t intersect';

  var srcSphere = [ 0, 1, 0, 1.5 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    -2,  -2,  -2,  -2,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = false;

  var gotBool = _.sphere.convexPolygonContains( srcSphere, polygon );
  test.identical( expected, gotBool );

  /* */

  test.case = 'Sphere contains polygon in origin';

  var srcSphere = [ 0, 0, 0, 3 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = true;

  var gotBool = _.sphere.convexPolygonContains( srcSphere, polygon );
  test.identical( expected, gotBool );

  /* */

  test.case = 'Sphere contains polygon';

  var srcSphere = [ -2, 0, 0, 1.5 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    -2,  -2,  -2,  -2,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = true;

  var gotBool = _.sphere.convexPolygonContains( srcSphere, polygon );
  test.identical( expected, gotBool );

  /* */

  test.case = 'Sphere contains polygon - touching sides';

  var srcSphere = [ -2, 0, 0, 1 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    -2,  -2,  -2,  -2,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = true;

  var gotBool = _.sphere.convexPolygonContains( srcSphere, polygon );
  test.identical( expected, gotBool );

  /* */

  test.case = '2D - Contained';

  var srcSphere = [ 4, 4, Math.sqrt( 2 ) ];
  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    3,   5,   5,   3,
    3,   3,   5,   5
  ]);
  var expected = true;

  var gotBool = _.sphere.convexPolygonContains( srcSphere, polygon );
  test.identical( expected, gotBool );

  /* */

  test.case = '2D - Not contained';

  var srcSphere = [ 4, 4, Math.sqrt( 2 )/2 ];
  var polygon =  _.Matrix.Make( [ 2, 3 ] ).copy
  ([
    2,   8,  2,
    2,   2,  8
  ]);
  var expected = false;

  var gotBool = _.sphere.convexPolygonContains( srcSphere, polygon );
  test.identical( expected, gotBool );

  /* */

  if( !Config.debug )
  return;

  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonContains( ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonContains( [] ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonContains( 'sphere', polygon ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonContains( [ 0, 0, 1 ], 'polygon' ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonContains(  null, polygon ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonContains(  [ 0, 1, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonContains(  NaN, polygon ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonContains(  [ 0, 1, 1 ], NaN ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonContains( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonContains( [ 0, 0, 1 ], [ 0, 1, 1 ], polygon ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonContains( [ 0, 1, 0 ], polygon, polygon ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonContains( [ 0, 1 ], polygon ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonContains( [ 0, 1, 0, 2 ], polygon ) );

}

//

function convexPolygonClosestPoint( test )
{

  /* */

  test.case = 'Source sphere and polygon remain unchanged';

  var srcSphere = [ - 1, - 1, -1, 3, ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = 0;

  var gotPoint = _.sphere.convexPolygonClosestPoint( srcSphere, polygon );
  test.identical( expected, gotPoint );

  var oldSrcSphere = [ - 1, - 1, -1, 3 ];
  test.identical( srcSphere, oldSrcSphere );

  var oldPolygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  test.identical( polygon, oldPolygon );

  /* */

  test.case = 'Sphere and polygon intersect';

  var srcSphere = [ - 1, - 1, -1, 2 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = 0;

  var gotPoint = _.sphere.convexPolygonClosestPoint( srcSphere, polygon );
  test.identical( expected, gotPoint );

  /* */

  test.case = 'Sphere cuts polygon vertex';

  var srcSphere = [ 0, 1, 0, 2 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    -2,  -2,  -2,  -2,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = 0;

  var gotPoint = _.sphere.convexPolygonClosestPoint( srcSphere, polygon );
  test.identical( expected, gotPoint );

  /* */

  test.case = 'Sphere next to polygon vertex';

  var srcSphere = [ 0, 1, 0, 1.5 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    -2,  -2,  -2,  -2,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = _.sphere.tools.long.make( [ -1.5, 1, 0 ] );

  var gotPoint = _.sphere.convexPolygonClosestPoint( srcSphere, polygon );
  test.identical( expected, gotPoint );

  /* */

  test.case = 'Sphere cuts polygon edge';

  var srcSphere = [ 0, 1, 1, Math.sqrt( 2 )/2 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = 0;

  var gotPoint = _.sphere.convexPolygonClosestPoint( srcSphere, polygon );
  test.identical( expected, gotPoint );

  /* */

  test.case = 'Sphere next to polygon edge';

  var srcSphere = [ 0, 2, 2, Math.sqrt( 2 ) ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = _.sphere.tools.long.make( [ 0, 1, 1 ] );

  var gotPoint = _.sphere.convexPolygonClosestPoint( srcSphere, polygon );
  test.equivalent( expected, gotPoint );

  /* */

  test.case = 'Sphere cuts polygon';

  var srcSphere = [ - 3, 0, 0, 1.5 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    -2,  -2,  -2,  -2,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var expected = 0;

  var gotPoint = _.sphere.convexPolygonClosestPoint( srcSphere, polygon );
  test.identical( expected, gotPoint );

  /* */

  test.case = 'Sphere next to polygon';

  var srcSphere = [ 0, 0, - 1, 0.5 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    1,   0, - 1,   0,
    0,   1,   0, - 1,
    0,   0,   0,   0
  ]);
  var expected = _.sphere.tools.long.make( [ 0, 0, -0.5 ] );

  var gotPoint = _.sphere.convexPolygonClosestPoint( srcSphere, polygon );
  test.identical( expected, gotPoint );

  /* */

  test.case = '2D';

  var srcSphere = [ 4, 4, Math.sqrt( 2 )/2 ];
  var polygon =  _.Matrix.Make( [ 2, 4 ] ).copy
  ([
    0,   1,   1,   0,
    0,   0,   1,   1
  ]);
  var expected = _.sphere.tools.long.make( [ 3.5, 3.5 ] );

  var gotPoint = _.sphere.convexPolygonClosestPoint( srcSphere, polygon );
  test.equivalent( expected, gotPoint );

  /* */

  test.case = 'dstPoint Array';

  var srcSphere = [ 3, 4, 4, Math.sqrt( 3 ) ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var dstPoint = [ 0, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 2.1022415975031303, 2.9526151970869856, 2.9526151970869856 ] );

  var gotPoint = _.sphere.convexPolygonClosestPoint( srcSphere, polygon, dstPoint );
  test.equivalent( expected, gotPoint );
  test.true( dstPoint === gotPoint );

  /* */

  test.case = 'dstPoint Vector';

  var srcSphere = [ -1, -2, -4, 2 ];
  var polygon =  _.Matrix.Make( [ 3, 4 ] ).copy
  ([
    0,   0,   0,   0,
    1,   0, - 1,   0,
    0,   1,   0, - 1
  ]);
  var dstPoint = _.sphere.tools.vectorAdapter.from( [ 0, 2, 1 ] );
  var expected = _.sphere.tools.vectorAdapter.from( [ -0.4654775161751512, -0.9309550323503024, -2.3964325485254534 ] );

  var gotPoint = _.sphere.convexPolygonClosestPoint( srcSphere, polygon, dstPoint );
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
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonClosestPoint( [] ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonClosestPoint( 'sphere', polygon ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonClosestPoint( [ 0, 0, 1 ], 'polygon' ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonClosestPoint(  null, polygon ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonClosestPoint(  [ 0, 1, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonClosestPoint(  NaN, polygon ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonClosestPoint(  [ 0, 1, 1 ], NaN ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonClosestPoint( [ 0, 0, 1 ], [ 0, 1, 1 ], polygon ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonClosestPoint( [ 0, 1, 0 ], polygon, polygon ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonClosestPoint( [ 0, 1 ], polygon ) );
  test.shouldThrowErrorSync( () => _.sphere.convexPolygonClosestPoint( [ 0, 1, 0, 2 ], polygon ) );

}

//

function frustumContains( test )
{
  test.description = 'Frustum and sphere remain unchanged'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 3, 3, 3, 2 ];

  var expected = false;
  var gotBool = _.sphere.frustumContains( srcSphere, tstFrustum );
  test.identical( gotBool, expected );

  var oldSrcSphere = srcSphere.slice();
  test.identical( srcSphere, oldSrcSphere );

  var oldFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( tstFrustum, oldFrustum );

  test.description = 'Sphere contains frustum'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 0, 0, 0, 2 ];

  var expected = true;
  var gotBool = _.sphere.frustumContains( srcSphere, tstFrustum );
  test.identical( gotBool, expected );

  test.description = 'Sphere contains frustum - near corner'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 0, 0, 0, Math.sqrt( 3 ) + 0.1 ];

  var expected = true;
  var gotBool = _.sphere.frustumContains( srcSphere, tstFrustum );
  test.identical( gotBool, expected );

  test.description = 'Sphere contains frustum - touching corner'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 0, 0, 0, Math.sqrt( 3 ) + test.accuracy ];

  var expected = true;
  var gotBool = _.sphere.frustumContains( srcSphere, tstFrustum );
  test.identical( gotBool, expected );

  test.description = 'Sphere doesn´t contains frustum - just outside corner'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 0, 0, 0, Math.sqrt( 3 ) - test.accuracy ];

  var expected = false;
  var gotBool = _.sphere.frustumContains( srcSphere, tstFrustum );
  test.identical( gotBool, expected );

  test.description = 'Sphere doesn´t contain frustum'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 5, 5, 5, 1 ];

  var expected = false;
  var gotBool = _.sphere.frustumContains( srcSphere, tstFrustum );
  test.identical( gotBool, expected );

  test.description = 'Sphere doesn´t contain frustum - intersection'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 2, 2, 2, 2 ];

  var expected = false;
  var gotBool = _.sphere.frustumContains( srcSphere, tstFrustum );
  test.identical( gotBool, expected );

  test.description = 'Zero frustum'; //

  var tstFrustum =  _.frustum.make();
  var srcSphere = [ 0, 0, 0, 2 ];

  var expected = true;
  var gotBool = _.sphere.frustumContains( srcSphere, tstFrustum );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);

  test.shouldThrowErrorSync( () => _.sphere.frustumContains( ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumContains( 'sphere', 'frustum' ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumContains( [ 1, 2, 3, 4 ], 'frustum' ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumContains( 'sphere', [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumContains( [ 1, 2, 3, 4 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumContains( null, tstFrustum ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumContains( [ 1, 2, 3, 4 ], NaN ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumContains( NaN, tstFrustum ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumContains( [ 1, 2, 3 ] , tstFrustum ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumContains( [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumContains( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] , tstFrustum ) );

}

//

function frustumDistance( test )
{
  test.description = 'Frustum and sphere remain unchanged'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 3, 3, 3, 2 ];

  var expected = 1.4641016151377544;
  var gotDistance = _.sphere.frustumDistance( srcSphere, tstFrustum );
  test.equivalent( gotDistance, expected );

  var oldSrcSphere = srcSphere.slice();
  test.identical( srcSphere, oldSrcSphere );

  var oldFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( tstFrustum, oldFrustum );

  test.description = 'Sphere contains frustum'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 0, 0, 0, 2 ];

  var expected = 0
  var gotDistance = _.sphere.frustumDistance( srcSphere, tstFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Sphere contains frustum - near corner'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 0, 0, 0, Math.sqrt( 3 ) + 0.1 ];

  var expected = 0;
  var gotDistance = _.sphere.frustumDistance( srcSphere, tstFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Sphere doesn´t contain frustum - just outside corner'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 0, 0, 0, Math.sqrt( 3 ) - test.accuracy ];

  var expected = 0;
  var gotDistance = _.sphere.frustumDistance( srcSphere, tstFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Sphere doesn´t contain frustum'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 5, 5, 5, 1 ];

  var expected = 5.928203230275509;
  var gotDistance = _.sphere.frustumDistance( srcSphere, tstFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Sphere doesn´t contain frustum - intersection'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 2, 2, 2, 2 ];

  var expected = 0;
  var gotDistance = _.sphere.frustumDistance( srcSphere, tstFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Sphere close to frustum side'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 0, 3, 0, 1 ];

  var expected = 1;
  var gotDistance = _.sphere.frustumDistance( srcSphere, tstFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Zero frustum'; //

  var tstFrustum =  _.frustum.make();
  var srcSphere = [ 0, 0, 0, 2 ];

  var expected = 0;
  var gotDistance = _.sphere.frustumDistance( srcSphere, tstFrustum );
  test.identical( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);

  test.shouldThrowErrorSync( () => _.sphere.frustumDistance( ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumDistance( 'sphere', 'frustum' ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumDistance( [ 1, 2, 3, 4 ], 'frustum' ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumDistance( 'sphere', [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumDistance( [ 1, 2, 3, 4 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumDistance( null, tstFrustum ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumDistance( [ 1, 2, 3, 4 ], NaN ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumDistance( NaN, tstFrustum ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumDistance( [ 1, 2, 3 ] , tstFrustum ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumDistance( [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumDistance( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] , tstFrustum ) );

}

//

function frustumClosestPoint( test )
{
  test.description = 'Frustum and sphere remain unchanged'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 3, 0, 0, 1 ];

  var expected = _.sphere.tools.long.make( [ 2, 0, 0 ] );
  var gotDistance = _.sphere.frustumClosestPoint( srcSphere, tstFrustum );
  test.equivalent( gotDistance, expected );

  var oldSrcSphere = srcSphere.slice();
  test.identical( srcSphere, oldSrcSphere );

  var oldFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( tstFrustum, oldFrustum );

  test.description = 'Sphere contains frustum'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 0, 0, 0, 2 ];

  var expected = 0
  var gotDistance = _.sphere.frustumClosestPoint( srcSphere, tstFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Intersection'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
  - 1, 0, - 1, 0, 0, - 1,
  0, 0, 0, 0, - 1, 1,
  1, - 1, 0, 0, 0, 0,
  0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 2, 2, 2, 2 ];

  var expected = 0;
  var gotDistance = _.sphere.frustumClosestPoint( srcSphere, tstFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustum contains sphere'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 0, 0, 0, 1 ];

  var expected = 0;
  var gotDistance = _.sphere.frustumClosestPoint( srcSphere, tstFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Closest point away in 1D'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 0, 5, 1, 1 ];

  var expected = _.sphere.tools.long.make( [ 0, 4, 1 ] );
  var gotDistance = _.sphere.frustumClosestPoint( srcSphere, tstFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Closest point away in 2D'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 0, 3, 3, 1 ];

  var expected = _.sphere.tools.long.make( [ 0, 2.2928932188134525, 2.2928932188134525 ] );
  var gotDistance = _.sphere.frustumClosestPoint( srcSphere, tstFrustum );
  test.equivalent( gotDistance, expected );

  test.description = 'Closest point away in 3D'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 3, 3, 3, 1 ];

  var expected = _.sphere.tools.long.make( [ 2.4226497308103743, 2.4226497308103743, 2.4226497308103743 ] );
  var gotDistance = _.sphere.frustumClosestPoint( srcSphere, tstFrustum );
  test.equivalent( gotDistance, expected );

  test.description = 'Zero frustum'; //

  var tstFrustum =  _.frustum.make();
  var srcSphere = [ 0, 0, 0, 2 ];

  var expected = 0;
  var gotDistance = _.sphere.frustumClosestPoint( srcSphere, tstFrustum );
  test.identical( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);

  test.shouldThrowErrorSync( () => _.sphere.frustumClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumClosestPoint( 'sphere', 'frustum' ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumClosestPoint( [ 1, 2, 3, 4 ], 'frustum' ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumClosestPoint( 'sphere', [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumClosestPoint( [ 1, 2, 3, 4 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumClosestPoint( null, tstFrustum ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumClosestPoint( [ 1, 2, 3, 4 ], NaN ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumClosestPoint( NaN, tstFrustum ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumClosestPoint( [ 1, 2, 3 ] , tstFrustum ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumClosestPoint( [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumClosestPoint( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] , tstFrustum ) );

}

//

function frustumExpand( test )
{
  test.description = 'Frustum and sphere remain unchanged'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 3, 0, 0, 1 ];

  var expected = _.sphere.tools.long.make( [ 3, 0, 0, 3.3166247903554 ] );
  var gotDistance = _.sphere.frustumExpand( srcSphere, tstFrustum );
  test.equivalent( gotDistance, expected );

  var oldSrcSphere = srcSphere.slice();
  test.identical( srcSphere, oldSrcSphere );

  var oldFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  test.identical( tstFrustum, oldFrustum );

  test.description = 'Sphere contains frustum'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 0, 0, 0, 2 ];

  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 2 ] );
  var gotDistance = _.sphere.frustumExpand( srcSphere, tstFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Intersection'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
  - 1, 0, - 1, 0, 0, - 1,
  0, 0, 0, 0, - 1, 1,
  1, - 1, 0, 0, 0, 0,
  0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 2, 2, 2, 2 ];

  var expected = _.sphere.tools.long.make( [ 2, 2, 2, Math.sqrt( 12 ) ] );
  var gotDistance = _.sphere.frustumExpand( srcSphere, tstFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustum contains sphere'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 0, 0, 0, 1 ];

  var expected = _.sphere.tools.long.make( [ 0, 0, 0, Math.sqrt( 3 ) ] );
  var gotDistance = _.sphere.frustumExpand( srcSphere, tstFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustrum away in 1D'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 0, 5, 1, 1 ];

  var expected = _.sphere.tools.long.make( [ 0, 5, 1, Math.sqrt( 27 ) ] );
  var gotDistance = _.sphere.frustumExpand( srcSphere, tstFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustum away in 2D'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 0, 3, 3, 1 ];

  var expected = _.sphere.tools.long.make( [ 0, 3, 3, Math.sqrt( 19 ) ] );
  var gotDistance = _.sphere.frustumExpand( srcSphere, tstFrustum );
  test.equivalent( gotDistance, expected );

  test.description = 'Closest point away in 3D'; //

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);
  var srcSphere = [ 3, 3, 3, 1 ];

  var expected = _.sphere.tools.long.make( [ 3, 3, 3, Math.sqrt( 27 ) ] );
  var gotDistance = _.sphere.frustumExpand( srcSphere, tstFrustum );
  test.equivalent( gotDistance, expected );

  test.description = 'Zero frustum'; //

  var tstFrustum =  _.frustum.make();
  var srcSphere = [ 0, 0, 0, 2 ];

  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 2 ] );
  var gotDistance = _.sphere.frustumExpand( srcSphere, tstFrustum );
  test.identical( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;

  var tstFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  ([
    - 1, 0, - 1, 0, 0, - 1,
    0, 0, 0, 0, - 1, 1,
    1, - 1, 0, 0, 0, 0,
    0, 0, 1, - 1, 0, 0,
  ]);

  test.shouldThrowErrorSync( () => _.sphere.frustumExpand( ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumExpand( 'sphere', 'frustum' ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumExpand( [ 1, 2, 3, 4 ], 'frustum' ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumExpand( 'sphere', [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumExpand( [ 1, 2, 3, 4 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumExpand( null, tstFrustum ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumExpand( [ 1, 2, 3, 4 ], NaN ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumExpand( NaN, tstFrustum ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumExpand( [ 1, 2, 3 ] , tstFrustum ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumExpand( [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.frustumExpand( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] , tstFrustum ) );

}

//

function lineClosestPoint( test )
{

  /* */

  test.case = 'Source sphere and line remain unchanged';

  var srcSphere = [ - 1, - 1, -1, 2 ];
  var tstLine = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotLine = _.sphere.lineClosestPoint( srcSphere, tstLine );
  test.identical( expected, gotLine );

  var oldSrcSphere = [ - 1, - 1, -1, 2 ];
  test.identical( srcSphere, oldSrcSphere );

  var oldTstLine = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( tstLine, oldTstLine );

  /* */

  test.case = 'sphere and line intersect';

  var srcSphere = [ - 1, - 1, -1, 3 ];
  var tstLine = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotLine = _.sphere.lineClosestPoint( srcSphere, tstLine );
  test.identical( expected, gotLine );

  /* */

  test.case = 'Line origin touches sphere';

  var srcSphere = [ - 1, - 1, -1, 1 ];
  var tstLine = [ -1, -1, 0, 0, 0, 1 ];
  var expected = 0;

  var gotLine = _.sphere.lineClosestPoint( srcSphere, tstLine );
  test.identical( expected, gotLine );

  /* */

  test.case = 'Negative factor';

  var srcSphere = [ - 1, - 1, -1, 1 ];
  var tstLine = [ - 1, -1, 2, 0, 0, 1 ];
  var expected = 0;

  var gotLine = _.sphere.lineClosestPoint( srcSphere, tstLine );
  test.identical( expected, gotLine );

  /* */

  test.case = 'Line and sphere don´t intersect';

  var srcSphere = [ - 1, - 1, -1, 1 ];
  var tstLine = [ - 1, -1, 2, 0, 1, 0 ];
  var expected = _.sphere.tools.long.make( [ - 1, - 1, 0 ] );

  var gotLine = _.sphere.lineClosestPoint( srcSphere, tstLine );
  test.identical( expected, gotLine );

  /* */

  test.case = 'Closest point in sphere side';

  var srcSphere = [ 0, 0, 0, 4 ];
  var tstLine = [ 5, 0, 0, 0, 1, 0 ];
  var expected = _.sphere.tools.long.make( [ 4, 0, 0 ] );

  var gotLine = _.sphere.lineClosestPoint( srcSphere, tstLine );
  test.identical( expected, gotLine );

  /* */

  test.case = 'dstPoint Array';

  var srcSphere = [ 0, 0, 0, 4 ];
  var tstLine = [ 5, 0, 0, 0, 1, 0 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 4, 0, 0 ] );

  var gotLine = _.sphere.lineClosestPoint( srcSphere, tstLine, dstPoint );
  test.identical( expected, gotLine );
  test.true( dstPoint === gotLine );

  /* */

  test.case = 'dstPoint Vector';

  var srcSphere = [ 0, 0, 0, 4 ];
  var tstLine = [ 0, 0, 5, 1, 0, 0 ];
  var dstPoint = _.vectorAdapter.from( [ 0, 0, 0 ] );
  var expected = _.sphere.tools.vectorAdapter.from( [ 0, 0, 4 ] );

  var gotLine = _.sphere.lineClosestPoint( srcSphere, tstLine, dstPoint );
  test.equivalent( expected, gotLine );
  test.true( dstPoint === gotLine );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.lineClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.sphere.lineClosestPoint( [] ) );
  test.shouldThrowErrorSync( () => _.sphere.lineClosestPoint( 'sphere', 'line' ) );
  test.shouldThrowErrorSync( () => _.sphere.lineClosestPoint(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.sphere.lineClosestPoint( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.lineClosestPoint( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.lineClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.lineClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.lineClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], undefined ) );

}

//

function planeClosestPoint( test )
{
  /* */

  test.case = 'Source sphere and test plane remain unchanged';

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstPlane = [ 0, 1, 0, 0 ];
  var expected = 0;
  var gotClosestPoint = _.sphere.planeClosestPoint( srcSphere, tstPlane );
  test.identical( gotClosestPoint, expected );

  var oldSrcSphere = [ 0, 0, 0, 0 ];
  test.identical( srcSphere, oldSrcSphere );

  var oldTstPlane = [ 0, 1, 0, 0 ];
  test.identical( tstPlane, oldTstPlane );

  /* */

  test.case = 'Empty sphere in plane';

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstPlane = [ 0, 1, 0, 0 ];
  var expected = 0;
  var gotClosestPoint = _.sphere.planeClosestPoint( srcSphere, tstPlane );

  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Empty sphere not in plane';

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstPlane = [ 1, 1, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0 ] );
  var gotClosestPoint = _.sphere.planeClosestPoint( srcSphere, tstPlane );

  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Intersection';

  var srcSphere = [ 0, 0, 0, 2 ];
  var tstPlane = [ 1, 1, 0, 0 ];
  var expected = 0;
  var gotClosestPoint = _.sphere.planeClosestPoint( srcSphere, tstPlane );

  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Plane touches sphere';

  var srcSphere = [ 0, 0, 0, 1 ];
  var tstPlane = [ 1, 1, 0, 0 ];
  var expected = 0;
  var gotClosestPoint = _.sphere.planeClosestPoint( srcSphere, tstPlane );

  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Plane separate from sphere - plane under sphere';

  var srcSphere = [ 0, 0, 0, 1 ];
  var tstPlane = [ 3, 1, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ -1, 0, 0 ] );
  var gotClosestPoint = _.sphere.planeClosestPoint( srcSphere, tstPlane );

  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'Plane separate from sphere - plane over sphere';

  var srcSphere = [ 0, 0, 0, 1 ];
  var tstPlane = [ - 3, 1, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 1, 0, 0 ] );
  var gotClosestPoint = _.sphere.planeClosestPoint( srcSphere, tstPlane );

  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'DstPoint is array';

  var srcSphere = [ 2, 2, 0, 1 ];
  var tstPlane = [ 0, 1, 1, 0 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 1.2928932188134525, 1.2928932188134525, 0 ] );
  var gotClosestPoint = _.sphere.planeClosestPoint( srcSphere, tstPlane, dstPoint );

  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'DstPoint is vector';

  var srcSphere = [ 2, 2, 2, 1 ];
  var tstPlane = [ 0, 1, 1, 1 ];
  var dstPoint = _.vectorAdapter.fromLong( [ 0, 0, 0 ] );
  var expected = _.sphere.tools.vectorAdapter.fromLong( [ 1.4226497308103743, 1.4226497308103743, 1.4226497308103743 ] );
  var gotClosestPoint = _.sphere.planeClosestPoint( srcSphere, tstPlane, dstPoint );

  test.equivalent( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( 'sphereOne', 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( [ 1, 2, 3, 4 ], 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( 'sphereOne', [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( [ 1, 2, 3, 4 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( null, [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( [ 1, 2, 3, 4 ], NaN ) );
  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( NaN, [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( [ 1, 2, 3, 4 ] , [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( [ 1, 2, 3 ] , [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeClosestPoint( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] ) );

}

//

function planeExpand( test )
{
  /* */

  test.case = 'Source sphere and test plane remain unchanged';

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstPlane = [ 0, 1, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 0 ] );
  var gotExpand = _.sphere.planeExpand( srcSphere, tstPlane );
  test.identical( gotExpand, expected );

  var oldSrcSphere = [ 0, 0, 0, 0 ];
  test.identical( srcSphere, oldSrcSphere );

  var oldTstPlane = [ 0, 1, 0, 0 ];
  test.identical( tstPlane, oldTstPlane );

  /* */

  test.case = 'Empty sphere in plane - no expansion';

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstPlane = [ 0, 1, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 0 ] );
  var gotExpand = _.sphere.planeExpand( srcSphere, tstPlane );

  test.identical( gotExpand, expected );

  /* */

  test.case = 'Empty sphere not in plane - expansion';

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstPlane = [ 1, 1, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 1 ] );
  var gotExpand = _.sphere.planeExpand( srcSphere, tstPlane );

  test.identical( gotExpand, expected );

  /* */

  test.case = 'Intersection';

  var srcSphere = [ 0, 0, 0, 2 ];
  var tstPlane = [ 1, 1, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 2 ] );
  var gotExpand = _.sphere.planeExpand( srcSphere, tstPlane );

  test.identical( gotExpand, expected );

  /* */

  test.case = 'Plane touches sphere';

  var srcSphere = [ 0, 0, 0, 1 ];
  var tstPlane = [ 1, 1, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 1 ] );
  var gotExpand = _.sphere.planeExpand( srcSphere, tstPlane );

  test.identical( gotExpand, expected );

  /* */

  test.case = 'Plane separate from sphere - plane under sphere';

  var srcSphere = [ 0, 0, 0, 1 ];
  var tstPlane = [ 3, 1, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 3 ] );
  var gotExpand = _.sphere.planeExpand( srcSphere, tstPlane );

  test.equivalent( gotExpand, expected );

  /* */

  test.case = 'Plane separate from sphere - plane over sphere';

  var srcSphere = [ 0, 0, 0, 1 ];
  var tstPlane = [ - 3, 1, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 3 ] );
  var gotExpand = _.sphere.planeExpand( srcSphere, tstPlane );

  test.equivalent( gotExpand, expected );

  /* */

  test.case = 'Expansion 2D';

  var srcSphere = [ 2, 2, 0, 1 ];
  var tstPlane = [ 0, 1, 1, 0 ];
  var expected = _.sphere.tools.long.make( [ 2, 2, 0, 2.8284271247461903 ] );
  var gotExpand = _.sphere.planeExpand( srcSphere, tstPlane );

  test.equivalent( gotExpand, expected );

  /* */

  test.case = 'Expansion 3D';

  var srcSphere = [ 2, 2, 2, 1 ];
  var tstPlane = [ 0, 1, 1, 1 ];
  var expected = _.sphere.tools.long.make( [ 2, 2, 2, 3.4641016151377544 ] );
  var gotExpand = _.sphere.planeExpand( srcSphere, tstPlane );

  test.equivalent( gotExpand, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.planeExpand( ) );
  test.shouldThrowErrorSync( () => _.sphere.planeExpand( 'sphereOne', 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.planeExpand( [ 1, 2, 3, 4 ], 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.planeExpand( 'sphereOne', [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeExpand( null, [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeExpand( [ 1, 2, 3, 4 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.planeExpand( [ 1, 2, 3, 4 ], NaN ) );
  test.shouldThrowErrorSync( () => _.sphere.planeExpand( NaN, [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeExpand( [ 1, 2, 3, 4 ] , [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeExpand( [ 1, 2, 3 ] , [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeExpand( [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.planeExpand( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] ) );

}

//

function rayClosestPoint( test )
{

  /* */

  test.case = 'Source sphere and ray remain unchanged';

  var srcSphere = [ - 1, - 1, -1, 2 ];
  var tstRay = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotRay = _.sphere.rayClosestPoint( srcSphere, tstRay );
  test.identical( expected, gotRay );

  var oldSrcSphere = [ - 1, - 1, -1, 2 ];
  test.identical( srcSphere, oldSrcSphere );

  var oldTstRay = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( tstRay, oldTstRay );

  /* */

  test.case = 'sphere and ray intersect';

  var srcSphere = [ - 1, - 1, -1, 3 ];
  var tstRay = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotRay = _.sphere.rayClosestPoint( srcSphere, tstRay );
  test.identical( expected, gotRay );

  /* */

  test.case = 'Ray origin touches sphere';

  var srcSphere = [ - 1, - 1, -1, 1 ];
  var tstRay = [ -1, -1, 0, 0, 0, 1 ];
  var expected = 0;

  var gotRay = _.sphere.rayClosestPoint( srcSphere, tstRay );
  test.identical( expected, gotRay );

  /* */

  test.case = 'Ray and sphere don´t intersect';

  var srcSphere = [ - 1, - 1, -1, 1 ];
  var tstRay = [ - 1, -1, 2, 0, 0, 1 ];
  var expected = _.sphere.tools.long.make( [ - 1, - 1, 0 ] );

  var gotRay = _.sphere.rayClosestPoint( srcSphere, tstRay );
  test.identical( expected, gotRay );

  /* */

  test.case = 'Closest point in sphere side';

  var srcSphere = [ 0, 0, 0, 4 ];
  var tstRay = [ 5, 0, 0, 0, 1, 0 ];
  var expected = _.sphere.tools.long.make( [ 4, 0, 0 ] );

  var gotRay = _.sphere.rayClosestPoint( srcSphere, tstRay );
  test.identical( expected, gotRay );

  /* */

  test.case = 'dstPoint Array';

  var srcSphere = [ 0, 0, 0, 4 ];
  var tstRay = [ 5, 0, 0, 1, 0, 0 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 4, 0, 0 ] );

  var gotRay = _.sphere.rayClosestPoint( srcSphere, tstRay, dstPoint );
  test.identical( expected, gotRay );
  test.true( dstPoint === gotRay );

  /* */

  test.case = 'dstPoint Vector';

  var srcSphere = [ 0, 0, 0, 4 ];
  var tstRay = [ 0, 0, 5, 1, 0, 0 ];
  var dstPoint = _.vectorAdapter.from( [ 0, 0, 0 ] );
  var expected = _.sphere.tools.vectorAdapter.from( [ 0, 0, 4 ] );

  var gotRay = _.sphere.rayClosestPoint( srcSphere, tstRay, dstPoint );
  test.equivalent( expected, gotRay );
  test.true( dstPoint === gotRay );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.rayClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.sphere.rayClosestPoint( [] ) );
  test.shouldThrowErrorSync( () => _.sphere.rayClosestPoint( 'sphere', 'ray' ) );
  test.shouldThrowErrorSync( () => _.sphere.rayClosestPoint(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.sphere.rayClosestPoint( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.rayClosestPoint( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.rayClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.rayClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.rayClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], undefined ) );

}

//

function segmentContains( test )
{

  /* */

  test.case = 'Source sphere and segment remain unchanged';

  var srcSphere = [ - 1, - 1, -1, 2 ];
  var tstSegment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = false;

  var gotSegment = _.sphere.segmentContains( srcSphere, tstSegment );
  test.identical( expected, gotSegment );

  var oldSrcSphere = [ - 1, - 1, -1, 2 ];
  test.identical( srcSphere, oldSrcSphere );

  var oldTstSegment = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( tstSegment, oldTstSegment );

  /* */

  test.case = 'sphere and segment intersect';

  var srcSphere = [ - 1, - 1, -1, 3 ];
  var tstSegment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = false;

  var gotSegment = _.sphere.segmentContains( srcSphere, tstSegment );
  test.identical( expected, gotSegment );

  /* */

  test.case = 'Segment origin touches sphere';

  var srcSphere = [ - 1, - 1, -1, 1 ];
  var tstSegment = [ -1, -1, 0, 0, 0, 1 ];
  var expected = false;

  var gotSegment = _.sphere.segmentContains( srcSphere, tstSegment );
  test.identical( expected, gotSegment );

  /* */

  test.case = 'Segment and sphere don´t intersect';

  var srcSphere = [ - 1, - 1, -1, 2 ];
  var tstSegment = [ - 1, -1, 3, - 1, - 1, 2 ];
  var expected = false;

  var gotSegment = _.sphere.segmentContains( srcSphere, tstSegment );
  test.identical( expected, gotSegment );

  /* */

  test.case = 'Sphere contains segment';

  var srcSphere = [ 0, 0, 0, 2 ];
  var tstSegment = [ - 1, -1, -1, 1, 1, 1 ];
  var expected = true;

  var gotSegment = _.sphere.segmentContains( srcSphere, tstSegment );
  test.identical( expected, gotSegment );

  /* */

  test.case = 'Sphere contains segment - touching sides';

  var srcSphere = [ 0, 0, 0, Math.sqrt( 3 ) ];
  var tstSegment = [ - 1, -1, -1, 1, 1, 1 ];
  var expected = true;

  var gotSegment = _.sphere.segmentContains( srcSphere, tstSegment );
  test.identical( expected, gotSegment );

  /* */

  test.case = '2D - contained';

  var srcSphere = [ 3, 4, 8 ];
  var tstSegment = [ 3, 5, 2, 6 ];
  var expected = true;

  var gotSegment = _.sphere.segmentContains( srcSphere, tstSegment );
  test.identical( expected, gotSegment );

  /* */

  test.case = '2D - Not contained';

  var srcSphere = [ 6, 7, Math.sqrt( 3 ) ];
  var tstSegment = [ - 1, -1, 6, 0 ];
  var expected = false;

  var gotSegment = _.sphere.segmentContains( srcSphere, tstSegment );
  test.identical( expected, gotSegment );


  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.segmentContains( ) );
  test.shouldThrowErrorSync( () => _.sphere.segmentContains( [] ) );
  test.shouldThrowErrorSync( () => _.sphere.segmentContains( 'sphere', 'segment' ) );
  test.shouldThrowErrorSync( () => _.sphere.segmentContains(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.sphere.segmentContains( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.segmentContains( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.segmentContains( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.segmentContains( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.segmentContains( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], undefined ) );

}

//

function segmentClosestPoint( test )
{

  /* */

  test.case = 'Source sphere and segment remain unchanged';

  var srcSphere = [ - 1, - 1, -1, 2 ];
  var tstSegment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotSegment = _.sphere.segmentClosestPoint( srcSphere, tstSegment );
  test.identical( expected, gotSegment );

  var oldSrcSphere = [ - 1, - 1, -1, 2 ];
  test.identical( srcSphere, oldSrcSphere );

  var oldTstSegment = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( tstSegment, oldTstSegment );

  /* */

  test.case = 'sphere and segment intersect';

  var srcSphere = [ - 1, - 1, -1, 3 ];
  var tstSegment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotSegment = _.sphere.segmentClosestPoint( srcSphere, tstSegment );
  test.identical( expected, gotSegment );

  /* */

  test.case = 'Segment origin touches sphere';

  var srcSphere = [ - 1, - 1, -1, 1 ];
  var tstSegment = [ -1, -1, 0, 0, 0, 1 ];
  var expected = 0;

  var gotSegment = _.sphere.segmentClosestPoint( srcSphere, tstSegment );
  test.identical( expected, gotSegment );

  /* */

  test.case = 'Segment end touches sphere';

  var srcSphere = [ - 1, - 1, -1, 1 ];
  var tstSegment = [ -7, -1, -1, -1, -1, 0 ];
  var expected = 0;

  var gotSegment = _.sphere.segmentClosestPoint( srcSphere, tstSegment );
  test.identical( expected, gotSegment );


  /* */

  test.case = 'Negative factor - no intersection';

  var srcSphere = [ - 1, - 1, -1, 1 ];
  var tstSegment = [ - 1, -1, 2, -1, -1, 5 ];
  var expected = _.sphere.tools.long.make( [ -1, -1, 0 ] );

  var gotSegment = _.sphere.segmentClosestPoint( srcSphere, tstSegment );
  test.identical( expected, gotSegment );


  /* */

  test.case = 'Positive factor - no intersection';

  var srcSphere = [ - 1, - 1, -1, 1 ];
  var tstSegment = [ - 1, -1, -5, -1, -1, -3 ];
  var expected = _.sphere.tools.long.make( [ -1, -1, -2 ] );

  var gotSegment = _.sphere.segmentClosestPoint( srcSphere, tstSegment );
  test.identical( expected, gotSegment );

  /* */

  test.case = 'Segment and sphere don´t intersect';

  var srcSphere = [ - 1, - 1, -1, 2 ];
  var tstSegment = [ - 1, -1, 3, - 1, - 1, 2 ];
  var expected = _.sphere.tools.long.make( [ - 1, - 1, 1 ] );

  var gotSegment = _.sphere.segmentClosestPoint( srcSphere, tstSegment );
  test.identical( expected, gotSegment );

  /* */

  test.case = 'Closest point to segment side';

  var srcSphere = [ 0, 0, 0, 1 ];
  var tstSegment = [ 5, 2, 0, -5, 2, 0 ];
  var expected = _.sphere.tools.long.make( [ 0, 1, 0 ] );

  var gotSegment = _.sphere.segmentClosestPoint( srcSphere, tstSegment );
  test.identical( expected, gotSegment );

  /* */

  test.case = 'Closest point to sphere side';

  var srcSphere = [ 0, 0, 0, 1 ];
  var tstSegment = [ 3, 0, 0, 0, 3, 0 ];
  var expected = _.sphere.tools.long.make( [ 1/Math.sqrt( 2 ), 1/Math.sqrt( 2 ), 0 ] );

  var gotSegment = _.sphere.segmentClosestPoint( srcSphere, tstSegment );
  test.equivalent( expected, gotSegment );

  /* */

  test.case = 'dstPoint Array';

  var srcSphere = [ 0, 0, 0, 4 ];
  var tstSegment = [ 5, 0, 0, 6, 2, 0 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 4, 0, 0 ] );

  var gotSegment = _.sphere.segmentClosestPoint( srcSphere, tstSegment, dstPoint );
  test.identical( expected, gotSegment );
  test.true( dstPoint === gotSegment );

  /* */

  test.case = 'dstPoint Vector';

  var srcSphere = [ 0, 0, 0, 4 ];
  var tstSegment = [ 0, 0, 5, 1, 0, 7 ];
  var dstPoint = _.vectorAdapter.from( [ 0, 0, 0 ] );
  var expected = _.sphere.tools.vectorAdapter.from( [ 0, 0, 4 ] );

  var gotSegment = _.sphere.segmentClosestPoint( srcSphere, tstSegment, dstPoint );
  test.equivalent( expected, gotSegment );
  test.true( dstPoint === gotSegment );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.segmentClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.sphere.segmentClosestPoint( [] ) );
  test.shouldThrowErrorSync( () => _.sphere.segmentClosestPoint( 'sphere', 'segment' ) );
  test.shouldThrowErrorSync( () => _.sphere.segmentClosestPoint(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.sphere.segmentClosestPoint( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.segmentClosestPoint( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.segmentClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.segmentClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.segmentClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], undefined ) );

}

//

function sphereContains( test )
{
  /* */

  test.case = 'Source and test spheres remain unchanged';

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstSphere = [ 0, 0, 0, 0 ];
  var expected = true;
  var gotBool = _.sphere.sphereContains( srcSphere, tstSphere );
  test.identical( gotBool, expected );

  var oldSrcSphere = [ 0, 0, 0, 0 ];
  test.identical( srcSphere, oldSrcSphere );

  var oldTstSphere = [ 0, 0, 0, 0 ];
  test.identical( tstSphere, oldTstSphere );

  /* */

  test.case = 'Empty sphere contains empty sphere';

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstSphere = [ 0, 0, 0, 0 ];
  var expected = true;
  var gotBool = _.sphere.sphereContains( srcSphere, tstSphere );

  test.identical( gotBool, expected );

  /* */

  test.case = 'Same spheres';

  var srcSphere = [ 0, 1, 0, 2 ];
  var tstSphere = [ 0, 1, 0, 2 ];
  var expected = true;
  var gotBool = _.sphere.sphereContains( srcSphere, tstSphere );

  test.identical( gotBool, expected );

  /* */

  test.case = 'Trivial intersection - not contained';

  var srcSphere = [ - 1, 2, 0, 2 ];
  var tstSphere = [ 1, 3, 0, 2 ];
  var expected = false;
  var gotBool = _.sphere.sphereContains( srcSphere, tstSphere );

  test.identical( gotBool, expected );

  /* */

  test.case = 'Different radius - src > tst';

  var srcSphere = [ 1, 0, 0, 3 ];
  var tstSphere = [ 1, 0, 0, 2 ];
  var expected = true;
  var gotBool = _.sphere.sphereContains( srcSphere, tstSphere );

  test.identical( gotBool, expected );

  /* */

  test.case = 'Different radius - tst > src';

  var srcSphere = [ 1, 0, 0, 2 ];
  var tstSphere = [ 1, 0, 0, 3 ];
  var expected = false;
  var gotBool = _.sphere.sphereContains( srcSphere, tstSphere );

  test.identical( gotBool, expected );

  /* */

  test.case = 'Just touching';

  var srcSphere = [ - 1, 0, 0, 1 ];
  var tstSphere = [ 1, 0, 0, 1 ];
  var expected = false;
  var gotBool = _.sphere.sphereContains( srcSphere, tstSphere );

  test.identical( gotBool, expected );

  /* */

  test.case = 'Not intersecting';

  var srcSphere = [ - 1.5, 0, 0, 1 ];
  var tstSphere = [ 1.5, 0, 0, 1 ];
  var expected = false;
  var gotBool = _.sphere.sphereContains( srcSphere, tstSphere );

  test.identical( gotBool, expected );

  /* */

  test.case = 'One inside another different centers';

  var srcSphere = [ 0, 0, 0, 3 ];
  var tstSphere = [ 1, 1, 1, 1 ];
  var expected = true;
  var gotBool = _.sphere.sphereContains( srcSphere, tstSphere );

  test.identical( gotBool, expected );

  test.case = 'src is nil';

  var srcSphere = _.sphere.makeSingular();
  var tstSphere = [ 0, 0, 0, 2 ];
  var expected = false;
  var gotBool = _.sphere.sphereContains( srcSphere, tstSphere );

  test.identical( gotBool, expected );

  test.case = 'tst is nil';

  var srcSphere = [ 0, 0, 0, 2 ];
  var tstSphere = _.sphere.makeSingular();
  var expected = true;
  var gotBool = _.sphere.sphereContains( srcSphere, tstSphere );

  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.sphereContains( ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereContains( 'sphereOne', 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereContains( [ 1, 2, 3, 4 ], 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereContains( 'sphereOne', [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereContains( [ 1, 2, 3, 4 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereContains( null, [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereContains( [ 1, 2, 3, 4 ], NaN ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereContains( NaN, [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereContains( [ 1, 2, 3, 4 ] , [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereContains( [ 1, 2, 3 ] , [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereContains( [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereContains( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] ) );

}

//

function sphereIntersects( test )
{

  /* */

  test.case = 'Intersection of empty spheres';

  var sphere = [ 0, 0, 0, 0 ];
  var sphere2 = [ 0, 0, 0, 0 ];
  var expected = true;
  var gotBool = _.sphere.sphereIntersects( sphere, sphere2 );

  test.identical( gotBool, expected );

  /* */

  test.case = 'Trivial intersection';

  var sphere = [ - 1, 2, 0, 2 ];
  var sphere2 = [ 1, 3, 0, 2 ];
  var expected = true;
  var gotBool = _.sphere.sphereIntersects( sphere, sphere2 );

  test.identical( gotBool, expected );

  /* */

  test.case = 'Different radius';

  var sphere = [ - 1, 0, 0, 3 ];
  var sphere2 = [ 1, 0, 0, 2 ];
  var expected = true;
  var gotBool = _.sphere.sphereIntersects( sphere, sphere2 );

  test.identical( gotBool, expected );

  /* */

  test.case = 'Just touching';

  var sphere = [ - 1, 0, 0, 1 ];
  var sphere2 = [ 1, 0, 0, 1 ];
  var expected = true;
  var gotBool = _.sphere.sphereIntersects( sphere, sphere2 );

  test.identical( gotBool, expected );

  /* */

  test.case = 'Not intersecting';

  var sphere = [ - 1.5, 0, 0, 1 ];
  var sphere2 = [ 1.5, 0, 0, 1 ];
  var expected = false;
  var gotBool = _.sphere.sphereIntersects( sphere, sphere2 );

  test.identical( gotBool, expected );

  /* */

  test.case = 'One inside another';

  var sphere = [ 0, 0, 0, 3 ];
  var sphere2 = [ 0, 0, 0, 1 ];
  var expected = true;
  var gotBool = _.sphere.sphereIntersects( sphere, sphere2 );

  test.identical( gotBool, expected );

  /* */

  test.case = 'One inside another different centers';

  var sphere = [ 0, 0, 0, 3 ];
  var sphere2 = [ 1, 1, 1, 3 ];
  var expected = true;
  var gotBool = _.sphere.sphereIntersects( sphere, sphere2 );

  test.identical( gotBool, expected );

  test.case = 'dst is nil';

  var sphere = _.sphere.makeSingular();
  var sphere2 = [ 0, 0, 0, 2 ];
  var expected = true;
  var gotBool = _.sphere.sphereIntersects( sphere, sphere2 );

  test.identical( gotBool, expected );

  test.case = 'src is nil';

  var sphere = _.sphere.makeSingular();
  var sphere2 = [ 0, 0, 0, 2 ];
  var expected = true;
  var gotBool = _.sphere.sphereIntersects( sphere, sphere2 );

  test.identical( gotBool, expected );

  test.case = 'dst and src are nil';

  var sphere = _.sphere.makeSingular();
  var sphere2 = _.sphere.makeSingular();
  var expected = true;
  var gotBool = _.sphere.sphereIntersects( sphere, sphere2 );

  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.sphereIntersects( ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereIntersects( 'sphereOne', 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereIntersects( [ 1, 2, 3, 4 ], 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereIntersects( 'sphereOne', [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereIntersects( [ 1, 2, 3, 4 ] , [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereIntersects( [ 1, 2, 3 ] , [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereIntersects( [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereIntersects( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] ) );

}

//

function sphereDistance( test )
{
  /* */

  test.case = 'Source and test spheres remain unchanged';

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstSphere = [ 0, 0, 0, 0 ];
  var expected = 0;
  var gotDistance = _.sphere.sphereDistance( srcSphere, tstSphere );
  test.identical( gotDistance, expected );

  var oldSrcSphere = [ 0, 0, 0, 0 ];
  test.identical( srcSphere, oldSrcSphere );

  var oldTstSphere = [ 0, 0, 0, 0 ];
  test.identical( tstSphere, oldTstSphere );

  /* */

  test.case = 'Empty spheres';

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstSphere = [ 0, 0, 0, 0 ];
  var expected = 0;
  var gotDistance = _.sphere.sphereDistance( srcSphere, tstSphere );

  test.identical( gotDistance, expected );

  /* */

  test.case = 'Same spheres';

  var srcSphere = [ 0, 1, 0, 2 ];
  var tstSphere = [ 0, 1, 0, 2 ];
  var expected = 0;
  var gotDistance = _.sphere.sphereDistance( srcSphere, tstSphere );

  test.identical( gotDistance, expected );

  /* */

  test.case = 'Intersection';

  var srcSphere = [ - 1, 2, 0, 2 ];
  var tstSphere = [ 1, 3, 0, 2 ];
  var expected = 0;
  var gotDistance = _.sphere.sphereDistance( srcSphere, tstSphere );

  test.identical( gotDistance, expected );

  /* */

  test.case = 'Different centers 1D';

  var srcSphere = [ 2, 0, 0, 1 ];
  var tstSphere = [ -2, 0, 0, 1 ];
  var expected = 2;
  var gotDistance = _.sphere.sphereDistance( srcSphere, tstSphere );

  test.identical( gotDistance, expected );

  /* */

  test.case = 'Different centers 2D';

  var srcSphere = [ 2, 2, 0, 1 ];
  var tstSphere = [ -2, -2, 0, 1 ];
  var expected = Math.sqrt( 32 ) - 2;
  var gotDistance = _.sphere.sphereDistance( srcSphere, tstSphere );

  test.equivalent( gotDistance, expected );

  /* */

  test.case = 'Different centers 3D';

  var srcSphere = [ 2, 2, 2, 1 ];
  var tstSphere = [ -2, -2, -2, 1 ];
  var expected = Math.sqrt( 48 ) - 2;
  var gotDistance = _.sphere.sphereDistance( srcSphere, tstSphere );

  test.equivalent( gotDistance, expected );

  /* */

  test.case = 'Different centers - different radius';

  var srcSphere = [ 2, 0, 0, 1 ];
  var tstSphere = [ -2, 0, 0, 2 ];
  var expected = 1;
  var gotDistance = _.sphere.sphereDistance( srcSphere, tstSphere );

  test.identical( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( 'sphereOne', 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( [ 1, 2, 3, 4 ], 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( 'sphereOne', [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( [ 1, 2, 3, 4 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( null, [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( [ 1, 2, 3, 4 ], NaN ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( NaN, [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( [ 1, 2, 3, 4 ] , [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( [ 1, 2, 3 ] , [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereDistance( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] ) );

}

//

function sphereClosestPoint( test )
{
  /* */

  test.case = 'Source and test spheres remain unchanged';

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstSphere = [ 0, 0, 0, 0 ];
  var expected = 0;
  var gotClosestPoint = _.sphere.sphereClosestPoint( srcSphere, tstSphere );
  test.identical( gotClosestPoint, expected );

  var oldSrcSphere = [ 0, 0, 0, 0 ];
  test.identical( srcSphere, oldSrcSphere );

  var oldTstSphere = [ 0, 0, 0, 0 ];
  test.identical( tstSphere, oldTstSphere );

  /* */

  test.case = 'Empty spheres';

  var srcSphere = [ 0, 0, 0, 0 ];
  var tstSphere = [ 0, 0, 0, 0 ];
  var expected = 0;
  var gotClosestPoint = _.sphere.sphereClosestPoint( srcSphere, tstSphere );

  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Same spheres';

  var srcSphere = [ 0, 1, 0, 2 ];
  var tstSphere = [ 0, 1, 0, 2 ];
  var expected = 0;
  var gotClosestPoint = _.sphere.sphereClosestPoint( srcSphere, tstSphere );

  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Intersection';

  var srcSphere = [ - 1, 2, 0, 2 ];
  var tstSphere = [ 1, 3, 0, 2 ];
  var expected = 0;
  var gotClosestPoint = _.sphere.sphereClosestPoint( srcSphere, tstSphere );

  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Different centers 1D';

  var srcSphere = [ 2, 0, 0, 1 ];
  var tstSphere = [ -2, 0, 0, 1 ];
  var expected = _.sphere.tools.long.make( [ 1, 0, 0 ] );
  var gotClosestPoint = _.sphere.sphereClosestPoint( srcSphere, tstSphere );

  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'Different centers 2D';

  var srcSphere = [ 2, 2, 0, 1 ];
  var tstSphere = [ -2, -2, 0, 1 ];
  var expected = _.sphere.tools.long.make( [ 1.2928932188134525, 1.2928932188134525, 0 ] );
  var gotClosestPoint = _.sphere.sphereClosestPoint( srcSphere, tstSphere );

  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'Different centers 3D';

  var srcSphere = [ 2, 2, 2, 1 ];
  var tstSphere = [ -2, -2, -2, 1 ];
  var expected = _.sphere.tools.long.make( [ 1.4226497308103743, 1.4226497308103743, 1.4226497308103743 ] );
  var gotClosestPoint = _.sphere.sphereClosestPoint( srcSphere, tstSphere );

  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'Different centers - different radius 1D';

  var srcSphere = [ 2, 0, 0, 1 ];
  var tstSphere = [ -2, 0, 0, 2 ];
  var expected = _.sphere.tools.long.make( [ 1, 0, 0 ] );
  var gotClosestPoint = _.sphere.sphereClosestPoint( srcSphere, tstSphere );

  test.identical( gotClosestPoint, expected );

  /* */

  test.case = 'DstPoint is array';

  var srcSphere = [ 2, 2, 0, 1 ];
  var tstSphere = [ -2, -2, 0, 2 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 1.2928932188134525, 1.2928932188134525, 0 ] );
  var gotClosestPoint = _.sphere.sphereClosestPoint( srcSphere, tstSphere, dstPoint );

  test.equivalent( gotClosestPoint, expected );

  /* */

  test.case = 'DstPoint is vector';

  var srcSphere = [ 2, 2, 2, 1 ];
  var tstSphere = [ -2, -2, -2, 1 ];
  var dstPoint = _.vectorAdapter.fromLong( [ 0, 0, 0 ] );
  var expected = _.sphere.tools.vectorAdapter.fromLong( [ 1.4226497308103743, 1.4226497308103743, 1.4226497308103743 ] );
  var gotClosestPoint = _.sphere.sphereClosestPoint( srcSphere, tstSphere, dstPoint );

  test.equivalent( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( 'sphereOne', 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( [ 1, 2, 3, 4 ], 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( 'sphereOne', [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( [ 1, 2, 3, 4 ], null ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( null, [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( [ 1, 2, 3, 4 ], NaN ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( NaN, [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( [ 1, 2, 3, 4 ] , [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( [ 1, 2, 3 ] , [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereClosestPoint( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] ) );

}

//

function sphereExpand( test )
{

  test.case = 'trivial';

  var s1 = [ -2, 0, 0, 1 ];
  var s2 = [ +2, 0, 0, 1 ];

  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 3 ] );
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.true( got === s1 );

  test.case = 'different radius';

  var s1 = [ -2, 0, 0, 2 ];
  var s2 = [ +2, 0, 0, 1 ];
  var expected = _.sphere.tools.long.make( [ -0.5, 0, 0, 3.5 ] );
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.true( got === s1 );

  test.case = 'different radius, one inside of another 1';

  var s1 = [ -2, 0, 0, 3 ];
  var s2 = [ 0, 0, 0, 1 ];
  var expected = _.sphere.tools.long.make( [ -2, 0, 0, 3 ] );
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.true( got === s1 );

  test.case = 'different radius, one inside of another 2';

  var s1 = [ -2, 0, 0, 3 ];
  var s2 = [ +0, 0, 0, 0.5 ];
  var expected = _.sphere.tools.long.make( [ -2, 0, 0, 3 ] );
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.true( got === s1 );

  test.case = 'different radius, overlap';

  var s1 = [ -2, 0, 0, 3 ];
  var s2 = [ +1, 0, 0, 2 ];
  var expected = _.sphere.tools.long.make( [ -1, 0, 0, 4 ] );
  var got = _.sphere.sphereExpand( s1, s2 );

  test.equivalent( got, expected );
  test.true( got === s1 );

  test.case = 'different radius, overlap';

  var s1 = [ 1, 2, 3, 5 ];
  var s2 = [ -1, -2, -3, 5 ];
  var expected = _.sphere.tools.long.make( [ 6.372004368593309e-8, 1.2744008737186618e-7, 1.9116013127984388e-7, 8.741657257080078 ] );
  var got = _.sphere.sphereExpand( s1, s2 );

  test.equivalent( got, expected );
  test.true( got === s1 );

  test.case = 'empty by identity';

  var s1 = [ 0, 0, 0, 0 ];
  var s2 = [ 0, 0, 0, 1 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 1 ] );
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.true( got === s1 );

  test.case = 'empty by empty at zero';

  var s1 = [ 0, 0, 0, 0 ];
  var s2 = [ 0, 0, 0, 0 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 0 ] );
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.true( got === s1 );

  test.case = 'empty by empty not at zero';

  var s1 = [ 0, 0, 0, 0 ];
  var s2 = [ 1, 1, 1, 0 ];
  var expected = _.sphere.tools.long.make( [ 0.5, 0.5, 0.5, 0.8660253882408142 ] );
  var got = _.sphere.sphereExpand( s1, s2 );

  test.equivalent( got, expected );
  test.true( got === s1 );

  test.case = 'overlap';

  var s1 = [ -3, 0, 0, 3 ];
  var s2 = [ +1, 0, 0, 2 ];
  var expected = _.sphere.tools.long.make( [ -1.5, 0, 0, 4.5 ] );
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.true( got === s1 );

  test.case = 'inside, different centers';

  var s1 = [ 0, 0, 0, 5 ];
  var s2 = [ 1, 1, 1, 2 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 5 ] );
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.true( got === s1 );

  test.case = 'inside, same centers';

  var s1 = [ 0, 0, 0, 5 ];
  var s2 = [ 0, 0, 0, 2 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 5 ] );
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.true( got === s1 );

  test.case = 'dst is nil';

  var s1 = _.sphere.makeSingular();
  var s2 = [ 0, 0, 0, 2 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 2 ] );
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.true( got === s1 );

  test.case = 'src is nil';

  var s1 = [ 0, 0, 0, 2 ];
  var s2 = _.sphere.makeSingular();
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 2 ] );
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.true( got === s1 );

  test.case = 'dst and src are nil';

  var s1 = _.sphere.makeSingular();
  var s2 = _.sphere.makeSingular();
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, -Infinity ] );
  var got = _.sphere.sphereExpand( s1, s2 );

  test.identical( got, expected );
  test.true( got === s1 );

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.sphere.sphereExpand( ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereExpand( 'sphereOne', 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereExpand( [ 1, 2, 3, 4 ], 'sphereTwo' ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereExpand( 'sphereOne', [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereExpand( [ 1, 2, 3, 4 ] , [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereExpand( [ 1, 2, 3 ] , [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereExpand( [ 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.sphere.sphereExpand( [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] , [ 1, 2, 3, 4 ] ) );

}

//

function sphereExpandExtended( test )
{
  test.case = 'same center, same radius'
  var s1 = [ 0, 0, 0, 1 ];
  var s2 = [ 0, 0, 0, 1 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 1 ] );
  var got = _.sphere.sphereExpand( s1, s2 );
  test.identical( got, expected );

  test.case = 'same center, diff radius'
  var s1 = [ 0, 0, 0, 1 ];
  var s2 = [ 0, 0, 0, 2 ];
  var expected = _.sphere.tools.long.make( [ 0, 0, 0, 2 ] );
  var got = _.sphere.sphereExpand( s1, s2 );
  test.identical( got, expected );

  test.case = 'diff center, same radius'
  var s1 = [ 0, 0, 0, 1 ];
  var s2 = [ 2, 0, 0, 1 ];
  var expected = _.sphere.tools.long.make( [ 1, 0, 0, 2 ] );
  var got = _.sphere.sphereExpand( s1, s2 );
  test.identical( got, expected );

  test.case = 'diff center, diff radius'
  var s1 = [ 0, 0, 0, 1 ]
  var s2 = [ 5, 5, 0, 3 ]
  var expected = _.sphere.tools.long.make( [ 3.207106781367236, 3.207106781367236, 0, 5.535533905029297 ] );
  var got = _.sphere.sphereExpand( s1, s2 );
  test.identical( got, expected );

  test.case = 'diff center, diff radius, enclosed'
  var s1 = [ 4, 5, 0, 1 ]
  var s2 = [ 5, 5, 0, 3 ]
  var expected = _.sphere.tools.long.make( [ 5, 5, 0, 3 ] );
  var got = _.sphere.sphereExpand( s1, s2 );
  test.identical( got, expected );

  test.case = 'diff center, diff radius, enclosed'
  var s1 = [ 4, 5, 0, 10 ]
  var s2 = [ 5, 5, 0, 3 ]
  var expected = _.sphere.tools.long.make( [ 4, 5, 0, 10 ] );
  var got = _.sphere.sphereExpand( s1, s2 );
  test.identical( got, expected );

  test.case = 'diff center, diff radius, intersection'
  var s1 = [ 0, 0, 0, 1 ]
  var s2 = [ 1, 0, 0, 1 ]
  var expected = _.sphere.tools.long.make( [ 0.5, 0, 0, 1.5 ] );
  var got = _.sphere.sphereExpand( s1, s2 );
  test.identical( got, expected );
}

// --
// declare
// --

const Proto =
{

  name : 'Tools.Math.Sphere',
  silencing : 1,

  tests :
  {

    make,
    makeZero,
    makeSingular,

    zero,
    nil,
    centeredOfRadius,

    fromPoints,
    fromBox,
    fromCenterAndRadius,

    is,
    isEmpty,
    isZero,
    isNil,

    dimGet,
    centerGet,
    radiusGet,
    radiusSet,

    project,
    getProjectionFactors,

    pointContains,
    pointDistance,
    pointClosestPoint,
    pointExpand,

    boxContains,
    boxIntersects,
    boxClosestPoint,
    boxExpand,
    boundingBoxGet,

    capsuleContains,
    capsuleClosestPoint,

    convexPolygonContains,
    convexPolygonClosestPoint,

    frustumContains,
    frustumDistance,
    frustumClosestPoint,
    frustumExpand,

    lineClosestPoint,

    planeClosestPoint,
    planeExpand,

    rayClosestPoint,

    segmentContains,
    segmentClosestPoint,

    sphereContains,
    sphereIntersects,
    sphereDistance,
    sphereClosestPoint,
    sphereExpand,
    sphereExpandExtended

  }

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
