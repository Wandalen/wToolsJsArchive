(function _Box_s_(){

'use strict';

const _ = _global_.wTools;
// let this.tools.avector = this.tools.avector;
// let vector = this.tools.vectorAdapter;
_.box = _.box || Object.create( _.avector );

/**
 * @description
 * A box is the space enclosed by orthogonal planes:
 *
 * For the following functions, boxes must have the shape [ minX, minY, minZ, maxX, maxY, maxZ ],
 * where the dimension equals the long's length divided by two.
 *
 * Moreover, minX, minY and minZ are the coordinates of the back, bottom left corner of the box,
 * and maxX, maxY, maxZ the coordinates of the front, top right corner.
 * @namespace wTools.box
  * @module Tools/math/Concepts
 */

/*
qqq : make sure all routines in all files of such kind in order
  *Contains : *Contains,
  *Intersects : *Intersects,
  *Distance : *Distance,
  *ClosestPoint : *ClosestPoint,
  *Expand : *Expand,
- *Distance returns 0 if intersection
- _.*.*ClosestPoint does not accept undefines or null
- _.*.pointClosestPoint writes result into 2-nd argument
- other _.*.*ClosestPoint makes new Array for result
- no need in _.frustum.*Expand
- no need in _.*.pointIntersects
*/

/*
qqq
- avoid toLong - use eGet, eSet instead
- CC break : identation
*/

/*

  A box is the space enclosed by orthogonal planes:

  For the following functions, boxes must have the shape [ minX, minY, minZ, maxX, maxY, maxZ ],
where the dimension equals the long's length divided by two.

  Moreover, minX, minY and minZ are the coordinates of the back, bottom left corner of the box,
and maxX, maxY, maxZ the coordinates of the front, top right corner.

*/

// --
//
// --

/**
  *Create a box of dimension dim. Returns the created box. Box is stored in Array data structure.
  * Dim remains unchanged.
  *
  * @param { Number } dim - Dimension of the created box.
  *
  * @example
  * // returns [ 0, 0, 0, 0, 0, 0 ];
  * _.box.make( 3 );
  *
  * @example
  * // returns [ 0, 0, 1, 1 ];
  * _.box.make( [ 0, 0, 1, 1 ] );
  *
  * @returns { Array } Returns the array of the created box.
  * @function make
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @namespace wTools.box
   * @module Tools/math/Concepts
  */

function make( dim )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = this.makeZero( dim );

  if( this.is( dim ) )
  this.tools.avector.assign( result, dim );

  return result;
}

//

/**
  *Create a box of zeros of dimension dim. Returns the created box. Box is stored in Array data structure.
  * Dim remains unchanged.
  *
  * @param { Number } dim - Dimension of the created box.
  *
  * @example
  * // returns [ 0, 0, 0, 0, 0, 0 ];
  * _.box.makeZero( 3 );
  *
  * @example
  * // returns [ 0, 0, 0, 0 ];
  * _.box.makeZero( [ 1, 1, 2, 2] );
  *
  * @function makeZero
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @namespace wTools.box
   * @module Tools/math/Concepts
  */

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

/**
  *Create a nil box of dimension dim. Returns the created box. Box is stored in Array data structure.
  * Dim remains unchanged.
  *
  * @param { Number } dim - Dimension of the created box.
  *
  * @example
  * // returns [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  * _.box.makeSingular( 3 );
  *
  * @example
  * // returns [ Infinity, Infinity, - Infinity, - Infinity ];
  * _.box.makeSingular( [ 1, 1, 2, 2] );
  *
  * @function makeSingular
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */

function makeSingular( dim )
{
  if( this.is( dim ) )
  dim = this.dimGet( dim );

  if( dim === undefined || dim === null )
  dim = 3;

  let result = [];

  for( let i = 0 ; i < dim ; i++ )
  result[ i ] = +Infinity;

  for( let i = 0 ; i < dim ; i++ )
  result[ dim + i ] = -Infinity;

  return result;
}

//

/**
  *Transform a box in a box of zeros. Returns the created box. Box is stored in Array data structure.
  *
  * @param { Array } box - Destination box.
  *
  * @example
  * // returns [ 0, 0, 0, 0 ];
  * _.zero( [ 1, 1, 2, 2] );
  *
  * @example
  * // returns [ 0, 0, 0, 0, 0, 0 ];
  * _.zero( 3 );
  *
  * @function zero
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function zero( box )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( this.is( box ) )
  {
    let boxView = this.adapterFrom( box );
    boxView.assign( 0 );
    return box;
  }

  return this.makeZero( box );
}

//

/**
  *Transform a box in a nil box. Returns the created box. Box is stored in Array data structure.
  *
  * @param { Array } box - Destination box.
  *
  * @example
  * // returns [ Infinity, Infinity, - Infinity, - Infinity ];
  * _.nil( [ 1, 1, 2, 2] );
  *
  * @example
  * // returns [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  * _.nil( 3 );
  *
  * @function nil
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */

function nil( box )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( this.is( box ) )
  {
    let boxView = this.adapterFrom( box );
    let min = this.cornerLeftGet( boxView );
    let max = this.cornerRightGet( boxView );

    this.tools.vectorAdapter.assign( min, +Infinity );
    this.tools.vectorAdapter.assign( max, -Infinity );

    return box;
  }

  return this.makeSingular( box );
}

//

/**
  *Transform a box in a box centered in the origin of a given size. Returns the created box.
  * Box is stored in Array data structure.
  *
  * @param { Array } box - Destination box.
  * @param { Number } size - Source size.
  *
  * @example
  * // returns [ -0.5, -0.5, 0.5, 0.5 ];
  * _.centeredOfSize( [ 1, 1, 2, 2] );
  *
  * @example
  * // returns [ - 1.5, -1.5, -1.5, 1.5, 1.5, 1.5 ];
  * _.centeredOfSize( 3 );
  *
  * @example
  * // returns [ - 1.5, -1.5, 1.5, 1.5 ];
  * _.centeredOfSize( [ 1, 1, 2, 2], 3 );
  *
  * @returns { Array } Returns the created box.
  * @function centeredOfSize
  * @throws { Error } An Error if ( arguments.length ) is different than one or two.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function centeredOfSize( box, size )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );

  /* qqq : in routines like this "box" and "null" are only valid first argument */

  _.assert( _.numberIs( size ) || _.longIs( size ) || _.vectorAdapterIs( size ) );

  if( !this.is( box ) )
  box = this.make( box );

  let boxView = this.adapterFrom( box );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );

  size = _.numbersSlice( size );
  size = this.tools.avector.mul( size, 0.5 );
  this.tools.vectorAdapter.assign( max, size );
  size = this.tools.avector.mul( size, -1 );
  this.tools.vectorAdapter.assign( min, size );

  return box;
}

//

/**
  *Create or return a box. Returns the created box.
  *
  * @param { Array } box - Destination box.
  *
  * @example
  * // returns [ 1, 1, 2, 2 ];
  * _.from( [ 1, 1, 2, 2 ] );
  *
  * @example
  * // returns this.tools.vectorAdapter.from( [ 1, 1, 2, 2 ] );
  * _.from( this.tools.vectorAdapter.from( [ 1, 1, 2, 2 ] ) );
  *
  * @function from
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function from( box )
{

  // if( _.object.isBasic( box ) )
  // {
  //   _.map.assertHasExactly( box, { min : 'min' , max : 'max' } );
  //   debugger;
  //   box = _.arrayAppendArrays( [], [ box.min, box.max ] );
  // }
  //
  // if( box === null || box === undefined )
  // box = this.make();

  _.assert( this.is( box ) || box === null );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( box === null )
  return this.make();

  // if( _.vectorAdapterIs( box ) )
  // {
  //   debugger;
  //   throw _.err( 'not implemented' );
  //   return box.slice();
  // }

  return box;
}

//

/**
  *Create or return a box vector. Returns the created box.
  *
  * @param { Array } box - Destination box.
  *
  * @example
  * // returns this.tools.vectorAdapter.from( [ 1, 1, 2, 2 ] );
  * _.adapterFrom( [ 1, 1, 2, 2 ] );
  *
  * @returns { Vector } Returns the vector of the box.
  * @function adapterFrom
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function adapterFrom( box )
{
  _.assert( this.is( box ) );
  _.assert( arguments.length === 1, 'Expects single argument' );
  return this.tools.vectorAdapter.from( box );
}

//

/**
  *Create or expand box from an array of points. Returns the expanded box. Box are stored in Array data structure.
  * Points stay untouched, box changes.
  *
  * @param { Array } box - box to be expanded.
  * @param { Array } points - Array of points of reference with expansion dimensions.
  *
  * @example
  * // returns [ 0, 0, 3, 3 ];
  * _.fromPoints( null , [ [ 1, 3 ], [ 0, 0 ], [ 3, 1 ] ] );
  *
  * @example
  * // returns [ 0, - 1, 2, 2 ];
  * _.fromPoints( [ 0, 0, 1, 1 ], [ [ 1, 2 ], [ 0, 0 ], [ 2, - 1 ] ] );
  *
  * @returns { Array } Returns the array of the box expanded.
  * @function fromPoints
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( point ) is not array.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */

function fromPoints( box, points )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.vectorAdapterIs( points ) || _.arrayIs( points ) || _.longIs( points ) );

  let dimp = points[0].length;

  if( box === null )
  box = this.makeSingular( dimp );

  let boxView = this.adapterFrom( box );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );

  debugger;
  // throw _.err( 'not tested' );

  for( let i = 0 ; i < points.length ; i += 1 )
  {
    this.pointExpand( boxView, points[ i ] );
  }

  return box;

}

//

