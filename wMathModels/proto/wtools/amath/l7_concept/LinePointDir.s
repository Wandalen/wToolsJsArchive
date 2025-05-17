(function _LinePointDir_s_(){

'use strict';

const _ = _global_.wTools;
_.linePointDir = _.linePointDir || Object.create( _.avector );

/**
 * @description
 * For the following functions, ( infinite ) lines must have the shape [ orX, orY, orZ, dirX, dirY, dirZ ],
 * where the dimension equals the long's length divided by two.
 *
 * Moreover, orX, orY and orZ, are the coordinates of the origin of the line,
 * and dirX, dirY, dirZ the coordinates of the direction of the line.
 *
 * Finally lines extend also in the direction ( - dirX, - dirY, - dirZ ).
 * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
 */

/*

For the following functions, ( infinite ) lines must have the shape [ orX, orY, orZ, dirX, dirY, dirZ ],
where the dimension equals the long's length divided by two.

Moreover, orX, orY and orZ, are the coordinates of the origin of the line,
and dirX, dirY, dirZ the coordinates of the direction of the line.

Finally lines extend also in the direction ( - dirX, - dirY, - dirZ ).

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

function zero( line )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( this.is( line ) )
  {
    let lineView = this.adapterFrom( line );
    lineView.assign( 0 );
    return line;
  }

  return this.makeZero( line );
}

//

function nil( line )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( this.is( line ) )
  {
    let lineView = this.adapterFrom( line );
    let min = this.originGet( lineView );
    let max = this.directionGet( lineView );

    this.tools.vectorAdapter.assign( min, +Infinity );
    this.tools.vectorAdapter.assign( max, -Infinity );

    return line;
  }

  return this.makeSingular( line );
}

//

function from( line )
{

  _.assert( this.is( line ) || line === null );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( line === null )
  return this.make();

  return line;
}

//

function adapterFrom( line )
{
  if( !this.is( line ) )
  debugger;
  _.assert( this.is( line ) );
  _.assert( arguments.length === 1, 'Expects single argument' );
  return this.tools.vectorAdapter.from( line );
}

//

/**
  * Get a line out of two points. Returns a vector with the coordinates of the line.
  * The pair of points stays untouched.
  *
  * @param { Array } pair - The source points.
  *
  * @example
  * // returns   this.tools.vectorAdapter.from( [ 1, 2, 1, 2 ] )
  * _.fromPoints( [ 1, 2 ], [ 3, 4 ] );
  *
  * @returns { Vector } Returns the line containing the two points.
  * @function fromPoints
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( pair ) is not array.
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */

function fromPoints( point1, point2 )
{
  _.assert( arguments.length === 2, 'Expects single argument' );
  _.assert( point1.length === point2.length, 'Expects two points' );

  let result = this.tools.vectorAdapter.make( point1.length * 2 );
  let pair0 = this.tools.vectorAdapter.from( point1 );
  let pair1 = this.tools.vectorAdapter.from( point2 );

  for( let i = 0; i < pair0.length ; i++ )
  {
    result.eSet( i, pair0.eGet( i ) );
    result.eSet( pair0.length + i, this.tools.avector.sub( null, pair1, pair0 )[ i ] );
  }

  return result;
}

fromPoints.shaderChunk =
`
  void line_fromPoints( out vec2 dstLine[ 2 ], vec2 pair[ 2 ] )
  {
    dstLine[ 0 ] = pair[ 0 ];
    dstLine[ 1 ] = pair[ 1 ] - pair[ 0 ];
  }

  void line_fromPoints( out vec3 dstLine[ 2 ], vec3 pair[ 2 ] )
  {
    dstLine[ 0 ] = pair[ 0 ];
    dstLine[ 1 ] = pair[ 1 ] - pair[ 0 ];
  }
`

//

function fromPoints2( points )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  debugger
  _.assert( this.tools.linePoints.is( points ) );

  let point1 = this.tools.linePoints.firstPointGet( points );
  let point2 = this.tools.linePoints.secondPointGet( points );

  return this.fromPoints( point1, point2 );
}

//

/**
  * Check if input is a line. Returns true if it is a line and false if not.
  *
  * @param { Vector } line - Source line.
  *
  * @example
  * // returns true;
  * _.linePointDir.is( [ 0, 0, 1, 1 ] );
  *
  * @returns { Boolean } Returns true if the input is line.
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */

function is( line )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return ( _.longIs( line ) || _.vectorAdapterIs( line ) ) && ( line.length >= 0 ) && ( line.length % 2 === 0 );
}

//

/**
  * Get line dimension. Returns the dimension of the line. Line stays untouched.
  *
  * @param { Vector } line - The source line.
  *
  * @example
  * // returns 2
  * _.dimGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns 1
  * _.dimGet( [ 0, 1 ] );
  *
  * @returns { Number } Returns the dimension of the line.
  * @function dimGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( line ) is not line.
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function dimGet( line )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( this.is( line ) );
  return line.length / 2;
}

//

/**
  * Get the origin of a line. Returns a vector with the coordinates of the origin of the line.
  * Line stays untouched.
  *
  * @param { Vector } line - The source line.
  *
  * @example
  * // returns   0, 0
  * _.originGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns  1
  * _.originGet( [ 1, 2 ] );
  *
  * @returns { Vector } Returns the coordinates of the origin of the line.
  * @function originGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( line ) is not line.
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */

function originGet( line )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  let lineView = this.adapterFrom( line );
  return lineView.review([ 0, line.length / 2 - 1 ]);
}

//

/**
  * Get the direction of a line. Returns a vector with the coordinates of the direction of the line.
  * Line stays untouched.
  *
  * @param { Vector } line - The source line.
  *
  * @example
  * // returns   2, 2
  * _.directionGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns  2
  * _.directionGet( [ 1, 2 ] );
  *
  * @returns { Vector } Returns the direction of the line.
  * @function directionGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( line ) is not line.
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */

function directionGet( line )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  let lineView = this.adapterFrom( line );
  return lineView.review([ line.length / 2, line.length - 1 ]);
}

//

/**
  * Get a point in a line. Returns a vector with the coordinates of the point of the line.
  * Line and factor stay untouched.
  *
  * @param { Vector } srcLine - The source line.
  * @param { Vector } factor - The source factor.
  *
  * @example
  * // returns   4, 4
  * _.lineAt( [ 0, 0, 2, 2 ], 2 );
  *
  * @example
  * // returns  1
  * _.lineAt( [ 1, 2 ], 0 );
  *
  * @returns { Vector } Returns a point in the line at a given factor.
  * @function lineAt
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( factor ) is not number.
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function lineAt( srcLine, factor )
{

  _.assert( arguments.length === 2, 'Expects single argument' );
  _.assert( this.is( srcLine ) );
  _.assert( _.numberIs( factor ) );

  let lineView = this.adapterFrom( srcLine )
  let origin = this.originGet( lineView );
  let direction = this.directionGet( lineView );

  let result = this.tools.avector.mul( null, direction, factor );
  result = this.tools.avector.add( result, origin );

  return result;
}

lineAt.shaderChunk =
`
  vec2 lineAt( vec2 srcLine[ 2 ], float factor )
  {

    vec2 result = srcLine[ 1 ]*factor;
    result += srcLine[ 0 ];

    return result;
  }
`

//

/**
* Get the factor of a point inside a line. Returs the calculated factor. Point and line stay untouched.
*
* @param { Array } srcLine - The source line.
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
* @returns { Number } Returns the factor if the point is inside the line, and false if the point is outside it.
* @function getFactor
* @throws { Error } An Error if ( dim ) is different than point.length (line and point have not the same dimension).
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( srcLine ) is not line.
* @throws { Error } An Error if ( srcPoint ) is not point.
* @namespace wTools.linePointDir
  * @module Tools/math/Concepts
*/

function getFactor( srcLine, srcPoint )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcLine === null )
  srcLine = this.make( srcPoint.length );

  let srcLineView = this.adapterFrom( srcLine );
  let origin = this.originGet( srcLineView );
  let direction = this.directionGet( srcLineView );
  let dimension  = this.dimGet( srcLineView )
  let srcPointView = this.tools.vectorAdapter.from( srcPoint.slice() );
  let accuracy = this.tools.accuracy*10; /* xxx */

  _.assert( dimension === srcPoint.length, 'The line and the point must have the same dimension' );
  let dOrigin = this.tools.vectorAdapter.from( this.tools.avector.sub( srcPointView, origin ) );

  let factor;
  if( direction.eGet( 0 ) === 0 )
  {
    // if( Math.abs( dOrigin.eGet( 0 ) ) > accuracy )
    if( this.tools.avector.isGreaterAprox( Math.abs( dOrigin.eGet( 0 ) ), accuracy ) )
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

  for( var i = 1; i < dOrigin.length; i++ )
  {
    let newFactor;
    if( direction.eGet( i ) === 0 )
    {
      // if( Math.abs( dOrigin.eGet( i ) ) > accuracy )
      if( this.tools.avector.isGreaterAprox( Math.abs( dOrigin.eGet( i ) ), accuracy ) )
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
      // if( Math.abs( newFactor - factor ) > accuracy && newFactor !== 0 && factor !== 0 )
      if( this.tools.avector.isGreaterAprox( Math.abs( newFactor - factor ), accuracy ) && newFactor !== 0 && factor !== 0 )
      {
        return false;
      }
      factor = newFactor;
    }
  }

  return factor;
}

//

