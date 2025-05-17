( function _FileExecutor_s_()
{

'use strict';

/**
  @module Tools/amid/Executor - Experimental. Class to execute a collection of templates with inlined JavaScript code to instantiate it. A collection of templates could be co-dependent in which case FileExecutor deduce dependencies and correct order of templates executions.
*/

/**
 *  */

/*
qqq : repair, please
*/

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../../node_modules/Tools' );

  _.include( 'wFiles' );
  _.include( 'wFilesArchive' );
  _.include( 'wEventHandler' );
  _.include( 'wConsequence' );
  _.include( 'wPathTranslator' );
  _.include( 'wBlueprint' );

  let VirtualMachine = require( 'vm' );

  try
  {
    let Coffee = require( 'coffeescript' );
  }
  catch( err )
  {
  }

}

//

const _ = _global_.wTools;
const Parent = null;
const Self = wFileExecutor;
function wFileExecutor( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'FileExecutor';

//

function init( o )
{
  let self = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.workpiece.initFields( self );

  Object.preventExtensions( self );

  if( o )
  self.copy( o );

  if( self.archive === null )
  self.archive = new _.FilesArchive();

  if( self.fileProvider === null )
  self.fileProvider = new _.FileFilter.Archive({ archive : self.archive });

  // if( self.fileProvider === null )
  // self.fileProvider = new _.FileProvider.Default();

  return self;
}

//

function languageFromFilePath( filePath )
{

  if( _.strEnds( filePath, '.coffee' ) )
  return 'coffee'
  else if( _.strEnds( filePath, '.js' ) || _.strEnds( filePath, '.s' ) || _.strEnds( filePath, '.ss' ) )
  return 'ecma';

}

//

function scriptExecute( o )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.routine.options_( scriptExecute, o );

  if( !o.language )
  o.language = languageFromFilePath( o.filePath );
  if( !o.name )
  o.name = _.path.name( o.filePath );

  if( !o.language && o.defaultLanguage )
  o.language = o.defaultLanguage;

  if( o.language === 'ecma' )
  return this.ecmaExecute( o );
  else if( o.language === 'coffee' )
  return this.coffeeExecute( o );

  _.assert( 0, 'unknown language', o.language );
}

scriptExecute.defaults =
{
  language : null,
  defaultLanguage : 'ecma',
  code : null,
  filePath : null,
  name : null,
  context : null,
  isConfig : 0,
  // wrapContext : 1,
  // return : 0,
  externals : null,
  verbosity : 1,
  debug : 0,
}

//

function ecmaExecute( o )
{
  let result;

  _.routine.options_( ecmaExecute, o );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( o.code ) );

  let execOptions =
  {
    code : o.code,
    context : o.context,
    filePath : o.filePath,
    prependingReturn : o.prependingReturn,
    externals : o.externals,
    debug : o.debug,
  }

  _.routineExec( execOptions );
  _.props.extend( o, execOptions );

  return o;
}

ecmaExecute.defaults =
{

  prependingReturn : 0,

  // code : null,
  // context : null,

  language : 'ecma',

  // executor : null,
  //
  // language : 'coffee',
  // filePath : null,
  // name : null,
  // return : 1,
  //
  // codePrefix : null,
  // codePostfix : null,
  // onInclude : null,
  // externals : null,
  //
  // bare : 1,
  // fix : 1,
  // wrapContext : 0,
  // verbosity : 1,

  // context : {},
  // executor : null,
  //
  // language : 'coffee',
  // filePath : null,
  // name : null,
  // return : 1,
  //
  // codePrefix : null,
  // codePostfix : null,
  // onInclude : null,
  // externals : null,
  //
  // bare : 1,
  // fix : 1,
  // wrapContext : 0,
  // verbosity : 1,

}

// ecmaExecute.defaults.__proto__ = scriptExecute.defaults;
Object.setPrototypeOf( ecmaExecute.defaults, scriptExecute.defaults )

//

function coffeeCompile( o )
{
  let self = this;
  let result = '';

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.routine.options_( coffeeCompile, o );

  if( !_.strIs( o.code ) )
  throw _.err( 'coffeCompile', 'Expects (-o.code-)' );

  // if( o.fix )
  // {
  //   o.code = _.strLinesIndentation( o.code, '  ' );
  //   o.code = [ self.prefix, o.code, self.postfix ].join( '\n' );
  // }

  let compileOptions =
  {
    filename : o.filePath,
    bare : !!o.baring,
  }

  result += Coffee.compile( o.code, compileOptions );

  return result;
}

coffeeCompile.defaults =
{
  filePath : null,
  code : null,
  baring : 0,
}

//

function coffeeExecute( o )
{
  let self = this;

  if( _.strIs( o ) )
  o = { code };

  _.routine.options_( coffeeExecute, o );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( !o.name )
  o.name = o.filePath ? _.path.name( o.filePath ) : 'unknown';

  // let optionsForCompile = _.props.extend( null, o );
  o.filePath = self.fileProvider.path.nativize( o.filePath );

  logger.log( 'coffeeExecute', o.filePath );

  let optionsForCompile = _.mapOnly_( null, o, this.coffeeCompile.defaults );
  optionsForCompile.baring = o.isConfig;
  o.code = this.coffeeCompile( optionsForCompile );
  o.prependingReturn = 1;

  let result = this.ecmaExecute( o );

  return result;
}

coffeeExecute.defaults =
{
  language : 'coffee',
}

// _.props.supplement( coffeeExecute.defaults, coffeeCompile.defaults );

// coffeeExecute.defaults.__proto__ = scriptExecute.defaults;
Object.setPrototypeOf( coffeeExecute.defaults, scriptExecute.defaults )
// --
// include
// --


function sessionMake( o )
{
  let self = this;

  _.routine.options_( sessionMake, o );
  _.assert( arguments.length === 1, 'Expects single argument' );

  let session = Object.create( null );
  session.rootIncludeFrame = null;
  session.fileFrames = [];
  session.onFileExec = null;

  _.props.extend( session, o );

  if( session.exposingInclude || session.exposingEnvironment || session.exposingTools )
  {
    session.externals = session.externals || Object.create( null );
  }

  Object.preventExtensions( session );
  return session;
}

sessionMake.defaults =
{
  allowIncluding : 1,
  allowIncludingChildren : 1,
  exposingInclude : 1,
  exposingEnvironment : 1,
  exposingTools : 1,
  externals : null,
  context : null,
}

//