/**
  * Create or expand box from center point and size dimensions. Returns the expanded box.
  * Box are stored in Array data structure. Center point and size stay untouched, box changes.
  *
  * @param { Array } box - box to be expanded.
  * @param { Array } center - Point of reference with center coordinates.
  * @param { Array } size - Array of reference with size dimensions.
  *
  * @example
  * // returns [ - 1, - 1, 3, 3 ];
  * _.fromCenterAndSize( [ 0, 0, 1, 1 ], [ 1, 1 ], [ 4, 4 ] );
  *
  * @example
  * // returns [ 0, 0, 2, 2 ];
  * _.fromCenterAndSize( [ 0, 0, 1, 1 ], [ 1, 1 ], [ 2, 2 ] );
  *
  * @returns { Array } Returns the array of the box expanded.
  * @function fromCenterAndSize
  * @throws { Error } An Error if ( arguments.length ) is different than three.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( center ) is not point.
  * @throws { Error } An Error if ( size ) is not array.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function fromCenterAndSize( box, center, size )
{
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );

  if( box === null )
  box = this.make( center.length );

  _.assert( _.longIs( center ) || _.vectorAdapterIs( center ) );
  _.assert( _.numberIs( size ) || _.longIs( size ) || _.vectorAdapterIs( size ) );

  let boxView = this.adapterFrom( box );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );
  let dim = this.dimGet( boxView );
  let center_ = this.tools.vectorAdapter.from( center );
  let size_ = this.tools.vectorAdapter.from( size );

  _.assert( dim === center_.length );
  _.assert( dim === size_.length );

  debugger;
  //throw _.err( 'not tested' );

  size_ = this.tools.vectorAdapter.mul( size_.clone() , 0.5 );
  this.tools.vectorAdapter.sub( min.copy( center_ ) , size_ );
  this.tools.vectorAdapter.add( max.copy( center_ ) , size_ );

  return box;
}

//

/**
  * Create or expand box from sphere. Returns the expanded box.
  * Box are stored in Array data structure. Sphere stays untouched, box changes.
  * First, the box is expanded until it contains the center of the sphere.
  * Then, the box is expanded by the radius of the sphere.
  *
  * @param { Array } box - box to be expanded.
  * @param { Array } sphere - sphere of reference with expansion dimensions.
  *
  * @example
  * // returns [ - 1, - 1, 2, 2 ];
  * _.fromSphere( [ 0, 0, 1, 1 ], [ 1, 1, 1 ] );
  *
  * @example
  * // returns [ - 2, - 2, 3, 3 ];
  * _.fromSphere( [ 0, 0, 1, 1 ], [ 1, 1, 2 ] );
  *
  * @returns { Array } Returns the array of the expanded box.
  * @function fromSphere
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function fromSphere( box, sphere )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.sphere.is( sphere ) );

  let sphereView = this.tools.sphere.adapterFrom( sphere );
  let dim1 = this.tools.sphere.dimGet( sphereView );
  let center = this.tools.sphere.centerGet( sphereView );
  let radius = this.tools.sphere.radiusGet( sphereView );

  if( box === null )
  box = this.makeSingular( dim1 );

  let boxView = this.adapterFrom( box );
  let dim2 = this.dimGet( boxView );

  _.assert( dim1 === dim2 );

  debugger;
  //throw _.err( 'not tested' );
  this.fromPoints( boxView, [ center ] );

  this.expand( boxView, radius );

  return box;
}

//

/**
  * Create a cube from cube size centered in origin. Returns the box converted in cube.
  * Box are stored in Array data structure. Cube size stay untouched, box changes.
  *
  * @param { Array } box - box to be converted to cube.
  * @param { Number } size - Cube size.
  *
  * @example
  * // returns [ - 2, - 2, 2, 2 ];
  * _.fromCube( [ 0, 0, 1, 1 ], [ 4, 4 ] );
  *
  * @example
  * // returns [ - 1, - 1, 1, 1 ];
  * _.fromCube( [ 3, 3, 5, 5 ], [ 2, 2 ] );
  *
  * @returns { Array } Returns the array of the new cube.
  * @function fromCube
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( size ) is not a number.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function fromCube( box, size )
{

  if( box === null )
  box = this.make();

  _.assert( _.numberIs( size ) || _.longIs( size ) || _.vectorAdapterIs( size ) );

  let boxView = this.adapterFrom( box );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );
  let dim = this.dimGet( boxView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.numberIs( size ) );

  this.tools.vectorAdapter.assign( min, -size/2 );
  this.tools.vectorAdapter.assign( max, +size/2 );
  // this.tools.vectorAdapter.assignScalar( min, -size/2 );
  // this.tools.vectorAdapter.assignScalar( max, +size/2 );

  return box;
}

//

/**
  * Check if input is a box. Returns true if it is a box and false if not.
  *
  * @param { Array } box - Source box.
  *
  * @example
  * // returns true;
  * _.box.is( [ 0, 0, 1, 1 ] );
  *
  * @returns { Boolean } Returns true if the input is box.
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function is( box )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  // _.assert( !box.some( isNaN ) );
  return ( _.longIs( box ) || _.vectorAdapterIs( box ) ) && ( box.length >= 0 ) && ( box.length % 2 === 0 );
}

//

/**
  * Check if input box is empty. Returns true if it is empty and false if not.
  *
  * @param { Array } box - Source box.
  *
  * @example
  * // returns true;
  * _.isEmpty( [ 1, 1, 0, 0 ] );
  *
  * @returns { Boolean } Returns true if the input is an empty box.
  * @function isEmpty
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function isEmpty( box )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  let boxView = this.adapterFrom( box );
  let dim = this.dimGet( boxView );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );

  for( let d = 0 ; d < dim ; d++ )
  if( min.eGet( d ) >= max.eGet( d ) )
  return true;

  if( dim === 0 )
  return true;

  return false;
}

//

/**
  * Check if input is a zero box. Returns true if it is a zero box and false if not.
  *
  * @param { Array } box - Source box.
  *
  * @example
  * // returns true;
  * _.isZero( [ 1, 1, 1, 1 ] );
  *
  * @returns { Boolean } Returns true if the input is a zero box.
  * @function isZero
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function isZero( box )
{

  _.assert( arguments.length === 1, 'Expects single argument' );

  let boxView = this.adapterFrom( box );
  let dim = this.dimGet( boxView );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );

  for( let d = 0 ; d < dim ; d++ ){
    if( min.eGet( d ) !== max.eGet( d ) )
    return false;
  }
  return true;
}

//

/**
  * Check if input is a nil box. Returns true if it is a nil box and false if not.
  *
  * @param { Array } box - Source box.
  *
  * @example
  * // returns true;
  * _.isNil( [ 2, 2, 1, 1 ] );
  *
  * @returns { Boolean } Returns true if the input is a nil box.
  * @function isNil
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */

function isNil( box )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  let boxView = this.adapterFrom( box );
  let dim = this.dimGet( boxView );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );

  for( let d = 0 ; d < dim ; d++ )
  {
    if( min.eGet( d ) > max.eGet( d ) )
    return true;
  }

  return false;
}

//

/**
  * Get box dimension. Returns the dimension of the box. Box stays untouched.
  *
  * @param { Array } box - The source box.
  *
  * @example
  * // returns 2
  * _.dimGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns 1
  * _.dimGet( [ 0, 1 ] );
  *
  * @returns { Number } Returns the dimension of the box.
  * @function dimGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( box ) is not box.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function dimGet( box )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( this.is( box ) );
  return box.length / 2;
}

//

/**
  * Get the coordinates of the left corner of a box.
  * Returns a vector with the coordinates of the left corner of the box definition. Box stays untouched.
  *
  * @param { Array } box - The source box.
  *
  * @example
  * // returns  0
  * _.cornerLeftGet( [ 0, 2 ] );
  *
  * @example
  * // returns  [ 0, 1 ]
  * _.cornerLeftGet( [ 0, 1, 2, 3 ] );
  *
  * @returns { Vector } Returns a vector with the left corner of the box.
  * @function cornerLeftGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( box ) is not box.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */

function cornerLeftGet( box )
{
  let boxView = this.adapterFrom( box );
  _.assert( arguments.length === 1, 'Expects single argument' );
  return boxView.review([ 0 , box.length / 2 - 1 ]);
}

//

/**
  * Get the coordinates of the right corner of a box.
  * Returns a vector with the coordinates of the right corner of the box definition. Box stays untouched.
  *
  * @param { Array } box - The source box.
  *
  * @example
  * // returns [ 2 ]
  * _.cornerRightGet( [ 0, 2 ] );
  *
  * @example
  * // returns [ 2, 3 ]
  * _.cornerRightGet( [ 0, 1, 2, 3 ] );
  *
  * @returns { Array } Returns a sub-array with the maximun coordinates of the box.
  * @function cornerRightGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( box ) is not box.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */

function cornerRightGet( box )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  let boxView = this.adapterFrom( box );
  return boxView.review([ box.length / 2 , box.length - 1 ]);
}

//

/**
  * Get the center of a box. Returns the center of the box. Box stays untouched.
  *
  * @param { Array } box - The source box.
  * @param { Array } dst - The destination array (optional - sets the type of the returned object).
  *
  * @example
  * // returns [ 1, 1 ]
  * _.centerGet( [ 0, 0, 2, 2 ] , [ 5, 0 ]);
  *
  * @example
  * // returns [ 0.5 ]
  * _.centerGet( [ 0, 1 ] );
  *
  * @returns { Array } Returns the coordinates of the center of the box.
  * @function centerGet
  * @throws { Error } An Error if ( arguments.length ) is different than one or two.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( dst ) is not point.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function centerGet( box , dst )
{

  let boxView = this.adapterFrom( box );
  let dim = this.dimGet( boxView );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );

  if( !dst )
  dst = _.dup( 0, dim ) ;

  let dstv = this.tools.vectorAdapter.from( dst );

  _.assert( dim === dst.length );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  // debugger;
  // throw _.err( 'not tested' );

  this.tools.vectorAdapter.add( dstv.copy( min ), max ).mul( 0.5 );

  // debugger;
  return dst;
}

//

/**
  * Get the size of a box. Returns an array with the length of each side the box.
  * Box stays untouched.
  *
  * @param { Array } box - The source box.
  * @param { Array } dst - The destination array (optional - sets the type of the returned object).
  *
  * @example
  * // returns [ 2, 2 ]
  * _.sizeGet( [ 0, 0, 2, 2 ] , [ 5, 0 ]);
  *
  * @example
  * // returns [ 1 ]
  * _.sizeGet( [ 0, 1 ] );
  *
  * @returns { Array } Returns the lenght of each side of the box.
  * @function sizeGet
  * @throws { Error } An Error if ( arguments.length ) is different than one or two.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( point ) is not point.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function sizeGet( box , dst )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );

  let boxView = this.adapterFrom( box );
  let dim = this.dimGet( boxView );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );

  if( !dst )
  dst = _.dup( 0, dim );
  let dstv = this.tools.vectorAdapter.from( dst );

  _.assert( dim === dst.length );

  this.tools.vectorAdapter.sub( dstv.copy( max ), min );

  return dst;
}

//

/**
  * Returns the coordinates of the corners of a box. Returns an space object where each column is a point.
  * Box stays untouched. Dimensions 0 - 3.
  *
  * @param { Array } box - The source box.
  *
  * @example
  * // returns boxCorners =
  * [ 0, 0, 0, 0, 1, 1, 1, 1,
  *   1, 0, 1, 0, 1, 0, 1, 0,
  *   1, 1, 0, 0, 1, 1, 0, 0,
  * ];
  * _.cornersGet( [ 0, 0, 0, 1, 1, 1 ] );
  *
  * @returns { Matrix } Returns the coordintes of the points in the box corners.
  * @function cornersGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( box ) is not box.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function cornersGet( box )
{
  _.assert( arguments.length === 1 );

  let boxView = this.adapterFrom( box );
  let dim = this.dimGet( boxView );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );

  let corners = _.Matrix.MakeZero( [ dim, Math.pow( 2, dim ) ] );
  let dims = _.Matrix.DimsOf( corners) ;
  let rows = dims[ 0 ];
  let cols = dims[ 1 ];

  for( let i = 0 ; i < cols ; i++)
  {
    for( let j = 0 ; j < rows ; j++)
    {
      if( i < cols/2 )
      {
        corners.scalarSet( [ j, i ], min.eGet( j ) );
        if( 0 < i && i < cols/2 )
        {
          corners.scalarSet( [ i - 1, i ], max.eGet( i - 1 ) );
        }
      }
      else if( i >= cols/2 )
      {
        corners.scalarSet( [ j, i ], max.eGet( j ) );
        if( cols/2 <= i && i < cols - 1 )
        {
          corners.scalarSet( [ i - ( cols/2 ), i ], min.eGet( i - ( cols/2 ) ) );
        }
      }

    }
  }


  return corners;
}

//

/**
  * Expand all sides of a box by the dimensions in the expansion array ( exoansion values are added twice to each side ).
  * Returns the expanded box. Box are stored in Array data structure.
  * The expansion array stays untouched, the box changes.
  *
  * @param { Array } box - box to be expanded.
  * @param { Array } expand - Array of reference with expansion dimensions.
  *
  * @example
  * // returns [ - 1, - 3, 4, 6 ];
  * _.expand( [ 0, 0, 2, 2 ], [ 1, 3 ] );
  *
  * @example
  * // returns [ - 1, - 2, 2, 4 ];
  * _.expand( [ 0, 0, 2, 2 ], [ 1, 2 ] );
  *
  * @returns { Array } Returns the array of the box expanded.
  * @function expand
  * @throws { Error } An Error if ( dim ) is different than expand.length (the box and the expansion array don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( expand ) is not an array.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function expand( box , expand )
{

  if( box === null )
  box = this.make();

  _.assert( _.numberIs( expand ) || _.longIs( expand ) || _.vectorAdapterIs( expand ) );

  let boxView = this.adapterFrom( box );
  let dim = this.dimGet( boxView );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );

  expand = this.tools.vectorAdapter.fromMaybeNumber( expand, dim );

  _.assert( dim === expand.length );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  debugger;
  //throw _.err( 'not tested' );

  this.tools.vectorAdapter.sub( min , expand );
  this.tools.vectorAdapter.add( max , expand );

  return box;
}

//

/**
  * Project a box: the projection vector ( projVector ) translates the center of the box,
  * and the projection scaling factors ( ax, ay, ..., an )
  * scale the sides of the box. The projection parameters should have the shape:
  * project = [ projVector, ax, ay, .., an ];
  * Returns the projected box. Box is stored in Array data structure.
  * The projection array stays untouched, the box changes.
  *
  * @param { Array } box - box to be expanded.
  * @param { Array } project - Array of reference with projection parameters.
  *
  * @example
  * // returns [ 1, 2, 3, 6 ];
  * _.project( [ 0, 0, 2, 2 ], [ [ 1, 3 ], 1, 2 ] );
  *
  * @example
  * // returns [ 0, 0, 2, 2 ];
  * _.expand( [ 0, 0, 2, 2 ], [ [ 0, 0 ], 1, 1 ] );
  *
  * @returns { Array } Returns the array of the projected box.
  * @function project
  * @throws { Error } An Error if ( dim ) is different than project.length / 2 (the box and the projection array don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( project ) is not an array.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function project( box, project )
{

  if( box === null )
  box = this.make();

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.longIs( project ) || _.vectorAdapterIs( project ) );

  let boxView = this.adapterFrom( box );
  let center = this.tools.vectorAdapter.from( this.centerGet( boxView ) );
  let sizes = this.tools.vectorAdapter.from( this.sizeGet( boxView ) );
  let dim = this.dimGet( boxView );
  let projectView = this.tools.vectorAdapter.from( project );

  _.assert( dim === projectView.length - 1 );
  let projVector = this.tools.vectorAdapter.from( projectView.eGet( 0 ) );

  _.assert( dim === projVector.length );

  debugger;
  let newCenter = this.tools.vectorAdapter.add( center, projVector );

  debugger;
  let newSizes = this.tools.vectorAdapter.from( this.tools.longMake/* _.array.makeArrayOfLength */( dim ) );
  for( let i = 0; i < dim; i++ )
  {
    newSizes.eSet( i, sizes.eGet( i ) * projectView.eGet( i + 1 ) );
  }

  boxView = this.fromCenterAndSize( boxView, newCenter, newSizes );
  return box;
}

