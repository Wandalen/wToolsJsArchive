
if( typeof module !== 'undefined' )
require( 'wchangetransactor' );
let _ = wTools;

/**/

var src =
{
  a : { a1 : 'src.a1' },
  b : [ 'src.b0' ],
  c : { c1 : 'src.c1' },
}

var dst =
{
  a : { a1 : 'dst.a1' },
  b : [ 'dst.b0' ],
  c : { c1 : 'dst.c1' },
}

var changes =
{
  a : true,
  b : true,
}

var got = _.changesApply( changes, dst, src );

console.log( got );
