( function _CppTreeSitter_test_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../../node_modules/Tools' );
  require( './CppAbstract.test.s' );

}

//

const _ = _global_.wTools;
var fileProvider = _.fileProvider;
var path = fileProvider.path;
const Parent = wTests[ 'Tools.mid.Introspector.Cpp' ];

// --
// tests
// --

function parseStringSpecial( test )
{
  let context = this;
  let sourceCode = context.defaultProgramSourceCode;

  test.description = 'setup';
  test.true( _.constructorIs( _.introspector.Parser.CppTreeSitter ) );
  test.true( _.constructorIs( context.defaultParser ) );
  test.true( context.defaultParser === _.introspector.Parser.CppTreeSitter );
  let sys = _.introspector.System({ defaultParserClass : context.defaultParser });
  let file = _.introspector.File({ data : sourceCode, sys });
  file.refine();
  logger.log( file.productExportInfo() );
  test.true( file.parser.constructor === context.defaultParser );

  test.description = 'nodes';
  test.identical( file.product.nodes.length, 427 );
  test.identical( _.props.keys( file.product.byType ).length, 48 );

  test.description = 'root';
  test.identical( file.product.byType.translation_unit.length, 1 );
  test.true( file.product.byType.translation_unit.first() === file.product.root );

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

  name : 'Tools.mid.Introspector.CppTreeSitter',

  context :
  {

    defaultParser : _.introspector.Parser.CppTreeSitter,

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
