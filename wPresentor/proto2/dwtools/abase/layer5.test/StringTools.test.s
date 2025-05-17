( function _StringTools_test_s_() {

'use strict';

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

  var _ = _global_.wTools;

  _.include( 'wTesting' );
  require( '../layer5/StringTools.s' );

}

var _ = _global_.wTools;

// --
//
// --

function strCamelize( test )
{

  test.case = 'converts string to camelcase';
  var got = _.strCamelize( 'a-b_c/d' );
  var expected = 'aBCD';
  test.identical( got,expected );

  test.case = 'string with spaces';
  var got = _.strCamelize( '.test -str_ing /with .spaces' );
  var expected = 'Test StrIng With Spaces';
  test.identical( got,expected );

  test.case = 'string with no spaces';
  var got = _.strCamelize( 'camel.case/string' );
  var expected = 'camelCaseString';
  test.identical( got,expected );

  test.case = 'empty string';
  var got = _.strCamelize( '' );
  var expected = '';
  test.identical( got,expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strCamelize( 'one','two' );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strCamelize( );
  });

  test.case = 'wrong argument type';
  test.shouldThrowError( function()
  {
    _.strCamelize( 111 );
  });

  test.case = 'wrong argument type';
  test.shouldThrowError( function()
  {
    _.strCamelize( [ ] );
  });

}

//

function strToTitle( test )
{

  test.case = 'trivial';
  var src = 'someString';
  var expected = 'some string';
  var got = _.strToTitle( src );
  test.identical( got, expected );

  test.case = 'trivial - first upper case';
  var src = 'SomeString';
  var expected = 'Some string';
  var got = _.strToTitle( src );
  test.identical( got, expected );

  test.case = 'several tokens';
  var src = 'abcEfgHigMigg';
  var expected = 'abc efg hig migg';
  var got = _.strToTitle( src );
  test.identical( got, expected );

  test.case = 'with digits and spaces';
  var src = 'someString13 ThisIs14 1999 year1d';
  var expected = 'some string 13 This is 14 1999 year 1 d';
  var got = _.strToTitle( src );
  test.identical( got, expected );

  test.case = 'with digits and spaces and underscore';
  var src = 'some_test_13_14_this is __13__ __x__';
  var expected = 'some test 13 14 this is 13 x';
  var got = _.strToTitle( src );
  test.identical( got, expected );

  test.case = 'with digits and spaces and dot';
  var src = 'some.test_13.14.this is ..13.. ..x..';
  var expected = 'some test 13 14 this is 13 x';
  var got = _.strToTitle( src );
  test.identical( got, expected );

}

//

function strFilenameFor( test )
{

  test.case = 'converts string to camelcase';
  var got = _.strFilenameFor( '"example\\file?name.txt' );
  var expected = '_example_file_name.txt';
  test.identical( got,expected );

  test.case = 'convertion with options';
  var got = _.strFilenameFor({ srcString : '\'example\\file?name.js', 'delimeter':'#' } );
  var expected = '#example#file#name.js';
  test.identical( got,expected );

  test.case = 'empty string';
  var got = _.strFilenameFor( '' );
  var expected = '';
  test.identical( got,expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strFilenameFor( 'one','two','three' );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strFilenameFor( );
  });

  test.case = 'first argument is wrong';
  test.shouldThrowError( function()
  {
    _.strFilenameFor( 111 );
  });

  test.case = 'second argument is wrong';
  test.shouldThrowError( function()
  {
    _.strFilenameFor( '"example\\file?name.txt','wrong' );
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( () => _.strFilenameFor() );

  test.case = 'too many arguments';
  test.shouldThrowError( () => _.strFilenameFor( 1,1 ) );

  test.case = 'bad arguments';
  test.shouldThrowError( () => _.strFilenameFor( null ) );

  test.case = 'bad arguments';
  test.shouldThrowError( () => _.strFilenameFor( undefined ) );

  test.case = 'bad arguments';
  test.shouldThrowError( () => _.strFilenameFor( {} ) );

  test.case = 'bad arguments';
  test.shouldThrowError( () => _.strFilenameFor( [] ) );

}

//

function strHtmlEscape( test )
{

  test.case = 'replaces html escape symbols';
  var got = _.strHtmlEscape( '<&test &text &here>' );
  var expected = '&lt;&amp;test &amp;text &amp;here&gt;';
  test.identical( got,expected );

  test.case = 'replaces html escape symbols from array';
  var got = _.strHtmlEscape( ['&','<'] );
  var expected = '&amp;,&lt;';
  test.identical( got,expected );

  test.case = 'object passed';
  var got = _.strHtmlEscape( {'prop': 'value'} );
  var expected = '[object Object]';
  test.identical( got,expected );

  test.case = 'empty string';
  var got = _.strHtmlEscape( '' );
  var expected = '';
  test.identical( got,expected );

  test.case = 'nothin replaced';
  var got = _.strHtmlEscape( 'text' );
  var expected = 'text';
  test.identical( got,expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strHtmlEscape( 'one','two' );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strHtmlEscape( );
  });

}

//

/*
  qqq : duplicate test cases for fast : 1
*/