function includeFrameBegin( o )
{
  let self = this;

  _.routine.options_( includeFrameBegin, o );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( o.fileFrames === null )
  o.fileFrames = [];
  if( o.usedIncludeFrames === null )
  o.usedIncludeFrames = [];

  let includeFrame = new IncludeFrameBlueprint.make();

  includeFrame.userIncludeFrame = o.userIncludeFrame;
  includeFrame.usedIncludeFrames = o.usedIncludeFrames
  includeFrame.fileFrames = [];

  includeFrame.session = includeFrame.userIncludeFrame ? includeFrame.userIncludeFrame.session : self.session;
  includeFrame.externals = includeFrame.session.externals;
  includeFrame.context = includeFrame.session.context;

  if( !includeFrame.userIncludeFrame )
  {
    self.session.rootIncludeFrame = includeFrame;
  }

  Object.preventExtensions( includeFrame );
  self.includeFrames.unshift( includeFrame );

  return includeFrame;
}

includeFrameBegin.defaults =
{
  userIncludeFrame : null,
}

//

function includeFrameEnd( includeFrame )
{
  let self = this;

  if( self.verbosity > 1 )
  logger.log( 'includeFrameEnd', includeFrame.includeOptions.path );

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( includeFrame.session === self.session );
  _.assert( _.construction.isInstanceOf( includeFrame, IncludeFrameBlueprint ) );

  _.arrayRemoveElementOnceStrictly( self.includeFrames, includeFrame );

  if( !includeFrame.userIncludeFrame )
  {
    self.session = null;
    _.assert( self.includeFrames.length === 0 );
  }

}

//

function _includeAct( o )
{
  let self = this;
  let session = o.session;

  _.routine.options_( _includeAct, o );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.object.isBasic( session ) );
  _.assert( _.object.isBasic( o.translator ) );

  if( self.verbosity > 2 )
  logger.log( '_includeAct.begin', o.path );

  // let maskTerminal = new _.RegexpObject( [], _.RegexpObject.Names.includeAny );
  let maskTerminal = _.RegexpObject
  ({
    excludeAny :
    [
      /(^|\/)\.(?!$|\/|\.)/,
      /(^|\/)-/,
      /\.(raw)($|\.|\/)/,
    ],
  });

  // let maskTerminal = _.RegexpObject.And( maskTerminal,maskTerminal2 );
  // if( o.translator.virtualFor( o.path || '.' ) === '/index/**' )
  // debugger;

  if( !o.withManual && _.path.isGlob( o.path ) )
  {
    maskTerminal = _.RegexpObject.And( maskTerminal, _.RegexpObject({ excludeAny : /\.(manual)($|\.|\/)/ }) );
  }

  // if( options.forTheDocument )
  // {
  //   let maskNotManual = _.regexpMakeObject( self.env.valueGet( '{{mask/manual}}' ) || /\.manual($|\.|\/)/, _.RegexpObject.Names.excludeAny );
  //   _.RegexpObject.And( maskTerminal,maskNotManual );
  // }
  //
  // if( options.maskTerminal )
  // _.RegexpObject.And( maskTerminal, _.regexpMakeObject( options.maskTerminal, _.RegexpObject.Names.includeAny ) );

  let userIncludeFrame = self.includeFrames[ 0 ];
  let includeFrame = self.includeFrameBegin({ userIncludeFrame });

  _.assert( _.construction.isInstanceOf( includeFrame, IncludeFrameBlueprint ) );

  includeFrame.userChunkFrame = o.userChunkFrame;
  includeFrame.translator = o.translator.clone();
  includeFrame.includeOptions = o;
  includeFrame.resolveOptions = o.resolveOptions || Object.create( null );

  // logger.log( 'maskTerminal', _.entity.exportString( maskTerminal,{ levels : 3 } ) );

  /* resolve */

  let resolveOptions =
  {
    globPath : includeFrame.translator.virtualFor( o.path || '.' ),
    ends : o.ends,
    translator : includeFrame.translator,
    maskTerminal,
    outputFormat : 'record',
    orderingExclusion : [ [ '.external', '' ], [ '.head', '', '.post' ] ],
    withDirs : 0,
  }

  includeFrame.resolveOptions = _filesFilterMasksSupplement( includeFrame.resolveOptions, resolveOptions );
  // self.fileProvider._filesFilterMasksSupplement( includeFrame.resolveOptions, resolveOptions );

  let filter = _.files.FileRecordFilter.TolerantFrom( includeFrame.resolveOptions, { defaultProvider : self.fileProvider } );
  includeFrame.resolveOptions.filter = filter;

  includeFrame.resolveOptions = _.mapOnly_( null, includeFrame.resolveOptions, self.fileProvider.filesResolve.defaults );

  if( includeFrame.resolveOptions.allowingMissed === undefined || includeFrame.resolveOptions.allowingMissed === null )
  includeFrame.resolveOptions.allowingMissed = 1;

  // debugger; // aaa
  includeFrame.files = self.fileProvider.filesResolve( includeFrame.resolveOptions );
  // debugger; // aaa

  if( !includeFrame.files.length && !o.optional )
  {
    throw _.err( '\nnone file found for', includeFrame.resolveOptions.globPath, '\n' );
  }

  /* */

  if( !o.syncExternal )
  o.syncExternal = new _.Consequence().take( null );
  includeFrame.consequence = new _.Consequence();

  o.syncExternal.give( function( err, arg )
  {
    includeFrame.consequence.take( err, arg );
  });

  self.filesExecute
  ({
    includeFrame,
    consequence : includeFrame.consequence,
  })

  includeFrame.consequence.ifNoErrorThen( function _includeSecondAfter( arg )
  {
    if( self.verbosity > 2 )
    logger.log( '_includeAct.end', o.path );
    _.assert( session === self.session );
    return arg;
  });

  includeFrame.consequence.finally( function _includeSecondAfter( err, arg )
  {
    // debugger;
    if( err )
    {
      o.syncExternal.take( err, arg );
      throw _.err( err );
    }

    // logger.log( 'includeFrameEnd\n', _.select( self.includeFrames, '*.includeOptions.globPath' ) );

    self.includeFrameEnd( includeFrame );

    o.syncExternal.take( null );
    return arg;
  });

  return includeFrame;

  function _filesFilterMasksSupplement( dst, src )
  {
    _.assert( arguments.length === 2, 'Expects exactly two arguments' );

    _.props.supplement( dst, src );

    dst.maskDirectory = _.RegexpObject.And
    (
      null, dst.maskDirectory || Object.create( null ), src.maskDirectory || Object.create( null )
    );
    dst.maskTerminal = _.RegexpObject.And
    (
      null, dst.maskTerminal || Object.create( null ), src.maskTerminal || Object.create( null )
    );
    dst.maskAll = _.RegexpObject.And
    (
      null, dst.maskAll || Object.create( null ), src.maskAll || Object.create( null )
    );

    return dst;
  }

}

