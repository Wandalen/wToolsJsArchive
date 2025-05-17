( function _Stxt_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../../node_modules/Tools' );
  require( '../stxt/entry/Stxt.s' );

  _.include( 'wTesting' );
  _.include( 'wFiles' );

}

//

const _ = _global_.wTools;

// --
// context
// --

function onSuiteBegin()
{
  let context = this;

  context.suiteTempPath = _.path.tempOpen( _.path.join( __dirname, '../..'  ), 'stxt' );
  context.assetsOriginalPath = _.path.join( __dirname, '_assets' );
  // context.appJsPath = _.module.resolve( 'wStxt' );

}

//

function onSuiteEnd()
{
  let context = this;
  _.assert( _.strHas( context.suiteTempPath, '/stxt' ) )
  _.path.tempClose( context.suiteTempPath );
}

// --
// test
// --

function basic( test )
{
  let context = this;

  var dataStr = _.fileProvider.fileRead( _.path.join( context.assetsOriginalPath, 'Courses.stxt' ) );
  var parser = _.stxt.Parser({ dataStr });
  parser.form();

  test.identical( parser.line.length, 11 );
  test.identical( parser.document.nodes.length, 2 );
  test.identical( parser.document.nodes[ 0 ].nodes.length, 3 );

  test.description = 'page0 / head';
  var node = parser.document.nodes[ 0 ].head;
  test.identical( node.kind, 'Line' );
  test.identical( node.lines, [ 1, 1 ] );
  test.identical( node.properties, null );
  test.identical( node.raw, 'Recommended Online Courses Platforms' );
  test.identical( node.text, 'Recommended Online Courses Platforms' );
  test.identical( node.nodes.length, 1 );

  test.description = 'page / head / span';
  var node = parser.document.nodes[ 0 ].head.nodes[ 0 ];
  test.identical( node.kind, 'Span' );
  test.identical( node.lines, [ 1, 1 ] );
  test.identical( node.properties, null );
  test.identical( node.raw, 'Recommended Online Courses Platforms' );
  test.identical( node.text, 'Recommended Online Courses Platforms' );

  test.description = 'page / list';
  var node = parser.document.nodes[ 0 ].nodes[ 1 ];
  test.identical( node.kind, 'List' );
  test.identical( node.lines, [ 3, 4 ] );
  test.identical( node.properties, null );
  test.identical( node.raw, null );
  test.identical( node.text, null );
  test.identical( node.nodes.length, 2 );

  test.description = 'page0 / list1 / listNode0';
  var node = parser.document.nodes[ 0 ].nodes[ 1 ].nodes[ 0 ];
  test.identical( node.kind, 'ListNode' );
  test.identical( node.level, 1 );
  test.identical( node.lines, [ 3, 3 ] );
  test.identical( node.properties, null );
  test.identical( node.raw, null );
  test.identical( node.text, null );

  test.description = 'page / list / listNode / line';
  var node = parser.document.nodes[ 0 ].nodes[ 1 ].nodes[ 0 ].nodes[ 0 ];
  test.identical( node.kind, 'Line' );
  test.identical( node.lines, [ 3, 3 ] );
  test.identical( node.properties, null );
  test.identical( node.raw, '>> edX <<- https://www.edx.org/' );
  test.identical( node.text, 'edX' );
  test.identical( node.nodes.length, 1 );

  test.description = 'page / list / listNode / line / link';
  var node = parser.document.nodes[ 0 ].nodes[ 1 ].nodes[ 0 ].nodes[ 0 ].nodes[ 0 ];
  test.identical( node.kind, 'Link' );
  test.identical( node.lines, [ 3, 3 ] );
  test.identical( node.properties, null );
  test.identical( node.raw, '>> edX <<- https://www.edx.org/' );
  test.identical( node.text, 'edX' );
  test.identical( node.ref, 'https://www.edx.org/' );

  test.description = 'page / list / listNode / line / link / span';
  var node = parser.document.nodes[ 0 ].nodes[ 1 ].nodes[ 0 ].nodes[ 0 ].nodes[ 0 ].nodes[ 0 ];
  test.identical( node.kind, 'Span' );
  test.identical( node.lines, [ 3, 3 ] );
  test.identical( node.properties, null );
  test.identical( node.raw, ' edX ' );
  test.identical( node.text, ' edX ' );

}