function strFindAll( test )
{

  function log( src )
  {
    logger.log( _.toStr( src, { levels : 3 } ) );
  }

  /* - */

  test.open( 'string' );

  test.case = 'simple replace';
  var got = _.strFindAll( 'aabaa','b' );
  var expected =
  [
    {
      groups : [ 'b' ],
      match : 'b',
      tokenId : 0,
      range : [ 2, 3 ],
      counter : 0,
      input : 'aabaa'
    }
  ]
  log( got );
  test.identical( got,expected );

  test.case = 'simple replace';
  var got = _.strFindAll( 'aabaa','aa' );
  var expected =
  [
    {
      groups : [ 'aa' ],
      match : 'aa',
      tokenId : 0,
      range : [ 0, 2 ],
      counter : 0,
      input : 'aabaa'
    },
    {
      groups : [ 'aa' ],
      match : 'aa',
      tokenId : 0,
      range : [ 3, 5 ],
      counter : 1,
      input : 'aabaa'
    }
  ]
  log( got );
  test.identical( got,expected );

  test.case = 'first two args empty strings';
  var got = _.strFindAll( '', '' );
  var expected = [];
  log( got );
  test.identical( got,expected );

  test.case = 'secong argument is empty string';
  var got = _.strFindAll( 'a', '' );
  var expected = [];
  log( got );
  test.identical( got,expected );

  test.case = 'all three args empty strings';
  var got = _.strFindAll( '', '' );
  var expected = [];
  log( got );
  test.identical( got,expected );

  test.case = 'third arg is empty string ';
  var got = _.strFindAll( 'a', 'a' );
  var expected =
  [
    {
      groups : [ 'a' ],
      match : 'a',
      tokenId : 0,
      range : [ 0, 1 ],
      counter : 0,
      input : 'a'
    }
  ]
  log( got );
  test.identical( got,expected );

  test.case = 'one argument call';
  var got = _.strFindAll({ src : 'gpxa', ins : [ 'x' , 'a' ] });
  var expected =
  [
    {
      groups : [ 'x' ],
      match : 'x',
      tokenId : 0,
      range : [ 2, 3 ],
      counter : 0,
      input : 'gpxa'
    },
    {
      groups : [ 'a' ],
      match : 'a',
      tokenId : 1,
      range : [ 3, 4 ],
      counter : 1,
      input : 'gpxa'
    }
  ]
  log( got );
  test.identical( got,expected );

  test.case = 'two arguments call';
  var got = _.strFindAll( 'hello', [ 'l' ] );
  var expected =
  [
    {
      groups : [ 'l' ],
      match : 'l',
      tokenId : 0,
      range : [ 2, 3 ],
      counter : 0,
      input : 'hello'
    },
    {
      groups : [ 'l' ],
      match : 'l',
      tokenId : 0,
      range : [ 3, 4 ],
      counter : 1,
      input : 'hello'
    }
  ]
  log( got );
  test.identical( got,expected );

  test.case = 'no occurrences returns origin';
  var got = _.strFindAll( 'hello', 'x' );
  var expected = [];
  log( got );
  test.identical( got,expected );

  test.case = 'empty array';
  var got = _.strFindAll( 'hello', [] );
  var expected = [];
  log( got );
  test.identical( got,expected );

  test.case = 'empty by empty, empty src';
  var got = _.strFindAll( '','' );
  var expected = [];
  log( got );
  test.identical( got,expected );

  test.case = 'not empty by empty, empty src';
  var got = _.strFindAll( '','x' );
  var expected = [];
  log( got );
  test.identical( got,expected );

  test.case = 'empty by not empty, empty src';
  var got = _.strFindAll( '','' );
  var expected = [];
  log( got );
  test.identical( got,expected );

  test.case = 'empty by empty, not empty src';
  var got = _.strFindAll( 'x','' );
  var expected = [];
  log( got );
  test.identical( got,expected );

  test.case = 'not empty by empty, not empty src';
  var got = _.strFindAll( 'x','x' );
  var expected =
  [
    {
      groups : [ 'x' ],
      match : 'x',
      tokenId : 0,
      range : [ 0, 1 ],
      counter : 0,
      input : 'x'
    }
  ]
  log( got );
  test.identical( got,expected );

  test.case = 'empty by not empty, not empty src';
  var got = _.strFindAll( 'x','' );
  var expected = [];
  log( got );
  test.identical( got,expected );

  test.case = 'repeat';
  var got = _.strFindAll( 'ababab','ab' );
  var expected =
  [
    {
      groups : [ 'ab' ],
      match : 'ab',
      tokenId : 0,
      range : [ 0, 2 ],
      counter : 0,
      input : 'ababab'
    },
    {
      groups : [ 'ab' ],
      match : 'ab',
      tokenId : 0,
      range : [ 2, 4 ],
      counter : 1,
      input : 'ababab'
    },
    {
      groups : [ 'ab' ],
      match : 'ab',
      tokenId : 0,
      range : [ 4, 6 ],
      counter : 2,
      input : 'ababab'
    }
  ]
  log( got );
  test.identical( got,expected );

  test.case = 'repeat';
  var got = _.strFindAll( 'abaabab',[ 'aa','ab' ] );
  var expected =
  [
    {
      groups : [ 'ab' ],
      match : 'ab',
      tokenId : 1,
      range : [ 0, 2 ],
      counter : 0,
      input : 'abaabab'
    },
    {
      groups : [ 'aa' ],
      match : 'aa',
      tokenId : 0,
      range : [ 2, 4 ],
      counter : 1,
      input : 'abaabab'
    },
    {
      groups : [ 'ab' ],
      match : 'ab',
      tokenId : 1,
      range : [ 5, 7 ],
      counter : 2,
      input : 'abaabab'
    }
  ]
  log( got );
  test.identical( got,expected );

  test.case = 'no recursion should happen';
  var got = _.strFindAll( 'abcabc', [ 'abc', 'a' ] );
  var expected =
  [
    {
      groups : [ 'abc' ],
      match : 'abc',
      tokenId : 0,
      range : [ 0, 3 ],
      counter : 0,
      input : 'abcabc'
    },
    {
      groups : [ 'abc' ],
      match : 'abc',
      tokenId : 0,
      range : [ 3, 6 ],
      counter : 1,
      input : 'abcabc'
    }
  ]
  log( got );
  test.identical( got,expected );

  test.case = 'no recursion should happen';
  var got = _.strFindAll( 'abcabc', [ 'a', 'abc' ] );
  var expected =
  [
    {
      groups : [ 'a' ],
      match : 'a',
      tokenId : 0,
      range : [ 0, 1 ],
      counter : 0,
      input : 'abcabc'
    },
    {
      groups : [ 'a' ],
      match : 'a',
      tokenId : 0,
      range : [ 3, 4 ],
      counter : 1,
      input : 'abcabc'
    }
  ]
  log( got );
  test.identical( got,expected );

  test.close( 'string' );

  /* - */

  test.open( 'regexp with no flags' );

  var got = _.strFindAll( 'aabaa', /b/ );
  var expected =
  [
    {
      groups : [ 'b' ],
      match : 'b',
      tokenId : 0,
      range : [ 2, 3 ],
      counter : 0,
      input : 'aabaa'
    }
  ]
  log( got );
  test.identical( got,expected );

  var got = _.strFindAll( '12345', /[1-3]/ );
  var expected =
  [
    {
      groups : [ '1' ],
      match : '1',
      tokenId : 0,
      range : [ 0, 1 ],
      counter : 0,
      input : '12345'
    },
    {
      groups : [ '2' ],
      match : '2',
      tokenId : 0,
      range : [ 1, 2 ],
      counter : 1,
      input : '12345'
    },
    {
      groups : [ '3' ],
      match : '3',
      tokenId : 0,
      range : [ 2, 3 ],
      counter : 2,
      input : '12345'
    }
  ]
  log( got );
  test.identical( got,expected );

  var got = _.strFindAll( 'gpbaac', /a+/ );
  var expected =
  [
    {
      groups : [ 'aa' ],
      match : 'aa',
      tokenId : 0,
      range : [ 3, 5 ],
      counter : 0,
      input : 'gpbaac'
    }
  ]
  log( got );
  test.identical( got,expected );

  var got = _.strFindAll( 'gpbgpcgpd', /(gp)+[^bc]$/ );
  var expected =
  [
    {
      groups : [ 'gpd', 'gp' ],
      match : 'gpd',
      tokenId : 0,
      range : [ 6, 9 ],
      counter : 0,
      input : 'gpbgpcgpd'
    }
  ]
  log( got );
  test.identical( got,expected );

  var got = _.strFindAll( 'gpa', [ 'a' ] );
  var expected =
  [
    {
      groups : [ 'a' ],
      match : 'a',
      tokenId : 0,
      range : [ 2, 3 ],
      counter : 0,
      input : 'gpa'
    }
  ]
  log( got );
  test.identical( got,expected );

  var got = _.strFindAll( 'gpa', [ /a/ ] );
  var expected =
  [
    {
      groups : [ 'a' ],
      match : 'a',
      tokenId : 0,
      range : [ 2, 3 ],
      counter : 0,
      input : 'gpa'
    }
  ]
  log( got );
  test.identical( got,expected );

  var got = _.strFindAll( 'gpa', [ /a/ ] );
  var expected =
  [
    {
      groups : [ 'a' ],
      match : 'a',
      tokenId : 0,
      range : [ 2, 3 ],
      counter : 0,
      input : 'gpa'
    }
  ]
  log( got );
  test.identical( got,expected );

  var got = _.strFindAll( 'gpahpb', [ 'a', 'b' ] );
  var expected =
  [
    {
      groups : [ 'a' ],
      match : 'a',
      tokenId : 0,
      range : [ 2, 3 ],
      counter : 0,
      input : 'gpahpb'
    },
    {
      groups : [ 'b' ],
      match : 'b',
      tokenId : 1,
      range : [ 5, 6 ],
      counter : 1,
      input : 'gpahpb'
    }
  ]
  log( got );
  test.identical( got,expected );

  var got = _.strFindAll( 'gpahpb', [ /a/, /b/ ] );
  var expected =
  [
    {
      groups : [ 'a' ],
      match : 'a',
      tokenId : 0,
      range : [ 2, 3 ],
      counter : 0,
      input : 'gpahpb'
    },
    {
      groups : [ 'b' ],
      match : 'b',
      tokenId : 1,
      range : [ 5, 6 ],
      counter : 1,
      input : 'gpahpb'
    }
  ]
  log( got );
  test.identical( got,expected );

  var got = _.strFindAll( 'gpahpb', [ /a/, 'b' ] );
  var expected =
  [
    {
      groups : [ 'a' ],
      match : 'a',
      tokenId : 0,
      range : [ 2, 3 ],
      counter : 0,
      input : 'gpahpb'
    },
    {
      groups : [ 'b' ],
      match : 'b',
      tokenId : 1,
      range : [ 5, 6 ],
      counter : 1,
      input : 'gpahpb'
    }
  ]
  log( got );
  test.identical( got,expected );

  var got = _.strFindAll( 'gpahpb', [ 'a', /b/ ] );
  var expected =
  [
    {
      groups : [ 'a' ],
      match : 'a',
      tokenId : 0,
      range : [ 2, 3 ],
      counter : 0,
      input : 'gpahpb'
    },
    {
      groups : [ 'b' ],
      match : 'b',
      tokenId : 1,
      range : [ 5, 6 ],
      counter : 1,
      input : 'gpahpb'
    }
  ]
  log( got );
  test.identical( got,expected );

  test.case = 'trivial ins:string sub:routine';
  var got = _.strFindAll( 'this is hello from hell', 'hell' );
  var expected =
  [
    {
      groups : [ 'hell' ],
      match : 'hell',
      tokenId : 0,
      range : [ 8, 12 ],
      counter : 0,
      input : 'this is hello from hell'
    },
    {
      groups : [ 'hell' ],
      match : 'hell',
      tokenId : 0,
      range : [ 19, 23 ],
      counter : 1,
      input : 'this is hello from hell'
    }
  ]
  log( got );
  test.identical( got, expected );

  test.case = 'trivial ins:regexp sub:routine';
  var got = _.strFindAll( 'this is hello from hell', /hell/ );
  var expected =
  [
    {
      groups : [ 'hell' ],
      match : 'hell',
      tokenId : 0,
      range : [ 8, 12 ],
      counter : 0,
      input : 'this is hello from hell'
    },
    {
      groups : [ 'hell' ],
      match : 'hell',
      tokenId : 0,
      range : [ 19, 23 ],
      counter : 1,
      input : 'this is hello from hell'
    }
  ]
  log( got );
  test.identical( got, expected );

  test.close( 'regexp with no flags' );

  /* - */

  test.open( 'regexp with gm' );

  var got = _.strFindAll( 'aabaa', /b/gm );
  var expected =
  [
    {
      groups : [ 'b' ],
      match : 'b',
      tokenId : 0,
      range : [ 2, 3 ],
      counter : 0,
      input : 'aabaa'
    }
  ]
  log( got );
  test.identical( got,expected );

  var got = _.strFindAll( '12345', /[1-3]/gm );
  var expected =
  [
    {
      groups : [ '1' ],
      match : '1',
      tokenId : 0,
      range : [ 0, 1 ],
      counter : 0,
      input : '12345'
    },
    {
      groups : [ '2' ],
      match : '2',
      tokenId : 0,
      range : [ 1, 2 ],
      counter : 1,
      input : '12345'
    },
    {
      groups : [ '3' ],
      match : '3',
      tokenId : 0,
      range : [ 2, 3 ],
      counter : 2,
      input : '12345'
    }
  ]
  log( got );
  test.identical( got,expected );

  var got = _.strFindAll( 'gpbaac', /a+/gm );
  var expected =
  [
    {
      groups : [ 'aa' ],
      match : 'aa',
      tokenId : 0,
      range : [ 3, 5 ],
      counter : 0,
      input : 'gpbaac'
    }
  ]
  log( got );
  test.identical( got,expected );

  var got = _.strFindAll( 'gpbgpcgpd', /(gp)+[^bc]$/gm );
  var expected =
  [
    {
      groups : [ 'gpd', 'gp' ],
      match : 'gpd',
      tokenId : 0,
      range : [ 6, 9 ],
      counter : 0,
      input : 'gpbgpcgpd'
    }
  ]
  log( got );
  test.identical( got,expected );

  var got = _.strFindAll( 'gpa', [ 'a' ] );
  var expected =
  [
    {
      groups : [ 'a' ],
      match : 'a',
      tokenId : 0,
      range : [ 2, 3 ],
      counter : 0,
      input : 'gpa'
    }
  ]
  log( got );
  test.identical( got,expected );

  var got = _.strFindAll( 'gpa', [ /a/ ] );
  var expected =
  [
    {
      groups : [ 'a' ],
      match : 'a',
      tokenId : 0,
      range : [ 2, 3 ],
      counter : 0,
      input : 'gpa'
    }
  ]
  log( got );
  test.identical( got,expected );

  var got = _.strFindAll( 'gpa', [ /a/gm ] );
  var expected =
  [
    {
      groups : [ 'a' ],
      match : 'a',
      tokenId : 0,
      range : [ 2, 3 ],
      counter : 0,
      input : 'gpa'
    }
  ]
  log( got );
  test.identical( got,expected );

  var got = _.strFindAll( 'gpahpb', [ 'a', 'b' ] );
  var expected =
  [
    {
      groups : [ 'a' ],
      match : 'a',
      tokenId : 0,
      range : [ 2, 3 ],
      counter : 0,
      input : 'gpahpb'
    },
    {
      groups : [ 'b' ],
      match : 'b',
      tokenId : 1,
      range : [ 5, 6 ],
      counter : 1,
      input : 'gpahpb'
    }
  ]
  log( got );
  test.identical( got,expected );

  var got = _.strFindAll( 'gpahpb', [ /a/gm, /b/gm ] );
  var expected =
  [
    {
      groups : [ 'a' ],
      match : 'a',
      tokenId : 0,
      range : [ 2, 3 ],
      counter : 0,
      input : 'gpahpb'
    },
    {
      groups : [ 'b' ],
      match : 'b',
      tokenId : 1,
      range : [ 5, 6 ],
      counter : 1,
      input : 'gpahpb'
    }
  ]
  log( got );
  test.identical( got,expected );

  var got = _.strFindAll( 'gpahpb', [ /a/gm, 'b' ] );
  var expected =
  [
    {
      groups : [ 'a' ],
      match : 'a',
      tokenId : 0,
      range : [ 2, 3 ],
      counter : 0,
      input : 'gpahpb'
    },
    {
      groups : [ 'b' ],
      match : 'b',
      tokenId : 1,
      range : [ 5, 6 ],
      counter : 1,
      input : 'gpahpb'
    }
  ]
  log( got );
  test.identical( got,expected );

  var got = _.strFindAll( 'gpahpb', [ 'a', /b/gm ] );
  var expected =
  [
    {
      groups : [ 'a' ],
      match : 'a',
      tokenId : 0,
      range : [ 2, 3 ],
      counter : 0,
      input : 'gpahpb'
    },
    {
      groups : [ 'b' ],
      match : 'b',
      tokenId : 1,
      range : [ 5, 6 ],
      counter : 1,
      input : 'gpahpb'
    }
  ]
  log( got );
  test.identical( got,expected );

  test.case = 'trivial ins:string sub:routine';
  var got = _.strFindAll( 'this is hello from hell', 'hell' );
  var expected =
  [
    {
      groups : [ 'hell' ],
      match : 'hell',
      tokenId : 0,
      range : [ 8, 12 ],
      counter : 0,
      input : 'this is hello from hell'
    },
    {
      groups : [ 'hell' ],
      match : 'hell',
      tokenId : 0,
      range : [ 19, 23 ],
      counter : 1,
      input : 'this is hello from hell'
    }
  ]
  log( got );
  test.identical( got, expected );

  test.case = 'trivial ins:regexp sub:routine';
  var got = _.strFindAll( 'this is hello from hell', /hell/gm );
  var expected =
  [
    {
      groups : [ 'hell' ],
      match : 'hell',
      tokenId : 0,
      range : [ 8, 12 ],
      counter : 0,
      input : 'this is hello from hell'
    },
    {
      groups : [ 'hell' ],
      match : 'hell',
      tokenId : 0,
      range : [ 19, 23 ],
      counter : 1,
      input : 'this is hello from hell'
    }
  ]
  log( got );
  test.identical( got, expected );

  test.close( 'regexp with gm' );

  /* - */

  test.open( 'complex' );

  test.case = 'map';
  var map =
  {
    manya : /a+/,
    ba : /ba/,
  }
  var got = _.strFindAll( 'aabaa', map );
  log( got );
  var expected =
  [
    {
      groups : [ 'aa' ],
      match : 'aa',
      tokenId : 0,
      range : [ 0, 2 ],
      counter : 0,
      input : 'aabaa',
      tokenName : 'manya'
    },
    {
      groups : [ 'ba' ],
      match : 'ba',
      tokenId : 1,
      range : [ 2, 4 ],
      counter : 1,
      input : 'aabaa',
      tokenName : 'ba'
    },
    {
      groups : [ 'a' ],
      match : 'a',
      tokenId : 0,
      range : [ 4, 5 ],
      counter : 2,
      input : 'aabaa',
      tokenName : 'manya'
    }
  ]
  log( got );
  test.identical( got,expected );

  /**/

  test.case = 'map with tokenizingUnknwon : 1, but not unknown';
  var map =
  {
    manya : /a+/,
    ba : /ba/,
  }
  var got = _.strFindAll
  ({
    src : 'aabaa',
    ins : map,
    tokenizingUnknown : 1,
  });
  log( got );
  var expected =
  [
    {
      groups : [ 'aa' ],
      match : 'aa',
      tokenId : 0,
      range : [ 0, 2 ],
      counter : 0,
      input : 'aabaa',
      tokenName : 'manya'
    },
    {
      groups : [ 'ba' ],
      match : 'ba',
      tokenId : 1,
      range : [ 2, 4 ],
      counter : 1,
      input : 'aabaa',
      tokenName : 'ba'
    },
    {
      groups : [ 'a' ],
      match : 'a',
      tokenId : 0,
      range : [ 4, 5 ],
      counter : 2,
      input : 'aabaa',
      tokenName : 'manya'
    }
  ]
  log( got );
  test.identical( got,expected );

  /* */

  test.case = 'map with tokenizingUnknwon : 1 and unknown';
  var map =
  {
    manya : /a+/,
    ba : /ba/,
  }
  var got = _.strFindAll
  ({
    src : 'xaayybaaz',
    ins : map,
    tokenizingUnknown : 1,
  });
  debugger;
  log( got );
  var expected =
  [
    {
      match : 'x',
      groups : [ 'x' ],
      tokenId : -1,
      range : [ 0, 1 ],
      counter : 0,
      input : 'xaayybaaz',
      tokenName : undefined,
    },
    {
      match : 'aa',
      groups : [ 'aa' ],
      tokenId : 0,
      range : [ 1, 3 ],
      counter : 1,
      input : 'xaayybaaz',
      tokenName : 'manya',
    },
    {
      match : 'yy',
      groups : [ 'yy' ],
      tokenId : -1,
      range : [ 3, 5 ],
      counter : 2,
      input : 'xaayybaaz',
      tokenName : undefined,
    },
    {
      match : 'ba',
      groups : [ 'ba' ],
      tokenId : 1,
      range : [ 5, 7 ],
      counter : 3,
      input : 'xaayybaaz',
      tokenName : 'ba'
    },
    {
      match : 'a',
      groups : [ 'a' ],
      tokenId : 0,
      range : [ 7, 8 ],
      counter : 4,
      input : 'xaayybaaz',
      tokenName : 'manya'
    },
    {
      match : 'z',
      groups : [ 'z' ],
      tokenId : -1,
      range : [ 8, 9 ],
      counter : 5,
      input : 'xaayybaaz',
      tokenName : undefined,
    },
  ]
  log( got );
  debugger;
  test.identical( got,expected );

  /**/

  test.case = 'options map';

  var o =
  {
    src : '**',
    ins :
    [
      /\./g,
      /([!?*@+]+)\((.*?(?:\|(.*?))*)\)/g,
      /(\*\*\/|\*\*)/g,
      /(\*)/g,
      /(\?)/g
    ],
    fast : 0,
    counter : 1,
  }
  var got = _.strFindAll( o );
  var expected =
  [
    {
      match : '**',
      groups : [ '**', '**' ],
      tokenId : 2,
      range : [ 0, 2 ],
      counter : 1,
      input : '**',
    }
  ]
  log( got );
  test.identical( got, expected );

  test.close( 'complex' );

  /* - */

  if( !Config.debug )
  return;

  test.open( 'throwing' );

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strFindAll( '1', '2', '3', '4' );
  });

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strFindAll( '1', '2', '3' );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strFindAll( );
  });

  test.case = 'first argument is wrong';
  test.shouldThrowError( function()
  {
    _.strFindAll( 1, '2','3' );
  });

  test.case = 'second argument is wrong';
  test.shouldThrowError( function()
  {
    _.strFindAll( '1', 2, '3' );
  });

  test.case = 'third argument is wrong';
  test.shouldThrowError( function()
  {
    _.strFindAll( '1','2', 3 );
  });

  test.case = 'second arg is not a Object';
  test.shouldThrowError( function()
  {
    _.strFindAll( '1', 2 );
  });

  test.case = 'argument is not a Object';
  test.shouldThrowError( function()
  {
    _.strFindAll( '1' );
  });

  test.case = 'wrong type of dictionary value';
  test.shouldThrowError( function()
  {
    _.strFindAll( { dst : 'gpx', dictionary : { 'a' : [ 1, 2 ] } } )
  });

  test.shouldThrowError( function()
  {
    _.strFindAll( 'gpahpb',[ 'a' ], [ 'c', 'd' ] );
  });

  test.shouldThrowError( function()
  {
    _.strFindAll( 'gpahpb',[ 'a', 'b' ], [ 'x' ] );
  });

  test.shouldThrowError( function()
  {
    _.strFindAll( 'gpahpb',{ 'a' : [ 'x' ] } );
  });

  test.close( 'throwing' );
}

