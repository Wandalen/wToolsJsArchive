( function _Glob_s_() {

'use strict';

/**
 * @file Glob.s.
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

  let _ = _global_.wTools;

}

//

let _global = _global_;
let _ = _global_.wTools;
let Self = _.path = _.path || Object.create( null );

// --
// glob
// --

/*
(\*\*)| -- **
([?*])| -- ?*
(\[[!^]?.*\])| -- [!^]
([+!?*@]\(.*\))| -- @+!?*()
(\{.*\}) -- {}
(\(.*\)) -- ()
*/

// let transformation1 =
// [
//   [ /\[(.+?)\]/g, handleSquareBrackets ], /* square brackets */
//   [ /\{(.*)\}/g, handleCurlyBrackets ], /* curly brackets */
// ]
//
// let transformation2 =
// [
//   [ /\.\./g, '\\.\\.' ], /* double dot */
//   [ /\./g, '\\.' ], /* dot */
//   [ /([!?*@+]*)\((.*?(?:\|(.*?))*)\)/g, hanleParentheses ], /* parentheses */
//   [ /\/\*\*/g, '(?:\/.*)?', ], /* slash + double asterix */
//   [ /\*\*/g, '.*', ], /* double asterix */
//   [ /(\*)/g, '[^\/]*' ], /* single asterix */
//   [ /(\?)/g, '.', ], /* question mark */
// ]


// let _pathIsGlobRegexp = /(\*\*)|([?*])|(\[[!^]?.*\])|([+!?*@]?)|\{.*\}|(\(.*\))/;

let _pathIsGlobRegexpStr = '';
_pathIsGlobRegexpStr += '(?:[?*]+)'; /* asterix, question mark */
_pathIsGlobRegexpStr += '|(?:([!?*@+]*)\\((.*?(?:\\|(.*?))*)\\))'; /* parentheses */
_pathIsGlobRegexpStr += '|(?:\\[(.+?)\\])'; /* square brackets */
_pathIsGlobRegexpStr += '|(?:\\{(.*)\\})'; /* curly brackets */
_pathIsGlobRegexpStr += '|(?:\0)'; /* zero */

let _pathIsGlobRegexp = new RegExp( _pathIsGlobRegexpStr );
function isGlob( src )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.strIs( src ) );

  /* let regexp = /(\*\*)|([!?*])|(\[.*\])|(\(.*\))|\{.*\}+(?![^[]*\])/g; */

  return _pathIsGlobRegexp.test( src );
}

//

function fromGlob( glob )
{
  let result;

  // glob = this.globNormalize( glob );

  let i = glob.search( _pathIsGlobRegexp );
  while( i > 0 && glob[ i ] !== this._upStr )
  i -= 1;

  if( i === -1 )
  result = glob;
  else
  result = glob.substr( 0, i+1 );

  /* replace urlNormalize by detrail */
  result = this.normalize( result );

  _.assert( _.strIs( glob ) );
  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( !this.isGlob( result ) );

  return result;
}

//

function globNormalize( glob )
{
  let result = _.strReplaceAll( glob, { '*()' : '', '\0' : '' } );
  return result;
}

//

function globSplit( glob )
{
  _.assert( _.strIs( glob ) );

  let splits = this.split( glob );

  for( let s = splits.length-1 ; s >= 0 ; s-- )
  {
    let split = splits[ s ];
    if( split === '**' || !_.strHas( split, '**' ) )
    continue;

    // if( _.strEnds( split, '**' ) )
    // {
    //   split = _.strRemoveEnd( split, '**' ) + '*';
    //   _.arrayCutin( splits, [ s,s+1 ], [ split, '**' ] );
    // }
    //
    // if( _.strBegins( split, '**' ) )
    // {
    //   split = '*' + _.strRemoveBegin( split, '**' );
    //   _.arrayCutin( splits, [ s,s+1 ], [ '**', split ] );
    // }

    split = _.strSplitFast({ src : split, delimeter : '**', preservingEmpty : 0 });
    for( let i = 0 ; i < split.length ; i++ )
    {
      if( split[ i ] === '**' )
      continue;
      if( i > 0 )
      split[ i ] = '*' + split[ i ];
      if( i < split.length-1 )
      split[ i ] = split[ i ] + '*';
    }
    // debugger;
    _.arrayCutin( splits, [ s,s+1 ], split );
    // debugger;

  }

  return splits;
}

//

/**
 * Turn a *-wildcard style _glob into a regular expression
 * @example
 * let _glob = '* /www/*.js';
 * wTools.globRegexpsForTerminalSimple( _glob );
 * // /^.\/[^\/]*\/www\/[^\/]*\.js$/m
 * @param {String} _glob *-wildcard style _glob
 * @returns {RegExp} RegExp that represent passed _glob
 * @throw {Error} If missed argument, or got more than one argumet
 * @throw {Error} If _glob is not string
 * @function globRegexpsForTerminalSimple
 * @memberof wTools
 */

function globRegexpsForTerminalSimple( _glob )
{

  function strForGlob( _glob )
  {

    let result = '';
    _.assert( arguments.length === 1, 'expects single argument' );
    _.assert( _.strIs( _glob ) );

    let w = 0;
    _glob.replace( /(\*\*[\/\\]?)|\?|\*/g, function( matched,a,offset,str )
    {

      result += _.regexpEscape( _glob.substr( w,offset-w ) );
      w = offset + matched.length;

      if( matched === '?' )
      result += '.';
      else if( matched === '*' )
      result += '[^\\\/]*';
      else if( matched.substr( 0,2 ) === '**' )
      result += '.*';
      else _.assert( 0,'unexpected' );

    });

    result += _.regexpEscape( _glob.substr( w,_glob.length-w ) );
    if( result[ 0 ] !== '^' )
    {
      result = _.strPrependOnce( result,'./' );
      result = _.strPrependOnce( result,'^' );
    }
    result = _.strAppendOnce( result,'$' );

    return result;
  }

  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.strIs( _glob ) || _.strsAre( _glob ) );

  if( _.strIs( _glob ) )
  _glob = [ _glob ];

  let result = _.entityMap( _glob,( _glob ) => strForGlob( _glob ) );
  result = RegExp( '(' + result.join( ')|(' ) + ')','m' );

  return result;
}