//

function qz1( test )
{
  let context = this;

  var dataStr = _.fileProvider.fileRead( _.path.join( context.assetsOriginalPath, 'Quiz1.stxt' ) );
  var parser = _.stxt.Parser({ dataStr });
  parser.form();

  test.identical( parser.line.length, 35 );
  test.identical( parser.document.nodes.length, 3 );

  var exp =
`
node::Page
  node::LineEmpty
  node::Line
    node::Span
  node::LineEmpty
  node::List
    node::ListNode
      node::Line
        node::Span
    node::ListNode
      node::Line
        node::Span
    node::ListNode
      node::Line
        node::Span
    node::ListNode
      node::Line
        node::Span
  node::LineEmpty
  node::Directive
  node::Label
  node::Label
  node::LineEmpty
`;
  var node = parser.document.nodes[ 0 ];
  var got = parser.nodeExportHierarchy({ src : node });
  test.equivalent( got, exp );

  var exp =
`
node::Page
  node::LineEmpty
  node::Line
    node::Span
  node::LineEmpty
  node::List
    node::ListNode
      node::Line
        node::Span
    node::ListNode
      node::Line
        node::Span
    node::ListNode
      node::Line
        node::Span
    node::ListNode
      node::Line
        node::Span
  node::LineEmpty
  node::Label
  node::Label
  node::LineEmpty
`;
  var node = parser.document.nodes[ 1 ];
  var got = parser.nodeExportHierarchy({ src : node });
  test.equivalent( got, exp );

  var exp =
`
node::Page
  node::LineEmpty
  node::Line
    node::Span
    node::Link
      node::Span
    node::Span
  node::LineEmpty
  node::List
    node::ListNode
      node::Line
        node::Link
          node::Span
    node::ListNode
      node::Line
        node::Span
  node::LineEmpty
  node::Label
  node::LineEmpty
`;
  var node = parser.document.nodes[ 2 ];
  var got = parser.nodeExportHierarchy({ src : node });
  test.equivalent( got, exp );

  test.description = 'page / list / listNode / line';
  var node = parser.document.nodes[ 0 ].nodes[ 3 ].nodes[ 2 ].nodes[ 0 ];
  test.identical( node.kind, 'Line' );
  test.identical( node.lines, [ 7, 7 ] );
  test.identical( node.properties, null );
  test.identical( node.raw, '`good third` <~ `$score += 1`' );
  test.identical( node.text, '`good third` ' );

  test.description = 'page / list / listNode / line / span';
  var node = parser.document.nodes[ 0 ].nodes[ 3 ].nodes[ 2 ].nodes[ 0 ].nodes[ 0 ];
  test.identical( node.kind, 'Span' );
  test.identical( node.lines, [ 7, 7 ] );
  test.identical( node.properties, '`$score += 1`' );
  test.identical( node.raw, '`good third` ' );
  test.identical( node.text, '`good third` ' );

  test.description = 'page / directive2';
  var node = parser.document.nodes[ 0 ].nodes[ 5 ];
  test.identical( node.kind, 'Directive' );
  test.identical( node.level, 1 );
  test.identical( node.lines, [ 10, 10 ] );
  test.identical( node.properties, { multiple : 1 } );
  test.identical( node.raw, '~ multiple : 1' );
  test.identical( node.text, '~ multiple : 1' );

  test.description = 'page0 / label3';
  var node = parser.document.nodes[ 0 ].nodes[ 6 ];
  test.identical( node.kind, 'Label' );
  test.identical( node.level, 1 );
  test.identical( node.lines, [ 11, 11 ] );
  test.identical( node.properties, { 'NodeJs' : 1 } );
  test.identical( node.raw, '@ NodeJs : 1' );
  test.identical( node.text, '@ NodeJs : 1' );

  test.description = 'page / label4';
  var node = parser.document.nodes[ 0 ].nodes[ 7 ];
  test.identical( node.kind, 'Label' );
  test.identical( node.level, 1 );
  test.identical( node.lines, [ 12, 12 ] );
  test.identical( node.properties, { 'level' : 0 } );
  test.identical( node.raw, '@ level : 0' );
  test.identical( node.text, '@ level : 0' );

  test.description = 'page2 / label2';
  var node = parser.document.nodes[ 2 ].nodes[ 5 ];
  test.identical( node.kind, 'Label' );
  test.identical( node.level, 1 );
  test.identical( node.lines, [ 33, 33 ] );
  test.identical( node.properties, { learning : 1 } );
  test.identical( node.raw, '@ learning' );
  test.identical( node.text, '@ learning' );

}

