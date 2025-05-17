( function _ArraySorted_s_() {

'use strict';

/**
  @module Tools/base/ArraySorted - Collection of routines to operate effectively sorted arrays. For that ArraySorted provides customizable quicksort algorithm and a dozen functions to optimally find/add/remove single/multiple elements into a sorted array, add/remove sorted array to/from another sorted array. Use it to increase the performance of your algorithms.
*/

/**
 * @file ArraySorted.s.
 */

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

}

//

let _global = _global_;
let _ = _global_.wTools;
let Self = _.sorted = _.sorted || Object.create( null );

// --
// array sorted
// --

/**
 * Bin search of element ( ins ) in array ( arr ). Find element with closest value.
 * If array does not have such element then return index of smallest possible greater element.
 * If array does not have such element then element previous to returned is smaller.
 * Could return index of the next ( non-existent ) after the last one element.
 * Zero is the least possible returned index.
 * Could return index of any element if there are several elements with such value.
 *
 * @param { longIs } arr - Entity to check.
 * @param { Number } ins - Element to locate in the array.
 * @param { Function } comparator - A callback function.
 * @param { Number } left - The index to start the search at.
 * @param { Number } right - The index to end the search at.
 *
 * @example
 * // returns 4
 * _lookUpAct( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b }, 0, 5 );
 *
 * @example
 * // returns 5
 * _lookUpAct( [ 1, 2, 3, 4, 5 ], 55, function( a, b ) { return a - b }, 0, 5 );
 *
 * @returns { Number } Returns the first index at which a given element (ins)
 * can be found in the array (arr).
 * Otherwise, if (ins) was not found, it returns the length of the array (arr) or the index from which it ended search at.
 * @method _lookUpAct
 * @memberof wTools
 */

function _lookUpAct( arr,ins,comparator,left,right )
{

  _.assert( right >= 0 );
  _.assert( left <= arr.length );

  let oleft = left;
  let oright = right;

  let d = 0;
  let current = ( left + right ) >> 1;

  /* */

  while( left < right )
  {

    let d = comparator( arr[ current ],ins );

    if( d < 0 )
    {
      left = current + 1;
      current = ( left + right ) >> 1;
    }
    else if( d > 0 )
    {
      right = current;
      current = ( left + right ) >> 1;
    }
    else return current;

  }

  /* */

  if( current < arr.length )
  {
    let d = comparator( arr[ current ],ins );
    if( d === 0 )
    return current;
    if( d < 0 )
    current += 1;
  }

  /*  */

  if( Config.debug )
  {

    /* current element is greater */
    if( _.numberIs( ins ) && current > oleft )
    if( current < oright )
    _.assert( comparator( arr[ current ],ins ) > 0 );

    /* next element is greater */
    if( _.numberIs( ins ) )
    if( current+1 < oright )
    _.assert( comparator( arr[ current+1 ],ins ) > 0 );

    /* prev element is smaller */
    if( _.numberIs( ins ) )
    if( current-1 >= oleft )
    _.assert( comparator( arr[ current-1 ],ins ) < 0 );

  }

  return current;
}

//

function lookUpIndex( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  comparator = _._comparatorFromEvaluator( comparator );
  let index = this._lookUpAct( arr,ins,comparator,0,arr.length );

  if( index === arr.length )
  return -1;

  if( comparator( ins,arr[ index ] ) !== 0 )
  return -1;

  return index;
}

//

function lookUpValue( arr,ins,comparator )
{
  let index = this.lookUpIndex.apply( this, arguments );
  return arr[ index ];
}

//

/**
 * The wTools.sorted.lookUp() method returns a new object containing the properties, (value, index),
 * corresponding to the found value (ins) from array (arr).
 *
 * @see {@link wTools._lookUpAct} - See for more information.
 *
 * @param { longIs } arr - Entity to check.
 * @param { Number } ins - Element to locate in the array.
 * @param { wTools~compareCallback } [comparator=function( a, b ) { return a - b }] comparator - A callback function.
 *
 * @example
 * // returns { value : 5, index : 4 }
 * _.sorted.lookUp( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b } );
 *
 * @example
 * // returns undefined
 * _.sorted.lookUp( [ 1, 2, 3, 4, 5 ], 55, function( a, b ) { return a - b } );
 *
 * @returns { Object } Returns a new object containing the properties, (value, index),
 * corresponding to the found value (ins) from the array (arr).
 * Otherwise, it returns 'undefined'.
 * @method wTools.sorted.lookUp
 * @throws { Error } Will throw an Error if (arguments.length) is less than two or more than three.
 * @throws { Error } Will throw an Error if (arr) is not an array-like.
 * @memberof wTools
 */

function lookUp( arr,ins,comparator )
{
  let index = this.lookUpIndex.apply( this, arguments );
  return { value : arr[ index ], index : index };
}

//

function lookUpClosestIndex( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  comparator = _._comparatorFromEvaluator( comparator );
  let index = this._lookUpAct( arr,ins,comparator,0,arr.length );

  return index;
}

//

function lookUpClosestValue( arr,ins,comparator )
{
  let index = this.lookUpClosestIndex.apply( this, arguments );
  return arr[ index ];
}

//

function lookUpClosest( arr,ins,comparator )
{
  let index = this.lookUpClosestIndex.apply( this, arguments );
  return { value : arr[ index ], index : index };
}

//

function lookUpInterval( arr,range,comparator )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  comparator = _._comparatorFromEvaluator( comparator );
  let length = arr.length;
  let b = _.sorted._leftMostAtLeastIndex( arr,range[ 0 ],comparator,0,length );

  if( b === length || comparator( arr[ b ],range[ 1 ] ) > 0 )
  return [ b,b ];

  let e = _.sorted._rightMostAtLeastIndex( arr,range[ 1 ],comparator,b+1,length );

  if( comparator( arr[ e ],range[ 1 ] ) <= 0 )
  e += 1;

  if( Config.debug )
  {

    if( b < length )
    _.assert( arr[ b ] >= range[ 0 ] );

    if( b > 0 )
    _.assert( arr[ b-1 ] < range[ 0 ] );

    if( e < length )
    _.assert( arr[ e ] > range[ 1 ] );

    if( e > 0 )
    _.assert( arr[ e-1 ] <= range[ 1 ] );

  }

  return [ b,e ]
}

