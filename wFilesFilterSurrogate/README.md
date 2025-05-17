# wFilesFilterSurrogate

Filter that works same like original provider, but additionally updates it own files tree cache. To perform behavior of original provider
filter wraps its methods.

### Installation
```npm install wfilesfiltersurrogate ```

### Usage

#### Options
* tree { object } - map that contains filesTree;
* original  { object }[ optional, default : default provider on target platform ] - provider to wrap.

Please visit [ wFiles ]( https://github.com/Wandalen/wFiles ) for information about providers.

###### Example #1
```javascript
var rootPath = 'path/to/directory';
var filesTree = _.FileFilter.Surrogate.filesTreeMake( rootPath );
var filter = _.FileFilter.Surrogate
({
  tree : filesTree,
  original : _.FileProvider.Extract(),
  rootPath : rootPath
});

/* getting files list using absolute path */
var files = filter.directoryRead( rootPath );
console.log( files );
```












