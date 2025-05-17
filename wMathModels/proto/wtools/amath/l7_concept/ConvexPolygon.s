(function _ConvexPolygon_s_(){

'use strict';

const _ = _global_.wTools;
// let this.tools.avector = this.tools.avector;
// let vector = this.tools.vectorAdapter;
_.convexPolygon = _.convexPolygon || Object.create( _.avector );

/**
 * @description
 * A convex polygon is a simple polygon where all interior angles are less than or equal
 * edges ( segments ) and vertices ( corners ).
 * to 180 degrees. Therefore, it is a plane figure ( 2D ), closed and defined by a set of
 *
 * In the following methods, convex polygons will be defined by a space where each column
 * represents one of the polygon´s vertices.
 * @namespace wTools.convexPolygon
 * @module Tools/math/Concepts
 */

/*



*/

// --
// implementation
// --

function is( polygon )
{
  return _.matrixIs( polygon ); /* Dmytro : maybe, needs improvement, it's should be like: return _.matrixIs( polygon ) && polygon.dims.length === 2 */
}

//

/**
 * Check if the source polygon is a polygon. Returns true if it is a polygon.
 * Source polygon stays unchanged.
 *
 * @param { Matrix } polygon - The source polygon.
 *
 * @example
 * // returns true;
 * var polygon = _.Matrix.Make([ 3, 5 ]).copy
 * ([
 *   1, 0, -1, 0, 2,
 *   0, 0, 1, 2, 2,
 *   0, 0, 0, 0, 0
 * ]);
 * _.isPolygon( polygon );
 *
 * @example
 * // returns false;
 * var polygon = _.Matrix.Make([ 3, 5 ]).copy
 * ([
 *   1, 0, -1, 0, 2,
 *   0, 0, 1, 2, 2,
 *   0, 0, 0, 2, 0
 * ]);
 * _.isPolygon( polygon );
 *
 * @returns { Boolean } Returns true if polygon is a polygon and false if not.
 * @function isPolygon
 * @throws { Error } An Error if ( arguments.length ) is different than one.
 * @namespace wTools.convexPolygon
 * @module Tools/math/Concepts
 */

function isPolygon( polygon )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.matrixIs( polygon ) );

  let dims = _.Matrix.DimsOf( polygon );

  if(  dims[ 0 ] < 2 || dims[ 0 ] > 3 || dims[ 1 ] < 3 )
  return false;
  else if( dims[ 0 ] === 3 && dims[ 1 ] > 3 )
  {
    let normal = this.tools.vectorAdapter.from( this.tools.longMakeZeroed/* _.array.makeArrayOfLengthZeroed */( dims[ 0 ] ) );
    let plane = this.tools.vectorAdapter.from( this.tools.longMakeZeroed/* _.array.makeArrayOfLengthZeroed */( dims[ 0 ] + 1 ) );
    let i = 0;

    while( this.tools.vectorAdapter.allEquivalent( normal, this.tools.vectorAdapter.fromNumber( 0, dims[ 0 ] ) ) && ( i <= dims[ 1 ] - 3 ) )
    {
      let pointOne = polygon.colGet( i );
      let pointTwo = polygon.colGet( i + 1 );
      let pointThree = polygon.colGet( i + 2 );
      plane = this.tools.plane.fromPoints( null, pointOne, pointTwo, pointThree );
      normal = this.tools.plane.normalGet( plane );
      i = i + 1;
    }

    for( let i = 0 ; i < dims[ 1 ]; i += 1 )
    {
      let vertex = polygon.colGet( i );

      if( !this.tools.plane.pointContains( plane, vertex ) )
      return false;
    }
  }

  return true;
}

//

/**
  * Check if the source polygon is a convex polygon. Returns true if it is a convex polygon.
  * Source polygon stays unchanged.
  *
  * @param { Matrix } polygon - The source polygon.
  *
  * @example
  * // returns true;
  * var polygon = _.Matrix.Make([ 3, 5 ]).copy
  * ([
  *   1, 0, -1, 0, 2,
  *   0, 0, 1, 2, 2,
  *   0, 0, 0, 0, 0
  * ]);
  * _.convexPolygon.is( polygon );
  *
  * @example
  * // returns false;
  * var polygon = _.Matrix.Make([ 3, 5 ]).copy
  * ([
  *   1, 0, 1, 0, 2,
  *   0, 0, 1, 2, 2,
  *   0, 0, 0, 0, 0
  * ]);
  * _.convexPolygon.is( polygon );
  *
  * @returns { Boolean } Returns true if polygon is a convex polygon and false if not.
  * @function isValid
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function isValid( polygon )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.matrixIs( polygon ) );

  if( !this.isPolygon( polygon ) )
  return false;

  let dims = _.Matrix.DimsOf( polygon );

  let normal = this.tools.vectorAdapter.from( this.tools.longMakeZeroed/* _.array.makeArrayOfLengthZeroed */( dims[ 0 ] ) );
  if( dims[ 0 ] === 3 )
  {
    let i = 0;
    while( this.tools.vectorAdapter.allEquivalent( normal, this.tools.longMakeZeroed/* _.array.makeArrayOfLengthZeroed */( dims[ 0 ] ) ) && ( i <= dims[ 1 ] - 3 ) )
    {
      let pointOne = polygon.colGet( i );
      let pointTwo = polygon.colGet( i + 1 );
      let pointThree = polygon.colGet( i + 2 );
      let plane = this.tools.plane.fromPoints( null, pointOne, pointTwo, pointThree );
      normal = this.tools.plane.normalGet( plane );
      i = i + 1;
    }
  }

  let angles = this.tools.vectorAdapter.from( this.tools.longMakeZeroed/* _.array.makeArrayOfLengthZeroed */( dims[ 1 ] ) );
  let zeros = 0;
  for( let i = 0 ; i < dims[ 1 ] ; i = i + 1 )
  {
    let h =  ( i - 1 >= 0 ) ? i - 1 : dims[ 1 ] - 1;
    let j =  ( i + 1 <= dims[ 1 ] - 1 ) ? i + 1 : 0;

    let pointOne = polygon.colGet( h );
    let pointTwo = polygon.colGet( i );
    let pointThree = polygon.colGet( j );

    if( dims[ 0 ] === 2 )
    {
      angles.eSet( i - zeros, this.angleThreePoints( pointOne, pointTwo, pointThree ) );
    }
    else if( dims[ 0 ] === 3 )
    {
      angles.eSet( i - zeros, this.angleThreePoints( pointOne, pointTwo, pointThree, normal ) );
    }

    if( angles.eGet( i - zeros ) === 0 || angles.eGet( i - zeros ) === 2*Math.PI ) //aaa vova: checks should be strict?
    {
      angles._vectorBuffer.splice( i - zeros, 1 ); /* xxx qqq : cant use *._vectorBuffer.splice! */
      zeros= zeros + 1;
    }
  }

  if(  this.tools.avector.allEquivalent( angles, this.tools.longMakeZeroed/* _.array.makeArrayOfLengthZeroed */( dims[ 1 ] - zeros ) ) || angles.length === 0 )
  return true;

  if( this.tools.vectorAdapter.allLessEqual( angles, Math.PI ) || this.tools.vectorAdapter.allGreaterEqual( angles, Math.PI ) )
  return true;

  return false;
}

//

function isConvex( polygon )
{

  if( !this.isPolygon( polygon ) )
  return false;

  let dims = _.Matrix.DimsOf( polygon );

  if ( dims[ 1 ] < 4 )
  return true;

  let result = false;
  let vertexNumber = dims[ 1 ];

  for( let i = 0 ; i < vertexNumber ; i++ )
  {
    let dx1 = polygon.scalarGet([ 0, ( i + 2 ) % vertexNumber ]) - polygon.scalarGet([ 0, ( i + 1 ) % vertexNumber ]);
    let dy1 = polygon.scalarGet([ 1, ( i + 2 ) % vertexNumber ]) - polygon.scalarGet([ 1, ( i + 1 ) % vertexNumber ]);
    let dx2 = polygon.scalarGet([ 0, i ]) - polygon.scalarGet([ 0, ( i + 1 ) % vertexNumber ]);
    let dy2 = polygon.scalarGet([ 1, i ]) - polygon.scalarGet([ 1, ( i + 1 ) % vertexNumber ]);
    let cross = dx1 * dy2 - dy1 * dx2;

    if ( i == 0 )
    result = cross > 0;
    else if ( result != ( cross > 0 ) )
    return false;
  }

  return true;
}

//

function isConcave( polygon )
{
  if( !this.isPolygon( polygon ) )
  return false;
  return !this.isConvex( polygon );
}

//