_includeAct.defaults =
{
  path : null,
  ends : null,
  optional : 0,
  withManual : 0,
  ifAny : null,
  ifAll : null,
  ifNone : null,
  onIncludeFromat : null,
  session : null,
  translator : null,
  userChunkFrame : null,
  resolveOptions : null,
  syncExternal : null,
}

//

function _includeFromChunk( bound, o, o2 )
{
  let self = this;
  let chunkFrame = bound.chunkFrame;
  let includeFile = bound.includeFile;
  let session = chunkFrame.fileFrame.includeFrame.session;

  if( _.strIs( o ) )
  o = { path : o };

  if( _.routineIs( o2 ) )
  o2 = { onIncludeFromat : o2 }

  if( o2 )
  {
    _.props.extend( o, o2 );
  }

  _.map.assertHasOnly( includeFile, _includeFromChunk.parameters );
  let o3 = _.mapOnly_( null, includeFile, _includeFromChunk.defaults );

  _.props.supplement( o, o3 );

  o.session = session;
  o.translator = chunkFrame.fileFrame.translator;
  o.syncExternal = chunkFrame.syncExternal;
  o.userChunkFrame = chunkFrame;

  let included = self._includeAct( o );

  _.assert( _.consequenceIs( o.syncExternal ) );
  _.assert( o2 === undefined || _.object.isBasic( o2 ) );
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  _.assert( _.object.isBasic( o.translator ) );
  _.assert( _.object.isBasic( session ) );
  _.assert( _.construction.isInstanceOf( included, IncludeFrameBlueprint ) );

  _.assert( included.files.length === included.fileFrames.length );

  if( self.verbosity > 4 )
  {
    logger.log( 'includeFromChunk.includeFrame :', chunkFrame.fileFrame.includeFrame.includeOptions.path );
    logger.log( 'includeFromChunk.fileFrame :', chunkFrame.fileFrame.file.relative );
  }

  chunkFrame.usedIncludeFrames.push( included );
  chunkFrame.fileFrame.usedIncludeFrames.push( included );
  chunkFrame.fileFrame.includeFrame.usedIncludeFrames.push( included );

  return '';
}

_includeFromChunk.defaults =
{
}

// _includeFromChunk.defaults.__proto__ = _includeAct.defaults;
Object.setPrototypeOf( _includeFromChunk.defaults, _includeAct.defaults );

_includeFromChunk.parameters =
{
}

// _includeFromChunk.parameters.__proto__ = _includeAct.defaults;
Object.setPrototypeOf( _includeFromChunk.parameters, _includeAct.defaults );

//

function include( o )
{
  let self = this;

  if( _.strIs( o ) )
  o = { path : o };

  if( self.verbosity > 1 )
  logger.log( 'include', o.path );

  _.routine.options_( include, o );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( self.session === null, 'attempt to relaunch executor during execution' );

  if( !o.translator )
  {
    o.translator = self.translator.clone();
    let realRootPath = _.strIs( o.path ) ? _.path.dir( o.path ) : _.path.common.apply( _.path, o.path );
    o.translator.realRootPath = realRootPath;
  }

  if( o.rootPath )
  {
    o.translator.realRootPath = o.rootPath;
  }

  if( o.virtualCurrentDirPath )
  {
    o.translator.virtualCurrentDirPath = o.virtualCurrentDirPath;
  }

  if( !o.session )
  o.session = self.sessionMake( _.mapOnly_( null, o, self.sessionMake.defaults ) );
  self.session = o.session;

  /* */

  let includeFrame = self._includeAct( _.mapOnly_( null, o, self._includeAct.defaults ) );

  /* */

  includeFrame.consequence.finally( function _includeAfter( err, arg )
  {
    if( err )
    {
      err = _.err( 'Error including', o.path, '\n', err );
      throw _.errLogOnce( err );
    }

    _.assert( self.session === null )
    _.assert( self.includeFrames.length === 0 );

    return arg;
  });

  return includeFrame;
}

include.defaults =
{
  rootPath : null,
  virtualCurrentDirPath : null,
}

_.props.extend( include.defaults, sessionMake.defaults );
_.props.extend( include.defaults, _includeAct.defaults );

// --
// file
// --

function filesExecute( o )
{
  let self = this;
  if( !o.consequence )
  o.consequence = new _.Consequence().take( null );
  let con = o.consequence;
  let session = o.includeFrame.session;
  let files = o.includeFrame.files;

  _.routine.options_( filesExecute, o );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.construction.isInstanceOf( o.includeFrame, IncludeFrameBlueprint ) );
  _.assert( _.object.isBasic( o.includeFrame ) );
  _.assert( _.arrayIs( o.includeFrame.files ) );
  _.assert( _.object.isBasic( session ) );

  /* prepare */

  for( let i = 0 ; i < files.length ; i += 1 )
  {
    let file = files[ i ];
    self.fileFrameFor
    ({
      file,
      includeFrame : o.includeFrame,
    });
  }

  /* filter out */

  self.filesFilter( o.includeFrame );

  _.assert( o.includeFrame.files.length === o.includeFrame.fileFrames.length );

  if( !session.allowIncludingChildren )
  session.allowIncluding = 0;

  /* execute */

  for( let i = 0 ; i < files.length ; i += 1 )
  {
    let file = files[ i ];
    con.ifNoErrorThen( _.routineSeal( self, self.fileExecute, [ { file, includeFrame : o.includeFrame } ] ) );
  }

  return con;
}

filesExecute.defaults =
{
  includeFrame : null,
  consequence : null,
}

//