//

function globRegexpsForTerminalOld( src )
{

  _.assert( _.strIs( src ) || _.strsAre( src ) );
  _.assert( arguments.length === 1, 'expects single argument' );

/*
  (\*\*\\\/|\*\*)|
  (\*)|
  (\?)|
  (\[.*\])
*/

  let map =
  {
    0 : '.*', /* doubleAsterix */
    1 : '[^\/]*', /* singleAsterix */
    2 : '.', /* questionMark */
    3 : handleSquareBrackets, /* handleSquareBrackets */
    '{' : '(',
    '}' : ')',
  }

  /* */

  let result = '';

  if( _.strIs( src ) )
  {
    result = adjustGlobStr( src );
  }
  else
  {
    if( src.length > 1 )
    for( let i = 0; i < src.length; i++ )
    {
      let r = adjustGlobStr( src[ i ] );
      result += `(${r})`;
      if( i + 1 < src.length )
      result += '|'
    }
    else
    {
      result = adjustGlobStr( src[ 0 ] );
    }
  }

  result = _.strPrependOnce( result,'\\/' );
  result = _.strPrependOnce( result,'\\.' );

  result = _.strPrependOnce( result,'^' );
  result = _.strAppendOnce( result,'$' );

  return RegExp( result );

  /* */

  function handleSquareBrackets( src )
  {
    debugger;
    src = _.strInsideOf( src, '[', ']' );
    // src = _.strIsolateInsideOrNone( src, '[', ']' );
    /* escape inner [] */
    src = src.replace( /[\[\]]/g, ( m ) => '\\' + m );
    /* replace ! -> ^ at the beginning */
    src = src.replace( /^\\!/g, '^' );
    return '[' + src + ']';
  }

  function curlyBrackets( src )
  {
    debugger;
    src = src.replace( /[\}\{]/g, ( m ) => map[ m ] );
    /* replace , with | to separate regexps */
    src = src.replace( /,+(?![^[|(]*]|\))/g, '|' );
    return src;
  }

  function _globToRegexp()
  {
    let args = _.longSlice( arguments );
    let i = args.indexOf( args[ 0 ], 1 ) - 1;

    /* i - index of captured group from regexp is equivalent to key from map  */

    if( _.strIs( map[ i ] ) )
    return map[ i ];
    else if( _.routineIs( map[ i ] ) )
    return map[ i ]( args[ 0 ] );
    else _.assert( 0 );
  }

  function adjustGlobStr( src )
  {
    _.assert( !_.path.isAbsolute( src ) );

    /* espace simple text */
    src = src.replace( /[^\*\[\]\{\}\?]+/g, ( m ) => _.regexpEscape( m ) );
    /* replace globs with regexps from map */
    src = src.replace( /(\*\*\\\/|\*\*)|(\*)|(\?)|(\[.*\])/g, _globToRegexp );
    /* replace {} -> () and , -> | to make proper regexp */
    src = src.replace( /\{.*\}/g, curlyBrackets );
    // src = src.replace( /\{.*\}+(?![^[]*\])/g, curlyBrackets );

    return src;
  }

}

//

function _globRegexpForTerminal( glob, filePath, basePath )
{
  let self = this;
  _.assert( arguments.length === 3 );
  if( basePath === null )
  basePath = filePath;
  if( filePath === null )
  filePath = basePath;
  if( basePath === null )
  basePath = filePath = this.fromGlob( glob );
  return self._globRegexpFor2.apply( self, [ glob, filePath, basePath ] ).actual;
}

//

let _globRegexpsForTerminal = _.routineVectorize_functor
({
  routine : _globRegexpForTerminal,
  select : 3,
});

function globRegexpsForTerminal()
{
  let result = _globRegexpsForTerminal.apply( this, arguments );
  return _.regexpsAny( result );
}

//

function _globRegexpForDirectory( glob, filePath, basePath )
{
  let self = this;
  _.assert( arguments.length === 3 );
  if( basePath === null )
  basePath = filePath;
  if( filePath === null )
  filePath = basePath;
  if( basePath === null )
  basePath = filePath = this.fromGlob( glob );
  return self._globRegexpFor2.apply( self, [ glob, filePath, basePath ] ).transient;
}

//

let _globRegexpsForDirectory = _.routineVectorize_functor
({
  routine : _globRegexpForDirectory,
  select : 3,
});

function globRegexpsForDirectory()
{
  let result = _globRegexpsForDirectory.apply( this, arguments );
  return _.regexpsAny( result );
}

//

