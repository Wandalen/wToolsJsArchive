# Introduction

The article describes the main features of the module and the principles of its use.

### Mathematical model

A formal description of the system using mathematical concepts and language.

### Making an instance

Every model has a defined of routines `make` and `from` for creating an instance of it. Calling without arguments creates an instance with default parameters. Also, each model defines routine `is` which answers the question: "is this essence an instance of this model".

### Routine make

The routine `make` allows to create an instance of a model. A new instance can be created based on a given dimensionality or another instance. If an instance of a model is used as an argument, the new instance will be a copy of the original instance.

Creation of an instance of the model `box` with dimensions by default:

```js
var box = _.box.make();
console.log( `Type : ${ _.entity.strType( box ) }` );
/* log : Type : Array */
console.log( box );
/* log : [ 0, 0, 0, 0, 0, 0 ] */
console.log( `_.box.is( box ) : ${ _.box.is( box ) }` );
/* log : _.box.is( box ) : true */
```

Box `box` is in `3D` space. The first three scalars describe one extreme point, while the last three scalars describe another extreme point. Those are the model's default parameters.

Every model implements routine `make` and defines default arguments so that an instance can be created through a call without arguments.

The invocation of the routine `make` with a scalar creates a box with a given dimensionality.

```js
var dim = 2;
var box = _.box.make( dim );
console.log( box );
/* log : [ 0, 0, 0, 0 ] */
console.log( `Type : ${ _.entity.strType( box ) }` );
/* log : Type : Array */
console.log( `_.box.is( box ) : ${ _.box.is( box ) }` );
/* log : _.box.is( box ) : true */
```

Box `box` is created in 2D space, unlike the previous example, the vector has only 4 scalars - 2 for each vertex.

To create with a sample pass the sample as the argument to the routine `make`.

```js
var srcBox = [ 2, 1, 9, 5 ];
var box = _.box.make( srcBox );
console.log( box );
/* log : [ 2, 1, 9, 5 ] */
console.log( `srcBox === box : ${ srcBox === box }` );
/* log : srcBox === box : false */
console.log( `Type : ${ _.entity.strType( box ) }` );
/* log : Type : Array */
console.log( `_.box.is( box ) : ${ _.box.is( box ) }` );
/* log : _.box.is( box ) : true */
```

Dimensionality and all the data of the `box` are the same as in `srcBox`.

![Box](../../img/Box.png)

Call `_.box.make( srcBox )` creates and returns a vector which contains 4 scalars, 2 for each point. Two points describe a box.

Creation with default parameters:

```js
var box = _.box.make( null );
console.log( box );
/* log : [ 0, 0, 0, 0 ] */
console.log( `Type : ${ _.entity.strType( box ) }` );
/* log : Type : Array */
console.log( `_.box.is( box ) : ${ _.box.is( box ) }` );
/* log : _.box.is( box ) : true */
```

The semantics is the same as in the example with a call without arguments. The pragmatics is different: an imaginary instance with default parameters is used as a sample.

### Routine from

An alternative way to create an instance of a mathematical model is using the routine `from`. The routine `from` the same as `make` constructs a new instance, but unlike the routine `make`, performs an additional checking. The routine `from` creates a new instance only if an argument of the call is not an instance of that model. If an argument of the call `from` is an instance of that model, it is returned without any changes.

Let's create an instance of the box model manually and pass it as the routine input.

```js
var srcBox = new F32x([ 2, 1, 9, 5 ]);
var box = _.box.from( srcBox );
console.log( box );
/* log : Float32Array(4) [ 2, 1, 9, 5 ] */
console.log( `srcBox === box : ${ srcBox === box }` );
/* log : srcBox === box : true */
console.log( `Type : ${ _.entity.strType( box ) }` );
/* log : Type : F32x */
console.log( `_.box.is( box ) : ${ _.box.is( box ) }` );
/* log : _.box.is( box ) : true */
```

