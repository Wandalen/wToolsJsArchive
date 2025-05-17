( function _JsBabel_test_s_( )
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
  test.true( _.constructorIs( _.introspector.Parser.JsBabel ) );
  test.true( _.constructorIs( context.defaultParser ) );
  test.true( context.defaultParser === _.introspector.Parser.JsBabel );
  let sys = _.introspector.System({ defaultParserClass : context.defaultParser });
  let file = _.introspector.File({ data : sourceCode, sys });
  file.refine();
  logger.log( file.productExportInfo() );
  test.true( file.parser.constructor === context.defaultParser );

  test.description = 'nodes';
  test.identical( file.product.nodes.length, 103 ); /* 95 */
  test.identical( _.props.keys( file.product.byType ).length, 24 ); /* 21 */
  test.identical( file.product.byType.gRoutine.length, 8 );

  test.description = 'root';
  test.identical( file.product.byType.File.length, 1 );
  test.identical( file.product.byType.Program.length, 1 );
  test.true( file.product.byType.File.first() === file.product.root );

  return null;
}

parseStringSpecial.description =
`
Parsing from string with espima js parser produce proper AST.
`

// --
// declare
// --

const Proto =
{

  name : 'Tools.mid.Introspector.JsBabel',

  context :
  {

    defaultParser : _.introspector.Parser.JsBabel,

  },

  tests :
  {

    parseStringSpecial,

  },

}

//

const Self = wTestSuite( Proto ).inherit( Parent );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
