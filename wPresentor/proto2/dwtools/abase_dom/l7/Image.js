(function _Image_js_(){

'use strict';

//

var _ = _global_.wTools;

// --
// svg
// --

function svgAdd( dst,src )
{

  var result = _.svgDom( 'g',{
  });

  if( dst ) $( dst ).append( result );
  var src = $( src );
  var src = $( src[0].childNodes[src[0].childNodes.length-1] );

//<clipPath id='clipUnion'>
//    <use x='0' y='0' width='200' height='200' xlink :href='#clip1Shape' />
//    <use x='0' y='0' width='200' height='200' xlink :href='#clip2Shape' />
//</clipPath>

  result.append( src.children().clone() );
  var viewBox = src.attr( 'viewBox' );
  var width = src.attr( 'width' );
  var height = src.attr( 'height' );
  if( width !== undefined && height !== undefined )
  {
    if( viewBox )
    {
      viewBox = _.arrayFrom( viewBox );
      var transform
        = ' translate( ' + [-viewBox[0],-viewBox[1]].join(' ') + ' )'
        + ' scale( ' + [parseFloat( width )/viewBox[2],parseFloat( height )/viewBox[3]].join(' ') + ' )';
      result.attr( 'transform',transform );

      var clipId = _.dateGetId( 'clip' );
      var clip = _.svgDom( 'clipPath',{
        'id' : clipId
      })
      _.svgDom( 'rect',{
        'x' : viewBox[0],
        'y' : viewBox[1],
        'width' : viewBox[2],
        'height' : viewBox[3]
      }).appendTo( clip );
      result.attr( 'clip-path','url( #' + clipId + ' )' );
      if( dst ) dst.prepend( clip );
      else result = [result,clip];
    }
    else
    {
      var clipId = _.dateGetId( 'clip' );
      var clip = _.svgDom( 'clipPath',{
        'id' : clipId
      });
      _.svgDom( 'rect',{
        'x' : 0,
        'y' : 0,
        'width' : width,
        'height' : height
      }).appendTo( clip );
      result.attr( 'clip-path','url( #' + clipId + ' )' );
      if( dst ) dst.prepend( clip );
      else result = [result,clip];
    }
  }
  return result;

}

//

function svgDom( tag,attrs )
{

  //var xml = '<' + tag + '>'
  //        + 'xmlns=' +''http ://www.w3.org/2000/svg''
  //        + 'xmlns :xlink=' +''http ://www.w3.org/1999/xlink''
  //        + '</' + tag + '>';
  //var dom = $.parseXML( xml );
  var dom = document.createElementNS( 'http ://www.w3.org/2000/svg', tag );

  for( var a in attrs )
  if( attrs[a] !== '' && attrs[a] !== undefined )
  dom.setAttribute( a, attrs[a] );
  dom = $( dom );
  return dom;

}

//

function svgRoot( attrs )
{

  var dom = svgDom( 'svg',attrs )

  dom.attr( 'version','1.1' );
  //dom.attr( 'xmlns','http ://www.w3.org/2000/svg' );
  //dom.attr( 'xmlns :xlink','http ://www.w3.org/1999/xlink' );

  dom[0].setAttributeNS( 'http ://www.w3.org/2000/xmlns/', 'xmlns', 'http ://www.w3.org/2000/svg' );
  dom[0].setAttributeNS( 'http ://www.w3.org/2000/xmlns/', 'xmlns :xlink', 'http ://www.w3.org/1999/xlink' );
  //dom[0].setAttribute( 'xmlns :xlink','http ://www.w3.org/1999/xlink' );

  //dom.setAttributeNS( 'http ://www.w3.org/1999/xlink','xmlns :xlink' );
  //dom = document.createElementNS('http ://www.w3.org/2000/svg', tag );

  return dom;

}

//

var _xmlSerialiser;
function svgStringWithDom( svg )
{

  if( !_xmlSerialiser ) _xmlSerialiser = new XMLSerializer();

  if( _.jqueryIs( svg ) || _.arrayIs( svg ) ) svg = svg[0];
  var data = _xmlSerialiser.serializeToString( svg );
  var data
    = '<?xml version="1.0" encoding="utf-8"?>\n'
    + '<!DOCTYPE svg PUBLIC '-//W3C//DTD SVG 1.1//EN' 'http ://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd'>\n'
    + data;

  return data;
}

//

function svgFromPolygon( polygon, o )
{
  var result;

  var o = o || Object.create( null );
  if( o.precision === undefined ) o.precision = 5;
  if( o.rootless === undefined ) o.rootless = 0;
  if( o.scale === undefined ) o.scale = 1;
  if( _.numberIs( o.scale ) ) o.scale = [ o.scale,o.scale ];

  var path = result = _.svgDom( 'path' );

  var d = '';

  for( var p = 0,pl = polygon.length / 2; p < pl ; p++ )
  {
    d += polygon[ 2*p+0 ].toFixed( o.precision ) * o.scale[ 0 ];
    d += ',';
    d += polygon[ 2*p+1 ].toFixed( o.precision ) * o.scale[ 1 ];
    if( p < pl-1 )
    d += 'L';
  }

  path.attr( 'd','M'+d+'Z' );

  var svgOptions =
  {
    'fill' : 'none',
    'stroke' : 'black',
    //'stroke-width' : 0.2,
    //'stroke' : 'none' ),
    //'fill' : _.color.colorToRgbHtml( color ) ),
  };

  if( o.fill !== undefined ) svgOptions[ 'fill' ] = _.color.colorToRgbHtml( o.fill );
  if( o.stroke !== undefined  ) svgOptions[ 'stroke' ] = _.color.colorToRgbHtml( o.stroke );
  if( o[ 'stroke-width' ] !== undefined ) svgOptions[ 'stroke-width' ] = o[ 'stroke-width' ];

  if( !o.rootless )
  {

    //var minMax = _.avector.minmaxVector( polygon,2 );
    //var minMax = _.avector.distributionRangeSummary( polygon ); // xxx

    var wspace = wSpace({ buffer : polygon, dimensions : 2 });
    var min = wspace.reduceToMin();
    var max = wspace.reduceToMax();

    svgOptions[ 'width' ] = max.eGet( 0 ) * o.scale[ 0 ];
    svgOptions[ 'height' ] = max.eGet( 1 ) * o.scale[ 1 ];

    var svg = _.svgRoot( svgOptions );
    var group = _.svgDom( 'g' ).appendTo( svg );
    path.appendTo( group );
    result = svg;
  }
  else
  {
    path.attr( svgOptions );
  }

  return result;
}

// --
// canvas
// --

function canvasIs( src )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  if( !src )
  return false;
  return src instanceof HTMLCanvasElement;
}

//

function canvasMake( o )
{
  var o = o || Object.create( null );

  _.routineOptions( canvasMake,o );

  if( _.numberIs( o.size ) )
  o.size = [ o.size,o.size ];

  _.assert( _.arrayIs( o.size ) );

  var canvas = document.createElement( 'canvas' );
  canvas.width = o.size[ 0 ];
  canvas.height = o.size[ 1 ];

  var context = canvas.context = canvas.getContext( '2d' );
  if( o.color )
  {
    //debugger;
    context.fillStyle = _.color.colorToRgbaHtml( o.color );
    context.fillRect( 0,0,canvas.width,canvas.height );
  }

  return canvas;
}

canvasMake.defaults =
{
  size : [ 1,1 ],
  color : { r : 1 , g : 1 , b : 1, a : 0 },
}

//

function canvasResize( canvas,size )
{
  var context = canvas.context = canvas.context || canvas.getContext( '2d' );
  var data = context.getImageData( 0, 0, canvas.width - 1, canvas.height - 1 );
  canvas.width = size[ 0 ];
  canvas.height = size[ 1 ];
  context.putImageData( data, 0, 0 );

  return canvas;
}

//

function canvasDelete( canvas )
{

  throw _.err( 'not tested' );

  if( !canvas ) return;
  if( canvas.context ) delete canvas.context;
  if( canvas.image )
  {
    canvas.image.onload = null;
    delete canvas.image;
  }
  window.URL.revokeObjectURL( canvas['url'] );
}

//

function canvasAlign( src )
{

  throw _.err( 'not tested' );

  var srcSize = [ src.width,src.height ];

  _.avector.ceilToPowerOfTwo( srcSize );

  if( dstSize[ 0 ] == srcSize[ 0 ] && dstSize[ 1 ] == srcSize[ 1 ] )
  return src;

  var dst = document.createElement( 'canvas' );
  //dst = src;
  dst.width = dstSize[0];
  dst.height = dstSize[1];

  var context = dst.getContext( '2d' );
  context.drawImage( src, 0, 0, dstSize[0], dstSize[1] );

  return dst;
};

//

function canvasFromDom( dom,o )
{
  debugger;

  if( !_.domableIs( o ) )
  o = { src : o }

  o = _.routineOptions( canvasFromDataurl,o );
  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.domIs( o.src ),'canvasFromDom :','expects dom element' );

  var durl = dataurlFromSvgDom( o.src );

  return _.canvasFromDataurl({ src : durl });
}

