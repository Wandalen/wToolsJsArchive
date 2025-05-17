(function _Quat_s_(){

'use strict';

const _ = _global_.wTools;
const pi = Math.PI;
const sin = Math.sin;
const cos = Math.cos;
const asin = Math.asin;
const acos = Math.acos;
const abs = Math.abs;
const sqr = _.math.sqr;
const sqrt = _.math.sqrt;

_.assert( !this );
_.quat = _.quat || Object.create( _.avector );

/**
 * @description
 * A Quaternion is an object that represents a rotation with a rotation vector and a scalar.
 *
 * For the following functions, quaternions must have the shape [ dir1, dir2, dir3, scalar ],
 * where dir1, dir2 and dir3 are the coordinates of the rotation vector
 * and scalar related with the rotation magnitude.
 * @namespace wTools.quat
 * @module Tools/math/Concepts
 */

/*

A Quaternion is an object that reprrsents a rotation with a rotation vector and a scalar.

For the following functions, quaternions must have the shape [ dir1, dir2, dir3, scalar ],
where dir1, dir2 and dir3 are the coordinates of the rotation vector
and scalar related with the rotation magnitude.

*/

// --
//
// --

function make( src )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( src === undefined || src === null || this.is( src ) );
  let result = this.makeUnit();
  if( this.is( src ) )
  this.tools.avector.assign( result, src );
  return result;
}

//

function makeZero()
{
  _.assert( arguments.length === 0, 'Expects no arguments' );
  let result = _.dup( 0, 4 );
  return result;
}

//

function makeUnit()
{
  _.assert( arguments.length === 0, 'Expects no arguments' );
  let result = _.dup( 0, 4 );
  result[ 0 ] = 1;
  // result[ 3 ] = 1;
  return result;
}

//

function zero( quat )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( quat === undefined || quat === null || this.is( quat ) );

  if( this.is( quat ) )
  {
    let quatView = this.adapterFrom( quat );
    quatView.assign( 0 );
    return quat;
  }

  return this.makeZero();
}

//

function unit( quat )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( quat === undefined || quat === null || this.is( quat ) );

  if( this.is( quat ) )
  {
    let quatView = this.adapterFrom( quat );
    quatView.assign( 0 );
    quatView.eSet( 0, 1 );
    // quatView.eSet( 3, 1 );
    return quat;
  }

  return this.makeUnit();
}

//

function from( quat )
{

  _.assert( quat === null || this.is( quat ), 'Expects quaternion' );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( quat === null )
  return this.make();

  if( _.vectorAdapterIs( quat ) )
  {
    debugger;
    // xxx
    quat.toLong();
    // throw _.err( 'not implemented' );
    // return quat.slice();
  }

  return quat;
}

//

function adapterFrom( quat )
{
  _.assert( /*quat === null ||*/ this.is( quat ), 'Expects quaternion' );
  _.assert( arguments.length === 1, 'Expects single argument' );

  // if( quat === null )
  // quat = this.make();

  return this.tools.vectorAdapter.from( quat );
}

//

