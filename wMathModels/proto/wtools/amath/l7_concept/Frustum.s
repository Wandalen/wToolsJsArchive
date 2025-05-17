(function _Frustum_s_(){

'use strict';

const _ = _global_.wTools;
_.frustum = _.frustum || Object.create( _.avector );

/**
 * @description
 * A frustum is the portion of a solid ( normally a pyramid )
 * which lies between two parallel planes cutting the solid.
 *
 * In the following methods, frustums will be defined by a space where each column
 * represents one of the frustum planes.
 *
 *
 * Frustums are defined in a very special way, and therefore planes must be included following
 * an order:
 * Frustum planes convention : [ right, left, bottom, top, far, near ];
 * Frustum planes must have director vectors pointing outside frustum!!!;
 *
 * If this convention is not followed when creating a frustum, routines may return
 * wrong results.
 *
 * The frustum representation of the box [ 0, 0, 0, 1, 1, 1 ] would be:
 * ```
 * var srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
 * ([
 *   -1,  0,   0,  -1,   0,  -1,
 *   0,   0,   0,   0,  -1,   1,
 *   1,  -1,   0,   0,   0,   0,
 *   0,   0,  -1,   1,   0,   0,
 * ]);
 * ```
 * Where all director vectors point outwards the frustum.
 *
 * Frustum planes convention : right, left, bottom, top, far, near;
 * Frustum planes must have director vectors pointing outside frustum;
 * @namespace wTools.frustum
  * @module Tools/math/Concepts
 */

// --
// implementation
// --

function make()
{
  _.assert( arguments.length === 0, 'Expects no arguments' );

  let dst = _.Matrix.Make([ 4, 6 ]);

  return dst;
}

//

function fromMatrixHomogenous( frustum , m )
{
  // let frustum , m;

  if( frustum === null )
  frustum = this.make();

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( frustum ) );
  _.assert( _.matrixIs( m ) );
  _.assert( m.hasShape([ 4, 4 ]) );

  frustum.colGet( 0 ).copy
  ([
    m.scalarGet([ 3, 3 ]) - m.scalarGet([ 0, 3 ]),
    m.scalarGet([ 3, 0 ]) - m.scalarGet([ 0, 0 ]),
    m.scalarGet([ 3, 1 ]) - m.scalarGet([ 0, 1 ]),
    m.scalarGet([ 3, 2 ]) - m.scalarGet([ 0, 2 ])
  ]);

  frustum.colGet( 1 ).copy
  ([
    m.scalarGet([ 3, 3 ]) + m.scalarGet([ 0, 3 ]),
    m.scalarGet([ 3, 0 ]) + m.scalarGet([ 0, 0 ]),
    m.scalarGet([ 3, 1 ]) + m.scalarGet([ 0, 1 ]),
    m.scalarGet([ 3, 2 ]) + m.scalarGet([ 0, 2 ])
  ]);

  frustum.colGet( 2 ).copy
  ([
    m.scalarGet([ 3, 3 ]) + m.scalarGet([ 1, 3 ]),
    m.scalarGet([ 3, 0 ]) + m.scalarGet([ 1, 0 ]),
    m.scalarGet([ 3, 1 ]) + m.scalarGet([ 1, 1 ]),
    m.scalarGet([ 3, 2 ]) + m.scalarGet([ 1, 2 ]),
  ]);

  frustum.colGet( 3 ).copy
  ([
    m.scalarGet([ 3, 3 ]) - m.scalarGet([ 1, 3 ]),
    m.scalarGet([ 3, 0 ]) - m.scalarGet([ 1, 0 ]),
    m.scalarGet([ 3, 1 ]) - m.scalarGet([ 1, 1 ]),
    m.scalarGet([ 3, 2 ]) - m.scalarGet([ 1, 2 ]),
  ]);

  frustum.colGet( 4 ).copy
  ([
    m.scalarGet([ 3, 3 ]) - m.scalarGet([ 2, 3 ]),
    m.scalarGet([ 3, 0 ]) - m.scalarGet([ 2, 0 ]),
    m.scalarGet([ 3, 1 ]) - m.scalarGet([ 2, 1 ]),
    m.scalarGet([ 3, 2 ]) - m.scalarGet([ 2, 2 ]),
  ]);

  frustum.colGet( 5 ).copy
  ([
    m.scalarGet([ 3, 3 ]) + m.scalarGet([ 2, 3 ]),
    m.scalarGet([ 3, 0 ]) + m.scalarGet([ 2, 0 ]),
    m.scalarGet([ 3, 1 ]) + m.scalarGet([ 2, 1 ]),
    m.scalarGet([ 3, 2 ]) + m.scalarGet([ 2, 2 ]),
  ]);

  return frustum;
}

//

function is( frustum )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return _.matrixIs( frustum ) && frustum.hasShape([ 4, 6 ])
}

//

