// ( function _FilesFind_Extract_test_s_( )
// {
//
// 'use strict';
//
// if( typeof module !== 'undefined' )
// {
//   require( './aTemplateFileWriter.test.s' );
// }
//
// //
//
// const _ = _global_.wTools;
// const Parent = wTests[ 'Tools/mid/TemplateFileWriter/Abstract' ];
//
// _.assert( !!Parent );
//
// //
//
// function onSuiteBegin( test )
// {
//   let context = this;
//   Parent.onSuiteBegin.apply( this, arguments );
//   // context.provider = _.FileProvider.Extract({ usingExtraStat : 1, protocol : 'current' });
//   // let path = context.provider.path;
//   // context.suiteTempPath = path.tempOpen( 'suite-TemplateFileWriter' );
//   // context.suiteTempPath = context.provider.pathResolveLinkFull
//   // ({
//   //   filePath : context.suiteTempPath,
//   //   resolvingSoftLink : 1,
//   //   resolvingTextLink : 1,
//   // });
// }
//
// //
//
// function onSuiteEnd()
// {
//   let context = this;
//   // let path = this.provider.path;
//   return Parent.onSuiteEnd.apply( this, arguments );
// }
//
// //
//
// function providerMake()
// {
//   let context = this;
//   let provider = _.FileProvider.Extract({ protocols : [ 'current', 'second' ] });
//   return provider;
// }
//
// //--
// // tests
// //--
//
//
// // --
// // declare
// // --
//
// const Proto =
// {
//
//   name : 'Tools/mid/TemplateFileWriter/Extract',
//   silencing : 1,
//   abstract : 0,
//   enabled : 1,
//
//   onSuiteBegin,
//   onSuiteEnd,
//
//   context :
//   {
//     providerMake,
//   },
//
//   tests :
//   {
//   },
//
// }
//
// //
//
// const Self = wTestSuite( Proto ).inherit( Parent );
// if( typeof module !== 'undefined' && !module.parent )
// wTester.test( Self.name );
//
// })();