function fromEuler( dst, euler, v )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  dst = this.from( dst );
  let dstv = this.tools.vectorAdapter.from( dst );
  let eulerView = this.tools.euler.adapterFrom( euler );

  let ox = eulerView.eGet( 3 );
  let oy = eulerView.eGet( 4 );
  let oz = eulerView.eGet( 5 );

  let e1 = eulerView.eGet( 0 );
  let e2 = eulerView.eGet( 1 );
  let e3 = eulerView.eGet( 2 );

  let c1 = cos( e1 / 2 );
  let c2 = cos( e2 / 2 );
  let c3 = cos( e3 / 2 );
  let s1 = sin( e1 / 2 );
  let s2 = sin( e2 / 2 );
  let s3 = sin( e3 / 2 );

  let cs1 = s1 * c2 * c3;
  let cs2 = c1 * s2 * c3;
  let cs3 = c1 * c2 * s3;
  let c = c1 * c2 * c3;

  let sc1 = c1 * s2 * s3;
  let sc2 = s1 * c2 * s3;
  let sc3 = s1 * s2 * c3;
  let s = s1 * s2 * s3;

  let vars = [ c, cs1, cs2, cs3, s, sc1, sc2, sc3 ];
  // logger.log( 'vars', vars.slice().sort() );

  // let xsign = ox === 0 ? oy === 1 : ox === 1;
  // let ysign = ox === 1 ? oy === 2 : ox === 2;
  // let zsign = ox === 2 ? oy === 0 : ox === 0;
  let wsign = ( ( ox !== 0 ) + ( oy !== 1 ) + ( oz !== 2 ) ) === 2;

  // xsign = xsign ? +1 : -1;
  // ysign = ysign ? +1 : -1;
  // zsign = zsign ? +1 : -1;
  wsign = wsign ? +1 : -1;

  let axisTwice = ox === oz;

  if( axisTwice )
  {
    wsign *= -1;
    if( ( ox === 0 && oy === 1 ) || ( ox === 1 && oy === 0 ) )
    oz = 2;
    else if( ( ox === 0 && oy === 2 ) || ( ox === 2 && oy === 0 ) )
    oz = 1;
    else if( ( ox === 1 && oy === 2 ) || ( ox === 2 && oy === 1 ) )
    oz = 0;
    else _.assert( 0 );
  }

  // console.log( 'xsign', xsign );
  // console.log( 'ysign', ysign );
  // console.log( 'zsign', zsign );
  // console.log( 'wsign', wsign );

  // if( 0 )
  // if( ox === 2 && oy === 1 && oz === 0 ) /* zyx */
  // {
  //
  //   dstv.eSet( 0, c1*c2*s3 - s1*s2*c3 );
  //   dstv.eSet( 1, c1*s2*c3 + s1*c2*s3 );
  //   dstv.eSet( 2, s1*c2*c3 - c1*s2*s3 );
  //   dstv.eSet( 3, c1*c2*c3 + s1*s2*s3 );
  //
  //   // dstv.eSet( 0, 3 - 7 );
  //   // dstv.eSet( 1, 2 + 6 );
  //   // dstv.eSet( 2, 1 - 5 );
  //   // dstv.eSet( 3, 0 + 4 );
  //
  //   // let vars = [ c, cs1, cs2, cs3, s, sc1, sc2, sc3 ];
  //   // let vars = [ 0,  1,  2,  3, 4,  5,  6,  7 ];
  //
  //   // let vars = [ c1*c2*c3, s1*c2*c3, c1*s2*c3, c1*c2*s3, s1*s2*s3, c1*s2*s3, s1*c2*s3, s1*s2*c3 ];
  //   // let vars = [ 0,       1,       2,       3,        4,       5,       6,       7 ];
  //
  // }

  if( !axisTwice )
  {
    // dstv.eSet( ox, cs1 - sc1*wsign );
    // dstv.eSet( oy, cs2 + sc2*wsign );
    // dstv.eSet( oz, cs3 - sc3*wsign );
    // dstv.eSet( 3,  c   +   s*wsign );
    dstv.eSet( ox + 1, cs1 - sc1*wsign );
    dstv.eSet( oy + 1, cs2 + sc2*wsign );
    dstv.eSet( oz + 1, cs3 - sc3*wsign );
    dstv.eSet( 0,  c   +   s*wsign );
  }
  else if( ox === 0 && oy === 1 ) /* xyx */
  {

    dstv.eSet( 1, s1*c2*c3 + c1*c2*s3 );
    dstv.eSet( 2, c1*s2*c3 + s1*s2*s3 );
    dstv.eSet( 3, s1*s2*c3 - c1*s2*s3 );
    dstv.eSet( 0, c1*c2*c3 - s1*c2*s3 );

    // dstv.eSet( 0, 1 + 3 );
    // dstv.eSet( 1, 2 + 4 );
    // dstv.eSet( 2, 7 - 5 );
    // dstv.eSet( 3, 0 - 6 );

    // let vars = [ c1*c2*c3, s1*c2*c3, c1*s2*c3, c1*c2*s3, s1*s2*s3, c1*s2*s3, s1*c2*s3, s1*s2*c3 ];
    // let vars = [ 0,       1,       2,       3,        4,       5,       6,       7 ];

    // dstv.eSet( ox, cs1 + cs3*wsign );
    // dstv.eSet( oy, cs2 + s*wsign );
    // dstv.eSet( oz, sc3 - sc1*wsign );
    // dstv.eSet( 3,  c   - sc2*wsign );

  }
  else if( ox === 0 && oy === 2 ) /* xzx */
  {

    // dstv.eSet( 0, s1*c2*c3 + c1*c2*s3 );
    // dstv.eSet( 1, c1*s2*s3 - s1*s2*c3 );
    // dstv.eSet( 2, c1*s2*c3 + s1*s2*s3 );
    // dstv.eSet( 3, c1*c2*c3 - s1*c2*s3 );
    dstv.eSet( 1, s1*c2*c3 + c1*c2*s3 );
    dstv.eSet( 2, c1*s2*s3 - s1*s2*c3 );
    dstv.eSet( 3, c1*s2*c3 + s1*s2*s3 );
    dstv.eSet( 0, c1*c2*c3 - s1*c2*s3 );

    // dstv.eSet( 0, 1 + 3 );
    // dstv.eSet( 1, 5 - 7 );
    // dstv.eSet( 2, 2 + 4 );
    // dstv.eSet( 3, 0 - 6 );

    // let vars = [ c1*c2*c3, s1*c2*c3, c1*s2*c3, c1*c2*s3, s1*s2*s3, c1*s2*s3, s1*c2*s3, s1*s2*c3 ];
    // let vars = [ 0,       1,       2,       3,        4,       5,       6,       7 ];

  }
  else if( ox === 1 && oy === 0 ) /* yxy */
  {

    // dstv.eSet( 0, c1*s2*c3 + s1*s2*s3 );
    // dstv.eSet( 1, s1*c2*c3 + c1*c2*s3 );
    // dstv.eSet( 2, c1*s2*s3 - s1*s2*c3 );
    // dstv.eSet( 3, c1*c2*c3 - s1*c2*s3 );
    dstv.eSet( 1, c1*s2*c3 + s1*s2*s3 );
    dstv.eSet( 2, s1*c2*c3 + c1*c2*s3 );
    dstv.eSet( 3, c1*s2*s3 - s1*s2*c3 );
    dstv.eSet( 0, c1*c2*c3 - s1*c2*s3 );

    // dstv.eSet( 0, 2 + 4 );
    // dstv.eSet( 1, 1 + 3 );
    // dstv.eSet( 2, 5 - 7 );
    // dstv.eSet( 3, 0 - 6 );

    // let vars = [ c1*c2*c3, s1*c2*c3, c1*s2*c3, c1*c2*s3, s1*s2*s3, c1*s2*s3, s1*c2*s3, s1*s2*c3 ];
    // let vars = [ 0,       1,       2,       3,        4,       5,       6,       7 ];

  }
  else if( ox === 1 && oy === 2 ) /* yzy */
  {

    // dstv.eSet( 0, s1*s2*c3 - c1*s2*s3 );
    // dstv.eSet( 1, s1*c2*c3 + c1*c2*s3 );
    // dstv.eSet( 2, c1*s2*c3 + s1*s2*s3 );
    // dstv.eSet( 3, c1*c2*c3 - s1*c2*s3 );
    dstv.eSet( 1, s1*s2*c3 - c1*s2*s3 );
    dstv.eSet( 2, s1*c2*c3 + c1*c2*s3 );
    dstv.eSet( 3, c1*s2*c3 + s1*s2*s3 );
    dstv.eSet( 0, c1*c2*c3 - s1*c2*s3 );

    // dstv.eSet( 0, 7 - 5 );
    // dstv.eSet( 1, 1 + 3 );
    // dstv.eSet( 2, 2 + 4 );
    // dstv.eSet( 3, 0 - 6 );

    // let vars = [ c1*c2*c3, s1*c2*c3, c1*s2*c3, c1*c2*s3, s1*s2*s3, c1*s2*s3, s1*c2*s3, s1*s2*c3 ];
    // let vars = [ 0,       1,       2,       3,        4,       5,       6,       7 ];

  }
  else if( ox === 2 && oy === 0 ) /* zxz */
  {

    // dstv.eSet( 0, c1*s2*c3 + s1*s2*s3 );
    // dstv.eSet( 1, s1*s2*c3 - c1*s2*s3 );
    // dstv.eSet( 2, s1*c2*c3 + c1*c2*s3 );
    // dstv.eSet( 3, c1*c2*c3 - s1*c2*s3 );
    dstv.eSet( 1, c1*s2*c3 + s1*s2*s3 );
    dstv.eSet( 2, s1*s2*c3 - c1*s2*s3 );
    dstv.eSet( 3, s1*c2*c3 + c1*c2*s3 );
    dstv.eSet( 0, c1*c2*c3 - s1*c2*s3 );

    // dstv.eSet( 0, 2 + 4 );
    // dstv.eSet( 1, 7 - 5 );
    // dstv.eSet( 2, 1 + 3 );
    // dstv.eSet( 3, 0 - 6 );

    // let vars = [ c, cs1, cs2, cs3, s, sc1, sc2, sc3 ];
    // let vars = [ 0,  1,  2,  3, 4,  5,  6,  7 ];

    // let vars = [ c1*c2*c3, s1*c2*c3, c1*s2*c3, c1*c2*s3, s1*s2*s3, c1*s2*s3, s1*c2*s3, s1*s2*c3 ];
    // let vars = [ 0,       1,       2,       3,        4,       5,       6,       7 ];

  }
  else if( ox === 2 && oy === 1 ) /* zyz */
  {

    // dstv.eSet( 0, sc1 - sc3 );
    // dstv.eSet( 1, cs2 + s );
    // dstv.eSet( 2, cs1 + cs3 );
    // dstv.eSet( 3, c - sc2 );

    // dstv.eSet( 0, c1*s2*s3 - s1*s2*c3 );
    // dstv.eSet( 1, c1*s2*c3 + s1*s2*s3 );
    // dstv.eSet( 2, s1*c2*c3 + c1*c2*s3 );
    // dstv.eSet( 3, c1*c2*c3 - s1*c2*s3 );
    dstv.eSet( 1, c1*s2*s3 - s1*s2*c3 );
    dstv.eSet( 2, c1*s2*c3 + s1*s2*s3 );
    dstv.eSet( 3, s1*c2*c3 + c1*c2*s3 );
    dstv.eSet( 0, c1*c2*c3 - s1*c2*s3 );

    // dstv.eSet( 0, 5 - 7 );
    // dstv.eSet( 1, 2 + 4 );
    // dstv.eSet( 2, 1 + 3 );
    // dstv.eSet( 3, 0 - 6 );

    // let vars = [ c, cs1, cs2, cs3, s, sc1, sc2, sc3 ];
    // let vars = [ 0,  1,  2,  3, 4,  5,  6,  7 ];

  }
  // else _.assert( 0 );

  /* */

  // if( v )
  // {
  //
  //   dstv.assign( -10 );
  //
  //   /* xyx : - */
  //   /* xzx : 1, 2, 0 */
  //   /* yxy : 2, 0, 1 */
  //   /* yzy : 1, 2, 0 */
  //   /* zxz : 2, 0, 1 */
  //   /* zyz : - */
  //
  //   dstv.eSet( 0, vars[ v.ox0 ] + vars[ v.ox1 ]*v.xs );
  //   dstv.eSet( 1, vars[ v.oy0 ] + vars[ v.oy1 ]*v.ys );
  //   dstv.eSet( 2, vars[ v.oz0 ] + vars[ v.oz1 ]*v.zs );
  //   dstv.eSet( 3, vars[ v.ow0 ] + vars[ v.ow1 ]*v.ws );
  //
  // }

  return dst;
}

