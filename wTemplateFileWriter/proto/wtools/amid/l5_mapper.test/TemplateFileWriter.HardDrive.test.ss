// ( function _TemplateFileWriter_HardDrive_test_ss_( )
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
//   // context.provider = _.FileProvider.HardDrive({ protocol : 'current' });
//   // context.hub = _.FileProvider.System({ providers : [ context.provider ], defaultProvider : context.provider });
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
// function providerMake()
// {
//   let context = this;
//   let provider = _.FileProvider.HardDrive({ protocols : [ 'current', 'second' ] });
//   return provider;
// }
//
// // --
// // declare
// // --
//
// const Proto =
// {
//
//   name : 'Tools/mid/TemplateFileWriter/HardDrive',
//   abstract : 0,
//   silencing : 1,
//   enabled : 1,
//
//   onSuiteBegin,
//
//   context :
//   {
//     providerMake,
//     // suiteTempPath : null,
//     // hub : null
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
