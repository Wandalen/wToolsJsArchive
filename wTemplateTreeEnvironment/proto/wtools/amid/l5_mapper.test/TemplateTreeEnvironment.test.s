( function _TemplateTreeEnvironment_test_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../node_modules/Tools' );

  _.include( 'wTesting' );

  require( '../l5_mapper/TemplateTreeEnvironment.s' );

}

//

const _ = _global_.wTools;
const Parent = wTester;

var tree =
{

  atomic1 : 'a1',
  atomic2 : 2,
  somePath : 'TemplateTreeEnvironment.test.s',

}

// --
// test
// --

function trivial( test )
{
  var self = this;
  var template = new wTemplateTreeEnvironment
  ({
    tree,
    prefixToken : '{',
    postfixToken : '}',
    upToken : '.',
    basePath : __dirname,
  });

  /* */

  var got = template.select( 'atomic1' );
  var expected = 'a1';
  test.identical( got, expected );

  var got = template.select( 'atomic2' );
  var expected = 2;
  test.identical( got, expected );

  var got = template.pathGet( '{somePath}' );
  var expected = _.path.normalize( __filename );
  test.identical( got, expected );

}

function valueTry( test )
{
  var tree =
  {
    prefix : {},
  }

  var env = new wTemplateTreeEnvironment
  ({
    tree,
    prefixToken : '{{',
    postfixToken : '}}',
    upToken : '/',
  });

  /**/

  var def = 'view';
  var got = env.valueTry( '{{/prefix/view}}', def );
  test.identical( got, def );
}

// --
// declare
// --

const Proto =
{

  name : 'Tools.mid.TemplateTreeEnvironment',
  silencing : 1,

  tests :
  {

    trivial,
    valueTry,

  },

};

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
