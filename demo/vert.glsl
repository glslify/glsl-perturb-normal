varying vec3 vNormal;
varying vec2 vUv;
varying vec3 vViewPosition;

void main() {
  vec4 pos = vec4(position, 1.0);
  vec4 viewPos = modelViewMatrix * pos;
  gl_Position = projectionMatrix * viewPos;

  vViewPosition = -viewPos.xyz;
  vUv = uv;
  vNormal = normalize(normalMatrix * normal);
}