//

function strReplaceAll( test )
{

  /* */

  test.open( 'string' );

  test.case = 'simple replace';
  var got = _.strReplaceAll( 'aabaa','b','c' );
  var expected = 'aacaa';
  test.identical( got,expected );

  test.case = 'simple replace';
  var got = _.strReplaceAll( 'aabaa','aa','zz' );
  var expected = 'zzbzz';
  test.identical( got,expected );

  test.case = 'first two args empty strings';
  var got = _.strReplaceAll( '', '', 'c' );
  var expected = '';
  test.identical( got,expected );

  test.case = 'secong argument is empty string';
  var got = _.strReplaceAll( 'a', '', 'c' );
  var expected = 'a';
  test.identical( got,expected );

  test.case = 'all three args empty strings';
  var got = _.strReplaceAll( '', '', '' );
  var expected = '';
  test.identical( got,expected );

  test.case = 'third arg is empty string ';
  var got = _.strReplaceAll( 'a', 'a', '' );
  var expected = '';
  test.identical( got,expected );

  test.case = 'one argument call';
  var got = _.strReplaceAll( { src : 'gpx', dictionary : { 'x' : 'a' } } );
  var expected = 'gpa';
  test.identical( got,expected );

  test.case = 'two arguments call';
  var got = _.strReplaceAll( 'hello', { 'l' : 'y' } );
  var expected = 'heyyo';
  test.identical( got,expected );

  test.case = 'no occurrences returns origin';
  var got = _.strReplaceAll( 'hello', 'x', 'y' );
  var expected = 'hello';
  test.identical( got,expected );

  test.case = 'empty dictionary';
  var got = _.strReplaceAll( 'hello', { } );
  var expected = 'hello';
  test.identical( got,expected );

  /* special cases */

  test.case = 'empty by empty, empty src';
  var got = _.strReplaceAll( '','','' );
  var expected = '';
  test.identical( got,expected );

  test.case = 'not empty by empty, empty src';
  var got = _.strReplaceAll( '','x','' );
  var expected = '';
  test.identical( got,expected );

  test.case = 'empty by not empty, empty src';
  var got = _.strReplaceAll( '','','x' );
  var expected = '';
  test.identical( got,expected );

  test.case = 'empty by empty, not empty src';
  var got = _.strReplaceAll( 'x','','' );
  var expected = 'x';
  test.identical( got,expected );

  test.case = 'not empty by empty, not empty src';
  var got = _.strReplaceAll( 'x','x','' );
  var expected = '';
  test.identical( got,expected );

  test.case = 'empty by not empty, not empty src';
  var got = _.strReplaceAll( 'x','','x' );
  var expected = 'x';
  test.identical( got,expected );

  test.case = 'repeat';
  var got = _.strReplaceAll( 'ababab','ab','ab' );
  var expected = 'ababab';
  test.identical( got,expected );

  test.case = 'no recursion should happen';
  debugger;
  var got = _.strReplaceAll( 'abcabc',{ abc : 'a', a : 'b' } );
  debugger;
  var expected = 'aa';
  test.identical( got,expected );

  test.case = 'no recursion should happen';
  var got = _.strReplaceAll( 'abcabc',[ [ 'abc', 'a' ], [ 'a', 'b' ] ] );
  var expected = 'aa';
  test.identical( got,expected );

  test.case = 'no recursion should happen';
  var got = _.strReplaceAll( 'abcabc',[ [ 'a', 'b' ], [ 'abc', 'a' ] ] );
  var expected = 'bbcbbc';
  test.identical( got,expected );

  test.close( 'string' );

  /* - */

  test.open( 'regexp' );

  var got = _.strReplaceAll( 'aabaa',/b/gm,'c' );
  var expected = 'aacaa';
  test.identical( got,expected );

  var got = _.strReplaceAll( '12345',/[1-3]/gm,'0' );
  var expected = '00045';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'gpbaac',/a+/gm,'b' );
  var expected = 'gpbbc';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'gpbgpcgpd',/(gp)+[^bc]$/gm,'x' );
  var expected = 'gpbgpcx';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'gpa',[ 'a' ], [ 'b' ] );
  var expected = 'gpb';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'gpa',[ /a/ ], [ 'b' ] );
  var expected = 'gpb';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'gpa',[ /a/gm ], [ 'b' ] );
  var expected = 'gpb';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'gpahpb',[ 'a', 'b' ], [ 'c', 'd' ] );
  var expected = 'gpchpd';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'gpahpb',[ /a/gm, /b/gm ], [ 'c', 'd' ] );
  var expected = 'gpchpd';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'gpahpb',[ /a/gm, 'b' ], [ 'c', 'd' ] );
  var expected = 'gpchpd';
  test.identical( got,expected );

  function replaceHell( match, it )
  {
    test.identical( arguments.length, 2 );
    test.identical( match, 'hell' );

    if( it.counter === 0 )
    {
      var expectedIt = Object.create( null );
      expectedIt.match = 'hell';
      expectedIt.range = [ 8,12 ];
      expectedIt.counter = 0;
      expectedIt.input = 'this is hello from hell';
      expectedIt.groups = [ 'hell' ];
      expectedIt.tokenId = 0;
      test.identical( it, expectedIt );
    }
    else
    {
      var expectedIt = Object.create( null );
      expectedIt.match = 'hell';
      expectedIt.range = [ 19,23 ];
      expectedIt.counter = 1;
      expectedIt.input = 'this is hello from hell';
      expectedIt.groups = [ 'hell' ];
      expectedIt.tokenId = 0;
      test.identical( it, expectedIt );
    }

    return 'paradise';
  }

  test.case = 'trivial ins:string sub:routine';
  var got = _.strReplaceAll( 'this is hello from hell', 'hell', replaceHell );
  var expected = 'this is paradiseo from paradise';
  test.identical( got,expected );

  test.case = 'trivial ins:regexp sub:routine';
  var got = _.strReplaceAll( 'this is hello from hell', /hell/g, replaceHell );
  var expected = 'this is paradiseo from paradise';
  test.identical( got,expected );

  test.close( 'regexp' );

  /* - */

  if( !Config.debug )
  return;

  test.open( 'throwing' );

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strReplaceAll( '1', '2', '3', '4' );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strReplaceAll( );
  });

  test.case = 'first argument is wrong';
  test.shouldThrowError( function()
  {
    _.strReplaceAll( 1, '2','3');
  });

  test.case = 'second argument is wrong';
  test.shouldThrowError( function()
  {
    _.strReplaceAll( '1', 2, '3');
  });

  test.case = 'third argument is wrong';
  test.shouldThrowError( function()
  {
    _.strReplaceAll( '1','2', 3);
  });

  test.case = 'second arg is not a Object';
  test.shouldThrowError( function()
  {
    _.strReplaceAll( '1', 2);
  });

  test.case = 'argument is not a Object';
  test.shouldThrowError( function()
  {
    _.strReplaceAll( '1' );
  });

  test.case = 'wrong type of dictionary value';
  test.shouldThrowError( function()
  {
    _.strReplaceAll( { dst : 'gpx', dictionary : { 'a' : [ 1, 2 ] } } )
  });

  test.shouldThrowError( function()
  {
    _.strReplaceAll( 'gpahpb',[ 'a' ], [ 'c', 'd' ] );
  });

  test.shouldThrowError( function()
  {
    _.strReplaceAll( 'gpahpb',[ 'a', 'b' ], [ 'x' ] );
  });

  test.shouldThrowError( function()
  {
    _.strReplaceAll( 'gpahpb',{ 'a' : [ 'x' ] } );
  });

  test.close( 'throwing' );
}

