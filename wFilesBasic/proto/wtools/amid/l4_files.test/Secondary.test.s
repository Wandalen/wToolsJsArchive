( function _Secondary_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../node_modules/Tools' );

  if( !_global_.wTools.FileProvider )
  require( '../l4_files/entry/Basic.s' );

  _.include( 'wTesting' );

}

//

const _ = _global_.wTools;
const Parent = wTester;

//

function onSuiteBegin()
{
  this.isBrowser = typeof module === 'undefined';

  if( !this.isBrowser )
  this.suiteTempPath = _.path.tempOpen( _.path.join( __dirname, '../..' ), 'FilesRead' );
  else
  this.suiteTempPath = _.path.current();
}

//

function onSuiteEnd()
{
  if( !this.isBrowser )
  {
    _.assert( _.strHas( this.suiteTempPath, '.tmp' ) );
    _.path.tempClose(  this.suiteTempPath );
  }
}

// --
// read
// --

function filesReadOld( test )
{
  test.case = 'basic';

  var files = _.fileProvider.filesGlob({ filePath : _.path.normalize( __dirname ) + '/**' });
  var read = _.fileProvider.filesReadOld({ paths : files, preset : 'js' });

  test.identical( read.errs, {} );
  test.true( read.err === undefined );
  test.true( _.arrayIs( read.read ) );
  test.true( _.strIs( read.data ) );
  test.true( read.data.indexOf( '======\n( function()' ) !== -1 );

  /* */

  var provider = _.fileProvider;
  var testDir = _.path.join( test.context.suiteTempPath, test.name );
  var fileNames = [ 'a', 'b', 'c' ];

  test.case = 'sync reading of files, all files are present';
  var paths = fileNames.map( ( path ) =>
  {
    var p = _.path.join( testDir, path );
    provider.fileWrite( p, path );
    return p;
  });
  var result = provider.filesReadOld
  ({
    paths,
    sync : 1,
    throwing : 1,
  });
  test.identical( result.data, fileNames );
  test.identical( result.errs, {} );
  test.identical( result.err, undefined );

  /* */

  test.case = 'sync reading of files, not all files are present, throwing on';
  var paths = fileNames.map( ( path ) =>
  {
    var p = _.path.join( testDir, path );
    provider.fileWrite( p, path );
    return p;
  });
  paths.push( paths[ 0 ] + '_' );
  test.shouldThrowErrorSync( () =>
  {
    provider.filesReadOld
    ({
      paths,
      sync : 1,
      throwing : 1,
    });
  })

  /* */

  test.case = 'sync reading of files, not all files are present, throwing off';
  var paths = fileNames.map( ( path ) =>
  {
    var p = _.path.join( testDir, path );
    provider.fileWrite( p, path );
    return p;
  });
  paths.push( paths[ 0 ] + '_' );
  var result = provider.filesReadOld
  ({
    paths,
    sync : 1,
    throwing : 0,
  });

  var expectedData = fileNames.slice();
  expectedData.push( null );
  test.identical( result.data, expectedData );
  test.true( _.errIs( result.errs[ paths.length - 1 ] ) );
  test.true( _.errIs( result.err ) );

  // logger.log( _.entity.exportString( result, { levels : 99 } ) )
}

//

// function filesTreeRead( test )
// {
//   var currentTestDir = _.path.join( test.context.suiteTempPath, test.name );
//   var provider = _.fileProvider;
//   provider.safe = 1;
//   var filesTreeReadFixedOptions =
//   {
//     recursive : 2,
//     // relative : null,
//     // filePath : null,
//     // strict : 1,
//     // ignoreNonexistent : 1,
//     result : [],
//     orderingExclusion : [],
//     // sortingWithArray : null,
//     upToken : '/',
//     onFileTerminal : null,
//     onFileDir : null,
//   }

//   var map =
//   {
//     includingTerminals : [ 0, 1 ],
//     includingTransient : [ 0, 1 ],
//     includingDirs : [ 0, 1 ],
//     asFlatMap : [ 0, 1 ],
//     readingTerminals : [ 0, 1 ]
//   }