//

function lookUpIntervalNarrowest( arr, range, comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  comparator = _._comparatorFromEvaluator( comparator );

  let length = arr.length;
  let b = _.sorted._rightMostAtLeastIndex( arr,range[ 0 ],comparator,0,length );

  // if( b === length )
  // if( comparator( arr[ b - 1 ],range[ 0 ] ) < 0 )
  // return [ b,b ];
  //
  // if( b === 0 )
  // if( comparator( arr[ b ],range[ 1 ] ) > 0 )
  // return [ b,b ];

  let e = _.sorted._leftMostAtMostIndex( arr,range[ 1 ],comparator,b,length );

  e += 1;

  // if( comparator( arr[ e - 1 ],range[ 1 ] ) > 0 )
  // e -= 1;
  //
  // if( comparator( arr[ e ],range[ 1 ] ) <= 0 )
  // e += 1;

  if( Config.debug )
  {

    if( b < length )
    _.assert( comparator( arr[ b ], range[ 0 ] ) >= 0 );

    if( b > 0 )
    _.assert( comparator( arr[ b-1 ], range[ 0 ] ) <= 0 );

    if( e < length )
    _.assert( comparator( arr[ e ], range[ 1 ] ) >= 0 );

    if( e > 0 )
    _.assert( comparator( arr[ e-1 ], range[ 1 ] ) <= 0 );

  }

  return [ b,e ]
}

//

function lookUpIntervalNarrowestOld( arr, range, comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  comparator = _._comparatorFromEvaluator( comparator );
  let length = arr.length;
  let b = _.sorted._rightMostAtLeastIndex( arr,range[ 0 ],comparator,0,length );

  if( b === length )
  if( comparator( arr[ b - 1 ],range[ 0 ] ) < 0 )
  return [ b,b ];

  if( b === 0 )
  if( comparator( arr[ b ],range[ 1 ] ) > 0 )
  return [ b,b ];

  let e = _.sorted._leftMostAtLeastIndex( arr,range[ 1 ],comparator,b+1,length );

  if( comparator( arr[ e - 1 ],range[ 1 ] ) > 0 )
  e -= 1;

  if( comparator( arr[ e ],range[ 1 ] ) <= 0 )
  e += 1;

  if( Config.debug )
  {

    if( b < length )
    _.assert( arr[ b ] >= range[ 0 ] );

    if( b > 0 )
    _.assert( arr[ b-1 ] <= range[ 0 ] );

    if( e < length )
    _.assert( arr[ e ] >= range[ 1 ] );

    if( e > 0 )
    _.assert( arr[ e-1 ] <= range[ 1 ] );

  }

  return [ b,e ]
}