//

function strTokenizeJs( test )
{

  function log( src )
  {
    logger.log( _.toStr( src, { levels : 3 } ) );
  }

  /* - */

  test.case = 'single line comment';

  var code = `
// type : 'image/png',
`;

  var expected =
  [
    {
      match : '\n',
      groups : [ '\n' ],
      tokenId : 5,
      range : [ 0, 1 ],
      counter : 0,
      input : code,
      tokenName : 'whitespace'
    },
    {
      match : `// type : 'image/png',`,
      groups : [ `// type : 'image/png',` ],
      tokenId : 1,
      range : [ 1, 23 ],
      counter : 1,
      input : code,
      tokenName : 'comment/singleline'
    },
    {
      match : '\n',
      groups : [ '\n' ],
      tokenId : 5,
      range : [ 23, 24 ],
      counter : 2,
      input : code,
      tokenName : 'whitespace'
    },
  ]

  debugger;
  var got = _.strTokenizeJs( code );

  log( code );
  log( _.entitySelect( got, '*.tokenName' ) );
  debugger;
  log( got );
  test.identical( got, expected );

  test.case = 'single line comment';

  var code =
` // divide by zero`

  var expected =
  [
    {
      match : ' ',
      groups : [ ' ' ],
      tokenId : 5,
      range : [ 0, 1 ],
      counter : 0,
      input : ' // divide by zero',
      tokenName : 'whitespace'
    },
    {
      match : '// divide by zero',
      groups : [ '// divide by zero' ],
      tokenId : 1,
      range : [ 1, 18 ],
      counter : 1,
      input : ' // divide by zero',
      tokenName : 'comment/singleline'
    }
  ]

  var got = _.strTokenizeJs( code );

  log( code );
  log( _.entitySelect( got, '*.tokenName' ) );
  log( got );
  test.identical( got, expected );

  /* - */

  test.case = 'single line comment inside long text looking like regexp';

  var code =
  `
for( var p = 0,pl = polygon.length / 2; p < pl ; p++ )
  // type : 'image/png',
`;

  var got = _.strTokenizeJs({ src : code, tokenizingUnknown : 1 });

  log( code );
  log( _.toStr( _.entitySelect( got, '*.match' ), { multiline : 0 } ) );
  log( _.entitySelect( got, '*.tokenName' ) );

  var tokenNamesGot = _.entitySelect( got, '*.tokenName' );
  var tokenNamesExpected = [ 'whitespace', 'keyword', 'parenthes', 'whitespace', 'keyword', 'whitespace', 'name', 'whitespace', 'punctuation', 'whitespace', 'number', 'punctuation', 'name', 'whitespace', 'punctuation', 'whitespace', 'name', 'punctuation', 'name', 'whitespace', 'punctuation', 'whitespace', 'number', 'punctuation', 'whitespace', 'name', 'whitespace', 'punctuation', 'whitespace', 'name', 'whitespace', 'punctuation', 'whitespace', 'name', 'punctuation', 'whitespace', 'parenthes', 'whitespace', 'comment/singleline', 'whitespace' ];
  test.identical( tokenNamesGot, tokenNamesExpected );

  var matchesGot = _.entitySelect( got, '*.match' );
  var matchesExpected = [ '\n', 'for', '(', ' ', 'var', ' ', 'p', ' ', '=', ' ', '0', ',', 'pl', ' ', '=', ' ', 'polygon', '.', 'length', ' ', '/', ' ', '2', ';', ' ', 'p', ' ', '<', ' ', 'pl', ' ', ';', ' ', 'p', '++', ' ', ')', '\n  ', '// type : \'image/png\',', '\n' ];
  test.identical( matchesGot, matchesExpected );

  /* - */

  test.case = 'multiline comment';

  var code =
`
  /**
   * @file File.js.
   */
`

  var expected =
  [
    {
      match : '\n  ',
      groups : [ '\n  ' ],
      tokenId : 5,
      range : [ 0, 3 ],
      counter : 0,
      input : code,
      tokenName : 'whitespace'
    },
    {
      match : `/**
   * @file File.js.
   */`,
      groups : [ `/**
   * @file File.js.
   */` ],
      tokenId : 0,
      range : [ 3, 32 ],
      counter : 1,
      input : code,
      tokenName : 'comment/multiline'
    },
    {
      match : '\n',
      groups : [ '\n' ],
      tokenId : 5,
      range : [ 32, 33 ],
      counter : 2,
      input : code,
      tokenName : 'whitespace'
    },
  ]

  var got = _.strTokenizeJs( code );

  log( code );
  log( _.entitySelect( got, '*.tokenName' ) );
  log( got );
  test.identical( got, expected );

  /* - */

  test.case = 'regular experssion without flags';

  var code = `/\d+/`;

  var expected =
  [
    {
      match : '/\d+/',
      groups : [ '/\d+/', '\d+', '' ],
      tokenId : 7,
      range : [ 0, 4 ],
      counter : 0,
      input : code,
      tokenName : 'regexp'
    },
  ]

  var got = _.strTokenizeJs( code );

  log( code );
  log( _.entitySelect( got, '*.tokenName' ) );
  log( got );
  test.identical( got, expected );

  /* - */

  test.case = 'regular experssion with flags';

  var code = `/\d+/ig`;

  var expected =
  [
    {
      match : '/\d+/ig',
      groups : [ '/\d+/ig', '\d+', 'ig' ],
      tokenId : 7,
      range : [ 0, 6 ],
      counter : 0,
      input : code,
      tokenName : 'regexp'
    },
  ]

  var got = _.strTokenizeJs( code );

  log( code );
  log( _.entitySelect( got, '*.tokenName' ) );
  log( got );
  test.identical( got, expected );

  /* - */

  // test.case = 'looking like regexp, but not';
  //
  // var x = / 2 , y /;
  // var code = `for( var p = x / 2 , y / 2 ; p < pl ; p++ )`;
  //
  // debugger;
  // var got = _.strTokenizeJs({ src : code, tokenizingUnknown : 1 });
  //
  // log( code );
  // log( _.toStr( _.entitySelect( got, '*.match' ), { multiline : 0 } ) );
  // log( _.entitySelect( got, '*.tokenName' ) );
  //
  // debugger;
  //
  // var tokenNamesGot = _.entitySelect( got, '*.tokenName' );
  // var tokenNamesExpected = [ 'whitespace', 'keyword', 'parenthes', 'whitespace', 'keyword', 'whitespace', 'name', 'whitespace', 'punctuation', 'whitespace', 'number', 'punctuation', 'name', 'whitespace', 'punctuation', 'whitespace', 'name', 'punctuation', 'name', 'whitespace', 'punctuation', 'whitespace', 'number', 'punctuation', 'whitespace', 'name', 'whitespace', 'punctuation', 'whitespace', 'name', 'whitespace', 'punctuation', 'whitespace', 'name', 'punctuation', 'whitespace', 'parenthes', 'whitespace', 'comment/singleline', 'whitespace' ];
  // test.identical( tokenNamesGot, tokenNamesExpected );
  //
  // var matchesGot = _.entitySelect( got, '*.match' );
  // var matchesExpected = [ '\n', 'for', '(', ' ', 'var', ' ', 'p', ' ', '=', ' ', '0', ',', 'pl', ' ', '=', ' ', 'polygon', '.', 'length', ' ', '/', ' ', '2', ';', ' ', 'p', ' ', '<', ' ', 'pl', ' ', ';', ' ', 'p', '++', ' ', ')', '\n  ', '// type : \'image/png\',', '\n' ];
  // test.identical( matchesGot, matchesExpected );

}