//   var combinations = [];
//   var keys = _.props.onlyOwnKeys( map );

//   function combine( i, o )
//   {
//     if( i === undefined )
//     i = 0;

//     if( o === undefined )
//     o = {};

//     var currentKey = keys[ i ];
//     var values = map[ currentKey ];

//     values.forEach( ( val ) =>
//     {
//       o[ currentKey ] = val;

//       if( i + 1 < keys.length )
//       combine( i + 1, o )
//       else
//       combinations.push( _.props.supplement( {}, o ) )
//     });
//   }

//   function flatMapFromTree( tree, currentPath, paths, o )
//   {
//     if( paths === undefined )
//     {
//       paths = Object.create( null );
//     }

//     if( o.includingDirs )
//     if( !paths[ currentTestDir] )
//     paths[ currentTestDir ] = Object.create( null );

//     for( var k in tree )
//     {
//       if( _.object.isBasic( tree[ k ] ) )
//       {
//         if( o.includingDirs )
//         paths[ _.path.resolve( currentPath, k ) ] = Object.create( null );

//         flatMapFromTree( tree[ k ], _.path.join( currentPath, k ), paths, o );
//       }
//       else
//       {
//         if( o.includingTerminals )
//         {
//           var val = null;
//           if( o.readingTerminals )
//           val = tree[ k ];

//           paths[ _.path.resolve( currentPath, k ) ] = val;
//         }
//       }
//     }

//     return paths;
//   }

//   function flatMapToTree( map, o )
//   {
//     var paths = _.props.onlyOwnKeys( map );
//     _.arrayRemoveElementOnce( paths, currentTestDir );
//     var result = Object.create( null );
//     var tree = new _.FileProvider.Extract({ filesTree : result })
//     // result[ '.' ] = Object.create( null );
//     // var inner = result[ '.' ];

//     paths.forEach( ( p ) =>
//     {
//       var isTerminal = o.readingTerminals ? _.strIs( map[ p ] ) : map[ p ] === null;
//       if( isTerminal && o.includingTerminals || o.includingDirs && !isTerminal )
//       {
//         var val = map[ p ];
//         if( isTerminal && !o.readingTerminals )
//         val = null;
//       }

//       tree.dirMakeForFile( '/' + _.path.relative( currentTestDir, p ) );

//       _.select
//       ({
//         src : result,
//         selector : _.path.relative( currentTestDir, p ),
//         set : val,
//         setting : 1,
//         usingIndexedAccessToMap : 0
//       });
//     })

//     return result;
//   }

//   /* */

//   var filesTree =
//   {
//     a  :
//     {
//       b  :
//       {
//         c  :
//         {
//           d :
//           {
//             e :
//             {
//               e_a  : '1',
//               e_b  : '2',
//               e_c  : '3',
//               e_d : {}
//             }
//           },
//           d_a  : '4',
//           d_b  : '5',
//           d_c  : '6',
//           d_d : {}
//         },
//         c_a  : '7',
//         c_b  : '8',
//         c_c  : '9',
//         c_d : {}
//       },
//       b_a  : '0',
//       b_b  : '1',
//       b_c  : '2',
//       b_d : {}
//     },
//     a_a  : '3',
//     a_b  : '4',
//     a_c  : '5',
//     a_d : {}
//   }

//   provider.filesDelete( currentTestDir );

//   _.FileProvider.Extract.readToProvider
//   ({
//     filesTree,
//     dstPath : currentTestDir,
//     dstProvider : provider
//   })

//   var n = 0;

//   var testsInfo = [];

//   combine();
//   combinations.forEach( ( c ) =>
//   {
//     var info = _.props.supplement( {}, c );
//     info.number = ++n;
//     test.case = _.entity.exportString( info, { levels : 3 } )
//     var checks = [];
//     var options = _.props.supplement( {}, c );
//     _.props.supplement( options, filesTreeReadFixedOptions );