function fileExecute( o )
{
  let self = this;
  let file = o.file;
  let includeFrame = o.includeFrame;
  let session = includeFrame.session;

  let fileFrame = self.fileFrameFor
  ({
    file,
    includeFrame,
  });

  _.assert( fileFrame.includeFrames.indexOf( includeFrame ) !== -1, 'Expects same includeFrame' );
  _.routine.options_( fileExecute, o );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.object.isBasic( session ) );
  _.assert( _.construction.isInstanceOf( fileFrame, FileFrameBlueprint ) );

  // if( !file.stat )
  // debugger;

  if( file.stat.size > o.maxSize )
  {
    logger.warn( 'WARNING :', 'execution of file ( ', file.stat.size, '>', o.maxSize, ' ) canceled because it is too big :', file.absolute );
    return;
  }

  if( fileFrame.executing )
  {
    throw _.err( 'File', fileFrame.file.absolute, 'already executing, recursion dependence!' );
  }

  if( fileFrame.executed )
  {
    if( self.verbosity > 1 )
    logger.log( 'already executed :', fileFrame.file.relative );
    self.includesUsedInherit( includeFrame, fileFrame );
    return fileFrame.consequence;
  }

  /* fileFrame.includeFrame should point on include frame in which fileFrame was executed */

  fileFrame.includeFrame = includeFrame;

  _.assert( !fileFrame.executed );
  _.assert( !fileFrame.executing );
  _.assert( !fileFrame.consequence );
  _.assert( !fileFrame.result );

  /* verbosity */

  if( self.verbosity )
  logger.log( 'fileExecute', o.file.absolute );

  if( self.warnBigFiles )
  if( file.stat.size > self.warnBigFiles )
  logger.warn( 'WARNING :', 'execution of big (', file.stat.size, '>', self.warnBigFiles, ') files is slow :', file.absolute );

  /* */

  fileFrame.executed = 0;
  fileFrame.executing = 1;

  // debugger;
  self._fileExecute( fileFrame );
  // debugger;

  /* write */

  fileFrame.consequence.ifNoErrorThen( function( arg )
  {

    if( self.verbosity > 1 )
    logger.log( 'fileExecute.end1', file.absolute );

    _.assert( _.strIs( arg ) || fileFrame.error, 'problem executing file', fileFrame.file.absolute );
    _.assert( _.strIs( fileFrame.result ), 'problem executing file', fileFrame.file.absolute );

    fileFrame.usedFiles = self.filesUsedGet( fileFrame.usedIncludeFrames );

    return arg;
  });

  /* */

  fileFrame.consequence.finally( function _fileExecuteAfter( err, arg )
  {

    if( err )
    fileFrame.error = err;

    if( fileFrame.error )
    {

      throw _.err( fileFrame.error );

    }
    else
    {

      if( fileFrame.chunks.length !== 0 )
      if( fileFrame.chunks.length !== 1 || fileFrame.chunks[ 0 ].code !== undefined )
      {

        // if( fileFrame.usedFiles.length )
        // self.archive.dependencyAdd( file, fileFrame.usedFiles );
        //
        // self.archive.contentUpdate( file, fileFrame.result );
        // debugger;

        self.fileProvider.fileWrite
        ({
          filePath : file.absolute,
          data : fileFrame.result,
          sync : 1,
          purging : 1,
        });

        // file.reset();
        // self.archive.statUpdate( file, file.stat );

        if( self.verbosity )
        logger.log( '+ executed :', file.absolute );

      }

    }

    fileFrame.executed = 1;
    fileFrame.executing = 0;

    // if( self.verbosity > 1 )
    // logger.log( 'fileExecute.end2', file.absolute );

    return fileFrame.result;
  });

  /* */

  return fileFrame.consequence;
}

fileExecute.defaults =
{
  includeFrame : null,
  file : null,
}

//

function _fileExecute( o )
{
  let self = this;
  let session = o.session;
  let includeFrame = o.includeFrame;

  if( _.strIs( o ) )
  o = { code : o }

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( o.file instanceof _.files.FileRecord );
  _.assert( _.construction.isInstanceOf( o, FileFrameBlueprint ) );
  _.assert( !o.consequence );

  /* result */

  o.result = '';
  if( !o.consequence )
  o.consequence = new _.Consequence().take( null );

  /* let */

  let errorPrefix = '';
  if( o.file )
  errorPrefix = _.entity.exportStringDiagnosticShallow/*exportStringSimple*/( o.file.absolute + ' :\n' );

  /* read file */

  try
  {

    if( o.code === null || o.code === undefined )
    o.code = self.fileProvider.fileReadSync( o.file.absolute );

  }
  catch( err )
  {
    o.error = _.err( 'Cant read file :', o.file.absolute, '\n', err );
    return o;
  }

  /* chunks */

  let chunks = self._chunksSplit( o.code, _.mapOnly_( null, o, _chunksSplit.defaults ) );
  if( chunks.error )
  o.error = _.err( errorPrefix, chunks.error, '\n' );
  o.chunks = chunks.chunks;

  if( !chunks.error )
  for( let c = 0 ; c < o.chunks.length ; c++ ) (function _executeChunk()
  {

    let chunk = o.chunks[ c ];
    _.assert( _.numberIs( chunk.index ) );
    Object.preventExtensions( chunk );

    let optionsChunkExecute = Object.create( null );
    optionsChunkExecute.fileFrame = o;
    optionsChunkExecute.chunk = chunk;
    o.consequence.ifNoErrorThen( _.routineSeal( self, self.chunkExecute, [ optionsChunkExecute ] ) );
    o.consequence.ifNoErrorThen( function( arg )
    {
      _.assert( _.strIs( arg ) );
      o.result += arg;
      return arg;
    });

  })();

  /* return */

  return o;
}

//

function filesFilter( includeFrame )
{
  let self = this;
  let io = includeFrame.includeOptions;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.construction.isInstanceOf( includeFrame, IncludeFrameBlueprint ) );

  if( !io.ifAny && !io.ifAll && !io.ifNone )
  return;

  if( _.strIs( io.ifAny ) )
  io.ifAny = [ io.ifAny ];
  if( _.strIs( io.ifAll ) )
  io.ifAll = [ io.ifAll ];
  if( _.strIs( io.ifNone ) )
  io.ifNone = [ io.ifNone ];

  let fileFrames = includeFrame.fileFrames;
  let files = includeFrame.files;
  for( let f = fileFrames.length-1 ; f >= 0 ; f-- )
  {
    let fileFrame = fileFrames[ f ];

    if( io.ifAny )
    if( !_.longHasAny( fileFrame.categories, io.ifAny ) )
    {
      fileFrames.splice( f, 1 );
      files.splice( f, 1 );
      continue;
    }

    if( io.ifAll )
    if( !_.longHasAll( fileFrame.categories, io.ifAll ) )
    {
      fileFrames.splice( f, 1 );
      files.splice( f, 1 );
      continue;
    }

    if( io.ifNone )
    if( !_.longHasNone( fileFrame.categories, io.ifNone ) )
    {
      fileFrames.splice( f, 1 );
      files.splice( f, 1 );
      continue;
    }

  }

}

//

