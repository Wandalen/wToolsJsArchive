const _ = require( 'wTools' );
require( 'wuribasic' );

var path = '/C:\\temp\\\\foo\\bar\\';
console.log( _.uri.canonize( path ) );
/* log : /C:/temp//foo/bar */

var path = '/C:\\temp\\\\foo\\\\bar\\..\\';
console.log( _.uri.canonize( path ) );
/* log : /C:/temp//foo */

var path = 'foo/././bar/././baz/';
console.log( _.uri.canonize( path ) );
/* log : foo/bar/baz */

