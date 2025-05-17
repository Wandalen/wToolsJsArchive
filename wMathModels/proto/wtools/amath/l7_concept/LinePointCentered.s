(function _LinePointCentered_s_(){

'use strict';

const _ = _global_.wTools;
_.linePointCentered = _.linePointCentered || Object.create( _.avector );

/**
 * Is a line alligned relative to the origin of coordinate system.
 * For the following functions, line should have shape [ X, Y, Z ]
 * @namespace wTools.linePointCentered
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
  * Check if input is a centered line. Returns true if it is a centered line and false if not.
  *
  * @param { Vector } pair - Source line.
  *
  * @example
  * // returns true;
  * _.linePointCentered.is( [ 1,1 ] );
  *
  * @returns { Boolean } Returns true if the input is a centered line.
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @namespace wTools.linePointCentered
  * @module Tools/math/Concepts
  */

function is( pair )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return ( _.longIs( pair ) || _.vectorAdapterIs( pair ) ) && ( pair.length % 2 === 0 ) && ( pair.length >= 2 );
}

//

/**
  * Returns the dimension of the centered line. Line stays untouched.
  *
  * @param { Vector } pair - The source line.
  *
  * @example
  * // returns 2
  * _.linePointCentered.dimGet( [ 1, 1 ] );
  *
  * @returns { Number } Returns the dimension of the centered line.
  * @function dimGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( pair ) is not centered line.
  * @namespace wTools.linePointCentered
  * @module Tools/math/Concepts
  */

function dimGet( pair )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( this.is( pair ) );
  return pair.length / 2;
}

//

function pointDistanceCentered2D( srcLineCentered, srcPointCentered )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcLineCentered === null )
  srcLineCentered = this.make( srcPointCentered.length / 2 );

  let srcLineView = this.adapterFrom( srcLineCentered );
  let dimension  = srcLineView.length;
  let srcPointView = this.tools.vectorAdapter.from( srcPointCentered.slice() );

  _.assert( dimension === 2, 'not implemented' );
  _.assert( dimension === srcPointCentered.length, 'The line and the point must have the same dimension' );

  let srcLineFromCentered = [ 0, 0, srcLineView.eGet( 0 ), srcLineView.eGet( 1 ) ];
  if( this.linePointDir.pointContains( srcLineFromCentered, srcPointView ) )
  return 0;

  let srcLineP = this.tools.vectorAdapter.fromLong( [ -srcLineView.eGet( 1 ), +srcLineView.eGet( 0 ) ]);
  let distance = this.tools.vectorAdapter.dot( srcLineP, srcPointView );
  distance = distance / this.tools.vectorAdapter.mag( srcLineView );
  return distance;
}

//

function pointDistance2D( linePoints, point )
{
  _.assert( arguments.length === 2 );

  let linePointsView = this.tools.vectorAdapter.from( linePoints );
  let pointView = this.tools.vectorAdapter.from( point );

  let linePoint1 = linePointsView.review([ 0, 1 ]);
  let linePoint2 = linePointsView.review([ 2, 3 ]);

  let lineCentered = this.tools.vectorAdapter.sub( null, linePoint2, linePoint1 );
  let pointCentered = this.tools.vectorAdapter.sub( null, pointView, linePoint1 );

  return this.pointDistanceCentered2D( lineCentered, pointCentered );

  /* let lineCentered = avector.sub( linePoints[ 1 ].slice(), linePoints[ 0 ] );
  let pointCentered = avector.sub( point.slice(), linePoints[ 0 ] );

  return d2LinePointDistanceCentered( lineCentered, pointCentered ); */
}

//

function pointDistanceCentered3DSqr( lineCentered, pointCentered )
{
  _.assert( arguments.length === 2 );

  let pointCenteredView = this.tools.vectorAdapter.from( pointCentered );
  let lineCenteredView = this.tools.vectorAdapter.from( lineCentered );

  let cross = this.tools.vectorAdapter.cross( null, pointCenteredView, lineCenteredView );

  let pointCenteredDot = this.tools.vectorAdapter.dot( cross, cross );
  let lineCenteredDot = this.tools.vectorAdapter.dot( lineCenteredView, lineCenteredView );

  return  pointCenteredDot / lineCenteredDot;

  /*

  throw _.err( 'not tested' );

  //p.slice().sub( p.slice().mul( p.dot( b ) ) );
  p.cross( b );

  return p.lengthSq() / b.lengthSq();

  */
}

//

function pointDistance3DSqr( linePoints, point )
{
  _.assert( arguments.length === 2 );

  let linePointsView = this.tools.vectorAdapter.from( linePoints );
  let pointView = this.tools.vectorAdapter.from( point );

  let linePoint1 = linePointsView.review([ 0, 2 ]);
  let linePoint2 = linePointsView.review([ 3, 5 ]);

  let lineCentered = this.tools.vectorAdapter.sub( null, linePoint2, linePoint1 );
  let pointCentered = this.tools.vectorAdapter.sub( null, pointView, linePoint1 );

  return this.pointDistanceCentered3dSqr( lineCentered, pointCentered );
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

  pointDistanceCentered2D,
  pointDistance2D,
  pointDistanceCentered3DSqr,
  pointDistance3DSqr,

  // ref

  tools : _,
}

/* _.props.extend */Object.assign( _.linePointCentered, Extension );
injectChunks( Extension );

})();
