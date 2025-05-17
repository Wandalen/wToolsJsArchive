(function _Geometric_s_()
{

'use strict';

/**
 * Collection of geometric math functions. Based on module MathVector.
  @module Tools/math/Geometric
  @extends Tools.math
*/

/**
 * Collection of geometric math functions
*/

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../node_modules/Tools' );

  _.include( 'wMathScalar' );
  _.include( 'wMathVector' );

}

//

const _ = _global_.wTools;
const _min = Math.min;
const _max = Math.max;
let _arraySlice = Array.prototype.slice;
let _sqrt = Math.sqrt;
const _sqr = _.math.sqr;
let _sign = _.math.sign;

let avector = _.avector;
let _distanceSqr = avector.distanceSqr;
let _dot = avector.dot;
let _mag = avector.mag;
let _magSqr = avector.magSqr;

const Self = _.math = _.math || _.props.extend( null, _.props.of( Math, { onlyOwn : 1, onlyEnumerable : 0 } ) );

_.assert( _.math.cos === Math.cos );
_.assert( _.object.isBasic( avector ) );

// --
// iterator
// --

function eachEdgeOfCube( onEdge )
{

  let axis = [ 0, 1, 2 ];
  let sign = [ 1, 1, 1 ];
  let index = 0;

  for( axis[ 0 ] = 0 ; axis[ 0 ] < 3 ; axis[ 0 ]++ )
  {

    if( axis[ 0 ] === 0 )
    {
      axis[ 1 ] = 1;
      axis[ 2 ] = 2;
    }
    else if( axis[ 0 ] === 1 )
    {
      axis[ 1 ] = 0;
      axis[ 2 ] = 2;
    }
    else if( axis[ 0 ] === 2 )
    {
      axis[ 1 ] = 0;
      axis[ 2 ] = 1;
    }

    sign[ 0 ] = 1;

    for( sign[ 1 ] = 1 ; sign[ 1 ] >= -1 ; sign[ 1 ] -= 2 )
    {

      for( sign[ 2 ] = 1 ; sign[ 2 ] >= -1 ; sign[ 2 ] -= 2 )
      {

        onEdge( axis, sign, index );
        index++;

      }

    }

  }

}

//

function eachPlaneOfCube( onPlane )
{

  let axis = [ 0, 1, 2 ];
  let sign = [ 1, 1, 1 ];
  let index = 0;

  for( axis[ 0 ] = 0 ; axis[ 0 ] < 3 ; axis[ 0 ]++ )
  {

    if( axis[ 0 ] === 0 )
    {
      axis[ 1 ] = 1;
      axis[ 2 ] = 2;
    }
    else if( axis[ 0 ] === 1 )
    {
      axis[ 1 ] = 0;
      axis[ 2 ] = 2;
    }
    else if( axis[ 0 ] === 2 )
    {
      axis[ 1 ] = 0;
      axis[ 2 ] = 1;
    }

    for( let sign = 1 ; sign >= -1 ; sign -= 2 )
    {

      onPlane( axis, sign, index );
      index++;

    }

  }

}

// --
// d2
// --

// function d2LineGeneralEqWithPoints( point1, point2 )
// {
//   let result = [];

//   result[ 0 ] = point1[ 1 ] - point2[ 1 ];
//   result[ 1 ] = point2[ 0 ] - point1[ 0 ];
//   result[ 2 ] = point2[ 1 ] * point1[ 0 ] - point2[ 0 ] * point1[ 1 ];

//   return result;
// }


// d2LineGeneralEqWithPoints.shaderChunk =

// `
//   vec3 d2LineGeneralEqWithPoints( vec2 point1, vec2 point2 )
//   {
//     vec3 result;

//     result[ 0 ] = point1[ 1 ] - point2[ 1 ];
//     result[ 1 ] = point2[ 0 ] - point1[ 0 ];
//     result[ 2 ] = point2[ 1 ] * point1[ 0 ] - point2[ 0 ] * point1[ 1 ];

//     return result;
//   }
// `

//

// function d2LineGeneralEqWithPointAndTangent( point, tangent )
// {
//   let result = [];

//   result[ 0 ] = - tangent[ 1 ];
//   result[ 1 ] = + tangent[ 0 ];
//   result[ 2 ] = ( point[ 1 ]+tangent[ 1 ] ) * point[ 0 ] - ( point[ 0 ]+tangent[ 0 ] ) * point[ 1 ];

//   return result;
// }

// d2LineGeneralEqWithPointAndTangent.shaderChunk =
// `
//   vec3 d2LineGeneralEqWithPointAndTangent( vec2 point, vec2 tangent )
//   {
//     vec3 result;

//     result[ 0 ] = - tangent[ 1 ];
//     result[ 1 ] = + tangent[ 0 ];
//     result[ 2 ] = ( point[ 1 ]+tangent[ 1 ] ) * point[ 0 ] - ( point[ 0 ]+tangent[ 0 ] ) * point[ 1 ];

//     return result;
//   }
// `

//

// function d2LineLineGeneralEqIntersection( lineGeneralEq1, lineGeneralEq2 )
// {
//   let result = [];

//   let d = lineGeneralEq1[ 0 ]*lineGeneralEq2[ 1 ] - lineGeneralEq1[ 1 ]*lineGeneralEq2[ 0 ];
//   let x = lineGeneralEq1[ 1 ]*lineGeneralEq2[ 2 ] - lineGeneralEq1[ 2 ]*lineGeneralEq2[ 1 ];
//   let y = lineGeneralEq1[ 2 ]*lineGeneralEq2[ 0 ] - lineGeneralEq1[ 0 ]*lineGeneralEq2[ 2 ];

//   result[ 0 ] = x / d;
//   result[ 1 ] = y / d;

//   return result;
// }

// d2LineLineGeneralEqIntersection.shaderChunk =

// `
//   vec2 d2LineLineGeneralEqIntersection( vec3 lineGeneralEq1, vec3 lineGeneralEq2 )
//   {
//     vec2 result;

//     float d = lineGeneralEq1[ 0 ]*lineGeneralEq2[ 1 ] - lineGeneralEq1[ 1 ]*lineGeneralEq2[ 0 ];
//     float x = lineGeneralEq1[ 1 ]*lineGeneralEq2[ 2 ] - lineGeneralEq1[ 2 ]*lineGeneralEq2[ 1 ];
//     float y = lineGeneralEq1[ 2 ]*lineGeneralEq2[ 0 ] - lineGeneralEq1[ 0 ]*lineGeneralEq2[ 2 ];

//     result[ 0 ] = x / d;
//     result[ 1 ] = y / d;

//     return result;
//   }
// `

//

// function d2LineGeneraEqPointDistance( lineGeneralEq, point )
// {
//   let result;

//   let n = [ lineGeneralEq[ 0 ], lineGeneralEq[ 1 ] ];
//   let d = _sqrt( lineGeneralEq[ 0 ]*lineGeneralEq[ 0 ] + lineGeneralEq[ 1 ]*lineGeneralEq[ 1 ] );

//   result = ( lineGeneralEq[ 2 ] + _.avector.dot( n, point ) ) / d;

//   return result;
// }

//

// function d2LinePointDistanceCentered( lineCentered, pointCentered )
// {
//   let d = _dot( [ -lineCentered[ 1 ], +lineCentered[ 0 ] ], pointCentered );
//   return d / _mag( lineCentered );
// }

//

// function d2LinePointDistance( linePoints, point )
// {

//   let lineCentered = avector.sub( linePoints[ 1 ].slice(), linePoints[ 0 ] );
//   let pointCentered = avector.sub( point.slice(), linePoints[ 0 ] );

//   return d2LinePointDistanceCentered( lineCentered, pointCentered );
// }

//

// function d2SegmentToPointDistanceSqr( segmentPoints, point ) // xxx
// {
//   let t = relativeSegment( segmentPoints, point );

//   if( t < 0 )
//   {
//     return _distanceSqr( segmentPoints[ 0 ], point );
//   }
//   else if( t > 1 )
//   {
//     return _distanceSqr( segmentPoints[ 1 ], point );
//   }
//   else
//   {
//     return _sqr( d2LinePointDistance( segmentPoints, point ) );
//   }

// }

//

// function d2PolygonPointDistanceSqr( polygon, point )
// {

//   let p = 0;
//   let pl = polygon.length / 2;
//   let p1 = [ polygon[ (pl-1)*2+0 ], polygon[ (pl-1)*2+1 ] ];
//   let p2 = [ polygon[ (p+0)*2+0 ], polygon[ (p+0)*2+1 ] ];
//   let smallest = d2SegmentToPointDistanceSqr( [ p1, p2 ], point );

//   for( p = 1 ; p < pl ; p++ )
//   {

//     let p1 = [ polygon[ (p-1)*2+0 ], polygon[ (p-1)*2+1 ] ];
//     let p2 = [ polygon[ (p+0)*2+0 ], polygon[ (p+0)*2+1 ] ];
//     let d = d2SegmentToPointDistanceSqr( [ p1, p2 ], point );
//     if( d < smallest ) smallest = d;

//   }

//   return smallest;
// }

//

// function d2PolygonPointDistance( polygon, point )
// {
//   let result = d2PolygonPointDistanceSqr( polygon, point );
//   return _sqrt( result );
// }

//

// function d2PolygonPointInside( polygon, point )
// {
//   let self = this;
//   //let c = [ point[ 0 ], point[ 1 ], 1 ];
//   let line21 = [];
//   let line20 = [];
//   let p = 0;
//   let pl = polygon.length / 2;
//   let inside = 0;

//   //

//   function pointsPointSide( points, point )
//   {

//     let point1 = [];
//     point1[ 0 ] = points[ 0 ][ 0 ] - point[ 0 ];
//     point1[ 1 ] = points[ 0 ][ 1 ] - point[ 1 ];

//     let point2 = [];
//     point2[ 0 ] = points[ 1 ][ 0 ] - point[ 0 ];
//     point2[ 1 ] = points[ 1 ][ 1 ] - point[ 1 ];

//     if( point1[ 0 ] < 0 && point2[ 0 ] < 0 )
//     return false;

//     if( point1[ 0 ] > 0 && point2[ 0 ] > 0 )
//     return false;

//     if( point1[ 0 ] === point2[ 0 ] )
//     {
//       if( point1[ 1 ] < 0 && point2[ 1 ] < 0 )
//       return false;

//       if( point1[ 1 ] > 0 && point2[ 1 ] > 0 )
//       return false;

//       return 2;
//     }

//     let upper = point2[ 1 ] - point2[ 0 ] * ( point1[ 1 ]-point2[ 1 ] ) / ( point1[ 0 ]-point2[ 0 ] );

//     if( upper === 0 )
//     return 2;

//     return upper >= 0;
//   }

//   //

//   let p1 = [ polygon[ (pl-1)*2+0 ], polygon[ (pl-1)*2+1 ] ];
//   let p2 = [ polygon[ (p+0)*2+0 ], polygon[ (p+0)*2+1 ] ];
//   let side = pointsPointSide( [ p1, p2 ], point );
//   if( side === 2 ) return 1;
//   inside = inside + side;

//   //

//   for( p = 1 ; p < pl ; p++ )
//   {

//     let p1 = [ polygon[ (p-1)*2+0 ], polygon[ (p-1)*2+1 ] ];
//     let p2 = [ polygon[ (p+0)*2+0 ], polygon[ (p+0)*2+1 ] ];
//     let side = pointsPointSide( [ p1, p2 ], point );
//     if( side === 2 ) return p+1;
//     inside = inside + side;

//   }

//   return inside % 2 ? pl+1 : 0;
// }

//

function d2PolygonConvexPointInside( polygon, point )
{
  let self = this;
  let p = 0;
  let pl = polygon.length / 2;

  let p1 = [ polygon[ (pl-1)*2+0 ], polygon[ (pl-1)*2+1 ] ];
  let p2 = [ polygon[ (p+0)*2+0 ], polygon[ (p+0)*2+1 ] ];
  let side = _d2LinePointsToPointSide( [ p1, p2 ], point );
  if( side === 0 )
  //return polygon.length;
  return 0;
  side = _sign( side );

  for( p = 1 ; p < pl ; p++ )
  {
    let p1 = [ polygon[ (p-1)*2+0 ], polygon[ (p-1)*2+1 ] ];
    let p2 = [ polygon[ (p+0)*2+0 ], polygon[ (p+0)*2+1 ] ];
    let cside = _d2LinePointsToPointSide( [ p1, p2 ], point );
    if( cside === 0 )
    //return p;
    return 0;
    cside = _sign( cside );
    if( cside !== side )
    return 0;
  }

  return pl+1;
}

//

// function d2PolygonConcavePointInside( polygon, point )
// {
//   let self = this;

//   let p = 0;
//   let pl = polygon.length / 2;
//   let p1 = [ polygon[ (pl-1)*2+0 ], polygon[ (pl-1)*2+1 ] ];

//   for( p = 1 ; p < pl ; p++ )
//   {

//     let p2 = [ polygon[ (p-1)*2+0 ], polygon[ (p-1)*2+1 ] ];
//     let p3 = [ polygon[ (p+0)*2+0 ], polygon[ (p+0)*2+1 ] ];

//     let side = _d2LinePointsToPointSide( [ p1, p2 ], point );
//     if( side === 0 )
//     {
//       let r = relativeSegment( [ p1, p2 ], point );
//       return 0 <= r && r <= 1 ? p : 0;
//     }

//     let cside1 = _d2LinePointsToPointSide( [ p2, p3 ], point );
//     if( side*cside1 < 0 )
//     continue;
//     else if( cside1 === 0 )
//     {
//       let r = relativeSegment( [ p2, p3 ], point );
//       return 0 <= r && r <= 1 ? p : 0;
//     }

//     let cside2 = _d2LinePointsToPointSide( [ p3, p1 ], point );
//     if( side*cside2 < 0 )
//     continue;
//     else if( cside2 === 0 )
//     {
//       let r = relativeSegment( [ p3, p1 ], point );
//       return 0 <= r && r <= 1 ? p : 0;
//     }

//     return pl+1;
//   }

//   return 0;
// }

//

function d2PolygonIsClockwise( polygon )
{
  let result = 0;

  _.assert( _.longIs( polygon ) );
  _.assert( polygon.length % 2 === 0 );
  _.assert( arguments.length === 1, 'Expects single argument' );

  let l = polygon.length / 2;
  for( let p = l-1 ; p >= 0 ; p-- )
  {
    let p2 = p + 1;
    if( p2 === l )
    p2 = 0;
    result += ( polygon[ p*2+0 ] - polygon[ p2*2+0 ] ) * ( polygon[ p*2+1 ] + polygon[ p2*2+1 ] );
  }

  _.assert( _.numberIsFinite( result ) );

  return result > 0;
}

//

// function _d2LinePointsToPointSide( segmentPoints, point )
// {

//   let point0x = point[ 0 ] - segmentPoints[ 0 ][ 0 ];
//   let point0y = point[ 1 ] - segmentPoints[ 0 ][ 1 ];

//   let point1x = segmentPoints[ 1 ][ 0 ] - segmentPoints[ 0 ][ 0 ];
//   let point1y = segmentPoints[ 1 ][ 1 ] - segmentPoints[ 0 ][ 1 ];

//   let result = point0x * point1y - point0y * point1x;

//   return result;
// /*
//   let point0 = [ point[ 0 ] - segmentPoints[ 0 ][ 0 ], point[ 1 ] - segmentPoints[ 0 ][ 1 ] ];
//   let point1 = [ segmentPoints[ 1 ][ 0 ] - segmentPoints[ 0 ][ 0 ], segmentPoints[ 1 ][ 1 ] - segmentPoints[ 0 ][ 1 ] ];

//   let result = point0[ 0 ] * point1[ 1 ] - point0[ 1 ] * point1[ 0 ];

//   return result;
// */
// }

//

// function _d2LinePointsToPointDistance( segmentPoints, point )
// {

//   let point0x = point[ 0 ] - segmentPoints[ 0 ][ 0 ];
//   let point0y = point[ 1 ] - segmentPoints[ 0 ][ 1 ];

//   let point1x = segmentPoints[ 1 ][ 0 ] - segmentPoints[ 0 ][ 0 ];
//   let point1y = segmentPoints[ 1 ][ 1 ] - segmentPoints[ 0 ][ 1 ];

//   let result = point0x * point1y - point0y * point1x;
//   result /= _sqrt( point1x*point1x + point1y*point1y );

//   return result;
// }

//
/*
function d2TriPointDistanceSqr( tri, point )
{

  let areaABP = tri[ 0 ]*tri[ 3 ] - tri[ 0 ]*point[ 1 ] + tri[ 1 ]*point[ 0 ] - tri[ 1 ]*tri[ 2 ] + tri[ 2 ]*point[ 1 ] - tri[ 3 ]*point[ 0 ];
  let areaABC = tri[ 0 ]*tri[ 3 ] - tri[ 0 ]*tri[ 5 ] + tri[ 1 ]*tri[ 4 ] - tri[ 1 ]*tri[ 2 ] + tri[ 2 ]*tri[ 5 ] - tri[ 3 ]*tri[ 4 ];

  return areaABP / areaABC;
}
*/

//

// function d2TriPointInside( tri, point )
// {

//   _.assert( tri.length === 6, 'd2TriPointDistance :', 'Expects triangle as arguments' );

//   let s1 = _d2LinePointsToPointSide( [ [ tri[ 0 ], tri[ 1 ] ], [ tri[ 2 ], tri[ 3 ] ] ], point );

//   let s2 = _d2LinePointsToPointSide( [ [ tri[ 2 ], tri[ 3 ] ], [ tri[ 4 ], tri[ 5 ] ] ], point );
//   if( s1*s2 < 0 )
//   return false;

//   let s3 = _d2LinePointsToPointSide( [ [ tri[ 4 ], tri[ 5 ] ], [ tri[ 0 ], tri[ 1 ] ] ], point );
//   if( s1*s3 < 0 )
//   return false;

//   return true;
// }

// --
// angle
// --

function angle3dPlaneVector180( plane, v )
{

  let a = -this.angle3dCos( plane, v );
  //console.log( 'a : ', a*180/Math.PI );
  a += Math.PI / 2;
  if( a > Math.PI ) a -= Math.PI;
  return a;

}

//

function angle3dPlaneVector360( plane, v )
{

  let a = this.angle3d( plane, v );
  a += Math.PI / 2;
  if( a > Math.PI*2 ) a -= Math.PI*2;
  return a ;

}

//

function angle3d( v1, v2 )
{

  let tnb = this.tnbMake1( v1 );
  let cross = v1.slice().cross( v2 );
  let ndot = cross.dot( tnb.n );
  let bdot = cross.dot( tnb.b );
  let nbdot = ( Math.abs( ndot ) > Math.abs( bdot ) ) ? ndot : bdot;

  let angle = Math.atan2( cross.length(), v1.dot( v2 ) );
  if( nbdot > 0 ) angle = 2*Math.PI - angle;
  return angle;

}

//

function angle3dAtan( v1, v2 )
{

  return Math.atan2(
    v1.slice()
    .cross( v2 )
    .length(),
    v1.dot( v2 )
  );

}

//

function angle3dCos( v1, v2 )
{

  return Math.acos( v1.slice().dot( v2 ) / (v1.length() * v2.length()) );

}

//

/**
 * Angle betwen two vector with atan2.
 * @return {number} angle - Angle in range [ 0..+2*PI ]
 * @param {array} v1 - input vector.
 * @param {array} v2 - input vector.
 * @method d2Angle
 * @namespace wTools.math
 * @module Tools/math/Geometric
 */

function d2Angle( v1, v2 )
{
  let result;

  result = Math.atan2( v2[ 1 ], v2[ 0 ] ) - Math.atan2( v1[ 1 ], v1[ 0 ] );

  if( result < 0 )
  result = 2*Math.PI + result;

  return result;
}

d2Angle.shaderChunk =

`
  float d2Angle( vec2 v1, vec2 v2 )
  {
    float result;

    result = atan( v2[ 1 ], v2[ 0 ] ) - atan( v1[ 1 ], v1[ 0 ] );

    if( result < 0.0 )
    result = 2.0*CONSTANT_PI + result;

    return result;
  }
`

//

/**
 * Angle betwen two vector with acos.
 * @return {number} angle - Angle in range [ 0..+PI ]
 * @param {array} v1 - input vector.
 * @param {array} v2 - input vector.
 * @method d2AngleWithCos
 * @namespace wTools.math
 * @module Tools/math/Geometric
 */

function d2AngleWithCos( v1, v2 )
{

  let m1 = _sqrt( _sqr( v1[ 0 ] ) + _sqr( v1[ 1 ] ) );
  let m2 = _sqrt( _sqr( v2[ 0 ] ) + _sqr( v2[ 1 ] ) );
  let m = m1*m2;
  if( m <= this.accuracy )return 0;
  let d = v1[ 0 ]*v2[ 0 ] + v1[ 1 ]*v2[ 1 ] ;

  return Math.acos( _.math.clamp( d / m, -1, 1 ) );
}

//

/**
 * Angle betwen two vector with acos.
 * Unsafe because does not treat unnormal input case.
 * @return {number} angle - Angle in range [ 0..+PI ]
 * @param {array} v1 - input vector.
 * @param {array} v2 - input vector.
 * @method d2AngleWithCos
 * @namespace wTools.math
 * @module Tools/math/Geometric
 */

function d2AngleWithCosFast( v1, v2 )
{

  let m1 = _sqrt( _sqr( v1[ 0 ] ) + _sqr( v1[ 1 ] ) );
  let m2 = _sqrt( _sqr( v2[ 0 ] ) + _sqr( v2[ 1 ] ) );
  let m = m1*m2;
  let d = v1[ 0 ]*v2[ 0 ] + v1[ 1 ]*v2[ 1 ];

  return Math.acos( d / m );
}

// --
// linear equation
// --

function d2linearEquationSolve( matrix, y )
{
  let result = [];
  let d = matrix[ 0 ]*matrix[ 3 ] - matrix[ 2 ]*matrix[ 1 ];

  _.assert( matrix.length === 4 );
  _.assert( y.length === 2 );

  result[ 0 ] = ( matrix[ 3 ]*y[ 0 ] - matrix[ 2 ]*y[ 1 ] ) / d;
  result[ 1 ] = ( matrix[ 0 ]*y[ 1 ] - matrix[ 1 ]*y[ 0 ] ) / d;

  return result;
}

d2linearEquationSolve.shaderChunk =
`
  vec2 d2linearEquationSolve( mat2 matrix, vec2 y )
  {

    vec2 result;
    float d = matrix[ 0 ][ 0 ]*matrix[ 1 ][ 1 ] - matrix[ 0 ][ 1 ]*matrix[ 1 ][ 0 ];

    result[ 0 ] = ( matrix[ 1 ][ 1 ]*y[ 0 ] - matrix[ 0 ][ 1 ]*y[ 1 ] ) / d;
    result[ 1 ] = ( matrix[ 0 ][ 0 ]*y[ 1 ] - matrix[ 1 ][ 0 ]*y[ 0 ] ) / d;

    return result;
  }
`

//

function linearEquationSolveExternal( m, y )
{

  let lu = numeric.LU( m );
  let x = numeric.LUsolve( lu, y );

  return x;
}

//

function linearEquationSolve( m, y )
{

  return this.linearEquationSolveExternal( m, y );

}

// --
// pair / ray - original
// --

function rayFromPair( pair )
{
  let result = [];
  result[ 0 ] = pair[ 0 ];
  result[ 1 ] = avector.sub( null, pair[ 1 ], pair[ 0 ] );
  return result;
}

rayFromPair.shaderChunk =
`
  void rayFromPair( out vec2 dstRay[ 2 ], vec2 pair[ 2 ] )
  {
    dstRay[ 0 ] = pair[ 0 ];
    dstRay[ 1 ] = pair[ 1 ] - pair[ 0 ];
  }

  void rayFromPair( out vec3 dstRay[ 2 ], vec3 pair[ 2 ] )
  {
    dstRay[ 0 ] = pair[ 0 ];
    dstRay[ 1 ] = pair[ 1 ] - pair[ 0 ];
  }
`

//

// function pairFromRay( dstPair, srcRay )
// {
//   dstPair = dstPair || [];
//   dstPair[ 0 ] = srcRay[ 0 ];
//   dstPair[ 1 ] = avector.add( null, srcRay[ 1 ], srcRay[ 0 ] );
//   return dstPair;
// }

//

// function rayAt( srcRay, factor )
// {
//   let result = avector.mul( null, srcRay[ 1 ], factor );
//   avector.add( result, srcRay[ 0 ] );
//   return result;
// }

// rayAt.shaderChunk =
// `
//   vec2 rayAt( vec2 srcRay[ 2 ], float factor )
//   {

//     vec2 result = srcRay[ 1 ]*factor;
//     result += srcRay[ 0 ];

//     return result;
//   }
// `

//

// function pairAt( pair, factor )
// {

//   let a = avector.mul( pair[ 0 ].slice(), 1-factor );
//   let b = avector.mul( pair[ 1 ].slice(), factor );

//   let result = avector.add( a, b );

//   return result;
// }

// pairAt.shaderChunk =
// `
//   vec2 pairAt( vec2 pair[ 2 ], float factor )
//   {

//     vec2 a = pair[ 0 ] * ( 1.0-factor );
//     vec2 b = pair[ 1 ] * factor;
//     vec2 result = a + b;

//     return result;
//   }
// `

// --
// pair / ray - from ray
// --

// function _pairPairRoutineFromRayRayRoutine( rayRayRoutine, name )
// {

//   _.assert( _.routineIs( rayRayRoutine ) );
//   _.assert( _.strIs( name ) );

//   function pairPairRoutine()
//   {
//     _.assert( arguments.length === 2, 'Expects exactly two arguments' );
//     let r1 = this.rayFromPair( arguments[ 0 ] );
//     let r2 = this.rayFromPair( arguments[ 1 ] );
//     return rayRayRoutine.call( this, r1, r2 );
//   }

//   pairPairRoutine.shaderChunk =
//   `
//     vec2 pairPair` + name + `( vec2 p1[ 2 ], vec2 p2[ 2 ] )
//     {

//       vec2 r1[ 2 ], r2[ 2 ];
//       rayFromPair( r1, p1 );
//       rayFromPair( r2, p2 );

//       return rayRay` + name + `( r1, r2 );
//     }
//   `

//   return pairPairRoutine;
// }

//

function rayRayParallel( src1Ray, src2Ray, accuracySqr )
{
  _.assert( src1Ray.length === 3 );
  _.assert( src2Ray.length === 3 );
  _.assert( arguments.length === 2 || arguments.length === 3 );

  if( accuracySqr === undefined )
  accuracySqr = this.accuracySqr;

  return _magSqr( avector.cross( src1Ray[ 1 ], src2Ray[ 1 ] ) ) <= this.accuracySqr;
}

//

function rayRayIntersectionFactors( r1, r2 )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( r1[ 0 ].length === 2, 'implemented only for d2' );
  _.assert( r2[ 0 ].length === 2, 'implemented only for d2' );

  let dorigin = avector.sub( r2[ 0 ].slice(), r1[ 0 ] );

  let y = [];
  y[ 0 ] = + dorigin[ 0 ];
  y[ 1 ] = - dorigin[ 1 ];

  let m = [];
  m[ 0 ] = + r1[ 1 ][ 0 ];
  m[ 1 ] = - r1[ 1 ][ 1 ];
  m[ 2 ] = - r2[ 1 ][ 0 ];
  m[ 3 ] = + r2[ 1 ][ 1 ];

  let x = d2linearEquationSolve( m, y );
  return x;
}

