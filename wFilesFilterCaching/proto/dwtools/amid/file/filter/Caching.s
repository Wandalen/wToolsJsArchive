( function _Caching_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }
  var _global = _global_;
  var _ = _global_.wTools;

  if( !_global_.wTools.FileProvider )
  _.include( 'wFiles' );

}

var _global = _global_;
var _global = _global_;
var _ = _global_.wTools;
_.assert( !_.FileFilter.Caching );

// _.FileFilter = _.FileFilter || Object.create( null );
// if( _.FileFilter.Caching )
// return;

//
var _global = _global_;
var _ = _global_.wTools;
var Abstract = _.FileProvider.Abstract;
var Partial = _.FileProvider.Partial;
var Default = _.FileProvider.Default;
var Parent = null;
var Self = function wFileFilterCaching( o )
{
  if( !( this instanceof Self ) )
  return Self.prototype.init.apply( this,arguments );
  throw _.err( 'Call wFileFilterCaching without new please' );
}

Self.shortName = 'Caching';

//

function init( o )
{

  var self = _.instanceFilterInit
  ({
    cls : Self,
    parent : Parent,
    extend : Extend,
    args : arguments,
  });

  if( self.watchPath )
  self._createFileWatcher();

  _.assert( _.objectIs( self.original ) );

  // x
  //
  // var self = Object.create( null );
  //
  // _.instanceInit( self,Self.prototype );
  //
  // if( o )
  // Self.prototype.copyCustom.call( self,
  // {
  //   proto : Self.prototype,
  //   src : o,
  //   technique : 'object',
  // });
  //
  // if( !self.original )
  // self.original = _.FileProvider.Default();
  //
  // _.mapExtend( self,Extend );
  //
  // Object.setPrototypeOf( self,self.original );
  // Object.preventExtensions( self );

  return self;
}

//

function fileStatAct( o )
{
  var self = this;

  if( _.strIs( o ) )
  o = { filePath : o };

  if( !self.cachingStats )
  {
    // o.filePath = self.pathNativize( o.filePath );
    return self.original.fileStatAct( o );
  }

  // var original = self.original.fileStatAct;

  // var o = _.files._fileOptionsGet.apply( original,arguments );
  // var filePath = o;

  // debugger;

  function handleEnd( stat )
  {
    if( o.sync || o.sync === undefined )
    return stat;
    else
    return new _.Consequence().give( stat );
  }

  if( self._cacheStats[ o.filePath ] !== undefined )
  {
    return handleEnd( self._cacheStats[ o.filePath ] );
  }
  else
  {
    var filePath = self.path.resolve( o.filePath );
    if( self._cacheStats[ filePath ] !== undefined )
    {
      return handleEnd( self._cacheStats[ filePath ] );
    }

    // if( _.strIs( o ) )
    // {
    //   o = self.path.resolve( o );
    //   if( self._cacheStats[ o ] !== undefined )
    //   return  self._cacheStats[ o ];
    // }
    // else
    // if( _.objectIs( o ) )
    // {
    //   o = _.routineOptions( fileStatAct,o )
    //   o = self.path.resolve( o );
    //   if( o.sync === undefined )
    //   o.sync = 1;
    //
    //   o.filePath = self.path.resolve( o.filePath );
    //   if( self._cacheStats[ filePath ] )
    //   {
    //     if( o.sync )
    //     return self._cacheStats[ filePath ];
    //     else
    //     return _.Consequence().give( self._cacheStats[ filePath ] );
    //   }
    // }

    // console.log( 'fileStatAct' );

    // o.filePath = self.pathNativize( o.filePath );
    var stat = self.original.fileStatAct( o );
    // o.filePath = self.path.resolve( o.filePath );


    // console.log( o );

    if( o.sync )
    self._cacheStats[ filePath ] = stat;
    else
    stat.got( function( err, got )
    {
      self._cacheStats[ filePath ] = got;
      stat.give( err, got );
    });

    // if( _.strIs( o ) )
    // self._cacheStats[ o ] = stat;
    // else
    // {
    //   if( o.sync )
    //   self._cacheStats[ filePath ] = stat;
    //   else
    //   stat.got( function( err, got )
    //   {
    //     self._cacheStats[ filePath ] = got;
    //     stat.give( err, got );
    //   });
    // }

    // console.log( 'self._cache',self._cache );

    return stat;

    // if( o.sync )
    // {
    //   self._cache[ filePath ] = stat;
    //   return stat;
    // }
    // else
    // {
    //   return stat.doThen( function( err, got )
    //   {
    //     if( err )
    //     throw err;
    //     self._cache[ filePath ] = got;
    //     return got;
    //   })
    // }
  }
}

