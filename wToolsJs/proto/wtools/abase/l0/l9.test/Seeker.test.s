( function _l0_l9_Seeker_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( 'Tools' );
  require( 'wTesting' );
}

const _global = _global_;
const _ = _global_.wTools;
const __ = _globals_.testing.wTools;

// --
// tests
// --

function basic( test )
{

  /* - */

  test.case = 'basic';

  test.true( _.aux.is( _.seeker ) );

  var o =
  {
  };
  var it1 = _.seeker.Seeker.head( { defaults : _.seeker.Seeker }, [ o ] );
  test.true( _.seeker.Seeker.iterationProper( it1 ) );
  test.true( _.seeker.Seeker.iteratorProper( _.prototype.each( it1 )[ 3 ] ) );
  test.true( _.seeker.iterationIs( it1 ) );
  test.true( _.seeker.iteratorIs( _.prototype.each( it1 )[ 3 ] ) );
  test.true( _.seeker.is( _.prototype.each( it1 )[ 4 ] ) );
  test.identical( _.prototype.each( it1 ).length, 5 );
  test.true( _.prototype.each( it1 )[ 3 ] === it1.iterator );
  test.true( _.prototype.each( it1 )[ 4 ] === it1.Seeker );

  var it2 = it1.iterationMake();
  test.true( _.seeker.Seeker.iterationProper( it2 ) );
  test.true( _.seeker.Seeker.iteratorProper( _.prototype.each( it2 )[ 2 ] ) );
  test.true( _.seeker.iterationIs( it2 ) );
  test.true( _.seeker.iteratorIs( _.prototype.each( it2 )[ 2 ] ) );
  test.true( _.seeker.is( _.prototype.each( it2 )[ 3 ] ) );
  test.identical( _.prototype.each( it2 ).length, 4 );
  test.true( _.prototype.each( it2 )[ 2 ] === it2.iterator );
  test.true( _.prototype.each( it2 )[ 3 ] === it2.Seeker );

  /* - */

}

//

function classDefineBasic( test )
{

  /* - */

  test.case = 'basic';

  var Seeker1 = _.seeker.classDefine
  ({
    name : 'custom',
    seeker :
    {
    },
    iterator :
    {
    },
    iteration :
    {
    },
    iterationPreserve :
    {
    },
  });

  var o =
  {
  };
  var it1 = Seeker1.head( { defaults : Seeker1 }, [ o ] );
  test.true( !_.seeker.Seeker.iterationProper( it1 ) );
  test.true( !_.seeker.Seeker.iteratorProper( _.prototype.each( it1 )[ 2 ] ) );
  test.true( Seeker1.iterationProper( it1 ) );
  test.true( Seeker1.iteratorProper( _.prototype.each( it1 )[ 3 ] ) );
  test.true( _.seeker.iterationIs( it1 ) );
  test.true( _.seeker.iteratorIs( _.prototype.each( it1 )[ 3 ] ) );
  test.true( _.seeker.is( _.prototype.each( it1 )[ 4 ] ) );
  test.identical( _.prototype.each( it1 ).length, 5 );
  test.true( _.prototype.each( it1 )[ 3 ] === it1.iterator );
  test.true( _.prototype.each( it1 )[ 4 ] === it1.Seeker );

  var it2 = it1.iterationMake();
  test.true( !_.seeker.Seeker.iterationProper( it2 ) );
  test.true( !_.seeker.Seeker.iteratorProper( _.prototype.each( it2 )[ 2 ] ) );
  test.true( Seeker1.iterationProper( it2 ) );
  test.true( Seeker1.iteratorProper( _.prototype.each( it2 )[ 2 ] ) );
  test.true( _.seeker.iterationIs( it2 ) );
  test.true( _.seeker.iteratorIs( _.prototype.each( it2 )[ 2 ] ) );
  test.true( _.seeker.is( _.prototype.each( it2 )[ 3 ] ) );
  test.identical( _.prototype.each( it2 ).length, 4 );
  test.true( _.prototype.each( it2 )[ 2 ] === it2.iterator );
  test.true( _.prototype.each( it2 )[ 3 ] === it2.Seeker );

  /* - */

}

//

function headField( test )
{

  /* - */

  test.case = 'without iterationPreserve';

  var Seeker1 = _.seeker.classDefine
  ({
    name : 'custom',
    seeker :
    {
      option1 : 0,
    },
    iterator :
    {
      option1 : 0,
    },
    iteration :
    {
      option1 : 0,
    },
    iterationPreserve :
    {
    },
  });

  var o =
  {
    option1 : 1,
  };
  var it1 = Seeker1.head( { defaults : Seeker1 }, [ o ] );
  test.identical( it1.option1, 1 );

  var it2 = it1.iterationMake();
  test.identical( it2.option1, 0 );

  var it3 = it2.iterationMake();
  test.identical( it3.option1, 0 );

  /* - */

  test.case = 'with iterationPreserve';

  var Seeker1 = _.seeker.classDefine
  ({
    name : 'custom',
    seeker :
    {
      option1 : 0,
    },
    iterator :
    {
      option1 : 0,
    },
    iteration :
    {
      option1 : 0,
    },
    iterationPreserve :
    {
      option1 : 0,
    },
  });

  var o =
  {
    option1 : 1,
  };
  var it1 = Seeker1.head( { defaults : Seeker1 }, [ o ] );
  test.identical( it1.option1, 1 );

  var it2 = it1.iterationMake();
  test.identical( it2.option1, 1 );

  it2.option1 = 2;
  var it3 = it2.iterationMake();
  test.identical( it3.option1, 2 );

  /* - */

  test.case = 'withщге iteration';

  var Seeker1 = _.seeker.classDefine
  ({
    name : 'custom',
    seeker :
    {
      option1 : 0,
    },
    iterator :
    {
      option1 : 0,
    },
    iteration :
    {
    },
    iterationPreserve :
    {
    },
  });

  var o =
  {
    option1 : 1,
  };
  var it1 = Seeker1.head( { defaults : Seeker1 }, [ o ] );
  test.identical( it1.option1, 1 );

  var it2 = it1.iterationMake();
  test.identical( it2.option1, 1 );

  it2.option1 = 2;
  var it3 = it2.iterationMake();
  test.identical( it3.option1, 1 );

  /* - */

}

headField.description =
`
Routine 'optionsToIteration' should preserve value of option::option1 for the first iteration.
If option::option1 is not listed in Iteration then option::option1 is preserved for all iteration, not only the first.
`

// --
// declaration
// --

const Proto =
{

  name : 'Tools.Seeker.l0.l9',
  silencing : 1,

  tests :
  {

    basic,
    classDefineBasic,
    headField,

  }

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