/**
  * Returns the coordinates of the corners of a frustum. Returns an space object where each column is a point.
  * Frustum remain unchanged. Frustum need to follow planes convention ( see top of the file )
  *
  * @param { Frustum } srcfrustum - Source frustum.
  *
  * @example
  * // returns furstumCorners =
  * [
  *   0, 0, 0, 0, 1, 1, 1, 1,
  *   1, 0, 1, 0, 1, 0, 1, 0,
  *   1, 1, 0, 0, 1, 1, 0, 0,
  * ];
  * let srcfrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1,
  * ]);
  *
  * _.cornersGet( srcfrustum );
  *
  * @returns { Matrix } Returns the coordintes of the points in the frustum corners.
  * @function cornersGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function cornersGet( srcfrustum )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( this.is( srcfrustum ) );

  let dims = _.Matrix.DimsOf( srcfrustum ) ;
  let rows = dims[ 0 ];
  let cols = dims[ 1 ];
  let pointsFru = _.Matrix.MakeZero( [ rows - 1, cols + 2 ] );

  let right = this.tools.vectorAdapter.from(srcfrustum.colGet( 0 ));
  let left = srcfrustum.colGet( 1 );
  let top = srcfrustum.colGet( 2 );
  let bottom = srcfrustum.colGet( 3 );
  let far = srcfrustum.colGet( 4 );
  let near = srcfrustum.colGet( 5 );

  let point = this.tools.plane.threeIntersectionPoint( far, top, right );
  if( ! _.vectorAdapterIs(point) )
  {
    return false;
  }
  else
  {
    pointsFru.scalarSet( [ 0, 0 ], point.eGet( 0 ) );
    pointsFru.scalarSet( [ 1, 0 ], point.eGet( 1 ) );
    pointsFru.scalarSet( [ 2, 0 ], point.eGet( 2 ) );
  }

  point =  this.tools.plane.threeIntersectionPoint( far, top, left );
  if( ! _.vectorAdapterIs( point ) )
  {
    return false;
  }
  else
  {
    pointsFru.scalarSet( [ 0, 1 ], point.eGet( 0 ) );
    pointsFru.scalarSet( [ 1, 1 ], point.eGet( 1 ) );
    pointsFru.scalarSet( [ 2, 1 ], point.eGet( 2 ) );
  }

  point =  this.tools.plane.threeIntersectionPoint( far, bottom, right );
  if( ! _.vectorAdapterIs( point) )
  {
    return false;
  }
  else
  {
    pointsFru.scalarSet( [ 0, 2 ], point.eGet( 0 ) );
    pointsFru.scalarSet( [ 1, 2 ], point.eGet( 1 ) );
    pointsFru.scalarSet( [ 2, 2 ], point.eGet( 2 ) );
  }

  point =  this.tools.plane.threeIntersectionPoint( far, bottom, left );
  if( ! _.vectorAdapterIs( point) )
  {
    return false;
  }
  else
  {
    pointsFru.scalarSet( [ 0, 3 ], point.eGet( 0 ) );
    pointsFru.scalarSet( [ 1, 3 ], point.eGet( 1 ) );
    pointsFru.scalarSet( [ 2, 3 ], point.eGet( 2 ) );
  }

  point = this.tools.plane.threeIntersectionPoint( near, top, right );
  if( ! _.vectorAdapterIs( point) )
  {
    return false;
  }
  else
  {
    pointsFru.scalarSet( [ 0, 4 ], point.eGet( 0 ) );
    pointsFru.scalarSet( [ 1, 4 ], point.eGet( 1 ) );
    pointsFru.scalarSet( [ 2, 4 ], point.eGet( 2 ) );
  }

  point =  this.tools.plane.threeIntersectionPoint( near, top, left );
  if( ! _.vectorAdapterIs(point) )
  {
    return false;
  }
  else
  {
    pointsFru.scalarSet( [ 0, 5 ], point.eGet( 0 ) );
    pointsFru.scalarSet( [ 1, 5 ], point.eGet( 1 ) );
    pointsFru.scalarSet( [ 2, 5 ], point.eGet( 2 ) );
  }

  point =  this.tools.plane.threeIntersectionPoint( near, bottom, right );
  if( ! _.vectorAdapterIs(point) )
  {
    return false;
  }
  else
  {
    pointsFru.scalarSet( [ 0, 6 ], point.eGet( 0 ) );
    pointsFru.scalarSet( [ 1, 6 ], point.eGet( 1 ) );
    pointsFru.scalarSet( [ 2, 6 ], point.eGet( 2 ) );
  }

  point = this.tools.plane.threeIntersectionPoint( near, bottom, left );
  if( ! _.vectorAdapterIs(point) )
  {
    return false;
  }
  else
  {
    pointsFru.scalarSet( [ 0, 7 ], point.eGet( 0 ) );
    pointsFru.scalarSet( [ 1, 7 ], point.eGet( 1 ) );
    pointsFru.scalarSet( [ 2, 7 ], point.eGet( 2 ) );
  }

  return pointsFru;
}

//

/**
  * Check if a frustum contains a point. Returns true if it contains it.
  * Frustum and point remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Array } point - Source point.
  *
  * @example
  * // returns false;
  * _.pointContains( this.make() , [ 1, 1, 1 ] );
  **
  * @returns { Boolean } Returns true if the frustum contains the point.
  * @function pointContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( point ) is not point.
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function pointContains( frustum , point )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( frustum ) );

  debugger;

  for( let i = 0 ; i < 6 ; i += 1 )
  {

    let plane = frustum.colGet( i );

    if( this.tools.plane.pointDistance( plane, point ) > 1E-12 )
    return false;

  }

  return true;
}

//

/**
  * Calculates the distance between a frustum and a point. Returns the calculated distance.
  * Frustum and point remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Array } point - Source point.
  *
  * @example
  * // returns 1;
  * let frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *     0,   0,   0,   0, - 1,   1,
  *     1, - 1,   0,   0,   0,   0,
  *     0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ]
  * );
  * _.pointDistance( frustum, [ 1, 1, 2 ] );
  **
  * @returns { Distance } Returns the distance between the frustum and the point.
  * @function pointDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( point ) is not point.
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function pointDistance( frustum, point )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( frustum ) );

  let dims = _.Matrix.DimsOf( frustum ) ;
  let rows = dims[ 0 ];
  let cols = dims[ 1 ];
  _.assert( rows - 1 === point.length );

  if( this.pointContains( frustum, point ) )
  return 0;

  let corners = this.cornersGet( frustum );

  let distanceCorner = Infinity;
  let distancePlane = Infinity;
  for( let i = 0 ; i < 6 ; i ++ )
  {
    let plane = frustum.colGet( i );

    let newDistPlane = Math.abs( this.tools.plane.pointDistance( plane, point ) );
    if( newDistPlane < distancePlane )
    {
      let projection = this.tools.plane.pointCoplanarGet( plane, point );
      if( this.pointContains( frustum, projection ))
      {
        distancePlane = newDistPlane;
      }
    }
  }

  for( let i = 0 ; i < 8 ; i++ )
  {
    let corner = corners.colGet( i );
    let newDistCorner = this.tools.avector.distance( point, corner );
    if( newDistCorner < distanceCorner )
    distanceCorner = newDistCorner;

  }
  let distance = distanceCorner;

  if( distancePlane < distance )
  distance = distancePlane;

  return distance;
}

//

/**
  * Returns the closest point in a frustum to a point. Returns the coordinates of the closest point.
  * Frustum and point remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Array } srcpoint - Source point.
  * @param { Array } dstPoint - Source point.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * let frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);
  * _.pointClosestPoint( frustum , [ - 1, - 1, - 1 ] );
  *
  * @returns { Array } Returns the array of coordinates of the closest point in the frustum.
  * @function pointClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( srcPoint ) is not point.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

/* qqq : dstPoint is destination */

function pointClosestPoint( frustum , srcPoint, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  _.assert( this.is( frustum ) );

  if( arguments.length === 2 )
  dstPoint = [ 0, 0, 0 ];

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  // let srcPointVector = this.tools.vectorAdapter.from( srcPoint );  /* xxx qqq : problem? */
  // let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  // let dims = _.Matrix.DimsOf( frustum ) ;

  if( this.pointContains( frustum, srcPoint ) )
  return 0;

  let srcPointView = this.tools.vectorAdapter.from( srcPoint );  /* xxx qqq : problem? */
  let dstPointView = this.tools.vectorAdapter.from( dstPoint );
  let dims = _.Matrix.DimsOf( frustum ) ;

  let rows = dims[ 0 ];
  let cols = dims[ 1 ];
  let fpoints = this.cornersGet( frustum );
  _.assert( _.matrixIs( fpoints ) );
  _.assert( fpoints.hasShape( [ 3, 8 ] ) );
  _.assert( rows - 1 === srcPointView.length );
  _.assert( dstPointView.length === srcPointView.length );

  let max = this.tools.vectorAdapter.from( fpoints.colGet( 0 ).slice() );
  let min = this.tools.vectorAdapter.from( fpoints.colGet( 0 ).slice() );

  for( let j = 1 ; j < _.Matrix.DimsOf( fpoints )[ 1 ] ; j++ )
  {
    let newp = fpoints.colGet( j );

    if( newp.eGet( 0 ) < min.eGet( 0 ) )
    {
      min.eSet( 0, newp.eGet( 0 ) );
    }
    if( newp.eGet( 1 ) < min.eGet( 1 ) )
    {
      min.eSet( 1, newp.eGet( 1 ) );
    }
    if( newp.eGet( 2 ) < min.eGet( 2 ) )
    {
      min.eSet( 2, newp.eGet( 2 ) );
    }
    if( newp.eGet( 0 ) > max.eGet( 0 ) )
    {
      max.eSet( 0, newp.eGet( 0 ) );
    }
    if( newp.eGet( 1 ) > max.eGet( 1 ) )
    {
      max.eSet( 1, newp.eGet( 1 ) );
    }
    if( newp.eGet( 2 ) > max.eGet( 2 ) )
    {
      max.eSet( 2, newp.eGet( 2 ) );
    }
  }

  for( let i = 0 ; i < 3 ; i++ )
  {
    if( srcPointView.eGet( i ) >= max.eGet( i ) )
    {
      dstPointView.eSet( i, max.eGet( i ) );
    }
    else if( srcPointView.eGet( i ) <= min.eGet( i ) )
    {
      dstPointView.eSet( i, min.eGet( i ) );
    }
    else
    {
      dstPointView.eSet( i, srcPointView.eGet( i ) );
    }
  }

  if( this.pointContains( frustum, dstPointView ) === true )
  {
    return dstPoint;
  }

  else
  {
    let d0 = Infinity;
    let finalPoint = this.tools.vectorAdapter.from( dstPointView.slice() );

    for( let i = 0 ; i < cols ; i++ )
    {
      let plane = this.tools.vectorAdapter.from( frustum.colGet( i ) );

      let p =  this.tools.plane.pointCoplanarGet( plane, dstPointView );

      let d = this.tools.avector.distance( dstPointView, p );

      let pVector = this.tools.vectorAdapter.from( p );
      if( d < d0  && this.pointContains( frustum, pVector ) )
      {
        for( var j = 0; j < finalPoint.length; j++ )
        {
          finalPoint.eSet( j, pVector.eGet( j ) );
        }

        d0 = d;
      }
    }

    for( var i = 0; i < finalPoint.length ; i++ )
    {
      dstPointView.eSet( i, finalPoint.eGet( i ) );
    }
    logger.log( dstPointView )
    _.assert( this.pointContains( frustum, dstPointView ) === true );
    return dstPoint;
  }
}

