( function _l0_l3_Set_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( '../Include3.s' );
  require( 'wTesting' );
}

const _global = _global_;
const _ = _global_.wTools;
const __ = _globals_.testing.wTools;

// --
// tests
// --

function aptLeft( test )
{

  /* */

  test.case = 'left';
  var src = new Set([ 1, 2, 3 ]);
  var ops = [];
  var got = _.set.aptLeft( src, function( val )
  {
    ops.push( Array.prototype.slice.call( arguments ) );
    if( val === 1 )
    return val + 10;
  });
  var exp = [ 11, 1, 0, true ];
  test.identical( got, exp );
  var exp =
  [
    [
      1,
      1,
      0,
      src,
    ],
  ]
  test.identical( ops, exp );

  /* */

  test.case = 'middle';
  var src = new Set([ 1, 2, 3 ]);
  var ops = [];
  var got = _.set.aptLeft( src, function( val )
  {
    ops.push( Array.prototype.slice.call( arguments ) );
    if( val === 2 )
    return val + 10;
  });
  var exp = [ 12, 2, 1, true ];
  test.identical( got, exp );
  var exp =
  [
    [
      1,
      1,
      0,
      src,
    ],
    [
      2,
      2,
      1,
      src,
    ]
  ]
  test.identical( ops, exp );

  /* */

  test.case = 'right';
  var src = new Set([ 1, 2, 3 ]);
  var ops = [];
  var got = _.set.aptLeft( src, function( val )
  {
    ops.push( Array.prototype.slice.call( arguments ) );
    if( val === 3 )
    return val + 10;
  });
  var exp = [ 13, 3, 2, true ];
  test.identical( got, exp );
  var exp =
  [
    [
      1,
      1,
      0,
      src,
    ],
    [
      2,
      2,
      1,
      src,
    ],
    [
      3,
      3,
      2,
      src,
    ]
  ]
  test.identical( ops, exp );

  /* */

  test.case = 'no';
  var src = new Set([ 1, 2, 3 ]);
  var ops = [];
  var got = _.set.aptLeft( src, function( val )
  {
    ops.push( Array.prototype.slice.call( arguments ) );
    if( val === 4 )
    return val + 10;
  });
  var exp = [ 3, 3, 2, false ];
  test.identical( got, exp );
  var exp =
  [
    [
      1,
      1,
      0,
      src,
    ],
    [
      2,
      2,
      1,
      src,
    ],
    [
      3,
      3,
      2,
      src,
    ]
  ]
  test.identical( ops, exp );

  /* */

  test.case = 'empty';
  var src = new Set([]);
  var ops = [];
  var got = _.set.aptLeft( src, function( val )
  {
    ops.push( Array.prototype.slice.call( arguments ) );
    if( val === 4 )
    return val + 10;
  });
  var exp = [ undefined, undefined, -1, false ];
  test.identical( got, exp );
  var exp =
  [
  ]
  test.identical( ops, exp );

  /* */

  test.case = 'without callback';
  var src = new Set([ 1, 2, 3 ]);
  var exp = [ 1, 1, 0, true ];
  var got = _.set.aptLeft( src );
  test.identical( got, exp );
  var exp = [ 1, 1, 0, true ];
  var got = _.set.first( src );
  test.identical( got, exp );

  /* */

  test.case = 'without callback, empty';
  var src = new Set([]);
  var exp = [ undefined, undefined, -1, false ];
  var got = _.set.aptLeft( src );
  test.identical( got, exp );
  var exp = [ undefined, undefined, -1, false ];
  var got = _.set.first( src );
  test.identical( got, exp );

  /* */

}

//

