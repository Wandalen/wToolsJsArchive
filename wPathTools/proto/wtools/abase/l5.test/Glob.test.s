( function _Glob_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../node_modules/Tools' );
  _.include( 'wTesting' );
  require( '../l5/PathTools.s' );

}

const _global = _global_;
const _ = _global_.wTools;

// --
// tests
// --

function fromGlob( test )
{

  test.case = 'trailed';
  var expected = '/a/b/';
  var got = _.path.fromGlob( '/a/b/' );
  test.identical( got, expected );

  test.case = 'doted';
  var expected = './a/b';
  var got = _.path.fromGlob( './a/b' );
  test.identical( got, expected );

  var expected = '/a/b';
  var got = _.path.fromGlob( '/a/b/**' );
  test.identical( got, expected );

  var expected = '/a';
  var got = _.path.fromGlob( '/a/b**' );
  test.identical( got, expected );

  var expected = '/';
  var got = _.path.fromGlob( '/(src1|src2)/**' );
  test.identical( got, expected );

  var expected = '/a';
  var got = _.path.fromGlob( '/a/(src1|src2)/**' );
  test.identical( got, expected );

  /* - */

  test.open( 'base marker *()' );

  var expected = '/';
  var got = _.path.fromGlob( '/src1*()' );
  test.identical( got, expected );

  var expected = '/';
  var got = _.path.fromGlob( '/*()src1' );
  test.identical( got, expected );

  var expected = '/';
  var got = _.path.fromGlob( '/src1*()/src2' );
  test.identical( got, expected );

  var expected = '/';
  var got = _.path.fromGlob( '/*()src1/src2' );
  test.identical( got, expected );

  var expected = '/src1';
  var got = _.path.fromGlob( '/src1/sr*()c2' );
  test.identical( got, expected );

  var expected = '/src1';
  var got = _.path.fromGlob( '/src1/src2*()' );
  test.identical( got, expected );

  var expected = '/src1';
  var got = _.path.fromGlob( '/src1/*()src2' );
  test.identical( got, expected );

  test.close( 'base marker *()' );

  /* - */

  test.open( 'base marker ()' );

  var expected = '/';
  var got = _.path.fromGlob( '/src1()' );
  test.identical( got, expected );

  var expected = '/';
  var got = _.path.fromGlob( '/()src1' );
  test.identical( got, expected );

  var expected = '/';
  var got = _.path.fromGlob( '/src1()/src2' );
  test.identical( got, expected );

  var expected = '/';
  var got = _.path.fromGlob( '/()src1/src2' );
  test.identical( got, expected );

  var expected = '/src1';
  var got = _.path.fromGlob( '/src1/sr()c2' );
  test.identical( got, expected );

  var expected = '/src1';
  var got = _.path.fromGlob( '/src1/src2()' );
  test.identical( got, expected );

  var expected = '/src1';
  var got = _.path.fromGlob( '/src1/()src2' );
  test.identical( got, expected );

  test.close( 'base marker ()' );

  /* - */

  test.open( 'base marker \\0' );

  var expected = '/';
  var got = _.path.fromGlob( '/src1\0' );
  test.identical( got, expected );

  var expected = '/';
  var got = _.path.fromGlob( '/\0src1' );
  test.identical( got, expected );

  var expected = '/';
  var got = _.path.fromGlob( '/src1\0/src2' );
  test.identical( got, expected );

  var expected = '/';
  var got = _.path.fromGlob( '/\0src1/src2' );
  test.identical( got, expected );

  var expected = '/src1';
  var got = _.path.fromGlob( '/src1/sr\0c2' );
  test.identical( got, expected );

  var expected = '/src1';
  var got = _.path.fromGlob( '/src1/src2\0' );
  test.identical( got, expected );

  var expected = '/src1';
  var got = _.path.fromGlob( '/src1/\0src2' );
  test.identical( got, expected );

  test.close( 'base marker \\0' );

  /* - */

}

//

