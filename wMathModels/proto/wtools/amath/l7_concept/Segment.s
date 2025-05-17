( function _Segment_s_()
{

'use strict';

const _ = _global_.wTools;
_.segment = _.segment || Object.create( _.avector );

/**
 * @description
 * A segment is a finite line, starting at an origin and finishing at an end point.
 *
 * For the following functions, segments must have the shape [ startX, startY, startZ, endX, endY, endZ ],
 * where the dimension equals the long's length divided by two.
 *
 * Moreover, startX, startY and startZ are the coordinates of the origin of the segment,
 * and endX, endY and endZ the coordinates of the end of the segment.
 * @namespace wTools.segment
  * @module Tools/math/Concepts
 */

/*

  A segment is a finite line, starting at an origin and finishing at an end point.

  For the following functions, segments must have the shape [ startX, startY, startZ, endX, endY, endZ ],
where the dimension equals the long's length divided by two.

  Moreover, startX, startY and startZ are the coordinates of the origin of the segment,
and endX, endY and endZ the coordinates of the end of the segment.

*/

// --
//
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
  dim = 3;
  _.assert( dim >= 0 );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = _.dup( 0, dim*2 );
  return result;
}

//

function makeSingular( dim )
{
  if( this.is( dim ) )
  dim = this.dimGet( dim );
  if( dim === undefined || dim === null )
  dim = 3;

  _.assert( dim >= 0 );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = [];
  for( let i = 0 ; i < dim ; i++ )
  result[ i ] = +Infinity;
  for( let i = 0 ; i < dim ; i++ )
  result[ dim+i ] = -Infinity;

  return result;
}

//

function zero( segment )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( this.is( segment ) )
  {
    let segmentView = this.adapterFrom( segment );
    segmentView.assign( 0 );
    return segment;
  }

  return this.makeZero( segment );
}

//

function nil( segment )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( this.is( segment ) )
  {
    let segmentView = this.adapterFrom( segment );
    let min = this.originGet( segmentView );
    let max = this.endPointGet( segmentView );

    this.tools.vectorAdapter.assign( min, +Infinity );
    this.tools.vectorAdapter.assign( max, -Infinity );

    return segment;
  }

  return this.makeSingular( segment );
}

//

function from( segment )
{
//  if( _.object.isBasic( segment ) )
//  {
//    _.map.assertHasExactly( segment, { min : 'min' , max : 'max' } );
//    segment = _.arrayAppendArray( [], [ segment.min, segment.max ] );
//  }

  _.assert( this.is( segment ) || segment === null );
  _.assert( arguments.length === 1, 'Expects single argument' );

//  if( _.vectorAdapterIs( segment ) )
//  {
//    debugger;
//    throw _.err( 'not implemented' );
//    return segment.slice();
//  }

  if( segment === null )
  return this.make();

  return segment;
}

//

function adapterFrom( segment )
{
  _.assert( this.is( segment ) );
  _.assert( arguments.length === 1, 'Expects single argument' );
  return this.tools.vectorAdapter.from( segment );
}

//

/**
  * Check if input is a segment. Returns true if it is a segment and false if not.
  *
  * @param { Vector } segment - Source segment.
  *
  * @example
  * // returns true;
  * _.segment.is( [ 0, 0, 1, 1 ] );
  *
  * @returns { Boolean } Returns true if the input is segment.
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */

function is( segment )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return ( _.longIs( segment ) || _.vectorAdapterIs( segment ) ) && ( segment.length >= 0 ) && ( segment.length % 2 === 0 );
}

//

/**
  * Get segment dimension. Returns the dimension of the segment. segment stays untouched.
  *
  * @param { Vector } segment - The source segment.
  *
  * @example
  * // returns 2
  * _.dimGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns 1
  * _.dimGet( [ 0, 1 ] );
  *
  * @returns { Number } Returns the dimension of the segment.
  * @function dimGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function dimGet( segment )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( this.is( segment ) );
  return segment.length / 2;
}

//

/**
  * Get the origin of a segment. Returns a vector with the coordinates of the origin of the segment.
  * segment stays untouched.
  *
  * @param { Vector } segment - The source segment.
  *
  * @example
  * // returns   0, 0
  * _.originGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns  1
  * _.originGet( [ 1, 2 ] );
  *
  * @returns { Vector } Returns the coordinates of the origin of the segment.
  * @function originGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function originGet( segment )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  let segmentView = this.adapterFrom( segment );
  return segmentView.review([ 0, segment.length / 2 - 1 ]);
}

//

/**
  * Get the end point of a segment. Returns a vector with the coordinates of the final point of the segment.
  * Segment stays untouched.
  *
  * @param { Vector } segment - The source segment.
  *
  * @example
  * // returns   2, 2
  * _.endPointGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns  2
  * _.endPointGet( [ 1, 2 ] );
  *
  * @returns { Vector } Returns the final point of the segment.
  * @function endPointGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */

function endPointGet( segment )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  let segmentView = this.adapterFrom( segment );
  return segmentView.review([ segment.length / 2, segment.length - 1 ]);
}

//

/**
  * Get the direction of a segment. Returns a vector with the coordinates of the direction of the segment.
  * Segment stays untouched.
  *
  * @param { Vector } segment - The source segment.
  *
  * @example
  * // returns  [ 2, 2 ]
  * _.directionGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns  [ 2 ]
  * _.directionGet( [ 1, 2 ] );
  *
  * @returns { Vector } Returns the direction of the segment.
  * @function directionGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function directionGet( segment )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  let segmentView = this.adapterFrom( segment );
  let origin = this.originGet( segment );
  let endPoint = this.endPointGet( segment );
  let dim = this.dimGet( segmentView );
  let direction = this.tools.vectorAdapter.from( this.tools.long.make( dim ) );

  for( var i = 0; i < dim; i++ )
  {
    direction.eSet( i, endPoint.eGet( i ) - origin.eGet( i ) );
  }

  return direction;
}

//

/**
  * Get the center of a segment. Returns the center of the segment. Segment stays untouched.
  *
  * @param { Array } segment - The source segment.
  * @param { Array } dst - The destination array (optional - sets the type of the returned object).
  *
  * @example
  * // returns [ 0.5, 1 ]
  * _.centerGet( [ 0, 0, 1, 2 ], [ 5, 0 ]);
  *
  * @example
  * // returns [ 0.5 ]
  * _.centerGet( [ 0, 1 ] );
  *
  * @returns { Array } Returns the coordinates of the center of the segment.
  * @function centerGet
  * @throws { Error } An Error if ( arguments.length ) is different than one or two.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @throws { Error } An Error if ( dst ) is not point.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function centerGet( segment, dst )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );

  let segmentView = this.adapterFrom( segment );
  let dim = this.dimGet( segmentView );
  let origin = this.originGet( segmentView );
  let end = this.endPointGet( segmentView );

  if( !dst )
  dst = _.dup( 0, dim ) ;

  let dstv = this.tools.vectorAdapter.from( dst );

  _.assert( dim === dst.length );

  this.tools.vectorAdapter.add( dstv.copy( origin ), end ).mul( 0.5 );

  return dst;
}

//

/**
  * Get a point in a segment. Returns a vector with the coordinates of the point of the segment.
  * Segment and factor stay untouched.
  *
  * @param { Vector } srcSegment - The source segment.
  * @param { Vector } factor - The source factor.
  *
  * @example
  * // returns   1, 1
  * _.segmentAt( [ 0, 0, 2, 2 ], 0.5 );
  *
  * @example
  * // returns  1
  * _.segmentAt( [ 1, 2 ], 0 );
  *
  * @returns { Vector } Returns a point in the segment at a given factor.
  * @function segmentAt
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( factor ) is not number.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function segmentAt( srcSegment, factor )
{
  // let result = this.tools.avector.mul( null, srcSegment[ 1 ], factor );
  // this.tools.avector.add( result, srcSegment[ 0 ] );

  _.assert( arguments.length === 2, 'Expects single argument' );
  _.assert( this.is( srcSegment ) );

  _.assert( factor >= 0, 'Factor can not be negative ( point must be in the segment )');
  _.assert( factor <= 1, 'Factor can not be bigger than one ( point must be in the segment )');

  let segmentView = this.adapterFrom( srcSegment )
  let origin = this.originGet( segmentView );
  let direction = this.directionGet( segmentView );

  let result = this.tools.avector.mul( null, direction, factor );
  result = this.tools.avector.add( result, origin );

  return result;
}

segmentAt.shaderChunk =
`
  vec2 segmentAt( vec2 srcSegment[ 2 ], float factor )
  {

    vec2 result = srcSegment[ 1 ]*factor;
    result += srcSegment[ 0 ];

    return result;
  }
`

//

/**
* Get the factor of a point inside a segment. Returs the calculated factor. Point and segment stay untouched.
*
* @param { Array } srcSegment - The source segment.
* @param { Array } srcPoint - The source point.
*
* @example
* // returns 0.5
* _.getFactor( [ 0, 0, 2, 2 ], [ 1, 1 ] );
*
* @example
* // returns false
* _.getFactor( [ 0, 0, 2, 2 ], [ - 1, 3 ] );
*
* @returns { Number } Returns the factor if the point is inside the segment, and false if the point is outside it.
* @function getFactor
* @throws { Error } An Error if ( dim ) is different than point.length (segment and point have not the same dimension).
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( srcSegment ) is not segment.
* @throws { Error } An Error if ( srcPoint ) is not point.
* @namespace wTools.segment
  * @module Tools/math/Concepts
*/
function getFactor( srcSegment, srcPoint )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcSegment === null )
  srcSegment = this.make( srcPoint.length );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let origin = this.originGet( srcSegmentView );
  let direction = this.directionGet( srcSegmentView );
  let dimension  = this.dimGet( srcSegmentView )
  let srcPointView = this.tools.vectorAdapter.from( srcPoint.slice() );

  _.assert( dimension === srcPoint.length, 'The segment and the point must have the same dimension' );
  // let dOrigin = this.tools.vectorAdapter.from( this.tools.avector.sub( srcPointView, origin ) ); /* xxx */
  let dOrigin = this.tools.vectorAdapter.from( this.tools.avector.sub( srcPointView.clone(), origin ) );

  let factor;
  if( direction.eGet( 0 ) === 0 )
  {
    // if( Math.abs( dOrigin.eGet( 0 ) ) > this.tools.accuracySqr )
    if( this.tools.avector.isGreaterAprox( Math.abs( dOrigin.eGet( 0 ) ), this.tools.accuracySqr ) )
    {
      return false;
    }
    else
    {
      factor = 0;
    }
  }
  else
  {
    factor = dOrigin.eGet( 0 ) / direction.eGet( 0 );
  }

  // Factor can not be negative
  // if(  factor <= 0 - this.tools.accuracySqr || factor >= 1 + this.tools.accuracySqr )
  if(  this.tools.avector.isLessEqualAprox( factor, 0 - this.tools.accuracySqr ) || this.tools.avector.isGreaterEqualAprox( factor, 1 + this.tools.accuracySqr ) )
  return false;

  let newPoint = this.segmentAt( srcSegmentView, factor );

  if( this.tools.avector.allEquivalent( newPoint, srcPointView ) )
  return factor;

  for( var i = 1; i < dOrigin.length; i++ )
  {
    let newFactor;
    if( direction.eGet( i ) === 0 )
    {
      // if( Math.abs( dOrigin.eGet( i ) ) > this.tools.accuracySqr )
      if( this.tools.avector.isGreaterAprox( Math.abs( dOrigin.eGet( i ) ), this.tools.accuracySqr ) )
      {
        return false;
      }
      else
      {
        newFactor = 0;
      }
    }
    else
    {
      newFactor = dOrigin.eGet( i ) / direction.eGet( i );
      // if( Math.abs( newFactor - factor ) > this.tools.accuracySqr && newFactor !== 0 && factor !== 0 )
      if( this.tools.avector.isGreaterAprox( Math.abs( newFactor - factor ), this.tools.accuracySqr ) && newFactor !== 0 && factor !== 0 )
      {
        return false;
      }
      factor = newFactor;

      // Factor can not be negative
      // if(  factor <= 0 - this.tools.accuracySqr || factor >= 1 + this.tools.accuracySqr )
      if(  this.tools.avector.isLessEqualAprox( factor, 0 - this.tools.accuracySqr ) || this.tools.avector.isGreaterEqualAprox( factor, 1 + this.tools.accuracySqr ) )
      return false;

    }
    let newPoint = this.segmentAt( srcSegmentView, factor );

    if( this.tools.avector.allEquivalent( newPoint, srcPointView ) )
    return factor;
  }

  return false;
}

//