/**
  * Check if two lines are parallel. Returns true if they are parallel and false if not.
  * Lines and accuracySqr stay untouched. Only for 3d.
  *
  * @param { Vector } src1Line - The first source line.
  * @param { Vector } src2Line - The second source line.
  * @param { Vector } accuracySqr - The accuracy.
  *
  * @example
  * // returns   true
  * _.lineParallel( [ 0, 0, 0, 2, 2, 2 ], [ 1, 2, 1, 4, 4, 4 ] );
  *
  * @example
  * // returns  false
  * _.lineParallel( [ 1, 2, 1, 1, 1, 2 ], [ 1, 2, 1, 1, 3, 3 ] );
  *
  * @returns { Boolean } Returns true if the lines are parallel.
  * @function lineParallel
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( src1Line ) is not line.
  * @throws { Error } An Error if ( src2Line ) is not line.
  * @throws { Error } An Error if ( accuracySqr ) is not number.
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function lineParallel3d( src1Line, src2Line, accuracySqr )
{
  // _.assert( src1Line.length === 3 );
  // _.assert( src2Line.length === 3 );
  // _.assert( arguments.length === 2 || arguments.length === 3 );

  // if( accuracySqr === undefined )
  // accuracySqr = this.accuracySqr;

  // return _magSqr( this.tools.avector.cross( src1Line[ 1 ], src2Line[ 1 ] ) ) <= this.accuracySqr;

  _.assert( this.is( src1Line ) );
  _.assert( this.is( src2Line ) );
  _.assert( arguments.length === 2 || arguments.length === 3 );

  if( arguments.length === 2 || accuracySqr === undefined || accuracySqr === null )
  accuracySqr = this.tools.accuracySqr;;

  let direction1 = this.directionGet( src1Line );
  let direction2 = this.directionGet( src2Line );
  debugger;
  // return this.tools.avector.magSqr( this.tools.avector.cross( null, direction1, direction2 )) <= accuracySqr;
  let result = this.tools.avector.magSqr( this.tools.avector.cross( null, direction1, direction2 ));
  return this.tools.avector.isLessEqualAprox( result, accuracySqr );
}

//

function lineParallel( src1Line, src2Line, accuracySqr )
{
  // _.assert( src1Line.length === 3 );
  // _.assert( src2Line.length === 3 );
  // _.assert( arguments.length === 2 || arguments.length === 3 );

  // if( accuracySqr === undefined )
  // accuracySqr = this.accuracySqr;

  // return _magSqr( this.tools.avector.cross( src1Line[ 1 ], src2Line[ 1 ] ) ) <= this.accuracySqr;

  _.assert( this.is( src1Line ) );
  _.assert( this.is( src2Line ) );
  _.assert( arguments.length === 2 || arguments.length === 3 );
  _.assert( src1Line.length === src2Line.length );

  if( arguments.length === 2 || accuracySqr === undefined || accuracySqr === null )
  accuracySqr = this.tools.accuracySqr;

  let direction1 = this.directionGet( src1Line ).clone().normalize();
  let direction2 = this.directionGet( src2Line ).clone().normalize();
  let proportion = undefined;

  let zeros1 = 0;                               // Check if Line1 is a point
  for( let i = 0; i < direction1.length ; i++  )
  {
    if( direction1.eGet( i ) === 0 )
    {
      zeros1 = zeros1 + 1;
    }
    if( zeros1 === direction1.length )
    return true;
  }

  let zeros2 = 0;                               // Check if Line2 is a point
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
      // if( Math.abs( direction1.eGet( i ) - direction2.eGet( i ) ) > accuracySqr )
      if( this.tools.avector.isGreaterAprox( Math.abs( direction1.eGet( i ) - direction2.eGet( i ) ), accuracySqr ) )
      {
        return false;
      }
    }
    else
    {
      let newProportion = direction1.eGet( i ) / direction2.eGet( i );

      if( proportion !== undefined )
      {
        // if( Math.abs( proportion - newProportion ) > accuracySqr )
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
  * Returns the factors for the intersection of two lines. Returns a vector with the intersection factors, 0 if there is no intersection.
  * Lines stay untouched.
  *
  * @param { Vector } src1Line - The first source line.
  * @param { Vector } src2Line - The second source line.
  *
  * @example
  * // returns   0
  * _.lineIntersectionFactors( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  this.tools.vectorAdapter.from( [ 2, 1 ] ) // qqq : check
  * _.lineIntersectionFactors( [ -2, 0, 1, 0 ], [ 0, -2, 0, 2 ] );
  *
  * @returns { Array } Returns the factors for the two lines intersection.
  * @function lineIntersectionFactors
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Line ) is not line.
  * @throws { Error } An Error if ( src2Line ) is not line.
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */

function lineIntersectionFactors( srcLine1, srcLine2 )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( srcLine1.length === srcLine2.length, 'The two lines must have the same dimension' );

  let srcLine1View = this.adapterFrom( srcLine1.slice() );
  let srcLine2View = this.adapterFrom( srcLine2.slice() );

  let origin1 = this.originGet( srcLine1View );
  let origin2 = this.originGet( srcLine2View );

  let dOrigin = this.tools.vectorAdapter.from( this.tools.avector.sub( origin2.clone(), origin1 ) );

  let direction1 = this.directionGet( srcLine1View );
  let direction2 = this.directionGet( srcLine2View );
  let directions = _.Matrix.Make( [ srcLine1.length / 2, 2 ] );
  directions.colGet( 0 ).copy( direction1 );
  directions.colGet( 1 ).copy( direction2.clone().mul( - 1 ) );

  // Same origin
  let identOrigin = 0;
  for( let i = 0; i < origin1.length; i++ )
  {
    if( origin1.eGet( i ) === origin2.eGet( i ) )
    identOrigin = identOrigin + 1;
  }

  if( identOrigin === origin1.length )
  return this.tools.vectorAdapter.from( [ 0, 0 ] );

  // Parallel lines
  if( this.lineParallel( srcLine1, srcLine2 ) === true )
  {
    let factor1 = this.getFactor( srcLine1View, origin2 );
    let factor2 = this.getFactor( srcLine2View, origin1 );

    if( factor1 )
    {
      return this.tools.vectorAdapter.from( [ factor1, 0 ] );
    }
    else if( factor2 )
    {
      return this.tools.vectorAdapter.from( [ 0, factor2 ] );
    }
    else
    {
      return 0;
    }
  }
  /*
  let result = _.vector.from( [ 0, 0 ] );
  debugger;
  let j = 0;
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
    logger.log(' x: ', x.base)
    if( j === 0 )
    {
      result = _.vector.from( x.base )
    }
    else
    {
      let x1 = x.base.colGet( 0 ).eGet( 0 );
      let x2 = x.base.colGet( 0 ).eGet( 1 );
      let samex1 = Math.abs( x1 - result.eGet( 0 ) ) < 1E-6 || Math.abs( x1 - result.eGet( 1 ) ) < 1E-6 ;
      let samex2 = Math.abs( x2 - result.eGet( 0 ) ) < 1E-6 || Math.abs( x2 - result.eGet( 1 ) ) < 1E-6 ;
      if( x1 !== 0 )
      {
        if( samex1 )
        {
          result.eSet( 0, _.vector.from( x.base ).eGet( 0 ) );
        }
        else if ( ( result.eGet( 0 ) === 0 || result.eGet( 1 ) === 0 ) && samex2 )
        {
          result.eSet( 0, _.vector.from( x.base ).eGet( 0 ) );
        }
        else
        {
          return 0;
        }
      }
      if( x2 !== 0 )
      {
        if( samex2 )
        {
          result.eSet( 1, _.vector.from( x.base ).eGet( 1 ) );
        }
        else if ( ( result.eGet( 0 ) === 0 || result.eGet( 1 ) === 0 ) && samex1 )
        {
          result.eSet( 1, _.vector.from( x.base ).eGet( 1 ) );
        }
        else
        {
          return 0;
        }
      }
    }
    j = j + 1;
    var oldDeterminant = m.determinant();
  }
  if( result.eGet( 0 ) === 0 && result.eGet( 1 ) === 0 )
  {
    return 0;
  }
  logger.log('result', result)
  // Check result
  let point1 = _.vector.from( this.tools.long.make( origin1.length ) )
  let point2 = _.vector.from( this.tools.long.make( origin1.length ) )
  for( let i = 0; i < origin1.length; i++ )
  {
    point1.eSet( i, origin1.eGet( i ) + result.eGet( 0 )*direction1.eGet( i ) )
    point2.eSet( i, origin2.eGet( i ) + result.eGet( 1 )*direction2.eGet( i ) )
    if( Math.abs( point1.eGet( i ) - point2.eGet( i ) ) > this.tools.accuracy * 10 )
    {
      return 0
    }
  }
  return result;
  */

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

    let point1 = this.tools.vectorAdapter.from( this.tools.long.make( dOrigin.length ) );
    let point2 = this.tools.vectorAdapter.from( this.tools.long.make( dOrigin.length ) );
    for( var j = 0; j < dOrigin.length; j++ )
    {
      point1.eSet( j, origin1.eGet( j ) + direction1.eGet( j )*result.eGet( 0 ) );
      point2.eSet( j, origin2.eGet( j ) + direction2.eGet( j )*result.eGet( 1 ) );
    }

    let contained = 0;

    debugger;

    if( this.pointContains( srcLine1View, point2 ) )
    {
      result.eSet( 0, this.getFactor( srcLine1View, point2 ) );
      contained = 1;
    }
    else if( this.pointContains( srcLine2View, point1 ) )
    {
      result.eSet( 1, this.getFactor( srcLine2View, point1 ) );
      contained = 1;
    }

    if( contained === 1 )
    return result;
  }

  return 0;
}

//

