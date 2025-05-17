( function _Trie_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( 'Tools' );
  require( '../l1/l1/Trie.s' );
  _.include( 'wTesting' );
}

const _ = _global_.wTools;
const __ = _globals_.testing.wTools;

// --
// write
// --

function makeWithPathBasic( test )
{

  /* */

  test.case = '1 level';
  var got = _.trie.makeWithPath( null, [ 'a' ] );
  var exp =
  {
    vals : new Set,
    ups :
    {
      a :
      {
        vals : new Set(),
        ups : {},
      }
    }
  };
  test.identical( got.root, exp );
  test.true( got.child === got.root.ups.a );

  /* */

  test.case = '2 levels';
  var got = _.trie.makeWithPath( null, [ 'a', 'b' ] );
  var exp =
  {
    vals : new Set,
    ups :
    {
      a :
      {
        vals : new Set,
        ups :
        {
          b :
          {
            vals : new Set,
            ups : {},
          }
        },
      }
    }
  };
  test.identical( got.root, exp );
  test.true( got.child === got.root.ups.a.ups.b );

  /* */

  test.case = '0 + 1 + 2';
  var root = null;
  var got = _.trie.makeWithPath( root, [] );
  root = got.root;
  var got = _.trie.makeWithPath( root, [ 'a' ] )
  test.true( got.root === root );
  var got = _.trie.makeWithPath( root, [ 'a', 'b' ] );
  test.true( got.root === root );
  var exp =
  {
    vals : new Set,
    ups :
    {
      a :
      {
        vals : new Set,
        ups :
        {
          b :
          {
            vals : new Set,
            ups : {},
          }
        },
      }
    }
  };
  test.identical( got.root, exp );

  /* */

  test.case = '2 + 1 + 0';
  var root = null;
  var got = _.trie.makeWithPath( root, [ 'a', 'b' ] );
  root = got.root;
  var got = _.trie.makeWithPath( root, [ 'a' ] )
  test.true( got.root === root );
  var got = _.trie.makeWithPath( root, [] );
  test.true( got.root === root );
  var exp =
  {
    vals : new Set,
    ups :
    {
      a :
      {
        vals : new Set,
        ups :
        {
          b :
          {
            vals : new Set,
            ups : {},
          }
        },
      }
    }
  };
  test.identical( got.root, exp );

  /* */

  test.case = '1 + 0 + 2';
  var root = null;
  var got = _.trie.makeWithPath( root, [ 'a' ] );
  root = got.root;
  var got = _.trie.makeWithPath( root, [ 'a', 'b' ] );
  test.true( got.root === root );
  var got = _.trie.makeWithPath( root, [] );
  test.true( got.root === root );
  var exp =
  {
    vals : new Set,
    ups :
    {
      a :
      {
        vals : new Set,
        ups :
        {
          b :
          {
            vals : new Set,
            ups : {},
          }
        },
      }
    }
  };
  test.identical( got.root, exp );

  /* */

}

//

function addMultipleBasic( test )
{

  /* */

  test.case = '1 level';
  var val = { f1 : 1 };
  var got = _.trie.addMultiple( null, [ 'a' ], [ val ] );
  var exp =
  {
    vals : new Set,
    ups :
    {
      a :
      {
        vals : new Set([{ f1 : 1 }]),
        ups : {},
      }
    }
  };
  test.identical( got.root, exp );
  test.true( [ ... got.root.ups.a.vals ][ 0 ] === val );
  test.true( got.child === got.root.ups.a );

  /* */

  test.case = '2 levels';
  var val = { f1 : 1 };
  var got = _.trie.addMultiple( null, [ 'a', 'b' ], [ val ] );
  var exp =
  {
    vals : new Set,
    ups :
    {
      a :
      {
        vals : new Set,
        ups :
        {
          b :
          {
            vals : new Set([{ f1 : 1 }]),
            ups : {},
          }
        },
      }
    }
  };
  test.identical( got.root, exp );
  test.true( [ ... got.root.ups.a.ups.b.vals ][ 0 ] === val );
  test.true( got.child === got.root.ups.a.ups.b );

  /* */

  test.case = '0 + 1 + 2';
  var root = null;
  var got = _.trie.addMultiple( root, [], [ 'val0' ] );
  root = got.root;
  var got = _.trie.addMultiple( root, [ 'a' ], [ 'vala1', 'vala2' ] )
  test.true( got.root === root );
  var got = _.trie.addMultiple( root, [ 'a', 'b' ], new Set([ 'valb1', 'valb2' ]) );
  test.true( got.root === root );
  var exp =
  {
    vals : new Set([ 'val0' ]),
    ups :
    {
      a :
      {
        vals : new Set([ 'vala1', 'vala2' ]),
        ups :
        {
          b :
          {
            vals : new Set([ 'valb1', 'valb2' ]),
            ups : {},
          }
        },
      }
    }
  };
  test.identical( got.root, exp );

  /* */

}

//

