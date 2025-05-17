( function _String_toStr_test_s_( ) {

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
  var _global = _global_;
  var _ = _global_.wTools;

  _.include( 'wTesting' );

}
var _global = _global_;
var _ = _global_.wTools;

// --
// test
// --

function toStr( test )
{
  var self = this;

  var samples =
  [

    {
      options : {},
      in : false,
      out : 'false',
      description : 'boolean',
    },

    {
      options : {},
      in : 13,
      out : '13',
      description : 'number',
    },

    {
      options : { levels : 2 },
      in : 0,
      out : '0',
    },

    {
      options : { levels : 2 },
      in : new Date( Date.UTC( 2020, 0, 13 ) ),
      out : '2020-01-13T00:00:00.000Z',
    },

    {
      options : { levels : 2 },
      in : 'text',
      out : '\'text\'',
    },

    {
      options : { levels : 2 },
      in : [],
      out : '[]',
    },

    {
      options : { levels : 2 },
      in : [ {}, {}, {} ],
      out : '[ {}, {}, {} ]',
    },

    {
      options : { levels : 2 },
      in : {},
      out : '{}',
    },

    {
      options : { levels : 2 },
      in : { a : {}, b : {} },
      out : '{ a : {}, b : {} }',
    },

    {
      options : { levels : 2 },
      in : [ 1, 2, 3, 4 ],
      out : '[ 1, 2, 3, 4 ]',
    },

    {
      options : { levels : 2 },
      in : { 1 : 'a', 2: 'b', 3: 'c' },
      out : '{ 1 : \'a\', 2 : \'b\', 3 : \'c\' }',
    },

    {
      options : { levels : 2 },
      in :
      {
        1 : 'a',
        2: [ 10, 20, 30 ],
        3: { 21 : 'aa', 22 : 'bb' }
      },
      out :
      [
        '{',
        '  1 : \'a\', ',
        '  2 : [ 10, 20, 30 ], ',
        '  3 : { 21 : \'aa\', 22 : \'bb\' }',
        '}',
      ].join( '\n' ),
    },

    {
      options : { levels : 2 },
      in :
      {
        1 : 'a',
        2 : [ 10, 20, 30 ],
        3 : { 21 : 'aa', 22 : 'bb' },
        4 : [ 10, 20, 30 ],
        5 : [ 10, 20, 30 ],
      },
      out :
      [
        '{',
        '  1 : \'a\', ',
        '  2 : [ 10, 20, 30 ], ',
        '  3 : { 21 : \'aa\', 22 : \'bb\' }, ',
        '  4 : [ 10, 20, 30 ], ',
        '  5 : [ 10, 20, 30 ]',
        '}',
      ].join( '\n' ),
    },

    {
      options : { levels : 2 },
      in :
      [
        'a',
        [ 10, 20, 30 ],
        { 21 : 'aa', 22 : 'bb' },
        { 31 : '111', 32 : '222' },
        [ 10, 20, 30 ],
        [ 10, 20, 30 ],
      ],
      out :
      [
        '[',
        '  \'a\', ',
        '  [ 10, 20, 30 ], ',
        '  { 21 : \'aa\', 22 : \'bb\' }, ',
        '  { 31 : \'111\', 32 : \'222\' }, ',
        '  [ 10, 20, 30 ], ',
        '  [ 10, 20, 30 ]',
        ']',
      ].join( '\n' ),
    },

    // complex

    {
      options : { levels : 3 },
      in :
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
      ],
      out :
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
      ].join( '\n' ),
    },

    {
      options : { levels : 5 },
      in :
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
      ],
      out :
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
      ].join( '\n' ),
    },

    // levels

    {
      options : { levels : 1 },
      in :
      [
        'a',
        [ 10, 20, 30 ],
        { 21 : 'aa', 22 : 'bb' },
        { 31 : '111', 32 : '222' },
        [ 10, 20, 30 ],
        [ 10, 20, 30 ],
      ],
      out :
      [
        '[',
        '  \'a\', ',
        '  [ Array with 3 elements ], ',
        '  [ Object with 2 elements ], ',
        '  [ Object with 2 elements ], ',
        '  [ Array with 3 elements ], ',
        '  [ Array with 3 elements ]',
        ']',
      ].join( '\n' ),
    },

    {
      options : { levels : 2 },
      in :
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
      ],
      out :
      [
        '[',
        '  \'a\', ',
        '  [ 10, 20, 30 ], ',
        '  {',
        '    21 : [ Array with 3 elements ], ',
        '    22 : [ Array with 4 elements ]',
        '  }, ',
        '  {',
        '    31 : [ Object with 2 elements ], ',
        '    32 : [ Object with 3 elements ]',
        '  }, ',
        '  [',
        '    [ Array with 3 elements ], ',
        '    [ Array with 4 elements ]',
        '  ], ',
        '  [',
        '    [ Object with 2 elements ], ',
        '    [ Object with 3 elements ]',
        '  ]',
        ']',
      ].join( '\n' ),
    },

    // tab

    {
      options : { levels : 2, tab : '---', dtab : '+' },
      in :
      {
        1 : 'a',
        2 : [ 10, 20, 30 ],
        3 : { 21 : 'aa', 22 : 'bb' },
        4 : [ 10, 20, 30 ],
        13 : [ 10, 20, 30 ],
      },
      out :
      [
        '---{',
        '---+1 : \'a\', ',
        '---+2 : [ 10, 20, 30 ], ',
        '---+3 : { 21 : \'aa\', 22 : \'bb\' }, ',
        '---+4 : [ 10, 20, 30 ], ',
        '---+13 : [ 10, 20, 30 ]',
        '---}',
      ].join( '\n' ),
    },

    // prependTab

    {
      options : { levels : 2, wrap : 0, tab : '-', prependTab : 0 },
      in :
      {
        1 : 'a',
        2 : [ 10, 20, 30 ],
        3 : { 21 : 'aa', 22 : 'bb' },
        4 : [ 10, 20, 30 ],
        13 : [ 10, 20, 30 ],
      },
      out :
      [
        '  1 : \'a\' ',
        '-  2 :   10 20 30 ',
        '-  3 : 21 : \'aa\' 22 : \'bb\' ',
        '-  4 :   10 20 30 ',
        '-  13 :   10 20 30',
      ].join( '\n' ),
    },

    {
      options : { levels : 2, wrap : 0, tab : '-', prependTab : 1 },
      in :
      {
        1 : 'a',
        2 : [ 10, 20, 30 ],
        3 : { 21 : 'aa', 22 : 'bb' },
        4 : [ 10, 20, 30 ],
        13 : [ 10, 20, 30 ],
      },
      out :
      [
        '-  1 : \'a\' ',
        '-  2 :   10 20 30 ',
        '-  3 : 21 : \'aa\' 22 : \'bb\' ',
        '-  4 :   10 20 30 ',
        '-  13 :   10 20 30',
      ].join( '\n' ),
    },



    {
      options : { levels : 2, wrap : 1, tab : '-', prependTab : 0 },
      in :
      {
        1 : 'a',
        2 : [ 10, 20, 30 ],
        3 : { 21 : 'aa', 22 : 'bb' },
        4 : [ 10, 20, 30 ],
        5 : [ 10, 20, 30 ],
      },
      out :
      [
        '{',
        '-  1 : \'a\', ',
        '-  2 : [ 10, 20, 30 ], ',
        '-  3 : { 21 : \'aa\', 22 : \'bb\' }, ',
        '-  4 : [ 10, 20, 30 ], ',
        '-  5 : [ 10, 20, 30 ]',
        '-}',
      ].join( '\n' ),
    },

    {
      options : { levels : 2, wrap : 1, tab : '-', prependTab : 1 },
      in :
      {
        1 : 'a',
        2 : [ 10, 20, 30 ],
        3 : { 21 : 'aa', 22 : 'bb' },
        4 : [ 10, 20, 30 ],
        5 : [ 10, 20, 30 ],
      },
      out :
      [
        '-{',
        '-  1 : \'a\', ',
        '-  2 : [ 10, 20, 30 ], ',
        '-  3 : { 21 : \'aa\', 22 : \'bb\' }, ',
        '-  4 : [ 10, 20, 30 ], ',
        '-  5 : [ 10, 20, 30 ]',
        '-}',
      ].join( '\n' ),
    },

    {
      options : { levels : 2, noSubObject : 1, noArray : 1, dtab : '  ' },
      in :
      {
        1 : [ 1,2,3 ],
        2 : 'abc',
        3 : 4,
      },
      out :
      [
        '{',
        '  2 : \'abc\', ',
        '  3 : 4',
        '}',
      ].join( '\n' ),
    },

  ];

  //

  debugger;
  for( var s = 0 ; s < samples.length ; s++ )
  {
    var sample = samples[ s ];
    var got = _.toStr( sample.in,sample.options );

    test.case = sample.description || null;
    test.identical( got,sample.out );

  }
  debugger;

}

// --
// declare
// --

var Self =
{

  name : 'Tools/base/layer4/String/1',
  silencing : 1,
  enabled : 1, // !!! refactoring

  tests :
  {

    toStr : toStr,

  },

};

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