The routine `_.box.from()` first of all, checks whether `srcBox` is an instance of the model `box`. And `srcBox` is an instance of the model `box` so it is returned without any changes from the routine `_.box.from()`.

Alternatively the routine `from()` accepts a vector adapter.

```js
var srcBox = _.vad.fromLong([ 2, 1, 9, 5 ]);
var box = _.box.from( srcBox );
console.log( box );
/* log : VectorAdapter.x4.Array :: 2.000 1.000 9.000 5.000 */
console.log( `srcBox === box : ${ srcBox === box }` );
/* log : srcBox === box : true */
console.log( `_.box.is( box ) : ${ _.box.is( box ) }` );
/* log : _.box.is( box ) : true */
```

The same as in the previous example the routine `_.box.from()` returns `srcBox` without any changes.

If `from` takes `null` as an argument, we'll get the same semantics as in the routine `make`.

```js
var box = _.box.from( null );
console.log( box );
/* log : [ 0, 0, 0, 0, 0, 0 ] */
console.log( `Type : ${ _.entity.strType( box ) }` );
/* log : Type : Array */
console.log( `_.box.is( box ) : ${ _.box.is( box ) }` );
/* log : _.box.is( box ) : true */
```

The routine `_.box.from()` creates a new instance of the box model with default parameters.

### Make vs from

Two alternative ways `make()` and `from()` for the creation of instances of mathematical models have similarities and differences.

```js
var box1 = _.box.make( null );
console.log( `Box1 : ${ box1 }` );
/* log : Box1 : [ 0, 0, 0, 0, 0, 0 ] */

var box2 = _.box.from( null );
console.log( `Box2 : ${ box2 }` );
/* log : Box2 : [ 0, 0, 0, 0, 0, 0 ] */

```

Both calls create a new instance of the model `box` with the dimensionality defined by default. Semantics and pragmatics are the same.

The difference between routines `make()` and `from()` is what they do with prepared instances as arguments.

```js
var src1 = [ 2, 1, 9, 5 ];
var box1 = _.box.make( src1 );
console.log( 'Box1 :', box1 );
/* log : Box1 : [ 2, 1, 9, 5 ] */
console.log( 'src1 === box1 :', src1 === box1 );
/* log : src1 === box1 : false */

var src2 = [ 2, 1, 9, 5 ];
var box2 = _.box.from( src2 );
console.log( 'Box2 :', box2 );
/* log : Box2 : [ 2, 1, 9, 5 ] */
console.log( 'src2 === box2 :', src2 === box2 );
/* log : src2 === box2 : true */
```

Both calls `make()` and `from()` return an instance of the model box with parameters `[ 2, 1, 9, 5 ]`. But the routine `make()` created a copy of `src1`, and the routine `from()` returned `src1` without any changes.

### Uncoupling data and functionality

Data of instances of all mathematical models are stored in the **vector** ( of any form ) or **matrix**. The container for the model box, quaternion, straight line, and many others is a **vector**.

A vector might have the following forms:

- array ( Array )
- typed array ( BufferTyped )
- vector adapter ( VectorAdapter )

A vector adapter is a kind of link that defines how to interpret data as the vector.

The container for the model polygon and frustum is a **matrix**. A matrix is capable of transferring multidimensional information, what is required for models like a polygon.

A **zero-copy principle** can be implemented both through the matrix and through the vector adapter.

Uncoupling of the data and functionality:

 - makes it possible to avoid useless copying of data.
 - simplifies the use of the module.
 - standardizes the interface.
 - algorithms of all models are not tied to the form, the format, or the type of the data.
 - makes the system more extendable

Algorithms and data are uncoupled. Algorithms are implemented on the abstract interface of the vector adapter or matrix.

```js
var srcBox = new F32x([ 2, 1, 9, 5 ]);
var box = _.box.from( srcBox );
console.log( box );
/* log : Float32Array(4) [ 2, 1, 9, 5 ] */
console.log( `Type : ${ _.entity.strType( box ) }` );
/* log : Type : F32x */
console.log( `srcBox === box : ${ srcBox === box }` );
/* log : srcBox === box : true */
```

