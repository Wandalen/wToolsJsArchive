( function _ArraySparse_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../node_modules/Tools' );

  _.include( 'wTesting' );

  require( '../l4/ArraySparse.s' );

}

const _global = _global_;
const _ = _global_.wTools;
const Parent = wTester;

// --
// test
// --

function minimize( test )
{

  test.case = 'trivial';

  var src = [ 3, 5, 5, 7, 7, 7, 11, 11, 11, 11, 11, 11, 15, 20 ];
  var expected = [ 3, 7, 11, 11, 15, 20 ];
  var got = _.sparse.minimize( src );
  test.identical( got, expected );
  test.true( got !== src );

  test.case = 'empty';

  var src = [];
  var expected = [];
  var got = _.sparse.minimize( src );
  test.identical( got, expected );
  test.true( got !== src );

  test.case = 'single';

  var src = [ -3, +3 ];
  var expected = [ -3, +3 ];
  var got = _.sparse.minimize( src );
  test.identical( got, expected );
  test.true( got !== src );

  test.case = 'two separate';

  var src = [ -3, +3, 13, 13 ];
  var expected = [ -3, +3, 13, 13 ];
  var got = _.sparse.minimize( src );
  test.identical( got, expected );
  test.true( got !== src );

  test.case = 'two continuous';

  var src = [ -3, +3, 3, 13 ];
  var expected = [ -3, 13 ];
  var got = _.sparse.minimize( src );
  test.identical( got, expected );
  test.true( got !== src );

  test.case = 'typed';

  var src = new I32x([ 3, 5, 5, 7, 7, 7, 11, 11, 11, 11, 11, 11, 15, 20 ]);
  var expected = new I32x([ 3, 7, 11, 11, 15, 20 ]);
  var got = _.sparse.minimize( src );
  test.identical( got, expected );
  test.true( got !== src );

}

//

function invertFinite( test )
{

  test.case = 'trivial';

  var src      = [ 3, 5, 5, 7, 7, 7, 11, 11, 11, 11, 11, 11, 15, 20 ];
  var expected = [ 3, 3, 5, 5, 7, 7, 7, 11, 11, 11, 11, 11, 11, 15, 20, 20 ];
  var got = _.sparse.invertFinite( src );
  test.identical( got, expected );
  test.true( got !== src );
  var got2 = _.sparse.invertFinite( got );
  test.identical( got2, src );
  test.true( got !== got2 );

  test.case = 'empty';

  var src = [];
  var expected = [];
  var got = _.sparse.invertFinite( src );
  test.identical( got, expected );
  test.true( got !== src );
  var got2 = _.sparse.invertFinite( got );
  test.identical( got2, src );
  test.true( got !== got2 );

  test.case = 'single';

  var src = [ -3, +3 ];
  var expected = [ -3, -3, +3, +3 ];
  var got = _.sparse.invertFinite( src );
  test.identical( got, expected );
  test.true( got !== src );
  var got2 = _.sparse.invertFinite( got );
  test.identical( got2, src );
  test.true( got !== got2 );

  test.case = 'single empty interval';

  var src = [ 3, 3 ];
  var expected = [ 3, 3 ];
  var got = _.sparse.invertFinite( src );
  test.identical( got, expected );
  test.true( got !== src );
  var got2 = _.sparse.invertFinite( got );
  test.identical( got2, src );
  test.true( got !== got2 );

  test.case = 'two separate empty intervals';

  var src = [ -3, -3, 13, 13 ];
  var expected = [ -3, 13 ];
  var got = _.sparse.invertFinite( src );
  test.identical( got, expected );
  test.true( got !== src );
  var got2 = _.sparse.invertFinite( got );
  test.identical( got2, src );
  test.true( got !== got2 );

  test.case = 'three separate empty intervals';

  var src = [ -3, -3, 5, 5, 13, 13 ];
  var expected = [ -3, 5, 5, 13 ];
  var got = _.sparse.invertFinite( src );
  test.identical( got, expected );
  test.true( got !== src );
  var got2 = _.sparse.invertFinite( got );
  test.identical( got2, src );
  test.true( got !== got2 );

  test.case = 'two separate intervals, left is empty';

  var src = [ -3, -3, 11, 13 ];
  var expected = [ -3, 11, 13, 13 ];
  var got = _.sparse.invertFinite( src );
  test.identical( got, expected );
  test.true( got !== src );
  var got2 = _.sparse.invertFinite( got );
  test.identical( got2, src );
  test.true( got !== got2 );

  test.case = 'two separate intervals, right is empty';

  var src = [ -3, 0, 13, 13 ];
  var expected = [ -3, -3, 0, 13 ];
  var got = _.sparse.invertFinite( src );
  test.identical( got, expected );
  test.true( got !== src );
  var got2 = _.sparse.invertFinite( got );
  test.identical( got2, src );
  test.true( got !== got2 );

  test.case = 'two continuous';

  var src = [ -3, +3, 3, 13 ];
  var expected = [ -3, -3, 3, 3, 13, 13 ];
  var got = _.sparse.invertFinite( src );
  test.identical( got, expected );
  test.true( got !== src );
  var got2 = _.sparse.invertFinite( got );
  test.identical( got2, src );
  test.true( got !== got2 );

  test.case = 'typed';

  var src = new I32x([ 3, 5, 5, 7, 7, 7, 11, 11, 11, 11, 11, 11, 15, 20 ]);
  var expected = new I32x([ 3, 3, 5, 5, 7, 7, 7, 11, 11, 11, 11, 11, 11, 15, 20, 20 ]);
  var got = _.sparse.invertFinite( src );
  test.identical( got, expected );
  test.true( got !== src );
  var got2 = _.sparse.invertFinite( got );
  test.identical( got2, src );
  test.true( got !== got2 );

}

// --
// declare
// --

const Proto =
{

  name : 'Tools.l4.ArraySparse',
  silencing : 1,

  tests :
  {

    minimize,
    invertFinite,

  },

};

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