fileStatAct.defaults = {};
fileStatAct.defaults.__proto__ = Partial.prototype.fileStatAct.defaults;

//

function directoryReadAct( o )
{
  var self = this;


  if( _.strIs( o ) )
  o = { filePath : o };

  if( !self.cachingDirs )
  {
    // o.filePath = self.pathNativize( o.filePath );
    return self.original.directoryReadAct( o );
  }

  // var original = self.original.directoryReadAct;

  // var o = _.files._fileOptionsGet.apply( original,arguments );
  // var filePath = o;

  // debugger;

  function handleEnd( files )
  {
    if( o.sync || o.sync === undefined )
    return files;
    else
    return new _.Consequence().give( files );
  }

  if( self._cacheDir[ o.filePath ] !== undefined )
  {
    return handleEnd( self._cacheDir[ o.filePath ] );
  }
  else
  {
    var filePath = self.path.resolve( o.filePath );
    if( self._cacheDir[ filePath ] !== undefined )
    return handleEnd( self._cacheDir[ filePath ] );


    // if( _.strIs( o ) )
    // {
    //   o = self.path.resolve( o );
    //   if( self._cacheDir[ o ] !== undefined )
    //   return  self._cacheDir[ o ];
    // }
    // else if( _.objectIs( o ) )
    // {
    //   o = _.routineOptions( directoryReadAct,o )
    //   // o = self.path.resolve( o );
    //   o.filePath = self.path.resolve( o.filePath );
    //   if( self._cacheDir[ o.filePath ] )
    //   {
    //     if( o.sync )
    //     return self._cacheDir[ o.filePath ];
    //     else
    //     return _.Consequence().give( self._cacheDir[ o.filePath ] );
    //   }
    // }

    // console.log( 'directoryReadAct' );
    // o.filePath = self.pathNativize( o.filePath );
    var files = self.original.directoryReadAct.call( self, o );
    // o.filePath = self.path.resolve( o.filePath );

    // console.log( o );

    if( o.sync )
    self._cacheDir[ filePath ] = files;
    else
    files.doThen( function( err, got )
    {
      self._cacheDir[ filePath ] = got;
      if( err )
      throw err;
      return got;
    });

    // if( _.strIs( o ) )
    // self._cacheDir[ o ] = files;
    // else
    // {
    //   if( o.sync )
    //   self._cacheDir[ o.filePath ] = files;
    //   else
    //   files.doThen( function( err, got )
    //   {
    //     self._cacheDir[ o.filePath ] = got;
    //     if( err )
    //     throw err;
    //     return got;
    //   });
    // }

    // console.log( 'self._cache',self._cache );

    return files;

    // if( o.sync )
    // {
    //   self._cache[ filePath ] = stat;
    //   return stat;
    // }
    // else
    // {
    //   return stat.doThen( function( err, got )
    //   {
    //     if( err )
    //     throw err;
    //     self._cache[ filePath ] = got;
    //     return got;
    //   })
    // }
  }
}

directoryReadAct.defaults = {};
directoryReadAct.defaults.__proto__ = Partial.prototype.directoryReadAct.defaults;

//

function fileRecord( filePath, o )
{
  var self = this;
  debugger;

  xxx

  if( o === undefined )
  o = Object.create( null );

  if( !self.cachingRecord )
  return self.original.fileRecord( filePath, _.mapOnly( o, _.FileRecord.fieldsOfCopyableGroups ) );

  if( self._cacheRecord[ filePath ] !== undefined )
  {
    var records = self._cacheRecord[ filePath ];
    for( var i = 0; i < records.length; i += 2 )
    {
      if( _.mapIdentical( records[ i ], o ) )
      return records[ i + 1 ];
    }
  }

  var options = _.mapOnly( o, _.FileRecord.fieldsOfCopyableGroups );
  var record = self.original.fileRecord( filePath, options );
  if( !self._cacheRecord[ record.absolute ] )
  self._cacheRecord[ record.absolute ] = [];
  self._cacheRecord[ record.absolute ].push( o, record );

  return record;
}

