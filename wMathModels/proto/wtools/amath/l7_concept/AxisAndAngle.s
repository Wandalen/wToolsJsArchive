(function _AxisAndAngle_s_(){

'use strict';

const _ = _global_.wTools;
// let this.tools.avector = this.tools.avector;
// let vector = this.tools.vectorAdapter;
const pi = Math.PI;
const sin = Math.sin;
const cos = Math.cos;
const atan2 = Math.atan2;
const asin = Math.asin;
const acos = Math.acos;
const abs = Math.abs;
const sqr = _.math.sqr;
const sqrt = _.math.sqrt;

_.assert( !this );
_.assert( _.object.isBasic( _.avector ) );

/**
 * An AxisAndAngle element represents a rotation around a direction vector of a certain magnitude.
 *
 * For the following functions, Axis Angles must have the shape [ dir1, dir2, dir3, angle ],
 * where dir1, dir2 and dir3 are the coordinates of the axis of the rotations,
 * and angle corresponds to the rotation magnitude.
 *
 * @namespace wTools.axisAndAngle
 * @module Tools/math/Concepts
 */

_.axisAndAngle = _.axisAndAngle || Object.create( _.avector );

// --
//
// --

/**
 * @descriptionNeeded
 * @param {Array} axisAndAngle
 * @param {Array} angle
 * @function is
 * @namespace wTools.axisAndAngle
 * @module Tools/math/Concepts
 */

function is( axisAndAngle, angle )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( !_.longIs( axisAndAngle ) && !_.vectorAdapterIs( axisAndAngle ) )
  return false;

  return ( ( axisAndAngle.length === 4 ) && ( angle === undefined ) ) || ( ( axisAndAngle.length === 3 ) && ( _.numberIs( angle ) ) );
}

//

/**
 * @descriptionNeeded
 * @param {Array} axisAndAngle
 * @param {Array} angle
 * @function isWithAngle
 * @namespace wTools.axisAndAngle
 * @module Tools/math/Concepts
 */

function isWithAngle( axisAndAngle, angle )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( angle !== null && angle !== undefined && !_.numberIs( angle ) )
  return false;

  if( axisAndAngle === null )
  return true;

  if( !_.longIs( axisAndAngle ) && !_.vectorAdapterIs( axisAndAngle ) )
  return false;

  if( ( axisAndAngle.length === 4 ) && ( angle === undefined ) )
  return true;

  if( ( ( axisAndAngle.length === 3 ) && ( _.numberIs( angle ) || angle === null ) ) )
  return true;

  return false;
}

//

/**
 * @descriptionNeeded
 * @param {Array} axisAndAngle
 * @param {Array} angle
 * @function isZero
 * @namespace wTools.axisAndAngle
 * @module Tools/math/Concepts
 */

function isZero( axisAndAngle, angle )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( !this.is( axisAndAngle, angle ) )
  return false;

  if( axisAndAngle && axisAndAngle.length === 3 )
  return angle === 0;

  if( _.vectorAdapterIs( axisAndAngle ) )
  return axisAndAngle.eGet( 0 ) === 0;
  else if( _.arrayIs( axisAndAngle ) )
  return axisAndAngle[ 0 ] === 0;
  else _.assert( 0 );
  // if( _.vectorAdapterIs( axisAndAngle ) )
  // return axisAndAngle.eGet( 3 ) === 0;
  // else if( _.arrayIs( axisAndAngle ) )
  // return axisAndAngle[ 3 ] === 0;
  // else _.assert( 0 );
}

//

/**
 * @descriptionNeeded
 * @param {Array} axisAndAngle
 * @param {Array} angle
 * @function make
 * @namespace wTools.axisAndAngle
 * @module Tools/math/Concepts
 */

function make( axisAndAngle, angle )
{
  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );
  _.assert( axisAndAngle === undefined || axisAndAngle === null || this.is( axisAndAngle, angle ) );

  let result = this.makeZero();
  let resultv = this.tools.vectorAdapter.from( result );

  let axisAndAnglev;
  if( axisAndAngle )
  axisAndAnglev = this.tools.vectorAdapter.from( axisAndAngle );

  if( axisAndAnglev )
  {
    resultv.eSet( 1, axisAndAnglev.eGet( axisAndAnglev.length - 3 ) );
    resultv.eSet( 2, axisAndAnglev.eGet( axisAndAnglev.length - 2 ) );
    resultv.eSet( 3, axisAndAnglev.eGet( axisAndAnglev.length - 1 ) );
    // resultv.eSet( 0, axisAndAnglev.eGet( 0 ) );
    // resultv.eSet( 1, axisAndAnglev.eGet( 1 ) );
    // resultv.eSet( 2, axisAndAnglev.eGet( 2 ) );
  }

  if( _.numberIs( angle ) )
  resultv.eSet( 0, angle );
  else if( axisAndAnglev )
  resultv.eSet( 0, axisAndAnglev.eGet( 0 ) );
  // if( _.numberIs( angle ) )
  // resultv.eSet( 3, angle );
  // else if( axisAndAnglev )
  // resultv.eSet( 3, axisAndAnglev.eGet( 3 ) );

  return result;
}