/**
  * Returns the points of the intersection of two lines. Returns an array with the intersection points, 0 if there is no intersection.
  * Lines stay untouched.
  *
  * @param { Vector } src1Line - The first source line.
  * @param { Vector } src2Line - The second source line.
  *
  * @example
  * // returns   0
  * _.lineIntersectionPoints( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  [ [ 0, 0 ], [ 0, 0 ] ]
  * _.lineIntersectionPoints( [ -3, 0, 1, 0 ], [ 0, -2, 0, 1 ] );
  *
  * @returns { Array } Returns the points of intersection of the two lines.
  * @function lineIntersectionPoints
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Line ) is not line.
  * @throws { Error } An Error if ( src2Line ) is not line.
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function lineIntersectionPoints( srcLine1, srcLine2 )
{
  let factors = this.lineIntersectionFactors( srcLine1, srcLine2 );
  if( factors === 0 )
  return 0;

  let factorsView = this.tools.vectorAdapter.from( factors );
  let result = [ this.lineAt( srcLine1, factorsView.eGet( 0 ) ), this.lineAt( srcLine2, factorsView.eGet( 1 ) ) ];
  return result;
}

lineIntersectionPoints.shaderChunk =
`
  void lineIntersectionPoints( out vec2 result[ 2 ], vec2 srcLine1[ 2 ], vec2 srcLine2[ 2 ] )
  {

    vec2 factors = lineIntersectionFactors( srcLine1, srcLine2 );
    result[ 0 ] = lineAt( srcLine1, factors[ 0 ] );
    result[ 1 ] = lineAt( srcLine2, factors[ 1 ] );

  }
`

//

/**
  * Returns the point of the intersection of two lines. Returns an array with the intersection point, 0 if there is no intersection.
  * Lines stay untouched.
  *
  * @param { Vector } src1Line - The first source line.
  * @param { Vector } src2Line - The second source line.
  *
  * @example
  * // returns   0
  * _.lineIntersectionPoint( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  [ [ 0, 0 ] ]
  * _.lineIntersectionPoint( [ -3, 0, 1, 0 ], [ 0, -2, 0, 1 ] );
  *
  * @returns { Array } Returns the point of intersection of the two lines.
  * @function lineIntersectionPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Line ) is not line.
  * @throws { Error } An Error if ( src2Line ) is not line.
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function lineIntersectionPoint( srcLine1, srcLine2 )
{

  let factors = this.lineIntersectionFactors( srcLine1, srcLine2 );

  if( factors === 0 )
  return 0;

  return this.lineAt( srcLine1, factors.eGet( 0 ) );

}

lineIntersectionPoint.shaderChunk =
`
  vec2 lineIntersectionPoint( vec2 srcLine1[ 2 ], vec2 srcLine2[ 2 ] )
  {

    vec2 factors = lineIntersectionFactors( srcLine1, srcLine2 );
    return lineAt( srcLine1, factors[ 0 ] );

  }
`

//

/**
  * Returns the point of the intersection of two lines. Returns an array with the intersection point, 0 if there is no intersection.
  * Lines stay untouched.
  *
  * @param { Vector } src1Line - The first source line.
  * @param { Vector } src2Line - The second source line.
  *
  * @example
  * // returns   0
  * _.lineIntersectionPointAccurate( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  [ [ 0, 0 ] ]
  * _.lineIntersectionPointAccurate( [ -3, 0, 1, 0 ], [ 0, -2, 0, 1 ] );
  *
  * @returns { Array } Returns the point of intersection of the two lines.
  * @function lineIntersectionPointAccurate
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Line ) is not line.
  * @throws { Error } An Error if ( src2Line ) is not line.
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function lineIntersectionPointAccurate( srcLine1, srcLine2 )
{

  let closestPoints = this.lineIntersectionPoints( srcLine1, srcLine2 );
  debugger;

  if( closestPoints === 0)
  return 0;

  return this.tools.avector.mul( this.tools.avector.add( null, closestPoints[ 0 ], closestPoints[ 1 ] ), 0.5 );

}

lineIntersectionPointAccurate.shaderChunk =
`
  vec2 lineIntersectionPointAccurate( vec2 srcLine1[ 2 ], vec2 srcLine2[ 2 ] )
  {

    vec2 closestPoints[ 2 ];
    lineIntersectionPoints( closestPoints, srcLine1, srcLine2 );
    return ( closestPoints[ 0 ] + closestPoints[ 1 ] ) * 0.5;

  }
`

//

/**
  * Check if a given point is contained inside a line. Returs true if it is contained, false if not.
  * Point and line stay untouched.
  *
  * @param { Array } srcLine - The source line.
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
  * @returns { Boolean } Returns true if the point is inside the line, and false if the point is outside it.
  * @function pointContains
  * @throws { Error } An Error if ( dim ) is different than point.length (line and point have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcPoint ) is not point.
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function pointContains( srcLine, srcPoint )
{
  /*
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcLine === null )
  srcLine = this.make( srcPoint.length );

  let srcLineView = this.adapterFrom( srcLine );
  let origin = this.originGet( srcLineView );
  let direction = this.directionGet( srcLineView );
  let dimension  = this.dimGet( srcLineView )
  let srcPointView = this.tools.vectorAdapter.from( srcPoint.slice() );

  _.assert( dimension === srcPoint.length, 'The line and the point must have the same dimension' );
  let dOrigin = this.tools.vectorAdapter.from( this.tools.avector.sub( srcPointView, origin ) );
  logger.log( direction )
  let factor;
  if( direction.eGet( 0 ) === 0 )
  {
    if( Math.abs( dOrigin.eGet( 0 ) ) > this.tools.accuracySqr )
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

  logger.log( 'fac', factor)
  for( var i = 1; i < dOrigin.length; i++ )
  {
    logger.log( i, 'Dir', direction.eGet( i ) )
    let newFactor;
    if( direction.eGet( i ) === 0 )
    { logger.log(i,'is zero')
      if( Math.abs( dOrigin.eGet( i ) ) > this.tools.accuracySqr )
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
      logger.log(i,'newF', newFactor, direction.eGet( i - 1 ))
      if( Math.abs( newFactor - factor ) > this.tools.accuracySqr && direction.eGet( i ) !== 0 )
      {
        return false;
      }
      factor = newFactor;
    }
  }

  return true;
  */

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcLine === null )
  srcLine = this.make( srcPoint.length );

  let srcLineView = this.adapterFrom( srcLine );
  let origin = this.originGet( srcLineView );
  let direction = this.directionGet( srcLineView );
  let dimension  = this.dimGet( srcLineView )
  let srcPointView = this.tools.vectorAdapter.from( srcPoint.slice() );

  _.assert( dimension === srcPoint.length, 'The line and the point must have the same dimension' );

  // Line is point
  let isPoint = 0;
  for( let i = 0; i < dimension; i++ )
  {
    if( direction.eGet( i ) === 0 )
    {
      isPoint = isPoint + 1;
    }
  }

  if( isPoint === dimension )
  {
    let isEqual = 0;
    for( let i = 0; i < dimension; i++ )
    {
      if( origin.eGet( i ) === srcPointView.eGet( i )  )
      {
        isEqual = isEqual + 1;
      }
    }

    if( isEqual === dimension )
    {
      return true;
    }
    else
    {
      return false;
    }
  }

  let lineTwo = this.fromPoints( origin, srcPointView );

  if( this.lineParallel( srcLineView, lineTwo, 1e-7 ) === false )
  {
    return false;
  }
  else
  {
    return true;
  }

}

//

/**
  * Get the distance between a point and a line. Returs the calculated distance. Point and line stay untouched.
  *
  * @param { Array } srcLine - The source line.
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
  * @returns { Boolean } Returns the distance between the point and the line.
  * @function pointDistance
  * @throws { Error } An Error if ( dim ) is different than point.length (line and point have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcPoint ) is not point.
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function pointDistance( srcLine, srcPoint )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcLine === null )
  srcLine = this.make( srcPoint.length );

  let srcLineView = this.adapterFrom( srcLine );
  let origin = this.originGet( srcLineView );
  let direction = this.directionGet( srcLineView );
  let dimension  = this.dimGet( srcLineView )
  let srcPointView = this.tools.vectorAdapter.from( srcPoint.slice() );

  _.assert( dimension === srcPoint.length, 'The line and the point must have the same dimension' );

  if( this.pointContains( srcLineView, srcPointView ) )
  {
    return 0;
  }
  else
  {
    let projection = this.pointClosestPoint( srcLineView, srcPointView );

    let dPoints = this.tools.vectorAdapter.from( this.tools.avector.sub( srcPointView, projection ) );
    debugger;
    let mod = this.tools.vectorAdapter.dot( dPoints, dPoints );
    mod = Math.sqrt( mod );

    return mod;
  }
}

//

/**
  * Get the closest point between a point and a line. Returs the calculated point. srcPoint and line stay untouched.
  *
  * @param { Array } srcLine - The source line.
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
  * @returns { Boolean } Returns the closest point in a line to a point.
  * @function pointClosestPoint
  * @throws { Error } An Error if ( dim ) is different than point.length (line and point have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcPoint ) is not point.
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */

function pointClosestPoint( srcLine, srcPoint, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( srcPoint.length );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcLine === null )
  srcLine = this.make( srcPoint.length );

  let srcLineView = this.adapterFrom( srcLine );
  let origin = this.originGet( srcLineView );
  let direction = this.directionGet( srcLineView );
  let dimension  = this.dimGet( srcLineView )
  let srcPointView = this.tools.vectorAdapter.from( srcPoint.slice() );
  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimension === srcPoint.length, 'The line and the point must have the same dimension' );

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
  else if( this.pointContains( srcLineView, srcPointView ) )
  {
    pointVector = this.tools.vectorAdapter.from( srcPointView );
  }
  else
  {
    let dOrigin = this.tools.vectorAdapter.from( this.tools.avector.sub( srcPointView, origin ) );
    let dot = this.tools.vectorAdapter.dot( direction, direction );
    let factor = this.tools.vectorAdapter.dot( direction , dOrigin ) / dot ;
    if( dot === 0 )
    {
      pointVector = this.tools.vectorAdapter.from( origin );
    }
    else
    {
      pointVector = this.tools.vectorAdapter.from( this.lineAt( srcLineView, factor ) );
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
  * Check if a line and a box intersect. Returns true if they intersect and false if not.
  * The box and the line remain unchanged. Only for 1D to 3d
  *
  * @param { Array } srcLine - Source line.
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
  * @returns { Boolean } Returns true if the line and the box intersect.
  * @function boxIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the line and box don´t have the same dimension).
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function boxIntersects( srcLine, srcBox )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcLine === null )
  srcLine = this.make( srcBox.length / 2 );

  let srcLineView = this.adapterFrom( srcLine );
  let origin = this.originGet( srcLineView );
  let direction = this.directionGet( srcLineView );
  let dimLine  = this.dimGet( srcLineView )

  let boxView = this.tools.box.adapterFrom( srcBox );
  let dimBox = this.tools.box.dimGet( boxView );
  let min = this.tools.vectorAdapter.from( this.tools.box.cornerLeftGet( boxView ) );
  let max = this.tools.vectorAdapter.from( this.tools.box.cornerRightGet( boxView ) );

  _.assert( dimLine === dimBox );

  if( this.tools.box.pointContains( boxView, origin ) )
  return true;

  /* box corners */
  let c = this.tools.box.cornersGet( boxView );

  for( let j = 0 ; j < _.Matrix.DimsOf( c )[ 1 ] ; j++ )
  {
    let corner = c.colGet( j );
    let projection = this.pointClosestPoint( srcLineView, corner );

    if( this.tools.box.pointContains( boxView, projection ) )
    return true;
  }

  return false;

}

