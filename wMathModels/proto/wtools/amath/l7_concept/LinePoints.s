(function _LinePoints_s_(){

'use strict';

const _ = _global_.wTools;
_.linePoints = _.linePoints || Object.create( _.avector );

/**
 * @description
 * A line defined by two points.
 *
 * For the following functions, lines must have the shape [ X1, Y1, Z1, X2, Y2, Z2 ],
 * where the dimension equals the long's length divided by two.
 *
 * @namespace wTools.linePoints
  * @module Tools/math/Concepts
 */

// --
// implementation
// --

function make( dim )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = this.makeZero( dim );
  if( this.is( dim ) )
  this.tools.avector.assign( result, dim );
  return result;
}

//

function makeZero( dim )
{
  if( this.is( dim ) )
  dim = this.dimGet( dim );
  if( dim === undefined || dim === null )
  dim = 2;
  _.assert( dim >= 0 );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = _.dup( 0, dim * 2 )
  return result;
}

//

function from( pair )
{

  _.assert( this.is( pair ) || pair === null );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( pair === null )
  return this.make();

  return pair;
}

//

function adapterFrom( points )
{
  _.assert( this.is( points ) );
  _.assert( arguments.length === 1, 'Expects single argument' );
  return this.tools.vectorAdapter.from( points );
}

//

/**
  * Check if input is a line by two points. Returns true if it is a line and false if not.
  *
  * @param { Vector } line - Source line points.
  *
  * @example
  * // returns true;
  * _.linePoints.is( [ 0, 0, 1, 1 ] );
  * // returns false;
  * _.linePoints.is( [ 0,0 ] );
  *
  * @returns { Boolean } Returns true if the input is line by two points.
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  @namespace wTools.linePoints
  * @module Tools/math/Concepts
*/

function is( linePoints )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return ( _.longIs( linePoints ) || _.vectorAdapterIs( linePoints ) ) && ( linePoints.length % 2 === 0 ) && ( linePoints.length >= 4 );
}

//

/**
  * Get line dimension. Returns the dimension of the line. Line stays untouched.
  *
  * @param { Vector } linePoints - The source points.
  *
  * @example
  * // returns 2
  * _.linePoints.dimGet( [ 0, 0, 0, 0 ] );
  *
  * @returns { Number } Returns the dimension of the line.
  * @function dimGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( linePoints ) is not a line.
  @namespace wTools.linePoints
  * @module Tools/math/Concepts
  */

function dimGet( linePoints )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( this.is( linePoints ) );
  return linePoints.length / 2;
}

//

function firstPointGet( points )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  let pointsView = this.adapterFrom( points );
  return pointsView.review([ 0, points.length / 2 - 1 ]);
}

//

function secondPointGet( points )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  let pointsView = this.adapterFrom( points );
  return pointsView.review([ points.length / 2, points.length - 1 ]);
}

//

function fromRay( ray )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( this.tools.ray.is( ray ) );

  return this.tools.ray.toLinePoints( ray );
}

//

function fromLineImplicit( lineImplicit )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( this.tools.lineImplicit.is( lineImplicit ) );

  let lineView = this.tools.lineImplicit.adapterFrom( lineImplicit.slice() );
  let w = lineView.eGet( 0 );
  let a = lineView.eGet( 1 );
  let b = lineView.eGet( 2 );

  let m = -( a/b );
  b = -( w/b );

  let points = this.make();

  points[ 0 ] = -m * b / ( m * m + 1 );
  points[ 1 ] = b / ( m * m + 1 );

  points[ 2 ] = points[ 0 ];
  points[ 3 ] = points[ 1 ];

  if( points[ 2 ] === 0 )
  points[ 2 ] += ( -b * a + 1 );

  if( points[ 3 ] === 0 )
  points[ 3 ] += ( -b * a + 1 );

  return points;
}

//

function pairAt( pair, factor )
{
  _.assert( arguments.length === 2 );
  _.assert( this.is( pair ) );

  let d = this.dimGet( pair );

  let pair1View = this.tools.vectorAdapter.fromLongLrange( pair, 0, d );
  let pair2View = this.tools.vectorAdapter.fromLongLrange( pair, d, d );

  let a = this.tools.vectorAdapter.mul( null, pair1View, 1-factor );
  let b = this.tools.vectorAdapter.mul( null, pair2View, factor );

  let result = this.tools.vectorAdapter.add( a, b );

  return result;
}

pairAt.shaderChunk =
`
  vec2 pairAt( vec2 pair[ 2 ], float factor )
  {

    vec2 a = pair[ 0 ] * ( 1.0-factor );
    vec2 b = pair[ 1 ] * factor;
    vec2 result = a + b;

    return result;
  }
`

//

function pairPairParallel( pair1, pair2 )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let ray1 = this.tools.ray.fromPair2( pair1 );
  let ray2 = this.tools.ray.fromPair2( pair2 );
  return this.tools.ray.rayParallel( ray1, ray2 );
}