function _globRegexpFor2( glob, filePath, basePath )
{
  let self = this;

  _.assert( _.strIs( glob ) );
  _.assert( _.strIs( filePath ) && !_.path.isGlob( filePath ) );
  _.assert( _.strIs( basePath ) && !_.path.isGlob( basePath ) );
  _.assert( arguments.length === 3 );

  glob = this.join( filePath, glob );

  // debugger;
  let related = this.relateForGlob( glob, filePath, basePath );
  // debugger;
  let maybeHere = '';
  let hereEscapedStr = self._globSplitToRegexpSource( self._hereStr );
  let downEscapedStr = self._globSplitToRegexpSource( self._downStr );

  let cache = Object.create( null );
  let result = Object.create( null );
  result.transient = [];
  result.actual = [];

  for( let r = 0 ; r < related.length ; r++ )
  {

    // related[ r ] = this.globSplit( related[ r ] );
    // related[ r ] = related[ r ].map( ( e, i ) => self._globSplitToRegexpSource( e ) );

    let transientSplits = this.globSplit( related[ r ] );
    let actualSplits = this.split( related[ r ] );

    transientSplits = transientSplits.map( ( e, i ) => toRegexp( e ) );
    actualSplits = actualSplits.map( ( e, i ) => toRegexp( e ) );

    result.transient.push( self._globRegexpSourceSplitsJoinForDirectory( transientSplits ) );
    result.actual.push( self._globRegexpSourceSplitsJoinForTerminal( actualSplits ) );

  }

  result.transient = '(?:(?:' + result.transient.join( ')|(?:' ) + '))';
  result.transient = _.regexpsJoin([ '^', result.transient, '$' ]);
  result.actual = '(?:(?:' + result.actual.join( ')|(?:' ) + '))';
  result.actual = _.regexpsJoin([ '^', result.actual, '$' ]);

  return result;

  /* - */

  function toRegexp( split )
  {
    if( cache[ split ] )
    return cache[ split ];
    cache[ split ] = self._globSplitToRegexpSource( split );
    return cache[ split ];
  }

}

//

let _globRegexpsFor2 = _.routineVectorize_functor
({
  routine : _globRegexpFor2,
  select : 3,
});

//

function globRegexpsFor2()
{
  let r = _globRegexpsFor2.apply( this, arguments );
  if( _.arrayIs( r ) )
  {
    let result = Object.create( null );
    result.actual = r.map( ( e ) => e.actual );
    result.transient = r.map( ( e ) => e.transient );
    return result;
  }
  return r;
}

//
//
// function _globRegexpFor3( glob, filePath, basePath )
// {
//   let self = this;
//
//   _.assert( _.strIs( glob ) );
//   _.assert( _.strIs( filePath ) && !_.path.isGlob( filePath ) );
//   _.assert( _.strIs( basePath ) && !_.path.isGlob( basePath ) );
//   _.assert( arguments.length === 3 );
//
//   glob = this.join( filePath, glob );
//
//   debugger;
//   let related = this.relateForGlob( glob, filePath, basePath );
//   debugger;
//   let maybeHere = '';
//   let hereEscapedStr = self._globSplitToRegexpSource( self._hereStr );
//   let downEscapedStr = self._globSplitToRegexpSource( self._downStr );
//
//   let cache = Object.create( null );
//   let result = Object.create( null );
//   result.transient = [];
//   result.actual = [];
//
//   for( let r = 0 ; r < related.length ; r++ )
//   {
//
//     // related[ r ] = this.globSplit( related[ r ] );
//     // related[ r ] = related[ r ].map( ( e, i ) => self._globSplitToRegexpSource( e ) );
//
//     let transientSplits = this.globSplit( related[ r ] );
//     let actualSplits = this.split( related[ r ] );
//
//     transientSplits = transientSplits.map( ( e, i ) => toRegexp( e ) );
//     actualSplits = actualSplits.map( ( e, i ) => toRegexp( e ) );
//
//     result.transient.push( self._globRegexpSourceSplitsJoinForDirectory( transientSplits ) );
//     result.actual.push( self._globRegexpSourceSplitsJoinForTerminal( actualSplits ) );
//
//   }
//
//   result.transient = '(?:(?:' + result.transient.join( ')|(?:' ) + '))';
//   result.transient = _.regexpsJoin([ '^', result.transient, '$' ]);
//   result.actual = '(?:(?:' + result.actual.join( ')|(?:' ) + '))';
//   result.actual = _.regexpsJoin([ '^', result.actual, '$' ]);
//
//   return result;
//
//   /* - */
//
//   function toRegexp( split )
//   {
//     if( cache[ split ] )
//     return cache[ split ];
//     cache[ split ] = self._globSplitToRegexpSource( split );
//     return cache[ split ];
//   }
//
// }

//
//
// let _globRegexpsFor3 = _.routineVectorize_functor
// ({
//   routine : _globRegexpFor3,
//   select : 3,
// });
//