fileRecord.defaults = {};
fileRecord.defaults.__proto__ = Partial.prototype.fileRecord.defaults;

//

function _dirUpdate( filePath )
{
  var self = this;

  if( !self.cachingDirs )
  return;

  filePath = self.path.resolve( filePath );

  if( self._cacheDir[ filePath ] !== undefined )
  self._cacheDir[ filePath ] = self.original.directoryRead( filePath );

  var dirPath = self.path.dir( filePath );
  var fileName = self.path.name({ path : filePath, withExtension : 1 });

  var dir = self._cacheDir[ dirPath ];

  if( dir === null )
  self._cacheDir[ dirPath ] = self.original.directoryRead( dirPath );

  if( dir )
  {
    if( dir.indexOf( fileName ) === -1 )
    dir.push( fileName );
  }
}

//

function _recordUpdate( path )
{
  var self = this;

  function _update( filePath )
  {
    if( self._cacheRecord[ filePath ] !== undefined )
    {
      for( var i = 1; i <= self._cacheRecord[ filePath ].length; i += 2 )
      {
        var o = self._cacheRecord[ filePath ][ i - 1 ];
        self._cacheRecord[ filePath ][ i ] = self.original.fileRecord( filePath, o );
      }
    }
  }

  if( self.cachingRecord )
  {
    var filePath = self.path.resolve( path );
    var dirPath = self.path.dir( filePath );

    _update( filePath );
    _update( dirPath );
  }

}

//

function _statUpdate( path,stat )
{
  var self = this;

  var filePath = self.path.resolve( path );
  if( self.cachingStats )
  {
    if( self._cacheStats[ filePath ] !== undefined )
    {
      if( stat === undefined )
      stat = self.original.fileStat( path );
      self._cacheStats[ filePath ] = stat;
    }

    var dir = self.path.dir( filePath );

    if( self._cacheStats[ dir ] !== undefined )
    self._cacheStats[ dir ] = self.original.fileStat( dir );
  }
}

//

function _removeFromCache( path )
{
  var self = this;

  var filePath = self.path.resolve( path );

  function _removeChilds( cache )
  {
    var files = Object.keys( cache );
    for( var i = 0; i < files.length; i++  )
    if( self.path.dir( files[ i ] ) === filePath )
    cache[ files[ i ] ] = null;
    // delete cache[ files[ i ] ];
  }

  if( self.cachingStats )
  {
    if( self._cacheStats[ filePath ] !== undefined )
    {
      var stat = self._cacheStats[ filePath ];
      if( _.objectIs( stat ) && stat.isDirectory() || stat === null )
      {
        var files = Object.keys( self._cacheStats );
        for( var i = 0; i < files.length; i++  )
        if( _.strBegins( files[ i ], filePath ) )
        self._cacheStats[ files[ i ] ] = null;
      }
      else
      self._cacheStats[ filePath ] = null;
    }
  }

  if( self.cachingRecord )
  {
    var files = Object.keys( self._cacheRecord );
    for( var i = 0; i < files.length; i++  )
    {
      if( _.strBegins( files[ i ], filePath ) )
      for( var j = 1; j <= self._cacheRecord[ files[ i ] ].length; j += 2 )
      self._cacheRecord[ files[ i ] ][ j ] = null;
    }

  }

  if( self.cachingDirs )
  {
    _removeChilds( self._cacheDir );

    if( self._cacheDir[ filePath ] )
    {
      self._cacheDir[ filePath ] = null;
      // delete self._cacheDir[ filePath ];
    }

    var dir = self.path.dir( filePath );
    var fileName = self.path.name({ path : filePath, withExtension : 1 });
    var dir = self._cacheDir[ dir ];
    if( dir )
    {
      var index = dir.indexOf( fileName );
      if( index >= 0  )
      dir.splice( index, 1 );
    }
  }

}

//