//

function commentLine( test )
{
  let context = this;

  var dataStr = _.fileProvider.fileRead( _.path.join( context.assetsOriginalPath, 'CommentLine.stxt' ) );
  var parser = _.stxt.Parser({ dataStr });
  parser.form();

  test.identical( parser.line.length, 35 );
  test.identical( parser.document.nodes.length, 2 );

  var exp =
`
node::Page
  node::CommentLine
  node::LineEmpty
  node::Line
    node::Span
  node::LineEmpty
  node::List
    node::ListNode
      node::Line
        node::Span
    node::ListNode
      node::Line
        node::Span
    node::ListNode
      node::Line
        node::Span
    node::CommentLine
  node::LineEmpty
  node::Directive
  node::Label
  node::Label
  node::LineEmpty
`;
  var node = parser.document.nodes[ 0 ];
  var got = parser.nodeExportHierarchy({ src : node });
  test.equivalent( got, exp );

  var exp =
`
node::Page
  node::LineEmpty
  node::CommentLine
  node::LineEmpty
  node::CommentLine
  node::List
    node::ListNode
      node::Line
        node::Span
    node::ListNode
      node::Line
        node::Span
    node::ListNode
      node::Line
        node::Span
  node::LineEmpty
  node::CommentLine
  node::Label
  node::LineEmpty
  node::CommentLine
  node::LineEmpty
  node::Line
    node::Span
    node::Link
      node::Span
    node::Span
  node::LineEmpty
  node::List
    node::ListNode
      node::Line
        node::Link
          node::Span
    node::ListNode
      node::Line
        node::Span
  node::LineEmpty
  node::CommentLine
  node::LineEmpty
`;
  var node = parser.document.nodes[ 1 ];
  var got = parser.nodeExportHierarchy({ src : node });
  test.equivalent( got, exp );

  /*
    qqq : check each node effected by commenting out
  */

}

//

function pagelessEpilogue( test )
{
  let context = this;

  var dataStr = _.fileProvider.fileRead( _.path.join( context.assetsOriginalPath, 'PagelessEpilogue.stxt' ) );
  var parser = _.stxt.Parser({ dataStr });
  parser.form();

  test.identical( parser.line.length, 14 );
  test.identical( parser.document.nodes.length, 3 );

  /* */

  test.case = 'no empty line';
  var node = parser.document;
  var exp =
`
node::Collection
  node::Page
    node::Line
      node::Span
    node::LineEmpty
    node::Directive
    node::Label
    node::Label
    node::LineEmpty
  node::Page
    node::LineEmpty
    node::List
      node::ListNode
        node::Line
          node::Link
            node::Span
      node::ListNode
        node::Line
          node::Span
    node::LineEmpty
  node::Page
`
  var got = parser.nodeExportHierarchy({ src : node });
  test.equivalent( got, exp );

  /* */

  test.description = 'page0';
  var node = parser.document.nodes[ 0 ]; debugger;
  test.identical( node.kind, 'Page' );
  test.identical( node.level, 1 );
  test.identical( node.lines, [ 0, 6 ] );
  test.identical( node.properties, null );
  test.identical( node.nodes.length, 6 );
  test.identical( node.number, 0 );
  test.identical( node.raw, null );
  test.identical( node.text, null );
  test.identical( node.subPages.length, 0 );
  test.identical( node.supPages.length, 0 );

  /* */

}

//

