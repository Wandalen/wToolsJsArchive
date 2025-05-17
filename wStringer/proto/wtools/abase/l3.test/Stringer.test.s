( function _Stringer_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../node_modules/Tools' );

  _.include( 'wTesting' );
  require( '../l3/Stringer.s' );

}

const _ = _global_.wTools;
const __ = _globals_.testing.wTools;
const fileProvider = __.fileProvider;
const path = fileProvider.path;

// --
// context
// --

/*

\' 	single quote 	byte 0x27 in ASCII encoding
\" 	double quote 	byte 0x22 in ASCII encoding
\\ 	backslash 	byte 0x5c in ASCII encoding
\b 	backspace 	byte 0x08 in ASCII encoding
\f 	form feed - new page 	byte 0x0c in ASCII encoding
\n 	line feed - new line 	byte 0x0a in ASCII encoding
\r 	carriage return 	byte 0x0d in ASCII encoding
\t 	horizontal tab 	byte 0x09 in ASCII encoding
\v 	vertical tab 	byte 0x0b in ASCII encoding
\nnn 	arbitrary octal value 	byte nnn
\xnn 	arbitrary hexadecimal value 	byte nn
\unnnn 	universal character name
( arbitrary Unicode value );
may result in several characters 	code point U+nnnn
\Unnnnnnnn 	universal character name
( arbitrary Unicode value );
may result in several characters 	code point U+nnnnnnnn

source : http://en.cppreference.com/w/cpp/language/escape

*/

//

function reportChars( )
{

  var r = '';
  for( var i = 0 ; i < 512 ; i++ )
  {
    var d = _.strDup( '0', 4-i.toString( 16 ).length ) + i.toString( 16 );
    var u = eval( `"\\u${d}"` );
    r += `${d} : "${u}"\n`;
  }

  console.log( r );

}

/*reportChars( );*/

// //
//
// function stringFromFile( name, encoding, begin, end )
// {
//   var str = fileProvider.fileRead( { filePath : __dirname + '/../../../../asset/test/' + name, encoding } );
//   str = str.slice( begin, end );
//   return str;
// }

//

//function testFunction( test, desc, src, options, expected )
//{
//
//  var got = null;
//  var result = null;
//  var exp = null;
//
//  for( var k = 0; k < src.length; ++k  )
//  {
//    test.case = desc ;
//    var optionsTest = options[ k ] || options[ 0 ];
//    got = _.entity.exportString( src[ k ], optionsTest );
//
//    if( test.case.slice( 0, 4 ) === 'json' && optionsTest.jsonLike )
//    {
//
//      try
//      {
//        result = JSON.parse( got );
//        test.identical( result, src[ k ] );
//      }
//      catch( err )
//      {
//        logger.log( 'JSON :' );
//        logger.log( got );
//        throw _.err( err );
//      }
//
//    }
//    else
//    {
//      test.identical( got, expected[ k ] );
//    }
//
//  }
//
//}

// --
// tests
// --