// fromEuler.variates =
// {
//
//   // ox : [ 0, 1, 2, 3 ],
//   // oy : [ 0, 1, 2, 3 ],
//   // oz : [ 0, 1, 2, 3 ],
//   // ow : [ 0, 1, 2, 3 ],
//   // ow : [ 3 ],
//
//   // check : function()
//   // {
//   //   if( sample.ox0+sample.oy0+sample.oz0+sample.ow0 !== 6 )
//   //   return false;
//   // },
//
//   ox0 : [ 0, 1, 2, 3, 4, 5, 6, 7 ],
//   oy0 : [ 0, 1, 2, 3, 4, 5, 6, 7 ],
//   oz0 : [ 0, 1, 2, 3, 4, 5, 6, 7 ],
//   ow0 : [ 0, 1, 2, 3, 4, 5, 6, 7 ],
//
//   ox1 : [ 0, 1, 2, 3, 4, 5, 6, 7 ],
//   oy1 : [ 0, 1, 2, 3, 4, 5, 6, 7 ],
//   oz1 : [ 0, 1, 2, 3, 4, 5, 6, 7 ],
//   ow1 : [ 0, 1, 2, 3, 4, 5, 6, 7 ],
//
//   xs : [ +1, -1 ],
//   ys : [ +1, -1 ],
//   zs : [ +1, -1 ],
//   ws : [ +1, -1 ],
//
//   // x1 : [ +1, -1 ],
//   // y1 : [ +1, -1 ],
//   // z1 : [ +1, -1 ],
//   // w1 : [ +1, -1 ],
//
//   // ox2 : [ 0, 1, 2, 3 ],
//   // oy2 : [ 0, 1, 2, 3 ],
//   // oz2 : [ 0, 1, 2, 3 ],
//   //
//   // x02 : [ +1, -1 ],
//   // y02 : [ +1, -1 ],
//   // z02 : [ +1, -1 ],
//   // w02 : [ +1, -1 ],
//   //
//   // x12 : [ +1, -1 ],
//   // y12 : [ +1, -1 ],
//   // z12 : [ +1, -1 ],
//   // w12 : [ +1, -1 ],
//
// }