//

function lookUpIntervalHaving( arr, range, comparator )
{
  comparator = _._comparatorFromEvaluator( comparator );

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  let length = arr.length;
  let b = _.sorted._leftMostAtMostIndex( arr, range[ 0 ], comparator, 0, length );
  let e = _.sorted._rightMostAtMostIndex( arr, range[ 1 ]-1, comparator, Math.max( 0,b ), length )+1;

  if( e === 0 && b === -1 )
  e -= 1;

  if( Config.debug )
  {
    _.assert( b === -1 || b === length || comparator( arr[ b ], range[ 0 ] ) <= 0 );
    _.assert( e === -1 || e === length || comparator( arr[ e ], range[ 1 ] ) >= 0 );
    _.assert( e <= length )
  }

  return [ b,e ]
}

//

function lookUpIntervalEmbracingAtLeast( arr, range, comparator )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  comparator = _._comparatorFromEvaluator( comparator );

  let length = arr.length;
  let b = _.sorted._rightMostAtMostIndex( arr,range[ 0 ],comparator,0,length );
  if( b < 0 )
  b = 0

  let e0 = length;
  if( b+1 <= length )
  e0 = _.sorted._rightMostAtLeastIndex( arr,range[ 1 ],comparator,b+1,length );
  let e = e0;
  while( e < arr.length-1 )
  {
    if( comparator( arr[ e0 ], arr[ e+1 ] ) !== 0 )
    break;
    e += 1;
  }

  if( Config.debug )
  {

    // if( b < length )
    // _.assert( arr[ b ] >= range[ 0 ] );

    if( b > 0 )
    _.assert( arr[ b-1 ] <= range[ 0 ] );

    if( e < length )
    _.assert( arr[ e ] >= range[ 1 ] );

    // if( e > 0 )
    // _.assert( arr[ e-1 ] <= range[ 1 ] );

  }

  return [ b,e ]
}

//

function lookUpIntervalEmbracingAtLeastOld( arr, range, comparator )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  comparator = _._comparatorFromEvaluator( comparator );
  let length = arr.length;
  let b = _.sorted._rightMostAtLeastIndex( arr,range[ 0 ],comparator,0,length );

  if( 0 < b && b < length )
  if( comparator( arr[ b ],range[ 0 ] ) > 0 )
  b -= 1;

  if( b === length || comparator( arr[ b ],range[ 1 ] ) > 0 )
  return [ b,b ];

  let e = _.sorted._leftMostAtLeastIndex( arr,range[ 1 ],comparator,b+1,length );

  if( e > 0 )
  {
    if( e < length )
    if( comparator( arr[ e-1 ],range[ 1 ] ) < 0 )
    e += 1;
  }
  else
  {
    _.assert( length > 0 );
    if( comparator( arr[ e ],range[ 1 ] ) <= 0 )
    e += 1;
  }

  if( Config.debug )
  {

    // if( b < length )
    // _.assert( arr[ b ] >= range[ 0 ] );

    if( b > 0 )
    _.assert( arr[ b-1 ] <= range[ 0 ] );

    if( e < length )
    _.assert( arr[ e ] >= range[ 1 ] );

    // if( e > 0 )
    // _.assert( arr[ e-1 ] <= range[ 1 ] );

  }

  return [ b,e ]
}

// --
// left-most at-least
// --

function _leftMostAtLeastIndex( arr,ins,comparator,left,right )
{
  let index = _.sorted._lookUpAct( arr,ins,comparator,left,right );

  _.assert( arguments.length === 5 );

  if( index === right )
  return right;

  let c = comparator( arr[ index ], ins );

  if( c !== 0 )
  return index;

  let i = index-1;
  while( i >= left )
  {
    if( comparator( arr[ i ], ins ) < 0 )
    break;
    i -= 1;
  }

  index = i + 1;

  return index;
}

//

function leftMostAtLeastIndex( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  if( !arr.length )
  return 0;

  let l = arr.length;
  comparator = _._comparatorFromEvaluator( comparator );
  let index = _.sorted._leftMostAtLeastIndex( arr,ins,comparator,0,l );

  return index;
}

//

function leftMostAtLeastValue( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );

  let index = this.leftMostAtLeastIndex( arr,ins,comparator );
  let result = arr[ index ];

  return result;
}