function emptyLines( test )
{
  let context = this;

  var dataStr = _.fileProvider.fileRead( _.path.join( context.assetsOriginalPath, 'EmptyLines.stxt' ) );
  var parser = _.stxt.Parser({ dataStr });
  parser.form();

  test.identical( parser.line.length, 49 );
  test.identical( parser.document.nodes.length, 5 );

  /* */

  test.case = 'no empty line';
  var node = parser.document.nodes[ 0 ];
  var exp =
`
node::Page
  node::Line
    node::Span
  node::List
    node::ListNode
      node::Line
        node::Span
    node::ListNode
      node::Line
        node::Span
    node::ListNode
      node::Line
        node::Span
  node::Directive
  node::Label
  node::Label
`
  var got = parser.nodeExportHierarchy({ src : node });
  test.equivalent( got, exp );

  /* */

  test.case = '1 empty line';
  var node = parser.document.nodes[ 1 ];
  var exp =
`
node::Page
  node::LineEmpty
  node::Line
    node::Span
  node::LineEmpty
  node::List
    node::ListNode
      node::Line
        node::Span
    node::ListNode
      node::Line
        node::Span
    node::ListNode
      node::Line
        node::Span
  node::LineEmpty
  node::Directive
  node::LineEmpty
  node::Label
  node::LineEmpty
  node::Label
  node::LineEmpty
`
  var got = parser.nodeExportHierarchy({ src : node });
  test.equivalent( got, exp );

  /* */

  test.case = '2 empty line';
  var node = parser.document.nodes[ 2 ];
  var exp =
`
node::Page
  node::LineEmpty
  node::Line
    node::Span
  node::LineEmpty
  node::List
    node::ListNode
      node::Line
        node::Span
    node::ListNode
      node::Line
        node::Span
    node::ListNode
      node::Line
        node::Span
  node::LineEmpty
  node::Directive
  node::LineEmpty
  node::Label
  node::LineEmpty
  node::Label
  node::LineEmpty
`
  var got = parser.nodeExportHierarchy({ src : node });
  test.equivalent( got, exp );

  /* */

  test.case = 'only empty lines';
  var node = parser.document.nodes[ 3 ];
  var exp =
`
node::Page
`
  var got = parser.nodeExportHierarchy({ src : node });
  test.equivalent( got, exp );

  /* */

  test.case = 'no lines';
  var node = parser.document.nodes[ 4 ];
  var exp =
`
node::Page
`
  var got = parser.nodeExportHierarchy({ src : node });
  test.equivalent( got, exp );

  /* */

}

//

