(function _Changes_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( '../../../../node_modules/Tools' );
}

//

const _ = _global_.wTools;
const _ArraySlice = Array.prototype.slice;
const _FunctionBind = Function.prototype.bind;
const _ObjectToString = Object.prototype.toString;
const _ObjectHasOwnProperty = Object.hasOwnProperty;

// --
// changes
// --

/**
 * @summary Extension name map `dst` by other name maps.
 * @param {Object} dst Target map.
 * @function changesExtend
 * @namespace wTools
 * @module Tools/base/ChangeTransactor
*/

function changesExtend( dst )
{

  _.assert( _.object.isBasic( dst ) );

  for( var a = 1 ; a < arguments.length ; a++ )
  {
    var src = arguments[ a ];

    _changesExtend( dst, src )

  }

  return dst;
}

//

/**
 * @summary Extension name map `dst` by other name map `src`.
 * @param {Object} dst Target map.
 * @param {Object} src Source map.
 * @function _changesExtend
 * @namespace wTools
 * @module Tools/base/ChangeTransactor
*/

function _changesExtend( dst, src )
{

  _.assert( arguments.length === 2 );
  _.assert( _.object.isBasic( src ) );

  for( var s in src )
  {

    _.assert( _.object.isBasic( src ) || _.boolsIs( src ) );

    /**/

    if( _.arrayIs( src[ s ] ) )
    {
      if( dst[ s ] === undefined )
      dst[ s ] = [];
      else
      dst[ s ] = [ dst[ s ] ];
    }

    if( _.boolIs( dst[ s ] ) )
    {
      dst[ s ] = [ dst[ s ] ];
    }

    /**/

    if( _.boolIs( src[ s ] ) )
    {
      dst[ s ] = src[ s ];
    }
    else if( _.arrayIs( src[ s ] ) )
    {
      for( var i = 0, l = src[ s ].length ; i < l ; i++ )
      dst[ s ].push( src[ s ][ i ] );
    }
    else if( _.object.isBasic( src[ s ] ) )
    {

      if( _.object.isBasic( dst[ s ] ) )
      dst[ s ] = _changesExtend( dst[ s ], src[ s ] );
      else if( dst[ s ] === undefined )
      dst[ s ] = _changesExtend( Object.create( null ), src[ s ] );
      else if( _.arrayIs( dst[ s ] ) )
      dst[ s ].push( _changesExtend( Object.create( null ), src[ s ] ) );
      else _.assert( 0, 'unknown dst type' );

    }
    else _.assert( 0, 'unknown src type' );

  }

  return dst;
}

//

/**
 * @summary Selects sub map from map `src` with help of `changes` map.
 * @param {Object} changes Changes map.
 * @param {Object} src Source map.
 * @param {Object} options Options map.
 * @function changesSelect
 * @namespace wTools
 * @module Tools/base/ChangeTransactor
*/

function changesSelect( changes, src, options )
{
  var options = options || Object.create( null );
  var result = Object.create( null );

  var optionsDefault =
  {
    ignoreUndefined : false,
    /*onSelect : function(){},*/
  }

  _.map.assertHasOnly( options, optionsDefault );
  _.props.supplement( options, optionsDefault );
  _.assert( _.object.isBasic( changes ) );

  result = _changesSelectFromContainer( result, src, changes, options );

  return result;
}

//

/**
 * @summary Selects sub map from map `srcContainer` with help of `changes` map. Actual implementation.
 * @param {Object} resultContainer Result map.
 * @param {Object} srcContainer Source map.
 * @param {Object} changes Changes map.
 * @param {Object} options Options map.
 * @function _changesSelectFromContainer
 * @namespace wTools
 * @module Tools/base/ChangeTransactor
*/

function _changesSelectFromContainer( /* resultContainer, srcContainer, changes, options */ )
{

  let resultContainer = arguments[ 0 ];
  let srcContainer = arguments[ 1 ];
  let changes = arguments[ 2 ];
  let options = arguments[ 3 ];

  _.assert( arguments.length === 4 );
  _.assert( _.object.isBasic( changes ) );
  _.assert( _.object.isBasic( resultContainer ) );

  for( let n in changes )
  {

    let change = changes[ n ];
    resultContainer = _changesSelectFromTerminal( resultContainer, srcContainer, n, change, options );

  }

  return resultContainer;
}

//

/**
 * @summary Selects property from map `srcContainer` with name of `name` map. Actual implementation.
 * @param {Object} resultContainer Result map.
 * @param {Object} srcContainer Source map.
 * @param {String} name Property name.
 * @param {Object} change Changes map.
 * @param {Object} options Options map.
 * @function _changesSelectFromTerminal
 * @namespace wTools
 * @module Tools/base/ChangeTransactor
*/