function isClockwise( polygon )
{
  let result = 0;

  _.assert( this.is( polygon ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  let dims = _.Matrix.DimsOf( polygon );
  let l = dims[ 1 ];
  for( let p = l-1 ; p >= 0 ; p-- )
  {
    let p2 = p + 1;
    if( p2 === l )
    p2 = 0;

    let vertex = polygon.colGet( p );
    let nextVertex = polygon.colGet( p2 );

    result += ( vertex.eGet( 0 ) - nextVertex.eGet( 0 ) ) * ( vertex.eGet( 1 ) + nextVertex.eGet( 1 ) );
    // result += ( polygon[ p*2+0 ] - polygon[ p2*2+0 ] ) * ( polygon[ p*2+1 ] + polygon[ p2*2+1 ] );
  }

  _.assert( _.numberIsFinite( result ) );

  return result >= 0;
  // return result > 0;
}

//

/**
 * Create a convex polygon of 'vertices' number of vertices and dimension dim ( 2 or 3 ), full of zeros.
 * Returns the created polygon. Vertices and dim remain unchanged.
 *
 * @param { Number } vertices - Number of vertices of the polygon.
 * @param { Number } dim - Dimension of the created polygon.
 *
 * @example
 * // returns cvexPolygon =
 * [
 *   0, 0, 0, 0, 0, 0, 0, 0,
 *   0, 0, 0, 0, 0, 0, 0, 0,
 *   0, 0, 0, 0, 0, 0, 0, 0,
 * ];
 * _.convexPolygon.make( 8, 3 );
 *
 * @example
 * // returns [ 0, 0, 1, 1 ];
 * _.convexPolygon.make( [ 0, 0, 1, 1 ] );
 *
 * @returns { Array } Returns the array of the created box.
 * @function make
 * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
 * @namespace wTools.convexPolygon
 * @module Tools/math/Concepts
 */

function make( vertices, dim )
{
  _.assert( arguments.length === 2, 'convexPolygon.make expects exactly 2 arguments' );
  _.assert( _.numberIs( dim ) && dim > 1 && dim < 4, 'dim must be a number ( 2 or 3 )' );
  _.assert( _.longIs( vertices ) || _.numberIs( vertices ), 'vertices must be a vector or a number' );

  let dst;
  let numberOfVertices = vertices;
  let verticesIsLong = _.longIs( vertices );

  if( verticesIsLong )
  numberOfVertices = vertices.length / dim;

  _.assert( numberOfVertices > 2, 'vertices must be a number superior to two' );
  dst = _.Matrix.MakeZero([ dim, numberOfVertices ]);

  if( verticesIsLong )
  dst.copy( vertices );

  return dst;
}

//

/**
  * Get an angle out of three points. Returns angle in radians.
  * Source points and normal stay unchanged.
  * Angle is calculated counter clockwise, according to the src normal direction.
  * If normal is not provided, it returns the small angle.
  * For 2D, normal is not used ( always counter clockwise )
  *
  * @param { Array } pointOne - The first source point.
  * @param { Array } pointTwo - The second source point ( the middle point ).
  * @param { Array } pointThree - The third source point.
  * @param { Array } normal - Direction of the reference plane.
  *
  * @example
  * // returns pi / 2;
  * _.angleThreePoints( [ 1, 0, 0 ], [ 0, 0, 0 ], [ 0, 1, 0 ] , [ 0, 0, 1 ] );
  *
  * @returns { Number } Returns the angle formed by the three points in radians.
  * @function angleThreePoints
  * @throws { Error } An Error if ( arguments.length ) is different than four.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */
function angleThreePoints( pointOne, pointTwo, pointThree, normal )
{
  _.assert( arguments.length === 3 || arguments.length === 4, 'Expects three or four arguments' );
  _.assert( pointOne.length === pointTwo.length, 'Points must have same length' );
  _.assert( pointOne.length === pointThree.length, 'Points must have same length' );
  _.assert( pointOne.length === 2 || pointOne.length === 3 , 'Implemented for 2D and 3D' );

  let angle;
  let pointOneView = this.tools.vectorAdapter.from( pointOne );
  let pointTwoView = this.tools.vectorAdapter.from( pointTwo );
  let pointThreeView = this.tools.vectorAdapter.from( pointThree );
  let vectorOne = this.tools.vectorAdapter.sub( pointOneView.clone(), pointTwoView );
  let vectorTwo = this.tools.vectorAdapter.sub( pointThreeView.clone(), pointTwoView );
  let accuracy = 1e-7; /*eps*/

  if( pointOne.length === 3 )
  {
    if( arguments.length === 3 )
    {
      let plane = this.tools.plane.fromPoints( null, pointOne, pointTwo, pointThree );
      var normal = this.tools.plane.normalGet( plane );
    }

    let normalView = this.tools.vectorAdapter.from( normal );
    normalView.normalize();
    _.assert( pointOne.length === normal.length, 'Normal and points must have same length' );

    if( this.tools.vectorAdapter.mag( normalView ) === 0 )
    {
      if( this.tools.vectorAdapter.allEquivalent( vectorOne.normalize(), vectorTwo.normalize() ) )
      return 0;

      return Math.PI;
    }

    let dot = this.tools.vectorAdapter.dot( vectorOne, vectorTwo );
    let cross = this.tools.vectorAdapter.cross( vectorOne.clone(), vectorTwo );

    let det = this.tools.vectorAdapter.dot( normalView, cross );

    angle = Math.atan2( det, dot );
  }
  else
  {
    angle = Math.atan2( vectorTwo.eGet( 1 ), vectorTwo.eGet( 0 ) ) - Math.atan2( vectorOne.eGet( 1 ), vectorOne.eGet( 0 ) );
  }

  if( angle < 0 )
  angle = 2 * Math.PI + angle;

  return angle;
}

//

/**
  * Check if the source polygon contains the source point. Returns true if it contains it.
  * Source polygon and point stay unchanged.
  *
  * @param { ConvexPolygon } polygon - The source polygon.
  * @param { Array } point - The source point.
  *
  * @example
  * // returns true;
  * var polygon = _.Matrix.Make([ 3, 5 ]).copy
  * ([
  *   1,  0, -1,  0,  2,
  *   0,  0,  1,  2,  2,
  *   0,  0,  0,  0,  0
  * ]);
  * _.pointContains( polygon, [ 1, 1, 0 ] );
  *
  * @example
  * // returns false;
  * var polygon = _.Matrix.Make([ 3, 5 ]).copy
  * ([
  *   1,  0, -1,  0,  2,
  *   0,  0,  1,  2,  2,
  *   0,  0,  0,  0,  0
  * ]);
  * _.pointContains( polygon, [ 3, 3, 3 ] );
  *
  * @returns { Boolean } Returns true if the src polygon contains the src point, and false if not.
  * @function pointContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( point ) is not a point.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function pointContains( polygon, point )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( polygon ), 'polygon must be a convex polygon' );

  let pointView = this.tools.vectorAdapter.from( point );
  let dims = _.Matrix.DimsOf( polygon );

  _.assert( dims[ 0 ] === point.length, 'Polygon and point must have same dimension' );

  let normal = this.tools.vectorAdapter.from( this.tools.longMakeZeroed/* _.array.makeArrayOfLengthZeroed */( dims[ 0 ] ) );
  if( dims[ 0 ] === 3 )
  {
    let plane = this.tools.vectorAdapter.from( this.tools.longMakeZeroed/* _.array.makeArrayOfLengthZeroed */( dims[ 0 ] + 1 ) );
    let i = 0;
    debugger
    while( this.tools.vectorAdapter.allIdentical( normal, this.tools.vectorAdapter.fromNumber( 0, dims[ 0 ] ) ) && ( i <= dims[ 1 ] - 3 ) )
    {
      let pointOne = polygon.colGet( i );
      let pointTwo = polygon.colGet( i + 1 );
      let pointThree = polygon.colGet( i + 2 );
      plane = this.tools.plane.fromPoints( null, pointOne, pointTwo, pointThree );
      normal = this.tools.plane.normalGet( plane );
      i = i + 1;
    }

    if( !this.tools.plane.pointContains( plane, pointView ) )
    return false;
  }

  let angles = this.tools.vectorAdapter.from( this.tools.longMakeZeroed/* _.array.makeArrayOfLengthZeroed */( dims[ 1 ] ) );
  let zeros = 0;
  for( let i = 0 ; i < dims[ 1 ] ; i = i + 1 )
  {
    let j =  ( i + 1 <= dims[ 1 ] - 1 ) ? i + 1 : 0;

    let vertex = polygon.colGet( i );
    let nextVertex = polygon.colGet( j );

    if( this.tools.vectorAdapter.allEquivalent( pointView, vertex ) )
    return true;

    if( dims[ 0 ] === 2 )
    {
      angles.eSet( i - zeros, this.angleThreePoints( vertex, pointView, nextVertex ) );
    }
    else if( dims[ 0 ] === 3 )
    {
      angles.eSet( i - zeros, this.angleThreePoints(  vertex, pointView, nextVertex, normal ) );
    }

    if( angles.eGet( i - zeros ) === 0 || angles.eGet( i - zeros ) === 2*Math.PI )// aaa vova:checks should be strict?
    {
      angles._vectorBuffer.splice( i - zeros, 1 );
      zeros= zeros + 1;
    }
  }

  if(  this.tools.avector.allEquivalent( angles, this.tools.longMakeZeroed/* _.array.makeArrayOfLengthZeroed */( dims[ 1 ] - zeros ) ) || angles.length === 0 )
  return false;

  debugger;

  // if( this.tools.vectorAdapter.allLessAprox( angles, Math.PI ) || this.tools.vectorAdapter.allGreaterAprox( angles, Math.PI ) )
  if( ( this.tools.vectorAdapter.allLessAprox( angles, Math.PI ) || this.tools.vectorAdapter.allGreaterAprox( angles, Math.PI ) ) && this.isClockwise( polygon ) )
  return true;

  return false;

}

//

function pointContains2D( polygon, point )
{
  let self = this;
  //let c = [ point[ 0 ], point[ 1 ], 1 ];
  let line21 = [];
  let line20 = [];
  let p = 0;
  let pl = polygon.length / 2;
  let inside = 0;

  _.assert( pl === 2, 'not implemented' );

  //

  function pointsPointSide( points, point )
  {

    let point1 = [];
    point1[ 0 ] = points[ 0 ][ 0 ] - point[ 0 ];
    point1[ 1 ] = points[ 0 ][ 1 ] - point[ 1 ];

    let point2 = [];
    point2[ 0 ] = points[ 1 ][ 0 ] - point[ 0 ];
    point2[ 1 ] = points[ 1 ][ 1 ] - point[ 1 ];

    if( point1[ 0 ] < 0 && point2[ 0 ] < 0 )
    return false;

    if( point1[ 0 ] > 0 && point2[ 0 ] > 0 )
    return false;

    if( point1[ 0 ] === point2[ 0 ] )
    {
      if( point1[ 1 ] < 0 && point2[ 1 ] < 0 )
      return false;

      if( point1[ 1 ] > 0 && point2[ 1 ] > 0 )
      return false;

      return 2;
    }

    let upper = point2[ 1 ] - point2[ 0 ] * ( point1[ 1 ]-point2[ 1 ] ) / ( point1[ 0 ]-point2[ 0 ] );

    if( upper === 0 )
    return 2;

    return upper >= 0;
  }

  //

  let p1 = [ polygon[ (pl-1)*2+0 ], polygon[ (pl-1)*2+1 ] ];
  let p2 = [ polygon[ (p+0)*2+0 ], polygon[ (p+0)*2+1 ] ];
  let side = pointsPointSide( [ p1, p2 ], point );
  if( side === 2 ) return 1;
  inside = inside + side;

  //

  for( p = 1 ; p < pl ; p++ )
  {

    let p1 = [ polygon[ (p-1)*2+0 ], polygon[ (p-1)*2+1 ] ];
    let p2 = [ polygon[ (p+0)*2+0 ], polygon[ (p+0)*2+1 ] ];
    let side = pointsPointSide( [ p1, p2 ], point );
    if( side === 2 ) return p+1;
    inside = inside + side;

  }

  return inside % 2 ? pl+1 : 0;
}

