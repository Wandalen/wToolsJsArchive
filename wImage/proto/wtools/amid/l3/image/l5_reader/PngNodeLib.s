( function _PngNodeLib_s_()
{

'use strict';

/**
 * @classdesc Abstract interface to read image.
 * @class wImageReaderPngNodeLib
 * @namespace wTools
 * @module Tools/mid/ImageReader
 */

const _ = _global_.wTools;
let { decode } = require( 'node-libpng' );
let Backend = { decode };
let bufferFromStream = require( './BufferFromStream.s' );
const Parent = _.image.reader.Abstract;
const Self = wImageReaderPngNodeLib;
function wImageReaderPngNodeLib()
{

  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'PngNodeLib';

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
  structure.buffer = _.bufferRawFrom( os.data );
  else
  structure.buffer = null;

  if( o.op.params.headGot )
  return o.op;

  structure.dims = [ os.width, os.height ];

  o.op.params.originalStructure = os;

  // _.assert( !os.palette, 'not implemented' );

  if( os.colorType === 'rgb' )
  {
    _.assert( structure.channelsArray.length === 0 );
    channelAdd( 'red' );
    channelAdd( 'green' );
    channelAdd( 'blue' );
  }
  else if( os.colorType === 'rgba' )
  {
    _.assert( structure.channelsArray.length === 0 );
    channelAdd( 'red' );
    channelAdd( 'green' );
    channelAdd( 'blue' );
    channelAdd( 'alpha' );
  }

  if( os.colorType === 'gray-scale' )
  {
    _.assert( o.op.structure.channelsArray.length === 0 );
    channelAdd( 'gray' );
  }

  // structure.bitsPerPixel = _.props.vals( structure.channelsMap ).reduce( ( val, channel ) => val + channel.bits, 0 );
  // structure.bytesPerPixel = Math.round( structure.bitsPerPixel / 8 );
  structure.bitsPerPixel = os.bitDepth;
  structure.bytesPerPixel = Math.ceil( structure.bitsPerPixel / 8 );
  structure.special.interlaced = os.interlaceType !== 'none';
  structure.hasPalette = os.palette !== undefined;

  o.op.params.headGot = true;

  if( o.op.params.onHead )
  o.op.params.onHead( o.op );

  return o.op;

  /* */

  function channelAdd( name )
  {
    // structure.channelsMap[ name ] = { name, bits : os.bitDepth, order : structure.channelsArray.length };
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

function _readHead ( o )
{
  let self = this;
  _.assert( arguments.length === 1 );
  _.routine.assertOptions( _readHead, o );
  if( !o.params.mode )
  o.params.mode = 'head';
  return self._readGeneral( o );
}

_readHead.defaults =
{
  ... Parent.prototype._readHead.defaults,
  // ... Parent.prototype._read.defaults,
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

//

function _readGeneralBufferSync( o )
{
  let self = this;
  try
  {
    let image = Backend.decode( _.bufferNodeFrom( o.in.data ) );
    self._structureHandle({ originalStructure : image, op : o, mode : 'full' });
  }
  catch( err )
  {
    throw _.err( err );
  }
  return o;
}

//

function _readGeneralBufferAsync( o )
{
  let self = this;
  let ready = new _.Consequence();
  try
  {
    let image = Backend.decode( _.bufferNodeFrom( o.in.data ) );
    self._structureHandle({ originalStructure : image, op : o, mode : 'full' });
    ready.take( o );
  }
  catch( err )
  {
    throw _.err( err );
  }
  return ready;

}


// --
// relations
// --

let Formats = [ 'png' ];
let Exts = [ 'png' ];

let Composes =
{
  shortName : 'pngNodeLib',
  ext : _.define.own([ 'png' ]),
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
  SupportsStream : 0,
  SupportsDepth : 1,
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

  _readHead,
  _read,

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

})();