//

/**
  * Check if a frustum contains a box. Returns true if the frustrum contains the box.
  * Frustum and box remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Array } box - Source box.
  *
  * @example
  * // returns false;
  * _.boxContains( this.make() , [ 2, 2, 2, 3, 3, 3 ] );
  **
  * @returns { Boolean } Returns true if the frustum contains the box.
  * @function boxContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( box ) is not box.
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function boxContains( frustum, box )
{

  let boxView = this.tools.box.adapterFrom( box );
  let dim1 = this.tools.box.dimGet( boxView );
  let srcMin = this.tools.box.cornerLeftGet( boxView );
  let srcMax = this.tools.box.cornerRightGet( boxView );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( frustum ) );

  let dims = _.Matrix.DimsOf( frustum ) ;
  let rows = dims[ 0 ];
  let cols = dims[ 1 ];
  _.assert( rows -1 === dim1 );

  /* src corners */

  let c = _.Matrix.MakeZero( [ 3, 8 ] );
  c.colGet( 0 ).copy( [ srcMin.eGet( 0 ), srcMin.eGet( 1 ), srcMin.eGet( 2 ) ] );
  c.colGet( 1 ).copy( [ srcMax.eGet( 0 ), srcMin.eGet( 1 ), srcMin.eGet( 2 ) ] );
  c.colGet( 2 ).copy( [ srcMin.eGet( 0 ), srcMax.eGet( 1 ), srcMin.eGet( 2 ) ] );
  c.colGet( 3 ).copy( [ srcMin.eGet( 0 ), srcMin.eGet( 1 ), srcMax.eGet( 2 ) ] );
  c.colGet( 4 ).copy( [ srcMax.eGet( 0 ), srcMax.eGet( 1 ), srcMax.eGet( 2 ) ] );
  c.colGet( 5 ).copy( [ srcMin.eGet( 0 ), srcMax.eGet( 1 ), srcMax.eGet( 2 ) ] );
  c.colGet( 6 ).copy( [ srcMax.eGet( 0 ), srcMin.eGet( 1 ), srcMax.eGet( 2 ) ] );
  c.colGet( 7 ).copy( [ srcMax.eGet( 0 ), srcMax.eGet( 1 ), srcMin.eGet( 2 )] );

  let distance = Infinity;
  for( let j = 0 ; j < 8 ; j++ )
  {
    let srcCorner = c.colGet( j );
    if( this.pointContains( frustum, srcCorner ) === false )
    {
      return false;
    }
  }

  return true;

}

//

