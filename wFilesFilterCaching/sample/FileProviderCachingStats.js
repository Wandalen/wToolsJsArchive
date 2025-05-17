
if( typeof module !== 'undefined' )
require( 'wfilesfiltercaching' )

var _ = wTools;

var cachingStats = _.FileFilter.Caching({ cachingDirs : 0, cachingRecord : 0 });

var dir = _.join( _.dir( _.realMainFile() ), 'cachingStatsSample' );
_.fileProvider.fileDelete( dir );
var filePath = _.join( dir, 'file.txt' );

/* get stat for current dir and cache them */

var fileStatSync = cachingStats.fileStat( _.realMainDir() );
console.log( "\nfileStatSync: ",fileStatSync );
console.log( "cacheStats: ",cachingStats._cacheStats );

/* fileWrite - rewriting of a file updates stats cache */

// //creating file
// cachingStats.fileWrite( filePath, 'aaa' );
// var fileStatSync = cachingStats.fileStat( filePath );
// console.log( "\nfileStat before: ",fileStatSync );
// //rewriting
// cachingStats.fileWrite( filePath, 'aaaaaa' );
// var fileStatSync = cachingStats.fileStat( filePath );
// console.log( "\nfileStat after : ",fileStatSync );
// console.log( "cacheStats: ",cachingStats._cacheStats );

/* deleting of existing file invokes deleting of chached stats */

// //creating file and caching it stats
// cachingStats.fileWrite( filePath, 'abc' );
// cachingStats.fileStat( filePath );
// console.log( "\ncachedStats: ", cachingStats._cacheStats );
// //deleting
// cachingStats.fileDelete( filePath );
// var fileStatSync = cachingStats.fileStat( filePath );
// console.log( "\nfileStatSync: ", fileStatSync );
// console.log( "\ncachedStats: ", cachingStats._cacheStats );

/* creating of new dir updates cache if file stat was already cached */

// //creating file
// cachingStats.fileWrite( filePath, 'abc' );
// //caching stat
// cachingStats.fileStat( filePath );
// var fileStatSync = cachingStats.fileStat( filePath );
// console.log( "\nfileStatSync: ",fileStatSync );
// //making dir by rewriting file and updating it cache
// cachingStats.directoryMake( filePath );
// var fileStatSync = cachingStats.fileStat( filePath );
// console.log( "\nfileStatSync: ",fileStatSync );
// console.log( "cacheStats: ",cachingStats._cacheStats );

/* renaming invokes stats updating */

// //creating file
// cachingStats.fileWrite( filePath, 'abc' );
// //caching stat
// cachingStats.fileStat( filePath );
// console.log( "cacheStats: ",cachingStats._cacheStats );
// //renaming
// cachingStats.fileRename( _.join( dir, 'file.js' ), filePath );
// console.log( "cacheStats: ",cachingStats._cacheStats );

/* copying invokes stats updating */
// //creating file
// cachingStats.fileWrite( filePath, 'abc' );
// //caching stat
// cachingStats.fileStat( filePath );
// cachingStats.fileStat( _.join( dir, 'file.js' ) );
// console.log( "cacheStats: ",cachingStats._cacheStats );
// //copying
// cachingStats.fileCopy( _.join( dir, 'file.js' ), filePath );
// console.log( "cacheStats: ",cachingStats._cacheStats );
