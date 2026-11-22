# Suminagashi Shader

![GLSL](https://img.shields.io/badge/GLSL-shader-5586A4?logo=opengl&logoColor=white)
![WebGL 2](https://img.shields.io/badge/WebGL-2-990000?logo=webgl&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-green)

A procedural GLSL fragment shader that recreates **Suminagashi** (墨流し), the Japanese art
of marbling ink on water. Minimal and monochrome, with animated wavy lines that mimic ink
drifting on the surface.

![Frame of the shader at t = 30 s](assets/preview.jpg)

**Live demo:** [Shadertoy](https://www.shadertoy.com/view/tXdXWH) · or run it locally with
the standalone [`index.html`](index.html) (see below).

## How it works

All the work happens in [`shader.glsl`](shader.glsl), a single `mainImage` function in the
Shadertoy format:

- **Harmonic domain warping:** 30 iterations of `cos` offsets feed `uv.x` into `uv.y` and
  back again. Each pass adds a finer, weaker ripple (amplitude `0.5 / i`), which produces the
  nested, ink-like curves.
- **Animation:** `iTime` shifts the phase of every ripple, so the pattern flows slowly
  instead of jumping.
- **Shading:** brightness is `1 - |sin(t - uv.x - uv.y)|`, giving soft grayscale bands with no
  color, only black, white and gray.

```glsl
for (float i = 1.0; i < 30.0; i++) {
    uv.x += 0.5 / i * cos(i * 4.0 * uv.y + t);
    uv.y += 0.5 / i * cos(i * 3.0 * uv.x + t);
}
float brightness = 1.0 - abs(sin(t - uv.x - uv.y));
```

## Running locally

`index.html` is a ~90-line WebGL 2 runner that loads `shader.glsl` unchanged and supplies
the `iResolution` and `iTime` uniforms, so no Shadertoy account is needed:

```bash
python -m http.server 8000   # then open http://localhost:8000
```

It also works as-is on GitHub Pages. To embed the Shadertoy version in another page, use the
iframe snippet in [`assets/shadertoy-embed.html`](assets/shadertoy-embed.html).

## Ideas for next steps

- Color palettes (sumi ink over colored paper).
- Interactive controls for amplitude, frequency and iteration count.
- Mouse-driven distortion, like dragging a brush through the water.

## License

[MIT](LICENSE)