function _createFileWatcher()
{
  var self = this;

  if( !self.fileWatcher )
  {
    var chokidar = require('chokidar');

    self.watchOptions.ignoreInitial = true;
    self.watchOptions.alwaysStat = true;
    self.watchOptions.usePolling = true;
    // self.watchOptions.awaitWriteFinish =
    // {
    //   stabilityThreshold: 2000,
    //   pollInterval: 100
    // };

    self.fileWatcher = chokidar.watch( self.watchPath,self.watchOptions );

    self.fileWatcher.onReady = new _.Consequence();
    self.fileWatcher.onUpdate = new _.Consequence();

    if( !self.watchOptions.skipReadyEvent )
    self.fileWatcher.on( 'ready', function( path )
    {
      self.fileWatcher.onReady.give( 'ready' );
    });

    self.fileWatcher.on( 'raw', function( event, path, details )
    {
      var info =
      {
        event : event,
        path : path,
        details : details
      };

      // console.log( 'raw:', _.toStr( info, { levels : 99 } ) )
    })

    self.fileWatcher.on( 'all', function( event, path, details )
    {
      // debugger
      var info =
      {
        event : event,
        path : path,
        details : details
      };

      // console.log( _.toStr( info, { levels : 99 } ) )

      if( event === 'add' || event === 'addDir' )
      {
          self._statUpdate( path );
          self._dirUpdate( path );
          self._recordUpdate( path );
          self.fileWatcher.onUpdate.give( info );
      }

      if( event === 'change' )
      {
        self._statUpdate( path );
        self._recordUpdate( path );
        self.fileWatcher.onUpdate.give( info );
      }

      if( event === 'unlink' || event === 'unlinkDir' )
      {
        self._removeFromCache( path );
        self.fileWatcher.onUpdate.give( info );
      }
    });
  }
}

//

function fileReadAct( o )
{
  var self = this;
  var result;

  if( o.sync )
  {
    try
    {
      result = self.original.fileReadAct( o );
    }
    catch( err )
    {
      throw err;
    }
    finally
    {
      if( self.updateOnRead )
      {
        self._statUpdate( o.filePath );
        self._recordUpdate( o.filePath );
      }

    }
  }

  if( !o.sync )
  {
    var result = self.original.fileReadAct( o );
    if( !self.updateOnRead )
    return result;

    result.doThen( function( err, got )
    {
      self._statUpdate( o.filePath );
      self._recordUpdate( o.filePath );
      if( err )
      return err;
      return got;
    });
  }

  return result;
}

fileReadAct.defaults = {};
fileReadAct.defaults.__proto__ = Partial.prototype.fileReadAct.defaults;

//

function fileHashAct( o )
{
  var self = this;

  var result = self.original.fileHashAct( o );

  if( !self.updateOnRead )
  return result;

  if( !o.sync )
  {
    return result
    .ifNoErrorThen( function( got )
    {
      if( !_.isNaN( got ) )
      if( self.updateOnRead )
      {
        self._statUpdate( o.filePath );
        self._recordUpdate( o.filePath );
      }

      return got;
    });
  }
  else
  {
    if( !_.isNaN( result ) )
    if( self.updateOnRead )
    {
      self._statUpdate( o.filePath );
      self._recordUpdate( o.filePath );
    }
  }


  return result;
}

fileHashAct.defaults = {};
fileHashAct.defaults.__proto__ = Partial.prototype.fileHashAct.defaults;

//

function fileWriteAct( o )
{
  var self = this;

  if( arguments.length === 2 )
  {
    o = { filePath : arguments[ 0 ], data : arguments[ 1 ] };
  }

  var result = self.original.fileWriteAct( o );

  if( !o.sync )
  {
    return result
    .ifNoErrorThen( function()
    {
      self._recordUpdate( o.filePath );
      self._statUpdate( o.filePath );
      self._dirUpdate( o.filePath );
    });
  }
  else
  {
    self._recordUpdate( o.filePath );
    self._statUpdate( o.filePath );
    self._dirUpdate( o.filePath );
  }

  return result;
}

fileWriteAct.defaults = {};
fileWriteAct.defaults.__proto__ = Partial.prototype.fileWriteAct.defaults;