//

function leftMostAtLeast( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );

  let index = this.leftMostAtLeastIndex( arr,ins,comparator );
  let result = { value : arr[ index ], index : index };

  return result;
}

// --
// left-most at-most
// --

function _leftMostAtMostIndex( arr,ins,comparator,left,right )
{
  let index = _.sorted._lookUpAct( arr,ins,comparator,left,right );

  _.assert( arguments.length === 5 );
  _.assert( index >= 0, 'expectation' );

  if( index === right )
  return right-1;

  let i = index;
  // index = left;
  while( i >= left )
  {
    let c = comparator( arr[ i ],ins );
    if( c < 0 )
    {
      // if( index === -1 )
      // index = i;
      // else
      // index = i + 1;
      return index;
    }
    else if( c === 0 )
    {
      index = i;
    }
    else
    {
      index -= 1;
    }
    i -= 1;
  }

  return index;
}

//

function leftMostAtMostIndex( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  if( !arr.length )
  return 0;

  let l = arr.length;
  comparator = _._comparatorFromEvaluator( comparator );
  let index = _.sorted._leftMostAtMostIndex( arr,ins,comparator,0,l );

  return index;
}

//

function leftMostAtMostValue( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );

  let index = this.leftMostAtMostIndex( arr,ins,comparator );
  let result = arr[ index ];

  return result;
}

//

function leftMostAtMost( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );

  let index = this.leftMostAtMostIndex( arr,ins,comparator );
  let result = { value : arr[ index ], index : index };

  return result;
}

// --
// right-most at-least
// --

function _rightMostAtLeastIndex( arr,ins,comparator,left,right )
{
  let index = _.sorted._lookUpAct( arr,ins,comparator,left,right );

  _.assert( arguments.length === 5 );

  if( index === right )
  return right;

  let c = comparator( arr[ index ],ins );
  if( c !== 0 )
  return index;

  let i = index+1;
  while( i < right )
  {
    if( comparator( arr[ i ], ins ) > 0 )
    break;
    i += 1;
  }

  index = i - 1;
  return index;
}

//

function rightMostAtLeastIndex( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  if( !arr.length )
  return 0;

  let l = arr.length;
  comparator = _._comparatorFromEvaluator( comparator );
  let index = _.sorted._rightMostAtLeastIndex( arr,ins,comparator,0,l );

  return index;
}

//

function rightMostAtLeastValue( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );

  let index = this.rightMostAtLeastIndex( arr,ins,comparator );
  let result = arr[ index ];

  return result;
}

//

function rightMostAtLeast( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );

  let index = this.rightMostAtLeastIndex( arr,ins,comparator );
  let result = { value : arr[ index ], index : index };

  return result;
}

// --
// right-most at-most
// --

function _rightMostAtMostIndex( arr,ins,comparator,left,right )
{
  let index = _.sorted._lookUpAct( arr,ins,comparator,left,right );

  _.assert( arguments.length === 5 );

  if( index === right )
  return right-1;

  let i = index;
  while( i < right )
  {
    let c = comparator( arr[ i ],ins );
    if( c > 0 )
    {
      index = i - 1;
      return index;
    }
    else if( c === 0 )
    {
      index = i;
    }
    i += 1;
  }

  return index;
}

//

function rightMostAtMostIndex( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  if( !arr.length )
  return 0;

  let l = arr.length;
  comparator = _._comparatorFromEvaluator( comparator );
  let index = _.sorted._rightMostAtMostIndex( arr,ins,comparator,0,l );

  return index;
}

//

function rightMostAtMostValue( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );

  let index = this.rightMostAtMostIndex( arr,ins,comparator );
  let result = arr[ index ];

  return result;
}

//

function rightMostAtMost( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );

  let index = this.rightMostAtMostIndex( arr,ins,comparator );
  let result = { value : arr[ index ], index : index };

  return result;
}

// --
//
// --

