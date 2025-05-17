
if( typeof module !== 'undefined' )
require( 'wtemplatetreeenvironment' );

var tree = { 'a' : 'a', 'b' : [ 1, 2, 3 ], 'c' : { 'c1' : [ 1, 2, 3 ], 'c2' : [ 11, 22, 33 ] }, 'd' : '{{^^a}}' }
var templateTree = new wTemplateTreeEnvironment();
templateTree.tree = tree;

var b1 = templateTree.select( 'b/#1' );
var d = templateTree.select( 'd' );

console.log( 'b1 :', b1 );
// b1 : 2
console.log( 'd :', d );
// d : a