//

function fileTimeSetAct( o )
{
  var self = this;

  if( arguments.length === 3 )
  o =
  {
    filePath : arguments[ 0 ],
    atime : arguments[ 1 ],
    mtime : arguments[ 2 ],
  }

  var result = self.original.fileTimeSetAct( o );

  var filePath = self.path.resolve( o.filePath );

  if( self.cachingStats )
  {
    if( self._cacheStats[ filePath ] )
    {
      self._cacheStats[ filePath ].atime = o.atime;
      self._cacheStats[ filePath ].mtime = o.mtime;
    }
  }

  if( self.cachingRecord )
  {
    var record = self._cacheRecord[ filePath ];
    if( record )
    {
      for( var i = 1; i <= record.length; i += 2 )
      if( record[ i ].stat )
      {
        record[ i ].stat.atime = o.atime;
        record[ i ].stat.mtime = o.mtime;
      }

    }
  }

  return result;
}

fileTimeSetAct.defaults = {};
fileTimeSetAct.defaults.__proto__ = Partial.prototype.fileTimeSetAct.defaults;

//

function fileDelete( o )
{
  var self = this;

  if( _.strIs( o ) )
  o = { filePath : o };

  var result = self.original.fileDelete( o );

  if( !o.sync )
  {
    return result
    .ifNoErrorThen( function()
    {
      self._removeFromCache( o.filePath );
    });
  }
  else
  {
    self._removeFromCache( o.filePath );
  }
  return result;
}

fileDelete.defaults = {};
fileDelete.defaults.__proto__ = Partial.prototype.fileDelete.defaults;

//

function directoryMake( o )
{
  var self = this;

  if( _.strIs( o ) )
  o = { filePath : o };

  var result = self.original.directoryMake.call( self, o );

  if( !o.sync )
  {
    return result
    .ifNoErrorThen( function()
    {
      self._statUpdate( o.filePath );
      self._dirUpdate( o.filePath );
      self._recordUpdate( o.filePath );
    });
  }
  else
  {
    self._statUpdate( o.filePath );
    self._dirUpdate( o.filePath );
    self._recordUpdate( o.filePath );
  }

  return result;
}

directoryMake.defaults = {};
directoryMake.defaults.__proto__ = Partial.prototype.directoryMake.defaults;

//