//

/**
  * Get the projection factors of two boxes: the projection vector ( projVector ) translates the center of the box, and the projection scaling factors ( ax, ay, ..., an )
  * scale the sides of the box. The projection parameters should have the shape:
  * project = [ projVector, ax, ay, .., an ];
  * Returns the projection parameters, 0 when not possible ( i.e: srcBox is a point and projBox is a box - no scaling factors ).
  * Boxes are stored in Array data structure. The boxes stay untouched.
  *
  * @param { Array } srcBox - Original box.
  * @param { Array } projBox - Projected box.
  *
  * @example
  * // returns [ [ 0.5, 0.5 ], 2, 2 ];
  * _.getProjectionFactors( [ 0, 0, 1, 1 ], [ 0.5, 0.5, 2, 2 ] );
  *
  *
  * @returns { Array } Returns the array with the projection factors between the two boxes.
  * @function getProjectionFactors
  * @throws { Error } An Error if ( dim ) is different than ( dim2 ) (the boxes don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( projBox ) is not box.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function getProjectionFactors( srcBox, projBox )
{

  _.assert( this.is( srcBox ), 'Expects box' );
  _.assert( this.is( projBox ), 'Expects box' );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let srcBoxView = this.adapterFrom( srcBox );
  let srcCenter = this.tools.vectorAdapter.from( this.centerGet( srcBoxView ) );
  let srcSizes = this.tools.vectorAdapter.from( this.sizeGet( srcBoxView ) );
  let srcDim = this.dimGet( srcBoxView );

  let projBoxView = this.adapterFrom( projBox );
  let projCenter = this.tools.vectorAdapter.from( this.centerGet( projBoxView ) );
  let projSizes = this.tools.vectorAdapter.from( this.sizeGet( projBoxView ) );
  let projDim = this.dimGet( projBoxView );

  _.assert( srcDim === projDim );

  let project = this.tools.longMake/* _.array.makeArrayOfLength */( srcDim + 1 );
  let projectView = this.tools.vectorAdapter.from( project );

  let translation = this.tools.vectorAdapter.sub( projCenter, srcCenter );

  projectView.eSet( 0, translation.toLong() );

  debugger;
  for( let i = 0; i < srcDim; i++ )
  {
    if( srcSizes.eGet( i ) === 0 )
    {
      if( projSizes.eGet( i ) === 0 )
      {
        projectView.eSet( i + 1, 1 );
      }
      else
      {
        return 0;
      }
    }
    else
    {
      var scalingFactor = projSizes.eGet( i ) / srcSizes.eGet( i );

      projectView.eSet( i + 1, scalingFactor );
    }
  }

  return project;
}

//