rayRayIntersectionFactors.shaderChunk =
`
  vec2 rayRayIntersectionFactors( vec2 r1[ 2 ], vec2 r2[ 2 ] )
  {

    vec2 dorigin = r2[ 0 ] - r1[ 0 ];

    vec2 y;
    y[ 0 ] = + dorigin[ 0 ];
    y[ 1 ] = - dorigin[ 1 ];

    mat2 m;
    m[ 0 ][ 0 ] = + r1[ 1 ][ 0 ];
    m[ 1 ][ 0 ] = - r1[ 1 ][ 1 ];
    m[ 0 ][ 1 ] = - r2[ 1 ][ 0 ];
    m[ 1 ][ 1 ] = + r2[ 1 ][ 1 ];

    vec2 x = d2linearEquationSolve( m, y );
    return x;

  }
`

//

function rayRayIntersectionPoints( r1, r2 )
{
  let factors = this.rayRayIntersectionFactors( r1, r2 );
  let result = [ this.rayAt( r1, factors[ 0 ] ), this.rayAt( r2, factors[ 1 ] ) ];
  return result;

}

rayRayIntersectionPoints.shaderChunk =
`
  void rayRayIntersectionPoints( out vec2 result[ 2 ], vec2 r1[ 2 ], vec2 r2[ 2 ] )
  {

    vec2 factors = rayRayIntersectionFactors( r1, r2 );
    result[ 0 ] = rayAt( r1, factors[ 0 ] );
    result[ 1 ] = rayAt( r2, factors[ 1 ] );

  }
`