function subpages( test )
{
  let context = this;

  var dataStr = _.fileProvider.fileRead( _.path.join( context.assetsOriginalPath, 'Subpages.stxt' ) );
  var parser = _.stxt.Parser({ dataStr });
  parser.form();

  test.identical( parser.line.length, 28 );
  test.identical( parser.document.nodes.length, 11 );

  /* */

  test.description = 'hierarchy';
  var node = parser.document;
  var exp =
`
node::Collection
  node::Page
    node::Line
      node::Span
    node::LineEmpty
    node::Directive
    node::Directive
    node::Directive
    node::LineEmpty
  node::Page
    node::Line
      node::Span
    node::LineEmpty
    node::Line
      node::Span
    node::LineEmpty
  node::Page
    node::Line
      node::Span
    node::LineEmpty
    node::Line
      node::Span
    node::LineEmpty
  node::Page
    node::Line
      node::Span
    node::LineEmpty
    node::Line
      node::Span
    node::LineEmpty
  node::Page
    node::Line
      node::Span
  node::Page
    node::Line
      node::Span
  node::Page
    node::Line
      node::Span
  node::Page
    node::Line
      node::Span
  node::Page
    node::Line
      node::Span
  node::Page
    node::Line
      node::Span
  node::Page
    node::Line
      node::Span
`
  var got = parser.nodeExportHierarchy({ src : node });
  test.equivalent( got, exp );

  /* */

  test.description = 'page0';
  var node = parser.document.nodes[ 0 ];
  test.identical( node.kind, 'Page' );
  test.identical( node.level, 3 );
  test.identical( node.number, 0 );
  test.identical( node.nodes.length, 5 );
  test.identical( _.select( node.supPages, '*/number' ), [] );
  test.identical( _.select( node.subPages, '*/number' ), [ 1 ] );

  /* */

  test.description = 'page1';
  var node = parser.document.nodes[ 1 ];
  test.identical( node.kind, 'Page' );
  test.identical( node.level, 2 );
  test.identical( node.number, 1 );
  test.identical( node.nodes.length, 3 );
  test.identical( _.select( node.supPages, '*/number' ), [ 0 ] );
  test.identical( _.select( node.subPages, '*/number' ), [ 2 ] );

  /* */

  test.description = 'page2';
  var node = parser.document.nodes[ 2 ];
  test.identical( node.kind, 'Page' );
  test.identical( node.level, 1 );
  test.identical( node.number, 2 );
  test.identical( node.nodes.length, 3 );
  test.identical( _.select( node.supPages, '*/number' ), [ 0, 1 ] );
  test.identical( _.select( node.subPages, '*/number' ), [] );

  /* */

  test.description = 'page3';
  var node = parser.document.nodes[ 3 ];
  test.identical( node.kind, 'Page' );
  test.identical( node.level, 3 );
  test.identical( node.number, 3 );
  test.identical( node.nodes.length, 3 );
  test.identical( _.select( node.supPages, '*/number' ), [] );
  test.identical( _.select( node.subPages, '*/number' ), [ 4, 5, 6, 8 ] );

  /* */

  test.description = 'page4';
  var node = parser.document.nodes[ 4 ];
  test.identical( node.kind, 'Page' );
  test.identical( node.level, 1 );
  test.identical( node.number, 4 );
  test.identical( node.nodes.length, 0 );
  test.identical( _.select( node.supPages, '*/number' ), [ 3 ] );
  test.identical( _.select( node.subPages, '*/number' ), [] );

  /* */

  test.description = 'page5';
  var node = parser.document.nodes[ 5 ];
  test.identical( node.kind, 'Page' );
  test.identical( node.level, 1 );
  test.identical( node.number, 5 );
  test.identical( node.nodes.length, 0 );
  test.identical( _.select( node.supPages, '*/number' ), [ 3 ] );
  test.identical( _.select( node.subPages, '*/number' ), [] );

  /* */

  test.description = 'page6';
  var node = parser.document.nodes[ 6 ];
  test.identical( node.kind, 'Page' );
  test.identical( node.level, 2 );
  test.identical( node.number, 6 );
  test.identical( node.nodes.length, 0 );
  test.identical( _.select( node.supPages, '*/number' ), [ 3 ] );
  test.identical( _.select( node.subPages, '*/number' ), [ 7 ] );

  /* */

  test.description = 'page7';
  var node = parser.document.nodes[ 7 ];
  test.identical( node.kind, 'Page' );
  test.identical( node.level, 1 );
  test.identical( node.number, 7 );
  test.identical( node.nodes.length, 0 );
  test.identical( _.select( node.supPages, '*/number' ), [ 3, 6 ] );
  test.identical( _.select( node.subPages, '*/number' ), [] );

  /* */

  test.description = 'page8';
  var node = parser.document.nodes[ 8 ];
  test.identical( node.kind, 'Page' );
  test.identical( node.level, 2 );
  test.identical( node.number, 8 );
  test.identical( node.nodes.length, 0 );
  test.identical( _.select( node.supPages, '*/number' ), [ 3 ] );
  test.identical( _.select( node.subPages, '*/number' ), [ 9, 10 ] );

  /* */

  test.description = 'page9';
  var node = parser.document.nodes[ 9 ];
  test.identical( node.kind, 'Page' );
  test.identical( node.level, 1 );
  test.identical( node.number, 9 );
  test.identical( node.nodes.length, 0 );
  test.identical( _.select( node.supPages, '*/number' ), [ 3, 8 ] );
  test.identical( _.select( node.subPages, '*/number' ), [] );

  /* */

  test.description = 'page10';
  var node = parser.document.nodes[ 10 ];
  test.identical( node.kind, 'Page' );
  test.identical( node.level, 1 );
  test.identical( node.number, 10 );
  test.identical( node.nodes.length, 0 );
  test.identical( _.select( node.supPages, '*/number' ), [ 3, 8 ] );
  test.identical( _.select( node.subPages, '*/number' ), [] );

  /* */

}

