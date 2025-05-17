
# module::FileExecutor [![status](https://github.com/Wandalen/wFileExecutor/actions/workflows/StandardPublish.yml/badge.svg)](https://github.com/Wandalen/wFileExecutor/actions/workflows/StandardPublish.yml) [![experimental](https://img.shields.io/badge/stability-experimental-orange.svg)](https://github.com/emersion/stability-badges#experimental)

Experimental. Class to execute a collection of templates with inlined JavaScript code to instantiate it. A collection of templates could be co-dependent in which case FileExecutor deduce dependencies and correct order of templates executions.

### Try out from the repository

```
git clone https://github.com/Wandalen/wFileExecutor
cd wFileExecutor
will .npm.install
node sample/trivial/Sample.s
```

Make sure you have utility `willbe` installed. To install willbe: `npm i -g willbe@stable`. Willbe is required to build of the module.

### To add to your project

```
npm add 'wfileexecutor@stable'
```

`Willbe` is not required to use the module in your project as submodule.