Please note that `box` is an ordinary vector and not some kind of object. This is a direct manifestation of the **uncoupling of the data and functionality principle**.

### Namespaces logistics

All model's algorithms are called through namespace models, for example for the box it is `_.box.*`, for quaternion, it is `_.quat.*`, while an instance of the model is a **vector** or a **matrix**, and not an instance of some other additional class. All mathematical model's algorithms are called functionally, for example:

```js
var distance = _.plane.pointDistance( plane, point );
```

Here a `plane` is a vector, which is interpreted as an implicit plane equation, `point` is a vector, which is interpreted as a point and `distance` is a returned scalar. There is no implicit side effect.

### Components of models

All mathematical models in this module ( a vector as well as a matrix ) consist of atomic parts, on the lowest level those are scalars, which are often grouped into larger groups.

```js
var box = new F32x([ 2, 1, 9, 5 ]);
var cornerLeft = _.box.cornerLeftGet( box );
var cornerRight = _.box.cornerRightGet( box );
console.log( `cornerLeft : ${ cornerLeft }` );
/* log : cornerLeft : VectorAdapter.x2.F32x :: 2.000 1.000 */
console.log( `cornerRight : ${ cornerRight }` );
/* log : cornerRight : VectorAdapter.x2.F32x :: 9.000 5.000 */
```

An instance of the model `box` is created manually. Routine `_.box.cornerLeftGet( box )` creates a vector adapter for the left bottom point of the box and then output it to the log.

Routines for access to the components of the instances of the models return not a copy of the data but a vector adapter. A vector adapter is a kind of link to the data and it doesn't have this data.

```js
var box = new F32x([ 2, 1, 9, 5 ]);
var cornerLeft = _.box.cornerLeftGet( box );
console.log( `cornerLeft : ${ cornerLeft }` );
/* log : cornerLeft : VectorAdapter.x2.F32x :: 2.000 1.000 */
cornerLeft.assign([ 3, 4 ]);
console.log( `box : ${ box }` );
/* log : box : 3,4,9,5 */
```

A vector adapter `cornerLeft` is used to change the value of the first vertex of the box.

Routines to access to the components of the models accept vectors in any form, including vector adapters.

```js
var box = _.vad.from([ 2, 1, 9, 5 ]);
var cornerLeft = _.box.cornerLeftGet( box );
var cornerRight = _.box.cornerRightGet( box );
console.log( `cornerLeft : ${ cornerLeft }` );
/* log : cornerLeft : VectorAdapter.x2.Array :: 2.000 1.000 */
console.log( `cornerRight : ${ cornerRight }` );
/* log : cornerRight : VectorAdapter.x2.Array :: 9.000 5.000 */
```

The output is similar to the first example.

### Isomorphic

The behavior is unchanged even if model changes.

For example, an algorithm for checking that the point is on the boundary or inside is implemented by the routine `pointContains`. All models for which it's possible to implement such an algorithm have this routine with this name.

```js
var point = [ 0, 1, 2 ];
var plane = [ 0, 1, 2, -1 ];
var contains = _.plane.pointContains( plane, point );
console.log( `Plane contains point : ${ contains }` );
/* log : Plane contains point : true */
```

`true` is returned to the variable `contains`, because the point `point` is on the plane `plane`.

```js
var point = [ 0, 1 ];
var line = [ 0, 0, 0, 2 ];
var contains = _.linePointDir.pointContains( line, point );
console.log( `Line contains point : ${ contains }` );
/* log : Line contains point : true */
```

`true` is returned to the variable `contains`, because the point `point` is on the line `line`.

```js
var point = [ 0, 1 ];
var vertices =
[
  1, 0, 0,
  0, 0, 1
];
var polygon = _.convexPolygon.make( vertices, 2 );
var contains = _.convexPolygon.pointContains( polygon, point );
console.log( `Polygon contains point : ${ contains }` );
/* log : Polygon contains point : true */
```

