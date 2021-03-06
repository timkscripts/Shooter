attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;



void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    //in_Colour = vec4(1.0, 1.0, 1.0, 1.0);
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~uniform float vTime;
uniform float vSwitch;
uniform float yOffset;


varying vec2 v_vTexcoord;
uniform vec3 vRes;
varying vec4 v_vColour;



void main(){
    vec2 uv = v_vTexcoord.xy;
    //uv.x = 0.1;
    //uv.y += 50.0;
   // v_vColour = vec4(0.0, 1.0, 0.0, 1.0);
    float cor = (vRes.x / vRes.y);
    float ra = 1.0 + (cos(vTime/60.0))/10.0;
    float rs = 1.0 - (sin(vTime/30.0))/10.0;
    vec2 p =  v_vTexcoord.xy * 1.5;
    p.x *= cor;
    float a = atan(p.x,p.y);
    float r = length(p) * ra;
    
   
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, uv );
    gl_FragColor.r = sin(uv.x*10.0) / vTime;
float verColor = (uv.x - (vTime / 120.0)) * 3.0;
    verColor = mod(verColor, 3.0);
    vec3 hc = vec3(0.25, 0.25, 0.25);
    
    if (verColor < 1.0) {
        hc.r += 1.0 - verColor;
        hc.g += verColor;
   }
    else if (verColor < 2.0) {
        verColor -= 1.0;
        hc.g += 1.0 - verColor;
        hc.b += verColor;
   }
    else {
        verColor -= 2.0;
        hc.b += 1.0 - verColor;
        hc.r += verColor;
   }
   
   //grid lines
   float bv = 1.0;
   if ((mod(uv.y * 110.0, 1.0) > 0.70 || mod(uv.x * 110.0 * cor, 1.0) > 0.70) && vSwitch != 5.0) {
        bv = 1.15 * ra;
   }

   //line
   uv = (2.0 * uv) - 1.0 / ra;
   float bw = abs(1.0 / (30.0 * uv.y)) * ra;
   vec3 hb = vec3(bw);
    
    gl_FragColor.rgb = vec3(( hc));
   // gl_FragColor.r = 1.0;
   // gl_FragColor.rgb = vec3((0.25 * uv.x) ,(1.0 / uv.x), (1.0 / uv.x));
    //gl_FragColor.rgb = vec3(((bv * hb) * hc));
    }