//

function fromAxisAndAngle( dst, axisAndAngle, angle )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  dst = this.from( dst );
  let dstv = this.tools.vectorAdapter.from( dst );
  let axisAndAnglev = this.tools.axisAndAngle.adapterFrom( axisAndAngle, angle );

  let halfAngle = axisAndAnglev.eGet( 0 ) / 2;
  // let halfAngle = axisAndAnglev.eGet( 3 ) / 2;
  let s = sin( halfAngle );

  // dstv.eSet( 0, axisAndAnglev.eGet( 0 ) * s );
  // dstv.eSet( 1, axisAndAnglev.eGet( 1 ) * s );
  // dstv.eSet( 2, axisAndAnglev.eGet( 2 ) * s );
  // dstv.eSet( 3, cos( halfAngle ) );
  dstv.eSet( 1, axisAndAnglev.eGet( 1 ) * s );
  dstv.eSet( 2, axisAndAnglev.eGet( 2 ) * s );
  dstv.eSet( 3, axisAndAnglev.eGet( 3 ) * s );
  dstv.eSet( 0, cos( halfAngle ) );

  return dst;
}

//

function toAxisAndAngle( quat, axisAndAngle )
{

  _.assert( this.tools.accuracySqr > 0 );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  quat = this.from( quat );
  let quatView = this.tools.vectorAdapter.from( quat );
  axisAndAngle = this.tools.axisAndAngle.from( axisAndAngle );
  let axisAndAnglev = this.tools.vectorAdapter.from( axisAndAngle );

  let w = quatView.eGet( 0 );
  // let w = quatView.eGet( 3 );

  // if( abs( w-1 ) < this.tools.accuracySqr )
  if( this.tools.avector.isLessAprox( abs( w-1 ), this.tools.accuracySqr ) )
  {
    axisAndAnglev.assign( 0 );
    axisAndAnglev.eSet( 0, 0 );
    // axisAndAnglev.eSet( 3, 0 );
    return axisAndAngle;
  }

  let halfAngle = acos( w );
  let s = sin( halfAngle );

  // axisAndAnglev.eSet( 0, quatView.eGet( 0 ) / s );
  // axisAndAnglev.eSet( 1, quatView.eGet( 1 ) / s );
  // axisAndAnglev.eSet( 2, quatView.eGet( 2 ) / s );
  // axisAndAnglev.eSet( 3, halfAngle * 2 );
  axisAndAnglev.eSet( 1, quatView.eGet( 1 ) / s );
  axisAndAnglev.eSet( 2, quatView.eGet( 2 ) / s );
  axisAndAnglev.eSet( 3, quatView.eGet( 3 ) / s );
  axisAndAnglev.eSet( 0, halfAngle * 2 );

  return axisAndAngle;
}

//

function fromVectors( dst, src1, src2 )
{

  _.assert( arguments.length === 3, 'Expects exactly three arguments' );

  dst = this.from( dst );
  let dstv = this.tools.vectorAdapter.from( dst );
  // let dst3 = dstv.review([ 0, 2 ]);
  let dst3 = dstv.review([ 1, 3 ]);
  let dot = this.tools.avector.dot( src1, src2 );

  dot += Math.sqrt( this.tools.avector.magSqr( src1 ) * this.tools.avector.magSqr( src2 ) );

  if( this.tools.number.equivalent( dot, 0 ) )
  {

    dot = 0;
    dst3.assign([ - src1[ 2 ], src1[ 1 ], src1[ 0 ] ]);

  }
  else
  {

    this.tools.avector.cross3( dst3, src1, src2 );

  }

  dstv.eSet( 0, dot );
  // dstv.eSet( 3, dot );

  this.normalize( dstv );

  return dst;
}

//

