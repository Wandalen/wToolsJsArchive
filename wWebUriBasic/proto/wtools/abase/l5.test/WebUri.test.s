( function _WebUri_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../node_modules/Tools' );

  _.include( 'wTesting' );
  require( '../l5/WebUri.s' );

}

const _global = _global_;
const _ = _global_.wTools;

// --
//
// --

function join( test )
{

  test.case = 'join protocols : file, undefined, http - global, undefined';
  var got = _.weburi.join( 'file://www.site.com:13', 'a', 'http:///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  test.case = 'join protocols : file - global, undefined, http - global, undefined';
  var got = _.weburi.join( 'file:///d', 'a', 'http:///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  /* */

  test.case = 'join protocols : http, undefined, http - global, undefined';
  var got = _.weburi.join( 'http://www.site.com:13', 'a', 'http:///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  test.case = 'join protocols : http - global, undefined, http - global, undefined';
  var got = _.weburi.join( 'http:///www.site.com:13', 'a', 'http:///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  test.case = 'join protocols : http, undefined, http, undefined';
  var got = _.weburi.join( 'http://server1', 'a', 'http://server2', 'b' );
  var expected = 'http://server2/a/b';
  test.identical( got, expected );

  test.case = 'join protocols : http - global, undefined, http, undefined';
  var got = _.weburi.join( 'http:///server1', 'a', 'http://server2', 'b' );
  var expected = 'http://server2/a/b';
  test.identical( got, expected );

  test.case = 'join protocols : http, undefined, http - global, undefined';
  var got = _.weburi.join( 'http://server1', 'a', 'http:///server2', 'b' );
  var expected = 'http:///server2/a/b';
  test.identical( got, expected );

  /* */

  test.case = 'join protocol with protocol-less';

  var got = _.weburi.join( 'http://www.site.com:13', 'a', ':///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.join( 'http:///www.site.com:13', 'a', '://dir', 'b' );
  var expected = 'http://dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.join( 'http:///www.site.com:13', 'a', ':///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.join( 'http://www.site.com:13', 'a', '://dir', 'b' );
  var expected = 'http://dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.join( 'http://dir:13', 'a', '://dir', 'b' );
  var expected = 'http://dir:13/a/b';
  test.identical( got, expected );

  var got = _.weburi.join( 'http://www.site.com:13', 'a', '://:14', 'b' );
  var expected = 'http://www.site.com:14/a/b';
  test.identical( got, expected );

  /**/

  var got = _.weburi.join( 'a', '://dir1/x', 'b', 'http://dir2/y', 'c' );
  var expected = 'http://dir2/a/x/b/y/c';
  test.identical( got, expected );

  var got = _.weburi.join( 'a', ':///dir1/x', 'b', 'http://dir2/y', 'c' );
  var expected = 'http://dir2/a/x/b/y/c';
  test.identical( got, expected );

  var got = _.weburi.join( 'a', '://dir1/x', 'b', 'http:///dir2/y', 'c' );
  var expected = 'http:///dir2/a/x/b/y/c';
  test.identical( got, expected );

  var got = _.weburi.join( 'a', ':///dir1/x', 'b', 'http:///dir2/y', 'c' );
  var expected = 'http:///dir2/a/x/b/y/c';
  test.identical( got, expected );

  /* */

  test.case = 'server join absolute path 1';
  var got = _.weburi.join( 'http://www.site.com:13', '/x', '/y', '/z' );
  test.identical( got, 'http://www.site.com:13//z' );

  test.case = 'server join absolute path 2';
  var got = _.weburi.join( 'http://www.site.com:13/', 'x', '/y', '/z' );
  test.identical( got, 'http://www.site.com:13//z' );

  test.case = 'server join absolute path 2';
  var got = _.weburi.join( 'http://www.site.com:13/', 'x', 'y', '/z' );
  test.identical( got, 'http://www.site.com:13//z' );

  test.case = 'server join absolute path';
  var got = _.weburi.join( 'http://www.site.com:13/', 'x', '/y', 'z' );
  test.identical( got, 'http://www.site.com:13//y/z' );

  test.case = 'server join relative path';
  var got = _.weburi.join( 'http://www.site.com:13/', 'x', 'y', 'z' );
  test.identical( got, 'http://www.site.com:13/x/y/z' );

  test.case = 'server with path join absolute path 2';
  var got = _.weburi.join( 'http://www.site.com:13/ab', '/y', '/z' );
  test.identical( got, 'http://www.site.com:13//z' );

  test.case = 'server with path join absolute path 2';
  var got = _.weburi.join( 'http://www.site.com:13/ab', '/y', 'z' );
  test.identical( got, 'http://www.site.com:13//y/z' );

  test.case = 'server with path join absolute path 2';
  var got = _.weburi.join( 'http://www.site.com:13/ab', 'y', 'z' );
  test.identical( got, 'http://www.site.com:13/ab/y/z' );

  test.case = 'add relative to uri with no resourcePath';
  var got = _.weburi.join( 'https://some.domain.com/', 'something/to/add' );
  test.identical( got, 'https://some.domain.com/something/to/add' );

  test.case = 'add relative to uri with resourcePath';
  var got = _.weburi.join( 'https://some.domain.com/was', 'something/to/add' );
  test.identical( got, 'https://some.domain.com/was/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( 'https://some.domain.com/was', '/something/to/add' );
  test.identical( got, 'https://some.domain.com//something/to/add' );

  /* */

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( '//some.domain.com/was', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( '://some.domain.com/was', '/something/to/add' );
  test.identical( got, '://some.domain.com//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( '//some.domain.com/was', 'x', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( '://some.domain.com/was', 'x', '/something/to/add' );
  test.identical( got, '://some.domain.com//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( '//some.domain.com/was', '/something/to/add', 'x' );
  test.identical( got, '/something/to/add/x' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( '://some.domain.com/was', '/something/to/add', 'x' );
  test.identical( got, '://some.domain.com//something/to/add/x' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( '//some.domain.com/was', '/something/to/add', '/x' );
  test.identical( got, '/x' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( '://some.domain.com/was', '/something/to/add', '/x' );
  test.identical( got, '://some.domain.com//x' );

  /* */

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( '/some/staging/index.html', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( '/some/staging/index.html', 'x', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( '/some/staging/index.html', 'x', '/something/to/add', 'y' );
  test.identical( got, '/something/to/add/y' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( '/some/staging/index.html', '/something/to/add', '/y' );
  test.identical( got, '/y' );

  /* */

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( '///some/staging/index.html', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( ':///some/staging/index.html', '/something/to/add' );
  test.identical( got, ':///some//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( '///some/staging/index.html', 'x', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( ':///some/staging/index.html', 'x', '/something/to/add' );
  test.identical( got, ':///some//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( '///some/staging/index.html', 'x', '/something/to/add', 'y' );
  test.identical( got, '/something/to/add/y' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( ':///some/staging/index.html', 'x', '/something/to/add', 'y' );
  test.identical( got, ':///some//something/to/add/y' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( '///some/staging/index.html', '/something/to/add', '/y' );
  test.identical( got, '/y' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( ':///some/staging/index.html', '/something/to/add', '/y' );
  test.identical( got, ':///some//y' );

  /* */

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( 'svn+https://user@subversion.com/svn/trunk', '/something/to/add' );
  test.identical( got, 'svn+https://user@subversion.com//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( 'svn+https://user@subversion.com/svn/trunk', 'x', '/something/to/add' );
  test.identical( got, 'svn+https://user@subversion.com//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( 'svn+https://user@subversion.com/svn/trunk', 'x', '/something/to/add', 'y' );
  test.identical( got, 'svn+https://user@subversion.com//something/to/add/y' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( 'svn+https://user@subversion.com/svn/trunk', '/something/to/add', '/y' );
  test.identical( got, 'svn+https://user@subversion.com//y' );

  /* */

  test.case = 'add absolute to uri with resourcePath';
  var uri = 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor';
  var parsed = _.weburi.parse( uri );
  var got = _.weburi.join( uri, '/something/to/add' );
  test.identical( got, parsed.origin + '//something/to/add' + '?query=here&and=here#anchor' );

  test.case = 'add absolute to uri with resourcePath';
  var uri = 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor';
  var got = _.weburi.join( uri, 'x', '/something/to/add' );
  test.identical( got, parsed.origin + '//something/to/add' + '?query=here&and=here#anchor' );

  test.case = 'add absolute to uri with resourcePath';
  var uri = 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor';
  var got = _.weburi.join( uri, 'x', '/something/to/add', 'y' );
  test.identical( got, parsed.origin + '//something/to/add/y' + '?query=here&and=here#anchor' );

  test.case = 'add absolute to uri with resourcePath';
  var uri = 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor';
  var got = _.weburi.join( uri, '/something/to/add', '/y' );
  test.identical( got, parsed.origin + '//y' + '?query=here&and=here#anchor' );

  /* */

  test.case = 'several queries and hashes'
  var uri1 = '://user:pass@sub.host.com:8080/p/a/t/h?query1=string1#hash1';
  var uri2 = '://user:pass@sub.host.com:8080/p/a/t/h?query2=string2#hash2';
  var got = _.weburi.join( uri1, uri2, '/x//y//z' );
  var expected = '://user:pass@sub.host.com:8080//x//y//z?query1=string1&query2=string2#hash2';
  test.identical( got, expected );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( '://some.domain.com/was', '/something/to/add' );
  test.identical( got, '://some.domain.com//something/to/add' );

  var uri = '://user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.join( uri, 'x' );
  var expected = '://user:pass@sub.host.com:8080/p/a/t/h/x?query=string#hash'
  test.identical( got, expected );

  var uri = '://user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.join( uri, 'x', '/y' );
  var expected = '://user:pass@sub.host.com:8080//y?query=string#hash'
  test.identical( got, expected );

  var uri = '://user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.join( uri, '/x//y//z' );
  var expected = '://user:pass@sub.host.com:8080//x//y//z?query=string#hash'
  test.identical( got, expected );

  var uri = '://user:pass@sub.host.com:8080/p//a//t//h?query=string#hash';
  var got = _.weburi.join( uri, 'x' );
  var expected = '://user:pass@sub.host.com:8080/p//a//t//h/x?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.join( uri, 'x' );
  var expected = ':///user:pass@sub.host.com:8080/p/a/t/h/x?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.join( uri, 'x', '/y' );
  var expected = ':///user:pass@sub.host.com:8080//y?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.join( uri, '/x//y//z' );
  var expected = ':///user:pass@sub.host.com:8080//x//y//z?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.join( uri, 'x' );
  var expected = ':///user:pass@sub.host.com:8080/p/a/t/h/x?query=string#hash'
  test.identical( got, expected );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join( 'file:///some/file', '/something/to/add' );
  test.identical( got, 'file:///some//something/to/add' );

  /* */

  test.case = 'add uris';

  var got = _.weburi.join( '//a', '//b', 'c' );
  test.identical( got, '//b/c' )

  var got = _.weburi.join( 'b://c', 'd://e', 'f' );
  test.identical( got, 'd://e/f' );

  var got = _.weburi.join( 'a://b', 'c://d/e', '//f/g' );
  test.identical( got, 'c://d///f/g' )

  /* */

  test.case = 'works like join';
  var paths = [ 'c:\\', 'foo\\', 'bar\\' ];
  var expected = '/c/foo/bar/';
  var got = _.weburi.join.apply( _.weburi, paths );
  test.identical( got, expected );

  test.case = 'join unix os paths';
  var paths = [ '/bar/', '/baz', 'foo/', '.' ];
  var expected = '/baz/foo';
  var got = _.weburi.join.apply( _.weburi, paths );
  test.identical( got, expected );

  /* */

  test.case = 'more complicated cases';

  /* xxx */

  var paths = [ '/aa', 'bb//', 'cc' ];
  var expected = '/aa/bb//cc';
  var got = _.weburi.join.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [ '/aa', 'bb//', 'cc', '.' ];
  var expected = '/aa/bb//cc';
  var got = _.weburi.join.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [ '/', 'a', '//b', '././c', '../d', '..e' ];
  var expected = '//b/d/..e';
  var got = _.weburi.join.apply( _.weburi, paths );
  test.identical( got, expected );

  /*
    _.weburi.join( 'https://some.domain.com/', 'something/to/add' ) -> 'https://some.domain.com/something/to/add'
    _.weburi.join( 'https://some.domain.com/was', 'something/to/add' ) -> 'https://some.domain.com/was/something/to/add'
    _.weburi.join( 'https://some.domain.com/was', '/something/to/add' ) -> 'https://some.domain.com/something/to/add'

    _.weburi.join( '//some.domain.com/was', '/something/to/add' ) -> '//some.domain.com/something/to/add'
    _.weburi.join( '://some.domain.com/was', '/something/to/add' ) -> '://some.domain.com/something/to/add'

    /some/staging/index.html
    //some/staging/index.html
    ///some/staging/index.html
    file:///some/staging/index.html
    http://some.come/staging/index.html
    svn+https://user@subversion.com/svn/trunk
    complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor

  */

}

//

function join_( test )
{

  test.case = 'join_ protocols : file, undefined, http - global, undefined';
  var got = _.weburi.join_( 'file://www.site.com:13', 'a', 'http:///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  test.case = 'join_ protocols : file - global, undefined, http - global, undefined';
  var got = _.weburi.join_( 'file:///d', 'a', 'http:///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  /* */

  test.case = 'join_ protocols : http, undefined, http - global, undefined';
  var got = _.weburi.join_( 'http://www.site.com:13', 'a', 'http:///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  test.case = 'join_ protocols : http - global, undefined, http - global, undefined';
  var got = _.weburi.join_( 'http:///www.site.com:13', 'a', 'http:///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  test.case = 'join_ protocols : http, undefined, http, undefined';
  var got = _.weburi.join_( 'http://server1', 'a', 'http://server2', 'b' );
  var expected = 'http://server2/a/b';
  test.identical( got, expected );

  test.case = 'join_ protocols : http - global, undefined, http, undefined';
  var got = _.weburi.join_( 'http:///server1', 'a', 'http://server2', 'b' );
  var expected = 'http://server2/a/b';
  test.identical( got, expected );

  test.case = 'join_ protocols : http, undefined, http - global, undefined';
  var got = _.weburi.join_( 'http://server1', 'a', 'http:///server2', 'b' );
  var expected = 'http:///server2/a/b';
  test.identical( got, expected );

  /* */

  test.case = 'join_ protocol with protocol-less';

  var got = _.weburi.join_( 'http://www.site.com:13', 'a', ':///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.join_( 'http:///www.site.com:13', 'a', '://dir', 'b' );
  var expected = 'http://dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.join_( 'http:///www.site.com:13', 'a', ':///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.join_( 'http://www.site.com:13', 'a', '://dir', 'b' );
  var expected = 'http://dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.join_( 'http://dir:13', 'a', '://dir', 'b' );
  var expected = 'http://dir:13/a/b';
  test.identical( got, expected );

  var got = _.weburi.join_( 'http://www.site.com:13', 'a', '://:14', 'b' );
  var expected = 'http://www.site.com:14/a/b';
  test.identical( got, expected );

  /**/

  var got = _.weburi.join_( 'a', '://dir1/x', 'b', 'http://dir2/y', 'c' );
  var expected = 'http://dir2/a/x/b/y/c';
  test.identical( got, expected );

  var got = _.weburi.join_( 'a', ':///dir1/x', 'b', 'http://dir2/y', 'c' );
  var expected = 'http://dir2/a/x/b/y/c';
  test.identical( got, expected );

  var got = _.weburi.join_( 'a', '://dir1/x', 'b', 'http:///dir2/y', 'c' );
  var expected = 'http:///dir2/a/x/b/y/c';
  test.identical( got, expected );

  var got = _.weburi.join_( 'a', ':///dir1/x', 'b', 'http:///dir2/y', 'c' );
  var expected = 'http:///dir2/a/x/b/y/c';
  test.identical( got, expected );

  /* */

  test.case = 'server join_ absolute path 1';
  var got = _.weburi.join_( 'http://www.site.com:13', '/x', '/y', '/z' );
  test.identical( got, 'http://www.site.com:13//z' );

  test.case = 'server join_ absolute path 2';
  var got = _.weburi.join_( 'http://www.site.com:13/', 'x', '/y', '/z' );
  test.identical( got, 'http://www.site.com:13//z' );

  test.case = 'server join_ absolute path 2';
  var got = _.weburi.join_( 'http://www.site.com:13/', 'x', 'y', '/z' );
  test.identical( got, 'http://www.site.com:13//z' );

  test.case = 'server join_ absolute path';
  var got = _.weburi.join_( 'http://www.site.com:13/', 'x', '/y', 'z' );
  test.identical( got, 'http://www.site.com:13//y/z' );

  test.case = 'server join_ relative path';
  var got = _.weburi.join_( 'http://www.site.com:13/', 'x', 'y', 'z' );
  test.identical( got, 'http://www.site.com:13/x/y/z' );

  test.case = 'server with path join_ absolute path 2';
  var got = _.weburi.join_( 'http://www.site.com:13/ab', '/y', '/z' );
  test.identical( got, 'http://www.site.com:13//z' );

  test.case = 'server with path join_ absolute path 2';
  var got = _.weburi.join_( 'http://www.site.com:13/ab', '/y', 'z' );
  test.identical( got, 'http://www.site.com:13//y/z' );

  test.case = 'server with path join_ absolute path 2';
  var got = _.weburi.join_( 'http://www.site.com:13/ab', 'y', 'z' );
  test.identical( got, 'http://www.site.com:13/ab/y/z' );

  test.case = 'add relative to uri with no resourcePath';
  var got = _.weburi.join_( 'https://some.domain.com/', 'something/to/add' );
  test.identical( got, 'https://some.domain.com/something/to/add' );

  test.case = 'add relative to uri with resourcePath';
  var got = _.weburi.join_( 'https://some.domain.com/was', 'something/to/add' );
  test.identical( got, 'https://some.domain.com/was/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( 'https://some.domain.com/was', '/something/to/add' );
  test.identical( got, 'https://some.domain.com//something/to/add' );

  /* */

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( '//some.domain.com/was', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( '://some.domain.com/was', '/something/to/add' );
  test.identical( got, '://some.domain.com//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( '//some.domain.com/was', 'x', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( '://some.domain.com/was', 'x', '/something/to/add' );
  test.identical( got, '://some.domain.com//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( '//some.domain.com/was', '/something/to/add', 'x' );
  test.identical( got, '/something/to/add/x' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( '://some.domain.com/was', '/something/to/add', 'x' );
  test.identical( got, '://some.domain.com//something/to/add/x' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( '//some.domain.com/was', '/something/to/add', '/x' );
  test.identical( got, '/x' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( '://some.domain.com/was', '/something/to/add', '/x' );
  test.identical( got, '://some.domain.com//x' );

  /* */

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( '/some/staging/index.html', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( '/some/staging/index.html', 'x', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( '/some/staging/index.html', 'x', '/something/to/add', 'y' );
  test.identical( got, '/something/to/add/y' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( '/some/staging/index.html', '/something/to/add', '/y' );
  test.identical( got, '/y' );

  /* */

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( '///some/staging/index.html', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( ':///some/staging/index.html', '/something/to/add' );
  test.identical( got, ':///some//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( '///some/staging/index.html', 'x', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( ':///some/staging/index.html', 'x', '/something/to/add' );
  test.identical( got, ':///some//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( '///some/staging/index.html', 'x', '/something/to/add', 'y' );
  test.identical( got, '/something/to/add/y' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( ':///some/staging/index.html', 'x', '/something/to/add', 'y' );
  test.identical( got, ':///some//something/to/add/y' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( '///some/staging/index.html', '/something/to/add', '/y' );
  test.identical( got, '/y' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( ':///some/staging/index.html', '/something/to/add', '/y' );
  test.identical( got, ':///some//y' );

  /* */

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( 'svn+https://user@subversion.com/svn/trunk', '/something/to/add' );
  test.identical( got, 'svn+https://user@subversion.com//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( 'svn+https://user@subversion.com/svn/trunk', 'x', '/something/to/add' );
  test.identical( got, 'svn+https://user@subversion.com//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( 'svn+https://user@subversion.com/svn/trunk', 'x', '/something/to/add', 'y' );
  test.identical( got, 'svn+https://user@subversion.com//something/to/add/y' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( 'svn+https://user@subversion.com/svn/trunk', '/something/to/add', '/y' );
  test.identical( got, 'svn+https://user@subversion.com//y' );

  /* */

  test.case = 'add absolute to uri with resourcePath';
  var uri = 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor';
  var parsed = _.weburi.parse( uri );
  var got = _.weburi.join_( uri, '/something/to/add' );
  test.identical( got, parsed.origin + '//something/to/add' + '?query=here&and=here#anchor' );

  test.case = 'add absolute to uri with resourcePath';
  var uri = 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor';
  var got = _.weburi.join_( uri, 'x', '/something/to/add' );
  test.identical( got, parsed.origin + '//something/to/add' + '?query=here&and=here#anchor' );

  test.case = 'add absolute to uri with resourcePath';
  var uri = 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor';
  var got = _.weburi.join_( uri, 'x', '/something/to/add', 'y' );
  test.identical( got, parsed.origin + '//something/to/add/y' + '?query=here&and=here#anchor' );

  test.case = 'add absolute to uri with resourcePath';
  var uri = 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor';
  var got = _.weburi.join_( uri, '/something/to/add', '/y' );
  test.identical( got, parsed.origin + '//y' + '?query=here&and=here#anchor' );

  /* */

  test.case = 'several queries and hashes'
  var uri1 = '://user:pass@sub.host.com:8080/p/a/t/h?query1=string1#hash1';
  var uri2 = '://user:pass@sub.host.com:8080/p/a/t/h?query2=string2#hash2';
  var got = _.weburi.join_( uri1, uri2, '/x//y//z' );
  var expected = '://user:pass@sub.host.com:8080//x//y//z?query1=string1&query2=string2#hash2';
  test.identical( got, expected );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( '://some.domain.com/was', '/something/to/add' );
  test.identical( got, '://some.domain.com//something/to/add' );

  var uri = '://user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.join_( uri, 'x' );
  var expected = '://user:pass@sub.host.com:8080/p/a/t/h/x?query=string#hash'
  test.identical( got, expected );

  var uri = '://user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.join_( uri, 'x', '/y' );
  var expected = '://user:pass@sub.host.com:8080//y?query=string#hash'
  test.identical( got, expected );

  var uri = '://user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.join_( uri, '/x//y//z' );
  var expected = '://user:pass@sub.host.com:8080//x//y//z?query=string#hash'
  test.identical( got, expected );

  var uri = '://user:pass@sub.host.com:8080/p//a//t//h?query=string#hash';
  var got = _.weburi.join_( uri, 'x' );
  var expected = '://user:pass@sub.host.com:8080/p//a//t//h/x?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.join_( uri, 'x' );
  var expected = ':///user:pass@sub.host.com:8080/p/a/t/h/x?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.join_( uri, 'x', '/y' );
  var expected = ':///user:pass@sub.host.com:8080//y?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.join_( uri, '/x//y//z' );
  var expected = ':///user:pass@sub.host.com:8080//x//y//z?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.join_( uri, 'x' );
  var expected = ':///user:pass@sub.host.com:8080/p/a/t/h/x?query=string#hash'
  test.identical( got, expected );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.join_( 'file:///some/file', '/something/to/add' );
  test.identical( got, 'file:///some//something/to/add' );

  /* */

  test.case = 'add uris';

  var got = _.weburi.join_( '//a', '//b', 'c' );
  test.identical( got, '//b/c' )

  var got = _.weburi.join_( 'b://c', 'd://e', 'f' );
  test.identical( got, 'd://e/f' );

  var got = _.weburi.join_( 'a://b', 'c://d/e', '//f/g' );
  test.identical( got, 'c://d///f/g' )

  /* */

  test.case = 'works like join_';
  var paths = [ 'c:\\', 'foo\\', 'bar\\' ];
  var expected = '/c/foo/bar/';
  var got = _.weburi.join_.apply( _.weburi, paths );
  test.identical( got, expected );

  test.case = 'join_ unix os paths';
  var paths = [ '/bar/', '/baz', 'foo/', '.' ];
  var expected = '/baz/foo';
  var got = _.weburi.join_.apply( _.weburi, paths );
  test.identical( got, expected );

  /* */

  test.case = 'more complicated cases';

  var paths = [ '/aa', 'bb//', 'cc' ];
  var expected = '/aa/bb//cc';
  var got = _.weburi.join_.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [ '/aa', 'bb//', 'cc', '.' ];
  var expected = '/aa/bb//cc';
  var got = _.weburi.join_.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [ '/', 'a', '//b', '././c', '../d', '..e' ];
  var expected = '//b/d/..e';
  var got = _.weburi.join_.apply( _.weburi, paths );
  test.identical( got, expected );
}

//

function joinRaw( test )
{
  test.case = 'join different protocols';

  var got = _.weburi.joinRaw( 'file://www.site.com:13', 'a', 'http:///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'file:///d', 'a', 'http:///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  test.case = 'joinRaw same protocols';

  var got = _.weburi.joinRaw( 'http://www.site.com:13', 'a', 'http:///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'http:///www.site.com:13', 'a', 'http:///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'http://server1', 'a', 'http://server2', 'b' );
  var expected = 'http://server2/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'http:///server1', 'a', 'http://server2', 'b' );
  var expected = 'http://server2/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'http://server1', 'a', 'http:///server2', 'b' );
  var expected = 'http:///server2/a/b';
  test.identical( got, expected );

  test.case = 'joinRaw protocol with protocol-less';

  var got = _.weburi.joinRaw( 'http://www.site.com:13', 'a', ':///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'http:///www.site.com:13', 'a', '://dir', 'b' );
  var expected = 'http://dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'http:///www.site.com:13', 'a', ':///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'http://www.site.com:13', 'a', '://dir', 'b' );
  var expected = 'http://dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'http://dir:13', 'a', '://dir', 'b' );
  var expected = 'http://dir:13/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'http://www.site.com:13', 'a', '://:14', 'b' );
  var expected = 'http://www.site.com:14/a/b';
  test.identical( got, expected );

  /**/

  var got = _.weburi.joinRaw( 'a', '://dir1/x', 'b', 'http://dir2/y', 'c' );
  var expected = 'http://dir2/a/x/b/y/c';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'a', ':///dir1/x', 'b', 'http://dir2/y', 'c' );
  var expected = 'http://dir2/a/x/b/y/c';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'a', '://dir1/x', 'b', 'http:///dir2/y', 'c' );
  var expected = 'http:///dir2/a/x/b/y/c';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'a', ':///dir1/x', 'b', 'http:///dir2/y', 'c' );
  var expected = 'http:///dir2/a/x/b/y/c';
  test.identical( got, expected );

  /* */

  test.case = 'server joinRaw absolute path 1';
  var got = _.weburi.joinRaw( 'http://www.site.com:13', '/x', '/y', '/z' );
  test.identical( got, 'http://www.site.com:13//z' );

  test.case = 'server joinRaw absolute path 2';
  var got = _.weburi.joinRaw( 'http://www.site.com:13/', 'x', '/y', '/z' );
  test.identical( got, 'http://www.site.com:13//z' );

  test.case = 'server joinRaw absolute path 2';
  var got = _.weburi.joinRaw( 'http://www.site.com:13/', 'x', 'y', '/z' );
  test.identical( got, 'http://www.site.com:13//z' );

  test.case = 'server joinRaw absolute path';
  var got = _.weburi.joinRaw( 'http://www.site.com:13/', 'x', '/y', 'z' );
  test.identical( got, 'http://www.site.com:13//y/z' );

  test.case = 'server joinRaw relative path';
  var got = _.weburi.joinRaw( 'http://www.site.com:13', 'x', 'y', 'z' );
  test.identical( got, 'http://www.site.com:13/x/y/z' );

  test.case = 'server with path joinRaw absolute path 2';
  var got = _.weburi.joinRaw( 'http://www.site.com:13/ab', '/y', '/z' );
  test.identical( got, 'http://www.site.com:13//z' );

  test.case = 'server with path joinRaw absolute path 2';
  var got = _.weburi.joinRaw( 'http://www.site.com:13/ab', '/y', 'z' );
  test.identical( got, 'http://www.site.com:13//y/z' );

  test.case = 'server with path joinRaw absolute path 2';
  var got = _.weburi.joinRaw( 'http://www.site.com:13/ab', 'y', 'z' );
  test.identical( got, 'http://www.site.com:13/ab/y/z' );

  test.case = 'add relative to uri with no resourcePath';
  var got = _.weburi.joinRaw( 'https://some.domain.com/', 'something/to/add' );
  test.identical( got, 'https://some.domain.com/something/to/add' );

  test.case = 'add relative to uri with resourcePath';
  var got = _.weburi.joinRaw( 'https://some.domain.com/was', 'something/to/add' );
  test.identical( got, 'https://some.domain.com/was/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( 'https://some.domain.com/was', '/something/to/add' );
  test.identical( got, 'https://some.domain.com//something/to/add' );

  /* */

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( '//some.domain.com/was', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( '://some.domain.com/was', '/something/to/add' );
  test.identical( got, '://some.domain.com//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( '//some.domain.com/was', 'x', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( '://some.domain.com/was', 'x', '/something/to/add' );
  test.identical( got, '://some.domain.com//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( '//some.domain.com/was', '/something/to/add', 'x' );
  test.identical( got, '/something/to/add/x' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( '://some.domain.com/was', '/something/to/add', 'x' );
  test.identical( got, '://some.domain.com//something/to/add/x' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( '//some.domain.com/was', '/something/to/add', '/x' );
  test.identical( got, '/x' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( '://some.domain.com/was', '/something/to/add', '/x' );
  test.identical( got, '://some.domain.com//x' );

  /* */

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( '/some/staging/index.html', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( '/some/staging/index.html', 'x', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( '/some/staging/index.html', 'x', '/something/to/add', 'y' );
  test.identical( got, '/something/to/add/y' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( '/some/staging/index.html', '/something/to/add', '/y' );
  test.identical( got, '/y' );

  /* */

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( '///some/staging/index.html', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( ':///some/staging/index.html', '/something/to/add' );
  test.identical( got, ':///some//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( '///some/staging/index.html', 'x', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( ':///some/staging/index.html', 'x', '/something/to/add' );
  test.identical( got, ':///some//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( '///some/staging/index.html', 'x', '/something/to/add', 'y' );
  test.identical( got, '/something/to/add/y' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( ':///some/staging/index.html', 'x', '/something/to/add', 'y' );
  test.identical( got, ':///some//something/to/add/y' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( '///some/staging/index.html', '/something/to/add', '/y' );
  test.identical( got, '/y' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( ':///some/staging/index.html', '/something/to/add', '/y' );
  test.identical( got, ':///some//y' );

  /* */

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( 'svn+https://user@subversion.com/svn/trunk', '/something/to/add' );
  test.identical( got, 'svn+https://user@subversion.com//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( 'svn+https://user@subversion.com/svn/trunk', 'x', '/something/to/add' );
  test.identical( got, 'svn+https://user@subversion.com//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( 'svn+https://user@subversion.com/svn/trunk', 'x', '/something/to/add', 'y' );
  test.identical( got, 'svn+https://user@subversion.com//something/to/add/y' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( 'svn+https://user@subversion.com/svn/trunk', '/something/to/add', '/y' );
  test.identical( got, 'svn+https://user@subversion.com//y' );

  /* */

  test.case = 'add absolute to uri with resourcePath';
  var uri = 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor';
  var parsed = _.weburi.parse( uri );
  var got = _.weburi.joinRaw( uri, '/something/to/add' );
  test.identical( got, parsed.origin + '//something/to/add' + '?query=here&and=here#anchor' );

  test.case = 'add absolute to uri with resourcePath';
  var uri = 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor';
  var got = _.weburi.joinRaw( uri, 'x', '/something/to/add' );
  test.identical( got, parsed.origin + '//something/to/add' + '?query=here&and=here#anchor' );

  test.case = 'add absolute to uri with resourcePath';
  var uri = 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor';
  var got = _.weburi.joinRaw( uri, 'x', '/something/to/add', 'y' );
  test.identical( got, parsed.origin + '//something/to/add/y' + '?query=here&and=here#anchor' );

  test.case = 'add absolute to uri with resourcePath';
  var uri = 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor';
  var got = _.weburi.joinRaw( uri, '/something/to/add', '/y' );
  test.identical( got, parsed.origin + '//y' + '?query=here&and=here#anchor' );

  /* */

  test.case = 'several queries and hashes'
  var uri1 = '://user:pass@sub.host.com:8080/p/a/t/h?query1=string1#hash1';
  var uri2 = '://user:pass@sub.host.com:8080/p/a/t/h?query2=string2#hash2';
  var got = _.weburi.joinRaw( uri1, uri2, '/x//y//z' );
  var expected = '://user:pass@sub.host.com:8080//x//y//z?query1=string1&query2=string2#hash2';
  test.identical( got, expected );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( '://some.domain.com/was', '/something/to/add' );
  test.identical( got, '://some.domain.com//something/to/add' );

  var uri = '://user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.joinRaw( uri, 'x' );
  var expected = '://user:pass@sub.host.com:8080/p/a/t/h/x?query=string#hash'
  test.identical( got, expected );

  var uri = '://user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.joinRaw( uri, 'x', '/y' );
  var expected = '://user:pass@sub.host.com:8080//y?query=string#hash'
  test.identical( got, expected );

  var uri = '://user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.joinRaw( uri, '/x//y//z' );
  var expected = '://user:pass@sub.host.com:8080//x//y//z?query=string#hash'
  test.identical( got, expected );

  var uri = '://user:pass@sub.host.com:8080/p//a//t//h?query=string#hash';
  var got = _.weburi.joinRaw( uri, 'x' );
  var expected = '://user:pass@sub.host.com:8080/p//a//t//h/x?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.joinRaw( uri, 'x' );
  var expected = ':///user:pass@sub.host.com:8080/p/a/t/h/x?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.joinRaw( uri, 'x', '/y' );
  var expected = ':///user:pass@sub.host.com:8080//y?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.joinRaw( uri, '/x//y//z' );
  var expected = ':///user:pass@sub.host.com:8080//x//y//z?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.joinRaw( uri, 'x' );
  var expected = ':///user:pass@sub.host.com:8080/p/a/t/h/x?query=string#hash'
  test.identical( got, expected );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw( 'file:///some/file', '/something/to/add' );
  test.identical( got, 'file:///some//something/to/add' );

  /* */

  test.case = 'add uris';

  var got = _.weburi.joinRaw( '//a', '//b', 'c' );
  test.identical( got, '//b/c' )

  var got = _.weburi.joinRaw( 'b://c', 'd://e', 'f' );
  test.identical( got, 'd://e/f' );

  var got = _.weburi.joinRaw( 'a://b', 'c://d/e', '//f/g' );
  test.identical( got, 'c://d///f/g' )

  /* */

  test.case = 'works like joinRaw';
  var paths = [ 'c:\\', 'foo\\', 'bar\\' ];
  var expected = '/c/foo/bar/';
  var got = _.weburi.joinRaw.apply( _.weburi, paths );
  test.identical( got, expected );

  test.case = 'joinRaw unix os paths';
  var paths = [ '/bar/', '/baz', 'foo/', '.' ];
  var expected = '/baz/foo/.';
  var got = _.weburi.joinRaw.apply( _.weburi, paths );
  test.identical( got, expected );

  /* */

  test.case = 'more complicated cases';

  /* xxx */

  var paths = [ '/aa', 'bb//', 'cc' ];
  var expected = '/aa/bb//cc';
  var got = _.weburi.joinRaw.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [ '/aa', 'bb//', 'cc', '.' ];
  var expected = '/aa/bb//cc/.';
  var got = _.weburi.joinRaw.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [ '/aa', 'bb//', 'cc', '.' ];
  var expected = '/aa/bb//cc/.';
  var got = _.weburi.joinRaw.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [ '/', 'a', '//b', '././c', '../d', '..e' ];
  var expected = '//b/././c/../d/..e';
  var got = _.weburi.joinRaw.apply( _.weburi, paths );
  test.identical( got, expected );

}

//

function joinRaw_( test )
{
  test.case = 'join different protocols';

  var got = _.weburi.joinRaw_( 'file://www.site.com:13', 'a', 'http:///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw_( 'file:///d', 'a', 'http:///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  test.case = 'joinRaw_ same protocols';

  var got = _.weburi.joinRaw_( 'http://www.site.com:13', 'a', 'http:///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw_( 'http:///www.site.com:13', 'a', 'http:///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw_( 'http://server1', 'a', 'http://server2', 'b' );
  var expected = 'http://server2/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw_( 'http:///server1', 'a', 'http://server2', 'b' );
  var expected = 'http://server2/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw_( 'http://server1', 'a', 'http:///server2', 'b' );
  var expected = 'http:///server2/a/b';
  test.identical( got, expected );

  test.case = 'joinRaw_ protocol with protocol-less';

  var got = _.weburi.joinRaw_( 'http://www.site.com:13', 'a', ':///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw_( 'http:///www.site.com:13', 'a', '://dir', 'b' );
  var expected = 'http://dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw_( 'http:///www.site.com:13', 'a', ':///dir', 'b' );
  var expected = 'http:///dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw_( 'http://www.site.com:13', 'a', '://dir', 'b' );
  var expected = 'http://dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw_( 'http://dir:13', 'a', '://dir', 'b' );
  var expected = 'http://dir:13/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw_( 'http://www.site.com:13', 'a', '://:14', 'b' );
  var expected = 'http://www.site.com:14/a/b';
  test.identical( got, expected );

  /**/

  var got = _.weburi.joinRaw_( 'a', '://dir1/x', 'b', 'http://dir2/y', 'c' );
  var expected = 'http://dir2/a/x/b/y/c';
  test.identical( got, expected );

  var got = _.weburi.joinRaw_( 'a', ':///dir1/x', 'b', 'http://dir2/y', 'c' );
  var expected = 'http://dir2/a/x/b/y/c';
  test.identical( got, expected );

  var got = _.weburi.joinRaw_( 'a', '://dir1/x', 'b', 'http:///dir2/y', 'c' );
  var expected = 'http:///dir2/a/x/b/y/c';
  test.identical( got, expected );

  var got = _.weburi.joinRaw_( 'a', ':///dir1/x', 'b', 'http:///dir2/y', 'c' );
  var expected = 'http:///dir2/a/x/b/y/c';
  test.identical( got, expected );

  /* */

  test.case = 'server joinRaw_ absolute path 1';
  var got = _.weburi.joinRaw_( 'http://www.site.com:13', '/x', '/y', '/z' );
  test.identical( got, 'http://www.site.com:13//z' );

  test.case = 'server joinRaw_ absolute path 2';
  var got = _.weburi.joinRaw_( 'http://www.site.com:13/', 'x', '/y', '/z' );
  test.identical( got, 'http://www.site.com:13//z' );

  test.case = 'server joinRaw_ absolute path 2';
  var got = _.weburi.joinRaw_( 'http://www.site.com:13/', 'x', 'y', '/z' );
  test.identical( got, 'http://www.site.com:13//z' );

  test.case = 'server joinRaw_ absolute path';
  var got = _.weburi.joinRaw_( 'http://www.site.com:13/', 'x', '/y', 'z' );
  test.identical( got, 'http://www.site.com:13//y/z' );

  test.case = 'server joinRaw_ relative path';
  var got = _.weburi.joinRaw_( 'http://www.site.com:13', 'x', 'y', 'z' );
  test.identical( got, 'http://www.site.com:13/x/y/z' );

  test.case = 'server with path joinRaw_ absolute path 2';
  var got = _.weburi.joinRaw_( 'http://www.site.com:13/ab', '/y', '/z' );
  test.identical( got, 'http://www.site.com:13//z' );

  test.case = 'server with path joinRaw_ absolute path 2';
  var got = _.weburi.joinRaw_( 'http://www.site.com:13/ab', '/y', 'z' );
  test.identical( got, 'http://www.site.com:13//y/z' );

  test.case = 'server with path joinRaw_ absolute path 2';
  var got = _.weburi.joinRaw_( 'http://www.site.com:13/ab', 'y', 'z' );
  test.identical( got, 'http://www.site.com:13/ab/y/z' );

  test.case = 'add relative to uri with no resourcePath';
  var got = _.weburi.joinRaw_( 'https://some.domain.com/', 'something/to/add' );
  test.identical( got, 'https://some.domain.com/something/to/add' );

  test.case = 'add relative to uri with resourcePath';
  var got = _.weburi.joinRaw_( 'https://some.domain.com/was', 'something/to/add' );
  test.identical( got, 'https://some.domain.com/was/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( 'https://some.domain.com/was', '/something/to/add' );
  test.identical( got, 'https://some.domain.com//something/to/add' );

  /* */

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( '//some.domain.com/was', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( '://some.domain.com/was', '/something/to/add' );
  test.identical( got, '://some.domain.com//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( '//some.domain.com/was', 'x', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( '://some.domain.com/was', 'x', '/something/to/add' );
  test.identical( got, '://some.domain.com//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( '//some.domain.com/was', '/something/to/add', 'x' );
  test.identical( got, '/something/to/add/x' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( '://some.domain.com/was', '/something/to/add', 'x' );
  test.identical( got, '://some.domain.com//something/to/add/x' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( '//some.domain.com/was', '/something/to/add', '/x' );
  test.identical( got, '/x' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( '://some.domain.com/was', '/something/to/add', '/x' );
  test.identical( got, '://some.domain.com//x' );

  /* */

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( '/some/staging/index.html', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( '/some/staging/index.html', 'x', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( '/some/staging/index.html', 'x', '/something/to/add', 'y' );
  test.identical( got, '/something/to/add/y' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( '/some/staging/index.html', '/something/to/add', '/y' );
  test.identical( got, '/y' );

  /* */

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( '///some/staging/index.html', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( ':///some/staging/index.html', '/something/to/add' );
  test.identical( got, ':///some//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( '///some/staging/index.html', 'x', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( ':///some/staging/index.html', 'x', '/something/to/add' );
  test.identical( got, ':///some//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( '///some/staging/index.html', 'x', '/something/to/add', 'y' );
  test.identical( got, '/something/to/add/y' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( ':///some/staging/index.html', 'x', '/something/to/add', 'y' );
  test.identical( got, ':///some//something/to/add/y' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( '///some/staging/index.html', '/something/to/add', '/y' );
  test.identical( got, '/y' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( ':///some/staging/index.html', '/something/to/add', '/y' );
  test.identical( got, ':///some//y' );

  /* */

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( 'svn+https://user@subversion.com/svn/trunk', '/something/to/add' );
  test.identical( got, 'svn+https://user@subversion.com//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( 'svn+https://user@subversion.com/svn/trunk', 'x', '/something/to/add' );
  test.identical( got, 'svn+https://user@subversion.com//something/to/add' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( 'svn+https://user@subversion.com/svn/trunk', 'x', '/something/to/add', 'y' );
  test.identical( got, 'svn+https://user@subversion.com//something/to/add/y' );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( 'svn+https://user@subversion.com/svn/trunk', '/something/to/add', '/y' );
  test.identical( got, 'svn+https://user@subversion.com//y' );

  /* */

  test.case = 'add absolute to uri with resourcePath';
  var uri = 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor';
  var parsed = _.weburi.parse( uri );
  var got = _.weburi.joinRaw_( uri, '/something/to/add' );
  test.identical( got, parsed.origin + '//something/to/add' + '?query=here&and=here#anchor' );

  test.case = 'add absolute to uri with resourcePath';
  var uri = 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor';
  var got = _.weburi.joinRaw_( uri, 'x', '/something/to/add' );
  test.identical( got, parsed.origin + '//something/to/add' + '?query=here&and=here#anchor' );

  test.case = 'add absolute to uri with resourcePath';
  var uri = 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor';
  var got = _.weburi.joinRaw_( uri, 'x', '/something/to/add', 'y' );
  test.identical( got, parsed.origin + '//something/to/add/y' + '?query=here&and=here#anchor' );

  test.case = 'add absolute to uri with resourcePath';
  var uri = 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor';
  var got = _.weburi.joinRaw_( uri, '/something/to/add', '/y' );
  test.identical( got, parsed.origin + '//y' + '?query=here&and=here#anchor' );

  /* */

  test.case = 'several queries and hashes'
  var uri1 = '://user:pass@sub.host.com:8080/p/a/t/h?query1=string1#hash1';
  var uri2 = '://user:pass@sub.host.com:8080/p/a/t/h?query2=string2#hash2';
  var got = _.weburi.joinRaw_( uri1, uri2, '/x//y//z' );
  var expected = '://user:pass@sub.host.com:8080//x//y//z?query1=string1&query2=string2#hash2';
  test.identical( got, expected );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( '://some.domain.com/was', '/something/to/add' );
  test.identical( got, '://some.domain.com//something/to/add' );

  var uri = '://user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.joinRaw_( uri, 'x' );
  var expected = '://user:pass@sub.host.com:8080/p/a/t/h/x?query=string#hash'
  test.identical( got, expected );

  var uri = '://user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.joinRaw_( uri, 'x', '/y' );
  var expected = '://user:pass@sub.host.com:8080//y?query=string#hash'
  test.identical( got, expected );

  var uri = '://user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.joinRaw_( uri, '/x//y//z' );
  var expected = '://user:pass@sub.host.com:8080//x//y//z?query=string#hash'
  test.identical( got, expected );

  var uri = '://user:pass@sub.host.com:8080/p//a//t//h?query=string#hash';
  var got = _.weburi.joinRaw_( uri, 'x' );
  var expected = '://user:pass@sub.host.com:8080/p//a//t//h/x?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.joinRaw_( uri, 'x' );
  var expected = ':///user:pass@sub.host.com:8080/p/a/t/h/x?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.joinRaw_( uri, 'x', '/y' );
  var expected = ':///user:pass@sub.host.com:8080//y?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.joinRaw_( uri, '/x//y//z' );
  var expected = ':///user:pass@sub.host.com:8080//x//y//z?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.joinRaw_( uri, 'x' );
  var expected = ':///user:pass@sub.host.com:8080/p/a/t/h/x?query=string#hash'
  test.identical( got, expected );

  test.case = 'add absolute to uri with resourcePath';
  var got = _.weburi.joinRaw_( 'file:///some/file', '/something/to/add' );
  test.identical( got, 'file:///some//something/to/add' );

  /* */

  test.case = 'add uris';

  var got = _.weburi.joinRaw_( '//a', '//b', 'c' );
  test.identical( got, '//b/c' )

  var got = _.weburi.joinRaw_( 'b://c', 'd://e', 'f' );
  test.identical( got, 'd://e/f' );

  var got = _.weburi.joinRaw_( 'a://b', 'c://d/e', '//f/g' );
  test.identical( got, 'c://d///f/g' )

  /* */

  test.case = 'works like joinRaw_';
  var paths = [ 'c:\\', 'foo\\', 'bar\\' ];
  var expected = '/c/foo/bar/';
  var got = _.weburi.joinRaw_.apply( _.weburi, paths );
  test.identical( got, expected );

  test.case = 'joinRaw_ unix os paths';
  var paths = [ '/bar/', '/baz', 'foo/', '.' ];
  var expected = '/baz/foo/.';
  var got = _.weburi.joinRaw_.apply( _.weburi, paths );
  test.identical( got, expected );

  /* */

  test.case = 'more complicated cases';

  /* xxx */

  var paths = [ '/aa', 'bb//', 'cc' ];
  var expected = '/aa/bb//cc';
  var got = _.weburi.joinRaw_.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [ '/aa', 'bb//', 'cc', '.' ];
  var expected = '/aa/bb//cc/.';
  var got = _.weburi.joinRaw_.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [ '/aa', 'bb//', 'cc', '.' ];
  var expected = '/aa/bb//cc/.';
  var got = _.weburi.joinRaw_.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [ '/', 'a', '//b', '././c', '../d', '..e' ];
  var expected = '//b/././c/../d/..e';
  var got = _.weburi.joinRaw_.apply( _.weburi, paths );
  test.identical( got, expected );

}

//

function resolve( test )
{

  var got = _.weburi.resolve( 'http://www.site.com:13', 'a' );
  test.identical( got, 'http://www.site.com:13//a' );

  var got = _.weburi.resolve( 'http://www.site.com:13/', 'a' );
  test.identical( got, 'http://www.site.com:13//a' );

  var got = _.weburi.resolve( 'http://www.site.com:13', 'a', '/b' );
  test.identical( got, 'http://www.site.com:13//b' );

  var got = _.weburi.resolve( 'http://www.site.com:13', 'a', '/b', 'c' );
  test.identical( got, 'http://www.site.com:13//b/c' );

  var got = _.weburi.resolve( 'http://www.site.com:13', '/a/', '/b/', 'c/', '.' );
  test.identical( got, 'http://www.site.com:13//b/c' );

  var got = _.weburi.resolve( 'http://www.site.com:13', 'a', '.', 'b' );
  test.identical( got, 'http://www.site.com:13//a/b' );

  var got = _.weburi.resolve( 'http://www.site.com:13/', 'a', '.', 'b' );
  test.identical( got, 'http://www.site.com:13//a/b' );

  var got = _.weburi.resolve( 'http://www.site.com:13', 'a', '..', 'b' );
  test.identical( got, 'http://www.site.com:13//b' );

  var got = _.weburi.resolve( 'http://www.site.com:13', 'a', '..', '..', 'b' );
  test.identical( got, 'http://www.site.com:13//../b' );

  var got = _.weburi.resolve( 'http://www.site.com:13', '.a.', 'b', '.c.' );
  test.identical( got, 'http://www.site.com:13//.a./b/.c.' );

  var got = _.weburi.resolve( 'http://www.site.com:13/', '.a.', 'b', '.c.' );
  test.identical( got, 'http://www.site.com:13//.a./b/.c.' );

  var got = _.weburi.resolve( 'http://www.site.com:13', 'a/../' );
  test.identical( got, 'http://www.site.com:13//' );

  var got = _.weburi.resolve( 'http://www.site.com:13/', 'a/../' );
  test.identical( got, 'http://www.site.com:13//' );

  /* */

  var got = _.weburi.resolve( '://www.site.com:13', 'a' );
  test.identical( got, '://www.site.com:13//a' );

  var got = _.weburi.resolve( '://www.site.com:13/', 'a' );
  test.identical( got, '://www.site.com:13//a' );

  var got = _.weburi.resolve( '://www.site.com:13', 'a', '/b' );
  test.identical( got, '://www.site.com:13//b' );

  var got = _.weburi.resolve( '://www.site.com:13', 'a', '/b', 'c' );
  test.identical( got, '://www.site.com:13//b/c' );

  var got = _.weburi.resolve( '://www.site.com:13', '/a/', '/b/', 'c/', '.' );
  test.identical( got, '://www.site.com:13//b/c' );

  var got = _.weburi.resolve( '://www.site.com:13', 'a', '.', 'b' );
  test.identical( got, '://www.site.com:13//a/b' );

  var got = _.weburi.resolve( '://www.site.com:13/', 'a', '.', 'b' );
  test.identical( got, '://www.site.com:13//a/b' );

  var got = _.weburi.resolve( '://www.site.com:13', 'a', '..', 'b' );
  test.identical( got, '://www.site.com:13//b' );

  var got = _.weburi.resolve( '://www.site.com:13', 'a', '..', '..', 'b' );
  test.identical( got, '://www.site.com:13//../b' );

  var got = _.weburi.resolve( '://www.site.com:13', '.a.', 'b', '.c.' );
  test.identical( got, '://www.site.com:13//.a./b/.c.' );

  var got = _.weburi.resolve( '://www.site.com:13/', '.a.', 'b', '.c.' );
  test.identical( got, '://www.site.com:13//.a./b/.c.' );

  var got = _.weburi.resolve( '://www.site.com:13', 'a/../' );
  test.identical( got, '://www.site.com:13//' );

  var got = _.weburi.resolve( '://www.site.com:13/', 'a/../' );
  test.identical( got, '://www.site.com:13//' );

  /* */

  var got = _.weburi.resolve( ':///www.site.com:13', 'a' );
  test.identical( got, ':///www.site.com:13//a' );

  var got = _.weburi.resolve( ':///www.site.com:13/', 'a' );
  test.identical( got, ':///www.site.com:13//a' );

  var got = _.weburi.resolve( ':///www.site.com:13', 'a', '/b' );
  test.identical( got, ':///www.site.com:13//b' );

  var got = _.weburi.resolve( ':///www.site.com:13', 'a', '/b', 'c' );
  test.identical( got, ':///www.site.com:13//b/c' );

  var got = _.weburi.resolve( ':///www.site.com:13', '/a/', '/b/', 'c/', '.' );
  test.identical( got, ':///www.site.com:13//b/c' );

  var got = _.weburi.resolve( ':///www.site.com:13', 'a', '.', 'b' );
  test.identical( got, ':///www.site.com:13//a/b' );

  var got = _.weburi.resolve( ':///www.site.com:13/', 'a', '.', 'b' );
  test.identical( got, ':///www.site.com:13//a/b' );

  var got = _.weburi.resolve( ':///www.site.com:13', 'a', '..', 'b' );
  test.identical( got, ':///www.site.com:13//b' );

  var got = _.weburi.resolve( ':///www.site.com:13', 'a', '..', '..', 'b' );
  test.identical( got, ':///www.site.com:13//../b' );

  var got = _.weburi.resolve( ':///www.site.com:13', '.a.', 'b', '.c.' );
  test.identical( got, ':///www.site.com:13//.a./b/.c.' );

  var got = _.weburi.resolve( ':///www.site.com:13/', '.a.', 'b', '.c.' );
  test.identical( got, ':///www.site.com:13//.a./b/.c.' );

  var got = _.weburi.resolve( ':///www.site.com:13', 'a/../' );
  test.identical( got, ':///www.site.com:13//' );

  var got = _.weburi.resolve( ':///www.site.com:13/', 'a/../' );
  test.identical( got, ':///www.site.com:13//' );

  /* */

  var got = _.weburi.resolve( '/some/staging/index.html', 'a' );
  test.identical( got, '/some//staging/index.html/a' );

  var got = _.weburi.resolve( '/some/staging/index.html', '.' );
  test.identical( got, '/some//staging/index.html' );

  var got = _.weburi.resolve( '/some/staging/index.html/', 'a' );
  test.identical( got, '/some//staging/index.html/a' );

  var got = _.weburi.resolve( '/some/staging/index.html', 'a', '/b' );
  test.identical( got, '/b' );

  var got = _.weburi.resolve( '/some/staging/index.html', 'a', '/b', 'c' );
  test.identical( got, '/b//c' );

  var got = _.weburi.resolve( '/some/staging/index.html', '/a/', '/b/', 'c/', '.' );
  test.identical( got, '/b//c' );

  var got = _.weburi.resolve( '/some/staging/index.html', 'a', '.', 'b' );
  test.identical( got, '/some//staging/index.html/a/b' );

  var got = _.weburi.resolve( '/some/staging/index.html/', 'a', '.', 'b' );
  test.identical( got, '/some//staging/index.html/a/b' );

  var got = _.weburi.resolve( '/some/staging/index.html', 'a', '..', 'b' );
  test.identical( got, '/some//staging/index.html/b' );

  var got = _.weburi.resolve( '/some/staging/index.html', 'a', '..', '..', 'b' );
  test.identical( got, '/some//staging/b' );

  var got = _.weburi.resolve( '/some/staging/index.html', '.a.', 'b', '.c.' );
  test.identical( got, '/some//staging/index.html/.a./b/.c.' );

  var got = _.weburi.resolve( '/some/staging/index.html/', '.a.', 'b', '.c.' );
  test.identical( got, '/some//staging/index.html/.a./b/.c.' );

  var got = _.weburi.resolve( '/some/staging/index.html/', 'a/../' );
  test.identical( got, '/some//staging/index.html/' );

  var got = _.weburi.resolve( '/some/staging/index.html/', 'a/../' );
  test.identical( got, '/some//staging/index.html/' );

  var got = _.weburi.resolve( '//some/staging/index.html', '.', 'a' );
  test.identical( got, '///some/staging/index.html/a' );

  var got = _.weburi.resolve( '///some/staging/index.html', 'a', '.', 'b', '..' );
  test.identical( got, '///some/staging/index.html/a' );

  var got = _.weburi.resolve( 'file:///some/staging/index.html', '../..' );
  test.identical( got, 'file:///some//' );

  var got = _.weburi.resolve( 'svn+https://user@subversion.com/svn/trunk', '../a', 'b', '../c' );
  test.identical( got, 'svn+https://user@subversion.com//svn/a/c' );

  var got = _.weburi.resolve( 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor', '../../path/name' );
  test.identical( got, 'complex+protocol://www.site.com:13//path/name?query=here&and=here#anchor' )

  var got = _.weburi.resolve( 'https://web.archive.org/web/*\/http://www.heritage.org/index/ranking', '../../../a.com' );
  test.identical( got, 'https://web.archive.org/web/*\/http://a.com' );

  var got = _.weburi.resolve( '127.0.0.1:61726', '../path' );
  test.identical( got, 'path' );

  var got = _.weburi.resolve( 'http://127.0.0.1:61726', '../path' );
  test.identical( got, 'http://127.0.0.1:61726//../path' );

  /* */

  test.case = 'works like resolve';

  var paths = [ 'c:\\', 'foo\\', 'bar\\' ];
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, '/c//foo/bar/' );

  var paths = [ '/bar/', '/baz', 'foo/', '.' ];
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, '/baz//foo' );

  var paths = [ 'aa', '.', 'cc' ];
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, 'aa//cc' );

  var paths = [ 'aa', 'cc', '.' ];
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, 'aa//cc' );

  var paths = [ '.', 'aa', 'cc' ];
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, './/aa/cc' );

  var paths = [ '.', 'aa', 'cc', '..' ];
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, './/aa' );

  var paths = [ '.', 'aa', 'cc', '..', '..' ];
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, '.' );

  var paths = [ 'aa', 'cc', '..', '..', '..' ];
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, '..' );

  var paths = [ '.x.', 'aa', 'bb', '.x.' ];
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, '.x.//aa/bb/.x.' );

  var paths = [ '..x..', 'aa', 'bb', '..x..' ];
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, '..x..//aa/bb/..x..' );

  var paths = [ '/abc', './../a/b' ];
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, '/a//b' );

  var paths = [ '/abc', 'a/.././a/b' ];
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, '/abc//a/b' );

  var paths = [ '/abc', '.././a/b' ];
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, '/a//b' );

  var paths = [ '/abc', './.././a/b' ];
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, '/a//b' );

  var paths = [ '/abc', './../.' ];
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, '/' );

  var paths = [ '/abc', './../../.' ];
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, '/..' );

  var paths = [ '/abc', './../.' ];
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, '/' );
}

// --
// declare
// --

const Proto =
{

  name : 'Tools.l4.WebUriFundamentals',
  silencing : 1,

  tests :
  {

    join,
    join_, /* Dmytro : analog of join for routine join_ */
    joinRaw,
    joinRaw_, /* Dmytro : analog of joinRaw for routine joinRaw_ */
    resolve,

  },

}

const Self = wTestSuite( Proto );

if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self );

})();
