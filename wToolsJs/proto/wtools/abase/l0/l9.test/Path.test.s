( function _l0_l9_Path_test_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( 'Tools' );
  _.include( 'wTesting' );
}

const _global = _global_;
const _ = _global_.wTools;

// --
// tests
// --

function escape( test )
{

  test.case = `"a`;
  var src = `"a`;
  var dst = `""a`
  var got1 = _.path.escape( src );
  test.identical( got1, dst );
  var got2 = _.path._unescape( got1 );
  var exp =
  {
    wasEscaped : false,
    unescaped : src,
  }
  var got2 = _.path._unescape( got1 );
  test.identical( got2, exp );
  var got3 = _.path.unescape( got1 );
  test.identical( got3, src );

  test.case = `"#`;
  var src = `"#`;
  var dst = `"""#"`
  var got1 = _.path.escape( src );
  test.identical( got1, dst );
  var exp =
  {
    wasEscaped : true,
    unescaped : src,
  }
  var got2 = _.path._unescape( got1 );
  test.identical( got2, exp );
  var got3 = _.path.unescape( got1 );
  test.identical( got3, src );

  test.case = `"!`;
  var src = `"!`;
  var dst = `"""!"`
  var got1 = _.path.escape( src );
  test.identical( got1, dst );
  var got2 = _.path._unescape( got1 );
  var exp =
  {
    wasEscaped : true,
    unescaped : src,
  }
  var got2 = _.path._unescape( got1 );
  test.identical( got2, exp );
  var got3 = _.path.unescape( got1 );
  test.identical( got3, src );

  test.case = `a"`;
  var src = `a"`;
  var dst = `a""`
  var got1 = _.path.escape( src );
  test.identical( got1, dst );
  var exp =
  {
    wasEscaped : false,
    unescaped : src,
  }
  var got2 = _.path._unescape( got1 );
  test.identical( got2, exp );
  var got3 = _.path.unescape( got1 );
  test.identical( got3, src );

  test.case = `#"`;
  var src = `#"`;
  var dst = `"#"""`
  var got1 = _.path.escape( src );
  test.identical( got1, dst );
  var exp =
  {
    wasEscaped : true,
    unescaped : src,
  }
  var got2 = _.path._unescape( got1 );
  test.identical( got2, exp );
  var got3 = _.path.unescape( got1 );
  test.identical( got3, src );

  test.case = `!"`;
  var src = `!"`;
  var dst = `"!"""`
  var got1 = _.path.escape( src );
  test.identical( got1, dst );
  var exp =
  {
    wasEscaped : true,
    unescaped : src,
  }
  var got2 = _.path._unescape( got1 );
  test.identical( got2, exp );
  var got3 = _.path.unescape( got1 );
  test.identical( got3, src );

  test.case = `"a"`;
  var src = `"a"`;
  var dst = `""a""`
  var got1 = _.path.escape( src );
  test.identical( got1, dst );
  var exp =
  {
    wasEscaped : false,
    unescaped : src,
  }
  var got2 = _.path._unescape( got1 );
  test.identical( got2, exp );
  var got3 = _.path.unescape( got1 );
  test.identical( got3, src );

  test.case = `"#"`;
  var src = `"#"`;
  var dst = `"""#"""`
  var got1 = _.path.escape( src );
  test.identical( got1, dst );
  var exp =
  {
    wasEscaped : true,
    unescaped : src,
  }
  var got2 = _.path._unescape( got1 );
  test.identical( got2, exp );
  var got3 = _.path.unescape( got1 );
  test.identical( got3, src );

  test.case = `"!"`;
  var src = `"!"`;
  var dst = `"""!"""`
  var got1 = _.path.escape( src );
  test.identical( got1, dst );
  var exp =
  {
    wasEscaped : true,
    unescaped : src,
  }
  var got2 = _.path._unescape( got1 );
  test.identical( got2, exp );
  var got3 = _.path.unescape( got1 );
  test.identical( got3, src );

  test.case = `""a""`;
  var src = `""a""`;
  var dst = `""""a""""`
  var got1 = _.path.escape( src );
  test.identical( got1, dst );
  var exp =
  {
    wasEscaped : false,
    unescaped : src,
  }
  var got2 = _.path._unescape( got1 );
  test.identical( got2, exp );
  var got3 = _.path.unescape( got1 );
  test.identical( got3, src );

  test.case = `""#""`;
  var src = `""#""`;
  var dst = `"""""#"""""`
  var got1 = _.path.escape( src );
  test.identical( got1, dst );
  var exp =
  {
    wasEscaped : true,
    unescaped : src,
  }
  var got2 = _.path._unescape( got1 );
  test.identical( got2, exp );
  var got3 = _.path.unescape( got1 );
  test.identical( got3, src );

  test.case = `""!""`;
  var src = `""!""`;
  var dst = `"""""!"""""`
  var got1 = _.path.escape( src );
  test.identical( got1, dst );
  var exp =
  {
    wasEscaped : true,
    unescaped : src,
  }
  var got2 = _.path._unescape( got1 );
  test.identical( got2, exp );
  var got3 = _.path.unescape( got1 );
  test.identical( got3, src );

  test.case = 'a1#/a2@/a3!/a4?/#a5/@a6/!a7/?a8/File1.txt';
  var src = 'a1#/a2@/a3!/a4?/#a5/@a6/!a7/?a8/File1.txt';
  var dst = `"a1#"/"a2@"/"a3!"/"a4?"/"#a5"/"@a6"/"!a7"/"?a8"/File1.txt`;
  var got1 = _.path.escape( src );
  test.identical( got1, dst );
  var exp =
  {
    wasEscaped : true,
    unescaped : src,
  }
  var got2 = _.path._unescape( got1 );
  test.identical( got2, exp );
  var got3 = _.path.unescape( got1 );
  test.identical( got3, src );

}

// --
// declare
// --

const Proto =
{

  name : 'Tools.path.Fundamental.l0.l9',
  silencing : 1,

  tests :
  {

    escape,

  },

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
