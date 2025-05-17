(function _cScalar_s_() {

'use strict';

if( typeof module !== 'undefined' )
{
  if( typeof wBase === 'undefined' )
  try
  {
    try
    {
      require.resolve( '../../../../dwtools/Base.s' )/*fff*/;
    }
    finally
    {
      require( '../../../../dwtools/Base.s' )/*fff*/;
    }
  }
  catch( err )
  {
    require( 'wTools' );
  }
var _ = wTools;

}

var _ = wTools;
var _random = Math.random;
var _floor = Math.floor;
var _ceil = Math.ceil;
var _round = Math.round;

if( _.EPS === undefined )
_.EPS = 1e-5;

if( _.EPS2 === undefined )
_.EPS2 = 1e-10;

var EPS = _.EPS;
var EPS2 = _.EPS2;

// --
// basic
// --

function fract( src )
{
  return src - _floor( src );
}

//

function factorial( src )
{
  if( src > 1 )
  return src * factorial( src - 1 );
  return src;
}

// //
//
// function minmax( dstMinMax,value )
// {
//   if( _.arrayIs( value ) )
//   {
//
//     if( !dstMinMax )
//     dstMinMax = [];
//
//     _.assert( value.length >= dstMinMax.length,'minmax :','expects dstMinMax and value of same length' );
//
//     for( var i = 0 ; i < value.length ; i++ )
//     dstMinMax[ i ] = minmax( dstMinMax[ i ],value[ i ] );
//
//     return dstMinMax;
//   }
//
//   if( !dstMinMax )
//   dstMinMax = [ +Infinity,-Infinity ];
//
//   if( dstMinMax[ 0 ] > value )
//   dstMinMax[ 0 ] = value;
//   if( dstMinMax[ 1 ] < value )
//   dstMinMax[ 1 ] = value;
//
//   return dstMinMax;
// }

//

function clamp( src , low , high )
{
  return _.numberClamp.apply( _,arguments );
}

//

function sqrt( src )
{
  return Math.sqrt( src );
}

//

function sqr( src )
{
  return src * src;
}

//

function cbd( src )
{
  return src * src * src;
}

//

function mod( src1,src2 )
{
  _.assert( arguments.length === 2 );
  var result = src1 - src2 * Math.floor( src1 / src2 );
  return result;
}

//

var sign = function( src )
{

  return ( src < 0 ) ? - 1 : ( src > 0 ) ? 1 : 0;

}

//

function sc( src )
{
  var result = Object.create( null );

  result.s = Math.sin( src );
  result.c = Math.cos( src );

  return result;
}

// --
// round
// --

function roundToPowerOfTwo( src )
{

  _.assert( _.numberIs( src ) );
  _.assert( arguments.length === 1 );

  // if( _.arrayIs( src ) )
  // {
  //   var result = [];
  //   for( var s = 0 ; s < src.length ; s++ )
  //   result[ s ] = roundToPowerOfTwo( src[ s ] );
  //   return result;
  // }

  return Math.pow( 2, Math.round( Math.log( src ) / Math.LN2 ) );
}

//

function ceilToPowerOfTwo( src )
{

  _.assert( _.numberIs( src ) );
  _.assert( arguments.length === 1 );

  // if( _.arrayIs( src ) )
  // {
  //   var result = [];
  //   for( var s = 0 ; s < src.length ; s++ )
  //   result[ s ] = ceilToPowerOfTwo( src[ s ] );
  //   return result;
  // }

  return Math.pow( 2, _ceil( Math.log( src ) / Math.LN2 ) );
}

//

function floorToPowerOfTwo( src )
{

  _.assert( _.numberIs( src ) );
  _.assert( arguments.length === 1 );

  // if( _.arrayIs( src ) )
  // {
  //   var result = [];
  //   for( var s = 0 ; s < src.length ; s++ )
  //   result[ s ] = floorToPowerOfTwo( src[ s ] );
  //   return result;
  // }

  return Math.pow( 2, Math.floor( Math.log( src ) / Math.LN2 ) );
}

// --
// prototype
// --

var Proto =
{

  // basic

  fract : fract,
  factorial : factorial,

  clamp : clamp,
  sqrt : sqrt,
  sqr : sqr,
  cbd : cbd,

  mod : mod,
  sign : sign,
  sc : sc,


  // round

  roundToPowerOfTwo : roundToPowerOfTwo,
  ceilToPowerOfTwo : ceilToPowerOfTwo,
  floorToPowerOfTwo : floorToPowerOfTwo,


  // var

  EPS : EPS,
  EPS2 : EPS2,

}

_.mapExtend( wTools,Proto );
_.assert( _.EPS >= 0 );
_.assert( _.EPS2 >= 0 );

})();
