( function _JsTreeSitter_test_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../../node_modules/Tools' );
  require( './JsAbstract.test.s' );

}

//

const _ = _global_.wTools;
var fileProvider = _.fileProvider;
var path = fileProvider.path;
const Parent = wTests[ 'Tools.mid.Introspector.JsAbstract' ];

// --
// tests
// --

function parseStringSpecial( test )
{
  let context = this;
  let sourceCode = context.defaultProgramSourceCode;

  test.description = 'setup';
  test.true( _.constructorIs( _.introspector.Parser.JsTreeSitter ) );
  test.true( _.constructorIs( context.defaultParser ) );
  test.true( context.defaultParser === _.introspector.Parser.JsTreeSitter );
  let sys = _.introspector.System({ defaultParserClass : context.defaultParser });
  let file = _.introspector.File({ data : sourceCode, sys });
  file.refine();
  logger.log( file.productExportInfo() );
  test.true( file.parser.constructor === context.defaultParser );

  test.description = 'nodes';
  test.identical( file.product.nodes.length, 234 ); /* 220 */
  test.identical( _.props.keys( file.product.byType ).length, 26 ); /* 23 */
  test.identical( file.product.byType.gRoutine.length, 8 );
  test.identical( file.product.byType.gComment.length, 2 );

  test.description = 'root';
  test.identical( file.product.byType.program.length, 1 );
  test.true( file.product.byType.program.first() === file.product.root );

  return null;
}

parseStringSpecial.description =
`
Parsing from string with espima js parser produce proper AST.
`

//

function descriptorsSearchKind( test )
{
  let context = this;
  let program = _.program.preform( programRoutine );

  logger.log( '' );
  logger.log( _.strLinesNumber( program.entry.routineCode ) );
  logger.log( '' );

  test.true( _.constructorIs( context.defaultParser ) );

  let file = _.introspector.File.FromData( program.entry.routineCode );
  file.sys.defaultParserClass = context.defaultParser;
  file.refine();

  logger.log( file.productExportInfo() );
  logger.log( '' );

  /*
    xxx : implement
    type = [ CallExpression, ExpressionStatement ]
    calle/code >= ( 'test.setsAreIdentical' )
    arguments/0 -> '_.setFrom( {- arguments/0/code -} )'
    arguments/1 -> '_.setFrom( {- arguments/1/code -} )'
  */

  /*
    xxx : implement
    @code >= ( 'test.setsAreIdentical' )
    .../@type = [ call_expression, expression_statement ]
    arguments/0 -> '_.setFrom( {- arguments/0/code -} )'
    arguments/1 -> '_.setFrom( {- arguments/1/code -} )'
  */

  let request =
  {
    kind : 'and',
    elements :
    [
      {
        kind : 'has',
        left : '@code',
        right :
        {
          kind : 'and',
          elements :
          [
            {
              kind : 'scalar',
              value : 'test.setsAreIdentical',
            }
          ],
        }
      },
      {
        kind : 'identical',
        left : { kind : 'selector', value : '.../@type' },
        right :
        {
          kind : 'or',
          elements :
          [
            {
              kind : 'scalar',
              value : 'call_expression',
            },
            {
              kind : 'scalar',
              value : 'expression_statement',
            },
          ]
        },
      },
    ],
  }

  let foundDescriptors = file.descriptorsSearch( 'setsAreIdentical' );

  var foundStr = _.container.map_( null, foundDescriptors, ( d ) =>
  {
    return `at ${d.path}\nfound ${file.descriptorToCode( d )}\n`;
  }).join( '\n' );
  logger.log( foundStr );
  test.identical( _.strCount( foundStr, `found` ), 2 );

  /* */

  function programRoutine()
  {
    const _ = require( toolsPath );
    function r1()
    {
      test.setsAreIdentical( rel( _.arrayFlatten( _.select( arr, '*/filePath' ) ) ), [] );
      _.process.on( 'exit', () =>
      {
        test.setsAreIdentical( rel( _.props.keys( map ) ), [] );
      });
    }

  }

}

descriptorsSearchKind.description =
`
xxx
`

// --
// declare
// --

const Proto =
{

  name : 'Tools.mid.Introspector.JsTreeSitter',

  context :
  {

    defaultParser : _.introspector.Parser.JsTreeSitter,

  },

  tests :
  {

    parseStringSpecial,
    descriptorsSearchKind

  },

}

//

const Self = wTestSuite( Proto ).inherit( Parent );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
