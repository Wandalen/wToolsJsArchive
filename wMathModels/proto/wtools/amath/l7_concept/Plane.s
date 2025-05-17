(function _Plane_s_() {

'use strict';

const _ = _global_.wTools;
_.plane = _.plane || Object.create( _.avector );

/**
 * A plane is a flat surface represented by an equation Ax + By + Cz = D,
 * where x, y and z represent the 3 axes( for 3D ).
 *
 * For the following functions, planes must have the shape `[ A, B, ... , D ]`,
 * where the dimension equals the long's length minus one.
 *
 * @namespace wTools.plane
  * @module Tools/math/Concepts
 */

// --
//
// --

function make( dim )
{
  if( dim === undefined )
  dim = 3;
  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( _.numberIs( dim ) );
  let dst = _.dup( 0, dim+1 );
  return dst;
}

//

function adapterFrom( plane )
{
  _.assert( this.is( plane ) );
  _.assert( _.vectorAdapterIs( plane ) || _.longIs( plane ) );
  _.assert( arguments.length === 1, 'Expects single argument' );
  return this.tools.vectorAdapter.from( plane );
}

//

function is( plane )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return ( _.longIs( plane ) || _.vectorAdapterIs( plane ) ) && plane.length >= 1;
}

//


/**
  * Create a plane from another plane or a normal and a bias. Returns the new plane.
  * Planes are stored in Array data structure. Source plane/Normal and bias stay untouched, dst plane changes.
  *
  * @param { Array } dstplane - Destination plane to be expanded.
  * @param { Array } srcplane - Source plane.
  * Alternative to srcplane:
  * @param { Array } normal - Array of points with normal vector coordinates.
  * @param { Number } bias - Number with bias value.
  *
  * @example
  * // returns [ 0, 0, 1, 2 ];
  * _.from( [ 0, 0, 0, 0 ] , [ 0, 0, 1, 2 ] );
  *
  * @example
  * // returns [ 0, - 1, 2, 2 ];
  * _.from( [ 0, 0, 1, 1 ], [ 0, - 1, 2 ], 2 );
  *
  * @returns { Array } Returns the array of the new plane.
  * @function from
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( normal ) is not array.
  * @throws { Error } An Error if ( bias ) is not number.
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function from( plane )
{

  if( plane === null )
  {
    let d = this.dimGet( arguments[ 1 ] );
    plane = this.make( d );
  }

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  debugger;
  // throw _.err( 'not tested' );

  let planeView = this.adapterFrom( plane );
  let normal = this.normalGet( planeView );
  let bias = this.biasGet( planeView );

  if( arguments.length === 2 )
  {
    debugger;
  //  throw _.err( 'not tested' );
    this.tools.avector.assign( planeView, arguments[ 1 ] )
  }
  else if( arguments.length === 3 )
  {
    debugger;
  //  throw _.err( 'not tested' );
    this.tools.avector.assign( normal, this.tools.vectorAdapter.from( arguments[ 1 ] ) );
    this.biasSet( planeView, arguments[ 2 ] );
  }
  else _.assert( 0, 'unexpected arguments' );

  return plane;
}

//

/**
  * Create a plane from a normal and a point. Returns the new plane.
  * Planes are stored in Array data structure. Normal and point stay untouched, plane changes.
  *
  * @param { Array } plane - Plane to be modified.
  * @param { Array } anormal - Array of points with normal vector coordinates.
  * @param { Array } abias - Array with point coordinates.
  *
  * @example
  * // returns [ 0, 0, 1, 2 ];
  * _.fromNormalAndPoint( [ 0, 0, 0, 0 ] , [ 0, 0, 1 ], [ 2, 0, 0 ] );
  *
  * @returns { Array } Returns the array of the new plane.
  * @function fromNormalAndPoint
  * @throws { Error } An Error if ( arguments.length ) is different than three.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( anormal ) is not array.
  * @throws { Error } An Error if ( apoint ) is not a point.
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function fromNormalAndPoint( plane, anormal, apoint )
{

  if( plane === null )
  plane = this.make();

  let planeView = this.adapterFrom( plane );
  let normal = this.normalGet( planeView );
  let bias = this.biasGet( planeView );

  _.assert( arguments.length === 3, 'Expects exactly three arguments' );
  debugger;
  //throw _.err( 'not tested' );

  debugger;
  normal.copy( anormal );
  this.biasSet( plane , - this.tools.vectorAdapter.dot( this.tools.vectorAdapter.from( apoint ) , normal ) );

  return plane;
}

//

/**
  * Create a plane from three points. Returns the new plane.
  * Planes are stored in Array data structure. The points remain untouched, plane changes.
  *
  * @param { Array } plane - Plane to be modified.
  * @param { Array } a - First point in the new plane.
  * @param { Array } b - Second point in the new plane.
  * @param { Array } c - Third point in the new plane.
  *
  * @example
  * // returns [ 0, 1, 0, 0 ];
  * _.fromPoints( null, [ 0, 0, 0 ] , [ 0, 0, 1 ], [ 2, 0, 0 ] );
  *
  * @returns { Array } Returns the array of the new plane.
  * @function fromPoints
  * @throws { Error } An Error if ( arguments.length ) is different than four.
  * @throws { Error } An Error if ( dim ) point dimension is different than three.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( a ) is not a point.
  * @throws { Error } An Error if ( b ) is not a point.
  * @throws { Error } An Error if ( c ) is not a point.
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function fromPoints( plane, a, b, c )
{
  if( arguments.length === 3 )
  {
    _.assert( a.length === b.length );
    _.assert( a.length == 2 );

    let srcPoint1View = this.tools.vectorAdapter.from( a );
    let srcPoint2View = this.tools.vectorAdapter.from( b );

    if( plane === null )
    plane = this.tools.vectorAdapter.make( 3 );

    _.assert( this.dimGet( plane ) === 2 );

    let planeView = this.adapterFrom( plane );

    //(𝑦𝐴−𝑦𝐵)𝑥 − (𝑥𝐴−𝑥𝐵)𝑦 + 𝑥𝐴𝑦𝐵 − 𝑥𝐵𝑦𝐴 = 0

    planeView.eSet( 0, srcPoint2View.eGet( 1 ) * srcPoint1View.eGet( 0 ) - srcPoint2View.eGet( 0 ) * srcPoint1View.eGet( 1 ) )
    planeView.eSet( 1, srcPoint1View.eGet( 1 ) - srcPoint2View.eGet( 1 ) )
    planeView.eSet( 2, srcPoint2View.eGet( 0 ) - srcPoint1View.eGet( 0 ) )

    return plane;
  }

  if( plane === null )
  plane = this.make();

  let planeView = this.adapterFrom( plane );
  let normal = this.normalGet( planeView );
  let bias = this.biasGet( planeView );

  _.assert( arguments.length === 4 );
  debugger;
  //throw _.err( 'not tested' );

  a = this.tools.vectorAdapter.from( a );
  b = this.tools.vectorAdapter.from( b );
  c = this.tools.vectorAdapter.from( c );

  let n1 = this.tools.vectorAdapter.sub( a.clone() , b );
  let n2 = this.tools.vectorAdapter.sub( c.clone() , b );
  normal = this.tools.vectorAdapter.cross( n1, n2 );
  debugger;
  normal.normalize();

  this.fromNormalAndPoint( plane, normal, a );

  return plane;
}

fromPoints.shaderChunk =
`
  vec3 lineImplicit_eqWithPoints( vec2 point1, vec2 point2 )
  {
    vec3 result;

    result[ 0 ] = point2[ 1 ] * point1[ 0 ] - point2[ 0 ] * point1[ 1 ];
    result[ 1 ] = point1[ 1 ] - point2[ 1 ];
    result[ 2 ] = point2[ 0 ] - point1[ 0 ];

    return result;
  }
`
fromPoints.shaderChunkName = 'lineImplicit_eqWithPoints';

//

function fromPointAndTangent( srcPoint, tangent )
{
  _.assert( arguments.length === 2 );
  _.assert( srcPoint.length === tangent.length );
  _.assert( srcPoint.length === 2 );

  let srcPointView = this.tools.vectorAdapter.from( srcPoint );
  let tangentView = this.tools.vectorAdapter.from( tangent );

  let result = this.tools.vectorAdapter.make( 3 );

  result.eSet( 1, - tangentView.eGet( 1 ) );
  result.eSet( 2, + tangentView.eGet( 0 ) );
  result.eSet( 0, ( srcPointView.eGet( 1 ) + tangentView.eGet( 1 ) ) * srcPointView.eGet( 0 ) );
  result.eSet( 0, result.eGet( 0 ) - ( srcPointView.eGet( 0 ) + tangentView.eGet( 0 ) ) * srcPointView.eGet( 1 ) )

  // result[ 0 ] = - tangent[ 1 ];
  // result[ 1 ] = + tangent[ 0 ];
  // result[ 2 ] = ( point[ 1 ]+tangent[ 1 ] ) * point[ 0 ] - ( point[ 0 ]+tangent[ 0 ] ) * point[ 1 ];

  return result;
}

fromPointAndTangent.shaderChunk =
`
  vec3 lineImplicit_eqWithPointAndTangent( vec2 point, vec2 tangent )
  {
    vec3 result;

    result[ 1 ] = - tangent[ 1 ];
    result[ 2 ] = + tangent[ 0 ];
    result[ 0 ] = ( point[ 1 ]+tangent[ 1 ] ) * point[ 0 ] - ( point[ 0 ]+tangent[ 0 ] ) * point[ 1 ];

    return result;
  }
`
fromPointAndTangent.shaderChunkName = 'lineImplicit_eqWithPointAndTangent';


//

function dimGet( plane )
{
  let dim = plane.length - 1;

  _.assert( this.is( plane ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  debugger;

  return dim;
}

//

function normalGet( plane )
{
  let planeView = this.adapterFrom( plane );
  _.assert( arguments.length === 1, 'Expects single argument' );
  // return planeView.review([ 0, planeView.length - 2 ]);
  return planeView.review([ 1, planeView.length - 1 ]);
}

//

function biasGet( plane )
{
  let planeView = this.adapterFrom( plane );
  _.assert( arguments.length === 1, 'Expects single argument' );
  // return planeView.eGet( planeView.length-1 );
  return planeView.eGet( 0 );
}

//

function biasSet( plane, bias )
{
  let planeView = this.adapterFrom( plane );

  _.assert( _.numberIs( bias ) );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  debugger;
  //throw _.err( 'not tested' );

  // return planeView.eSet( planeView.length-1, bias );
  return planeView.eSet( 0, bias );}

//

/**
  * Check if a plane contains a point. Returns true if the point is contained.
  * The point an the plane remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Vector } point - Source point.
  *
  * @example
  * // returns false;
  * _.pointsDistance( [ 0, 1, 0, 1 ] , this.tools.vectorAdapter.from( [ 0, 0, 1 ] ) );
  *
  * @returns { Boolean } Returns true if the plane contains the point and false if not.
  * @function pointContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( point ) is not a vector.
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */

function pointContains( plane , point )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let planeView = this.adapterFrom( plane );
  let pointVector = this.tools.vectorAdapter.from( point );

  // if( Math.abs( this.pointDistance( plane, pointVector ) ) < /* 1E-7 */this.tools.accuracy )
  if( this.tools.avector.isLessAprox( Math.abs( this.pointDistance( plane, pointVector ) ), this.tools.accuracy ) )
  return true;
  else
  return false;
}