canvasFromDom.defaults =
{
  src : null,
}

//

function canvasFromDataurl( o )
{

  if( _.strIs( o ) )
  o = { src : o }

  // if( _.objectIs( dataUrl ) )
  // {
  //   o = dataUrl;
  //   dataUrl = null;
  // }
  // var o = o || Object.create( null );
  // o.dataUrl = dataUrl || o.dataUrl;

  o = _.routineOptions( canvasFromDataurl,o );

  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.dataurlIs( o.src ) );

  if( !o.canvas )
  o.canvas = document.createElement( 'canvas' );

  if( !o.onReady )
  o.onReady = new _.Consequence();

  var readOptions = Object.create( null );
  readOptions.filePath = o.dataUrl;
  readOptions.onReady = function( image )
  {

    var canvas = _.canvasFromImage({ src : image });
    if( o.onReady )
    o.onReady( o );

  }

  _.imageReadFromFile( readOptions );
  o.image = readOptions.image;

  return o.canvas;
}

canvasFromDataurl.defaults =
{
  src : null,
  canvas : null,
  dataUrl : null,
  onReady : null,
}

//

function canvasFromImage( o )
{

  debugger;

  if( src instanceof HTMLImageElement )
  o = { src : o };

  o = _.routineOptions( canvasFromImage,o );

  _.assert( arguments.length === 1, 'expects single argument' );

  // var o = o || Object.create( null );

  if( !o.canvas )
  o.canvas = document.createElement( 'canvas' );
  var context = o.canvas.context = o.canvas.context || o.canvas.getContext( '2d' );

  if( o.size === null )
  o.size = [ o.src.width,o.src.height ]
  o.scale = _.numbersFromNumber( o.scale,2 );

  o.canvas.width = Math.abs( o.size[ 0 ] * o.scale[ 0 ] );
  o.canvas.height = Math.abs( o.size[ 1 ] * o.scale[ 1 ] );

  context.save();
  context.fillStyle = 'transparent';
  context.fillRect( 0,0,o.canvas.width,o.canvas.height );
  context.scale( scale[0],scale[1] );
  if( o.src.width > 0 && o.src.height > 0 )
  {
    var pos =
    [
      scale[ 0 ] < 0 ? o.src.width * scale[0] : 0,
      scale[ 1 ] < 0 ? o.src.height * scale[1] : 0,
    ];
    context.drawImage( o.src,pos[ 0 ],pos[ 1 ] );
  }
  context.restore();

  return o.canvas;
}