function _globAnalogs1( test )
{

  test.case = '**proto**dir2**';
  var src = '**proto**dir2**';
  var expected = '***/*proto*/***/*dir2*/***';
  var got = _.path._globAnalogs1( src );
  test.identical( got, expected );

  test.case = '**proto/**/dir2**';
  var src = '**proto/**/dir2**';
  var expected = '***/*proto/**/dir2*/***';
  var got = _.path._globAnalogs1( src );
  test.identical( got, expected );

}

//

function _globAnalogs2( test )
{

  /* */

  var got = _.path._globAnalogs2( '/**/b/**', '/a', '/a/b/c' );
  var expected = [ '../../**/b/**', './**/b/**' ];
  test.identical( got, expected );

  /* */

  var got = _.path._globAnalogs2( '/doubledir/d1/**', '/doubledir/d1', '/doubledir/d1/d11' );
  var expected = [ '../**', './**' ];
  test.identical( got, expected );

  /* */

  var got = _.path._globAnalogs2( '/doubledir/d1/**', '/doubledir', '/doubledir/d1/d11' );
  var expected = [ '../../d1/**', './**' ];
  test.identical( got, expected );

  /* */

  var got = _.path._globAnalogs2( '/doubledir/d1/*', '/doubledir', '/doubledir/d1/d11' );
  var expected = [ '../../d1/*', './*' ];
  test.identical( got, expected );

  /* */

  var got = _.path._globAnalogs2( '/doubledir/d1/*', '/doubledir2', '/doubledir2/d1/d11' );
  var expected = [];
  test.identical( got, expected );

  /* */

  var got = _.path._globAnalogs2( '/src1/**', '/src2', '/src2' );
  var expected = [];
  test.identical( got, expected );

  var got = _.path._globAnalogs2( '/src2/**', '/src2', '/src2' );
  var expected = [ './**' ];
  test.identical( got, expected );

  /* */

  var got = _.path._globAnalogs2( '/src1/**', '/src2', '/' );
  var expected = [];
  test.identical( got, expected );

  var got = _.path._globAnalogs2( '/src2/**', '/src2', '/' );
  var expected = [ './src2/**' ];
  test.identical( got, expected );

  var got = _.path._globAnalogs2( '/src1/**', '/', '/src2' );
  var expected = [ '../src1/**' ];
  test.identical( got, expected );

  var got = _.path._globAnalogs2( '/src2/**', '/', '/src2' );
  var expected = [ '../src2/**', './**' ];
  test.identical( got, expected );

  /* */

  var got = _.path._globAnalogs2( '/src1/**', '/src2', '/src1' );
  var expected = [];
  test.identical( got, expected );

  var got = _.path._globAnalogs2( '/src1/**', '/src1', '/src2' );
  var expected = [ '../src1/**' ];
  test.identical( got, expected );

  /* - */

  test.shouldThrowErrorSync( () =>
  {
    var expected = [ './file' ];
    var globPath = 'src1Terminal/file';
    var filePath = '/';
    var basePath = '/src1Terminal';
    var got = _.path._globAnalogs2( globPath, filePath, basePath );
    test.identical( got, expected );
  } );

  test.shouldThrowErrorSync( () =>
  {
    var expected = [ '../../b/c/f' ];
    var globPath = 'f';
    var filePath = '/a/b/c';
    var basePath = '/a/d/e';
    var got = _.path._globAnalogs2( globPath, filePath, basePath );
    test.identical( got, expected );
  } );

  test.shouldThrowErrorSync( () =>
  {
    var got = _.path._globAnalogs2( '/src1Terminal', '/', '/src1Terminal' )
    var expected = [ '.' ];
    test.identical( got, expected );
  } );

}

// --
// glob short
// --

function globShortSplitToRegexp( test )
{

  var got = _.path.globShortSplitToRegexp( '**/b/**' );
  var expected = /^.*\/b\/.*$/;
  test.identical( got, expected );

}

//

