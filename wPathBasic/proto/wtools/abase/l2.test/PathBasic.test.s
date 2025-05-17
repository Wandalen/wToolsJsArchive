( function _Path_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( 'Tools' );

  _.include( 'wTesting' );
  _.include( 'wStringer' );

  require( '../l3/PathsBasic.s' );

}

const _global = _global_;
const _ = _global_.wTools;

// --
// tests
// --

function is( test )
{

  // Input is path

  test.case = 'Empty string';
  var expected = true;
  var got = _.path.is( '' );
  test.identical( got, expected );

  test.case = 'Empty path';
  var expected = true;
  var got = _.path.is( '/' );
  test.identical( got, expected );

  test.case = 'Simple string';
  var expected = true;
  var got = _.path.is( 'hello' );
  test.identical( got, expected );

  test.case = 'Simple path string';
  var expected = true;
  var got = _.path.is( '/D/work/f' );
  test.identical( got, expected );

  test.case = 'Relative path';
  var expected = true;
  var got = _.path.is( '/home/user/dir1/dir2' );
  test.identical( got, expected );

  test.case = 'Absolute path';
  var expected = true;
  var got = _.path.is( 'C:/foo/baz/bar' );
  test.identical( got, expected );

  test.case = 'Other path';
  var expected = true;
  var got = _.path.is( 'c:\\foo\\' );
  test.identical( got, expected );

  // Input is not path

  test.case = 'No path - regexp';
  var expected = false;
  var got = _.path.is( /foo/ );
  test.identical( got, expected );

  test.case = 'No path - number';
  var expected = false;
  var got = _.path.is( 3 );
  test.identical( got, expected );

  test.case = 'No path - array';
  var expected = false;
  var got = _.path.is( [ '/C/', 'work/f' ] );
  test.identical( got, expected );

  test.case = 'No path - object';
  var expected = false;
  var got = _.path.is( { Path : 'C:/foo/baz/bar' } );
  test.identical( got, expected );

  test.case = 'No path - undefined';
  var expected = false;
  var got = _.path.is( undefined );
  test.identical( got, expected );

  test.case = 'No path - null';
  var expected = false;
  var got = _.path.is( null );
  test.identical( got, expected );

  test.case = 'No path - NaN';
  var expected = false;
  var got = _.path.is( NaN );
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.is( ) );

  test.case = 'Two arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.is( 'a', 'b' ) );

}

//

function are( test )
{
  test.case = 'Empty array';
  var expected = [];
  var got = _.paths.are( [] );
  test.identical( got, expected );

  test.case = 'Path in array';
  var expected = [ true ];
  var got = _.paths.are( [ '/C/work/f' ] );
  test.identical( got, expected );

  test.case = 'Paths in array';
  var expected = [ true, true ];
  var got = _.paths.are( [ '/C/', 'work/f' ] );
  test.identical( got, expected );

  test.case = 'Not a path in array';
  var expected = [ false ];
  var got = _.paths.are( [ 3 ] );
  test.identical( got, expected );

  test.case = 'Not only paths in array';
  var expected = [ true, true, false ];
  var got = _.paths.are( [ '/C/', 'work/f', 3 ] );
  test.identical( got, expected );

  // Input is object

  test.case = 'Empty object';
  var expected = [];
  var got = _.paths.are( {} );
  test.identical( got, expected );

  test.case = 'Number in object';
  var expected = [ true ];
  var got = _.paths.are( { Path : 3 } );
  test.identical( got, expected );

  test.case = 'String in object';
  var expected = [ true ];
  var got = _.paths.are( { Path : 'Hello world' } );
  test.identical( got, expected );

  test.case = 'Several entries in object';
  var expected = [ true, true, true, true ];
  var got = _.paths.are( { Path1 : 0, Path2 : [ 'One', 'Two' ], Path3 : null, Path4 : undefined } );
  test.identical( got, expected );

  // Other input

  test.case = 'No paths - string';
  var expected = true;
  var got = _.paths.are( 'foo' );
  test.identical( got, expected );

  test.case = 'No paths - regexp';
  var expected = false;
  var got = _.paths.are( /foo/ );
  test.identical( got, expected );

  test.case = 'No paths - number';
  var expected = false;
  var got = _.paths.are( 3 );
  test.identical( got, expected );

  test.case = 'No paths - undefined';
  var expected = false;
  var got = _.paths.are( undefined );
  test.identical( got, expected );

  test.case = 'No paths - null';
  var expected = false;
  var got = _.paths.are( null );
  test.identical( got, expected );

  test.case = 'No paths - NaN';
  var expected = false;
  var got = _.paths.are( NaN );
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'No arguments';
  test.shouldThrowErrorOfAnyKind( () => _.paths.are( ) );

  test.case = 'Two arguments';
  test.shouldThrowErrorOfAnyKind( () => _.paths.are( 'a', 'b' ) );
}

//

function like( test )
{
  test.case = 'Empty string';
  var expected = true;
  var got = _.path.like( '' );
  test.identical( got, expected );

  test.case = 'Empty path';
  var expected = true;
  var got = _.path.like( '/' );
  test.identical( got, expected );

  test.case = 'Simple string';
  var expected = true;
  var got = _.path.like( 'hello' );
  test.identical( got, expected );

  test.case = 'Simple path string';
  var expected = true;
  var got = _.path.like( '/D/work/f' );
  test.identical( got, expected );

  test.case = 'Relative path';
  var expected = true;
  var got = _.path.like( '/home/user/dir1/dir2' );
  test.identical( got, expected );

  test.case = 'Absolute path';
  var expected = true;
  var got = _.path.like( 'C:/foo/baz/bar' );
  test.identical( got, expected );

  test.case = 'Other path';
  var expected = true;
  var got = _.path.like( 'c:\\foo\\' );
  test.identical( got, expected );

  /* */

  test.case = 'No path - regexp';
  var expected = false;
  var got = _.path.like( /foo/ );
  test.identical( got, expected );

  test.case = 'No path - number';
  var expected = false;
  var got = _.path.like( 3 );
  test.identical( got, expected );

  test.case = 'No path - array';
  var expected = false;
  var got = _.path.like( [ '/C/', 'work/f' ] );
  test.identical( got, expected );

  test.case = 'No path - object';
  var expected = false;
  var got = _.path.like( { Path : 'C:/foo/baz/bar' } );
  test.identical( got, expected );

  test.case = 'No path - undefined';
  var expected = false;
  var got = _.path.like( undefined );
  test.identical( got, expected );

  test.case = 'No path - null';
  var expected = false;
  var got = _.path.like( null );
  test.identical( got, expected );

  test.case = 'No path - NaN';
  var expected = false;
  var got = _.path.like( NaN );
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'No arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.like() );

  test.case = 'extra arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.like( 'a', 'b' ) );
}

//

/* !!! example to avoid */

function isSafe( test )
{
  var path1 = '/home/user/dir1/dir2';
  var path2 = 'C:/foo/baz/bar';
  var path3 = '/foo/bar/.hidden';
  var path4 = '/foo/./somedir';
  var path5 = 'c:/foo/';
  var path6 = 'c:\\foo\\';
  var path7 = '/';
  var path8 = '/a';
  var got;

  // level 0 - Always True

  test.case = 'Absolute path, only 2 parts';

  var got = _.path.isSafe( '/D/work/', 0 );
  test.identical( got, true );

  test.case = 'unsafe windows path';
  var got = _.path.isSafe( path5, 0 );
  test.identical( got, true );

  test.case = 'unsafe windows path';
  var got = _.path.isSafe( path6, 0 );
  test.identical( got, true );

  test.case = 'unsafe short path';
  var got = _.path.isSafe( path7, 0 );
  test.identical( got, true );

  test.case = 'unsafe short path';
  var got = _.path.isSafe( path8, 0 );
  test.identical( got, true );

  // Absolute path long

  test.case = 'Absolute path 1';
  var got = _.path.isSafe( '/D/work/f', 1 );
  test.identical( got, true );

  test.case = 'Absolute path 2';
  var got = _.path.isSafe( '/D/work/f/g', 2 );
  test.identical( got, true );

  test.case = 'Absolute path 3';
  var got = _.path.isSafe( '/D/work/f/g', 3 );
  test.identical( got, true );

  // Absolute path short

  test.case = 'Absolute path 1';
  var got = _.path.isSafe( '/D', 1 );
  test.identical( got, false );

  test.case = 'Absolute path 2';
  var got = _.path.isSafe( '/D', 2 );
  test.identical( got, false );

  test.case = 'Absolute path 3';
  var got = _.path.isSafe( '/D', 3 );
  test.identical( got, false );

  test.case = 'Absolute path 2';
  var got = _.path.isSafe( '/D/work', 2 );
  test.identical( got, false );

  test.case = 'Absolute path 3';
  var got = _.path.isSafe( '/D/work', 3 );
  test.identical( got, false );

  // No absolute path long

  test.case = 'Not absolute path 1';
  var got = _.path.isSafe( 'c/work/f/', 1 );
  test.identical( got, true );

  test.case = 'Not absolute path 2';
  var got = _.path.isSafe( 'c/work/f/', 2 );
  test.identical( got, true );

  test.case = 'Not absolute path 3';
  var got = _.path.isSafe( 'c/work/f/', 3 );
  test.identical( got, true );

  // No absolute path short

  test.case = 'Not absolute path 1';
  var got = _.path.isSafe( 'c/work', 1 );
  test.identical( got, true );

  test.case = 'Not absolute path 2';
  var got = _.path.isSafe( 'c/', 2 );
  test.identical( got, true );

  test.case = 'Not absolute path 3';
  var got = _.path.isSafe( 'c/', 3 );
  test.identical( got, true );

  if( process.platform === 'win32' )
  {

    // Absolute path short

    test.case = 'Absolute path 1';
    var got1 = _.path.isSafe( '/D/work', 1 );
    test.identical( got1, false );

    test.case = 'Absolute path 2';
    var got1 = _.path.isSafe( '/D/work', 2 );
    test.identical( got1, false );

    test.case = 'Absolute path 3';
    var got1 = _.path.isSafe( '/D/work', 3 );
    test.identical( got1, false );

    test.case = 'Absolute path 2';
    var got1 = _.path.isSafe( '/D/work/f', 2 );
    test.identical( got1, false );

    test.case = 'Absolute path 3';
    var got1 = _.path.isSafe( '/D/work/f', 3 );
    test.identical( got1, false );

    // No absolute path contains 'Windows'

    test.case = 'Not absolute path 1';
    var got1 = _.path.isSafe( 'c/Windows/f/', 1 );
    test.identical( got1, true );

    test.case = 'Not absolute path 2';
    var got1 = _.path.isSafe( 'c/Windows/f/g', 2 );
    test.identical( got1, false );

    test.case = 'Not absolute path 3';
    var got1 = _.path.isSafe( 'c/Windows/f/g', 3 );
    test.identical( got1, false );

    test.case = 'Absolute path 3';
    var got1 = _.path.isSafe( 'c:/Windows/f/g', 3 );
    test.identical( got1, true );

    // No absolute path contains 'Program Files'

    test.case = 'Not absolute path 1';
    var got1 = _.path.isSafe( 'c/Program Files/f/', 1 );
    test.identical( got1, true );

    test.case = 'Not absolute path 2';
    var got1 = _.path.isSafe( 'c/Program Files/f/g', 2 );
    test.identical( got1, false );

    test.case = 'Not absolute path 3';
    var got1 = _.path.isSafe( 'c/Program Files/f/g', 3 );
    test.identical( got1, false );

    test.case = 'Absolute path 3';
    var got1 = _.path.isSafe( 'c:/Program Files/f/g', 3 );
    test.identical( got1, true );

  }

  // No absolute path contains RegExp characters

  test.case = 'Not absolute path 1';
  var got = _.path.isSafe( '.c/Program/.f/', 1 );
  test.identical( got, true );

  test.case = 'Not absolute path 2';
  var got = _.path.isSafe( '.c/Program/.f/g', 2 );
  test.identical( got, false );

  test.case = 'Not absolute path 3';
  var got = _.path.isSafe( '.c/Program/.f/g', 3 );
  test.identical( got, false );

  test.case = 'Absolute path 3';
  var got = _.path.isSafe( 'c:/Program/.f/g', 3 );
  test.identical( got, true );

  // No absolute path contains RegExp node_modules

  test.case = 'Not absolute path 1';
  var got = _.path.isSafe( 'node_modules/Program/f/', 1 );
  test.identical( got, true );

  test.case = 'Not absolute path 2';
  var got = _.path.isSafe( 'node_modules/Program/f/', 2 );
  test.identical( got, true );

  test.case = 'Not absolute path 3';
  var got = _.path.isSafe( 'node_modules/Program/f/', 3 );
  test.identical( got, false );

  test.case = 'Not absolute path 3';
  var got = _.path.isSafe( '/Program/node_modules/', 3 );
  test.identical( got, false );

  test.case = 'Absolute path 3';
  var got = _.path.isSafe( 'c:/Program/node_modules/g', 3 );
  test.identical( got, true );

  //

  test.case = 'safe windows path, level:2';
  var got = _.path.isSafe( '/D/work/f', 2 );
  var exp = true;
  if( process.platform === 'win32' )
  exp = false
  test.identical( got, exp );

  test.case = 'safe windows path, level:1';
  var got = _.path.isSafe( '/D/work/f', 1 );
  test.identical( got, true );

  test.case = 'safe posix path';
  var got = _.path.isSafe( path1 );
  test.identical( got, true );

  test.case = 'safe windows path';
  var got = _.path.isSafe( path2 );
  test.identical( got, true );

  // test.case = 'unsafe posix path ( hidden )';
  // var got = _.path.isSafe( path3 );
  // test.identical( got, false );

  test.case = 'safe posix path with "." segment';
  var got = _.path.isSafe( path4 );
  test.identical( got, true );

  test.case = 'unsafe short path';

  var got = _.path.isSafe( path7 );
  test.identical( got, false );

  var got = _.path.isSafe( path8 );
  test.identical( got, false );

  var got = _.path.isSafe( '/dir1/dir2', 2 );
  test.identical( got, false );

  var got = _.path.isSafe( '/dir1/dir2', 1 );
  test.identical( got, true );

  var got = _.path.isSafe( '/dir1', 1 );
  test.identical( got, false );

  /* - */

  test.open( 'windows only' );

  /* qqq : bad */
  if( process.platform === 'win32' )
  {

    test.case = 'unsafe windows path';
    var got2 = _.path.isSafe( path5 );
    test.identical( got2, false );

    test.case = 'unsafe windows path';
    var got2 = _.path.isSafe( path6 );
    test.identical( got2, false );

    var got2 = _.path.isSafe( '/c/Windows' );
    test.identical( got2, false );

    var got2 = _.path.isSafe( '/C/Windows' );
    test.identical( got2, false );

    var got2 = _.path.isSafe( '/c/Program Files' );
    test.identical( got2, false );

    var got2 = _.path.isSafe( '/C/Program Files' );
    test.identical( got2, false );

    var got2 = _.path.isSafe( 'C:\\Program Files (x86)' );
    test.identical( got2, false );

  }

  test.close( 'windows only' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'missed arguments';
  test.shouldThrowErrorSync( function( )
  {
    _.path.isSafe( );
  });

  test.case = 'Too many arguments';
  test.shouldThrowErrorSync( function( )
  {
    _.path.isSafe( '/a/b', 2, '/a/b' );
  });

  test.case = 'argument is not string';
  test.shouldThrowErrorSync( function( )
  {
    _.path.isSafe( null );
  });

  test.case = 'Wrong first argument';
  test.shouldThrowErrorSync( function( )
  {
    _.path.isSafe( null, 1 );
  });

  test.case = 'Wrong second argument';
  test.shouldThrowErrorSync( function( )
  {
    _.path.isSafe( '/a/b', '/a/b' );
  });

}

//

// function isRefinedMaybeTrailed( test )
// {
//   test.case = 'posix path, not refined'; [> <]
//
//   var path = '/';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '/a/';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '/foo/bar//baz/asdf/quux/..';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '/foo/bar//baz/asdf/quux/../';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '//foo/bar//baz/asdf/quux/..//';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = 'foo/bar//baz/asdf/quux/..//.';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   test.case = 'posix path, refined'; [> <]
//
//   var path = '/foo/bar//baz/asdf/quux/..';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = '/foo/bar//baz/asdf/quux/../';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = '//foo/bar//baz/asdf/quux/..//';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = 'foo/bar//baz/asdf/quux/..//.';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   test.case = 'winoows path, not refined'; [> <]
//
//   var path = 'C:\\temp\\\\foo\\bar\\..\\';
//   var expected = false;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = 'C:\\temp\\\\foo\\bar\\..\\\\';
//   var expected = false;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = 'C:\\temp\\\\foo\\bar\\..\\\\';
//   var expected = false;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = 'C:\\temp\\\\foo\\bar\\..\\..\\';
//   var expected = false;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = 'C:\\temp\\\\foo\\bar\\..\\..';
//   var expected = false;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = 'C:\\temp\\\\foo\\bar\\..\\..\\.';
//   var expected = false;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   test.case = 'winoows path, refined'; [> <]
//
//   var path = 'C:\\temp\\\\foo\\bar\\..\\';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = 'C:\\temp\\\\foo\\bar\\..\\\\';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = 'C:\\temp\\\\foo\\bar\\..\\\\';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = 'C:\\temp\\\\foo\\bar\\..\\..';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = 'C:\\temp\\\\foo\\bar\\..\\..\\';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = 'C:\\temp\\\\foo\\bar\\..\\..\\.';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   test.case = 'empty path, not refined';
//
//   var path = '';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '/';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '//';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '///';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '/.';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '/./.';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '.';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = './.';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   test.case = 'empty path';
//
//   var path = '';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   test.case = 'here';
//
//   var path = '.';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = '/';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = '//';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = '///';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = '/.';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = '/./.';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = '.';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = './.';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   test.case = 'path with "." in the middle'; [> <]
//
//   var path = 'foo/./bar/baz';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = 'foo/././bar/baz/';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = 'foo/././bar/././baz/';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '/foo/././bar/././baz/';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   test.case = 'path with "." in the middle, refined';
//
//   var path = 'foo/./bar/baz';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = 'foo/././bar/baz/';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = 'foo/././bar/././baz/';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = '/foo/././bar/././baz/';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   test.case = 'path with ".." in the middle'; [> <]
//
//   var path = 'foo/../bar/baz';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = 'foo/../../bar/baz/';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = 'foo/../../bar/../../baz/';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '/foo/../../bar/../../baz/';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   test.case = 'path with ".." in the middle, refined'; [> <]
//
//   var path = 'foo/../bar/baz';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = 'foo/../../bar/baz/';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = 'foo/../../bar/../../baz/';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = '/foo/../../bar/../../baz/';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   test.case = 'path with ".." in the beginning'; [> <]
//
//   var path = '../foo/bar';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '../../foo/bar/';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '..//..//foo/bar/';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '/..//..//foo/bar/';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '..x/foo/bar';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '..x../foo/bar';
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   test.case = 'path with ".." in the beginning, refined';
//
//   var path = '../foo/bar';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = '../../foo/bar/';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = '..//..//foo/bar/';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = '/..//..//foo/bar/';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = '..x/foo/bar';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   var path = '..x../foo/bar';
//   var refined = _.path.refine( path );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( refined );
//   test.identical( got, expected );
//
//   test.case = 'path with ".." in the beginning, refined and trailed';
//
//   var path = '../foo/bar';
//   var refined = _.path.refine( path );
//   var trailed = _.path.trail( refined );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( trailed );
//   test.identical( got, expected );
//
//   var path = '../../foo/bar/';
//   var refined = _.path.refine( path );
//   var trailed = _.path.trail( refined );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( trailed );
//   test.identical( got, expected );
//
//   var path = '..//..//foo/bar/';
//   var refined = _.path.refine( path );
//   var trailed = _.path.trail( refined );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( trailed );
//   test.identical( got, expected );
//
//   var path = '/..//..//foo/bar/';
//   var refined = _.path.refine( path );
//   var trailed = _.path.trail( refined );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( trailed );
//   test.identical( got, expected );
//
//   var path = '..x/foo/bar';
//   var refined = _.path.refine( path );
//   var trailed = _.path.trail( refined );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( trailed );
//   test.identical( got, expected );
//
//   var path = '..x../foo/bar';
//   var refined = _.path.refine( path );
//   var trailed = _.path.trail( refined );
//   var expected = true;
//   var got = _.path.isRefinedMaybeTrailed( trailed );
//   test.identical( got, expected );
//
//   [> <]
//
//   if( !Config.debug )
//   return;
//
//   test.case = 'No arguments';
//   test.shouldThrowErrorOfAnyKind( () => _.path.isRefinedMaybeTrailed( ) );
//
//   test.case = 'Two arguments';
//   test.shouldThrowErrorOfAnyKind( () => _.path.isRefinedMaybeTrailed( 'a', 'b' ) );
//
//   test.case = 'No path - regexp';
//   test.shouldThrowErrorOfAnyKind( () => _.path.isRefinedMaybeTrailed( /foo/ ) );
//
//   test.case = 'No path - number';
//   test.shouldThrowErrorOfAnyKind( () => _.path.isRefinedMaybeTrailed( 3 ) );
//
//   test.case = 'No path - array';
//   test.shouldThrowErrorOfAnyKind( () => _.path.isRefinedMaybeTrailed( [ '/C/', 'work/f' ] ) );
//
//   test.case = 'No path - object';
//   test.shouldThrowErrorOfAnyKind( () => _.path.isRefinedMaybeTrailed( { Path : 'C:/foo/baz/bar' } ) );
//
//   test.case = 'No path - undefined';
//   test.shouldThrowErrorOfAnyKind( () => _.path.isRefinedMaybeTrailed( undefined ) );
//
//   test.case = 'No path - null';
//   test.shouldThrowErrorOfAnyKind( () => _.path.isRefinedMaybeTrailed( null ) );
//
//   test.case = 'No path - NaN';
//   test.shouldThrowErrorOfAnyKind( () => _.path.isRefinedMaybeTrailed( NaN ) );
//
// }

//

function isRefined( test )
{
  test.case = 'posix path, not refined'; /* */

  var path = '/';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = '/a/';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = '/foo/bar//baz/asdf/quux/..';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = '/foo/bar//baz/asdf/quux/../';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = '//foo/bar//baz/asdf/quux/..//';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = 'foo/bar//baz/asdf/quux/..//.';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  test.case = 'posix path, refined'; /* */

  var path = '/foo/bar//baz/asdf/quux/..';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = '/foo/bar//baz/asdf/quux/../';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = '//foo/bar//baz/asdf/quux/..//';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = 'foo/bar//baz/asdf/quux/..//.';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  test.case = 'winoows path, not refined'; /* */

  var path = 'C:\\temp\\\\foo\\bar\\..\\';
  var expected = false;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\\\';
  var expected = false;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\\\';
  var expected = false;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..';
  var expected = false;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..\\';
  var expected = false;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..\\.';
  var expected = false;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  test.case = 'winoows path, refined'; /* */

  var path = 'C:\\temp\\\\foo\\bar\\..\\';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\\\';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\\\';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..\\';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..\\.';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  test.case = 'empty path, not refined';

  var path = '';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = '/';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = '//';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = '///';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = '/.';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = '/./.';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = '.';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = './.';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  test.case = 'empty path';

  var path = '';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  test.case = 'here';

  var path = '.';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = '/';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = '//';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = '///';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = '/.';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = '/./.';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = '.';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = './.';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  test.case = 'path with "." in the middle'; /* */

  var path = 'foo/./bar/baz';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = 'foo/././bar/baz/';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = 'foo/././bar/././baz/';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = '/foo/././bar/././baz/';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  test.case = 'path with "." in the middle, refined';

  var path = 'foo/./bar/baz';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = 'foo/././bar/baz/';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = 'foo/././bar/././baz/';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = '/foo/././bar/././baz/';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  test.case = 'path with ".." in the middle'; /* */

  var path = 'foo/../bar/baz';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = 'foo/../../bar/baz/';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = 'foo/../../bar/../../baz/';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = '/foo/../../bar/../../baz/';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  test.case = 'path with ".." in the middle, refined'; /* */

  var path = 'foo/../bar/baz';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = 'foo/../../bar/baz/';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = 'foo/../../bar/../../baz/';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = '/foo/../../bar/../../baz/';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  test.case = 'path with ".." in the beginning'; /* */

  var path = '../foo/bar';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = '../../foo/bar/';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = '..//..//foo/bar/';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = '/..//..//foo/bar/';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = '..x/foo/bar';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  var path = '..x../foo/bar';
  var expected = true;
  var got = _.path.isRefined( path );
  test.identical( got, expected );

  test.case = 'path with ".." in the beginning, refined';

  var path = '../foo/bar';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = '../../foo/bar/';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = '..//..//foo/bar/';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = '/..//..//foo/bar/';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = '..x/foo/bar';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  var path = '..x../foo/bar';
  var refined = _.path.refine( path );
  var expected = true;
  var got = _.path.isRefined( refined );
  test.identical( got, expected );

  test.case = 'path with ".." in the beginning, refined and trailed';

  var path = '../foo/bar';
  var refined = _.path.refine( path );
  var trailed = _.path.trail( refined );
  var expected = true;
  var got = _.path.isRefined( trailed );
  test.identical( got, expected );

  var path = '../../foo/bar/';
  var refined = _.path.refine( path );
  var trailed = _.path.trail( refined );
  var expected = true;
  var got = _.path.isRefined( trailed );
  test.identical( got, expected );

  var path = '..//..//foo/bar/';
  var refined = _.path.refine( path );
  var trailed = _.path.trail( refined );
  var expected = true;
  var got = _.path.isRefined( trailed );
  test.identical( got, expected );

  var path = '/..//..//foo/bar/';
  var refined = _.path.refine( path );
  var trailed = _.path.trail( refined );
  var expected = true;
  var got = _.path.isRefined( trailed );
  test.identical( got, expected );

  var path = '..x/foo/bar';
  var refined = _.path.refine( path );
  var trailed = _.path.trail( refined );
  var expected = true;
  var got = _.path.isRefined( trailed );
  test.identical( got, expected );

  var path = '..x../foo/bar';
  var refined = _.path.refine( path );
  var trailed = _.path.trail( refined );
  var expected = true;
  var got = _.path.isRefined( trailed );
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRefined( ) );

  test.case = 'Two arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRefined( 'a', 'b' ) );

  test.case = 'No path - regexp';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRefined( /foo/ ) );

  test.case = 'No path - number';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRefined( 3 ) );

  test.case = 'No path - array';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRefined( [ '/C/', 'work/f' ] ) );

  test.case = 'No path - object';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRefined( { Path : 'C:/foo/baz/bar' } ) );

  test.case = 'No path - undefined';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRefined( undefined ) );

  test.case = 'No path - null';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRefined( null ) );

  test.case = 'No path - NaN';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRefined( NaN ) );

}

