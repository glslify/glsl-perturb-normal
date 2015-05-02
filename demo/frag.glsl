#extension GL_OES_standard_derivatives : enable

varying vec3 vNormal;
varying vec2 vUv;
varying vec3 vViewPosition;

uniform sampler2D normalMap;
uniform vec2 uvRepeat;
const float normalScale = 0.85;

#pragma glslify: perturb = require('../')

void main() {
  //extract normal map from your texture
  vec3 normalRGB = texture2D(normalMap, vUv * uvRepeat).rgb;
  vec3 normalMap = normalRGB * 2.0 - 1.0;
  //you can adjust its strength like so...
  normalMap.xy *= normalScale;

  vec3 N = normalize(vNormal);
  vec3 V = normalize(vViewPosition);
  vec3 normal = perturb(normalMap, N, V, vUv);

  gl_FragColor.rgb = normal;
  gl_FragColor.a = 1.0;
}