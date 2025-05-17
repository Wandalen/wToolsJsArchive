
let _ = require( 'wimg' );

// let image = _.image.fileRead( __dirname + '/../proto/wtools/amid/l3/image.test/_assets/basic/Pixels-2x2.png' ).structure;
let image = _.image.fileRead( __dirname + '/Pixels-2x2.png' );
console.log( image );
/* log :
[Object: null prototype] {
  in:
   [Object: null prototype] {
     data: ArrayBuffer { byteLength: 127 },
     filePath:
      '/Users/jackiejo/main/BFS/wImg/sample/trivial/Pixels-2x2.png',
     ext: 'png',
     format: 'buffer.png' },
  out:
   [Object: null prototype] {
     data:
      [Object: null prototype] {
        special: [Object],
        channelsMap: [Object: null prototype] {},
        channelsArray: [Array],
        buffer: ArrayBuffer { byteLength: 16 },
        dims: [Array],
        bytesPerPixel: 1,
        bitsPerPixel: 8,
        hasPalette: false },
     format: 'structure.image' },
  params:
   [Object: null prototype] {
     onHead: null,
     mode: 'full',
     headGot: true,
     originalStructure:
      { width: 2,
        height: 2,
        depth: 8,
        interlace: false,
        palette: false,
        color: true,
        alpha: true,
        bpp: 4,
        colorType: 6,
        data: <Buffer ff 00 00 ff 00 ff 00 ff 00 00 ff ff ff ff ff ff>,
        gamma: 0.45455 } },
  sync: 1,
  err: null }
*/