//

// function isNormalizedMaybeTrailed( test )
// {
//
//   var got;
//
//   test.case = 'posix path'; [> <]
//
//   // Not normalized
//
//   var path = '/foo/bar//baz/asdf/quux/..';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '/foo/bar//baz/asdf/quux/../';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = 'foo/bar//baz/asdf/quux/..//.';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   // Normalized
//
//   var path = '/foo/bar//baz/asdf';
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = _.path.normalize( '/foo/bar//baz/asdf/quux/../' );
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = _.path.normalize( 'foo/bar//baz/asdf/quux/..//.' );
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   test.case = 'windows path'; [> <]
//
//   //Not normalized
//
//   var path = '/C:\\temp\\\\foo\\bar\\..\\';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '\\C:\\temp\\\\foo\\bar\\..\\';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = 'C:\\temp\\\\foo\\bar\\..\\..';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = 'C:\\temp\\\\foo\\bar\\..\\..\\';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = 'c://temp/foo/bar/';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   // Normalized
//
//   var path = _.path.normalize( '/C:\\temp\\\\foo\\bar\\..\\' );
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '/C:/temp//foo';
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = _.path.normalize( 'C:\\temp\\\\foo\\bar\\..\\..\\' );
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   test.case = 'empty path'; [> <]
//
//   var path = '';
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '.';
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '/';
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '///';
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '/./.';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = './.';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   test.case = 'path with "." in the middle'; [> <]
//
//   var path = 'foo/./bar/baz';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '/foo/././bar/././baz/';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '/foo/.x./baz';
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   test.case = 'path with "." in the beginning'; [> <]
//
//   var path = './foo/bar';
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '.\\foo\\bar';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '././foo/bar/';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '/.//.//foo/bar/';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '.x./foo/bar/';
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '.x./foo/bar';
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   test.case = 'path with "." in the end'; [> <]
//
//   var path = 'foo/.bar.';
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = 'foo/bar/./.';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '/foo/baz/.x./';
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   test.case = 'path with ".." in the middle'; [> <]
//
//   var path = 'foo/../bar/baz';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '/foo/../../bar/../../baz/';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = _.path.normalize( '/foo/../../bar/../../baz/' );
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '/../../baz';
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   test.case = 'path with ".." in the beginning'; [> <]
//
//   var path = '../../foo/bar';
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '..//..//foo/bar/';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '..x../foo/bar';
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   test.case = 'path with ".." in the end'; [> <]
//
//   var path = 'foo/..bar..';
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = 'foo/bar/..';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = 'foo/bar/../../../..';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   test.case = 'path with ".." and "." combined'; [> <]
//
//   var path = '/abc/./.././a/b';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = '/a/b/abc/./../.';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = './../.';
//   var expected = false;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   var path = _.path.normalize( '/a/b/abc/./../.' );
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( path );
//   test.identical( got, expected );
//
//   test.case = 'path with ".." and "." combined - normalized'; [> <]
//
//   var path = '/abc/./.././a/b';
//   var normalized = _.path.normalize( path );
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( normalized );
//   test.identical( got, expected );
//
//   var path = '/a/b/abc/./../.';
//   var normalized = _.path.normalize( path );
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( normalized );
//   test.identical( got, expected );
//
//   var path = './../.';
//   var normalized = _.path.normalize( path );
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( normalized );
//   test.identical( got, expected );
//
//   test.case = 'path with ".." and "." combined - normalized and trailed'; [> <]
//
//   var path = '/abc/./.././a/b';
//   var normalized = _.path.normalize( path );
//   var trailed = _.path.trail( normalized );
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( trailed );
//   test.identical( got, expected );
//
//   var path = '/a/b/abc/./../.';
//   var normalized = _.path.normalize( path );
//   var trailed = _.path.trail( normalized );
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( trailed );
//   test.identical( got, expected );
//
//   var path = './../.';
//   var normalized = _.path.normalize( path );
//   var trailed = _.path.trail( normalized );
//   var expected = true;
//   var got = _.path.isNormalizedMaybeTrailed( trailed );
//   test.identical( got, expected );
//
//   [> <]
//
//   if( !Config.debug )
//   return;
//
//   test.case = 'No arguments';
//   test.shouldThrowErrorOfAnyKind( () => _.path.isNormalizedMaybeTrailed( ) );
//
//   test.case = 'Two arguments';
//   test.shouldThrowErrorOfAnyKind( () => _.path.isNormalizedMaybeTrailed( 'a', 'b' ) );
//
//   // Input is not path
//
//   test.case = 'No path - regexp';
//   test.shouldThrowErrorOfAnyKind( () => _.path.isNormalizedMaybeTrailed( /foo/ ) );
//
//   test.case = 'No path - number';
//   test.shouldThrowErrorOfAnyKind( () => _.path.isNormalizedMaybeTrailed( 3 ) );
//
//   test.case = 'No path - array';
//   test.shouldThrowErrorOfAnyKind( () => _.path.isNormalizedMaybeTrailed( [ '/C/', 'work/f' ] ) );
//
//   test.case = 'No path - object';
//   test.shouldThrowErrorOfAnyKind( () => _.path.isNormalizedMaybeTrailed( { Path : 'C:/foo/baz/bar' } ) );
//
//   test.case = 'No path - undefined';
//   test.shouldThrowErrorOfAnyKind( () => _.path.isNormalizedMaybeTrailed( undefined ) );
//
//   test.case = 'No path - null';
//   test.shouldThrowErrorOfAnyKind( () => _.path.isNormalizedMaybeTrailed( null ) );
//
//   test.case = 'No path - NaN';
//   test.shouldThrowErrorOfAnyKind( () => _.path.isNormalizedMaybeTrailed( NaN ) );
//
// }

//

function isNormalized( test )
{

  var got;

  test.case = 'posix path'; /* */

  // Not normalized

  var path = '/foo/bar//baz/asdf/quux/..';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = '/foo/bar//baz/asdf/quux/../';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = 'foo/bar//baz/asdf/quux/..//.';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  // Normalized

  var path = '/foo/bar//baz/asdf';
  var expected = true;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = _.path.normalize( '/foo/bar//baz/asdf/quux/../' );
  var expected = true;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = _.path.normalize( 'foo/bar//baz/asdf/quux/..//.' );
  var expected = true;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  test.case = 'windows path'; /* */

  //Not normalized

  var path = '/C:\\temp\\\\foo\\bar\\..\\';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = '\\C:\\temp\\\\foo\\bar\\..\\';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..\\';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = 'c://temp/foo/bar/';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  // Normalized

  var path = _.path.normalize( '/C:\\temp\\\\foo\\bar\\..\\' );
  var expected = true;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = '/C:/temp//foo';
  var expected = true;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = _.path.normalize( 'C:\\temp\\\\foo\\bar\\..\\..\\' );
  var expected = true;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  test.case = 'empty path'; /* */

  var path = '';
  var expected = true;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = '.';
  var expected = true;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = '/';
  var expected = true;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = '///';
  var expected = true;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = '/./.';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = './.';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  test.case = 'path with "." in the middle'; /* */

  var path = 'foo/./bar/baz';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = '/foo/././bar/././baz/';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = '/foo/.x./baz';
  var expected = true;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  test.case = 'path with "." in the beginning'; /* */

  var path = './foo/bar';
  var expected = true;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = '.\\foo\\bar';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = '././foo/bar/';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = '/.//.//foo/bar/';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = '.x./foo/bar';
  var expected = true;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  test.case = 'path with "." in the end'; /* */

  var path = 'foo/.bar.';
  var expected = true;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = 'foo/bar/./.';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = '/foo/baz/.x./';
  var expected = true;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  test.case = 'path with ".." in the middle'; /* */

  var path = 'foo/../bar/baz';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = '/foo/../../bar/../../baz/';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = _.path.normalize( '/foo/../../bar/../../baz/' );
  var expected = true;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = '/../../baz';
  var expected = true;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  test.case = 'path with ".." in the beginning'; /* */

  var path = '../../foo/bar';
  var expected = true;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = '..//..//foo/bar/';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = '..x../foo/bar';
  var expected = true;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  test.case = 'path with ".." in the end'; /* */

  var path = 'foo/..bar..';
  var expected = true;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = 'foo/bar/..';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = 'foo/bar/../../../..';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  test.case = 'path with ".." and "." combined'; /* */

  var path = '/abc/./.././a/b';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = '/a/b/abc/./../.';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = './../.';
  var expected = false;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  var path = _.path.normalize( '/a/b/abc/./../.' );
  var expected = true;
  var got = _.path.isNormalized( path );
  test.identical( got, expected );

  test.case = 'path with ".." and "." combined - normalized'; /* */

  var path = '/abc/./.././a/b';
  var normalized = _.path.normalize( path );
  var expected = true;
  var got = _.path.isNormalized( normalized );
  test.identical( got, expected );

  var path = '/a/b/abc/./../.';
  var normalized = _.path.normalize( path );
  var expected = true;
  var got = _.path.isNormalized( normalized );
  test.identical( got, expected );

  var path = './../.';
  var normalized = _.path.normalize( path );
  var expected = true;
  var got = _.path.isNormalized( normalized );
  test.identical( got, expected );

  test.case = 'path with ".." and "." combined - normalized and trailed'; /* */

  var path = '/abc/./.././a/b';
  var normalized = _.path.normalize( path );
  var trailed = _.path.trail( normalized );
  var expected = true;
  var got = _.path.isNormalized( trailed );
  test.identical( got, expected );

  var path = '/a/b/abc/./../.';
  var normalized = _.path.normalize( path );
  var trailed = _.path.trail( normalized );
  var expected = true;
  var got = _.path.isNormalized( trailed );
  test.identical( got, expected );

  var path = './../.';
  var normalized = _.path.normalize( path );
  var trailed = _.path.trail( normalized );
  var expected = true;
  var got = _.path.isNormalized( trailed );
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.isNormalized( ) );

  test.case = 'Two arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.isNormalized( 'a', 'b' ) );

  // Input is not path

  test.case = 'No path - regexp';
  test.shouldThrowErrorOfAnyKind( () => _.path.isNormalized( /foo/ ) );

  test.case = 'No path - number';
  test.shouldThrowErrorOfAnyKind( () => _.path.isNormalized( 3 ) );

  test.case = 'No path - array';
  test.shouldThrowErrorOfAnyKind( () => _.path.isNormalized( [ '/C/', 'work/f' ] ) );

  test.case = 'No path - object';
  test.shouldThrowErrorOfAnyKind( () => _.path.isNormalized( { Path : 'C:/foo/baz/bar' } ) );

  test.case = 'No path - undefined';
  test.shouldThrowErrorOfAnyKind( () => _.path.isNormalized( undefined ) );

  test.case = 'No path - null';
  test.shouldThrowErrorOfAnyKind( () => _.path.isNormalized( null ) );

  test.case = 'No path - NaN';
  test.shouldThrowErrorOfAnyKind( () => _.path.isNormalized( NaN ) );

}

//

function isAbsolute( test )
{

  // Absolute path

  test.case = 'Absolute path';

  var got = _.path.isAbsolute( '/D' );
  test.identical( got, true );

  var got = _.path.isAbsolute( '/D/' );
  test.identical( got, true );

  var got = _.path.isAbsolute( '/D/work' );
  test.identical( got, true );

  var got = _.path.isAbsolute( '/D/work/f' );
  test.identical( got, true );

  var got = _.path.isAbsolute( '/D/work/f/' );
  test.identical( got, true );

  // No absolute path

  test.case = 'Not absolute path';

  var got = _.path.isAbsolute( 'c' );
  test.identical( got, false );

  var got = _.path.isAbsolute( 'c/' );
  test.identical( got, false );

  var got = _.path.isAbsolute( 'c/work' );
  test.identical( got, false );

  var got = _.path.isAbsolute( 'c/work/' );
  test.identical( got, false );

  test.case = 'posix path'; /* */

  var path = '/foo/bar/baz/asdf/quux/..';
  var expected = true;
  var got = _.path.isAbsolute( path );
  test.identical( got, expected );

  test.case = 'posix path'; /* */

  var path = '/foo/bar//baz/asdf/quux/..';
  var expected = true;
  var got = _.path.isAbsolute( path );
  test.identical( got, expected );

  var path = 'foo/bar//baz/asdf/quux/..//.';
  var expected = false;
  var got = _.path.isAbsolute( path );
  test.identical( got, expected );

  test.case = 'windows path'; /* */

  test.open( 'not normalized' );

  var path = '/C:/temp/foo/bar/../';
  var expected = true;
  var got = _.path.isAbsolute( path );
  test.identical( got, expected );

  var path = 'C:/temp/foo/bar/../';
  var expected = true;
  var got = _.path.isAbsolute( path );
  test.identical( got, expected );

  var path = 'c://temp/foo/bar/';
  var expected = true;
  var got = _.path.isAbsolute( path );
  test.identical( got, expected );

  test.close( 'not normalized' );
  test.open( 'normalized' );

  var path = _.path.refine( '/C:/temp/foo/bar/../' );
  var expected = true;
  var got = _.path.isAbsolute( path );
  test.identical( got, expected );

  var path = _.path.refine( 'C:/temp/foo/bar/../' );
  var expected = true;
  var got = _.path.isAbsolute( path );
  test.identical( got, expected );

  var path = _.path.refine( 'c://temp/foo/bar/' );
  var expected = true;
  var got = _.path.isAbsolute( path );
  test.identical( got, expected );

  test.close( 'normalized' );

  test.case = 'empty path'; /* */

  var path = '';
  var expected = false;
  var got = _.path.isAbsolute( path );
  test.identical( got, expected );

  var path = '.';
  var expected = false;
  var got = _.path.isAbsolute( path );
  test.identical( got, expected );

  var path = '/';
  var expected = true;
  var got = _.path.isAbsolute( path );
  test.identical( got, expected );

  var path = '///';
  var expected = true;
  var got = _.path.isAbsolute( path );
  test.identical( got, expected );

  var path = '/./.';
  var expected = true;
  var got = _.path.isAbsolute( path );
  test.identical( got, expected );

  var path = './.';
  var expected = false;
  var got = _.path.isAbsolute( path );
  test.identical( got, expected );

  test.open( 'not refined' );

  test.case = '\\ in the beggining';
  var got = _.path.isAbsolute( '\\C:/foo/baz/bar' );
  test.identical( got, true );

  test.case = '\\ in the middle';
  var got = _.path.isAbsolute( 'C:/foo\\baz\\bar' );
  test.identical( got, true );

  test.case = '\\ in the end';
  var got = _.path.isAbsolute( 'C:/foo/baz/bar\\' );
  test.identical( got, true );

  test.close( 'not refined' );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.isAbsolute( ) );

  test.case = 'Two arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.isAbsolute( 'a', 'b' ) );

  // Input is not path

  test.case = 'No path - regexp';
  test.shouldThrowErrorOfAnyKind( () => _.path.isAbsolute( /foo/ ) );

  test.case = 'No path - number';
  test.shouldThrowErrorOfAnyKind( () => _.path.isAbsolute( 3 ) );

  test.case = 'No path - array';
  test.shouldThrowErrorOfAnyKind( () => _.path.isAbsolute( [ '/C/', 'work/f' ] ) );

  test.case = 'No path - object';
  test.shouldThrowErrorOfAnyKind( () => _.path.isAbsolute( { Path : 'C:/foo/baz/bar' } ) );

  test.case = 'No path - undefined';
  test.shouldThrowErrorOfAnyKind( () => _.path.isAbsolute( undefined ) );

  test.case = 'No path - null';
  test.shouldThrowErrorOfAnyKind( () => _.path.isAbsolute( null ) );

  test.case = 'No path - NaN';
  test.shouldThrowErrorOfAnyKind( () => _.path.isAbsolute( NaN ) );

  // // Input is not Refined
  //
  // test.case = '\\ in the beggining';
  // test.shouldThrowErrorOfAnyKind( () => _.path.isAbsolute( '\\C:/foo/baz/bar' ) );
  //
  // test.case = '\\ in the middle';
  // test.shouldThrowErrorOfAnyKind( () => _.path.isAbsolute( 'C:/foo\\baz\\bar' ) );
  //
  // test.case = '\\ in the end';
  // test.shouldThrowErrorOfAnyKind( () => _.path.isAbsolute( 'C:/foo/baz/bar\\' ) );

}

//

function isRelative( test )
{

  // Absolute path

  test.case = 'Absolute path';

  var got = _.path.isRelative( '/D' );
  test.identical( got, false );

  var got = _.path.isRelative( '/D/' );
  test.identical( got, false );

  var got = _.path.isRelative( '/D/work' );
  test.identical( got, false );

  var got = _.path.isRelative( '/D/work/f' );
  test.identical( got, false );

  var got = _.path.isRelative( '/D/work/f/' );
  test.identical( got, false );

  // Relative path

  test.case = 'Relative path';

  var got = _.path.isRelative( 'c' );
  test.identical( got, true );

  var got = _.path.isRelative( 'c/' );
  test.identical( got, true );

  var got = _.path.isRelative( 'c/work' );
  test.identical( got, true );

  var got = _.path.isRelative( 'c/work/' );
  test.identical( got, true );

  var got = _.path.isRelative( 'c/work/f/' );
  test.identical( got, true );

  test.case = 'posix path'; /* */

  var path = '/foo/bar//baz/asdf/quux/..';
  var expected = false;
  var got = _.path.isRelative( path );
  test.identical( got, expected );

  var path = 'foo/bar//baz/asdf/quux/..//.';
  var expected = true;
  var got = _.path.isRelative( path );
  test.identical( got, expected );

  test.case = 'windows path'; /* */

  //Not normalized

  var path = '/C:/temp/foo/bar/../';
  var expected = false;
  var got = _.path.isRelative( path );
  test.identical( got, expected );

  var path = 'C:/temp/foo/bar/../';
  var expected = false;
  var got = _.path.isRelative( path );
  test.identical( got, expected );

  var path = 'c://temp/foo/bar/';
  var expected = false;
  var got = _.path.isRelative( path );
  test.identical( got, expected );

  // Normalized

  var path = _.path.normalize( '/C:/temp/foo/bar/../' );
  var expected = false;
  var got = _.path.isRelative( path );
  test.identical( got, expected );

  var path = _.path.normalize( 'C:/temp/foo/bar/../' );
  var expected = false;
  var got = _.path.isRelative( path );
  test.identical( got, expected );

  var path = _.path.normalize( 'c://temp/foo/bar/' );
  var expected = false;
  var got = _.path.isRelative( path );
  test.identical( got, expected );

  var path = _.path.normalize( 'c/temp/foo/bar/' );
  var expected = true;
  var got = _.path.isRelative( path );
  test.identical( got, expected );

  test.open( 'not refined' );

  test.case = '\\ in the beggining';
  var got = _.path.isRelative( '\\C:/foo/baz/bar' );
  test.identical( got, false );

  test.case = '\\ in the middle';
  var got = _.path.isRelative( 'C:/foo\\baz\\bar' );
  test.identical( got, false );

  test.case = '\\ in the end';
  var got = _.path.isRelative( 'C:/foo/baz/bar\\' );
  test.identical( got, false );

  test.close( 'not refined' );

  test.case = 'empty path'; /* */

  var path = '';
  var expected = true;
  var got = _.path.isRelative( path );
  test.identical( got, expected );

  var path = '.';
  var expected = true;
  var got = _.path.isRelative( path );
  test.identical( got, expected );

  var path = '/';
  var expected = false;
  var got = _.path.isRelative( path );
  test.identical( got, expected );

  var path = '///';
  var expected = false;
  var got = _.path.isRelative( path );
  test.identical( got, expected );

  var path = '/./.';
  var expected = false;
  var got = _.path.isRelative( path );
  test.identical( got, expected );

  var path = './.';
  var expected = true;
  var got = _.path.isRelative( path );
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRelative( ) );

  test.case = 'Two arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRelative( 'a', 'b' ) );

  // Input is not path

  test.case = 'No path - regexp';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRelative( /foo/ ) );

  test.case = 'No path - number';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRelative( 3 ) );

  test.case = 'No path - array';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRelative( [ '/C/', 'work/f' ] ) );

  test.case = 'No path - object';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRelative( { Path : 'C:/foo/baz/bar' } ) );

  test.case = 'No path - undefined';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRelative( undefined ) );

  test.case = 'No path - null';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRelative( null ) );

  test.case = 'No path - NaN';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRelative( NaN ) );

  // // Input is not Normalized
  //
  // test.case = '\\ in the beggining';
  // test.shouldThrowErrorOfAnyKind( () => _.path.isRelative( '\\C:/foo/baz/bar' ) );
  //
  // test.case = '\\ in the middle';
  // test.shouldThrowErrorOfAnyKind( () => _.path.isRelative( 'C:/foo\\baz\\bar' ) );
  //
  // test.case = '\\ in the end';
  // test.shouldThrowErrorOfAnyKind( () => _.path.isRelative( 'C:/foo/baz/bar\\' ) );

}

//

