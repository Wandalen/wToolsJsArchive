( function _Js_test_s_( )
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
  test.true( _.constructorIs( _.introspector.Parser.JsAcorn ) );
  test.true( _.constructorIs( context.defaultParser ) );
  let sys = _.introspector.System();
  let file = _.introspector.File({ data : sourceCode, filePath : '/ParseStringSpecial.js', sys });
  file.refine();
  logger.log( file.productExportInfo() );
  test.true( file.parser.constructor === _.introspector.Parser.JsAcorn );

  test.description = 'nodes';
  test.identical( file.product.nodes.length, 104 ); /* 96 */
  test.identical( _.props.keys( file.product.byType ).length, 23 ); /* 20 */
  test.identical( file.product.byType.gRoutine.length, 8 );

  test.description = 'root';
  test.identical( file.product.byType.Program.length, 1 );
  test.true( file.product.byType.Program.first() === file.product.root );

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

  name : 'Tools.mid.Introspector.Default',

  context :
  {

    defaultParser : _.introspector.Parser.Js,

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
