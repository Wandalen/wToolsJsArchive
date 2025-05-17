( function _Mid_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( './Base.s' );

  require( '../l1/Namespace.s' );

  require( '../l3/File.s' );
  require( '../l3/NodeDescriptor.s' );
  require( '../l3/Parser.s' );
  require( '../l3/Path.s' );
  require( '../l3/Structure.s' );
  require( '../l3/Sys.s' );

  require( '../l5_parser/CppTreeSitter.s' );
  require( '../l5_parser/JsAcorn.s' );
  require( '../l5_parser/JsBabel.s' );
  require( '../l5_parser/JsEsprima.s' );
  require( '../l5_parser/JsTreeSitter.s' );
  require( '../l5_parser/JsUglify.s' );
  require( '../l5_parser/TsMicrosoft.s' );

}

if( typeof module !== 'undefined' )
module[ 'exports' ] = _global_.wTools;

})();