function isGlobal( test )
{

  // Not global paths

  test.case = 'Empty';

  var expected = false;
  var got = _.path.isGlobal( '' );
  test.identical( got, expected );

  var expected = false;
  var got = _.path.isGlobal( '/' );
  test.identical( got, expected );

  var expected = false;
  var got = _.path.isGlobal( '/.' );
  test.identical( got, expected );

  var expected = false;
  var got = _.path.isGlobal( '///' );
  test.identical( got, expected );

  var expected = false;
  var got = _.path.isGlobal( '.' );
  test.identical( got, expected );

  var expected = false;
  var got = _.path.isGlobal( '/./.' );
  test.identical( got, expected );

  var expected = false;
  var got = _.path.isGlobal( './.' );
  test.identical( got, expected );

  test.case = 'Relative path';
  var expected= false;
  var got = _.path.isGlobal( 'c/work/f/' );
  test.identical( got, expected );

  test.case = 'posix path';

  var path = '/foo/bar//baz/asdf/quux/..';
  var expected = false;
  var got = _.path.isGlobal( path );
  test.identical( got, expected );

  var path = 'foo/bar//baz/asdf/quux/..//.';
  var expected = false;
  var got = _.path.isGlobal( path );
  test.identical( got, expected );

  test.case = 'windows path'; /* */

  var path = 'c:/';
  var expected = false;
  var got = _.path.isGlobal( path );
  test.identical( got, expected );

  var path = 'C:/temp/foo';
  var expected = false;
  var got = _.path.isGlobal( path );
  test.identical( got, expected );

  test.case = 'windows path'; /* */
  var path = '/C:/temp/foo/bar/../';
  var expected = false;
  var got = _.path.isGlobal( path );
  test.identical( got, expected );

  // Global paths

  test.case = 'Empty';

  var got = _.path.isGlobal( '://' );
  var expected = true;
  test.identical( got, expected );

  var got = _.path.isGlobal( '/://' );
  var expected = true;
  test.identical( got, expected );

  var expected = true;
  var got = _.path.isGlobal( '.:///' );
  test.identical( got, expected );

  var expected = true;
  var got = _.path.isGlobal( '/.://./.' );
  test.identical( got, expected );

  var expected= true;
  var got = _.path.isGlobal( 'c/work/f/://' );
  test.identical( got, expected );

  var path = '/foo/bar/://baz/asdf/quux/..';
  var expected = true;
  var got = _.path.isGlobal( path );
  test.identical( got, expected );

  var path = '://foo/bar//baz/asdf/quux/..//.';
  var expected = true;
  var got = _.path.isGlobal( path );
  test.identical( got, expected );

  var path = '../abc/**#master';
  var expected = false;
  var got = _.path.isGlobal( path );
  test.identical( got, expected );

  var path = '../abc#master';
  var expected = false;
  var got = _.path.isGlobal( path );
  test.identical( got, expected );

  var path = '#master';
  var expected = false;
  var got = _.path.isGlobal( path );
  test.identical( got, expected );

  var path = '#';
  var expected = false;
  var got = _.path.isGlobal( path );
  test.identical( got, expected );

  test.case = 'windows path'; /* */

  var path = 'c://';
  var expected = true;
  var got = _.path.isGlobal( path );
  test.identical( got, expected );

  var path = 'C://temp/foo';
  var expected = true;
  var got = _.path.isGlobal( path );
  test.identical( got, expected );

  var path = '/C://temp/foo/bar/../';
  var expected = true;
  var got = _.path.isGlobal( path );
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.isGlobal( ) );

  test.case = 'Two arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.isGlobal( 'a', 'b' ) );

  // Input is not path

  test.case = 'No path - regexp';
  test.shouldThrowErrorOfAnyKind( () => _.path.isGlobal( /foo/ ) );

  test.case = 'No path - number';
  test.shouldThrowErrorOfAnyKind( () => _.path.isGlobal( 3 ) );

  test.case = 'No path - array';
  test.shouldThrowErrorOfAnyKind( () => _.path.isGlobal( [ '/C/', 'work/f' ] ) );

  test.case = 'No path - object';
  test.shouldThrowErrorOfAnyKind( () => _.path.isGlobal( { Path : 'C:/foo/baz/bar' } ) );

  test.case = 'No path - undefined';
  test.shouldThrowErrorOfAnyKind( () => _.path.isGlobal( undefined ) );

  test.case = 'No path - null';
  test.shouldThrowErrorOfAnyKind( () => _.path.isGlobal( null ) );

  test.case = 'No path - NaN';
  test.shouldThrowErrorOfAnyKind( () => _.path.isGlobal( NaN ) );

}

//

function isRoot( test )
{

  test.case = 'Is root';

  var path = '/';
  var got = _.path.isRoot( path );
  test.identical( got, true );

  var path = '/.';
  var got = _.path.isRoot( path );
  test.identical( got, true );

  var path = '/./';
  var got = _.path.isRoot( path );
  test.identical( got, true );

  var path = '/./.';
  var got = _.path.isRoot( path );
  test.identical( got, true );

  var path = '/x/..';
  var got = _.path.isRoot( path );
  test.identical( got, true );

  var path = '/x/y/../..';
  var got = _.path.isRoot( path );
  test.identical( got, true );

  test.case = 'Is not root';

  var path = '';
  var got = _.path.isRoot( path );
  test.identical( got, false );

  var path = '.';
  var got = _.path.isRoot( path );
  test.identical( got, false );

  var path = './';
  var got = _.path.isRoot( path );
  test.identical( got, false );

  var path = '/c';
  var got = _.path.isRoot( path );
  test.identical( got, false );

  var path = '/src/a1';
  var got = _.path.isRoot( path );
  test.identical( got, false );

  var path = 'c:/src/a1';
  var got = _.path.isRoot( path );
  test.identical( got, false );

  var path = '/C://src/a1';
  var got = _.path.isRoot( path );
  test.identical( got, false );

  var path = 'foo/bar//baz/asdf/quux/..//.';
  var got = _.path.isRoot( path );
  test.identical( got, false );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRoot( ) );

  test.case = 'Two arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRoot( 'a', 'b' ) );

  // Input is not path

  test.case = 'No path - regexp';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRoot( /foo/ ) );

  test.case = 'No path - number';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRoot( 3 ) );

  test.case = 'No path - array';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRoot( [ '/C/', 'work/f' ] ) );

  test.case = 'No path - object';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRoot( { Path : 'C:/foo/baz/bar' } ) );

  test.case = 'No path - undefined';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRoot( undefined ) );

  test.case = 'No path - null';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRoot( null ) );

  test.case = 'No path - NaN';
  test.shouldThrowErrorOfAnyKind( () => _.path.isRoot( NaN ) );

}

//

function isDotted( test )
{

  test.case = 'is single dotted';

  var path = '.';
  var got = _.path.isDotted( path );
  test.identical( got, true );

  var path = './';
  var got = _.path.isDotted( path );
  test.identical( got, true );

  var path = './..';
  var got = _.path.isDotted( path );
  test.identical( got, true );

  var path = './../';
  var got = _.path.isDotted( path );
  test.identical( got, true );

  var path = './.';
  var got = _.path.isDotted( path );
  test.identical( got, true );

  var path = '././';
  var got = _.path.isDotted( path );
  test.identical( got, true );

  var path = './x/..';
  var got = _.path.isDotted( path );
  test.identical( got, true );

  var path = './c';
  var got = _.path.isDotted( path );
  test.identical( got, true );

  var path = './src/a1';
  var got = _.path.isDotted( path );
  test.identical( got, true );

  var path = './C://src/a1';
  var got = _.path.isDotted( path );
  test.identical( got, true );

  test.case = 'is double dotted';

  var path = '..';
  var got = _.path.isDotted( path );
  test.identical( got, true );

  var path = '../';
  var got = _.path.isDotted( path );
  test.identical( got, true );

  var path = '../.';
  var got = _.path.isDotted( path );
  test.identical( got, true );

  var path = '../..';
  var got = _.path.isDotted( path );
  test.identical( got, true );

  var path = '../../';
  var got = _.path.isDotted( path );
  test.identical( got, true );

  var path = '../x/..';
  var got = _.path.isDotted( path );
  test.identical( got, true );

  var path = '../c';
  var got = _.path.isDotted( path );
  test.identical( got, true );

  var path = '../src/a1';
  var got = _.path.isDotted( path );
  test.identical( got, true );

  var path = '../C://src/a1';
  var got = _.path.isDotted( path );
  test.identical( got, true );

  test.case = 'is not dotted';

  var path = '';
  var got = _.path.isDotted( path );
  test.identical( got, false );

  var path = '/';
  var got = _.path.isDotted( path );
  test.identical( got, false );

  var path = '/./.';
  var got = _.path.isDotted( path );
  test.identical( got, false );

  var path = '/..';
  var got = _.path.isDotted( path );
  test.identical( got, false );

  var path = '/c';
  var got = _.path.isDotted( path );
  test.identical( got, false );

  var path = '/src/a1';
  var got = _.path.isDotted( path );
  test.identical( got, false );

  var path = 'c:/src/a1';
  var got = _.path.isDotted( path );
  test.identical( got, false );

  var path = '/C://src/a1';
  var got = _.path.isDotted( path );
  test.identical( got, false );

  var path = 'foo/bar//baz/asdf/quux/..//.';
  var got = _.path.isDotted( path );
  test.identical( got, false );

  var path = '.c:/src/a1';
  var got = _.path.isDotted( path );
  test.identical( got, false );

  var path = '.foo/bar';
  var got = _.path.isDotted( path );
  test.identical( got, false );

  var path = '.foo/bar//baz/asdf/quux/..//.';
  var got = _.path.isDotted( path );
  test.identical( got, false );

  var path = '..c:/src/a1';
  var got = _.path.isDotted( path );
  test.identical( got, false );

  var path = '..foo/bar';
  var got = _.path.isDotted( path );
  test.identical( got, false );

  var path = '..foo/bar//baz/asdf/quux/..//.';
  var got = _.path.isDotted( path );
  test.identical( got, false );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.isDotted( ) );

  test.case = 'Two arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.isDotted( 'a', 'b' ) );

  // Input is not path

  test.case = 'No path - regexp';
  test.shouldThrowErrorOfAnyKind( () => _.path.isDotted( /foo/ ) );

  test.case = 'No path - number';
  test.shouldThrowErrorOfAnyKind( () => _.path.isDotted( 3 ) );

  test.case = 'No path - array';
  test.shouldThrowErrorOfAnyKind( () => _.path.isDotted( [ '/C/', 'work/f' ] ) );

  test.case = 'No path - object';
  test.shouldThrowErrorOfAnyKind( () => _.path.isDotted( { Path : 'C:/foo/baz/bar' } ) );

  test.case = 'No path - undefined';
  test.shouldThrowErrorOfAnyKind( () => _.path.isDotted( undefined ) );

  test.case = 'No path - null';
  test.shouldThrowErrorOfAnyKind( () => _.path.isDotted( null ) );

  test.case = 'No path - NaN';
  test.shouldThrowErrorOfAnyKind( () => _.path.isDotted( NaN ) );

}

//

function isTrailed( test )
{

  test.case = 'Is trailed';

  var path = './';
  var got = _.path.isTrailed( path );
  test.identical( got, true );

  var path = '.././';
  var got = _.path.isTrailed( path );
  test.identical( got, true );

  var path = '/../';
  var got = _.path.isTrailed( path );
  test.identical( got, true );

  var path = '/c/';
  var got = _.path.isTrailed( path );
  test.identical( got, true );

  var path = 'src/a1/';
  var got = _.path.isTrailed( path );
  test.identical( got, true );

  var path = 'c:/src/a1/';
  var got = _.path.isTrailed( path );
  test.identical( got, true );

  var path = '/C://src/a1/';
  var got = _.path.isTrailed( path );
  test.identical( got, true );

  var path = 'foo/bar//baz/asdf/quux/..//./';
  var got = _.path.isTrailed( path );
  test.identical( got, true );

  test.case = 'Is not trailed';

  var path = '';
  var got = _.path.isTrailed( path );
  test.identical( got, false );

  var path = '/';
  var got = _.path.isTrailed( path );
  test.identical( got, false );

  var path = '.';
  var got = _.path.isTrailed( path );
  test.identical( got, false );

  var path = '/.';
  var got = _.path.isTrailed( path );
  test.identical( got, false );

  var path = './.';
  var got = _.path.isTrailed( path );
  test.identical( got, false );

  var path = '././..';
  var got = _.path.isTrailed( path );
  test.identical( got, false );

  var path = './x/..';
  var got = _.path.isTrailed( path );
  test.identical( got, false );

  var path = './c';
  var got = _.path.isTrailed( path );
  test.identical( got, false );

  var path = '.src/a1';
  var got = _.path.isTrailed( path );
  test.identical( got, false );

  var path = '.c:/src/a1';
  var got = _.path.isTrailed( path );
  test.identical( got, false );

  var path = './C://src/a1';
  var got = _.path.isTrailed( path );
  test.identical( got, false );

  var path = '.foo/bar//baz/asdf/quux/..//.';
  var got = _.path.isTrailed( path );
  test.identical( got, false );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.isTrailed( ) );

  test.case = 'Two arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.isTrailed( 'a', 'b' ) );

  // Input is not path

  test.case = 'No path - regexp';
  test.shouldThrowErrorOfAnyKind( () => _.path.isTrailed( /foo/ ) );

  test.case = 'No path - number';
  test.shouldThrowErrorOfAnyKind( () => _.path.isTrailed( 3 ) );

  test.case = 'No path - array';
  test.shouldThrowErrorOfAnyKind( () => _.path.isTrailed( [ '/C/', 'work/f' ] ) );

  test.case = 'No path - object';
  test.shouldThrowErrorOfAnyKind( () => _.path.isTrailed( { Path : 'C:/foo/baz/bar' } ) );

  test.case = 'No path - undefined';
  test.shouldThrowErrorOfAnyKind( () => _.path.isTrailed( undefined ) );

  test.case = 'No path - null';
  test.shouldThrowErrorOfAnyKind( () => _.path.isTrailed( null ) );

  test.case = 'No path - NaN';
  test.shouldThrowErrorOfAnyKind( () => _.path.isTrailed( NaN ) );

}

//

function isGlob( test )
{

  test.case = 'this is not glob';

  test.true( !_.path.isGlob( '!a.js' ) );
  test.true( !_.path.isGlob( '^a.js' ) );
  test.true( !_.path.isGlob( '+a.js' ) );
  test.true( !_.path.isGlob( '!' ) );
  test.true( !_.path.isGlob( '^' ) );
  test.true( !_.path.isGlob( '+' ) );

  /**/

  test.case = 'this is glob';

  test.true( _.path.isGlob( '?' ) );
  test.true( _.path.isGlob( '*' ) );
  test.true( _.path.isGlob( '**' ) );

  test.true( _.path.isGlob( '?c.js' ) );
  test.true( _.path.isGlob( '*.js' ) );
  test.true( _.path.isGlob( '**/a.js' ) );

  test.true( _.path.isGlob( 'dir?c/a.js' ) );
  test.true( _.path.isGlob( 'dir/*.js' ) );
  test.true( _.path.isGlob( 'dir/**.js' ) );
  test.true( _.path.isGlob( 'dir/**/a.js' ) );

  test.true( _.path.isGlob( '/dir?c/a.js' ) );
  test.true( _.path.isGlob( '/dir/*.js' ) );
  test.true( _.path.isGlob( '/dir/**.js' ) );
  test.true( _.path.isGlob( '/dir/**/a.js' ) );

  test.true( _.path.isGlob( '[a-c]' ) );
  test.true( _.path.isGlob( '{a,c}' ) );
  test.true( _.path.isGlob( '(a|b)' ) );

  test.true( _.path.isGlob( '(ab)' ) );
  test.true( _.path.isGlob( '@(ab)' ) );
  test.true( _.path.isGlob( '!(ab)' ) );
  test.true( _.path.isGlob( '?(ab)' ) );
  test.true( _.path.isGlob( '*(ab)' ) );
  test.true( _.path.isGlob( '+(ab)' ) );

  test.true( _.path.isGlob( 'dir/[a-c].js' ) );
  test.true( _.path.isGlob( 'dir/{a,c}.js' ) );
  test.true( _.path.isGlob( 'dir/(a|b).js' ) );

  test.true( _.path.isGlob( 'dir/(ab).js' ) );
  test.true( _.path.isGlob( 'dir/@(ab).js' ) );
  test.true( _.path.isGlob( 'dir/!(ab).js' ) );
  test.true( _.path.isGlob( 'dir/?(ab).js' ) );
  test.true( _.path.isGlob( 'dir/*(ab).js' ) );
  test.true( _.path.isGlob( 'dir/+(ab).js' ) );

  test.true( _.path.isGlob( '/index/**' ) );

}

//

function begins( test )
{

  test.case = 'Same string';

  var got = _.path.begins( 'a', 'a' );
  test.identical( got, true );

  var got = _.path.begins( 'c:/', 'c:/' );
  test.identical( got, true );

  var got = _.path.begins( 'this/is/some/path', 'this/is/some/path' );
  test.identical( got, true );

  var got = _.path.begins( '/this/is/some/path', '/this/is/some/path' );
  test.identical( got, true );

  test.case = 'Begins';

  var got = _.path.begins( 'a/', 'a' );
  test.identical( got, true );

  var got = _.path.begins( 'a/b', 'a' );
  test.identical( got, true );

  var got = _.path.begins( 'this/is/some/path', 'this/is' );
  test.identical( got, true );

  var got = _.path.begins( '/this/is/some/path', '/this/is' );
  test.identical( got, true );

  var got = _.path.begins( '.src/a1', '.src' );
  test.identical( got, true );

  var got = _.path.begins( '.src/a1', '.src/' );
  test.identical( got, true );

  var got = _.path.begins( 'c:/src/a1', 'c:' );
  test.identical( got, true );

  var got = _.path.begins( '/C://src/a1', '/C:' );
  test.identical( got, true );

  var got = _.path.begins( 'foo/bar//baz/asdf/quux/..//.', 'foo' );
  test.identical( got, true );

  var got = _.path.begins( 'foo/bar//baz/asdf/quux/..//.', 'foo/' );
  test.identical( got, true );

  test.case = 'Doesn´t begin';

  var got = _.path.begins( 'ab', 'a' );
  test.identical( got, false );

  var got = _.path.begins( 'a/b', 'b' );
  test.identical( got, false );

  var got = _.path.begins( 'this/is/some/path', '/this/is' );
  test.identical( got, false );

  var got = _.path.begins( 'this/is/some/path', '/this/is/some/path' );
  test.identical( got, false );

  var got = _.path.begins( '/this/is/some/path', 'this/is' );
  test.identical( got, false );

  var got = _.path.begins( '/this/is/some/path', 'this/is/some/path' );
  test.identical( got, false );

  var got = _.path.begins( '/this/is/some/pathpath', '/this/is/some/path' );
  test.identical( got, false );

  var got = _.path.begins( '/this/is/some/path', '/this/is/some/pathpath' );
  test.identical( got, false );

  var got = _.path.begins( 'c:/src/a1', '/c:' );
  test.identical( got, false );

  var got = _.path.begins( '/C://src/a1', 'C:' );
  test.identical( got, false );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.begins( ) );

  test.case = 'One argument';
  test.shouldThrowErrorOfAnyKind( () => _.path.begins( 'a' ) );

  test.case = 'Three arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.begins( 'a', 'b', 'c' ) );

  // Input is not path

  test.case = 'No path - regexp';
  test.shouldThrowErrorOfAnyKind( () => _.path.begins( /foo/, /foo/ ) );

  test.case = 'No path - array';
  test.shouldThrowErrorOfAnyKind( () => _.path.begins( [ ], [ ] ) );

  test.case = 'No path - number';
  test.shouldThrowErrorOfAnyKind( () => _.path.begins( 3, 3 ) );

  test.case = 'No path - object';
  test.shouldThrowErrorOfAnyKind( () => _.path.begins( { Path : 'C:/' }, { Path : 'C:/' } ) );

  test.case = 'No path - undefined';
  test.shouldThrowErrorOfAnyKind( () => _.path.begins( undefined ) );

  test.case = 'No path - null';
  test.shouldThrowErrorOfAnyKind( () => _.path.begins( null ) );

  test.case = 'No path - null';
  test.shouldThrowErrorOfAnyKind( () => _.path.begins( null, null ) );

  test.case = 'No path - NaN';
  test.shouldThrowErrorOfAnyKind( () => _.path.begins( NaN ) );

  test.case = 'No path - NaN';
  test.shouldThrowErrorOfAnyKind( () => _.path.begins( NaN, NaN ) );

}

//

function ends( test )
{

  test.case = 'Doesn´t End';

  var got = _.path.ends( 'a/b', 'a' );
  test.identical( got, false );

  var got = _.path.ends( 'a/b', '/b' );
  test.identical( got, false );

  var got = _.path.ends( 'this/is/some/path', '/some/path' );
  test.identical( got, false );

  var got = _.path.ends( '/this/is/some/path', '/some/path' );
  test.identical( got, false );

  var got = _.path.ends( 'this/is/some/path', 'this/is' );
  test.identical( got, false );

  var got = _.path.ends( 'this/is/some/pathpath', 'path' );
  test.identical( got, false );

  var got = _.path.ends( 'this/is/some/path', '/this/is/some/path' );
  test.identical( got, false );

  var got = _.path.ends( '.src/a1', '.a1' );
  test.identical( got, false );

  var got = _.path.ends( '.src/a1', '/a1' );
  test.identical( got, false );

  var got = _.path.ends( 'c:/src/a1', '/src/a1' );
  test.identical( got, false );

  var got = _.path.ends( 'c:/src/_a1', 'a1' );
  test.identical( got, false );

  var got = _.path.ends( 'foo/bar//baz/asdf/quux/..//.', 'quux' );
  test.identical( got, false );

  var got = _.path.ends( 'foo/bar//baz/asdf/quux/..', 'asdf' );
  test.identical( got, false );

  var got = _.path.ends( 'foo/bar//baz/asdf/quux/..', '/..' );
  test.identical( got, false );

  //

  test.case = 'Ends';

  var got = _.path.ends( 'a', 'a' );
  test.identical( got, true );

  var got = _.path.ends( '/a', './a' );
  test.identical( got, true );

  var got = _.path.ends( '.a', 'a' );
  test.identical( got, true );

  var got = _.path.ends( '/C://src/a1/', 'a1/' );
  test.identical( got, true );

  var got = _.path.ends( 'this/is/some/path', 'path' );
  test.identical( got, true );

  var got = _.path.ends( 'this/is/some/path', './path' );
  test.identical( got, true );

  var got = _.path.ends( 'this/is/some/path', 'some/path' );
  test.identical( got, true );

  var got = _.path.ends( 'this/is/some/path', 'is/some/path' );
  test.identical( got, true );

  var got = _.path.ends( 'this/is/some/path', 'this/is/some/path' );
  test.identical( got, true );

  var got = _.path.ends( '/this/is/some/path', 'some/path' );
  test.identical( got, true );

  var got = _.path.ends( '/this/is/some/path', './some/path' );
  test.identical( got, true );

  var got = _.path.ends( '/this/is/some/path', 'this/is/some/path' );
  test.identical( got, true );

  var got = _.path.ends( '/this/is/some/path', '/this/is/some/path' );
  test.identical( got, true );

  var got = _.path.ends( 'c:/file.src_a1', 'src_a1' );
  test.identical( got, true );

  var got = _.path.ends( 'c:/file/src/_a1', '_a1' );
  test.identical( got, true );

  var got = _.path.ends( 'c:/file/src._a1', '_a1' );
  test.identical( got, true );

  var got = _.path.ends( 'foo/bar//baz/asdf/quux/..//.', './/.' );
  test.identical( got, true );

  var got = _.path.ends( 'foo/bar//baz/asdf/quux/..//.', '/.' );
  test.identical( got, true );

  var got = _.path.ends( 'foo/bar//baz/asdf/quux/..//.', '.' );
  test.identical( got, true );

  var got = _.path.ends( 'foo/bar//baz/asdf/quux/...', '.' );
  test.identical( got, true );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.ends( ) );

  test.case = 'One argument';
  test.shouldThrowErrorOfAnyKind( () => _.path.ends( 'a' ) );

  test.case = 'Three arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.ends( 'a', 'b', 'c' ) );

  // Input is not path

  test.case = 'No path - regexp';
  test.shouldThrowErrorOfAnyKind( () => _.path.ends( /foo/, /foo/ ) );

  test.case = 'No path - array';
  test.shouldThrowErrorOfAnyKind( () => _.path.ends( [ ], [ ] ) );

  test.case = 'No path - object';
  test.shouldThrowErrorOfAnyKind( () => _.path.ends( { Path : 'C:/' }, { Path : 'C:/' } ) );

  test.case = 'No path - undefined';
  test.shouldThrowErrorOfAnyKind( () => _.path.ends( undefined ) );

  test.case = 'No path - undefined';
  test.shouldThrowErrorOfAnyKind( () => _.path.ends( undefined, undefined ) );

  test.case = 'No path - null';
  test.shouldThrowErrorOfAnyKind( () => _.path.ends( null ) );

  test.case = 'No path - null';
  test.shouldThrowErrorOfAnyKind( () => _.path.ends( null, null ) );

  test.case = 'No path - NaN';
  test.shouldThrowErrorOfAnyKind( () => _.path.ends( NaN ) );

  test.case = 'No path - NaN';
  test.shouldThrowErrorOfAnyKind( () => _.path.ends( NaN, NaN ) );
}

//