//

function rayRayIntersectionPoint( r1, r2 )
{
  let factors = this.rayRayIntersectionFactors( r1, r2 );
  return this.rayAt( r1, factors[ 0 ] );
}

rayRayIntersectionPoint.shaderChunk =
`
  vec2 rayRayIntersectionPoint( vec2 r1[ 2 ], vec2 r2[ 2 ] )
  {

    vec2 factors = rayRayIntersectionFactors( r1, r2 );
    return rayAt( r1, factors[ 0 ] );

  }
`

//

function rayRayIntersectionPointAccurate( r1, r2 )
{
  let closestPoints = this.rayRayIntersectionPoints( r1, r2 );
  return ( closestPoints[ 0 ]
  .slice()
  .add( closestPoints[ 1 ] )
  .mul( 0.5 )
  )
}

rayRayIntersectionPointAccurate.shaderChunk =
`
  vec2 rayRayIntersectionPointAccurate( vec2 r1[ 2 ], vec2 r2[ 2 ] )
  {

    vec2 closestPoints[ 2 ];
    rayRayIntersectionPoints( closestPoints, r1, r2 );
    return ( closestPoints[ 0 ] + closestPoints[ 1 ] ) * 0.5;

  }
`

// --
// line other
// --

// function linePointDistanceOriginSqr( b, p )
// {