function fileRenameAct( o )
{
  var self = this;

  if( arguments.length === 2 )
  o =
  {
    dstPath : arguments[ 0 ],
    srcPath : arguments[ 1 ],
  }

  var result = self.original.fileRenameAct( o );

  //

  function _rename( o )
  {
    if( o.dstPath === o.srcPath )
    return;

    var srcPath = self.path.resolve( o.srcPath );
    var dstPath = self.path.resolve( o.dstPath );

    if( self.cachingStats )
    if( self._cacheStats[ srcPath ] )
    {
      if( self._cacheStats[ srcPath ].isDirectory() )
      {
        var files = Object.keys( self._cacheStats );
        for( var i = 0; i < files.length; i++  )
        if( _.strBegins( files[ i ], srcPath ) )
        {
          delete self._cacheStats[ files[ i ] ];
        }
      }
      else
      {
        self._cacheStats[ srcPath ] = null;
      }
      self._cacheStats[ dstPath ] = self.original.fileStat( dstPath );
    }

    if( self.cachingDirs )
    {
      var srcPath = self.path.resolve( o.srcPath );
      self._removeFromCache( o.srcPath );
      if( self._cacheDir[ self.path.resolve( o.srcPath ) ] !== undefined )
      self._cacheDir[ self.path.resolve( o.dstPath ) ] = null;
      self._dirUpdate( o.dstPath );
      // var oldName = self.path.name({ path : srcPath, withExtension : 1 });
      // if( self._cacheDir[ srcPath ] )
      // if( self._cacheDir[ srcPath ][ 0 ]  === oldName )
      // {
      //   var newName = self.path.name({ path : dstPath, withExtension : 1 });
      //   self._cacheDir[ srcPath ][ 0 ] = newName;
      // }
      //
      // var dir = self.path.dir( srcPath );
      // var dir = self._cacheDir[ dir ];
      // if( dir )
      // {
      //   var index = dir.indexOf( oldName );
      //   if( index >= 0  )
      //   dir.splice( index, 1 );
      //   var fileName = self.path.name({ path : dstPath, withExtension : 1 });
      //   dir.push( fileName );
      // }
      //
      // var files = Object.keys( self._cacheDir );
      // for( var i = 0; i < files.length; i++ )
      // {
      //   if( _.strBegins( files[ i ], srcPath ) )
      //   {
      //     var newPath = _.strReplaceAll( files[ i ], srcPath, dstPath );
      //     self._cacheDir[ newPath ] = self._cacheDir[ files[ i ] ];
      //     delete self._cacheDir[ files[ i ] ];
      //   }
      // }

    }
    if( self.cachingRecord )
    {
      var files = Object.keys( self._cacheRecord );
      for( var i = 0; i < files.length; i++  )
      {
        if( _.strBegins( files[ i ], srcPath ) || _.strBegins( files[ i ], dstPath ) )
        for( var j = 1; j <= self._cacheRecord[ files[ i ] ].length; j += 2 )
        self._cacheRecord[ files[ i ] ][ j ] = null;
      }
      // if( self._cacheRecord[ srcPath ] )
      // {
        // var files = Object.keys( self._cacheRecord );
        // for( var i = 0; i < files.length; i++  )
        // if( _.strBegins( files[ i ], srcPath ) )
        // delete self._cacheRecord[ files[ i ] ];
      // }
      // if( self._cacheRecord[ dstPath ] )
      // {
        // var files = Object.keys( self._cacheRecord );
        // for( var i = 0; i < files.length; i++  )
        // if( _.strBegins( files[ i ], dstPath ) )
        // delete self._cacheRecord[ files[ i ] ];
      // }
      //
      // if( self._cacheRecord[ dstPath ] )
      // for( var i = 0; i < self._cacheRecord[ dstPath ].length; i += 2 )
      // {
      //   var o = self._cacheRecord[ dstPath ][ i ];
      //   self._cacheRecord[ dstPath ][ i + 1 ] = _.FileRecord( dstPath, o );
      // }
    }
  }

  //

  if( !o.sync )
  {
    return result
    .ifNoErrorThen( function()
    {
      _rename( o );
    });
  }
  else
  {
    _rename( o );
  }

  return result;
}

fileRenameAct.defaults = {};
fileRenameAct.defaults.__proto__ = Partial.prototype.fileRenameAct.defaults;

//

function fileCopyAct( o )
{
  var self = this;

  if( arguments.length === 2 )
  o =
  {
    dstPath : arguments[ 0 ],
    srcPath : arguments[ 1 ],
  }

  var result = self.original.fileCopyAct( o );

  function _copy()
  {
    if( o.dstPath === o.srcPath )
    return;

    if( self.updateOnRead )
    self._statUpdate( o.srcPath );

    self._statUpdate( o.dstPath );

    if( self.cachingDirs )
    self._dirUpdate( o.dstPath );

    if( self.cachingRecord )
    {
      if( self.updateOnRead )
      {
        self._recordUpdate( o.srcPath );
      }

      var dstPath = self.path.resolve( o.dstPath );
      if( self._cacheRecord[ dstPath ] )
      delete self._cacheRecord[ dstPath ];

    }
  }

  if( !o.sync )
  {
    return result
    .ifNoErrorThen( function()
    {
      _copy();
    });
  }
  else
  _copy();

  return result;
}

fileCopyAct.defaults = {};
fileCopyAct.defaults.__proto__ = Partial.prototype.fileCopyAct.defaults;

//

function linkSoftAct( o )
{
  var self = this;

  if( arguments.length === 2 )
  o =
  {
    dstPath : arguments[ 0 ],
    srcPath : arguments[ 1 ],
  }

  var result = self.original.linkSoftAct( o );

  function _link()
  {
    if( o.dstPath === o.srcPath )
    return;

    if( self.updateOnRead )
    self._statUpdate( o.srcPath );

    self._statUpdate( o.dstPath );

    if( self.cachingDirs )
    self._dirUpdate( o.dstPath );
  }

  if( !o.sync )
  {
    return result
    .ifNoErrorThen( function()
    {
      _link();
    });
  }
  else
  _link();

  return result;
}

