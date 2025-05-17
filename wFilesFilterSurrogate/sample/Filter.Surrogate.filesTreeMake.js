if( typeof module !== 'undefined' )
require( 'wfilesfiltersurrogate' )

var _ = wTools;

/* making file tree cache */

var rootPath = __dirname;
var testDir = _.join( rootPath, 'SurrogateSample' );

_.fileProvider.fileDelete( testDir );

var tree = _.FileFilter.Surrogate.filesTreeMake( rootPath );

/* writting to *.js file */

var fileTreePath = _.join( testDir, 'wFilesFilterSurrogate.js' );

/* prepare data: rootPath and tree as json object */
var data = 'var rootPath = ' + _.toStr( rootPath, { wrap : 1 } );
data = data + '\nvar wFilesTree = \n' + _.toStr( tree, { jsonLike : 1 , multiline : 1 } );

_.fileProvider.fileWrite( fileTreePath, data );

console.log( 'Written to file: ', fileTreePath );