# Математична модель

Формальний опис системи за допомогою математичних концепцій та мови.

### Box

Математична модель n-ортотопа, або інакше гіперпрямокутника або боксу.

Екземпляр моделі зберігається в будь-якій формі вектора.

```js
var box = [ 2, 1, 9, 5 ];
var point = [ 6, 8 ];
var got = _.box.pointDistance( box, point );
console.log( `Distance from box to point : ${ _.entity.exportString( got, { precision : 2 } ) }` );
/* log : Distance from box to point : 3.0 */
```

![Box](../../img/Box.png)

У 2D бокс має вигляд прямокутника. Ліва нижня і права верхня точки цього прямокутника використовуються для опису цієї математичної моделі. Для опису боксу у 2D випадку достатньо 4-х скалярів.

### Segment

Математична модель відрізка.

Екземпляр моделі зберігається в будь-якій формі вектора.

```js
var segment = [ 9, 1, 2, 4 ];
var point = [ 3, 5 ];
var distance = _.segment.pointDistance( segment, point );
console.log( `Distance from segment to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from segment to point : 1.3 */
```

![Segment](../../img/Segment.png)

Задається двома точками: початком `( 9, 1 )` та кінцем відрізка `( 2, 4 )`. Для опису відрізка у 2D достатньо 4 скалярів.

### Capsule

Математична модель капсули.

Капсула це відрізок, котрий має товщину. Капсула як і сегмент описується двома точками, що позначають початок і кінець, а також має товщину та заокруглення на кінцях. Екземпляр моделі зберігається в будь-якій формі вектора.

```js
var capsule = [ 9, 1, 2, 4, 0.5 ];
var point = [ 3, 5 ];
var distance = _.capsule.pointDistance( capsule, point );
console.log( `Distance from capsule to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from capsule to point : 0.81 */
```

![Capsule](../../img/Capsule.png)

Капсула в прикладі починається в точці `( 9, 1 )`, закінчується в точці `( 2, 4 )` і має радіус `0.5`. Для опису капсули у 2D достатньо 5 скалярів.

### Sphere

Математична модель гіперсфери.

У 2D це коло, в 3D це звичайна сфера, у 4D це глом. Описується центром та радіусом. Екземпляр моделі зберігається в будь-якій формі вектора.

```js
var sphere = [ 2, 1, 3 ];
var point = [ 5, 6 ];
var distance = _.sphere.pointDistance( sphere, point );
console.log( `Distance from sphere to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from sphere to point : 2.8 */
```

![Sphere](../../img/Sphere.png)

У 2D сфера перетворюється в коло.

Центр кола з прикладу в точці `( 2, 1 )` а його радіус `3`. Для опису сфери у 2D достатньо 3-х скалярів.

### Ray

Математична модель променя.

Перша точка позначає початок променя, друга - задає напрям. Екземпляр моделі зберігається в будь-якій формі вектора.

```js
var ray = [ 2, 1, 6, 3 ];
var point = [ 2, 3 ];
var distance = _.ray.pointDistance( ray, point );
console.log( `Distance from ray to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from ray to point : 1.8 */
```

![Ray](../../img/Ray.png)

Промінь `ray` з прикладу починається в точці `( 2, 1 )` та прямує в нескінченність через точку `( 6, 3 )`. Для опису променя у 2D достатньо 4-х скалярів.

### LinePoints

Математична модель прямої за двома точками.

Описує пряму двома точками, через які вона проходить. Екземпляр моделі зберігається в будь-якій формі вектора.

```js
var line = [ 2, 1, 4, 2 ];
var point = [ 2, 3 ];
var distance = _.linePoints.pointDistance( line, point );
console.log( `Distance from line to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from line to point : 1.8 */
```

![LinePoints](../../img/LinePoints.png)

Перші два скаляри вектора `line` є першою точкою, інші два другою точкою. За цими двома точками будується пряма. Для опису прямої у 2D достатньо 4-х скалярів.

### LinePointDir

Математична модель прямої за точкою та відносним напрямком.

Друга точка задається відносно першої. Екземпляр моделі зберігається в будь-якій формі вектора.

```js
var line = [ 2, 1, 2, 1 ];
var point = [ 2, 3 ];
var distance = _.linePointDir.pointDistance( line, point );
console.log( `Distance from line by point and direction to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from line by point and direction to point : 1.8 */
```

![LinePointDir](../../img/LinePointDir1.png)

Перші два скаляри вектора `line` є першою точкою, інші два описують другу точку. Проте в випадку моделі `lineDir` координати другої точки задані відносно координат першої. За цими двома точками будується пряма. Для опису прямої у 2D достатньо 4-х скалярів.

### LinePointCentered

Математична модель прямої, котра проходить через початок координат і задану точку.

Екземпляр моделі зберігається в будь-якій формі вектора.

```js
var line = [ 4, 2 ];
var point = [ 2, 3 ];
var distance = _.linePointCentered.pointDistanceCentered2D( line, point );
console.log( `Distance from centered line to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from centered line to point : 1.8 */
```

![LinePointCentered](../../img/LinePointCentered.png)

Два скаляри вектора `line` є точкою через яку проходить пряма. Друга точка завжди початок координат. За цими двома точками будується пряма. Для опису прямої яка проходить через початок координат у 2D достатньо 2-х скалярів.

### Plane ( implicit )

Математична модель гіперплощини заданої неявним рівнянням.

Ця математична модель завжди ділитиме простір в якому вона існує на дві половини. У 2D це буде пряма, що задовольняє рівняння `w + a*x + b*y = 0`, в 3D це буде площина, що задовольняє рівняння `w + a*x + b*y + c*z = 0`. Екземпляр моделі зберігається в будь-якій формі вектора.

```js
var line = [ -2, -1, 2 ];
var point = [ 2, 3 ];
var distance = _.plane.pointDistance( line, point );
console.log( `Distance from straight to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from straight to point : 0.89 */
```

![LineImplicit](../../img/LineImplicit.png)

Пряма `line` задовольняє рівняння `-2 - 1*x + 2*y = 0` проходить через точки `( -2, 0 )` та `( 0, +1 )`, тобто перетинає вісь `x` в `-2` та вісь `y` в `+1`. Для опису прямої через неявне рівняння достатньо 3-х скалярів.

```js
var plane = [ 0, -2, -1, 2 ];
var point = [ 2, 3, -3 ];
var distance = _.plane.pointDistance( plane, point );
console.log( `Distance from 3D plane to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from 3D plane to point : 0.89 */
```

![Plane](../../img/Plane.png)

Так само, як у випадку із прямої, площина `plane` задовольняє рівняння `-2 - 1*x + 2*y + 0*z = 0` проходить через точки `( -2, 0, z )` та `( 0, +1, z )` тобто проходить через всі точки де `x = -2` та `y = 0`, а також через всі точки, де `x = 0` та `y = 1`. Для опису площини через неявне рівняння достатньо 4-х скалярів.

### Triangle

Математична модель трикутника.

Задається трьома вершинами. Екземпляр моделі зберігається в будь-якій формі вектора.

```js
var triangle = [ 2, 1, 9, 2, 5, 6 ];
var point = [ 3, 6 ]
var distance = _.triangle.pointDistance( triangle, point );
console.log( `Distance from triangle to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from triangle to point : 1.7 */
console.log( `Type : ${ _.entity.strType( triangle ) }` );
/* log : Type : Array */
```

![Triangle](../../img/Triangle.png)

Вершини трикутника `triangle` йдуть послідовно по 2-ва скаляри на вершину. Для опису трикутника в 2D достатньо 6-и скалярів.

### ConvexPolygon

Математична модель випуклого полігона.

Випуклий полігон це простий полігон ( не перетинає сам себе ) в котрому жоден відрізок між двома вершинами на межі полігона не виходить за межі полігона. У випуклому полігоні всі внутрішні кути є меншими чи рівними 180 градусів. В цій моделі полігона він задається перерахуванням його вершин проти годинникової стрілки. Як контейнер для даних екземпляра моделі випуклого полігона використовується матриця.

```js
var vertices =
[
  2,  6,  9,  5,
  1, -1,  2,  6,
]
var polygon = _.convexPolygon.make( vertices, 2 );
var point = [ 3, 6 ];
var distance = _.convexPolygon.pointDistance( polygon, point );
console.log( `Distance from convex polygon to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from convex polygon to point : 1.7 */
console.log( `Type : ${ _.entity.strType( polygon ) }` );
/* log : Type : wMatrix */
```

![ConvexPolygon](../../img/ConvexPolygon.png)

Колонки матриці `polygon` зберігають вершини полігона. Кількість рядків матриці `polygon` рівна розмірності математичної моделі `2`, а кількість колонок рівна кількості вершин полігона `4`. 4-ри вершини полігона поєднуються послідовно гранями та утворюється випуклий полігон. В загальному випадку полігон може мати будь-яку кількість вершин, в просторі будь-якої розмірності. Для опису випуклого полігона із 4-ма вершинами у 2D достатньо 8-и скалярів.

### ConcavePolygon

Математична модель впуклого полігона.

Впуклий полігон той в котрому відрізки між двома вершинами на межі полігона можуть виходить за межі полігона. У впуклому полігоні внутрішні кути можуть бути більше ніж 180 градусів. Впуклий полігон складніша математична модель ніж випуклий, адже, впуклий завжди можливо розбити на сукупність випуклих. В цій моделі полігона він задається перерахуванням його вершинами проти годинникової стрілки. Як контейнер для даних екземпляра моделі випуклого полігона використовується матриця.

```js
var vertices =
[
  2,  6,  9,  5,
  1,  3,  2,  6
]
var polygon = _.concavePolygon.make( vertices, 2 );
var point = [ 3, 6 ]
var distance = _.concavePolygon.pointDistance( polygon, point );
console.log( `Distance from concave polygon to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from concave polygon to point : 1.7 */
console.log( `Type : ${ _.entity.strType( polygon ) }` );
/* log : Type : wMatrix */
```

![ConcavePolygon](../../img/ConcavePolygon.png)

Колонки матриці `polygon` зберігають вершини полігона. Кількість рядків матриці `polygon` рівна розмірності математичної моделі `2`, а кількість колонок рівна кількості вершин полігона `4`. 4-ри вершини полігона поєднуються послідовно гранями та утворюється полігон. В загальному випадку полігон може мати будь-яку кількість вершин, в просторі будь-якої розмірності. Для опису впуклого полігона із 4-ма вершинами у 2D достатньо 8-и скалярів.

### Frustum

Математична модель фрустума - обрізаної піраміди.

Модель обрізаної піраміди часто застосовується в 3D графіці для моделювання видимої частини простору перспективною камери. Модель задається 6-ма гранями. Кожна грань, задана неявним рівнянням площини. Екземпляр моделі зберігає свої параметри в матриці розмірності 4x6. Рівняння площини зберігаються в колонках такої матриці.

```js
var frustum = _.frustum.make();
var matrix = _.Matrix.FormPerspective( 90, [ 20, 70 ], [ 10, 50 ] );
_.frustum.fromMatrixHomogenous( frustum, matrix );
console.log( `Frustum from perspective matrix : \n${ frustum }` );
var point = [ 1, 1, 2 ];
/* log :
Matrix.F32x.4x6 ::
  -1.000 1.000  0.000  0.000  0.000  0.000
  0.000  0.000  0.286  -0.286 0.000  0.000
  -1.000 -1.000 -1.000 -1.000 0.500  -2.500
  0.000  0.000  0.000  0.000  25.000 -25.000
*/
var distance = _.frustum.pointDistance( frustum, point );
console.log( `Distance from frustum to point : ${ _.entity.exportString( distance, { precision : 2 } ) }` );
/* log : Distance from frustum to point : 37 */
console.log( `Type of frustum : ${ _.entity.strType( frustum ) }` );
/* log : Type of frustum : wMatrix */
```

![Frustum](../../img/Frustum.png)

Параметри неявних рівнянь 6-ти граней моделі обрізаної піраміди вираховуються із матриці перспективної трансформації. Для опису моделі обрізаної піраміди потрібно 24-ри скаляри.

### AxisAndAngle

Обертання об'єкта за віссю обертання і кутом повороту.

Один із можливих способів задати обертання. Екземпляр моделі зберігається в будь-якій формі вектора.

```js
var axisAndAngle = [ Math.PI / 4, 1, 0, 0 ];
var euler = _.euler.fromAxisAndAngle2( null, axisAndAngle );
console.log( `AxisAndAngle to Euler : ${ _.entity.exportString( euler, { precision : 2 } ) }` )
/* log : AxisAndAngle to Euler : [ 0.79, 0.0, -0.0, 0.0, 1.0, 2.0 ] */
```

![AxisAndAngle](../../img/AxisAndAngle.png)

Кутом обертання `axisAndAngle` є 45 градусів, а вісь `( 1, 0, 0 )`, що збігається з віссю `x`. Для опису моделі обертання за віссю і кутом обертання достатньо 4-х скалярів.

### Euler

Обертання об'єкта за кутами Ейлера.

Один із можливих способів задати обертання. Задається трьома кутами повороту навколо 3-х осей та 3-ма осями ( навколо яких здійнсюється обертання ). Перших 3-ри скаляри вектора є кутами повороту, а останні 3-ри скаляра несуть інформацію про те, навколо яких осей потрібно здійснювати поворот. Всього в векторі 6-ть скалярів. В 3D існує 12 можливих комбінацій послідовності осей навколо яких можливо здійснювати почергово поворти:

- x-y-z
- x-z-y
- y-x-z
- y-z-x
- z-x-y
- z-y-x
- x-y-x
- x-z-x
- y-x-y
- y-z-y
- z-x-z
- z-y-z

Деякі комбінації значень кутів повороту ( йдеться про перших 3-ри скаляра ) є проблемними. Може виникати [гімбал лок](https://en.wikipedia.org/wiki/Gimbal_lock), заблокувавши можливість обертання в 3-ій розмірності.

```js
var euler = [ Math.PI/4, 0, 0, 0, 1, 2 ];
var quat = _.euler.toQuat( euler, null );
console.log( `Quat from Euler : ${ _.entity.exportString( quat, { precision : 2 } ) }` );
/* log : Quat from Euler : [ 0.38, 0.0, 0.0, 0.92 ] */
```

![Euler](../../img/Euler.png)

Кути Ейлера `euler` розвертають об'єкт на `45` градусів навколо осі `x`, на `0` градусів навколо осі `y`, та на `0` градусів навколо осі `z`. Зверніть увагу, що перші три скаляри вектора `[ Math.PI/4, 0, 0 ]` є кутами повороту, а останні 3 `[ 0, 1, 2 ]` є інформацією про те навколо котрих осей потрібно здійснювати ці повороти. `[ 0, 1, 2 ]` означає `x-y-z`. Для опису моделі обертання за кутами Ейлера потрібно 6-ть скалярів.

### Quat

Обертання об'єкта за допомогою кватерніона.

Один із можливих способів задати обертання. Кватерніон це розширення концепції комплексних чисел в 3D просторі. Задається 4-ма числами в яких закодована вісь обертання на поворот. Довжина валідного кватерніона завжди 1. На відміну від кутів Ейлера, кватерніон не страждає від проблеми [гімбал лока](https://en.wikipedia.org/wiki/Gimbal_lock).

```js
var quat = [ 0.38, 0.0, 0.0, 0.92 ];
var euler = _.quat.toEuler( quat, null );
console.log( `Quat from Euler : ${ _.entity.exportString( euler, { precision : 2 } ) }` );
/* log : Euler from Quat : [ 0.78, 0.0, -0.0, 0.0, 1.0, 2.0 ] */
```

![Quat](../../img/Quat.png)

Кватерніон `quat` розвертає об'єкт на `45` градусів навколо осі `x`. Для опису моделі кватерніон достатньо 4-х скалярів.
