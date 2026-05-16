/*
 * Copyright (c) 2026 James Koenig
 *
 * SPDX-License-Identifier: BSD-2-Clause
 */
const float pi  = radians(180);
const float tpi = radians(360);

/* The period of the color space is assumed to be [0,1]
 *  as such consts is the integral of the color space (per channel), while
 *  each cosine and sign coefficient (cosEffs[i],sinEffs[i], respectively)
 *  is the integral of the desired color space times cosine and sine of
 *  given frequency multiples, respectively.  LaTeX:
 *  \text{cosEff}_n = 2\cdot\int_0^1 colors(x)\cdot cos(2\pi\cdot n\cdot x)\,dx
 *  for cosEff[n] and:
 *  \text{sinEff}_n = 2\cdot\int_0^1 colors(x)\cdot sin(2\pi\cdot n\cdot x)\,dx
 *  for sinEff[n].
 */
vec4 fourier2Palette(in float t, in vec4 consts,
                     in vec4 cosEffs[2], in vec4 sinEffs[2] ) {
  int idx;
  vec4 sum = consts;

  for(idx = 0; idx < 2; idx++) {
    sum += cosOff[idx]*cos(tpi*(idx+1)*t)
           + sinOff[idx]*sin(tpi*(idx+1)*t);
  }
  return sum
}

#define FR_N 5
vec4 fourierNPalette(in float t, in vec4 consts,
                     in vec4 cosEffs[FR_N], in vec4 sinEffs[FR_N] ) {
  int idx;
  vec4 sum = consts;
  for(idx = 0; idx < FR_N; idx++) {
    sum += cosEffs[idx]*cos(tpi*(idx+1)*t)
           + sinEffs[idx]*sin(tpi*(idx+1)*t);
  }
  return sum;
}

// TODO: make a non glsl tool that calculates the series coefficients
//       for a desired color spectrum.
