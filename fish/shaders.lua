return {
  water = [[
    extern float time;
    extern float cutoff = 64.0;
    extern vec2 turbulence = vec2(1.0);
    extern vec2 size;
    extern vec4 tint = vec4(0.5, 0.7, 0.9, 0.2);
    extern Image reflection;
    varying vec2 hs;

    #ifdef VERTEX
    vec4 position(mat4 transform_projection, vec4 vertex_position) {
        hs = love_ScreenSize.xy/2.0;
        return transform_projection * vertex_position;
    }
    #endif

    #ifdef PIXEL
    float rand(vec2 co) {
        return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
    }

    vec4 effect(vec4 color, Image texture, vec2 tc, vec2 screen_coords) {
        vec2 pc = tc*size;
        vec2 offset = turbulence/size;
        offset.x *= 1.0*cos(80.0*time+pc.y/4.0);
        offset.y *= 2.0*sin(40.0*time+pc.x/40.0);
        if (pc.y < (offset*size+turbulence*2.0).y) {
            discard;
        }

        // diffraction
        vec4 out_pixel = Texel(texture, tc+offset);
        out_pixel.rgb = tint.rgb;
        out_pixel.rgb = mix(out_pixel.rgb, tint.rgb, tint.a);
        out_pixel.a = 1.0;
        return out_pixel * color;
    }
    #endif
  ]],

  stencil = [[
    vec4 effect(vec4 color, Image texture, vec2 tc, vec2 screen_coords) {
        float alpha = Texel(texture, tc).a;
        if (alpha == 0.0) {
            discard;
        }
        return vec4(vec3(1.0), alpha);
    }
  ]]
}
