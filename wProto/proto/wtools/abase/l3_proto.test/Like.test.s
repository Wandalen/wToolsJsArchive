( function _Like_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( '../../../node_modules/Tools' );

  _.include( 'wTesting' );

  require( '../../abase/l3_proto/Include.s' );

}
const _global = _global_;
const _ = _global_.wTools;

// --
// test
// --

function isLike( test )
{
  var self = this;

  var Base1 = _.like().end;
  var Base2 = _.like().end;
  var Mid = _.like( Base1, Base2 ).end;

  test.case = 'Base1 class like itself';
  var is = _.lconstruction.isLike( Base1, Base1 );
  test.true( is );

  test.case = 'Mid class like itself';
  var is = _.lconstruction.isLike( Mid, Mid );
  test.true( is );

  test.case = 'Mid class like one of parent';
  var is = _.lconstruction.isLike( Mid, Base1 );
  test.true( is );
  var is = _.lconstruction.isLike( Mid, Base2 );
  test.true( is );

  /* */

  test.case = 'base instance like base class';
  var base1 = Base1.constructor();
  var is = _.lconstruction.isLike( base1, Base1 );
  test.true( is );

  test.case = 'base instance like another base class';
  var base1 = Base1.constructor();
  var is = _.lconstruction.isLike( base1, Base2 );
  test.true( !is );

  test.case = 'mid instance like one of class';
  var mid = Mid.constructor();
  var is = _.lconstruction.isLike( mid, Mid );
  test.true( is );
  var is = _.lconstruction.isLike( mid, Base1 );
  test.true( is );
  var is = _.lconstruction.isLike( mid, Base2 );
  test.true( is );

}

// --
// declare
// --

const Proto =
{

  name : 'Tools.l3.ProtoLike',
  silencing : 1,

  tests :
  {

    isLike,

  },

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