function fileFrameFor( fileFrame )
{
  let self = this;
  let includeFrame = fileFrame.includeFrame;
  let session = includeFrame.session;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.object.isBasic( session ) );
  _.assert( _.object.isBasic( includeFrame ) );

  if( self.verbosity > 4 )
  logger.log( 'fileFrameFor', fileFrame.file.absolute );

  let equ = ( e ) => e.file.absolute;
  let fileFrameFound = _.longLeft( session.fileFrames, fileFrame, equ ).element;
  if( fileFrameFound )
  {
    _.arrayAppendOnce( fileFrameFound.includeFrames, includeFrame );
    _.arrayAppendOnce( includeFrame.fileFrames, fileFrameFound );
    return fileFrameFound;
  }

  /* */

  fileFrame = new FileFrameBlueprint.make( fileFrame );

  if( !session.allowIncluding )
  throw _.err( 'can only reuse included files, but was attempt to include a new one', fileFrame.file.absolute );

  includeFrame.fileFrames.push( fileFrame );
  session.fileFrames.push( fileFrame );

  fileFrame.includeFrames.push( includeFrame );
  fileFrame.translator = includeFrame.translator.clone();
  fileFrame.translator.realCurrentDirPath = fileFrame.file.dir;

  if( fileFrame.context === null )
  fileFrame.context = includeFrame.context;

  if( fileFrame.externals === null )
  fileFrame.externals = _.props.extend( null, includeFrame.externals );

  fileFrame.categories = self.categoriesForFile( fileFrame );

  return fileFrame;
}

// --
// chunk
// --

function chunkFrameFor( o )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.mapIs( o ) );
  o = ChunkFrameBlueprint.make( o );
  return o;
}

//

function chunkExecute( o )
{
  let self = this;
  let includeFrame = o.fileFrame.includeFrame;

  // _.assert( arguments.length === 1, 'Expects single argument' );
  o = chunkFrameFor( o );

  if( self.verbosity > 2 )
  logger.log( 'chunkExecute', o.fileFrame.file.relative, o.chunk.index );

  /* */

  o.syncInternal = new _.Consequence({ capacity : 1 });
  o.syncExternal = new _.Consequence({ capacity : 1 }).take( null );

  let executed = self._chunkExecute( o );
  executed = _.Consequence.From( executed );

  executed.give( function( err, arg )
  {

    if( self.verbosity > 2 )
    logger.log( 'chunkExecute.end1', o.fileFrame.file.relative, o.chunk.index );

    if( err )
    return this.take( err, arg );

    if( _.numberIs( arg ) )
    arg = _.entity.exportString( arg );

    if( !_.strIs( arg ) )
    return this.error( _.err
    (
      'chunk should return string, but returned', _.entity.strType( arg ),
      '\ncode :\n', _.strLinesNumber( o.chunk.text || o.chunk.code )
    ));

    this.take( err, arg );
  });

  executed.andKeep( o.syncExternal );
  executed.finally( o.syncInternal );

  /* */

  o.syncInternal.ifNoErrorThen( function chunkExecuteAfter( result )
  {

    _.assert( result.length === 2 );
    result = result[ 1 ];

    if( self.verbosity > 2 )
    logger.log( 'chunkExecute.end2', o.fileFrame.file.relative, o.chunk.index );

    _.assert( _.strIs( result ), 'Expects string result from chunk' );
    _.assert( _.arrayIs( o.usedIncludeFrames ) );

    o.resultRaw = result;
    o.result = result;

    return self._chunkConcat( o );
  });

  /* */

  o.syncInternal.ifNoErrorThen( function( arg )
  {

    if( self.verbosity > 2 )
    logger.log( 'chunkExecute.end3', o.fileFrame.file.relative, o.chunk.index );

    _.assert( _.strIs( arg ) );
    _.assert( _.strIs( o.result ) );
    self._chunkTabulate( o );

    return o.result;
  });

  return o.syncInternal;
}

//

function _chunkExecute( o )
{
  let self = this;
  let session = o.fileFrame.includeFrame.session;

  _.assert( _.object.isBasic( session ) );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( o.chunk.text ) || _.strIs( o.chunk.code ) );
  _.assert( _.construction.isInstanceOf( o, ChunkFrameBlueprint ) );

  /* */

  if( _.strIs( o.chunk.text ) )
  {
    return o.chunk.text;
  }
  else if( _.strIs( o.chunk.code ) )
  {

    try
    {

      /* exposing */

      if( !o.externals && o.fileFrame.externals )
      o.externals = _.props.extend( null, o.fileFrame.externals );
      self._chunkExpose( o );

      /* */

      let execution = _.mapOnly_( null, o, ecmaExecute.defaults );
      execution.language = self.languageFromFilePath( o.fileFrame.file.absolute );
      execution.filePath = o.fileFrame.file.absolute + '{' + o.chunk.line + '-' + ( o.chunk.line + o.chunk.lines.length ) + '}';

      execution.verbosity = self.verbosity;
      execution.debug = self.debug;

      execution.context = o.fileFrame.context;
      execution.externals = o.externals;
      execution.defaultLanguage = 'ecma';

      execution.code = o.chunk.code;
      o.execution = execution;

      self.scriptExecute( execution );

      return execution.result;
    }
    catch( err )
    {

      throw _.err
      (
        'Error executing chunk :\n', _.entity.exportString( o.chunk ), '\n',
        '\nat file', o.fileFrame.file.absolute,
        '\n', err
      );

    }
  }

}

// _chunkExecute.defaults = chunkExecute.defaults;

//

function _chunkExpose( chunkFrame )
{
  let self = this;
  let externals = chunkFrame.externals;
  let fileFrame = chunkFrame.fileFrame;
  let file = fileFrame.file;
  let session = fileFrame.includeFrame.session;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.construction.isInstanceOf( chunkFrame, ChunkFrameBlueprint ) );

  /* exposing */

  if( session.exposingInclude )
  {

    _.assert( externals.includeFile === undefined );
    let bound = Object.create( null );
    externals.includeFile = _.routineJoin( self, self._includeFromChunk, [ bound ] );
    delete externals.includeFile.defaults;
    delete externals.includeFile.parameters;
    bound.chunkFrame = chunkFrame;
    bound.includeFile = externals.includeFile;

  }

  if( session.exposingEnvironment )
  {

    _.assert( externals.__filename === undefined );
    _.assert( externals.__dirname === undefined );
    _.assert( externals.__file === undefined );
    _.assert( externals.__fileFrame === undefined );
    _.assert( externals.__chunkFrame === undefined );

    externals.__filename = file.absolute;
    externals.__dirname = file.dir;
    externals.__file = file;
    externals.__chunkFrame = chunkFrame;
    externals.__fileFrame = fileFrame;
    externals.__templateExecutor = self;

  }

  if( session.exposingTools )
  {

    _.assert( externals._ === undefined || externals._ === wTools );
    _.assert( externals.wTools === undefined || externals.wTools === wTools );

    externals._ = _global_.wTools;
    externals.wTools = wTools;

  }

}

