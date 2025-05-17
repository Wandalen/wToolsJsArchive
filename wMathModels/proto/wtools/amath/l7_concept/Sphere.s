(function _Sphere_s_(){

'use strict';

const _ = _global_.wTools;
_.sphere = _.sphere || Object.create( _.avector );

/**
 * @description
 * A sphere is the space enclosed by all the points at a given distance to a center:
 *
 * For the following functions, spheres must have the shape [ centerX, centerY, centerZ, radius ],
 * where the dimension equals the long's length minus one.
 *
 * Moreover, centerX, centerY, centerZ are the coordinates of the center of the sphere,
 * and radius is the radius pf the sphere.
 * @namespace wTools.sphere
  * @module Tools/math/Concepts
 */

/*

  A sphere is the space enclosed by all the points at a given distance to a center:

  For the following functions, spheres must have the shape [ centerX, centerY, centerZ, radius ],
where the dimension equals the long's length minus one.

  Moreover, centerX, centerY, centerZ are the coordinates of the center of the sphere,
and radius is the radius pf the sphere.

*/

// --
//
// --

/**
  *Create a sphere of dimension dim. Returns the created sphere. Sphere is stored in Array data structure.
  * Dim remains unchanged.
  *
  * @param { Number } dim - Dimension of the created sphere.
  *
  * @example
  * // returns [ 0, 0, 0, 0 ];
  * _.sphere.make( 3 );
  *
  * @example
  * // returns [ 0, 0, 0, 1 ];
  * _.sphere.make( [ 0, 0, 0, 1 ] );
  *
  * @returns { Array } Returns the array of the created sphere.
  * @function make
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @namespace wTools.sphere
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
  *Create a zero sphere of dimension dim. Returns the created sphere. Sphere is stored in Array data structure.
  * Dim remains unchanged.
  *
  * @param { Number } dim - Dimension of the created sphere.
  *
  * @example
  * // returns [ 0, 0, 0, 0 ];
  * _.sphere.makeZero( 3 );
  *
  * @example
  * // returns [ 0, 0, 0, 0 ];
  * _.sphere.makeZero( [ 0, 0, 0, 1 ] );
  *
  * @returns { Array } Returns the array of the created sphere.
  * @function makeZero
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function makeZero( dim )
{
  if( this.is( dim ) )
  dim = this.dimGet( dim );

  if( dim === undefined || dim === null )
  dim = 3;

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( _.numberIs( dim ) );

  let result = _.dup( 0, dim+1 );

  return result;
}

//

/**
  *Create a nil sphere of dimension dim. Returns the created sphere. Sphere is stored in Array data structure.
  * Dim remains unchanged.
  *
  * @param { Number } dim - Dimension of the created sphere.
  *
  * @example
  * // returns [ 0, 0, 0, - Infinity ];
  * _.sphere.makeSingular( 3 );
  *
  * @example
  * // returns [ 0, 0, 0, - Infinity ];
  * _.sphere.makeSingular( [ 0, 2, 0, 1 ] );
  *
  * @returns { Array } Returns the array of the created sphere.
  * @function makeSingular
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function makeSingular( dim )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = this.makeZero( dim );
  result[ result.length-1 ] = -Infinity;
  return result;
}

//

/**
  *Transform a sphere to a zero sphere. Returns the transformed sphere. Sphere is stored in Array data structure.
  *
  * @param { Array } sphere - Destination sphere.
  *
  * @example
  * // returns [ 0, 0, 0, 0 ];
  * _.zero( 3 );
  *
  * @example
  * // returns [ 0, 0, 0, 0 ];
  * _.zero( [ 0, 2, 0, 1 ] );
  *
  * @returns { Array } Returns the array of the transformed sphere.
  * @function zero
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function zero( sphere )
{
  if( !this.is( sphere ) )
  return this.makeZero( sphere );

  let sphereView = this.adapterFrom( sphere );
  for( let i = 0 ; i < sphereView.length ; i++ )
  sphereView.eSet( i, 0 );

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( this.is( sphere ) );

  return sphere;
}

//

/**
  *Transform a sphere to a nil sphere. Returns the transformed sphere. Sphere is stored in Array data structure.
  *
  * @param { Array } sphere - Destination sphere.
  *
  * @example
  * // returns [ 0, 0, 0, - Infinity ];
  * _.nil( 3 );
  *
  * @example
  * // returns [ 0, 0, 0, - Infinity ];
  * _.nil( [ 0, 2, 0, 1 ] );
  *
  * @returns { Array } Returns the array of the transformed sphere.
  * @function nil
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function nil( sphere )
{
  if( !this.is( sphere ) )
  return this.makeSingular( sphere );

  let sphereView = this.adapterFrom( sphere );
  for( let i = 0 ; i < sphereView.length-1 ; i++ )
  sphereView.eSet( i, 0 );
  sphereView.eSet( sphereView.length-1, -Infinity );

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( this.is( sphere ) );

  return sphere;
}

//

/**
  *Transform a sphere to a sphere centered in the origin with a given radius. Returns the created sphere.
  * Sphere is stored in Array data structure.
  *
  * @param { Array } sphere - Destination sphere.
  * @param { Number } radius - Source radius.
  *
  * @example
  * // returns [ 0, 0, 0, 0.5 ];
  * _.centeredOfRadius( [ 1, 1, 1, 2] );
  *
  * @example
  * // returns [ 0, 0, 0, 3 ];
  * _.centeredOfRadius( 3 );
  *
  * @example
  * // returns [ 0, 0, 0, 3 ];
  * _.centeredOfSize( [ 1, 1, 2, 2], 3 );
  *
  * @returns { Array } Returns the created sphere.
  * @function centeredOfRadius
  * @throws { Error } An Error if ( arguments.length ) is different than one or two.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function centeredOfRadius( sphere, radius )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.numberIs( radius ) );

  sphere = this.zero( sphere );
  _.assert( this.is( sphere ) );

  this.radiusSet( sphere, radius );

  return sphere;
}

//

/**
  *Transform a sphere to a string. Returns the created string.
  * Sphere is stored in Array data structure.
  *
  * @param { Array } sphere - Destination sphere.
  * @param { Number } options - Source options.
  *
  * @example
  * // returns [ 1, 1, 2, 2 ];
  * _.entity.exportString( [ 1, 1, 2, 2] );
  *
  * @returns { String } Returns an string with the box information.
  * @function toStr
  * @throws { Error } An Error if ( arguments.length ) is different than one or two.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function toStr( sphere, options )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( this.is( sphere ) );

  // let sphereView = this.adapterFrom( sphere );
  // let center = this.centerGet( sphereView );
  // let radius = this.radiusGet( sphereView );
  // let dim = this.dimGet( sphereView );

  return _.entity.exportString( sphere, options );
  debugger;
}

//

/**
  *Create or return a sphere. Returns the created sphere.
  *
  * @param { Array } sphere - Destination sphere.
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
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function from( sphere )
{

  if( _.object.isBasic( sphere ) )
  {
    _.assert( arguments.length === 1, 'Expects single argument' );
    _.map.assertHasOnly( sphere, { center : 'center' , radius : 'radius' } );
    sphere = [ sphere.center[ 0 ] , sphere.center[ 1 ] , sphere.center[ 2 ] , sphere.radius ]
  }
  else
  {
    _.assert( arguments.length === 1, 'Expects single argument' );
  }

  _.assert( _.vectorAdapterIs( sphere ) || _.longIs( sphere ) );

  if( _.vectorAdapterIs( sphere ) )
  {
    debugger;
    throw _.err( 'not implemented' );
    return sphere.slice();
  }

  return sphere;
}

//

/**
  *Create or return a sphere vector. Returns the created sphere.
  *
  * @param { Array } sphere - Destination sphere.
  *
  * @example
  * // returns this.tools.vectorAdapter.from( [ 1, 1, 2, 2 ] );
  * _.adapterFrom( [ 1, 1, 2, 2 ] );
  *
  * @returns { Vector } Returns the vector of the sphere.
  * @function adapterFrom
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function adapterFrom( sphere )
{
  _.assert( this.is( sphere ) )
  _.assert( arguments.length === 1, 'Expects single argument' );
  return this.tools.vectorAdapter.from( sphere );
}

//

/**
  * Create or expand a sphere from an array of points. Returns the expanded sphere. Spheres are stored in Array data structure.
  * Points stay untouched, sphere changes. Created spheres have center in origin.
  *
  * @param { Array } sphere - sphere to be expanded.
  * @param { Array } points - Array of points of reference with expansion dimensions.
  *
  * @example
  * // returns [ 0, 0, 0, 3 ];
  * _.fromPoints( null , [ [ 0, 0, 3 ], [ 0, 2, 0 ], [ 1, 0, 0 ] ] );
  *
  * @example
  * // returns [ 0, - 1, 2 ];
  * _.fromPoints( [ 0, - 1, 1 ], [ [ 1, 0 ], [ 0, -3 ], [ 0, 0 ] ] );
  *
  * @returns { Array } Returns the array of the sphere expanded.
  * @function fromPoints
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @throws { Error } An Error if ( point ) is not array.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function fromPoints( sphere, points )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.arrayIs( points )  || _.longIs( points ) );

  debugger;
  //throw _.err( 'not tested' );


  let dimp = points[0].length;

  if( sphere === null )
  sphere = this.make(dimp);

  let sphereView = this.adapterFrom( sphere );
  let center = this.centerGet( sphereView );
  let maxr = 0;

  for ( let i = 0 ; i < points.length ; i += 1 )
  {
    maxr = Math.max( maxr, this.tools.vectorAdapter.distanceSqr( center , this.tools.vectorAdapter.from( points[ i ] ) ) );
  }

  debugger;
  sphere[ dimp ] = Math.sqrt( maxr );

  return sphere;
}

//

/**
  * Create or expand a sphere from a box. Returns the expanded sphere. Spheres are stored in Array data structure.
  * Box stay untouched, sphere changes.
  *
  * @param { Array } sphere - sphere to be expanded.
  * @param { Array } box - box of reference with expansion dimensions.
  *
  * @example
  * // returns [ 0, 0, 0, Math.sqrt( 27 ) ];
  * _.fromBox( null , [ - 3, - 3, -3, 3, 3, 3 ] );
  *
  * @returns { Array } Returns the array of the sphere expanded.
  * @function fromBox
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @throws { Error } An Error if ( point ) is not array.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function fromBox( sphere, box )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  _.assert( this.tools.box.is( box ) );

  let boxView = this.tools.box.adapterFrom( box );
  let dimB = this.tools.box.dimGet( boxView );
  let min = this.tools.box.cornerLeftGet( boxView );
  let max = this.tools.box.cornerRightGet( boxView );
  let size = this.tools.box.sizeGet( boxView );

  if( this.tools.box.isNil( box ) )
  return this.tools.sphere.nil( sphere )

  if( sphere === null )
  sphere = this.make( dimB );

  let sphereView = this.adapterFrom( sphere );
  let center = this.centerGet( sphereView );
  let radius = this.radiusGet( sphereView );
  let dimS = this.dimGet( sphereView );

  _.assert( dimS === dimB );
  //  _.assert( dim === this.dimGet(  sphere) );

  center.copy( min );
  this.tools.vectorAdapter.add( center, max );
  this.tools.vectorAdapter.div( center, 2 );

  /* radius based on 2 major dimensions */

  // debugger;
  // this.tools.avector.sort( size );
  // this.radiusSet( sphereView , this.tools.avector.mag( size.slice( 1, 3 ) ) / 2 );
  this.radiusSet( sphereView , this.tools.avector.mag( size ) / 2 );

  return sphere;
}

//

/**
  * Create or modify sphere coordinates from a center and a radius. Returns the modified sphere.
  * Spheres are stored in Array data structure. Center and radius stay untouched, sphere changes.
  *
  * @param { Array } sphere - sphere to be modified.
  * @param { Array } center - Array of coordinates for new center of sphere.
  * @param { Number } radius - Value for new radius of sphere.
  *
  * @example
  * // returns [ 0, 2, 0, 1 ];
  * _.fromCenterAndRadius( null , [ 0, 2, 0 ], 1 );
  *
  * @example
  * // returns [ 1, 0, 2 ];
  * _.fromCenterAndRadius( [ 0, - 1, 1 ], [ 1, 0 ], 2 );
  *
  * @returns { Array } Returns the array of the sphere with new coordinates.
  * @function fromCenterAndRadius
  * @throws { Error } An Error if ( arguments.length ) is different than three.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @throws { Error } An Error if ( center ) is not point.
  * @throws { Error } An Error if ( radius ) is not number.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function fromCenterAndRadius( sphere, center, radius )
{
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );
  _.assert( _.longIs( center ) || _.vectorAdapterIs( center ) );
  _.assert( _.numberIs( radius ) );

  if( sphere === null )
  sphere = this.make( center.length );

  let sphereView = this.adapterFrom( sphere );
  let _center = this.centerGet( sphereView );
  let _dim = this.dimGet( sphereView );

  _.assert( center.length === _dim );

  _center.copy( center );
  this.radiusSet( sphereView , radius );

  return sphere;
}

//

/**
  * Check if input is a sphere. Returns true if it is a sphere and false if not.
  *
  * @param { Array } sphere - Source sphere.
  *
  * @example
  * // returns true;
  * _.sphere.is( [ 0, 0, 0, 1 ] );
  *
  * @returns { Boolean } Returns true if the input is sphere
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function is( sphere )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return ( _.longIs( sphere ) || _.vectorAdapterIs( sphere ) ) && sphere.length > 0;
}

//

/**
  * Check if input is an empty sphere. Returns true if it is an empty sphere and false if not.
  *
  * @param { Array } sphere - Source sphere.
  *
  * @example
  * // returns true;
  * _.isEmpty( [ 0, 0, 0, 0 ] );
  *
  * @returns { Boolean } Returns true if the input is an empty sphere
  * @function isEmpty
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function isEmpty( sphere )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( this.is( sphere ) );

  let sphereView = this.adapterFrom( sphere );
  let radius = this.radiusGet( sphereView );

  return( radius <= 0 );
}

//

/**
  * Check if input is a zero sphere. Returns true if it is a zero sphere and false if not.
  *
  * @param { Array } sphere - Source sphere.
  *
  * @example
  * // returns true;
  * _.isZero( [ 0, 0, 0, 0 ] );
  *
  * @returns { Boolean } Returns true if the input is a zero sphere
  * @function isZero
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function isZero( sphere )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( this.is( sphere ) );

  let sphereView = this.adapterFrom( sphere );
  let radius = this.radiusGet( sphereView );

  return( radius === 0 );
}

//

/**
  * Check if input is a nil sphere. Returns true if it is a nil sphere and false if not.
  *
  * @param { Array } sphere - Source sphere.
  *
  * @example
  * // returns true;
  * _.isNil( [ 0, 0, 0, - Infinity ] );
  *
  * @returns { Boolean } Returns true if the input is a nil sphere
  * @function isNil
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function isNil( sphere )
{

  _.assert( arguments.length === 1, 'Expects single argument' );

  // debugger;
  // throw _.err( 'not tested' );

  let sphereView = this.adapterFrom( sphere );
  let radius = this.radiusGet( sphereView );
  let center = this.centerGet( sphereView );

  // debugger;

  if( radius !== -Infinity )
  return false;

  if( !this.tools.vectorAdapter.allZero( center ) )
  return false;

  return true;
}

//

/**
  * Get Sphere dimension. Returns the dimension of the Sphere (number). Sphere stays untouched.
  *
  * @param { Array } sphere - The source sphere.
  *
  * @example
  * // returns 3
  * _.dimGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns 1
  * _.dimGet( [ 0, 1 ] );
  *
  * @returns { Number } Returns the dimension of the sphere.
  * @function dimGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function dimGet( sphere )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( this.is( sphere ) );
  return sphere.length - 1;
}

//

/**
  * Get the center of a sphere. Returns a vector with the coordinates of the center of the sphere.
  * Sphere stays untouched.
  *
  * @param { Array } sphere - The source sphere.
  *
  * @example
  * // returns   0, 0, 2
  * _.centerGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns  0
  * _.centerGet( [ 0, 1 ] );
  *
  * @returns { Vector } Returns the coordinates of the center of the sphere.
  * @function centerGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function centerGet( sphere )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  let sphereView = this.adapterFrom( sphere );
  return sphereView.review([ 0, sphere.length - 2 ]);
}

//

/**
  * Get the radius of a sphere. Returns a number with the radius of the sphere.
  * Sphere stays untouched.
  *
  * @param { Array } sphere - The source sphere.
  *
  * @example
  * // returns 2
  * _.radiusGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns  1
  * _.radiusGet( [ 0, 1 ] );
  *
  * @returns { Number } Returns the radius of the sphere.
  * @function radiusGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function radiusGet( sphere )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  let sphereView = this.adapterFrom( sphere );
  return sphereView.eGet( sphere.length-1 );
}

//


/**
  * Set the radius of a sphere. Returns a vector with the sphere including the new radius.
  * Radius stays untouched.
  *
  * @param { Array } sphere - The source and destination sphere.
  * @param { Number } radius - The source radius to set.
  *
  * @example
  * // returns [ 0, 0, 2, 4 ]
  * _.radiusSet( [ 0, 0, 2, 2 ], 4 );
  *
  * @example
  * // returns  [ 0, - 2 ]
  * _.radiusSet( [ 0, 1 ], -2 );
  *
  * @returns { Array } Returns the sphere with the modified radius.
  * @function radiusSet
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @throws { Error } An Error if ( radius ) is not number.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function radiusSet( sphere, radius )
{
  _.assert( this.is( sphere ) );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.numberIs( radius ) );

  //if( _.vectorAdapterIs( sphere ) )
  //{
  let sphereView = this.adapterFrom( sphere );
  //return sphereView.eSet( sphere.length-1, radius );
  //console.log('vector');
  sphereView.eSet( sphere.length-1, radius );
  return sphereView;
  //}

  // Alternative solution
  //if( _.longIs( sphere ) )
  //{
  //  sphere[ sphere.length-1 ] = radius;
  //  return sphere;
  //}
  debugger;
}

//

/**
  * Project a sphere: the projection vector ( projVector ) translates the center of the sphere, and the projection scaling factor ( r )
  * scale the radius of the sphere. The projection parameters should have the shape:
  * project = [ projVector, r ];
  * Returns the projected sphere. Sphere is stored in Array data structure.
  * The projection array stays untouched, the sphere changes.
  *
  * @param { Array } sphere - sphere to be projected.
  * @param { Array } project - Array of reference with projection parameters.
  *
  * @example
  * // returns [ 1, 1, 3, 3, 2 ];
  * _.project( [ 0, 0, 2, 2, 1 ], [ [ 1, 1, 1, 1 ], 2 ] );
  *
  *
  * @returns { Array } Returns the array of the projected sphere.
  * @function project
  * @throws { Error } An Error if ( dim ) is different than projVector.length (the sphere and the projection vector don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @throws { Error } An Error if ( project ) is not an array.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */
function project( sphere, project )
{

  if( sphere === null )
  sphere = this.make();

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.longIs( project ) || _.vectorAdapterIs( project ) );
  _.assert( project.length === 2, 'Project array expects exactly two entries')

  let sphereView = this.adapterFrom( sphere );
  let center = this.tools.vectorAdapter.from( this.centerGet( sphereView ) );
  let radius = this.radiusGet( sphereView );
  let dim = this.dimGet( sphereView );
  let projectView = this.tools.vectorAdapter.from( project );

  let projVector = this.tools.vectorAdapter.from( projectView.eGet( 0 ) );
  _.assert( dim === projVector.length );
  let scalRadius = projectView.eGet( 1 );

  let newCenter = this.tools.vectorAdapter.add( center.clone(), projVector );
  let newRadius = scalRadius * radius;

  debugger;

  for( let i = 0; i < dim; i ++ )
  {
    sphereView.eSet( i, newCenter.eGet( i ) );
  }

  sphereView.eSet( sphereView.length - 1, newRadius );
  return sphere;
}