function aptRight( test )
{

  /* */

  test.case = 'left';
  var src = new Set([ 1, 2, 3 ]);
  var ops = [];
  var got = _.set.aptRight( src, function( val )
  {
    ops.push( Array.prototype.slice.call( arguments ) );
    if( val === 1 )
    return val + 10;
  });
  var exp = [ 11, 1, 0, true ];
  test.identical( got, exp );
  var exp =
  [
    [
      3,
      3,
      2,
      src,
    ],
    [
      2,
      2,
      1,
      src,
    ],
    [
      1,
      1,
      0,
      src,
    ]
  ]
  test.identical( ops, exp );

  /* */

  test.case = 'middle';
  var src = new Set([ 1, 2, 3 ]);
  var ops = [];
  var got = _.set.aptRight( src, function( val )
  {
    ops.push( Array.prototype.slice.call( arguments ) );
    if( val === 2 )
    return val + 10;
  });
  var exp = [ 12, 2, 1, true ];
  test.identical( got, exp );
  var exp =
  [
    [
      3,
      3,
      2,
      src,
    ],
    [
      2,
      2,
      1,
      src,
    ]
  ]
  test.identical( ops, exp );

  /* */

  test.case = 'right';
  var src = new Set([ 1, 2, 3 ]);
  var ops = [];
  var got = _.set.aptRight( src, function( val )
  {
    ops.push( Array.prototype.slice.call( arguments ) );
    if( val === 3 )
    return val + 10;
  });
  var exp = [ 13, 3, 2, true ];
  test.identical( got, exp );
  var exp =
  [
    [
      3,
      3,
      2,
      src,
    ]
  ]
  test.identical( ops, exp );

  /* */

  test.case = 'no';
  var src = new Set([ 1, 2, 3 ]);
  var ops = [];
  var got = _.set.aptRight( src, function( val )
  {
    ops.push( Array.prototype.slice.call( arguments ) );
    if( val === 4 )
    return val + 10;
  });
  var exp = [ 1, 1, 0, false ];
  test.identical( got, exp );
  var exp =
  [
    [
      3,
      3,
      2,
      src,
    ],
    [
      2,
      2,
      1,
      src,
    ],
    [
      1,
      1,
      0,
      src,
    ],
  ]
  test.identical( ops, exp );

  /* */

  test.case = 'empty';
  var src = new Set([]);
  var ops = [];
  var got = _.set.aptRight( src, function( val )
  {
    ops.push( Array.prototype.slice.call( arguments ) );
    if( val === 4 )
    return val + 10;
  });
  var exp = [ undefined, undefined, -1, false ];
  test.identical( got, exp );
  var exp =
  [
  ]
  test.identical( ops, exp );

  /* */

  test.case = 'without callback';
  var src = new Set([ 1, 2, 3 ]);
  var exp = [ 3, 3, 2, true ];
  var got = _.set.aptRight( src );
  test.identical( got, exp );
  var exp = [ 3, 3, 2, true ];
  var got = _.set.last( src );
  test.identical( got, exp );

  /* */

  test.case = 'without callback, empty';
  var src = new Set([]);
  var exp = [ undefined, undefined, -1, false ];
  var got = _.set.aptRight( src );
  test.identical( got, exp );
  var exp = [ undefined, undefined, -1, false ];
  var got = _.set.last( src );
  test.identical( got, exp );

  /* */

}

//

function lengthOf( test )
{
  test.case = 'empty set';
  var src = new Set([]);
  var got = _.set.lengthOf( src );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'set of numbers';
  var src = new Set([ 1, 2, 3 ]);
  var got = _.set.lengthOf( src );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'set with undefined and boolean';
  var src = new Set([ 1, undefined, false ]);
  var got = _.set.lengthOf( src );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'extra argument';
  test.shouldThrowErrorSync( () => _.set.lengthOf( new Set( [ 1, 3 ] ), [] ) );
  test.shouldThrowErrorSync( () => _.set.lengthOf( new Set( [ 1, 3 ] ), 2 ) );
  test.shouldThrowErrorSync( () => _.set.lengthOf( new Set( [ 1, 3 ] ), 'str' ) );

  test.case = 'wrong src';
  test.shouldThrowErrorSync( () => _.set.lengthOf( 'wrong' ) );
  test.shouldThrowErrorSync( () => _.set.lengthOf( 2 ) );
  test.shouldThrowErrorSync( () => _.set.lengthOf( [] ) );
  test.shouldThrowErrorSync( () => _.set.lengthOf( new Set( {} ) ));
}

//

function hasKey( test )
{
  test.case = 'ordinary';
  var src = new Set([ 1, 2, 3 ]);
  test.identical( _.set.hasKey( src, 0 ), false );
  test.identical( _.set.hasKey( src, 1 ), true );
  test.identical( _.set.hasKey( src, 2 ), true );
  test.identical( _.set.hasKey( src, 3 ), true );

  test.case = 'undefined key';
  var src = new Set([ 1, 2, 3, [ 1, 3 ] ]);
  var got = _.set.hasKey( src, undefined );
  var expected = false;
  test.identical( got, expected );

  test.case = 'set with undefined key';
  var src = new Set([ 1, 2, 3, undefined ]);
  var got = _.set.hasKey( src, undefined );
  var expected = true;
  test.identical( got, expected );

  test.case = 'wrong src';
  test.shouldThrowErrorSync( () => _.set.hasKey( 2, 2 ) );
  test.shouldThrowErrorSync( () => _.set.hasKey( new Set( {} ) ) );
}

//