//

function nodeRawText( test )
{
  let context = this;

  var dataStr = _.fileProvider.fileRead( _.path.join( context.assetsOriginalPath, 'Quiz1.stxt' ) );
  var parser = _.stxt.Parser({ dataStr });
  parser.form();

  test.identical( parser.line.length, 35 );
  test.identical( parser.document.nodes.length, 3 );

  /* */

  test.case = 'Collection';
  var node = parser.nodesMap.Collection[ 0 ];
  var exp =
`
==

Which of the following console command is good?

- \`notgood first\`
- \`notgood second\`
- \`good third\` <~ \`$score += 1\`
- \`notgood fourth\`

~ multiple : 1
@ NodeJs : 1
@ level : 0

==

What does it contain?

- \`The nothing\`.
- The good file <~ \`$score += 2\`
- The bad file.
- The fourth bad file.

@ NodeJs : 1
@ level : 2

==

What is >> edX <<- https://www.edx.org/ ?

- Produces cars. <- https://www.edx.org/
- Online courses. <~ \`$score += 1\`

@ learning

`;
  var got = _.stxt.nodeRaw( node, parser );
  test.equivalent( got, exp );
  var got = _.stxt.nodeText( node, parser );
  test.equivalent( got, exp );

  /* */

  test.case = 'Page';
  test.identical( parser.nodesMap.Page.length, 3 );
  var node = parser.nodesMap.Page[ 0 ];
  var exp =
`
==

  Which of the following console command is good?

  - \`notgood first\`
  - \`notgood second\`
  - \`good third\` <~ \`$score += 1\`
  - \`notgood fourth\`

  ~ multiple : 1
  @ NodeJs : 1
  @ level : 0

`;
  var got = _.stxt.nodeRaw( node, parser );
  test.equivalent( got, exp );
  var got = _.stxt.nodeText( node, parser );
  test.equivalent( got, exp );

  /* */

  test.case = 'Span';
  test.identical( parser.nodesMap.Span.length, 15 );
  var node = parser.nodesMap.Span[ 0 ];
  var exp =
`
Which of the following console command is good?
`;
  var got = _.stxt.nodeRaw( node, parser );
  test.equivalent( got, exp );
  var got = _.stxt.nodeText( node, parser );
  test.equivalent( got, exp );

  /* */

  test.case = 'LineEmpty';
  test.identical( parser.nodesMap.LineEmpty.length, 12 );
  var node = parser.nodesMap.LineEmpty[ 0 ];
  var exp =
`
`;
  var got = _.stxt.nodeRaw( node, parser );
  test.equivalent( got, exp );
  var got = _.stxt.nodeText( node, parser );
  test.equivalent( got, exp );

  /* */

  test.case = 'Line';
  test.identical( parser.nodesMap.Line.length, 13 );
  var node = parser.nodesMap.Line[ 0 ];
  var exp =
`
Which of the following console command is good?
`;
  var got = _.stxt.nodeRaw( node, parser );
  test.equivalent( got, exp );
  var got = _.stxt.nodeText( node, parser );
  test.equivalent( got, exp );

  /* */

  test.case = 'Line1';
  var node = parser.nodesMap.Line[ 1 ];
  var exp =
`
\`notgood first\`
`;
  var got = _.stxt.nodeRaw( node, parser );
  test.equivalent( got, exp );
  var got = _.stxt.nodeText( node, parser );
  test.equivalent( got, exp );

  /* */

  test.case = 'List';
  test.identical( parser.nodesMap.List.length, 3 );
  var node = parser.nodesMap.List[ 0 ];
  var exp =
`
- \`notgood first\`
- \`notgood second\`
- \`good third\` <~ \`$score += 1\`
- \`notgood fourth\`
`;
  var got = _.stxt.nodeRaw( node, parser );
  test.equivalent( got, exp );
  var got = _.stxt.nodeText( node, parser );
  test.equivalent( got, exp );

  /* */

  test.case = 'ListNode';
  test.identical( parser.nodesMap.Directive.length, 1 );
  var node = parser.nodesMap.ListNode[ 0 ];
  var exp =
`
- \`notgood first\`
`;
  var got = _.stxt.nodeRaw( node, parser );
  test.equivalent( got, exp );
  var got = _.stxt.nodeText( node, parser );
  test.equivalent( got, exp );

  /* */

  test.case = 'Directive';
  test.identical( parser.nodesMap.Directive.length, 1 );
  var node = parser.nodesMap.Directive[ 0 ];
  var exp =
`
~ multiple : 1
`;
  var got = _.stxt.nodeRaw( node, parser );
  test.equivalent( got, exp );
  var got = _.stxt.nodeText( node, parser );
  test.equivalent( got, exp );

  /* */

  test.case = 'Link';
  test.identical( parser.nodesMap.Link.length, 2 );
  var node = parser.nodesMap.Link[ 0 ];
  var exp =
`
>> edX <<- https://www.edx.org/
`;
  var got = _.stxt.nodeRaw( node, parser );
  test.equivalent( got, exp );
  var exp =
`
edX
`;
  var got = _.stxt.nodeText( node, parser );
  test.equivalent( got, exp );

  /* */

}

