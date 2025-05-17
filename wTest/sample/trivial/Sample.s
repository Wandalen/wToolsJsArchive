if( typeof module !== 'undefined' )
require( 'wtest' );

let _ = wTools;

//

function arrayIs( test )
{

  test.case = 'an empty array';
  var got = _.arrayIs( [] );
  var expected = true;
  test.identical( got, expected );

  test.case = 'an array';
  var got = _.arrayIs( [ 1, 2, 3 ] );
  var expected  = true;
  test.identical( got, expected );

  test.case = 'object';
  var got = _.arrayIs( {} );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'number';
  var got = _.arrayIs( 6 );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'string';
  var got = _.arrayIs( 'abc' );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'boolean';
  var got = _.arrayIs( true );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'function';
  var got = _.arrayIs( function(){} );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'a pseudo array';
  var got = ( function()
  {
    return _.arrayIs( arguments );
  } )('Hello there!');
  var expected = false;
  test.identical( got, expected );

  test.case = 'no argument';
  var got = _.arrayIs();
  var expected  = false;
  test.identical( got, expected );

  test.case = 'null';
  var got = _.arrayIs( null );
  var expected  = false;
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;
}

//

let Self =
{

  name : 'Sample/Trivial',
  silencing : 1,

  tests :
  {

    arrayIs,

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

