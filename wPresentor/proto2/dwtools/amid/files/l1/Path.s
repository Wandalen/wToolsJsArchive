(function _Path_ss_() {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../UseBase.s' );

  let _global = _global_;
  let _ = _global_.wTools;

  _.include( 'wPathFundamentals' );

}

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools.path;

_.assert( _.objectIs( Self ) );

// --
// routines
// --

/**
 * Returns absolute path to file. Accepts file record object. If as argument passed string, method returns it.
 * @example
 * let str = 'foo/bar/baz',
    fileRecord = FileRecord( str );
   let path = wTools.path.from( fileRecord ); // '/home/user/foo/bar/baz';
 * @param {string|wFileRecord} src file record or path string
 * @returns {string}
 * @throws {Error} If missed argument, or passed more then one.
 * @throws {Error} If type of argument is not string or wFileRecord.
 * @method from
 * @memberof wTools.path
 */

function from( src )
{

  _.assert( arguments.length === 1, 'expects single argument' );

  if( _.strIs( src ) )
  return src;
  else if( src instanceof _.FileRecord )
  return src.absolute;
  else _.assert( 0, 'unexpected type of argument', _.strTypeOf( src ) );

}

//

let pathsFrom = _.routineVectorize_functor( from );

//

function nativize( src )
{
  _.assert( arguments.length === 1 );
  _.assert( _.routineIs( this.fileProvider.pathNativizeAct ) );
  return this.fileProvider.pathNativizeAct( src );
}

//

/**
 * Returns the current working directory of the Node.js process. If as argument passed path to existing directory,
   method sets current working directory to it. If passed path is an existing file, method set its parent directory
   as current working directory.
 * @param {string} [path] path to set current working directory.
 * @returns {string}
 * @throws {Error} If passed more than one argument.
 * @throws {Error} If passed path to not exist directory.
 * @method current
 * @memberof wTools.path
 */

function current()
{
  let path = this;
  let provider = this.fileProvider;

  _.assert( _.objectIs( provider ) );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( _.routineIs( provider.pathCurrentAct ) );
  _.assert( _.routineIs( path.isAbsolute ) );

  if( arguments[ 0 ] )
  try
  {

    let filePath = arguments[ 0 ];
    _.assert( _.strIs( filePath ) );

    if( !path.isAbsolute( filePath ) )
    filePath = path.join( provider.pathCurrentAct(), filePath );

    if( provider.fileExists( filePath ) && provider.fileIsTerminal( filePath ) )
    filePath = path.resolve( filePath, '..' );

    provider.pathCurrentAct( filePath );

  }
  catch( err )
  {
    throw _.err( 'File was not found : ' + arguments[ 0 ] + '\n', err );
  }

  let result = provider.pathCurrentAct();

  _.assert( _.strIs( result ) );

  result = path.normalize( result );

  return result;
}

// --
// declare
// --

let Proto =
{

  from : from,
  pathsFrom : pathsFrom,

  nativize : nativize,
  current : current,

}

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