/**
 * The wTools.sorted.remove() method returns true, if a value (ins) was removed from an array (arr).
 * Otherwise, it returns false.
 *
 * @see {@link wTools._lookUpAct} - See for more information.
 *
 * @param { longIs } arr - Entity to check.
 * @param { Number } ins - Element to locate in the array.
 * @param { wTools~compareCallback } [ comparator = function( a, b ) { return a - b } ] comparator - A callback function.
 *
 * @example
 * // returns true
 * this.sorted.remove( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b } ); // => [ 1, 2, 3, 4 ]
 *
 * @example
 * // returns false
 * this.sorted.remove( [ 1, 2, 3, 4, 5 ], 55, function( a, b ) { return a - b } ); // => [ 1, 2, 3, 4, 5 ]
 *
 * @returns { Boolean } Returns true, if a value (ins) was removed from an array (arr).
 * Otherwise, it returns false.
 * @method wTools.sorted.remove
 * @throws { Error } Will throw an Error if (arguments.length) is less than two or more than three.
 * @throws { Error } Will throw an Error if (arr) is not an array-like.
 * @memberof wTools
 */

function remove( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  comparator = _._comparatorFromEvaluator( comparator );
  let l = arr.length;
  let index = _.sorted._lookUpAct( arr,ins,comparator,0,l );

  let remove = index !== l && comparator( ins,arr[ index ] ) === 0;

  if( remove ) arr.splice( index,1 );

  return remove;
}

//

/**
 * The wTools.sorted.addOnce() method returns true, if a value (ins) was added to an array (arr).
 * Otherwise, it returns false.
 *
 * It calls the method (_.sorted._lookUpAct( arr, ins, comparator, 0, arr.length - 1 )),
 * that returns the index of the value (ins) in the array (arr).
 * [wTools._lookUpAct() ]{@link wTools._lookUpAct}.
 * If (index) is equal to the one, and call callback function(comparator( ins, arr[ index ])
 * returns a value that is not equal to the zero (i.e the array (arr) doesn't contain the value (ins)), it adds the value (ins) to the array (arr), and returns true.
 * Otherwise, it returns false.
 *
 * @see {@link wTools._lookUpAct} - See for more information.
 *
 * @param { longIs } arr - Entity to check.
 * @param { Number } ins - Element to locate in the array.
 * @param { wTools~compareCallback } [ comparator = function( a, b ) { return a - b } ] comparator - A callback function.
 *
 * @example
 * // returns false
 * wTools.sorted.addOnce( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b } ); // => [ 1, 2, 3, 4, 5 ]
 *
 * @example
 * // returns true
 * wTools.sorted.addOnce( [ 1, 2, 3, 4, 5 ], 55, function( a, b ) { return a - b } ); // => [ 1, 2, 3, 4, 5, 55 ]
 *
 * @returns { Boolean } Returns true, if a value (ins) was added to an array (arr).
 * Otherwise, it returns false.
 * @method wTools.sorted.addOnce
 * @throws { Error } Will throw an Error if (arguments.length) is less than two or more than three.
 * @throws { Error } Will throw an Error if (arr) is not an array-like.
 * @memberof wTools
 */

function addOnce( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  comparator = _._comparatorFromEvaluator( comparator );
  let l = arr.length;
  let index = _.sorted._lookUpAct( arr,ins,comparator,0,l );

  let add = index === l || comparator( ins,arr[ index ] ) !== 0;

  if( add )
  arr.splice( index,0,ins );

  return add;
}

//

/**
 * The wTools.sorted.add() method adds the value (ins) to the array (arr), no matter whether it has there or hasn't,
 * and returns the new added or the updated index.
 *
 * It calls the method (_.sorted._lookUpAct( arr, ins, comparator, 0, arr.length - 1 )),
 * that returns the index of the value (ins) in the array (arr).
 * [wTools._lookUpAct() ]{@link wTools._lookUpAct}.
 * If value (ins) has in the array (arr), it adds (ins) to that found index and offsets the old values in the (arr).
 * Otherwise, it adds the new index.
 *
 * @see {@link wTools._lookUpAct} - See for more information.
 *
 * @param { longIs } arr - Entity to check.
 * @param { Number } ins - Element to locate in the array.
 * @param { wTools~compareCallback } [ comparator = function( a, b ) { return a - b } ] comparator - A callback function.
 *
 * @example
 * // returns 5
 * wTools.sorted.add( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b } ); // => [ 1, 2, 3, 4, 5, 5 ]
 *
 * @example
 * // returns 4
 * wTools.sorted.add( [ 1, 2, 3, 4 ], 2, function( a, b ) { return a - b } ); // => [ 1, 2, 2, 3, 4 ]
 *
 * @returns { Number } Returns the new added or the updated index.
 * @method wTools.sorted.add
 * @throws { Error } Will throw an Error if (arguments.length) is less than two or more than three.
 * @throws { Error } Will throw an Error if (arr) is not an array-like.
 * @memberof wTools
 */