//

/**
  * Get the distance between a point and a plane. Returns the distance value.
  * The point an the plane remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Vector } point - Source point.
  *
  * @example
  * // returns 1;
  * _.pointsDistance( [ 0, 1, 0, 1 ] , this.tools.vectorAdapter.from( [ 0, 0, 1 ] ) );
  *
  * @returns { Number } Returns the distance from the point to the plane.
  * @function pointDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( point ) is not a vector.
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function pointDistance( plane , point )
{

  let planeView = this.adapterFrom( plane );
  let normal = this.normalGet( planeView );
  let bias = this.biasGet( planeView );
  let pointVector = this.tools.vectorAdapter.from( point );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let mod = this.tools.vectorAdapter.dot( normal, normal );
  mod = Math.sqrt( mod );

  let distance = ( this.tools.vectorAdapter.dot( normal , pointVector ) + bias ) / mod ;

  // distance = Math.abs( distance );

  return distance;

}

//

/**
  * Get the proyection of a point in a plane. Returns the new point coordinates.
  * The plane remains unchanged, the point changes.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } point - Source and destination point.
  *
  * @example
  * // returns [ - 1, 2, 2 ];
  * _.pointCoplanarGet( [ 1, 0, 0, 1 ] , [ 2, 2, 2 ]);
  *
  * @returns { Array } Returns the new point in the plane.
  * @function pointCoplanarGet
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( point ) is not point.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */

function pointCoplanarGet( plane , point, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( point.length );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  let pointVector = this.tools.vectorAdapter.from( point.slice() );
  let planeView = this.adapterFrom( plane.slice() );
  let normal = this.normalGet( planeView );
  let bias = this.biasGet( planeView );

  _.assert( plane.length - 1 === point.length , 'Plane and point have different dimensions' );
  _.assert( dstPoint.length === point.length , 'Source and test points have different dimensions' );

  let lambda = - (( this.tools.vectorAdapter.dot( normal , pointVector ) + bias ) / this.tools.vectorAdapter.dot( normal, normal ) ) ;

  debugger;
  //throw _.err( 'not tested' );

  let movement = this.tools.vectorAdapter.mul( normal, lambda );

  pointVector = this.tools.vectorAdapter.add( pointVector ,  movement  );

  for( let i = 0; i < pointVector.length; i++ )
  {
    dstPointView.eSet( i, pointVector.eGet( i ) );
  }
  return dstPoint;
}

// function pointCoplanarGet( plane , point )
// {

//  if( !point )
//  point = [ 0, 0, 0 ];

//  let pointVector = this.tools.vectorAdapter.from( point );
//  let planeView = this.adapterFrom( plane );
//  let normal = this.normalGet( planeView );
//  let bias = this.biasGet( planeView );

//  _.assert( arguments.length === 1 || arguments.length === 2 );
//  debugger;
//  throw _.err( 'not tested' );

//  this.tools.avector.assign( pointVector , normal  );
//  this.tools.avector.mulScalar( pointVector, -bias );

//  return point
//  }

//

/**
  * Check if a plane and a box intersect. Returns true if they intersect and false if not.
  * The box and the plane remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } srcBox - Source box.
  *
  * @example
  * // returns true;
  * _.boxIntersects( [ 1, 0, 0, 1 ] , [ -1, 2, 2, -1, 2, 8 ]);
  *
  * @example
  * // returns false;
  * _.boxIntersects( [ 0, 1, 0, 1 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Boolean } Returns true if the plane and the box intersect.
  * @function boxIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the plane and box don´t have the same dimension).
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function boxIntersects( plane , srcBox )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let bool = false;
  let planeView = this.adapterFrom( plane );
  let dimP = this.dimGet( planeView );
  let boxView = this.tools.box.adapterFrom( srcBox );
  let dimB = this.tools.box.dimGet( boxView );
  let min = this.tools.box.cornerLeftGet( boxView );
  let max = this.tools.box.cornerRightGet( boxView );

  _.assert( dimP === dimB );

  /* box corners */
  let c =  this.tools.box.cornersGet( boxView );

  min = this.tools.vectorAdapter.from( min );
  let distance = this.pointDistance( plane, min );
  if( distance === 0 )
  {
    bool = true;
  }
  else
  {
    let side = distance/ Math.abs( distance );
    for( let j = 1 ; j < _.Matrix.DimsOf( c )[ 1 ] ; j++ )
    {
      let corner = c.colGet( j );
      distance = this.pointDistance( plane, corner );
      if( distance === 0 )
      {
        bool = true;
      }
      else
      {
        let newSide = distance/ Math.abs( distance );
        if( side === - newSide )
        {
          bool = true;
        }
        side = newSide;
      }
    }
  }
  return bool;
}

//