pairPairParallel.shaderChunk =
`
  vec2 pairPairParallel( vec2 p1[ 2 ], vec2 p2[ 2 ] )
  {

    vec2 r1[ 2 ], r2[ 2 ];
    ray_fromPair( r1, p1 );
    ray_fromPair( r2, p2 );

    return rayRayParallel( r1, r2 );
  }
`

//

function pairIntersectionFactors( pair1, pair2 )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let ray1 = this.tools.ray.fromPair2( pair1 );
  let ray2 = this.tools.ray.fromPair2( pair2 );
  return this.tools.ray.rayIntersectionFactors( ray1, ray2 );
}

pairIntersectionFactors.shaderChunk =
`
  vec2 pairPairIntersectionFactors( vec2 p1[ 2 ], vec2 p2[ 2 ] )
  {

    vec2 r1[ 2 ], r2[ 2 ];
    ray_fromPair( r1, p1 );
    ray_fromPair( r2, p2 );

    return ray_rayIntersectionFactors( r1, r2 );
  }
`

pairIntersectionFactors.shaderChunkName = 'pairPairIntersectionFactors'

//


function pairIntersectionPoint( pair1, pair2 )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let ray1 = this.tools.ray.fromPair2( pair1 );
  let ray2 = this.tools.ray.fromPair2( pair2 );
  return this.tools.ray.rayIntersectionPoint( ray1, ray2 );
}

pairIntersectionPoint.shaderChunk =
`
  vec2 pairPairIntersectionPoint( vec2 p1[ 2 ], vec2 p2[ 2 ] )
  {

    vec2 r1[ 2 ], r2[ 2 ];
    ray_fromPair( r1, p1 );
    ray_fromPair( r2, p2 );

    return ray_rayIntersectionPoint( r1, r2 );
  }
`
pairIntersectionPoint.shaderChunkName = 'pairPairIntersectionPoint'

//


function pairIntersectionPointAccurate( pair1, pair2 )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let ray1 = this.tools.ray.fromPair2( pair1 );
  let ray2 = this.tools.ray.fromPair2( pair2 );
  return this.tools.ray.rayIntersectionPointAccurate( ray1, ray2 );
}

pairIntersectionPointAccurate.shaderChunk =
`
  vec2 pairPairIntersectionPointAccurate( vec2 p1[ 2 ], vec2 p2[ 2 ] )
  {

    vec2 r1[ 2 ], r2[ 2 ];
    ray_fromPair( r1, p1 );
    ray_fromPair( r2, p2 );

    return ray_rayIntersectionPointAccurate( r1, r2 );
  }
`

pairIntersectionPointAccurate.shaderChunkName = 'pairPairIntersectionPointAccurate'


//

function injectChunks( routines )
{
  let Chunks = _._chunk = _._chunk || Object.create( null );

  for( let r in routines )
  {
    let routine = routines[ r ];

    if( !_.routineIs( routine ) )
    continue;

    if( !routine.shaderChunk )
    continue;

    _.assert( _.strIs( routine.shaderChunk ) );

    let shaderChunk = '';
    shaderChunk += '\n' + routine.shaderChunk + '\n';

    let chunkName = routine.shaderChunkName || r;

    Chunks[ chunkName ] = shaderChunk;

  }

}

//

/**
  * Routine pointDistance() gets the distance between a point and a line. Returns the calculated distance. Point and line stay untouched.
  *
  * @param { Array } srcLine - The source line.
  * @param { Array } srcPoint - The source point.
  *
  * @example
  * // returns 0
  * _.pointDistance( [ 0, 0, 0, 2 ], [ 0, 0 ] );
  *
  * @example
  * // returns 1.
  * _.pointDistance( [ 0, 0, 0, 2 ], [ 2, 0 ] );
  *
  * @returns { Number } - Returns the distance between the point and the line.
  * @function pointDistance
  * @throws { Error } An Error if ( dim ) is different than point.length (line and point have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcPoint ) is not point.
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */

function pointDistance( srcLine, srcPoint ) /* Dmytro : it's very bad implementation, but very simple and faster, needs to rewrite */
{
  if( srcLine === null )
  srcLine = this.make( srcPoint.length );
  else
  srcLine = this.make( srcLine );
  srcLine = _.linePointDir.make( srcLine );

  return _.linePointDir.pointDistance( srcLine, srcPoint );
}

// --
// declare
// --


let Extension = /* qqq xxx : normalize order */
{
  make,
  makeZero,

  from,
  adapterFrom,

  is,
  dimGet,

  firstPointGet,
  secondPointGet,

  fromRay,
  fromLineImplicit,

  pairAt,

  pairPairParallel,
  pairIntersectionFactors,
  pairIntersectionPoint,
  pairIntersectionPointAccurate,

  pointDistance,

  // ref

  tools : _,
}

/* _.props.extend */Object.assign( _.linePoints, Extension );
injectChunks( Extension );

})();