function _changesSelectFromTerminal( /* resultContainer, srcContainer, name, change, options */ )
{

  let resultContainer = arguments[ 0 ];
  let srcContainer = arguments[ 1 ];
  let name = arguments[ 2 ];
  let change = arguments[ 3 ];
  let options = arguments[ 4 ];

  _.assert( arguments.length === 5 );
  _.assert( change !== undefined );
  _.assert( _.object.isBasic( resultContainer ) );
  _.assert( _.strIs( name ) );

  if( _.boolIs( change ) )
  {

    if( change )
    {
      resultContainer[ name ] = _changesSelectingClone( resultContainer[ name ], srcContainer[ name ] );
    }
    else
    {
      delete resultContainer[ name ];
    }

    if( change && !options.ignoreUndefined )
    _.assert( resultContainer[ name ] !== undefined );

  }
  else if( _.object.isBasic( change ) )
  {
    if( resultContainer[ name ] )
    {
      if( !_.object.isBasic( resultContainer[ name ] ) )
      resultContainer[ name ] = _.longToMap( resultContainer[ name ] );
    }
    else
    {
      resultContainer[ name ] = Object.create( null );
    }
    resultContainer[ name ] = _changesSelectFromContainer( resultContainer[ name ], srcContainer[ name ], change, options );
  }
  else if( _.arrayIs( change ) )
  {
    for( var c = 0 ; c < change.length ; c++ )
    resultContainer = _changesSelectFromTerminal( resultContainer, srcContainer, name, change[ c ], options );
  }
  else _.assert( 0, 'Strange changes map' );

  return resultContainer;
}

//

/**
 * @summary Apply changes to object.
 * @param {Object} changes Changes map.
 * @param {Object} dst Target map.
 * @param {Object} src Source map.
 * @param {Object} options Options map.
 * @function changesApply
 * @namespace wTools
 * @module Tools/base/ChangeTransactor
*/

function changesApply( /* changes, dst, src, options */ )
{

  let changes = arguments[ 0 ];
  let dst = arguments[ 1 ];
  let src = arguments[ 2 ];
  let options = arguments[ 3 ];

  options = options || Object.create( null );

  _.assert( _.object.isBasic( dst ) );
  _.assert( 3 <= arguments.length && arguments.length <= 4 );

  return _changesApply( changes, dst, src, options );
}

//

/**
 * @summary Apply changes to object. Actual implementation.
 * @param {Object} changes Changes map.
 * @param {Object} dst Target map.
 * @param {Object} src Source map.
 * @param {Object} options Options map.
 * @function _changesApply
 * @namespace wTools
 * @module Tools/base/ChangeTransactor
*/

function _changesApply( /* changes, dst, src, options */ )
{
  let changes = arguments[ 0 ];
  let dst = arguments[ 1 ];
  let src = arguments[ 2 ];
  let options = arguments[ 3 ];

  _.assert( arguments.length === 4 );

  if( _.boolIs( changes ) )
  {

    if( changes )
    {
      return _changesApplyingSet( dst, src );
    }
    else
    {
      return;
    }

  }
  else if( _.arrayIs( changes ) )
  {
    var val0 = dst;
    for( let c = 0 ; c < changes.length ; c++ )
    {
      val0 = _changesApply( changes[ c ], val0, src, options );
      if( c+1 < changes.length && val0 === undefined )
      {
        val0 = _.entity.cloneShallow( dst );
      }
    }
    dst = val0;
  }
  else if( _.object.isBasic( changes ) )
  {

    _.assert( !!dst );
    for( let c in changes )
    {

      var val = _changesApply( changes[ c ], dst[ c ], src[ c ], options );
      if( val === undefined )
      delete dst[ c ];
      else
      dst[ c ] = val;

      // if( val !== undefined )
      // dst[ c ] = val;
      // else
      // delete dst[ c ];
    }

  }
  else _.assert( 0, 'Strange changes map' );

  return dst;
}

//

/**
 * @summary Clones source enity. Actual implementation.
 * @param {*} src Source entity.
 * @function _changesSelectingClone
 * @namespace wTools
 * @module Tools/base/ChangeTransactor
*/

function _changesSelectingClone( dst, src )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( _.primitiveIs( src ) )
  return src;

  var result = _.cloneData
  ({
    src,
    // copyingBuffers : 1,
  });

  return result;
}

//

/**
 * @param {Object} dst Target entity.
 * @param {Object} src Source entity.
 * @function _changesApplyingSet
 * @namespace wTools
 * @module Tools/base/ChangeTransactor
*/

function _changesApplyingSet( dst, src )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( dst )
  {

    if( dst.copyCustom && src )
    return dst.copyCustom
    ({

      dst,
      src,

      copyingComposes : 3,
      copyingAggregates : 1,
      copyingAssociates : 0,

      technique : 'object',

    });

  }

  if( _.primitiveIs( src ) )
  {
    return src;
  }

  return src;
}

// --
// declare
// --

const Proto =
{

  changesExtend,
  _changesExtend,

  changesSelect,
  _changesSelectFromContainer,
  _changesSelectFromTerminal,

  changesApply,
  _changesApply,

  _changesSelectingClone,
  _changesApplyingSet,

};

_.props.extend( _, Proto );

// --
// export
// --


if( typeof module !== 'undefined' )
module[ 'exports' ] = _;

})();