// function globMapToRegexps( globMap, filePaths, basePath )
// function globMapToRegexps( globMap, basePath )
// {
//   let path = this;
//
//   _.assert( arguments.length === 2 );
//   // _.assert( _.strIs( filePaths ) || _.strsAre( filePaths ) );
//   _.assert( _.strIs( basePath ) && this.isAbsolute( basePath ) );
//   _.assert( _.mapIs( globMap ) )
//
//   // globMap = this.globMapExtend( null, globMap );
//
//   /* */
//
//   // if( _.strIs( filePaths ) )
//   // filePaths = [ filePaths ];
//
//   let empty = true;
//   let positive = Object.create( null );
//   let negative = Object.create( null );
//
//   debugger;
//
//   for( let g in globMap )
//   {
//     let value = !!globMap[ g ];
//     let glob = this.join( basePath, g );
//     let globPath = this.fromGlob( glob );
//
//     _.assert( _.boolLike( globMap[ g ] ) );
//     empty = false;
//
//     // if( !_.strBegins( basePath, globPath ) && !_.strBegins( globPath, basePath ) )
//     // continue;
//
//     if( value && !negative[ glob ] )
//     {
//       _.assert( !positive[ glob ] && !negative[ glob ], 'not tested' );
//       positive[ glob ] = [ g, path.fromGlob( glob ), basePath ];
//     }
//     else
//     {
//       _.assert( !positive[ glob ] && !negative[ glob ], 'not tested' );
//       negative[ glob ] = [ glob, path.fromGlob( glob ), basePath ];
//       delete positive[ glob ];
//     }
//
//   }
//
//   debugger;
//
//   // for( let p = 0 ; p < filePaths.length ; p++ )
//   // {
//   //   let filePath = this.join( basePath, filePaths[ p ] );
//   //   for( let g in globMap )
//   //   {
//   //     let value = !!globMap[ g ];
//   //     let glob = this.join( filePath, g );
//   //     let globPath = this.fromGlob( glob );
//   //
//   //     _.assert( _.boolLike( globMap[ g ] ) );
//   //     empty = false;
//   //
//   //     if( !_.strBegins( filePath, globPath ) && !_.strBegins( globPath, filePath ) )
//   //     continue;
//   //
//   //     if( value && !negative[ glob ] )
//   //     {
//   //       _.assert( !positive[ glob ] && !negative[ glob ], 'not tested' );
//   //       positive[ glob ] = [ g, filePaths[ p ], basePath ];
//   //     }
//   //     else
//   //     {
//   //       _.assert( !positive[ glob ] && !negative[ glob ], 'not tested' );
//   //       negative[ glob ] = [ g, filePaths[ p ], basePath ];
//   //       delete positive[ glob ];
//   //     }
//   //
//   //   }
//   // }
//
//   // debugger;
//
//   /* */
//
//   let result = Object.create( null );
//   result.actual = [];
//   result.transient = [];
//   result.notActual = [];
//
//   for( let g in positive )
//   {
//     let request = positive[ g ];
//     let response = this._globRegexpFor2.apply( this, request );
//     result.actual.push( response.actual );
//     result.transient.push( response.transient );
//   }
//
//   for( let g in negative )
//   {
//     let request = negative[ g ];
//     let response = this._globRegexpFor2.apply( this, request );
//     result.notActual.push( response.actual );
//   }
//
//   if( !empty && result.transient.length === 0 && result.notActual.length === 0 )
//   {
//     result.actual.push( /$_^/ );
//     result.transient.push( /$_^/ );
//   }
//
//   // debugger;
//
//   return result;
// }

//
//
// function globRegexpsFor3()
// {
//   let r = _globRegexpsFor3.apply( this, arguments );
//   if( _.arrayIs( r ) )
//   {
//     let result = Object.create( null );
//     result.terminal = r.map( ( e ) => e.terminal );
//     result.directory = r.map( ( e ) => e.directory );
//     return result;
//   }
//   return r;
// }

//
//
// function _globRegexpFor( srcGlob )
// {
//   let self = this;
//
//   _.assert( _.strIs( srcGlob ) );
//   _.assert( arguments.length === 1, 'expects single argument' );
//
//   let isRelative = this.isRelative( srcGlob );
//   let maybeHere = '\\.?';
//
//   if( !isRelative || srcGlob === '.' )
//   maybeHere = '';
//
//   if( isRelative )
//   srcGlob = this.undot( srcGlob );
//
//   let hereEscapedStr = self._globSplitToRegexpSource( self._hereStr );
//   let downEscapedStr = self._globSplitToRegexpSource( self._downStr );
//   let groups = self._globSplitsToRegexpSourceGroups( srcGlob );
//   let result = Object.create( null )
//
//   result.directory = write( groups, 0, 1 );
//   result.terminal = write( groups, 0, 0 );
//
//   if( maybeHere )
//   result.directory = '(?:' + result.directory + ')?';
//   result.directory = _.regexpsJoin([ '^', maybeHere, result.directory, '$' ]);
//
//   result.terminal = _.regexpsJoin([ '^', maybeHere, result.terminal, '$' ]);
//
//   return result;
//
//   /* - */
//
//   function write( groups, written, forDirectory )
//   {
//
//     if( _.strIs( groups ) )
//     {
//       if( groups === '.*' )
//       return '(?:/' + groups + ')?';
//       else if( written === 0 && ( groups === downEscapedStr || groups === hereEscapedStr ) )
//       return groups;
//       else if( groups === hereEscapedStr )
//       return '(?:/' + groups + ')?';
//       else
//       return '/' + groups;
//     }
//
//     let joined = [];
//     for( let g = 0 ; g < groups.length ; g++ )
//     {
//       let group = groups[ g ];
//       let text = write( group, written, forDirectory );
//       if( _.arrayIs( group ) )
//       text = '(?:' + text + ')?';
//       if( _.arrayIs( group ) && groups[ g ] === downEscapedStr )
//       text = '(?:' + text + ')?';
//       joined[ g ] = text;
//       written += 1;
//     }
//
//     let result;
//
//     if( forDirectory )
//     result = _.regexpsAtLeastFirstOnly( joined ).source;
//     else
//     result = joined.join( '' );
//
//     return result;
//   }
//
// }
//
// //
//
// let _globRegexpsFor = _.routineVectorize_functor( _globRegexpFor );
// function globRegexpsFor()
// {
//   let r = _globRegexpsFor.apply( this, arguments );
//   if( _.arrayIs( r ) )
//   {
//     let result = Object.create( null );
//     result.terminal = _.regexpsAny( r.map( ( e ) => e.terminal ) );
//     result.directory = _.regexpsAny( r.map( ( e ) => e.directory ) );
//     return result;
//   }
//   return r;
// }
//
//

function globToRegexp( glob )
{

  _.assert( _.strIs( glob ) || _.regexpIs( glob ) );
  _.assert( arguments.length === 1 );

  if( _.regexpIs( glob ) )
  return glob;

  let str = this._globSplitToRegexpSource( glob );

  let result = new RegExp( str );

  return result;
}

//

