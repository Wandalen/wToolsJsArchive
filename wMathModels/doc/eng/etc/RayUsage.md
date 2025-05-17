
# Ray.s Usage [![Ray methods](https://travis-ci.org/Wandalen/wMathModels.svg?branch=master)](https://github.com/Wandalen/wMathModels/blob/master/proto/wtools/amath/geometric/Ray.s)

### Definition:
  Ray.s contains a collection of functions to work with the geometrical concept of a ray ( a line starting at an origin point that extends infinitely in a given direction).

  A ray element is defined by an origin [ x0, x1, ..., xn ], and a direction [ d0, d1, ..., dn ] ( where n is the dimension of the vectorial space ).
  Rays are stored as flat vectors according to the following convention: ray = [ x0, x1, ..., xn, d0, d1, ..., dn ];

### Functions:
  - `make( dim )`: Returns a ray of dimension dim ( default dim = 3 ).
  - `makeZero( dim )`: Returns a ray of dimension dim ( default dim = 3 ) full of zeros.
  - `makeSingular( dim )`: Returns a nil ray of dimension dim ( default dim = 3 ).
  - `zero( ray )`: Transforms the input ray to a zero ray.
  - `nil( ray )`: Transforms the input ray to a nil ray.

  - `from( ray )`: Returns a ray out of the input object.
  - `_from( ray )`: Returns a ray vector out of the input object.
  - `fromPair( pair )`: Creates a ray out of two points ( first point is used as origin ).
      @Example
      // returns [ 0, 1, 2, 0, 0, 3 ];
      // fromPair( [ 0, 1, 2 ], [ 0, 1, 5 ] );

  - `is( ray )`: Checks if the input is a ray.      
  - `dimGet( ray )`: Returns the input ray´s dimension.
  - `originGet( ray )` Returs the input ray´s origin.
  - `directionGet( ray )`: Returns the input ray´s direction.

  - `rayAt( ray, factor )`: Gets a point in a ray with a factor. Factor can not be negative.
      @Example
      // returns [ 0, 2, 4 ];
      // rayAt( [ 0, 1, 2, 0, 1, 2 ], 1 )

  - `rayParallel( src1Ray, src2Ray, accuracySqr )`: Checks if two rays are parallel.
      @Example
      // returns true
      // rayParallel( [ 0, 1, 3, 4 ], [ 5, 5, 3, 4 ] );

  - `rayIntersectionFactors( src1Ray, src2Ray )`: Get the factors of two rays intersecting in a point.
  If the rays don´t intersect, it returns 0.
      @Example
      // returns [ 4, 1 ]
      // rayParallel( [ -4, 0, 1, 0 ], [ 0, -2, 0, 2 ] );
  - `rayIntersectionPoints( src1Ray, src2Ray )`: Return the intersection points of the two rays.
      @Example
      // returns [ [ 0, 0 ], [ 0, 0 ] ]
      // rayParallel( [ -4, 0, 1, 0 ], [ 0, -2, 0, 2 ] );
  - `rayIntersectionPoint( src1Ray, src2Ray )`: Return the intersection point of the two rays.
      @Example
      // returns [ 0, 0 ]
      // rayParallel( [ -4, 0, 1, 0 ], [ 0, -2, 0, 2 ] );
  - `rayIntersectionPointAccurate( src1Ray, src2Ray )`: Return the mean of rayIntersectionPoints.


### Try out  
```
npm install
node sample/SampleRay.s
```