//

/**
  * Get the projection factors of two spheres: the projection vector ( projVector ) translates the center of the sphere, and the projection scaling factors( l, r )
  * scale the segment length ( l ) and the radius ( r ) of the sphere. The projection parameters should have the shape:
  * project = [ projVector, l, r ];
  * Returns the projection parameters, 0 when not possible ( i.e: srcSphere is a point and projSphere is a sphere - no scaling factors ).
  * Spheres are stored in Array data structure. The spheres stay untouched.
  *
  * @param { Array } srcSphere - Original sphere.
  * @param { Array } projSphere - Projected sphere.
  *
  * @example
  * // returns [ [ 0.5, 0.5 ], 2, 2 ];
  * _.getProjectionFactors( [ 0, 0, 1, 1, 1 ], [ -0.5, -0.5, 2.5, 2.5, 2 ] );
  *
  *
  * @returns { Array } Returns the array with the projection factors between the two spherees.
  * @function getProjectionFactors
  * @throws { Error } An Error if ( dim ) is different than ( dim2 ) (the spheres don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( projSphere ) is not sphere.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */
function getProjectionFactors( srcSphere, projSphere )
{

  _.assert( this.is( srcSphere ), 'Expects sphere' );
  _.assert( this.is( projSphere ), 'Expects sphere' );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let srcSphereView = this.adapterFrom( srcSphere );
  let srcCenter = this.tools.vectorAdapter.from( this.centerGet( srcSphereView ) );
  let srcRadius = this.radiusGet( srcSphereView );
  let srcDim = this.dimGet( srcSphereView );

  let projSphereView = this.adapterFrom( projSphere );
  let projCenter = this.tools.vectorAdapter.from( this.centerGet( projSphereView ) );
  let projRadius = this.radiusGet( projSphereView );
  let projDim = this.dimGet( projSphereView );

  _.assert( srcDim === projDim );

  let project = this.tools.long.make( 2 );
  let projectView = this.tools.vectorAdapter.from( project );

  let translation = this.tools.vectorAdapter.sub( projCenter.clone(), srcCenter );
  projectView.eSet( 0, translation.toLong() );

  let scalRadius;
  if( srcRadius === 0 )
  {
    if( projRadius === 0 )
    {
      scalRadius = 1;
    }
    else return 0;
  }
  else
  {
    scalRadius = projRadius / srcRadius;
  }
  projectView.eSet( 1, scalRadius );

  return project;
}