/**
  * Get the distance between a plane and a box. Returns the calculated distance.
  * The box and the plane remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } srcBox - Source box.
  *
  * @example
  * // returns 0;
  * _.boxDistance( [ 1, 0, 0, 1 ] , [ -1, 2, 2, -1, 2, 8 ]);
  *
  * @example
  * // returns 3;
  * _.boxDistance( [ 0, 1, 0, 1 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Number } Returns the distance between the plane and the box.
  * @function boxDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the plane and box don´t have the same dimension).
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function boxDistance( plane , srcBox )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let planeView = this.adapterFrom( plane );
  let boxView = this.tools.box.adapterFrom( srcBox );

  let distance = this.tools.box.planeDistance( boxView, planeView );

  return distance;
}

//

/**
  * Get the closest point in a plane to a box. Returns the calculated point.
  * The box and the plane remain unchanged.
  *
  * @param { Array } srcPlane - Source plane.
  * @param { Array } srcBox - Source box.
  * @param { Array } dstPoint - Destination point.
  *
  * @example
  * // returns [ 2, 2, 2 ];
  * _.boxClosestPoint( [ 0, 1, 0, 1 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Array } Returns the closest point in the plane to the box.
  * @function boxClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the plane and box don´t have the same dimension).
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function boxClosestPoint( srcPlane , srcBox, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = [ 0, 0, 0 ];

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  let planeView = this.adapterFrom( srcPlane );
  let dimP = this.dimGet( planeView );

  let boxView = this.tools.box.adapterFrom( srcBox );
  let dimB = this.tools.box.dimGet( boxView );
  let min = this.tools.box.cornerLeftGet( boxView );
  let max = this.tools.box.cornerRightGet( boxView );

  _.assert( dimP === dimB );
  _.assert( dimP === dstPointView.length );

  if( this.boxIntersects( planeView, boxView ) )
  return 0;

  let boxPoint = this.tools.box.planeClosestPoint( boxView, planeView );

  let planePoint = this.pointCoplanarGet( planeView, boxPoint );

  for( let i = 0; i < planePoint.length; i++ )
  {
    dstPointView.eSet( i, planePoint[ i ] );
  }

  return dstPoint;
}

//

/**
  * Get the bounding box of a plane. Returns destination box.
  * Plane and box are stored in Array data structure. Source plane stays untouched.
  *
  * @param { Array } dstBox - destination box.
  * @param { Array } srcPlane - source plane for the bounding box.
  *
  * @example
  * // returns [ 0, -Infinity, - Infinity, 0, Infinity, Infinity ]
  * _.boundingBoxGet( null, [ 1, 0, 0, 0 ] );
  *
  * @returns { Array } Returns the array of the bounding box.
  * @function boundingBoxGet
  * @throws { Error } An Error if ( dim ) is different than dimGet(plane) (the plane and the box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstBox ) is not box
  * @throws { Error } An Error if ( srcPlane ) is not plane
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function boundingBoxGet( dstBox, srcPlane )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let srcPlaneView = this.adapterFrom( srcPlane );
  let normal = this.normalGet( srcPlaneView );
  let bias = this.biasGet( srcPlaneView );
  let dimPlane  = this.dimGet( srcPlaneView )

  if( dstBox === null || dstBox === undefined )
  dstBox = this.tools.box.makeSingular( dimPlane );

  _.assert( _.box.is( dstBox ) );
  let boxView = this.tools.box.adapterFrom( dstBox );
  let dimB = this.tools.box.dimGet( boxView );

  _.assert( dimPlane === dimB );

  let zeros = 0;
  for( let i = 0; i < dimB; i++ )
  {
    if( normal.eGet( i ) === 0 )
    {
      zeros = zeros + 1;
    }
  }

  if( zeros === dimB - 1 )
  {
    for( let i = 0; i < dimB; i++ )
    {
      if(  normal.eGet( i ) !== 0  )
      {
        boxView.eSet( i, - bias / normal.eGet( i ) );
        boxView.eSet( i + dimB, - bias / normal.eGet( i ) );
      }
      else
      {
        boxView.eSet( i, - Infinity );
        boxView.eSet( i + dimB, Infinity );
      }
    }

  }
  else
  {
    for( let i = 0; i < dimB; i++ )
    {
      boxView.eSet( i, - Infinity );
      boxView.eSet( i + dimB, Infinity );
    }
  }

  return dstBox;
}

//

function capsuleIntersects( srcPlane , tstCapsule )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstCapsuleView = this.tools.capsule.adapterFrom( tstCapsule );
  let planeView = this.adapterFrom( srcPlane );

  let gotBool = this.tools.capsule.planeIntersects( tstCapsuleView, planeView );
  return gotBool;
}

//

function capsuleDistance( srcPlane , tstCapsule )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstCapsuleView = this.tools.capsule.adapterFrom( tstCapsule );
  let planeView = this.adapterFrom( srcPlane );

  let gotDist = this.tools.capsule.planeDistance( tstCapsuleView, planeView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a plane to a capsule. Returns the calculated point.
  * Plane and capsule remain unchanged
  *
  * @param { Array } plane - The source plane.
  * @param { Array } capsule - The source capsule.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * let capsule = [ 0, 0, 0, - 1, - 1, - 1, 1 ]
  * _.capsuleClosestPoint( [ 1, 0, 0, 0 ], capsule );
  *
  * @example
  * // returns [ 3, 0, 0 ]
  * _.capsuleClosestPoint( [ 1, 0, 0, - 3 ], capsule );
  *
  * @returns { Array } Returns the closest point to the capsule.
  * @function capsuleClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( plane ) is not plane
  * @throws { Error } An Error if ( capsule ) is not capsule
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function capsuleClosestPoint( plane, capsule, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let planeView = this.adapterFrom( plane );
  let dimPlane = this.dimGet( planeView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimPlane );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let capsuleView = this.tools.capsule.adapterFrom( capsule );
  let dimCapsule  = this.tools.capsule.dimGet( capsuleView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimPlane === dstPoint.length );
  _.assert( dimPlane === dimCapsule );

  if( this.tools.capsule.planeIntersects( capsuleView, planeView ) )
  return 0
  else
  {
    let capsulePoint = this.tools.capsule.planeClosestPoint( capsule, planeView );

    let planePoint = this.tools.vectorAdapter.from( this.pointCoplanarGet( planeView, capsulePoint ) );

    for( let i = 0; i < dimPlane; i++ )
    {
      dstPointView.eSet( i, planePoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

/**
  * Check if a plane contains a convex polygon. Returns true if it is contained and false if not.
  * Plane and polygon remain unchanged
  *
  * @param { Array } plane - The source plane.
  * @param { Polygon } polygon - The source polygon.
  *
  * @example
  * // returns false
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([
  *    0,   0,   0,   0,
  *    1,   0, - 1,   0,
  *    0,   1,   0, - 1
  *  ]);
  * _.convexPolygonContains( [ 0, 0, 1, -2 ], polygon );
  *
  * @returns { Array } Returns true if the plane contains the polygon.
  * @function convexPolygonContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane
  * @throws { Error } An Error if ( polygon ) is not convexPolygon
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function convexPolygonContains( plane, polygon )
{
  _.assert( arguments.length === 2 , 'Expects two arguments' );
  _.assert( _.convexPolygon.is( polygon ) );

  let planeView = this.adapterFrom( plane );
  let dimPl = this.dimGet( planeView );
  let dimP  = _.Matrix.DimsOf( polygon );

  _.assert( dimP[ 0 ] === dimPl, 'Plane and polygon must have the same dimensions' );

  for( let i = 0; i < dimP[ 1 ]; i++ )
  {
    let vertex = polygon.colGet( i );

    if( !this.pointContains( planeView, vertex ) )
    return false;
  }

  return true;

}

//

function convexPolygonIntersects( srcPlane , polygon )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.convexPolygon.is( polygon ) );
  let planeView = this.adapterFrom( srcPlane );

  let gotBool = this.tools.convexPolygon.planeIntersects( polygon, planeView );

  return gotBool;
}

//

function convexPolygonDistance( srcPlane , polygon )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.convexPolygon.is( polygon ) );
  let planeView = this.adapterFrom( srcPlane );

  let gotDist = this.tools.convexPolygon.planeDistance( polygon, planeView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a plane to a convex polygon. Returns the calculated point.
  * Plane and polygon remain unchanged
  *
  * @param { Array } plane - The source plane.
  * @param { Polygon } polygon - The source polygon.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns [ 0, 0, 2 ]
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([
  *    0,   0,   0,   0,
  *    1,   0, - 1,   0,
  *    0,   1,   0, - 1
  *  ]);
  * _.convexPolygonClosestPoint( [ 0, 0, 1, -2 ], polygon );
  *
  * @returns { Array } Returns the closest point to the polygon.
  * @function convexPolygonClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( plane ) is not plane
  * @throws { Error } An Error if ( polygon ) is not convexPolygon
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function convexPolygonClosestPoint( plane, polygon, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  _.assert( _.convexPolygon.is( polygon ) );

  let planeView = this.adapterFrom( plane );
  let dimPl = this.dimGet( planeView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimPl );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let dimP  = _.Matrix.DimsOf( polygon );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimPl === dstPoint.length );
  _.assert( dimP[ 0 ] === dimPl );

  if( this.tools.convexPolygon.planeIntersects( polygon, planeView ) )
  return 0
  else
  {
    let polygonPoint = this.tools.convexPolygon.planeClosestPoint( polygon, planeView );

    let planePoint = this.pointCoplanarGet( planeView, polygonPoint, this.tools.vectorAdapter.from( this.tools.long.make( dimPl ) ) ) ;

    for( let i = 0; i < dimPl; i++ )
    {
      dstPointView.eSet( i, planePoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

/**
  * Check if a plane and a frustum intersect. Returns true if they intersect.
  * The plane and the frustum remain unchanged.
  *
  * @param { Array } srcPlane - Source plane.
  * @param { Array } srcFrustum - Source frustum.
  *
  * @example
  * // returns false;
  * let srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1
  * ]);
  * _.frustumIntersects( [ 0, 1, 0, 1 ] , srcFrustum );
  *
  * @returns { Boolean } Returns true if the plane and the frustum intersect.
  * @function frustumIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( dim ) is different than frustum.dimGet (the plane and frustum don´t have the same dimension).
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function frustumIntersects( srcPlane, srcFrustum )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( srcFrustum ) );
  let srcPlaneView = this.adapterFrom( srcPlane );

  let gotBool = this.tools.frustum.planeIntersects( srcFrustum, srcPlaneView );

  return gotBool;
}

//

/**
  * Get the distance between a plane and a frustum. Returns the calculated distance.
  * The plane and the frustum remain unchanged.
  *
  * @param { Array } srcPlane - Source plane.
  * @param { Array } srcFrustum - Source frustum.
  *
  * @example
  * // returns 1;
  * let srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1
  * ]);
  * _.frustumDistance( [ 0, 1, 0, 1 ] , srcFrustum );
  *
  * @returns { Array } Returns the distance between the plane and the frustum.
  * @function frustumDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( dim ) is different than frustum.dimGet (the plane and frustum don´t have the same dimension).
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function frustumDistance( srcPlane , srcFrustum )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( srcFrustum ) );
  let srcPlaneView = this.adapterFrom( srcPlane );

  let distance = this.tools.frustum.planeDistance( srcFrustum, srcPlaneView );
  return distance;
}

//

/**
  * Get the closest point in a plane to a frustum. Returns the calculated point.
  * The plane and the frustum remain unchanged.
  *
  * @param { Array } srcPlane - Source plane.
  * @param { Array } srcFrustum - Source frustum.
  * @param { Array } dstPoint - Destination point.
  *
  * @example
  * // returns [ 0, 1, 1 ];
  * let srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1
  * ]);
  * _.frustumClosestPoint( [ 0, 1, 0, 1 ] , srcFrustum );
  *
  * @returns { Array } Returns the closest point in the plane to the frustum.
  * @function frustumClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @throws { Error } An Error if ( dim ) is different than frustum.dimGet (the plane and frustum don´t have the same dimension).
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function frustumClosestPoint( srcPlane , srcFrustum, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  _.assert( _.frustum.is( srcFrustum ) );

  if( arguments.length === 2 )
  dstPoint = [ 0, 0, 0 ];

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  let planeView = this.adapterFrom( srcPlane );
  let dimP = this.dimGet( planeView );
  _.assert( dimP === dstPointView.length );

  let dimF = _.Matrix.DimsOf( srcFrustum ) ;
  let rows = dimF[ 0 ];
  let cols = dimF[ 1 ];
  _.assert( dimP === rows - 1 );

  if( this.tools.frustum.planeIntersects( srcFrustum, planeView ) )
  return 0;

  let frustumPoint = this.tools.frustum.planeClosestPoint( srcFrustum, planeView );

  let planePoint = this.pointCoplanarGet( planeView, frustumPoint );

  for( let i = 0; i < planePoint.length; i++ )
  {
    dstPointView.eSet( i, planePoint[ i ] );
  }

  return dstPoint;
}

//

/**
  * Check if a plane contains a line. Returns true it contains the line, false if not.
  * The plane and line remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } line -  Source line.
  *
  * @example
  * // returns false
  * _.lineContains( [ 1, 0, 0, 1 ] , [ - 2, - 2, - 2, 3, 3, 3 ]);
  *
  * @example
  * // returns true
  * _.lineContains( [ 1, 0, 0, 1 ] , [ -1, 2, 2, 0, 1, 1 ]);
  *
  * @returns { Boolean } Returns true if the plane contains the line, false if not.
  * @function lineContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( line ) is not line.
  * @namespace wTools.plane
  * @module Tools/math/Concepts
*/
function lineContains( srcPlane, tstLine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstLineView = this.tools.linePointDir.adapterFrom( tstLine );
  let planeView = this.adapterFrom( srcPlane );

  let dimL = this.tools.linePointDir.dimGet( tstLineView );
  let dimP = this.dimGet( planeView );
  _.assert( dimL === dimP, 'Plane and line must have the same dimension' );

  let origin = this.tools.linePointDir.originGet( tstLineView );

  if( !this.pointContains( planeView, origin ) )
  return false;

  let secondPoint = this.tools.linePointDir.lineAt( tstLineView, 1 );

  if( !this.pointContains( planeView, secondPoint ) )
  return false;

  return true;
}

