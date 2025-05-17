
# module::ChangeTransactor [![status](https://github.com/Wandalen/wChangeTransactor/actions/workflows/StandardPublish.yml/badge.svg)](https://github.com/Wandalen/wChangeTransactor/actions/workflows/StandardPublish.yml) [![experimental](https://img.shields.io/badge/stability-experimental-orange.svg)](https://github.com/emersion/stability-badges#experimental)

Still sketch. Mixin to add the ability to track changes of an object, to reflect changes in a data structure and to make possible to apply the changes to another object. Use the module to mirror object's changes somehow elsewhere, for example on server-side or client-side.

### Try out from the repository

```
git clone https://github.com/Wandalen/wChangeTransactor
cd wChangeTransactor
will .npm.install
node sample/trivial/Sample.s
```

Make sure you have utility `willbe` installed. To install willbe: `npm i -g willbe@stable`. Willbe is required to build of the module.

### To add to your project

```
npm add 'wchangetransactor@stable'
```

`Willbe` is not required to use the module in your project as submodule.