function fromVectors2( src1, src2, axis )
{
  throw _.err( 'not tested' );

  src1 = this.tools.vectorAdapter.slice( src1 );
  src2 = this.tools.vectorAdapter.slice( src2 );

  let accuracy = 0.01;
  let v1 = src1.slice().normalize();
  let v2 = src2.slice().normalize();
  let d = v1.dot( v2 );
  let result = [ 1, 0, 0, 0 ];
  // let result = [ 0, 0, 0, 1 ];

  if( d >= 1 - accuracy )
  {
    return result;
  }

  if( d <= accuracy - 1 )
  {
    if( axis )
    result.setFromAxisAngle( axis, Math.PI )
  }
  else
  {
    let w = _sqrt( (1+d)*2 );
    let invw = 1 / w;
    let v = [ 0, 0, 0 ];
    v.crossVectors( v1, v2 );
    result.set( w * 0.5 , v[ 0 ]*invw , v[ 1 ]*invw , v[ 2 ]*invw );
    // result.set( v[ 0 ]*invw , v[ 1 ]*invw , v[ 2 ]*invw , w * 0.5 );
    result.normalize();
  }

  return result;
}

//

function fromNormalizedVectors( dst, src1, src2 )
{

  _.assert( arguments.length === 3, 'Expects exactly three arguments' );

  dst = this.from( dst );
  let dstv = this.tools.vectorAdapter.from( dst );
  let dst3 = dstv.review([ 1, 3 ]);
  // let dst3 = dstv.review([ 0, 2 ]);
  let dot = this.tools.avector.dot( src1, src2 ) + 1;

  if( this.tools.number.equivalent( dot, 0 ) )
  {

    dot = 0;
    dst3.assign([ - src1[ 2 ], src1[ 1 ], src1[ 0 ] ]);

  }
  else
  {

    this.tools.avector.cross3( dst3, src1, src2 );

  }

  dstv.eSet( 0, dot );
  // dstv.eSet( 3, dot );

  this.normalize( dstv );

  return dst;
}

//

function fromMatrixRotation( dst, mat )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.Matrix.Is( mat ) );
  _.assert( mat.dims[ 0 ] >= 3 );
  _.assert( mat.dims[ 1 ] >= 3 );

  dst = this.from( dst );
  let dstv = this.tools.vectorAdapter.from( dst );
  let m00 = mat.scalarGet([ 0, 0 ]), m01 = mat.scalarGet([ 0, 1 ]), m02 = mat.scalarGet([ 0, 2 ]);
  let m10 = mat.scalarGet([ 1, 0 ]), m11 = mat.scalarGet([ 1, 1 ]), m12 = mat.scalarGet([ 1, 2 ]);
  let m20 = mat.scalarGet([ 2, 0 ]), m21 = mat.scalarGet([ 2, 1 ]), m22 = mat.scalarGet([ 2, 2 ]);
  let trace = m00 + m11 + m22;

  if( trace > 0 )
  {

    let s = 0.5 / Math.sqrt( trace + 1.0 );

    // dstv.eSet( 0, ( m21 - m12 ) * s );
    // dstv.eSet( 1, ( m02 - m20 ) * s );
    // dstv.eSet( 2, ( m10 - m01 ) * s );
    // dstv.eSet( 3, 0.25 / s );
    dstv.eSet( 1, ( m21 - m12 ) * s );
    dstv.eSet( 2, ( m02 - m20 ) * s );
    dstv.eSet( 3, ( m10 - m01 ) * s );
    dstv.eSet( 0, 0.25 / s );

  }
  else if( m00 > m11 && m00 > m22 )
  {

    let s = 2.0 * Math.sqrt( 1.0 + m00 - m11 - m22 );

    // dstv.eSet( 0, 0.25 * s );
    // dstv.eSet( 1, ( m01 + m10 ) / s );
    // dstv.eSet( 2, ( m02 + m20 ) / s );
    // dstv.eSet( 3, ( m21 - m12 ) / s );
    dstv.eSet( 1, 0.25 * s );
    dstv.eSet( 2, ( m01 + m10 ) / s );
    dstv.eSet( 3, ( m02 + m20 ) / s );
    dstv.eSet( 0, ( m21 - m12 ) / s );

  }
  else if ( m11 > m22 )
  {

    let s = 2.0 * Math.sqrt( 1.0 + m11 - m00 - m22 );

    // dstv.eSet( 0, ( m01 + m10 ) / s );
    // dstv.eSet( 1, 0.25 * s );
    // dstv.eSet( 2, ( m12 + m21 ) / s );
    // dstv.eSet( 3, ( m02 - m20 ) / s );
    dstv.eSet( 1, ( m01 + m10 ) / s );
    dstv.eSet( 2, 0.25 * s );
    dstv.eSet( 3, ( m12 + m21 ) / s );
    dstv.eSet( 0, ( m02 - m20 ) / s );

  }
  else
  {

    let s = 2.0 * Math.sqrt( 1.0 + m22 - m00 - m11 );

    // dstv.eSet( 0, ( m02 + m20 ) / s );
    // dstv.eSet( 1, ( m12 + m21 ) / s );
    // dstv.eSet( 2, 0.25 * s );
    // dstv.eSet( 3, ( m10 - m01 ) / s );
    dstv.eSet( 1, ( m02 + m20 ) / s );
    dstv.eSet( 2, ( m12 + m21 ) / s );
    dstv.eSet( 3, 0.25 * s );
    dstv.eSet( 0, ( m10 - m01 ) / s );

  }

  return dst;
}

//