function exportString( test )
{

  test.case = 'in - boolean';
  var got = _.entity.exportString( false, {} );
  test.identical( got, 'false' );

  test.case = 'in - number';
  var got = _.entity.exportString( 13, {} );
  test.identical( got, '13' );

  test.case = 'in - number, levels - 2';
  var got = _.entity.exportString( 0, { levels : 2 } );
  test.identical( got, '0' );

  test.case = 'in - Date, levels - 2';
  var got = _.entity.exportString( new Date( Date.UTC( 2020, 0, 13 ) ), { levels : 2 } );
  test.identical( got, '2020-01-13T00:00:00.000Z' );

  test.case = 'in - string, level - 2';
  var got = _.entity.exportString( 'text', { levels : 2 } );
  test.identical( got, '\'text\'' );

  test.case = 'in - empty array, levels - 2';
  var got = _.entity.exportString( [], { levels : 2 } );
  test.identical( got, '[]' );

  test.case = 'in - array with empty maps, levels - 2';
  var got = _.entity.exportString( [ {}, {}, {} ], { levels : 2 } );
  test.identical( got, '[ {}, {}, {} ]' );

  test.case = 'in - array with numbers, levels - 2';
  var got = _.entity.exportString( [ 1, 2, 3, 4 ], { levels : 2 } );
  test.identical( got, '[ 1, 2, 3, 4 ]' );

  test.case = 'in - empty map, levels - 2';
  var got = _.entity.exportString( {}, { levels : 2 } );
  test.identical( got, '{}' );

  test.case = 'in - filled map, levels - 2';
  var got = _.entity.exportString( { a : {}, b : {} }, { levels : 2 } );
  test.identical( got, '{ a : {}, b : {} }' );

  test.case = 'in - filled map with strings values, levels - 2';
  var got = _.entity.exportString( { 1 : 'a', 2: 'b', 3: 'c' }, { levels : 2 } );
  test.identical( got, '{ 1 : \'a\', 2 : \'b\', 3 : \'c\' }' );

  /* */

  test.case = 'str';
  var src = 'abc';
  var got = _.entity.exportString( src, { levels : 2 } );
  var exp = '\'abc\'';
  test.identical( got, exp );

  /* */

  test.case = 'str in map';
  var src = { 'a' : 'b' };
  var got = _.entity.exportString( src, { levels : 2 } );
  var exp =
  [
    '{ a : \'b\' }',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'str in map in map';
  var src = { 'a' : { 'b' : 'c' } };
  var got = _.entity.exportString( src, { levels : 2 } );
  var exp =
  [
    '{',
    '  a : { b : \'c\' }',
    '}',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled map, complex values, levels - 2';
  var src = { 1 : 'a', 2 : [ 10, 20, 30 ], 3 : { 21 : 'aa', 22 : 'bb' } };
  var got = _.entity.exportString( src, { levels : 2 } );
  var exp =
  [
    '{',
    '  1 : \'a\', ',
    '  2 : [ 10, 20, 30 ], ',
    '  3 : { 21 : \'aa\', 22 : \'bb\' }',
    '}',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled map, complex values, levels - 2';
  var src =
  {
    1 : 'a',
    2 : [ 10, 20, 30 ],
    3 : { 21 : 'aa', 22 : 'bb' },
    4 : [ 10, 20, 30 ],
    5 : [ 10, 20, 30 ],
  };
  var got = _.entity.exportString( src, { levels : 2 } );
  var exp =
  [
    '{',
    '  1 : \'a\', ',
    '  2 : [ 10, 20, 30 ], ',
    '  3 : { 21 : \'aa\', 22 : \'bb\' }, ',
    '  4 : [ 10, 20, 30 ], ',
    '  5 : [ 10, 20, 30 ]',
    '}',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled map, complex values, levels - 2';
  var src =
  {
    1 : 'a',
    2 : [ 10, 20, 30 ],
    3 : { 21 : 'aa', 22 : 'bb' },
    4 : [ 10, 20, 30 ],
    5 : [ 10, 20, 30 ],
  };
  var got = _.entity.exportString( src, { levels : 2 } );
  var exp =
  [
    '{',
    '  1 : \'a\', ',
    '  2 : [ 10, 20, 30 ], ',
    '  3 : { 21 : \'aa\', 22 : \'bb\' }, ',
    '  4 : [ 10, 20, 30 ], ',
    '  5 : [ 10, 20, 30 ]',
    '}',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled array, complex values, levels - 2';
  var src =
  [
    'a',
    [ 10, 20, 30 ],
    { 21 : 'aa', 22 : 'bb' },
    { 31 : '111', 32 : '222' },
    [ 10, 20, 30 ],
    [ 10, 20, 30 ],
  ];
  var got = _.entity.exportString( src, { levels : 2 } );
  var exp =
  [
    '[',
    '  \'a\', ',
    '  [ 10, 20, 30 ], ',
    '  { 21 : \'aa\', 22 : \'bb\' }, ',
    '  { 31 : \'111\', 32 : \'222\' }, ',
    '  [ 10, 20, 30 ], ',
    '  [ 10, 20, 30 ]',
    ']',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled array, complex values, levels - 3';
  var src =
  [
    'a',
    [ 10, 20, 30 ],
    {
      21 : [ 1, 2, 3 ],
      22 : [ 1, 2, 3, 4 ],
    },
    {
      31 : { a : 'a', b : 'b' },
      32 : { a : 'a', b : 'b', c : 'c' }
    },
    [
      [ 1, 2, 3 ],
      [ 1, 2, 3, 4 ]
    ],
    [
      { a : 'a', b : 'b' },
      { a : 'a', b : 'b', c : 'c' }
    ],
  ];
  var got = _.entity.exportString( src, { levels : 3 } );
  var exp =
  [
    '[',
    '  \'a\', ',
    '  [ 10, 20, 30 ], ',
    '  {',
    '    21 : [ 1, 2, 3 ], ',
    '    22 : [ 1, 2, 3, 4 ]',
    '  }, ',
    '  {',
    '    31 : { a : \'a\', b : \'b\' }, ',
    '    32 : { a : \'a\', b : \'b\', c : \'c\' }',
    '  }, ',
    '  [',
    '    [ 1, 2, 3 ], ',
    '    [ 1, 2, 3, 4 ]',
    '  ], ',
    '  [',
    '    { a : \'a\', b : \'b\' }, ',
    '    { a : \'a\', b : \'b\', c : \'c\' }',
    '  ]',
    ']',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled array, complex values, a few levels of nesting, levels - 5';
  var src =
  [
    'a',
    [ 10, 20, 30 ],
    {
      21 : [ 1, 2, 3 ],
      22 : [ 1, 2, 3, 4 ],
    },
    {
      31 :
      {
        a : { a : 'a', b : 'b' },
        b : { a : 'a', b : 'b' }
      },
      32 :
      {
        a : 'a',
        b : 'b',
        c : { a : 'a', b : 'b' },
      }
    },
    [
      [
        [ 100, 200 ],
        [ 100, 200 ]
      ],
      [ 1, 2, 3, 4 ]
    ],
    [
      { a : 'a', b : 'b' },
      {
        a : 'a',
        b : 'b',
        c : { a : 'a', b : 'b' }
      }
    ],
  ];
  var got = _.entity.exportString( src, { levels : 5 } );
  var exp =
  [
    '[',
    '  \'a\', ',
    '  [ 10, 20, 30 ], ',
    '  {',
    '    21 : [ 1, 2, 3 ], ',
    '    22 : [ 1, 2, 3, 4 ]',
    '  }, ',
    '  {',
    '    31 : ',
    '    {',
    '      a : { a : \'a\', b : \'b\' }, ',
    '      b : { a : \'a\', b : \'b\' }',
    '    }, ',
    '    32 : ',
    '    {',
    '      a : \'a\', ',
    '      b : \'b\', ',
    '      c : { a : \'a\', b : \'b\' }',
    '    }',
    '  }, ',
    '  [',
    '    [',
    '      [ 100, 200 ], ',
    '      [ 100, 200 ]',
    '    ], ',
    '    [ 1, 2, 3, 4 ]',
    '  ], ',
    '  [',
    '    { a : \'a\', b : \'b\' }, ',
    '    {',
    '      a : \'a\', ',
    '      b : \'b\', ',
    '      c : { a : \'a\', b : \'b\' }',
    '    }',
    '  ]',
    ']',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled array, complex values, levels - 1';
  var src =
  [
    'a',
    [ 10, 20, 30 ],
    { 21 : 'aa', 22 : 'bb' },
    { 31 : '111', 32 : '222' },
    [ 10, 20, 30 ],
    [ 10, 20, 30 ],
  ];
  var got = _.entity.exportString( src, { levels : 1 } );
  var exp =
  [
    '[',
    '  \'a\', ',
    '  {- Array with 3 elements -}, ',
    '  {- Map.polluted with 2 elements -}, ',
    '  {- Map.polluted with 2 elements -}, ',
    '  {- Array with 3 elements -}, ',
    '  {- Array with 3 elements -}',
    ']',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled array, complex values, 3 levels of nesting, levels - 2';
  var src =
  [
    'a',
    [ 10, 20, 30 ],
    {
      21 : [ 1, 2, 3 ],
      22 : [ 1, 2, 3, 4 ],
    },
    {
      31 : { a : 'a', b : 'b' },
      32 : { a : 'a', b : 'b', c : 'c' }
    },
    [
      [ 1, 2, 3 ],
      [ 1, 2, 3, 4 ]
    ],
    [
      { a : 'a', b : 'b' },
      { a : 'a', b : 'b', c : 'c' }
    ],
  ];
  var got = _.entity.exportString( src, { levels : 2 } );
  var exp =
  [
    '[',
    '  \'a\', ',
    '  [ 10, 20, 30 ], ',
    '  {',
    '    21 : {- Array with 3 elements -}, ',
    '    22 : {- Array with 4 elements -}',
    '  }, ',
    '  {',
    '    31 : {- Map.polluted with 2 elements -}, ',
    '    32 : {- Map.polluted with 3 elements -}',
    '  }, ',
    '  [',
    '    {- Array with 3 elements -}, ',
    '    {- Array with 4 elements -}',
    '  ], ',
    '  [',
    '    {- Map.polluted with 2 elements -}, ',
    '    {- Map.polluted with 3 elements -}',
    '  ]',
    ']',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled map, complex values, levels - 2, tab - "-", dtab - "+"';
  var src =
  {
    1 : 'a',
    2 : [ 10, 20, 30 ],
    3 : { 21 : 'aa', 22 : 'bb' },
    4 : [ 10, 20, 30 ],
    13 : [ 10, 20, 30 ],
  };
  var got = _.entity.exportString( src, { levels : 2, tab : '---', dtab : '+' } );
  var exp =
  [
    '---{',
    '---+1 : \'a\', ',
    '---+2 : [ 10, 20, 30 ], ',
    '---+3 : { 21 : \'aa\', 22 : \'bb\' }, ',
    '---+4 : [ 10, 20, 30 ], ',
    '---+13 : [ 10, 20, 30 ]',
    '---}',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled map, complex values, levels - 2, wrap - 0, tab - "-", prependTab - 0';
  var src =
  {
    1 : 'a',
    2 : [ 10, 20, 30 ],
    3 : { 21 : 'aa', 22 : 'bb' },
    4 : [ 10, 20, 30 ],
    13 : [ 10, 20, 30 ],
  };
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, tab : '-', prependTab : 0 } );
  var exp =
  [
    '  1 : \'a\' ',
    '-  2 :   10 20 30 ',
    '-  3 : 21 : \'aa\' 22 : \'bb\' ',
    '-  4 :   10 20 30 ',
    '-  13 :   10 20 30',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled map, complex values, levels - 2, wrap - 0, tab - "-", prependTab - 1';
  var src =
  {
    1 : 'a',
    2 : [ 10, 20, 30 ],
    3 : { 21 : 'aa', 22 : 'bb' },
    4 : [ 10, 20, 30 ],
    13 : [ 10, 20, 30 ],
  };
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, tab : '-', prependTab : 1 } );
  var exp =
  [
    '-  1 : \'a\' ',
    '-  2 :   10 20 30 ',
    '-  3 : 21 : \'aa\' 22 : \'bb\' ',
    '-  4 :   10 20 30 ',
    '-  13 :   10 20 30',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled map, complex values, levels - 2, wrap - 1, tab - "-", prependTab - 0';
  var src =
  {
    1 : 'a',
    2 : [ 10, 20, 30 ],
    3 : { 21 : 'aa', 22 : 'bb' },
    4 : [ 10, 20, 30 ],
    5 : [ 10, 20, 30 ],
  };
  var got = _.entity.exportString( src, { levels : 2, wrap : 1, tab : '-', prependTab : 0 } );
  var exp =
  [
    '{',
    '-  1 : \'a\', ',
    '-  2 : [ 10, 20, 30 ], ',
    '-  3 : { 21 : \'aa\', 22 : \'bb\' }, ',
    '-  4 : [ 10, 20, 30 ], ',
    '-  5 : [ 10, 20, 30 ]',
    '-}',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled map, complex values, levels - 2, wrap - 1, tab - "-", prependTab - 1';
  var src =
  {
    1 : 'a',
    2 : [ 10, 20, 30 ],
    3 : { 21 : 'aa', 22 : 'bb' },
    4 : [ 10, 20, 30 ],
    5 : [ 10, 20, 30 ],
  };
  var got = _.entity.exportString( src, { levels : 2, wrap : 1, tab : '-', prependTab : 1 } );
  var exp =
  [
    '-{',
    '-  1 : \'a\', ',
    '-  2 : [ 10, 20, 30 ], ',
    '-  3 : { 21 : \'aa\', 22 : \'bb\' }, ',
    '-  4 : [ 10, 20, 30 ], ',
    '-  5 : [ 10, 20, 30 ]',
    '-}',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled map, complex values, levels - 2, noSubObject - 1, noArray - 1, dtab - "  "';
  var src =
  {
    1 : [ 1, 2, 3 ],
    2 : 'abc',
    3 : 4,
  };
  var got = _.entity.exportString( src, { levels : 2, noSubObject : 1, noArray : 1, dtab : '  ' } );
  var exp =
  [
    '{',
    '  2 : \'abc\', ',
    '  3 : 4',
    '}',
  ].join( '\n' );
  test.identical( got, exp );
}

// --
// str unwrapped
// --

function exportStringUnwrapped( test )
{
  //var desc = 'Error test',
  //src =
  //  [
  //
  //    /*01*/
  //    [
  //      [
  //        'abc',
  //        'edf',
  //        { a : 1 },
  //      ],
  //    ],
  //
  //    /*02*/
  //    [
  //      {
  //        nameLong : 'abc',
  //        description : 'edf',
  //        rewardForVisitor : { a : 1 },
  //      },
  //    ],
  //
  //    /*03*/
  //    {
  //      a :
  //      {
  //        nameLong : 'abc',
  //        description : 'edf',
  //        rewardForVisitor : { a : 1 },
  //      },
  //    },
  //
  //    /*04*/
  //    {
  //      a :
  //      [
  //        'abc',
  //        'edf',
  //        { a : 1 },
  //      ],
  //    },
  //
  //    /*05*/
  //    [
  //      [
  //        'abc',
  //        'edf',
  //        { a : 1 },
  //      ],
  //      1,
  //      2,
  //    ],
  //
  //    /*06*/
  //    [ 'a', 7, [ 1 ], 8, 'b' ],
  //
  //    /*07*/
  //    [ 'a', 7, { u : 1 }, 8, 'b' ],
  //
  //    /*08*/
  //    [ [ 5, 4 ], [ 2, 1, 0 ] ],
  //
  //    /*09*/
  //    [ [ 5, 4, [ 3 ] ], [ 2, 1, 0 ] ],
  //
  //    /*10*/
  //    ( function( )
  //    {
  //      var structure =
  //      [
  //        {
  //          nameLong : 'abc',
  //          description : 'edf',
  //          rewardForVisitor : { a : 1 },
  //          stationary : 1,
  //          f : 'f',
  //          quantity : 1
  //        },
  //        {
  //          nameLong : 'abc2',
  //          description : 'edf2',
  //          rewardForVisitor : { a : 1 },
  //          stationary : 1,
  //          f : 'f',
  //          quantity : 1
  //        },
  //      ];
  //      return structure;
  //    } )( ),
  //
  //    /*11*/
  //    {
  //      1 : 'a',
  //      2 : [ 10, 20, 30 ],
  //      3 : { 21 : 'aa', 22 : 'bb' },
  //      4 : [ 10, 20, 30 ],
  //      13 : [ 10, 20, 30 ],
  //    },
  //
  //  ],
  //  options =
  //  [
  //
  //    /*01*/  { wrap : 0, levels : 4 },
  //
  //  ],
  //  expected =
  //  [
  //
  //    /*01*/
  //
  //    [
  //      '    \'abc\' ',
  //      '    \'edf\' ',
  //      '    a : 1',
  //    ].join( '\n' ),
  //
  //    /*02*/
  //
  //    [
  //      '    nameLong : \'abc\' ',
  //      '    description : \'edf\' ',
  //      '    rewardForVisitor : a : 1',
  //    ].join( '\n' ),
  //
  //    /*03*/
  //
  //    [
  //      '  a : ',
  //      '    nameLong : \'abc\' ',
  //      '    description : \'edf\' ',
  //      '    rewardForVisitor : a : 1',
  //    ].join( '\n' ),
  //
  //    /*04*/
  //
  //    [
  //      '  a : ',
  //      '    \'abc\' ',
  //      '    \'edf\' ',
  //      '    a : 1',
  //    ].join( '\n' ),
  //
  //    /*05*/
  //
  //    [
  //      '    \'abc\' ',
  //      '    \'edf\' ',
  //      '    a : 1 ',
  //      '  1 ',
  //      '  2',
  //    ].join( '\n' ),
  //
  //    /*06*/
  //
  //    [
  //      '  \'a\' ',
  //      '  7 ',
  //      '    1 ',
  //      '  8 ',
  //      '  \'b\'',
  //    ].join( '\n' ),
  //
  //    /*07*/
  //
  //    [
  //      '  \'a\' ',
  //      '  7 ',
  //      '  u : 1 ',
  //      '  8 ',
  //      '  \'b\'',
  //    ].join( '\n' ),
  //
  //    /*08*/
  //    [
  //      '    5 4 ',
  //      '    2 1 0',
  //    ].join( '\n' ),
  //
  //    /*09*/
  //    [
  //      '    5 ',
  //      '    4 ',
  //      '      3 ',
  //      '    2 1 0',
  //    ].join( '\n' ),
  //
  //    /*10*/
  //    [
  //      '    nameLong : \'abc\' ',
  //      '    description : \'edf\' ',
  //      '    rewardForVisitor : a : 1 ',
  //      '    stationary : 1 ',
  //      '    f : \'f\' ',
  //      '    quantity : 1 ',
  //      '    nameLong : \'abc2\' ',
  //      '    description : \'edf2\' ',
  //      '    rewardForVisitor : a : 1 ',
  //      '    stationary : 1 ',
  //      '    f : \'f\' ',
  //      '    quantity : 1',
  //
  //    ].join( '\n' ),
  //
  //    /*11*/
  //
  //    [
  //      '  1 : \'a\' ',
  //      '  2 :   10 20 30 ',
  //      '  3 : 21 : \'aa\' 22 : \'bb\' ',
  //      '  4 :   10 20 30 ',
  //      '  13 :   10 20 30',
  //    ].join( '\n' ),
  //
  //  ];
  //
  //  testFunction( test, desc, src, options, expected );

  test.case = 'unwrapped array inside an array';
  var src =
  [
    [
      'abc',
      'edf',
      { a : 1 },
    ],
  ];
  var got = _.entity.exportString( src, { wrap : 0, levels : 4 } );
  var expected =
  [
    '    \'abc\' ',
    '    \'edf\' ',
    '    a : 1',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'unwrapped object inside an array';
  var src =
  [
    {
      nameLong : 'abc',
      description : 'edf',
      rewardForVisitor : { a : 1 },
    },
  ];
  var got = _.entity.exportString( src, { wrap : 0, levels : 4 } );
  var expected =
  [
    '    nameLong : \'abc\' ',
    '    description : \'edf\' ',
    '    rewardForVisitor : a : 1',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'unwrapped object inside an array';
  var src =
  {
    a :
    {
      nameLong : 'abc',
      description : 'edf',
      rewardForVisitor : { a : 1 },
    },
  };
  var got = _.entity.exportString( src, { wrap : 0, levels : 4 } );
  var expected =
  [
    '  a : ',
    '    nameLong : \'abc\' ',
    '    description : \'edf\' ',
    '    rewardForVisitor : a : 1',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'unwrapped array inside an object';
  var src =
  {
    a :
    [
      'abc',
      'edf',
      { a : 1 },
    ],
  };
  var got = _.entity.exportString( src, { wrap : 0, levels : 4 } );
  var expected =
  [
    '  a : ',
    '    \'abc\' ',
    '    \'edf\' ',
    '    a : 1',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'unwrapped array inside an array, with other items';
  var src =
  [
    [
      'abc',
      'edf',
      { a : 1 },
    ],
    1,
    2,
  ];
  var got = _.entity.exportString( src, { wrap : 0, levels : 4 } );
  var expected =
  [
    '    \'abc\' ',
    '    \'edf\' ',
    '    a : 1 ',
    '  1 ',
    '  2',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'unwrapped array with single item array';
  var src = [ 'a', 7, [ 1 ], 8, 'b' ];
  var got = _.entity.exportString( src, { wrap : 0, levels : 4 } );
  var expected =
  [
    '  \'a\' ',
    '  7 ',
    '    1 ',
    '  8 ',
    '  \'b\'',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'unwrapped array with single item object';
  var src = [ 'a', 7, { u : 1 }, 8, 'b' ];
  var got = _.entity.exportString( src, { wrap : 0, levels : 4 } );
  var expected =
  [
    '  \'a\' ',
    '  7 ',
    '  u : 1 ',
    '  8 ',
    '  \'b\'',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'unwrapped array of arrays';
  var src = [ [ 5, 4 ], [ 2, 1, 0 ] ];
  var got = _.entity.exportString( src, { wrap : 0, levels : 4 } );
  var expected =
  ['    5 4 ',
  '    2 1 0',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'unwrapped array of arrays, level 2';
  var src = [ [ 5, 4, [ 3 ] ], [ 2, 1, 0 ] ];
  var got = _.entity.exportString( src, { wrap : 0, levels : 4 } );
  var expected =
  [
    '    5 ',
    '    4 ',
    '      3 ',
    '    2 1 0',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'unwrapped function structure';
  var src =
  ( function( )
  {
    var structure =
    [
      {
        nameLong : 'abc',
        description : 'edf',
        rewardForVisitor : { a : 1 },
        stationary : 1,
        f : 'f',
        quantity : 1
      },
      {
        nameLong : 'abc2',
        description : 'edf2',
        rewardForVisitor : { a : 1 },
        stationary : 1,
        f : 'f',
        quantity : 1
      },
    ];
    return structure;
  } )( );
  var got = _.entity.exportString( src, { wrap : 0, levels : 4 } );
  var expected =
  [
    '    nameLong : \'abc\' ',
    '    description : \'edf\' ',
    '    rewardForVisitor : a : 1 ',
    '    stationary : 1 ',
    '    f : \'f\' ',
    '    quantity : 1 ',
    '    nameLong : \'abc2\' ',
    '    description : \'edf2\' ',
    '    rewardForVisitor : a : 1 ',
    '    stationary : 1 ',
    '    f : \'f\' ',
    '    quantity : 1',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'unwrapped object with arrays as properties';
  var src =
  {
    1 : 'a',
    2 : [ 10, 20, 30 ],
    3 : { 21 : 'aa', 22 : 'bb' },
    4 : [ 10, 20, 30 ],
    13 : [ 10, 20, 30 ],
  };
  var got = _.entity.exportString( src, { wrap : 0, levels : 4 } );
  var expected =
  [
    '  1 : \'a\' ',
    '  2 :   10 20 30 ',
    '  3 : 21 : \'aa\' 22 : \'bb\' ',
    '  4 :   10 20 30 ',
    '  13 :   10 20 30',
  ].join( '\n' );
  test.identical( got, expected ) ;

}

//

function exportStringError( test )
{
  //  var desc = 'Error test',
  //  src =
  //  [
  //    /*01*/  new Error( ),
  //    /*02*/  new Error( 'msg' ),
  //    /*03*/  new Error( 'msg2' ),
  //    /*04*/  new Error( 'message' ),
  //    /*06*/  new Error( 'err message' ),
  //    /*07*/  new Error( 'my message' ),
  //    /*10*/  ( function( )
  //              {
  //                var err = new Error( 'my message4' );
  //                err.stack = err.stack.slice( 0, 18 );
  //                return err;
  //              } )( ),
  //
  //    /*11*/  ( function( )
  //              {
  //                var err = new Error( 'my error' );
  //                err.stack = err.stack.slice( 0, 16 );
  //                return err;
  //              } )( ),
  //  ],
  //  options =
  //  [
  //    /*01*/  { },
  //    /*02*/  { },
  //    /*03*/  { levels : 0 },
  //    /*04*/  { noError : 1 },
  //    /*06*/  { errorAsMap : 1, onlyEnumerable : 1 },
  //    /*07*/  { errorAsMap : 1, onlyEnumerable : 1, own : 0 },
  //    /*10*/  { errorAsMap : 1, levels : 2 },
  //    /*11*/  { errorAsMap : 1, levels : 2, escaping : 1 },
  //
  //  ],
  //  expected =
  //  [
  //
  //    /*01*/  'Error',
  //    /*02*/  'Error: msg',
  //    /*03*/  '[object Error]',
  //    /*04*/  '',
  //    /*06*/  '{}',
  //    /*07*/  '{}',
  //
  //    /*10*/
  //      [
  //        '{ stack : \'Error: my message4\', message : \'my message4\' }',
  //      ].join( '\n' ),
  //
  //    /*11*/
  //      [
  //        '{ stack : \'Error: my error\\n\', message : \'my error\' }',
  //      ].join( '\n' ),
  //  ];
  //
  //
  //  testFunction( test, desc, src, options, expected );

  test.case = 'error simple';
  var got = _.entity.exportString( new Error( ), { } );
  var expected = 'Error';
  test.identical( got, expected );

  test.case = 'error with message';
  var got = _.entity.exportString( new Error( 'msg' ), { } );
  var expected = 'Error: msg';
  test.identical( got, expected );

  test.case = 'error with message, levels 0';
  var got = _.entity.exportString( new Error( 'msg2' ), { levels : 0 } );
  var expected = '[object Error]';
  test.identical( got, expected );

  test.case = 'error, noError';
  var got = _.entity.exportString( new Error( 'message' ), { noError : 1 } );
  var expected = '';
  test.identical( got, expected );

  test.case = 'map-error, onlyEnumerable';
  var got = _.entity.exportString( new Error( 'err message' ), { errorAsMap : 1, onlyEnumerable : 1 } );
  // var expected = `{ stack : 'Error: err message.../timers.js:475:7)', message : 'err message' }`;
  // test.identical( got, expected );
  var expected = /\{ stack : \'Error: err message\.\.\.\w*\/{0,1}timers(\.js){0,1}:\d+:\d+\)\', message : \'err message\' \}/;
  test.true( _.strHas( got, expected ) );

  test.case = 'map-error, onlyEnumerable own:0';
  var got = _.entity.exportString( new Error( 'my message' ), { errorAsMap : 1, onlyEnumerable : 1, onlyOwn : 0 } );
  var fileWithLineCol = got.match( /\.\.\.\w*\/{0,1}timers(\.js){0,1}:(\d+:\d+)/ )[ 0 ];
  var expected =
`{
  stack : 'Error: my message\\${ fileWithLineCol })',\u0020
  message : 'my message',\u0020
  constructor : [ routine Error ],\u0020
  name : 'Error',\u0020`;
  test.true( _.str.has( got, expected ) );
  var expected =
`  toString : [ routine toString ],\u0020
  __defineGetter__ : [ routine __defineGetter__ ],\u0020
  __defineSetter__ : [ routine __defineSetter__ ],\u0020
  hasOwnProperty : [ routine hasOwnProperty ],\u0020
  __lookupGetter__ : [ routine __lookupGetter__ ],\u0020
  __lookupSetter__ : [ routine __lookupSetter__ ],\u0020
  isPrototypeOf : [ routine isPrototypeOf ],\u0020
  propertyIsEnumerable : [ routine propertyIsEnumerable ],\u0020
  valueOf : [ routine valueOf ],\u0020
  __proto__ : {- Map.polluted with 0 elements -},\u0020
  toLocaleString : [ routine toLocaleString ]
}`;
  test.true( _.str.has( got, expected ) );

  test.case = 'map-error stack';
  var src =
  ( function( )
  {
    var err = new Error( 'my message4' );
    err.stack = err.stack.slice( 0, 18 );
    return err;
  } )( );
  var got = _.entity.exportString( src, { errorAsMap : 1, levels : 2 } );
  var expected = '{ stack : \'Error: my message4\', message : \'my message4\' }';
  test.identical( got, expected );

  test.case = 'map-error stack, escaping';
  var src =
  ( function( )
  {
    var err = new Error( 'my error' );
    err.stack = err.stack.slice( 0, 16 );
    return err;
  } )( );
  var got = _.entity.exportString( src, { errorAsMap : 1, levels : 2, escaping : 1 } );
  var expected = '{ stack : \'Error: my error\\n\', message : \'my error\' }';
  test.identical( got, expected );

}

//

function exportStringArray( test )
{
  //  var  desc = 'Array test',
  //  src =
  //  [
  //    /*01*/ [ 1, 2, 3 ],
  //    /*02*/ [ { a : 1 }, { b : 2 } ],
  //    /*03*/ [ function( ){ }, function add( ){ } ],
  //    /*04*/ [ 1000, 2000, 3000 ],
  //    /*05*/ [ 1.1111, 2.2222, 3.3333 ],
  //    /*06*/ [ 0, 1, 2 ],
  //    /*07*/ [  7, { v : 0 }, 1, 'x' ],
  //    /*08*/ [ 'e', 'e', 'e' ],
  //    /*09*/ [ '\n\nEscaping test' ],
  //    /*10*/ [ 0, 1, 2 ],
  //    /*11*/ [ 'a', 'b', 'c', 1, 2, 3 ],
  //    /*12*/ [ { x : 1 }, { y : 2 } ],
  //    /*13*/ [ 1, [ 2, 3, 4 ], 5 ],
  //    /*14*/ [ 6, [ 7, 8, 9 ], 10 ],
  //    /*15*/ [ { k : 3 }, { l : 4 } ],
  //    /*16*/ [ 1, { a : 2 }, 5 ],
  //    /*17*/ [ 0, { b : 1 }, 3 ],
  //    /*18*/ [ 'a', 7, { u : 2 }, 8, 'b' ],
  //    /*19*/ [ function f1( ){ }, function( ){ } ],
  //    /*20*/ [ function f2( ){ }, function f3( ){ } ],
  //    /*21*/ [ { a : { a : '1' } } ],
  //    /*22*/ [ { c : 1 }, { d : 2 } ],
  //    /*23*/ [ new Date( Date.UTC( 1993, 12, 12 ) ), { d : 2 }, new Error( 'error' ) ],
  //    /*24*/ [ function ff( ){ }, { d : 3 }, 15 ],
  //    /*25*/ [ [ 1, 2, 3 ], [ 4, 5, 6 ] ],
  //    /*26*/ [ [ 1, 2, 3 ], [ '4, 5, 6' ], undefined, false ],
  //    /*27*/ [ 'e', 'e', 'e' ],
  //    /*28*/ [ 'a', 'b', 'c', 1, 2, 3 ],
  //    /*29*/ [ 15, 16, 17, 18 ],
  //    /*30*/ [ { a : 5, b : 6, c : 7 } ],
  //    /*31*/ [ 'a', 1, function( ) { }, false ],
  //    /*32*/ [ 'b', 2, function( ) { }, true ],
  //    /*33*/ [ function( ) { } ],
  //    /*34*/ [ 'a', 1000, 2000, 3000 ],
  //    /*35*/ [ 1.1111, 2.2222, 3.3333 ],
  //    /*36*/ [  7, { v : 0 }, 1, 'x' ],
  //    /*37*/ [ '\n\nEscaping & wrap test' ],
  //    /*38*/ [ 0, [ 1, 2, 3, 4 ], 5, { a : 6 } ],
  //    /*39*/ [ ['a', 'b', 'c'], 'd', 'e' ],
  //    /*40*/ [ { a : 0 }, { b : 1 }, [ 2, 3 ] ],
  //    /*41*/ [ { a : 'a', b : 'b', c : 'c' } ],
  //    /*42*/ [ 'a', 7, { u : 2 }, 8, 'b' ],
  //    /*43*/ [ 0.1111, 0.2222, 0.3333 ],
  //    /*44*/ [ 'x', 2000, 3000, 4000 ],
  //    /*45*/ [ 0, { b : 1 }, 3 ],
  //    /*46*/ [ { a : '\na', b : { d : '\ntrue' } } ],
  //    /*47*/ [ { x : '\na', y : { z : '\ntrue' } } ],
  //    /*48*/ [ 1, { a : 2 }, '03' ],
  //    /*49*/ [ 0, [ 1, 2, 3, 4 ], 5, { a : 6 } ],
  //    /*50*/ [ { a : 'string' }, [ true ], 1 ],
  //    /*51*/ [ [ 5, 4, [ 3 ] ], [ 2, 1, 0 ] ],
  //    /*52*/ [ { a : 0 }, { b : 1 }, [ 2, 3 ] ],
  //    /*53*/ [ [ 1.100, 1.200 ], [ 2, 3 ] ],
  //    /*54*/ [ 9000, [ 8000, 6000], 7000 ],
  //    /*55*/ [ { a : '\\test' }, { b : '\ntest' }, { c : 'test' } ],
  //    /*56*/ [ { a : function func ( ){ } }, 0, 1, 'a' ],
  //    /*57*/ [ { b : function f ( ){ } }, 1, 2 , 3 ],
  //    /*58*/ [ new Error( 'msg' ), new Date( Date.UTC( 1990, 0, 0 ) ), 'test' ],
  //    /*59*/ [ 1, [ 2, 3, 4 ], 2 ],
  //    /*60*/ [ 1, [ '2', null, undefined, '4' ], 2 ],
  //    /*61*/ [ [ 1, 2 ], 'string', { a : true, b : null }, undefined ],
  //    /*62*/ [ [ 0, 1 ], 'test', { a : Symbol( ) }, undefined ],
  //    /*63*/ [ 0, 'str', { a : Symbol( ) }, function test( ){ }, null ],
  //    /*64*/ [ 0, 'str', { a : Symbol( ) }, function test( ){ }, true, new Date( Date.UTC( 1990, 0, 0 ) ) ],
  //    /*65*/ [ [ 0, 1 ], 'test', { a : 'a' } ],
  //    /*66*/ [ [ 1, 2 ], 'sample', { a : 'b' } ],
  //    /*67*/ [ 11, 22, function routine( ){ }, { a : 'string' } ],
  //    /*68*/ [ ['a', 100], ['b', 200] ],
  //    /*69*/ [ ['aa', 300], ['bb', 400] ],
  //    /*70*/ [ [ 1.00, 2.00 ], [ 3.00, 4.00], 'str sample' ],
  //    /*71*/ [ '1', [ 2, 3, 4 ], '2' ],
  //    /*72*/ [ '1', [ 2.00, 3.00, 4.00 ], '2' ],
  //    /*73*/ [ 'o', [ 90, 80, 70 ], 'o' ],
  //    /*74*/ [ 'o', 1, { a : true, b : undefined, c : null } ],
  //    /*75*/ [ 'a', 2, { a : '\\true', b : true, c : null } ],
  //    /*76*/ [ [ 'a', 1 ], new Error( 'err msg' ), new Date( Date.UTC( 1990, 0, 0 ) ) ],
  //    /*77*/ [ [ 'a', 1 ], new Date( Date.UTC( 1999, 1, 1 ) ) ],
  //    /*78*/ [ [ 1, 2, 3 ], 'a' ],
  //
  //  ],
  //  options =
  //  [
  //    /*01*/ { },
  //    /*02*/ { },
  //    /*03*/ { },
  //    /*04*/ { precision : 2, multiline : 1 },
  //    /*05*/ { fixed : 2 },
  //    /*06*/ { noArray : 1 },
  //    /*07*/ { noAtomic : 1 },
  //    /*08*/ { noArray : 1 },
  //    /*09*/ { escaping : 1, levels : 2 },
  //    /*10*/ { levels : 0 },
  //    /*11*/ { levels : 2, noString : 1 },
  //    /*12*/ { levels : 2, dtab : '-' },
  //    /*13*/ { levels : 2, multiline : 1 },
  //    /*14*/ { levels : 2, noNumber : 1 },
  //    /*15*/ { levels : 2, colon : '->' },
  //    /*16*/ { levels : 2, noObject : 1 },
  //    /*17*/ { levels : 2, noNumber : 1 },
  //    /*18*/ { levels : 2, noAtomic : 1 },
  //    /*19*/ { levels : 2 },
  //    /*20*/ { levels : 2, noRoutine : 1 },
  //    /*21*/ { levels : 3, noSubObject : 1 },
  //    /*22*/ { levels : 2, tab : '|', prependTab : 0 },
  //    /*23*/ { levels : 2, noError : 1, noDate : 1 },
  //    /*24*/ { levels : 2, noRoutine : 1, noSubObject : 1 },
  //
  //    /*25*/  { wrap : 0, comma : ' | ' },
  //    /*26*/  { wrap : 0, noString : 1, noNumber: 1, comma : ', ' },
  //    /*27*/  { wrap : 0, comma : ' ' },
  //    /*28*/  { wrap : 0, prependTab : 0, comma : ', ' },
  //    /*29*/  { wrap : 0, tab : '| ', dtab : '', comma : '. ' },
  //    /*30*/  { wrap : 0, colon : '->', comma : '.' },
  //    /*31*/  { wrap : 0, noRoutine : 1, comma : '. ' },
  //    /*32*/  { wrap : 0, noAtomic : 1, comma : '. ' },
  //    /*33*/  { wrap : 0, onlyRoutines : 1, comma : '| ' },
  //    /*34*/  { wrap : 0, precision : 3, comma : '* ' },
  //    /*35*/  { wrap : 0, fixed : 3, comma : ', ' },
  //    /*36*/  { wrap : 0, multiline : 1, comma : '. ' },
  //    /*37*/  { wrap : 0, escaping : 1, comma : '. ' },
  //
  //    /*38*/  { levels : 2, wrap : 0, comma : '- ' },
  //    /*39*/  { levels : 2, wrap : 0, comma : '. '},
  //    /*40*/  { levels : 2, wrap : 0, tab : '| ', dtab : '', comma : ', ' },
  //    /*41*/  { levels : 2, wrap : 0, colon : ' - ', comma : '| ' },
  //    /*42*/  { levels : 2, wrap : 0, prependTab : 0, comma : ', ' },
  //    /*43*/  { levels : 2, wrap : 0, fixed : 1, comma : '* ' },
  //    /*44*/  { levels : 2, wrap : 0, precision : 1, comma : ', ' },
  //    /*45*/  { levels : 2, wrap : 0, multiline : 1, comma : '| ' },
  //    /*46*/  { levels : 3, wrap : 0, escaping : 1, comma : '. ' },
  //    /*47*/  { levels : 4, wrap : 0, escaping : 1, comma : ', ' },
  //    /*48*/  { levels : 3, wrap : 0, noAtomic : 1, comma : ' , ' },
  //    /*49*/  { levels : 2, wrap : 0, noSubObject : 1, noArray : 1, comma : ' ..' },
  //    /*50*/  { levels : 2, wrap : 0, noString : 1, noNumber : 1, comma : '/ ' },
  //
  //    /*51*/  { levels : 3, wrap : 0, comma : '||' },
  //    /*52*/  { levels : 2, wrap : 0, comma : ', , ', tab :'  |', colon : '->' },
  //    /*53*/  { levels : 2, prependTab : 0, fixed : 2 },
  //    /*54*/  { levels : 2, prependTab : 0, precision : 1 },
  //    /*55*/  { levels : 2, multiline : 1, escaping : 1 },
  //    /*56*/  { levels : 2, noRoutine : 1 },
  //    /*57*/  { levels : 3, noRoutine : 1 },
  //    /*58*/  { levels : 3, noError : 1, noDate : 1 },
  //    /*59*/  { levels : 2, noArray : 1 },
  //    /*60*/  { levels : 2, noNumber : 1, noString : 1 },
  //    /*61*/  { levels : 2, noNumber : 1, noString : 1, noObject : 1 },
  //    /*62*/  { levels : 3, noNumber : 1, noString : 1, noObject : 1 },
  //    /*63*/  { levels : 2, noNumber : 1, noString : 1, noObject : 1, noRoutine : 1 },
  //    /*64*/  { levels : 2, noNumber : 1, noString : 1, noObject : 1, noRoutine : 1, noDate : 1 },
  //    /*65*/  { levels : 2, noNumber : 1, noString : 1, noSubObject : 1 },
  //    /*66*/  { levels : 3, noNumber : 1, noString : 1, noSubObject : 1 },
  //    /*67*/  { levels : 2, noNumber : 1, noString : 1, onlyRoutines : 1 },
  //    /*68*/  { levels : 2, noString : 1, precision : 2 },
  //    /*69*/  { levels : 3, noString : 1, precision : 3 },
  //    /*70*/  { levels : 2, noString : 1, fixed : 3 },
  //    /*71*/  { levels : 2, noString : 1, noNumber : 1, precision : 1 },
  //    /*72*/  { levels : 2, noString : 1, noNumber : 1, fixed : 1 },
  //    /*73*/  { levels : 3, noString : 1, noNumber : 1, precision : 1 },
  //    /*74*/  { levels : 2, noString : 1, noNumber : 1, multiline : 1 },
  //    /*75*/  { levels : 2, noString : 1, noNumber : 1, multiline : 1, escaping : 1 },
  //    /*76*/  { levels : 2, noString : 1, noNumber : 1, noError : 1 },
  //    /*77*/  { levels : 2, noString : 1, noNumber : 1, tab : '|', prependTab : 0 },
  //    /*78*/  { levels : 3, noAtomic : 1, noNumber : 0 },
  //
  //
  //  ],
  //  expected =
  //  [
  //    /*01*/ '[ 1, 2, 3 ]',
  //    /*02*/
  //    [
  //      '[',
  //      '  {- Map.polluted with 1 elements -}, ',
  //      '  {- Map.polluted with 1 elements -}',
  //      ']'
  //    ].join( '\n' ),
  //
  //    /*03*/ '[ [ routine without name ], [ routine add ] ]',
  //    /*04*/
  //    [
  //      '[',
  //      '  1.0e+3, ',
  //      '  2.0e+3, ',
  //      '  3.0e+3',
  //      ']',
  //    ].join( '\n' ),
  //
  //    /*05*/ '[ 1.11, 2.22, 3.33 ]',
  //
  //    /*06*/ '',
  //
  //
  //    /*07*/
  //    [
  //      '[',
  //      '  {- Map.polluted with 1 elements -}',
  //      ']'
  //    ].join( '\n' ),
  //
  //    /*08*/ '',
  //
  //
  //    /*09*/ '[ \'\\n\\nEscaping test\' ]',
  //
  //    /*10*/ '{- Array with 3 elements -}',
  //    /*11*/ '[ 1, 2, 3 ]',
  //    /*12*/
  //    [
  //      '[',
  //      '-{ x : 1 }, ',
  //      '-{ y : 2 }',
  //      ']'
  //    ].join( '\n' ),
  //
  //    /*13*/
  //    [
  //      '[',
  //      '  1, ',
  //      '  [',
  //      '    2, ',
  //      '    3, ',
  //      '    4',
  //      '  ], ',
  //      '  5',
  //      ']',
  //
  //    ].join( '\n' ),
  //
  //    /*14*/
  //    [
  //      '[',
  //      '  []',
  //      ']'
  //    ].join( '\n' ),
  //
  //    /*15*/
  //    [
  //      '[',
  //      '  { k->3 }, ',
  //      '  { l->4 }',
  //      ']'
  //    ].join( '\n' ),
  //
  //    /*16*/
  //    [
  //
  //      '[ 1, 5 ]'
  //
  //    ].join( '\n' ),
  //
  //    /*17*/
  //    [
  //      '[',
  //      '  {}',
  //      ']'
  //    ].join( '\n' ),
  //
  //    /*18*/
  //    [
  //      '[',
  //      '  {}',
  //      ']'
  //    ].join( '\n' ),
  //
  //    /*19*/ '[ [ routine f1 ], [ routine without name ] ]',
  //    /*20*/ '[]',
  //    /*21*/
  //    [
  //      '[',
  //      '  {}',
  //      ']'
  //    ].join( '\n' ),
  //
  //    /*22*/
  //    [
  //      '[',
  //      '|  { c : 1 }, ',
  //      '|  { d : 2 }',
  //      '|]',
  //    ].join( '\n' ),
  //
  //    /*23*/
  //    [
  //      '[',
  //      '  { d : 2 }',
  //      ']',
  //    ].join( '\n' ),
  //
  //    /*24*/
  //    [
  //      '[',
  //      '  { d : 3 }, ',
  //      '  15',
  //      ']',
  //    ].join( '\n' ),
  //
  //    /*25*/
  //    [
  //      '  {- Array with 3 elements -} | ',
  //      '  {- Array with 3 elements -}',
  //    ].join( '\n' ),
  //
  //    /*26*/
  //    [
  //      '  undefined, false',
  //    ].join( '\n' ),
  //
  //    /*27*/
  //    '  \'e\' \'e\' \'e\'',
  //
  //    /*28*/
  //    '  \'a\', \'b\', \'c\', 1, 2, 3',
  //    /*29*/
  //    '| 15. 16. 17. 18',
  //    /*30*/
  //    '  {- Map.polluted with 3 elements -}',
  //    /*31*/
  //    '  \'a\'. 1. false',
  //    /*32*/
  //    '  [ routine without name ]',
  //    /*33*/
  //    '',
  //    /*34*/
  //    '  \'a\'* 1.00e+3* 2.00e+3* 3.00e+3',
  //
  //    /*35*/
  //    '  1.111, 2.222, 3.333',
  //    /*36*/
  //    [
  //      '  7. ',
  //      '  {- Map.polluted with 1 elements -}. ',
  //      '  1. ',
  //      '  \'x\'',
  //    ].join( '\n' ),
  //
  //    /*37*/
  //    '  \'\\n\\nEscaping & wrap test\'',
  //
  //    /*38*/
  //    [
  //      '  0- ',
  //      '    1- 2- 3- 4- ',
  //      '  5- ',
  //      '  a : 6',
  //    ].join( '\n' ),
  //
  //    /*39*/
  //    [
  //      '    \'a\'. \'b\'. \'c\'. ',
  //      '  \'d\'. ',
  //      '  \'e\''
  //    ].join( '\n' ),
  //
  //    /*40*/
  //    [
  //      '| a : 0, ',
  //      '| b : 1, ',
  //      '| 2, 3'
  //    ].join( '\n' ),
  //
  //    /*41*/
  //    [
  //      '  a - \'a\'| b - \'b\'| c - \'c\''
  //    ].join( '\n' ),
  //
  //    /*42*/
  //    [
  //      '  \'a\', ',
  //      '  7, ',
  //      '  u : 2, ',
  //      '  8, ',
  //      '  \'b\'',
  //    ].join( '\n' ),
  //
  //    /*43*/
  //    [
  //      '  0.1* 0.2* 0.3',
  //    ].join( '\n' ),
  //
  //    /*44*/
  //    [
  //      '  \'x\', 2e+3, 3e+3, 4e+3',
  //    ].join( '\n' ),
  //
  //    /*45*/
  //    [
  //      '  0| ',
  //      '    b : 1| ',
  //      '  3',
  //    ].join( '\n' ),
  //
  //    /*46*/
  //    [
  //      '    a : \'\\na\'. ',
  //      '    b : d : \'\\ntrue\'',
  //    ].join( '\n' ),
  //
  //    /*47*/
  //    [
  //      '    x : \'\\na\', ',
  //      '    y : z : \'\\ntrue\'',
  //    ].join( '\n' ),
  //
  //    /*48*/
  //    [
  //      '',
  //    ].join( '\n' ),
  //
  //    /*49*/
  //    [
  //      '',
  //    ].join( '\n' ),
  //
  //    /*50*/
  //    [
  //      '    true'
  //    ].join( '\n' ),
  //
  ////[ { a : 'string' }, [ true ], 1 ],
  ////{ levels : 2, wrap : 0, noString : 1, noNumber : 1, comma : '/ ' },
  //
  //    /*51*/ // !!! please move to exportStringUnwrapped
  //    [
  //      '    5||',
  //      '    4||',
  //      '      3||',
  //      '    2||1||0',
  //    ].join( '\n' ),
  //
  //    /*52*/
  //    [
  //      '  |  a->0, , ',
  //      '  |  b->1, , ',
  //      '  |    2, , 3',
  //    ].join( '\n' ),
  //
  //    /*53*/
  //    [
  //      '[',
  //      '  [ 1.10, 1.20 ], ',
  //      '  [ 2.00, 3.00 ]',
  //      ']',
  //    ].join( '\n' ),
  //
  //    /*54*/
  //    [
  //      '[',
  //      '  9e+3, ',
  //      '  [ 8e+3, 6e+3 ], ',
  //      '  7e+3',
  //      ']',
  //    ].join( '\n' ),
  //
  //    /*55*/
  //    [
  //      '[',
  //      '  {',
  //      '    a : \'\\\\test\'',
  //      '  }, ',
  //      '  {',
  //      '    b : \'\\ntest\'',
  //      '  }, ',
  //      '  {',
  //      '    c : \'test\'',
  //      '  }',
  //      ']',
  //    ].join( '\n' ),
  //
  //    /*56*/
  //    [
  //      '[',
  //      '  {}, ',
  //      '  0, ',
  //      '  1, ',
  //      '  \'a\'',
  //      ']',
  //    ].join( '\n' ),
  //
  //    /*57*/
  //    [
  //      '[',
  //      '  {}, ',
  //      '  1, ',
  //      '  2, ',
  //      '  3',
  //      ']',
  //    ].join( '\n' ),
  //
  //    /*58*/
  //    [
  //      '[ \'test\' ]',
  //    ].join( '\n' ),
  //
  //    /*59*/
  //     '',
  //
  //    /*60*/
  //
  //    [ '[',
  //      '  [ null, undefined ]',
  //      ']',
  //    ].join( '\n' ),
  //
  //    /*61*/
  //
  //    [ '[',
  //      '  [], ',
  //      '  undefined',
  //      ']',
  //    ].join( '\n' ),
  //
  //    /*62*/
  //
  //    [ '[',
  //      '  [], ',
  //      '  undefined',
  //      ']',
  //    ].join( '\n' ),
  //
  //    /*63*/
  //
  //    [
  //      '[ null ]',
  //    ].join( '\n' ),
  //
  //    /*64*/
  //
  //    [
  //      '[ true ]',
  //    ].join( '\n' ),
  //
  //    /*65*/
  //
  //    [ '[',
  //      '  [], ',
  //      '  {}',
  //      ']',
  //    ].join( '\n' ),
  //
  //    /*66*/
  //
  //    [ '[',
  //      '  [], ',
  //      '  {}',
  //      ']',
  //    ].join( '\n' ),
  //
  //    /*67*/
  //
  //    [
  //      ''
  //    ].join( '\n' ),
  //
  //    /*68*/
  //
  //    [
  //      '[',
  //      '  [ 1.0e+2 ], ',
  //      '  [ 2.0e+2 ]',
  //      ']'
  //    ].join( '\n' ),
  //
  //    /*69*/
  //
  //    [
  //      '[',
  //      '  [ 300 ], ',
  //      '  [ 400 ]',
  //      ']'
  //    ].join( '\n' ),
  //
  //    /*70*/
  //
  //    [
  //      '[',
  //      '  [ 1.000, 2.000 ], ',
  //      '  [ 3.000, 4.000 ]',
  //      ']'
  //    ].join( '\n' ),
  //
  //    /*71*/
  //
  //    [
  //      '[',
  //      '  []',
  //      ']'
  //    ].join( '\n' ),
  //
  //    /*72*/
  //
  //    [
  //      '[',
  //      '  []',
  //      ']'
  //    ].join( '\n' ),
  //
  //    /*73*/
  //
  //    [
  //      '[',
  //      '  []',
  //      ']'
  //    ].join( '\n' ),
  //
  //    /*74*/
  //
  //    [
  //      '[',
  //      '  {',
  //      '    a : true, ',
  //      '    b : undefined, ',
  //      '    c : null',
  //      '  }',
  //      ']'
  //    ].join( '\n' ),
  //
  //    /*75*/
  //
  //    [
  //      '[',
  //      '  {',
  //      '    b : true, ',
  //      '    c : null',
  //      '  }',
  //      ']'
  //    ].join( '\n' ),
  //
  //    /*76*/
  //
  //    [
  //      '[',
  //      '  [], ',
  //      '  1989-12-31T00:00:00.000Z',
  //      ']'
  //    ].join( '\n' ),
  //
  //    /*77*/
  //
  //    [
  //      '[',
  //      '|  [], ',
  //      '|  1999-02-01T00:00:00.000Z',
  //      '|]'
  //    ].join( '\n' ),
  //
  //    /*78*/
  //
  //    [
  //      '[',
  //      '  []',
  //      ']'
  //    ].join( '\n' ),
  //
  //
  //  ];
  //
  //  testFunction( test, desc, src, options, expected );

  test.case = 'trivial array';
  var src = [ 1, 2, 3 ];
  var got = _.entity.exportString( src, { } );
  var expected = '[ 1, 2, 3 ]';
  test.identical( got, expected );

  test.case = 'array of objects';
  var src = [ { a : 1 }, { b : 2 } ];
  var got = _.entity.exportString( src, { } );
  var expected =
  [
    '[',
    '  {- Map.polluted with 1 elements -}, ',
    '  {- Map.polluted with 1 elements -}',
    ']'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array of functions';
  var src = [ function( ){ }, function add( ){ } ];
  var got = _.entity.exportString( src, { } );
  var expected = '[ [ routine without name ], [ routine add ] ]';
  test.identical( got, expected );

  test.case = 'array of integers, precision 2 multiline';
  var src = [ 1000, 2000, 3000 ];
  var got = _.entity.exportString( src, { precision : 2, multiline : 1 } );
  var expected =
  [
    '[',
    '  1.0e+3, ',
    '  2.0e+3, ',
    '  3.0e+3',
    ']',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array of floats, fixed 2';
  var src = [ 1.1111, 2.2222, 3.3333 ];
  var got = _.entity.exportString( src, { fixed : 2 } );
  var expected = '[ 1.11, 2.22, 3.33 ]';
  test.identical( got, expected );

  test.case = 'array, noArray';
  var src = [ 0, 1, 2 ];
  var got = _.entity.exportString( src, { noArray : 1 } );
  var expected = '';
  test.identical( got, expected );

  test.case = 'array with object, noAtomic';
  var src = [  7, { v : 0 }, 1, 'x' ];
  var got = _.entity.exportString( src, { noAtomic : 1 } );
  var expected =
  [
    '[',
    '  {- Map.polluted with 1 elements -}',
    ']'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array, noArray';
  var src = [ 'e', 'e', 'e' ];
  var got = _.entity.exportString( src, { noArray : 1 } );
  var expected = '';
  test.identical( got, expected );

  test.case = 'array, escaping';
  var src = [ '\n\nEscaping test' ];
  var got = _.entity.exportString( src, { escaping : 1, levels : 2 } );
  var expected = '[ \'\\n\\nEscaping test\' ]';
  test.identical( got, expected );

  test.case = 'default array, levels 0';
  var src = [ 0, 1, 2 ];
  var got = _.entity.exportString( src, { levels : 0 } );
  var expected = '{- Array with 3 elements -}';
  test.identical( got, expected );

  test.case = 'default array, noSring levels 2';
  var src = [ 'a', 'b', 'c', 1, 2, 3 ];
  var got = _.entity.exportString( src, { levels : 2, noString : 1 } );
  var expected = '[ 1, 2, 3 ]';
  test.identical( got, expected );

  test.case = 'array with objects, levels 2';
  var src = [ { x : 1 }, { y : 2 } ];
  var got = _.entity.exportString( src, { levels : 2, dtab : '-' } );
  var expected =
  [
    '[',
    '-{ x : 1 }, ',
    '-{ y : 2 }',
    ']'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested array';
  var src = [ 1, [ 2, 3, 4 ], 5 ];
  var got = _.entity.exportString( src, { levels : 2, multiline : 1 } );
  var expected =
  [
    '[',
    '  1, ',
    '  [',
    '    2, ',
    '    3, ',
    '    4',
    '  ], ',
    '  5',
    ']',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested array, noNumber';
  var src = [ 6, [ 7, 8, 9 ], 10 ];
  var got = _.entity.exportString( src, { levels : 2, noNumber : 1 } );
  var expected =
  [
    '[',
    '  []',
    ']'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array of object, modified colon levels 2';
  var src = [ { k : 3 }, { l : 4 } ];
  var got = _.entity.exportString( src, { levels : 2, colon : '->' } );
  var expected =
  [
    '[',
    '  { k->3 }, ',
    '  { l->4 }',
    ']'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array with object, noObject';
  var src = [ 1, { a : 2 }, 5 ];
  var got = _.entity.exportString( src, { levels : 2, noObject : 1 } );
  var expected = '[ 1, 5 ]';
  test.identical( got, expected );

  test.case = 'array with object, noNumber';
  var src = [ 0, { b : 1 }, 3 ];
  var got = _.entity.exportString( src, { levels : 2, noNumber : 1 } );
  var expected =
  [
    '[',
    '  {}',
    ']'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array with object, noAtomic';
  var src = [ 'a', 7, { u : 2 }, 8, 'b' ];
  var got = _.entity.exportString( src, { levels : 2, noAtomic : 1 } );
  var expected =
  [
    '[',
    '  {}',
    ']'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array of functions, levels 2';
  var src = [ function f1( ){ }, function( ){ } ];
  var got = _.entity.exportString( src, { levels : 2 } );
  var expected = '[ [ routine f1 ], [ routine without name ] ]';
  test.identical( got, expected );

  test.case = 'array of functions, noRoutine';
  var src = [ function f2( ){ }, function f3( ){ } ];
  var got = _.entity.exportString( src, { levels : 2, noRoutine : 1 } );
  var expected = '[]';
  test.identical( got, expected );

  test.case = 'array of nested object, noSubObject';
  var src = [ { a : { a : '1' } } ];
  var got = _.entity.exportString( src, { levels : 3, noSubObject : 1 } );
  var expected =
  [
    '[',
    '  {}',
    ']'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array of objects, prependTab 0';
  var src = [ { c : 1 }, { d : 2 } ];
  var got = _.entity.exportString( src, { levels : 2, tab : '|', prependTab : 0 } );
  var expected =
  [
    '[',
    '|  { c : 1 }, ',
    '|  { d : 2 }',
    '|]',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array of date, object and error. noError noDate';
  var src = [ new Date( Date.UTC( 1993, 12, 12 ) ), { d : 2 }, new Error( 'error' ) ];
  var got = _.entity.exportString( src, { levels : 2, noError : 1, noDate : 1 } );
  var expected =
  [
    '[',
    '  { d : 2 }',
    ']',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array with routine and object, noRoutine noSubObject';
  var src = [ function ff( ){ }, { d : 3 }, 15 ];
  var got = _.entity.exportString( src, { levels : 2, noRoutine : 1, noSubObject : 1 } );
  var expected =
  [
    '[',
    '  { d : 3 }, ',
    '  15',
    ']',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested arrays, wrap 0';
  var src = [ [ 1, 2, 3 ], [ 4, 5, 6 ] ];
  var got = _.entity.exportString( src, { wrap : 0, comma : ' | ' } );
  var expected =
  [
    '  {- Array with 3 elements -} | ',
    '  {- Array with 3 elements -}',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested arrays, noString noNumber wrap 0';
  var src = [ [ 1, 2, 3 ], [ '4, 5, 6' ], undefined, false ];
  var got = _.entity.exportString( src, { wrap : 0, noString : 1, noNumber: 1, comma : ', ' } );
  var expected = '  undefined, false';
  test.identical( got, expected );

  test.case = 'array, wrap 0';
  var src = [ 'e', 'e', 'e' ];
  var got = _.entity.exportString( src, { wrap : 0, comma : ' ' } );
  var expected = '  \'e\' \'e\' \'e\'';
  test.identical( got, expected );

  test.case = 'array, wrap 0 prependTab 0';
  var src = [ 'a', 'b', 'c', 1, 2, 3 ];
  var got = _.entity.exportString( src, { wrap : 0, prependTab : 0, comma : ', ' } );
  var expected = '  \'a\', \'b\', \'c\', 1, 2, 3';
  test.identical( got, expected );

  test.case = 'array, wrap 0 modified tab';
  var src = [ 15, 16, 17, 18 ];
  var got = _.entity.exportString( src, { wrap : 0, tab : '| ', dtab : '', comma : '. ' } );
  var expected = '| 15. 16. 17. 18';
  test.identical( got, expected );

  test.case = 'array of an object, wrap 0';
  var src = [ { a : 5, b : 6, c : 7 } ];
  var got = _.entity.exportString( src, { wrap : 0, colon : '->', comma : '.' } );
  var expected = '  {- Map.polluted with 3 elements -}';
  test.identical( got, expected );

  test.case = 'array with a function, noRoutine';
  var src = [ 'a', 1, function( ) { }, false ];
  var got = _.entity.exportString( src, { wrap : 0, noRoutine : 1, comma : '. ' } );
  var expected = '  \'a\'. 1. false';
  test.identical( got, expected );

  test.case = 'array with function, noAtomic';
  var src = [ 'b', 2, function( ) { }, true ];
  var got = _.entity.exportString( src, { wrap : 0, noAtomic : 1, comma : '. ' } );
  var expected = '  [ routine without name ]';
  test.identical( got, expected );

  test.case = 'array with a function, onlyRoutines';
  var src = [ function( ) { } ];
  var got = _.entity.exportString( src, { wrap : 0, onlyRoutines : 1, comma : '| ' } );
  var expected = '';
  test.identical( got, expected );

  test.case = 'array, precision 3';
  var src = [ 'a', 1000, 2000, 3000 ];
  var got = _.entity.exportString( src, { wrap : 0, precision : 3, comma : '* ' } );
  var expected = '  \'a\'* 1.00e+3* 2.00e+3* 3.00e+3';
  test.identical( got, expected );

  test.case = 'array, fixed 3';
  var src = [ 1.1111, 2.2222, 3.3333 ];
  var got = _.entity.exportString( src, { wrap : 0, fixed : 3, comma : ', ' } );
  var expected = '  1.111, 2.222, 3.333';
  test.identical( got, expected );

  test.case = 'array, multiline';
  var src = [  7, { v : 0 }, 1, 'x' ];
  var got = _.entity.exportString( src, { wrap : 0, multiline : 1, comma : '. ' } );
  var expected =
  [
    '  7. ',
    '  {- Map.polluted with 1 elements -}. ',
    '  1. ',
    '  \'x\'',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array, escaping wrap 0';
  var src = [ '\n\nEscaping & wrap test' ];
  var got = _.entity.exportString( src, { wrap : 0, escaping : 1, comma : '. ' } );
  var expected = '  \'\\n\\nEscaping & wrap test\'';
  test.identical( got, expected );

  test.case = 'nested array, levels 2 wrap 0';
  var src = [ 0, [ 1, 2, 3, 4 ], 5, { a : 6 } ];
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, comma : '- ' } );
  var expected =
  [
    '  0- ',
    '    1- 2- 3- 4- ',
    '  5- ',
    '  a : 6',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested array, levels 2 wrap 0';
  var src = [ ['a', 'b', 'c'], 'd', 'e' ];
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, comma : '. '} );
  var expected =
  [
    '    \'a\'. \'b\'. \'c\'. ',
    '  \'d\'. ',
    '  \'e\''
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array of objects, wrap 0 modified tab';
  var src = [ { a : 0 }, { b : 1 }, [ 2, 3 ] ];
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, tab : '| ', dtab : '', comma : ', ' } );
  var expected =
  [
    '| a : 0, ',
    '| b : 1, ',
    '| 2, 3'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array of an object';
  var src = [ { a : 'a', b : 'b', c : 'c' } ];
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, colon : ' - ', comma : '| ' } );
  var expected = '  a - \'a\'| b - \'b\'| c - \'c\'';
  test.identical( got, expected );

  test.case = 'array, levels 2';
  var src = [ 'a', 7, { u : 2 }, 8, 'b' ];
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, prependTab : 0, comma : ', ' } );
  var expected =
  [
    '  \'a\', ',
    '  7, ',
    '  u : 2, ',
    '  8, ',
    '  \'b\'',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array, fixed 1';
  var src = [ 0.1111, 0.2222, 0.3333 ];
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, fixed : 1, comma : '* ' } );
  var expected = '  0.1* 0.2* 0.3';
  test.identical( got, expected );

  test.case = 'array, precision 1 levels 2';
  var src = [ 'x', 2000, 3000, 4000 ];
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, precision : 1, comma : ', ' } );
  var expected = '  \'x\', 2e+3, 3e+3, 4e+3';
  test.identical( got, expected );

  test.case = 'array, multiline';
  var src = [ 0, { b : 1 }, 3 ];
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, multiline : 1, comma : '| ' } );
  var expected =
  [
    '  0| ',
    '    b : 1| ',
    '  3',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array of nested objects, escaping';
  var src = [ { a : '\na', b : { d : '\ntrue' } } ];
  var got = _.entity.exportString( src, { levels : 3, wrap : 0, escaping : 1, comma : '. ' } );
  var expected =
  [
    '    a : \'\\na\'. ',
    '    b : d : \'\\ntrue\'',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array of nested objects, escaping';
  var src = [ { x : '\na', y : { z : '\ntrue' } } ];
  var got = _.entity.exportString( src, { levels : 4, wrap : 0, escaping : 1, comma : ', ' } );
  var expected =
  [
    '    x : \'\\na\', ',
    '    y : z : \'\\ntrue\'',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array, noAtomic wrap 0';
  var src = [ 1, { a : 2 }, '03' ];
  var got = _.entity.exportString( src, { levels : 3, wrap : 0, noAtomic : 1, comma : ' , ' } );
  var expected = '';
  test.identical( got, expected );

  test.case = 'array, noArray wrap 0';
  var src = [ 0, [ 1, 2, 3, 4 ], 5, { a : 6 } ];
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, noSubObject : 1, noArray : 1, comma : ' ..' } );
  var expected = '';
  test.identical( got, expected );

  test.case = 'array, wrap 0 noSring noNumber';
  var src = [ { a : 'string' }, [ true ], 1 ];
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, noString : 1, noNumber : 1, comma : '/ ' } );
  var expected = '    true';
  test.identical( got, expected );

  test.case = 'nested arrays, wrap 0 modified comma';
  var src = [ [ 5, 4, [ 3 ] ], [ 2, 1, 0 ] ];
  var got = _.entity.exportString( src, { levels : 3, wrap : 0, comma : '||' } );
  var expected =
  [
    '    5||',
    '    4||',
    '      3||',
    '    2||1||0',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array of objects';
  var src = [ { a : 0 }, { b : 1 }, [ 2, 3 ] ];
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, comma : ', , ', tab :'  |', colon : '->' } );
  var expected =
  [
    '  |  a->0, , ',
    '  |  b->1, , ',
    '  |    2, , 3',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested arrays, prependTab 0 fixed 2';
  var src = [ [ 1.100, 1.200 ], [ 2, 3 ] ];
  var got = _.entity.exportString( src, { levels : 2, prependTab : 0, fixed : 2 } );
  var expected =
  [
    '[',
    '  [ 1.10, 1.20 ], ',
    '  [ 2.00, 3.00 ]',
    ']',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array, precision 1';
  var src = [ 9000, [ 8000, 6000], 7000 ];
  var got = _.entity.exportString( src, { levels : 2, prependTab : 0, precision : 1 } );
  var expected =
  [
    '[',
    '  9e+3, ',
    '  [ 8e+3, 6e+3 ], ',
    '  7e+3',
    ']',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array of objects, multiline escaping';
  var src = [ { a : '\\test' }, { b : '\ntest' }, { c : 'test' } ];
  var got = _.entity.exportString( src, { levels : 2, multiline : 1, escaping : 1 } );
  var expected =
  [
    '[',
    '  {',
    '    a : \'\\\\test\'',
    '  }, ',
    '  {',
    '    b : \'\\ntest\'',
    '  }, ',
    '  {',
    '    c : \'test\'',
    '  }',
    ']',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array with a func inside an object, noRoutine';
  var src = [ { a : function func ( ){ } }, 0, 1, 'a' ];
  var got = _.entity.exportString( src, { levels : 2, noRoutine : 1 } );
  var expected =
  [
    '[',
    '  {}, ',
    '  0, ',
    '  1, ',
    '  \'a\'',
    ']',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array with a func inside an object, noRoutine';
  var src = [ { b : function f ( ){ } }, 1, 2 , 3 ];
  var got = _.entity.exportString( src, { levels : 3, noRoutine : 1 } );
  var expected =
  [
    '[',
    '  {}, ',
    '  1, ',
    '  2, ',
    '  3',
    ']',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array with error and date, noError noDate';
  var src = [ new Error( 'msg' ), new Date( Date.UTC( 1990, 0, 0 ) ), 'test' ];
  var got = _.entity.exportString( src, { levels : 3, noError : 1, noDate : 1 } );
  var expected = '[ \'test\' ]';
  test.identical( got, expected );

  test.case = 'nested arrays, noArray';
  var src = [ 1, [ 2, 3, 4 ], 2 ];
  var got = _.entity.exportString( src, { levels : 2, noArray : 1 } );
  var expected = '';
  test.identical( got, expected );

  test.case = 'nested array, noNumber';
  var src = [ 1, [ '2', null, undefined, '4' ], 2 ];
  var got = _.entity.exportString( src, { levels : 2, noNumber : 1, noString : 1 } );
  var expected =
  [
    '[',
    '  [ null, undefined ]',
    ']',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array, noObject noNumber noString';
  var src = [ [ 1, 2 ], 'string', { a : true, b : null }, undefined ];
  var got = _.entity.exportString( src, { levels : 2, noNumber : 1, noString : 1, noObject : 1 } );
  var expected =
  [
    '[',
    '  [], ',
    '  undefined',
    ']',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array, noObject noNumber noString';
  var src = [ [ 0, 1 ], 'test', { a : Symbol( ) }, undefined ];
  var got = _.entity.exportString( src, { levels : 3, noNumber : 1, noString : 1, noObject : 1 } );
  var expected =
  [
    '[',
    '  [], ',
    '  undefined',
    ']',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array, noObject noNumber noString noRoutine';
  var src = [ 0, 'str', { a : Symbol( ) }, function test( ){ }, null ];
  var got = _.entity.exportString( src, { levels : 2, noNumber : 1, noString : 1, noObject : 1, noRoutine : 1 } );
  var expected = '[ null ]';
  test.identical( got, expected );

  test.case = 'array, noObject noNumber noString noRoutine noDate';
  var src = [ 0, 'str', { a : Symbol( ) }, function test( ){ }, true, new Date( Date.UTC( 1990, 0, 0 ) ) ];
  var got = _.entity.exportString( src, { levels : 2, noNumber : 1, noString : 1, noObject : 1, noRoutine : 1, noDate : 1 } );
  var expected = '[ true ]';
  test.identical( got, expected );

  test.case = 'array with object, noSubObject noNumber noSring';
  var src = [ [ 0, 1 ], 'test', { a : 'a' } ];
  var got = _.entity.exportString( src, { levels : 2, noNumber : 1, noString : 1, noSubObject : 1 } );
  var expected =
  [
    '[',
    '  [], ',
    '  {}',
    ']',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array with object, noSubObject noNumber noSring';
  var src = [ [ 1, 2 ], 'sample', { a : 'b' } ];
  var got = _.entity.exportString( src, { levels : 3, noNumber : 1, noString : 1, noSubObject : 1 } );
  var expected =
  [
    '[',
    '  [], ',
    '  {}',
    ']',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array with function, onlyRoutines';
  var src = [ 11, 22, function routine( ){ }, { a : 'string' } ];
  var got = _.entity.exportString( src, { levels : 2, noNumber : 1, noString : 1, onlyRoutines : 1 } );
  var expected = '';
  test.identical( got, expected );

  test.case = 'nested arrays, noSring precision 2';
  var src = [ ['a', 100], ['b', 200] ];
  var got = _.entity.exportString( src, { levels : 2, noString : 1, precision : 2 } );
  var expected =
  [
    '[',
    '  [ 1.0e+2 ], ',
    '  [ 2.0e+2 ]',
    ']'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested arrays, noSring precision 3';
  var src = [ ['aa', 300], ['bb', 400] ];
  var got = _.entity.exportString( src, { levels : 3, noString : 1, precision : 3 } );
  var expected =
  [
    '[',
    '  [ 300 ], ',
    '  [ 400 ]',
    ']'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested arrays, noSring fixed 3';
  var src = [ [ 1.00, 2.00 ], [ 3.00, 4.00], 'str sample' ];
  var got = _.entity.exportString( src, { levels : 2, noString : 1, fixed : 3 } );
  var expected =
  [
    '[',
    '  [ 1.000, 2.000 ], ',
    '  [ 3.000, 4.000 ]',
    ']'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested array, noString noNumber precision';
  var src = [ '1', [ 2, 3, 4 ], '2' ];
  var got = _.entity.exportString( src, { levels : 2, noString : 1, noNumber : 1, precision : 1 } );
  var expected =
  [
    '[',
    '  []',
    ']'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested arrays, noNumber noString fixed 1';
  var src = [ '1', [ 2.00, 3.00, 4.00 ], '2' ];
  var got = _.entity.exportString( src, { levels : 2, noString : 1, noNumber : 1, fixed : 1 } );
  var expected =
  [
    '[',
    '  []',
    ']'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested arrays, noNumber noString precision 1';
  var src = [ 'o', [ 90, 80, 70 ], 'o' ];
  var got = _.entity.exportString( src, { levels : 3, noString : 1, noNumber : 1, precision : 1 } );
  var expected =
  [
    '[',
    '  []',
    ']'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array with an object,noSring noNumber multiline';
  var src = [ 'o', 1, { a : true, b : undefined, c : null } ];
  var got = _.entity.exportString( src, { levels : 2, noString : 1, noNumber : 1, multiline : 1 } );
  var expected =
  [
    '[',
    '  {',
    '    a : true, ',
    '    b : undefined, ',
    '    c : null',
    '  }',
    ']'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array with object, escaping';
  var src = [ 'a', 2, { a : '\\true', b : true, c : null } ];
  var got = _.entity.exportString( src, { levels : 2, noString : 1, noNumber : 1, multiline : 1, escaping : 1 } );
  var expected =
  [
    '[',
    '  {',
    '    b : true, ',
    '    c : null',
    '  }',
    ']'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array, noError';
  var src = [ [ 'a', 1 ], new Error( 'err msg' ), new Date( Date.UTC( 1990, 0, 0 ) ) ];
  var got = _.entity.exportString( src, { levels : 2, noString : 1, noNumber : 1, noError : 1 } );
  var expected =
  [
    '[',
    '  [], ',
    '  1989-12-31T00:00:00.000Z',
    ']'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array with a date, modified tab';
  var src = [ [ 'a', 1 ], new Date( Date.UTC( 1999, 1, 1 ) ) ];
  var got = _.entity.exportString( src, { levels : 2, noString : 1, noNumber : 1, tab : '|', prependTab : 0 } );
  var expected =
  [
    '[',
    '|  [], ',
    '|  1999-02-01T00:00:00.000Z',
    '|]'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested array';
  var src = [ [ 1, 2, 3 ], 'a' ];
  var got = _.entity.exportString( src, { levels : 3, noAtomic : 1, noNumber : 0 } );
  var expected =
  [
    '[',
    '  []',
    ']'
  ].join( '\n' );
  test.identical( got, expected );

  /* */

  var src = [ 'a', 'b' ];
  var got = _.entity.exportString( src );
  var expected = `[ 'a', 'b' ]`
  test.identical( got, expected );

  /* */

  var src = [ 'a b' ];
  var got = _.entity.exportString( src );
  var expected = `[ 'a b' ]`
  test.identical( got, expected );

  /* */

}

//

function exportStringObject( test )
{
  //  var desc = 'Object test',
  //  src =
  //  [
  //    /*01*/  { a : 1, b : 2, c : 3 },
  //    /*02*/  { x : 3, y : 5, z : 5 },
  //    /*03*/  { q : 6, w : 7, e : 8 },
  //    /*04*/  { u : 12, i : { o : 13 }, p : 14 },
  //    /*05*/  { r : 9, t : { a : 10 }, y : 11 },
  //      /* redundant */
  //    /*06*/  { z : '01', x : { c : { g : 4 } }, v : '03' },
  //    /*07*/  { u : 12, i : { o : { x : { y : [ 1, 2, 3 ] } } }, p : 14 },
  //      /* redundant */
  //    /*08*/  { q : { a : 1 }, w : 'c', e : [1] },
  //    /*09*/  { z : '02', x : { c : { g : 6 } }, v : '01' },
  //    /*10*/  { h : { d : 1 }, g : 'c', c : [2] },
  //    /*11*/  { a : 6, b : 7, c : 1 },
  //    /*12*/  { a : true, b : '2', c : 3, d : undefined },
  //    /*13*/  { a : null, b : 1, c : '2', d : undefined, e : true, f : Symbol( 'symbol' ) },
  //    /*14*/  { a : 'true', b : 2, c : false, d : undefined },
  //    /*15*/  { e : new Error( 'msg' ) },
  //    /*16*/  { f : 1, g : function f(  ) { } },
  //    /*17*/  { x : function y(  ) { } },
  //    /*18*/  { a : null, b : 1, c : '2', d : undefined },
  //    /*19*/  { e : function r( ) { }, f : 1, g : '2', h : [ 1 ] },
  //    /*20*/  { i : 0, k : 1, g : 2, l : 3 },
  //    /*21*/  { o : 4, p : 5, r : 6, s : 7 },
  //    /*22*/  { m : 8, n : 9 },
  //    /*23*/  { x : '\n10', z : '\\11' },
  //    /*24*/  { a : 1, b : { d : 2 }, c : 3 },
  //    /*25*/  { a : 3, b : { d : 2 }, c : 1 },
  //    /*26*/  { a : 4, b : { d : 5 }, c : 6 },
  //    /*27*/  { a : 7, b : { d : 8 }, c : 9 },
  //    /*28*/  { a : 9, b : { d : 8 }, c : 7 },
  //    /*29*/  { a : 10, b : { d : 20 }, c : 30 },
  //    /*30*/  { a : 10.00, b : { d : 20.00 }, c : 30.00 },
  //    /*31*/  { a : 'a', b : { d : false }, c : 3 },
  //    /*32*/  { a : '\na', b : { d : '\ntrue' }, c : '\n' },
  //    /*33*/  { a : 'a', b : { d : false }, c : 3 },
  //    /*34*/  { a : 'aa', b : { d : true }, c : 40 },
  //    /*35*/  { a : [ 'a', 'b' ], b : { d : 'true' }, c : 1 },
  //    /*36*/  { a : [ 'a', 'b' ], b : { d : 'true' }, c : 1 },
  //    /*37*/  { a : 1, b : { d : 2 }, c : 3 },
  //    /*38*/  { a : 3, b : { d : 2 }, c : 1 },
  //    /*39*/  { a : 'bb', b : { d : false }, c : 30 },
  //    /*40*/  { a : 100, b : { d : 110 }, c : 120 },
  //    /*41*/  { a : '\na', b : { d : '\ntrue' } },
  //    /*42*/  { a : 'aa', b : { d : function( ){ } } },
  //    /*43*/  { a : 'bb', b : { d : function( ){ } } },
  //    /*44*/  { a : new Date( Date.UTC( 1993, 12, 12 ) ), b : { d : new Error( 'msg' ) }, c : 1 },
  //    /*45*/  { "sequence" : "\u001b[A", "name" : "undefined", "shift" : false, "code" : "[A"  },
  //    /*46*/  { "sequence" : "\x7f[A", "name" : "undefined", "shift" : false, "code" : "[A"  },
  //    /*47*/  { "sequence" : "<\u001cb>text<\u001cb>", "data" : { "name" : "myname", "age" : 1 }, "shift" : false, "code" : "<b>text<b>"  },
  //    /*48*/  { "sequence" : "\u0068\u0065\u004C\u004C\u006F", "shift" : false, "code" : "heLLo"  },
  //    /*49*/  { "sequence" : "\n\u0061\u0062\u0063", "shift" : false, "code" : "abc"  },
  //    /*50*/  { "sequence" : "\t\u005b\u0063\u0062\u0061\u005d\t", "data" : 100, "code" : "\n[cba]\n"  },
  //    /*51*/  { "sequence" : "\u005CABC\u005C", "data" : 100, "code" : "\\ABC\\"  },
  //    /*52*/  { "sequence" : "\u000Aline\u000A", "data" : null, "code" : "\nline\n"  },
  //    /*53*/  { "sequence" : "\rspace\r",  },
  //    /*54*/  { "sequence" : "\btest",  },
  //    /*55*/  { "sequence" : "\vsample",  },
  //    /*56*/  { "sequence" : "\ftest",  },
  //    /*57*/  { a : 1, b : { d : 'string' }, c : true },
  //    /*58*/  { a : 1, b : { d : 'string' }, c : new Date(Date.UTC( ) ) },
  //    /*59*/  { a : 1000, b : { d : 'string' }, c : 1.500 },
  //    /*60*/  { a : 1000, b : 'text', c : 1.500 },
  //    /*61*/  { a : 1000, b : 'text', c : false, d : undefined, e : null},
  //    /*62*/  { a : 1001, b : 'text', c : false, d : undefined, e : null},
  //    /*63*/  ( function( ) //own:0 option test
  //            {
  //              var x = { a : 1, b : 2 },
  //              y = Object.create( x );
  //              y.c = 3;
  //              return y;
  //            } )( ),
  //
  //    /*64*/  ( function( ) //own:1 option test
  //            {
  //              var x = { a : '0', b : '1' },
  //              y = Object.create( x );
  //              y.c = '3';
  //              return y;
  //            } )( ),
  //
  //    /*65*/  { "sequence" : "\u001b[A", "name" : "undefined", "shift" : false, "code" : "[A"  },
  //
  //  ],
  //  options =
  //  [
  //    /*01*/  { },
  //    /*02*/  { levels : 0 },
  //    /*03*/  { levels : 1 },
  //    /*04*/  { levels : 1 },
  //    /*05*/  { levels : 2 },
  //
  //      /* redundant */
  //    /*06*/  { levels : 3 },
  //    /*07*/  { levels : 5 },
  //      /* redundant */
  //
  //    /*08*/  { levels : 2, noSubObject : 1, noArray : 1 },
  //    /*09*/  { levels : 3, noAtomic : 1 },
  //    /*10*/  { levels : 2, noObject : 1 },
  //
  //
  //    /*11*/  { wrap : 0, comma : ' | ' },
  //    /*12*/  { wrap : 0, noString : 1, noNumber: 1, comma : ', ' },
  //    /*13*/  { wrap : 0, comma : '* ' },
  //    /*14*/  { wrap : 0, prependTab : 0, comma : '-> ' },
  //    /*15*/  { wrap : 0, tab : '| ', dtab : '', comma : '> ' },
  //    /*16*/  { wrap : 0, colon : '', comma : ' ' },
  //    /*17*/  { wrap : 0, noRoutine : 1, comma : '.. ' },
  //    /*18*/  { wrap : 0, noAtomic : 1, comma : ', ' },
  //    /*19*/  { wrap : 0, onlyRoutines : 1, comma : '<< ' },
  //    /*20*/  { wrap : 0, precision : 3, comma : '| ' },
  //    /*21*/  { wrap : 0,  fixed : 3, comma : '^ ' },
  //    /*22*/  { wrap : 0,  multiline : 1, comma : ', ' },
  //    /*23*/  { wrap : 0,  escaping : 1, comma : '| ' },
  //
  //    /*24*/  { levels : 2, wrap : 0, comma : '. ' },
  //    /*25*/  { levels : 2, wrap : 0, comma : '. '},
  //    /*26*/  { levels : 2, wrap : 0, tab : '| ', dtab : '', comma : '@ ' },
  //    /*27*/  { levels : 2, wrap : 0, colon : ' - ', comma : '-? ' },
  //    /*28*/  { levels : 2, wrap : 0, prependTab : 0, comma : ', ' },
  //    /*29*/  { levels : 2, wrap : 0, fixed : 1, comma : '| ' },
  //    /*30*/  { levels : 2, wrap : 0, precision : 1, comma : '/ ' },
  //    /*31*/  { levels : 2, wrap : 0, multiline : 1, comma : ', , ' },
  //    /*32*/  { levels : 3, wrap : 0, escaping : 1, comma : '| ' },
  //    /*33*/  { levels : 2, wrap : 0, noAtomic : 1, comma : '< ' },
  //    /*34*/  { levels : 3, wrap : 0, noAtomic : 1, comma : ', ' },
  //    /*35*/  { levels : 2, wrap : 0, noSubObject : 1, noArray : 1, comma : '' },
  //    /*36*/  { levels : 2, wrap : 0, noString : 1, noNumber : 1, comma : '. ' },
  //    /*37*/  { levels : 2, wrap : 0, comma : '. '},
  //    /*38*/  { levels : 2, wrap : 0, comma : ', , ', tab :'  |', colon : '->' },
  //    /*39*/  { levels : 2, prependTab : 0, fixed : 5 },
  //    /*40*/  { levels : 2, prependTab : 0, precision : 5 },
  //    /*41*/  { levels : 2, multiline : 1, escaping : 1 },
  //    /*42*/  { levels : 2, noRoutine : 1 },
  //    /*43*/  { levels : 3, noRoutine : 1, },
  //    /*44*/  { levels : 3, noError : 1, noDate : 1 },
  //    /*45*/  { escaping : 1 },
  //    /*46*/  { escaping : 0 },
  //    /*47*/  { escaping : 0 },
  //    /*48*/  { multiline : 1 },
  //    /*49*/  { levels : 2, multiline : 1, escaping : 1 },
  //    /*50*/  { levels : 2, multiline : 1, escaping : 1 },
  //    /*51*/  { levels : 2, multiline : 1, escaping : 1 },
  //    /*52*/  { levels : 2, multiline : 1, escaping : 1 },
  //    /*53*/  { levels : 2, escaping : 1 },
  //    /*54*/  { levels : 2, escaping : 1 },
  //    /*55*/  { levels : 2, escaping : 1 },
  //    /*56*/  { levels : 2, escaping : 1 },
  //    /*57*/  { levels : 3, noNumber : 1, noString : 1},
  //    /*58*/  { levels : 3, noNumber : 1, noString : 1, noDate : 1},
  //    /*59*/  { levels : 2, noString : 1, fixed : 1},
  //    /*60*/  { levels : 2, noString : 1, precision : 1},
  //    /*61*/  { levels : 2, noString : 1, noNumber :1, tab : '-', prependTab : 0 },
  //    /*62*/  { levels : 2, noAtomic : 1, noNumber : 0 },
  //    /*63*/  { own : 0},
  //    /*64*/  {  },
  //    /*65*/  {  },
  //
  //  ],
  //  expected =
  //  [
  //    /*01*/  '{ a : 1, b : 2, c : 3 }',
  //    /*02*/  '{- Map.polluted with 3 elements -}',
  //    /*03*/  '{ q : 6, w : 7, e : 8 }',
  //
  //    /*04*/
  //    [
  //      '{',
  //      '  u : 12, ',
  //      '  i : {- Map.polluted with 1 elements -}, ',
  //      '  p : 14',
  //      '}'
  //    ].join( '\n' ),
  //
  //    /*05*/
  //    [
  //      '{',
  //      '  r : 9, ',
  //      '  t : { a : 10 }, ',
  //      '  y : 11',
  //      '}'
  //    ].join( '\n' ),
  //
  //      /* redundant */
  //    /*06*/
  //    [
  //      '{',
  //      '  z : \'01\', ',
  //      '  x : ',
  //      '  {',
  //      '    c : { g : 4 }',
  //      '  }, ',
  //      '  v : \'03\'',
  //      '}'
  //    ].join( '\n' ),
  //
  //    /*07*/
  //    [
  //      '{',
  //      '  u : 12, ',
  //      '  i : ',
  //      '  {',
  //      '    o : ',
  //      '    {',
  //      '      x : ',
  //      '      {',
  //      '        y : [ 1, 2, 3 ]',
  //      '      }',
  //      '    }',
  //      '  }, ',
  //      '  p : 14',
  //      '}'
  //    ].join( '\n' ),
  //    /* redundant */
  //
  //    /*08*/
  //    [
  //      '{',
  //      '  w : \'c\'',
  //      '}'
  //    ].join( '\n' ),
  //
  //    /*09*/
  //    [
  //      '{',
  //      '  x : ',
  //      '  {',
  //      '    c : {}',
  //      '  }',
  //      '}'
  //    ].join( '\n' ),
  //
  //    /*10*/  '',
  //
  //
  //    /*11*/  'a : 6 | b : 7 | c : 1',
  //
  //    /*12*/
  //    [
  //      'a : true, d : undefined'
  //
  //    ].join( '\n' ),
  //
  //    /*13*/
  //    [
  //      '  a : null* ',
  //      '  b : 1* ',
  //      '  c : \'2\'* ',
  //      '  d : undefined* ',
  //      '  e : true* ',
  //      '  f : {- Symbol symbol -}'
  //
  //    ].join( '\n' ),
  //
  //    /*14*/
  //    [
  //      '  a : \'true\'-> ',
  //      '  b : 2-> ',
  //      '  c : false-> ',
  //      '  d : undefined'
  //
  //    ].join( '\n' ),
  //
  //    /*15*/
  //
  //      '| e : [object Error]',
  //
  //    /*16*/
  //
  //      'f1 g[ routine f ]',
  //
  //    /*17*/
  //
  //      '',
  //
  //    /*18*/
  //    [
  //      ''
  //
  //    ].join( '\n' ),
  //
  //    /*19*/
  //
  //    '',
  //
  //    /*20*/
  //
  //    [
  //      '  i : 0.00| ',
  //      '  k : 1.00| ',
  //      '  g : 2.00| ',
  //      '  l : 3.00'
  //
  //    ].join( '\n' ),
  //
  //    /*21*/
  //
  //    [
  //      '  o : 4.000^ ',
  //      '  p : 5.000^ ',
  //      '  r : 6.000^ ',
  //      '  s : 7.000'
  //
  //    ].join( '\n' ),
  //
  //    /*22*/
  //
  //    [
  //      '  m : 8, ',
  //      '  n : 9'
  //
  //    ].join( '\n' ),
  //
  //    /*23*/
  //
  //    'x : \'\\n10\'| z : \'\\\\11\'',
  //
  //    /*24*/
  //    [
  //      '  a : 1. ',
  //      '  b : d : 2. ',
  //      '  c : 3'
  //
  //    ].join( '\n' ),
  //
  //    /*25*/
  //    [
  //      '  a : 3. ',
  //      '  b : d : 2. ',
  //      '  c : 1'
  //
  //    ].join( '\n' ),
  //
  //    /*26*/
  //    [
  //      '| a : 4@ ',
  //      '| b : d : 5@ ',
  //      '| c : 6'
  //
  //    ].join( '\n' ),
  //
  //    /*27*/
  //    [
  //      '  a - 7-? ',
  //      '  b - d - 8-? ',
  //      '  c - 9'
  //
  //    ].join( '\n' ),
  //
  //    /*28*/
  //    [
  //      '  a : 9, ',
  //      '  b : d : 8, ',
  //      '  c : 7'
  //
  //    ].join( '\n' ),
  //
  //    /*29*/
  //    [
  //      '  a : 10.0| ',
  //      '  b : d : 20.0| ',
  //      '  c : 30.0'
  //
  //    ].join( '\n' ),
  //
  //    /*30*/
  //    [
  //      '  a : 1e+1/ ',
  //      '  b : d : 2e+1/ ',
  //      '  c : 3e+1'
  //    ].join( '\n' ),
  //
  //    /*31*/
  //    [
  //      '  a : \'a\', , ',
  //      '  b : ',
  //      '    d : false, , ',
  //      '  c : 3'
  //    ].join( '\n' ),
  //
  //    /*32*/
  //    [
  //      '  a : \'\\na\'| ',
  //      '  b : d : \'\\ntrue\'| ',
  //      '  c : \'\\n\''
  //
  //    ].join( '\n' ),
  //
  //    /*33*/
  //    '',
  //
  //    /*34*/
  //    '',
  //
  //    /*35*/
  //    '  c : 1',
  //
  //    /*36*/
  //    [
  //      '',
  //    ].join( '\n' ),
  //
  //    /*37*/
  //    [
  //      '  a : 1. ',
  //      '  b : d : 2. ',
  //      '  c : 3',
  //    ].join( '\n' ),
  //
  //    /*38*/
  //    [
  //      '  |  a->3, , ',
  //      '  |  b->d->2, , ',
  //      '  |  c->1',
  //    ].join( '\n' ),
  //
  //    /*39*/
  //    [
  //      '{',
  //      '  a : \'bb\', ',
  //      '  b : { d : false }, ',
  //      '  c : 30.00000',
  //      '}'
  //
  //    ].join( '\n' ),
  //
  //    /*40*/
  //    [
  //      '{',
  //      '  a : 100.00, ',
  //      '  b : { d : 110.00 }, ',
  //      '  c : 120.00',
  //      '}'
  //
  //    ].join( '\n' ),
  //
  //    /*41*/
  //    [
  //      '{',
  //      '  a : \'\\na\', ',
  //      '  b : ',
  //      '  {',
  //      '    d : \'\\ntrue\'',
  //      '  }',
  //      '}'
  //
  //    ].join( '\n' ),
  //
  //    /*42*/
  //    [
  //      '{',
  //      '  a : \'aa\', ',
  //      '  b : {}',
  //      '}'
  //
  //    ].join( '\n' ),
  //
  //    /*43*/
  //    [
  //      '{',
  //      '  a : \'bb\', ',
  //      '  b : {}',
  //      '}'
  //
  //    ].join( '\n' ),
  //
  //    /*44*/
  //    [
  //      '{',
  //      '  b : {}, ',
  //      '  c : 1',
  //      '}'
  //
  //    ].join( '\n' ),
  //
  //    /*45*/
  //    [
  //
  //      '{',
  //      '  sequence : \'\\u001b[A\', ',
  //      '  name : \'undefined\', ',
  //      '  shift : false, ',
  //      '  code : \'[A\'',
  //      '}'
  //
  //    ].join( '\n' ),
  //
  //    /*46*/
  //    [
  //      '{',
  //      '  sequence : \'\\u007f[A\', ',
  //      '  name : \'undefined\', ',
  //      '  shift : false, ',
  //      '  code : \'[A\'',
  //      '}'
  //
  //    ].join( '\n' ),
  //
  //    /*47*/
  //    [
  //      '{',
  //      '  sequence : \'<\\u001cb>text<\\u001cb>\', ',
  //      '  data : {- Map.polluted with 2 elements -}, ',
  //      '  shift : false, ',
  //      '  code : \'<b>text<b>\'',
  //      '}'
  //
  //    ].join( '\n' ),
  //
  //    /*48*/
  //    [
  //      '{',
  //      '  sequence : \'heLLo\', ',
  //      '  shift : false, ',
  //      '  code : \'heLLo\'',
  //      '}'
  //
  //    ].join( '\n' ),
  //
  //    /*49*/
  //    [
  //      '{',
  //      '  sequence : \'\\nabc\', ',
  //      '  shift : false, ',
  //      '  code : \'abc\'',
  //      '}'
  //
  //    ].join( '\n' ),
  //
  //    /*50*/
  //    [
  //      '{',
  //      '  sequence : \'\\t[cba]\\t\', ',
  //      '  data : 100, ',
  //      '  code : \'\\n[cba]\\n\'',
  //      '}'
  //
  //    ].join( '\n' ),
  //
  //    /*51*/
  //    [
  //      '{',
  //      '  sequence : \'\\\\ABC\\\\\', ',
  //      '  data : 100, ',
  //      '  code : \'\\\\ABC\\\\\'',
  //      '}'
  //
  //    ].join( '\n' ),
  //
  //    /*52*/
  //    [
  //      '{',
  //      '  sequence : \'\\nline\\n\', ',
  //      '  data : null, ',
  //      '  code : \'\\nline\\n\'',
  //      '}'
  //
  //    ].join( '\n' ),
  //
  //    /*53*/
  //    [
  //      '{ sequence : \'\\rspace\\r\' }'
  //
  //    ].join( '\n' ),
  //
  //    /*54*/
  //    [
  //      '{ sequence : \'\\btest\' }'
  //
  //    ].join( '\n' ),
  //
  //    /*55*/
  //    [
  //      '{ sequence : \'\\u000bsample\' }'
  //
  //    ].join( '\n' ),
  //
  //    /*56*/
  //    [
  //      '{ sequence : \'\\ftest\' }'
  //
  //    ].join( '\n' ),
  //
  //    /*57*/
  //    [
  //      '{',
  //      '  b : {}, ',
  //      '  c : true',
  //      '}'
  //
  //
  //    ].join( '\n' ),
  //
  //    /*58*/
  //    [
  //      '{',
  //      '  b : {}',
  //      '}'
  //
  //
  //    ].join( '\n' ),
  //
  //    /*59*/
  //    [
  //      '{',
  //      '  a : 1000.0, ',
  //      '  b : {}, ',
  //      '  c : 1.5',
  //      '}'
  //
  //
  //    ].join( '\n' ),
  //
  //    /*60*/
  //    [
  //      '{ a : 1e+3, c : 2 }',
  //
  //    ].join( '\n' ),
  //
  //    /*61*/
  //    [
  //      '{ c : false, d : undefined, e : null }'
  //
  //    ].join( '\n' ),
  //
  //    /*62*/
  //    [
  //      '{}',
  //
  //    ].join( '\n' ),
  //
  //    /*63*/
  //    [
  //      '{ c : 3, a : 1, b : 2 }',
  //
  //    ].join( '\n' ),
  //
  //    /*64*/
  //    [
  //      '{ c : \'3\' }',
  //
  //    ].join( '\n' ),
  //
  //    /*65*/
  //    [
  //
  //      '{',
  //      '  sequence : \'\\u001b[A\', ',
  //      '  name : \'undefined\', ',
  //      '  shift : false, ',
  //      '  code : \'[A\'',
  //      '}'
  //
  //    ].join( '\n' ),
  //
  //
  //  ];
  //
  //  testFunction( test, desc, src, options, expected );

  test.case = 'default object';
  var src = { a : 1, b : 2, c : 3 };
  var got = _.entity.exportString( src, { } );
  var expected = '{ a : 1, b : 2, c : 3 }';
  test.identical( got, expected );

  test.case = 'default object, levels 0';
  var src = { x : 3, y : 5, z : 5 };
  var got = _.entity.exportString( src, { levels : 0 } );
  var expected = '{- Map.polluted with 3 elements -}';
  test.identical( got, expected );

  test.case = 'default object, levels 1';
  var src = { q : 6, w : 7, e : 8 };
  var got = _.entity.exportString( src, { levels : 1 } );
  var expected = '{ q : 6, w : 7, e : 8 }';
  test.identical( got, expected );

  test.case = 'nested object, levels 1';
  var src = { u : 12, i : { o : 13 }, p : 14 };
  var got = _.entity.exportString( src, { levels : 1 } );
  var expected =
  [
    '{',
    '  u : 12, ',
    '  i : {- Map.polluted with 1 elements -}, ',
    '  p : 14',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object, levels 2';
  var src = { r : 9, t : { a : 10 }, y : 11 };
  var got = _.entity.exportString( src, { levels : 2 } );
  var expected =
  [
    '{',
    '  r : 9, ',
    '  t : { a : 10 }, ',
    '  y : 11',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object, levels 3';
  var src = { z : '01', x : { c : { g : 4 } }, v : '03' };
  var got = _.entity.exportString( src, { levels : 3 } );
  var expected =
  [
    '{',
    '  z : \'01\', ',
    '  x : ',
    '  {',
    '    c : { g : 4 }',
    '  }, ',
    '  v : \'03\'',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object, levels 5';
  var src = { u : 12, i : { o : { x : { y : [ 1, 2, 3 ] } } }, p : 14 };
  var got = _.entity.exportString( src, { levels : 5 } );
  var expected =
  [
    '{',
    '  u : 12, ',
    '  i : ',
    '  {',
    '    o : ',
    '    {',
    '      x : ',
    '      {',
    '        y : [ 1, 2, 3 ]',
    '      }',
    '    }',
    '  }, ',
    '  p : 14',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object, noSubObject noArray';
  var src = { q : { a : 1 }, w : 'c', e : [1] };
  var got = _.entity.exportString( src, { levels : 2, noSubObject : 1, noArray : 1 } );
  var expected =
  [
    '{',
    '  w : \'c\'',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object, noAtomic';
  var src = { z : '02', x : { c : { g : 6 } }, v : '01' };
  var got = _.entity.exportString( src, { levels : 3, noAtomic : 1 } );
  var expected =
  [
    '{',
    '  x : ',
    '  {',
    '    c : {}',
    '  }',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object, noObject';
  var src = { h : { d : 1 }, g : 'c', c : [2] };
  var got = _.entity.exportString( src, { levels : 2, noObject : 1 } );
  var expected = '';
  test.identical( got, expected );

  test.case = 'default object, wrap 0 modified comma';
  var src = { a : 6, b : 7, c : 1 };
  var got = _.entity.exportString( src, { wrap : 0, comma : ' | ' } );
  var expected = 'a : 6 | b : 7 | c : 1';
  test.identical( got, expected );

  test.case = 'default object, wrap 0 noString noNumber';
  var src = { a : true, b : '2', c : 3, d : undefined };
  var got = _.entity.exportString( src, { wrap : 0, noString : 1, noNumber: 1, comma : ', ' } );
  var expected = 'a : true, d : undefined';
  test.identical( got, expected );

  test.case = 'object with symbol, wrap 0';
  var src = { a : null, b : 1, c : '2', d : undefined, e : true, f : Symbol( 'symbol' ) };
  var got = _.entity.exportString( src, { wrap : 0, comma : '* ' } );
  var expected =
  [
    '  a : null* ',
    '  b : 1* ',
    '  c : \'2\'* ',
    '  d : undefined* ',
    '  e : true* ',
    '  f : {- Symbol symbol -}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'default object, wrap 0 prependTab 0 modified comma';
  var src = { a : 'true', b : 2, c : false, d : undefined };
  var got = _.entity.exportString( src, { wrap : 0, prependTab : 0, comma : '-> ' } );
  var expected =
  [
    '  a : \'true\'-> ',
    '  b : 2-> ',
    '  c : false-> ',
    '  d : undefined'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'object with error, wrap 0';
  var src = { e : new Error( 'msg' ) };
  var got = _.entity.exportString( src, { wrap : 0, tab : '| ', dtab : '', comma : '> ' } );
  var expected = '| e : [object Error]';
  test.identical( got, expected );

  test.case = 'object with a function, wrap 0';
  var src = { f : 1, g : function f(  ) { } };
  var got = _.entity.exportString( src, { wrap : 0, colon : '', comma : ' ' } );
  var expected = 'f1 g[ routine f ]';
  test.identical( got, expected );

  test.case = 'object with a function, wrap 0 noRoutine';
  var src = { x : function y(  ) { } };
  var got = _.entity.exportString( src, { wrap : 0, noRoutine : 1, comma : '.. ' } );
  var expected = '';
  test.identical( got, expected );

  test.case = 'default object, wrap 0 noAtomic';
  var src = { a : null, b : 1, c : '2', d : undefined };
  var got = _.entity.exportString( src, { wrap : 0, noAtomic : 1, comma : ', ' } );
  var expected = '';
  test.identical( got, expected );

  test.case = 'object with a function, onlyRoutines';
  var src = { e : function r( ) { }, f : 1, g : '2', h : [ 1 ] };
  var got = _.entity.exportString( src, { wrap : 0, onlyRoutines : 1, comma : '<< ' } );
  var expected = '';
  test.identical( got, expected );

  test.case = 'integer object values, precision 3 wrap 0';
  var src = { i : 0, k : 1, g : 2, l : 3 };
  var got = _.entity.exportString( src, { wrap : 0, precision : 3, comma : '| ' } );
  var expected =
  [
    '  i : 0.00| ',
    '  k : 1.00| ',
    '  g : 2.00| ',
    '  l : 3.00'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'integer values, wrap 0 fixed 3';
  var src = { o : 4, p : 5, r : 6, s : 7 };
  var got = _.entity.exportString( src, { wrap : 0,  fixed : 3, comma : '^ ' } );
  var expected =
  [
    '  o : 4.000^ ',
    '  p : 5.000^ ',
    '  r : 6.000^ ',
    '  s : 7.000'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'integer values, multiline';
  var src = { m : 8, n : 9 };
  var got = _.entity.exportString( src, { wrap : 0,  multiline : 1, comma : ', ' } );
  var expected =
  [
    '  m : 8, ',
    '  n : 9'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'object new lines, escaping';
  var src = { x : '\n10', z : '\\11' };
  var got = _.entity.exportString( src, { wrap : 0,  escaping : 1, comma : '| ' } );
  var expected = 'x : \'\\n10\'| z : \'\\\\11\'';
  test.identical( got, expected );

  test.case = 'nested object';
  var src = { a : 1, b : { d : 2 }, c : 3 };
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, comma : '. ' } );
  var expected =
  [
    '  a : 1. ',
    '  b : d : 2. ',
    '  c : 3'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object';
  var src = { a : 3, b : { d : 2 }, c : 1 };
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, comma : '. '} );
  var expected =
  [
    '  a : 3. ',
    '  b : d : 2. ',
    '  c : 1'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object, modified tab';
  var src = { a : 4, b : { d : 5 }, c : 6 };
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, tab : '| ', dtab : '', comma : '@ ' } );
  var expected =
  [
    '| a : 4@ ',
    '| b : d : 5@ ',
    '| c : 6'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object';
  var src = { a : 7, b : { d : 8 }, c : 9 };
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, colon : ' - ', comma : '-? ' } );
  var expected =
  [
    '  a - 7-? ',
    '  b - d - 8-? ',
    '  c - 9'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object';
  var src = { a : 9, b : { d : 8 }, c : 7 };
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, prependTab : 0, comma : ', ' } );
  var expected =
  [
    '  a : 9, ',
    '  b : d : 8, ',
    '  c : 7'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object, fixed 1';
  var src = { a : 10, b : { d : 20 }, c : 30 };
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, fixed : 1, comma : '| ' } );
  var expected =
  [
    '  a : 10.0| ',
    '  b : d : 20.0| ',
    '  c : 30.0'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object, precision 1';
  var src = { a : 10.00, b : { d : 20.00 }, c : 30.00 };
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, precision : 1, comma : '/ ' } );
  var expected =
  [
    '  a : 1e+1/ ',
    '  b : d : 2e+1/ ',
    '  c : 3e+1'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object, multiline';
  var src = { a : 'a', b : { d : false }, c : 3 };
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, multiline : 1, comma : ', , ' } );
  var expected =
  [
    '  a : \'a\', , ',
    '  b : ',
    '    d : false, , ',
    '  c : 3'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object, escaping 1';
  var src = { a : '\na', b : { d : '\ntrue' }, c : '\n' };
  var got = _.entity.exportString( src, { levels : 3, wrap : 0, escaping : 1, comma : '| ' } );
  var expected =
  [
    '  a : \'\\na\'| ',
    '  b : d : \'\\ntrue\'| ',
    '  c : \'\\n\''
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object, noAtomic';
  var src = { a : 'a', b : { d : false }, c : 3 };
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, noAtomic : 1, comma : '< ' } );
  var expected = '';
  test.identical( got, expected );

  test.case = 'nestedObject, noAtomic';
  var src = { a : 'aa', b : { d : true }, c : 40 };
  var got = _.entity.exportString( src, { levels : 3, wrap : 0, noAtomic : 1, comma : ', ' } );
  var expected = '';
  test.identical( got, expected );

  test.case = 'nestedObject, noSubObject noArray';
  var src = { a : [ 'a', 'b' ], b : { d : 'true' }, c : 1 };
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, noSubObject : 1, noArray : 1, comma : '' } );
  var expected = '  c : 1';
  test.identical( got, expected );

  test.case = 'nested object, noString noNumber';
  var src = { a : [ 'a', 'b' ], b : { d : 'true' }, c : 1 };
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, noString : 1, noNumber : 1, comma : '. ' } );
  var expected = '';
  test.identical( got, expected );

  test.case = 'nested object';
  var src = { a : 1, b : { d : 2 }, c : 3 };
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, comma : '. '} );
  var expected =
  [
    '  a : 1. ',
    '  b : d : 2. ',
    '  c : 3',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object, double comma';
  var src = { a : 3, b : { d : 2 }, c : 1 };
  var got = _.entity.exportString( src, { levels : 2, wrap : 0, comma : ', , ', tab :'  |', colon : '->' } );
  var expected =
  [
    '  |  a->3, , ',
    '  |  b->d->2, , ',
    '  |  c->1',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object, prependTab 0 fixed 5';
  var src = { a : 'bb', b : { d : false }, c : 30 };
  var got = _.entity.exportString( src, { levels : 2, prependTab : 0, fixed : 5 } );
  var expected =
  [
    '{',
    '  a : \'bb\', ',
    '  b : { d : false }, ',
    '  c : 30.00000',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object, prependTab 0 precision 5';
  var src = { a : 100, b : { d : 110 }, c : 120 };
  var got = _.entity.exportString( src, { levels : 2, prependTab : 0, precision : 5 } );
  var expected =
  [
    '{',
    '  a : 100.00, ',
    '  b : { d : 110.00 }, ',
    '  c : 120.00',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object, multiline escaping';
  var src = { a : '\na', b : { d : '\ntrue' } };
  var got = _.entity.exportString( src, { levels : 2, multiline : 1, escaping : 1 } );
  var expected =
  [
    '{',
    '  a : \'\\na\', ',
    '  b : ',
    '  {',
    '    d : \'\\ntrue\'',
    '  }',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object with function, noRoutine';
  var src = { a : 'aa', b : { d : function( ){ } } };
  var got = _.entity.exportString( src, { levels : 2, noRoutine : 1 } );
  var expected =
  [
    '{',
    '  a : \'aa\', ',
    '  b : {}',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object with function, noRoutine';
  var src = { a : 'bb', b : { d : function( ){ } } };
  var got = _.entity.exportString( src, { levels : 3, noRoutine : 1, } );
  var expected =
  [
    '{',
    '  a : \'bb\', ',
    '  b : {}',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object with date and error, noError noDate';
  var src = { a : new Date( Date.UTC( 1993, 12, 12 ) ), b : { d : new Error( 'msg' ) }, c : 1 };
  var got = _.entity.exportString( src, { levels : 3, noError : 1, noDate : 1 } );
  var expected =
  [
    '{',
    '  b : {}, ',
    '  c : 1',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'object json like, escaping 1';
  var src = { 'sequence' : '\u001b[A', 'name' : 'undefined', 'shift' : false, 'code' : '[A'  };
  var got = _.entity.exportString( src, { escaping : 1 } );
  var expected =
  [
    '{',
    '  sequence : \'\\u001b[A\', ',
    '  name : \'undefined\', ',
    '  shift : false, ',
    '  code : \'[A\'',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'object json like, escaping 0';
  var src = { 'sequence' : '\x7f[A', 'name' : 'undefined', 'shift' : false, 'code' : '[A'  };
  var got = _.entity.exportString( src, { escaping : 0 } );
  var expected =
  [
    '{',
    '  sequence : \'\\u007f[A\', ',
    '  name : \'undefined\', ',
    '  shift : false, ',
    '  code : \'[A\'',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object json like, escaping 0';
  var src = { 'sequence' : '<\u001cb>text<\u001cb>', 'data' : { 'name' : 'myname', 'age' : 1 }, 'shift' : false, 'code' : '<b>text<b>'  };
  var got = _.entity.exportString( src, { escaping : 0 } );
  var expected =
  [
    '{',
    '  sequence : \'<\\u001cb>text<\\u001cb>\', ',
    '  data : {- Map.polluted with 2 elements -}, ',
    '  shift : false, ',
    '  code : \'<b>text<b>\'',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'object json like, multiline';
  var src = { 'sequence' : '\u0068\u0065\u004C\u004C\u006F', 'shift' : false, 'code' : 'heLLo'  };
  var got = _.entity.exportString( src, { multiline : 1 } );
  var expected =
  [
    '{',
    '  sequence : \'heLLo\', ',
    '  shift : false, ',
    '  code : \'heLLo\'',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'object json like, multiline escaping';
  var src = { 'sequence' : '\n\u0061\u0062\u0063', 'shift' : false, 'code' : 'abc'  };
  var got = _.entity.exportString( src, { levels : 2, multiline : 1, escaping : 1 } );
  var expected =
  [
    '{',
    '  sequence : \'\\nabc\', ',
    '  shift : false, ',
    '  code : \'abc\'',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'object json like, multiline escaping';
  var src = { 'sequence' : '\t\u005b\u0063\u0062\u0061\u005d\t', 'data' : 100, 'code' : '\n[cba]\n'  };
  var got = _.entity.exportString( src, { levels : 2, multiline : 1, escaping : 1 } );
  var expected =
  [
    '{',
    '  sequence : \'\\t[cba]\\t\', ',
    '  data : 100, ',
    '  code : \'\\n[cba]\\n\'',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'object json like, multiline escaping';
  var src = { 'sequence' : '\u005CABC\u005C', 'data' : 100, 'code' : '\\ABC\\'  };
  var got = _.entity.exportString( src, { levels : 2, multiline : 1, escaping : 1 } );
  var expected =
  [
    '{',
    '  sequence : \'\\\\ABC\\\\\', ',
    '  data : 100, ',
    '  code : \'\\\\ABC\\\\\'',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'object json like, multiline escaping';
  var src = { 'sequence' : '\u000Aline\u000A', 'data' : null, 'code' : '\nline\n'  };
  var got = _.entity.exportString( src, { levels : 2, multiline : 1, escaping : 1 } );
  var expected =
  [
    '{',
    '  sequence : \'\\nline\\n\', ',
    '  data : null, ',
    '  code : \'\\nline\\n\'',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'object json like, escaping levels 2';
  var src = { 'sequence' : '\rspace\r',  };
  var got = _.entity.exportString( src, { levels : 2, escaping : 1 } );
  var expected = '{ sequence : \'\\rspace\\r\' }';
  test.identical( got, expected );

  test.case = 'object json like, escaping';
  var src = { 'sequence' : '\btest',  };
  var got = _.entity.exportString( src, { levels : 2, escaping : 1 } );
  var expected = '{ sequence : \'\\btest\' }';
  test.identical( got, expected );

  test.case = 'object json like, escaping';
  var src = { 'sequence' : '\vsample',  };
  var got = _.entity.exportString( src, { levels : 2, escaping : 1 } );
  // var expected = `{ sequence : '\\vsample' }`;
  var expected = `{ sequence : '\\u000bsample' }`;
  test.identical( got, expected );

  test.case = 'object json like, escaping';
  var src = { 'sequence' : '\ftest',  };
  var got = _.entity.exportString( src, { levels : 2, escaping : 1 } );
  var expected = '{ sequence : \'\\ftest\' }';
  test.identical( got, expected );

  test.case = 'nested object, noNumber noString';
  var src = { a : 1, b : { d : 'string' }, c : true };
  var got = _.entity.exportString( src, { levels : 3, noNumber : 1, noString : 1} );
  var expected =
  [
    '{',
    '  b : {}, ',
    '  c : true',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object, noNumber noString noDate';
  var src = { a : 1, b : { d : 'string' }, c : new Date(Date.UTC( ) ) };
  var got = _.entity.exportString( src, { levels : 3, noNumber : 1, noString : 1, noDate : 1} );
  var expected =
  [
    '{',
    '  b : {}',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested object, noString fixed 1';
  var src = { a : 1000, b : { d : 'string' }, c : 1.500 };
  var got = _.entity.exportString( src, { levels : 2, noString : 1, fixed : 1} );
  var expected =
  [
    '{',
    '  a : 1000.0, ',
    '  b : {}, ',
    '  c : 1.5',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'object, noString precision 1';
  var src = { a : 1000, b : 'text', c : 1.500 };
  var got = _.entity.exportString( src, { levels : 2, noString : 1, precision : 1} );
  var expected = '{ a : 1e+3, c : 2 }';
  test.identical( got, expected );

  test.case = 'object, noString noNumber prependTab 0';
  var src = { a : 1000, b : 'text', c : false, d : undefined, e : null};
  var got = _.entity.exportString( src, { levels : 2, noString : 1, noNumber :1, tab : '-', prependTab : 0 } );
  var expected = '{ c : false, d : undefined, e : null }';
  test.identical( got, expected );

  test.case = 'object, noAtomic noNumber 0';
  var src = { a : 1001, b : 'text', c : false, d : undefined, e : null};
  var got = _.entity.exportString( src, { levels : 2, noAtomic : 1, noNumber : 0 } );
  var expected = '{}';
  test.identical( got, expected );

  test.case = 'return object, own 0';
  var src =
  ( function( )
  {
    var x = { a : 1, b : 2 },
    y = Object.create( x );
    y.c = 3;
    return y;
  } )( );
  var got = _.entity.exportString( src, { onlyOwn : 0 } );
  var expected = '{ c : 3, a : 1, b : 2 }';
  test.identical( got, expected );

  test.case = 'return object';
  var src =
  ( function( )
  {
    var x = { a : '0', b : '1' },
    y = Object.create( x );
    y.c = '3';
    return y;
  } )( );
  var got = _.entity.exportString( src, { } );
  var expected = '{ c : \'3\' }';
  test.identical( got, expected );

  test.case = 'object json like';
  var src = { 'sequence' : '\u001b[A', 'name' : 'undefined', 'shift' : false, 'code' : '[A'  };
  var got = _.entity.exportString( src, { } );
  var expected =
  [
    '{',
    '  sequence : \'\\u001b[A\', ',
    '  name : \'undefined\', ',
    '  shift : false, ',
    '  code : \'[A\'',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

}

//

function exportStringStringWrapper( test )
{
  //   var desc = 'stringWrapper test',
  //   src =
  //   [
  //     /*01*/ { a : 'string', b : 1, c : null , d : undefined },
  //     /*02*/ { a : 'sample', b : 0, c : false , d : [ 'a' ] },
  //     /*03*/ { a : [ 'example' ], b : 1, c : null , d : [ 'b' ] },
  //     /*04*/ { a : 'test', b : new Error( 'err' ) },
  //     /*05*/ { a : 'a', b : 'b', c : { d : 'd' } },
  //     /*06*/ { a : { h : 'a' }, b : 'b', c : { d : 'd' } },
  //     /*07*/ { a : 'line1\nline2\nline3' },
  //     /*08*/ { a : 'line1' },
  //   ],
  //   options =
  //   [
  //     /*01*/ { stringWrapper : '' },
  //     /*02*/ { levels : 2, stringWrapper : '' },
  //     /*03*/ { levels : 3, stringWrapper : '' },
  //     /*04*/ { levels : 2 },
  //     /*05*/ { stringWrapper: '', levels : 1 },
  //     /*06*/ { stringWrapper: '', levels : 2 },
  //     /*07*/ { levels : 2, multilinedString : 1 },
  //     /*08*/ { levels : 2, multilinedString : 1 },
  //   ],
  //
  //   expected =
  //   [
  //    /*01*/
  //      [
  //
  //       '{',
  //       '  a : string, ',
  //       '  b : 1, ',
  //       '  c : null, ',
  //       '  d : undefined',
  //       '}'
  //
  //     ].join( '\n' ),
  //
  //    /*02*/
  //      [
  //
  //       '{',
  //       '  a : sample, ',
  //       '  b : 0, ',
  //       '  c : false, ',
  //       '  d : [ a ]',
  //       '}'
  //
  //     ].join( '\n' ),
  //
  //    /*03*/
  //      [
  //
  //       '{',
  //       '  a : [ example ], ',
  //       '  b : 1, ',
  //       '  c : null, ',
  //       '  d : [ b ]',
  //       '}'
  //
  //     ].join( '\n' ),
  //
  //    /*04*/
  //      [
  //
  //       '{',
  //       '  a : \'test\', ',
  //       '  b : Error: err',
  //       '}'
  //
  //     ].join( '\n' ),
  //
  //    /*05*/
  //      [
  //
  //       '{',
  //       '  a, ',
  //       '  b, ',
  //       '  c : {- Map.polluted with 1 elements -}',
  //       '}'
  //
  //     ].join( '\n' ),
  //
  //    /*06*/
  //    [
  //
  //       '{',
  //       '  a : { h : a }, ',
  //       '  b, ',
  //       '  c : { d }',
  //       '}'
  //
  //     ].join( '\n' ),
  //
  //    /*07*/
  //    [
  //
  //       '{',
  //       '  a : `line1',
  //       'line2',
  //       'line3`',
  //       '}'
  //
  //     ].join( '\n' ),
  //
  //    /*08*/
  //    [
  //
  //       '{ a : `line1` }',
  //
  //      ].join( '\n' ),
  //
  //   ]
  //
  //testFunction( test, desc, src, options, expected );

  test.case = 'stringWrapper no quotes';
  var got = _.entity.exportString( { a : 'string', b : 1, c : null , d : undefined } , { stringWrapper : '' } );
  var expected =
  [
    '{',
    '  a : string, ',
    '  b : 1, ',
    '  c : null, ',
    '  d : undefined',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'stringWrapper no quotes, levels 2';
  var src = { a : 'sample', b : 0, c : false , d : [ 'a' ] };
  var got = _.entity.exportString( src, { levels : 2, stringWrapper : '' } );
  var expected =
  [
    '{',
    '  a : sample, ',
    '  b : 0, ',
    '  c : false, ',
    '  d : [ a ]',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'stringWrapper no quotes, levels 3';
  var src = { a : [ 'example' ], b : 1, c : null , d : [ 'b' ] };
  var got = _.entity.exportString( src, { levels : 3, stringWrapper : '' } );
  var expected =
  [
    '{',
    '  a : [ example ], ',
    '  b : 1, ',
    '  c : null, ',
    '  d : [ b ]',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'stringWrapper with error';
  var src = { a : 'test', b : new Error( 'err' ) };
  var got = _.entity.exportString( src, { levels : 2 } );
  var expected =
  [
    `{ a : 'test', b : Error: err }`,
    // '{',
    // '  a : \'test\', ',
    // '  b : Error: err',
    // '}'
  ].join( '\n' );
  test.identical( got, expected );

  // test.case = 'stringWrapper with object, levels 1'; // Dmytro : old test case, if key and value is identical, then routine write only key
  // var src = { a : 'a', b : 'b', c : { d : 'd' } };
  // var got = _.entity.exportString( src, { stringWrapper: '', levels : 1 } );
  // var expected =
  // [
  //   '{',
  //   '  a, ',
  //   '  b, ',
  //   '  c : {- Map.polluted with 1 elements -}',
  //   '}'
  // ].join( '\n' );
  // test.identical( got, expected );

  test.case = 'stringWrapper with object, levels 1'; // Dmytro : new test case, if key and value is identical, routine write key and value
  var src = { a : 'a', b : 'b', c : { d : 'd' } };
  var got = _.entity.exportString( src, { stringWrapper: '', levels : 1 } );
  var expected =
  [
    '{',
    '  a : a, ',
    '  b : b, ',
    '  c : {- Map.polluted with 1 elements -}',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  // test.case = 'stringWrapper with objects, levels 2'; // Dmytro : old test case, if key and value is identical, then routine write only key
  // var src = { a : { h : 'a' }, b : 'b', c : { d : 'd' } };
  // var got = _.entity.exportString( src, { stringWrapper: '', levels : 2 } );
  // var expected =
  // [
  //   '{',
  //   '  a : { h : a }, ',
  //   '  b, ',
  //   '  c : { d }',
  //   '}'
  // ].join( '\n' );
  // test.identical( got, expected );

  test.case = 'stringWrapper with objects, levels 2'; // Dmytro : new test case, if key and value is identical, routine write key and value
  var src = { a : { h : 'a' }, b : 'b', c : { d : 'd' } };
  var got = _.entity.exportString( src, { stringWrapper: '', levels : 2 } );
  var expected =
  [
    '{',
    '  a : { h : a }, ',
    '  b : b, ',
    '  c : { d : d }',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'stringWrapper multiline \\n, levels 2';
  var src = { a : 'line1\nline2\nline3' };
  var got = _.entity.exportString( src, { levels : 2, multilinedString : 1 } );
  var expected =
  [
    '{',
    '  a : `line1',
    'line2',
    'line3`',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'stringWrapper multiline, levels 2';
  var src = { a : 'line1' };
  var got = _.entity.exportString( src, { levels : 2, multilinedString : 1 } );
  var expected = '{ a : `line1` }';
  test.identical( got, expected );

}

//

function exportStringLevel( test )
{
  //   var desc = 'level test',
  //   src =
  //   [
  //     /*01*/ { a : 'a', b : 'b', c : { d : 'd' } },
  //     /*02*/ { a : { h : 'a' }, b : 'b', c : { d : 'd' } },
  //     /*03*/ { a : [ 'example' ], b : 1, c : null , d : [ 'b' ] },
  //     /*04*/ { a : 'a', b : 'b', c : { d : 'd' } },
  //   ],
  //   options =
  //   [
  //     /*01*/ { level: 0, levels : 0 },
  //     /*02*/ { level: 1, levels : 2 },
  //     /*03*/ { level: 1, levels : 0 },
  //     /*04*/ { },
  //   ],
  //
  //   expected =
  //   [
  //    /*01*/
  //      [
  //       '{- Map.polluted with 3 elements -}',
  //      ].join( '\n' ),
  //
  //    /*02*/
  //      [
  //       '{',
  //       '  a : {- Map.polluted with 1 elements -}, ',
  //       '  b : \'b\', ',
  //       '  c : {- Map.polluted with 1 elements -}',
  //       '}'
  //
  //      ].join( '\n' ),
  //
  //    /*03*/
  //      [
  //       '{- Map.polluted with 4 elements -}',
  //      ].join( '\n' ),
  //
  //    /*04*/
  //      [
  //       '{',
  //       '  a : \'a\', ',
  //       '  b : \'b\', ',
  //       '  c : {- Map.polluted with 1 elements -}',
  //       '}',
  //
  //      ].join( '\n' ),
  //
  //   ]
  //  testFunction( test, desc, src, options, expected );

  test.case = 'nested objects, level 0 and levels 0';
  var src = { a : 'a', b : 'b', c : { d : 'd' } };
  var got = _.entity.exportString( src, { level: 0, levels : 0 } );
  var expected = '{- Map.polluted with 3 elements -}';
  test.identical( got, expected );

  test.case = 'nested objects, level 1 levels 2';
  var src = { a : { h : 'a' }, b : 'b', c : { d : 'd' } };
  var got = _.entity.exportString( src, { level: 1, levels : 2 } );
  var expected =
  [
    '{',
    '  a : {- Map.polluted with 1 elements -}, ',
    '  b : \'b\', ',
    '  c : {- Map.polluted with 1 elements -}',
    '}'
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'nested objects, level 1 levels 0';
  var src = { a : [ 'example' ], b : 1, c : null , d : [ 'b' ] };
  var got = _.entity.exportString( src, { level: 1, levels : 0 } );
  var expected = '{- Map.polluted with 4 elements -}';
  test.identical( got, expected );

  test.case = 'nested objects';
  var src = { a : 'a', b : 'b', c : { d : 'd' } };
  var got = _.entity.exportString( src, { } );
  var expected =
  [
    '{',
    '  a : \'a\', ',
    '  b : \'b\', ',
    '  c : {- Map.polluted with 1 elements -}',
    '}',
  ].join( '\n' );
  test.identical( got, expected );

}

//

function exportStringEnumerable( test )
{
  //   var desc = 'onlyEnumerable test',
  //   src =
  //   [
  //     /*01*/ ( function( )
  //            {
  //             var x = Object.create( {},
  //              {
  //                getFoo:
  //                {
  //                  value: function( ) { return this.foo; },
  //                  enumerable: false
  //                }
  //              } );
  //
  //             x.foo = 1;
  //
  //             var y = Object.create( x );
  //             y.a = 'string';
  //
  //             return y;
  //
  //            } )( ),
  //
  //     /*02*/ ( function( )
  //            {
  //             var x = Object.create( {},
  //              {
  //                getFoo:
  //                {
  //                  value: function( ) { return this.foo; },
  //                  enumerable: false
  //                }
  //              } );
  //
  //             x.foo = 1;
  //
  //             var y = Object.create( x );
  //             y.a = 'string';
  //
  //             return y;
  //
  //            } )( ),
  //
  //     /*03*/ ( function( )
  //            {
  //             var x = Object.create( {},
  //              {
  //                getFoo:
  //                {
  //                  value: function( ) { return this.foo; },
  //                  enumerable: false
  //                }
  //              } );
  //
  //             x.foo = 1;
  //
  //             return x;
  //
  //            } )( ),
  //
  //      /*04*/ ( function( )
  //      {
  //        var x = Object.create( {},
  //          {
  //            getFoo:
  //            {
  //              value: function( ) { return this.foo; },
  //              enumerable: false
  //            }
  //          } );
  //
  //          x.foo = 1;
  //
  //          var y = Object.create( x );
  //          y.a = 'string';
  //
  //          return y;
  //
  //        } )( ),
  //
  //   ],
  //   options =
  //   [
  //     /*01*/ {  }, //own :1, onlyEnumerable:1
  //     /*02*/ { own : 0 }, //own :0, onlyEnumerable:1
  //     /*03*/ { onlyEnumerable : 0 }, //own :1, onlyEnumerable:0
  //     /*04*/ { own : 0, onlyEnumerable : 0 },
  //   ],
  //   expected =
  //   [
  //    /*01*/
  //      [
  //       '{ a : \'string\' }'
  //      ].join( '\n' ),
  //
  //    /*02*/
  //      [
  //       '{ a : \'string\', foo : 1 }'
  //      ].join( '\n' ),
  //
  //    /*03*/
  //      [
  //       '{ getFoo : [ routine value ], foo : 1 }'
  //      ].join( '\n' ),
  //
  //    /*04*/
  //      [
  //        '{',
  //        '  a : \'string\', ',
  //        '  getFoo : [ routine value ], ',
  //        '  foo : 1, ',
  //        '  constructor : [ routine Object ], ',
  //        '  __defineGetter__ : [ routine __defineGetter__ ], ',
  //        '  __defineSetter__ : [ routine __defineSetter__ ], ',
  //        '  hasOwnProperty : [ routine hasOwnProperty ], ',
  //        '  __lookupGetter__ : [ routine __lookupGetter__ ], ',
  //        '  __lookupSetter__ : [ routine __lookupSetter__ ], ',
  //        '  isPrototypeOf : [ routine isPrototypeOf ], ',
  //        '  propertyIsEnumerable : [ routine propertyIsEnumerable ], ',
  //        '  toString : [ routine toString ], ',
  //        '  valueOf : [ routine valueOf ], ',
  //        '  __proto__ : {- Map.polluted with 1 elements -}, ',
  //        '  toLocaleString : [ routine toLocaleString ]',
  //        '}',
  //      ].join( '\n' ),
  //   ]
  //  testFunction( test, desc, src, options, expected );

  test.case = 'enumerable';
  var src =
  ( function( )
  {
    var x = Object.create( {},
    {
      getFoo:
      {
        value: function( ) { return this.foo; },
        enumerable: false
      }
    } );

    x.foo = 1;

    var y = Object.create( x );
    y.a = 'string';

    return y;

  } )( );
  var got = _.entity.exportString( src, { } );
  var expected = '{ a : \'string\' }';
  test.identical( got, expected );

  test.case = 'enumerable, own 0';
  var src =
  ( function( )
  {
    var x = Object.create( {},
    {
      getFoo:
      {
        value: function( ) { return this.foo; },
        enumerable: false
      }
    } );

    x.foo = 1;

    var y = Object.create( x );
    y.a = 'string';

    return y;

  } )( );
  var got = _.entity.exportString( src, { onlyOwn : 0 } );
  var expected = '{ a : \'string\', foo : 1 }';
  test.identical( got, expected );

  test.case = 'enumerable, onlyEnum 0';
  var src =
  ( function( )
  {
    var x = Object.create( {},
    {
      getFoo:
      {
        value: function( ) { return this.foo; },
        enumerable: false
      }
    } );

    x.foo = 1;

    return x;

  } )( );
  var got = _.entity.exportString( src, { onlyEnumerable : 0 } );
  var expected = '{ getFoo : [ routine value ], foo : 1 }';
  test.identical( got, expected );

  test.case = 'enumerable, onlyEnum 0 own 0';
  var src =
  ( function( )
  {
    var x = Object.create( {},
    {
      getFoo:
      {
        value: function( ) { return this.foo; },
        enumerable: false
      }
    } );

    x.foo = 1;

    var y = Object.create( x );
    y.a = 'string';

    return y;

  } )( );
  var got = _.entity.exportString( src, { onlyOwn : 0, onlyEnumerable : 0 } );
  var expected =
  [
    '{',
    '  a : \'string\', ',
    '  getFoo : [ routine value ], ',
    '  foo : 1, ',
    '  constructor : [ routine Object ], ',
    '  __defineGetter__ : [ routine __defineGetter__ ], ',
    '  __defineSetter__ : [ routine __defineSetter__ ], ',
    '  hasOwnProperty : [ routine hasOwnProperty ], ',
    '  __lookupGetter__ : [ routine __lookupGetter__ ], ',
    '  __lookupSetter__ : [ routine __lookupSetter__ ], ',
    '  isPrototypeOf : [ routine isPrototypeOf ], ',
    '  propertyIsEnumerable : [ routine propertyIsEnumerable ], ',
    '  toString : [ routine toString ], ',
    '  valueOf : [ routine valueOf ], ',
    '  __proto__ : {- Aux.polluted.prototyped with 1 elements -}, ',
    '  toLocaleString : [ routine toLocaleString ]',
    '}',
  ].join( '\n' );
  test.identical( got, expected );

}

// xxx

function exportStringEmptyArgs( test )
{
  //  var desc = 'empty arguments',
  //  src = [ {}, '', [] ],
  //  options = [ {} ],
  //  expected =[ '{}', '\'\'', '[]' ];
  //
  //  testFunction( test, desc, src, options, expected );

  test.case = 'empty arguments, object';
  var got = _.entity.exportString( { }, { } );
  var expected = '{}';
  test.identical( got, expected );

  test.case = 'empty arguments, string';
  var got = _.entity.exportString( '', { } );
  var expected = '\'\'';
  test.identical( got, expected );

  test.case = 'empty arguments, array';
  var got = _.entity.exportString( [], { } );
  var expected = '[]';
  test.identical( got, expected );

}

//

function exportStringSymbol( test )
{
  //  var desc = 'Symbol test',
  //  src =
  //  [
  //    Symbol( ),
  //    Symbol( 'sm' ),
  //    Symbol( 'sx' ),
  //    Symbol( 'sy' )
  //  ],
  //  options =
  //  [
  //    {},
  //    {},
  //    { levels : 0 },
  //    { noAtomic : 1 },
  //
  //  ],
  //  expected =
  //  [
  //    '{- Symbol -}',
  //    '{- Symbol sm -}',
  //    '{- Symbol sx -}',
  //    ''
  //  ]
  //
  //  testFunction( test, desc, src, options, expected );

  test.case = 'symbol';
  var got = _.entity.exportString( Symbol( ), { } );
  var expected = '{- Symbol -}';
  test.identical( got, expected );

  test.case = 'symbol sm';
  var got = _.entity.exportString( Symbol( 'sm' ), { } );
  var expected = '{- Symbol sm -}';
  test.identical( got, expected );

  test.case = 'symbol sx, level 0';
  var got = _.entity.exportString( Symbol( 'sx' ), { levels : 0 } );
  var expected = '{- Symbol sx -}';
  test.identical( got, expected );

  test.case = 'symbol sy, noAtomic';
  var got = _.entity.exportString( Symbol( 'sy' ), { noAtomic : 1 } );
  var expected = '';
  test.identical( got, expected );

}

//

function exportStringNumber( test )
{
  //  var desc = 'Number test',
  //  src =
  //  [
  //    Number( ),
  //    5,
  //    15000,
  //    1222.222,
  //    1234.4321,
  //    15,
  //    99,
  //    22
  //  ],
  //  options =
  //  [
  //    {},
  //    {},
  //    { precision : 3 },
  //    { fixed : 1 },
  //    { noNumber : 1 },
  //    { noAtomic : 1 },
  //    { levels : 0 },
  //    { noRoutine : 1 }
  //  ],
  //  expected =
  //  [
  //    '0',
  //    '5',
  //    '1.50e+4',
  //    '1222.2',
  //    '',
  //    '',
  //    '99',
  //    '22'
  //  ]
  //
  //  testFunction( test, desc, src, options, expected );

  test.case = 'number';
  var got = _.entity.exportString( Number( ), { } );
  var expected = '0';
  test.identical( got, expected );

  test.case = 'integer';
  var got = _.entity.exportString( 5, { } );
  var expected = '5';
  test.identical( got, expected );

  test.case = 'number, precision 3';
  var got = _.entity.exportString( 15000, { precision : 3 } );
  var expected = '1.50e+4';
  test.identical( got, expected );

  test.case = 'float number, fixed 1';
  var got = _.entity.exportString( 1222.222, { fixed : 1 } );
  var expected = '1222.2';
  test.identical( got, expected );

  test.case = 'float number, noNumber';
  var got = _.entity.exportString( 1234.4321, { noNumber : 1 } );
  var expected = '';
  test.identical( got, expected );

  test.case = 'integer, noAtomic';
  var got = _.entity.exportString( 15, { noAtomic : 1 } );
  var expected = '';
  test.identical( got, expected );

  test.case = 'integer, levels 0';
  var got = _.entity.exportString( 99, { levels : 0 } );
  var expected = '99';
  test.identical( got, expected );

  test.case = 'integer, noRoutine';
  var got = _.entity.exportString( 22, { noRoutine : 1 } );
  var expected = '22';
  test.identical( got, expected );

}

//

function exportStringString( test )
{
  //  var desc = 'String test',
  //  src =
  //  [
  //    String( ),
  //    'sample',
  //    'sample2',
  //    'sample3',
  //    '\nsample4\n',
  //    'sample5',
  //    'sample6',
  //    '\nsample7'
  //
  //  ],
  //  options =
  //  [
  //    { },
  //    { },
  //    { noAtomic : 1 },
  //    { noString : 1 },
  //    { escaping : 1 },
  //    { tab : '---' },
  //    { levels : 0 },
  //    { },
  //  ],
  //  expected =
  //  [
  //    '\'\'',
  //    '\'sample\'',
  //    '',
  //    '',
  //    '\'\\nsample4\\n\'',
  //    '\'sample5\'',
  //    '\'sample6\'',
  //    '\'\nsample7\''
  //  ]
  //
  //  testFunction( test, desc, src, options, expected );

  test.case = 'string';
  var got = _.entity.exportString( String( ), { } );
  var expected = '\'\'';
  test.identical( got, expected );

  test.case = 'trivial string';
  var got = _.entity.exportString( 'sample', { } );
  var expected = '\'sample\'';
  test.identical( got, expected );

  test.case = 'string, noAtomic';
  var got = _.entity.exportString( 'sample2', { noAtomic : 1 } );
  var expected = '';
  test.identical( got, expected );

  test.case = 'string, noString';
  var got = _.entity.exportString( 'sample3', { noString : 1 } );
  var expected = '';
  test.identical( got, expected );

  test.case = 'string, escaping';
  var got = _.entity.exportString( '\nsample4\n', { escaping : 1 } );
  var expected = '\'\\nsample4\\n\'';
  test.identical( got, expected );

  test.case = 'string, tab';
  var got = _.entity.exportString( 'sample5', { tab : '---' } );
  var expected = '\'sample5\'';
  test.identical( got, expected );

  test.case = 'string, levels 0';
  var got = _.entity.exportString( 'sample6', { levels : 0 } );
  var expected = '\'sample6\'';
  test.identical( got, expected );

  test.case = 'string new line inside';
  var got = _.entity.exportString( '\nsample7', { } );
  var expected = '\'\nsample7\'';
  test.identical( got, expected );

}

//

function exportStringAtomic( test )
{
  //  var desc = 'boolean, null, undefined test',
  //  src =
  //  [
  //    Boolean( ),
  //    true,
  //    false,
  //    1!=2,
  //
  //    null,
  //    null,
  //
  //    undefined,
  //    undefined
  //  ],
  //  options =
  //  [
  //    { },
  //    { },
  //    { levels : 0 },
  //    { onlyRoutines : 1 },
  //
  //    { },
  //    { levels : 3 },
  //
  //    { },
  //    { noAtomic : 1 }
  //
  //  ],
  //  expected =
  //  [
  //    'false',
  //    'true',
  //    'false',
  //    '',
  //
  //    'null',
  //    'null',
  //
  //    'undefined',
  //    ''
  //  ]
  //  testFunction( test, desc, src, options, expected );

  test.case = 'boolean';
  var got = _.entity.exportString( Boolean( ), { } );
  var expected = 'false';
  test.identical( got, expected );

  test.case = 'boolean with value';
  var got = _.entity.exportString( true, { } );
  var expected = 'true';
  test.identical( got, expected );

  test.case = 'boolean, levels 0';
  var got = _.entity.exportString( false, { levels : 0 } );
  var expected = 'false';
  test.identical( got, expected );

  test.case = 'boolean, onlyRoutines';
  var got = _.entity.exportString( 1!=2, { onlyRoutines : 1 } );
  var expected = '';
  test.identical( got, expected );

  test.case = 'boolean null';
  var got = _.entity.exportString( null, { } );
  var expected = 'null';
  test.identical( got, expected );

  test.case = 'boolean null, levels 3';
  var got = _.entity.exportString( null, { levels : 3 } );
  var expected = 'null';
  test.identical( got, expected );

  test.case = 'boolean undefined';
  var got = _.entity.exportString( undefined, { } );
  var expected = 'undefined';
  test.identical( got, expected );

  test.case = 'boolean undefined, noAtomic';
  var got = _.entity.exportString( undefined, { noAtomic : 1 } );
  var expected = '';
  test.identical( got, expected );

}

//

function exportStringDate( test )
{
  //  var desc = 'Date test',
  //  src =
  //  [
  //    new Date( Date.UTC( 1993, 12, 12 ) ),
  //    new Date( Date.UTC( 1990, 0, 0 ) ),
  //    new Date( Date.UTC( 2016, 12, 8 ) ),
  //    new Date( Date.UTC( 2016, 1, 2 ) ),
  //  ],
  //  options =
  //  [
  //    { },
  //    { },
  //    { levels : 0 },
  //    { noDate : 1 }
  //  ],
  //  expected =
  //  [
  //    '1994-01-12T00:00:00.000Z',
  //    '1989-12-31T00:00:00.000Z',
  //    '2017-01-08T00:00:00.000Z',
  //    '',
  //  ]
  //  testFunction( test, desc, src, options, expected );

  test.case = 'date';
  var got = _.entity.exportString( new Date( Date.UTC( 1993, 12, 12 ) ), { } );
  var expected = '1994-01-12T00:00:00.000Z';
  test.identical( got, expected );

  test.case = 'date';
  var got = _.entity.exportString( new Date( Date.UTC( 1990, 0, 0 ) ), { } );
  var expected = '1989-12-31T00:00:00.000Z';
  test.identical( got, expected );

  test.case = 'date, levels 0';
  var got = _.entity.exportString( new Date( Date.UTC( 2016, 12, 8 ) ), { levels : 0 } );
  var expected = '2017-01-08T00:00:00.000Z';
  test.identical( got, expected );

  test.case = 'date, noDate';
  var got = _.entity.exportString( new Date( Date.UTC( 2016, 1, 2 ) ), { noDate : 1 } );
  var expected = '';
  test.identical( got, expected );

}

//

function exportStringRoutine( test )
{
  //  var desc = 'Routine test',
  //  src =
  //  [
  //    function rr( ){ },
  //    function rx( ){ },
  //    [ function ry( ){ } , 1],
  //  ],
  //  options =
  //  [
  //    { },
  //    { noRoutine : 1 },
  //    { onlyRoutines : 1 },
  //
  //  ],
  //  expected =
  //  [
  //    '[ routine rr ]',
  //    '',
  //    '',
  //  ]
  //  testFunction( test, desc, src, options, expected );

  test.case = 'routine';
  var got = _.entity.exportString( function rr( ){ }, { } );
  var expected = '[ routine rr ]';
  test.identical( got, expected );

  test.case = 'routine, noRoutine';
  var got = _.entity.exportString( function rx( ){ }, { noRoutine : 1 } );
  var expected = '';
  test.identical( got, expected );

  test.case = 'array with a routine, onlyRoutines';
  var got = _.entity.exportString( [ function ry( ){ } , 1], { onlyRoutines : 1 } );
  var expected = '';
  test.identical( got, expected );

}

//

function exportStringThrow( test )
{
  if( Config.debug )
  {
    test.case = 'wrong type of argument';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity.exportString( { a : 1 }, null );
    } );

    test.case = '( o.precision ) is not between 1 and 21';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity.exportString( { a : 1 }, { precision : 0 } );
    } );

    test.case = '( o.fixed ) is not between 0 and 20';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity.exportString( { a : 1 }, { fixed : 22 } );
    } );

    test.case = 'if jsonLike : 1, multilinedString 1 " ';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity.exportString( { a : 1 }, { jsonLike : 1, multilinedString : 1 } );
    } );

    test.case = 'wrong arguments count';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity.exportString( { a : 1 }, { b : 1 }, { jsonLike : 1 } );
    } );

    test.case = 'invalid json if multilinedString is true`';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity.exportString( { a : 1, b : 'text' }, { jsonLike : 1, multilinedString : 1 } );
    } );

    test.case = 'onlyRoutines & noRoutine both true';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity.exportString( { a : function f( ){}, b : 'text' }, { onlyRoutines : 1, noRoutine : 1 } );
    } );


  }
}

//

function exportStringLimitElements( test )
{
  //  var desc = 'limitElementsNumber options test',
  //  src =
  //  [
  //  //Arrays
  //  /*01*/[ 1, 2 , 3, 4, 5 ],
  //  /*02*/[ 1, 2 , '3', 4, 5 ],
  //  /*03*/[ 1, 2 , '3', 4, 5 ],
  //  /*04*/[ 1, 2 , '3', 4, 5 ],
  //  /*05*/[ 1, 2 , '3', 4, 5 ],
  //  /*06*/[ 1, 2 , '3', 4, { a : '1'  }, '5', '6' ],
  //  /*07*/[ 1, 2 , '3', 4, { a : '1'  }, '5', '6' ],
  //
  //  //Objects
  //  /*08*/{ a : 1, b : 2, c : 3, d : 4 },
  //  /*09*/{ a : 1, b : function n( ){ }, c : { a : '1' }, d : 4 },
  //  /*10*/{ a : 1, b : undefined, c : { a : '1' }, d : 4 },
  //  /*11*/{ a : 1, b : 2, c : { a : 1, b : '2' }, d : 3 },
  //
  //
  //  ],
  //  options =
  //  [
  //  //Arrays
  //  /*01*/{ limitElementsNumber : 2 },
  //  /*02*/{ limitElementsNumber : 3, noString : 1 },
  //  /*03*/{ limitElementsNumber : 2, noNumber : 1 },
  //  /*04*/{ limitElementsNumber : 5, noArray : 1 },
  //  /*05*/{ limitElementsNumber : 2, multiline : 1 },
  //  /*06*/{ levels : 2, limitElementsNumber : 3, noNumber : 1, multiline : 1 },
  //  /*07*/{ levels : 2, limitElementsNumber : 3, noNumber : 1, multiline : 1, wrap : 0, comma : ', '  },
  //
  //  //Objects
  //  /*08*/{ limitElementsNumber : 2 },
  //  /*09*/{ limitElementsNumber : 2, levels : 2,  noRoutine : 1, noString : 1 },
  //  /*10*/{ limitElementsNumber : 2, multiline : 1, noString : 1 },
  //  /*11*/{ limitElementsNumber : 4, wrap : 0, comma : ', ' },
  //
  //
  //
  //
  //  ],
  //  expected =
  //  [
  //  //Arrays
  //  /*01*/'[ 1, 2, [ ... other 3 element(s) ] ]',
  //  /*02*/'[ 1, 2, 4, [ ... other 1 element(s) ] ]',
  //  /*03*/'[ \'3\' ]',
  //  /*04*/'',
  //  /*05*/
  //  [
  //    '[',
  //    '  1, ',
  //    '  2, ',
  //    '  [ ... other 3 element(s) ]',
  //    ']',
  //  ].join( '\n' ),
  //
  //  /*06*/
  //  [
  //    '[',
  //    '  \'3\', ',
  //    '  {',
  //    '    a : \'1\'',
  //    '  }, ',
  //    '  \'5\', ',
  //    '  [ ... other 1 element(s) ]',
  //    ']',
  //  ].join( '\n' ),
  //
  //  /*07*/
  //  [
  //    '  \'3\', ',
  //    '    a : \'1\', ',
  //    '  \'5\', ',
  //    '  [ ... other 1 element(s) ]',
  //
  //  ].join( '\n' ),
  //
  //  //Objects
  //  /*08*/
  //  [
  //    '{',
  //    '  a : 1, ',
  //    '  b : 2, ',
  //    '  [ ... other 2 element(s) ]',
  //    '}',
  //
  //  ].join( '\n' ),
  //
  //  /*09*/
  //  [
  //    '{',
  //    '  a : 1, ',
  //    '  c : {}, ',
  //    '  [ ... other 1 element(s) ]',
  //    '}',
  //
  //  ].join( '\n' ),
  //
  //  /*10*/
  //  [
  //    '{',
  //    '  a : 1, ',
  //    '  b : undefined, ',
  //    '  [ ... other 2 element(s) ]',
  //    '}',
  //
  //  ].join( '\n' ),
  //
  //  /*11*/
  //  [
  //    '  a : 1, ',
  //    '  b : 2, ',
  //    '  c : {- Map.polluted with 2 elements -}, ',
  //    '  d : 3',
  //
  //  ].join( '\n' ),
  //
  //  ]
  //  testFunction( test, desc, src, options, expected );

  test.case = 'array, limit elements 2';
  var src = [ 1, 2 , 3, 4, 5 ];
  var got = _.entity.exportString( src, { limitElementsNumber : 2 } );
  var expected = '[ 1, 2, [ ... other 3 element(s) ] ]';
  test.identical( got, expected );

  test.case = 'array, noString limit elements 3';
  var src = [ 1, 2 , '3', 4, 5 ];
  var got = _.entity.exportString( src, { limitElementsNumber : 3, noString : 1 } );
  var expected = '[ 1, 2, 4, [ ... other 1 element(s) ] ]';
  test.identical( got, expected );

  test.case = 'array, noNumber limit elements 2';
  var src = [ 1, 2 , '3', 4, 5 ];
  var got = _.entity.exportString( src, { limitElementsNumber : 2, noNumber : 1 } );
  var expected = '[ \'3\' ]';
  test.identical( got, expected );

  test.case = 'array, noArray limit elements 5';
  var src = [ 1, 2 , '3', 4, 5 ];
  var got = _.entity.exportString( src, { limitElementsNumber : 5, noArray : 1 } );
  var expected = '';
  test.identical( got, expected );

  test.case = 'array, multiline limit elements';
  var src = [ 1, 2 , '3', 4, 5 ];
  var got = _.entity.exportString( src, { limitElementsNumber : 2, multiline : 1 } );
  var expected =
  [
    '[',
    '  1, ',
    '  2, ',
    '  [ ... other 3 element(s) ]',
    ']',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array, levels 2 noNumber multiline';
  var src = [ 1, 2 , '3', 4, { a : '1'  }, '5', '6' ];
  var got = _.entity.exportString( src, { levels : 2, limitElementsNumber : 3, noNumber : 1, multiline : 1 } );
  var expected =
  [
    '[',
    '  \'3\', ',
    '  {',
    '    a : \'1\'',
    '  }, ',
    '  \'5\', ',
    '  [ ... other 1 element(s) ]',
    ']',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'array, noNumber multiline wrap 0 levels 2';
  var src = [ 1, 2 , '3', 4, { a : '1'  }, '5', '6' ];
  var got = _.entity.exportString( src, { levels : 2, limitElementsNumber : 3, noNumber : 1, multiline : 1, wrap : 0, comma : ', '  } );
  var expected =
  [
    '  \'3\', ',
    '    a : \'1\', ',
    '  \'5\', ',
    '  [ ... other 1 element(s) ]',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'object, limit elements 2';
  var src = { a : 1, b : 2, c : 3, d : 4 };
  var got = _.entity.exportString( src, { limitElementsNumber : 2 } );
  var expected =
  [
    '{',
    '  a : 1, ',
    '  b : 2, ',
    '  [ ... other 2 element(s) ]',
    '}',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'object, noRoutine noString levels 2';
  var src = { a : 1, b : function n( ){ }, c : { a : '1' }, d : 4 };
  var got = _.entity.exportString( src, { limitElementsNumber : 2, levels : 2,  noRoutine : 1, noString : 1 } );
  var expected =
  [
    '{',
    '  a : 1, ',
    '  c : {}, ',
    '  [ ... other 1 element(s) ]',
    '}',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'object, noString multiline';
  var src = { a : 1, b : undefined, c : { a : '1' }, d : 4 };
  var got = _.entity.exportString( src, { limitElementsNumber : 2, multiline : 1, noString : 1 } );
  var expected =
  [
    '{',
    '  a : 1, ',
    '  b : undefined, ',
    '  [ ... other 2 element(s) ]',
    '}',
  ].join( '\n' );
  test.identical( got, expected );

  test.case = 'object, wrap 0 ';
  var src = { a : 1, b : 2, c : { a : 1, b : '2' }, d : 3 };
  var got = _.entity.exportString( src, { limitElementsNumber : 4, wrap : 0, comma : ', ' } );
  var expected =
  [
    '  a : 1, ',
    '  b : 2, ',
    '  c : {- Map.polluted with 2 elements -}, ',
    '  d : 3',
  ].join( '\n' );
  test.identical( got, expected );

}

//

function exportStringMethods( test )
{

  test.case = 'converts routine to string default options';
  var got = _.entity.exportStringMethods( function route( ) {} );
  var expected = '[ routine route ]';
  test.identical( got, expected );

  test.case = 'converts routine to string, levels:0';
  var got = _.entity.exportStringMethods( function route( ) {}, { levels : 0 } );
  var expected = '[ routine route ]';
  test.identical( got, expected );

  test.case = 'different input data types';
  var got = _.entity.exportStringMethods( [ function route( ) {}, 0, '1', null ] );
  var expected = '';
  test.identical( got, expected );

  /**/

  test.case = 'invalid argument type';
  test.shouldThrowErrorOfAnyKind( function( )
  {
    _.entity.exportStringMethods( 'one', 'two' );
  } );

  test.case = 'wrong arguments count';
  test.shouldThrowErrorOfAnyKind( function( )
  {
    _.entity.exportStringMethods( { a : 1 }, { b : 1 }, { jsonLike : 1 } );
  } );

  test.case = 'onlyRoutines & noRoutine both true';
  test.shouldThrowErrorOfAnyKind( function( )
  {
    _.entity.exportStringMethods( function f ( ) {}, { noRoutine : 1 } );
  } );

}

//

function exportStringFields( test )
{
  test.case = 'Fields default options';
  var got = _.entity.exportStringFields( [ 1, 2, 'text', undefined ] );
  var expected = '[ 1, 2, \'text\', undefined ]';
  test.identical( got, expected );

  test.case = 'Fields, levels : 0';
  var got = _.entity.exportStringFields( [ 1, 2, 'text', undefined ], { levels : 0 } );
  var expected = '{- Array with 4 elements -}';
  test.identical( got, expected );

  test.case = 'Ignore routine';
  var got = _.entity.exportStringFields( [ function f ( ) {}, 1, 2, 3 ] );
  var expected = '[ 1, 2, 3 ]';
  test.identical( got, expected );

  test.case = 'no arguments';
  var got = _.entity.exportStringFields( );
  var expected = 'undefined';
  test.identical( got, expected );



  /**/

  if( Config.debug )
  {
    test.case = 'invalid argument type';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity.exportStringFields( 'one', 'two' );
    } );

    test.case = 'wrong arguments count';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity.exportStringFields( { a : 1 }, { b : 1 }, { jsonLike : 1 } );
    } );

    test.case = 'onlyRoutines & noRoutine both true';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity.exportStringFields( function f ( ) {}, { onlyRoutines : 1 } );
    } );

  }
}

//

function exportStringDiagnosticShallow( test )
{
  test.case = 'Array length test';
  var got = _.entity._exportStringShortAct( [ 1, 2, 'text', undefined ], {} );
  var expected = '{- Array with 4 elements -}';
  test.identical( got, expected );

  test.case = 'date to string';
  var got = _.entity._exportStringShortAct( new Date( Date.UTC( 1993, 12, 12 ) ), {} );
  var expected = '1994-01-12T00:00:00.000Z';
  test.identical( got, expected );

  test.case = 'string length > 40, prefix, postfix, infix';
  var got = _.entity._exportStringShortAct( 'toxtndmtmdbmmlzoirmfypyhnrrqfuvybuuvixyrx', { stringWrapper : '"' } );
  var expected = `"toxtndmtmdbmmlzoir...nrrqfuvybuuvixyrx"`;
  test.identical( got, expected );

  test.case = 'string with options';
  var got = _.entity._exportStringShortAct( '\toxtndmtmdb', {} );
  var expected = `'\\toxtndmtmdb'`;
  test.identical( got, expected );

  test.case = 'error to string ';
  var got = _.entity._exportStringShortAct( new Error( 'err', {} ), {} );
  var expected = '[object Error]';
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.case = 'invalid second argument type';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringShortAct( '1', 2 );
    } );

    test.case = 'only one argument provided';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringShortAct( '1' );
    } );

    test.case = 'no arguments';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringShortAct( );
    } );

  }
}

//

function exportStringNice( test )
{
  test.case = 'in - boolean';
  var got = _.entity.exportStringNice( false, {} );
  test.identical( got, 'false' );

  test.case = 'in - number';
  var got = _.entity.exportStringNice( 13, {} );
  test.identical( got, '13' );

  test.case = 'in - number, levels - 2';
  var got = _.entity.exportStringNice( 0, { levels : 2 } );
  test.identical( got, '0' );

  test.case = 'in - Date, levels - 2';
  var got = _.entity.exportStringNice( new Date( Date.UTC( 2020, 0, 13 ) ), { levels : 2 } );
  test.identical( got, '2020-01-13T00:00:00.000Z' );

  test.case = 'in - string, level - 2';
  var got = _.entity.exportStringNice( 'text', { levels : 2 } );
  test.identical( got, 'text' );

  test.case = 'in - empty array, levels - 2';
  var got = _.entity.exportStringNice( [], { levels : 2 } );
  test.identical( got, '' );

  test.case = 'in - array with empty maps, levels - 2';
  var got = _.entity.exportStringNice( [ {}, {}, {} ], { levels : 2 } );
  test.identical( got, '' );

  test.case = 'in - array with numbers, levels - 2';
  var got = _.entity.exportStringNice( [ 1, 2, 3, 4 ], { levels : 2 } );
  test.identical( got, '  1\n  2\n  3\n  4' );

  test.case = 'in - empty map, levels - 2';
  var got = _.entity.exportStringNice( {}, { levels : 2 } );
  test.identical( got, '' );

  test.case = 'in - filled map, levels - 2';
  var got = _.entity.exportStringNice( { a : {}, b : {} }, { levels : 2 } );
  test.identical( got, '' );

  test.case = 'in - filled map with strings values, levels - 2';
  var got = _.entity.exportStringNice( { 1 : 'a', 2: 'b', 3: 'c' }, { levels : 2 } );
  test.identical( got, '  1 : a\n  2 : b\n  3 : c' );

  /* */

  test.case = 'in - filled map, complex values, levels - 2';
  var src = { 1 : 'a', 2 : [ 10, 20, 30 ], 3 : { 21 : 'aa', 22 : 'bb' } };
  var got = _.entity.exportStringNice( src, { levels : 2 } );
  var exp =
  [
    '  1 : a',
    '  2 : \n    10\n    20\n    30',
    '  3 : \n    21 : aa\n    22 : bb',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled map, complex values, levels - 2';
  var src =
  {
    1 : 'a',
    2 : [ 10, 20, 30 ],
    3 : { 21 : 'aa', 22 : 'bb' },
    4 : [ 10, 20, 30 ],
    5 : [ 10, 20, 30 ],
  };
  var got = _.entity.exportStringNice( src, { levels : 2 } );
  var exp =
  [
    '  1 : a',
    '  2 : \n    10\n    20\n    30',
    '  3 : \n    21 : aa\n    22 : bb',
    '  4 : \n    10\n    20\n    30',
    '  5 : \n    10\n    20\n    30',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled map, complex values, levels - 2';
  var src =
  {
    1 : 'a',
    2 : [ 10, 20, 30 ],
    3 : { 21 : 'aa', 22 : 'bb' },
    4 : [ 10, 20, 30 ],
    5 : [ 10, 20, 30 ],
  };
  var got = _.entity.exportStringNice( src, { levels : 2 } );
  var exp =
  [
    '  1 : a',
    '  2 : \n    10\n    20\n    30',
    '  3 : \n    21 : aa\n    22 : bb',
    '  4 : \n    10\n    20\n    30',
    '  5 : \n    10\n    20\n    30',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled array, complex values, levels - 2';
  var src =
  [
    'a',
    [ 10, 20, 30 ],
    { 21 : 'aa', 22 : 'bb' },
    { 31 : '111', 32 : '222' },
    [ 10, 20, 30 ],
    [ 10, 20, 30 ],
  ];
  var got = _.entity.exportStringNice( src, { levels : 2 } );
  var exp =
  [
    '  a',
    '    10\n    20\n    30',
    '    21 : aa\n    22 : bb',
    '    31 : 111\n    32 : 222',
    '    10\n    20\n    30',
    '    10\n    20\n    30',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled array, complex values, levels - 3';
  var src =
  [
    'a',
    [ 10, 20, 30 ],
    {
      21 : [ 1, 2, 3 ],
      22 : [ 1, 2, 3, 4 ],
    },
    {
      31 : { a : 'a', b : 'b' },
      32 : { a : 'a', b : 'b', c : 'c' }
    },
    [
      [ 1, 2, 3 ],
      [ 1, 2, 3, 4 ]
    ],
    [
      { a : 'a', b : 'b' },
      { a : 'a', b : 'b', c : 'c' }
    ],
  ];
  var got = _.entity.exportStringNice( src, { levels : 3 } );
  var exp =
  [
    '  a',
    '    10\n    20\n    30',
    '    21 : \n      1\n      2\n      3',
    '    22 : \n      1\n      2\n      3\n      4',
    '    31 : \n      a : a\n      b : b',
    '    32 : \n      a : a\n      b : b\n      c : c',
    '      1\n      2\n      3',
    '      1\n      2\n      3\n      4',
    '      a : a\n      b : b',
    '      a : a\n      b : b\n      c : c',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled array, complex values, a few levels of nesting, levels - 5';
  var src =
  [
    'a',
    [ 10, 20, 30 ],
    {
      21 : [ 1, 2, 3 ],
      22 : [ 1, 2, 3, 4 ],
    },
    {
      31 :
      {
        a : { a : 'a', b : 'b' },
        b : { a : 'a', b : 'b' }
      },
      32 :
      {
        a : 'a',
        b : 'b',
        c : { a : 'a', b : 'b' },
      }
    },
    [
      [
        [ 100, 200 ],
        [ 100, 200 ]
      ],
      [ 1, 2, 3, 4 ]
    ],
    [
      { a : 'a', b : 'b' },
      {
        a : 'a',
        b : 'b',
        c : { a : 'a', b : 'b' }
      }
    ],
  ];
  var got = _.entity.exportStringNice( src, { levels : 5 } );
  var exp =
  [
    '  a',
    '    10\n    20\n    30',
    '    21 : \n      1\n      2\n      3',
    '    22 : \n      1\n      2\n      3\n      4',
    '    31 : ',
    '      a : \n        a : a\n        b : b',
    '      b : \n        a : a\n        b : b',
    '    32 : ',
    '      a : a',
    '      b : b',
    '      c : \n        a : a\n        b : b',
    '        100\n        200',
    '        100\n        200',
    '      1\n      2\n      3\n      4',
    '      a : a\n      b : b',
    '      a : a',
    '      b : b',
    '      c : \n        a : a\n        b : b',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled array, complex values, levels - 1';
  var src =
  [
    'a',
    [ 10, 20, 30 ],
    { 21 : 'aa', 22 : 'bb' },
    { 31 : '111', 32 : '222' },
    [ 10, 20, 30 ],
    [ 10, 20, 30 ],
  ];
  var got = _.entity.exportStringNice( src, { levels : 1 } );
  var exp =
  [
    '  a',
    '  {- Array with 3 elements -}',
    '  {- Map.polluted with 2 elements -}',
    '  {- Map.polluted with 2 elements -}',
    '  {- Array with 3 elements -}',
    '  {- Array with 3 elements -}',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled array, complex values, 3 levels of nesting, levels - 2';
  var src =
  [
    'a',
    [ 10, 20, 30 ],
    {
      21 : [ 1, 2, 3 ],
      22 : [ 1, 2, 3, 4 ],
    },
    {
      31 : { a : 'a', b : 'b' },
      32 : { a : 'a', b : 'b', c : 'c' }
    },
    [
      [ 1, 2, 3 ],
      [ 1, 2, 3, 4 ]
    ],
    [
      { a : 'a', b : 'b' },
      { a : 'a', b : 'b', c : 'c' }
    ],
  ];
  var got = _.entity.exportStringNice( src, { levels : 2 } );
  var exp =
  [
    '  a',
    '    10\n    20\n    30',
    '    21 : {- Array with 3 elements -}',
    '    22 : {- Array with 4 elements -}',
    '    31 : {- Map.polluted with 2 elements -}',
    '    32 : {- Map.polluted with 3 elements -}',
    '    {- Array with 3 elements -}',
    '    {- Array with 4 elements -}',
    '    {- Map.polluted with 2 elements -}',
    '    {- Map.polluted with 3 elements -}',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled map, complex values, levels - 2, tab - "-", dtab - "+"';
  var src =
  {
    1 : 'a',
    2 : [ 10, 20, 30 ],
    3 : { 21 : 'aa', 22 : 'bb' },
    4 : [ 10, 20, 30 ],
    5 : [ 10, 20, 30 ],
  };
  var got = _.entity.exportStringNice( src, { levels : 2, tab : '---', dtab : '+' } );
  var exp =
  [
    '---+1 : a',
    '---+2 : \n---++10\n---++20\n---++30',
    '---+3 : \n---++21 : aa\n---++22 : bb',
    '---+4 : \n---++10\n---++20\n---++30',
    '---+5 : \n---++10\n---++20\n---++30',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled map, complex values, levels - 2, wrap - 0, tab - "-", prependTab - 0';
  var src =
  {
    1 : 'a',
    2 : [ 10, 20, 30 ],
    3 : { 21 : 'aa', 22 : 'bb' },
    4 : [ 10, 20, 30 ],
    5 : [ 10, 20, 30 ],
  };
  var got = _.entity.exportStringNice( src, { levels : 2, wrap : 0, tab : '-', prependTab : 0 } );
  var exp =
  [
    '  1 : a',
    '-  2 : \n-    10\n-    20\n-    30',
    '-  3 : \n-    21 : aa\n-    22 : bb',
    '-  4 : \n-    10\n-    20\n-    30',
    '-  5 : \n-    10\n-    20\n-    30',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled map, complex values, levels - 2, wrap - 0, tab - "-", prependTab - 1';
  var src =
  {
    1 : 'a',
    2 : [ 10, 20, 30 ],
    3 : { 21 : 'aa', 22 : 'bb' },
    4 : [ 10, 20, 30 ],
    5 : [ 10, 20, 30 ],
  };
  var got = _.entity.exportStringNice( src, { levels : 2, wrap : 0, tab : '-', prependTab : 1 } );
  var exp =
  [
    '-  1 : a',
    '-  2 : \n-    10\n-    20\n-    30',
    '-  3 : \n-    21 : aa\n-    22 : bb',
    '-  4 : \n-    10\n-    20\n-    30',
    '-  5 : \n-    10\n-    20\n-    30',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled map, complex values, levels - 2, wrap - 1, tab - "-", prependTab - 0';
  var src =
  {
    1 : 'a',
    2 : [ 10, 20, 30 ],
    3 : { 21 : 'aa', 22 : 'bb' },
    4 : [ 10, 20, 30 ],
    5 : [ 10, 20, 30 ],
  };
  var got = _.entity.exportStringNice( src, { levels : 2, wrap : 1, tab : '-', prependTab : 0 } );
  var exp =
  [
    '{',
    '-  1 : a',
    '-  2 : \n-  [\n-    10\n-    20\n-    30\n-  ]',
    '-  3 : \n-  {\n-    21 : aa\n-    22 : bb\n-  }',
    '-  4 : \n-  [\n-    10\n-    20\n-    30\n-  ]',
    '-  5 : \n-  [\n-    10\n-    20\n-    30\n-  ]',
    '-}',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled map, complex values, levels - 2, wrap - 1, tab - "-", prependTab - 1';
  var src =
  {
    1 : 'a',
    2 : [ 10, 20, 30 ],
    3 : { 21 : 'aa', 22 : 'bb' },
    4 : [ 10, 20, 30 ],
    5 : [ 10, 20, 30 ],
  };
  var got = _.entity.exportStringNice( src, { levels : 2, wrap : 1, tab : '-', prependTab : 1 } );
  var exp =
  [
    '-{',
    '-  1 : a',
    '-  2 : \n-  [\n-    10\n-    20\n-    30\n-  ]',
    '-  3 : \n-  {\n-    21 : aa\n-    22 : bb\n-  }',
    '-  4 : \n-  [\n-    10\n-    20\n-    30\n-  ]',
    '-  5 : \n-  [\n-    10\n-    20\n-    30\n-  ]',
    '-}',
  ].join( '\n' );
  test.identical( got, exp );

  /* */

  test.case = 'in - filled map, complex values, levels - 2, noSubObject - 1, noArray - 1, dtab - "  "';
  var src =
  {
    1 : [ 1, 2, 3 ],
    2 : 'abc',
    3 : 4,
  };
  var got = _.entity.exportStringNice( src, { levels : 2, noSubObject : 1, noArray : 1, dtab : '  ' } );
  var exp =
  [
    '  2 : abc',
    '  3 : 4',
  ].join( '\n' );
  test.identical( got, exp );
}

//

function _exportStringIsVisibleElement( test )
{
  test.case = 'default options';
  var got = _.entity._exportStringIsVisibleElement( 123, {} );
  var expected = true;
  test.identical( got, expected );

  test.case = 'noAtomic';
  var got = _.entity._exportStringIsVisibleElement( 'test', { noAtomic : 1 } );
  var expected = false;
  test.identical( got, expected );

  test.case = 'noObject';
  var got = _.entity._exportStringIsVisibleElement( { a : 'test' }, { noObject : 1 } );
  var expected = false;
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.case = 'invalid arguments count';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringIsVisibleElement( '1' );
    } );

    // test.case = 'second argument is not a object';
    // test.shouldThrowErrorOfAnyKind( function( )
    // {
    //   _.entity._exportStringIsVisibleElement( '1', 2 );
    // } );

    test.case = 'no arguments';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringIsVisibleElement( );
    } );

  }
}

//

function _exportStringIsSimpleElement( test )
{
  test.case = 'default options';
  var got = _.entity._exportStringIsSimpleElement( 123, {} );
  var expected = true;
  test.identical( got, expected );

  test.case = 'string length > 40';
  var got = _.entity._exportStringIsSimpleElement( 'toxtndmtmdbmmlzoirmfypyhnrrqfuvybuuvixyrx', {} );
  var expected = false;
  test.identical( got, expected );

  test.case = 'object test';
  var got = _.entity._exportStringIsSimpleElement( { a : 1 }, {} );
  var expected = false;
  test.identical( got, expected );

  test.case = 'atomic test';
  var got = _.entity._exportStringIsSimpleElement( undefined, {} );
  var expected = true;
  test.identical( got, expected );

  test.case = 'escaping test';
  var got = _.entity._exportStringIsSimpleElement( '\naaa', { escaping : 1 } );
  var expected = true;
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.case = 'invalid arguments count';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringIsSimpleElement( '1' );
    } );

    test.case = 'second argument is not a object';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringIsSimpleElement( '1', 2 );
    } );

    test.case = 'no arguments';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringIsSimpleElement( );
    } );

  }
}

//

function _exportStringIsSimpleElement2( test )
{

  test.case = 'argument\'s length is less than 40 symbols';
  var got = _.entity._exportStringIsSimpleElement( 'test', {} );
  var expected = true;
  test.identical( got, expected );

  test.case = 'argument is number';
  var got = _.entity._exportStringIsSimpleElement( 13, {} );
  var expected = true;
  test.identical( got, expected );

  test.case = 'argument is boolean';
  var got = _.entity._exportStringIsSimpleElement( true, {} );
  var expected = true;
  test.identical( got, expected );

  test.case = 'argument is null';
  var got = _.entity._exportStringIsSimpleElement( null, {} );
  var expected = true;
  test.identical( got, expected );

  test.case = 'argument is undefined';
  var got = _.entity._exportStringIsSimpleElement( undefined, {} );
  var expected = true;
  test.identical( got, expected );

  test.case = 'argument\'s length is greater than 40 symbols';
  var got = _.entity._exportStringIsSimpleElement( 'test, test, test, test, test, test, test, test, test.', {} );
  var expected = false;
  test.identical( got, expected );

  test.case = 'argument is an object';
  var got = _.entity._exportStringIsSimpleElement( { a: 33 }, {} );
  var expected = false;
  test.identical( got, expected );

  test.case = 'argument is an array';
  var got = _.entity._exportStringIsSimpleElement( [ 1, 2, 3 ], {} );
  var expected = false;
  test.identical( got, expected );

  test.case = 'argument is an array-like';
  var arrLike = ( function( ) { return arguments; } )( 1, 2, 3 );
  var got = _.entity._exportStringIsSimpleElement( arrLike, {} );
  var expected = false;
  test.identical( got, expected );
}


//

function _exportStringFromRoutine( test )
{
  test.case = 'routine test';
  var got = _.entity._exportStringFromRoutine( function a ( ) {}, {} );
  var expected = '[ routine a ]';
  test.identical( got, expected );

  test.case = 'routine without name';
  var got = _.entity._exportStringFromRoutine( function( ) {}, {} );
  var expected = '[ routine without name ]';
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.case = 'invalid argument type';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringFromRoutine( '1' );
    } );

    test.case = 'no arguments';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringFromRoutine( );
    } );

  }
}

//

function _exportStringFromNumber( test )
{
  test.case = 'default options';
  var got = _.entity._exportStringFromNumber( 123, {} );
  var expected = '123';
  test.identical( got, expected );

  test.case = 'number precision test';
  var got = _.entity._exportStringFromNumber( 123, { precision : 2 } );
  var expected = '1.2e+2';
  test.identical( got, expected );

  test.case = 'number fixed test';
  var got = _.entity._exportStringFromNumber( 123, { fixed : 2 } );
  var expected = '123.00';
  test.identical( got, expected );

  test.case = 'invalid option type';
  var got = _.entity._exportStringFromNumber( 123, { fixed : '2' } );
  var expected = '123';
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.case = 'invalid first argument type';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringFromNumber( '1', {} );
    } );

    test.case = 'invalid second argument type';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringFromNumber( 1, 2 );
    } );

    test.case = 'no arguments';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringFromNumber( );
    } );

    test.case = 'precision out of range';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringFromNumber( 1, { precision : 22 } );
    } );

    test.case = 'fixed out of range';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringFromNumber( 1, { fixed : 22 } );
    } );

  }
}

//

function _exportStringFromNumber2( test )
{

  test.case = 'returns with precision until 5';
  var options = { precision : 5 };
  var got = _.entity._exportStringFromNumber( 3.123456, options );
  var expected = '3.1235';
  test.identical( got, expected );

  test.case = 'returns with precision until 2';
  var options = { precision : 2 };
  var got = _.entity._exportStringFromNumber( 3.123456, options );
  var expected = '3.1';
  test.identical( got, expected );

  test.case = 'is returned with four numbers after dot';
  var options = { fixed : 4 };
  var got = _.entity._exportStringFromNumber( 13.75, options );
  var expected = '13.7500';
  test.identical( got, expected );

  test.case = 'is returned the rounded number to the top';
  var options = { fixed : 0 };
  var got = _.entity._exportStringFromNumber( 13.50, options );
  var expected = '14';
  test.identical( got, expected );

  test.case = 'is returned the rounded number to the bottom';
  var options = { fixed : 0 };
  var got = _.entity._exportStringFromNumber( 13.49, options );
  var expected = '13';
  test.identical( got, expected );

  test.case = 'returns string';
  var options = {  };
  var got = _.entity._exportStringFromNumber( 13.75, options );
  var expected = '13.75';
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorOfAnyKind( function( )
  {
    _.entity._exportStringFromNumber( );
  } );

  test.case = 'first argument is wrong';
  test.shouldThrowErrorOfAnyKind( function( )
  {
    _.entity._exportStringFromNumber( 'wrong argument', { fixed : 3 } );
  } );

  test.case = 'second argument is not provided';
  test.shouldThrowErrorOfAnyKind( function( )
  {
    _.entity._exportStringFromNumber( 13.75 );
  } );

  test.case = 'second argument is wrong precision must be between 1 and 21';
  test.shouldThrowErrorOfAnyKind( function( )
  {
    _.entity._exportStringFromNumber( 13.75, { precision : 0 } );
  } );

};

//

function _exportStringFromStr( test )
{

  test.case = 'default options';
  var got = _.entity._exportStringFromStr( '123', {} );
  var expected = `'123'`;
  test.identical( got, expected );

  test.case = 'escaping';
  var got = _.entity._exportStringFromStr( '\n123\u001b', { escaping : 1 } );
  var expected = `'\\n123\\u001b'`;
  test.identical( got, expected );

  test.case = 'stringWrapper';
  var got = _.entity._exportStringFromStr( 'string', { stringWrapper : '"' } );
  var expected = '"string"';
  test.identical( got, expected );

  test.case = 'multilinedString';
  var got = _.entity._exportStringFromStr( 'string\nstring2', { stringWrapper : '`' } );
  var expected = '`string\nstring2`';
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.case = 'invalid first argument type';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringFromStr( 2, {} );
    } );

    test.case = 'invalid second argument type';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringFromStr( '1', 2 );
    } );

    test.case = 'no arguments';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringFromStr( );
    } );

  }
}

//

function _exportStringFromSet( test )
{
  test.case = 'default options';
  var options = { tab : ' ', dtab : '   ', level : 1, comma : ', ', wrap : 1 };
  var got = _.entity._exportStringFromSet( new Set([ 1, 2, 3 ]), options ).text;
  var expected = 'new Set([ 1, 2, 3 ])';
  test.identical( got, expected );

  test.case = 'wrap test';
  var options = { tab : ' ', dtab : '   ', level : 1, comma : ', ', wrap : 0 };
  var got = _.entity._exportStringFromSet( new Set([ 1, 2, 3 ]), options ).text;
  var expected = 'new Set(   1, 2, 3)';
  test.identical( got, expected );

  test.case = 'levels 0 test';
  var options = { tab : ' ', dtab : '   ', level : 0, levels : 0, comma : ', ', wrap : 1 };
  var got = _.entity._exportStringFromSet( new Set([ 1, 2, 3 ]), options ).text;
  var expected = 'new Set({- Array with 3 elements -})';
  test.identical( got, expected );

  test.case = 'dtab & multiline test';
  var options = { tab : ' ', dtab : '-', level : 0, comma : ', ', wrap : 1, multiline : 1 };
  var got = _.entity._exportStringFromSet( new Set([ 1, 2, 3 ]), options ).text;
  var expected =
  [
    'new Set([',
    ' -1, ',
    ' -2, ',
    ' -3',
    ' ])',
  ].join( '\n' );
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.entity._exportStringFromSet() );

  test.case = 'invalid first argument type';
  test.shouldThrowErrorSync( () => _.entity._exportStringFromSet( 2, {} ) );

  test.case = 'invalid second argument type';
  test.shouldThrowErrorSync( () => _.entity._exportStringFromSet( [], 2 ) );
}

//

function _exportStringFromArray( test )
{

  test.case = 'default options';
  var got = _.entity._exportStringFromArray( [ 1, 2, 3 ], { tab : ' ', dtab : '   ', level : 1, comma : ', ', wrap : 1 } ).text;
  var expected = '[ 1, 2, 3 ]';
  test.identical( got, expected );

  test.case = 'wrap test';
  var got = _.entity._exportStringFromArray( [ 1, 2, 3 ], { tab : ' ', dtab : '   ', level : 1, comma : ', ', wrap : 0 } ).text;
  var expected = '   1, 2, 3';
  test.identical( got, expected );

  test.case = 'levels 0 test';
  var got = _.entity._exportStringFromArray( [ 1, 2, 3 ], { tab : ' ', dtab : '   ', level : 0, levels : 0, comma : ', ', wrap : 1 } ).text;
  var expected = '{- Array with 3 elements -}';
  test.identical( got, expected );

  test.case = 'dtab & multiline test';
  var got = _.entity._exportStringFromArray( [ 1, 2, 3 ], { tab : ' ', dtab : '-', level : 0, comma : ', ', wrap : 1, multiline : 1 } ).text;
  var expected =
  [
    '[',
    ' -1, ',
    ' -2, ',
    ' -3',
    ' ]',
  ].join( '\n' );
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.case = 'invalid first argument type';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringFromArray( 2, {} );
    } );

    test.case = 'invalid second argument type';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringFromArray( [], 2 );
    } );

    test.case = 'no arguments';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringFromArray( );
    } );

  }
}

//

function _exportStringFromContainer( test )
{
  var o = { tab : ' ', dtab : '   ', level : 0, levels : 1, onlyEnumerable : 1, own : 1, colon : ' : ', comma : ', ', wrap : 1, noObject : 0, multiline : 0, noSubObject : 0, prependTab : 1, jsonLike : 0, stringWrapper : '"' };
  var src = { a : 1, b : 2, c : 'text' };
  var names = _.props.onlyOwnKeys( src );
  var optionsItem = null;

  function item_options( )
  {
  optionsItem = _.props.extend( {}, o );
  optionsItem.noObject = o.noSubObject ? 1 : 0;
  optionsItem.tab = o.tab + o.dtab;
  optionsItem.level = o.level + 1;
  optionsItem.prependTab = 0;
  };

  test.case = 'default options';
  item_options( );
  var got = _.entity._exportStringFromContainer
  ( {
    values : src,
    names,
    optionsContainer : o,
    optionsItem,
    simple : !o.multiline,
    prefix : '{',
    postfix : '}',
  } );
  var expected = ' { a : 1, b : 2, c : "text" }';
  test.identical( got, expected );

  test.case = 'wrap 0, comma , dtab, multiline test';

  o.wrap = 0;
  o.comma = '_';
  o.dtab = '*';
  o.colon = ' | ';
  o.multiline = 1;
  item_options( );

  var got = _.entity._exportStringFromContainer
  ( {
    values : src,
    names,
    optionsContainer : o,
    optionsItem,
    simple : !o.multiline,
    prefix : '{',
    postfix : '}',
  } );
  var expected =
  [
    ' *a | 1_',
    ' *b | 2_',
    ' *c | "text"',
  ].join( '\n' );

  test.identical( got, expected );

  test.case = 'json test';

  o.wrap = 1;
  o.comma = ', ';
  o.dtab = '  ';
  o.multiline = 0;
  o.colon = ' : ';
  o.json = 1;
  o.levels = 256;
  item_options( );

  var got = _.entity._exportStringFromContainer
  ( {
    values : src,
    names,
    optionsContainer : o,
    optionsItem,
    simple : !o.multiline,
    prefix : '{',
    postfix : '}',
  } );
  var expected = ' { "a" : 1, "b" : 2, "c" : "text" }';

  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.case = 'invalid  argument type';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringFromContainer( 1 );
    } );

    test.case = 'empty object';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringFromContainer( { } );
    } );

    test.case = 'no arguments';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringFromContainer( );
    } );

  }

}

//

function _exportStringFromObject( test )
{
  var def = { tab : ' ', dtab : '   ', level : 0, levels : 1, onlyEnumerable : 1, own : 1, colon : ' : ', comma : ', ', wrap : 1, noObject : 0, multiline : 0 };

  test.case = 'default options';
  var got = _.entity._exportStringFromObject( { a : 1, b : 2 , c : 'text' }, def );
  var expected = `{ a : 1, b : 2, c : 'text' }`;
  test.identical( got.text, expected );

  test.case = 'levels 0 test';
  def.levels = 0;
  var got = _.entity._exportStringFromObject( { a : 1, b : 2 , c : 'text' }, def );
  var expected = '{- Map.polluted with 3 elements -}';
  test.identical( got.text, expected );

  test.case = 'wrap 0 test';
  def.levels = 1;
  def.wrap = 0;
  var got = _.entity._exportStringFromObject( { a : 1, b : 2, c : 'text' }, def );
  var expected = `a : 1, b : 2, c : 'text'`;
  test.identical( got.text, expected );

  test.case = 'noObject test';
  def.noObject = 1;
  var got = _.entity._exportStringFromObject( { a : 1, b : 2, c : 'text' }, def );
  var expected = undefined;
  test.identical( got, expected );

  test.case = 'dtab & prependTab & multiline test';
  def.noObject = 0;
  def.dtab = '*';
  def.multiline  = 1;
  def.prependTab = 1;
  var got = _.entity._exportStringFromObject( { a : 1, b : 2, c : 'text' }, def );
  var expected =
  [
    ` *a : 1, `,
    ` *b : 2, `,
    ` *c : 'text'`,
  ].join( '\n' );
  test.identical( got.text, expected );

  /**/

  if( Config.debug )
  {

    test.case = 'invalid first argument type';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringFromObject( 1, {} );
    } );

    test.case = 'empty options';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringFromObject( { a : 1 }, {} );
    } );

    test.case = 'invalid second argument type';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringFromObject( { a : 1 }, 2 );
    } );

    test.case = 'no arguments';
    test.shouldThrowErrorOfAnyKind( function( )
    {
      _.entity._exportStringFromObject( );
    } );

  }
}

// --
// declare test suite
// --

const Proto =
{

  name : 'Tools.l3.Stringer',
  silencing : 1,
  enabled : 1,

  context :
  {
    reportChars,
    // stringFromFile,
    // testFunction,
    // _exportStringJsonFromFile,
  },

  tests :
  {

    exportString,
    exportStringUnwrapped,
    exportStringError,
    exportStringArray,
    exportStringObject,
    // exportStringJson,
    // exportStringJsonFromFileU,
    // exportStringJsonFromFileA,
    exportStringStringWrapper,
    exportStringLevel,
    exportStringEnumerable,
    exportStringEmptyArgs,
    exportStringSymbol,
    exportStringNumber,
    exportStringString,
    exportStringAtomic,
    exportStringDate,
    exportStringRoutine,
    exportStringThrow,
    exportStringLimitElements,

    exportStringMethods,
    exportStringFields,
    exportStringDiagnosticShallow,
    exportStringNice,

    _exportStringIsVisibleElement,
    _exportStringIsSimpleElement,
    _exportStringIsSimpleElement2,
    _exportStringFromRoutine,
    _exportStringFromNumber,
    _exportStringFromNumber2,
    _exportStringFromStr,
    _exportStringFromSet,
    _exportStringFromArray,
    _exportStringFromContainer,
    _exportStringFromObject,


  }

};

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
