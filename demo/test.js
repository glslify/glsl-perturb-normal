var THREE = require('three')
var createViewer = require('three-orbit-viewer')(THREE)
var glslify = require('glslify')

var app = createViewer({
    clearColor: 0x000000,
    clearAlpha: 1.0,
    fov: 65,
    position: new THREE.Vector3(1, 1, -2)
})

var normalMap = THREE.ImageUtils.loadTexture('normal.jpg', undefined, ready)
normalMap.wrapS = normalMap.wrapT = THREE.RepeatWrapping

var geo = new THREE.TorusGeometry(0.85, 0.3, 16, 100)
var mat = new THREE.ShaderMaterial({ 
  vertexShader: glslify('./vert.glsl'),
  fragmentShader: glslify('./frag.glsl'),
  shading: THREE.SmoothShading,
  uniforms: {
    normalMap: { type: 't', value: normalMap },
    uvRepeat: { type: 'v2', value: new THREE.Vector2(5, 1) }
  },
  defines: {
    USE_MAP: ''
  }
})
var box = new THREE.Mesh(geo, mat)

//once texture is loaded...
function ready() {
  app.scene.add(box)
}