//

function _chunkTabulate( chunkFrame )
{
  let self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );

  if( chunkFrame.chunk.kind !== 'dynamic' )
  return;

  let result = '';
  let ret = '';

  if( _.strIs( chunkFrame.result ) )
  ret = chunkFrame.result;
  else
  ret = _.entity.exportString( chunkFrame.result );

  ret = ret.split( '\n' );

  if( ret[ ret.length-1 ].trim() === '' )
  ret.splice( ret.length-1, 1 );

  for( let r = 0, l = ret.length ; r < l ; r++ )
  {
    let prefix = r > 0 ? chunkFrame.chunk.tab : '';
    let postfix = r < l-1 ? '\n' : '';
    result += prefix + ret[ r ] + postfix;
  }

  chunkFrame.result = result;
}

//

function _chunksSplit( src, o )
{

  return _.strSplitChunks( src, o );

}

_chunksSplit.defaults = _.strSplitChunks.defaults;

//

function _chunkConcat( chunkFrame )
{
  let self = this;
  let result = [];
  let err = null;
  let con = new _.Consequence();
  let chunkFormatterOptions = Object.create( null );

  _.assert( _.strIs( chunkFrame.result ) );
  _.assert( _.arrayIs( chunkFrame.usedIncludeFrames ) );
  _.assert( chunkFrame.usedFileFrames.length === 0 );
  _.assert( arguments.length === 1, 'Expects single argument' );

  /* */

  for( let i = 0 ; i < chunkFrame.usedIncludeFrames.length ; i += 1 )
  {
    let usedIncludeFrame = chunkFrame.usedIncludeFrames[ i ];
    _.assert( usedIncludeFrame.fileFrames.length === usedIncludeFrame.files.length );
    _.arrayAppendArray( chunkFrame.usedFileFrames, usedIncludeFrame.fileFrames );
  }

  /* */

  let _index = 0;
  for( let i = 0 ; i < chunkFrame.usedIncludeFrames.length ; i += 1 )
  {
    let usedIncludeFrame = chunkFrame.usedIncludeFrames[ i ];

    _.assert( usedIncludeFrame.fileFrames.length === usedIncludeFrame.files.length );

    for( let f = 0 ; f < usedIncludeFrame.fileFrames.length ; f += 1 ) ( function()
    {
      let fileFrame = usedIncludeFrame.fileFrames[ f ];

      con.give( 1 );
      _index += 1;
      let index = _index;

      if( err && !fileFrame.consequence )
      return;

      _.assert( _.object.isBasic( fileFrame ), 'unexpected' );

      if( fileFrame.error )
      {
        if( err )
        _.errAttend( fileFrame.error );
        else
        err = _.err( fileFrame.error );
      }
      else
      {
        _.assert( _.strIs( fileFrame.result ), 'Expects string, but got', _.entity.strType( fileFrame.result ) );
        let formatted = self.linkFormat
        ({
          userChunkFrame : chunkFrame,
          usedFileFrame : fileFrame,
          usedIncludeFrame,
        });

        formatted = _.Consequence.From( formatted );
        formatted.ifNoErrorThen( function( formatted )
        {
          _.assert( _.strIs( formatted ) );
          result[ index ] = formatted;
          return formatted;
        });
        formatted.finally( con );
      }

    })();

  }

  if( err )
  throw _.errLogOnce( err );

  /* */

  con
  .take( null )
  .ifNoErrorThen( function( arg )
  {
    if( result.length )
    chunkFrame.result = result.join( '' ) + chunkFrame.result;
    return chunkFrame.result;
  })
  .ifNoErrorThen( function( arg )
  {
    if( self.verbosity > 1 )
    logger.log( '_chunkFormat', chunkFrame.fileFrame.file.absolute, chunkFrame.chunk.index );
    return self._chunkFormat( chunkFrame, arg );
  })
  .ifNoErrorThen( function( arg )
  {
    _.assert( _.strIs( arg ) );
    return arg;
  });

  /* */

  return con;
}

//

function _chunkFormat( chunkFrame, text )
{
  let self = this;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  return self.formattersApply
  ({
    formatters : self.chunkFormatters,
    frame : chunkFrame,
    categories : chunkFrame.fileFrame.categories,
  });

}

// --
// etc
// --

function categoriesForFile( fileFrame )
{
  let self = this;
  let result = [];
  let file = fileFrame.file;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.construction.isInstanceOf( fileFrame, FileFrameBlueprint ) );
  _.assert( file instanceof _.files.FileRecord );

  /* arbitrary categories */

  for( let c in self.arbitraryCategorizers )
  {
    let categorizer = self.arbitraryCategorizers[ c ];
    let category;
    _.assert( _.routineIs( categorizer ) );
    try
    {
      category = categorizer.call( self, file );
    }
    catch( err )
    {
      let msg = 'Categorizer ' + c + ' failed\n';
      throw _.err( msg, err )
    }
    if( category )
    {
      _.assert( _.primitiveIs( category ) );
      if( !_.strIs( category ) )
      category = c;
      result.push( category );
    }
  }

  /* file categories */

  for( let c in self.fileCategorizers )
  {
    let categorizer = self.fileCategorizers[ c ];
    _.assert( _.routineIs( categorizer ) );
    let category = categorizer.call( self, file );
    if( category )
    {
      _.assert( _.primitiveIs( category ) );
      if( !_.strIs( category ) )
      category = c;
      result.push( category );
    }
  }

  return result;
}

//

function _categoriesForLink( o )
{
  let self = this;
  let result = [];

  _.assert( arguments.length === 1, 'Expects single argument' );

  /* file categories */

  for( let c = 0 ; c < o.user.fileFrame.categories.length ; c++ )
  {
    _.arrayAppendOnce( result, 'in.' + o.user.fileFrame.categories[ c ] );
  }

  for( let c = 0 ; c < o.used.fileFrame.categories.length ; c++ )
  {
    _.arrayAppendOnce( result, o.used.fileFrame.categories[ c ] );
  }

  /* link categories */

  // if( _.props.keys( self.linkCategorizers ).length )
  // debugger;
  for( let c in self.linkCategorizers )
  {
    let categorizer = self.linkCategorizers[ c ];
    _.assert( _.routineIs( categorizer ) );
    let category = categorizer.call( self, o );
    if( category )
    {
      _.assert( _.primitiveIs( category ) );
      if( !_.strIs( category ) )
      category = c;
      _.arrayAppendOnce( result, category );
    }
  }

  if( self.linkAttributeDefault !== '' )
  if( result.length === 0 )
  result.push( self.linkAttributeDefault );

  return result;
}