/**
  * Check if a given point is contained inside a box. Returs true if it is contained, false if not. Point and box stay untouched.
  *
  * @param { Array } box - The box to check if the point is inside.
  * @param { Array } point - The point to check.
  *
  * @example
  * // returns true
  * _.pointContains( [ 0, 0, 2, 2 ], [ 1, 1 ] );
  *
  * @example
  * // returns false
  * _.pointContains( [ 0, 0, 2, 2 ], [ - 1, 3 ] );
  *
  * @returns { Boolean } Returns true if the point is inside the box, and false if the point is outside it.
  * @function pointContains
  * @throws { Error } An Error if ( dim ) is different than point.length (Box and point have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( point ) is not point.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function pointContains( box , point )
{

  if( box === null )
  box = this.make();

  let boxView = this.adapterFrom( box );
  let dim = this.dimGet( boxView );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );
  let pointView = this.tools.vectorAdapter.from( point );

  _.assert( dim === pointView.length );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( this.tools.vectorAdapter.anyLess( pointView , min ) )
  return false;

  if( this.tools.vectorAdapter.anyGreater( pointView , max ) )
  return false;

  return true;
}

//

/**
  *Calulate distance between point and box ( distance between point and nearest point in box ). Returns distance value.
  * Point and box stay untouched.
  *
  * @param { Array } box - source box.
  * @param { Array } point - source point.
  *
  * @example
  * // returns 1;
  * _.pointDistance( [ 0, 0, 2, 2 ], [ 0, 3 ] );
  *
  * @example
  * // returns 0;
  * _.pointDistance( [ 0, 0, 2, 2 ], [ 1, 1 ] );
  *
  * @returns { Number } Returns the distance between the point and the nearest point in the box.
  * @function pointDistance
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the point and the box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box
  * @throws { Error } An Error if ( point ) is not point
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function pointDistance( box , point )
{

  if( box === null )
  box = this.make();

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  debugger;
  //  throw _.err( 'not tested' );

  let clamped = this.pointClosestPoint( box, point );
  return this.tools.avector.distance( point, clamped );

  debugger;
}

//

/**
  * Clamp a point to a box. Returns the clamped point. Box and point stay unchanged.
  *
  * @param { Array } box - The source box.
  * @param { Array } point - The point to be clamped against the box.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns [ 0, 2 ]
  * _.pointClosestPoint( [ 0, 0, 2, 2 ], [ 0, 3 ] );
  *
  * @example
  * // returns [ 0, 1 ]
  * _.pointClosestPoint( [ 0, 0, 2, 2 ], [ 0, 1 ] );
  *
  * @returns { Array } Returns an array with the coordinates of the clamped point.
  * @function pointClosestPoint
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the box and the point don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( point ) is not point.
  * @throws { Error } An Error if ( dstPoint ) is not dstPoint.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function pointClosestPoint( box , point, dstPoint )
{

  if( box === null )
  box = this.make();

  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = point.slice();

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let boxView = this.adapterFrom( box );
  let dim = this.dimGet( boxView );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );
  let pointVector = this.tools.vectorAdapter.from( point.slice() );
  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dim === point.length );


  debugger;
  //  throw _.err( 'not tested' );
  let v = this.tools.vectorAdapter.clamp( pointVector, min, max );

  for( let i = 0; i < pointVector.length; i++ )
  {
    dstPointView.eSet( i, v.eGet( i ) );
    debugger;
  }

  return dstPoint;
}

//

/**
  *Expand box by point. Returns the expanded box. Box are stored in Array data structure. Point stays untouched, dstBox changes.
  *
  * @param { Array } dstBox - box to be expanded.
  * @param { Array } point - Point of reference with expansion dimensions.
  *
  * @example
  * // returns [ 0, 0, 3, 3 ];
  * _.pointExpand( [ 0, 0, 2, 2 ], [ 1, 3 ] );
  *
  * @example
  * // returns [ 0, 0, 2, 2 ];
  * _.pointExpand( [ 0, 0, 2, 2 ], [ 1, 2 ] );
  *
  * @returns { Array } Returns the array of the box expanded.
  * @function pointExpand
  * @throws { Error } An Error if ( dim ) is different than point.length (the box and the point don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( point ) is not point.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function pointExpand( dstBox , point )
{

  if( dstBox === null )
  dstBox = this.makeSingular();

  _.assert( _.longIs( point ) || _.vectorAdapterIs( point ) );

  let boxView = this.adapterFrom( dstBox );
  let dim = this.dimGet( boxView );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );
  let pointView = this.tools.vectorAdapter.from( point );

  _.assert( dim === pointView.length );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  this.tools.vectorAdapter.min( min , pointView );
  this.tools.vectorAdapter.max( max , pointView );

  return dstBox;
}

//

/**
  * Get the relative coordinates of a point regarding a given box. Returns the point in relative coordinates.
  * Source box remains untouched.
  *
  * @param { Array } box - Source box.
  * @param { Array } point - The point to calculate its relative reference.
  *
  * @example
  * // returns [ 0.5, 1 ]
  * _.pointRelative( [ 0, 0, 2, 2 ], [ 1, 2 ] );
  *
  * @example
  * // returns [ - 1.5, 2 ]
  * _.pointRelative( [ 0, 0, 2, 2 ], [ - 3, 4 ] );
  *
  * @returns { Array } Returns the relative coordinates of the point against the box coordinates.
  * @function pointRelative
  * @throws { Error } An Error if ( dim ) is different than point.length (Box and point have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( point ) is not point.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function pointRelative( box , point, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  if( box === null )
  box = this.make();

  if( arguments.length === 2 )
  dstPoint = point.slice();

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let boxView = this.adapterFrom( box );
  let dim = this.dimGet( boxView );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );
  let pointVector = this.tools.vectorAdapter.from( point );
  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dim === point.length );
  _.assert( dim === dstPoint.length );

  debugger;
  // throw _.err( 'not tested' );

  this.tools.vectorAdapter.div( this.tools.vectorAdapter.sub( dstPointView , min ) , this.tools.vectorAdapter.sub( max.clone() , min ) );

  return dstPoint;
}

//

/**
  *Check if the source box contains tested box.
  *Returns true if it is contained, false if not. Box are stored in Array data structure. Source and tested boxes remain unchanged
  *
  * @param { Array } srcBox - The source box (container).
  * @param { Array } tstBox - The tested box (the box to check if it is contained in srcBox).
  *
  * @example
  * // returns true
  * _.boxContains( [ 0, 0, 2, 2 ], [ 0.5, 0.5, 1, 1 ] );
  *
  * @example
  * // returns false
  * _.boxContains( [ 0, 0, 2, 2 ], [ 0, 0, 1, 2.5 ] );
  *
  * @returns { Boolean } Returns true if the box is contained and false if not.
  * @function boxContains
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the two boxes don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstBox ) or ( srcBox ) is not box
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function boxContains( box , box2 )
{

  let boxView = this.adapterFrom( box2 );
  let dim = this.dimGet( boxView );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( dim === this.dimGet( box ) );

  if( !this.pointContains( box, min ) )
  return false;

  if( !this.pointContains( box, max ) )
  return false;

  return true;
}

//

/**
  *Check if srcBox intersects with tstBox. Returns true if the boxes intersect, false if not.
  * Box are stored in Array data structure. Source box and Test box stay untouched.
  *
  * @param { Array } srcBox - Source box
  * @param { Array } tstBox - Test box to check if it intersects
  *
  * @example
  * // returns true
  * _.boxIntersects( [ 0, 0, 2, 2 ], [ 1, 1, 3, 3 ] );
  *
  * @example
  * // returns false
  * _.boxIntersects( [ 0, 0, 2, 2 ], [ 3, 3, 4, 4 ] );
  *
  * @returns { Boolean } Returns true if the boxes intersect and false if not.
  * @function boxIntersects
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the two boxes have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function boxIntersects( srcBox , tstBox )
{
  let srcBoxView = this.adapterFrom( srcBox );
  let srcDim = this.dimGet( srcBoxView );
  let srcMin = this.cornerLeftGet( srcBoxView );
  let srcMax = this.cornerRightGet( srcBoxView );

  let tstBoxView = this.adapterFrom( tstBox );
  let tstDim = this.dimGet( tstBoxView );
  let tstMin = this.cornerLeftGet( tstBoxView );
  let tstMax = this.cornerRightGet( tstBoxView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( tstDim === srcDim );

  debugger;
  // throw _.err( 'not tested' );

  let intTrue = 0;

  for( let i = 0; i < srcDim; i++ )
  {
    let inter = false;
    if( srcMin.eGet( i ) <= tstMin.eGet( i ) && tstMin.eGet( i ) <= srcMax.eGet( i ) )
    inter = true;
    else if( srcMin.eGet( i ) <= tstMax.eGet( i ) && tstMax.eGet( i ) <= srcMax.eGet( i ) )
    inter = true;
    else if( tstMin.eGet( i ) <= srcMin.eGet( i ) && srcMin.eGet( i ) <= tstMax.eGet( i ) )
    inter = true;
    else if( tstMin.eGet( i ) <= srcMax.eGet( i ) && srcMax.eGet( i ) <= tstMax.eGet( i ) )
    inter = true;

    if( inter === true )
    intTrue = intTrue + 1;
  }

  if( intTrue === srcDim )
  return true;

  return false;
}

//

/**
  * Calculates the distance between two boxes. Returns the distance value, 0 if intersection.
  * Box are stored in Array data structure. Source box and Test box stay untouched.
  *
  * @param { Array } srcBox - Source box
  * @param { Array } tstBox - Test box to calculate the distance
  *
  * @example
  * // returns 0
  * _.boxDistance( [ 0, 0, 2, 2 ], [ 1, 1, 3, 3 ] );
  *
  * @example
  * // returns 1
  * _.boxDistance( [ 0, 0, 2, 2 ], [ 0, 3, 2, 4 ] );
  *
  * @returns { Number } Returns the distance between the two boxes.
  * @function boxDistance
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the two boxes have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function boxDistance( srcBox , tstBox )
{

  let srcBoxView = this.adapterFrom( srcBox );
  let srcDim = this.dimGet( srcBoxView );
  let srcMin = this.cornerLeftGet( srcBoxView );
  let srcMax = this.cornerRightGet( srcBoxView );

  let tstBoxView = this.adapterFrom( tstBox );
  let tstDim = this.dimGet( tstBoxView );
  let tstMin = this.cornerLeftGet( tstBoxView );
  let tstMax = this.cornerRightGet( tstBoxView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( tstDim === srcDim );

  debugger;
  // throw _.err( 'not tested' );

  /* src corners */
  let c =  this.cornersGet( srcBoxView );

  /* tst box corners */
  let c1 =  this.cornersGet( tstBoxView );

  let distance = Infinity;
  for( let j = 0 ; j < _.Matrix.DimsOf( c )[ 1 ] ; j++ )
  {
    let srcCorner = c.colGet( j );
    let tstCorner = c1.colGet( j );
    let dSrc = this.pointDistance( srcBox, tstCorner );
    let dTst = this.pointDistance( tstBox, srcCorner );

    let d;
    if( dSrc < dTst )
      d = dSrc;
    else
      d = dTst;
    if( d < distance )
    {
      distance = d;
    }

  }

  if( this.boxIntersects( srcBox , tstBox ) === true )
    return 0;
  else
    return distance;
}

//

/**
  * Calculates the closest point in a box. Returns the closest point coordinates.
  * Box are stored in Array data structure. Source box and Test box stay untouched.
  *
  * @param { Array } srcBox - Source box
  * @param { Array } tstBox - Test box to calculate the closest point in it.
  * @param { Array } dstPoint - Destination point
  *
  * @example
  * // returns 0
  * _.boxClosestPoint( [ 0, 0, 2, 2 ], [ 1, 1, 3, 3 ] );
  *
  * @example
  * // returns [ 3, 3 ]
  * _.boxClosestPoint( [ 0, 0, 2, 2 ], [ 3, 3, 4, 4 ] );
  *
  * @returns { Array } Returns the coordinates of the closest point.
  * @function boxClosestPoint
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the two boxes have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */

function boxClosestPoint( srcBox , tstBox, dstPoint )
{

  let srcBoxView = this.adapterFrom( srcBox );
  let srcDim = this.dimGet( srcBoxView );
  let srcMin = this.cornerLeftGet( srcBoxView );
  let srcMax = this.cornerRightGet( srcBoxView );

  let tstBoxView = this.adapterFrom( tstBox );
  let tstDim = this.dimGet( tstBoxView );
  let tstMin = this.cornerLeftGet( tstBoxView );
  let tstMax = this.cornerRightGet( tstBoxView );

  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  _.assert( tstDim === srcDim );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( tstDim );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  _.assert( tstDim === dstPoint.length );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  debugger;
  // throw _.err( 'not tested' );

  if( this.boxIntersects( srcBox , tstBox ) === true )
    return 0;
  else{

    /* src corners */
    let c = this.cornersGet( srcBoxView );

    /* tst box corners */
    let c1 = this.cornersGet( tstBoxView );

    let distance = Infinity;
    let point = this.tools.vectorAdapter.from( dstPointView.slice() );
    for( let j = 0 ; j < 8 ; j++ )
    {
      let srcCorner = c.colGet( j );
      let tstCorner = c1.colGet( j );
      let dSrc = this.pointDistance( srcBox, tstCorner );
      let dTst = this.pointDistance( tstBox, srcCorner );

      if( dSrc < dTst && dSrc <= distance )
      {
        distance = dSrc;
        point = tstCorner;
      }
      else if( dTst <= dSrc && dTst <= distance )
      {
        distance = dTst;
        point = this.pointClosestPoint( tstBox, srcCorner, point );
      }
    }

    for( let i = 0; i < tstDim; i++ )
    {
      dstPointView.eSet( i, point.eGet( i ) );
      debugger;
    }

    return dstPoint;
  }

}

//

/**
  *Expand destination box by source box. Returns destination box. Box are stored in Array data structure. Source box stays untouched.
  *
  * @param { Array } dstBox - box to be expanded.
  * @param { Array } srcBox - source box with expansion dimensions.
  *
  * @example
  * // returns [ 0, 0, 3, 3 ];
  * _.boxExpand( [ 0, 0, 2, 2 ], [ 1, 1, 3, 3 ] );
  *
  * @example
  * // returns [ 0, 0, 2, 2 ];
  * _.boxExpand( [ 0, 0, 2, 2 ], [ 1, 1, 2, 2 ] );
  *
  * @returns { Array } Returns the array of the expanded box, that contains new element ( src box ).
  * @function boxExpand
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the two boxes have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstBox ) or ( srcBox ) is not box
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function boxExpand( dstBox , srcBox )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let _dstBox = this.adapterFrom( dstBox );
  let dim1 = this.dimGet( _dstBox );
  let min1 = this.cornerLeftGet( _dstBox );
  let max1 = this.cornerRightGet( _dstBox );

  _.assert( this.is( srcBox ) );
  let _srcBox = this.adapterFrom( srcBox );
  let dim2 = this.dimGet( _srcBox );
  let min2 = this.cornerLeftGet( _srcBox );
  let max2 = this.cornerRightGet( _srcBox );

  _.assert( dim1 === dim2 );

  this.tools.vectorAdapter.min( min1 , min2 );
  this.tools.vectorAdapter.max( max1 , max2 );

  return dstBox;
}

//

/**
  * Check if a given capsule is contained inside a box. Returs true if it is contained, false if not. Capsule and box stay untouched.
  *
  * @param { Array } box - The box to check if the capsule is inside.
  * @param { Array } capsule - The capsule to check.
  *
  * @example
  * // returns true
  * _.capsuleContains( [ 0, 0, 2, 2 ], [ 1, 1, 1.5, 1.5, 0.1 ] );
  *
  * @example
  * // returns false
  * _.capsuleContains( [ 0, 0, 2, 2 ], [ - 1, 3, 3, 3, 1 ] );
  *
  * @returns { Boolean } Returns true if the capsule is inside the box, and false if the capsule is outside it.
  * @function capsuleContains
  * @throws { Error } An Error if ( dim ) is different than capsule.length (Box and capsule have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( capsule ) is not capsule.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */


function capsuleContains( box, capsule )
{

  if( box === null )
  box = this.make();

  let boxView = this.adapterFrom( box );
  let dimB = this.dimGet( boxView );
  let capsuleView = this.tools.capsule.adapterFrom( capsule );
  let dimC = this.tools.capsule.dimGet( capsuleView );
  let origin = this.tools.vectorAdapter.from( this.tools.capsule.originGet( capsuleView ) );
  let end = this.tools.vectorAdapter.from( this.tools.capsule.endPointGet( capsuleView ) );
  let radius = this.tools.capsule.radiusGet( capsuleView );

  _.assert( dimB === dimC );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let bottomSphere = this.tools.sphere.fromCenterAndRadius( null, origin, radius );
  let topSphere = this.tools.sphere.fromCenterAndRadius( null, end, radius );

  if( !this.sphereContains( boxView, bottomSphere ) )
  return false;

  if( !this.sphereContains( boxView, topSphere ) )
  return false;

  return true;
}