//

/**
  * Check if a sphere contains a point. Returns true if it is contained and false if not.
  *
  * @param { Array } sphere - Source sphere.
  * @param { Array } point - Source point.
  *
  * @example
  * // returns true;
  * _.pointContains( [ 0, 0, 0, 1 ], [ 0, 0, 0 ] );
  *
  * @returns { Boolean } Returns true if the sphere contains the point
  * @function pointContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function pointContains( sphere, point )
{

  let sphereView = this.adapterFrom( sphere );
  let center = this.centerGet( sphereView );
  let radius = this.radiusGet( sphereView );
  let dim = this.dimGet( sphereView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( dim === point.length );

  debugger;
  //throw _.err( 'not tested' );

  // return ( this.tools.vectorAdapter.distanceSqr( this.tools.vectorAdapter.from( point ) , center ) <= ( radius * radius ) + this.tools.accuracy ); /* xxx */
  let distanceSqr = this.tools.vectorAdapter.distanceSqr( this.tools.vectorAdapter.from( point ) , center );
  return this.tools.avector.isLessEqualAprox( distanceSqr, ( radius * radius ) + this.tools.accuracy );
}

//

/**
  * Calculate the distance between a sphere and a point. Returns the calculated distance.
  *
  * @param { Array } sphere - Source sphere.
  * @param { Array } point - Source point.
  *
  * @example
  * // returns 0;
  * _.pointDistance( [ 0, 0, 0, 1 ], [ 0, 0, 0 ] );
  *
  * @returns { Number } Returns the distance between the sphere and the point
  * @function pointDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function pointDistance( sphere, point )
{

  let sphereView = this.adapterFrom( sphere );
  let center = this.centerGet( sphereView );
  let radius = this.radiusGet( sphereView );
  let dim = this.dimGet( sphereView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( dim === point.length );

  debugger;
  //throw _.err( 'not tested' );

  let distance = this.tools.vectorAdapter.distance( this.tools.vectorAdapter.from( point ) , center ) - radius;

  if( distance < 0 )
  return 0;
  else
  return distance;
}

//

/**
  * Clamp a point to a sphere. Returns the closest point in the sphere. Sphere and point stay unchanged.
  *
  * @param { Array } sphere - The source sphere.
  * @param { Array } point - The point to be clamped against the box.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns [ 3, 0, 0 ]
  * _.pointClosestPoint( [ 1, 0, 0, 2 ], [ 4, 0, 0 ] );
  *
  *
  * @returns { Array } Returns an array with the coordinates of the clamped point.
  * @function pointClosestPoint
  * @throws { Error } An Error if ( dim ) is different than dimGet( sphere ) (the sphere and the point don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @throws { Error } An Error if ( point ) is not point.
  * @throws { Error } An Error if ( dstPoint ) is not dstPoint.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function pointClosestPoint( sphere, srcPoint, dstPoint )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let sphereView = this.adapterFrom( sphere );
  let center = this.centerGet( sphereView );
  let radius = this.radiusGet( sphereView );
  let dim = this.dimGet( sphereView );

  if( arguments.length === 2 )
  dstPoint = srcPoint.slice();

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  _.assert( dim === srcPoint.length );
  let srcPointv = this.tools.vectorAdapter.from( srcPoint );
  _.assert( dim === dstPoint.length );
  let dstPointv = this.tools.vectorAdapter.from( dstPoint );

  if( this.pointContains( sphereView, srcPointv ) )
  return srcPointv;

  debugger;
  // throw _.err( 'not tested' );

  for( let i = 0; i < dim; i++ )
  {
    dstPointv.eSet( i, srcPointv.eGet( i ) );
  }

  let distanseSqr = this.vectorAdapter.distanceSqr( srcPointv , center );
  if( distanseSqr > radius * radius )
  {
    this.tools.vectorAdapter.sub( dstPointv, center );
    this.tools.vectorAdapter.normalize( dstPointv );
    this.tools.vectorAdapter.mul( dstPointv, radius );
    this.tools.vectorAdapter.add( dstPointv, center );
  }

  return dstPoint;
}

//


//

/**
  * Expand a sphere with a point. Returns the new sphere.
  * Point remains unchanged, sphere changes.
  *
  * @param { Array } sphere - Destination sphere.
  * @param { Array } point - Source point.
  *
  * @example
  * // returns [ 0, 0, 0, Math.sqrt( 27 ) ];
  * _.pointExpand( [ 0, 0, 0, 1 ], [ 3, 3, 3 ] );
  *
  * @returns { Array } Returns the coordinates of the expanded sphere
  * @function pointExpand
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( sphere ) is not a sphere.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function pointExpand( sphere , point )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.longIs( point ) || _.vectorAdapterIs( point ) );
  let sphereView = this.adapterFrom( sphere );
  let center = this.centerGet( sphereView );
  let radius = this.radiusGet( sphereView );
  let dim = this.dimGet( sphereView );


  let pointView = this.tools.vectorAdapter.from( point );

  _.assert( dim === point.length );

  // debugger;

  if( radius === -Infinity )
  {
    center.copy( point );
    this.radiusSet( sphereView, 0 );
    return sphere;
  }

  let distance = this.tools.vectorAdapter.distance( center , pointView );
  if( radius < distance )
  {

    _.assert( distance > 0 );

    // this.tools.vectorAdapter.mix( center, point, 0.5 + ( -radius ) / ( distance*2 ) );
    // this.radiusSet( sphereView, ( distance+radius ) / 2 );
    this.radiusSet( sphereView, distance );

  }

  return sphere;
}

//

/**
  * Checks if a sphere contains a box. Returns True if the sphere contains the box.
  * Sphere and box remain unchanged.
  *
  * @param { Array } sphere - Source sphere.
  * @param { Array } box - Source box
  *
  * @example
  * // returns true
  * _.boxContains( [ 1, 1, 1, 2 ], [ 0, 0, 0, 2, 2, 2 ] );
  *
  * @example
  * // returns false
  * _.boxContains( [ - 2, - 2, - 2, 1 ], [ 0, 0, 0, 1, 1, 1 ] );
  *
  * @returns { Boolean } Returns true if the sphere contains the box, and false if not.
  * @function boxContains
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the sphere and box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function boxContains( sphere, box )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let sphereView = this.adapterFrom( sphere );
  let center = this.centerGet( sphereView );
  let radius = this.radiusGet( sphereView );
  let dimS = this.dimGet( sphereView );

  let boxView = this.tools.box.adapterFrom( box );
  let dimB = this.tools.box.dimGet( boxView );
  let min = this.tools.box.cornerLeftGet( boxView );
  let max = this.tools.box.cornerRightGet( boxView );

  _.assert( dimS === dimB, 'Arguments must have same dimension' );

  /* src corners */

  let c = _.Matrix.MakeZero( [ 3, 8 ] );
  c.colGet( 0 ).copy( [ min.eGet( 0 ), min.eGet( 1 ), min.eGet( 2 ) ] );
  c.colGet( 1 ).copy( [ max.eGet( 0 ), min.eGet( 1 ), min.eGet( 2 ) ] );
  c.colGet( 2 ).copy( [ min.eGet( 0 ), max.eGet( 1 ), min.eGet( 2 ) ] );
  c.colGet( 3 ).copy( [ min.eGet( 0 ), min.eGet( 1 ), max.eGet( 2 ) ] );
  c.colGet( 4 ).copy( [ max.eGet( 0 ), max.eGet( 1 ), max.eGet( 2 ) ] );
  c.colGet( 5 ).copy( [ min.eGet( 0 ), max.eGet( 1 ), max.eGet( 2 ) ] );
  c.colGet( 6 ).copy( [ max.eGet( 0 ), min.eGet( 1 ), max.eGet( 2 ) ] );
  c.colGet( 7 ).copy( [ max.eGet( 0 ), max.eGet( 1 ), min.eGet( 2 ) ] );

  for( let j = 0 ; j < 8 ; j++ )
  {
    let srcCorner = c.colGet( j );

    if( this.pointContains( sphereView, srcCorner ) === false )
    {
    return false;
    }
  }

  return true;
}

