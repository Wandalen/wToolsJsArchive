// ( function _TemplateFileWriter_test_s_( )
// {
//
// 'use strict';
//
// if( typeof module !== 'undefined' )
// {
//   const _ = require( 'Tools' );
//   _.include( 'wTesting' );
//   require( '../l5_mapper/TemplateFileWriter.s' );
// }
//
// //
//
// const _ = _global_.wTools;
//
// // --
// // context
// // --
//
// function onSuiteBegin( test )
// {
//   let context = this;
// }
//
// //
//
// function onSuiteEnd()
// {
//   // let path = this.provider.path;
//   // _.assert( _.strHas( this.suiteTempPath.filePath, 'tmp.tmp' ) );
//   // _.assert( _.strHas( this.suiteTempPath.filePath, 'suite-TemplateFileWriter' ) );
//   // path.tempClose( this.suiteTempPath.filePath );
//   // this.provider.finit();
// }
//
// //
//
// function onRoutineEnd( test )
// {
//   let context = this;
//   // let provider = context.provider;
//   // let path = context.provider.path;
// }
//
// //
//
// function assetFor( test, a )
// {
//   let context = this;
//
//   if( !_.mapIs( a ) )
//   {
//     if( _.boolIs( arguments[ 1 ] ) )
//     a = { originalAssetPath : arguments[ 1 ] }
//     else
//     a = { assetName : arguments[ 1 ] }
//   }
//
//   if( !a.fileProvider )
//   {
//     a.fileProvider = context.providerMake();
//   }
//
//   a = test.assetFor( a );
//
//   return a;
// }
//
// //--
// // tests
// //--
//
// function templateFileWriter( test )
// {
//   let context = this;
//   let a = context.assetFor( test, false );
//   // let provider = context.provider;
//   // let a.abs( '.' ) = context.suiteTempPath.filePath;
//
//   var template =
//   {
//     'tmp.tmp' :
//     {
//       'folder' :
//       {
//         'file.js' : 'console.log( "file.js" );'
//       },
//       'test1.txt' : 'Test file1 content',
//       'test2.s' : 'Test file2 content',
//     }
//   };
//   var templateFile = `const Proto = { file : 'Content of file' };\
//                      \nif( typeof module !== 'undefined' )\
//                      \nmodule[ 'exports' ] = Self;`;
//
//   /* testing of rewriting existed files by templateWriter */
//
//   test.case = 'rewriting test';
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   a.fileProvider.fileWrite( a.abs( '.' ) + '/tmp.tmp/test2.s', 'Should not be overwritten, test2.s' );
//   a.fileProvider.fileWrite( a.abs( '.' ) + '/tmp.tmp/folder/file.js', 'Should not be overwritten, file.js' );
//   var writer = _.TemplateFileWriter
//   ({
//     template,
//     dst : a.abs( '.' ),
//     dstProvider : a.fileProvider,
//     srcProvider : a.fileProvider,
//   });
//   writer.form();
//   var expected = 'Should not be overwritten, test2.s';
//   var got = a.fileProvider.fileRead( a.abs( '.' ) + '/tmp.tmp/test2.s' );
//   test.identical( got, expected );
//   var expected1 = 'Should not be overwritten, file.js';
//   var got1 = a.fileProvider.fileRead( a.abs( '.' ) + '/tmp.tmp/folder/file.js' );
//   test.identical( got1, expected1 );
//   var got2 = a.fileProvider.filesFindRecursive( { filePath : a.abs( '.' ) + '/tmp.tmp', outputFormat : 'relative' } );
//   var expected2 = [ '.', './test1.txt', './test2.s', './folder', './folder/file.js' ];
//   test.identical( got2, expected2 );
//
//   /* test, template */
//
//   test.case = 'template, dst, dstProvider, base test';
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var writer = _.TemplateFileWriter
//   ({
//     template,
//     dst : a.abs( '.' ),
//     dstProvider : a.fileProvider,
//     srcProvider : a.fileProvider,
//   });
//   writer.form();
//   var got = a.fileProvider.filesFindRecursive( { filePath : a.abs( '.' ) + '/tmp.tmp', outputFormat : 'relative' } );
//   var expected = [ '.', './test1.txt', './test2.s', './folder', './folder/file.js' ];
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'template, dst, dstProvider, name, base test';
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var writer = _.TemplateFileWriter
//   ({
//     dst : a.abs( '.' ),
//     template,
//     dstProvider : a.fileProvider,
//     srcProvider : a.fileProvider,
//     name : 'filename',
//   });
//   writer.form();
//   var got = a.fileProvider.filesFindRecursive( { filePath : a.abs( '.' ) + '/tmp.tmp', outputFormat : 'relative' } );
//   var expected = [ '.', './test1.txt', './test2.s', './folder', './folder/file.js' ];
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'template, without dst';
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var writer = _.TemplateFileWriter
//   ({
//     template,
//     dstProvider : a.fileProvider,
//     srcProvider : a.fileProvider,
//   });
//   writer.form();
//   var got = a.fileProvider.filesFindRecursive( { filePath : a.fileProvider.path.current() + '/tmp.tmp', outputFormat : 'relative' } );
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var expected = [ '.', './test1.txt', './test2.s', './folder', './folder/file.js' ];
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'template, without dst, name';
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var writer = _.TemplateFileWriter
//   ({
//     template,
//     dstProvider : a.fileProvider,
//     srcProvider : a.fileProvider,
//     name : 'filename',
//   });
//   writer.form();
//   var got = a.fileProvider.filesFindRecursive( { filePath : a.fileProvider.path.current() + '/tmp.tmp', outputFormat : 'relative' } );
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var expected = [ '.', './test1.txt', './test2.s', './folder', './folder/file.js' ];
//   test.identical( got, expected );
//
//   /* srcProvider is instance of FileProvider.Extract */
//
//   var srcProvider = _.FileProvider.Extract
//   ({
//     filesTree : template,
//   });
//
//   test.case = 'srcProvider - instance of Extract, dst, dstProvider';
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var writer = _.TemplateFileWriter
//   ({
//     srcProvider,
//     dst : a.abs( '.' ),
//     dstProvider : a.fileProvider,
//     srcProvider : a.fileProvider,
//   });
//   writer.form();
//   var got = a.fileProvider.filesFindRecursive( { filePath : a.abs( '.' ) + '/tmp.tmp', outputFormat : 'relative' } );
//   var expected = [ '.', './test1.txt', './test2.s', './folder', './folder/file.js' ];
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'srcProvider - instance of Extract, dst, dstProvider, name';
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var writer = _.TemplateFileWriter
//   ({
//     srcProvider,
//     dst : a.abs( '.' ),
//     dstProvider : a.fileProvider,
//     srcProvider : a.fileProvider,
//     name : 'filename',
//   });
//   writer.form();
//   var got = a.fileProvider.filesFindRecursive( { filePath : a.abs( '.' ) + '/tmp.tmp', outputFormat : 'relative' } );
//   var expected = [ '.', './test1.txt', './test2.s', './folder', './folder/file.js' ];
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'srcProvider - instance of Extract, dstProvider';
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var writer = _.TemplateFileWriter
//   ({
//     srcProvider,
//     dstProvider : a.fileProvider,
//   });
//   writer.form();
//   var got = a.fileProvider.filesFindRecursive( { filePath : a.fileProvider.path.current() + '/tmp.tmp', outputFormat : 'relative' } );
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var expected = [ '.', './test1.txt', './test2.s', './folder', './folder/file.js' ];
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'srcProvider - instance of Extract, dstProvider, name';
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var writer = _.TemplateFileWriter
//   ({
//     srcProvider,
//     dstProvider : a.fileProvider,
//     name : 'filename',
//   });
//   writer.form();
//   var got = a.fileProvider.filesFindRecursive( { filePath : a.fileProvider.path.current() + '/tmp.tmp', outputFormat : 'relative' } );
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var expected = [ '.', './test1.txt', './test2.s', './folder', './folder/file.js' ];
//   test.identical( got, expected );
//
//   /* resolver using */
//
//   test.case = 'default onConfigGet';
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var template =
//   {
//     file : '{:name :}, {:lowName:}, {:highName:}'
//   };
//   var writer = _.TemplateFileWriter
//   ({
//     template,
//     dst : a.abs( '.' ),
//     dstProvider : a.fileProvider,
//     srcProvider : a.fileProvider,
//   });
//   writer.form();
//   var got = a.fileProvider.fileRead( a.abs( '.' ) + '/file' );
//   var name = _.path.name( a.abs( '.' ) );
//   var expected = name + ', ' + name.toLowerCase() + ', ' + name.toUpperCase();
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'custom onConfigGet';
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var template =
//   {
//     file : '{:name :}, {:lowName:}, {:highName:}'
//   };
//   function configGet()
//   {
//     return { name : 'File', lowName : 'file', highName : 'FILE' };
//   }
//   var writer = _.TemplateFileWriter
//   ({
//     template,
//     dst : a.abs( '.' ),
//     dstProvider : a.fileProvider,
//     srcProvider : a.fileProvider,
//     onConfigGet : configGet,
//   });
//   writer.form();
//   var got = a.fileProvider.fileRead( a.abs( '.' ) + '/file' );
//   var expected = 'File, file, FILE';
//   test.identical( got, expected );
//
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var template =
//   {
//     file : '{:any.key:} : {:any.value:}'
//   };
//   function configGet2()
//   {
//     return { 'any.key' : 'key', 'any.value' : 'value' };
//   }
//   var writer = _.TemplateFileWriter
//   ({
//     template,
//     dst : a.abs( '.' ),
//     dstProvider : a.fileProvider,
//     srcProvider : a.fileProvider,
//     onConfigGet : configGet2,
//   });
//   writer.form();
//   var got = a.fileProvider.fileRead( a.abs( '.' ) + '/file' );
//   var expected = 'key : value';
//   test.identical( got, expected );
//
//   /* - */
//
//   if( !Config.debug )
//   return;
//
//   test.case = 'passed argument in routine form()';
//   test.shouldThrowErrorSync( function()
//   {
//     var write = _.templateFileWriter
//     ({
//       dstProvider : a.fileProvider,
//       srcProvider : a.fileProvider,
//       template,
//     });
//     write.form( template );
//   });
//
//   test.case = 'srcProvider + template';
//   test.shouldThrowErrorSync( function()
//   {
//     var write = _.templateFileWriter
//     ({
//       srcProvider : a.fileProvider,
//       template,
//     });
//     write.form();
//   });
//
//   test.case = 'srcProvider + srcTemplatePath';
//   test.shouldThrowErrorSync( function()
//   {
//     var write = _.templateFileWriter
//     ({
//       srcProvider : a.fileProvider,
//       srcTemplatePath : a.abs( '.' ),
//     });
//     write.form();
//   });
//
//   test.case = 'srcProvider is instance of HardDrive';
//   test.shouldThrowErrorSync( function()
//   {
//     var write = _.templateFileWriter
//     ({
//       srcProvider : _.fileProvider,
//       template,
//     });
//     write.form();
//   });
//
// }
//
// //
//
// function templateFileWriterLinks( test )
// {
//   let context = this;
//   let a = context.assetFor( test, false );
//   // let provider = context.provider;
//   // let a.abs( '.' ) = context.suiteTempPath.filePath;
//
//   var templateFile = `const Proto = { file : 'Content of file' };\
//                      \nif( typeof module !== 'undefined' )\
//                      \nmodule[ 'exports' ] = Self;`;
//
//   /* test, srcTemplatePath */
//
//   test.case = 'without srcTemplatePath, dst, dstProvider';
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var defaultTemplate = a.abs( 'Template.s' );
//   a.fileProvider.fileWrite( defaultTemplate, templateFile );
//   var writer = _.TemplateFileWriter
//   ({
//     dst : a.abs( '.' ),
//     dstProvider : a.fileProvider,
//     srcProvider : a.fileProvider,
//   });
//   debugger;
//   writer.form();
//   debugger;
//   a.fileProvider.filesDelete( defaultTemplate );
//   var got = a.fileProvider.filesFindRecursive( { filePath : a.abs( '.' ), outputFormat : 'relative' } );
//   var expected = [ '.', './file' ];
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'srcTemplatePath is hard link, dst, dstProvider';
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var pathToTemp = a.fileProvider.path.tempOpen( 'tmp.tmp' );
//   var customTemplate = pathToTemp + '/Template.s';
//   a.fileProvider.fileWrite( customTemplate, templateFile );
//   var writer = _.TemplateFileWriter
//   ({
//     srcTemplatePath : customTemplate,
//     dst : a.abs( '.' ),
//     dstProvider : a.fileProvider,
//     srcProvider : a.fileProvider,
//   });
//   writer.form();
//   a.fileProvider.filesDelete( pathToTemp );
//   var got = a.fileProvider.filesFindRecursive( { filePath : a.abs( '.' ), outputFormat : 'relative' } );
//   var expected = [ '.', './file' ];
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'srcTemplatePath is soft link, dst, dstProvider';
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var pathToTemp = a.fileProvider.path.tempOpen( 'tmp.tmp' );
//   var customTemplate = pathToTemp + '/Template.s';
//   var softlink = pathToTemp + '/softlink';
//   a.fileProvider.fileWrite( customTemplate, templateFile );
//   a.fileProvider.softLink( softlink, customTemplate );
//   var writer = _.TemplateFileWriter
//   ({
//     srcTemplatePath : softlink,
//     dst : a.abs( '.' ),
//     dstProvider : a.fileProvider,
//     srcProvider : a.fileProvider,
//   });
//   writer.form();
//   a.fileProvider.filesDelete( pathToTemp );
//   var got = a.fileProvider.filesFindRecursive( { filePath : a.abs( '.' ), outputFormat : 'relative' } );
//   var expected = [ '.', './file' ];
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'srcTemplatePath is double soft link, dst, dstProvider';
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var pathToTemp = a.fileProvider.path.tempOpen( 'tmp.tmp' );
//   var customTemplate = pathToTemp + '/Template.s';
//   var softlink = pathToTemp + '/softlink';
//   a.fileProvider.fileWrite( customTemplate, templateFile );
//   a.fileProvider.softLink( softlink, customTemplate );
//   a.fileProvider.softLink( pathToTemp + '/softlink2', softlink );
//   var writer = _.TemplateFileWriter
//   ({
//     srcTemplatePath : pathToTemp + '/softlink2',
//     dst : a.abs( '.' ),
//     dstProvider : a.fileProvider,
//     srcProvider : a.fileProvider,
//   });
//   writer.form();
//   a.fileProvider.filesDelete( pathToTemp );
//   var got = a.fileProvider.filesFindRecursive( { filePath : a.abs( '.' ), outputFormat : 'relative' } );
//   var expected = [ '.', './file' ];
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'srcTemplatePath is soft link, relative';
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var pathToTemp = a.fileProvider.path.tempOpen( 'tmp.tmp' );
//   var customTemplate = pathToTemp + '/Template.s';
//   var softlink = pathToTemp + '/softlink';
//   a.fileProvider.fileWrite( customTemplate, templateFile );
//   a.fileProvider.softLink( softlink, '../Template.s' );
//   a.fileProvider.softLink( pathToTemp + '/softlink2', softlink );
//   var writer = _.TemplateFileWriter
//   ({
//     srcTemplatePath : pathToTemp + '/softlink2',
//     dst : a.abs( '.' ),
//     dstProvider : a.fileProvider,
//     srcProvider : a.fileProvider,
//   });
//   writer.form();
//   a.fileProvider.filesDelete( pathToTemp );
//   var got = a.fileProvider.filesFindRecursive( { filePath : a.abs( '.' ), outputFormat : 'relative' } );
//   var expected = [ '.', './file' ];
//   test.identical( got, expected );
//
//   /* test, text links */
//
//   test.case = 'srcTemplatePath is text link, dst, dstProvider';
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var pathToTemp = a.fileProvider.path.tempOpen( 'tmp.tmp' );
//   var customTemplate = pathToTemp + '/Template.s';
//   var textlink = pathToTemp + '/textlink';
//   a.fileProvider.fileWrite( customTemplate, templateFile );
//   a.fileProvider.textLink( textlink, customTemplate );
//   a.fileProvider.fieldPush( 'usingTextLink', 1 );
//   var pathResolved = a.fileProvider.pathResolveTextLink( { filePath : textlink } );
//   var writer = _.TemplateFileWriter
//   ({
//     srcTemplatePath : pathResolved,
//     dst : a.abs( '.' ),
//     dstProvider : a.fileProvider,
//     srcProvider : a.fileProvider,
//   });
//   writer.form();
//   a.fileProvider.filesDelete( pathToTemp );
//   var got = a.fileProvider.filesFindRecursive( { filePath : a.abs( '.' ), outputFormat : 'relative' } );
//   var expected = [ '.', './file' ];
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'srcTemplatePath is double text link, dst, dstProvider';
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var pathToTemp = a.fileProvider.path.tempOpen( 'tmp.tmp' );
//   var customTemplate = pathToTemp + '/Template.s';
//   var textlink = pathToTemp + '/textlink';
//   a.fileProvider.fileWrite( customTemplate, templateFile );
//   a.fileProvider.textLink( textlink, customTemplate );
//   a.fileProvider.textLink( pathToTemp + '/textlink2', textlink );
//   a.fileProvider.fieldPush( 'usingTextLink', 1 );
//   var pathResolved = a.fileProvider.pathResolveTextLink( { filePath : pathToTemp + '/textlink2' } );
//   pathResolved = a.fileProvider.pathResolveTextLink( textlink );
//   var writer = _.TemplateFileWriter
//   ({
//     srcTemplatePath : pathResolved,
//     dst : a.abs( '.' ),
//     dstProvider : a.fileProvider,
//     srcProvider : a.fileProvider,
//   });
//   writer.form();
//   a.fileProvider.filesDelete( pathToTemp );
//   var got = a.fileProvider.filesFindRecursive( { filePath : a.abs( '.' ), outputFormat : 'relative' } );
//   var expected = [ '.', './file' ];
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'srcTemplatePath is text link, relative';
//   a.fileProvider.filesDelete( a.abs( '.' ) );
//   var pathToTemp = a.fileProvider.path.tempOpen( 'tmp.tmp' );
//   var customTemplate = pathToTemp + '/Template.s';
//   var textlink = pathToTemp + '/textlink';
//   a.fileProvider.fileWrite( customTemplate, templateFile );
//   a.fileProvider.textLink( { dstPath : textlink, srcPath : '../Template.s' } );
//   a.fileProvider.fieldPush( 'usingTextLink', 1 );
//   var pathResolved = a.fileProvider.pathResolveTextLink( { filePath : textlink } );
//   var writer = _.TemplateFileWriter
//   ({
//     srcTemplatePath : textlink + '/' + pathResolved,
//     dst : a.abs( '.' ),
//     dstProvider : a.fileProvider,
//     srcProvider : a.fileProvider,
//   });
//   writer.form();
//   a.fileProvider.filesDelete( pathToTemp );
//   var got = a.fileProvider.filesFindRecursive( { filePath : a.abs( '.' ), outputFormat : 'relative' } );
//   var expected = [ '.', './file' ];
//   test.identical( got, expected );
//
//   /* - */
//
//   if( !Config.debug )
//   return;
//
//   test.case = 'broken soft link';
//   test.shouldThrowErrorSync( function()
//   {
//     var write = _.templateFileWriter
//     ({
//       dstProvider : a.fileProvider,
//       srcProvider : a.fileProvider,
//       dst : a.abs( '.' ),
//       srcTemplatePath : a.fileProvider.softLink( pathToTemp, a.abs( '.' ) ),
//     });
//     write.form();
//   });
//
//   test.case = 'not allowed text links';
//   test.shouldThrowErrorSync( function()
//   {
//     var write = _.templateFileWriter
//     ({
//       dstProvider : a.fileProvider,
//       srcProvider : a.fileProvider,
//       dst : a.abs( '.' ),
//       srcTemplatePath : a.fileProvider.textLink( pathToTemp + '/link', a.abs( '.' ) + '/file2.s' ),
//     });
//     write.form();
//   });
// }
//
// // --
// // declare
// // --
//
// const Proto =
// {
//
//   name : 'Tools/mid/TemplateFileWriter/Abstract',
//   abstract : 1,
//   silencing : 1,
//   routineTimeOut : 20000,
//
//   onSuiteBegin,
//   onSuiteEnd,
//   onRoutineEnd,
//
//   context :
//   {
//     assetFor,
//     // provider : null,
//     // suiteTempPath : null,
//     providerMake : null,
//   },
//
//   tests :
//   {
//     templateFileWriter,
//     templateFileWriterLinks,
//   },
//
// };
//
// const Self = wTestSuite( Proto );
//
// })();