function add( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  comparator = _._comparatorFromEvaluator( comparator );
  let l = arr.length;
  let index = _.sorted._lookUpAct( arr,ins,comparator,0,l );

  arr.splice( index,0,ins );

  return index;
}

//

/**
 * The wTools.sorted.addArray() method returns the sum of the added indexes from an array (src) to an array (dst).
 *
 * It creates variable (result = 0), iterates over an array (src),
 * adds to the (result +=) each call the function( _.sorted.add( dst, src[ s ], comparator ) )
 * that returns the new added or the updated index.
 *
 * @see {@link wTools_.sorted.add} - See for more information.
 *
 * @param { longIs } dst - Entity to check.
 * @param { longIs } src - Entity to check.
 * @param { wTools~compareCallback } [ comparator = function( a, b ) { return a - b } ] comparator - A callback function.
 *
 * @example
 * // returns 19
 * _.sorted.addArray( [ 1, 2, 3, 4, 5 ], [ 6, 7, 8, 2 ], function( a, b ) { return a - b } ); // => [ 1, 2, 2, 3, 4, 5, 6, 7, 8 ]
 *
 * @example
 * // returns 3
 * _.sorted.addArray( [  ], [ 1, 2, 3 ], function( a, b ) { return a - b } ); // => [ 1, 2, 3 ]
 *
 * @returns { Number } Returns the sum of the added indexes from an array (src) to an array (dst).
 * @method wTools.sorted.addArray
 * @throws { Error } Will throw an Error if (arguments.length) is less than two or more than three.
 * @throws { Error } Will throw an Error if (dst and src) are not an array-like.
 * @memberof wTools
 */

function addArray( dst,src,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( dst ) && _.longIs( src ) );

  let result = 0;
  comparator = _._comparatorFromEvaluator( comparator );

  for( let s = 0 ; s < src.length ; s++ )
  result += this.add( dst,src[ s ],comparator );

  return result;
}

// --
// declare
// --

let Proto =
{

  // array sorted

  // _comparatorFromEvaluator : _comparatorFromEvaluator,

  _lookUpAct : _lookUpAct,

  lookUpIndex : lookUpIndex,
  lookUpValue : lookUpValue,
  lookUp : lookUp,

  lookUpClosestIndex : lookUpClosestIndex,
  lookUpClosestValue : lookUpClosestValue,
  lookUpClosest : lookUpClosest,

  lookUpInterval : lookUpInterval,
  lookUpIntervalNarrowest : lookUpIntervalNarrowest, /* experimental */
  lookUpIntervalNarrowestOld : lookUpIntervalNarrowestOld, /* experimental */
  lookUpIntervalHaving : lookUpIntervalHaving,
  lookUpIntervalEmbracingAtLeast : lookUpIntervalEmbracingAtLeast, /* experimental */
  lookUpIntervalEmbracingAtLeastOld : lookUpIntervalEmbracingAtLeastOld, /* experimental */

  _leftMostAtLeastIndex : _leftMostAtLeastIndex,
  leftMostAtLeastIndex : leftMostAtLeastIndex,
  leftMostAtLeastValue : leftMostAtLeastValue,
  leftMostAtLeast : leftMostAtLeast,

  _leftMostAtMostIndex : _leftMostAtMostIndex,
  leftMostAtMostIndex : leftMostAtMostIndex,
  leftMostAtMostValue : leftMostAtMostValue,
  leftMostAtMost : leftMostAtMost,

  _rightMostAtLeastIndex : _rightMostAtLeastIndex,
  rightMostAtLeastIndex : rightMostAtLeastIndex,
  rightMostAtLeastValue : rightMostAtLeastValue,
  rightMostAtLeast : rightMostAtLeast,

  _rightMostAtMostIndex : _rightMostAtMostIndex,
  rightMostAtMostIndex : rightMostAtMostIndex,
  rightMostAtMostValue : rightMostAtMostValue,
  rightMostAtMost : rightMostAtMost,

  // closestIndex : closestIndex,
  // closestValue : closestValue,
  // closest : closest,

  remove : remove,
  add : add,
  addOnce : addOnce,
  addArray : addArray,

}

// _.mapExtend( _, Proto );
_.mapExtend( Self, Proto );

// --
// export
// --

if( typeof module !== 'undefined' )
if( _global_.WTOOLS_PRIVATE )
delete require.cache[ module.id ];

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
