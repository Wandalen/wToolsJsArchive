( function _Namespace_s_( )
{

'use strict';

const _ = _global_.wTools;
_.introspector = _.introspector || Object.create( null );

// --
// inter
// --

function thisFile()
{
  _.assert( arguments.length === 0, 'Expects no arguments' );
  let location = _.introspector.location({ level : 1 });
  let file = _.introspector.File({ filePath : location.filePath });
  return file;
}

//

function parserClassFor( filePath )
{
  let Parser;
  let ext = _.path.ext( filePath );

  Parser = _.introspector.extToDefaultParserMap[ ext ];
  if( Parser )
  return Parser;

  let parsers = _.introspector.extToAllParsersMap[ ext ];
  if( parsers && parsers.length )
  return parsers[ 0 ];

  return null;
}

// --
// declare
// --

let Extension =
{

  thisFile,
  parserClassFor,

  // fields

  extToDefaultParserMap : Object.create( null ),
  extToAllParsersMap : Object.create( null ),

}

/* _.props.extend */Object.assign( _.introspector, Extension );

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = _global_.wTools;

})();