//   throw _.err( 'not tested' );

//   //p.slice().sub( p.slice().mul( p.dot( b ) ) );
//   p.cross( b );

//   return p.lengthSq() / b.lengthSq();
// }

//

// function linePointDistanceSqr( linePoints, point )
// {

//   let lineCentered = avector.sub( linePoints[ 1 ].slice(), linePoints[ 0 ] );
//   let pointCentered = avector.sub( point.slice(), linePoints[ 0 ] );

//   return this.linePointDistanceOriginSqr( lineCentered, pointCentered );
// }

//

function relativeSegmentOrigin( segmentCentered, pointCentered )
{

  return _dot( pointCentered, segmentCentered ) / _dot( segmentCentered, segmentCentered );
  /*return p.dot( b ) / b.dot( b )*/

}

//

function relativeSegment( segmentPoints, point )
{

  let segmentCentered = avector.sub( segmentPoints[ 1 ].slice(), segmentPoints[ 0 ] );
  let pointCentered = avector.sub( point.slice(), segmentPoints[ 0 ] );

  return relativeSegmentOrigin( segmentCentered, pointCentered );
}

//

function segmentToPointDistanceSqr( segmentPoints, point )
{
  throw _.err( 'not tested' );
  let t = this.relativeSegment( a, b, p );

  if( t < 0 )
  {
    _distanceSqr( a, p );
  }
  else if( t > 1 )
  {
    _distanceSqr( b, p );
  }
  else
  {
    return this.linePointDistanceSqr( a, b, p );
  }

}