//

/**
  * Checks if a sphere and a box Intersect. Returns True if they intersect.
  * Sphere and box remain unchanged.
  *
  * @param { Array } sphere - Source sphere.
  * @param { Array } box - Source box
  *
  * @example
  * // returns true
  * _.boxIntersects( [ - 1, - 1, - 1, 2 ], [ 0, 0, 0, 2, 2, 2 ] );
  *
  * @example
  * // returns false
  * _.boxIntersects( [ - 2, - 2, - 2, 1 ], [ 0, 0, 0, 1, 1, 1 ] );
  *
  * @returns { Boolean } Returns true if the box and the sphere intersect and false if not.
  * @function boxIntersects
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the sphere and box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function boxIntersects( sphere, box )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let sphereView = this.adapterFrom( sphere );
  let center = this.centerGet( sphereView );
  let radius = this.radiusGet( sphereView );
  let dimS = this.dimGet( sphereView );

  let boxView = this.tools.box.adapterFrom( box );
  let dimB = this.tools.box.dimGet( boxView );

  _.assert( dimS === dimB, 'Arguments must have same dimension' );

  if( this.tools.box.pointContains( boxView, center ) === true )
  {
    return true;
  }
  else
  {
    let distance = this.tools.box.pointDistance( boxView, center );
    if( distance <= radius )
    {
      return true;
    }
  }
  return false;
}

//

/**
  * Calculates the distance between a sphere and a box. Returns the calculated distance.
  * Sphere and box remain unchanged.
  *
  * @param { Array } sphere - Source sphere.
  * @param { Array } box - Source box
  *
  * @example
  * // returns 0
  * _.boxDistance( [ - 1, - 1, - 1, 2 ], [ 0, 0, 0, 2, 2, 2 ] );
  *
  * @example
  * // returns 1
  * _.boxDistance( [ 0, 0, - 2, 1 ], [ 0, 0, 0, 1, 1, 1 ] );
  *
  * @returns { Boolean } Returns the distance between the sphere and the plane.
  * @function boxDistance
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the sphere and box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function boxDistance( sphere, box )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let sphereView = this.adapterFrom( sphere );
  let boxView = this.tools.box.adapterFrom( box );

  let distance = this.tools.box.sphereDistance( boxView, sphereView );

  return distance;
}

//

/**
  * Gets the closest point in a sphere to a box. Returns the calculated point.
  * Sphere and box remain unchanged.
  *
  * @param { Array } srcSphere - Source sphere.
  * @param { Array } srcBox - Source box.
  * @param { Array } dstPoint - Destination point (optional).
  *
  * @example
  * // returns Math.sqrt( 27 ) - 2
  * _.boxClosestPoint( [ 0, 0, 0, 1 ], [ 2, 0, 0, 4, 0, 0 ] );
  *
  * @returns { Array } Returns the closest point in a sphere to a box.
  * @function boxClosestPoint
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the sphere and box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */
function boxClosestPoint( srcSphere, srcBox, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let sphereView = this.adapterFrom( srcSphere );
  let center = this.centerGet( sphereView );
  let radius = this.radiusGet( sphereView );
  let dimS = this.dimGet( sphereView );

  let boxView = this.tools.box.adapterFrom( srcBox );
  let dimB = this.tools.box.dimGet( boxView );
  let min = this.tools.box.cornerLeftGet( boxView );
  let max = this.tools.box.cornerRightGet( boxView );

  _.assert( dimS === dimB );

  if( arguments.length === 2 )
  dstPoint = this.tools.longMakeZeroed( dimB );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  _.assert( dimB === dstPoint.length );
  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  if( this.boxIntersects( sphereView, boxView ) )
  return 0;

  let boxPoint = this.tools.box.sphereClosestPoint( boxView, sphereView );
  let point = this.pointClosestPoint( sphereView, boxPoint );

  for( let i = 0; i < point.length; i++ )
  {
    dstPointView.eSet( i, point[ i ] );
  }

  return dstPoint;
}

//

/**
  * Expands a sphere with a box. Returns the expanded sphere.
  * Sphere changes and box remains unchanged.
  *
  * @param { Array } dstSphere - Destination sphere.
  * @param { Array } srcBox - Source box
  *
  * @example
  * // returns [ -1, -1, -1, Math.sqrt( 27 )]
  * _.boxExpand( [ - 1, - 1, - 1, 2 ], [ 0, 0, 0, 2, 2, 2 ] );
  *
  * @returns { Sphere } Returns an array with the center and radius of the expanded sphere.
  * @function boxExpand
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the sphere and box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */
function boxExpand( dstSphere, srcBox )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let sphereView = this.adapterFrom( dstSphere );
  let center = this.centerGet( sphereView );
  let radius = this.radiusGet( sphereView );
  let dimS = this.dimGet( sphereView );

  _.assert( _.box.is( srcBox ) );
  let boxView = this.tools.box.adapterFrom( srcBox );
  let dimB = this.tools.box.dimGet( boxView );
  let min = this.tools.box.cornerLeftGet( boxView );
  let max = this.tools.box.cornerRightGet( boxView );

  _.assert( dimS === dimB );

  /* box corners */
  let c = this.tools.box.cornersGet( boxView );

  let distance = radius;
  for( let j = 0 ; j < _.Matrix.DimsOf( c )[ 1 ] ; j++ )
  {
    let corner = c.colGet( j );
    let d = this.tools.avector.distance( corner, center );
    if( d > distance )
    {
      distance = d;
    }
  }

  this.radiusSet( sphereView, distance );

  return dstSphere;
}

//

/**
  * Get the bounding box of a sphere. Returns destination box.
  * Sphere and box are stored in Array data structure. Source sphere stays untouched.
  *
  * @param { Array } dstBox - destination box.
  * @param { Array } srcSphere - source sphere for the bounding box.
  *
  * @example
  * // returns [ - 2, - 2, - 2, 2, 2, 2 ]
  * _.boundingBoxGet( null, [ 0, 0, 0, 2 ] );
  *
  * @returns { Array } Returns the array of the bounding box.
  * @function boundingBoxGet
  * @throws { Error } An Error if ( dim ) is different than dimGet(sphere) (the sphere and the box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstBox ) is not box
  * @throws { Error } An Error if ( srcSphere ) is not sphere
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */
function boundingBoxGet( dstBox, srcSphere )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let sphereView = this.adapterFrom( srcSphere );
  let center = this.centerGet( sphereView );
  let radius = this.radiusGet( sphereView );
  let dimS = this.dimGet( sphereView );

  if( dstBox === null || dstBox === undefined )
  dstBox = this.tools.box.makeSingular( dimS );

  _.assert( _.box.is( dstBox ) );
  let dimB = this.tools.box.dimGet( dstBox );

  _.assert( dimS === dimB );

  let boxView = this.tools.box.adapterFrom( dstBox );
  let box = this.tools.box.adapterFrom( this.tools.box.fromSphere( null, sphereView ) );

  for( let b = 0; b < boxView.length; b++ )
  {
    boxView.eSet( b, box.eGet( b ) );
  }

  return dstBox;
}

//

/**
  * Check if a given capsule is contained inside a sphere. Returs true if it is contained, false if not. Capsule and sphere stay untouched.
  *
  * @param { Array } sphere - The sphere to check if the capsule is inside.
  * @param { Array } capsule - The capsule to check.
  *
  * @example
  * // returns true
  * _.capsuleContains( [ 0, 0, 4 ], [ 1, 1, 1.5, 1.5, 0.1 ] );
  *
  * @example
  * // returns false
  * _.capsuleContains( [ 0, 0, 2 ], [ - 1, 3, 3, 3, 1 ] );
  *
  * @returns { Boolean } Returns true if the capsule is inside the sphere, and false if the capsule is outside it.
  * @function capsuleContains
  * @throws { Error } An Error if ( dim ) is different than capsule.length (Sphere and capsule have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @throws { Error } An Error if ( capsule ) is not capsule.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */


function capsuleContains( sphere, capsule )
{

  let sphereView = this.adapterFrom( sphere );
  let dimS = this.dimGet( sphereView );
  let capsuleView = this.tools.capsule.adapterFrom( capsule );
  let dimC = this.tools.capsule.dimGet( capsuleView );
  let origin = this.tools.vectorAdapter.from( this.tools.capsule.originGet( capsuleView ) );
  let end = this.tools.vectorAdapter.from( this.tools.capsule.endPointGet( capsuleView ) );
  let radius = this.tools.capsule.radiusGet( capsuleView );

  _.assert( dimS === dimC );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let bottomSphere = this.fromCenterAndRadius( null, origin, radius );
  let topSphere = this.fromCenterAndRadius( null, end, radius );

  if( !this.sphereContains( sphereView, bottomSphere ) )
  return false;

  if( !this.sphereContains( sphereView, topSphere ) )
  return false;

  return true;
}