canvasFromImage.defaults =
{
  size : null,
  scale : 1,
  canvas : null,
  src : null,
}

//

function canvasFromImageData( o )
{

  if( o instanceof ImageData )
  o = { src : o };

  o = _.routineOptions( canvasFromImageData,o );

  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( o.src instanceof ImageData );

  if( !o.canvas )
  o.canvas = document.createElement( 'canvas' );
  var context = o.canvas.context = o.canvas.context || o.canvas.getContext( '2d' );

  o.canvas.width = o.src.width;
  o.canvas.height = o.src.height;

  context.putImageData( o.src, 0, 0 );

  return o.canvas;
}

canvasFromImageData.defaults =
{
  canvas : null,
  src : null,
}

//

function canvasFrom( o )
{

  if( !_.mapIs( o ) )
  o = { src : o }

  _.routineOptions( canvasFrom,o );
  _.assert( arguments.length === 1, 'expects single argument' );

  if( _.strIs( o.src ) )
  {
    debugger;
    _.assert( _.dataurlIs( o.src ) );
  }
  else if( o.src instanceof HTMLImageElement )
  {
    debugger;
    o.src = _.canvasFromImage( o.src );
  }
  else if( o.src instanceof ImageData )
  {
    o.src = _.canvasFromImageData( o.src );
  }
  else if( _.domIs( o.src ) )
  {
    debugger;
    o.src = _.dataurlFromSvgDom( o.src );
  }
  else throw _.err( 'canvasFrom :','unknown source',o.src );

  /* */

  if( o.src instanceof HTMLCanvasElement )
  {
    return o.src;
  }
  else
  {
    return _.canvasFromDataurl( o.src ).consequence;
  }

}

