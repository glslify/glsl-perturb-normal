#pragma glslify: cotangent = require('./cotangent-frame')

vec3 perturb(vec3 map, vec3 N, vec3 V, vec2 texcoord) {
  mat3 TBN = cotangent(N, -V, texcoord);
  return normalize(TBN * map);
}

#pragma glslify: export(perturb)