//

function capsuleIntersects( srcSphere , tstCapsule )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstCapsuleView = this.tools.capsule.adapterFrom( tstCapsule );
  let sphereView = this.adapterFrom( srcSphere );

  let gotBool = this.tools.capsule.sphereIntersects( tstCapsuleView, sphereView );
  return gotBool;
}

//

function capsuleDistance( srcSphere , tstCapsule )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstCapsuleView = this.tools.capsule.adapterFrom( tstCapsule );
  let sphereView = this.adapterFrom( srcSphere );

  let gotDist = this.tools.capsule.sphereDistance( tstCapsuleView, sphereView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a sphere to a capsule. Returns the calculated point.
  * Sphere and capsule remain unchanged
  *
  * @param { Array } sphere - The source sphere.
  * @param { Array } capsule - The source capsule.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * let capsule = [ 0, 0, 0, - 1, - 1, - 1, 1 ]
  * _.capsuleClosestPoint( [ 0, 0, 0, 2 ], capsule );
  *
  * @example
  * // returns [ 1, 0, 0 ]
  * _.capsuleClosestPoint( [ 2, 0, 0, 1 ], capsule );
  *
  * @returns { Array } Returns the closest point to the capsule.
  * @function capsuleClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( sphere ) is not sphere
  * @throws { Error } An Error if ( capsule ) is not capsule
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */
function capsuleClosestPoint( sphere, capsule, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let sphereView = this.adapterFrom( sphere );
  let dimSphere = this.dimGet( sphereView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimSphere );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let capsuleView = this.tools.capsule.adapterFrom( capsule );
  let dimCapsule  = this.tools.capsule.dimGet( capsuleView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimSphere === dstPoint.length );
  _.assert( dimSphere === dimCapsule );

  if( this.tools.capsule.sphereIntersects( capsuleView, sphereView ) )
  return 0
  else
  {
    let capsulePoint = this.tools.capsule.sphereClosestPoint( capsule, sphereView );

    let spherePoint = this.tools.vectorAdapter.from( this.pointClosestPoint( sphereView, capsulePoint ) );

    for( let i = 0; i < dimSphere; i++ )
    {
      dstPointView.eSet( i, spherePoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

/**
  * Check if a sphere contains a convex polygon. Returns true if it is cotained, false if not.
  * Sphere and polygon remain unchanged
  *
  * @param { Array } sphere - The source sphere.
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
  * _.convexPolygonContains( [ 0, 0, 4, 1 ], polygon );
  *
  * @returns { Array } Returns true if the sphere contains the polygon.
  * @function convexPolygonContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( sphere ) is not sphere
  * @throws { Error } An Error if ( polygon ) is not convexPolygon
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */
function convexPolygonContains( sphere, polygon )
{
  _.assert( arguments.length === 2, 'Expects two arguments' );
  _.assert( _.convexPolygon.is( polygon ) );

  let sphereView = this.adapterFrom( sphere );
  let dimS = this.dimGet( sphereView );

  let dimP  = _.Matrix.DimsOf( polygon );

  _.assert( dimP[ 0 ] === dimS );

  for( let i = 0; i < dimP[ 1 ]; i++ )
  {
    let vertex = polygon.colGet( i );

    if( !this.pointContains( sphereView, vertex ) )
    return false;
  }

  return true;

}

//

function convexPolygonIntersects( srcSphere , polygon )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.convexPolygon.is( polygon ) );
  let sphereView = this.adapterFrom( srcSphere );

  let gotBool = this.tools.convexPolygon.sphereIntersects( polygon, sphereView );

  return gotBool;
}

//

function convexPolygonDistance( srcSphere , polygon )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.convexPolygon.is( polygon ) );
  let sphereView = this.adapterFrom( srcSphere );

  let gotDist = this.tools.convexPolygon.sphereDistance( polygon, sphereView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a sphere to a convex polygon. Returns the calculated point.
  * Sphere and polygon remain unchanged
  *
  * @param { Array } sphere - The source sphere.
  * @param { Polygon } polygon - The source polygon.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns [ 0, 0, 3 ]
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  *  ([
  *    0,   0,   0,   0,
  *    1,   0, - 1,   0,
  *    0,   1,   0, - 1
  *  ]);
  * _.convexPolygonClosestPoint( [ 0, 0, 4, 1 ], polygon );
  *
  * @returns { Array } Returns the closest point to the polygon.
  * @function convexPolygonClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( sphere ) is not sphere
  * @throws { Error } An Error if ( polygon ) is not convexPolygon
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */
function convexPolygonClosestPoint( sphere, polygon, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  _.assert( _.convexPolygon.is( polygon ) );

  let sphereView = this.adapterFrom( sphere );
  let dimS = this.dimGet( sphereView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimS );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let dimP  = _.Matrix.DimsOf( polygon );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimS === dstPoint.length );
  _.assert( dimP[ 0 ] === dimS );

  if( this.tools.convexPolygon.sphereIntersects( polygon, sphereView ) )
  return 0
  else
  {
    let polygonPoint = this.tools.convexPolygon.sphereClosestPoint( polygon, sphereView );

    let spherePoint = this.pointClosestPoint( sphereView, polygonPoint, this.tools.vectorAdapter.from( this.tools.long.make( dimS ) ) ) ;

    for( let i = 0; i < dimS; i++ )
    {
      dstPointView.eSet( i, spherePoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

/**
  * Check if a sphere contains a frustum. Returns true if frustum is contained.
  * Frustum and sphere remain unchanged.
  *
  * @param { Sphere } srcSphere - Source sphere.
  * @param { Frustum } tstFrustum - Test frustum.
  *
  * @example
  * // returns false;
  * _.frustumContains( [ 2, 2, 2, 1 ], _.frustum.make() );
  **
  * @returns { Boolean } Returns true if the sphere contains the frustum.
  * @function frustumContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( tstFrustum ) is not frustum.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function frustumContains( srcSphere, tstFrustum )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( tstFrustum ) );

  let srcSphereView = this.adapterFrom( srcSphere );
  let center = this.centerGet( srcSphereView );
  let radius = this.radiusGet( srcSphereView );
  let dimS = this.dimGet( srcSphereView );

  let points = this.tools.frustum.cornersGet( tstFrustum );

  for( let i = 0 ; i < points.length ; i += 1 )
  {
    let point = points.colGet( i );
    let c = this.pointContains( srcSphereView, point );
    if( c === false )
    return false;
  }

  return true;
}

//

/**
  * Check if a sphere and a frustum intersect. Returns true if frustum is contained.
  * Frustum and sphere remain unchanged.
  *
  * @param { Sphere } srcSphere - Source sphere.
  * @param { Frustum } tstFrustum - Test frustum.
  *
  * @example
  * // returns false;
  * _.frustumIntersects( [ 2, 2, 2, 1 ], _.frustum.make() );
  **
  * @returns { Boolean } Returns true if the sphere and the frustum intersect, false if not.
  * @function frustumIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( tstFrustum ) is not frustum.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function frustumIntersects( srcSphere, tstFrustum )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( tstFrustum ) );
  let srcSphereView = this.adapterFrom( srcSphere );

  let gotBool = this.tools.frustum.sphereIntersects( tstFrustum, srcSphereView );

  return gotBool;
}

//

/**
  * Calculates the distance between a sphere and a frustum. Returns the calculated distance.
  * Frustum and sphere remain unchanged.
  *
  * @param { Sphere } srcSphere - Source sphere.
  * @param { Frustum } tstFrustum - Test frustum.
  *
  * @example
  * // returns 1;
  * let frustum = _.Matrix.Make( [ 4, 6 ] ).copy(
  *   [ 0,   0,   0,   0, - 1,   1,
  *     1, - 1,   0,   0,   0,   0,
  *     0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ] );
  * _.frustumDistance( [ 1, 3, 1, 1 ], frustum );
  *
  * @returns { Number } Returns the distance between sphere and frustum.
  * @function frustumDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( tstFrustum ) is not frustum.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function frustumDistance( srcSphere, tstFrustum )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( tstFrustum ) );

  let srcSphereView = this.adapterFrom( srcSphere );
  let center = this.centerGet( srcSphereView );
  let radius = this.radiusGet( srcSphereView );
  let dimS = this.dimGet( srcSphereView );

  if( this.tools.frustum.sphereIntersects( tstFrustum, srcSphereView ) )
  return 0;

  let closestPoint = this.tools.frustum.sphereClosestPoint( tstFrustum, srcSphereView );
  let distance = this.tools.avector.distance( closestPoint, center ) - radius;

  return distance;
}

//

/**
  * Calculates the closest point in a sphere to a frustum. Returns the calculated point.
  * Frustum and sphere remain unchanged.
  *
  * @param { Sphere } srcSphere - Source sphere.
  * @param { Frustum } tstFrustum - Test frustum.
  * @param { Point } dstPoint - Destination point.
  *
  * @example
  * // returns [ 2, 0, 0 ];
  * let frustum = _.Matrix.Make( [ 4, 6 ] ).copy(
  *   [ 0,   0,   0,   0, - 1,   1,
  *     1, - 1,   0,   0,   0,   0,
  *     0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ] );
  * _.frustumClosestPoint( [ 3, 0, 0, 1 ], frustum );
  *
  * @returns { Array } Returns the closest point to a frustum.
  * @function frustumClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two pr three.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( tstFrustum ) is not frustum.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function frustumClosestPoint( srcSphere, tstFrustum, dstPoint )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  _.assert( _.frustum.is( tstFrustum ) );

  if( arguments.length === 2 )
  dstPoint = [ 0, 0, 0 ];

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  let srcSphereView = this.adapterFrom( srcSphere );
  let center = this.centerGet( srcSphereView );
  let radius = this.radiusGet( srcSphereView );
  let dimS = this.dimGet( srcSphereView );

  _.assert( dimS === dstPoint.length );

  if( this.tools.frustum.sphereIntersects( tstFrustum, srcSphereView ) )
  return 0;

  let fClosestPoint = this.tools.frustum.sphereClosestPoint( tstFrustum, srcSphereView );
  let sClosestPoint = this.pointClosestPoint( srcSphereView, fClosestPoint );

  for( let i = 0; i < sClosestPoint.length; i++ )
  {
    dstPointView.eSet( i, sClosestPoint[ i ] );
  }

  return dstPoint;
}

//

/**
  * Expands an sphere with a frustum. Returns the expanded sphere.
  * Frustum remains unchanged.
  *
  * @param { Sphere } dstSphere - Destination sphere.
  * @param { Frustum } tstFrustum - Source frustum.
  *
  * @example
  * // returns [ 3, 0, 0, 3.3166247903554 ];
  * let frustum = _.Matrix.Make( [ 4, 6 ] ).copy(
  *   [ 0,   0,   0,   0, - 1,   1,
  *     1, - 1,   0,   0,   0,   0,
  *     0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ] );
  * _.frustumExpand( [ 3, 0, 0, 1 ], frustum );
  *
  * @returns { Array } Returns an array with the expanded sphere dimensions.
  * @function frustumExpand
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( tstFrustum ) is not frustum.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function frustumExpand( dstSphere, srcFrustum )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( srcFrustum ) );

  let dstSphereView = this.adapterFrom( dstSphere );
  let center = this.centerGet( dstSphereView );
  let radius = this.radiusGet( dstSphereView );
  let dimS = this.dimGet( dstSphereView );

  if( this.frustumContains( dstSphereView, srcFrustum ) )
  return dstSphere;

  let points = this.tools.frustum.cornersGet( srcFrustum );

  for( let i = 0 ; i < points.length ; i += 1 )
  {
    let point = points.colGet( i );
    if( this.pointContains( dstSphereView, point ) === false )
    this.pointExpand( dstSphereView, point )

  }

  return dstSphere;
}

//

function lineIntersects( srcSphere, tstLine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let srcSphereView = this.adapterFrom( srcSphere );
  let tstLineView = this.tools.linePointDir.adapterFrom( tstLine );

  let gotBool = this.tools.linePointDir.sphereIntersects( tstLineView, srcSphereView );

  return gotBool;
}

//

function lineDistance( srcSphere , tstLine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let srcSphereView = this.adapterFrom( srcSphere );
  let tstLineView = this.tools.linePointDir.adapterFrom( tstLine );

  let gotDist = this.tools.linePointDir.sphereDistance( tstLineView, srcSphereView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a sphere to a line. Returns the calculated point.
  * Sphere and line remain unchanged
  *
  * @param { Array } sphere - The source sphere.
  * @param { Array } line - The source line.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * let line = [ 0, 0, 0, - 1, - 1, - 1 ]
  * _.lineClosestPoint( [ 0, 0, 0, 1 ], line );
  *
  * @example
  * // returns [ 1, 0, 0 ]
  * _.lineClosestPoint( [ 2, 0, 0, 1 ], line );
  *
  * @returns { Array } Returns the closest point to the line.
  * @function lineClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( sphere ) is not sphere
  * @throws { Error } An Error if ( line ) is not line
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */
function lineClosestPoint( sphere, line, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let lineView = this.tools.linePointDir.adapterFrom( line );
  let origin = this.tools.linePointDir.originGet( lineView );
  let direction = this.tools.linePointDir.directionGet( lineView );
  let dimLine  = this.tools.linePointDir.dimGet( lineView );

  let srcSphereView = this.adapterFrom( sphere );
  let dimSphere = this.dimGet( srcSphereView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimSphere );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );


  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimSphere === dstPoint.length );
  _.assert( dimSphere === dimLine );

  if( this.tools.linePointDir.sphereIntersects( lineView, srcSphereView ) )
  return 0
  else
  {
    let linePoint = this.tools.linePointDir.sphereClosestPoint( line, srcSphereView );

    let spherePoint = this.tools.vectorAdapter.from( this.pointClosestPoint( srcSphereView, linePoint ) );

    for( let i = 0; i < dimSphere; i++ )
    {
      dstPointView.eSet( i, spherePoint.eGet( i ) );
    }

    return dstPoint;
  }
}

//

/**
  * Check if a plane and a sphere intersect.
  * Sphere and plane remain unchanged.
  *
  * @param { Array } sphere - Source sphere
  * @param { Array } plane - Source plane
  *
  * @example
  * // returns true
  * _.planeIntersects( [ 0, 0, 0, 2 ], [ 1, 0, 0, 1 ] );
  *
  * @example
  * // returns false
  * _.planeIntersects( [ 0, 0, 0, 2 ], [ 1, 0, 0, 3 ] );
  *
  * @returns { Boolean } Returns true of they intersect, false if not.
  * @function planeIntersects
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the sphere and the plane don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function planeIntersects( sphere, plane )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let sphereView = this.adapterFrom( sphere );
  let planeView = this.tools.plane.adapterFrom( plane );

  let gotBool = this.tools.plane.sphereIntersects( planeView, sphereView );

  return gotBool;
}

//

/**
  * Return the distance between a sphere and a plane.
  * Sphere and plane remain unchanged.
  *
  * @param { Array } sphere - Source sphere
  * @param { Array } plane - Source plane
  *
  * @example
  * // returns 0
  * _.planeDistance( [ 0, 0, 0, 2 ], [ 1, 0, 0, 1 ] );
  *
  * @example
  * // returns 1
  * _.planeDistance( [ 0, 0, 0, 2 ], [ 1, 0, 0, 3 ] );
  *
  * @returns { Array } Returns the calculated distance.
  * @function planeDistance
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the sphere and the plane don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function planeDistance( sphere, plane )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let sphereView = this.adapterFrom( sphere );
  let planeView = this.tools.plane.adapterFrom( plane );

  let distance = this.tools.plane.sphereDistance( planeView, sphereView );

  return distance;
}

//

/**
  * Calculate the closest point in a sphere to a plane.
  * Sphere and plane remain unchanged.
  *
  * @param { Array } sphere - Source sphere
  * @param { Array } plane - Source plane
  * @param { Array } dstPoint - Destination point
  *
  * @example
  * // returns 0
  * _.planeClosestPoint( [ 0, 0, 0, 2 ], [ 1, 0, 0, 1 ] );
  *
  * @example
  * // returns [ -2, 0, 0 ]
  * _.planeClosestPoint( [ 0, 0, 0, 2 ], [ 1, 0, 0, 3 ] );
  *
  * @returns { Array } Returns the calculated point.
  * @function planeClosestPoint
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the sphere and the plane don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function planeClosestPoint( sphere, plane, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  let sphereView = this.adapterFrom( sphere );
  let center = this.centerGet( sphereView );
  let radius = this.radiusGet( sphereView );
  let dim = this.dimGet( sphereView );

  let planeView = this.tools.plane.adapterFrom( plane );
  let normal = this.tools.plane.normalGet( planeView );
  let bias = this.tools.plane.biasGet( planeView );
  let dimP = this.tools.plane.dimGet( planeView );

  _.assert( dim === dimP );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dim );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  _.assert( dim === dstPoint.length );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  if( this.tools.plane.sphereIntersects( planeView, sphereView ) )
  return 0;

  debugger;
  // throw _.err( 'not tested' );

  let planePoint = this.tools.plane.pointCoplanarGet( planeView, center );
  let spherePoint = this.pointClosestPoint( sphereView, planePoint );

  for ( let i = 0; i < spherePoint.length; i++ )
  {
    dstPointView.eSet( i, spherePoint[ i ] );
  }

  return dstPoint;
}

//

/**
  * Expands a sphere with a plane equation.
  * Plane remains unchanged.
  *
  * @param { Array } dstSphere - Destination sphere
  * @param { Array } srcPlane - Source plane
  *
  * @example
  * // returns [ 0, 0, 0, 2 ]
  * _.planeExpand( [ 0, 0, 0, 2 ], [ 1, 0, 0, 1 ] );
  *
  * @example
  * // returns [ 0, 0, 0, 3 ]
  * _.planeExpand( [ 0, 0, 0, 2 ], [ 1, 0, 0, 3 ] );
  *
  * @returns { Array } Returns the expanded sphere.
  * @function planeExpand
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the sphere and the plane don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function planeExpand( dstSphere, srcPlane )
{
  _.assert( arguments.length === 2 , 'Expects two arguments' );

  let sphereView = this.adapterFrom( dstSphere );
  let center = this.centerGet( sphereView );
  let radius = this.radiusGet( sphereView );
  let dim = this.dimGet( sphereView );

  _.assert( _.plane.is( srcPlane ) );

  let planeView = this.tools.plane.adapterFrom( srcPlane );
  let normal = this.tools.plane.normalGet( planeView );
  let bias = this.tools.plane.biasGet( planeView );
  let dimP = this.tools.plane.dimGet( planeView );

  _.assert( dim === dimP );

  if( this.tools.plane.sphereIntersects( planeView, sphereView ) )
  return dstSphere;

  debugger;
  // throw _.err( 'not tested' );

  let planePoint = this.tools.plane.pointCoplanarGet( planeView, center );
  this.pointExpand( sphereView, planePoint );

  return dstSphere;
}

//

function rayIntersects( srcSphere, tstRay )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let srcSphereView = this.adapterFrom( srcSphere );
  let tstRayView = this.tools.ray.adapterFrom( tstRay );

  let gotBool = this.tools.ray.sphereIntersects( tstRayView, srcSphereView );

  return gotBool;
}

//

function rayDistance( srcSphere , tstRay )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let srcSphereView = this.adapterFrom( srcSphere );
  let tstRayView = this.tools.ray.adapterFrom( tstRay );

  let gotDist = this.tools.ray.sphereDistance( tstRayView, srcSphereView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a sphere to a ray. Returns the calculated point.
  * Sphere and ray remain unchanged
  *
  * @param { Array } sphere - The source sphere.
  * @param { Array } ray - The source ray.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * let ray = [ 0, 0, 0, - 1, - 1, - 1 ]
  * _.rayClosestPoint( [ 0, 0, 0, 1 ], ray );
  *
  * @example
  * // returns [ 1, 0, 0 ]
  * _.rayClosestPoint( [ 2, 0, 0, 1 ], ray );
  *
  * @returns { Array } Returns the closest point to the ray.
  * @function rayClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( sphere ) is not sphere
  * @throws { Error } An Error if ( ray ) is not ray
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */
function rayClosestPoint( sphere, ray, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let rayView = this.tools.ray.adapterFrom( ray );
  let origin = this.tools.ray.originGet( rayView );
  let direction = this.tools.ray.directionGet( rayView );
  let dimRay  = this.tools.ray.dimGet( rayView );

  let srcSphereView = this.adapterFrom( sphere );
  let dimSphere = this.dimGet( srcSphereView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimSphere );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );


  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimSphere === dstPoint.length );
  _.assert( dimSphere === dimRay );

  if( this.tools.ray.sphereIntersects( rayView, srcSphereView ) )
  return 0
  else
  {
    let rayPoint = this.tools.ray.sphereClosestPoint( ray, srcSphereView );

    let spherePoint = this.tools.vectorAdapter.from( this.pointClosestPoint( srcSphereView, rayPoint ) );

    for( let i = 0; i < dimSphere; i++ )
    {
      dstPointView.eSet( i, spherePoint.eGet( i ) );
    }

    return dstPoint;
  }
}

//

/**
  *Check if the source sphere contains the test segment. Returns true if it is contained, false if not.
  * Segment and sphere are stored in Array data structure and remain unchanged.
  *
  * @param { Array } srcSphere - The source sphere
  * @param { Array } tstSegment - The tested segment
  *
  * @example
  * // returns true
  * _.segmentContains( [ 0, 0, 2 ], [ 0.5, 0.5, 1, 1 ] );
  *
  * @example
  * // returns false
  * _.segmentContains( [ 0, 0, 2 ], [ 0, 0, 1, 2.5 ] );
  *
  * @returns { Boolean } Returns true if the segment is contained and false if not.
  * @function segmentContains
  * @throws { Error } An Error if ( dim ) is different than dimGet( segment ) ( The segment and the sphere don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment
  * @throws { Error } An Error if ( tstSphere ) is not sphere
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function segmentContains( srcSphere, tstSegment )
{

  let srcSphereView = this.adapterFrom( srcSphere );
  let srcDim = this.dimGet( srcSphereView );

  let tstSegmentView = this.tools.segment.adapterFrom( tstSegment );
  let origin = this.tools.segment.originGet( tstSegmentView );
  let end = this.tools.segment.endPointGet( tstSegmentView );
  let tstDim = this.tools.segment.dimGet( tstSegmentView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( srcDim === tstDim, 'Sphere and segment must have the same dimension' );
  debugger;
  // throw _.err( 'not tested' );
  if( !this.pointContains( srcSphereView, origin ) )
  return false;

  if( !this.pointContains( srcSphereView, end ) )
  return false;

  return true;
}

//

function segmentIntersects( srcSphere, tstSegment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let srcSphereView = this.adapterFrom( srcSphere );
  let tstSegmentView = this.tools.segment.adapterFrom( tstSegment );

  let gotBool = this.tools.segment.sphereIntersects( tstSegmentView, srcSphereView );

  return gotBool;
}

//

function segmentDistance( srcSphere , tstSegment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let srcSphereView = this.adapterFrom( srcSphere );
  let tstSegmentView = this.tools.segment.adapterFrom( tstSegment );

  let gotDist = this.tools.segment.sphereDistance( tstSegmentView, srcSphereView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a sphere to a segment. Returns the calculated point.
  * Sphere and segment remain unchanged
  *
  * @param { Array } sphere - The source sphere.
  * @param { Array } segment - The source segment.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * let segment = [ 0, 0, 0, - 1, - 1, - 1 ]
  * _.segmentClosestPoint( [ 0, 0, 0, 1 ], segment );
  *
  * @example
  * // returns [ 1, 0, 0 ]
  * _.segmentClosestPoint( [ 2, 0, 0, 1 ], segment );
  *
  * @returns { Array } Returns the closest point to the segment.
  * @function segmentClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( sphere ) is not sphere
  * @throws { Error } An Error if ( segment ) is not segment
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */
function segmentClosestPoint( sphere, segment, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let segmentView = this.tools.segment.adapterFrom( segment );
  let origin = this.tools.segment.originGet( segmentView );
  let direction = this.tools.segment.directionGet( segmentView );
  let dimSegment  = this.tools.segment.dimGet( segmentView );

  let srcSphereView = this.adapterFrom( sphere );
  let dimSphere = this.dimGet( srcSphereView );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimSphere );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );


  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimSphere === dstPoint.length );
  _.assert( dimSphere === dimSegment );

  if( this.tools.segment.sphereIntersects( segmentView, srcSphereView ) )
  return 0
  else
  {
    let segmentPoint = this.tools.segment.sphereClosestPoint( segment, srcSphereView );

    let spherePoint = this.tools.vectorAdapter.from( this.pointClosestPoint( srcSphereView, segmentPoint ) );

    for( let i = 0; i < dimSphere; i++ )
    {
      dstPointView.eSet( i, spherePoint.eGet( i ) );
    }

    return dstPoint;
  }
}