//

/**
  * Calculates the distance between a convex polygon and a point. Returns the calculated distance.
  * Polygon and point remain unchanged.
  *
  * @param { ConvexPolygon } polygon - Source polygon.
  * @param { Array } point - Source point.
  *
  * @example
  * // returns 1;
  * let polygon = _.Matrix.Make( [ 2, 3 ] ).copy
  * ([
  *     0, 1, 0,
  *     1, 0, 0
  * ]);
  * _.pointDistance( polygon, [ 2, 0 ] );
  **
  * @returns { Distance } Returns the distance between the polygon and the point.
  * @function pointDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not convex polygon.
  * @throws { Error } An Error if ( point ) is not point.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function pointDistance( polygon, point )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( polygon ), 'polygon must be a convex polygon' );

  let pointView = this.tools.vectorAdapter.from( point );
  let dims = _.Matrix.DimsOf( polygon );

  _.assert( dims[ 0 ] === pointView.length, 'Polygon and point must have same dimension' )
  debugger;

  if( this.pointContains( polygon, pointView ) )
  return 0;


  let plane = this.tools.vectorAdapter.from( this.tools.longMakeZeroed( dims[ 0 ] + 1 ) );
  if( dims[ 0 ] === 3 )
  {
    let normal = this.tools.vectorAdapter.from( this.tools.longMakeZeroed( dims[ 0 ] ) );
    let i = 0;
    while( this.tools.vectorAdapter.allIdentical( normal, this.tools.vectorAdapter.fromNumber( 0, dims[ 0 ] ) ) && ( i <= dims[ 1 ] - 3 ) )
    {
      let pointOne = polygon.colGet( i );
      let pointTwo = polygon.colGet( i + 1 );
      let pointThree = polygon.colGet( i + 2 );
      plane = this.tools.plane.fromPoints( null, pointOne, pointTwo, pointThree );
      normal = this.tools.plane.normalGet( plane );
      i = i + 1;
    }

    let proy = this.tools.vectorAdapter.from( this.tools.plane.pointCoplanarGet( plane, pointView ) );

    if( this.pointContains( polygon, proy ) )
    return this.tools.vectorAdapter.distance( pointView, proy );
  }

  let distance = Infinity;
  for( let i = 0 ; i < dims[ 1 ] ; i = i + 1 )
  {
    let j =  ( i + 1 <= dims[ 1 ] - 1 ) ? i + 1 : 0;

    let vertex = polygon.colGet( i );
    let nextVertex = polygon.colGet( j );

    let segment = this.tools.segment.fromPair( [ vertex, nextVertex ] );
    let d = this.tools.segment.pointDistance( segment, pointView );

    if( d < distance )
    distance = d;
  }

  return distance;
}

//

function pointDistanceSqr( polygon, point )
{
  let result = this.pointDistance( polygon, point );
  return this.tools.math.sqr( result );
}

//

/**
  * Returns the closest point in a polygon to a point. Returns the coordinates of the closest point.
  * Polygon and point remain unchanged.
  *
  * @param { Polygon } polygon - Source polygon.
  * @param { Array } srcPoint - Source point.
  * @param { Array } dstPoint - Destination point.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.pointClosestPoint( polygon, [ - 1, - 1, - 1 ] );
  *
  * @returns { Array } Returns the array of coordinates of the closest point in the polygon.
  * @function pointClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( point ) is not point.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function pointClosestPoint( polygon , srcPoint, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  _.assert( this.is( polygon ), 'polygon must be a convex polygon' );

  let pointView = this.tools.vectorAdapter.from( srcPoint );
  let dims = _.Matrix.DimsOf( polygon );

  _.assert( dims[ 0 ] === pointView.length, 'Polygon and point must have same dimension' );
  debugger;

  if( arguments.length === 2 )
  dstPoint = this.tools.longMakeZeroed/* _.array.makeArrayOfLengthZeroed */( dims[ 0 ] );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  if( this.pointContains( polygon, pointView ) )
  {
    dstPointView.copy( pointView );
    return dstPoint;
  }

  let plane = this.tools.vectorAdapter.from( this.tools.longMakeZeroed/* _.array.makeArrayOfLengthZeroed */( dims[ 0 ] + 1 ) );
  if( dims[ 0 ] === 3 )
  {
    let normal = this.tools.vectorAdapter.from( this.tools.longMakeZeroed/* _.array.makeArrayOfLengthZeroed */( dims[ 0 ] ) );
    let i = 0;
    while( this.tools.vectorAdapter.allIdentical( normal, this.tools.vectorAdapter.fromNumber( 0, dims[ 0 ] ) ) && ( i <= dims[ 1 ] - 3 ) )
    {
      let pointOne = polygon.colGet( i );
      let pointTwo = polygon.colGet( i + 1 );
      let pointThree = polygon.colGet( i + 2 );
      plane = this.tools.plane.fromPoints( null, pointOne, pointTwo, pointThree );
      normal = this.tools.plane.normalGet( plane );
      i = i + 1;
    }

    var proy = this.tools.vectorAdapter.from( this.tools.plane.pointCoplanarGet( plane, pointView ) );

    if( this.pointContains( polygon, proy ) )
    {
      dstPointView.copy( proy );
      return dstPoint;
    }
  }


  let distance = Infinity;
  let point;
  for( let i = 0 ; i < dims[ 1 ] ; i = i + 1 )
  {
    let j =  ( i + 1 <= dims[ 1 ] - 1 ) ? i + 1 : 0;

    let vertex = polygon.colGet( i );
    let nextVertex = polygon.colGet( j );

    let segment = this.tools.segment.fromPair( [ vertex, nextVertex ] );
    let d = this.tools.segment.pointDistance( segment, pointView );

    if( d < distance )
    {
      distance = d;
      point = this.tools.segment.pointClosestPoint( segment, pointView );
    }
  }

  dstPointView.copy( point );

  _.assert( this.pointContains( polygon, dstPointView ) === true );

  return dstPoint;
}

//