function _globSplitsToRegexpSourceGroups( globSplits )
{
  let self = this;

  _.assert( _.arrayIs( globSplits ) );
  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( globSplits.length >= 1 );

  let s = 0;
  let depth = 0;
  let hereEscapedStr = self._globSplitToRegexpSource( self._hereStr );
  let downEscapedStr = self._globSplitToRegexpSource( self._downStr );
  let levels = levelsEval( globSplits );

  for( let s = 0 ; s < globSplits.length ; s++ )
  {
    let split = globSplits[ s ];
    if( _.strHas( split, '.*' ) )
    {
      let level = levels[ s ];
      if( level < 0 )
      {
        for( let i = s ; i < globSplits.length ; i++ )
        levels[ i ] += 1;
        levels.splice( s, 0, level );
        globSplits.splice( s, 0, '[^\/]*' );
      }
      else
      {
        while( levels.indexOf( level, s+1 ) !== -1 )
        {
          _.assert( 0, 'not tested' ); xxx
          levels.splice( s+1, 0, level );
          globSplits.splice( s+1, 0, '[^\/]*' );
          for( let i = s+1 ; i < globSplits.length ; i++ )
          levels[ i ] += 1;
        }
      }
    }
  }

  let groups = groupWithLevels( globSplits.slice(), levels, 0 );

  return groups;

  /* - */

  function levelsEval()
  {
    let result = [];
    let level = 0;
    for( let s = 0 ; s < globSplits.length ; s++ )
    {
      split = globSplits[ s ];
      if( split === downEscapedStr )
      level -= 1;
      result[ s ] = level;
      if( split !== downEscapedStr )
      level += 1;
    }
    return result;
  }

  /* - */

  function groupWithLevels( globSplits, levels, first )
  {
    let result = [];

    for( let b = first ; b < globSplits.length-1 ; b++ )
    {
      let level = levels[ b ];
      let e = levels.indexOf( level, b+1 );

      if( e === -1 /*|| ( b === 0 && e === globSplits.length-1 )*/ )
      {
        continue;
      }
      else
      {
        let inside = globSplits.splice( b, e-b+1, null );
        globSplits[ b ] = inside;
        inside = levels.splice( b, e-b+1, null );
        levels[ b ] = inside;
        groupWithLevels( globSplits[ b ], levels[ b ], 1 );
      }

    }

    return globSplits;
  }

}

//

function _globSplitToRegexpSource( src )
{

  _.assert( _.strIs( src ) );
  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( !_.strHas( src, this._downStr ) || src === this._downStr, 'glob should not has splits with ".." combined with something' );

  let transformation1 =
  [
    [ /\[(.+?)\]/g, handleSquareBrackets ], /* square brackets */
    [ /\{(.*)\}/g, handleCurlyBrackets ], /* curly brackets */
  ]

  let transformation2 =
  [
    [ /\.\./g, '\\.\\.' ], /* double dot */
    [ /\./g, '\\.' ], /* dot */
    [ /([!?*@+]*)\((.*?(?:\|(.*?))*)\)/g, hanleParentheses ], /* parentheses */
    [ /\/\*\*/g, '(?:\/.*)?', ], /* slash + double asterix */
    [ /\*\*/g, '.*', ], /* double asterix */
    [ /(\*)/g, '[^\/]*' ], /* single asterix */
    [ /(\?)/g, '.', ], /* question mark */
  ]

  let result = adjustGlobStr( src );

  return result;

  /* */

  function handleCurlyBrackets( src, it )
  {
    throw _.err( 'Globs with curly brackets are not supported' );
  }

  /* */

  function handleSquareBrackets( src, it )
  {
    let inside = it.groups[ 1 ];
    /* escape inner [] */
    inside = inside.replace( /[\[\]]/g, ( m ) => '\\' + m );
    /* replace ! -> ^ at the beginning */
    inside = inside.replace( /^!/g, '^' );
    if( inside[ 0 ] === '^' )
    inside = inside + '\/';
    return '[' + inside + ']';
  }

  /* */

  function hanleParentheses( src, it )
  {

    let inside = it.groups[ 2 ].split( '|' );
    let multiplicator = it.groups[ 1 ];
    multiplicator = _.strReverse( multiplicator );
    if( multiplicator === '*' )
    multiplicator += '?';

    _.assert( _.strCount( multiplicator, '!' ) === 0 || multiplicator === '!' );
    _.assert( _.strCount( multiplicator, '@' ) === 0 || multiplicator === '@' );

    let result = '(?:' + inside.join( '|' ) + ')';
    if( multiplicator === '@' )
    result = result;
    else if( multiplicator === '!' )
    result = '(?:(?!(?:' + result + '|\/' + ')).)*?';
    else
    result += multiplicator;

    /* (?:(?!(?:abc)).)+ */

    return result;
  }

  // /* */
  //
  // function curlyBrackets( src )
  // {
  //   debugger;
  //   src = src.replace( /[\}\{]/g, ( m ) => map[ m ] );
  //   /* replace , with | to separate regexps */
  //   src = src.replace( /,+(?![^[|(]*]|\))/g, '|' );
  //   return src;
  // }

  /* */

  function adjustGlobStr( src )
  {
    let result = src;

    // _.assert( !_.path.isAbsolute( result ) );

    result = _.strReplaceAll( result, transformation1 );
    result = _.strReplaceAll( result, transformation2 );

    // /* espace ordinary text */
    // result = result.replace( /[^\*\+\[\]\{\}\?\@\!\^\(\)]+/g, ( m ) => _.regexpEscape( m ) );

    // /* replace globs with regexps from map */
    // result = result.replace( /(\*\*\\\/|\*\*)|(\*)|(\?)|(\[.*\])/g, globToRegexp );

    // /* replace {} -> () and , -> | to make proper regexp */
    // result = result.replace( /\{.*\}/g, curlyBrackets );
    // result = result.replace( /\{.*\}+(?![^[]*\])/g, curlyBrackets );

    return result;
  }

}

