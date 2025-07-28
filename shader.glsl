void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // Normalize fragment coordinates
    vec2 uv = (2.0 * fragCoord - iResolution.xy) / min(iResolution.x, iResolution.y);

    // Time scaling
    float timeScale = 1.0;
    float scaledTime = iTime / 12.0 * timeScale;

    // Grayscale base
    float baseGray = 1.0;

    // More iterations for more curves
    float iteration = 30.0;

    // Wavy distortions with adjusted frequency and strength
    for(float i = 1.0; i < iteration; i++) {
        float freqX = 4.0; // Horizontal frequency
        float freqY = 3.0; // Increased vertical frequency
        float amp = 0.5;   // Adjusted amplitude to avoid excess

        uv.x += amp / i * cos(i * freqX * uv.y + scaledTime);
        uv.y += amp / i * cos(i * freqY * uv.x + scaledTime);
    }

    // Inverted brightness
    float brightness = 1.0 - abs(sin(scaledTime - uv.x - uv.y));

    // Final grayscale color
    fragColor = vec4(vec3(baseGray * brightness), 1.0);
}