//     options.srcPath = currentTestDir;
//     options.srcProvider = provider;

//     var files = _.FileProvider.Extract.filesTreeRead( options );
//     var expected = {};
//     flatMapFromTree( filesTree, currentTestDir, expected, options );

//     if( !options.asFlatMap )
//     expected = flatMapToTree( expected, options );

//     checks.push( test.identical( files, expected ) );

//     info.passed = true;
//     checks.forEach( ( check ) => { info.passed &= check; } )
//     testsInfo.push( info );
//   })

//   console.log( _.entity.exportString( testsInfo, { levels : 3 } ) )
// }

// filesTreeRead.timeOut = 30000;

//

// function filesTreeWrite( test )
// {
//   test.case = 'filesTreeWrite';

//   var currentTestDir = _.path.join( test.context.suiteTempPath, test.name );
//   var provider = _.fileProvider;

//   var fixedOptions =
//   {
//     filesTree : null,
//     allowWrite : 1,
//     allowDelete : 1,
//     verbosity : 0,
//   }

//   var map =
//   {
//     sameTime : [ 0, 1 ],
//     absolutePathForLink : [ 0, 1 ],
//     breakingSoftLink : [ 0, 1 ],
//     terminatingHardLinks : [ 0, 1 ],
//   }

//   var srcs =
//   [
//     {
//       a  :
//       {
//         b  :
//         {
//           c  :
//           {
//             d :
//             {
//               e :
//               {
//                 e_a  : '1',
//                 e_b  : '2',
//                 e_c  : '3',
//                 e_d : {}
//               }
//             },
//             d_a  : '4',
//             d_b  : '5',
//             d_c  : '6',
//             d_d : {}
//           },
//           c_a  : '7',
//           c_b  : '8',
//           c_c  : '9',
//           c_d : {}
//         },
//         b_a  : '0',
//         b_b  : '1',
//         b_c  : '2',
//         b_d : {}
//       },
//       a_a  : '3',
//       a_b  : '4',
//       a_c  : '5',
//       a_d : {}
//     }
//   ]

//   var combinations = [];
//   var keys = _.props.onlyOwnKeys( map );

//   function combine( i, o )
//   {
//     if( i === undefined )
//     i = 0;

//     if( o === undefined )
//     o = {};

//     var currentKey = keys[ i ];
//     var values = map[ currentKey ];

//     values.forEach( ( val ) =>
//     {
//       o[ currentKey ] = val;

//       if( i + 1 < keys.length )
//       combine( i + 1, o )
//       else
//       combinations.push( _.props.supplement( {}, o ) )
//     });
//   }


//   var n = 0;

//   var testsInfo = [];

//   combine();
//   srcs.forEach( ( tree ) =>
//   {
//     combinations.forEach( ( c ) =>
//     {
//       var info = _.props.supplement( {}, c );
//       info.number = ++n;
//       test.case = _.entity.exportString( info, { levels : 3 } )
//       var checks = [];
//       var options = _.props.supplement( {}, c );
//       _.props.supplement( options, fixedOptions );

//       provider.filesDelete( currentTestDir );
//       options.dstPath = currentTestDir;
//       options.filesTree = tree;
//       options.dstProvider = provider;

//       _.FileProvider.Extract.readToProvider( options );

//       var got = _.FileProvider.Extract.filesTreeRead
//       ({
//         srcPath : currentTestDir,
//         srcProvider : provider,
//       });
//       test.identical( got, tree );
//     })
//   })
// }

// filesTreeWrite.timeOut = 20000;

//