function hasCardinal( test )
{
  test.case = 'ordinary';
  var src = new Set([ 1, 2, 3 ]);
  test.identical( _.set.hasCardinal( src, -1 ), false );
  test.identical( _.set.hasCardinal( src, 0 ), true );
  test.identical( _.set.hasCardinal( src, 1 ), true );
  test.identical( _.set.hasCardinal( src, 2 ), true );
  test.identical( _.set.hasCardinal( src, 3 ), false );
  test.identical( _.set.hasCardinal( src, undefined ), false );

  test.case = 'empty set';
  var src = new Set([]);
  test.identical( _.set.hasCardinal( src ), false );
  test.identical( _.set.hasCardinal( src, 0 ), false );
  test.identical( _.set.hasCardinal( src, -1 ), false );
  test.identical( _.set.hasCardinal( src, {} ), false );

  test.case = 'wrong src';
  test.shouldThrowErrorSync( () => _.set.hasCardinal( 2, 2 ) );
  test.shouldThrowErrorSync( () => _.set.hasCardinal( new Set( {} ) ) );
}

//

function keyWithCardinal( test )
{
  test.case = 'ordinary';
  var src = new Set([ 1, 2, 3 ]);
  test.identical( _.set.keyWithCardinal( src, -1 ), [ undefined, false ] );
  test.identical( _.set.keyWithCardinal( src, 0 ), [ 1, true ] );
  test.identical( _.set.keyWithCardinal( src, 1 ), [ 2, true ] );
  test.identical( _.set.keyWithCardinal( src, 2 ), [ 3, true ] );
  test.identical( _.set.keyWithCardinal( src, 3 ), [ undefined, false ] );
  test.identical( _.set.keyWithCardinal( src, undefined ), [ undefined, true ] );

  test.case = 'duplicate';
  var src = new Set([ 22, 1, 22, 2, 22, 3 ]);
  test.identical( _.set.keyWithCardinal( src, -1 ), [ undefined, false ] );
  test.identical( _.set.keyWithCardinal( src, 0 ), [ 22, true ] );
  test.identical( _.set.keyWithCardinal( src, 1 ), [ 1, true ] );
  test.identical( _.set.keyWithCardinal( src, 2 ), [ 2, true ] );
  test.identical( _.set.keyWithCardinal( src, 3 ), [ 3, true ] );
  test.identical( _.set.keyWithCardinal( src, 4 ), [ undefined, false ] );

  test.case = 'empty set';
  var src = new Set([]);
  test.identical( _.set.keyWithCardinal( src, undefined ), [ undefined, true ] );
  test.identical( _.set.keyWithCardinal( src, 0 ), [ undefined, false ] );
  test.identical( _.set.keyWithCardinal( src, -1 ), [ undefined, false ] );
  test.identical( _.set.keyWithCardinal( src, {} ), [ undefined, true ] );

  test.case = 'wrong src';
  test.shouldThrowErrorSync( () => _.set.keyWithCardinal( 2, 2 ) );
  test.shouldThrowErrorSync( () => _.set.keyWithCardinal( new Set( {} ) ) );
}

//

function cardinalWithKey( test )
{
  test.case = 'ordinary';
  var src = new Set([ 1, 2, 3 ]);
  test.identical( _.set.cardinalWithKey( src, 0 ), -1 );
  test.identical( _.set.cardinalWithKey( src, 1 ), 0 );
  test.identical( _.set.cardinalWithKey( src, 2 ), 1 );
  test.identical( _.set.cardinalWithKey( src, 3 ), 2 );
  test.identical( _.set.cardinalWithKey( src, undefined ), -1 );

  test.case = 'duplicate';
  var src = new Set([ 22, 1, undefined, 2, 22, undefined ]);
  test.identical( _.set.cardinalWithKey( src, 22 ), 0 );
  test.identical( _.set.cardinalWithKey( src, 1 ), 1 );
  test.identical( _.set.cardinalWithKey( src, undefined ), 2 );
  test.identical( _.set.cardinalWithKey( src, 2 ), 3 );

  test.case = 'wrong src';
  test.shouldThrowErrorSync( () => _.set.cardinalWithKey( 2, 2 ) );
  test.shouldThrowErrorSync( () => _.set.cardinalWithKey( new Set( {} ) ) );
}

// --
// declaration
// --

const Proto =
{

  name : 'Tools.Set.l0.l3',
  silencing : 1,

  tests :
  {

    aptLeft,
    aptRight,
    lengthOf,
    hasKey,
    hasCardinal,
    keyWithCardinal,
    cardinalWithKey,

  }

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