// -- other

function barycentricToPosArray( result, poly, barycentric )
{

  result.copy( poly[ 0 ] ).sub( poly[ 0 ] );
  for( let i = 0 ; i < poly.length ; i++ )
  {
    let m = poly[ i ].slice().mul( barycentric[ i ] );
    result.add( m );
  }
  return result;

}

//

function inConvexPoly2d( poly, pos, barycentric )
{

  function getSide( edge0, edge1, pos )
  {
    return ( edge1[ 0 ] - edge0[ 0 ] ) * ( pos[ 1 ] - edge0[ 1 ] ) - ( edge1[ 1 ] - edge0[ 1 ] ) * ( pos[ 0 ] - edge0[ 0 ] );
  }

  let i = 0;
  let side = getSide( poly[ poly.length-1 ], poly[ i ], pos );
  for( i = 1; i < poly.length; i++ )
  {
    let wasSide = side;
    side = getSide( poly[ i-1 ], poly[ i ], pos )
    if( side === 0 )break
    if( wasSide*side < 0 )return false;
  }

  i = 0;
  let d = pos.distanceTo( poly[ i ] );
  let td = d;
  let mind = d;
  for( i = 1; i < poly.length; i++ )
  {
    let d = pos.distanceTo( poly[ i ] );
    td += d;
    if( mind > d ) mind = d;
  }

  let nd = 0;
  for( i = 0; i < poly.length; i++ )
  {
    let d = pos.distanceTo( poly[ i ] );
    let p = mind / d;
    //let p = d / ( d - mind );
    if( d < 0.0000001 ) p = 1;
    nd += p;
  }

  for( i = 0; i < poly.length; i++ )
  {
    let d = pos.distanceTo( poly[ i ] );
    let p = mind / d;
    if( d < 0.0000001 ) p = 1;
    barycentric[ i ] = p / nd;
  }
  return true;

}

