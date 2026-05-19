#version 420 core

layout(location=0) out vec4 out_color;

void main(void) {
  // note this produces, in mathematical terms, a 3x2 matrix.
  const mat2x3 mA =
    mat2x3(
       1, 2, 3, //first column
       4, 5, 6  //second column
    );

  /*
   * n.b. every 3 numbers is actually technically a column for a 3x3 matrix
   *      so in the below three-at-a-time entry the matrix is actually
   *      a transpose of its actual operations.
   *      ie. the third row adds the 2nd and 3rd elements of a 3-row
   *          column vector.
   */
  const mat3 mB =
    mat3(
       -1, 1, 0,
        0,-1, 1,
        1, 0, 1
    );

  /*
   * per the note on the 2x3 matrix above, a mat3's rows match the number
   *  of rows in a mat2x3 (read mat2x3 as two 3-length columns).
   */
  mat2x3 mC = mB*mA;

  mat2x3 mD =
    mat2x3(
       2,-1, 5,
       2,-1,11
    );

  if(mC == mD) {
    // we're right and the multiplication occured correctly
    out_color = vec4(0.0,0.25,0.25,1.0);
  } else {
    // we're wrong and the multiplication occurred incorrectly
    out_color = vec4(0.5,0.00,0.00,1.0);
  }
}