//

function strSorterParse( test )
{
  var src;
  var fields;
  var expected;
  var got;

  /* */

  test.case = 'str without special characters';
  src = 'ab'
  expected = [];
  got = _.strSorterParse( src );

  /* */

  test.case = 'single pair';
  src = 'a>'
  expected = [ [ 'a', 1 ] ];
  got = _.strSorterParse( src );

  /* */

  test.case = 'src only';

  src = 'a>b>'
  expected = [ [ 'a', 1 ], [ 'b', 1 ] ];
  got = _.strSorterParse( src );
  test.identical( got, expected );

  src = 'a<b<'
  expected = [ [ 'a', 0 ], [ 'b', 0 ] ];
  got = _.strSorterParse( src );
  test.identical( got, expected );

  src = 'a>b<'
  expected = [ [ 'a', 1 ], [ 'b', 0 ] ];
  got = _.strSorterParse( src );
  test.identical( got, expected );

  src = 'a<b>'
  expected = [ [ 'a', 0 ], [ 'b', 1 ] ];
  got = _.strSorterParse( src );
  test.identical( got, expected );

  src = 'a>b>c<d>'
  expected = [ [ 'a', 1 ], [ 'b', 1 ],[ 'c', 0 ], [ 'd', 1 ] ];
  got = _.strSorterParse( src );
  test.identical( got, expected );

  src = 'a+b>c-d<'
  expected = [ [ 'a+b', 1 ], [ 'c-d', 0 ] ];
  got = _.strSorterParse( src );
  test.identical( got, expected );

  /* */

  test.case = 'with fields';
  var fields = { a : 'a', b : 'b', 'a+b' : 1, 'c-d' : 1 };

  src = 'a>b>'
  expected = [ [ 'a', 1 ], [ 'b', 1 ] ];
  got = _.strSorterParse( src, fields );
  test.identical( got, expected );

  src = 'a<b<'
  expected = [ [ 'a', 0 ], [ 'b', 0 ] ];
  got = _.strSorterParse( src, fields );
  test.identical( got, expected );

  src = 'a>b<'
  expected = [ [ 'a', 1 ], [ 'b', 0 ] ];
  got = _.strSorterParse( src, fields );
  test.identical( got, expected );

  src = 'a<b>'
  expected = [ [ 'a', 0 ], [ 'b', 1 ] ];
  got = _.strSorterParse( src, fields );
  test.identical( got, expected );

  src = 'a+b>c-d<'
  expected = [ [ 'a+b', 1 ], [ 'c-d', 0 ] ];
  got = _.strSorterParse( src, fields );
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'with fields';
  var fields = { a : 'a', b : 'b' };
  src = 'a>b>c>'
  test.shouldThrowError( () => _.strSorterParse( src, fields ) );

  test.case = 'src must be str, fields must be objectLike';
  src = 'a>b';
  fields = [];
  test.shouldThrowError( () => _.strSorterParse( src, fields ) );
}