A convex polygon `polygon` is created in 2D based on the coordinates of the vertices from the vector `vertices`. `true` is returned to the variable `contains`, because the point `point` is on the boundary of the polygon `polygon`.

### Intuitive

The routines have intuitive names. Knowledge of one routine helps to guess about other routines. The search in the module and its research can be made by combining prefixes/suffixes.

An example of using a group of routines `*Intersects` to check the cross-section of the model instance `plane` with instances of other models.

```js
var plane = [ -2, 0, 2, 0 ];
var box = [ 0, 0, 0, 2, 2, 2 ];
var intersected = _.plane.boxIntersects( plane, box );
console.log( `Plane intersects with box : ${ intersected }` );
/* log : Plane intersects with box : true */
```

`true` is returned to the variable `intersected`, because the plane `plane` crosses the box `box`.

```js
var plane = [ 1, 1, 0, 0 ];
var capsule = [ - 1, 2, 3, -1, 2, 3, 0  ];
var intersected = _.plane.capsuleIntersects( plane, capsule );
console.log( `Plane intersects with capsule : ${ intersected }` );
/* log : Plane intersects with capsule: true */
```

`true` is returned to the variable `intersected`, because the plane `plane` crosses the capsule `capsule`.

```js
var plane = [ -0.4, 1, 0, 0 ];
var frustum = _.frustum.make().copy
([
  -1,   0,  -1,   0,   0,  -1,
   0,   0,   0,   0,  -1,   1,
   1,  -1,   0,   0,   0,   0,
   0,   0,   1,  -1,   0,   0,
]);
var intersected = _.plane.frustumIntersects( plane, frustum );
console.log( `Plane intersects with frustum : ${ intersected }` );
/* log : Plane intersects with frustum : true */
```

An instance `frustum` of the model frustum is created by defining spaces of 6 faces. From the output, it is clear that the container for the data for the instance of the model is a matrix. `true` is returned to the variable `intersected`, because the plane `plane` crosses the truncated pyramid `frustum`.

```js
var plane = [ 1, 1, 0, 0 ];
var intersected = _.plane.planeIntersects( plane, plane );
console.log( `Plane intersects with plane : ${ intersected }` );
/* log : Plane intersects with plane : true */
```

`true` is returned to the variable `intersected`, because the plane `plane` crosses itself.

```js
var plane = [ 1, 1, 0, 0 ];
var line = [ 1, 0, 1, 1, 1, 1 ];
var intersected = _.plane.lineIntersects( plane, line );
console.log( `Plane intersects with line : ${ intersected }` );
/* log : Plane intersects with line : true */
```

`true` is returned to the variable `intersected`, because the plane `plane` is crossed by the line `line`.

```js
var plane = [ 1, 1, 0, 0 ];
var segment = [ -2, -2, -2, 2, 2, 2 ];
var intersected = _.plane.segmentIntersects( plane, segment );
console.log( `Plane intersects with segment : ${ intersected }` );
/* log : Plane intersects with segment : true */
```

`true` is returned to the variable `intersected`, because the plane `plane` is crossing with a segment `segment`.

```js
var plane = [ 2, 0, 2, 0 ];
var sphere = [ 0, 0, 0, 1.5 ];
var intersected = _.plane.sphereIntersects( plane, sphere );
console.log( `Plane intersects with sphere : ${ intersected }` );
/* log : Plane intersects with sphere : true */

```

`true` is returned to the variable `intersected`, because the plane `plane` is crossing with a sphere `sphere`.

```js
var plane = [ 1, - 1, 0, 0 ];
var ray = [ 0, 0, 0, 1, 1, 1 ];
var intersected = _.plane.rayIntersects( plane, ray );
console.log( `Plane intersects with ray : ${ intersected }` );
/* log : Plane intersects with ray: true */
```

`true` is returned to the variable `intersected`, because the plane `plane` is crossing with a ray `ray`.

### Convention dst=null