canvasFrom.defaults =
{
  src : null,
  // type : 'image/png',
}

//

function canvasNormalMapMake( image, depth )
{

  throw _.err( 'not tested' );

  var cross = _.avector.cross;
  var sub = _.avector.subVectors;
  var normalize = _.avector.normalize;

  depth = depth | 1;

  var width = image.width;
  var height = image.height;

  var canvas = document.createElement( 'canvas' );
  canvas.width = width;
  canvas.height = height;

  var context = canvas.getContext( '2d' );
  context.drawImage( image, 0, 0 );

  var data = context.getImageData( 0, 0, width, height ).data;
  var imageData = context.createImageData( width, height );
  var data = imageData.data;

  for( var x = 0; x < width; x ++ )
  {

    for( var y = 0; y < height; y ++ )
    {

      var ly = y - 1 < 0 ? 0 : y - 1;
      var uy = y + 1 > height - 1 ? height - 1 : y + 1;
      var lx = x - 1 < 0 ? 0 : x - 1;
      var ux = x + 1 > width - 1 ? width - 1 : x + 1;

      var points = [];
      var origin = [ 0, 0, data[ ( y * width + x ) * 4 ] / 255 * depth ];
      points.push( [ - 1, 0, data[ ( y * width + lx ) * 4 ] / 255 * depth ] );
      points.push( [ - 1, - 1, data[ ( ly * width + lx ) * 4 ] / 255 * depth ] );
      points.push( [ 0, - 1, data[ ( ly * width + x ) * 4 ] / 255 * depth ] );
      points.push( [  1, - 1, data[ ( ly * width + ux ) * 4 ] / 255 * depth ] );
      points.push( [ 1, 0, data[ ( y * width + ux ) * 4 ] / 255 * depth ] );
      points.push( [ 1, 1, data[ ( uy * width + ux ) * 4 ] / 255 * depth ] );
      points.push( [ 0, 1, data[ ( uy * width + x ) * 4 ] / 255 * depth ] );
      points.push( [ - 1, 1, data[ ( uy * width + lx ) * 4 ] / 255 * depth ] );

      var normals = [];

      for( var i = 0, l = points.length; i < l ; i ++ )
      {

        var v1 = points[ i ];
        var v2 = points[ ( i + 1 ) % l ];
        v1 = sub( v1, origin );
        v2 = sub( v2, origin );
        normals.push( normalize( cross( v1, v2 ) ) );

      }

      var normal = [ 0, 0, 0 ];

      for( var i = 0; i < normals.length; i ++ )
      {

        normal[ 0 ] += normals[ i ][ 0 ];
        normal[ 1 ] += normals[ i ][ 1 ];
        normal[ 2 ] += normals[ i ][ 2 ];

      }

      normal[ 0 ] /= normals.length;
      normal[ 1 ] /= normals.length;
      normal[ 2 ] /= normals.length;

      var index = ( y * width + x ) * 4;

      data[ index + 0 ] = ( ( normal[ 0 ] + 1.0 ) / 2.0 * 255 ) | 0;
      data[ index + 1 ] = ( ( normal[ 1 ] + 1.0 ) / 2.0 * 255 ) | 0;
      data[ index + 2 ] = ( normal[ 2 ] * 255 ) | 0;
      data[ index + 3 ] = 255;

    }

  }

  context.putImageData( imageData, 0, 0 );

  return canvas;
}