//

/**
 * @descriptionNeeded
 * @function makeZero
 * @namespace wTools.axisAndAngle
 * @module Tools/math/Concepts
 */

function makeZero()
{
  _.assert( arguments.length === 0, 'Expects no arguments' );
  let result = this.tools.longMakeZeroed( 4 );
  // let result = _.dup( 0, 4 ); /* xxx */
  return result;
}

//

/**
 * @descriptionNeeded
 * @param {Array} axisAndAngle
 * @param {Array} angle
 * @function from
 * @namespace wTools.axisAndAngle
 * @module Tools/math/Concepts
 */

function from( axisAndAngle, angle )
{

  _.assert( axisAndAngle === null || this.isWithAngle( axisAndAngle, angle ) );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( axisAndAngle === null )
  return this.make( axisAndAngle, angle );

  if( _.vectorAdapterIs( axisAndAngle ) )
  {
    if( axisAndAngle.length === 4 )
    {
      if( angle !== undefined && angle !== null )
      axisAndAngle.eSet( 0, angle );
      // axisAndAngle.eSet( 3, angle );
      return axisAndAngle;
    }
    // debugger;
    // let result = axisAndAngle.growLong([ 0, 3 ]);
    let result = axisAndAngle.growLong([ -1, 2 ]);
    if( angle !== undefined && angle !== null )
    result[ 0 ] = angle;
    return result;
  }
  else
  {
    if( axisAndAngle.length === 3 )
    {
      // axisAndAngle = _.longResize( axisAndAngle, 0, 4 );
      // axisAndAngle = this.tools.longGrow_( null, axisAndAngle, [ -1, 3 ] ); /* Dmytro : previous */ /* xxx */
      axisAndAngle = this.tools.longGrow_( null, axisAndAngle, [ -1, 2 ] );
      // axisAndAngle = this.tools.longGrow( axisAndAngle, [ 0, 4 ] )
      axisAndAngle[ 0 ] = angle === null ? 0 : angle;
      // axisAndAngle[ 3 ] = angle === null ? 0 : angle;
    }
  }

  return axisAndAngle;
}

//

function adapterFrom( axisAndAngle, angle )
{

  _.assert( axisAndAngle === null || this.isWithAngle( axisAndAngle, angle ) );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( axisAndAngle === null )
  {
    axisAndAngle = this.make( axisAndAngle, angle );
  }
  else if( _.vectorAdapterIs( axisAndAngle ) )
  {
    if( axisAndAngle.length === 4 )
    {
      if( angle !== undefined && angle !== null )
      axisAndAngle.eSet( 0 , angle );
      // axisAndAngle.eSet( 3 , angle );
      return axisAndAngle;
    }
    // debugger;
    // let result = axisAndAngle.resizedAdapter( 0, 4 );
    let result = axisAndAngle.grow([ -1, 2 ]);
    if( angle !== undefined && angle !== null )
    result.eSet( 0 , angle );
    // result.eSet( 3 , angle );
    return result;
  }
  else
  {
    if( axisAndAngle.length === 3 )
    {
      // debugger;
      // axisAndAngle = _.longGrow( axisAndAngle, [ -1, 3 ] ); /* Dmytro : routine */
      axisAndAngle = _.longGrow_( null, axisAndAngle, [ -1, 2 ] );
      axisAndAngle[ 0 ] = angle === null ? 0 : angle;
      // axisAndAngle[ 3 ] = angle === null ? 0 : angle;
    }
  }

  return this.tools.vectorAdapter.fromLong( axisAndAngle );
}

// {
//   _.assert( axisAndAngle === null || this.isWithAngle( axisAndAngle, angle ) );
//   _.assert( arguments.length === 1 || arguments.length === 2 );
//
//   if( axisAndAngle === null )
//   axisAndAngle = this.make( axisAndAngle, angle );
//
//   if( _.vectorAdapterIs( axisAndAngle ) )
//   {
//     debugger;
//     throw _.err( 'not implemented' );
//     let result = axisAndAngle.slice( 0, 4 );
//     if( angle !== undefined )
//     result[ 3 ] = angle;
//     return result;
//   }
//   else
//   {
//     if( axisAndAngle.length === 3 )
//     {
//       axisAndAngle = _.longResize( axisAndAngle, 0, 4 );
//       axisAndAngle[ 3 ] = angle;
//     }
//   }
//
//   return this.tools.vectorAdapter.from( axisAndAngle );
// }