/**
  * Check if two segments are parallel. Returns true if they are parallel and false if not.
  * Segments and accuracySqr stay untouched.
  *
  * @param { Vector } src1Segment - The first source segment.
  * @param { Vector } src2Segment - The second source segment.
  * @param { Vector } accuracySqr - The accuracy.
  *
  * @example
  * // returns   true
  * _.segmentParallel( [ 0, 0, 0, 2, 2, 2 ], [ 1, 2, 1, 3, 4, 3 ] );
  *
  * @example
  * // returns  false
  * _.segmentParallel( [ 1, 2, 1, 1, 1, 2 ], [ 1, 2, 1, 1, 3, 3 ] );
  *
  * @returns { Boolean } Returns true if the segments are parallel.
  * @function segmentParallel
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( src1Segment ) is not segment.
  * @throws { Error } An Error if ( src2Segment ) is not segment.
  * @throws { Error } An Error if ( accuracySqr ) is not number.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function segmentParallel( src1Segment, src2Segment, accuracySqr )
{
  _.assert( this.is( src1Segment ) );
  _.assert( this.is( src2Segment ) );
  _.assert( arguments.length === 2 || arguments.length === 3 );
  _.assert( src1Segment.length === src2Segment.length );

  if( arguments.length === 2 || accuracySqr === undefined || accuracySqr === null )
  accuracySqr = this.tools.accuracySqr;;

  let direction1 = this.directionGet( src1Segment );
  let direction2 = this.directionGet( src2Segment );
  let proportion = undefined;

  let zeros1 = 0;                               // Check if Segment1 is a point
  for( let i = 0; i < direction1.length ; i++  )
  {
    if( direction1.eGet( i ) === 0 )
    {
      zeros1 = zeros1 + 1;
    }
    if( zeros1 === direction1.length )
    return true;
  }

  let zeros2 = 0;                               // Check if Segment2 is a point
  for( let i = 0; i < direction2.length ; i++  )
  {
    if( direction2.eGet( i ) === 0 )
    {
      zeros2 = zeros2 + 1;
    }
    if( zeros2 === direction2.length )
    return true;
  }

  for( let i = 0; i < direction1.length ; i++  )
  {
    if( direction1.eGet( i ) === 0 || direction2.eGet( i ) === 0 )
    {
      if( direction1.eGet( i ) !== direction2.eGet( i ) )
      {
        return false;
      }
    }
    else
    {
      let newProportion = direction1.eGet( i ) / direction2.eGet( i );

      if( proportion !== undefined )
      {
        // if( Math.abs( proportion - newProportion ) > accuracySqr)
        if( this.tools.avector.isGreaterAprox( Math.abs( proportion - newProportion ), accuracySqr ) )
        return false
      }

      proportion = newProportion;
    }
  }

  return true;
}

//

/**
  * Project a segment: the projection vector ( projVector ) translates the center of the segment, and the projection scaling factor ( l )
  * scales the segment length ( l ). The projection parameters should have the shape:
  * project = [ projVector, l ];
  * Returns the projected segment. Segment is stored in Array data structure.
  * The projection array stays untouched, the segment changes.
  *
  * @param { Array } segment - segment to be projected.
  * @param { Array } project - Array of reference with projection parameters.
  *
  * @example
  * // returns [ 1, 1, 3, 3 ];
  * _.project( [ 0, 0, 2, 2 ], [ [ 1, 1 ], 1 ] );
  *
  * @example
  * // returns [ -1, -1, 3, 3 ];
  * _.expand( [ 0, 0, 2, 2 ], [ [ 0, 0 ], 2 ] );
  *
  * @returns { Array } Returns the array of the projected segment.
  * @function project
  * @throws { Error } An Error if ( dim ) is different than project.length - 1 / 2 (the segment and the projection array don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @throws { Error } An Error if ( project ) is not an array.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function project( segment, project )
{

  if( segment === null )
  segment = this.make();

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.longIs( project ) || _.vectorAdapterIs( project ) );
  _.assert( project.length === 2, 'Project array expects exactly two entries')

  let segmentView = this.adapterFrom( segment );
  let origin = this.tools.vectorAdapter.from( this.originGet( segmentView ) );
  let end = this.tools.vectorAdapter.from( this.endPointGet( segmentView ) );
  let center = this.tools.vectorAdapter.from( this.centerGet( segmentView ) );
  let dim = this.dimGet( segmentView );

  let projectView = this.tools.vectorAdapter.from( project );
  let projVector = this.tools.vectorAdapter.from( projectView.eGet( 0 ) );
  _.assert( dim === projVector.length );
  let scalLength = projectView.eGet( 1 );


  let segTop = this.tools.vectorAdapter.mul( this.tools.vectorAdapter.sub( end.clone(), center ), scalLength );
  let segSub = this.tools.vectorAdapter.mul( this.tools.vectorAdapter.sub( origin.clone(), center ), scalLength );

  let newCenter = this.tools.vectorAdapter.add( center.clone(), projVector );
  let newOrigin = this.tools.vectorAdapter.add( newCenter.clone(), segSub );
  let newEnd = this.tools.vectorAdapter.add( newCenter.clone(), segTop );

  debugger;

  for( let i = 0; i < dim; i ++ )
  {
    segmentView.eSet( i, newOrigin.eGet( i ) );
    segmentView.eSet( i + dim, newEnd.eGet( i ) );
  }

  return segment;
}

//

/**
  * Get the projection factors of two segments: the projection vector ( projVector ) translates the center of the segment, and the projection scaling factor ( l )
  * scale the segment length. The projection parameters should have the shape:
  * project = [ projVector, l ];
  * Returns the projection parameters, 0 when not possible ( i.e: Segments are not parallel ).
  * Segments are stored in Array data structure. The segments stay untouched.
  *
  * @param { Array } srcSegment - Original segment.
  * @param { Array } projSegment - Projected segment.
  *
  * @example
  * // returns [ [ 0.5, 0.5 ], 2 ];
  * _.getProjectionFactors( [ 0, 0, 1, 1 ], [ -0.5, -0.5, 2.5, 2.5 ] );
  *
  *
  * @returns { Array } Returns the array with the projection factors between the two segmentes.
  * @function getProjectionFactors
  * @throws { Error } An Error if ( dim ) is different than ( dim2 ) (the segments don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( projSegment ) is not segment.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function getProjectionFactors( srcSegment, projSegment )
{

  _.assert( this.is( srcSegment ), 'Expects segment' );
  _.assert( this.is( projSegment ), 'Expects segment' );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let srcOrigin = this.tools.vectorAdapter.from( this.originGet( srcSegmentView ) );
  let srcEnd = this.tools.vectorAdapter.from( this.endPointGet( srcSegmentView ) );
  let srcCenter = this.tools.vectorAdapter.from( this.centerGet( srcSegmentView ) );
  let srcDim = this.dimGet( srcSegmentView );

  let projSegmentView = this.adapterFrom( projSegment );
  let projOrigin = this.tools.vectorAdapter.from( this.originGet( projSegmentView ) );
  let projEnd = this.tools.vectorAdapter.from( this.endPointGet( projSegmentView ) );
  let projCenter = this.tools.vectorAdapter.from( this.centerGet( projSegmentView ) );
  let projDim = this.dimGet( projSegmentView );

  _.assert( srcDim === projDim );

  let project = this.tools.long.make( 2 );
  let projectView = this.tools.vectorAdapter.from( project );

  debugger;
  if( !this.segmentParallel( srcSegmentView, projSegmentView, 1e-7 ) )
  return 0;

  let translation = this.tools.vectorAdapter.sub( projCenter.clone(), srcCenter );
  projectView.eSet( 0, translation.toLong() );

  let srcTop = this.tools.vectorAdapter.sub( srcEnd.clone(), srcCenter );
  let projTop = this.tools.vectorAdapter.sub( projEnd.clone(), projCenter );
  debugger;

  let srcTopMag = this.tools.vectorAdapter.mag( srcTop);
  let projTopMag = this.tools.vectorAdapter.mag( projTop);

  let scalLength;
  if( srcTopMag === 0 )
  {
    if( projTopMag === 0 )
    {
      scalLength = 1;
    }
    else return 0;
  }
  else
  {
    scalLength = projTopMag / srcTopMag;
  }
  projectView.eSet( 1, scalLength );

  return project;
}

//

/**
  * Returns the factors for the intersection of two segments. Returns a vector with the intersection factors, 0 if there is no intersection.
  * Segments stay untouched.
  *
  * @param { Vector } src1Segment - The first source segment.
  * @param { Vector } src2Segment - The second source segment.
  *
  * @example
  * // returns   0
  * _.segmentIntersectionFactors( [ 0, 0, 2, 2 ], [ 3, 3, 4, 4 ] );
  *
  * @example
  * // returns  this.tools.vectorAdapter.from( [ 2/3, 0.5 ] )
  * _.segmentIntersectionFactors( [ - 2, 0, 1, 0 ], [ 0, - 2, 0, 2 ] );
  *
  * @returns { Array } Returns the factors for the two segments intersection.
  * @function segmentIntersectionFactors
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Segment ) is not segment.
  * @throws { Error } An Error if ( src2Segment ) is not segment.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */

function segmentIntersectionFactors( srcSegment1, srcSegment2 )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( srcSegment1.length === srcSegment2.length, 'The two segments must have the same dimension' );

  // let srcSegment1View = this.adapterFrom( srcSegment1.slice() );
  // let srcSegment2View = this.adapterFrom( srcSegment2.slice() );
  let srcSegment1View = this.adapterFrom( srcSegment1 );
  let srcSegment2View = this.adapterFrom( srcSegment2 );

  let origin1 = this.originGet( srcSegment1View );
  let origin2 = this.originGet( srcSegment2View );
  let dOrigin = this.tools.vectorAdapter.from( this.tools.avector.sub( origin2.clone(), origin1 ) );

  let end1 = this.endPointGet( srcSegment1View );
  let end2 = this.endPointGet( srcSegment2View );

  let direction1 = this.directionGet( srcSegment1View );
  let direction2 = this.directionGet( srcSegment2View );

  let directions = _.Matrix.Make( [ srcSegment1.length / 2 , 2 ] );
  directions.colGet( 0 ).copy( direction1 );
  directions.colGet( 1 ).copy( direction2.clone().mul( - 1 ) );

  // Same origin
  let identOrigin = 0;
  let identEnd = 0;
  let origin1End2 = 0;
  let end1Origin2 = 0;
  for( let i = 0; i < origin1.length; i++ )
  {
    // if( origin1.eGet( i ) === origin2.eGet( i ) )
    if( this.tools.avector.isEquivalent( origin1.eGet( i ), origin2.eGet( i ) ) )
    identOrigin = identOrigin + 1;

    // if( origin1.eGet( i ) === end2.eGet( i ) )
    if( this.tools.avector.isEquivalent( origin1.eGet( i ), end2.eGet( i ) ) )
    origin1End2 = origin1End2 + 1;

    // if( end1.eGet( i ) === origin2.eGet( i ) )
    if( this.tools.avector.isEquivalent( end1.eGet( i ), origin2.eGet( i ) ) )
    end1Origin2 = end1Origin2 + 1;

    // if( end1.eGet( i ) === end2.eGet( i ) )
    if( this.tools.avector.isEquivalent( end1.eGet( i ), end2.eGet( i ) ) )
    identEnd = identEnd + 1;
  }

  if( identOrigin === origin1.length )
  return this.tools.vectorAdapter.from( [ 0, 0 ] );

  else if( origin1End2 === origin1.length )
  return this.tools.vectorAdapter.from( [ 0, 1 ] );

  else if( end1Origin2 === origin1.length )
  return this.tools.vectorAdapter.from( [ 1, 0 ] );

  else if( identEnd === origin1.length )
  return this.tools.vectorAdapter.from( [ 1, 1 ] );

  // Parallel segments
  if( this.segmentParallel( srcSegment1, srcSegment2 ) === true )
  {
    if( this.pointContains( srcSegment1, origin2 ) )
    {
      return this.tools.vectorAdapter.from( [ this.getFactor( srcSegment1, origin2), 0 ] );
    }
    else if( this.pointContains( srcSegment2, origin1 ) )
    {
      return this.tools.vectorAdapter.from( [  0, this.getFactor( srcSegment2, origin1) ] );
    }
    else
    {
      return 0;
    }
  }

  let result = this.tools.vectorAdapter.from( [ 0, 0 ] );

  for( let i = 0; i < dOrigin.length - 1 ; i++ )
  {
    let m = _.Matrix.Make( [ 2, 2 ] );
    m.rowSet( 0, directions.rowGet( i ) );
    m.rowSet( 1, directions.rowGet( i + 1 ) );
    let or = _.Matrix.MakeCol( [ dOrigin.eGet( i ), dOrigin.eGet( i + 1 ) ] );

    let o =
    {
      x : null,
      m : m,
      y : or,
      kernel : null,
      permutating : 1,
      // pivoting : 1,
    }

    let x = _.Matrix.SolveGeneral( o );

    result = _.Matrix.ConvertToClass( _.VectorAdapter, x.ox ); /* Dmytro : not sure that needs to use x.ox, it also can be x.x */
    // result = this.tools.vectorAdapter.from( x.base );

    let point1 = this.tools.vectorAdapter.from( this.tools.longMake/* _.array.makeArrayOfLength */( dOrigin.length ) );
    let point2 = this.tools.vectorAdapter.from( this.tools.longMake/* _.array.makeArrayOfLength */( dOrigin.length ) );

    for( var j = 0; j < dOrigin.length; j++ )
    {
      point1.eSet( j, origin1.eGet( j ) + direction1.eGet( j )*result.eGet( 0 ) );
      point2.eSet( j, origin2.eGet( j ) + direction2.eGet( j )*result.eGet( 1 ) );
    }

    let contained = 0;
    if( this.pointContains( srcSegment1View, point2 ) )
    {
      result.eSet( 0, this.getFactor( srcSegment1View, point2 ) );
      contained = 1;
    }
    else if( this.pointContains( srcSegment2View, point1 ) )
    {
      result.eSet( 1, this.getFactor( srcSegment2View, point1 ) );
      contained = 1;
    }

    let isGreaterEqualAprox = this.tools.avector.isGreaterEqualAprox;
    let isLessEqualAprox = this.tools.avector.isLessEqualAprox;


    // let result0 = result.eGet( 0 ) >= 0 - this.tools.accuracySqr && result.eGet( 0 ) <= 1 + this.tools.accuracySqr;
    let result0 = isGreaterEqualAprox( result.eGet( 0 ), 0 - this.tools.accuracySqr ) && isLessEqualAprox( result.eGet( 0 ), 1 + this.tools.accuracySqr );
    // let result1 = result.eGet( 1 ) >= 0 - this.tools.accuracySqr && result.eGet( 1 ) <= 1 + this.tools.accuracySqr;
    let result1 = isGreaterEqualAprox( result.eGet( 1 ), 0 - this.tools.accuracySqr ) && isLessEqualAprox( result.eGet( 1 ), 1 + this.tools.accuracySqr );

    if( result0 && result1 && contained === 1 )
    return result;
  }

  return 0;
}
/*
function segmentIntersectionFactors( srcSegment1, srcSegment2 )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( srcSegment1.length === srcSegment2.length, 'The two segments must have the same dimension' );
  let srcSegment1View = this.adapterFrom( srcSegment1.slice() );
  let srcSegment2View = this.adapterFrom( srcSegment2.slice() );
  let origin1 = this.originGet( srcSegment1View );
  let origin2 = this.originGet( srcSegment2View );
  let end1 = this.endPointGet( srcSegment1View );
  let end2 = this.endPointGet( srcSegment2View );
  let dOrigin = this.tools.vectorAdapter.from( this.tools.avector.sub( origin2.clone(), origin1 ) );
  let direction1 = this.directionGet( srcSegment1View );
  let direction2 = this.directionGet( srcSegment2View );
  let directions = _.Matrix.Make( [ srcSegment1.length / 2 , 2 ] );
  directions.colGet( 0 ).copy( direction1 );
  directions.colGet( 1 ).copy( direction2.clone().mul( - 1 ) );
  // Same origin
  let identOrigin = 0;
  let identEnd = 0;
  let origin1End2 = 0;
  let end1Origin2 = 0;
  for( let i = 0; i < origin1.length; i++ )
  {
    if( origin1.eGet( i ) === origin2.eGet( i ) )
    identOrigin = identOrigin + 1;
    if( origin1.eGet( i ) === end2.eGet( i ) )
    origin1End2 = origin1End2 + 1;
    if( end1.eGet( i ) === origin2.eGet( i ) )
    end1Origin2 = end1Origin2 + 1;
    if( end1.eGet( i ) === end2.eGet( i ) )
    identEnd = identEnd + 1;
  }
  if( identOrigin === origin1.length )
  return this.tools.vectorAdapter.from( [ 0, 0 ] );
  else if( origin1End2 === origin1.length )
  return this.tools.vectorAdapter.from( [ 0, 1 ] );
  else if( end1Origin2 === origin1.length )
  return this.tools.vectorAdapter.from( [ 1, 0 ] );
  else if( identEnd === origin1.length )
  return this.tools.vectorAdapter.from( [ 1, 1 ] );
  // Parallel segments
  if( segmentParallel( srcSegment1, srcSegment2 ) === true )
  {
    if( this.pointContains( srcSegment1, origin2 ) )
    {
      return this.tools.vectorAdapter.from( [ this.getFactor( srcSegment1, origin2), 0 ] );
    }
    else if( this.pointContains( srcSegment2, origin1 ) )
    {
      return this.tools.vectorAdapter.from( [  0, this.getFactor( srcSegment2, origin1) ] );
    }
    else
    {
      return 0;
    }
  }
  let result = this.tools.vectorAdapter.from( [ 0, 0 ] );
  let oldResult = this.tools.vectorAdapter.from( [ 0, 0 ] );
  debugger;
  for( let i = 0; i < dOrigin.length - 1 ; i++ )
  {
    let m = _.Matrix.Make( [ 2, 2 ] );
    m.rowSet( 0, directions.rowGet( i ) );
    m.rowSet( 1, directions.rowGet( i + 1 ) );
    let or = _.Matrix.MakeCol( [ dOrigin.eGet( i ), dOrigin.eGet( i + 1 ) ] );
    let o =
    {
      x : null,
      m : m,
      y : or,
      kernel : null,
      pivoting : 1,
    }
    let x = _.Matrix.SolveGeneral( o );
    result = this.tools.vectorAdapter.from( x.base );
    let point1 = this.tools.vectorAdapter.from( this.tools.long.make( dOrigin.length ) );
    let point2 = this.tools.vectorAdapter.from( this.tools.long.make( dOrigin.length ) );
    let equal = 0;
    for( var j = 0; j < dOrigin.length; j++ )
    {
      point1.eSet( j, origin1.eGet( j ) + direction1.eGet( j )*result.eGet( 0 ) )
      point2.eSet( j, origin2.eGet( j ) + direction2.eGet( j )*result.eGet( 1 ) )
      logger.log('Points', point1.slice(), point2.slice() )
      if( point1.eGet( j ) + 1E-6 >= point2.eGet( j ) && point2.eGet( j ) >= point1.eGet( j ) - 1E-6 )
      {
        equal = equal + 1;
      }
    }
    let result0 = result.eGet( 0 ) >= 0 - this.tools.accuracySqr && result.eGet( 0 ) <= 1 + this.tools.accuracySqr;
    let result1 = result.eGet( 1 ) >= 0 - this.tools.accuracySqr && result.eGet( 1 ) <= 1 + this.tools.accuracySqr;
    logger.log( 'RES', equal,  dOrigin.length, result0, result1 )
    if( equal === dOrigin.length && result0 && result1 )
    return result;
  }
  return 0;
}
*/