//

/**
  * Check if a plane and a line intersect. Returns true if they intersect.
  * The plane and line remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } line -  Source line.
  *
  * @example
  * // returns true
  * _.lineIntersects( [ 1, 0, 0, 1 ] , [ - 2, - 2, - 2, 3, 3, 3 ]);
  *
  * @example
  * // returns false
  * _.lineIntersects( [ 1, 0, 0, 1 ] , [ 2, 2, 2, 3, 3, 3 ]);
  *
  * @returns { Boolean } Returns true if the line and plane intersect, false if not.
  * @function lineIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( line ) is not line.
  * @namespace wTools.plane
  * @module Tools/math/Concepts
*/
function lineIntersects( srcPlane , tstLine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstLineView = this.tools.linePointDir.adapterFrom( tstLine );
  let planeView = this.adapterFrom( srcPlane );

  let gotBool = this.tools.linePointDir.planeIntersects( tstLineView, planeView );

  return gotBool;
}

//

/**
  * Returns the intersection point between a plane and a line. Returns the intersection point coordinates.
  * The plane and line remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } line -  Source line.
  * @param { Array } dstPoint -  Destination point.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.lineIntersectionPoint( [ 1, 0, 0, 0 ] , [ - 2, - 2, - 2 , 3, 3, 3 ], [ 1, 1, 1 ]);
  *
  *
  * @returns { Point } Returns the point of intersection between a plane and a line.
  * @function lineIntersectionPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( line ) is not line.
  * @throws { Error } An Error if ( point ) is not point.
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */

function lineIntersectionPoint( plane, line, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let planeView = this.adapterFrom( plane );
  let dimP = this.dimGet( planeView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimP );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let lineView = this.tools.linePointDir.adapterFrom( line );
  let origin = this.tools.linePointDir.originGet( lineView );
  let direction = this.tools.linePointDir.directionGet( lineView );
  let dimLine  = this.tools.linePointDir.dimGet( lineView );

  // throw _.err( 'not tested' );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  let dot = this.tools.vectorAdapter.dot( origin , direction );

  _.assert( dimP === dstPoint.length );
  _.assert( dimP === dimLine );

  // xxx
  if( !this.tools.linePointDir.planeIntersects( lineView, planeView ) )
  return 0; /* xxx */
  else
  {
    let linePoint =  this.tools.vectorAdapter.from( this.tools.linePointDir.planeIntersectionPoint( lineView, planeView ) );

    for( let i = 0; i < dimP; i++ )
    {
      dstPointView.eSet( i, linePoint.eGet( i ) );
    }

    return dstPoint;
  }

  // let t = - ( this.tools.vectorAdapter.dot( lineView.eGet( 0 ) , this.normal ) + bias ) / dot;
  //
  // if( t < 0 || t > 1 )
  // return false;
  //
  // return _.linePointDir.at( [ lineView.eGet( 0 ), direction ] , t );
}