function globShortFilter( test )
{
  let path = _.path;

  // *
  test.case = 'empty right glob';
  test.description = 'empty selector';
  var expected = [];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globShortFilter( src, '' );
  test.identical( got, expected );

  test.case = 'mandatory single char followed by * that should never be found';
  test.description = 'selector out of league';
  var expected = [];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globShortFilter( src, 'z*' );
  test.identical( got, expected );

  test.case = '* followed by mandatory char that should never be found';
  var expected = [];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globShortFilter( src, '*a' );
  test.identical( got, expected );

  test.case = 'mandatory double char followed by * that should never be found';
  test.description = 'selector starts with double out of league chars';
  var expected = [];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globShortFilter( src, 'za*' );
  test.identical( got, expected );

  test.case = '* followed by mandatory double char that should never be found';
  test.description = 'selector ends with double out of league chars';
  var expected = [];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globShortFilter( src, '*az' );
  test.identical( got, expected );

  test.case = 'plain mandatory string that should never be found';
  test.description = 'selector string length overflow';
  var expected = [];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globShortFilter( src, 'dbba' );
  test.identical( got, expected );

  test.case = 'plain mandatory string that should be found';
  test.description = 'selector string length overflow';
  var expected = [ 'dbb' ];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globShortFilter( src, 'dbb' );
  test.identical( got, expected );

  test.case = 'mandatory char followed by * that should be found';
  test.description = 'selector string starts with d';
  var expected = [ 'dbb', 'dab' ];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globShortFilter( src, 'd*' );
  test.identical( got, expected );

  test.case = '* followed by mandatory char that should be found';
  var expected = [ 'adb', 'dbb', 'dab' ];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globShortFilter( src, '*b' );
  test.identical( got, expected );

  test.case = 'mid glob';
  var expected = [ 'abc', 'abd', 'adb', 'dab' ];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globShortFilter( src, '*a*' );
  test.identical( got, expected );

  test.case = 'mid glob double';
  var expected = [ 'dbb', 'dbba' ];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab', 'dbba' ];
  var got = path.globShortFilter( src, '*bb*' );
  test.identical( got, expected );

  test.case = 'not glob';
  var expected = [ 'abd' ];
  var src = [ 'abc', 'abd', 'adb' ];
  var got = path.globShortFilter( src, 'abd' );
  test.identical( got, expected );

  test.case = 'any glob';
  var expected = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globShortFilter( src, '*' );
  test.identical( got, expected );

  // ?
  test.case = 'glob match exact 1 char with string len=3';
  var expected = [ 'dbb', 'dab' ];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab', 'dbba' ];
  var got = path.globShortFilter( src, 'd?b' );
  test.identical( got, expected );

  test.case = 'glob match exact 1 char with string len=2';
  var expected = [ 'ab', 'ad', 'ac' ];
  var src = [ 'ab', 'ad', 'ac', 'abc', 'adb', 'acb' ];
  var got = path.globShortFilter( src, 'a?' );
  test.identical( got, expected );

  // ? & *
  test.case = 'right glob len = atleast 2 chars';
  var expected = [ 'ab', 'ad', 'ac', 'abc', 'adb', 'acb' ];
  var src = [ 'ab', 'ad', 'ac', 'abc', 'adb', 'acb' ];
  var got = path.globShortFilter( src, 'a?*' );
  test.identical( got, expected );

  // (...)
  test.case = 'empty char glob for a group of digits';
  var expected = [ ];
  var src = [ 1, 2, 3, 4, 5, 123, 456, 123456, 7890 ];
  var got = path.globShortFilter( src, '+([a-g])' );
  test.identical( got, expected );

  test.case = 'glob range group of chars';
  var expected = [ 'abc', 'abcd', 'abcde', 'abcdef', 'abcdefg', 'a' ];
  var src = [ 'abc', 'abcd', 'abcde', 'abcdef', 'abcdefg', 'a', 1, 'xyz', 'abcdefghij' ];
  var got = path.globShortFilter( src, '+([a-g])' );
  test.identical( got, expected );

  test.case = 'glob range group of chars and must have more trailing';
  var expected = [ 'abc', 'abcd', 'abcde', 'abcdef', 'abcdefg', 'abcdefghij' ];
  var src = [ 'abc', 'abcd', 'abcde', 'abcdef', 'abcdefg', 'a', 1, 'xyz', 'abcdefghij' ];
  var got = path.globShortFilter( src, '+([a-g])+([a-z])' );
  test.identical( got, expected );

  test.case = 'glob range group of chars and may have more trailing';
  var expected = [ 'abc', 'abcd', 'abcde', 'abcdef', 'abcdefg', 'a', 'abcdefghij' ];
  var src = [ 'abc', 'abcd', 'abcde', 'abcdef', 'abcdefg', 'a', 1, 'xyz', 'abcdefghij' ];
  var got = path.globShortFilter( src, '+([a-g])*([a-z])' );
  test.identical( got, expected );

  test.case = 'glob range skip - (!)';
  var expected = [ 1, 'xyz', 'abcdefghij' ];
  var src = [ 'abc', 'abcd', 'abcde', 'abcdef', 'abcdefg', 'a', 1, 'xyz', 'abcdefghij' ];
  var got1 = path.globShortFilter( src, '*[!a-g]' );
  var got2 = path.globShortFilter( src, '*[^a-g]' );
  test.identical( got1, expected );
  test.identical( got2, expected );

  // |
  test.case = 'pattern match = none';
  var expected = [ ];
  var src = [ 'a', 'b', 'bb' ];
  var got = path.globShortFilter( src, 'a(b|bb|bc)' );
  test.identical( got, expected );

  test.case = 'pattern match = all ending with c';
  var expected = [ 'abcc' ];
  var src = [ 'abcc', 'bc', 'ac' ];
  var got = path.globShortFilter( src, '(ab|bb|abc)c' );
  test.identical( got, expected );

  test.case = '2 chars starting with either a or b but ending with c';
  var expected = [ 'ac' ];
  var src = [ 'ac', 'abc', 'cc' ];
  var got = path.globShortFilter( src, '(a|b)c' );
  test.identical( got, expected );

  // +(|)
  test.case = 'pattern with single group';
  var expected = [ 'axyzz' ];
  var src = [ 'axyzz', 'adefz', 'azyxz' ];
  var got = path.globShortFilter( src, 'a+(xyz)z' );
  test.identical( got, expected );

  test.case = 'pattern with 2 groups';
  var expected = [ 'axyzz', 'adefz' ];
  var src = [ 'abz', 'acz', 'zzz', 'axyzz', 'adefz' ];
  var got = path.globShortFilter( src, 'a+(xyz|def)z' );
  test.identical( got, expected );

  test.case = 'empty digit glob for group of unexpected chars';
  var expected = [ ];
  var src = [ 'abc', 'abcd', 'abcde', 'abcdef', 'abcdefg', 'a' ];
  var got = path.globShortFilter( src, '+([0-9])' );
  test.identical( got, expected );

  test.case = 'digit glob for group of digits';
  var expected = [ 1, 2, 3, 4, 5, 123, 456, 123456, 7890 ];
  var src = [ 1, 2, 3, 4, 5, 123, 456, 123456, 7890, 'a', 'abc' ];
  var got = path.globShortFilter( src, '+([0-9])' );
  test.identical( got, expected );

  // *(|)
  test.case = 'empty digit glob for group of unexpected chars';
  var expected = [ ];
  var src = [ 'abc', 'abcd', 'abcde', 'abcdef', 'abcdefg', 'a' ];
  var got = path.globShortFilter( src, '*([0-9])' );
  test.identical( got, expected );

  test.case = 'all strings that owns a car';
  var expected = [ 'car', 'cart', 'carting', 'cariter' ];
  var src = [ 'car', 'cart', 'carting', 'cariter' ];
  var got = path.globShortFilter( src, 'car*(t|ting|iter)' );
  test.identical( got, expected );

  // !(|)
  test.case = 'not pattern match = none';
  var expected = [ ];
  var src = [ 'ab', 'ac' ];
  var got1 = path.globShortFilter( src, 'a!(b|c)' );
  test.identical( got1, expected );

  test.case = '3 chars starting with a, skip b-k, end with z';
  var expected = [ 'azz' ];
  var src = [ 'abz', 'acz', 'azz' ];
  var got = path.globShortFilter( src, 'a!(b|c|d|e|f|g|h|i|j|k)z' );
  test.identical( got, expected );

  test.case = 'any 3 chars, no z in the middle';
  var expected = [ 'abz', 'acz' ];
  var src = [ 'abz', 'acz', 'zzz' ];
  var got = path.globShortFilter( src, 'a!(z)z' );
  test.identical( got, expected );

  test.case = 'any 3 chars, no xyz in the middle';
  var expected = [ 'abz', 'acz' ];
  var src = [ 'abz', 'acz', 'zzz' ];
  var got = path.globShortFilter( src, 'a!(xyz)z' );
  test.identical( got, expected );

  test.case = 'skip a group of chars';
  var expected = [ 'car', 'cat', 'carpool', 'ca' ];
  var src = [ 'car', 'cat', 'catastrophic', 'carnage', 'carpool', 'ca' ];
  var got = path.globShortFilter( src, 'ca!(tastrophic|rnage)' );
  test.identical( got, expected );

  // @
  test.case = 'match exactly one of the patterns';
  var expected = [ 'catastrophic', 'carnage' ];
  var src = [ 'car', 'cat', 'catastrophic', 'carnage', 'carpool', 'ca' ];
  var got = path.globShortFilter( src, 'ca@(tastrophic|rnage)' );
  test.identical( got, expected );

  // // FIXME: Everything below this line
  // test.case = 'must throw errors';
  // var src = [ 'car', 'cat', 'catastrophic', 'carnage', 'carpool', 'ca' ];
  // test.shouldThrowErrorSync(path.globShortFilter());
  // test.shouldThrowErrorSync(path.globShortFilter( src ));
  // test.shouldThrowErrorSync(path.globShortFilter( src, null ));
  // test.shouldThrowErrorSync(path.globShortFilter( null, 'lorem' ));
  // test.shouldThrowErrorSync(path.globShortFilter( null, null ));
  //
  // test.case = 'plain numbers as glob must fail';
  // var src = [ 0, 1, 2, 3, 4 ];
  // test.shouldThrowErrorSync( path.globShortFilter( src, 0 ) );

}

