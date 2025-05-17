( function _FilesGraph_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( '../../../node_modules/Tools' );
  _.include( 'wTesting' );
  _.include( 'wFilesBasic' );
  _.include( 'wFilesArchive' );
}

//

const _ = _global_.wTools;
const Parent = wTester;

// --
//
// --

function trivial( test )
{

  /* - */

  test.case = 'universal, linkingAction : fileCopy, dstRewriting : 0';

  var expectedExtract = _.FileProvider.Extract
  ({
    usingExtraStat : 1,
    filesTree :
    {
      src :
      {
        same : 'same',
        diff : 'src/diff',
        srcDirDstTerm : { f2 : 'src/srcDirDstTerm/f2', f3 : 'src/srcDirDstTerm/f3' },
        srcTermDstDir : 'src/srcTermDstDir',
        srcTerm : 'srcTerm',
        srcDir : {},
      },
      dst :
      {
        same : 'same',
        diff : 'src/diff',
        srcDirDstTerm : { f2 : 'src/srcDirDstTerm/f2', f3 : 'src/srcDirDstTerm/f3' },
        srcTermDstDir : 'src/srcTermDstDir',
        // dstTerm : 'dstTerm',
        // dstDir : {},
        srcTerm : 'srcTerm',
        srcDir : {},
      }
    },
  });

  var extract = _.FileProvider.Extract
  ({
    usingExtraStat : 1,
    filesTree :
    {
      src :
      {
        same : 'same',
        diff : 'src/diff',
        srcDirDstTerm : { f2 : 'src/srcDirDstTerm/f2', f3 : 'src/srcDirDstTerm/f3' },
        srcTermDstDir : 'src/srcTermDstDir',
        srcTerm : 'srcTerm',
        srcDir : {},
      },
      dst :
      {
        same : 'same',
        diff : 'dst/diff',
        srcDirDstTerm : 'dst/srcDirDstTerm',
        srcTermDstDir : { f2 : 'src/srcDirDstTerm/f2', f3 : 'src/srcDirDstTerm/f3' },
        dstTerm : 'dstTerm',
        dstDir : {},
      }
    },
  });

  // extract.statsAdopt();

  var image = _.FileFilter.Image({ originalFileProvider : extract });
  var archive = new _.FilesGraphArchive({ imageFileProvider : image });

  test.true( image.proxyImage === image );
  test.true( image.archive === archive );

  archive.timelapseBegin();

  image.filesDelete( '/dst' );

  var records = image.filesReflect
  ({
    reflectMap : { '/src' : '/dst' },
    dstRewriting : 0,
    dstRewritingByDistinct : 0,
    linkingAction : 'fileCopy',
  });

  archive.timelapseEnd();

  var expAbsolutes = [ '/dst', '/dst/diff', '/dst/same', '/dst/srcTerm', '/dst/srcTermDstDir', '/dst/srcDir', '/dst/srcDirDstTerm', '/dst/srcDirDstTerm/f2', '/dst/srcDirDstTerm/f3' ];
  var expActions = [ 'dirMake', 'fileCopy', 'fileCopy', 'fileCopy', 'fileCopy', 'dirMake', 'dirMake', 'fileCopy', 'fileCopy' ];
  var expPreserve = [ false, false, false, false, false, false, false, false, false ];

  var gotAbsolutes = _.select( records, '*/dst/absolute' );
  var gotActions = _.select( records, '*/action' );
  var gotPreserve = _.select( records, '*/preserve' );

  test.identical( extract.filesTree, expectedExtract.filesTree );
  test.identical( gotAbsolutes, expAbsolutes );
  test.identical( gotActions, expActions );
  test.identical( gotPreserve, expPreserve );

  /* - */

  test.case = 'universal, linkingAction : fileCopy, dstRewriting : 1';

  var expectedExtract = _.FileProvider.Extract
  ({
    usingExtraStat : 1,
    filesTree :
    {
      src :
      {
        same : 'same',
        diff : 'src/diff',
        srcDirDstTerm : { f2 : 'src/srcDirDstTerm/f2', f3 : 'src/srcDirDstTerm/f3' },
        srcTermDstDir : 'src/srcTermDstDir',
        srcTerm : 'srcTerm',
        srcDir : {},
      },
      dst :
      {
        same : 'same',
        diff : 'src/diff',
        srcDirDstTerm : { f2 : 'src/srcDirDstTerm/f2', f3 : 'src/srcDirDstTerm/f3' },
        srcTermDstDir : 'src/srcTermDstDir',
        // dstTerm : 'dstTerm',
        // dstDir : {},
        srcTerm : 'srcTerm',
        srcDir : {},
      }
    },
  });

  var extract = _.FileProvider.Extract
  ({
    usingExtraStat : 1,
    filesTree :
    {
      src :
      {
        same : 'same',
        diff : 'src/diff',
        srcDirDstTerm : { f2 : 'src/srcDirDstTerm/f2', f3 : 'src/srcDirDstTerm/f3' },
        srcTermDstDir : 'src/srcTermDstDir',
        srcTerm : 'srcTerm',
        srcDir : {},
      },
      dst :
      {
        same : 'same',
        diff : 'dst/diff',
        srcDirDstTerm : 'dst/srcDirDstTerm',
        srcTermDstDir : { f2 : 'src/srcDirDstTerm/f2', f3 : 'src/srcDirDstTerm/f3' },
        dstTerm : 'dstTerm',
        dstDir : {},
      }
    },
  });

  var image = _.FileFilter.Image({ originalFileProvider : extract });
  var archive = new _.FilesGraphArchive({ imageFileProvider : image });

  archive.timelapseBegin();

  image.filesDelete( '/dst' );

  var records = image.filesReflect
  ({
    reflectMap : { '/src' : '/dst' },
    dstRewriting : 1,
    linkingAction : 'fileCopy',
  });

  archive.timelapseEnd();

  var expAbsolutes = [ '/dst', '/dst/diff', '/dst/same', '/dst/srcTerm', '/dst/srcTermDstDir', '/dst/srcDir', '/dst/srcDirDstTerm', '/dst/srcDirDstTerm/f2', '/dst/srcDirDstTerm/f3' ];
  var expActions = [ 'dirMake', 'fileCopy', 'fileCopy', 'fileCopy', 'fileCopy', 'dirMake', 'dirMake', 'fileCopy', 'fileCopy' ];
  var expPreserve = [ false, false, false, false, false, false, false, false, false ];

  var gotAbsolutes = _.select( records, '*/dst/absolute' );
  var gotActions = _.select( records, '*/action' );
  var gotPreserve = _.select( records, '*/preserve' );

  test.identical( extract.filesTree, expectedExtract.filesTree );
  test.identical( gotAbsolutes, expAbsolutes );
  test.identical( gotActions, expActions );
  test.identical( gotPreserve, expPreserve );

  /* - */

  test.case = 'universal, linkingAction : hardLink, dstRewriting : 1';

  var expectedExtract = _.FileProvider.Extract
  ({
    usingExtraStat : 1,
    filesTree :
    {
      src :
      {
        same : [ { hardLinks : [ '/dst/same', '/src/same' ], data : 'same' } ],
        diff : [ { hardLinks : [ '/dst/diff', '/src/diff' ], data : 'src/diff' } ],
        srcDirDstTerm : { f2 : [ { hardLinks : [ '/dst/srcDirDstTerm/f2', '/src/srcDirDstTerm/f2' ], data : 'src/srcDirDstTerm/f2' } ], f3 : [ { hardLinks : [ '/dst/srcDirDstTerm/f3', '/src/srcDirDstTerm/f3' ], data : 'src/srcDirDstTerm/f3' } ] },
        srcTermDstDir : [ { hardLinks : [ '/dst/srcTermDstDir', '/src/srcTermDstDir' ], data : 'src/srcTermDstDir' } ],
        srcTerm : [ { hardLinks : [ '/dst/srcTerm', '/src/srcTerm' ], data : 'srcTerm' } ],
        srcDir : {},
      },
      dst :
      {
        same : [ { hardLinks : [ '/dst/same', '/src/same' ], data : 'same' } ],
        diff : [ { hardLinks : [ '/dst/diff', '/src/diff' ], data : 'src/diff' } ],
        srcDirDstTerm : { f2 : [ { hardLinks : [ '/dst/srcDirDstTerm/f2', '/src/srcDirDstTerm/f2' ], data : 'src/srcDirDstTerm/f2' } ], f3 : [ { hardLinks : [ '/dst/srcDirDstTerm/f3', '/src/srcDirDstTerm/f3' ], data : 'src/srcDirDstTerm/f3' } ] },
        srcTermDstDir : [ { hardLinks : [ '/dst/srcTermDstDir', '/src/srcTermDstDir' ], data : 'src/srcTermDstDir' } ],
        srcTerm : [ { hardLinks : [ '/dst/srcTerm', '/src/srcTerm' ], data : 'srcTerm' } ],
        srcDir : {},
      }
    },
  });

  var extract = _.FileProvider.Extract
  ({
    usingExtraStat : 1,
    filesTree :
    {
      src :
      {
        same : 'same',
        diff : 'src/diff',
        srcDirDstTerm : { f2 : 'src/srcDirDstTerm/f2', f3 : 'src/srcDirDstTerm/f3' },
        srcTermDstDir : 'src/srcTermDstDir',
        srcTerm : 'srcTerm',
        srcDir : {},
      },
      dst :
      {
        same : 'same',
        diff : 'dst/diff',
        srcDirDstTerm : 'dst/srcDirDstTerm',
        srcTermDstDir : { f2 : 'src/srcDirDstTerm/f2', f3 : 'src/srcDirDstTerm/f3' },
        dstTerm : 'dstTerm',
        dstDir : {},
      }
    },
  });

  var image = _.FileFilter.Image({ originalFileProvider : extract });
  var archive = new _.FilesGraphArchive({ imageFileProvider : image });

  archive.timelapseBegin();

  image.filesDelete( '/dst' );

  var records = image.filesReflect
  ({
    reflectMap : { '/src' : '/dst' },
    dstRewriting : 1,
    linkingAction : 'hardLink',
  });

  archive.timelapseEnd();

  var expAbsolutes = [ '/dst', '/dst/diff', '/dst/same', '/dst/srcTerm', '/dst/srcTermDstDir', '/dst/srcDir', '/dst/srcDirDstTerm', '/dst/srcDirDstTerm/f2', '/dst/srcDirDstTerm/f3' ];
  var expActions = [ 'dirMake', 'hardLink', 'hardLink', 'hardLink', 'hardLink', 'dirMake', 'dirMake', 'hardLink', 'hardLink' ];
  var expPreserve = [ false, false, false, false, false, false, false, false, false ];

  var gotAbsolutes = _.select( records, '*/dst/absolute' );
  var gotActions = _.select( records, '*/action' );
  var gotPreserve = _.select( records, '*/preserve' );

  test.identical( extract.filesTree, expectedExtract.filesTree );
  test.identical( gotAbsolutes, expAbsolutes );
  test.identical( gotActions, expActions );
  test.identical( gotPreserve, expPreserve );

  /* - */

}

// --
// declare
// --

const Proto =
{

  name : 'Tools.files.Graph',
  silencing : 1,
  enabled : 0,
  routineTimeOut : 15000,

  context :
  {
  },

  tests :
  {

    trivial,

  },

};

const Self = wTestSuite( Proto )
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )();