//

/**
  *Check if the source sphere contains test sphere. Returns true if it is contained, false if not.
  * Spheres are stored in Array data structure and remain unchanged
  *
  * @param { Array } srcSphere - The source sphere (container).
  * @param { Array } tstSphere - The tested sphere (the sphere to check if it is contained in srcSphere).
  *
  * @example
  * // returns true
  * _.sphereContains( [ 0, 0, 0, 2 ], [ 0.5, 0.5, 1, 1 ] );
  *
  * @example
  * // returns false
  * _.sphereContains( [ 0, 0, 0, 2 ], [ 0, 0, 1, 2.5 ] );
  *
  * @returns { Boolean } Returns true if the sphere is contained and false if not.
  * @function sphereContains
  * @throws { Error } An Error if ( dim ) is different than dimGet( sphere ) ( The two spheres don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSphere ) is not sphere
  * @throws { Error } An Error if ( tstSphere ) is not sphere
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function sphereContains( srcSphere, tstSphere )
{

  let srcSphereView = this.adapterFrom( srcSphere );
  let srcCenter = this.centerGet( srcSphereView );
  let srcRadius = this.radiusGet( srcSphereView );
  let srcDim = this.dimGet( srcSphereView );

  let tstSphereView = this.adapterFrom( tstSphere );
  let tstCenter = this.centerGet( tstSphereView );
  let tstRadius = this.radiusGet( tstSphereView );
  let tstDim = this.dimGet( tstSphereView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( srcDim === tstDim );
  debugger;
  // throw _.err( 'not tested' );

  if( !this.pointContains( srcSphereView, tstCenter ) )
  return false;

  let d = this.tools.vectorAdapter.distance( srcCenter, tstCenter ) + tstRadius;

  if( d <= srcRadius )
  return true;
  else
  return false;
}

//

/**
  * Returns true if the two spheres intersect. Spheres remain unchanged.
  *
  * @param { Array } sphere one
  * @param { Array } sphere two
  *
  * @example
  * // returns true
  * _.sphereIntersects( [ - 1, 0, 0, 2 ], [ 1, 0, 0, 2 ] );
  *
  * @example
  * // returns false
  * _.sphereIntersects( [ - 2, 0, 0, 1 ], [ 2, 0, 0, 1 ] );
  *
  * @returns { Boolean } Returns true if the two spheres intersect and false if not.
  * @function sphereIntersects
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the two spheres have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function sphereIntersects( sphere1, sphere2 )
{

  let sphereView1 = this.adapterFrom( sphere1 );
  let center1 = this.centerGet( sphereView1 );
  let radius1 = this.radiusGet( sphereView1 );
  let dim1 = this.dimGet( sphereView1 );

  let sphereView2 = this.adapterFrom( sphere2 );
  let center2 = this.centerGet( sphereView2 );
  let radius2 = this.radiusGet( sphereView2 );
  let dim2 = this.dimGet( sphereView2 );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( dim1 === dim2 );
  debugger;
  // throw _.err( 'not tested' );

  let r = radius1 + radius2;
  return this.tools.vectorAdapter.distanceSqr( center1, center2 ) <= r*r;
}

//

/**
  * Calculates the distance between two spheres. Returns the distance value, 0 if they intersect.
  * Spheres are stored in Array data structure and remain unchanged.
  *
  * @param { Array } srcSphere - The source sphere.
  * @param { Array } tstSphere - The tested sphere (the sphere to calculate the distance to).
  *
  * @example
  * // returns 0
  * _.sphereDistance( [ 0, 0, 0, 2 ], [ 0.5, 0.5, 1, 1 ] );
  *
  * @example
  * // returns 1
  * _.sphereDistance( [ 0, 0, 0, 2 ], [ 0, 0, 4, 1 ] );
  *
  * @returns { Number } Returns the calculated distance.
  * @function sphereDistance
  * @throws { Error } An Error if ( dim ) is different than dimGet( sphere ) ( The two spheres don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSphere ) is not sphere
  * @throws { Error } An Error if ( tstSphere ) is not sphere
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function sphereDistance( srcSphere, tstSphere )
{

  let _srcSphere = this.adapterFrom( srcSphere );
  let srcCenter = this.centerGet( _srcSphere );
  let srcRadius = this.radiusGet( _srcSphere );
  let srcDim = this.dimGet( _srcSphere );

  let _tstSphere = this.adapterFrom( tstSphere );
  let tstCenter = this.centerGet( _tstSphere );
  let tstRadius = this.radiusGet( _tstSphere );
  let tstDim = this.dimGet( _tstSphere );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( srcDim === tstDim );
  debugger;
  // throw _.err( 'not tested' );

  if( this.sphereIntersects( srcSphere, tstSphere ) )
  return 0;

  let distance = this.tools.vectorAdapter.distance( srcCenter, tstCenter ) - tstRadius - srcRadius;

  return distance;
}

//

/**
  * Calculates the closest point in a sphere to another sphere. Returns the calculated point.
  * Spheres are stored in Array data structure and remain unchanged.
  *
  * @param { Array } srcSphere - The source sphere.
  * @param { Array } tstSphere - The test sphere.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * _.sphereClosestPoint( [ 0, 0, 0, 2 ], [ 0.5, 0.5, 1, 1 ] );
  *
  * @example
  * // returns [ 0, 0, 2 ]
  * _.sphereClosestPoint( [ 0, 0, 0, 2 ], [ 0, 0, 4, 1 ] );
  *
  * @returns { Array } Returns the calculated point.
  * @function sphereClosestPoint
  * @throws { Error } An Error if ( dim ) is different than dimGet( sphere ) ( The two spheres don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( tstSphere ) is not sphere.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

function sphereClosestPoint( srcSphere, tstSphere, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let _srcSphere = this.adapterFrom( srcSphere );
  let srcCenter = this.centerGet( _srcSphere );
  let srcRadius = this.radiusGet( _srcSphere );
  let srcDim = this.dimGet( _srcSphere );

  let _tstSphere = this.adapterFrom( tstSphere );
  let tstCenter = this.centerGet( _tstSphere );
  let tstRadius = this.radiusGet( _tstSphere );
  let tstDim = this.dimGet( _tstSphere );

  _.assert( srcDim === tstDim );

  debugger;
  // throw _.err( 'not tested' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( srcDim );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  _.assert( srcDim === dstPoint.length );
  let dstPointv = this.tools.vectorAdapter.from( dstPoint );

  if( this.sphereIntersects( srcSphere, tstSphere ) )
  return 0;

  let point = this.pointClosestPoint( _srcSphere, tstCenter );

  for( let i = 0; i < point.length; i++ )
  {
    dstPointv.eSet( i, point[ i ] );
  }

  return dstPoint;
}

//

/**
  * Expands an sphere with a second sphere. Returns an array with the corrdinates of the expanded sphere
  *
  * @param { Array } sphereDst - Destination sphere.
  * @param { Array } sphereSrc - Source Sphere.
  *
  * @example
  * // returns [ 0, 0, 0, 3 ]
  * _.sphereExpand( [ 0, 0, 0, 2 ], [ 0, 0, 0, 3 ] );
  *
  * @returns { Array } Returns an array with the coordinates of the expanded sphere.
  * @function sphereExpand
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the two spheres have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @namespace wTools.sphere
  * @module Tools/math/Concepts
  */