// --
//
// --

function strMetricFormat( test )
{

  test.case = 'default options';
  var got = _.strMetricFormat( '100m', {} );
  var expected = '100.0 ';
  test.identical( got,expected );

  test.case = 'default options';
  var got = _.strMetricFormat( 0.005 );
  var expected = '5.0 m';
  test.identical( got,expected );

  test.case = 'number to million';
  var got = _.strMetricFormat( 1, { metric : 6 } );
  var expected = '1.0 M';
  test.identical( got,expected );

  test.case = 'metric out of range';
  var got = _.strMetricFormat( 1, { metric : 25 } );
  var expected = '1.0 ';
  test.identical( got,expected );

  test.case = 'fixed : 0';
  var got = _.strMetricFormat( '1300', { fixed : 0 } );
  var expected = '1 k';
  test.identical( got,expected );

  test.case = 'divisor, thousand test';
  var got = _.strMetricFormat( '1000000',{ divisor : 2, thousand:100 } );
  var expected = '1.0 M';
  test.identical( got,expected );

  test.case = 'divisor, thousand,dimensions,metric test';
  var got = _.strMetricFormat( '10000', { divisor : 2, thousand : 10, dimensions : 3,metric: 1 } );
  var expected = '10.0 k'
  test.identical( got,expected );

  test.case = 'divisor, thousand,dimensions test';
  var got = _.strMetricFormat( '10000', { divisor : 2, thousand : 10, dimensions : 3 } );
  var expected = '10.0 h';
  test.identical( got,expected );

  test.case = 'divisor, thousand,dimensions,fixed test';
  var got = _.strMetricFormat( '10000', { divisor : 2, thousand : 10, dimensions : 3, fixed : 0 } );
  var expected = '10 h';
  test.identical( got,expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strMetricFormat( '1', { fixed : 0 }, '3' );
  });

  test.case = 'invalid first argument type';
  test.shouldThrowError( function()
  {
    _.strMetricFormat( [ 1, 2, 3 ] );
  });

  test.case = 'invalid second argument type';
  test.shouldThrowError( function()
  {
    _.strMetricFormat( 11, '0' );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strMetricFormat();
  });

  test.case = 'fixed out of range';
  test.shouldThrowError( function()
  {
    _.strMetricFormat( '1300', { fixed : 21 } );
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( () => _.strMetricFormat() );

  test.case = 'too many arguments';
  test.shouldThrowError( () => _.strMetricFormat( 1,1 ) );

  test.case = 'bad arguments';
  test.shouldThrowError( () => _.strMetricFormat( null ) );

  test.case = 'bad arguments';
  test.shouldThrowError( () => _.strMetricFormat( undefined ) );

  test.case = 'bad arguments';
  test.shouldThrowError( () => _.strMetricFormat( {} ) );

  test.case = 'bad arguments';
  test.shouldThrowError( () => _.strMetricFormat( [] ) );

}

//

function strMetricFormatBytes( test )
{

  test.case = 'zero';
  var got = _.strMetricFormatBytes( 0 );
  var expected = '0.0 b';
  test.identical( got,expected );

  test.case = 'string zero';
  var got = _.strMetricFormatBytes( '0' );
  var expected = '0.0 b';
  test.identical( got,expected );

  test.case = 'string';
  var got = _.strMetricFormatBytes( '1000000' );
  var expected = '976.6 kb';
  test.identical( got,expected );

  test.case = 'default options';
  var got = _.strMetricFormatBytes( 1024 );
  var expected = '1024.0 b';
  test.identical( got,expected );

  test.case = 'default options';
  var got = _.strMetricFormatBytes( 2500 );
  var expected = '2.4 kb';
  test.identical( got,expected );

  test.case = 'fixed';
  var got = _.strMetricFormatBytes( 2500, { fixed : 0 } );
  var expected = '2 kb';
  test.identical( got,expected );

  test.case = 'invalid metric value';
  var got = _.strMetricFormatBytes( 2500 , { metric:4 } );
  var expected = '2500.0 b';
  test.identical( got,expected );

  test.case = 'divisor test';
  var got = _.strMetricFormatBytes( Math.pow(2,32) , { divisor:4, thousand: 1024 } );
  var expected = '4.0 Tb';
  test.identical( got,expected );


  /**/

  if( !Config.debug )
  return;

  test.case = 'invalid first argument type';
  test.shouldThrowError( function()
  {
    _.strMetricFormatBytes( [ '1', '2', '3' ] );
  });

  test.case = 'invalid second argument type';
  test.shouldThrowError( function()
  {
    _.strMetricFormatBytes( 0, '0' );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strMetricFormatBytes();
  });

  test.case = 'fixed out of range';
  test.shouldThrowError( function()
  {
    _.strMetricFormatBytes( '1300', { fixed : 22 } );
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( () => _.strMetricFormatBytes() );

  test.case = 'too many arguments';
  test.shouldThrowError( () => _.strMetricFormatBytes( 1,1 ) );

  test.case = 'bad arguments';
  test.shouldThrowError( () => _.strMetricFormatBytes( null ) );

  test.case = 'bad arguments';
  test.shouldThrowError( () => _.strMetricFormatBytes( undefined ) );

  test.case = 'bad arguments';
  test.shouldThrowError( () => _.strMetricFormatBytes( {} ) );

  test.case = 'bad arguments';
  test.shouldThrowError( () => _.strMetricFormatBytes( [] ) );

}

//

function strToBytes( test )
{

  test.case = 'simple string';
  var got = _.strToBytes( 'abcd' );
  var expected = new Uint8Array ( [ 97, 98, 99, 100 ] );
  test.identical( got,expected );

  test.case = 'escaping';
  var got = _.strToBytes( '\u001bABC\n\t' );
  var expected = new Uint8Array ( [ 27, 65, 66, 67, 10, 9 ] );
  test.identical( got,expected );

  test.case = 'zero length';
  var got = _.strToBytes( '' );
  var expected = new Uint8Array ( [ ] );
  test.identical( got,expected );

  test.case = 'returns the typed-array';
  var got = _.strToBytes( 'abc' );
  var expected = got;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strToBytes( '1', '2' );
  });

  test.case = 'invalid argument type';
  test.shouldThrowError( function()
  {
    _.strToBytes( 0 );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strToBytes();
  });

  test.case = 'argument is wrong';
  test.shouldThrowError( function( )
  {
    _.strToBytes( [  ] );
  } );

  test.case = 'argument is wrong';
  test.shouldThrowError( function( )
  {
    _.strToBytes( 13 );
  } );

  test.case = 'not enough arguments';
  test.shouldThrowError( () => _.strToBytes() );

  test.case = 'too many arguments';
  test.shouldThrowError( () => _.strToBytes( 1,1 ) );

  test.case = 'bad arguments';
  test.shouldThrowError( () => _.strToBytes( null ) );

  test.case = 'bad arguments';
  test.shouldThrowError( () => _.strToBytes( undefined ) );

  test.case = 'bad arguments';
  test.shouldThrowError( () => _.strToBytes( {} ) );

  test.case = 'bad arguments';
  test.shouldThrowError( () => _.strToBytes( [] ) );

}

//

function strTimeFormat( test )
{

  test.case = 'simple number';
  var got = _.strTimeFormat( 0 );
  var expected = '0.000 s';
  test.identical( got,expected );

  test.case = 'simple number';
  var got = _.strTimeFormat( 1000 );
  var expected = '1.000 s';
  test.identical( got,expected );

  test.case = 'simple number';
  var got = _.strTimeFormat( 1 );
  var expected = '1.000 ms';
  test.identical( got,expected );

  test.case = 'big number';
  var got = _.strTimeFormat( Math.pow( 4,7 ) );
  var expected = '16.384 s';
  test.identical( got,expected );

  test.case = 'very big number';
  var got = _.strTimeFormat( Math.pow( 13,13 ) );
  var expected = '302.875 Gs';
  test.identical( got,expected );

  // test.case = 'zero';
  // var got = _.strTimeFormat( 0 );
  // var expected = '0.000 ys';
  // test.identical( got,expected );

  test.case = 'from date';
  var d = new Date( 1,2,3 )
  var got = _.strTimeFormat( d );
  var expected = '-2.172 Gs';
  test.identical( got,expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'not enough arguments';
  test.shouldThrowError( () => _.strTimeFormat() );

  test.case = 'too many arguments';
  test.shouldThrowError( () => _.strTimeFormat( 1,1 ) );

  test.case = 'bad arguments';
  test.shouldThrowError( () => _.strTimeFormat( null ) );

  test.case = 'bad arguments';
  test.shouldThrowError( () => _.strTimeFormat( undefined ) );

  test.case = 'bad arguments';
  test.shouldThrowError( () => _.strTimeFormat( {} ) );

  test.case = 'bad arguments';
  test.shouldThrowError( () => _.strTimeFormat( [] ) );

  test.case = 'bad arguments';
  test.shouldThrowError( () => _.strTimeFormat( '24:00' ) );

}

//

function strDifference( test )
{

  test.case = 'returns the string';
  var got = _.strDifference( 'abc', 'abd' );
  var expected = 'ab*';
  test.identical( got, expected );

  test.case = 'returns the string where the difference in the first letter';
  var got = _.strDifference( 'abc', 'def' );
  var expected = '*';
  test.identical( got, expected );

  test.case = 'returns false because arguments are equal';
  var got = _.strDifference( 'abc', 'abc' );
  var expected = false;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function( )
  {
    _.strDifference( );
  } );

  test.case = 'first argument is wrong';
  test.shouldThrowError( function( )
  {
    _.strDifference( [  ], 'abc' );
  } );

  test.case = 'second argument is wrong';
  test.shouldThrowError( function( )
  {
    _.strDifference( 'abc', 13 );
  } );

  test.case = 'not enough arguments';
  test.shouldThrowError( function( )
  {
    _.strDifference( 'abc' );
  } );

}

//

function strLattersSpectre( test )
{

  test.case = 'returns the object';
  var got = _.strLattersSpectre( 'abcacc' );
  var expected = new U32x([ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6 ]);
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function( )
  {
    _.strLattersSpectre( );
  } );

};

// --
//
// --

var Self =
{

  name : 'Tools/base/StringsExtra',
  silencing : 1,
  enabled : 1, //

  tests :
  {

    strCamelize : strCamelize,
    strToTitle : strToTitle,

    strFilenameFor : strFilenameFor,
    strHtmlEscape : strHtmlEscape,

    //

    strFindAll : strFindAll,
    strReplaceAll : strReplaceAll,
    strTokenizeJs : strTokenizeJs,
    strSorterParse : strSorterParse,

    //

    strMetricFormat : strMetricFormat,
    strMetricFormatBytes : strMetricFormatBytes,
    strToBytes : strToBytes,
    strTimeFormat : strTimeFormat,

    //

    strDifference : strDifference,
    strLattersSpectre : strLattersSpectre,

  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

})();