function fromMatrixRotation2( dst, mat )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.Matrix.Is( mat ) );
  _.assert( mat.dims[ 0 ] >= 3 );
  _.assert( mat.dims[ 1 ] >= 3 );

  dst = this.from( dst );
  let dstv = this.tools.vectorAdapter.from( dst );

  let m00 = mat.scalarGet([ 0, 0 ]), m01 = mat.scalarGet([ 0, 1 ]), m02 = mat.scalarGet([ 0, 2 ]);
  let m10 = mat.scalarGet([ 1, 0 ]), m11 = mat.scalarGet([ 1, 1 ]), m12 = mat.scalarGet([ 1, 2 ]);
  let m20 = mat.scalarGet([ 2, 0 ]), m21 = mat.scalarGet([ 2, 1 ]), m22 = mat.scalarGet([ 2, 2 ]);

  let x = Math.sqrt( Math.max( 0, 1 + m00 - m11 - m22 ) ) / 2;
  let y = Math.sqrt( Math.max( 0, 1 - m00 + m11 - m22 ) ) / 2;
  let z = Math.sqrt( Math.max( 0, 1 - m00 - m11 + m22 ) ) / 2;
  let w = Math.sqrt( Math.max( 0, 1 + m00 + m11 + m22 ) ) / 2;

  if( _.math.sign( x ) !== _.math.sign( m21 - m12 ) )
  x *= -1;
  if( _.math.sign( y ) !== _.math.sign( m02 - m20 ) )
  y *= -1;
  if( _.math.sign( z ) !== _.math.sign( m10 - m01 ) )
  z *= -1;

  // dstv.eSet( 0 , x );
  // dstv.eSet( 1 , y );
  // dstv.eSet( 2 , z );
  // dstv.eSet( 3 , w );
  dstv.eSet( 1 , x );
  dstv.eSet( 2 , y );
  dstv.eSet( 3 , z );
  dstv.eSet( 0 , w );

  dstv.normalize();

  return dst;
}

//

function fromMatrixWithScale( dst, mat )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.Matrix.Is( mat ) );
  _.assert( mat.dims[ 0 ] >= 3 );
  _.assert( mat.dims[ 1 ] >= 3 );

  dst = this.from( dst );
  let dstv = this.tools.vectorAdapter.from( dst );
  let m = mat.scaleGet().clone().abs().reduceToMean();
  let m00 = mat.scalarGet([ 0, 0 ]) / m, m01 = mat.scalarGet([ 0, 1 ]) / m, m02 = mat.scalarGet([ 0, 2 ]) / m;
  let m10 = mat.scalarGet([ 1, 0 ]) / m, m11 = mat.scalarGet([ 1, 1 ]) / m, m12 = mat.scalarGet([ 1, 2 ]) / m;
  let m20 = mat.scalarGet([ 2, 0 ]) / m, m21 = mat.scalarGet([ 2, 1 ]) / m, m22 = mat.scalarGet([ 2, 2 ]) / m;
  let trace = m00 + m11 + m22;

  if( trace > 0 )
  {

    let s = 0.5 / Math.sqrt( trace + 1.0 );
    let sm = s*m;

    // dstv.eSet( 0, ( m21 - m12 ) * sm );
    // dstv.eSet( 1, ( m02 - m20 ) * sm );
    // dstv.eSet( 2, ( m10 - m01 ) * sm );
    // dstv.eSet( 3, 0.25*m / s );
    dstv.eSet( 1, ( m21 - m12 ) * sm );
    dstv.eSet( 2, ( m02 - m20 ) * sm );
    dstv.eSet( 3, ( m10 - m01 ) * sm );
    dstv.eSet( 0, 0.25*m / s );

  }
  else if( m00 > m11 && m00 > m22 )
  {

    let s = 2.0 * Math.sqrt( 1.0 + m00 - m11 - m22 );
    let sm = s/m;

    // dstv.eSet( 0, 0.25 * s * m );
    // dstv.eSet( 1, ( m01 + m10 ) / sm );
    // dstv.eSet( 2, ( m02 + m20 ) / sm );
    // dstv.eSet( 3, ( m21 - m12 ) / sm );
    dstv.eSet( 1, 0.25 * s * m );
    dstv.eSet( 2, ( m01 + m10 ) / sm );
    dstv.eSet( 3, ( m02 + m20 ) / sm );
    dstv.eSet( 0, ( m21 - m12 ) / sm );

  }
  else if ( m11 > m22 )
  {

    let s = 2.0 * Math.sqrt( 1.0 + m11 - m00 - m22 );
    let sm = s/m;

    // dstv.eSet( 0, ( m01 + m10 ) / sm );
    // dstv.eSet( 1, 0.25 * s * m );
    // dstv.eSet( 2, ( m12 + m21 ) / sm );
    // dstv.eSet( 3, ( m02 - m20 ) / sm );
    dstv.eSet( 1, ( m01 + m10 ) / sm );
    dstv.eSet( 2, 0.25 * s * m );
    dstv.eSet( 3, ( m12 + m21 ) / sm );
    dstv.eSet( 0, ( m02 - m20 ) / sm );

  }
  else
  {

    let s = 2.0 * Math.sqrt( 1.0 + m22 - m00 - m11 );
    let sm = s/m;

    // dstv.eSet( 0, ( m02 + m20 ) / sm );
    // dstv.eSet( 1, ( m12 + m21 ) / sm );
    // dstv.eSet( 2, 0.25 * s * m );
    // dstv.eSet( 3, ( m10 - m01 ) / sm );
    dstv.eSet( 1, ( m02 + m20 ) / sm );
    dstv.eSet( 2, ( m12 + m21 ) / sm );
    dstv.eSet( 3, 0.25 * s * m );
    dstv.eSet( 4, ( m10 - m01 ) / sm );

  }

  return dst;
}

//