//

/**
  * Get the distance between a line and a box. Returns the calculated distance.
  * The box and the line remain unchanged. Only for 1D to 3d
  *
  * @param { Array } srcLine - Source line.
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
  * @returns { Number } Returns the distance between the line and the box.
  * @function boxDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the line and box don´t have the same dimension).
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function boxDistance( srcLine, srcBox )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcLine === null )
  srcLine = this.make( srcBox.length / 2 );

  let srcLineView = this.adapterFrom( srcLine );
  let origin = this.originGet( srcLineView );
  let direction = this.directionGet( srcLineView );
  let dimLine  = this.dimGet( srcLineView )

  let boxView = this.tools.box.adapterFrom( srcBox );
  let dimBox = this.tools.box.dimGet( boxView );
  let min = this.tools.vectorAdapter.from( this.tools.box.cornerLeftGet( boxView ) );
  let max = this.tools.vectorAdapter.from( this.tools.box.cornerRightGet( boxView ) );

  _.assert( dimLine === dimBox );

  if( this.boxIntersects( srcLineView, boxView ) )
  return 0;

  let closestPoint = this.boxClosestPoint( srcLineView, boxView );
  return this.tools.box.pointDistance( boxView, closestPoint );
}

//

/**
  * Get the closest point in a line to a box. Returns the calculated point.
  * The box and the line remain unchanged. Only for 1D to 3d
  *
  * @param { Array } srcLine - Source line.
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
  * @returns { Number } Returns the closest point in the line to the box.
  * @function boxClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the line and box don´t have the same dimension).
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */

function boxClosestPoint( srcLine, srcBox, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( srcBox.length / 2 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcLine === null )
  srcLine = this.make( srcBox.length / 2 );

  let srcLineView = this.adapterFrom( srcLine );
  let origin = this.originGet( srcLineView );
  let direction = this.directionGet( srcLineView );
  let dimLine  = this.dimGet( srcLineView )

  let boxView = this.tools.box.adapterFrom( srcBox );
  let dimBox = this.tools.box.dimGet( boxView );
  let min = this.tools.vectorAdapter.from( this.tools.box.cornerLeftGet( boxView ) );
  let max = this.tools.vectorAdapter.from( this.tools.box.cornerRightGet( boxView ) );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  _.assert( dimLine === dimBox );

  if( this.boxIntersects( srcLineView, boxView ) )
  return 0;

  /* box corners */
  let c = this.tools.box.cornersGet( boxView );

  let distance = this.tools.box.pointDistance( boxView, origin );
  let d = 0;
  let pointView = this.tools.vectorAdapter.from( origin );

  for( let j = 0 ; j < _.Matrix.DimsOf( c )[ 1 ] ; j++ )
  {
    let corner = c.colGet( j );
    d = Math.abs( this.pointDistance( srcLineView, corner ) );
    if( d < distance )
    {
      distance = d;
      pointView = this.pointClosestPoint( srcLineView, corner );
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
  * Get the bounding box of a line. Returns destination box.
  * Line and box are stored in Array data structure. Source line stays untouched.
  *
  * @param { Array } dstBox - destination box.
  * @param { Array } srcLine - source line for the bounding box.
  *
  * @example
  * // returns [ - Infinity, 0, - Infinity, Infinity, 0, Infinity ]
  * _.boundingBoxGet( null, [ 0, 0, 0, - 2, 0, 2 ] );
  *
  * @returns { Array } Returns the array of the bounding box.
  * @function boundingBoxGet
  * @throws { Error } An Error if ( dim ) is different than dimGet(line) (the line and the box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstBox ) is not box
  * @throws { Error } An Error if ( srcLine ) is not line
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function boundingBoxGet( dstBox, srcLine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let srcLineView = this.adapterFrom( srcLine );
  let origin = this.originGet( srcLineView );
  let direction = this.directionGet( srcLineView );
  let dimLine  = this.dimGet( srcLineView )

  if( dstBox === null || dstBox === undefined )
  dstBox = this.tools.box.makeSingular( dimLine );

  _.assert( _.box.is( dstBox ) );
  let boxView = this.tools.box.adapterFrom( dstBox );
  let min = this.tools.box.cornerLeftGet( boxView );
  let max = this.tools.box.cornerRightGet( boxView );
  let dimB = this.tools.box.dimGet( boxView );

  _.assert( dimLine === dimB );

  let endPoint = this.tools.long.make( dimB );

  for( let i = 0; i < dimB; i++ )
  {
    if( direction.eGet( i ) !== 0 )
    {
      min.eSet( i, - Infinity );
      max.eSet( i, Infinity );
    }
    else if( direction.eGet( i ) === 0 )
    {
      min.eSet( i, origin.eGet( i ) );
      max.eSet( i, origin.eGet( i ) );
    }
  }

  return dstBox;
}

//

function capsuleIntersects( srcLine, tstCapsule )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstCapsuleView = this.tools.capsule.adapterFrom( tstCapsule );
  let lineView = this.adapterFrom( srcLine );

  let gotBool = this.tools.capsule.lineIntersects( tstCapsuleView, lineView );
  return gotBool;
}

//

function capsuleDistance( srcLine, tstCapsule )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstCapsuleView = this.tools.capsule.adapterFrom( tstCapsule );
  let lineView = this.adapterFrom( srcLine );

  let gotDist = this.tools.capsule.lineDistance( tstCapsuleView, lineView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a line to a capsule. Returns the calculated point.
  * Line and capsule remain unchanged
  *
  * @param { Array } line - The source line.
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
  * @throws { Error } An Error if ( line ) is not line
  * @throws { Error } An Error if ( capsule ) is not capsule
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function capsuleClosestPoint( line, capsule, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let lineView = this.adapterFrom( line );
  let dimLine = this.dimGet( lineView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimLine );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let capsuleView = this.tools.capsule.adapterFrom( capsule );
  let dimCapsule  = this.tools.capsule.dimGet( capsuleView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimLine === dstPoint.length );
  _.assert( dimLine === dimCapsule );

  if( this.tools.capsule.lineIntersects( capsuleView, lineView ) )
  return 0
  else
  {
    let capsulePoint = this.tools.capsule.lineClosestPoint( capsuleView, lineView );

    let linePoint = this.tools.vectorAdapter.from( this.pointClosestPoint( lineView, capsulePoint ) );

    for( let i = 0; i < dimLine; i++ )
    {
      dstPointView.eSet( i, linePoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

function convexPolygonIntersects( srcLine , polygon )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.convexPolygon.is( polygon ) );
  let lineView = this.adapterFrom( srcLine );

  let gotBool = this.tools.convexPolygon.lineIntersects( polygon, lineView );

  return gotBool;
}

//

function convexPolygonDistance( srcLine , polygon )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.convexPolygon.is( polygon ) );
  let lineView = this.adapterFrom( srcLine );

  let gotDist = this.tools.convexPolygon.lineDistance( polygon, lineView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a line to a convex polygon. Returns the calculated point.
  * Line and polygon remain unchanged
  *
  * @param { Array } line - The source line.
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
  * _.convexPolygonClosestPoint( [ -5, 2, -5, 1, 0, 1 ], polygon );
  *
  * @returns { Array } Returns the closest point to the polygon.
  * @function convexPolygonClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( line ) is not line
  * @throws { Error } An Error if ( polygon ) is not convexPolygon
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function convexPolygonClosestPoint( line, polygon, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  _.assert( _.convexPolygon.is( polygon ) );

  let lineView = this.adapterFrom( line );
  let dimL = this.dimGet( lineView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimL );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let dimP  = _.Matrix.DimsOf( polygon );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimL === dstPoint.length );
  _.assert( dimP[ 0 ] === dimL );

  if( this.tools.convexPolygon.lineIntersects( polygon, lineView ) )
  return 0
  else
  {
    let polygonPoint = this.tools.convexPolygon.lineClosestPoint( polygon, lineView );

    let linePoint = this.pointClosestPoint( lineView, polygonPoint, this.tools.vectorAdapter.from( this.tools.long.make( dimL ) ) ) ;

    for( let i = 0; i < dimL; i++ )
    {
      dstPointView.eSet( i, linePoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

/**
  * Check if a line and a frustum intersect. Returns true if they intersect and false if not.
  * The frustum and the line remain unchanged.
  *
  * @param { Array } srcLine - Source line.
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
  * @returns { Boolean } Returns true if the line and the frustum intersect.
  * @function frustumIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( dim ) is different than frustum.dimGet (the line and frustum don´t have the same dimension).
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */

function frustumIntersects( srcLine, srcFrustum )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( srcFrustum ) );

  let dimFrustum = _.Matrix.DimsOf( srcFrustum ) ;
  let rows = dimFrustum[ 0 ];
  let cols = dimFrustum[ 1 ];

  if( srcLine === null )
  srcLine = this.make( rows - 1 );

  let srcLineView = this.adapterFrom( srcLine );
  let origin = this.originGet( srcLineView );
  let direction = this.directionGet( srcLineView );
  let dimLine  = this.dimGet( srcLineView );

  _.assert( dimLine === rows - 1 );

  if( this.tools.frustum.pointContains( srcFrustum, origin ) )
  return true;

  /* frustum corners */
  let corners = this.tools.frustum.cornersGet( srcFrustum );
  let cornersLength = _.Matrix.DimsOf( corners )[ 1 ];

  for( let j = 0 ; j < cornersLength ; j++ )
  {
    let corner = corners.colGet( j );
    let projection = this.pointClosestPoint( srcLineView, corner );

    if( this.tools.frustum.pointContains( srcFrustum, projection ) )
    return true;
  }

  return false;

}

//

/**
  * Get the distance between a line and a frustum. Returns the calculated distance.
  * The frustum and the line remain unchanged.
  *
  * @param { Array } srcLine - Source line.
  * @param { Array } srcFrustum - Source frustum.
  *
  * @example
  * // returns 0;
  * _.frustumDistance( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns Math.sqrt( 17 );
  * _.frustumDistance( [ 0, - 1, 0, 0, -2, 0 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Number } Returns the distance between a line and a frustum.
  * @function frustumClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( dim ) is different than frustum.dimGet (the line and frustum don´t have the same dimension).
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function frustumDistance( srcLine, srcFrustum )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( srcFrustum ) );

  let dimFrustum = _.Matrix.DimsOf( srcFrustum ) ;
  let rows = dimFrustum[ 0 ];
  let cols = dimFrustum[ 1 ];

  if( srcLine === null )
  srcLine = this.make( srcFrustum.length / 2 );

  let srcLineView = this.adapterFrom( srcLine );
  let origin = this.originGet( srcLineView );
  let direction = this.directionGet( srcLineView );
  let dimLine  = this.dimGet( srcLineView );

  _.assert( dimLine === rows - 1 );

  if( this.frustumIntersects( srcLineView, srcFrustum ) )
  return 0;

  let closestPoint = this.frustumClosestPoint( srcLineView, srcFrustum );
  return this.tools.frustum.pointDistance( srcFrustum, closestPoint );
}

//

/**
  * Get the closest point in a line to a frustum. Returns the calculated point.
  * The frustum and the line remain unchanged.
  *
  * @param { Array } srcLine - Source line.
  * @param { Array } srcFrustum - Source frustum.
  *
  * @example
  * // returns 0;
  * _.frustumClosestPoint( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns [ 0, - 1, 0 ];
  * _.frustumClosestPoint( [ 0, - 1, 0, 0, -2, 0 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Number } Returns the closest point in the line to the frustum.
  * @function frustumClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( dim ) is different than frustum.dimGet (the line and frustum don´t have the same dimension).
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function frustumClosestPoint( srcLine, srcFrustum, dstPoint )
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

  if( srcLine === null )
  srcLine = this.make( srcFrustum.length / 2 );

  let srcLineView = this.adapterFrom( srcLine );
  let origin = this.originGet( srcLineView );
  let direction = this.directionGet( srcLineView );
  let dimLine  = this.dimGet( srcLineView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  _.assert( dimLine === rows - 1 );

  if( this.frustumIntersects( srcLineView, srcFrustum ) )
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
    d = Math.abs( this.pointDistance( srcLineView, corner ) );
    if( d < distance )
    {
      distance = d;
      pointView = this.pointClosestPoint( srcLineView, corner );
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
  * Check if two lines intersect. Returns true if they intersect, false if not.
  * Lines stay untouched.
  *
  * @param { Vector } src1Line - The first source line.
  * @param { Vector } src2Line - The second source line.
  *
  * @example
  * // returns   true
  * _.lineIntersects( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  false
  * _.lineIntersects( [ -3, 0, 1, 0 ], [ 0, -2, 1, 0 ] );
  *
  * @returns { Boolean } Returns true if the two lines intersect.
  * @function lineIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Line ) is not line.
  * @throws { Error } An Error if ( src2Line ) is not line.
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function lineIntersects( srcLine1, srcLine2 )
{

  if( this.lineIntersectionFactors( srcLine1, srcLine2 ) === 0 )
  return false

  return true;
}

//

/**
  * Get the distance between two lines. Returns the calculated distance.
  * The lines remain unchanged.
  *
  * @param { Array } srcLine - Source line.
  * @param { Array } tstLine - Test line.
  *
  * @example
  * // returns 0;
  * _.lineDistance( [ 0, 0, 0, 2, 2, 2 ], [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns Math.sqrt( 12 );
  * _.lineDistance( [ 0, 0, 0, 0, -2, 0 ] , [ 2, 2, 2, 0, 0, 1 ]);
  *
  * @returns { Number } Returns the distance between two lines.
  * @function lineDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( tstLine ) is not line.
  * @throws { Error } An Error if ( dim ) is different than line.dimGet (the lines don´t have the same dimension).
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function lineDistance( srcLine, tstLine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcLine === null )
  srcLine = this.make( tstLine.length / 2 );

  let srcLineView = this.adapterFrom( srcLine );
  let srcOrigin = this.originGet( srcLineView );
  let srcDirection = this.directionGet( srcLineView );
  let srcDim  = this.dimGet( srcLineView )

  let tstLineView = this.adapterFrom( tstLine );
  let tstOrigin = this.originGet( tstLineView );
  let tstDirection = this.directionGet( tstLineView );
  let tstDim  = this.dimGet( tstLineView );

  _.assert( srcDim === tstDim );

  let distance;

  if( this.lineIntersects( srcLineView, tstLineView ) === true )
  return 0;
  // Parallel lines
  if( this.lineParallel( srcLineView, tstLineView ) )
  {
    let d1 = this.pointDistance( srcLineView, tstOrigin );
    let d2 = this.pointDistance( tstLineView, srcOrigin );
    let d3 = this.tools.avector.distance( srcOrigin, tstOrigin );

    if( d1 <= d2 && d1 <= d3 )
    {
      distance = d1;
    }
    else if( d2 <= d3 )
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
    let srcPoint = this.lineClosestPoint( srcLineView, tstLineView );
    let tstPoint = this.lineClosestPoint( tstLineView, srcLineView );
    distance = this.tools.avector.distance( srcPoint, tstPoint );
  }


  return distance;
}

//

/**
  * Get the closest point in a line to a line. Returns the calculated point.
  * The lines remain unchanged.
  *
  * @param { Array } srcLine - Source line.
  * @param { Array } tstLine - Test line.
  *
  * @example
  * // returns 0;
  * _.lineClosestPoint( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.lineClosestPoint( [ 0, 0, 0, 0, 1, 0 ] , [ 1, 0, 0, 1, 0, 0 ]);
  *
  * @returns { Array } Returns the closest point in the srcLine to the tstLine.
  * @function lineClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( tstLine ) is not line.
  * @throws { Error } An Error if ( dim ) is different than line.dimGet (the lines don´t have the same dimension).
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function lineClosestPoint( srcLine, tstLine, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( tstLine.length / 2 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcLine === null )
  srcLine = this.make( tstLine.length / 2 );

  let srcLineView = this.adapterFrom( srcLine );
  let srcOrigin = this.originGet( srcLineView );
  let srcDir = this.directionGet( srcLineView );
  let srcDim  = this.dimGet( srcLineView );

  let tstLineView = this.adapterFrom( tstLine );
  let tstOrigin = this.originGet( tstLineView );
  let tstDir = this.directionGet( tstLineView );
  let tstDim = this.dimGet( tstLineView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  _.assert( srcDim === tstDim );

  let pointView;

  // Same origin
  let identOrigin = 0;
  for( let i = 0; i < srcOrigin.length; i++ )
  {
    if( srcOrigin.eGet( i ) === tstOrigin.eGet( i ) )
    identOrigin = identOrigin + 1;
  }
  if( identOrigin === srcOrigin.length )
  pointView = srcOrigin;
  else
  {
    // Parallel lines
    if( this.lineParallel( srcLineView, tstLineView ) )
    {
      pointView = this.pointClosestPoint( srcLineView, tstOrigin );
    }
    else
    {
      let srcMod = this.tools.vectorAdapter.dot( srcDir, srcDir );
      let tstMod = this.tools.vectorAdapter.dot( tstDir, tstDir );
      let mod = this.tools.vectorAdapter.dot( srcDir, tstDir );
      let dOrigin = this.tools.vectorAdapter.from( this.tools.avector.sub( tstOrigin.slice(), srcOrigin ) );
      let factor = ( - mod*this.tools.vectorAdapter.dot( tstDir, dOrigin ) + tstMod*this.tools.vectorAdapter.dot( srcDir, dOrigin ))/( tstMod*srcMod - mod*mod );

      pointView = this.lineAt( srcLineView, factor );
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
  * Check if a line and a plane intersect. Returns true if they intersect and false if not.
  * The plane and the line remain unchanged.
  *
  * @param { Array } srcLine - Source line.
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
  * @returns { Boolean } Returns true if the line and the plane intersect.
  * @function planeIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the line and plane don´t have the same dimension).
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function planeIntersects( srcLine, srcPlane )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcLine === null )
  srcLine = this.make( srcPlane.length - 1 );

  let srcLineView = this.adapterFrom( srcLine );
  let origin = this.originGet( srcLineView );
  let direction = this.directionGet( srcLineView );
  let dimLine  = this.dimGet( srcLineView )

  let planeView = this.tools.plane.adapterFrom( srcPlane );
  let normal = this.tools.plane.normalGet( planeView );
  let bias = this.tools.plane.biasGet( planeView );
  let dimPlane = this.tools.plane.dimGet( planeView );

  _.assert( dimLine === dimPlane );

  if( this.tools.plane.pointContains( planeView, origin ) )
  return true;

  let dirDotNormal = this.tools.vectorAdapter.dot( direction, normal );

  if( dirDotNormal !== 0 )
  {
    return true;
  /*
  *  let originDotNormal = this.tools.vectorAdapter.dot( origin, normal );
  *  let factor = - ( originDotNormal + bias ) / dirDotNormal;
  *
  *  if( factor > 0 )
  *  {
  *    return true;
  *  }
  */

  }

  return false;
}

//

/**
  * Get the intersection point between a line and a plane. Returns the calculated point.
  * The plane and the line remain unchanged.
  *
  * @param { Array } srcLine - Source line.
  * @param { Array } srcPlane - Source plane.
  * @param { Array } dstPoint - Destination point.
  *
  * @example
  * // returns [ 1, 1, 1 ];
  * _.planeIntersectionPoint( [ 0, 0, 0, 2, 2, 2 ] , [ 1, 0, 0, - 1 ]);
  *
  * @example
  * // returns 0;
  * _.planeIntersectionPoint( [ 0, -1, 0, 0, -2, 0 ] , [ 1, 0, 0, - 1 ]);
  *
  * @returns { Array } Returns the intersection point between the line and the plane, 0 if there is no intersection.
  * @function planeIntersectionPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the line and plane don´t have the same dimension).
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function planeIntersectionPoint( srcLine, srcPlane, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( srcPlane.length - 1 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcLine === null )
  srcLine = this.make( srcPlane.length - 1 );

  let srcLineView = this.adapterFrom( srcLine );
  let origin = this.originGet( srcLineView );
  let direction = this.directionGet( srcLineView );
  let dimLine  = this.dimGet( srcLineView )

  let planeView = this.tools.plane.adapterFrom( srcPlane );
  let normal = this.tools.plane.normalGet( planeView );
  let bias = this.tools.plane.biasGet( planeView );
  let dimPlane = this.tools.plane.dimGet( planeView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimLine === dimPlane );

  if( !this.planeIntersects( srcLineView, planeView ) )
  return 0;

  if( this.tools.plane.pointContains( planeView, origin ) )
  {
    origin = this.tools.vectorAdapter.from( origin );
    for( let i = 0; i < origin.length; i++ )
    {
      dstPointView.eSet( i, origin.eGet( i ) );
    }
    return dstPoint;
  }

  let copOrigin = this.tools.plane.pointCoplanarGet( planeView, origin );

  let secondPoint = this.lineAt( srcLineView, 1 );
  let secondCopPoint = this.tools.plane.pointCoplanarGet( planeView, secondPoint );
  let copLine = this.fromPoints( copOrigin, secondCopPoint );

  let point = this.tools.vectorAdapter.from( this.lineIntersectionPoint( srcLineView, copLine ) );

  for( let i = 0; i < origin.length; i++ )
  {
    dstPointView.eSet( i, point.eGet( i ) );
  }
  return dstPoint;

}

//

/**
  * Get the distance between a line and a plane. Returns the calculated distance.
  * The plane and the line remain unchanged.
  *
  * @param { Array } srcLine - Source line.
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
  * @returns { Number } Returns the distance between the line and the plane.
  * @function planeDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the line and plane don´t have the same dimension).
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function planeDistance( srcLine, srcPlane )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcLine === null )
  srcLine = this.make( srcPlane.length - 1 );

  let srcLineView = this.adapterFrom( srcLine );
  let origin = this.originGet( srcLineView );
  let direction = this.directionGet( srcLineView );
  let dimLine  = this.dimGet( srcLineView )

  let planeView = this.tools.plane.adapterFrom( srcPlane );
  let normal = this.tools.plane.normalGet( planeView );
  let bias = this.tools.plane.biasGet( planeView );
  let dimPlane = this.tools.plane.dimGet( planeView );

  _.assert( dimLine === dimPlane );

  if( this.planeIntersects( srcLineView, planeView ) )
  return 0;

  return Math.abs( this.tools.plane.pointDistance( planeView, origin ) );
}

//

/**
  * Get the closest point between a line and a plane. Returns the calculated point.
  * The plane and the line remain unchanged.
  *
  * @param { Array } srcLine - Source line.
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
  * @returns { Array } Returns the closest point in the line to the plane.
  * @function planeClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the line and plane don´t have the same dimension).
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function planeClosestPoint( srcLine, srcPlane, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( srcPlane.length - 1 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcLine === null )
  srcLine = this.make( srcPlane.length - 1 );

  let srcLineView = this.adapterFrom( srcLine );
  let origin = this.originGet( srcLineView );
  let direction = this.directionGet( srcLineView );
  let dimLine  = this.dimGet( srcLineView )

  let planeView = this.tools.plane.adapterFrom( srcPlane );
  let normal = this.tools.plane.normalGet( planeView );
  let bias = this.tools.plane.biasGet( planeView );
  let dimPlane = this.tools.plane.dimGet( planeView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimLine === dimPlane );

  if( this.planeIntersects( srcLineView, planeView ) )
  return 0;

  origin = this.tools.vectorAdapter.from( origin );
  for( let i = 0; i < origin.length; i++ )
  {
    dstPointView.eSet( i, origin.eGet( i ) );
  }


  return dstPoint;
}

//

/**
  * Check if a line and a ray intersect. Returns true if they intersect and false if not.
  * The ray and the line remain unchanged.
  *
  * @param { Array } srcLine - Source line.
  * @param { Array } srcRay - Source ray.
  *
  * @example
  * // returns true;
  * var srcRay =  [ -1, -1, -1, 0, 0, 1 ]
  * var srcLine = [ 0, 0, 0, 2, 2, 2 ]
  * _.rayIntersects( srcLine, srcRay );
  *
  * @example
  * // returns false;
  * var srcRay =  [ -1, -1, -1, 0, 0, 1 ]
  * var srcLine = [ 0, 1, 0, 2, 2, 2 ]
  * _.rayIntersects( srcLine, srcRay );
  *
  * @returns { Boolean } Returns true if the line and the ray intersect.
  * @function rayIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( dim ) is different than ray.dimGet (the line and ray don´t have the same dimension).
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function rayIntersects( srcLine, srcRay )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let srcRayView = this.tools.ray.adapterFrom( srcRay );
  let rayOrigin = this.tools.ray.originGet( srcRayView );
  let rayDirection = this.tools.ray.directionGet( srcRayView );
  let dimRay  = this.tools.ray.dimGet( srcRayView );

  if( srcLine === null )
  srcLine = this.make( srcRay.length / 2 );

  let srcLineView = this.adapterFrom( srcLine );
  let lineOrigin = this.originGet( srcLineView );
  let lineDirection = this.directionGet( srcLineView );
  let dimLine  = this.dimGet( srcLineView );

  _.assert( dimLine === dimRay );

  let factors = this.lineIntersectionFactors( srcLineView, srcRayView );

  if( factors === 0 || factors.eGet( 1 ) < 0 )
  return false;

  return true;
}

//

/**
  * Get the intersection point in a line to a ray. Returns the calculated point.
  * The line and ray remain unchanged.
  *
  * @param { Array } srcLine - Source line.
  * @param { Array } srcRay - Test ray.
  * @param { Array } dstPoint -  Destination point.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.rayIntersectionPoint( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns 0;
  * _.rayIntersectionPoint( [ 0, 0, 0, 0, 1, 0 ] , [ 1, 0, 0, 1, 0, 0 ]);
  *
  * @returns { Array } Returns the intersection point between the srcLine and the srcRay.
  * @function rayIntersectionPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( dim ) is different than ray.dimGet (the line and ray don´t have the same dimension).
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function rayIntersectionPoint( srcLine, srcRay, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( srcRay.length / 2 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcLine === null )
  srcLine = this.make( srcRay.length / 2 );

  let srcLineView = this.adapterFrom( srcLine );
  let srcOrigin = this.originGet( srcLineView );
  let srcDir = this.directionGet( srcLineView );
  let srcDim  = this.dimGet( srcLineView );

  let srcRayView = this.tools.ray.adapterFrom( srcRay );
  let rayOrigin = this.tools.ray.originGet( srcRayView );
  let tstDir = this.tools.ray.directionGet( srcRayView );
  let rayDim = this.tools.ray.dimGet( srcRayView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  _.assert( srcDim === rayDim );

  let pointView;

  if( !this.rayIntersects( srcLineView, srcRayView ) )
  return 0;

  // Same origin
  let identOrigin = 0;
  for( let i = 0; i < srcOrigin.length; i++ )
  {
    if( srcOrigin.eGet( i ) === rayOrigin.eGet( i ) )
    identOrigin = identOrigin + 1;
  }
  if( identOrigin === srcOrigin.length )
  pointView = srcOrigin;
  else
  {
    // Parallel lines
    if( this.lineParallel( srcLineView, srcRayView ) )
    {
      pointView = this.pointClosestPoint( srcLineView, rayOrigin );
    }
    else
    {
      let srcMod = this.tools.vectorAdapter.dot( srcDir, srcDir );
      let tstMod = this.tools.vectorAdapter.dot( tstDir, tstDir );
      let mod = this.tools.vectorAdapter.dot( srcDir, tstDir );
      let dOrigin = this.tools.vectorAdapter.from( this.tools.avector.sub( rayOrigin.slice(), srcOrigin ) );
      let factor = ( - mod*this.tools.vectorAdapter.dot( tstDir, dOrigin ) + tstMod*this.tools.vectorAdapter.dot( srcDir, dOrigin ))/( tstMod*srcMod - mod*mod );

      pointView = this.lineAt( srcLineView, factor );
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
  * Returns the factors for the intersection between a line and a ray. Returns a vector with the intersection factors, 0 if there is no intersection.
  * Line and ray stay untouched.
  *
  * @param { Vector } srcLine - The source line.
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
  * @returns { Array } Returns the factors of the intersection between a line and a ray.
  * @function rayIntersectionFactors
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function rayIntersectionFactors( srcLine, srcRay )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( srcLine.length === srcRay.length, 'The line and the ray must have the same dimension' );

  let srcLineView = this.adapterFrom( srcLine.slice() );
  let srcRayView = this.adapterFrom( srcRay.slice() );

  let intersection = this.rayIntersects( srcLineView, srcRayView );

  if( !intersection )
  return 0;

  return this.lineIntersectionFactors( srcLineView, srcRayView );
}

//

/**
  * Get the distance between a ray and a line. Returns the calculated distance.
  * The line and the ray remain unchanged.
  *
  * @param { Array } srcLine - Source line.
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
  * @returns { Number } Returns the distance between a line and a ray.
  * @function rayDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( dim ) is different than ray.dimGet (the line and ray don´t have the same dimension).
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function rayDistance( srcLine, srcRay )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcLine === null )
  srcLine = this.make( srcRay.length / 2 );

  let srcLineView = this.adapterFrom( srcLine );
  let srcOrigin = this.originGet( srcLineView );
  let srcDirection = this.directionGet( srcLineView );
  let srcDim  = this.dimGet( srcLineView )

  let srcRayView = this.tools.ray.adapterFrom( srcRay );
  let rayOrigin = this.tools.ray.originGet( srcRayView );
  let rayDirection = this.tools.ray.directionGet( srcRayView );
  let rayDim  = this.tools.ray.dimGet( srcRayView );

  _.assert( srcDim === rayDim );

  let distance;

  if( this.rayIntersects( srcLineView, srcRayView ) === true )
  return 0;

  // Parallel line/ray
  if( this.lineParallel( srcLineView, srcRayView ) )
  {
    // Line is point
    let isPoint = 0;
    for( let i = 0; i < rayDim; i++ )
    {
      if( srcDirection.eGet( i ) === 0 )
      isPoint = isPoint + 1;
    }
    if( isPoint === rayDim )
    {
      distance = this.tools.ray.pointDistance( srcRayView, srcOrigin );
    }
    else
    {
      distance = this.pointDistance( srcLineView, rayOrigin );
    }
  }
  else
  {
    let srcPoint = this.rayClosestPoint( srcLineView, srcRayView );
    let tstPoint = this.tools.ray.lineClosestPoint( srcRayView, srcLineView );
    distance = this.tools.avector.distance( srcPoint, tstPoint );
  }

  return distance;
}

//

/**
  * Get the closest point in a line to a ray. Returns the calculated point.
  * The line and ray remain unchanged.
  *
  * @param { Array } srcLine - Source line.
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
  * @returns { Array } Returns the closest point in the srcLine to the srcRay.
  * @function rayClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( dim ) is different than ray.dimGet (the line and ray don´t have the same dimension).
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function rayClosestPoint( srcLine, srcRay, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( srcRay.length / 2 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcLine === null )
  srcLine = this.make( srcRay.length / 2 );

  let srcLineView = this.adapterFrom( srcLine );
  let srcOrigin = this.originGet( srcLineView );
  let srcDir = this.directionGet( srcLineView );
  let srcDim  = this.dimGet( srcLineView );

  let srcRayView = this.tools.ray.adapterFrom( srcRay );
  let rayOrigin = this.tools.ray.originGet( srcRayView );
  let tstDir = this.tools.ray.directionGet( srcRayView );
  let rayDim = this.tools.ray.dimGet( srcRayView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  _.assert( srcDim === rayDim );

  if( this.rayIntersects( srcLineView, srcRayView ) )
  return 0;

  let pointView;

  // Parallel lines
  if( this.lineParallel( srcLineView, srcRayView ) )
  {
    pointView = this.pointClosestPoint( srcLineView, rayOrigin );
  }
  else
  {
    let srcMod = this.tools.vectorAdapter.dot( srcDir, srcDir );
    let tstMod = this.tools.vectorAdapter.dot( tstDir, tstDir );
    let mod = this.tools.vectorAdapter.dot( srcDir, tstDir );
    let dOrigin = this.tools.vectorAdapter.from( this.tools.avector.sub( rayOrigin.slice(), srcOrigin ) );
    let factor = ( - mod*this.tools.vectorAdapter.dot( tstDir, dOrigin ) + tstMod*this.tools.vectorAdapter.dot( srcDir, dOrigin ))/( tstMod*srcMod - mod*mod );

    pointView = this.lineAt( srcLineView, factor );
  }


  pointView = this.tools.vectorAdapter.from( pointView );
  for( let i = 0; i < pointView.length; i++ )
  {
    dstPointView.eSet( i, pointView.eGet( i ) );
  }

  return dstPoint;
}

//

function segmentIntersects( srcLine , tstSegment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstSegmentView = this.tools.segment.adapterFrom( tstSegment );
  let lineView = this.adapterFrom( srcLine );

  let gotBool = this.tools.segment.lineIntersects( tstSegmentView, lineView );
  return gotBool;
}

//

/**
  * Get the intersection between a line and a segment. Returns the calculated point.
  * The line and segment remain unchanged.
  *
  * @param { Array } srcLine - Source line.
  * @param { Array } tstSegment - Test segment.
  * @param { Array } dstPoint -  Destination point.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.segmentIntersectionPoint( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns 0;
  * _.segmentIntersectionPoint( [ 0, - 1, 0, 0, -2, 0 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Array } Returns the intersection point between the srcLine and the tstLine.
  * @function segmentIntersectionPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( tstSegment ) is not segment.
  * @throws { Error } An Error if ( dim ) is different than segment.dimGet (the line and segment don´t have the same dimension).
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function segmentIntersectionPoint( srcLine, tstSegment, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( tstSegment.length / 2 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcLine === null )
  srcLine = this.make( tstSegment.length / 2 );

  let srcLineView = this.adapterFrom( srcLine );
  let srcOrigin = this.originGet( srcLineView );
  let srcDir = this.directionGet( srcLineView );
  let srcDim  = this.dimGet( srcLineView );

  let tstSegmentView = this.tools.segment.adapterFrom( tstSegment );
  let tstOrigin = this.tools.segment.originGet( tstSegmentView );
  let tstEnd = this.tools.segment.endPointGet( tstSegmentView );
  let tstDir = this.tools.segment.directionGet( tstSegmentView );
  let tstDim = this.tools.segment.dimGet( tstSegmentView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  _.assert( srcDim === tstDim );

  if( !this.segmentIntersects( srcLineView, tstSegmentView ) )
  return 0;

  let pointView;

  // Same origin
  let identOrigin = 0;
  for( let i = 0; i < srcOrigin.length; i++ )
  {
    if( srcOrigin.eGet( i ) === tstOrigin.eGet( i ) )
    identOrigin = identOrigin + 1;
  }
  if( identOrigin === srcOrigin.length )
  pointView = srcOrigin;
  else
  {

    if( this.lineParallel( srcLineView, tstSegmentView ) )
    {
      pointView = this.pointClosestPoint( srcLineView, tstOrigin );
    }
    else
    {
      let srcMod = this.tools.vectorAdapter.dot( srcDir, srcDir );
      let tstMod = this.tools.vectorAdapter.dot( tstDir, tstDir );
      let mod = this.tools.vectorAdapter.dot( srcDir, tstDir );
      let dOrigin = this.tools.vectorAdapter.from( this.tools.avector.sub( tstOrigin.slice(), srcOrigin ) );
      let factor = ( - mod*this.tools.vectorAdapter.dot( tstDir, dOrigin ) + tstMod*this.tools.vectorAdapter.dot( srcDir, dOrigin ))/( tstMod*srcMod - mod*mod );

      pointView = this.lineAt( srcLineView, factor );
    }

    // // Parallel line and segment
    // let lineSegment = this.fromPoints( [ tstOrigin, tstEnd ] );
    // if( this.lineParallel( srcLineView, lineSegment ) )
    // {
    //   pointView = this.pointClosestPoint( srcLineView, tstOrigin );
    // }
    // else
    // {
    //   let srcMod = this.tools.vectorAdapter.dot( srcDir, srcDir );
    //   let tstMod = this.tools.vectorAdapter.dot( tstDir, tstDir );
    //   let mod = this.tools.vectorAdapter.dot( srcDir, tstDir );
    //   let dOrigin = this.tools.vectorAdapter.from( this.tools.avector.sub( tstOrigin.slice(), srcOrigin ) );
    //   let factor = ( - mod*this.tools.vectorAdapter.dot( tstDir, dOrigin ) + tstMod*this.tools.vectorAdapter.dot( srcDir, dOrigin ))/( tstMod*srcMod - mod*mod );
    //
    //   pointView = this.lineAt( srcLineView, factor );
    // }

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
  * Returns the factors for the intersection between a line and a segment. Returns a vector with the intersection factors, 0 if there is no intersection.
  * Line and segment stay untouched.
  *
  * @param { Vector } srcLine - The source line.
  * @param { Vector } srcSegment - The source segment.
  *
  * @example
  * // returns   0
  * _.segmentIntersectionFactors( [ 0, 0, 2, 2 ], [ 1, 0, 2, 0 ] );
  *
  * @example
  * // returns  this.tools.vectorAdapter.from( [ 0, 0 ] )
  * _.segmentIntersectionFactors( [ - 2, 0, 1, 0 ], [ 0, - 2, 0, 2 ] );
  *
  * @returns { Array } Returns the factors of the intersection between a line and a segment.
  * @function segmentIntersectionFactors
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function segmentIntersectionFactors( srcLine, srcSegment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstSegmentView = this.tools.segment.adapterFrom( tstSegment );
  let lineView = this.adapterFrom( srcLine );
  let gotBool = this.tools.segment.lineIntersects( tstSegmentView, lineView );
  return gotBool;
}

//

function segmentDistance( srcLine , tstSegment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstSegmentView = this.tools.segment.adapterFrom( tstSegment );
  let lineView = this.adapterFrom( srcLine );

  let gotDist = this.tools.segment.lineDistance( tstSegmentView, lineView );

  return gotDist;
}

//

/**
  * Get the closest point in a line to a segment. Returns the calculated point.
  * The line and segment remain unchanged.
  *
  * @param { Array } srcLine - Source line.
  * @param { Array } tstSegment - Test segment.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.segmentClosestPoint( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns [ 0, - 1, 0 ];
  * _.segmentClosestPoint( [ 0, - 1, 0, 0, -2, 0 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Array } Returns the closest point in the srcLine to the tstLine.
  * @function segmentClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( tstSegment ) is not segment.
  * @throws { Error } An Error if ( dim ) is different than segment.dimGet (the line and segment don´t have the same dimension).
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function segmentClosestPoint( srcLine, tstSegment, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( tstSegment.length / 2 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcLine === null )
  srcLine = this.make( tstSegment.length / 2 );

  let srcLineView = this.adapterFrom( srcLine );
  let srcOrigin = this.originGet( srcLineView );
  let srcDir = this.directionGet( srcLineView );
  let srcDim  = this.dimGet( srcLineView );

  let tstSegmentView = this.tools.segment.adapterFrom( tstSegment );
  let tstOrigin = this.tools.segment.originGet( tstSegmentView );
  let tstEnd = this.tools.segment.endPointGet( tstSegmentView );
  let tstDir = this.tools.segment.directionGet( tstSegmentView );
  let tstDim = this.tools.segment.dimGet( tstSegmentView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  _.assert( srcDim === tstDim );

  let pointView;

  if( this.segmentIntersects( srcLineView, tstSegmentView ) )
  return 0;


  // Parallel line and segment
  let lineSegment = this.fromPoints( tstOrigin, tstEnd );
  if( this.lineParallel( srcLineView, lineSegment ) )
  {
    pointView = this.pointClosestPoint( srcLineView, tstOrigin );
  }
  else
  {

    // Parallel line and segment
    let lineSegment = this.fromPoints( tstOrigin, tstEnd );
    if( this.lineParallel( srcLineView, lineSegment ) )
    {
      pointView = this.pointClosestPoint( srcLineView, tstOrigin );
    }
    else
    {
      let srcMod = this.tools.vectorAdapter.dot( srcDir, srcDir );
      let tstMod = this.tools.vectorAdapter.dot( tstDir, tstDir );
      let mod = this.tools.vectorAdapter.dot( srcDir, tstDir );
      let dOrigin = this.tools.vectorAdapter.from( this.tools.avector.sub( tstOrigin.slice(), srcOrigin ) );
      let factor = ( - mod*this.tools.vectorAdapter.dot( tstDir, dOrigin ) + tstMod*this.tools.vectorAdapter.dot( srcDir, dOrigin ))/( tstMod*srcMod - mod*mod );

      pointView = this.lineAt( srcLineView, factor );

    }

    // let srcMod = this.tools.vectorAdapter.dot( srcDir, srcDir );
    // let tstMod = this.tools.vectorAdapter.dot( tstDir, tstDir );
    // let mod = this.tools.vectorAdapter.dot( srcDir, tstDir );
    // let dOrigin = this.tools.vectorAdapter.from( this.tools.avector.sub( tstOrigin.slice(), srcOrigin ) );
    // let factor = ( - mod*this.tools.vectorAdapter.dot( tstDir, dOrigin ) + tstMod*this.tools.vectorAdapter.dot( srcDir, dOrigin ))/( tstMod*srcMod - mod*mod );
    //
    // pointView = this.lineAt( srcLineView, factor );

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
  * Check if a line and a sphere intersect. Returns true if they intersect and false if not.
  * The sphere and the line remain unchanged.
  *
  * @param { Array } srcLine - Source line.
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
  * @returns { Boolean } Returns true if the line and the sphere intersect.
  * @function sphereIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the line and sphere don´t have the same dimension).
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function sphereIntersects( srcLine, srcSphere )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.sphere.is( srcSphere ) );

  if( srcLine === null )
  srcLine = this.make( srcSphere.length - 1 );

  let srcLineView = this.adapterFrom( srcLine );
  let origin = this.originGet( srcLineView );
  let direction = this.directionGet( srcLineView );
  let dimLine  = this.dimGet( srcLineView )

  let sphereView = this.tools.sphere.adapterFrom( srcSphere );
  let center = this.tools.sphere.centerGet( sphereView );
  let radius = this.tools.sphere.radiusGet( sphereView );
  let dimSphere = this.tools.sphere.dimGet( sphereView );

  _.assert( dimLine === dimSphere );

  if( this.tools.sphere.pointContains( sphereView, origin ) )
  return true;

  let distance = this.pointDistance( srcLineView, center );

  if( distance <= radius)
  return true;

  return false;

}

//

/**
  * Get the distance between a line and a sphere. Returns the calculated distance.
  * The sphere and the line remain unchanged.
  *
  * @param { Array } srcLine - Source line.
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
  * @returns { Boolean } Returns the distance between the line and the sphere.
  * @function sphereDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the line and sphere don´t have the same dimension).
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function sphereDistance( srcLine, srcSphere )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.sphere.is( srcSphere ) );

  if( srcLine === null )
  srcLine = this.make( srcSphere.length - 1 );

  let srcLineView = this.adapterFrom( srcLine );
  let origin = this.originGet( srcLineView );
  let direction = this.directionGet( srcLineView );
  let dimLine  = this.dimGet( srcLineView )

  let sphereView = this.tools.sphere.adapterFrom( srcSphere );
  let center = this.tools.sphere.centerGet( sphereView );
  let radius = this.tools.sphere.radiusGet( sphereView );
  let dimSphere = this.tools.sphere.dimGet( sphereView );

  _.assert( dimLine === dimSphere );

  if( this.sphereIntersects( srcLineView, sphereView ) )
  return 0;

  return this.pointDistance( srcLineView, center ) - radius;
}

//

/**
  * Get the closest point in a line to a sphere. Returns the calculated point.
  * The sphere and the line remain unchanged.
  *
  * @param { Array } srcLine - Source line.
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
  * @returns { Boolean } Returns the closest point in a line to a sphere.
  * @function sphereClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the line and sphere don´t have the same dimension).
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */
function sphereClosestPoint( srcLine, srcSphere, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  _.assert( _.sphere.is( srcSphere ) );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( srcSphere.length - 1 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcLine === null )
  srcLine = this.make( srcSphere.length - 1 );

  let srcLineView = this.adapterFrom( srcLine );
  let origin = this.originGet( srcLineView );
  let direction = this.directionGet( srcLineView );
  let dimLine  = this.dimGet( srcLineView )

  let sphereView = this.tools.sphere.adapterFrom( srcSphere );
  let center = this.tools.sphere.centerGet( sphereView );
  let radius = this.tools.sphere.radiusGet( sphereView );
  let dimSphere = this.tools.sphere.dimGet( sphereView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimLine === dimSphere );

  if( this.sphereIntersects( srcLineView, sphereView ) )
  return 0;

  let pointVector = this.tools.vectorAdapter.from( this.pointClosestPoint( srcLineView, center ) );

  for( let i = 0; i < pointVector.length; i++ )
  {
    dstPointView.eSet( i, pointVector.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Get the bounding sphere of a line. Returns destination sphere.
  * Line and sphere are stored in Array data structure. Source line stays untouched.
  *
  * @param { Array } dstSphere - destination sphere.
  * @param { Array } srcLine - source line for the bounding sphere.
  *
  * @example
  * // returns [ 0, 0, 0, Infinity ]
  * _.boundingSphereGet( null, [ 0, 0, 0, 2, 2, 2 ] );
  *
  * @returns { Array } Returns the array of the bounding sphere.
  * @function boundingSphereGet
  * @throws { Error } An Error if ( dim ) is different than dimGet(line) (the line and the sphere don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstSphere ) is not sphere
  * @throws { Error } An Error if ( srcLine ) is not line
  * @namespace wTools.linePointDir
  * @module Tools/math/Concepts
  */

function boundingSphereGet( dstSphere, srcLine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let srcLineView = this.adapterFrom( srcLine );
  let origin = this.originGet( srcLineView );
  let direction = this.directionGet( srcLineView );
  let dimLine  = this.dimGet( srcLineView )

  if( dstSphere === null || dstSphere === undefined )
  dstSphere = this.tools.sphere.makeZero( dimLine );

  _.assert( _.sphere.is( dstSphere ) );
  let dstSphereView = this.tools.sphere.adapterFrom( dstSphere );
  let center = this.tools.sphere.centerGet( dstSphereView );
  let radiusSphere = this.tools.sphere.radiusGet( dstSphereView );
  let dimSphere = this.tools.sphere.dimGet( dstSphereView );

  _.assert( dimLine === dimSphere );

  // Center of the sphere
  for( let c = 0; c < center.length; c++ )
  {
    center.eSet( c, origin.eGet( c ) );
  }

  // Radius of the sphere
  let distOrigin = this.tools.vectorAdapter.distance( this.tools.vectorAdapter.from( this.tools.longMakeZeroed( dimLine ) ), direction );

  if( distOrigin === 0  )
  {
  this.tools.sphere.radiusSet( dstSphereView, 0 );
  }
  else
  {
    this.tools.sphere.radiusSet( dstSphereView, Infinity );
  }

  return dstSphere;
}

//

function pointsToPointSide( segmentPoints, point )
{
  _.assert( point.length === 2, 'not implemented' );
  _.assert( segmentPoints.length === 4, 'not implemented' );

  let segmentPointsView = this.tools.vectorAdapter.from( segmentPoints );
  let pointView = this.tools.vectorAdapter.from( point );

  /*
    d=(x−x1)(y2−y1)−(y−y1)(x2−x1)
    d === 0 point is on the line, otherwise on the side of the line
  */

  let point0x = pointView.eGet( 0 ) - segmentPointsView.eGet( 0 );
  let point0y = pointView.eGet( 1 ) - segmentPointsView.eGet( 1 )

  let point1x = segmentPointsView.eGet( 2 ) - segmentPointsView.eGet( 0 );
  let point1y = segmentPointsView.eGet( 3 ) - segmentPointsView.eGet( 1 );

  let result = point0x * point1y - point0y * point1x;

  return result;
/*
  let point0 = [ point[ 0 ] - segmentPoints[ 0 ][ 0 ], point[ 1 ] - segmentPoints[ 0 ][ 1 ] ];
  let point1 = [ segmentPoints[ 1 ][ 0 ] - segmentPoints[ 0 ][ 0 ], segmentPoints[ 1 ][ 1 ] - segmentPoints[ 0 ][ 1 ] ];

  let result = point0[ 0 ] * point1[ 1 ] - point0[ 1 ] * point1[ 0 ];

  return result;
*/
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
  fromPoints, // fromPoints,
  fromPoints2,

  is,
  dimGet,
  originGet,
  directionGet,

  lineAt,
  getFactor,

  lineParallel3d,
  lineParallel,
  lineIntersectionFactors,
  lineIntersectionPoints,
  lineIntersectionPoint,
  lineIntersectionPointAccurate,

  pointContains,
  pointDistance,
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

  convexPolygonIntersects,
  convexPolygonDistance,
  convexPolygonClosestPoint,

  frustumIntersects,
  frustumDistance,
  frustumClosestPoint,

  sphereIntersects,
  sphereDistance,
  sphereClosestPoint,
  boundingSphereGet,

  planeIntersects,
  planeIntersectionPoint,
  planeDistance,
  planeClosestPoint,

  rayIntersects,
  rayIntersectionPoint,
  rayIntersectionFactors,
  rayDistance,
  rayClosestPoint,

  segmentIntersects,  /* Same as _.segment.rayIntersects */
  segmentIntersectionPoint,
  segmentIntersectionFactors,
  segmentDistance,  /* Same as _.segment.rayDistance */
  segmentClosestPoint,

  pointsToPointSide,

  // ref

  tools : _,

}

/* _.props.extend */Object.assign( _.linePointDir, Extension );

})();