// function sphereExpand( sphereDst, sphereSrc )
// {

//   let sphereViewDst = this.adapterFrom( sphereDst );
//   let centerDst = this.centerGet( sphereViewDst );
//   let radiusDst = this.radiusGet( sphereViewDst );
//   let dimDst = this.dimGet( sphereViewDst );

//   _.assert( this.is( sphereSrc ) );

//   let sphereViewSrc = this.adapterFrom( sphereSrc );
//   let centerSrc = this.centerGet( sphereViewSrc );
//   let radiusSrc = this.radiusGet( sphereViewSrc );
//   let dimSrc = this.dimGet( sphereViewSrc );

//   _.assert( arguments.length === 2, 'Expects exactly two arguments' );
//   _.assert( dimDst === dimSrc );

//   if( radiusSrc === -Infinity )
//   {
//     return sphereDst;
//   }

//   if( radiusDst === -Infinity )
//   {
//     sphereViewDst.copy( sphereViewSrc );
//     return sphereDst;
//   }

//   let distance = this.tools.vectorAdapter.distance( centerDst, centerSrc );
//   if( radiusDst < distance+radiusSrc )
//   {
//     //if( distance > 0 )
//     //this.tools.vectorAdapter.mix( centerDst, centerSrc, 0.5 + ( radiusSrc-radiusDst ) / ( distance*2 ) );

