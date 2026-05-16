/*
 * Copyright (c) 2026 James Koenig
 *
 * SPDX-License-Identifier: BSD-2-Clause
 */

const pi = radians(180);

/*
 * NB. most uses of this seem to want to produce a value [0,1]
 *     i.e. vert_shifts +/- amps have seemingly been within that boundary
 *
 * Note2. when `ordPhases = vec4(0)` this is equivalent to a single iteration
 *        of a (per rgba channel) fourier series where `sin` has coefficient
 *        of `amps` while cos has a zero coefficient.
 *        (the relation would probably be clearer if I kept sin)
 */
vec4 palette(float t, mat4 coeffs) {
  const mat4 trans       = transpose(coeffs);
  const vec4 vert_shifts = trans[0],  //vertical shifts
             amps        = trans[1],  //amplitudes
             ordFreqs    = trans[2],  //ordinary frequencies \in [0,1]
             ordPhases   = trans[3];  //ordinary phases      \in [0,1]

  return vert_shifts + amps*sin( 2*pi*(ordFreqs*t + ordPhases) );
}

// e.g.
vec4 a_palette(float t) {
  // each coefficient is in the form
  //                 vec4(shift, amp,    freq, phase)
  vec4 redCoeffs   = vec4(  0.5, 0.5, (1.0/2),     0),
       blueCoeffs  = vec4(  0.5, 0.5, (1.0/3),     0),
       greenCoeffs = vec4(  0.5, 0.5, (1.0/5),     0),
       alphaCoeffs = vec4(  1.0, 0.0,     0.0,     0);

  return palette(t, mat4(redCoeffs, blueCoeffs, greenCoeffs, alphaCoeffs) );
}