//

function _globRegexpSourceSplitsJoinForTerminal( globRegexpSourceSplits )
{
  let result = '';
  // debugger;
  let splits = globRegexpSourceSplits.map( ( split, s ) =>
  {
    if( s > 0 )
    if( split == '.*' )
    split = '(?:(?:^|/)' + split + ')?';
    else
    split = '(?:^|/)' + split;
    return split;
  });

  // for( let g = 0 ; g < globRegexpSourceSplits.length ; g++ )
  // {
  //   let split = globRegexpSourceSplits[ g ];
  //   if( g > 0 && split !== '.*' && globRegexpSourceSplits[ g-1 ] !== '.*' )
  //   result += '/';
  //   result += split;
  // }

  result = splits.join( '' );
  // result = '^' + splits.join( '' ) + '$';
  return result;
}

//

function _globRegexpSourceSplitsJoinForDirectory( globRegexpSourceSplits )
{
  let result = '';
  let splits = globRegexpSourceSplits.map( ( split, s ) =>
  {
    if( s > 0 )
    if( split == '.*' )
    split = '(?:(?:^|/)' + split + ')?';
    else
    split = '(?:^|/)' + split;
    return split;
  });
  result = _.regexpsAtLeastFirst( splits ).source;
  return result;
}

//

function relateForGlob( glob, filePath, basePath )
{
  let self = this;
  let result = [];

  _.assert( arguments.length === 3, 'expects exactly three argument' );
  _.assert( _.strIs( glob ) );
  _.assert( _.strIs( filePath ) );
  _.assert( _.strIs( basePath ) );

  let glob0 = this.globNormalize( glob );
  let glob1 = this.join( filePath, glob0 );
  let r1 = this.relativeUndoted( basePath, filePath );
  let r2 = this.relativeUndoted( filePath, glob1 );
  let downGlob = this.dot( this.normalize( this.join( r1, r2 ) ) );

  result.push( downGlob );

  /* */

  if( !_.strBegins( basePath, filePath ) || basePath === filePath )
  return result;

  let common = this.common( glob1, basePath );
  let glob2 = this.relative( common, glob1 );
  basePath = this.relative( common, basePath );

  if( basePath === '.' )
  {

    result.push( ( glob2 === '' || glob2 === '.' ) ? '.' : './' + glob2 );

  }
  else
  {

    let globSplits = this.globSplit( glob2 );
    let globRegexpSourceSplits = globSplits.map( ( e, i ) => self._globSplitToRegexpSource( e ) );
    let s = 0;
    while( s < globSplits.length )
    {
      let globSliced = new RegExp( '^' + self._globRegexpSourceSplitsJoinForTerminal( globRegexpSourceSplits.slice( 0, s+1 ) ) + '$' );
      if( globSliced.test( basePath ) )
      {
        let splits = _.strHas( globSplits[ s ], '**' ) ? globSplits.slice( s ) : globSplits.slice( s+1 );
        let glob3 = splits.join( '/' );
        result.push( glob3 === '' ? '.' : './' + glob3  );
      }

      s += 1;
    }

  }

  /* */

  return result;
}

//

function pathsRelateForGlob( filePath, oldPath, newPath )
{
  let length;

  let multiplied = _.multipleAll([ filePath, oldPath, newPath ]);

  filePath = multiplied[ 0 ];
  oldPath = multiplied[ 1 ];
  newPath = multiplied[ 2 ];

  _.assert( arguments.length === 3, 'expects exactly three argument' );

  if( _.arrayIs( filePath ) )
  {
    let result = [];
    for( let f = 0 ; f < filePath.length ; f++ )
    result[ f ] = this.relateForGlob( filePath[ f ], oldPath[ f ], newPath[ f ] );
    return result;
  }

  return this.relateForGlob( filePath, oldPath, newPath );
}

//

function globMapExtend( globMap, glob, value )
{

  _.assert( arguments.length === 2 || arguments.length === 3 );
  _.assert( globMap === null || _.mapIs( globMap ) );

  if( value === undefined )
  value = true;
  else
  value = !!value;

  if( globMap === null )
  globMap = Object.create( null );

  /* */

  if( glob === null )
  return globMap;

  if( _.strIs( glob ) )
  {
    glob = this.normalize( glob );
    if( globMap[ glob ] === undefined || !value )
    globMap[ glob ] = value;
  }
  else if( _.mapIs( glob ) )
  {
    for( let g in glob )
    {
      let val = glob[ g ];
      let gg = this.normalize( g );
      if( _.boolLike( val ) )
      val = !!val;
      _.assert( _.boolIs( val ) || _.strIs( val ) || _.arrayIs( val ) );

      // _.assert( _.boolLike( val ) );
      // if( !val || globMap[ gg ] || globMap[ gg ] === undefined )

      if( !val )
      globMap[ gg ] = val;
      else if( globMap[ gg ] === false )
      {}
      else if( _.strIs( globMap[ gg ] ) )
      {
        _.assert( _.strIs( val ) );
        globMap[ gg ] = [ globMap[ gg ], val ];
      }
      else if( _.arrayIs( globMap[ gg ] ) )
      globMap[ gg ].push( val );
      else
      globMap[ gg ] = val;

    }
  }
  else if( _.arrayLike( glob ) )
  {
    for( let g = 0 ; g < glob.length ; g++ )
    {
      this.globMapExtend( globMap, glob[ g ], value );
    }
  }
  else _.assert( 0, 'Expects glob' );

  /* */

  return globMap;
}

//

