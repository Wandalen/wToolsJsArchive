(function _Triangle_s_(){

'use strict';

const _ = _global_.wTools;
_.triangle = _.triangle || Object.create( _.avector );

/**
 * @description
 * A triangle is a polygon with three edges and three vertices.
 *
 * For the following functions, triangle must have the shape [ x1,y1,z1, x2,y2,z2, x3,y3,z3 ].
 * @namespace wTools.triangle
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
  let result = _.dup( 0, dim*3 );
  return result;
}

//

function from( triangle )
{

  _.assert( this.is( triangle ) || triangle === null );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( triangle === null )
  return this.make();

  return triangle;
}

//

/**
  * Check if input is a triangle. Returns true if it is a triangle and false if not.
  *
  * @param { Vector } triangle - Source triangle.
  *
  * @example
  * // returns true;
  * _.triangle.is( [ 0, 0, 1, 1, 0, 0 ] );
  *
  * @returns { Boolean } Returns true if the input is triangle.
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @namespace wTools.triangle
  * @module Tools/math/Concepts
  */

function is( triangle )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return ( _.longIs( triangle ) || _.vectorAdapterIs( triangle ) ) && ( triangle.length % 3 === 0 );
}

//

/**
  * Get triangle dimension. Returns the dimension of the triangle. Triangle stays untouched.
  *
  * @param { Vector } triangle - The source triangle.
  *
  * @example
  * // returns 2
  * _.dimGet( [ 0, 0, 2, 2, 0, 0 ] );
  *
  * @returns { Number } Returns the dimension of the triangle.
  * @function dimGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( triangle ) is not triangle.
  * @namespace wTools.triangle
  * @module Tools/math/Concepts
  */
function dimGet( triangle )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( this.is( triangle ) );
  return triangle.length / 3;
}

//

function pointContains( tri, point )
{
  _.assert( this.is( tri ) );
  _.assert( arguments.length === 2 );
  _.assert( point.length === 2, 'not implemented' );
  _.assert( this.dimGet( tri ) === 2, 'not implemented' );

  let triView = this.vectorAdapter.from( tri );

  let s1 = this.tools.linePointDir.pointsToPointSide( [ triView.eGet( 0 ), triView.eGet( 1 ) , triView.eGet( 2 ), triView.eGet( 3 ) ], point );

  let s2 = this.tools.linePointDir.pointsToPointSide( [ triView.eGet( 2 ), triView.eGet( 3 ), triView.eGet( 4 ), triView.eGet( 5 ) ], point );
  if( s1*s2 < 0 )
  return false;

  let s3 = this.tools.linePointDir.pointsToPointSide( [ triView.eGet( 4 ), triView.eGet( 5 ), triView.eGet( 0 ), triView.eGet( 1 ) ], point );
  if( s1*s3 < 0 )
  return false;

  return true;
}

//

function pointDistance( tri, point )
{
  _.assert( arguments.length === 2 );
  _.assert( this.is( tri ) );

  let triView = this.vectorAdapter.from( tri );
  let d = this.dimGet( tri );

  _.assert( d === point.length );

  let tri0Point = triView.review([ 0, d - 1 ]);
  let tri1Point = triView.review([ tri0Point.length, 2 * d - 1 ]);
  let tri2Point = triView.review([ tri1Point.offset + tri1Point.length, triView.length - 1 ]);

  let polygon = this.tools.convexPolygon.make( 3, d );

  polygon.colGet( 0 ).copy( tri0Point )
  polygon.colGet( 1 ).copy( tri1Point )
  polygon.colGet( 2 ).copy( tri2Point )

  return this.tools.convexPolygon.pointDistance( polygon, point );
}

//

/* function distanceToTri( tri, pos ) {

    let p0 = pos.slice();
    let p1 = tri[ 1 ].slice();
    let p2 = tri[ 2 ].slice();

    p0.sub( tri[ 0 ] );
    p1.sub( tri[ 0 ] );
    p2.sub( tri[ 0 ] );

    p1.cross( p2 ).normalize();
    let result = Math.abs( p1.dot( p0 ) );
    return result;

} */

function pointDistance3D( tri, point )
{
  _.assert( arguments.length === 2 );
  _.assert( this.is( tri ) );

  let triView = this.vectorAdapter.from( tri );
  let pointView = this.vectorAdapter.from( point );
  let d = this.dimGet( tri );

  _.assert( d === 3, 'implemented only for 3D' );
  _.assert( d === pointView.length );

  let tri0Point = triView.review([ 0, d - 1 ]);
  let tri1Point = triView.review([ tri0Point.length, 2 * d - 1 ]);
  let tri2Point = triView.review([ tri1Point.offset + tri1Point.length, triView.length - 1 ]);

  let p0 = this.tools.vectorAdapter.sub( null, pointView, tri0Point );
  let p1 = this.tools.vectorAdapter.sub( null, tri1Point, tri0Point );
  let p2 = this.tools.vectorAdapter.sub( null, tri2Point, tri0Point );

  let cross = this.tools.vectorAdapter.cross( null, p1, p2 ).normalize();

  let result = Math.abs( this.tools.vectorAdapter.dot( cross, p0 ) );
  return result;

}

// --
// declare
// --


let Extension = /* qqq xxx : normalize order */
{
  make,
  makeZero,

  from,

  is,
  dimGet,

  pointContains,
  pointDistance,
  pointDistance3D,

  // ref

  tools : _,
}

/* _.props.extend */Object.assign( _.triangle, Extension );

})();