//

function _categoriesCheck( categories, filter )
{
  let self = this;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( filter.ifAny )
  if( !_.longHasAny( categories, filter.ifAny ) )
  return false;

  if( filter.ifAll )
  if( !_.longHasAll( categories, filter.ifAll ) )
  return false;

  if( filter.ifNone )
  if( !_.longHasNone( categories, filter.ifNone ) )
  return false;

  return true;
}

//

function formattersApply( o )
{
  let self = this;
  let con = new _.Consequence().take( o.frame.result );

  _.assert( arguments.length === 1, 'Expects single argument' );

  // debugger; // aaa

  if( !o.categories.length )
  return con;

  o.executor = self;

  for( let f = 0 ; f < o.formatters.length ; f++ ) ( function()
  {

    let ff = f;
    con.ifNoErrorThen( function( arg )
    {
      o.formatter = o.formatters[ ff ];
      return self.formatterTry( o );
    });

  })();

  con.ifNoErrorThen( function( arg )
  {
    return o.frame.result;
  });

  return con;
}

//

function formatterTry( o )
{
  let self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.object.isBasic( o.formatter ) );

  if( !self._categoriesCheck( o.categories, o.formatter ) )
  return false;

  return self.formatterApply( o );
}

//

function formatterApply( o )
{
  let self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.object.isBasic( o.formatter ) );

  if( !o.usedFileFrames )
  {

    let usedFileFrames = o.frame.usedFileFrames;
    if( o.formatter.onlyForUsedFiles )
    {

      usedFileFrames = [];
      for( let u = 0 ; u < o.frame.usedFileFrames.length ; u++ )
      {
        let usedFileFrame = o.frame.usedFileFrames[ u ];
        if( self._categoriesCheck( usedFileFrame.categories, o.formatter.onlyForUsedFiles ) )
        usedFileFrames.push( usedFileFrame );
      }

      if( !usedFileFrames.length )
      return false;

    }
    o.usedFileFrames = usedFileFrames;

  }

  _.assert( _.routineIs( o.formatter.format ), 'formatter should have routine (-format-)' );
  let r = o.formatter.format.call( self, o );

  _.assert( r === undefined || _.consequenceIs( r ) );

  if( _.consequenceIs( r ) )
  r.ifNoErrorThen( function( arg )
  {
    o.usedFileFrames = null;
    return true;
  })
  else
  {
    o.usedFileFrames = null;
  }

  return r || null;
}

//

function linkFor( userChunkFrame, usedFileFrame )
{
  let self = this;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.construction.isInstanceOf( userChunkFrame, ChunkFrameBlueprint ) );
  _.assert( _.construction.isInstanceOf( usedFileFrame, FileFrameBlueprint ) || usedFileFrame instanceof _.files.FileRecord );

  let usedFile;
  if( usedFileFrame instanceof _.files.FileRecord )
  {
    usedFile = usedFileFrame;
    usedFileFrame = null;
  }
  else
  {
    usedFile = usedFileFrame.file;
  }

  let link = Object.create( null );
  link.result = usedFileFrame ? usedFileFrame.result : null;

  link.used = Object.create( null );
  link.used.fileFrame = usedFileFrame;
  link.used.includeFrame = usedFileFrame ? usedFileFrame.includeFrame : null;
  link.used.file = usedFile;
  link.used.ext = usedFile.ext.toLowerCase();

  link.user = Object.create( null );
  link.user.chunkFrame = userChunkFrame;
  link.user.fileFrame = userChunkFrame.fileFrame;
  link.user.includeFrame = userChunkFrame.fileFrame.includeFrame;
  link.user.file = userChunkFrame.fileFrame.file;
  link.user.ext = link.user.file.ext.toLowerCase();

  link.categories = self._categoriesForLink( link );

  Object.preventExtensions( link );

  return link;
}

//

function linkFormat( o )
{
  let self = this;

  // debugger; // aaa

  if( !o.link )
  o.link = self.linkFor( o.userChunkFrame, o.usedFileFrame );

  if( !o.usedIncludeFrame )
  o.usedIncludeFrame = o.link.used.includeFrame;

  _.assert( _.object.isBasic( o.usedIncludeFrame ) );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.construction.isInstanceOf( o.usedIncludeFrame, IncludeFrameBlueprint ) );

  if( self.verbosity > 2 )
  logger.log
  (
    'linkFormat',
    o.link.user.file.relative,
    '#',
    o.link.user.chunkFrame.chunk.index,
    ':',
    o.link.used.file.relative
  );

  let formatted = self.formattersApply
  ({
    formatters : self.linkFormatters,
    frame : o.link,
    categories : o.link.categories
  });

  let got = formatted;

  got.give( function( err, arg )
  {
    _.assert( _.strIs( arg ), 'Expects string' );
    o.link.result = arg;
    this.take( err, arg );
  });

  if( o.usedIncludeFrame.includeOptions.onIncludeFromat )
  {
    got.ifNoErrorThen( function( arg )
    {
      o.link.result = arg;
      let r = o.usedIncludeFrame.includeOptions.onIncludeFromat.call( self, o.link );
      if( _.strIs( r ) )
      o.link.result = r;
      _.assert( r === undefined || _.strIs( r ), 'Expects string or nothing from (-onIncludeFromat-)' );
      _.assert( _.strIs( o.link.result ) );
      return o.link.result;
    });
  }

  return got;
}

linkFormat.defaults =
{
  link : null,
  userChunkFrame : null,
  usedFileFrame : null,
  usedIncludeFrame : null,
}

//

function linkFormatExplicit( o )
{
  let self = this;

  if( !o.filePath )
  o.filePath = _.path.join( o.formatter.frame.fileFrame.file.dir, o.formatter.frame.fileFrame.file.name + '.manual.js' );
  let joinedFile = o.formatter.frame.fileFrame.file.clone( o.filePath );

  let fileFrame = self.fileFrameFor
  ({
    file : joinedFile,
    includeFrame : o.formatter.frame.fileFrame.includeFrame,
  });

  let link = self.linkFor( o.formatter.frame, fileFrame );
  if( o.removeCategories )
  _.arrayRemoveArrayOnce( link.categories, o.removeCategories );
  if( o.addCategories )
  _.arrayAppendArrayOnce( link.categories, o.addCategories );

  let formatted = self.linkFormat
  ({
    link,
  });

  formatted.ifNoErrorThen( function _formatReplaceByFileAfter( arg )
  {
    _.assert( _.strIs( arg ) );
    o.formatter.frame.result += arg;
    return arg;
  });

  return formatted;
}