//

function canvasDataMake( size )
{

  if( _.numberIs( size ) )
  size = [ size,size ];

  var canvas = _.canvasMake
  ({
    size : size,
    color : 'rgba( 0,0,0,0 )',
  });

  debugger;

  canvas.data = canvas.context.getImageData( 0,0,size[ 0 ],size[ 1 ] );

  return canvas;
}

//

function canvasToDurl( o )
{
  var con = new _.Consequence();

  if( !_.mapIs( o ) )
  o = { canvas : o }

  _.routineOptions( canvasToDurl,o );

  function onBlobReady( blob )
  {
    o.durl = URL.createObjectURL( blob );

    // if( o.saving )
    // _.uri.save( o.durl,'snapshot.' + o.type );

    con.give( o );
  }


  o.canvas.toBlob( onBlobReady,'image/' + o.type, 1 );

  return con;
}

canvasToDurl.defaults =
{
  type : 'jpg',
  canvas : null,
}

// --
// drawing
// --

function canvasDrawRoundRect( ctx, x, y, w, h, r )
{
  ctx.beginPath();
  ctx.moveTo( x + r, y );
  ctx.lineTo( x + w - r, y );
  ctx.quadraticCurveTo( x + w, y, x + w, y + r );
  ctx.lineTo( x + w, y + h - r );
  ctx.quadraticCurveTo( x + w, y + h, x + w - r, y + h );
  ctx.lineTo( x + r, y + h );
  ctx.quadraticCurveTo( x, y + h, x, y + h - r );
  ctx.lineTo( x, y + r );
  ctx.quadraticCurveTo( x, y, x + r, y );
  ctx.closePath();
  ctx.fill();
  ctx.stroke();
}

//

function canvasDrawText( o )
{

  // if ( o === undefined )
  // o = Object.create( null );
  //
  // if( o.fontface === undefined ) o.fontface = 'Arial';
  // if( o.fontSize === undefined ) o.fontSize = 50;
  // if( o.borderThickness === undefined ) o.borderThickness = 2;
  // if( o.borderColor === undefined ) o.borderColor = { r : 0, g : 0, b : 0, a :1.0 };
  // if( o.backgroundColor === undefined ) o.backgroundColor = { r : 255, g : 255, b : 255, a : 1.0 };
  // if( o.textColor === undefined ) o.textColor = { r : 0, g : 0, b : 0, a : 1.0 };
  // if( o.scale === undefined ) o.scale = 1;
  // if( o.background === undefined ) o.background = 1;

  if( _.strIs( o ) )
  o = { text : o }
  if( arguments[ 1 ] )
  _.mapExtend( o,arguments[ 1 ] );

  _.routineOptions( canvasDrawText,o );

  o.fontSize = Number( o.fontSize );
  o.borderThickness = Number( o.borderThickness );

  _.assert( _.numberIsFinite( o.fontSize ) );
  _.assert( _.numberIsFinite( o.borderThickness ) );
  _.assert( _.strIs( o.text ) );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  // canvas

  if( !o.canvas )
  o.canvas = document.createElement( 'canvas' );
  var context = o.canvas.context = o.canvas.context || o.canvas.getContext( '2d' );

  // metrics

  var metrics = [];
  context.canvas.width = 1;
  context.canvas.height = 1;
  context.font = '' + o.fontSize + 'px ' + o.fontface;
  var padding = context.measureText( 'M' );
  var m = context.measureText( o.text );
  metrics[ 0 ] = m.width + padding.width*2 + o.borderThickness*2;
  metrics[ 1 ] = o.fontSize*1.3 + o.borderThickness*2;

  context.canvas.width = metrics[ 0 ];
  context.canvas.height = metrics[ 1 ];
  context.font = '' + o.fontSize + 'px ' + o.fontface;

  // draw background

  if( o.background )
  {
    context.fillStyle = _.color.colorToRgbaHtml( o.backgroundColor );
    context.strokeStyle = _.color.colorToRgbaHtml( o.borderColor );
    context.lineWidth = o.borderThickness;
    if( !o.borderThickness )
    context.strokeStyle = 'transparent';
    canvasDrawRoundRect
    (
      context,
      o.borderThickness,
      o.borderThickness,
      metrics[ 0 ] - o.borderThickness*2,
      metrics[ 1 ] - o.borderThickness*2,
      metrics[ 1 ] / 4
    );
  }

  // draw text

  context.fillStyle = _.color.colorToRgbaHtml( o.textColor );
  context.strokeStyle = _.color.colorToRgbaHtml( o.textColor );
  context.fillText( o.text, o.borderThickness + padding.width, o.fontSize + o.borderThickness );

  //_.pictureShow( canvas );

  return o;
}