/**
  * Check if a convex polygon and a box intersect. Returns true if they intersect.
  * Convex polygon and box remain unchanged.
  *
  * @param { Polygon } polygon - Source polygon.
  * @param { Array } box - Source box.
  *
  * @example
  * // returns false;
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.boxIntersects( polygon , [ 4, 4, 4, 5, 5, 5 ] );
  **
  * @returns { Boolean } Returns true if the polygon and the box intersect.
  * @function boxIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( box ) is not box.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function boxIntersects( polygon, box )
{

  let boxView = this.tools.box.adapterFrom( box );
  let dimB = this.tools.box.dimGet( boxView );
  let minB = this.tools.box.cornerLeftGet( boxView );
  let maxB = this.tools.box.cornerRightGet( boxView );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( polygon ), 'polygon must be a convex polygon' );
  debugger;

  let dims = _.Matrix.DimsOf( polygon );

  let boxCorners = this.tools.box.cornersGet( boxView );
  let dimCorners = _.Matrix.DimsOf( boxCorners );

  for( let b = 0; b < dimCorners[ 1 ]; b++ )
  {
    let corner = boxCorners.colGet( b );
    if( this.pointContains( polygon, corner ) === true )
    {
      return true;
    }
  }


  for( let i = 0 ; i < dims[ 1 ] ; i ++ )
  {
    let point = polygon.colGet( i );

    if( this.tools.box.pointContains( box, point ) === true )
    {
      return true;
    }
  }

  for( let i = 0 ; i < dims[ 1 ] ; i = i + 1 )
  {
    let j = ( i + 1 <= dims[ 1 ] - 1 ) ? i + 1 : 0;

    let vertex = polygon.colGet( i );
    let nextVertex = polygon.colGet( j );

    let segment = this.tools.segment.fromPair( [ vertex, nextVertex ] );

    if( this.tools.segment.boxIntersects( segment, boxView ) )
    {
      return true;
    }
  }

  //3D case include segment - polygon intersection
  if( dims[ 0 ] > 2 )
  {
    let corner0 = boxCorners.colGet( 0 );
    for( let b = 1; b < dimCorners[ 1 ]; b++ )
    {
      let corner = boxCorners.colGet( b );
      let segment = this.tools.segment.fromPair( [ corner0, corner ] );
      if( this.segmentIntersects( polygon, segment ) === true )
      return true;
    }
  }
  return false;
}

//

/**
  * Get the distance between a convex polygon and a box. Returns the calculated distance.
  * The polygon and box remain unchanged.
  *
  * @param { Polygon } polygon - Source convex polygon.
  * @param { Array } box - Source box.
  *
  * @example
  * // returns 1;
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.boxDistance( polygon , [ 0, 0, 4, 5, 5, 5 ] );
  *
  * @returns { Number } Returns the distance between the polygon and the box.
  * @function boxDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not polygon.
  * @throws { Error } An Error if ( box ) is not box.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function boxDistance( polygon, box )
{
  let boxView = this.tools.box.adapterFrom( box );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( polygon ), 'polygon must be a convex polygon' );
  debugger;

  if( this.boxIntersects( polygon, boxView ) )
  return 0;

  let closestPoint = this.boxClosestPoint( polygon, boxView );

  let distance = this.tools.box.pointDistance( boxView, closestPoint );

  return distance;
}

//

/**
  * Returns the closest point in a convex polygon to a box. Returns the coordinates of the closest point.
  * The polygon and box remain unchanged.
  *
  * @param { Polygon } polygon - Source convex polygon.
  * @param { Array } box - Source box.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.boxClosestPoint( polygon , [ - 1, - 1, - 1, -0.1, -0.1, -0.1 ] );
  *
  * @returns { Array } Returns the array of coordinates of the closest point in the convex polygon.
  * @function boxClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( box ) is not box.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function boxClosestPoint( polygon, box, dstPoint )
{
  let boxView = this.tools.box.adapterFrom( box );
  let dimB = this.tools.box.dimGet( boxView );
  let minB = this.tools.box.cornerLeftGet( boxView );
  let maxB = this.tools.box.cornerRightGet( boxView );
  let dims = _.Matrix.DimsOf( polygon );
  let rows = dims[ 0 ];
  let cols = dims[ 1 ];

  _.assert( this.is( polygon ), 'polygon must be a convex polygon' );
  _.assert( dimB === rows, 'Polygon and box must have the same dimension' );
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( rows );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  _.assert( dstPointView.length === rows, 'Polygon and dstPoint must have the same dimension' );

  if( this.boxIntersects( polygon, boxView ) )
  return 0;

  let point = this.tools.vectorAdapter.from( this.tools.longMake/* _.array.makeArrayOfLength */( rows ) );

  /* polygon vertices */

  let dist = Infinity;
  for ( let j = 0 ; j < cols ; j++ )
  {
    let newVertex = polygon.colGet( j );
    let d = this.tools.box.pointDistance( boxView, newVertex );

    if( d < dist )
    {
      point = this.tools.vectorAdapter.from( newVertex );
      dist = d;
    }
  }

  /* box corners */
  let c = this.tools.box.cornersGet( boxView );

  for( let j = 0 ; j < _.Matrix.DimsOf( c )[ 1 ] ; j++ )
  {
    let corner = c.colGet( j );
    let proj = this.pointClosestPoint( polygon, corner );
    let d = this.tools.avector.distance( corner, proj );
    if( d < dist )
    {
      point = this.tools.vectorAdapter.from( proj );
      dist = d;
    }
  }

  for( var i = 0; i < dstPointView.length; i++ )
  {
    dstPointView.eSet( i, point.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Get the bounding box of a convex polygon. Returns destination box.
  * Polygon and box are stored in Array data structure. Source polygon stays untouched.
  *
  * @param { Array } dstBox - destination box.
  * @param { Polygon } polygon - source polygon for the bounding box.
  *
  * @example
  * // returns [ 0, -1, -1, 0, 1, 1 ]
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  * ([
  *    0,   0,   0,   0,
  *    1,   0, - 1,   0,
  *    0,   1,   0, - 1
  *  ]);
  * _.boundingBoxGet( polygon, null );
  *
  * @returns { Array } Returns the array of the bounding box.
  * @function boundingBoxGet
  * @throws { Error } An Error if ( dim ) is different than dimGet(polygon) (the polygon and the box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstBox ) is not box
  * @throws { Error } An Error if ( polygon ) is not a convex polygon
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */
function boundingBoxGet( polygon, dstBox  )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  _.assert( this.is( polygon ) );
  let dims = _.Matrix.DimsOf( polygon ) ;
  let rows = dims[ 0 ];
  let cols = dims[ 1 ];

  if( dstBox === null || dstBox === undefined )
  dstBox = this.tools.box.makeSingular( rows );

  _.assert( _.box.is( dstBox ) );
  let boxView = this.tools.box.adapterFrom( dstBox );
  let minB = this.tools.box.cornerLeftGet( boxView );
  let maxB = this.tools.box.cornerRightGet( boxView );
  let dimB = this.tools.box.dimGet( boxView );

  _.assert( rows === dimB );

  // Polygon limits
  let maxP = polygon.colGet( 0 ).clone();
  let minP = polygon.colGet( 0 ).clone();

  for( let j = 1 ; j < cols ; j++ )
  {
    let newp = polygon.colGet( j );
    for( let i = 0; i < rows; i ++ )
    {
      if( newp.eGet( i ) < minP.eGet( i ) )
      {
        minP.eSet( i, newp.eGet( i ) );
      }
      if( newp.eGet( i ) > maxP.eGet( i ) )
      {
        maxP.eSet( i, newp.eGet( i ) );
      }
    }
  }

  for( let b = 0; b < dimB; b++ )
  {
    minB.eSet( b, minP.eGet( b ) );
    maxB.eSet( b, maxP.eGet( b ) );
  }

  return dstBox;
}

//

/**
  * Check if a convex polygon and a capsule intersect. Returns true if they intersect.
  * Convex polygon and capsule remain unchanged.
  *
  * @param { Polygon } polygon - Source polygon.
  * @param { Array } capsule - Source capsule.
  *
  * @example
  * // returns false;
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.capsuleIntersects( polygon , [ 4, 4, 4, 5, 5, 5, 0.2 ] );
  **
  * @returns { Boolean } Returns true if the polygon and the capsule intersect.
  * @function capsuleIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( capsule ) is not capsule.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function capsuleIntersects( polygon, capsule )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( polygon ), 'polygon must be a convex polygon' );
  _.assert( _.capsule.is( capsule ), 'capsuleIntersects ecxpects Capsule' );

  let capsuleView = this.tools.vectorAdapter.from( capsule );
  let dimC = this.tools.capsule.dimGet( capsuleView );
  let originC = this.tools.capsule.originGet( capsuleView );
  let endC = this.tools.capsule.endPointGet( capsuleView );
  let radiusC = this.tools.capsule.radiusGet( capsuleView );
  debugger;

  let dims = _.Matrix.DimsOf( polygon );
  _.assert( dimC === dims[ 0 ], 'Capsule and polygon must have the same dimension' );

  let segment = this.tools.segment.fromPair( [ originC, endC ] );

  let distance = this.segmentDistance( polygon, segment );

  if( distance > radiusC )
  return false;

  return true;

}

//

/**
  * Get the distance between a convex polygon and a capsule. Returns the calculated distance.
  * Convex polygon and capsule remain unchanged.
  *
  * @param { Polygon } polygon - Source polygon.
  * @param { Array } capsule - Source capsule.
  *
  * @example
  * // returns Math.sqrt( 19 ) - 1;
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.capsuleDistance( polygon , [ 4, 4, 4, 5, 5, 5, 1 ] );
  **
  * @returns { Number } Returns the distance between the polygon and the capsule, 0 if they intersect.
  * @function capsuleDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( capsule ) is not capsule.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function capsuleDistance( polygon, capsule )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( polygon ), 'polygon must be a convex polygon' );
  _.assert( _.capsule.is( capsule ), 'capsuleIntersects ecxpects Capsule' );

  let capsuleView = this.tools.vectorAdapter.from( capsule );
  let dimC = this.tools.capsule.dimGet( capsuleView );
  let originC = this.tools.capsule.originGet( capsuleView );
  let endC = this.tools.capsule.endPointGet( capsuleView );
  let radiusC = this.tools.capsule.radiusGet( capsuleView );
  debugger;

  let dims = _.Matrix.DimsOf( polygon );
  _.assert( dimC === dims[ 0 ], 'Polygon and capsule must have the same dimension' );

  if( this.capsuleIntersects( polygon, capsuleView ) )
  return 0;

  let segment = this.tools.segment.fromPair( [ originC, endC ] );

  let distanceS = this.segmentDistance( polygon, segment );
  let distanceC = distanceS - radiusC;

  _.assert( distanceS >= 0 );
  return distanceC;
}

//

/**
  * Returns the closest point in a convex polygon to a capsule. Returns the coordinates of the closest point.
  * The polygon and capsule remain unchanged.
  *
  * @param { Polygon } polygon - Source convex polygon.
  * @param { Array } capsule - Source capsule.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.capsuleClosestPoint( polygon , [ - 1, - 1, - 1, -0.1, -0.1, -0.1, 0.01 ] );
  *
  * @returns { Array } Returns the array of coordinates of the closest point in the convex polygon.
  * @function capsuleClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( capsule ) is not capsule.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function capsuleClosestPoint( polygon, capsule, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  _.assert( this.is( polygon ), 'Polygon must be a convex polygon' );
  _.assert( _.capsule.is( capsule ), 'capsuleIntersects ecxpects Capsule' );

  let capsuleView = this.tools.vectorAdapter.from( capsule );
  let dimC = this.tools.capsule.dimGet( capsuleView );
  let originC = this.tools.capsule.originGet( capsuleView );
  let endC = this.tools.capsule.endPointGet( capsuleView );
  let radiusC = this.tools.capsule.radiusGet( capsuleView );
  debugger;

  let dims = _.Matrix.DimsOf( polygon );
  _.assert( dimC === dims[ 0 ], 'Polygon and capsule must have the same dimension' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimC );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  _.assert( dstPointView.length === dims[ 0 ], 'Polygon and dstPoint must have the same dimension' );

  if( this.capsuleIntersects( polygon, capsuleView ) )
  return 0;

  let point = this.tools.vectorAdapter.from( this.tools.long.make( dimC ) );
  let segment = this.tools.segment.fromPair( [ originC, endC ] );

  point = this.segmentClosestPoint( polygon, segment, point );

  for( var i = 0; i < dstPointView.length; i++ )
  {
    dstPointView.eSet( i, point.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Check if a convex polygon and a frustum intersect. Returns true if they intersect.
  * The polygon and the frustum remain unchanged.
  *
  * @param { ConvexPolygon } polygon - Source convex polygon.
  * @param { Frustum } frustum - Frustum to test if it intersects.
  *
  * @example
  * // returns true;
  * let polygon = _.Matrix.Make( [ 4, 6 ] ).copy
  *  ([
  *     1,   0,   0,
  *     0,   0,   0,
  *     0,   0,   1
  *   ]);
  * let frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  *   ([
  *    0,   0,   0,   0, - 1,   1,
  *    1, - 1,   0,   0,   0,   0,
  *    0,   0,   1, - 1,   0,   0,
  *   -0.5, -0.5, -0.5, -0.5, -0.5, -0.5
  *   ]);
  * _.frustumIntersects( polygon, frustum );
  *
  * @returns { Boolean } Returns true if the convex polygon and the frustum intersect.
  * @function frustumIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not convex polygon.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function frustumIntersects( polygon, frustum )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( polygon ), 'Polygon must be a convex polygon' );
  _.assert( _.frustum.is( frustum ), 'frustumIntersects expects frustum' );
  debugger;

  let dimsP = _.Matrix.DimsOf( polygon );
  let dimsF = _.Matrix.DimsOf( frustum );
  _.assert( dimsP[ 0 ] === dimsF[ 0 ] - 1, 'Polygon and frustum must have the same dimension' );

  // Frustum corners
  let points = this.tools.frustum.cornersGet( frustum );
  let dimsFP = _.Matrix.DimsOf( points );
  for( let i = 0 ; i < dimsFP[ 1 ] ; i += 1 )
  {
    let point = points.colGet( i );
    let c = this.pointContains( polygon, point );

    if( c === true )
    return true;
  }

  // Polygon vertices
  for( let i = 0 ; i < dimsP[ 1 ].length ; i += 1 )
  {
    let point = polygon.colGet( i );
    let c = this.tools.frustum.pointContains( frustum, point );
    if( c === true )
    return true;
  }

  // Polygon edges
  for( let i = 0 ; i < dimsP[ 1 ] ; i = i + 1 )
  {
    let j = ( i + 1 <= dimsP[ 1 ] - 1 ) ? i + 1 : 0;

    let vertex = polygon.colGet( i );
    let nextVertex = polygon.colGet( j );

    let segment = this.tools.segment.fromPair( [ vertex, nextVertex ] );

    if( this.tools.segment.frustumIntersects( segment, frustum ) )
    {
      return true;
    }
  }

  //3D case include segment - polygon intersection
  if( dimsP[ 0 ] > 2 )
  {
    let corner0 = points.colGet( 0 );
    for( let b = 1; b < dimsFP[ 1 ]; b++ )
    {
      let corner = points.colGet( b );
      let segment = this.tools.segment.fromPair( [ corner0, corner ] );
      if( this.segmentIntersects( polygon, segment ) === true )
      return true;
    }
  }

  return false;
}

//

/**
  * Calculates the distance between a polygon and a frustum. Returns the calculated distance.
  * The polygon and the frustum remain unchanged.
  *
  * @param { ConvexPolygon } polygon - Source convex polygon.
  * @param { Frustum } tstFrustum - Frustum to calculate the distance.
  *
  * @example
  * // returns 0;
  * let polygon = _.Matrix.Make( [ 4, 6 ] ).copy
  *  ([
  *     1,   0,   0,
  *     0,   0,   0,
  *     0,   0,   1
  *   ]);
  * let frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  *   ([
  *    0,   0,   0,   0, - 1,   1,
  *    1, - 1,   0,   0,   0,   0,
  *    0,   0,   1, - 1,   0,   0,
  *   -0.5, -0.5, -0.5, -0.5, -0.5, -0.5 ]
  *   );
  * _.frustumDistance( polygon , frustum );
  *
  * @returns { Number } Returns the distance between the convex polygon and the frustum.
  * @function frustumDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function frustumDistance( polygon, frustum )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( polygon ), 'Polygon must be a convex polygon' );
  _.assert( _.frustum.is( frustum ), 'frustumDistance expects frustum' );
  debugger;

  if( this.frustumIntersects( polygon, frustum ) )
  return 0;

  let closestPoint = this.frustumClosestPoint( polygon, frustum );

  let distance = this.tools.frustum.pointDistance( frustum, closestPoint );

  return distance;
}

//

/**
  * Calculates the closest point in a convex polygon to a frustum. Returns the calculated point.
  * The polygon and the frustum remain unchanged.
  *
  * @param { ConvexPolygon } polygon - Source convex polygon.
  * @param { Frustum } frustum - Test frustum.
  * @param { Point } dstPoint - Destination point.
  *
  * @example
  * // returns [ 1, 1, 1 ];
  * let polygon = _.Matrix.Make( [ 4, 6 ] ).copy
  *  ([
  *     2,   0,   0,
  *     0,   2,   0,
  *     0,   0,   2
  *   ]);
  * let frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  *   ([
  *    0,   0,   0,   0, - 1,   1,
  *    1, - 1,   0,   0,   0,   0,
  *    0,   0,   1, - 1,   0,   0,
  *   -0.5, -0.5, -0.5, -0.5, -0.5, -0.5 ]
  *   );
  * _.frustumClosestPoint( polygon , frustum );
  *
  * @returns { Array } Returns the closest point in a convex polygon to a frustum.
  * @function frustumClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function frustumClosestPoint( polygon, frustum, dstPoint )
{

  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  _.assert( this.is( polygon ), 'Polygon must be a convex polygon' );
  _.assert( _.frustum.is( frustum ), 'frustumDistance expects frustum' );

  let dimsP = _.Matrix.DimsOf( polygon ) ;
  let dimsF = _.Matrix.DimsOf( frustum ) ;
  _.assert( dimsP[ 0 ] === dimsF[ 0 ] - 1, 'Polygon and frustum must have the same dimension' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimsP[ 0 ] );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  _.assert( dstPointView.length === dimsP[ 0 ], 'Polygon and dstPoint must have the same dimension' );

  debugger;

  if( this.frustumIntersects( polygon, frustum ) )
  return 0;

  let distance = Infinity;
  let finalPoint = this.tools.long.make( dimsP[ 0 ] );

  //Frustum corners
  let fPoints = this.tools.frustum.cornersGet( frustum );
  let dimsFP = _.Matrix.DimsOf( fPoints );

  for( let i = 0 ; i < dimsFP[ 1 ] ; i += 1 )
  {
    let pointF = fPoints.colGet( i );
    let proj = this.pointClosestPoint( polygon, pointF );
    let d = this.tools.avector.distance( pointF, proj );

    if( d < distance )
    {
      finalPoint = this.tools.vectorAdapter.from( proj );
      distance = d;
    }
  }

  //Polygon vertices
  for( let i = 0 ; i < dimsP[ 1 ] ; i += 1 )
  {
    let point = polygon.colGet( i );
    let d = this.tools.frustum.pointDistance( frustum, point );
    if( d < distance )
    {
      let finalPoint = this.tools.vectorAdapter.from( point );
      distance = d;
    }
  }

  for( var i = 0; i < finalPoint.length; i++ )
  {
    dstPointView.eSet( i, finalPoint.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Check if a convex polygon and a line intersect. Returns true if they intersect.
  * Convex polygon and line remain unchanged.
  *
  * @param { Polygon } polygon - Source polygon.
  * @param { Array } line - Source line.
  *
  * @example
  * // returns true;
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.lineIntersects( polygon , [ 4, 4, 4, 5, 5, 5 ] );
  **
  * @returns { Boolean } Returns true if the polygon and the line intersect.
  * @function lineIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( line ) is not line.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function lineIntersects( polygon, line )
{

  let lineView = this.tools.vectorAdapter.from( line );
  let lOrigin = this.tools.linePointDir.originGet( lineView );
  let lDir = this.tools.linePointDir.directionGet( lineView );
  let lDim  = this.tools.linePointDir.dimGet( lineView );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( polygon ), 'polygon must be a convex polygon' );
  debugger;

  let dims = _.Matrix.DimsOf( polygon );
  _.assert( lDim === dims[ 0 ], 'Polygon and line must have the same dimension' );

  let containOrigin = this.pointContains( polygon, lOrigin );
  if( containOrigin === true )
  {
    return true;
  }

  for( let i = 0 ; i < dims[ 1 ] ; i = i + 1 )
  {
    let j = ( i + 1 <= dims[ 1 ] - 1 ) ? i + 1 : 0;

    let vertex = polygon.colGet( i );
    let nextVertex = polygon.colGet( j );
    let segmentP = this.tools.segment.fromPair( [ vertex, nextVertex ] );

    if( this.tools.segment.lineIntersects( segmentP, lineView ) )
    {
      logger.log( segmentP )
      return true;
    }
  }

  if( dims[ 0 ] > 2 )
  {
    let normal = this.tools.vectorAdapter.from( this.tools.longMakeZeroed( dims[ 0 ] ) );
    let plane = this.tools.vectorAdapter.from( this.tools.longMakeZeroed( dims[ 0 ] + 1 ) );
    let i = 0;

    debugger;
    while( vectorsEquivalent.call( this, normal, this.tools.longMakeZeroed( dims[ 0 ] ) ) && ( i <= dims[ 1 ] - 3 ) ) /* Dmytro : uses local routine. In other side, the first and the second arguments of the routine are the same new instances */
    // while( this.tools.vectorAdapter.allEquivalent( normal, this.tools.longMakeZeroed( dims[ 0 ] ) ) && ( i <= dims[ 1 ] - 3 ) )
    {
      let pointOne = polygon.colGet( i );
      let pointTwo = polygon.colGet( i + 1 );
      let pointThree = polygon.colGet( i + 2 );
      plane = this.tools.plane.fromPoints( null, pointOne, pointTwo, pointThree );
      normal = this.tools.plane.normalGet( plane );
      i = i + 1;
    }

    if( this.tools.linePointDir.planeIntersects( lineView, plane ) )
    {
      let copOrigin = this.tools.plane.pointCoplanarGet( plane, lOrigin );
      let copEnd = this.tools.plane.pointCoplanarGet( plane, this.tools.linePointDir.lineAt( lineView, 1 ) );
      let copLine = this.tools.linePointDir.fromPoints( copOrigin, copEnd );
      debugger;
      if( this.tools.linePointDir.lineIntersects( lineView, copLine ) )
      {
        let intPoint = this.tools.linePointDir.lineIntersectionPoint( lineView, copLine );

        if( this.pointContains( polygon, intPoint ) )
        return true;
      }
    }
  }

  return false;

  /* */

  function vectorsEquivalent( src1, src2 )
  {

    for( let i = 0 ; i < src2.length ; i++ )
    if( src1.eGet( i ) - src2[ i ] >= this.tools.accuracy )
    return false;

    return true;
  }
}