//

function globShortFilterVals( test )
{
  let path = _.path;

  /* - */

  test.open( 'from array' );

  test.case = 'trivial glob';
  var expected = [ 'abc', 'abd' ];
  var src = [ 'abc', 'abd', 'adb' ];
  var got = path.globShortFilterVals( src, 'ab*' );
  test.identical( got, expected );

  test.case = 'not glob';
  var expected = [ 'abd' ];
  var src = [ 'abc', 'abd', 'adb' ];
  var got = path.globShortFilterVals( src, 'abd' );
  test.identical( got, expected );

  test.close( 'from array' );

  /* - */

  test.open( 'map by element' );

  test.case = 'trivial glob';
  var expected = { a : 'abc', b : 'abd' };
  var src = { a : 'abc', b : 'abd', c : 'adb' };
  var got = path.globShortFilterVals( src, 'ab*' );
  test.identical( got, expected );

  test.case = 'not glob';
  var expected = { b : 'abd' };
  var src = { a : 'abc', b : 'abd', c : 'adb' };
  var got = path.globShortFilterVals( src, 'abd' );
  test.identical( got, expected );

  test.close( 'map by element' );

  /* - */

}

//

function globShortFilterKeys( test )
{
  let path = _.path;

  /* - */

  test.open( 'from array' );

  test.case = 'trivial glob';
  var expected = [ 'abc', 'abd' ];
  var src = [ 'abc', 'abd', 'adb' ];
  var got = path.globShortFilterKeys( src, 'ab*' );
  test.identical( got, expected );

  test.case = 'not glob';
  var expected = [ 'abd' ];
  var src = [ 'abc', 'abd', 'adb' ];
  var got = path.globShortFilterKeys( src, 'abd' );
  test.identical( got, expected );

  test.close( 'from array' );

  /* - */

  test.open( 'map by element' );

  test.case = 'trivial glob';
  var expected = { abc : 'a', abd : 'b' };
  var src = { abc : 'a', abd : 'b', adb : 'c' };
  var got = path.globShortFilterKeys( src, 'ab*' );
  test.identical( got, expected );

  test.case = 'not glob';
  var expected = { abd : 'b' };
  var src = { abc : 'a', abd : 'b', adb : 'c' };
  var got = path.globShortFilterKeys( src, 'abd' );
  test.identical( got, expected );

  test.close( 'map by element' );

  /* - */

}