function refine( test )
{

  test.case = 'posix path'; /* */

  var path = '/foo/bar//baz/asdf/quux/..';
  var expected = '/foo/bar//baz/asdf/quux/..';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '/foo/bar//baz/asdf/quux/../';
  var expected = '/foo/bar//baz/asdf/quux/../';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '//foo/bar//baz/asdf/quux/..//';
  var expected = '//foo/bar//baz/asdf/quux/..//';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'foo/bar//baz/asdf/quux/..//.';
  var expected = 'foo/bar//baz/asdf/quux/..//.';
  var got = _.path.refine( path );
  test.identical( got, expected );

  test.case = 'winoows path'; /* */

  var path = 'C:\\\\';
  var expected = '/C//';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'C:\\';
  var expected = '/C';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'C:';
  var expected = '/C';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\';
  var expected = '/C/temp//foo/bar/../';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\\\';
  var expected = '/C/temp//foo/bar/..//';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\\\';
  var expected = '/C/temp//foo/bar/..//';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..';
  var expected = '/C/temp//foo/bar/../..';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..\\';
  var expected = '/C/temp//foo/bar/../../';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..\\.';
  var expected = '/C/temp//foo/bar/../../.';
  var got = _.path.refine( path );
  test.identical( got, expected );

  test.case = 'empty path';
  var path = '';
  var expected = '';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '/';
  var expected = '/';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '\\';
  var expected = '/';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '\\\\';
  var expected = '//';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '\/';
  var expected = '/';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '//';
  var expected = '//';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '///';
  var expected = '///';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '/.';
  var expected = '/.';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '/./.';
  var expected = '/./.';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '.';
  var expected = '.';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = './.';
  var expected = './.';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '././';
  var expected = '././';
  var got = _.path.refine( path );
  test.identical( got, expected );

  test.case = 'path with "." in the middle'; /* */

  var path = 'foo/./bar/baz';
  var expected = 'foo/./bar/baz';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'foo/././bar/baz/';
  var expected = 'foo/././bar/baz/';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'foo/././bar/././baz/';
  var expected = 'foo/././bar/././baz/';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '/foo/././bar/././baz/';
  var expected = '/foo/././bar/././baz/';
  var got = _.path.refine( path );
  test.identical( got, expected );

  test.case = 'path with "." in the beginning'; /* */

  var path = './foo/bar';
  var expected = './foo/bar';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '././foo/bar/';
  var expected = '././foo/bar/';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = './/.//foo/bar/';
  var expected = './/.//foo/bar/';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '/.//.//foo/bar/';
  var expected = '/.//.//foo/bar/';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '.x/foo/bar';
  var expected = '.x/foo/bar';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '.x./foo/bar';
  var expected = '.x./foo/bar';
  var got = _.path.refine( path );
  test.identical( got, expected );

  test.case = 'path with "." in the end'; /* */

  var path = 'foo/bar.';
  var expected = 'foo/bar.';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'foo/.bar.';
  var expected = 'foo/.bar.';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'foo/bar/.';
  var expected = 'foo/bar/.';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'foo/bar/./.';
  var expected = 'foo/bar/./.';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'foo/bar/././';
  var expected = 'foo/bar/././';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '/foo/bar/././';
  var expected = '/foo/bar/././';
  var got = _.path.refine( path );
  test.identical( got, expected );

  test.case = 'path with ".." in the middle'; /* */

  var path = 'foo/../bar/baz';
  var expected = 'foo/../bar/baz';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'foo/../../bar/baz/';
  var expected = 'foo/../../bar/baz/';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'foo/../../bar/../../baz/';
  var expected = 'foo/../../bar/../../baz/';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '/foo/../../bar/../../baz/';
  var expected = '/foo/../../bar/../../baz/';
  var got = _.path.refine( path );
  test.identical( got, expected );

  test.case = 'path with ".." in the beginning'; /* */

  var path = '../foo/bar';
  var expected = '../foo/bar';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '../../foo/bar/';
  var expected = '../../foo/bar/';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '..//..//foo/bar/';
  var expected = '..//..//foo/bar/';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '/..//..//foo/bar/';
  var expected = '/..//..//foo/bar/';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '..x/foo/bar';
  var expected = '..x/foo/bar';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '..x../foo/bar';
  var expected = '..x../foo/bar';
  var got = _.path.refine( path );
  test.identical( got, expected );

  test.case = 'path with ".." in the end'; /* */

  var path = 'foo/bar..';
  var expected = 'foo/bar..';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'foo/..bar..';
  var expected = 'foo/..bar..';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'foo/bar/..';
  var expected = 'foo/bar/..';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'foo/bar/../..';
  var expected = 'foo/bar/../..';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'foo/bar/../../';
  var expected = 'foo/bar/../../';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '/foo/bar/../../';
  var expected = '/foo/bar/../../';
  var got = _.path.refine( path );
  test.identical( got, expected );

  test.case = 'path with \\'; /* */

  var path = 'foo/bar\\';
  var expected = 'foo/bar/';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'foo/\\bar\\';
  var expected = 'foo//bar/';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '\\foo/bar/..';
  var expected = '/foo/bar/..';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '\\foo\\bar/../..';
  var expected = '/foo/bar/../..';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '\\foo\\bar/../../';
  var expected = '/foo/bar/../../';
  var got = _.path.refine( path );
  test.identical( got, expected );

  test.case = 'path with \/'; /* */

  var path = 'foo/bar\/';
  var expected = 'foo/bar/';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = 'foo/\/bar\/';
  var expected = 'foo//bar/';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '\/foo/bar/..';
  var expected = '/foo/bar/..';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '\/foo\/bar/../..';
  var expected = '/foo/bar/../..';
  var got = _.path.refine( path );
  test.identical( got, expected );

  var path = '\/foo\/bar/../../';
  var expected = '/foo/bar/../../';
  var got = _.path.refine( path );
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.refine( ) );

  test.case = 'Two arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.refine( 'a', 'b' ) );

  test.case = 'No path - regexp';
  test.shouldThrowErrorOfAnyKind( () => _.path.refine( /foo/ ) );

  test.case = 'No path - number';
  test.shouldThrowErrorOfAnyKind( () => _.path.refine( 3 ) );

  test.case = 'No path - array';
  test.shouldThrowErrorOfAnyKind( () => _.path.refine( [ '/C/', 'work/f' ] ) );

  test.case = 'No path - object';
  test.shouldThrowErrorOfAnyKind( () => _.path.refine( { Path : 'C:/foo/baz/bar' } ) );

  test.case = 'No path - undefined';
  test.shouldThrowErrorOfAnyKind( () => _.path.refine( undefined ) );

  test.case = 'No path - null';
  test.shouldThrowErrorOfAnyKind( () => _.path.refine( null ) );

  test.case = 'No path - NaN';
  test.shouldThrowErrorOfAnyKind( () => _.path.refine( NaN ) );

}

//

function normalize( test )
{

  test.case = 'posix path'; /* */

  var path = 'a/foo/../b';
  var expected = 'a/b';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/aa/bb/cc/./';
  var expected = '/aa/bb/cc/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/c/temp/x/foo/../';
  var expected = '/c/temp/x/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/c/temp//foo/../';
  var expected = '/c/temp//';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/c/temp//foo/bar/../..';
  var expected = '/c/temp/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/c/temp//foo/bar/../../';
  var expected = '/c/temp//';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/c/temp//foo/bar/../../.';
  var expected = '/c/temp/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '//b/x/c/../d/..e';
  var expected = '//b/x/d/..e';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '//b//c/../d/..e';
  var expected = '//b//d/..e';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '//b//././c/../d/..e';
  var expected = '//b//d/..e';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/aa/bb/cc/';
  var expected = '/aa/bb/cc/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/foo/bar//baz/asdf/quux/..';
  var expected = '/foo/bar//baz/asdf';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/foo/bar//baz/asdf/quux/.';
  var expected = '/foo/bar//baz/asdf/quux';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/foo/bar//baz/asdf/quux/./';
  var expected = '/foo/bar//baz/asdf/quux/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/foo/bar//baz/asdf/quux/../';
  var expected = '/foo/bar//baz/asdf/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '//foo/bar//baz/asdf/quux/..//';
  var expected = '//foo/bar//baz/asdf//';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'foo/bar//baz/asdf/quux/..//.';
  var expected = 'foo/bar//baz/asdf/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  test.case = 'windows path'; /* */

  var path = '/C:\\temp\\\\foo\\bar\\..\\';
  var expected = '/C:/temp//foo/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '\\C:\\temp\\\\foo\\bar\\..\\';
  var expected = '/C:/temp//foo/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\';
  var expected = '/C/temp//foo/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\\\';
  var expected = '/C/temp//foo//';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\\\';
  var expected = '/C/temp//foo//';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..';
  var expected = '/C/temp/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..\\';
  var expected = '/C/temp//';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..\\.';
  var expected = '/C/temp/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  test.case = 'empty path'; /* */

  var path = '';
  var expected = '';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/';
  var expected = '/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '//';
  var expected = '//';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '///';
  var expected = '///';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/.';
  var expected = '/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/./.';
  var expected = '/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '.';
  var expected = '.';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = './';
  var expected = './';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = './.';
  var expected = '.';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  test.case = 'path with "." in the middle'; /* */

  var path = 'foo/./bar/baz';
  var expected = 'foo/bar/baz';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'foo/././bar/baz/';
  var expected = 'foo/bar/baz/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'foo/././bar/././baz/';
  var expected = 'foo/bar/baz/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/foo/././bar/././baz/';
  var expected = '/foo/bar/baz/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/foo/.x./baz/';
  var expected = '/foo/.x./baz/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  test.case = 'path with "." in the beginning'; /* */

  var path = './foo/bar';
  var expected = './foo/bar';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '.\\foo\\bar';
  var expected = './foo/bar';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '././foo/bar/';
  var expected = './foo/bar/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = './/.//foo/bar/';
  var expected = './//foo/bar/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/.//.//foo/bar/';
  var expected = '///foo/bar/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '.x/foo/bar';
  var expected = '.x/foo/bar';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '.x./foo/bar';
  var expected = '.x./foo/bar';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = './x/.';
  var expected = './x';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  test.case = 'path with "." in the end'; /* */

  var path = 'foo/bar.';
  var expected = 'foo/bar.';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'foo/.bar.';
  var expected = 'foo/.bar.';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'foo/bar/.';
  var expected = 'foo/bar';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'foo/bar/./.';
  var expected = 'foo/bar';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'foo/bar/././';
  var expected = 'foo/bar/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/foo/bar/././';
  var expected = '/foo/bar/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/foo/baz/.x./';
  var expected = '/foo/baz/.x./';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  test.case = 'path with ".." in the middle'; /* */

  var path = 'foo/../bar/baz';
  var expected = 'bar/baz';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'foo/../../bar/baz/';
  var expected = '../bar/baz/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '../../baz';
  var expected = '../../baz';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/../../baz';
  var expected = '/../../baz';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/../../baz/';
  var expected = '/../../baz/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'foo/../../bar/../../baz/';
  var expected = '../../baz/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/foo/../../bar';
  var expected = '/../bar';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/../..x/baz/';
  var expected = '/../..x/baz/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/../x../baz/';
  var expected = '/../x../baz/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/x../../baz/';
  var expected = '/baz/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/..x/../baz/';
  var expected = '/baz/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/foo/../../bar/../../baz/';
  var expected = '/../../baz/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  test.case = 'path with ".." in the beginning'; /* */

  var path = '../foo/bar';
  var expected = '../foo/bar';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '../../foo/bar/';
  var expected = '../../foo/bar/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '..//..//foo/bar/';
  var expected = '..//foo/bar/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/../foo/bar';
  var expected = '/../foo/bar';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/x//../foo/bar';
  var expected = '/x/foo/bar';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/..//../foo/bar/';
  var expected = '/../foo/bar/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/..//..//foo/bar/';
  var expected = '/..//foo/bar/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '..x/foo/bar';
  var expected = '..x/foo/bar';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '..x../foo/bar';
  var expected = '..x../foo/bar';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  test.case = 'path with ".." in the end'; /* */

  var path = 'foo/bar..';
  var expected = 'foo/bar..';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'foo/..bar..';
  var expected = 'foo/..bar..';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'foo/bar/..';
  var expected = 'foo';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'foo/bar/../..';
  var expected = '.';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'foo/bar/../../';
  var expected = './';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/foo/../';
  var expected = '/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/foo/bar/../../';
  var expected = '/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'foo/bar/../../..';
  var expected = '..';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'foo/bar/../../../..';
  var expected = '../..';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'foo/../bar/../../../..';
  var expected = '../../..';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  test.case = 'path with ".." and "." combined'; /* */

  var path = '/abc/./../a/b';
  var expected = '/a/b';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/abc/.././a/b';
  var expected = '/a/b';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/abc/./.././a/b';
  var expected = '/a/b';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/a/b/abc/../.';
  var expected = '/a/b';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/a/b/abc/./..';
  var expected = '/a/b';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '/a/b/abc/./../.';
  var expected = '/a/b';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = './../.';
  var expected = '..';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = './.././';
  var expected = '../';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = './..';
  var expected = '..';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '../.';
  var expected = '..';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  test.case = 'path with \/'; /* */

  var path = 'foo/bar\/';
  var expected = 'foo/bar/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = 'foo/\/bar\/';
  var expected = 'foo//bar/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '\/foo/bar/..';
  var expected = '/foo';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '\/foo\/bar/../..';
  var expected = '/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  var path = '\/foo\/bar/../../';
  var expected = '/';
  var got = _.path.normalize( path );
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.normalize( ) );

  test.case = 'Two arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.normalize( 'a', 'b' ) );

  // Input is not path

  test.case = 'No path - regexp';
  test.shouldThrowErrorOfAnyKind( () => _.path.normalize( /foo/ ) );

  test.case = 'No path - number';
  test.shouldThrowErrorOfAnyKind( () => _.path.normalize( 3 ) );

  test.case = 'No path - array';
  test.shouldThrowErrorOfAnyKind( () => _.path.normalize( [ '/C/', 'work/f' ] ) );

  test.case = 'No path - object';
  test.shouldThrowErrorOfAnyKind( () => _.path.normalize( { Path : 'C:/foo/baz/bar' } ) );

  test.case = 'No path - undefined';
  test.shouldThrowErrorOfAnyKind( () => _.path.normalize( undefined ) );

  test.case = 'No path - null';
  test.shouldThrowErrorOfAnyKind( () => _.path.normalize( null ) );

  test.case = 'No path - NaN';
  test.shouldThrowErrorOfAnyKind( () => _.path.normalize( NaN ) );

}

//

function normalizeTolerant( test )
{

  test.case = 'posix path'; /* */

  var path = '/aa/bb/cc/./';
  var expected = '/aa/bb/cc/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '//b//././c/../d/..e';
  var expected = '/b/d/..e';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '/aa/bb/cc/';
  var expected = '/aa/bb/cc/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '/foo/bar//baz/asdf/quux/..';
  var expected = '/foo/bar/baz/asdf';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '/foo/bar//baz/asdf/quux/.';
  var expected = '/foo/bar/baz/asdf/quux';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '/foo/bar//baz/asdf/quux/./';
  var expected = '/foo/bar/baz/asdf/quux/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '/foo/bar//baz/asdf/quux/../';
  var expected = '/foo/bar/baz/asdf/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '//foo/bar//baz/asdf/quux/..//';
  var expected = '/foo/bar/baz/asdf/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/bar//baz/asdf/quux/..//.';
  var expected = 'foo/bar/baz/asdf';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  test.case = 'winoows path'; /* */

  var path = 'C:\\temp\\\\foo\\bar\\..\\';
  var expected = '/C/temp/foo/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\\\';
  var expected = '/C/temp/foo/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\\\';
  var expected = '/C/temp/foo/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..';
  var expected = '/C/temp';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..\\';
  var expected = '/C/temp/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..\\.';
  var expected = '/C/temp';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  test.case = 'empty path'; /* */

  var path = '';
  var expected = '';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '/';
  var expected = '/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '//';
  var expected = '/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '///';
  var expected = '/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '/.';
  var expected = '/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '/./.';
  var expected = '/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '.';
  var expected = '.';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = './.';
  var expected = '.';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = './';
  var expected = './';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  test.case = 'path with "." in the middle'; /* */

  var path = 'foo/./bar/baz';
  var expected = 'foo/bar/baz';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/././bar/baz/';
  var expected = 'foo/bar/baz/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/././bar/././baz/';
  var expected = 'foo/bar/baz/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '/foo/././bar/././baz/';
  var expected = '/foo/bar/baz/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '/foo/.x./baz/';
  var expected = '/foo/.x./baz/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  test.case = 'path with "." in the beginning'; /* */

  var path = './foo/bar';
  var expected = './foo/bar';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '././foo/bar/';
  var expected = './foo/bar/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = './/.//foo/bar/';
  var expected = './foo/bar/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '/.//.//foo/bar/';
  var expected = '/foo/bar/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '.x/foo/bar';
  var expected = '.x/foo/bar';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '.x./foo/bar';
  var expected = '.x./foo/bar';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = './x/.';
  var expected = './x';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  test.case = 'path with "." in the end'; /* */

  var path = 'foo/bar.';
  var expected = 'foo/bar.';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/.bar.';
  var expected = 'foo/.bar.';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/bar/.';
  var expected = 'foo/bar';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/bar/./.';
  var expected = 'foo/bar';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/bar/././';
  var expected = 'foo/bar/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '/foo/bar/././';
  var expected = '/foo/bar/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '/foo/baz/.x./';
  var expected = '/foo/baz/.x./';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  test.case = 'path with ".." in the middle'; /* */

  var path = 'foo/../bar/baz';
  var expected = 'bar/baz';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/../../bar/baz/';
  var expected = '../bar/baz/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/../../bar/../../baz/';
  var expected = '../../baz/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '/foo/../../bar/../../baz/';
  var expected = '/../../baz/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  test.case = 'path with ".." in the beginning'; /* */

  var path = '../foo/bar';
  var expected = '../foo/bar';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '../../foo/bar/';
  var expected = '../../foo/bar/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '..//..//foo/bar/';
  var expected = '../../foo/bar/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '/..//..//foo/bar/';
  var expected = '/../../foo/bar/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '..x/foo/bar';
  var expected = '..x/foo/bar';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '..x../foo/bar';
  var expected = '..x../foo/bar';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  test.case = 'path with ".." in the end'; /* */

  var path = 'foo/bar..';
  var expected = 'foo/bar..';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/..bar..';
  var expected = 'foo/..bar..';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/bar/..';
  var expected = 'foo';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/bar/../../';
  var expected = './';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/bar/../..';
  var expected = '.';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '/foo/bar/../../';
  var expected = '/';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/bar/../../..';
  var expected = '..';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/bar/../../../..';
  var expected = '../..';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/../bar/../../../..';
  var expected = '../../..';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  test.case = 'path with ".." and "." combined'; /* */

  var path = '/abc/./../a/b';
  var expected = '/a/b';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '/abc/.././a/b';
  var expected = '/a/b';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '/abc/./.././a/b';
  var expected = '/a/b';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '/a/b/abc/../.';
  var expected = '/a/b';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '/a/b/abc/./..';
  var expected = '/a/b';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '/a/b/abc/./../.';
  var expected = '/a/b';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = './../.';
  var expected = '..';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = './.././';
  var expected = '../';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = './..';
  var expected = '..';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '../.';
  var expected = '..';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

  var path = '.././';
  var expected = '../';
  var got = _.path.normalizeTolerant( path );
  test.identical( got, expected );

}

//

function canonize( test )
{

  var path = 'a/foo/../b';
  var expected = 'a/b';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  test.case = 'posix path'; /* */

  var path = '/aa/bb/cc/./';
  var expected = '/aa/bb/cc';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '//b//././c/../d/..e';
  var expected = '//b//d/..e';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '/aa/bb/cc/';
  var expected = '/aa/bb/cc';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '/foo/bar//baz/asdf/quux/..';
  var expected = '/foo/bar//baz/asdf';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '/foo/bar//baz/asdf/quux/.';
  var expected = '/foo/bar//baz/asdf/quux';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '/foo/bar//baz/asdf/quux/./';
  var expected = '/foo/bar//baz/asdf/quux';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '/foo/bar//baz/asdf/quux/../';
  var expected = '/foo/bar//baz/asdf';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '//foo/bar//baz/asdf/quux/..//';
  var expected = '//foo/bar//baz/asdf//';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'foo/bar//baz/asdf/quux/.';
  var expected = 'foo/bar//baz/asdf/quux';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'foo/bar//baz/asdf/quux/..//.';
  var expected = 'foo/bar//baz/asdf';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  test.case = 'windows path'; /* */

  var path = '/C:\\temp\\\\foo\\bar\\..\\';
  var expected = '/C:/temp//foo';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '\\C:\\temp\\\\foo\\bar\\..\\';
  var expected = '/C:/temp//foo';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\';
  var expected = '/C/temp//foo';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\\\';
  var expected = '/C/temp//foo//';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\\\';
  var expected = '/C/temp//foo//';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..';
  var expected = '/C/temp';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..';
  var expected = '/C/temp';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..\\';
  var expected = '/C/temp';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..\\.';
  var expected = '/C/temp';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  test.case = 'empty path'; /* */

  var path = '';
  var expected = '';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '/';
  var expected = '/';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '//';
  var expected = '//';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '///';
  var expected = '///';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '/.';
  var expected = '/';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '/./.';
  var expected = '/';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '.';
  var expected = '.';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = './';
  var expected = '.';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = './.';
  var expected = '.';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  test.case = 'path with "." in the middle'; /* */

  var path = 'foo/./bar/baz';
  var expected = 'foo/bar/baz';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'foo/././bar/baz/';
  var expected = 'foo/bar/baz';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'foo/././bar/././baz/';
  var expected = 'foo/bar/baz';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '/foo/././bar/././baz/';
  var expected = '/foo/bar/baz';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '/foo/.x./baz/';
  var expected = '/foo/.x./baz';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  test.case = 'path with "." in the beginning'; /* */

  var path = './foo/bar';
  var expected = 'foo/bar';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '././foo/bar/';
  var expected = 'foo/bar';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = './././foo/bar/';
  var expected = 'foo/bar';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '.\\foo\\bar';
  var expected = 'foo/bar';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = './/.//foo/bar/';
  var expected = './//foo/bar';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '/.//.//foo/bar/';
  var expected = '///foo/bar';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '.x/foo/bar';
  var expected = '.x/foo/bar';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '.x./foo/bar';
  var expected = '.x./foo/bar';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = './x/.';
  var expected = 'x';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  test.case = 'path with "." in the end'; /* */

  var path = 'foo/bar.';
  var expected = 'foo/bar.';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'foo/.bar.';
  var expected = 'foo/.bar.';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'foo/bar/.';
  var expected = 'foo/bar';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'foo/bar/./.';
  var expected = 'foo/bar';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'foo/bar/././';
  var expected = 'foo/bar';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '/foo/bar/././';
  var expected = '/foo/bar';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '/foo/baz/.x./';
  var expected = '/foo/baz/.x.';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  test.case = 'path with ".." in the middle'; /* */

  var path = 'foo/../bar/baz';
  var expected = 'bar/baz';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'foo/../../bar/baz/';
  var expected = '../bar/baz';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'foo/../../bar/../../baz/';
  var expected = '../../baz';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '/foo/../../bar/../../baz/';
  var expected = '/../../baz';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  test.case = 'path with ".." in the beginning'; /* */

  var path = '../foo/bar';
  var expected = '../foo/bar';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '../../foo/bar/';
  var expected = '../../foo/bar';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '..//..//foo/bar/';
  var expected = '..//foo/bar';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '/..//..//foo/bar/';
  var expected = '/..//foo/bar';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '..x/foo/bar';
  var expected = '..x/foo/bar';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '..x../foo/bar';
  var expected = '..x../foo/bar';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  test.case = 'path with ".." in the end'; /* */

  var path = 'foo/bar..';
  var expected = 'foo/bar..';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'foo/..bar..';
  var expected = 'foo/..bar..';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'foo/bar/..';
  var expected = 'foo';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'foo/bar/../..';
  var expected = '.';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'foo/bar/../../';
  var expected = '.';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '/foo/bar/../../';
  var expected = '/';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'foo/bar/../../..';
  var expected = '..';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'foo/bar/../../../..';
  var expected = '../..';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'foo/../bar/../../../..';
  var expected = '../../..';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  test.case = 'path with ".." and "." combined'; /* */

  var path = '/abc/./../a/b';
  var expected = '/a/b';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '/abc/.././a/b';
  var expected = '/a/b';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '/abc/./.././a/b';
  var expected = '/a/b';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '/a/b/abc/../.';
  var expected = '/a/b';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '/a/b/abc/./..';
  var expected = '/a/b';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '/a/b/abc/./../.';
  var expected = '/a/b';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = './../.';
  var expected = '..';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = './.././';
  var expected = '..';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = './..';
  var expected = '..';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '../.';
  var expected = '..';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  test.case = 'path with \/'; /* */

  var path = 'foo/bar\/';
  var expected = 'foo/bar';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = 'foo/\/bar\/';
  var expected = 'foo//bar';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '\/foo/bar/..';
  var expected = '/foo';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '\/foo\/bar/../..';
  var expected = '/';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  var path = '\/foo\/bar/../../';
  var expected = '/';
  var got = _.path.canonize( path );
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.canonize( ) );

  test.case = 'Two arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.canonize( 'a', 'b' ) );

  // Input is not path

  test.case = 'No path - regexp';
  test.shouldThrowErrorOfAnyKind( () => _.path.canonize( /foo/ ) );

  test.case = 'No path - number';
  test.shouldThrowErrorOfAnyKind( () => _.path.canonize( 3 ) );

  test.case = 'No path - array';
  test.shouldThrowErrorOfAnyKind( () => _.path.canonize( [ '/C/', 'work/f' ] ) );

  test.case = 'No path - object';
  test.shouldThrowErrorOfAnyKind( () => _.path.canonize( { Path : 'C:/foo/baz/bar' } ) );

  test.case = 'No path - undefined';
  test.shouldThrowErrorOfAnyKind( () => _.path.canonize( undefined ) );

  test.case = 'No path - null';
  test.shouldThrowErrorOfAnyKind( () => _.path.canonize( null ) );

  test.case = 'No path - NaN';
  test.shouldThrowErrorOfAnyKind( () => _.path.canonize( NaN ) );

}