//

/**
  * Get the distance between a convex polygon and a line. Returns the calculated distance.
  * Convex polygon and line remain unchanged.
  *
  * @param { Polygon } polygon - Source polygon.
  * @param { Array } line - Source line.
  *
  * @example
  * // returns 0;
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.lineDistance( polygon , [ 4, 4, 4, 5, 5, 5 ] );
  **
  * @returns { Number } Returns the distance between the polygon and the line, 0 if they intersect.
  * @function lineDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( line ) is not line.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function lineDistance( polygon, line )
{

  let lineView = this.tools.vectorAdapter.from( line );
  let lOrigin = this.tools.linePointDir.originGet( lineView );
  let lDir = this.tools.linePointDir.directionGet( lineView );
  let lDim  = this.tools.linePointDir.dimGet( lineView );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( polygon ), 'polygon must be a convex polygon' );
  debugger;

  let dims = _.Matrix.DimsOf( polygon );
  _.assert( lDim === dims[ 0 ], 'Polygon and line must have the same dimension' );

  if( this.lineIntersects( polygon, lineView ) )
  return 0;

  let closestPoint = this.lineClosestPoint( polygon, lineView );

  let distance = this.tools.linePointDir.pointDistance( lineView, closestPoint );

  return distance;
}

//

/**
  * Returns the closest point in a convex polygon to a line. Returns the coordinates of the closest point.
  * The polygon and line remain unchanged.
  *
  * @param { Polygon } polygon - Source convex polygon.
  * @param { Array } line - Source line.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.lineClosestPoint( polygon , [ - 1, - 1, - 1, 2, 0, 0 ] );
  *
  * @returns { Array } Returns the array of coordinates of the closest point in the convex polygon.
  * @function lineClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( line ) is not line.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function lineClosestPoint( polygon, line, dstPoint )
{
  let lineView = this.tools.vectorAdapter.from( line );
  let lOrigin = this.tools.linePointDir.originGet( lineView );
  let lEnd = this.tools.linePointDir.directionGet( lineView );
  let lDim  = this.tools.linePointDir.dimGet( lineView );
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  _.assert( this.is( polygon ), 'Polygon must be a convex polygon' );
  debugger;

  let dims = _.Matrix.DimsOf( polygon );
  _.assert( lDim === dims[ 0 ], 'Polygon and line must have the same dimension' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( lDim );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  _.assert( dstPointView.length === dims[ 0 ], 'Polygon and dstPoint must have the same dimension' );

  if( this.lineIntersects( polygon, lineView ) )
  return 0;

  let point = this.tools.vectorAdapter.from( this.tools.long.make( lDim ) );

  let dist = Infinity;

  /* line corners */
  let dOrigin = this.pointDistance( polygon, lOrigin );

  if( dOrigin < dist )
  {
    dist = dOrigin;
    point = this.tools.vectorAdapter.from( this.pointClosestPoint( polygon, lOrigin ) );
  }
  /* polygon vertices */
  for ( let j = 0 ; j < dims[ 1 ] ; j++ )
  {
    let newVertex = polygon.colGet( j );
    let d = this.tools.linePointDir.pointDistance( lineView, newVertex );

    if( d < dist )
    {
      point = this.tools.vectorAdapter.from( newVertex );
      dist = d;
    }
  }

  for( var i = 0; i < dstPointView.length; i++ )
  {
    dstPointView.eSet( i, point.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Check if a convex polygon and a plane intersect. Returns true if they intersect.
  * Convex polygon and plane remain unchanged.
  *
  * @param { Polygon } polygon - Source polygon.
  * @param { Array } plane - Source plane.
  *
  * @example
  * // returns true;
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.planeIntersects( polygon , [ 1, 0, 0, -1 ] );
  **
  * @returns { Boolean } Returns true if the polygon and the plane intersect.
  * @function planeIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function planeIntersects( polygon, plane )
{

  let planeView = this.tools.plane.adapterFrom( plane );
  let dimP = this.tools.plane.dimGet( planeView );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( polygon ), 'polygon must be a convex polygon' );
  debugger;

  let dims = _.Matrix.DimsOf( polygon );
  _.assert( dimP === dims[ 0 ], 'Polygon and plane must have the same dimension' );

  let bool = false;

  let distance = this.tools.plane.pointDistance( plane, polygon.colGet( 0 ) );
  if( distance === 0 )
  {
    bool = true;
  }
  else
  {
    let side = distance/ Math.abs( distance );
    for( let j = 1 ; j < dims[ 1 ]; j++ )
    {
      let vertex = polygon.colGet( j );
      distance = this.tools.plane.pointDistance( plane, vertex );
      if( distance === 0 )
      {
        bool = true;
      }
      else
      {
        let newSide = distance/ Math.abs( distance );
        if( side === - newSide )//aaa vova: this.tools.number.equivalent?
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
  * Get the distance between a convex polygon and a plane. Returns the calculated distance.
  * Convex polygon and plane remain unchanged.
  *
  * @param { Polygon } polygon - Source polygon.
  * @param { Array } plane - Source plane.
  *
  * @example
  * // returns 0;
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.planeDistance( polygon , [ 0, 1, 0, -1 ] );
  **
  * @returns { Number } Returns the distance between the polygon and the plane, 0 if they intersect.
  * @function planeDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function planeDistance( polygon, plane )
{

  let planeView = this.tools.plane.adapterFrom( plane );
  let dimP = this.tools.plane.dimGet( planeView );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( polygon ), 'polygon must be a convex polygon' );
  debugger;

  let dims = _.Matrix.DimsOf( polygon );
  _.assert( dimP === dims[ 0 ], 'Polygon and plane must have the same dimension' );

  if( this.planeIntersects( polygon, planeView ) )
  return 0;

  let closestPoint = this.planeClosestPoint( polygon, planeView );

  let distance = Math.abs( this.tools.plane.pointDistance( planeView, closestPoint ) );

  return distance;
}

//

/**
  * Returns the closest point in a convex polygon to a plane. Returns the coordinates of the closest point.
  * The polygon and plane remain unchanged.
  *
  * @param { Polygon } polygon - Source convex polygon.
  * @param { Array } plane - Source plane.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.planeClosestPoint( polygon , [ 1, 0, 0, 1 ] );
  *
  * @returns { Array } Returns the array of coordinates of the closest point in the convex polygon.
  * @function planeClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function planeClosestPoint( polygon, plane, dstPoint )
{

  let planeView = this.tools.plane.adapterFrom( plane );
  let dimP = this.tools.plane.dimGet( planeView );
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  _.assert( this.is( polygon ), 'Polygon must be a convex polygon' );
  debugger;

  let dims = _.Matrix.DimsOf( polygon );
  _.assert( dimP === dims[ 0 ], 'Polygon and plane must have the same dimension' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimP );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  _.assert( dstPointView.length === dims[ 0 ], 'Polygon and dstPoint must have the same dimension' );

  if( this.planeIntersects( polygon, planeView ) )
  return 0;

  let point = this.tools.vectorAdapter.from( this.tools.long.make( dimP ) );

  let dist = Infinity;

  /* polygon vertices */
  for ( let j = 0 ; j < dims[ 1 ] ; j++ )
  {
    let newVertex = polygon.colGet( j );
    let d = Math.abs( this.tools.plane.pointDistance( planeView, newVertex ) );

    if( d < dist )
    {
      point = this.tools.vectorAdapter.from( newVertex );
      dist = d;
    }
  }

  for( var i = 0; i < dstPointView.length; i++ )
  {
    dstPointView.eSet( i, point.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Check if a convex polygon and a ray intersect. Returns true if they intersect.
  * Convex polygon and ray remain unchanged.
  *
  * @param { Polygon } polygon - Source polygon.
  * @param { Array } ray - Source ray.
  *
  * @example
  * // returns false;
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.rayIntersects( polygon , [ 4, 4, 4, 5, 5, 5 ] );
  **
  * @returns { Boolean } Returns true if the polygon and the ray intersect.
  * @function rayIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( ray ) is not ray.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function rayIntersects( polygon, ray )
{

  let rayView = this.tools.vectorAdapter.from( ray );
  let sOrigin = this.tools.ray.originGet( rayView );
  let sDim  = this.tools.ray.dimGet( rayView );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( polygon ), 'polygon must be a convex polygon' );
  debugger;

  let dims = _.Matrix.DimsOf( polygon );
  _.assert( sDim === dims[ 0 ], 'Polygon and ray must have the same dimension' );

  let containOrigin = this.pointContains( polygon, sOrigin );
  if( containOrigin === true )
  return true;

  for( let i = 0 ; i < dims[ 1 ] ; i = i + 1 )
  {
    let j = ( i + 1 <= dims[ 1 ] - 1 ) ? i + 1 : 0;

    let vertex = polygon.colGet( i );
    let nextVertex = polygon.colGet( j );
    let segmentP = this.tools.segment.fromPair( [ vertex, nextVertex ] );

    if( this.tools.segment.rayIntersects( segmentP, rayView ) )
    {
      return true;
    }
  }
  if( dims[ 0 ] > 2 )
  {
    let normal = this.tools.vectorAdapter.from( this.tools.longMakeZeroed( dims[ 0 ] ) );
    let plane = this.tools.vectorAdapter.from( this.tools.longMakeZeroed( dims[ 0 ] + 1 ) );
    let i = 0;

    while( this.tools.vectorAdapter.allEquivalent( normal, this.tools.longMakeZeroed( dims[ 0 ] ) ) && ( i <= dims[ 1 ] - 3 ) )
    {
      let pointOne = polygon.colGet( i );
      let pointTwo = polygon.colGet( i + 1 );
      let pointThree = polygon.colGet( i + 2 );
      plane = this.tools.plane.fromPoints( null, pointOne, pointTwo, pointThree );
      normal = this.tools.plane.normalGet( plane );
      i = i + 1;
    }

    if( this.tools.ray.planeIntersects( rayView, plane ) )
    {
      let copOrigin = this.tools.plane.pointCoplanarGet( plane, sOrigin );
      let copEnd = this.tools.plane.pointCoplanarGet( plane, this.tools.ray.rayAt( rayView, 1 ) );
      let copLine = this.tools.linePointDir.fromPoints( copOrigin, copEnd );
      debugger;
      if( this.tools.ray.lineIntersects( rayView, copLine ) )
      {
        let intPoint = this.tools.linePointDir.lineIntersectionPoint( rayView, copLine );

        if( this.pointContains( polygon, intPoint ) )
        return true;
      }
    }
  }

  return false;
}

//

/**
  * Get the distance between a convex polygon and a ray. Returns the calculated distance.
  * Convex polygon and ray remain unchanged.
  *
  * @param { Polygon } polygon - Source polygon.
  * @param { Array } ray - Source ray.
  *
  * @example
  * // returns Math.sqrt( 19 );
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.rayDistance( polygon , [ 4, 4, 4, 5, 5, 5 ] );
  **
  * @returns { Number } Returns the distance between the polygon and the ray, 0 if they intersect.
  * @function rayDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( ray ) is not ray.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function rayDistance( polygon, ray )
{

  let rayView = this.tools.vectorAdapter.from( ray );
  let sOrigin = this.tools.ray.originGet( rayView );
  let sDim  = this.tools.ray.dimGet( rayView );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( polygon ), 'polygon must be a convex polygon' );
  debugger;

  let dims = _.Matrix.DimsOf( polygon );
  _.assert( sDim === dims[ 0 ], 'Polygon and ray must have the same dimension' );

  if( this.rayIntersects( polygon, rayView ) )
  return 0;

  let closestPoint = this.rayClosestPoint( polygon, rayView );

  let distance = this.tools.ray.pointDistance( rayView, closestPoint );

  return distance;
}

//

/**
  * Returns the closest point in a convex polygon to a ray. Returns the coordinates of the closest point.
  * The polygon and ray remain unchanged.
  *
  * @param { Polygon } polygon - Source convex polygon.
  * @param { Array } ray - Source ray.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.rayClosestPoint( polygon , [ - 1, - 1, - 1, -0.1, -0.1, -0.1 ] );
  *
  * @returns { Array } Returns the array of coordinates of the closest point in the convex polygon.
  * @function rayClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( ray ) is not ray.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function rayClosestPoint( polygon, ray, dstPoint )
{
  let rayView = this.tools.vectorAdapter.from( ray );
  let sOrigin = this.tools.ray.originGet( rayView );
  let sDim  = this.tools.ray.dimGet( rayView );
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  _.assert( this.is( polygon ), 'Polygon must be a convex polygon' );
  debugger;

  let dims = _.Matrix.DimsOf( polygon );
  _.assert( sDim === dims[ 0 ], 'Polygon and ray must have the same dimension' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( sDim );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  _.assert( dstPointView.length === dims[ 0 ], 'Polygon and dstPoint must have the same dimension' );

  if( this.rayIntersects( polygon, rayView ) )
  return 0;

  let point = this.tools.vectorAdapter.from( this.tools.long.make( sDim ) );

  let dist = Infinity;

  /* ray origin */
  let dOrigin = this.pointDistance( polygon, sOrigin );

  if( dOrigin < dist )
  {
    dist = dOrigin;
    point = this.tools.vectorAdapter.from( this.pointClosestPoint( polygon, sOrigin ) );
  }

  /* polygon vertices */
  for ( let j = 0 ; j < dims[ 1 ] ; j++ )
  {
    let newVertex = polygon.colGet( j );
    let d = this.tools.ray.pointDistance( rayView, newVertex );

    if( d < dist )
    {
      point = this.tools.vectorAdapter.from( newVertex );
      dist = d;
    }
  }

  for( var i = 0; i < dstPointView.length; i++ )
  {
    dstPointView.eSet( i, point.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Check if a convex polygon contains a segment. Returns true if it is contained, false if not.
  * Convex polygon and segment remain unchanged.
  *
  * @param { Polygon } polygon - Source polygon.
  * @param { Array } segment - Source segment.
  *
  * @example
  * // returns false;
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy([
  *   0,   1,   1,   0,
  *   0,   1,   1,   0,
  *   0,   1,   3,   3
  * ]);
  * _.segmentContains( polygon , [ 0, 0, 1, 5, 5, 5 ] );
  *
  * @returns { Boolean } Returns true if the polygon contains the segment.
  * @function segmentIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function segmentContains( polygon, segment )
{

  let segmentView = this.tools.vectorAdapter.from( segment );
  let sOrigin = this.tools.segment.originGet( segmentView );
  let sEnd = this.tools.segment.endPointGet( segmentView );
  let sDim  = this.tools.segment.dimGet( segmentView );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( polygon ), 'polygon must be a convex polygon' );
  debugger;

  let dims = _.Matrix.DimsOf( polygon );
  _.assert( sDim === dims[ 0 ], 'Polygon and segment must have the same dimension' );

  if( !this.pointContains( polygon, sOrigin ) )
  return false;

  if( !this.pointContains( polygon, sEnd ) )
  return false;

  return true;
}

//

/**
  * Check if a convex polygon and a segment intersect. Returns true if they intersect.
  * Convex polygon and segment remain unchanged.
  *
  * @param { Polygon } polygon - Source polygon.
  * @param { Array } segment - Source segment.
  *
  * @example
  * // returns false;
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.segmentIntersects( polygon , [ 4, 4, 4, 5, 5, 5 ] );
  **
  * @returns { Boolean } Returns true if the polygon and the segment intersect.
  * @function segmentIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function segmentIntersects( polygon, segment )
{

  let segmentView = this.tools.vectorAdapter.from( segment );
  let sOrigin = this.tools.segment.originGet( segmentView );
  let sEnd = this.tools.segment.endPointGet( segmentView );
  let sDim  = this.tools.segment.dimGet( segmentView );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( polygon ), 'polygon must be a convex polygon' );
  debugger;

  let dims = _.Matrix.DimsOf( polygon );
  _.assert( sDim === dims[ 0 ], 'Polygon and segment must have the same dimension' );

  let containOrigin = this.pointContains( polygon, sOrigin );
  let containEnd = this.pointContains( polygon, sEnd );
  if( containOrigin === true || containEnd === true )
  {
    return true;
  }

  for( let i = 0 ; i < dims[ 1 ] ; i = i + 1 )
  {
    let j = ( i + 1 <= dims[ 1 ] - 1 ) ? i + 1 : 0;

    let vertex = polygon.colGet( i );
    let nextVertex = polygon.colGet( j );
    let segmentP = this.tools.segment.fromPair( [ vertex, nextVertex ] );

    if( this.tools.segment.segmentIntersects( segmentP, segmentView ) )
    {
      return true;
    }
  }

  if( dims[ 0 ] > 2 )
  {
    let normal = this.tools.vectorAdapter.from( this.tools.longMakeZeroed( dims[ 0 ] ) );
    let plane = this.tools.vectorAdapter.from( this.tools.longMakeZeroed( dims[ 0 ] + 1 ) );
    let i = 0;

    while( this.tools.vectorAdapter.allEquivalent( normal, this.tools.vectorAdapter.fromNumber( 0, dims[ 0 ] ) ) && ( i <= dims[ 1 ] - 3 ) )
    {
      let pointOne = polygon.colGet( i );
      let pointTwo = polygon.colGet( i + 1 );
      let pointThree = polygon.colGet( i + 2 );
      plane = this.tools.plane.fromPoints( null, pointOne, pointTwo, pointThree );
      normal = this.tools.plane.normalGet( plane );
      i = i + 1;
    }

    if( this.tools.segment.planeIntersects( segmentView, plane ) )
    {
      let copOrigin = this.tools.plane.pointCoplanarGet( plane, sOrigin );
      let copEnd = this.tools.plane.pointCoplanarGet( plane, sEnd );
      let copSegment = this.tools.segment.fromPair( [ copOrigin, copEnd ] );
      debugger;
      if( this.tools.segment.segmentIntersects( segmentView, copSegment ) )
      {
        let intPoint = this.tools.segment.segmentIntersectionPoint( segmentView, copSegment );

        if( this.pointContains( polygon, intPoint ) )
        return true;
      }
    }
  }

  return false;
}

//

/**
  * Get the distance between a convex polygon and a segment. Returns the calculated distance.
  * Convex polygon and segment remain unchanged.
  *
  * @param { Polygon } polygon - Source polygon.
  * @param { Array } segment - Source segment.
  *
  * @example
  * // returns Math.sqrt( 19 );
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.segmentDistance( polygon , [ 4, 4, 4, 5, 5, 5 ] );
  **
  * @returns { Number } Returns the distance between the polygon and the segment, 0 if they intersect.
  * @function segmentDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function segmentDistance( polygon, segment )
{

  let segmentView = this.tools.vectorAdapter.from( segment );
  let sOrigin = this.tools.segment.originGet( segmentView );
  let sEnd = this.tools.segment.endPointGet( segmentView );
  let sDim  = this.tools.segment.dimGet( segmentView );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( polygon ), 'polygon must be a convex polygon' );
  debugger;

  let dims = _.Matrix.DimsOf( polygon );
  _.assert( sDim === dims[ 0 ], 'Polygon and segment must have the same dimension' );

  if( this.segmentIntersects( polygon, segmentView ) )
  return 0;

  let closestPoint = this.segmentClosestPoint( polygon, segmentView );

  let distance = this.tools.segment.pointDistance( segmentView, closestPoint );

  return distance;
}

//

/**
  * Returns the closest point in a convex polygon to a segment. Returns the coordinates of the closest point.
  * The polygon and segment remain unchanged.
  *
  * @param { Polygon } polygon - Source convex polygon.
  * @param { Array } segment - Source segment.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.segmentClosestPoint( polygon , [ - 1, - 1, - 1, -0.1, -0.1, -0.1 ] );
  *
  * @returns { Array } Returns the array of coordinates of the closest point in the convex polygon.
  * @function segmentClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function segmentClosestPoint( polygon, segment, dstPoint )
{
  let segmentView = this.tools.vectorAdapter.from( segment );
  let sOrigin = this.tools.segment.originGet( segmentView );
  let sEnd = this.tools.segment.endPointGet( segmentView );
  let sDim  = this.tools.segment.dimGet( segmentView );
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  _.assert( this.is( polygon ), 'Polygon must be a convex polygon' );
  debugger;

  let dims = _.Matrix.DimsOf( polygon );
  _.assert( sDim === dims[ 0 ], 'Polygon and segment must have the same dimension' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( sDim );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  _.assert( dstPointView.length === dims[ 0 ], 'Polygon and dstPoint must have the same dimension' );

  if( this.segmentIntersects( polygon, segmentView ) )
  return 0;

  let point = this.tools.vectorAdapter.from( this.tools.long.make( sDim ) );

  let dist = Infinity;

  /* segment corners */
  let dOrigin = this.pointDistance( polygon, sOrigin );
  let dEnd = this.pointDistance( polygon, sEnd );

  if( dOrigin < dist )
  {
    dist = dOrigin;
    point = this.tools.vectorAdapter.from( this.pointClosestPoint( polygon, sOrigin ) );
  }

  if( dEnd < dist )
  {
    dist = dEnd;
    point = this.tools.vectorAdapter.from( this.pointClosestPoint( polygon, sEnd ) );
  }

  /* polygon vertices */
  for ( let j = 0 ; j < dims[ 1 ] ; j++ )
  {
    let newVertex = polygon.colGet( j );
    let d = this.tools.segment.pointDistance( segmentView, newVertex );

    if( d < dist )
    {
      point = this.tools.vectorAdapter.from( newVertex );
      dist = d;
    }
  }

  for( var i = 0; i < dstPointView.length; i++ )
  {
    dstPointView.eSet( i, point.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Check if a convex polygon and a sphere intersect. Returns true if they intersect.
  * Convex polygon and sphere remain unchanged.
  *
  * @param { Polygon } polygon - Source polygon.
  * @param { Array } sphere - Source sphere.
  *
  * @example
  * // returns false;
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.sphereIntersects( polygon , [ 4, 4, 4, 1 ] );
  **
  * @returns { Boolean } Returns true if the polygon and the sphere intersect.
  * @function sphereIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function sphereIntersects( polygon, sphere )
{

  let sphereView = this.tools.sphere.adapterFrom( sphere );
  let center = this.tools.sphere.centerGet( sphereView );
  let radius = this.tools.sphere.radiusGet( sphereView );
  let dimS = this.tools.sphere.dimGet( sphereView );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( polygon ), 'polygon must be a convex polygon' );
  debugger;

  let dims = _.Matrix.DimsOf( polygon );
  _.assert( dimS === dims[ 0 ], 'Polygon and sphere must have the same dimension' );

  let distance = this.pointDistance( polygon, center );

  // if( distance <= radius )
  if( this.tools.avector.isLessEqualAprox( distance, radius ) )
  return true;

  return false;
}

//

/**
  * Get the distance between a convex polygon and a sphere. Returns the calculated distance.
  * Convex polygon and sphere remain unchanged.
  *
  * @param { Polygon } polygon - Source polygon.
  * @param { Array } sphere - Source sphere.
  *
  * @example
  * // returns Math.sqrt( 18 );
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.sphereDistance( polygon , [ 4, 4, 4, 1 ] );
  **
  * @returns { Number } Returns the distance between the polygon and the sphere, 0 if they intersect.
  * @function sphereDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function sphereDistance( polygon, sphere )
{

  let sphereView = this.tools.sphere.adapterFrom( sphere );
  let center = this.tools.sphere.centerGet( sphereView );
  let radius = this.tools.sphere.radiusGet( sphereView );
  let dimS = this.tools.sphere.dimGet( sphereView );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( polygon ), 'polygon must be a convex polygon' );
  debugger;

  let dims = _.Matrix.DimsOf( polygon );
  _.assert( dimS === dims[ 0 ], 'Polygon and sphere must have the same dimension' );

  if( this.sphereIntersects( polygon, sphereView ) )
  return 0;

  let distance = this.pointDistance( polygon, center ) - radius;

  _.assert( distance > 0 );
  return distance;
}

//

/**
  * Returns the closest point in a convex polygon to a sphere. Returns the coordinates of the closest point.
  * The polygon and sphere remain unchanged.
  *
  * @param { Polygon } polygon - Source convex polygon.
  * @param { Array } sphere - Source sphere.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.sphereClosestPoint( polygon , [ - 1, - 1, - 1, 0.1 ] );
  *
  * @returns { Array } Returns the array of coordinates of the closest point in the convex polygon.
  * @function sphereClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( polygon ) is not a convex polygon.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */

function sphereClosestPoint( polygon, sphere, dstPoint )
{

  let sphereView = this.tools.sphere.adapterFrom( sphere );
  let center = this.tools.sphere.centerGet( sphereView );
  let radius = this.tools.sphere.radiusGet( sphereView );
  let dimS = this.tools.sphere.dimGet( sphereView );
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  _.assert( this.is( polygon ), 'Polygon must be a convex polygon' );
  debugger;

  let dims = _.Matrix.DimsOf( polygon );
  _.assert( dimS === dims[ 0 ], 'Polygon and sphere must have the same dimension' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimS );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  _.assert( dstPointView.length === dims[ 0 ], 'Polygon and dstPoint must have the same dimension' );

  if( this.sphereIntersects( polygon, sphereView ) )
  return 0;

  let point = this.pointClosestPoint( polygon, center, this.tools.vectorAdapter.from( this.tools.long.make( dimS ) ) );


  for( var i = 0; i < dstPointView.length; i++ )
  {
    dstPointView.eSet( i, point.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Get the bounding sphere of a convex polygon. Returns destination sphere.
  * Polygon and sphere are stored in Array data structure. Source polygon stays untouched.
  *
  * @param { Array } dstSphere - destination sphere.
  * @param { Array } polygon - source polygon for the bounding sphere.
  *
  * @example
  * // returns [ 0, 0, 0, 1 ]
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([
  *    0,   0,   0,   0,
  *    1,   0, - 1,   0,
  *    0,   1,   0, - 1
  *  ]);
  * _.boundingSphereGet( polygon, null );
  *
  * @returns { Array } Returns the array of the bounding sphere.
  * @function boundingSphereGet
  * @throws { Error } An Error if ( dim ) is different than dimGet( polygon ) (the polygon and the sphere don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstSphere ) is not sphere
  * @throws { Error } An Error if ( polygon ) is not convex polygon
  * @namespace wTools.convexPolygon
  * @module Tools/math/Concepts
  */
function boundingSphereGet( polygon, dstSphere )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  _.assert( this.is( polygon ) );
  let dims = _.Matrix.DimsOf( polygon ) ;
  let rows = dims[ 0 ];
  let cols = dims[ 1 ];

  if( dstSphere === null || dstSphere === undefined )
  dstSphere = this.tools.sphere.makeZero( rows );

  _.assert( _.sphere.is( dstSphere ) );
  let dstSphereView = this.tools.sphere.adapterFrom( dstSphere );
  let center = this.tools.sphere.centerGet( dstSphereView );
  let radiusSphere = this.tools.sphere.radiusGet( dstSphereView );
  let dimSphere = this.tools.sphere.dimGet( dstSphereView );

  _.assert( rows === dimSphere, 'Polygon and sphere must have the same dimension' );

  // Polygon limits
  let max = polygon.colGet( 0 ).clone();
  let min = polygon.colGet( 0 ).clone();

  for( let j = 1 ; j < cols ; j++ )
  {
    let newp = polygon.colGet( j );
    for( let i = 0; i < rows; i++ )
    {
      if( newp.eGet( i ) < min.eGet( i ) )
      {
        min.eSet( i, newp.eGet( i ) );
      }

      if( newp.eGet( i ) > max.eGet( i ) )
      {
        max.eSet( i, newp.eGet( i ) );
      }
    }
  }

  // Center of the sphere
  for( let c = 0; c < center.length; c++ )
  {
    center.eSet( c, ( max.eGet( c ) + min.eGet( c ) ) / 2 );
  }

  // Radius of the sphere
  this.tools.sphere.radiusSet( dstSphereView, this.tools.vectorAdapter.distance( center, max ) );

  return dstSphere;
}


// --
// declare
// --


let Extension = /* qqq xxx : normalize order */
{

  is,
  isPolygon,
  isValid,
  isConvex,
  isConcave,
  isClockwise,
  angleThreePoints,

  make,

  pointContains,
  pointContains2D,
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

  segmentContains,
  segmentIntersects,
  segmentDistance,
  segmentClosestPoint,

  sphereIntersects,
  sphereDistance,
  sphereClosestPoint,
  boundingSphereGet,

  // ref

  tools : _,
}

/* _.props.extend */Object.assign( _.convexPolygon, Extension );

})();