The routines which expect `dst` container as a first argument, can create a new instance of a model instead of rewriting the existing one. `dst` is the argument in which the writing is made if any writing is performed. `dst` is the first argument. `null` as the first argument instructs to create a new container to write the result.

```js
var point1 = [ 3, 1 ];
var point2 = [ 0, 8 ];
var box = _.box.fromPoints( null, [ point1, point2 ] );
console.log( `Box : ${ box }` );
/* log : Box : [ 0, 1, 3, 8 ] */
```

An instance `box` of the model `box` is created from the points `point1` and `point2`. From the output, it's clear that `box` contains `point1` and `point2`.

Alternatively, a container to write the result can be created manually and passed as the first argument.

```js
var point1 = [ 3, 1 ];
var point2 = [ 0, 8 ];
var dstBox = _.box.makeSingular( 2 );
console.log( `Box : ${dstBox}` );
/* log : Box : Infinity,Infinity,-Infinity,-Infinity */
_.box.fromPoints( dstBox, [ point1, point2 ] );
console.log( `Box : ${dstBox}` );
/* log : Box : 0,1,3,8 */
```

The vector `dstBox`, which will be the container for the data of the instance of the model `box` is created. `_.box.makeSingular` fills `dstBox` with infinities. Based on points `point1` and `point2` the extreme points of the box are calculated. As a result, the left bottom point has value `( 0, 1 )` and right top `( 3, 8 )`.

### Naming pattern

Please note the pattern by which the routines obtain their names.

```js
intersected = _.plane.sphereIntersects( plane, sphere );
intersected = _.plane.boxIntersects( plane, box )
euler = _.euler.fromAxisAndAngle( axisAndAngle );
```

The name of the namespace + the name of the routine repeat the sequence of expected arguments. And vice versa it can be guessed from the namespace + the name of the routine what arguments it expects.

### Higher dimension

The same interface hides the implementation of algorithms for different dimensions: 2D, 3D, 4D...

```js
var sphere2d = [ 1, 1, 5 ];
var point2d = [ 2, 2 ];
var contains = _.sphere.pointContains( sphere2d, point2d );
console.log( `Sphere contains point : ${ contains }` );
/* log : Sphere contains point : true */
```

In the 2D case, a sphere is a circle. In all dimensionalities, this model is described by the center and the radius. In 2D case, 3 scalars are enough for description.

```js
var sphere3d = [ 2, 2, 2, 5 ];
var point3d = [ 3, 3, 3 ];
var contains = _.sphere.pointContains( sphere3d, point3d );
console.log( `Sphere contains point : ${ contains }` );
/* log : Sphere contains point : true */
```

In the 3D case, a sphere is described by 4 scalars.

```js
var sphere4d = [ 3, 3, 3, 3, 5 ];
var point4d = [ 4, 4, 4, 4 ];
var contains = _.sphere.pointContains( sphere4d, point4d );
console.log( `Sphere contains point : ${ contains }` );
/* log : Sphere contains point : true */
```

3-sphere or glome is a sphere in 4D space. To describe a glome 5 scalars is enough.

Another good example is determining the distance between a point and a line.