function readToProvider( test )
{
  let self = this;

  var filesTree =
  {
    'file' : 'file',
    'a' :
    {
      'b' :
      {
        'rlink' : [ { softLink : '../../../file' } ],
        'alink' : [ { softLink : '/file' } ],
        'hlink' : [ { hardLink : '/file' } ]
      }
    }
  }
  var extract1 = new _.FileProvider.Extract({ filesTree });

  test.identical( extract1.fileRead( '/a/b/rlink' ), 'file' )
  test.identical( extract1.fileRead( '/a/b/alink' ), 'file' )
  test.identical( extract1.fileRead( '/a/b/hlink' ), 'file' )

  var dstProvider = new _.FileProvider.Extract();
  extract1.readToProvider
  ({
    dstProvider,
    dstPath : '/',
    absolutePathForLink : 1
  });
  var expectedTree =
  {
    'file' : 'file',
    'a' :
    {
      'b' :
      {
        'rlink' : [ { softLink : '/file' } ],
        'alink' : [ { softLink : '/file' } ],
        'hlink' : [ { hardLink : '/file' } ]
      }
    }
  }

  test.identical( dstProvider.filesTree, expectedTree );
  test.identical( dstProvider.fileRead( '/a/b/rlink' ), 'file' )
  test.identical( dstProvider.fileRead( '/a/b/alink' ), 'file' )
  test.identical( dstProvider.fileRead( '/a/b/hlink' ), 'file' )

}

//