//

function capsuleIntersects( srcBox , tstCapsule )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstCapsuleView = this.tools.capsule.adapterFrom( tstCapsule );
  let boxView = this.adapterFrom( srcBox );

  let gotBool = this.tools.capsule.boxIntersects( tstCapsuleView, boxView );
  return gotBool;
}

//

function capsuleDistance( srcBox , tstCapsule )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstCapsuleView = this.tools.capsule.adapterFrom( tstCapsule );
  let boxView = this.adapterFrom( srcBox );

  let gotDist = this.tools.capsule.boxDistance( tstCapsuleView, boxView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a box to a capsule. Returns the calculated point.
  * Box and capsule remain unchanged
  *
  * @param { Array } box - The source box.
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
  * @throws { Error } An Error if ( box ) is not box
  * @throws { Error } An Error if ( capsule ) is not capsule
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function capsuleClosestPoint( box, capsule, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let boxView = this.adapterFrom( box );
  let dimB = this.dimGet( boxView );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimB );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let capsuleView = this.tools.capsule.adapterFrom( capsule );
  let dimCapsule  = this.tools.capsule.dimGet( capsuleView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimB === dstPoint.length );
  _.assert( dimB === dimCapsule );

  if( this.tools.capsule.boxIntersects( capsuleView, boxView ) )
  return 0
  else
  {
    let capsulePoint = this.tools.capsule.boxClosestPoint( capsule, boxView );

    let boxPoint = this.tools.vectorAdapter.from( this.pointClosestPoint( boxView, capsulePoint ) );

    for( let i = 0; i < dimB; i++ )
    {
      dstPointView.eSet( i, boxPoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

/**
  * Check if a given convex polygon is contained inside a box. Returs true if it is contained, false if not. Polygon and box stay untouched.
  *
  * @param { Array } box - The box to check if the convex polygon is inside.
  * @param { Polygon } convex polygon - The convex polygon to check.
  *
  * @example
  * // returns true
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([ 0,   1,   1,   0,
  *     0,   1,   1,   0,
  *     0,   1,   3,   3 ] );
  * _.convexPolygonContains( [ 0, 0, 0, 3, 3, 3 ], polygon );
  *
  * @returns { Boolean } Returns true if the convexPolygon is inside the box, and false if not.
  * @function convexPolygonContains
  * @throws { Error } An Error if ( dim ) is different than convexPolygon.length (Box and polygon don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( convexPolygon ) is not convexPolygon.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */


function convexPolygonContains( box, polygon )
{

  if( box === null )
  box = this.make();

  let boxView = this.adapterFrom( box );
  let dimB = this.dimGet( boxView );
  let dimP =  _.Matrix.DimsOf( polygon );

  _.assert( dimB === dimP[ 0 ] );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  for( let i = 0; i < dimP[ 1 ]; i++ )
  {
    let vertex = polygon.colGet( i );
    if( !this.pointContains( boxView, vertex ) )
    return false;
  }

  return true;
}

//

function convexPolygonIntersects( srcBox , polygon )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.convexPolygon.is( polygon ) );
  let boxView = this.adapterFrom( srcBox );

  let gotBool = this.tools.convexPolygon.boxIntersects( polygon, boxView );

  return gotBool;
}

//

function convexPolygonDistance( srcBox , polygon )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.convexPolygon.is( polygon ) );
  let boxView = this.adapterFrom( srcBox );

  let gotDist = this.tools.convexPolygon.boxDistance( polygon, boxView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a box to a convex polygon. Returns the calculated point.
  * Box and polygon remain unchanged
  *
  * @param { Array } box - The source box.
  * @param { Polygon } polygon - The source polygon.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns [ 1.5, 1.5, 1.5 ]
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([
  *    0,   0,   0,   0,
  *    1,   0, - 1,   0,
  *    0,   1,   0, - 1
  *  ]);
  * _.convexPolygonClosestPoint( [ 1.5, 1.5, 1.5, 2, 2, 2 ], polygon );
  *
  * @returns { Array } Returns the closest point to the polygon.
  * @function convexPolygonClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( box ) is not box
  * @throws { Error } An Error if ( polygon ) is not convexPolygon
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function convexPolygonClosestPoint( box, polygon, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  _.assert( _.convexPolygon.is( polygon ) );

  let boxView = this.adapterFrom( box );
  let dimB = this.dimGet( boxView );

  if( arguments.length === 2 )
  dstPoint = this.tools.longMake/* _.array.makeArrayOfLength */( dimB );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let dimP  = _.Matrix.DimsOf( polygon );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimB === dstPoint.length );
  _.assert( dimP[ 0 ] === dimB );

  if( this.tools.convexPolygon.boxIntersects( polygon, boxView ) )
  return 0
  else
  {
    let polygonPoint = this.tools.convexPolygon.boxClosestPoint( polygon, boxView );

    let boxPoint = this.tools.vectorAdapter.from( this.pointClosestPoint( boxView, polygonPoint ) ) ;

    for( let i = 0; i < dimB; i++ )
    {
      dstPointView.eSet( i, boxPoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

/**
  * Check if a box contains a frustum. Returns true if it is contained, false if not.
  * Box and frustum remain unchanged
  *
  * @param { Array } box - The source box (container).
  * @param { Matrix } frustum - The tested frustum (the frustum to check if it is contained in box).
  *
  * @example
  * // returns true
  * let frustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ]
  * );
  * _.frustumContains( [ 0, 0, 0, 2, 2, 2 ], frustum );
  *
  * @example
  * // returns false
  * _.frustumContains( [ 2, 2, 2, 3, 3, 3 ], frustum );
  *
  * @returns { Boolean } Returns true if the frustum is contained and false if not.
  * @function frustumContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box
  * @throws { Error } An Error if ( frustum ) is not frustum
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function frustumContains( box, frustum )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( frustum ) );
  let boxView = this.adapterFrom( box );
  let dim = this.dimGet( boxView );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );
  let dims = _.Matrix.DimsOf( frustum );
  _.assert( dim = dims[ 0 ], 'Frustum and box must have same dim');

  let fpoints = this.tools.frustum.cornersGet( frustum );
  let dimsPoints = _.Matrix.DimsOf( fpoints );
  _.assert( _.matrixIs( fpoints ) );

  for( let i = 0 ; i < dimsPoints[ 1 ] ; i += 1 )
  {
    let point = fpoints.colGet( i );

    if( this.pointContains( box, point ) !== true )
    {
      return false;
    }
  }
  return true;
}

//

/**
  * Check if a box and a frustum intersect. Returns true if they intersect, false if not.
  * Box and frustum remain unchanged
  *
  * @param { Array } box - The source box.
  * @param { Matrix } frustum - The tested frustum.
  *
  * @example
  * // returns true
  * let frustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ]
  * );
  * _.frustumIntersects( [ 0, 0, 0, 2, 2, 2 ], frustum );
  *
  * @example
  * // returns false
  * _.frustumIntersects( [ 2, 2, 2, 3, 3, 3 ], frustum );
  *
  * @returns { Boolean } Returns true if the frustum and the box intersect.
  * @function frustumIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box
  * @throws { Error } An Error if ( frustum ) is not frustum
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function frustumIntersects( box, frustum )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( frustum ) );
  let boxView = this.adapterFrom( box );

  let gotBool = this.tools.frustum.boxIntersects( frustum, boxView );
  return gotBool;
}

//

/**
  * Calculates the distance between a box and a frustum. Returns the calculated distance.
  * Box and frustum remain unchanged
  *
  * @param { Array } box - The source box.
  * @param { Matrix } frustum - The source frustum.
  *
  * @example
  * // returns 0
  * let frustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);
  * _.frustumDistance( [ 0, 0, 0, 2, 2, 2 ], frustum );
  *
  * @example
  * // returns 1
  * _.frustumDistance( [ 2, 2, 2, 3, 3, 3 ], frustum );
  *
  * @returns { Number } Returns the distance between the box and the point.
  * @function frustumDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box
  * @throws { Error } An Error if ( frustum ) is not frustum
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function frustumDistance( box, frustum )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( frustum ) );

  let boxView = this.adapterFrom( box );

  let dim = this.dimGet( boxView );
  _.assert( dim === 3 );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );

  if( this.tools.frustum.boxIntersects( frustum, boxView ) )
  return 0;

  let frustumPoint = this.tools.frustum.boxClosestPoint( frustum, boxView );

  /* box corners */
  let c = this.cornersGet( boxView );

  let distance = Infinity;
  for( let j = 0 ; j < _.Matrix.DimsOf( c )[ 1 ] ; j++ )
  {
    let corner = c.colGet( j );
    let proj = this.tools.frustum.pointClosestPoint( frustum, corner );
    let d = this.tools.avector.distance( corner, frustumPoint );
    if( d < distance )
    {
      distance = d;
    }
  }

  return distance;
}

//

/**
  * Calculates the closest point in a box to a frustum. Returns the calculated point.
  * Box and frustum remain unchanged
  *
  * @param { Array } box - The source box.
  * @param { Matrix } frustum - The source frustum.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * let frustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ]
  * );
  * _.frustumClosestPoint( [ 0, 0, 0, 2, 2, 2 ], frustum );
  *
  * @example
  * // returns [ 2, 2, 2 ]
  * _.frustumClosestPoint [ 2, 2, 2, 3, 3, 3 ], frustum );
  *
  * @returns { Array } Returns the closest point to the frustum.
  * @function frustumClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( box ) is not box
  * @throws { Error } An Error if ( frustum ) is not frustum
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function frustumClosestPoint( box, frustum, dstPoint )
{
  _.assert( _.frustum.is( frustum ) );

  let boxView = this.adapterFrom( box );
  let dimB = this.dimGet( boxView );
  _.assert( dimB === 3 );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimB );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  _.assert( dimB === 3 );
  _.assert( dimB === dstPoint.length );

  if( this.tools.frustum.boxIntersects( frustum, boxView ) )
  return 0
  else
  {
    let frustumPoint = this.tools.frustum.boxClosestPoint( frustum, boxView );

    /* box corners */
    let c = this.cornersGet( boxView );

    let distance = Infinity;
    let point = [ 0, 0, 0 ];
    for( let j = 0 ; j < _.Matrix.DimsOf( c )[ 1 ] ; j++ )
    {
      let corner = c.colGet( j );
      let d = this.tools.avector.distance( corner, frustumPoint ); /* qqq : why slice??? */
      if( d < distance )
      {
        distance = d;
        point = corner; /* qqq : no clone principle */
      }
    }

    for( let i = 0; i < dimB; i++ )
    {
      dstPointView.eSet( i, point.eGet( i ) );
    }

    return dstPoint;
  }

}

//

/**
  * Expand a box with a frustum. Returns the expanded box.
  * Frustum remains unchanged
  *
  * @param { Array } dstBox - The destination box.
  * @param { Matrix } srcFrustum - The source frustum.
  *
  * @example
  * // returns [ 0, 0, 0, 2, 2, 2 ]
  * let frustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ]
  * );
  * _.frustumExpand( [ 0, 0, 0, 2, 2, 2 ], frustum );
  *
  * @example
  * // returns [ 0, 0, 0, 3, 3, 3 ]
  * _.frustumExpand( [ 2, 2, 2, 3, 3, 3 ], frustum );
  *
  * @returns { Array } Returns the expanded box.
  * @function frustumExpand
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstBox ) is not box
  * @throws { Error } An Error if ( srcFrustum ) is not frustum
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */

function frustumExpand( dstBox, srcFrustum )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( srcFrustum ) );

  let boxView = this.adapterFrom( dstBox );

  let dim = this.dimGet( boxView );
  _.assert( dim === 3 );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );

  let fpoints = this.tools.frustum.cornersGet( srcFrustum );
  _.assert( _.matrixIs( fpoints ) );
  _.assert( fpoints.hasShape([ 3, 8 ] ) );

  for( let j = 0 ; j < 8 ; j++ )
  {
    let newp = fpoints.colGet( j );
    boxView = this.pointExpand( boxView, newp );
  }

  return dstBox;
}

