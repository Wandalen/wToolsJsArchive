var read = function( o )
{
  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o ) || _.objectIs( o ) );

  var self = this;

  if( _.strIs( o ) )
  {
    o = { file : o };
  }

  _.routineOptions( read, o );

  self._tree = _.filesTreeRead( o );

  // logger.log( 'tree :\n' + _.toStr( self._tree,{ levels : 3 } ) );
  debugger;

}

read.defaults =
{
  file : null,
}

//

var write = function( o )
{
  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o ) || _.objectIs( o ) );

  var self = this;

  if( _.strIs( o ) )
  {
    o = { file : o };
  }

  _.routineOptions( write, o );

  var data = _.toStr( self._tree,{ json : 1 } );
  File.writeFileSync( o.file , data );

  debugger;

}

write.defaults =
{
  file : null,
}
