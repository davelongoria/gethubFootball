// shdPaletteTex.fsh  – corrected
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// REMOVE this →  uniform sampler2D gm_BaseTexture;
uniform sampler2D u_pal;        // our palette texture (stage 1)

void main()
{
    float idx  = texture2D(gm_BaseTexture, v_vTexcoord).r;  // built-in sampler
    vec4  palC = texture2D(u_pal, vec2(idx, 0.5));          // lookup
    gl_FragColor = vec4(palC.rgb,
                        texture2D(gm_BaseTexture, v_vTexcoord).a)
                 * v_vColour;
}