linkSoftAct.defaults = {};
linkSoftAct.defaults.__proto__ = Partial.prototype.linkSoftAct.defaults;

//

function linkHardAct( o )
{
  var self = this;

  if( arguments.length === 2 )
  o =
  {
    dstPath : arguments[ 0 ],
    srcPath : arguments[ 1 ],
  }

  var result = self.original.linkHardAct( o );

  function _link()
  {
    if( o.dstPath === o.srcPath )
    return;

    if( self.updateOnRead )
    self._statUpdate( o.srcPath );

    self._statUpdate( o.dstPath );

    if( self.cachingDirs )
    self._dirUpdate( o.dstPath );
  }

  if( !o.sync )
  {
    return result
    .ifNoErrorThen( function()
    {
      _link();
    });
  }
  else
  _link();

  return result;
}

linkHardAct.defaults = {};
linkHardAct.defaults.__proto__ = Partial.prototype.linkHardAct.defaults;

//

function fileExchange( o )
{
  var self = this;

  if( arguments.length === 2 )
  o =
  {
    dstPath : arguments[ 0 ],
    srcPath : arguments[ 1 ],
  }

  if( !self.cachingStats && !self.cachingRecord && !self.cachingDirs )
  return self.original.fileExchange( o );

  var srcPath = o.srcPath;
  var dstPath = o.dstPath;

  var src = self.original.fileStat( o.srcPath );
  var dst = self.original.fileStat( o.dstPath );

  var result = self.original.fileExchange.call( self, o );

  function _exchange()
  {
    if( !src && dst )
    {
      self._statUpdate( srcPath );
      self._recordUpdate( srcPath );
    }
    if( !dst && src )
    {
      self._statUpdate( dstPath );
      self._recordUpdate( dstPath );
    }

    if( src && dst )
    {
      self._statUpdate( srcPath );
      self._recordUpdate( srcPath );
      self._statUpdate( dstPath );
      self._recordUpdate( dstPath );
    }
  }

  if( !o.sync )
  {
    return result
    .ifNoErrorThen( function( got )
    {
      if( got )
      {
        _exchange();
      }
      return got;
    });
  }
  else if( result )
  {
    _exchange();
  }

  return result;
}

fileExchange.defaults = {};
fileExchange.defaults.__proto__ = Partial.prototype.fileExchange.defaults;


// --
// relationship
// --

var Composes =
{
  original : null,
  cachingDirs : 1,
  cachingStats : 1,
  cachingRecord : 1,
  updateOnRead : 0,
  watchPath : null,
  watchOptions : _.define.own({}),
}

var Aggregates =
{
}

var Associates =
{
}

var Restricts =
{
  _cacheStats : _.define.own( {} ),
  _cacheDir : _.define.own( {} ),
  _cacheRecord : _.define.own( {} ),
  fileWatcher : null,
}

// --
// declare
// --

var Extend =
{
  fileStatAct : fileStatAct,
  directoryReadAct : directoryReadAct,
  fileRecord : fileRecord,

  fileReadAct : fileReadAct,

  fileHashAct : fileHashAct,

  fileWriteAct : fileWriteAct,

  fileTimeSetAct : fileTimeSetAct,

  fileDelete : fileDelete,

  directoryMake : directoryMake,

  fileRenameAct : fileRenameAct,
  fileCopyAct : fileCopyAct,
  linkSoftAct : linkSoftAct,
  linkHardAct : linkHardAct,

  fileExchange : fileExchange,

  _statUpdate : _statUpdate,
  _dirUpdate : _dirUpdate,
  _recordUpdate : _recordUpdate,
  _removeFromCache : _removeFromCache,

  _createFileWatcher : _createFileWatcher

}

//

var Proto =
{

  init : init,

  //


  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,

}

//

_.mapExtend( Proto,Extend );

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.Copyable.mixin( Self );

//

_.FileFilter = _.FileFilter || Object.create( null );
_.FileFilter[ Self.shortName ] = Self;

// --
// export
// --

if( typeof module !== 'undefined' )
if( _global_.WTOOLS_PRIVATE )
delete require.cache[ module.id ];

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
