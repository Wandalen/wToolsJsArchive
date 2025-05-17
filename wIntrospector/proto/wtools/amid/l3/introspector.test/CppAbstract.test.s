( function _CppAbstract_test_s_( )
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
`#include <vector>
#include <iostream>
#include <algorithm>
#include <functional>
using namespace std;

struct TIME
{
  int seconds;
  int minutes;
  int hours;
};

struct X {
    int x, y;
    int operator()(int);
    void f()
    {
        // the context of the following lambda is the member function X::f
        [=]()->int
        {
            return operator()(this->x + y); // X::operator()(this->x + (*this).y)
                                            // this has type X*
        };
    }
};

/* comment1 */

int main()
{
    std::vector<int> c = {1, 2, 3, 4, 5, 6, 7};
    int x = 5;
    c.erase(std::remove_if(c.begin(), c.end(), [x](int n) { return n < x; }), c.end());

    std::cout << "c: ";
    std::for_each(c.begin(), c.end(), [](int i){ std::cout << i << ' '; });
    std::cout << '\n';

    // the type of a closure cannot be named, but can be inferred with auto
    // since C++14, lambda could own default arguments
    auto func1 = [](int i = 6) { return i + 4; };
    std::cout << "func1: " << func1() << '\n';

    // like all callable objects, closures can be captured in std::function
    // (this may incur unnecessary overhead)
    std::function<int(int)> func2 = [](int i) { return i + 4; };
    std::cout << "func2: " << func2(6) << '\n';
}
`

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
  test.identical( file.product.byType.gRoutine.length, 7 );
  test.identical( file.product.byType.gComment.length, 8 );
  test.identical( file.product.byType.gRoot.length, 1 );
  test.true( file.product.root === file.product.byType.gRoot.withIndex( 0 ) );

  // translation_unit : 1
  // gRoot : 1
  // using_declaration : 1
  // operator_name : 1
  // lambda_default_capture : 1
  // trailing_return_type : 1
  // this : 1
  // initializer_list : 1
  // char_literal : 1
  // auto : 1
  // optional_parameter_declaration : 1
  // struct_specifier : 2
  // field_declaration_list : 2
  // function_definition : 2
  // template_type : 2
  // scoped_type_identifier : 2
  // template_argument_list : 2
  // type_descriptor : 2
  // function_declarator : 3
  // string_literal : 3
  // preproc_include : 4
  // system_lib_string : 4
  // type_identifier : 4
  // return_statement : 4
  // declaration : 4
  // init_declarator : 4
  // field_declaration : 5
  // parameter_declaration : 5
  // lambda_expression : 5
  // lambda_capture_specifier : 5
  // abstract_function_declarator : 6
  // compound_statement : 7
  // field_expression : 7
  // scoped_identifier : 7
  // comment : 8
  // gComment : 8
  // expression_statement : 8
  // parameter_list : 9
  // namespace_identifier : 9
  // binary_expression : 11
  // call_expression : 12
  // argument_list : 12
  // number_literal : 12
  // field_identifier : 13
  // primitive_type : 17
  // identifier : 33
  // syntax : 178

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

  name : 'Tools.mid.Introspector.Cpp',
  abstract : 1,

  context :
  {

    tsProgramSourceCode1,
    defaultProgramSourceCode : tsProgramSourceCode1,
    exts : [ 'cpp', 'c', 'hpp', 'h' ],

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