function fromMatrixWithScale2( dst, mat )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.Matrix.Is( mat ) );
  _.assert( mat.dims[ 0 ] >= 3 );
  _.assert( mat.dims[ 1 ] >= 3 );

  let rotationMatrix = mat.clone();

  rotationMatrix.colSet( 3, [ 0, 0, 0, 1] );

  let ape = rotationMatrix.scalarsPerElement;
  let l = rotationMatrix.length;
  let scale = rotationMatrix.scaleGet();

  for( let i = 0 ; i < ape ; i += 1 )
  {
    let c = rotationMatrix.rowGet( i );
    c = this.tools.vectorAdapter.fromLongLrange( c, 0, l-1 );
    this.tools.vectorAdapter.div( c, scale );
  }

  return this.fromMatrixRotation( dst, rotationMatrix )
}

//

function fromPlane( plane, origin )
{
  let self = this;
  let originVector;

  return function quatWithPlane( plane, origin )
  {
    if( !originVector ) originVector = [ 0, 0, 1 ];
    throw _.err( 'not tested' );
    origin = origin !== undefined ? origin : originVector;
    let pos0 = [ 0, 0, 0 ];
    let pos1 = [ 0, 0, 0 ];
    let pos2 = [ 0, 0, 0 ];
    // pos0.copy( plane[ 0 ] );
    // pos1.copy( plane[ 1 ] ).sub( pos0 );
    // pos2.copy( plane[ 2 ] ).sub( pos0 );
    pos0.copy( plane[ 1 ] );
    pos1.copy( plane[ 2 ] ).sub( pos0 );
    pos2.copy( plane[ 3 ] ).sub( pos0 );
    pos0.crossVectors( pos1, pos2 ).normalize();

    return self.quatWithVectors( origin, pos0 );
  }

}

//

function toMatrix( quat, mat )
{

  if( mat === null || mat === undefined )
  mat = _.Matrix.Make([ 3, 3 ]);

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( this.is( quat ) );
  _.assert( _.Matrix.Is( mat ) );
  _.assert( mat.dims[ 0 ] >= 3 );
  _.assert( mat.dims[ 1 ] >= 3 );

  mat.fromQuat( quat );

  return mat
}

//

function toEuler( quat, euler )
{
  _.assert( arguments.length === 2 );
  return _.euler.fromQuat2( euler, quat );
}

//

function is( quat )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return ( _.longIs( quat ) || _.vectorAdapterIs( quat ) ) && ( quat.length === 4 );
}

//

function isUnit( quat )
{

  _.assert( arguments.length === 1, 'Expects single argument' );

  let quatView = this.adapterFrom( quat );

  if( quatView.eGet( 0 ) !== 1 )
  return false;
  // if( quatView.eGet( 3 ) !== 1 )
  // return false;

  for( let d = 1 ; d < 4 ; d++ )
  if( quatView.eGet( d ) !== 0 )
  return false;
  // for( let d = 0 ; d < 3 ; d++ )
  // if( quatView.eGet( d ) !== 0 )
  // return false;

  return true;
}

//

function isZero( quat )
{

  _.assert( arguments.length === 1, 'Expects single argument' );

  let quatView = this.adapterFrom( quat );

  if( quatView.eGet( 0 ) !== 0 )
  return false;
  // if( quatView.eGet( 3 ) !== 0 )
  // return false;

  for( let d = 1 ; d < 4 ; d++ )
  if( quatView.eGet( d ) !== 0 )
  return false;
  // for( let d = 0 ; d < 3 ; d++ )
  // if( quatView.eGet( d ) !== 0 )
  // return false;

  return true;
}

//

function dimGet( quat )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( this.is( quat ) );
  return quat.length;
}

//

function conjugate( dst )
{
  let dstv = this.adapterFrom( dst );

  _.assert( arguments.length === 1, 'Expects single argument' );

  dstv.eSet( 1, -dstv.eGet( 1 ) );
  dstv.eSet( 2, -dstv.eGet( 2 ) );
  dstv.eSet( 3, -dstv.eGet( 3 ) );
  // dstv.eSet( 0, -dstv.eGet( 0 ) );
  // dstv.eSet( 1, -dstv.eGet( 1 ) );
  // dstv.eSet( 2, -dstv.eGet( 2 ) );

  return dst;
}

//

function inv( dst )
{
  let dstv = this.adapterFrom( dst );

  _.assert( arguments.length === 1, 'Expects single argument' );

  this.normalize( this.conjugate( dst ) );

  return dst;
}

//

function _mul3( dst, src1, src2 )
{

  let src10 = src1.eGet( 0 ), src11 = src1.eGet( 1 ), src12 = src1.eGet( 2 ), src13 = src1.eGet( 3 );
  let src20 = src2.eGet( 0 ), src21 = src2.eGet( 1 ), src22 = src2.eGet( 2 ), src23 = src2.eGet( 3 );

  dst.eSet( 0, src10 * src20 - src11 * src21 - src12 * src22 - src13 * src23 );
  dst.eSet( 1, src11 * src20 + src10 * src21 + src12 * src23 - src13 * src22 );
  dst.eSet( 2, src12 * src20 + src10 * src22 + src13 * src21 - src11 * src23 );
  dst.eSet( 3, src13 * src20 + src10 * src23 + src11 * src22 - src12 * src21 );

  // dst.eSet( 0, src10 * src23 + src13 * src20 + src11 * src22 - src12 * src21 );
  // dst.eSet( 1, src11 * src23 + src13 * src21 + src12 * src20 - src10 * src22 );
  // dst.eSet( 2, src12 * src23 + src13 * src22 + src10 * src21 - src11 * src20 );
  // dst.eSet( 3, src13 * src23 - src10 * src20 - src11 * src21 - src12 * src22 );

  return dst;
}