function globMapGroupByDst( globMap )
{
  let result = Object.create( null );

  _.assert( arguments.length == 1 );
  _.assert( _.mapIs( globMap ) );

  /* */

  for( let src in globMap )
  {
    let dst = globMap[ src ];
    if( dst === false )
    continue;

    if( _.strIs( dst ) )
    {
      result[ dst ] = result[ dst ] || Object.create( null );
      result[ dst ][ src ] = true;
    }
    else
    {
      for( var d = 0 ; d < dst.length ; d++ )
      {
        result[ dst[ d ] ] = result[ dst[ d ] ] || Object.create( null );
        result[ dst[ d ] ][ src ] = true;
      }
    }

  }

  /* */

  for( let src in globMap )
  {
    let dst = globMap[ src ];
    if( dst !== false )
    continue;
    for( var r in result )
    result[ r ][ src ] = false;
  }

  return result;
}

//
//
// function globMapRefine( o )
// {
//   let path = this;
//
//   _.routineOptions( globMapRefine, o );
//   _.assert( arguments.length === 1 );
//   _.assert( o.glob === null );
//   _.assert( !!o.filePath );
//
//   if( o.prefixPath === null )
//   o.prefixPath = o.basePath;
//   else if( o.basePath === null )
//   o.basePath = o.prefixPath;
//
//   o.glob = path.globMapExtend( null, o.filePath );
//
//   if( _.none( path.s.areGlob( o.glob ) ) )
//   {
//     o.glob = null;
//     return o;
//   }
//
//   if( o.basePath === null )
//   {
//     o.basePath = _.mapKeys( o.glob ).filter( ( g ) => path.isAbsolute( g ) );
//     o.basePath = o.basePath.map( ( g ) => path.fromGlob( g ) );
//     if( o.basePath.length > 0 )
//     o.basePath = path.common.apply( path, o.basePath );
//     _.sure( _.strIs( o.basePath ), 'Cant deduce prefixPath' );
//     o.prefixPath = o.basePath;
//   }
//
//   /* */
//
//   for( let g in o.glob )
//   {
//     let glob = path.s.join( o.prefixPath, g );
//     if( o.postfixPath )
//     glob = path.s.join( glob, o.postfixPath );
//     // glob = path.s.relative( o.basePath, glob );
//     if( glob !== g )
//     {
//       let value = o.glob[ g ];
//       delete o.glob[ g ];
//       path.globMapExtend( o.glob, glob, value );
//     }
//   }
//
//   /* */
//
//   o.filePath = [];
//   for( let g in o.glob )
//   {
//     let val = o.glob[ g ];
//     let filePath = path.fromGlob( g );
//     if( filePath === g && val )
//     {
//       o.filePath.push( filePath );
//       delete o.glob[ g ];
//     }
//     else
//     {
//       o.filePath.push( filePath );
//     }
//   }
//
//   o.prefixPath = path.s.detrail( o.prefixPath );
//   o.basePath = path.detrail( o.basePath );
//
//   _.assert( o.postfixPath === null || ( _.strIs( o.postfixPath ) && !path.isGlob( o.postfixPath ) ) );
//   _.assert( _.strIs( o.prefixPath ) && !path.isGlob( o.prefixPath ) );
//   _.assert( _.strIs( o.basePath ) && !path.isGlob( o.basePath ) );
//
//   return o;
// }
//
// globMapRefine.defaults =
// {
//   glob : null,
//   basePath : null,
//   filePath : null,
//   prefixPath : null,
//   postfixPath : null,
// }

//

function globMapToRegexps( o )
{
  let path = this;

  if( arguments[ 1 ] !== undefined )
  o = { globMap : arguments[ 0 ], basePath : arguments[ 1 ] }

  _.routineOptions( globMapToRegexps, o );
  _.assert( arguments.length === 1 || arguments.length === 2 );
  // _.assert( _.strIs( o.basePath ) && this.isAbsolute( o.basePath ) );
  _.assert( _.mapIs( o.basePath ) );
  _.assert( _.mapIs( o.globMap ) )

  o.redundantMap = _.mapExtend( null, o.globMap );

  /* */

  o.globPathMap = Object.create( null );
  for( let g in o.redundantMap )
  {
    let value = o.redundantMap[ g ];

    _.assert( path.isAbsolute( g ) );
    _.assert( _.boolIs( o.redundantMap[ g ] ) );

    let glob = g;
    let globPath = this.fromGlob( glob );
    o.globPathMap[ glob ] = globPath;
  }

  /* group by path */

  o.groupedMap = Object.create( null );
  for( let g in o.redundantMap )
  {
    let value = o.redundantMap[ g ];
    let globPath = o.globPathMap[ g ];
    let group = { [ g ] : value };

    if( !value )
    continue;

    delete o.redundantMap[ g ];

    for( let g2 in o.redundantMap )
    {
      let value2 = o.redundantMap[ g2 ];
      let globPath2 = o.globPathMap[ g2 ];
      let begin;

      if( g === g2 )
      continue;

      if( path.begins( globPath, globPath2 ) )
      begin = globPath2;
      else if( path.begins( globPath2, globPath ) )
      begin = globPath;

      if( !begin )
      continue;

      group[ g2 ] = value2;
    }

    let common = globPath;
    for( let g2 in group )
    {
      let value2 = o.redundantMap[ g2 ];
      let globPath2 = o.globPathMap[ g2 ];
      if( globPath2.length < common )
      common = globPath2;
      if( value2 )
      delete o.redundantMap[ g2 ];
    }

    o.groupedMap[ common ] = group;

  }

  /* */

  o.regexpMap = Object.create( null );
  for( let p in o.groupedMap )
  {
    let group = o.groupedMap[ p ];
    let basePath = o.basePath[ p ];
    let r = o.regexpMap[ p ] = Object.create( null );
    r.actual = [];
    r.transient = [];
    r.notActual = [];

    _.assert( _.strIsNotEmpty( basePath ), 'no base path for', p );

    for( let g in group )
    {
      let value = group[ g ];
      let regexps = this._globRegexpFor2( g, p, basePath );
      if( value )
      {
        r.actual.push( regexps.actual );
        r.transient.push( regexps.transient );
      }
      else
      {
        r.notActual.push( regexps.actual );
      }
    }

  }

  return o;
}