linkFormatExplicit.default =
{
  filePath : null,
  formatter : null,
  removeCategories : null,
  addCategories : null,
}

//

function _fileCategorizersSet( categorizers )
{
  let self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.object.isBasic( categorizers ), 'Expects object (-categorizers-)' );

  self[ fileCategorizersSymbol ] = categorizers;

  self._fileCategorizersChanged();

  return categorizers;
}

//

function _fileCategorizersChanged()
{
  let self = this;
  let categorizers = self[ fileCategorizersSymbol ];

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( _.object.isBasic( categorizers ), 'Expects map {-categorizers-}' );

  for( let c in categorizers )
  {
    let categorizer = categorizers[ c ];

    if( _.strIs( categorizer ) )
    categorizer = [ categorizer ];

    if( _.arrayIs( categorizer ) ) ( function()
    {
      let exts = categorizer;
      categorizer = function categorizer( file )
      {
        return _.longHasAny( exts, file.exts );
      }
    })();

    categorizers[ c ] = categorizer;
  }

}

// --
// used
// --

function filesUsedGet( includes, result )
{
  let self = this;
  result = result || [];

  _.assert( _.arrayIs( includes ) );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  for( let i = 0 ; i < includes.length ; i++ )
  {
    let includeFrame = includes[ i ];
    _.assert( _.construction.isInstanceOf( includeFrame, IncludeFrameBlueprint ) );
    _.arrayAppendArray( result, includeFrame.files );
    self.filesUsedGet( includeFrame.usedIncludeFrames, result );
  }

  return result;
}

//

function includesUsedInherit( includeFrame, fileFrame )
{
  let self = this;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  _.arrayAppendArray( includeFrame.usedIncludeFrames, fileFrame.usedIncludeFrames );

}

// --
// construction
// --

let IncludeFrameBlueprint = _.Blueprint
({

  resolveOptions : null,
  files : null,

  includeOptions : null,
  consequence : null,
  translator : null,

  userChunkFrame : null,
  userIncludeFrame : null,
  fileFrames : null,
  usedIncludeFrames : null,

  // fileFrames : [],
  // usedIncludeFrames : [],

  externals : null,
  context : null,
  session : null,

  typed : _.trait.typed( true )
})

let IncludeFrame = IncludeFrameBlueprint.make();

includeFrameBegin.defaults = IncludeFrame;
includeFrameEnd.defaults = IncludeFrame;

//

let FileFrameBlueprint = _.Blueprint
({
  includeFrame : null,
  includeFrames : _.define.shallow([]),

  file : null,
  translator : null,

  usedIncludeFrames : _.define.shallow([]),
  usedFiles : null,

  chunks : null,

  context : null,
  externals : null,

  category : null,

  executing : 0,
  executed : 0,
  result : null,
  error : null,
  consequence : null,

  code : null,
  categories : _.define.shallow([]),

  typed : _.trait.typed( true )

})

let FileFrame = FileFrameBlueprint.make();

fileFrameFor.defaults = FileFrame;

//

let ChunkFrameBlueprint = _.Blueprint
({
  chunk : null,
  fileFrame : null,
  externals : null,
  usedIncludeFrames : _.define.shallow([]),
  usedFileFrames : _.define.shallow([]),
  syncExternal : null,
  syncInternal : null,
  execution : null,
  result : null,
  resultRaw : null,

  typed : _.trait.typed( true )
})

let ChunkFrame = ChunkFrameBlueprint.make();

chunkFrameFor.defaults = ChunkFrame;
chunkExecute.defaults = ChunkFrame;

// --
// relations
// --

_.assert( !!_.PathTranslator );

let fileCategorizersSymbol = Symbol.for( 'fileCategorizers' );

let Composes =
{

  translator : _.define.own( new _.PathTranslator({ realCurrentDirPath : _.path.refine( __dirname ) }) ),

  warnBigFiles : 1 << 19,
  debug : 0,
  verbosity : 1,

  linkAttributeDefault : '',

}

let Aggregates =
{

  arbitraryCategorizers : _.define.own( {} ),
  linkCategorizers : _.define.own( {} ),
  fileCategorizers : _.define.own( {} ),

  linkFormatters : _.define.own( [] ),
  chunkFormatters : _.define.own( [] ),

}

let Associates =
{
  fileProvider : null,
  archive : null,
  context : _.define.own( {} ),
}

let Restricts =
{
  session : null,
  includeFrames : _.define.own( [] ),
}

let Statics =
{
}

let Forbids =
{
  conChunkBegin : 'conChunkBegin',
  conChunkEnd : 'conChunkEnd',
  prefix : 'prefix',
  postfix : 'postfix',
  currentDirPath : 'currentDirPath',
  virtualRootPath : 'virtualRootPath',
  realRootPath : 'realRootPath',
  realRelativePath : 'realRelativePath',
}

let Accessors =
{
  fileCategorizers : 'fileCategorizers',
}

// --
// declare
// --

let Proto =
{

  init,

  languageFromFilePath,
  scriptExecute,

  ecmaExecute,

  coffeeCompile,
  coffeeExecute,

  /* include */

  sessionMake,

  includeFrameBegin,
  includeFrameEnd,

  _includeAct,
  _includeFromChunk,
  include,

  /* file */

  filesExecute,

  fileExecute,
  _fileExecute,

  filesFilter,
  fileFrameFor,

  /* chunk */

  chunkFrameFor,
  chunkExecute,
  _chunkExecute,
  _chunkExpose,
  _chunkTabulate,
  _chunksSplit,
  _chunkConcat,
  _chunkFormat,

  /* etc */

  categoriesForFile,
  _categoriesForLink,
  _categoriesCheck,

  formattersApply,
  formatterTry,
  formatterApply,

  linkFor,
  linkFormat,
  linkFormatExplicit,

  _fileCategorizersSet,
  _fileCategorizersChanged,

  /* used */

  filesUsedGet,
  includesUsedInherit,

  /* relations */

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,
  Accessors,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.Copyable.mixin( Self );

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;
_global_[ Self.name ] = _[ Self.shortName ] = Self;

})();
