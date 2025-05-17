( function _AxisAndAngle_test_s_( ) {

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
const Parent = wTester;

var avector = _.avector;
var vector = _.vectorAdapter;
var pi = Math.PI;
var sin = Math.sin;
var cos = Math.cos;
var atan2 = Math.atan2;
var asin = Math.asin;
var sqr = _.math.sqr;
var sqrt = _.math.sqrt;
var clamp = _.math.clamp;

_.assert( _.routineIs( sqrt ) );

// --
// context
// --

function eachAngle( o )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.routine.options_( eachAngle, o );

  if( o.representations === null )
  o.representations = [ 'xyz', 'xzy', 'yxz', 'yzx', 'zxy', 'zyx', 'xyx', 'xzx', 'yxy', 'yzy', 'zxz', 'zyz' ];
  if( o.angles === null )
  o.angles = [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ];
  if( o.anglesLocked === null )
  o.anglesLocked = [ 0, Math.PI / 3 ];
  if( o.quadrants === null )
  o.quadrants = [ 0, 1, 2, 3 ];
  if( o.quadrantsLocked === null )
  o.quadrantsLocked = [ 0 ];
  if( o.deltasLocked === null )
  o.deltasLocked = [ 0 ];

  var euler = _.euler.from( o.dst );
  for( var r = 0; r < o.representations.length; r++ )
  {
    var representation = o.representations[ r ];
    _.euler.representationSet( euler, representation );
    for( var ang1 = 0; ang1 < o.angles.length; ang1++ )
    {
      for( var quad1 = 0; quad1 < o.quadrants.length; quad1++ )
      {
        for( var d = 0; d < o.deltas.length; d++ )
        {
          euler[ 0 ] = o.angles[ ang1 ] + o.quadrants[ quad1 ]*Math.PI/2 + o.deltas[ d ];
          for( var ang2 = ang1; ang2 < o.angles.length; ang2++ )
          {
            for( var quad2 = quad1; quad2 < o.quadrants.length; quad2++ )
            {
              for( var d2 = 0; d2 < o.deltas.length; d2++ )
              {
                euler[ 1 ] = o.angles[ ang2 ] + o.quadrants[ quad2 ]*Math.PI/2 + o.deltas[ d2 ];
                for( var ang3 = 0; ang3 < o.anglesLocked.length; ang3++ )
                {
                  for( var quad3 = 0; quad3 < o.quadrantsLocked.length; quad3++ )
                  {
                    for( var d3 = 0; d3 < o.deltasLocked.length; d3++ )
                    {
                      euler[ 2 ] = o.anglesLocked[ ang3 ] + o.quadrantsLocked[ quad3 ]*Math.PI/2 + o.deltasLocked[ d3 ];
                      o.onEach( euler );
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

}

eachAngle.defaults =
{
  representations : null,
  angles : null,
  anglesLocked : null,
  quadrants : null,
  quadrantsLocked : null,
  deltas : null,
  deltasLocked : null,
  onEach : null,
  dst : null,
  // representations : [ 'xyz', 'xzy', 'yxz', 'yzx', 'zxy', 'zyx', 'xyx', 'xzx', 'yxy', 'yzy', 'zxz', 'zyz' ],
  // angles : [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ],
  // anglesLocked : [ 0, Math.PI / 3 ],
  // quadrants : [ 0, 1, 2, 3 ],
  // quadrantsLocked : [ 0 ],
  // deltas : null,
  // deltasLocked : [ 0 ],
  // onEach : null,
  // dst : null,
}

// --
// test
// --

function is( test )
{

  /* */

  test.case = 'array';

  test.true( !_.axisAndAngle.is([]) );
  test.true( !_.axisAndAngle.is([ 0 ]) );
  test.true( !_.axisAndAngle.is([ 0, 0 ]) );

  test.true( !_.axisAndAngle.is([ 0, 0, 0 ]) );
  test.true( _.axisAndAngle.is( [ 0, 0, 0 ], 0 ) );
  test.true( !_.axisAndAngle.is( [ 0, 0, 0 ], null ) );
  test.true( !_.axisAndAngle.is( null, 0 ) );
  test.true( !_.axisAndAngle.is( null, null ) );

  test.true( _.axisAndAngle.is([ 0, 0, 0, 0 ]) );
  test.true( !_.axisAndAngle.is( [ 0, 0, 0, 0 ], 0 ) );
  test.true( !_.axisAndAngle.is( [ 0, 0, 0, 0 ], null ) );

  test.true( !_.axisAndAngle.is([ 0, 0, 0, 0, 0 ]) );
  test.true( !_.axisAndAngle.is([ 0, 0, 0, 0, 0, 0 ]) );
  test.true( !_.axisAndAngle.is([ 1, 2, 3, 0, 1, 2 ]) );
  test.true( !_.axisAndAngle.is([ 0, 0, 0, 0, 0, 0, 0 ]) );

  /* */

  test.case = 'vector';

  test.true( !_.axisAndAngle.is( _.axisAndAngle.tools.vectorAdapter.fromLong([]) ) );
  test.true( !_.axisAndAngle.is( _.axisAndAngle.tools.vectorAdapter.fromLong([ 0 ]) ) );
  test.true( !_.axisAndAngle.is( _.axisAndAngle.tools.vectorAdapter.fromLong([ 0, 0 ]) ) );

  test.true( !_.axisAndAngle.is( _.axisAndAngle.tools.vectorAdapter.fromLong([ 0, 0, 0 ]) ) );
  test.true( _.axisAndAngle.is( _.axisAndAngle.tools.vectorAdapter.fromLong( [ 0, 0, 0 ]), 0 ) );
  test.true( !_.axisAndAngle.is( _.axisAndAngle.tools.vectorAdapter.fromLong( [ 0, 0, 0 ]), null ) );

  test.true( _.axisAndAngle.is( _.axisAndAngle.tools.vectorAdapter.fromLong( [ 0, 0, 0, 0 ]) ) );
  test.true( !_.axisAndAngle.is( _.axisAndAngle.tools.vectorAdapter.fromLong( [ 0, 0, 0, 0 ] ), 0 ) );
  test.true( !_.axisAndAngle.is( _.axisAndAngle.tools.vectorAdapter.fromLong( [ 0, 0, 0, 0 ] ), null ) );

  test.true( !_.axisAndAngle.is( _.axisAndAngle.tools.vectorAdapter.fromLong([ 0, 0, 0, 0, 0 ]) ) );
  test.true( !_.axisAndAngle.is( _.axisAndAngle.tools.vectorAdapter.fromLong([ 0, 0, 0, 0, 0, 0 ]) ) );
  test.true( !_.axisAndAngle.is( _.axisAndAngle.tools.vectorAdapter.fromLong([ 1, 2, 3, 0, 1, 2 ]) ) );
  test.true( !_.axisAndAngle.is( _.axisAndAngle.tools.vectorAdapter.fromLong([ 0, 0, 0, 0, 0, 0, 0 ]) ) );

  /* */

  test.case = 'not axisAndAngle';

  test.true( !_.axisAndAngle.is( 'abcdef' ) );
  test.true( !_.axisAndAngle.is( {} ) );
  test.true( !_.axisAndAngle.is( function( a, b, c, d, e, f ){} ) );

}

//

function like( test )
{

  /* */

  test.case = 'array';

  test.true( !_.axisAndAngle.isWithAngle([]) );
  test.true( !_.axisAndAngle.isWithAngle([ 0 ]) );
  test.true( !_.axisAndAngle.isWithAngle([ 0, 0 ]) );

  test.true( !_.axisAndAngle.isWithAngle([ 0, 0, 0 ]) );
  test.true( _.axisAndAngle.isWithAngle( [ 0, 0, 0 ], 0 ) );
  test.true( _.axisAndAngle.isWithAngle( [ 0, 0, 0 ], null ) );
  test.true( _.axisAndAngle.isWithAngle( null, 0 ) );
  test.true( _.axisAndAngle.isWithAngle( null, null ) );

  test.true( _.axisAndAngle.isWithAngle([ 0, 0, 0, 0 ]) );
  test.true( !_.axisAndAngle.isWithAngle( [ 0, 0, 0, 0 ], 0 ) );
  test.true( !_.axisAndAngle.isWithAngle( [ 0, 0, 0, 0 ], null ) );

  test.true( !_.axisAndAngle.isWithAngle([ 0, 0, 0, 0, 0 ]) );
  test.true( !_.axisAndAngle.isWithAngle([ 0, 0, 0, 0, 0, 0 ]) );
  test.true( !_.axisAndAngle.isWithAngle([ 1, 2, 3, 0, 1, 2 ]) );
  test.true( !_.axisAndAngle.isWithAngle([ 0, 0, 0, 0, 0, 0, 0 ]) );

  /* */

  test.case = 'vector';

  test.true( !_.axisAndAngle.isWithAngle( _.axisAndAngle.tools.vectorAdapter.fromLong([]) ) );
  test.true( !_.axisAndAngle.isWithAngle( _.axisAndAngle.tools.vectorAdapter.fromLong([ 0 ]) ) );
  test.true( !_.axisAndAngle.isWithAngle( _.axisAndAngle.tools.vectorAdapter.fromLong([ 0, 0 ]) ) );

  test.true( !_.axisAndAngle.isWithAngle( _.axisAndAngle.tools.vectorAdapter.fromLong([ 0, 0, 0 ]) ) );
  test.true( _.axisAndAngle.isWithAngle( _.axisAndAngle.tools.vectorAdapter.fromLong( [ 0, 0, 0 ]), 0 ) );
  test.true( _.axisAndAngle.isWithAngle( _.axisAndAngle.tools.vectorAdapter.fromLong( [ 0, 0, 0 ]), null ) );

  test.true( _.axisAndAngle.isWithAngle( _.axisAndAngle.tools.vectorAdapter.fromLong( [ 0, 0, 0, 0 ]) ) );
  test.true( !_.axisAndAngle.isWithAngle( _.axisAndAngle.tools.vectorAdapter.fromLong( [ 0, 0, 0, 0 ] ), 0 ) );
  test.true( !_.axisAndAngle.isWithAngle( _.axisAndAngle.tools.vectorAdapter.fromLong( [ 0, 0, 0, 0 ] ), null ) );

  test.true( !_.axisAndAngle.isWithAngle( _.axisAndAngle.tools.vectorAdapter.fromLong([ 0, 0, 0, 0, 0 ]) ) );
  test.true( !_.axisAndAngle.isWithAngle( _.axisAndAngle.tools.vectorAdapter.fromLong([ 0, 0, 0, 0, 0, 0 ]) ) );
  test.true( !_.axisAndAngle.isWithAngle( _.axisAndAngle.tools.vectorAdapter.fromLong([ 1, 2, 3, 0, 1, 2 ]) ) );
  test.true( !_.axisAndAngle.isWithAngle( _.axisAndAngle.tools.vectorAdapter.fromLong([ 0, 0, 0, 0, 0, 0, 0 ]) ) );

  /* */

  test.case = 'not axisAndAngle';

  test.true( !_.axisAndAngle.isWithAngle( 'abcdef' ) );
  test.true( !_.axisAndAngle.isWithAngle( {} ) );
  test.true( !_.axisAndAngle.isWithAngle( function( a, b, c, d, e, f ){} ) );

}

//

function isZero( test )
{

  /* */

  test.case = 'zero';

  test.true( _.axisAndAngle.isZero([ 0, 0, 0, 0 ]) );
  test.true( _.axisAndAngle.isZero([ 0, 1, 0, 0 ]) );
  test.true( _.axisAndAngle.isZero([ 0, 0, 1, 0 ]) );
  test.true( _.axisAndAngle.isZero([ 0, 0, 0, 1 ]) );

  test.true( _.axisAndAngle.isZero( [ 0, 0, 1 ], 0 ) );

  /* */

  test.case = 'not zero';

  test.true( !_.axisAndAngle.isZero([ +0.1, 0, 0, 0 ]) );
  test.true( !_.axisAndAngle.isZero([ +0.1, 1, 0, 0 ]) );
  test.true( !_.axisAndAngle.isZero([ +0.1, 0, 1, 0 ]) );
  test.true( !_.axisAndAngle.isZero([ +0.1, 0, 0, 1 ]) );
  test.true( !_.axisAndAngle.isZero([ -0.1, 1, 0, 0 ]) );
  test.true( !_.axisAndAngle.isZero([ -0.1, 0, 1, 0 ]) );
  test.true( !_.axisAndAngle.isZero([ -0.1, 0, 0, 1 ]) );

  test.true( !_.axisAndAngle.isZero([ 0, 0, 0 ], +0.1 ) );
  test.true( !_.axisAndAngle.isZero([ 1, 0, 0 ], +0.1 ) );
  test.true( !_.axisAndAngle.isZero([ 0, 1, 0 ], +0.1 ) );
  test.true( !_.axisAndAngle.isZero([ 0, 0, 1 ], +0.1 ) );
  test.true( !_.axisAndAngle.isZero([ 1, 0, 0 ], -0.1 ) );
  test.true( !_.axisAndAngle.isZero([ 0, 1, 0 ], -0.1 ) );
  test.true( !_.axisAndAngle.isZero([ 0, 0, 1 ], -0.1 ) );

  test.true( !_.axisAndAngle.isZero( [ 0, 0, 1 ], null ) );
  test.true( !_.axisAndAngle.isZero( null, 0 ) );
  test.true( !_.axisAndAngle.isZero( null, null ) );

  test.true( !_.axisAndAngle.isZero( [ 0, 0, 0, 1 ], null ) );
  test.true( !_.axisAndAngle.isZero( [ 0, 0, 0, 1 ], 0 ) );

}

//

function make( test )
{

  /* */

  test.case = 'src undefined';

  var src = undefined;
  var got = _.axisAndAngle.make( src );
  var expected = _.axisAndAngle.tools.long.make( [ 0, 0, 0, 0 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src null';

  var src = null;
  var got = _.axisAndAngle.make( src );
  var expected = _.axisAndAngle.tools.long.make( [ 0, 0, 0, 0, ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src array';

  var src = [ 5, 0, 1, 2 ];
  var got = _.axisAndAngle.make( src );
  var expected = _.axisAndAngle.tools.long.make( [ 5, 0, 1, 2 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src array and angle';

  var src = [ 0, 1, 2 ];
  var got = _.axisAndAngle.make( src, 5 );
  var expected = _.axisAndAngle.tools.long.make( [ 5, 0, 1, 2 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src vector';

  var src = _.axisAndAngle.tools.vectorAdapter.fromLong([ 5, 0, 1, 2 ]);
  var got = _.axisAndAngle.make( src );
  var expected = _.axisAndAngle.tools.long.make( [ 5, 0, 1, 2 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src vector';

  var src = _.axisAndAngle.tools.vectorAdapter.fromLong([ 0, 1, 2 ]);
  var got = _.axisAndAngle.make( src, 5 );
  var expected = _.axisAndAngle.tools.long.make( [ 5, 0, 1, 2 ] );
  test.identical( got, expected );
  test.true( got !== src );

  if( !Config.debug )
  return;

  /* */

  test.case = 'bad arguments';

  test.shouldThrowErrorSync( () => _.axisAndAngle.make( 0 ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.make( 4 ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.make( '4' ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.make( [ 0, 0, 0, 0 ], 2 ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.make( [ 0, 0, 0 ], 2, 2 ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.make( [ 0, 0, 0 ] ) );

}

//

function makeZero( test )
{

  /* */

  test.case = 'trivial';

  var got = _.axisAndAngle.makeZero();
  var expected = _.axisAndAngle.tools.long.make( [ 0, 0, 0, 0 ] );
  test.identical( got, expected );

  if( !Config.debug )
  return;

  /* */

  test.case = 'bad arguments';

  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero( undefined ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero( null ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero( 4 ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero([ 0, 0, 0 ], 1) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero([ 0, 0, 0, 0 ]) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero([ 0, 0, 0, 0, 1, 2 ]) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero( '4' ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero( [ 0, 0, 0, 0, 1, 2 ], 2 ) );

}

//

function from( test )
{

  /* */

  test.case = 'from null';

  var src = null;
  var got = _.axisAndAngle.from( src );
  var expected = _.axisAndAngle.tools.long.make( [ 0, 0, 0, 0 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'from null and null';

  var src = null;
  var got = _.axisAndAngle.from( src, null );
  var expected = _.axisAndAngle.tools.long.make( [ 0, 0, 0, 0 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'from null and angle';

  var src = null;
  var got = _.axisAndAngle.from( src, 3 );
  var expected = _.axisAndAngle.tools.long.make( [ 3, 0, 0, 0 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'from array and null';

  var src = [ 0, 1, 2 ];
  var got = _.axisAndAngle.from( src, null );
  var expected = _.axisAndAngle.tools.long.make( [ 0, 0, 1, 2 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'from array';

  var src = [ 3, 0, 1, 2 ];
  var got = _.axisAndAngle.from( src );
  var expected = _.axisAndAngle.tools.long.make( [ 3, 0, 1, 2 ] );
  test.identical( got, expected );
  test.true( got === src );

  /* */

  test.case = 'from array and angle';

  var src = [ 0, 1, 2 ];
  var got = _.axisAndAngle.from( src, 3 );
  var expected = _.axisAndAngle.tools.long.make( [ 3, 0, 1, 2 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'from vector';

  var src = _.axisAndAngle.tools.vectorAdapter.from([ 3, 0, 1, 2 ]);
  var got = _.axisAndAngle.from( src );
  var expected = _.axisAndAngle.tools.vectorAdapter.from([ 3, 0, 1, 2 ]);
  test.identical( got, expected );
  test.true( got === src );

  /* */

  test.case = 'from vector and angle';

  var src = _.axisAndAngle.tools.vectorAdapter.from([ 0, 1, 2 ]);
  var got = _.axisAndAngle.from( src, 3 );
  var expected = _.axisAndAngle.tools.long.make( [ 3, 0, 1, 2 ] );
  test.identical( got, expected );
  test.true( got !== src );

  if( !Config.debug )
  return;

  /* */

  test.case = 'bad arguments';

  test.shouldThrowErrorSync( () => _.axisAndAngle.from() );
  test.shouldThrowErrorSync( () => _.axisAndAngle.from( undefined ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.from( null, null, null ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.from( [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.from( [ 1, 2, 3, 4, 5 ] ) );

  test.shouldThrowErrorSync( () => _.axisAndAngle.from( 'abcd' ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.from( {} ) );

}

//

function adapterFrom( test )
{

  /* */

  test.case = 'adapterFrom null';

  var src = null;
  var got = _.axisAndAngle.adapterFrom( src );
  var expected = _.axisAndAngle.tools.vectorAdapter.from([ 0, 0, 0, 0 ]);
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'adapterFrom null and null';

  var src = null;
  var got = _.axisAndAngle.adapterFrom( src, null );
  var expected = _.axisAndAngle.tools.vectorAdapter.from([ 0, 0, 0, 0 ]);
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'adapterFrom null and angle';

  var src = null;
  var got = _.axisAndAngle.adapterFrom( src, 3 );
  var expected = _.axisAndAngle.tools.vectorAdapter.from([ 3, 0, 0, 0 ]);
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'adapterFrom array and null';

  var src = [ 0, 1, 2 ];
  var got = _.axisAndAngle.adapterFrom( src, null );
  var expected = _.axisAndAngle.tools.vectorAdapter.from([ 0, 0, 1, 2 ]);
  test.identical( got, expected );
  test.true( got !== src );
  test.true( got._vectorBuffer !== src );
  test.true( !!got._vectorBuffer );

  /* */

  test.case = 'adapterFrom array';

  var src = [ 3, 0, 1, 2 ];
  var got = _.axisAndAngle.adapterFrom( src );
  var expected = _.axisAndAngle.tools.vectorAdapter.from([ 3, 0, 1, 2 ]);
  test.identical( got, expected );
  test.true( got !== src );
  test.true( got._vectorBuffer === src );
  test.true( !!got._vectorBuffer );

  /* */

  test.case = 'adapterFrom array and angle';

  var src = [ 0, 1, 2 ];
  var got = _.axisAndAngle.adapterFrom( src, 3 );
  var expected = _.axisAndAngle.tools.vectorAdapter.from([ 3, 0, 1, 2 ]);
  test.identical( got, expected );
  test.true( got !== src );
  test.true( got._vectorBuffer !== src );
  test.true( !!got._vectorBuffer );

  /* */

  test.case = 'adapterFrom vector';

  var src = _.axisAndAngle.tools.vectorAdapter.from([ 3, 0, 1, 2 ]);
  var got = _.axisAndAngle.adapterFrom( src );
  var expected = _.axisAndAngle.tools.vectorAdapter.from([ 3, 0, 1, 2 ]);
  test.identical( got, expected );
  test.true( got === src );

  /* */

  test.case = 'adapterFrom vector and angle';

  var src = _.axisAndAngle.tools.vectorAdapter.from([ 0, 1, 2 ]);
  var got = _.axisAndAngle.adapterFrom( src, 3 );
  var expected = _.axisAndAngle.tools.vectorAdapter.from([ 3, 0, 1, 2 ]);
  test.identical( got, expected );
  test.true( got !== src );
  test.true( got._vectorBuffer !== src );
  test.true( !!got._vectorBuffer );

  if( !Config.debug )
  return;

  /* */

  test.case = 'bad arguments';

  test.shouldThrowErrorSync( () => _.axisAndAngle.adapterFrom() );
  test.shouldThrowErrorSync( () => _.axisAndAngle.adapterFrom( undefined ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.adapterFrom( null, null, null ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.adapterFrom( [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.adapterFrom( [ 1, 2, 3, 4, 5 ] ) );

  test.shouldThrowErrorSync( () => _.axisAndAngle.adapterFrom( _.axisAndAngle.tools.vectorAdapter.from([ 1, 2, 3 ]) ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.adapterFrom( _.axisAndAngle.tools.vectorAdapter.from([ 1, 2, 3, 4, 5 ]) ) );

  test.shouldThrowErrorSync( () => _.axisAndAngle.adapterFrom( 'abcd' ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.adapterFrom( {} ) );

}

//

function zero( test )
{

  /* */

  test.case = 'src undefined';

  var src = undefined;
  var got = _.axisAndAngle.zero( src );
  var expected = _.axisAndAngle.tools.long.make( [ 0, 0, 0, 0 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'src null';

  var src = null;
  var got = _.axisAndAngle.zero( src );
  var expected = _.axisAndAngle.tools.long.make( [ 0, 0, 0, 0 ] );
  test.identical( got, expected );
  test.true( got !== src );

  /* */

  test.case = 'dst array';

  var dst = [ 5, 0, 1, 2 ];
  var got = _.axisAndAngle.zero( dst );
  var expected = _.axisAndAngle.tools.long.make( [ 0, 0, 1, 2 ] );
  test.identical( got, expected );
  test.true( got === dst );

  /* */

  test.case = 'dst vector';

  var dst = _.axisAndAngle.tools.vectorAdapter.fromLong([ 5, 0, 1, 2 ]);
  var got = _.axisAndAngle.zero( dst );
  var expected = _.axisAndAngle.tools.vectorAdapter.fromLong([ 0, 0, 1, 2 ]);
  test.identical( got, expected );
  test.true( got === dst );

  if( !Config.debug )
  return;

  /* */

  test.case = 'bad arguments';

  test.shouldThrowErrorSync( () => _.axisAndAngle.zero( 4 ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.zero([ 0, 0, 0 ]) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.zero( '4' ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.zero( [ 0, 0, 0, 5, 5, 5 ], 2 ) );

}

//

function eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatFast( test )
{

  var accuracy =  test.accuracy;
  var accuracySqr = test.accuracy*test.accuracy;
  var accuracySqrt = Math.sqrt( test.accuracy );
  var euler = _.euler.make();
  var quat1 = _.quat.make();
  var matrix = _.Matrix.MakeZero( [ 3, 3 ] );
  var quat2 = _.quat.make();
  var quat2b = _.quat.make();
  var axisAngle1 = _.axisAndAngle.makeZero();
  var axisAngle2 = _.axisAndAngle.makeZero();

  // var deltas = [ -0.1, -accuracySqrt, -accuracySqr, 0, +accuracySqr, +accuracySqrt, +0.1 ];
  // var deltas = [ -accuracySqr, 0, +accuracySqr, +accuracySqrt, +0.1 ];
  var deltas = [ -accuracySqr, 0, +accuracySqr, +0.1 ];
  var angles = [ 0, Math.PI / 6, Math.PI / 4 ];
  // var anglesLocked = [ 0, Math.PI / 3 ];
  var anglesLocked = [ Math.PI / 3 ];

  /* */

  var o =
  {
    deltas,
    angles,
    anglesLocked,
    onEach,
    dst : euler,
  }

  this.eachAngle( o );

  /* */

  function onEach( euler )
  {
    quat1 = _.euler.toQuat2( euler, quat1 );
    axisAngle1 = _.quat.toAxisAndAngle( quat1, axisAngle1 );
    matrix = _.axisAndAngle.toMatrixRotation( axisAngle1, matrix );
    axisAngle2 = _.axisAndAngle.fromMatrixRotation( axisAngle2, matrix );
    quat2 = _.quat.fromAxisAndAngle( quat2, axisAngle2 );

    var positiveResult = quat2;
    var negativeResult = _.avector.mul( _.avector.assign( quat2b, quat2 ), -1 );
    var eq = false;
    eq = eq || _.entityEquivalent( positiveResult, quat1, { accuracy : test.accuracy } );
    eq = eq || _.entityEquivalent( negativeResult, quat1, { accuracy : test.accuracy } );
    test.true( eq );
  }

}

eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatFast.timeOut = 60000;
eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatFast.usingSourceCode = 0;
eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatFast.rapidity = -1;

//

function eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatSlow( test )
{

  var accuracy =  test.accuracy;
  var accuracySqr = test.accuracy*test.accuracy;
  var accuracySqrt = Math.sqrt( test.accuracy );
  var euler = _.euler.make();
  var quat1 = _.quat.make();
  var matrix = _.Matrix.MakeZero( [ 3, 3 ] );
  var quat2 = _.quat.make();
  var quat2b = _.quat.make();
  var axisAngle1 = _.axisAndAngle.makeZero();
  var axisAngle2 = _.axisAndAngle.makeZero();

  var deltas = [ -0.1, -accuracySqrt, -accuracySqr, 0, +accuracySqr, +accuracySqrt, +0.1 ];
  var angles = [ 0, Math.PI / 6, Math.PI / 4, Math.PI/6 ];
  // var anglesLocked = [ 0, Math.PI / 3 ];
  var anglesLocked =  [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ];

  /* */

  var o =
  {
    deltas,
    angles,
    anglesLocked,
    onEach,
    dst : euler,
  }

  this.eachAngle( o );

  /* */

  function onEach( euler )
  {
    quat1 = _.euler.toQuat2( euler, quat1 );
    axisAngle1 = _.quat.toAxisAndAngle( quat1, axisAngle1 );
    matrix = _.axisAndAngle.toMatrixRotation( axisAngle1, matrix );
    axisAngle2 = _.axisAndAngle.fromMatrixRotation( axisAngle2, matrix );
    quat2 = _.quat.fromAxisAndAngle( quat2, axisAngle2 );

    var positiveResult = quat2;
    var negativeResult = _.avector.mul( _.avector.assign( quat2b, quat2 ), -1 );
    var eq = false;
    eq = eq || _.entityEquivalent( positiveResult, quat1, { accuracy : test.accuracy } );
    eq = eq || _.entityEquivalent( negativeResult, quat1, { accuracy : test.accuracy } );
    test.true( eq );
  }

}

eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatSlow.timeOut = 300000;
eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatSlow.usingSourceCode = 0;
eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatSlow.rapidity = -2;

// --
// declare
// --

const Proto =
{

  name : 'Tools.Math.AxisAndAngle',
  silencing : 1,
  enabled : 1,
  // routine : 'eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatSlow',

  context :
  {
    eachAngle,
  },

  tests :
  {

    is,
    like,
    isZero,

    make,
    makeZero,

    from,
    adapterFrom,

    zero,

    /* takes 6 seconds */
    eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatFast,
    /* takes  seconds */
    eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatSlow,

  },

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