globMapToRegexps.defaults =
{
  globMap : null,
  basePath : null,
}

// //
//
// function globMapToRegexps( o )
// {
//   let path = this;
//
//   if( arguments[ 1 ] !== undefined )
//   o = { globMap : arguments[ 0 ], basePath : arguments[ 1 ] }
//
//   _.routineOptions( globMapToRegexps, o );
//   _.assert( arguments.length === 1 || arguments.length === 2 );
//   _.assert( _.strIs( o.basePath ) && this.isAbsolute( o.basePath ) );
//   _.assert( _.mapIs( o.globMap ) )
//
//   o.redundantMap = _.mapExtend( null, o.globMap );
//
//   /* */
//
//   o.globPathMap = Object.create( null );
//   for( let g in o.redundantMap )
//   {
//     let value = o.redundantMap[ g ];
//
//     _.assert( path.isAbsolute( g ) );
//     _.assert( _.boolIs( o.redundantMap[ g ] ) );
//
//     let glob = g;
//     let globPath = this.fromGlob( glob );
//     o.globPathMap[ glob ] = globPath;
//   }
//
//   /* group by path */
//
//   o.groupedMap = Object.create( null );
//   for( let g in o.redundantMap )
//   {
//     let value = o.redundantMap[ g ];
//     let globPath = o.globPathMap[ g ];
//     let group = { [ g ] : value };
//
//     if( !value )
//     continue;
//
//     delete o.redundantMap[ g ];
//
//     for( let g2 in o.redundantMap )
//     {
//       let value2 = o.redundantMap[ g2 ];
//       let globPath2 = o.globPathMap[ g2 ];
//       let begin;
//
//       if( g === g2 )
//       continue;
//
//       if( path.begins( globPath, globPath2 ) )
//       begin = globPath2;
//       else if( path.begins( globPath2, globPath ) )
//       begin = globPath;
//
//       if( !begin )
//       continue;
//
//       group[ g2 ] = value2;
//     }
//
//     let common = globPath;
//     for( let g2 in group )
//     {
//       let value2 = o.redundantMap[ g2 ];
//       let globPath2 = o.globPathMap[ g2 ];
//       if( globPath2.length < common )
//       common = globPath2;
//       if( value2 )
//       delete o.redundantMap[ g2 ];
//     }
//
//     o.groupedMap[ common ] = group;
//
//   }
//
//   /* */
//
//   o.regexpMap = Object.create( null );
//   for( let p in o.groupedMap )
//   {
//     let group = o.groupedMap[ p ];
//     let r = o.regexpMap[ p ] = Object.create( null );
//     r.actual = [];
//     r.transient = [];
//     r.notActual = [];
//
//     for( let g in group )
//     {
//       let value = group[ g ];
//       let regexps = this._globRegexpFor2( g, p, o.basePath );
//       if( value )
//       {
//         r.actual.push( regexps.actual );
//         r.transient.push( regexps.transient );
//       }
//       else
//       {
//         r.notActual.push( regexps.actual );
//       }
//     }
//
//   }
//
//   return o;
// }
//
// globMapToRegexps.defaults =
// {
//   globMap : null,
//   basePath : null,
// }

// --
// fields
// --

let Fields =
{
}

// --
// routines
// --

let Routines =
{

  // glob

  isGlob : isGlob,

  fromGlob : fromGlob,
  globNormalize : globNormalize,
  globSplit : globSplit,

  globRegexpsForTerminalSimple : globRegexpsForTerminalSimple,
  globRegexpsForTerminalOld : globRegexpsForTerminalOld,

  _globRegexpForTerminal : _globRegexpForTerminal,
  _globRegexpsForTerminal : _globRegexpsForTerminal,
  globRegexpsForTerminal : globRegexpsForTerminal,

  _globRegexpForDirectory : _globRegexpForDirectory,
  _globRegexpsForDirectory : _globRegexpsForDirectory,
  globRegexpsForDirectory : globRegexpsForDirectory,

  _globRegexpFor2 : _globRegexpFor2,
  _globRegexpsFor2 : _globRegexpsFor2,
  globRegexpsFor2 : globRegexpsFor2,


  // _globRegexpFor : _globRegexpFor,
  // _globRegexpsFor : _globRegexpsFor,
  // globRegexpsFor : globRegexpsFor,

  globToRegexp : globToRegexp,
  globsToRegexp : _.routineVectorize_functor( globToRegexp ),

  _globSplitsToRegexpSourceGroups : _globSplitsToRegexpSourceGroups,
  _globSplitToRegexpSource : _globSplitToRegexpSource,
  _globRegexpSourceSplitsJoinForTerminal : _globRegexpSourceSplitsJoinForTerminal,
  _globRegexpSourceSplitsJoinForDirectory : _globRegexpSourceSplitsJoinForDirectory,

  relateForGlob : relateForGlob,
  pathsRelateForGlob : pathsRelateForGlob,

  globMapExtend : globMapExtend,
  globMapGroupByDst : globMapGroupByDst,
  // globMapRefine : globMapRefine,
  globMapToRegexps : globMapToRegexps,

}

_.mapSupplement( Self, Fields );
_.mapSupplement( Self, Routines );

Self.Init();

// --
// export
// --

if( typeof module !== 'undefined' )
if( _global_.WTOOLS_PRIVATE )
delete require.cache[ module.id ];

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
