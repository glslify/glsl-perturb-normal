# glsl-perturb-normal

[![stable](http://badges.github.io/stability-badges/dist/stable.svg)](http://github.com/badges/stability-badges)

[(click for demo)](http://stack.gl/glsl-perturb-normal/demo)

<!-- iframe: http://stack.gl/glsl-perturb-normal/demo -->

Perturb a normal in the fragment shader using a normal map. This can be used to add surface detail during per-pixel lighting. 

*Note:* You need to enable `GL_OES_standard_derivatives`.

```glsl
#extension GL_OES_standard_derivatives : enable

varying vec3 vNormal;
varying vec2 vUv;
varying vec3 vViewPosition;

uniform sampler2D normalMap;

#pragma glslify: perturb = require('glsl-perturb-normal')

void main() {
  //extract normal map from your texture
  vec3 normalRGB = texture2D(normalMap, vUv).rgb;

  //expand into -1.0 .. 1.0 range
  vec3 normalMap = normalRGB * 2.0 - 1.0;
  
  //get surface normal and camera-space position
  vec3 N = normalize(vNormal);
  vec3 V = normalize(vViewPosition);

  //perturb the normal
  vec3 normal = perturb(normalMap, N, V, vUv);

  //... lighting
}
```

## Usage

[![NPM](https://nodei.co/npm/glsl-perturb-normal.png)](https://nodei.co/npm/glsl-perturb-normal/)

#### `vec3 perturbed = perturb(vec3 M, vec3 N, vec3 V, vec2 texcoord)`

Perturbs a normal where:

- `M` is a unit vector from your normal map (e.g. decoded from a RGB texture)
- `N` is the normalized surface normal
- `V` is the normalized camera-space position
- `texcoord` is the UV coordinates of your mesh

This uses `GL_OES_standard_derivatives` to compute the derivatives, so it may not work on older or low-end devices. 

## Credits

The algorithm here is from Chris­t­ian Schüler's blog post [Normal Mapping Without Precomputed Tangents](http://www.thetenthplanet.de/archives/1180).

## License

MIT. See [LICENSE.md](http://github.com/stackgl/glsl-perturb-normal/blob/master/LICENSE.md) for details.