function addDeepBasic( test )
{

  /* */

  test.case = '1 level';
  var got = _.trie.addDeep( null, [ 'a' ], [ 'val1' ] );
  var exp =
  {
    vals : new Set([ 'val1' ]),
    ups :
    {
      a :
      {
        vals : new Set([ 'val1' ]),
        ups : {},
      }
    }
  };
  test.identical( got.root, exp );

  /* */

  test.case = '2 levels';
  var got = _.trie.addDeep( null, [ 'a', 'b' ], [ 'val1' ] );
  var exp =
  {
    vals : new Set([ 'val1' ]),
    ups :
    {
      a :
      {
        vals : new Set(),
        ups :
        {
          b :
          {
            vals : new Set([ 'val1' ]),
            ups : {},
          }
        },
      },
      b :
      {
        vals : new Set([ 'val1' ]),
        ups : {},
      },
    }
  };
  test.identical( got.root, exp );

  /* */

  test.case = '3 levels';
  var got = _.trie.addDeep( null, [ 'a', 'b', 'c' ], new Set([ 'val1', 'val2' ]) );
  var exp =
  {
    vals : new Set([ 'val1', 'val2' ]),
    ups :
    {
      a :
      {
        vals : new Set(),
        ups :
        {
          b :
          {
            vals : new Set(),
            ups :
            {
              c :
              {
                vals : new Set([ 'val1', 'val2' ]),
                ups :
                {
                },
              },
            },
          }
        },
      },
      b :
      {
        vals : new Set([]),
        ups :
        {
          c :
          {
            vals : new Set([ 'val1', 'val2' ]),
            ups : {},
          },
        },
      },
      c :
      {
        vals : new Set([ 'val1', 'val2' ]),
        ups : {},
      },
    },
  };
  test.identical( got.root, exp );

  /* */

  test.case = '3 levels, severall';
  var root = _.trie.make();
  var got = _.trie.addDeep( root, [ 'a' ], new Set([ 'vala' ]) );
  var got = _.trie.addDeep( root, [ 'a', 'b', 'c' ], new Set([ 'val1', 'val2' ]) );
  var exp =
  {
    vals : new Set([ 'vala', 'val1', 'val2' ]),
    ups :
    {
      a :
      {
        vals : new Set([ 'vala' ]),
        ups :
        {
          b :
          {
            vals : new Set(),
            ups :
            {
              c :
              {
                vals : new Set([ 'val1', 'val2' ]),
                ups :
                {
                },
              },
            },
          }
        },
      },
      b :
      {
        vals : new Set([]),
        ups :
        {
          c :
          {
            vals : new Set([ 'val1', 'val2' ]),
            ups : {},
          },
        },
      },
      c :
      {
        vals : new Set([ 'val1', 'val2' ]),
        ups : {},
      },
    },
  };
  test.identical( got.root, exp );

  /* */

}

//

