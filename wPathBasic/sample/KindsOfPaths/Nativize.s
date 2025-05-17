const _ = require( 'wTools' );
require( 'wuribasic' );

// posix path similar to drive letter
let path = '/A';
console.log( _.uri.nativize( path ) );
/*
  if( process.platform === 'win32' )
  log : A:\
  else
  log : /A
*/

// posix path similar to Windows path with drive letter
path = '/C/Documents/Newsletters/Summer2018.pdf';
console.log( _.uri.nativize( path ) );
/*
  if( process.platform === 'win32' )
  log : C:\Documents\Newsletters\Summer2018.pdf
  else
  log : /C/Documents/Newsletters/Summer2018.pdf
*/

// posix path similar to Windows path
path = '/Documents/Newsletters/Summer2018.pdf';
console.log( _.uri.nativize( path ) );
/*
  if( process.platform === 'win32' )
  log : \Documents\Newsletters\Summer2018.pdf
  else
  log : /Documents/Newsletters/Summer2018.pdf
*/

//

// posix path with directory in root
path = '/bin';
console.log( _.uri.nativize( path ) );
/*
  if( process.platform === 'win32' )
  log : \bin
  else
  log : /bin
*/

// posix user path
path = '/home/mthomas/class_stuff/foo';
console.log( _.uri.nativize( path ) );
/*
  if( process.platform === 'win32' )
  log : \home\mthomas\class_stuff\foo
  else
  log : /home/mthomas/class_stuff/foo
*/