/**
  * Check if a frustum and a box intersect. Returns true if they intersect.
  * Frustum and box remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Array } box - Source box.
  *
  * @example
  * // returns false;
  * _.boxIntersects( this.make() , [ 2, 2, 2, 3, 3, 3 ] );
  **
  * @returns { Boolean } Returns true if the frustum and the box intersect.
  * @function boxIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( box ) is not box.
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function boxIntersects( frustum , box )
{

  let boxView = this.tools.box.adapterFrom( box );
  let dim1 = this.tools.box.dimGet( boxView );
  let min1 = this.tools.box.cornerLeftGet( boxView );
  let max1 = this.tools.box.cornerRightGet( boxView );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( frustum ) );

  let c0 = this.tools.vectorAdapter.from( min1.slice() );
  let c4 = this.tools.vectorAdapter.from( max1.slice() );

  let c1 = this.tools.vectorAdapter.from( c0.slice() ); c1.eSet( 0, c4.eGet( 0 ) );
  let c2 = this.tools.vectorAdapter.from( c0.slice() ); c2.eSet( 1, c4.eGet( 1 ) );
  let c3 = this.tools.vectorAdapter.from( c0.slice() ); c3.eSet( 2, c4.eGet( 2 ) );
  let c5 = this.tools.vectorAdapter.from( c4.slice() ); c5.eSet( 0, c0.eGet( 0 ) );
  let c6 = this.tools.vectorAdapter.from( c4.slice() ); c6.eSet( 1, c0.eGet( 1 ) );
  let c7 = this.tools.vectorAdapter.from( c4.slice() ); c7.eSet( 2, c0.eGet( 2 ) );

  if( this.pointContains( frustum, c0 ) === true )
  {
    return true;
  }
  else if( this.pointContains( frustum, c1 ) === true )
  {
    return true;
  }
  else if( this.pointContains( frustum, c2 ) === true )
  {
    return true;
  }
  else if( this.pointContains( frustum, c3 ) === true )
  {
    return true;
  }
  else if( this.pointContains( frustum, c4 ) === true )
  {
    return true;
  }
  else if( this.pointContains( frustum, c5 ) === true )
  {
    return true;
  }
  else if( this.pointContains( frustum, c6 ) === true )
  {
    return true;
  }
  else if( this.pointContains( frustum, c7 ) === true )
  {
    return true;
  }

  let fpoints = this.cornersGet( frustum );
  _.assert( _.matrixIs( fpoints ) );

  for( let i = 0 ; i < 6 ; i ++ )
  {
    let point = fpoints.colGet( i );

    if( this.tools.box.pointContains( box, point ) === true )
    {
      return true;
    }
  }
  return false;
}

//function boxIntersects( frustum , box )
//{
//
//  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
//  _.assert( this.is( frustum ) );
//  debugger;
//
//  let p1 = [];
//  let p2 = [];
//
//  for( let i = 0 ; i < 6 ; i += 1 )
//  {
//    let plane = frustum.colGet( i );
//
//    p1 = _.box.cornerLeftGet( box );
//    p2 = _.box.cornerRightGet( box );
//
//    let d1 = _.plane.pointDistance( plane, p1 );
//    let d2 = _.plane.pointDistance( plane, p2 );
//
//    if( d1 < 0 && d2 < 0 )
//    return false;
//
//  }
//
//  return true;
//}

//

/**
  * Get the distance between a frustum and a box. Returns the calculated distance.
  * Frustum and box remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Array } box - Source box.
  *
  * @example
  * // returns 1;
  * let frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);
  * _.boxDistance( frustum , [ 0, 0, 2, 3, 3, 3 ] );
  *
  * @returns { Number } Returns the distance between the frustum and the box.
  * @function boxDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( box ) is not box.
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function boxDistance( frustum, box )
{
  let boxView = this.tools.box.adapterFrom( box );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( frustum ) );

  let distance = this.tools.box.frustumDistance( boxView, frustum );

  return distance;
}

//

/**
  * Returns the closest point in a frustum to a box. Returns the coordinates of the closest point.
  * Frustum and box remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Array } box - Source box.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * let frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);
  * _.boxClosestPoint( frustum , [ - 1, - 1, - 1, -0.1, -0.1, -0.1 ] );
  *
  * @returns { Array } Returns the array of coordinates of the closest point in the frustum.
  * @function boxClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( box ) is not box.
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function boxClosestPoint( frustum, box, dstPoint )
{
  let boxView = this.tools.box.adapterFrom( box );
  let dim1 = this.tools.box.dimGet( boxView );
  let min1 = this.tools.box.cornerLeftGet( boxView );
  let max1 = this.tools.box.cornerRightGet( boxView );
  let dims = _.Matrix.DimsOf( frustum ) ;
  let rows = dims[ 0 ];
  let cols = dims[ 1 ];

  _.assert( this.is( frustum ) );
  _.assert( dim1 === rows - 1 );
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( rows - 1 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  if( this.boxIntersects( frustum, boxView ) )
  return 0;

  let point = this.tools.vectorAdapter.from( this.tools.long.make( rows - 1 ) );

  /* frustum corners */

  let fpoints = this.cornersGet( frustum );
  let dist = Infinity;
  for ( let j = 0 ; j < cols ; j++ )
  {
    let newp = fpoints.colGet( j );
    let d = this.tools.box.pointDistance( boxView, newp );

    if( d < dist )
    {
      point = this.tools.vectorAdapter.from( newp.slice() );
      dist = d;
    }
  }

  /* box corners */
  let c = this.tools.box.cornersGet( boxView );

  for( let j = 0 ; j < _.Matrix.DimsOf( c )[ 1 ] ; j++ )
  {
    let corner = c.colGet( j );
    let proj = this.pointClosestPoint( frustum, corner );
    let d = this.tools.avector.distance( corner, proj );
    if( d < dist )
    {
      point = this.tools.vectorAdapter.from( proj.slice() );
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
  * Get the bounding box of a frustum. Returns destination box.
  * Frustum and box are stored in Array data structure. Source frustum stays untouched.
  *
  * @param { Array } dstBox - destination box.
  * @param { Array } srcFrustum - source frustum for the bounding box.
  *
  * @example
  * // returns [ 0, 0, 0, 1, 1, 1 ]
  * let frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);
  * _.boundingBoxGet( null, frustum );
  *
  * @returns { Array } Returns the array of the bounding box.
  * @function boundingBoxGet
  * @throws { Error } An Error if ( dim ) is different than dimGet(frustum) (the frustum and the box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstBox ) is not box
  * @throws { Error } An Error if ( srcFrustum ) is not frustum
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function boundingBoxGet( dstBox, srcFrustum )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  _.assert( this.is( srcFrustum ) );
  let dims = _.Matrix.DimsOf( srcFrustum ) ;
  let rows = dims[ 0 ];
  let cols = dims[ 1 ];
  let fpoints = this.cornersGet( srcFrustum );
  _.assert( _.matrixIs( fpoints ) );
  _.assert( fpoints.hasShape( [ 3, 8 ] ) );

  if( dstBox === null || dstBox === undefined )
  dstBox = this.tools.box.makeSingular( rows - 1 );

  _.assert( _.box.is( dstBox ) );
  let boxView = this.tools.box.adapterFrom( dstBox );
  let minB = this.tools.box.cornerLeftGet( boxView );
  let maxB = this.tools.box.cornerRightGet( boxView );
  let dimB = this.tools.box.dimGet( boxView );

  _.assert( rows - 1 === dimB );

  // Frustum limits
  let maxF = this.tools.vectorAdapter.from( fpoints.colGet( 0 ).slice() );
  let minF = this.tools.vectorAdapter.from( fpoints.colGet( 0 ).slice() );
  // let maxF = fpoints.colGet( 0 ).clone();
  // let minF = fpoints.colGet( 0 ).clone();

  for( let j = 1 ; j < _.Matrix.DimsOf( fpoints )[ 1 ] ; j++ )
  {
    let newp = fpoints.colGet( j );

    if( newp.eGet( 0 ) < minF.eGet( 0 ) )
    {
      minF.eSet( 0, newp.eGet( 0 ) );
    }
    if( newp.eGet( 1 ) < minF.eGet( 1 ) )
    {
      minF.eSet( 1, newp.eGet( 1 ) );
    }
    if( newp.eGet( 2 ) < minF.eGet( 2 ) )
    {
      minF.eSet( 2, newp.eGet( 2 ) );
    }
    if( newp.eGet( 0 ) > maxF.eGet( 0 ) )
    {
      maxF.eSet( 0, newp.eGet( 0 ) );
    }
    if( newp.eGet( 1 ) > maxF.eGet( 1 ) )
    {
      maxF.eSet( 1, newp.eGet( 1 ) );
    }
    if( newp.eGet( 2 ) > maxF.eGet( 2 ) )
    {
      maxF.eSet( 2, newp.eGet( 2 ) );
    }
  }


  for( let b = 0; b < dimB; b++ )
  {
    minB.eSet( b, minF.eGet( b ) );
    maxB.eSet( b, maxF.eGet( b ) );
  }

  return dstBox;
}

//