//

function nodeExportStrDefault( test )
{
  let context = this;

  var dataStr = _.fileProvider.fileRead( _.path.join( context.assetsOriginalPath, 'Quiz1.stxt' ) );
  var parser = _.stxt.Parser({ dataStr });
  parser.form();

  /* */

  test.case = 'Collection';
  var node = parser.nodesMap.Collection[ 0 ];
  var exp =
`
node::Collection
  lines :
    0
    34
  nodes : 3
`;
  var got = _.stxt.nodeExportStr({ src : node, parser });
  test.equivalent( got, exp );

  /* */

  test.case = 'Page';
  var node = parser.nodesMap.Page[ 0 ];
  var exp =
`
node::Page
  lines :
    1
    13
  level : 2
  number : 0
  nodes : 9
`;
  var got = _.stxt.nodeExportStr({ src : node, parser });
  test.equivalent( got, exp );

  /* */

  test.case = 'Span';
  var node = parser.nodesMap.Span[ 0 ];
  var exp =
`
node::Span
  lines :
    3
    3
`;
  var got = _.stxt.nodeExportStr({ src : node, parser });
  test.equivalent( got, exp );

  /* */

  test.case = 'Line';
  var node = parser.nodesMap.Line[ 0 ];
  var exp =
`
node::Line
  lines :
    3
    3
  nodes : 1
`;
  var got = _.stxt.nodeExportStr({ src : node, parser });
  test.equivalent( got, exp );

  /* */

  test.case = 'List';
  var node = parser.nodesMap.List[ 0 ];
  var exp =
`
node::List
  lines :
    5
    8
  nodes : 4
`;
  var got = _.stxt.nodeExportStr({ src : node, parser });
  debugger;
  test.equivalent( got, exp );

  /* */

  test.case = 'ListNode';
  var node = parser.nodesMap.ListNode[ 0 ];
  var exp =
`
node::ListNode
  lines :
    5
    5
  level : 1
  nodes : 1
`;
  var got = _.stxt.nodeExportStr({ src : node, parser });
  test.equivalent( got, exp );

  /* */

  test.case = 'Directive';
  var node = parser.nodesMap.Directive[ 0 ];
  var exp =
`
node::Directive
  lines :
    10
    10
  properties :
    multiple : 1
  level : 1
`;
  var got = _.stxt.nodeExportStr({ src : node, parser });
  test.equivalent( got, exp );

  /* */

  test.case = 'Link';
  var node = parser.nodesMap.Link[ 0 ];
  var exp =
`
node::Link
  lines :
    28
    28
  ref : https://www.edx.org/
  nodes : 1
`;
  var got = _.stxt.nodeExportStr({ src : node, parser });
  test.equivalent( got, exp );

  /* */

}

//

