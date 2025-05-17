
if( typeof module !== 'undefined' )
require( 'wColor256' );

let _ = wTools;
var names = _.mapOwnKeys( _.color.ColorMap ).sort();
var table = document.createElement('table');
var tr;
var c = 0;
names.forEach( ( n, i ) =>
{
  c++;
  if( !tr || c === 15 )
  {
    tr = document.createElement('tr');
    c = 0;
  }
  var td = document.createElement('td');
  var text = document.createTextNode( _.strDup( '\u00A0', 4 ) +  i + _.strDup( '\u00A0', 4 ) );
  td.appendChild(text);
  td.id = i;
  td.title = n;
  tr.appendChild(td);
  table.appendChild(tr);
});

document.body.appendChild(table);
var info = document.createElement('p');
info.innerText = 'Click on cell to get info about color!'
document.body.appendChild(info);

names.forEach( ( n, i ) =>
{
  document.getElementById( i ).onclick = () => alert( 'name : ' + n + '\n' + 'rgb : ' + _.color.ColorMap[ n ] )
  document.getElementById( i ).setAttribute( 'style', 'text-align: center;color : white;background-color :' + _.color.colorToHex( _.color.ColorMap[ n ] ))
});