/**
  * Check if a frustum contains a capsule. Returns true it contains the capsule.
  * Frustum and capsule remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Sphere } capsule - Source capsule.
  *
  * @example
  * // returns false;
  * let frustum = _.Matrix.Make( [ 4, 6 ] ).copy(
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);
  * _.capsuleContains( frustum , [ 0, 0, 0, 2, 2, 2, 1 ] );
  *
  * @returns { Boolean } Returns true if the frustum contains the capsule.
  * @function capsuleContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( capsule ) is not capsule.
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function capsuleContains( frustum , capsule )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( frustum ) );
  let dims = _.Matrix.DimsOf( frustum );

  let capsuleView = this.tools.capsule.adapterFrom( capsule );
  let dimC = this.tools.capsule.dimGet( capsuleView );
  let origin = this.tools.vectorAdapter.from( this.tools.capsule.originGet( capsuleView ) );
  let end = this.tools.vectorAdapter.from( this.tools.capsule.endPointGet( capsuleView ) );
  let radius = this.tools.capsule.radiusGet( capsuleView );

  _.assert( dims[ 0 ] - 1 === dimC, 'Capsule and frustum must have same length' );

  let bottomSphere = this.tools.sphere.fromCenterAndRadius( null, origin, radius );
  let topSphere = this.tools.sphere.fromCenterAndRadius( null, end, radius );

  if( !this.sphereContains( frustum, bottomSphere ) )
  return false;

  if( !this.sphereContains( frustum, topSphere ) )
  return false;

  return true;
}

//

function capsuleIntersects( srcFrustum , tstCapsule )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( srcFrustum ) );

  let tstCapsuleView = this.tools.capsule.adapterFrom( tstCapsule );

  let gotBool = this.tools.capsule.frustumIntersects( tstCapsuleView, srcFrustum );
  return gotBool;
}

//

function capsuleDistance( srcFrustum , tstCapsule )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( srcFrustum ) );

  let tstCapsuleView = this.tools.capsule.adapterFrom( tstCapsule );

  let gotDist = this.tools.capsule.frustumDistance( tstCapsuleView, srcFrustum );

  return gotDist;
}

//

/**
  * Calculates the closest point in a frustum to a capsule. Returns the calculated point.
  * Frustum and capsule remain unchanged
  *
  * @param { Array } frustum - The source frustum.
  * @param { Array } capsule - The source capsule.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * let srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);
  * let capsule = [ 0, 0, 0, - 1, - 1, - 1, 1 ]
  * _.capsuleClosestPoint( srcFrustum, capsule );
  *
  * @example
  * // returns [ 2, 2, 2 ]
  * _.capsuleClosestPoint( srcFrustum, capsule );
  *
  * @returns { Array } Returns the closest point to the capsule.
  * @function capsuleClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( frustum ) is not frustum
  * @throws { Error } An Error if ( capsule ) is not capsule
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */
function capsuleClosestPoint( frustum, capsule, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  _.assert( this.is( frustum ) );
  let dims = _.Matrix.DimsOf( frustum ) ;
  let rows = dims[ 0 ];
  let cols = dims[ 1 ];

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( rows - 1 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let capsuleView = this.tools.capsule.adapterFrom( capsule );
  let dimCapsule  = this.tools.capsule.dimGet( capsuleView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimCapsule === dstPoint.length );
  _.assert( dimCapsule === rows - 1 );

  if( this.tools.capsule.frustumIntersects( capsuleView, frustum ) )
  return 0
  else
  {
    let capsulePoint = this.tools.capsule.frustumClosestPoint( capsule, frustum );

    let frustumPoint = this.tools.vectorAdapter.from( this.pointClosestPoint( frustum, capsulePoint ) );

    for( let i = 0; i < dimCapsule; i++ )
    {
      dstPointView.eSet( i, frustumPoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

/**
  * Check if a frustum contains a convex polygon. Returns true it contains the polygon.
  * Frustum and polygon remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { ConvexPolygon } polygon - Source convex polygon.
  *
  * @example
  * // returns false;
  * let frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);
  * let polygon = _.Matrix.Make( [ 3, 3 ] ).copy
  * ([
  *    0,  0, -1,
  *    0, -1,  0,
  *   -1,  0,  0
  * ]);
  * _.convexPolygonContains( frustum, polygon );
  *
  * @returns { Boolean } Returns true if the frustum contains the convex polygon.
  * @function convexPolygonContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( polygon ) is not convex polygon.
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function convexPolygonContains( frustum , polygon )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( frustum ) );
  _.assert( _.convexPolygon.is( polygon ) );

  let dimsF = _.Matrix.DimsOf( frustum );
  let dimsP = _.Matrix.DimsOf( polygon );
  _.assert( dimsF[ 0 ] - 1 === dimsP[ 0 ], 'Polygon and frustum must have same length' );

  for( let i = 0; i < dimsP[ 1 ]; i++ )
  {
    let vertex = polygon.colGet( i );
    if( !this.pointContains( frustum, vertex ) )
    return false;
  }

  return true;
}

//

function convexPolygonIntersects( srcFrustum , polygon )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.convexPolygon.is( polygon ) );
  _.assert( this.is( srcFrustum ) );

  let gotBool = this.tools.convexPolygon.frustumIntersects( polygon, srcFrustum );

  return gotBool;
}

//

function convexPolygonDistance( srcFrustum , polygon )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.convexPolygon.is( polygon ) );
  _.assert( this.is( srcFrustum ) );

  let gotDist = this.tools.convexPolygon.frustumDistance( polygon, srcFrustum );

  return gotDist;
}

//

/**
  * Calculates the closest point in a frustum to a convex polygon. Returns the calculated point.
  * Frustum and polygon remain unchanged
  *
  * @param { Matrix } frustum - The source frustum.
  * @param { Polygon } polygon - The source polygon.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns [ 0, 0, 0 ]
  * let polygon = _.Matrix.Make( [ 3, 4 ] ).copy
  * ([
  *   -1, -1, -1, -1,
  *    1,  0, -1,  0,
  *    0,  1,  0, -1
  * ]);
  * let srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);

  * _.convexPolygonClosestPoint( srcFrustum, polygon );
  *
  * @returns { Array } Returns the closest point to the polygon.
  * @function convexPolygonClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( frustum ) is not frustum
  * @throws { Error } An Error if ( polygon ) is not convexPolygon
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function convexPolygonClosestPoint( frustum, polygon, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  _.assert( _.convexPolygon.is( polygon ) );
  _.assert( this.is( frustum ) );

  let dimP  = _.Matrix.DimsOf( polygon );
  let dimF  = _.Matrix.DimsOf( frustum );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimP[ 0 ] );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );


  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimP[ 0 ] === dstPoint.length );
  _.assert( dimP[ 0 ] === dimF[ 0 ] - 1 );

  if( this.tools.convexPolygon.frustumIntersects( polygon, frustum ) )
  return 0
  else
  {
    let polygonPoint = this.tools.convexPolygon.frustumClosestPoint( polygon, frustum );
    let frustumPoint = this.tools.vectorAdapter.from( this.pointClosestPoint( frustum, polygonPoint ) );

    for( let i = 0; i < dimP[ 0 ]; i++ )
    {
      dstPointView.eSet( i, frustumPoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

/**
  * Check if a frustum contains another frustum. Returns true if it contains the frustum.
  * Both frustums remain unchanged.
  *
  * @param { Frustum } srcFrustum - Source frustum ( container ).
  * @param { Frustum } tstFrustum - Frustum to test if it is contained.
  *
  * @example
  * // returns true;
  * let srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);
  * let tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,    0,    0,    0,   -1,    1,
  *    1,   -1,    0,    0,    0,    0,
  *    0,    0,    1,   -1,    0,    0,
  *   -0.5, -0.5, -0.5, -0.5, -0.5, -0.5
  * ]);
  * _.frustumContains( srcFrustum , tstFrustum );
  *
  * @returns { Boolean } Returns true if the srcFrustum contains the tstFrustum.
  * @function frustumContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( tstFrustum ) is not frustum.
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function frustumContains( srcFrustum , tstFrustum )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( srcFrustum ) );
  _.assert( this.is( tstFrustum ) );

  let points = this.cornersGet( tstFrustum );

  for( let i = 0 ; i < points.length ; i += 1 )
  {
    let point = points.colGet( i );
    let c = this.pointContains( srcFrustum, point );
    if( c !== true )
    return false;
  }

  return true;
}

//

/**
  * Check if a frustum intersects with another frustum. Returns true if they intersect.
  * Both frustums remain unchanged.
  *
  * @param { Frustum } srcFrustum - Source frustum.
  * @param { Frustum } tstFrustum - Frustum to test if it intersects.
  *
  * @example
  * // returns true;
  * let srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);
  * let tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,    0,    0,    0,   -1,    1,
  *    1,   -1,    0,    0,    0,    0,
  *    0,    0,    1,   -1,    0,    0,
  *   -0.5, -0.5, -0.5, -0.5, -0.5, -0.5
  * ]);
  * _.frustumIntersects( srcFrustum , tstFrustum );
  *
  * @returns { Boolean } Returns true if the frustums intersect.
  * @function frustumIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( tstFrustum ) is not frustum.
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function frustumIntersects( srcFrustum , tstFrustum )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( srcFrustum ) );
  _.assert( this.is( tstFrustum ) );
  debugger;

  let points = this.cornersGet( srcFrustum );

  for( let i = 0 ; i < points.length ; i += 1 )
  {
    let point = points.colGet( i );
    let c = this.pointContains( tstFrustum, point );
    if( c === true )
    return true;

  }

  let points2 = this.cornersGet( tstFrustum );

  for( let i = 0 ; i < points2.length ; i += 1 )
  {
    let point = points2.colGet( i );
    let c = this.pointContains( srcFrustum, point );
    if( c === true )
    return true;

  }

  return false;
}

//

/**
  * Calculates the distance between two frustums. Returns the calculated distance.
  * Both frustums remain unchanged.
  *
  * @param { Frustum } srcFrustum - Source frustum.
  * @param { Frustum } tstFrustum - Frustum to calculate the distance.
  *
  * @example
  * // returns 0;
  * let srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);
  * let tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,    0,    0,    0,   -1,    1,
  *    1,   -1,    0,    0,    0,    0,
  *    0,    0,    1,   -1,    0,    0,
  *   -0.5, -0.5, -0.5, -0.5, -0.5, -0.5
  * ]);
  * _.frustumDistance( srcFrustum , tstFrustum );
  *
  * @returns { Number } Returns the distance between the two frustums.
  * @function frustumDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( tstFrustum ) is not frustum.
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function frustumDistance( srcFrustum , tstFrustum )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( srcFrustum ) );
  _.assert( this.is( tstFrustum ) );
  debugger;

  if( this.frustumIntersects( srcFrustum, tstFrustum ) )
  return 0;

  let distance = Infinity;

  let points = this.cornersGet( srcFrustum );
  for( let i = 0 ; i < points.length ; i += 1 )
  {
    let point = points.colGet( i );
    let d = this.pointDistance( tstFrustum, point );
    if( d < distance )
    distance = d;
  }

  let points2 = this.cornersGet( tstFrustum );
  for( let i = 0 ; i < points2.length ; i += 1 )
  {
    let point = points2.colGet( i );
    let d2 = this.pointDistance( srcFrustum, point );
    if( d2 < distance )
    distance = d2;
  }

  return distance;
}

//

/**
  * Calculates the closest point in a frustum to another frustum. Returns the calculated point.
  * Both frustums remain unchanged.
  *
  * @param { Frustum } srcFrustum - Source frustum ( closest point in it ).
  * @param { Frustum } tstFrustum - Test frustum.
  * @param { Point } dstPoint - Destination point.
  *
  * @example
  * // returns 0;
  * let srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);
  * let tstFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,    0,    0,    0,   -1,    1,
  *    1,   -1,    0,    0,    0,    0,
  *    0,    0,    1,   -1,    0,    0,
  *   -0.5, -0.5, -0.5, -0.5, -0.5, -0.5
  * ]);
  * _.frustumClosestPoint( srcFrustum , testFrustum );
  *
  * @returns { Number } Returns the closest point to a frustum.
  * @function frustumClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( tstFrustum ) is not frustum.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function frustumClosestPoint( srcFrustum , tstFrustum, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  _.assert( this.is( srcFrustum ) );
  _.assert( this.is( tstFrustum ) );

  let dims = _.Matrix.DimsOf( srcFrustum ) ;
  let rows = dims[ 0 ];
  let cols = dims[ 1 ];

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( rows - 1 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  debugger;

  if( this.frustumIntersects( srcFrustum, tstFrustum ) )
  return 0;

  let distance = Infinity;
  let finalPoint = this.tools.long.make( rows - 1 );

  let srcPoints = this.cornersGet( srcFrustum );
  for( let i = 0 ; i < srcPoints.length ; i += 1 )
  {
    let point = srcPoints.colGet( i );
    let d = this.pointDistance( tstFrustum, point );
    if( d < distance )
    {
      distance = d;
      finalPoint = point.slice();
    }
  }

  let tstPoints = this.cornersGet( tstFrustum );
  for( let i = 0 ; i < tstPoints.length ; i += 1 )
  {
    let point = tstPoints.colGet( i );
    let d2 = this.pointDistance( srcFrustum, point );
    if( d2 < distance )
    {
      distance = d2;
      let finalPoint = point.slice();
    }
  }

  for( var i = 0; i < finalPoint.length; i++ )
  {
    dstPointView.eSet( i, finalPoint[ i ] );
  }

  return dstPoint;
}

//

function lineIntersects( srcFrustum , tstLine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( srcFrustum ) );

  let dims = _.Matrix.DimsOf( srcFrustum ) ;

  let tstLineView = this.tools.linePointDir.adapterFrom( tstLine );

  let gotBool = this.tools.linePointDir.frustumIntersects( tstLineView, srcFrustum );

  return gotBool;
}

//

function lineDistance( srcFrustum , tstLine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstLineView = this.tools.linePointDir.adapterFrom( tstLine );

  let gotDist = this.tools.linePointDir.frustumDistance( tstLineView, srcFrustum );

  return gotDist;
}

//

/**
  * Calculates the closest point in a frustum to a line. Returns the calculated point.
  * Frustum and line remain unchanged
  *
  * @param { Array } frustum - The source frustum.
  * @param { Array } line - The source line.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns [ 1, 0, 0 ]
  * let line = [ 2, 0, 0, 1, 0, 0 ]
  * let srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);
  * _.lineClosestPoint( frusrum, line );
  *
  * @returns { Array } Returns the closest point to the line.
  * @function lineClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( frustum ) is not frustum
  * @throws { Error } An Error if ( line ) is not line
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function lineClosestPoint( frustum, line, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  _.assert( this.is( frustum ) );

  let dimF = _.Matrix.DimsOf( frustum ) ;

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimF[ 0 ] - 1);

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let lineView = this.tools.linePointDir.adapterFrom( line );
  let dimLine  = this.tools.linePointDir.dimGet( lineView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimF[ 0 ] - 1 === dstPoint.length );
  _.assert( dimF[ 0 ] - 1 === dimLine );

  if( this.tools.linePointDir.frustumIntersects( lineView, frustum ) )
  return 0
  else
  {
    let linePoint = this.tools.linePointDir.frustumClosestPoint( lineView, frustum );

    let frustumPoint = this.tools.vectorAdapter.from( this.pointClosestPoint( frustum, linePoint ) );

    for( let i = 0; i < dimF[ 0 ] - 1 ; i++ )
    {
      dstPointView.eSet( i, frustumPoint.eGet( i ) );
    }

    return dstPoint;
  }
}

//

/**
  * Check if a frustum and a plane intersect. Returns true if they intersect.
  * Frustum and plane remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Plane } plane - Source plane.
  *
  * @example
  * // returns false;
  * _.planeIntersects( this.make() , [ 2, 2, 2, 1 ] );
  **
  * @returns { Boolean } Returns true if the frustum and the plane intersect.
  * @function planeIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( sphere ) is not plane.
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function planeIntersects( frustum, plane )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( frustum ) );

  let planeView = this.tools.plane.adapterFrom( plane );
  let corners = this.cornersGet( frustum );
  let side;
  for( let j = 0 ; j < 8 ; j = j + 1 )
  {
    let corner = corners.colGet( j );
    let distance = this.tools.plane.pointDistance( planeView, corner );
    if( distance === 0 )
    return true;

    if( j > 0 )
    {
      let newSide = distance/ Math.abs( distance );
      if( side === - newSide )//aaa vova: numberAreEquivalent?
      {
        return true;
      }
      side = newSide;
    }
    side = distance/ Math.abs( distance );
  }

  return false;
}

//

/**
  * Calculates the distance between a frustum and a plane. Returns the calculated distance.
  * Frustum and plane remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Plane } plane - Source plane.
  *
  * @example
  * // returns 2;
  * let frustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);
  * _.planeDistance( frustum , [ 1, 0, 0, 2 ] );
  *
  * @returns { Number } Returns the distance between the frustum and the plane.
  * @function planeDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( sphere ) is not plane.
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function planeDistance( frustum, plane )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( frustum ) );

  let planeView = this.tools.plane.adapterFrom( plane );
  if( this.planeIntersects( frustum, planeView ) )
  return 0;

  let corners = this.cornersGet( frustum );
  let distance = Infinity;
  for( let j = 0 ; j < 8 ; j = j + 1 )
  {
    let corner = corners.colGet( j );
    let dist = Math.abs( this.tools.plane.pointDistance( planeView, corner ) );
    if( dist < distance )
    distance = dist;
  }

  return distance;
}

//

/**
  * Calculates the closest point in a frustum to a plane. Returns the calculated point.
  * Frustum and plane remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Plane } plane - Source plane.
  * @param { Point } dstPoint - Destination point.
  *
  * @example
  * // returns [ 1, 1, 1 ];
  * let frustum =  _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);
  * _.planeClosestPoint( frustum , [ 1, 1, 1, 6 ] );
  *
  * @returns { Array } Returns the coordinates of the closest point.
  * @function planeClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( sphere ) is not plane.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function planeClosestPoint( frustum, plane, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  _.assert( this.is( frustum ) );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( plane.length - 1 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  let planeView = this.tools.plane.adapterFrom( plane );
  if( this.planeIntersects( frustum, planeView ) )
  return 0;

  let corners = this.cornersGet( frustum );
  let distance = Infinity;
  let point = this.tools.long.make( plane.length - 1 );
  for( let j = 0 ; j < 8 ; j = j + 1 )
  {
    let corner = corners.colGet( j );
    let dist = Math.abs( this.tools.plane.pointDistance( planeView, corner ) );
    if( dist < distance )
    {
      distance = dist;
      point = this.tools.vectorAdapter.from( corner.slice() );
    }
  }

  for( var i = 0; i < dstPointView.length; i++ )
  {
    dstPointView.eSet( i, point.eGet( i ) );
  }

  return dstPoint;
}

//

function rayIntersects( srcFrustum , tstRay )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( srcFrustum ) );

  let dims = _.Matrix.DimsOf( srcFrustum ) ;

  let tstRayView = this.tools.ray.adapterFrom( tstRay );

  let gotBool = this.tools.ray.frustumIntersects( tstRayView, srcFrustum );

  return gotBool;
}

//

function rayDistance( srcFrustum , tstRay )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstRayView = this.tools.ray.adapterFrom( tstRay );

  let gotDist = this.tools.ray.frustumDistance( tstRayView, srcFrustum );

  return gotDist;
}

//

/**
  * Calculates the closest point in a frustum to a ray. Returns the calculated point.
  * Frustum and ray remain unchanged
  *
  * @param { Array } frustum - The source frustum.
  * @param { Array } ray - The source ray.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns [ 1, 0, 0 ]
  * let ray = [ 2, 0, 0, 1, 0, 0 ]
  * let srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);
  * _.rayClosestPoint( frusrum, ray );
  *
  * @returns { Array } Returns the closest point to the ray.
  * @function rayClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( frustum ) is not frustum
  * @throws { Error } An Error if ( ray ) is not ray
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function rayClosestPoint( frustum, ray, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  _.assert( this.is( frustum ) );

  let dimF = _.Matrix.DimsOf( frustum ) ;

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimF[ 0 ] - 1);

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let rayView = this.tools.ray.adapterFrom( ray );
  let dimRay  = this.tools.ray.dimGet( rayView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimF[ 0 ] - 1 === dstPoint.length );
  _.assert( dimF[ 0 ] - 1 === dimRay );

  if( this.tools.ray.frustumIntersects( rayView, frustum ) )
  return 0
  else
  {
    let rayPoint = this.tools.ray.frustumClosestPoint( rayView, frustum );

    let frustumPoint = this.tools.vectorAdapter.from( this.pointClosestPoint( frustum, rayPoint ) );

    for( let i = 0; i < dimF[ 0 ] - 1 ; i++ )
    {
      dstPointView.eSet( i, frustumPoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

/**
  * Check if a frustum contains a segment. Returns true it contains the segment.
  * Frustum and segment remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Segment } segment - Source segment.
  *
  * @example
  * // returns false;
  * let frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);
  * _.segmentContains( frustum , [ 1, 1, 1, 2, 2, 2 ] );
  *
  * @returns { Boolean } Returns true if the frustum contains the segment.
  * @function segmentContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function segmentContains( frustum, segment )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( frustum ) );
  let dims = _.Matrix.DimsOf( frustum );

  let segmentView = this.tools.segment.adapterFrom( segment );
  let dimS = this.tools.segment.dimGet( segmentView );
  let origin = this.tools.segment.originGet( segmentView );
  let end = this.tools.segment.endPointGet( segmentView );

  _.assert( dimS = dims[ 0 ] - 1, 'Frustum and segment must have the same dimension')

  if( !this.pointContains( frustum, origin ) )
  return false;

  if( !this.pointContains( frustum, end ) )
  return false;

  return true;

}

//

function segmentIntersects( srcFrustum , tstSegment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( srcFrustum ) );

  let dims = _.Matrix.DimsOf( srcFrustum ) ;

  let tstSegmentView = this.tools.segment.adapterFrom( tstSegment );

  let gotBool = this.tools.segment.frustumIntersects( tstSegmentView, srcFrustum );

  return gotBool;
}

//

function segmentDistance( srcFrustum , tstSegment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstSegmentView = this.tools.segment.adapterFrom( tstSegment );

  let gotDist = this.tools.segment.frustumDistance( tstSegmentView, srcFrustum );

  return gotDist;
}

//

/**
  * Calculates the closest point in a frustum to a segment. Returns the calculated point.
  * Frustum and segment remain unchanged
  *
  * @param { Array } frustum - The source frustum.
  * @param { Array } segment - The source segment.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns [ 1, 0, 0 ]
  * let segment = [ 2, 0, 0, 1, 0, 0 ]
  * let srcFrustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);
  * _.segmentClosestPoint( frusrum, segment );
  *
  * @returns { Array } Returns the closest point to the segment.
  * @function segmentClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( frustum ) is not frustum
  * @throws { Error } An Error if ( segment ) is not segment
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function segmentClosestPoint( frustum, segment, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  _.assert( this.is( frustum ) );

  let dimF = _.Matrix.DimsOf( frustum ) ;

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dimF[ 0 ] - 1);

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let segmentView = this.tools.segment.adapterFrom( segment );
  let dimSegment  = this.tools.segment.dimGet( segmentView );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( dimF[ 0 ] - 1 === dstPoint.length );
  _.assert( dimF[ 0 ] - 1 === dimSegment );

  if( this.tools.segment.frustumIntersects( segmentView, frustum ) )
  return 0
  else
  {
    let segmentPoint = this.tools.segment.frustumClosestPoint( segmentView, frustum );

    let frustumPoint = this.tools.vectorAdapter.from( this.pointClosestPoint( frustum, segmentPoint ) );

    for( let i = 0; i < dimF[ 0 ] - 1 ; i++ )
    {
      dstPointView.eSet( i, frustumPoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

/**
  * Check if a frustum contains a sphere. Returns true it contains the sphere.
  * Frustum and sphere remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Sphere } sphere - Source sphere.
  *
  * @example
  * // returns false;
  * let frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);
  * _.sphereContains( frustum , [ 2, 2, 2, 1 ] );
  *
  * @returns { Boolean } Returns true if the frustum contains the sphere.
  * @function sphereContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function sphereContains( frustum , sphere )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( frustum ) );

  let center = this.tools.sphere.centerGet( sphere );
  let radius = this.tools.sphere.radiusGet( sphere );

  for( let i = 0 ; i < 6 ; i += 1 )
  {
    let plane = frustum.colGet( i );
    if( this.tools.plane.pointDistance( plane, center ) > - radius + 1E-12 )
    return false;
  }

  return true;
}

//

/**
  * Check if a frustum and a sphere intersect. Returns true if they intersect.
  * Frustum and sphere remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Sphere } sphere - Source sphere.
  *
  * @example
  * // returns false;
  * _.sphereIntersects( this.make() , [ 2, 2, 2, 1 ] );
  *
  * @returns { Boolean } Returns true if the frustum and the sphere intersect.
  * @function sphereIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function sphereIntersects( frustum , sphere )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( frustum ) );

  let center = this.tools.sphere.centerGet( sphere );
  let radius = this.tools.sphere.radiusGet( sphere );

  if( this.pointContains( frustum, this.tools.vectorAdapter.from( center )) === true )
  {
    return true;
  }
  else
  {
    let proj = this.pointClosestPoint( frustum, center );
    let d = this.tools.avector.distance( proj, center );
    if( d <= radius )
    {
      return true;
    }
  }
  return false;
}

//

/**
  * Get the distance between a frustum and a sphere. Returns the calculated distance.
  * Frustum and sphere remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Sphere } sphere - Source sphere.
  *
  * @example
  * // returns 1;
  * let frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);
  * _.sphereDistance( frustum , [ 0, 0, 3, 1 ] );
  *
  * @returns { Number } Returns the distance between the frustum and the sphere.
  * @function sphereDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function sphereDistance( frustum, sphere )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( this.is( frustum ) );

  let sphereView = this.tools.sphere.adapterFrom( sphere );

  let distance = this.tools.sphere.frustumDistance( sphereView, frustum );

  return distance;
}

//

/**
  * Returns the closest point in a frustum to a sphere. Returns the coordinates of the closest point.
  * Frustum and sphere remain unchanged.
  *
  * @param { Frustum } frustum - Source frustum.
  * @param { Array } sphere - Source sphere.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * let frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);
  * _.sphereClosestPoint( frustum , [ - 1, - 1, - 1, 0.1 ] );
  *
  * @returns { Array } Returns the array of coordinates of the closest point in the frustum.
  * @function sphereClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( frustum ) is not frustum.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function sphereClosestPoint( frustum , sphere, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  let sphereView = this.tools.sphere.adapterFrom( sphere );
  let center = this.tools.sphere.centerGet( sphereView );
  let radius = this.tools.sphere.radiusGet( sphereView );
  let dim = this.tools.sphere.dimGet( sphereView );
  _.assert( dim === 3 );

  if( arguments.length === 2 )
  dstPoint = this.tools.long.make( dim );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = this.tools.vectorAdapter.from( dstPoint );

  _.assert( this.is( frustum ) );

  if( this.sphereIntersects( frustum, sphereView ) == true )
  return 0;

  let point = this.pointClosestPoint( frustum, center );

  for( var i = 0; i < point.length; i++ )
  {
    dstPointView.eSet( i, point[ i ] );
  }

  return dstPoint;

}

//

/**
  * Get the bounding sphere of a frustum0. Returns destination sphere.
  * Frustum and sphere are stored in Array data structure. Source frustum stays untouched.
  *
  * @param { Array } dstSphere - destination sphere.
  * @param { Array } srcFrustum - source frustum for the bounding sphere.
  *
  * @example
  * // returns [ 0.5, 0.5, 0.5,  Math.sqrt( 0.75 ) ]
  * let frustum = _.Matrix.Make( [ 4, 6 ] ).copy
  * ([
  *    0,  0,  0,  0, -1,  1,
  *    1, -1,  0,  0,  0,  0,
  *    0,  0,  1, -1,  0,  0,
  *   -1,  0, -1,  0,  0, -1
  * ]);
  * _.boundingSphereGet( null, frustum );
  *
  * @returns { Array } Returns the array of the bounding sphere.
  * @function boundingSphereGet
  * @throws { Error } An Error if ( dim ) is different than dimGet( frustum ) (the frustum and the sphere don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstSphere ) is not sphere
  * @throws { Error } An Error if ( srcFrustum ) is not frustum
  * @namespace wTools.frustum
  * @module Tools/math/Concepts
  */

function boundingSphereGet( dstSphere, srcFrustum )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  _.assert( this.is( srcFrustum ) );
  let dims = _.Matrix.DimsOf( srcFrustum ) ;
  let rows = dims[ 0 ];
  let cols = dims[ 1 ];
  let fpoints = this.cornersGet( srcFrustum );
  _.assert( _.matrixIs( fpoints ) );
  _.assert( fpoints.hasShape( [ 3, 8 ] ) );

  if( dstSphere === null || dstSphere === undefined )
  dstSphere = this.tools.sphere.makeZero( rows - 1 );

  _.assert( _.sphere.is( dstSphere ) );
  let dstSphereView = this.tools.sphere.adapterFrom( dstSphere );
  let center = this.tools.sphere.centerGet( dstSphereView );
  let radiusSphere = this.tools.sphere.radiusGet( dstSphereView );
  let dimSphere = this.tools.sphere.dimGet( dstSphereView );

  _.assert( rows - 1 === dimSphere );

  // Frustum limits
  let maxF = this.tools.vectorAdapter.from( fpoints.colGet( 0 ).slice() );
  let minF = this.tools.vectorAdapter.from( fpoints.colGet( 0 ).slice() );
  // let maxF = fpoints.colGet( 0 ).clone();
  // let minF = fpoints.colGet( 0 ).clone();

  for( let j = 1 ; j < _.Matrix.DimsOf( fpoints )[ 1 ] ; j++ )
  {
    let newp = fpoints.colGet( j );

    if( newp.eGet( 0 ) < minF.eGet( 0 ) )
    {
      minF.eSet( 0, newp.eGet( 0 ) );
    }
    if( newp.eGet( 1 ) < minF.eGet( 1 ) )
    {
      minF.eSet( 1, newp.eGet( 1 ) );
    }
    if( newp.eGet( 2 ) < minF.eGet( 2 ) )
    {
      minF.eSet( 2, newp.eGet( 2 ) );
    }
    if( newp.eGet( 0 ) > maxF.eGet( 0 ) )
    {
      maxF.eSet( 0, newp.eGet( 0 ) );
    }
    if( newp.eGet( 1 ) > maxF.eGet( 1 ) )
    {
      maxF.eSet( 1, newp.eGet( 1 ) );
    }
    if( newp.eGet( 2 ) > maxF.eGet( 2 ) )
    {
      maxF.eSet( 2, newp.eGet( 2 ) );
    }
  }

  // Center of the sphere
  for( let c = 0; c < center.length; c++ )
  {
    center.eSet( c, ( maxF.eGet( c ) + minF.eGet( c ) ) / 2 );
  }

  // Radius of the sphere
  this.tools.sphere.radiusSet( dstSphereView, this.tools.vectorAdapter.distance( center, maxF ) );

  return dstSphere;
}



// --
// declare
// --

/* qqq : please sort */

let Extension = /* qqq : normalize order */
{

  make,
  fromMatrixHomogenous,
  is,

  cornersGet,

  pointContains,
  pointDistance, /* qqq : implement me */
  pointClosestPoint, /* qqq : review please */

  boxContains, /* qqq : implement me */
  boxIntersects,
  boxDistance, /* qqq : implement me - Same as _.box.frustumDistance */
  boxClosestPoint,
  boundingBoxGet,

  capsuleContains,
  capsuleIntersects,
  capsuleDistance,
  capsuleClosestPoint,

  frustumContains, /* qqq : implement me */
  frustumIntersects,
  frustumDistance, /* qqq : implement me */
  frustumClosestPoint, /* qqq : implement me */

  lineIntersects,  /* Same as _.linePointDir.frustumIntersects */
  lineDistance,  /* Same as _.linePointDir.frustumDistance */
  lineClosestPoint,

  planeIntersects, /* qqq : implement me */
  planeDistance, /* qqq : implement me */
  planeClosestPoint, /* qqq : implement me */

  convexPolygonContains,
  convexPolygonIntersects,
  convexPolygonDistance,
  convexPolygonClosestPoint,

  rayIntersects,  /* Same as _.ray.frustumIntersects */
  rayDistance,  /* Same as _.ray.frustumDistance */
  rayClosestPoint,

  segmentContains,
  segmentIntersects,  /* Same as _.segment.frustumIntersects */
  segmentDistance,  /* Same as _.segment.frustumDistance */
  segmentClosestPoint,

  sphereContains, /* qqq : implement me */
  sphereIntersects,
  sphereDistance, /* qqq : implement me - Same as _.sphere.frustumDistance  */
  sphereClosestPoint,
  boundingSphereGet,

  tools : _,

}

/* _.props.extend */Object.assign( _.frustum, Extension );

})();
