
if( typeof module !== 'undefined' )
require( 'wnamemapper' );

let _ = wTools;

var nameMapper = new wNameMapper(/*{ droppingDuplicate : 1 }*/).set
({

  'exam' : 'discussion',
  'quiz' : 'problem',
  'supplement' : 'hypertext',
  'video' : 'video',

  'pdf' : 'downloadable',
  'subtitles' : 'downloadable',
  'asset' : 'downloadable',

  'lecture' : 'page',
  'section' : 'section',
  'week' : 'chapter',
  'course' : 'course',

});

// console.log( 'nameMapper.valueToKeyMap',nameMapper.valueToKeyMap );
// console.log( 'nameMapper.keyToValueMap',nameMapper.keyToValueMap );

var valueForExam = nameMapper.forKey( 'exam' )
console.log( 'valueForExam :', valueForExam );
// valueForExam : discussion

var valueForPdf = nameMapper.forKey( 'pdf' )
console.log( 'valueForPdf :', valueForPdf );
// valueForPdf : downloadable

try
{
  var values = nameMapper.forVal( 'downloadable' )
}
catch( err )
{
  console.log( 'Unknown value downloadable, because this value has duplicates' )
}