//

function lineIntersects( srcBox , tstLine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstLineView = this.tools.linePointDir.adapterFrom( tstLine );
  let boxView = this.adapterFrom( srcBox );

  let gotBool = this.tools.linePointDir.boxIntersects( tstLineView, boxView );
  return gotBool;
}

//

function lineDistance( srcBox , tstLine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstLineView = this.tools.linePointDir.adapterFrom( tstLine );
  let boxView = this.adapterFrom( srcBox );

  let gotDist = this.tools.linePointDir.boxDistance( tstLineView, boxView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a box to a line. Returns the calculated point.
  * Box and line remain unchanged
  *
  * @param { Array } box - The source box.
  * @param { Array } line - The source line.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * let line = [ 0, 0, 0, - 1, - 1, - 1 ]
  * _.lineClosestPoint( [ 0, 0, 0, 2, 2, 2 ], line );
  *
  * @example
  * // returns [ 2, 2, 2 ]
  * _.lineClosestPoint( [ 2, 2, 2, 3, 3, 3 ], line );
  *
  * @returns { Array } Returns the closest point to the line.
  * @function lineClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( box ) is not box
  * @throws { Error } An Error if ( line ) is not line
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function lineClosestPoint( box, line, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let boxView = this.adapterFrom( box );
  let dimB = this.dimGet( boxView );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimB );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let lineView = this.tools.linePointDir.adapterFrom( line );
  let origin = this.tools.linePointDir.originGet( lineView );
  let direction = this.tools.linePointDir.directionGet( lineView );
  let dimLine  = this.tools.linePointDir.dimGet( lineView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimB === dstPoint.length );
  _.assert( dimB === dimLine );

  if( this.tools.linePointDir.boxIntersects( lineView, boxView ) )
  return 0
  else
  {
    let linePoint = this.tools.linePointDir.boxClosestPoint( line, boxView );

    let boxPoint = this.tools.vectorAdapter.from( this.pointClosestPoint( boxView, linePoint ) );

    for( let i = 0; i < dimB; i++ )
    {
      dstPointView.eSet( i, boxPoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

function rayIntersects( srcBox , tstRay )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstRayView = this.tools.ray.adapterFrom( tstRay );
  let boxView = this.adapterFrom( srcBox );

  let gotBool = this.tools.ray.boxIntersects( tstRayView, boxView );

  return gotBool;
}

//

function rayDistance( srcBox , tstRay )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstRayView = this.tools.ray.adapterFrom( tstRay );
  let boxView = this.adapterFrom( srcBox );

  let gotDist = this.tools.ray.boxDistance( tstRayView, boxView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a box to a ray. Returns the calculated point.
  * Box and ray remain unchanged
  *
  * @param { Array } box - The source box.
  * @param { Array } ray - The source ray.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * let ray = [ 0, 0, 0, - 1, - 1, - 1 ]
  * _.rayClosestPoint( [ 0, 0, 0, 2, 2, 2 ], ray );
  *
  * @example
  * // returns [ 2, 2, 2 ]
  * _.rayClosestPoint( [ 2, 2, 2, 3, 3, 3 ], ray );
  *
  * @returns { Array } Returns the closest point to the ray.
  * @function rayClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( box ) is not box
  * @throws { Error } An Error if ( ray ) is not ray
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function rayClosestPoint( box, ray, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let boxView = this.adapterFrom( box );
  let dimB = this.dimGet( boxView );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimB );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let rayView = this.tools.ray.adapterFrom( ray );
  let origin = this.tools.ray.originGet( rayView );
  let direction = this.tools.ray.directionGet( rayView );
  let dimRay  = this.tools.ray.dimGet( rayView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimB === dstPoint.length );
  _.assert( dimB === dimRay );

  if( this.tools.ray.boxIntersects( rayView, boxView ) )
  return 0
  else
  {
    let rayPoint = this.tools.ray.boxClosestPoint( ray, boxView );

    let boxPoint = this.tools.vectorAdapter.from( this.pointClosestPoint( boxView, rayPoint ) );

    for( let i = 0; i < dimB; i++ )
    {
      dstPointView.eSet( i, boxPoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

/**
  *Check if the source box intersects with test plane. Returns true if it they intersect, false if not.
  * Box and plane are stored in Array data structure and remain unchanged
  *
  * @param { Array } srcBox - The source box.
  * @param { Array } tstPlane - The tested plane.
  *
  * @example
  * // returns true
  * _.planeIntersects( [ 0, 0, 0, 2, 2, 2 ], [ 1, 0, 0, -1 ] );
  *
  * @example
  * // returns false
  * _.planeIntersects( [ 0, 0, 0, 2, 2, 2 ], [ 1, 0, 0, 1 ] );
  *
  * @returns { Boolean } Returns true if the plane and the box intersect.
  * @function planeIntersects
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the box and plane don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcBox ) is not box
  * @throws { Error } An Error if ( tstPlane ) is not plane
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */

function planeIntersects( srcBox , tstPlane )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let _tstPlane = this.tools.plane.adapterFrom( tstPlane );
  let boxView = this.adapterFrom( srcBox );

  let gotBool = this.tools.plane.boxIntersects( _tstPlane, boxView );

  return gotBool;
}

//

/**
  * Calculates the distance between a plane and a box. Returns the distance between the two elements.
  * The box and the plane remain unchanged.
  *
  * @param { Array } srcBox - Source box.
  * @param { Array } plane - Source plane.
  *
  * @example
  * // returns 0;
  * _.planeDistance( [ 1, 0, 0, 1 ] , [ -1, 2, 2, -1, 2, 8 ]);
  *
  * @example
  * // returns 3;
  * _.planeDistance( [ 0, 1, 0, 1 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Number } Returns the distance between the plane and the box.
  * @function planeDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the plane and box don´t have the same dimension).
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function planeDistance( srcBox, plane )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let boxView = this.adapterFrom( srcBox );
  let dimB = this.dimGet( boxView );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );

  let planeView = this.tools.plane.adapterFrom( plane );
  let dimP = this.tools.plane.dimGet( planeView );

  _.assert( dimP === dimB );

  if( this.tools.plane.boxIntersects( planeView, boxView ) )
    return 0;
  else
  {
    /* box corners */
    let c = this.cornersGet( boxView );

    let distance = Infinity;
    let d = 0;
    for( let j = 0 ; j < _.Matrix.DimsOf( c )[ 1 ]  ; j++ )
    {
      let corner = c.colGet( j );
      d = Math.abs( this.tools.plane.pointDistance( plane, corner ) );

      if( d < distance )
      {
        distance = d;
      }
    }

    return distance;
  }
}

//

/**
  * Get the closest point in a box to a plane. Returns the closest point. Box and plane stay untouched.
  *
  * @param { Array } box - The source box.
  * @param { Array } plane - The source plane.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns [ 0, 2 ]
  * _.planeClosestPoint( [ 0, 0, 2, 2 ], [ 0, 3 ] );
  *
  * @example
  * // returns [ 0, 1 ]
  * _.planeClosestPoint( [ 0, 0, 2, 2 ], [ 0, 1 ] );
  *
  * @returns { Array } Returns an array with the coordinates of the closest point.
  * @function planeClosestPoint
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the box and the plane don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( box ) is not box.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( dstPoint ) is not dstPoint.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */

function planeClosestPoint( srcBox, plane, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let boxView = this.adapterFrom( srcBox );
  let dimB = this.dimGet( boxView );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );

  let planeView = this.tools.plane.adapterFrom( plane );
  let dimP = this.tools.plane.dimGet( planeView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimB );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimP === dimB );
  _.assert( dimP === dstPoint.length );

  if( this.tools.plane.boxIntersects( planeView, boxView ) )
    return 0;
  else
  {
    /* box corners */
    let c = this.cornersGet( boxView );

    let distance = Infinity;
    let d = 0;
    let point = this.tools.long.make( dimB );
    for( let j = 0 ; j < _.Matrix.DimsOf( c )[ 1 ] ; j++ )
    {
      let corner = c.colGet( j );
      d = Math.abs( this.tools.plane.pointDistance( plane, corner ) );

      if( d < distance )
      {
        distance = d;
        point = corner;
      }
    }

    for( let i = 0; i < point.length; i++ )
    {
      dstPointView.eSet( i, point.eGet( i ) );
    }

    return dstPoint;
  }
}

//

/**
  * Expand a box with a plane equation. Returns the expanded box.
  * Plane stay untouched, box changes.
  *
  * @param { Array } dstBox - The destination box.
  * @param { Array } srcPlane - The source plane.
  *
  * @example
  * // returns [ -1, -1, -1, 2, 2, 2 ]
  * _.planeExpand( [ 0, 0, 0, 2, 2, 2 ], [ 1, 0, 0, 1 ] );
  *
  * @example
  * // returns [ 0, 0, 0, 2, 2, 2 ]
  * _.planeExpand( [ 0, 0, 0, 2, 2, 2 ], [ 1, 0, 0, 0 ] );
  *
  * @returns { Array } Returns an array with the coordinates of the expanded box.
  * @function planeExpand
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the box and the plane don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstBox ) is not box.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */

function planeExpand( dstBox, srcPlane )
{
  _.assert( arguments.length === 2, 'Expects two arguments' );

  let boxView = this.adapterFrom( dstBox );
  let dimB = this.dimGet( boxView );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );

  _.assert( _.plane.is( srcPlane ) );

  let planeView = this.tools.plane.adapterFrom( srcPlane );
  let dimP = this.tools.plane.dimGet( planeView );

  _.assert( dimP === dimB );

  if( this.tools.plane.boxIntersects( planeView, boxView ) )
  return dstBox;
  else
  {
    let boxPoint = this.planeClosestPoint( boxView, planeView );
    let planePoint = this.tools.plane.pointCoplanarGet( planeView, boxPoint );
    let box = this.pointExpand( boxView, planePoint);
    for( let i = 0; i < box.length; i++ )
    {
      boxView.eSet( i, box.eGet( i ) );
    }
    return dstBox;
  }
}

//

/**
  *Check if the source box contains the test segment. Returns true if it is contained, false if not.
  * Box and segment are stored in Array data structure and remain unchanged
  *
  * @param { Array } srcBox - The source box (container).
  * @param { Array } tstSegment - The tested segment (the segment to check if it is contained in srcBox).
  *
  * @example
  * // returns true
  * _.segmentContains( [ 0, 0, 0, 2, 2, 2 ], [ 1, 1, 1, 2, 1, 1 ] );
  *
  * @example
  * // returns false
  * _.segmentContains( [ 0, 0, 0, 2, 2, 2 ], [ 0, 0, 1, 1, 1, 2.5 ] );
  *
  * @returns { Boolean } Returns true if the segment is contained and false if not.
  * @function segmentContains
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the box and segment don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcBox ) is not box
  * @throws { Error } An Error if ( tstSegment ) is not segment
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */

function segmentContains( srcBox , tstSegment )
{

  let segmentView = this.tools.segment.adapterFrom( tstSegment );
  let origin = this.tools.segment.originGet( segmentView );
  let end = this.tools.segment.endPointGet( segmentView );
  let dimS = this.tools.segment.dimGet( segmentView );

  let boxView = this.adapterFrom( srcBox );
  let dimB = this.dimGet( boxView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( dimS === dimB );

  if( !this.pointContains( boxView, origin ) )
  return false;

  if( !this.pointContains( boxView, end ) )
  return false;

  return true;
}

//

function segmentIntersects( srcBox , tstSegment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstSegmentView = this.tools.segment.adapterFrom( tstSegment );
  let boxView = this.adapterFrom( srcBox );

  let gotBool = this.tools.segment.boxIntersects( tstSegmentView, boxView );
  return gotBool;
}

//

function segmentDistance( srcBox , tstSegment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstSegmentView = this.tools.segment.adapterFrom( tstSegment );
  let boxView = this.adapterFrom( srcBox );

  let gotDist = this.tools.segment.boxDistance( tstSegmentView, boxView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a box to a segment. Returns the calculated point.
  * Box and segment remain unchanged
  *
  * @param { Array } box - The source box.
  * @param { Array } segment - The source segment.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * let segment = [ 0, 0, 0, - 1, - 1, - 1 ]
  * _.segmentClosestPoint( [ 0, 0, 0, 2, 2, 2 ], segment );
  *
  * @example
  * // returns [ 2, 2, 2 ]
  * _.segmentClosestPoint( [ 2, 2, 2, 3, 3, 3 ], segment );
  *
  * @returns { Array } Returns the closest point to the segment.
  * @function segmentClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( box ) is not box
  * @throws { Error } An Error if ( segment ) is not segment
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function segmentClosestPoint( box, segment, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let boxView = this.adapterFrom( box );
  let dimB = this.dimGet( boxView );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimB );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let segmentView = this.tools.segment.adapterFrom( segment );
  let origin = this.tools.segment.originGet( segmentView );
  let direction = this.tools.segment.directionGet( segmentView );
  let dimSegment  = this.tools.segment.dimGet( segmentView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimB === dstPoint.length );
  _.assert( dimB === dimSegment );

  if( this.tools.segment.boxIntersects( segmentView, boxView ) )
  return 0
  else
  {
    let segmentPoint = this.tools.segment.boxClosestPoint( segment, boxView );

    let boxPoint = this.tools.vectorAdapter.from( this.pointClosestPoint( boxView, segmentPoint ) );

    for( let i = 0; i < dimB; i++ )
    {
      dstPointView.eSet( i, boxPoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

/**
  *Check if the source box contains test sphere. Returns true if it is contained, false if not.
  * Box and sphere are stored in Array data structure and remain unchanged
  *
  * @param { Array } srcBox - The source box (container).
  * @param { Array } tstSphere - The tested sphere (the sphere to check if it is contained in srcBox).
  *
  * @example
  * // returns true
  * _.sphereContains( [ 0, 0, 0, 2, 2, 2 ], [ 1, 1, 1, 1 ] );
  *
  * @example
  * // returns false
  * _.sphereContains( [ 0, 0, 0, 2, 2, 2 ], [ 0, 0, 1, 2.5 ] );
  *
  * @returns { Boolean } Returns true if the sphere is contained and false if not.
  * @function sphereContains
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the box and sphere don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcBox ) is not box
  * @throws { Error } An Error if ( tstSphere ) is not sphere
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */

function sphereContains( srcBox , tstSphere )
{
  let _tstSphere = this.tools.sphere.adapterFrom( tstSphere );
  let center = this.tools.sphere.centerGet( _tstSphere );
  let radius = this.tools.sphere.radiusGet( _tstSphere );
  let dimS = this.tools.sphere.dimGet( _tstSphere );

  let boxView = this.adapterFrom( srcBox );
  let dimB = this.dimGet( boxView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( dimS === dimB );

  let pointp = this.tools.vectorAdapter.from( center.slice() );
  let pointn = this.tools.vectorAdapter.from( center.slice() );
  for( let i = 0; i < dimS; i++ )
  {
    pointp.eSet( i, pointp.eGet( i ) + radius );
    pointn.eSet( i, pointn.eGet( i ) - radius );

    if( !this.pointContains( boxView, pointp ) )
    return false;

    if( !this.pointContains( boxView, pointn ) )
    return false;

    pointp.eSet( i, pointp.eGet( i ) - radius );
    pointn.eSet( i, pointn.eGet( i ) + radius );
  }

  return true;
}

//

/**
  *Check if the source box intersects with test sphere. Returns true if it they intersect, false if not.
  * Box and sphere are stored in Array data structure and remain unchanged
  *
  * @param { Array } srcBox - The source box.
  * @param { Array } tstSphere - The tested sphere.
  *
  * @example
  * // returns true
  * _.sphereIntersects( [ 0, 0, 0, 2, 2, 2 ], [ 0.5, 0.5, 1, 1 ] );
  *
  * @example
  * // returns false
  * _.sphereIntersects( [ 0, 0, 0, 2, 2, 2 ], [ 4, 4, 4, 1 ] );
  *
  * @returns { Boolean } Returns true if the sphere and the box intersect.
  * @function sphereIntersects
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the box and sphere don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcBox ) is not box
  * @throws { Error } An Error if ( tstSphere ) is not sphere
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function sphereIntersects( srcBox , tstSphere )
{
  let _tstSphere = this.tools.sphere.adapterFrom( tstSphere );
  let boxView = this.adapterFrom( srcBox );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let gotBool = this.tools.sphere.boxIntersects( _tstSphere, boxView );

  return gotBool;
}

//

/**
  * Calculates the distance between a box and a sphere. Returns the calculated distance.
  * Box and sphere are stored in Array data structure and remain unchanged
  *
  * @param { Array } srcBox - The source box.
  * @param { Array } tstSphere - The tested sphere (the sphere to calculate the distance).
  *
  * @example
  * // returns 0
  * _.sphereDistance( [ 0, 0, 0, 2, 2, 2 ], [ 0.5, 0.5, 1, 1 ] );
  *
  * @example
  * // returns 1
  * _.sphereDistance( [ 0, 0, 0, 2, 2, 2 ], [ 0, 0, 4, 1 ] );
  *
  * @returns { Number } Returns the distance between the box and the sphere.
  * @function sphereDistance
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the box and sphere don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcBox ) is not box
  * @throws { Error } An Error if ( tstSphere ) is not sphere
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function sphereDistance( srcBox , tstSphere )
{
  let _tstSphere = this.tools.sphere.adapterFrom( tstSphere );
  let center = this.tools.sphere.centerGet( _tstSphere );
  let radius = this.tools.sphere.radiusGet( _tstSphere );
  let dimS = this.tools.sphere.dimGet( _tstSphere );

  let boxView = this.adapterFrom( srcBox );
  let dimB = this.dimGet( boxView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( dimS === dimB );

  let distance = 0;
  if( this.tools.sphere.boxIntersects( _tstSphere, boxView ) )
    return distance;
  else
    distance = this.pointDistance( boxView, center ) - radius;

  return distance;
}

//

/**
  * Gets the closest point in a box to a sphere. Returns the closest point.
  * Box and sphere are stored in Array data structure and remain unchanged.
  *
  * @param { Array } srcBox - The source box.
  * @param { Array } tstSphere - The tested sphere.
  * @param { Array } dstPoint - The closest point in the sphere to the box.
  *
  * @example
  * // returns 0
  * _.sphereClosestPoint( [ 0, 0, 0, 2, 2, 2 ], [ 0.5, 0.5, 1, 1 ] );
  *
  * @example
  * // returns [ 0, 0, 2 ]
  * _.sphereClosestPoint( [ 0, 0, 0, 2, 2, 2 ], [ 0, 0, 4, 1 ] );
  *
  * @returns { Array } Returns the closest point in the box to the sphere.
  * @function sphereClosestPoint
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the box and sphere don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( tstSphere ) is not sphere.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function sphereClosestPoint( srcBox , tstSphere, dstPoint )
{

  let _tstSphere = this.tools.sphere.adapterFrom( tstSphere );
  let center = this.tools.sphere.centerGet( _tstSphere );
  let radius = this.tools.sphere.radiusGet( _tstSphere );
  let dimS = this.tools.sphere.dimGet( _tstSphere );

  let boxView = this.adapterFrom( srcBox );
  let dimB = this.dimGet( boxView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimB );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  _.assert( dimS === dimB );
  _.assert( dimS === dstPoint.length );

  if( this.tools.sphere.boxIntersects( _tstSphere, boxView ) )
    return 0
  else
  {
    let p = this.pointClosestPoint( boxView, center );

    for( let i = 0; i < dimB; i++ )
    {
      dstPointView.eSet( i, p[ i ] );
    }

    return dstPoint;
  }
}

//

/**
  * Expand destination box by source sphere. Returns destination box.
  * Box and sphere are stored in Array data structure. Source sphere stays untouched.
  *
  * @param { Array } dstBox - box to be expanded.
  * @param { Array } srcSphere - source sphere with expansion dimensions.
  *
  * @example
  * // returns [ -2, -2, -2, 3, 3, 3 ];
  * _.sphereExpand( [ 1, 1, 1, 3, 3, 3 ], [ 0, 0, 0, 2 ] );
  *
  * @returns { Array } Returns the array of the expanded box, that contains new element ( src sphere ).
  * @function sphereExpand
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the box and the sphere don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstBox ) is not box
  * @throws { Error } An Error if ( srcSphere ) is not sphere
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function sphereExpand( dstBox , srcSphere )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let _dstBox = this.adapterFrom( dstBox );
  let dimB = this.dimGet( _dstBox );
  let min1 = this.cornerLeftGet( _dstBox );
  let max1 = this.cornerRightGet( _dstBox );

  _.assert( _.sphere.is( srcSphere ) );
  let _srcSphere = this.tools.sphere.adapterFrom( srcSphere );
  let center = this.tools.sphere.centerGet( _srcSphere );
  let radius = this.tools.sphere.radiusGet( _srcSphere );
  let dimS = this.tools.sphere.dimGet( _srcSphere );

  _.assert( dimB === dimS );

  /* Sphere limits */

  let c1 = _.Matrix.MakeZero( [ 3, 6 ] );
  c1.colGet( 0 ).copy( [ center.eGet( 0 ) + radius, center.eGet( 1 ), center.eGet( 2 ) ] );
  c1.colGet( 1 ).copy( [ center.eGet( 0 ) - radius, center.eGet( 1 ), center.eGet( 2 ) ] );
  c1.colGet( 2 ).copy( [ center.eGet( 0 ), center.eGet( 1 ) + radius, center.eGet( 2 ) ] );
  c1.colGet( 3 ).copy( [ center.eGet( 0 ), center.eGet( 1 ) - radius, center.eGet( 2 ) ] );
  c1.colGet( 4 ).copy( [ center.eGet( 0 ), center.eGet( 1 ), center.eGet( 2 ) + radius ] );
  c1.colGet( 5 ).copy( [ center.eGet( 0 ), center.eGet( 1 ), center.eGet( 2 ) - radius ] );

  for( let j = 0 ; j < 6 ; j++ )
  {
    let srcCorner = c1.colGet( j );
    _dstBox = this.pointExpand( _dstBox, srcCorner );
  }

  return dstBox;
}

//

/**
  * Get the bounding sphere of a box. Returns destination sphere.
  * Box and sphere are stored in Array data structure. Source box stays untouched.
  *
  * @param { Array } dstSphere - destination sphere.
  * @param { Array } srcBox - source box for the bounding sphere.
  *
  * @example
  * // returns [ 1, 1, 1, Math.sqrt( 3 ) ]
  * _.boundingSphereGet( null, [ 0, 0, 0, 2, 2, 2 ] );
  *
  * @returns { Array } Returns the array of the bounding sphere.
  * @function boundingSphereGet
  * @throws { Error } An Error if ( dim ) is different than dimGet(box) (the box and the sphere don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstSphere ) is not sphere
  * @throws { Error } An Error if ( srcBox ) is not box
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function boundingSphereGet( dstSphere, srcBox )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let srcBoxView = this.adapterFrom( srcBox );
  let dimB = this.dimGet( srcBoxView );
  let min = this.cornerLeftGet( srcBoxView );
  let max = this.cornerRightGet( srcBoxView );

  if( dstSphere === null || dstSphere === undefined )
  dstSphere = this.tools.sphere.makeZero( dimB );

  _.assert( _.sphere.is( dstSphere ) );
  let dstSphereView = this.tools.sphere.adapterFrom( dstSphere );
  let center = this.tools.sphere.centerGet( dstSphereView );
  let radius = this.tools.sphere.radiusGet( dstSphereView );
  let dimS = this.tools.sphere.dimGet( dstSphereView );

  _.assert( dimB === dimS );

  // Center of the sphere
  for( let c = 0; c < center.length; c++ )
  {
    center.eSet( c, ( max.eGet( c ) + min.eGet( c ) ) / 2 );
  }

  // Radius of the sphere
  this.tools.sphere.radiusSet( dstSphereView, this.tools.vectorAdapter.distance( center, max ) );

  return dstSphere;
}

//

/**
  * Apply a space transformation to a box. Returns the transformed box.
  *
  * @param { Array } box - The destination box.
  * @param { Matrix } matrix - The transformation matrix.
  *
  * @example
  * // returns [ 0, 0, 0, 1, 1, 1 ]
  * let matrix = _.Matrix.Make( [ 4, 4 ] ).copy
  *  ([
  *    0.5, 0, 0, 0,
  *    0, 0.5, 0, 0,
  *    0, 0, 0.5, 0,
  *    0, 0, 0, 1
  *  ]);
  * _.matrixHomogenousApply( [ 0, 0, 0, 2, 2, 2 ], matrix );
  *
  * @returns { Array } Returns the transformed box.
  * @function matrixHomogenousApply
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( box ) is not box
  * @throws { Error } An Error if ( matrix ) is not space
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */
function matrixHomogenousApply( box , matrix )
{
  let self = this;
  let boxView = this.adapterFrom( box );
  let dim = this.dimGet( boxView );
  let min = this.cornerLeftGet( boxView );
  let max = this.cornerRightGet( boxView );
  let isNil = this.isNil( box );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.matrixIs( matrix ) );
  _.assert( matrix.hasShape([ dim+1, dim+1 ]) );

  let box2 = this.nil( dim );

  let point = [];
  let samples = _.dup( [ 0, 1 ] , dim );
  _.permutation.eachSample( samples, function( sample, i )
  {

    for( let i = 0 ; i < dim ; i++ )
    point[ i ] = sample[ i ] ? max.eGet( i ) : min.eGet( i );
    matrix.matrixHomogenousApply( point );
    self.pointExpand( box2, point );

  });

  if( isNil )
  {
    min.assign( this.cornerRightGet( box2 ) );
    max.assign( this.cornerLeftGet( box2 ) );
  }
  else
  {
    boxView.copy( box2 );
  }

  return box;
}

//

/**
  * Translate a box by a given offset. Returns the translated box.
  *
  * @param { Array } box - The destination box.
  * @param { Number } offset - The translation offset.
  *
  * @example
  * // returns [ 3, 3, 3, 5, 5, 5 ]
  * _.translate( [ 0, 0, 0, 2, 2, 2 ], 3 );
  *
  * @returns { Array } Returns the translated box.
  * @function translate
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstBox ) is not box
  * @namespace wTools.box
  * @module Tools/math/Concepts
  */

function translate( box, offset )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let boxView = this.adapterFrom( box );
  _.assert( _.numberIs( offset ) );

  boxView.add( offset );
  // boxView.addScalar( offset );

  return box;
}

//

/*
*
*  function translate( box , offset )
*  {
*
*    this.min.add( offset );
*    this.max.add( offset );
*
*    return box;
*
*  }
*/

// //
//
// function pointContains( box, point )
// {
//
//   _.assert( arguments.length === 2, 'Expects exactly two arguments' );
//   _.assert( this.is( box ) );
//   debugger;
//   throw _.err( 'not implemented' );
//
//   let boxView = this.adapterFrom( box );
//   let center = this.centerGet( boxView );
//   let radius = this.radiusGet( boxView );
//
//   return( vector.distanceSqr( vector.From( point ) , center ) <= ( radius * radius ) );
// }
//
// //
//
// function pointDistance( box, point )
// {
//
//   _.assert( arguments.length === 2, 'Expects exactly two arguments' );
//   _.assert( this.is( box ) );
//   debugger;
//   throw _.err( 'not implemented' );
//
//   let boxView = this.adapterFrom( box );
//   let center = this.centerGet( boxView );
//   let radius = this.radiusGet( boxView );
//
//   return( vector.distance( vector.From( point ) , center ) - radius );
// }
//
// //
//
// function pointClosestPoint( box, point )
// {
//
//   _.assert( arguments.length === 2, 'Expects exactly two arguments' );
//   _.assert( this.is( box ) );
//   debugger;
//   throw _.err( 'not implemented' );
//
//   let pointVector = vector.From( point );
//   let boxView = this.adapterFrom( box );
//   let center = this.centerGet( boxView );
//   let radius = this.radiusGet( boxView );
//
//   let distanseSqr = vector.distanceSqr( pointVector , center );
//
//   if( distanseSqr > radius * radius )
//   {
//
//     this.tools.vectorAdapter.sub( pointVector, center );
//     this.tools.vectorAdapter.normalize( pointVector );
//     this.tools.vectorAdapter.mulScalar( pointVector, radius );
//     this.tools.vectorAdapter.add( pointVector, center );
//
//   }
//
//   return point;
// }
//
// //
//
// function boxIntersects( box1, box2 )
// {
//
//   _.assert( arguments.length === 2, 'Expects exactly two arguments' );
//   _.assert( this.is( box1 ) );
//   _.assert( this.is( box2 ) );
//   debugger;
//   throw _.err( 'not implemented' );
//
//   let boxView1 = this.adapterFrom( box1 );
//   let center1 = this.centerGet( boxView1 );
//   let radius1 = this.radiusGet( boxView1 );
//
//   let boxView2 = this.adapterFrom( box2 );
//   let center2 = this.centerGet( boxView2 );
//   let radius2 = this.radiusGet( boxView2 );
//
//   let r = radius1 + radius2;
//   return this.tools.vectorAdapter.distanceSqr( center1, center2 ) <= r*r;
// }
//
// //
//
// function matrixHomogenousApply( box, matrix )
// {
//
//   _.assert( arguments.length === 2, 'Expects exactly two arguments' );
//   _.assert( this.is( box ) );
//   _.assert( _.matrixIs( matrix ) );
//   debugger;
//   throw _.err( 'not implemented' );
//
//   let boxView = this.adapterFrom( box );
//   let center = this.centerGet( boxView );
//   let radius = this.radiusGet( boxView );
//
//   matrix.matrixHomogenousApply( center );
//   this.radiusSet( radius, matrix.scaleMaxGet() )
//
//   return box;
// }
//
// //
//
// function translate( box, offset )
// {
//
//   _.assert( arguments.length === 2, 'Expects exactly two arguments' );
//   _.assert( this.is( box ) );
//   _.assert( _.matrixIs( matrix ) );
//   debugger;
//   throw _.err( 'not implemented' );
//
//   let boxView = this.adapterFrom( box );
//   let center = this.centerGet( boxView );
//   let radius = this.radiusGet( boxView );
//
//   center.add( offset );
//
//   return box;
// }

// --
// declare
// --

let Extension = /* qqq : normalize order */
{

  make,
  makeZero,
  makeSingular,

  zero,
  nil,
  centeredOfSize,

  from,
  adapterFrom,
  fromPoints,
  fromCenterAndSize,
  fromSphere,
  fromCube,

  is,
  isEmpty,
  isZero,
  isNil,

  dimGet,
  cornerLeftGet,
  cornerRightGet,
  centerGet,
  sizeGet,
  cornersGet,

  expand,

  // pointContains,
  // pointDistance,
  // pointClosestPoint,
  // pointExpand,
  // pointRelative,

  boxContains,
  boxIntersects,
  boxDistance, /* qqq : implement me */
  boxClosestPoint, /* qqq : implement me */
  boxExpand,

  // capsuleIntersects,
  // capsuleDistance,
  // capsuleClosestPoint,

  project,
  getProjectionFactors, /* xxx */

  pointContains,
  pointDistance,
  pointClosestPoint,
  pointExpand,
  pointRelative,

  lineIntersects, /* Same as _.linePointDir.boxIntersects */
  lineDistance, /* Same as _.linePointDir.boxDistance */
  lineClosestPoint,

  planeIntersects, /* qqq : implement me - Same as _.plane.boxIntersects */
  planeDistance, /* qqq : implement me */
  planeClosestPoint, /* qqq : implement me */
  planeExpand, /* qqq : implement me */

  capsuleContains,
  capsuleIntersects,
  capsuleDistance,
  capsuleClosestPoint,

  convexPolygonContains,
  convexPolygonIntersects,
  convexPolygonDistance,
  convexPolygonClosestPoint,

  frustumContains, /* qqq : implement me */
  frustumIntersects, /* qqq : implement me - Same as _.frustum.boxIntersects */
  frustumDistance, /* qqq : implement me */
  frustumClosestPoint, /* qqq : implement me */
  frustumExpand, /* qqq : implement me */

  rayIntersects, /* qqq : implement me - Same as _.ray.boxIntersects */
  rayDistance, /* qqq : implement me - Same as _.ray.boxDistance */
  rayClosestPoint,

  segmentIntersects, /* Same as _.segment.boxIntersects */
  segmentDistance, /* Same as _.segment.boxDistance */
  segmentClosestPoint,

  sphereContains, /* qqq : implement me */
  sphereIntersects, /* qqq : implement me - Same as _.sphere.boxIntersects */
  sphereDistance, /* qqq : implement me */
  sphereClosestPoint, /* qqq : implement me */
  sphereExpand, /* qqq : implement me */
  boundingSphereGet,

  matrixHomogenousApply,
  translate,

  segmentContains,
  segmentIntersects, /* Same as _.segment.boxIntersects */
  segmentDistance, /* Same as _.segment.boxDistance */
  segmentClosestPoint,

  // ref

  tools : _,

}

/* _.props.extend */Object.assign( _.box, Extension );

})();