//     //if( distance > 0 )
//     //this.radiusSet( sphereViewDst, ( distance+radiusSrc+radiusDst ) / 2 );
//     this.radiusSet( sphereViewDst, ( distance + radiusSrc ) );
//     //else
//     //this.radiusSet( sphereViewDst, Math.max( radiusDst, radiusSrc ) );

//   }

//   return sphereDst;
// }

//

function sphereExpand( sphereDst, sphereSrc )
{
  let sphereViewDst = this.adapterFrom( sphereDst );
  let sphereViewSrc = this.adapterFrom( sphereSrc );

  _.assert( this.is( sphereSrc ) );

  let dimDst = this.dimGet( sphereViewDst );
  let dimSrc = this.dimGet( sphereViewSrc );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( dimDst === dimSrc );

  let dstCenter = this.centerGet( sphereViewDst );
  let srcCenter = this.centerGet( sphereViewSrc );

  let dstRadius = this.radiusGet( sphereViewDst );
  let srcRadius = this.radiusGet( sphereViewSrc );

  if( srcRadius === -Infinity )
  {
    return sphereDst;
  }

  if( dstRadius === -Infinity )
  {
    sphereViewDst.copy( sphereViewSrc );
    return sphereDst;
  }

  if( this.tools.vector.distance( dstCenter, srcCenter ) + dstRadius < srcRadius )
  {
    sphereViewDst.copy( sphereViewSrc );
    return sphereDst;
  }
  else if( this.tools.vector.distance( srcCenter, dstCenter ) + srcRadius < dstRadius )
  {
    return sphereDst;
  }

  var distance1 = this.tools.vector.distance( dstCenter, srcCenter );

  if( distance1 === 0 && dstRadius === srcRadius )
  return sphereDst;

  let radius = this.tools.vector.add( null, dstRadius, srcRadius, distance1 ) / 2;
  let center = this.tools.vector.mul( null, this.tools.vector.sub( null, srcCenter, dstCenter ), radius - dstRadius );
  let distance2 = this.tools.vector.distance( srcCenter, dstCenter );
  this.tools.vector.div( center, distance2 );
  this.tools.vector.add( center, dstCenter );

  dstCenter.assign( center );
  this.radiusSet( sphereViewDst, radius );

  return sphereDst;
}

//

function matrixHomogenousApply( sphere, matrix )
{

  let sphereView = this.adapterFrom( sphere );
  let center = this.centerGet( sphereView );
  let radius = this.radiusGet( sphereView );
  let dim = this.dimGet( sphereView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.matrixIs( matrix ) );
  _.assert( dim+1 === matrix.ncol );

  matrix.matrixHomogenousApply( center );
  this.radiusSet( sphereView, radius * matrix.scaleMaxGet() )

  return sphere;
}

//

function translate( sphere, offset )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.matrixIs( matrix ) );
  debugger;
  throw _.err( 'not tested' );

  let sphereView = this.adapterFrom( sphere );
  let center = this.centerGet( sphereView );
  let radius = this.radiusGet( sphereView );
  let dim = this.dimGet( sphereView );

  debugger;

  center.add( offset );

  return sphere;
}

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
  centeredOfRadius,

  toStr,

  from,
  adapterFrom,
  fromPoints,
  fromBox,
  fromCenterAndRadius,

  is,
  isEmpty,
  isZero,
  isNil,

  dimGet,
  centerGet,
  radiusGet,
  radiusSet,

  project,
  getProjectionFactors,

  pointContains,
  pointDistance,
  pointClosestPoint, /* qqq : implement me - Already implemented - to test */
  pointExpand,

  boxContains, /* qqq : implement me */
  boxIntersects,
  boxDistance, /* qqq : implement me - Same as _.box.sphereDistance */
  boxClosestPoint, /* qqq : implement me */
  boxExpand,
  boundingBoxGet,

  capsuleContains,
  capsuleIntersects,
  capsuleDistance,
  capsuleClosestPoint,

  convexPolygonContains,
  convexPolygonIntersects,
  convexPolygonDistance,
  convexPolygonClosestPoint,

  frustumContains, /* qqq : implement me */
  frustumIntersects, /* qqq : implement me - Same as _.frustum.sphereIntersects */
  frustumDistance, /* qqq : implement me */
  frustumClosestPoint, /* qqq : implement me */
  frustumExpand, /* qqq : implement me */

  lineIntersects, /* Same as _.linePointDir.sphereIntersects */
  lineDistance,  /* Same as _.linePointDir.sphereDistance */
  lineClosestPoint,

  planeIntersects, /* qqq : implement me - Same as _.plane.sphereIntersects */
  planeDistance, /* qqq : implement me - Same as _.plane.sphereDistance */
  planeClosestPoint, /* qqq : implement me */
  planeExpand, /* qqq : implement me */

  rayIntersects, /* Same as _.ray.sphereIntersects */
  rayDistance,  /* Same as _.ray.sphereDistance */
  rayClosestPoint,

  segmentContains,
  segmentIntersects, /* Same as _.segment.sphereIntersects */
  segmentDistance,  /* Same as _.segment.sphereDistance */
  segmentClosestPoint,

  sphereContains, /* qqq : implement me */
  sphereIntersects,
  sphereDistance, /* qqq : implement me */
  sphereClosestPoint, /* qqq : implement me */
  sphereExpand,

  matrixHomogenousApply,
  translate,

  // ref

  tools : _,

}

/* _.props.extend */Object.assign( _.sphere, Extension );

})();