//

/**
 * @descriptionNeeded
 * @param {Array} axisAndAngle
 * @param {Array} angle
 * @function zero
 * @namespace wTools.axisAndAngle
 * @module Tools/math/Concepts
 */

function zero( axisAndAngle, angle )
{

  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );
  _.assert( axisAndAngle === undefined || axisAndAngle === null || this.is( axisAndAngle, angle ) );

  if( axisAndAngle === undefined || axisAndAngle === null )
  return this.makeZero();

  let axisAndAnglev = this.tools.vectorAdapter.from( axisAndAngle );

  axisAndAnglev.eSet( 0, 0 );
  // axisAndAnglev.eSet( 3, 0 );

  return axisAndAngle;
}

//

/**
  * Create an axis and angle rotation from a matrix rotation. Returns the created AxisAndAngle.
  * Matrix rotation stays unchanged.
  *
  * @param { Array } srcMatrix - Source matrix rotation.
  * @param { Array } axisAndAngle - Destination rotation axis and angle.
  *
  * @example
  * // returns [ 0.6520678, 0.38680106, 0.6520678, 0.92713394 ]
  * let srcMatrix = _.Matrix.Make([ 3, 3 ]).copy
  * ([
  *   0.7701511383, -0.4207354784, 0.479425549507,
  *   0.6224468350, 0.65995573997, - 0.420735478401,
  *   - 0.13938128948, 0.622446835, 0.7701511383
  * ]);
  * _.fromMatrixRotation( [ 0, 0, 0, 0 ], srcMatrix );
  *
  * @returns { Array } Returns the corresponding axis and angle.
  * @function fromMatrixRotation
  * @throws { Error } An Error if( arguments.length ) is different than two.
  * @throws { Error } An Error if( srcMatrix ) is not a rotation matrix.
  * @throws { Error } An Error if( axisAndAngle ) is not axis and angle.
  * @namespace wTools.axisAndAngle
  * @module Tools/math/Concepts
  */

function fromMatrixRotation( axisAndAngle, srcMatrix )
{

  _.assert( arguments.length === 2, 'Expects two arguments' );
  _.assert( axisAndAngle.length === 4 );
  _.assert( _.Matrix.Is( srcMatrix ) );
  _.assert( srcMatrix.hasShape([ 3, 3 ]) );


  let quat = this.tools.quat.fromMatrixRotation( [ 0, 0, 0, 0 ], srcMatrix );
  axisAndAngle = this.tools.quat.toAxisAndAngle( quat, axisAndAngle );

  return axisAndAngle;

}

//

/**
  * Create a matrix rotation from an axis and angle rotation. Returns the created matrix.
  * Axis Angle stays unchanged.
  *
  * @param { Array } dstMatrix - Destination matrix rotation.
  * @param { Array } axisAndAngle - Source rotation axis and angle.
  *
  * @example
  * // returns
  * ([
  *   0.7701511383, -0.4207354784, 0.479425549507,
  *   0.6224468350, 0.65995573997, - 0.420735478401,
  *   - 0.13938128948, 0.622446835, 0.7701511383
  * ]);
  * _.toMatrixRotation( [ 0.6520678, 0.38680106, 0.6520678, 0.92713394 ], srcMatrix );
  *
  * @returns { Matrix } Returns the corresponding matrix rotation.
  * @function toMatrixRotation
  * @throws { Error } An Error if( arguments.length ) is different than two.
  * @throws { Error } An Error if( dstMatrix ) is not matrix.
  * @throws { Error } An Error if( axisAndAngle ) is not axis and angle.
  * @namespace wTools.axisAndAngle
 * @module Tools/math/Concepts
  */

function toMatrixRotation( axisAndAngle, dstMatrix )
{

  _.assert( arguments.length === 2, 'Expects two arguments' );
  _.assert( axisAndAngle.length === 4 );
  _.assert( _.Matrix.Is( dstMatrix ) );
  _.assert( dstMatrix.hasShape([ 3, 3 ]) );

  let quat = this.tools.quat.fromAxisAndAngle( [ 0, 0, 0, 0 ], axisAndAngle );
  dstMatrix = this.tools.quat.toMatrix( quat, dstMatrix );

  return dstMatrix;
}

// --
// declare
// --

let Extension = /* qqq : normalize order */
{

  //

  is,
  isWithAngle,
  isZero,

  make,
  makeZero,

  from,
  adapterFrom,

  zero,

  fromMatrixRotation,
  toMatrixRotation,

  // ref

  tools : _,

}

/* _.props.extend */Object.assign( _.axisAndAngle, Extension );

})();