//

function globShortFit( test )
{

  /* - */

  test.case = 'abc - abc';
  test.identical( _.path.globShortFit( 'abc', 'abc' ), true );
  test.identical( _.path.globShortFit( 'abc', '/abc' ), false );
  test.identical( _.path.globShortFit( '/abc', 'abc' ), false );
  test.identical( _.path.globShortFit( '/abc', '/abc' ), true );

  test.case = 'abc - abd';
  test.identical( _.path.globShortFit( 'abc', 'abd' ), false );
  test.identical( _.path.globShortFit( 'abc', '/abd' ), false );
  test.identical( _.path.globShortFit( '/abc', 'abd' ), false );
  test.identical( _.path.globShortFit( '/abc', '/abd' ), false );

  test.case = 'abc - ab*';
  test.identical( _.path.globShortFit( 'abc', 'ab*' ), true );
  test.identical( _.path.globShortFit( 'abc', '/ab*' ), false );
  test.identical( _.path.globShortFit( '/abc', 'ab*' ), false );
  test.identical( _.path.globShortFit( '/abc', '/ab*' ), true );

  test.case = 'adc - ab*';
  test.identical( _.path.globShortFit( 'adc', 'ab*' ), false );
  test.identical( _.path.globShortFit( 'adc', '/ab*' ), false );
  test.identical( _.path.globShortFit( '/adc', 'ab*' ), false );
  test.identical( _.path.globShortFit( '/adc', '/ab*' ), false );

  test.case = 'abc - *abc';
  test.identical( _.path.globShortFit( 'abc', '*abc' ), true );
  test.identical( _.path.globShortFit( 'abc', '/*abc' ), false );
  test.identical( _.path.globShortFit( '/abc', '*abc' ), false );
  test.identical( _.path.globShortFit( '/abc', '/*abc' ), true );

  test.case = 'abc - *ab';
  test.identical( _.path.globShortFit( 'abc', '*ab' ), false );
  test.identical( _.path.globShortFit( 'abc', '/*ab' ), false );
  test.identical( _.path.globShortFit( '/abc', '*ab' ), false );
  test.identical( _.path.globShortFit( '/abc', '/*ab' ), false );

  test.case = 'abc - a*c';
  test.identical( _.path.globShortFit( 'abc', 'a*c' ), true );
  test.identical( _.path.globShortFit( 'abc', '/a*c' ), false );
  test.identical( _.path.globShortFit( '/abc', 'a*c' ), false );
  test.identical( _.path.globShortFit( '/abc', '/a*c' ), true );

  test.case = 'a/b/c - */c';
  test.identical( _.path.globShortFit( 'a/b/c', '*/c' ), false );
  test.identical( _.path.globShortFit( 'a/b/c', '/*/c' ), false );
  test.identical( _.path.globShortFit( '/a/b/c', '*/c' ), false );
  test.identical( _.path.globShortFit( '/a/b/c', '/*/c' ), false );

  test.case = 'a/b/c - */*/c';
  test.identical( _.path.globShortFit( 'a/b/c', '*/*/c' ), true );
  test.identical( _.path.globShortFit( 'a/b/c', '/*/*/c' ), false );
  test.identical( _.path.globShortFit( '/a/b/c', '*/*/c' ), false );
  test.identical( _.path.globShortFit( '/a/b/c', '/*/*/c' ), true );

  test.case = 'a/b/c - **/c';
  test.identical( _.path.globShortFit( 'a/b/c', '**/c' ), true );
  test.identical( _.path.globShortFit( 'a/b/c', '/**/c' ), false );
  test.identical( _.path.globShortFit( '/a/b/c', '**/c' ), true );
  test.identical( _.path.globShortFit( '/a/b/c', '/**/c' ), true );

  test.case = 'a/b/c/d/e.js - **/*.js';
  test.identical( _.path.globShortFit( 'a/b/c/d/e.js', '**/*.js' ), true );
  test.identical( _.path.globShortFit( 'a/b/c/d/e.js', '/**/*.js' ), false );
  test.identical( _.path.globShortFit( '/a/b/c/d/e.js', '**/*.js' ), true );
  test.identical( _.path.globShortFit( '/a/b/c/d/e.js', '/**/*.js' ), true );

  test.case = 'f.js - **/**/**.js';
  test.identical( _.path.globShortFit( 'f.js', '**/**/**.js' ), false ); /* xxx : implement */
  test.identical( _.path.globShortFit( 'f.js', '/**/**/**.js' ), false );
  test.identical( _.path.globShortFit( '/f.js', '**/**/**.js' ), false );
  test.identical( _.path.globShortFit( '/f.js', '/**/**/**.js' ), false );

  test.case = 'a/f.js - **/**.js';
  test.identical( _.path.globShortFit( 'a/f.js', '**/**.js' ), true );
  test.identical( _.path.globShortFit( 'a/f.js', '/**/**.js' ), false );
  test.identical( _.path.globShortFit( '/a/f.js', '**/**.js' ), true );
  test.identical( _.path.globShortFit( '/a/f.js', '/**/**.js' ), true );

  /* - */

}