//

function lineDistance( srcPlane , tstLine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstLineView = this.tools.linePointDir.adapterFrom( tstLine );
  let planeView = this.adapterFrom( srcPlane );

  let gotDist = this.tools.linePointDir.planeDistance( tstLineView, planeView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a plane to a line. Returns the calculated point.
  * Plane and line remain unchanged
  *
  * @param { Array } plane - The source plane.
  * @param { Array } line - The source line.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  *  plane = [ 0, 0, 1, 2 ];
  *  line = [ 0, 0, 0, 0, 0, - 1 ];
  * _.lineClosestPoint( plane, line );
  *
  * @example
  * // returns [ 0, 0, - 2 ]
  *  plane = [ 0, 0, 1, 2 ];
  *  line = [ 0, 0, 0, 0, - 1, 0 ];
  * _.lineClosestPoint( plane, line );
  *
  * @returns { Array } Returns the closest point to the line.
  * @function lineClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( plane ) is not plane
  * @throws { Error } An Error if ( line ) is not line
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function lineClosestPoint( plane, line, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let planeView = this.adapterFrom( plane );
  let dimP = this.dimGet( planeView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimP );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let lineView = this.tools.linePointDir.adapterFrom( line );
  let origin = this.tools.linePointDir.originGet( lineView );
  let direction = this.tools.linePointDir.directionGet( lineView );
  let dimLine  = this.tools.linePointDir.dimGet( lineView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimP === dstPoint.length );
  _.assert( dimP === dimLine );

  if( this.tools.linePointDir.planeIntersects( lineView, planeView ) )
  return 0
  else
  {
    let linePoint = this.tools.linePointDir.planeClosestPoint( line, planeView );

    let planePoint = this.tools.vectorAdapter.from( this.pointCoplanarGet( planeView, linePoint ) );

    for( let i = 0; i < dimP; i++ )
    {
      dstPointView.eSet( i, planePoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

/**
  * Check if two planes intersect. Returns true if they intersect.
  * The planes remain unchanged.
  *
  * @param { Array } srcPlane - Source plane.
  * @param { Array } tstPlane - Test plane.
  *
  * @example
  * // returns true;
  * _.planeIntersects( [ 1, 0, 0, 0 ] , [ 3, 2, 0, 1 ]);
  *
  * @returns { Boolean } Returns true if the planes intersect, false if not.
  * @function planeIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( tstPlane ) is not plane.
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function planeIntersects( srcPlane, tstPlane )
{
  let srcPlaneView = this.adapterFrom( srcPlane.slice() );
  let srcNormal = this.normalGet( srcPlaneView );
  let srcBias = this.biasGet( srcPlaneView );

  let dstPlaneView = this.adapterFrom( tstPlane.slice() );
  let tstNormal = this.normalGet( dstPlaneView );
  let tstBias = this.biasGet( dstPlaneView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  debugger;
  //throw _.err( 'not tested' );

  let factor = srcNormal.eGet( 0 ) / tstNormal.eGet( 0 );
  srcNormal.normalize();
  tstNormal.normalize();

  for( let i = 0; i < srcNormal.length ; i++ )
  {
    if( Math.abs( tstNormal.eGet( i ) - srcNormal.eGet( i ) ) > 1E-7 )
    return true;
  }

  if( Math.abs( tstBias*factor - srcBias ) < 1E-7 )
  return true;

  return false;
}

//

function lineIntersection( lineImplicit1, lineImplicit2 )
{
  _.assert( arguments.length === 2 );
  _.assert( this.is( lineImplicit1 ) );
  _.assert( this.is( lineImplicit2 ) );
  _.assert( lineImplicit1.length === lineImplicit1.length );
  _.assert( lineImplicit1.length === 3, 'not implemented' );

  let line1View = this.adapterFrom( lineImplicit1.slice() );
  let line2View = this.adapterFrom( lineImplicit2.slice() );

  let result = this.tools.vectorAdapter.make( lineImplicit1.length - 1 );

  let d = line1View.eGet( 1 )*line2View.eGet( 2 ) - line1View.eGet( 2 )*line2View.eGet( 1 );
  let x = line1View.eGet( 2 )*line2View.eGet( 0 ) - line1View.eGet( 0 )*line2View.eGet( 2 );
  let y = line1View.eGet( 0 )*line2View.eGet( 1 ) - line1View.eGet( 1 )*line2View.eGet( 0 );

  // let d = lineGeneralEq1[ 0 ]*lineGeneralEq2[ 1 ] - lineGeneralEq1[ 1 ]*lineGeneralEq2[ 0 ];
  // let x = lineGeneralEq1[ 1 ]*lineGeneralEq2[ 2 ] - lineGeneralEq1[ 2 ]*lineGeneralEq2[ 1 ];
  // let y = lineGeneralEq1[ 2 ]*lineGeneralEq2[ 0 ] - lineGeneralEq1[ 0 ]*lineGeneralEq2[ 2 ];

  result.eSet( 0, x / d );
  result.eSet( 1, y / d );

  return result;
}

lineIntersection.shaderChunk =

`
  vec2 lineImplicit_lineIntersection( vec3 lineGeneralEq1, vec3 lineGeneralEq2 )
  {
    vec2 result;

    float d = lineGeneralEq1[ 1 ]*lineGeneralEq2[ 2 ] - lineGeneralEq1[ 2 ]*lineGeneralEq2[ 1 ];
    float x = lineGeneralEq1[ 2 ]*lineGeneralEq2[ 0 ] - lineGeneralEq1[ 0 ]*lineGeneralEq2[ 2 ];
    float y = lineGeneralEq1[ 0 ]*lineGeneralEq2[ 1 ] - lineGeneralEq1[ 1 ]*lineGeneralEq2[ 0 ];

    result[ 0 ] = x / d;
    result[ 1 ] = y / d;

    return result;
  }
`
lineIntersection.shaderChunkName = 'lineImplicit_lineIntersection'

/**
  * Calculates the distance between two planes. Returns the calculated distance.
  * The planes remain unchanged.
  *
  * @param { Array } srcPlane - Source plane.
  * @param { Array } tstPlane - Test plane.
  *
  * @example
  * // returns 0;
  * _.planeDistance( [ 1, 0, 0, 0 ] , [ 3, 2, 0, 1 ]);
  *
  * @returns { Number } Returns the distance between the two planes.
  * @function planeDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( tstPlane ) is not plane.
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function planeDistance( srcPlane, tstPlane )
{
  let srcPlaneView = this.adapterFrom( srcPlane );
  let srcNormal = this.normalGet( srcPlaneView );
  let srcBias = this.biasGet( srcPlaneView );

  let dstPlaneView = this.adapterFrom( tstPlane );
  let tstNormal = this.normalGet( dstPlaneView );
  let tstBias = this.biasGet( dstPlaneView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( srcPlaneView.length === dstPlaneView.length, 'Planes must have same dimension' );

  debugger;
  //throw _.err( 'not tested' );

  if( this.planeIntersects( srcPlaneView, dstPlaneView ) === true )
  return 0;

  let factor = srcNormal.eGet( 0 ) / tstNormal.eGet( 0 );
  dstPlaneView.mul( factor )

  let a2 =  srcNormal.eGet( 0 ) * srcNormal.eGet( 0 );
  let b2 =  srcNormal.eGet( 1 ) * srcNormal.eGet( 1 );
  let c2 =  srcNormal.eGet( 2 ) * srcNormal.eGet( 2 );
  let module = Math.sqrt( a2 + b2 + c2 );

  let distance = Math.abs( tstBias*factor - srcBias ) / module;
  return distance;
}

//

/**
  * Check if a plane contains a ray. Returns true it contains the ray, false if not.
  * The plane and ray remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } ray -  Source ray.
  *
  * @example
  * // returns false
  * _.rayContains( [ 1, 0, 0, 1 ] , [ - 2, - 2, - 2, 3, 3, 3 ]);
  *
  * @example
  * // returns true
  * _.rayContains( [ 1, 0, 0, 1 ] , [ -1, 2, 2, 0, 1, 1 ]);
  *
  * @returns { Boolean } Returns true if the plane contains the ray, false if not.
  * @function rayContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( ray ) is not ray.
  * @namespace wTools.plane
  * @module Tools/math/Concepts
*/

function rayContains( srcPlane, tstRay )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstRayView = this.tools.ray.adapterFrom( tstRay );
  let planeView = this.adapterFrom( srcPlane );

  let dimR = this.tools.ray.dimGet( tstRayView );
  let dimP = this.dimGet( planeView );
  _.assert( dimR === dimP, 'Plane and ray must have the same dimension' );

  let origin = this.tools.ray.originGet( tstRayView );

  if( !this.pointContains( planeView, origin ) )
  return false;

  let secondPoint = this.tools.ray.rayAt( tstRayView, 1 );

  if( !this.pointContains( planeView, secondPoint ) )
  return false;

  return true;
}

//

function rayIntersects( srcPlane , tstRay )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let planeView = this.adapterFrom( srcPlane );
  let tstRayView = this.tools.ray.adapterFrom( tstRay );

  let gotBool = this.tools.ray.planeIntersects( tstRayView, planeView );

  return gotBool;
}

//

/**
  * Returns the intersection point between a plane and a ray. Returns the intersection point coordinates.
  * The plane and ray remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } ray -  Source ray.
  * @param { Array } dstPoint -  Destination point.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.rayIntersection( [ 1, 0, 0, 0 ] , [ - 2, - 2, - 2 , 3, 3, 3 ], [ 1, 1, 1 ]);
  *
  *
  * @returns { Point } Returns the point of intersection between a plane and a ray.
  * @function rayIntersection
  * @throws { Error } An Error if ( arguments.length ) is different than three.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( ray ) is not ray.
  * @throws { Error } An Error if ( point ) is not point.
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */

function rayIntersectionPoint( plane, ray, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let planeView = this.adapterFrom( plane );
  let dimP = this.dimGet( planeView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimP );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let rayView = this.tools.ray.adapterFrom( ray );
  let origin = this.tools.ray.originGet( rayView );
  let direction = this.tools.ray.directionGet( rayView );
  let dimRay  = this.tools.ray.dimGet( rayView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimP === dstPoint.length );
  _.assert( dimP === dimRay );

  if( !this.tools.ray.planeIntersects( rayView, planeView ) )
  return 0
  else
  {
    let rayPoint = this.tools.linePointDir.planeIntersectionPoint( rayView, planeView );

    let planePoint = this.tools.vectorAdapter.from( this.pointCoplanarGet( planeView, rayPoint ) );

    for( let i = 0; i < dimP; i++ )
    {
      dstPointView.eSet( i, planePoint.eGet( i ) );
    }

    return dstPoint;
  }
}

//

function rayDistance( srcPlane , tstRay )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let planeView = this.adapterFrom( srcPlane );
  let tstRayView = this.tools.ray.adapterFrom( tstRay );

  let gotDist = this.tools.ray.planeDistance( tstRayView, planeView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a plane to a ray. Returns the calculated point.
  * Plane and ray remain unchanged
  *
  * @param { Array } plane - The source plane.
  * @param { Array } ray - The source ray.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0.5
  * let ray = [ 0, 0, 0, - 1, - 1, - 1 ]
  * _.rayClosestPoint( [ 1, 0, 0, -0.5 ], ray );
  *
  * @example
  * // returns 0
  * _.rayClosestPoint( [ 1, 0, 0, 2 ], ray );
  *
  * @returns { Array } Returns the closest point to the ray.
  * @function rayClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( plane ) is not plane
  * @throws { Error } An Error if ( ray ) is not ray
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function rayClosestPoint( plane, ray, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let planeView = this.adapterFrom( plane );
  let dimP = this.dimGet( planeView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimP );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let rayView = this.tools.ray.adapterFrom( ray );
  let origin = this.tools.ray.originGet( rayView );
  let direction = this.tools.ray.directionGet( rayView );
  let dimRay  = this.tools.ray.dimGet( rayView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimP === dstPoint.length );
  _.assert( dimP === dimRay );

  if( this.tools.ray.planeIntersects( rayView, planeView ) )
  return 0
  else
  {
    let rayPoint = this.tools.ray.planeClosestPoint( ray, planeView );

    let planePoint = this.tools.vectorAdapter.from( this.pointCoplanarGet( planeView, rayPoint ) );

    for( let i = 0; i < dimP; i++ )
    {
      dstPointView.eSet( i, planePoint.eGet( i ) );
    }

    return dstPoint;
  }
}

//

/**
  * Check if a plane contains a segment. Returns true it contains the segment, false if not.
  * The plane and segment remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } segment -  Source segment.
  *
  * @example
  * // returns false
  * _.segmentContains( [ 1, 0, 0, 1 ] , [ - 2, - 2, - 2, 3, 3, 3 ]);
  *
  * @example
  * // returns true
  * _.segmentContains( [ 1, 0, 0, 1 ] , [ -1, 2, 2, -1, 1, 1 ]);
  *
  * @returns { Boolean } Returns true if the plane contains the segment, false if not.
  * @function segmentContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @namespace wTools.plane
  * @module Tools/math/Concepts
*/
function segmentContains( srcPlane, tstSegment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstSegmentView = this.tools.segment.adapterFrom( tstSegment );
  let planeView = this.adapterFrom( srcPlane );

  let dimS = this.tools.segment.dimGet( tstSegmentView );
  let dimP = this.dimGet( planeView );
  _.assert( dimS === dimP, 'Plane and segment must have the same dimension' );

  let origin = this.tools.segment.originGet( tstSegmentView );

  if( !this.pointContains( planeView, origin ) )
  return false;

  let end = this.tools.segment.endPointGet( tstSegmentView );

  if( !this.pointContains( planeView, end ) )
  return false;

  return true;
}

//

/**
* Check if a plane and a segment intersect. Returns true if they intersect.
* The plane and segment remain unchanged.
*
* @param { Array } plane - Source plane.
* @param { Array } segment -  First and last points in segment.
*
* @example
* // returns true
* _.segmentIntersects( [ 1, 0, 0, 1 ] , [ - 2, - 2, - 2, 3, 3, 3 ]);
*
* @example
* // returns false
* _.segmentIntersects( [ 1, 0, 0, 1 ] , [  2, 2, 2, 3, 3, 3 ]);
*
* @returns { Boolean } Returns true if the segment and plane intersect, false if not.
* @function segmentIntersects
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( plane ) is not plane.
* @throws { Error } An Error if ( segment ) is not segment.
* @namespace wTools.plane
  * @module Tools/math/Concepts
*/
function segmentIntersects( plane , segment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let planeView = this.adapterFrom( plane );
  let normal = this.normalGet( planeView );
  let bias = this.biasGet( planeView );

  let segmentView = this.tools.segment.adapterFrom( segment );
  let origin = this.tools.segment.originGet( segmentView );
  let end = this.tools.segment.endPointGet( segmentView );

  debugger;
  //throw _.err( 'not tested' );

  let b = this.pointDistance( planeView, origin );
  let e = this.pointDistance( planeView, end );

  debugger;
  return ( b <= 0 && e >= 0 ) || ( e <= 0 && b >= 0 );
}

//

/**
  * Returns the intersection point between a plane and a segment. Returns the intersection point coordinates.
  * The plane and segment remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } segment -  Source segment.
  * @param { Array } dstPoint -  Destination point.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.segmentIntersection( [ 1, 0, 0, 0 ] , [ - 2, - 2, - 2, 3, 3, 3 ]);
  *
  *
  * @returns { Point } Returns the point of intersection between a plane and a segment.
  * @function segmentIntersection
  * @throws { Error } An Error if ( arguments.length ) is different than three.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @throws { Error } An Error if ( point ) is not point.
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */

function segmentIntersectionPoint( plane, segment, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let planeView = this.adapterFrom( plane );
  let dimP = this.dimGet( planeView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimP );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let segmentView = this.tools.segment.adapterFrom( segment );
  let origin = this.tools.segment.originGet( segmentView );
  let end = this.tools.segment.endPointGet( segmentView );
  let dimSegment  = this.tools.segment.dimGet( segmentView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimP === dstPoint.length );
  _.assert( dimP === dimSegment );

  if( !this.tools.segment.planeIntersects( segmentView, planeView ) )
  return 0
  else
  {
    let lineSegment = this.tools.linePointDir.fromPoints( origin, end );
    let segmentPoint = this.tools.linePointDir.planeIntersectionPoint( lineSegment, planeView );

    let planePoint = this.tools.vectorAdapter.from( this.pointCoplanarGet( planeView, segmentPoint ) );

    for( let i = 0; i < dimP; i++ )
    {
      dstPointView.eSet( i, planePoint.eGet( i ) );
    }

    return dstPoint;
  }
}

//

function segmentDistance( srcPlane , tstSegment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstSegmentView = this.tools.segment.adapterFrom( tstSegment );
  let planeView = this.adapterFrom( srcPlane );

  let gotDist = this.tools.segment.planeDistance( tstSegmentView, planeView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a plane to a segment. Returns the calculated point.
  * Plane and segment remain unchanged
  *
  * @param { Array } plane - The source plane.
  * @param { Array } segment - The source segment.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  *  plane = [ 0, 0, 1, 2 ];
  *  segment = [ 0, 0, 0, 0, 0, - 1 ];
  * _.segmentClosestPoint( plane, segment );
  *
  * @example
  * // returns [ 0, 0, - 2 ]
  *  plane = [ 0, 0, 1, 2 ];
  *  segment = [ 0, 0, 0, 0, - 1, 0 ];
  * _.segmentClosestPoint( plane, segment );
  *
  * @returns { Array } Returns the closest point to the segment.
  * @function segmentClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( plane ) is not plane
  * @throws { Error } An Error if ( segment ) is not segment
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function segmentClosestPoint( plane, segment, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let planeView = this.adapterFrom( plane );
  let dimP = this.dimGet( planeView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimP );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let segmentView = this.tools.segment.adapterFrom( segment );
  let origin = this.tools.segment.originGet( segmentView );
  let direction = this.tools.segment.directionGet( segmentView );
  let dimSegment  = this.tools.segment.dimGet( segmentView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimP === dstPoint.length );
  _.assert( dimP === dimSegment );

  if( this.tools.segment.planeIntersects( segmentView, planeView ) )
  return 0
  else
  {
    let segmentPoint = this.tools.segment.planeClosestPoint( segment, planeView );
    let planePoint = this.tools.vectorAdapter.from( this.pointCoplanarGet( planeView, segmentPoint ) );

    for( let i = 0; i < dimP; i++ )
    {
      dstPointView.eSet( i, planePoint.eGet( i ) );
    }

    return dstPoint;
  }
}

//

/**
  * Check if a plane and a sphere intersect. Returns true if they intersect and false if not.
  * The sphere and the plane remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } sphere - Source sphere.
  *
  * @example
  * // returns true;
  * _.sphereIntersects( [ 1, 0, 0, 1 ] , [ 2, 2, 2, 8 ]);
  *
  * @example
  * // returns false;
  * _.sphereIntersects( [ 0, 1, 0, 1 ] , [ 2, 2, 2, 2 ]);
  *
  * @returns { Boolean } Returns true if the plane and the sphere intersect.
  * @function sphereIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function sphereIntersects( plane , sphere )
{
  let bool = false;
  let planeView = this.adapterFrom( plane );
  _.assert( _.sphere.is( sphere ) );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  debugger;

  let distance = this.sphereDistance( plane, sphere );

  if( distance <= 0 )
  {
    bool = true;
  }

  return bool;
}

//

/**
  * Get the distance between a plane and a sphere. Returns the distance value.
  * The sphere an the plane remain unchanged.
  * If sphere and plane intersect, it returns 0.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } sphere - Source sphere.
  *
  * @example
  * // returns 1;
  * _.sphereDistance( [ 0, 1, 0, 1 ] , [ 0, 0, 2, 1 ]);
  *
  * @returns { Number } Returns the distance from the sphere to the plane.
  * @function sphereDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function sphereDistance( plane , sphere )
{

  let planeView = this.adapterFrom( plane );
  let normal = this.normalGet( planeView );
  let bias = this.biasGet( planeView );

  let center = this.tools.sphere.centerGet( sphere );
  center = this.tools.vectorAdapter.from( center );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  debugger;
  //throw _.err( 'not tested' );

  let d = this.pointDistance( plane , center );
  d = Math.abs( d ) - this.tools.sphere.radiusGet( sphere );

  if( d < 0 )
  return 0;
  else
  return d;

}

//

/**
  * Get the closest point in a plane to a sphere. Returns the calculated point.
  * The sphere an the plane remain unchanged.
  * If sphere and plane intersect, it returns 0.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } sphere - Source sphere.
  * @param { Array } dstPoint - Destination point.
  *
  * @example
  * // returns [ 0, 2, 0 ];
  * _.sphereClosestPoint( [ 1, 0, 0, 0 ] , [ 3, 2, 0, 1 ]);
  *
  * @returns { Array } Returns the distance from the sphere to the plane.
  * @function sphereClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function sphereClosestPoint( plane , sphere, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = [ 0, 0, 0 ];

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  let planeView = this.adapterFrom( plane );
  let normal = this.normalGet( planeView );
  let bias = this.biasGet( planeView );

  _.assert( planeView.length - 1 === dstPoint.length , 'Plane and point must have same dimension' );

  let sphereView = this.tools.sphere.adapterFrom( sphere );
  let center = this.tools.sphere.centerGet( sphereView );

  if( this.sphereIntersects( planeView, sphereView ) === true )
  return 0;

  let point = this.pointCoplanarGet( planeView, center );

  for( let i = 0; i < point.length; i++ )
  {
    dstPointView.eSet( i, point[ i ] );
  }

  return dstPoint;
}

//

/**
  * Get the bounding sphere of a plane. Returns the destination sphere.
  * Plane and sphere are stored in Array data structure. Source plane stays untouched.
  *
  * @param { Array } dstSphere - destination sphere.
  * @param { Array } srcPlane - source plane for the bounding sphere.
  *
  * @example
  * // returns [ 0, 2, 0, Infinity ]
  * _.boundingSphereGet( null, [ 0, 1, 0, - 2 ] );
  *
  * @returns { Array } Returns the array of the bounding sphere.
  * @function boundingSphereGet
  * @throws { Error } An Error if ( dim ) is different than dimGet(plane) (the plane and the sphere don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstSphere ) is not sphere
  * @throws { Error } An Error if ( srcPlane ) is not plane
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */
function boundingSphereGet( dstSphere, srcPlane )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let planeView = this.adapterFrom( srcPlane );
  let normal = this.normalGet( planeView );
  let bias = this.biasGet( planeView );
  let dimPlane = this.dimGet( planeView )

  if( dstSphere === null || dstSphere === undefined )
  dstSphere = this.tools.sphere.makeZero( dimPlane );

  _.assert( _.sphere.is( dstSphere ) );
  let dstSphereView = this.tools.sphere.adapterFrom( dstSphere );
  let center = this.tools.sphere.centerGet( dstSphereView );
  let radiusSphere = this.tools.sphere.radiusGet( dstSphereView );
  let dimSphere = this.tools.sphere.dimGet( dstSphereView );

  _.assert( dimPlane === dimSphere );

  let distOrigin = this.tools.vectorAdapter.distance( this.tools.vectorAdapter.from( this.tools.longMakeZeroed( dimPlane ) ), normal );

  // Center of the sphere
  if( distOrigin === 0 )
  {
    for( let c = 0; c < center.length; c++ )
    {
      center.eSet( c, 0 );
    }
  }
  else
  {
    debugger; /* xxx */
    let pointInPlane = this.tools.vectorAdapter.from( this.pointCoplanarGet( planeView, this.tools.longMakeZeroed( dimPlane ) ) ); /* xxx */
    logger.log( pointInPlane )

    for( let c = 0; c < center.length; c++ )
    {
      center.eSet( c, pointInPlane.eGet( c ) );
    }
  }

  // Radius of the sphere
  this.tools.sphere.radiusSet( dstSphereView, Infinity );

  return dstSphere;
}

//

function matrixHomogenousApply( plane , matrix )
{

  let planeView = this.adapterFrom( plane );
  let normal = this.normalGet( planeView );
  let bias = this.biasGet( planeView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  debugger;
  throw _.err( 'not tested' );

  normal = normal.clone();

  /* let m = m1.normalProjectionMatrixGet( matrix ); */

  if( matrix.ncol === 4 )
  matrix = matrix.normalProjectionMatrixMake();

  normal = _.space.mul( matrix, normal );

  let point = this.pointCoplanarGet( plane );
  matrix.matrixHomogenousApply( point );

  return this.fromNormalAndPoint( plane , normal , point );
}

//

/**
  * Translates a plane by a given offset. Returns the new plane coordinates.
  * The offset remains unchanged, the plane changes.
  *
  * @param { Array } plane - Source and destination plane.
  * @param { Array } offset -  Offset to translate the plane.
  *
  * @example
  * // returns [ 1, 0, 0, 1 ];
  * _.translate( [ 1, 0, 0, 1 ] , [ 0, 2, 0 ] );
  *
  * @example
  * // returns [ 1, 0, 0, - 1 ]
  * _.translate( [ 1, 0, 0, 1 ] ,  [  2, 2, 2 ] );
  *
  * @returns { Boolean } Returns the translated plane.
  * @function translate
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( offset ) is not point.
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */

function translate( plane , offset )
{

  let _offset = this.tools.vectorAdapter.from( offset );
  let planeView = this.adapterFrom( plane );
  let normal = this.normalGet( planeView );
  let bias = this.biasGet( planeView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  debugger;
  //  throw _.err( 'not tested' );

  this.biasSet( plane, bias - this.tools.vectorAdapter.dot( normal, _offset ) )

  return plane;
}

//

/**
  * Normalize a plane coordinates. Returns the normalized plane coordinates.
  * The plane changes.
  *
  * @param { Array } plane - Source and destination plane.
  *
  * @example
  * // returns [ 1, 0, 0, 0 ];
  * _.normalize( [ 1, 0, 0, 0 ] );
  *
  * @example
  * // returns [ 1, 0, 0, 2 ]
  * _.translate( [ 1, 0, 0, 2 ]  );
  *
  * @returns { Array } Returns the normalized plane.
  * @function normalize
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */

function normalize( plane )
{

  let planeView = this.adapterFrom( plane );
  let normal = this.normalGet( planeView );
  let bias = this.biasGet( planeView );

  _.assert( arguments.length === 1, 'Expects single argument' );
  debugger;
  //throw _.err( 'not tested' );

  let scaler = 1.0 / normal.mag();
  normal.mul( scaler );
  this.biasSet( planeView, bias*scaler );

  return plane;
}

//

/**
  * Negate a plane coordinates. Returns the negated plane coordinates.
  * The plane changes.
  *
  * @param { Array } plane - Source and destination plane.
  *
  * @example
  * // returns [ - 1, 0, 0, 0 ];
  * _.negate( [ 1, 0, 0, 0 ] );
  *
  * @example
  * // returns [ - 1, 0, 0, - 2 ]
  * _.negate( [ 1, 0, 0, 2 ]  );
  *
  * @returns { Array } Returns the negated plane.
  * @function negate
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */

function negate( plane )
{

  let planeView = this.adapterFrom( plane );
  let normal = this.normalGet( planeView );
  let bias = this.biasGet( planeView );

  _.assert( arguments.length === 1, 'Expects single argument' );
  debugger;
  // throw _.err( 'not tested' );

  this.tools.vectorAdapter.mul( normal, -1 );
  this.biasSet( planeView, -bias );

  return plane;
}

//

/**
  * Returns the intersection point between three planes. Returns the intersection point coordinates, NaN if the plane´s intersection is not a point.
  * The planes remain unchanged.
  *
  * @param { Array } planeone - Source plane.
  * @param { Array } planetwo - Source plane.
  * @param { Array } planethree - Source plane.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.threeIntersectionPoint( [ 1, 0, 0, 0 ] , [ 0, 1, 0, 0 ], [ 0, 0, 1, 0 ] );
  *
  *
  * @returns { Point } Returns the point of intersection between three planes.
  * @function threeIntersectionPoint
  * @throws { Error } An Error if ( arguments.length ) is different than three.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @namespace wTools.plane
  * @module Tools/math/Concepts
  */

function threeIntersectionPoint( planeone , planetwo , planethree )
{

  let planeViewOne = this.adapterFrom( planeone );
  let normalOne = this.normalGet( planeViewOne );
  let biasOne = this.biasGet( planeViewOne );
  let planeViewTwo = this.adapterFrom( planetwo );
  let normalTwo = this.normalGet( planeViewTwo );
  let biasTwo = this.biasGet( planeViewTwo );
  let planeViewThree = this.adapterFrom( planethree );
  let normalThree = this.normalGet( planeViewThree );
  let biasThree = this.biasGet( planeViewThree );

  _.assert( arguments.length === 3, 'Expects exactly three arguments' );
  _.assert( normalOne.length === normalTwo.length && normalTwo.length == normalThree.length );

  let Ispoint = this.tools.vectorAdapter.dot( normalOne, this.tools.vectorAdapter.cross( normalTwo.clone(), normalThree ) );

  let point;
  if( Ispoint != 0)
  {
    let cross23 = this.tools.vectorAdapter.cross( normalTwo.clone(), normalThree );
    let cross31 = this.tools.vectorAdapter.cross( normalThree.clone(), normalOne );
    let cross12 = this.tools.vectorAdapter.cross( normalOne.clone(), normalTwo );

    let Mcross23 = this.tools.vectorAdapter.mul( cross23, - 1.0*biasOne );
    let Mcross31 = this.tools.vectorAdapter.mul( cross31, - 1.0*biasTwo );
    let Mcross12 = this.tools.vectorAdapter.mul( cross12, - 1.0*biasThree );

    point = this.tools.vectorAdapter.mul( this.tools.vectorAdapter.add( Mcross23, Mcross31, Mcross12 ) , 1.0 / Ispoint);

    return point;
  }

  else
  {
    point = NaN;
    return point;
  }

}

// --
// chunks injection
// --

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


// --
// declare
// --

let Extension = /* qqq : normalize order */
{

  make,
  adapterFrom,
  is,

  from,
  fromNormalAndPoint,
  fromPoints,
  fromPointAndTangent,

  dimGet,
  normalGet,
  biasGet,
  biasSet,

  pointContains, /* qqq : implement me */
  pointDistance,
  pointCoplanarGet,
  // pointClosestPoint, /* qqq : implement me - done in pointCoplanarGet */

  boxIntersects,
  boxDistance, /* qqq: implement me - Same as _.box.planeDistance */
  boxClosestPoint, /* qqq: implement me */
  boundingBoxGet,

  capsuleIntersects,
  capsuleDistance,
  capsuleClosestPoint,

  frustumIntersects, /* qqq: implement me - Same as _.frustum.planeIntersects */
  frustumDistance, /* qqq: implement me - Same as _.frustum.planeDistance */
  frustumClosestPoint, /* qqq: implement me */

  planeIntersects, /* qqq: implement me */
  lineIntersection,
  planeDistance, /* qqq: implement me */

  convexPolygonContains,
  convexPolygonIntersects,
  convexPolygonDistance,
  convexPolygonClosestPoint,

  frustumIntersects, /* qqq: implement me - Same as _.frustum.planeIntersects */
  frustumDistance, /* qqq: implement me - Same as _.frustum.planeDistance */
  frustumClosestPoint, /* qqq: implement me */

  lineContains,
  lineIntersects,
  lineIntersectionPoint,
  lineDistance,
  lineClosestPoint,

  segmentIntersects,
  segmentDistance,
  segmentClosestPoint,

  sphereIntersects,
  sphereDistance,
  sphereClosestPoint, /* qqq: implement me */
  boundingSphereGet,

  matrixHomogenousApply,
  translate,

  rayContains,
  rayIntersects, /* Same as _.ray.planeIntersects */
  rayIntersectionPoint,
  rayDistance, /* Same as _.ray.planeDistance */
  rayClosestPoint,

  segmentContains,
  segmentIntersects,
  segmentIntersectionPoint,
  segmentDistance,
  segmentClosestPoint,

  normalize,
  negate,

  threeIntersectionPoint,

  // ref

  tools : _,

}

/* _.props.extend */Object.assign( _.plane, Extension );
injectChunks( Extension );

})();