function configRead( test )
{
  let context = this;
  let provider = context.provider || _.fileProvider;
  let path = provider.path;
  let routinePath = path.join( context.suiteTempPath, 'routine-' + test.name );
  let terminalPath = path.join( routinePath, 'terminal' );

  /* */

  test.case = 'no config'
  provider.filesDelete( routinePath );
  test.shouldThrowErrorSync( () => provider.configRead({ filePath : terminalPath, many : 'all' }) );
  test.shouldThrowErrorSync( () => provider.configRead({ filePath : terminalPath, many : 'any', throwing : 1 }) );
  test.mustNotThrowError( () => provider.configRead({ filePath : terminalPath, many : 'any', throwing : 0 }) );

  /* */

  let src =
  {

    null : null,
    number : 13,
    string : 'something',
    map : { a : '1', dir : { b : 2 }, c : [ 1, 2, 3 ] },
    array : [ { a : '1', dir : { b : 2 }, c : [ 1, 2, 3 ] } ],
  }

  /* */

  test.case = 'json, no ext';
  provider.filesDelete( routinePath );
  var filePath = path.changeExt( terminalPath, 'json' );
  provider.fileWrite({ filePath, data : src, encoding : 'json.fine' });
  var got = provider.configRead({ filePath : terminalPath });
  test.identical( got, src );

  test.case = 'json, with ext';
  provider.filesDelete( routinePath );
  var filePath = path.changeExt( terminalPath, 'json' );
  provider.fileWrite({ filePath, data : src, encoding : 'json.fine' });
  var got = provider.configRead({ filePath });
  test.identical( got, src )

  test.case = 'bson, no ext';
  provider.filesDelete( routinePath );
  var filePath = path.changeExt( terminalPath, 'bson' );
  provider.fileWrite({ filePath, data : src, encoding : 'bson' });
  var got = provider.configRead({ filePath : terminalPath });
  test.identical( got, src );

  test.case = 'bson, with ext';
  provider.filesDelete( routinePath );
  var filePath = path.changeExt( terminalPath, 'bson' );
  provider.fileWrite({ filePath, data : src, encoding : 'bson' });
  var got = provider.configRead({ filePath });
  test.identical( got, src )

  test.case = 'cson, no ext';
  provider.filesDelete( routinePath );
  var filePath = path.changeExt( terminalPath, 'coffee' );
  provider.fileWrite({ filePath, data : src, encoding : 'coffee' });
  var got = provider.configRead({ filePath : terminalPath });
  test.identical( got, src );

  test.case = 'cson, with ext';
  provider.filesDelete( routinePath );
  var filePath = path.changeExt( terminalPath, 'coffee' );
  provider.fileWrite({ filePath, data : src, encoding : 'coffee' });
  var got = provider.configRead({ filePath });
  test.identical( got, src )

  /* */

  test.case = 'several configs';

  var src1 =
  {

    null : null,
    number : 13,
    string : 'something',
  }
  var src2 =
  {
    map : { a : '1', dir : { b : 2 }, c : [ 1, 2, 3 ] },
    array : [ { a : '1', dir : { b : 2 }, c : [ 1, 2, 3 ] } ],
  }
  provider.filesDelete( routinePath );
  var filePath = path.changeExt( terminalPath, 'json' );
  provider.fileWrite({ filePath, data : src1, encoding : 'json.fine' });
  var filePath = path.changeExt( terminalPath, 'bson' );
  provider.fileWrite({ filePath, data : src2, encoding : 'bson' });
  var filePath = path.s.changeExt( terminalPath, [ 'json', 'bson' ] );
  var got = provider.configRead({ filePath });
  test.identical( got, src );

  /* */

  test.case = 'several configs, no ext';

  var src1 =
  {

    null : null,
    number : 13,
    string : 'something',
  }
  var src2 =
  {
    map : { a : '1', dir : { b : 2 }, c : [ 1, 2, 3 ] },
    array : [ { a : '1', dir : { b : 2 }, c : [ 1, 2, 3 ] } ],
  }
  provider.filesDelete( routinePath );
  var filePath = path.changeExt( terminalPath, 'json' );
  provider.fileWrite({ filePath, data : src1, encoding : 'json.fine' });
  var filePath = path.changeExt( terminalPath, 'bson' );
  provider.fileWrite({ filePath, data : src2, encoding : 'bson' });
  var got = provider.configRead({ filePath : terminalPath });
  var expected =
  {
    null : null,
    number : 13,
    string : 'something',
    map : { a : '1', dir : { b : 2 }, c : [ 1, 2, 3 ] },
    array : [ { a : '1', dir : { b : 2 }, c : [ 1, 2, 3 ] } ],
  };
  test.identical( got, expected );
  test.shouldThrowErrorSync( () =>
  {
    provider.configRead({ filePath : [ terminalPath, terminalPath ] });
  })

  /* */

  test.case = 'second config rewrites some properties of first';
  var src1 =
  {

    null : null,
    number : 13,
    string : 'something',
  }
  var src2 =
  {
    null : 1,
    number : 10,
  }
  provider.filesDelete( routinePath );
  var filePath = path.changeExt( terminalPath, 'json' );
  provider.fileWrite({ filePath, data : src1, encoding : 'json.fine' });
  var filePath = path.changeExt( terminalPath, 'bson' );
  provider.fileWrite({ filePath, data : src2, encoding : 'bson' });
  var filePath = path.s.changeExt( terminalPath, [ 'json', 'bson' ] );
  var found = filePath.map( ( path ) =>
  {
    let ext = _.path.ext( path );
    return { particularPath : path, abstractPath : path, encoding : ext, ext }
  })
  var got = provider.configRead({ filePath, found });
  var expected =
  {
    null : 1,
    number : 10,
    string : 'something',
  }
  test.identical( got, expected );

  /* */

  test.case = 'second config is empty';
  var src1 =
  {

    null : null,
    number : 13,
    string : 'something',
  }
  var src2 =
  {
  }
  provider.filesDelete( routinePath );
  var filePath = path.changeExt( terminalPath, 'json' );
  provider.fileWrite({ filePath, data : src1, encoding : 'json.fine' });
  var filePath = path.changeExt( terminalPath, 'bson' );
  provider.fileWrite({ filePath, data : src2, encoding : 'bson' });
  var filePath = path.s.changeExt( terminalPath, [ 'json', 'bson' ] );
  var got = provider.configRead({ filePath });
  test.identical( got, src1 );

}

// --
// declare
// --

const Proto =
{

  name : 'Tools.files.Secondary.s',
  silencing : 1,
  // verbosity : 7,

  onSuiteBegin,
  onSuiteEnd,

  context :
  {
    suiteTempPath : null,
    isBrowser : null
  },

  tests :
  {

    // filesReadOld,
    // filesTreeRead,
    // filesTreeWrite,
    // readToProvider,

    configRead, /* qqq : extend */

  },

}

const Self = wTestSuite( Proto )
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
