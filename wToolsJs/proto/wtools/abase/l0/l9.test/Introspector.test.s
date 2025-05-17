( function _l0_l9_Introspector_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( 'Tools' );
  _.include( 'wTesting' );
}

const _ = _global_.wTools;
const __ = _globals_.testing.wTools;
const fileProvider = __.fileProvider;
const path = fileProvider.path;

// --
// context
// --

function onSuiteBegin()
{
  let self = this;

  self.suiteTempPath = path.tempOpen( path.join( __dirname, '../..'  ), 'err' );
  self.assetsOriginalPath = path.join( __dirname, '_asset' );

}

//

function onSuiteEnd()
{
  let self = this;
  _.assert( _.strHas( self.suiteTempPath, '/err-' ) )
  path.tempClose( self.suiteTempPath );
}

// --
// tests
// --

function locationFromStackFrameWithoutLocationField( test )
{

  test.open( 'o - string' );

  test.case = 'empty string';
  var stackFrame = '';
  var exp =
  {
    'original' : '',
    'filePath' : '',
    'routineName' : null,
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : null,
    'col' : null,
    'filePathLineCol' : '',
    'routineFilePathLineCol' : null,
    'fileName' : null,
    'fileNameLineCol' : '',
  };
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'complex routineName and windows path in parentheses';
  var stackFrame = 'at Object.stackBasic (C:\\dir\\Introspector.test.s:48:79)';
  var exp =
  {
    'original' : 'at Object.stackBasic (C:\\dir\\Introspector.test.s:48:79)',
    'filePath' : '/C/dir/Introspector.test.s',
    'routineName' : 'Object.stackBasic',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 48,
    'col' : 79,
    'filePathLineCol' : '/C/dir/Introspector.test.s:48:79',
    'routineFilePathLineCol' : 'Object.stackBasic @ /C/dir/Introspector.test.s:48:79',
    'fileName' : 'Introspector.test.s',
    'fileNameLineCol' : 'Introspector.test.s:48:79',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'complex routineName and normalized path in parentheses';
  var stackFrame = 'at Object.stackBasic (/C/dir/Introspector.test.s:48:79)';
  var exp =
  {
    'original' : 'at Object.stackBasic (/C/dir/Introspector.test.s:48:79)',
    'filePath' : '/C/dir/Introspector.test.s',
    'routineName' : 'Object.stackBasic',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 48,
    'col' : 79,
    'filePathLineCol' : '/C/dir/Introspector.test.s:48:79',
    'routineFilePathLineCol' : 'Object.stackBasic @ /C/dir/Introspector.test.s:48:79',
    'fileName' : 'Introspector.test.s',
    'fileNameLineCol' : 'Introspector.test.s:48:79',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'simple routineName and windows path in parentheses';
  var stackFrame = 'at iteration (C:\\dir\\File.js:5:47)';
  var exp =
  {
    'original' : 'at iteration (C:\\dir\\File.js:5:47)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'iteration',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 5,
    'col' : 47,
    'filePathLineCol' : '/C/dir/File.js:5:47',
    'routineFilePathLineCol' : 'iteration @ /C/dir/File.js:5:47',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:47'
  }
  /* xxx2 : problem in _.entity.exportString( 'some\\path' )! */
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'simple routineName and normalized path in parentheses';
  var stackFrame = 'at iteration (/C/dir/File.js:5:47)';
  var exp =
  {
    'original' : 'at iteration (/C/dir/File.js:5:47)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'iteration',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 5,
    'col' : 47,
    'filePathLineCol' : '/C/dir/File.js:5:47',
    'routineFilePathLineCol' : 'iteration @ /C/dir/File.js:5:47',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:47'
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineName begins on underscore, windows path';
  var stackFrame = 'at _iteration (C:\\dir\\File.js:5:47)';
  var exp =
  {
    'original' : 'at _iteration (C:\\dir\\File.js:5:47)',
    'filePath' : '/C/dir/File.js',
    'routineName' : '_iteration',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 1,
    'line' : 5,
    'col' : 47,
    'filePathLineCol' : '/C/dir/File.js:5:47',
    'routineFilePathLineCol' : '_iteration @ /C/dir/File.js:5:47',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:47',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineName begins on double underscore, windows path';
  var stackFrame = 'at __iteration (C:\\dir\\File.js:5:47)';
  var exp =
  {
    'original' : 'at __iteration (C:\\dir\\File.js:5:47)',
    'filePath' : '/C/dir/File.js',
    'routineName' : '__iteration',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 2,
    'line' : 5,
    'col' : 47,
    'filePathLineCol' : '/C/dir/File.js:5:47',
    'routineFilePathLineCol' : '__iteration @ /C/dir/File.js:5:47',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:47',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineName has underscore in name, windows path';
  var stackFrame = 'at wConsequence.handle_Now (C:\\dir\\File.js:5:15)';
  var exp =
  {
    'original' : 'at wConsequence.handle_Now (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.handle_Now',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence.handle_Now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineName has underscore at the start and in the middle, windows path';
  var stackFrame = 'at wConsequence._handle_Now (C:\\dir\\File.js:5:15)';
  var exp =
  {
    'original' : 'at wConsequence._handle_Now (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence._handle_Now',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 1,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence._handle_Now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineName has double underscore at the start and underscore in the middle, windows path';
  var stackFrame = 'at wConsequence.__handle_Now (C:\\dir\\File.js:5:15)';
  var exp =
  {
    'original' : 'at wConsequence.__handle_Now (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.__handle_Now',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 2,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence.__handle_Now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineName has double underscore in name, windows path';
  var stackFrame = 'at wConsequence.handle__Now (C:\\dir\\File.js:5:15)';
  var exp =
  {
    'original' : 'at wConsequence.handle__Now (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.handle__Now',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence.handle__Now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineName has underscore at the start and double underscore in the middle, windows path';
  var stackFrame = 'at wConsequence._handle__Now (C:\\dir\\File.js:5:15)';
  var exp =
  {
    'original' : 'at wConsequence._handle__Now (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence._handle__Now',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 1,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence._handle__Now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineName has double underscore at the start and in the middle, windows path';
  var stackFrame = 'at wConsequence.__handle__Now (C:\\dir\\File.js:5:15)';
  var exp =
  {
    'original' : 'at wConsequence.__handle__Now (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.__handle__Now',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 2,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence.__handle__Now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineName end by dot, windows path';
  var stackFrame = 'at wConsequence. (C:\\dir\\File.js:9:15)';
  var exp =
  {
    'original' : 'at wConsequence. (C:\\dir\\File.js:9:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.{-anonymous-}',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 9,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:9:15',
    'routineFilePathLineCol' : 'wConsequence.{-anonymous-} @ /C/dir/File.js:9:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:9:15',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineName end by double dot, windows path';
  var stackFrame = 'at wConsequence.. (C:\\dir\\File.js:9:15)';
  var exp =
  {
    'original' : 'at wConsequence.. (C:\\dir\\File.js:9:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence..{-anonymous-}',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 9,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:9:15',
    'routineFilePathLineCol' : 'wConsequence..{-anonymous-} @ /C/dir/File.js:9:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:9:15',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = '<anonymous> in routineName, windows path';
  var stackFrame = 'at wConsequence.<anonymous> (C:\\dir\\File.js:9:15)';
  var exp =
  {
    'original' : 'at wConsequence.<anonymous> (C:\\dir\\File.js:9:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.{-anonymous-}',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 9,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:9:15',
    'routineFilePathLineCol' : 'wConsequence.{-anonymous-} @ /C/dir/File.js:9:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:9:15',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'a few <anonymous> in routineName, normalized path';
  var stackFrame = 'at wConsequence.<anonymous>.<anonymous> (/C/dir/File.js:9:15)';
  var exp =
  {
    'original' : 'at wConsequence.<anonymous>.<anonymous> (/C/dir/File.js:9:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.{-anonymous-}.{-anonymous-}',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 9,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:9:15',
    'routineFilePathLineCol' : 'wConsequence.{-anonymous-}.{-anonymous-} @ /C/dir/File.js:9:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:9:15',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'not routineAlias with underscore';
  var stackFrame = 'at Object.time [ab _time] (C:\\dir\\Procedure.s:1503:20)';
  var exp =
  {
    'original' : 'at Object.time [ab _time] (C:\\dir\\Procedure.s:1503:20)',
    'filePath' : '/C/dir/Procedure.s',
    'routineName' : 'Object.time',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 1503,
    'col' : 20,
    'filePathLineCol' : '/C/dir/Procedure.s:1503:20',
    'routineFilePathLineCol' : 'Object.time @ /C/dir/Procedure.s:1503:20',
    'fileName' : 'Procedure.s',
    'fileNameLineCol' : 'Procedure.s:1503:20',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );


  test.case = 'routinAlias with underscore';
  var stackFrame = 'at Object.time [as _time] (C:\\dir\\Procedure.s:1503:20)';
  var exp =
  {
    'original' : 'at Object.time [as _time] (C:\\dir\\Procedure.s:1503:20)',
    'filePath' : '/C/dir/Procedure.s',
    'routineName' : 'Object.time',
    'routineAlias' : '_time',
    'internal' : 0,
    'abstraction' : 1,
    'line' : 1503,
    'col' : 20,
    'filePathLineCol' : '/C/dir/Procedure.s:1503:20',
    'routineFilePathLineCol' : 'Object.time @ /C/dir/Procedure.s:1503:20',
    'fileName' : 'Procedure.s',
    'fileNameLineCol' : 'Procedure.s:1503:20',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineAlias with double underscore';
  var stackFrame = 'at Object.time [as __time] (C:\\dir\\Procedure.s:1503:20)';
  var exp =
  {
    'original' : 'at Object.time [as __time] (C:\\dir\\Procedure.s:1503:20)',
    'filePath' : '/C/dir/Procedure.s',
    'routineName' : 'Object.time',
    'routineAlias' : '__time',
    'internal' : 0,
    'abstraction' : 2,
    'line' : 1503,
    'col' : 20,
    'filePathLineCol' : '/C/dir/Procedure.s:1503:20',
    'routineFilePathLineCol' : 'Object.time @ /C/dir/Procedure.s:1503:20',
    'fileName' : 'Procedure.s',
    'fileNameLineCol' : 'Procedure.s:1503:20',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineName has double underscore, routineAlias has single underscore';
  var stackFrame = 'at Object.__time [as _time] (C:\\dir\\Procedure.s:1503:20)';
  var exp =
  {
    'original' : 'at Object.__time [as _time] (C:\\dir\\Procedure.s:1503:20)',
    'filePath' : '/C/dir/Procedure.s',
    'routineName' : 'Object.__time',
    'routineAlias' : '_time',
    'internal' : 0,
    'abstraction' : 2,
    'line' : 1503,
    'col' : 20,
    'filePathLineCol' : '/C/dir/Procedure.s:1503:20',
    'routineFilePathLineCol' : 'Object.__time @ /C/dir/Procedure.s:1503:20',
    'fileName' : 'Procedure.s',
    'fileNameLineCol' : 'Procedure.s:1503:20',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'relative path';
  var stackFrame = 'at listOnTimeout (internal/timers.js:531:17)';
  var exp =
  {
    'original' : 'at listOnTimeout (internal/timers.js:531:17)',
    'filePath' : 'internal/timers.js',
    'routineName' : 'listOnTimeout',
    'routineAlias' : null,
    'internal' : 2,
    'abstraction' : 0,
    'line' : 531,
    'col' : 17,
    'filePathLineCol' : 'internal/timers.js:531:17',
    'routineFilePathLineCol' : 'listOnTimeout @ internal/timers.js:531:17',
    'fileName' : 'timers.js',
    'fileNameLineCol' : 'timers.js:531:17',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'eval and <anonymous> in path';
  var stackFrame = 'at eval (<anonymous>:1:16)';
  var exp =
  {
    'original' : 'at eval (<anonymous>:1:16)',
    'filePath' : '<anonymous>',
    'routineName' : 'eval',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 1,
    'col' : 16,
    'filePathLineCol' : '<anonymous>:1:16',
    'routineFilePathLineCol' : 'eval @ <anonymous>:1:16',
    'fileName' : '<anonymous>',
    'fileNameLineCol' : '<anonymous>:1:16',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'windows filePath nested in parentheses with routineName and <anonymous>';
  var stackFrame = 'at eval (eval at program2 (C:\\basic\\program2.js:13:5), <anonymous>:1:16)';
  var exp =
  {
    'original' : 'at eval (eval at program2 (C:\\basic\\program2.js:13:5), <anonymous>:1:16)',
    'filePath' : '/C/basic/program2.js',
    'routineName' : 'program2',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 13,
    'col' : 5,
    'filePathLineCol' : '/C/basic/program2.js:13:5',
    'routineFilePathLineCol' : 'program2 @ /C/basic/program2.js:13:5',
    'fileName' : 'program2.js',
    'fileNameLineCol' : 'program2.js:13:5',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'normalized filePath nested in parentheses with routineName and <anonymous>';
  var stackFrame = 'at eval (eval at program2 (/C/basic/program2.js:13:5), <anonymous>:1:16)';
  var exp =
  {
    'original' : 'at eval (eval at program2 (/C/basic/program2.js:13:5), <anonymous>:1:16)',
    'filePath' : '/C/basic/program2.js',
    'routineName' : 'program2',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 13,
    'col' : 5,
    'filePathLineCol' : '/C/basic/program2.js:13:5',
    'routineFilePathLineCol' : 'program2 @ /C/basic/program2.js:13:5',
    'fileName' : 'program2.js',
    'fileNameLineCol' : 'program2.js:13:5',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.close( 'o - string' );

  /* - */

  test.open( 'o - map' );

  test.case = 'empty string';
  var stackFrame = { stackFrame : '' };
  var exp =
  {
    'original' : '',
    'filePath' : '',
    'routineName' : null,
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : null,
    'col' : null,
    'filePathLineCol' : '',
    'routineFilePathLineCol' : null,
    'fileName' : null,
    'fileNameLineCol' : '',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'complex routineName and windows path in parentheses';
  var stackFrame = { stackFrame : 'at Object.stackBasic (C:\\dir\\Introspector.test.s:48:79)' };
  var exp =
  {
    'original' : 'at Object.stackBasic (C:\\dir\\Introspector.test.s:48:79)',
    'filePath' : '/C/dir/Introspector.test.s',
    'routineName' : 'Object.stackBasic',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 48,
    'col' : 79,
    'filePathLineCol' : '/C/dir/Introspector.test.s:48:79',
    'routineFilePathLineCol' : 'Object.stackBasic @ /C/dir/Introspector.test.s:48:79',
    'fileName' : 'Introspector.test.s',
    'fileNameLineCol' : 'Introspector.test.s:48:79',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'complex routineName and normalized path in parentheses';
  var stackFrame = { stackFrame : 'at Object.stackBasic (/C/dir/Introspector.test.s:48:79)' };
  var exp =
  {
    'original' : 'at Object.stackBasic (/C/dir/Introspector.test.s:48:79)',
    'filePath' : '/C/dir/Introspector.test.s',
    'routineName' : 'Object.stackBasic',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 48,
    'col' : 79,
    'filePathLineCol' : '/C/dir/Introspector.test.s:48:79',
    'routineFilePathLineCol' : 'Object.stackBasic @ /C/dir/Introspector.test.s:48:79',
    'fileName' : 'Introspector.test.s',
    'fileNameLineCol' : 'Introspector.test.s:48:79',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'simple routineName and windows path in parentheses';
  var stackFrame = { stackFrame : 'at iteration (C:\\dir\\File.js:5:47)' };
  var exp =
  {
    'original' : 'at iteration (C:\\dir\\File.js:5:47)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'iteration',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 5,
    'col' : 47,
    'filePathLineCol' : '/C/dir/File.js:5:47',
    'routineFilePathLineCol' : 'iteration @ /C/dir/File.js:5:47',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:47'
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'simple routineName and normalized path in parentheses';
  var stackFrame = { stackFrame : 'at iteration (/C/dir/File.js:5:47)' };
  var exp =
  {
    'original' : 'at iteration (/C/dir/File.js:5:47)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'iteration',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 5,
    'col' : 47,
    'filePathLineCol' : '/C/dir/File.js:5:47',
    'routineFilePathLineCol' : 'iteration @ /C/dir/File.js:5:47',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:47'
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineName begins on underscore, windows path';
  var stackFrame = { stackFrame : 'at _iteration (C:\\dir\\File.js:5:47)' };
  var exp =
  {
    'original' : 'at _iteration (C:\\dir\\File.js:5:47)',
    'filePath' : '/C/dir/File.js',
    'routineName' : '_iteration',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 1,
    'line' : 5,
    'col' : 47,
    'filePathLineCol' : '/C/dir/File.js:5:47',
    'routineFilePathLineCol' : '_iteration @ /C/dir/File.js:5:47',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:47',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineName begins on double underscore, windows path';
  var stackFrame = { stackFrame : 'at __iteration (C:\\dir\\File.js:5:47)' };
  var exp =
  {
    'original' : 'at __iteration (C:\\dir\\File.js:5:47)',
    'filePath' : '/C/dir/File.js',
    'routineName' : '__iteration',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 2,
    'line' : 5,
    'col' : 47,
    'filePathLineCol' : '/C/dir/File.js:5:47',
    'routineFilePathLineCol' : '__iteration @ /C/dir/File.js:5:47',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:47',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineName has underscore in name, windows path';
  var stackFrame = { stackFrame : 'at wConsequence.handle_Now (C:\\dir\\File.js:5:15)' };
  var exp =
  {
    'original' : 'at wConsequence.handle_Now (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.handle_Now',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence.handle_Now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineName has underscore at the start and in the middle, windows path';
  var stackFrame = { stackFrame : 'at wConsequence._handle_Now (C:\\dir\\File.js:5:15)' };
  var exp =
  {
    'original' : 'at wConsequence._handle_Now (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence._handle_Now',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 1,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence._handle_Now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineName has double underscore at the start and underscore in the middle, windows path';
  var stackFrame = { stackFrame : 'at wConsequence.__handle_Now (C:\\dir\\File.js:5:15)' };
  var exp =
  {
    'original' : 'at wConsequence.__handle_Now (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.__handle_Now',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 2,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence.__handle_Now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineName has double underscore in name, windows path';
  var stackFrame = { stackFrame : 'at wConsequence.handle__Now (C:\\dir\\File.js:5:15)' };
  var exp =
  {
    'original' : 'at wConsequence.handle__Now (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.handle__Now',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence.handle__Now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineName has underscore at the start and double underscore in the middle, windows path';
  var stackFrame = { stackFrame : 'at wConsequence._handle__Now (C:\\dir\\File.js:5:15)' };
  var exp =
  {
    'original' : 'at wConsequence._handle__Now (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence._handle__Now',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 1,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence._handle__Now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineName has double underscore at the start and in the middle, windows path';
  var stackFrame = { stackFrame : 'at wConsequence.__handle__Now (C:\\dir\\File.js:5:15)' };
  var exp =
  {
    'original' : 'at wConsequence.__handle__Now (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.__handle__Now',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 2,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence.__handle__Now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineName end by dot, windows path';
  var stackFrame = { stackFrame : 'at wConsequence. (C:\\dir\\File.js:9:15)' };
  var exp =
  {
    'original' : 'at wConsequence. (C:\\dir\\File.js:9:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.{-anonymous-}',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 9,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:9:15',
    'routineFilePathLineCol' : 'wConsequence.{-anonymous-} @ /C/dir/File.js:9:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:9:15',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineName end by double dot, windows path';
  var stackFrame = { stackFrame : 'at wConsequence.. (C:\\dir\\File.js:9:15)' };
  var exp =
  {
    'original' : 'at wConsequence.. (C:\\dir\\File.js:9:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence..{-anonymous-}',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 9,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:9:15',
    'routineFilePathLineCol' : 'wConsequence..{-anonymous-} @ /C/dir/File.js:9:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:9:15',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = '<anonymous> in routineName, windows path';
  var stackFrame = { stackFrame : 'at wConsequence.<anonymous> (C:\\dir\\File.js:9:15)' };
  var exp =
  {
    'original' : 'at wConsequence.<anonymous> (C:\\dir\\File.js:9:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.{-anonymous-}',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 9,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:9:15',
    'routineFilePathLineCol' : 'wConsequence.{-anonymous-} @ /C/dir/File.js:9:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:9:15',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'a few <anonymous> in routineName, normalized path';
  var stackFrame = { stackFrame : 'at wConsequence.<anonymous>.<anonymous> (/C/dir/File.js:9:15)' };
  var exp =
  {
    'original' : 'at wConsequence.<anonymous>.<anonymous> (/C/dir/File.js:9:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.{-anonymous-}.{-anonymous-}',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 9,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:9:15',
    'routineFilePathLineCol' : 'wConsequence.{-anonymous-}.{-anonymous-} @ /C/dir/File.js:9:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:9:15',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'not routineAlias with underscore';
  var stackFrame = { stackFrame : 'at Object.time [ab _time] (C:\\dir\\Procedure.s:1503:20)' };
  var exp =
  {
    'original' : 'at Object.time [ab _time] (C:\\dir\\Procedure.s:1503:20)',
    'filePath' : '/C/dir/Procedure.s',
    'routineName' : 'Object.time',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 1503,
    'col' : 20,
    'filePathLineCol' : '/C/dir/Procedure.s:1503:20',
    'routineFilePathLineCol' : 'Object.time @ /C/dir/Procedure.s:1503:20',
    'fileName' : 'Procedure.s',
    'fileNameLineCol' : 'Procedure.s:1503:20',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineAlias with underscore';
  var stackFrame = { stackFrame : 'at Object.time [as _time] (C:\\dir\\Procedure.s:1503:20)' };
  var exp =
  {
    'original' : 'at Object.time [as _time] (C:\\dir\\Procedure.s:1503:20)',
    'filePath' : '/C/dir/Procedure.s',
    'routineName' : 'Object.time',
    'routineAlias' : '_time',
    'internal' : 0,
    'abstraction' : 1,
    'line' : 1503,
    'col' : 20,
    'filePathLineCol' : '/C/dir/Procedure.s:1503:20',
    'routineFilePathLineCol' : 'Object.time @ /C/dir/Procedure.s:1503:20',
    'fileName' : 'Procedure.s',
    'fileNameLineCol' : 'Procedure.s:1503:20',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineAlias with double underscore';
  var stackFrame = { stackFrame : 'at Object.time [as __time] (C:\\dir\\Procedure.s:1503:20)' };
  var exp =
  {
    'original' : 'at Object.time [as __time] (C:\\dir\\Procedure.s:1503:20)',
    'filePath' : '/C/dir/Procedure.s',
    'routineName' : 'Object.time',
    'routineAlias' : '__time',
    'internal' : 0,
    'abstraction' : 2,
    'line' : 1503,
    'col' : 20,
    'filePathLineCol' : '/C/dir/Procedure.s:1503:20',
    'routineFilePathLineCol' : 'Object.time @ /C/dir/Procedure.s:1503:20',
    'fileName' : 'Procedure.s',
    'fileNameLineCol' : 'Procedure.s:1503:20',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'routineName has double underscore, routineAlias has single underscore';
  var stackFrame = { stackFrame : 'at Object.__time [as _time] (C:\\dir\\Procedure.s:1503:20)' };
  var exp =
  {
    'original' : 'at Object.__time [as _time] (C:\\dir\\Procedure.s:1503:20)',
    'filePath' : '/C/dir/Procedure.s',
    'routineName' : 'Object.__time',
    'routineAlias' : '_time',
    'internal' : 0,
    'abstraction' : 2,
    'line' : 1503,
    'col' : 20,
    'filePathLineCol' : '/C/dir/Procedure.s:1503:20',
    'routineFilePathLineCol' : 'Object.__time @ /C/dir/Procedure.s:1503:20',
    'fileName' : 'Procedure.s',
    'fileNameLineCol' : 'Procedure.s:1503:20',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'relative path';
  var stackFrame = { stackFrame : 'at listOnTimeout (internal/timers.js:531:17)' };
  var exp =
  {
    'original' : 'at listOnTimeout (internal/timers.js:531:17)',
    'filePath' : 'internal/timers.js',
    'routineName' : 'listOnTimeout',
    'routineAlias' : null,
    'internal' : 2,
    'abstraction' : 0,
    'line' : 531,
    'col' : 17,
    'filePathLineCol' : 'internal/timers.js:531:17',
    'routineFilePathLineCol' : 'listOnTimeout @ internal/timers.js:531:17',
    'fileName' : 'timers.js',
    'fileNameLineCol' : 'timers.js:531:17',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'eval and <anonymous> in path';
  var stackFrame = { stackFrame : 'at eval (<anonymous>:1:16)' };
  var exp =
  {
    'original' : 'at eval (<anonymous>:1:16)',
    'filePath' : '<anonymous>',
    'routineName' : 'eval',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 1,
    'col' : 16,
    'filePathLineCol' : '<anonymous>:1:16',
    'routineFilePathLineCol' : 'eval @ <anonymous>:1:16',
    'fileName' : '<anonymous>',
    'fileNameLineCol' : '<anonymous>:1:16',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'windows filePath nested in parentheses with routineName and <anonymous>';
  var stackFrame = { stackFrame : 'at eval (eval at program2 (C:\\basic\\program2.js:13:5), <anonymous>:1:16)' };
  var exp =
  {
    'original' : 'at eval (eval at program2 (C:\\basic\\program2.js:13:5), <anonymous>:1:16)',
    'filePath' : '/C/basic/program2.js',
    'routineName' : 'program2',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 13,
    'col' : 5,
    'filePathLineCol' : '/C/basic/program2.js:13:5',
    'routineFilePathLineCol' : 'program2 @ /C/basic/program2.js:13:5',
    'fileName' : 'program2.js',
    'fileNameLineCol' : 'program2.js:13:5',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.case = 'normalized filePath nested in parentheses with routineName and <anonymous>';
  var stackFrame = { stackFrame : 'at eval (eval at program2 (/C/basic/program2.js:13:5), <anonymous>:1:16)' };
  var exp =
  {
    'original' : 'at eval (eval at program2 (/C/basic/program2.js:13:5), <anonymous>:1:16)',
    'filePath' : '/C/basic/program2.js',
    'routineName' : 'program2',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 13,
    'col' : 5,
    'filePathLineCol' : '/C/basic/program2.js:13:5',
    'routineFilePathLineCol' : 'program2 @ /C/basic/program2.js:13:5',
    'fileName' : 'program2.js',
    'fileNameLineCol' : 'program2.js:13:5',
  }
  var got = _.introspector.locationFromStackFrame( stackFrame );
  test.identical( got, exp );

  test.close( 'o - map' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.introspector.locationFromStackFrame() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.introspector.locationFromStackFrame( 'at @abc2:0', 'unnecessary' ) );

  test.case = 'unnecessary option in map options';
  test.shouldThrowErrorSync( () => _.introspector.locationFromStackFrame( { stackFrame : 'abc', range : [ 1, 2 ] } ) );

  test.case = 'wrong type of map options';
  test.shouldThrowErrorSync( () => _.introspector.locationFromStackFrame( [ [ stackFrame, 'abc' ] ] ) );

  test.case = 'wrong type of o.stackFrame';
  test.shouldThrowErrorSync( () => _.introspector.locationFromStackFrame( { stackFrame : [ 'string in array' ] } ) );

  test.case = 'wrong type of o.location.filePath';
  test.shouldThrowErrorSync( () => _.introspector.locationFromStackFrame( { stackFrame : 'at abc (/a/b/c)', location : { filePath : true } } ) );

  test.case = 'wrong type of o.location.routineName';
  test.shouldThrowErrorSync( () => _.introspector.locationFromStackFrame( { stackFrame : 'at abc (/a/b/c)', location : { routineName : [] } } ) );

  test.case = 'stackFrame is null';
  test.shouldThrowErrorSync( () => _.introspector.locationFromStackFrame( { stackFrame : null } ) );
}

//

function locationFromStackFrameWithLocationField( test )
{
  test.case = 'o.location has original field different to stackFrame';
  var location =
  {
    original : 'at stackBasic (/C/dir/Introspector.test.s)',
  }
  var stackFrame = 'at Object.stackBasic (C:\\dir\\Introspector.test.s:48:79)';
  var exp =
  {
    'original' : 'at Object.stackBasic (C:\\dir\\Introspector.test.s:48:79)',
    'filePath' : '/C/dir/Introspector.test.s',
    'routineName' : 'Object.stackBasic',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 48,
    'col' : 79,
    'filePathLineCol' : '/C/dir/Introspector.test.s:48:79',
    'routineFilePathLineCol' : 'Object.stackBasic @ /C/dir/Introspector.test.s:48:79',
    'fileName' : 'Introspector.test.s',
    'fileNameLineCol' : 'Introspector.test.s:48:79',
  }
  var got = _.introspector.locationFromStackFrame( { stackFrame, location } );
  test.identical( got, exp );

  /* */

  test.case = 'o.location has original field different to stackFrame, filePath - empty string';
  var location =
  {
    original : 'at stackBasic (/C/dir/Introspector.test.s)',
    filePath : '',
  }
  var stackFrame = 'at Object.stackBasic (/C/dir/Introspector.test.s:48:79)';
  var exp =
  {
    'original' : 'at Object.stackBasic (/C/dir/Introspector.test.s:48:79)',
    'filePath' : '/C/dir/Introspector.test.s',
    'routineName' : 'Object.stackBasic',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 48,
    'col' : 79,
    'filePathLineCol' : '/C/dir/Introspector.test.s:48:79',
    'routineFilePathLineCol' : 'Object.stackBasic @ /C/dir/Introspector.test.s:48:79',
    'fileName' : 'Introspector.test.s',
    'fileNameLineCol' : 'Introspector.test.s:48:79',
  }
  var got = _.introspector.locationFromStackFrame( { stackFrame, location } );
  test.identical( got, exp );

  /* */

  test.case = 'routineName has double underscore at the start and in the middle, windows path';
  var location = {};
  var stackFrame = 'at wConsequence.__handle__Now (C:\\dir\\File.js:5:15)';
  var exp =
  {
    'original' : 'at wConsequence.__handle__Now (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.__handle__Now',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 2,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence.__handle__Now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  }
  var got = _.introspector.locationFromStackFrame( { stackFrame, location } );
  test.identical( got, exp );

  /* */

  test.case = 'o.location.routineAlias - empty string, o.location.internal - 2';
  var location =
  {
    routineAlias : '',
    internal : 2
  };
  var stackFrame = 'at Object.time [as _time] (C:\\dir\\Procedure.s:1503:20)';
  var exp =
  {
    'original' : 'at Object.time [as _time] (C:\\dir\\Procedure.s:1503:20)',
    'filePath' : '/C/dir/Procedure.s',
    'routineName' : 'Object.time',
    'routineAlias' : '_time',
    'internal' : 2,
    'abstraction' : 1,
    'line' : 1503,
    'col' : 20,
    'filePathLineCol' : '/C/dir/Procedure.s:1503:20',
    'routineFilePathLineCol' : 'Object.time @ /C/dir/Procedure.s:1503:20',
    'fileName' : 'Procedure.s',
    'fileNameLineCol' : 'Procedure.s:1503:20',
  }
  var got = _.introspector.locationFromStackFrame( { stackFrame, location } );
  test.identical( got, exp );

  /* */

  test.case = 'o.location.routineAlias with double underscore, o.location.internal - 0';
  var location =
  {
    routineAlias : '__routine',
    internal : 0
  };
  var stackFrame = 'at Object.time [as __time] (C:\\dir\\Procedure.s:1503:20)';
  var exp =
  {
    'original' : 'at Object.time [as __time] (C:\\dir\\Procedure.s:1503:20)',
    'filePath' : '/C/dir/Procedure.s',
    'routineName' : 'Object.time',
    'routineAlias' : '__routine',
    'internal' : 0,
    'abstraction' : 2,
    'line' : 1503,
    'col' : 20,
    'filePathLineCol' : '/C/dir/Procedure.s:1503:20',
    'routineFilePathLineCol' : 'Object.time @ /C/dir/Procedure.s:1503:20',
    'fileName' : 'Procedure.s',
    'fileNameLineCol' : 'Procedure.s:1503:20',
  }
  var got = _.introspector.locationFromStackFrame( { stackFrame, location } );
  test.identical( got, exp );

  /* */

  test.case = 'number of o.location.line is different to stack';
  var location =
  {
    filePath : 'internal/timers.js',
    line : 1,
  };
  var stackFrame = 'at Object.__time [as _time] (C:\\dir\\Procedure.s:1503:20)';
  var exp =
  {
    'original' : 'at Object.__time [as _time] (C:\\dir\\Procedure.s:1503:20)',
    'filePath' : 'internal/timers.js',
    'routineName' : 'Object.__time',
    'routineAlias' : '_time',
    'internal' : 2,
    'abstraction' : 2,
    'line' : 1,
    'col' : null,
    'filePathLineCol' : 'internal/timers.js:1',
    'routineFilePathLineCol' : 'Object.__time @ internal/timers.js:1',
    'fileName' : 'timers.js',
    'fileNameLineCol' : 'timers.js:1',
  }
  var got = _.introspector.locationFromStackFrame( { stackFrame, location } );
  test.identical( got, exp );

  /* */

  test.case = 'relative path';
  var location =
  {
    filePath : 'internal/timers.js:531:17',
  }
  var stackFrame = 'at listOnTimeout (internal/timers.js)';
  var exp =
  {
    'original' : 'at listOnTimeout (internal/timers.js)',
    'filePath' : 'internal/timers.js',
    'routineName' : 'listOnTimeout',
    'routineAlias' : null,
    'internal' : 2,
    'abstraction' : 0,
    'line' : 531,
    'col' : 17,
    'filePathLineCol' : 'internal/timers.js:531:17',
    'routineFilePathLineCol' : 'listOnTimeout @ internal/timers.js:531:17',
    'fileName' : 'timers.js',
    'fileNameLineCol' : 'timers.js:531:17',
  }
  var got = _.introspector.locationFromStackFrame( { stackFrame, location } );
  test.identical( got, exp );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'o.location is an array, o.location is not a map';
  test.shouldThrowErrorSync( () => _.introspector.locationFromStackFrame( { stackFrame : 'at Object.stackBasic', location : [] } ) );
}

//

function locationNormalize( test )
{
  test.case = 'without options';
  var o = {};
  var exp =
  {
    'original' : null,
    'filePath' : undefined,
    'routineName' : null,
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : null,
    'col' : null,
    'filePathLineCol' : '',
    'routineFilePathLineCol' : null,
    'fileName' : null,
    'fileNameLineCol' : '',
  };
  var got = _.introspector.locationNormalize( o );
  test.identical( got, exp );
  test.true( got === o );

  /* - */

  test.case = 'empty string';
  var o = { original : '' };
  var exp =
  {
    'original' : '',
    'filePath' : '',
    'routineName' : null,
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : null,
    'col' : null,
    'filePathLineCol' : '',
    'routineFilePathLineCol' : null,
    'fileName' : null,
    'fileNameLineCol' : '',
  };
  var got = _.introspector.locationNormalize( o );
  test.identical( got, exp );
  test.true( got === o );

  test.case = 'stack frame line with posix path';
  var o = { original : 'at node (/home/user/file.txt)' };
  var exp =
  {
    'original' : 'at node (/home/user/file.txt)',
    'filePath' : '/home/user/file.txt',
    'routineName' : 'node',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : null,
    'col' : null,
    'filePathLineCol' : '/home/user/file.txt',
    'routineFilePathLineCol' : 'node @ /home/user/file.txt',
    'fileName' : 'file.txt',
    'fileNameLineCol' : 'file.txt',
  };
  var got = _.introspector.locationNormalize( o );
  test.identical( got, exp );
  test.true( got === o );

  /* */

  test.case = 'stack frame with Windows path';
  var o = { original : 'at Object.stackBasic (C:\\dir\\Introspector.test.s:48:79)' };
  var exp =
  {
    'original' : 'at Object.stackBasic (C:\\dir\\Introspector.test.s:48:79)',
    'filePath' : '/C/dir/Introspector.test.s',
    'routineName' : 'Object.stackBasic',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 48,
    'col' : 79,
    'filePathLineCol' : '/C/dir/Introspector.test.s:48:79',
    'routineFilePathLineCol' : 'Object.stackBasic @ /C/dir/Introspector.test.s:48:79',
    'fileName' : 'Introspector.test.s',
    'fileNameLineCol' : 'Introspector.test.s:48:79',
  };
  var got = _.introspector.locationNormalize( o );
  test.identical( got, exp );

  /* */

  test.case = '<anonymous> in stack frame, windows path';
  var o = { original : 'at wConsequence.<anonymous> (C:\\dir\\File.js:9:15)' };
  var exp =
  {
    'original' : 'at wConsequence.<anonymous> (C:\\dir\\File.js:9:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.{-anonymous-}',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 9,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:9:15',
    'routineFilePathLineCol' : 'wConsequence.{-anonymous-} @ /C/dir/File.js:9:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:9:15',
  };
  var got = _.introspector.locationNormalize( o );
  test.identical( got, exp );

  /* */

  test.case = 'a few <anonymous> in stack frame, normalized path';
  var o = { original : 'at wConsequence.<anonymous>.<anonymous> (/C/dir/File.js:9:15)' };
  var exp =
  {
    'original' : 'at wConsequence.<anonymous>.<anonymous> (/C/dir/File.js:9:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.{-anonymous-}.{-anonymous-}',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 9,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:9:15',
    'routineFilePathLineCol' : 'wConsequence.{-anonymous-}.{-anonymous-} @ /C/dir/File.js:9:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:9:15',
  };
  var got = _.introspector.locationNormalize( o );
  test.identical( got, exp );

  /* */

  test.case = 'eval and <anonymous> in stack frame';
  var o = { original : 'at eval (<anonymous>:1:16)' };
  var exp =
  {
    'original' : 'at eval (<anonymous>:1:16)',
    'filePath' : '<anonymous>',
    'routineName' : 'eval',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 1,
    'col' : 16,
    'filePathLineCol' : '<anonymous>:1:16',
    'routineFilePathLineCol' : 'eval @ <anonymous>:1:16',
    'fileName' : '<anonymous>',
    'fileNameLineCol' : '<anonymous>:1:16',
  };
  var got = _.introspector.locationNormalize( o );
  test.identical( got, exp );

  /* */

  test.case = 'windows filePath nested in parentheses with routineName and <anonymous>';
  var o = { original : 'at eval (eval at program2 (C:\\basic\\program2.js:13:5), <anonymous>:1:16)' };
  var exp =
  {
    'original' : 'at eval (eval at program2 (C:\\basic\\program2.js:13:5), <anonymous>:1:16)',
    'filePath' : '/C/basic/program2.js',
    'routineName' : 'program2',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 13,
    'col' : 5,
    'filePathLineCol' : '/C/basic/program2.js:13:5',
    'routineFilePathLineCol' : 'program2 @ /C/basic/program2.js:13:5',
    'fileName' : 'program2.js',
    'fileNameLineCol' : 'program2.js:13:5',
  };
  var got = _.introspector.locationNormalize( o );
  test.identical( got, exp );

  /* */

  test.case = 'normalized filePath nested in parentheses with routineName and <anonymous>';
  var o = { original : 'at eval (eval at program2 (/C/basic/program2.js:13:5), <anonymous>:1:16)' };
  var exp =
  {
    'original' : 'at eval (eval at program2 (/C/basic/program2.js:13:5), <anonymous>:1:16)',
    'filePath' : '/C/basic/program2.js',
    'routineName' : 'program2',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 0,
    'line' : 13,
    'col' : 5,
    'filePathLineCol' : '/C/basic/program2.js:13:5',
    'routineFilePathLineCol' : 'program2 @ /C/basic/program2.js:13:5',
    'fileName' : 'program2.js',
    'fileNameLineCol' : 'program2.js:13:5',
  };
  var got = _.introspector.locationNormalize( o );
  test.identical( got, exp );

  /* */

  test.case = 'original with routine alias';
  var o = { original : 'at routine [as time] (/C/basic/program2.js:13:5)' };
  var exp =
  {
    'original' : 'at routine [as time] (/C/basic/program2.js:13:5)',
    'filePath' : '/C/basic/program2.js',
    'routineName' : 'routine',
    'routineAlias' : 'time',
    'internal' : 0,
    'abstraction' : 0,
    'line' : 13,
    'col' : 5,
    'filePathLineCol' : '/C/basic/program2.js:13:5',
    'routineFilePathLineCol' : 'routine @ /C/basic/program2.js:13:5',
    'fileName' : 'program2.js',
    'fileNameLineCol' : 'program2.js:13:5',
  };
  var got = _.introspector.locationNormalize( o );
  test.identical( got, exp );

  /* */

  test.case = 'original with internal in path';
  var o = { original : 'at routine [as time] (internal/event)' };
  var exp =
  {
    'original' : 'at routine [as time] (internal/event)',
    'filePath' : 'internal/event',
    'routineName' : 'routine',
    'routineAlias' : 'time',
    'internal' : 2,
    'abstraction' : 0,
    'line' : null,
    'col' : null,
    'filePathLineCol' : 'internal/event',
    'routineFilePathLineCol' : 'routine @ internal/event',
    'fileName' : 'event',
    'fileNameLineCol' : 'event',
  };
  var got = _.introspector.locationNormalize( o );
  test.identical( got, exp );

  /* */

  test.case = 'original with internal in path';
  var o = { original : 'at routine [as time] (node:internal/event)' };
  var exp =
  {
    'original' : 'at routine [as time] (node:internal/event)',
    'filePath' : 'node:internal/event',
    'routineName' : 'routine',
    'routineAlias' : 'time',
    'internal' : 2,
    'abstraction' : 0,
    'line' : null,
    'col' : null,
    'filePathLineCol' : 'node:internal/event',
    'routineFilePathLineCol' : 'routine @ node:internal/event',
    'fileName' : 'event',
    'fileNameLineCol' : 'event',
  };
  var got = _.introspector.locationNormalize( o );
  test.identical( got, exp );

  /* */

  test.case = 'routineName has two underscores, abstraction - 2';
  var o = { original : 'at wConsequence.__handle__Now (C:\\dir\\File.js:5:15)' };
  var exp =
  {
    'original' : 'at wConsequence.__handle__Now (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.__handle__Now',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 2,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence.__handle__Now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  };
  var got = _.introspector.locationNormalize( o );
  test.identical( got, exp );

  /* */

  test.case = 'routineName has single underscore, abstraction - 1';
  var o = { original : 'at wConsequence._handle__Now (C:\\dir\\File.js:5:15)' };
  var exp =
  {
    'original' : 'at wConsequence._handle__Now (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence._handle__Now',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 1,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence._handle__Now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  };
  var got = _.introspector.locationNormalize( o );
  test.identical( got, exp );

  /* */

  test.case = 'routineName has two underscores, abstraction - 2';
  var o = { original : 'at wConsequence.__handle__Now (C:\\dir\\File.js:5:15)' };
  var exp =
  {
    'original' : 'at wConsequence.__handle__Now (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.__handle__Now',
    'routineAlias' : null,
    'internal' : 0,
    'abstraction' : 2,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence.__handle__Now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  };
  var got = _.introspector.locationNormalize( o );
  test.identical( got, exp );

  /* */

  test.case = 'routineAlias has single underscore, abstraction - 1';
  var o = { original : 'at wConsequence.now [as _now] (C:\\dir\\File.js:5:15)' };
  var exp =
  {
    'original' : 'at wConsequence.now [as _now] (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.now',
    'routineAlias' : '_now',
    'internal' : 0,
    'abstraction' : 1,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence.now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  };
  var got = _.introspector.locationNormalize( o );
  test.identical( got, exp );

  /* */

  test.case = 'routineAlias has two underscores, abstraction - 2';
  var o = { original : 'at wConsequence.now [as __now] (C:\\dir\\File.js:5:15)' };
  var exp =
  {
    'original' : 'at wConsequence.now [as __now] (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.now',
    'routineAlias' : '__now',
    'internal' : 0,
    'abstraction' : 2,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence.now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  };
  var got = _.introspector.locationNormalize( o );
  test.identical( got, exp );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.introspector.locationNormalize() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.introspector.locationNormalize( { original : '' }, { filePath : '/home/user' } ) );

  test.case = 'wrong type of o';
  test.shouldThrowErrorSync( () => _.introspector.locationNormalize([ '/some/path' ]) );

  test.case = 'unknown option in map o';
  test.shouldThrowErrorSync( () => _.introspector.locationNormalize({ unknown : '', original : '' }) );
}

//

function locationToStack( test )
{
  test.case = 'without options';
  var o = {};
  var exp = null;
  var got = _.introspector.locationToStack( o );
  test.identical( got, exp );

  /* - */

  test.case = 'empty string';
  var o = { original : '' };
  var exp = null;
  var got = _.introspector.locationToStack( o );
  test.identical( got, exp );

  test.case = 'stack frame line with posix path';
  var o = { original : 'at node (/home/user/file.txt)' };
  var exp = 'at node (/home/user/file.txt)';
  var got = _.introspector.locationToStack( o );
  test.identical( got, exp );

  test.case = 'stack frame with Windows path';
  var o = { original : 'at Object.stackBasic (C:\\dir\\Introspector.test.s:48:79)' };
  var exp = 'at Object.stackBasic (/C/dir/Introspector.test.s:48:79)';
  var got = _.introspector.locationToStack( o );
  test.identical( got, exp );

  test.case = '<anonymous> in stack frame, windows path';
  var o = { original : 'at wConsequence.<anonymous> (C:\\dir\\File.js:9:15)' };
  var exp = 'at wConsequence.{-anonymous-} (/C/dir/File.js:9:15)';
  var got = _.introspector.locationToStack( o );
  test.identical( got, exp );

  test.case = 'a few <anonymous> in stack frame, normalized path';
  var o = { original : 'at wConsequence.<anonymous>.<anonymous> (/C/dir/File.js:9:15)' };
  var exp = 'at wConsequence.{-anonymous-}.{-anonymous-} (/C/dir/File.js:9:15)';
  var got = _.introspector.locationToStack( o );
  test.identical( got, exp );

  test.case = 'eval and <anonymous> in stack frame';
  var o = { original : 'at eval (<anonymous>:1:16)' };
  var exp = 'at eval (<anonymous>:1:16)';
  var got = _.introspector.locationToStack( o );
  test.identical( got, exp );

  test.case = 'windows filePath nested in parentheses with routineName and <anonymous>';
  var o = { original : 'at eval (eval at program2 (C:\\basic\\program2.js:13:5), <anonymous>:1:16)' };
  var exp = 'at program2 (/C/basic/program2.js:13:5)';
  var got = _.introspector.locationToStack( o );
  test.identical( got, exp );

  test.case = 'normalized filePath nested in parentheses with routineName and <anonymous>';
  var o = { original : 'at eval (eval at program2 (/C/basic/program2.js:13:5), <anonymous>:1:16)' };
  var exp = 'at program2 (/C/basic/program2.js:13:5)';
  var got = _.introspector.locationToStack( o );
  test.identical( got, exp );

  test.case = 'original with routine alias';
  var o = { original : 'at routine [as time] (/C/basic/program2.js:13:5)' };
  var exp = 'at routine (/C/basic/program2.js:13:5)';
  var got = _.introspector.locationToStack( o );
  test.identical( got, exp );

  test.case = 'original with internal in path';
  var o = { original : 'at routine [as time] (internal/event)' };
  var exp = 'at routine (internal/event)';
  var got = _.introspector.locationToStack( o );
  test.identical( got, exp );

  test.case = 'original with internal in path';
  var o = { original : 'at routine [as time] (node:internal/event)' };
  var exp = 'at routine (node:internal/event)';
  var got = _.introspector.locationToStack( o );
  test.identical( got, exp );

  test.case = 'routineName has two underscores, abstraction - 2';
  var o = { original : 'at wConsequence.__handle__Now (C:\\dir\\File.js:5:15)' };
  var exp = 'at wConsequence.__handle__Now (/C/dir/File.js:5:15)';
  var got = _.introspector.locationToStack( o );
  test.identical( got, exp );

  test.case = 'routineName has single underscore, abstraction - 1';
  var o = { original : 'at wConsequence._handle__Now (C:\\dir\\File.js:5:15)' };
  var exp = 'at wConsequence._handle__Now (/C/dir/File.js:5:15)';
  var got = _.introspector.locationToStack( o );
  test.identical( got, exp );

  test.case = 'routineName has two underscores, abstraction - 2';
  var o = { original : 'at wConsequence.__handle__Now (C:\\dir\\File.js:5:15)' };
  var exp = 'at wConsequence.__handle__Now (/C/dir/File.js:5:15)';
  var got = _.introspector.locationToStack( o );
  test.identical( got, exp );

  test.case = 'routineAlias has single underscore, abstraction - 1';
  var o = { original : 'at wConsequence.now [as _now] (C:\\dir\\File.js:5:15)' };
  var exp = 'at wConsequence.now (/C/dir/File.js:5:15)';
  var got = _.introspector.locationToStack( o );
  test.identical( got, exp );

  test.case = 'routineAlias has two underscores, abstraction - 2';
  var o = { original : 'at wConsequence.now [as __now] (C:\\dir\\File.js:5:15)' };
  var exp = 'at wConsequence.now (/C/dir/File.js:5:15)';
  var got = _.introspector.locationToStack( o );
  test.identical( got, exp );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.introspector.locationToStack() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.introspector.locationToStack( { original : '' }, { filePath : '/home/user' } ) );

  test.case = 'wrong type of o';
  test.shouldThrowErrorSync( () => _.introspector.locationToStack([ '/some/path' ]) );

  test.case = 'unknown option in map o';
  test.shouldThrowErrorSync( () => _.introspector.locationToStack({ unknown : '', original : '' }) );
}

// --
// declare
// --

const Proto =
{

  name : 'Tools.Introspector.l0.l9',
  silencing : 1,

  onSuiteBegin,
  onSuiteEnd,

  context :
  {
    suiteTempPath : null,
    assetsOriginalPath : null,
    appJsPath : null,
  },

  tests :
  {

    locationFromStackFrameWithoutLocationField,
    locationFromStackFrameWithLocationField,

    locationNormalize,
    locationToStack,

  }

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
