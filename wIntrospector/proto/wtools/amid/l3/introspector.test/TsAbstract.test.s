( function _TsAbstract_test_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../../node_modules/Tools' );
  require( './Abstract.test.s' );

}

//

const _ = _global_.wTools;
var fileProvider = _.fileProvider;
var path = fileProvider.path;
const Parent = wTests[ 'Tools.mid.Introspector' ];

// --
// assets
// --

let tsProgramSourceCode1 =
`
function programWithCommentsAndRoutines(): void
{
  /* comment1 */
  console.log( 'program' );
  process.on( 'exit', () => console.log( 'arrow1' ) );
  process.on( 'exit', () => { console.log( 'arrow2' ) } );
  process.on( 'exit', function(){ console.log( 'anonymous1' ) } );
  process.on( 'exit', function function1(){ console.log( 'function1' ) } );
  let function2 = function function2_(){ console.log( 'function2' ) };
  class SomeClass
  {
    constructor()
    {
    }
    method2(): void
    {
      console.log( 'method2' );
    }
  }
  // comment2
}
`

/*
`
import { Syntax } from './syntax';

export type ArgumentListElement = Expression | SpreadElement;
export type ArrayExpressionElement = Expression | SpreadElement | null;

export class ArrayExpression
{
  readonly type: string;
  readonly elements: ArrayExpressionElement[];
  constructor(elements: ArrayExpressionElement[])
  {
    this.type = Syntax.ArrayExpression;
    this.elements = elements;
  }
}

function routine( s : string ) : Namespace1.Class1 | Namespace1.Class2
{
    return 'x'.indexOf( s );
}

`
*/

// --
// tests
// --

function parseStringCommon( test )
{
  let context = this;
  let sourceCode = context.defaultProgramSourceCode;

  test.true( !_.introspector.Parser.Default );
  test.true( _.constructorIs( context.defaultParser ) );

  let sys = _.introspector.System({ defaultParserClass : context.defaultParser });
  let file = _.introspector.File({ data : sourceCode, sys });
  file.refine();

  logger.log( file.productExportInfo() );

  test.true( file.nodeIs( file.product.root ) );
  test.identical( file.product.byType.gRoutine.length, 8 );
  test.identical( file.nodeCode( file.product.root ), sourceCode );
  test.identical( file.parser.nodeRange( file.product.root ), [ 0, sourceCode.length-1 ] );

  return null;
}

parseStringCommon.description =
`
Parsing from string with espima js parser produce proper AST.
Routine nodeCode returns proper source code.
`

//

function parseGeneralNodes( test )
{
  let context = this;

  logger.log( '' );
  logger.log( _.strLinesNumber( context.defaultProgramSourceCode ) );
  logger.log( '' );

  test.true( _.constructorIs( context.defaultParser ) );

  let file = _.introspector.File.FromData( context.defaultProgramSourceCode );
  file.sys.defaultParserClass = context.defaultParser;
  file.refine();

  logger.log( file.productExportInfo() );
  logger.log( '' );

  test.description = 'general nodes';
  test.identical( file.product.byType.gRoutine.length, 8 );
  // test.identical( file.product.byType.gComment.length, 2 ); // xxx : not implemented
  test.identical( file.product.byType.gRoot.length, 1 );
  test.true( file.product.root === file.product.byType.gRoot.withIndex( 0 ) );

  /* */

}

parseGeneralNodes.description =
`
parse general nodes
`

// --
// declare
// --

const Proto =
{

  name : 'Tools.mid.Introspector.Ts',
  abstract : 1,

  context :
  {

    tsProgramSourceCode1,
    defaultProgramSourceCode : tsProgramSourceCode1,
    exts : [ 'ts' ],

  },

  tests :
  {
    parseStringCommon,
    parseGeneralNodes,
  },

}

//

const Self = wTestSuite( Proto ).inherit( Parent );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
