( function _NameMapper_s_( )
{

'use strict';

/**
 * Simple class to map names from one space to another and vice versa. Options for handling names collisions exist. Use the module to make your program shorter, more readable and to avoid typos.
  @module Tools/mid/NameMapper
*/

/**
 *  */

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../node_modules/Tools' );

  _.include( 'wCopyable' );

}

//

/**
 * @classdesc Simple class to map names from one space to another and vice versa.
 * @param {Object} o Options map for constructor. {@link module:Tools/mid/NameMapper.wNameMapper.Fields Options description }
 * @example
 * let mapper = new _.NameMapper({ leftName : 'kind of entity', rightName : 'name of routine' })
 * @class wNameMapper
 * @namespace wTools
 * @module Tools/mid/NameMapper
*/

const _global = _global_;
const _ = _global_.wTools;
const Parent = null;
const Self = wNameMapper;
function wNameMapper( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'NameMapper';

// --
// inter
// --

function init( o )
{
  let mapper = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.workpiece.initFields( mapper );

  if( o )
  mapper.copy( o );

  mapper.forVal = mapper._forVal.bind( mapper );
  mapper.forKey = mapper._forKey.bind( mapper );
  mapper.forVals = mapper._forVals.bind( mapper );
  mapper.forKeys = mapper._forKeys.bind( mapper );
  mapper.hasKey = mapper._hasKey.bind( mapper );
  mapper.hasVal = mapper._hasVal.bind( mapper );

  if( mapper.constructor === Self )
  Object.preventExtensions( mapper );
}

//

/**
 * @summary Maps names from one space to another and vice versa.
 * @description Expects at least one map with key:value pairs.
 * @example
 * let shortNameToLong  = new _.NameMapper().set
   ({
      'Tools' : 'wTools',
      'NameMapper' : 'wNameMapper',
   });
   shortNameToLong.forKey('NameMapper') // wNameMapper
   shortNameToLong.forVal('wTools') // Tools
 * @method set
 * @class wNameMapper
 * @namespace wTools
 * @module Tools/mid/NameMapper
*/

function set()
{
  let mapper = this;

  _.assert( arguments.length > 0 );

  mapper.val = _.props.extend( null, mapper.val );
  _.mapsExtend( mapper.val, arguments );

  if( mapper.droppingDuplicates )
  mapper.key = _.mapInvertDroppingDuplicates( mapper.val );
  else
  mapper.key = _.mapInvert( mapper.val );

  Object.freeze( mapper.val );
  Object.freeze( mapper.key );

  return mapper;
}

//

/**
 * @summary Returns key mapped with provided value `val`.
 * @example
 * let val  = new _.NameMapper().set
   ({
      'A' : 'B',
   });
   val.forVal('B') // A
 * @method forVal
 * @class wNameMapper
 * @namespace wTools
 * @module Tools/mid/NameMapper
*/

function _forVal( val )
{
  let mapper = this;
  let result = mapper.key[ val ];

  _.assert( arguments.length === 1, 'Expects single argument' );

  if( result === undefined )
  result = mapper.onNothing( undefined, val, mapper );

  _.assert( result !== undefined, () => 'Unknown ' + mapper.rightName + ' ' + val );

  return result;
}

//

/**
 * @summary Returns value mapped with provided key `key`.
 * @example
 * let val  = new _.NameMapper().set
   ({
      'A' : 'B',
   });
   val.forKey('A') // B
 * @method forKey
 * @class wNameMapper
 * @namespace wTools
 * @module Tools/mid/NameMapper
*/

function _forKey( key )
{
  let mapper = this;
  let result = mapper.val[ key ];

  _.assert( arguments.length === 1, 'Expects single argument' );

  if( result === undefined )
  result = mapper.onNothing( key, undefined, mapper );

  _.assert( result !== undefined, () => 'Unknown ' + mapper.leftName + ' ' + key );

  return result;
}

//

/**
 * @summary Returns key mapped with provided value `val`.
 * @example
 * let val  = new _.NameMapper().set
   ({
      'A' : 'B',
   });
   val.forVal('B') // A
 * @method forVals
 * @class wNameMapper
 * @namespace wTools
 * @module Tools/mid/NameMapper
*/

function _forVals( val )
{
  let mapper = this;

  _.assert( arguments.length === 1, 'Expects single argument' );

  if( !_.primitiveIs( val ) )
  {
    return _.container.map_( null, val, function forVal( val )
    {
      return mapper._forVal( val );
    });
  }

  return mapper._forVal( val );
}

//

/**
 * @summary Returns value mapped with provided key `key`.
 * @example
 * let val  = new _.NameMapper().set
   ({
      'A' : 'B',
   });
   val.forKey('A') // B
 * @method forKeys
 * @class wNameMapper
 * @namespace wTools
 * @module Tools/mid/NameMapper
*/

function _forKeys( key )
{
  let mapper = this;

  _.assert( arguments.length === 1, 'Expects single argument' );

  if( !_.primitiveIs( key ) )
  {
    return _.container.map_( null, key, function forKey( key )
    {
      return mapper._forKey( key );
    });
  }

  return mapper._forKey( key );
}


//

/**
 * @summary Returns true if map has key:value pair with provided value `val`.
 * @example
 * let val  = new _.NameMapper().set
   ({
      'A' : 'B',
   });
   val.hasVal('A') // false
   val.hasVal('B') // true
 * @method hasVal
 * @class wNameMapper
 * @namespace wTools
 * @module Tools/mid/NameMapper
*/

function _hasVal( val )
{
  let mapper = this;
  return mapper.key[ val ] !== undefined;
}

//

/**
 * @summary Returns true if map has key:value pair with provided key `key`.
 * @example
 * let val  = new _.NameMapper().set
   ({
      'A' : 'B',
   });
   val.hasKey('A') // true
   val.hasKey('B') // false
 * @method hasKey
 * @class wNameMapper
 * @namespace wTools
 * @module Tools/mid/NameMapper
*/

function _hasKey( key )
{
  let mapper = this;
  _.assert( _.strIs( key ) || _.numberIs( key ), 'Expects string or number {-key-}, but got', _.entity.strType( key ) );
  return mapper.val[ key ] !== undefined;
}

//

function Nothing()
{
}

//

function AsIs( key, val, mapper )
{
  if( key === undefined )
  return val;
  else
  return key;

  // if( key !== undefined )
  // return key;
  // else
  // return val;
}

// --
// relations
// --

/**
 * @typedef {Object} Fields
 * @property {Boolean} droppingDuplicates=1 Prevents duplication of keys.
 * @property {Boolean} asIsIfMiss=0 Return source value if key:value pair is not found.
 * @property {Object} val Container for mapped key:value pairs.
 * @property {Object} key Container for mapped value:key pairs.
 * @property {String} leftName='key' Description of left side of key:value pair.
 * @property {String} rightName='value' Description of right side of key:value pair.
 * @class wNameMapper
 * @namespace wTools
 * @module Tools/mid/NameMapper
 */

let Composes =
{
  droppingDuplicates : 1,
  // asIsIfMiss : 0,
  onNothing : Nothing,
  val : _.define.own( {} ),
  key : _.define.own( {} ),
  leftName : 'key',
  rightName : 'value',
}

let Associates =
{
}

let Restricts =
{
}

let Forbids =
{
  asIsIfMiss : 'asIsIfMiss'
}

let Statics =
{
  Nothing,
  AsIs,
}

// --
// declare
// --

let Proto =
{

  init,
  set,

  _forVal,
  _forKey,
  _forVals,
  _forKeys,
  _hasVal,
  _hasKey,

  Nothing,
  AsIs,

  // relations

  Composes,
  Associates,
  Restricts,
  Forbids,
  Statics,

};

// define

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.Copyable.mixin( Self );

//

_[ Self.shortName ] = _global_[ Self.name ] = Self;
if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

})();