// --
// glob long
// --

function globLongFit( test )
{

  /* - */

  test.case = 'abc - abc';
  test.identical( _.path.globLongFit( 'abc', 'abc' ), true );
  test.identical( _.path.globLongFit( 'abc', '/abc' ), false );
  test.identical( _.path.globLongFit( '/abc', 'abc' ), false );
  test.identical( _.path.globLongFit( '/abc', '/abc' ), true );

  test.case = 'abc - abd';
  test.identical( _.path.globLongFit( 'abc', 'abd' ), false );
  test.identical( _.path.globLongFit( 'abc', '/abd' ), false );
  test.identical( _.path.globLongFit( '/abc', 'abd' ), false );
  test.identical( _.path.globLongFit( '/abc', '/abd' ), false );

  test.case = 'abc - ab*';
  test.identical( _.path.globLongFit( 'abc', 'ab*' ), true );
  test.identical( _.path.globLongFit( 'abc', '/ab*' ), false );
  test.identical( _.path.globLongFit( '/abc', 'ab*' ), false );
  test.identical( _.path.globLongFit( '/abc', '/ab*' ), true );

  test.case = 'adc - ab*';
  test.identical( _.path.globLongFit( 'adc', 'ab*' ), false );
  test.identical( _.path.globLongFit( 'adc', '/ab*' ), false );
  test.identical( _.path.globLongFit( '/adc', 'ab*' ), false );
  test.identical( _.path.globLongFit( '/adc', '/ab*' ), false );

  test.case = 'abc - *abc';
  test.identical( _.path.globLongFit( 'abc', '*abc' ), true );
  test.identical( _.path.globLongFit( 'abc', '/*abc' ), false );
  test.identical( _.path.globLongFit( '/abc', '*abc' ), false );
  test.identical( _.path.globLongFit( '/abc', '/*abc' ), true );

  test.case = 'abc - *ab';
  test.identical( _.path.globLongFit( 'abc', '*ab' ), false );
  test.identical( _.path.globLongFit( 'abc', '/*ab' ), false );
  test.identical( _.path.globLongFit( '/abc', '*ab' ), false );
  test.identical( _.path.globLongFit( '/abc', '/*ab' ), false );

  test.case = 'abc - a*c';
  test.identical( _.path.globLongFit( 'abc', 'a*c' ), true );
  test.identical( _.path.globLongFit( 'abc', '/a*c' ), false );
  test.identical( _.path.globLongFit( '/abc', 'a*c' ), false );
  test.identical( _.path.globLongFit( '/abc', '/a*c' ), true );

  test.case = 'a/b/c - */c';
  test.identical( _.path.globLongFit( 'a/b/c', '*/c' ), false );
  test.identical( _.path.globLongFit( 'a/b/c', '/*/c' ), false );
  test.identical( _.path.globLongFit( '/a/b/c', '*/c' ), false );
  test.identical( _.path.globLongFit( '/a/b/c', '/*/c' ), false );

  test.case = 'a/b/c - */*/c';
  test.identical( _.path.globLongFit( 'a/b/c', '*/*/c' ), true );
  test.identical( _.path.globLongFit( 'a/b/c', '/*/*/c' ), false );
  test.identical( _.path.globLongFit( '/a/b/c', '*/*/c' ), true );
  test.identical( _.path.globLongFit( '/a/b/c', '/*/*/c' ), true );

  test.case = 'a/b/c - **/c';
  test.identical( _.path.globLongFit( 'a/b/c', '**/c' ), true );
  test.identical( _.path.globLongFit( 'a/b/c', '/**/c' ), false );
  test.identical( _.path.globLongFit( '/a/b/c', '**/c' ), true );
  test.identical( _.path.globLongFit( '/a/b/c', '/**/c' ), true );

  test.case = 'a/b/c/d/e.js - **/*.js';
  test.identical( _.path.globLongFit( 'a/b/c/d/e.js', '**/*.js' ), true );
  test.identical( _.path.globLongFit( 'a/b/c/d/e.js', '/**/*.js' ), false );
  test.identical( _.path.globLongFit( '/a/b/c/d/e.js', '**/*.js' ), true );
  test.identical( _.path.globLongFit( '/a/b/c/d/e.js', '/**/*.js' ), true );

  test.case = 'f.js - **/**/**.js';
  test.identical( _.path.globLongFit( 'f.js', '**/**/**.js' ), true );
  test.identical( _.path.globLongFit( 'f.js', '/**/**/**.js' ), false );
  test.identical( _.path.globLongFit( '/f.js', '**/**/**.js' ), true );
  test.identical( _.path.globLongFit( '/f.js', '/**/**/**.js' ), true );

  test.case = 'a/f.js - **/**.js';
  test.identical( _.path.globLongFit( 'a/f.js', '**/**.js' ), true );
  test.identical( _.path.globLongFit( 'a/f.js', '/**/**.js' ), false );
  test.identical( _.path.globLongFit( '/a/f.js', '**/**.js' ), true );
  test.identical( _.path.globLongFit( '/a/f.js', '/**/**.js' ), true );

  /* - */

}