//

function canonizeTolerant( test )
{

  test.case = 'posix path'; /* */

  var path = '/aa/bb/cc/./';
  var expected = '/aa/bb/cc';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '//b//././c/../d/..e';
  var expected = '/b/d/..e';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '/aa/bb/cc/';
  var expected = '/aa/bb/cc';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '/foo/bar//baz/asdf/quux/..';
  var expected = '/foo/bar/baz/asdf';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '/foo/bar//baz/asdf/quux/.';
  var expected = '/foo/bar/baz/asdf/quux';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '/foo/bar//baz/asdf/quux/./';
  var expected = '/foo/bar/baz/asdf/quux';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '/foo/bar//baz/asdf/quux/../';
  var expected = '/foo/bar/baz/asdf';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '//foo/bar//baz/asdf/quux/..//';
  var expected = '/foo/bar/baz/asdf';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/bar//baz/asdf/quux/..//.';
  var expected = 'foo/bar/baz/asdf';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  test.case = 'winoows path'; /* */

  var path = 'C:\\temp\\\\foo\\bar\\..\\';
  var expected = '/C/temp/foo';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\\\';
  var expected = '/C/temp/foo';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\\\';
  var expected = '/C/temp/foo';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..';
  var expected = '/C/temp';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..\\';
  var expected = '/C/temp';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = 'C:\\temp\\\\foo\\bar\\..\\..\\.';
  var expected = '/C/temp';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  test.case = 'empty path'; /* */

  var path = '';
  var expected = '';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '/';
  var expected = '/';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '//';
  var expected = '/';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '///';
  var expected = '/';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '/.';
  var expected = '/';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '/./.';
  var expected = '/';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '.';
  var expected = '.';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = './.';
  var expected = '.';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = './';
  var expected = '.';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  test.case = 'path with "." in the middle'; /* */

  var path = 'foo/./bar/baz';
  var expected = 'foo/bar/baz';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/././bar/baz/';
  var expected = 'foo/bar/baz';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/././bar/././baz/';
  var expected = 'foo/bar/baz';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '/foo/././bar/././baz/';
  var expected = '/foo/bar/baz';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '/foo/.x./baz/';
  var expected = '/foo/.x./baz';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  test.case = 'path with "." in the beginning'; /* */

  var path = './foo/bar';
  var expected = 'foo/bar';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '././foo/bar/';
  var expected = 'foo/bar';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = './/.//foo/bar/';
  var expected = 'foo/bar';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '/.//.//foo/bar/';
  var expected = '/foo/bar';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '.x/foo/bar';
  var expected = '.x/foo/bar';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '.x./foo/bar';
  var expected = '.x./foo/bar';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = './x/.';
  var expected = 'x';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  test.case = 'path with "." in the end'; /* */

  var path = 'foo/bar.';
  var expected = 'foo/bar.';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/.bar.';
  var expected = 'foo/.bar.';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/bar/.';
  var expected = 'foo/bar';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/bar/./.';
  var expected = 'foo/bar';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/bar/././';
  var expected = 'foo/bar';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '/foo/bar/././';
  var expected = '/foo/bar';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '/foo/baz/.x./';
  var expected = '/foo/baz/.x.';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  test.case = 'path with ".." in the middle'; /* */

  var path = 'foo/../bar/baz';
  var expected = 'bar/baz';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/../../bar/baz/';
  var expected = '../bar/baz';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/../../bar/../../baz/';
  var expected = '../../baz';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '/foo/../../bar/../../baz/';
  var expected = '/../../baz';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  test.case = 'path with ".." in the beginning'; /* */

  var path = '../foo/bar';
  var expected = '../foo/bar';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '../../foo/bar/';
  var expected = '../../foo/bar';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '..//..//foo/bar/';
  var expected = '../../foo/bar';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '/..//..//foo/bar/';
  var expected = '/../../foo/bar';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '..x/foo/bar';
  var expected = '..x/foo/bar';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '..x../foo/bar';
  var expected = '..x../foo/bar';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  test.case = 'path with ".." in the end'; /* */

  var path = 'foo/bar..';
  var expected = 'foo/bar..';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/..bar..';
  var expected = 'foo/..bar..';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/bar/..';
  var expected = 'foo';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/bar/../../';
  var expected = '.';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/bar/../..';
  var expected = '.';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '/foo/bar/../../';
  var expected = '/';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/bar/../../..';
  var expected = '..';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/bar/../../../..';
  var expected = '../..';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = 'foo/../bar/../../../..';
  var expected = '../../..';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  test.case = 'path with ".." and "." combined'; /* */

  var path = '/abc/./../a/b';
  var expected = '/a/b';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '/abc/.././a/b';
  var expected = '/a/b';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '/abc/./.././a/b';
  var expected = '/a/b';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '/a/b/abc/../.';
  var expected = '/a/b';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '/a/b/abc/./..';
  var expected = '/a/b';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '/a/b/abc/./../.';
  var expected = '/a/b';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = './../.';
  var expected = '..';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = './.././';
  var expected = '..';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = './..';
  var expected = '..';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '../.';
  var expected = '..';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

  var path = '.././';
  var expected = '..';
  var got = _.path.canonizeTolerant( path );
  test.identical( got, expected );

}

//

function nativize( test )
{

  /* */

  var src = 'A:\\';
  var got = _.path.nativize( src );
  var expected = 'A:\\';
  if( process.platform === 'win32' )
  test.identical( got, expected );
  else
  test.identical( got, src );

  /* */

  var src = '/A/';
  var got = _.path.nativize( src );
  var expected = 'A:\\';
  if( process.platform === 'win32' )
  test.identical( got, expected );
  else
  test.identical( got, src );

  /* */

  var src = '/A';
  var got = _.path.nativize( src );
  var expected = 'A:\\';
  if( process.platform === 'win32' )
  test.identical( got, expected );
  else
  test.identical( got, src );

  /* */

  var src = '/A/b';
  var got = _.path.nativize( src );
  var expected = 'A:\\b';
  if( process.platform === 'win32' )
  test.identical( got, expected );
  else
  test.identical( got, src );

  /* */

  var src = '/A/b/';
  var got = _.path.nativize( src );
  var expected = 'A:\\b\\';
  if( process.platform === 'win32' )
  test.identical( got, expected );
  else
  test.identical( got, src );

  /* */

  var src = '/Aa/b';
  var got = _.path.nativize( src );
  if( process.platform === 'win32' )
  test.identical( got, '\\Aa\\b' );
  else
  test.identical( got, src );

  /* */

  var src = '/Aa';
  var got = _.path.nativize( src );
  if( process.platform === 'win32' )
  test.identical( got, '\\Aa' );
  else
  test.identical( got, src );

  /* */

  var src = 'a/b';
  var got = _.path.nativize( src );
  if( process.platform === 'win32' )
  test.identical( got, 'a\\b' );
  else
  test.identical( got, src );

}

//

function from( test )
{

  test.case = 'trivial';
  var expected = 'a/b';
  var got = _.path.from( 'a/b' );
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.path.from() );
  test.shouldThrowErrorSync( () => _.path.from( null ) );
  test.shouldThrowErrorSync( () => _.path.from( [] ) );
  test.shouldThrowErrorSync( () => _.path.from( {} ) );

}

//

// function dot( test )
// {
//   test.case = 'src - empty path';
//   var src = '';
//   var got = _.path.dot( src );
//   var exp = './';
//   test.identical( got, exp );
//
//   test.case = 'src - filename';
//   var src = 'a';
//   var got = _.path.dot( src );
//   var exp = './a';
//   test.identical( got, exp );
//
//   test.case = 'src - current directory';
//   var src = '.';
//   var got = _.path.dot( src );
//   var exp = '.';
//   test.identical( got, exp );
//
//   test.case = 'src - filename begins with dot';
//   var src = '.a';
//   var got = _.path.dot( src );
//   var exp = './.a';
//   test.identical( got, exp );
//
//   test.case = 'src - file in current directory';
//   var src = './a';
//   var got = _.path.dot( src );
//   var exp = './a';
//   test.identical( got, exp );
//
//   test.case = 'src - up to current directory';
//   var src = '..';
//   var got = _.path.dot( src );
//   var exp = '..';
//   test.identical( got, exp );
//
//   test.case = 'src - filename begins by double dot';
//   var src = '..a';
//   var got = _.path.dot( src );
//   var exp = './..a';
//   test.identical( got, exp );
//
//   test.case = 'src - file in up to current directory';
//   var src = '../a';
//   var got = _.path.dot( src );
//   var exp = '../a';
//   test.identical( got, exp );
//
//   if( !Config.debug )
//   return;
//
//   test.case = 'root directory';
//   test.shouldThrowErrorSync( () => _.path.dot( '/' ) );
//
//   test.case = 'file in root directory';
//   test.shouldThrowErrorSync( () => _.path.dot( '/a' ) );
// }
//
// //
//
// function undot( test )
// {
//   [> aaa : unwrap array and normalize all tests in this test suite <]
//   [> Dmytro : unwrapped and normalized this test routine and in all test suite <]
//
//   test.case = 'src - current directory with slash';
//   var src = './';
//   var got =  _.path.undot( src );
//   var exp = './';
//   test.identical( got, exp );
//
//   test.case = 'src - current directory';
//   var src = '.';
//   var got =  _.path.undot( src );
//   var exp = '.';
//   test.identical( got, exp );
//
//   test.case = 'src - up from current directory';
//   var src = '..';
//   var got =  _.path.undot( src );
//   var exp = '..';
//   test.identical( got, exp );
//
//   test.case = 'src - current directory with filename';
//   var src = './a';
//   var got =  _.path.undot( src );
//   var exp = 'a';
//   test.identical( got, exp );
//
//   test.case = 'src - filename';
//   var src = 'a';
//   var got =  _.path.undot( src );
//   var exp = 'a';
//   test.identical( got, exp );
//
//   test.case = 'src - current directory, filename with dot at begin';
//   var src = './.a';
//   var got =  _.path.undot( src );
//   var exp = '.a';
//   test.identical( got, exp );
//
//   test.case = 'src - current directory, filename with double dot at begin';
//   var src = './..a';
//   var got =  _.path.undot( src );
//   var exp = '..a';
//   test.identical( got, exp );
//
//   test.case = 'src - file in directory with name ".", after root';
//   var src = '/./a';
//   var got =  _.path.undot( src );
//   var exp = '/./a';
//   test.identical( got, exp );
// }
//
// //
//
// function _pathJoin_body( test )
// {
//
//   // var options1 =
//   // {
//   //   reroot : 1,
//   //   url : 0,
//   // }
//   // var options2 =
//   // {
//   //   reroot : 0,
//   //   url : 1,
//   // }
//   // var options3 =
//   // {
//   //   reroot : 0,
//   //   url : 0,
//   // }
//
//   var paths1 = [ 'http://www.site.com:13/', 'bar', 'foo' ];
//   var paths2 = [ 'c:\\', 'foo\\', 'bar\\' ];
//   var paths3 = [ '/bar/', '/', 'foo/' ];
//   var paths4 = [ '/bar/', '/baz', 'foo/' ];
//
//   var expected1 = 'http://www.site.com:13/bar/foo';
//   var expected2 = '/c/foo/bar';
//   var expected3 = '/foo';
//   var expected4 = '/bar/baz/foo';
//
//   // test.case = 'join url';
//   // var got = _.path._pathJoin_body
//   // ({
//   //   paths : paths1,
//   //   reroot : 0,
//   //   url : 1,
//   // });
//   // test.identical( got, expected1 );
//
//   test.case = 'join windows os paths';
//   var got = _.path._pathJoin_body
//   ({
//     paths : paths2,
//     reroot : 0,
//     allowingNull : 0,
//   });
//   test.identical( got, expected2 );
//
//   test.case = 'join unix os paths';
//   var got = _.path._pathJoin_body
//   ({
//     paths : paths3,
//     reroot : 0,
//     allowingNull : 0,
//   });
//   test.identical( got, expected3 );
//
//   test.case = 'join unix os paths with reroot';
//   var got = _.path._pathJoin_body
//   ({
//     paths : paths4,
//     reroot : 1,
//     allowingNull : 0,
//   });
//   test.identical( got, expected4 );
//
//   test.case = 'join reroot with /';
//   var got = _.path._pathJoin_body
//   ({
//     paths : [ '/', '/a/b' ],
//     reroot : 1,
//     allowingNull : 0,
//   });
//   test.identical( got, '/a/b' );
//
//   if( !Config.debug )
//   return;
//
//   test.case = 'missed arguments';
//   test.shouldThrowErrorSync( function()
//   {
//     _.path._pathJoin_body();
//   });
//
//   test.case = 'path element is not string';
//   test.shouldThrowErrorSync( function()
//   {
//     _.path._pathJoin_body( _.props.supplement( { paths : [ 34 , 'foo/' ] }, options3 ) );
//   });
//
//   test.case = 'missed options';
//   test.shouldThrowErrorSync( function()
//   {
//     _.path._pathJoin_body( paths1 );
//   });
//
//   test.case = 'options has unexpected parameters';
//   test.shouldThrowErrorSync( function()
//   {
//     _.path._pathJoin_body({ paths : paths1, wrongParameter : 1 });
//   });
//
//   test.case = 'options does not has paths';
//   test.shouldThrowErrorSync( function()
//   {
//     _.path._pathJoin_body({ wrongParameter : 1 });
//   });
// }

//