function addSingleBasic( test )
{

  /* */

  test.case = '1 level';
  var val = { f1 : 1 };
  var got = _.trie.addSingle( null, [ 'a' ], val );
  var exp =
  {
    vals : new Set,
    ups :
    {
      a :
      {
        vals : new Set([{ f1 : 1 }]),
        ups : {},
      }
    }
  };
  test.identical( got.root, exp );
  test.true( [ ... got.root.ups.a.vals ][ 0 ] === val );
  test.true( got.child === got.root.ups.a );

  /* */

  test.case = '2 levels';
  var val = { f1 : 1 };
  var got = _.trie.addSingle( null, [ 'a', 'b' ], val );
  var exp =
  {
    vals : new Set,
    ups :
    {
      a :
      {
        vals : new Set,
        ups :
        {
          b :
          {
            vals : new Set([{ f1 : 1 }]),
            ups : {},
          }
        },
      }
    }
  };
  test.identical( got.root, exp );
  test.true( [ ... got.root.ups.a.ups.b.vals ][ 0 ] === val );
  test.true( got.child === got.root.ups.a.ups.b );

  /* */

  test.case = '0 + 1 + 2';
  var val0 = { f0 : 0 };
  var val1 = { f1 : 1 };
  var val2 = { f2 : 2 };
  var root = null;
  var got = _.trie.addSingle( root, [], val0 );
  root = got.root;
  var got = _.trie.addSingle( root, [ 'a' ], val1 )
  test.true( got.root === root );
  var got = _.trie.addSingle( root, [ 'a', 'b' ], val2 );
  test.true( got.root === root );
  var exp =
  {
    vals : new Set([{ f0 : 0 }]),
    ups :
    {
      a :
      {
        vals : new Set([{ f1 : 1 }]),
        ups :
        {
          b :
          {
            vals : new Set([{ f2 : 2 }]),
            ups : {},
          }
        },
      }
    }
  };
  test.identical( got.root, exp );
  test.identical( got.root.vals, new Set([ val0 ]) );
  test.identical( got.root.ups.a.vals, new Set([ val1 ]) );
  test.identical( got.root.ups.a.ups.b.vals, new Set([ val2 ]) );

  /* */

  test.case = '2 + 1 + 0';
  var val0 = { f0 : 0 };
  var val1 = { f1 : 1 };
  var val2 = { f2 : 2 };
  var root = null;
  var got = _.trie.addSingle( root, [ 'a', 'b' ], val2 );
  root = got.root;
  var got = _.trie.addSingle( root, [ 'a' ], val1 )
  test.true( got.root === root );
  var got = _.trie.addSingle( root, [], val0 );
  test.true( got.root === root );
  var exp =
  {
    vals : new Set([{ f0 : 0 }]),
    ups :
    {
      a :
      {
        vals : new Set([{ f1 : 1 }]),
        ups :
        {
          b :
          {
            vals : new Set([{ f2 : 2 }]),
            ups : {},
          }
        },
      }
    }
  };
  test.identical( got.root, exp );
  test.identical( got.root.vals, new Set([ val0 ]) );
  test.identical( got.root.ups.a.vals, new Set([ val1 ]) );
  test.identical( got.root.ups.a.ups.b.vals, new Set([ val2 ]) );

  /* */

  test.case = '1 + 0 + 2';
  var val0 = { f0 : 0 };
  var val1 = { f1 : 1 };
  var val2 = { f2 : 2 };
  var root = null;
  var got = _.trie.addSingle( root, [ 'a' ], val1 );
  root = got.root;
  var got = _.trie.addSingle( root, [ 'a', 'b' ], val2 );
  test.true( got.root === root );
  var got = _.trie.addSingle( root, [], val0 );
  test.true( got.root === root );
  var exp =
  {
    vals : new Set([{ f0 : 0 }]),
    ups :
    {
      a :
      {
        vals : new Set([{ f1 : 1 }]),
        ups :
        {
          b :
          {
            vals : new Set([{ f2 : 2 }]),
            ups : {},
          }
        },
      }
    }
  };
  test.identical( got.root, exp );
  test.identical( got.root.vals, new Set([ val0 ]) );
  test.identical( got.root.ups.a.vals, new Set([ val1 ]) );
  test.identical( got.root.ups.a.ups.b.vals, new Set([ val2 ]) );

  /* */

  test.case = 'branching 1 + 22';
  var root = null;
  var got = _.trie.addSingle( root, [ 'a' ], 'vala' );
  root = got.root;
  var got = _.trie.addSingle( root, [ 'a', 'c' ], 'valc1' );
  test.true( got.root === root );
  var got = _.trie.addSingle( root, [ 'a', 'b' ], 'valb' );
  test.true( got.root === root );
  var got = _.trie.addSingle( root, [ 'a', 'c' ], 'valc2' );
  test.true( got.root === root );
  var got = _.trie.addSingle( root, [], 'val0' );
  test.true( got.root === root );
  var exp =
  {
    vals : new Set([ 'val0' ]),
    ups :
    {
      a :
      {
        vals : new Set([ 'vala' ]),
        ups :
        {
          b :
          {
            vals : new Set([ 'valb' ]),
            ups : {},
          },
          c :
          {
            vals : new Set([ 'valc1', 'valc2' ]),
            ups : {},
          },
        },
      }
    }
  };
  test.identical( got.root, exp );
  test.identical( got.root.vals, new Set([ 'val0' ]) );
  test.identical( got.root.ups.a.vals, new Set([ 'vala' ]) );
  test.identical( got.root.ups.a.ups.b.vals, new Set([ 'valb' ]) );
  test.identical( got.root.ups.a.ups.c.vals, new Set([ 'valc1', 'valc2' ]) );

  /* */

  test.case = '.a.b.x';
  var root = _.trie.make();
  _.trie.addSingle( root, [], 'val0' );
  _.trie.addSingle( root, [ 'a' ], 'vala' );
  _.trie.addSingle( root, [ 'a', 'b', 'c' ], 'valc' );
  _.trie.makeWithPath( root, [ 'a', 'b', 'c', 'd' ] );

  var exp =
  {
    'vals' : new Set([ `val0` ]),
    'ups' :
    {
      'a' :
      {
        'vals' : new Set([ `vala` ]),
        'ups' :
        {
          'b' :
          {
            'vals' : new Set([]),
            'ups' :
            {
              'c' :
              {
                'vals' : new Set([ `valc` ]),
                'ups' :
                {
                  'd' :
                  {
                    'vals' : new Set([]),
                    'ups' : {}
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  test.identical( root, exp );

  /* */

}

//

function deleteWithPathAllVals( test )
{

  /* */

  test.case = 'empty, delete .';
  var root = _.trie.make();
  var got = _.trie.deleteWithPath({ root, path : [], shrinking : 0 });
  var exp = { vals : new Set(), ups : {} }
  test.identical( root, exp );

  /* */

  test.case = 'empty, delete .x';
  var root = _.trie.make();
  var got = _.trie.deleteWithPath({ root, path : [ 'x' ], shrinking : 0 });
  var exp = { vals : new Set(), ups : {} }
  test.identical( root, exp );

  /* */

  test.case = 'empty with child. delete .';
  var root = _.trie.make();
  _.trie.makeWithPath( root, [ 'd' ] );
  var got = _.trie.deleteWithPath({ root, path : [], shrinking : 0 });
  var exp = { vals : new Set(), ups : { d : { vals : new Set(), ups : {} } } };
  test.identical( root, exp );

  /* */

  test.case = 'empty with child. delete .d';
  var root = _.trie.make();
  _.trie.makeWithPath( root, [ 'd' ] );
  var got = _.trie.deleteWithPath({ root, path : [ 'd' ], shrinking : 0 });
  var exp = { vals : new Set(), ups : { d : { vals : new Set(), ups : {} } } };
  test.identical( root, exp );

  /* */

  test.case = 'empty with child. delete .d.x';
  var root = _.trie.make();
  _.trie.makeWithPath( root, [ 'd' ] );
  var got = _.trie.deleteWithPath({ root, path : [ 'd', 'x' ], shrinking : 0 });
  var exp = { vals : new Set(), ups : { d : { vals : new Set(), ups : {} } } };
  test.identical( root, exp );

  /* */

  test.case = 'empty with child. delete .x';
  var root = _.trie.make();
  _.trie.makeWithPath( root, [ 'd' ] );
  var got = _.trie.deleteWithPath({ root, path : [ 'x' ], shrinking : 0 });
  var exp = { vals : new Set(), ups : { d : { vals : new Set(), ups : {} } } };
  test.identical( root, exp );

  /* */

  test.case = '.a.b.x';
  var root = _.trie.make();
  _.trie.addSingle( root, [ 'a' ], 'vala' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc1' );
  _.trie.addSingle( root, [ 'a', 'b' ], 'valb' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc2' );
  _.trie.addSingle( root, [], 'val0' );
  _.trie.makeWithPath( root, [ 'd' ] );

  var got = _.trie.deleteWithPath({ root, path : [ 'a', 'b', 'x' ], shrinking : 0 });

  var exp =
  {
    vals : new Set([ 'val0' ]),
    ups :
    {
      a :
      {
        vals : new Set([ 'vala' ]),
        ups :
        {
          b :
          {
            vals : new Set([ 'valb' ]),
            ups : {},
          },
          c :
          {
            vals : new Set([ 'valc1', 'valc2' ]),
            ups : {},
          },
        },
      },
      d :
      {
        vals : new Set(),
        ups : {},
      }
    }
  };
  test.identical( root, exp );

  /* */

  test.case = '.a.b';
  var root = _.trie.make();
  _.trie.addSingle( root, [ 'a' ], 'vala' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc1' );
  _.trie.addSingle( root, [ 'a', 'b' ], 'valb' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc2' );
  _.trie.addSingle( root, [], 'val0' );
  _.trie.makeWithPath( root, [ 'd' ] );

  var got = _.trie.deleteWithPath({ root, path : [ 'a', 'b' ], shrinking : 0 });

  var exp =
  {
    vals : new Set([ 'val0' ]),
    ups :
    {
      a :
      {
        vals : new Set([ 'vala' ]),
        ups :
        {
          b :
          {
            vals : new Set(),
            ups : {},
          },
          c :
          {
            vals : new Set([ 'valc1', 'valc2' ]),
            ups : {},
          },
        },
      },
      d :
      {
        vals : new Set(),
        ups : {},
      }
    }
  };
  test.identical( root, exp );

  /* */

  test.case = '.a.c';
  var root = _.trie.make();
  _.trie.addSingle( root, [ 'a' ], 'vala' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc1' );
  _.trie.addSingle( root, [ 'a', 'b' ], 'valb' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc2' );
  _.trie.addSingle( root, [], 'val0' );
  _.trie.makeWithPath( root, [ 'd' ] );

  var got = _.trie.deleteWithPath({ root, path : [ 'a', 'c' ], shrinking : 0 });

  var exp =
  {
    vals : new Set([ 'val0' ]),
    ups :
    {
      a :
      {
        vals : new Set([ 'vala' ]),
        ups :
        {
          b :
          {
            vals : new Set([ 'valb' ]),
            ups : {},
          },
          c :
          {
            vals : new Set(),
            ups : {},
          },
        },
      },
      d :
      {
        vals : new Set(),
        ups : {},
      }
    }
  };
  test.identical( root, exp );

  /* */

  test.case = '.a';
  var root = _.trie.make();
  _.trie.addSingle( root, [ 'a' ], 'vala' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc1' );
  _.trie.addSingle( root, [ 'a', 'b' ], 'valb' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc2' );
  _.trie.addSingle( root, [], 'val0' );
  _.trie.makeWithPath( root, [ 'd' ] );

  var got = _.trie.deleteWithPath({ root, path : [ 'a' ], shrinking : 0 });

  var exp =
  {
    vals : new Set([ 'val0' ]),
    ups :
    {
      a :
      {
        vals : new Set(),
        ups :
        {
          b :
          {
            vals : new Set([ 'valb' ]),
            ups : {},
          },
          c :
          {
            vals : new Set([ 'valc1', 'valc2' ]),
            ups : {},
          },
        },
      },
      d :
      {
        vals : new Set(),
        ups : {},
      }
    }
  };
  test.identical( root, exp );

  /* */

  if( !Config.debug )
  return;

  test.case = 'throwing';
  test.shouldThrowErrorSync( () => _.trie.deleteWithPath( _.trie.make() ) );
  test.shouldThrowErrorSync( () => _.trie.deleteWithPath( _.trie.make(), [], [], [] ) );
  test.shouldThrowErrorSync( () => _.trie.deleteWithPath( _.trie.make(), 1 ) );
  test.shouldThrowErrorSync( () => _.trie.deleteWithPath() );

  /* */

}

//

function deleteWithPathOnlyVals( test )
{

  /* */

  test.case = 'empty, delete .';
  var root = _.trie.make();
  var got = _.trie.deleteWithPath({ root, path : [], vals : [], shrinking : 0 });
  var exp = { vals : new Set(), ups : {} }
  test.identical( root, exp );

  /* */

  test.case = 'empty, delete .x';
  var root = _.trie.make();
  var got = _.trie.deleteWithPath({ root, path : [ 'x' ], vals : [], shrinking : 0 });
  var exp = { vals : new Set(), ups : {} }
  test.identical( root, exp );

  /* */

  test.case = 'empty with child. delete .';
  var root = _.trie.make();
  _.trie.makeWithPath( root, [ 'd' ] );
  var got = _.trie.deleteWithPath({ root, path : [], vals : [], shrinking : 0 } );
  var exp = { vals : new Set(), ups : { d : { vals : new Set(), ups : {} } } };
  test.identical( root, exp );

  /* */

  test.case = 'empty with child. delete .d';
  var root = _.trie.make();
  _.trie.makeWithPath( root, [ 'd' ] );
  var got = _.trie.deleteWithPath({ root, path : [ 'd' ], vals : [], shrinking : 0 });
  var exp = { vals : new Set(), ups : { d : { vals : new Set(), ups : {} } } };
  test.identical( root, exp );

  /* */

  test.case = 'empty with child. delete .d.x';
  var root = _.trie.make();
  _.trie.makeWithPath( root, [ 'd' ] );
  var got = _.trie.deleteWithPath({ root, path : [ 'd', 'x' ], vals : [], shrinking : 0 } );
  var exp = { vals : new Set(), ups : { d : { vals : new Set(), ups : {} } } };
  test.identical( root, exp );

  /* */

  test.case = 'empty with child. delete .x';
  var root = _.trie.make();
  _.trie.makeWithPath( root, [ 'd' ] );
  var got = _.trie.deleteWithPath({ root, path : [ 'x' ], vals : [] });
  var exp = { vals : new Set(), ups : { d : { vals : new Set(), ups : {} } } };
  test.identical( root, exp );

  /* */

  test.case = '.a.b.x';
  var root = _.trie.make();
  _.trie.addSingle( root, [ 'a' ], 'vala' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc1' );
  _.trie.addSingle( root, [ 'a', 'b' ], 'valb' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc2' );
  _.trie.addSingle( root, [], 'val0' );
  _.trie.makeWithPath( root, [ 'd' ] );

  var got = _.trie.deleteWithPath({ root, path : [ 'a', 'b', 'x' ], vals : [] });

  var exp =
  {
    vals : new Set([ 'val0' ]),
    ups :
    {
      a :
      {
        vals : new Set([ 'vala' ]),
        ups :
        {
          b :
          {
            vals : new Set([ 'valb' ]),
            ups : {},
          },
          c :
          {
            vals : new Set([ 'valc1', 'valc2' ]),
            ups : {},
          },
        },
      },
      d :
      {
        vals : new Set(),
        ups : {},
      }
    }
  };
  test.identical( root, exp );

  /* */

  test.case = '.a.b';
  var root = _.trie.make();
  _.trie.addSingle( root, [ 'a' ], 'vala' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc1' );
  _.trie.addSingle( root, [ 'a', 'b' ], 'valb' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc2' );
  _.trie.addSingle( root, [], 'val0' );
  _.trie.makeWithPath( root, [ 'd' ] );

  var got = _.trie.deleteWithPath({ root, path : [ 'a', 'b' ], vals : [ 'valb' ], shrinking : 0 });

  var exp =
  {
    vals : new Set([ 'val0' ]),
    ups :
    {
      a :
      {
        vals : new Set([ 'vala' ]),
        ups :
        {
          b :
          {
            vals : new Set(),
            ups : {},
          },
          c :
          {
            vals : new Set([ 'valc1', 'valc2' ]),
            ups : {},
          },
        },
      },
      d :
      {
        vals : new Set(),
        ups : {},
      }
    }
  };
  test.identical( root, exp );

  /* */

  test.case = '.a.c';
  var root = _.trie.make();
  _.trie.addSingle( root, [ 'a' ], 'vala' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc1' );
  _.trie.addSingle( root, [ 'a', 'b' ], 'valb' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc2' );
  _.trie.addSingle( root, [], 'val0' );
  _.trie.makeWithPath( root, [ 'd' ] );

  var got = _.trie.deleteWithPath({ root, path : [ 'a', 'c' ], vals : [ 'valc1', 'valc2', 'valc3' ], shrinking : 0 });

  var exp =
  {
    vals : new Set([ 'val0' ]),
    ups :
    {
      a :
      {
        vals : new Set([ 'vala' ]),
        ups :
        {
          b :
          {
            vals : new Set([ 'valb' ]),
            ups : {},
          },
          c :
          {
            vals : new Set(),
            ups : {},
          },
        },
      },
      d :
      {
        vals : new Set(),
        ups : {},
      }
    }
  };
  test.identical( root, exp );

  /* */

  test.case = '.a.c';
  var root = _.trie.make();
  _.trie.addSingle( root, [ 'a' ], 'vala' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc1' );
  _.trie.addSingle( root, [ 'a', 'b' ], 'valb' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc2' );
  _.trie.addSingle( root, [], 'val0' );
  _.trie.makeWithPath( root, [ 'd' ] );

  var got = _.trie.deleteWithPath({ root, path : [ 'a', 'c' ], vals : [ 'valc1' ], shrinking : 0 });

  var exp =
  {
    vals : new Set([ 'val0' ]),
    ups :
    {
      a :
      {
        vals : new Set([ 'vala' ]),
        ups :
        {
          b :
          {
            vals : new Set([ 'valb' ]),
            ups : {},
          },
          c :
          {
            vals : new Set([ 'valc2' ]),
            ups : {},
          },
        },
      },
      d :
      {
        vals : new Set(),
        ups : {},
      }
    }
  };
  test.identical( root, exp );

  /* */

  test.case = '.a.c';
  var root = _.trie.make();
  _.trie.addSingle( root, [ 'a' ], 'vala' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc1' );
  _.trie.addSingle( root, [ 'a', 'b' ], 'valb' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc2' );
  _.trie.addSingle( root, [], 'val0' );
  _.trie.makeWithPath( root, [ 'd' ] );

  var got = _.trie.deleteWithPath({ root, path : [ 'a', 'c' ], vals : [ 'valc2' ], shrinking : 0 });

  var exp =
  {
    vals : new Set([ 'val0' ]),
    ups :
    {
      a :
      {
        vals : new Set([ 'vala' ]),
        ups :
        {
          b :
          {
            vals : new Set([ 'valb' ]),
            ups : {},
          },
          c :
          {
            vals : new Set([ 'valc1' ]),
            ups : {},
          },
        },
      },
      d :
      {
        vals : new Set(),
        ups : {},
      }
    }
  };
  test.identical( root, exp );

  /* */

  test.case = '.a';
  var root = _.trie.make();
  _.trie.addSingle( root, [ 'a' ], 'vala' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc1' );
  _.trie.addSingle( root, [ 'a', 'b' ], 'valb' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc2' );
  _.trie.addSingle( root, [], 'val0' );
  _.trie.makeWithPath( root, [ 'd' ] );

  var got = _.trie.deleteWithPath({ root, path : [ 'a' ], vals : [ 'vala' ], shrinking : 0 });

  var exp =
  {
    vals : new Set([ 'val0' ]),
    ups :
    {
      a :
      {
        vals : new Set(),
        ups :
        {
          b :
          {
            vals : new Set([ 'valb' ]),
            ups : {},
          },
          c :
          {
            vals : new Set([ 'valc1', 'valc2' ]),
            ups : {},
          },
        },
      },
      d :
      {
        vals : new Set(),
        ups : {},
      }
    }
  };
  test.identical( root, exp );

  /* */

  if( !Config.debug )
  return;

  test.case = 'throwing';
  test.shouldThrowErrorSync( () => _.trie.deleteWithPath( _.trie.make(), [], 'x', 'x' ) );
  test.shouldThrowErrorSync( () => _.trie.deleteWithPath( _.trie.make(), [], 'x' ) );
  test.shouldThrowErrorSync( () => _.trie.deleteWithPath( _.trie.make(), [], 3 ) );
  test.shouldThrowErrorSync( () => _.trie.deleteWithPath( _.trie.make(), [], undefined ) );

  /* */

}

//

function deleteWithPathShrkinking( test )
{

  act({ val : null });
  act({ val : true });

  function act( env )
  {

    /* */

    test.case = `was val and up, ${__.entity.exportStringSolo( env )}`;
    var root = _.trie.make();
    _.trie.addSingle( root, [], 'val0' );
    _.trie.addSingle( root, [ 'a' ], 'vala' );
    _.trie.addSingle( root, [ 'a', 'b', 'c' ], 'valc' );
    _.trie.makeWithPath( root, [ 'a', 'b', 'c', 'd' ] );

    var got = _.trie.deleteWithPath
    ({
      root,
      path : [ 'a', 'b', 'c' ],
      shrinking : 1,
      vals : ( env.vals ? [ 'valc' ] : null ),
    });
    var exp =
    {
      'vals' : new Set([ `val0` ]),
      'ups' :
      {
        'a' :
        {
          'vals' : new Set([ `vala` ]),
          'ups' :
          {
            'b' :
            {
              'vals' : new Set(),
              'ups' :
              {
                'c' :
                {
                  'vals' : new Set(),
                  'ups' :
                  {
                    'd' :
                    {
                      'vals' : new Set(),
                      'ups' : {}
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    test.identical( root, exp );

    /* */

    test.case = `no val, but up, ${__.entity.exportStringSolo( env )}`;
    var root = _.trie.make();
    _.trie.addSingle( root, [], 'val0' );
    _.trie.addSingle( root, [ 'a' ], 'vala' );
    _.trie.makeWithPath( root, [ 'a', 'b', 'c', 'd' ] );

    var got = _.trie.deleteWithPath
    ({
      root,
      path : [ 'a', 'b', 'c' ],
      shrinking : 1,
      vals : ( env.vals ? [ 'valc' ] : null ),
    });
    var exp =
    {
      'vals' : new Set([ `val0` ]),
      'ups' :
      {
        'a' :
        {
          'vals' : new Set([ `vala` ]),
          'ups' :
          {
            'b' :
            {
              'vals' : new Set(),
              'ups' :
              {
                'c' :
                {
                  'vals' : new Set(),
                  'ups' :
                  {
                    'd' :
                    {
                      'vals' : new Set(),
                      'ups' : {}
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    test.identical( root, exp );

    /* */

    test.case = `no up and no val, ${__.entity.exportStringSolo( env )}`;
    var root = _.trie.make();
    _.trie.addSingle( root, [], 'val0' );
    _.trie.addSingle( root, [ 'a' ], 'vala' );
    _.trie.makeWithPath( root, [ 'a', 'b', 'c', 'd' ] );

    var got = _.trie.deleteWithPath
    ({
      root,
      path : [ 'a', 'b', 'c', 'd' ],
      shrinking : 1,
      vals : ( env.vals ? [ 'vald' ] : null ),
    });
    var exp =
    {
      'vals' : new Set([ `val0` ]),
      'ups' :
      {
        'a' :
        {
          'vals' : new Set([ `vala` ]),
          'ups' :
          {
          }
        }
      }
    }
    test.identical( root, exp );

    /* */

    test.case = `no up, was val, ${__.entity.exportStringSolo( env )}`;
    var root = _.trie.make();
    _.trie.addSingle( root, [], 'val0' );
    _.trie.addSingle( root, [ 'a' ], 'vala' );
    _.trie.addSingle( root, [ 'a', 'b', 'c', 'd' ], 'vald' );

    var got = _.trie.deleteWithPath
    ({
      root,
      path : [ 'a', 'b', 'c', 'd' ],
      shrinking : 1,
      vals : ( env.vals ? [ 'vald' ] : null ),
    });
    var exp =
    {
      'vals' : new Set([ `val0` ]),
      'ups' :
      {
        'a' :
        {
          'vals' : new Set([ `vala` ]),
          'ups' :
          {
          }
        }
      }
    }
    test.identical( root, exp );

    /* */

  }

}

//

function shrinkBasic( test )
{

  /* */

  test.case = `single`;
  var root = _.trie.make();
  _.trie.addSingle( root, [], 'val0' );
  _.trie.addSingle( root, [ 'a' ], 'vala' );
  _.trie.addSingle( root, [ 'a', 'b', 'c' ], 'valc' );
  _.trie.makeWithPath( root, [ 'a', 'b', 'c', 'd' ] );

  var got = _.trie.shrink( root );
  var exp =
  {
    'vals' : new Set([ `val0` ]),
    'ups' :
    {
      'a' :
      {
        'vals' : new Set([ `vala` ]),
        'ups' :
        {
          'b' :
          {
            'vals' : new Set(),
            'ups' :
            {
              'c' :
              {
                'vals' : new Set([ 'valc' ]),
                'ups' : {},
              }
            }
          }
        }
      }
    }
  }
  test.identical( root, exp );
  test.identical( got.counter, 1 );

  /* */

  test.case = `several`;
  var root = _.trie.make();
  _.trie.addSingle( root, [], 'val0' );
  _.trie.addSingle( root, [ 'a' ], 'vala' );
  _.trie.addSingle( root, [ 'a', 'b', 'c' ], 'valc' );
  _.trie.makeWithPath( root, [ 'a', 'b', 'c', 'd', 'e' ] );
  _.trie.makeWithPath( root, [ 'k', 'l', 'm' ] );

  var got = _.trie.shrink( root );
  var exp =
  {
    'vals' : new Set([ `val0` ]),
    'ups' :
    {
      'a' :
      {
        'vals' : new Set([ `vala` ]),
        'ups' :
        {
          'b' :
          {
            'vals' : new Set(),
            'ups' :
            {
              'c' :
              {
                'vals' : new Set([ 'valc' ]),
                'ups' : {},
              }
            }
          }
        }
      }
    }
  }
  test.identical( root, exp );
  test.identical( got.counter, 5 );

  /* */

}

// --
// read
// --

function withPathBasic( test )
{

  /* */

  test.case = 'basic';
  var val0 = { f0 : 0 };
  var val1 = { f1 : 1 };
  var val2 = { f2 : 2 };
  var root = _.trie.make();
  _.trie.addSingle( root, [], val0 );
  _.trie.addSingle( root, [ 'a' ], val1 )
  _.trie.addSingle( root, [ 'a', 'b' ], val2 );

  test.description = '.';
  var got = _.trie.withPath( root, [] );
  test.true( got.child === root );

  test.description = '.a';
  var got = _.trie.withPath( root, [ 'a' ] );
  test.true( got.child === root.ups.a );

  test.description = '.a.b';
  var got = _.trie.withPath( root, [ 'a', 'b' ] );
  test.true( got.child === root.ups.a.ups.b );

  test.description = '.a.b.c';
  var got = _.trie.withPath( root, [ 'a', 'b', 'c' ] );
  test.true( got.child === undefined );

  test.description = '.x';
  var got = _.trie.withPath( root, [ 'x' ] );
  test.true( got.child === undefined );

  var exp =
  {
    vals : new Set([{ f0 : 0 }]),
    ups :
    {
      a :
      {
        vals : new Set([{ f1 : 1 }]),
        ups :
        {
          b :
          {
            vals : new Set([{ f2 : 2 }]),
            ups : {},
          }
        },
      }
    }
  };
  test.identical( root, exp );

  /* */

}

//

function valEachBasic( test )
{

  /* */

  test.case = 'empty';
  var root = _.trie.make();

  var got = _.trie.valEach( root );
  test.identical( got.vals, new Set() );

  /* */

  test.case = 'empty with child';
  var root = _.trie.make();
  _.trie.makeWithPath( root, [ 'd' ] );

  var got = _.trie.valEach( root );
  test.identical( got.vals, new Set() );

  var got = _.trie.valEach( root.ups.d );
  test.identical( got.vals, new Set() );

  /* */

  test.case = 'basic';
  var root = _.trie.make();
  _.trie.addSingle( root, [ 'a' ], 'vala' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc1' );
  _.trie.addSingle( root, [ 'a', 'b' ], 'valb' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc2' );
  _.trie.addSingle( root, [], 'val0' );
  _.trie.makeWithPath( root, [ 'd' ] );

  var got = _.trie.valEach( root );
  test.identical( got.vals, new Set([ 'val0', 'vala', 'valb', 'valc1', 'valc2' ]) );

  var got = _.trie.valEach( root.ups.a );
  test.identical( got.vals, new Set([ 'vala', 'valb', 'valc1', 'valc2' ]) );

  var got = _.trie.valEach( root.ups.a.ups.c );
  test.identical( got.vals, new Set([ 'valc1', 'valc2' ]) );

  var got = _.trie.valEach( root.ups.d );
  test.identical( got.vals, new Set([]) );

  var exp =
  {
    vals : new Set([ 'val0' ]),
    ups :
    {
      a :
      {
        vals : new Set([ 'vala' ]),
        ups :
        {
          b :
          {
            vals : new Set([ 'valb' ]),
            ups : {},
          },
          c :
          {
            vals : new Set([ 'valc1', 'valc2' ]),
            ups : {},
          },
        },
      },
      d :
      {
        vals : new Set(),
        ups : {},
      }
    }
  };
  test.identical( root, exp );

  /* */

  if( !Config.debug )
  return;

  test.case = 'throwing';
  var root = _.trie.make();
  test.shouldThrowErrorSync( () => _.trie.valEach( root, [] ) );
  test.shouldThrowErrorSync( () => _.trie.valEach( root, [], [] ) );
  test.shouldThrowErrorSync( () => _.trie.valEach( root, 1 ) );
  test.shouldThrowErrorSync( () => _.trie.valEach() );

}

//

function valEachAboveBasic( test )
{

  /* */

  test.case = 'empty';
  var root = _.trie.make();

  var got = _.trie.valEachAbove( root, [] );
  test.identical( got.vals, [] );

  var got = _.trie.valEachAbove( root, [ 'x' ] );
  test.identical( got.vals, [] );

  /* */

  test.case = 'empty with child';
  var root = _.trie.make();
  _.trie.makeWithPath( root, [ 'd' ] );

  var got = _.trie.valEachAbove( root, [] );
  test.identical( got.vals, [] );

  var got = _.trie.valEachAbove( root, [ 'd' ] );
  test.identical( got.vals, [] );

  var got = _.trie.valEachAbove( root, [ 'd', 'x' ] );
  test.identical( got.vals, [] );

  var got = _.trie.valEachAbove( root, [ 'x' ] );
  test.identical( got.vals, [] );

  /* */

  test.case = 'basic';
  var root = _.trie.make();
  _.trie.addSingle( root, [ 'a' ], 'vala' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc1' );
  _.trie.addSingle( root, [ 'a', 'b' ], 'valb' );
  _.trie.addSingle( root, [ 'a', 'c' ], 'valc2' );
  _.trie.addSingle( root, [], 'val0' );
  _.trie.makeWithPath( root, [ 'd' ] );

  var got = _.trie.valEachAbove( root, [] );
  test.identical( got.vals, [ 'val0', 'vala', 'valb', 'valc1', 'valc2' ] );

  var got = _.trie.valEachAbove( root, [ 'a' ] );
  test.identical( got.vals, [ 'vala', 'valb', 'valc1', 'valc2' ] );

  var got = _.trie.valEachAbove( root, [ 'a', 'c' ] );
  test.identical( got.vals, [ 'valc1', 'valc2' ] );

  var got = _.trie.valEachAbove( root, [ 'd' ] );
  test.identical( got.vals, [] );

  var exp =
  {
    vals : new Set([ 'val0' ]),
    ups :
    {
      a :
      {
        vals : new Set([ 'vala' ]),
        ups :
        {
          b :
          {
            vals : new Set([ 'valb' ]),
            ups : {},
          },
          c :
          {
            vals : new Set([ 'valc1', 'valc2' ]),
            ups : {},
          },
        },
      },
      d :
      {
        vals : new Set(),
        ups : {},
      }
    }
  };
  test.identical( root, exp );

  /* */

  if( !Config.debug )
  return;

  test.case = 'throwing';
  var root = _.trie.make();
  test.shouldThrowErrorSync( () => _.trie.valEachAbove( root ) );
  test.shouldThrowErrorSync( () => _.trie.valEachAbove( root, [], [] ) );
  test.shouldThrowErrorSync( () => _.trie.valEachAbove( root, 1 ) );
  test.shouldThrowErrorSync( () => _.trie.valEachAbove() );

  /* */

}

// --
// declare
// --

const Proto =
{

  name : 'Tools.abse.Trie',
  silencing : 1,

  context :
  {
  },

  tests :
  {

    // write

    makeWithPathBasic,
    addSingleBasic,
    addMultipleBasic,
    addDeepBasic,
    deleteWithPathAllVals,
    deleteWithPathOnlyVals,
    deleteWithPathShrkinking,
    shrinkBasic,

    // reads

    withPathBasic,
    valEachBasic,
    valEachAboveBasic,

  }

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