//

/**
  * Returns the points of the intersection of two segments. Returns an array with the intersection points, 0 if there is no intersection.
  * Segments stay untouched.
  *
  * @param { Vector } src1Segment - The first source segment.
  * @param { Vector } src2Segment - The second source segment.
  *
  * @example
  * // returns   0
  * _.segmentIntersectionPoints( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  [ [ 0, 0 ], [ 0, 0 ] ]
  * _.segmentIntersectionPoints( [ -3, 0, 1, 0 ], [ 0, -2, 0, 1 ] );
  *
  * @returns { Array } Returns the points of intersection of the two segments.
  * @function segmentIntersectionPoints
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Segment ) is not segment.
  * @throws { Error } An Error if ( src2Segment ) is not segment.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function segmentIntersectionPoints( srcSegment1, srcSegment2 )
{
  let factors = this.segmentIntersectionFactors( srcSegment1, srcSegment2 );
  if( factors === 0 )
  return 0;

  let factorsView = this.tools.vectorAdapter.from( factors );
  let result = [ this.segmentAt( srcSegment1, factorsView.eGet( 0 ) ), this.segmentAt( srcSegment2, factorsView.eGet( 1 ) ) ];
  return result;
}

segmentIntersectionPoints.shaderChunk =
`
  void segmentIntersectionPoints( out vec2 result[ 2 ], vec2 srcSegment1[ 2 ], vec2 srcSegment2[ 2 ] )
  {

    vec2 factors = segmentIntersectionFactors( srcSegment1, srcSegment2 );
    result[ 0 ] = segmentAt( srcSegment1, factors[ 0 ] );
    result[ 1 ] = segmentAt( srcSegment2, factors[ 1 ] );

  }
`

//

/**
  * Returns the point of the intersection of two segments. Returns an array with the intersection point, 0 if there is no intersection.
  * Segments stay untouched.
  *
  * @param { Vector } src1Segment - The first source segment.
  * @param { Vector } src2Segment - The second source segment.
  *
  * @example
  * // returns   0
  * _.segmentIntersectionPoint( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  [ [ 0, 0 ] ]
  * _.segmentIntersectionPoint( [ -3, 0, 1, 0 ], [ 0, -2, 0, 1 ] );
  *
  * @returns { Array } Returns the point of intersection of the two segments.
  * @function segmentIntersectionPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Segment ) is not segment.
  * @throws { Error } An Error if ( src2Segment ) is not segment.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function segmentIntersectionPoint( srcSegment1, srcSegment2 )
{

  let factors = this.segmentIntersectionFactors( srcSegment1, srcSegment2 );

  if( factors === 0 )
  return 0;

  return this.segmentAt( srcSegment1, factors.eGet( 0 ) );

}

segmentIntersectionPoint.shaderChunk =
`
  vec2 segmentIntersectionPoint( vec2 srcSegment1[ 2 ], vec2 srcSegment2[ 2 ] )
  {

    vec2 factors = segmentIntersectionFactors( srcSegment1, srcSegment2 );
    return segmentAt( srcSegment1, factors[ 0 ] );

  }
`

//

/**
  * Returns the point of the intersection of two segments. Returns an array with the intersection point, 0 if there is no intersection.
  * Segments stay untouched.
  *
  * @param { Vector } src1Segment - The first source segment.
  * @param { Vector } src2Segment - The second source segment.
  *
  * @example
  * // returns   0
  * _.segmentIntersectionPointAccurate( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  [ [ 0, 0 ] ]
  * _.segmentIntersectionPointAccurate( [ -3, 0, 1, 0 ], [ 0, -2, 0, 1 ] );
  *
  * @returns { Array } Returns the point of intersection of the two segments.
  * @function segmentIntersectionPointAccurate
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Segment ) is not segment.
  * @throws { Error } An Error if ( src2Segment ) is not segment.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function segmentIntersectionPointAccurate( srcSegment1, srcSegment2 )
{

  let closestPoints = this.segmentIntersectionPoints( srcSegment1, srcSegment2 );
  debugger;

  if( closestPoints === 0 )
  return 0;

  return this.tools.avector.mul( this.tools.avector.add( null, closestPoints[ 0 ], closestPoints[ 1 ] ), 0.5 );

}

segmentIntersectionPointAccurate.shaderChunk =
`
  vec2 segmentIntersectionPointAccurate( vec2 srcSegment1[ 2 ], vec2 srcSegment2[ 2 ] )
  {

    vec2 closestPoints[ 2 ];
    segmentIntersectionPoints( closestPoints, srcSegment1, srcSegment2 );
    return ( closestPoints[ 0 ] + closestPoints[ 1 ] ) * 0.5;

  }
`
//

/**
  * Make a segment out of two points. Returns the created segment.
  * Points stay untouched.
  *
  * @param { Array } pair - The source points.
  *
  * @example
  * // returns [ 0, 0, 1, 1 ]
  * _.fromPair( [ [ 0, 0 ], [ 1, 1 ] ] );
  *
  * @returns { Segment } Returns the segment defined by the source points.
  * @function fromPair
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( pair ) is not array of points.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */

function fromPair( pair )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( pair.length === 2, 'Expects two points' );
  _.assert( pair[ 0 ].length === pair[ 1 ].length, 'Expects two points' );

  let result = this.tools.vectorAdapter.from( this.tools.long.make( pair[ 0 ].length * 2 ) );
  let pair0 = this.tools.vectorAdapter.from( pair[ 0 ] );
  let pair1 = this.tools.vectorAdapter.from( pair[ 1 ] );

  for( let i = 0; i < pair0.length ; i++ )
  {
    result.eSet( i, pair0.eGet( i ) );
    result.eSet( pair0.length + i, pair1.eGet( i ) );
  }

  return result;
}

//

/**
  * Check if a given point is contained inside a segment. Returs true if it is contained, false if not.
  * Point and segment stay untouched.
  *
  * @param { Array } srcSegment - The source segment.
  * @param { Array } srcPoint - The source point.
  *
  * @example
  * // returns true
  * _.pointContains( [ 0, 0, 2, 2 ], [ 1, 1 ] );
  *
  * @example
  * // returns false
  * _.pointContains( [ 0, 0, 2, 2 ], [ - 1, 3 ] );
  *
  * @returns { Boolean } Returns true if the point is inside the segment, and false if the point is outside it.
  * @function pointContains
  * @throws { Error } An Error if ( dim ) is different than point.length (segment and point have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcPoint ) is not point.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function pointContains( srcSegment, srcPoint )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcSegment === null )
  srcSegment = this.make( srcPoint.length );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let origin = this.originGet( srcSegmentView );
  let direction = this.directionGet( srcSegmentView );
  let dimension  = this.dimGet( srcSegmentView )
  // let srcPointView = this.tools.vectorAdapter.from( srcPoint.slice() );
  // _.assert( dimension === srcPoint.length, 'The segment and the point must have the same dimension' );
  // let dOrigin = this.tools.vectorAdapter.from( this.tools.avector.sub( srcPointView, origin ) );
  let srcPointView = this.tools.vectorAdapter.from( srcPoint );
  _.assert( dimension === srcPoint.length, 'The segment and the point must have the same dimension' );
  let dOrigin = this.tools.vectorAdapter.from( this.tools.avector.sub( srcPointView.clone(), origin ) );

  let factor;

  if( direction.eGet( 0 ) === 0 )
  {
    // if( Math.abs( dOrigin.eGet( 0 ) ) > this.tools.accuracySqr )
    if( this.tools.avector.isGreaterAprox( Math.abs( dOrigin.eGet( 0 ) ), this.tools.accuracySqr ) )
    {
      return false;
    }
    else
    {
      factor = 0;
    }
  }
  else
  {
    factor = dOrigin.eGet( 0 ) / direction.eGet( 0 );
  }

  // Factor can not be negative or superior to one
  // if(  factor <= 0 - this.tools.accuracySqr || factor >= 1 + this.tools.accuracySqr )
  if(  this.tools.avector.isLessEqualAprox( factor, 0 - this.tools.accuracySqr ) || this.tools.avector.isGreaterEqualAprox( factor, 1 + this.tools.accuracySqr ) )
  return false;

  let newPoint = this.segmentAt( srcSegmentView, factor );

  if( this.tools.avector.allEquivalent( newPoint, srcPoint ) )
  return true;

  for( var i = 1; i < dOrigin.length; i++ )
  {
    let newFactor;
    if( direction.eGet( i ) === 0 )
    {
      // if( Math.abs( dOrigin.eGet( i ) ) > this.tools.accuracySqr )
      if( this.tools.avector.isGreaterAprox( Math.abs( dOrigin.eGet( i ) ), this.tools.accuracySqr ) )
      {
        return false;
      }
      else
      {
        newFactor = 0;
      }
    }
    else
    {
      newFactor = dOrigin.eGet( i ) / direction.eGet( i );

      // if( Math.abs( newFactor - factor ) > this.tools.accuracySqr && direction.eGet( i - 1 ) !== 0 )
      if( this.tools.avector.isGreaterAprox( Math.abs( newFactor - factor ), this.tools.accuracySqr ) )
      if( !this.tools.number.equivalent( direction.eGet( i - 1 ), 0 ) )
      {
        return false;
      }
      factor = newFactor;

      // Factor can not be negative or superior to one
      // if(  factor <= 0 - this.tools.accuracySqr || factor >= 1 + this.tools.accuracySqr )
      if(  this.tools.avector.isLessEqualAprox( factor, 0 - this.tools.accuracySqr ) || this.tools.avector.isGreaterEqualAprox( factor, 1 + this.tools.accuracySqr ) )
      return false;
    }

    newPoint = this.segmentAt( srcSegmentView, factor );
    if( this.tools.avector.allEquivalent( newPoint, srcPoint ) )
    return true;
  }

  return false;
}

//

/**
  * Get the distance between a point and a segment. Returs the calculated distance. Point and segment stay untouched.
  *
  * @param { Array } srcSegment - The source segment.
  * @param { Array } srcPoint - The source point.
  *
  * @example
  * // returns 0
  * _.pointDistance( [ 0, 0, 0, 2 ], [ 0, 1 ] );
  *
  * @example
  * // returns 2
  * _.pointDistance( [ 0, 0, 0, 2 ], [ 2, 2 ] );
  *
  * @returns { Boolean } Returns the distance between the point and the segment.
  * @function pointDistance
  * @throws { Error } An Error if ( dim ) is different than point.length (segment and point have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcPoint ) is not point.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function pointDistanceSqr( srcSegment, srcPoint )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcSegment === null )
  srcSegment = this.make( srcPoint.length );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let origin = this.originGet( srcSegmentView );
  let direction = this.directionGet( srcSegmentView );
  let dimension  = this.dimGet( srcSegmentView )
  let srcPointView = this.tools.vectorAdapter.from( srcPoint.slice() );

  _.assert( dimension === srcPoint.length, 'The segment and the point must have the same dimension' );

  if( this.pointContains( srcSegmentView, srcPointView ) )
  {
    return 0;
  }
  else
  {
    let projection = this.pointClosestPoint( srcSegmentView, srcPointView );
    let factor = this.getFactor( srcSegmentView, projection );

    let dPoints = this.tools.vectorAdapter.from( this.tools.avector.sub( srcPointView, projection ) );
    debugger;
    let mod = this.tools.vectorAdapter.dot( dPoints, dPoints );
    // mod = Math.sqrt( mod );

    return mod;

  }
}

//

function pointDistance( srcSegment, srcPoint )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let distance = this.pointDistanceSqr( srcSegment, srcPoint );

  if( distance === 0 )
  return distance;

  return Math.sqrt( distance );
}

//

/**
  * Get the closest point between a point and a segment. Returs the calculated point. srcPoint and segment stay untouched.
  *
  * @param { Array } srcSegment - The source segment.
  * @param { Array } srcPoint - The source point.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * _.pointClosestPoint( [ 0, 0, 0, 2 ], [ 0, 1 ] );
  *
  * @example
  * // returns [ 0, 2 ]
  * _.pointClosestPoint( [ 0, 0, 0, 2 ], [ 2, 2 ] );
  *
  * @returns { Boolean } Returns the closest point in a segment to a point.
  * @function pointClosestPoint
  * @throws { Error } An Error if ( dim ) is different than point.length (segment and point have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcPoint ) is not point.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */

function pointClosestPoint( srcSegment, srcPoint, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( srcPoint.length );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcSegment === null )
  srcSegment = this.make( srcPoint.length );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let origin = this.originGet( srcSegmentView );
  let end = this.endPointGet( srcSegmentView );
  let direction = this.directionGet( srcSegmentView );
  let dimension  = this.dimGet( srcSegmentView )
  let srcPointView = this.tools.vectorAdapter.from( srcPoint.slice() );
  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimension === srcPoint.length, 'The segment and the point must have the same dimension' );

  let pointVector;

  var dir = 0;
  for( var i = 0; i < direction.length; i++ )
  {
    if( direction.eGet( i ) === 0 )
    dir = dir + 1;
  }

  if( dir === direction.length )
  {
    pointVector = origin;
  }
  else if( this.pointContains( srcSegmentView, srcPointView ) )
  {
    pointVector = this.tools.vectorAdapter.from( srcPointView );
  }
  else
  {
    let dOrigin = this.tools.vectorAdapter.from( this.tools.avector.sub( srcPointView, origin ) );
    let dot = this.tools.vectorAdapter.dot( direction, direction );
    let factor = this.tools.vectorAdapter.dot( direction , dOrigin ) / dot ;

    if( factor < 0 || dot === 0 )
    {
      pointVector = this.tools.vectorAdapter.from( origin );
    }
    else if( factor > 1 )
    {
      pointVector = this.tools.vectorAdapter.from( end );
    }
    else
    {
      pointVector = this.tools.vectorAdapter.from( this.segmentAt( srcSegmentView, factor ) );
    }
  }

  for( let i = 0; i < pointVector.length; i++ )
  {
    dstPointView.eSet( i, pointVector.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Check if a segment and a box intersect. Returns true if they intersect and false if not.
  * The box and the segment remain unchanged. Only for 1D to 3D
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcBox - Source box.
  *
  * @example
  * // returns true;
  * _.boxIntersects( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns false;
  * _.boxIntersects( [ 0, -1, 0, 0, -2, 0 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Boolean } Returns true if the segment and the box intersect.
  * @function boxIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the segment and box don´t have the same dimension).
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function boxIntersects( srcSegment, srcBox )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcSegment === null )
  srcSegment = this.make( srcBox.length / 2 );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let origin = this.originGet( srcSegmentView );
  let end = this.endPointGet( srcSegmentView );
  let direction = this.directionGet( srcSegmentView );
  let dimSegment  = this.dimGet( srcSegmentView )

  let boxView = this.tools.box.adapterFrom( srcBox );
  let dimBox = this.tools.box.dimGet( boxView );
  let min = this.tools.vectorAdapter.from( this.tools.box.cornerLeftGet( boxView ) );
  let max = this.tools.vectorAdapter.from( this.tools.box.cornerRightGet( boxView ) );

  _.assert( dimSegment === dimBox );

  if( this.tools.box.pointContains( boxView, origin ) || this.tools.box.pointContains( boxView, end ) )
  return true;

  /* box corners */
  let c = this.tools.box.cornersGet( boxView );

  for( let j = 0 ; j < _.Matrix.DimsOf( c )[ 1 ] ; j++ )
  {
    let corner = c.colGet( j );
    let projection = this.pointClosestPoint( srcSegmentView, corner );

    if( this.tools.box.pointContains( boxView, projection ) )
    return true;
  }

  return false;

}

//

/**
  * Get the distance between a segment and a box. Returns the calculated distance.
  * The box and the segment remain unchanged. Only for 1D to 3D
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcBox - Source box.
  *
  * @example
  * // returns 0;
  * _.boxDistance( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns Math.sqrt( 12 );
  * _.boxDistance( [ 0, 0, 0, 0, -2, 0 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Number } Returns the distance between the segment and the box.
  * @function boxDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the segment and box don´t have the same dimension).
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function boxDistance( srcSegment, srcBox )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcSegment === null )
  srcSegment = this.make( srcBox.length / 2 );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let origin = this.originGet( srcSegmentView );
  let direction = this.directionGet( srcSegmentView );
  let dimSegment  = this.dimGet( srcSegmentView )

  let boxView = this.tools.box.adapterFrom( srcBox );
  let dimBox = this.tools.box.dimGet( boxView );
  let min = this.tools.vectorAdapter.from( this.tools.box.cornerLeftGet( boxView ) );
  let max = this.tools.vectorAdapter.from( this.tools.box.cornerRightGet( boxView ) );

  _.assert( dimSegment === dimBox );

  if( this.boxIntersects( srcSegmentView, boxView ) )
  return 0;

  let closestPoint = this.boxClosestPoint( srcSegmentView, boxView );
  return this.tools.box.pointDistance( boxView, closestPoint );
}

//

/**
  * Get the closest point in a segment to a box. Returns the calculated point.
  * The box and the segment remain unchanged. Only for 1D to 3D
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcBox - Source box.
  *
  * @example
  * // returns 0;
  * _.boxClosestPoint( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns [ 0, - 1, 0 ];
  * _.boxClosestPoint( [ 0, - 1, 0, 0, -2, 0 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Number } Returns the closest point in the segment to the box.
  * @function boxClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the segment and box don´t have the same dimension).
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function boxClosestPoint( srcSegment, srcBox, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( srcBox.length / 2 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcSegment === null )
  srcSegment = this.make( srcBox.length / 2 );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let origin = this.originGet( srcSegmentView );
  let direction = this.directionGet( srcSegmentView );
  let dimSegment  = this.dimGet( srcSegmentView )

  let boxView = this.tools.box.adapterFrom( srcBox );
  let dimBox = this.tools.box.dimGet( boxView );
  let min = this.tools.vectorAdapter.from( this.tools.box.cornerLeftGet( boxView ) );
  let max = this.tools.vectorAdapter.from( this.tools.box.cornerRightGet( boxView ) );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  _.assert( dimSegment === dimBox );

  if( this.boxIntersects( srcSegmentView, boxView ) )
  return 0;

  /* box corners */
  let c = this.tools.box.cornersGet( boxView );

  let distance = this.tools.box.pointDistance( boxView, origin );
  let d = 0;
  let pointView = this.tools.vectorAdapter.from( origin );

  for( let j = 0 ; j < _.Matrix.DimsOf( c )[ 1 ] ; j++ )
  {
    let corner = c.colGet( j );
    d = Math.abs( this.pointDistance( srcSegmentView, corner ) );
    if( d < distance )
    {
      distance = d;
      pointView = this.pointClosestPoint( srcSegmentView, corner );
    }
  }

  pointView = this.tools.vectorAdapter.from( pointView );
  for( let i = 0; i < pointView.length; i++ )
  {
    dstPointView.eSet( i, pointView.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Get the bounding box of a segment. Returns destination box.
  * Segment and box are stored in Array data structure. Source segment stays untouched.
  *
  * @param { Array } dstBox - destination box.
  * @param { Array } srcSegment - source segment for the bounding box.
  *
  * @example
  * // returns [ - 2, - 2, - 2, 2, 2, 2 ]
  * _.boundingBoxGet( null, [ 0, 0, 0, 2, 2, 2 ] );
  *
  * @returns { Array } Returns the array of the bounding box.
  * @function boundingBoxGet
  * @throws { Error } An Error if ( dim ) is different than dimGet(segment) (the segment and the box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstBox ) is not box
  * @throws { Error } An Error if ( srcSegment ) is not segment
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function boundingBoxGet( dstBox, srcSegment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let origin = this.originGet( srcSegmentView );
  let endPoint = this.endPointGet( srcSegmentView );
  let dimSegment  = this.dimGet( srcSegmentView )

  if( dstBox === null || dstBox === undefined )
  dstBox = this.tools.box.makeSingular( dimSegment );

  _.assert( _.box.is( dstBox ) );
  let dimB = this.tools.box.dimGet( dstBox );

  _.assert( dimSegment === dimB );

  let boxView = this.tools.box.adapterFrom( dstBox );
  let box = this.tools.box.adapterFrom( this.tools.box.fromPoints( null, [ origin, endPoint ] ) );

  for( let b = 0; b < boxView.length; b++ )
  {
    boxView.eSet( b, box.eGet( b ) );
  }

  return dstBox;
}

//

function capsuleIntersects( srcSegment , tstCapsule )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstCapsuleView = this.tools.capsule.adapterFrom( tstCapsule );
  let segmentView = this.adapterFrom( srcSegment );

  let gotBool = this.tools.capsule.segmentIntersects( tstCapsuleView, segmentView );
  return gotBool;
}

//

function capsuleDistance( srcSegment , tstCapsule )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstCapsuleView = this.tools.capsule.adapterFrom( tstCapsule );
  let segmentView = this.adapterFrom( srcSegment );

  let gotDist = this.tools.capsule.segmentDistance( tstCapsuleView, segmentView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a segment to a capsule. Returns the calculated point.
  * Segment and capsule remain unchanged
  *
  * @param { Array } segment - The source segment.
  * @param { Array } capsule - The source capsule.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * let capsule = [ 0, 0, 0, - 1, - 1, - 1, 1 ]
  * _.capsuleClosestPoint( [ 0, 0, 0, 2, 2, 2 ], capsule );
  *
  * @example
  * // returns [ 2, 2, 2 ]
  * _.capsuleClosestPoint( [ 2, 2, 2, 3, 3, 3 ], capsule );
  *
  * @returns { Array } Returns the closest point to the capsule.
  * @function capsuleClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( segment ) is not segment
  * @throws { Error } An Error if ( capsule ) is not capsule
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function capsuleClosestPoint( segment, capsule, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let segmentView = this.adapterFrom( segment );
  let dimS = this.dimGet( segmentView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimS );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let capsuleView = this.tools.capsule.adapterFrom( capsule );
  let dimCapsule  = this.tools.capsule.dimGet( capsuleView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimS === dstPoint.length );
  _.assert( dimS === dimCapsule );

  if( this.tools.capsule.segmentIntersects( capsuleView, segmentView ) )
  return 0
  else
  {
    let capsulePoint = this.tools.capsule.segmentClosestPoint( capsule, segmentView );

    let segmentPoint = this.tools.vectorAdapter.from( this.pointClosestPoint( segmentView, capsulePoint ) );

    for( let i = 0; i < dimS; i++ )
    {
      dstPointView.eSet( i, segmentPoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

function convexPolygonIntersects( srcSegment , polygon )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.convexPolygon.is( polygon ) );
  let segmentView = this.adapterFrom( srcSegment );

  let gotBool = this.tools.convexPolygon.segmentIntersects( polygon, segmentView );

  return gotBool;
}

//

function convexPolygonDistance( srcSegment , polygon )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.convexPolygon.is( polygon ) );
  let segmentView = this.adapterFrom( srcSegment );

  let gotDist = this.tools.convexPolygon.segmentDistance( polygon, segmentView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a segment to a convex polygon. Returns the calculated point.
  * Segment and polygon remain unchanged
  *
  * @param { Array } segment - The source segment.
  * @param { Polygon } polygon - The source polygon.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns [ 0, 2, 0 ]
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([
  *    0,   0,   0,   0,
  *    1,   0, - 1,   0,
  *    0,   1,   0, - 1
  *  ]);
  * _.convexPolygonClosestPoint( [ -5, 2, -5, 1, 2, 1 ], polygon );
  *
  * @returns { Array } Returns the closest point to the polygon.
  * @function convexPolygonClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( segment ) is not segment
  * @throws { Error } An Error if ( polygon ) is not convexPolygon
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function convexPolygonClosestPoint( segment, polygon, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  _.assert( _.convexPolygon.is( polygon ) );

  let segmentView = this.adapterFrom( segment );
  let dimS = this.dimGet( segmentView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimS );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  // let capsuleView = _.capsule.adapterFrom( capsule );
  // let dimCapsule  = _.capsule.dimGet( capsuleView );
  let dimP  = _.Matrix.DimsOf( polygon );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimS === dstPoint.length );
  _.assert( dimP[ 0 ] === dimS );

  if( this.tools.convexPolygon.segmentIntersects( polygon, segmentView ) )
  return 0
  else
  {
    let polygonPoint = this.tools.convexPolygon.segmentClosestPoint( polygon, segmentView );

    // xxx
    // let segmentPoint = this.tools.vectorAdapter.from( this.pointClosestPoint( segmentView, capsulePoint ) );
    let segmentPoint = this.pointClosestPoint( segmentView, polygonPoint, this.tools.vectorAdapter.make( dimS ) ) ;

    for( let i = 0; i < dimS; i++ )
    {
      dstPointView.eSet( i, segmentPoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

/**
  * Check if a segment and a frustum intersect. Returns true if they intersect and false if not.
  * The frustum and the segment remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcFrustum - Source frustum.
  *
  * @example
  * // returns true;
  * var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1
  * ]);
  * _.frustumIntersects( [ 0, 0, 0, 2, 2, 2 ] , srcFrustum );
  *
  * @example
  * // returns false;
  * _.frustumIntersects( [ 0, -1, 0, 0, -2, 0 ] , srcFrustum );
  *
  * @returns { Boolean } Returns true if the segment and the frustum intersect.
  * @function frustumIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( dim ) is different than frustum.dimGet (the segment and frustum don´t have the same dimension).
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function frustumIntersects( srcSegment, srcFrustum )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( srcFrustum ) );

  let dimFrustum = _.Matrix.DimsOf( srcFrustum ) ;
  let rows = dimFrustum[ 0 ];
  let cols = dimFrustum[ 1 ];

  if( srcSegment === null )
  srcSegment = this.make( rows - 1 );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let origin = this.originGet( srcSegmentView );
  let direction = this.directionGet( srcSegmentView );
  let dimSegment  = this.dimGet( srcSegmentView );

  _.assert( dimSegment === rows - 1 );

  if( this.tools.frustum.pointContains( srcFrustum, origin ) )
  return true;

  /* frustum corners */
  let corners = this.tools.frustum.cornersGet( srcFrustum );
  let cornersLength = _.Matrix.DimsOf( corners )[ 1 ];

  for( let j = 0 ; j < cornersLength ; j++ )
  {
    let corner = corners.colGet( j );
    let projection = this.pointClosestPoint( srcSegmentView, corner );

    if( this.tools.frustum.pointContains( srcFrustum, projection ) )
    return true;
  }

  return false;

}

//

/**
  * Get the distance between a segment and a frustum. Returns the calculated distance.
  * The frustum and the segment remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcFrustum - Source frustum.
  *
  * @example
  * // returns 0;
  * var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1
  * ]);
  * _.frustumDistance( [ 0, 0, 0, 2, 2, 2 ] , srcFrustum );
  *
  * @example
  * // returns 1;
  * _.frustumDistance( [ 0, - 1, 0, 0, -2, 0 ] , srcFrustum );
  *
  * @returns { Number } Returns the distance between a segment and a frustum.
  * @function frustumDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( dim ) is different than frustum.dimGet (the segment and frustum don´t have the same dimension).
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function frustumDistance( srcSegment, srcFrustum )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( srcFrustum ) );

  let dimFrustum = _.Matrix.DimsOf( srcFrustum ) ;
  let rows = dimFrustum[ 0 ];
  let cols = dimFrustum[ 1 ];

  if( srcSegment === null )
  srcSegment = this.make( srcFrustum.length / 2 );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let origin = this.originGet( srcSegmentView );
  let direction = this.directionGet( srcSegmentView );
  let dimSegment  = this.dimGet( srcSegmentView );

  _.assert( dimSegment === rows - 1 );

  if( this.frustumIntersects( srcSegmentView, srcFrustum ) )
  return 0;

  let closestPoint = this.frustumClosestPoint( srcSegmentView, srcFrustum );

  return this.tools.frustum.pointDistance( srcFrustum, closestPoint );
}

//

/**
  * Get the closest point in a segment to a frustum. Returns the calculated point.
  * The frustum and the segment remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcFrustum - Source frustum.
  *
  * @example
  * // returns 0;
  * var srcFrustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1
  * ]);
  * _.frustumClosestPoint( [ 0, 0, 0, 2, 2, 2 ] , srcFrustum );
  *
  * @example
  * // returns [ 0, - 1, 0 ];
  * _.frustumClosestPoint( [ 0, - 1, 0, 0, -2, 0 ] , srcFrustum );
  *
  * @returns { Array } Returns the closest point in the segment to the frustum.
  * @function frustumClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( dim ) is different than frustum.dimGet (the segment and frustum don´t have the same dimension).
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function frustumClosestPoint( srcSegment, srcFrustum, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  _.assert( _.frustum.is( srcFrustum ) );

  let dimFrustum = _.Matrix.DimsOf( srcFrustum ) ;
  let rows = dimFrustum[ 0 ];
  let cols = dimFrustum[ 1 ];

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( srcFrustum.length / 2 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcSegment === null )
  srcSegment = this.make( srcFrustum.length / 2 );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let origin = this.originGet( srcSegmentView );
  let direction = this.directionGet( srcSegmentView );
  let dimSegment  = this.dimGet( srcSegmentView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  _.assert( dimSegment === rows - 1 );

  if( this.frustumIntersects( srcSegmentView, srcFrustum ) )
  return 0;

  /* frustum corners */
  let corners = this.tools.frustum.cornersGet( srcFrustum );
  let cornersLength = _.Matrix.DimsOf( corners )[ 1 ];

  let distance = this.tools.frustum.pointDistance( srcFrustum, origin );
  let d = 0;
  let pointView = this.tools.vectorAdapter.from( origin );

  for( let j = 0 ; j < _.Matrix.DimsOf( corners )[ 1 ] ; j++ )
  {
    let corner = corners.colGet( j );
    d = Math.abs( this.pointDistance( srcSegmentView, corner ) );
    if( d < distance )
    {
      distance = d;
      pointView = this.pointClosestPoint( srcSegmentView, corner );
    }
  }

  pointView = this.tools.vectorAdapter.from( pointView );
  for( let i = 0; i < pointView.length; i++ )
  {
    dstPointView.eSet( i, pointView.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Check if a segment and a line intersect. Returns true if they intersect and false if not.
  * The line and the segment remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcLine - Source line.
  *
  * @example
  * // returns true;
  * var srcLine =  [ -1, -1, -1, 1, 1, 1 ]
  * var srcSegment = [ 0, 0, 0, 2, 2, 2 ]
  * _.lineIntersects( srcSegment, srcLine );
  *
  * @example
  * // returns false;
  * var srcLine =  [ -1, -1, -1, 0, 0, 1 ]
  * var srcSegment = [ 0, 1, 0, 2, 2, 2 ]
  * _.lineIntersects( srcSegment, srcLine );
  *
  * @returns { Boolean } Returns true if the segment and the line intersect.
  * @function lineIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( dim ) is different than line.dimGet (the segment and line don´t have the same dimension).
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function lineIntersects( srcSegment, srcLine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let srcLineView = this.tools.linePointDir.adapterFrom( srcLine );
  let lineOrigin = this.tools.linePointDir.originGet( srcLineView );
  let lineDirection = this.tools.linePointDir.directionGet( srcLineView );
  let dimLine  = this.tools.linePointDir.dimGet( srcLineView );

  if( srcSegment === null )
  srcSegment = this.make( srcLine.length / 2 );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let segmentOrigin = this.originGet( srcSegmentView );
  let segmentEnd = this.endPointGet( srcSegmentView );
  let dimSegment  = this.dimGet( srcSegmentView );

  _.assert( dimSegment === dimLine );

  if( this.tools.linePointDir.pointContains( srcLineView, segmentOrigin ) || this.tools.linePointDir.pointContains( srcLineView, segmentEnd ) )
  return true;

  if( this.pointContains( srcSegmentView, lineOrigin ) )
  return true;
  let lineSegment = this.tools.linePointDir.fromPoints( segmentOrigin, segmentEnd );
  if( this.tools.linePointDir.lineParallel( lineSegment, srcLineView ) )
  {
    if( this.tools.linePointDir.pointContains( srcLineView, segmentOrigin ) )
    return true;
    else
    return false;
  }

  let factors = this.tools.linePointDir.lineIntersectionFactors( lineSegment, srcLineView );

  let isLessAprox = this.tools.avector.isLessAprox;
  let isGreaterAprox = this.tools.avector.isGreaterAprox;
  // if( factors === 0 || factors.eGet( 0 ) < 0 - this.tools.accuracy || factors.eGet( 0 ) > 1 - this.tools.accuracy )
  if( factors === 0 || isLessAprox( factors.eGet( 0 ), 0 - this.tools.accuracy ) || isGreaterAprox( factors.eGet( 0 ), 1 - this.tools.accuracy ) )
  return false;

  return true;
}

//

/**
  * Returns the intersection point between a segment and a line. Returns the intersection point coordinates.
  * The segment and line remain unchanged.
  *
  * @param { Array } segment - Source segment.
  * @param { Array } line -  Source line.
  * @param { Array } dstPoint -  Destination point.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.lineIntersectionPoint( [ 1, 2, 3, 0, 0, 0 ] , [ - 2, - 2, - 2 , 3, 3, 3 ], [ 1, 1, 1 ]);
  *
  *
  * @returns { Point } Returns the point of intersection between a segment and a line.
  * @function lineIntersectionPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @throws { Error } An Error if ( line ) is not line.
  * @throws { Error } An Error if ( point ) is not point.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */

function lineIntersectionPoint( segment, line, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let segmentView = this.tools.ray.adapterFrom( segment );
  let dimS = this.tools.ray.dimGet( segmentView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimS );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let lineView = this.tools.linePointDir.adapterFrom( line );
  let origin = this.tools.linePointDir.originGet( lineView );
  let direction = this.tools.linePointDir.directionGet( lineView );
  let dimLine  = this.tools.linePointDir.dimGet( lineView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimS === dstPoint.length );
  _.assert( dimS === dimLine );

  if( !this.tools.linePointDir.segmentIntersects( lineView, segmentView ) )
  return 0
  else
  {
    let linePoint =  this.tools.vectorAdapter.from( this.tools.linePointDir.segmentIntersectionPoint( lineView, segmentView ) );

    for( let i = 0; i < dimS; i++ )
    {
      dstPointView.eSet( i, linePoint.eGet( i ) );
    }

    return dstPoint;
  }
}

//

/**
  * Returns the factors for the intersection between a line and a segment. Returns a vector with the intersection factors, 0 if there is no intersection.
  * Line and segment stay untouched.
  *
  * @param { Vector } srcSegment - The source segment.
  * @param { Vector } srcLine - The source line.
  *
  * @example
  * // returns   0
  * _.lineIntersectionFactors( [ 1, 0, 1, 0 ], [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns  this.tools.vectorAdapter.from( [ 0, 0 ] )
  * _.lineIntersectionFactors( [ 0, - 2, 0, 2 ], [ - 2, 0, 1, 0 ] );
  *
  * @returns { Array } Returns the factors of the intersection between a line and a segment.
  * @function lineIntersectionFactors
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function lineIntersectionFactors( srcSegment, srcLine )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( srcLine.length === srcSegment.length, 'The line and the segment must have the same dimension' );

  let srcLineView = this.tools.linePointDir.adapterFrom( srcLine.slice() );
  let srcSegmentView = this.tools.linePointDir.adapterFrom( srcSegment.slice() );
  let origin = this.originGet( srcSegmentView );
  let end = this.endPointGet( srcSegmentView );

  let intersection = this.tools.linePointDir.segmentIntersects( srcLineView, srcSegmentView );

  if( !intersection )
  return 0;

  let segmentLine = this.tools.linePointDir.fromPoints( origin, end );

  return this.tools.linePointDir.lineIntersectionFactors( srcLineView, segmentLine );
}

//

/**
  * Get the distance between a line and a segment. Returns the calculated distance.
  * The segment and the line remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcLine - Test line.
  *
  * @example
  * // returns 0;
  * _.lineDistance( [ 0, 0, 0, 2, 2, 2 ], [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns Math.sqrt( 8 );
  * _.lineDistance( [ 0, 0, 0, 0, -2, 0 ] , [ 2, 2, 2, 0, 0, 1 ]);
  *
  * @returns { Number } Returns the distance between a segment and a line.
  * @function lineDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( dim ) is different than line.dimGet (the segment and line don´t have the same dimension).
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function lineDistance( srcSegment, srcLine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcSegment === null )
  srcSegment = this.make( srcLine.length / 2 );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let srcOrigin = this.originGet( srcSegmentView );
  let srcEnd = this.endPointGet( srcSegmentView );
  let srcDirection = this.directionGet( srcSegmentView );
  let srcDim  = this.dimGet( srcSegmentView )

  let srcLineView = this.tools.linePointDir.adapterFrom( srcLine );
  let lineOrigin = this.tools.linePointDir.originGet( srcLineView );
  let lineDirection = this.tools.linePointDir.directionGet( srcLineView );
  let lineDim  = this.tools.linePointDir.dimGet( srcLineView );

  _.assert( srcDim === lineDim );

  let distance;

  if( this.lineIntersects( srcSegmentView, srcLineView ) === true )
  return 0;

  // Parallel segment/line
  let lineSegment = this.tools.linePointDir.fromPoints( srcOrigin, srcEnd );
  if( this.tools.linePointDir.lineParallel( lineSegment, srcLineView ) )
  {
    // Line is point
    let lineIsPoint = 0;
    for( let i = 0; i < lineDim; i++ )
    {
      // if( lineDirection.eGet( i ) === 0 )
      if( this.tools.number.equivalent( lineDirection.eGet( i ), 0 ) )
      lineIsPoint = lineIsPoint + 1;
    }

    if( lineIsPoint === lineDim )
    {
      distance = this.pointDistance( srcSegmentView, lineOrigin );
    }
    else
    {
      distance = this.tools.linePointDir.pointDistance( srcLineView, srcOrigin );
    }
  }
  else
  {
    let srcPoint = this.lineClosestPoint( srcSegmentView, srcLineView );
    let tstPoint = this.tools.linePointDir.segmentClosestPoint( srcLineView, srcSegmentView );
    distance = this.tools.avector.distance( srcPoint, tstPoint );
  }

  return distance;
}

//

/**
  * Get the closest point in a segment to a line. Returns the calculated point.
  * The segment and line remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcLine - Test line.
  *
  * @example
  * // returns 0;
  * _.lineClosestPoint( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.lineClosestPoint( [ 0, 0, 0, 0, 1, 0 ] , [ 1, 0, 0, 1, 0, 0 ]);
  *
  * @returns { Array } Returns the closest point in the srcSegment to the srcLine.
  * @function lineClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( dim ) is different than line.dimGet (the segment and line don´t have the same dimension).
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function lineClosestPoint( srcSegment, srcLine, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( srcLine.length / 2 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcSegment === null )
  srcSegment = this.make( srcLine.length / 2 );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let srcOrigin = this.originGet( srcSegmentView );
  let srcEnd = this.endPointGet( srcSegmentView );
  let srcDir = this.directionGet( srcSegmentView );
  let srcDim  = this.dimGet( srcSegmentView );

  let srcLineView = this.tools.linePointDir.adapterFrom( srcLine );
  let lineOrigin = this.tools.linePointDir.originGet( srcLineView );
  let tstDir = this.tools.linePointDir.directionGet( srcLineView );
  let lineDim = this.tools.linePointDir.dimGet( srcLineView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  _.assert( srcDim === lineDim );

  let pointView;

  // Same origin - line is point
  let identOrigin = 0;
  let linePoint = 0;
  for( let i = 0; i < srcOrigin.length; i++ )
  {
    // if( srcOrigin.eGet( i ) === lineOrigin.eGet( i ) )
    if( this.tools.number.equivalent( srcOrigin.eGet( i ), lineOrigin.eGet( i ) ) )
    identOrigin = identOrigin + 1;

    // if( tstDir.eGet( i ) === 0 )
    if( this.tools.number.equivalent( tstDir.eGet( i ), 0 ) )
    linePoint = linePoint + 1;
  }
  if( identOrigin === srcOrigin.length )
  {
    pointView = srcOrigin;
  }
  else if( linePoint === srcOrigin.length )
  {
    pointView = this.pointClosestPoint( srcSegmentView, lineOrigin );
  }
  else
  {
    let lineSegment = this.tools.linePointDir.fromPoints( srcOrigin, srcEnd );
    // Parallel segments
    if( this.tools.linePointDir.lineParallel( lineSegment, srcLineView ) )
    {
      pointView = this.pointClosestPoint( srcSegmentView, lineOrigin );
    }
    else
    {
      let srcMod = this.tools.vectorAdapter.dot( srcDir, srcDir );
      let tstMod = this.tools.vectorAdapter.dot( tstDir, tstDir );
      let mod = this.tools.vectorAdapter.dot( srcDir, tstDir );
      let dOrigin = this.tools.vectorAdapter.from( this.tools.avector.sub( lineOrigin.slice(), srcOrigin ) );

      // if( tstMod*srcMod - mod*mod === 0 )
      if( this.tools.number.equivalent( tstMod*srcMod - mod*mod, 0 ) )
      {
          pointView = srcOrigin;
      }
      else
      {
        let factor = ( - mod*this.tools.vectorAdapter.dot( tstDir, dOrigin ) + tstMod*this.tools.vectorAdapter.dot( srcDir, dOrigin ))/( tstMod*srcMod - mod*mod );
        // if( factor < 0 )
        if( this.tools.avector.isLessAprox( factor, 0 ) )
        {
          pointView = srcOrigin;
        }
        // else if( factor > 1 )
        else if( this.tools.avector.isGreaterAprox( factor, 1 ) )
        {
          pointView = srcEnd;
        }
        else
        {
          pointView = this.segmentAt( srcSegmentView, factor );
        }
      }
    }
  }

  pointView = this.tools.vectorAdapter.from( pointView );
  for( let i = 0; i < pointView.length; i++ )
  {
    dstPointView.eSet( i, pointView.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Check if a segment and a plane intersect. Returns true if they intersect and false if not.
  * The plane and the segment remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcPlane - Source plane.
  *
  * @example
  * // returns true;
  * _.planeIntersects( [ 0, 0, 0, 2, 2, 2 ] , [ 1, 0, 0, - 1 ]);
  *
  * @example
  * // returns false;
  * _.planeIntersects( [ 0, -1, 0, 0, -2, 0 ] , [ 1, 0, 0, - 1 ]);
  *
  * @returns { Boolean } Returns true if the segment and the plane intersect.
  * @function planeIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the segment and plane don´t have the same dimension).
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function planeIntersects( srcSegment, srcPlane )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcSegment === null )
  srcSegment = this.make( srcPlane.length - 1 );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let origin = this.originGet( srcSegmentView );
  let direction = this.directionGet( srcSegmentView );
  let dimSegment  = this.dimGet( srcSegmentView )

  let planeView = this.tools.plane.adapterFrom( srcPlane );
  let normal = this.tools.plane.normalGet( planeView );
  let bias = this.tools.plane.biasGet( planeView );
  let dimPlane = this.tools.plane.dimGet( planeView );

  _.assert( dimSegment === dimPlane );

  if( this.tools.plane.pointContains( planeView, origin ) )
  return true;

  let dirDotNormal = this.tools.vectorAdapter.dot( direction, normal );

  // if( dirDotNormal !== 0 )
  if( this.tools.avector.isNotEquivalent( dirDotNormal, 0 ) )
  {
    let originDotNormal = this.tools.vectorAdapter.dot( origin, normal );
    let factor = - ( originDotNormal + bias ) / dirDotNormal;

    let isLessEqualAprox = this.tools.avector.isLessEqualAprox;
    let isGreaterEqualAprox = this.tools.avector.isGreaterEqualAprox;
    // if( factor >= 0 && factor <= 1 )
    if( isGreaterEqualAprox( factor, 0 ) && isLessEqualAprox( factor, 1 ) )
    {
      return true;
    }
  }
  return false;
}

//

/**
  * Returns the intersection point between a segment and a plane. Returns the intersection point coordinates.
  * The segment and plane remain unchanged.
  *
  * @param { Array } segment - Source segment.
  * @param { Array } plane -  Source plane.
  * @param { Array } dstPoint -  Destination point.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.planeIntersectionPoint( [ - 2, - 2, - 2 , 3, 3, 3 ], [ 1, 0, 0, 0 ] , [ 1, 1, 1 ]);
  *
  *
  * @returns { Point } Returns the point of intersection between a segment and a plane.
  * @function planeIntersectionPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( point ) is not point.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */

function planeIntersectionPoint( segment, plane, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let segmentView = this.adapterFrom( segment );
  let dimS = this.dimGet( segmentView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimS );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let planeView = this.tools.plane.adapterFrom( plane );
  let dimP  = this.tools.plane.dimGet( planeView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimS === dstPoint.length );
  _.assert( dimS === dimP );

  if( !this.tools.plane.segmentIntersects( planeView, segmentView ) )
  return 0
  else
  {
    let planePoint =  this.tools.vectorAdapter.from( this.tools.plane.segmentIntersectionPoint( planeView, segmentView ) );

    for( let i = 0; i < dimS; i++ )
    {
      dstPointView.eSet( i, planePoint.eGet( i ) );
    }

    return dstPoint;
  }
}

//

/**
  * Get the distance between a segment and a plane. Returns the calculated distance.
  * The plane and the segment remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcPlane - Source plane.
  *
  * @example
  * // returns 0;
  * _.planeDistance( [ 0, 0, 0, 2, 2, 2 ] , [ 1, 0, 0, - 1 ]);
  *
  * @example
  * // returns 1;
  * _.planeDistance( [ 0, -1, 0, 0, -2, 0 ] , [ 1, 0, 0, - 1 ]);
  *
  * @returns { Number } Returns the distance between the segment and the plane.
  * @function planeDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the segment and plane don´t have the same dimension).
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function planeDistance( srcSegment, srcPlane )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcSegment === null )
  srcSegment = this.make( srcPlane.length - 1 );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let origin = this.originGet( srcSegmentView );
  let end = this.endPointGet( srcSegmentView );
  let direction = this.directionGet( srcSegmentView );
  let dimSegment  = this.dimGet( srcSegmentView )

  let planeView = this.tools.plane.adapterFrom( srcPlane );
  let normal = this.tools.plane.normalGet( planeView );
  let bias = this.tools.plane.biasGet( planeView );
  let dimPlane = this.tools.plane.dimGet( planeView );

  _.assert( dimSegment === dimPlane );

  if( this.planeIntersects( srcSegmentView, planeView ) )
  return 0;

  let d1 = Math.abs( this.tools.plane.pointDistance( planeView, origin ) );
  let d2 = Math.abs( this.tools.plane.pointDistance( planeView, end ) );

  // if( d1 < d2 )
  if( this.tools.avector.isLessAprox( d1, d2 ) )
  {
    return d1;
  }
  else
  {
    return d2;
  }
}

//

/**
  * Get the closest point between a segment and a plane. Returns the calculated point.
  * The plane and the segment remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcPlane - Source plane.
  * @param { Array } dstPoint - Destination point.
  *
  * @example
  * // returns 0;
  * _.planeClosestPoint( [ 0, 0, 0, 2, 2, 2 ] , [ 1, 0, 0, - 1 ]);
  *
  * @example
  * // returns [ 0, -1, 0 ];
  * _.planeClosestPoint( [ 0, -1, 0, 0, -2, 0 ] , [ 1, 0, 0, - 1 ]);
  *
  * @returns { Array } Returns the closest point in the segment to the plane.
  * @function planeClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the segment and plane don´t have the same dimension).
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function planeClosestPoint( srcSegment, srcPlane, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( srcPlane.length - 1 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcSegment === null )
  srcSegment = this.make( srcPlane.length - 1 );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let origin = this.originGet( srcSegmentView );
  let end = this.endPointGet( srcSegmentView );
  let direction = this.directionGet( srcSegmentView );
  let dimSegment  = this.dimGet( srcSegmentView )

  let planeView = this.tools.plane.adapterFrom( srcPlane );
  let normal = this.tools.plane.normalGet( planeView );
  let bias = this.tools.plane.biasGet( planeView );
  let dimPlane = this.tools.plane.dimGet( planeView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimSegment === dimPlane );

  if( this.planeIntersects( srcSegmentView, planeView ) )
  return 0;

  let point;
  let d1 = Math.abs( this.tools.plane.pointDistance( planeView, origin ) ) ;
  let d2 = Math.abs( this.tools.plane.pointDistance( planeView, end ) );

  // if( d1 <= d2 )
  if( this.tools.avector.isLessEqualAprox( d1, d2 ) )
  {
    point = this.tools.vectorAdapter.from( origin );
  }
  else
  {
    point = this.tools.vectorAdapter.from( end );
  }
  for( let i = 0; i < point.length; i++ )
  {
    dstPointView.eSet( i, point.eGet( i ) );
  }


  return dstPoint;
}

//

/**
  * Check if a segment and a ray intersect. Returns true if they intersect and false if not.
  * The ray and the segment remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcRay - Source ray.
  *
  * @example
  * // returns true;
  * var srcRay =  [ -1, -1, -1, 1, 1, 1 ]
  * var srcSegment = [ 0, 0, 0, 2, 2, 2 ]
  * _.rayIntersects( srcSegment, srcRay );
  *
  * @example
  * // returns false;
  * var srcRay =  [ -1, -1, -1, 0, 0, 1 ]
  * var srcSegment = [ 0, 1, 0, 2, 2, 2 ]
  * _.rayIntersects( srcSegment, srcRay );
  *
  * @returns { Boolean } Returns true if the segment and the ray intersect.
  * @function rayIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( dim ) is different than ray.dimGet (the segment and ray don´t have the same dimension).
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function rayIntersects( srcSegment, srcRay )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let srcRayView = this.tools.ray.adapterFrom( srcRay );
  let rayOrigin = this.tools.ray.originGet( srcRayView );
  let rayDirection = this.tools.ray.directionGet( srcRayView );
  let dimRay  = this.tools.ray.dimGet( srcRayView );

  if( srcSegment === null )
  srcSegment = this.make( srcRay.length / 2 );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let segmentOrigin = this.originGet( srcSegmentView );
  let segmentEnd = this.endPointGet( srcSegmentView );
  let dimSegment  = this.dimGet( srcSegmentView );

  _.assert( dimSegment === dimRay );

  let lineSegment = this.tools.linePointDir.fromPoints( segmentOrigin, segmentEnd );
  if( this.tools.linePointDir.lineParallel( lineSegment, srcRayView ) )
  {
    let rayContainsSegment = this.tools.ray.pointContains( srcRayView, segmentOrigin ) || this.tools.ray.pointContains( srcRayView, segmentEnd );
    let segmentContainsRay = this.pointContains( srcSegmentView, rayOrigin );
    if(  rayContainsSegment || segmentContainsRay )
    return true;
    else
    return false;
  }
  let factors = this.tools.ray.rayIntersectionFactors( srcRayView, lineSegment );

  if( factors === 0 || factors.eGet( 0 ) < 0 || factors.eGet( 1 ) < 0 || ( factors.eGet( 0 ) > 1 && factors.eGet( 1 ) > 1 ) )
  return false;

  if( factors.eGet( 0 ) > 1 )
  {
    let point = this.segmentAt( srcSegmentView, factors.eGet( 1 ) );
    let contained = this.tools.ray.pointContains( srcRayView, point );

    if( contained === false )
    return false;
  }
  else if( factors.eGet( 1 ) > 1 )
  {
    let point = this.segmentAt( srcSegmentView, factors.eGet( 0 ) );
    let contained = this.tools.ray.pointContains( srcRayView, point );

    if( contained === false )
    return false;
  }

  return true;
}

//

/**
  * Returns the intersection point between a segment and a ray. Returns the intersection point coordinates.
  * The segment and ray remain unchanged.
  *
  * @param { Array } segment - Source segment.
  * @param { Array } ray -  Source ray.
  * @param { Array } dstPoint -  Destination point.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.rayIntersectionPoint( [ - 2, - 2, - 2 , 3, 3, 3 ], [ 1, 0, 0, -1, 0, 0 ] , [ 1, 1, 1 ]);
  *
  *
  * @returns { Point } Returns the point of intersection between a segment and a ray.
  * @function rayIntersectionPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @throws { Error } An Error if ( ray ) is not ray.
  * @throws { Error } An Error if ( point ) is not point.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */

function rayIntersectionPoint( segment, ray, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let segmentView = this.adapterFrom( segment );
  let dimS = this.dimGet( segmentView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimS );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let rayView = this.tools.ray.adapterFrom( ray );
  let dimR  = this.tools.ray.dimGet( rayView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimS === dstPoint.length );
  _.assert( dimS === dimR );

  if( !this.tools.ray.segmentIntersects( rayView, segmentView ) )
  return 0
  else
  {
    let rayPoint =  this.tools.vectorAdapter.from( this.tools.ray.segmentIntersectionPoint( rayView, segmentView ) );

    for( let i = 0; i < dimS; i++ )
    {
      dstPointView.eSet( i, rayPoint.eGet( i ) );
    }

    return dstPoint;
  }
}

//

/**
  * Returns the factors for the intersection between a segment and a ray. Returns a vector with the intersection factors, 0 if there is no intersection.
  * Segment and ray stay untouched.
  *
  * @param { Vector } srcSegment - The source segment.
  * @param { Vector } srcRay - The source ray.
  *
  * @example
  * // returns   0
  * _.rayIntersectionFactors( [ 0, 0, 2, 2 ], [ 1, 0, 1, 0 ] );
  *
  * @example
  * // returns  this.tools.vectorAdapter.from( [ 0, 0 ] )
  * _.rayIntersectionFactors( [ - 2, 0, 1, 0 ], [ 0, - 2, 0, 2 ] );
  *
  * @returns { Array } Returns the factors of the intersection between a segment and a ray.
  * @function rayIntersectionFactors
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function rayIntersectionFactors( srcSegment, srcRay )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( srcSegment.length === srcRay.length, 'The segment and the ray must have the same dimension' );

  let srcSegmentView = this.adapterFrom( srcSegment.slice() );
  let origin = this.originGet( srcSegmentView );
  let end = this.endPointGet( srcSegmentView );
  let srcRayView = this.adapterFrom( srcRay.slice() );

  let intersection = this.rayIntersects( srcSegmentView, srcRayView );

  if( !intersection )
  return 0;

  let segmentLine = this.tools.linePointDir.fromPoints( origin, end );

  return this.tools.linePointDir.lineIntersectionFactors( srcRayView, segmentLine  );

}

//

/**
  * Get the distance between a ray and a segment. Returns the calculated distance.
  * The segment and the ray remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcRay - Test ray.
  *
  * @example
  * // returns 0;
  * _.rayDistance( [ 0, 0, 0, 2, 2, 2 ], [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns Math.sqrt( 12 );
  * _.rayDistance( [ 0, 0, 0, 0, -2, 0 ] , [ 2, 2, 2, 0, 0, 1 ]);
  *
  * @returns { Number } Returns the distance between a segment and a ray.
  * @function rayDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( dim ) is different than ray.dimGet (the segment and ray don´t have the same dimension).
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function rayDistance( srcSegment, srcRay )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcSegment === null )
  srcSegment = this.make( srcRay.length / 2 );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let srcOrigin = this.originGet( srcSegmentView );
  let srcEnd = this.endPointGet( srcSegmentView );
  let srcDirection = this.directionGet( srcSegmentView );
  let srcDim  = this.dimGet( srcSegmentView )

  let srcRayView = this.tools.ray.adapterFrom( srcRay );
  let rayOrigin = this.tools.ray.originGet( srcRayView );
  let rayDirection = this.tools.ray.directionGet( srcRayView );
  let rayDim  = this.tools.ray.dimGet( srcRayView );

  _.assert( srcDim === rayDim );

  let distance;

  if( this.rayIntersects( srcSegmentView, srcRayView ) === true )
  {
    return 0;
  }

  // Parallel segment/ray
  let lineSegment = this.tools.linePointDir.fromPoints( srcOrigin, srcEnd );
  if( this.tools.linePointDir.lineParallel( lineSegment, srcRayView ) )
  {
    // Segment or ray is point
    let segIsPoint = 0;
    let rayIsPoint = 0;
    for( let i = 0; i < rayDim; i++ )
    {
      // if( srcDirection.eGet( i ) === 0 )
      if( this.tools.number.equivalent( srcDirection.eGet( i ), 0 ) )
      segIsPoint = segIsPoint + 1;

      // if( rayDirection.eGet( i ) === 0 )
      if( this.tools.number.equivalent( rayDirection.eGet( i ), 0 ) )
      rayIsPoint = rayIsPoint + 1;
    }
    if( segIsPoint === rayDim )
    {
      distance = this.tools.ray.pointDistance( srcRayView, srcOrigin );
    }
    else if( rayIsPoint === rayDim )
    {
      distance = this.pointDistance( srcSegmentView, rayOrigin );
    }
    else
    {
      //distance = this.pointDistance( srcSegmentView, rayOrigin );
      distance = this.tools.ray.pointDistance( srcRayView, srcOrigin );
      if(  this.tools.ray.pointDistance( srcRayView, srcEnd ) < distance )
      distance =  this.tools.ray.pointDistance( srcRayView, srcEnd );
    }
  }
  else
  {
    let srcPoint = this.rayClosestPoint( srcSegmentView, srcRayView );
    let tstPoint = this.tools.ray.segmentClosestPoint( srcRayView, srcSegmentView );

    distance = this.tools.avector.distance( srcPoint, tstPoint );
  }

  return distance;
}

//

/**
  * Get the closest point in a segment to a ray. Returns the calculated point.
  * The segment and ray remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcRay - Test ray.
  *
  * @example
  * // returns 0;
  * _.rayClosestPoint( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.rayClosestPoint( [ 0, 0, 0, 0, 1, 0 ] , [ 1, 0, 0, 1, 0, 0 ]);
  *
  * @returns { Array } Returns the closest point in the srcSegment to the srcRay.
  * @function rayClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( dim ) is different than ray.dimGet (the segment and ray don´t have the same dimension).
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function rayClosestPoint( srcSegment, srcRay, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( srcRay.length / 2 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcSegment === null )
  srcSegment = this.make( srcRay.length / 2 );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let srcOrigin = this.originGet( srcSegmentView );
  let srcEnd = this.endPointGet( srcSegmentView );
  let srcDir = this.directionGet( srcSegmentView );
  let srcDim  = this.dimGet( srcSegmentView );

  let srcRayView = this.tools.ray.adapterFrom( srcRay );
  let rayOrigin = this.tools.ray.originGet( srcRayView );
  let tstDir = this.tools.ray.directionGet( srcRayView );
  let rayDim = this.tools.ray.dimGet( srcRayView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  _.assert( srcDim === rayDim );

  let pointView;

  // Same origin - ray is point
  let identOrigin = 0;
  let rayPoint = 0;
  for( let i = 0; i < srcOrigin.length; i++ )
  {
    // if( srcOrigin.eGet( i ) === rayOrigin.eGet( i ) )
    if( this.tools.number.equivalent( srcOrigin.eGet( i ), rayOrigin.eGet( i ) ) )
    identOrigin = identOrigin + 1;

    // if( tstDir.eGet( i ) === 0 )
    if( this.tools.number.equivalent( tstDir.eGet( i ), 0 ) )
    rayPoint = rayPoint + 1;
  }
  if( identOrigin === srcOrigin.length )
  {
    pointView = srcOrigin;
  }
  else if( rayPoint === srcOrigin.length )
  {
    pointView = this.pointClosestPoint( srcSegmentView, rayOrigin );
  }
  else
  {
    let lineSegment = this.tools.linePointDir.fromPoints( srcOrigin, srcEnd );
    // let lineSegment = this.tools.linePointDir.fromPair( [ srcOrigin, srcEnd ] );

    // Parallel segments
    if( this.tools.linePointDir.lineParallel( lineSegment, srcRayView ) )
    {
      pointView = this.pointClosestPoint( srcSegmentView, rayOrigin );
    }
    else
    {
      let srcMod = this.tools.vectorAdapter.dot( srcDir, srcDir );
      let tstMod = this.tools.vectorAdapter.dot( tstDir, tstDir );
      let mod = this.tools.vectorAdapter.dot( srcDir, tstDir );
      let dOrigin = this.tools.vectorAdapter.from( this.tools.avector.sub( rayOrigin.slice(), srcOrigin ) );

      // if( tstMod*srcMod - mod*mod === 0 )
      if( this.tools.number.equivalent( tstMod*srcMod - mod*mod, 0 ) )
      {
          pointView = srcOrigin;
      }
      else
      {
        let factor = ( - mod*this.tools.vectorAdapter.dot( tstDir, dOrigin ) + tstMod*this.tools.vectorAdapter.dot( srcDir, dOrigin ))/( tstMod*srcMod - mod*mod );
        // if( factor < 0 )
        if( this.tools.avector.isLessAprox( factor, 0 ) )
        {
          pointView = srcOrigin;
        }
        // else if( factor > 1 )
        else if( this.tools.avector.isGreaterAprox( factor, 1 ) )
        {
          pointView = srcEnd;
        }
        else
        {
          pointView = this.segmentAt( srcSegmentView, factor );
        }
      }
    }
  }

  pointView = this.tools.vectorAdapter.from( pointView );
  for( let i = 0; i < pointView.length; i++ )
  {
    dstPointView.eSet( i, pointView.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Check if two segments intersect. Returns true if they intersect, false if not.
  * Segments stay untouched.
  *
  * @param { Vector } src1Segment - The first source segment.
  * @param { Vector } src2Segment - The second source segment.
  *
  * @example
  * // returns   true
  * _.segmentIntersects( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  false
  * _.segmentIntersects( [ -3, 0, 1, 0 ], [ 0, -2, 1, 0 ] );
  *
  * @returns { Boolean } Returns true if the two segments intersect.
  * @function segmentIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Segment ) is not segment.
  * @throws { Error } An Error if ( src2Segment ) is not segment.
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function segmentIntersects( srcSegment1, srcSegment2 )
{

  if( this.segmentIntersectionFactors( srcSegment1, srcSegment2 ) === 0 )
  return false

  return true;
}

//

/**
  * Get the distance between two segments. Returns the calculated distance.
  * The segments remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } tstSegment - Test segment.
  *
  * @example
  * // returns 0;
  * _.segmentDistance( [ 0, 0, 0, 2, 2, 2 ], [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns Math.sqrt( 12 );
  * _.segmentDistance( [ 0, 0, 0, 0, -2, 0 ] , [ 2, 2, 2, 0, 0, 1 ]);
  *
  * @returns { Number } Returns the distance between two segments.
  * @function segmentDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( tstSegment ) is not segment.
  * @throws { Error } An Error if ( dim ) is different than segment.dimGet (the segments don´t have the same dimension).
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function segmentDistance( srcSegment, tstSegment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcSegment === null )
  srcSegment = this.make( tstSegment.length / 2 );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let srcOrigin = this.originGet( srcSegmentView );
  let srcDirection = this.directionGet( srcSegmentView );
  let srcDim  = this.dimGet( srcSegmentView )

  let tstSegmentView = this.adapterFrom( tstSegment );
  let tstOrigin = this.originGet( tstSegmentView );
  let tstDirection = this.directionGet( tstSegmentView );
  let tstDim  = this.dimGet( tstSegmentView );

  _.assert( srcDim === tstDim );

  let distance;

  if( this.segmentIntersects( srcSegmentView, tstSegmentView ) === true )
  return 0;
  // Parallel segments
  if( this.segmentParallel( srcSegmentView, tstSegmentView ) )
  {
    let d1 = this.pointDistance( srcSegmentView, tstOrigin );
    let d2 = this.pointDistance( tstSegmentView, srcOrigin );
    let d3 = this.tools.avector.distance( srcOrigin, tstOrigin );
    let isLessEqualAprox = this.tools.avector.isLessEqualAprox;

    // if( d1 <= d2 && d1 <= d3 )
    if( isLessEqualAprox( d1, d2 ) && isLessEqualAprox( d1, d3 ) )
    {
      distance = d1;
    }
    // else if( d2 <= d3 )
    else if( isLessEqualAprox( d2, d3 ) )
    {
      distance = d2;
    }
    else
    {
      distance = d3;
    }
  }
  else
  {
    let srcPoint = this.segmentClosestPoint( srcSegmentView, tstSegmentView );
    let tstPoint = this.segmentClosestPoint( tstSegmentView, srcSegmentView );
    distance = this.tools.avector.distance( srcPoint, tstPoint );
  }


  return distance;
}

//

/**
  * Get the closest point in a segment to a segment. Returns the calculated point.
  * The segments remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } tstSegment - Test segment.
  *
  * @example
  * // returns 0;
  * _.segmentClosestPoint( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.segmentClosestPoint( [ 0, 0, 0, 0, 1, 0 ] , [ 1, 0, 0, 1, 0, 0 ]);
  *
  * @returns { Array } Returns the closest point in the srcSegment to the tstSegment.
  * @function segmentClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( tstSegment ) is not segment.
  * @throws { Error } An Error if ( dim ) is different than segment.dimGet (the segments don´t have the same dimension).
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */

function segmentClosestPoint( srcSegment, tstSegment, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( tstSegment.length / 2 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcSegment === null )
  srcSegment = this.make( tstSegment.length / 2 );

  debugger;
  let srcSegmentView = this.adapterFrom( srcSegment );
  let srcOrigin = this.originGet( srcSegmentView );
  let srcEnd = this.endPointGet( srcSegmentView );
  let srcDir = this.directionGet( srcSegmentView );
  let srcDim  = this.dimGet( srcSegmentView );

  let tstSegmentView = this.adapterFrom( tstSegment );
  let tstOrigin = this.originGet( tstSegmentView );
  let tstEnd = this.endPointGet( tstSegmentView );
  let tstDir = this.directionGet( tstSegmentView );
  let tstDim = this.dimGet( tstSegmentView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  _.assert( srcDim === tstDim );

  let pointView;


  if( this.segmentIntersects( srcSegmentView, tstSegmentView ) )
  return 0;

  // Parallel segments
  if( this.segmentParallel( srcSegmentView, tstSegmentView ) )
  {
    pointView = this.pointClosestPoint( srcSegmentView, tstOrigin );
  }
  else
  {
    let srcLine = this.tools.vectorAdapter.from( this.tools.long.make( srcDim*2 ) );
    let tstLine = this.tools.vectorAdapter.from( this.tools.long.make( srcDim*2 ) );

    for( var i = 0 ; i < srcDim ; i++ )
    {
      srcLine.eSet( i, srcOrigin.eGet( i ) );
      srcLine.eSet( srcDim + i, srcDir.eGet( i ) );
      tstLine.eSet( i, tstOrigin.eGet( i ) );
      tstLine.eSet( srcDim + i, tstDir.eGet( i ) );
    }

    let factors = this.tools.linePointDir.lineIntersectionFactors( srcLine, tstLine );

    if( factors === 0 )
    {
      let srcMod = this.tools.vectorAdapter.dot( srcDir, srcDir );
      let tstMod = this.tools.vectorAdapter.dot( tstDir, tstDir );
      let mod = this.tools.vectorAdapter.dot( srcDir, tstDir );
      let dOrigin = this.tools.vectorAdapter.from( this.tools.avector.sub( tstOrigin.slice(), srcOrigin ) );
      let factor = ( - mod*this.tools.vectorAdapter.dot( tstDir, dOrigin ) + tstMod*this.tools.vectorAdapter.dot( srcDir, dOrigin ))/( tstMod*srcMod - mod*mod );

      if( factor >= 0 && factor <= 1 )
      {
        pointView = this.segmentAt( srcSegmentView, factor );
      }
      else if( factor > 1 )
      {
        pointView = srcEnd;
      }
      else if ( factor < 0 )
      {
        pointView = srcOrigin;
      }
    }
    else if( factors.eGet( 1 ) < 0 )
    {
      pointView = this.pointClosestPoint( srcSegmentView, tstOrigin );
    }
    else if( factors.eGet( 1 ) > 1 )
    {
      pointView = this.pointClosestPoint( srcSegmentView, tstEnd );
    }
    else if( factors.eGet( 0 ) < 0 )
    {
      //pointView = this.pointClosestPoint( srcSegmentView, tstOrigin );
      pointView = srcOrigin;
    }
    else if( factors.eGet( 0 ) > 1 )
    {
      pointView = srcEnd;
    }
  }

  pointView = this.tools.vectorAdapter.from( pointView );
  for( let i = 0; i < pointView.length; i++ )
  {
    dstPointView.eSet( i, pointView.eGet( i ) );
  }

  return dstPoint;
}

// function segmentClosestPoint( srcSegment, tstSegment, dstPoint )
// {
//   _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
//
//   if( arguments.length === 2 )
//   dstPoint = this.tools.long.make( tstSegment.length / 2 );
//
//   if( dstPoint === null || dstPoint === undefined )
//   throw _.err( 'Not a valid destination point' );
//
//   if( srcSegment === null )
//   srcSegment = this.make( tstSegment.length / 2 );
//
//   let srcSegmentView = this.adapterFrom( srcSegment );
//   let srcOrigin = this.originGet( srcSegmentView );
//   let srcEnd = this.endPointGet( srcSegmentView );
//   let srcDir = this.directionGet( srcSegmentView );
//   let srcDim  = this.dimGet( srcSegmentView );
//
//   let tstSegmentView = this.adapterFrom( tstSegment );
//   let tstOrigin = this.originGet( tstSegmentView );
//   let tstEnd = this.endPointGet( tstSegmentView );
//   let tstDir = this.directionGet( tstSegmentView );
//   let tstDim = this.dimGet( tstSegmentView );
//
//   let dstPointView = this.tools.vectorAdapter.from( dstPoint );
//   _.assert( srcDim === tstDim );
//
//   let pointView;
//
//
//   if( this.segmentIntersects( srcSegmentView, tstSegmentView ) )
//   {
//     pointView = this.segmentIntersectionPoint( srcSegmentView, tstSegmentView );
//   }
//   else
//   {
//     // Parallel segments
//     if( this.segmentParallel( srcSegmentView, tstSegmentView ) )
//     {
//       pointView = this.pointClosestPoint( srcSegmentView, tstOrigin );
//     }
//     else
//     {
//       let srcLine = this.tools.vectorAdapter.from( this.tools.long.make( srcDim*2 ) );
//       let tstLine = this.tools.vectorAdapter.from( this.tools.long.make( srcDim*2 ) );
//
//       for( var i = 0 ; i < srcDim ; i++ )
//       {
//         srcLine.eSet( i, srcOrigin.eGet( i ) );
//         srcLine.eSet( srcDim + i, srcDir.eGet( i ) );
//         tstLine.eSet( i, tstOrigin.eGet( i ) );
//         tstLine.eSet( srcDim + i, tstDir.eGet( i ) );
//       }
//
//       let factors = _.linePointDir.lineIntersectionFactors( srcLine, tstLine );
//
//       if( factors === 0 )
//       {
//         let srcMod = this.tools.vectorAdapter.dot( srcDir, srcDir );
//         let tstMod = this.tools.vectorAdapter.dot( tstDir, tstDir );
//         let mod = this.tools.vectorAdapter.dot( srcDir, tstDir );
//         let dOrigin = this.tools.vectorAdapter.from( this.tools.avector.sub( tstOrigin.slice(), srcOrigin ) );
//         let factor = ( - mod*this.tools.vectorAdapter.dot( tstDir, dOrigin ) + tstMod*this.tools.vectorAdapter.dot( srcDir, dOrigin ))/( tstMod*srcMod - mod*mod );
//
//         if( factor >= 0 && factor <= 1 )
//         {
//           pointView = this.segmentAt( srcSegmentView, factor );
//         }
//         else if( factor > 1 )
//         {
//           pointView = srcEnd;
//         }
//         else if ( factor < 0 )
//         {
//           pointView = srcOrigin;
//         }
//       }
//       else if( factors.eGet( 1 ) < 0 )
//       {
//         pointView = this.pointClosestPoint( srcSegmentView, tstOrigin );
//       }
//       else if( factors.eGet( 1 ) > 1 )
//       {
//         pointView = this.pointClosestPoint( srcSegmentView, tstEnd );
//       }
//       else if( factors.eGet( 0 ) < 0 )
//       {
//         //pointView = this.pointClosestPoint( srcSegmentView, tstOrigin );
//         pointView = srcOrigin;
//       }
//       else if( factors.eGet( 0 ) > 1 )
//       {
//         pointView = srcEnd;
//       }
//     }
//   }
//
//   pointView = this.tools.vectorAdapter.from( pointView );
//   for( let i = 0; i < pointView.length; i++ )
//   {
//     dstPointView.eSet( i, pointView.eGet( i ) );
//   }
//
//   return dstPoint;
// }

//

function relativeSegmentOrigin( segmentCentered, pointCentered )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let srcSegmentCenteredView = this.adapterFrom( segmentCentered );
  let srcPointCenteredView = this.tools.vectorAdapter.from( pointCentered.slice() );

  return this.tools.vectorAdapter.dot( srcPointCenteredView, srcSegmentCenteredView ) / this.tools.avector.dot( srcSegmentCenteredView, srcSegmentCenteredView );
  // return _dot( pointCentered, segmentCentered ) / _dot( segmentCentered, segmentCentered );
}

//

function relativeSegment( segmentPoints, point )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let segmentCentered = this.tools.avector.sub( null, segmentPoints[ 1 ], segmentPoints[ 0 ] );
  let pointCentered = this.tools.avector.sub( null, point, segmentPoints[ 0 ] );

  return this.relativeSegmentOrigin( segmentCentered, pointCentered )

  // let segmentCentered = avector.sub( segmentPoints[ 1 ].slice(), segmentPoints[ 0 ] );
  // let pointCentered = avector.sub( point.slice(), segmentPoints[ 0 ] );

  // return relativeSegmentOrigin( segmentCentered, pointCentered );
}

//

/**
  * Check if a segment and a sphere intersect. Returns true if they intersect and false if not.
  * The sphere and the segment remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcSphere - Source sphere.
  *
  * @example
  * // returns true;
  * _.sphereIntersects( [ 0, 0, 0, 2, 2, 2 ], [ 0, 0, 0, 1 ]);
  *
  * @example
  * // returns false;
  * _.sphereIntersects( [ 0, 0, 0, 0, -2, 0 ], [ 3, 3, 3, 1 ]);
  *
  * @returns { Boolean } Returns true if the segment and the sphere intersect.
  * @function sphereIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the segment and sphere don´t have the same dimension).
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function sphereIntersects( srcSegment, srcSphere )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.sphere.is( srcSphere ) );

  if( srcSegment === null )
  srcSegment = this.make( srcSphere.length - 1 );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let origin = this.originGet( srcSegmentView );
  let direction = this.directionGet( srcSegmentView );
  let dimSegment  = this.dimGet( srcSegmentView )

  let sphereView = this.tools.sphere.adapterFrom( srcSphere );
  let center = this.tools.sphere.centerGet( sphereView );
  let radius = this.tools.sphere.radiusGet( sphereView );
  let dimSphere = this.tools.sphere.dimGet( sphereView );

  _.assert( dimSegment === dimSphere );

  if( this.tools.sphere.pointContains( sphereView, origin ) )
  return true;

  let distance = this.pointDistance( srcSegmentView, center );

  // if( distance <= radius)
  if( this.tools.avector.isLessEqualAprox( distance, radius ) )
  return true;

  return false;

}

//

/**
  * Get the distance between a segment and a sphere. Returns the calculated distance.
  * The sphere and the segment remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcSphere - Source sphere.
  *
  * @example
  * // returns 0;
  * _.sphereDistance( [ 0, 0, 0, 2, 2, 2 ], [ 0, 0, 0, 1 ]);
  *
  * @example
  * // returns Math.sqrt( 27 ) -1;
  * _.sphereDistance( [ 0, 0, 0, 0, -2, 0 ], [ 3, 3, 3, 1 ]);
  *
  * @returns { Boolean } Returns the distance between the segment and the sphere.
  * @function sphereDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the segment and sphere don´t have the same dimension).
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function sphereDistance( srcSegment, srcSphere )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.sphere.is( srcSphere ) );

  if( srcSegment === null )
  srcSegment = this.make( srcSphere.length - 1 );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let origin = this.originGet( srcSegmentView );
  let direction = this.directionGet( srcSegmentView );
  let dimSegment  = this.dimGet( srcSegmentView )

  let sphereView = this.tools.sphere.adapterFrom( srcSphere );
  let center = this.tools.sphere.centerGet( sphereView );
  let radius = this.tools.sphere.radiusGet( sphereView );
  let dimSphere = this.tools.sphere.dimGet( sphereView );

  _.assert( dimSegment === dimSphere );

  if( this.sphereIntersects( srcSegmentView, sphereView ) )
  return 0;

  return this.pointDistance( srcSegmentView, center ) - radius;
}

//

/**
  * Get the closest point in a segment to a sphere. Returns the calculated point.
  * The sphere and the segment remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcSphere - Source sphere.
  * @param { Array } dstPoint - Destination point.
  *
  * @example
  * // returns 0;
  * _.sphereClosestPoint( [ 0, 0, 0, 2, 2, 2 ], [ 0, 0, 0, 1 ]);
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.sphereClosestPoint( [ 0, 0, 0, 0, -2, 0 ], [ 3, 3, 3, 1 ]);
  *
  * @returns { Boolean } Returns the closest point in a segment to a sphere.
  * @function sphereClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the segment and sphere don´t have the same dimension).
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function sphereClosestPoint( srcSegment, srcSphere, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  _.assert( _.sphere.is( srcSphere ) );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( srcSphere.length - 1 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcSegment === null )
  srcSegment = this.make( srcSphere.length - 1 );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let origin = this.originGet( srcSegmentView );
  let direction = this.directionGet( srcSegmentView );
  let dimSegment  = this.dimGet( srcSegmentView )

  let sphereView = this.tools.sphere.adapterFrom( srcSphere );
  let center = this.tools.sphere.centerGet( sphereView );
  let radius = this.tools.sphere.radiusGet( sphereView );
  let dimSphere = this.tools.sphere.dimGet( sphereView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimSegment === dimSphere );

  if( this.sphereIntersects( srcSegmentView, sphereView ) )
  return 0;

  let pointVector = this.tools.vectorAdapter.from( this.pointClosestPoint( srcSegmentView, center ) );

  for( let i = 0; i < pointVector.length; i++ )
  {
    dstPointView.eSet( i, pointVector.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Get the bounding sphere of a segment. Returns destination sphere.
  * Segment and sphere are stored in Array data structure. Source segment stays untouched.
  *
  * @param { Array } dstSphere - destination sphere.
  * @param { Array } srcSegment - source segment for the bounding sphere.
  *
  * @example
  * // returns [ 1, 1, 1, Math.sqrt( 3 ) ]
  * _.boundingSphereGet( null, [ 0, 0, 0, 2, 2, 2 ] );
  *
  * @returns { Array } Returns the array of the bounding sphere.
  * @function boundingSphereGet
  * @throws { Error } An Error if ( dim ) is different than dimGet(segment) (the segment and the sphere don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstSphere ) is not sphere
  * @throws { Error } An Error if ( srcSegment ) is not segment
  * @namespace wTools.segment
  * @module Tools/math/Concepts
  */
function boundingSphereGet( dstSphere, srcSegment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let srcSegmentView = this.adapterFrom( srcSegment );
  let origin = this.originGet( srcSegmentView );
  let endPoint = this.endPointGet( srcSegmentView );
  let dimSegment  = this.dimGet( srcSegmentView )

  if( dstSphere === null || dstSphere === undefined )
  dstSphere = this.tools.sphere.makeZero( dimSegment );

  _.assert( _.sphere.is( dstSphere ) );
  let dstSphereView = this.tools.sphere.adapterFrom( dstSphere );
  let center = this.tools.sphere.centerGet( dstSphereView );
  let radius = this.tools.sphere.radiusGet( dstSphereView );
  let dimS = this.tools.sphere.dimGet( dstSphereView );

  _.assert( dimSegment === dimS );

  // Center of the sphere
  for( let c = 0; c < center.length; c++ )
  {
    center.eSet( c, ( endPoint.eGet( c ) + origin.eGet( c ) ) / 2 );
  }

  // Radius of the sphere
  this.tools.sphere.radiusSet( dstSphereView, this.tools.vectorAdapter.distance( center, endPoint ) );

  return dstSphere;
}


// --
// extension
// --

let Extension = /* qqq : normalize order */
{

  make,
  makeZero,
  makeSingular,

  zero,
  nil,

  from,
  adapterFrom,

  is,
  dimGet,
  originGet,
  endPointGet,
  directionGet,
  centerGet,

  segmentAt,
  getFactor,

  segmentParallel,

  project,
  getProjectionFactors,

  segmentIntersectionFactors,
  segmentIntersectionPoints,
  segmentIntersectionPoint,
  segmentIntersectionPointAccurate,

  fromPair,
  pointContains,
  pointDistanceSqr,
  pointDistance,
  pointClosestPoint,

  boxIntersects,
  boxDistance,
  boxClosestPoint,
  boundingBoxGet,

  capsuleIntersects,
  capsuleDistance,
  capsuleClosestPoint,

  convexPolygonIntersects,
  convexPolygonDistance,
  convexPolygonClosestPoint,

  frustumIntersects,
  frustumDistance,
  frustumClosestPoint,

  lineIntersects,
  lineIntersectionPoint,
  lineIntersectionFactors,
  lineDistance,
  lineClosestPoint,

  planeIntersects,
  planeIntersectionPoint,
  planeDistance,
  planeClosestPoint,

  rayIntersects,
  rayIntersectionPoint,
  rayIntersectionFactors,
  rayDistance,
  rayClosestPoint,

  segmentIntersects,
  segmentDistance,
  segmentClosestPoint,

  relativeSegmentOrigin,
  relativeSegment,

  sphereIntersects,
  sphereDistance,
  sphereClosestPoint,
  boundingSphereGet,

  // ref

  tools : _,

}

/* _.props.extend */Object.assign( _.segment, Extension );

})();
