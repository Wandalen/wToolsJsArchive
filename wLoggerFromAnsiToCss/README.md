
# wLoggerFromAsciiToCss [![Build Status](https://travis-ci.org/Wandalen/wLoggerFromAsciiToCss.svg?branch=master)](https://travis-ci.org/Wandalen/wLoggerFromAsciiToCss)

Class to transform ANSI-styled input into CSS-styled output supported by the browser's console.

## Installation
```terminal
npm install wloggerfromasciitocss
```

##### Example #1
```javascript
var l = new _.LoggerFromAsciiToCss({ output : console });
l.log( _.ct.fg( 'text', 'red' ) );
// %ctext color:rgba(255,51,0,1);
```





