//

// function distanceToTri( tri, pos ) {

//   let p0 = pos.slice();
//   let p1 = tri[ 1 ].slice();
//   let p2 = tri[ 2 ].slice();

//   p0.sub( tri[ 0 ] );
//   p1.sub( tri[ 0 ] );
//   p2.sub( tri[ 0 ] );

//   p1.cross( p2 ).normalize();
//   let result = Math.abs( p1.dot( p0 ) );
//   return result;

// }

//

function inTri( tri, pos, barycentric )
{

  let p0 = pos.slice();
  let p1 = tri[ 1 ].slice();
  let p2 = tri[ 2 ].slice();

  p0.sub( tri[ 0 ] );
  p1.sub( tri[ 0 ] );
  p2.sub( tri[ 0 ] );

  let dot01 = p0.dot( p1 );
  let dot02 = p0.dot( p2 );
  let dot11 = p1.dot( p1 );
  let dot22 = p2.dot( p2 );
  let dot21 = p2.dot( p1 );

  inv = 1 / (dot11 * dot22 - dot21 * dot21);
  barycentric[ 1 ] = (dot22 * dot01 - dot21 * dot02) * inv;
  barycentric[ 2 ] = (dot11 * dot02 - dot21 * dot01) * inv;
  barycentric[ 0 ] = 1 - (barycentric[ 1 ] + barycentric[ 2 ]);

  return (barycentric[ 0 ] >= 0) && (barycentric[ 1 ] >= 0) && (barycentric[ 2 ] >= 0);
}