function join( test )
{

  test.case = 'join empty';
  var paths = [ '' ];
  var expected = '';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'join several empties';
  var paths = [ '', '' ];
  var expected = '';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'root with absolute';
  var paths = [ '/', '/a/b' ];
  var expected = '/a/b';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'root with relative';
  var paths = [ '/', 'a/b' ];
  var expected = '/a/b';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'dir with absolute';
  var paths = [ '/dir', '/a/b' ];
  var expected = '/a/b';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'dir with relative';
  var paths = [ '/dir', 'a/b' ];
  var expected = '/dir/a/b';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'trailed dir with absolute';
  var paths = [ '/dir/', '/a/b' ];
  var expected = '/a/b';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'trailed dir with relative';
  var paths = [ '/dir/', 'a/b' ];
  var expected = '/dir/a/b';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'dir with absolute';
  var paths = [ '/dir', '/a/b' ];
  var expected = '/a/b';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'dir with relative';
  var paths = [ '/dir', 'a/b' ];
  var expected = '/dir/a/b';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'dir with down';
  var paths = [ '/dir', '../a/b' ];
  var expected = '/a/b';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'trailed dir with down';
  var paths = [ '/dir/', '../a/b' ];
  var expected = '/dir/a/b';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'dir with several down';
  var paths = [ '/dir/dir2', '../../a/b' ];
  var expected = '/a/b';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'trailed dir with several down';
  var paths = [ '/dir/', '../../a/b' ];
  var expected = '/a/b';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'dir with several down, go out of root';
  var paths = [ '/dir', '../../a/b' ];
  var expected = '/../a/b';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'trailed absolute with trailed down';
  var paths = [ '/a/b/', '../' ];
  var expected = '/a/b/';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'absolute with trailed down';
  var paths = [ '/a/b', '../' ];
  var expected = '/a/';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'trailed absolute with down';
  var paths = [ '/a/b/', '..' ];
  var expected = '/a/b';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'trailed absolute with trailed here';
  var paths = [ '/a/b/', './' ];
  var expected = '/a/b/';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'absolute with trailed here';
  var paths = [ '/a/b', './' ];
  var expected = '/a/b/';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'trailed absolute with here';
  var paths = [ '/a/b/', '.' ];
  var expected = '/a/b';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  /* */

  test.case = 'join with empty';
  var paths = [ '', 'a/b', '', 'c', '' ];
  var expected = 'a/b/c';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'join windows os paths';
  var paths = [ 'c:\\', 'foo\\', 'bar\\' ];
  var expected = '/c/foo/bar/';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'join unix os paths';
  var paths = [ '/bar/', '/baz', 'foo/', '.' ];
  var expected = '/baz/foo';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'join unix os paths';
  var paths = [ '/bar/', '/baz', 'foo/', '.', 'z' ];
  var expected = '/baz/foo/z';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'more complicated cases'; /* */

  var paths = [ '/aa', 'bb//', 'cc' ];
  var expected = '/aa/bb//cc';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  var paths = [ '/aa', '/bb', 'cc' ];
  var expected = '/bb/cc';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  var paths = [ '//aa', 'bb//', 'cc//' ];
  var expected = '//aa/bb//cc//';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  var paths = [ '/aa', 'bb//', 'cc', '.' ];
  var expected = '/aa/bb//cc';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  var paths = [ '/', 'a', '//b//', '././c', '../d', '..e' ];
  var expected = '//b//d/..e';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'join trailed';
  var paths = [ '/a/b/', '.' ];
  var expected = '/a/b';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'join trailed';
  var paths = [ '/a/b/', './' ];
  var expected = '/a/b/';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.case = 'join trailed';
  var paths = [ '/a/b', './' ];
  var expected = '/a/b/';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  /* - */

  test.open( 'with nulls' );

  var paths = [ 'a', null ];
  var expected = null;
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  var paths = [ '/', null ];
  var expected = null;
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  var paths = [ 'a', null, 'b' ];
  var expected = 'b';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  var paths = [ '/a', null, 'b' ];
  var expected = 'b';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  var paths = [ '/a', null, '/b' ];
  var expected = '/b';
  var got = _.path.join( ... paths );
  test.identical( got, expected );

  test.close( 'with nulls' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'bad arguments';

  test.shouldThrowErrorSync( () => _.path.join() );
  test.shouldThrowErrorSync( () => _.path.join( {} ) );
  test.shouldThrowErrorSync( () => _.path.join( 1 ) );
  test.shouldThrowErrorSync( () => _.path.join( '/', 1 ) );

}

//

function joinRaw( test )
{

  test.case = 'join empty';
  var paths = [ '' ];
  var expected = '';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'join several empties';
  var paths = [ '', '' ];
  var expected = '';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'root with absolute';
  var paths = [ '/', '/a/b' ];
  var expected = '/a/b';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'root with relative';
  var paths = [ '/', 'a/b' ];
  var expected = '/a/b';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'dir with absolute';
  var paths = [ '/dir', '/a/b' ];
  var expected = '/a/b';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'dir with relative';
  var paths = [ '/dir', 'a/b' ];
  var expected = '/dir/a/b';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'trailed dir with absolute';
  var paths = [ '/dir/', '/a/b' ];
  var expected = '/a/b';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'trailed dir with relative';
  var paths = [ '/dir/', 'a/b' ];
  var expected = '/dir/a/b';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'dir with absolute';
  var paths = [ '/dir', '/a/b' ];
  var expected = '/a/b';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'dir with relative';
  var paths = [ '/dir', 'a/b' ];
  var expected = '/dir/a/b';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'dir with down';
  var paths = [ '/dir', '../a/b' ];
  var expected = '/dir/../a/b';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'trailed dir with down';
  var paths = [ '/dir/', '../a/b' ];
  var expected = '/dir/a/b';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'dir with several down';
  var paths = [ '/dir/dir2', '../../a/b' ];
  var expected = '/dir/dir2/../../a/b';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'trailed dir with several down';
  var paths = [ '/dir/', '../../a/b' ];
  var expected = '/dir/../a/b';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'dir with several down, go out of root';
  var paths = [ '/dir', '../../a/b' ];
  var expected = '/dir/../../a/b';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'trailed absolute with trailed down';
  var paths = [ '/a/b/', '../' ];
  var expected = '/a/b/./';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'absolute with trailed down';
  var paths = [ '/a/b', '../' ];
  var expected = '/a/b/../';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'trailed absolute with down';
  var paths = [ '/a/b/', '..' ];
  var expected = '/a/b/.';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'trailed absolute with trailed here';
  var paths = [ '/a/b/', './' ];
  var expected = '/a/b/./';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'absolute with trailed here';
  var paths = [ '/a/b', './' ];
  var expected = '/a/b/./';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'trailed absolute with here';
  var paths = [ '/a/b/', '.' ];
  var expected = '/a/b/.';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  /* */

  test.case = 'second trailed';
  var paths = [ '/a/b', 'c/' ];
  var expected = '/a/b/c/';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'both trained';
  var paths = [ '/a/b/', 'c/' ];
  var expected = '/a/b/c/';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'with empty';
  var paths = [ '', 'a/b', '', 'c', '' ];
  var expected = 'a/b/c';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'windows os paths';
  var paths = [ 'c:\\', 'foo\\', 'bar\\' ];
  var expected = '/c/foo/bar/';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'unix os paths';
  var paths = [ '/bar/', '/baz', 'foo/', '.' ];
  var expected = '/baz/foo/.';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.case = 'more complicated cases'; /* */

  var paths = [ '/aa', 'bb//', 'cc' ];
  var expected = '/aa/bb//cc';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  var paths = [ '/aa', '/bb', 'cc' ];
  var expected = '/bb/cc';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  var paths = [ '//aa', 'bb//', 'cc//' ];
  var expected = '//aa/bb//cc//';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  var paths = [ '/aa', 'bb//', 'cc', '.' ];
  var expected = '/aa/bb//cc/.';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  var paths = [ '/', 'a', '//b//', '././c', '../d', '..e' ];
  var expected = '//b//././c/../d/..e';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  /* - */

  test.open( 'with nulls' );

  var paths = [ 'a', null ];
  var expected = null;
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  var paths = [ '/', null ];
  var expected = null;
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  var paths = [ 'a', null, 'b' ];
  var expected = 'b';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  var paths = [ '/a', null, 'b' ];
  var expected = 'b';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  var paths = [ '/a', null, '/b' ];
  var expected = '/b';
  var got = _.path.joinRaw( ... paths );
  test.identical( got, expected );

  test.close( 'with nulls' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'bad arguments';

  test.shouldThrowErrorSync( () => _.path.joinRaw() );
  test.shouldThrowErrorSync( () => _.path.joinRaw( {} ) );
  test.shouldThrowErrorSync( () => _.path.joinRaw( 1 ) );
  test.shouldThrowErrorSync( () => _.path.joinRaw( '/', 1 ) );

}

//

function joinCross( test )
{
  test.description = 'paths - empty array';
  var paths = [];
  var expected = [];
  var got = _.path.joinCross( paths );
  test.identical( got, expected );

  test.description = 'paths - array with empty subsets';
  var paths = [ [], [], [] ];
  var expected = [];
  var got = _.path.joinCross.apply( _.path, paths );
  test.identical( got, expected );

  test.description = 'paths - array with single empty subset';
  var paths = [ 'a', [ 'b' ], [], 'c' ];
  var expected = [];
  var got = _.path.joinCross.apply( _.path, paths );
  test.identical( got, expected );

  /* */

  test.description = 'simple paths';
  var paths = [ 'a', 'b', 'c' ];
  var expected = 'a/b/c';
  var got = _.path.joinCross.apply( _.path, paths );
  test.identical( got, expected );

  test.description = 'single element vector in the middle';
  var paths = [ 'a', [ 'b' ], 'c' ];
  var expected = [ 'a/b/c' ];
  var got = _.path.joinCross.apply( _.path, paths );
  test.identical( got, expected );

  test.description = 'two elements vector in the middle';
  var paths = [ 'a', [ 'b1', 'b2' ], 'c' ];
  var expected = [ 'a/b1/c', 'a/b2/c' ];
  var got = _.path.joinCross.apply( _.path, paths );
  test.identical( got, expected );

  test.description = 'several many elements vectors';
  var paths = [ 'a', [ 'b1', 'b2' ], [ 'c1', 'c2', 'c3' ] ];
  var expected = [ 'a/b1/c1', 'a/b2/c1', 'a/b1/c2', 'a/b2/c2', 'a/b1/c3', 'a/b2/c3' ];
  var got = _.path.joinCross.apply( _.path, paths );
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'bad arguments';
  test.shouldThrowErrorSync( () => _.path.joinCross() );
  test.shouldThrowErrorSync( () => _.path.joinCross( {} ) );
  test.shouldThrowErrorSync( () => _.path.joinCross( 1 ) );
  test.shouldThrowErrorSync( () => _.path.joinCross( '/', 1 ) );
}

//

function reroot( test )
{

  test.case = 'join empty';
  var paths = [ '' ];
  var expected = '';
  var got = _.path.reroot( ... paths );
  test.identical( got, expected );

  test.case = 'join several empties';
  var paths = [ '', '' ];
  var expected = '';
  var got = _.path.reroot( ... paths );
  test.identical( got, expected );

  test.case = 'root with absolute';
  var paths = [ '/', '/a/b' ];
  var expected = '//a/b';
  var got = _.path.reroot( ... paths );
  test.identical( got, expected );

  test.case = 'root with relative';
  var paths = [ '/', 'a/b' ];
  var expected = '/a/b';
  var got = _.path.reroot( ... paths );
  test.identical( got, expected );

  test.case = 'dir with absolute';
  var paths = [ '/dir', '/a/b' ];
  var expected = '/dir/a/b';
  var got = _.path.reroot( ... paths );
  test.identical( got, expected );

  test.case = 'dir with relative';
  var paths = [ '/dir', 'a/b' ];
  var expected = '/dir/a/b';
  var got = _.path.reroot( ... paths );
  test.identical( got, expected );

  test.case = 'trailed dir with absolute';
  var paths = [ '/dir/', '/a/b' ];
  var expected = '/dir/a/b';
  var got = _.path.reroot( ... paths );
  test.identical( got, expected );

  test.case = 'trailed dir with relative';
  var paths = [ '/dir/', 'a/b' ];
  var expected = '/dir/a/b';
  var got = _.path.reroot( ... paths );
  test.identical( got, expected );

  test.case = 'dir with absolute';
  var paths = [ '/dir', '/a/b' ];
  var expected = '/dir/a/b';
  var got = _.path.reroot( ... paths );
  test.identical( got, expected );

  test.case = 'dir with relative';
  var paths = [ '/dir', 'a/b' ];
  var expected = '/dir/a/b';
  var got = _.path.reroot( ... paths );
  test.identical( got, expected );

  test.case = 'dir with down';
  var paths = [ '/dir', '../a/b' ];
  var expected = '/a/b';
  var got = _.path.reroot( ... paths );
  test.identical( got, expected );

  test.case = 'trailed dir with down';
  var paths = [ '/dir/', '../a/b' ];
  var expected = '/dir/a/b';
  var got = _.path.reroot( ... paths );
  test.identical( got, expected );

  test.case = 'dir with several down';
  var paths = [ '/dir/dir2', '../../a/b' ];
  var expected = '/a/b';
  var got = _.path.reroot( ... paths );
  test.identical( got, expected );

  test.case = 'trailed dir with several down';
  var paths = [ '/dir/', '../../a/b' ];
  var expected = '/a/b';
  var got = _.path.reroot( ... paths );
  test.identical( got, expected );

  test.case = 'dir with several down, go out of root';
  var paths = [ '/dir', '../../a/b' ];
  var expected = '/../a/b';
  var got = _.path.reroot( ... paths );
  test.identical( got, expected );

  test.case = 'trailed absolute with trailed down';
  var paths = [ '/a/b/', '../' ];
  var expected = '/a/b/';
  var got = _.path.reroot( ... paths );
  test.identical( got, expected );

  test.case = 'absolute with trailed down';
  var paths = [ '/a/b', '../' ];
  var expected = '/a/';
  var got = _.path.reroot( ... paths );
  test.identical( got, expected );

  test.case = 'trailed absolute with down';
  var paths = [ '/a/b/', '..' ];
  var expected = '/a/b';
  var got = _.path.reroot( ... paths );
  test.identical( got, expected );

  test.case = 'trailed absolute with trailed here';
  var paths = [ '/a/b/', './' ];
  var expected = '/a/b/';
  var got = _.path.reroot( ... paths );
  test.identical( got, expected );

  test.case = 'absolute with trailed here';
  var paths = [ '/a/b', './' ];
  var expected = '/a/b/';
  var got = _.path.reroot( ... paths );
  test.identical( got, expected );

  test.case = 'trailed absolute with here';
  var paths = [ '/a/b/', '.' ];
  var expected = '/a/b';
  var got = _.path.reroot( ... paths );
  test.identical( got, expected );

  /* */

  test.case = 'join windows os paths';
  var paths1 = [ 'c:\\', 'foo\\', 'bar\\' ];
  var expected1 = '/c/foo/bar/';
  var got = _.path.reroot( ... paths1 );
  test.identical( got, expected1 );

  test.case = 'join unix os paths';
  var paths2 = [ '/bar/', '/baz', 'foo/', '.' ];
  var expected2 = '/bar/baz/foo';
  var got = _.path.reroot( ... paths2 );
  test.identical( got, expected2 );

  test.case = 'reroot';

  var got = _.path.reroot( 'a', '/a', 'b' );
  var expected = 'a/a/b';
  test.identical( got, expected );

  var got = _.path.reroot( 'a', '/a', '/b' );
  var expected = 'a/a/b';
  test.identical( got, expected );

  var got = _.path.reroot( '/a', '/b', '/c' );
  var expected = '/a/b/c';
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'nothing passed';
  test.shouldThrowErrorSync( function()
  {
    _.path.reroot();
  });

  test.case = 'not string passed';
  test.shouldThrowErrorSync( function()
  {
    _.path.reroot( {} );
  });

}

//

function resolve( test )
{

  test.case = 'join windows os paths';
  var paths = [ 'c:\\', 'foo\\', 'bar\\' ];
  var expected = '/c/foo/bar/';
  var got = _.path.resolve.apply( _.path, paths );
  test.identical( got, expected );

  test.case = 'join unix os paths';
  var paths = [ '/bar/', '/baz', 'foo/', '.' ];
  var expected = '/baz/foo';
  var got = _.path.resolve.apply( _.path, paths );
  test.identical( got, expected );

  test.case = 'here cases'; /* */

  var paths = [ 'aa', '.', 'cc' ];
  var expected = _.path.join( _.path.current(), 'aa/cc' );
  var got = _.path.resolve.apply( _.path, paths );
  test.identical( got, expected );

  var paths = [ 'aa', 'cc', '.' ];
  var expected = _.path.join( _.path.current(), 'aa/cc' );
  var got = _.path.resolve.apply( _.path, paths );
  test.identical( got, expected );

  var paths = [ '.', 'aa', 'cc' ];
  var expected = _.path.join( _.path.current(), 'aa/cc' );
  var got = _.path.resolve.apply( _.path, paths );
  test.identical( got, expected );

  test.case = 'down cases'; /* */

  var paths = [ '.', 'aa', 'cc', '..' ];
  var expected = _.path.join( _.path.current(), 'aa' );
  var got = _.path.resolve.apply( _.path, paths );
  test.identical( got, expected );

  var paths = [ '.', 'aa', 'cc', '..', '..' ];
  var expected = _.path.current();
  var got = _.path.resolve.apply( _.path, paths );
  test.identical( got, expected );

  console.log( '_.path.current()', _.path.current() );
  var paths = [ 'aa', 'cc', '..', '..', '..' ];
  var expected = _.strIsolateRightOrNone( _.path.current(), '/' )[ 0 ];
  if( _.path.current() === '/' )
  expected = '/..';
  var got = _.path.resolve.apply( _.path, paths );
  test.identical( got, expected );

  test.case = 'like-down or like-here cases'; /* */

  var paths = [ '.x.', 'aa', 'bb', '.x.' ];
  var expected = _.path.join( _.path.current(), '.x./aa/bb/.x.' );
  var got = _.path.resolve.apply( _.path, paths );
  test.identical( got, expected );

  var paths = [ '..x..', 'aa', 'bb', '..x..' ];
  var expected = _.path.join( _.path.current(), '..x../aa/bb/..x..' );
  var got = _.path.resolve.apply( _.path, paths );
  test.identical( got, expected );

  test.case = 'period and double period combined'; /* */

  var paths = [ '/abc', './../a/b' ];
  var expected = '/a/b';
  var got = _.path.resolve.apply( _.path, paths );
  test.identical( got, expected );

  var paths = [ '/abc', 'a/.././a/b' ];
  var expected = '/abc/a/b';
  var got = _.path.resolve.apply( _.path, paths );
  test.identical( got, expected );

  var paths = [ '/abc', '.././a/b' ];
  var expected = '/a/b';
  var got = _.path.resolve.apply( _.path, paths );
  test.identical( got, expected );

  var paths = [ '/abc', './.././a/b' ];
  var expected = '/a/b';
  var got = _.path.resolve.apply( _.path, paths );
  test.identical( got, expected );

  var paths = [ '/abc', './../.' ];
  var expected = '/';
  var got = _.path.resolve.apply( _.path, paths );
  test.identical( got, expected );

  var paths = [ '/abc', './../../.' ];
  var expected = '/..';
  var got = _.path.resolve.apply( _.path, paths );
  test.identical( got, expected );

  var paths = [ '/abc', './../.' ];
  var expected = '/';
  var got = _.path.resolve.apply( _.path, paths );
  test.identical( got, expected );

  if( !Config.debug ) //
  return;

  test.case = 'nothing passed';
  test.shouldThrowErrorSync( function()
  {
    _.path.resolve();
  });

  test.case = 'non string passed';
  test.shouldThrowErrorSync( function()
  {
    _.path.resolve( {} );
  });
}

//

function joinNames( test )
{

  test.case = 'nothing';
  var got = _.path.joinNames();
  //var expected = ''; // _.path.normalize( '' ) returns '.'
  var expected = '';
  test.identical( got, expected );

  // Only one type

  test.case = 'only prefixes';
  var got = _.path.joinNames( '/a', './b/' );
  var expected = '/a/b';
  test.identical( got, expected );

  test.case = 'only names';
  var got = _.path.joinNames( 'a', 'b' );
  var expected = 'ab';
  test.identical( got, expected );

  test.case = 'only exts';
  var got = _.path.joinNames( '.a', '.b' );
  var expected = '.ab';
  test.identical( got, expected );

  // Names with extensions

  test.case = 'Two names with extension';
  var got = _.path.joinNames( 'a.c', 'b.d' );
  var expected = 'ab.cd';
  test.identical( got, expected );

  test.case = 'Two names with extension and a point';
  var got = _.path.joinNames( '.', 'a.c', 'b.d' );
  var expected = 'ab.cd';
  test.identical( got, expected );

  test.case = 'one name without ext';
  var got = _.path.joinNames( 'a.a', 'b', 'c.c' );
  var expected = 'abc.ac';
  test.identical( got, expected );

  test.case = 'all with exts';
  var got = _.path.joinNames( 'a.a', 'b.b', 'c.c' );
  var expected = 'abc.abc';
  test.identical( got, expected );

  test.case = 'same name and ext';
  var got = _.path.joinNames( 'a.a', 'a.a' );
  var expected = 'aa.aa';
  test.identical( got, expected );

  test.case = 'several exts';
  var got = _.path.joinNames( 'a.test.js', 'b.test.s', 'c.test.ss' );
  var expected = 'a.testb.testc.test.jssss';
  test.identical( got, expected );

  test.case = 'dot in name';
  var got = _.path.joinNames( 'a..b', 'b..c', 'c.ss' );
  var expected = 'a.b.c.bcss';
  test.identical( got, expected );

  test.case = 'null - begining';
  var got = _.path.joinNames( null, 'a.a', 'b.b' );
  var expected = 'ab.ab';
  test.identical( got, expected );

  test.case = 'null - middle';
  var got = _.path.joinNames( 'a.a', null, 'b.b' );
  var expected = 'b.b';
  test.identical( got, expected );

  test.case = 'null - end';
  var got = _.path.joinNames( 'a.a', 'b.b', null );
  //var expected = '';
  var expected = '';
  test.identical( got, expected );

  // Names with Prefixes

  test.case = 'Two names with prefix';
  var got = _.path.joinNames( 'a/c', 'b/d' );
  var expected = 'ab/cd';
  test.identical( got, expected );

  test.case = 'Two names with prefix and a point';
  var got = _.path.joinNames( '.', 'a/c', 'b/d' );
  var expected = 'ab/cd';
  test.identical( got, expected );

  test.case = 'one name without prefix';
  var got = _.path.joinNames( 'a/a', 'b', 'c/c' );
  var expected = 'ac/abc';
  test.identical( got, expected );

  test.case = 'all with prefixes';
  var got = _.path.joinNames( 'a/a', 'b/b', 'c/c' );
  var expected = 'abc/abc';
  test.identical( got, expected );

  test.case = 'Same name and prefix';
  var got = _.path.joinNames( 'a/a', 'a/a' );
  var expected = 'aa/aa';
  test.identical( got, expected );

  test.case = 'One starting prefix';
  var got = _.path.joinNames( '/a/a', 'a/a' );
  var expected = '/a/a/a/a';
  test.identical( got, expected );

  test.case = 'several prefixes';
  var got = _.path.joinNames( 'a/test1/js', 'b/test2/s', 'c/test3/ss' );
  var expected = 'abc/test1test2test3/jssss';
  test.identical( got, expected );

  test.case = 'slash in prefix';
  var got = _.path.joinNames( 'a//b', 'b//c', 'c/ss' );
  var expected = 'ab/c/bcss';
  test.identical( got, expected );

  test.case = 'null - begining';
  var got = _.path.joinNames( null, 'a/a', 'b/b' );
  var expected = 'ab/ab';
  test.identical( got, expected );

  test.case = 'null - middle';
  var got = _.path.joinNames( 'a/a', null, 'b/b' );
  var expected = 'b/b';
  test.identical( got, expected );

  test.case = 'null - end';
  var got = _.path.joinNames( 'a/a', 'b/b', null );
  var expected = '';
  test.identical( got, expected );

  // Names with prefixes and extensions

  test.case = 'Starting prefix, prefixes and extensions';
  var got = _.path.joinNames( '/pre.x', 'a.y/b/c.name', 'post.z' );
  var expected = '/pre.x/a.y/b/cpost.namez';
  test.identical( got, expected );

  test.case = 'Prefixes and extensions - point in first arg';
  var got = _.path.joinNames( './pre.x', 'a.y/b/c.name', 'post.z' );
  var expected = 'a.y/b/precpost.xnamez';
  test.identical( got, expected );

  test.case = 'Post point prefix - point in last arg';
  var got = _.path.joinNames( 'pre.x', 'a.y/b/c.name', './post.z' );
  var expected = 'a.y/b/precpost.xnamez';
  test.identical( got, expected );

  test.case = 'Only one prefix - extensions';
  var got = _.path.joinNames( 'pre.x', 'a.y/b/c.name', 'post.z' );
  var expected = 'a.y/b/precpost.xnamez';
  test.identical( got, expected );

  test.case = 'Points in the middle';
  var got = _.path.joinNames( 'pre.x', 'a.y/./b/./c.name', './post.z' );
  var expected = 'a.y/b/precpost.xnamez';
  test.identical( got, expected );

  test.case = 'Several points in the beggining';
  var got = _.path.joinNames( './././pre.x', 'a.y/b/c.name', 'post.z' );
  var expected = 'a.y/b/precpost.xnamez';
  test.identical( got, expected );

  test.case = 'Two prefixes + extensions';
  var got = _.path.joinNames( 'pre.x', 'a.y/b/c.name', 'd/post.z' );
  var expected = 'a.y/bd/precpost.xnamez';
  test.identical( got, expected );

  test.case = 'Several Prefixes';
  var got = _.path.joinNames( 'c/b/d/e.h', 'a/g/c.d' );
  var expected = 'c/ba/dg/ec.hd';
  test.identical( got, expected );

  test.case = 'Several Prefixes';
  var got = _.path.joinNames( 'pre1.x1/pre.x', 'a.y/b/c.name', 'd/post.z' );
  var expected = 'a.y/pre1bd.x1/precpost.xnamez';
  test.identical( got, expected );

  test.case = 'Several Prefixes with start prefix';
  var got = _.path.joinNames( '/pre1.x1/pre.x', 'a.y/b/c.name', 'd/post.z' );
  var expected = '/pre1.x1/pre.x/a.y/bd/cpost.namez';
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorOfAnyKind( () => _.path.joinNames( 'a', 1 ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.joinNames( 'a', null, 1 ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.joinNames( 'a', 1, null ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.joinNames( 1, 'a' ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.joinNames( [ '1' ], 'a' ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.joinNames( undefined, 'a' ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.joinNames( [ '1', 'a' ] ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.joinNames( '/a/a', '/b/b', 'c/c' ) );

};

//

function dir( test )
{

  test.case = '.';
  var src = '.';
  var expected = '..';
  var got = _.path.dir( src );
  test.identical( got, expected );

  test.case = './';
  var src = './';
  var expected = '../';
  var got = _.path.dir( src );
  test.identical( got, expected );

  test.case = 'a/b';
  var src = 'a/b';
  var expected = 'a';
  var got = _.path.dir( src );
  test.identical( got, expected );

  test.case = 'a/b/';
  var src = 'a/b/';
  var expected = 'a/';
  var got = _.path.dir( src );
  test.identical( got, expected );

  /* */

  test.case = 'simple absolute path';
  var src = '/foo';
  var expected = '/';
  var got = _.path.dir( src );
  test.identical( got, expected );

  test.case = 'absolute path : nested dirs'; /* */
  var src = '/foo/bar/baz/text.txt';
  var expected = '/foo/bar/baz';
  var got = _.path.dir( src );
  test.identical( got, expected );

  var src = '/aa/bb';
  var expected = '/aa';
  var got = _.path.dir( src );
  test.identical( got, expected );

  var src = '/aa';
  var expected = '/';
  var got = _.path.dir( src );
  test.identical( got, expected );

  var src = '/';
  var expected = '/..';
  var got = _.path.dir( src );
  test.identical( got, expected );

  test.case = 'relative path : nested dirs'; /* */

  var src = 'aa/bb';
  var expected = 'aa';
  var got = _.path.dir( src );
  test.identical( got, expected );

  var src = 'aa';
  var expected = '.';
  var got = _.path.dir( src );
  test.identical( got, expected );

  var src = 'aa/.';
  var expected = '.';
  var got = _.path.dir( src );
  test.identical( got, expected );

  var src = '.';
  var expected = '..';
  var got = _.path.dir( src );
  test.identical( got, expected );

  var src = '..';
  var expected = '../..';
  var got = _.path.dir( src );
  test.identical( got, expected );

  /* - */

  test.open( 'trailing slash' );

  var src = '/a/b/';
  var expected = '/a/';
  var got = _.path.dir( src );
  test.identical( got, expected );

  var src = '/a/b/.';
  var expected = '/a';
  var got = _.path.dir( src );
  test.identical( got, expected );

  var src = '/a/b/./';
  var expected = '/a/';
  var got = _.path.dir( src );
  test.identical( got, expected );

  var src = 'a/b/';
  var expected = 'a/';
  var got = _.path.dir( src );
  test.identical( got, expected );

  var src = 'a/b/.';
  var expected = 'a';
  var got = _.path.dir( src );
  test.identical( got, expected );

  var src = 'a/b/./';
  var expected = 'a/';
  var got = _.path.dir( src );
  test.identical( got, expected );

  test.close( 'trailing slash' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'empty path';
  test.shouldThrowErrorSync( function()
  {
    var got = _.path.dir( '' );
  });

  test.case = 'redundant argument';
  test.shouldThrowErrorSync( function()
  {
    var got = _.path.dir( 'a', 'b' );
  });

  test.case = 'passed argument is non string';
  test.shouldThrowErrorSync( function()
  {
    _.path.dir( {} );
  });

}

//

function dirFirst( test )
{

  test.case = '.';
  var src = '.';
  var expected = '../';
  var got = _.path.dirFirst( src );
  test.identical( got, expected );

  test.case = './';
  var src = './';
  var expected = './';
  var got = _.path.dirFirst( src );
  test.identical( got, expected );

  test.case = 'a/b';
  var src = 'a/b';
  var expected = 'a/';
  var got = _.path.dirFirst( src );
  test.identical( got, expected );

  test.case = 'a/b/';
  var src = 'a/b/';
  var expected = 'a/b/';
  var got = _.path.dirFirst( src );
  test.identical( got, expected );

  test.case = 'simple absolute path'; /* */
  var src = '/foo';
  var expected2 = '/';
  var got = _.path.dirFirst( src );
  test.identical( got, expected2 );

  test.case = 'absolute path : nested dirs'; /* */
  var src = '/foo/bar/baz/text.txt';
  var expected = '/foo/bar/baz/';
  var got = _.path.dirFirst( src );
  test.identical( got, expected );

  var src = '/aa/bb';
  var expected = '/aa/';
  var got = _.path.dirFirst( src );
  test.identical( got, expected );

  var src = '/aa';
  var expected = '/';
  var got = _.path.dirFirst( src );
  test.identical( got, expected );

  var src = '/';
  var expected = '/../';
  var got = _.path.dirFirst( src );
  test.identical( got, expected );

  test.case = 'relative path : nested dirs'; /* */

  var src = 'aa/bb';
  var expected = 'aa/';
  var got = _.path.dirFirst( src );
  test.identical( got, expected );

  var src = 'aa';
  var expected = './';
  var got = _.path.dirFirst( src );
  test.identical( got, expected );

  var src = 'aa/.';
  var expected = './';
  var got = _.path.dirFirst( src );
  test.identical( got, expected );

  var src = '.';
  var expected = '../';
  var got = _.path.dirFirst( src );
  test.identical( got, expected );

  var src = '..';
  var expected = '../../';
  var got = _.path.dirFirst( src );
  test.identical( got, expected );

  /* - */

  test.open( 'trailing slash' );

  var src = '/a/b/';
  var expected = '/a/b/';
  var got = _.path.dirFirst( src );
  test.identical( got, expected );

  var src = '/a/b/.';
  var expected = '/a/';
  var got = _.path.dirFirst( src );
  test.identical( got, expected );

  var src = '/a/b/./';
  var expected = '/a/b/';
  var got = _.path.dirFirst( src );
  test.identical( got, expected );

  var src = 'a/b/';
  var expected = 'a/b/';
  var got = _.path.dirFirst( src );
  test.identical( got, expected );

  var src = 'a/b/.';
  var expected = 'a/';
  var got = _.path.dirFirst( src );
  test.identical( got, expected );

  var src = 'a/b/./';
  var expected = 'a/b/';
  var got = _.path.dirFirst( src );
  test.identical( got, expected );

  test.close( 'trailing slash' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'empty path';
  test.shouldThrowErrorSync( function()
  {
    var got = _.path.dirFirst( '' );
  });

  test.case = 'redundant argument';
  test.shouldThrowErrorSync( function()
  {
    var got = _.path.dirFirst( 'a', 'b' );
  });

  test.case = 'passed argument is non string';
  test.shouldThrowErrorSync( function()
  {
    _.path.dirFirst( {} );
  });

}

//

function prefixGet( test )
{
  var path1 = '';
  var path2 = 'some.txt';
  var path3 = '/foo/bar/baz.asdf';
  var path4 = '/foo/bar/.baz';
  var path5 = '/foo.coffee.md';
  var path6 = '/foo/bar/baz';
  var expected1 = '';
  var expected2 = 'some';
  var expected3 = '/foo/bar/baz';
  var expected4 = '/foo/bar/';
  var expected5 = '/foo';
  var expected6 = '/foo/bar/baz';

  test.case = 'empty path';
  var got = _.path.prefixGet( path1 );
  test.identical( got, expected1 );

  test.case = 'txt extension';
  var got = _.path.prefixGet( path2 );
  test.identical( got, expected2 );

  test.case = 'path with non empty dir name';
  var got = _.path.prefixGet( path3 );
  test.identical( got, expected3 ) ;

  test.case = 'hidden file';
  var got = _.path.prefixGet( path4 );
  test.identical( got, expected4 );

  test.case = 'several extension';
  var got = _.path.prefixGet( path5 );
  test.identical( got, expected5 );

  test.case = 'file without extension';
  var got = _.path.prefixGet( path6 );
  test.identical( got, expected6 );

  if( !Config.debug )
  return;

  test.case = 'passed argument is non string';
  test.shouldThrowErrorSync( function()
  {
    _.path.prefixGet( null );
  });
};

//

function name( test )
{

  test.case = 'empty path';
  var got = _.path.name( '' );
  test.identical( got, '' );

  test.case = 'trailed relative';
  var got = _.path.name( 'a/name.txt/' );
  test.identical( got, 'name' );

  test.case = 'trailed absolute';
  var got = _.path.name( '/a/name.txt/' );
  test.identical( got, 'name' );

  test.case = 'relative';
  var got = _.path.name( 'some.txt' );
  test.identical( got, 'some' );

  test.case = 'relative, full : 0';
  var got = _.path.name({ path : 'some.txt', full : 0 } );
  test.identical( got, 'some' );

  test.case = 'relative, full : 1';
  var got = _.path.name({ path : 'some.txt', full : 1 } );
  test.identical( got, 'some.txt' );

  test.case = 'got file without extension';
  var got = _.path.name({ path : '/foo/bar/baz.asdf', full : 0 } );
  test.identical( got, 'baz') ;

  test.case = 'hidden file';
  var got = _.path.name({ path : '/foo/bar/.baz', full : 1 } );
  test.identical( got, '.baz' );

  test.case = 'several extension';
  var got = _.path.name( '/foo.coffee.md' );
  test.identical( got, 'foo.coffee' );

  test.case = 'file without extension';
  var got = _.path.name( '/foo/bar/baz' );
  test.identical( got, 'baz' );

  if( !Config.debug )
  return;

  test.case = 'passed argument is non string';
  test.shouldThrowErrorSync( function()
  {
    _.path.name( false );
  });

};

//

function fullName( test )
{

  test.case = 'empty path';
  var got = _.path.fullName( '' );
  test.identical( got, '' );

  test.case = 'trailed relative';
  var got = _.path.fullName( 'a/name.txt/' );
  test.identical( got, 'name.txt' );

  test.case = 'trailed absolute';
  var got = _.path.fullName( '/a/name.txt/' );
  test.identical( got, 'name.txt' );

  test.case = 'relative';
  var got = _.path.fullName( 'some.txt' );
  test.identical( got, 'some.txt' );

  test.case = 'relative, full : 0';
  var got = _.path.fullName({ path : 'some.txt', full : 0 } );
  test.identical( got, 'some' );

  test.case = 'relative, full : 1';
  var got = _.path.fullName({ path : 'some.txt', full : 1 } );
  test.identical( got, 'some.txt' );

  test.case = 'got file without extension';
  var got = _.path.fullName({ path : '/foo/bar/baz.asdf', full : 0 } );
  test.identical( got, 'baz') ;

  test.case = 'hidden file';
  var got = _.path.fullName({ path : '/foo/bar/.baz', full : 1 } );
  test.identical( got, '.baz' );

  test.case = 'several extension';
  var got = _.path.fullName( '/foo.coffee.md' );
  test.identical( got, 'foo.coffee.md' );

  test.case = 'file without extension';
  var got = _.path.fullName( '/foo/bar/baz' );
  test.identical( got, 'baz' );

  test.case = 'windows';
  var got = _.path.fullName( 'c:\\dir.ext\\terminal.ext' );
  test.identical( got, 'terminal.ext' );

  test.case = 'windows';
  var got = _.path.fullName( 'c:\\dir.ext\\terminal.ext\\..' );
  test.identical( got, 'dir.ext' );

  if( !Config.debug )
  return;

  test.case = 'passed argument is non string';
  test.shouldThrowErrorSync( function()
  {
    _.path.fullName( false );
  });

};

//

function withoutExt( test )
{

  test.case = 'empty path';
  var path = '';
  var expected = '';
  var got = _.path.withoutExt( path );
  test.identical( got, expected );

  /* */

  test.case = 'txt extension';
  var path = 'some.txt';
  var expected = 'some';
  var got = _.path.withoutExt( path );
  test.identical( got, expected );

  /* */

  test.case = 'path with non empty dir name';
  var path = '/foo/bar/baz.asdf';
  var expected = '/foo/bar/baz';
  var got = _.path.withoutExt( path );
  test.identical( got, expected ) ;

  /* */

  test.case = 'hidden file';
  var path = '/foo/bar/.baz';
  var expected = '/foo/bar/.baz';
  var got = _.path.withoutExt( path );
  test.identical( got, expected );

  /* */

  test.case = 'file with composite file name';
  var path = '/foo.coffee.md';
  var expected = '/foo.coffee';
  var got = _.path.withoutExt( path );
  test.identical( got, expected );

  /* */

  test.case = 'path without extension';
  var path = '/foo/bar/baz';
  var expected = '/foo/bar/baz';
  var got = _.path.withoutExt( path );
  test.identical( got, expected );

  /* */

  test.case = 'relative path #1';
  var got = _.path.withoutExt( './foo/.baz' );
  var expected = './foo/.baz';
  test.identical( got, expected );

  /* */

  test.case = 'relative path #2';
  var got = _.path.withoutExt( './.baz' );
  var expected = './.baz';
  test.identical( got, expected );

  /* */

  test.case = 'relative path #3';
  var got = _.path.withoutExt( '.baz.txt' );
  var expected = '.baz';
  test.identical( got, expected );

  /* */

  test.case = 'relative path #4';
  var got = _.path.withoutExt( './baz.txt' );
  var expected = './baz';
  test.identical( got, expected );

  /* */

  test.case = 'relative path #5';
  var got = _.path.withoutExt( './foo/baz.txt' );
  var expected = './foo/baz';
  test.identical( got, expected );

  /* */

  test.case = 'relative path #6';
  var got = _.path.withoutExt( './foo/' );
  var expected = './foo/';
  test.identical( got, expected );

  /* */

  test.case = 'relative path #7';
  var got = _.path.withoutExt( 'baz' );
  var expected = 'baz';
  test.identical( got, expected );

  /* */

  test.case = 'relative path #8';
  var got = _.path.withoutExt( 'baz.a.b' );
  var expected = 'baz.a';
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'passed argument is non string';
  test.shouldThrowErrorSync( function()
  {
    _.path.withoutExt( null );
  });
};

//

function changeExt( test )
{
  test.case = 'empty ext';
  var got = _.path.changeExt( 'some.txt', '' );
  var expected = 'some';
  test.identical( got, expected );

  /* */

  test.case = 'simple change extension';
  var got = _.path.changeExt( 'some.txt', 'json' );
  var expected = 'some.json';
  test.identical( got, expected );

  /* */

  test.case = 'path with non empty dir name';
  var got = _.path.changeExt( '/foo/bar/baz.asdf', 'txt' );
  var expected = '/foo/bar/baz.txt';
  test.identical( got, expected) ;

  /* */

  test.case = 'change extension of hidden file';
  var got = _.path.changeExt( '/foo/bar/.baz', 'sh' );
  var expected = '/foo/bar/.baz.sh';
  test.identical( got, expected );

  /* */

  test.case = 'change extension in composite file name';
  var got = _.path.changeExt( '/foo.coffee.md', 'min' );
  var expected = '/foo.coffee.min';
  test.identical( got, expected );

  /* */

  test.case = 'add extension to file without extension';
  var got = _.path.changeExt( '/foo/bar/baz', 'txt' );
  var expected = '/foo/bar/baz.txt';
  test.identical( got, expected );

  /* */

  test.case = 'path folder contains dot, file without extension';
  var got = _.path.changeExt( '/foo/baz.bar/some.md', 'txt' );
  var expected = '/foo/baz.bar/some.txt';
  test.identical( got, expected );

  /* */

  test.case = 'relative path #1';
  var got = _.path.changeExt( './foo/.baz', 'txt' );
  var expected = './foo/.baz.txt';
  test.identical( got, expected );

  /* */

  test.case = 'relative path #2';
  var got = _.path.changeExt( './.baz', 'txt' );
  var expected = './.baz.txt';
  test.identical( got, expected );

  /* */

  test.case = 'relative path #3';
  var got = _.path.changeExt( '.baz', 'txt' );
  var expected = '.baz.txt';
  test.identical( got, expected );

  /* */

  test.case = 'relative path #4';
  var got = _.path.changeExt( './baz', 'txt' );
  var expected = './baz.txt';
  test.identical( got, expected );

  /* */

  test.case = 'relative path #5';
  var got = _.path.changeExt( './foo/baz', 'txt' );
  var expected = './foo/baz.txt';
  test.identical( got, expected );

  /* */

  test.case = 'relative path #6';
  var got = _.path.changeExt( './foo/', 'txt' );
  var expected = './foo/.txt';
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'passed argument is non string';
  test.shouldThrowErrorSync( function()
  {
    _.path.changeExt( null, '' );
  });

}

//

function ext( test )
{
  test.case = 'empty path';
  var got = _.path.ext( '' );
  test.identical( got, '' );

  test.case = 'txt extension';
  var got = _.path.ext( 'some.txt' );
  test.identical( got, 'txt' );

  test.case = 'path with non empty dir name';
  var got = _.path.ext( '/foo/bar/baz.asdf' );
  test.identical( got, 'asdf' ) ;

  test.case = 'hidden file';
  var got = _.path.ext( '/foo/bar/.baz' );
  test.identical( got, '' );

  test.case = 'several extension';
  var got = _.path.ext( '/foo.coffee.md' );
  test.identical( got, 'md' );

  test.case = 'file without extension';
  var got = _.path.ext( '/foo/bar/baz' );
  test.identical( got, '' );

  if( !Config.debug )
  return;

  test.case = 'passed argument is non string';
  test.shouldThrowErrorSync( () => _.path.ext( null ) );
}

//

function relative( test )
{
  var got;

  test.open( 'absolute' );

  test.case = '/a - /b'; /* */
  var from = '/a';
  var to = '/b';
  var expected = '../b';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = '/a - /b'; /* */
  var from = '/a';
  var to = '/b';
  var expected = '../b';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = '/ - /b'; /* */
  var from = '/';
  var to = '/b';
  var expected = 'b';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'same path'; /* */
  var from = '/aa/bb/cc';
  var to = '/aa/bb/cc';
  var expected = '.';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'same path'; /* */
  var from = '/aa/bb/cc';
  var to = '/aa/bb/cc/';
  var expected = './';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'two trailed absolute paths'; /* */
  var from = '/a/b/';
  var to = '/a/b/';
  var expected = './';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'two absolute paths'; /* */
  var from = '/a/b';
  var to = '/a/b/';
  var expected = './';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'two absolute paths'; /* */
  var from = '/a/b/';
  var to = '/a/b';
  var expected = '.';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'same path'; /* */
  var from = '/aa/bb/cc/';
  var to = '/aa/bb/cc';
  var expected = '.';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'same path'; /* */
  var from = '/a';
  var to = '//b';
  var expected = '..//b';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'same path'; /* */
  var from = '/a/';
  var to = '//b/';
  var expected = './..//b/';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = '4 down'; /* */
  var basePath = '/aa//bb/cc/';
  var filePath = '//xx/yy/zz/';
  var expected = './../../../..//xx/yy/zz/';
  var got = _.path.relative( basePath, filePath );
  test.identical( got, expected );

  test.case = 'same length, both trailed'; /* */
  var from = '/aa//bb/cc/';
  var to = '//xx/yy/zz/';
  var expected = './../../../..//xx/yy/zz/';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'relative to parent directory'; /* */
  var from = '/aa/bb/cc';
  var to = '/aa/bb';
  var expected = '..';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'relative to parent directory, base is trailed'; /* */
  var from = '/aa/bb/cc/';
  var to = '/aa/bb';
  var expected = './..';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'relative to parent directory, file is trailed'; /* */
  var from = '/aa/bb/cc';
  var to = '/aa/bb/';
  var expected = '../';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'relative to parent directory, both are trailed'; /* */
  var from = '/aa/bb/cc/';
  var to = '/aa/bb/';
  var expected = './../';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'relative to nested'; /* */
  var from = '/foo/bar/baz/asdf/quux';
  var to = '/foo/bar/baz/asdf/quux/new1';
  var expected = 'new1';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'out of relative dir'; /* */
  var from = '/abc';
  var to = '/a/b/z';
  var expected = '../a/b/z';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'relative root'; /* */
  var from = '/';
  var to = '/a/b/z';
  var expected = 'a/b/z';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'relative root'; /* */
  var from = '/';
  var to = '/';
  var expected = '.';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'windows disks'; /* */
  var from = 'd:/';
  var to = 'c:/x/y';
  var expected = '../c/x/y';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'long, not direct'; /* */
  var from = '/a/b/xx/yy/zz';
  var to = '/a/b/files/x/y/z.txt';
  var expected = '../../../files/x/y/z.txt';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.close( 'absolute' );

  //

  test.open( 'relative' );

  test.case = '. - .'; /* */
  var from = '.';
  var to = '.';
  var expected = '.';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'a - b'; /* */
  var from = 'a';
  var to = 'b';
  var expected = '../b';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'a/b - b/c'; /* */
  var from = 'a/b';
  var to = 'b/c';
  var expected = '../../b/c';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'a/b - a/b/c'; /* */
  var from = 'a/b';
  var to = 'a/b/c';
  var expected = 'c';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'a/b/c - a/b'; /* */
  var from = 'a/b/c';
  var to = 'a/b';
  var expected = '..';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'a/b/c - a/b'; /* */
  var from = 'a/b/c';
  var to = 'a/b';
  var expected = '..';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'a/b/c/d - a/b/d/c'; /* */
  var from = 'a/b/c/d';
  var to = 'a/b/d/c';
  var expected = '../../d/c';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'a - ../a'; /* */
  var from = 'a';
  var to = '../a';
  var expected = '../../a';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'a//b - a//c'; /* */
  var from = 'a//b';
  var to = 'a//c';
  var expected = '../c';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'a/./b - a/./c'; /* */
  var from = 'a/./b';
  var to = 'a/./c';
  var expected = '../c';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'a/../b - b'; /* */
  var from = 'a/../b';
  var to = 'b';
  var expected = '.';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'b - b/../b'; /* */
  var from = 'b';
  var to = 'b/../b';
  var expected = '.';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = '. - ..'; /* */
  var from = '.';
  var to = '..';
  var expected = '..';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = '. - ../..'; /* */
  var from = '.';
  var to = '../..';
  var expected = '../..';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = '.. - ../..'; /* */
  var from = '..';
  var to = '../..';
  var expected = '..';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = '.. - ..'; /* */
  var from = '..';
  var to = '..';
  var expected = '.';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = '../a/b - ../c/d'; /* */
  var from = '../a/b';
  var to = '../c/d';
  var expected = '../../c/d';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  /* */

  test.case = '. - b';
  var from = '.';
  var to = 'b';
  var expected = 'b';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = './ - b';
  var from = './';
  var to = 'b';
  var expected = './b';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = '. - b/';
  var from = '.';
  var to = 'b/';
  var expected = 'b/';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = './ - b/';
  var from = './';
  var to = 'b/';
  var expected = './b/';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  /* */

  /* */

  test.case = 'a/../b/.. - b';
  var from = 'a/../b/..';
  var to = 'b';
  var expected = 'b';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.close( 'relative' );

  /* - */

  if( !Config.debug )
  return;

  test.open( 'relative' );

  test.shouldThrowErrorSync( () =>
  {
    test.case = '.. - b';
    var from = '..';
    var to = 'b';
    var expected = '../b';
    var got = _.path.relative( from, to );
    test.identical( got, expected );
  });

  test.shouldThrowErrorSync( () =>
  {
    test.case = '../ - b';
    var from = '../';
    var to = 'b';
    var expected = '../b';
    var got = _.path.relative( from, to );
    test.identical( got, expected );
  });

  test.shouldThrowErrorSync( () =>
  {
    test.case = '.. - b/';
    var from = '..';
    var to = 'b/';
    var expected = '../b';
    var got = _.path.relative( from, to );
    test.identical( got, expected );
  });

  test.shouldThrowErrorSync( () =>
  {
    test.case = '../ - b/';
    var from = '../';
    var to = 'b/';
    var expected = '../b';
    var got = _.path.relative( from, to );
    test.identical( got, expected );
  });

  test.case = '../a/b - .'; /* */
  var from = '../a/b';
  var to = '.';
  test.shouldThrowErrorOfAnyKind( () => _.path.relative( from, to ) );

  test.case = '../a/b - ./c/d'; /* */
  var from = '../a/b';
  var to = './c/d';
  test.shouldThrowErrorOfAnyKind( () => _.path.relative( from, to ) );

  test.case = '.. - .'; /* */
  var from = '..';
  var to = '.';
  test.shouldThrowErrorOfAnyKind( () => _.path.relative( from, to ) );

  test.case = '.. - ./a'; /* */
  var from = '..';
  var to = './a';
  test.shouldThrowErrorOfAnyKind( () => _.path.relative( from, to ) );

  test.case = '../a - a'; /* */
  var from = '../a';
  var to = 'a';
  test.shouldThrowErrorOfAnyKind( () => _.path.relative( from, to ) );

  test.close( 'relative' );

  //

  test.open( 'other' )

  test.case = 'missed arguments';
  test.shouldThrowErrorSync( function( )
  {
    _.path.relative( from );
  });

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( function( )
  {
    _.path.relative( 'from3', 'to3', 'to4' );
  });

  test.case = 'second argument is not string or array';
  test.shouldThrowErrorSync( function( )
  {
    _.path.relative( 'from3', null );
  });

  test.case = 'relative + absolute';
  test.shouldThrowErrorSync( function( )
  {
    _.path.relative( '.', '/' );
  });

  test.close( 'other' )

};

//

function relativeWithOptions( test )
{

  test.open( 'old cases' )

  test.case = 'both relative, long, not direct, resolving : 0'; /* */
  var from = 'a/b/xx/yy/zz';
  var to = 'a/b/files/x/y/z.txt';
  var expected = '../../../files/x/y/z.txt';
  var got = _.path.relative({ basePath : from, filePath : to, resolving : 0 });
  test.identical( got, expected );

  test.case = 'both relative, long, not direct, resolving : 1'; /* */
  var from = 'a/b/xx/yy/zz';
  var to = 'a/b/files/x/y/z.txt';
  var expected = '../../../files/x/y/z.txt';
  var got = _.path.relative({ basePath : from, filePath : to, resolving : 1 });
  test.identical( got, expected );

  test.case = 'one relative, resolving 1'; /* */
  var current = _.path.current();
  var upStr = '/';

  //

  test.case = 'with colon'; /* */
  var from = 'c:/x/y';
  var to = 'a/b/files/x/y/z.txt';
  var expected = '../../../a/b/files/x/y/z.txt';
  if( current !== upStr )
  expected = '../../..' + _.path.join( current, to );
  var got = _.path.relative({ basePath :  from, filePath : to, resolving : 1 });
  test.identical( got, expected );

  //

  var from = 'a/b/files/x/y/z.txt';
  var to = 'c:/x/y';
  var expected = '../../../../../../c/x/y';
  if( current !== upStr )
  {
    var outOfCurrent = _.path.relative( current, upStr );
    var toNormalized = _.path.normalize( to );
    expected = outOfCurrent + '../../../../../..' + toNormalized;
  }
  test.identical( from, 'a/b/files/x/y/z.txt' );
  test.identical( to, 'c:/x/y' );
  var got = _.path.relative({ basePath : from, filePath : to, resolving : 1 });
  test.identical( got, expected );

  test.case = 'one relative, resolving 0'; /* */

  var from = 'c:/x/y';
  var to = 'a/b/files/x/y/z.txt';
  var expected = '../../../files/x/y/z.txt';
  test.shouldThrowErrorSync( function()
  {
    _.path.relative({ basePath : from, filePath : to, resolving : 0 });
  })

  test.close( 'old cases' )

  /* - */

  if( !Config.debug )
  return;

  test.open( 'relative, resolving : 0' )

  test.case = '../a/b - .'; /* */
  var from = '../a/b';
  var to = '.';
  test.shouldThrowErrorOfAnyKind( () => _.path.relative({ basePath : from, filePath : to, resolving : 0 }) );

  test.case = '../a/b - ./c/d'; /* */
  var from = '../a/b';
  var to = './c/d';
  test.shouldThrowErrorOfAnyKind( () => _.path.relative({ basePath : from, filePath : to, resolving : 0 }) );

  test.case = '.. - .'; /* */
  var from = '..';
  var to = '.';
  test.shouldThrowErrorOfAnyKind( () => _.path.relative({ basePath : from, filePath : to, resolving : 0 }) );

  test.case = '.. - ./a'; /* */
  var from = '..';
  var to = './a';
  test.shouldThrowErrorOfAnyKind( () => _.path.relative({ basePath : from, filePath : to, resolving : 0 }) );

  test.case = '../a - a'; /* */
  var from = '../a';
  var to = 'a';
  test.shouldThrowErrorOfAnyKind( () => _.path.relative({ basePath : from, filePath : to, resolving : 0 }) );

  test.close( 'relative, resolving : 0' )

  //

  test.open( 'relative, resolving : 1' )

  let levels = _.strCount( _.path.current(), '/' );
  let prefixFrom = _.strDup( '../', levels - 1 );

  test.case = '../a/b - .'; /* */
  var from = prefixFrom + '../a/b';
  var to = '.';

  if( _.path.current() === '/' )
  {

    test.case = '../a/b - ./c/d'; /* */
    var from1 = prefixFrom + '../a/b';
    var to1 = './c/d';
    test.shouldThrowErrorOfAnyKind( () => _.path.relative({ basePath : from1, filePath : to1, resolving : 1 }) );

    test.case = '../a/b - ../c/d'; /* */
    var from1 = prefixFrom + '../a/b';
    var to1 = '../c/d';
    test.shouldThrowErrorOfAnyKind( () => _.path.relative({ basePath : from1, filePath : to1, resolving : 1 }) );

    test.case = '.. - .'; /* */
    var from1 = prefixFrom + '..';
    var to1 = '.';
    test.shouldThrowErrorOfAnyKind( () => _.path.relative({ basePath : from1, filePath : to1, resolving : 1 }) );

    test.case = '.. - ./a'; /* */
    var from1 = prefixFrom + '..';
    var to1 = './a';
    test.shouldThrowErrorOfAnyKind( () => _.path.relative({ basePath : from1, filePath : to1, resolving : 1 }) );

    test.case = '../a - a'; /* */
    var from1 = prefixFrom + '../a';
    var to1 = 'a';
    test.shouldThrowErrorOfAnyKind( () => _.path.relative({ basePath : from1, filePath : to1, resolving : 1 }) );

  }

  test.close( 'relative, resolving : 1' )

}

//

function common( test )
{

  test.case = 'without arguments';
  var got = _.path.common();
  test.identical( got, null );

  test.case = 'with empty array';
  var got = _.path.common( [] );
  test.identical( got, null );

  /* */

  test.case = 'array';

  var got = _.path.common([ '/a1/b2', '/a1/b' ]);
  test.identical( got, '/a1/' );

  var got = _.path.common( [ '/a1/b1/c', '/a1/b1/d' ], '/a1/b2' );
  test.identical( got, '/a1/' );

  /* - */

  test.open( 'absolute-absolute' );

  test.case = 'have common dir';
  var got = _.path.common( '/a1/b2', '/a1/a' );
  test.identical( got, '/a1/' );

  test.case = 'have common dir and part of name';
  var got = _.path.common( '/a1/b2', '/a1/b1' );
  test.identical( got, '/a1/' );

  test.case = 'one path has dots, identical paths';
  var got = _.path.common( '/a1/x/../b1', '/a1/b1' );
  test.identical( got, '/a1/b1' );

  test.case = 'more than one dir in common path';
  var got = _.path.common( '/a1/b1/c1', '/a1/b1/c' );
  test.identical( got, '/a1/b1/' );

  test.case = 'one path have dots, no common dirs';
  var got = _.path.common( '/a1/../../b1/c1', '/a1/b1/c1' );
  test.identical( got, '/' );

  test.case = 'dir name is a part of another dir name';
  var got = _.path.common( '/abcd', '/ab' );
  test.identical( got, '/' );

  test.case = 'dir names has dots, have common path';
  var got = _.path.common( '/.a./.b./.c.', '/.a./.b./.c' );
  test.identical( got, '/.a./.b./' );

  test.case = 'one path has several slashes, the other has not, not identical';
  var got = _.path.common( '//a//b//c', '/a/b' );
  test.identical( got, '/' );

  test.case = 'identical paths with several slashes';
  var got = _.path.common( '/a//b', '/a//b' );
  test.identical( got, '/a//b' );

  var got = _.path.common( '/a//', '/a//' );
  test.identical( got, '/a//' );

  test.case = 'one path has hereToken dirs, identical paths';
  var got = _.path.common( '/./a/./b/./c', '/a/b' );
  test.identical( got, '/a/b' );

  test.case = 'different case in path name, not identical';
  var got = _.path.common( '/A/b/c', '/a/b/c' );
  test.identical( got, '/' );

  test.case = 'one path is root directory, common root directory';
  var got = _.path.common( '/', '/x' );
  test.identical( got, '/' );

  test.case = 'different paths in root directory, common root directory';
  var got = _.path.common( '/a', '/x' );
  test.identical( got, '/' );

  /* */

  test.case = 'more than 2 path in arguments';

  var got = _.path.common( '/a/b/c', '/a/b/c', '/a/b/c', '/a/b/c' );
  test.identical( got, '/a/b/c' );

  var got = _.path.common( '/a/b/c', '/a/b/c', '/a/b' );
  test.identical( got, '/a/b' );

  var got = _.path.common( '/a/b/c', '/a/b/c', '/a/b1' );
  test.identical( got, '/a/' );

  var got = _.path.common( '/a/b/c', '/a/b/c', '/a' );
  test.identical( got, '/a' );

  var got = _.path.common( '/a/b/c', '/a/b/c', '/x' );
  test.identical( got, '/' );

  var got = _.path.common( '/a/b/c', '/a/b/c', '/' );
  test.identical( got, '/' );

  test.close( 'absolute-absolute' );

  /* - */

  test.open( 'absolute-relative' );

  test.case = 'root and downToken';
  var got = _.path.common( '/', '..' );
  test.identical( got, '/' );

  test.case = 'root and hereToken';
  var got = _.path.common( '/', '.' );
  test.identical( got, '/' );

  test.case = 'root and some relative directory';
  var got = _.path.common( '/', 'x' );
  test.identical( got, '/' );

  test.case = 'root and double downToken in path';
  var got = _.path.common( '/', '../..' );
  test.identical( got, '/' );

  test.case = 'root with hereToken and downToken';
  var got = _.path.common( '/.', '..' );
  test.identical( got, '/' );

  test.case = 'root with hereToken and hereToken';
  var got = _.path.common( '/.', '.' );
  test.identical( got, '/' );

  test.case = 'root with hereToken and some relative directory';
  var got = _.path.common( '/.', 'x' );
  test.identical( got, '/' );

  test.case = 'root with hereToken and double downToken in path';
  var got = _.path.common( '/.', '../..' );
  test.identical( got, '/' );

  test.close( 'absolute-relative' );

  /* - */

  test.open( 'relative-relative' );

  test.case = 'common dir';
  var got = _.path.common( 'a1/b2', 'a1/a' );
  test.identical( got, 'a1/' );

  test.case = 'common dir and part of dir names';
  var got = _.path.common( 'a1/b2', 'a1/b1' );
  test.identical( got, 'a1/' );

  test.case = 'one path with downToken dir, identical paths';
  var got = _.path.common( 'a1/x/../b1', 'a1/b1' );
  test.identical( got, 'a1/b1' );

  test.case = 'paths begins with hereToken directory, dots, identical paths';
  var got = _.path.common( './a1/x/../b1', './a1/b1' );
  test.identical( got, 'a1/b1');

  test.case = 'one path begins with hereToken dir, another downToken,';
  var got = _.path.common( './a1/x/../b1', '../a1/b1' );
  test.identical( got, '..');

  test.case = 'hereToken and downToken';
  var got = _.path.common( '.', '..' );
  test.identical( got, '..' );

  test.case = 'diffent paths start with hereToken dir';
  var got = _.path.common( './b/c', './x' );
  test.identical( got, '.' );

  test.case = 'combinations of paths with dots';

  var got = _.path.common( './././a', './a/b' );
  test.identical( got, 'a' );

  var got = _.path.common( './a/./b', './a/b' );
  test.identical( got, 'a/b' );

  var got = _.path.common( './a/./b', './a/c/../b' );
  test.identical( got, 'a/b' );

  var got = _.path.common( '../b/c', './x' );
  test.identical( got, '..' );

  var got = _.path.common( '../../b/c', '../b' );
  test.identical( got, '../..' );

  var got = _.path.common( '../../b/c', '../../../x' );
  test.identical( got, '../../..' );

  var got = _.path.common( '../../b/c/../../x', '../../../x' );
  test.identical( got, '../../..' );

  var got = _.path.common( './../../b/c/../../x', './../../../x' );
  test.identical( got, '../../..' );

  var got = _.path.common( '../../..', './../../..' );
  test.identical( got, '../../..' );

  var got = _.path.common( './../../..', './../../..' );
  test.identical( got, '../../..' );

  var got = _.path.common( '../../..', '../../..' );
  test.identical( got, '../../..' );

  var got = _.path.common( '../b', '../b' );
  test.identical( got, '../b' );

  var got = _.path.common( '../b', './../b' );
  test.identical( got, '../b' );

  test.case = 'several relative paths';

  var got = _.path.common( 'a/b/c', 'a/b/c', 'a/b/c' );
  test.identical( got, 'a/b/c' );

  var got = _.path.common( 'a/b/c', 'a/b/c', 'a/b' );
  test.identical( got, 'a/b' );

  var got = _.path.common( 'a/b/c', 'a/b/c', 'a/b1' );
  test.identical( got, 'a/' );

  var got = _.path.common( 'a/b/c', 'a/b/c', '.' );
  test.identical( got, '.' );

  var got = _.path.common( 'a/b/c', 'a/b/c', 'x' );
  test.identical( got, '.' );

  var got = _.path.common( 'a/b/c', 'a/b/c', './' );
  test.identical( got, '.' );

  var got = _.path.common( '../a/b/c', 'a/../b/c', 'a/b/../c' );
  test.identical( got, '..' );

  var got = _.path.common( './a/b/c', '../../a/b/c', '../../../a/b' );
  test.identical( got, '../../..' );

  var got = _.path.common( '.', './', '..' );
  test.identical( got, '..' );

  var got = _.path.common( '.', './../..', '..' );
  test.identical( got, '../..' );

  test.close( 'relative-relative' );

  /* - */

  test.case = 'mixed array argument with path and string, absolute paths';
  var got = _.path.common( [ '/a1/b2', '/a1/b' ], '/a1/c' );
  test.identical( got, '/a1/' );

  test.case = 'mixed array argument with path and string, relative paths';
  var got = _.path.common( [ './a1/b2', './a1/b' ], './a1/c' );
  test.identical( got, 'a1/' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'first path is absolute, another is dots';
  test.shouldThrowErrorOfAnyKind( () => _.path.common( '/a', '..' ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.common( '/a', '.' ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.common( '/a', '../..' ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.common( '/a/b/c', '/a/b/c', './' ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.common( '/a/b/c', '/a/b/c', '.' ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.common( '/a/b/c', '..', '/a' ) );

  test.case = 'first path is dots, and absolute path';
  test.shouldThrowErrorOfAnyKind( () => _.path.common( '../..', '../../b/c', '/a' ) );

  test.case = 'unknown path';
  test.shouldThrowErrorOfAnyKind( () => _.path.common( '/a', 'x' ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.common( 'x', '/a/b/c', '/a' ) );

}

//

function common_( test )
{

  test.case = 'without arguments';
  var got = _.path.common_();
  test.identical( got, null );

  test.case = 'with empty array';
  var got = _.path.common_( [] );
  test.identical( got, null );

  /* */

  test.case = 'array';

  var got = _.path.common_([ '/a1/b2', '/a1/b' ]);
  test.identical( got, '/a1/' );

  var got = _.path.common_( [ '/a1/b1/c', '/a1/b1/d' ], '/a1/b2' );
  test.identical( got, '/a1/' );

  /* - */

  test.open( 'absolute-absolute' );

  test.case = 'have common dir';
  var got = _.path.common_( '/a1/b2', '/a1/a' );
  test.identical( got, '/a1/' );

  test.case = 'have common dir and part of name';
  var got = _.path.common_( '/a1/b2', '/a1/b1' );
  test.identical( got, '/a1/' );

  test.case = 'one path has dots, identical paths';
  var got = _.path.common_( '/a1/x/../b1', '/a1/b1' );
  test.identical( got, '/a1/b1' );

  test.case = 'more than one dir in common path';
  var got = _.path.common_( '/a1/b1/c1', '/a1/b1/c' );
  test.identical( got, '/a1/b1/' );

  test.case = 'one path have dots, no common dirs';
  var got = _.path.common_( '/a1/../../b1/c1', '/a1/b1/c1' );
  test.identical( got, '/' );

  test.case = 'dir name is a part of another dir name';
  var got = _.path.common_( '/abcd', '/ab' );
  test.identical( got, '/' );

  test.case = 'dir names has dots, have common path';
  var got = _.path.common_( '/.a./.b./.c.', '/.a./.b./.c' );
  test.identical( got, '/.a./.b./' );

  test.case = 'one path has several slashes, the other has not, not identical';
  var got = _.path.common_( '//a//b//c', '/a/b' );
  test.identical( got, '/' );

  test.case = 'identical paths with several slashes';
  var got = _.path.common_( '/a//b', '/a//b' );
  test.identical( got, '/a//b' );

  var got = _.path.common_( '/a//', '/a//' );
  test.identical( got, '/a//' );

  test.case = 'one path has hereToken dirs, identical paths';
  var got = _.path.common_( '/./a/./b/./c', '/a/b' );
  test.identical( got, '/a/b' );

  test.case = 'different case in path name, not identical';
  var got = _.path.common_( '/A/b/c', '/a/b/c' );
  test.identical( got, '/' );

  test.case = 'one path is root directory, common root directory';
  var got = _.path.common_( '/', '/x' );
  test.identical( got, '/' );

  test.case = 'different paths in root directory, common root directory';
  var got = _.path.common_( '/a', '/x' );
  test.identical( got, '/' );

  /* */

  test.case = 'more than 2 path in arguments';

  var got = _.path.common_( '/a/b/c', '/a/b/c', '/a/b/c', '/a/b/c' );
  test.identical( got, '/a/b/c' );

  var got = _.path.common_( '/a/b/c', '/a/b/c', '/a/b' );
  test.identical( got, '/a/b' );

  var got = _.path.common_( '/a/b/c', '/a/b/c', '/a/b1' );
  test.identical( got, '/a/' );

  var got = _.path.common_( '/a/b/c', '/a/b/c', '/a' );
  test.identical( got, '/a' );

  var got = _.path.common_( '/a/b/c', '/a/b/c', '/x' );
  test.identical( got, '/' );

  var got = _.path.common_( '/a/b/c', '/a/b/c', '/' );
  test.identical( got, '/' );

  test.close( 'absolute-absolute' );

  /* - */

  test.open( 'absolute-relative' );

  test.case = 'root and downToken';
  var got = _.path.common_( '/', '..' );
  test.identical( got, '/' );

  test.case = 'root and hereToken';
  var got = _.path.common_( '/', '.' );
  test.identical( got, '/' );

  test.case = 'root and some relative directory';
  var got = _.path.common_( '/', 'x' );
  test.identical( got, '/' );

  test.case = 'root and double downToken in path';
  var got = _.path.common_( '/', '../..' );
  test.identical( got, '/' );

  test.case = 'root with hereToken and downToken';
  var got = _.path.common_( '/.', '..' );
  test.identical( got, '/' );

  test.case = 'root with hereToken and hereToken';
  var got = _.path.common_( '/.', '.' );
  test.identical( got, '/' );

  test.case = 'root with hereToken and some relative directory';
  var got = _.path.common_( '/.', 'x' );
  test.identical( got, '/' );

  test.case = 'root with hereToken and double downToken in path';
  var got = _.path.common_( '/.', '../..' );
  test.identical( got, '/' );

  test.close( 'absolute-relative' );

  /* - */

  test.open( 'relative-relative' );

  test.case = 'common dir';
  var got = _.path.common_( 'a1/b2', 'a1/a' );
  test.identical( got, 'a1/' );

  test.case = 'common dir and part of dir names';
  var got = _.path.common_( 'a1/b2', 'a1/b1' );
  test.identical( got, 'a1/' );

  test.case = 'one path with downToken dir, identical paths';
  var got = _.path.common_( 'a1/x/../b1', 'a1/b1' );
  test.identical( got, 'a1/b1' );

  test.case = 'paths begins with hereToken directory, dots, identical paths';
  var got = _.path.common_( './a1/x/../b1', './a1/b1' );
  test.identical( got, 'a1/b1');

  test.case = 'one path begins with hereToken dir, another downToken,';
  var got = _.path.common_( './a1/x/../b1', '../a1/b1' );
  test.identical( got, '..');

  test.case = 'hereToken and downToken';
  var got = _.path.common_( '.', '..' );
  test.identical( got, '..' );

  test.case = 'diffent paths start with hereToken dir';
  var got = _.path.common_( './b/c', './x' );
  test.identical( got, '.' );

  test.case = 'combinations of paths with dots';

  var got = _.path.common_( './././a', './a/b' );
  test.identical( got, 'a' );

  var got = _.path.common_( './a/./b', './a/b' );
  test.identical( got, 'a/b' );

  var got = _.path.common_( './a/./b', './a/c/../b' );
  test.identical( got, 'a/b' );

  var got = _.path.common_( '../b/c', './x' );
  test.identical( got, '..' );

  var got = _.path.common_( '../../b/c', '../b' );
  test.identical( got, '../..' );

  var got = _.path.common_( '../../b/c', '../../../x' );
  test.identical( got, '../../..' );

  var got = _.path.common_( '../../b/c/../../x', '../../../x' );
  test.identical( got, '../../..' );

  var got = _.path.common_( './../../b/c/../../x', './../../../x' );
  test.identical( got, '../../..' );

  var got = _.path.common_( '../../..', './../../..' );
  test.identical( got, '../../..' );

  var got = _.path.common_( './../../..', './../../..' );
  test.identical( got, '../../..' );

  var got = _.path.common_( '../../..', '../../..' );
  test.identical( got, '../../..' );

  var got = _.path.common_( '../b', '../b' );
  test.identical( got, '../b' );

  var got = _.path.common_( '../b', './../b' );
  test.identical( got, '../b' );

  test.case = 'several relative paths';

  var got = _.path.common_( 'a/b/c', 'a/b/c', 'a/b/c' );
  test.identical( got, 'a/b/c' );

  var got = _.path.common_( 'a/b/c', 'a/b/c', 'a/b' );
  test.identical( got, 'a/b' );

  var got = _.path.common_( 'a/b/c', 'a/b/c', 'a/b1' );
  test.identical( got, 'a/' );

  var got = _.path.common_( 'a/b/c', 'a/b/c', '.' );
  test.identical( got, '.' );

  var got = _.path.common_( 'a/b/c', 'a/b/c', 'x' );
  test.identical( got, '.' );

  var got = _.path.common_( 'a/b/c', 'a/b/c', './' );
  test.identical( got, '.' );

  var got = _.path.common_( '../a/b/c', 'a/../b/c', 'a/b/../c' );
  test.identical( got, '..' );

  var got = _.path.common_( './a/b/c', '../../a/b/c', '../../../a/b' );
  test.identical( got, '../../..' );

  var got = _.path.common_( '.', './', '..' );
  test.identical( got, '..' );

  var got = _.path.common_( '.', './../..', '..' );
  test.identical( got, '../..' );

  test.close( 'relative-relative' );

  /* - */

  test.case = 'mixed array argument with path and string, absolute paths';
  var got = _.path.common_( [ '/a1/b2', '/a1/b' ], '/a1/c' );
  test.identical( got, '/a1/' );

  test.case = 'mixed array argument with path and string, relative paths';
  var got = _.path.common_( [ './a1/b2', './a1/b' ], './a1/c' );
  test.identical( got, 'a1/' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'first path is absolute, another is dots';
  test.shouldThrowErrorOfAnyKind( () => _.path.common_( '/a', '..' ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.common_( '/a', '.' ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.common_( '/a', '../..' ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.common_( '/a/b/c', '/a/b/c', './' ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.common_( '/a/b/c', '/a/b/c', '.' ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.common_( '/a/b/c', '..', '/a' ) );

  test.case = 'first path is dots, and absolute path';
  test.shouldThrowErrorOfAnyKind( () => _.path.common_( '../..', '../../b/c', '/a' ) );

  test.case = 'unknown path';
  test.shouldThrowErrorOfAnyKind( () => _.path.common_( '/a', 'x' ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.common_( 'x', '/a/b/c', '/a' ) );
}

// --
// reporter
// --

function groupTextualReport( test )
{
  let defaults =
  {
    explanation : '',
    groupsMap : null,
    verbosity : 3,
    spentTime : null,
  }

  test.case = 'defaults';
  var got = _.path.groupTextualReport( _.props.extend( null, defaults ) );
  var expected = '0 file(s)';
  test.identical( got, expected );

  test.case = 'explanation only';
  var o =
  {
    explanation : '- Deleted '
  }
  var got = _.path.groupTextualReport( _.props.extend( null, defaults, o ) );
  var expected = '- Deleted 0 file(s)';
  test.identical( got, expected );

  test.case = 'spentTime only';
  var o =
  {
    spentTime : 5000
  }
  var got = _.path.groupTextualReport( _.props.extend( null, defaults, o ) );
  var expected = '0 file(s), in 5.000s';
  test.identical( got, expected );

  test.open( 'locals' )

  test.case = 'groupsMap only';
  var o =
  {
    groupsMap :
    {
      '/' : [ '/a', '/a/b', '/b', '/b/c' ],
      '/a' : [ '/a', '/a/b' ],
      '/b' : [ '/b', '/b/c' ]
    }
  }
  var got = _.path.groupTextualReport( _.props.extend( null, defaults, o ) );
  var expected =
  [
    '   4 at /',
    '   2 at ./a',
    '   2 at ./b',
    '4 file(s), at /'
  ].join( '\n' )
  test.identical( got, expected );

  test.case = 'explanation + groupsMap + spentTime, verbosity : 3';
  var o =
  {
    groupsMap :
    {
      '/' : [ '/a', '/a/b', '/b', '/b/c' ],
      '/a' : [ '/a', '/a/b' ],
      '/b' : [ '/b', '/b/c' ]
    },
    spentTime : 5000,
    explanation : '- Deleted ',
    verbosity : 3
  }
  var got = _.path.groupTextualReport( _.props.extend( null, defaults, o ) );
  var expected =
  [
    '   4 at /',
    '   2 at ./a',
    '   2 at ./b',
    '- Deleted 4 file(s), at /, in 5.000s'
  ].join( '\n' )
  test.identical( got, expected );

  test.case = 'explanation + groupsMap + spentTime, verbosity : 5';
  var o =
  {
    groupsMap :
    {
      '/' : [ '/a', '/a/b', '/b', '/b/c' ],
      '/a' : [ '/a', '/a/b' ],
      '/b' : [ '/b', '/b/c' ]
    },
    spentTime : 5000,
    explanation : '- Deleted ',
    verbosity : 5
  }

  var got = _.path.groupTextualReport( _.props.extend( null, defaults, o ) );
  var expected =
`
  '/a'
  '/a/b'
  '/b'
  '/b/c'
   4 at /
   2 at ./a
   2 at ./b
- Deleted 4 file(s), at /, in 5.000s`;
  test.equivalent( got, expected );

  test.case = 'relative, explanation + groupsMap + spentTime, verbosity : 5';
  var o =
  {
    groupsMap :
    {
      '/' : [ './a', './a/b', './b', './b/c' ],
      './a' : [ './a', './a/b' ],
      './b' : [ './b', './b/c' ]
    },
    spentTime : 5000,
    explanation : '- Deleted ',
    verbosity : 5
  }
  var got = _.path.groupTextualReport( _.props.extend( null, defaults, o ) );
  var expected =
`
  './a'
  './a/b'
  './b'
  './b/c'
   4 at .
   2 at ./a
   2 at ./b
- Deleted 4 file(s), at ., in 5.000s
`
  test.equivalent( got, expected );

  test.close( 'locals' );
}

//

function commonTextualReport( test )
{
  test.open( 'locals' );

  test.case = 'single';
  var filePath = [ '/wprocedure#0.3.19' ];
  var expected = filePath[ 0 ];
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, same';
  var filePath = [ '/wprocedure#0.3.19', '/wprocedure#0.3.19' ];
  var expected = '( /wprocedure#0.3.19 + [ . , . ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, same protocol and path, diffent hash';
  var filePath = [ '/wprocedure#0.3.19', '/wprocedure#0.3.18' ];
  var expected = '( / + [ wprocedure#0.3.19 , wprocedure#0.3.18 ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, different';
  var filePath = [ '/wprocedure#0.3.19', '/wfiles#0.3.19' ];
  var expected = '( / + [ wprocedure#0.3.19 , wfiles#0.3.19 ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, different';
  var filePath = [ '/wprocedure#0.3.19', '/wfiles#0.3.18' ];
  var expected = '( / + [ wprocedure#0.3.19 , wfiles#0.3.18 ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, different';
  var filePath = [ '/wprocedure', '/wfiles#0.3.18' ];
  var expected = '( / + [ wprocedure , wfiles#0.3.18 ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, different';
  var filePath = [ '/wprocedure', '/a/b/c' ];
  var expected = '( / + [ wprocedure , a/b/c ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'three, commot part of path';
  var filePath = [ '/wprocedure', '/a/b/c', '/wfiles' ];
  var expected = '( / + [ wprocedure , a/b/c , wfiles ] )'
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, part of path is diffent';
  var filePath = [ '/a/b/c', '/a/x/c' ];
  var expected = '( /a/ + [ ./b/c , ./x/c ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two relatives, common part of path';
  var filePath = [ 'a/b/c', 'a/x/c' ];
  var expected = '( a/ + [ ./b/c , ./x/c ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two different relatives';
  var filePath = [ 'a/b', 'c/d' ];
  var expected = '[ a/b , c/d ]';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.close( 'locals' );

  /*  */

  test.open( 'map' );

  test.case = 'single';
  var filePath = { '/wprocedure#0.3.19' : 1 };
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, '/wprocedure#0.3.19' );

  test.case = 'two, same protocol and path, diffent hash';
  var filePath = { '/wprocedure#0.3.19' : 1, '/wprocedure#0.3.18' : 1 };
  var expected = '( / + [ wprocedure#0.3.19 , wprocedure#0.3.18 ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, different';
  var filePath = { '/wprocedure#0.3.19' : 1, '/wfiles#0.3.19' : 1 };
  var expected = '( / + [ wprocedure#0.3.19 , wfiles#0.3.19 ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, different';
  var filePath =  { '/wprocedure#0.3.19' : 1, '/wfiles#0.3.18' : 1 };
  var expected = '( / + [ wprocedure#0.3.19 , wfiles#0.3.18 ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, different';
  var filePath = { '/wprocedure' : 1, '/wfiles#0.3.18' : 1 };
  var expected = '( / + [ wprocedure , wfiles#0.3.18 ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, different';
  var filePath = { '/wprocedure' : 1, '/a/b/c' : 1 };
  var expected = '( / + [ wprocedure , a/b/c ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'three, commot part of path';
  var filePath = { '/wprocedure' : 1, '/a/b/c' : 1, '/wfiles' : 1 };
  var expected = '( / + [ wprocedure , a/b/c , wfiles ] )'
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, part of path is diffent';
  var filePath = { '/a/b/c' : 1, '/a/x/c' : 0 };
  var expected = '( /a/ + [ ./b/c , ./x/c ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two relatives, common part of path';
  var filePath = { 'a/b/c' : 1, 'a/x/c' : 0 };
  var expected = '( a/ + [ ./b/c , ./x/c ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two different relatives';
  var filePath = { 'a/b' : 'a/b/c', 'c/d' : 'a/b' };
  var expected = '[ a/b , c/d ]';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.close( 'map' );

  /*  */

  if( !Config.debug )
  return

  test.shouldThrowErrorSync( () => _.path.commonTextualReport( null ) )
  test.shouldThrowErrorSync( () => _.path.commonTextualReport([ '/a/b/c', null ]) )
  test.shouldThrowErrorSync( () => _.path.commonTextualReport([ '/a/b/c', './c/d' ]) )
}

//

function moveTextualReport( test )
{
  test.open( 'locals' );

  test.case = 'same, absolute';
  var expected = '/a : . <- .';
  var dst = '/a';
  var src = '/a';
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'different, absolute, with common';
  var expected = '/a/ : ./dst <- ./src';
  var dst = '/a/dst';
  var src = '/a/src';
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'different, absolute, without common';
  var expected = '/b/dst <- /a/src';
  var dst = '/b/dst';
  var src = '/a/src';
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'same, relative';
  var expected = 'a/src : . <- .';
  var dst = 'a/src';
  var src = 'a/src';
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'different, relative, with common';
  var expected = 'a/ : ./dst <- ./src';
  var dst = 'a/dst';
  var src = 'a/src';
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'different, relative, without common';
  var expected = 'b/dst <- a/src';
  var dst = 'b/dst';
  var src = 'a/src';
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'same, relative dotted';
  var expected = 'a/src : . <- .';
  var dst = './a/src';
  var src = './a/src';
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'different, relative dotted, with common';
  var expected = 'a/ : ./dst <- ./src';
  var dst = './a/dst';
  var src = './a/src';
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'different, relative dotted, without common';
  var expected = './b/dst <- ./a/src';
  var dst = './b/dst';
  var src = './a/src';
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.close( 'locals' );

  test.open( 'null' );

  test.case = 'both null';
  var expected = '{null} : . <- .';
  var dst = null;
  var src = null;
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'dst relative, src null';
  var expected = './a/dst <- {null}';
  var dst = './a/dst';
  var src = null;
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'src relative, dst null';
  var expected = '{null} <- ./a/src';
  var src = './a/src';
  var dst = null;
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'src absolute, dst null';
  var expected = '/{null} <- /a/src';
  var src = '/a/src';
  var dst = null;
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'dst absolute, src null';
  var expected = '/a/dst <- /{null}';
  var dst = '/a/dst';
  var src = null;
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.close( 'null' );
}

// --
// declare
// --

const Proto =
{

  name : 'Tools.l3.path.Basic',
  silencing : 1,

  tests :
  {

    is,
    are,
    like,
    isSafe,
    // isRefinedMaybeTrailed, /* Dmytro : should be deleted */
    isRefined,
    // isNormalizedMaybeTrailed, /* Dmytro : should be deleted */
    isNormalized,
    isAbsolute,
    isRelative,
    isGlobal,
    isRoot,
    isDotted,
    isTrailed,
    isGlob,

    begins,
    ends,

    refine,

    normalize,
    normalizeTolerant,
    canonize,
    canonizeTolerant,

    nativize,

    from,

    // dot, /* Dmytro : coverage in Tools */
    // undot,

    join,
    joinRaw,
    joinCross,
    reroot,
    resolve,
    joinNames,

    dir,
    dirFirst,
    prefixGet,
    name,
    fullName,
    withoutExt,
    changeExt,
    ext,

    relative,
    relativeWithOptions,

    common, /* !!! : remove after replacing common_ -> common */
    common_,

    // reporter

    groupTextualReport,
    commonTextualReport,
    moveTextualReport

  },

  /* qqq : comment out test routines for moved out routines */

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
