( function _TemplateTreeEnvironment_s_( )
{

'use strict';

/**
 * Class to resolve tree-like with links data structures or paths in the structure. TemplateTreeEnvironment extends TemplateTreeResolver to been able to resolve paths into a files system. Use the module to resolve template or path to value.
  @module Tools/mid/TemplateTreeEnvironment
*/

/**
 *  */

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../node_modules/Tools' );

  _.include( 'wTemplateTreeResolver' );
  _.include( 'wPathBasic' );

}

//

/**
 * @classdesc Class to resolve tree-like with links data structures or paths in the structure.
 * TemplateTreeEnvironment extends {@link module:Tools/mid/TemplateTreeResolver.wTemplateTreeResolver TemplateTreeResolver }
 * to been able to resolve paths into a files system.
 * @param {Object} o Options map for constructor. {@link module:Tools/mid/TemplateTreeResolver.wTemplateTreeResolver.Fields Options description }
 * @class wTemplateTreeEnvironment
 * @namespace wTools
 * @module Tools/mid/TemplateTreeEnvironment
*/

const _global = _global_;
const _ = _global_.wTools;
const Parent = wTemplateTreeResolver;
const Self = wTemplateTreeEnvironment;
function wTemplateTreeEnvironment( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'TemplateTreeEnvironment';

// --
// inter
// --

function init( o )
{
  let self = this;

  Parent.prototype.init.call( self, o );

  if( self.constructor === Self )
  Object.preventExtensions( self );

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( self.path === null )
  self.path = _.path;

}

//

function _valueGet( name )
{
  let self = this;
  let name2 = name;

  if( self.front !== null )
  name2 = _.select
  ({
    src : self.front,
    selector : name,
  });

  let result = self._resolve( name2 );

  _.assert( arguments.length === 1 );

  // if( _.errIs( result ) )
  // return;

  if( result === undefined )
  return;

  if( result instanceof _.looker.SeekingError )
  return result;

  if( _.errIs( result ) )
  throw result;

  return result;
}

//

/**
 * @summary Resolves provided string `name` to value.
 * @description Uses default value `def` if fails to get the value.
 * @param {String} name String to resolve.
 * @param {*} def Default value.
 * @function valueTry
 * @class wTemplateTreeEnvironment
 * @namespace wTools
 * @module Tools/mid/TemplateTreeEnvironment
*/

function valueTry( name, def )
{
  let self = this;
  let result = self._valueGet( name );

  _.assert( arguments.length === 1 || def !== undefined, 'def should not be undefined if used' );
  _.assert( arguments.length === 1 || arguments.length === 2, 'valueTry expects 1 or 2 arguments' );

  if( def !== undefined )
  if( result === undefined || _.errIs( result ) )
  result = def;

  if( self.verbosity )
  logger.debug( 'value :', name, '->', result );

  return result;
}

//

/**
 * @summary Resolves provided string `name` to value.
 * @description Throws an Error if fails to get the value.
 * @param {String} name String to resolve.
 * @function valueGet
 * @class wTemplateTreeEnvironment
 * @namespace wTools
 * @module Tools/mid/TemplateTreeEnvironment
*/

function valueGet( name )
{
  let self = this;
  let result = self._valueGet( name );

  _.assert( arguments.length === 1, 'valueGet expects 1 argument' );

  if( _.errIs( result ) )
  throw result;

  if( result === undefined )
  {
    throw _.err( 'Unknown variable', name );
  }

  return result;
}

//
//
// function _pathGet( name )
// {
//   let self = this;
//   let result = self.valueTry( name );
//
//   _.assert( arguments.length === 1 );
//
//   if( !result )
//   return;
//
//   result = self._pathNormalize( filePath );
//
//   if( self.verbosity )
//   logger.debug( 'path :', name, '->', result );
//
//   return result;
// }
//
//

function _pathNormalize( filePath )
{
  let self = this;

  filePath = self.path.join( self.basePath, filePath );
  filePath = self.path.normalize( filePath );
  filePath = filePath.replace( /(?<!:|:\/)\/\//, '/' );

  return filePath;
}

//

/**
 * @summary Resolves provided string `name` to a path.
 * @description Uses default value `def` if fails to get the path.
 * @param {String} name String to resolve.
 * @param {String} def Default value.
 * @function pathTry
 * @class wTemplateTreeEnvironment
 * @namespace wTools
 * @module Tools/mid/TemplateTreeEnvironment
*/

function pathTry( name, def )
{
  let self = this;
  let result = self._valueGet( name );

  _.assert( arguments.length === 1 || arguments.length === 2, 'pathTry expects 1 or 2 arguments' );

  if( !result || _.errIs( result ) )
  result = def;

  result = self._pathNormalize( result );

  if( self.verbosity )
  logger.debug( 'path :', name, '->', result );

  return result;
}

//

/**
 * @summary Resolves provided string `name` to a path.
 * @description Throws an Error if fails to get the path.
 * @param {String} name String to resolve.
 * @function pathGet
 * @class wTemplateTreeEnvironment
 * @namespace wTools
 * @module Tools/mid/TemplateTreeEnvironment
*/

function pathGet( name )
{
  let self = this;
  let result = self._valueGet( name );

  if( result === undefined )
  {
    throw _.err( 'Unknown variable', name );
  }

  if( result instanceof _.looker.SeekingError )
  {
    throw _.err( 'Unknown variable', name, '\n', result );
  }

  result = self._pathNormalize( result );

  if( self.verbosity )
  logger.debug( 'path :', name, '->', result );

  return result;
}

//

/**
 * @summary Normalizes all paths from current tree.
 * @function pathsNormalize
 * @class wTemplateTreeEnvironment
 * @namespace wTools
 * @module Tools/mid/TemplateTreeEnvironment
*/

function pathsNormalize()
{
  let self = this;

  for( let t in self.tree )
  {
    let src = self.tree[ t ];
    if( !_.strEnds( t, 'Path' ) )
    continue;
    if( !_.strIs( src ) )
    continue;
    self.tree[ t ] = self.pathGet( src );
  }

  return self;
}

// --
// relations
// --

/**
 * @typedef {Object} Fields
 * @property {Number} verbosity=0 Controls level of verbosity.
 * @property {String} basePath='' Base of path obtained from resolving of the template.
 * @property {Object} front
 * @property {Object} path Reference to path namespace {@link module:Tools/base/Path.wTools.path}
 * @class wTemplateTreeEnvironment
 * @namespace wTools
 * @module Tools/mid/TemplateTreeEnvironment
*/

let Composes =
{
  verbosity : 0,
  basePath : '',
}

let Associates =
{
  front : null,
  path : null,
}

let Restricts =
{
}

// --
// declare
// --

let Proto =
{

  init,

  _valueGet,
  valueTry,
  valueGet,

  _pathNormalize,
  pathTry,
  pathGet,
  // path : pathGet,

  pathsNormalize,

  // relations

  Composes,
  Associates,
  Restricts,

};

// define

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

//


_[ Self.shortName ] = _global_[ Self.name ] = Self;
if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

})();
