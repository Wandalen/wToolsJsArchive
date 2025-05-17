( function _Deployer_s_() {

'use strict';

/*

try :
node staging/dwtools/amid/fileDeployer/FileDeployer.s ./staging

*/

if( typeof module !== 'undefined' )
{

  // require( '../../../../wTools/staging/dwtools/abase/wTools.s' );
  // require( '../../../../wFiles/staging/dwtools/amid/file/Files.ss' );

  if( typeof wBase === 'undefined' )
  try
  {
    require( '../../abase/wTools.s' );
  }
  catch( err )
  {
    require( 'wTools' );
  }

  if( typeof wCopyable === 'undefined' )
  try
  {
    require( '../../mixin/Copyable.s' );
  }
  catch( err )
  {
    require( 'wCopyable' );
  }

  //require( '../../../../wFiles/staging/dwtools/amid/file/Files.ss' );

  if( !wTools.files )
  try
  {
    require( '../../amid/file/Files.ss' );
  }
  catch( err )
  {
    require( 'wFiles' );
  }

  var Path = require( 'path' );
  var File = require( 'fs-extra' );

}

//

var _ = wTools;
var Parent = null;
debugger
var Self = function wDeployer( o )
{
  if( !( this instanceof Self ) )
  if( o instanceof Self )
  return o;
  else
  return new( _.routineJoin( Self, Self, arguments ) );
  return Self.prototype.init.apply( this,arguments );
}

//

var init = function( o )
{
  var self = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.instanceInit( self );

  if( self.Self === Self )
  Object.preventExtensions( self );

  if( o )
  self.copy( o );

  /* default file provider, it's HardDrive for backend */

  if( !self.files )
  self.files = _.fileProvider;

}

//

/* exec if launched as stand-alone application */

var exec = function()
{
  var self = this;
  var argv = process.argv;

  debugger;

  console.log( 'argv :',argv );

  self.read( _.join( _.current() , argv[ 2 ] ) );

  logger.log( 'tree :\n' + _.toStr( self._tree,{ levels : 3 } ) );

  var dst = argv[ 3 ] || 'tree.json';

  self.writeToJson( _.join( _.current(), dst ) );

  return self;
}

//

var read = function( o )
{
  var self = this;

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o ) || _.objectIs( o ) );

  if( _.strIs( o ) )
  {
    o = { file : o };
  }

  self.target = o.file;

  self._optionsSupplement( o );
  _.routineOptions( read, o )

  self._tree = self.files.filesTreeRead( o.file );

}

read.defaults =
{
  file : null,
  usingLogging : 0
}

read.defaults.__proto__ = _.FileProvider.Secondary.prototype.filesTreeRead.defaults;

//

var write = function( o )
{
  var self = this;

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o ) || _.objectIs( o ) );

  debugger;

  if( _.strIs( o ) )
  {
    o = { file : o };
  }

  o.tree = self._tree;
  self.target = o.file;

  self._optionsSupplement( o );
  _.routineOptions( write, o )

  return self.files.filesTreeWrite( o.file );
}

write.defaults =
{
  file : null,
}

write.defaults.__proto__ = _.FileProvider.Secondary.prototype.filesTreeWrite.defaults;

//

var readFromJson = function( o )
{
  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o ) || _.objectIs( o ) );

  var self = this;

  if( _.strIs( o ) )
  {
    o = { file : o };
  }

  self._optionsSupplement( o,0 );
  _.routineOptions( readFromJson, o );

  self._tree = self.files.fileReadJson( o.file );

}

readFromJson.defaults =
{
  file : null,
  usingLogging : 0
}

readFromJson.defaults.__proto__ = _.FileProvider.Partial.prototype.fileReadJson.defaults;

console.log( _.toStr( readFromJson.defaults.__proto__ ) );

//

var writeToJson = function( o )
{
  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o ) || _.objectIs( o ) );

  var self = this;

  debugger;

  if( _.strIs( o ) )
  {
    o = { file : o };
  }

  self._optionsSupplement( o,0 );
  _.routineOptions( writeToJson, o );

  var data = _.toStr( self._tree,{ jsonLike : 1 } );
  File.writeFileSync( o.file , data );

}

writeToJson.defaults =
{
  file : null,
  usingLogging : 0,
}

//

var publish = function( o )
{
  var self = this;

  debugger;

}

publish.defaults =
{
}

//

var toStr = function( o )
{
  var self = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  debugger;

}

//

var fileProviderMake = function( o )
{
  var self = this;

  debugger;

}

fileProviderMake.defaults =
{
}

//

var _optionsSupplement = function( options,forTree )
{
  var self = this;

  if( options.usingLogging === undefined )
  options.usingLogging = self.usingLogging;

  if( forTree )
  if( options.file === undefined )
  options.file = self.target;

}

//

// var _writeTreeIntoFile = function( o )
// {
//   var self = this;
//
//   _.assert( arguments.length === 1 );
//
//   if( _.strIs( o ) )
//   {
//     o = { file : o };
//   }
//
//   o.tree = self._tree;
//
//   x
//
// }

// --
//
// --

var Composes =
{
  target : null,
  usingLogging : 1,
  files : null,
}

var Aggregates =
{
}

var Associates =
{
  _tree : null,
}

var Restricts =
{
}

var Static =
{
}

// --
// prototype
// --

var Proto =
{

  init : init,
  exec : exec,

  read : read,
  write : write,

  readFromJson : readFromJson,
  writeToJson : writeToJson,

  publish : publish,

  toStr : toStr,

  fileProviderMake : fileProviderMake,

  _optionsSupplement : _optionsSupplement,

  //_writeTreeIntoFile : _writeTreeIntoFile,

  /**/

  constructor : Self,
  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Static : Static,

};

//

_.classMake
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

//

if( _global_.wCopyable )
wCopyable.mixin( Self );

//

_.accessorForbid( Self.prototype,
{
});

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

_global_[ Self.name ] = wTools.Deployer = Self;

if( typeof module !== 'undefined' )
if( !module.parent )
{
  _global_.deployer = new Self();
  _global_.deployer.exec();
}

return Self;

})();
