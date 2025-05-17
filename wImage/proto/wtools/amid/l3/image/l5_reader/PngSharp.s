( function _PngSharp_s_()
{

'use strict';

/**
 * @classdesc Abstract interface to read image.
 * @class wImageReaderPngSharp
 * @namespace wTools
 * @module Tools/mid/ImageReader
 */

const _ = _global_.wTools;
let Backend = require( 'sharp' );
const Parent = _.image.reader.Abstract;
let bufferFromStream = require( './BufferFromStream.s' );
const Self = wImageReaderPngSharp;
function wImageReaderPngSharp()
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'PngSharp';

// --
// implementation
// --

function _structureHandle( o )
{
  let self = this;
  let os = o.originalStructure;

  if( os === null )
  os = o.op.originalStructure;

  _.routine.assertOptions( _structureHandle, arguments );
  _.assert( _.object.isBasic( os ) );
  _.assert( _.strIs( o.mode ) );

  let structure = o.op.out.data;

  if( o.mode === 'full' && o.op.params.mode === 'full' )
  structure.buffer = _.bufferRawFrom( os.buffer );
  else
  structure.buffer = null;

  if( o.op.params.headGot )
  return o.op;

  structure.dims = [ os.metadata.width, os.metadata.height ];

  o.op.params.originalStructure = os;

  _.assert( !os.metadata.palette, 'not implemented' );

  if( os.metadata.space === 'rgb' || os.metadata.space === 'srgb' )
  {
    _.assert( structure.channelsArray.length === 0 );
    channelAdd( 'red' );
    channelAdd( 'green' );
    channelAdd( 'blue' );
  }

  if( os.metadata.space === 'gray' )
  {
    _.assert( structure.channelsArray.length === 0 );
    channelAdd( 'gray' );
  }

  if( os.metadata.hasAlpha )
  {
    channelAdd( 'alpha' );
  }

  // NO BIT DEPTH
  structure.special.interlaced = os.metadata.isProgressive;
  structure.hasPalette = os.metadata.paletteBitDepth !== undefined;
  o.op.params.headGot = true;

  if( o.op.params.onHead )
  o.op.params.onHead( o.op );

  return o.op;

  /* */

  function channelAdd( name )
  {
    structure.channelsArray.push( name );
  }

}

_structureHandle.defaults =
{
  op : null,
  originalStructure : null,
  mode : null,
}

//

function _readGeneral( o )
{
  let self = this;

  _.routine.assertOptions( _readGeneral, o );
  _.assert( arguments.length === 1 );
  _.assert( _.longHas( [ 'full', 'head' ], o.params.mode ) );
  _.assert( o.in.format === null || _.strIs( o.in.format ) );
  _.assert( o.out.format === null || _.strIs( o.out.format ) );
  _.assert( o.in.data !== undefined );

  o.params.headGot = false;

  if( _.streamIs( o.in.data ) )
  {

    if( o.in.format === null )
    o.in.format = 'stream.png';

    if( o.sync )
    return self._readGeneralStreamSync( o )
    else
    return self._readGeneralStreamAsync( o );
  }
  else
  {
    if( o.in.format === null )
    o.in.format = 'buffer.png';

    if( o.sync )
    return self._readGeneralBufferSync( o );
    else
    return self._readGeneralBufferAsync( o );
  }

}

_readGeneral.defaults =
{
  ... Parent.prototype._read.defaults,
  // mode : 'full',
}

//

function _readHead( o )
{
  let self = this;
  _.assert( arguments.length === 1 );
  _.routine.assertOptions( _readHead, o );
  o.mode = 'head';
  return self._readGeneral( o );
}

_readHead.defaults =
{
  ... Parent.prototype._read.defaults,
}

//

function _read( o )
{
  let self = this;
  _.assert( arguments.length === 1 );
  _.routine.assertOptions( _read, o );
  if( !o.params.mode )
  o.params.mode = 'full';
  return self._readGeneral( o );
}

_read.defaults =
{
  ... Parent.prototype._read.defaults,
}

//

function _readGeneralBufferAsync( o )
{
  let self = this;
  let ready = new _.Consequence();
  let data = {};

  try
  {
    if( o.mode === 'head' )
    {
      Backend( _.bufferNodeFrom( o.in.data ) )
      .metadata()
      .then( ( metadata ) =>
      {
        self._structureHandle({ originalStructure : { metadata }, op : o, mode : 'full' });
        ready.take( o );
      });
    }
    else
    {
      Backend( _.bufferNodeFrom( o.in.data ) )
      .metadata()
      .then( ( metadata ) =>
      {
        console.log( metadata )
        data.metadata = metadata;

        Backend( _.bufferNodeFrom( o.in.data ) )
        .raw()
        .toBuffer()
        .then( ( buffer ) =>
        {
          // console.log( buffer )
          data.buffer = buffer;
          self._structureHandle({ originalStructure : data, op : o, mode : 'full' });
          ready.take( o );
        } )
      } )
    }
  }
  catch( err )
  {
    throw _.err( err );
  }

  return ready;
}

//

function _readGeneralBufferSync( o )
{
  let self = this;
  let ready = self._readGeneralBufferAsync( o );
  ready.deasync()
  return ready;
}

//

function _readGeneralStreamAsync( o )
{
  let self = this;
  let ready = bufferFromStream({ src : o.in.data });

  ready.then( ( buffer ) =>
  {
    o.in.data = _.bufferNodeFrom( buffer );
    return self._readGeneralBufferAsync( o );
  } )

  return ready;
}

//

function _readGeneralStreamSync( o )
{
  let self = this;
  let ready = self._readGeneralStreamAsync( o );
  ready.deasync();
  return ready.sync();
}

// --
// relations
// --

let Formats = [ 'png', 'jpg', 'webp', 'gif', 'svg', 'tif' ];
let Exts = [ 'png', 'jpg', 'jpeg', 'webp', 'gif', 'svg', 'tif', 'tiff' ];

// let Formats = [ 'png' ];
// let Exts = [ 'png' ];

let Composes =
{
  shortName : 'pngSharp',
  ext : _.define.own([ 'png', 'jpg', 'jpeg', 'webp', 'gif', 'svg', 'tif', 'tiff' ]),
  inFormat : _.define.own([ 'buffer.any', 'string.any' ]),
  outFormat : _.define.own([ 'structure.image' ]),
  feature : _.define.own({}),
}

let Aggregates =
{
}

let Associates =
{
}

let Restricts =
{
}

let Statics =
{
  Formats,
  Exts,
  SupportsDimensions : 1,
  SupportsBuffer : 1,
  SupportsDepth : 0,
  SupportsColor : 1,
  SupportsSpecial : 1,
  LimitationsRead : 0,
  MethodsNativeCount : 1
}

let Forbids =
{
}

let Accessors =
{
}

let Medials =
{
}

// --
// prototype
// --

let Extension =
{
  _structureHandle,
  _readGeneralBufferSync,
  _readGeneralBufferAsync,
  _readGeneralStreamAsync,
  _readGeneralStreamSync,
  _readGeneral,

  _read,
  _readHead,

  //

  Formats,
  Exts,

  //

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Medials,
  Statics,
  Forbids,
  Accessors,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extension,
});

//

_.assert( !_.image.reader[ Self.shortName ] );
// new Self();
_.image.reader[ Self.shortName ] = new Self();
_.assert( !!_.image.reader[ Self.shortName ] );

// _.image.reader[ Self.shortName ] = Self;
if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

} )();