//

function triSphereSmallest( tri )
{

  let result = Object.create( null );
  let d = Number.NEGATIVE_INFINITY;

  result.centre = tri[ 0 ].slice();
  for( let i = 1 ; i < tri.length ; i++ )
  result.centre.add( tri[ i ] )
  result.centre.mul( 1/tri.length );

  for( let i = 0 ; i < tri.length ; i++ )
  {
    let cd = tri[ i ].distanceToSquared( result.centre )
    if( d < cd ) d = cd;
  }
  result.radius = _sqrt( d );
  return result;
}

//

function triCentre( tri )
{

  let p1 = tri[ 1 ].slice().sub( tri[ 0 ] );
  let p2 = tri[ 2 ].slice().sub( tri[ 0 ] );
  let n, n1, n2;

  //let p1 = new THREE.vector2( 2, 0 );
  //let p2 = new THREE.vector2( 0, 1 );

  if( p1[ 2 ] === undefined )
  {
    n1 = p1.slice().set( p1[ 1 ], -p1[ 0 ] );
    n2 = p2.slice().set( p2[ 1 ], -p2[ 0 ] );
  }
  else
  {
    n = p1.slice().cross( p2 );
    n1 = p1.slice().cross( n );
    n2 = p2.slice().cross( n );
  }

  p1.mul( 0.5 );
  p2.mul( 0.5 );

  let result = pairPairIntersectionPoint( [ p1, n1 ], [ p2, n2 ] );
  //let d = [tri[ 0 ].distanceTo( result ), tri[ 1 ].distanceTo( result ), tri[ 2 ].distanceTo( result )];
  //console.log( d );
  return result;
}

// --
// algorithm
// --