canvasDrawText.defaults =
{
  text : null,
  canvas : null,
  fontface : 'Arial',
  fontSize : 50,
  borderThickness : 2,
  borderColor : { r : 0, g : 0, b : 0, a : 1.0 },
  backgroundColor : { r : 255, g : 255, b : 255, a : 1.0 },
  textColor : { r : 0, g : 0, b : 0, a : 1.0 },
  scale : 1,
  background : 1,
}

// --
// image
// --

function imageIs( src )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  if( !src )
  return false;
  return src instanceof HTMLImageElement;
}

//

function imageFromCanvas( canvas )
{

  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( canvas instanceof HTMLCanvasElement );

  debugger

  throw _.err( 'not implemented' );

}

function imageClampToSize( image, maxSize )
{

  //throw _.err( 'not tested' );

  if( image.width <= maxSize && image.height <= maxSize )
  {

    return image;

  }

  // Scaling with canvas does not work with image without premultiplied alpha.

  var maxDimension = Math.max( image.width, image.height );
  var newWidth = Math.floor( image.width * maxSize / maxDimension );
  var newHeight = Math.floor( image.height * maxSize / maxDimension );

  var canvas = document.createElement( 'canvas' );
  canvas.width = newWidth;
  canvas.height = newHeight;

  var ctx = canvas.getContext( '2d' );
  ctx.drawImage( image, 0, 0, image.width, image.height, 0, 0, newWidth, newHeight );

  return canvas;
}

//

function imageGetWithDom( dom,o )
{

  if( !_.domIs( dom ) ) dom = dom[ 0 ];
  _.assert( _.domIs( dom ),'canvasFromDom :','expects dom element' );

  var durl = _.dataurlFromSvgDom( dom );

  return _.imageReadFromFile( durl,o );
}

//

var _imageReadFromFileProcessing = [];
function imageReadFromFile( o )
{

  if( _.strIs( o ) )
  o = { filePath : o };

  _.assert( arguments.length === 1, 'expects single argument' );
  _.routineOptions( imageReadFromFile,o );
  _.assert( _.strIsNotEmpty( o.filePath ) );

  if( !o.onReady )
  o.onReady = new _.Consequence();

  if( _.arrayIs( o.filePath ) || _.mapIs( o.filePath ) )
  {

    debugger;
    var result = _.entityMake( o.filePath );

    o.onReady.got( _.entityLength( o.filePath ) );

    _.each( o.filePath,function( e,k )
    {
      var optionsForRead = _.mapExtend( null,o );
      optionsForRead.filePath = e;
      optionsForRead.onReady = o.onReady;
      result[ k ] = imageReadFromFile( optionsForRead ).image;
    });

    o.onReady.doThen( function()
    {
      o.onReady.give( result );
    });

    o.onReady.give();

    return o;
  }

  _.assert( _.strIsNotEmpty( o.filePath ) );

  var image = o.image = new Image();

  if( o.serializing )
  {
    _imageReadFromFileProcessing.push( o )
    if( _imageReadFromFileProcessing.length > 1 )
    {
      debugger;
      console.info( 'Not tested' );
      return;
    }
  }

  /* */

  function onLoad()
  {

    if( o.onEnd )
    o.onEnd( undefined, image );

    o.onReady.give( undefined, image );

    if( o.serializing )
    _imageReadFromFileProcessing.splice( 0,1 );
    var l = _imageReadFromFileProcessing.length;
    if( l > 0 )
    {
      debugger;
      throw _.err( 'not tested' );
      var execute = _imageReadFromFileProcessing[ l-1 ];
      _imageReadFromFileProcessing.splice( 0,l-1 );
      o.serializing = false;
      _.imageReadFromFile( o.filePath,o );
    }

  }

  /* */

  function onError( err )
  {
    err = _.errLogOnce( 'imageReadFromFile : error loading :',o.filePath );

    if( o.onEnd )
    o.onEnd( err, undefined );
    o.onReady.give( err, undefined );

    throw err;
  }

  /* */

  //image.setAttribute( 'src','' );
  //image.setAttribute( 'src','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAIAAACQd1PeAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAMSURBVBhXY/j//z8ABf4C/qc1gYQAAAAASUVORK5CYII=' );
  //debugger;

  image.onload = onLoad;
  image.onerror = onError;
  _.timeOut( 0,function()
  {
    image.src = o.filePath;
  });

  return o;
}