//

function mul( dst )
{
  let first = 1;

  _.assert( arguments.length >= 2, 'Expects at least two arguments' );

  if( dst === null )
  {
    dst = this.make( arguments[ 1 ] );
    first = 2;
    _.assert( arguments.length >= 3, 'Expects at least three arguments' );
  }

  let dstv = this.adapterFrom( dst );

  for( let a = first ; a < arguments.length ; a++ )
  {
    let srcv = this.adapterFrom( arguments[ a ] );
    this._mul3( dstv, dstv, srcv );
  }

  return dst;
}

//

function mix( dst, src, val )
{

  let dstv = this.adapterFrom( dst );
  let srcv = this.adapterFrom( src );

  _.assert( arguments.length === 3, 'Expects exactly three arguments' );

  if( val === 0 )
  return dst;

  if( val === 1 )
  debugger;
  if( val === 1 )
  return this.copy( dst, src );

  let src0 = srcv.eGet( 0 ), src1 = srcv.eGet( 1 ), src2 = srcv.eGet( 2 ), src3 = srcv.eGet( 3 );
  let dst0 = dstv.eGet( 0 ), dst1 = dstv.eGet( 1 ), dst2 = dstv.eGet( 2 ), dst3 = dstv.eGet( 3 );

  let cosHalfTheta = src0 * src.eGet( 0 ) + src1 * src.eGet( 1 ) + src2 * src.eGet( 2 ) + src3 * src.eGet( 3 );

  let invertCosHalfTheta = 0;
  if( cosHalfTheta < 0 )
  {
    debugger;
    cosHalfTheta = - cosHalfTheta;
    invertCosHalfTheta = 1;
  }

  if( cosHalfTheta >= 1.0 )
  {

    debugger;
    dstv.eSet( 0, src0 );
    dstv.eSet( 1, src1 );
    dstv.eSet( 2, src2 );
    dstv.eSet( 3, src3 );

    return dst;
  }

  let halfTheta = Math.acos( cosHalfTheta );
  let sinHalfTheta = Math.sqrt( 1.0 - cosHalfTheta * cosHalfTheta );

  if( invertCosHalfTheta )
  {

    debugger;
    src0 = -src0;
    src1 = -src1;
    src2 = -src2;
    src3 = -src3;

  }
  // else
  // {
  //
  //   debugger;
  //   dstv.copy( srcv );
  //
  // }

  if( Math.abs( sinHalfTheta ) < 0.0001 )
  {

    debugger;
    dstv.eSet( 0, 0.5 * ( src0 + dst0 ) );
    dstv.eSet( 1, 0.5 * ( src1 + dst1 ) );
    dstv.eSet( 2, 0.5 * ( src2 + dst2 ) );
    dstv.eSet( 3, 0.5 * ( src3 + dst3 ) );

    return dst;
  }

  debugger;
  let r1 = Math.sin( ( 1 - val ) * halfTheta ) / sinHalfTheta;
  let r2 = Math.sin( t * halfTheta ) / sinHalfTheta;

  dstv.eSet( 0, ( dst0 * r1 + src0 * r2 ) );
  dstv.eSet( 1, ( dst1 * r1 + src1 * r2 ) );
  dstv.eSet( 2, ( dst2 * r1 + src2 * r2 ) );
  dstv.eSet( 3, ( dst3 * r1 + src3 * r2 ) );

  return dst;
}

//

function applyTo( quat, vector )
{

  let quatView = this.adapterFrom( quat );
  let vectorv = this.tools.vectorAdapter.from( vector );

  let x = vectorv.eGet( 0 );
  let y = vectorv.eGet( 1 );
  let z = vectorv.eGet( 2 );

  let qx = quatView.eGet( 1 );
  let qy = quatView.eGet( 2 );
  let qz = quatView.eGet( 3 );
  let qw = quatView.eGet( 0 );
  // let qx = quatView.eGet( 0 );
  // let qy = quatView.eGet( 1 );
  // let qz = quatView.eGet( 2 );
  // let qw = quatView.eGet( 3 );

  let ix = + qw * x + qy * z - qz * y;
  let iy = + qw * y + qz * x - qx * z;
  let iz = + qw * z + qx * y - qy * x;
  let iw = - qx * x - qy * y - qz * z;

  vectorv.eSet( 0 , ix * qw + iw * - qx + iy * - qz - iz * - qy );
  vectorv.eSet( 1 , iy * qw + iw * - qy + iz * - qx - ix * - qz );
  vectorv.eSet( 2 , iz * qw + iw * - qz + ix * - qy - iy * - qx );

  return vector;
}

// --
// declare
// --

let Extension = /* qqq : normalize order */
{

  make,
  makeZero,
  makeUnit,

  zero,
  unit,

  from,
  adapterFrom,

  fromEuler,

  fromAxisAndAngle,
  toAxisAndAngle,

  fromVectors,
  fromVectors2,
  fromNormalizedVectors,

  fromMatrixRotation,
  fromMatrixRotation2,
  fromMatrixWithScale,
  fromMatrixWithScale2,

  fromPlane,

  toMatrix,
  toEuler,

  is,
  isUnit,
  isZero,

  dimGet,

  conjugate,
  inv,

  _mul3,
  mul,
  mix,

  applyTo,

  // ref

  tools : _,

}

/* _.props.extend */Object.assign( _.quat, Extension );

})();
