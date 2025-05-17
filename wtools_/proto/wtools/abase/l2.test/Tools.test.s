( function _Tools_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( 'Tools' );

  _.include( 'wTesting' );

  require( '../../abase/l2/Include.s' );

}

const _global = _global_;
const _ = _global_.wTools;

// --
// tests
// --

function routinesOfTools( test )
{
  test.case = 'routines _.array*';
  test.true( _.routineIs( _.arrayIs ) );
  test.true( _.routineIs( _.arrayRemove ) );

  test.case = 'routines _.map*';
  test.true( _.routineIs( _.mapIs ) );
  test.true( _.routineIs( _.props.extend ) );

  test.case = 'routines _.str*';
  test.true( _.routineIs( _.mapIs ) );
  test.true( _.routineIs( _.props.extend ) );
}

// --
// declare
// --

const Proto =
{

  name : 'Tools.l2.tools',
  silencing : 1,

  tests :
  {

    routinesOfTools,

  },

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