//

function pathMapToRegexps( test )
{

  /* */

  test.case = 'abc - abc';
  let expMap =
  {
    'filePath' : { '/abc' : '' },
    'basePath' : { '/abc' : '/abc' },
    'fileGlobToPathMap' : { '/abc' : '/abc' },
    'filePathToGlobMap' :
    {
      '/abc' : [ '/abc' ]
    },
    'unglobedFilePath' : { '/abc' : '' },
    'optimizedUnglobedFilePath' : { '/abc' : '' },
    'unglobedBasePath' : { '/abc' : '/abc' },
    'optimizedUnglobedBasePath' : { '/abc' : '/abc' },
    'redundantArray' : [],
    'groupsMap' : { '/abc' : {} },
    'optimalGroupsMap' : { '/abc' : {} },
    'optimalRegexpsMap' :
    {
      '/abc' :
      {
        'certainlyHash' : new HashMap(),
        'transient' : [],
        'actualAny' : [],
        'actualAny2' : [],
        'actualAll' : [],
        'actualNone' : [],
      }
    },
    'regexpsMap' :
    {
      '/abc' :
      {
        'certainlyHash' : new HashMap(),
        'transient' : [],
        'actualAny' : [],
        'actualAny2' : [],
        'actualAll' : [],
        'actualNone' : [],
      }
    }
  }
  let filePath = { '/abc' : true }
  let basePath = { '/abc' : '/abc' }
  let gotMap = _.path.pathMapToRegexps( filePath, basePath );
  test.identical( gotMap, expMap );

  /* */

}

// --
// declare
// --

const Proto =
{

  name : 'Tools.l3.path.Glob',
  silencing : 1,

  tests :
  {

    // etc

    fromGlob,
    _globAnalogs1,
    _globAnalogs2,

    // short

    globShortSplitToRegexp,
    globShortFilter,
    globShortFilterVals,
    globShortFilterKeys,
    globShortFit,

    // long

    globLongFit,

    //

    pathMapToRegexps,

  },

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )();
