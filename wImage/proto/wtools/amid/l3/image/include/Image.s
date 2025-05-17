( function _Image_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( './Basic.s' );
  require( './Reader.s' );
  require( './ReaderPngjs.s' );
  require( './ReaderPngDotJs.s' );
  require( './ReaderPngSharp.s' )
  require( './ReaderPngNodeLib.s' );
  require( './ReaderPngFast.s' );
  require( './ReaderBmpDashJs.s' );
  require( './ReaderJpegjs.s' );
  // require( './ReaderOmggif.s' );
  require( './ReaderUtifJs.s' );
  // require( './Writer.s' );

  module[ 'exports' ] = _global_.wTools;
}

})();
