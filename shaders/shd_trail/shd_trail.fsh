//
// fs_trail.fsh
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_time;         // passe current_time / 1000.0 do GML
uniform vec2  u_texel;        // 1.0 / surface_width, 1.0 / surface_height
uniform float u_glow_strength;// ex: 1.8
uniform float u_distortion;   // ex: 0.002

void main() {
    // leve distorção tipo "energia" — desloca o UV com seno baseado no tempo
    vec2 uv = v_vTexcoord;
    uv.x += sin(uv.y * 40.0 + u_time * 3.0) * u_distortion;
    uv.y += cos(uv.x * 40.0 + u_time * 3.0) * u_distortion;

    // sample central
    vec4 base = texture2D(gm_BaseTexture, uv);

    // glow real: soma 8 amostras ao redor (blur barato tipo bloom)
    vec4 glow = vec4(0.0);
    float total_weight = 0.0;
    for (int x = -1; x <= 1; x++) {
        for (int y = -1; y <= 1; y++) {
            vec2 offset = vec2(float(x), float(y)) * u_texel * 2.0;
            float weight = 1.0 / (1.0 + float(x*x + y*y));
            glow += texture2D(gm_BaseTexture, uv + offset) * weight;
            total_weight += weight;
        }
    }
    glow /= total_weight;

    // combina base + glow amplificado
    vec4 result = base + glow * u_glow_strength * base.a;

    // gradiente de cor dinâmico baseado no alpha (mais forte = mais branco/quente)
    vec3 hot_color = vec3(1.0, 1.0, 0.6);   // quase branco-amarelo (núcleo)
    vec3 cold_color = vec3(1.0, 0.15, 0.0); // vermelho (borda)
    vec3 tinted = mix(cold_color, hot_color, clamp(result.a * 1.5, 0.0, 1.0));

    result.rgb = tinted * result.a;

    gl_FragColor = result;
}