imageReadFromFile.defaults =
{
  image : null,
  filePath : null,
  onReady : null,
  serializing : 0,
}

//

function imageSize( image )
{
  var result = [];

  _.assert( arguments.length === 1, 'expects single argument' );

  // if( _.arrayIs( image ) || _.mapIs( image ) )
  // result[ 0 ] = _.entityVals( image )[ 0 ].width;
  // else if( image )
  // result[ 0 ] = image.width;
  // else
  // result[ 0 ] = 0;

  if( _.arrayIs( image ) || _.mapIs( image ) )
  {
    image = _.entityVals( image );
    result[ 0 ] = image[ 0 ].width;
    result[ 1 ] = image[ 1 ].height;
  }
  else if( image )
  {
    result[ 0 ] = image.width;
    result[ 1 ] = image.height;
  }
  else
  {
    result[ 0 ] = 0;
    result[ 1 ] = 0;
  }

  return result;
}

//

function pictureShow( picture )
{
  // var dataurl = _.dataurlFrom( picture );

  _.assert( arguments.length === 1, 'expects single argument' );

  if( !_.imageIs( picture ) && !_.canvasIs( picture ) )
  picture = _.canvasFrom( picture );

  var tab = _.domWindowOpen();

  tab.document.body.appendChild( picture );

  $( picture ).css({ 'border' : '2px solid black' })

  return tab;
}

/*
// clear canvas
ctx.save();
ctx.setTransform(1, 0, 0, 1, 0, 0);
ctx.clearRect(0, 0, canvas.width, canvas.height);
ctx.restore();
*/

//

function pictureSave( picture )
{

  if( !_.imageIs( picture ) && !_.canvasIs( picture ) )
  picture = _.canvasFrom( picture );

  var con = _.canvasToDurl( picture );

  con.ifNoErrorThen( function( e ) {

    _.assert( e.durl );
    _.uri.save( e.durl,'picture.' + e.type );

    return e;
  });

  return con;
}

// --
// prototype
// --

var Proto =
{

  // svg

  svgAdd : svgAdd,
  svgDom : svgDom,
  svgRoot : svgRoot,
  svgStringWithDom : svgStringWithDom,
  svgFromPolygon : svgFromPolygon,


  // canvas

  canvasIs : canvasIs,
  canvasMake : canvasMake,
  canvasResize : canvasResize,
  canvasDelete : canvasDelete,
  canvasAlign : canvasAlign,

  canvasFromDom : canvasFromDom,
  canvasFromDataurl : canvasFromDataurl,
  canvasFromImage : canvasFromImage,
  canvasFromImageData : canvasFromImageData,
  canvasFrom : canvasFrom,

  canvasNormalMapMake : canvasNormalMapMake,
  canvasDataMake : canvasDataMake,

  canvasToDurl : canvasToDurl,


  // drawing

  canvasDrawRoundRect : canvasDrawRoundRect,
  canvasDrawText : canvasDrawText,


  // image

  imageIs : imageIs,
  imageFromCanvas : imageFromCanvas,
  imageClampToSize : imageClampToSize,
  imageGetWithDom : imageGetWithDom,
  imageReadFromFile : imageReadFromFile,

  imageSize : imageSize,


  // picture

  pictureShow : pictureShow,
  pictureSave : pictureSave,

}

_.mapExtend( _,Proto );

})();