```js
var point = [ 3, 2 ];
var line = [ -4, 4, 0 ];
var distance = _.plane.pointDistance( line, point );
console.log( `Distance from line to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from line to point : -0.71*/
```

The distance from the point `point` to the line `line` is returned in a variable `distance` which is `-0.71`. Space is 2D.

```js
var point = [ 4, 1, -3 ];
var plane = [ 1, 2, -1, 3 ];
var distance = _.plane.pointDistance( plane, point );
console.log( `Distance from 3D plane to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from 3D plane to point : -0.27 */
```

The distance from the point `point` to the plane `plane` is returned in a variable `distance` which is `-0.27`. Space is 3D.

### Alternative models

An instance of a model can be converted from one conceptual form to another, alternative.

Rotations can be set by a quaternion, Euler's angles, axis, and angle, or matrix. The straight line can be set by an implicit equation, two points, point, and a relative direction, etc. For each concept can be found several mathematical models. The module implements some of these alternatives and provides tools for converting an instance of one model into an instance of another model.

Model `linePoints` describes a straight line with two points, and a model `linePointDir` describes a straight line with a point and a relative direction. An example of conversion an instance of the model `linePoints` into an instance of the model `linePointDir` and calculation of the point of intersection of the lines set by this or that model.

```js
var linePoints1 = _.linePoints.from([ 1, 1, 3, 3 ]);
var linePoints2 = _.linePoints.from([ 2, 2, 3, 3 ]);
var point1 = _.linePoints.pairIntersectionPoint( linePoints1, linePoints2 );
console.log( `Intersection point : ${ point1 }` );
/* log : Intersection point : [ 2, 2 ] */

var linePointsDir1 = _.linePointDir.fromPoints2( linePoints1 );
var linePointsDir2 = _.linePointDir.fromPoints2( linePoints2 );
var point2 = _.linePointDir.lineIntersectionPoint( linePointsDir1, linePointsDir2 );
console.log( `Intersection point : ${ point2 }` );
/* log : Intersection point: [ 2, 2 ] */

```

Two lines `linePoints1` and `linePoints2` are created based on the coordinates of 2 points. The routine `_.linePoints.pairIntersectionPoint` calculates the coordinates of intersection and writes it into the variable `point1`. Then conversion into model `linePointDir` is performed. `linePointsDir1` and `linePointsDir2` are instances of the model `linePointDir`. `linePointsDir1` and `linePointsDir2` are created based on `linePoints1` and `linePoints2`. Similarly for the model with a point and a relative direction, the routine  `_.linePointDir.pairIntersectionPoint` calculates the coordinates of intersection and writes it into the variable `point2`. The points `point1` and `point2` have the same value `( 2, 2 )` even though they have been calculated with different mathematical models.

More about the model `linePoints` can be read [here.](../concept/Overview.md#LinePoints).
More about the model `linePointDir` can be read [here.](../concept/Overview.md#LinePointDir).

An example of converting Euler's angles into quaternions and back:

```js
var euler1 =  [ 1, 0, 0.5, 0, 1, 2 ] ;
console.log( `Euler : ${ _.entity.exportString( euler1, { precision : 2 } ) }` );
/* log : Euler : [ 1.0, 0.0, 0.50, 0.0, 1.0, 2.0 ] */

var quat = _.euler.toQuat( euler1, null );
console.log( `Quat from Euler : ${ _.entity.exportString( quat, { precision : 2 } ) }` );
/* log : Quat from Euler : [ 0.46, -0.12, 0.22, 0.85 ] */

var euler2 = _.quat.toEuler( quat, null );
console.log( `Euler from Quat : ${ _.entity.exportString( euler2, { precision : 2 } ) }` );
/* log : Euler from Quat : [ 1.0, 0.0, 0.50, 0.0, 1.0, 2.0 ] */
```

The vector `euler1` which is a container of an instance of the Euler's angles mathematical model is created. Quaternion is written into the variable `quat` which is the result of converting from Euler's angles `euler1`. The value of the Euler's angles is written into the variable `euler2` which is the result of converting the quaternion `quat`. From the output, it's clear that the transformation which is described by Euler's angles at the beginning of the example is preserved.

### Models overview

The complete list of mathematical models available in this module is [here](../concept/Overview.md).

### Summary

- Every mathematical model implements such routines as `make`, `from`, `is`.
- The data of the instance of every model is stored in a vector or a matrix.
- An algorithm and data are uncoupled.
- There is a pattern to name the model's routines.
- Most models are implemented for all dimensions, not only 2D or 3D
- If `null` is passed as an argument to the routine which performs writing the result into some container than a new container will be created and returned.
- Some conepts are implemented by alternative models, so rotation can be described by axis and angle, Euler's angles, or quaternion.

[Back to content](../README.md#Tutorials)