function nodeExportStrRecursive( test )
{
  let context = this;
  let recursive = 2;
  let verbosity = 1;

  var dataStr = _.fileProvider.fileRead( _.path.join( context.assetsOriginalPath, 'Quiz1.stxt' ) );
  var parser = _.stxt.Parser({ dataStr });
  parser.form();

  /* */

  test.case = 'Collection';
  var node = parser.nodesMap.Collection[ 0 ];
  var exp =
`
node::Collection
  node::Page
    node::LineEmpty
    node::Line
      node::Span
    node::LineEmpty
    node::List
      node::ListNode
        node::Line
          node::Span
      node::ListNode
        node::Line
          node::Span
      node::ListNode
        node::Line
          node::Span
      node::ListNode
        node::Line
          node::Span
    node::LineEmpty
    node::Directive
    node::Label
    node::Label
    node::LineEmpty
  node::Page
    node::LineEmpty
    node::Line
      node::Span
    node::LineEmpty
    node::List
      node::ListNode
        node::Line
          node::Span
      node::ListNode
        node::Line
          node::Span
      node::ListNode
        node::Line
          node::Span
      node::ListNode
        node::Line
          node::Span
    node::LineEmpty
    node::Label
    node::Label
    node::LineEmpty
  node::Page
    node::LineEmpty
    node::Line
      node::Span
      node::Link
        node::Span
      node::Span
    node::LineEmpty
    node::List
      node::ListNode
        node::Line
          node::Link
            node::Span
      node::ListNode
        node::Line
          node::Span
    node::LineEmpty
    node::Label
    node::LineEmpty
`;
  var got = _.stxt.nodeExportStr({ src : node, parser, recursive, verbosity });
  test.equivalent( got, exp );

  /* */

  test.case = 'Page';
  var node = parser.nodesMap.Page[ 0 ];
  var exp =
`
node::Page
  node::LineEmpty
  node::Line
    node::Span
  node::LineEmpty
  node::List
    node::ListNode
      node::Line
        node::Span
    node::ListNode
      node::Line
        node::Span
    node::ListNode
      node::Line
        node::Span
    node::ListNode
      node::Line
        node::Span
  node::LineEmpty
  node::Directive
  node::Label
  node::Label
  node::LineEmpty
`;
  var got = _.stxt.nodeExportStr({ src : node, parser, recursive, verbosity });
  test.equivalent( got, exp );

  /* */

  test.case = 'Span';
  var node = parser.nodesMap.Span[ 0 ];
  var exp =
`
node::Span
`;
  var got = _.stxt.nodeExportStr({ src : node, parser, recursive, verbosity });
  test.equivalent( got, exp );

  /* */

  test.case = 'Line';
  var node = parser.nodesMap.Line[ 0 ];
  var exp =
`
node::Line
  node::Span
`;
  var got = _.stxt.nodeExportStr({ src : node, parser, recursive, verbosity });
  test.equivalent( got, exp );

  /* */

  test.case = 'List';
  var node = parser.nodesMap.List[ 0 ];
  var exp =
`
node::List
  node::ListNode
    node::Line
      node::Span
  node::ListNode
    node::Line
      node::Span
  node::ListNode
    node::Line
      node::Span
  node::ListNode
    node::Line
      node::Span
`;
  var got = _.stxt.nodeExportStr({ src : node, parser, recursive, verbosity });
  test.equivalent( got, exp );

  /* */

  test.case = 'ListNode';
  var node = parser.nodesMap.ListNode[ 0 ];
  var exp =
`
node::ListNode
  node::Line
    node::Span
`;
  var got = _.stxt.nodeExportStr({ src : node, parser, recursive, verbosity });
  test.equivalent( got, exp );

  /* */

  test.case = 'Directive';
  var node = parser.nodesMap.Directive[ 0 ];
  var exp =
`
node::Directive
`;
  var got = _.stxt.nodeExportStr({ src : node, parser, recursive, verbosity });
  test.equivalent( got, exp );

  /* */

  test.case = 'Link';
  var node = parser.nodesMap.Link[ 0 ];
  var exp =
`
node::Link
  node::Span
`;
  var got = _.stxt.nodeExportStr({ src : node, parser, recursive, verbosity });
  test.equivalent( got, exp );

  /* */

}

// --
// declare
// --

const Proto =
{

  name : 'Tools.mid.StxtParser',
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

    basic,
    qz1,
    commentLine,
    pagelessEpilogue,
    emptyLines,
    subpages,

    nodeRawText,
    nodeExportStrDefault,
    nodeExportStrRecursive,

  },

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