function fillSpace( o )
{
  let self = this;
  o = o || Object.create( null );

  if( o.constructors === undefined )throw _.err( 'fillSpace :', '"o.constructor" is needed' );
  if( o.args === undefined ) o.args = [];

  if( !_.arrayIs( o.args ) )throw _.err( 'fillSpace :', 'o.args must be array' );

  if( o.radius === undefined ) o.radius = 100;
  if( o.gap === undefined ) o.gap = 0;
  if( o.attempts === undefined ) o.attempts = 50;

  if( o.numberOfSamples === undefined ) o.numberOfSamples = 1;
  if( o.randomConstructor === undefined ) o.randomConstructor = 1;

  o.constructors = _.array.as( o.constructor );

  let result = o.container;
  if( result === undefined ) result = [];

  //

  function positionSet( object )
  {

    let attemptsLeft = o.attempts;
    let objects = result.nodeChildrenGet ? result.nodeChildrenGet() : result;

    if( !object.boundingSphere ) object.computeBoundingSphere();
    let pos1 = object.position;
    let radius1 = _.sphere.radiusGet( object.boundingSphere );

    do
    {
      _.anrray.randomInRadius( object.position, o.radius );

      let goodPosition = 1;
      for( let a = 0 ; a < objects.length ; a++ )
      {
        let aobject = objects[ a ];
        if( aobject === object )continue;

        if( !aobject.boundingSphere ) aobject.computeBoundingSphere();

        let pos2 = _.sphere.centerGet( aobject.boundingSphere );
        let radius2 = _.sphere.radiusGet( aobject.boundingSphere );

        if( !_.numberIsFinite( radius2 ) )break;

        let distance = pos1.distanceToSquared( pos2 );
        if( distance < _sqr( radius1 + radius2 + o.gap ) )
        {
          goodPosition = 0;
          break;
        }
      }
      attemptsLeft--;

    }
    while( !goodPosition && attemptsLeft );

    return object;
  }

  //

  let add = _.routineIs( result.add ) ? _.routineJoin_( result, result.add ) : _.routineJoin_( result, result.push );
  let constructorOf;
  let c = 0;

  if( o.randomConstructor ) constructorOf = function()
  {
    c = _.numberRandom( 1, o.constructors.length );
    return o.constructors[ c ];
  }
  else constructorOf = function()
  {
    let result = o.constructors[ c ];
    c += 1;
    if( c >= o.constructors.length )
    c = 0;
    return result;
  }

  for( let s = 0 ; s < o.numberOfSamples ; s++ )
  {

    let constructor = constructorOf();
    o.sampleNumber = s;
    let object = constructor.call( o, o.args );
    positionSet( object );
    add( object )

  }

  return result;
}

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

// --
// extension
// --

let Extension =
{

  // iterator

  eachEdgeOfCube, //
  eachPlaneOfCube, //

  // d2

  // d2LineGeneralEqWithPoints,//lineImplicit.eqWithPoints
  // d2LineGeneralEqWithPointAndTangent,//lineImplicit.eqWithPointAndTangent

  // d2LineLineGeneralEqIntersection,//lineImplicit.lineIntersection

  // d2LineGeneraEqPointDistance,//lineImplicit.pointDistance

  // d2LinePointDistanceCentered,//linePointCentered.pointDistanceCentered2D
  // d2LinePointDistance,//linePointCentered.pointDistance2D

  // d2SegmentToPointDistanceSqr, // xxx segment.pointDistance

  // d2PolygonPointDistanceSqr,// convexPolygon.pointDistanceSqr, concavePolygon.pointDistanceSqr
  // d2PolygonPointDistance,// convexPolygon.pointDistance, concavePolygon.pointDistance
  // d2PolygonPointInside,// convexPolygon.pointContains2D
  // d2PolygonConvexPointInside,// convexPolygon.pointContains
  //d2PolygonConcavePointInside,// concavePolygon.pointContains

  // d2PolygonIsClockwise,//*polygon.isClockwise

  // _d2LinePointsToPointSide,//line.pointsToPointSide
  // _d2LinePointsToPointDistance,//line.pointDistance

  // d2TriPointInside,//triangle.pointContains

  // angle

  angle3dPlaneVector180,
  angle3dPlaneVector360,
  angle3d,
  angle3dAtan,
  angle3dCos,

  d2Angle,
  d2AngleWithCos,
  d2AngleWithCosFast,

  // pair / ray - original

  //rayFromPair,//ray.fromPair
  // rayAt,// ray.rayAt

  // pairFromRay,// pair.fromRay
  // pairAt,//pair.pairAt

  // pair / ray - from ray

  // _pairPairRoutineFromRayRayRoutine,

  // rayRayParallel,//ray.rayParallel
  // rayRayIntersectionFactors,//ray.rayIntersectionFactors
  // rayRayIntersectionPoints,//ray.rayIntersectionPoints
  // rayRayIntersectionPoint,//ray.rayIntersectionPoint
  // rayRayIntersectionPointAccurate,//ray.rayIntersectionPointAccurate

  // pairPairParallel : _pairPairRoutineFromRayRayRoutine( rayRayParallel, 'Parallel' ),//pair.pairParallel
  // pairPairIntersectionFactors : _pairPairRoutineFromRayRayRoutine( rayRayIntersectionFactors, 'IntersectionFactors' ),//pair.pairIntersectionFactors
  /*pairPairIntersectionPoints : _pairPairRoutineFromRayRayRoutine( rayRayIntersectionPoints, 'IntersectionPoints' ), */
  // pairPairIntersectionPoint : _pairPairRoutineFromRayRayRoutine( rayRayIntersectionPoint, 'IntersectionPoint' ),//pair.pairIntersectionPoint
  // pairPairIntersectionPointAccurate : _pairPairRoutineFromRayRayRoutine( rayRayIntersectionPointAccurate, 'IntersectionPointAccurate' ),////pair.pairIntersectionPointAccurate

  // linear equation

  d2linearEquationSolve, //Matrix.solveLinear?
  linearEquationSolveExternal,
  linearEquationSolve,

  // line other

  // linePointDistanceOriginSqr,//linePointCentered.pointDistanceCentered3DSqr
  // linePointDistanceSqr,//linePointCentered.pointDistance3DSqr
  // relativeSegmentOrigin,//segment.relativeSegmentOrigin
  // relativeSegment,//segment.relativeSegment
  // segmentToPointDistanceSqr,//segment.pointDistanceSqr

  // other

  barycentricToPosArray, //triangle.
  inConvexPoly2d, //convexPolygon.inPolygon?
  // distanceToTri,//triangle.pointDistance
  inTri, //triangle.inTri
  triCentre, //triangle.inTriCentre
  triSphereSmallest, //trianle.sphereSmallest?

};

//

_.props.supplement( _.math, Extension );
injectChunks( Extension );

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = _;

})();
